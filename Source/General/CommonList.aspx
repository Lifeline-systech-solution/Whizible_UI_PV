<!--Including files & Libraries by Miiint Solutions-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CommonList.aspx.vb" Inherits="PbNIT.CommonList" %>


<%--/*Commented & Added By Pradip P On 17-10-2022 For JQuery Version*/--%>

<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<%--/*End of Commented & Added By Pradip P On 17-10-2022 For JQuery Version*/--%>


<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js" type="text/javascript"></script>

<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }
    /*ADDED BY NILESH G ON 2/11/2015 FOR HIDE TEXTBOX ON EMPLOYEE PAGE */
    #thisIsADummyControl
    {
        display:none;
    }
     /*ENDED BY NILESH G ON 2/11/2015 FOR HIDE TEXTBOX ON EMPLOYEE PAGE */

     /*Added By Dipali Vekhande content 6th July 2020 for if filter not applicable then note should be hide*/ 
    #tblPL03979 {

        display:none;
    }
     /*Added By Dipali Vekhande content 6th July 2020 for if filter not applicable then note should be hide*/

   /*COMMENTED BY NILESH G ON 23/12/2015*/
      /*.tableHeaderParentDiv
    {
        height:auto !important;
    }*/
    /*Integrated for project listing new UI*/
   .clsBody {border: none !important;padding: 0px !important;margin: 0px !important;}
    .bgwhite, #frmCommonList table {background-color:#fff !important;}
    #frmCommonList TR.clsTRMenu {height:30px;}
    #frmCommonList table.clsTable.topInnerMenu {margin: 10px 0px;}
    #frmCommonList .clsTRPageCaption {background-color:#EEF2FF;padding:10px 15px;display:table;width:98%;margin:0px 0px 10px;}
    #frmCommonList .clsTRPageCaption td {color: #2563EB;margin: 0px;font-size:16px !important;padding: 0px !important;}
    /*#frmCommonList > table:nth-child(9) > tbody > tr > td:nth-child(1) {display:none;}*/
    #frmCommonList > table:nth-child(9) > tbody > tr > td[align="right"] {display:block !important;}
    /*#frmCommonList > table:nth-child(21), #frmCommonList > table:nth-child(17) > tbody > tr, #frmCommonList > table:nth-child(22) > tbody > tr, #frmCommonList > table:nth-child(24) > tbody > tr, #frmCommonList > table:nth-child(19) > tbody > tr {display:none;}*/
    #frmCommonList #divListTag .clsGridTable .clsTRColumnHeader th:not(.divListTag), #frmCommonList #divListTag TR.clsTRSectionHeader, #frmCommonList .clsGridTable .clsTRColumnHeader th {padding: 8px;background: #dfe6ff  !important;color: #000 !important;}
    #frmCommonList #divListTag TR.clsTRSectionHeader td, #frmCommonList .clsGridTable td {padding:8px !important;}
    #tblCap02003 > tbody > tr > td:nth-child(2) {padding-right: 20px !important;}
    
    /*Integrated for project listing new UI*/  
  
   /*Added Rutuja D. content 8 April 2020 for IssueID = 23235*/
    #frmCommonList .clsTRPageCaption td select {
    color: #000;
}
   /*End Added Rutuja D. content 8 April 2020 for IssueID = 23235*/
   #divListPageTag, #divListTag{min-height:104px}
</style>

