using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Web;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;

public class CachingAttribute : ActionFilterAttribute

{

    public int Duration { get; set; }

    private bool CacheEnabled = false;
    public int cachingDuration = Convert.ToInt32(CommonFunctions.General.CheckIsNothing(ConfigurationManager.AppSettings["CachingDuration"], "60"));

    public CachingAttribute(bool _cacheEnabled)
    {

        Duration = cachingDuration;

        CacheEnabled = _cacheEnabled;

    }

    public override void OnActionExecuting(HttpActionContext context)

    {

        if (CacheEnabled)

        {

            if (context != null)

            {
                //generate cache key from HTTP request URI and Header

                string _cachekey = string.Join(":", new string[]

                {

                            context.Request.RequestUri.OriginalString,

                            context.Request.Headers.Accept.FirstOrDefault().ToString(),

                });


                // Check Key exists

                if (MemoryCacher.Contains(_cachekey))

                {


                    var val = (string)MemoryCacher.GetValue(_cachekey);

                    if (val != null)

                    {

                        context.Response = context.Request.CreateResponse();

                        context.Response.Content = new StringContent(val);

                        var contenttype = (MediaTypeHeaderValue)MemoryCacher.GetValue(_cachekey +

                    ":response-ct");

                        if (contenttype == null)

                            contenttype = new MediaTypeHeaderValue(_cachekey.Split(':')[1]);

                        context.Response.Content.Headers.ContentType = contenttype;

                        return;

                    }

                }
            }

        }

    }



    public override void OnActionExecuted(HttpActionExecutedContext context)

    {



        if (CacheEnabled)

        {

            //if (WebApiCache != null)

            //{

                string _cachekey = string.Join(":", new string[]

                {

                            context.Request.RequestUri.OriginalString,

                            context.Request.Headers.Accept.FirstOrDefault().ToString(),

                });


                if (context.Response != null && context.Response.Content != null)

                {

                    string body = context.Response.Content.ReadAsStringAsync().Result;


                    if (MemoryCacher.Contains(_cachekey))

                    {

                        MemoryCacher.Add(_cachekey, body, DateTime.Now.AddSeconds(Duration));

                        MemoryCacher.Add(_cachekey + ":response-ct",

                        context.Response.Content.Headers.ContentType,

                        DateTime.Now.AddSeconds(240));

                    }

                    else

                    {

                        MemoryCacher.Add(_cachekey, body, DateTime.Now.AddSeconds(Duration));

                        MemoryCacher.Add(_cachekey + ":response-ct",

                        context.Response.Content.Headers.ContentType,

                        DateTime.Now.AddSeconds(Duration));

                    }

                }

            //}

        }

    }


}