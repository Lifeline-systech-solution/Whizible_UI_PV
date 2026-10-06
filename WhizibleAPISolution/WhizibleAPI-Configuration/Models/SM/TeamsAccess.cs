using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.SM
{
    public class TeamsAccess
    { 
        public int RoleID { get; set; }
         public int OUID { get; set; }
         public int UserId { get; set; }
         public string EmployeeIDs { get; set; }
         public string LoginType { get; set; }
    }
}