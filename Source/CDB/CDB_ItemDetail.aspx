<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_ItemDetail.aspx.vb" Inherits="Whiz.CDB_ItemDetail" %>
<!DOCTYPE HTML>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Item Details")%>
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmItemDetail" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
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

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objtxtGraphTitle;
	var objtxtLeftTitle;
	var objcboQuery;
	var objtxtMin;
	var objtxtMax;
	var objtxtNMin;
	var objtxtNMax;
	var objtxtWMin;
	var objtxtWMax;
	var objtxtDMin;
	var objtxtDMax;
	var objtxtNoOfGraphElements;
	var objcboGraphType;
	objform = GetFormReference('frmItemDetail');
	objdivlist = GetObjectReference('frmItemDetail','divList');
	objtxtGraphTitle = GetObjectReference('frmItemDetail','txtGraphTitle');
	objtxtLeftTitle = GetObjectReference('frmItemDetail','txtLeftTitle');
	objcboQuery = GetObjectReference('frmItemDetail','cboQuery');
	objtxtMin = GetObjectReference('frmItemDetail','txtMin');
	objtxtMax = GetObjectReference('frmItemDetail','txtMax');
	objtxtNMin = GetObjectReference('frmItemDetail','txtNMin');
	objtxtNMax = GetObjectReference('frmItemDetail','txtNMax');
	objtxtWMin = GetObjectReference('frmItemDetail','txtWMin');
	objtxtWMax = GetObjectReference('frmItemDetail','txtWMax');
	objtxtDMin = GetObjectReference('frmItemDetail','txtDMin');
	objtxtDMax = GetObjectReference('frmItemDetail','txtDMax');
	objtxtNoOfGraphElements = GetObjectReference('frmItemDetail','txtNoOfGraphElements');
	objcboGraphType = GetObjectReference('frmItemDetail','cboGraphType');
	
	objcboXAxisAttribute = GetObjectReference('frmItemDetail','cboXAxisAttribute');
	objcboYAxisAttribute = GetObjectReference('frmItemDetail','cboYAxisAttribute');
		
	function validate()
	{
		var graphid;
		graphid = objcboGraphType.value;//<%=m_intGraphID%>;
		
		if (disallowBlank(objtxtGraphTitle,"Please enter the item name")) return false;
		if (disallowSpecialCharacters(objtxtGraphTitle,"Characters [/:*?+\"><|,\\\\] are not allowed within the 'Graph Title'.")) return false;//Added By Shrikant, IssueID 20608
		if (disallowBlank(objcboQuery,"Please select the query for the graph")) {objcboQuery.selectedIndex = -1; return false;}
		if (disallowBlank(objtxtNoOfGraphElements,"Please enter the value")) return false;
		if (disallowNonNumeric(objtxtNoOfGraphElements,"Please enter a numeric value")) return false;
		
		if (graphid == 1)
		{
			if (disallowBlank(objtxtMin,"Please enter the value")) return false;
			if (disallowBlank(objtxtMax,"Please enter the value")) return false;
			if (disallowBlank(objtxtNMin,"Please enter the value")) return false;
			if (disallowBlank(objtxtNMax,"Please enter the value")) return false;
			if (disallowBlank(objtxtWMin,"Please enter the value")) return false;
			if (disallowBlank(objtxtWMax,"Please enter the value")) return false;
			if (disallowBlank(objtxtDMin,"Please enter the value")) return false;
			if (disallowBlank(objtxtDMax,"Please enter the value")) return false;
						
			if (disallowNonNumeric(objtxtMin,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtMax,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtNMin,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtNMax,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtWMin,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtWMax,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtDMin,"Please enter a numeric value")) return false;
			if (disallowNonNumeric(objtxtDMax,"Please enter a numeric value")) return false;
			
			if (disallowMaxValueViolation(objtxtMin,objtxtMax.value,"The minimum value should be less than the maximum value")) return false;
			
			if (disallowValueRangeViolation(objtxtNMin,objtxtMin.value,objtxtMax.value,"The normal minimum value should be within the graph range")) return false;
			if (disallowValueRangeViolation(objtxtNMax,objtxtMin.value,objtxtMax.value,"The normal maximum value should be within the graph range")) return false;
			if (disallowValueRangeViolation(objtxtWMin,objtxtMin.value,objtxtMax.value,"The warning minimum value should be within the graph range")) return false;
			if (disallowValueRangeViolation(objtxtWMax,objtxtMin.value,objtxtMax.value,"The warning maximum value should be within the graph range")) return false;
			if (disallowValueRangeViolation(objtxtDMin,objtxtMin.value,objtxtMax.value,"The danger minimum value should be within the graph range")) return false;
			if (disallowValueRangeViolation(objtxtDMax,objtxtMin.value,objtxtMax.value,"The danger maximum value should be within the graph range")) return false;
			
			
			if (disallowMaxValueViolation(objtxtNMin,objtxtNMax.value,"The minimum value should be less than the maximum value")) return false;
			if (disallowMaxValueViolation(objtxtWMin,objtxtWMax.value,"The minimum value should be less than the maximum value")) return false;
			if (disallowMaxValueViolation(objtxtDMin,objtxtDMax.value,"The minimum value should be less than the maximum value")) return false;
			
		}
		if (chkCTAttributes()==false) return false;
		return true;
	}
	
	function chkCTAttributes()
	{
		if (objcboXAxisAttribute != null && objcboYAxisAttribute != null)
		{
			if (objcboXAxisAttribute.value != '' && objcboYAxisAttribute.value != '')
			{			
				if (objcboXAxisAttribute.value == objcboYAxisAttribute.value)
				{
					alert("Please Select Different X and Y Axis Attributes For Cross Tab.");
					return false;
				}
			}

			if (objcboXAxisAttribute.value == '' && objcboYAxisAttribute.value != '')
			{
				alert("Please Select X Axis Attributes For Cross Tab.");
				return false;
			}

			if (objcboXAxisAttribute.value != '' && objcboYAxisAttribute.value == '')
			{
				alert("Please Select Y Axis Attributes For Cross Tab.");
				return false;
			}
		}	
		return true;
	}
	
	function Next_OnClick()
	{
		if (validate())
		{
			objform.action = "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=NEXT&Mode=<%=m_strMode%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>&GraphID=<%=m_intGraphID%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64			
			objform.submit();
		}
	}
	
	function ChainLink_OnClick(pos)
	{
		if(ShowNavigationAlert()==false) return;    //Added By Ninad WAF3_PB_64	
		var graphid;
		graphid = <%=m_intGraphID%>;
		if (graphid==1)
		{
			switch(true)
			{
			case (pos==1):
				window.location.href =  "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==2):
				window.location.href =  "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==3):
				window.location.href =  "CDB_ItemAlert.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			default:
				break;
			}
		}
		else
		{
			switch(true)
			{
			case (pos==1):
				window.location.href =  "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==2):
				window.location.href =  "CDB_GraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==3):
				window.location.href =  "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==4):
				window.location.href =  "CDB_AdvancedGraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			default:
				break;
			}
		}
	}
	
	function Save_OnClick()
	{
		if (validate())
		{
		    var MenuTags = document.getElementsByTagName('A');
		    for(i = 0; i < MenuTags.length; i++)
		    {
		        if (MenuTags[i].className == "Menu")
		        {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.parentNode.style.display= "none";
		        }
		    } 
			objform.action = "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&Mode=<%=m_strMode%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>&GraphID=<%=m_intGraphID%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64			
			objform.submit();
		}
	}
	
	function cboGraphType_OnChange()
	{
		if (objcboGraphType.value==1)
		{
			tblRange.style.display ="block";
		}
		else
		{
			tblRange.style.display ="none";
		}
	}
	
	function cboQuery_OnChange()
	{
		objform.action = "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=<%=m_strAction%>&Mode=<%=m_strMode%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>&GraphID=<%=m_intGraphID%>&QueryID="+ objcboQuery.value;
		blnNavigate = false;    //Added By Ninad WAF3_PB_64		
		objform.submit();
	}
	
	function Back_OnClick(DBID)
	{
		if(ShowNavigationAlert()==false) return;    //Added By Ninad WAF3_PB_64	
		window.location.href = "CDB_ItemTemplate.aspx?FromWhere=<%=m_strFromWhere%>&DashboardID=" + DBID;
	}
	
	function window_onload()
	{
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		var msg;
		msg = "<%=m_strInvalidQueryMessage%>";
		if (trimString(msg) != "")
		{
			alert(msg);
		}
		
		objtxtGraphTitle.focus(); 
	}
	
	<% 'WAF3_PB_42 April 16, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 16, 2007 END%>

</script>
