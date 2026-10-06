<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_ItemList.aspx.vb" Inherits="Whiz.CDB_ItemList" %>
<!DOCTYPE HTML>
<html>
<%CommonFunctions.General.PlotPageHeadTag("Item List")%>
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
    /*Added by Yogesh J on 10/15/2015 Issue id=2720*/
    #DivList1 {
        height:210px !important;
    }
    #DivList7
    {
     height:210px !important;
    }
   /*End of addition by Yogesh J on 10/15/2015 Issue id=2720*/ 
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


	<body  class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)" onresize=" window_onresize()"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmItemList" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
        Response.Write("strControlsToExcludeFrmNavigationAlert='chkDelete';")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objchkDelete;
	var objchkShow;
	var objtxtOrderNumber;
	
	objform = GetFormReference('frmItemList');
	objdivlist = GetObjectReference('frmItemList','DivList');
	objchkDelete = GetObjectReference('frmItemList','chkDelete',true);
	objchkShow = GetObjectReference('frmItemList','chkShow',true);
	objtxtOrderNumber = GetObjectReference('frmItemList','txtOrderNumber',true);
	

    //Commented and Added By Yogesh J on 10-Dec-2015 issue id=2720
	function window_onload() {
	   
	var intDivHeight;
	var browser = isIE();
	if (objdivlist) {

	
	   
	    if (browser == 'IE') {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	    }
	    else if (browser == 'FF') {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	    }
	    else {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	    }
	 

	    if (intDivHeight < 100) intDivHeight = 100;
	    objdivlist.style.height = intDivHeight+'px';
	}
	
	}
	
	function window_onresize() 
	{
	   
	    var intDivHeight;
	    var browser = isIE();
	    if (objdivlist) {

	
	   
	        if (browser == 'IE') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        }
	        else if (browser == 'FF') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        }
	        else {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
	        }
	 

	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight+'px';
	    }
	
	}
    
    /*End of addition by Yogesh J on 10/15/2015 Issue id=2720*/ 
	
	function validate()
	{
		var count;
		var index;
		count = <%=m_intTotalRows%>;
		for (index=0;index < count;index++)
		{
			if (IsEmpty(objtxtOrderNumber[index],"Please provide the 'Order Number'.")) return false; //Modified By Ninad on 17 Aug 2007 Issue ID - 2620 
			if (disallowNonInteger(objtxtOrderNumber[index],"Please enter a positive integer value for order number"))  return false;
		}
		return true;
	}
	
	function Item_OnClick(itemid)
	{	
        if (ShowNavigationAlert() == false) return; //Added By Ninad WAF3_PB_64			
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
		<%--window.open("CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=" + itemid,"_ItemWizard", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 540)/2) + ",width=600,height=540") ; //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=" + itemid, "_ItemWizard", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 540) / 2) + ",width=600,height=540"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function AddToDashboard_OnClick(itemid)
    {
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
        <%--window.open("CDB_AddItemToDashboard.aspx?DashboardID=<%=m_lngDashboardID%>&ItemID=" + itemid, "_AddItemToDashboard", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 200) / 2) + ",width=600,height=200"); //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_AddItemToDashboard.aspx?DashboardID=<%=m_lngDashboardID%>&ItemID=" + itemid, "_AddItemToDashboard", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 200) / 2) + ",width=600,height=200"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function AddNew_OnClick(DBID)
	{
        if (ShowNavigationAlert() == false) return; //Added By Ninad WAF3_PB_64
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
		<%--window.open("CDB_ItemTemplate.aspx?FromWhere=<%=m_strFromWhere%>&DashboardID=" + DBID,"_ItemTemplate", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 970)/2) + ",top=" + ((window.screen.height - 525)/2) + ",width=970,height=525"); //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_ItemTemplate.aspx?FromWhere=<%=m_strFromWhere%>&DashboardID=" + DBID, "_ItemTemplate", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 970) / 2) + ",top=" + ((window.screen.height - 525) / 2) + ",width=970,height=525"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function Save_OnClick(DBID)
	{
		var count;
		var index;
		
		if (validate()== true)
		{
			count = <%=m_intTotalRows%>;
			for (index=0;index < count;index++)
			{
				objchkDelete[index].disabled = false;
				objchkShow[index].disabled =false;
			}
			objform.action = "CDB_ItemList.aspx?FromWhere=<%=m_strFromWhere%>&TotalRecords=<%=m_intTotalRows%>&Action=SAVE&DashboardID=" + DBID + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64			
			objform.submit();
		}
	}
	
	function Delete_OnClick(DBID,msg)
	{
	    //Added By Ninad on 20 Aug 2007, issue ID - 14474
	    var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmItemList','chkDelete')
        if (blnIsRecordSelected == false) {return;}
        //End Addition By Ninad on 20 Aug 2007, issue ID - 14474
		if (confirm(msg))
		{
		objform.action = "CDB_ItemList.aspx?FromWhere=<%=m_strFromWhere%>&Action=DELETE&DashboardID=" + DBID;
		objform.submit();
		}
	}
	
<% 'WAF3_PB_42 April 16, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 16, 2007 END%>

</script>


<script type="text/javascript">

$(document).ready(function(){

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-System Dashboard->High Level Dashboard->Configuration->Sections
// Description:Apply FooTable
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
if($('.clsGridTable').length > 0)
{
    var tableClassName;
    var codehtml;
    var newCodehtml;
    var divName;

    if($('#DivList1').length > 0)
    {
       divName=$('#DivList1').attr('id');
    }

    if($('#DivList13').length > 0)
    {
        divName=$('#DivList13').attr('id');
    }

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
});
</script>
