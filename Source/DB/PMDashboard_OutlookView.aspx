<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PMDashboard_OutlookView.aspx.vb" Inherits="PbNIT.PMDashboard_OutlookView" %>

<!DOCTYPE HTML>
<html>
<%PlotHead()%>
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 22/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 22/08/24 for JQuery and Bootstrap version upgrade -->
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

<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="GraphOutlook" method="post" runat="server">
        <%DrawPage()%>
    </form>
    <script language='javascript' src='../General/CommonValidations.js'></script>
    <script language="javascript">
	
        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
	
        function cboDashboard_OnChange()
            // For selecting the user's e-DB 
        {
            var strPageName;
            var arr;
            var objcboDashboard;
            objcboDashboard = GetObjectReference('GraphOutlook','cboDashboard');
		
            strPageName = objcboDashboard.value;
	
            if (trimString(strPageName + "") != "") 
            {
                arr = strPageName.split("|");
			
                if (isSubstringExists(arr[0],'?'))
                {
                    window.parent.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
                }
                else
                {
                    window.parent.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
                }
			
            }
            else
            {
                //Integrated by SuchitraP on 18-may-2009
                //Commented & Added By VarunA on 23-Mar-2009 IssueID-27992
                //Purpose : Page crash was there when we select 'Mgmt Dashboard (High Level', after that we select 'Add New Dashboard'
                //over there click on back link...page crash occurs. 
                //window.parent.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=<%=m_strDB_PageName%>&DashboardID=0";
		    var lnk = window.location.href ;
		    var arrlnk = lnk.split("?")
		    var arrDashboardID= arrlnk[1].split("&");
		    var arrIDs = arrDashboardID[0].split("=");
		    window.parent.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=<%=m_strDB_PageName%>%3FID=" + arrIDs[1]+"%26amp;DB=|0"; 	
		    //End By VarunA on 23-Mar-2009 IssueID-27992
		    //End of Integration by SuchitraP
        }
	 
    }
	
			
    function NormalPMDashboard_clicked()
    {
        window.top.location.href = "../General/Navigation.aspx?FromWhere=DB"
    }
    function PreviousMonth_clicked(strModule)
    {try
        {
        //Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender 
        //Purpose: Added one QueryString MonthFlag.
        if(<%=m_intMonth%>!=1)
	    {	//Commented adn Modified By JyotiG
	        //Start_JG_7526_09-Nov-2006
	        //window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
		    window.location.href = "PMDashboard_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
		    //End_JG_7526_09-Nov-2006
		}
		else{
		    //Commented adn Modified By JyotiG
		    //Start_JG_7526_09-Nov-2006
		    //window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+"&MonthFlag=1"
		    window.location.href = "PMDashboard_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+"&MonthFlag=1"
		    //End_JG_7526_09-Nov-2006
		}
	    //End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
    }
    catch(ex){}
}
	
