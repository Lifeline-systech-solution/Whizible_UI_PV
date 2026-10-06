<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_DelegateSubNode.aspx.vb" Inherits="PbNIT.PM_DelegateSubNode"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Task Delegation")%>
    
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
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

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
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

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
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

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


    <%--Commented and Added By Ankit P on 16th-September-2015 for Responsive Page--%>
<script src="../../responsive/responsive.js"></script>
    

<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<%--End Of Added By Usha Pandit On 14 Dec 2020 For Jquery Change Version 3.5.1--%>
<script type="text/javascript">
    $(document).ready(function () {
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
    });

    $(document).ready(function () {
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

    $(window).resize(function () {

        // Starts Feature Tag:whiz41-InnerMenuDropDown 
        // Description:Creating DropDown for Table Inner Menu on Window Resize 
        // By Whom: Miiint 
        // When:14/01/2015 
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown 
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize 
        // By Whom: Miiint 
        // When:14/01/2015 
        /*---------------------------------------------------------*/


        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown 
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready 
        // By Whom: Miiint 
        // When:14/01/2015 
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown 
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize 
        // By Whom: Miiint 
        // When:28/05/2015 
        /*---------------------------------------------------------*/


        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
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
    });

    $(window).resize(function () {
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

    $(document).ready(function () {

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
    });

    $(document).ready(function () {
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
        //here we have to apply footable functionality i.e. dataCollapse() as per step 4.1. & then we will write below code 
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs 
        // Description:Display navigation tabs in dropdown 
        // By Whom: Miiint 
        // When:07/02/2015 
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        //Added by Dhanashri S on 27 Jan 2016
        var windowWidth = $(window).width();
        //End of Addition by Dhanashri S on 27 Jan 2016
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs 
        // Description:Display navigation tabs in dropdown 
        // By Whom: Miiint 
        // When:07/02/2015 
        /*---------------------------------------------------------*/
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        responsiveNavigationTabsResize(responsiveNavigationClass);
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Calculate Height for iframes 
        // Description:Giving height to each iframe with respect to window height on Window Resize 
        // By Whom: Miiint 
        // When: 
        /*---------------------------------------------------------*/
        var linkFrame = $('.iframeLinks').outerHeight();
        var iframeHeight = $(window).height() - linkFrame;
        
        //var iframeWin = parent.document.getElementById("Sub");
        //iframeWin.height = iframeHeight;
        
        //var treeHeight = parent.document.getElementById("Main");
        //treeHeight.height = iframeHeight;
        

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Calculate Height for iframes 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Calculate Height for iframes 
        // Description:Giving height to each iframe with respect to window height on Window Resize 
        // By Whom: Miiint 
        // When: 
        /*---------------------------------------------------------*/
        var linkFrame = $('.iframeLinks').outerHeight();
        var iframeHeight = $(window).height() - linkFrame;
        
        //var iframeWin = parent.document.getElementById("Sub");
        //iframeWin.height = iframeHeight;
       
        //var treeHeight = parent.document.getElementById("Main");
        //treeHeight.height = iframeHeight;
        

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Calculate Height for iframes 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-check device is tablet or not 
        // Description:if device is not tablet then set width on document ready 
        // By Whom: Miiint 
        // When: 13/02/2015 
        /*---------------------------------------------------------*/
        if (!(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))) {
            if ($(window).width() < 992) {
                //alert($('#Sub').width()); 
                $('#Sub').css('width', '80%');
            }
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-check device is tablet or not 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-check device is tablet or not 
        // Description:if device is not tablet then set width on Window Resize 
        // By Whom: Miiint 
        // When: 13/02/2015 
        /*---------------------------------------------------------*/
        if (!(/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent))) {
            if ($(window).width() < 992) {
                $('#Sub').css('width', '80%');
            }
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-check device is tablet or not 
        /*---------------------------------------------------------*/
    });

    $(document).ready(function () {
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

    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column 
        // Description:removing plus sign with footable functionality for 'Total' column 
        // By Whom: Miiint 
        // When:27/04/2015 
        /*---------------------------------------------------------*/
        //Added by Dhanashri S on 27 Jan 2016
        var windowWidth = $(window).width();
        //End of Addition by Dhanashri S on 27 Jan 2016
        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column 
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column 
        // Description:removing plus sign with footable functionality for 'Total' column 
        // By Whom: Miiint 
        // When:27/04/2015 
        /*---------------------------------------------------------*/
        //Added by Dhanashri S on 27 Jan 2016
        var windowWidth = $(window).width();
        //End of Addition by Dhanashri S on 27 Jan 2016
        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column 
        /*---------------------------------------------------------*/
    });
</script>

<%--End of Commented and Added By Ankit P on 16th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmPM_DelegateSubNode" method="post" runat="server">
									<%PageInit%>
					</form>
					<Script language="javascript">
		var objform=GetFormReference('frmPM_DelegateSubNode');
		var objdivlist=GetObjectReference('frmPM_DelegateSubNode','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
        }
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
		    	objdivlist.style.height = intDivHeight + 'px';
			}
		}	
		function Save_OnClick()
			{
				var objTxt,count;
				
				objTxt = GetObjectReference('frmRoleAccess','hdtxtRowCount');
				count = objTxt.value;
				
				if(count > 0)
				{
					objform.action = "PM_DelegateSubNode.aspx?EmployeeID=<%=m_lngUserID%>&Action=Save&TagID=<%=m_lngTagID%>";
					objform.submit();
				}
			}
			function ClearAll_OnClick()
			{
				var objTxt;
				var count,indx;
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess;
				var isStyle=false;
				
				objTxt = GetObjectReference('frmRoleAccess','hdtxtRowCount');
				count = objTxt.value;
				
				if(count > 0)
				{
					
											
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd',true);
					objChkEdit = GetObjectReference('frmRoleAccess','chkEdit',true);
					objChkDel = GetObjectReference('frmRoleAccess','chkDelete',true);
					objChkView = GetObjectReference('frmRoleAccess','chkView',true);
				
					for(indx=0;indx<count-1;indx++)
					{
						if(objChkAdd[indx].style != null)
						{		
											
							objChkAdd[indx].checked = false;
							objChkEdit[indx].checked = false;
							objChkDel[indx].checked = false;
							objChkView[indx].checked = false;					
						}						
					}
				}
			}
			function SelectAll_OnClick()
			{
				var objTxt;
				var count,indx;
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess;
				
				objTxt = GetObjectReference('frmRoleAccess','hdtxtRowCount');
				count = objTxt.value;
				
				if(count > 0)
				{
										
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd',true);
					objChkEdit = GetObjectReference('frmRoleAccess','chkEdit',true);
					objChkDel = GetObjectReference('frmRoleAccess','chkDelete',true);
					objChkView = GetObjectReference('frmRoleAccess','chkView',true);
				
					for(indx=0;indx<count-1;indx++)
					{						
						if(objChkAdd[indx].style.display == "")
						{		
											
							objChkAdd[indx].checked = true;
							objChkEdit[indx].checked = true;
							objChkDel[indx].checked = true;
							objChkView[indx].checked = true;					
						}
												
					}
				}
			}
					</Script>
				
	</body>
</HTML>
