<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjecPlanDeliverable.aspx.vb" Inherits="PbNIT.PM_ProjecPlanDeliverable" %>

<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <head>
    <title></title>
    
    <% MyBase.InitializeResources("AppResources.PM_PlanDeliverable", "AppResources")%>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>
<script src="../../General/CommonFunctions.js"></script> -->


    <script src="../../responsive/responsive.js"></script>
  
    <!-- <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
   <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script> -->
    
    <!-- <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=2">
     <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
     <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" /> -->
    <link rel="stylesheet" href="../../Whizible2.0/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.9">

    <!-- <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script> -->

    <style>
        .clsTable .clsTRMenu td:first-child {
            /*width: 35%;*/
            vertical-align: middle;
        }
        .alertify-notifier {
            z-index: 99999 !important;
            font-size:12px !important;
        }

        #DivMain {

            height:450px!important;
            overflow:hidden!important;
        }

        #DivList {

            height:275px!important;
             overflow:auto!important;
        }

        .responsive_clsTRMenu li:nth-child(3) {

            display:none

        }

          .footer_responsive_clsTRMenu li:nth-child(3) {

            display:none

        }
        .clsTextbox {
    display: block;
    width: auto;
    height: 34px;
    padding: 4px 8px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
        .clsTable td { padding:4px;
        }
        TR.clsTRSectionHeader {BACKGROUND-COLOR: #e7edf0;
        }
.clsTRSectionHeader td {
    padding-top: 10px; font-weight:bold;
    text-align: center;
}
#TasksTable tr > td {
    border: 1px solid #ddd;
    vertical-align: top;
}
SELECT.clsComboBox{ background-image:none;height: 30px;}
table.clsTable:last-child td, table.clsTable:last-child td em {
    font-size: 12px!important;
}
#TasksTable tr > td select {
    margin: 0 0 10px!important;
}
tr.clsTRPageCaption {
    background: #4263c1;
    font-size: 14px;
    padding: 0px 0; color:#fff;
}
tr.clsTRPageCaption td {
    padding: 10px 4px;
}
#DivMain{ padding:15px;}
.notebox{ background:#e7edf0;}

/*13-11-2019 - added by pradip*/
TR.clsTRMenu{BACKGROUND: #e7edf0; height:34px;}
TR.clsTRMenu li{ margin:0 0 0 5px;border: none;}
TR.clsTRMenu a.Menu {
    font-weight: 700;
    padding: 4px 14px;
    border: 1px solid #1359ac!important;
    color: #1359ac;
    border-radius: 4px;
    text-shadow: none;
    margin: 0 0px; transition:0.4s ease-in-out 0s;
}
    TR.clsTRMenu li:first-child a.Menu {background: #fbb03b; border: 1px solid #fbb03b!important;
    color: #fff;
    }
        TR.clsTRMenu li:first-child a.Menu:hover {background: #e29214!important; border: 1px solid #e29214!important;
    color: #fff;
        }
.clsTable td a {
    color: #1359ac!important;
}

/*css added by pradip for datepicker*/
.ui-state-default, .ui-widget-content .ui-state-default {border: none!important;}
.ui-state-default, .ui-widget-content .ui-state-default {border: none!important;}
.ui-state-default a{ font-size:12px!important;}
.ui-datepicker .ui-datepicker-header{ font-size:12px;}

    </style>
   
    


    <script type="text/javascript">

       


         var ProjectID
        $(document).ready(function () {

             $(".clsTextBox").addClass("form-control");

            ProjectID = '<%=m_ProjectID%>'
            //Added By Dipali V On 27th Aug 2026 For Brower issues 
            $('#DivList .clsComboBox font').contents().unwrap();
            //End of Added By Dipali V On 27th Aug 2026 For Brower issues 
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

          //  Template_OnChange();
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
</head>
<body class="clsBody" onresize="window_onresize()" onload="window_onload()" ms_positioning="GridLayout" id="ProjectPlanDeliverable">
    <form id="frmTaskSelection" name="frmTaskSelection" method="post" runat="server">
        <%PageInit()%>
    </form>

    <script language="javascript">
        //var objDivMain = GetObjectReference('frmTaskSelection', 'DivMain');
        //var objDivList = GetObjectReference('frmTaskSelection', 'DivList');
        //var objForm;
        //objForm = GetFormReference('frmTaskSelection');
        //Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
        var intResourceValidation = <%=m_bitResourceValidation%>;
        //End Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
        //Added by MahendraV On 10:53 AM 6/27/2007 To get server Today date
        var todayDate = "<%=m_strTodayDate%>";

        var strmessage;

  <%--      <%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>--%>

        function window_onload() {
            //var intDivHeight;
            //// intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
            //intDivHeight = window.innerHeight - objDivMain.offsetTop - 28;
            //if (intDivHeight < 100)
            //    intDivHeight = 100;
            //objDivMain.style.height = intDivHeight + 'px';
            //if (typeof (objDivList) == "object") {
            //    if (objDivList != null)
            //        objDivList.style.height = intDivHeight - 145 + 'px';
            //}
        }

        function window_onresize() {
            //var intDivHeight;
            //// intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 25;
            //intDivHeight = window.innerHeight - objDivMain.offsetTop - 28;
            //if (intDivHeight < 100)
            //    intDivHeight = 100;
            //objDivMain.style.height = intDivHeight + 'px';
            //if (typeof (objDivList) == "object") {
            //    if (objDivList != null)
            //        objDivList.style.height = intDivHeight - 145 + 'px';
            //}
        }

        function fixDateClient(instrDate, format) {
            var d, m, y, strm;
            var monthname = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
            var retDate;
            var strReplaceString = /-/g;             //Create regular expression pattern for replacing "-" with "/"
            var dtDate = new StringToDate(instrDate, format);		//Replace "-" with "/" and convert to Date.

            if (isNaN(dtDate.getDate()) == true || isNaN(dtDate.getMonth()) == true || isNaN(dtDate.getYear()) == true)
                return ("");

            d = dtDate.getDate().toString();
            m = (dtDate.getMonth() + 1).toString();
            y = dtDate.getFullYear().toString();
            strm = monthname[dtDate.getMonth()];

            if (d.length < 2)
                d = "0" + d;
            if (m.length < 2)
                m = "0" + m;

            switch (format) {
                case "yyyy/mm/dd":
                    retDate = y + "/" + m + "/" + d;
                    break;
                case "yy/mm/dd":
                    retDate = y.substr(2, 2) + "/" + m + "/" + d;
                    break;
                case "dd/mm/yy":
                    retDate = d + "/" + m + "/" + y.substr(2, 2);
                    break;
                case "dd/mm/yyyy":
                    retDate = d + "/" + m + "/" + y;
                    break;
                case "yyyy-mm-dd":
                    retDate = y + "-" + m + "-" + d;
                    break;
                case "yy-mm-dd":
                    retDate = y.substr(2, 2) + "-" + m + "-" + d;
                    break;
                case "dd-mm-yy":
                    retDate = d + "-" + m + "-" + y.substr(2, 2);
                    break;
                case "dd-mm-yyyy":
                    retDate = d + "-" + m + "-" + y;
                    break;
                case "mm-dd-yyyy":
                    retDate = m + "-" + d + "-" + y;
                    break;
                case "ddmmyyyy":
                    retDate = d + m + y;
                    break;
                case "ddmmyy":
                    retDate = d + m + y.substr(2, 2);
                    break;
                case "mmddyy":
                    retDate = m + d + y.substr(2, 2);
                    break;
                case "mmddyyyy":
                    retDate = m + d + y;
                    break;
                case "yyyymmdd":
                    retDate = y + m + d;
                    break;
                case "yymmdd":
                    retDate = y.substr(2, 2) + m + d;
                    break;
                case "yyyy":
                    retDate = y;
                    break;
                case "dd-Month-yyyy":
                    retDate = d + "-" + strm + "-" + y;
                    break;
                case "dd-Month-yy":
                    retDate = d + "-" + strm + "-" + y.substr(2, 2);
                    break;
                default:
                    retDate = d + "/" + m + "/" + y;
            }
            return (retDate);
        }

        function CheckDates(intRowID, strTaskStartDate, strTaskEndDate, strActivityTitle, strAlertMsg) {
            //To check if the Start and End Dates are specified

            var dtmObjStartDate, dtmObjEndDate;
            var dtmTaskStartDate, dtmTaskEndDate, strProjectEndDate, dtmProjectEndDate;
            var retCheckDates;
            var strAlertMsg;
            var strRepStr = /-/g;             //Create regular expression pattern for replacing "-" with "/"
            strAlertMsg = new String();

            retCheckDates = false;

            if (intRowID == "")
                return (retCheckDates);

            objStartDate = document.getElementsByName("txtStartDate" + intRowID)[0].value;
            objEndDate = document.getElementsByName("txtEndDate" + intRowID)[0].value;

            //Validation : Not blank (Start Date).
            if (objStartDate == "") {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_BLANK_FROM_DATE"))%>";
                //alert(strmessage);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strmessage, 'error', 25);
             
                //alert("Please select the 'Start Date' !!");
                if (objStartDate != null)
                    document.getElementsByName("txtStartDate" + intRowID)[0].focus();
                return (retCheckDates);
            }

            //Validation : Not blank (End Date).
            if (objEndDate == "") {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_BLANK_TO_DATE"))%>";
               // alert(strmessage);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strmessage, 'error', 25);
             
                //alert("Please select the 'End Date' !!");
                document.getElementsByName("txtEndDate" + intRowID)[0].focus();
                return (retCheckDates);
            }

            if (CheckDateFieldValidity((objStartDate),"<%=m_strDateFormat%>") == false) {
                if (objStartDate != null)
                    document.getElementsByName("txtStartDate" + intRowID)[0].focus();
                return (retCheckDates);
            }

            if (CheckDateFieldValidity((objEndDate),"<%=m_strDateFormat%>") == false) {
                document.getElementsByName("txtEndDate" + intRowID)[0].focus();
                return (retCheckDates);
            }

            dtmObjStartDate = StringToDate(objStartDate, "<%=m_strDateFormat%>");
            dtmObjEndDate = StringToDate(objEndDate, "<%=m_strDateFormat%>");

            dtmTaskStartDate = StringToDate(strTaskStartDate, "<%=m_strDateFormat%>");
            dtmTaskEndDate = StringToDate(strTaskEndDate, "<%=m_strDateFormat%>");

            //Validation : Start Date <= End Date.				
            if (dtmObjStartDate > dtmObjEndDate) {
            strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_START_DATE_GREATER_THAN_END_DATE"))%>",
                    //alert(strmessage);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strmessage, 'error', 25);
             
                //alert("The 'Start Date' cannot be greater than the 'End Date' !!");
                if (objStartDate != null)
                    document.getElementsByName("txtStartDate" + intRowID)[0].focus();
                return (retCheckDates);
            }

            //Validation : Start Date >= Deliverable Start Date And End Date <= Deliverable End Date
            if (strTaskStartDate != "") {
                if (dtmObjStartDate < dtmTaskStartDate) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_START_DATE_LESS_THAN_DELIVERABLE_START_DATE"))%>";
                    strmessage = replaceSubstring(strmessage, "<ACTIVITY>", "" + strActivityTitle);
                    strmessage = replaceSubstring(strmessage, "<DELIVERABLE_START_DATE>", fixDateClient(strTaskStartDate,"<%=m_strDateFormat%>"));
                    strAlertMsg = strmessage
            //strAlertMsg = "The 'Start Date' of '" + strActivityTitle + "' is lesser than the 'Deliverable Start Date' [" + fixDateClient(strTaskStartDate,"<%=m_strDateFormat%>") + "] !!";
                }

                /*	'Added By       :   NitinVS on 23 Mar 2005 
                    'IssueID        :   16984 
                    'Description    :   Project Start Date validation is not applicable to task for plan deliverable
                    '                   Variable to hold Project Start Date 
                    'version        :   PBNITE SP2 */

                var ProjectStartDate, dtmProjectStartDate;
                ProjectStartDate = "<%=FixDateForDisplay(m_strProjectStartDate, m_intDateFormat)%>";

                if (ProjectStartDate != "") {
                    dtmProjectStartDate = StringToDate(ProjectStartDate, "<%=m_strDateFormat%>");

            if (strTaskEndDate != "") {
                if (dtmObjStartDate < dtmProjectStartDate) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_START_DATE_LESS_THAN_PROJECT_START_DATE"))%>";
                    strmessage = replaceSubstring(strmessage, "<ACTIVITY>", "" + strActivityTitle);
                    strmessage = replaceSubstring(strmessage, "<PROJECT_START_DATE>", fixDateClient(ProjectStartDate,"<%=m_strDateFormat%>"));
                    strAlertMsg = strmessage
                //strAlertMsg = "The 'End Date' of '" + strActivityTitle + "' is greater than the 'Project End Date' [" + fixDateClient(strProjectEndDate,"<%=m_strDateFormat%>") + "]!";
                   // alert(strAlertMsg);
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify(strAlertMsg, 'error', 25);
             
                            return false;
                        }
                    }
                }
                /* End Addition By NitinVS on 23 March 2005 IssueID 16984 */
            }

            if (strTaskEndDate != "") {
                if (dtmObjStartDate > dtmTaskEndDate) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_START_DATE_GREATER_THAN_DELIVERABLE_START_DATE"))%>";
            strmessage = replaceSubstring(strmessage, "<ACTIVITY>", "" + strActivityTitle);
            strmessage = replaceSubstring(strmessage, "<DELIVERABLE_END_DATE>", fixDateClient(strTaskEndDate,"<%=m_strDateFormat%>"));
            strAlertMsg = strmessage
            //strAlertMsg = "The 'Start Date' of '" + strActivityTitle + "' is greater than the 'Deliverable End Date' [" + fixDateClient(strTaskEndDate,"<%=m_strDateFormat%>") + "] !!";
                }

            }

            //Added by ShamkantD on 16 Dec 2004
            //Validation: End Date  <= Project End Date
            strProjectEndDate = "<%=FixDateForDisplay(m_strProjectEndDate, m_intDateFormat)%>";

            if (strProjectEndDate != "") {
                dtmProjectEndDate = StringToDate(strProjectEndDate, "<%=m_strDateFormat%>");

                if (strTaskEndDate != "") {
                    if (dtmObjEndDate > dtmProjectEndDate) {
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_END_DATE_GREATER_THAN_PROJECT_END_DATE"))%>";
                        strmessage = replaceSubstring(strmessage, "<ACTIVITY>", "" + strActivityTitle);
                        strmessage = replaceSubstring(strmessage, "<PROJECT_END_DATE>", fixDateClient(strProjectEndDate,"<%=m_strDateFormat%>"));
                        strAlertMsg = strmessage
	            //strAlertMsg = "The 'End Date' of '" + strActivityTitle + "' is greater than the 'Project End Date' [" + fixDateClient(strProjectEndDate,"<%=m_strDateFormat%>") + "]!";
                       // alert(strAlertMsg);
                      alertify.set('notifier', 'position', 'top-right');
                      alertify.notify(strAlertMsg, 'error', 25);
                        return false;
                    }
                }
            }
            //End of addition - ShamkantD on 16 Dec 2004		

            //Validation : End Date <= Deliverable End Date
            if (strTaskEndDate != "") {
                if (dtmObjEndDate > dtmTaskEndDate) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_END_DATE_GREATER_THAN_DELIVERABEL_END_DATE"))%>";
            strmessage = replaceSubstring(strmessage, "<ACTIVITY>", "" + strActivityTitle);
            strmessage = replaceSubstring(strmessage, "<DELIVERABLE_END_DATE>", fixDateClient(strTaskEndDate,"<%=m_strDateFormat%>"));
            strAlertMsg = strmessage
            //strAlertMsg = "The 'End Date' of '" + strActivityTitle + "' is greater than the 'Deliverable End Date' [" + fixDateClient(strTaskEndDate,"<%=m_strDateFormat%>") + "]!";
                    //strAlertMsg = strAlertMsg + "\r\nThis will update the End Date of deliverable.\r\nDo you want to continue?"
                    if (window.confirm(strAlertMsg) == true)
                        return true;
                    else
                        return false;

                    strAlertMsg = "";
                }
            }

            if (strAlertMsg.length > 0) {
                //alert(strAlertMsg);
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strAlertMsg, 'error', 25);
                return (retCheckDates);
            }

            retCheckDates = true;
            return (retCheckDates);
        }
        //Added by Harshk for sp4 issueid 120,121 
        function GetResourceDate(intEmpID, strWhichDate) {
            var objSDateCbo = GetObjectReference('frmTaskSelection', 'cboResourceStartDates');
            var objEDateCbo = GetObjectReference('frmTaskSelection', 'cboResourceEndDates');
            var intIndex;
            for (intIndex = 0; intIndex < objSDateCbo.length; intIndex++) {
                if (objSDateCbo[intIndex].value == intEmpID) {
                    if (strWhichDate == 'START') {
                        return objSDateCbo[intIndex].text;
                    }
                    else {
                        return objEDateCbo[intIndex].text;
                    }
                }
            }

        }
        // Added By MahendraV On 5:39 PM 8/16/2007 For WhizibleSEM 7.0
        // To create FTR only for single day
        // Start_MV_8/16/2007

        function CheckFTRDateForSingleDay(ID) {
            var dtTaskSDt, dtTaskEDt, objFTR, objStartDt, objEndDt;

            objStartDt = document.getElementsByName("txtStartDate" + ID)[0];
            objEndDt = document.getElementsByName("txtEndDate" + ID)[0];
            dtTaskSDt = StringToDate(objStartDt.value, "<%=m_strDateFormat%>");
    dtTaskEDt = StringToDate(objEndDt.value, "<%=m_strDateFormat%>");
            objFTR = GetObjectReference('frmTaskSelection', 'IsFTR' + ID);
            if (objFTR != null) {
                if (objFTR.checked == true) {
                    if (DateDiff(dtTaskSDt, dtTaskEDt, "d") != 0) {

                        //alert("Please create 'Fast Track Review' only for single Day ( " + objStartDt.value + " ) ")
                         alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please create 'Fast Track Review' only for single Day ( " + objStartDt.value + " ) ", 'error', 25);
                        objEndDt.focus();
                        return false;
                    }
                }
            }

        }
        // End_MV_8/16/2007
        // Added By MahendraV On 11:06 AM 6/27/2007 To check review dates for future plan deliverable
        // For IssueID(14046) Planned Deliverable : while creating review it doesn't allow start date backdated this condition should be handled while creating review task thr planned deliverable
        function checkReviewDateForFuturePlan(strTaskSDt, strTaskEDt) {

            var dtTaskSDt, dtTaskEDt;
            dtTodayDt = StringToDate(todayDate, "<%=m_strDateFormat%>");
    dtTaskSDt = StringToDate(strTaskSDt, "<%=m_strDateFormat%>");
    dtTaskEDt = StringToDate(strTaskEDt, "<%=m_strDateFormat%>");
            if (dtTaskSDt < dtTodayDt) {
               // alert("Please Enter 'Start Date' for review greater than or equal to today's date " + todayDate)
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please Enter 'Start Date' for review greater than or equal to today's date " + todayDate, 'error', 25);
                return false;

            }
            if (dtTaskEDt < dtTodayDt) {
               // alert("Please Enter 'End Date' for review greater than or equal to today's date " + todayDate)
                  alertify.set('notifier', 'position', 'top-right');
                 alertify.notify("Please Enter 'End Date' for review greater than or equal to today's date " + todayDate, 'error', 25);
                return false;
            }
            return true;

        }
        // Added By MahendraV On 12:57 PM 6/27/2007 
        // For IssueID(14038) Plan Deliverable : Project > WBS > Deliverables > Planned Deliverables : Even though resource not selected still task gets created
        function CheckRevieweeForWithoutOfflineReview(blnOffline, intRevieweeIndex) {
            if (blnOffline == false && intRevieweeIndex == -1) {
                //alert("Please select 'Reviewee' or create 'Offline Review'")
                  alertify.set('notifier', 'position', 'top-right');
                 alertify.notify("Please select 'Reviewee' or create 'Offline Review'", 'error', 25);
                return false;
            }
            return true;
        }
        // End of addition by MahendraV
        function CheckRevieweeDates(strTaskSDt, strTaskEDt, objResourceCbo) {
            var strResourceSDt, strResourceEDt;
            var dtTaskSDt, dtTaskEDt, dtResourceSDt, dtResourceEDt;
            var intIndx;

            dtTaskSDt = StringToDate(strTaskSDt, "<%=m_strDateFormat%>");
    dtTaskEDt = StringToDate(strTaskEDt, "<%=m_strDateFormat%>");
    if (objResourceCbo != null) {
        strResourceSDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value, 'START');
        strResourceEDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value, 'END');
        dtResourceSDt = getDate(strResourceSDt);
        dtResourceEDt = getDate(strResourceEDt);
        if (DateDiff(dtTaskSDt, dtResourceSDt, "d") > 0) {
            strMsg = '<%=MyBase.GetResourceString("MSG_REVIEWEE_START_DATE_VALIDATION")%>';
            strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
            strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
            strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
            //strMsg = 'task start date should be between Reviewee(' + objResourceCbo[objResourceCbo.selectedIndex].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
           alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strMsg, 'error', 25);
            return false;
        }
        if (DateDiff(dtResourceEDt, dtTaskEDt, "d") > 0) {
            strMsg = '<%=MyBase.GetResourceString("MSG_REVIEWEE_START_DATE_VALIDATION")%>';
                    strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
                    strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                    strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                    //strMsg = 'task start date should be between Reviewee(' + objResourceCbo[objResourceCbo.selectedIndex].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
                     alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strMsg, 'error', 25);
                    return false;
                }
            }
            return true;
        }
        function CheckReviewerDates(strTaskSDt, strTaskEDt, objResourceCbo) {
            var strResourceSDt, strResourceEDt;
            var dtTaskSDt, dtTaskEDt, dtResourceSDt, dtResourceEDt;
            var intIndx;

            dtTaskSDt = StringToDate(strTaskSDt, "<%=m_strDateFormat%>");
    dtTaskEDt = StringToDate(strTaskEDt, "<%=m_strDateFormat%>");
    if (objResourceCbo != null) {
        strResourceSDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value, 'START');
        strResourceEDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value, 'END');
        dtResourceSDt = getDate(strResourceSDt);
        dtResourceEDt = getDate(strResourceEDt);
        // Modified By MahendraV On 2:46 PM 7/27/2007 For WhizibleSEM 7.0
        // Purpose : Skip resource date validation for non project resources.
        // Start_MV_7/27/2007
        if (dtResourceSDt != null && dtResourceEDt != null) {
            if (DateDiff(dtTaskSDt, dtResourceSDt, "d") > 0) {
                strMsg = '<%=MyBase.GetResourceString("MSG_REVIEWER_START_DATE_VALIDATION")%>';
                strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
                strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                //strMsg = 'task start date should be between Reviewer(' + objResourceCbo[objResourceCbo.selectedIndex].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strMsg, 'error', 25);
                return false;
            }
            if (DateDiff(dtResourceEDt, dtTaskEDt, "d") > 0) {
                strMsg = '<%=MyBase.GetResourceString("MSG_REVIEWER_END_DATE_VALIDATION")%>';
                        strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
                        strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                        strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                        //strMsg = 'task start date should be between Reviewer(' + objResourceCbo[objResourceCbo.selectedIndex].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
                       alertify.set('notifier', 'position', 'top-right');
                      alertify.notify(strMsg, 'error', 25);
                        return false;
                    }
                    // End_MV_7/27/2007
                }
            }
            return true;
        }
        function CheckResourceDates(strTaskSDt, strTaskEDt, objResourceCbo) {
            var strResourceSDt, strResourceEDt;
            var dtTaskSDt, dtTaskEDt, dtResourceSDt, dtResourceEDt;
            var intIndx;

            dtTaskSDt = StringToDate(strTaskSDt, "<%=m_strDateFormat%>");
    dtTaskEDt = StringToDate(strTaskEDt, "<%=m_strDateFormat%>");
    if (objResourceCbo != null) {


        for (intIndx = 0; intIndx < objResourceCbo.length; intIndx++) {
            if (objResourceCbo.multiple) {
                if (objResourceCbo[intIndx].selected) {
                    strResourceSDt = GetResourceDate(objResourceCbo[intIndx].value, 'START');
                    strResourceEDt = GetResourceDate(objResourceCbo[intIndx].value, 'END');

                    dtResourceSDt = getDate(strResourceSDt);
                    dtResourceEDt = getDate(strResourceEDt);

                    if (DateDiff(dtTaskSDt, dtResourceSDt, "d") > 0) {
                        strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_VALIDATION")%>';
                        strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[intIndx].text);
                        strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                        strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                        //strMsg = 'task start date should be between resource(' + objResourceCbo[intIndx].text + ') start date(' + strResourceEDt + ') and end date(' + strResourceSDt + ') ';
                         alertify.set('notifier', 'position', 'top-right');
                         alertify.notify(strMsg, 'error', 25);
                        return false;
                    }
                    if (DateDiff(dtResourceEDt, dtTaskEDt, "d") > 0) {
                        strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_VALIDATION")%>';
                        strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[intIndx].text);
                        strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                        strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                        //strMsg = 'task start date should be between resource(' + objResourceCbo[intIndx].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
                       // alert(strMsg)
                          alertify.set('notifier', 'position', 'top-right');
                          alertify.notify(strMsg, 'error', 25);
                        return false;
                    }
                }

                // Modified By MahendraV On 12:26 PM 7/23/2007 For WhizibleSEM 7.0
                // Purpose : To validate resource date for 'Reviewer' and 'Reviewee' combo.IssueID(14441)
                // Start_MV_7/23/2007
            }
            /*else
            {

                    if(objResourceCbo[intIndx].selectedIndex!=-1 )
                    {
                            strResourceSDt = GetResourceDate(objResourceCbo[intIndx].value,'START');
                            strResourceEDt = GetResourceDate(objResourceCbo[intIndx].value,'END');

                            dtResourceSDt = getDate(strResourceSDt);
                            dtResourceEDt = getDate(strResourceEDt);

                            if(DateDiff(dtTaskSDt, dtResourceSDt, "d")>0)
                            {
                                strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_VALIDATION")%>';
            //			strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[intIndx].text);
            //		strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
            //	strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
            ///		//strMsg = 'task start date should be between resource(' + objResourceCbo[intIndx].text + ') start date(' + strResourceEDt + ') and end date(' + strResourceSDt + ') ';
            //	alert(strMsg);
            //	return false;
            ///	}
            ///	if(DateDiff(dtResourceEDt, dtTaskEDt, "d")>0)
            //	{
            //		strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_VALIDATION")%>';
                    //strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[intIndx].text);
                    //strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
                    //strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
                    ////strMsg = 'task start date should be between resource(' + objResourceCbo[intIndx].text + ') start date(' + strResourceSDt + ') and end date(' + strResourceEDt + ') ';
                    //			alert(strMsg)
                    //			return false;
                    //		}

                    //}

                    //}*/
                    // End_MV_7/23/2007

                }
            } return true;
        }

        //End Added by Harshk for sp4 issueid 120,121 

        // Reviewed and Modified by MahendraV on 6:56 PM 8/13/2007 For WhizibleSEM 7.0
        // To sink the code for all project type (Case1,Case2 and Case3) 
        // Start the revision by MahendraV On 8/13/2007
        function CreateAssignedTasks_OnClick() {

            var intCnt, intCount, intRecordCount, intResources, intResponse, intActivityID;
            var intTemplateID, intProjectPhaseTaskActivityID, intDateFormat, intIsSubTaskApplicable;
            var dblEffort, dblDeliverableLCE, dtmStartDt, dtmEndDt, dblProjectWorkHrs;
            var dtmObjStartDate, dtmObjEndDate, dtmTaskStartDate, dtmTaskEndDate, dateDiff;
            var strAlertMsg, strDescription, strActivityTitle, strResponse;
            var ResourceIDList, AtleastOneResource;
            /*'==============================================================             
            ' Added By		: NitinVS on 17 Feb 2005 
            ' PBNITE SP2
            ' Description	: To Implement Task Level Planning
            '==============================================================*/

            intIsSubTaskApplicable = "<%=m_IsSubTaskApplicable%>";
    ResourceIDList = ""

    // End Addition By NitinVS on 17 Feb 2005

    if (intIsSubTaskApplicable == 1) {

        // End Of Addition By NitinVS on 16 Feb 2005 
        /*'==============================================================
		'Added By       :   HiteshS on 31st Jan.2005
		'IssueID        :   15430
		'Description    :   Variable to hold Assigned Task Hours for a Project
		'==============================================================*/
        var dblProjectAssignedTaskHrs;
        dblProjectAssignedTaskHrs = 0;
        dblProjectAssignedTaskHrs = parseFloat("<%=m_dblProjectAssignedTaskHrs%>");
	    /*'==============================================================
		'End Of Addition By HiteshS on 31st Jan.2005
		'==============================================================*/
        AtleastOneResource = 0;
        strAlertMsg = "";
        dblDeliverableLCE = 0;
        dblEffort = 0;
        intCount = 0;
        intDateFormat = "<%=m_intDateFormat%>"
        dtmStartDt = "<%=FixDateForDisplay(m_dtStartDate, m_intDateFormat)%>";
        dtmEndDt = "<%=FixDateForDisplay(m_dtEndDate, m_intDateFormat)%>";
        intTemplateID = frmTaskSelection.cboTemplate.value;
        dblDeliverableLCE = parseFloat("<%=m_dblDeliverableLCE%>");
        dblProjectWorkHrs = parseFloat("<%=m_dblProjectWorkHrs%>");

        if (frmTaskSelection.txtRecordCount.value.length == 0)
            intRecordCount = 0;
        else
            intRecordCount = frmTaskSelection.txtRecordCount.value;

        if (intRecordCount == 0) {
            strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_NO_EXECUTION_TEMPLATE"))%>";
            //alert(strmessage);
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strmessage, 'error', 25);
            frmTaskSelection.cboTemplate.focus();
            return;
        }

        //Validate efforts
        if (ValidateEfforts(intRecordCount) == false)
            return;

        //Calculate the Total Effort
        if (intRecordCount > 1) {
            //Total Effort Calculation
            for (intCount = 0; intCount <= frmTaskSelection.txtPhaseTaskID.length - 1; intCount++) {

                intActivityID = frmTaskSelection.txtActivityID(intCount).value;
                intProjectPhaseTaskActivityID = frmTaskSelection.txtProjectPhaseTaskActivityID(intCount).value;
                strActivityTitle = frmTaskSelection.txtPhaseTaskTitle(intCount).value + " -> " + frmTaskSelection.txtActivityTitle(intCount).value;
                dtmStartDt = document.getElementsByName("txtStartDate" + intProjectPhaseTaskActivityID)[0].value;
                dtmEndDt = document.getElementsByName("txtEndDate" + intProjectPhaseTaskActivityID)[0].value;
                intResources = 0;
                //Added by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
                ResourceIDList = '';
                //End Of Addition by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
                // PBNITE SP2
                // Modified By	: NitinVS on 19 Feb 2005 
                // Purpose		: To Validate Activity Start And End Date
                if (CheckDates(intProjectPhaseTaskActivityID, dtmStartDt, dtmEndDt, strActivityTitle, strAlertMsg) == false)
                    return;

                //Added by Harshk sp4 issueID 120,121 txtEffort

                var objWorkHour = GetObjectReference('frmTaskSelection', 'txtEffort' + intProjectPhaseTaskActivityID)
                // Modified By MahendraV On 11:54 AM 7/23/2007 For WhizibleSEM 7.0 
                // Purpose		: To Validate Task Start And End Date for review.IssueID(14441)
                // Start_MV_7/23/2007
                var objReviewWorkHour = GetObjectReference('frmTaskSelection', 'txtReviewerEffort' + intProjectPhaseTaskActivityID)
                if (intResourceValidation == 1) {
                    if (objWorkHour != null) {
                        if (parseFloat(objWorkHour.value == "" ? "0" : objWorkHour.value) > 0) {
                            if (CheckResourceDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboResource' + intProjectPhaseTaskActivityID)) == false)
                                return;
                        }//End of If
                    }//End of If
                    if (objReviewWorkHour != null) {
                        if (parseFloat(objReviewWorkHour.value == "" ? "0" : objReviewWorkHour.value) > 0) {

                            if (CheckReviewerDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewer' + intProjectPhaseTaskActivityID)) == false)
                                return;
                            // Modified By MahendraV On 1:07 PM 7/27/2007 For WhizibleSEM 7.0 
                            // Purpose		: To Validate Task Start And End Date for review.IssueID(14445)
                            // Start_MV_7/27/2007
                            var objOffRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID);
                            if (objOffRewiew != null) {
                                if (objOffRewiew.checked == false) {
                                    if (CheckRevieweeDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewee' + intProjectPhaseTaskActivityID)) == false)
                                        return;
                                }//End of If for Check Reviewee Date valition
                            } //End of If
                            // End_MV_7/27/2007
                        }//End of If
                    }//End of If
                }// End of if condition for intResourceValidation
                //END Added by Harshk issueID 120,121  cboReviewee
                if (frmTaskSelection.txtReviewActivity(intCount).value == "False") {
                    // PBNITE SP2
                    // Modified By	: NitinVS on 17 Feb 2005 
                    // Issue No		: 15415
                    // Purpose		: To Validate length of EmployyeId list 
                    for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].length - 1; intCnt++) {
                        if (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].selected == true) {
                            intResources = intResources + 1;
                            ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].value;
                            AtleastOneResource = 1;
                        }

                    }//End of for loop
                    if (ResourceIDList.length > 200) {
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                        //alert(strmessage);
                           alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
                        frmTaskSelection.elements["cboResource" + intProjectPhaseTaskActivityID].focus();
                        return;
                    }//End of 200 validation condition
                    // End Modification By NitinVS on 17 Feb 2005 
                    /*Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                    //Start Date - End Date validation			
                    // Added Condition for Atleast one resource is selected.				
                    if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0 && intResources > 0) {
                        if (parseFloat(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                            if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'False') {
                                dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value)) * intResources;
                            }
                            else {
                                dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value));
                            }
                            /*End Modification BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                        }//End of Efforts value If condition
                    }//End of Efforts length valition If 
                }// End of Normal task If condition(e.i. False)
                else {
                    AtleastOneResource = 1;
                    // Added by MahendraV On 5:41 PM 7/5/2007 For Whiziblesem 7 
                    // To check if review is offline then plan should create only for reviewer otherwise create for both reviewer and reviewee
                    // Start_MV_7/5/2007
                    var objOfflineRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID);
                    if (objOfflineRewiew != null) {
                        if (objOfflineRewiew.checked == true) { intResources = intResources + 1; }
                        else
                            intResources = intResources + 2;
                    }
                    else
                        intResources = intResources + 2;
                    // End_MV_7/5/2007						
                    if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0) {
                        if (parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                            /*Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                            // Modified by MahendraV On 5:56 PM 7/5/2007 For Whiziblesem 7
                            // To check if reviewer and reviewee same then it should distribute effort only for single task other wise for two task
                            // Start_MV_7/5/2007	
                            if ((document.getElementsByName("cboReviewer" + intProjectPhaseTaskActivityID)[0].value) != (document.getElementsByName("cboReviewee" + intProjectPhaseTaskActivityID)[0].value))
                                dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtReviewerEffort" + intProjectPhaseTaskActivityID].value) * intResources);
                            else
                                // End_MV_7/5/2007	
                                dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtReviewerEffort" + intProjectPhaseTaskActivityID].value));
                            /*End Modification BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */

                        }//End of inner If
                    } //End of Efforts Validation
                }//End of else part for review (i.e. True)
            }//End of for loop
        }//End of intRecordCount if condition
        else {
            intActivityID = frmTaskSelection.txtActivityID.value;
            strActivityTitle = frmTaskSelection.txtActivityTitle.value;
            intProjectPhaseTaskActivityID = frmTaskSelection.txtProjectPhaseTaskActivityID.value;
            intResources = 0;
            //Added by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
            ResourceIDList = '';
            //End of Addition by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
            // PBNITE SP2
            // Modified By	: NitinVS on 19 Feb 2005 
            // Purpose		: To Validate Activity Start And End Date	
            dtmStartDt = document.getElementsByName("txtStartDate" + intProjectPhaseTaskActivityID)[0].value;
            dtmEndDt = document.getElementsByName("txtEndDate" + intProjectPhaseTaskActivityID)[0].value;
            // End Addition By NitinVS on 19 Feb 2005

            if (CheckDates(intProjectPhaseTaskActivityID, dtmStartDt, dtmEndDt, strActivityTitle, strAlertMsg) == false)
                return;
            // Added by Harshk sp4 issueID 120,121 
            var objWorkHour = GetObjectReference('frmTaskSelection', 'txtEffort' + intProjectPhaseTaskActivityID)
            // Modified By MahendraV On 11:54 AM 7/23/2007 For WhizibleSEM 7.0 
            // Purpose		: To Validate Task Start And End Date for review.IssueID(14441)
            // Start_MV_7/23/2007
            var objReviewWorkHour = GetObjectReference('frmTaskSelection', 'txtReviewerEffort' + intProjectPhaseTaskActivityID)
            if (intResourceValidation == 1) {
                if (objWorkHour != null) {
                    if (parseFloat(objWorkHour.value == "" ? "0" : objWorkHour.value) > 0) {
                        if (CheckResourceDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboResource' + intProjectPhaseTaskActivityID)) == false)
                            return;
                    }//End of If for Resource Date validation

                }//End of If
                if (objReviewWorkHour != null) {
                    if (parseFloat(objReviewWorkHour.value == "" ? "0" : objReviewWorkHour.value) > 0) {
                        if (CheckReviewerDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewer' + intProjectPhaseTaskActivityID)) == false)
                            return;
                        // Modified By MahendraV On 1:07 PM 7/27/2007 For WhizibleSEM 7.0 
                        // Purpose		: To Validate Task Start And End Date for review.IssueID(14445)
                        // Start_MV_7/27/2007
                        var objOffRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID);
                        if (objOffRewiew != null) {
                            if (objOffRewiew.checked == false) {
                                if (CheckRevieweeDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewee' + intProjectPhaseTaskActivityID)) == false)
                                    return;
                            }//End of IF for Reviewee Date valition
                        }
                        // End_MV_7/27/2007
                    }//End of If for ReviewWorkHour
                }//End of If 
                // End_MV_7/23/2007
            }//End of If for intResourceValidation
            //END Added by Harshk sp4 issueID 120,121  cboReviewee
            if (frmTaskSelection.txtReviewActivity.value == "False") {
                // PBNITE SP2
                // Modified By	: NitinVS on 17 Feb 2005 
                // Issue No		: 15415
                // Purpose		: To Validate length of EmployyeId list 
                for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].length - 1; intCnt++) {
                    if (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].selected == true) {
                        intResources = intResources + 1;
                        ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].value
                        AtleastOneResource = 1;
                    }

                }//End of For Loop for Resource Count

                if (ResourceIDList.length > 200) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                    //alert(strmessage);
                      alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strmessage, 'error', 25);
                    document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].focus();
                    return;
                }//End of If for 200 validation
                // End Modification By NitinVS on 17 Feb 2005 

                if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0 && intResources > 0) {
                    if (parseFloat(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                        /*Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                        if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'False') {
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value)) * intResources;
                        }
                        else {
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value));
                        }
                        /*'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                    }//End of If
                }//End of If for Efforts Validation
            }//End of If for normal task validation(e.i. False)
            else {
                //Added By NitinVs on 26 Mar 2007 for WhizibleSEM SP 8 regression Issue 12017
                AtleastOneResource = 1;
                //end addition  By NitinVs on 26 Mar 2007 for WhizibleSEM SP 8 regression Issue 12017

                // Added by MahendraV On 5:41 PM 7/5/2007 For Whiziblesem 7 
                // To check if review is offline then plan should create only for reviewer otherwise create for both reviewer and reviewee
                // Start_MV_7/5/2007
                var objOfflineRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID);
                if (objOfflineRewiew != null) {
                    if (objOfflineRewiew.checked == true) { intResources = intResources + 1; }
                    else
                        intResources = intResources + 2;
                }
                else
                    intResources = intResources + 2;
                // End_MV_7/5/2007

                if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0) {
                    if (parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                        /*Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                        // Modified by MahendraV On 5:56 PM 7/5/2007 For Whiziblesem 7
                        // To check if reviewer and reviewee same then it should distribute effort only for single task other wise for two task
                        // Start_MV_7/5/2007							
                        if ((document.getElementsByName("cboReviewer" + intProjectPhaseTaskActivityID)[0].value) != (document.getElementsByName("cboReviewee" + intProjectPhaseTaskActivityID)[0].value))
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtReviewerEffort" + intProjectPhaseTaskActivityID].value) * intResources);
                        else
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtReviewerEffort" + intProjectPhaseTaskActivityID].value));
                        // End_MV_7/5/2007
                        /*'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                    }//End of If
                }//End Of Efforts Validation
            }//End of Review validation(i.e. True)
        }//End of else for intCountRecords
        //Added by PadmnabhA IssueID 15414
        if (AtleastOneResource == 0) {
              //added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
           // strmessage = "<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_NO_RESOURCE"))%>";
            strmessage = "Select at least one resource for selected activity";
              //Endof added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
         //   alert(strmessage);
               alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strmessage, 'error', 25);
            return;
        }//End of If for AtleastOneResource =0

        // Added by ShamkantD on 13 Dec 2004
        if (dblEffort > dblProjectWorkHrs)
        {
            //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
            strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_PROJECT_EFFORT"))%>";
            strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
            strmessage = replaceSubstring(strmessage, "<PROJECT_EFFORT>", "" + parseFloat(dblProjectWorkHrs).toFixed(2));
           // alert(strmessage);
               alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strmessage, 'error', 25);
            return;
        }//End of If for Project effrots validation
        // End of addition - ShamkantD on 13 Dec 2004

	    /*'==============================================================
		'Added By       :   HiteshS on 31st Jan.2005
		'IssueID        :   15430
		'Description    :   Variable to hold Assigned Task Hours for a Project
		'==============================================================*/
        if (dblEffort > (dblProjectWorkHrs - dblProjectAssignedTaskHrs)) {

            //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
            strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_PROJECT_BALANCE_EFFORT"))%>";
            strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
            strmessage = replaceSubstring(strmessage, "<PROJECT_BALANCE_HRS>", "" + (dblProjectWorkHrs - dblProjectAssignedTaskHrs));
            //alert(strmessage);
               alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strmessage, 'error', 25);
            return;
        }//End of If for Assigned Task Hours for a Project
	    /*'==============================================================
		'End Of Addition By HiteshS on 31st Jan.2005
		'==============================================================*/
        if (AtleastOneResource == 0) {
            //added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
           // strmessage = "<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_NO_RESOURCE"))%>";
            strmessage = "Select at least one resource for selected activity";
              //Endof added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
           // alert(strmessage);
                    alertify.set('notifier', 'position', 'top-right');
                 alertify.notify(strmessage, 'error', 25);
                    objEfforts.focus();
                    return;
            //alert("Select atleast one resource for selected execution Template");
            return;
        }
        //Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
        else {
            var TaskMandatoryArr = new Array();
            //var TaskMandatoryArr1=new Array();

            TaskMandatoryArr ="<%=TaskMandatoryArr%>".split(",");
            ReviewTaskArr = "<%=ReviewTaskArr%>".split(",");

            var j;
            //@@@@@@@@@@@@@@@@@@@@
            //Code Added by AmitJ On 22 June 2010 For WhizibleSEM9 SP1 HotFix 9.0.026 
            //Effort & Resource validations are not working for CAse2,3 projects
            for (j = 0; j < TaskMandatoryArr.length - 1; j = j + 1) {
                //  var objEfforts = GetObjectReference('frmTaskSelection','txtEffort'+ TaskMandatoryArr[j]);COMMENTED BY nILESH G
                var objEfforts = document.getElementById('frmTaskSelection', 'txtEffort' + TaskMandatoryArr[j]);

                if (objEfforts.value == 0) {
                    //alert("Efforts cannot be zero for mandatory task");
                       alertify.set('notifier', 'position', 'top-right');
                 alertify.notify("Efforts cannot be zero for mandatory task", 'error', 25);
                    objEfforts.focus();
                    return;
                }
            }

            for (j = 0; j < ReviewTaskArr.length - 1; j = j + 1) {
                var objResource = GetObjectReference('frmTaskSelection', 'cboResource' + ReviewTaskArr[j]);

                //   alert(cboResource.value);
                if (objResource.value == "") {
                    //alert("Please select resource for mandatory task");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Please select resource for mandatory task", 'error', 25);
                    frmTaskSelection.elements["cboResource" + ReviewTaskArr[j]].focus();
                    return;
                }
            }
            //End Of Addition by amitj

            ///@@@@@@@@@@@@@@@@@@@@@
            //				for(j=1;j<TaskMandatoryArr.length;j=j+2)
            //				{
            //					var objEfforts = GetObjectReference('frmTaskSelection','txtEffort'+ TaskMandatoryArr[j-1]);
            //				
            //						var objResource =GetObjectReference('frmTaskSelection','cboResource' + ReviewTaskArr[j-1]);
            //					if (TaskMandatoryArr[j]=="True" )//&& objcboResource == null) 
            //					{
            //								
            //						if (ReviewTaskArr[j]== "False") 
            //						{
            //							if (objResource.value == "")
            //							{
            //									alert("Please select resource for mandatory task");
            //									frmTaskSelection.elements("cboResource" + ReviewTaskArr[j-1]).focus();
            //									return;
            //							}    	
            //						}	
            //						
            //					}		
            //				}

        }
        //End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
        //debugger;
        if (parseFloat(dblEffort) == 0)
        {

            <%--strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_NO_EFFORT"))%>";--%>
            <%--strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_NO_EFFORT"))%>";--%>
           // strmessage = "Please select at least one resource(s) for the activity";
            //alert(strmessage);
             //  alertify.set('notifier', 'position', 'top-right');
                 //   alertify.notify(strmessage, 'error', 25);
            //alert("Please assign Work(Hrs) to atleast one activity for selected resource(s).");
          //  return;
        }
        //End of If for dblEffort=0
        //Addition Ends
        //Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
        else {

            var TaskMandatoryArr = new Array();

            TaskMandatoryArr ="<%=TaskMandatoryArr%>".split(",");
            //alert(TaskMandatoryArr[0]);
            var j;
            //				for(j=1;j<TaskMandatoryArr.length;j=j+2)
            //				{
            //					var objEfforts = GetObjectReference('frmTaskSelection','txtEffort'+ TaskMandatoryArr[j-1]);
            //					alert(TaskMandatoryArr[j]+ ',' + objEfforts.value);
            //					
            //					if (TaskMandatoryArr[j]=="True" && objEfforts.value==0)
            //						{
            //							alert("Efforts cannot be zero for mandatory task");
            //							objEfforts.focus();
            //							return;
            //						}
            //				}
            for (j = 0; j < TaskMandatoryArr.length - 1; j = j + 1) {
                // var objEfforts = GetObjectReference('frmTaskSelection','txtEffort'+ TaskMandatoryArr[j]);
                var objEfforts = document.getElementById('frmTaskSelection', 'txtEffort' + TaskMandatoryArr[j]);

                if (objEfforts.value == 0) {
                   // alert("Efforts cannot be zero for mandatory task");
                      alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Efforts cannot be zero for mandatory task", 'error', 25);
                    objEfforts.focus();
                    return;
                }
            }


        }

        //End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10	
        if (dblEffort > dblDeliverableLCE) {
             //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
            strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_DELIVERABLE_EFFORT"))%>";
            strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
            strmessage = replaceSubstring(strmessage, "<DELIVERABEL_EFFORTS>", "" + dblDeliverableLCE);
            strResponse = confirm(strmessage);

            if (strResponse == false)
                return;
            /************************ Added By VijayD 25 May 2009********************************
                Purpose: To validate Task assignment for baseline
            ************************ ***********************************************************/
            else if (ValidateControls(intRecordCount) == false)
                return;
            /************************************************************************************/
            else {
           
                 StartLoader("#ProjectPlanDeliverable");
                //Added by Dhanashri S on 12 Oct 2016 For Page Loader
                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }
              //  setFrameLoader();
                //End of Addition by Dhanashri S on 12 Oct 2016
              
                document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=Save&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=<%=m_intSpecificationID%>" + "&TaskEffort=" + dblEffort + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
                document.forms[0].submit();
                StopAjaxLoader("#ProjectPlanDeliverable");
            }
        }//End of If for dblEffort > dblDeliverableLCE
        /************************ Added By VijayD 25 May 2009********************************
                Purpose: To validate Task assignment for baseline
         ************************ ***********************************************************/
        else if (ValidateControls(intRecordCount) == false)
            return;
        /************************************************************************************/
        else {
            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            var MenuTags = document.getElementsByTagName('A');
            for (i = 0; i < MenuTags.length; i++) {
                if (MenuTags[i].className == "Menu") {
                    //MenuTags[i].style.display= "none";
                    MenuTags[i].parentNode.style.display = "none";
                }
            }
         //   setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016
            document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=Save&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=<%=m_intSpecificationID%>" + "&TaskEffort=" + dblEffort + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
                    document.forms[0].submit();
                }//End of Else for dblEffort > dblDeliverableLCE
                // End Addition By NitinVS on 16 Feb 2005 
                //Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
                //Hide 'Save' link on its click for static menu (avoid duplicate entries)
                //Start_MV_6/29/2007
                var L1 = GetObjectReference('frmTaskSelection', 'MENU_CREATE_TASKSUP');
                if (L1 != null) {
                    L1.style.display = "none";
                }//End of If for L1
                var L2 = GetObjectReference('frmTaskSelection', 'MENU_CREATE_TASKSDN');
                if (L2 != null) {
                    L2.style.display = "none";
                }//End of If for L2
                //End_MV_6/29/2007
                // Added By NitinVS 16 Feb 2005 
                // To Implement Task Level Planning
                // PBNITE SP2

            }//End of If for create plan at Activity level
            else {

                CreateTaskforTaskLevelPlanning();
            }//End of 'Else' for create plan at Task level 

        }
        // End of the revision by MahendraV On 8/13/2007  for fucntion CreateAssignedTasks_OnClick()

        // Reviewed and Modified by MahendraV on 6:56 PM 8/13/2007 For WhizibleSEM 7.0
        // To sink the code for all project type (Case1,Case2 and Case3) 
        // Start the revision by MahendraV On 8/13/2007
        function ValidateEfforts(intRecordCount) {
            var dblIncrementMinutes, dblEffort;
            var intCount, intProjectPhaseTaskActivityID, intDuration;
            var intCompanyHrsPerDay, intHoursPerDay, intResources;
            var ResourceIDList = '', AtleastOneResource;
            // Added By NitinVS on 28 Feb 2005 
            // To alert user for Maximum work hour for the Organization Unit 
            intCompanyHrsPerDay = 0;
            intCompanyHrsPerDay =  <%=m_dblHoursPerDay%>;
    // End Addition By NitinVS on 28 Feb 2005 
    intResources = 0;
    AtleastOneResource = 0;
    dblEffort = 0;
    dblIncrementMinutes = parseFloat(frmTaskSelection.txtIncrementMinutes.value);

    // If no Minimum Chargable Activity Time found, return
    if (dblIncrementMinutes == 0)
        return true;

    if (intRecordCount > 1) {
        for (intCount = 0; intCount <= frmTaskSelection.txtPhaseTaskID.length - 1; intCount++) {
            intProjectPhaseTaskActivityID = frmTaskSelection.txtProjectPhaseTaskActivityID(intCount).value;
            objStartDate = document.getElementsByName("txtStartDate" + intProjectPhaseTaskActivityID)[0].value;
            objEndDate = document.getElementsByName("txtEndDate" + intProjectPhaseTaskActivityID)[0].value;
            AtleastOneResource = 0;
            intResources = 0;
            ResourceIDList = '';
            dblEffort = 0;
            if (frmTaskSelection.txtReviewActivity(intCount).value == "False") {
                /*'==================================================
				'Modified By	:	HiteshS on 31st Jan.2005
				'IssueID		:	14722
				'Description	:	Added If Condition to Check for ZERO Length check.
				'==================================================*/

                if (trimString(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) == "") {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
                   // alert(strmessage);
                      alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                    objEfforts.focus();
                    //alert('Please enter only positive numeric value !!!');
                    document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].select();
                    return false;
                }//End of IF							
                else {
                    /*Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                    for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].length - 1; intCnt++) {
                        if (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].selected == true) {
                            intResources = intResources + 1;
                            ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].value;
                            AtleastOneResource = 1;
                        }//End of If for Resource Count	

                    }//End of 'For - Loop' for Resource Count
                    if (ResourceIDList.length > 200) {
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                       // alert(strmessage);
                         alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                        //alert("Too Many Resources Selected ");
                        document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].focus();
                        return;
                    }//End of If for 200 validation

                    if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0 && intResources > 0)
                    {
                       // if (disallowNegativeNumeric(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID), 'Please enter only positive numeric value!!!', true)) { return false; }
                         if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value < 0)
                            {
                                 alertify.set('notifier', 'position', 'top-right');
                                 alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                                 return false

                            }


                        if (parseFloat(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                            if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True') {
                                dblEffort = parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value) / intResources;
                            }
                            else {
                                dblEffort = parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value);
                            }//End of 'If-Else' for dblEffort						
                            /*End Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452 */
                        } //End of If for parseFloat
                    }//End of Else for value.length > 0
	                /*'==================================================
					'Modification Ends	:	HiteshS on 31st Jan.2005
					'==================================================*/
                }//End of Else for .value)==""
            }//End of Normal Activity validation(e.i. False)
            else {

                /* Added By NitinVS on 3 Oct 06 for WhizibleSEM 7 IssueID 6452*/
                AtleastOneResource = 1;
                /* End Added By NitinVS on 3 Oct 06 for WhizibleSEM 7 IssueID 6452*/
                intResources = 1;
	            /*'==================================================
				'Modified By	:	HiteshS on 31st Jan.2005
				'IssueID		:	14722
				'Description	:	Added If Condition to Check for ZERO Length check.
				'==================================================*/
                if (trimString(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) == "") {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
                    //alert(strmessage);
                     alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                    //alert('Please enter only positive numeric value!!!');
                    document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].select();
                    return false;
                }//End of If for MSG_ONLY_POSITIVE_NUMERIC_VALUE							
                else if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0) {
                    //if (disallowNegativeNumeric(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0], 'Please enter only positive numeric value!!!', true)) { return false; }
                       if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value < 0)
                            {
                                 alertify.set('notifier', 'position', 'top-right');
                                 alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                                 return false

                            }

                    if (parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {

                        // Added By MahendraV On 11:06 AM 6/27/2007 To check review dates for future plan deliverable
                        if (checkReviewDateForFuturePlan(objStartDate, objEndDate) == false)
                            return false;
                        var OfflineReviewValue = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID).checked;
                        var RevieweeValue = GetObjectReference("frmTaskSelection", "cboReviewee" + intProjectPhaseTaskActivityID).selectedIndex;
                        if (CheckRevieweeForWithoutOfflineReview(OfflineReviewValue, RevieweeValue) == false)
                            return false;
                        // End of Addition by MahendraV	

                        // Added By MahendraV On 5:49 PM 8/16/2007 for WhizibleSEM 7.0
                        // To create FTR only for single day
                        // Strat_MV_8/16/2007
                        if (CheckFTRDateForSingleDay(intProjectPhaseTaskActivityID) == false) { return false; }
                        // End_MV_8/16/2007				
                        dblEffort = parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value);

                    }//End of IF for parseFloat
                }//End of Else for value.length >= 0
	            /*'==================================================
				'Modification Ends	:	HiteshS on 31st Jan.2005
				'==================================================*/
            }//End of Else for Review Activity validation
            /* Validations are to be performed if effort is greater than 0 and at least one resource is selected for the task */
            if (dblEffort > 0 && AtleastOneResource > 0) {
                // Make sure that the effort is in the multiple of Minimum Chargable Activity Time
               // alert(dblIncrementMinutes);
                if (dblIncrementMinutes != '0.016') {//Added By Dipali V On 21st May 2020 For Issue ID 23385
                    if (Mod(dblEffort, dblIncrementMinutes) > 0) {
                        var dblvalidEffortsLow = 0;
                        var dblvalidEffortsHigh = 0;
                        dblvalidEffortsLow = (dblEffort - Mod(dblEffort, dblIncrementMinutes)) * intResources;
                        dblvalidEffortsHigh = ((dblEffort - Mod(dblEffort, dblIncrementMinutes)) + dblIncrementMinutes) * intResources;
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_IN_MULITIPLE_OF_MIN_TIME"))%>";
                        strmessage = replaceSubstring(strmessage, "<MINTIME>", "" + dblIncrementMinutes);
                        strmessage = strmessage + "\n Please assign either [" + dblvalidEffortsLow + "] or [" + dblvalidEffortsHigh + "].";
                        // alert(strmessage);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmessage, 'error', 25);
                        //alert("Please enter the efforts in the multiple of Minimum Chargable Activity Time (" + dblIncrementMinutes + ")");
                        if (frmTaskSelection.txtReviewActivity(intCount).value == "False")
                            document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                        else
                            document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();

                        return false;
                    }//End of If for effort is in the multiple of Minimum Chargable Activity Time
                }
            }//End of If for dateDiff > 0 && AtleastOneResource > 0

	        /*'==================================================
			'Modified By	:	NitinVS on 19 Feb. 2005
			'
			'Description	:	to Validate Effort with Task start date and End Date
			'==================================================*/
            dtmObjStartDate = StringToDate(objStartDate, "<%=m_strDateFormat%>");
            dtmObjEndDate = StringToDate(objEndDate, "<%=m_strDateFormat%>");
            dateDiff = (Math.abs(dtmObjEndDate - dtmObjStartDate) / (1000 * 60 * 60 * 24)) + 1;
            if (dateDiff > 0 && AtleastOneResource > 0) {
                intHoursPerDay = dblEffort / dateDiff;
                if (intHoursPerDay > 24) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_MAX_DAY_HOURS"))%>";
                  //  alert(strmessage);
                     alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                    if (frmTaskSelection.txtReviewActivity(intCount).value == "False")
                        document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                    else
                        document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();

                    return false;
                } //End of If for 24 Validation
                // Added By NitinVS on 28 Feb 2005 for alerting user for Maximum working hours for Organization Unit 
                else if (intHoursPerDay > intCompanyHrsPerDay) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_OU_MAX_HRS"))%>";
                    strmessage = replaceSubstring(strmessage, "<HOURS>", "" + parseFloat(intHoursPerDay).toFixed(2) + "");
                    strmessage = replaceSubstring(strmessage, "<OU_HOURS>", "" + parseFloat(intCompanyHrsPerDay).toFixed(2));
                    strMsg = strmessage;
                    if (!confirm(strMsg)) {
                        if (frmTaskSelection.txtReviewActivity(intCount).value == "False")
                            document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                        else
                            document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();
                        return false;
                    }//End of If for confirm
                }//End of Else for dateDiff > 0 && AtleastOneResource > 0
                // End Addition By NitinVS on 28 Feb 2005 
            }//End of If for dateDiff > 0 && AtleastOneResource > 0
	        /*'==================================================
			'Modification Ends	:	NitinVS on 19 Feb. 2005
			'==================================================*/
        }//End of 'For - loop' for Multiple resources
    }//End of If for intRecordCount > 1
    else {
        /* Modified By nitinVS on 3 Oct 06 for WhizibleSEM SP 7 IssueID 6452 */
        var intResources = 0;
        var ResourceIDList = '';
        var AtleastOneResource = 0;
        intProjectPhaseTaskActivityID = frmTaskSelection.txtProjectPhaseTaskActivityID.value;
        objStartDate = document.getElementsByName("txtStartDate" + intProjectPhaseTaskActivityID)[0].value;
        objEndDate = document.getElementsByName("txtEndDate" + intProjectPhaseTaskActivityID)[0].value;

        if (frmTaskSelection.txtReviewActivity.value == "False") {
            if (trimString(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) == "") {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
               // alert(strmessage);
                 alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                //alert('Please enter only positive numeric value !!!');
                document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].select();
                return false;
            }//End of IF							
            else {
                for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].length - 1; intCnt++) {
                    if (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].selected == true) {
                        intResources = intResources + 1;
                        ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].value
                        AtleastOneResource = 1;
                    }//End of If	

                }//End of 'For-Loop' for Resource count					
                if (ResourceIDList.length > 200) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                    //alert(strmessage);
                     alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                    document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].focus();
                    return;
                }//End of If for 200 validation

                if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0 && intResources > 0) {
                    //if (disallowNegativeNumeric(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID), 'Please enter only positive numeric value!!!', true)) { return false; }

                     if (document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value < 0)
                            {
                                 alertify.set('notifier', 'position', 'top-right');
                                 alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                                 return false

                            }
                    if (parseFloat(document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                        if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True') {
                            dblEffort = parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value) / intResources;
                        }
                        else {
                            dblEffort = parseFloat(frmTaskSelection.elements["txtEffort" + intProjectPhaseTaskActivityID].value);
                        }//End of 'If-Else' for dblEffort
                        /*end  Modified By nitinVS on 3 Oct 06 for WhizibleSEM SP 7 IssueID 6452*/
                    }//End of If for parseFloat
                }//End of IF for value.length > 0
            }//End of Else for value)==""
        }//End of If for Normal Activity of single resources (e.i. False)
        else {
            AtleastOneResource = 1;
            intResources = 1;
            if (trimString(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) == "") {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
                //alert(strmessage);
                 alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                //alert('Please enter only positive numeric value !!!');
                document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].select();
                return false;
            }//End of IF							
            else if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value.length > 0) {
               // if (disallowNegativeNumeric(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID), 'Please enter only positive numeric value!!!', true)) { return false; }
                 if (document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value < 0)
                            {
                                 alertify.set('notifier', 'position', 'top-right');
                                 alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                                 return false

                            }
                if (parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value) > 0) {
                    // Added By MahendraV On 11:06 AM 6/27/2007 To check review dates for future plan deliverable
                    if (checkReviewDateForFuturePlan(objStartDate, objEndDate) == false)
                        return false;
                    var OfflineReviewValue = GetObjectReference("frmTaskSelection", "IsOffline" + intProjectPhaseTaskActivityID).checked;
                    var RevieweeValue = GetObjectReference("frmTaskSelection", "cboReviewee" + intProjectPhaseTaskActivityID).selectedIndex;
                    if (CheckRevieweeForWithoutOfflineReview(OfflineReviewValue, RevieweeValue) == false)
                        return false;
                    // End of Addition by MahendraV	
                    // Added By MahendraV On 5:49 PM 8/16/2007 for WhizibleSEM 7.0
                    // To create FTR only for single day
                    // Strat_MV_8/16/2007
                    if (CheckFTRDateForSingleDay(intProjectPhaseTaskActivityID) == false) { return false; }
                    // End_MV_8/16/2007	
                    dblEffort = parseFloat(document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].value);
                }//End of If for parseFloat
            }//End of Else for value.length > 0 	
        }//End of If for Review Activity of single resources (e.i. True)
        // Make sure that the effort is in the multiple of Minimum Chargable Activity Time
        if (dblEffort > 0 && AtleastOneResource > 0) {
            if (dblIncrementMinutes != '0.016') {//Added By Dipali V On 21st May 2020 For Issue ID 23385
                if (Mod(dblEffort, dblIncrementMinutes) > 0) {
                    var dblvalidEffortsLow = 0;
                    var dblvalidEffortsHigh = 0;
                    dblvalidEffortsLow = (dblEffort - Mod(dblEffort, dblIncrementMinutes)) * intResources;
                    dblvalidEffortsHigh = ((dblEffort - Mod(dblEffort, dblIncrementMinutes)) + dblIncrementMinutes) * intResources;
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_IN_MULITIPLE_OF_MIN_TIME"))%>";
                    strmessage = replaceSubstring(strmessage, "<MINTIME>", "" + dblIncrementMinutes);
                    strmessage = strmessage + "\n Please assign either [" + dblvalidEffortsLow + "] or [" + dblvalidEffortsHigh + "].";
                    // alert(strmessage);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                    if (frmTaskSelection.txtReviewActivity.value == "False")
                        document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                    else
                        document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();
                    return false;
                }//End of If for Mod(dblEffort, dblIncrementMinutes) > 0
            }
        }//End of If for dblEffort > 0 && AtleastOneResource > 0

	    /*'==================================================
		'Modified By	:	NitinVS on 19 Feb. 2005
		'
		'Description	:	to Validate Effort with Task start date and End Date
		'==================================================*/

        dtmObjStartDate = StringToDate(objStartDate, "<%=m_strDateFormat%>");
        dtmObjEndDate = StringToDate(objEndDate, "<%=m_strDateFormat%>");
        dateDiff = (Math.abs(dtmObjEndDate - dtmObjStartDate) / (1000 * 60 * 60 * 24)) + 1;
        if (dateDiff > 0 && AtleastOneResource > 0) {
            intHoursPerDay = dblEffort / dateDiff;
            if (intHoursPerDay > 24) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_MAX_DAY_HOURS"))%>";
               // alert(strmessage);
                 alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                //alert("The work hours per day cannot exceed 24 hours. Please enter valid work hours.");

                if (frmTaskSelection.txtReviewActivity.value == "False")
                    document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                else
                    document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();

                return false;
            }//End of If for 24 Validation
            else if (intHoursPerDay > intCompanyHrsPerDay) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_OU_MAX_HRS"))%>";
                        strmessage = replaceSubstring(strmessage, "<HOURS>", "" + parseFloat(intHoursPerDay).toFixed(2) + "");
                        strmessage = replaceSubstring(strmessage, "<OU_HOURS>", "" + parseFloat(intCompanyHrsPerDay).toFixed(2));
                        strMsg = strmessage;
                        if (!confirm(strMsg)) {
                            if (frmTaskSelection.txtReviewActivity.value == "False")
                                document.getElementsByName("txtEffort" + intProjectPhaseTaskActivityID)[0].focus();
                            else
                                document.getElementsByName("txtReviewerEffort" + intProjectPhaseTaskActivityID)[0].focus();
                            return false;
                        }//End of If for confirm
                    }//End of 'If-Else' for 24 validation				
                }
                /*'==================================================
                'Modification Ends	:	NitinVS on 19 Feb. 2005
                '==================================================*/
            }
        }
        //End of addition - ShamkantD on 4 Dec 2004
        // End of the revision by MahendraV On 8/13/2007 for fucntion ValidateEfforts()
        function Mod(divisee, base) {
            return (divisee - (Math.floor(divisee / base) * base));
        }

        function Close_OnClick() {
            window.close();
        }

        function Template_OnChange() {
        //    debugger;
            var intTemplateID;
            var intDateFormat;

            intDateFormat = "<%=m_intDateFormat%>"    // document.frmTaskSelection.cboDateFormat.value;
            //if (document.forms[0] != null) {
                intTemplateID = document.forms[0].cboTemplate.value;
               
            //} else {
            //   intTemplateID = $("#cboTemplate").val();
            //}
           
          //  $("#cboTemplate").val(intTemplateID);
    //Modified by Puneet M on 23-12-2015
    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
   // setFrameLoader();
    //End of Addition by Dhanashri S on 12 Oct 2016
            StartLoader("#ProjectPlanDeliverable");
            //if (intTemplateID != 0 && intTemplateID != null && intTemplateID != undefined) {
                document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=List&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=" + "<%=m_intSpecificationID%>" + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
                document.forms[0].method = "post";
                document.forms[0].submit();
           //} else {


           //}

              StopAjaxLoader("#ProjectPlanDeliverable");
        }

        function DateFormat_OnChange() {
            var intDateFormat;
            var intTemplateId;

            intTemplateID = document.forms[0].cboTemplate.value;
            intDateFormat = document.forms[0].cboDateFormat.value;
            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
          //  setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016
            document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=List&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=" + "<%=m_intSpecificationID%>" + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
            document.forms[0].method = "post";
            document.forms[0].submit();
        }

        function ResourceLoading(intProjectPhaseTaskActivityID, blnReviewActivity) {
            var intCnt, strResourceList;
            var intY;
            strResourceList = '';

            if (blnReviewActivity == "True") {
                if (document.getElementsByName("cboReviewer" + intProjectPhaseTaskActivityID)[0].length > 0) {
                    strResourceList = " Select ";
                    strResourceList += (document.getElementsByName("cboReviewer" + intProjectPhaseTaskActivityID)[0].options[intCnt].value);
                    strResourceList += " As ResourceID ,'";
                    strResourceList += (frmTaskSelection("cboReviewer" + intProjectPhaseTaskActivityID).options(frmTaskSelection("cboReviewer" + intProjectPhaseTaskActivityID).selectedIndex).text);
                    strResourceList += "' As ResourceName";
                    if (document.getElementsByName("cboReviewee" + intProjectPhaseTaskActivityID)[0].length > 0) {
                        if ((document.getElementsByName("cboReviewer" + intProjectPhaseTaskActivityID)[0].value) != (document.getElementsByName("cboReviewee" + intProjectPhaseTaskActivityID)[0].value)) {
                            strResourceList += " Union Select ";
                            strResourceList += (document.getElementsByName("cboReviewee" + intProjectPhaseTaskActivityID)[0].value);
                            strResourceList += " As ResourceID ,'";
                            strResourceList += (frmTaskSelection("cboReviewee" + intProjectPhaseTaskActivityID).options(frmTaskSelection("cboReviewee" + intProjectPhaseTaskActivityID).selectedIndex).text);
                            strResourceList += "' As ResourceName";
                        }
                    }
                }
            }
            else {
                for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].length - 1; intCnt++) {
                    if (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].selected == true) {
                        if (strResourceList.length == 0)
                            strResourceList = strResourceList + " Select ";
                        else
                            strResourceList = strResourceList + " Union Select ";

                        strResourceList += (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].value);
                        strResourceList += " As ResourceID ,'";
                        strResourceList += (document.getElementsByName("cboResource" + intProjectPhaseTaskActivityID)[0].options[intCnt].text);
                        strResourceList += "' As ResourceName";
                    }
                }
            }

            if (strResourceList.length == 0) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_RESOURCE_LOADING"))%>";
      //  alert(strmessage);
                 alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
        //alert("Select the resources for viewing the Resource Loading");

    }
    else
        window.open("../PM/PM_ProjecPlanDeliverableResourceLoading.aspx?Mode=Select&MasterTagID=<%=m_intTagID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&ResourceList=" + strResourceList, "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 950) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=900,height=600");
        }

        //function CheckDateFieldValidity(strDateString,m_strDateFormat)
        //{
        //    var strDD, strMM, strYY;
        //    var intDD, intMM, intYY;

        //    var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

        //    //var matchArray = strDateString.match(datePat); // is the format ok?
        //    var matchArray = strDateString.contains(datePat); // is the format ok?

        //    if (matchArray == null) 
        //    {	
        //        alert("The Date entered is not in a valid format.");
        //        return false;
        //    }


        //    if (m_strDateFormat == "dd-mm-yyyy" )
        //    {
        //        intDD = matchArray[1];
        //        intMM = matchArray[3]; 
        //        intYY = matchArray[4];
        //    }
        //    else if (m_strDateFormat == "mm-dd-yyyy")
        //    {
        //        intMM = matchArray[1];
        //        intDD = matchArray[3]; 
        //        intYY = matchArray[4];
        //    }


        //    if (isNaN(intDD) || isNaN(intMM) || isNaN(intYY))
        //    {
        //        alert("Please enter number values for Day, Month and Year!!");
        //        isOK = false;
        //        return false;
        //    }

        //    if ( intDD < 1 || intMM < 1 || intYY < 1 )
        //    {
        //        alert("Month, Date and Year values should be positive and greater than 0!");
        //        isOK = false;
        //        return false;
        //    }

        //    if (intYY < 1753) 
        //    {
        //        alert("The year entered is out of range.");
        //        return false;
        //    }

        //    if (intMM < 1 || intMM > 12) 
        //    { // check month range
        //        alert("Month must be between 1 and 12.");
        //        return false;
        //    }

        //    if (intDD < 1 || intDD > 31) 
        //    {
        //        alert("Day must be between 1 and 31.");
        //        return false;
        //    }

        //    if ((intMM==4 || intMM==6 || intMM==9 || intMM==11) && intDD==31) 
        //    {
        //        alert("Month "+intMM+" doesn't have 31 days!");
        //        return false;
        //    }

        //    if (intMM == 2) 
        //    { // check for february 29th
        //        var isleap = (intYY % 4 == 0 && (intYY % 100 != 0 || intYY % 400 == 0));

        //        if (intDD>29 || (intDD>28 && !isleap)) 
        //        {
        //            alert("February " + intYY + " doesn't have " + intDD + " days!");
        //            return false;
        //        }
        //    }
        //    return true;
        //}	
        function CheckDateFieldValidity(strDateString, m_strDateFormat) {
            var strDD, strMM, strYY;
            var intDD, intMM, intYY;

            var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;

            var matchArray = strDateString.match(datePat); // is the format ok?

            if (matchArray == null) {
              //  alert("The Date entered is not in a valid format.");
              

                   alertify.set('notifier', 'position', 'top-right');
                alertify.notify('The Date entered is not in a valid format.', 'error', 25);
                  return false;
            }


            if (m_strDateFormat == "dd-mm-yyyy") {
                intDD = matchArray[1];
                intMM = matchArray[3];
                intYY = matchArray[4];
            }
            else if (m_strDateFormat == "mm-dd-yyyy") {
                intMM = matchArray[1];
                intDD = matchArray[3];
                intYY = matchArray[4];
            }


            if (isNaN(intDD) || isNaN(intMM) || isNaN(intYY)) {
                //alert("Please enter number values for Day, Month and Year!!");
                 alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please enter number values for Day, Month and Year!!", 'error', 25);
                isOK = false;
                return false;
            }

            if (intDD < 1 || intMM < 1 || intYY < 1) {
               // alert("Month, Date and Year values should be positive and greater than 0!");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Month, Date and Year values should be positive and greater than 0!", 'error', 25);
                isOK = false;
                return false;
            }

            if (intYY < 1753) {
               // alert("The year entered is out of range.");
                  alertify.set('notifier', 'position', 'top-right');
                alertify.notify("The year entered is out of range.", 'error', 25);
                return false;
            }

            if (intMM < 1 || intMM > 12) { // check month range
                //alert("Month must be between 1 and 12.");
                 alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Month must be between 1 and 12.", 'error', 25);
                return false;
            }

            if (intDD < 1 || intDD > 31) {
                //alert("Day must be between 1 and 31.");
                 alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Day must be between 1 and 31.", 'error', 25);
                return false;
            }

            if ((intMM == 4 || intMM == 6 || intMM == 9 || intMM == 11) && intDD == 31) {
                var MName;
                if (intMM == 4)
                    MName = "April";
                if (intMM == 6)
                    MName = "June";
                if (intMM == 9)
                    MName = "September";
                if (intMM == 11)
                    MName = "November";
                //alert("Month " + MName + " doesn't have 31 days!");
                 alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Month " + MName + " doesn't have 31 days!", 'error', 25);
                return false;
            }

            if (intMM == 2) { // check for february 29th
                var isleap = (intYY % 4 == 0 && (intYY % 100 != 0 || intYY % 400 == 0));

                if (intDD > 29 || (intDD > 28 && !isleap)) {
                  //  alert("February " + intYY + " doesn't have " + intDD + " days!");
                     alertify.set('notifier', 'position', 'top-right');
                alertify.notify("February " + intYY + " doesn't have " + intDD + " days!", 'error', 25);
                    return false;
                }
            }
            return true;
        }
        function StringToDate(strInDate, strDateFormat) {
            var dtRetDate;
            var strRepStr = /-/g;             //Create regular expression pattern for replacing "-" with "/"
            var strMonthname = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
            var strDay = "";
            var strMonth = "";
            var strYear = "";
            var strLongDate = "";
            var intPosSep = 0;		// Position of separator i.e. "/"

            if (strInDate.indexOf("-") > 0)
                strInDate = strInDate.replace(strRepStr, "/");

            intPosSep = strInDate.indexOf("/");

            if (strDateFormat == "dd-mm-yyyy") {
                strDay = strInDate.substr(0, intPosSep);
                strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));

                intPosSep = strInDate.indexOf("/");
                strMonth = strInDate.substr(0, intPosSep);
                strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));
            }

            if (strDateFormat == "mm-dd-yyyy") {
                strMonth = strInDate.substr(0, intPosSep);
                strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));

                intPosSep = strInDate.indexOf("/");
                strDay = strInDate.substr(0, intPosSep);
                strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));
            }
            strYear = strInDate;

            strLongDate = strMonthname[parseFloat(strMonth) - 1] + " " + strDay + ", " + strYear;

            dtRetDate = new Date(strLongDate);
            return (dtRetDate);
        }

        function GetTaskDetails(intPhaseTaskID) {
            var objTaskName = GetObjectReference("frmTaskSelection", "txtPhaseTaskName" + intPhaseTaskID);
            var objTextNotes = GetObjectReference("frmTaskSelection", "txtPhaseTaskNotes" + intPhaseTaskID);
            var objPriority = GetObjectReference("frmTaskSelection", "txtPriority" + intPhaseTaskID);
            var objEstimationTypeID = GetObjectReference("frmTaskSelection", "txtEstimationTypeID" + intPhaseTaskID);
            var objPhaseID = GetObjectReference("frmTaskSelection", "txtPhaseID" + intPhaseTaskID);
            var objModuleID = GetObjectReference("frmTaskSelection", "txtModuleID" + intPhaseTaskID);
            var objSubProjectID = GetObjectReference("frmTaskSelection", "txtSubProjectID" + intPhaseTaskID);
            var objMilestoneID = GetObjectReference("frmTaskSelection", "txtMilestoneID" + intPhaseTaskID);
            var objChangeRequestID = GetObjectReference("frmTaskSelection", "txtChangeRequestID" + intPhaseTaskID);
            var objFeatureID = GetObjectReference("frmTaskSelection", "txtFeatureID" + intPhaseTaskID);

            var strTaskName = objTaskName.value;
            var strPriority = objPriority.value;
            var intEstimationTypeID = objEstimationTypeID.value;
            var intPhaseID = objPhaseID.value;
            var intModuleID = objModuleID.value;
            var intSubProjectID = objSubProjectID.value;
            var intMilestoneID = objMilestoneID.value;
            var intChangeRequestID = objChangeRequestID.value;
            var intFeatureID = objFeatureID.value;

          //  window.open("PM_GetTaskDetails.aspx?MasterTagID=" + "<%=m_intTagId%>" + "&PhaseTaskName=" + strTaskName + "&PhaseTaskID=" + intPhaseTaskID + "&Priority=" + strPriority + "&EstimationTypeID=" + intEstimationTypeID + "&PhaseID=" + intPhaseID + "&ModuleID=" + intModuleID + "&SubProjectID=" + intSubProjectID + "&MilestoneID=" + intMilestoneID + "&ChangeRequestID=" + intChangeRequestID + "&FeatureID=" + intFeatureID, "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=750,height=400");
            window.open("PM_WBSGetTaskDetails.aspx?intProjectID=" + "<%=m_ProjectID%>" + "&MasterTagID=" + "<%=m_intTagId%>" + "&PhaseTaskName=" + strTaskName + "&PhaseTaskID=" + intPhaseTaskID + "&Priority=" + strPriority + "&EstimationTypeID=" + intEstimationTypeID + "&PhaseID=" + intPhaseID + "&ModuleID=" + intModuleID + "&SubProjectID=" + intSubProjectID + "&MilestoneID=" + intMilestoneID + "&ChangeRequestID=" + intChangeRequestID + "&FeatureID=" + intFeatureID, "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=900,height=600");
            return;
        }

        // Reviewed and Modified by MahendraV on 6:56 PM 8/13/2007 For WhizibleSEM 7.0
        // To sink the code for all project type (Case1,Case2 and Case3) 
        // Start the revision by MahendraV On 8/13/2007

        // Added By NitinVS on 16 Feb 2005 
        // PBNITE SP2
        // To Implement Task Level Planning

        function CreateTaskforTaskLevelPlanning() {


            var intCount, intRecordCount, intCnt;
            var intResources, intTemplateID, intResponse, intPhaseTaskID, intDateFormat;
            var dblEffort, dtmStartDt, dtmEndDt, dblDeliverableLCE;
            var dblProjectAssignedTaskHrs, dblProjectWorkHrs;
            var strAlertMsg, strDescription, strResponse;
            var strPhaseTaskName, ResourceIDList, AtleastOneResource;

            ResourceIDList = "";
            strAlertMsg = "";
            dblDeliverableLCE = 0;
            dblEffort = 0;
            intCount = 0;

            /*'==============================================================
            'Added By       :   HiteshS on 31st Jan.2005
            'IssueID        :   15430
            'Description    :   Variable to hold Assigned Task Hours for a Project
            '==============================================================*/
            dblProjectAssignedTaskHrs = 0;
            dblProjectAssignedTaskHrs = parseFloat("<%=m_dblProjectAssignedTaskHrs%>");
    /*'==============================================================
	'End Of Addition By HiteshS on 31st Jan.2005
	'==============================================================*/
    AtleastOneResource = 0;
    intDateFormat = "<%=m_intDateFormat%>"
    dtmStartDt = "<%=FixDateForDisplay(m_dtStartDate, m_intDateFormat)%>";
    dtmEndDt = "<%=FixDateForDisplay(m_dtEndDate, m_intDateFormat)%>";
    intTemplateID = frmTaskSelection.cboTemplate.value;
    dblDeliverableLCE = parseFloat("<%=m_dblDeliverableLCE%>");
    dblProjectWorkHrs = parseFloat("<%=m_dblProjectWorkHrs%>");


    if (frmTaskSelection.txtRecordCount.value.length == 0)
        intRecordCount = 0;
    else
        intRecordCount = frmTaskSelection.txtRecordCount.value;

    if (intRecordCount == 0) {
        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_NO_EXECUTION_TEMPLATE"))%>";
       // alert(strmessage);
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
        frmTaskSelection.cboTemplate.focus();
        return;
    }//End of If
    //Validate efforts
    if (validateTaskLevelPlanning(intRecordCount) == false)
        return;

    //Calculate the Total Effort
    if (intRecordCount > 1) {

        //Total Effort Calculation
        for (intCount = 0; intCount <= frmTaskSelection.txtPhaseTaskID.length - 1; intCount++) {

            //intPhaseTaskID			= frmTaskSelection.txtPhaseTaskID(intCount).value;
            intPhaseTaskID = frmTaskSelection.txtPhaseTaskID[intCount].value;
            var objTaskName = GetObjectReference("frmTaskSelection", "txtPhaseTaskName" + intPhaseTaskID);
            dtmStartDt = document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].value;
            dtmEndDt = document.getElementsByName("txtEndDate" + intPhaseTaskID)[0].value;
            ResourceIDList = '';
            intResources = 0;
            // Validate start Date and End Date 							
            // Added By MahendraV On 11:54 AM 7/23/2007 For WhizibleSEM 7.0 
            // Purpose		: To Validate Task Start And End Date.IssueID(14441)
            // Start_MV_7/23/2007

            if (CheckDates(intPhaseTaskID, dtmStartDt, dtmEndDt, objTaskName.value, strAlertMsg) == false)
                return;
            var objWorkHour = GetObjectReference('frmTaskSelection', 'txtEffort' + intPhaseTaskID)


            if (intResourceValidation == 1) {
                if (objWorkHour != null) {
                    if (parseFloat(objWorkHour.value == "" ? "0" : objWorkHour.value) > 0) {
                        if (frmTaskSelection.txtReviewTask[intCount].value == "False") {
                            if (CheckResourceDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboResource' + intPhaseTaskID)) == false)
                                return;
                        }//End of If for Resource Dates validation of review task 
                        else {
                            if (CheckReviewerDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewer' + intPhaseTaskID)) == false)
                                return;
                            // Modified By MahendraV On 1:07 PM 7/27/2007 For WhizibleSEM 7.0 
                            // Purpose		: To Validate Task Start And End Date for review.IssueID(14445)
                            // Start_MV_7/27/2007
                            var objOffRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID);
                            if (objOffRewiew != null) {
                                if (objOffRewiew.checked == false) {
                                    if (CheckRevieweeDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewee' + intPhaseTaskID)) == false)
                                        return;
                                }//End of If for Reviewee Dates validation
                            }//End of If for objOffRewiew!= null
                        }//End of Else for Reviewer and Reviewee Dates validation of review task 
                        // End_MV_7/27/2007
                    }//End of If
                }//End of If for objWorkHour != null
            }//End of If for Resource Validation is aplicable(intResourceValidation=1)
            // End_MV_7/23/2007
            if (frmTaskSelection.txtReviewTask[intCount].value == "False") {
                for (intCnt = 0; intCnt <= frmTaskSelection.elements["cboResource" + intPhaseTaskID].length - 1; intCnt++) {
                    if (document.getElementsByName("cboResource" + intPhaseTaskID)[0].options[intCnt].selected == true) {
                        intResources = intResources + 1;
                        ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intPhaseTaskID)[0].options[intCnt].value;
                        AtleastOneResource = 1;

                    }//End of If	
                }//End of For Loop for Resource Count
                if (ResourceIDList.length > 200) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                   // alert(strmessage);
                      alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
                    frmTaskSelection.elements["cboResource" + intPhaseTaskID].focus();
                    return;
                }//End of If for 200 validation
                if (frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value.length > 0 && intResources > 0) {
                    if (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value) > 0 && intResources > 0) {
                        //added by Harshk on 25/08/2005 sp4 issueid 120,121 
                        if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'False') {
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value)) * intResources;
                        }
                        else {
                            dblEffort = dblEffort + (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value));
                        }//End of If-Else for dblEffort		
                        //end added by Harshk on 25/08/2005 sp4 issueid 120,121 

                    }//End of If

                }//End of if 
                ////Added by MahendraV on 10:45 AM 6/09/2007 for SP8 Review Information:
                // Start_MV_6/09/2007
            }
            else {
                AtleastOneResource = 1;
                var objOfflineRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID);
                if (objOfflineRewiew != null) {
                    if (objOfflineRewiew.checked == true) { intResources = intResources + 1; }
                    else
                        intResources = intResources + 2;
                }
                else
                    intResources = intResources + 2;

                if (document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value.length > 0) {
                    if (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) > 0) {
                        if ((document.getElementsByName("cboReviewer" + intPhaseTaskID)[0].value) != (document.getElementsByName("cboReviewee" + intPhaseTaskID)[0].value))
                            dblEffort = dblEffort + (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) * intResources);
                        else
                            dblEffort = dblEffort + parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value);

                    }//End of If for dblEffort
                }//End of If
                // End_MV_6/09/2007				
            }//End of If for Review validation (i.e. True)
        }//End of 'For-Loop' for each task validation 
    }//End of If for intResourceCount > 1	
    else {
        intPhaseTaskID = frmTaskSelection.txtPhaseTaskID.value;
        var objTaskName = GetObjectReference("frmTaskSelection", "txtPhaseTaskName" + intPhaseTaskID);
        AtleastOneResource = 0;
        intResources = 0;
        //Added by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
        ResourceIDList = '';
        //End Of Addition by NitinVS on 1 July 2005 for Nucleus IssueID 19623 whizibleSEMSP4
        dtmStartDt = document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].value;
        dtmEndDt = document.getElementsByName("txtEndDate" + intPhaseTaskID)[0].value;
        if (CheckDates(intPhaseTaskID, dtmStartDt, dtmEndDt, objTaskName.value, strAlertMsg) == false)
            return false;
        // Added by Harshk sp4 issueID 120,121 
        var objWorkHour = GetObjectReference('frmTaskSelection', 'txtEffort' + intPhaseTaskID)


        //Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
        objWorkHour = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];
        objHMEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];
        if (objHMEffort.value.toString().indexOf(":") != -1) {
            var chkhr = objHMEffort.value.split(":")[0];
            var chkmin = objHMEffort.value.split(":")[1];
            if (chkhr.length == 1) {
                chkhr = "0" + chkhr;
                objHMEffort.value = chkhr + ":" + chkmin;
            }
            if (chkmin.length == 1) {
                chkmin = chkmin + "0";
                objHMEffort.value = chkhr + ":" + chkmin;
            }
        }
        var dataHM = JSON.stringify({ HMHours: objHMEffort.value });
        var decTotalWorkResult = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/getDecimalHours", dataHM, false);

        var decEfforts = decTotalWorkResult.d;

        //End of Added By Usha Pandit on 05-Apr-2019 Purpose:: Project Work field level changes

        if (intResourceValidation == 1) {
            if (objWorkHour != null) {
                //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                //if (parseFloat(objWorkHour.value == "" ? "0" : objWorkHour.value) > 0)
                if (parseFloat(decEfforts == "" ? "0" : decEfforts) > 0)
                //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                {
                    if (frmTaskSelection.txtReviewTask.value == "False") {
                        if (CheckResourceDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboResource' + intPhaseTaskID)) == false)
                            return false;
                    }//End of If for Resource Dates validation of normal task 
                    else {
                        // Added By MahendraV On 11:54 AM 7/23/2007 For WhizibleSEM 7.0 
                        // Purpose		: To Validate Task Start And End Date .IssueID(14441)
                        // Start_MV_7/23/2007						
                        if (CheckReviewerDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewer' + intPhaseTaskID)) == false)
                            return;
                        // Modified By MahendraV On 1:07 PM 7/27/2007 For WhizibleSEM 7.0 
                        // Purpose		: To Validate Task Start And End Date for review.IssueID(14445)
                        // Start_MV_7/27/2007
                        var objOffRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID);
                        if (objOffRewiew != null) {
                            if (objOffRewiew.checked == false) {
                                if (CheckRevieweeDates(dtmStartDt, dtmEndDt, GetObjectReference('frmTaskSelection', 'cboReviewee' + intPhaseTaskID)) == false)
                                    return;
                            }
                        }//End of If for Reviewee date validation
                    }//End of Else for Reviewer and Reviewee Dates validation of review task 
                    // End_MV_7/27/2007
                    // End_MV_7/23/2007
                }// End of If 
            }//End of If for objWorkHour != null
        }// End of If for intResourceValidation == 1
        //END Added by Harshk sp4 issueID 120,121  cboReviewee
        if (frmTaskSelection.txtReviewTask.value == "False") {
            //for(intCnt = 0;intCnt<=frmTaskSelection.elements("cboResource" + intPhaseTaskID).length - 1;intCnt++)
            //{	

            //    if (document.frmTaskSelection.elements("cboResource" + intPhaseTaskID).options(intCnt).selected == true) 
            for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intPhaseTaskID)[0].length - 1; intCnt++) {
                // alert(document.getElementById("cboResource" + intPhaseTaskID)[intCnt].selected);
                if (document.getElementById("cboResource" + intPhaseTaskID)[intCnt].selected == true) {
                    intResources = intResources + 1;
                    ResourceIDList = ResourceIDList + "," + document.getElementById("cboResource" + intPhaseTaskID)[intCnt].value;;
                    AtleastOneResource = 1;
                }
            }//End of If for CountResources
            if (ResourceIDList.length > 200) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
               // alert(strmessage);
                   alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
                document.getElementById("cboResource" + intPhaseTaskID)[intCnt].focus();
                return;
            }//End of If for 200 validation

            //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
            //if (document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value.length > 0 && intResources > 0)
            if (decEfforts.length > 0 && intResources > 0)
            //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
            {
                //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                //if (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) > 0)
                if (parseFloat(decEfforts) > 0)
                //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                {
                    if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'False') {
                        //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                        //dblEffort = dblEffort + (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value)) * intResources;
                        dblEffort = dblEffort + (parseFloat(decEfforts)) * intResources;
                        //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                    }
                    else {
                        //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                        //dblEffort = dblEffort + (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value));
                        dblEffort = dblEffort + (parseFloat(decEfforts));
                        //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes

                    }//End of If for dblEffort	

                }//End of If
            }//End of If	
            //Added by MahendraV on 10:45 AM 6/09/2007 for SP8 Review Information:
            // Start_MV_6/09/2007
        }//End of If normal task validation (i.e. False)
        else {
            AtleastOneResource = 1;
            var objOfflineRewiew = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID);
            if (objOfflineRewiew != null) {
                if (objOfflineRewiew.checked == true) { intResources = intResources + 1; }
                else
                    intResources = intResources + 2;
            }
            else
                intResources = intResources + 2;

            if (document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value.length > 0) {
                if (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) > 0) {
                    if ((document.getElementsByName("cboReviewer" + intPhaseTaskID)[0].value) != (document.getElementsByName("cboReviewee" + intPhaseTaskID)[0].value))
                        dblEffort = dblEffort + (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) * intResources);
                    else
                        dblEffort = dblEffort + parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value)

                }//End of If
            }//End of If		
            // End_MV_6/09/2007					
        }//End of Else for Review validation (e.i.True)					
    }//End of Else for intRecordCount >1
    // Added by ShamkantD on 13 Dec 2004
            if (dblEffort > dblProjectWorkHrs) {
                //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_PROJECT_EFFORT"))%>";
        strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
        strmessage = replaceSubstring(strmessage, "<PROJECT_EFFORT>", "" + dblProjectWorkHrs);
        //alert(strmessage);
           alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
        return;
    }//End of If for dblEffort > dblProjectWorkHrs
    // End of addition - ShamkantD on 13 Dec 2004
    // End of addition - ShamkantD on 13 Dec 2004

    /*'==============================================================
	'Added By       :   HiteshS on 31st Jan.2005
	'IssueID        :   15430
	'Description    :   Variable to hold Assigned Task Hours for a Project
	'==============================================================*/
            if (dblEffort > (dblProjectWorkHrs - dblProjectAssignedTaskHrs)) {
         //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_PROJECT_BALANCE_EFFORT"))%>";
        strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
        strmessage = replaceSubstring(strmessage, "<PROJECT_BALANCE_HRS>", "" + (dblProjectWorkHrs - dblProjectAssignedTaskHrs));
       // alert(strmessage);
           alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
        return;
    }//End of If for dblEffort > (dblProjectWorkHrs - dblProjectAssignedTaskHrs)
    /*'==============================================================
	'End Of Addition By HiteshS on 31st Jan.2005
	'==============================================================*/
    //Added by PadmnabhA IssueID 15414	
    if (AtleastOneResource == 0) {
        //added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
           // strmessage = "<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_NO_RESOURCE"))%>";
            strmessage = "Select at least one resource for selected activity";
              //Endof added & Commented By Dipali V On 16th Dec 2019 For Alter Change issue
           alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
        //alert("Select atleast one resource for selected execution Template");
        return;
    }//End of If AtleastOneResource == 0
    //Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
    else {

        var TaskMandatoryArr = new Array();
        TaskMandatoryArr ="<%=TaskMandatoryArr%>".split(",");
        ReviewTaskArr = "<%=ReviewTaskArr%>".split(",");
        //alert(TaskMandatoryArr[0]);
        var j;
        for (j = 1; j < TaskMandatoryArr.length; j = j + 2) {

            var objEfforts = GetObjectReference('frmTaskSelection', 'txtEffort' + TaskMandatoryArr[j - 1]);
            //var objReviewTask =GetObjectReference('frmTaskSelection','txtReviewTask' + ReviewTaskArr[j-1]);
            var objResource = GetObjectReference('frmTaskSelection', 'cboResource' + ReviewTaskArr[j - 1]);
            if (TaskMandatoryArr[j] == "True")//&& objcboResource == null) 
            {

                if (ReviewTaskArr[j] == "False") {
                    if (objResource.value == "") {
                        alert("Please select resource for mandatory task");
                        frmTaskSelection.elements["cboResource" + ReviewTaskArr[j - 1]].focus();
                        return;
                    }
                }

            }
        }

    }


    //End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
           // alert(dblEffort);
    if (parseFloat(dblEffort) == 0) {
       // strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_NO_EFFORT"))%>";
      //  strmessage = "Please select at least one resource(s) for the activity";
       // alert(strmessage);
      //     alertify.set('notifier', 'position', 'top-right');
      //  alertify.notify(strmessage, 'error', 25);
      //  return;
    }//End of If dblEffort == 0
    //Addition Ends
    //Added by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10
    else {
        var TaskMandatoryArr = new Array();
        TaskMandatoryArr ="<%=TaskMandatoryArr%>".split(",");
        //alert(TaskMandatoryArr[0]);
        var j;
        for (j = 1; j < TaskMandatoryArr.length; j = j + 2) {
            //var objEfforts = GetObjectReference('frmTaskSelection','txtEffort'+ TaskMandatoryArr[j-1]);COMMENTED BY NILESH G ON 15/1/2016
            var objEfforts = document.getElementById('frmTaskSelection', 'txtEffort' + TaskMandatoryArr[j - 1]);
            //alert(TaskMandatoryArr[j]+ ',' + objEfforts.value);
            if (TaskMandatoryArr[j] == "True" && objEfforts.value == 0) {
                alert("Efforts cannot be zero for mandatory task");
                objEfforts.focus();
                return;
            }
        }
    }
    //End of Addition by RuchiraC for Hexaware-RequestID-25641 on 05-Apr-10


            if (dblEffort > dblDeliverableLCE) {
                 //Added By Dipali V On 29th April 2020 For Effort should be HH:MM
                var RequestParameters = {
                               WorkHrs: encodeURI(dblEffort),
                               Flag: encodeURI(1),
                  }
                  var param = JSON.stringify(RequestParameters);
           var lngHours = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/ConvertDecimalToHourViceVersa", param, false);
             //End of  Added By Dipali V On 29th April 2020 For Effort should be HH:MM
        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_DELIVERABLE_EFFORT"))%>";
        strmessage = replaceSubstring(strmessage, "<EFFORT>", "" + lngHours.d);
        strmessage = replaceSubstring(strmessage, "<DELIVERABEL_EFFORTS>", "" + dblDeliverableLCE);
        strResponse = confirm(strmessage);
        if (strResponse == false)
            return;
        /************************ Added By VijayD 25 May 2009********************************
                Purpose: To validate Task assignment for baseline
         ************************ ***********************************************************/
        else if (ValidateControls(intRecordCount) == false)
            return;
        /************************************************************************************/

        else {
            //Added by Dhanashri S on 12 Oct 2016 For Page Loader
            var MenuTags = document.getElementsByTagName('A');
            for (i = 0; i < MenuTags.length; i++) {
                if (MenuTags[i].className == "Menu") {
                    //MenuTags[i].style.display= "none";
                    MenuTags[i].parentNode.style.display = "none";
                }
            }
           // setFrameLoader();
            //End of Addition by Dhanashri S on 12 Oct 2016
            document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=Save&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=<%=m_intSpecificationID%>" + "&TaskEffort=" + dblEffort + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
            document.forms[0].submit();
        }//end of 'If-Else'
    }//End of dblEffort > dblDeliverableLCE

    /************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
    ************************ ***********************************************************/
    else if (ValidateControls(intRecordCount) == false)
        return;
    /************************************************************************************/
    else {
        //     alert(dblEffort);
        //alert(dblDeliverableLCE);
        //alert(11);
        //Added by Dhanashri S on 12 Oct 2016 For Page Loader
        var MenuTags = document.getElementsByTagName('A');
        for (i = 0; i < MenuTags.length; i++) {
            if (MenuTags[i].className == "Menu") {
                //MenuTags[i].style.display= "none";
                MenuTags[i].parentNode.style.display = "none";
            }
        }
       // setFrameLoader();
        //End of Addition by Dhanashri S on 12 Oct 2016
        document.forms[0].action = "../PM/PM_ProjecPlanDeliverable.aspx?Mode=Save&MasterTagID=<%=m_intTagId%>&ProjectID=<%=m_ProjectID%>&DeliverableID=<%=m_intDeliverableID%>&DeliverableTypeID=<%=m_intDeliverableTypeID%>&OtherScheduleQueryString=<%=Server.URLEncode(m_strQueryString)%>&TemplateID=" + intTemplateID + "&SpecificationID=<%=m_intSpecificationID%>" + "&TaskEffort=" + dblEffort + "&DateFormat=" + intDateFormat + "&FromWhere=<%=m_strFromWhere%>" + "&PagingAlphabet=<%=m_strPagingAlphabet%>" + "&SortBy=<%=m_strSortBy%>" + "&SortOrder=<%=m_strSortOrder%>" + "&ParentTagID=<%=m_strParentTagID%>" + "&FromCL=<%=m_strFromCL%>";
                document.forms[0].submit();
            }//End of Else
            // End Addition By NitinVS on 16 Feb 2005 
            //Added by MahendraV On 6:13 PM 6/29/2007 For WhizibleSEM 7
            //Hide 'Save' link on its click for static menu (avoid duplicate entries)
            //Start_MV_6/29/2007
            var L1 = GetObjectReference('frmTaskSelection', 'MENU_CREATE_TASKSUP');
            if (L1 != null) {
                L1.style.display = "none";
            }//End of L1
            var L2 = GetObjectReference('frmTaskSelection', 'MENU_CREATE_TASKSDN');
            if (L2 != null) {
                L2.style.display = "none";
            }//End of L2
            //End_MV_6/29/2007
        }
        // End of the revision by MahendraV On 8/13/2007 for fucntion CreateTaskforTaskLevelPlanning()

        //Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
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
                    //Stop();
                },
                error: function (xhr, status, error) {
                    //Stop();
                    //StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }
        //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes

        // Reviewed and Modified by MahendraV on 6:56 PM 8/13/2007 For WhizibleSEM 7.0
        // To sink the code for all project type (Case1,Case2 and Case3) 
        // Start the revision by MahendraV On 8/13/2007
        function validateTaskLevelPlanning(intRecordCount) {
            var dblIncrementMinutes, dblEffort, dtmEndDt, dtmStartDt;
            var intCount, intPhaseTaskID, intDuration, intHoursPerDay;
            var intCompanyHrsPerDay, intResources, intCompanyHrsPerDay;
            var ResourceIDList, strAlertMsg = ""

            intCompanyHrsPerDay = 0;
            intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
    // By NitinVS on 28 Sep 2006 
    intResources = 0;
    ResourceIDList = '';
    // By NitinVS on 28 Sep 2006 				
    dblIncrementMinutes = parseFloat(frmTaskSelection.txtIncrementMinutes.value);
    // If no Minimum Chargable Activity Time found, return
    if (dblIncrementMinutes == 0)
        return true;

    if (intRecordCount > 1) {

        //Total Effort Calculation
        for (intCount = 0; intCount <= frmTaskSelection.txtPhaseTaskID.length - 1; intCount++) {
            //cOMMENTED AND ADDED BY nILESH G ON 12/2/2016 FOR JAVASCRIPT
            intPhaseTaskID = frmTaskSelection.txtPhaseTaskID[intCount].value;
            //intPhaseTaskID          = document.getElementsByName(txtPhaseTaskID)[intCount].value;
            objStartDate = document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].value;
            objEndDate = document.getElementsByName("txtEndDate" + intPhaseTaskID)[0].value;
            AtleastOneResource = 0;
            intResources = 0;
            ResourceIDList = '';
            dblEffort = 0;
            /*'==================================================
			'Modified By	:	NitinVS on 23 Mar.2005
			'IssueID		:	16966 
								On the Planned Deliverables page for case 1,2 , keep Work Hrs for some task Blank and select its repective Resources, while the other Resources and Work Hrs should be filled and click on Create task. - Page Crashes.
			'Description	:	Added If Condition to Check for ZERO Length check.
			'==================================================*/

            if (frmTaskSelection.txtReviewTask[intCount].value == "False") {
                if (trimString(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) == "") {

                    //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                   <%-- strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
	                alert(strmessage);
	                //alert('Please enter only positive numeric value !!!');
	                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
	                return false;
	                /*'==================================================
                        'Modification Ends	:	NitinVS on 23 Mar.2005 IssueID 16966
                    '==================================================*/--%>


                    //alert("Work(Hrs) should not left blank");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Work(Hrs) should not left blank.", 'error', 25);
              
                    document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                    return false;
                    //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                }
                else {
                    //Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                    objHMEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];
                    if (objHMEffort.value.toString().indexOf(":") != -1) {
                        var chkhr = objHMEffort.value.split(":")[0];
                        var chkmin = objHMEffort.value.split(":")[1];
                        if (chkhr.length == 1) {
                            chkhr = "0" + chkhr;
                            objHMEffort.value = chkhr + ":" + chkmin;
                        }
                        if (chkmin.length == 1) {
                            chkmin = chkmin + "0";
                            objHMEffort.value = chkhr + ":" + chkmin;
                        }
                    }
                    var dataHM = JSON.stringify({ HMHours: objHMEffort.value });
                    var decTotalWorkResult = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/getDecimalHours", dataHM, false);

                    var decEfforts = decTotalWorkResult.d;

                    //End of Added By Usha Pandit on 05-Apr-2019 Purpose:: Project Work field level changes

                    for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intPhaseTaskID)[0].length - 1; intCnt++) {
                        //Commented and added by Yogesh Jalamkar on 21-SEP-2016 For functinality not working on other browsers
                        // if (document.getElementsByName("cboResource" + intPhaseTaskID)[0].options(intCnt).selected == true)
                        if (document.getElementsByName("cboResource" + intPhaseTaskID)[0].options[intCnt].selected == true)
                        //End of addition by Yogesh Jalamkar
                        {
                            intResources = intResources + 1;
                            ResourceIDList = ResourceIDList + "," + document.getElementsByName("cboResource" + intPhaseTaskID)[0].options[intCnt].value;
                            AtleastOneResource = 1;

                        }//End of If for Resource count
                    }//End of 'For-Loop' for Resource count
                    if (ResourceIDList.length > 200) {
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                       // alert(strmessage);
                          alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strmessage, 'error', 25);
                        //alert("Too Many Resources Selected");
                        frmTaskSelection.elements["cboResource" + intPhaseTaskID].focus();
                        return;
                    }//End of If for 200 validation

                    //Commented and Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                   <%-- if(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value.length > 0 && intResources >0)
                    {
                        if (disallowNegativeNumeric(frmTaskSelection.elements["txtEffort" + intPhaseTaskID],'Please enter only positive numeric value!!!',true))
                        { return false; }
						
                        /*'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452*/		
                        if(parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value) > 0)
                        {		
                            if('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True')	
                            {
                                dblEffort =  (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value) ) /( intResources  ) ;										
                            }
                            else
                            {
                                dblEffort = (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value) );
                            }//End of If for dblEffort			
                        }//End of If for parseFloat							
						
                    }//End of value.length > 0	--%>


                    var objtxtPlanEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];


                    var objoldVal = objtxtPlanEffort.value;

                    var objVal = objtxtPlanEffort.value;

                    objtxtPlanEffort.value = objtxtPlanEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objtxtPlanEffort.value);
                    objtxtPlanEffort.value = objoldVal;

                    if (isdigit == false) {
                       // alert("Please Enter only positive numeric value For Work Hours in H:M format.");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please Enter only positive numeric value For Work Hours in H:M format.", 'error', 25);
                        setFocus(objtxtPlanEffort);
                        return false;
                    }

                    if (objtxtPlanEffort.value.indexOf(':') == -1) {
                        objtxtPlanEffort.value = objVal + ':00';
                        objVal = objtxtPlanEffort.value;
                    }
                    if (objtxtPlanEffort.value.indexOf('.') >= 0) {
                        objtxtPlanEffort.value = objoldVal;
                       // alert('Please enter Work(Hrs) in H:M format.');
                            alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter Work(Hrs) in H:M format.", 'error', 25);
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        return false;

                    }
                    if (objtxtPlanEffort.value.indexOf(":") != -1) {
                        objtxtPlanEffort.value = objtxtPlanEffort.value.replace(':', '.');
                    }

                    var blnResult = disallowSpecialCharacters(objtxtPlanEffort, "Please enter Work(Hrs) in H:M format.");

                    if (blnResult == true) {
                        objtxtPlanEffort.value = objoldVal;
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        return false;
                    }

                    objtxtPlanEffort.value = objtxtPlanEffort.value.replace('.', ':');
                    //End of script for disallow special characters

                    var WorkHour = objtxtPlanEffort.value;
                    WorkHour = WorkHour.trim(); //Removing unnecessary spaces
                    var idxColon = WorkHour.indexOf(':');
                    var hrs = WorkHour.substring(0, idxColon);
                    var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                    if (mins.length == 1 && mins > 5) {
                        mins = mins + "0";
                    }
                    if (mins == "") {
                        //mins = "00";
                        objtxtPlanEffort.value = objoldVal;
                        //alert('Please enter Work(Hrs) in H:M format.');
                            alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter Work(Hrs) in H:M format.", 'error', 25);
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        return false;
                    }

                    //Validating Hours

                    if (hrs.indexOf("-") != -1) {
                       // alert('Hours should not be less than or equal to zero (0).');
                           alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Hours should not be less than or equal to zero (0).", 'error', 25);
                        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                        return false;
                    }

                    if (hrs <= 0 && mins <= 0) {
                        objtxtPlanEffort.value = objoldVal;
                      //  alert('Hours should not be less than or equal to zero (0).');
                           alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Hours should not be less than or equal to zero (0).", 'error', 25);
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        return false;
                    }

                    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                    if (mins.length > 2) {
                       // alert("Please enter minutes in two decimal and less than 60.");
                           alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter minutes in two decimal and less than 60.", 'error', 25);
                        setFocus(objtxtPlanEffort);
                        return false;
                    }
                    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                    //Validating Minutes range (0 - 59)
                    if (mins > 59 || mins < 0) {
                        objtxtPlanEffort.value = objoldVal;
                        //alert('Please enter minutes between (0-59) range');
                            alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter minutes between (0-59) range.", 'error', 25);
                        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        setFocus(objtxtPlanEffort);
                        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                        return false;
                    }

                    var MinDAENtryDisplay = "";
                    var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
        //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
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

                    if ("<%=m_RestrictByMinHours%>" == 'True') {
                        if (MinDAEntry == 0.016) {
                        }
                        else {
                            var minutes = objtxtPlanEffort.value.split(':');
                            var p = minutes[0];
                            var dec = minutes[1];
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);

                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")");
                                //alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                                  alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min", 'error', 25);
                                setFocus(objtxtPlanEffort);
                                objtxtPlanEffort.value = objtxtPlanEffort.value.split('.').join(':');
                                return false;
                            }
                        }
                    }
                    if (decEfforts.length > 0 && intResources > 0) {
                        //if (disallowNegativeNumeric(frmTaskSelection.elements["txtEffort" + intPhaseTaskID],'Please enter only positive numeric value!!!',true))
                        //{ return false; }

                        /*'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452*/
                        if (parseFloat(decEfforts) > 0) {
                            if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True') {
                                dblEffort = (parseFloat(decEfforts)) / (intResources);
                            }
                            else {
                                dblEffort = (parseFloat(decEfforts));
                            }//End of If for dblEffort			
                        }//End of If for parseFloat							

                    }//End of value.length > 0



                    //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes

                }//End of Else for value)==""
            }//End of Normal task validation (e.i. False)
            else {
                AtleastOneResource = 1;
                intResources = 1;
                if (trimString(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) == "") {
                    strmessage = "<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
                    //alert(strmessage);
                               alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmessage, 'error', 25);
                    //alert('Please enter only positive numeric value !!!');
                    document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                    return false;

                }
                else if (frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value.length > 0) {
                    //if (disallowNegativeNumeric(frmTaskSelection.elements["txtEffort" + intPhaseTaskID], 'Please enter only positive numeric value!!!', true)) { return false; }

                    if (frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value < 0)
                    {
                         alertify.set('notifier', 'position', 'top-right');
                         alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                         return false

                    }

                

                    if (parseFloat(frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value) > 0) {
                        // Added By MahendraV On 11:06 AM 6/27/2007 To check review dates for future plan deliverable
                        if (checkReviewDateForFuturePlan(objStartDate, objEndDate) == false)
                            return false;
                        var OfflineReviewValue = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID).checked;
                        var RevieweeValue = GetObjectReference("frmTaskSelection", "cboReviewee" + intPhaseTaskID).selectedIndex;
                        if (CheckRevieweeForWithoutOfflineReview(OfflineReviewValue, RevieweeValue) == false)
                            return false;
                        // End of Addition by MahendraV	
                        // Added By MahendraV On 5:49 PM 8/16/2007 for WhizibleSEM 7.0
                        // To create FTR only for single day
                        // Strat_MV_8/16/2007
                        if (CheckFTRDateForSingleDay(intPhaseTaskID) == false) { return false; }
                        // End_MV_8/16/2007

                        dblEffort = parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value);

                    }//End of If for parseFloat
                }//End of Else for .value.length > 0
            }//End of Else for Review Task validation (e.i. True)				
            //'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6452
            if (dblEffort > 0 && AtleastOneResource > 0) {
                // Make sure that the effort is in the multiple of Minimum Chargable Activity Time
                if (dblIncrementMinutes != '0.016') {//Added By Dipali V On 21st May 2020 For Issue ID 23385
                    if (Mod(dblEffort, dblIncrementMinutes) > 0) {
                        var dblvalidEffortsLow = 0;
                        var dblvalidEffortsHigh = 0;
                        dblvalidEffortsLow = (dblEffort - Mod(dblEffort, dblIncrementMinutes)) * intResources;
                        dblvalidEffortsHigh = ((dblEffort - Mod(dblEffort, dblIncrementMinutes)) + dblIncrementMinutes) * intResources;
                        strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_IN_MULITIPLE_OF_MIN_TIME"))%>";
                        strmessage = replaceSubstring(strmessage, "<MINTIME>", "" + dblIncrementMinutes);
                        strmessage = strmessage + "\n Please assign either [" + dblvalidEffortsLow + "] or [" + dblvalidEffortsHigh + "].";
                        // alert(strmessage);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmessage, 'error', 25);
                        frmTaskSelection.elements["txtEffort" + intPhaseTaskID].focus();
                        return false;
                    }//End of If for Mod(dblEffort, dblIncrementMinutes) > 0
                }
            }//End of If for dblEffort > 0 && AtleastOneResource > 0

	        /*'==================================================
			'Modified By	:	NitinVS on 19 Feb. 2005
			'
			'Description	:	to Validate Effort with Task start date and End Date
			'==================================================*/
            dtmObjStartDate = StringToDate(objStartDate, "<%=m_strDateFormat%>");
            dtmObjEndDate = StringToDate(objEndDate, "<%=m_strDateFormat%>");
            dateDiff = (Math.abs(dtmObjEndDate - dtmObjStartDate) / (1000 * 60 * 60 * 24)) + 1;
            if (dateDiff > 0 && AtleastOneResource > 0) {
                intHoursPerDay = Number(dblEffort / dateDiff);
                if (intHoursPerDay > 24) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_MAX_DAY_HOURS"))%>";
                 //   alert(strmessage);
                             alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmessage, 'error', 25);
                    document.getElementsByName("txtEffort" + intPhaseTaskID)[0].focus();
                    return false;
                }//End of If  for 24 validation
                // Added By NitinVS on 28 Feb 2005 for alerting user for Maximum working hours for Organization Unit 
                else if (intHoursPerDay > intCompanyHrsPerDay) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_OU_MAX_HRS"))%>";
                    strmessage = replaceSubstring(strmessage, "<HOURS>", "" + parseFloat(intHoursPerDay).toFixed(2));
                    strmessage = replaceSubstring(strmessage, "<OU_HOURS>", "" + intCompanyHrsPerDay);
                    strMsg = strmessage;
                    if (!confirm(strMsg)) {
                        document.getElementsByName("txtEffort" + intPhaseTaskID)[0].focus();
                        return false;
                    }//End of If for confirm
                }//End of 'If-Else' for 24 validation
                // End Addition By NitinVS on 28 Feb 2005 
            }//End of If for dateDiff > 0 && AtleastOneResource >0
	        /*'==================================================
			'Modification Ends	:	NitinVS on 19 Feb. 2005
			'==================================================*/
        }//End of 'For-Loop' for Multiple Resources
    }//End of If for Multiple Resources
    else {


        var intResources = 0;
        var ResourceIDList = '';
        var AtleastOneResource = 0;
        intPhaseTaskID = frmTaskSelection.txtPhaseTaskID.value;
        objStartDate = document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].value;
        objEndDate = document.getElementsByName("txtEndDate" + intPhaseTaskID)[0].value;


        //Added by MahendraV on 10:45 AM 6/09/2007 for SP8 Review Information:
        // Start_MV_6/09/2007

        if (frmTaskSelection.txtReviewTask.value == "False") {
            // End_MV_6/09/2007

            if (trimString(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) == "") {
                //Commented And Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
              <%--  strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
                alert(strmessage);
                //alert('Please enter only positive numeric value !!!');
                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                return false;
                /*'==================================================
                    'Modification Ends	:	NitinVS on 23 Mar.2005 IssueID 16966
                '==================================================*/--%>

               // alert("Work(Hrs) should not left blank");
                         alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Work(Hrs) should not left blank", 'error', 25);
                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                return false;
                //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
            }
            else {
                //Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                objHMEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];
                if (objHMEffort.value.toString().indexOf(":") != -1) {
                    var chkhr = objHMEffort.value.split(":")[0];
                    var chkmin = objHMEffort.value.split(":")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                    if (chkmin.length == 1) {
                        chkmin = chkmin + "0";
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                }
                var dataHM = JSON.stringify({ HMHours: objHMEffort.value });
                var decTotalWorkResult = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/getDecimalHours", dataHM, false);

                var decEfforts = decTotalWorkResult.d;

                //End of Added By Usha Pandit on 05-Apr-2019 Purpose:: Project Work field level changes

                for (intCnt = 0; intCnt <= document.getElementsByName("cboResource" + intPhaseTaskID)[0].length - 1; intCnt++) {
                    // alert(document.getElementById("cboResource" + intPhaseTaskID)[intCnt].selected);
                    if (document.getElementById("cboResource" + intPhaseTaskID)[intCnt].selected == true) {
                        intResources = intResources + 1;
                        ResourceIDList = ResourceIDList + "," + document.getElementById("cboResource" + intPhaseTaskID)[intCnt].value;
                        AtleastOneResource = 1;
                    }//End of IF for Resource Count
                }//End of 'For-Loop' for Resource Count 					
                if (ResourceIDList.length > 200) {
                    strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_TOO_MANY_RESOURCES"))%>";
                    //alert(strmessage);
                     alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strmessage, 'error', 25);
                    document.getElementById("cboResource" + intPhaseTaskID)[intCnt].focus();
                    return;
                }//End of If for 200 validation		

                 //Commented And Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
                <%--if(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value.length > 0 && intResources > 0)
                {
                    
                    if (disallowNegativeNumeric(document.getElementsByName("txtEffort" + intPhaseTaskID),'Please enter only positive numeric value!!!',true))
                   { return false; }                  
                    
                    if(parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) > 0)
                    {		
                        if('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True')	
                        {
                            dblEffort = (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) ) /(  intResources) ;
                        }
                        else
                        {
                            dblEffort = (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) );
                        }//End of If for dblEffort								
                    }//End of IF for parseFloat
                }//End of If for value.length > 0--%>


                var objtxtPlanEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];


                var objoldVal = objtxtPlanEffort.value;

                var objVal = objtxtPlanEffort.value;

                objtxtPlanEffort.value = objtxtPlanEffort.value.replace(":", ".");
                var isdigit = isNumeric(objtxtPlanEffort.value);
                objtxtPlanEffort.value = objoldVal;

                if (isdigit == false) {
                  //  alert("Please Enter only positive numeric value For Work Hours in H:M format.");
                       alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please Enter only positive numeric value For Work Hours in H:M format.', 'error', 25);
                    setFocus(objtxtPlanEffort);
                    return false;
                }

                if (objtxtPlanEffort.value.indexOf(':') == -1) {
                    objtxtPlanEffort.value = objVal + ':00';
                    objVal = objtxtPlanEffort.value;
                }
                if (objtxtPlanEffort.value.indexOf('.') >= 0) {
                    objtxtPlanEffort.value = objoldVal;
                    //alert('Please enter Work(Hrs) in H:M format.');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 25);
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;

                }
                if (objtxtPlanEffort.value.indexOf(":") != -1) {
                    objtxtPlanEffort.value = objtxtPlanEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objtxtPlanEffort, "Please enter Work(Hrs) in H:M format.");

                if (blnResult == true) {
                    objtxtPlanEffort.value = objoldVal;
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                objtxtPlanEffort.value = objtxtPlanEffort.value.replace('.', ':');
                //End of script for disallow special characters

                var WorkHour = objtxtPlanEffort.value;
                WorkHour = WorkHour.trim(); //Removing unnecessary spaces
                var idxColon = WorkHour.indexOf(':');
                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (mins == "") {
                    //mins = "00";
                    objtxtPlanEffort.value = objoldVal;
                    alert('Please enter Work(Hrs) in H:M format.');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                //Validating Hours

                if (hrs.indexOf("-") != -1) {
                  //  alert('Hours should not be less than or equal to zero (0).');
                  alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Hours should not be less than or equal to zero (0).');
                    //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                    return false;
                }

                if (hrs <= 0 && mins <= 0) {
                    objtxtPlanEffort.value = objoldVal;
                  //  alert('Hours should not be less than or equal to zero (0).');
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Hours should not be less than or equal to zero (0).');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                if (mins.length > 2) {
                 //   alert("Please enter minutes in two decimal and less than 60.");
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Please enter minutes in two decimal and less than 60.');
                    setFocus(objtxtPlanEffort);
                    return false;
                }
                // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                //Validating Minutes range (0 - 59)
                if (mins > 59 || mins < 0) {
                    objtxtPlanEffort.value = objoldVal;
                    //alert('Please enter minutes between (0-59) range');
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Please enter minutes between (0-59) range');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                var MinDAENtryDisplay = "";
                var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
        //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
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

                if ("<%=m_RestrictByMinHours%>" == 'True') {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = objtxtPlanEffort.value.split(':');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")");
                            //alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                              alertify.set('notifier', 'position', 'top-right');
                            //Commented & Added By Rutuja D. on 30 March 2020 For issueid = 23380
                            //  alertify.error('Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min');
                            alertify.error("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                            //End Commented & Added By Rutuja D. on 30 March 2020 For issueid = 23380

                            setFocus(objtxtPlanEffort);
                            objtxtPlanEffort.value = objtxtPlanEffort.value.split('.').join(':');
                            return false;
                        }
                    }
                }
                if (decEfforts.length > 0 && intResources > 0) {
                    // if (disallowNegativeNumeric(document.getElementsByName("txtEffort" + intPhaseTaskID),'Please enter only positive numeric value!!!',true))
                    //{ return false; }

                    if (parseFloat(decEfforts) > 0) {
                        if ('<%= m_strDistributeWorkInAT_CorporateFlag %>' == 'True') {
                            dblEffort = (parseFloat(decEfforts)) / (intResources);
                        }
                        else {
                            dblEffort = (parseFloat(decEfforts));
                        }//End of If for dblEffort								
                    }//End of IF for parseFloat
                }//End of If for value.length > 0

                //End of Added By Usha Pandit on 05-Apr-2019 Purpose::Project Work field level changes
            }// End of Else for .value)==""
        }//End of If for Normal Review Task validation (e.i. False)
        else {
            AtleastOneResource = 1;
            intResources = 1;
            //Added by MahendraV on 10:45 AM 6/09/2007 for SP8 Review Information:
            // Start_MV_6/09/2007
            if (trimString(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) == "") {
                //Commented And Added By Usha Pandit on 27-Mar-2020 Purpose::Project Work field level changes
               <%-- strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_ONLY_POSITIVE_NUMERIC_VALUE"))%>";
               // alert(strmessage);
                   alertify.set('notifier', 'position', 'top-right');
                alertify.notify(strmessage, 'error', 25);
                //alert('Please enter only positive numeric value !!!');
                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                return false;--%>

                 alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Work(Hrs) should not left blank", 'error', 25);
                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].select();
                return false;
                //End of Added By Usha Pandit on 27-Mar-2020 Purpose::Project Work field level changes

            }
            //else if((GetObjectReference("frmTaskSelection","txtEffort" + intPhaseTaskID).value).length > 0)
            else if ((document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value).length > 0) {
                //if (disallowNegativeNumeric(GetObjectReference("frmTaskSelection","txtEffort" + intPhaseTaskID),'Please enter only positive numeric value!!!',true))
                //if (disallowNegativeNumeric(GetObjectReference("frmTaskSelection", "txtEffort" + intPhaseTaskID), 'Please enter only positive numeric value!!!', true)) { return false; }

                //Commented And Added By Usha Pandit on 27-Mar-2020 Purpose::Project Work field level changes
                //if (frmTaskSelection.elements["txtEffort" + intPhaseTaskID].value < 0)
                 //   {
                 //        alertify.set('notifier', 'position', 'top-right');
                 //        alertify.notify("Please enter only positive numeric value!!", 'error', 25);
                 //        return false

                 //   }
                
                objHMEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];
                if (objHMEffort.value.toString().indexOf(":") != -1) {
                    var chkhr = objHMEffort.value.split(":")[0];
                    var chkmin = objHMEffort.value.split(":")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                    if (chkmin.length == 1) {
                        chkmin = chkmin + "0";
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                }
                var dataHM = JSON.stringify({ HMHours: objHMEffort.value });
                var decTotalWorkResult = AJAXCallWithResult("PM_ProjecPlanDeliverable.aspx/getDecimalHours", dataHM, false);

                var decEfforts = decTotalWorkResult.d;

                var objtxtPlanEffort = document.getElementsByName("txtEffort" + intPhaseTaskID)[0];


                var objoldVal = objtxtPlanEffort.value;

                var objVal = objtxtPlanEffort.value;

                objtxtPlanEffort.value = objtxtPlanEffort.value.replace(":", ".");
                var isdigit = isNumeric(objtxtPlanEffort.value);
                objtxtPlanEffort.value = objoldVal;

                if (isdigit == false) {
                  //  alert("Please Enter only positive numeric value For Work Hours in H:M format.");
                       alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please Enter only positive numeric value For Work Hours in H:M format.', 'error', 25);
                    setFocus(objtxtPlanEffort);
                    return false;
                }

                if (objtxtPlanEffort.value.indexOf(':') == -1) {
                    objtxtPlanEffort.value = objVal + ':00';
                    objVal = objtxtPlanEffort.value;
                }
                if (objtxtPlanEffort.value.indexOf('.') >= 0) {
                    objtxtPlanEffort.value = objoldVal;
                    //alert('Please enter Work(Hrs) in H:M format.');
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 25);
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;

                }
                if (objtxtPlanEffort.value.indexOf(":") != -1) {
                    objtxtPlanEffort.value = objtxtPlanEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objtxtPlanEffort, "Please enter Work(Hrs) in H:M format.");

                if (blnResult == true) {
                    objtxtPlanEffort.value = objoldVal;
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                objtxtPlanEffort.value = objtxtPlanEffort.value.replace('.', ':');
                //End of script for disallow special characters

                var WorkHour = objtxtPlanEffort.value;
                WorkHour = WorkHour.trim(); //Removing unnecessary spaces
                var idxColon = WorkHour.indexOf(':');
                var hrs = WorkHour.substring(0, idxColon);
                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (mins == "") {
                    //mins = "00";
                    objtxtPlanEffort.value = objoldVal;
                    alert('Please enter Work(Hrs) in H:M format.');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                //Validating Hours

                if (hrs.indexOf("-") != -1) {
                  //  alert('Hours should not be less than or equal to zero (0).');
                  alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Hours should not be less than or equal to zero (0).');
                    //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                    return false;
                }

                if (hrs <= 0 && mins <= 0) {
                    objtxtPlanEffort.value = objoldVal;
                  //  alert('Hours should not be less than or equal to zero (0).');
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Hours should not be less than or equal to zero (0).');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                if (mins.length > 2) {
                 //   alert("Please enter minutes in two decimal and less than 60.");
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Please enter minutes in two decimal and less than 60.');
                    setFocus(objtxtPlanEffort);
                    return false;
                }
                // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                //Validating Minutes range (0 - 59)
                if (mins > 59 || mins < 0) {
                    objtxtPlanEffort.value = objoldVal;
                    //alert('Please enter minutes between (0-59) range');
                       alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Please enter minutes between (0-59) range');
                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    setFocus(objtxtPlanEffort);
                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
                    return false;
                }

                var MinDAENtryDisplay = "";
                var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
        //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
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

                if ("<%=m_RestrictByMinHours%>" == 'True') {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = objtxtPlanEffort.value.split(':');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")");
                            //alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                              alertify.set('notifier', 'position', 'top-right');
                   alertify.error('Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min');
                            setFocus(objtxtPlanEffort);
                            objtxtPlanEffort.value = objtxtPlanEffort.value.split('.').join(':');
                            return false;
                        }
                    }
                }

                //End of Added By Usha Pandit on 27-Mar-2020 Purpose:: Project Work field level changes


                if (parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value) > 0) {
                    // Added By MahendraV On 11:06 AM 6/27/2007 To check review dates for future plan deliverable
                    if (checkReviewDateForFuturePlan(objStartDate, objEndDate) == false)
                        return false;
                    var OfflineReviewValue = GetObjectReference("frmTaskSelection", "IsOffline" + intPhaseTaskID).checked;
                    var RevieweeValue = GetObjectReference("frmTaskSelection", "cboReviewee" + intPhaseTaskID).selectedIndex;
                    if (CheckRevieweeForWithoutOfflineReview(OfflineReviewValue, RevieweeValue) == false)
                        return false;
                    // End of Addition by MahendraV
                    // Added By MahendraV On 5:49 PM 8/16/2007 for WhizibleSEM 7.0
                    // To create FTR only for single day
                    // Strat_MV_8/16/2007
                    if (CheckFTRDateForSingleDay(intPhaseTaskID) == false) { return false; }
                    // End_MV_8/16/2007
                    dblEffort = parseFloat(document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value);

                }//End of If for parseFloat

            }//End of If for value).length > 0
        }//End of Else for Review Task validation (e.i. True)
        // End_MV_6/09/2007
        //Added by MahendraV on 3:48 PM 6/27/2007 for Checking positive numeric value:
        // IssueID(14034) : Plan Deliverables : Project > WBS > Deliverables : Wrong alert get displayed
        //Commented By Usha Pandit on 27-Mar-2020 Purpose:: Project Work field level changes
        <%--if (dblEffort > 0 && AtleastOneResource > 0) {
            if (Mod(dblEffort, dblIncrementMinutes) > 0) {
                var dblvalidEffortsLow = 0;
                var dblvalidEffortsHigh = 0;
                dblvalidEffortsLow = (dblEffort - Mod(dblEffort, dblIncrementMinutes)) * intResources;
                dblvalidEffortsHigh = ((dblEffort - Mod(dblEffort, dblIncrementMinutes)) + dblIncrementMinutes) * intResources;
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_EFFORT_IN_MULITIPLE_OF_MIN_TIME"))%>";
                strmessage = replaceSubstring(strmessage, "<MINTIME>", "" + dblIncrementMinutes);
                strmessage = strmessage + "\n Please assign either [" + dblvalidEffortsLow + "] or [" + dblvalidEffortsHigh + "].";
                //alert(strmessage);
                   alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
                frmTaskSelection.elements["txtEffort" + intPhaseTaskID].focus();
                return false;
            }//End of If for Mod(dblEffort, dblIncrementMinutes) > 0
        }// End of If for dblEffort > 0 && AtleastOneResource > 0--%>
        //End Of Commented By Usha Pandit on 27-Mar-2020 Purpose:: Project Work field level changes

        dtmObjStartDate = StringToDate(objStartDate, "<%=m_strDateFormat%>");
        dtmObjEndDate = StringToDate(objEndDate, "<%=m_strDateFormat%>");
        dateDiff = (Math.abs(dtmObjEndDate - dtmObjStartDate) / (1000 * 60 * 60 * 24)) + 1;
        if (dateDiff > 0 && AtleastOneResource > 0) {
            intHoursPerDay = Number(dblEffort / dateDiff);
            if (intHoursPerDay > 24) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_MAX_DAY_HOURS"))%>";
               // alert(strmessage);
                   alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strmessage, 'error', 25);
                document.getElementsByName("txtEffort" + intPhaseTaskID)[0].focus();
                return false;
            }//End of If for 24 validation
            else if (intHoursPerDay > intCompanyHrsPerDay) {
                strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_OU_MAX_HRS"))%>";
                strmessage = replaceSubstring(strmessage, "<HOURS>", "" + parseFloat(intHoursPerDay).toFixed(2));
                strmessage = replaceSubstring(strmessage, "<OU_HOURS>", "" + intCompanyHrsPerDay);
                strMsg = strmessage;

                if (!confirm(strMsg)) {
                    document.getElementsByName("txtEffort" + intPhaseTaskID)[0].focus();
                    return false;
                }// End of If for confirm
            }//End of If for intHoursPerDay > intCompanyHrsPerDay
        }// End of If for dateDiff > 0 && AtleastOneResource > 0

	    /*'==================================================
		'Modification Ends	:	NitinVS on 19 Feb. 2005
		'==================================================*/
	    //else
	    //{
	    //strmessage = "<%=Server.HTMLDecode(MyBase.GetResourceString("MSG_INVALID_EFFORT"))%>";
                //alert(strmessage)
                //alert("Please Enter Valid Efforts");
                //}

            }// End of If for single Task validation
        } // End of the Function	
        // End Addition By NitinVS on 16 Feb 2005 

        // End of the revision by MahendraV On 8/13/2007 for fucntion validateTaskLevelPlanning()

        //Added by MahendraV on 5:50 PM 6/7/2007 Review validation in plan deliverable
        // Start_MV_6/7/2007

        function FTR_Check(intPhaseTaskID) {
            var objFTR = GetObjectReference('frmTaskSelection', 'IsFTR' + intPhaseTaskID);
            var objOffline = GetObjectReference('frmTaskSelection', 'IsOffline' + intPhaseTaskID);
            var objcboReviewee = GetObjectReference('frmTaskSelection', 'cboReviewee' + intPhaseTaskID);
            if (objFTR.checked == true) {
                objOffline.checked = false;
                objOffline.disabled = true;
            }
            else {
                objOffline.disabled = false;
            }
        }

        function Offline_Check(intPhaseTaskID) {
            var objFTR = GetObjectReference('frmTaskSelection', 'IsFTR' + intPhaseTaskID);
            var objOffline = GetObjectReference('frmTaskSelection', 'IsOffline' + intPhaseTaskID);
            var objcboReviewee = GetObjectReference('frmTaskSelection', 'cboReviewee' + intPhaseTaskID);
            if (objOffline.checked == true) {
                objFTR.checked = false;
                objFTR.disabled = true;
                objcboReviewee.disabled = true;
            }
            else {
                objFTR.disabled = false;
                objcboReviewee.disabled = false;
            }
        }
        // End_MV_6/7/2007

        /************************ Added By VijayD 25 May 2009********************************
                Purpose: To validate Task assignment for baseline
         ************************ ***********************************************************/
        function ValidateControls(intRecordCount) {
            var intCount, intPhaseTaskID;
            var objStartDate, objEndDate;
            var intDeliverableID;
            var strTaskStartDate, strTaskEndDate;
            var strURL;
            var fmt = 'MMM dd,yyyy';

            intDeliverableID =<%=m_intDeliverableID%>;

            if (intRecordCount > 1 && frmTaskSelection.txtPhaseTaskID != null) {
                for (intCount = 0; intCount <= frmTaskSelection.txtPhaseTaskID.length - 1; intCount++) {
                    // intPhaseTaskID	=   frmTaskSelection.txtPhaseTaskID(intCount).value;
                    intPhaseTaskID = frmTaskSelection.txtPhaseTaskID[intCount].value;
                    objEfforts = document.getElementsByName("txtEffort" + intPhaseTaskID)[0].value;
                    objStartDate = document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].value;
                    objEndDate = document.getElementsByName("txtEndDate" + intPhaseTaskID)[0].value;

                    objModuleID = document.getElementsByName("txtModuleID" + intPhaseTaskID)[0].value;
                    objSubProjectID = document.getElementsByName("txtSubProjectID" + intPhaseTaskID)[0].value;
                    objMilestoneID = document.getElementsByName("txtMilestoneID" + intPhaseTaskID)[0].value;

                    if (objStartDate != null && objEndDate != null) {
                        //cOMMENTED BY nILESH G ON 12/2/2016 FOR JAVASCRIPT
                        //strTaskStartDate                =   GetDateInFormat(objStartDate.value, fmt);		       
                        //strTaskEndDate                  =   GetDateInFormat(objEndDate.value, fmt);
                        strTaskStartDate = GetDateInFormat(objStartDate, fmt);
                        strTaskEndDate = GetDateInFormat(objEndDate, fmt);
                        if (frmTaskSelection.elements["cboResource" + intPhaseTaskID] != null) {
                            for (intCnt = 0; intCnt <= frmTaskSelection.elements["cboResource" + intPhaseTaskID].length - 1; intCnt++) {
                                if (document.getElementsByName("cboResource" + intPhaseTaskID)[0].options[intCnt].selected == true) {
                                    strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=0&StartDate=" + encodeURIComponent(strTaskStartDate) + "&EndDate=" + encodeURIComponent(strTaskEndDate) + "&DeliverableID=" + String(intDeliverableID) + "&ModuleID=" + objModuleID.value + "&SubProjectID=" + objSubProjectID.value + "&MilestoneID=" + objMilestoneID.value + "&Work=" + String(objEfforts.value);
                                    ValidateTask_Baseline(strUrl);

                                    if (strResult != null && strResult != "") {
                                       // alert(strResult);
                                            alertify.set('notifier', 'position', 'top-right');
                                             alertify.notify(strResult, 'error', 25);
                                        document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].select();
                                        document.getElementsByName("txtStartDate" + intPhaseTaskID)[0].focus();
                                        return false;
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return true;
        }
        var brw = isIE();
        function ValidateTask_Baseline(url) {
            // TO SEE IF WE ARE RUNNING IN IE 
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            if (brw == "IE") {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
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
                    if (brw == "FF")
                        xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                }

            }
            return strResult;
        }

        function TaskValidation_state_change() {
            if (g_objXHttp.readyState == 4) {

                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {

                    //if (window.ActiveXObject)
                    if (brw == "IE") {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);

                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        if (brw == "FF")
                            xmlDoc.load(g_objXHttp.responseXML);
                    }

                    //Save the Result in a Global variable
                    strResult = g_objXHttp.responseText;

                }
            }
        }
        //************************End Addition By VijayD 25 May 2009**************************//

        // var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
        //    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        //var uDatepicker = $.datepicker._updateDatepicker;
        //$.datepicker._updateDatepicker = function () {
        //    var ret = uDatepicker.apply(this, arguments);
        //    var $sel = this.dpDiv.find('select');
        //    $sel.find('option').each(function (i) {
        //        $(this).text(months[i]);
        //    });
        //    return ret;
        //};

      
        function showdatepicker(ControlID, DateFormate) {
            var ControlID = ControlID;
            //  alert(DateFormate);
            if (DateFormate == 'dd-mm-yyyy') {
                DateFormate = 'dd-mm-yy';
            }
            else if (DateFormate = 'mm-dd-yyyy')
            {
                   DateFormate = 'mm-dd-yy';
            }
            // $("#" + ControlID).val("");
            $("#" + ControlID).datepicker({
                autoclose: true,
                changeMonth: true,
              
               // dateFormat: DateFormate
                dateFormat: DateFormate
            });

        }



    </script>


 



</body>
</html>
