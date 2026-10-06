<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<!-- <%  CommonFunctions.General.PlotPageHeadTag("")%>  -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration > Security > Group & Access > Node Maintenance.
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:09/02/2015
    /*---------------------------------------------------------*/

    if($('.clsGridTable').length > 0)
    {
        var divName=$('#divListPageTag').find('div:first').attr('id');
        dataCollapse(divName);
    }
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration > Security > Group & Access > Node Maintenance.
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-divListPageTag Height
        // Description:Giving Height to divListPageTag Div on Document Ready
        // By Whom: Miiint
        // When:03/01/2015
        /*---------------------------------------------------------*/
        var frameHeight=$(window).height();
        var divHeight=parseInt((frameHeight/100)*62);
        $('#divListPageTag').height(divHeight);
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-divListPageTag Height
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-context menu
        // Description:display context menu on click of link only
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        var tableId = $('#divListPageTag').find('#divListTag').find('table:first').attr('id');
        display_contextmenu(tableId);

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-contextmenu
        /*---------------------------------------------------------*/
});

$(window).resize(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on Window Resize
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
       // Starts Feature Tag:whiz41-divListPageTag Height
       // Description:Giving Height to divListPageTag Div on Window Resize
       // By Whom: Miiint
       // When:03/01/2015
       /*---------------------------------------------------------*/
       var frameHeight=$(window).height();
       var divHeight=parseInt((frameHeight/100)*62);
       $('#divListPageTag').height(divHeight);

       /*---------------------------------------------------------*/
       // Ends Feature Tag:whiz41-divListPageTag Height
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

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_FunctionalityMaintenance.aspx.vb" Inherits="Whiz.PB_FunctionalityMaintenance" %>

<style>
    #thisIsADummyControl
    {
        display:none;
    }
    /*Added By Chakshuta H on 16th-Nov-2015 Purpose:Footer menu is shifted upwards whenever user takes the cursor from Tree towards the main page.*/
    #divListPageTag
    {
        height:auto !important;
    }
    /*End Of Addition By Chakshuta H on 16th-Nov-2015 Purpose:Footer menu is shifted upwards whenever user takes the cursor from Tree towards the main page.*/
    #divContextMenuCL1890 .footerMenuTable
    {
        background-color:white;
    }
</style>