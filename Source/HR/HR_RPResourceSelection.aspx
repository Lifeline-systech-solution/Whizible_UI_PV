<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_RPResourceSelection.aspx.vb" Inherits="PbNIT.HR_RPResourceSelection" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>

<%CommonFunctions.General.PlotPageHeadTag("Resource Selection")%>
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
    /*Added by Nilesh Gundecha on 17/11/2015 for textbox alignment*/
    #txtPageNumber
    {
            margin-top:0px !important;
            height:20px;
    }
    #divGrid {
        margin-bottom:14px !important;/*Added by Yogesh J for pop up bottom line issue*/
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
<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmHR_RPResourceSelection" method="post" runat="server">
        <%WritePage()%>
    </form>

    <script language="javascript">

        objform = GetFormReference('frmHR_RPResourceSelection');
        var objdivlist = GetObjectReference('frmHR_RPResourceSelection', 'divGrid');
        var ShowFilter = '0';

        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (isIE() == 'FF') {

                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
            }
            else {
                //Commented by Yogesh J on 08/12/2015 issue id 2668
               // intDivHeight = window.innerHeight - 42;
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
                //End of addition by Yogesh J on 08/12/2015
            }
            if (intDivHeight < 100)
                intDivHeight = 100;

            objdivlist.style.height = intDivHeight+'px';
        }

        function window_onload() {

         
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                var lc;
              //  if (navigator.appName == 'Microsoft Internet Explorer')
                if (isIE() == 'FF') {
                   
                    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
                }
                else {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
                }
                
                if (intDivHeight < 100)
                    intDivHeight = 100;
                objdivlist.style.height = intDivHeight +'px';
               // objdivlist.HEIGHT = intDivHeight + 'px';
            }
        }


        function Filters_OnClick(show) {
            objtblFilter = GetObjectReference('FrmScoreCardReview', 'tblFilter');
            //objimgFilter =GetObjectReference('FrmScoreCardReview','imgFilter',true);
            objimgFilterUp = GetObjectReference('frmResourceUtilizationFilters', 'imgFilterUp');
            objimgFilterDown = GetObjectReference('frmResourceUtilizationFilters', 'imgFilterDown');

            img1 = '../../Images/cssImages/Link images/close.gif';
            img2 = '../../Images/cssImages/Link Images/Filter.gif';
           
            if (ShowFilter == '0') {
                /*objtblFilter.style.top=30;
                
                //objimgFilter.src=img1;
                //objimgFilter.alt='Hide filter'
                    objimgFilter[0].src=img1;
                    objimgFilter[0].alt='Hide filter';
                    objimgFilter[1].src=img1;
                    objimgFilter[1].alt='Hide filter';
                    
                ShowFilter='1';*/

                objtblFilter.style.left = 0;
                objtblFilter.zIndex = 99;
                objtblFilter.style.display = '';
                objimgFilterUp.src = img1;
                objimgFilterUp.alt = 'Hide filter';
                objimgFilterDown.src = img1;
                objimgFilterDown.alt = 'Hide filter';

                /*if(ns)
                objFilterMenudiv.style.height = objtblFilter.offsetHeight;*/
                 
                ShowFilter = '1';

            }
            else if (ShowFilter == '1') {
                /* objtblFilter.style.display='none';
                //objimgFilter.src=img2;
                    objimgFilter[0].src=img2;
                    objimgFilter[0].alt='Hide filter';
                    objimgFilter[1].src=img2;
                    objimgFilter[1].alt='Hide filter';
                ShowFilter='0';    */

                objtblFilter.style.display = 'none';
                objimgFilterUp.src = img2;
                objimgFilterUp.alt = 'Show filter';
                objimgFilterDown.src = img2;
                objimgFilterDown.alt = 'Show filter';

                ShowFilter = '0';

                //objimgFilter.alt='Show filter' ;
            }
        }
        function Apply_OnClick() {

            var CompareFactor = GetObjectReference('frmHR_RPResourceSelection', 'cboCompareFactor');
            var Exp = GetObjectReference('frmHR_RPResourceSelection', 'cboExp');

            if (Exp.value != '') {
                if (CompareFactor.value == '') {
                    alert('Please select operator for experience filter.');
                    setFocus(CompareFactor);
                    return;
                }
            }
            if (CompareFactor.value != '') {
                if (Exp.value == '') {
                    alert('Please select value for experience.');
                    setFocus(Exp);
                    return;
                }
            }

            objform.action = "HR_RPResourceSelection.aspx";
            objform.submit();

        }
        function Clear_OnClick() {
            var objBG = GetObjectReference('frmHR_RPResourceSelection', 'cboBG').value = '';
            var objOU = GetObjectReference('frmHR_RPResourceSelection', 'cboOU').value = '';
            var objDU = GetObjectReference('frmHR_RPResourceSelection', 'cboDU').value = '';
            var objDT = GetObjectReference('frmHR_RPResourceSelection', 'cboDT').value = '';
            var objRole = GetObjectReference('frmHR_RPResourceSelection', 'cboRole').value = '';
            var objDesignation = GetObjectReference('frmHR_RPResourceSelection', 'cboDesignation').value = '';
            var objDepartment = GetObjectReference('frmHR_RPResourceSelection', 'cboDepartment').value = '';
            var objGrade = GetObjectReference('frmHR_RPResourceSelection', 'cboGrade').value = '';
            var objSkill = GetObjectReference('frmHR_RPResourceSelection', 'cboSkill').value = '';
            var objCompareFactor = GetObjectReference('frmHR_RPResourceSelection', 'cboCompareFactor').value = '';
            var objExp = GetObjectReference('frmHR_RPResourceSelection', 'cboExp').value = '';
            var objCertification = GetObjectReference('frmHR_RPResourceSelection', 'cboCertification').value = '';
            var objQualification = GetObjectReference('frmHR_RPResourceSelection', 'cboQualification').value = '';
            var objProject = GetObjectReference('frmHR_RPResourceSelection', 'cboProject').value = '';
            var objResourcePool = GetObjectReference('frmHR_RPResourceSelection', 'cboResourcePool').value = '';
            var objchkhasPassport = GetObjectReference('frmHR_RPResourceSelection', 'chkhasPassport').value = '';
            var objVisaCountry = GetObjectReference('frmHR_RPResourceSelection', 'cboVisaCountry').value = '';
            var objVisaType = GetObjectReference('frmHR_RPResourceSelection', 'cboVisaType').value = '';

            objform.action = "HR_RPResourceSelection.aspx";
            objform.submit();


        }
        function Close_OnClick() {
            window.close();
        }
        function Save_onClick() {
            var objCHK = GetObjectReference('', 'chkSelect', true);
            var hidResourcePoolID = GetObjectReference('', 'hidResourcePoolID');

            var strEmployeeIDs;
            strEmployeeIDs = '';
            for (var i = 0; i < objCHK.length  ; i++) {
                if (objCHK[i].checked == true) {
                    strEmployeeIDs = strEmployeeIDs + objCHK[i].value + ',';
                }
            }

            objform.action = "HR_RPResourceSelection.aspx?Action=SAVE&ResourcePoolID=" + hidResourcePoolID.value + "&EmployeeIDs=" + strEmployeeIDs;
            objform.submit();

            //To refresh Parent

            var strParentPage = new String();
            var objTokenPK = window.opener.document.getElementById('PKToken');
            var objIDPK = window.opener.document.getElementById('ResourcePoolID_PK');
            strParentPage = '../HR/HR_CommonPage.aspx?ResourcePoolID_PK=' + objIDPK.value + '&PKToken=' + objTokenPK.value;
            strParentPage = strParentPage + '&MasterTagID=3900&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1'
            refreshParent('frmCommonPage', 'CommonPage.aspx', strParentPage);

        }

        function SaveAndClose_onClick() {
            var objCHK = GetObjectReference('', 'chkSelect', true);
            var hidResourcePoolID = GetObjectReference('', 'hidResourcePoolID');

            var strEmployeeIDs;
            strEmployeeIDs = '';
            for (var i = 0; i < objCHK.length  ; i++) {
                if (objCHK[i].checked == true) {
                    strEmployeeIDs = strEmployeeIDs + objCHK[i].value + ',';
                }
            }

            objform.action = "HR_RPResourceSelection.aspx?Action=SAVE&ResourcePoolID=" + hidResourcePoolID.value + "&EmployeeIDs=" + strEmployeeIDs;
            objform.submit();

            //To refresh Parent

            var strParentPage = new String();
            var objTokenPK = window.opener.document.getElementById('PKToken');
            var objIDPK = window.opener.document.getElementById('ResourcePoolID_PK');
            strParentPage = '../HR/HR_CommonPage.aspx?ResourcePoolID_PK=' + objIDPK.value + '&PKToken=' + objTokenPK.value;
            strParentPage = strParentPage + '&MasterTagID=3900&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1'
            refreshParent('frmCommonPage', 'CommonPage.aspx', strParentPage);

            window.close();
        }
        function ShowSelected_onClick() {
            objform.action = "HR_RPResourceSelection.aspx?IsSelected=1";
            objform.submit();
        }
        function ShowAll_onClick() {
            objform.action = "HR_RPResourceSelection.aspx?IsSelected=0";
            objform.submit();
        }


        function txtPageNumber_KeyPress(e) {
            var code;
            if (e.keyCode)
                code = e.keyCode;
            else
                if (e.which)
                    code = e.which;

            if (code == 13) {
                var objtxtpageNumber = GetObjectReference('frmHRResourceCalenderView', 'txtPageNumber');
                var objtxtNoOfPages = GetObjectReference('frmHRResourceCalenderView', 'txtNoOfPages');

                //if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
			    if (!disallowBlank(objtxtpageNumber, "Please Enter Page Number.", true) && (!disallowNonNumeric(objtxtpageNumber, "Page number must be Numeric.", true)) && (!disallowNegativeNumeric(objtxtpageNumber, "Page number must be Positive.", true)) & (!disallowNonInteger(objtxtpageNumber, "Page number must be Integer.", true))) {
			        if (Number(objtxtpageNumber.value) == 0) {
			            alert("Page number should be greater than zero!");
			            return;
			        }

			        if (Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value)) {
			            alert("Page number is not valid.");
			            return;
			        }
			        Page_OnClick(objtxtpageNumber.value);
			    }
			}

        }
        function Page_OnClick(page) {
            objform.action = "HR_RPResourceSelection.aspx?ResourcePoolID=<%=strResourcePoolID%>&IsSelected=<%=IsSelected%>&PageNumber=" + page;
		    objform.submit();
		}

		var noOfPages = GetObjectReference('frmHRResourceCalenderView', 'hidNoOfPages').value;
		var objtxtpageNumber = GetObjectReference('frmHRResourceCalenderView', 'txtPageNumber');
		function validateNumPaging() {

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
		    if (isBlank(objtxtpageNumber.value))
		        Page_OnClick(1);
		    else {
		        if (!validateNumPaging())
		            return;

		        if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
		        objtxtpageNumber.value = objtxtpageNumber.value - 1;
		        Page_OnClick(objtxtpageNumber.value);
		    }

		}
		function ShowFirstPage() {
		    if (isBlank(objtxtpageNumber.value))
		        Page_OnClick(1);
		    else {
		        if (!validateNumPaging())
		            return;
		        if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
		        objtxtpageNumber.value = 1;
		        Page_OnClick(objtxtpageNumber.value);
		    }
		}
		function ShowNextPage() {

		    if (isBlank(objtxtpageNumber.value))
		        Page_OnClick(1);
		    else {
		        if (!validateNumPaging())
		            return;
		        if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
		        objtxtpageNumber.value = parseInt(objtxtpageNumber.value) + 1;
		        Page_OnClick(objtxtpageNumber.value);
		    }
		}
		function ShowLastPage() {
		    if (isBlank(objtxtpageNumber.value))
		        Page_OnClick(noOfPages);
		    else {
		        if (!validateNumPaging())
		            return;
		        if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
		        objtxtpageNumber.value = noOfPages;
		        Page_OnClick(objtxtpageNumber.value);
		    }
		}


    </script>
</body>
</html>
