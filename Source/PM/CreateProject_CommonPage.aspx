<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<script src="../Enhancement/Customer_XMLHttp.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

   
</style>

<script type="text/javascript">
    $(document).ready(function () {
        try {
            /*Added by dipali vekhande on 8th july 2020 while creation project not applicable cusstomfild*/
            $("#DivCustomFieldsSection").html('<table width="99.9%" cellspacing="0" class="clsTable"><tbody><tr class="clsTREven"><td align="center" valign="center"><b>No custom fields have been defined</b></td></tr><input type="hidden" name="CustomFieldList" id="CustomFieldList" class="clsTextBox" style="text-align:Left" value=""><input type="hidden" name="TypeInaccessibleCustomFieldList" id="TypeInaccessibleCustomFieldList" class="clsTextBox" style="text-align:Left" value=""></tbody></table>');
            /*End of Added by dipali vekhande on 8th july 2020 while creation project not applicable cusstomfild*/
            
            //Added By Usha Pandit On 08.07.2020 For clearing filter applied in list of project while creating project
            if ($("#ProjectName").val() != "") {
                $("#ProjectName").val("");
            }
            if ($("#ProjectGroupID option:selected").val() != "") {
                $("#ProjectGroupID").val($("#ProjectGroupID option:first").val());
            }
            //End Of Added By Usha Pandit On 08.07.2020 For clearing filter applied in list of project while creating project
            //Added by Yogesh J on 1-Apr-2016 purpose:To display Organisation Unit on Create project page on page load
            javascript: BusinessGroup_OnChange();
            //End of addition by Yogesh J 1-Apr-2016 

            //Added By Usha Pandit On 17.08.2020 For Resource demand project creation details fetch
            var opportunitId = "<%= Request.QueryString("opportunityID") %>";
            //End Of Added By Usha Pandit On 17.08.2020 For Resource demand project creation details fetch

            //Added by Vaijat K ON 19/05/2016 For Issue Fixing            
            $("#BusinessGroupID").prepend("<option value='' selected='selected'></option>");
            $("#LocationID").prepend("<option value='' selected='selected'></option>");
            $("#CustomerID").prepend("<option value='' selected='selected'></option>");
            //End of Addition Vaijat K
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

            //Added By Usha Pandit On 08.06.2020 For setting employee's BG and OU
            var objNonDatabase2 = GetObjectReference("frmCommonPage", "NonDatabase2");
            var objNonDatabase3 = GetObjectReference("frmCommonPage", "NonDatabase3");
            var objBusinessGroupID = GetObjectReference("frmCommonPage", "BusinessGroupID");
            var objLocationID = GetObjectReference("frmCommonPage", "LocationID");
            //alert(11);
            for (var i = 0; i < objNonDatabase2.length; i++) {
                if (objNonDatabase2[i].value != "" && objNonDatabase2[i].value != null && objNonDatabase2[i].value != undefined) {
                    objBusinessGroupID.value = objNonDatabase2[i].value;
                }
            }            

            //Added By Usha Pandit On 07.08.2020 For getting default BG and OU
            objLocationID.remove(0);
            for (var i = 0; i < objNonDatabase3.length; i++) {
                if (objNonDatabase3[i].value != "" && objNonDatabase3[i].value != null && objNonDatabase3[i].value != undefined) {
                    if (objLocationID.value == "") {
                        objLocationID.options[objLocationID.selectedIndex].value = objNonDatabase3[i].value;
                        objLocationID.options[objLocationID.selectedIndex].text = objNonDatabase3[i].text;
                    }
                    else {
                        objLocationID.options[objLocationID.options.length] = new Option(objNonDatabase3[i].text, objNonDatabase3[i].value);
                    }
                }
            }
            //End Of Added By Usha Pandit On 07.08.2020 For getting default BG and OU
            //End Of Added By Usha Pandit On 08.06.2020 For setting employee's BG and OU

            //Added By Usha Pandit On 17.08.2020 For Resource demand project creation details fetch
            
            if (opportunitId != null && opportunitId != undefined && opportunitId != "") {
                var curProjectName = "<%= Request.QueryString("ProjectName") %>";
                var curBG = "<%= Request.QueryString("BusinessGroupID") %>";
                var curOU = "<%= Request.QueryString("LocationID") %>";
                var curCustomerId = "<%= Request.QueryString("CustomerID") %>";
                
                $("#ProjectName").val(curProjectName);               
                $("#BusinessGroupID").val(curBG);
                $("#BusinessGroupID option[value=" + curBG + "]").prop("selected", true);
                $("#LocationID").val(curOU);
                $("#CustomerID").val(curCustomerId);
                $("#CustomerID option[value=" + curCustomerId + "]").prop("selected", true);                               
            }  
            
            //End Of Added By Usha Pandit On 17.08.2020 For Resource demand project creation details fetch
        }
        catch (ex) {
            //alert(ex.message);
        }
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

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CreateProject_CommonPage.aspx.vb" Inherits="PbNIT.CreateProject_CommonPage" %>


    