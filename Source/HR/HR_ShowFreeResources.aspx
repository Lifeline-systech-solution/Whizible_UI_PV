<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_ShowFreeResources.aspx.vb" Inherits="PbNIT.HR_ShowFreeResources"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<!--<title>Resource Calender View</title>-->

	<%CommonFunctions.General.PlotPageHeadTag("Free Resources")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>

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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmFreeResources" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		var objdivlist = GetObjectReference('frmFreeResources', 'divList');
		var objfrm=GetFormReference('frmFreeResources');
		var objtblFilter = GetObjectReference('frmFreeResources','tblFilter');
		var ShowFilter='0';		
		
	    	<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		function window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 55;
			}
			else
			{
				intDivHeight = window.innerHeight - 55;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight;
							
		}

		function window_onload()
		{
								
				var intDivHeight ;
				var intDivHeightRisk;
				var lc;
				if (navigator.appName == 'Microsoft Internet Explorer'){
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 55;
				}
				else{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 55;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight;
				objdivlist.HEIGHT = intDivHeight;
										
		}
		
	function Filters_OnClick(show)
	{
		objtblFilter = GetObjectReference('frmFreeResources','tblFilter');
		objimgFilterUp =GetObjectReference('frmFreeResources','imgFilterUp');
		objimgFilterDown =GetObjectReference('frmFreeResources','imgFilterDown');
			
		img1='../../Images/cssImages/Link images/close.gif';
		img2='../../Images/cssImages/Link Images/Filter.gif';    

		if (ShowFilter=='0')
		{						
			objtblFilter.style.left=0;
			objtblFilter.style.top=30;
			objtblFilter.zIndex=99;
			objtblFilter.style.display='';
			
			objimgFilterUp.src=img1;
			objimgFilterUp.alt='Hide filter';
			objimgFilterDown.src=img1;
			objimgFilterDown.alt='Hide filter';
			
			ShowFilter='1';
			
		}
		else if(ShowFilter=='1')
		{
			objtblFilter.style.display='none';
			objimgFilterUp.src=img2;
			objimgFilterUp.alt='Show filter';
			objimgFilterDown.src=img2;
			objimgFilterDown.alt='Show filter';
			
			ShowFilter='0';  
			
		}
	}
	
function SortBy(strFieldName,strAscDesc)
{

	var objSortBy = GetObjectReference('frmFreeResources','img' +strFieldName);
	//var objSortUP = GetObjectReference('frmFreeResources','img' +strFieldName);
	//var sortUP = '../../Images/Sort_up.gif';
		
	if(objSortBy.src == 'http://localhost/WhizibleSem7/Images/SortBy.gif')
	{
		objSortBy.src = '../../Images/Sort_up.gif';
		strAscDesc = 'ASC';
	} 
	else if (objSortBy.src == 'http://localhost/WhizibleSem7/Images/Sort_up.gif')
	{
		objSortBy.src = '../../Images/Sort_Down.gif';
		strAscDesc = 'DESC';
	}
	else if (objSortBy.src == 'http://localhost/WhizibleSem7/Images/Sort_Down.gif')
	{
		objSortBy.src = '../../Images/Sort_up.gif';
		strAscDesc = 'ASC';
	}
		 
	 
   objfrm.action = "HR_ShowFreeResources.aspx?SortBy=" + strFieldName + "&SortOrder=" + strAscDesc; 
   objfrm.submit();
}
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
			var objSortBy, objSortOrder;
			
				objSortBy = GetObjectReference('frmFreeResources','txthidSortBy');
				objSortOrder = GetObjectReference('frmFreeResources','txthidSortOrder');
				objSortBy.value = strFieldName;
				objSortOrder.value = strAscOrDesc;
				objfrm.action = "HR_ShowFreeResources.aspx?SortBy=" + strFieldName + "&SortOrder=" + strAscOrDesc; 
				objfrm.submit();			
	}
		
function Page_OnClick(strPagingAlphabet)
{
	 
   objfrm.action = "HR_ShowFreeResources.aspx?Paging=" +  strPagingAlphabet;
   objfrm.submit();
}
var FromDate = GetObjectReference('frmFreeResources','dtFromDate');
var Role = GetObjectReference('frmFreeResources','cboRole');
var Percentage = GetObjectReference('frmFreeResources','txtAllocationPercent');


function Apply_OnClick()
{
	if(isBlank(FromDate.value))
	{
		alert('Please enter From Date');
		setFocus(FromDate);
		return;
	}
	if(isBlank(Percentage.value))
	{
		alert('Please enter Percentage');
		setFocus(Percentage);
		return;
	}
	if(isBlank(Role.value))
	{
		alert('Please enter Role');
		setFocus(Role);
		return;
	}
	
	
   objfrm.action = "HR_ShowFreeResources.aspx"; 
   objfrm.submit();
}
function Close_Click()
{
	window.close();
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
				var objtxtpageNumber =  GetObjectReference('HR_ShowFreeResources','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('HR_ShowFreeResources','txtNoOfPages');
								
				//if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				if (!disallowBlank(objtxtpageNumber,"Please Enter Page Number.",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number must be Numeric.",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number must be Positive.",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number must be Integer.",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page number is not valid.");
						return;
					}
					AllPage_OnClick(objtxtpageNumber.value);
				}
			}
		
		}
		function AllPage_OnClick(page)
		{		
				objfrm.action = "HR_ShowFreeResources.aspx?PageNumber=" +page;
				objfrm.submit();
		}
		
var noOfPages = GetObjectReference('HR_ShowFreeResources','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('HR_ShowFreeResources','txtPageNumber');
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
		AllPage_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		AllPage_OnClick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		AllPage_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		AllPage_OnClick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{

	if (isBlank(objtxtpageNumber.value))
		AllPage_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		AllPage_OnClick(objtxtpageNumber.value);
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		AllPage_OnClick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		AllPage_OnClick(objtxtpageNumber.value);
	}
}
	
		</script>
	</body>
</HTML>
