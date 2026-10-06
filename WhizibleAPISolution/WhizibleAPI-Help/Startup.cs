using Microsoft.Owin;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using Whizible.CS_Files;
using WhizibleAPI;

[assembly: OwinStartup(typeof(Whizible.App_Start.Startup))]
namespace Whizible.App_Start
{

    public class Startup
    {
        public void ConfigureAuth(IAppBuilder app)
        {

            var OAuthOptions = new OAuthAuthorizationServerOptions
            {
                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/token"),
                //Commneted and Added By Nikhil A on 20-Jan-2021 for Increasing Token Expiretimeout
                //AccessTokenExpireTimeSpan = TimeSpan.FromMinutes(60),
                AccessTokenExpireTimeSpan = TimeSpan.FromDays(1),
                //End of Commneted and Added By Nikhil A
                Provider = new Provider()
            };

            app.UseOAuthBearerTokens(OAuthOptions);
            app.UseOAuthAuthorizationServer(OAuthOptions);
            app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions());

            HttpConfiguration config = new HttpConfiguration();
            WebApiConfig.Register(config);
        }

        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            GlobalConfiguration.Configure(WebApiConfig.Register);
        }
    }
}