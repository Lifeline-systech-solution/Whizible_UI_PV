<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuickTask.aspx.vb" Inherits="PbNIT.QuickTask" ValidateRequest="false" EnableViewState="true" %>

<!DOCTYPE HTML>
<html>
<%WritePageHead()%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<% CommonFunctions.General.PlotPageHeadTag("Task Details")%>

<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

    #QTasks TD
    {
        white-space: nowrap;
    }

    #QTasks TH
    {
        text-align: center;
    }

    .footerMenuTable
    {
        visibility: visible !important;
    }
    /* Added By Gauri On 29th Aug 2024 For Alignment Issue */
    .clsTable tbody td b{
        font-weight: 700;
    }
    #QTasks tr TD:first-child img {
        min-width: 18px;
        height: 15px;
    }
    /* .clsCheckBox{
        accent-color: #ada8a4;
    } */
    #QTasks tr td:nth-child(9), #QTasks tr td:nth-child(10){
        min-width: 118px;
    }
    /* End of Added By Gauri On 29th Aug 2024 For Alignment Issue */

    
</style>

<script type="text/javascript">
    var StrTaskType = "";
    $(document).ready(function () {

        StrTaskType = '<%=m_DefualtTaskType%>';
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
    <form id="frmQuickTask" method="post" runat="server">
         <div id="div1">
        </div>
        <%WritePage()%>
    </form>
    <link href="../General/loaderStylesheet.css" rel="stylesheet" />
    <script language="javascript" id="MainScript">
        </script>
    <script language="javascript" >
        var objTbl = GetObjectReference('frmQuickTask', 'QTasks');
        //var divPageDiv = GetObjectReference('frmQuickTask', 'PageDiv');
        var divPageDiv = GetObjectReference('frmQuickTask', 'divTblGrid');
        var WholeScript = '';
        var LastRowNumber;
        var LastRowNumber = -1;
        var isInValid = 0;
        var EmployeeData;

        var deleteButtonHitCountMSSection = 0;
        var deleteButtonHitCountInputSection = 0;

        var noOfRows;
        var tabCountChange;
        var deleteArr = new Array();

        var objtxtHidRCMSSection = GetObjectReference('frmQuickTask', 'txtHidRC');

        if (objtxtHidRCMSSection != null)
            noOfRows = parseInt(objtxtHidRCMSSection.value);
        else
            noOfRows = 0;
        //IF Add Button is not clicked
        totalMSRowCount = noOfRows;
        var objtblMSSection = GetObjectReference('frmQuickTask', 'QTasks');
        var totalcount = objtblMSSection.rows.length - 1;
        var objForm = GetFormReference('frmQuickTask');

        var MaxNumber;
        var ValidateFlag = true;
        var bitLeave;
        var strHolidays = "<%=m_strHolidays%>";
        function CreateTasks_OnClick() {
            //debugger;
            var Mode = (arguments.length > 0) ? arguments[0] : "0";

            if (Mode == "0") {
                document.body.readonly=true;
                window.setTimeout('CreateTasks_OnClick("1")', 1);
            }
            if(Mode == "1")
            {
                if(objtblMSSection.rows.length > 2)
                {
                    var blnIsRecordSelected = false;
                    totalcount = totalcount + parseInt(deleteButtonHitCountMSSection);
                    ValidateFlag = true;
                    var returnValue = ValidateTasks();

                    if (returnValue == false) {
                        alert('One or more tasks have validation error, please correct it !');
                        return;               
                    }
                    else if(returnValue== 'disallow'){
                        return;
                    }
                    else{                 
                        setFrameLoader();
                        objForm.action = '../Enhancement/QuickTask.aspx?ProjectID=<%=strProjectID%>&UserStoryID=<%=Request.QueryString("UserStoryID")%>&FromTimesheet=CreateTask&Action=CreateTask&RowCount=<%=TotalRowCount%>'
                        objForm.submit();
                        //  alert("Tasks are created successfully.");
                    }
                }
                else
                    alert('Please add at least one task.');
            }
            // window.open('../Home/QuickValidate.aspx?FromWhere=PM', '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 1000)/2 + ',top=' + (window.screen.height - 800)/2 + ',width=1000,height=800');
        }
        function ValidateTasks()
        {

            var url;
            intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
            intCompanyWeekDays = <%=m_lngWeekDays%>;
            var intHolidays = 0;
            var bitHoliday = false;
            var dtCurrentStartDate, dtCurrentEndDate,dtHoliday, dtCurrentDate,strHolidayList,strMsg,strUrl;
            var ValidateRowCount = totalcount + parseInt(deleteButtonHitCountMSSection);
            var firstCall = false;
           

            for (var j = 1; j <= ValidateRowCount; j++) {

              

                var objImage = document.getElementById('validImage' + j);
                var objImageDel = document.getElementById('imgDelete_' + j);
                var objAnchorImage = document.getElementById('anchorImage_' + j);
                var objCopyImage = document.getElementById('copyImage' + j);


               
                var objTaskName = GetObjectReference('frmQuickTask', 'txtTaskName' + j);
                var objStartDate = GetObjectReference('frmQuickTask', 'txtStartDate' + j);
                var objEndDate = GetObjectReference('frmQuickTask', 'txtEndDate' + j);
                var objWorkHrs = GetObjectReference('frmQuickTask', 'txtWorkHrs' + j);
                var objTaskNotes = GetObjectReference('frmQuickTask', 'txtTaskNotes' + j);
                var objDeliverableID = GetObjectReference('frmQuickTask', 'txtHidDeliverableID' + j);
                var objResource = GetObjectReference('frmQuickTask', 'cboResource' + j);
                var objBillable = GetObjectReference('frmQuickTask', 'chkBillable' + j);
                var objModuleID = GetObjectReference('frmQuickTask', 'cboModuleID' + j);
                var objSubProjectID = GetObjectReference('frmQuickTask', 'cboSubProjectID' + j);
                var objMilestoneID = GetObjectReference('frmQuickTask', 'cboMilestoneID' + j);
                //Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                var objFeatureID = GetObjectReference('frmQuickTask', 'cboFeatureID' + j);
                var objEstimationTypeID = GetObjectReference('frmQuickTask', 'cboEstimationTypeID' + j);
                //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                var objChangeRequestID = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + j);
                var objPriority = GetObjectReference('frmQuickTask', 'cboPriority' + j);
                var objTaskType = GetObjectReference('frmQuickTask', 'cboTaskType' + j);
                var objPhaseID = GetObjectReference('frmQuickTask', 'cboPhaseID' + j);
                var objUserStoryID = GetObjectReference('frmQuickTask', 'cboUserStory' + j);
                //Added by Aditya J. on 18-11-2024
                var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
                //End of Added by Aditya J. on 18-11-2024
                if(objStartDate!=null)
                    dtCurrentStartDate = getDate(objStartDate.value);

                if(objEndDate!=null)
                    dtCurrentEndDate = getDate(objEndDate.value);
                if(objTaskName!=null)
                {
                    if (disallowSpecialCharacters(objTaskName,"Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in &#39;Task Name&#39; ",true,'[@/:*?+\';\"<|{}^#&%[,\\\\]')) 
                    {
                        objTaskName.focus(); 
                        return 'disallow';
                    }
                    if(objTaskName.value.indexOf(']')>=0) 
                    {
                        alert("Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in 'Task Name'");
                        objTaskName.focus(); 
                        return 'disallow';
                    }

                    //Added by Aditya J. on 12-11-2024 for special characters validation on 12-11-2024
                    if (disallowSpecialCharacters(objTaskNotes, "Special characters " + WebConfigSpecialCharacters + " are not allowed in &#39;Task Note&#39; ", true, WebConfigSpecialCharacters)) {
                        objTaskNotes.focus();
                        return 'disallow';
                    }
                    //End of Added by Aditya J. on 12-11-2024 for special characters validation on 12-11-2024
                }

                if(objTaskNotes!=null)
                {
                    //Commented By Usha Pandit On 05.08.2020 for allowing special characters
                    //if (disallowSpecialCharacters(objTaskNotes,"Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in &#39;Task Notes&#39; ",true,'[@/:*?+\';\"<|{}^#&%[,\\\\]')) 
                    //{
                    //    objTaskNotes.focus(); 
                    //    return 'disallow';
                    //}
                    //if(objTaskNotes.value.indexOf(']')>=0) 
                    //{
                    //    alert("Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in 'Task Notes'");
                    //    objTaskNotes.focus(); 
                    //    return 'disallow';
                    //}
                    //End Of Commented By Usha Pandit On 05.08.2020 for allowing special characters
                }
                if (objWorkHrs != null && objWorkHrs.value != "") {
                    // Commented and Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change

                    //if (disallowNegativeNumeric(objWorkHrs,'Please enter only positive numeric value!!!',true)) 
                    //{ 
                    //    return 'disallow'; 
                    //}
                    //debugger;

                    //Added By Ankush T on 18-March-2019 for allowing to enter only hours 

                    var precision = objWorkHrs.value.split(":")[1];
                    var hrs = objWorkHrs.value.split(":")[0];

                    if (precision == "") {
                        alert('Please enter Work (hrs) in H:M format.');
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        // ValidateFlag =  false;
                        return 'disallow';
                    }
                     
                    var blnResult = disallowBlank(objWorkHrs, "'Work (H:M)' should not be left blank.");

                    if (blnResult == true) {
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        //ValidateFlag =  false;
                        return 'disallow';
                    }

                    var objWorkHrsVal = objWorkHrs.value;

                    objWorkHrs.value = objWorkHrs.value.replace(":", ".");
                    var isdigit = isNumeric(objWorkHrs.value);
                    objWorkHrs.value = objWorkHrsVal;

                    if (isdigit == false) {
                        alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                        setFocus(objWorkHrs);
                        return 'disallow';
                    }

                    if (objWorkHrsVal.indexOf(":") == -1) {
                        objWorkHrs.value = objWorkHrsVal + ":00";
                        objVal = objWorkHrs.value;
                    }
                    //End of Added By Ankush T  on 18-March-2019 for allowing to enter only hours 
                    if (objWorkHrs.value.indexOf(':') == -1) {
                        alert("Please enter Work (hrs) in H:M format.");
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        //ValidateFlag =  false;
                        return 'disallow';
                    }

                    if (objWorkHrs.value.indexOf("-") != -1) {
                        alert('Hours should not be less than or equal to zero (0).');
                        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                        return 'disallow';
                    }
                    // debugger;
                    if (precision != undefined) {
                        if (hrs <= 0 && precision <= 0) {
                            objWorkHrs.value = objWorkHrsVal;
                            alert('Hours should not be less than or equal to zero (0).');
                            //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            setFocus(objWorkHrs);
                            //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            return 'disallow';
                        }
                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                      if (precision.length > 2) {
                      alert("Please enter minutes in two decimal and less than 60.");
                      setFocus(objWorkHrs);
                       return 'disallow';
                      }
                    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                    }
                    else {
                        if (hrs <= 0) {
                            objWorkHrs.value = objWorkHrsVal;
                            alert('Hours should not be less than or equal to zero (0).');
                            //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            setFocus(objWorkHrs);
                            //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            return 'disallow';
                        }
                    }

                    if (precision >= 60) {
                        alert('Please enter minutes between (0-59) range.');
                        objWorkHrs.value = objWorkHrs.value.split('.').join(':');
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        // ValidateFlag =  false;
                        return 'disallow';
                    }

                    
                    if (objWorkHrs.value.indexOf(":") != -1) {
                        objWorkHrs.value = objWorkHrs.value.replace(":", ".");
                    }

                    var blnResult = disallowSpecialCharacters(objWorkHrs, "Please enter Work (hrs) in H:M format.");

                    if (blnResult == true) {
                        objWorkHrs.value = objWorkHrs.value.replace(".", ":");
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        // return false;
                        return 'disallow';
                    }

                    blnResult = disallowNonNumeric(objWorkHrs, "Please enter Work (hrs) in H:M format.");

                    if (blnResult == true) {
                        objWorkHrs.value = objWorkHrsVal;
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objWorkHrs);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        //ValidateFlag =  false;
                        return 'disallow';
                    }

                    var MinDAENtryDisplay = "";
                    var MinDAEntry = '<%=CommonFunctions.Application.MinHoursForDAEntry%>';

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

                    if ('<%=m_RestrictByMinHours%>' == 'True') {

                        if (MinDAEntry == 0.016) {

                        }
                        else {
                            var minutes = objWorkHrs.value.split('.');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);

                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                // alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")" );
                                setFocus(objWorkHrs);
                                objWorkHrs.value = objWorkHrs.value.split('.').join(':');
                                //EmployeeData = ValidateData(url, 0, 0, 0);
                                ValidateFlag = false;
                                //return 'disallow';
                            }
                        }
                    }
                    var chkhr = objWorkHrs.value.split(".")[0];
                    var chkmin = objWorkHrs.value.split(".")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        objWorkHrs.value = chkhr + "." + chkmin;
                    }
                    objWorkHrs.value = objWorkHrs.value.replace(".", ":");

                    //End of Commented and Added By Ankush Toraskar on 04-Mar-2019 Purpose::Whizible 2 Work field change
                }
                //else {
                //    ValidateFlag = false;
                //}





                if (objImageDel != null) {

                    //Holiday Validation
                    if(objResource!=null)
                        var strResource = objResource.options[objResource.selectedIndex].text;
                    if(objStartDate!=null && objEndDate!=null)
                    {
                        if(objStartDate.value !='' && objEndDate.value!='')
                        {
                            if (strHolidays != "") {
                                strMsg = "" + strResource + ": The dates \n";
                                strHolidayList = strHolidays.split(',');
                                bitHoliday = false;
                                for (intCount = 0; intCount < strHolidayList.length - 1 ; intCount++) {
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
                            //if (bitHoliday == true)			//Remove Comments after added the function DatePart
                            //{
                            //    if (!confirm(strMsg + "falling between the start date and end date for this task are holidays.\nDo you want to maintain the start and end date.\nOk = Save the selected dates.\nCancel = Go back to the previous screen without saving."))
                            //    {
                            //        ValidateFlag=false;
                            //        setFocus(objStartDate);
                            //        return false;
                            //    }
                            //}

                            var intCounter;
                            var strEmployeeList;
                            strEmployeeList='';
                            if (objResource!=null)
                            {
                                for(intCounter=0;intCounter < objResource.options.length;intCounter++)
                                {
                                    if(objResource.options[intCounter].selected==true)
                                    {
                                        strEmployeeList+= objResource.options[intCounter].value	+ ','
                                    }
				
                                }
                            }
                     
                       
                            strUrl = new String();
                            strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId=0&PROJECT_SETTINGS=<%=m_strProjectSetting%>&FromDate=" + encodeURIComponent(objStartDate.value) + "&ToDate=" + encodeURIComponent(objEndDate.value)+ "&EmployeeIDs=" + strEmployeeList ;

                            if (strResult == "")
                            {                               
                                if( generateRequest(strUrl) == false)
                                {
                                    ValidateFlag =  false;
                                }
                            }
                        }
                    }

                    if (firstCall == false) {
                        url = "Action=Validate&FromWhere=DB&RowNumber=" + j + "&IsFirst=1&MaxNumber=" + MaxNumber + "";
                        firstCall = true;
                    }
                    else {
                        url = "Action=Validate&FromWhere=DB&RowNumber=" + j + "&MaxNumber=" + MaxNumber + "";
                    }

                    if (objTaskName != null)
                        url += "&TaskName=" + objTaskName.value + ""
                    if (objStartDate != null)
                        url += "&StartDate=" + objStartDate.value + ""
                    if (objEndDate != null)
                        url += "&EndDate=" + objEndDate.value + ""
                    if (objWorkHrs != null)
                        url += "&WorkHrs=" + objWorkHrs.value + ""
                    //Commented And Added By Usha Pandit On 05.08.2020 for encoding special characters
                    //if (objTaskNotes != null)
                    //    url += "&TaskNote=" + objTaskNotes.value + ""

                    if (objTaskNotes != null)
                        url += "&TaskNote=" + encodeURIComponent(encodeURI(objTaskNotes.value)) + ""                    
                    //End Of Added By Usha Pandit On 05.08.2020 for encoding special characters
                    if (objDeliverableID != null)
                        url += "&DeliverableID=" + objDeliverableID.value + ""
                    if (objResource != null)
                        url += "&Resource=" + objResource.value + ""
                    if (objBillable != null)
                        url += "&Billable=" + objBillable.value + ""
                    if (objModuleID != null)
                        url += "&ModuleID=" + objModuleID.value + ""
                    if (objSubProjectID != null)
                        url += "&SubProjectID=" + objSubProjectID.value + ""
                    if (objMilestoneID != null)
                        url += "&MilestoneID=" + objMilestoneID.value + ""
                    //Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                    if (objMilestoneID != null)
                        url += "&FeatureID=" + objFeatureID.value + ""
                    if (objMilestoneID != null)
                        url += "&EstimationTypeID=" + objEstimationTypeID.value + ""
                    //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                    if (objChangeRequestID != null)
                        url += "&ChangeRequestID=" + objChangeRequestID.value + ""
                    if (objPriority != null)
                        url += "&Priority=" + objPriority.value + ""
                    if (objTaskType != null)
                        url += "&TaskType=" + objTaskType.value + ""
                    if (objPhaseID != null)
                        url += "&PhaseID=" + objPhaseID.value + ""

                    if('<%=m_intFlag%>' == "1")
                    {
                        if(objUserStoryID!=null)
                            url += "&UserStoryID=" + objUserStoryID.value + ""
                    }

                    if (bitHoliday == true)
                        url += "&Holiday=true"
                    else
                        url += "&Holiday=false"

                    if (bitLeave == true)
                        url += "&Leave=true"
                    else
                        url += "&Leave=false"
                    
                    if (objImageDel != null)
                        url += "&ImgDelete=" + objImageDel.value + ""

                    if (objAnchorImage != null) {
                        objAnchorImage.href = "javascript:ValidImage_OnClick(" + MaxNumber + ")";
                        MaxNumber = parseInt(MaxNumber) + 1;
                    }
                    
                    if (objImage != null) {
                        EmployeeData = ValidateData(url, 0, 0, 0);

                        if (EmployeeData == 0) {
                            objImage.src = "../../Images/Home/wrongtick.png";
                            objCopyImage.src = ""
                            objCopyImage.style.display= 'none';
                            objImage.style.display = '';                           
                            ValidateFlag = false;
                        }
                        else if(EmployeeData == 2){
                            objImage.src = "../../Images/Home/alertmark.png"
                            objCopyImage.src = "../../Images/Copy.gif"
                            objCopyImage.style.display= '';                            
                            objImage.style.display = '';
                        }
                        else{
                            objImage.src = "../../Images/Home/righttick.jpg"
                            objCopyImage.src = "../../Images/Copy.gif"
                            objCopyImage.style.display= '';                            
                            objImage.style.display = '';
                        }
                    }
                }

                                
            }
            if (ValidateFlag == false) {
                return false;
            }
            else {
                return true;
                }
          
        }


