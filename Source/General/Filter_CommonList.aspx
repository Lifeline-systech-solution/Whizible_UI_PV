<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<!-- <%  CommonFunctions.General.PlotPageHeadTag("")%>  -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function()
{

   /*----------------------------------------------------------*/
   // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
   // Description:Apply FooTable
   // By Whom: Miiint
   // When:17/02/2015
   /*---------------------------------------------------------*/
    if($('.clsGridTable').length > 0)
    {
        dataCollapse();
    }

   /*---------------------------------------------------------*/
   // Ends Feature Tag:whiz41-Apply FooTable
   /*---------------------------------------------------------*/

   /*----------------------------------------------------------*/
   // Starts Feature Tag:whiz41-InnerMenuDropDown
   // Description:Creating DropDown for Top Table Inner Menu on document Ready
   // By Whom: Miiint
   // When:17/02/2015
   /*---------------------------------------------------------*/
    responsiveTopMenu();
   /*---------------------------------------------------------*/
   // Ends Feature Tag:whiz41-InnerMenuDropDown
   /*---------------------------------------------------------*/

   /*----------------------------------------------------------*/
   // Starts Feature Tag:whiz41-InnerMenuDropDown
   // Description:Creating DropDown for Footer Table Inner Menu on document Ready
   // By Whom: Miiint
   // When:17/02/2015
   /*---------------------------------------------------------*/
    responsiveFooterMenu();
   /*---------------------------------------------------------*/
   // Ends Feature Tag:whiz41-InnerMenuDropDown
   /*---------------------------------------------------------*/

});

$(window).resize(function(){

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Top Table Inner Menu on Window Resize
// By Whom: Miiint
// When:17/02/2015
/*---------------------------------------------------------*/
responsiveTopMenuResize();
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Footer InnerMenuDropDown
// Description:Creating DropDown for Footer Table Inner Menu on Window Resize
// By Whom: Miiint
// When:17/02/2015
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


<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Filter_CommonList.aspx.vb" Inherits="Whiz.Filter_CommonList" %>
