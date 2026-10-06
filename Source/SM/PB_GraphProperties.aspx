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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_GraphProperties.aspx.vb" Inherits="Whiz.PB_GraphProperties" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_GraphProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmGraphProperties" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
	
	var objdivlist;
	var objFrm;
	objFrm=GetFormReference('frmGraphProperties')
	objdivlist=GetObjectReference('frmGraphProperties','myDiv')

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
				var objStoredProcedure;
				var objGraphTitleFont;
				var objType;
				var objHeightInPixel;
				var objWidthInPixel;
				var objPalletStyle;
				var objPiChartLabelStyle;
				var objBorderColor;
				var objChartBackColor;
				var objChartAreaColor;
				var objLegendFont;
				var objLegendColor;
				var objLegendCaptionColor;
				
				
				objTitle=GetObjectReference('frmGraphProperties','Title');
				objTitle.focus();
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';

				
				var RelatedDataID;
				GraphID=GetObjectReference('frmGraphProperties','hdGraphID');
				var hdFlag=GetObjectReference('frmGraphProperties','hdFlag');
			
				if(GraphID.value==0 && hdFlag==null) 
				{
					objStoredProcedure=GetObjectReference('frmGraphProperties','StoredProcedure')
					//objStoredProcedure.selectedIndex=-1;
					
					objType=GetObjectReference('frmGraphProperties','Type');
					//objType.selectedIndex=-1;
					
					//objGraphTitleFont=GetObjectReference('frmGraphProperties','GraphTitleFont');
					//objGraphTitleFont.selectedIndex=-1;
					
					//objType=GetObjectReference('frmGraphProperties','GraphTitleFont');
					//objType.selectedIndex=-1;
					
					objHeightInPixel=GetObjectReference('frmGraphProperties','HeightInPixel');
					//objHeightInPixel.selectedIndex=-1;
					
					objWidthInPixel=GetObjectReference('frmGraphProperties','WidthInPixel');
					//objWidthInPixel.selectedIndex=-1;
					
					//objPalletStyle=GetObjectReference('frmGraphProperties','PalletStyle');
					//objPalletStyle.selectedIndex=-1;
					
					objPiChartLabelStyle=GetObjectReference('frmGraphProperties','PiChartLabelStyle');
					//objPiChartLabelStyle.selectedIndex=-1;
					
					objBorderColor=GetObjectReference('frmGraphProperties','BorderColor');
					//objBorderColor.selectedIndex=-1;
					
					objBorderStyle=GetObjectReference('frmGraphProperties','BorderStyle');
					//objBorderStyle.selectedIndex=-1;
					
					objChartBackColor=GetObjectReference('frmGraphProperties','ChartBackColor');
					//objChartBackColor.selectedIndex=-1;
					
					objChartAreaColor=GetObjectReference('frmGraphProperties','ChartAreaColor');
					//objChartAreaColor.selectedIndex=-1;
					
					//objLegendFont=GetObjectReference('frmGraphProperties','LegendFont');
					//objLegendFont.selectedIndex=-1;
					
					//objLegendColor=GetObjectReference('frmGraphProperties','LegendColor');
					//objLegendColor.selectedIndex=-1;
					
					objLegendCaptionColor=GetObjectReference('frmGraphProperties','LegendCaptionColor');
					//objLegendCaptionColor.selectedIndex=-1;
				}
				
				if(hdFlag!=null)
				{
					if(hdFlag.value=='True')
					{
						objStoredProcedure=GetObjectReference('frmGraphProperties','StoredProcedure')
						objStoredProcedure.focus();
					}
				}			
			
		}
		
	function Save_OnClick()
	{
		var validateflag;
		validateflag=Validate_OnClick();
		if( validateflag==true)
		{
			var objform;
			var RelatedDataID;
			GraphID=GetObjectReference('frmGraphProperties','hdGraphID');
				
			var paramFromElement=GetObjectReference('frmGraphProperties','paramFromElement');
			var paramTagID=GetObjectReference('frmGraphProperties','paramTagID');
			var paramSubTagID=GetObjectReference('frmGraphProperties','paramSubTagID');
			var paramTitle=GetObjectReference('frmGraphProperties','paramTitle'); 
			
			if (GraphID.value==0) 
			{
				var objAction=GetObjectReference('frmGraphProperties','paramaction');
				objAction.value="Save";
				objform=GetFormReference('frmGraphProperties')
				if (paramFromElement.value == 'Tag')
					{objform.action = "PB_GraphProperties.aspx?TITLE=" + paramTitle.value + "&TagID=" + paramTagID.value + "&FromElement=" + paramFromElement.value;}
				else if (paramFromElement.value == 'SubTag')   
				    {objform.action = "PB_GraphProperties.aspx?TITLE=" + paramTitle.value + "&SubTagID=" + paramSubTagID.value + "&FromElement=" + paramFromElement.value;}
				objform.submit();
				if (paramFromElement.value == 'Tag')
				    {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&DisplaySection=G";}
				else if (paramFromElement.value == 'SubTag')   
				        {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&DisplaySection=G";}
			}
			else
			{
				var objAction=GetObjectReference('frmGraphProperties','paramaction');
				objAction.value="Save";
				
				objform=GetFormReference('frmGraphProperties')
				if (paramFromElement.value == 'Tag')
				    {objform.action = "PB_GraphProperties.aspx?GraphID=" + GraphID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value;}
				else if (paramFromElement.value == 'SubTag')   
				    {objform.action = "PB_GraphProperties.aspx?GraphID=" + GraphID.value + "&TITLE=" + paramTitle.value + "&FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value;}
				objform.submit();
				if (paramFromElement.value == 'Tag')
				    {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&DisplaySection=G";}
				else if (paramFromElement.value == 'SubTag')   
				        {parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&DisplaySection=G";}
			}
		}
	}
	
		
	function Close_OnClick()
	{
		parent.window.close();
	}		
		
	
		</script>
		<Script>
		<asp:Literal id="ltlAlert" runat="server"
				EnableViewState="True">
		</asp:Literal>
		</Script>
	</body>
</HTML>
