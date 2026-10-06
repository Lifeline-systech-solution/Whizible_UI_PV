<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_StatusReport.aspx.vb" Inherits="PbNIT.IB_StatusReport"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION"))%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmIB_StatusReport" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmIB_StatusReport');
		var objdivlist=GetObjectReference('frmIB_StatusReport','PageDiv');
		var ovjdivgrid= GetObjectReference('frmIB_StatusReport','DivList');
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		   
			var intDivHeight ;
			var intDivHeightRisk;
			var intToReduce;
			if (ovjdivgrid !=null) 
			{
				intToReduce=50;
			}
			else
			{
				intToReduce=40;
			}
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - intToReduce;
				//'Modified by ShraddhaM on Date 01 Jully,2006 for PMLifeLine Issue ID.4168
			if(navigator.appName == 'Netscape')
			{
                //Commented And Added By Vaijat K On 03/11/2015
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 200;
			    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 161;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop -28;//Added By Shamkant S on 23 DEC 2015
					 if (intDivHeight < 100)	intDivHeight = 100;
				}
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}	
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			var intToReduce;
			if (ovjdivgrid !=null) 
			{
				intToReduce=50;
			}
			else
			{
				intToReduce=40;
			}
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - intToReduce;
			
				if(navigator.appName == 'Netscape')
				{
				  //  intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 140;
				    intDivHeight = window.innerHeight - objdivlist.offsetTop - 28;//Added By Shamkant S on 23 DEC 2015
					 if (intDivHeight < 100)	intDivHeight = 100;
				}
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
			
		}	
	
		function ShowReport_OnClick()
		{
			//first validate the entries and then show the report if validated
			var result;
			var objFromStatus=GetObjectReference('frmIB_StatusReport','cboFromStatus');	
			result=disallowBlank(objFromStatus);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("BLANK_FROM_STATUS")%>");
				return;
			}
			var objToStatus=GetObjectReference('frmIB_StatusReport','cboToStatus');		
			result=disallowBlank(objToStatus);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("BLANK_TO_STATUS")%>");
				return;
			}
										
			var objFromDate=GetObjectReference('frmIB_StatusReport','txtFromDate');		
			var objToDate=GetObjectReference('frmIB_StatusReport','txtToDate');	
			
			if(trimString(objFromStatus.value) == trimString(objToStatus.value))
			{ 
					alert("<%=MyBase.GetResourceString("SAME_STATUS")%>");
					return;
			}
			
			if ( (trimString(objFromDate.value) == "") || (trimString(objToDate.value) == "") ) 
			{
				alert("<%=MyBase.GetResourceString("INVALID_DATE")%>");
				return;
			}
			
			if (disallowDate1GreaterThanDate2(objFromDate,objToDate)) 
			{	
					//Modified by HarshK for sp4 issueid 376  on 11/10/2005
					alert(replaceSubstring("<%=MyBase.GetResourceString("DATE_DIFF")%>","&#39;","'"));
					//End Modified by HarshK for sp4 issueid 376  on 11/10/2005
					return;
			}
			var objView=GetObjectReference('frmIB_StatusReport','cboView');		
			result=disallowBlank(objView);
			if(result==true)
			{
				alert("<%=MyBase.GetResourceString("BLANK_VIEW")%>");
				return;
			}
		    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
		   // window.open("IB_StatusReport.aspx?Action=View&cboFromStatus=" + frmIB_StatusReport.cboFromStatus.value + "&cboToStatus=" + frmIB_StatusReport.cboToStatus.value + "&txtFromDate=" + frmIB_StatusReport.txtFromDate.value + "&txtToDate=" + frmIB_StatusReport.txtToDate.value + "&cboView=" + frmIB_StatusReport.cboView.value, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=750,height=550");

		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'IB_StatusReport.aspx/GenrateURLToken_ShowReport_OnClick',
		        data: JSON.stringify({ FromStatus: frmIB_StatusReport.cboFromStatus.value, EmployeeID: "<%=Session("intUserID")%>", ToStatus: frmIB_StatusReport.cboToStatus.value, FromDate: frmIB_StatusReport.txtFromDate.value, ToDate: frmIB_StatusReport.txtToDate.value, View: frmIB_StatusReport.cboView.value }),
			        success: function (Result) {
			            window.open("IB_StatusReport.aspx?Action=View&cboFromStatus=" + frmIB_StatusReport.cboFromStatus.value + "&cboToStatus=" + frmIB_StatusReport.cboToStatus.value + "&txtFromDate=" + frmIB_StatusReport.txtFromDate.value + "&txtToDate=" + frmIB_StatusReport.txtToDate.value + "&cboView=" + frmIB_StatusReport.cboView.value+"&PKToken="+Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=750,height=550");

			        },
			        error: function () {
			          //  alert("Error")

			        }
			    });
		    //End of addition by Yogesh J on 02-Feb-2016 to generate Token
		}
	
		function Close_OnClick()
		{
			window.close() 
		}
		
		//Added By VivekP On 4 May 2005 To Add The Status Based Report
		function Show_Status_Report_OnClick() {
            //Commented and added by Yogesh J on 02-FEB
	//	window.open ("IB_IssueStatusBasedReport.aspx?ProjectID=<%=Session("IssueProject")%>","","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 390)/2 + ",width=750,height=390");
		    window.open("IB_IssueStatusBasedReport.aspx?ProjectID=<%=Session("IssueProject")%>&PKToken=<%=m_strToken%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 390) / 2 + ",width=750,height=390");

		}
		//End Of Addition
					</Script>
		
        
	</body>
</HTML>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Vaijat K On 03/11/2015*/
    .footerMenuTable
    {
    bottom:0px !important;
    position:absolute !important;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        //  document.body.style.height = window.innerHeight - 3 + 'px';
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
        document.body.style.height = window.innerHeight - 3 + 'px';
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
