<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Home_OutlookView.aspx.vb" Inherits="PbNIT.Home_OutlookView" %>
<!DOCTYPE>
<HTML>
	<%PlotHead()%>

	<style>
		/* Added By Gauri On 29th Aug 2024 For Alignment Issue */
		table.clsTable .clsTRColumnHeader td{
			border: 1px solid #d3d3d3;
		}
		table.clsTable .clsTREven td{
			border: 1px solid #000;
		}
		/* End of Added By Gauri On 29th Aug 2024 For Alignment Issue */
	</style>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="GraphOutlook" method="post" runat="server">
			<%DrawPage()%>
		</form>
		
		<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
		<script language="javascript">
		
		var ObjForm=GetObjectReference('','GraphOutlook');
	
	    <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
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
			window.parent.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=<%=m_strDB_PageName%>&DashboardID=0"; 	
		}
	 
	}
	
			
	function NormalPMDashboard_clicked()
	{
		window.top.location.href = "../General/Navigation.aspx?FromWhere=DB"
	}
	
	function PreviousMonth_clicked(strModule)
	{try
	 {
	   if(<%=m_intMonth%>!=1)
		{	//window.location.href = "Home_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
		    ObjForm.action="Home_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1";
		}
		else{
			//window.location.href = "Home_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+"&MonthFlag=1"
			ObjForm.action="Home_OutlookView.aspx?MonthLoc=P&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+"&MonthFlag=1";
			}
			ObjForm.submit();
	 }
	 catch(ex){}
	}
	
	function NextMonth_clicked(strModule)
	{
	  //window.location.href = "Home_OutlookView.aspx?MonthLoc=N&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
	  ObjForm.action="Home_OutlookView.aspx?MonthLoc=N&MODULE=" + strModule + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+"&MonthFlag=1"
	ObjForm.submit();
	}
		
	function ThisMonth_clicked(strModule)
	{
	
	 //window.location.href = "Home_OutlookView.aspx?MonthLoc=C&MODULE=" + strModule + "&ThisMonth=1&MonthFlag=1"
	ObjForm.action="Home_OutlookView.aspx?MonthLoc=C&MODULE=" + strModule + "&ThisMonth=1&MonthFlag=1";
	ObjForm.submit();
	}
	
	//Added by PrashantSJ for Weekly View
	//Modified by PurvaJ on 11 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
  	function Week_clicked(strModule)
	{
	
	    //window.location.href = "Home_OutlookView.aspx?MonthLoc=<%=m_strMonthLoc%>&MODULE=" + strModule + "&WeekFlag=1&Where=THIS&WeekDate=" + "<%=dtWeekDate%>"	
	    ObjForm.action="Home_OutlookView.aspx?MonthLoc=<%=m_strMonthLoc%>&MODULE=" + strModule + "&WeekFlag=1&Where=THIS&WeekDate=" + "<%=dtWeekDate%>"	
	    ObjForm.submit();
	}
	//End Modification
	//'End of Addition by PrashantSJ on 17-Feb-2006 for Weekly View Calender
	
	//Added By PurvaJ on 10 May 2006 for WhizibleSEM 6.1 for issue 3636(PM DashBoard Enhanced View Enhancements)
	function PreviousWeek_clicked(strModule)
	{
   	  //window.location.href = "Home_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=PREV&WeekDate=" + "<%=dtWeekDate%>";
   	  ObjForm.action="Home_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=PREV&WeekDate=" + "<%=dtWeekDate%>";
	    ObjForm.submit();
	}
	function NextWeek_clicked(strModule)
	{
		//window.location.href = "Home_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=NEXT&WeekDate=" + "<%=dtWeekDate%>";
        ObjForm.action="Home_OutlookView.aspx?MODULE=" + strModule + "&WeekFlag=1&Where=NEXT&WeekDate=" + "<%=dtWeekDate%>";
	    ObjForm.submit();
	}

  
		function Assignments_clicked(intNumber)		
		{	
		  try
		  {     
				//var objSection = GetObjectReference('GraphOutlook','objTDCell');
				if(intNumber != <%=m_intListNumber%>)
				{  
					window.location.href = "Home_OutlookView.aspx?List=" + intNumber;
				}
		   }
		   catch(ex){}				
		}	

		function window_onload() 
		{ 
		
		try{	
			var objdivContainer = GetObjectReference('GraphOutlook','divContainer');
			
			var intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop + 230 ;
			if (intDivHeight < 100) 
				intDivHeight = 100;	// Let the minimum height of the div tag be 100
			objdivContainer.style.height = intDivHeight +'px';
			//Assignments_clicked(<%=m_intListNumber%>);
		}
		 catch(ex){}		 
		
		}
		
		function window_onresize()		
		{
		  try{	
			var intDivHeight; 
			var objdivContainer = GetObjectReference('GraphOutlook','divContainer');
			if(objdivContainer){
			intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop  + 230;
			if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100
			objdivContainer.style.height = intDivHeight +'px';
			}
		  }
		  catch(ex)	{}
		}	
		
		function OpenPage()
		{
		  //Help not available as yet
		  OpenHelpPage(100);
		}	
	<%'Added by NitinVS on 27 July 2007 for WhizibleSEM 7 %>
		function SetDefaultDashboard (dbID,dashboardID,Set)
		{
			window.location.href= "Home_OutlookView.aspx?DashboardID="+dashboardID+"&Mode=0&dbID="+ dbID +"&SETDEFAULT="+ Set;
		}
		<%'End Addition by NitinVS on 27 July 2007 for WhizibleSEM 7 %>
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

			//*******************************************************************************//
			//     Generate Request functions creates the XMLHTTP Request for the Server.    //
			//*******************************************************************************//
			function generateRequest(url) 
			{ 
				
		  		// Mozilla and Friends 
				if (window.XMLHttpRequest) 
				{ 
					req = new XMLHttpRequest(); 
				} else if (window.ActiveXObject) { 
					// Internet Explorer 
					req = new ActiveXObject("Microsoft.XMLHTTP"); 
				} 
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
                    if (Browser == 'IE')        // ADDED BY PUNEET M ON 23-12-2015
                        xmlDoc.loadXML(req.responseText);
                    else
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
			var brw = isIE();
			function Process() 
			{
		  		// wait until the request is done 
				if (req.readyState == 4) 
				{
			   		// Make sure request came back OK 
					if (req.status == 200) 
					{
				 
					    //if (window.ActiveXObject)
					    if (Browser == 'IE') // Added By Nilesh g ON 10/12/2015
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
                            xmlDoc.loadXML(req.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							if (Browser == 'FF') // Added By Nilesh g ON 10/12/2015
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
   		var strURL="Home_OutlookView.aspx?FromWhere=XMLHTTP&MODULE=" + Module + "&Date=" + Date + "&EmployeeID=" + intEmployeeID + "&StartEnd=" + strStartEnd +"&List=<%=m_strList %>"; 
   			
		window.open (strURL,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 325)/2 + ",width=700,height=350");//Amol
				
	 }
	 catch(ex){}
	}

	//*************************************************************************************************************//
	//*************************************************************************************************************//
 
	function DocumentLink_OnClick(intProjectID,intUniqueID,intTaskID,btApplyEffortDistribution,btHaveSubTaskTypes)
	{
	   if(btApplyEffortDistribution=='False' && btHaveSubTaskTypes=='False')
	    { 
	        window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intTaskID +"&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    } 
	    else 
	    {
	        window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    } 
	} 
	function DocumentLink_Review_OnClick(intProjectID,intUniqueID,strIssueIds)
	{
	    if(strIssueIds != '')	
        {
	        window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=2191&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    }
        else
        {
	        window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=1026&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    }	
	}

	function DocumentLink_Milestone_OnClick(intProjectID,intUniqueID)
	{
	    window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=34&DocumentType=","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	
	function DocumentLink_Issue_OnClick(intProjectID,intIssueID)
	{window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}

	function DocumentLink_Deliverable_OnClick(intScheduleID)
	{
	    window.open ("../DB/DocumentType.aspx?ScheduleID=" + intScheduleID + "&TagID=0&DocumentType=Deliverable","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");	
	}
 
	//--------------------------------------------------------------------------------------------------------------------
	//--------------------------------------------------------------------------------------------------------------------

function Close_OnClick(){window.close();} 
function Help_OnClick()
{
    window.open ('../General/Help.aspx?HelpID=Calendar','_help','resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250');
}


function Add_OnClick(List)
{
//Added By VijaYD On 29 August 2009
    if(List==11)
    {
            var IsProjectApproved = GetObjectReference('frmGanttChartView','hidIsProjectApproved'); 
            var IsProjectOnHold = GetObjectReference('frmGanttChartView','hidIsProjectOnHold'); 
            var IsProjectOver = GetObjectReference('frmGanttChartView','hidIsProjectOver');   
            if(IsProjectOnHold)
            if(IsProjectOnHold.value == "True")
            {
                alert('Project related activities such as adding Task entry cannot be performed as the Project is On-Hold');
                return ;
            }
            if(IsProjectOver)
            if(IsProjectOver.value == "True")
            {
                alert('Project related activities such as adding Task entry cannot be performed as the Project is Closed');
                return ;
            }  
    }        
            
//End AAddition By VijayD      On 29 August 2009       
    if(List==1)
        window.open ("../PM/PM_TaskAssignment.aspx?Mode=New&MasterTagID=1038&PageNumber=-1undefined","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");        
    if(List==2)
        window.open ("../IB/IB_IssueEntry.aspx?PageNumber=1&OrderBy=IssueID&ASCDESC=Desc","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=1000,height=600");      
    if(List==6)
        window.open ("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=34&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");      
    if(List==8)
        window.open ("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1026&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 650)/2 -50 + ",width=800,height=650");      
    if(List==9)
        window.open ("../General/CommonList.aspx?FromWhere=SM&MasterTagID=2246", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=600,height=450");
    if(List==10)
        //Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
        //window.open ("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=661&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");      
        window.open ("../PM/SubProject_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=661&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");      
        //End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
    if(List==11)
        //Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
        //window.open("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=800,height=600");
        window.open("../PM/Resources_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=800,height=600");
        //End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
    if(List==12)
         window.open("../General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=454&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");      
         
}
function Period_OnChange(obj)
{
    if(String(obj.value)=="4")
    {
        switch("<%=m_strList%>")
        {
            case "1" :
                window.location.href="../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";        
                break;
            case "6" :
                window.location.href="../General/CommonList.aspx?MasterTagID=34&FromWhere=PM";       
                break;
            case "9" :
                window.location.href="../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";       
                break;
            case "10" :
                window.location.href="../General/CommonList.aspx?MasterTagID=661&FromWhere=PM";    
                break;         
            case "11" :
                window.location.href="../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM";
                break;
            case "12" :
                window.location.href="../General/CommonList.aspx?MasterTagID=454&FromWhere=PM";
                break;                 
        } 
        
    }
   
    else
    {
        var strTagID='';
         switch("<%=m_strList%>")
        {
            case "1" :
                strTagID="1038";
                break;    
            case "6" :
                strTagID="34";
                break;
            case "9" :
                strTagID="2133";
                break;    
            case "10" :
                strTagID="661";
                break; 
            case "11" :
                strTagID="1019";
                break;            
            case "12" :
                strTagID="454";
                break;                
        }    
        
        if(strTagID!="2133")
            window.location.href="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+strTagID+"&GanttChartType="+obj.value;
        else
            window.location.href="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType="+obj.value;    
    
    } 
}

			
		</script>

	</body>
</HTML>
