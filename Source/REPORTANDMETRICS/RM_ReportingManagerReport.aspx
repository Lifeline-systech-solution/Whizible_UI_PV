<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ReportingManagerReport.aspx.vb" Inherits="PbNIT.RM_ReportingManagerReport" %>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script src="../../responsive/responsive.js"></script>

 <script type="text/javascript">
     $(document).ready(function () {
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
     });


     $(window).resize(function () {
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->

<!--Added by Yogesh J on 13 OCt 2015 for footer note-->
<style>
   
      /*Added by Yogesh J on 04-Nov-2015*/
            #divList2>.clsTable td {
                padding-left:5px !important;
            }
    .footerMenuTable
    {
        position:relative!important;
    }
             /*End of addition by Yogesh J on 04-Nov-2015*/
</style>
<!--End addition by Yogesh J on 13 OCt 2015 for footer note-->