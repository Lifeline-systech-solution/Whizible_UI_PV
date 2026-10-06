using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WhizibleAPI.Controllers
{
    public class CommonController : ApiController
    {
        public static string connectionString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings["ConnectionString"]);
    }
}
