using Authentication;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http.Cors;
using WhizibleAPI.Controllers;

namespace Whizible.CS_Files
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class Provider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated(); //   
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {

            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            // Added By Nikhil A for CORS - Vulnerability
            var strDomain = ConfigurationManager.AppSettings["DomainName"];
            context.OwinContext.Response.Headers.Add("Access-Control-Allow-Origin", new[] { strDomain });
            //End Of Added By Nikhil A
            //Added By Nikhil A for 
            string UName = "";
            string Pwd = "";
            string NewPwd = "";
            string m_strPasswordForEncrypt = "";
            string strPasswordPrevious = "";
            int isValidUser = 0;
            string[] strpwd = context.Password.Split('|');

            for (int i = 0; i <= strpwd.Length - 2; i++)
            {
                m_strPasswordForEncrypt += strpwd[i].Substring(0, 1);
            }
            for (int i = m_strPasswordForEncrypt.Length - 1; i > -1; i--)
            {
                NewPwd += m_strPasswordForEncrypt[i];
            }
            NewPwd = NewPwd.Replace("''", "'");
            PWEncryption objPW1 = new PWEncryption(context.UserName, NewPwd);
            strPasswordPrevious = objPW1.Encrypt().ToString();

            DataTable dt = CommonFunctions.Data.GetDataTable("EXEC usp_ValidateActiveLogin '" + context.UserName + "','" + strPasswordPrevious + "'", true, CommonController.connectionString);
            foreach (DataRow row in dt.Rows)
            {
                UName = row["LoginName"].ToString();
                Pwd = row["Password"].ToString();
                isValidUser = 1;
            }

            //End of Added By Nikhil A
            //Added By Nikhil Adkar for AzureAD Integration
            string AzureAD = ConfigurationManager.AppSettings["AzureAD"]; ;

            if (AzureAD == "1")
            {
                isValidUser = 1;
            }
            //END of added By Nikhil Adkar



            if (context.UserName != "" && context.Password != "" && isValidUser == 1)
            {
                identity.AddClaim(new Claim("Age", "16"));
                var props = new AuthenticationProperties(new Dictionary<string, string>
                            {
                                {
                                    "userdisplayname", context.UserName
                                },
                                {
                                     "role", "admin"
                                }
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
    }
}