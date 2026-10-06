<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ShowView.aspx.vb" Inherits="PbNIT.ShowView" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Resource Skill Details")%>

<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
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

<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmShowView" name="frmShowView" method="post" runat="server">
        <%DrawPage()%>
    </form>
    <script language="javascript">
        var objfrm = GetFormReference('frmShowView');

        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

        function window_onload() {

            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight +'px';
            }

            //CallOnLoad() 

        }
        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight +'px';
            }
            //CallOnLoad() 
        }

        function Status_onchange() {

            objfrm.action = "../HR/ShowView.aspx?PageNumber=<%=m_intPageNumber%>";
		    objfrm.submit();
		}

		function Category_onchange() {
		    GetObjectReference('', 'cboSkills').value = '';
		    objfrm.action = "../HR/ShowView.aspx?PageNumber=<%=m_intPageNumber%>";
			objfrm.submit();
        }

        function View_onchange() {
            objfrm.action = "../HR/ShowView.aspx?PageNumber=<%=m_intPageNumber%>";
		    objfrm.submit();
		}


		function ExportData_OnClick() {
		    var objintCategoryID;
		    objintCategoryID = GetObjectReference('frmShowView', 'cboCategory').value;
		    var objintSkillID;
		    objintSkillID = GetObjectReference('frmShowView', 'cboSkills').value;
		    var objintViewID;
		    objintViewID = GetObjectReference('frmShowView', 'cboView').value;
		    window.open("../HR/ShowView.aspx?Action=EXPORT&ViewReport=0&SkillID=" + objintSkillID + "&CategoryID=" + objintCategoryID + "&ViewID=" + objintViewID + "&PageNumber=<%=m_intPageNumber%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=550,height=230");//&ReportID="+intReportID+"");//,"left=50,top=50,height=400,width=550,resizable=yes,scrollbar=yes");

        }

        function ViewReport_OnClick(format) {
            if ("<%=m_ViewID%>" == 1)
		        intReportID = 2117;
		    if ("<%=m_ViewID%>" == 2)
		        intReportID = 2118;
		    if ("<%=m_ViewID%>" == 3)
		        intReportID = 2119;


		    window.status = 'Processing...Please wait.';
		    var objintCategoryID;
		    objintCategoryID = GetObjectReference('frmShowView', 'intCategoryID').value;
		    if (objintCategoryID == "")
		        objintCategoryID = "NULL";

		    var objintSkillID;
		    objintSkillID = GetObjectReference('frmShowView', 'intSkillID').value;
		    if (objintSkillID == "")
		        objintSkillID = "NULL";

		    var objintViewID;
		    objintViewID = GetObjectReference('frmShowView', 'intViewID').value;

		    if (objintViewID == "")
		        objintViewID = "NULL";
		    objfrm.target = '_blank';

		    objfrm.action = "../HR/ShowView.aspx?ViewReport=1&SkillID=" + objintSkillID + "&CategoryID=" + objintCategoryID + "&ViewID=" + objintViewID + "&ReportID=" + intReportID + "&Format=" + format;//+"&PageNumber=<%=m_intPageNumber%>";
				objfrm.submit();
            }

            function Page_OnClick(strPaging) {
                var objintCategoryID;
                objintCategoryID = GetObjectReference('frmShowView', 'cboCategory').value;
                if (objintCategoryID == "")
                    objintCategoryID = "NULL";
                var objintSkillID;
                objintSkillID = GetObjectReference('frmShowView', 'cboSkills').value;
                if (objintSkillID == "")
                    objintSkillID = "NULL";
                var objintViewID;
                objintViewID = GetObjectReference('frmShowView', 'cboView').value;
                if (objintViewID == "")
                    objintViewID = "NULL";

                objfrm.action = "../HR/ShowView.aspx?ViewReport=0&SkillID=" + objintSkillID + "&CategoryID=" + objintCategoryID + "&ViewID=" + objintViewID + "&Mode=&Paging=" + strPaging + "&PageNumber=<%=m_intPageNumber%>";
			objfrm.submit();

        }




        function txtPageNumber_KeyPress(e) {
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            var objtxtNoOfPages = GetObjectReference('frmShowView', 'txtNoOfPages');

            var code;
            if (e.keyCode)
                code = e.keyCode;
            else
                if (e.which)
                    code = e.which;

            if (code == 13) {
                if (!disallowBlank(objtxtpageNumber, "<%=mybase.GetResourceString("ENTERPAGENO")%>", true) && (!disallowNonNumeric(objtxtpageNumber, "<%=mybase.GetResourceString("NUMERICPAGENO")%>", true)) && (!disallowNegativeNumeric(objtxtpageNumber, "<%=mybase.GetResourceString("POSITIVEPAGENO")%>", true)) & (!disallowNonInteger(objtxtpageNumber, "<%=mybase.GetResourceString("INTEGER_PAGENO")%>", true))) {
				        if (Number(objtxtpageNumber.value) == 0) {
				            alert("Page number should be greater than zero!");
				            return;
				        }
				        if (Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value)) {
				            alert("Please enter value less than or equal to " + objtxtNoOfPages.value);
				            return;
				        }
				        NumPage_OnClick(objtxtpageNumber.value);
				    }
				}
            }

            function NumPage_OnClick(page) {

                var objintCategoryID;
                objintCategoryID = GetObjectReference('frmShowView', 'cboCategory').value;
                if (objintCategoryID == "")
                    objintCategoryID = "NULL";
                var objintSkillID;
                objintSkillID = GetObjectReference('frmShowView', 'cboSkills').value;
                if (objintSkillID == "")
                    objintSkillID = "NULL";
                var objintViewID;
                objintViewID = GetObjectReference('frmShowView', 'cboView').value;
                if (objintViewID == "")
                    objintViewID = "NULL";
                window.location.href.refresh;
                objfrm.action = "../HR/ShowView.aspx?ViewReport=0&SkillID=" + objintSkillID + "&CategoryID=" + objintCategoryID + "&ViewID=" + objintViewID + "&Paging=<%=m_strpaging%>&PageNumber=" + page;
			objfrm.submit();
        }

        function validateNumPaging() {
            var noOfPages = GetObjectReference('frmShowView', 'hidNoOfPages').value;
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            if (isNaN(objtxtpageNumber.value)) {
                alert("Please enter numeric value");
                return false;
            }

            if (parseInt(noOfPages) < parseInt(objtxtpageNumber.value)) {
                alert("Please enter value within range of 1 to " + noOfPages);
                return false;
            }
            return true;
        }

        function ShowPreviousPage() {
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            var objtxtNoOfPages = GetObjectReference('frmShowView', 'txtNoOfPages');

            if (isBlank(objtxtpageNumber.value))
                NumPage_OnClick(1);
            else {
                if (!validateNumPaging())
                    return;
                if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
                objtxtpageNumber.value = objtxtpageNumber.value - 1;
                NumPage_OnClick(objtxtpageNumber.value);
            }
        }

        function ShowFirstPage() {
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            var objtxtNoOfPages = GetObjectReference('frmShowView', 'txtNoOfPages');

            if (isBlank(objtxtpageNumber.value))
                NumPage_OnClick(1);
            else {
                if (!validateNumPaging())
                    return;
                if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
                objtxtpageNumber.value = 1;
                NumPage_OnClick(objtxtpageNumber.value);
            }
        }

        function ShowNextPage() {
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            var objtxtNoOfPages = GetObjectReference('frmShowView', 'txtNoOfPages');
            var noOfPages = GetObjectReference('frmShowView', 'hidNoOfPages').value;

            if (isBlank(objtxtpageNumber.value))
                NumPage_OnClick(1);
            else {
                if (!validateNumPaging())
                    return;
                if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
                objtxtpageNumber.value = parseInt(objtxtpageNumber.value) + 1;
                NumPage_OnClick(objtxtpageNumber.value);
            }
        }

        function ShowLastPage() {
            var noOfPages = GetObjectReference('frmShowView', 'hidNoOfPages').value;
            var objtxtpageNumber = GetObjectReference('frmShowView', 'txtPageNumber');
            if (isBlank(objtxtpageNumber.value))
                NumPage_OnClick(noOfPages);
            else {
                if (!validateNumPaging())
                    return;
                if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
                objtxtpageNumber.value = noOfPages;
                NumPage_OnClick(objtxtpageNumber.value);
            }
        }
    </script>
</body>
</html>
