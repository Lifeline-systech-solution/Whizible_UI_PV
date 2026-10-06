<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectBreakUp_MasterSelection.aspx.vb" Inherits="PbNIT.LinkMetrics" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<head>
    <title>Project BreakUp Metric Details</title>
    <style>
        A.clsSelected {
            COLOR: #000 !IMPORTANT;
        }

        TR.clsTR
        {
            border-right: thin;
            padding-right: 1pt;
            border-top: thin;
            padding-left: 1pt;
            padding-bottom: 1pt;
            border-left: thin;
            padding-top: 1pt;
            border-bottom: thin;
            font-weight: normal;
            font-size: 11px;
            color: black;
            font-family: Verdana, Arial;
            height: 22px;
            BACKGROUND-COLOR: #f5deb3;
        }

        TR.clsLinkPageHeaderInnerTR
        {
            font-weight: bolder;
            font-size: 10px;
            margin-bottom: 2px;
            padding-bottom: 2px;
            color: white;
            font-family: Verdana, Arial;
            background-color: #4E7DD1;
        }

        TD.clsTRSectionHeaderTD
        {
            BORDER-RIGHT: thin;
            PADDING-RIGHT: 2pt;
            BORDER-TOP: thin;
            PADDING-LEFT: 2pt;
            FONT-WEIGHT: bolder;
            FONT-SIZE: 8pt;
            PADDING-BOTTOM: 2pt;
            MARGIN: 2pt;
            BORDER-LEFT: thin;
            COLOR: black;
            PADDING-TOP: 2pt;
            BORDER-BOTTOM: thin;
            FONT-FAMILY: Verdana, Arial;
            BACKGROUND-COLOR: #dcc1be;
        }
        a.clsNavTab {
            font-family: "Helvetica";
            font-size: 11px;
            color: #FFF;
            font-weight: bold !important;
            text-decoration: none;
            position: relative !important;
             display: block; 
            padding-left: 5px;
            padding-right: 5px; 
          

        }
/*Added By Chakshuta H on 20th-Nov-2015 Purpose::QA issue fixing*/
 #processselected {
            font-family: "Helvetica";
            font-size: 10px !important;
            color: #FFF;
            font-weight: bold !important;
            text-decoration: none;
            position: relative !important;
            display: block; 
            padding-right: 5px; 
            padding-left: 0px;
            bottom: 10px;

        }
