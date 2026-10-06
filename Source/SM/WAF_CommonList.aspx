<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>


<%-- Added by Dhanashri S on 14 Oct 2015--%>
        <style>
        .footerMenuTable
        {
            position: absolute;
            bottom: 0px;
            left:0px;       /*added this property to solve footer issue in IE*/
            right: 2px;
            background-color:#E7F1FE;
            height:150px;
            width:115px;
            display: table !important;
    }
        </style>
        <%--End of addition by Dhanashri S on 14 Oct 2014--%>


 <script type="text/javascript">
 $(document).ready(function(){
     /*----------------------------------------------------------*/
     // Starts Feature Tag:whiz41-Application Administration >Page >	Web Form Wizard
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
     // Ends Feature Tag:whiz41-Application Administration >Page >Web Form Wizard
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
     //responsiveFooterMenu();
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
        var divHeight=parseInt((frameHeight/100)*59);
        $('#divListPageTag').height(divHeight);

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-divListPageTag Height
    /*---------------------------------------------------------*/
 });

 $(window).resize(function(){

     /*----------------------------------------------------------*/
     // Starts Feature Tag:whiz41-InnerMenuDropDown
     // Description:Creating DropDown for Table Inner Menu on Window Resize
     // By Whom: Miiint
     // When:14/01/2015
     /*---------------------------------------------------------*/
     responsiveTopMenuResize()
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WAF_CommonList.aspx.vb" Inherits="Whiz.WAF_CommonList" %>