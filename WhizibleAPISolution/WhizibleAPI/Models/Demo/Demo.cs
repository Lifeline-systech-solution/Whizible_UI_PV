using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Demo
{
    public class Demo
    {
        public int DemoID { get; set; }
        public string DemoName { get; set; }
        public List<DemoList> demoLists { get; set; }
    }
}