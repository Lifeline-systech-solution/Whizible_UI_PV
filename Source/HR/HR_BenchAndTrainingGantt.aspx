<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_BenchAndTrainingGantt.aspx.vb" Inherits="PbNIT.HR_BenchAndTrainingGantt"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Bench And Training Gantt")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmBenchAndTraining" method="post" runat="server">
			<% BuildPage()%>
		</form>
		<script language="javascript">
		var objform = GetFormReference('frmBenchAndTraining');
		var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
		var noOfPages = GetObjectReference('frmBenchAndTraining','hidNoOfPages').value;
		var objdivlist = GetObjectReference('frmBenchAndTraining','DivList');	
			
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
		function Add_OnClick()
		{
		  window.open("../HR/HR_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=3867&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=800,height=300");
		}
		
		//function EmpEdit_OnClick(Emp)
		//{
		//  window.open("../HR/HR_CommonList.aspx?MasterTagID=3867&EmployeeID="+Emp+"&FromWhere=RM&PagingAlphabet=-1&ParentTagID=0&PagingNumber=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=800,height=300");
		//}
		
		function Previous_OnClick()
		{
			var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
		  	var objYearIncr = document.getElementById('YearIncr');
			objYearIncr.value = parseInt(objYearIncr.value)-1; 
			objform.action="../HR/HR_BenchAndTrainingGantt.aspx?PageNumber=" + objtxtpageNumber.value;
			objform.submit();
		}
		
		function Next_OnClick()
		{
		    var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
			var objYearIncr = document.getElementById('YearIncr');
			objYearIncr.value = parseInt(objYearIncr.value)+1;
			objform.action="../HR/HR_BenchAndTrainingGantt.aspx?PageNumber=" + objtxtpageNumber.value;
			objform.submit();
		}
		
		function ShowContextMenu(ev,obj,intEmployeeID)
		{
			if(obj)
			{
				objTDRolledNow=obj;obj.className='clsTDRolledOver';
			}
			var objContextMenu = GetObjectReference('frmBenchAndTraining','divContextMenu');
			 
			var mousePosition = getMousePosition(ev,objContextMenu);
			 
			objContextMenu.style.visibility= 'visible';
			objContextMenu.style.position = 'absolute';
			
			objContextMenu.style.left = mousePosition.x;objContextMenu.style.top = mousePosition.y;
			
			var objTrMenuHR = GetObjectReference('frmBenchAndTraining','trMenuHR');
			if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
			var objProjectAllocation  = GetObjectReference('frmBenchAndTraining','tdProjectAllocation');
			var objResUtilization = GetObjectReference('frmBenchAndTraining','tdResourceUtilization');
			var objSkillView  = GetObjectReference('frmBenchAndTraining','tdSkillView');
			var objViewDetails = GetObjectReference('frmBenchAndTraining','tdViewDetails');
						
			objProjectAllocation.onclick=function()
			{
				window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3902&EmployeeID=" + intEmployeeID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			}
			
			objSkillView.onclick=function()
			{
				window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3910&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			}
			
			objResUtilization.onclick=function()
			{
				window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
				
			}
			
			objViewDetails.onclick=function()
			{
			    window.open("../HR/HR_CommonList.aspx?MasterTagID=3867&EmployeeID="+intEmployeeID+"&FromWhere=RM&PagingAlphabet=-1&ParentTagID=0&PagingNumber=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=800,height=300");
			}
			
			
		}
		
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmBenchAndTraining','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
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
		
		var ShowFilter='0';
		function showFilters(show)
		{
			var objtblFilter = GetObjectReference('frmBenchAndTraining','tblFilter');
			var objimgFilter =GetObjectReference('frmBenchAndTraining','imgFilter');
			var img1='../../Images/cssImages/Link images/close.gif';
			var img2='../../Images/cssImages/Link Images/Filter.gif';    

			if (ShowFilter=='0')
			{
			objtblFilter.style.top=40;
			objtblFilter.style.left=0;
			objtblFilter.zIndex=99;
			objtblFilter.style.display='';
			objimgFilter.src=img1;
			objimgFilter.alt='Hide filter'
			ShowFilter='1';

			}
			else if(ShowFilter=='1')
			{
			objtblFilter.style.display='none';
			objimgFilter.src=img2;
			ShowFilter='0';    
			objimgFilter.alt='Show filter' ;
			}
		}
		
		function applyFilter()
		{
			var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
			var objEmployee=GetObjectReference('frmBenchAndTraining','txtResource').value;	
			
			var objBG=GetObjectReference('frmBenchAndTraining','cboBG').value;	
			var objOU=GetObjectReference('frmBenchAndTraining','cboOU').value;	
			var objDU=GetObjectReference('frmBenchAndTraining','cboDU').value;	
			var objDT=GetObjectReference('frmBenchAndTraining','cboDT').value;	
			var objEmpTypeID=GetObjectReference('frmBenchAndTraining','cboEmpType').value;	
			var objDepartmentID = GetObjectReference('frmBenchAndTraining','cboDepartment').value;	
			var objRole=GetObjectReference('frmBenchAndTraining','cboRole').value;	
			var objDesignation=GetObjectReference('frmBenchAndTraining','cboDesignation').value;	
			var objSkill=GetObjectReference('frmBenchAndTraining','cboSkill').value;		
			
			//"HR_BenchAndTrainingGantt.aspx?PageNumber=" +page; 
			objform.action = "HR_BenchAndTrainingGantt.aspx?PageNumber=" + objtxtpageNumber.value;  
			objform.submit();
		}
		
		function ClearFilter()
		{
			var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
			var objEmployee=GetObjectReference('frmBenchAndTraining','txtResource').value = '';	
			var objBG=GetObjectReference('frmBenchAndTraining','cboBG').value = '';	
			var objOU=GetObjectReference('frmBenchAndTraining','cboOU').value = '';	
			var objDU=GetObjectReference('frmBenchAndTraining','cboDU').value = '';	
			var objDT=GetObjectReference('frmBenchAndTraining','cboDT').value = '';	
			var objEmpTypeID=GetObjectReference('frmBenchAndTraining','cboEmpType').value = '';	
			var objDepartmentID = GetObjectReference('frmBenchAndTraining','cboDepartment').value = '';	
			var objRole=GetObjectReference('frmBenchAndTraining','cboRole').value = '';	
			var objDesignation=GetObjectReference('frmBenchAndTraining','cboDesignation').value = '';	
			var objSkill=GetObjectReference('frmBenchAndTraining','cboSkill').value = '';		
			var objDeployable=GetObjectReference('frmBenchAndTraining','cboDeployable').value = '';
			var objResourcePool=GetObjectReference('frmBenchAndTraining','cboResourcePool').value = '';	
						
			objform.action = "HR_BenchAndTrainingGantt.aspx?PageNumber=" + objtxtpageNumber.value;  
			objform.submit();
			
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
				var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmBenchAndTraining','txtNoOfPages');
								
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
				
				objform.action = "HR_BenchAndTrainingGantt.aspx?PageNumber=" +page;  
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
			var noOfPages = GetObjectReference('frmBenchAndTraining','hidNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
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
			var noOfPages = GetObjectReference('frmBenchAndTraining','hidNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmBenchAndTraining','txtPageNumber');
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
		
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}	
		 
	
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) 
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30 ;
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight +'px';	
			}
			 
		}	
				
		</script>
	</body>
</HTML>
