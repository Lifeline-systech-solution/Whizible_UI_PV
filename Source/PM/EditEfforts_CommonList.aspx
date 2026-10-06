<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
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
            dataCollapse(divName);
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



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EditEfforts_CommonList.aspx.vb" Inherits="PbNIT.EditEfforts_CommonList" %>

<script language="javascript">
function SaveList_OnClick(intUniqueID)
{   
 //debugger;
      var objChkDelete = GetObjectReference('','chkDelete',true);
      var objtxtEfforts = GetObjectReference('','Effort',true);
      var iCount,ECount;
      var chkCount;
      chkCount = 0;
      for (ECount = 0;ECount<objtxtEfforts.length;ECount++)
      {
            if(disallowNonNumeric(objtxtEfforts[ECount],"Efforts should be numeric only !",true))
	                return ;
      }
      for (iCount = 0;iCount<objChkDelete.length;iCount++)
      {
            if(objChkDelete[iCount].checked == true)
            {
                chkCount = chkCount + 1;
                break;
            }
      }
      if (chkCount < 1)
      {
        alert('Please select atleast one record!');
        return false;
      }
      else if(chkCount > 0)
      {
            if(confirm("Are you sure, you want to save selected records?"))
            {
                objfrm.action="../PM/EditEfforts_CommonList.aspx?Mode=Save&MasterTagID=9001"
                objfrm.submit();
                //objParentobj = GetParentFormReference('frmPrioritization');
               //objParentobj.action="../PM/PM_Prioritization.aspx?MasterTagID=8096&FromWhere=PM"
                //objParentobj.submit();
                refreshParent('frmPrioritization','PM_Prioritization.aspx','PM_Prioritization.aspx?MasterTagID=8096&FromWhere=PM&isStory=1&isBug=1&isList=0');
                return;
            }
      }
      else
      {
         return false;
      }
}

/*function Close_Click()
{
    //For Firefox
    //debugger;
    if (navigator.appName == 'Microsoft Internet Explorer')
    {
      //for IE
        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).frameElement.style.display='none';
        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).frameElement.src="";
      
    }
    else
    { 
    
        window.parent.frames['iFloatingMenu'].frameElement.style.display='none';
        window.parent.frames['iFloatingMenu'].frameElement.src="";
        
        
    }
    return; 

}*/

    function AssignIssue_OnClick(IssueId,strToken)
	{
	//debugger;
		//Purpose: Not allow to do any activity if Project is not baselined 	
			if ("<%=m_blnIsProjectCreationWorkflowReqd%>"== "True")
			{
			if ("<%=m_intBaselineNumber%>"== 0)
			    {
			 		alert("Project related activities such as adding Task or Resource or Timesheet entry cannot be performed as the Project is not Baselined." );
                    return;
                }
            }      
            var intFixInDays=''
		
		window.open ("../IB/IB_IssueAssignment.aspx?IssueID="+IssueId+"&PKToken="+strToken+"&FixInDays=" + intFixInDays,"_IssueAssignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=900,height=400");
	}
	function MapToIteration_OnClick(UserStoryID)
	{
	    window.open ("../General/CommonPage.aspx?MastertagID=8091&Mode=Prioritize&UserStoryID="+UserStoryID,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
	}
	function MapIssue_OnClick(IssueId)
	{
	    window.open ("../PM/IssueMapping_CommonPage.aspx?IssueID_PK="+IssueId+"&MasterTagID=8090&FromWhere=PM&Mode=Prioritize","MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
	}

</script>