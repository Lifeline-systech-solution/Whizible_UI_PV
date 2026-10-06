<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DailyActivityWeeklyView.aspx.vb" Inherits="PbNIT.DailyActivityWeeklyView"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag("DailyActivityWeeklyView")%>

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
      /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
        table
        {
            width:100% !important;
        }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
		
					<form id="frmDailyActivityWeeklyView" method="post" runat="server">
						
									<%PageInit%> 
							
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmDailyActivityWeeklyView');
		var objdivlist=GetObjectReference('frmDailyActivityWeeklyView','DivList');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		    var browser = WhichBrowser();
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //if (browser == 'FF')
                //    //Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID:2030
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 140;
			    //else if (browser == 'IE') 
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 155;
			    //else if (browser == 'CR') 
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 206;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 175;
			    //End of Comment and Addition by Dhanashri S on 7 Dec 2015
			    intDivHeight = window.innerHeight - objdivlist.offsetTop -46;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
			
        }			
		}
		function WhichBrowser() {

		    var brwser = '';
		    var ua = navigator.userAgent, tem,
            M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
		    if (/trident/i.test(M[1])) {
		        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
		        //return 'IE '+(tem[1] || '');
		        return 'IE';
		    }
		    if (M[1] === 'Chrome') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'CR';
		    }
		    else if (M[1] === 'Firefox') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'FF';
		    }
		    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
		    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
		    //return M.join(' ');
		    return brwser;
		}
		function window_onresize()		
		{
		    var browser = WhichBrowser();
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //if (browser == 'FF')
			    //    //Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID:2030
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 140;
			    //else if (browser == 'IE') 
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 155;
			    //else if (browser == 'CR') 
			    //    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 206;
			    //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 175;
			    ////End of Comment and Addition by Dhanashri S on 7 Dec 2015
			    intDivHeight = window.innerHeight - objdivlist.offsetTop -46;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
		}	
	/*	function Show_OnClick(){
		var objFromDate=GetObjectReference('frmDailyActivityWeeklyView','FromDate');
		var objToDate=GetObjectReference('frmDailyActivityWeeklyView','ToDate');
		frmDailyActivityWeeklyView.action = "DailyActivityWeeklyView.aspx?SelectedDate=<%=dtmSelectedDate%>&Show=true&FromDate="+objFromDate.value+"&ToDate="+objToDate.value;
		frmDailyActivityWeeklyView.submit();
		
		}*/
		// Modified by NitinVS on 7 Dec 2005 for PMLifeLine  SP5 IssueID 672
		//function FromDate_onfocus
		function FromDate_onKeyPress(e){
		<%if m_UseEditableDateControl = true then%>
		var keynum
		var objFromDate = GetObjectReference('frmDailyActivityWeeklyView','FromDate');
		if(window.event) // IE
		{ keynum = e.keyCode }
		else if(e.which) // Netscape/Firefox/Opera</DIV>
		{ keynum = e.which }
�		if (keynum==13) 
		{
		
		str = DateControl_StandardOnblur('frmDailyActivityWeeklyView','FromDate','<%=strInputdateFormat%>','')
		
		if (str==false)
		{
		 return;
		} 
		
		//frmDailyActivityWeeklyView.action = "DailyActivityWeeklyView.aspx?SelectedDate="+val;
		
		//frmDailyActivityWeeklyView.action = "DailyActivityWeeklyView.aspx?SelectedDate="+ objFromDate.value ;
		//frmDailyActivityWeeklyView.submit();
		}
		<%end if%>
		}
		
		// End Modification By NitinVS on 7 Dec 2005 for PMLifeLine  SP5 IssueID 672
		
		function PreviousWeek_OnClick(){
		frmDailyActivityWeeklyView.action ="DailyActivityWeeklyView.aspx?Previous=true&SelectedDate=<%=dtmSelectedDate%>";
		frmDailyActivityWeeklyView.submit();
			}
	
	function NextWeek_OnClick(){
	frmDailyActivityWeeklyView.action ="DailyActivityWeeklyView.aspx?Next=true&SelectedDate=<%=dtmSelectedDate%>";
	frmDailyActivityWeeklyView.submit();
	}
	function MyTaskList_OnClick(){
	//window.open("MyTaskList.aspx?","_popup","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=500")
	window.open("MyTaskList.aspx?","_popup","resizable=no,scrollbars=yes,left=60,top=150,width=900,height=507")
	}

        // Added by NitinVS on 7 Dec 2005 for PMLifeLine SP5 IssueID 672
// fn.. to display the calendar control
	function callcalendar(formname,datefield)
	{
		var objdateObject=GetObjectReference(formname,datefield)
		var dtval;
		
		
		if(objdateObject.value =='')
			dtval='None';
		else
			dtval=objdateObject.value;
		calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval+'&FromWhere=DV','calendar_window','top=0,left=0,width=348,height=260');calendar_window.focus();
	}
	  // End Addition by NitinVS on 7 Dec 2005 for PMLifeline  SP5 IssueID 672
	</Script>
			
	</body>
</HTML>
