<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ReallocatableTasks.aspx.vb" Inherits="PbNIT.PM_ReallocatableTasks" %>
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
			var iCount
			var strList
			var ToBeReallocatedCount=0
			
			var objChkReallocate=document.getElementById("chkReallocate")
			var intEmployeeID=window.frmReallocateList.txtEmployeeID.value
			
			if(!objChkReallocate)
				{
					return;
				}
				strList=""
				for (iCount=0;iCount<window.frmReallocateList.chkReallocate.length;iCount++)
				{
				
					if (window.frmReallocateList.chkReallocate[iCount].checked)
						{
						//alert (window.frmReallocateList.chkReallocate[iCount].value)
						strList=strList + window.frmReallocateList.chkReallocate[iCount].value + ","
						ToBeReallocatedCount++;
						}
				}
			//If chkReallocate is not a array and is a single check box
			if(ToBeReallocatedCount==0)
				{	
					//if not a array only single check box is present
					if (objChkReallocate.checked)
						{
						strList=strList + objChkReallocate.value+ ","
						ToBeReallocatedCount++;
						}
				}
				
			if(ToBeReallocatedCount>0)
				{
						//strList=strList+window.frmReallocateList.chkReallocate[window.frmReallocateList.chkReallocate.length].value
						window.location.href="PM_ReallocatableResource.aspx?mode=Reallocate&ReallocateTaskList=" + strList + "&ProjectEmployeeRoleID=" + intEmployeeID
						
				}
			else
				{
					alert("Select Tasks to be Reallocated")
				}		
			}
			
		//Function Name :ClearAll_onClick
		//Purpose : Deselects all the checkboxes for Reallocation
		//Parameters :None
		//Returns : None	
			
			
			function ClearAll_onClick()
			{
			//Selects or Deselects all the checkboxes
			var iCount
			var strList
			//If object does not exist then return
			var objchkReallocate=document.getElementById("chkReallocate")
			if(!objchkReallocate)
				{
					return
				}
			
			strList=""
				//Clear all checkboxes and set flag to Select
					for (iCount=0;iCount<window.frmReallocateList.chkReallocate.length;iCount++)
						{
							if (window.frmReallocateList.chkReallocate[iCount].checked==true)
							{
								window.frmReallocateList.chkReallocate[iCount].checked=false
							}
						}
			}
			
		//Function Name :SelectAll_onClick
		//Purpose : Selects/Deselects all the checkboxes for deletion
		//Parameters :None
		//Returns : None
		function SelectAll_onClick()
			{
			//Selects or Deselects all the checkboxes
			var iCount
			var strList
			//If object does not exist then return
			var objchkReallocate=document.getElementById("chkReallocate")
			if(!objchkReallocate)
				{
					return
				}
		
			strList=""
		
				//select allcheckboxes and set flag to Clear
					for (iCount=0;iCount<window.frmReallocateList.chkReallocate.length;iCount++)
						{
						if (window.frmReallocateList.chkReallocate[iCount].checked==false)
							{
								if(window.frmReallocateList.chkReallocate[iCount].disabled==false)
									window.frmReallocateList.chkReallocate[iCount].checked=true
							}
						}
			}
			
	
		//Function Name :Help_onClick
		//Purpose : To redirect to Help Page.
		//Parameters :None
		//Returns : None
		function Help_onClick(TestCode)
			{
			//window.location.href="../General/Help.aspx?MasterTagID=1019"
			window.open("../General/Help.aspx?MasterTagID=1019","","menubar=no,scrollbars=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-400)/2 + ",width=700,height=450")
			}
		//Function Name :Back_onClick
		//Purpose : To redirect to Previous page .
		//Parameters :None
		//Returns : None
		
			function Close_onClick()
		{
			//Go Back To previous page 
			window.close();
      //      window.opener.location=window.opener.location;
        }	
			
		</script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" >
		<form id="frmReallocateList" method="post" runat="server">
			<%call CreateTaskList%>
		</form>
	</body>
</HTML>