/*End Of Added By Chakshuta H on 20th-Nov-2015 Purpose::QA issue fixing*/
        .footerMenuTable {
            position: relative !important;;
            bottom: 0px;
            right: 2px;
            display: table !important;
            margin-bottom: 9px;
        }
        clsGridTable footerMenuTable{
        overflow: auto;
        position: relative;
        }
        .clsTRNavLinks .clsLinkPageHeaderInner
        {
            font-size:15px;
            padding:2px
        }
    </style>
    <script language='javascript' src='../General/CommonFunctions.js'></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
    <%CommonFunctions.General.PlotPageHeadTag(PAGE_CAPTION)%>

    <%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
    <%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
    <script src="../../responsive/responsive.js"></script>

    <style>
        .clsTable .clsTRMenu td:first-child
        {
            width: 35%;
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
<body ms_positioning="GridLayout" class="clsBody" onresize='window_onresize()' onload='window_onload()'>

    <form id="frmLinkMetrics" name="frmLinkMetrics" method="post" runat="server">

        <%BuildPage()%>
    </form>

    <script>
        var ObjForm = GetFormReference('frmLinkMetrics');
        var objDivMain = GetObjectReference('frmLinkMetrics', 'DivList');

        function window_onload() {
            //debugger;
            var intDivHeight;
            var intDivHeightRisk;
            var intScriptNo;
            document.body.style.visibility = 'visible';
            if (objDivMain != null) {
                //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
                if (WhichBrowser() == 'IE') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
                }
                else if (WhichBrowser() == 'CR') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
                }
                else if (WhichBrowser() == 'FF') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 890;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597

                }
                else {
                    intDivHeight = (document.body.offsetHeight - objDivMain.offsetTop - 100) + 895;
                }
                if (intDivHeight < 100)
                    intDivHeight = 100;
                objDivMain.style.height = intDivHeight + 'px';
            }
            //setting scroll height----------------
            var ObjTblList1 = GetObjectReference('frmLinkMetrics', 'DivList');
            var ObjhdnDivScrollHeight = GetObjectReference('frmLinkMetrics', 'hdnDivScrollHeight');
            if (ObjTblList1 != null && ObjhdnDivScrollHeight != null) {
                ObjTblList1.scrollTop = ObjhdnDivScrollHeight.value;
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
        function window_onresize() {
            if (objDivMain != null) {
                var intDivHeight;
                var intDivHeightRisk;
                //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
                if (WhichBrowser() == 'IE') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
                }
                else if (WhichBrowser() == 'CR') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
                }
                else if (WhichBrowser() == 'FF') {
                    //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 890;
                    intDivHeight = (window.innerHeight - objDivMain.offsetTop - 6); //Added By Vaijat K ON 03/11/2015 Issue ID-2597

                }
                else {
                    intDivHeight = (document.body.offsetHeight - objDivMain.offsetTop - 100) + 895;
                }
                if (intDivHeight < 100)
                    intDivHeight = 100;
                objDivMain.style.height = intDivHeight + 'px';
            }

        }
        function Sort_OnClick(sortby, sortorder) {

            //if (sortby != "MetricCount")
            //{
            if (sortby == "CustomerName")
                ObjForm.action = "LinkMetrics.aspx?Show=Customer&MasterTagID=8070&FromWhere=SM&sortby=" + sortby + "&sortorder=" + sortorder;
            else if (sortby == "ProjectType")
                ObjForm.action = "LinkMetrics.aspx?Show=Practice&MasterTagID=8070&FromWhere=SM&sortby=" + sortby + "&sortorder=" + sortorder;
            else {
                if (sortorder == "ASC") {
                    if (ObjForm.action.indexOf("sortorder") > 0)
                        ObjForm.action = ObjForm.action.replace("DESC", "ASC")
                    else
                        ObjForm.action = ObjForm.action + "&sortby=" + sortby + "&sortorder=" + sortorder;
                }
                if (sortorder == "DESC") {
                    if (ObjForm.action.indexOf("sortorder") > 0)
                        ObjForm.action = ObjForm.action.replace("ASC", "DESC");
                    else
                        ObjForm.action = ObjForm.action + "&sortby=" + sortby + "&sortorder=" + sortorder;
                }
            }
            ObjForm.submit();
            //}
        }

        function Customer_OnClick(strProjectID) {

            //saving scroll height----------------
            var ObjTblList1 = GetObjectReference('frmLinkMetrics', 'DivList');
            var ObjhdnDivScrollHeight = GetObjectReference('frmLinkMetrics', 'hdnDivScrollHeight');
            //alert(ObjhdnDivScrollHeight.value)
            if (ObjTblList1 != null && ObjhdnDivScrollHeight != null) {
                ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
            }
            //--------------------------------------
            var ObjForm = GetFormReference('frmLinkMetrics');
            //var ProjectType= GetObjectReference('frmLinkMetrics','cboPT');
            //ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Milestone&PType="+ProjectType.value;
            ObjForm.action = "LinkMetrics.aspx?Show=Customer&MasterTagID=8070&FromWhere=SM";
            ObjForm.submit()
        }

        function Practice_OnClick(strProjectID) {

            //saving scroll height----------------
            var ObjTblList1 = GetObjectReference('frmLinkMetrics', 'DivList');
            var ObjhdnDivScrollHeight = GetObjectReference('frmLinkMetrics', 'hdnDivScrollHeight');
            //alert(ObjhdnDivScrollHeight.value)
            if (ObjTblList1 != null && ObjhdnDivScrollHeight != null) {
                ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
            }
            //--------------------------------------
            var ObjForm = GetFormReference('frmLinkMetrics');
            //var ProjectType= GetObjectReference('frmLinkMetrics','cboPT');
            //ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Milestone&PType="+ProjectType.value;
            ObjForm.action = "LinkMetrics.aspx?Show=Practice&MasterTagID=8070&FromWhere=SM";
            ObjForm.submit()
        }

        function LinkMetric_OnClick(UniqueID, ModeID) {
            window.open("../METRICS/LinkMetricsToCustomer_CommonList.aspx?MasterTagID=8071&FromWhere=SM&UniqueID=" + UniqueID + "&ModeID=" + ModeID, "_new", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=800,height=600")
        }

        function Page_Onclick(strPageNo) {
            var URL;
            switch ("<%=m_strShow.ToUpper()%>") {
                case "CUSTOMER":
                    URL = "LinkMetrics.aspx?Show=Customer&PageNumber=" + URIEncode(strPageNo);
                    break;
                case "PRACTICE":
                    URL = "LinkMetrics.aspx?Show=Practice&PageNumber=" + URIEncode(strPageNo);
                    break;

                default:

            }

            ObjForm.action = URL
            ObjForm.submit();
        }


    </script>
</body>
</html>
