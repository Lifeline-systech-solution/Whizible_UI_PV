<!--Including files & Libraries by Miiint Solutions-->
<!-- <%CommonFunctions.General.PlotPageHeadTag("")%> -->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->


<script type="text/javascript" src="../General/responsive/responsive.js"></script>


<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Report >Report Builder
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
    // Ends Feature Tag:whiz41-Application Administration >Report >	Report Builder
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

});


$(window).resize(function(){

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
    // When:21/01/2015
    /*---------------------------------------------------------*/

    responsiveFooterMenuResize();

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/
});
</script>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_CommonList.aspx.vb" Inherits="Whiz.CRW_CommonList"%>