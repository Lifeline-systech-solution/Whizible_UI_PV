<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_EarnedValueReport.aspx.vb" Inherits="PbNIT.PM_EarnedValueReport"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
        <%CommonFunctions.General.PlotPageHeadTag("Earned Value Report")%>
        
        
		<title>Earned Value Report</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
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


	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody">
		<form id="frmPM_EarnedValueReport" method="post" runat="server">
			<% BuildPage()%>
		</form>
		<Script language="javascript">
		
			var objfrmEV = GetFormReference('frmPM_EarnedValueReport');
			var objtxtFromDate = GetObjectReference('objfrmEV','txtFromDate');
			var objtxtToDate = GetObjectReference('objfrmEV','txtToDate');
			var objcboProject = GetObjectReference('objfrmEV','cboProject');
			
			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			 function cboProject_change()
			 {
			     //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			     setFrameLoader();
			     //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Mode=Change"
				objfrmEV.submit();
			 }
			 
			  function cboPhase_change()
			 {
			      //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			      setFrameLoader();
			      //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=1&Mode=Change"
				objfrmEV.submit();
			 }
			 
			  function cboModule_change()
			  {
			      //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			      setFrameLoader();
			      //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=3&Mode=Change"
				objfrmEV.submit();
			 }
			 
			  function cboMilestone_change()
			  {
			      //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			      setFrameLoader();
			      //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=4&Mode=Change"
				objfrmEV.submit();
			 }
			 
			  function cboSubProject_change()
			  {
			      //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			      setFrameLoader();
			      //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=2&Mode=Change"
				objfrmEV.submit();
			 }
			 
			 function GenerateReport()
			 {
				objtxtFromDate.disabled=false;
				
				/*	Added By NitinVS on 16 March 2005 for PBNITE SP2
					dates Should not be blank 
				*/								
				
				if (objtxtFromDate.value== "")
				{
					alert("Please select the start date!! ");
					return;	
				}
				else if (objtxtToDate.value == "")
				{	
					alert("Please select the end date!! ")
					return;
				}
				/* End addition By NitinVS on 16 March 2005 for PBNITE SP2 */ 
			
				//objfrmEV.action="PM_EarnedValueReport.aspx?Mode=Generate&FromDate='" + objtxtFromDate.value + "'&ToDate='" + objtxtToDate.value + "'&ProjectID=" + objcboProject.value 
		//		window.open("PM_EarnedValueReport.aspx?MasterTagID=2047&Mode=Generate&FromDate=" + objtxtFromDate.value + "&ToDate=" + objtxtToDate.value + "&ProjectID=" + objcboProject.value + "&strID=" + <%=m_strID%> + "&strType=" + <%=m_strType%>  ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=850,height=650");  
				//window.open("PM_EarnedValueReport.aspx?Mode=Generate&FromDate='" + objtxtFromDate.value + "'&ToDate='" + objtxtToDate.value + "'&ProjectID=" + objcboProject.value ) //,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=850,height=650");  
			     //objfrmEV.submit();

			     //Commented and added by Yogesh J on 04-Feb-2016 to generate Token
			     //		window.open("PM_EarnedValueReport.aspx?MasterTagID=2047&Mode=Generate&FromDate=" + objtxtFromDate.value + "&ToDate=" + objtxtToDate.value + "&ProjectID=" + objcboProject.value + "&strID=" + <%=m_strID%> + "&strType=" + <%=m_strType%>  ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=850,height=650");  

			     $.ajax({
			         type: 'POST',
			         dataType: 'json',
			         contentType: 'application/json',
			         url: 'PM_EarnedValueReport.aspx/GenrateURLToken_GenerateToken_OnClick',
			         data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", FromDate: objtxtFromDate.value, ToDate: objtxtToDate.value, ProjectID: objcboProject.value, strID: "<%=m_strID%>" }),
		        success: function (Result) {   
		            window.open("PM_EarnedValueReport.aspx?MasterTagID=2047&Mode=Generate&FromDate=" + objtxtFromDate.value + "&ToDate=" + objtxtToDate.value + "&ProjectID=" + objcboProject.value + "&strID=" + <%=m_strID%> + "&strType=" + <%=m_strType%> + "&PKToken="+Result.d ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=850,height=650");  

		        },
		        error: function () {
		               //  alert("Error")
		        }
		    });
			     //End of addition by Yogesh J on 02-Feb-2016 to generate Token
			 }
			 
			 function optPhase_click()
			 {
			     //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			     setFrameLoader();
			     //End of Addition by Dhanashri S on 12 Oct 2016
			 	objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=1&ProjectID=" + objcboProject.value
				objfrmEV.submit();
			 }
			 
			 function optSubProject_click()
			 {
			     //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			     setFrameLoader();
			     //End of Addition by Dhanashri S on 12 Oct 2016
			 	objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=2&ProjectID=" + objcboProject.value
				objfrmEV.submit();
			 }
			 
			 function optModule_click()
			 {
			     //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			     setFrameLoader();
			     //End of Addition by Dhanashri S on 12 Oct 2016
			 	objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=3&ProjectID=" + objcboProject.value
				objfrmEV.submit();
			 }
			 
			 function optMilestone_click()
			 {
			     //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			     setFrameLoader();
			     //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=4&ProjectID=" + objcboProject.value
				objfrmEV.submit();
			 }
			 
			 
			 function Close_OnClink()
			 {
				window.close();
			 }
			 /*	Added By NitinVS on 15 March 2005 for PBNITE SP2
				To add filter for Deliverable
			  */
			function optDeliverable_click()
			 {
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=5&ProjectID=" + objcboProject.value
				objfrmEV.submit();
			}
			function cboDeliverable_change()
			{
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objfrmEV.action="PM_EarnedValueReport.aspx?MasterTagID=2047&Type=5&Mode=Change"
				objfrmEV.submit();
			}

			function WeeklySummary_OnClink()
			{
				window.open ( "PM_EarnedValueSummaryReport.aspx?MasterTagID=2047&ReportID=1897&FromDate=<%=m_strFromdate%>&ToDate=<%=m_strTodate%>&ProjectID=" + <%=m_strProjectID%> + "&strID=" + <%=m_strID%> + "&strType=" + "<%=m_strType%>" ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=600,height=400");  
				
			}
			
			function WeeklyDetails_OnClink()
			{
				window.open ( "PM_EarnedValueSummaryReport.aspx?MasterTagID=2047&ReportID=1901&FromDate=<%=m_strFromdate%>&ToDate=<%=m_strTodate%>&ProjectID=" + <%=m_strProjectID%> + "&strID=" + <%=m_strID%> + "&strType=" + "<%=m_strType%>" ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=600,height=400");    
				
			}
		    /* End Addition By NitinVS on 15 March 2005 for PBNITE SP2*/	
		    ///Added by Shamkant S on 12 Dec 2015
		    document.body.onload = function () {
		        //alert("");
		        objdivmain = document.getElementById('DivMain');
		        var intDivHeight;
		        //     var intDivHeightRisk;
		        // alert(objdivlist.id);
		        intDivHeight = (window.innerHeight - objdivmain.offsetTop - 38);
		        //     if (intDivHeight < 100) intDivHeight = 100;
		        objdivmain.style.height = intDivHeight + 'px';
		        //alert(objdivlist.style.height);
		    }
		    document.body.onresize= function (){
                //Commented by Chetan M on 10th April 2020 for issue fixing
                // alert("");
                //End of Commented by Chetan M on 10th April 2020 for issue fixing
		        objdivmain = document.getElementById('DivMain');
		        var intDivHeight;
		        //     var intDivHeightRisk;
		        // alert(objdivlist.id);
		        intDivHeight = (window.innerHeight - objdivmain.offsetTop - 38);
		        //     if (intDivHeight < 100) intDivHeight = 100;
		        objdivmain.style.height = intDivHeight + 'px';
		    }
		    //Ended by Shamkant S on 12 Dec 2015
		</Script>
	</body>
</HTML>
