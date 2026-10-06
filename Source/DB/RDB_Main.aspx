<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RDB_Main.aspx.vb" Inherits="PbNIT.RDB_Main" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Radar Dashboard")%>
  
    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
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

	<body MS_POSITIONING="GridLayout" bgcolor="black" >
		<form name=frmRadar id=frmRadar runat=server>
		<%WritePage%>
		</form>  
	</body>
</HTML>
	
	
<script language="javascript">

	var frm = GetFormReference('frmRadar');
	var objcboLocation = GetObjectReference('frmRadar','cboLocation');
	var objcboDepartment = GetObjectReference('frmRadar','cboDepartment');
	var objcboRadar = GetObjectReference('frmRadar','cboRadar');
	var objcboView = GetObjectReference('frmRadar','cboView');
	var objcboProject = GetObjectReference('frmRadar','cboProject');
	var objcboParameter = GetObjectReference('frmRadar','cboParameter');
	
	    <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
	
	function Project_OnClick(ProjectID)
	{
		window.open("RDB_DrillDown.aspx?Type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>&view=<%=m_strView%>&ParameterID=<%=m_lngParameterID%>" + "&ProjectID=" + ProjectID ,"_DrillDown","resizable=yes,scrolbars=yes,left=100,top=100,width=700,height=500") ;
	}
	// Modified By NitinVS on 2 sep 2005 for PMLifeLine IssueId 130 Added Parameter for Curr= 1 and ParameterValue
	function Parameter_OnClick(ParameterID,ShowDrillDowns , Parametervalue)
	{
		if (ShowDrillDowns==1)
		{//&PARAMVALUE=" + Parametervalue 
		window.open("RDB_DrillDown.aspx?Type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>&view=<%=m_strView%>&ParameterID=" + ParameterID  + "&ProjectID=<%=m_lngProjectID%>&CURR=1&PARAMVALUE=" + Parametervalue ,"_DrillDown","resizable=yes,scrolbars=yes,left=100,top=100,width=700,height=500") ;
		}
	}
	// End Modification By NitinVS on 2 sep 2005 for PMLifeLine IssueId 130 Added Parameter for ParameterValue
	
	function cboView_OnChange()
	{
		if (objcboView.value == "PARAMETER" )
		{
			objcboParameter.value = "";
		}
		else
		{
			objcboProject.value=""; 
		}
		frm.action = "RDB_Main.aspx?type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>";
		frm.submit();
	}
	
	function cboParameter_OnChange()
	{
		frm.action = "RDB_Main.aspx?type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>";
		frm.submit();
	}
	
	function cboProject_OnChange()
	{
		frm.action = "RDB_Main.aspx?type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>";
		frm.submit();
	}
	// Modified By NitinVS on 2 sep 2005 for PMLifeLine IssueId 130 Location and Busness Group are not used	
	function Configure_OnClick()
	{
//		window.open("RDB_ParameterList.aspx?Type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>&view=<%=m_strView%>&LocationID=" + objcboLocation.value +  "&DepartmentID=" + objcboDepartment.value ,"_Paramlist","resizable=yes,scrolbars=no,left=100,top=100,width=500,height=450") ;
		window.open("RDB_ParameterList.aspx?Type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>&view=<%=m_strView%>" ,"_Paramlist","resizable=yes,scrolbars=no,left=100,top=100,width=500,height=450") ;
	}

	// End Modification  By NitinVS on 2 sep 2005 for PMLifeLine IssueId 130 
	
	function cboLocation_OnChange()
	{
		frm.action = "RDB_Main.aspx?type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>";
		frm.submit();
	}
	
	function cboDepartment_OnChange()
	{
		frm.action = "RDB_Main.aspx?type=<%=m_strType%>&DashboardID=<%=m_lngDashboardID%>";
		frm.submit();
	}

	function cboDashboard_OnChange()
	{
	var objcboDashboard = GetObjectReference('frmRadar','cboDashboard')
	var PageName;
	var arr = new Array();
		PageName = objcboDashboard.value;
		if (trimString(objcboDashboard.value) != "") 
		{
			arr = PageName.split("|");
			if (isSubstringExists(arr[0],'?'))
			{
				window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
			}
			else
			{
				window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
			}
		}
		else
		{
			window.location.href = "../CDB/CDB_DashboardDetail.aspx?&MODE=NEW&FromPage=../DB/DBRadarDashboard.aspx?DashboardID=105" ; 	
		}
	}
</script>

