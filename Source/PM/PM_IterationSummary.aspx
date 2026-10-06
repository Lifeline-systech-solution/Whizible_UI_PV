<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_IterationSummary.aspx.vb" Inherits="PbNIT.PM_IterationSummary" %>

<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    
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


	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()" style="visibility:hidden">
	<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 );}
	#Tajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	#Tajax_tooltipObj DIV { POSITION: absolute; }
	#Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; BORDER-RIGHT: red 2px solid; BORDER-BOTTOM: red 2px solid; BORDER-TOP: red 2px solid; BORDER-LEFT: red 2px solid; }
	#Bajax_tooltipObj DIV { POSITION: absolute; }
	#Tajax_tooltipObj .ajax_tooltip_TLarrow { BACKGROUND-POSITION: right top; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }
	#Bajax_tooltipObj .ajax_tooltip_BRarrow { BACKGROUND-POSITION: bottom right ; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/BRarrow.gif'); BACKGROUND-REPEAT: no-repeat; }
	#Tajax_tooltipObj .ajax_tooltip_Tcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; top:18px }
	#Bajax_tooltipObj .ajax_tooltip_Bcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	</STYLE>	
		<form id="frmIterationSummary" name="frmIterationSummary" method="post" runat="server" >
			<%PageInit()%>
						
		
			</form>		
	
		<script language="Javascript">
			var flagSubmit = true;
			var controlArray;
			
			
			objform=GetFormReference('frmIterationSummary');
			objDivMain=GetObjectReference('frmIterationSummary','DivList');
				
			var blnisSaved = 0; 
			
			 
			 
			 
			 
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
		
				document.body.style.visibility='visible';
				 
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
					

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			//objDivMain.style.height = intDivHeight ;
				objDivMain.style.height = intDivHeight + 'px'	;
				
				intMaxEntry = 24;
				
			
			}
			
			function window_onresize()		
			{
				
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
					

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
				if (intDivHeight < 100)
					intDivHeight = 100;
				//objDivMain.style.height = intDivHeight	;	
				
			}
			function Name_OnClick(ID,Flag)
			{
			    //debugger;
			    if (Flag == "RELEASE")
			    {
			        window.open("../PM/Releases_CommonPage.aspx?ReleaseID_PK=" + ID +"&MasterTagID=8083&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
			        
			        //../General/CommonPage.aspx?MastertagID=20121&<PARAMETERS>,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400"
			        //http://localhost/WhizibleSEM10.0/Source/General/CommonPage.aspx?ReleaseID_PK=18&PKToken=CtkJ4r9WgFYvvlNmMoZ0/w&MasterTagID=8083&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1
			    }
			    if (Flag == "ITERATION")
			    {
			        window.open("../PM/Iterations_CommonPage.aspx?IterationID_PK=" + ID +"&MasterTagID=8084&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
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

var objtxtpageNumber =  GetObjectReference('frmIterationSummary','txtPageNumber');
var objtxtNoOfPages = GetObjectReference('frmIterationSummary','txtNoOfPages');

if(GetObjectReference('frmIterationSummary','txtNoOfPages'))
{	
	var noOfPages = GetObjectReference('frmIterationSummary','txtNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmIterationSummary','txtPageNumber');
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
			
				var objtxtpageNumber =  GetObjectReference('frmIterationSummary','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmIterationSummary','txtNoOfPages');
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
		function Page_Onclick(PageNumber)
		{
			 
			 strLocation = "PM_IterationSummary.aspx?PageNumber=" + PageNumber+"&MasterTagID=8093&FromWhere=PM";
			
			objform.action = strLocation
			objform.submit();
		}
		function Export_OnClick()
        {    
			window.open("PM_IterationSummary.aspx?MasterTagID=8093&FromWhere=PM&MODE=Print");  
        	
        }	
		function Back_OnClick()	
		{
		window.location.href="PM_Scrum_ViewOtherReports.aspx?MasterTagID=9010&FromWhere=PM"	
		}				
			
		</script>
	</body>
</HTML>









