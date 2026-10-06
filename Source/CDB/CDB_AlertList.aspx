<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_AlertList.aspx.vb" Inherits="Whiz.CDB_Alerts" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Alert List")%>
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


	<body  class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id='frmAlerts' method='post' runat='server'>
			<%WritePage()%>
		</form>
	</body>
	<script language="javascript">
	var objform;
	var objdivlist;
	var objchkDelete;
	var DescriptiveShow = 1;
	var SummaryShow = 1;
	
	objform = GetFormReference('frmAlerts');
	objdivlist = GetObjectReference('frmAlerts', 'DivList');
	objchkDelete = GetObjectReference('frmAlerts','chkDelete',true);
		
	function Page_OnClick(alphabet)
	{
		
		window.location.href = "CDB_AlertList.aspx?FromWhere=<%=m_strFromWhere%>&Mode=LIST&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=<%=m_lngDashboardID%>&alphabet=" + URLEncode(alphabet);//Modified By Shrikant IssueID 20608
	}

	function Alert_OnClick(alertid)
    {
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
		<%--window.open("CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Mode=EDIT&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=<%=m_lngDashboardID%>&AlertID=" + alertid,"_AlertWizard", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 830)/2) + ",top=" + ((window.screen.height - 334)/2) + ",width=830,height=334") ; //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Mode=EDIT&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=<%=m_lngDashboardID%>&AlertID=" + alertid, "_AlertWizard", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 830) / 2) + ",top=" + ((window.screen.height - 334) / 2) + ",width=830,height=334"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function AddNew_OnClick(DBID)
    {
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
        <%--window.open("CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Mode=NEW&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID, "_AlertWizard", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 830) / 2) + ",top=" + ((window.screen.height - 334) / 2) + ",width=830,height=334"); //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Mode=NEW&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DashboardID=" + DBID, "_AlertWizard", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 830) / 2) + ",top=" + ((window.screen.height - 334) / 2) + ",width=830,height=334"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function SelectAll_OnClick()
	{
			var LoopCtr; 
			var TotalRows;
	
			TotalRows = "<%=m_intTotalRows%>";
			if (TotalRows == 0)
			{
				alert("There are no alerts to select");
				return;
			}	
		
			for (LoopCtr = 0;LoopCtr < TotalRows;LoopCtr++)
			{
				if (objchkDelete[LoopCtr].disabled==false)
				{
					objchkDelete[LoopCtr].checked=true;
				}
			}
			return;
	}
	
	function SetAsDefault_OnClick(alertid,setreset)
	{
		window.location.href = "CDB_AlertList.aspx?FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Action=SET_DEFAULT&DashboardID=<%=m_lngDashboardID%>&alertid=" + alertid + "&setreset=" + setreset;
	}
	
	function Delete_OnClick(DBID,msg)
	{
	    //Added By Ninad on 20 Aug 2007, issue ID - 14474
	    var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmAlerts','chkDelete')
        if (blnIsRecordSelected == false) {return;}
        //End Addition By Ninad on 20 Aug 2007, issue ID - 14474
		if (confirm(msg))
		{
		objform.action = "CDB_AlertList.aspx?FromWhere=<%=m_strFromWhere%>&Mode=LIST&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Action=DELETE&DashboardID=" + DBID;
		objform.submit();
		}
	}
	
	function Sort_OnClick(sortorder,sortby)
	{
		window.location.href = "CDB_AlertList.aspx?FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&DescriptiveShow="+ DescriptiveShow +"&SummaryShow=" + SummaryShow +"&Action=&DashboardID=<%=m_lngDashboardID%>&sortby=" + sortby + "&sortorder=" + sortorder;
	}
	
	
	function ShowHide_Div_Descriptive() 
	{
		var objtdShowHide_Div_Descriptive = document.getElementById("tdShowHide_ShowHide_Div_Descriptive");
		var obj_Div_Descriptive = document.getElementById("Div_Descriptive");
		var strDisplay=(arguments.length>0)?arguments[0]:obj_Div_Descriptive.style.display;
		if (strDisplay != "none") 
		{
			DescriptiveShow =0;
			obj_Div_Descriptive.style.display="none";
			objtdShowHide_Div_Descriptive.src='../../Images/plus.gif';
		}
		else
		{
			DescriptiveShow =1;
			obj_Div_Descriptive.style.display="";
			objtdShowHide_Div_Descriptive.src='../../Images/minus.gif';
		}
	}
        //added by Shamkant S on 10 Dec 2015
	function window_onload()
	{
	   // alert("");
	    var intDivHeight;
	    if (objdivlist) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;

	        if (navigator.appName == 'Netscape') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        }

	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';

	    }
	}
	function window_onresize()
	{

	    var intDivHeight;
	    if (objdivlist) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';
	    }
	}
        //Ended by Shamkant S on 10 Dec 2015 
	function ShowHide_Div_Summary() 
	{
		var objtdShowHide_Div_Summary = document.getElementById("tdShowHide_ShowHide_Div_Summary");
		var obj_Div_Summary = document.getElementById("Div_Summary");
		var strDisplay=(arguments.length>0)?arguments[0]:obj_Div_Summary.style.display;
		if (strDisplay != "none") 
		{
			SummaryShow=0;
			obj_Div_Summary.style.display="none";
			objtdShowHide_Div_Summary.src='../../Images/plus.gif';
		}
		else
		{
			SummaryShow=1;
			obj_Div_Summary.style.display="";
			objtdShowHide_Div_Summary.src='../../Images/minus.gif';
		}
	}
	
	<% 'WAF3_PB_42 April 16, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 16, 2007 END%>

	</script>
</HTML>

<!--Including files & Libraries-->




<script type="text/javascript">

$(document).ready(function(){
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
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Footer Table Inner Menu on Window Resize
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
responsiveFooterMenuResize();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

});
</script>
