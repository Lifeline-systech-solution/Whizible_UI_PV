<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
     /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
        table
        {
            width:100% !important;
        }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; 
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_TimesheetApproval.aspx.vb" Inherits="PbNIT.RT_TimesheetApproval" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
			<form id="frmTimesheetApproval" method="post" runat="server">
					
									<%PageInit()%>
						
			</form>
					<script language="javascript">

					    //Commented and Added by Dhanashri S on 7 Dec 2015 for IssueID:2030
					    //var objDivMain = GetObjectReference('frmVerifyResourceTimesheetDetails', 'DivList');
					    var objDivMain = GetObjectReference('frmVerifyResourceTimesheetDetails', 'DivMain');
					    var objDivList = GetObjectReference('frmVerifyResourceTimesheetDetails', 'DivList');
					    //End of Comment and Addition by Dhanashri S on 7 Dec 2015
			
			<%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function window_onload()		
			{
			    var browser = WhichBrowser();
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				if (browser == 'FF')
                    //Commented and Added by Dhanashri S on 7 Dec 2015 for IssueID:2030

				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 87;
				   // intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				intDivHeight = window.innerHeight - objDivMain.offsetTop - 30-34;
				else if (browser == 'IE')

			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 88;
				//intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 30-34;
				else if (browser == 'CR')
			    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 80;
			//	intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 30-34;

			        //End of Comment and Addition by Dhanashri S on 7 Dec 2015
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px';
				objDivList.style.height = intDivHeight - 150 + 'px';
				
				
			}
			function WhichBrowser() {

			    var brwser = '';
			    var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
			    if (/trident/i.test(M[1])) {
			        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
			        //return 'IE '+(tem[1] || '');
			        return 'IE';
			    }
			    if (M[1] === 'Chrome') {
			        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
			        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
			        brwser = 'CR';
			    }
			    else if (M[1] === 'Firefox') {
			        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
			        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
			        brwser = 'FF';
			    }
			    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
			    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
			    //return M.join(' ');
			    return brwser;
			}
			function window_onresize()		
			{
			    var browser = WhichBrowser();
				var intDivHeight ;
				var intDivHeightRisk;
				if (browser == 'FF')
				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 87;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;

				else if (browser == 'IE')
				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 88;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				else if (browser == 'CR')
				    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 80;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 30;
				if (intDivHeight < 100)
				    intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px';
				objDivList.style.height = intDivHeight - 150 + 'px';
			}
			// ParagD 13-Sept
			//function Approve_OnClick(sortby,sortorder)
			function Approve_OnClick(sortby,sortorder)
			{
				var objVerify;
				var intctr;
				var objForm;
				var strVal; 
				var bSubmit; 
				bSubmit = false; 
				objForm = GetFormReference('frmTimesheetApproval');
				objVerify = GetObjectReference('frmTimesheetApproval','chkApprove',true); 
				if(objVerify!=null) 
				{ 
					if(objVerify.length == 0)
					return;
					if(objVerify.length > 1)
					{ 
						for(i=0;i<=objVerify.length-1;i++)
						{ 
							if (objVerify[i].checked == true) 
							{ 
								bSubmit = true; 
								break; 
							} 
						} 
					} 
					else 
					{ 
						if (objForm.chkApprove.checked == true) 
						bSubmit = true; 
					} 
					if (bSubmit==true) 
					{ 
						var bConfirmed; 
						bConfirmed = window.confirm('Do you want to approve the selected Timesheets?');
						if (bConfirmed == false) 
						return;
						else 
						{
							objForm.action='RT_TimesheetApproval.aspx?Verify=True&sortby=' + sortby + '&sortorder=' + sortorder;
							objForm.submit();
						} 
					} 
					else 
					{ 
						alert('Please select the Timesheet to approve.')  
						return; 
					} 
				} 
				return; 

			}
			function SelectAll_OnClick()
			{
				var objchkApprove;
				var intIndex;
				objchkApprove = GetObjectReference('frmTimesheetApproval','chkApprove',true);
				for(intIndex=0 ;intIndex < objchkApprove.length ;intIndex++)
				{
					if (objchkApprove[intIndex].disabled == false )
					objchkApprove[intIndex].checked=true;
				}

			}
			function ClearAll_OnClick()
			{
				var objchkApprove;
				var intIndex;
				objchkApprove = GetObjectReference('frmTimesheetApproval','chkApprove',true);
				for(intIndex=0 ;intIndex < objchkApprove.length ;intIndex++)
				{
					if (objchkApprove[intIndex].disabled == false )
					objchkApprove[intIndex].checked=false;
				}
			}
			function ShowHelp()
			{
				//OpenHelpPage(2125)
				window.open("../General/Help.aspx?HelpID=2125","","resizable=yes,scrollbars=yes,Left=0,Top=0,height=250,width=250");
			}
			function Sort_OnClick(sortby,sortorder)
			{
				var objform;	
				objform = GetFormReference('frmTimesheetApproval');
				objform.action = "RT_TimesheetApproval.aspx?sortby=" + sortby + "&sortorder=" + sortorder;
				objform.submit();
			}
			function Filter_OnClick()
			{
				var objform;	
				objform = GetFormReference('frmTimesheetApproval');
				objform.action = "RT_TimesheetApproval.aspx";
				objform.submit();
			}
			function Employee_OnClick(TimesheetID,EmployeeID,TimesheetStatus)
			{
				/*var objform;	
				objform = GetFormReference('frmTimesheetApproval');
				objform.action = "../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + TimesheetID + "&EmployeeID=" + EmployeeID + "&TimesheetStatus=" + TimesheetStatus;
				objform.submit();*/
				window.location ="../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + TimesheetID + "&EmployeeID=" + EmployeeID + "&TimesheetStatus=" + TimesheetStatus;
			}
			
			</script>
		</body>
</HTML>