<script type="text/javascript">

   
$(document).ready(function()
{
       CL_window_onload();
    
/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Web Form Extension Type
// Description:Remove section header row in Tablet and Mobile view
// By Whom: Miiint
// When:23/01/2015
    /*---------------------------------------------------------*/
    //Added By Vidya J ON 15-12-2015
    if (getParameterByName("MasterTagID") == "8067" || getParameterByName("MasterTagID") == "2184" || getParameterByName("MasterTagID") == "3836" || getParameterByName("MasterTagID") == "1034" || getParameterByName("MasterTagID") == "23" || getParameterByName("MasterTagID") == "1207" || getParameterByName("MasterTagID") == "1025" || getParameterByName("MasterTagID") == "2044" || getParameterByName("MasterTagID") == "1024")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
    {

    }
    else {
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            // removeSectionHeader();  COMMENTD BY NILESH G ON 23/12/2015

  
        }
    }
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Web Form Extension Type
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Remove plus(+)in Tablet and Mobile view
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/

    /*Generating 'id' for table row if it has no 'id'*/
    if (getParameterByName("MasterTagID") == "2349")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
 {

 }
 else {
     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01207').find('tbody').find('tr').each(function () {

         var rowIndex = $(this).index();
         var attr = $(this).attr('id');
         // For some browsers, `attr` is undefined;
         // for others, `attr` is false. Check for both.
         if (typeof attr !== typeof undefined && attr !== false) {
         }

         else {
             $(this).attr('id', 'rowId' + rowIndex);
         }
     });

     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01207').addClass('large_visible');
     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01207').after('<div id="reviewTypeContent"></div>');
     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01207').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
         $(this).remove();
     });
     $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');
 }
    /*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Remove plus(+)in Tablet and Mobile view
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/

    if (getParameterByName("MasterTagID") == "2123")        // added BY Nilesh g ON 5/12/2015 for IssueID:2629
    {
        $('table').attr('width', '100%');
    }

    if (getParameterByName("MasterTagID") == "2349")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
{
    document.body.style.height = window.innerHeight - 4 + 'px';
}
else {
    /*Generating 'id' for table row if it has no 'id'*/
    $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01025').find('tbody').find('tr').each(function () {

        var rowIndex = $(this).index();
        var attr = $(this).attr('id');
        // For some browsers, `attr` is undefined;
        // for others, `attr` is false. Check for both.
        if (typeof attr !== typeof undefined && attr !== false) {
        }

        else {
            $(this).attr('id', 'rowId' + rowIndex);
        }
    });
    //Commented By RehanC for Double Entires on 13th April 2023
    //$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01025').addClass('large_visible');

    //$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01025').after('<div id="reviewTypeContent"></div>');
    //$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01025').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
    //$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
    //    $(this).remove();
    //});
    //$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');
    //End of Comment By RehanC
}
    
    /*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Remove plus(+)in Tablet and Mobile view
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/

/*Generating 'id' for table row if it has no 'id'*/
$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid02022').find('tbody').find('tr').each(function(){

    var rowIndex=$(this).index();
    var attr = $(this).attr('id');
    // For some browsers, `attr` is undefined;
    // for others, `attr` is false. Check for both.
    if (typeof attr !== typeof undefined && attr !== false)
    {
    }

    else
    {
        $(this).attr('id','rowId'+rowIndex);
    }
});

$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid02022').addClass('large_visible');

$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid02022').after('<div id="reviewTypeContent"></div>');
$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid02022').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function()
{
      $(this).remove();
});

$('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Apply Footable For Grids
// Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
// By Whom: Miiint
// When:17/01/2015
    /*---------------------------------------------------------*/
    //Added By Vidya J ON 15-12-2015
    //Commented and added by Yogesh Jalamkar on 08-Nov-2016 Purpose: UI is misaligned
    //if (getParameterByName("MasterTagID") == "8067" || getParameterByName("MasterTagID") == "2184" || getParameterByName("MasterTagID") == "3836" || getParameterByName("MasterTagID") == "1034" || getParameterByName("MasterTagID") == "23" || getParameterByName("MasterTagID") == "1207" || getParameterByName("MasterTagID") == "1025" || getParameterByName("MasterTagID") == "2044" || getParameterByName("MasterTagID") == "1024") {      // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
    if (getParameterByName("MasterTagID") == "8067" || getParameterByName("MasterTagID") == "2184" || getParameterByName("MasterTagID") == "3836" || getParameterByName("MasterTagID") == "1034" || getParameterByName("MasterTagID") == "23" || getParameterByName("MasterTagID") == "1207" || getParameterByName("MasterTagID") == "1025" || getParameterByName("MasterTagID") == "2044" || getParameterByName("MasterTagID") == "1024" || getParameterByName("MasterTagId") == "3698") {      // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
  //End of addition by Yogesh Jalamkar on 08-Nov-2016
}
else {
   
    if ($('.clsGridTable').length > 0) {
        var divName = $('#divListPageTag').find('div:first').attr('id');
        dataCollapse(divName);
    }
}

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Table Inner Menu on document Ready
// By Whom: Miiint
// When:14/01/2015
/*---------------------------------------------------------*/
    //Added By Vidya J ON 15-12-2015
if (getParameterByName("MasterTagID") == "2184" || getParameterByName("MasterTagID") == "3836" || getParameterByName("MasterTagID") == "1034" || getParameterByName("MasterTagID") == "23" || getParameterByName("MasterTagID") == "1207" || getParameterByName("MasterTagID") == "1025" || getParameterByName("MasterTagID") == "2044" || getParameterByName("MasterTagID") == "1024")
{

}

else
{
    responsiveTopMenu();
}
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Apply FooTable
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/
    if (getParameterByName("MasterTagID") == "8067")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
    {

    }
    else {
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01207').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');
    }
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Apply FooTable
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/
    if (getParameterByName("MasterTagID") == "8067")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
    {

    }
    else {
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01025').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');
    }
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
// Description:Apply FooTable
// By Whom: Miiint
// When:17/01/2015
/*---------------------------------------------------------*/
    if (getParameterByName("MasterTagID") == "8067")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
    {

    }
    else {
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid02022').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');
    }
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Remove footer
// Description:Display none footer in Tablet and Mobile view
// By Whom: Miiint
// When:16/01/2015
/*---------------------------------------------------------*/
 /* Display none footer in Tablet and Mobile view*/

