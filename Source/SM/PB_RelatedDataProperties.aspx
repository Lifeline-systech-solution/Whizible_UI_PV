<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_RelatedDataProperties.aspx.vb" Inherits="Whiz.PB_RelatedDataProperties" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_RelatedDataProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmRelatedDataProperties" name="frmRelatedDataProperties" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">  
	
	var objdivlist;
	var objFrm;
	objFrm=GetFormReference('frmRelatedDataProperties')
	objdivlist=GetObjectReference('frmRelatedDataProperties','myDiv')

	function window_onresize()		
		{
			var x,b;
			var intDivHeight ;
			var intDivHeightRisk;
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
			intDivHeight = 100;
				
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
		}
			
	function window_onload()
		{
				var intDivHeight ;
				var intDivHeightRisk;
				var objDataHeader;
				var objDataHeaderAlignment;
				
				objDataHeader=GetObjectReference('frmRelatedDataProperties','DataHeader');
				objDataHeader.focus();
				
				var RelatedDataID;
				RelatedDataID=GetObjectReference('frmRelatedDataProperties','hdRelatedDataID');
				var hdFlag;
				hdFlag=GetObjectReference('frmRelatedDataProperties','hdFlag');
				if (RelatedDataID.value==0 && hdFlag==null) 
				{
					objDataHeaderAlignment=GetObjectReference('frmRelatedDataProperties','DataHeaderAlignment')
					objDataHeaderAlignment.selectedIndex=-1;
				}
				
				if(hdFlag!=null)
				{
					if(hdFlag.value=='True')
					{
						objDataGridSQL=GetObjectReference('frmRelatedDataProperties','DataGridSQL')
						objDataGridSQL.focus();
					}
				}				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
								
		}
		
	function Save_OnClick()
	{
		var validateflag;
		validateflag=Validate_OnClick();
		if( validateflag==true)
		{
			var objform;
			var RelatedDataID;
			RelatedDataID=GetObjectReference('frmRelatedDataProperties','hdRelatedDataID');
			//Modified By NileshD on 6 Nov. 2004
				var paramFromElement=GetObjectReference('frmRelatedDataProperties','paramFromElement');
				var paramTagID=GetObjectReference('frmRelatedDataProperties','paramTagID');
				var paramSubTagID=GetObjectReference('frmRelatedDataProperties','paramSubTagID');
				var paramTitle=GetObjectReference('frmRelatedDataProperties','paramTitle');
		
			if (RelatedDataID.value==0) 
			{
				var objAction=GetObjectReference('frmGraphProperties','paramaction');
				objAction.value="Save";
				var objFromElement = GetObjectReference('frmGraphProperties','FromElement');
				objform=GetFormReference('frmRelatedDataProperties')
				if (objFromElement.value == 'Tag')
				  { objform.action = "PB_RelatedDataProperties.aspx?TITLE=" + paramTitle.value + "&TagID=" + paramTagID.value + "&FromElement=" + paramFromElement.value; }
				else if (objFromElement.value == 'SubTag')   
				  { objform.action = "PB_RelatedDataProperties.aspx?TITLE=" + paramTitle.value + "&SubTagID=" + paramSubTagID.value + "&FromElement=" + paramFromElement.value; }
				objform.submit();
				
			}
			else
			{
				var objAction=GetObjectReference('frmGraphProperties','paramaction');
				var objFromElement = GetObjectReference('frmGraphProperties','FromElement');
				objAction.value="Save";
				objform=GetFormReference('frmRelatedDataProperties')
				if (objFromElement.value == 'Tag')
				 { objform.action = "PB_RelatedDataProperties.aspx?RelatedDataID=" + RelatedDataID.value + "&TITLE=" + paramTitle.value + "&TagID=" + paramTagID.value + "&FromElement=" + paramFromElement.value; }
				else if (objFromElement.value == 'SubTag')  
				  { objform.action = "PB_RelatedDataProperties.aspx?RelatedDataID=" + RelatedDataID.value + "&TITLE=" + paramTitle.value + "&SubTagID=" + paramSubTagID.value + "&FromElement=" + paramFromElement.value; }
				objform.submit();
			}
			if (objFromElement.value == 'Tag')
			   {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&DisplaySection=R";}
			else if (objFromElement.value == 'SubTag')  
			   {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&DisplaySection=R";}
		}
		
		//parent.frVerticalLeft.location.reload();
	}
	
		
		
	function Close_OnClick()
	{
		parent.window.close();
	}
	
	function StoredProcedureFocus()
	{
		objStoredProcedure=GetObjectReference('frmRelatedDataProperties','StoredProcedure');
        objStoredProcedure.focus();
	}
	function ShowMessage()
	{
		alert('Invalid Stored Procedure or Invalid Parameters');
	}
			
		</script>
	</body>
</HTML>
