using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace WhizibleAPI.Models.SM
{ 
    public class SM_Default
    { }

    public class EmployeeDetails
    {
        public string AuthNo { get; set; }
        public string NewPassword { get; set; }
        public string LoginName { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string EmailID { get; set; }
        public string OldPassword { get; set; }
        public string ConfirmPassword { get; set; }

    }

  
}