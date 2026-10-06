<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_ShowSLAdetails.aspx.vb" Inherits="PbNIT.CRM_ShowSLAdetails"%>
<!DOCTYPE HTML>
<%CommonFunctions.General.PlotPageHeadTag("SLA Details")%>

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
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize = "window_onresize()">
		<form id="frmShowSLADetails" method="post" runat="server">
		<%WritePage()%>
		</form>
	</form>
		<script>
		var objform;
		var objdivlist;		
		objform = GetFormReference('frmShowSLADetails');
		objdivMain = GetObjectReference('frmShowSLADetails','DivMain');
		objdivGrid = GetObjectReference('frmShowSLADetails','divGrid');
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
			function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			
			//WindowLoading();
			intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 50;

			if (intDivHeight < 100)	intDivHeight = 100;
			if(navigator.appName == 'Netscape')
			{
			intDivHeight = document.body.offsetHeight - objdivMain.offsetTop + 80 ;
			}

			objdivMain.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	
			if (objdivGrid !=null)
			{
			    objdivGrid.style.height = intDivHeight - 122 + 'px';//Added By Nilesh g on 11/12/2015
			}
			
					
		}
		
		function window_onresize()
		{
			var intDivHeight;
			var intDivHeightRisk;
			
			UpdateWindowSize();
						
			intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 60;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
			if (objdivGrid !=null)
			{
			    objdivGrid.style.height = intDivHeight - 122 + 'px';//Added By Nilesh g on 11/12/2015
			}	
		
		}
		function SetFilter(e)
		{
			var code;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			if(code==13) 
			{
				if (validateFilter())
				{
					objform.action = "CRM_ShowSLADetails.aspx?ApplyFilter=1&PageNumber=<%=m_intPageNumber%>&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>"
					objform.submit();
				}	
			}
		}
		function validateFilter() 
		{
			if (disallowNonInteger(GetObjectReference("frmShowSLADetails","txtQueryID"),'Please enter only integer value',true)) 
			{ return false; }
			return true;
		}
		function Staus_OnChange()
		{
			if (validateFilter())
				{
					objform.action = "CRM_ShowSLADetails.aspx?ApplyFilter=1&PageNumber=<%=m_intPageNumber%>&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>"
					objform.submit();
				}	
		
		}
		function Sort_OnClick(strSortBy,strAscDesc)		
		{
				if (validateFilter())
				{
						objSortBy = GetObjectReference('frmShowSLADetails','txthdnSortBy');
						objSortOrder = GetObjectReference('frmShowSLADetails','txthdnAscDesc');
						objSortBy.value = strSortBy;
						objSortOrder.value = strAscDesc;
						
						objform.action = "CRM_ShowSLADetails.aspx?ApplyFilter=1&PageNumber=<%=m_intPageNumber%>&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>"
						objform.submit();			
				}
		}
		
		
		
		function Page_OnClick(page)
		{
			objform.action = "CRM_ShowSLADetails.aspx?ApplyFilter=1&PageNumber=" + page + "&Year=<%=m_intYear%>&Mode=<%=m_strMode%>&FilterID=<%=m_filterID%>"
			objform.submit();	
		}	
var noOfPages = GetObjectReference('frmShowSLADetails','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('frmShowSLADetails','txtPageNumber');
function validateNumPaging()
{

	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_OnClick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_OnClick(objtxtpageNumber.value);
	}
}

function txtPageNumber_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumber =  GetObjectReference('frmDashboard','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmDashboard','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"Please enter Page number",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number must be numeric",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number must be positive",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number must be integer",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page Number is not Valid");
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}	
			}
		
		}

		</script>
	</body>
</HTML>
