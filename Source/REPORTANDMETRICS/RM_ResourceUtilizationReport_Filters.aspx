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
	/* Added By Gauri On 30th Aug 2024 For Alignment Issue */
	#tblMainPage a.clsSelected:hover{
		text-decoration: underline !important;
	}
	/* End of Added By Gauri On 30th Aug 2024 For Alignment Issue */
</style>

<script type="text/javascript">
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015

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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RM_ResourceUtilizationReport_Filters.aspx.vb" Inherits="PbNIT.RM_ResourceUtilizationReport_Filters"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->

<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Resource Utilization")%>
    
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmResourceUtilizationFilters" method="post" runat="server">
			<% BuildPage()%>
		</form>
		<script language="javascript">
		var objDateRange = GetObjectReference('frmResourceUtilizationFilters','cboDateRange');
		var objfrm=GetFormReference('frmResourceUtilizationFilters');
		var objhidFilterID = GetObjectReference('frmResourceUtilizationFilters','hidFilterID');
		var objFilterID=GetObjectReference('frmResourceUtilizationFilters','cboAppliedView');
		
		var objhidDateRange=GetObjectReference('frmResourceUtilizationFilters','hidDateRangeID');
		var objdivlist = GetObjectReference('frmResourceUtilizationFilters','FilterRecordsdiv');	
		//var objdivlist = GetObjectReference('frmResourceUtilizationFilters','DivList');	
		
		
		var objFilterMenudiv =GetObjectReference('frmResourceUtilizationFilters','FilterMenudiv');
		var DateRangeID;
		var FilterID;
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		function GenerateReport()
		 {
		    if(objDateRange)
		    DateRangeID = objDateRange.value;
		    else
		    DateRangeID = objhidDateRange.value;
		    
		    if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;
		      
		    if(FilterID=="")
		    {
		      alert('Select the filter to be applied.');
		      setFocus(objFilterID);
		      return;
		    }
		    
		    
		    window.open("RM_ResourceUtilizationReport_Filters.aspx?Mode=Generate&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&FilterID="+FilterID+"&DateRangeID="+DateRangeID,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 580)/2 + ",width=950,height=580");  
		 }
			 
		function DisplayDetails_OnClink(intBUID,intOUID,intDUID,intProjectID,intResourceID,intDateRangeID )
		 { 
		    if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;
		      
		    if(FilterID=="")
		    {
		      alert('Select the filter to be applied.');
		      setFocus(objFilterID);
		      return;
		    }
		    
			if(objDateRange)
		    DateRangeID = objDateRange.value;
		    else
		    DateRangeID = objhidDateRange.value;
		    		    
			window.open("RM_ResourceUtilizationReport_Filters.aspx?Mode=DisplayDetails&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&FilterID="+FilterID+"&DateRangeID=" + DateRangeID  ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=1000,height= 650");  
		 }

		function DisplaySummaryDetails_OnClink(intBUID,intOUID,intDUID,intProjectID,intResourceID,intDateRangeID)
		 {
			if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;
		      
		    if(FilterID=="")
		    {
		      alert('Select the filter to be applied.');
		      setFocus(objFilterID);
		      return;
		    }
		    
		    if(objDateRange)
		    DateRangeID = objDateRange.value;
		    else
		    DateRangeID = objhidDateRange.value;
			window.open("RM_ResourceUtilizationReport_Filters.aspx?Mode=DisplaySummaryDetails&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&FilterID="+FilterID+"&DateRangeID=" + DateRangeID ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=950,height=650");  
		 }
			 
		function Close_OnClink()
		 {
			window.close();
		 }
		 
		 function ViewDeployable(show)
		{
			 if(objDateRange)
		    DateRangeID = objDateRange.value;
		    else
		    DateRangeID = objhidDateRange.value;
		    
		    if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;
		      
		    
				objfrm.action = "RM_ResourceUtilizationReport_Filters.aspx?Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&FilterID="+FilterID+"&DateRangeID=" + DateRangeID + "&ShowDeployableOnly=" + show;
				objfrm.submit();				 
		 }
			 
				
		function Print_Onclick()
		{
			var ReportMode;
			var intReportID;
				
			ReportMode="<%=m_strMode%>";
				
			if(ReportMode=="DisplayDetails")
				 intReportID=2126
			else
				 intReportID=2124
			
			if(objDateRange)
		    DateRangeID = objDateRange.value;
		    else
		    DateRangeID = objhidDateRange.value;
		    
		    if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;				 
		    // Commented and Added by Shamkant S on 28 Jan 2016
		  //  window.open("../REPORTANDMETRICS/RM_ShowReport.aspx?FromWhere=Filter&FilterID=" + FilterID + "&Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&DateRangeID=" + DateRangeID + "&ShowDeployableOnly=<%=m_ShowDeployableOnly%>&ReportID=" + intReportID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",width=550,height=300");
		   
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'RM_ResourceUtilizationReport_Filters.aspx/GenrateURLToken_Print_OnClick',
		        data: JSON.stringify({ ReportID: intReportID, ResourceID: "<%=m_strEmployeeID%>", DateRangeID: DateRangeID }),
		        success: function (Result) {
		            window.open("../REPORTANDMETRICS/RM_ShowReport.aspx?FromWhere=Filter&PKToken=" + Result.d + "&FilterID=" + FilterID + "&Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&DateRangeID=" + DateRangeID + "&ShowDeployableOnly=<%=m_ShowDeployableOnly%>&ReportID=" + intReportID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",width=550,height=300");
		        },
		        error: function () {
		       //     alert("Error")
		        }
		    });
		    // Commented Ended by Shamkant S on 28 Jan 2016
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
		var tblHeight;
		function window_onload()
		{
		   
		    var browser = WhichBrowser();
		    var intDivHeight ;
			var intDivHeightRisk;
            //Added by Nilesh G on 2/12/2015 for issue id 2565
			var Mode = getParameterByName("Mode");
			if(document.getElementById('FilterTbl'))
			{
				if(!objdivlist)
				{
					objdivlist = GetObjectReference('frmResourceUtilizationFilters','DivGraph');
					tblHeight = document.getElementById('FilterTbl').offsetHeight-94;
				}
				else
				tblHeight=document.getElementById('FilterTbl').offsetHeight;
			}
			else
			    tblHeight = 0;
			if (objdivlist == null) {
			  
			    objdivlist = GetObjectReference('frmResourceUtilizationFilters', 'DivList');
			}
			
						
			if (objdivlist != null) {

			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + (tblHeight) ;

			intDivHeight = window.innerHeight - objdivlist.offsetTop;
			if (intDivHeight < 100) intDivHeight = 100;
			else
			if (Mode == "Generate") {
			    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 16;


			    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 16-23;//added By Shamkant S on 8 Dec 2015 Issueid 2565
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 12;
			    //alert(intDivHeight)
			    }
			else
			if (Mode == "DisplaySummaryDetails") {
			   // intDivHeight = window.innerHeight - objdivlist.offsetTop - 111
			            intDivHeight = window.innerHeight - objdivlist.offsetTop - 111-25;//added by Shamkant S on 8 Dec 2015
			           
			        }
			else

			if (Mode == "DisplayDetails") {
			    
			                intDivHeight = window.innerHeight - objdivlist.offsetTop - 133;
			               
			            }
		    else
			if (browser == "IE")
			{
			    
			    intDivHeight = window.innerHeight - objdivlist.offsetTop-67;
		    }
			else
			    if (browser == "CR")
			    {
			      
			        intDivHeight = window.innerHeight - objdivlist.offsetTop-65;
			       
			    }
			else
			if (browser == "FF")
			{  
			    intDivHeight = window.innerHeight - objdivlist.offsetTop-70;
			   
			}
			else
			{
			    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - (106+tblHeight);
			    intDivHeight = window.innerHeight - objdivlist.offsetTop;
			    //End of Comment by Yogesh J on 23-NOV-2015
			}

			objdivlist.style.height = intDivHeight +'PX';
			
			  //endded by Nilesh G on 2/12/2015 for issue id 2565
		}
			if(objFilterMenudiv)
			{		
			objFilterMenudiv.style.position = "absolute";
			objFilterMenudiv.style.left = 40;
			objFilterMenudiv.style.top = 40;
			}
			if(typeof(doCallShowFilter) != "undefined")
			if(doCallShowFilter==1)
			{
			alert('Filter name ' + GetObjectReference('frmResourceUtilizationFilters','txtFilter').value + ' already exists.');
			showFilters('');
			setFocus(GetObjectReference('frmResourceUtilizationFilters','txtFilter'));
			}
			
			var toDel = GetObjectReference('frmResourceUtilizationFilters','toDel',true);
			var tr,i;
			var tbl;
						
			if(!toDel[0])
			return;
			
			tr = toDel[0];
			while(tr.parentNode)
			{
				tbl=tr.parentNode;
				tr=tr.parentNode;
				if(tbl.tagName=="TABLE")
				break;
			}
			
			if(tbl.tagName=="TABLE")
			for(i=toDel.length-1;i>=0;i--)
			{
				tr = toDel[i].parentNode;
				tbl.deleteRow(tr.rowIndex)
			}
		}
			
		function window_onresize() {
		    var browser = WhichBrowser();// Added By Vaijat K ON 25/11/2015
		    var intDivHeight;
		    var intDivHeightRisk;
		    //Added by Nilesh G on 2/12/2015 for issue id 2565
		    var Mode = getParameterByName("Mode");
		    if (document.getElementById('FilterTbl')) {
		        if (!objdivlist) {
		            objdivlist = GetObjectReference('frmResourceUtilizationFilters', 'DivGraph');
		            tblHeight = document.getElementById('FilterTbl').offsetHeight - 94;
		        }
		        else
		            tblHeight = document.getElementById('FilterTbl').offsetHeight;
		    }
		    else
		        tblHeight = 0;
		    if (objdivlist == null) {

		        objdivlist = GetObjectReference('frmResourceUtilizationFilters', 'DivList');
		    }


		    if (objdivlist != null) {

		        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + (tblHeight) ;

		        intDivHeight = window.innerHeight - objdivlist.offsetTop;
		        if (intDivHeight < 100) intDivHeight = 100;
		        else
		            if (Mode == "Generate") {

		                intDivHeight = window.innerHeight - objdivlist.offsetTop - 16-23;
		            }
		            else
		                if (Mode == "DisplaySummaryDetails") {

		                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 111-25;

		                }
		                else

		                    if (Mode == "DisplayDetails") {

		                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 133;

		                    }
		                    else
		                        if (browser == "IE") {

		                            intDivHeight = window.innerHeight - objdivlist.offsetTop - 67;
		                        }
		                        else
		                            if (browser == "CR") {

		                                intDivHeight = window.innerHeight - objdivlist.offsetTop - 65;

		                            }
		                            else
		                                if (browser == "FF") {
		                                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 70;

		                                }
		                                else {
		                                    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - (106+tblHeight);
		                                    intDivHeight = window.innerHeight - objdivlist.offsetTop;
		                                    //End of Comment by Yogesh J on 23-NOV-2015
		                                }

		        objdivlist.style.height = intDivHeight + 'px';
		        //endded by Nilesh G on 2/12/2015 for issue id 2565	}
		    }
		}
		function CreateView()
		{
		  window.open("../REPORTANDMETRICS/RM_CommonList.aspx?MasterTagID=3903","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
		}
		
		function Period_Onchange()
		{
		  DateRangeID = objDateRange.value;
		  if(objFilterID)
		      FilterID=objFilterID.value;
		    else
		      FilterID=objhidFilterID.value;
		  
		  objfrm.action="RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&Mode=DisplayDetails&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ResourceID=<%=m_strEmployeeID%>&FilterID="+FilterID+"&DateRangeID=" + DateRangeID;
		  objfrm.submit();
		}
		
		</script>
	</body>
</HTML>
