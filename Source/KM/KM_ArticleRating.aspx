<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="KM_ArticleRating.aspx.vb" Inherits="PbNIT.KM_ArticleRating" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<html>
<%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


    <%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>






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

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onresize="window_onresize()" onload="window_onload()" ms_positioning="GridLayout">
    <form autocomplete="off" id="frmKMArticleRating" method="post" runat="server">
        <%WritePage%>
    </form>

    <script>
        var objForm, objdivMain;

        objForm = GetFormReference('frmKMArticleRating');
        objdivMain = GetObjectReference('frmKMArticleRating', 'DivBody');
        objdivList = GetObjectReference('frmKMArticleRating', 'DivList');

    <%' Added By SonalD on 13th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>

        function window_onload() {
            var intDivHeight;
            var HeightDiff;
            HeightDiff = 40; //2;
            var browser = isIE();
            if (objdivMain) {
                //Commented and Added By Bharat T on 30th-Nov-2015
                //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop -  HeightDiff;
                //if(navigator.appName == 'Netscape')
                //{
                //	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - (120 + HeightDiff);
                //}

                if (browser == 'IE') {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                    objdivList.style.height = '93px';
                }
                else {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                }

                //if (intDivHeight < 100)	intDivHeight = 100;
                objdivMain.style.height = intDivHeight + 'px';
                //End of Commented and Added By Bharat T on 30th-Nov-2015
                //alert('objdivMain.style.height ' + objdivMain.style.height );
            }
        }
        function window_onresize() {
            var intDivHeight;
            var HeightDiff;
            HeightDiff = 40; //2;
            var browser = isIE();
            if (objdivMain) {
                //Commented and Added By Bharat T on 30th-Nov-2015
                //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop -  HeightDiff;
                //if(navigator.appName == 'Netscape')
                //{
                //	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - (120 + HeightDiff);
                //}

                if (browser == 'IE') {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                    //objdivList.style.height = '93px';
                }
                else {
                    intDivHeight = window.innerHeight - objdivMain.offsetTop - 5;
                }

                //if (intDivHeight < 100)	intDivHeight = 100;
                objdivMain.style.height = intDivHeight + 'px';
                //End of Commented and Added By Bharat T on 30th-Nov-2015
                //alert('objdivMain.style.height ' + objdivMain.style.height );
            }
        }
        function Save_OnClick() {
            
            var OptionRate = GetObjectReference('frmKMArticleRating', 'optRate', true);
            var cnt;
            var flag = 0;
            var Optvalue;
            for (cnt = 0; cnt < OptionRate.length; cnt++) {
                if (OptionRate[cnt].checked == true) {
                    flag = 1;
                    Optvalue = cnt + 1;
                    cnt = OptionRate.length;
                }
            }
            if (flag == 0) {
                alert('Select rating for Article.');
                return;
            }
            //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 
            //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
            var MenuTags = document.getElementsByTagName('A');
            for (i = 0; i < MenuTags.length; i++) {
                if (MenuTags[i].className == "Menu") {
                    //MenuTags[i].style.display= "none";
                    MenuTags[i].parentNode.style.display = "none";
                }
            }
            setFrameLoader();
            //ADDED BY Tejal D ON 12/2/2016 FOR SAVE ISSUE  
            // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 

            //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 





            objForm.action ="../KM/KM_ArticleRating.aspx?From=<%=strFrom%>&OptValue=" + Optvalue +"&ProcedureID=<%=strProcedureID%>&Action=SAVE";

           
            objForm.submit();
            //Added By Reshma Chavan on 22nd Sep 2021 For Refresh Issue on rate Article
            window.onunload = refreshMyParent;
            refreshMyParent();
            //End of Added By Reshma Chavan on 22nd Sep 2021 For Refresh Issue on rate Article
        //Commented by Yogesh J on 07/Dec/2015
        //window.close();
        //End of comment by Yogesh J on 07/Dec/2015
            if ('<%=strFrom %>' == 'HOME') {
            //Commented And Added By Usha Pandit On 25.04.2021 For refresh issue on rating the article
            //window.opener.location.href = "../Km/Km_List.aspx?Fromwhere=LatestFeatured&SelectList=1";
            window.opener.location.href = "../KM/KM_List.aspx?PageNumber=1&Fromwhere=MyArticle&Tab=MY&Subtab=MY PAGES&SelectList=4";
            //window.onunload = refreshParent;
            //function refreshParent() {
            //    window.opener.location.reload();
            //    }
                //End Of Added By Usha Pandit On 25.04.2021 For refresh issue on rating the article
                //Commented by Yogesh J on 07/Dec/2015
                //window.close();
                //End of comment by Yogesh J on 07/Dec/2015
            }
            else {
                //Added by Chetan M on 21 June 2021 for Refresh issue on Rating article in edit
            //    window.onunload = refreshParent;
            //function refreshParent() {
            //    window.opener.location.reload();
            //    }
                //End of Added by Chetan M on 21 June 2021 for Refresh issue on Rating article in edit
                //Commented and Added By Chakshuta H on 22nd-Aug-2016 Purpose:Qa issue fixing
           
                //Commented By Usha Pandit On 04.08.2020 for blank article issue
                //window.opener.location.href = window.opener.location.href;
                //End Of Commented By Usha Pandit On 04.08.2020 for blank article issue
                //window.opener.location.href = "../Km/Km_List.aspx?PageNumber=1&Fromwhere=MyArticle&Tab=MY&Subtab=MY PAGES&SelectList=4";
                //End Of Commented and Added By Chakshuta H on 22nd-Aug-2016 Purpose:Qa issue fixing
                //Commented by Yogesh J on 07/Dec/2015
                //window.close();
                //End of comment by Yogesh J on 07/Dec/2015
            }
        }

         //Added By Reshma Chavan on 22nd Sep 2021 For Refresh Issue on rate Article
        function refreshMyParent() {  
            var url = "";
            if ('<%=CheckFlag%>' == '5') {
                url = "KM_MyPage.aspx?ActionLink=&PageNumber=1&Mode=Edit&Myflag=2&Fromwhere=MyArticle&PageID=<%=strProcedureID%>";
            }
            else {
                url = opener.location.href;
            }           
              opener.location.href = url;
        }
        //End of Added By Reshma Chavan on 22nd Sep 2021 For Refresh Issue on rate Article
         

        
    </script>
</body>
</html>
