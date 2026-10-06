<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_TaskCostCategory.aspx.vb" Inherits="PbNIT.PM_TaskCostCategory" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<head>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

    <!--Including files & Libraries by Miiint Solutions-->
    <%--/*Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
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
    <%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>
</head>
<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmPM_TaskCostCategory" method="post">

        <%PageInit()%>
    </form>
    <script language="javascript">
        var objform = GetFormReference('frmPM_TaskCostCategory');
        var objdivlist = GetObjectReference('frmPM_TaskCostCategory', 'PageDiv');
        var strTaskIDs = '';
        var strCostCategory = '';

        <%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

        //The div tag has id as PageDiv 
        function window_onload() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                if (intDivHeight < 100) intDivHeight = 100;
                //Commented and added by Yogesh J on 11/12/2015
                //objdivlist.style.height = intDivHeight;
                objdivlist.style.height = intDivHeight + 'px';
            }
            strTaskIDs = '';
        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                if (intDivHeight < 100) intDivHeight = 100;
                //Commented and added by Yogesh J on 11/12/2015
                //objdivlist.style.height = intDivHeight;
                objdivlist.style.height = intDivHeight + 'px';
            }
        }


        function Show_OnClick() {
            var objFromDate, objToDate, intProjectID, strTaskType, objTaskType, intCnt, intEmployeeID;

            objFromDate = GetObjectReference('frmPM_TaskCostCategory', 'txtFromDate').value;
            objToDate = GetObjectReference('frmPM_TaskCostCategory', 'txtToDate').value;
            intProjectID = GetObjectReference('frmPM_TaskCostCategory', 'cboProject').value;

            objTaskType = GetObjectReference('frmPM_TaskCostCategory', 'optTaskType', true);
            intEmployeeID = GetObjectReference('frmPM_TaskCostCategory', 'cboResource').value;
            for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                if (objTaskType[intCnt].checked)
                    strTaskType = objTaskType[intCnt].value;
            }

            if (IsValidInput() == true) {
                objform.action = "PM_TaskCostCategory.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&EmployeeID=" + intEmployeeID;
                objform.submit();
            }
        }

        function IsValidInput() {
            var objFromDate, objToDate;

            objFromDate = GetObjectReference('frmPM_TaskCostCategory', 'txtFromDate');
            objToDate = GetObjectReference('frmPM_TaskCostCategory', 'txtToDate');

            if (objFromDate.value == '') {
                alert("From Date Should not be Blank")
                return false;
            }

            if (objToDate.value == '') {
                alert("To Date Should not be Blank")
                return false;
            }

            if (disallowDate1GreaterThanDate2(objFromDate, objToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
                return false;
            return true;
        }

        function Save_OnClick() {
            var objFromDate, objToDate, intProjectID, strTaskType, objTaskIDs, objTaskType, intCostCategory;
            var objCC, intCC;
            objFromDate = GetObjectReference('frmPM_TaskCostCategory', 'txtFromDate').value;
            objToDate = GetObjectReference('frmPM_TaskCostCategory', 'txtToDate').value;
            intProjectID = GetObjectReference('frmPM_TaskCostCategory', 'cboProject').value;

            objTaskType = GetObjectReference('frmPM_TaskCostCategory', 'optTaskType', true);
            intCostCategory = GetObjectReference('frmPM_TaskCostCategory', 'cboCostCategory').value;

            for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                if (objTaskType[intCnt].checked)
                    strTaskType = objTaskType[intCnt].value;
            }

            if (IsValidInput() == true) {
                objform.action = "PM_TaskCostCategory.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&TaskIDs=" + strTaskIDs + "&CostCategory=" + intCostCategory + "&CCArray=" + strCostCategory;
                objform.submit()
            }
        }

        function CheckChildTasks(intTaskID, intChildCount) {
            var strCheckBox, objCheckbox, intIndex, blnChecked, objTaskType, strTaskType, i;
            var strTextBox, objTextBox;

            objTaskType = GetObjectReference('frmPM_TaskCostCategory', 'optTaskType', true);
            for (intCnt = 0; intCnt < objTaskType.length; intCnt++) {
                if (objTaskType[intCnt].checked)
                    strTaskType = objTaskType[intCnt].value;
            }

            strCheckBox = 'chk' + intTaskID + '_0';
            objCheckbox = GetObjectReference('frmPM_TaskCostCategory', strCheckBox);

            if (strTaskType == 'O' || strTaskType == 'R') {
                if (objCheckbox.checked == true) {
                    blnChecked = true;
                    if (strTaskIDs.indexOf(intTaskID + ',') == -1) {
                        strTaskIDs = strTaskIDs + intTaskID + ',';
                    }
                }
                else {
                    blnChecked = false;
                    if (strTaskIDs.indexOf(intTaskID + ',') != -1) {
                        strTaskIDs = strTaskIDs.replace(intTaskID + ',', '');
                    }
                }

                for (i = 1; i <= intChildCount; i++) {

                    strCheckBox = 'chk' + intTaskID + '_' + i;
                    objCheckbox = GetObjectReference('frmPM_TaskCostCategory', strCheckBox);

                    strTextBox = 'txt' + intTaskID + '_' + i;
                    objTextbox = GetObjectReference('frmPM_TaskCostCategory', strTextBox);

                    if (blnChecked == true) {
                        objCheckbox.checked = true;
                        objCheckbox.disabled = true;
                        if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1) {
                            strTaskIDs = strTaskIDs + objCheckbox.value + ',';
                        }

                    }
                    else {

                        if (strTaskIDs.indexOf(objCheckbox.value + ',') != -1) {
                            strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                        }
                        if (objTextbox.value == 'False') {
                            objCheckbox.checked = false;
                            objCheckbox.disabled = false;
                        }
                    }

                }
            }

            if (strTaskType == 'M' || strTaskType == 'B') {
                if (objCheckbox.checked == true) {
                    blnChecked = true;
                    if (strTaskIDs.indexOf(intTaskID + ',') == -1) {
                        strTaskIDs = strTaskIDs + intTaskID + ',';
                    }
                }
                else {
                    blnChecked = true;
                    if (strTaskIDs.indexOf(intTaskID + ',') > -1) {
                        strTaskIDs = strTaskIDs.replace(intTaskID + ',', '');
                    }
                }
            }
        }

        function CheckTask(intTaskID, intCount) {
            var strCheckBox, objCheckbox, intIndex, blnChecked;
            var strTextBox, objTextbox;

            strCheckBox = "chk" + intTaskID + "_" + intCount;
            strTextBox = "txtCC" + intTaskID + "_" + intCount;

            objCheckbox = GetObjectReference('frmPM_TaskCostCategory', strCheckBox);
            objTextbox = GetObjectReference('frmPM_TaskCostCategory', strTextBox);
            if (objCheckbox.checked == true) {
                blnChecked = true;
                if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1) {
                    strTaskIDs = strTaskIDs + objCheckbox.value + ',';
                }

                if (strCostCategory.indexOf(objTextbox.value + ',') == -1) {
                    strCostCategory = strCostCategory + objTextbox.value + ',';
                }
            }
            else {
                blnChecked = false;
                if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1) {
                    strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',', '');
                }
                if (strCostCategory.indexOf(objTextbox.value + ',') > -1) {
                    strCostCategory = strCostCategory.replace(objTextbox.value + ',', '');
                }
            }
        }
        function GetCostCategory(intTaskID, intCount, intEmployeeID) {

            var strTextBox, intIndex, objTextbox, intProjectID;
            strTextBox = "txtCC" + intTaskID + "_" + intCount;
            objTextbox = GetObjectReference('frmPM_TaskCostCategory', strTextBox);
            intProjectID = GetObjectReference('frmPM_TaskCostCategory', 'cboProject').value;
            window.open("PM_CostCategory.aspx?FromWhere=PM&EmployeeID=" + intEmployeeID + "&ProjectID=" + intProjectID + "&strTextBox=" + strTextBox, "_new", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
        }

    </script>
</body>
</html>
