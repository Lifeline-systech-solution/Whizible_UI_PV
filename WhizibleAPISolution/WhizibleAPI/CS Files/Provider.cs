using Authentication;
using Microsoft.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http.Cors;
using WhizibleAPI.Controllers;

namespace Whizible.CS_Files
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class Provider : OAuthAuthorizationServerProvider
    {
        // Added by or modified by Vishal Mane on 27/04/2026 to fix security issue
        private const string LoginNameClaimType = "login_name";
        private const string ClientBindingClaimType = "client_binding";
        // End of Added by or modified by Vishal Mane on 27/04/2026

        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            // Added By Dipali V on 29th Dec 2025 For Programming Error Messages Prevention
            try
            {
                var identity = new ClaimsIdentity(context.Options.AuthenticationType);

                // Added By Nikhil A for CORS - Vulnerability
                var strDomain = ConfigurationManager.AppSettings["DomainName"];
                context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { strDomain });
                // End Of Added By Nikhil A

                // Added By Dipali for SQL Injection On 29th Dec 2025
                if (ContainsSQLInjection(context.UserName) || ContainsSQLInjection(context.Password))
                {
                    context.Response.StatusCode = 400;
                    context.SetError("invalid_request", "Your request is invalid");
                    return;
                }
                // End of Added By Dipali

                string UName = "";
                string Pwd = "";
                string NewPwd = "";
                string m_strPasswordForEncrypt = "";
                string strPasswordPrevious = "";
                int isValidUser = 0;
                //Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
                //string[] strpwd = context.Password.Split('|');

                //for (int i = 0; i <= strpwd.Length - 2; i++)
                //{
                //    m_strPasswordForEncrypt += strpwd[i].Substring(0, 1);
                //}
                //for (int i = m_strPasswordForEncrypt.Length - 1; i > -1; i--)
                //{
                //    NewPwd += m_strPasswordForEncrypt[i];
                //}
                //NewPwd = NewPwd.Replace("''", "'");
                NewPwd = context.Password;
                //End of Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
                PWEncryption objPW1 = new PWEncryption(context.UserName, NewPwd);
                strPasswordPrevious = objPW1.Encrypt().ToString();

                DataTable dt = CommonFunctions.Data.GetDataTable(
                    "EXEC usp_ValidateActiveLogin '" + context.UserName + "','" + strPasswordPrevious + "'",
                    true,
                    CommonController.connectionString);

                string loginID = "";
                string securityStamp = "";

                foreach (DataRow row in dt.Rows)
                {
                    UName = row["LoginName"].ToString();
                    Pwd = row["Password"].ToString();
                    isValidUser = 1;

                    // Added By Nikhil Mane on 28th April 2026
                    // Capture LoginID and SecurityStamp at login time and embed in token
                    loginID = row.Table.Columns.Contains("LoginID") ? row["LoginID"].ToString() : "";
                    securityStamp = row.Table.Columns.Contains("SecurityStamp") ? row["SecurityStamp"].ToString() : "";
                    // End Of Added By Nikhil Mane on 28th April 2026
                }

                // Added By Nikhil Adkar for AzureAD Integration
                string AzureAD = ConfigurationManager.AppSettings["AzureAD"];
                string AllowSAMLRedirection = ConfigurationManager.AppSettings["AllowSAMLRedirection"];
                if (AzureAD == "0" && AllowSAMLRedirection == "1")
                    AzureAD = "1";

                if (AzureAD == "1")
                {
                    isValidUser = 1;

                    string normalizedUser = NormalizeUserName(context.UserName);
                    string clientBinding = BuildClientBinding(context.OwinContext.Request, normalizedUser);

                    identity.AddClaim(new Claim(ClaimTypes.NameIdentifier, normalizedUser));
                    identity.AddClaim(new Claim(ClaimTypes.Name, normalizedUser));
                    identity.AddClaim(new Claim(LoginNameClaimType, normalizedUser));
                    identity.AddClaim(new Claim(ClientBindingClaimType, clientBinding));

                    // Added By Nikhil Mane on 28th April 2026 — embed stamp in token
                    if (!string.IsNullOrEmpty(loginID))
                        identity.AddClaim(new Claim("login_id", loginID));
                    if (!string.IsNullOrEmpty(securityStamp))
                        identity.AddClaim(new Claim("security_stamp", securityStamp));
                    // End Of Added By Nikhil Mane on 28th April 2026

                    identity.AddClaim(new Claim("Age", "16"));

                    var props = new AuthenticationProperties(new Dictionary<string, string>
                    {
                        { "userdisplayname", "Admin" },
                        { "role",            "admin" }
                    });
                    var ticket = new AuthenticationTicket(identity, props);
                    context.Validated(ticket);
                    return;
                }
                // End of Added By Nikhil Adkar

                if (context.UserName != "" && context.Password != "" && isValidUser == 1)
                {
                    string normalizedUser = NormalizeUserName(context.UserName);
                    string clientBinding = BuildClientBinding(context.OwinContext.Request, normalizedUser);

                    identity.AddClaim(new Claim(ClaimTypes.NameIdentifier, normalizedUser));
                    identity.AddClaim(new Claim(ClaimTypes.Name, normalizedUser));
                    identity.AddClaim(new Claim(LoginNameClaimType, normalizedUser));
                    identity.AddClaim(new Claim(ClientBindingClaimType, clientBinding));

                    // Added By Nikhil Mane on 28th April 2026 — embed stamp in token
                    if (!string.IsNullOrEmpty(loginID))
                        identity.AddClaim(new Claim("login_id", loginID));
                    if (!string.IsNullOrEmpty(securityStamp))
                        identity.AddClaim(new Claim("security_stamp", securityStamp));
                    // End Of Added By Nikhil Mane on 28th April 2026

                    identity.AddClaim(new Claim("Age", "16"));

                    var props = new AuthenticationProperties(new Dictionary<string, string>
                    {
                        { "userdisplayname", context.UserName },
                        { "role",            "admin"          }
                    });
                    var ticket = new AuthenticationTicket(identity, props);
                    context.Validated(ticket);
                }
                else
                {
                    context.SetError("invalid_grant", "Provided username and password is incorrect");
                    context.Rejected();
                }
                return;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("GrantResourceOwnerCredentials Error: " + ex.ToString());
                context.Response.StatusCode = 400;
                context.SetError("invalid_request", "Something went wrong");
                return;
            }
            // End of Added By Dipali V on 29th Dec 2025
        }

        // Added By Nikhil Mane on 28th April 2026
        // Validates SecurityStamp from token claim against DB — called in Startup.cs pipeline
        // Pass request in so we never touch HttpContext.Current
        public static bool IsSecurityStampValid(ClaimsIdentity identity, IOwinRequest request)
        {
            try
            {
                if (identity == null) return true;

                string loginID = GetClaimValue(identity, "login_id");
                string tokenStamp = GetClaimValue(identity, "security_stamp");

                if (string.IsNullOrEmpty(loginID) || string.IsNullOrEmpty(tokenStamp))
                    return true;

                // Throttle via OWIN environment dict
                var env = request.Environment;
                string lastCheckKey = "_StampLastCheck_" + loginID;

                if (env.TryGetValue(lastCheckKey, out object lastCheckObj)
                    && lastCheckObj is DateTime lastCheck
                    && (DateTime.UtcNow - lastCheck).TotalSeconds < 60)
                {
                    return true;
                }

                env[lastCheckKey] = DateTime.UtcNow;

                // ✅ Pass connection string explicitly — same pattern as GrantResourceOwnerCredentials
                string dbStamp = CommonFunctions.General.CheckIsNothing(
                    CommonFunctions.Data.CheckIsDBNull(
                        CommonFunctions.Data.GetDataScalar(
                            "EXEC usp_Sel_SecurityStamp_For_LoginID " + loginID,
                            true,
                            CommonController.connectionString),   // ← ADD THIS
                        ""), "");

                if (string.IsNullOrEmpty(dbStamp)) return true;

                return string.Equals(dbStamp, tokenStamp, StringComparison.OrdinalIgnoreCase);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("IsSecurityStampValid Error: " + ex.ToString());
                return true;
            }
        }
        // End Of Added By Nikhil Mane on 28th April 2026

        // Added by or modified by Vishal Mane on 27/04/2026
        public static bool IsTokenBoundToCurrentRequest(ClaimsIdentity identity, Microsoft.Owin.IOwinRequest request)
        {
            if (identity == null || request == null) return false;

            string tokenUser = NormalizeUserName(GetClaimValue(identity, LoginNameClaimType) ?? identity.Name);
            string tokenBinding = GetClaimValue(identity, ClientBindingClaimType);

            if (string.IsNullOrWhiteSpace(tokenUser) || string.IsNullOrWhiteSpace(tokenBinding))
                return false;

            string expectedBinding = BuildClientBinding(request, tokenUser);
            return SecureEquals(tokenBinding, expectedBinding);
        }

        private static string NormalizeUserName(string userName)
            => (userName ?? string.Empty).Trim().ToLowerInvariant();

        private static string BuildClientBinding(Microsoft.Owin.IOwinRequest request, string normalizedUser)
        {
            string userAgent = request.Headers.Get("User-Agent") ?? string.Empty;
            string ipAddress = request.RemoteIpAddress ?? string.Empty;
            string raw = normalizedUser + "|" + userAgent + "|" + ipAddress;
            byte[] bytes = Encoding.UTF8.GetBytes(raw);
            using (SHA256 sha = SHA256.Create())
                return Convert.ToBase64String(sha.ComputeHash(bytes));
        }

        private static bool SecureEquals(string left, string right)
        {
            byte[] leftBytes = Encoding.UTF8.GetBytes(left ?? string.Empty);
            byte[] rightBytes = Encoding.UTF8.GetBytes(right ?? string.Empty);
            if (leftBytes.Length != rightBytes.Length) return false;
            int diff = 0;
            for (int i = 0; i < leftBytes.Length; i++)
                diff |= leftBytes[i] ^ rightBytes[i];
            return diff == 0;
        }

        private static string GetClaimValue(ClaimsIdentity identity, string claimType)
        {
            Claim claim = identity.FindFirst(claimType);
            return claim?.Value;
        }
        // End of Added by or modified by Vishal Mane on 27/04/2026

        // Added By Dipali for SQL Injection On 29th Dec 2025
        private bool ContainsSQLInjection(string input)
        {
            string baseDir = AppDomain.CurrentDomain.BaseDirectory;
            DirectoryInfo dir = Directory.GetParent(baseDir);
            dir = dir.Parent;
            string configPath = Path.Combine(dir.FullName, "bin", "security.config");

            ExeConfigurationFileMap configMap = new ExeConfigurationFileMap
            {
                ExeConfigFilename = configPath
            };
            Configuration config = ConfigurationManager.OpenMappedExeConfiguration(
                configMap, ConfigurationUserLevel.None);

            string keywords = config.AppSettings.Settings["SQLKeyWords"].Value;
            string[] words = keywords.Split('|');

            foreach (string w in words)
            {
                if (!string.IsNullOrEmpty(w) && input.ToLower().Contains(w.ToLower()))
                    return true;
            }
            return false;
        }
        // End of Added By Dipali
    }
}