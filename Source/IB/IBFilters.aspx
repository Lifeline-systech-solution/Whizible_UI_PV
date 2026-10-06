<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IBFilters.aspx.vb" Inherits="PbNIT.IB_Filters" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<%PlotPageHeadTag()%>
<%CommonFunctions.General.PlotPageHeadTag("")%>

<body class="clsBody" onresize="window_onresize()" onload="window_onload()" ms_positioning="GridLayout">

    <form id="frmIBFilters" method="post" runat="server">

        <%BuildPage()%>
    </form>

    <script language="javascript">

        //Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
        var IssueListSearchType = GetObjectReference('frmIBIssueEntry', 'IssueListSearchType');
        if (GetObjectReference('frmIBIssueEntry', 'IssueListSearchValue'))
            var IssueListSearchValue = GetObjectReference('frmIBIssueEntry', 'IssueListSearchValue').value;
	    //End of addition by ShraddhaM

	<%	dim Operation
        Operation = Request.QueryString("Operation")
        If Operation = "APPLY_FILTER" Or Operation = "CLEAR_FILTER" Then%>
        //Modified by PrashantD on 13 March 2007 for IssueID 11573
        //window.opener.location.href = 'IBIssueList.aspx?';
        //debugger;
         // Added By Dipali v On 10th June 2019 For 1st time  Filter not clear issue
        var strHref="";
        var strHrefurl = "";
         //End of Added By Dipali v On 10th June 2019 For 1st time  Filter not clear issue
       //var IsApplyFilter;
     
        if (window.opener.location.href.indexOf("ApplyFilter") != -1) {
            strHrefurl = window.opener.location.href;
           // IsApplyFilter = 0;
        }
        else {
            strHrefurl = window.opener.location.href + "&ApplyFilter=1";
           // IsApplyFilter = 1;
        }
        //End of modification by PrashantD on 13 March 2007
       /// alert(strHref);
        //if (IsApplyFilter == 1) {
        //    IssueListSearchValue = 1;
        //}
        //else {
        //   //  IssueListSearchValue = IssueListSearchValue.value;
        //}
        //debugger;
        if (window.opener.location.href.indexOf("IssueListSearchType") < 0) {
            //Commented & Added By Dipali v On 10th June 2019 For 1st time  Filter not clear issue
            //strHref = window.opener.location.href + "&IssueListSearchValue=" + IssueListSearchValue + "&IssueListSearchType=" + IssueListSearchType.value;

            strHref = strHrefurl + "&IssueListSearchValue=" + IssueListSearchValue + "&IssueListSearchType=" + IssueListSearchType.value;
            //End of Commented & Added By Dipali v On 10th June 2019 For 1st time  Filter not clear issue
            //strHref += strHrefurl;
        }
        else {
           strHref = strHrefurl + "&IssueListSearchValue=" + IssueListSearchValue + "&IssueListSearchType=" + IssueListSearchType.value;
        }
      //  alert(strHref);
        //alert(IssueListSearchValue);
        //alert(IssueListSearchType.value);
        //Addition done by suchitraP on 23-July-2007 for IssueID 14443
        //Purpose:To change the value of Filter from 'C' to 'NC'
        strHref = replaceSubstring(strHref, "Filter=C", "Filter=NC");

        strHref = replaceSubstring(strHref, "Mode=Default", "Mode=");

        window.opener.location.href = strHref;
        //End done by suchitraP on 23-July-2007 for IssueID 14443
        window.close();
	<%end if%>

        var objDivCommonFields;
        var objDivCustomFields;
        var objDivMain;

        var objTxtReportedFromDate, objtxtReportedToDate, objtxtDueFromDate, objtxtDueToDate;

        objfrmIBFilters = GetFormReference('frmIBFilters');
        objDivMain = GetObjectReference('frmIBFilters', 'DivMain');
        objDivCommonFields = GetObjectReference('frmIBFilters', 'DivCommonFields');
        objDivCustomFields = GetObjectReference('frmIBFilters', 'DivCustomFields');

        objtxtReportedFromDate = GetObjectReference('frmIBFilters', 'txtReportedFromDate');
        objtxtReportedToDate = GetObjectReference('frmIBFilters', 'txtReportedToDate');
        objtxtDueFromDate = GetObjectReference('frmIBFilters', 'txtDueFromDate');
        objtxtDueToDate = GetObjectReference('frmIBFilters', 'txtDueToDate');

        var objcboType = GetObjectReference('frmIBFilters', 'cboType');
        var objcboSubType = GetObjectReference('frmIBFilters', 'cboSubType');
        var objcboStatus = GetObjectReference('frmIBFilters', 'cboStatus');

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
    
	function ShowHideCustomFields() 
	{
		var objtdShowHide_ShowHideCustomFields = document.getElementById("tdShowHide_ShowHideCustomFields");
		var objDivCustomFields = document.getElementById("DivCustomFields");
		var strDisplay=(arguments.length>0)?arguments[0]:objDivCustomFields.style.display;
		if (strDisplay != "none") 
		{
			objDivCustomFields.style.display="none";
			objtdShowHide_ShowHideCustomFields.src='../../Images/plus.gif';
		}
		else
		{
			objDivCustomFields.style.display="";
			objtdShowHide_ShowHideCustomFields.src='../../Images/minus.gif';
		}
	}
	
	//Addition done by SuchitraP on 12-Jul-2007
	//Purpose:to show Product fields
	function ShowHideProductFields() 
	{
		var objtdShowHide_ShowHideProductFields = document.getElementById("tdShowHide_ShowHideProductFields");
		var objDivProductFields = document.getElementById("DivProductFields");
		var strDisplay=(arguments.length>0)?arguments[0]:objDivProductFields.style.display;
		if (strDisplay != "none") 
		{
			objDivProductFields.style.display="none";
			objtdShowHide_ShowHideProductFields.src='../../Images/plus.gif';
		}
		else
		{
			objDivProductFields.style.display="";
			objtdShowHide_ShowHideProductFields.src='../../Images/minus.gif';
		}
	}	
	//End of addition done by SuchitraP on 12-Jul-2007
	
	function ShowHideCommonFields() 
	{
		var objtdShowHide_ShowHideCommonFields = document.getElementById("tdShowHide_ShowHideCommonFields");
		var objDivCommonFields = document.getElementById("DivCommonFields");
		var strDisplay=(arguments.length>0)?arguments[0]:objDivCommonFields.style.display;
		if (strDisplay != "none") 
		{
			objDivCommonFields.style.display="none";
			objtdShowHide_ShowHideCommonFields.src='../../Images/plus.gif';
		}
		else
		{
			objDivCommonFields.style.display="";
			objtdShowHide_ShowHideCommonFields.src='../../Images/minus.gif';
		}
	}	
	
	//Addition done by SuchitraP on 13-July-2007
	//Purpose:To plot combo's of Product fields
	objCustomer = GetObjectReference('frmCommonPage','CustomerID');
	objProductVersionID = GetObjectReference('frmCommonPage','ProductVersionID');
	objComponentID = GetObjectReference('frmCommonPage','ComponentID');


	function Customer_OnChange()
		{	
			if (objCustomer.selectedIndex==0)
				{	
					objProductVersionID.length=0;
					objComponentID.length=0;
					
					return;
				}
				
			getCustomerComboValue('objfrmIBFilters' ,'CustomerID') ;
		
			onSelection('objfrmIBFilters','CustomerID','ProductVersionID','2133','IssueID','EDIT',<%=m_ProjectId.ToString%>);
			objComponentID.length=0;
		}	

		
		
	function ProductVersion_OnChange()
		{ 
			getCustomerComboValue('objfrmIBFilters' ,'CustomerID') ;
			
			if (objProductVersionID != null && objProductVersionID.selectedIndex==0)
			{	
				objComponentID.length=0;
				return;
			}
			
			onSelection('objfrmIBFilters','ProductVersionID','ComponentID','2133','IssueID','EDIT',<%=m_ProjectId.ToString%>);
        }

        var depCboValue;
        var objCustomerCBO;
        var objProductVersionID;

        function getCustomerComboValue(strForm, strCustomerCombo) {
            objCustomerCBO = GetObjectReference(strForm, strCustomerCombo);
        }
        function onSelection(strFrm, strCtrl, strDependentCtrl, strTagID, strPK, strMode, ProjectID) {
            var objCbo; var strUrl; var strMasterPK; var depCbo;
            var strCustomerControlValue;
            var strComponentValue;

            var ProjectID = (arguments.length > 6) ? arguments[6] : false;
            if (ProjectID == false) {
                ProjectID = '';
            }

            //strMasterPK = GetObjectReference(strFrm,strPK);

            global_strFrm = strFrm; global_strDependentCtrl = strDependentCtrl;
            objCbo = GetObjectReference(strFrm, strCtrl);
            depCbo = GetObjectReference(strFrm, strDependentCtrl);
            // Modification By NitinVS on 7 Jun 2006 
            // if the dependant control is having any value selected then only set the values else set to 0  
            if (depCbo.selectedIndex != -1)
                depCboValue = depCbo[depCbo.selectedIndex].value;
            // End Modification By NitinVS on 7 Jun 2006 
            if (objCbo != null) {
                if (objCbo.value != '0' || objCbo.value != '') {
                    strUrl = new String();

                    if (objCustomerCBO != null) {
                        strCustomerControlValue = objCustomerCBO.value;
                        if (strCustomerControlValue != 0) {
                            strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=" + strCustomerControlValue + "&MasterPKField=" + strPK + "&MasterPKValue=" + "0" + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                        }
                        else {
                            strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=0&MasterPKField=" + strPK + "&MasterPKValue=" + "0" + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                        }
                    }
                    else {
                        strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=NULL&MasterPKField=" + strPK + "&MasterPKValue=" + "0" + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                    }

                    if (objCbo.selectedIndex > -1) {
                        //INSTANTIATE XmlHttpRequest
                        // Checking if IE-specific document.all collection exists 
                        // TO SEE IF WE ARE RUNNING IN IE 
                        if (document.all) {
                            objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                            //hook the event handler
                            objXHttp.onreadystatechange = HandlerOnReadyState;
                            //prepare the call, http method=GET, false=asynchronous call
                            objXHttp.open("GET", strUrl, false);
                            //finally send the call
                            objXHttp.send();
                        }
                        else {
                            // Mozilla - based browser 
                            objXHttp = new XMLHttpRequest();
                            //hook the event handler
                            objXHttp.onreadystatechange = HandlerOnReadyState();
                            //prepare the call, http method=GET, false=asynchronous call
                            objXHttp.open("GET", strUrl, false);
                            //finally send the call
                            objXHttp.send(null);
                            alert('in ' + strUrl);
                        }
                    }
                }
            }
        }



        //End of addition By SuchitraP on 13-July-2007


        function ApplyFilter_OnClick(strOrderByField, strAscOrDesc) {
            if (disallowDate1GreaterThanDate2(objtxtDueFromDate, objtxtDueToDate,"<%=mybase.GetResourceString("DUEFROM>DUETO")%>", true))
            return;

        if (disallowDate1GreaterThanDate2(objtxtReportedFromDate, objtxtReportedToDate,"<%=mybase.GetResourceString("REPORTEDFROM>REPORTEDTO")%>", true))
                return;

            //Apply the filter

            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            setFrameLoader();
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
            objfrmIBFilters.action = "IBFilters.aspx?Operation=APPLY_FILTER&OrderBy=" + strOrderByField + "&ASCDESC=" + strAscOrDesc
            objfrmIBFilters.submit();
        }

        function Close_OnClick() {
            window.close();
        }


        function ClearFilter_OnClick(strOrderBy, strAscOrDesc) {

            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            setFrameLoader();
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
            objfrmIBFilters.action = "IBFilters.aspx?Operation=CLEAR_FILTER&OrderBy=" + strOrderBy + "&ASCDESC=" + strAscOrDesc;
            objfrmIBFilters.submit();
        }

        function window_onresize() {

            var intDivHeight;
            var intDivHeightRisk;
            //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 60;

            //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

            if (navigator.appName == 'Netscape') {
                intDivHeight = window.innerHeight - objDivMain.offsetTop - 60;
            }
            else {
                intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 60;
            }
            if (intDivHeight < 100)
                intDivHeight = 100;
            objDivMain.style.height = intDivHeight + 'px';
        }

        function window_onload() {
            var intDivHeight;
            var intDivHeightRisk;


            //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 60;
            //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

            if (navigator.appName == 'Netscape') {
                intDivHeight = window.innerHeight - objDivMain.offsetTop - 60;
            }
            else {
                intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 60;
            }
            if (intDivHeight < 100)
                intDivHeight = 100;
            objDivMain.style.height = intDivHeight + 'px';
        }

        function cboType_OnChange() {
            //If the Type is selected then ask user to select the Sub Type and Status that comes under the selected Type
            if (objcboType.value != "") {
                if ((objcboSubType.value != "") && (objcboStatus.value != ""))
                    alert("<%=mybase.GetResourceString("TYPESUBTYPESTATUS")%>");
            else if (objcboSubType.value != "")
                alert( "<%=mybase.GetResourceString("TYPESUBTYPE")%>");
            else if (objcboStatus.value != "")
                alert("<%=mybase.GetResourceString("TYPESTATUS")%>");
            }
        }

        function cboSubType_OnChange() {
            //If the Type is selected then ask user to select the Sub Type that comes under the selected Type
            if ((objcboType.value != "") && (objcboSubType.value != ""))
                alert( "<%=mybase.GetResourceString("TYPESUBTYPE")%>");
        }

        function cboStatus_OnChange() {
            //If the Type is selected then ask user to select the Status that comes under the selected Type
            if ((objcboType.value = "") && (objcboStatus.value != ""))
                alert("<%=mybase.GetResourceString("TYPESTATUS")%>");
        }


    </script>
</body>
</html>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child {
        /*width: 35%;*/
        vertical-align: middle;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
