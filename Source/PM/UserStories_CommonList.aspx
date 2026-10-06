<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>


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

</style>

<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
           removeSectionHeader();
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
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

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

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
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

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            //Commented and Added by Dhanashri S on 7 Jan 2016 For IssueID : 2946
            //dataCollapse(divName);
            divDatacollapse(divName);
            //End of Comment and Addition by Dhanashri S on 7 Jan 2016
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

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('.clsTable:last').css({ 'display': 'none' });
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


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();

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
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else {
            $('.clsTable:last').css({ 'display': 'block' });
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
</script>

<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UserStories_CommonList.aspx.vb" Inherits="PbNIT.UserStories_CommonList" %>

<SCRIPT Language=javascript>
function Delete_OnClick()
{


    var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete')
if (blnIsRecordSelected == false) {return;}

var objUserStoryIds=GetObjectReference('frmCommonPage','chkDelete',true);
var UserStoryIds = ' ';
for(var i=0;i<objUserStoryIds.length;i++)
{
    if(objUserStoryIds[i].checked == true)
    {
        UserStoryIds = UserStoryIds + ","+objUserStoryIds[i].value;
    }
} 
UserStoryIds = UserStoryIds.substring(1);
try
{ var strUrl="../PM/AjaxCallIteration.aspx?Flag=DeleteEntityValitation&Entity=UserStory&IDs=" + UserStoryIds;
    //objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
if (document.all) {
    objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
}
else {
    objXHttp = new XMLHttpRequest();
}
objXHttp.onreadystatechange = function()
{
if(objXHttp.readyState==4)
{
if(objXHttp.responseText != null)
{
if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
alert(objXHttp.responseText);
else
var data;
data =objXHttp.responseText;
//debugger;
var arrData = data.split('@');
var strMsg = ''
for(var j=0;j<arrData.length;j++)
{
   strMsg = strMsg + '\n' + arrData[j]
}
if(data != "0")
{
   if(confirm(strMsg.substring(1)))
   {
      objfrm.action="../PM/UserStories_CommonList.aspx?Operation=DELETE&Flag=DeleteEntity&MasterTagID=8087&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
      objfrm.submit();
      //document.forms["frmCommonList"].action = "../PM/Releases_CommonList.aspx?MasterTagID=8083&FromWhere=PM";
      //document.forms["frmCommonList"].submit();
      //alert('Records deleted successfully!');
   }
}
else
{
   if(confirm("Are you sure, you want to delete the selected records?"))
   {
    objfrm.action="../PM/UserStories_CommonList.aspx?Operation=DELETE&MasterTagID=8087&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
    objfrm.submit();
}
}
} } }
objXHttp.open("GET",strUrl, false);
objXHttp.send();
} catch(e){}
return;
}
</SCRIPT>