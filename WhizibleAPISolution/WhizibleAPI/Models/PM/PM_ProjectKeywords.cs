using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ProjectKeywords
    {
        public int ProjectID { get; set; }
        public int ProjectKeywordID { get; set; }
        public string Keyword { get; set; }
        public string CreatedBy { get; set; }        
    }
}