<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_RCV_ProjectAllocation.aspx.vb" Inherits="PbNIT.HR_RCV_ProjectAllocation"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<!--<title>Resource Calender View</title>-->
	<%CommonFunctions.General.PlotPageHeadTag("Resource Calendar View")%>
	
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    u
    {
        cursor:pointer;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Web Form Extension Type
        //// Description:Remove section header row in Tablet and Mobile view
        //// By Whom: Miiint
        //// When:23/01/2015
        ///*---------------------------------------------------------*/
        //if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
        //    removeSectionHeader();
        //}
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        ///*---------------------------------------------------------*/
        //if ($('.clsgridtable').length > 0) {
        //    var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Top Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveTopMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Footer Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveFooterMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Sub Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableTopMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Sub Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableFooterMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Remove footer
        //// Description:Display none footer in Tablet and Mobile view
        //// By Whom: Miiint
        //// When:16/01/2015
        ///*---------------------------------------------------------*/
        ///* Display none footer in Tablet and Mobile view*/

        //var windowWidth = $(window).width();
        //if (windowWidth < 992) {

        //}
        //else {

        //}
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-Remove footer
        ///*---------------------------------------------------------*/

        //$('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Responsive Navigation Tabs
        //// Description:Display navigation tabs in dropdown
        //// By Whom: Miiint
        //// When:07/02/2015
        ///*---------------------------------------------------------*/
        //$('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        //$('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        //var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        //var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        //if (windowWidth < 992) {
        //    responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        //}
        //else {
        //    $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        //}

        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-Responsive Navigation Tabs
        ///*---------------------------------------------------------*/

        //$('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        //$('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        //// Description:removing plus sign with footable functionality for 'Total' column
        //// By Whom: Miiint
        //// When:27/04/2015
        ///*---------------------------------------------------------*/

        //if (windowWidth < 1040) {
        //    var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
        //    if (text == "Total") {
        //        $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
        //        $('#tblGrid1053121').find('tr:last').css('display', 'none');
        //    }
        //}

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        //responsiveTopMenuResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        //// Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        //// By Whom: Miiint
        //// When:10/02/2015
        ///*---------------------------------------------------------*/
        //responsiveFooterMenuResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableTopMenuResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-FooterMenuDropDown
        //// Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        //// By Whom: Miiint
        //// When:28/05/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableFooterMenuResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-FooterMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Remove footer
        //// Description:Display none footer in Tablet and Mobile view
        //// By Whom: Miiint
        //// When:16/01/2015
        ///*---------------------------------------------------------*/
        ///* Display none footer in Tablet and Mobile view*/

        //var windowWidth = $(window).width();
        //if (windowWidth < 992) {

        //}
        //else {

        //}
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-Remove footer
        ///*---------------------------------------------------------*/
        //$('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-Responsive Navigation Tabs
        //// Description:Display navigation tabs in dropdown
        //// By Whom: Miiint
        //// When:07/02/2015
        ///*---------------------------------------------------------*/
        //responsiveNavigationTabsResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-Responsive Navigation Tabs
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-collapse & close for tablet view
        //// Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        //// By Whom: Miiint
        //// When:17/02/2015
        ///*---------------------------------------------------------*/
        //collapseDivsResize();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-collapse & close for tablet view
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        //// Description:removing plus sign with footable functionality for 'Total' column
        //// By Whom: Miiint
        //// When:27/04/2015
        ///*---------------------------------------------------------*/

        //if (windowWidth < 1040) {
        //    var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
        //    if (text == "Total") {
        //        $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
        //        $('#tblGrid1053121').find('tr:last').css('display', 'none');
        //    }
        //}

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmRCVProjectAllocation" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		var objdivlist = GetObjectReference('frmRCVProjectAllocation', 'DivMain');
		var ProjectCount = "<%=m_ProjectCount%>"
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		if(GetObjectReference('frmHRResourceCalenderView','hidNoOfPages'))
		{
            var noOfPages = GetObjectReference('frmHRResourceCalenderView','hidNoOfPages').value;
        }
	    var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
        var objform = GetFormReference('frmRCVProjectAllocation');
		
		function window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			}
			else
			{
                //Commented by Yogesh J on 15/12/2015 for pop up bottom line issue
			    //intDivHeight = window.innerHeight - 60;
                //End of comment by Yogesh J
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 60;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight + 'px';

			//CallOnLoad()		
		}

		function window_onload()
		{
		
				var intDivHeight ;
				var intDivHeightRisk;
				var lc;
				if (navigator.appName == 'Microsoft Internet Explorer'){
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				}
				else{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 60;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight;
				objdivlist.HEIGHT = intDivHeight +'px';
				//CallOnLoad()
				
		}

		function Close_Click()
		{
			window.close();
		}
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmHRResourceCalenderView','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
			objdivLegendsContextMenu = GetObjectReference('frmHRResourceCalenderView','divLegendsContextMenu');
			if(objdivLegendsContextMenu){objdivLegendsContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
		}
		
		
function ShowContextMenu(ev,obj,intEmployeeID,strStartDate,strEndDate)
{
 var LoginUser = "<%=session("intUserID")%>" ;	
			
	if(obj)
	{
		objTDRolledNow=obj;obj.className='clsTDRolledOver';
	}
	var objContextMenu = GetObjectReference('frmHRResourceCalenderView','divContextMenu');
	 
	var mousePosition = getMousePosition(ev,objContextMenu);
	 
	objContextMenu.style.visibility= 'visible';
	objContextMenu.style.position = 'absolute';
    //Commented And Added By Vaijat K ON 09/12/2015 Issue ID-2677
	//objContextMenu.style.left = mousePosition.x ; objContextMenu.style.top = mousePosition.y ;
	objContextMenu.style.left = event.pageX + 'px';
	objContextMenu.style.top = event.pageY + 'px';
	
	var strHref='../SM/PB_ModifyAccess.aspx';


var objTrMenuHR = GetObjectReference('frmHRResourceCalenderView','trMenuHR');
	if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
	var objShowTasks = GetObjectReference('frmResourceCalenderView','tdShowTasks');
	var objProjectAllocation = GetObjectReference('frmResourceCalenderView','tdProjectAllocation');
	var objLeaveDetails = GetObjectReference('frmResourceCalenderView','tdLeavDetails');
	var objSkillView = GetObjectReference('frmResourceCalenderView','tdSkillView');
	var objResUtilization = GetObjectReference('frmResourceCalenderView','tdResourceUtilization');
	
	
	objShowTasks.onclick=function()
	{
        //Commented added by Shamkant s on 28 Jan 2016
	   //window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	    // window.open("../HR/HR_ResourceCalendarDetails.aspx?PKToken=<%=m_PKToken_FromRequestDetail%>&EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	    //Commented added by Shamkant s on 15 Feb 2016
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'HR_RCV_ProjectAllocation.aspx/GenrateTask__OnClick',
	        data: JSON.stringify({ EmployeeID: intEmployeeID, FromDate: strStartDate, ToDate: strEndDate }),
	        success: function (Result) {
	           // window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&PKToken=" + Result.d + "&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
                //Commented and Added by Dhanashri S on 11 Aug 2016
	            //window.open("../HR/HR_ResourceCalendarDetails.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	            window.open("../HR/HR_ResourceCalendarDetails.aspx?PkToken=" + Result.d + "&EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
                //End of Comment and Addition by Dhanashri S on 11 Aug 2016
	        },
	        error: function () {
	            //     alert("Error")
	        }
	    });
	    //Commented Ended by Shamkant s on 15 Feb 2016
	}
	
	objProjectAllocation.onclick=function()
	{
		window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3902&EmployeeID=" + intEmployeeID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	
	objLeaveDetails.onclick=function()
	{
	    window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3906&EmployeeID=" + intEmployeeID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=700,height=400");

	}
	
	//tdResourceAllocation
	objSkillView.onclick=function()
	{
		//window.open("../General/CommonList.aspx?MasterTagID=3910&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3910&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	//tdResourceUtilization
	objResUtilization.onclick=function()
	{
	    
	   // window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	   // window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&PKToken=<%=m_PKToken_FromRequestDetail%>&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	   
	    //Commented Added by Shamkant s on 11 Feb 2016
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'HR_RCV_ProjectAllocation.aspx/GenrateToken__OnClick',
	        data: JSON.stringify({ ResourceID: intEmployeeID,DateRangeID: "3" }),
	        success: function (Result) {
	            window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&PKToken=" + Result.d + "&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3&Flag=FromProjectAlloc", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
	            
	        },
	        error: function () {
	            //     alert("Error")
	        }
	    });
        //Commented Ended By Shamkant on 11 Feb 2016
	}
	
}
 