//Added by Chetan M on 18 May 2020 for Issue ID = 24423
        function disallowNegativeNumeric(obj) {            
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }
            var msg = (arguments.length > 1) ? arguments[1] : "";
            msg = replaceSubstring(msg, "&#39;", "'");
            var dofocus = (arguments.length > 2) ? arguments[2] : true;
            //if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
            if (getInputValue(obj) < 0) {
                if (!isBlank(msg)) { alert(msg); }
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        //End of Added by Chetan M on 18 May 2020 for Issue ID = 24423



       
        function CreateRowForResource()
        {


            if ('<%=m_strBaselineMessage%>'== "") {
                var strUrl = "Action=GetMaxNumber";
                MaxNumber = ValidateData(strUrl, 0, 0, 0);

                if (MaxNumber == '')
                    MaxNumber = 0;
                else
                    MaxNumber = parseInt(MaxNumber) + 1;
                // debugger;
                var returnValue = ValidateTasks();

                if (returnValue == 'disallow') {
                    return;
                }


                var strcombohtml;
                var startMandHTML = " ";
                var NewTR, NewTD;
                var NewTR1, newTD1;


                if (noOfRows == 0) {
                    noOfRows = 1;
                }
                else
                    noOfRows = noOfRows + 1;


                objtblMSSection = GetObjectReference('frmQuickTask', 'QTasks');
                totalcount = objtblMSSection.rows.length - 2;

                if (noOfRows == 0) {
                    noOfRows = 1;
                    totalcount = 1;
                }
                else {
                    noOfRows = noOfRows + 1;
                    totalcount = totalcount + 1;
                }

                if ((objtblMSSection.rows.length - 1) <= 10) {

                    totalcount = totalcount + parseInt(deleteButtonHitCountMSSection);
                    objtxtHidRCMSSection.value = totalcount;
                    tabCountChange = totalcount;
                    NewTR = objtblMSSection.insertRow(objtblMSSection.rows.length - 1);
                    NewTR.className = 'clsTREven';
                    NewTR.id = 'TR' + totalcount;

                    NewTD = NewTR.insertCell(0);
                    NewTD.align = 'center';
                    NewTD.title = 'Delete';
                    NewTD.width = '1%';
                    NewTD.innerHTML = "<td ><Input type=hidden name='txtMSSectionID" + totalcount + "' id='txtMSSectionID" + totalcount + "' value=0  /> <IMG ID='imgDelete" + totalcount + "' BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRowSection(this," + totalcount + ")'>";

                    NewTD.innerHTML += "<Input type=hidden name='imgDelete_" + totalcount + "' id='imgDelete_" + totalcount + "' value='" + totalcount + "'  /></td>"

                    //Select checkbox
                    NewTD = NewTR.insertCell(1);
                    NewTD.align = 'center';
                    // strcombohtml = '<CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , False, , False, , True, False, , , , ).ToString.Replace("'", "\'")%>';
                    //strcombohtml = strcombohtml.replace(/chkSelect/g, "chkSelect" + totalcount);
                    //NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
                    NewTD.innerHTML = NewTD.innerHTML + "<td><a id='anchorCopyimage_" + totalcount + "' href='javascript:CopyImage_OnClick(" + totalcount + ")'><img id='copyImage" + totalcount + "' src='' height='20px' width='20px' style='display:none;'></img></a></td>"


                    // var taskid = totalcount - 1;
                    //TaskID
                    NewTD = NewTR.insertCell(2);
                    NewTD.align = 'center';
                    NewTD.innerHTML = NewTD.innerHTML + "<td ><a id='anchorImage_" + totalcount + "' href='javascript:ValidImage_OnClick(" + MaxNumber + ")'><img id='validImage" + totalcount + "' src='' height='15px' width='15px' style='display:none;'></img></a></td>"


                    //Task Name
                    NewTD = NewTR.insertCell(3);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 150, 255, , , , , , , , , True, True, , , , 1,EnableHTMLEncode:=True ).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtTaskName/g, "txtTaskName" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Task Notes
                    NewTD = NewTR.insertCell(4);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , , , "frmQuickTask", , , 150, 40, 2000, , returnHTML:=True, Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtTaskNotes/g, "txtTaskNotes" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
                    GetObjectReference('frmQuickTask', 'txtTaskNotes' + totalcount).maxLength = 2000;

                    //Resource
                    NewTD = NewTR.insertCell(5);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboResource", "EXEC usp_Sel_CurrentTeamMembers " + m_lngProjectId.ToString(), 150, , , True, True, , True,  , False,1).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/cboResource/g, "cboResource" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Work Hrs
                    NewTD = NewTR.insertCell(6);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs", "txtWorkHrs", , 50, 6, , , , , , , , , True, True, , , ,  1, ).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtWorkHrs/g, "txtWorkHrs" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Billable
                    NewTD = NewTR.insertCell(7);
                    NewTD.align = 'center';
                    //Commented And Added By Usha Pandit On 24.08.2020 For setting billable check access
                    <%--strcombohtml = '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", ,  , "ON", returnHTML:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'--%>
                    strcombohtml = '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", , m_blnBillable, "ON", returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                    //End Of Added By Usha Pandit On 24.08.2020 For setting billable check access
                    strcombohtml = strcombohtml.replace(/chkBillable/g, "chkBillable" + totalcount)
                    NewTD.innerHTML = "<td style='text-align:center;'>" + strcombohtml + "</td>";

                    //Start Date
                    NewTD = NewTR.insertCell(8);
                    NewTD.align = 'left';
                    strcombohtml = '<%= CommonFunctions.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , 80, , , "frmQuickTask","../../images/Calendar.gif", returnHTML:=True, IsMandatory:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtStartDate/g, "txtStartDate" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //End Date
                    NewTD = NewTR.insertCell(9);
                    NewTD.align = 'left';
                    strcombohtml = '<%= CommonFunctions.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , 80, , , "frmQuickTask", "../../images/Calendar.gif", returnHTML:=True, IsMandatory:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtEndDate/g, "txtEndDate" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Task Type
                    NewTD = NewTR.insertCell(10);
                    NewTD.align = 'left';
                    //onChange=TaskTypeID_OnChange(value)
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "EXEC usp_Sel_tbl_PM_Project_TaskTypes_Names " + m_lngProjectId.ToString(), 150,, " onChange=TaskTypeID_OnChange(this)", True, ReturnAsHTML:=True, IsMandatory:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/cboTaskType/g, "cboTaskType" + totalcount)

                    //strcombohtml = strcombohtml.replace(/StrTaskType/g, StrTaskType)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                     //Added By Dipali V On 8th April 2020 For Default Task Type Should get set
                    //alert('<%=m_DefualtTaskType%>');
                   // alert($("#cboTaskType" + totalcount).length);
                  <%--  if ('<%=m_DefualtTaskType%>'!= "") {
                        $('select"#cboTaskType' + totalcount + 'option:selected').val('<%=m_DefualtTaskType%>');
                    }--%>
                    //End of Added By Dipali V On 8th April 2020 For Default Task Type Should get set

                   

                    //Priority
                    NewTD = NewTR.insertCell(11);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "EXEC usp_Sel_tbl_IB_Priorities", 150, , , True, ReturnAsHTML:=True, IsMandatory:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/cboPriority/g, "cboPriority" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Deliverable
                    NewTD = NewTR.insertCell(12);
                    NewTD.align = 'left';
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , 150, , , , , True, True, , , , True, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
                    strcombohtml = strcombohtml.replace(/txtDeliverableID/g, "txtDeliverableID" + totalcount)
                    var strDelivarable = '<%=CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , "SelectDeliverable", 12, 12, , True)%>'
                    strDelivarable = strDelivarable.replace(/SelectDeliverable/g, "SelectDeliverable(" + totalcount + ")")
                    var strHiddenDeliverable = "<Input type=hidden name='txtHidDeliverableID" + totalcount + "' id='txtHidDeliverableID" + totalcount + "' />";
                    NewTD.innerHTML = '<td>' + strcombohtml + strDelivarable + strHiddenDeliverable + '</td>';



                    //Phase
                    NewTD = NewTR.insertCell(13);
                    NewTD.align = 'left';

                <% If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", "Exec usp_PRS_GetProjectPhasesForSQA " + m_lngProjectId.ToString(), 150,  , , True, True, ,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1),TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", "Exec usp_PRS_GetProjectPhasesForSQA " + m_lngProjectId.ToString(), 150, ,"disabled", True, True ,TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>
                    strcombohtml = strcombohtml.replace(/cboPhaseID/g, "cboPhaseID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Module
                    NewTD = NewTR.insertCell(14);
                    NewTD.align = 'left';



                <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", "Exec usp_Sel_tbl_PM_Module " + m_lngProjectId.ToString() + ",null,'A',null", 150, , , True, True, , IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1), TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", "Exec usp_Sel_tbl_PM_Module " + m_lngProjectId.ToString() + ",null,'A',null", 150, , "disabled" , True, True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>

                    strcombohtml = strcombohtml.replace(/cboModuleID/g, "cboModuleID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //SubProject
                    NewTD = NewTR.insertCell(15);
                    NewTD.align = 'left';

                <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) Then%>
                    strcombohtml = '<%= CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", "Exec usp_Sel_tbl_PM_SubProject " + m_lngProjectId.ToString() + ",null,'T',null", 150, , , True, True,,IsMandatory:= m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1),TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%= CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", "Exec usp_Sel_tbl_PM_SubProject " + m_lngProjectId.ToString() + ",null,'T',null", 150, , "disabled", True, True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>

                    strcombohtml = strcombohtml.replace(/cboSubProjectID/g, "cboSubProjectID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Milestone
                    NewTD = NewTR.insertCell(16);
                    NewTD.align = 'left';

                <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", "Exec usp_Sel_tbl_PM_Milestones " + m_lngProjectId.ToString() + ",'T',null", 150, , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1),TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", "Exec usp_Sel_tbl_PM_Milestones " + m_lngProjectId.ToString() + ",'T',null", 150, , "disabled", True, True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>

                    strcombohtml = strcombohtml.replace(/cboMilestoneID/g, "cboMilestoneID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Change Request
                    NewTD = NewTR.insertCell(17);
                    NewTD.align = 'left';

                //Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                <% If m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 0) = True Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboFeatureID", "Exec usp_Sel_tbl_PM_Project_Features NULL, " + m_lngProjectId.ToString(), 150,  , , True, True, , IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_FEATURE, 1), TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboFeatureID", "Exec usp_Sel_tbl_PM_Project_Features NULL, " + m_lngProjectId.ToString(), 150, , "disabled", True, True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>
                    strcombohtml = strcombohtml.replace(/cboFeatureID/g, "cboFeatureID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Module
                    NewTD = NewTR.insertCell(18);
                    NewTD.align = 'left';

                <% If m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 0) = True Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboEstimationTypeID", "Exec usp_Sel_tbl_PM_Project_EstimationTypes NULL, " + m_lngProjectId.ToString(), 150,  , , True, True, , IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_ESTIMATIONTYPE, 1), TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboEstimationTypeID", "Exec usp_Sel_tbl_PM_Project_EstimationTypes NULL, " + m_lngProjectId.ToString(), 150, , "disabled", True, True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>
                    strcombohtml = strcombohtml.replace(/cboEstimationTypeID/g, "cboEstimationTypeID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                    //Module
                    NewTD = NewTR.insertCell(19);
                    NewTD.align = 'left';
                //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields

                <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) Then%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "Exec usp_Sel_tbl_PM_ChangeRequest_Master "+ m_lngProjectId.ToString(), 150, , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1),TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%Else%>
                    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "Exec usp_Sel_tbl_PM_ChangeRequest_Master "+ m_lngProjectId.ToString(), 150, ,  "disabled", True, True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                <%End If%>

                    strcombohtml = strcombohtml.replace(/cboChangeRequestID/g, "cboChangeRequestID" + totalcount)
                    NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
                    if ("<%=m_intFlag%>" == "1") {
                        //User Story

                        //Commented And Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                        //NewTD = NewTR.insertCell(18);
                        NewTD = NewTR.insertCell(20);
                        //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields

                        NewTD.align = 'left';

                        //Commented And Added By Usha Pandit On 25.08.2020 for selecting only those user stories which are not from Completed or Terminated Sprint
                        <%--<%Dim strQuery As String = "SELECT UserStoryID,UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ProjectID =" & m_lngProjectId.ToString() & " AND ReleaseID IS NOT NULL AND (IsUserStoryComplete = 0 or  IsUserStoryComplete is null)"%>--%>
                        <%Dim strQuery As String = "SELECT UserStoryID,UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ProjectID =" & m_lngProjectId.ToString() & " AND IterationID IS NOT NULL AND (IsUserStoryComplete = 0 OR IsUserStoryComplete IS NULL) AND IterationID NOT IN(SELECT IterationID FROM tbl_PM_ScrumIteration WHERE ISNULL(IterationStatus,'') IN('Completed','Sprint Terminated',''))"%>
                        //End Of Added By Usha Pandit On 25.08.2020 for selecting only those user stories which are not from Completed or Terminated Sprint

                        strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", strQuery, 150, , " onChange=UserStoryID_OnChange(this,value)", True, ReturnAsHTML:=True, IsMandatory:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                        strcombohtml = strcombohtml.replace(/cboUserStory/g, "cboUserStory" + totalcount)
                        NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                        //Release
                        //Commented And Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                        //NewTD = NewTR.insertCell(19);
                        NewTD = NewTR.insertCell(21);
                        //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields

                        NewTD.align = 'left';
                        strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtRelease", "txtRelease", "clsTextBoxReadOnly", 150, , , "left", , , True, returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                        strcombohtml = strcombohtml.replace(/txtRelease/g, "txtRelease" + totalcount)
                        NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

                        //Iteration

                        //Commented And Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields
                        //NewTD = NewTR.insertCell(20);
                        NewTD = NewTR.insertCell(21);
                        //End Of Added By Usha Pandit On 04.08.2020 for plotting Feature and Estimation Type fields

                        NewTD.align = 'left';
                        strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtIteration", "txtIteration", "clsTextBoxReadOnly", 150, , , "left", , , True, returnHTML:=True, IsMandatory:=False, EnableHTMLEncode:=True,TabIndex:=1).ToString.Replace("'", "\'")%>'
                        strcombohtml = strcombohtml.replace(/txtIteration/g, "txtIteration" + totalcount)

                        var hdnStory = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtHdnIsStoryComplete", "txtHdnIsStoryComplete", value:="0", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
                        hdnStory = hdnStory.replace(/txtHdnIsStoryComplete/g, "txtHdnIsStoryComplete" + totalcount)
                        NewTD.innerHTML = '<td>' + strcombohtml + hdnStory + '</td>';

                    }

                  
                    var strURl = "Action=DrawCustomField&RowID=" + totalcount + ""
                    var strResult = ValidateData(strURl, 0, 0, 0);



                    var resultArr = strResult.split("####");

                    NewTR.innerHTML += resultArr[0];

                    //Append javascript to body element     

                    // var script = "<script type='text/javascript'> ";
                    var e = document.getElementById('MainScript');



                    WholeScript += resultArr[1];
                    e.innerHTML = '';
                    // document.getElementById('div1').innerHTML = WholeScript;
                    var script = " document.getElementById('tdShowHide').onclick = function(){ " + WholeScript + " }; ";
                    script += "  document.getElementById('CreateTaskID').onclick = function(){ " + WholeScript + " CreateTasks_OnClick(); }; "
                    // script += " function ValidateCustomField(){ "+ WholeScript +" } "

                    var CreateTaskscript = " document.getElementByTagName('Title=Create Tasks').onclick = function(){ " + WholeScript + " } ";

                    //script += "<\/script>"

                    var newsc = script;


                    e.innerHTML = newsc;
                   
                    $.globalEval(e.innerHTML);
                    //eval(e.innerHTML);
                    //addCode(resultArr[1]);
                    //Added By Dipali V On 8th April 2020 For Default Task Type Should get set
                    
                    //debugger
                    //debugger;
                    //Commented And Added By Usha Pandit On 10.09.2020 For checking default condition
                    //TaskTypeID_OnChange('cboTaskType' + totalcount);
                    //Commented by Usha Pandit On 07.08.2020 For issue related to custom field disabled even if task type default value is present 
                    //TaskTypeID_OnChange(document.getElementById('cboTaskType' + totalcount), "Default");
                    //End Of Commented by Usha Pandit On 07.08.2020 For issue related to custom field disabled even if task type default value is present
                    <%--if ('<%=m_DefualtTaskType%>'!= "") {
                        $('#cboTaskType' + totalcount + ' option:selected').val('<%=m_DefualtTaskType%>');
                    }--%>
                    
                    var curdefaultTaskType = '<%=m_DefualtTaskType%>';

                    $("#cboTaskType" + totalcount + " " + " > option").each(function () {
                        if (this.value == curdefaultTaskType) {
                            $("#cboTaskType" + totalcount).val(curdefaultTaskType);
                        }
                    });
                    //End Of Added By Usha Pandit On 10.09.2020 For checking default condition
                    //Added by Usha Pandit On 07.08.2020 For issue related to custom field disabled even if task type default value is present 
                    TaskTypeID_OnChange(document.getElementById('cboTaskType' + totalcount), "Default");
                    //End Of Added by Usha Pandit On 07.08.2020 For issue related to custom field disabled even if task type default value is present 
                    //End of Added By Dipali V On 8th April 2020 For Default Task Type Should get set
                }
                else {
                    alert('Maximum Tasks limit is 10 records.');

                }
                //Added By Dipali V On 8th April 2020 For Alter Issues if Project WF not enabled
            } else {
                alert('<%=m_strBaselineMessage%>');
                //End of Added By Dipali V On 8th April 2020 For Alter Issues if Project WF not enabled
            }
 
        }

        function addCode(code){
            //var JS= document.createElement('script');
            //JS.type = "text/javascript";
            //JS.text= "" + code + "" ;
            var script = "<script type='text/javascript'> ";
           
             script += " var objCustomFieldText91=GetObjectReference('frmQuickTask','CustomFieldText91'); if(objCustomFieldText91.value == ''){ alert('should not blank');  } ";
            
                script += "<\/script>"
            //var strScripts  = document.scripts['6'].innerHTML + script;
           // document.scripts['6'].appendChild(script);

                var newsc = '<script id="sc1" type="text/javascript">function go() { alert("GO!") }<\/script>';
                var e = document.getElementById('div1');
                e.innerHTML = newsc;
                eval(document.getElementById('sc1').innerHTML);

            //document.body.innerText = document.body.innerText + script;
            //headID.textContent = headID.textContent + script;
            
            //$('body').append(script);
            //$('body').append(JS);
            //document.head.appendChild(script);
           

            //document.body.appendChild(JS);
        }
        function deleteRowSection(evt, deleteRow) {
            objtblMSSection.deleteRow(evt.parentNode.parentNode.rowIndex);
            deleteButtonHitCountMSSection = parseInt(deleteButtonHitCountMSSection) + 1;
            noOfRows = noOfRows - 1;
            totalcount = totalcount - 1;
            deleteArr.push(deleteRow);
          
        }
        var g_sResponseText = '';
        var g_oValidateXMLHttp;
        function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
            //start .Added mode option in parameter list to the function         
            var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
            //End
            var strResult;
            var strNavigator;
            g_sResponseText = '';
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();


            strURL = "../Enhancement/QuickTask.aspx?MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;


            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send();
            }
            else {
                // Mozilla - based browser 
                g_oValidateXMLHttp = new XMLHttpRequest();
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send(null);
            }
           
            if (g_oValidateXMLHttp.responseText != null) {
                strResult = g_oValidateXMLHttp.responseText;
            }
            return strResult;
        }
        function GetResponseText() {
            if (g_oValidateXMLHttp.readyState == 4) {
                if (g_oValidateXMLHttp.responseText != null) {
                    g_sResponseText = g_oValidateXMLHttp.responseText;
                }
            }
        }
        function ValidImage_OnClick(MaxNumber)
        {
          
            //window.open('../PM/QuickTask_Validate_CommonList.aspx?MasterTagID=20176&FromWhere=PM', '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 1000) / 2 + ',top=' + (window.screen.height - 800) / 2 + ',width=1000,height=800')
            window.open("../Enhancement/QuickTask_Validate_CommonList.aspx?MasterTagID=22180&FromWhere=PM&TMSTaskID=" + MaxNumber + "", "", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990) / 2) + ",top=" + ((window.screen.height - 640) / 2) + ",width=990,height=640");
        }

        function SelectDeliverable(RowCount) {
            var objDeliverableID;
            objDeliverableID = document.getElementsByName('txtDeliverableID');
            if ("<%=FromTimesheet%>" != "CreateTask")
                window.open("../General/CommonList.aspx?MasterTagID=2176&FromWhere=QuickCreate"+ RowCount +"&DeliverableID=0&RowCount="+ RowCount +"","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
            else
                window.open("../General/CommonList.aspx?FromTimesheet=CreateTask&ProjectID=<%=m_lngProjectId%>&MasterTagID=2176&FromWhere=QuickCreate"+ RowCount +"&DeliverableID=0", "","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
        }
        function CopyImage_OnClick(RowNumber)
        {
           
            CreateRowForResource();
           
           

                var CopyRowNumber = totalcount ;

                //Copy Row Details
            
                var objTaskName1 = GetObjectReference('frmQuickTask', 'txtTaskName' + RowNumber);
                var objStartDate1 = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtStartDate' + RowNumber);
                var objEndDate1 = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtEndDate' + RowNumber);
                var objWorkHrs1 = GetObjectReference('frmQuickTask', 'txtWorkHrs' + RowNumber);
                var objTaskNotes1 = GetObjectReference('frmQuickTask', 'txtTaskNotes' + RowNumber);
                var objDeliverableID1 = GetObjectReference('frmQuickTask', 'txtDeliverableID' + RowNumber);
                var objHdnDeliverableID1 = GetObjectReference('frmQuickTask', 'txtHidDeliverableID' + RowNumber);
                var objResource1 = GetObjectReference('frmQuickTask', 'cboResource' + RowNumber);
                var objBillable1 = GetObjectReference('frmQuickTask', 'chkBillable' + RowNumber);
                var objModuleID1 = GetObjectReference('frmQuickTask', 'cboModuleID' + RowNumber);
                var objSubProjectID1 = GetObjectReference('frmQuickTask', 'cboSubProjectID' + RowNumber);
                var objMilestoneID1 = GetObjectReference('frmQuickTask', 'cboMilestoneID' + RowNumber);
                var objChangeRequestID1 = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + RowNumber);
                var objPriority1 = GetObjectReference('frmQuickTask', 'cboPriority' + RowNumber);
                var objTaskType1 = GetObjectReference('frmQuickTask', 'cboTaskType' + RowNumber);
                var objPhaseID1 = GetObjectReference('frmQuickTask', 'cboPhaseID' + RowNumber);
                var objUserStory1 = GetObjectReference('frmQuickTask', 'cboUserStory' + RowNumber);
                var objRelease1 = GetObjectReference('frmQuickTask', 'txtRelease' + RowNumber);
                var objIteration1 = GetObjectReference('frmQuickTask', 'txtIteration' + RowNumber);

                //New Row in that data will be copy
                var objTaskName = GetObjectReference('frmQuickTask', 'txtTaskName' + CopyRowNumber);
                var objStartDate = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtStartDate' + CopyRowNumber);
                var objEndDate = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtEndDate' + CopyRowNumber);
                var objWorkHrs = GetObjectReference('frmQuickTask', 'txtWorkHrs' + CopyRowNumber);
                var objTaskNotes = GetObjectReference('frmQuickTask', 'txtTaskNotes' + CopyRowNumber);
                var objDeliverableID = GetObjectReference('frmQuickTask', 'txtDeliverableID' + CopyRowNumber);
                var objHdnDeliverableID = GetObjectReference('frmQuickTask', 'txtHidDeliverableID' + CopyRowNumber);
                var objResource = GetObjectReference('frmQuickTask', 'cboResource' + CopyRowNumber);
                var objBillable = GetObjectReference('frmQuickTask', 'chkBillable' + CopyRowNumber);
                var objModuleID = GetObjectReference('frmQuickTask', 'cboModuleID' + CopyRowNumber);
                var objSubProjectID = GetObjectReference('frmQuickTask', 'cboSubProjectID' + CopyRowNumber);
                var objMilestoneID = GetObjectReference('frmQuickTask', 'cboMilestoneID' + CopyRowNumber);
                var objChangeRequestID = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + CopyRowNumber);
                var objPriority = GetObjectReference('frmQuickTask', 'cboPriority' + CopyRowNumber);
                var objTaskType = GetObjectReference('frmQuickTask', 'cboTaskType' + CopyRowNumber);
                var objPhaseID = GetObjectReference('frmQuickTask', 'cboPhaseID' + CopyRowNumber);
                var objUserStory = GetObjectReference('frmQuickTask', 'cboUserStory' + CopyRowNumber);
                var objRelease = GetObjectReference('frmQuickTask', 'txtRelease' + CopyRowNumber);
                var objIteration = GetObjectReference('frmQuickTask', 'txtIteration' + CopyRowNumber);

                if(objTaskName!=null)
                    objTaskName.value =  objTaskName1.value;
                if(objTaskNotes!=null)
                objTaskNotes.value = objTaskNotes1.value;
            //objResource.value = objResource1.value;
                if(objWorkHrs!=null)
                    objWorkHrs.value = objWorkHrs1.value;
                if(objBillable!=null)
                    objBillable.checked = objBillable1.checked;
                if(objStartDate!=null)
                    objStartDate.value = objStartDate1.value;
                if( GetObjectReference('frmQuickTask', 'txtStartDate' + CopyRowNumber)!=null)
                    GetObjectReference('frmQuickTask', 'txtStartDate' + CopyRowNumber).value = GetObjectReference('frmQuickTask', 'txtStartDate' + RowNumber).value;
                if(objEndDate!=null)
                    objEndDate.value = objEndDate1.value;
                if(GetObjectReference('frmQuickTask', 'txtEndDate' + CopyRowNumber)!=null)
                    GetObjectReference('frmQuickTask', 'txtEndDate' + CopyRowNumber).value = GetObjectReference('frmQuickTask', 'txtEndDate' + RowNumber).value;
                if(objPriority!=null)
                    objPriority.value = objPriority1.value;
                if(objDeliverableID!=null)
                    objDeliverableID.value = objDeliverableID1.value;
                if(objHdnDeliverableID!=null)
                    objHdnDeliverableID.value = objHdnDeliverableID1.value;
                
                if(objTaskType!=null)
                {
                    objTaskType.value =  objTaskType1.value;
                    objTaskType.onchange();
                }

                if(objPhaseID!=null)
                    objPhaseID.value =  objPhaseID1.value;
                if(objModuleID!=null)
                    objModuleID.value = objModuleID1.value;
                if(objSubProjectID!=null)
                    objSubProjectID.value = objSubProjectID1.value;
                if(objMilestoneID!=null)
                    objMilestoneID.value = objMilestoneID1.value;
                if(objChangeRequestID!=null)
                    objChangeRequestID.value = objChangeRequestID1.value;
               
                if("<%=m_intFlag%>" == "1")
                {
                    if(objUserStory!=null)
                        objUserStory.value = objUserStory1.value;
                    if(objRelease!=null)
                    {                     
                        objRelease.value = objRelease1.value;                      
                    }
                    if(objIteration!=null)
                    {                        
                        objIteration.value = objIteration1.value;  
                       
                    }
                }
            var strCustomFieldList = GetObjectReference('frmQuickTask','CustomFieldList'+ CopyRowNumber);

            if(strCustomFieldList!=null)
                var ArrCustomFieldList = (strCustomFieldList.value).split(",");

            for(var i=0; i<ArrCustomFieldList.length;i++)
            {
                var objPrevCustomField = GetObjectReference('frmQuickTask',ArrCustomFieldList[i]+RowNumber);
                var objNextCustomField = GetObjectReference('frmQuickTask',ArrCustomFieldList[i]+CopyRowNumber);

                if(objPrevCustomField!=null && objNextCustomField!=null)
                {
                    if(objNextCustomField.disabled==false)
                        objNextCustomField.value = objPrevCustomField.value;
                }
            }
           
        }

        function window_onload() {
            var intDivHeight;
            var intDivHeightRisk;
            if (divPageDiv != null) {
               
                if (intDivHeight < 100) intDivHeight = 100;
             

                if (navigator.appName == 'Netscape') {
                    intDivHeight = window.innerHeight - divPageDiv.offsetTop - 5;
                }
                else {
                    intDivHeight = window.innerHeight - divPageDiv.offsetTop - 5;
                }
              
                divPageDiv.style.height = intDivHeight + 'px';
            }
            var ObjTd=window.frames.parent.document.getElementById('tdTree')
            var ObjImg=window.frames.parent.document.getElementById('ImgShowHide')
            var ObjLeftnavigation=window.frames.parent.document.getElementById('tblLeftNavigation')
              
            if(ObjTd!=null && ObjImg!=null)
            {
                
                ObjTd.style.display='none';
                ObjImg.src='../../Images/Home/RightMove.gif';
                ObjLeftnavigation.style.display='';
            }
        }

        var strResult='';
        var req; //PrashantD
        var g_objXHttp;
        function generateRequest(url) 
        { 								
				
            // TO SEE IF WE ARE RUNNING IN IE             
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            var browser = isIE();
            if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            { 
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send();
            }
                //added By Bharat T on 13th-Oct-2015
            else if(browser=='IE')
            {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send();
            }
                //End of Added By Bharat T on 13th-Oct-2015
            else
            {
							
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send(null);
								
                if ( g_objXHttp.responseText != null)
                {
                    xmlDoc= document.implementation.createDocument("","",null);
                    xmlDoc.async=false;
                    //xmlDoc.load(req.responseXML);
                    //if (browser == 'FF') // Added By Vaijat K on 20/11/2015
                    //xmlDoc.load(g_objXHttp.responseXML);
                    strResult=g_objXHttp.responseText;
                    if(save_onClick_2() == false)
                    {
                        ValidateFlag = false;                        
                        return false;
                    }
                }
								
            }
				
            //delete req; PrashantD
				
            
        } 
        //var objCbo = GetObjectReference(g_strFrm,g_strDependentCtrl);
		
			
        function state_change() 
        {
            var browser = isIE(); 
				
            if (g_objXHttp.readyState == 4) 
            {
					
                // Make sure request came back OK 
                //if (req.status == 200) 
                if (g_objXHttp.status == 200) 
                {
				 
                    if (window.ActiveXObject || "ActiveXObject" in window)
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async=false;
                        //xmlDoc.loadXML(req.responseText);
                        xmlDoc.loadXML(g_objXHttp.responseText);
												
                    }
                        // code for Mozilla, etc.
                    else if (document.implementation &&	document.implementation.createDocument)
                    {
                        xmlDoc= document.implementation.createDocument("","",null);
                        xmlDoc.async=false;
                    }
										

                    strResult=g_objXHttp.responseText;

                    if ( isIE() == 'IE') // Added By Vidya J ON 01/12/2015
                    {
                        if(save_onClick_2() == false)
                        {
                            return false;
                        }
                    }
                }					
            }				
        }
        function save_onClick_2()
        {
	    
            var objBaselineStartDate; //it was declared previously in Save_OnClick function. 
            bitLeave = false;
            if(strResult!=null)
            {
                if(strResult!='')
                {
					
                    strResult=strResult.split("<=>");
                    var intCount, Count;
                    
                    for(intCount=0;intCount<strResult.length;intCount++)
                    {
                        strLH=strResult[intCount];	
                        strLH=strLH.split("<==>");
                        for(Count=0;Count<strLH.length;Count++)
                        {	
                            if(!strLH[Count])
                            {
                                if(strLH[Count]!='')
                                {
                                    if(strLH[Count]!=' ')
                                    {			
                                        strResult="";                                    
                                        bitLeave = true;
                                        return false;
                                        //if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
                                        //}
                                    }
                                }	
                            }
                        }	
                    }
					
					
                }
            }
        }
        
        function TaskTypeID_OnChange(obj, defaultFlag) { //Flag Added By Usha Pandit On 10.09.2020 For checking default condition
            // debugger;
            var RowNumber = obj.id.split('cboTaskType')[1];
            
            var strUrl = "Action=GetAccessToCustomField&TaskTypeID=" + obj.value + "";
            var CustomFieldAccess = ValidateData(strUrl, 0, 0, 0);

            var TempField = CustomFieldAccess.split(",");

            for (var i = 0; i < TempField.length; i++) {
                var IsCustomFieldAssigned = TempField[i].split('#')[1];
                var CustomFieldName = TempField[i].split('#')[0];
                var HasAccess = TempField[i].split('#')[2];

                if (HasAccess == 1) {
                    if (IsCustomFieldAssigned == 0) {
                        if (GetObjectReference('frmQuickTask', CustomFieldName + RowNumber) != null) {
                            GetObjectReference('frmQuickTask', CustomFieldName + RowNumber).value = '';
                            GetObjectReference('frmQuickTask', CustomFieldName + RowNumber).disabled = true;
                        }
                    }
                    else {
                        if (GetObjectReference('frmQuickTask', CustomFieldName + RowNumber) != null)
                            GetObjectReference('frmQuickTask', CustomFieldName + RowNumber).disabled = false;
                    }
                }
                else {
                    if (GetObjectReference('frmQuickTask', CustomFieldName + RowNumber) != null) {
                        GetObjectReference('frmQuickTask', CustomFieldName + RowNumber).value = '';
                        GetObjectReference('frmQuickTask', CustomFieldName + RowNumber).disabled = true;
                    }
                }

            }
            if ('<%=m_DefualtTaskType%>' != "") {
                //Commented And Added By Usha Pandit On 10.09.2020 For checking default condition
                //$("#cboTaskType" + RowNumber + " option:selected").val('<%=m_DefualtTaskType%>');
                var curdefaultTaskType = '<%=m_DefualtTaskType%>';

                $("#cboTaskType" + RowNumber + " " + " > option").each(function () {
                    if (this.value == curdefaultTaskType && defaultFlag == "Default") { 
                        $("#cboTaskType" + RowNumber).val(curdefaultTaskType);
                    }
                });
                //End Of Added By Usha Pandit On 10.09.2020 For checking default condition                
            }
        }
        function UserStoryID_OnChange(obj,value)
        { //debugger;
	        
            var RowNumber = obj.id.split("cboUserStory")[1];
            var objRelease = GetObjectReference('frmQuickTask','txtRelease'+ RowNumber);
            var objIteration = GetObjectReference('frmQuickTask','txtIteration'+RowNumber);
            var objtxtHdnIsStoryComplete = GetObjectReference('frmQuickTask','txtHdnIsStoryComplete'+RowNumber);
            if(value != '')
            {
                try
                { var strUrl="../PM/AjaxCallIteration.aspx?Flag=AssignedTask&UserStoryID=" + value;
                    //Modified by swapnil aswale on 22-12-2015 
                    var brw = isIE();
	        
	        
                    if (brw == "IE"){
                        objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                        objXHttp.onreadystatechange = function()
                        {
                            if(objXHttp.readyState==4)
                            {
                                if(objXHttp.responseText != null)
                                {
                                    if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                        alert(objXHttp.responseText);
                                    else
                                        var data;
                                    data =objXHttp.responseText;
                                    var strUSDetails = data.split(',');
                                    objRelease.value = strUSDetails[0];
                                    objIteration.value = strUSDetails[1];
                                    objtxtHdnIsStoryComplete.value = strUSDetails[2];
                                } } }
                        objXHttp.open("GET",strUrl, false);
                        objXHttp.send();
                    }
                    else
                    {
	               
                        // Mozilla - based browser , Netscape
                        objXHttp = new XMLHttpRequest();
                        //hook the event handler
                        //g_objXHttp.onreadystatechange = TaskValidation_state_change;
                        //prepare the call, http method=GET, false=asynchronous call
                        objXHttp.open("GET",strUrl, false);
                        //finally send the call
                        objXHttp.send(null);
							
                        if ( objXHttp.responseText != null)
                        {
                            xmlDoc= document.implementation.createDocument("","",null);
                            xmlDoc.async=false;
                            //added by Nilesh g on 10/12/2015 for issue id 2721
                            if (brw == "FF")
                                xmlDoc.load(objXHttp.responseXML);
                            var data;
                            data =objXHttp.responseText;
                            var strUSDetails = data.split(',');
                            objRelease.value = strUSDetails[0];
                            objIteration.value = strUSDetails[1];
                            objtxtHdnIsStoryComplete.value = strUSDetails[2];
                            //strResult=g_objXHttp.responseText;
                        }
                    }
                } catch(e){}
               
                //objForm.action="PM_TaskAssignment.aspx?Mode=New&MasterTagID=1038&PageNumber=-1undefined&UserStoryID="+value;
                //objForm.submit();
                return;
            }
            else
            {
                objRelease.value = '';
                objIteration.value = '';
            }
        }
    </script>
