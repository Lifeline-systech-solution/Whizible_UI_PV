<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
     .footerMenuTable
    {
        
        left: 0px;
         /* Commented by Shamkant S 14/10/2015 for align footer menu*/ 
        
    }
    #dvMainMnu
    {
        float:right;
    }
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $("#TD0").parent().find('td').css("text-align", "right");
    });
</script>
<%--<script type="text/javascript">
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

</script>--%>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_PageCanvas.aspx.vb" Inherits="Whiz.PB_PageCanvas" %>

<!DOCTYPE HTML>
<HTML>
				<% MyBase.InitializeResources("Resources.PB_PageCanvas", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmSample" method="post" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 101; LEFT: 150px; VISIBILITY: hidden; POSITION: absolute; TOP: 50px"></DIV>
			<%PageInit%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objdivSection;
			var objListTableRef;
			var objFormTableRef;
			var objListTDRef;
			var objFormTDRef;
			objdivlist=GetObjectReference('frmPageCanvas','outerDiv');
			objdivSection=GetObjectReference('frmPageCanvas','sectionDiv');
			objBorderTableRef=GetObjectReference('frmPageCanvas','tblEditingAreaBorder');										
			<% 'WAF3_PB_42 April 10, 2007 modified local functions window_onresize and window_onload %>
			function window_onresize()		
			{
		        var intFillFactor=(arguments.length>0)?arguments[0]:40;
		        windowSize_common(intFillFactor);
				 UpdateWindowSize(true, true);
			}			
			function window_onload()
			{
		        var intFillFactor=(arguments.length>0)?arguments[0]:40;
		        windowSize_common(intFillFactor);
				WindowLoading(true, true);
			}
			function DefineSystemView(TagID)
			{
				window.open ("../General/ViewProperties_CommonList.aspx?MasterTagID=1837&TagID=" + TagID, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=800,height=500");	 
			}
			
			function DefineSystemFilters(strTagID)
			{
				window.document.open("../General/Filter_CommonList.aspx?MasterTagID=1840&TagID=" + strTagID + "&ParentTagID=0","", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=800,height=500");
			}
			function OpenProperties(strPageName, strPageParameters, strTitle, strTagID, strSubTagID, strFromElement)
			{
				var style;
				/*if(strFromElement=="SubTag")
				{
					style = "height=600,width=1000,left=20,top=20,scrollbars=1,resizable=1";
				}
				else*/
				if (strPageName == 'PB_AttachmentTab.aspx')
					style = CentralizeWindow(600, 375) + ",scrollbars=0,resizable=1";
				else
					style = CentralizeWindow(1000, 575) + ",scrollbars=0,resizable=1";
				var url = strPageName + "?"+ strPageParameters + "&";
				url += "TITLE="+ strTitle + "&TagID="+ strTagID+ "&SubTagID="+ strSubTagID + "&FromElement=" + strFromElement;
				window.document.open(url,strTagID+strSubTagID,style);
			}
			function Back_OnClick()
			{
				var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
				var paramMasterTagID=GetObjectReference('frmPageCanvas','paramMasterTagID');
				parent.Sub.location.href="../SM/WAF_CommonList.aspx?FromWhere=" + paramFromWhere.value + "&MasterTagID=" + paramMasterTagID.value;
					
			}
			function GridFormattingRules_OnClick(MasterTagID)
			{
				var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
				var paramMasterTagID=GetObjectReference('frmPageCanvas','paramMasterTagID');
				var paramTagSubTagID = GetObjectReference('frmPageCanvas', 'paramTagSubTagID');
				var paramFromElement = GetObjectReference('frmPageCanvas','paramFromElement');
				var style = CentralizeWindow(600, 375) + ",scrollbars=0,resizable=1";
				var url;
				url = "../General/CommonList.aspx?FromElement=" + paramFromElement.value + "&MasterTagID=" + MasterTagID + "&TagID=" + paramTagSubTagID.value;
				window.document.open(url,"GridFormattingRules",style);
			}
			function Close_OnClick()
			{
				parent.window.close();
			}
			function Preview_OnClick(MasterTagID, TemplateType,IsSmartNavigationEnabled)
			{
				var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
				var paramMasterTagID=GetObjectReference('frmPageCanvas','paramMasterTagID');
				var paramTagSubTagID = GetObjectReference('frmPageCanvas', 'paramTagSubTagID');
				var paramFromElement = GetObjectReference('frmPageCanvas','paramFromElement');
				var style = CentralizeWindow(900,600)+ ",scrollbars=0,resizable=1";
				var url;
				var PageName = GetObjectReference('frmPageCanvas','PageName');
				var CustomPage = GetObjectReference('frmPageCanvas','CustomPage');
				if (CustomPage == null)
				  {					  			  
					if (TemplateType == 'FORM')
						url = "../General/CommonPage.aspx?FromWhere=" + paramFromWhere.value + "&MasterTagID=" + MasterTagID;
					else
						url = "../General/CommonList.aspx?FromWhere=" + paramFromWhere.value + "&MasterTagID=" + MasterTagID;
				  }
				 else
				 {
				 //Append the parameters and prepend the '../' to page name. IssueID = 20404 (2nd August 2005 NileshD)
				 url = "../" + PageName.value + "?FromWhere=" + paramFromWhere.value + "&MasterTagID=" + MasterTagID;
				  }
				  //Added By : Ninad   Req Id : WAF3_PB_41
				 if (IsSmartNavigationEnabled=='True') 
				 url="../General/SmartNavigation.aspx" + url.substring(url.indexOf('?'));
				 window.document.open(url,"GridFormattingRules",style);
			}
			
			//Added By NileshD on 15 oct. 2004
			function CLCPPageEvent_OnClick(TagID,ParentTagID)
			{
			 var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
			 var style = CentralizeWindow(900,600)+ ",scrollbars=0,resizable=1";
			 var url;
			 
			 url = "../General/PageEventMapping_CommonList.aspx?FromWhere="+ paramFromWhere.value + "&MasterTagId=1523&Tag=" + TagID + "&ParentTag=" + ParentTagID;
			
			 window.open(url,"",style);
			}
			//End Of Addition
			
			//Added By NileshD on 18 oct. 2004
			function RouterEventTag_OnClick(TagID,ParentTagID)
			{
			 var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
			 var style = CentralizeWindow(900,600)+ ",scrollbars=0,resizable=1";
			 var url;
			 
			 url = "../General/CommonList.aspx?FromWhere="+ paramFromWhere.value + "&MasterTagId=1519&TagID=" + TagID;
			
			 window.open(url,"",style);
			}
			//End Of Addition
			
			//Added By NileshD on 18 oct. 2004
			function RouterEventSubTag_OnClick(TagID,ParentTagID)
			{
			 var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
			 var style = CentralizeWindow(900,600)+ ",scrollbars=0,resizable=1";
			 var url;
			 
			 url = "../General/CommonList.aspx?FromWhere="+ paramFromWhere.value + "&MasterTagId=1518&TagID=" + ParentTagID;
			
			 window.open(url,"",style);
			}
			//End Of Addition
			
			//Added By NileshD on 16 Sep. 2004
			function CLCPExtension_OnClick(TagID,ParentTagID)
			{
			 var paramFromWhere=GetObjectReference('frmPageCanvas','paramFromWhere');
			 var style = CentralizeWindow(900,600)+ ",scrollbars=0,resizable=1";
			 var url;
			 
			 url = "../General/CommonList.aspx?FromWhere="+ paramFromWhere.value + "&MasterTagId=1522&Tag=" + TagID + "&ParentTag=" + ParentTagID;
			
			 window.open(url,"",style);
			}
			//End of Addition
			
			//Added By NileshD on 27 Sep. 2004
			function GenerateScript_OnClick(TagID)
			{
			   	 var style = CentralizeWindow(900,600)+ ",scrollbars=1,resizable=1,menubar=yes";
				 window.open("PB_GeneratedScript.aspx?TagID=" + TagID,"",style);
			}
			//End of Addition
			
			//Adde By NileshD on 25 Jan 2005
			function TemplateSelected(strTagID, strTemplateID,strPageName)
			{
				var url = "PB_InitialPageProperties.aspx?TemplateID="+strTemplateID+"&TagID="+strTagID+"&PageName="+strPageName;
				window.document.open(url,'Properties','height=190,width=625,left=100,top=100,scrollbars=0,resizable=1');				
			}
			//End Of Addition
			
			function CentralizeWindow(width, height)
			{
				var styleHeightWidth;
				var left;
				var top;
				left = 512-(width/2);
				top = 350-(height/2);
				styleHeightWidth = "height=" + height + ",width=" + width + ",left=" + left + ",top=" + top;
				return styleHeightWidth;
			}
			function PageFilters_OnClick(FromWhere, TagID, SubTagID, MasterTagID)
			{
				var style = CentralizeWindow(600, 350) + ",scrollbars=0,resizable=1";
				var url;
				if (SubTagID == "")
					url = "../General/CommonList.aspx?FromWhere=" + FromWhere + "&MasterTagID=" + MasterTagID + "&TagID=" + TagID + "&SubTagID=" + SubTagID;
				else
					url = "../General/CommonList.aspx?FromWhere=" + FromWhere + "&MasterTagID=" + MasterTagID + "&ParentTag=" + TagID + "&TagID=" + SubTagID;
				window.document.open(url,"PageFilters",style);
			}
			//Added By NinadP on 22 Jan 2008, ReqID WAF3_PB_57  
            function QueryStringParameters_OnClick(TagID)
			{
				var style = CentralizeWindow(650, 400) + ",scrollbars=0,resizable=1";
				var url = "../General/SmartNavigation.aspx?FromWhere=SM&MasterTagID=1665&TagID=" + TagID;
				window.document.open(url,"QueryStringParameters",style);
			}
			//End addition By NinadP on 22 Jan 2008, ReqID WAF3_PB_57
		</script>
	</body>
</HTML>
