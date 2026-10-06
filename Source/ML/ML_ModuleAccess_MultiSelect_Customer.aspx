<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ML_ModuleAccess_MultiSelect_Customer.aspx.vb" Inherits="PbNIT.ML_ModuleAccess_MultiSelect_Customer" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%  CommonFunctions.General.PlotPageHeadTag("Module Access")%>
	 <body MS_POSITIONING="GridLayout" class="clsBody" onresize=window_onresize() onload=window_onload() >
		<form id="frmMultiselectCustomer" method="post" runat="server">
		<%PageInit%>
		</form>
		
		<script>
		objform=GetFormReference('frmMultiselectCustomer');
		objDivMain=GetObjectReference('frmMultiselectCustomer','DivList');
		//objDivGrid=GetObjectReference('frmMultiselectCustomer','DivGrid');
		function window_onload()		
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			if(objDivMain != null)
			{ 
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objDivMain.offsetTop - 45;
			 }
			 else
			 {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
				}
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight	;
			}
			<%if m_strScript<>""%>
		<%=m_strScript%>
		<%end if%>
			
		}
		/*--------------------------------------------------------------------------------------------------------*/
		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objDivMain.offsetTop - 45;
			 }
			 else
			 {
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
			 }
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight	;
				//objDivGrid.style.height = intDivHeight	;
			}
			
		}
		function SelectAll_OnClick()
		{ 
			var objApplicable = GetObjectReference('frmMultiselectCustomer','chkApplicable',true);
						
			if (objApplicable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
				{
				    if ( objApplicable[i].disabled==false)
				        {
					        objApplicable[i].checked=true;
					    }
				}
					
		
		}
		function ClearAll_OnClick()
		{
		    var objApplicable = GetObjectReference('frmMultiselectCustomer','chkApplicable',true);
						
			if (objApplicable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
				{
				    if ( objApplicable[i].disabled==false)
				        {
					        objApplicable[i].checked=false;
					    }
				}
					
		
		}
			function Sort_OnClick(sortby,sortorder)
			{
		
			//var Role =GetObjectReference('frmMultiselectCustomer','cboRole').value;	  
		     var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtCustomer').value;
		    // var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	
		      // var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
			    
                    objform.action="ML_ModuleAccess_MultiSelect_Customer.aspx?CustomerName="+EmployeeName+"&ModuleID=<%=m_strModuleID%>&sortby=" + sortby + "&sortorder=" + sortorder;
                        objform.submit();
			}
		
		/*
		 function RoleFilterOnChange()
		{
		    //var Role =GetObjectReference('frmMultiselectCustomer','cboRole').value;	  
		     var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtCustomer').value;
		    // var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	
		      // var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
		    objform.action="ML_ModuleAccess_MultiSelect_Customer.aspx?CustomerName="+EmployeeName+"&ModuleID=<%=m_strModuleID%>";
		    objform.submit();
		}
		 function BGFilterOnChange()
		{
		    //var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	  
		    //  var Role =GetObjectReference('frmMultiselectCustomer','cboRole').value;	  
		     var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtCustomer').value;
		     //var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
		    objform.action="ML_ModuleAccess_MultiSelect_Customer.aspx?CustomerName="+EmployeeName+"&ModuleID=<%=m_strModuleID%>&RoleID="+Role+"&BG="+BG+"&OU="+OU;
		    objform.submit();
		}
		function OUFilterOnChange()
		{
		    var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	  
		      var Role =GetObjectReference('frmMultiselectCustomer','cboRole').value;	  
		     var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtEmployee').value;
		     var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
		    objform.action="ML_ModuleAccess_MultiSelect_Customer.aspx?EmployeeName="+EmployeeName+"&ModuleID=<%=m_strModuleID%>&RoleID="+Role+"&BG="+BG+"&OU="+OU;
		    objform.submit();
		}
		*/
		function Save_OnClick()
		{		var objApplicable = GetObjectReference('frmMultiselectCustomer','chkApplicable',true);
			     //var Role =GetObjectReference('frmMultiselectCustomer','cboRole').value;	  
			     var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtCustomer').value;
		       // var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	
		       //  var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
			    if (objApplicable==null  ) return;
			
				for (i=0;i<objApplicable.length;i++) 
					objApplicable[i].disabled=false;
					
		        if (ValidateControl()==true)
					{
					objform.action = "ML_ModuleAccess_MultiSelect_Customer.aspx?ModuleID=<%=m_strModuleID%>&Action=Save&CustomerName="+EmployeeName ;
					objform.submit();
					}
				else
				    {
				    alert("All Licences for this module are utilized! ");
				    objform.action = "ML_ModuleAccess_MultiSelect_Customer.aspx?ModuleID=<%=m_strModuleID%>&Action=REFRESH&CustomerName="+EmployeeName;
					objform.submit();
				    }
		}
	
		function Close_OnClick()
		{
			window.close();
		}
		
		function ValidateControl()
		{ 
			var objApplicable = GetObjectReference('frmMultiselectCustomer','chkApplicable',true);
            var Count=0;
            blnModuleSelected=false;					
			if (objApplicable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
				{
				    if ( objApplicable[i].checked==true)
				        {
				       Count++;
				       
				        }
				}
				//alert("<%=ctype(m_strAvailable,integer) + SelectedLoginCount%>");
				//if (Count<="<%=strLicencesforModule%>")
				  if (Count<="<%=ctype(m_strAvailable,integer) + SelectedLoginCount%>")				
				{ return true;}
				 
					
		return false;
		}
		function txtName_OnKeyPress()
		{
			var key;
			key = window.event.keyCode;
			if (key == 13)
			{
				//var Role =    GetObjectReference('frmMultiselectCustomer','cboRole').value;
		        var EmployeeName =    GetObjectReference('frmMultiselectCustomer','txtCustomer').value;
		        //var BG =GetObjectReference('frmMultiselectCustomer','cboBusinessGroup').value;	
		        // var OU = GetObjectReference('frmMultiselectCustomer','cboOrganizationUnit').value;	 
		        //var noOfPages = GetObjectReference('','hidNoOfPages').value;
		        //objfrm.action="MB_InheritMetrics_Corporate.aspx?Fromwhere=MB&MetricName="+MetricName+"&CategoryID="+Category+"&PageNumber="+noOfPages;
		     
		        if (EmployeeName=='#')
		            EmployeeName='&#35;';
		        objform.action="ML_ModuleAccess_MultiSelect_Customer.aspx?ModuleID=<%=m_strModuleID%>&CustomerName="+EmployeeName;
		    
		        
		        objform.submit();
			}
		}
/*		
var noOfPages = GetObjectReference('frmMultiselectCustomer','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('frmMultiselectCustomer','txtPageNumber');
function Page_OnClick(page)
		{
			//objform.action = "ML_ModuleAccess_MultiSelect_Customer.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&Mode=<%=m_strMode%>&PageNumber=" + page;
			//objform.submit();
		}
function validateNumPaging()
{

	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_OnClick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_OnClick(objtxtpageNumber.value);
	}
}
*/
	
	"<%=m_strScript%>"
				</script>
	</body>
</HTML>
