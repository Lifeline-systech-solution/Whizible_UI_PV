<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_StatusMailConfiguration.aspx.vb" Inherits="PbNIT.IB_StatusMailConfiguration" ValidateRequest="False" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>

<!DOCTYPE HTML>
<%--Integrated for project listing new UI--%>
<style>
    .clsBody.no-border-main-wrap {
        border: none !important;
        padding: 0px !important;
        margin: 0px !important;
    }

    .bgwhite, .new-main-wrap table {
        background-color: #fff !important;
    }

        .new-main-wrap table.clsTable.topInnerMenu {
            margin: 10px 0px;
        }

    .new-main-wrap .clsTRPageCaption {
        background-color: #4263c1;
        padding: 10px 15px;
        display: table;
        width: 98%;
        margin: 0px 0px 10px;
    }

        .new-main-wrap .clsTRPageCaption td {
            color: #fff !important;
            margin: 0px;
            font-size: 16px !important;
            padding: 0px !important;
        }

    .new-main-wrap .clsTable.footerMenuTable {
        display: none !important;
    }

    .new-main-wrap TR.clsTRMenu {
        height: 30px;
    }

    .new-main-wrap.new-configure-wrap .clsGridTable {
        width: 97%;
        margin: 10px auto;
    }

        .new-main-wrap.new-configure-wrap .clsGridTable .clsTRColumnHeader {
            padding: 8px;
            display: table;
            width: 98.7%;
        }

        .new-main-wrap.new-configure-wrap .clsGridTable tbody {
            display: table;
            width: 100%;
        }

            .new-main-wrap.new-configure-wrap .clsGridTable tbody tr td {
                padding: 8px !important;
            }

      .new-configure-wrap #divListResources {
       /*Commented By Dipali V On 27th Sep 2021 For Height Issue*/
        /*height: 180px !important;*/
           height: 400px !important;
       /*End of Commented By Dipali V On 27th Sep 2021 For Height Issue*/
    }


  .new-main-wrap.new-configure-wrap #divListStatus {
        height: 100px !important;
    }

    .new-configure-wrap #tblCap00:nth-child(2) {
        display: none !important;
    }

    .new-main-wrap .clsTRPageCaption td:nth-child(2) {
        padding-right: 30px !important;
    }

    .new-main-wrap A.PagingNormal, .new-main-wrap A.PagingSelected, #tblCap00 > tbody > tr > td > a {
        color: #fff;
    }
</style>
<%--Integrated for project listing new UI--%>
<html>
<%WritePageHead%>


<%CommonFunctions.General.PlotPageHeadTag("")%>

<body ms_positioning="GridLayout" class="clsBody no-border-main-wrap" onresize="window_onresize()" onload="window_onload()">
    <form id="frmConfigureMails" method="post" runat="server" class="new-main-wrap bgwhite new-configure-wrap">
        <%WritePage%>
    </form>
