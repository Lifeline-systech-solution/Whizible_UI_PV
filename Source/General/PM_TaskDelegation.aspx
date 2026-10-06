<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskDelegation.aspx.vb" Inherits="PbNIT.PM_TaskDelegation"%>
<!DOCTYPE HTML>
<html>
<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
  <body MS_POSITIONING="GridLayout" class='clsBody' onresize="window_onresize()" onload="window_onload()">
    <form id="frmTaskDelegation" name="frmTaskDelegation" method="post" runat="server">
		<%PageInit()%>
    </form>
  </body>
  <script language="javascript">
			var objdivlist;
			var objform;
							
			objform = GetFormReference('frmTaskDelegation');
			objdivlist = GetObjectReference('frmTaskDelegation','DivList');
									
			'<%MyBase.InitializeResources("AppResources.PM_TaskDelegation", "AppResources")%>';
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				objdivlist.style.height = intDivHeight	;	
			}
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight	;	
			}	
			
			function SetParentAccess(intCheckBoxIndex, intParentCheckBoxIndex)
			{
				var strChildNodesList,strTempArray,intCtr;
				var objChk,objTxt;
				
				if(intParentCheckBoxIndex <0) return;
				
				//If the current node is checked, then check the parent node also.	
				objChk = GetObjectReference('frmTaskDelegation','chkAccess',true);
				
				if(objChk[intCheckBoxIndex].checked==true)
				{	
					if(objChk[intParentCheckBoxIndex].checked==false)
						objChk[intParentCheckBoxIndex].checked=true;	
				}
				else
				{
					 //If the current node is unchecked, uncheck the parent node conditionally.
					 
					 //First check if any of the child nodes of the current node are checked. 
					 //If yes then return to original state (checked).
					var str;
					str = 'txtChildNodesList' + intCheckBoxIndex;
					
					 //objTxt = GetObjectReference('frmTaskDelegation','txtChildNodesList' + intCheckBoxIndex);
					 objTxt = GetObjectReference('frmTaskDelegation',str);
					 if(objTxt!=null)
					 {
						strChildNodesList = new String(objTxt.value);
						strTempArray =  strChildNodesList.split(",");
						for(intCtr=0;intCtr<strTempArray.length;intCtr++)
							if(strTempArray[intCtr]!='')
								if(objChk[strTempArray[intCtr]].checked==true)
									break; 
						
						if(intCtr<strTempArray.length)
						{
							objChk[intCheckBoxIndex].checked=true;
							alert('<%=Mybase.getResourceString("MSG_REMOVE_CHIELD")%>');
							return;
						}						
					 }
					 
					 //When removing the access rights of a particular TagID, 
					 //the corresponding node level access rights must also be removed.
					 objTxt = GetObjectReference('frmTaskDelegation','txtNodeAccess' + objChk[intCheckBoxIndex].value);
					 objTxt.value= "0,0,0,0";
					 
					 objTxt = GetObjectReference('frmTaskDelegation','txtNodeAccessModified' + objChk[intCheckBoxIndex].value);
					 objTxt.value= "1";
					 
					 //Then, check if the parent of the current node must be unchecked. 
					 //(If any of the siblings of the current node is checked, then the parent node will not be unchecked.)
					 if(objChk[intParentCheckBoxIndex].checked==true)
					 {
						objTxt = GetObjectReference('frmTaskDelegation','txtChildNodesList' + intParentCheckBoxIndex);
						strChildNodesList = new String(objTxt.value);
						strTempArray = strChildNodesList.split(",");
						
						for(intCtr=0;intCtr<strTempArray.length;intCtr++)
							if(strTempArray[intCtr] != '')
								if(objChk[strTempArray[intCtr]].checked==true)
									break;
						
						if(intCtr>=strTempArray.length)
							objChk[intParentCheckBoxIndex].checked=false;		
					 } 					 
				}				
			}
			function RestoreAll_OnClick()
			{	
				objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_RESTORE%>&EmployeeID=<%=m_strEmployeeID%>";
				objform.submit();
			}
			function Save_OnClick()
			{							
				objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EmployeeID=<%=m_strEmployeeID%>";
				objform.submit();
			}
			function ModifyAccess_OnClick(TID,intChkIndx)
			{
				var objChk,objTxt;
				var strNodeAccess;
				
				//Check if the corresponding checkbox has been checked. 
				//(Only if the check box if checked, the user is allowed to modify the access rights.)
				objChk = GetObjectReference('frmTaskDelegation','chkAccess',true);
				if(objChk[intChkIndx].checked==false)
				{	alert('<%=Mybase.GetResourceString("MSG_SELECT_CHECKBOX")%>'); }
				else
				{
					objTxt = GetObjectReference('frmTaskDelegation','txtNodeAccess' + TID);
					strNodeAccess = objTxt.value;
					
					window.open("PM_TaskDelegation.aspx?Mode=<%=CONST_MODE_NODE%>&EmployeeID=<%=m_strEmployeeID%>&NodeAccess=" + strNodeAccess + "&TaskID=" + TID,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-400)/2 + ",top=" + (window.screen.height-500)/2 + ",width=300,height=200");															
				}
			}
			function SetNodeAccess_OnClick(TID)
			{
				var objTxt,objChk;
				var strNodeAccess,strOldNodeAccess;
				
				strNodeAccess= new String();
				
				objChk = GetObjectReference('frmTaskDelegation','chkAdd');
				if(objChk.checked==true) {strNodeAccess = "1"; }
				else {	strNodeAccess = "0"; }
				
				objChk = GetObjectReference('frmTaskDelegation','chkDelete');
				if(objChk.checked==true) {strNodeAccess += ",1"; }
				else {	strNodeAccess += ",0"; }
					
				objChk = GetObjectReference('frmTaskDelegation','chkEdit');
				if(objChk.checked==true) {strNodeAccess += ",1"; }
				else {	strNodeAccess += ",0"; }
					
				objChk = GetObjectReference('frmTaskDelegation','chkView');
				if(objChk.checked==true) {strNodeAccess += ",1"; }
				else {	strNodeAccess += ",0"; }
				
				objTxt = GetObjectReference('frmTaskDelegation','txtOldNodeAccess');
				strOldNodeAccess = new String(objTxt.value);

				if(strNodeAccess != strOldNodeAccess)
				{	updateDataByParent(strNodeAccess);
					//objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EmployeeID=<%=m_strEmployeeID%>&TaskID=" + TID + "&NodeAccess=" + strNodeAccess;
					//objform.submit();
				}					
				window.close();					
			}
			function Reset_OnClick(TID,NodeCntr,PNodeCntr)
			{
				var objChk;
				
				objChk = GetObjectReference('frmTaskDelegation','chkAccess',true);
				objChk[NodeCntr].checked=false;
				
				SetParentAccess(NodeCntr,PNodeCntr);
								
				objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EmployeeID=<%=m_strEmployeeID%>&TagToBeReset=" + TID;
				objform.submit();
			}			
			
			//Integrated by MrugajaB on 14th Mar 2005 for Whizible SEM SP2 Issue ID.16639
			//Added by DipaliS_23122004
			function TabAccess_OnClick(TID,intChkIndx)
			{
				var objChk,objTxt;
				var strNodeAccess;
				
				//Check if the corresponding checkbox has been checked. 
				//(Only if the check box if checked, the user is allowed to modify the access rights.)
				objChk = GetObjectReference('frmTaskDelegation','chkAccess',true);
				if(objChk[intChkIndx].checked==false)
				{	alert('<%=Mybase.GetResourceString("MSG_SELECT_CHECKBOX")%>'); 
				}
				else
				{
					objTxt = GetObjectReference('frmTaskDelegation','txtNodeAccess' + TID);
					strNodeAccess = objTxt.value;
					window.open("PM_DelegateSubNode.aspx?EmployeeID=<%=m_strEmployeeID%>" +  "&TagID=" + TID,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",width=600,height=400");															
				}
			}
			//End Addition by DipaliS_23122004
		</Script>  
</html>
