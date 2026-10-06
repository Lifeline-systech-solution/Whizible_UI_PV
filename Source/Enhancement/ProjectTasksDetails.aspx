<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectTasksDetails.aspx.vb" Inherits="PbNIT.ProjectTasksDetails" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<% CommonFunctions.General.PlotPageHeadTag("Task Details")%>

<head runat="server">
    <title>Recruiter Assignment</title>
    <style>
		    #divList
		    {
		        height:180px !important;
		    }
		</style>
</head>
<body>
    <form id="frmInherit_BillingCalendarDetails" runat="server">
        <%PageInit%>	
    </form>
    
    <script language= "javascript" type="text/javascript" >
    var objform = GetFormReference('frmInherit_BillingCalendarDetails');
    var objDivMain=GetObjectReference('frmInherit_BillingCalendarDetails','divList');
    
//    var objRecruiterFilterID = GetObjectReference('frmRecruiterAssignment','cboFilter_RecruiterID');
//    var objBGFilterID = GetObjectReference('frmRecruiterAssignment','cboFilter_BusinessGroupID');
//    var objHMFilterID = GetObjectReference('frmRecruiterAssignment','cboFilter_HiringManagerID');
    
    //var objRC = GetObjectReference('','txtHidRC');
   	var dblIncrementMinutes;    		
    dblIncrementMinutes = 0.25; 
        //Code Added By Bharat Tekade On 25th-May-2015
    var objAssignedOn = GetObjectReference('frmInherit_BillingCalendarDetails','txtStartDate');
     var objEndDate = GetObjectReference('frmInherit_BillingCalendarDetails','txtEndDate');
        //Code Ended By Bharat Tekade On 25th-May-2015
     var objchkSelect = GetObjectReference('frmDrillDownSettings','chkSelect',true)
  
   

      function ModifiedBy_OnChange(intAction)
      {
                var objModifiedField = GetObjectReference('frmInherit_BillingCalendarDetails','cboFilter_ModifiedField');
                var objModifiedBy = GetObjectReference('frmInherit_BillingCalendarDetails','cboFilter_ModifiedBy');
                var objUnique = '<%=m_strUniqueID %>';
                var objProjectCapDetailUniqueID = '<%=intUniqueID %>';
                var objProjectID = '<%=m_intProjectID %>';
                var objBillingCalendarID = '<%=BillingCalendarID %>';
                var objCustomerID = '<%=CustomerID %>';
                
                if (intAction == 'CAPHISTORY')
                {
                    if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"";             
       		            objform.submit();
			        }
			    }
			    else if(intAction == 'INHERITCAP')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&ProjCustomerCapDetailsID_PK="+objProjectCapDetailUniqueID+"";             
       		            objform.submit();
			        }
			    }
			    else  if(intAction == 'INHERITMASTER')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&CustomerID="+objCustomerID+"&BillingCalendarID="+objBillingCalendarID+"";             
       		            objform.submit();
			        }
			    }
			     else  if(intAction == 'CUSTOMERHOLIDAYS')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"";             
       		            objform.submit();
			        }
			    }
			    //bharat on 21st-Nov-2015
			    else  if(intAction == 'PROJECT_TIMESHEET')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"&TimesheetNo=<%=m_TimeSheetNo %>";             
       		            objform.submit();
			        }
			    }
			    //bharat on 21st-Nov-2015
			    else
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "EntityDetails_History.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"";             
       		            objform.submit();
			        }
			    }
			     
        }
       function ModifiedField_OnChange(intAction)
       {
                var objModifiedField = GetObjectReference('frmInherit_BillingCalendarDetails','cboFilter_ModifiedField');
                var objModifiedBy = GetObjectReference('frmInherit_BillingCalendarDetails','cboFilter_ModifiedBy');
                var objUnique = '<%=m_strUniqueID %>';
                var objProjectCapDetailUniqueID = '<%=intUniqueID %>';
                var objProjectID = '<%=m_intProjectID %>';
                var objBillingCalendarID = '<%=BillingCalendarID %>';
                var objCustomerID = '<%=CustomerID %>';
                
                if (intAction == 'CAPHISTORY')
                {
                    if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedField&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"";             
       		            objform.submit();
			        }
			    }
			    else
			    if (intAction == 'INHERITCAP')
			    {
			     if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedField&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&ProjCustomerCapDetailsID_PK="+objProjectCapDetailUniqueID+"";             
       		            objform.submit();
			        }
			    }
			    else
			    if (intAction == 'INHERITMASTER')
			    {
			     if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedField&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&CustomerID="+objCustomerID+"&BillingCalendarID="+objBillingCalendarID+"";             
       		            objform.submit();
			        }
			    }
			     else  if(intAction == 'CUSTOMERHOLIDAYS')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"";             
       		            objform.submit();
			        }
			    }
			    //bharat on 21st-Nov-2015
			    else  if(intAction == 'PROJECT_TIMESHEET')
			    {
			        if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "Inherit_BillingCalendarDetails.aspx?Mode=ModifiedBy&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"&UniqueID="+objUnique+"&TimesheetNo=<%=m_TimeSheetNo %>";             
       		            objform.submit();
			        }
			    }
			    //bharat on 21st-Nov-2015
			    else
			    {
			     if(objModifiedField != null && objModifiedBy!=null)
                    {
                        objform.action = "EntityDetails_History.aspx?Mode=ModifiedField&Action="+ intAction +"&ModifiedField="+objModifiedField.value+"&ModifiedBy="+objModifiedBy.value+"";             
       		            objform.submit();
			        }
			    }
			     
      }

     function Save_OnClick(m_intProjectID)
	{//debugger;
		 if(Validate() == false)
                    return;
		var objform=GetFormReference('frmInherit_BillingCalendarDetails');
			
		objform.action='../Quinnox2015/Inherit_BillingCalendarDetails.aspx?ProjectID='+m_intProjectID+'&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SAVE';
		objform.submit();
		//window.location.reload();
		//window.location.href=window.location.href;
	}
  

  function Close_OnClick()
        { 
           
            window.close();
        }
 function Validate()
       {
        var objCapValue = GetObjectReference('','txtCapValue');
        var objCapPeriod = GetObjectReference('','cboCapPeriodID');
        var objCapUnit = GetObjectReference('','cboCapUnitID');
        var objBillingCalendarID = GetObjectReference('','txtBillingCalendarID');//txtBillingCalendarID
        
         if(disallowNonNumeric(objCapValue,"Cap Value should be numeric only !",true))
	                       return false;    
	      if (objBillingCalendarID != null)
          {                                
                 if (disallowBlank(objBillingCalendarID,"Please map the billing calendar at the customer master!"))
                 {
                        return false;
                 }                            
                            
           }  
          if (objCapValue != null)
          {                                
                 if (disallowBlank(objCapValue,"Please enter the cap value!"))
                 {
                        return false;
                 }                            
                            
           }  
          if (objCapPeriod != null)
          {                                
                 if (disallowBlank(objCapPeriod,"Please enter the Cap period!"))
                 {
                        return false;
                 }                            
                            
           }  
          if (objCapUnit != null)
          {                                
                 if (disallowBlank(objCapUnit,"Please enter the cap unit!"))
                 {
                        return false;
                 }                            
                            
           }  
 }
 //Added By Bharat Tekade on 05th-May-2016 for OS changes
 function TaskName_OnClick(TaskID, PKToken) {     
            window.open("../PM/PM_TaskAssignment.aspx?TaskId=" + TaskID + "&Mode=Edit&MasterTagID=1038&PkToken=" + PKToken + "&From=OSTaskDetails", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=700,height=600");
 }
 function ClearAll_OnClick() {
     var LoopCtr;
     var TotalRows = objchkSelect.length;

             if (TotalRows == 0) { alert("There are no attributes to clear"); return; }
             else if (TotalRows == 1) {
                 objchkSelect[0].checked = false;
             }
             else {
                 for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
                 {
                     if (objchkSelect[LoopCtr].disabled != true)
                        objchkSelect[LoopCtr].checked = false;
                 }
             }     
 }
 function SelectAll_OnClick() {
     var LoopCtr;
     var TotalRows = objchkSelect.length;

     if (TotalRows == 0) { alert("There are no attributes to select"); return; }
     else if (TotalRows == 1) {
         objchkSelect[0].checked = true;
     }
     else {
         for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
         {
             if (objchkSelect[LoopCtr].disabled != true)
                objchkSelect[LoopCtr].checked = true;
         }
     }
     
 }
 function SetBaseline_OnClick()
 {
     var LoopCtr;
     var TotalRows = objchkSelect.length;
     var flag = false;
    
     for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
     {
         if(objchkSelect[LoopCtr].checked == true)
         {
             flag = true;
             break;
         }
         else
         {
             flag = false;
         }
     }
     if(flag != true)
     {
         alert("Please select at least one task!");
         return;
     }

     var OverallScheduleID = <%=intOverallScheduleID%>; 
     objform.action = "../Enhancement/ProjectTasksDetails.aspx?Action=SETBASELINE&FromWhere=PM&OverallScheduleID=" + OverallScheduleID + "";
     objform.submit();
 }
 function CloseTasks_OnClick()
 {
     var TotalRows = objchkSelect.length;
     var LoopCtr;
     var flag = false;

     for (LoopCtr = 0; LoopCtr < TotalRows; LoopCtr++)
     {
         if(objchkSelect[LoopCtr].checked == true)
         {
             flag = true;
             break;
         }
         else
         {
             flag = false;
         }
     }
     if(flag != true)
     {
         alert("Please select at least one task!");
         return;
     }
     var OverallScheduleID = <%=intOverallScheduleID%>
     objform.action = "../Enhancement/ProjectTasksDetails.aspx?Action=CLOSETASK&FromWhere=PM&OverallScheduleID=" + OverallScheduleID + "";
     objform.submit();
 }
 function cboTasksChange(obj)
 {     
     var OverallScheduleID = <%=intOverallScheduleID%>;     
     objform.action = "../Enhancement/ProjectTasksDetails.aspx?Action=TASKDETAILS&FromWhere=PM&OverallScheduleID=" + OverallScheduleID + "&WhichTask=" + obj.value + "";
     objform.submit();
 }
//End of Added By Bharat Tekade on 05th-May-2016 for OS changes
    </script>
</body>
</html>
;