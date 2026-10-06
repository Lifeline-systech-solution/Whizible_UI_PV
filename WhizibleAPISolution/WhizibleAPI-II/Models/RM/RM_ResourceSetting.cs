using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.RM
{
    public class ResourceSetting
    {
        public int TagID { get; set; }
        public int RoleID { get; set; }
        public int UserID { get; set; }
        public string LoginType { get; set; }
        public int ProjectID { get; set; }
        public int ParentTagID { get; set; }

        public DataTable GetDetailsWithAccess { get; set; }
        public DataTable NodeAccess { get; set; }
        public IDataReader TaskTypeColorDetails { get; set; }
    }
}