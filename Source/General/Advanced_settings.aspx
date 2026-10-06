<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Advanced_settings.aspx.vb" Inherits="PbNIT.Advanced_settings" %>
<!DOCTYPE HTML>
<HTML>
  
	<%CommonFunctions.General.PlotPageHeadTag("Advanced Settings")%>
	<body onresize="window_onresize()" onload="window_onload()">
		<form id="frmAdvanceSettings" method="post" runat="server">
			<% BuildPage()%>
		</form>
        
		<script language="javascript">
		
		var objfrm=GetFormReference('frmAdvanceSettings');
		var objResAlloc = GetObjectReference('frmAdvanceSettings','chkResourceAllocation');
		var objResAllocLevel = GetObjectReference('frmAdvanceSettings','cboResourceAllocationLevel'); 
		var objResAllocValue = GetObjectReference('frmAdvanceSettings','txtResAllocationValue'); 
		var objResPool = GetObjectReference('frmAdvanceSettings','chkResourcePool');
		var objdivlist = GetObjectReference('frmResourceUtilization', 'DivMain');
		var objAdvSettingsdiv = GetObjectReference('frmAdvanceSettings', 'AdvSettingsdiv');
		
		
		<%' Added By SonalD on 21st Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 21st Jan 2009 %>
		
		function ResAlloc_Click()
		{
					
			if (objResAlloc.checked==false)
			{
				//objResAllocLevel.value = ""; 
				objResAllocLevel.disabled = true; 
				objResPool.disabled = true;
				//objResAllocValue.disabled=false;
				//setFocus(objResAllocValue);
			}
			else 
			{
				objResAllocLevel.disabled = false; 
				objResPool.disabled = false;
				//objResAllocValue.disabled=true;
				/*if(isBlank(objResAllocLevel.value)==true)
				{
				   alert('Reource Allocation Level should not be blank.');
				   setFocus(objResAllocLevel);
				}*/
			}
		}
		
		function Save_OnClink()
		{
		   if (objResAlloc.checked==false)
			{
					if(disallowNegativeNumeric(objResAllocValue)==true)
					{
						alert('Resource Percentage Allocation should be positive numeric value.');
						setFocus(objResAllocValue);
						return;
					}
					//Added by SanaS on 22-Oct-2009
						if(disallowMinValueViolation(objResAllocValue,100)==true)
					{
						alert('Resource Percentage Allocation should be greater than or equal to 100.');
						setFocus(objResAllocValue);
						return;
					}
		            //end Addition by SanaS on 22-Oct-2009
		   }
		   //Added by SanaS on 22-Oct-2009
            if(disallowNegativeNumeric(objResAllocValue)==true)
					{
						alert('Resource Percentage Allocation should be positive numeric value.');
						setFocus(objResAllocValue);
						return;
					}
			if(disallowMinValueViolation(objResAllocValue,100)==true)
					{
						alert('Resource Percentage Allocation should be greater than or equal to 100.');
						setFocus(objResAllocValue);
						return;
					}
		//end Addition by SanaS
		   objResAllocLevel.disabled = false; 
		   objResPool.disabled = false;
		   //objResAllocValue.disabled=false;
			
			if(isBlank(GetObjectReference('','txtResAllocationValue').value))
			{
			  alert('Resource Percentage Allocation value should not be blank.');
			  setFocus(GetObjectReference('','txtResAllocationValue'));
			  return;
			}
						   		   
		   objfrm.action="../General/Advanced_settings.aspx?Action=Save";
		   objfrm.submit();
		}
		
		function window_onload()
		{
		    
		    if (objResAlloc.checked==false)
			{
				//objResAllocLevel.value = ""; 
				objResAllocLevel.disabled = true; 
				objResPool.disabled = true;
				//objResAllocValue.disabled=false;
				//setFocus(objResAllocValue);
			}
			else 
			{
				objResAllocLevel.disabled = false; 
				objResPool.disabled = false;
				//objResAllocValue.disabled=true;
				if(isBlank(objResAllocLevel.value)==true)
				{
				   alert('Reource Allocation Level should not be blank.');
				   setFocus(objResAllocLevel);
				}
			}
			var intDivHeight ;
			var intDivHeightRisk;
			//ADDED BY NILESH G ON 23/11/2015 FOR ADVANCE PAGE FOOTER SETTING
			if (objAdvSettingsdiv != null) {
			   
			    intDivHeight = window.innerHeight - objAdvSettingsdiv.offsetTop - 28;
			    objAdvSettingsdiv.style.height = intDivHeight + 'px';
			}
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
			    if (intDivHeight < 100) intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			//if(navigator.appName == 'Netscape')
			//{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 2210;
				
			    //}
           }
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    //ADDED BY NILESH G ON 23/11/2015 FOR ADVANCE PAGE FOOTER SETTING
			if (objAdvSettingsdiv != null) {
			   
			    intDivHeight = window.innerHeight - objAdvSettingsdiv.offsetTop - 28;
			    objAdvSettingsdiv.style.height = intDivHeight + 'px';
			}
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
			if (objAdvSettingsdiv != null)
			{
			    intDivHeight = window.innerHeight - objAdvSettingsdiv.offsetTop - 28;
			    objAdvSettingsdiv.style.height = intDivHeight + 'px';
			}
			}
		}
		</script>
	</body>
</HTML>
