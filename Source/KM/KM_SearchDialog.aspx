<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_SearchDialog.aspx.vb" Inherits="PbNIT.KM_SearchDialog" ValidateRequest="False" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
  <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>



<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmKMSearch" method="post" runat="server">
		<%WritePage%>
    </form>
  </body>
</html>
<script language="javascript">
// =============================== Common To all Mode=====================//

	<%=m_strClientSideScript%>
	
	var objForm, objdivlist, objFocus;
	
	objForm = GetFormReference('frmKMSearch');
	objFocus = GetObjectReference('frmKMSearch','txtFreeText');
	setFocus(objFocus);

	objdivlist = GetObjectReference('frmKMSearch','divList');
	
	        <%' Added By SonalD on 13th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>
	
	function window_onload()
	{
		var intDivHeight ;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 05 Jully,2006 for WhizibleSEM Issue ID.4168

		if(navigator.appName == 'Netscape')
		{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 75;
		}
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';	
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';		
	}
// =============================== Common To all Mode =====================//
	function ClearSearch_OnClick()
	{
		// PURPOSE: To clear the previous search.
		objForm.action = "KM_SearchDialog.aspx?Action=<%=ACTION_CLEAR_SEARCH%>";
		objForm.submit();		
	}
	
	function SelectEmployee(strFor)
	{
		// PURPOSE: To display the Employee Selection dialog.
		var strFormName, strTextBox, strIdControl;
		
		strFormName = "frmKMSearch";
		if(strFor == "Contributor")
		{
			strTextBox = "txtContributorName";
			strIdControl = "txtContributorID";
		}
		else if(strFor == "Authentication")
		{
			strTextBox = "txtAuthenticatorName";
			strIdControl = "txtAuthenticatorID";
		}
		window.open("../HR/HR_EmployeeSelection.aspx?FromWhere=KM&Form=" + strFormName + "&ValueControl=" + strTextBox + "&IDControl=" + strIdControl ,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=750,height=300");
	}
	
	function chkAll_OnClick()
	{
		// PURPOSE: To disable / enable all other search parameters for the free text search when "ALL" is checked / uchecked.				
		var objchkAll;
		var objchkTitle, objchkCode, objchkExample, objchkComments;
		var objchkPrerequisites, objchkApplication, objchkAttachmentName;
		
		objchkAll = GetObjectReference('frmKMSearch', 'chkAll');
		objchkTitle = GetObjectReference('frmKMSearch', 'chkTitle');
		objchkCode = GetObjectReference('frmKMSearch', 'chkCode');
		objchkExample = GetObjectReference('frmKMSearch', 'chkExample');
		objchkComments = GetObjectReference('frmKMSearch', 'chkComments');
		objchkPrerequisites = GetObjectReference('frmKMSearch', 'chkPrerequisites');
		objchkApplication = GetObjectReference('frmKMSearch', 'chkApplication');
		objchkAttachmentName = GetObjectReference('frmKMSearch', 'chkAttachmentName');

		if(frmKMSearch.chkAll.checked == true)
		{
			objchkTitle.disabled = true;
			objchkCode.disabled = true;
			objchkExample.disabled = true;
			objchkComments.disabled = true;
			objchkPrerequisites.disabled = true;
			objchkApplication.disabled = true;
			objchkAttachmentName.disabled = true;
		}
		else
		{
			objchkTitle.disabled = false;
			objchkCode.disabled = false;
			objchkExample.disabled = false;
			objchkComments.disabled = false;
			objchkPrerequisites.disabled = false;
			objchkApplication.disabled = false;
			objchkAttachmentName.disabled = false;
		}
	}
	
	function ClearContributor_OnClick()
	{
		// PURPOSE: To clear the contributor text box.
		var objContributorId, objContributorName;
		
		objContributorId = GetObjectReference('frmKMSearch', 'txtContributorID');
		objContributorName = GetObjectReference('frmKMSearch', 'txtContributorName');
		objContributorId.value = "";
		objContributorName.value = "";			
	}
	
	function ClearAuthenticator_OnClick()
	{
		// PURPOSE: To clear the authenticator text box.
		var objAuthenticatorId, objAuthenticatorName;
		
		objAuthenticatorId = GetObjectReference('frmKMSearch', 'txtAuthenticatorID');
		objAuthenticatorName = GetObjectReference('frmKMSearch', 'txtAuthenticatorName');
		objAuthenticatorId.value = "";
		objAuthenticatorName.value = "";			
	}
	
	function Search_OnClick()
	{
		var objFreeText, objSubmission_FromDate, objSubmission_ToDate;
		var objAuthentication_FromDate, objAuthentication_ToDate;
		var objchkTitle, objchkCode, objchkExample, objchkComments;
		var objchkPrerequisites, objchkApplication, objchkAttachmentName, objchkAll;
		
		objchkTitle = GetObjectReference('frmKMSearch', 'chkTitle');
		objchkCode = GetObjectReference('frmKMSearch', 'chkCode');
		objchkExample = GetObjectReference('frmKMSearch', 'chkExample');
		objchkComments = GetObjectReference('frmKMSearch', 'chkComments');
		objchkPrerequisites = GetObjectReference('frmKMSearch', 'chkPrerequisites');
		objchkApplication = GetObjectReference('frmKMSearch', 'chkApplication');
		objchkAttachmentName = GetObjectReference('frmKMSearch', 'chkAttachmentName');
		objchkAll = GetObjectReference('frmKMSearch', 'chkAll');
		
		objFreeText = GetObjectReference('frmKMSearch', 'txtFreeText');
		objSubmission_FromDate = GetObjectReference('frmKMSearch', 'txtSubmission_FromDate');
		objSubmission_ToDate = GetObjectReference('frmKMSearch', 'txtSubmission_ToDate');
		objAuthentication_FromDate = GetObjectReference('frmKMSearch', 'txtAuthentication_FromDate');
		objAuthentication_ToDate = GetObjectReference('frmKMSearch', 'txtAuthentication_ToDate');
		
		if(isBlank(objFreeText.value) == false)
		{
			if((objchkTitle.checked == false) && (objchkCode.checked == false) &&
				(objchkExample.checked == false) && (objchkComments.checked == false) &&
				(objchkPrerequisites.checked == false) && (objchkApplication.checked == false) &&
				(objchkAttachmentName.checked == false) && (objchkAll.checked == false))
			{
				alert("<%=MyBase.GetResourceString("SELECT_ITEMS")%>");
				return;
			}	
		}

		// Validation : The 'From' date of the submission period cannot be a future date.
		if(compareDates(objSubmission_FromDate.value, getDate1(1))==1)
		{
			alert("<%=MyBase.GetResourceString("SUBMISSION_FROMDATE_FUTURE", False)%>");
			return;
		}
			
		// Validation : The 'To' date of the submission period cannot be a future date.
		if(compareDates(objSubmission_ToDate.value, getDate1(1))==1)
		{
			alert("<%=MyBase.GetResourceString("SUBMISSION_TODATE_FUTURE", False)%>");
			return;
		}

		// Validation : The 'From' date of the submission period cannot be greater than the 'To' date of the submission period.
		if(compareDates(objSubmission_FromDate.value, objSubmission_ToDate.value)==1)
		{
			alert("<%=MyBase.GetResourceString("SUBMISSION_FROMDATE_LESS_TODATE", False)%>");
			return;
		}
	
		if(objAuthentication_FromDate && objAuthentication_ToDate)
		{
			// Validation : The 'From' date of the authentication period cannot be a future date.
			if(compareDates(objAuthentication_FromDate.value, getDate1(1))==1)
			{
				alert("<%=MyBase.GetResourceString("AUTHENTICATION_FROMDATE_FUTURE", False)%>");
				return;
			}
				
			// Validation : The 'To' date of the authentication period cannot be a future date.
			if(compareDates(objAuthentication_ToDate.value, getDate1(1))==1)
			{
				alert("<%=MyBase.GetResourceString("AUTHENTICATION_TODATE_FUTURE", False)%>");
				return;
			}

			// Validation : The 'From' date of the authentication period cannot be greater than the 'To' date of the authentication period.
			if(compareDates(objAuthentication_FromDate.value, objAuthentication_ToDate.value) == 1)
			{
				alert("<%=MyBase.GetResourceString("AUTHENTICATION_TODATE_FUTURE_FROMDATE_LESS_TODATE", False)%>");
				return;
			}
		}
		// Cleanup routine : If no text is specified, then uncheck all the check boxes.
		if(isBlank(objFreeText.value) == true)
		{
			objchkTitle.checked = false;
			objchkCode.checked = false;
			objchkExample.checked = false;
			objchkComments.checked = false;
			objchkPrerequisites.checked = false;
			objchkApplication.checked = false;
			objchkAttachmentName.checked = false;
			objchkAll.checked = false;
			chkAll_OnClick();
		}
		 
		objForm.action = "KM_SearchDialog.aspx?Action=<%=ACTION_SEARCH%>";
		objForm.submit();		
	}
</Script>