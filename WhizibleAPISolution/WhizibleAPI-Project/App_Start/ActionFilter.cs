using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Filters;
using System.Web.Http.Controllers;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Reflection;
using System.Configuration;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;

namespace WhizibleAPI.App_Start
{
    public class ValidateHeaders : ActionFilterAttribute
    {
        // Added by DipalI v On 4th sep 2026 - Purpose: opt-in slim/hash Params for large list saves (e.g. SaveTasks); default false keeps existing full Params compare for all other APIs
        public bool AllowHashParams { get; set; } = false;

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            string TokenAuthenticate = ConfigurationManager.AppSettings["TokenAuthenticate"];
            if (TokenAuthenticate == "true")
            {
                if (actionContext.Request.Headers.Count() > 0)
                {
                    if (actionContext.ActionArguments.Count > 0)
                    {
                        foreach (var item in actionContext.ActionArguments)
                        {
                            try
                            {
                                JObject o = null;
                                JValue j = null;
                                try
                                {
                                    o = JsonConvert.DeserializeObject<JObject>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key.ToLower() == "params").Value.FirstOrDefault())));
                                   // o = JsonConvert.DeserializeObject<JObject>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key == "Params").Value)));
                                }
                                catch (Exception ex)
                                {
                                    j = JsonConvert.DeserializeObject<JValue>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key.ToLower() == "params").Value.FirstOrDefault())));
                                    //j = JsonConvert.DeserializeObject<JValue>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key == "Params").Value)));
                                }
                                if (o != null)
                                {
                                    // Added by DipalI v On 4th sep 2026 - Purpose: when AllowHashParams + ValidationMode=Hash, validate fingerprint only (skip full array in Params header)
                                    if (AllowHashParams && TryValidateSlimHashParams(o, item.Value))
                                    {
                                        continue;
                                    }
                                    if (item.Value == null && o.Children().ToList().Count > 0)
                                    {
                                        throw new Exception("Something has went wrong");
                                    }
                                    var propList = GetProperties(item.Value);
                                    foreach (var jToken in o.Children().ToList())
                                    {
                                        if (propList.Length > 0)
                                        {
                                            foreach (var propInfo in propList)
                                            {
                                                var jTokenList = jToken.ToList();
                                                foreach (var li in jTokenList)
                                                {
                                                    if (li.Type == JTokenType.Array)
                                                    {
                                                        string jsonString = JsonConvert.SerializeObject(jToken);
                                                        if (!jsonString.StartsWith("{"))
                                                        {
                                                            jsonString = "{" + JsonConvert.SerializeObject(jToken) + "}";
                                                        }
                                                        if (jsonString != JsonConvert.SerializeObject(item.Value))
                                                        {
                                                            throw new Exception("Parameter mismatch");
                                                        }
                                                    }
                                                    else
                                                    {
                                                        if (li.Path == propInfo.Name && Convert.ToString(item.Value.GetType().GetProperty(propInfo.Name).GetValue(item.Value, null)) != Convert.ToString(GetValueOfProperty(propInfo, li)))
                                                        {
                                                            throw new Exception("Parameter mismatch");
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            var jTokenList = jToken.ToList();
                                            foreach (var li in jTokenList)
                                            {
                                                if (li.Path == item.Key && Convert.ToString(item.Value) != Convert.ToString(GetValueOfType(item.Value?.GetType(), li)))
                                                {
                                                    throw new Exception("Parameter mismatch");
                                                }
                                            }
                                        }
                                    }
                                }
                                else if (j != null)
                                {
                                    if (Convert.ToString(j.Value) != Convert.ToString(item.Value))
                                    {
                                        throw new Exception("Parameter mismatch");
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                if (ex.Message != "Parameter mismatch")
                                    throw new Exception("Something has went wrong");
                                else
                                    throw ex;
                            }
                        }
                    }
                }

            }
        }

            // Added by DipalI v On 4th sep 2026 - Purpose: generic slim Params hash validation (opt-in via AllowHashParams). Page sends HashFields/SortField/MatchFields/PayloadHash — no page-specific field names in ActionFilter.
            // Returns false when not Hash mode so existing full Params compare runs unchanged for all other APIs.
            private bool TryValidateSlimHashParams(JObject paramsObj, object actionArg)
            {
                if (paramsObj == null || actionArg == null)
                {
                    return false;
                }

                JObject hashMeta = null;
                foreach (var prop in paramsObj.Properties())
                {
                    if (prop.Value is JObject jo && string.Equals(Convert.ToString(jo["ValidationMode"]), "Hash", StringComparison.OrdinalIgnoreCase))
                    {
                        hashMeta = jo;
                        break;
                    }
                }
                if (hashMeta == null && string.Equals(Convert.ToString(paramsObj["ValidationMode"]), "Hash", StringComparison.OrdinalIgnoreCase))
                {
                    hashMeta = paramsObj;
                }
                if (hashMeta == null)
                {
                    return false;
                }

                // Generic contract (page-specific fields live only in HashFields sent by that page)
                int expectedCount = Convert.ToInt32(hashMeta["ItemCount"] ?? hashMeta["TaskCount"] ?? 0);
                string expectedHash = Convert.ToString(hashMeta["PayloadHash"] ?? hashMeta["TaskIdsHash"] ?? string.Empty);
                string sortField = Convert.ToString(hashMeta["SortField"] ?? string.Empty);
                JArray hashFieldsToken = hashMeta["HashFields"] as JArray;
                if (hashFieldsToken == null || hashFieldsToken.Count == 0 || string.IsNullOrWhiteSpace(expectedHash))
                {
                    throw new Exception("Parameter mismatch");
                }
                List<string> hashFields = hashFieldsToken.Select(t => Convert.ToString(t)).Where(s => !string.IsNullOrWhiteSpace(s)).ToList();
                if (hashFields.Count == 0)
                {
                    throw new Exception("Parameter mismatch");
                }
                if (string.IsNullOrWhiteSpace(sortField))
                {
                    sortField = hashFields[0];
                }

                IEnumerable list = null;
                PropertyInfo listProp = actionArg.GetType().GetProperties()
                    .FirstOrDefault(p => typeof(IEnumerable).IsAssignableFrom(p.PropertyType) && p.PropertyType != typeof(string));
                if (listProp != null)
                {
                    list = listProp.GetValue(actionArg, null) as IEnumerable;
                }
                else if (actionArg is IEnumerable && !(actionArg is string))
                {
                    list = actionArg as IEnumerable;
                }
                if (list == null)
                {
                    throw new Exception("Parameter mismatch");
                }

                JObject matchFields = hashMeta["MatchFields"] as JObject;
                List<Tuple<string, string>> rowPayloads = new List<Tuple<string, string>>();
                int actualCount = 0;
                foreach (object row in list)
                {
                    if (row == null)
                    {
                        throw new Exception("Parameter mismatch");
                    }
                    actualCount++;
                    Type rowType = row.GetType();

                    if (matchFields != null)
                    {
                        foreach (var mf in matchFields.Properties())
                        {
                            object rowVal = rowType.GetProperty(mf.Name)?.GetValue(row, null);
                            if (Convert.ToString(rowVal ?? string.Empty) != Convert.ToString(mf.Value ?? string.Empty))
                            {
                                throw new Exception("Parameter mismatch");
                            }
                        }
                    }

                    List<string> fieldValues = new List<string>();
                    string sortValue = string.Empty;
                    foreach (string fieldName in hashFields)
                    {
                        object val = rowType.GetProperty(fieldName)?.GetValue(row, null);
                        string sVal = Convert.ToString(val ?? string.Empty) ?? string.Empty;
                        fieldValues.Add(sVal);
                        if (string.Equals(fieldName, sortField, StringComparison.OrdinalIgnoreCase))
                        {
                            sortValue = sVal;
                        }
                    }
                    rowPayloads.Add(Tuple.Create(sortValue, string.Join("|", fieldValues)));
                }

                if (actualCount != expectedCount)
                {
                    throw new Exception("Parameter mismatch");
                }

                // Stable sort: numeric when possible, else string
                rowPayloads = rowPayloads
                    .OrderBy(r =>
                    {
                        long n;
                        if (long.TryParse(r.Item1, out n))
                        {
                            return n;
                        }
                        return long.MaxValue;
                    })
                    .ThenBy(r => r.Item1, StringComparer.Ordinal)
                    .ToList();

                string actualHash = ComputeSha256Hex(string.Join("\n", rowPayloads.Select(r => r.Item2)));
                if (!string.Equals(actualHash, expectedHash, StringComparison.OrdinalIgnoreCase))
                {
                    throw new Exception("Parameter mismatch");
                }

                return true;
            }

            // Added by DipalI v On 4th sep 2026 - Purpose: SHA256 hex for slim Params TaskIdsHash (must match TaskStatusManagement.aspx client hash)
            private static string ComputeSha256Hex(string input)
            {
                using (SHA256 sha = SHA256.Create())
                {
                    byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(input ?? string.Empty));
                    StringBuilder sb = new StringBuilder(bytes.Length * 2);
                    for (int i = 0; i < bytes.Length; i++)
                    {
                        sb.Append(bytes[i].ToString("x2"));
                    }
                    return sb.ToString();
                }
            }

            private PropertyInfo[] GetProperties(object obj)
            {
                if (obj == null)
                    return new PropertyInfo[0];
                return obj.GetType().GetProperties();
            }

            private object GetValueOfProperty(PropertyInfo info, object value)
            {
                if (info.PropertyType == typeof(DateTime))
                {
                    return Convert.ToDateTime(value).ToString();
                }
                else if (info.PropertyType == typeof(bool))
                {
                    if (Convert.ToString(value) == "0")
                    {
                        return false.ToString();
                    }
                    else
                    {
                        return true.ToString();
                    }
                }
                //Added By Dipali V On 31st Jan 2023 For Check Intger Value
                else if (info.PropertyType == typeof(int))
                {
                    if (Convert.ToString(value) == "")
                    {
                        return "0";
                    }

                }
                //End of Added By Dipali V On 31st Jan 2023 For Check Intger Value
                else if (info.PropertyType == typeof(Array))
                {

                }
                if (Convert.ToString(value) == "null")
                {
                    return "";
                }
                return value;
            }

            private object GetValueOfType(Type info, object value)
            {
                if (info == typeof(DateTime))
                {
                    return Convert.ToDateTime(value).ToString();
                }
                else if (info == typeof(bool))
                {
                    if (Convert.ToString(value) == "0")
                    {
                        return false.ToString();
                    }
                    else
                    {
                        return true.ToString();
                    }
                }
                //Added By Dipali V On 31st Jan 2023 For Check Intger Value
                else if (info == typeof(int))
                {
                    if (Convert.ToString(value) == "")
                    {
                        return "0";
                    }

                }
                //End of Added By Dipali V On 31st Jan 2023 For Check Intger Value
                if (Convert.ToString(value) == "null")
                {
                    return null;
                }
                return value;
            }
        }

    /// <summary>
    /// Opt-in rate limit for data-modification POST actions (Save/Insert/Update/Delete).
    /// Add alongside [ValidateHeaders] on save methods only — read POST APIs are not affected.
    /// Uses Web.config: RateLimit_Enabled, RateLimit_Duration_Minutes, RateLimit_Count.
    /// Added by Vishal Mane on 01/06/2026 — WhizibleAPI-Timesheet.
    /// </summary>
    public class ValidateRateLimit : ActionFilterAttribute
    {
        private static readonly Dictionary<string, (int Count, DateTime Timestamp)> RequestCounts =
            new Dictionary<string, (int Count, DateTime Timestamp)>();

        private static readonly object SyncRoot = new object();

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            var enabled = ConfigurationManager.AppSettings["RateLimit_Enabled"];
            if (string.Equals(enabled, "false", StringComparison.OrdinalIgnoreCase)
                || string.Equals(enabled, "0", StringComparison.OrdinalIgnoreCase))
            {
                return;
            }

            // Only enforce on POST (attribute is opt-in on save POST methods)
            if (actionContext.Request != null
                && !string.Equals(actionContext.Request.Method.Method, "POST", StringComparison.OrdinalIgnoreCase))
            {
                return;
            }

            var durationMinutes = GetConfigInt("RateLimit_Duration_Minutes", 5);
            var maxCount = GetConfigInt("RateLimit_Count", 3);

            var ip = GetClientIp(actionContext);
            var controller = actionContext.ActionDescriptor.ControllerDescriptor.ControllerName;
            var action = actionContext.ActionDescriptor.ActionName;
            var userKey = actionContext.RequestContext?.Principal?.Identity?.Name ?? string.Empty;

            var key = $"{ip}|{controller}|{action}|{userKey}";
            var rateLimited = false;

            lock (SyncRoot)
            {
                if (!RequestCounts.ContainsKey(key))
                {
                    RequestCounts[key] = (1, DateTime.UtcNow);
                }
                else
                {
                    var entry = RequestCounts[key];
                    if ((DateTime.UtcNow - entry.Timestamp).TotalMinutes < durationMinutes)
                    {
                        if (entry.Count >= maxCount)
                        {
                            rateLimited = true;
                        }
                        else
                        {
                            RequestCounts[key] = (entry.Count + 1, entry.Timestamp);
                        }
                    }
                    else
                    {
                        RequestCounts[key] = (1, DateTime.UtcNow);
                    }
                }
            }

            if (rateLimited)
            {
                actionContext.Response = actionContext.Request.CreateResponse(
                    (HttpStatusCode)429,
                    "Too many attempts for this request");
            }
        }

        private static string GetClientIp(HttpActionContext actionContext)
        {
            if (actionContext?.Request?.Properties != null
                && actionContext.Request.Properties.TryGetValue("MS_HttpContext", out var httpContextObj)
                && httpContextObj is HttpContextWrapper wrapper)
            {
                return wrapper.Request.UserHostAddress ?? "unknown";
            }

            if (HttpContext.Current != null)
            {
                return HttpContext.Current.Request.UserHostAddress ?? "unknown";
            }

            return "unknown";
        }

        private static int GetConfigInt(string key, int defaultValue)
        {
            var value = ConfigurationManager.AppSettings[key];
            int parsed;
            return int.TryParse(value, out parsed) ? parsed : defaultValue;
        }
    }
}
