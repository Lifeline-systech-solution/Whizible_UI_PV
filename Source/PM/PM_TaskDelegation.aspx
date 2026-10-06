<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskDelegation.aspx.vb" Inherits="PbNIT.PM_TaskDelegation"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


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
			//Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			
			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				if(navigator.appName == 'Netscape')
				{
					intDivHeight = window.innerHeight - objdivlist.offsetTop -15;
				}
				objdivlist.style.height = intDivHeight + "px"	;	
			}
			function window_onresize()		
			
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight + "px" ;
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
			    //Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token
				//objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_RESTORE%>&EmployeeID=<%=m_strEmployeeID%>";
			    //  objform.submit();
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'PM_TaskDelegation.aspx/GenrateURLToken_RestoreAllOnclick',
			        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", Employee_ID: "<%=m_strEmployeeID%>" }),
			        success: function (Result) {
			            objform.action="PM_TaskDelegation.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_RESTORE%>&EmployeeID=<%=m_strEmployeeID%>&PkTokenRestoreAll="+ Result.d;
			            objform.submit();

			        },
			        error: function () {
			            // alert("Error")
			        }
			    });
			    //End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token
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
					
				    //Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
					$.ajax({
					    type: 'POST',
					    dataType: 'json',
					    contentType: 'application/json',
					    url: 'PM_TaskDelegation.aspx/GenrateURLToken_ModifyAccess_OnClick',
					    data: JSON.stringify({ EmployeeID: '<%=m_strEmployeeID%>', NodeAccess: strNodeAccess, TaskID: TID }),
					    success: function (Result) {

					        window.open("PM_TaskDelegation.aspx?Mode=<%=CONST_MODE_NODE%>&PkTokenModifyAccess=" + Result.d + "&EmployeeID=<%=m_strEmployeeID%>&NodeAccess=" + strNodeAccess + "&TaskID=" + TID, "", "resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width - 400) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=300,height=200");															

					    },
					    error: function () {
					      //  alert("Error")
					    }
					});
				    //End of Addition by Dhanashri S on 29 Jan 2016

				    //Commented by Dhanashri S on 29 Jan 2016
				    //window.open("PM_TaskDelegation.aspx?Mode=<%=CONST_MODE_NODE%>&EmployeeID=<%=m_strEmployeeID%>&NodeAccess=" + strNodeAccess + "&TaskID=" + TID,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-400)/2 + ",top=" + (window.screen.height-500)/2 + ",width=300,height=200");															
                    //End of Comment by Dhanashri S on 29 Jan 2016
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

				    //Added by Dhanashri S on 29 Jan 2016 for PkToken Validation
					$.ajax({
					    type: 'POST',
					    dataType: 'json',
					    contentType: 'application/json',
					    url: 'PM_TaskDelegation.aspx/GenrateURLToken_TabAccess_OnClick',
					    data: JSON.stringify({ EmployeeID: '<%=m_strEmployeeID%>', TagID: TID }),
					    success: function (Result) {

					        window.open("PM_DelegateSubNode.aspx?EmployeeID=<%=m_strEmployeeID%>" + "&PkTokenTabAccess=" + Result.d + "&TagID=" + TID, "", "resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=600,height=400");															
					    },
					    error: function () {
					        alert("Error")
					    }
					});
				    //End of Addition by Dhanashri S on 29 Jan 2016

					//window.open("PM_DelegateSubNode.aspx?EmployeeID=<%=m_strEmployeeID%>" +  "&TagID=" + TID,"","resizable=no,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-400)/2 + ",width=600,height=400");															
				}
			}
			//End Addition by DipaliS_23122004
		</Script>  
</html>
