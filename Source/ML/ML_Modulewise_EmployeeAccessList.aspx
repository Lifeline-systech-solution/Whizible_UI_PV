<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ML_Modulewise_EmployeeAccessList.aspx.vb" Inherits="PbNIT.ML_Modulewise_EmployeeAccessList" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<%  CommonFunctions.General.PlotPageHeadTag("Module Access")%>
	 <body MS_POSITIONING="GridLayout" class="clsBody" onresize=window_onresize() onload=window_onload() >
		<form id="frmModuleAccess" method="post" runat="server">
		<%PageInit%>
		</form>
		
		<script>
		objform=GetFormReference('frmModuleAccess');
		objDivMain=GetObjectReference('frmModuleAccess','DivLi
		
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
			
		}
		/*--------------------------------------------------------------------------------------------------------------*/
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
			}
			
		}
		function SelectAll_OnClick()
		{ 
			var objSelected =GetObjectReference('frmModuleAccess','chkApplicable',true);
    		if (objSelected==null ) return;
			for (i=0;i<objSelected.length;i++) 
			{
			    if (objSelected[i].disabled==false)
			        {
				        objSelected[i].checked=true;
				    }
			}
		}
		
		function Save_OnClick()
		{		
		        if (ValidateControl()==true)
					{
					objform.action = "ML_Modulewise_EmployeeAccessList.aspx?ModuleTagID=<%=m_intModuleTagID%>&Action=Save" ;
					objform.submit();
					}
				else
				    {
				    alert("No. Of Licences are exceeding Total Licences for the module! ");
				    objform.action = "ML_Modulewise_EmployeeAccessList.aspx?ModuleTagID=<%=m_intModuleTagID%>&Action=" ;
					objform.submit();
				    }
		}
		function ValidateControl()
		{
		    var objSelected=GetObjectReference('frmModuleAccess','chkApplicable',true);
	        var intCheckedcnt;
	        var i;
	        intCheckedcnt=0;
	       	if (objSelected==null ) return;
			for (i=0;i<objSelected.length;i++) 
			{ 
			    if ( objSelected[i].checked==true)
			        {
				        intCheckedcnt++;
				    }
			}
					
			if 	(intCheckedcnt > "<%=m_intLicences%>")
			    return false;
			else
			    return true;
			}
		
		</script>
	</body>
</HTML>