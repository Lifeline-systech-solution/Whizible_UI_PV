using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_ReviewType
    {
        public int PReviewTypeID { get; set; }
        public string PReviewType { get; set; }
        public int CReviewTypeID { get; set; }
        public string CReviewType { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
        public List<ReviewTypeCauses> listReviewTypeCauses = new List<ReviewTypeCauses>();
    }
    public class PM_ReviewTypeParameter
    {
        public int PReviewTypeID { get; set; }
        public int ProjectID { get; set; }
    }

    public class DeleteReviewTypeParameter
    {
        public int PReviewTypeID { get; set; }
        public int ProjectID { get; set; }
        public string Result { get; set; }
    }

    public class ReviewTypeCauses
    {
        public int PReviewCauseID { get; set; }
        public string PReviewCause { get; set; }
        public int CReviewCauseID { get; set; }
        public string CReviewCause { get; set; }
        public int PReviewTypeID { get; set; }
        public int ProjectID { get; set; }
        public string CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime ModifiedDate { get; set; }
    }

    public class ReviewTypeCausesParameter
    {
        public int PReviewTypeID { get; set; }
        public int ProjectID { get; set; }
    }

    public class DeleteReviewCausesParameter
    {
        public int PReviewCauseID { get; set; }
        public string Result { get; set; }
    }

    public class MappedCorporateReviewTypes
    {
        public int CReviewTypeID { get; set; }
        public string CReviewType { get; set; }
    }

    public class MappedCorporateReviewTypeParameter
    {
        public int ProjectID { get; set; }
        public int CReviewTypeID { get; set; }
        public string CReviewType { get; set; }
    }

    public class MappedCorporateReviewCause
    {
        public int CReviewCauseID { get; set; }
        public string CReviewCause { get; set; }
    }

    public class MappedCorporateReviewCauseParameter
    {
        public int ProjectID { get; set; }
        public int PReviewTypeID { get; set; }
    }
}