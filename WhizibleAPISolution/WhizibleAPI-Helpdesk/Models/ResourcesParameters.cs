using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models
{
    public class ResourcesParameters
    {
        public char LoginType { get; set; }
        public int RoleId { get; set; }
        public int UserId { get; set; } // same as Employee id
        public string UserName { get; set; }
        public string DepartmentName { get; set; }
        public string CustomerName { get; set; } // al
        public DateTime FromDate {get; set;} //al
        public DateTime ToDate { get; set; }  //al
        public DateTime OnDate { get; set; }
        public int Id { get; set; } // For TicketId
        public List<int> Ids { get; set; } 
        public string SIDs { get; set; } 
    }
}