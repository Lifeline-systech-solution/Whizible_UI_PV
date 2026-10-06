using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WhizibleAPI.Models.TaskMapping
{
    public class ExecuteInputParameters
    {
        public string Mode { get; set; }
        public int ProjectID { get; set; }
        public string SelectedValue { get; set; }
        public string Execute { get; set; }
        public string WhereClause { get; set; }
        public string Alphabet { get; set; }
        public string ColumnName { get; set; }
        public string OrderBy { get; set; }
        public string SortOrder { get; set; }
    }
}