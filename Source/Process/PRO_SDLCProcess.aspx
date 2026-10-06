<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_SDLCProcess.aspx.vb" Inherits="PbNIT.PRO_SDLCProcess"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
		
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	
	<body class='clsBody' MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">
		<form id="frmSDLCProcess" name="frmSDLCProcess" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objform;
							
			objform=GetFormReference('frmSDLCProcess');
			objdivlist=GetObjectReference('frmSDLCProcess','DivList');
				
			'<%MyBase.InitializeResources("AppResources.PRO_SDLCProcess", "AppResources")%>';
			
			<%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				
				
				//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

				if(navigator.appName == 'Netscape'){
					intDivHeight = window.innerHeight  - objdivlist.offsetTop - 40 ;}
				else{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;}
				if (intDivHeight < 100)
				intDivHeight = 100;
				objdivlist.style.height = intDivHeight	;	
				
			}
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

					if(navigator.appName == 'Netscape')
					{
						intDivHeight = window.innerHeight  - objdivlist.offsetTop - 40 ;
					}
					else
					{
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight	;	
			}
			function Save_OnClick()
			{
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_PROCESS_INFO%>&Action=<%=CONST_ACTION_SAVE%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>";
				objform.submit();
			}
			function AddNew_OnClick()
			{
				window.open("PRO_SDLCProcess.aspx?Mode=<%=CONST_ACTIVITY_INFO%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-450)/2 + ",width=650,height=450");
			}
			function ActivitySave_OnClick()
			{
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_ACTIVITY_INFO%>&Action=<%=CONST_ACTION_SAVE%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>";
				objform.submit();
			}
			function SelectAll_OnClick()
			{
				var objChk,objTxt;
				var intCnt,i;
				
				objTxt = GetObjectReference('frmSDLCProcess','hdtxtRowCount');
				intCnt = objTxt.value;
				
				objChk = GetObjectReference('frmSDLCProcess','chkSelect',true);
				for(i=0;i<intCnt;i++)
					objChk[i].checked = true;
					
			}
			function ClearAll_OnClick()
			{
				var objChk,objTxt;
				var intCnt,i;
				
				objTxt = GetObjectReference('frmSDLCProcess','hdtxtRowCount');
				intCnt = objTxt.value;
				
				objChk = GetObjectReference('frmSDLCProcess','chkSelect',true);
				for(i=0;i<intCnt;i++)
					objChk[i].checked = false;
			}
			function Activity_OnClick(AID)
			{
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_EDIT_ACTIVITY%>&ProjectID=<%=m_lngProjectID%>&ProcessID=<%=m_lngProcessID%>&ActivityID=" + AID; 
				objform.submit();
			}
			function Back_OnClick()
			{
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_PROCESS_INFO%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>"; 
				objform.submit();
			}
			function ActivityEditSave_OnClick()
			{
				var objTxt;
				var flag,i;
				
				var objSelectedItems = GetObjectReference('frmSDLCProcess','lstTemplate'); 
				for(i=0;i< objSelectedItems.options.length;i++)
					objSelectedItems.options[i].selected=true;
					
				objSelectedItems = GetObjectReference('frmSDLCProcess','lstChecklist'); 
				for(i=0;i< objSelectedItems.options.length;i++)
					objSelectedItems.options[i].selected=true;	
				
				objTxt = GetObjectReference('frmSDLCProcess','txtReferences');
				flag = disallowMaxlengthViolation(objTxt,999,'<%=mybase.GetResourceString("MSG_REFERENCE_LENGTH")%>');
				if(flag==true)
					return;     
				
				objTxt = GetObjectReference('frmSDLCProcess','txtTailoringDesc');
				flag = disallowMaxlengthViolation(objTxt,999,'<%=mybase.GetResourceString("MSG_TAILORING_DESC_LENGTH")%>');
				if(flag==true)
					return;     
				
				objTxt = GetObjectReference('frmSDLCProcess','txtDeviationDesc');
				flag = disallowMaxlengthViolation(objTxt,999,'<%=mybase.GetResourceString("MSG_DEVIATION_DESC_LENGTH")%>');
				if(flag==true)
					return;     
				
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_EDIT_ACTIVITY%>&Action=<%=CONST_ACTION_SAVE%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>&ActivityID=<%=m_lngActivityID%>";
				objform.submit();		
			}
			function SaveWithRevision_OnClick()
			{
				var i;
				var objSelectedItems = GetObjectReference('frmSDLCProcess','lstTemplate'); 
				for(i=0;i< objSelectedItems.options.length;i++)
					objSelectedItems.options[i].selected=true;
					
				objSelectedItems = GetObjectReference('frmSDLCProcess','lstChecklist'); 
				for(i=0;i< objSelectedItems.options.length;i++)
					objSelectedItems.options[i].selected=true;
					
				window.open("PRO_SDLCProcess.aspx?Mode=<%=CONST_REVISION_REASON%>&ProjectID=<%=m_lngProjectID%>&ProcessID=<%=m_lngProcessID%>&ActivityID=<%=m_lngActivityID%>" ,"_new","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-200)/2 + ",width=550,height=200");								
			}
			function RevisionSave_OnClick()
			{
				var objTxt;
				var strReason,flag;
				
				objTxt = GetObjectReference('frmSDLCProcess','txtReason');
				flag = disallowMaxlengthViolation(objTxt,999,'<%=mybase.GetResourceString("MSG_REVISION_LENGTH")%>');
				if(flag==false)
				{	
					objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_REVISION_REASON%>&Action=<%=CONST_ACTION_SAVE%>&ProcessID=<%=m_lngProcessID%>&ProjectID=<%=m_lngProjectID%>&ActivityID=<%=m_lngActivityID%>";
					objform.submit();
				}	
			}
			function ShowDetails_OnClick(AID)
			{
				window.open("PRO_SDLCProcess.aspx?Mode=<%=CONST_SHOW_DETAILS%>&ProjectID=<%=m_lngProjectID%>&ProcessID=<%=m_lngProcessID%>&ActivityID=" + AID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-450)/2 + ",width=650,height=450");				
			}
			function CheckList_OnClick(CID,PRCID)
			{
				window.open("../Process/PRO_ChecklistForm.aspx?Mode=PUBLISH&ChecklistID=" + CID, "", "resizable=yes,menubar=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
			}
			function Template_OnClick(TID,PRCID)
			{
				objform.action="PRO_SDLCProcess.aspx?Mode=<%=CONST_SHOW_TEMPLATE%>&ProjectID=<%=m_lngProjectID%>&ProcessID=<%=m_lngProcessID%>&TemplateID=" + TID; 
				objform.submit();
			}
			function AddAll_OnClick(strLst1,strLst2)
			{
				var objUserList = GetObjectReference('frmSDLCProcess',strLst1); 
				var objSelectedUserList = GetObjectReference('frmSDLCProcess',strLst2); 
				var Count = objUserList.options.length
				
				if (objUserList.length > 0) 
				{	var intCounter;
					for (intCounter = 0;intCounter < Count;)
					{
						var objOption = document.createElement("OPTION");				
													
					    //objSelectedUserList.options.add(objOption);  Commented & added by vaijat k on 26-11-2015
						document.getElementById(strLst2).appendChild(objOption);
						objOption.text = objUserList.options[intCounter].text;	
						objOption.value = objUserList.options[intCounter].value;	
						
						objUserList.options.remove(intCounter);
						Count=objUserList.options.length;
									
						objSelectedUserList.focus();
						//txtModified.value = 'yes';
					}
				}	
			}
			
			function Add_OnClick(strLst1,strLst2)
			{
				var objUserList = GetObjectReference('frmSDLCProcess',strLst1); 				
				var objSelectedUserList = GetObjectReference('frmSDLCProcess',strLst2); 
							
				var intCounter;
				for(intCounter=0;intCounter < objUserList.options.length;)
				{
					if(objUserList.options[intCounter].selected==true)
					{
						var objOption = document.createElement("OPTION");
					    //objSelectedUserList.options.add(objOption);  Commented & added by vaijat k on 26-11-2015
						document.getElementById(strLst2).appendChild(objOption);
						objOption.text = objUserList.options[intCounter].text	
						objOption.value = objUserList.options[intCounter].value	
						objUserList.options.remove(intCounter)
						//txtModified.value = 'yes';
					}
					else
					{
					intCounter++;
					}
				}
			}
			function Remove_OnClick(strLst1,strLst2)
			{		
				var objUserList = GetObjectReference('frmSDLCProcess',strLst1); 
				var objSelectedUserList = GetObjectReference('frmSDLCProcess',strLst2); 
				var intCounter;
			
				for(intCounter=0;intCounter<objSelectedUserList.options.length;)
				{
					if(objSelectedUserList.options[intCounter].selected==true)
					{
						var objOption = document.createElement("OPTION");
						//objUserList.options.add(objOption);     Commented & added by vaijat k on 26-11-2015
						document.getElementById(strLst1).appendChild(objOption);
						objOption.text=objSelectedUserList.options[intCounter].text	
						objOption.value=objSelectedUserList.options[intCounter].value
				
						objSelectedUserList.options.remove(intCounter)
						
					}
					else
					{
						intCounter++;
					}
				}	 
			}

			function RemoveAll_OnClick(strLst1,strLst2)
			{
				
				var objSelectedUserList = GetObjectReference('frmSDLCProcess',strLst2); 
				var objUserList = GetObjectReference('frmSDLCProcess',strLst1);												
				var Count = objSelectedUserList.options.length;
				
				if (objSelectedUserList.length>0) 
				{	var intCounter;
					for (intCounter=0;intCounter< Count; )
					{
						var objOption = document.createElement("OPTION");				
													
					    //objUserList.options.add(objOption);     Commented & added by vaijat k on 26-11-2015
						document.getElementById(strLst1).appendChild(objOption);
						objOption.text = objSelectedUserList.options[intCounter].text	
						objOption.value = objSelectedUserList.options[intCounter].value	
						
						objSelectedUserList.options.remove(intCounter)
						Count = objSelectedUserList.options.length
										
						objUserList.focus();
					}
				}	
			}
		</script>
	</body>
</HTML>
