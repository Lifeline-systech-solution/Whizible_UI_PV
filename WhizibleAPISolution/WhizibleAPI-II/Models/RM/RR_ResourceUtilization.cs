using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RR_ResourceUtilization
    {

    }

    #region ProjectResourceWiseMOnth

    public class RrProjectMonths : Rr_Months
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public List<RrResourcMonths> RrResourceList { get; set; }

    }

    public class RrResourcMonths : Rr_Months
    {
        public int ResourceId { get; set; }
        public int ProjectId { get; set; }
        public string ResourceName { get; set; }
        public string ProjectName { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }

    }

    public class Rr_Months
    {
        public Decimal Month_1 { get; set; }
        public Decimal Month_2 { get; set; }
        public Decimal Month_3 { get; set; }
        public Decimal Month_4 { get; set; }
        public Decimal Month_5 { get; set; }
        public Decimal Month_6 { get; set; }
        public Decimal Month_7 { get; set; }
        public Decimal Month_8 { get; set; }
        public Decimal Month_9 { get; set; }
        public Decimal Month_10 { get; set; }
        public Decimal Month_11 { get; set; }
        public Decimal Month_12 { get; set; }

        public Decimal Month_Ah1 { get; set; }
        public Decimal Month_Ah2 { get; set; }
        public Decimal Month_Ah3 { get; set; }
        public Decimal Month_Ah4 { get; set; }
        public Decimal Month_Ah5 { get; set; }
        public Decimal Month_Ah6 { get; set; }
        public Decimal Month_Ah7 { get; set; }
        public Decimal Month_Ah8 { get; set; }
        public Decimal Month_Ah9 { get; set; }
        public Decimal Month_Ah10 { get; set; }
        public Decimal Month_Ah11 { get; set; }
        public Decimal Month_Ah12 { get; set; }
    }

    public class Rr_ProjectWiseList
    {
        public RrProjectMonths ProjectMonth { get; set; }

    }

    public class Rr_ResourceWiseList
    {
        public RrResourcetMonths ResourceMonth { get; set; }

    }

    public class RrResourcetMonths : Rr_Months
    {
        public int ResourceId { get; set; }
        public string ResourceName { get; set; }
        public List<RrResourcMonths> RrRList { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }


    public class ResourceUtilizationFilter
    {       
        public string RUWhereClause { get; set; }
        public string ReportFormat { get; set; }
        public string ReportTab { get; set; }
        public string YearPrevNext { get; set; }
        public string TimeLine { get; set; }
        public string ReportIn { get; set; }
        public int UserId { get; set; }
        public string Year { get; set; }
        public string ReportInStr { get; set; }
        public int BusinessGroupID  { get; set; }
        public int OrganizationUnitID { get; set; }
        public int DeliveryUnitID  { get; set; }
        public int DeliveryTeamID  { get; set; }
        public string ResourceName { get; set; }
	   //Added by imran 12-10-2021
        public int PageNo { get; set; }
        public int PageSize { get; set; }
        //End by imran 12-10-2021
     }

    public class ResourceUtilizationsFilter 
    {
        public string ReportName { get; set; }
        public string StrSql { get; set; }
        public bool IsNextHalfYear { get; set; } = false;

    }


    public class ObjRr_ResourceProjectwisemonth
    {
       // public List<Rr_ProjectWiseListHalfYear> RrProjectListhalfyear { get; set; } //used in case of by project
        public RrResourcMonths RrProjectLitForTotalSummonth { get; set; }
        public List<string> columnNames { get; set; }
        public List<Rr_ResourceWiseList> RrResourceListmonth { get; set; } //used in case of by resource


    }

    #endregion

    #region ProjectResourceWiseHalfYear

    public class RrProjectHalfYear : Rr_HalfYear
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public List<RrResourcHalfYear> RrResourceList { get; set; }
     
    }

    public class RrResourcHalfYear : Rr_HalfYear
    {
        public int ResourceId { get; set; }
        public int ProjectId { get; set; }
        public string ResourceName { get; set; }
        public string ProjectName { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_HalfYear
    {
        public Decimal Month_1 { get; set; }
        public Decimal Month_2 { get; set; }
        public Decimal Month_3 { get; set; }
        public Decimal Month_4 { get; set; }
        public Decimal Month_5 { get; set; }
        public Decimal Month_6 { get; set; }
      

        public Decimal Month_Ah1 { get; set; }
        public Decimal Month_Ah2 { get; set; }
        public Decimal Month_Ah3 { get; set; }
        public Decimal Month_Ah4 { get; set; }
        public Decimal Month_Ah5 { get; set; }
        public Decimal Month_Ah6 { get; set; }
      
    }

    public class Rr_ProjectWiseListHalfYear
    {
        public RrProjectHalfYear ProjectHalfYear { get; set; }

    }

    public class ObjRr_Projectwisehalfyear
    {
       public List<Rr_ProjectWiseListHalfYear> RrProjectListhalfyear { get; set; } //used in case of by project
        public RrResourcHalfYear RrProjectLitForTotalSumhalfyear { get; set; }
        public List<string> columnNames { get; set; }
        public List<Rr_ResourceWiseListHalfYear> RrResourceListhalfyear { get; set; } //used in case of by resource


    }


    //for halfyear by resource
    public class RrByResourctHalfYear : Rr_HalfYear
    {
        public int ResourceId { get; set; }
        public string ResourceName { get; set; }
        public List<RrResourcHalfYear> RrProjectList { get; set; }

        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_ResourceWiseListHalfYear
    {
        public RrByResourctHalfYear ResourceHalfYear { get; set; }

    }





    #endregion

    #region ProjectResourceWiseQuarter

    public class RrProjectQuarter : Rr_Quarter
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public List<RrResourcQuarter> RrResourceList { get; set; }

    }

    public class RrResourcQuarter : Rr_Quarter
    {
        public int ResourceId { get; set; }
        public int ProjectId { get; set; }
        public string ResourceName { get; set; }
        public string ProjectName { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_Quarter
    {
        public Decimal Q1 { get; set; }
        public Decimal Q2 { get; set; }
        public Decimal Q3 { get; set; }
        public Decimal Q4 { get; set; }

        public Decimal Q1_Ah { get; set; }
        public Decimal Q2_Ah { get; set; }
        public Decimal Q3_Ah { get; set; }
        public Decimal Q4_Ah { get; set; }

    }

    public class Rr_ProjectWiseListQuarter
    {
        public RrProjectQuarter ProjectQuarter { get; set; }

    }

    public class ObjRr_ProjectwiseQuarter
    {
        public List<Rr_ProjectWiseListQuarter> RrProjectListQuarter  { get; set; } //used in case of by project
        public RrResourcQuarter RrProjectLitForTotalSumQuarter { get; set; }
        public List<string> columnNames { get; set; }
        public List<Rr_ResourceWiseListQuarter> RrResourceListQuarter { get; set; } //used in case of by resource


    }


    //for halfyear by resource
    public class RrByResourctQuarter : Rr_Quarter
    {
        public int ResourceId { get; set; }
        public string ResourceName { get; set; }
        public List<RrResourcQuarter> RrProjectList { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_ResourceWiseListQuarter
    {
        public RrByResourctQuarter ResourceQuarter { get; set; }
    }





    #endregion

    #region ProjectResourceWiseWeek

    public class RrProjectWeek : Rr_Week
    {
        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public List<RrResourcWeek> RrResourceList { get; set; }

    }

    public class RrResourcWeek : Rr_Week
    {
        public int ResourceId { get; set; }
        public int ProjectId { get; set; }
        public string ResourceName { get; set; }
        public string ProjectName { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_Week
    {
        public Decimal W1 { get; set; }
        public Decimal W2 { get; set; }
        public Decimal W3 { get; set; }
        public Decimal W4 { get; set; }
        public Decimal W5 { get; set; }
        public Decimal W6 { get; set; }
        public Decimal W7 { get; set; }
        public Decimal W8 { get; set; }
        public Decimal W9 { get; set; }
        public Decimal W10 { get; set; }
        public Decimal W11 { get; set; }
        public Decimal W12 { get; set; }
        public Decimal W13 { get; set; }
        public Decimal W14 { get; set; }
        public Decimal W15 { get; set; }
        public Decimal W16 { get; set; }
        public Decimal W17 { get; set; }
        public Decimal W18 { get; set; }
        public Decimal W19 { get; set; }
        public Decimal W20 { get; set; }
        public Decimal W21 { get; set; }
        public Decimal W22 { get; set; }
        public Decimal W23 { get; set; }
        public Decimal W24 { get; set; }
        public Decimal W25 { get; set; }
        public Decimal W26 { get; set; }
        public Decimal W27 { get; set; }
        public Decimal W28 { get; set; }
        public Decimal W29 { get; set; }
        public Decimal W30 { get; set; }
        public Decimal W31 { get; set; }
        public Decimal W32 { get; set; }
        public Decimal W33 { get; set; }
        public Decimal W34 { get; set; }
        public Decimal W35 { get; set; }
        public Decimal W36 { get; set; }
        public Decimal W37 { get; set; }
        public Decimal W38 { get; set; }
        public Decimal W39 { get; set; }
        public Decimal W40 { get; set; }
        public Decimal W41 { get; set; }
        public Decimal W42 { get; set; }
        public Decimal W43 { get; set; }
        public Decimal W44 { get; set; }
        public Decimal W45 { get; set; }
        public Decimal W46 { get; set; }
        public Decimal W47 { get; set; }
        public Decimal W48 { get; set; }
        public Decimal W49 { get; set; }
        public Decimal W50 { get; set; }
        public Decimal W51 { get; set; }
        public Decimal W52 { get; set; }
        public Decimal W53 { get; set; }

        public Decimal W1_Ah { get; set; }
        public Decimal W2_Ah { get; set; }
        public Decimal W3_Ah { get; set; }
        public Decimal W4_Ah { get; set; }
        public Decimal W5_Ah { get; set; }
        public Decimal W6_Ah { get; set; }
        public Decimal W7_Ah { get; set; }
        public Decimal W8_Ah { get; set; }
        public Decimal W9_Ah { get; set; }
        public Decimal W10_Ah { get; set; }
        public Decimal W11_Ah { get; set; }
        public Decimal W12_Ah { get; set; }
        public Decimal W13_Ah { get; set; }
        public Decimal W14_Ah { get; set; }
        public Decimal W15_Ah { get; set; }
        public Decimal W16_Ah { get; set; }
        public Decimal W17_Ah { get; set; }
        public Decimal W18_Ah { get; set; }
        public Decimal W19_Ah { get; set; }
        public Decimal W20_Ah { get; set; }
        public Decimal W21_Ah { get; set; }
        public Decimal W22_Ah { get; set; }
        public Decimal W23_Ah { get; set; }
        public Decimal W24_Ah { get; set; }
        public Decimal W25_Ah { get; set; }
        public Decimal W26_Ah { get; set; }
        public Decimal W27_Ah { get; set; }
        public Decimal W28_Ah { get; set; }
        public Decimal W29_Ah { get; set; }
        public Decimal W30_Ah { get; set; }
        public Decimal W31_Ah { get; set; }
        public Decimal W32_Ah { get; set; }
        public Decimal W33_Ah { get; set; }
        public Decimal W34_Ah { get; set; }
        public Decimal W35_Ah { get; set; }
        public Decimal W36_Ah { get; set; }
        public Decimal W37_Ah { get; set; }
        public Decimal W38_Ah { get; set; }
        public Decimal W39_Ah { get; set; }
        public Decimal W40_Ah { get; set; }
        public Decimal W41_Ah { get; set; }
        public Decimal W42_Ah { get; set; }
        public Decimal W43_Ah { get; set; }
        public Decimal W44_Ah { get; set; }
        public Decimal W45_Ah { get; set; }
        public Decimal W46_Ah { get; set; }
        public Decimal W47_Ah { get; set; }
        public Decimal W48_Ah { get; set; }
        public Decimal W49_Ah { get; set; }
        public Decimal W50_Ah { get; set; }
        public Decimal W51_Ah { get; set; }
        public Decimal W52_Ah { get; set; }
        public Decimal W53_Ah { get; set; }
    }

    public class Rr_ProjectWiseListWeek
    {
        public RrProjectWeek ProjectWeek { get; set; }

    }

    public class ObjRr_ProjectwiseWeek
    {
        public List<Rr_ProjectWiseListWeek> RrProjectListWeek { get; set; } //used in case of by project
        public RrResourcWeek RrProjectLitForTotalSumWeek { get; set; }
        public List<string> columnNames { get; set; }
        public List<Rr_ResourceWiseListWeek> RrResourceListWeek { get; set; } //used in case of by resource


    }


    //for halfyear by resource
    public class RrByResourctWeek : Rr_Week
    {
        public int ResourceId { get; set; }
        public string ResourceName { get; set; }
        public List<RrResourcWeek> RrProjectList { get; set; }
        public string ProfilePicURL { get; set; }
        public string Designation { get; set; }
    }

    public class Rr_ResourceWiseListWeek
    {
        public RrByResourctWeek ResourceWeek { get; set; }
    }





    #endregion

}
