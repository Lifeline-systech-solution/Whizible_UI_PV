<%@ Page Language='vb' AutoEventWireup='false' Codebehind='CustomerDashBoard.aspx.vb' Inherits='PbNIT.CustomerDashBoard' %>

<!DOCTYPE HTML>
<html>
<%  CommonFunctions.General.PlotPageHeadTag("Customer DashBoard")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css' />
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css' />
<link rel='stylesheet' type='text/css' href='../General/tab-view.css' />
<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()">
    <form id="frmBrickRedCustomerDB" method="post" runat="server">
        <% DrawPage()%>
    </form>
</body>

<script language="JavaScript">
    var objform=GetFormReference('frmBrickRedCustomerDB');
    var ObjCustomerId;
    var WhichGrid;
    ObjCustomerId=GetObjectReference('frmBrickRedCustomerDB','cboCustomer');
  
        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
  
    if (ObjCustomerId==null)
    {
        ObjCustomerId="<%=customerid%>"
    }
        
        function comboChanged()
    {      
    
        objform.action='../CustomerPortal/CustomerDashBoard.aspx?ProjectID=0&CustomerId='+ ObjCustomerId.value;
        objform.submit();
    }
    function Dashboards_OnClick(intDashboardID)
	{
        window.open ("../CDB/CDB_Dashboard_CommonList.aspx?MasterTagID=1871&ParentTagID=0&DashboardID=" + intDashboardID + "&FromLink=", "_Dashboards","resizable=no,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 622)/2) + ",width=800,height=622"); //WAF3_PB_42 April 17, 2007 NinadP
	}
	function Customer_OnClick()
    {
        window.open("../DB/CustomerSelection_customerPortal_CommonList.aspx?FromWhere=SM&MasterTagID=3964", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
    }
	function ShowSummary_ProjectSTab(TabName,intProjectID,intTabNo,FavPageNo)//BringData
	{    
	    objform.action="../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&FavPageNo="+FavPageNo+"&DashboardID=15001&TabName="+TabName+"&ProjectID="+intProjectID+"&intTabNo="+intTabNo+"&CustomerId="+ ObjCustomerId.value;
        objform.submit();
	}
	function ShowHide_SubTabs(idtoshow,idtoHide)//Deliverables_MileStones
	{
 	    document.getElementById(idtoHide).style.display = 'none';
		document.getElementById(idtoshow).style.display = 'block';
	
	    var objimgExpandTask = GetObjectReference('frmBrickRedCustomerDB','imgExpand_Task');  
        var objimgCollapsTask = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_Task'); 
        var objimgExpandIssue = GetObjectReference('frmBrickRedCustomerDB','imgExpand_Issue');  
        var objimgCollapsIssue = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_Issue'); 
        
        var objimgExpandDel = GetObjectReference('frmBrickRedCustomerDB','imgExpand_Deliverable');  
        var objimgCollapsDel = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_Deliverable'); 
        var objimgExpandMile = GetObjectReference('frmBrickRedCustomerDB','imgExpand_Milestone');  
        var objimgCollapsMile = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_Milestone'); 
        
        
        var objTaskFilters = GetObjectReference('frmBrickRedCustomerDB','tdTaskFilters'); 
        var objIssueFilters = GetObjectReference('frmBrickRedCustomerDB','tdIssueFilters');
        
        var objDelFilters = GetObjectReference('frmBrickRedCustomerDB','tdDelFilters'); 
        var objMileFilters = GetObjectReference('frmBrickRedCustomerDB','tdMileFilters');
        
         
        if(objimgExpandTask.style.display=='')
        {    
            objimgExpandIssue.style.display = '';
            objimgCollapsIssue.style.display = 'none';
            objimgCollapsTask.style.display = 'none';
            
            objTaskFilters.style.display = 'none';
            objIssueFilters.style.display = 'none';
        }         
        else if(objimgCollapsTask.style.display=='')
        {    
            objimgCollapsIssue.style.display = '';
            objimgExpandIssue.style.display = 'none';
            objimgExpandTask.style.display='none';
            objTaskFilters.style.display = '';
            objIssueFilters.style.display = '';
           
        }  
        /*else if(objimgExpandDel.style.display=='')
        {    
            objimgExpandMile.style.display = '';
            objimgCollapsIssue.style.display = 'none';
            objimgCollapsDel.style.display = 'none';
            
            objTaskFilters.style.display = 'none';
            objIssueFilters.style.display = 'none';
        }         
        else if(objimgCollapsDel.style.display=='')
        {    
            objimgCollapsIssue.style.display = '';
            objimgExpandMile.style.display = 'none';
            objimgExpandDel.style.display='none';
            objTaskFilters.style.display = '';
            objIssueFilters.style.display = '';
           
        }   */
        
	}
	function cboDashboard_OnChange()
	{
        var PageName;
        var arr = new Array();
        var _objcboDashboard;
        _objcboDashboard = GetObjectReference('frmCDBMain','cboDashboard');
        PageName = _objcboDashboard.value;
        if (trimString(_objcboDashboard.value) != "") 
        {
            arr = PageName.split("|");
            if (isSubstringExists(arr[0],'?'))
            {
                window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
            }
            else
            {
                window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
            }
        }
        else
        {
        window.location.href = "../CDB/CDB_DashboardDetail.aspx?FromWhere=BrickRed&MODE=NEW&FromPage=../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001"; 	
        }
	}
</script>

<script language="javascript">
	   //Added By VijayD oN 28 July 2008
	 	function OnClickDeliverables(TabName,intProjectID,strDeliverablesCriteria,strMilestoneCriteria,strEmployeeID)
		{
		   // window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&div_Deliverables=block&div_Milestones=none&TabName="+TabName+"&ProjectID="+intProjectID+"&SummaryDeliverables="+ strCriteria +"&SummaryMilestones="+strMilestoneCriteria+"&CustomerId="+ ObjCustomerId.value; 
			var strLoginType=<%="'"+m_LoginType+"'"%>
	        var objCurrentPageNumber = GetObjectReference('frmBrickRedCustomerDB','txtCurrentPage_Deliverable'); 
	         
            var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&CalledFrom=DeliverableTab&EmployeeID='"+strEmployeeID+"'&CustomerId="+ ObjCustomerId.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&LoginType="+strLoginType+"&Deliverables_SearchCriteria="+ strDeliverablesCriteria +"&PageNumber=" + objCurrentPageNumber.value; 
		    strResult="OnClickDeliverables";
            loadXMLDoc(strURL,"");
		} 
		
		function OnClickMilestones(TabName,intProjectID,strMilestoneCriteria,strDeliverablesCriteria,strEmployeeID)
		{
			var strLoginType=<%="'"+m_LoginType+"'"%>
	
            var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&CalledFrom=MilestoneTab&EmployeeID='"+strEmployeeID+"'&CustomerId="+ ObjCustomerId.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&LoginType="+strLoginType+"&Milestones_SearchCriteria="+strMilestoneCriteria; 
		    strResult="OnClickMilestones";
            loadXMLDoc(strURL,"");
           
		  //window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&div_Milestones=block&div_Deliverables=none&TabName="+TabName+"&ProjectID="+intProjectID+"&SummaryMilestones="+ strCriteria +"&SummaryDeliverables="+strDeliverablesCriteria+"&CustomerId="+ ObjCustomerId.value; //SummaryTaskStatus="+ objSummaryTaskStatus.value+"&
		} 
			
		
		function OnSummaryTaskStatusChange(TabName,intProjectID,strCriteria,strIssueNextLastToday)
		{
		
			var objSummaryTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryTaskStatus');	
			var objWeekDate = GetObjectReference('frmBrickRedCustomerDB','txthidWeekDateTask');			
			
			window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&SummaryTaskStatus="+ objSummaryTaskStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&WeekDateTask="+objWeekDate.value +"&SummaryTaskCriteria="+strCriteria+"&TaskNextLastToday="+strIssueNextLastToday+"&CustomerId="+ ObjCustomerId.value;
		} 
	
		function OnSummaryIssueStatusTypeChange(TabName,intProjectID,strCriteria,strIssueNextLastToday,EmployeeID)
		{
		    //debugger;
     		var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');
			var objWeekDate = GetObjectReference('frmBrickRedCustomerDB','txthidWeekDate');	
			
			var strLoginType=<%="'"+m_LoginType+"'"%>
			//		window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&SummaryIssueStatus="+ objSummaryIssueStatus.value+"&SummaryIssueType="+objSummaryIssueType.value+" &TabName="+TabName+"&ProjectID="+intProjectID+"&WeekDate="+objWeekDate.value +"&SummaryIssueCriteria="+strCriteria+"&IssueNextLastToday="+strIssueNextLastToday+"&CustomerId="+ ObjCustomerId.value;
            var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&CalledFrom=IssueTab&EmployeeID="+EmployeeID+"&CustomerId="+ ObjCustomerId.value+"&SummaryIssueStatus="+ objSummaryIssueStatus.value+"&SummaryIssueType="+objSummaryIssueType.value+" &TabName="+TabName+"&ProjectID="+intProjectID+"&WeekDate="+objWeekDate.value +"&LoginType="+strLoginType+"&SummaryIssueCriteria="+strCriteria+"&IssueNextLastToday="+strIssueNextLastToday; 
            strResult="OnSummaryIssueStatusTypeChange";
            loadXMLDoc(strURL,"");
		} 

		function OnProjectTaskStatusChange(TabName,intProjectID,objDivName,strEmployeeID)
		{
		
			var objdiv_ProjectTask,objdiv_ProjectIssues;
			var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');		
			var objProjectTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboProjectTaskStatus');	
			var strLoginType=<%="'"+m_LoginType+"'"%>
			var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&CalledFrom=TaskSTab&EmployeeID='"+strEmployeeID+"'&CustomerId="+ ObjCustomerId.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&&LoginType="+strLoginType+"&IssueNextLastToday=&&ProjectTaskStatus="+ objProjectTaskStatus.value+"&SummaryTaskStatus="; 
		    strResult="OnProjectTaskStatusChange";
		  
            loadXMLDoc(strURL,"");
//		   if(objDivName=='div_ProjectTask')
//			{
//				objdiv_ProjectTask='block';
//				objdiv_ProjectIssues='none';
//			}
//			else
//			{
//				objdiv_ProjectTask='none';
//				objdiv_ProjectIssues='block';
//			}
			//window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&ProjectTaskStatus="+ objProjectTaskStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&div_ProjectIssues="+objdiv_ProjectIssues+"&div_ProjectTask="+objdiv_ProjectTask+"&intTabNo=<%=m_strTabCount%>&CustomerId="+ ObjCustomerId.value;
		} 
		function OnProjectIsssueStatusChange(TabName,intProjectID,objDivName,strProjectIssueStatus,strEmployeeID)
		{
		   // debugger;
			var objdiv_ProjectTask,objdiv_ProjectIssues;
			var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');	
			var objProjectIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboProjectIssueStatus');	
			var strLoginType=<%="'"+m_LoginType+"'"%>
			
			//window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&ProjectIssueStatus="+ objProjectIssueStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&div_ProjectIssues="+objdiv_ProjectIssues+"&div_ProjectTask="+objdiv_ProjectTask+"&intTabNo=<%=m_strTabCount%>&CustomerId="+ ObjCustomerId.value;
            var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&CalledFrom=IssueTab&EmployeeID='"+strEmployeeID+"'&CustomerId="+ ObjCustomerId.value+"&SummaryIssueStatus=&SummaryIssueType=&TabName="+TabName+"&ProjectID="+intProjectID+"&&LoginType="+strLoginType+"&SummaryIssueCriteria=&IssueNextLastToday=&ProjectIssueStatus="+objProjectIssueStatus.value; 
		    strResult="OnProjectIsssueStatusChange";		   	     
            loadXMLDoc(strURL,"");
		} 
		
		function OnTimeSheetStatusChange(TabName,intProjectID,objDivName)
		{
			var objTimeSheetResult = GetObjectReference('frmBrickRedCustomerDB','cboTimeSheetResult');
			var objTimeSheetStatus = GetObjectReference('frmBrickRedCustomerDB','cboTimeSheetStatus');	
 			var objWeeklyStatus = GetObjectReference('frmBrickRedCustomerDB','cboWeeklyStatus');
 			window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&TimeSheet_Status="+objTimeSheetStatus.value+"&TimeSheet_Result="+objTimeSheetResult.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&WeeklyStatus="+objWeeklyStatus.value+"&intTabNo=<%=m_strTabCount%>&CustomerId="+ ObjCustomerId.value;
		}
		
		function OnDrawNotificationCount_Click()
		{
		  window.open("../CustomerPortal/CustomerDashBoard.aspx?Mode_Notification=True","", "resizable=no,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=600,height=300");
		}

		function OnSummaryTimesheetNo_Click(strTimeSheetNo,strTimesheetStatus)
		{
		 window.open("../CustomerPortal/CustomerDashBoard.aspx?Mode_TimeSheetDetail=True&TimeSheetNo="+strTimeSheetNo+"&TimesheetStatus="+strTimesheetStatus,"", "scrollbars=yes,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");//resizable=no,
		}

		function OnWSRTimesheetNo_Click(TimeSheetNo)
		{
		 window.open("../CustomerPortal/CustomerDashBoard.aspx?Mode_WSRTimeSheetDetail=True&TimeSheetNo="+TimeSheetNo,"", "scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=520");//resizable=no,
		 
		}				
	   function OnProjectTeamDetailChange(TabName,intProjectID)  
		{
			var objProjectTeamDetail = GetObjectReference('frmBrickRedCustomerDB','cboProjectTeamDetail');	
			window.location.href = "../CustomerPortal/CustomerDashBoard.aspx?DashboardID=15001&ProjectTeamDetail="+ objProjectTeamDetail.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&intTabNo=<%=m_strTabCount%>&CustomerId="+ ObjCustomerId.value;
		}
		
//TimeSheet Listing Accept and Reject TimeSheet		
		
		
		function AuthenticateDetailPage_OnClick(strTimeSheetNo)
		{
		  window.open("../CustomerPortal/CustomerDashBoard.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToApprove=ToApprove&MasterTagId=0&TimesheetNo_PK="+strTimeSheetNo+"&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 350)/2 + ",height=300,width=850");
		}
		
		function Reject_OnClick(strTimeSheetNo)
		{
		window.open("../CustomerPortal/CustomerDashBoard.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=0&TimesheetNo_PK="+strTimeSheetNo+"&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 350)/2 + ",height=300,width=850");
		}
		function View_Comment_OnClick(strTimeSheetNo)
		{
		window.open ("../General/CommonPage.aspx?ViewComment=ViewComment&TimesheetNo_PK="+strTimeSheetNo+"&TimesheetNo="+strTimeSheetNo+"&MasterTagID=3061&FromWhere=FA&FromCL=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,resizable=no,scrollbars=no,left=320,top=250,height=250,width=430");
		}

		function FinalReject_OnClick(strTimeSheetNo)
		{
			objComment = GetObjectReference('frmBrickRedCustomerDB','Comment'+strTimeSheetNo);
			if(objComment.value=="")
			{
			alert('Please add comment for rejection.');
			setFocus(objComment);
			return;
			}
			<%' Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
			if(disallowMaxlengthViolation(objComment,475,"The maximum length of the 'Comments' field is 475 characters",true))	return ;
			<%' End Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>

			objform.action="../CustomerPortal/CustomerDashBoard.aspx?Action=RejectTimesheet&TimesheetNo_PK="+strTimeSheetNo+"&Mode_ApproveReject=Reject&MasterTagId=15001";//&TimesheetList="+strTimeSheetList+"
			objform.submit();
		}
		
		function FinalAuthenticate_OnClick(strTimeSheetNo)
		{
			objComment = GetObjectReference('frmBrickRedCustomerDB','Comment'+strTimeSheetNo);
			if(objComment.value=="")
			{
			alert('Comment can\'t be left blank.');
			setFocus(objComment);
			return;
			}
			<%' Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
			if(disallowMaxlengthViolation(objComment,500,"The maximum length of the 'Comments' field is 500 characters",true))	return ;
			<%' End Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
		
			objform.action="../CustomerPortal/CustomerDashBoard.aspx?FinalApproved=FinalApproved&TimesheetNo_PK="+strTimeSheetNo+"&Mode_ApproveReject=Approve&MasterTagId=15001&Action=FinalAuthenticate";//&TimesheetList="+strTimeSheetList+"
			objform.submit();
		}


//TimeSheet Listing Accept and Reject TimeSheet		
	
 		function window_onload()		
		{  
			var objDiv_111 = GetObjectReference('frmBrickRedCustomerDB','tab_111');
			if (objDiv_111 !=null)
			{
                var intDivHeight = document.body.offsetHeight - objDiv_111.offsetTop - 30;
		            if (intDivHeight < 100) 
			        intDivHeight = 100;	// Let the minimum height of the div tag be 100
		            objDiv_111.style.height =intDivHeight ;
		    }
		}
		
		
		function ChangeStatus1(val){
		frmBrickRedCustomerDB.action = "CustometDashbsoard.aspx?CustomerID=<%=customerid%>&ComboVal="+val;
		frmBrickRedCustomerDB.submit();
		}
		
		function ShowDetails(customerid)
		{
		    window.open("CustomerDashboard.aspx?Mode=customerDetails&customerid="+customerid,"" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",height=300,width=700");
	    }
	
	    function Add_OnClick(customerid)
	    {
		    //window.open("../DB/DB_CustomerFieldLock.aspx?CustomerID=" + customerid,"" ,"scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		    window.open("../DB/DB_CustomerFieldLock.aspx?CustomerID=" + customerid,"" ,"resizable=no,scrollbars=yes,Left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=800");
		        		
	    }
    	
	    function Close_OnClick()
	    {
		    window.close();
	    }
	    
	    function Help_OnClick(HelpID) 
		{ 
			window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250"); 
		}

  //************************************************************************************//
    //  Added By VijayD   
  //************************************************************************************//
  	function ShowPreviousFAV(strLoginType,intCustomerID,intEmployeeID)
    {
		var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
	    var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
	    
	    if (isBlank(objtxtFAVPageNumber.value))
		   PageFAV_Onclick(1,strLoginType,intCustomerID,intEmployeeID);
	    else
	    {
    	    if (objtxtFAVPageNumber.value==1){alert("This is the first favorites");return;}
			    objtxtFAVPageNumber.value=objtxtFAVPageNumber.value -1;
		        PageFAV_Onclick(objtxtFAVPageNumber.value,strLoginType,intCustomerID,intEmployeeID);
	    }
		
    }
    
    function ShowNextFAV(strLoginType,intCustomerID,intEmployeeID)
    {
        //debugger;
		var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
		var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
		
	    if (isBlank(objtxtFAVPageNumber.value))
		    PageFAV_Onclick(1,strLoginType,intCustomerID,intEmployeeID);
	    else
	    {  
            if (objtxtFAVPageNumber.value==parseInt(noOfFAVs)){alert("This is the last favorites");return;}		 
		        objtxtFAVPageNumber.value=parseInt(objtxtFAVPageNumber.value) + 1;
    		    PageFAV_Onclick(objtxtFAVPageNumber.value,strLoginType,intCustomerID,intEmployeeID);
        }
   } 
   var strResult="";
  function PageFAV_Onclick(PageNumber,strLoginType,intCustomerID,intEmployeeID)
  {  
    var strURL = "../General/XMLHttp.aspx?Mode=CustomerPortal&LoginType="+strLoginType+"&CustomerID="+intCustomerID+"&EmployeeID="+intEmployeeID;

    strResult="PageFAV_Onclick";
    loadXMLDoc(strURL,"PageNumber=" + String(parseInt(PageNumber)));
   }
  
  var strResult=''; 
 function loadXMLDoc(url,reqQuery)
  {
    // code for Mozilla, etc.
    if (window.XMLHttpRequest)
    {
        xmlhttp=new XMLHttpRequest()
        xmlhttp.onreadystatechange=state_Change;
        if (ns)
        {
            xmlhttp.open("GET",url+"&"+reqQuery,true)
            xmlhttp.send(false)
        }
        else
        {
            xmlhttp.open("POST",url,true)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery)
        }
    }
    // code for IE
    else if (window.ActiveXObject)
    {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
        if (xmlhttp)
        {
            xmlhttp.onreadystatechange=state_Change;
            xmlhttp.open("POST",url,true)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send()
        }
    }
    
  }

  function state_Change()
  {
    // if xmlhttp shows "loaded"
    if (xmlhttp.readyState==4)
      {
      // if "OK"
       
        if (xmlhttp.status==200)
        {                  
            if(xmlhttp.responseText!="")
            { 
               if (strResult=="PageFAV_Onclick")
                { 
                    var objtdTabs=GetObjectReference('','tdTabs');
                       if(objtdTabs!=null)
                          objtdTabs.innerHTML=xmlhttp.responseText;
                }       
                else if ( strResult=="OnSummaryIssueStatusTypeChange")
                {
                    var objtdTabs=GetObjectReference('','div_ProjectIssues');
                    if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
                } 
                else if ( strResult=="OnProjectIsssueStatusChange")
                {
                    var objtdTabs=GetObjectReference('','div_ProjectIssues_List');
                    if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
                }   
                else if ( strResult=="OnClickMilestones")
                {
                    var objtdTabs=GetObjectReference('','div_MileStones');
                    if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
                }                    
                else if ( strResult=="OnClickDeliverables")
                {
                    var objtdTabs=GetObjectReference('','div_Deliverables');
                    if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
                }    
                else if ( strResult=="OnProjectTaskStatusChange")
                {  
                    var objtdTabs=GetObjectReference('','div_ProjectTask_l');
                    if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
                } 
                else if(strResult=="ShowTask")   
                {    
                    objTab = GetObjectReference('frmBrickRedCustomerDB','MainTable');   
                           
                                               
	                    if (objTab != null)
	                    {
		                     objTab.outerHTML = xmlhttp.responseText ;
		                    
                        }
                        
                }
                else
                {    
      
                    objTab = GetObjectReference('frmBrickRedCustomerDB','tbl'+WhichGrid+'Grid');                                         
                     var objtxtTaskMaximize = GetObjectReference('frmBrickRedCustomerDB','txtTaskMaximize');
                     
                    
	                    if (objTab != null)
	                    {
		                    objTab.outerHTML = xmlhttp.responseText ;	                    
		                   
		                    
		                     var objimgExpand = GetObjectReference('frmBrickRedCustomerDB','imgExpand_'+WhichGrid);  
                             var objimgCollaps = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_'+WhichGrid);   
                              
		                    if(objtxtTaskMaximize.value == 'true')
                             {  
                                objimgExpand.style.display = 'none';
                                objimgCollaps.style.display = '';
                             } 
                             else if(objtxtTaskMaximize.value == 'false')
                             {
                                objimgExpand.style.display = '';
                                objimgCollaps.style.display = 'none';
                             }
                             
                        }
                }
                
                                                            
          } 
        }
        else
        {
            alert("Problem in transfering data:" + xmlhttp.statusText)
        }
        strResult="";
    }
  }
  
   //************************************************************************************//
    //  Added By VijayD   
  //************************************************************************************//

function Previous_Onclick(SummaryORDetail,WhichPrevious)
{    
        var objCurrentPageNumber = GetObjectReference('frmBrickRedCustomerDB','txtCurrentPage_'+WhichPrevious);         
        var url
        objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) - 1 ;
        var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
        var CustomerID = GetObjectReference('frmBrickRedCustomerDB','hidcustomerid'); 
        var objtxtTaskMaximize = GetObjectReference('frmBrickRedCustomerDB','txtTaskMaximize'); 
        var Maximize=0;
        if(objtxtTaskMaximize.value == true);
            Maximize = 1;
           
        WhichGrid = WhichPrevious;
          
        if (parseInt(objCurrentPageNumber.value)>0)
        {
            
           url = "CustomerDashBoard.aspx?Maximize="+Maximize+"&Fromwhich="+WhichPrevious+"&IsXMLHTTP=1&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=" + objCurrentPageNumber.value;
       
            strResult=="TaskPaging"
            loadXMLDoc(url,'');
        }
        else
        { 
            alert('This is First Page.')
            objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) + 1 ;
            return;
        }
}
function Next_Onclick(SummaryORDetail,WhichNext)
{   
         
        
        var objCurrentPageNumber = GetObjectReference('frmBrickRedCustomerDB','txtCurrentPage_'+WhichNext);
        var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
        var CustomerID = GetObjectReference('frmBrickRedCustomerDB','hidcustomerid');         
       
        var objfrm=GetFormReference('frmBrickRedCustomerDB'); 
        var objTxt = GetObjectReference('frmBrickRedCustomerDB','txthid_Period');
        var objTxtNoofPages = GetObjectReference('frmBrickRedCustomerDB','txtNoOfPages_'+WhichNext);
        var objtxtTaskMaximize = GetObjectReference('frmBrickRedCustomerDB','txtTaskMaximize'); 
        var Maximize=0;
        if(objtxtTaskMaximize.value == true);
            Maximize = 1;
        
        objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) + 1 ;   
        
              
        if (objTxtNoofPages.value!=null)
        {
            if(parseInt(objTxtNoofPages.value) <= parseInt(objCurrentPageNumber.value) )
            {
                alert('This is Last Page.')
                objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) - 1 ;
                return;
            }
        }
        WhichGrid = WhichNext;
         url = "CustomerDashBoard.aspx?Maximize="+Maximize+"&Fromwhich="+WhichNext+"&IsXMLHTTP=1&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=" + objCurrentPageNumber.value;
          
         strResult=="TaskPaging"
         loadXMLDoc(url,'');
         
        
} 
function ExpandSection_Onclick(WhichExpand)
    {
            
          var url;
          var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
          var CustomerID = GetObjectReference('frmBrickRedCustomerDB','hidcustomerid');   
          var objfrm=GetFormReference('frmBrickRedCustomerDB'); 
          var objTxt = GetObjectReference('frmBrickRedCustomerDB','txthid_Period');
          var objTxtNoofPages = GetObjectReference('frmBrickRedCustomerDB','txtNoOfPages_'+WhichExpand);
          var objCurrentPageNumber = GetObjectReference('frmBrickRedCustomerDB','txtCurrentPage_'+WhichExpand);
             
          var objTdTaskIssue = GetObjectReference('frmBrickRedCustomerDB','tdTaskIssue');        
          var objtdDeliverableMilestone = GetObjectReference('frmBrickRedCustomerDB','tdDeliverableMilestone');         
          var objtdTimeseet = GetObjectReference('frmBrickRedCustomerDB','tdTimeseet');          
          var objtblWeeklyTimesheetGrid = GetObjectReference('frmBrickRedCustomerDB','tblWeeklyTimesheetGrid');          
          var objtdTeamDetails = GetObjectReference('frmBrickRedCustomerDB','tdTeamDetails');           
          var objtdGraphDetails = GetObjectReference('frmBrickRedCustomerDB','tdGraphDetails');          
          
          var objimgExpand = GetObjectReference('frmBrickRedCustomerDB','imgExpand_'+WhichExpand);  
          var objimgCollaps = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_'+WhichExpand);      
       
          var objtrProjectPage = GetObjectReference('frmBrickRedCustomerDB','trProjectPage'); 
          var objtrTimeSheet = GetObjectReference('frmBrickRedCustomerDB','trTimeSheet');
          var objtrTeam = GetObjectReference('frmBrickRedCustomerDB','trTeam');
          var objtrBlankAfterTask = GetObjectReference('frmBrickRedCustomerDB','trBlankAfterTask');
          var objtrBlankAfterTimesheet = GetObjectReference('frmBrickRedCustomerDB','trBlankAfterTimesheet');
          
          var objtxtTaskMaximize = GetObjectReference('frmBrickRedCustomerDB','txtTaskMaximize'); 
        
          var objTaskFilters = GetObjectReference('frmBrickRedCustomerDB','tdTaskFilters'); 
          var objIssueFilters = GetObjectReference('frmBrickRedCustomerDB','tdIssueFilters');
          
          var objDelFilters = GetObjectReference('frmBrickRedCustomerDB','tdDelFilters'); 
          var objMileFilters = GetObjectReference('frmBrickRedCustomerDB','tdMileFilters');
           
          var objTimeSheetFilters = GetObjectReference('frmBrickRedCustomerDB','tdtimesheetFilters'); 
          var objWeeklyFilters = GetObjectReference('frmBrickRedCustomerDB','tdWeeklyFilters'); 
          var objTeamFilters = GetObjectReference('frmBrickRedCustomerDB','tdTeamFilters'); 
          
          
          
          objtxtTaskMaximize.value = true;
        
          objTdTaskIssue.style.display = 'none';
          objtdDeliverableMilestone.style.display = 'none';
          objtdTimeseet.style.display = 'none';
          objtblWeeklyTimesheetGrid.style.display = 'none';
          objtdTeamDetails.style.display = 'none';
          objtdGraphDetails.style.display = 'none';
          
          objtrBlankAfterTask.style.display = 'none';
          objtrBlankAfterTimesheet.style.display = 'none';
          
        
           objimgExpand.style.display = 'none';
           objimgCollaps.style.display = ''; 
                       
        
          switch(WhichExpand)
          {
                case    "Task" :
                        objTdTaskIssue.style.display = '';
                        objTdTaskIssue.style.width='99.99%';
                         
                        objtrTimeSheet.style.display = 'none';
                        objtrTeam.style.display = 'none';
                        
                        objTaskFilters.style.display = '';                       
          
                        break;
                case   "Issue" :
                        objTdTaskIssue.style.display = '';
                        objTdTaskIssue.style.width='99.99%';
                          
                        objtrTimeSheet.style.display = 'none';
                        objtrTeam.style.display = 'none';
                        
                        objIssueFilters.style.display = ''; 
                                               
                        break;
                case    "Deliverable" :
                        objtdDeliverableMilestone.style.display = '';
                        objtdDeliverableMilestone.style.width='99.99%';
                        objDelFilters.style.display = ''; 
          objtrTimeSheet.style.display = 'none';
          objtrTeam.style.display = 'none';
         
                        break;
                case    "Milestone" :
                        objtdDeliverableMilestone.style.display = '';
                        objtdDeliverableMilestone.style.width='99.99%';
                        objMileFilters.style.display = ''; 
          objtrTimeSheet.style.display = 'none';
          objtrTeam.style.display = 'none';
                        break;
                case    "TimeSheet" :
                        objtdTimeseet.style.display = '';
                        objtdTimeseet.style.width='99.99%';
                        objtrProjectPage.style.display = 'none';
                        objTimeSheetFilters.style.display = '';         
          
          objtrTeam.style.display = 'none';
                        break;
                case   "WeeklyTimeSheet" :
                        objtblWeeklyTimesheetGrid.style.display = '';
                        objtblWeeklyTimesheetGrid.style.width='99.99%';
                        objtrProjectPage.style.display = 'none';
          
                        objWeeklyFilters.style.display = '';
          
          
          objtrTeam.style.display = 'none';
                        break;
                case    "TeamDetails" :
                        objtdTeamDetails.style.display = '';
                        objtdTeamDetails.style.width='99.99%';
                        objtrProjectPage.style.display = 'none';
                        objTeamFilters.style.display = '';
          objtrTimeSheet.style.display = 'none';
           
                        break;
                default : 
          }
          
          
             
             
          WhichGrid = WhichExpand;
          url = "CustomerDashBoard.aspx?Maximize=1&Fromwhich="+WhichExpand+"&IsXMLHTTP=1&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=" + objCurrentPageNumber.value;
          
         //strResult=="TaskPaging"
         
         strResult = "TaskPaging";
         
         loadXMLDoc(url,'');
         
              
        
    }
    function CollapsSection_Onclick(WhichCollaps)
    {
        var url;
          var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
          var CustomerID = GetObjectReference('frmBrickRedCustomerDB','hidcustomerid');   
          var objfrm=GetFormReference('frmBrickRedCustomerDB'); 
          var objTxt = GetObjectReference('frmBrickRedCustomerDB','txthid_Period');
          var objTxtNoofPages = GetObjectReference('frmBrickRedCustomerDB','txtNoOfPages_'+WhichCollaps);
          var objCurrentPageNumber = GetObjectReference('frmBrickRedCustomerDB','txtCurrentPage_'+WhichCollaps);
             
          var objTdTaskIssue = GetObjectReference('frmBrickRedCustomerDB','tdTaskIssue');          
          
          var objtdDeliverableMilestone = GetObjectReference('frmBrickRedCustomerDB','tdDeliverableMilestone');           
          
          var objtdTimeseet = GetObjectReference('frmBrickRedCustomerDB','tdTimeseet');          
          
          var objtblWeeklyTimesheetGrid = GetObjectReference('frmBrickRedCustomerDB','tblWeeklyTimesheetGrid');          
          
          var objtdTeamDetails = GetObjectReference('frmBrickRedCustomerDB','tdTeamDetails');           
          
          var objtdGraphDetails = GetObjectReference('frmBrickRedCustomerDB','tdGraphDetails');          
          
          var objimgExpand = GetObjectReference('frmBrickRedCustomerDB','imgExpand_'+WhichCollaps);  
          var objimgCollaps = GetObjectReference('frmBrickRedCustomerDB','imgCollaps_'+WhichCollaps);  
          var objtrProjectPage = GetObjectReference('frmBrickRedCustomerDB','trProjectPage'); 
          var objtrTimeSheet = GetObjectReference('frmBrickRedCustomerDB','trTimeSheet');
          var objtrTeam = GetObjectReference('frmBrickRedCustomerDB','trTeam');
          
          var objtrBlankAfterTask = GetObjectReference('frmBrickRedCustomerDB','trBlankAfterTask');
          var objtrBlankAfterTimesheet = GetObjectReference('frmBrickRedCustomerDB','trBlankAfterTimesheet');
          var objtxtTaskMaximize = GetObjectReference('frmBrickRedCustomerDB','txtTaskMaximize');
          
          var objTaskFilters = GetObjectReference('frmBrickRedCustomerDB','tdTaskFilters'); 
          var objIssueFilters = GetObjectReference('frmBrickRedCustomerDB','tdIssueFilters');
          var objDelMileFilters = GetObjectReference('frmBrickRedCustomerDB','tdDelMileFilters'); 
          var objTimeSheetFilters = GetObjectReference('frmBrickRedCustomerDB','tdtimesheetFilters'); 
          var objWeeklyFilters = GetObjectReference('frmBrickRedCustomerDB','tdWeeklyFilters'); 
          var objTeamFilters = GetObjectReference('frmBrickRedCustomerDB','tdTeamFilters'); 
          
          
          objTaskFilters.style.display = 'none';   
          objIssueFilters.style.display = 'none';   
          
          
          objtxtTaskMaximize.value = false;
           
          objTdTaskIssue.style.width='50%';
          objTdTaskIssue.style.display = '';          
          objtdDeliverableMilestone.style.display = '';
          objtdTimeseet.style.display = '';
          objtblWeeklyTimesheetGrid.style.display = '';
          objtdTeamDetails.style.display = '';
          objtdGraphDetails.style.display = '';
          objimgExpand.style.display = '';
          objimgCollaps.style.display = 'none';
          
          objtrProjectPage.style.display = '';
          objtrBlankAfterTask.style.display = '';
          objtrBlankAfterTimesheet.style.display = '';          
          objtrTimeSheet.style.display = '';
          objtrTeam.style.display = '';
          
          WhichGrid = WhichCollaps;
          url = "CustomerDashBoard.aspx?Maximize=0&Fromwhich="+WhichCollaps+"&IsXMLHTTP=1&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=" + objCurrentPageNumber.value;
          
         strResult=="TaskPaging"
         loadXMLDoc(url,'');
    }
   
    function ShowTasks(period,customerid)
    {
        strResult = "ShowTask";
        var url;
        var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
        var CustomerID = GetObjectReference('frmBrickRedCustomerDB','hidcustomerid');       
        WhichGrid = 'Task';
        /*if(period == 1)
        {
            url = "CustomerDashBoard.aspx?IsXMLHTTP=1&Fromwhich=TODAYSTASK&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=1";
        }
        else if(period == 2)
        {
            url = "CustomerDashBoard.aspx?IsXMLHTTP=1&Fromwhich=WEEKLYTASK&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=1";
        }
        else if(period == 3)
        {
            url = "CustomerDashBoard.aspx?IsXMLHTTP=1&Fromwhich=FORTTASK&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=1";
        }
        else if(period == 4)
        {
            url = "CustomerDashBoard.aspx?IsXMLHTTP=1&Fromwhich=MONTHLYTASK&CustomerId="+CustomerID.value+"&ProjectID="+ProjectID.value+"&PageNumber=1";
        }
        
        loadXMLDoc(url,''); 
        */
         var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
         objform.action='../CustomerPortal/CustomerDashBoard.aspx?period='+period+'&ProjectID='+ProjectID.value+'&CustomerId='+ CustomerID.value;
         objform.submit();   
    
    }
function ShowAllRecords(CustomerID)
{
    var ProjectID = GetObjectReference('frmBrickRedCustomerDB','hidm_ProjectID'); 
    objform.action='../CustomerPortal/CustomerDashBoard.aspx?period=0&ProjectID='+ProjectID.value+'&CustomerId='+ CustomerID;
    objform.submit();    
}    
</script>

</html>
