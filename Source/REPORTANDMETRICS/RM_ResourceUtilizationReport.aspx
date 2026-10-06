<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<!-- <script src="../General/CommonFunctions.js"></script> -->
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
   
    /*Commented and added by Yogesh J on 04-Nov-2015*/
    #DivMain>.clsTable td{
    padding-left:5px !important;
    }
      /*End of addition by Yogesh J on 04-Nov-2015*/
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RM_ResourceUtilizationReport.aspx.vb" Inherits="PbNIT.RM_ResourceUtilizationReport" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->

<HTML>
		<%CommonFunctions.General.PlotPageHeadTag("ResourceUtilization")%> 

	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()" >
		<form id="frmResourceUtilization" method="post" runat="server">
			<!--<br> -->
			<% BuildPage()%>
		</form>
		<script language="javascript">
		
			var objfrm = GetFormReference('frmResourceUtilization');
			var objdivlist=GetObjectReference('frmResourceUtilization','DivMain');			
			
			var isProjectReport = <%=m_intProjectReport%>;
			
			<%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
				
			 function Filter_change()
			 {
				objfrm.action="RM_ResourceUtilizationReport.aspx?FromWhere=<%=m_FromWhere%>&Mode=Change"+ "&PROJECTREPORT=" + isProjectReport 
				objfrm.submit();
				
			 }
			 
			  function GenerateReport()
			 {
				var objDateRange = GetObjectReference('objfrm','cboDateRange');
				var objBU = GetObjectReference('objfrm','cboBU');
				var objOU = GetObjectReference('objfrm','cboOU');
				var objProject = GetObjectReference('objfrm','cboProject');
				var objResource = GetObjectReference('objfrm','cboResource');
		
				if ( objResource != null )
				{	var ResourceCount = GetObjectReference('objfrm','cboResource').length;
					if (ResourceCount  == 1 )
					{	
						alert("At least one resource should be present") 
						return; 
					}
				}

				//Date	Range should Not be blank 
				if ( disallowBlank(objDateRange ,'<%=MyBase.GetResourceString("MSG_DATERANGE_EMPTY")%>',true) == true ) return; 
				
				if ( isProjectReport ==0)
				{
					var objDU = GetObjectReference('objfrm','cboDU');

					window.open("RM_ResourceUtilizationReport.aspx?FromWhere=<%=m_FromWhere%>&Mode=Generate&PROJECTREPORT=0&BUID=" + objBU.value + "&OUID=" + objOU.value + "&DUID=" + objDU.value + "&ResourceID=" + objResource.value + "&DateRangeID=" + objDateRange.value ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
				}
				else
				{
					var objProject = GetObjectReference('objfrm','cboProject');
					if ( disallowBlank(objProject ,'Please select project!',true) == true ) return; 
					window.open("RM_ResourceUtilizationReport.aspx?FromWhere=<%=m_FromWhere%>&Mode=Generate&PROJECTREPORT=1&BUID=" + objBU.value + "&OUID=" + objOU.value +  "&ProjectID=" + objProject.value  + "&ResourceID=" + objResource.value + "&DateRangeID=" + objDateRange.value ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
				}	
				
			 }

			 function DisplayDetails_OnClink(intBUID,intOUID,intDUID,intProjectID,intResourceID,intDateRangeID )
			 { 
				if ("<%=m_strMode%>" == "" || "<%=m_strMode%>"  == "Change")
				{				
					var objDateRange = GetObjectReference('objfrm','cboDateRange');
					var objResource = GetObjectReference('objfrm','cboResource');
				intResourceID = objResource.value;
				intDateRangeID = objDateRange.value;
				}

				var objResource = GetObjectReference('objfrm','cboResource');
				if ( objResource != null )
				{	var ResourceCount = GetObjectReference('objfrm','cboResource').length;
					if (ResourceCount  == 1 )
					{	
						alert("At least one resource should be present") 
						return; 
					}
				}
				
				if ( isProjectReport ==1 )
				{ 
					var objProject = GetObjectReference('objfrm','cboProject');
					if ( disallowBlank(objProject ,'Please select project!',true) == true ) return; 
	 
				}

				window.open("RM_ResourceUtilizationReport.aspx?FromWhere=<%=m_FromWhere%>&Mode=DisplayDetails&BUID=" + intBUID + "&OUID=" + intOUID + "&DUID=" + intDUID + "&ProjectID="+ intProjectID +"&ResourceID=" + intResourceID + "&DateRangeID=" + intDateRangeID + "&PROJECTREPORT=" + isProjectReport ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=950,height= 680");  
			 }

			  function DisplaySummaryDetails_OnClink(intBUID,intOUID,intDUID,intProjectID,intResourceID,intDateRangeID)
			 {
				if ("<%=m_strMode%>" == "" || "<%=m_strMode%>"  == "Change")
				{				
					var objDateRange = GetObjectReference('objfrm','cboDateRange');
					var objResource = GetObjectReference('objfrm','cboResource');
				intResourceID = objResource.value;
				intDateRangeID = objDateRange.value;
				}	
					
				var objResource = GetObjectReference('objfrm','cboResource');
				if ( objResource != null )
				{	var ResourceCount = GetObjectReference('objfrm','cboResource').length;
					if (ResourceCount  == 1 )
					{	
						alert("At least one resource should be present") 
						return; 
					}
				}				
				
				if ( isProjectReport == 1)
				{
					var objProject = GetObjectReference('objfrm','cboProject');
					if ( disallowBlank(objProject ,'Please select project!',true) == true ) return; 
	 
				}
								
				window.open("RM_ResourceUtilizationReport.aspx?FromWhere=<%=m_FromWhere%>&Mode=DisplaySummaryDetails&BUID=" + intBUID + "&OUID=" + intOUID + "&DUID=" + intDUID + "&ProjectID=" + intProjectID + "&ResourceID=" + intResourceID + "&DateRangeID=" + intDateRangeID + "&PROJECTREPORT=" + isProjectReport ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=950,height=680");  
			 }
			 
			 function Close_OnClink()
			 {
				window.close();
			 }
			 
			 function RelatedData_OnClink(intBUID,intOUID,intProjectID,intResourceID,intDateRangeID)
			 {
				window.open("RM_ResourceUtilizationReport.aspx?&FromWhere=<%=m_FromWhere%>&Mode=RelatedData&BUID=" + intBUID + "&OUID=" + intOUID + "&ProjectID=" + intProjectID + "&ResourceID=" + intResourceID + "&DateRangeID=" + intDateRangeID + "&PROJECTREPORT=" + isProjectReport ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=950,height=680");  
			 }
			 
			 function ViewDeployable(show)
			 {
				objfrm.action = "RM_ResourceUtilizationReport.aspx?Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ProjectID=<%=m_strProjectID%>&ResourceID=<%=m_strEmployeeID%>&DateRangeID=<%=m_strDateRangeID%>&PROJECTREPORT=<%=m_intProjectReport%>&FromWhere=<%=m_FromWhere%>&ShowDeployableOnly=" + show ;
				objfrm.submit();				 
			 }
			 
			 function ViewFilters()
			 {
				window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport.aspx?PROJECTREPORT=0&FromWhere=MR&MasterTagId=2221","ResourceUtilization","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 860)/2 + ",width=950,height=680");  
			 }
			 
			 //Addition done by SuchitraP on 10 Sep 2007
			 //To show print link
			 function Print_Onclick()
			 {
				//"RM_ResourceUtilizationReport.aspx?Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ProjectID=<%=m_strProjectID%>&ResourceID=<%=m_strEmployeeID%>&DateRangeID=<%=m_strDateRangeID%>&PROJECTREPORT=<%=m_intProjectReport%>&FromWhere=<%=m_FromWhere%>&ShowDeployableOnly=" + show ;
								
				var ReportType;
				var ReportMode;
				var intReportID;
				
				ReportType=<%=m_intProjectReport%>;
				ReportMode="<%=m_strMode%>";
				
				if(ReportType==1)
				{
				   if(ReportMode=="DisplayDetails")
				   	intReportID=2109
				   else
				     intReportID=2105
				
				}
				if(ReportType==0)
				{
				   if(ReportMode=="DisplayDetails")
				     	intReportID=2110
				   else
				     intReportID=2106
				
				}
			   window.open("../REPORTANDMETRICS/RM_ShowReport.aspx?Mode=<%=m_strMode%>&BUID=<%=m_strBUID%>&OUID=<%=m_strOUID%>&DUID=<%=m_strDUID%>&ProjectID=<%=m_strProjectID%>&ResourceID=<%=m_strEmployeeID%>&DateRangeID=<%=m_strDateRangeID%>&PROJECTREPORT=<%=m_intProjectReport%>&ShowDeployableOnly=<%=m_ShowDeployableOnly%>&ReportID="+intReportID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=550,height=300");
			 }
			 //End of addition by SuchitraP on 10 Sep 2007
			 
			function window_onload()
			{
			    //debugger;
			    var browser = WhichBrowser();
				    var intDivHeight ;
				var intDivHeightRisk;
				if (objdivlist !=null) {
				    //Commented by Yogesh J on 23-Nov-2015
				    //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				    
				    
				    //End of comment by Yogesh J on 23-Nov-2015
				    //Added and Commented By Vidya J on 26-11-2015
				    //if (intDivHeight < 100)	intDivHeight = 100;
				    //End Of Added and Commented By Vidya J on 26-11-2015
				    //if(browser == 'CR')
				    //{
				    //    $(".footerMenuTable").addClass('footerMenuTableChrome'); // Added By Vaijat K ON 25/11/2015
				    //}

				//if(browser == 'FF')
				//{
                //    //Commented by Yogesh J on 23-Nov-2015
				//    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 230;
				//    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
				//    intDivHeight = window.innerHeight - objdivlist.offsetTop - 39; // Added By Vaijat K ON 25/11/2015
				//    //End of comment by Yogesh J on 23-Nov-2015
				
				//}
				    //else
                    //Added and Commented By Vidya J on 26-11-2015
				//    intDivHeight = window.innerHeight - objdivlist.offsetTop - 39;
				    var Mode=getParameterByName("Mode");
				    intDivHeight = window.innerHeight - objdivlist.offsetTop;
				    
				    if (intDivHeight < 100)	intDivHeight = 100;
				    //End Of Added and Commented By Vidya J on 26-11-2015
				    
				    
				    else
				    if(browser=="IE")
				    {
				        if(Mode=="Generate"||Mode=="DisplaySummaryDetails"||Mode=="DisplayDetails"||Mode=="RelatedData")
				            {    
				           // objdivlist.style.height = intDivHeight-15+ "px";
				                objdivlist.style.height = intDivHeight-38+ "px"; //added by Shamkant S on 9 Dec 2015
				            }
                        else
				        objdivlist.style.height = intDivHeight-38+ "px";
				       
				    }
				   else if(browser=="CR")
				   {
				       
				        objdivlist.style.height = intDivHeight-38 + "px";
				   }
				   else if(browser=="FF") 
				   {
				       if(Mode=="Generate"||Mode=="DisplaySummaryDetails"||Mode=="DisplayDetails"||Mode=="RelatedData")
				       {    
				          // objdivlist.style.height = intDivHeight-13+ "px";
				           objdivlist.style.height = intDivHeight-40+ "px";//added by Shamkant s on 9 Dec 2015
				       }
				       else
				        objdivlist.style.height = intDivHeight-38 + "px";
				   }
                    else
				    objdivlist.style.height = intDivHeight + "px";	}	
				

				//Modified by VarunA on 1-Oct-2008 IssueID-22531
				//Purpose : To have proper alignment between rows in Mozilla.
				var toDel = GetObjectReference('frmResourceUtilization','toDel',true);
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
				//End by VarunA on 1-Oct-2008 IssueID-22531
			}
			
			function window_onresize()		
			{
			    var browser = WhichBrowser(); // Added By Vaijat K ON 25/11/2015
				var intDivHeight;
				var intDivHeightRisk;
				if (objdivlist !=null) {
				    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;  
				    //if(browser == 'FF')
				    //{
				    //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 39; // Added By Vaijat K ON 25/11/2015
				    //}
				    //else
				    //Added and Commented By Vidya J on 26-11-2015
				    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 29; COMMENTED BY NILESH
				    //End Of Added and Commented By Vidya J on 26-11-2015
				    //if(browser == 'CR')
				    //{
				    //    $(".footerMenuTable").addClass('footerMenuTableChrome'); // Added By Vaijat K ON 25/11/2015
				    //}
				//if (intDivHeight < 100)	intDivHeight = 100;  COMMENTED BY NILESH
				    //objdivlist.style.height = intDivHeight + "px";	COMMENTED BY NILESH
				    intDivHeight = window.innerHeight - objdivlist.offsetTop;
				    if (intDivHeight < 100)	intDivHeight = 100;
				    //End Of Added and Commented By Vidya J on 26-11-2015
				    if(browser=="IE")
				    {
				       // objdivlist.style.height = intDivHeight-15 + "px";
				        objdivlist.style.height = intDivHeight-38 + "px";//added  Shamkant s On 9 Dec 2015 
				        
				    }
				    if(browser=="CR")
				    {
				        objdivlist.style.height = intDivHeight-38 + "px";
				    }
				    else
				        //objdivlist.style.height = intDivHeight + "px";
				        objdivlist.style.height = intDivHeight -38+ "px";//added By Shamkant s on 9 Dec 2015
				    
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
		</script>
	</body>
</HTML>