function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}

function CallOnLoad()
{	
			 
				var xl = tblHeader.offsetLeft;				
				var yt = tblHeader.offsetTop;				
				var tl = tblHeader;
				while (tl.tagName != "BODY") 
						{
							tl = tl.offsetParent;
							xl = xl + tl.offsetLeft;
							yt = yt + tl.offsetTop;
						}
				
								var headerTableRow = tblHDF.rows[0];						 			
								var originalTableRow = tblHeader.rows[0];									 
								headerTableRow.height =originalTableRow.offsetHeight;
							for (var i = 0; i < 15; i++) 
							{
								var O_Width = originalTableRow.cells[i].offsetWidth;
								var O_Height = originalTableRow.cells[i].offsetHeight;
								var In_HTML = originalTableRow.cells[i].innerHTML;							
												
								//headerTableRow.cells[0].width = O_Width; 
								//headerTableRow.cells[0].height = O_Height; 
								headerTableRow.cells[i].innerHTML = In_HTML; 
								//headerTableRow.cells[i].align = 'left';
								headerTableRow.cells[i].title = originalTableRow.cells[i].title;
							}			
															
								tblHDF.style.left =xl; 
								tblHDF.style.top = yt ; //176
								tblHDF.style.position = 'absolute';
								tblHDF.style.display="block";					 						
								

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
				var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmHRResourceCalenderView','txtNoOfPages');
								
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
					Page_OnClick(objtxtpageNumber.value);
				}
			}
		
		}
		function Page_OnClick(page)
		{
			objform.action = "HR_RCV_ProjectAllocation.aspx?PageNumber=" +page;  
			//enableAllControls();
			objform.submit();
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
	var noOfPages = GetObjectReference('frmRCVProjectAllocation','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmRCVProjectAllocation','txtPageNumber');
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
	var noOfPages = GetObjectReference('frmRCVProjectAllocation','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmRCVProjectAllocation','txtPageNumber');
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
	 
		
		
		
		</script>
		
		
					
	</body>
</HTML>
