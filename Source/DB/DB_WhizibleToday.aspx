<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_WhizibleToday.aspx.vb" Inherits="PbNIT.DB_WhizibleToday"%>
<!DOCTYPE HTML>
<HTML>
	<%PlotHead()%>

	<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("Select Project")%> 
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
  
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmDB_WhizibleToday" method="post" runat="server">
						
									<%PageInit%>
					</form>
					<Script language="javascript">
		var objfrmDB_WhizibleToday=GetFormReference('frmDB_WhizibleToday');
		var objdivlist=GetObjectReference('frmDB_WhizibleToday','PageDiv');
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
					    function window_onload() {
					         
					        var intDivHeight;
					        var intDivHeightRisk;
					        if (objdivlist != null) {

					            // Added & Commented By Vidya J ON 18 Dec 2015
					            if (WhichBrowser() == 'IE') {

					                intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

					            }
					            else
					                if (WhichBrowser() == 'CR') {

					                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

					                }
					                else
					                    if (WhichBrowser() == 'FF') {

					                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 9;

					                    }

					            if (intDivHeight < 100) intDivHeight = 100;
					            objdivlist.style.height = intDivHeight + "px";
					        }







					        //	//var intDivHeight ;
					        //	//var intDivHeightRisk;
					        //	//if (objdivlist !=null) {
					        //	//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					        //	//if (intDivHeight < 100)	intDivHeight = 100;
					        //	//objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;	
					        //}			
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
					    function window_onresize() {
					        //	var intDivHeight;
					        //	var intDivHeightRisk;
					        //	if (objdivlist !=null) {
					        //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					        //	if (intDivHeight < 100)	intDivHeight = 100;
					        //	objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
					        //}

					        if (objdivlist != null) {

					            // Added By Vidya J on 18 Dec 2015
					            if (WhichBrowser() == 'IE') {

					                intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

					            }
					            else
					                if (WhichBrowser() == 'CR') {

					                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

					                }
					                else
					                    if (WhichBrowser() == 'FF') {

					                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 9;

					                    }

					            if (intDivHeight < 100) intDivHeight = 100;
					            objdivlist.style.height = intDivHeight + "px";
					        }
					        //End Of Added& Commented By Vidya J ON 18 Dec 2015
					    }
		function Help_OnClick(HelpID) 
		{ 
			window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250"); 
		}	
		
		// added by  harshada D for PMLifeLine on 25 th may 2006
		
		function Action_PointsOnclick(intReviewStatisticsID) 
		{
		 window.open("../General/CommonList.aspx?FromWhere=DB&MasterTagId=3629&ReviewStatisticsID="+ intReviewStatisticsID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");

		}
		function TSRV_DetailsOnclick(intReviewStatisticsID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&ReviewStatisticsID="+ intReviewStatisticsID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");

		}
		function TSIB_DetailsOnclick(intIssueID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");

		}
		function TSPM_DetailsOnclick(intTaskID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&TaskID="+ intTaskID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");

		}
		
		function TSDEL_DetailsOnclick(intDeliverableID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&DeliverableID="+ intDeliverableID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");

		}

