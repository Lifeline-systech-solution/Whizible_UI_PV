<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_YesterdayActivity.aspx.vb" Inherits="PbNIT.PM_YesterdayActivity" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>

<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("DailyActivityWeeklyView")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmScrumActivityView" method="post" runat="server">
						
									<%PageInit%> 
							
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmScrumActivityView');
		var objdivlist=GetObjectReference('frmScrumActivityView','PageDiv');
		
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight;	
			}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight;	
			}
		}	
	
		function FromDate_onKeyPress(e){
		<%if m_UseEditableDateControl = True Then%>
		var keynum
		var objFromDate = GetObjectReference('frmScrumActivityView','FromDate');
		if(window.event) // IE
		{ keynum = e.keyCode }
		else if(e.which) // Netscape/Firefox/Opera</DIV>
		{ keynum = e.which }
 		if (keynum==13) 
		{
		
		str = DateControl_StandardOnblur('frmScrumActivityView','FromDate','<%=strInputdateFormat%>','')
		
		if (str==false)
		{
		 return;
		} 
		
		
		}
		<%end If%>
		}
		
        
// fn.. to display the calendar control
	
	
	
		//commented and added by Nilesh g on 13/1/2015 for issue id 2986	
	   //var objdtmFromDate=GetObjectReference('','fromDate');
		var objdtmFromDate = GetObjectReference('', 'FromDate');
	    var objdtmToDate=GetObjectReference('','ToDate');	
	 function ShowActivityView()
	 {
	    //debugger; 
	   if(objdtmFromDate.value!="")
		{ 
		 if(objdtmToDate.value=="")
		 {
		 alert('Please Select End Date!');
		 return;
		 }	  
		} 
	    if(objdtmToDate.value!="")
		{ 
		 if(objdtmFromDate.value=="")
		 {
		 alert('Please Select Start Date! ');
		 }	  
	    }
	    if(objdtmToDate.value=="" && objdtmFromDate.value=="")
		{
	     alert('StartDate and Enddate is mandatory!');
		}
        if(objdtmToDate.value!="" && objdtmFromDate.value!="")
		{
	    objform.action ="../PM/PM_YesterdayActivity.aspx?MasterTagID=8094&FromWhere=PM&Mode=Show&FromDate="+objdtmFromDate.value+"&ToDate="+objdtmToDate.value;
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
           
          function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}
		
}

var objtxtpageNumber =  GetObjectReference('frmScrumActivityView','txtPageNumber');
var objtxtNoOfPages = GetObjectReference('frmScrumActivityView','txtNoOfPages');

if(GetObjectReference('frmScrumActivityView','txtNoOfPages'))
{	
	var noOfPages = GetObjectReference('frmScrumActivityView','txtNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmScrumActivityView','txtPageNumber');
}
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
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}
		
}

function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_Onclick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
    
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{  

		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}		 
		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
				 
		Page_Onclick(objtxtpageNumber.value);
		 
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_Onclick(objtxtpageNumber.value);
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
			
				var objtxtpageNumber =  GetObjectReference('frmScrumActivityView','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmScrumActivityView','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
					
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						return;
					}
					Page_Onclick(objtxtpageNumber.value);
				}	
			}
		
		}
		//For Added Requirements
function ShowPreviousPage1()
{
	if (isBlank(objtxtpageNumber1.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber1.value==1){alert("This is the first page");return;}
			objtxtpageNumber1.value=objtxtpageNumber1.value -1;
		Page_Onclick(objtxtpageNumber1.value);
	}
		
}

var objtxtpageNumber1 =  GetObjectReference('frmScrumActivityView','txtPageNumber1');
var objtxtNoOfPages1 = GetObjectReference('frmScrumActivityView','txtNoOfPages1');

