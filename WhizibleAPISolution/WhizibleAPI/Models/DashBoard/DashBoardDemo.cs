using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.DashBoard
{
    public class DashBoardDemo
    {

        public List<DashBoardCustomerDetails> DashboardCustLists { get; set; }
        public List<DashBoardSkillDetails> DashboardSkillLists { get; set; }
        public List<DashBoardSkillShortSurplusDetails> DashboardSurplusLists { get; set; }
        public List<DashBoardProjectRevenue_ProjectionDetails> DashboardProjectRevenueLists { get; set; }
        public List<DashBoardProjectRevenue_RecognitionDetails> DashboardProjectRevenueRecogLists { get; set; }
        public List<DashBoardProjectRevenue_RealizationDetails> DashboardProjectRevenueRealLists { get; set; }
        public List<DashBoardProjectCompletion_PaymentDetails> DashboardProjectCompl_PayLists { get; set; }
        public List<Dependent_ComboBox> objDependent_ComboBox { get; set; }

    }

    public class DashBoardCustomerDetails
    {
        public string Monthname { get; set; }
        public string CustomerName { get; set; }
        public double Available { get; set; }
        public double Utilization { get; set; }
        public double Invoiced { get; set; }
        public int WeekNumber { get; set; }

    }
    public class DashBoardSkillDetails
    {
        public string SkillName { get; set; }
        public int WeekNumber { get; set; }
        public string MonthName { get; set; }
        public double ResourceCapacity { get; set; }
        public double ResourceAllocated { get; set; }
        public double OpportunityReq { get; set; }
        public double ResourceBench { get; set; }
        public double ResourceRelease { get; set; }
        public double ResourceShort_Surplus { get; set; }
    }

    public class DashBoardSkillShortSurplusDetails
    {
        public string SkillName { get; set; }
        public int WeekNumber { get; set; }
        public string MonthName { get; set; }
        public double SumofCost { get; set; }
        public double SumofLostBillability { get; set; }
    }

    public class DashBoardProjectRevenue_ProjectionDetails
    {
        public string Quarter { get; set; }
        public string MonthName { get; set; }
        public double CountMonthMileStone { get; set; }
        public double CountQuarterMilestone { get; set; }
        public double Commercial_Value { get; set; }
        public int WeekNumber { get; set; }

    }

    public class DashBoardProjectRevenue_RecognitionDetails
    {
        public string Quarter { get; set; }
        public string ProjectName { get; set; }
        public string MonthName { get; set; }
        public float Amount { get; set; }
        public double TotalAmount { get; set; }
    }
    public class DashBoardProjectRevenue_RealizationDetails
    {
        public string Quarter { get; set; }
        public string ProjectName { get; set; }
        public string MonthName { get; set; }
        public double InvoicePayment { get; set; }
        public double TotalInvoicePayment { get; set; }
    }
    public class DashBoardProjectCompletion_PaymentDetails
    {
        public string MonthName { get; set; }
        public string ProjectName { get; set; }
        public int CountMileStone { get; set; }
        public double Sum_PaymentPercentage { get; set; }
        public double Sum_CompletionPercentage { get; set; }
        public int WeekNumber { get; set; }
    }
    public class Dependent_ComboBox
    {
        public int CboID { get; set; }
        public string CboName { get; set; }
    }
}