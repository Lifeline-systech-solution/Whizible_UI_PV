<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_Links.aspx.vb" Inherits="Whiz.CDB_Links" %>
<!DOCTYPE HTML>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Links")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    #DivList
    {
    overflow:auto;
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


	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmLinks" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        If Not CommonFunctions.General.CheckIsNothingOrEmpty(Request("Mode")) Then
            Response.Write("var blnShowNavigationAlert = true;")
            Response.Write("window.onbeforeunload = confirmExit;")
            Response.Write("var strContainerDivs = 'DivList';")
            Response.Write("blnNavigate = null;")
        End If
    End If    
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objchkDelete;
	var objtxtLinkName;
	var objtxtLinkURL;
		
	objform = GetFormReference('frmLinks');
	objdivlist = GetObjectReference('frmLinks','DivList');
	objchkDelete = GetObjectReference('frmLinks','chkDelete',true);
	objtxtLinkName = GetObjectReference('frmLinks','txtLinkName');
	objtxtLinkURL = GetObjectReference('frmLinks', 'txtLinkURL');
   
	document.body.onload = window_load(); //added by Shamkant S 0n 10 Dec 2015
	function validate()
	{
		if (disallowBlank(objtxtLinkName,"Please provide the link name")) return false;
		if (disallowBlank(objtxtLinkURL,"Please provide the link URL")) return false;
		//Added By Shrikant, IssueID 20608
		if (disallowSpecialCharacters(objtxtLinkURL,"Characters [*+\"><|,\\\\] are not allowed within the 'Link URL'.",true,"[*+\"><|,\\\\]"))
		 {
			objtxtLinkURL.focus();
			return;
		}
		//End Addition By Shrikant, IssueID 20608
		return true;
	}
    //added by Shamkant S 0n 10 Dec 2015
	function window_load()
	{
        
	    var intDivHeight;
	    if (objdivlist) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;

	        if (navigator.appName == 'Netscape') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
	        }

	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';
	        //alert("");
	    }
	}
	function window_onresize() {
	 
	    var intDivHeight;
	    if (objdivlist) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';
	    }
	}
    //Commented ended by Shamkant S on 10 Dec 2015
	function Sort_OnClick(sortby,sortorder)
	{
		window.location.href = "CDB_Links.aspx?DashboardID=<%=m_lngDashboardID%>&sortby=" + sortby + "&sortorder=" + sortorder+ "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
	}	
	
	function LinkName_OnClick(linkid)
	{
		window.location.href = "CDB_Links.aspx?Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&LinkID=" + linkid + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
	}
	
	function AddNew_OnClick(DBID)
	{
		window.location.href = "CDB_Links.aspx?Mode=NEW&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
	}
	
	function Back_OnClick(DBID)
	{
	    if(ShowNavigationAlert()==false) return; //Added By Ninad WAF3_PB_64	
		window.location.href = "CDB_Links.aspx?sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
	}
	
	function Save_OnClick(DBID)
	{
		if (validate()== true)
		{
			objform.action = "CDB_Links.aspx?LinkID=<%=m_lngLinkID%>&Mode=<%=m_strMode%>&Action=SAVE&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64			
			objform.submit();
		}
	}
	
	function Delete_OnClick(DBID,msg)
	{
	    //Added By Ninad on 20 Aug 2007, issue ID - 14474
	    var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmLinks','chkDelete')
        if (blnIsRecordSelected == false) {return;}
        //End Addition By Ninad on 20 Aug 2007, issue ID - 14474
		if (confirm(msg))
		{
		objform.action = "CDB_Links.aspx?Action=DELETE&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID+ "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&parentsortby=<%=m_strParentSortBy%>&parentsortorder=<%=m_strParentSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>&FromWhere=<%=m_strFromWhere%>";
		objform.submit();
		}
	}
		
	function window_onload()
	{
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		if (objtxtLinkName !=null)
		{
			objtxtLinkName.focus(); 
		}
	}
	
	<% 'WAF3_PB_42 April 16, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 16, 2007 END%>
</script>

<script type="text/javascript">

$(document).ready(function(){

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-System Dashboard->High Level Dashboard->Configuration->Links
// Description:Apply FooTable
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
if($('.clsGridTable').length > 0)
{
    var divName=$('#DivList').attr('id');
    dataCollapse(divName);
}

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Table Inner Menu on document Ready
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
responsiveTopMenu();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Footer InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Footer InnerMenuDropDown
// Description:Creating DropDown for Footer Table Inner Menu on document Ready
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
responsiveFooterMenu();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Footer InnerMenuDropDown
/*---------------------------------------------------------*/

});


$(window).resize(function(){
/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Table Inner Menu on Window Resize
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
responsiveTopMenuResize();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Footer InnerMenuDropDown
// Description:Creating DropDown for Footer Table Inner Menu on Window Resize
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
responsiveFooterMenuResize();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Footer InnerMenuDropDown
/*---------------------------------------------------------*/
});
</script>