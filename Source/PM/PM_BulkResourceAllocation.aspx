<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_BulkResourceAllocation.aspx.vb" Inherits="PbNIT.PM_BulkResourceAllocation"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag("PM_BulkResourceAllocation")%>
    
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_BulkResourceAllocation" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmPM_BulkResourceAllocation');
		//'Modified by : JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
		var objdivlist=GetObjectReference('frmPM_BulkResourceAllocation','DIVLIST');
		
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
		
			if (objdivlist!=null) { 
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
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
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
        }
		}	
		
		function Paging_OnClick(chr)
			{
				objform.action = "PM_BulkResourceAllocation.aspx?Alphabet=" + chr;
				objform.submit();
			}
			function Filter_OnChange()
			{
				objform.action = "PM_BulkResourceAllocation.aspx?";
				objform.submit();
			}
			function Show_OnClick()
			{
				objform.action = "PM_BulkResourceAllocation.aspx?";
				objform.submit();
			}
			function Clear_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmEmployeeSelection','txtFilter');
				objTxt.value='';
				
				objform.action = "PM_BulkResourceAllocation.aspx?";
				objform.submit();
			}
			
			function Assign_To_Project_OnClick()
			{
			var intRowCount="<%=intRowCount%>";
			var strSelectedEmployee="";
			var cnttaskselected = 0 
			var dtProjectStartDate=getDate('<%=ProjectStartDate%>');
			var dtProjectEndDate=getDate('<%=ProjectEndDate%>');
			var dtStartDate, dtEndDate;
			var strEmployeeNameList;
			//if(intRowCount!=0)
			 //{
			for (i=0;i<intRowCount;i++)
				{
					// if the Task is Selected then only Validate the data 
					var objchkSelect = GetObjectReference('frmPM_BulkResourceAllocation','chkSelect'+ i );
					
					if (objchkSelect.checked )
					{
						cnttaskselected  = 1 
						strSelectedEmployee = strSelectedEmployee + "," + objchkSelect.value;
						
						
					//	var objtxtEmployeeName = GetObjectReference('frmPM_BulkResourceAllocation','txtEmployeeName'+ i );
						
						var objtxtStartDate = GetObjectReference('frmPM_BulkResourceAllocation','txtStartDate'+ i );
						
						
					/*	if(objtxtStartDate.value="")
						{
						strEmployeeNameList+=objtxtEmployeeName;
						}
					*/
						
						//if (disallowBlank(objtxtStartDate,"'Start Date' can not be left blank for the Resource '"+objtxtEmployeeName.value+"'.",1) == true)
						if (disallowBlank(objtxtStartDate,"'Start Date' can not be left blank for the Resource.",1) == true)
						{
						//setFocus(objtxtEmployeeName);
						return;
						}
					
					
						
					/*	if (disallowBlank(objtxtStartDate,"'Start Date' can not be left blank.",1) == true)
						{
						setFocus(objtxtEmployeeName);
						return;
						}
					*/
						
						var objtxtEndDate = GetObjectReference('frmPM_BulkResourceAllocation','txtEndDate'+ i );
					//	if (disallowBlank(objtxtEndDate,"'End Date' can not be left blank for the Resource '"+objtxtEmployeeName.value+"'.",1) == true)
					if (disallowBlank(objtxtEndDate,"'End Date' can not be left blank for the Resource.",1) == true)
						{
						//setFocus(objtxtEmployeeName);
						return;
						}
						
						if (disallowDate1GreaterThanDate2(objtxtStartDate,objtxtEndDate)) 
						 {
//						alert("Please enter 'End Date' greater than 'Start Date' for the Resource '"+objtxtEmployeeName.value+"'.");
                            alert("Please enter 'End Date' greater than 'Start Date' for the Resource.");
						//setFocus(objtxtEmployeeName);
						return;
						 }
						 
						 dtStartDate = getDate(objtxtStartDate.value);
						 dtEndDate = getDate(objtxtEndDate.value);
						 
						 if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtStartDate != null) && (dtEndDate != null))
						 {
							if((dtStartDate < dtProjectStartDate) || (dtStartDate > dtProjectEndDate) || (dtEndDate > dtProjectEndDate))
							{
							//alert("Start Date and End Date should be between the Project Start date (<%=ProjectStartDate%>) and End date (<%=ProjectEndDate%>) for the Resource '"+objtxtEmployeeName.value+"'.");
							alert("Start Date and End Date should be between the Project Start date (<%=ProjectStartDate%>) and End date (<%=ProjectEndDate%>) for the Resource.");
							//setFocus(objtxtEmployeeName);
							return;
						    }
						    
						 }
						 
						 
						var objtxtWorkhrs = GetObjectReference('frmPM_BulkResourceAllocation','txtWorkhrs'+ i );
						if (disallowNegativeNumeric(objtxtWorkhrs,'Please enter only positive numeric value for \'Work (hrs)\'.',true))
						{ 
						return ;
						}
						
						var objcboEmployeeRole = GetObjectReference('frmPM_BulkResourceAllocation','cboEmployeeRole'+ i );
						if (disallowBlank(objcboEmployeeRole,"'Role' can not be left blank.",1) == true)
						{
						return;
						}
						
						var objcboReportingTo = GetObjectReference('frmPM_BulkResourceAllocation','cboReportingTo'+ i );
						if (disallowBlank(objcboReportingTo,"'Reporting To' can not be left blank.",1) == true)
						{
						return;
						}
							
					}
				}
			// }
			if (cnttaskselected == 0)
				{
					alert("Please Select at least one Resource.");
					return;
				}
			
			objform.action = "PM_BulkResourceAllocation.aspx?MODE=ASSIGN&SelectedEmployee="+strSelectedEmployee+"&RowCount="+intRowCount;
			objform.submit();
			}
			
			function SelectAll_OnClick()
			{
			    var count=<%=m_Count%>
			    for(var i=0;i<count;i++)
			    {
			     var objchk=GetObjectReference('frmPM_BulkResourceAllocation','chkSelect'+ i );
			     objchk.checked=true;
			    }
		    }
		    function ClearAll_OnClick()
		    {
		        var count=<%=m_Count%>
			    for(var i=0;i<count;i++)
			    {
			     var objchk=GetObjectReference('frmPM_BulkResourceAllocation','chkSelect'+ i );
			     objchk.checked=false;
			    }
		        
		    }
					</Script>
					</body>
</HTML>
