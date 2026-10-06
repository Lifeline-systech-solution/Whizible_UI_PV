using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RR_ForeCastingReport
    {
        public int intUserID { get; set; }
        public int RoleID { get; set; }
        public string ReportFormat { get; set; }
        public string ByWeekOrMonth { get; set; }
        
    }
    public class ForeCastMothWeek:ForeCast_Months
    {
        public string ResourceName { get; set; }
    }

    public class ForeCast_Months
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

        public Decimal Month_Ph1 { get; set; }
        public Decimal Month_Ph2 { get; set; }
        public Decimal Month_Ph3 { get; set; }
        public Decimal Month_Ph4 { get; set; }
        public Decimal Month_Ph5 { get; set; }
        public Decimal Month_Ph6 { get; set; }
        public Decimal Month_Ph7 { get; set; }
        public Decimal Month_Ph8 { get; set; }
        public Decimal Month_Ph9 { get; set; }
        public Decimal Month_Ph10 { get; set; }
        public Decimal Month_Ph11 { get; set; }
        public Decimal Month_Ph12 { get; set; }
    }                     
    public class RR_ForeCastingWeek
    {
        public string ResourceName { get; set; }
        public string ReportPeriod { get; set; }
        public double W1 { get; set; }
        public double W2 { get; set; }
        public double W3 { get; set; }
        public double W4 { get; set; }
        public double W5 { get; set; }
        public double W6 { get; set; }
        public double W7 { get; set; }
        public double W8 { get; set; }
        public double W9 { get; set; }
        public double W10 { get; set; }
        public double W11 { get; set; }
        public double W12 { get; set; }
        public double W13 { get; set; }
        public double W14 { get; set; }
        public double W15 { get; set; }
        public double W16 { get; set; }
        public double W17 { get; set; }
        public double W18 { get; set; }
        public double W19 { get; set; }
        public double W20 { get; set; }
        public double W21 { get; set; }
        public double W22 { get; set; }
        public double W23 { get; set; }
        public double W24 { get; set; }
        public double W25 { get; set; }
        public double W26 { get; set; }
        public double W27 { get; set; }
        public double W28 { get; set; }
        public double W29 { get; set; }
        public double W30 { get; set; }
        public double W31 { get; set; }
        public double W32 { get; set; }
        public double W33 { get; set; }
        public double W34 { get; set; }
        public double W35 { get; set; }
        public double W36 { get; set; }
        public double W37 { get; set; }
        public double W38 { get; set; }
        public double W39 { get; set; }
        public double W40 { get; set; }
        public double W41 { get; set; }
        public double W42 { get; set; }
        public double W43 { get; set; }
        public double W44 { get; set; }
        public double W45 { get; set; }
        public double W46 { get; set; }
        public double W47 { get; set; }
        public double W48 { get; set; }
        public double W49 { get; set; }
        public double W50 { get; set; }
        public double W51 { get; set; }
        public double W52 { get; set; }
        public double W53 { get; set; }
              
        public double W1_Ah { get; set; }
        public double W2_Ah { get; set; }
        public double W3_Ah { get; set; }
        public double W4_Ah { get; set; }
        public double W5_Ah { get; set; }
        public double W6_Ah { get; set; }
        public double W7_Ah { get; set; }
        public double W8_Ah { get; set; }
        public double W9_Ah { get; set; }
        public double W10_Ah { get; set; }
        public double W11_Ah { get; set; }
        public double W12_Ah { get; set; }
        public double W13_Ah { get; set; }
        public double W14_Ah { get; set; }
        public double W15_Ah { get; set; }
        public double W16_Ah { get; set; }
        public double W17_Ah { get; set; }
        public double W18_Ah { get; set; }
        public double W19_Ah { get; set; }
        public double W20_Ah { get; set; }
        public double W21_Ah { get; set; }
        public double W22_Ah { get; set; }
        public double W23_Ah { get; set; }
        public double W24_Ah { get; set; }
        public double W25_Ah { get; set; }
        public double W26_Ah { get; set; }
        public double W27_Ah { get; set; }
        public double W28_Ah { get; set; }
        public double W29_Ah { get; set; }
        public double W30_Ah { get; set; }
        public double W31_Ah { get; set; }
        public double W32_Ah { get; set; }
        public double W33_Ah { get; set; }
        public double W34_Ah { get; set; }
        public double W35_Ah { get; set; }
        public double W36_Ah { get; set; }
        public double W37_Ah { get; set; }
        public double W38_Ah { get; set; }
        public double W39_Ah { get; set; }
        public double W40_Ah { get; set; }
        public double W41_Ah { get; set; }
        public double W42_Ah { get; set; }
        public double W43_Ah { get; set; }
        public double W44_Ah { get; set; }
        public double W45_Ah { get; set; }
        public double W46_Ah { get; set; }
        public double W47_Ah { get; set; }
        public double W48_Ah { get; set; }
        public double W49_Ah { get; set; }
        public double W50_Ah { get; set; }
        public double W51_Ah { get; set; }
        public double W52_Ah { get; set; }
        public double W53_Ah { get; set; }
    }

    public class RR_ForeCastingMonth
    {
        public string ResourceName { get; set; }
      //  public string ReportPeriod { get; set; }

        public double January { get; set; }
        public double February { get; set; }
        public double March { get; set; }
        public double April { get; set; }
        public double May { get; set; }
        public double June { get; set; }
        public double July { get; set; }
        public double August { get; set; }
        public double September { get; set; }
        public double October { get; set; }
        public double November { get; set; }
        public double December { get; set; }
        public double January_Ph { get; set; }
        public double February_Ph { get; set; }
        public double March_Ph { get; set; }
        public double April_Ph { get; set; }
        public double May_Ph { get; set; }
        public double June_Ph { get; set; }
        public double July_Ph { get; set; }
        public double August_Ph { get; set; }
        public double September_Ph { get; set; }
        public double October_Ph { get; set; }
        public double November_Ph { get; set; }
        public double December_Ph { get; set; }

    }
}