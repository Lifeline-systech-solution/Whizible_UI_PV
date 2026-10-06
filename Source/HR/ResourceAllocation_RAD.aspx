<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceAllocation_RAD.aspx.vb" Inherits="PbNIT.ResourceAllocation_RAD" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<% CommonFunctions.General.PlotPageHeadTag("Allocate Resource")%>
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
    .footerMenuTable {
        visibility:visible !important;  /*Added by Yogesh J on 15/12/2015*/
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

    <form id="frmResourceAllocation_RAD" method="post" runat="server">

        <%PageInit()%>
    </form>


    <script language="javascript">

        var objform = GetFormReference('frmResourceAllocation_RAD');
        var objdivlist = GetObjectReference('frmResourceAllocation_RAD', 'PageDiv');

        <%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>


        var objXHttp;
        var blnFlag = false;
        var strmsg;

        function HandlerOnReadyState() {
            if (objXHttp.readyState == 4) {
                if (objXHttp.status == 200) {
                    if (objXHttp.responseText != null) {
                        strmsg = objXHttp.responseText
                        if (strmsg != "")
                            alert(strmsg);
                    }
                }
            }
        }

        function window_onload() {
        
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                //'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

                if (navigator.appName == 'Netscape') {
                    //Commented by Yogesh J on 14/12/2015 for pop up bottom line issue
                    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                    //End of comment by Yogesh J 
                }
                else {
                    //Commented by Yogesh J on 14/12/2015 for pop up bottom line issue
                    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                    //End of comment by Yogesh J 
                }
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight +'px';
            }


        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                //'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

                if (navigator.appName == 'Netscape') {
                    // intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                else {
                    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight +'px';
            }
        }



        function Save_OnClick(thisLink) {
            var objStartDate = GetObjectReference('frmResourceAllocation_RAD', 'txtFromDate');
            var objEndDate = GetObjectReference('frmResourceAllocation_RAD', 'txtToDate');
            //Commented And Added By Vaijat K ON 24/12/2015 
            //var objProject = GetObjectReference('frmResourceAllocation_RAD', 'cboproject');
            var objProject = GetObjectReference('frmResourceAllocation_RAD', 'cboProject');
            //Ended
            var objPercentage = GetObjectReference('frmResourceAllocation_RAD', 'txtAllocationPer');
            var objEmployeeid = GetObjectReference('frmResourceAllocation_RAD', 'txtemployeeid');
            var objRole = GetObjectReference('frmResourceAllocation_RAD', 'cboRole');
            strUrl = new String();

            var errmsg = 'Project can not be blank';
            if (disallowBlank(objProject, errmsg) == true) {
                return;
            }

            errmsg = 'Role can not be blank';
            if (disallowBlank(objRole, errmsg) == true) {
                return;
            }

            errmsg = 'Expected End Date Cannot be less than Expected Start Date';
            if (disallowDate1LessThanDate2(objEndDate, objStartDate, errmsg) == true) {
                return;
            }
            errmsg = 'Expected Start Date Cannot be blank';
            if (disallowBlank(objStartDate, errmsg) == true) {
                return;
            }
            errmsg = 'Expected End Date cannot be blank';
            if (disallowBlank(objEndDate, errmsg) == true) {
                return;
            }
            errmsg = 'Allocation %  cannot be blank';
            if (disallowBlank(objPercentage, errmsg) == true) {
                return;
            }

            errmsg = 'Allocation Percentage should be in the range of 1 To <%=m_StdAllocationPercentage%>';
		   if (disallowValueRangeViolation(objPercentage, 1, '<%=m_StdAllocationPercentage%>', errmsg)) {
		        objPercentage.value = '';
		        return false;
		    }

		    thisLink.disabled = true;
		    strUrl = '../General/XMLHttp.aspx?TagID=3982&Action=VALIDATE&Project=' + objProject.value + '&FromDate=' + objStartDate.value + '&ToDate=' + objEndDate.value + '&EmployeeId=' + objEmployeeid.value + '&Allocation=' + objPercentage.value;
		    if (WhichBrowser() == 'IE') {
		        objXHttp = new ActiveXObject('Msxml2.XMLHTTP');
		        objXHttp.onreadystatechange = HandlerOnReadyState;
		        objXHttp.open('GET', strUrl, false);
		        objXHttp.send();
		    }
		    else {
                objXHttp = new XMLHttpRequest();
                //Commented And Added By Usha Pandit On 16.04.2020 For Save issue On Chrome and Firefox on Allocate link click for Project allocation
		        //objXHttp.onreadystatechange = HandlerOnReadyState();
                objXHttp.onreadystatechange = HandlerOnReadyState;
                //End Of Added By Usha Pandit On 16.04.2020 For Save issue On Chrome and Firefox on Allocate link click for Project allocation
		        objXHttp.open('GET', strUrl, false);
		        objXHttp.send(null);
		    }


		    if (strmsg == "") {
		        //Added By NILESH G on 13-April-2015 Purpose::HIDE SAVE LINK AND APPLY LOADER 
		        var MenuTags = document.getElementsByTagName('A');
		        for (i = 0; i < MenuTags.length; i++) {
		            if (MenuTags[i].className == "Menu") {
		                //MenuTags[i].style.display= "none";
		                MenuTags[i].parentNode.style.display = "none";
		            }
		        }
		        setFrameLoader();
		        // End of Added By NILESH G on 13-April-2015 Purpose::HIDE SAVE LINK AND APPLY LOADER
		        objform.action = "../HR/ResourceAllocation_RAD.aspx?MODE=SAVE";
		        objform.submit();
		    }
		    else {
		        thisLink.disabled = false;
		    }
		}



        <%=m_strScript%>
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
    </script>

</body>
</html>
