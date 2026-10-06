using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.PM
{
    public class PM_CheckList
    {
        public PM_CheckList() {
            DeletedResult = new List<string>();
        }
        public int ProjectId { get; set; }

        //Comment And Added By Riddhesh Patil on 21st March 2023
        //public int [] QuestionnaireIDs { get; set; }
        public string QuestionnaireIDs { get; set; }
        //End of Comment And Added By Riddhesh Patil on 21st March 2023
        public DataTable WorkOrderCheckList { get; set; }
        public int OldProjectCheckListID { get; set; }
        public string CheckListShortName { get; set; }
        public string CheckListItemName { get; set; }

        //Comment And Added By Riddhesh Patil on 21st March 2023
        //public string[] CheckListShortNames { get; set; }
        // public int [] UniqueIDs { get; set; }
        public string CheckListShortNames { get; set; }
        public string UniqueIDs { get; set; }
        //End of Comment And Added By Riddhesh Patil on 21st March 2023
        public int [] unDeleted { get; set; }
        public int RevisionNo { get; set; }
        public int ProjectCheckListId { get; set; }
        public string Revisiondate { get; set; }
        public string Reason { get; set; }
        public int RevisedBy { get; set; }
        public int ApprovedBy { get; set; }
        public int RevisionID { get; set; }
        public int ProjectCheckListItemID { get; set; }
        public int [] ProjectCheckListItemIDs { get; set; }
        public int AnswerSetID { get; set; }
        public int CatagoryId { get; set; }
        public int AnswerSetId { get; set; }
       
        public DataTable WorkOrderCheckListItem { get; set; }
        public DataTable ProjectCategory { get; set; }
        public DataTable AnswerSet { get; set; }
        public DataTable tbl_Q_Answer { get; set; }
       public List<string> DeletedResult { get; set; }
        //public bool IsActive { get; set; }
        public int IsActive { get; set; }
        //public bool Compulsory { get; set; }
        public int Compulsory { get; set; }

        //added by omkar 09/01/2020
        public DataTable WorkOrderCheckListSection { get; set; }
        public string Description { get; set; }
        public string CategoryCode { get; set; }
        public int OrderNo { get; set; }
        public int ProjectCategoryID { get; set; }
        public int[] ProjectCategoryIDs { get; set; }
        //end of added by omkar 09/01/2020

    }

    //Added By Dipali V On 8th April 2023 For Crash ISsue
    public class PM_CheckList_New {
        public string ProjectCategoryIDs { get; set; }
        public string ProjectCheckListItemIDs { get; set; }

    }
    //End of Added By Dipali V On 8th April 2023 For Crash ISsue
}
