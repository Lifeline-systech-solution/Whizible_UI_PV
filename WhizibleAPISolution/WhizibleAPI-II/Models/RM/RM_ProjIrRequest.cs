using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.RM
{
    public class RM_ProjIrRequest
    {
        public int InfraRequestId { get; set; }
        public int InfraResourceId { get; set; }
        public int RequestedUserId { get; set; }
        public int ProjectId { get; set; }
        public Decimal Quantity { get; set; }
        //commented and added by imran on 23-08-2022 Action filter validate getting error
        //public DateTime StartDate { get; set; }
        //public DateTime EndDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        //End of comment by imran on 23-08-2022
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public string Status { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatdDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public DateTime RequestedDate { get; set; }
        public string RequestedBy { get; set; }
        public int AllocatedQuantity { get; set; }
        public DateTime? AllocatedDate { get; set; }
        public string Comments { get; set; }
        public string Approvalby { get; set; }
        public DateTime? ApprovalDate { get; set; }
        public string AlloctedBy { get; set; }
        public string IsUpdate { get; set; }
    }

    public class RM_IrProjectStartEndDate
    {
        public DateTime ProjectStartDate { get; set; }
        public DateTime ProjectEndDate { get; set; }
    }

    public class RM_IrProjectAllocation
    {
        ///// <summary>
        ///// Total resource count
        ///// </summary>
        //public int TotalResources { get; set; }  will show the list length
        public int InfraResourceId { get; set; }
        public string ResourceName { get; set; }
        public int MaxAllocationPerDay { get; set; } 
        /// <summary>
        /// allocated count 
        /// </summary>
        public int TotalQuantityForMonth { get; set; }
        public int TotalAllocatedQuantityForallProject { get; set; }

        public int TotalAllocatedQuantityForProject { get; set; }
        public string DayName { get; set; }
        public int DayValue { get; set; }
        public DateTime MontDate { get; set; }
        public string MonthName  { get; set; }
        public int AvailableCount { get; set; }
        private int _AvailableCount;
        //public int AvailableCount
        //{
        //    get
        //    {
        //        this._AvailableCount =  TotalQuantityForMonth-TotalAllocatedQuantityForProject  ;
        //        //this._AvailableCount = TotalQuantityForMonth - TotalAllocatedQuantityForallProject;
        //        return this._AvailableCount>0 ? this._AvailableCount : 0;
        //    }
        //    set
        //    {
        //        this._AvailableCount = value;
        //    }
        //}


        #region DayName
        public long Day_1 { get; set; }
        public long Day_2 { get; set; }

        public long Day_3 { get; set; }

        public long Day_4 { get; set; }

        public long Day_5 { get; set; }

        public long Day_6 { get; set; }
        public long Day_7 { get; set; }
        public long Day_8 { get; set; }
        public long Day_9 { get; set; }
        public long Day_10 { get; set; }
        public long Day_11 { get; set; }
        public long Day_12 { get; set; }
        public long Day_13 { get; set; }
        public long Day_14 { get; set; }
        public long Day_15 { get; set; }
        public long Day_16 { get; set; }
        public long Day_17 { get; set; }
        public long Day_18 { get; set; }
        public long Day_19 { get; set; }
        public long Day_20 { get; set; }
        public long Day_21 { get; set; }
        public long Day_22 { get; set; }

        public long Day_23 { get; set; }
        public long Day_24 { get; set; }
        public long Day_25 { get; set; }

        public long Day_26 { get; set; }
        public long Day_27 { get; set; }
        public long Day_28 { get; set; }

        public long Day_29 { get; set; }
        public long Day_30 { get; set; }
        public long Day_31 { get; set; }

        #endregion


        #region ClassName for daya to check booking 
        public string ClDay_1 { get; set; }
        public string ClDay_2 { get; set; }

        public string ClDay_3 { get; set; }

        public string ClDay_4 { get; set; }

        public string ClDay_5 { get; set; }

        public string ClDay_6 { get; set; }
        public string ClDay_7 { get; set; }
        public string ClDay_8 { get; set; }
        public string ClDay_9 { get; set; }
        public string ClDay_10 { get; set; }
        public string ClDay_11 { get; set; }
        public string ClDay_12 { get; set; }
        public string ClDay_13 { get; set; }
        public string ClDay_14 { get; set; }
        public string ClDay_15 { get; set; }
        public string ClDay_16 { get; set; }
        public string ClDay_17 { get; set; }
        public string ClDay_18 { get; set; }
        public string ClDay_19 { get; set; }
        public string ClDay_20 { get; set; }
        public string ClDay_21 { get; set; }
        public string ClDay_22 { get; set; }

        public string ClDay_23 { get; set; }
        public string ClDay_24 { get; set; }
        public string ClDay_25 { get; set; }

        public string ClDay_26 { get; set; }
        public string ClDay_27 { get; set; }
        public string ClDay_28 { get; set; }

        public string ClDay_29 { get; set; }
        public string ClDay_30 { get; set; }
        public string ClDay_31 { get; set; }

        #endregion

        DayOfWeek _day;
        public DayOfWeek Day
        {
            get
            {
                // We don't allow this to be used on Friday.
                if (this._day == DayOfWeek.Friday)
                {
                    throw new Exception("Invalid access");
                }
                return this._day;
            }
            set
            {
                this._day = value;
            }
        }


        #region All allocated count


        public long GDay_1 { get; set; }
        public long GDay_2 { get; set; }

        public long GDay_3 { get; set; }

        public long GDay_4 { get; set; }

        public long GDay_5 { get; set; }

        public long GDay_6 { get; set; }
        public long GDay_7 { get; set; }
        public long GDay_8 { get; set; }
        public long GDay_9 { get; set; }
        public long GDay_10 { get; set; }
        public long GDay_11 { get; set; }
        public long GDay_12 { get; set; }
        public long GDay_13 { get; set; }
        public long GDay_14 { get; set; }
        public long GDay_15 { get; set; }
        public long GDay_16 { get; set; }
        public long GDay_17 { get; set; }
        public long GDay_18 { get; set; }
        public long GDay_19 { get; set; }
        public long GDay_20 { get; set; }
        public long GDay_21 { get; set; }
        public long GDay_22 { get; set; }
        public long GDay_23 { get; set; }
        public long GDay_24 { get; set; }
        public long GDay_25 { get; set; }
        public long GDay_26 { get; set; }
        public long GDay_27 { get; set; }
        public long GDay_28 { get; set; }
        public long GDay_29 { get; set; }
        public long GDay_30 { get; set; }
        public long GDay_31 { get; set; }

        #endregion

    }


    public class RM_IrAvailability : RM_IrProjectAllocation
    {
    }
    public class RM_IrParmas
    {
        public int ProjectId { get; set; }
        public string CurrentDate { get; set; }
        public  string  CurrentMonth { get; set; }
        public bool IsNext { get; set; }
    }


    public class RM_InfraRequestUpdateResource : RM_InfraRequestUpdateStatus
    {
        public int ProjectId { get; set; }
    }
    public class InOutDateFormats
    {
        public string InputDateFormat { get; set; }
        public string OutDateFormat { get; set; }
    }

}