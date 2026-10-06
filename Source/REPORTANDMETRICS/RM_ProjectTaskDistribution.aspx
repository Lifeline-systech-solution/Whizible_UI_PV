<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ProjectTaskDistribution.aspx.vb" Inherits="PbNIT.RM_ProjectTaskDistribution" %>

<html>
	<% CommonFunctions.General.PlotPageHeadTag("Project Task Distribution")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmReportUIBuilder" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmReportUIBuilder'); 
		var objdivlist=GetObjectReference('frmReportUIBuilder','PageDiv');
		
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
			var filename;
			var showmsg;
			
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 80 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 80;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}			
			
			showmsg = <%=m_intShowMessage%>;
			if (showmsg == 1 )
			{
				alert("There are no items to show in this view");
				window.close();
			}
			/*
			else
			{
								
				<%'Added by MahendraV On 10:37 AM 5/24/2007 for List of Reports modified for HTML Report Issue'%>
				<%'Start_MV_5/24/2007'%>
				filename="<%=m_strFileName%>";

				var strWindowName = filename;

				var strDot = '.';

				if (strWindowName)
				{
					while(strWindowName.indexOf(strDot) > -1)
					{
						strWindowName =strWindowName.replace(strDot,'');
					}
				}
				strWindowName = strWindowName + "_report";
				openSecure = "<%=m_intOpenReportInSecurePage%>";
				if (trimString(filename).length > 0 )
				{
					if (openSecure==1)
					{
						window.open("../CRW/CRW_ReportOutput.aspx?filename=" + filename,strWindowName,"");
					}
					else
					{
						window.open("../../Reports/" + filename,strWindowName,"");
					}
				}				
				<%'End_MV_5/24/2007'%>
			}
			*/
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
			objdivlist.style.height = intDivHeight;	}
		}	
		
		function Configure_OnClick(reportid)
		{
			window.open("../CRW/CRW_ReportDesigner.aspx?reportid=" + reportid,"_designer","left=50,top=50,height=600,width=600,resizable=yes,scrollbar=yes");
		}
		
		function ViewReport_OnClick(format)
		{
		    objProject=GetObjectReference('','cboProject');
		    objTimeFlag=GetObjectReference('','cboTimeFlag');
		    objReportType=GetObjectReference('','cboReportType');
		  
		    if(objProject==null || objTimeFlag==null || objReportType==null)
		    return;
		    
		    if (disallowBlank(objProject, 'Project cannot be blank!',true)) return;
		    
		    if (disallowBlank(objTimeFlag, 'Select Period cannot be blank!',true)) return;
		    
		    if (disallowBlank(objReportType, 'Report Type cannot be blank!',true)) return;
		    
			objform.action  = "RM_ProjectTaskDistribution.aspx?MasterTagID=550&Action=ViewReport&format=" + format;
			objform.target="_blank";
			objform.submit();
		}
	//"../CRW/CRW_ReportUIBuilder.aspx?WhZpArm=%23%3bH3%40ALMLLlk31q4l1ncL%23%40RFHF%23N3fNF%24rAmEwOrk%3b.NtWhIzM%3e%3c%23WH%24O%40%23FN%23LNl33N%23LNFl%23J%23Y%24%23IOHnf%3b%3bSAoRdEr3qrthl3OF%25%25ERISED%23%24&UNIQUEID=&Mode=VIEW&ReportID=291&Format="+ format + "&Captions=Project,Select Period,&Controls=iProjectID,iTimeFlag,&MasterTableID=337,338,&DataTypes=int,int,&ActualPosition=1,2,"
		/*function ByWhat_OnClick()
		{
			var objByWhat, objProject, objEmployee;
			objByWhat = GetObjectReference('frmReportUIBuilder','optByWhat',true);
			objProject = GetObjectReference('frmReportUIBuilder','cboProject');
			objEmployee = GetObjectReference('frmReportUIBuilder','cboEmployee');
			
			if(objByWhat[0].checked == true)
			{ 
				objProject.disabled=false;
				objEmployee.disabled=true;
				objEmployee.value="";
			}
			else
			{
				objProject.disabled=true;
				objEmployee.disabled=false;
				objProject.value="";
			}
		}
		
		function WeekDays_OnClick()
		{
			var objFromDate, objToDate, objWeekDays;
			var strFromDate, strToDate;
			
			objFromDate = GetObjectReference('frmReportUIBuilder','txtFromDate');
			objToDate = GetObjectReference('frmReportUIBuilder','txtToDate');
			objWeekDays = GetObjectReference('frmReportUIBuilder','optWeekDays',true);
			if(isBlank(objFromDate.value)==true)
			{
				strFromDate = getDate("=m_strTempFromDate%>");
				objToDate.value = getDateInFormat_ddMMMyyyy(strFromDate);
			}
			else
			{
				strFromDate = getDate(objFromDate.value);
				strToDate = getDate(objToDate.value);
			}
			if((strToDate == null) || (DateDiff(strFromDate, strToDate, "d") < 7))
			{
				if(objWeekDays[0].checked == true)
					strToDate = DayAdd(strFromDate, 4);
				else if(objWeekDays[1].checked == true)
					strToDate = DayAdd(strFromDate, 5);
				else if(objWeekDays[2].checked == true)
					strToDate = DayAdd(strFromDate, 6);
			}
			objToDate.value = getDateInFormat_ddMMMyyyy(strToDate);
		}
		
		/*
		This function returns the Date in the Format dd-MMM-yyyy.
		The input parameter is date object.
		
		function getDateInFormat_ddMMMyyyy(dtDate)
		{
			var strDay, strMonth, strYear, strReturnDate = "";
			var strMonths = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
			
			if(dtDate == null)
				return;
			strReturnDate = dtDate.getDate() + "-";
			strReturnDate = strReturnDate + strMonths[dtDate.getMonth()] + "-";
			strReturnDate = strReturnDate + dtDate.getFullYear();
			return(strReturnDate);
		}*/
		</Script>
	</body>
</html>

