using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http.Filters;
using System.Web.Http.Controllers;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Reflection;
using System.Configuration;
using System.Text;
using Microsoft.Owin.Security.OAuth;
using System.Net;
using System.Net.Http;

namespace WhizibleAPI.App_Start
{
    public class ValidateHeaders : ActionFilterAttribute
    {
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
                                    //o = JsonConvert.DeserializeObject<JObject>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key == "Params").Value)));
                                }
                                catch (Exception ex)
                                {
                                     j = JsonConvert.DeserializeObject<JValue>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key.ToLower() == "params").Value.FirstOrDefault())));
                                    //j = JsonConvert.DeserializeObject<JValue>(CommonFunctions.General.DecryptString(Convert.ToString(actionContext.Request.Headers.ToList().FirstOrDefault(h => h.Key == "Params").Value)));
                                }
                                if (o != null)
                                {
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
        private static readonly Dictionary<string, RequestInfo> RequestCounts =
            new Dictionary<string, RequestInfo>();

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
                    //RequestCounts[key] = (1, DateTime.UtcNow);
                    RequestCounts[key] = new RequestInfo
                    {
                        Count = 1,
                        Timestamp = DateTime.UtcNow
                    };
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
                            //RequestCounts[key] = (entry.Count + 1, entry.Timestamp);
                            RequestCounts[key] = new RequestInfo
                            {
                                Count = entry.Count + 1,
                                Timestamp = entry.Timestamp
                            };
                        }
                    }
                    else
                    {
                        //RequestCounts[key] = (1, DateTime.UtcNow);
                        RequestCounts[key] = new RequestInfo
                        {
                            Count = 1,
                            Timestamp = DateTime.UtcNow
                        };
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

    public class RequestInfo
    {
        public int Count { get; set; }
        public DateTime Timestamp { get; set; }
    }
}