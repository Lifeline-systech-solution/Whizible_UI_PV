<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MetricDashBoard.aspx.vb" Inherits="PbNIT.MetricDashBoard" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>

<html>

<%-- ADDED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>
<% CommonFunctions.General.PlotPageHeadTag("Customer DashBoard")%>
<%-- END ADDED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>
<%MyBase.InitializeResources("AppResourcePPM.MB_Plot_MetricGraphs_For_Projects", "AppResourcePPM")%>


<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*added by bharat on 3rd-Dec-2015*/
    .container_header_PPDB
    {
        font-size:12px !important;
    }   
</style>

<script type="text/javascript">
    $(document).ready(function () {
         //Added By Usha Pandit On 20.05.2020 For getting select project/Session project 
        if ($('#cboProjectList').val() == -1) {
            var sessionProjectId = '<%=Session("intProjectID")%>';
            if (sessionProjectId != 0 && sessionProjectId != "" && sessionProjectId != null && sessionProjectId != undefined) {
                $('#cboProjectList > option').each(function () {
                    curval = $(this).val();
                    curval = curval.toString().trim();
                    if (curval == sessionProjectId) {
                        $(this).attr("selected", true);
                    }
                });
            }
        }
        //End Of Added By Usha Pandit On 20.05.2020 For getting select project/Session project
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

<body ms_positioning="GridLayout" onload="window_onload()">
    <form id="frmMetricDashBoardDB" method="post" runat="server" title="Dashboard">
        <% DrawPage()%>
        <%--Commented and Added by Dhanashri S on 18 Dec 2015 For IssueID:2727--%>
      <%--  <iframe id="ifMetricDashBoard" src="../MetricDashBoard/MB_Plot_MetricGraphs_For_Projects.aspx?ProjectIDfromDB= <%=m_ProjectID%> &FROM=MDB" width="100%" height="499px;"
            marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>--%>
           <iframe id="ifMetricDashBoard" src="../MetricDashBoard/MB_Plot_MetricGraphs_For_Projects.aspx?ProjectIDfromDB=<%=m_ProjectID%>&FROM=MDB" width="100%" height="800px;"
            marginwidth="0" marginheight="0" hspace="0" vspace="0" frameborder="0" scrolling="no"></iframe>
        <%--End of Comment and Addition by Dhanashri S on 18 Dec 2015--%>
        <div id="PopUpDiv" class='ContextMenu' style="display: none; border-left: black 2px solid; border-bottom: black 1px solid; border-right: black 1px solid; border-top: black 1px solid; text-align: center; vertical-align: middle"></div>
        <div id="fillDiv" style="filter: alpha(opacity=60); background-color: #d1d1d1; DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%"></div>

    </form>
</body>

<script language="JavaScript">
    //new
    document.getElementById("PopUpDiv").style.display = "none";
    var strMode = '<%=m_strMode%>';
	        var objfrm = GetFormReference('frmMetricDashBoardDB');
	        if (strMode != 'PRINT') {
	            objrapper = GetObjectReference('frmMetricDashBoardDB', 'rapper');
	            objdivlist = GetObjectReference('frmMetricDashBoardDB', 'DivList');
	            objifMetricDashBoard = GetObjectReference('frmMetricDashBoardDB', 'ifMetricDashBoard');
	        }
	        //end new		
	        function Project_MetricLink_OnClick()//BringData
            {
	            var x_selectedIndex = document.getElementById("cboProjectList").selectedIndex;
	            var y_options = document.getElementById("cboProjectList").options;
	            intProjectID = y_options[x_selectedIndex].value;

	            var strProjectName = y_options[x_selectedIndex].text;
	            if (intProjectID == -1) {
	                strProjectName = "";
	            }
	            if (intProjectID != -1) {
	                window.location.href = "../MetricDashBoard/MetricDashBoard.aspx?ProjectIDfromDB=" + intProjectID + "&FROM=MDB";
	            }
	        }



	        function window_onload() {
	            //debugger;
	            var intDivHeight;
	            var intDivHeightRisk;
	            var msg;
	            //				if ((strMode!='PRINT')&& objdivlist != null)//
	            //				{
	            //					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
	            //					if (intDivHeight < 100)	intDivHeight = 70;
	            //					objdivlist.style.height = intDivHeight-10;	
	            //				}
	            ////                if ((strMode!='PRINT')&& objifMetricDashBoard != null)//
	            ////				{
	            ////					intDivHeight = document.body.offsetHeight - objifMetricDashBoard.offsetTop - 20;
	            ////					if (intDivHeight < 100)	intDivHeight = 70;
	            ////					objifMetricDashBoard.style.height = intDivHeight+200;	
	            ////				}
	        }




</script>


</html>