//Modified by MonikaI. IssueID : 3926
		//strToekn Parameter added By JyotiG for Security Issue.
		function IB_DiscussionOnclick(intIssueID,strToken) 
			{ 
				
				//window.open("../IB/IB_Discussion.aspx?FromWhere=DB&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				//Commented And Modofied By JyotiG
				//Start
				//Date: 28-Sep-2006
				//Issue ID : 6197
				//window.open("../IB/IB_Discussion.aspx?FromWhere=DB&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				//Commented And Modified By JyotiG
				//Purpose : Developer Dashboard Enhanced View
				//Start
				//window.open("../IB/IB_Discussion.aspx?PKToken=" + strToken + "&FromWhere=DB&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				if ("<%=strDashBoard%>" == "DEV" )
					window.open("../IB/IB_Discussion.aspx?PKToken=" + strToken + "&Dashboard=DEV&FromWhere=DB&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");
				else
					window.open("../IB/IB_Discussion.aspx?PKToken=" + strToken + "&Dashboard=PMDB&FromWhere=DB&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>&IssueID="+ intIssueID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=720,height=430");					
					
				//End OF modification By JyotiG
				//End
			}
//End by MonikaI
		
	//Addition by MonikaI on 21st Aug 2006 For PMLifeLine
		function Filters_Onclick(fromWhere)
		{
			//window.open ("../DB/DB_WhizibleToday_Filter.aspx?FromWhere=" + fromWhere + "&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>&PMVisitNo="+strPMVisitNo + "&IBVisitNo=" + strIBVisitNo + "&DELVisitNo=" + strDELVisitNo + "&RVVisitNo=" + strRVVisitNo,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//window.open ("../DB/DB_WhizibleToday_Filter.aspx?FromWhere=" + fromWhere + "&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
			if ("<%=strDashBoard%>" == "DEV" )
				window.open ("../DB/DB_WhizibleToday_Filter.aspx?DashBoard=DEV&FromWhere=" + fromWhere + "&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
			else
				window.open ("../DB/DB_WhizibleToday_Filter.aspx?DashBoard=PMDB&FromWhere=" + fromWhere + "&PageNumberPM=<%=m_intPageNumberPM%>&PageNumberIB=<%=m_intPageNumberIB%>&PageNumberDEL=<%=m_intPageNumberDEL%>&PageNumberRV=<%=m_intPageNumberRV%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );			
			//End				
		}
	//End of addition by MonikaI

		function txtPageNumber_KeyPress(e,fromwhere)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumberPM =  GetObjectReference('objfrmDB_WhizibleToday','txtPageNumberPM');
				var objtxtNoOfPagesPM = GetObjectReference('objfrmDB_WhizibleToday','txtNoOfPagesPM');

				var objtxtpageNumberIB =  GetObjectReference('objfrmDB_WhizibleToday','txtPageNumberIB');
				var objtxtNoOfPagesIB = GetObjectReference('objfrmDB_WhizibleToday','txtNoOfPagesIB');
				
				var objtxtpageNumberDEL =  GetObjectReference('objfrmDB_WhizibleToday','txtPageNumberDEL');
				var objtxtNoOfPagesDEL = GetObjectReference('objfrmDB_WhizibleToday','txtNoOfPagesDEL');
				
				var objtxtpageNumberRV =  GetObjectReference('objfrmDB_WhizibleToday','txtPageNumberRV');
				var objtxtNoOfPagesRV = GetObjectReference('objfrmDB_WhizibleToday','txtNoOfPagesRV');
												
				var strtxtpageNumber= 'txtPageNumber' + fromwhere ;  
				var objtxtpageNumber = document.getElementById(strtxtpageNumber); 
				
				//Added by MonikaI. Issue ID.3926 For PMLifeLine
				//var strtxtNoOfPages= 'txtNoOfPages' + fromwhere ;  
				//var objtxtNoOfPages = document.getElementById(strtxtNoOfPages); 
				
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}

					if (objtxtpageNumberPM.value == '')
					{
						objtxtpageNumberPM.value = 0;
					}

					if (objtxtpageNumberIB.value == '')
					{
						objtxtpageNumberIB.value = 0;
					}

					if (objtxtpageNumberDEL.value == '')
					{
						objtxtpageNumberDEL.value = 0;
					}

					if (objtxtpageNumberRV.value == '')
					{
						objtxtpageNumberRV.value = 0;
					}

					if (disallowNonNumeric(objtxtpageNumberPM,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberIB,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberDEL,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberRV,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true))
						return;


					if(Number(objtxtpageNumberPM.value) > Number(objtxtNoOfPagesPM.value) )
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						setFocus(objtxtpageNumberPM);
						return;
					}
					if(Number(objtxtpageNumberIB.value) > Number(objtxtNoOfPagesIB.value) )
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						setFocus(objtxtpageNumberIB);
						return;
					}
					if(Number(objtxtpageNumberDEL.value) > Number(objtxtNoOfPagesDEL.value) )
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						setFocus(objtxtpageNumberDEL);
						return;
					}
					if(Number(objtxtpageNumberRV.value) > Number(objtxtNoOfPagesRV.value) )
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						setFocus(objtxtpageNumberRV);
						return;
					}
	//End of modification by MonikaI				
	
					var str =objtxtpageNumberPM.value+','+objtxtpageNumberIB.value+','+objtxtpageNumberDEL.value+','+objtxtpageNumberRV.value
					Page_Onclick(str);
			}	
			}
		
		}
	
	//	function Page_Onclick(PageNumberPM,pageNumberIB,PageNumberDEL,pageNumberRV)
			function Page_Onclick(str)
		{
		//alert(str);
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberIB = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberRV = strPageNumber[3];
		}		
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//strLocation = "DB_WhizibleToday.aspx?PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			if ("<%=strDashBoard%>" == "DEV" )
				strLocation = "DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			else
				strLocation = "DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV					
				
			strLocation = strLocation ;
			objfrmDB_WhizibleToday.action = strLocation
			objfrmDB_WhizibleToday.submit();
		}
		
		
		
		
		function PagePM_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberIB = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberRV = strPageNumber[3];
		}	
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//strLocation = "DB_WhizibleToday.aspx?PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			if ("<%=strDashBoard%>" == "DEV" )
				strLocation = "DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			else
				strLocation = "DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
								
			strLocation = strLocation ;
			objfrmDB_WhizibleToday.action = strLocation
			objfrmDB_WhizibleToday.submit();
		}
		function PageIB_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberIB = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberRV = strPageNumber[3];
		}		
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//strLocation = "DB_WhizibleToday.aspx?PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			if ("<%=strDashBoard%>" == "DEV" )
				strLocation = "DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			else
				strLocation = "DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV		
				
			strLocation = strLocation ;
			objfrmDB_WhizibleToday.action = strLocation
			objfrmDB_WhizibleToday.submit();
		}
		function PageDEL_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberIB = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberRV = strPageNumber[3];
		}	
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//strLocation = "DB_WhizibleToday.aspx?PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			if ("<%=strDashBoard%>" == "DEV" )
				strLocation = "DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			else
				strLocation = "DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV	
				
			strLocation = strLocation ;
			objfrmDB_WhizibleToday.action = strLocation
			objfrmDB_WhizibleToday.submit();
		}
		
		
		function PageRV_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberIB = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberRV = strPageNumber[3];
		}		
			//Commented and Modified By JyotiG
			//Date : 16-Oct-2006
			//Purpose : Developer Dashboard Enhanced View
			//Start
			//strLocation = "DB_WhizibleToday.aspx?PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			if ("<%=strDashBoard%>" == "DEV" )
				strLocation = "DB_WhizibleToday.aspx?Dashboard=DEV&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
			else
				strLocation = "DB_WhizibleToday.aspx?Dashboard=PMDB&PageNumberPM=" + PageNumberPM + "&PageNumberIB=" + pageNumberIB + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberRV=" + pageNumberRV
				
			strLocation = strLocation ;
			objfrmDB_WhizibleToday.action = strLocation
			objfrmDB_WhizibleToday.submit();
		}
		
		// end of addition by harshada D for PMLifeLine on 25 th may 2006
					</Script>
	</body>
</HTML>
