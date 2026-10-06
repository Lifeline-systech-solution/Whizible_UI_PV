using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.Email
{
    public class SendEmail
    {
        //public List<EmailMessage> EmailMessageList { get; set; }
        public string FromEmailID { get; set; }
        public string ToEmailID { get; set; }
        public string CCToEmailID { get; set; }
        public string Subject { get; set; }
        public string Message { get; set; }

        //start by Vishal Mahajan 10-12-2019 for attachment
        public bool IsAttachment { get; set; }
        public string FileName { get; set; }
        public string FilePath { get; set; }
        //end by Vishal Mahajan 10-12-2019
    }
    public class EmailMessage
    {
       //public string FromEmailID { get; set; }
       // public string ToEmailID { get; set; }
       // public string CCToEmailID { get; set; }
       // public string Subject { get; set; }
       // public string Message { get; set; }
    }
}