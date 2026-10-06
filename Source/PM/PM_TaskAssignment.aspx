<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskAssignment.aspx.vb" Inherits="PbNIT.PM_TaskAssignment" ValidateRequest="false" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<%WritePageHead%>
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child {
        /*width: 35%;*/
        vertical-align: middle;
    }

    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 100px;
        height: 100px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.4;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {

        //Added By Usha Pandit On 23.07.2019 For not allowing to assign resources to void task
        $(".Menu").each(function () {
            if ($(this).attr("title") == "Assign Resources") {
                try {
                    var result = AJAXCallWithResult('PM_TaskAssignment.aspx/IsActiveTask', JSON.stringify({ TaskID: '<%=m_lngTaskId%>' }), false);
                    if (result.d == 1) {

                    }
                    if (result.d == 0) {
                        $(this).removeAttr("onclick");
                        $(this).prop("onclick", null);
                        $(this).attr("title", "You can not assign resources to void task");
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
            }
        });
        //End Of Added By Usha Pandit On 23.07.2019 For not allowing to assign resources to void task

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


<%'Modified By NitinVS on 17 Mar 2007 for PMLifeLine SP 8 Regression Issue 11318 div resizing was not working%>
<body class="clsBody" ms_positioning="GridLayout" onload="window_onload()" onresize="window_onresize()">
    <%'End Modification By NitinVS on 17 Mar 2007 for PMLifeLine SP 8 Regression Issue 11318 div resizing was not working%>
    <form id="frmTaskAssignment" method="post" runat="server">

        <%WritePage%>
    </form>
    <script language="javascript">
        //onresize=window_onresize() onload=window_onload()
        //Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
        var intResourceValidation = <%=m_bitResourceValidation%>;
        var strUrl;
        //Modified By ShraddhaM on 26 Erpt 2006 for Firefox changes..

        var objTaskType = window.document.forms['frmTaskAssignment'].elements['cboTasktype'];

		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
		<%End If%>




	//End Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
// =============================== Common To all Mode=====================//
//Code Commented By VidyaJ on 15th Jan 2005
//For IssueID - 15416
//<%'If m_blnProjectOnHold = True Then%>

//	alert('<%=m_strProjectOnHoldMessage%>');
//	window.close();
//<%'Else%>			
	<%If m_blnSendEmail = True Then%>
		<%If m_blnShowPopup = True Then%>
        if ("<%=FromTimesheet%>" != "CreateTask")
            //modified By VivekP On 5 Jun 2005
            window.open("../General/SendEmail.aspx?MessageID=20&TaskID=<%=m_strTaskIDList%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
        else
            window.open("../General/SendEmail.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&MessageID=20&TaskID=<%=m_strTaskIDList%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
		<%End If%>
        if ("<%=FromTimesheet%>" != "CreateTask") {
            window.location.href = "../PM/PM_AssignedTaskList.aspx?FromWhere=PM&MasterTagID=<%=m_lngTagID%>&<%=m_strFilterQueryString%>";
        } else {
            //SandipL SEMSP8 IssueID 12620
            //opener.location.href=opener.location.href;
            //window.close();
            objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
            opener.location.href = "../PM/PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&ProjectID=<%=TempProjectId%>&txtDate=" + objCurrentStartDate.value;
            window.close();
        }
		//End of Modificaion On 5 Jun 2005
	/* Modified By	: NitinVS on 3 May 2005 for PMLifeLine SP3 
	   IssueID		: 17096 
	   While creating a task for Case1 , Resource is not displayed when Email settings is changed.
	   Reason		: Page was not redirected to CL 
	   Solution		: Redirectd Page to CL 
	*/
	//Modified By VarunA on 26-Oct-2007 RequestID-9588
	//Purpose : Page was not redirected to CL, so Redirectd Page to CL
	<% ElseIf m_HaveSubTaskTypes = False And m_ApplyEffortDistribution = False And m_strAction = ACTION_SAVE And Request.QueryString("TaskID") = "0" Then %>
	<%' Else IF m_HaveSubTaskTypes= False AND m_ApplyEffortDistribution = False AND  m_strAction = ACTION_SAVE Then %>
	<%' Else IF m_HaveSubTaskTypes= False AND m_ApplyEffortDistribution = False AND  m_strAction = ACTION_SAVE AND m_strMode<>Request.QueryString("MODE") Then %>
        //End By VarunA on 26-Oct-2007
        if ("<%=FromTimesheet%>" != "CreateTask")
            window.location.href = "../PM/PM_AssignedTaskList.aspx?FromWhere=PM&MasterTagID=<%=m_lngTagID%>&<%=m_strFilterQueryString%>";
    else {
        //SandipL SEMSP8 IssueID 12620
        //opener.location.href=opener.location.href;
        //window.close();
        objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
        opener.location.href = "../PM/PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&ProjectID=<%=TempProjectId%>&txtDate=" + objCurrentStartDate.value;
            window.close();
        }
	/* End Modification By  NitinVS on 3 May 2005 for PMLifeLine SP3 IssueID : 17096  */
	<%End If%>

	<%If m_strLeaveMessage <> "" Then%>
        alert("<%=m_strLeaveMessage%>");
	<%End If%>	

	//Modified By VidyaJ - Browser Issue - IssueID - 809 

	<%If m_strAction = ACTION_CLOSE_WINDOW_REVIEW Then%>
        refreshParent('<%=PbNIT.CommonPage.FORM_NAME%>', 'CommonPage.aspx','CommonPage.aspx?FocusOn=<%=PbNIT.CommonPage.FocusOn_SUBTAG%>', true);
		//opener.frmCommonPage.submit();		
		//window.close();
	<%End If%>		

	//<%If m_strAction = ACTION_CLOSE_WINDOW_REVIEW Then%>
		//Commented By MrugajaB on 4th Feb 2005
		//opener.frmCommonPage.submit();	
		//Code added by MrugajaB on 4th Feb 2005 for Issue ID.15376
		//Added code for refreshingparent by sending querystring parameters explicitely

		//var strHref;
		//strHref=opener.location.href;
		//strHref=strHref.replace("Operation=SAVE&","");
			//opener.frmCommonPage.action = strHref;
		//opener.frmCommonPage.submit()
		//window.close();
		//End Addition
	//<%End If%>


	<%If m_strAction = ACTION_CLOSE_WINDOW_MITIGATION Then%>
        refreshParent('<%=PbNIT.CommonPage.FORM_NAME%>', 'CommonPage.aspx','CommonPage.aspx?FocusOn=<%=PbNIT.CommonPage.FocusOn_SUBTAG%>', true);
		//opener.frmCommonPage.action = opener.location.href;
		//opener.frmCommonPage.submit()
		//window.close();
	<%End If%>
		<%If m_strAction = ACTION_CLOSE_WINDOW_TRAINING Then%>
        refreshParent('<%=PbNIT.CommonPage.FORM_NAME%>', 'CommonPage.aspx','CommonPage.aspx?FocusOn=<%=PbNIT.CommonPage.FocusOn_SUBTAG%>', true);
		//opener.frmCommonPage.submit();
		//window.close();		
	<%End If%>
	<%If m_strAction = ACTION_CLOSE_WINDOW_MODE Then%>
        //opener.frmCommonPage.submit();
        //window.close();
        refreshParent('<%=PbNIT.CommonPage.FORM_NAME%>', 'CommonPage.aspx','CommonPage.aspx?FocusOn=<%=PbNIT.CommonPage.FocusOn_SUBTAG%>', true);
	<%End If%>
	//Nikhil
			<%If m_strAction = ACTION_CLOSE_WINDOW_SUBPROJECT Then%>
        refreshParent('<%=PbNIT.CommonPage.FORM_NAME%>', 'SubProject_CommonPage.aspx','SubProject_CommonPage.aspx?FocusOn=<%=PbNIT.CommonPage.FocusOn_SUBTAG%>', true);
	<%End If%>
	//Nikhil
//End of modifications by VidyaJ - IssueID - 809
/////////////////////////////////////////////////////////////////////////////////
//Added by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page //Change GanttChartView.aspx TO WBS_GanttChartView.aspx BY vIJAYd
<%If m_strAction = ACTION_SAVE Or m_strAction = ACTION_DELETE_RESOURCES Then%>
        if (window.opener != null) {
            if (window.opener.document.forms['frmGanttChartView'] != null)
                refreshParent('frmGanttChartView', 'GanttChartView.aspx', '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038', true);

            refreshParent('frmWBS_GanttChartView', 'WBS_GanttChartView.aspx', '../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038', true);
        }       
<%End If%>
        //End of addition by PrashantSJ on 28th July 2009 Purpose: to refersh gantt chart page 
        /////////////////////////////////////////////////////////////////////////////////
        if ("<%=m_blnHasResources%>" != "False") {
            var objTaskType;
            objTaskType = GetObjectReference('frmTaskAssignment', 'cboTaskType');
            objTaskType.disabled = true;
        }
        else {
            var objTaskType;
            objTaskType = GetObjectReference('frmTaskAssignment', 'cboTaskType');
            objTaskType.disabled = false;
        }

	<%=m_sbClientSideScript%>

        var objForm, objdivlist;

        objForm = GetFormReference('frmTaskAssignment');
        //Viraj
        //objdivlist = GetObjectReference('frmTaskAssignment','PageDiv');
        var objDivPage = GetObjectReference('frmTaskAssignment', 'PageDiv');
        objdivlist = GetObjectReference('frmTaskAssignment', 'DivList2');
        // For Setting the focus on the control - by default
        if ("<%=Request.QueryString("Focus")%>".toUpperCase() != "NO") {
            var objForFocus;
            objForFocus = GetObjectReference('frmTaskAssignment', 'txtTaskName');
            setFocus(objForFocus);
        }
//<%'End If%>

        function window_onload() {

            // Commented  by Viraj P on 17 Nov 2015
            var intDivHeight;
            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            //if (intDivHeight < 100)	intDivHeight = 100;
            //objdivlist.style.height = intDivHeight;	
            var browser = WhichBrowser();

            if (objdivlist != null) {
			   <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
            //if(navigator.appName == 'Netscape')
            //{		  
            //    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
            //}
            //else
            //{
            //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            //}
            if (browser == 'IE') {
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;

            }
            else {
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
            }
                 <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
            if (intDivHeight < 100)
                intDivHeight = 100;
		      <%'Commented And Edited  by KIRAN K K  For footer line alignment 16-11-15%>
                <%'objdivlist.style.height = intDivHeight;%>
            objdivlist.style.height = intDivHeight + "px";
		      <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>
            }
            //Commented and Added by Dhanashri S on 1 Dec 2015 for IssueID:2238 
            //else if (objDivPage!=null)
            if (objDivPage != null)
            //End of Comment and Addition by Dhanashri S on 1 Dec 2015
            {

                if (browser == 'IE') {
                    //Commented and Added by Dhanashri S on 1 Dec 2015 for IssueID:2238 
                    //intDivHeight = window.innerHeight - objDivPage.offsetTop - 4;
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                    //End of Comment and Addition by Dhanashri S on 1 Dec 2015
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                }
                else if (browser == 'CR') {
                    //Commented and Added by Dhanashri S on 1 Dec 2015 for IssueID:2238 
                    //intDivHeight = window.innerHeight - objDivPage.offsetTop - 4; 
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                    //End of Comment and Addition by Dhanashri S on 1 Dec 2015
                }
                else {
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26; //Added By Vaijat K ON 08/02/2016 for Edge UI Issue
                }
                if (intDivHeight < 100)
                    intDivHeight = 100;
                objDivPage.style.height = intDivHeight + "px";
            }
        }

        function WhichBrowser() {

            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        //End of Comment  by Viraj P on 17 Nov 2015
        function window_onresize() {

            var intDivHeight;
            var browser = WhichBrowser();
            //Commented and added By Bharat T on 26th-Nov-2015 for SEM Issue Fixing
            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            if (objdivlist != null) {
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight + "px";
            }
            if (objDivPage != null) {
                //intDivHeight = window.innerHeight - objDivPage.offsetTop - 4;
                if (browser == 'IE') {
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                    // intDivHeight = window.innerHeight - objDivPage.offsetTop - 4;
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                }
                else {
                    //   intDivHeight = window.innerHeight - objDivPage.offsetTop - 4; 
                    intDivHeight = window.innerHeight - objDivPage.offsetTop - 26;
                }
                if (intDivHeight < 100) intDivHeight = 100;
                objDivPage.style.height = intDivHeight + "px";
            }
            //End of Commented and added By Bharat T on 26th-Nov-2015 for SEM Issue Fixing

        }
        // =============================== Common To all Mode =====================//
        var strHolidays = "<%=m_strHolidays%>";

        //Added by SidddharthS on  17 Feb 2005 for IssueID 16002
        //Purpose:To get the starting day of the week set at carporate level. 
        var strStartingDay ="<%=m_strStartingDayOfWeek%>";
	<%=declarevariables%>
        function ShowBaseline_OnClick() {
	    //window.open("PM_ShowBaseline.aspx?TaskId=<%=m_lngTaskId%>&FromWhere=AssignedTask", "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");
        //EmployeeID Added by Dhanashri S on 11 Aug 2016 Pktoken validation
        window.open("PM_ShowBaseline.aspx?TaskId=<%=m_lngTaskId%>&EmployeeID=<%=Session("intUserID")%>&PKToken=<%=m_PKToken%>&FromWhere=AssignedTask", "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=700,height=450");
            //End of Addition by Dhanashri S on 11 Aug 2016
        }

        function SendEmail_OnClick() {
		// ***************************************************************************
		// Integrated On 10-Feb-2006 By ParagD for Whiz 2   

		// Commented & Modified By ParagD On 11-Jan-2006
		// Purpose : DSS - 289 => 
		// When task details are modified and click on "SEND MAIL" link ,message contains as "NEW Task"
		// and not "MODIFIED Task" 

		// if ("<%=FromTimesheet%>"!="CreateTask")
		//window.open("../General/SendEmail.aspx?MessageID=20&TaskID=<%=m_lngTaskId%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
		//else
		//window.open("../General/SendEmail.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&MessageID=20&TaskID=<%=m_lngTaskId%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");

        if ("<%=FromTimesheet%>" != "CreateTask") {
            if ("<%=blnIsNewTask%>" == "1") {
                window.open("../General/SendEmail.aspx?MessageID=20&TaskID=<%=m_strTaskIDList%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
            }
            else {
                window.open("../General/SendEmail.aspx?MessageID=202&TaskID=<%=m_lngTaskId%>&EmployeeID=<%=m_strEmployeeId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
            }
			// window.open("../General/SendEmail.aspx?MessageID=20&TaskID=<%=m_lngTaskId%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
            // END : Commented & Modified By ParagD On 11-Jan-2006

            // END : Integrated On 10-Feb-2006 By ParagD for Whiz 2 
            // ***************************************************************************

        }
        else
            window.open("../General/SendEmail.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&MessageID=20&TaskID=<%=m_lngTaskId%>&MasterTagID=<%=m_lngTagId%>", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
        }

        function SetAsBaseline_OnClick() {
            // added By purvaj on 7 Nov 2008 for PMLifeLine
            // validation currentwork should be greater than actual work hours filled
            objActualWork = GetObjectReference('frmTaskAssignment', 'hid_txtActualWork');
            objPlannedWork = GetObjectReference('frmTaskAssignment', 'hid_txtPlannedWork');
            objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');

            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objtxthidCurrentWork = GetObjectReference('frmTaskAssignment', 'txthidCurrentWork');

            //Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change
            if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                objtxthidCurrentWork.value = objCurrentWork.value;
            //End of Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change

            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

            /*Commented by GokulP on 06 Jun 2009 for Validating the Task
                	
    //		//added by purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
    //		var objtxtdelBasalinestartDate = GetObjectReference('frmTaskAssignment','txtdelBasalinestartDate');
    //		var objtxtdelBaselineenddate = GetObjectReference('frmTaskAssignment','txtdelBaselineenddate');
    //		var objtxtdelBaselinework = GetObjectReference('frmTaskAssignment','txtdelBaselinework');
    //		var objtxtDeliverableID = GetObjectReference('frmTaskAssignment','txtHidDeliverableID');
    //		var objtxtDeliverable = GetObjectReference('frmTaskAssignment','txtDeliverableID');
    //		var objtxtdelPlannedTaskEfforts = GetObjectReference('frmTaskAssignment','txtdelPlannedTaskEfforts');
    //		var objCurrentStartDate = GetObjectReference('frmTaskAssignment','txtCurrentStartDate');
    //		var objCurrentEndDate=GetObjectReference('frmTaskAssignment','txtCurrentEndDate');
    //		
    //		if (objtxtDeliverableID != null && objtxtDeliverableID.value !='' && objtxtDeliverableID.value !='0')
    //		{
    //		    if (objtxtdelBasalinestartDate.value == '' || objtxtdelBaselineenddate.value == '' || objtxtdelBaselinework.value =='0' || objtxtdelBaselinework.value =='')
    //		    {
    //		        alert("Please baseline the ' " + objtxtDeliverable.value + " ' Deliverable before saving the task.")
    //		        return;
    //		    }
    //	    
    //		    
    //		    if ((parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) < parseFloat(objCurrentWork.value) )//- parseFloat(objPlannedWork.value)
    //		    {
    //		        alert('Planned Work hours should be less than or equal to remaining deliverable Work hours('+(parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) +').');//- parseFloat(objPlannedWork.value)
    //		        return;
    //		    }
    //		    
    //		    /*var myDeliverableStartDate=new Date();
    //            myDeliverableStartDate=objtxtdelBasalinestartDate.value;
    //            var StratDate= new Date();
    //            StratDate=objCurrentStartDate.value;
    //            if (myDeliverableStartDate>StratDate)
    //            {
    //                alert("Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").");
    //                return;
    //            }
    
    
    //            var myDeliverableEndDate=new Date();
    //            myDeliverableEndDate=objtxtdelBaselineenddate.value;
    //            var EndDate= new Date();
    //            EndDate=objCurrentEndDate.value;
    //            if (EndDate>myDeliverableEndDate)
    //            {
    //                alert("Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").");
    //                return;
    //            }*/
            //            
            //            if(disallowDate1GreaterThanDate2(objtxtdelBasalinestartDate,objCurrentStartDate,"Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").")==true)
            //            return;
            //            
            //            if(disallowDate1GreaterThanDate2(objCurrentEndDate,objtxtdelBaselineenddate,"Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").")==true)//,'dd-mmm-yyyy'
            //            return;		    
            //		    
            //		}
            //end addition purvaj
            //End of comment by GokulP on 06 Jun 2009 
            //Added by GokulP on 06 Jun 2009 for Validation of Task
            var objDeliverableID = GetObjectReference('frmTaskAssignment', 'txtHidDeliverableID');
            var objModuleID = GetObjectReference('frmTaskAssignment', 'cboModuleID');
            var objSubProjectID = GetObjectReference('frmTaskAssignment', 'cboSubProjectID');
            var objMilestoneID = GetObjectReference('frmTaskAssignment', 'cboMilestoneID');
            var objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
            var objTaskStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
            var objTaskEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
            var strURL;
            var objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');


            //Modified by purvaj on 10 Aug 2009. else codition added. value was not getting set to the variable if the object contains value.
            if (objModuleID == null)
                ModuleID = '';
            else
                ModuleID = objModuleID.value;

            if (objSubProjectID == null)
                SubProjectID = '';
            else
                SubProjectID = objSubProjectID.value;

            if (objMilestoneID == null)
                MilestoneID = '';
            else
                MilestoneID = objMilestoneID.value;

            if (objDeliverableID == null)
                DeliverableID = '';
            else
                DeliverableID = objDeliverableID.value;
            //End Modification purvaj.		

            if (objEmployee != null) {
                var counter;
                counter = 0;

                for (var i = 0; i < objEmployee.length; i++) {
                    if (objEmployee[i].selected)
                        counter++;
                }
                var str;
                str = "<%=CommonFunctions.Application.DistributeWorkInAT%>"
            if (str == "True")
                dblLCEHrs = parseFloat(objCurrentWork.value);
            else
                dblLCEHrs = parseFloat(objCurrentWork.value) * counter;
        }
        else
            dblLCEHrs = parseFloat(objCurrentWork.value);


        strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=<%=m_lngTaskId%>&StartDate=" + encodeURIComponent(objTaskStartDate.value) + "&EndDate=" + encodeURIComponent(objTaskEndDate.value) + "&DeliverableID=" + DeliverableID + "&ModuleID=" + ModuleID + "&SubProjectID=" + SubProjectID + "&MilestoneID=" + MilestoneID + "&Work=" + String(dblLCEHrs);
        ValidateTask_Baseline(strUrl);

        if (strResult != null && strResult != "") {
            alert(strResult);
            return;
        }
        //End of Addition by GokulP on 06 Jun 2009 for Validation of Task
        //Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

        //Commented And Added By Usha Pandit On 29.04.2020 For work hour field validation
        ////if (objCurrentWork!=null && objActualWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
        //      if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objActualWork.value)) {
        //          alert('Planned Work hours should be greater than Actual work hours (' + objActualWork.value + ').');
        //          objCurrentWork.focus();
        //          objCurrentWork.select();
        //          return;
        //      }


        ////if (objCurrentWork!=null && objPlannedWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objPlannedWork.value))
        //      if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objPlannedWork.value)) {
        //          alert('Planned Work hours should be greater than Planned work hours of child tasks (' + objPlannedWork.value + ').');
        //          objCurrentWork.focus();
        //          objCurrentWork.select();
        //          return;
        //      }

        var curWorkHrs = objtxthidCurrentWork.value;
        var data = JSON.stringify({ HMHours: curWorkHrs });
        var dectxthidCurrentWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", data, false);
        var curActualHrs = objActualWork.value;
        data = JSON.stringify({ DecimalHours: curActualHrs });
        var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);
        var curPlannedHrs = objPlannedWork.value;
        data = JSON.stringify({ DecimalHours: curPlannedHrs });
        var HMPlannedHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);

        if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objActualWork.value)) {
            alert('Planned Work hours should be greater than Actual work hours ( ' + HMActualHrs.d + ' ).');
            objCurrentWork.focus();
            objCurrentWork.select();
            return;
        }

        if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objPlannedWork.value)) {
            alert('Planned Work hours should be greater than Planned work hours of child tasks ( ' + HMPlannedHrs.d + ' ).');
            objCurrentWork.focus();
            objCurrentWork.select();
            return;
        }
        //End Of Added By Usha Pandit On 29.04.2020 For work hour field validation

        //End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

        // End addition purvaj
        //Added by TruptiK on 24-Mar-09
        obCurrentDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
        objCurrentStartDt = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
        objPlannedendDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskEndDate');
        objPlannedStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskStartDate');
        objActualStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualStartDate');

        dtCurrentDate = getDate(obCurrentDate.value);
        dtCurrentStartDt = getDate(objCurrentStartDt.value);
        dtPlannedendDat = getDate(objPlannedendDate.value);
        dtPlannedStartDate = getDate(objPlannedStartDate.value);

        //Added by GokulP on 08 Oct 2009 for IssueID : 32455
        objActualEndDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualEndDate');
        if (objActualEndDate) {
            dtActualEndDate = getDate(objActualEndDate.value);
        }
        //End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455

        if (objActualStartDate != '0') {
            dtActualStartDate = getDate(objActualStartDate.value);
        }

        if (objPlannedendDate.value != '' && dtCurrentDate < dtPlannedendDat) {
            alert('Planned End Date should not be less than Planned End Date of child tasks (' + objPlannedendDate.value + ').');

            return;
        }


        if (objPlannedStartDate.value != '' && dtCurrentStartDt > dtPlannedStartDate) {
            alert('Planned Start Date should not be greater than start Date of child tasks (' + objPlannedStartDate.value + ').');

            return;
        }

        if (objCurrentStartDt != null && objActualStartDate != null && objActualStartDate.value != 0 && objActualStartDate.value != '' && dtCurrentStartDt > dtActualStartDate) {

            alert('Planned Start Date should not be greater than Actual start Date (' + objActualStartDate.value + ').');
            return;
        }
        //End of addition by TruptiK

        //Added by GokulP on 08 Oct 2009 for IssueID : 32455
        if (objActualEndDate) {
            if (obCurrentDate != null && objActualEndDate != null && objActualEndDate.value != 0 && objActualEndDate.value != '' && dtCurrentDate < dtActualEndDate) {
                alert('Planned End Date should not be less than Actual End Date (' + objActualEndDate.value + ').');
                return;
            }
        }
        //End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455

        //var objTaskType;
        if (ValidateControls() == false)
            return;

        SetAsBaseline();

        //objTaskType = GetObjectReference('frmTaskAssignment','cboTasktype');
        objTaskType.disabled = false;
        if ("<%=FromTimesheet%>" != "CreateTask")
            objForm.action = "PM_TaskAssignment.aspx?Action=<%=ACTION_SAVE%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
        else
            objForm.action = "PM_TaskAssignment.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&Action=<%=ACTION_SAVE%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016

            objForm.submit();
        }

        function ClearBaseline_OnClick() {

            var objBaselineStartDate, objBaselineEndDate, objBaselineWork;


            // added By purvaj on 7 Nov 2008 for PMLifeLine		// validation currentwork should be greater than actual work hours filled
            objActualWork = GetObjectReference('frmTaskAssignment', 'hid_txtActualWork');
            objPlannedWork = GetObjectReference('frmTaskAssignment', 'hid_txtPlannedWork');
            objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');

            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objtxthidCurrentWork = GetObjectReference('frmTaskAssignment', 'txthidCurrentWork');

            //Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change
            if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                objtxthidCurrentWork.value = objCurrentWork.value;
            //End of Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change

            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

            //        //Commented BY VijayD ON 9 Jun 2009
            //        //Purpose : changes Validation for Workflow Approval.
            //        
            //        //added by purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
            //		var objtxtdelBasalinestartDate = GetObjectReference('frmTaskAssignment','txtdelBasalinestartDate');
            //		var objtxtdelBaselineenddate = GetObjectReference('frmTaskAssignment','txtdelBaselineenddate');
            //		var objtxtdelBaselinework = GetObjectReference('frmTaskAssignment','txtdelBaselinework');
            //		var objtxtDeliverableID = GetObjectReference('frmTaskAssignment','txtHidDeliverableID');
            //		var objtxtDeliverable = GetObjectReference('frmTaskAssignment','txtDeliverableID');
            //		var objtxtdelPlannedTaskEfforts = GetObjectReference('frmTaskAssignment','txtdelPlannedTaskEfforts');
            //		var objCurrentStartDate = GetObjectReference('frmTaskAssignment','txtCurrentStartDate');
            //		var objCurrentEndDate=GetObjectReference('frmTaskAssignment','txtCurrentEndDate');
            //		
            //		if (objtxtDeliverableID != null && objtxtDeliverableID.value !='' && objtxtDeliverableID.value !='0')
            //		{
            //		    if (objtxtdelBasalinestartDate.value == '' || objtxtdelBaselineenddate.value == '' || objtxtdelBaselinework.value =='0' || objtxtdelBaselinework.value =='') 
            //		    {
            //		        alert("Please baseline the ' " + objtxtDeliverable.value + " ' Deliverable before saving the task.")
            //		        return;
            //		    }
            //	    
            //		    
            //		    if ((parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) < parseFloat(objCurrentWork.value) )//- parseFloat(objPlannedWork.value)
            //		    {
            //		        alert('Planned Work hours should be less than or equal to remaining deliverable Work hours('+(parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) +').');//- parseFloat(objPlannedWork.value)
            //		        return;
            //		    }
            //		    
            //		   /* var myDeliverableStartDate=new Date();
            //            myDeliverableStartDate=objtxtdelBasalinestartDate.value;
            //            var StratDate= new Date();
            //            StratDate=objCurrentStartDate.value;
            //            if (myDeliverableStartDate>StratDate)
            //            {
            //                alert("Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").");
            //                return;
            //            }


            //            var myDeliverableEndDate=new Date();
            //            myDeliverableEndDate=objtxtdelBaselineenddate.value;
            //            var EndDate= new Date();
            //            EndDate=objCurrentEndDate.value;
            //            if (EndDate>myDeliverableEndDate)
            //            {
            //                alert("Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").");
            //                return;
            //            }
            //		    */
            //		    
            //            if(disallowDate1GreaterThanDate2(objtxtdelBasalinestartDate,objCurrentStartDate,"Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").")==true)
            //            return;
            //            
            //            if(disallowDate1GreaterThanDate2(objCurrentEndDate,objtxtdelBaselineenddate,"Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").")==true)//,'dd-mmm-yyyy'
            //            return;		    
            //		}
            //		//end addition purvaj		


            //Added by Vijay Dahite On: 9 Jun 2009
            var objDeliverableID = GetObjectReference('frmTaskAssignment', 'txtHidDeliverableID');
            var objModuleID = GetObjectReference('frmTaskAssignment', 'cboModuleID');
            var objSubProjectID = GetObjectReference('frmTaskAssignment', 'cboSubProjectID');
            var objMilestoneID = GetObjectReference('frmTaskAssignment', 'cboMilestoneID');
            var objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
            var objTaskStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
            var objTaskEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
            var strURL;
            var objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');

            //Modified by purvaj on 10 Aug 2009. else codition added. value was not getting set to the variable if the object contains value.
            if (objModuleID == null)
                ModuleID = '';
            else
                ModuleID = objModuleID.value;

            if (objSubProjectID == null)
                SubProjectID = '';
            else
                SubProjectID = objSubProjectID.value;

            if (objMilestoneID == null)
                MilestoneID = '';
            else
                MilestoneID = objMilestoneID.value;

            if (objDeliverableID == null)
                DeliverableID = '';
            else
                DeliverableID = objDeliverableID.value;
            //End Modification purvaj.		

            if (objEmployee != null) {
                var counter;
                counter = 0;

                for (var i = 0; i < objEmployee.length; i++) {
                    if (objEmployee[i].selected)
                        counter++;
                }
                var str;
                str = "<%=CommonFunctions.Application.DistributeWorkInAT%>"
            if (str == "True")
                dblLCEHrs = parseFloat(objCurrentWork.value);
            else
                dblLCEHrs = parseFloat(objCurrentWork.value) * counter;
        }
        else
            dblLCEHrs = parseFloat(objCurrentWork.value);


        strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=<%=m_lngTaskId%>&StartDate=" + encodeURIComponent(objTaskStartDate.value) + "&EndDate=" + encodeURIComponent(objTaskEndDate.value) + "&DeliverableID=" + DeliverableID + "&ModuleID=" + ModuleID + "&SubProjectID=" + SubProjectID + "&MilestoneID=" + MilestoneID + "&Work=" + String(dblLCEHrs);

        //End Addition and Comments by Vijay Dahite On: 9 Jun 2009

        //Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
        //Commented And Added By Usha Pandit On 29.04.2020 For work hour field validation
        ////if (objCurrentWork!=null && objActualWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
        //if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objActualWork.value)) {
        //    alert('Planned Work hours should be greater than Actual work hours (' + objActualWork.value + ').');
        //    objCurrentWork.focus();
        //    objCurrentWork.select();
        //    return;
        //}

        ////if (objCurrentWork!=null && objPlannedWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objPlannedWork.value))
        //if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objPlannedWork.value)) {
        //    alert('Planned Work hours should be greater than Planned work hours of child tasks (' + objPlannedWork.value + ').');
        //    objCurrentWork.focus();
        //    objCurrentWork.select();
        //    return;
        //}

        var curWorkHrs = objtxthidCurrentWork.value;
        var data = JSON.stringify({ HMHours: curWorkHrs });
        var dectxthidCurrentWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", data, false);
        var curActualHrs = objActualWork.value;
        data = JSON.stringify({ DecimalHours: curActualHrs });
        var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);
        var curPlannedHrs = objPlannedWork.value;
        data = JSON.stringify({ DecimalHours: curPlannedHrs });
        var HMPlannedHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);

        if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objActualWork.value)) {
            alert('Planned Work hours should be greater than Actual work hours ( ' + HMActualHrs.d + ' ).');
            objCurrentWork.focus();
            objCurrentWork.select();
            return;
        }

        if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objPlannedWork.value)) {
            alert('Planned Work hours should be greater than Planned work hours of child tasks ( ' + HMPlannedHrs.d + ' ).');
            objCurrentWork.focus();
            objCurrentWork.select();
            return;
        }
        //End Of Added By Usha Pandit On 29.04.2020 For work hour field validation

        //End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

        // End addition purvaj

        //Added by TruptiK on 24-Mar-09
        obCurrentDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
        objCurrentStartDt = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
        objPlannedendDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskEndDate');
        objPlannedStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskStartDate');
        objActualStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualStartDate');

        dtCurrentDate = getDate(obCurrentDate.value);
        dtCurrentStartDt = getDate(objCurrentStartDt.value);
        dtPlannedendDat = getDate(objPlannedendDate.value);
        dtPlannedStartDate = getDate(objPlannedStartDate.value);
        dtActualStartDate = getDate(objActualStartDate.value);

        //Added by GokulP on 08 Oct 2009 for IssueID : 32455
        objActualEndDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualEndDate');
        if (objActualEndDate) {
            dtActualEndDate = getDate(objActualEndDate.value);
        }
        //End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455

        if (objPlannedendDate.value != '' && dtCurrentDate < dtPlannedendDat) {
            alert('Planned End Date should not be less than Planned End Date of child tasks (' + objPlannedendDate.value + ').');
            //obCurrentDate.focus();
            //obCurrentDate.select();
            //alert(obCurrentDate.value);
            //alert(objPlannedendDate.value);
            return;
        }


        if (objPlannedStartDate.value != '' && dtCurrentStartDt > dtPlannedStartDate) {
            alert('Planned Start Date should not be greater than start Date of child tasks (' + objPlannedStartDate.value + ').');
            //obCurrentDate.focus();
            //obCurrentDate.select();
            //alert(obCurrentDate.value);
            //alert(objPlannedendDate.value);
            return;
        }

        if (objCurrentStartDt != null && objActualWork != null && objActualStartDate.value != '' && dtCurrentStartDt > dtActualStartDate) {

            alert('Planned Start Date should not be greater than Actual start Date (' + objActualStartDate.value + ').');
            return;
        }

        //End of addition by TruptiK

        //Added by GokulP ON 08 Oct 2009 for IssueID : 32455 
        if (objActualEndDate) {
            if (obCurrentDate != null && objActualWork != null && objActualEndDate.value != '' && dtCurrentDate < dtActualEndDate) {
                alert('Planned End Date should not be less than Actual End Date (' + objActualEndDate.value + ').');
                return;
            }
        }
        //End of Addition by GokulP ON 08 Oct 2009 for IssueID : 32455

        //Added By VijaYD
        ValidateTask_Baseline(strUrl);
        if (strResult != null && strResult != "") {
            alert(strResult);
            return;
        }
        //End Addition By Vijay
        if (ValidateControls() == false)
            return;

        objBaselineStartDate = GetObjectReference('frmTaskAssignment', 'txthidBaselineStartDate');

        objBaselineEndDate = GetObjectReference('frmTaskAssignment', 'txthidBaselineEndDate');

        objBaselineWork = GetObjectReference('frmTaskAssignment', 'txthidBaselineWork');

        objBaselineStartDate.value = "";
        objBaselineEndDate.value = "";
        objBaselineWork.value = "";


        objTaskType.disabled = false;
        if ("<%=FromTimesheet%>" != "CreateTask")
            objForm.action = "PM_TaskAssignment.aspx?Action=<%=ACTION_SAVE%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
        else
            objForm.action = "PM_TaskAssignment.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&Action=<%=ACTION_SAVE%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016

            objForm.submit();
        }

        function SetAsBaseline() {
            var objBaselineStartDate, objBaselineEndDate, objBaselineWork;
            var objCurrentStartDate, objCurrentEndDate, objCurrentWork;

            objBaselineStartDate = GetObjectReference('frmTaskAssignment', 'txthidBaselineStartDate');
            objBaselineEndDate = GetObjectReference('frmTaskAssignment', 'txthidBaselineEndDate');
            objBaselineWork = GetObjectReference('frmTaskAssignment', 'txthidBaselineWork');

            objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
            objCurrentEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
            objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');

            objBaselineStartDate.value = objCurrentStartDate.value;
            objBaselineEndDate.value = objCurrentEndDate.value;
            objBaselineWork.value = objCurrentWork.value;
        }
        //******************************************************************************************
        ///Added by ManishK  on 7th Feb 06 for PMLifeLine sp6 WFH customization
        //******************************************************************************************
        var strResult = '';
        var req; //PrashantD
        var g_objXHttp;
        function generateRequest(url) {

            // Mozilla and Friends 
            //if (window.XMLHttpRequest) 
            //{ 
            ///	req = new XMLHttpRequest(); 
            //} 
            //else if (window.ActiveXObject) { 
            // Internet Explorer 

            //	req = new ActiveXObject("Microsoft.XMLHTTP"); 
            //} 


            //req.onreadystatechange = state_change;
            //req.open("POST",url,true); //PrashantD
            //PrashantD
            //req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            //req.send(null);

            // TO SEE IF WE ARE RUNNING IN IE 
            var browser = WhichBrowser();
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            var browser = WhichBrowser();
            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            //added By Bharat T on 13th-Oct-2015
            else if (browser == 'IE') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            //End of Added By Bharat T on 13th-Oct-2015
            else {

                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    //xmlDoc.load(req.responseXML);
                    //if (browser == 'FF') // Added By Vaijat K on 20/11/2015
                    //xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                    save_onClick_2();
                }

            }

            //delete req; PrashantD

            return true;
        }
        //var objCbo = GetObjectReference(g_strFrm,g_strDependentCtrl);


        function state_change() {
            var browser = WhichBrowser();
            //debugger;
            // wait until the request is done 
            //if (req.readyState == 4) 

            if (g_objXHttp.readyState == 4) {

                // Make sure request came back OK 
                //if (req.status == 200) 
                if (g_objXHttp.status == 200) {

                    if (window.ActiveXObject || "ActiveXObject" in window) {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        //xmlDoc.loadXML(req.responseText);
                        xmlDoc.loadXML(g_objXHttp.responseText);

                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        //xmlDoc.load(req.responseXML);
                        //if (browser == 'FF') // Added By Vaijat K on 20/11/2015
                        //xmlDoc.load(g_objXHttp.responseXML);
                    }

                    //Save the Result in a Global variable
                    //strResult=req.responseText;
                    strResult = g_objXHttp.responseText;


                    //added by PrashantD for making synchronous XMLHttp request in mozilla. Same code runs in IE also
                    if (WhichBrowser() == 'IE') // Added By Vidya J ON 01/12/2015
                        save_onClick_2();

                }

            }


        }

        //******************************************************************************************
        ///End of Added by ManishK  on 7th Feb 06 for PMLifeLine sp6 WFH customization
        //******************************************************************************************

        function ValidateTask_Baseline(url) {

            // TO SEE IF WE ARE RUNNING IN IE 
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            var browser = WhichBrowser();
            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            //added By Bharat T on 13th-Oct-2015
            else if (browser == 'IE') {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            //End of Added By Bharat T on 13th-Oct-2015
            else {
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    //if (browser == 'FF') // Added By Vaijat K on 20/11/2015
                    //xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                }

            }
            return strResult;
        }

        function TaskValidation_state_change() {
            var browser = WhichBrowser();  // Added By Vaijat K on 20/11/2015
            if (g_objXHttp.readyState == 4) {

                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {
                    //Commented and added By Bharat T on 13th-Oct-2015
                    //if (window.ActiveXObject)
                    if (window.ActiveXObject || "ActiveXObject" in window)
                    //End of Commented and added By Bharat T on 13th-Oct-2015
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);

                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        //if (browser == 'FF')  // Added By Vaijat K on 20/11/2015
                        //xmlDoc.load(g_objXHttp.responseXML);
                    }

                    //Save the Result in a Global variable
                    strResult = g_objXHttp.responseText;

                }

            }


        }
        //Added By Bharat T on 13th-Oct-2015
        function WhichBrowser() {

            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        //End of Added By Bharat T on 13th-Oct-2015

        function setFrameLoader() {

            $("HTML").append("<div id='preloader'></div>");
            $("HTML").append("<div id='fillDiv'></div>");
        }

        function RemoveFrameLoader() {
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            jQuery("#preloader").fadeOut("slow");
            jQuery("#fillDiv").fadeOut("slow");
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
        }

        function Save_OnClick() {

            try {
                //added by Nilesh on 8/1/2015 for loader add on save link
                var Mode = (arguments.length > 0) ? arguments[0] : "0";
                if (Mode == "0") {
                    setFrameLoader();
                    document.body.readonly = true;
                    window.setTimeout('Save_OnClick("1")', 1);
                }
                if (Mode == "1") {
                    //endded by Nilesh on 8/1/2015 for loader add on save link    
                    var objBaselineStartDate, objChkOnHold, blnFlag;
                    var objCurrentWork, objCurrentStartDate, objCurrentEndDate;
                    var dtCurrentStartDate, dtCurrentEndDate, dtTempDate;
                    var objTaskType;
                    //var objChkVoid;
                    
                    //Added by swapnil aswale on 17th Nov 2015 for special character validation
                    var objTaskName;
                    objTaskName = GetObjectReference('frmTaskAssignment', 'txtTaskName');
                    //Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
                    //if (disallowSpecialCharacters(objTaskName, "Characters '/:*?+\"><,\\\\' are not allowed")) return false;
                    if (disallowSpecialCharacters(objTaskName, "Characters '/':*?+\"><,\\\\' are not allowed")) return false;
                    //End of Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
                    //Ended

                    objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
                    objCurrentEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
                    objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');

                    //Commented and Added By Amol Changle On: 13 May 2009
                    //Purpose: To validate task assignment for baselined WBS entities(Deliverable, Module, SubProject and Milestone) using AJAX 

                    // added By purvaj on 7 Nov 2008 for PMLifeLine
                    // validation currentwork should be greater than actual work hours filled
                    objActualWork = GetObjectReference('frmTaskAssignment', 'hid_txtActualWork');
                    objPlannedWork = GetObjectReference('frmTaskAssignment', 'hid_txtPlannedWork');
                    objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    objtxthidCurrentWork = GetObjectReference('frmTaskAssignment', 'txthidCurrentWork');

                    //Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change
                    if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                        objtxthidCurrentWork.value = objCurrentWork.value;
                    //End of Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change


                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    //		
                    //		//added by purvaj on 23 Apr 2009 task validation done against deliverable baseline efforts and dates.
                    //		var objtxtdelBasalinestartDate = GetObjectReference('frmTaskAssignment','txtdelBasalinestartDate');
                    //		var objtxtdelBaselineenddate = GetObjectReference('frmTaskAssignment','txtdelBaselineenddate');
                    //		var objtxtdelBaselinework = GetObjectReference('frmTaskAssignment','txtdelBaselinework');
                    //		var objtxtDeliverableID = GetObjectReference('frmTaskAssignment','txtHidDeliverableID');
                    //		var objtxtDeliverable = GetObjectReference('frmTaskAssignment','txtDeliverableID');
                    //		
                    //		var objtxtdelPlannedTaskEfforts = GetObjectReference('frmTaskAssignment','txtdelPlannedTaskEfforts');
                    //		var objWhizCurrentStartDate = GetObjectReference('frmTaskAssignment','FFE29587WHIZ_txtCurrentStartDate');
                    ////		var objWhizCurrentEndDate = GetObjectReference('frmTaskAssignment','FFE29587WHIZ_txtCurrentEndDate');
                    //		
                    //		if (objtxtDeliverableID != null && objtxtDeliverableID.value !='' && objtxtDeliverableID.value !='0')
                    //		{
                    //		    if (objtxtdelBasalinestartDate.value == '' || objtxtdelBaselineenddate.value == '' || objtxtdelBaselinework.value =='0' || objtxtdelBaselinework.value =='')
                    //		    {
                    //		        alert("Please baseline the ' " + objtxtDeliverable.value + " ' Deliverable before saving the task.")
                    //		        return;
                    //		    }
                    //	    
                    //		    
                    //		    if ((parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) < parseFloat(objCurrentWork.value) ) //- parseFloat(objPlannedWork.value)
                    //		    {
                    //		        alert('Planned Work hours should be less than or equal to remaining deliverable Work hours('+(parseFloat(objtxtdelBaselinework.value) - parseFloat(objtxtdelPlannedTaskEfforts.value) ) +').'); //- parseFloat(objPlannedWork.value)
                    //		        return;
                    //		    }
                    //		    
                    //		    /*var myDeliverableStartDate=new Date();
                    //            myDeliverableStartDate=objtxtdelBasalinestartDate.value;
                    //            var StratDate= new Date();
                    //            StratDate=objCurrentStartDate.value;
                    //            if (myDeliverableStartDate>StratDate)
                    //            {
                    //                alert("Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").");
                    //                return;
                    //            }


                    //            var myDeliverableEndDate=new Date();
                    //            myDeliverableEndDate=objtxtdelBaselineenddate.value;
                    //            var EndDate= new Date();
                    //            EndDate=objCurrentEndDate.value;
                    //            if (EndDate>myDeliverableEndDate)
                    //            {
                    //                alert("Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").");
                    //                return;
                    //            }*/
                    //            
                    //            if(disallowDate1GreaterThanDate2(objtxtdelBasalinestartDate,objCurrentStartDate,"Task start date should be Greater than Deliverable start date ("+objtxtdelBasalinestartDate.value+").",true))
                    //            return;
                    //            
                    //            if(disallowDate1GreaterThanDate2(objCurrentEndDate,objtxtdelBaselineenddate,"Task end date should be less than Deliverable end date ("+objtxtdelBaselineenddate.value+").",true))//,'dd-mmm-yyyy'
                    //            return;
                    //            
                    //		    
                    //		    
                    //		}
                    //		//end addition purvaj

                    var objDeliverableID = GetObjectReference('frmTaskAssignment', 'txtHidDeliverableID');
                    var objModuleID = GetObjectReference('frmTaskAssignment', 'cboModuleID');
                    var objSubProjectID = GetObjectReference('frmTaskAssignment', 'cboSubProjectID');
                    var objMilestoneID = GetObjectReference('frmTaskAssignment', 'cboMilestoneID');
                    var objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
                    var objTaskStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
                    var objTaskEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
                    var strURL;
                    var objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');

                    //Added by Shraddha M on 24,Jun 2009 for PMLifeLine
                    //JS Error while adding task.Module,Sub Project milestone are configurable.If one of these is not on page 
                    //then object is null.
                    var ModuleID;
                    var SubProjectID;
                    var MilestoneID;
                    var DeliverableID;
                    //Modified by purvaj on 10 Aug 2009. else codition added. value was not getting set to the variable if the object contains value.
                    if (objModuleID == null)
                        ModuleID = '';
                    else
                        ModuleID = objModuleID.value;

                    if (objSubProjectID == null)
                        SubProjectID = '';
                    else
                        SubProjectID = objSubProjectID.value;

                    if (objMilestoneID == null)
                        MilestoneID = '';
                    else
                        MilestoneID = objMilestoneID.value;

                    if (objDeliverableID == null)
                        DeliverableID = '';
                    else
                        DeliverableID = objDeliverableID.value;
                    //End Modification purvaj.
                    //End of addition by Shraddha M


                    if (objEmployee != null) {
                        var counter;
                        counter = 0;

                        for (var i = 0; i < objEmployee.length; i++) {
                            if (objEmployee[i].selected)
                                counter++;
                        }
                        var str;
                        str = "<%=CommonFunctions.Application.DistributeWorkInAT%>"
                    if (str == "True")
                        dblLCEHrs = parseFloat(objCurrentWork.value);
                    else
                        dblLCEHrs = parseFloat(objCurrentWork.value) * counter;
                }
                else
                    dblLCEHrs = parseFloat(objCurrentWork.value);

                //Commented and Added by Shraddha M on 24,Jun 2009 for PMLifeLine
                //JS Error while adding task.Module,Sub Project milestone are configurable.If one of these is not on page 
                //then object is null.
                //strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=<%=m_lngTaskId%>&StartDate=" + encodeURIComponent(objTaskStartDate.value) + "&EndDate=" + encodeURIComponent(objTaskEndDate.value)+ "&DeliverableID="+objDeliverableID.value+"&ModuleID="+objModuleID.value+"&SubProjectID="+objSubProjectID.value+"&MilestoneID="+objMilestoneID.value+"&Work="+String(dblLCEHrs);
                strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=<%=m_lngTaskId%>&StartDate=" + encodeURIComponent(objTaskStartDate.value) + "&EndDate=" + encodeURIComponent(objTaskEndDate.value) + "&DeliverableID=" + DeliverableID + "&ModuleID=" + ModuleID + "&SubProjectID=" + SubProjectID + "&MilestoneID=" + MilestoneID + "&Work=" + String(dblLCEHrs);
                //End of comment and addition by Shraddha M

                /* ValidateTask_Baseline(strUrl);
                
                if(strResult!=null && strResult!="")
                {
                    alert(strResult);
                    return;		    
                } */


                //End Addition and Comments by Amol Changle On: 13 May 2009

                //Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                //Commented and Added By Usha Pandit On 29.04.2020 For work hour field validation           

                //if (objCurrentWork!=null && objActualWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
                //if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objActualWork.value)) {

                //    alert('Planned Work hours should be greater than Actual work hours(' + objActualWork.value + ').');
                //    objCurrentWork.focus();
                //    objCurrentWork.select();
                //    return;
                //}
                //if (objCurrentWork!=null && objPlannedWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objPlannedWork.value))
                //if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objPlannedWork.value)) {
                //    alert('Planned Work hours should be greater than Planned work hours of child tasks (' + objPlannedWork.value + ').');
                //    objCurrentWork.focus();
                //    objCurrentWork.select();
                //    return;
                //}
                if (objtxthidCurrentWork != undefined && objtxthidCurrentWork != null) {

                    try {
                        var curWorkHrs = objtxthidCurrentWork.value;
                        var data = JSON.stringify({ HMHours: curWorkHrs });
                        var dectxthidCurrentWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", data, false);
                        var curActualHrs = objActualWork.value;
                        data = JSON.stringify({ DecimalHours: curActualHrs });
                        var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);
                        var curPlannedHrs = objPlannedWork.value;
                        data = JSON.stringify({ DecimalHours: curPlannedHrs });
                        var HMPlannedHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);
                        if (dectxthidCurrentWork != undefined && dectxthidCurrentWork != null) {

                            if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objActualWork.value)) {

                                alert('Planned Work hours should be greater than Actual work hours ( ' + HMActualHrs.d + ' ).');
                                objCurrentWork.focus();
                                objCurrentWork.select();
                                return;
                            }

                            if (objtxthidCurrentWork != null && objPlannedWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objPlannedWork.value)) {
                                alert('Planned Work hours should be greater than Planned work hours of child tasks ( ' + HMPlannedHrs.d + ' ).');
                                objCurrentWork.focus();
                                objCurrentWork.select();
                                return;
                            }
                        }
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                }
                //Commented and Added By Usha Pandit On 29.04.2020 For work hour field validation

                //End of Commented and Modified By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

                // End addition purvaj
                //Added by TruptiK on 24-Mar-09
                obCurrentDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
                objCurrentStartDt = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
                objPlannedendDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskEndDate');
                objPlannedStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtTaskStartDate');
                objActualStartDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualStartDate');
                dtCurrentDate = getDate(obCurrentDate.value);
                dtCurrentStartDt = getDate(objCurrentStartDt.value);
                dtPlannedendDat = getDate(objPlannedendDate.value);
                dtPlannedStartDate = getDate(objPlannedStartDate.value);
                dtActualStartDate = getDate(objActualStartDate.value);

                //Added by GokulP on 08 Oct 2009 for IssueID : 32455
                objActualEndDate = GetObjectReference('frmTaskAssignment', 'hid_txtActualEndDate');
                if (objActualEndDate) {
                    dtActualEndDate = getDate(objActualEndDate.value);
                }
                //End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455

                if (objPlannedendDate.value != '' && dtCurrentDate < dtPlannedendDat) {
                    alert('Planned End Date should not be less than Planned End Date of child tasks (' + objPlannedendDate.value + ').');
                    //obCurrentDate.focus();
                    //obCurrentDate.select();
                    //alert(obCurrentDate.value);
                    //alert(objPlannedendDate.value);
                    return;
                }

                if (objPlannedStartDate.value != '' && dtCurrentStartDt > dtPlannedStartDate) {
                    alert('Planned Start Date should not be greater than  start Date of child tasks (' + objPlannedStartDate.value + ').');
                    //obCurrentDate.focus();
                    //obCurrentDate.select();
                    //alert(obCurrentDate.value);
                    //alert(objPlannedendDate.value);
                    return;
                }

                if (objCurrentStartDt != null && objActualWork != null && objActualStartDate.value != '' && dtCurrentStartDt > dtActualStartDate && objActualStartDate.value != '0') {

                    alert('Planned Start Date should not be greater than Actual start Date (' + objActualStartDate.value + ').');
                    return;
                }
                //Added by GokulP on 08 Oct 2009 for IssueID : 32455	
                if (objActualEndDate) {
                    if (obCurrentDate != null && objActualWork != null && objActualEndDate.value != '' && dtCurrentDate < dtActualEndDate && objActualEndDate.value != '0') {
                        alert('Planned End Date should not be less than Actual End Date (' + objActualEndDate.value + ').');
                        return;
                    }
                }
                //End of Addition by GokulP on 08 Oct 2009 for IssueID : 32455

                //End of addition by TruptiK
                if (ValidateControls() == false)
                    return;
                //******************************************************************************************		
                ///Added by ManishK  on 7th Feb 06 for PMLifeLine sp6 WFH customization
                //******************************************************************************************

                //Added by GokulP on 09 Sept 2009 for IssueID = 33084
                strUrl = strUrl + "&FromPage=AssignTaskEditMode";
                //End of Addition by GokulP on 09 Sept 2009 for IssueID = 33084

                // Added By VijayD On 18 August 2009        
                ValidateTask_Baseline(strUrl);

                if (strResult != null && strResult != "") {
                    //Added by GokulP on 09 Sept 2009 for IssueID = 33083
                    var objEmployeeCombo = GetObjectReference('frmTaskAssignment', 'cboEmployee');
                    if (objEmployeeCombo != null) {
                        objEmployeeCombo.disabled = true;
                    }
                    //End of Addition by GokulP on 09 Sept 2009 for IssueID = 33083	   
                    alert(strResult);
                    return;
                }
                //END Addition By VijayD On 18 August 2009     

                var intCounter;
                var strEmployeeList;
                strEmployeeList = '';
                if (objEmployee != null) {
                    for (intCounter = 0; intCounter < objEmployee.options.length; intCounter++) {
                        if (objEmployee.options[intCounter].selected == true) {
                            strEmployeeList += objEmployee.options[intCounter].value + ','
                        }

                    }
                }
                strUrl = new String();
	        <%'Modified BY NitinVS on 21 May 2007  for PMLifeLine Moved Leave validation to XMLHTTP.aspx.vb page %>
                <% ' strUrl = "PM_TaskAssignment.aspx?FromWhere=XMLHTTP&FromDate=" + encodeURIComponent(objCurrentStartDate.value) + "&ToDate=" + encodeURIComponent(objCurrentEndDate.value)+ "&EmployeeIDs=" + strEmployeeList ; %>
                strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId=<%=m_lngTaskId%>&PROJECT_SETTINGS=<%=m_strProjectSetting%>&FromDate=" + encodeURIComponent(objCurrentStartDate.value) + "&ToDate=" + encodeURIComponent(objCurrentEndDate.value) + "&EmployeeIDs=" + strEmployeeList;
	        <%' End Modification BY NitinVS on 21 May 2007  for PMLifeLine %>
                    /*This code is commented by MrugajaB on 31st May 2006
                    Due to this code task assignment page is not working on mozilla browser*/
                    //Added by PrashantD for Mozilla support
                    //Added By Usha Pandit on 07.05.2020 For showing work hours in H:M format                    
                    var oldobjTxt = objCurrentWork.value;
                    oldobjTxt = oldobjTxt.replace('.', ':');
                    if (oldobjTxt.toString().indexOf(":") != -1) {
                        var chkhr = oldobjTxt.split(":")[0];
                        var chkmin = oldobjTxt.split(":")[1];
                        if (chkhr.length == 1) {
                            chkhr = "0" + chkhr;
                            objCurrentWork.value = chkhr + ":" + chkmin;
                        }
                        if (chkmin.length == 1) {
                            chkmin = chkmin + "0";
                            objCurrentWork.value = chkhr + ":" + chkmin;
                        }
                    }
                    //End Of Added By Usha Pandit on 07.05.2020 For showing work hours in H:M format
                    //PrashantD
                    if (strResult == "")
                        generateRequest(strUrl);
                    //ADDED BY nILESH G ON 7/1/2015 FOR ISSUE ID 2768
                    //window.opener.location.href=window.opener.location.href;

                    //if (generateRequest(strUrl)==true)
                    //nothing code in this if block. Transefered to save_onClick_2()

                    //After if , there are some lines of code. It is also transfered to save_onClick_2()
                }
                //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
                //var MenuTags = document.getElementsByTagName('A');
                //for(i = 0; i < MenuTags.length; i++)
                //{
                //    if (MenuTags[i].className == "Menu")
                //    {
                //        //MenuTags[i].style.display= "none";
                //        MenuTags[i].parentNode.style.display= "none";
                //    }
                //}
                //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
                RemoveFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        //save_onClick_2() is Created by PrashantD
        //Purpose : To make XMLhttp synchronous in mozilla, all code in save_onClick_2() is from stmt of  if (generateRequest(strUrl)==true)
        function save_onClick_2() {

            var objBaselineStartDate; //it was declared previously in Save_OnClick function. 

            if (strResult != null) {
                if (strResult != '') {

                    strResult = strResult.split("<=>");
                    var intCount, Count;
                    for (intCount = 0; intCount < strResult.length; intCount++) {
                        strLH = strResult[intCount];
                        strLH = strLH.split("<==>");
                        for (Count = 0; Count < strLH.length; Count++) {
                            if (strLH[Count] != '') {
                                if (strLH[Count] != ' ') {
                                    if (confirm(strLH[Count] + ' \n Do you want to continue ?') == false) {
                                        //Added by GokulP on 25 Sept 2009 for IssueID = 33083
                                        var objEmployeeCombo = GetObjectReference('frmTaskAssignment', 'cboEmployee');
                                        if (objEmployeeCombo != null && "<%=m_lngTaskId%>" != 0) {
                                        objEmployeeCombo.disabled = true;
                                    }
                                    //End of Addition by GokulP on 25 Sept 2009 for IssueID = 33083	   
                                    strResult = ""; //added by PrashantD for Mozilla support. sync xmlhttp
                                    return;
                                }
                            }
                        }
                    }
                }


            }
        }
        //} this brace was of if stmt of "generateRequest(strUrl)==true" in Save_OnClick function.
        //******************************************************************************************
        ///End of Added by ManishK  on 7th Feb 06 for PMLifeLine sp6 WFH customization
        //******************************************************************************************
        objBaselineStartDate = GetObjectReference('frmTaskAssignment', 'txthidBaselineStartDate');

        //if((objChkVoid != null && objChkVoid.checked == true) || (objChkOnHold != null && objChkOnHold.checked == true))
        //	blnFlag = false;
        if (objBaselineStartDate.value == "") {
			//Code Commented by Noble K 28th Jan 2005
			//if(confirm("<%=MyBase.GetResourceString("SAVE_TASK_WITH_BASELINE")%>"))
            //Code Added by Noble K 28th Jan 2005 for IssueID 15022
            if (confirm("<%=MyBase.GetResourceString("SAVE_TASK_WITH_BASELINE_NEW")%>"))
                //End of Code Addition by Noble K 28th Jan 2005 for IssueID 15022
                SetAsBaseline();
        }
        //Modified By VidyaJ - Browser Issue - IssueID - 809 
        //objTaskType = GetObjectReference('frmTaskAssignment','cboTasktype');
        //objTaskType.disabled = false;
        EnableControls();

        ////Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
        //var MenuTags = document.getElementsByTagName('A');
        //for(i = 0; i < MenuTags.length; i++)
        //{
        //    if (MenuTags[i].className == "Menu")
        //    {
        //        //MenuTags[i].style.display= "none";
        //        MenuTags[i].parentNode.parentNode.style.display= "none";
        //    }
        //}
        //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 

        //modified By VivekP On 3 Jun 2005
        //Added by Nilesh g on 12/1/2015 for issue id 2783
            //Added By Usha Pandit On 14.01.2021 For saving work hours with HH:MM format
            var objtestCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
            
            if (objtestCurrentWork.value != "") {
                if (objtestCurrentWork.value.toString().indexOf(":") == -1 && objtestCurrentWork.value.toString().indexOf(":") == -1) {                    
                    objtestCurrentWork.value = objtestCurrentWork.value + ":00";
                }
            }
            //End Of Added By Usha Pandit On 14.01.2021 For saving work hours with HH:MM format

        if ("<%=m_FromPage%>" == "DailyProgress")
            objForm.action ="PM_TaskAssignment.aspx?From=DailyProgress&Action=<%=ACTION_SAVE%>&UserStoryID=<%=Request.QueryString("UserStoryID")%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
        else if ("<%=FromTimesheet%>" != "CreateTask")
            //endded by Nilesh g on 12/1/2015 for issue id 2783
            //Added by Dhanashri S on 3 Dec 2015 for Issue ID:2572
            objForm.action ="PM_TaskAssignment.aspx?Action=<%=ACTION_SAVE%>&UserStoryID=<%=Request.QueryString("UserStoryID")%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
        //End of Addition by Dhanashri S on 3 Dec 2015

        else
            objForm.action ="PM_TaskAssignment.aspx?ProjectID=<%=TempProjectId%>&FromTimesheet=CreateTask&Action=<%=ACTION_SAVE%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
        //End of Modification On 3 jun 2005




        //Nikhil
        if ("<%=m_strMode%>" != "SubProject") {
            //window.opener.document.forms['frmCommonPage'].action= window.opener.location.href;
            //window.opener.document.forms['frmCommonPage'].submit()

            //window.opener.document.forms['frmCommonPage'].action= window.opener.location.href;
            //window.opener.document.forms['frmCommonPage'].submit()
            refreshParent_Phases('frmCommonPage', 'CommonPage.aspx', 'CommonPage.aspx?FocusOn=SUBTAG', true);
        }
        else
            refreshParent_Phases('frmCommonPage', 'SubProject_CommonPage.aspx', 'SubProject_CommonPage.aspx?FocusOn=SUBTAG', true);
        //nikhil
        //Vidya J
        //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing

        var MenuTags = document.getElementsByTagName('A');
        for (i = 0; i < MenuTags.length; i++) {
            if (MenuTags[i].className == "Menu") {
                //MenuTags[i].style.display= "none";
                MenuTags[i].parentNode.style.display = "none";
            }
        }
        // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
        //Vidya J
        objForm.submit();

        //Added By Bharat Tekade on 13th-May-2016 to refresh os task details page on save action
        if ("<%=m_FromPage%>" == "OSTaskDetails") {
            // refreshParent_Phases('frmInherit_BillingCalendarDetails','ProjectTasksDetails.aspx','SubProject_CommonPage.aspx?FocusOn=SUBTAG',true);
            window.opener.location.href = window.opener.location.href;

            if (isIE() == 'IE')
                window.close();
        }
        //End of Added By Bharat Tekade on 13th-May-2016 to refresh os task details page on save action

        if (window.opener != null) {
            var strParentPage; strParentPage = new String();
            strParentPage = opener.location.href;
            if (strParentPage.toUpperCase().indexOf('GANTTCHARTVIEW.ASPX') != -1) {
                opener.location.href = '../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=<%=m_strGanttView%>';
             }
             if (strParentPage.toUpperCase().indexOf('WBS_GANTTCHARTVIEW.ASPX') != -1) {
                 opener.location.href = '../Home/WBS_GANTTCHARTVIEW.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=<%=m_strGanttView%>';
                }
            }

        }
        //End of addition by PrashantD

        // Modified By VidyaJ - Browser Issue - IssueID - 809 
        function EnableControls() {
            var objCntrl;
            var intCnt = 0;

            for (intCnt = 0; intCnt < document.forms[0].elements.length; intCnt++)       // Modified by puneet m on 23-12-2015
            {
                document.forms[0].elements[intCnt].disabled = false;
            }
        }

        function Back_OnClick() {

            window.location.href = "../PM/PM_AssignedTaskList.aspx?FromWhere=PM&MasterTagID=<%=m_lngTagID%>&<%=m_strFilterQueryString%>";
        }

        function ShowSchedule_OnClick() {

            var objEmployee, objCurrentStartDate, objCurrentEndDate, strEmployeeList, intCtr;

            objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');
            if (disallowBlank(objEmployee, "<%=MyBase.GetResourceString("SELECT_RESOURCES")%>", true))
            return;

        objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
        if (disallowBlank(objCurrentStartDate, "<%=MyBase.GetResourceString("ENTER_STARTDATE")%>", true))
            return;

        objCurrentEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
        if (disallowBlank(objCurrentEndDate, "<%=MyBase.GetResourceString("ENTER_ENDDATE")%>", true))
            return;

        if (disallowDate1LessThanDate2(objCurrentEndDate, objCurrentStartDate, "<%=MyBase.GetResourceString("ENDDATE_LESSTHAN_STARTDATE")%>", true))
            return;

        strEmployeeList = "";
        if (objEmployee != null) {
            for (intCtr = 0; intCtr < objEmployee.options.length; intCtr++) {
                //Modified By VidyaJ - Browser Issue - IssueID - 809 
                //() brackets are replaced with [] brackets
                if (objEmployee.options[intCtr].selected == true)
                    strEmployeeList = strEmployeeList + objEmployee.options[intCtr].value + ",";
                //End modification
            }
        }
        if (strEmployeeList != "") {
            strEmployeeList = strEmployeeList.substring(0, strEmployeeList.length - 1);

        }
        //Modified by ShraddhaM on Date 21 June,2006 for PMLifeLine Issue ID.4168


        //Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'PM_TaskAssignment.aspx/GenrateURLToken',
            data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", EmployeeList: strEmployeeList, FromDate: objCurrentStartDate.value, ToDate: objCurrentEndDate.value }),
                success: function (Result) {
                    window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + strEmployeeList + "&PKToken=" + Result.d + "&FromDate=" + objCurrentStartDate.value + "&ToDate=" + objCurrentEndDate.value, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");

                },
                error: function () {
                    //  alert("Error")
                }
            });

            //End of addition by Yogesh J on 19-Jan-2016

            //window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + strEmployeeList + "&FromDate=" + objCurrentStartDate.value + "&ToDate=" + objCurrentEndDate.value, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");
            //Ended by ShraddhaM on Date 21 June,2006 for PMLifeLine Issue ID.4168
        }

	/*function AddResources_OnClick()
	{
//		window.open("../PM/PM_AddNewResource.asp?FromWhere=<%=Request.QueryString("FromWhere")%>& FromSkill=True" ,"", "resizable = yes, scrollbars = yes, left = " + (window.screen.width - 800)/2 + ", top = " + (window.screen.height - 650)/2 + ", width = 800, height = 650");
        //	}*/

        function AssignResources_OnClick(intTaskId, intEmployeeID) {

            var objTaskType, objStartDate, objCurrentWork, strMsg1, strMsg;

            strMsg1 = "<%=MyBase.GetResourceString("BEFORE_ASSIGNING_RESOURCES")%>";

        strMsg = strMsg1 + " " + "<%=MyBase.GetResourceString("SELECT_TASK_TYPE")%>";
        objTaskType = GetObjectReference('frmTaskAssignment', 'cboTasktype');
        if (disallowBlank(objTaskType, strMsg, true))
            return;

        strMsg = strMsg1 + " " + "<%=MyBase.GetResourceString("ENTER_STARTDATE")%>";
        objStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');

        if (disallowBlank(objStartDate, strMsg, true))
            return;



        strMsg = "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>";
        objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');

        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
        objtxthidCurrentWork = GetObjectReference('frmTaskAssignment', 'txthidCurrentWork');

        //Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change
        if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
            objtxthidCurrentWork.value = objCurrentWork.value;
        //End of Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change

        if (objCurrentWork.value.indexOf(':') == -1) {
            //alert("Please enter Work (hrs) in hh:mm format.");
            //return false;
        }
        objCurrentWork.value = objCurrentWork.value.replace(/:/g, ".");
        var precision = '';
        if (objCurrentWork.value.indexOf(".") != -1) {
            precision = objCurrentWork.value.split(".")[1];
        }

        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   

        if (precision != "" && precision != undefined) {
            if (precision.length > 2) {
                alert("Please enter minutes in two decimal and less than 60.");
                return false;
            }
        }
        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

        //Commented and Added by Usha Pandit on 16.04.2019 for Work field alert issue for minutes length

        //if (precision > 60) {
        //    alert('Please enter number in minute part less than 60.');
        //    return false;
        //    }

        if (precision != "" && precision != undefined) {
            if (precision > 59 || precision < 0) {
                alert('Please enter minutes between (0-59) range.');
                return false;
            }
        }

        //End of Added by Usha Pandit on 16.04.2019 for Work field alert issue for minutes length

        if (precision == 60) {
            objCurrentWork.value = (objCurrentWork.value.split(".")[0] - 0) + 1;
        }
        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

        if (disallowBlank(objCurrentWork, strMsg, true))
            return;
        if (disallowMinValueViolation(objCurrentWork, 0.00001, strMsg, true))
            return;

        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

        //Added By VivekP On 2 Jun 2005
        if (intEmployeeID == 0)
            if ("<%=FromTimesheet%>" != "CreateTask") {
		        //Modified by MrugajaB on 21st Sept 2006 for PMLifeLine SP7 Issue ID.6197
		        //window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&PKToken=<%=m_strToken%>" , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");
                //End Modification

                //Added by Dhanashri S on 1 April 2016 for to generate and validate Token
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: 'PM_TaskAssignment.aspx/GenrateAssignResourcesToken',
                    data: JSON.stringify({ ParentTaskID: "<%=m_lngTaskId%>", TaskID: intTaskId }),
                    success: function (Result) {
                        window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&PKToken=<%=m_strToken%>&PKAssignResourcesToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");

                    },
                    error: function () {
                        alert("Error")
                    }
                });

                //End of addition by Dhanashri S on 1 April 2016


            }
            else {
                window.open("../PM/PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&PKToken=<%=m_strToken%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");
            }
        else {
			<%If m_strProjectSetting = PROJECT_SETTING_ACTIVITY Then%>
            if ("<%=FromTimesheet%>" != "CreateTask") {
                window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=<%=m_lngTaskId%>&ResourceID=" + intEmployeeID.toString() + "&PKToken=<%=m_strToken%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 770) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=770,height=500");
                    }
                    else
                        window.open("../PM/PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&ParentTaskID=<%=m_lngTaskId%>&TaskID=<%=m_lngTaskId%>&ResourceID=" + intEmployeeID.toString() + "&PKToken=<%=m_strToken%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 770) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=770,height=500");
			<%ElseIf m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION Then%>
            if ("<%=FromTimesheet%>" != "CreateTask") {

                window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&ResourceID=" + intEmployeeID.toString() + "&PKToken=<%=m_strToken%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");
                    }
                    else
                        window.open("../PM/PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&ResourceID=" + intEmployeeID.toString() + "&PKToken=<%=m_strToken%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");
			<%End If%>	

        }
			//End Of Addition On 3 jun 2005

		/*if(intEmployeeID == 0)
			window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>& TaskID=" + intTaskId.toString(), "", "resizable = yes, scrollbars = no, left = " + (window.screen.width - 550)/2 + ", top = " + (window.screen.height - 350)/2 + ", width = 650, height = 450");
	//	else
	//	{
	//		<%If m_strProjectSetting = PROJECT_SETTING_ACTIVITY Then%>
	//			window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=<%=m_lngTaskId%>&ResourceID=" + intEmployeeID.toString(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");
	//		<%ElseIf m_strProjectSetting = PROJECT_SETTING_EFFORT_DISTRIBUTION Then%>
	//			window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&ResourceID=" + intEmployeeID.toString(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");
	//		<%End If%>	
	//	}*/
			//window.open("../PM/PM_AssignTaskResources.aspx?ParentTaskID=<%=m_lngTaskId%>&TaskID=" + intTaskId.toString() + "&ResourceID=" + intEmployeeID.toString(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");		
        }

        function DeleteResources_OnClick() {
            var objChkResources, intCtr, blnSubmit;

            objChkResources = GetObjectReference('frmTaskAssignment', 'chkDelete', true);
            if (objChkResources == null)
                return;

            blnSubmit = false;
            for (intCtr = 0; intCtr < objChkResources.length; intCtr++) {
                if (objChkResources[intCtr].checked == true) {
                    blnSubmit = true;
                    break;
                }
            }
            if (blnSubmit == true) {
                if (confirm("<%=MyBase.GetResourceString("CONFIRM_DELETE_RESOURCES")%>") == true) {
                var objTaskType;
                //Commented And Added By Usha PAndit On 29.06.2019 for javascript error
                //objTaskType = GetObjectReference('frmTaskAssignment','cboTasktype');
                objTaskType = GetObjectReference('frmTaskAssignment', 'cboTasktype', true);
                //End Of Added By Usha PAndit On 29.06.2019 for javascript error

                objTaskType.disabled = false;
                //Modified By VivekP On 4 Jun 2005
                if ("<%=FromTimesheet%>" != "CreateTask")
                    objForm.action ="PM_TaskAssignment.aspx?Action=<%=ACTION_DELETE_RESOURCES%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "&<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
                else
                    objForm.action ="PM_TaskAssignment.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Action=<%=ACTION_DELETE_RESOURCES%>&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "&<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
                //End Of Modification On 4 Jun 2005

                //Added by Dhanashri S on 12 Oct 2016 For Page Loader
                setFrameLoader();
                //End of Addition by Dhanashri S on 12 Oct 2016

                objForm.submit();
            }
        }
        else {
            alert("<%=MyBase.GetResourceString("SELECT_RESOURCE_TO_DELETE")%>");
            }
        }
        /*added by harshk on 22/08/2005 for sp4 IssueID 120,121 */
        function ValidateResourceDate(objSDt, objEDt) {
            var objResourceStartDate, objResourceEndDate, objEmp
            var dtResourceStartDate, dtResourceEndDate
            var intIndex = 0;
            var strMsg;
            objEmp = GetObjectReference('frmTaskAssignment', 'cboEmployee');
            objResourceStartDate = GetObjectReference('frmTaskAssignment', 'cboResourceStartDate');
            objResourceEndDate = GetObjectReference('frmTaskAssignment', 'cboResourceEndDate');
            if (objEmp != null && objResourceStartDate != null && objResourceEndDate != null) {
                for (intIndex = 0; intIndex < objEmp.length; intIndex++) {
                    if (objEmp[intIndex].selected) {
                        if (objEmp.multiple) {
                            dtResourceStartDate = getDate(objResourceStartDate[intIndex + 1].text);
                            dtResourceEndDate = getDate(objResourceEndDate[intIndex + 1].text);
                            if (DateDiff(objSDt, dtResourceStartDate, "d") > 0) {
                                strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>';
                            //strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text + '-' + objResourceStartDate[intIndex + 1].text);
                            strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text);
                            strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[intIndex + 1].text);
                            strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[intIndex + 1].text);
                            alert(strMsg)
                            return false;
                        }
                        if (DateDiff(dtResourceEndDate, objEDt, "d") > 0) {
                            strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>';
                            //strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text + '-' + objResourceEndDate[intIndex + 1].text);
                            strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text);
                            strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[intIndex + 1].text);
                            strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[intIndex + 1].text);
                            alert(strMsg)
                            return false;
                        }
                    }
                    else {
                        dtResourceStartDate = getDate(objResourceStartDate[intIndex].text);
                        dtResourceEndDate = getDate(objResourceEndDate[intIndex].text);
                        if (DateDiff(objSDt, dtResourceStartDate, "d") > 0) {
                            strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>';
                            strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text);
                            strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[intIndex].text);
                            strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[intIndex].text);
                            alert(strMsg);
                            return false;
                        }
                        if (DateDiff(dtResourceEndDate, objEDt, "d") > 0) {
                            strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>';
                                strMsg = replaceSubstring(strMsg, '<=>', objEmp[intIndex].text);
                                strMsg = replaceSubstring(strMsg, '<==>', objResourceStartDate[intIndex].text);
                                strMsg = replaceSubstring(strMsg, '<===>', objResourceEndDate[intIndex].text);
                                alert(strMsg);
                                return false;
                            }
                        }
                    }
                }
            }
            return true;
        }

        /*end added by harshk on 22/08/2005 for sp4 IssueID 120,121 */
        function ValidateControls() {
            //debugger;
            var intCompanyHrsPerDay, intCompanyWeekDays, intHolidays, intCount, intCnt, intDays;
            var strMsg, bitHoliday, dtCurrentStartDate, dtCurrentEndDate, dtCurrentDate, dtHoliday;
            var dblAvgHoursPerDay, intResourceCount, dblTotalWork, dblTotalDuration, strHolidayList;
            var objTaskName, objTaskNotes, objEmployee, objCurrentWork, objCurrentStartDate, objCurrentEndDate;
            var objPriority, objPhaseId, objPhase, objModuleId, objModule, objSubProjectId;
            var objSubProject, objMilestoneId, objMilestone, objProjectEstimationTypeId;
            var dblLCEHrs, dtmActStartDate, CWork;
            var dtProjectStartDate, dtProjectEndDate;
            //var objChkVoid;
            PopulateDefaultValues()
            dblLCEHrs = "<%=m_strCurrentWork%>";
        if ((dblLCEHrs == null) || (dblLCEHrs == ""))
            dblLCEHrs = "0";
        dtmActStartDate = "<%=m_strActualStartDate%>";
        if (dtmActStartDate == null)
            dtmActStartDate = "";

        objTaskName = GetObjectReference('frmTaskAssignment', 'txtTaskName');
        //Commented By JyotiG
        //Start
        //if(disallowBlank(objTaskName, "<%=MyBase.GetResourceString("ENTER_TASKNAME")%>", true))
        if (disallowBlank(objTaskName, '<%=MyBase.GetResourceString("ENTER_TASKNAME")%>') == true)
            //End
            return false;

        objTaskNotes = GetObjectReference('frmTaskAssignment', 'txtTaskNotes');
        if (disallowMaxlengthViolation(objTaskNotes, 2000, "<%=MyBase.GetResourceString("MAXLENGTH_OF_TASKNOTES")%>", true))
            return false;

        objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');
        //Modified By VidyaJ - Browser Issue - IssueID - 809 
        var objRR = GetObjectReference('frmTaskAssignment', 'rowResource');

        if ((objEmployee != null) && (objRR.style.display != "none"))
        //End Of Code Modification By VidyaJ - Browser Issue - IssueID - 809 

        {
            if (disallowBlank(objEmployee, "<%=MyBase.GetResourceString("SELECT_RESOURCES")%>", true))
                return false;
        }

        objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
        var objcurworkval = objCurrentWork.value;
        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
        objtxthidCurrentWork = GetObjectReference('frmTaskAssignment', 'txthidCurrentWork');

        //Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change
        if (objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
            objtxthidCurrentWork.value = objCurrentWork.value;
        //End of Added by Usha Pandit on 01-Apr-2019 Purpose::PbNIT 2 Work field change

        if (disallowBlank(objCurrentWork, "'Work (H:M)' should not be left blank.", true)) {
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');

            objCurrentWork.value = objcurworkval
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

            return false;
        }
        //debugger;

        if (objCurrentWork.value.indexOf(".") != -1) {
            objCurrentWork.value = objcurworkval;
            alert("Please enter Work (hrs) in H:M format.");
            setFocus(objCurrentWork);
            return false;
        }


        objCurrentWork.value = objCurrentWork.value.replace(":", ".");
        var isdigit = isNumeric(objCurrentWork.value);
        objCurrentWork.value = objcurworkval;
        if (isdigit == false) {
            alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
            setFocus(objCurrentWork);
            return false;
        }



        if (objCurrentWork.value.indexOf(":") != -1) {
            //debugger;
            objCurrentWork.value = objCurrentWork.value.replace(":", ".");
        }
        var blnResult = disallowNonNumeric(objCurrentWork, "Please enter Work (hrs) in H:M format.");

        if (blnResult == true) {
            objCurrentWork.value = objcurworkval;
            setFocus(objCurrentWork);
            return false;
        }

        var minutePart = objcurworkval.split(":")[1];
        if (minutePart == "") {
            objCurrentWork.value = objcurworkval;
            alert("Please enter Work (hrs) in H:M format.");
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objCurrentWork);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }
        if (objCurrentWork.value.indexOf(':') == -1) {
            //Commented and Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
            //alert("Please enter Work (hrs) in hh:mm format.");
            //return false;
            //objCurrentWork.value =objCurrentWork.value + ":00";
            //End of Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
        }
        objCurrentWork.value = objCurrentWork.value.replace(/:/g, ".");

        var precision = '';
        if (objCurrentWork.value.indexOf(".") != -1) {
            precision = objCurrentWork.value.split(".")[1];
        }


        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   

        if (precision.length > 2) {
            objCurrentWork.value = objcurworkval;
            alert("Please enter minutes in two decimal and less than 60.");
            setFocus(objCurrentWork);
            return false;
        }

        // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

        //Commented and Added by Usha Pandit on 16.04.2019 for Work field alert issue for minutes length
        //    if (precision > 60) {
        //    alert('Please enter number in minute part less than 60.');
        //    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
        //    setFocus(objCurrentWork);
        //    return false;
        //}

        if (precision != "" && precision != undefined) {
            if (precision > 59 || precision < 0) {
                alert('Please enter minutes between (0-59) range.');
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                setFocus(objCurrentWork);
                return false;
            }
        }

        //End of Added by Usha Pandit on 16.04.2019 for Work field alert issue for minutes length

        if (precision == 60) {
            objCurrentWork.value = (objCurrentWork.value.split(".")[0] - 0) + 1;
        }
        var pattern = /^\d+(\.\d{1,2})?$/;
        if (pattern.test(objCurrentWork.value)) {
        }
        else {
            //Commented and Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
            //alert("Please enter Work (hrs) in hh:mm format.");
            //objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //return false;
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //objCurrentWork.value =objCurrentWork.value + ":00";
            //End of Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
        }
        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change


        if (disallowMinValueViolation(objCurrentWork, 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true)) {
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            objCurrentWork.value = objcurworkval
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
		//Code Commented by VidyaJ for IssueID - 15398

		//if(parseFloat(objCurrentWork.value) != parseFloat(dblLCEHrs))
		//{			
		//	if((dtmActStartDate != null) && (trimString(dtmActStartDate) != ""))
		//	{
		//		strMsg = "<%=MyBase.GetResourceString("DAILY_ACTIVITY_FILLED_NOT_CHANGED_WORKHOURS")%>";
        //		//strMsg = replaceSubstring(strMsg, "<=>", "LCE");
        //		alert(strMsg);
        //		objCurrentWork.value = dblLCEHrs.toString();
        //		setFocus(objCurrentWork);
        //		return false;
        //	}
        //}

        if (objEmployee != null) {
            var counter;
            counter = 0;

            for (var i = 0; i < objEmployee.length; i++) {
                if (objEmployee[i].selected)
                    counter++;
            }
            //dblLCEHrs = parseFloat(objCurrentWork.value) * counter;

            // START : Integrated by ParagD On 14-Aug-2006 for PMLifeLine SP 7.2

            //Modified by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257				
            var str;

            str ="<%=CommonFunctions.Application.DistributeWorkInAT%>"
            if (str == "True")
                dblLCEHrs = parseFloat(objCurrentWork.value) / counter;
            else
                dblLCEHrs = parseFloat(objCurrentWork.value) * counter;

            //End Modification by SavitaS for TechUnified Issue ID-1257	11
            // END : Integrated by ParagD On 14-Aug-2006 for PMLifeLine SP 7.2
        }
        else
            dblLCEHrs = parseFloat(objCurrentWork.value);

        // START : Integrated by ParagD On 14-Aug-2006 for PMLifeLine SP 7.2		
        //Modified by SavitaS on 24 Mar 2006 for TechUnified Issue ID-1257	
            //debugger;
        var objTotalAllocatedTaskLCE;
            CWork = parseFloat(objCurrentWork.value)
            //-----------------------------Added & Commented By Dipali V on 30th Nov 2021 For Restirct Hours----------
            var curdata = JSON.stringify({ HMHours: CWork });
            var decdblTotalWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", curdata, false);
            CWork = decdblTotalWork.d;
            //-----------------------------End of Added & Commented By Dipali V on 30th Nov 2021 For Restirct Hours----------

             //-----------------------------Added & Commented By Dipali V on 30th Nov 2021 For Restirct Hours----------
            objTotalAllocatedTaskLCE = parseFloat("<%=m_dblTotalAllocatedTaskLCE%>")
            var Duration =  parseFloat(CWork) +  parseFloat(objTotalAllocatedTaskLCE)
            if (parseFloat(Duration) > parseFloat("<%=m_dblTotalLCE%>")) {
       <%-- if (CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>")) {--%>
               //-----------------------------End of Added & Commented By Dipali V on 30th Nov 2021 For Restirct Hours----------
            var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE

                //Commented And Added By Usha Pandit On 27.06.2020 For getting Balanced Hrs in HH: MM format
            //alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + dblBalancedHrs);

            var curBalancedHrs = JSON.stringify({ DecimalHours: dblBalancedHrs.toFixed(2) });
            var HMBalancedHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", curBalancedHrs, false);           
            alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are " + HMBalancedHrs.d);

            //End Of Added By Usha Pandit On 27.06.2020 For getting Balanced Hrs in HH:MM format

            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
        //End Modification by SavitaS for TechUnified Issue ID-1257				
        // END : Integrated by ParagD On 14-Aug-2006 for PMLifeLine SP 7.2

        //Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
        if (dblLCEHrs + parseFloat("<%=m_dblTotalAllocatedTaskLCE%>") > parseFloat("<%=m_dblTotalLCE%>")) {
            var dblBalancedHrs;
            dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
            strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
            strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
            strMsg = replaceSubstring(strMsg, "<==>", dblBalancedHrs.toFixed(2));
            alert(strMsg);
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }

		<%'Modified By NitinVS on 20 Mar 2007 for PMLifeLine SP 8 Regression Issue 12045 %>		

        objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
        dtCurrentStartDate = getDate(objCurrentStartDate.value);
        if (disallowBlank(objCurrentStartDate, "<%=MyBase.GetResourceString("ENTER_STARTDATE")%>", true)) {
            var whizCurrentStartDate = GetObjectReference('frmTaskAssignment', 'FFE29587WHIZ_txtCurrentStartDate');
            if (whizCurrentStartDate != null)
                whizCurrentStartDate.focus();
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
        objCurrentEndDate = GetObjectReference('frmTaskAssignment', 'txtCurrentEndDate');
        dtCurrentEndDate = getDate(objCurrentEndDate.value);
        if (disallowBlank(objCurrentEndDate, "<%=MyBase.GetResourceString("ENTER_ENDDATE")%>", true)) {
            var whizCurrentEndDate = GetObjectReference('frmTaskAssignment', 'FFE29587WHIZ_txtCurrentEndDate');
            if (whizCurrentEndDate != null)
                whizCurrentEndDate.focus();
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }

		<%' END Modified By NitinVS on 20 Mar 2007 for PMLifeLine SP 8 Regression Issue 12045 %>				

        if (disallowDate1LessThanDate2(objCurrentEndDate, objCurrentStartDate, "<%=MyBase.GetResourceString("ENDDATE_LESSTHAN_STARTDATE")%>", true)) {
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
        //Dates not in between the Projects start and End dates.
        dtProjectStartDate = getDate('<%=m_strProjectStartDate%>');
        dtProjectEndDate = getDate('<%=m_strProjectEndDate%>');
        if ((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtCurrentStartDate != null) && (dtCurrentEndDate != null)) {
            if ((dtCurrentStartDate < dtProjectStartDate) || (dtCurrentEndDate > dtProjectEndDate)) {
                strMsg ="<%=MyBase.GetResourceString("TASKDATES_BETWEEN_PROJECTDATES")%>";
                strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
                strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
                alert(strMsg);
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                return false;
            }
        }
		<%If strClientSideScript <> "" Then %>
		<%=strClientSideScript%>
		<%End If%>
        //addedby harshk on 22/08/2005 for sp4 IssueID 120,121 */
        if (intResourceValidation == 1) {
            if (ValidateResourceDate(dtCurrentStartDate, dtCurrentEndDate) == false) {
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                return false;
            }
        }
        //end addition harshk on 22/08/2005 for sp4 IssueID 120,121 
        //Only Used in Edit Mode
        if ("<%=m_lngTaskId%>" != "0") {
            if ("<%=m_blnHasResources%>" != "False") {
                if ("<%=m_strCurrentWork%>" != "") {
                    if (disallowMinValueViolation(objCurrentWork, parseFloat("<%=m_strCurrentWork%>")) == true) {
                        if (confirm("<%=MyBase.GetResourceString("CONFIRM_WORK_HOURS_CHANGE")%>") == false) {
                            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            return false;
                        }
                    }
                }


                dtTempDate = getDate("<%=m_strCurrentStartDate%>");
                if ("<%=m_strCurrentStartDate%>" != "") {
                    if (DateDiff(dtCurrentStartDate, dtTempDate, "d") != 0) {
                        if (confirm("<%=MyBase.GetResourceString("CONFIRM_START_DATE_CHANGE")%>") == false) {
                            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            return false;
                        }
                    }
                }
                dtTempDate = getDate("<%=m_strCurrentEndDate%>");
                if ("<%=m_strCurrentEndDate%>" != "") {
                    if (DateDiff(dtCurrentEndDate, dtTempDate, "d") != 0) {
                        if (confirm("<%=MyBase.GetResourceString("CONFIRM_END_DATE_CHANGE")%>") == false) {
                            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                            return false;
                        }
                    }
                }
            }
        }

        objPriority = GetObjectReference('frmTaskAssignment', 'cboPriority');
        if (disallowBlank(objPriority, "<%=MyBase.GetResourceString("SELECT_PRIORITY")%>", true)) {
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
        if (DynamicValidation() == false) {
            //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            objCurrentWork.value = objCurrentWork.value.split('.').join(':');
            //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
            return false;
        }
        intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
        intCompanyWeekDays = <%=m_lngWeekDays%>;
        intHolidays = 0;
        bitHoliday = false;
        if (strHolidays != "") {
            strMsg ="<%=MyBase.GetResourceString("THEDATES")%>\n";
            strHolidayList = strHolidays.split(',');
            for (intCount = 0; intCount < strHolidayList.length - 1; intCount++) {
                intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
                for (intCnt = 0; intCnt <= intDays; intCnt++) {
                    dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
                    // If the holiday does not fall in the week end, then...
                    if (DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
                    {
                        dtHoliday = getDate(strHolidayList[intCount]);
                        //if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))

                        //Integrated by MrugajaB on 30th APr 2005 for PMLifeLine SP3
                        /*Added Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/
                        if ((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
						//if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))
						/*End of Addition Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/ {
                            bitHoliday = true;
                            //Need the month string
                            strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
                            //Commented And Added By Chakshuta H on 19th-Nov-2015
                            //strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
                            strMsg = strMsg + "-" + dtCurrentDate.getFullYear() + "\n";
                            //End Of Commented And Added By Chakshuta H on 19th-Nov-2015
                            intHolidays = intHolidays + 1;
                        }
                    }
                }
            }
        }
        if (bitHoliday == true)			//Remove Comments after added the function DatePart
        {
            if (!confirm(strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>")) {
                setFocus(objCurrentStartDate);
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                return false;
            }
        }
        if (objcurworkval.indexOf(".") != -1) {
            alert("Please enter Work (hrs) in H:M format.");
            //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            setFocus(objCurrentWork);
            //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
            return false;
        }

        for (intCnt = 0; intCnt <= DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d"); intCnt++) {
            dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
            //Modified by SiddharthS on 17 Feb 2005 for Issue Id 16002
            //Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
            switch (strStartingDay) {
                case "1":
                    if (DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
                        intHolidays = intHolidays + 1;
                    break
                case "2":
                    if (DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
                case "3":
                    if (DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
                case "4":
                    if (DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
                case "5":
                    if (DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
                case "6":
                    if (DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
                case "7":
                    if (DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)
                        intHolidays = intHolidays + 1;
                    break
            }
            //End modification.
        }

        dblAvgHoursPerDay = 0;
		<% ' Modified By NitinVS on 21 Mar 2007 for PMLifeLine SP 8 Regression Issue 11872 %>
		<% ' for Apply Effort Distribution the valid effort is in "dblLCEHrs" %>
		<% 'dblTotalWork = objCurrentWork.value;%>
		//Commented by ShraddhaM for PMLifeLine on 21,Nov 2008
		//In Case 1 Project when DistributedWork In Assign Task is on and you r trying to assign task to multiple resources
		//then 24 hrs validation was wrong.
			//if( "<%=m_lngTaskId%>" == "0" && "<%=m_ApplyEffortDistribution%>" =="False" && "<%=m_HaveSubTaskTypes%>" =="False" && "<%=CommonFunctions.Application.DistributeWorkInAT%>" == "True")			
        if ( "<%=m_lngTaskId%>" == "0" && "<%=m_ApplyEffortDistribution%>" == "False" && "<%=m_HaveSubTaskTypes%>" == "False" && "<%=CommonFunctions.Application.DistributeWorkInAT%>" == "True" && "<%=m_DistributeWorkInAT%>" == "False")
            dblLCEHrs = parseFloat(objCurrentWork.value) / counter;
        else
            dblLCEHrs = parseFloat(objCurrentWork.value);
        //End of comment and addition by ShraddhaM for PMLifeLine on 21,Nov 2008					

        dblTotalWork = dblLCEHrs;

		<% ' End Modification By NitinVS on 21 Mar 2007 for PMLifeLine SP 8 Regression Issue 11872 %>	
/*		Commented because the Effort distribution mode has different flow now.
		<%'If CommonFunctions.Application.DistributeWorkInAT = True Then%>
	//		intResourceCount = 0;
			// If listbox is provided for resource selection, get the number of resources selected.
	//		if(objEmployee !=  null)
	//		{
	//			if(objEmployee.type == "select-multiple")
	//			{
		//			for(intCnt=0; intCnt < objEmployee.length; intCnt++)
			//		{
				//		if(objEmployee.options(intCnt).selected == true)
					//		intResourceCount = intResourceCount + 1;
					//}
					//if(intResourceCount > 1)
				//		dblTotalWork = dblTotalWork / intResourceCount;
			//	}
		//	}
		//<%'End If%>
//*/		

	    //Commented and Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
		 <%--if((dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
		{
			strMsg = "<%=MyBase.GetResourceString("VALID_WORK")%>";
			<%If CommonFunctions.Application.DistributeWorkInAT = True Then%>
				strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("FOR_EACH_RESOURCE")%>");
		
			<%Else%>
				strMsg = replaceSubstring(strMsg, "<=>", ""); 
			<%End If%>
			strMsg = replaceSubstring(strMsg, "<==>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
			alert(strMsg);
			
			setFocus(objCurrentWork);
			return false;
		}--%>

        var MinDAENtryDisplay = "";
        var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
        if (MinDAEntry == 0.25) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:15"
        }
        else if (MinDAEntry == 0.50) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:30"
        }
        else if (MinDAEntry == 0.75) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:45"
        }

        dblTotalWork = objCurrentWork.value;

        //Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box
        var curdblTotalWork = dblTotalWork.replace('.', ':');
        if (curdblTotalWork.toString().indexOf(":") != -1) {
            var chkhr = curdblTotalWork.split(":")[0];
            var chkmin = curdblTotalWork.split(":")[1];
            if (chkhr.length == 1) {
                chkhr = "0" + chkhr;
                curdblTotalWork = chkhr + ":" + chkmin;
            }
            if (chkmin.length == 1) {
                chkmin = chkmin + "0";
                curdblTotalWork = chkhr + ":" + chkmin;
            }
        }

        var curdata = JSON.stringify({ HMHours: curdblTotalWork });
        var decdblTotalWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", curdata, false);
        dblTotalWorkForConfirm = decdblTotalWork.d;
        //End Of Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box                

        if ("<%=m_RestrictByMinHours%>" == "True") {
            if (MinDAEntry == 0.016) {
            }
            else {
                var minutes = dblTotalWork.toString().split('.');
                var p = minutes[0];
                var dec = minutes[1];
                if (dec == undefined) { dec = 0; }
                d = (dec - 0) / 60 + (p - 0);

                if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                  <%--  strMsg = "<%=MyBase.GetResourceString("VALID_WORK")%>";
                    <%If CommonFunctions.Application.DistributeWorkInAT = True Then%>
                    strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("FOR_EACH_RESOURCE")%>");
		
                    <%Else%>
                    strMsg = replaceSubstring(strMsg, "<=>", ""); 
                    <%End If%>
                    strMsg = replaceSubstring(strMsg, "<==>", MinDAENtryDisplay);
                    alert(strMsg);--%>

                    alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                    setFocus(objCurrentWork);
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    return false;
                }
            }
        }
        objCurrentWork.value = objCurrentWork.value.split('.').join(':');

        if (objCurrentWork.value.indexOf(':') == -1) {
            //Commented and Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
            //alert("Please enter Work (hrs) in hh:mm format.");
            //return false;
            objCurrentWork.value = objCurrentWork.value + ":00";
            //End of Added by Usha Pandit on 18.03.2019 Purpose::PbNIT 2 Work field change
        }

        //ENd of Commented and Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change


        dblTotalDuration = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d") + 1;
        //Modified By VidyaJ on 3rd Feb 2004
        //For IssueID -15739
        //dblTotalDuration = dblTotalDuration - intHolidays;
        if (dblTotalDuration - intHolidays != 0) {
		//confirm("<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>") //siddharths
            //return false;
            //}

            //Added By JyotiG
            //Start
            //Issue Id : 6949
            if (str == "True") {
                if ("<%=m_lngTaskId%>" != "0")
                    //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    //dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                    dblAvgHoursPerDay = dblTotalWorkForConfirm / dblTotalDuration;
                //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box

                else {
                    //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    //dblAvgHoursPerDay = dblTotalWork/counter;
                    dblAvgHoursPerDay = dblTotalWorkForConfirm / counter;
                    //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    dblAvgHoursPerDay = dblAvgHoursPerDay / dblTotalDuration;;
                }
            }
            else {
                //End
                //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                //dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
                dblAvgHoursPerDay = dblTotalWorkForConfirm / dblTotalDuration;
                //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
            }
        }
        else {
            //Remove the Comments after inserting the DatePart function.
            if (!confirm("<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>")) {
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                return false;
            }
            dblTotalDuration = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d") + 1;
            //Added By JyotiG
            //Start
            //Issue Id : 6949
            if (str == "True") {
                if ("<%=m_lngTaskId%>" != "0")
                    //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    //dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
                    dblAvgHoursPerDay = dblTotalWorkForConfirm / dblTotalDuration;
                //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                else {
                    //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    //dblAvgHoursPerDay = dblTotalWork/counter;
                    dblAvgHoursPerDay = dblTotalWorkForConfirm / counter;
                    //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                    dblAvgHoursPerDay = dblAvgHoursPerDay / dblTotalDuration;
                }
            }
            else {
                //End
                //Commented And Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                //dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
                dblAvgHoursPerDay = dblTotalWorkForConfirm / dblTotalDuration;
                //End Of Added By Usha Pandit On 07.05.2020 For showing work hours in H:M format in Confirm box
                //Start
            }//End

        }
        if (objEmployee != null) {
            if (objEmployee.value != "") {
                if (dblAvgHoursPerDay > 24) {
                    alert("<%=MyBase.GetResourceString("WORK_PER_DAY_MORE_THAN_24")%>");

                        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

                        setFocus(objCurrentWork);
                        return false;
                    }
                    else if (dblAvgHoursPerDay > intCompanyHrsPerDay) {
                        strMsg = "<%=MyBase.GetResourceString("WORK_PER_DAY_EXEEDS_MAX")%>";
                    //Commented And Added By Usha Pandit on 07.05.2020 For showing work hours in H:M format in Confirm box
                    //strMsg = replaceSubstring(strMsg, "<=>", dblAvgHoursPerDay.toFixed(2));
                    curdata = JSON.stringify({ DecimalHours: dblAvgHoursPerDay.toFixed(2) });
                    var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", curdata, false);
                    strMsg = replaceSubstring(strMsg, "<=>", HMActualHrs.d);
                    //End Of Added By Usha Pandit on 07.05.2020 For showing work hours in H:M format in Confirm box
                    strMsg = replaceSubstring(strMsg, "<==>", intCompanyHrsPerDay.toString());
                    if (!confirm(strMsg)) {
                        //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                        objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change

                        setFocus(objCurrentWork);
                        return false;
                    }
                }
            }
            objEmployee.disabled = false;
        }

        objPhaseId = GetObjectReference('frmTaskAssignment', 'cboPhaseID');
        if (objPhaseId != null) {
            objPhase = GetObjectReference('frmTaskAssignment', 'txthidPhase');
            if (objPhaseId.selectedIndex != -1) {
                //Modified By VidyaJ - Browser Issue - IssueID - 809 
                //Modified by RajashriK for netsape implementation on 18.3.2005
                if (navigator.appName == 'Netscape')
                    objPhase.value = objPhaseId.options[objPhaseId.selectedIndex].innerHTML;
                else
                    objPhase.value = objPhaseId.options(objPhaseId.selectedIndex).innerText;
                //End Of Code modification By RajashriK
                //End Of Code modification By VidyaJ - Browser Issue - IssueID - 809 
            }
            else
                objPhase.value = "";
        }
        //Modified By AmrutaJ For DSS IssueId 3297
        //Module Name of the Task is not shown in Task Mapping

        objModuleId = GetObjectReference('frmTaskAssignment', 'cboModuleID');
        if (objModuleId != null) {
            objModule = GetObjectReference('frmTaskAssignment', 'txthidModule');
            //addition by harshada d for PMLifeLine on 31 March 2006
            if (objModuleId != null) {
                //end of addition by harshada d for PMLifeLine on 31 March 2006
                if (objModuleId.selectedIndex != -1) {
                    //Modified By VidyaJ - Browser Issue - IssueID - 809 
                    //Modified by RajashriK for netsape implementation on 18.3.2005
                    if (navigator.appName == 'Netscape')
                        objModule.value = objModuleId.options[objModuleId.selectedIndex].innerHTML;
                    else
                        objModule.value = objModuleId.options(objModuleId.selectedIndex).innerText;
                    //End Of Code modification By RajashriK
                    //End Of Code modification By VidyaJ - Browser Issue - IssueID - 809 
                }
                //addition by harshada d for PMLifeLine on 31 March 2006
            }
            //end of addition by harshada d for PMLifeLine on 31 March 2006
            else
                objModule.value = "";
        }
        //End Of Modifications By AmrutaJ
        objSubProjectId = GetObjectReference('frmTaskAssignment', 'cboSubProjectID');
        if (objSubProjectId != null) {
            objSubProject = GetObjectReference('frmTaskAssignment', 'txthidSubProject');
            if (objSubProjectId.selectedIndex != -1) {
                //Modified By VidyaJ - Browser Issue - IssueID - 809 
                //Modified by RajashriK for netsape implementation on 18.3.2005
                if (navigator.appName == 'Netscape')
                    objSubProject.value = objSubProjectId.options[objSubProjectId.selectedIndex].innerHTML;
                else
                    objSubProject.value = objSubProjectId.options(objSubProjectId.selectedIndex).innerText;
                //End modification
                //End Of Code modification By VidyaJ - Browser Issue - IssueID - 809 

            }
            else
                objSubProject.value = "";
        }
        objMilestoneId = GetObjectReference('frmTaskAssignment', 'cboMilestoneID');
        if (objMilestoneId != null) {
            objMilestone = GetObjectReference('frmTaskAssignment', 'txthidMilestone');
            if (objMilestoneId.selectedIndex != -1) {
                //Modified By VidyaJ - Browser Issue - IssueID - 809 
                //Modified by RajashriK for netsape implementation on 18.3.2005
                if (navigator.appName == 'Netscape')
                    objMilestone.value = objMilestoneId.options[objMilestoneId.selectedIndex].innerHTML;
                else
                    objMilestone.value = objMilestoneId.options(objMilestoneId.selectedIndex).innerText;
                //End modification by RajashriK
                //End Of Code modification By VidyaJ - Browser Issue - IssueID - 809 			
            }
            else
                objMilestone.value = "";
        }
        objProjectEstimationTypeId = GetObjectReference('frmTaskAssignment', 'cboProjectEstimationTypeID');
        if (objProjectEstimationTypeId != null)
            objProjectEstimationTypeId.disabled = false;

        //Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
        if (document.getElementById('cboUserStory') != null) {
            var NewTaskID = "<%=m_lngTaskId%>"
            var result = AJAXCallWithResult('PM_TaskAssignment.aspx/CheckIterationEfforts', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strEfforts: document.getElementById('txtCurrentWork').value, strTaskID: NewTaskID }), false);
            if (result.d != "") {
                alert(result.d);
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                return false;
            }
            var result = AJAXCallWithResult('PM_TaskAssignment.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: dtCurrentStartDate, strEndDate: dtCurrentEndDate }), false);
            if (result.d != "") {
                var strMsg = String(result.d).split("_");
                if (strMsg[0] == "1") {
                    alert(strMsg[1]);
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    return false;
                }
                else {
                    alert(strMsg[1]);
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    objCurrentWork.value = objCurrentWork.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::PbNIT 2 Work field change
                    return false;
                }
            }
        }
	    //End of Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
		// Confirm the Task void
		/*
		objChkVoid = GetObjectReference('frmTaskAssignment','chkVoid');
		//if("<%=m_lngTaskId%>" != "0")
		//{	
			//if(objChkVoid.checked == true)
			//{
			//	if(confirm("<%=MyBase.GetResourceString("SAVE_AS_VOID_TASK")%>")==false)
            //	{
            //		setFocus(objChkVoid);
            //		return false;
            //	}
            //}
            //}*/


            return true;
        }
        //Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                //timeout: 180000,
                async: async,
                success: function (result) {
                    AjaxResult = result;
                    $(".loadingoverlay", parent.document).css("display", "none");
                    // Stop();
                },
                error: function (xhr, status, error) {
                    //  Stop();
                    //  StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }
        //End of Added By Aniruddh Gujar on 08-Jun-2018 Purpose::To validate Task Efforts with Sprint
        function DynamicValidation() {
            var objControl;

		<%=m_sbValidationScript%>
            return true;
        }
        function ToggleResourceList_OnClick() {
            var objEmployee, objHrefToggleResource;

            objEmployee = GetObjectReference('frmTaskAssignment', 'cboEmployee');
            objHrefToggleResource = GetObjectReference('frmTaskAssignment', 'hrefToggleResource');

            //Modified By VidyaJ - Browser Issue - IssueID - 809 
            var objRR = GetObjectReference('frmTaskAssignment', 'rowResource');
            if (objRR.style.display == "block")
            //End Of Code Modification By VidyaJ - Browser Issue - IssueID - 809
            {
                objEmployee.selectedIndex = -1;
                //Modified By VidyaJ - Browser Issue - IssueID - 809 

                if (navigator.appName == 'Netscape')
                    objHrefToggleResource.innerHTML = "<%=MyBase.GetResourceString("ASSIGN_TASK_TO_RESOURCES")%>";
            else
                objHrefToggleResource.innerText = "<%=MyBase.GetResourceString("ASSIGN_TASK_TO_RESOURCES")%>";
            //End modification

            objRR.style.display = "none";

        }
        else {
            //Modified By VidyaJ - Browser Issue - IssueID - 809 
            //Modified by RajashriK for netsape implementation on 18.3.2005
            if (navigator.appName == 'Netscape')
                objHrefToggleResource.innerHTML = "<%=MyBase.GetResourceString("HIDE_RESOURCES")%>";
            else
                objHrefToggleResource.innerText = "<%=MyBase.GetResourceString("HIDE_RESOURCES")%>";
                //End modification
                //End Of Modification By VidyaJ - Browser Issue - IssueID - 809 				
                objRR.style.display = "block";
            }
        }



        function cboProjectEstimationTypeID_OnChange() {
            var objProjectEstimationTypeID, objProjectEstimationTypeHours, objCurrentWork;
            var intSelectedIndex, dblHours, strMsg;

            objProjectEstimationTypeID = GetObjectReference('frmTaskAssignment', 'cboProjectEstimationTypeID');
            objProjectEstimationTypeHours = GetObjectReference('frmTaskAssignment', 'cboProjectEstimationTypeHours');
            objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtCurrentWork');
            intSelectedIndex = objProjectEstimationTypeID.selectedIndex;
            //Modified By VidyaJ - Browser Issue - IssueID - 809 
            //Modified by RajashriK for netsape implementation on 18.3.2005
            if (navigator.appName == 'Netscape')
                dblHours = objProjectEstimationTypeHours.options[intSelectedIndex].innerHTML;
            else
                dblHours = objProjectEstimationTypeHours.options(intSelectedIndex).innerText;
            //End modification
            //End Of Code Modification By VidyaJ - Browser Issue - IssueID - 809 
            if (isNumeric(dblHours) == true) {
                if (isBlank(objCurrentWork.value) == false) {
                    if (isNumeric(objCurrentWork.value)) {
                        if (parseFloat(objCurrentWork.value) == parseFloat(dblHours))
                            return;
                        strMsg = "<%=MyBase.GetResourceString("APPLY_ESTIMATION_TYPE", False)%>";
                        strMsg = replaceSubstring(strMsg, "<=>", parseFloat(dblHours).toFixed(2).toString());
                        if (confirm(strMsg)) {
                            objCurrentWork.value = dblHours;
                        }
                    }
                }
                else {
                    objCurrentWork.value = dblHours;
                }
            }
        }

        //When the Page is called from SubProject, Module or Change Management tree link and 
        //Apply Activity and Effort Distribution is false.
        function CloseWindow_OnClick() {
		<%If (m_lngReviewActionId > 0 Or m_lngMitigationPlanId > 0 Or m_lngTrainingResourceId > 0 Or
                                  m_strMode <> "") And (m_blnHasResources = False) And m_lngTaskId > 0 Then%>
        alert('<%=MyBase.GetResourceString("PLEASE_ASSIGN_RESOURCES")%>');
        return;
         <%End If%>
            refreshParent('frmCommonPage', 'CommonPage.aspx', 'CommonPage.aspx?FocusOn=SUBTAG', true);
            window.close();
        }

        function SelectDeliverable() {
            var objDeliverableID;
            objDeliverableID = GetObjectReference('frmTaskAssignment', 'txtHidDeliverableID');
            if ("<%=FromTimesheet%>" != "CreateTask")
            window.open("../General/CommonList.aspx?MasterTagID=2176&FromWhere=PM&DeliverableID=" + objDeliverableID.value, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
        else
            window.open("../General/CommonList.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&MasterTagID=2176&FromWhere=PM&DeliverableID=" + objDeliverableID.value, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
        }
        /*	Added By NitinVS on 9 MArch 2005 for Uploading the Document PBNITE SP2 */
        function UploadDoc_OnClick() {
			    //Commented by Yogesh Jalamkar on 02-Mar-2016 to generate Token
			    //Modified By VivekP On 4 jun 2005
				//if ("<%=FromTimesheet%>"!="CreateTask")
				//Modified by MrugajaB on 21st Sept 2006 for PMLifeLine SP7 Issue ID.6197
		    	//Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6636
				//window.open("PM_ProjectDocuments.aspx?Mode=UPLOAD&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
		      	//	window.open("PM_ProjectDocuments.aspx?PageType=<%=m_strMode%>&Mode=UPLOAD&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
			    //End by MonikaI
				//End Modification
			    //	else
				//window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=UPLOAD&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PKToken=<%=m_strToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
                //End Of Modification On 4 Jun 2005
                $.ajax({
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json',
                    url: 'PM_TaskAssignment.aspx/GenrateURLToken_UploadDoc',
                    data: JSON.stringify({ UniqueID: "<%=m_lngTaskId%>", EmployeeID: "<%=Session("intUserID")%>" }),
                    success: function (Result) {
                        if ("<%=FromTimesheet%>" != "CreateTask")
                            window.open("PM_ProjectDocuments.aspx?PageType=<%=m_strMode%>&Mode=UPLOAD&MasterTagID=1038&Flag=Token&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&PkToken=<%=m_strToken%>&FilterParameter=<%=m_strFilterQueryString%>&Token=" + Result.d, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=400");

                        else
                            window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=UPLOAD&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&PKToken=<%=m_strToken%>&FilterParameter=<%=m_strFilterQueryString%>&Token=" + Result.d, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=400");

                },
                error: function () {
                    //  alert("Error")
                }
            });
            //End of addition by Yogesh Jalamkar 02-Mar-2016 to generate Token
        }

        function Document_OnClick(DID) {
            //Modified By vivekP On 4 jun 2005
            if ("<%=FromTimesheet%>" != "CreateTask")
                    window.open("PM_ViewDocument.aspx?MasterTagID=1038&FromWhere=PM&DocumentID=" + DID, "", "left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=300");
                else
                    window.open("PM_ViewDocument.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&MasterTagID=1038&FromWhere=PM&DocumentID=" + DID, "", "left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=300");
            //End Of Modification On 4 Jun 2005	
        }


        function Review_OnClick(DID) {
			<%'Modified By NitinVS on 20 Mar 2007 for PMLifeLine SP 8 Regression Issue 12051 increased window width to 550 from 500 %>
                //Modified By vivekP On 4 jun 2005
                if ("<%=FromTimesheet%>" != "CreateTask")
				//Modified By VarunA on 27-Feb-2008 IssueID-19003
				//Purpose : To remove single quotes after FilterParameter
				//window.open("PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=1038&UniqueID=<%=m_lngTaskId%>&FromWhere=PM&TaskId=<%=m_lngTaskId%>&PkToken=<%=m_strToken%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-400)/2 + ",width=550,height=300");
                    window.open("PM_ProjectDocuments.aspx?Mode=REVIEW&MasterTagID=1038&UniqueID=<%=m_lngTaskId%>&FromWhere=PM&TaskId=<%=m_lngTaskId%>&PkToken=<%=m_strToken%>&FilterParameter=<%=m_strFilterQueryString%>&DocumentID=" + DID, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=550,height=300");
                //End By VarunA on 27-Feb-2008
                else
				//Modified By VarunA on 27-Feb-2008 IssueID-19003
				//Purpose : To remove single quotes after FilterParameter
				//window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=REVIEW&MasterTagID=1038&UniqueID=<%=m_lngTaskId%>&FromWhere=PM&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID + "&PKToken=<%=m_strToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-400)/2 + ",width=550,height=300");
                    window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=REVIEW&MasterTagID=1038&UniqueID=<%=m_lngTaskId%>&FromWhere=PM&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&DocumentID=" + DID + "&PKToken=<%=m_strToken%>", "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=550,height=300");
				//End By VarunA on 27-Feb-2008
				//End Of Modification On 4 Jun 2005	
			<%'End Modification By NitinVS on 20 Mar 2007 for PMLifeLine SP 8 Regression Issue 12051 increased window width to 550 from 500 %>				
        }

        function History_OnClick(DID, DRID) {
            if (DRID != '0' && DRID != '')
                DID = DRID;
            //Modified By vivekP On 4 jun 2005
            if ("<%=FromTimesheet%>" != "CreateTask") {	//Commented and Modified By JyotiG for Token Changes for Issue ID :12486
						//window.open("PM_ProjectDocuments.aspx?Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600"); 
						//Modified By VarunA on 27-Feb-2008 IssueID-19003
						//Purpose : To remove single quotes after FilterParameter
						//window.open("PM_ProjectDocuments.aspx?ParentToken=<%=m_strToken%>&PkToken=<%=m_strToken%>&Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600"); 
                    window.open("PM_ProjectDocuments.aspx?ParentToken=<%=m_strToken%>&PkToken=<%=m_strToken%>&Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&DocumentID=" + DID, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=500,height=600");
                    //End By VarunA on 27-Feb-2008
                }
                else {	//Commented and Modified By JyotiG for Token Changes for Issue ID :12486
						//window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600"); 
						//Modified By VarunA on 27-Feb-2008 IssueID-19003
						//Purpose : To remove single quotes after FilterParameter
						//window.open("PM_ProjectDocuments.aspx?ParentToken=<%=m_strToken%>&PkToken=<%=m_strToken%>&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&DocumentID=" + DID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-600)/2 + ",width=500,height=600"); 
                    window.open("PM_ProjectDocuments.aspx?ParentToken=<%=m_strToken%>&PkToken=<%=m_strToken%>&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=HISTORY&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&DocumentID=" + DID, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=500,height=600");
                //End By VarunA on 27-Feb-2008
            }

            //End Of Modification On 4 Jun 2005	
        }

        function DeleteDocument_OnClick() {	
		'<%MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")%>';

            var intRowCnt, i, blnSelected = false, ans;
            var objChk;

            objChk = GetObjectReference('frmTaskAssignment', 'chkDeleteDocument', true);
            intRowCnt = objChk.length;

            if (intRowCnt > 0)
                for (i = 0; i < intRowCnt; i++)
                    if (objChk[i].checked == true) {
                        blnSelected = true;
                        break;
                    }

            if (blnSelected == false) {
                alert('<%=MyBase.GetResourceString("MSG_NO_RECORD_SELECTED")%>');
                return;
            }

            ans = window.confirm('<%=MyBase.GetResourceString("MSG_DELETE_CONFIRM")%>');
            if (ans == true) {
                //Modified By VivekP On 4 Jun 2005
                if ("<%=FromTimesheet%>" != "CreateTask")
                        objForm.action ="PM_TaskAssignment.aspx?Action=<%=ACTION_DELETE_DOCUMENT%>&FilterParameter='<%=m_strFilterQueryString%>'&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "&<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
                    else
                        objForm.action ="PM_TaskAssignment.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Action=<%=ACTION_DELETE_DOCUMENT%>&FilterParameter='<%=m_strFilterQueryString%>'&TaskId=<%=m_lngTaskId%><% If m_lngReviewActionId > 0 Then Response.Write("&ReviewActionID=" & m_lngReviewActionId.ToString() & "&ReviewStatisticsID=" & m_lngReviewStatisticsId.ToString()) %><%If m_lngMitigationPlanId > 0 Then Response.Write("&MitigationPlanID=" & m_lngMitigationPlanId.ToString() & "&RiskID=" & m_lngRiskId.ToString())%><%If m_lngTrainingResourceId > 0 Then Response.Write("&TrainingResourceID=" & m_lngTrainingResourceId.ToString() & "&TrainingID=" & m_lngTrainingId.ToString())%>&MasterTagID=<%=m_lngTagId%>" + "&<% If m_strMode <> "" Then Response.Write("&PageType=" & m_strMode)%>";
                //End Of Modification on 4 jun 2005
                //Added by Dhanashri S on 12 Oct 2016 For Page Loader
                setFrameLoader();
                //End of Addition by Dhanashri S on 12 Oct 2016

                objForm.submit();

            }

        }












        function AttachURL_OnClick() {

            if ("<%=FromTimesheet%>" != "CreateTask") {

                        window.open("PM_ProjectDocuments.aspx?PageType=<%=m_strMode%>&Mode=URL&MasterTagID=1038&FromWhere=PM&PKAttachURLToken=<%=CommonFunctions.Security.Token.GetToken(m_lngTaskId.ToString() + m_lngTaskId.ToString())%>&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>", "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=350");


                    }
                    else {
                        window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=URL&MasterTagID=1038&FromWhere=PM&PKAttachURLCreateTaskToken=<%=CommonFunctions.Security.Token.GetToken(m_lngTaskId.ToString() + m_lngTaskId.ToString() + TempProjectId.ToString())%>&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>", "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=350");

                    }

				//Modified By VivekP On 4 Jun 2005
				///////if ("<%=FromTimesheet%>"!="CreateTask")
			    //Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6636
				//window.open("PM_ProjectDocuments.aspx?Mode=URL&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&PkToken=<%=m_strToken%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
				//Modified By VarunA on 27-Feb-2008 IssueID-19003
				//Purpose : to remove single quotes after the FilterParameter
				//window.open("PM_ProjectDocuments.aspx?PageType=<%=m_strMode%>&Mode=URL&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'&PkToken=<%=m_strToken%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
				///////////window.open("PM_ProjectDocuments.aspx?PageType=<%=m_strMode%>&Mode=URL&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
				//End By VarunA on 27-Feb-2008
			    //End by MonikaI
				/////////else
				//Modified By VarunA on 27-Feb-2008 IssueID-19003
				//Purpose : to remove single quotes after the FilterParameter and to pass token
				//window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=URL&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter='<%=m_strFilterQueryString%>'" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
			    ///////window.open("PM_ProjectDocuments.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=URL&MasterTagID=1038&FromWhere=PM&UniqueID=<%=m_lngTaskId%>&TaskId=<%=m_lngTaskId%>&FilterParameter=<%=m_strFilterQueryString%>&PkToken=<%=m_strToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
            //End By VarunA on 27-Feb-2008
            //End Of Modification on 4 jun 2005
        }
        /*	End Addition By NitinVS on 9 March 2005 for Uploading the Document PBNITE SP2 */
        //Added By VivekP On 5 Jun 2005

        function CloseTimesheet_OnClick() {
            //window.opener.location.reload(true);

            // START : Commented & Modified By ParagD 4-Sept-2006
            // Purpose : When "CLOSE" window after creation of tasks ,existing Task for that date 
            //			 get updated with blank ProjectID and TaskID 

            // opener.location.href= opener.location.href;
            objCurrentStartDate = GetObjectReference('frmTaskAssignment', 'txtCurrentStartDate');
            //alert(objCurrentStartDate.value);
            opener.location.href = "../PM/PM_DailyActivity.aspx?FromTimesheet=CreateTask&Mode=New&ProjectID=<%=TempProjectId%>&txtDate=" + objCurrentStartDate.value;
            // END : Commented & Modified By ParagD 4-Sept-2006

            window.close()
        }

        //End of addition On 5 Jun 2005 By vivekP
        function TaskTypeID_OnChange(value) {
            //debugger;
		    <%' Added By nitinVS on 10 DEC 2008 if No Custom field defined for Project No Need to Post back the page  %>
            if ("<%=CustomFieldsApplicable%>" != "1")
                return;
		    <%' End Addition By nitinVS on 10 DEC 2008 if No Custom field defined for Project No Need to Post back the page  %>		        

			<%If m_strEnableControlScript <> "" Then %>
			<%=m_strEnableControlScript%>
			<%End If%>

            var strLocation = window.location.href
            if (strLocation.indexOf('TaskTypeID') != -1)
                strLocation = strLocation.substring(0, strLocation.indexOf('&TaskTypeID'))

            //window.location.href = strLocation + "&TaskTypeID=" + value 		
            /* integrated by harshada d for PMLifeLine sem SP7.2 for Issue ID 4518*/
            // Commented and Modified By ParagD On 17-May-2006
            // VERTEX 1933 -	Wild character validation on Task Type Master screen.
            //					If TaskType contains "&" in description ,then page crashes.
            // objForm.action = strLocation + "&TaskTypeID=" + value ;
            // value.replace("&" ,"%26")

            var strNewTaskID = "<%=m_lngTaskId%>";
            var strTagID = "<%=m_lngTagId%>";

            // START : By ParagD On 24-Aug-2006

            if (strLocation.indexOf('Edit') == -1) {
                if (strLocation.indexOf('TaskId') != -1) {
                    strLocation = strLocation.substring(0, strLocation.indexOf('&TaskId'))
					<%'Added By NitinVS on 6 Mar 2007 for PMLifeLine SP 8 Regression Issues IssueID 11105%>
					<% 'Code  added By PradipK on 17 Jan 2007 for IssueID 9633 %>
                    if (strLocation.indexOf('MasterTagID') != -1)
                        strLocation = strLocation.substring(0, strLocation.indexOf('&MasterTagID'))
					<%'//End Addition By PradipK on 17 Jan 2007	%>
					<%'End Addition  By NitinVS on 6 Mar 2007 for PMLifeLine SP 8 Regression Issues IssueID 11105 %>	
                    // START : 25-Aug-2006
                    strLocation = strLocation + "&MasterTagID=" + strTagID + "&TaskId=" + strNewTaskID;
                }
                if (strLocation.indexOf('PM_TaskAssignment') == -1) {
                    strLocation = "../PM/PM_TaskAssignment.aspx?Action=Save" + "&MasterTagID=" + strTagID + "&TaskId=" + strNewTaskID;

                }
                // END : 25-Aug-2006
                // END : By ParagD On 24-Aug-2006
            }
            //alert(strLocation)

            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016

            objForm.action = strLocation + "&TaskTypeID=" + encodeURIComponent(value);

            // END : Commented and Modified By ParagD On 17-May-2006
            //end of integration by harshada d

            objForm.submit();


        }

        //Added By Chakshuta H on 28th Oct 2014 For Suntech Issue
        //Added by NitinC on 19 August 2011 For WhiziblSEM v10.0 (Agile Methodology)
        function isIE() {
            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        function UserStoryID_OnChange(value) {//debugger;


            var objRelease = GetObjectReference('frmTaskAssignment', 'txtRelease');
            var objIteration = GetObjectReference('frmTaskAssignment', 'txtIteration');
            var objtxtHdnIsStoryComplete = GetObjectReference('frmTaskAssignment', 'txtHdnIsStoryComplete');
            //Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
            var objhdnUSStoryPoint = GetObjectReference('frmTaskAssignment', 'hdnUSStoryPoint');
            //End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
            if (value != '') {
                try {
                    var strUrl = "../PM/AjaxCallIteration.aspx?Flag=AssignedTask&UserStoryID=" + value;
                    //Modified by swapnil aswale on 22-12-2015 
                    var brw = isIE();


                    if (brw == "IE") {
                        objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                        objXHttp.onreadystatechange = function () {
                            if (objXHttp.readyState == 4) {
                                if (objXHttp.responseText != null) {
                                    if (objXHttp.responseText.substring(0, 8) == "INFOMSG:")
                                        alert(objXHttp.responseText);
                                    else
                                        var data;
                                    data = objXHttp.responseText;
                                    var strUSDetails = data.split(',');
                                    objRelease.value = strUSDetails[0];
                                    objIteration.value = strUSDetails[1];
                                    objtxtHdnIsStoryComplete.value = strUSDetails[2];
                                    //Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
                                    objhdnUSStoryPoint.value = strUSDetails[3];
                                    //End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
                                }
                            }
                        }
                        objXHttp.open("GET", strUrl, false);
                        objXHttp.send();
                    }
                    else {

                        // Mozilla - based browser , Netscape
                        objXHttp = new XMLHttpRequest();
                        //hook the event handler
                        //g_objXHttp.onreadystatechange = TaskValidation_state_change;
                        //prepare the call, http method=GET, false=asynchronous call
                        objXHttp.open("GET", strUrl, false);
                        //finally send the call
                        objXHttp.send(null);

                        if (objXHttp.responseText != null) {
                            xmlDoc = document.implementation.createDocument("", "", null);
                            xmlDoc.async = false;
                            //added by Nilesh g on 10/12/2015 for issue id 2721
                            if (brw == "FF")
                                xmlDoc.load(objXHttp.responseXML);
                            var data;
                            data = objXHttp.responseText;
                            var strUSDetails = data.split(',');
                            objRelease.value = strUSDetails[0];
                            objIteration.value = strUSDetails[1];
                            objtxtHdnIsStoryComplete.value = strUSDetails[2];
                            //strResult=g_objXHttp.responseText;
                            //Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
                            objhdnUSStoryPoint.value = strUSDetails[3];
                            //End of Added By Aniruddh Gujar on 26-Apr-2018 Purpose::PbNIT Agile Changes
                        }
                    }
                } catch (e) { }

                //objForm.action="PM_TaskAssignment.aspx?Mode=New&MasterTagID=1038&PageNumber=-1undefined&UserStoryID="+value;
                //objForm.submit();
                return;
            }
            else {
                objRelease.value = '';
                objIteration.value = '';
            }
        }
        //End Addition
        ////Ended By Chakshuta H on 28th Oct 2014 For Suntech Issue
        //nikhil
        function refreshParent_Phases(parentFormName, parentPage, submitToPage) {

            var strParentPage;
            strParentPage = new String();
			//commented and Added By Rupali Nimbalkar On:15 NOV 2103
		<%If m_strMode <> "" Then %>
             strParentPage = opener.location.href;
		<%End If%>	
            if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1) {
                window.opener.document.forms[parentFormName].action = submitToPage;
                try { window.opener.document.forms[parentFormName].submit(); } catch (e) { }//Modified By Ninad WAF3_PB_64
            }


        }
        //nikhil
        function PopulateDefaultValues() {
		<%If strDefaultScript <> "" Then%>
		<%=strDefaultScript%>
		<%End If%>
        }
	<%
        if m_blnShowDefaults = True Then %>
        PopulateDefaultValues()
	<%	end if
	%>	

</script>

</body>
</html>

<%'XMLHTTP_GetLeaves%>
