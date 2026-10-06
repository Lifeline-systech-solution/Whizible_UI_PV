<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Alerts_Configure.aspx.vb" Inherits="PbNIT.Alerts_Configure" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
	<%CommonFunctions.General.PlotPageHeadTag("")%> 
	<HEAD>
		<title>Set Alerts</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<script language='javascript' src='../General/CommonFunctions.js'></script>
		<script language='javascript' src='../General/CommonValidations.js'></script>
		<%CommonFunctions.General.PlotPageHeadTag("Set Alerts")%>
        <%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
 <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
     
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="FrmConfigureAlerts" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script language="Javascript">
		var objform;
		var objdivlist;
		var objTask;
		var objReview;
		var objHelpRequest;
		var objDeliverable;
		var objChkTask;
		var objChkReview;
		var objChkHelpRequest;
		var objChkDeliverable;
		
		//Added by MrugajaB on 3rd Jan 2006 for PMLifeline 
		var objchkCustomer;
		var objCustomer;
		//End Addition
				
		objform = GetFormReference('FrmConfigureAlerts');
		objdivlist = GetObjectReference('FrmConfigureAlerts','divList');
		objTask = GetObjectReference('FrmConfigureAlerts', 'txtTask');
		objReview = GetObjectReference('FrmConfigureAlerts','txtReview');
		objHelpRequest = GetObjectReference('FrmConfigureAlerts','txtHelpRequest');
		objDeliverable = GetObjectReference('FrmConfigureAlerts','txtDeliverable');
		
		objChkTask = GetObjectReference('FrmConfigureAlerts','chkTask');
        objChkReview = GetObjectReference('FrmConfigureAlerts','chkReview');
        objChkHelpRequest = GetObjectReference('FrmConfigureAlerts','chkHelpRequest');
        objChkDeliverable = GetObjectReference('FrmConfigureAlerts','chkDeliverable');
        
        //Added by MrugajaB on 3rd Jan 2006 for PMLifeline 
        objchkCustomer = GetObjectReference('FrmConfigureAlerts','chkCustomer');
		//objCustomer= GetObjectReference('FrmConfigureAlerts','lstCustomer');
		objchkHelpDeskRequestAfter= GetObjectReference('FrmConfigureAlerts','chkHelpRequestAfterFlag');
		objHelpDeskRequestAfter= GetObjectReference('FrmConfigureAlerts','txtHelpRequestAfter');
		//End Addition

        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		    //document.getElementById("chkTask").onchange = function () { if (objChkTask.checked== false)
		    //{
		    //    objTask.value = 0 
		    //    objTask.disabled = true
		    //}
		    //else
		    //{
		    //    objTask.disabled = false
		    //}  }
		function Save_OnClick()
		{
			if (validate() == true)
			{
			
			if (objChkTask.checked== true)
			{
			objChkTask = 1 
			}
			else
			{
			objChkTask = 0 
			}
			if (objChkReview.checked== true)
			{
			objChkReview = 1 
			}
			else
			{
			objChkReview = 0 
			}
			if (objChkHelpRequest.checked== true)
			{
			objChkHelpRequest = 1 
			}
			else
			{
			objChkHelpRequest = 0 
			}
			if (objChkDeliverable.checked== true)
			{
			objChkDeliverable = 1 
			}
			else
			{
			objChkDeliverable = 0 
			}
			
			//Added by MrugajaB on 3rd Jan 2006 for PMLifeline
			if (objchkCustomer != null)
			{
				if (objchkCustomer.checked== true)
				{
					objchkCustomer = 1 
				}
				else
				{
					objchkCustomer = 0
				}
			}
			else
			{
				objchkCustomer = 0 
			}
			
			if (objchkHelpDeskRequestAfter != null)
			{
				if (objchkHelpDeskRequestAfter.checked== true)
				{
					objchkHelpDeskRequestAfter = 1 
				}
				else
				{
					objchkHelpDeskRequestAfter = 0
				}
			}
			else
			{
				objchkHelpDeskRequestAfter = 0 
			}
			//End Addition
				//Modified by MrugajaB on 3rd Jan 2006 for PMLifeline
			    objform.action = "Alerts_Configure.aspx?Action=Save&Task="+ objChkTask + "&Review="+ objChkReview + "&HelpRequest=" + objChkHelpRequest + "&Deliverable=" + objChkDeliverable + "&HelpRequestAfterFlag=" + objchkHelpDeskRequestAfter + "&Customer=" + objchkCustomer;
			    //End Modification
			    objform.submit();
			}
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function Help_OnClick()
		{	
			window.open ("../General/Help.aspx?HelpID=Tracking","_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
		}
		
		function validate()
		{
			
			if (disallowBlank(objTask,"Enter Alert Days for Task",true)) return false;
			if (disallowBlank(objReview,"Enter Alert Days for Review",true)) return false;
			if (disallowBlank(objHelpRequest,"Enter Alert Days for HelpRequest",true)) return false;
			if (disallowBlank(objDeliverable,"Enter Alert Days for Deliverable",true)) return false;
			if (disallowNonInteger(objTask,"Enter Numbers Only !",true)) return false;
			if (disallowNonInteger(objReview,"Enter Numbers Only !",true)) return false;
			if (disallowNonInteger(objHelpRequest,"Enter Numbers only !",true)) return false;
			if (disallowNonInteger(objDeliverable,"Enter Numbers only !",true)) return false;
			if (disallowNegativeInteger(objTask,"Enter Positive Numbers Only !",true)) return false;
			if (disallowNegativeInteger(objReview,"Enter Positive Numbers Only !",true)) return false;
			if (disallowNegativeInteger(objHelpRequest,"Enter Positive Numbers only !",true)) return false;
			if (disallowNegativeInteger(objDeliverable,"Enter Positive Numbers only !",true)) return false;
		    //Added By Chakshuta H on 16th-Oct-2015 Purpose::QA issue fixing
            if (disallowBlank(objHelpDeskRequestAfter,"Enter Alert Days for HelpRequest",true)) return false;
            //Added By Chakshuta H on 16th-Oct-2015 Purpose::QA issue fixing
			return true;
		}
		
				
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 27;//added By Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';		//Added By Nilesh g on 11/12/2015
			
			if (objchkCustomer != null)
			{
				if (objchkCustomer.checked== false)
				{
/*					objCustomer.value = 0 
					objCustomer.disabled = true*/
					objchkHelpDeskRequestAfter.checked = false
					objchkHelpDeskRequestAfter.disabled = true
				}
			}
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;//added By Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
		}
		function chkTask_Change()
		{
		    
			if (objChkTask.checked== false)
			{
			objTask.value = 0 
			objTask.disabled = true
			}
			else
			{
			objTask.disabled = false
			}
		}
		function chkReview_Change()
		{
		   
			if (objChkReview.checked== false)
			{
			objReview.value = 0 
			objReview.disabled = true
			}
			else
			{
			objReview.disabled = false
			}
		}
		function chkHelpRequest_Change()
		{
		  
		if (objChkHelpRequest.checked== false)
			{
			objHelpRequest.value = 0 
			objHelpRequest.disabled = true
			}
			else
			{
			objHelpRequest.disabled = false
			}
		}
		function chkDeliverable_Change()
		{
		   
		if (objChkDeliverable.checked== false)
			{
			objDeliverable.value = 0 
			objDeliverable.disabled = true
			}
			else
			{
			objDeliverable.disabled = false
			}
		}
		
		//Added by MrugajaB on 3rd Jan 2006 for PMLifeline
		function chkCustomer_Change()
		{
		//Code added by PrashantD on 30 May 2007 for CleanUp Activity
		//Purpose: do not show Customer link unless immediate alert is saved otherwise page will be crashed
		return;
			var objLabel_Customers = GetObjectReference('FrmConfigureAlerts','lblCustomers');		
			if (objchkCustomer.checked== false)
			{
	/*			objCustomer.value = 0 
				objCustomer.disabled = true*/
				
				objHelpDeskRequestAfter.value = 0 
				objHelpDeskRequestAfter.disabled = true
				objchkHelpDeskRequestAfter.disabled=true
				objchkHelpDeskRequestAfter.checked=false		
				
				objLabel_Customers.style.visibility = "hidden";
					
			}
			else
			{
	//			objCustomer.disabled = false
				objchkHelpDeskRequestAfter.checked=false
				objHelpDeskRequestAfter.disabled = false
				objchkHelpDeskRequestAfter.disabled=false
				
				objLabel_Customers.style.display = "block";
				objLabel_Customers.style.visibility = "visible";
			}
	}
		
		function chkHelpRequestAfter_Change()
		{
		
		if (objchkHelpDeskRequestAfter.checked== false)
			{
			objHelpDeskRequestAfter.value = 0 
			objHelpDeskRequestAfter.disabled = true
			}
			else
			{
			objHelpDeskRequestAfter.disabled = false
			}
		}
		
		//End Addition
		
		function Customer_OnClick()
		{
            //Commented and added by Nilesh g on 3/3/2016 for add PKtoken
		    //window.open("../DB/Alerts_CustomerSelection.aspx?EntryID=<%=m_lngEntryID%>&Customers=<%=m_strCustomers%>", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");
		    window.open("../DB/Alerts_CustomerSelection.aspx?EntryID=<%=m_lngEntryID%>&Customers=<%=m_strCustomers%>&PKToken=<%=m_PKToken%>", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=650,height=400");
		    //END OF Commented and added by Nilesh g on 3/3/2016 for add PKtoken
		}
		function Employees_OnClick()
		{
		    //Commented and added by Nilesh g on 3/3/2016 for add PKtoken
			//window.open("../DB/Alerts_EmployeeSelection.aspx?EntryID=<%=m_lngEntryID%>&Customers=<%=m_strCustomers%>", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");
		    window.open("../DB/Alerts_EmployeeSelection.aspx?EntryID=<%=m_lngEntryID%>&Customers=<%=m_strCustomers%>&PKToken=<%=m_PKToken%>", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=650,height=400");
		    //END OF Commented and added by Nilesh g on 3/3/2016 for add PKtoken
		}
        </script>
	</body>
</HTML>
