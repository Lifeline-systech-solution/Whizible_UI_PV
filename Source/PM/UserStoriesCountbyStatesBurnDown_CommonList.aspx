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



<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UserStoriesCountbyStatesBurnDown_CommonList.aspx.vb" Inherits="PbNIT.UserStoriesCountbyStatesBurnDown_CommonList" %>

<script language="Javascript">
//objform = GetFormReference('frmCommonList');
function FromDate_onKeyPress(e){
		<%if m_UseEditableDateControl = true then%>
		var keynum
		var objFromDate = GetObjectReference('frmCommonList','FromDate');
		if(window.event) // IE
		{ keynum = e.keyCode }
		else if(e.which) // Netscape/Firefox/Opera</DIV>
		{ keynum = e.which }
 		if (keynum==13) 
		{
		
		str = DateControl_StandardOnblur('frmCommonList','FromDate','<%=strInputdateFormat%>','')
		
		if (str==false)
		{
		 return;
		} 
				
		}
		<%end if%>
		}
		       
// fn.. to display the calendar control
		
function ShowActivityView(Flag)
	 {	
		var objform;
		objform = GetFormReference('frmCommonList');
		
		objtype = GetObjectReference('frmCommonList','cboType')
		var valtype = objtype.options[objtype.selectedIndex].innerHTML
						            
		var objdtmFromDate=GetObjectReference('','fromDate');
	    var objdtmToDate=GetObjectReference('','ToDate');
	    if (Flag=="Show" )
	    {
	        if (valtype=="")
	        {
	            alert('Please select type for user stories count!');
                return;
	        }
	        else if(objdtmFromDate.value=="" && objdtmToDate.value=="")
            {
                 alert('Please select From Date and To Date!');
                 return;
            }
	        else if(objdtmToDate.value!="" && objdtmFromDate.value=="")
	        {
                 alert('Please select From Date!');
                 return;
	        }
	        else if(objdtmFromDate.value!="" && objdtmToDate.value=="")
	        {
                 alert('Please select To Date!');
                 return;
	        }
	        		    		    //Added by NitinC on 23 April 2012  for WhizibleSEM 11.0 [Issue Fix : 61506]
	        else if(disallowDate1GreaterThanDate2(objdtmFromDate,objdtmToDate))
	        {
	            alert('From Date should be less than To Date!');
		        return;
	        }
		    //End of Added by NitinC on 23 April 2012  for WhizibleSEM 11.0 [Issue Fix : 61506]

	        else
	        {
		        objform.action ="../PM/UserStoriesCountbyStatesBurnDown_CommonList.aspx?MasterTagID=9008&FromWhere=PM&Mode=Show&FromDate="+objdtmFromDate.value+"&ToDate="+objdtmToDate.value+"&Flag="+valtype;
		        objform.submit();
	        }
	    }
	    else if (valtype!="")
	    {
	        objform.action ="../PM/UserStoriesCountbyStatesBurnDown_CommonList.aspx?MasterTagID=9008&FromWhere=PM&Mode=Show&FromDate="+objdtmFromDate.value+"&ToDate="+objdtmToDate.value+"&Flag="+valtype;
		    objform.submit();
	    }
	 }
	 function change_date(e)
			{
			  var keynum
			  if(window.event) // IE
	          {
	               keynum = e.keyCode
			   }
			else if(e.which) // Netscape/Firefox/Opera
			 {
			   keynum = e.which
			 }
            if (keynum==13)
            {
              //document.forms['DA'].action = 'PM_DailyActivity.aspx?FromWhere=DA&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          //document.forms['DA'].submit()
	         /* window.location = 'PM_DailyActivity.aspx?FromWhere=DA&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          window.opener = 'PM_DailyActivity.aspx?FromWhere=DA&yes=yes&txtDate='+ document.forms['DA'].elements['txtDate'].value;
	          window.document.refresh; */
	         window.focus()
	         }
           }
</script>