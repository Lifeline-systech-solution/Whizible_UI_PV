using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.EmailMessages
{
    public class EmailMessages
    {
        public List<MessagesBody> MessagesBodyList { get; set; }
        public List<EmployeeDetails> EmployeeDetailList { get; set; }
        public List<CompanyInformation> companyInformationList { get; set; }
        public string strUserName { get; set; }
        public string strEmailid { get; set; }
        public string strFromEmailID { get; set; }
        public string strToEmailID { get; set; }
        public string strCCToEmailID { get; set; }
        public string strSubject { get; set; }
        public string strEmailMessage { get; set; }
        public long lngMsgID { get; set; }
    }
    public class MessagesBody
    {
        public string strBody { get; set; }
        public string strSubject { get; set; }
    }
    public class EmployeeDetails
    {
      
        public string strUserName { get; set; }
        public string strEmailid { get; set; }
    }
    public class CompanyInformation
    {
        public int StartingDayOfWeek { get; set; }
        public string FinancialYearStart { get; set; }
        public string FinancialYearEnd { get; set; }
        public string SMTPUserName { get; set; }
        public string SMTPPassword { get; set; }
        public string SMTPDomainName { get; set; }
        public int SMTPServerPort { get; set; }
        public string EmailFormat { get; set; }
        public string SMTPServer { get; set; }
        public bool isSSLEnabled { get; set; }
    }
    //    public class SendEmailSSLCompatible
    //    {
    //        public string successMessage { get; set; }
    //    }
}