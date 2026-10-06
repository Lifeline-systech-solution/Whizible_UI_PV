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

 /*for scoll bar issue added By Dipali V */
    #PageDiv, #DivList{
        height:auto!important;
    }
    /*End of for scoll bar issue*/

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ProjectClosure.aspx.vb" Inherits="PbNIT.PRO_ProjectClosure"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><html>
 	<%CommonFunctions.General.PlotPageHeadTag("PRO_ProjectClosure")%>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPRO_ProjectClosure"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmPRO_ProjectClosure');
		var objdivlist=GetObjectReference('frmPRO_ProjectClosure','PageDiv');
		
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
			
			

			if (intDivHeight < 100)	intDivHeight = 100;
						
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
			 if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			 }
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			// objdivlist.style.height = intDivHeight;
			 objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
			
			
				}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
			 if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			 if (intDivHeight < 100) intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			// objdivlist.style.height = intDivHeight;
			 objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/ 
				}
		}	
	
	    function Sort_OnClick(strFieldName, strAscOrDesc)
		{
			var objForm, objSortBy, objSortOrder;
			objForm = GetFormReference('frmPRO_ProjectClosure');
			objSortBy = GetObjectReference('frmPRO_ProjectClosure','txthidSortBy');
			objSortOrder = GetObjectReference('frmPRO_ProjectClosure','txthidSortOrder');
			objSortBy.value = strFieldName;
			objSortOrder.value = strAscOrDesc;
	        //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			setFrameLoader();
	        //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			objForm.submit();
		}
		function ShowDetails(intProjectID)
        {
			objForm = GetFormReference('frmPRO_ProjectClosure');
            objForm.action = "PRO_ProjectClosure.aspx?Mode=AnalysisDetails&ProjectID=" + intProjectID + "&PageNumber=" + $("#txthidPageNo").val();
		    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			setFrameLoader();
		    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			objForm.submit();
		}
		function Back_OnClick(strPageNumber)
        {
			objForm = GetFormReference('frmPRO_ProjectClosure');
            objForm.action = "PRO_ProjectClosure.aspx?Mode=ShowList&MasterTagId=708" + "&PageNumber=" + strPageNumber;
		    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			setFrameLoader();
		    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			objForm.submit();
		}
		
		function Page_Onclick(strPageNumber)
        {
			objForm = GetFormReference('frmPRO_ProjectClosure');
			objForm.action = "PRO_ProjectClosure.aspx?Mode=ShowList&PageNumber=" + strPageNumber + "&MasterTagId=708";
		    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			setFrameLoader();
		    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose: For Page Loader
			objForm.submit();
		}
		
		function CallGatherData()
		{
			window.open("PRO_ProjectClosure.aspx?Mode=GatherData&ProjectID=<%=intProjectID%>","_self","resizable=yes,width=500,height=350,left=50,top=140,status =no,titlebar=no,location=no ");
		}

		function ShowProjectCLosureReport(intProjectID)
		{
			window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=<%=intProjClosureAnalysisReportID%>&UniqueID=" + intProjectID,"","resizable=yes,scrollbars=no,width=550,height=400,left=50,top=140,status =no,titlebar=no,location=no ");	
		}

		function LinkOnclick(strGoals,intAnalysisID,intProjectID)
		{
            //Commented and added by Yogesh J on 10-Feb-2016 to pass token
			//window.open ("PRO_ProjectClosureDetails.aspx?Mode=" + strGoals +"&AnalysisID=" + intAnalysisID +"&ProjectID=" + intProjectID ,"","resizable=yes,scrollbars=no,left=200,top=200,width=550,height=225");
		    window.open("PRO_ProjectClosureDetails.aspx?FromWhere=PRO&Mode=" + strGoals + "&AnalysisID=" + intAnalysisID + "&ProjectID=" + intProjectID + "&PKToken=<%=m_PKToken%>", "", "resizable=yes,scrollbars=no,left=200,top=200,width=550,height=225");
            //End of Comment by Yogesh J
		}

		function CausalAnalysis(intAnalysisID)
		{
		    window.location.href = "PRO_ProjectClosureDetails.aspx?Mode=CAUANA&AnalysisID=" + intAnalysisID + "&PKToken=<%=m_PKToken1%>";
		}

		function TotalLOC(intAnalysisID)
		{
        //Commented and added by Yogesh J on 10-Feb-2016 to pass token
		//	window.open("PRO_Milestones.aspx?MODE=TOTAL_LOC&FormName=frmPRO_ProjectClosure&ANAL_ID=" + intAnalysisID,"","TOOLBAR=no,TITLEBAR=no,TOP=200,scrollbars=no,LEFT=200,WIDTH=400,HEIGHT=300");
			window.open("PRO_Milestones.aspx?MODE=TOTAL_LOC&FormName=frmPRO_ProjectClosure&ANAL_ID=" + intAnalysisID+"&PKToken=<%=m_strToken%>", "", "TOOLBAR=no,TITLEBAR=no,TOP=200,scrollbars=no,LEFT=200,WIDTH=400,HEIGHT=300");
       //End of addition by Yogesh J 
		}

		function LinkMileStone(intAnalysisID)
		{
		    //Commented and added by Yogesh J on 10-Feb-2016 to pass token
		    //window.open("PRO_Milestones.aspx?MODE=CONCLUSION&FormName=frmPRO_ProjectClosure&ANAL_ID=" + intAnalysisID ,""  ,"TOOLBAR=no,TITLEBAR=no,RESIZABLE=no,scrollbars=no,TOP=150,LEFT=200,WIDTH= 600,HEIGHT=550");
		    window.open("PRO_Milestones.aspx?MODE=CONCLUSION&FormName=frmPRO_ProjectClosure&ANAL_ID=" + intAnalysisID + "&PKToken=<%=m_strToken%>", "", "TOOLBAR=no,TITLEBAR=no,RESIZABLE=no,scrollbars=no,TOP=150,LEFT=200,WIDTH= 600,HEIGHT=550");
		    //End of addition by Yogesh J 

		}	

		function CloseProject(intProjectID)
		{
			window.open ("PRO_ProjectClosure.aspx?Mode=CloseProject&ProjectID=" + intProjectID,"_self","resizable=yes,scrollbars=yes,left=0,top=0,width=550,height=225");
		}

	</Script>
  </body>
</html>
