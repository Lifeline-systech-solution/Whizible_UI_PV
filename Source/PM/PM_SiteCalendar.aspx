<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_SiteCalendar.aspx.vb" Inherits="PbNIT.PM_SiteCalendar"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Site Calendar")%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }



    /*style added by pradip on 21-4-2021*/
  .SCtbl, .SCtbl tr.clsTRSectionHeader {
    font-size: 14px;
}
  table.SCtbl td {
    font-size: 14px;
    text-align: center;
    vertical-align: middle;
    border: 1px solid #eee; height:8vh;
}
  table.SCtbl TR.clsTRSectionHeader td{ height:36px; font-weight:bold;}
  table.SCtbl TR:nth-child(2) td, table.SCtbl TR:nth-child(2){ height:0;}
  table.SCtbl TR.clsTRSectionHeader{ background-color:#e7edf0;}
  TR.clsTRMenu{background:#e7edf0;}
  .clsTable .clsTRPageCaption td {
    font-size: 16px!important;
    background: #4263c1;
    color: #fff;
    height: 34px;
    vertical-align: middle;
    FONT-WEIGHT: 600;
}
  a.Menu:hover {
    background: none!important;
    color: #1359ac!important;
}
  .clsTable .clsTRMenu td a {
    font-size: 12px;
}
  table.SCtbl td a {
    font-size: 14px;
}
  /*End style added by pradip on 21-4-2021*/

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
		<TABLE height="55" cellSpacing="0" cellPadding="0" width="100%" border="0" ms_2d_layout="TRUE">
			<TR>
				<TD width="0" height="0"></TD>
				<TD width="10" height="0"></TD>
				<TD width="42" height="0"></TD>
			</TR>
			<TR vAlign="top">
				<TD width="0" height="15"></TD>
                <%--Added By Bharat T on 15th-Oct-2015--%>
				<TD colSpan="2" rowSpan="2" style="width:100%;">
                    <%--End of Added By Bharat T on 15th-Oct-2015--%>
					<form id="frmPM_SiteCalendar" method="post" runat="server">
						<TABLE height="35" cellSpacing="0" cellPadding="0" width="100%" border="0" ms_2d_layout="TRUE">
							<TR vAlign="top">
								<TD width="10" height="15"></TD>
								<TD width="1"></TD>
							</TR>
							<TR vAlign="top">
                                <%--Commented By Bharat T on 15th-Oct-2015--%>
								<%--<TD height="20"></TD>--%>
                                <%--End of Commented By Bharat T on 15th-Oct-2015--%>
								<TD>
									<%PageInit%>
								</TD>
							</TR>
						</TABLE>
					</form>
				</TD>
			</TR>
			<TR vAlign="top">
				<TD width="0" height="40"></TD>
				<TD>
					<Script language="javascript">
		var objform=GetFormReference('frmPM_SiteCalendar');
		var objdivlist=GetObjectReference('frmPM_SiteCalendar','PageDiv');
		
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
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			//if(navigator.appName == 'Netscape')
			//{		
            //    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			//    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			//    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 25 ;
            //    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			    //}
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
			    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
			
        }			
			if("<%=m_intRoleLevel%>"==1)
			{
				
				GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,0,0,"All Projects",0,0,0);
			}
			else
			{
				GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,0,1,"All Projects",0,0,0);
			}
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 55;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			//if(navigator.appName == 'Netscape')
			//{		
			//    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			//    //intDivHeight =window.innerHeight  - objdivlist.offsetTop - 55 ;
			//    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 25 ;
			//    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			    //}
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
			    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
        }
		}	
	//'function returns no of allocated hours for specified day in the year
	function  GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours)
	{
		
				
			
			strHtml =" "  + intDay +  "";  
		
	}	 	
    
  function GenerateCalendarTable(intMonth,intYear,intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours)
	{
      
			var strTable;
			var intDay;
			var days;
			var firstDay;
			var startDay;
			var column;
			var intLastMonthDay;
			var intCount;
			var strDate;
			var intYear1;
			var intNextMonth;
			var lastMonth;
			var intNextDay;
			var strFileName;
			//apply class for table added by pradip on 21-4-2021
		strTable =  "<table class='SCtbl' cellSpacing=1 cellPadding=0 height = 85% width=99.9% border=0 style=border:1 solid #dddddd>"; 
		strTable =strTable +  "<tbody>";
		strTable =strTable + " <tr class=clsTRSectionHeader>";
		
		
		strTable =strTable + " <td align=center colspan=7 >";
		
		strTable =strTable + " Site Calendar for month - " + " " + "" + " " + "<%=m_strMonthName%>";
		strTable =strTable + " &nbsp;  ";
		strTable =strTable + intYear;
		
		
		strTable =strTable + " </td>"; 
		
		strTable =strTable + " </tr>";
		strTable =strTable + " <tr height=22><td colspan=7></td></tr>";
		strTable =strTable + " <tr class=clsTRColumnHeader height = 100%>";
		
		
		strTable =strTable + " ";
		
		for(intDay = 0;intDay<7;intDay++)
		{
		    strTable =strTable + " <td align=right> ";
		    strTable =strTable +  arrWeekDays[intDay];
		    strTable =strTable + " </td>";
		    strTable =strTable + " ";
		}
		strTable =strTable + "</tr>";
		
		strTable =strTable + "<tr class=clsTREven> ";
		strTable =strTable + " ";
		
		
		days=new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		var firstDay = new Date(intYear, intMonth-1, 1);
		
		startDay = firstDay.getDay(); 
		column = 0;
		lastMonth = intMonth - 1;
		if(lastMonth == 0)
		{
		    lastMonth = 12;
		}
		intLastMonthDay = days[lastMonth] - (startDay -2)-1;
		
		
		//display previous month days
		
		for(intCount = 1;intCount<=(startDay);intCount++)
		{
			
		    strTable =strTable + " ";
		    if(intCount == 1)
				{
		        strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top style=font-family: Verdana; font-size: 12pt; background:#F0F0F0 border:1 solid #dddddd>";//modified by pradip on 21-4-2021
		        strTable =strTable + "<%=GetPrevisousMonthName()%>";
		        strTable =strTable + "&nbsp;&nbsp;&nbsp; ";
		        strTable =strTable + intLastMonthDay;
		        strTable =strTable + " </td>";
		        strTable =strTable + " ";
		        }
		     else
				{
		        strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top style=font-family: Verdana; font-size: 12pt; background:#F0F0F0 border:1 solid #dddddd>";//modified by pradip on 21-4-2021
		        strTable =strTable + intLastMonthDay;
		        strTable =strTable + " </td>";
		        strTable =strTable + " ";
				}
		    
		    strTable =strTable + " ";
		    column = column + 1;
		    strTable =strTable + " ";
		    intLastMonthDay = intLastMonthDay + 1;
		    strTable =strTable + " ";
		}
		
		var weekends;
		var holidays;
		var normaldays;
		weekends = "<%=m_strWeekEnds%>";
		holidays = "," + "<%=m_strHolidayList%>" + "," ;
		normaldays ="," + "<%=m_NormalDays%>" + ",";
      //alert(normaldays);
      //alert(holidays);
      //alert(weekends);
      //alert(startDay);
		//alert(weekends);
		//alert(holidays);
		
		//Display current month details 
		strTable =strTable + " ";
		intDay = 1;
	
		for(intCount = startDay;intCount<7;intCount++)
		{
		    strTable =strTable + " ";
            //dhn
		    //strDate = new Date(intYear, intMonth, intDay)
		    strDate = new Date(intYear, intMonth-1, intDay);
            //dhn
            //alert(strDate);
		    strTable =strTable + " ";
				
				//if (intCount==0 || intCount==6)
				if(weekends.lastIndexOf(column)!= -1)
				{
				
					 strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 12pt; background:red bgcolor=#1359ac>";//modified by pradip on 21-4-2021
					 strTable =strTable +  "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ")' style='color:#ffffff;'> " + intDay + "</A>";
					 strTable =strTable + "</td>";
					 strTable =strTable + " ";
				}	 
			// added by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry on 28 Jun 2006
			//-------------------------------------------------------
				//Added by SavitaS for Bristlecone IssueID 2355 on 13 June 2006
				else if(holidays.lastIndexOf("," + intDay + "," ) != -1)
					{
						strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt;background:red bgcolor=#dbeaf5 >";//modified by pradip on 21-4-2021
						strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth  + "," + intDay + "," + intYear + ")'> <font color='#1359ac'>" + intDay + "</font></A>";
						strTable =strTable + "</td>";
						strTable =strTable + " ";
					}
				//End by SavitaS
				//------------------------------------------------------- 
			// end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for DA Easy Entry 28 Jun 2006
				else
				{
					 var strColor="";
					 if(normaldays.lastIndexOf("," + intDay + ",") != -1)
						strColor="bgcolor=#cad6e0";
					 
					 strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top style=font-family: Verdana; font-size: 14pt; " + strColor +" >";//modified by pradip on 21-4-2021
					 strTable =strTable +  "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ")'> " + intDay + "</A>";
					 strTable =strTable + "</td>";
					 strTable =strTable + " ";
				}
				
		    strTable =strTable + " ";
		    column = column + 1;
		    strTable =strTable + " ";
		    intDay = intDay + 1;
		    strTable =strTable + " ";
		 }
		 
		strTable =strTable + " <tr class=clsTREven>";
		strTable =strTable + " ";
		column = 0;
		strTable =strTable + " ";
		intYear1 = intYear;
		strTable =strTable + " ";
		
		
		if ((((intYear1 % 4) == 0) && ((intYear1 % 100) != 0)) || ((intYear1 % 400) == 0))
		{
		    days[2] = 29;
		}
		 else
		 {
		    days[2]= 28;
		}
		strTable =strTable + " ";
		
		
		for(intCount = intDay;intCount<=days[intMonth];intCount++)
		{
		    strTable =strTable + " ";
            //dhn
		    //strDate = new Date(intYear, intMonth, intDay);
		    strDate = new Date(intYear, intMonth-1, intDay);
            //dhn
		    strTable =strTable + " ";
					
				//if(column==0 || column==6 || intDay==15)
				
				if(weekends.lastIndexOf(column)!= -1 || holidays.lastIndexOf(intDay) != -1 || normaldays.lastIndexOf(intDay) != -1)
				{
					if (weekends.lastIndexOf(column)!= -1)
					{
						strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 12pt;background:red bgcolor=#1359ac >";//modified by pradip on 21-4-2021
						strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth  + "," + intDay + "," + intYear + ")' style='color:#ffffff;'> " + intDay + "</A>";
						strTable =strTable + "</td>";
						strTable =strTable + " ";
					}
					else if(holidays.lastIndexOf("," + intDay + "," ) != -1)
					{
						strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 12pt;background:red bgcolor=#dbeaf5 >";
						strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth  + "," + intDay + "," + intYear + ")'> <font color='#1359ac'>" + intDay + "</font></A>";
						strTable =strTable + "</td>";
						strTable =strTable + " ";
					}
					//Added by DipaliS 8 Oct 2004
					
					else if(normaldays.lastIndexOf("," + intDay + ",") != -1)
					{
						strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt;background:red bgcolor=#cad6e0 >";//modified by pradip on 21-4-2021
						strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth  + "," + intDay + "," + intYear + ")'> " + intDay + "</A>";
						strTable =strTable + "</td>";
						strTable =strTable + " ";
					}
					else
					{
						strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt; >";//modified by pradip on 21-4-2021
						strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ")'> " + intDay + "</A>";
						strTable =strTable + "</td>";
						strTable =strTable + " ";
					}
					
				}
				else
				{ 	
					strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt; >";//modified by pradip on 21-4-2021
					strTable =strTable + "<A href='javascript:SiteCalendarDetails(" + intMonth + "," + intDay + "," + intYear + ")'> " + intDay + "</A>";
					strTable =strTable + "</td>";
					strTable =strTable + " ";
				}		
		     
		    strTable =strTable + " ";
		    column = column + 1;
		    intDay = intDay + 1;
		    if(column == 7)
		    {
		        strTable =strTable + " </tr>";
		        strTable =strTable + " <tr class=clsTREven>";
		        strTable =strTable + " ";
		        column = 0;
		    }
		}
		//'Display next month days 
		intNextMonth = intMonth + 1;
		if(intNextMonth == 13)
		{
		    intNextMonth = 1;
		}
		intNextDay = 1;
		if(column != 0)
		{
		    for(intCount = column;intCount<=6;intCount++)
		    {
		        strTable =strTable + " ";
		        if(intNextDay == 1)
		        {
		            strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #dddddd>";//modified by pradip on 21-4-2021
		            strTable =strTable +  "<%=GetNextMonthName()%>";
		            strTable =strTable + "&nbsp;&nbsp;&nbsp;";
		            strTable =strTable + intNextDay;
		            strTable =strTable + "</td>";
		            strTable =strTable + " ";
		        }
		        else
		        {
		            strTable =strTable + " <td ALIGN=right height=50px width=14% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #dddddd>";//modified by pradip on 21-4-2021
		            strTable =strTable + intNextDay;
		            strTable =strTable + "</td>";
		            strTable =strTable + " ";
		        }
		        strTable =strTable + " ";
		        intDay = intDay + 1;
		        intNextDay = intNextDay + 1;
		    }
		    strTable =strTable + " ";
		}
		
		
		strTable =strTable + "</tbody>";
		strTable =strTable + "</table>";
		
		
		document.all.tdSchedule.innerHTML=strTable;
		
		 
   } 
   
  function DisplaySchedule(intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours)
  {
		GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours);
  }
  function Previous_OnClick()
  {
	//Added the If Condition by DipaliS 7 Oct 2004
	if("<%=m_strFromTimeSheet%>"=="1")
	{
		if(<%=m_intMonth%>!=1)
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action="PM_SiteCalendar.aspx?FromTimeSheet=1&SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear%>" + "&Month=" + "<%=m_intMonth-1%>";
			objform.submit();
		}
		else
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action="PM_SiteCalendar.aspx?FromTimeSheet=1&SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear-1%>" + "&Month=12";
			objform.submit();
		}
	}
	else
	{
		if(<%=m_intMonth%>!=1)
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action="PM_SiteCalendar.aspx?SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear%>" + "&Month=" + "<%=m_intMonth-1%>";
			objform.submit();
		}
		else
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action="PM_SiteCalendar.aspx?SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear-1%>" + "&Month=12";
			objform.submit();
		}
	}
  }
  function Next_OnClick()
  {
			//Added the if by DipaliS 7 Oct 2004
			if("<%=m_strFromTimeSheet%>"=="1")
			{
				if(<%=m_intMonth%>!=12)
				{
				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				    setFrameLoader();
				    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.action="PM_SiteCalendar.aspx?FromTimeSheet=1&SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear%>" + "&Month=" + "<%=m_intMonth+1%>";
					objform.submit();
				}
				else
				{
				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				    setFrameLoader();
				    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.action="PM_SiteCalendar.aspx?FromTimeSheet=1&SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear+1%>" + "&Month=1";
					objform.submit();
				}
			}
			else
			{
				if(<%=m_intMonth%>!=12)
				{
				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				    setFrameLoader();
				    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.action="PM_SiteCalendar.aspx?SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear%>" + "&Month=" + "<%=m_intMonth+1%>";
					objform.submit();
				}
				else
				{
				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				    setFrameLoader();
				    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.action="PM_SiteCalendar.aspx?SiteID=" + "<%=m_SiteID%>" + "&ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + "<%=m_intYear+1%>" + "&Month=1";
					objform.submit();
				}
			}

  }
  function SiteCalendarDetails(intMonth, intDay, intYear)
  {
	//window.open("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2177&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1","Site Calendar","left=50,top=50,height=400,width=550,resizable=yes,scrollbar=yes");
	//alert(intMonth);
	//alert(intDay);
	//alert(intYear);
	//Code Added by DipaliS 6 Oct 2004
	// Added by PrajaktaR on 8 June 2005 for Aspire IssueID 19353
	if(<%=m_SiteID%>==0) 
	{
		alert('Please Select the Site for this Project');
		return;
	}	
	// End of Addition by PrajaktaR on 8 June 2005 for Aspire IssueID 19353
	
             
      //Commented and added by Yogesh Jalamkar on 02-Mar-2016 to pass Token
      //if("<%=m_strFromTimeSheet%>"=="1")
      //	{
      //	var strDate;
      //		strDate= intMonth + '/' + intDay + '/' + intYear;
      //		window.open("PM_SiteCalendarDetails.aspx?Mode=ReadOnly&Date=" + strDate + "&SiteID=" + "<%=m_SiteID%>" ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=170"); 	
      //	}
      //	else
      //	{
      //	var strDate;
   
      //	window.open("PM_SiteCalendarDetails.aspx?Date=" + strDate + "&SiteID=" + "<%=m_SiteID%>" ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=170"); 	
      //	}
      //End Addition by DipaliS
     var stDate = intMonth + '/' + intDay + '/' + intYear;
      $.ajax({
          type: 'POST',
          dataType: 'json',
          contentType: 'application/json',
          url: 'PM_SiteCalendar.aspx/GenrateURLToken_SiteCalendarDetails',
          data: JSON.stringify({ EmpDate: stDate, EmployeeID: "<%=Session("intUserID")%>",SiteID: "<%=m_SiteID%>" }),
          success: function (Result) {   
         if("<%=m_strFromTimeSheet%>"=="1")
          {
            var strDate;
             strDate = intMonth + '/' + intDay + '/' + intYear;
            
            window.open("PM_SiteCalendarDetails.aspx?Mode=ReadOnly&ProjectID="+ '<%=strProjectID%>' +"&EmployeeID=<%=Session("intUserID")%>&Date=" + strDate + "&SiteID=" + "<%=m_SiteID%>&PKToken="+Result.d ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=170"); 	
          }
          else
            {
            var strDate;
            strDate= intMonth + '/' + intDay + '/' + intYear;
            
            window.open("PM_SiteCalendarDetails.aspx?Date=" + strDate + "&ProjectID="+ '<%=strProjectID%>' +"&EmployeeID=<%=Session("intUserID")%>&SiteID=" + "<%=m_SiteID%>&PKToken="+Result.d ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=170"); 	
 	
            }

		  },
		 error: function () {
			 // alert("Error")
		 }
       });
    
	
      //End of addition by Yogesh Jalamkar on 02-Mar-2016 to pass Token
  }
  
  function Site_OnChange()
	{
		var objSite=GetObjectReference('frmPM_SiteCalendar','cboSite');
		var SiteID=0;
		if(objSite!=null)
		    SiteID=objSite.value;
      //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		setFrameLoader();
      //End of Addition by Dhanashri S on 12 Oct 2016
		objform.action="PM_SiteCalendar.aspx?FromTimeSheet=1&Year=" + <%=m_intYear%> + " &Month= "+ <%=m_intMonth%>+ "&SiteID=" + SiteID,"","resizable=yes,width=800,height=550,Left=100,Top=100"
		objform.submit();
	
	}
	//Added by PrachiK on 5 Mar 2005 for IssueID 17462
    //Purpose:The parent page of Project Site does not refreshes when the site calender is changed.
                  
	function CloseOnClick()
	{
		window.close(); 
		//window.opener.location.href = window.opener.location.href;
 	refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx',true);
	}
//Added by PrachiK
					</Script>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
