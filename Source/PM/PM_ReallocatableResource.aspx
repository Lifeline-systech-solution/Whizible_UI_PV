<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ReallocatableResource.aspx.vb" Inherits="PbNIT.PM_ReallocatableResource"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<%CommonFunctions.General.PlotPageHeadTag("Reallocatable Tasks List")%>
		
		<title>Reallocatable Tasks List</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK rel="stylesheet" type="text/css" href="../General/StyleSheetChanakya.css">
		<script language="javascript">
			//The div tag has id as PageDiv 
			
		//Function Name :Next_onClick
		//Purpose : Set mode=Next and redirects to Next page with Reallocate Task list.
		//Parameters :None
		//Returns : None	
		function Next_onClick()
			{
		
			var strEmployeeID=window.frmReallocateList.txtEmployeeID.value
			
			var strList=window.frmReallocateList.txtReallocateTaskList.value
			alert(strList)
			var objResource=document.getElementById("cboResource")
			alert(objResource.value)
			if(!objResource)
				{
					return;
				}
			
			var strResource=window.frmReallocateList.cboResource.value	
					alert(strResource)	
			if(strResource)
				{
						//strList=strList+window.frmReallocateList.chkReallocate[window.frmReallocateList.chkReallocate.length].value
						window.location.href="PM_ReallocatateTaskstoResource.aspx?mode=Reallocatetemp&ReallocateTaskList=" + strList + "&ProjectEmployeeRoleID=" + strEmployeeID + "&EmployeeID=" + strResource 
						//alert("Hi")
				}
			else
				{
					alert("Please select Resource to be allocated")
				}							
			}
			
		//Function Name :Back_onClick
		//Purpose : To redirect to Previous page .
		//Parameters :None
		//Returns : None
		
		function Back_onClick()
		{
			//Go Back To previous page 
				var objResource=document.getElementById("cboResource")
			if(!objResource)
				{
					return;
				}
			
			var strResource=window.frmReallocateList.cboResource.value	
			alert(strResource)
				var strEmployeeID=window.frmReallocateList.txtEmployeeID.value
				var strList=window.frmReallocateList.txtReallocateTaskList.value
			window.location.href="PM_ReallocatableTasks.aspx?mode=Reallocate&ReallocateTaskList=" + strList + "&ProjectEmployeeRoleID=" + strEmployeeID + "&EmployeeID=" + strResource 
       }
    //    
        
		
		//Function Name :Help_onClick
		//Purpose : To redirect to Help Page.
		//Parameters :None
		//Returns : None
		function Help_onClick(TestCode)
			{
			//window.location.href="../General/Help.aspx?MasterTagID=1019"
			window.open("../General/Help.aspx?MasterTagID=1019","","menubar=no,scrollbars=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-400)/2 + ",width=700,height=450")
			}
		//Function Name :Close_onClick
		//Purpose : To Close page .
		//Parameters :None
		//Returns : None
		
		function Close_onClick()
		{
			// To Close page 
			window.close();
          //  window.opener.location=window.opener.location;
        }	
        
        
			
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody">
		<form id="frmReallocateList" method="post" runat="server">
			<%call CreateTaskList%>
		</form>
	</body>
</HTML>
