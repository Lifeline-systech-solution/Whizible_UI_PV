using Microsoft.Owin;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
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
            //Added or modified by Vishal Mane on 29/04/2026 to fix rate limiting per request (login /token only)
            //var durationConfig = ConfigurationManager.AppSettings["RateLimit_Duration_Minutes"];
            //var countConfig = ConfigurationManager.AppSettings["RateLimit_Count"];
            //int Duration = 5;
            //int MaxCount = 3;
            //int.TryParse(durationConfig, out Duration);
            //int.TryParse(countConfig, out MaxCount);
            //var requestCounts = new Dictionary<string, (int Count, DateTime Timestamp)>();
            //app.Use(async (context, next) =>
            //{
            //    var path = context.Request.Path.Value?.ToLowerInvariant() ?? string.Empty;
            //    var isTokenPost = path.Contains("/token")
            //        && string.Equals(context.Request.Method, "POST", StringComparison.OrdinalIgnoreCase);

            //    if (!isTokenPost)
            //    {
            //        await next.Invoke();
            //        return;
            //    }

            //    var ip = context.Request.RemoteIpAddress ?? "unknown";
            //    var userKey = string.Empty;
            //    var form = await context.Request.ReadFormAsync();
            //    userKey = form["username"];

            //    var key = $"{ip}_{path}_{userKey}";
            //    var rateLimited = false;

            //    lock (requestCounts)
            //    {
            //        if (!requestCounts.ContainsKey(key))
            //        {
            //            requestCounts[key] = (1, DateTime.UtcNow);
            //        }
            //        else
            //        {
            //            var entry = requestCounts[key];
            //            if ((DateTime.UtcNow - entry.Timestamp).TotalMinutes < Duration)
            //            {
            //                if (entry.Count >= MaxCount)
            //                {
            //                    rateLimited = true;
            //                }
            //                else
            //                {
            //                    requestCounts[key] = (entry.Count + 1, entry.Timestamp);
            //                }
            //            }
            //            else
            //            {
            //                requestCounts[key] = (1, DateTime.UtcNow);
            //            }
            //        }
            //    }

            //    if (rateLimited)
            //    {
            //        context.Response.StatusCode = 429;
            //        await context.Response.WriteAsync("Too many attempts for this request");
            //        return;
            //    }

            //    await next.Invoke();
            //});
            //End of Added or modified by Vishal Mane on 29/04/2026 to fix rate limiting per request

            // POST-only guard for /token
            app.Use(async (context, next) =>
            {
                if (context.Request.Path.Value.Equals("/token", StringComparison.OrdinalIgnoreCase)
                    && context.Request.Method != "POST")
                {
                    context.Response.StatusCode = 405;
                    await context.Response.WriteAsync("Only POST method is allowed");
                    return;
                }
                await next.Invoke();
            });

            var OAuthOptions = new OAuthAuthorizationServerOptions
            {
                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/token"),
                AccessTokenExpireTimeSpan = TimeSpan.FromDays(1),
                Provider = new Provider()
            };

            app.UseOAuthAuthorizationServer(OAuthOptions);

            app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions
            {
                Provider = new OAuthBearerAuthenticationProvider
                {
                    OnValidateIdentity = context =>
                    {
                        var claimsIdentity = context.Ticket?.Identity as ClaimsIdentity;

                        if (!Provider.IsTokenBoundToCurrentRequest(claimsIdentity, context.Request))
                        {
                            context.Rejected();
                            context.Response.StatusCode = 401;
                            context.SetError("invalid_token", "Token validation failed");
                            return Task.FromResult(0);
                        }

                        if (!Provider.IsSecurityStampValid(claimsIdentity, context.Request))
                        {
                            context.Rejected();
                            context.Response.StatusCode = 401;
                            context.SetError("invalid_token", "PASSWORDCHANGED");
                            return Task.FromResult(0);
                        }

                        return Task.FromResult(0);
                    }
                }
            });
        }

        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            GlobalConfiguration.Configure(WebApiConfig.Register);
        }
    }
}