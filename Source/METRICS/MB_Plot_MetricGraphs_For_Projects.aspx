<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MB_Plot_MetricGraphs_For_Projects.aspx.vb" Inherits="PbNIT.MB_Plot_MetricGraphs_For_Projects"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Project Metrics")%>
	<%MyBase.InitializeResources("AppResourcePPM.MB_Plot_MetricGraphs_For_Projects", "AppResourcePPM")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Bharat T on 15th-Oct-2015*/
    #PopUpDiv
    {   
        top:24px;
        width:400px;
    }
    /*End of Added By Bharat T on 15th-Oct-2015*/
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>
    <%--Commented And Added By Usha Pandit On 26.05.2020 For adding scroll to check large data--%>
    <%--<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">--%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()" style="overflow: scroll;">
        <%--End Of Added By Usha Pandit On 26.05.2020 For adding scroll to check large data--%>
		<form id="frmProjectMetrics" method="post" runat="server">
			<%PageInit%>
			<DIV id = PopUpDiv class='ContextMenu' style="display: none;border-left: black 2px solid; border-bottom:black 1px solid; border-right: black 1px solid; border-top: black 1px solid;text-align: center;vertical-align: middle"></DIV>
		
	    <div id=fillDiv style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%"></div>
	    </form>
		<script>
		
			document.getElementById("PopUpDiv").style.display="none";
//			document.getElementById("fillDiv").style.display="none";
//            document.getElementById('fillDiv').style.visibility="";
			var strMode = '<%=m_strMode%>';
			var objfrm = GetFormReference('frmProjectMetrics');
			if (strMode!='PRINT') 
				objdivlist = GetObjectReference('frmProjectMetrics','DivList');
			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var msg;
				if ((strMode!='PRINT')&& objdivlist != null)//
				{
                    //Commented Added by Shamkant S on 21 Jan 2016
				   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
				    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
					//if (intDivHeight < 100) intDivHeight = 70;
				    if (intDivHeight < 100) intDivHeight = 100;
				    //Commented and added by Yogesh J on 11/12/2015
				    //objdivlist.style.height = intDivHeight-10;	
					//objdivlist.style.height = intDivHeight - 10 + 'px';
				    objdivlist.style.height = intDivHeight + 'px';
                    //Commented Ended By Shamkant S on 21 Jan 2016
				}
			}
			function window_onresize()		
			{
				var intDivHeight;
				var intDivHeightRisk;
				if ( (strMode!='PRINT')&& objdivlist != null)//
				{
				    //Commented Added by Shamkant S on 21 Jan 2016
				    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
				    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
					if (intDivHeight < 100) intDivHeight = 100;
				    //Commented and added by Yogesh J on 11/12/2015
					//objdivlist.style.height = intDivHeight;
					objdivlist.style.height = intDivHeight + 'px';
				    //Commented Ended By Shamkant S on 21 Jan 2016
				}
			}
			
			function Back_OnClick()
			{
					frmProjectMetrics.document.location.href ="../General/CommonList.aspx?FromWhere=SM&MasterTagID=2143"
			}
			
			function Help()
			{
				OpenHelpPage(2141);
			}
			function ZoomClick(strUrl)
			{
				window.open(strUrl,"" ,"resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,width=800,height=600,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-600)/2);
				
			}
			function Back_OnClick()
			{
				   window.location.href = "../Metrics/ProjectBreakUp_MasterSelection.aspx?MasterTagID=2519&FromWhere=PM";
			}
			
			function PrintPreview_OnClick()
			{
				var strUrl = "";
				var strProjectID = '<%=m_lngProjectID.ToString%>';
				var showGraph= '<%=m_GraphDisplay%>';
				var fromwhere ='<%=m_strFromWhere%>';
				strUrl = "../METRICS/MB_Plot_MetricGraphs_For_Projects.aspx?mode=PRINT&FromWhere="+ fromwhere +"&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ProjectID_PK=" + strProjectID + "&ProjectID=" + strProjectID + "&ShowGraph=" + showGraph;
				window.open(strUrl,"" ,"resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,width=775,height=500,left=" + (window.screen.width)/30 + ",top=" + (window.screen.height/4));
			}
			function Print_OnClick()
			{
				window.print('tblPrint');
			}
			function Project_Metric_Report(ProjectID)
			{
				var mode="<%=strMetricView%>";
				if(mode=='Weekly')
				{
				w = window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=2128&FromWhere=MB&MasterTagId=2146&UNIQUEID=" + ProjectID ,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=600,height=450")
				}
				else
				{
				w = window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1101&FromWhere=MB&MasterTagId=2146&UNIQUEID=" + ProjectID ,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=600,height=450")
				}
			}
			
          <%'Added by Archanan on 9-Apr-2010 ///To calidate and save metrics  order number %>
			
			function CloseDiv_OnClick()
            {
                document.getElementById("PopUpDiv").style.display="none";                 
                document.getElementById('DivList').style.filter="alpha(opacity=100)";   	
                document.getElementById('DivList').style.zIndex="1000";
            }
            
            function ChangeOrder()
            {                
               // var strHTML = "<%=m_strHTMLDiv%>";
                objDivpopup = document.getElementById("PopUpDiv");
                objDivpopup.innerHTML = "<%=m_strHTMLDiv%>"                
                objDivpopup.style.display  = '';
               // objDivpopup.style.visibility="";
                objDivpopup.style.top = 30;
                //Modified by Bharat T on 15th-Oct-2015
                objDivpopup.style.left='32%'; 
                //End of Modified by Bharat T on 15th-Oct-2015
                objDivpopup.style.width=400;   
                document.getElementById('DivList').style.filter="alpha(opacity=30)";   	                
                document.getElementById('DivList').style.zIndex = "100";
            }
            
            function SaveOrderNo_OnClick()            
            {
                var cnt= "<%=m_intCnt%>";
                for(i=0;i<cnt;i++)
                {
                    objOrderNo = GetObjectReference('frmProjectMetrics','txtOrderNo_'+i);
                    if (disallowNonNumeric(objOrderNo,'Please enter only positive numeric values !!!',false))
                    {
                        setFocus(objOrderNo);
                        return; 
                    }
                    if (disallowNegativeInteger(objOrderNo,'Please enter only positive numeric values !!!',false))
                    {
                        setFocus(objOrderNo);
                        return; 
                    }
                    if (parseInt(objOrderNo.value)==0)
                    {
                        alert("Order Number should be greater than zero(0).")
                        setFocus(objOrderNo);
                        return;
                    }
                    for(next=0;next<cnt;next++)
                    {
                        if (next!=i)
                        {
                            objOrderNo1 = GetObjectReference('frmProjectMetrics','txtOrderNo_'+next);
                            if(parseInt(objOrderNo.value) == parseInt(objOrderNo1.value))
                            {
                                alert("Order Number '" + parseInt(objOrderNo.value) + "' already exists.")
                                setFocus(objOrderNo1);
                                return;
                            }
                        }
                    }
                    if (disallowBlank(objOrderNo,"Order Number should not be left blank.",true))
                    {
                        setFocus(objOrderNo);
                        return;
                    }
                }
                //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }
                setFrameLoader();
                //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
                objfrm.action = '../Metrics/MB_Plot_MetricGraphs_For_Projects.aspx?mode=Save'
                objfrm.submit();                
            }
            
            <%'Added by Archanan on 9-Apr-2010 ///To calidate and save metrics order number %>
            
            
		</script>
	</body>
</HTML>