var windowWidth=$(window).width();
if(windowWidth < 992 )
{
    //Commented and added  by Nilesh g on 8/12/0015 for bottom line issue
    // $('.clsTable:last').css({'display':'none'});
 //   $('.clsTable:last').css({ 'visibility': 'hidden' });
}
else
    if (getParameterByName("MasterTagID") != "22187") {
        $('.clsTable:last').css({ 'display': 'block' });
    }

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Remove footer
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

if (getParameterByName("MasterTagID") == "8067")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
{

}
else {
    /* Add class to Total Record Table*/
    $('.clsBody').find('table:last').prev().prev().addClass('recordTable');
}

});// Ready Function Ends

$(window).resize(function(){
CL_window_onresize();

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-collapse & close for tablet view
// Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
// By Whom: Miiint
// When:17/02/2015
    /*---------------------------------------------------------*/
    //Added By Vidya J ON 15-12-2015
if (getParameterByName("MasterTagID") == "8067" || getParameterByName("MasterTagID") == "2184" || getParameterByName("MasterTagID") == "3836" || getParameterByName("MasterTagID") == "1034" || getParameterByName("MasterTagID") == "23" || getParameterByName("MasterTagID") == "1207" || getParameterByName("MasterTagID") == "1025" || getParameterByName("MasterTagID") == "2044" || getParameterByName("MasterTagID") == "1024")        // MODIFIED BY PUNEET M ON 25-11-2015 IssueID:1992
{

}
else {
    collapseDivsResize();
}
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
// Starts Feature Tag:whiz41-Remove footer
// Description:Display none footer in Tablet and Mobile view
// By Whom: Miiint
// When:16/01/2015
/*---------------------------------------------------------*/
/* Display none footer in Tablet and Mobile view*/

var windowWidth=$(window).width();
if(windowWidth < 992 )
{
    //Commented and added  by Nilesh g on 8/12/0015 for bottom line issue
    //$('.clsTable:last').css({'display':'none'});
    //$('.clsTable:last').css({ 'visibility': 'hidden' });
}
else
{
    $('.clsTable:last').css({'display':'block'});
}
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Remove footer
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

// ADDED BY PUNEET M ON 25-11-2015
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
// ENDED BY PUNEET M ON 25-11-2015.
//Added by swapnil aswale on 27th Nov 2015 for browser compatibility
function NAME(NAME) {
    var i; objParentCombo = window.opener.document.getElementById('cboDataSource');
    for (i = 0; i < objParentCombo.length; i++) {
        if (objParentCombo[i].value == NAME) objParentCombo.selectedIndex = i;
    }
    if (window.opener.document.getElementById('cboFKFieldName') != null) {
        var objForm = window.opener.document.getElementById('frmInitialTabProperties');
        var objtxtHidden = window.opener.document.getElementById('txtInputHidden');
        objtxtHidden.value = 'False';
        objForm.submit();
    }
    window.close(); return;
    window.open("DummyPage.aspx?NAME=" + NAME, "");
}
    //Ended
</script>

