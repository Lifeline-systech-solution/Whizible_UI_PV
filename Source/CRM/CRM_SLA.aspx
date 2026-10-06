<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_SLA.aspx.vb" Inherits="PbNIT.CRM_SLA"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Help-desk SLA")%>	

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
    /*Commented by Shamkant  for show footer menu on 4/11/2015 */
    .footerMenuTable
    {
        position: absolute;
        bottom: 0px;
        
        left:0px;
        /*display: table !important;
        /* margin-bottom:9px; Modified by swapnil for show footer menu on 3/11/2015 */
		
    }
     /*Commented Ended by Shamkant  for show footer menu on 4/11/2015 */
</style>
 
<script type="text/javascript">
   
   
    $(document).ready(function () {
        setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader

        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
	
<BODY class=clsBody  MS_POSITIONING="GridLayout" onload="window_onload()" onresize = "window_onresize()">
      <FORM id=frmSLA method=post runat="server" style="height:600px; overflow:auto" > 
            <% WritePage() %>         
			<DIV id="divGraphs" style='width:100%;'>
			<table cellspacing="0" align="middle" class="clsTable" id="tblGraphs" cellPadding="0" runat="server">
			</table>
		</DIV><DIV></DIV></DIV>
			<%=m_strMenu%>
	</FORM>
       <link href="../General/loaderStylesheet.css" rel="stylesheet" />
 
	<script>
	    window.onload = function () {
	        RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
	    }
		var objform;
		var objdivMain;
		
		objform = GetFormReference('frmSLA');
		objdivMain = GetObjectReference('frmSLA','DivMain');
		objdivGraph = GetObjectReference('frmSLA','divGraphs');
		//objDivAgeing = GetObjectReference('frmSLA','DivAgeing');
		
		//objdivGraph.style.height = "60%";	
		//objDivAgeing.style.height = "40%";	
				
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
			//intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 30;

			//if (intDivHeight < 100)	intDivHeight = 100;
			//if(navigator.appName == 'Netscape')
			//{
			//intDivHeight = document.body.offsetHeight - objdivMain.offsetTop + 80 ;
			//}
			intDivHeight = window.innerHeight - objdivMain.offsetTop - 25;
			if (intDivHeight < 100) intDivHeight = 100;
			objdivMain.style.height = intDivHeight + 'px';	//Added By Nilesh g on 11/12/2015
			document.getElementById("DivMain").removeAttribute("position")
			//objdivGraph.style.height = intDivHeight;		
		}
		
		function window_onresize()
		{
			var intDivHeight;
			var intDivHeightRisk;
			UpdateWindowSize();
						
		    //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 30;
			intDivHeight = window.innerHeight - objdivMain.offsetTop - 25;

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
			//objdivGraph.style.height = intDivHeight;		
				
		
		}
			function ShowSLADetails(SubRequestTypeID,MonthID)
			{			
				window.open ("CRM_SLADetails.aspx?FromGraph=0&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&SubRequestTypeID=" + SubRequestTypeID + "&MonthID=" + MonthID + "&FilterID=<%=m_filterID%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
			}	
			
				
			function ShowSLACategorywiseDetails(CategoryID,colname, colvalue,Series)
			{			
				window.open ("CRM_SLADetails.aspx?FromGraph=1&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&CategoryID=" + CategoryID + "&Month=" + colvalue + "&FilterID=<%=m_filterID%>&Series=" + Series,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
			}	
			
			function ShowRequestDetails(colname, colvalue,Series)
			{			
				window.open ("CRM_SLADetails.aspx?FromGraph=0&FromAgeingGraph=1&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&Status=" + colvalue + "&FilterID=<%=m_filterID%>&Ageing=" + String(Series.charAt(Series.length-1)-1),"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
			}	
			
			
			function Prev_Onclick()
			{
			
			window.location.href = "CRM_SLA.aspx?Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>&Year=<%=m_intYear-1%>" 
			
			}
			function Next_Onclick()
			{
			
			window.location.href = "CRM_SLA.aspx?Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>&Year=<%=m_intYear+1%>" 
			
			}
			function SLAdetails_OnClick()
			{			
			    //window.open ("CRM_ShowSLADetails.aspx?Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>" ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
			    //Added by Dhanashri S on 31 Mar 2016 Purpose: To generate and validate Token
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'CRM_SLA.aspx/GenrateSLAdetailsToken',
			        data: JSON.stringify({ Year: '<%=m_intYear%>', FilterID: '<%=m_filterID%>'}),
			        success: function (Result) {
			            window.open("CRM_ShowSLADetails.aspx?Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>&PKSLAdetailsToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=800,height=400");

			        },
			        error: function () {
			            //alert("Error")
			        }
			    });

			    //End of addition by Dhanashri S on 31 Mar 2016
			}	
			
			function Ageing_OnClick()
			{
			    //window.open ("CRM_SLA.aspx?PlotAgeingGraph=1&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>&Year=<%=m_intYear%>"  ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
			    //Added by Dhanashri S on 31 Mar 2016 Purpose: To generate and validate Token
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'CRM_SLA.aspx/GenrateRequestAgeingToken',
			        data: JSON.stringify({ Year: '<%=m_intYear%>', FilterID: '<%=m_filterID%>' }),
			        success: function (Result) {
			            window.open("CRM_SLA.aspx?PlotAgeingGraph=1&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>&Year=<%=m_intYear%>&PKRequestAgeingToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=500");

			        },
			        error: function () {
			            //alert("Error")
			        }
			    });

			    //End of addition by Dhanashri S on 31 Mar 2016
				
			}
		</script>
  
    
	</BODY>
</HTML>
