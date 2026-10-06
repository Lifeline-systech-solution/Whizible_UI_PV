<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_WeeklyStatusReport.aspx.vb" Inherits="PbNIT.PM_WeeklyStatusReport"%>

<html>
 	<%CommonFunctions.General.PlotPageHeadTag("Weekly Status Report")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    #DivList {
        overflow:auto;
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
        //Commented And Added By Vaijat K on 02/11/2015
        //if ($('.clsgridtable').length > 0) {
        //    var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        if ($('.clsBody').find('#frmPM_WeeklyStatusReport').find('#ProjectwiseWSR').length > 0) {
            var divName = $('.clsBody').find('#frmPM_WeeklyStatusReport').find('#ProjectwiseWSR').attr('id');
            dataCollapse(divName);
        }
        //End Added By Vaijat K on 02/11/2015
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


  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPM_WeeklyStatusReport"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
	    var objform = GetFormReference('frmPM_WeeklyStatusReport');
        //COMMENTED AND ADDED BY NILESH G 
	    //var objdivlist=GetObjectReference('frmPM_WeeklyStatusReport','PageDiv');
		var objdivlist=GetObjectReference('frmPM_WeeklyStatusReport','ProjectwiseWSR');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
	    function window_onload() {

	        var intDivHeight;
	        var intDivHeightRisk;
	        
	        if (objdivlist != null) {
	            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
	            //if(navigator.appName == 'Netscape')
	            //{

	            //	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
	            //}
	            //else
	            //{
	            //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
	            //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;

	            //}

	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;
	            

	            if (intDivHeight < 100) intDivHeight = 100;
	            objdivlist.style.height = intDivHeight + 'px';
	        }
	    }
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 47 ;
		    }
		    else
		    {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;
			   
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function ShowWSR(TimeSheetNo)
		{
            //Added By Vidya J ON 1 Feb 2016
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'PM_WeeklyStatusReport.aspx/GenrateURLToken_ShowWSR',
		        data: JSON.stringify({ TimeSheetNo: TimeSheetNo, EmployeeID: "<%=Session("intUserID")%>" }),
		        success: function (Result) {
		            //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
		            //window.open("../PM/PM_WeeklyStatusReport.aspx?TimeSheetNo=" + TimeSheetNo + "&PKTokenValue=" + Result.d, "", "resizable=yes,scrollbars=yes,menubar=yes,width=800,height=530,Left=5,Top=5");
		            window.open("../PM/PM_WeeklyStatusReport.aspx?TimeSheetNo=" + TimeSheetNo + "&EmployeeID=<%=Session("intUserID")%>&PKToken=" + Result.d, "", "resizable=yes,scrollbars=yes,menubar=yes,width=800,height=530,Left=5,Top=5");
		            //End of Addition by Dhanashri S on 11 Aug 2016
		          //  window.open("../PM/PM_WeeklyStatusReport.aspx?TimeSheetNo=" + TimeSheetNo , "", "resizable=yes,scrollbars=yes,menubar=yes,width=800,height=530,Left=5,Top=5");
		             },
	                error: function () {
	                 //   alert("Error")
	                }
		    });
		    //End Of Added By Vidya J ON 1 Feb 2016
	
		}
		
		<%' Modified By NitinVS on 19 Apr 2007 for PMLifeLine SP 8 Regression Fixes IssueID 13041 Added PKToken Parameter %>
		function ShowTimeSheet(TimeSheetNo,PKToken)
		{
		    //window.open("../FA/FA_TimeSheetListing.aspx?From=WeeklyStatusReport&Mode=Details&TimeSheetNo=" + TimeSheetNo + "&PKToken=" + PKToken, "", "resizable=yes,scrollbars=no,width=800,height=530,Left=5,Top=5");
		    window.open("../FA/FA_TimeSheetListing.aspx?From=WeeklyStatusReport&Mode=Details&TimeSheetNo=" + TimeSheetNo + "&EmployeeID=<%=Session("intUserID")%>&Flag=FromWeeklyStatusReport&PKToken=" + PKToken, "", "resizable=yes,scrollbars=no,width=800,height=530,Left=5,Top=5");
		}
		<% 'End Modification  By NitinVS on 19 Apr 2007 for PMLifeLine SP 8 Regression Fixes IssueID 13041 Added PKToken Parameter %>
		//Added By VivekP On 16 Sep 2005 For PMLifeLine SP4
        function Close_OnClick()
        {
        window.close();
        }
        //End Of Addition On 16 Sep 2005 For PMLifeLine SP4
	</Script>
  </body>
</html>
