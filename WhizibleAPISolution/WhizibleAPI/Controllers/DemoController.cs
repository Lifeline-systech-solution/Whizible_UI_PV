using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhizibleAPI.Models.Demo;

namespace WhizibleAPI.Controllers
{
    public class DemoController : ApiController
    {
        [HttpPost]
        [Authorize]
        public List<Demo> GetDemos() {
            List<Demo> demos = new List<Demo>();
            for (int i = 0; i < 10; i++)
            {
                Demo demo = new Demo();
                demo.DemoID = i;
                demo.DemoName = "Demo" + i;
                demos.Add(demo);
            }
            return demos;
        }

        [HttpGet]
        [Authorize]
        public List<Demo> GetDemoAuthorize()
        {
            List<Demo> demos = new List<Demo>();
            for (int i = 0; i < 10; i++)
            {
                Demo demo = new Demo();
                demo.DemoID = i;
                demo.DemoName = "Demo" + i;
                demos.Add(demo);
            }
            return demos;
        }

        [HttpGet]
        public List<Demo> GetDemosUnAuthorize()
        {
            List<Demo> demos = new List<Demo>();
            for (int i = 0; i < 10; i++)
            {
                Demo demo = new Demo();
                demo.DemoID = i;
                demo.DemoName = "Demo" + i;
                demos.Add(demo);
            }
            return demos;
        }
    }
}
