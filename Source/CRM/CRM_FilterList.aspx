<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_FilterList.aspx.vb" Inherits="PbNIT.CRM_FilterList" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Filters")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">

    

    $(document).ready(function ()
    {
        setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader

        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id='frmFilterList' method='post' runat='server'>
		<%WritePage()%>
		</form>
        <link href="../General/loaderStylesheet.css" rel="stylesheet" />
		<script language="javascript">

		    window.onload = function () {
		        RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
		    }
		    var objform;
		var objdivlist;
				
		objform = GetFormReference('frmFilterList');
		objdivlist = GetObjectReference('frmFilterList','divList');
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function Sort_OnClick(sortby,sortorder)
		{
			window.location.href = "CRM_FilterList.aspx?FromWhere=<%=m_strFromWhere%>&SortBy=" + sortby + "&SortOrder=" + sortorder + "&PageNumber=<%=m_strAlphabet%>";
		}
		
		function Page_OnClick(alphabet)
		{
			window.location.href = "CRM_FilterList.aspx?FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNumber=" + alphabet;
		}
		
		function AddNew_OnClick()
		{
			window.location.href = "CRM_FilterDetail.aspx?Mode=NEW&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNUmber=<%=m_strAlphabet%>";
		}
		
		function Filter_OnClick(filterid)
		{
			window.location.href = "CRM_FilterDetail.aspx?Mode=EDIT&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNUmber=<%=m_strAlphabet%>&FilterID=" + filterid ;
		}
		
		function SetAsDefault_OnClick(filterid)
		{
			window.location.href = "CRM_FilterList.aspx?Action=SET_DEFAULT&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNUmber=<%=m_strAlphabet%>&DefaultFilterID=" + filterid ;
		}
			
		function Delete_OnClick()
		{
			if (confirm("Are you sure, you want to delete the selected filters?"))
			{
				objform.action = "CRM_FilterList.aspx?Action=DELETE&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNUmber=<%=m_strAlphabet%>";
				objform.submit();
			}
		}
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 40; //Added By Vaijat K ON 14/12/2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	//Added By Nilesh g on 11/12/2015
			if ("<%=m_intRefresh%>" == "1")
			{
				window.opener.location.href=replaceSubstring(window.opener.location.href,'Action=','Action1=');
			} 
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 40; //Added By Vaijat K ON 14/12/2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	//Added By Nilesh g on 11/12/2015	
		}
		</script>
	</body>
</HTML>
