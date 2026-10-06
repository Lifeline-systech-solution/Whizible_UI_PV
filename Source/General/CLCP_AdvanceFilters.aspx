<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:19/01/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

});

$(window).resize(function(){
    document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on Window Resize
    // By Whom: Miiint
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:12/02/2015
    /*---------------------------------------------------------*/
       responsiveFooterMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
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
});

</script>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CLCP_AdvanceFilters.aspx.vb" Inherits="PbNIT.CLCP_AdvanceFilters" %>
