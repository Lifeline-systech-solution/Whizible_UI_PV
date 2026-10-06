<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ResourceLoadingDailyBreakUp.aspx.vb" Inherits="PbNIT.PM_ResourceLoadingDailyBreakUp"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("ResourceLoadingDailyBreakUp")%>
	
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
		
					<form id="frmPM_ResourceLoadingDailyBreakUp" method="post" runat="server">
									<%PageInit%>
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmPM_ResourceLoadingDailyBreakUp');
		var objdivlist=GetObjectReference('frmPM_ResourceLoadingDailyBreakUp','PageDiv');
		
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
			if("<%=m_intRoleLevel%>"==1)
			{
				//Code Modified by SwatiC on 30 Jun 2007 For Whiz7.0
				//Modified By Mrugaja on 23rd March,2005
				//Purpose:To pass actual work hours to the function
				GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,0,1,"All Projects(Open, Closed &amp; Others)",0,0,0,0);
			}
			else
			{
				//Code Modified by SwatiC on 30 Jun 2007 For Whiz7.0
				//Modified By Mrugaja on 23rd March,2005
				//Purpose:To pass actual work hours to the function
				GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,0,2,"All Projects(Open, Closed &amp; Others)",0,0,0,0);
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
	//'function returns no of allocated hours for specified day in the year
	function  GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours)
	{
		var strHtml;
		if(arrScheduleDetails[intIndex][intDay]>0)
			{
				if(intProjectID==0)
				{
				
					if(arrScheduleDetails[intIndex][intDay]>intTotalWorkingHours)
						{
						//Commented by MrugajaB on 23rd March,2005
						//strHtml ="  "  + intDay +  "<BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'>  "  + intDay +  "</a><BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
					else
						{
						//Commented by MrugajaB on 23rd March,2005
						//strHtml ="  "  + intDay +  "<BR><BR><b>" + arrScheduleDetails[intIndex][intDay] + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" +  Math.round(parseFloat(intTotalWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 					
						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml ="  <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'> "  + intDay +  "</a><BR><BR><b>" + arrScheduleDetails[intIndex][intDay] + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" +  Math.round(parseFloat(intTotalWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
				}
				
				/*Code Added 29 May*/
				if(intProjectID==-1)
				{
				
					if(arrScheduleDetails[intIndex][intDay]>intOtherTotalWorkingHours)
						{
						//Commented by MrugajaB on 23rd March,2005
						//strHtml ="  "  + intDay +  "<BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'>  "  + intDay +  "</a><BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
					else
						{
						//Commented by MrugajaB on 23rd March,2005
						//strHtml ="  "  + intDay +  "<BR><BR><b>" + arrScheduleDetails[intIndex][intDay] + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" +  Math.round(parseFloat(intOtherTotalWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'>  "  + intDay +  "</a><BR><BR><b>" + arrScheduleDetails[intIndex][intDay] + " " +  "<%=m_strHours%>"  + " </Font> </b>  "  + "<BR><b><font color=green>" +  Math.round(parseFloat(intOtherTotalWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
				}
				
				/*End Addition*/
				//Code Added by SwatiC on 30 Jun 2007 For Whiz7.0
				if(intProjectID==-2)
				{
				
					if(arrScheduleDetails[intIndex][intDay]>intTotalWorkingHours)
						{
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'>  "  + intDay +  "</a><BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
					else
						{
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml ="  <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'> "  + intDay +  "</a><BR><BR><b>" + arrScheduleDetails[intIndex][intDay] + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" +  Math.round(parseFloat(intTotalWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
				}
				
				//Commented by SwatiC on 30 Jun 2007
				//if(intProjectID!=-1 && intProjectID!=0)
				if(intProjectID!=-1 && intProjectID!=0 && intProjectID!=-2)
				//End of Code Addition by SwatiC on 30 Jun 2007 For Whiz7.0
				
				{
					if(arrScheduleDetails[intIndex][intDay]>intWorkingHours)
						{
							//Commented by MrugajaB on 23rd March,2005
							//strHtml ="  "  + intDay +  "<BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";  

						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml ="  <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'> "  + intDay +  "</a><BR><BR><BR><b><font color=Red>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";  
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
					else
						{
						//Commented by MrugajaB on 23rd March,2005
						//strHtml ="  "  + intDay +  "<BR><BR><b>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" + Math.round(parseFloat(intWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						
						//Modified By Mrugaja on 23rd March,2005
						//Purpose:To display actual work hours in resource calender
						strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'>  "  + intDay +  "</a><BR><BR><b>" + parseFloat(arrScheduleDetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  "  + "<BR><b><font color=green>" + Math.round(parseFloat(intWorkingHours-arrScheduleDetails[intIndex][intDay])*100)/100 + " " +  "<%=m_strHours%>" + " </Font> </b>  "; 
						strHtml = strHtml + "<BR><b><font color=Blue>" + parseFloat(arrDADetails[intIndex][intDay]) + " " +  "<%=m_strHours%>" + " </Font> </b>  ";   
						}
				}
			}
		else
		{
			strHtml =" <a href='javascript:ShowDetails(" + intDay + ","+ intMonth + "," + intYear + ")'> "  + intDay +  "</a>";  
		}
		
		return strHtml;
	}	 	
    
    //'function returns no of allocated hours for specified day in the year
	
  //---------------------------------------------------------------------------------------------------------------
  //Code Added by JyotiG. On 1st Aug 2006
  //Purpose : ----- WhizibleSEM SP7
  //Issue ID : 5342
  function ShowDetails(intDay,intMonth,intYear)
  {
	window.open("PM_ResourceTaskDetails.aspx?Day="+intDay + "&Month=" + intMonth + "&Year=" + intYear + "&ResourceID="+<%=m_intResourceID%>,"_blank","resizable=yes,scrollbars=no,Left=(window.screen.width-1000)/2,Top=(window.screen.height-550)/2,height=400,width=500");
  }
 //End of addition by JyotiG
 //---------------------------------------------------------------------------------------------------------------
  
  function GenerateCalendarTable(intMonth,intYear,intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours,intBookedHoursDaily)
	  {		var strTable;
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
			
		strTable =  "<table cellSpacing=1 cellPadding=0 width=99.9% border=0 style=border:1 solid #CCCCCC>"; 
		strTable =strTable +  "<tbody>";
		strTable =strTable + " <tr class=clsTRSectionHeader>";
		
		
		strTable =strTable + " <td align=center colspan=7 >";
		
		strTable =strTable + "<%=MyBase.GetResourceString("RESOURCELOADING")%>" + " " + strProjectName + "  :  " + "<%=m_strMonthName%>";
		strTable =strTable + " &nbsp;  ";
		strTable =strTable + intYear;
				
		////Code commented and added by SwatiC on 30 Jun 2007 Whiz7.0
		//if(intProjectID!=0 &&  intProjectID!=-1)
		if(intProjectID!=0 &&  intProjectID!=-1 &&  intProjectID!=-2)
		{
		//End of Code addition by SwatiC on 30 Jun 2007 Whiz7.0
		
		   ////Code Modified by SwatiC on 18 Jun 2007 for Performance Issue            
			strTable =strTable + " &nbsp; &nbsp;" + "<%=MyBase.GetResourceString("ALLOCATEDHOURS")%>" + intTotalAllocatedHours;
		  ////End fo Code Modification by SwatiC on 18 Jun 2007 for Performance Issue            
		}		
		
		if(intProjectID==0)
		{
			 ////Code Modified by SwatiC on 18 Jun 2007 for Performance Issue            
			strTable =strTable + " &nbsp; &nbsp; " + "<%=MyBase.GetResourceString("ALLOCATEDHOURS")%>" + intAllocatedHours;				
			////End fo Code Modification by SwatiC on 18 Jun 2007 for Performance Issue            
		}
		if(intProjectID==-1)
		{
			////Code Modified by SwatiC on 18 Jun 2007 for Performance Issue            
			strTable =strTable + " &nbsp; &nbsp; " + "<%=MyBase.GetResourceString("ALLOCATEDHOURS")%>" + intOtherAllocatedHours;	
			////End fo Code Modification by SwatiC on 18 Jun 2007 for Performance Issue 
		}	
		
		/*End Addition*/
		////Code Added by SwatiC on 30 Jun 2007 for Whiz7.0
		if(intProjectID==-2)
		{
			strTable =strTable + " &nbsp; &nbsp; " + "<%=MyBase.GetResourceString("ALLOCATEDHOURS")%>" + intOpenAllocatedHours;			
		}
		////End of Code Addition by SwatiC on 30 Jun 2007 for Whiz7.0
		
		strTable =strTable + " </td>"; 
		
		strTable =strTable + " </tr>";
		strTable =strTable + " <tr height=22><td colspan=7></td></tr>";
		strTable =strTable + " <tr class=clsTRColumnHeader>";
		
		
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
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #CCCCCC>";
		        strTable =strTable + "<%=GetPrevisousMonthName()%>";
		        strTable =strTable + "&nbsp;&nbsp;&nbsp; ";
		        strTable =strTable + intLastMonthDay;
		        strTable =strTable + " </td>";
		        strTable =strTable + " ";
		        }
		     else
				{
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #CCCCCC>";
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
		
		
		//Display current month details 
		strTable =strTable + " ";
		intDay = 1;
		for(intCount = startDay;intCount<7;intCount++)
		{
		    strTable =strTable + " ";
		    strDate = new Date(intYear, intMonth, intDay)
		    strTable =strTable + " ";
		    if(arrScheduleDetails[intIndex][intDay]<0)
				{
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#E6E6E6 border:1 solid #CCCCCC>";
		        strTable =strTable + GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours);
		        strTable =strTable + "</td>";
		        strTable =strTable + " "
		        }
		     else
				{
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; border:1 solid #CCCCCC>";
		        strTable =strTable + GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours);
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
		    strDate = new Date(intYear, intMonth, intDay);
		    strTable =strTable + " ";
		    if(arrScheduleDetails[intIndex][intDay]<0)
				{
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt; background:#E6E6E6 border:1 solid #CCCCCC>";
		        strTable =strTable + GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours);
		        strTable =strTable + "</td>";
		        strTable =strTable + " ";
		        }
		     else
				{
		        strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top align=right style=font-family: Verdana; font-size: 8pt; border:1 solid #CCCCCC>"; 
		        strTable =strTable + GetScheduleDetails(intYear,intMonth,intDay,intProjectID,intIndex,intWorkingHours);
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
		            strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #CCCCCC>";
		            strTable =strTable +  "<%=GetNextMonthName()%>";
		            strTable =strTable + "&nbsp;&nbsp;&nbsp;";
		            strTable =strTable + intNextDay;
		            strTable =strTable + "</td>";
		            strTable =strTable + " ";
		        }
		        else
		        {
		            strTable =strTable + " <td ALIGN=right height=60px width=13% align=right valign=top style=font-family: Verdana; font-size: 8pt; background:#F0F0F0 border:1 solid #CCCCCC>";
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
		strTable =strTable + "<BR>";
		strTable =strTable + " <table cellSpacing=0 cellPadding=0 width=99.9% border=0> ";
	    strTable =strTable + " <tbody> ";
		strTable =strTable + "   <tr height=10> ";
		strTable =strTable + "	  <td  width=21% >&nbsp;</td> ";
		strTable =strTable + "	  <td  width=2% ><IMG SRC='../../images/red.gif'></td> ";
		strTable =strTable + "	  <td class=clsTDOdd  >" + "<%=MyBase.GetResourceString("OVERALLOCATE")%>"  +"</td> ";
		strTable =strTable + "	  <td  width='2%' ><IMG SRC='../../images/green.gif'></td> ";
		strTable =strTable + "	  <td class=clsTDOdd  >" +  "<%=MyBase.GetResourceString("REMHOURS")%>"  + "</td> ";
		strTable =strTable + "	  <td  width='2%' ><IMG SRC='../../images/black.gif'></td> ";
		strTable =strTable + "	  <td class=clsTDOdd  > " + "<%=MyBase.GetResourceString("ALLOCHOURS")%>" + "</td>  ";
		//Added By MrugajaB on 29th March,2005 for displaying 'Actual Hours' string
		strTable =strTable + "	  <td  width='2%' ><IMG SRC='../../images/blue.gif'></td> ";
		strTable =strTable + "	  <td class=clsTDOdd  > " + "<%=MyBase.GetResourceString("ACTUAL")%>" + "</td>  ";
		//End Addition
		strTable =strTable + "	</tr> ";
		strTable =strTable + "	</tbody> ";
		strTable =strTable + " </table> ";
		
		document.all.tdSchedule.innerHTML=strTable;
		
		  
		   
		if(intProjectID==0)
		{
			//document.all.tdUtilization.innerHTML="<img align=right Border='0' src='../../images/Monthly Resource Utilization.png' width=400 height=200>";
			document.all.tdUtilization.innerHTML="<%=m_strImageForAllProject%>";
			document.all.tdGraphHeading.innerHTML="<%=Mybase.GetResourceString("RESUTILFORALL")%>";
		}
		if(intProjectID==-1)
		{
			//document.all.tdUtilization.innerHTML="<img align=right Border='0' src='../../images/Monthly Resource Utilization.png' width=400 height=200>";
			document.all.tdUtilization.innerHTML="<%=m_strImageForOtherProjects%>";
			document.all.tdGraphHeading.innerHTML="<%=Mybase.GetResourceString("RESUTILFORALL")%>";
		}
		if(intProjectID!=0 && intProjectID!=-1 )
		{
				
			var intCount;
			var intIndexGraph;
			intIndexGraph=0;
			for(intCount=0;intCount<=arrProjectIDs.length;intCount++)
			{
				if(intProjectID == arrProjectIDs[intCount])
				{
					intIndexGraph=intCount;
				}
			}
			document.all.tdGraphHeading.innerHTML="<%=Mybase.GetResourceString("RESUTUTILFOR")%>" + " : " + strProjectName;		
			document.all.tdUtilization.innerHTML=arrImages[intIndexGraph] 
			//document.all.tdUtilization.innerHTML="<img align=right Border='0' width=400 height=200 src='../../images/Monthly Resource Utilization" + intProjectID + ".png'" + " >";
			
			
		}
			
  
   } 
   
  function DisplaySchedule(intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours,intBookedHoursDaily)
  {
		//Modified By Mrugaja on 23rd March,2005
		//Purpose:Passed parameter for displaying actual work hours in resource calender
		GenerateCalendarTable(<%=m_intMonth%>,<%=m_intYear%>,intProjectID,intIndex,strProjectName,intTotalBookedHours,intTotalAllocatedHours,intWorkingHours,intBookedHoursDaily);
  }
 
  function Previous_OnClick()
  {  
	  //Code added by SwatiC on 22 Jun 2007 
	  //To restrict in financial year only
	  var arrFinYearRange= new Array();
	  var objDateRange = GetObjectReference('frmPM_ResourceLoadingDailyBreakUp','txtHiddenFinDateRange');	  
	  var year = '<%=m_intYear%>';
	  var Month = '<%=m_intMonth%>';
	  var tempMonth; 
	  arrFinYearRange = (objDateRange.value).split(','); 
		
		if (Month=='1')
		{
			year = parseInt(year)-1;
			Month = '12';
		}
		else
		{
			year = '<%=m_intYear%>';
			Month = '<%=m_intMonth-1%>';
			tempMonth = '<%=m_intMonth%>';
		}
	
		if (Month!=arrFinYearRange[0] || year==arrFinYearRange[1])
		{
			if (tempMonth==arrFinYearRange[0])
			{
				alert('This is first month of the Financial Year.');
				return;
			}
		    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
			//objform.action="PM_ResourceLoadingDailyBreakUp.aspx?ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + year + "&Month=" + Month;
		    objform.action="PM_ResourceLoadingDailyBreakUp.aspx?ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + year + "&Month=" + Month + "&FlagMove=PrevNext";
		    //End of Addition by Dhanashri S on 11 Aug 2016
			objform.submit();
		}
		/*else
		{
			alert('This is first month of the Financial Year.');
		}*/
		//End of Code addition by SwatiC on 22 Jun 2007
  }
  function Next_OnClick()
  {
		//Code added by SwatiC on 22 Jun 2007 
	  //To restrict in financial year only
		var arrFinYearRange= new Array();
		var objDateRange = GetObjectReference('frmPM_ResourceLoadingDailyBreakUp','txtHiddenFinDateRange');	   
		var year = '<%=m_intYear%>';
		var Month = '<%=m_intMonth%>';
		var tempMonth; 
	  	arrFinYearRange = (objDateRange.value).split(','); 		
		if (Month=='12')
		{
			year = parseInt(year)+1;
			Month = '1';
		}
		else
		{
			year = '<%=m_intYear%>';
			Month = '<%=m_intMonth+1%>';
			tempMonth = '<%=m_intMonth%>';
		}
	   
		if (tempMonth!=arrFinYearRange[2] || year!=arrFinYearRange[3])
		{
		    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
		    //objform.action="PM_ResourceLoadingDailyBreakUp.aspx?ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + year + "&Month=" + Month ;
		    objform.action="PM_ResourceLoadingDailyBreakUp.aspx?ResourceID=" + "<%=m_intResourceID%>" + "&Year=" + year + "&Month=" + Month + "&FlagMove=PrevNext";
		    //End of Addition by Dhanashri S on 11 Aug 2016
			objform.submit();
		}
		else
		{
			alert('This is last month of the Financial Year.');
		}
		//End of Code addition by SwatiC on 22 Jun 2007
  }

					</Script>
	</body>
</HTML>