function NextMonth_clicked(strModule)
{
    /*if(<%=m_intMonth%>!=12)
	    {*/
	        //Added by PrashantSJ on 17-Feb-2006 for Weekly View Calender 
	        //Purpose: Added one QueryString MonthFlag.
	        //Commented adn Modified By JyotiG
	        //Start_JG_7526_09-Nov-2006
	        //window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
	    window.location.href = "PMDashboard_OutlookView.aspx?MonthLoc=N&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
	    //End_JG_7526_09-Nov-2006
	    //}
	    //End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
	}
		
    function ThisMonth_clicked(strModule)
    {
        //Commented adn Modified By JyotiG
        //Start_JG_7526_09-Nov-2006
        //window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&ThisMonth=1&MonthFlag=1"
        window.location.href = "PMDashboard_OutlookView.aspx?MonthLoc=C&MODULE=" + strModule + "&ThisMonth=1&MonthFlag=1"
        //End_JG_7526_09-Nov-2006
    }
	
	    //Added by PrashantSJ for Weekly View
	    //Modified by PurvaJ on 11 May 2006 for PMLifeLine for issue 3636(PM DashBoard Enhanced View Enhancements)
    function Week_clicked(strModule)
    {
        /*if(<%=m_intMonth%>!=12)
  	    {*/
  	        //Commented adn Modified By JyotiG
  	        //Start_JG_7526_09-Nov-2006 
  	        //window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=THIS&WeekDate=" + "<%=dtWeekDate%>"	
	    window.location.href = "PMDashboard_OutlookView.aspx?MonthLoc=<%=m_strMonthLoc%>&MODULE=" + strModule + "&WeekFlag=1&Where=THIS&WeekDate=" + "<%=dtWeekDate%>"	
	    //End_JG_7526_09-Nov-2006	
	    //}
	}
  	    //End Modification
  	    //'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
	
  	    //Added By PurvaJ on 10 May 2006 for PMLifeLine for issue 3636(PM DashBoard Enhanced View Enhancements)
    function PreviousWeek_clicked(strModule)
    {
        /*if(<%=m_intMonth%>!=12)
	    {*/
	        window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=PREV&WeekDate=" + "<%=dtWeekDate%>";
	}
	function NextWeek_clicked(strModule)
	{
	    /*if(<%=m_intMonth%>!=12)
	    {*/
	        window.location.href = "PMDashboard_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=NEXT&WeekDate=" + "<%=dtWeekDate%>";
	}
	    //End Addition PurvaJ
  
	function Assignments_clicked(intNumber)		
	{	
	    try
	    {     
	        //var objSection = GetObjectReference('GraphOutlook','objTDCell');
	        if(intNumber != <%=m_intListNumber%>)
		      {  
                  window.location.href = "PMDashboard_OutlookView.aspx?List=" + intNumber;
		  }
      }
		   catch(ex){}				
  }	

    function window_onload() 
    { 
		
        try{	
            var objdivContainer = GetObjectReference('GraphOutlook','divContainer');
			
            var intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop + 120 ;
            if (intDivHeight < 100) 
                intDivHeight = 100;	// Let the minimum height of the div tag be 100
            objdivContainer.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
            Assignments_clicked(<%=m_intListNumber%>);
        }
        catch(ex){}		 
		
    }
		
    function window_onresize()		
    {
        try{	
            var intDivHeight; 
            var objdivContainer = GetObjectReference('GraphOutlook','divContainer');
            if(objdivContainer){
                intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100
                objdivContainer.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015
            }
        }
        catch(ex)	{}
    }	
		
    function OpenPage()
    {
        //Help not available as yet
        OpenHelpPage(100);
    }	
	<%'Added by NitinVS on 27 July 2007 for PMLifeLine %>
	    function SetDefaultDashboard (dbID,dashboardID,Set)
	    {
	        window.location.href= "PMDashboard_OutlookView.aspx?DashboardID="+dashboardID+"&Mode=0&dbID="+ dbID +"&SETDEFAULT="+ Set;
	    }
	    <%'End Addition by NitinVS on 27 July 2007 for PMLifeLine %>
    </script>
    <script>
        /*
		Added By	: SandeepA
		Purpose		: PopUp on mouse Click of Calender dates.
		Date		: 12 Dec,2005.
		*/	
        /**********************************************************************************************************/
        /************************* For Popup on Calender mouse Click ***********************************************/
        /**********************************************************************************************************/
			
        var Space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
        var strShowModule;
        var strShowDate;
        var strResult="";
        var strTasksScript="";
        var strIssuesScript="",strMileStonesScript="",strDeliverablesScript="";

        var brw = isIE();
        //*******************************************************************************//
        //     Generate Request functions creates the XMLHTTP Request for the Server.    //
        //*******************************************************************************//
        function generateRequest(url) 
        { 
				
            // Mozilla and Friends 
            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
            //if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
            //Commented and Added by SwapnilA on 08/11/2016 for bowser issue
            //if (brw == "IE")
            //{ 
            //    req = new XMLHttpRequest(); 
            //} else if (window.ActiveXObject) { 
            //    // Internet Explorer 
            //    req = new ActiveXObject("Microsoft.XMLHTTP"); 
            //} 
           
            req = new XMLHttpRequest(); 
            //Ended by SwapnilA
            //Added By Purvaj on 25 Sept 2008 for Firefox issues
            if(ns)
            {
                req.onreadystatechange = Process();
                req.open("GET", url,false); 
                req.send(null);
                if (req.responseText != null)
                {
                    xmlDoc= document.implementation.createDocument("","",null);
                    xmlDoc.async=false;
                    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
                    if (brw == "FF")
                        xmlDoc.load(req.responseXML);
                    Process(); 
                }
            }else
            {
                //End addition Purvaj
                req.onreadystatechange = Process;
                req.open("POST", url,false); 
                req.send();				
            }
				
            delete req;
            return true;
        } 
        //*******************************************************************************//
        //          Process function is called on STATE Change.                   //
        //*******************************************************************************//
        function Process() 
        {
            // wait until the request is done 
            if (req.readyState == 4) 
            {
                // Make sure request came back OK 
                if (req.status == 200) 
                {
				 
                    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
                    //if (window.ActiveXObject)
                    if (brw=="IE")
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async=false;
                        xmlDoc.loadXML(req.responseText);
												
                    }
                        // code for Mozilla, etc.
                    else if (document.implementation &&	document.implementation.createDocument)
                    {
                        xmlDoc= document.implementation.createDocument("","",null);
                        //added by Nilesh g on 10/12/2015 for issue id 2721
                        if (brw == "FF")
                            xmlDoc.load(req.responseXML);
                    }
										
                    //Save the Result in a Global variable
                    strResult=req.responseText;
				  
                }
            }
        }
		
        /** Function called on 'Click' or 'Mouse Over' of the Calender Dates **/
        function LoadDetails(Date,intEmployeeID,strDate,Module,strStartEnd)
        {
	 
            try
            { 
                //var strURL="PMDashboard_OutlookView.aspx?FromWhere=XMLHTTP&MODULE=" + Module + "&Date=" + Date + "&EmployeeID=" + intEmployeeID ; 
                //''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                //Modified By : JyotiG  Issue ID : 3636  Date : 08-Aug-2006
                //(New Parameter for ShowDetailsFun : strStartEnd)                
                //'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                var strURL="PMDashboard_OutlookView.aspx?FromWhere=XMLHTTP&MODULE=" + Module + "&Date=" + Date + "&EmployeeID=" + intEmployeeID + "&StartEnd=" + strStartEnd ; 
                //End
                strShowDate=strDate;
                strShowModule=Module;
                //Commented By VarunA on 7-Oct-2008 IssueID-23415
                //Purpose : Scripting doesn't come.
                //strResult ="";
                //strTasksScript ="";
                //strIssuesScript ="";
                //strReviewsScript ="";
                //strMileStonesScript ="";
                //strDeliverablesScript="";
                //End By VarunA on 7-Oct-2008 IssueID-23415
	
	
                if(Module=="TASKS")
                    strShowModule="Task";
                else 
                    if(Module=="ISSUES")
                        strShowModule="Issue";
                    else 
                        if(Module=="REWIEWS")
                            strShowModule="Review";
                        else
                            if(Module=="MILESTONES")
                                strShowModule="Milestone";
                            else
                                if(Module=="DELIVERABLES")
                                    strShowModule="Deliverable"
                                else
                                    //Added by PurvaJ on 11 May 2006 for PMLifeLine issue 3636 PM DashBoard Enhacements
                                    if(Module=="WEEK")
                                        strShowModule="Week"
                                    else
                                        strShowModule="Task"
                //End Addition
		     
                val=generateRequest(strURL);
		
                if (val==true)
                { 
                    //Request Success !!!
                    //Open a popup and populate it using window object (i.e. window.document.write())
                    var win=window.open ("about blank","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 325)/2 + ",width=700,height=350");
                    //Commented and Modified by SavitaS on 29 Aug 2006 for SP7 Integration for IssueId 5785
                    //strResult="<HTML><HEAD><TITLE>" + strShowModule +" : " + strShowDate +  "</TITLE><LINK rel='stylesheet' type='text/css' href='../General/StyleSheetChanakya.css'></LINK></HEAD><BODY class='clsBody' style='overflow:auto'><Form='frmDetails'><Table class='clsGridTable' width=100%><TR class='clsTRMenu'><TD align=right> | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A> | </TD></TR></TABLE><BR><Table width=100%><TR class='clsTRSectionHeader'><TD align='Left'>" + strShowModule +" details for " + strShowDate + "</TD></TR></Table><BR><Div style='overflow:auto;height:250'>" + strResult;
                    //strResult=strResult + "</Div><Table class='clsGridTable' width=100%><TR class='clsTRMenu'><TD align=right> | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A> | </TD></TR></TABLE></Form></BODY><Script>function Close_OnClick(){window.close();}"
                    //Added and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueID 5784 
                    <% GetStyleSheetName()%>			
		    strResult="<HTML><HEAD><TITLE>" + strShowModule +" : " + strShowDate +  "</TITLE><LINK rel='stylesheet' type='text/css' href='../General/<%=StyleSheetName %>'></LINK></HEAD><BODY class='clsBody' style='overflow:auto'><form name='frmDetails' id='frmDetails'><Table class='clsGridTable' width=100%><TR class='clsTRMenu'><TD align=right> | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A> | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='javascript:Help_OnClick()' Title='Help' >? </A>| </TD></TR></TABLE><BR><Table width=100%><TR class='clsTRSectionHeader'><TD align='Left'>" + strShowModule +" details for " + strShowDate + "</TD></TR></Table><BR><Div style='overflow:auto;height:250'>" + strResult;			
		    //End of Added and Modified by SavitaS on 30 Aug 2006 for SP7 Integration IssueID 5784 
		    strResult=strResult + "</Div><Table class='clsGridTable' width=100%><TR class='clsTRMenu'><TD align=right> | <A class='Menu' style='TEXT-DECORATION:NONE' HREF='Javascript:Close_OnClick()' Title='Close' >Close </A>| <A class='Menu' style='TEXT-DECORATION:NONE' HREF='javascript:Help_OnClick()' Title='Help' >? </A>| </TD></TR></TABLE></Form></BODY><Script>function Close_OnClick(){window.close();} function Help_OnClick(){window.open ('../General/Help.aspx?HelpID=Calendar','_help','resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250');}"		
		    //End of Commented and Modified by SavitaS on 29 Aug 2006 for SP7 Integration for IssueId 5785
		    //Commented and added by ShraddhaM on 18,Sep 2007.To plot all functions.
		    /*
			if(Module=="TASKS")
				strResult=strResult + strTasksScript + "<\/Script>";
			
			if (Module=="ISSUES")
				strResult=strResult + strIssuesScript + "<\/Script>";
			   
			if (Module=="REVIEWS")
				strResult=strResult + strReviewsScript + "<\/Script>";
			
			if(Module=="MILESTONES")
					strResult=strResult + strMileStonesScript + "<\/Script>";
			
			if(Module=="DELIVERABLES")
					strResult=strResult + strDeliverablesScript + "<\/Script>";
			//Added by PurvaJ on 11 May 2006 for PMLifeLine issue 3636 (PM Dashboard Enhanced view enhancements)
			if(Module=="WEEK")
					strResult=strResult + strDeliverablesScript + "<\/Script>";
			*/		           
			
		    if(Module=="TASKS" || Module=="ISSUES" || Module=="REVIEWS" || Module=="MILESTONES" || Module=="DELIVERABLES" || Module=="WEEK")
		        strResult=strResult + strTasksScript + strIssuesScript +  strReviewsScript + strMileStonesScript + strDeliverablesScript + "<\/Script>";
				
		    //End of comment and addition by ShraddhaM on 18,Sep 2007.To plot all functions.			
		    win.document.write(strResult);
			
		}
    }
    catch(ex){}
}

//*************************************************************************************************************//
//*************************************************************************************************************//
//Generate Scripts.
try{
	
    var strTasksScript = ""
	
    strTasksScript= strTasksScript + " function DocumentLink_OnClick(intProjectID,intUniqueID,intTaskID,btApplyEffortDistribution,btHaveSubTaskTypes)" 
    strTasksScript=strTasksScript+ "{if(btApplyEffortDistribution==\'False\' && btHaveSubTaskTypes==\'False\')"
    strTasksScript=strTasksScript + "{ window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&UniqueID=\" + intTaskID + \"&TagID=1038&DocumentType=Assign\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");" 
    strTasksScript=strTasksScript + "} else {"
    strTasksScript=strTasksScript + " window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&UniqueID=\" + intUniqueID + \"&TagID=1038&DocumentType=Assign\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");"
    strTasksScript=strTasksScript + "} } "

    strReviewsScript=""
    strReviewsScript=" function DocumentLink_Review_OnClick(intProjectID,intUniqueID,strIssueIds)"
    strReviewsScript=strReviewsScript + "{if(strIssueIds != \'\')	{"
    strReviewsScript=strReviewsScript + "window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&UniqueID=\" + intUniqueID + \"&TagID=2191&DocumentType=Review\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");"
    strReviewsScript=strReviewsScript + "}else{"
    strReviewsScript=strReviewsScript + "window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&UniqueID=\" + intUniqueID + \"&TagID=1026&DocumentType=Review\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");"
    strReviewsScript=strReviewsScript + "}	}"

    strMileStonesScript=""
    strMileStonesScript=strMileStonesScript + " function DocumentLink_Milestone_OnClick(intProjectID,intUniqueID)"
    strMileStonesScript=strMileStonesScript + "{window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&UniqueID=\" + intUniqueID + \"&TagID=34&DocumentType=\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");}"
	
    strIssuesScript=""
    strIssuesScript=strIssuesScript + " function DocumentLink_Issue_OnClick(intProjectID,intIssueID)"
    strIssuesScript=strIssuesScript + "{window.open (\"../DB/DocumentType.aspx?ProjectID=\" + intProjectID + \"&IssueID=\" + intIssueID + \"&TagID=0&DocumentType=Issue\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");"
    strIssuesScript=strIssuesScript + "}"

    strDeliverablesScript=""
	
    strDeliverablesScript=strDeliverablesScript + "	function DocumentLink_Deliverable_OnClick(intScheduleID)"
    strDeliverablesScript=strDeliverablesScript + "{window.open (\"../DB/DocumentType.aspx?ScheduleID=\" + intScheduleID + \"&TagID=0&DocumentType=Deliverable\",\"\",\"resizable=yes,scrollbars=yes,left=\" + (window.screen.width - 650)/2 + \",top=\" + (window.screen.height - 500)/2 + \",width=800,height=500\");	}"
}
catch(ex){}
//--------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------

			
    </script>
    <!-- Call for XMLHTTP Function -->
    <%XMLHTTP_GetTasks()%>
</body>
</html>
