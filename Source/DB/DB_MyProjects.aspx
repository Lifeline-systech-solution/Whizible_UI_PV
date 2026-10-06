<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_MyProjects.aspx.vb" Inherits="PbNIT.DB_MyProjects" %>
<%@ OutputCache Duration="60" VaryByParam="None" %>

<!DOCTYPE HTML>
<HTML>

    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>

<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*@media only screen and (max-width:991px) and (min-width:768px)*/
.footerMenuTable {
    position: relative;
    bottom: 0px;
    /*visibility: hidden;*/
    visibility: visible;
}
#PageDiv{
    overflow-y:auto!important;
}

/*added style by pradip pradhan on 24-03-2020*/
#frmMyProjects .footerMenuTable {visibility: visible;}
/*End added style by pradip pradhan on 24-03-2020*/
</style>

<script type="text/javascript">
    $(document).ready(function () {
	 $('#PageDiv').css("height",window.innerHeight-40+'px');
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

	<body MS_POSITIONING="GridLayout" class='clsBody'  onload='CL_window_onload()' onresize='CL_window_onresize()' >
		<form id="frmMyProjects" method="post" runat="server">
		<%PageInit%>
		</form>
		<script>
		/*******************************************************************************************************/
		/************************************|	JAVASCRIPT	  |*************************************************/
		/*******************************************************************************************************/
		var objfrm;
		var objdivlist;
		objfrm = GetFormReference('frmMyProjects')
		objdivlist=GetObjectReference('frmMyProjects','PageDiv');

		window.status='';//window resize for Common list
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function CL_window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 77;
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	;
		}
		//window onload for Common list
		function CL_window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var lc;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 77;
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	;
		}
		//Function for Sorting of columns
		function Sort_OnClick(strSortBy,strSortOrder)
		{

		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			frmMyProjects.action ="DB_MyProjects.aspx?Action=SORT&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder;
			frmMyProjects.submit();
		}
		//Function to show Dashboard
		function ShowDB(intProjectID)
		{
		  window.open ("../DB/DB_ProjectDashboard.aspx?ProjectID=" + intProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600" );
		}
		//Function to show 'Project Health Sheet'
		function ShowHealthSheet(intProjectID)
		{
		   var dt=new Date();
		   var strDate=dt.getDate();
		   //Modified by MrugajaB on 6th Jan 2006
		   //Purpose: getMonth function returns a value between 0 to 11 hence for Jan it was returning '0' and page was getting crashed
		   //To avoid this , added 1
		   var strMonth=dt.getMonth() + 1 ;
		   //End Addition
		   var strYear=dt.getFullYear();
		   var strToday=(strMonth) + '/' + (strDate) + '/' + (strYear);
		   //Modified By VarunA on 7-July-2008 IssueID-21539
		   //Purpose : To have the frequency dependy on corporate level.
		   //window.open ("../PTS/PM_SQERT.aspx?Mode=ViewReport&cboCategoryID=&cboProgramID=&cboProjectID=" + intProjectID + "&cboBUID=&cboOUID=&txtReportingDate=" + strToday + "&optReportingPeriod=0", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=650");
		   window.open ("../PTS/PM_SQERT.aspx?Mode=ViewReport&cboCategoryID=&cboProgramID=&cboProjectID=" + intProjectID + "&cboBUID=&cboOUID=&txtReportingDate=" + strToday + "&optReportingPeriod=<%=intFrequencyId%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=650");
		   //End By VarunA on 7-July-2008 IssueID-21539
		}
		
		// SearchKey: JP_31Jul2006
		// JijeshP Modification START for (PM DashBoard Enhanced View Enhancements): Show ETC Approvals.
		function ShowETCApprovals(intProjectID)
		{
			window.open("../PM/PM_ETCApproval.aspx?FromWhere=DB&MasterTagID=417&ProjectID="+intProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600" );
		}
		// JijeshP Modification END
		/*******************************************************************************************************/
		/************								JAVASCRIPT END									************/
		/*******************************************************************************************************/



             //Added By Reshma Chavan on 10th Nov 2020 For scroll to see All projects
    //dynamically set height
        function resizeSection(tag) {
            var frmheight = $(window).height();
            $('#frmMyProjects').css({ 'height': frmheight - 30, "overflow-y": "auto" });
           
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
    });
     //End of //Added By Reshma Chavan on 10th Nov 2020 For scroll to see All projects
		</script>
				
	</body>
</HTML>
