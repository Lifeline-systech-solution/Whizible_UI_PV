<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_EmployeeSelection.aspx.vb" Inherits="PbNIT.HR_EmployeeSelection" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body ms_positioning="GridLayout" class='clsBody' onresize="window_onresize()" onload="window_onload()">
    <form id="frmEmployeeSelection" name="frmEmployeeSelection" method="post" runat="server">
        <%PageInit()%>
    </form>
</body>
<script language="javascript">
    var objdivlist;
    var objform;

    objform = GetFormReference('frmEmployeeSelection');
    objdivlist = GetObjectReference('frmEmployeeSelection', 'DivList');

    '<%MyBase.InitializeResources("AppResources.HR_EmployeeSelection", "AppResources")%>';
		    
    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
    disableRightClick();
    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

    function window_onload() {
        var intDivHeight;
        var intDivHeightRisk;

        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        //'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

        if (navigator.appName == 'Netscape') {
            intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
        }
        else {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        }
        if (intDivHeight < 100)
            intDivHeight = 100;
        objdivlist.style.height = intDivHeight +'px';
    }
    function window_onresize() {
        var intDivHeight;
        var intDivHeightRisk;
        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        //'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

        if (navigator.appName == 'Netscape') {
            intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
        }
        else {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        }
        if (intDivHeight < 100)
            intDivHeight = 100;
        objdivlist.style.height = intDivHeight +'px';
    }
    function Paging_OnClick(chr) {
        objform.action = "HR_EmployeeSelection.aspx?Alphabet=" + chr;
        objform.submit();
    }
    function Filter_OnChange() {
        objform.action = "HR_EmployeeSelection.aspx?";
        objform.submit();
    }
    function Show_OnClick() {
        objform.action = "HR_EmployeeSelection.aspx?";
        objform.submit();
    }
    function Clear_OnClick() {
        var objTxt;
        objTxt = GetObjectReference('frmEmployeeSelection', 'txtFilter');
        objTxt.value = '';

        objform.action = "HR_EmployeeSelection.aspx?";
        objform.submit();
    }
    //Modified by harshk sp4 issueid =120,121 
    function EmployeeName_OnClick(EmpID, EmpName, Per, JDate)
        //End Modified by harshk sp4 issueid =120,121 
    {
        var str, intPer;
        var strEmpName = new String(EmpName);
        strEmpName = strEmpName.replace('|||', "'");

        if ('<%=m_strFromWhere%>' == 'PM') {
				    str = new String(EmpID);
				    EmpID = str.substr(0, str.indexOf('|'));
				    str = null;
				    intPer = new Number(Per);
				    intPer = 100 - intPer;

				    //Modified By VidyaJ - Browser Issue - IssueID - 809 
				    //Commented and modified by AmrutaJ on 18-Mar-2005 for Netscape Implementation
				    //commented code works only for IE
				    /*opener.frmCommonPage.NonDatabase1.value=strEmpName;
					opener.frmCommonPage.EmployeeID.value=EmpID;
					opener.frmCommonPage.ResourcePercentage.value = intPer;*/
				    //works for IE + Netscape
				    window.opener.document.forms['frmCommonPage'].elements['NonDatabase1'].value = strEmpName
				    window.opener.document.forms['frmCommonPage'].elements['EmployeeID'].value = EmpID
				    window.opener.document.forms['frmCommonPage'].elements['ResourcePercentage'].value = intPer
				    window.opener.document.forms['frmCommonPage'].elements['NonDatabase3'].value = JDate



				    //opener.frmCommonPage.NonDatabase1.value=strEmpName;
				    //opener.frmCommonPage.EmployeeID.value=EmpID;
				    //opener.frmCommonPage.ResourcePercentage.value = intPer;
				    ////added by harshk sp4 issueid =120,121 
				    //opener.frmCommonPage.NonDatabase3.value=JDate;
				    //added by harshk sp4 issueid =120,121 
				    //End of modification
				}
				else if ('<%=m_strFromWhere%>' == 'KM') {
				    if (strControlID == 'txtAuthenticatorID') {
				        opener.frmKMSearch.txtAuthenticatorName.value = strEmpName;
				        opener.frmKMSearch.txtAuthenticatorID.value = EmpID;
				    }
				    else {
				        opener.frmKMSearch.txtContributorName.value = strEmpName;
				        opener.frmKMSearch.txtContributorID.value = EmpID;
				    }
				}
                window.close();
            }
            function Percentage_OnClick(EmpID) {
                var str;
                str = new String(EmpID);
                EmpID = str.substr(0, str.indexOf('|'));
                window.open("../PM/PM_ProjectDetails.aspx?ShowOnGoing=1&Mode=ProjectDetails&EmployeeID=" + EmpID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=700,height=500");
            }
</script>
</html>
