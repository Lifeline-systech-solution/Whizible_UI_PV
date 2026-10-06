<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_OutlookConfiguration.aspx.vb" Inherits="PbNIT.PM_OutlookConfiguration" %>


<html>
    <%CommonFunctions.General.PlotPageHeadTag("Configure OutLook")%>
    
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
     
<script src="../../responsive/responsive.js"></script>


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

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmOutLookConfiguration" runat="server">
        <%WritePage()%>
    </form>
    <script language="javascript">
        var objfrm = GetFormReference('frmOutLookConfiguration');
        var objPageDiv = GetObjectReference('frmOutLookConfiguration', 'PageDiv');
        var objhidEntityID = GetObjectReference('frmOutLookConfiguration', 'hidEntityIDs').value;
        var arrhidEntityID = objhidEntityID.split(",");

  	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>

        function window_onload() {

            var intDivHeight;
            var intDivHeightRisk;
            if (objPageDiv != null) {
                intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                //Commented and added by Yogesh J on 11/12/2015
                //objPageDiv.style.height = intDivHeight;
                objPageDiv.style.height = intDivHeight + 'px';
            }

            for (var cnt = 0; cnt < arrhidEntityID.length - 1; cnt++) {
                //  var objstarttxt=GetObjectReference('frmOutLookConfiguration','txtEntityStart_' + arrhidEntityID[cnt]);
                var objEndtxt = GetObjectReference('frmOutLookConfiguration', 'txtEntityEnd_' + arrhidEntityID[cnt]);
                if (GetObjectReference('frmOutLookConfiguration', 'chkEntity_' + arrhidEntityID[cnt]).checked == true) {
                    //objstarttxt.disabled=false;
                    objEndtxt.disabled = false;
                }
                else {
                    // objstarttxt.disabled=true;
                    objEndtxt.disabled = true;
                }
            }
        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objPageDiv != null) {
                intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                //Commented and added by Yogesh J on 11/12/2015
                //objPageDiv.style.height = intDivHeight;
                objPageDiv.style.height = intDivHeight + 'px';
            }
        }

        function Save_OnClick() {

            var isselected = false;
            var SelectedEntityIDs = '';
            for (var cnt = 0; cnt < arrhidEntityID.length - 1; cnt++) {
                if (GetObjectReference('frmOutLookConfiguration', 'chkEntity_' + arrhidEntityID[cnt]).checked == true) {
                    //  var objstarttxt=GetObjectReference('frmOutLookConfiguration','txtEntityStart_' + arrhidEntityID[cnt]);
                    var objEndtxt = GetObjectReference('frmOutLookConfiguration', 'txtEntityEnd_' + arrhidEntityID[cnt]);
                    if (disallowNonInteger(objEndtxt, "Please enter integer value.", true)) return false;
                    if (disallowNegativeNumeric(objEndtxt, "Please enter positive integer.", true)) return false;
                    //  if (objstarttxt.value=="" && objEndtxt.value=="")
                    if (objEndtxt.value == "") {
                        alert("Please enter 'Due in days'");
                        return;
                    }
                }
            }

            for (var cnt = 0; cnt < arrhidEntityID.length - 1; cnt++) {
                if (GetObjectReference('frmOutLookConfiguration', 'chkEntity_' + arrhidEntityID[cnt]).checked == true) {
                    isselected = true;
                }
            }
            if (isselected == false) {
                alert("Please select at least one entity");
                return;
            }
            objfrm.action = 'PM_OutlookConfiguration.aspx?Action=SAVE';
            objfrm.submit();
        }

        function IntegrateNow_OnClick() {

            //  objfrm.action='PM_OutlookConfiguration.aspx?Action=INTEGRATENOW';
            // objfrm.submit();
            if (<%=m_strFlag %>!= "1") {
                alert("Please Save the data");
                return;
            }

      // window.open('PM_OutlookIntegration.aspx?&Action=INTEGRATENOW&EntityIds=<%=m_strEntityIDs %>' ,'','resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 300)/2 + ',width=600,height=300');
            window.open("PM_OutlookIntegration.aspx?&Action=INTEGRATENOW&EntityIds=<%=m_strEntityIDs %>", "_popup");


        }

        /* function Close_OnClick()
         {
             alert("HI");
             window.close();
         }*/

        function Chk_Select(id, value) {
            //  var objstarttxt=GetObjectReference('frmOutLookConfiguration','txtEntityStart_' + value);
            var objEndtxt = GetObjectReference('frmOutLookConfiguration', 'txtEntityEnd_' + value);
            var chk = GetObjectReference('frmOutLookConfiguration', 'chkEntity_' + value);
            if (chk.checked == true) {
                //  objstarttxt.disabled=false;
                objEndtxt.disabled = false;
            }
            else {
                // objstarttxt.disabled=true;
                objEndtxt.disabled = true;
            }
        }

        function Reset_OnClick() {

            if (confirm('Do you want to reset all the entities?')) {
                objfrm.action = 'PM_OutlookConfiguration.aspx?Action=RESET';
                objfrm.submit();
            }

            // objfrm.action='PM_OutlookConfiguration.aspx?Action=RESET';
            // objfrm.submit();
        }
        function ShowHistory_Onclick() {
            window.open('../General/CommonList.aspx?&MasterTagID=3957', '', 'resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 450) / 2 + ',width=800,height=450');
        }
    </script>
</body>
</html>
