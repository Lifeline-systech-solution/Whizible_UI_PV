
<!--Including files & Libraries-->
    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
 <%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<script type="text/javascript">

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        var clsTableMenu;

        if ($('.clsPageBody').find('table:first').find('td').size() == 1) {
            $('.clsPageBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsPageBody').find('table:first').addClass('TopInnerMenu');
        clsTableMenu = 'TopInnerMenu';
        //Commented and added by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue
        //responsiveMenu(clsTableMenu);
        responsiveTopMenu();
        //End of addition by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        $('.clsPageBody').find('table:last').addClass('footerMenuTable');
        $('.clsPageBody').find('table:last').find('td').before('<td></td>');
        var footerTableMenu = 'footerMenuTable';
        //Commented and added by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue
        //footerResponsiveMenu(footerTableMenu);
        responsiveFooterMenu();
        //End of addition by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });


    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        var clsTableMenu;

        $('.clsPageBody').find('table:first').addClass('TopInnerMenu');
        clsTableMenu = 'TopInnerMenu';

        //Commented and added by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue
        //responsiveMenuResize(clsTableMenu);
        responsiveTopMenuResize();
        //End of addition by Yogesh Jalamkar on 17-May-2016 for javascript undefined issue
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="GraphSkins_CommonPage.aspx.vb" Inherits="Whiz.GraphSkins_CommonPage"%>