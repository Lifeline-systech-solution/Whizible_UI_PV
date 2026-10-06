<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_CounterGraphs.aspx.vb" Inherits="PbNIT.CRM_CounterGraphs"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("HelpDesk Counter Graphs")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
        document.body.style.height = window.innerHeight - 3 + 'px';
        document.body.style.overflow = "auto";
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
        document.body.style.height = window.innerHeight - 3 + 'px';
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

	<body MS_POSITIONING="GridLayout" class=clsBody onload="window_onload()" onresize = "window_onresize()">
	<form id="frm_CRMCounters" method="post" runat="server" style="height:599px">					
		<%WritePage()%>
		<DIV id="divGraphs" runat="server">
			<table cellspacing="0" align="middle" class="clsTable" id="tblGraphs" cellPadding="0" runat="server">
			</table>
		</DIV><DIV></DIV></DIV>
		<%=m_strMenu%>
	</form>
	<Script>
					
		var objform;
		var objdivlist;
		
		objform = GetFormReference('frm_CRMCounters');
		objdivlist = GetObjectReference('frm_CRMCounters','DivMain');
	
        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>	
				
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			
			//WindowLoading();
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;

			if (intDivHeight < 100)	intDivHeight = 100;
			if(navigator.appName == 'Netscape')
			{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 80 ;
			}

			//objdivlist.style.height = intDivHeight+'px';	
			//objdivGraph.style.height = intDivHeight;		
		}
		
		function window_onresize()
		{
			var intDivHeight;
			var intDivHeightRisk;
			UpdateWindowSize();
						
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight + 'px';
			//objdivGraph.style.height = intDivHeight;		
				
		
		}
					
					
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
		   //Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'CRM_CounterGraphs.aspx/GenrateURLToken_RequestSLA_OnClick',
		        data: JSON.stringify({ itemid: itemid, EmployeeID: "<%=Session("intUserID")%>" }),
        success: function (Result) {
            OpenPage_RequestSLA(Result.d, itemid,colname,colvalue);
        },
        error: function () {
         //   alert("Error")
        }
		    });
		  //  window.open("CRM_DrillDown_Detail.aspx?CRMFilterID=<%=m_lngFilterID%>&DashboardID=153&Mode=<%=m_strMode%>&ItemID=" + itemid + "&colname=" + replaceSubstring(URLEncode(colname), "|||", "'") + "&colvalue=" + replaceSubstring(URLEncode(colvalue), "|||", "'"), "_drillDown", "left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
		  //  window.status = "View drill downs";

        //End of addition by Yogesh J on 19-Jan-2016
			
		}				
	    //Added by Yogesh J on 19-Jan-2016 for to generate and validate Token		
	    function OpenPage_RequestSLA(Result, itemid, colname,colvalue)
	    {
	        window.open("CRM_DrillDown_Detail.aspx?CRMFilterID=<%=m_lngFilterID%>&DashboardID=153&Mode=<%=m_strMode%>&ItemID=" + itemid + "&PKToken=" + Result + "&colname=" + replaceSubstring(URLEncode(colname), "|||", "'") + "&colvalue=" + replaceSubstring(URLEncode(colvalue), "|||", "'"), "_drillDown", "left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
	        window.status = "View drill downs";
	    }
	    //End of addition by Yogesh J on 19-Jan-2016
				
		function callDetail(itemid,showdrilldowns,intShowCT)
		{
			
			if (showdrilldowns == 1)
			{				
				
			    //Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'CRM_CounterGraphs.aspx/GenrateURLToken_RequestSLA_OnClick',
			        data: JSON.stringify({ itemid: itemid, EmployeeID: "<%=Session("intUserID")%>" }),
		        success: function (Result) {
		            window.open("CRM_DrillDown_Detail.aspx?CRMFilterID=<%=m_lngFilterID%>&Mode=<%=m_strMode%>&colname=&colvalue=&FromWhere=&DashboardID=153&ItemID=" + itemid + "&PKToken=" + Result.d + "&ShowCT=0", "_drillDown", "top=55,left=100,width=800,height=400,scrollbars=no,resizable=yes");
		        },
		        error: function () {
		           // alert("Error")
		        }
		    });
			   
			    //End of addition by Yogesh J on 19-Jan-2016
			 //   window.open("CRM_DrillDown_Detail.aspx?CRMFilterID=<%=m_lngFilterID%>&Mode=<%=m_strMode%>&colname=&colvalue=&FromWhere=&DashboardID=153&ItemID=" + itemid + "&ItemID=" + Result.d + "&ShowCT=0", "_drillDown", "top=55,left=100,width=800,height=400,scrollbars=no,resizable=yes");
				
			}
			window.status = "View drill downs"
		}
					
	</SCRIPT>
		
	</body>
</HTML>