</body>
</html>
<script language="javascript">

	<%If m_strAction = ACTION_SAVE Then%>
    window.close();
	<%End If%>

    var objForm, objdivlist;

    objForm = GetFormReference('frmConfigureMails');

	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

    function window_onload() {
        // PURPOSE: To resize the DIV size depending on the screen resolution.
        var intDivHeight, objdivlist;

        objdivlist = GetObjectReference('frmConfigureMails', 'divListStatus');
        if (objdivlist != null) {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            intDivHeight = (intDivHeight / 3);
            if (intDivHeight < 100) intDivHeight = 100;		// Let the minimum height of the div tag be 100
            objdivlist.style.height = intDivHeight + 'px';
        }
        objdivlist = GetObjectReference('frmConfigureMails', 'divListResources');
        if (objdivlist != null) {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            if (intDivHeight < 100) intDivHeight = 100;		// Let the minimum height of the div tag be 100
            objdivlist.style.height = intDivHeight + 'px';
        }
    }

    function window_onresize() {
        // PURPOSE: To resize the DIV size depending on the screen resolution.
        var intDivHeight, objdivlist;

        objdivlist = GetObjectReference('frmConfigureMails', 'divListStatus');
        if (objdivlist != null) {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            intDivHeight = (intDivHeight / 3);
            if (intDivHeight < 100) intDivHeight = 100;		// Let the minimum height of the div tag be 100
            objdivlist.style.height = intDivHeight + 'px';
        }
        objdivlist = GetObjectReference('frmConfigureMails', 'divListResources');
        if (objdivlist != null) {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            if (intDivHeight < 100) intDivHeight = 100;		// Let the minimum height of the div tag be 100
            objdivlist.style.height = intDivHeight + 'px';
        }
    }

    function Save_OnClick() {
        var objchkIssueStatus, objMailToEmployeeIDList, blnStatusSelected = false, intCtr;

        objchkIssueStatus = GetObjectReference('frmConfigureMails', 'chkIssueStatus', true);
        objMailToEmployeeIDList = GetObjectReference('frmConfigureMails', 'txthidMailToEmployeeIDList');
        if (objchkIssueStatus != null) {
            for (intCtr = 0; intCtr < objchkIssueStatus.length; intCtr++) {
                if (objchkIssueStatus[intCtr].checked == true) {
                    blnStatusSelected = true;
                    break;
                }
            }
        }
        // If at least status value is selected, then...	
        if (blnStatusSelected == true) {
            if (disallowBlank(objMailToEmployeeIDList, "<%=MyBase.GetResourceString("SELECT_RESOURCE")%>"))
                return;
            if (objMailToEmployeeIDList.value == ",") {
                alert("<%=MyBase.GetResourceString("SELECT_RESOURCE")%>");
                return;
            }
        }
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
        objForm.action = "IB_StatusMailConfiguration.aspx?Action=<%=ACTION_SAVE%>";
        objForm.submit();
    }

    function ConfigureMails_OnClick(strProjectIssueStatus) {
        // PURPOSE: To configure the mails (specific to a status).
        window.open("IB_StatusMailConfiguration.aspx?ProjectIssueType=<%=Server.URLEncode(m_strProjectIssueType)%>&ProjectIssueStatus=" + URLEncode(strProjectIssueStatus), "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=600,height=400");
    }

    function URLEncode(strQSParameter) {
        // PURPOSE: To handle the special characters in the query string.
        var strReturn = '';

        strReturn = strQSParameter;
        strReturn = replaceSubstring(strReturn, "#", "%23");
        strReturn = replaceSubstring(strReturn, "%", "%25");
        strReturn = replaceSubstring(strReturn, "&", "%26");
        strReturn = replaceSubstring(strReturn, "+", "%2B");
        return (strReturn);
    }

    function chkMailToList_OnClick(strEmployeeID) {
        var objToCheckBox, objCcCheckBox, objMailToEmployeeIDList, strMailToEmployeeIDList;
        var strTempArray, intCtr;

        objToCheckBox = GetObjectReference('frmConfigureMails', 'chkMailToEmployeeID_' + strEmployeeID);
        objCcCheckBox = GetObjectReference('frmConfigureMails', 'chkMailCCToEmployeeID_' + strEmployeeID);
        objMailToEmployeeIDList = GetObjectReference('frmConfigureMails', 'txthidMailToEmployeeIDList');
        strMailToEmployeeIDList = objMailToEmployeeIDList.value;
        if (objToCheckBox.checked == true) {
            if (isSubstringExists(strMailToEmployeeIDList, "," + objToCheckBox.value + ",") == false)
                strMailToEmployeeIDList = strMailToEmployeeIDList + objToCheckBox.value + ",";
            objCcCheckBox.disabled = true;
        }
        else {
            if (isSubstringExists(strMailToEmployeeIDList, "," + objToCheckBox.value + ",") == true) {
                strTempArray = strMailToEmployeeIDList.split(",");
                strMailToEmployeeIDList = ',';
                for (intCtr = 0; intCtr < strTempArray.length; intCtr++) {
                    if ((strTempArray[intCtr] != objToCheckBox.value) && (strTempArray[intCtr] != ""))
                        strMailToEmployeeIDList = strMailToEmployeeIDList + strTempArray[intCtr] + ',';
                }
            }
            objCcCheckBox.disabled = false;
        }
        objMailToEmployeeIDList.value = strMailToEmployeeIDList;
    }

    function chkMailCCToList_OnClick(strEmployeeID) {
        var objToCheckBox, objCcCheckBox, objMailCcToEmployeeIDList, strMailCcToEmployeeIDList;
        var strTempArray, intCtr;

        objCcCheckBox = GetObjectReference('frmConfigureMails', 'chkMailCCToEmployeeID_' + strEmployeeID);
        objToCheckBox = GetObjectReference('frmConfigureMails', 'chkMailToEmployeeID_' + strEmployeeID);
        objMailCcToEmployeeIDList = GetObjectReference('frmConfigureMails', 'txthidMailCCToEmployeeIDList');
        strMailCcToEmployeeIDList = objMailCcToEmployeeIDList.value;
        if (objCcCheckBox.checked == true) {
            if (isSubstringExists(strMailCcToEmployeeIDList, "," + objCcCheckBox.value + ",") == false)
                strMailCcToEmployeeIDList = strMailCcToEmployeeIDList + objCcCheckBox.value + ",";
            objToCheckBox.disabled = true;
        }
        else {
            if (isSubstringExists(strMailCcToEmployeeIDList, "," + objCcCheckBox.value + ",") == true) {
                strTempArray = strMailCcToEmployeeIDList.split(",");
                strMailCcToEmployeeIDList = ',';
                for (intCtr = 0; intCtr < strTempArray.length; intCtr++) {
                    if ((strTempArray[intCtr] != objCcCheckBox.value) && (strTempArray[intCtr] != ""))
                        strMailCcToEmployeeIDList = strMailCcToEmployeeIDList + strTempArray[intCtr] + ',';
                }
            }
            objToCheckBox.disabled = false;
        }
        objMailCcToEmployeeIDList.value = strMailCcToEmployeeIDList;
    }

    function Page_Onclick(strPageNumber) {
        var objPageNumber;

        objPageNumber = GetObjectReference('frmConfigureMails', 'txthidPageNumber');
        objPageNumber.value = strPageNumber;
        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        setFrameLoader();
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IB_StatusMailConfiguration.aspx";
        objForm.submit();
    }
</script>
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

</script >
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
