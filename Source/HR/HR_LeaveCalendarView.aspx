<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_LeaveCalendarView.aspx.vb" Inherits="PbNIT.HR_ResourceLeaveCalendarView" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Resource Leaves Calender")%>
    
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

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		 
					<form id="frmResourceLeaveCalenderView" method="post" runat="server">
						 
									<%DrawPage()%>
							 
					</form>
				 
					<script language="javascript">
			var objdivlist=GetObjectReference('frmResourceLeaveCalenderView','divContainer');
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}				
			 
			//CallOnLoad() 
		
		}
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) 
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight +'px';	
			}
			//CallOnLoad() 
		}	
		
		function OrganizationUnit_OnClick(intMonth,intYear)
		{
			var objOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','cboOrganizationUnit');			
			var objtxtOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','txtOrganizationUnit');			
			var txtOrganizationUnitID= objtxtOrganizationUnit.value;			
			var OrganizationUnitID=objOrganizationUnit.value;
			
			window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + intMonth + "&Year=" + intYear + "&txtOrganizationUnit="+txtOrganizationUnitID 
		}
		
		function NextMonth_clicked()
		{
			
			
			var objEmployee=GetObjectReference('frmResourceLeaveCalenderView','cboEmployee');
			
			var EmployeeID=objEmployee.value;
			
			var objOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','cboOrganizationUnit');
	 
			var objtxtOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','txtOrganizationUnit');
		 
			var txtOrganizationUnitID= objtxtOrganizationUnit.value;
		 
			var OrganizationUnitID=objOrganizationUnit.value;
		
		
			var objtxtMonth=GetObjectReference('frmResourceLeaveCalenderView','txtMonth');
			var objtxtYear=GetObjectReference('frmResourceLeaveCalenderView','txtYear');
			var tempYear =<%=m_CurrYear%>;
			var tempMonth =objtxtMonth.value;
		
			
			if( tempMonth<=0 ||tempMonth>12 )
			{
				alert("Please enter value between '1-12' for month !")
				objtxtMonth.focus();
				return;
			}
			//Modified by MrugajaB on 19th July 2006 for WhizibleSEM SP7
			//Purpose:when value 12/9999 is entered and next month clicked then page crashes
			if( tempMonth==12)
			{
				if (objtxtYear.value==9999)
				{
					alert("Operation not Allowed !");
					objtxtMonth.focus();
					return;
				}
			}	
			//End Modification
			
			window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID 

		}
	
	
	function PreviousMonth_clicked()
	{
		try
	 {
		var objEmployee=GetObjectReference('frmResourceLeaveCalenderView','cboEmployee');
		
		var EmployeeID=objEmployee.value;
		var objOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','cboOrganizationUnit');
	 
			var objtxtOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','txtOrganizationUnit');
		 
			var txtOrganizationUnitID= objtxtOrganizationUnit.value;
		 
			var OrganizationUnitID=objOrganizationUnit.value;
		var objtxtMonth=GetObjectReference('frmResourceLeaveCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmResourceLeaveCalenderView','txtYear');
		var tempYear =<%=m_CurrYear%>;
		var tempMonth =objtxtMonth.value;
	
	
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
			
					
		if(<%=m_intMonth%>!=1)
		{
			window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID +  "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID
		}
		else{
			window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID +   "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID
		}
	 }
	 catch(ex){}
	}
	
	
function Show_clicked()
{

	var objOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','cboOrganizationUnit');
	 
	var objtxtOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','txtOrganizationUnit');
	 
	 
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	 
	var OrganizationUnitID=objOrganizationUnit.value;
	 
	var objtxtMonth=GetObjectReference('frmResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmResourceCalenderView','txtYear');
	
	var ObjcboEmployee = GetObjectReference('frmResourceCalenderView','cboEmployee');
	
	
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;
	var preYear =tempYear-1; 
	 
	if (isBlank(Trim(tempMonth))==true)
	{
		alert("'Month' can not be blank !")
		objtxtMonth.focus();
		return;
	}
		
	if (isBlank(Trim(objtxtYear.value))==true)
	{
		alert("'Year' can not be blank !")
		objtxtYear.focus();
		return;
	}
		

	if(Trim(objtxtYear.value)<= 0)
	{
		alert("Please Enter Valid Year ")
		objtxtYear.focus();
		return;
	} 
	if(Trim(tempMonth)<=0 ||Trim(tempMonth)>12 )
	{
		alert("Please enter value between '1-12' for month !")
		objtxtMonth.focus();
		return;
	}
	
	var Year=Trim(objtxtYear.value);
	var Month=Trim(objtxtMonth.value);
	
	if(isInteger(Month)==false)
	{
		alert("Please enter only numeric value for 'Month'!");
		objtxtMonth.focus();
		return;
	}
	if(isInteger(Year)==false )
	{
		alert("Please enter only numeric value for 'Year'!");
		objtxtYear.focus();
		return;
	}
	 window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + Month + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&employeeid=" + ObjcboEmployee.value   
    

}

	function Employee_OnClick(intMonth,intYear)
	{
		var objOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','cboOrganizationUnit');
	 
	var objtxtOrganizationUnit=GetObjectReference('frmResourceLeaveCalenderView','txtOrganizationUnit');
	 
	 
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	 
	var OrganizationUnitID=objOrganizationUnit.value;
		var objEmployee=GetObjectReference('frmResourceLeaveCalenderView','cboEmployee');
		
		var objtxtMonth=GetObjectReference('frmResourceLeaveCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmResourceLeaveCalenderView','txtYear');
		
		var Year=objtxtYear.value;
		var MonthID=objtxtMonth.value;
		var EmployeeID=objEmployee.value;
		
		
		window.location.href = "HR_ResourceLeaveCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + MonthID + "&Year=" + Year+ "&employeeid=" + objEmployee.value   
		

	}
	
	function Leave_onClick(intEmployeeID,intLeaveID)
	{		
		window.open("../HR/HR_LeaveCalendarViewApproval.aspx?EmployeeID=" + intEmployeeID + "&LeaveID=" + intLeaveID , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
					
					
					</script>
				
	</body>
</HTML>