if(GetObjectReference('frmScrumActivityView','txtNoOfPages1'))
{	
	var noOfPages1 = GetObjectReference('frmScrumActivityView','txtNoOfPages1').value;
	var objtxtpageNumber1 =  GetObjectReference('frmScrumActivityView','txtPageNumber1');
}
function validateNumPaging()
{

	if(isNaN(objtxtpageNumber1.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	
	if(parseInt(noOfPages1)<parseInt(objtxtpageNumber1.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages1);
		return false;
	}
	return true;
}
function ShowPreviousPage1()
{
	if (isBlank(objtxtpageNumber1.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber1.value==1){alert("This is the first page");return;}
			objtxtpageNumber1.value=objtxtpageNumber1.value -1;
		Page_Onclick(objtxtpageNumber1.value);
	}
		
}

function ShowFirstPage1()
{
	if (isBlank(objtxtpageNumber1.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber1.value==1){alert("This is the first page");return;}
		objtxtpageNumber1.value=1;
		Page_Onclick(objtxtpageNumber1.value);
	}
}
function ShowNextPage1()
{
    
	if (isBlank(objtxtpageNumber1.value))
		Page_Onclick(1);
	else
	{  

		if(!validateNumPaging())
		return;
		if (objtxtpageNumber1.value==parseInt(noOfPages1)){alert("This is the last page");return;}		 
		objtxtpageNumber1.value=parseInt(objtxtpageNumber1.value) + 1;
				 
		Page_Onclick(objtxtpageNumber1.value);
		 
	}
}
function ShowLastPage1()
{
	if (isBlank(objtxtpageNumber1.value))
		Page_Onclick(noOfPages1);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber1.value==noOfPages1){alert("This is the last page");return;}
		objtxtpageNumber1.value=noOfPages1;
		Page_Onclick(objtxtpageNumber1.value);
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
			
				var objtxtpageNumber1 =  GetObjectReference('frmScrumActivityView','txtPageNumber1');
				var objtxtNoOfPages1 = GetObjectReference('frmScrumActivityView','txtNoOfPages1');
				if (!disallowBlank(objtxtpageNumber1,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber1,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber1,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber1,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber1.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber1.value) > Number(objtxtNoOfPages1.value) ) 
					{
					
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						return;
					}
					Page_Onclick(objtxtpageNumber1.value);
				}	
			}
		
		}
		//
		function Page_Onclick(PageNumber)
		{
			 
			 strLocation = "PM_YesterdayActivity.aspx?PageNumber=" + PageNumber+"&MasterTagID=8094&FromWhere=PM&Mode=Show&FromDate="+objdtmFromDate.value+"&ToDate="+objdtmToDate.value;
			
			objform.action = strLocation
			objform.submit();
		}
		function Edit_OnClick(ID,Flag)
        {
    
	        //debugger;
	        if (Flag == "User Story")
	        {
	            window.open("../PM/UserStories_CommonPage.aspx?UserStoryID_PK=" + ID +"&MasterTagID=8087&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
    	        
	            //../General/CommonPage.aspx?MastertagID=20121&<PARAMETERS>,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400"
	            //http://localhost/WhizibleSEM10.0/Source/General/CommonPage.aspx?ReleaseID_PK=18&PKToken=CtkJ4r9WgFYvvlNmMoZ0/w&MasterTagID=8083&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1
	        }
	        if (Flag == "Task")
	        {
	            //window.open("../General/CommonPage.aspx?IterationID_PK=" + ID +"&MasterTagID=8084&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
	        }
	        if (Flag == "Feature")
	        {
	            window.open("../General/CommonPage.aspx?FeatureID_PK=" + ID +"&MasterTagID=8085&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
	        } 
	        if (Flag == "Issue")
	        {
	            window.open("../PM/IssueMapping_CommonPage.aspx?IssueID_PK=" + ID +"&MasterTagID=8090&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
	        }  
			
        }
        function Back_OnClick()	
		{
		window.location.href="PM_Scrum_ViewOtherReports.aspx?MasterTagID=9010&FromWhere=PM"	
		}	
		
	</Script>
			
	</body>
</HTML>
