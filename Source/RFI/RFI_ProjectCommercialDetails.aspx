<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RFI_ProjectCommercialDetails.aspx.vb" Inherits="PbNIT.RFI_ProjectCommercialDetails"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><html>
  <%call drawPageHeader()%>
  <body class="clsPageBody" MS_POSITIONING="GridLayout" onload="window_Onload()" onresize="window_OnResize()">
    <form id="frmRFI_ProjectCommercialDetails" method="post" runat="server">
		<%call PageInit()%>
    </form>
<script language="javascript">
  	var frm;
	var objPageDiv ;
	frm = GetFormReference("frmRFI_ProjectCommercialDetails");
	objPageDiv = GetObjectReference("frmRFI_ProjectCommercialDetails","PageDiv");
	
	    <%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
	
function window_OnResize()		
	{
		var intDivHeight ;
		var intDivHeightRisk;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 37;
		}
		else{
		intDivHeight = window.innerHeight - 37;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
				
		objPageDiv.style.height = intDivHeight	;
	}	
	function window_Onload()		
	{
		var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 37;
		}
		else{
		intDivHeight = window.innerHeight - objPageDiv.offsetTop - 37;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objPageDiv.style.height = intDivHeight	;
		setFoucsonFirstcontrol();
	}  
	
	function Save_OnClick()
	{
		if(validateControls()==false)
			return;
		objRateFor = GetObjectReference('frmCommonPage','RateFor');		
		frm.action = "../RFI/RFI_ProjectCommercialDetails.aspx?FromWhere=PM&MasterTagID=1087&ACTION=SAVE&RateFor=" + objRateFor.value;
		frm.submit();	
	}
	
	function validateControls()
	{
		objCeilingAmount = GetObjectReference('frmCommonPage','CeilingAmount');
		objBasisOfRate  = GetObjectReference('frmCommonPage','BasisOfRate');
		objRateMethod  = GetObjectReference('frmCommonPage','RateMethod',true);
		objHoursPerDay  = GetObjectReference('frmCommonPage','HoursPerDay');		
		objHoursPerMonth  = GetObjectReference('frmCommonPage','HoursPerMonth');
		objRateForID  = GetObjectReference('frmCommonPage','RateForID',true);
		objRate  = GetObjectReference('frmCommonPage','Rate',true);
		objRateFor = GetObjectReference('frmCommonPage','RateFor');		

	if ( objRateForID == null) 
		return true;
			
	if ( objRateFor.value =="2" || objRateFor.value =="3"  )		
	{
		if (disallowBlank(objCeilingAmount,'&#39;Ceiling Amount&#39; should not be left blank.',true) )
		{ return false; }

		if (disallowNegativeNumeric(objCeilingAmount,'Please enter only positive numeric value for &#39;Ceiling Amount&#39;',true))
		{ return false; }

		if (disallowMaxlengthViolation(objBasisOfRate,300,'Max Length of this field is 300 characters.',true))
		{ return false; }

		if (disallowBlank(objHoursPerDay,'&#39;Hours Per Day&#39; should not be left blank.',true) )
		{ return false; }

		if (disallowNegativeNumeric(objHoursPerDay,'Please enter only positive numeric value for &#39;Hours Per Day&#39;',true))
		{ return false; }

		if (disallowValueRangeViolation(objHoursPerDay,1,24,'The value of &#39;Hours Per Day&#39; should be in the range of (1-24).',true))
		{ return false; }

		if (disallowBlank(objHoursPerMonth,'&#39;Hours Per Month&#39; should not be left blank.',true) )
		{ return false; }

		if (disallowNegativeNumeric(objHoursPerMonth,'Please enter only positive numeric value for &#39;Hours Per Month&#39;',true))
		{ return false; }

		if (disallowMinValueViolation(objHoursPerMonth,1,'The value of &#39;Hours Per Month&#39; should not be less than 1.',true))
		{ return false; }

		if (disallowMinValueViolation(objHoursPerMonth,objHoursPerDay.value,'The value of &#39;Hours Per Month&#39; should not be less than ' + objHoursPerDay.value ,true))
		{ return false; }
		
	}
	

	if(objRateForID.length==1)
	{
			if (disallowBlank( objRate ,'&#39;Rate&#39; should not be left blank.',true) )
			{ return false; }

			if (disallowNegativeNumeric(objRate,'Please enter only positive numeric value for &#39;Rate&#39;',true))
			{ return false; }	
	}
	else
	{
		for(i=0;i<objRateForID.length;i++)
		{
			if (disallowBlank( objRate[i] ,'&#39;Rate&#39; should not be left blank.',true) )
			{ return false; }

			if (disallowNegativeNumeric(objRate[i],'Please enter only positive numeric value for &#39;Rate&#39;',true))
			{ return false; }
		}	
	}
	
	return true; 		
	
	}

	function setFoucsonFirstcontrol()			
	{
		objCeilingAmount = GetObjectReference('frmCommonPage','CeilingAmount');
		if ( objCeilingAmount != null && objCeilingAmount.style.disabled != true )
		{
			objCeilingAmount.focus();
		} 
	}
	
	function History_OnClick(tagId ,UniqueID)
	{
		var ProjectID = '<%=m_ProjectID%>';
		if (tagId=="2087")
		{
			objRateContractID = GetObjectReference('frmCommonPage','RateContractID');
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=2087&UniqueID="+ ProjectID +"&ProjectID=" + ProjectID , "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}	
		if(tagId=="2058")
		{
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=1&TagID=2058&UniqueID="+ UniqueID +"&ProjectID=" + ProjectID , "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");		
		}
		if(tagId=="2059")
		{
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=1&TagID=2059&UniqueID="+ UniqueID +"&ProjectID=" + ProjectID , "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");		
		}
		if(tagId=="1060")
		{
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=1060&UniqueID="+ UniqueID +"&ProjectID=" + ProjectID , "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");		
		}				
	}
</script>   	    
</body>
</html>
	