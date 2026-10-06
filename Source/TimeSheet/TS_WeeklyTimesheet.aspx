<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TS_WeeklyTimesheet.aspx.vb" Inherits="PbNIT.TS_WeeklyTimesheet" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>

 <%--Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
  
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
   	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmWeeklyTimesheet" method="post" runat="server" >
				<%InitPage%>
			
		</form>
    <%-- commented by Nilesh G on 15/10/2015 for show data in all browser --%>
	<%--<%If m_strBrowserName = "IE" Or m_strBrowserName = "Microsoft Internet Explorer" Then %>--%>
     <%-- end of commented by Nilesh G on 15/10/2015 for show data in all browser --%>
		<table style="TABLE-LAYOUT:fixed;DISPLAY:none;HEIGHT:0px" id="tblHDF" cellSpacing=1 cellPadding=1 border=0 bgcolor='#ffffff' >
			<tr class='clsTRColumnHeader' >
				<TD ></TD> <TD ></TD>	<TD <TD> <TD ></TD><TD></TD> <TD></TD>	<TD></TD>
				<TD></TD> <TD></TD>	<TD></TD> <TD></TD>	<TD></TD> <TD></TD>	
			</tr>
			</table> 
	<style>
     /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
        table
        {
            width:100% !important;
        }
	</style>
           <Script>
		var strCurrentDate = '<%=m_strCurrentDate%>';
		var flagSubmit = true;
		var intBackDating = '<%=m_strBackdatingExpiry%>';
		var intFwdDating = '<%=m_strFwddatingExpiry%>';
		var strRestrict_MPPTasks = '<%=m_blnRestrict_MPPTasks%>';
		var strRestrict_AssignedTasks = '<%=m_blnRestrict_AssignedTasks%>';
		var strDetail='<%=m_strDetail%>';
		var strProjectsOnHold = '<%=m_strProjectsOnHold%>';
		var intMaxHoursPerDay = 24;
		//-----------------------------
		var arrMessages = new Array();
		arrMessages[0] = "";
		arrMessages[1] = "<%=MyBase.GetResourceString("MSG_ENTRYDATE")%>";
		arrMessages[2] = "<%=MyBase.GetResourceString("MSG_PROJECTSCHEDULE")%>";
		arrMessages[3] = "<%=MyBase.GetResourceString("MSG_EXCEED_ALLOCATED")%>";
		arrMessages[4] = "<%=MyBase.GetResourceString("MSG_BLANK_PERCENT")%>";
		arrMessages[5] = "<%=MyBase.GetResourceString("MSG_RANGE_0_100")%>";
		arrMessages[6] = "<%=MyBase.GetResourceString("MSG_RANGE_ACTUAL_HOURS")%>";
		arrMessages[7] = "<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>";
		arrMessages[8] = "<%=MyBase.GetResourceString("MSG_PROJECTSCHEDULE_2")%>";
		arrMessages[9] = "<%=MyBase.GetResourceString("MSG_MSN")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[10] = "<%=MyBase.GetResourceString("MSG_MFN")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[11] = "<%=MyBase.GetResourceString("MSG_SNET")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[12] = "<%=MyBase.GetResourceString("MSG_SNLT")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[13] = "<%=MyBase.GetResourceString("MSG_FNET")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[14] = "<%=MyBase.GetResourceString("MSG_FNLT")%>".replace("&#39;","'").replace("&#39;","'");
		arrMessages[15] = "<%=MyBase.GetResourceString("MSG_INVELID_CELLS")%>";
		arrMessages[16] = "<%=MyBase.GetResourceString("MSG_BLANK_HOURS")%>";
		arrMessages[17] = "<%=MyBase.GetResourceString("MSG_NUMERIC_VALUE")%>";
		arrMessages[18] = '<%=m_strProjectsOnHoldMsg%>';
		arrMessages[19] = "<%=MyBase.GetResourceString("MSG_DESC_LENGTH")%>";
		arrMessages[20] = "<%=MyBase.GetResourceString("MSG_MULTIPLE")%>";
		arrMessages[21] = "<%=MyBase.GetResourceString("MSG_ADJUST")%>";
		arrMessages[22] = "<%=MyBase.GetResourceString("MSG_CONTINUE")%>";
		arrMessages[23] = "<%=MyBase.GetResourceString("MSG_STOP")%>";
		arrMessages[24] = "<%=MyBase.GetResourceString("MSG_RT")%>";
		arrMessages[25] = "<%=MyBase.GetResourceString("MSG_CONFIRM_DELETE")%>";
		arrMessages[26] = "<%=MyBase.GetResourceString("MSG_CONFIRM_BEFORE_ACTION")%>";
		arrMessages[27] = "<%=MyBase.GetResourceString("MSG_NUMERIC_DURATION")%>";
		arrMessages[28] = "<%=MyBase.GetResourceString("MSG_HOURS_PER_DAY")%>";
		//-----------------------------
		objform=GetFormReference('frmWeeklyTimesheet');
		objDivMain=GetObjectReference('frmWeeklyTimesheet','divList');
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
        
      function window_onload()		
      {
          var browser = WhichBrowser();
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			if(objDivMain != null)
			{
			    if (browser == 'FF')
                    //Commented by Yogesh J on 27-NOV-2015
			        //  intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 185;
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 103 ;
			    else if (browser == 'IE')
			        //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 200;
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 99 ;
			    else if (browser == 'CR')
			        // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 199;
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 99 ;
                //End of Comment by Yogesh J on 27-NOV-2015
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight	+ 'px';
			}
			CallOnLoad();	
			//set div scroll height
			objDivHeight = GetObjectReference('frmWeeklyTimesheet','hdnDivHeight');//div scroll height
			objDiv3 = GetObjectReference('frmWeeklyTimesheet','divList');
			if (objDivHeight != null && objDiv3 != null)
			objDiv3.scrollTop = objDivHeight.value;	
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
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (browser == 'FF')
				    //Commented by Yogesh J on 27-NOV-2015
				    // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 185;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 103 ;
				else if (browser == 'IE')
				    //  intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 200;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 99 ;
				else if (browser == 'CR')
				    // intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 199;
				    intDivHeight = window.innerHeight - objDivMain.offsetTop - 99 ;
			    //End of Comment by Yogesh J on 27-NOV-2015
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px'	;
			}
			CallOnLoad();	
		}
		function SubmitForm(ObjF)
		{
			objDivHeight = GetObjectReference('frmWeeklyTimesheet','hdnDivHeight');//div scroll height
			objDiv3 = GetObjectReference('frmWeeklyTimesheet','divList');
			
			//Added By VidyaJ - issue ID - 11773
			var objMenuTop = GetObjectReference('frmWeeklyTimesheet', 'tblMenuTop');
			var objMenuBottom = GetObjectReference('frmWeeklyTimesheet', 'tblMenuBottom'); 
			<%'Commented and added by MahendraV On 6:20 PM 5/31/2007 for top menu consistency'%>
			<%'Start_MV_5/31/2007 '%>
			//objMenuTop.style.display = 'none';
			//objMenuBottom.style.display = 'none';
			objMenuTop.style.visibility = 'hidden';
			objMenuBottom.style.visibility = 'hidden';
			<%'End_MV_5/31/2007 '%>
					
			if (objDivHeight != null && objDiv3 != null)
			objDivHeight.value = objDiv3.scrollTop;
			if (ObjF != null) ObjF.submit();
		}
		function disallowBlank1(obj,msg,frm) 
		{
			if ( disallowBlank(obj,msg) == true )
			{
				if ((arguments.length>3)?arguments[3]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return true;	
			}
			flagSubmit = true;
			return false;
		}
		function disallowNonNumeric1(obj,msg,frm)
		{
			if ( disallowNonNumeric(obj,msg) == true )
			{
				if ((arguments.length>3)?arguments[3]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return true;	
			}
			flagSubmit = true;
			return false;
		}
		function disallowValueRangeViolation1(obj,minVal,maxVal,msg,frm) 
		{	if ( disallowValueRangeViolation(obj,minVal,maxVal,msg) == true )
			{	if((arguments.length>5)?arguments[5]:true)
				{
					window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
				}
				flagSubmit = false;
				return(true);	
			}
			flagSubmit = true;
			return(false);
		}
	
				
		<%If m_strShowDetails <> "1" Then%>
			//----------------------------------------
			var ElementClicked="";
			var StartingElement = "";
			var StartingCol=0;
			var StartingRow=0;
			var strBgcolor="#faebd7";
			var strBaseColor='<%=CellColor%>';
			var strRedColor = '<%=ERROR_COLOR%>';
			var strYellowColor = '<%=WARNING_COLOR%>';
			var strBorderColor = '<%=DISABLED_COLOR%>';
			var strImgSourceRed = '<%=ERROR_IMAGE%>';
			var strImgSourceYellow = '<%=WARNING_IMAGE%>';
			var strAnchorID="";
			var strAnchorCellID="";
			var xPos,yPos;
			var intSrNo = 0;
			//------------------Arrays-------------------------------------
			var arrEditedCells = new Array();//contains edited cells
			var arrInvalidCells = new Array();//contains objects of errorcell
			var arrProjectTasks = new Array();//contains objects of ProjectTasks
			var arrTxtBox = new Array();//contains taskids of edited text box
			var arrChkBox = new Array();//contains taskids of edited check box
			//-------------------------------------------------------------
			//-----Object for error cells---------------------------------------------
			//-----status and messages will be associate with this object-------------
			function CellErrors(Status,TaskID,CellIndex,strCellid)
			{
				this.Status = Status;//status-- warning or error
				this.TaskID = TaskID;
				this.CellIndex = CellIndex;
				this.id = strCellid;
				this.EMsg = new Array();//array for error messages
				this.WMsg = new Array();//array for warning messages
			}
			//-----End Object for error cells-----------------------------------------
			//------------------------------------------------------------------------
			//-----Object for Task Details---------------------------------------------
			function ProjectTasks(ProjectID,TaskID,MaxEntry,blnProjectBackdateEntry,blnProjectFwddateEntry,ConstraintType,ConstraintDate,WhichTask,EnforceConstraint,blnTimeBookedAgainstTask)
			{
				this.ProjectID = ProjectID;
				this.TaskID = TaskID;
				this.WhichTask = WhichTask;
				this.MaxEntry=MaxEntry;//maximum entry per day
				this.ProjectBackdateEntry = blnProjectBackdateEntry;
				this.ProjectFwddateEntry = blnProjectFwddateEntry;
				this.ConstraintType=ConstraintType;
				this.ConstraintDate=ConstraintDate;
				this.EnforceConstraint = EnforceConstraint;
				this.TimeBookedAgainstTask = blnTimeBookedAgainstTask;
				this.Response = 0;
			}
			//-----End Object for error cells-----------------------------------------
			//------------------------------------------------------------------------
			function CallOnLoad()
			{	
				var xl = tblList.offsetLeft;
				var yt = tblList.offsetTop;
				var tl = tblList;
				while (tl.tagName != "BODY") 
				{
					tl = tl.offsetParent;
					xl = xl + tl.offsetLeft;
					yt = yt + tl.offsetTop;
				}
				
				var headerTableRow = tblHDF.rows[0];
				var originalTableRow = tblList.rows[0];
				headerTableRow.height =originalTableRow.offsetHeight;
				for (var i = 0; i < headerTableRow.cells.length; i++) {
					headerTableRow.cells[i].width = originalTableRow.cells[i].offsetWidth;
					headerTableRow.cells[i].height = originalTableRow.cells[i].offsetHeight;
					headerTableRow.cells[i].innerHTML = originalTableRow.cells[i].innerHTML;
					headerTableRow.cells[i].align = 'center';
				}
				//divList.style.width = tblList.offsetWidth + 20 + 'px';
				tblHDF.style.left =xl; 
				tblHDF.style.top = yt ; //176
				tblHDF.style.position = 'absolute';
				//tblHDF.style.display="block";         // Commented By Puneet M ON 18-11-2015 IssueID: 2047
				setFooter();
			}
			function setFooter()
			{
				var FooterTableRow = tblTotal.rows[0];
				var originalTableRow = tblList.rows[0];
				FooterTableRow.cells[0].width = originalTableRow.cells[0].offsetWidth + originalTableRow.cells[1].offsetWidth + originalTableRow.cells[2].offsetWidth;
				FooterTableRow.cells[1].width = originalTableRow.cells[3].offsetWidth;
				FooterTableRow.cells[2].width = originalTableRow.cells[4].offsetWidth;
				FooterTableRow.cells[3].width = originalTableRow.cells[5].offsetWidth;
				FooterTableRow.cells[4].width = originalTableRow.cells[6].offsetWidth;
				FooterTableRow.cells[5].width = originalTableRow.cells[7].offsetWidth;
				FooterTableRow.cells[6].width = originalTableRow.cells[8].offsetWidth;
				FooterTableRow.cells[7].width = originalTableRow.cells[9].offsetWidth;
				FooterTableRow.cells[8].width = originalTableRow.cells[10].offsetWidth + originalTableRow.cells[11].offsetWidth;
				FooterTableRow.cells[9].width = originalTableRow.cells[12].offsetWidth;
				tblTotal.style.display="block";
			}
			//----------------
			function Save_OnClick()
			{ 

				if (arrEditedCells.length > 0 || arrTxtBox.length > 0 || arrChkBox.length > 0)
				{
					var ObjForm = GetFormReference('frmWeeklyTimesheet');
					if(checkInvalidCells() == false)
					return;
					BuiltValueString();
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583";
					}
					else
					{
					    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
					    //ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583";
					    ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&FromWhere=DT";
					    //End of Addition by Dhanashri S on 11 Aug 2016
					}
					/*Addition End by SantoshK on 20th March 2006*/
					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583";
					
				    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
				    var MenuTags = document.getElementsByTagName('A');
				    for (i = 0; i < MenuTags.length; i++) {
				        if (MenuTags[i].className == "Menu") {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.style.display = "none";
				        }
				    }
				      setFrameLoader();  
				    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
				    SubmitForm(ObjForm);
				}
			}
			function BeforeSubmit()
			{//0 - stop, 1 - save and action , 2- action only
				if(arrEditedCells.length > 0)
				{
					if(confirm(arrMessages[26]))
					{
						if(checkInvalidCells() == false)
						return 0;
						BuiltValueString();
						return 1;
					}
				}
				return 2
			}
			function checkInvalidCells()
			{
				var StrTN,intIndex=0;
				var strTasks=new String();
				var blnStop = false;
				if(arrInvalidCells.length > 0)
				{
					for(var i=0;i<arrInvalidCells.length;i++)
					{	if(arrInvalidCells[i].Status == "ERROR")
						{
							blnStop = true;
						}
						 
						StrTN = getTaskName(arrInvalidCells[i].id);
						//if (strTasks.indexOf(StrTN) == -1)
						//{getEntryDate(strCellID)
						//'shraddha
						 
							strTasks += ++intIndex + ": " + StrTN + " : " + getDate3(getEntryDate(arrInvalidCells[i].id)) +'\n';
						//}
					}
					if(blnStop == true)
					{ 
					 
						alert(arrMessages[15] + strTasks + '\n' + arrMessages[23]);
						return false;
					}
					else
					{
					 
						if (window.confirm(arrMessages[15] + strTasks + '\n' + arrMessages[22]))
						return true;
						return false;
					}
				}
				return true;
			}
			function optTasks_OnClick()
			{
				var ObjForm = GetFormReference('frmWeeklyTimesheet');
				var intResult = BeforeSubmit();
				if(intResult == 1) 
				{

					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583";
					}
					else
					{
					    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
					    //ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583";
					    ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&Fromwhere=DT";
					    //End of Addition by Dhanashri S on 11 Aug 2016
					}
					/*Addition End by SantoshK on 20th March 2006*/

					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583";
				}
				else 
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&MasterTagID=3583";
					}
					else
					{
					    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
					    //ObjForm.action = "TS_WeeklyTimesheet.aspx?MasterTagID=3583";
					    ObjForm.action = "TS_WeeklyTimesheet.aspx?MasterTagID=3583&Fromwhere=DT";
					    //End of Addition by Dhanashri S on 11 Aug 2016
					}
					/*Addition End by SantoshK on 20th March 2006*/

					//ObjForm.action = "TS_WeeklyTimesheet.aspx?MasterTagID=3583";
				}
			    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
			    setFrameLoader();  
			    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
				SubmitForm(ObjForm);	
			}
			function NextWeek_OnClick()
			{
				var ObjForm = GetFormReference('frmWeeklyTimesheet');
				var intResult = BeforeSubmit();
				if(intResult == 1) 
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&Where=<%=SAVE_MOVE_NEXT%>&MasterTagID=3583";
					}
					else
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&Where=<%=SAVE_MOVE_NEXT%>&MasterTagID=3583";
					}
					/*Addition End by SantoshK on 20th March 2006*/

					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&Where=<%=SAVE_MOVE_NEXT%>&MasterTagID=3583";
				}
				else 
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Where=<%=MOVE_NEXT%>&MasterTagID=3583";
					}
					else
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Where=<%=MOVE_NEXT%>&MasterTagID=3583";
					}
					/*Addition End by SantoshK on 20th March 2006*/
				
					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Where=<%=MOVE_NEXT%>&MasterTagID=3583";
				}
			    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
			    setFrameLoader();  
			    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
				SubmitForm(ObjForm);	
			}
			function PreviousWeek_OnClick()
			{
				var ObjForm = GetFormReference('frmWeeklyTimesheet');
				var intResult = BeforeSubmit();
				if(intResult == 1) 
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&Where=<%=SAVE_MOVE_PREVIOUS%>&MasterTagID=3583";
					}
					else
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&Where=<%=SAVE_MOVE_PREVIOUS%>&MasterTagID=3583";
					}
					/*Addition End by SantoshK on 20th March 2006*/
				
					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&Where=<%=SAVE_MOVE_PREVIOUS%>&MasterTagID=3583";
				}
				else 
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Where=<%=MOVE_PREVIOUS%>&MasterTagID=3583";
					}
					else
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Where=<%=MOVE_PREVIOUS%>&MasterTagID=3583";
					}
					/*Addition End by SantoshK on 20th March 2006*/
				
					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Where=<%=MOVE_PREVIOUS%>&MasterTagID=3583";
				}
			    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
			    setFrameLoader();  
			    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
				SubmitForm(ObjForm);	
			}
               function TaskLink_OnClick(TaskID,ProjectID)
               {
			     
                   var ObjForm = GetFormReference('frmWeeklyTimesheet');
                   /*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/

                   if ("<%=m_strFromWhere%>" == "Proxy")
				{
				    //Commented and added by Nilesh g on 22/1/2016 for increase width of window
				    //Added By Vidya J ON 28-01-2016 For PkToken Validation 
				    //window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
                       $.ajax({
                           type: 'POST',
                           dataType: 'json',
                           contentType: 'application/json',
                           url: 'TS_WeeklyTimesheet.aspx/GenrateURLToken_TaskLink_OnClick',
                           //data: JSON.stringify({ TaskDAID: TaskID, ProjectID: ProjectID}),
                           data: JSON.stringify({ TaskDAID: TaskID,EmployeeID: "<%=Session("intUserID")%>", ProjectID: ProjectID, ShowClose: 1}),
				        success: function (Result) {
		                    //Commented and added by Yogesh Jalamkar on 07-NOV-2016 Purpose: Page Crash
				           // window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID + "&PkToken=" +Result.d +"&EmployeeID=<%=Session("intUserID")%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=740,height=420");
				            window.open("../PM/PM_DailyActivity.aspx?&From=Proxy&EmployeeID=<%=m_strSessionUserID%>&FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID + "&PkToken=" +Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=740,height=420");
				            //End of addition by Yogesh Jalamkar on 07-NOV-2016 Purpose: Page Crash
				        },
				        error: function () {
				            //alert("Error")
				        }
				     });
                      
				    //End Of Addition By Vidya J ON 28-01-2016 For PkToken Validation 
				}
				else
				{  //Added By Vidya J ON 28-01-2016 For PkToken Validation 
				    //Commented and added by Nilesh g on 22/1/2016 for increase width of window
				    //window.open("../PM/PM_DailyActivity.aspx?FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
                       $.ajax({
                           type: 'POST',
                           dataType: 'json',
                           contentType: 'application/json',
                           url: 'TS_WeeklyTimesheet.aspx/GenrateURLToken_TaskLink_OnClick',
                           data: JSON.stringify({ TaskDAID: TaskID,EmployeeID: "<%=Session("intUserID")%>", ProjectID: ProjectID, ShowClose: 1}),
                           success: function (Result) {
		                    
                               window.open("../PM/PM_DailyActivity.aspx?FromWhere=WTimeSheet&WhatToShow=Entry&ShowClose=1&ProjectID=" + ProjectID + "&TaskID=" + TaskID + "&PkToken=" +Result.d +"&EmployeeID=<%=Session("intUserID")%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=740,height=420");

				        },
				        error: function () {
				            //alert("Error")
				        }
				    });
                     
				    //End Of Addition By Vidya J ON 28-01-2016 For PkToken Validation 
				}
		    /*Addition End by SantoshK on 20th March 2006*/
            }
				
			//Modified By VidyaJ - SP8 Performance 
               function ShowDetails_OnClick(TaskID,Detail,Day)
               {
			    
                   var strQueryString;


                   /*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
                   if ("<%=m_strFromWhere%>" == "Proxy")
			    {
			        strQueryString = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&ShowDetails=1&MasterTagID=3583";
				}
				else
				{
				    strQueryString = "TS_WeeklyTimesheet.aspx?ShowDetails=1&MasterTagID=3583";
				}
			    /*Addition End by SantoshK on 20th March 2006*/
				
			    //strQueryString = "TS_WeeklyTimesheet.aspx?ShowDetails=1&MasterTagID=3583";
                strQueryString = strQueryString + "&TaskDAID=" + TaskID;
                strQueryString = strQueryString + "&Detail=" + Detail;//m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")
                strQueryString = strQueryString + "&hdnStartDate=" + '<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>';
			    // strQueryString = strQueryString + "&Token_ShowDetails=" + Token_ShowDetails;
				if(Day != null && Day != '')
				{
				    strQueryString = strQueryString + "&Day=" + Day;
				}
			    //Added By Vidya J ON 28-01-2016 For PkToken Validation 
				if(Day != null && Day != '')
				{
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'TS_WeeklyTimesheet.aspx/GenrateURLToken_ShowDetails_OnClick',
				        //data: JSON.stringify({ TaskDAID: TaskID, Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>',Day:Day,ShowDetails:"1",MasterTagID:"3583"}),
				        data: JSON.stringify({ TaskDAID: TaskID, EmployeeID: "<%=Session("intUserID")%>", MasterTagID:"3583", Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>',Day:Day,ShowDetails:"1"}),
				        success: function (Result) {
		                    
			            
				            //strQueryString = strQueryString + "&Token_ShowDetails=" + Result.d +"&EmployeeID=<%=m_strSessionUserID%>";
				            strQueryString = strQueryString + "&PkToken=" + Result.d +"&EmployeeID=<%=m_strSessionUserID%>";
				            window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");

				        },
				        error: function () {
				            //alert("Error")
				        }
				    });
				}
				else
				{
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'TS_WeeklyTimesheet.aspx/GenrateURLToken_ShowDetail_OnClick',
				        data: JSON.stringify({ TaskDAID: TaskID, EmployeeID: "<%=Session("intUserID")%>", Detail: Detail , hdnStartDate:'<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>'}),
				        success: function (Result) {
		                    
			            
				            //strQueryString = strQueryString + "&Token_ShowDetails=" + Result.d + "&EmployeeID=<%=m_strSessionUserID%>";
				            strQueryString = strQueryString + "&PkToken=" + Result.d + "&EmployeeID=<%=m_strSessionUserID%>";
				            window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");

				        },
				        error: function () {
				           // alert("Error")
				        }
				});
				}
			    //window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");
			    //End Of Addition By Vidya J ON 28-01-2016 For PkToken Validation 
            }


			function ShowWorkDone(dblHours)
			{
				alert(dblHours + " hours have been uploaded from the MPP !!");
			}
			function SendApproval_OnClick()
			{
				var ObjForm = GetFormReference('frmWeeklyTimesheet');
				
				if(checkInvalidCells() == false)
				return;
				
				BuiltValueString();
				var intExpectedHrs = '<%=m_dblExpectedHrs%>';
				var intActualHrs = '<%=m_dblActualHrs%>';
				var intCurrentFilled=0;
				var ObjForm = GetFormReference('frmWeeklyTimesheet');
				var strTimesheetID = '<%=m_strTimeSheetID%>';
				for(var i=0;i<arrEditedCells.length ;i++)
				{
					
					//if(document.getElementById(arrEditedCells[i]) != null && document.getElementById(arrEditedCells[i]).innerHTML != "")
					//Modified By VidyaJ - 11834
					//intCurrentFilled += (document.getElementById(arrEditedCells[i]).innerHTML - 0);
					
					//Modified by  NitinVS on 9 Aug 2007 for PMLifeLine
					if(document.getElementById(arrEditedCells[i])!=null && document.getElementById(arrEditedCells[i]).value!="")
					{
						intCurrentFilled += parseFloat((document.getElementById(arrEditedCells[i]).value));
					}	
					//End Modification by  NitinVS on 9 Aug 2007 for PMLifeLine 
					
				}

				//Modified By VidyaJ - IssueID - 11778
				if(<%=m_dblActualHrs%>+intCurrentFilled==0)
				{
					alert('Timesheet cannot be sent for approval as Total Daily activity filled for timesheet period is Zero');
					return;
				} 
				
				//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4192
				//Modified by SandipL for WhizEnggSP6 on 15 May 2006 -IssueID 3720
			    //if ((intActualHrs + intCurrentFilled) < intExpectedHrs)
			  
				if ((parseFloat(intActualHrs) + parseFloat(intCurrentFilled)) < parseFloat(intExpectedHrs))
				//End mOdification by SandipL on 15 May 2006
				//End Integration
				{ var dblActualTill = parseFloat(intActualHrs) + parseFloat(intCurrentFilled);
					if (window.confirm(arrMessages[24].replace('<=>',dblActualTill).replace('<==>',intExpectedHrs)))
					{
						/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
						if ("<%=m_strFromWhere%>" == "Proxy")
						{
							ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
						}
						else
						{
							ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
						}
						/*Addition End by SantoshK on 20th March 2006*/
						//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
					    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
					    var MenuTags = document.getElementsByTagName('A');
					    for (i = 0; i < MenuTags.length; i++) {
					        if (MenuTags[i].className == "Menu") {
					            //MenuTags[i].style.display= "none";
					            MenuTags[i].parentNode.style.display = "none";
					        }
					    }
					    setFrameLoader();  
					    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
						SubmitForm(ObjForm);	
					}
					else
					{
						return;
					}
				}
				else
				{
					/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
					if ("<%=m_strFromWhere%>" == "Proxy")
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
					}
					else
					{
						ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
					}
					/*Addition End by SantoshK on 20th March 2006*/
				    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
				    var MenuTags = document.getElementsByTagName('A');
				    for (i = 0; i < MenuTags.length; i++) {
				        if (MenuTags[i].className == "Menu") {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.style.display = "none";
				        }
				    }
				    setFrameLoader();  
				    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
					//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&TSAction=S&TimeSheetID=" + strTimesheetID;
					SubmitForm(ObjForm);	
				}
			}
			function ViewTimesheet_OnClick()
			{
				var strQS = "../RT/RT_ResourceTimesheet.aspx?FromWhere=WTimeSheet&FromDate=" + '<%=m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")%>' + "&ToDate=" + '<%=m_dtEndDateOfWeek.ToString("dd-MMM-yyyy")%>' + "&Action=View";
				window.open(strQS,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
			}
			function ShowHistory_OnClick(intTimesheetID)
			{
				/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
				if ("<%=m_strFromWhere%>" == "Proxy")
				{
					window.open("../General/CommonList.aspx?FromWhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&MasterTagId=2248&ResourceTimesheetID=" + intTimesheetID,null,"Left=150,Top=150,height=450,width=860,status=no,toolbar=no,menubar=no,location=no")				
				}
				else
				{
					window.open("../General/CommonList.aspx?FromWhere=PM&EmployeeID=<%=m_strSessionUserID%>&MasterTagId=2248&ResourceTimesheetID=" + intTimesheetID,null,"Left=150,Top=150,height=450,width=860,status=no,toolbar=no,menubar=no,location=no")
				}
				/*Addition End by SantoshK on 20th March 2006*/
			}
			/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
			function Back_OnClick()
			{
				var intResult = BeforeSubmit();
				if(intResult == 1) 
				{
				    var ObjForm = GetFormReference('frmWeeklyTimesheet');
				    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
				    setFrameLoader();  
				    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
					ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&RedirectToDA=1";
					SubmitForm(ObjForm);	
				}
				else 
				window.location.href = "../PT/PT_OnSiteResources.aspx?FromWhere=DT&MasterTagId=3609";
			}
			/*Addition End by SantoshK on 20th March 2006*/
			
			function ShowHideRows(strProjectID,intRW)
			{
				var objhdnColumn = document.getElementById('img' + strProjectID);
				var objTableSec = document.getElementById('tblList');
				var ObjhdnSection = GetObjectReference('frmWeeklyTimesheet','hdnSection_' + strProjectID);
				var i=(intRW + 1);
				while(objTableSec.rows[i].id.substring(0,3) != 'TRP')
				{
					if (objTableSec.rows[i].style.display == "none") 
					{ 
						objTableSec.rows[i].style.display="";
						objhdnColumn.src='../../Images/minus.gif';
						objhdnColumn.title='Hide';
						if (ObjhdnSection != null)ObjhdnSection.value = "1";
					}
					else 
					{ 
						objTableSec.rows[i].style.display="none";
						objhdnColumn.src='../../Images/plus.gif';
						objhdnColumn.title='Show';
						if (ObjhdnSection != null)ObjhdnSection.value = "0";
					}
					i++;
				}
				CallOnLoad();
				//------------
			}
			function InsertIntoArray(arr,strData)
			{
				//alert('strData='+strData);
				var strArrValues = arr.join();
				//alert('strArrValues'+strArrValues);
				if(strArrValues.search(strData) == -1)
				{
					arr.push(strData);
					arr.sort();
				}
			}
			
			function RemoveFromArray(arr,strData)
			{
				for(var i=0; i < arr.length; i++)
				{
					if(arr[i] == strData)
					{
						arr.splice(i,1);
					}
				}
			}
			
			function ClearArray(arr)
			{
				arr.splice(0,arr.length);
			}
			
			function getTaskID(strCellID)
			{	//to get task id associate with sell
				var strTaskID;
				var startIndex = strCellID.indexOf("_") + 1;
				strTaskID = strCellID.substring(startIndex);
				return strTaskID;
			}
			
			function getTaskName(strCellID)
			{//take data cellid as argument and return corrosponding task name
			 
				var strTaskID = getTaskID(strCellID);
				 
				var strName=getTaskName_TaskID(strTaskID);
				 
				return strName;
			}
			
			function getTaskName_TaskID(strTaskID)
			{//take taskid as argument and return corrosponding task name
				var strTNID = "TDS0_" + strTaskID;
				var objTN = document.getElementById (strTNID);
				 
				var strName="";
				if(objTN != null)
				{
					//'Modified by ShraddhaM on Date 17 July,2006 for PMLifeLine Issue ID.4873

					if(navigator.appName == 'Netscape')
					{
						strName = objTN.innerHTML;
					}
					else
					{
						strName = objTN.innerText;
					}
					return strName;
					 
				}
			}
			function getTaskStartDate(strCellID)
			{//take taskid as argument and return corrosponding task start date
				var strTaskID = getTaskID(strCellID);
				var strTNID = "TDS1_" + strTaskID;
				var objTSD = document.getElementById (strTNID);
				var strDate="";
				if(objTSD != null)
				{
					strDate = objTSD.innerHTML;
					if(strDate.substring(strDate.indexOf('=')+1) != null)
					{
						strDate = strDate.substring(strDate.indexOf('=')+1)
					}
				}
				return strDate;
			}
			function getEntryDate(strCellID)
			{
			//return entry date of cell
				var intIndex=getCellIndex(strCellID) - 0;
				var objDT = document.getElementById ('hdnStartDate');
				var dtSDate = getDate(objDT.value);
				//var dtSDate = GetDateInFormat(objDT.value, '-', "rev");
				return DateAdd(dtSDate, intIndex - 3, 0, 0);//cell index start with 3
			}
			
			function getDate3(ObjDate)
			{
				var dateString;
				var months = new Array(13);
				months[0] = "January";
				months[1] = "February";
				months[2] = "March";
				months[3] = "April";
				months[4] = "May";
				months[5] = "June";
				months[6] = "July";
				months[7] = "August";
				months[8] = "September";
				months[9] = "October";
				months[10] = "November";
				months[11] = "December";
				var now = ObjDate;
				var monthnumber = now.getMonth();
				var monthname = months[monthnumber];
				var monthday = now.getDate();
				var year = now.getYear();
				if(year < 2000) { year = year + 1900; }
				
				dateString = monthday + '-' + Left(monthname,3) + '-' + year;
				return dateString;
			} 
			function getTaskEndDate(strCellID)
			{//take taskid as argument and return corrosponding task end date
				var strTaskID = getTaskID(strCellID);
				var strTNID = "TDS2_" + strTaskID;
				var objTSD = document.getElementById (strTNID);
				var strDate="";
				if(objTSD != null)
				{
					strDate = objTSD.innerHTML;
					if(strDate.substring(strDate.indexOf('=')+1) != null)
					{
						strDate = strDate.substring(strDate.indexOf('=')+1)
					}
				}
				return strDate;
			}
			
			function getCellIndex(strCellID)
			{	// to get index of cell
				var intCellIndex=-1;
				intCellIndex = strCellID.charAt(3);
				return intCellIndex;
			}
			
			function Set_as_ErrorCell(strCellID,strStatus)
			{//to set cell as error cell and return error object --arrInvalidCells
			
				var strTaskID = getTaskID(strCellID);
				var ObjE = document.getElementById (strCellID);
				if(ObjE != null)
				{
					/*if(strStatus == "ERROR")
					{
						ObjE.innerHTML = ObjE.innerHTML + getImageText(strCellID,strImgSourceRed);
									
					}
					else
					{
						ObjE.innerHTML = ObjE.innerHTML + getImageText(strCellID,strImgSourceYellow);
					}*/
					
					arrInvalidCells.push(new CellErrors(strStatus,strTaskID,getCellIndex(strCellID),strCellID));
					return arrInvalidCells[arrInvalidCells.length-1];
				}
			}
			
			function getImageText(strCellID,strSource)
			{
				var strImg = "<img id=img_" + strCellID + "  src='" + strSource + "' onmousemove=msoCommentShow('com3_','" + strCellID + "')>";
				return strImg;
				
			}
			
			function Reset_ErrorCell(strCellID)
			{//to reset cell 
				var ObjE = document.getElementById (strCellID);
				if(ObjE != null)
				{//alert(ObjE.style.BORDERTOP);
						ObjE.innerHTML = ObjE.innerHTML;
					for(var i=0; i< arrInvalidCells.length;i++)
					{
						if(arrInvalidCells[i].id == strCellID)
						{
							arrInvalidCells[i] = null;//set object null
							arrInvalidCells.splice(i,1);//remove from array
						}
					}
				}
			}
			
			function isCellBlank(strCellID)
			{//return true if cell is blank otherwise false
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.innerHTML != "")
					{
						return false;
					}
					{
						return true;
					}
				}
			}
			
			function isCellBlank_1(strCellID)
			{//return true if cell is blank otherwise false
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.value != "")
					{
						return false;
					}
					{
						return true;
					}
				}
			}
			
			function isCellDisabled(strCellID)
			{
				var ObjV = document.getElementById (strCellID);
				if(ObjV.style.borderTopColor != strBorderColor)
				{
					return false;
				}
				else
				{
					return true;
				}
			}
			function isInvalidCell(strCellID)
			{//if given cellid is present in error array then return true else return false
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID )
					{
						return true;
					}
				}
				return false;
			}
			
			function getCellValue(strCellID)
			{//to get cell value as float
				var fltValue;
				var ObjV = document.getElementById (strCellID);
				if(ObjV != null)
				{
					if(ObjV.value != "")
					{
						//fltValue = parseFloat(ObjV.innerHTML);
						fltValue = parseFloat(ObjV.value);
						return fltValue;
					}
				}
				return null;
			}			

			function getCellStatus(strCellID)
			{//return ERROR for invalid cell, WARNING for warning cells anf VALID for valid cells
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID )
					{
						return arrInvalidCells[i].Status;
					}
				}
				return "VALID";
			}
			
			function getAllocatedWork(strCellID)
			{//returns allocated work for task
				var fltValue;
				var strAW = 'TDA_' + getTaskID(strCellID);
				var ObjAW = document.getElementById (strAW);
				if(ObjAW != null)
				{
					if(ObjAW.innerHTML != "")
					{
						<%' Added by VarunA on 17-Dec-2007 RequestID-10001 %>
						<%' Purpose : To have allocated work hrs for a task which are more than 1,000 hrs.%>
						<%' fltValue = parseFloat(ObjAW.innerHTML);%>
						fltValue = parseFloat(ObjAW.innerHTML.replace(",",""));
						<%' End By VarunA on 17-Dec-2007 %>
						return fltValue;
					}
					else
					{
						return 0;
					}
				}
			}
			function getActualWork(strCellID)
			{//returns actual work for task
				var fltValue;
				var strAW = 'TDB_' + getTaskID(strCellID);
				var ObjAW = document.getElementById (strAW);
				if(ObjAW != null)
				{
					if(ObjAW.innerText != "")					
					{
						<%' Added by VarunA on 17-Dec-2007 RequestID-10001 %>
						<%' Purpose : To have actual work hrs for a task which are more than 1,000 hrs. %>
						<%' fltValue = parseFloat(ObjAW.innerText);	%>
						fltValue = parseFloat(ObjAW.innerText.replace(",",""));	
						<%' End By VarunA on 17-Dec-2007 %>			
						return fltValue;
					}
					return 0;
				}
			}
			function getRowTotal(strCellID)
			{//return total of 7 days for given cellID
				var _strTaskID = getTaskID(strCellID);
				return getRowTotal_Task(_strTaskID);
			}
			function getRowTotal_Task(strTaskID)
			{//return total of 7 days for given taskid
				var fltValue;
				var flt_1=0,flt_2=0,flt_3=0,flt_4=0,flt_5=0,flt_6=0,flt_7=0;
				var strID_1;
				strID_1 = 'ctr3_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_1 = getCellValue(strID_1);	}
				else
				{flt_1 = 0;	}
				
				strID_1 = 'ctr4_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_2 = getCellValue(strID_1);	}
				else{flt_2 = 0;	}
				
				strID_1 = 'ctr5_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_3 = getCellValue(strID_1);}
				else
				{flt_3 = 0;}
				
				strID_1 = 'ctr6_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_4 = getCellValue(strID_1);	}
				else
				{flt_4 = 0;}
				
				strID_1 = 'ctr7_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_5 = getCellValue(strID_1);	}
				else
				{flt_5 = 0;}
				
				strID_1 = 'ctr8_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_6 = getCellValue(strID_1);	}
				else
				{flt_6 = 0;}
				
				strID_1 = 'ctr9_' + strTaskID;
				if(isCellBlank_1(strID_1) == false && isCellDisabled(strID_1)==false)
				{flt_7 = getCellValue(strID_1);	}
				else
				{flt_7 = 0;}
				
				fltValue = parseFloat(flt_1) + parseFloat(flt_2) + parseFloat(flt_3) + parseFloat(flt_4) + parseFloat(flt_5) + parseFloat(flt_6) + parseFloat(flt_7);
				return fltValue;
			}
			
			function getErrorObj(strCellID)
			{//return error object(class CellErrors) or null
				for(var i=0;i<arrInvalidCells.length;i++)
				{
					if(arrInvalidCells[i].id == strCellID)
					{
						return arrInvalidCells[i];
					}
				}
				return null;
			}
			
			function getErrorMessages(strCellID)
			{//return all messages
				var strTemp ="";
				intSrNo = 0;
				var objE = getErrorObj(strCellID);
				for(var i=0;i< objE.EMsg.length;i++)
				{
					strTemp = strTemp + (++intSrNo) + ": " + objE.EMsg[i] + "\n";
				}
				return strTemp;
			}
			
			function getWarningMessages(strCellID)
			{//return all warnings
				var strTemp ="";
				var objE = getErrorObj(strCellID);
				for(var i=0;i< objE.WMsg.length;i++)
				{
					strTemp = strTemp + (++intSrNo) + ": " + objE.WMsg[i] + "\n";
				}
				return strTemp;
			}
			
			function getImageObject(strCellID)
			{
				return document.getElementById ('img_' + strCellID);
			}
			
			function setImage(ObjError,Status)
			{
				if(ObjError != null)
				{
					var strCellID = ObjError.id;
					var ObjC = document.getElementById (strCellID);
					
					if(ObjError.EMsg.length <= 0)
					{ObjError.Status = Status;}
					
					/*
					code modified by harshadad for PMLifeLine SP7 on 18 th July 2006
					
					if(Status == 'ERROR')
					{
						ObjError.Status = Status;
						ObjC.innerHTML = ObjC.innerHTML + getImageText(strCellID,strImgSourceRed);
						//alert(ObjC.innerHTML);
					}
					else if(ObjError.Status == "ERROR")
					{
						ObjC.innerHTML = ObjC.innerHTML + getImageText(strCellID,strImgSourceRed);
						//alert(ObjC.innerHTML);
					}
					else
					{
						ObjC.innerHTML = ObjC.innerHTML + getImageText(strCellID,strImgSourceYellow);
					}*/
					//if(getImageObject(strCellID) == null)
					
					if(Status == 'ERROR')
					{
						ObjError.Status = Status;
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceRed);
					}
					else if(ObjError.Status == "ERROR")
					{
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceRed);
					}
					else
					{
						//ObjC.innerHTML = ObjC.innerText + getImageText(strCellID,strImgSourceYellow);
					}
					//end of code modification by harshadad for PMLifeLine SP7 on 18 th July 2006
				}
			}
			function getColumnTotal(strCellID)
			{
				var fltTot=0.0;
				var strIndex = getCellIndex(strCellID);
				//var strID = 'TDA' + strIndex;
				//var objTot = document.getElementById (strID);
				var objTot = document.getElementById (strCellID);
				var objTemp, valTemp=0.0;
				/*if (objTot != null && objTot.innerHTML != "")//total for all project
				{
					fltTot += parseFloat(objTot.innerHTML);
				}*/
				for(var i=0;i<arrEditedCells.length;i++)//column wise total of edited cell
				{
					if(strIndex == getCellIndex(arrEditedCells[i]))
					{
						valTemp=0.0;
						objTemp = document.getElementById (arrEditedCells[i]);
						valTemp = objTemp.value;
						if (valTemp != '')
						fltTot += parseFloat(valTemp);
					}
				}
				return fltTot;
			}
			
			/*function ValidateEditedCells()
			{
				var _blnStatus = true;
				var fltActualWork;
				var fltAllocatedWork;
				var fltRowTotal;
				var strErrorMessage='';
				for(var i=0;i<arrEditedCells.length;i++)
				{		
						//Clear all error and warning messages if any
						var _Obj = getErrorObj(arrEditedCells[i]);
						if(_Obj != null){ClearArray(_Obj.EMsg); ClearArray(_Obj.WMsg); }
						//_Obj = null;
						//=====================================
						fltCurrentCellValue = getCellValue(arrEditedCells[i]);
						if(fltCurrentCellValue != null)
						{
							fltRowTotal = getRowTotal(arrEditedCells[i]);
							fltAllocatedWork = getAllocatedWork(arrEditedCells[i]);
							fltActualWork = getActualWork(arrEditedCells[i]);
							var strTaskStartDate = trimString(getTaskStartDate(arrEditedCells[i]));
							var strTaskEndDate = trimString(getTaskEndDate(arrEditedCells[i]));
							var strWhichTask = getTaskType(arrEditedCells[i]);
							var blnRestrictDurationChange = false;
							
							//validation for backdate entry
							if(ValidationForBackDateEntry(arrEditedCells[i]) == false)
							{
								_blnStatus = false;
								return;
							}
							//---------------------------------------------------------------------------------
							//validation for forward date entry
							if(ValidationForForwardDateEntry(arrEditedCells[i]) == false)
							{
								_blnStatus = false;
								return;
							}
							//---------------------------------------------------------------------------------
							//total work per day should not be between 0 to 24
							if(ValidationForWorkPerDay(arrEditedCells[i]) == false)
							{
								_blnStatus = false;
								return;
							}
							//----------------------------------------------------------------------------------
							//constraint validation
							if(isEnforceConstraint(arrEditedCells[i]) != false)
							{
								if(ConstraintValidation(arrEditedCells[i]) == false)
								{
									_blnStatus = false;
									return;
								}
							}
							//-------------------------------------------------------------------------------
							//if entry is not allowed for mpp and assigned task
							
							if(strWhichTask == "M")
							{
								if(strRestrict_MPPTasks == 'True')
								{
									blnRestrictDurationChange = true;
									return;
								}
							}
							else if(strWhichTask == "O")
							{
								if(strRestrict_AssignedTasks == 'True')
								{
									blnRestrictDurationChange = true;									
								}
							}
							else
							{
								blnRestrictDurationChange = true;
							}
							//------------------------------------------------------------------------------
							//entry date should be between task start date and end date.///Schedule Variance
							if (getTaskType(arrEditedCells[i])=='O' || getTaskType(arrEditedCells[i])== 'M' )
							{
								if(strTaskStartDate != '' && strTaskEndDate != '')
								{
									var dtTaskStartDate = getDate(strTaskStartDate);
									var dtTaskEndDate = getDate(strTaskEndDate);
									var dtCurrentDate = getEntryDate(arrEditedCells[i]);
									if(dtCurrentDate < dtTaskStartDate || dtCurrentDate > dtTaskEndDate)
									{
										strErrorMessage = arrMessages[1].replace('<=>',strTaskStartDate).replace('<==>',strTaskEndDate) + '\n';
										if(isInvalidCell(arrEditedCells[i]) == false)// check if already exixt in arrInvalidCells array
										{
											if (blnRestrictDurationChange == true)
											{	
												// var objEC = Set_as_ErrorCell(arrEditedCells[i],"ERROR");
												// objEC.EMsg.push(strErrorMessage);//atteching message to cell
												alert(strErrorMessage);
												return false;												
											}
											else
											{
												// var objEC = Set_as_ErrorCell(arrEditedCells[i],"WARNING");
												// objEC.WMsg.push(strErrorMessage);//atteching message to cell
												if (window.confirm(strErrorMessage))
													return true;
												return false;
											}
										}
										else
										{
											var objEC = getErrorObj(arrEditedCells[i]);
											if (blnRestrictDurationChange == true)
											{	
												// setImage(objEC,"ERROR");
												// objEC.EMsg.push(strErrorMessage);//atteching message to cell
												alert(strErrorMessage);
												return false;
											}
											else
											{
												// setImage(objEC,"WARNING");
												// objEC.WMsg.push(strErrorMessage);//atteching message to cell
												if (window.confirm(strErrorMessage))
													return true;
												return false;
											}
										}
										_blnStatus = false;
									}
								}
								//---------------------------------------------------------------------------------
								//Actual efforts should be less or equal to allocated efforts///Efforts Variance
								if(fltRowTotal + fltActualWork > fltAllocatedWork)
								//if(fltRowTotal  > fltAllocatedWork)
								{
									strErrorMessage = arrMessages[3].replace('<=>',fltAllocatedWork).replace('<==>',(fltRowTotal + fltActualWork)) + '\n';
									//strErrorMessage = arrMessages[3].replace('<=>',fltAllocatedWork).replace('<==>',fltRowTotal) + '\n';
									if(isInvalidCell(arrEditedCells[i]) == false)// check if already exixt in arrInvalidCells array
									{
										if (blnRestrictDurationChange == true)
										{	
											// var objEC = Set_as_ErrorCell(arrEditedCells[i],"ERROR");
											// objEC.EMsg.push(strErrorMessage);//atteching message to cell
											alert(strErrorMessage);
											return false;
										}
										else
										{
											// var objEC = Set_as_ErrorCell(arrEditedCells[i],"WARNING");
											// objEC.WMsg.push(strErrorMessage);//atteching message to cell
											if (window.confirm(strErrorMessage))
												return true;
											return false;
										}
									}
									else
									{
										var objEC = getErrorObj(arrEditedCells[i]);
										if (blnRestrictDurationChange == true)
										{	
											// setImage(objEC,"ERROR");
											// objEC.EMsg.push(strErrorMessage);//atteching message to cell
											alert(strErrorMessage);
											return false;
										}
										else
										{
											// setImage(objEC,"WARNING");
											// objEC.WMsg.push(strErrorMessage);//atteching message to cell
											if (window.confirm(strErrorMessage))
												return true;
											return false;
										}
									}
									_blnStatus = false;
								}
							}///end of if(==O)
							//---------------------------------------------------------------------------------
							
							if (_blnStatus == true)//if all condition satisfied then reset cell
							{
								//Reset_ErrorCell(arrEditedCells[i]);
							}
						}
						else
						{
							Reset_ErrorCell(arrEditedCells[i]);
						}
				}
				
			}*/
			function ConstraintValidation(strCellID)
			{
				var strErrorMessage;
				var ConstraintType = getConstraintType(strCellID);
				var strConstraintDate = getConstraintDate(strCellID);
				var dtConstraintDate = getDate(strConstraintDate);
				var dtEntryDate = getEntryDate(strCellID);
				var strEntryDate = dtEntryDate.toDateString();
				var blnTimeBookedAgainstTask = isTimeBookedAgainstTask(strCellID);
				var blnTaskMarkedAsComplete ;
				var ObjCK = GetObjectReference('frmWeeklyTimesheet', 'chkTaskCompleted_' + getTaskID(strCellID));
				if (ObjCK != null)
				{
					blnTaskMarkedAsComplete = ObjCK.checked;
				}
				switch(ConstraintType)
				{
					case '0':
						//as soon as possible
						break;
					case '1':
						//as late as possible
						break;
					case '2':
						//Must Start on
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0))
						{
							//blnConstraintViolated = true;
							strErrorMessage = arrMessages[9].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '3'://Must Finish on
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
						{
							strErrorMessage = arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '4':
						//start no earlier than
						if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(dtEntryDate, dtConstraintDate, "d") > 0)
						{	
							strErrorMessage = arrMessages[11].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '5':
						//Start no later than 
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
						{
							strErrorMessage = arrMessages[12].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '6':
						//Finish no eariler than
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
						{
							strErrorMessage = arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
					case '7':
						//finish no later than
						if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
						{
							strErrorMessage = arrMessages[14].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
							alert(strErrorMessage);
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							return false;
						}
						break;
				}
			}
			function chkTaskCompleted_OnClick(objCheckBox)
			{
				if(isEnforceConstraint(objCheckBox.id) != false)
				{
					var strMessage='';
					var ConstraintType = getConstraintType(objCheckBox.id);
					var strConstraintDate = getConstraintDate(objCheckBox.id);
					var dtConstraintDate = getDate(strConstraintDate);
					var strEntryDate;
					var dtEntryDate;
					var blnTimeBookedAgainstTask = isTimeBookedAgainstTask(objCheckBox.id);
					var fmt = "dummy";
					var strTaskID = getTaskID(objCheckBox.id);
					
					var blnDisplayMessage;
					var blnTaskMarkedAsComplete;
										
					blnTaskMarkedAsComplete = objCheckBox.checked;
					blnDisplayMessage = true
					
					for(var intCol=3; intCol<=9; intCol++)
					{
						var strCellID = "TDD" + intCol + "_" + strTaskID;
						dtEntryDate = getEntryDate(strCellID);
						strEntryDate = dtEntryDate.toDateString();
						if (getCellValue(strCellID) != null)
						{
							fmt = "dummy1";
							switch(ConstraintType)
							{
								case '0':
									//as soon as possible
									break;
								case '1':
									//as late as possible
									break;
								case '2':
									//Must Start on
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0))
									{
										strMessage =   arrMessages[9].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '3':
									//Must Finish on
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
									{
										strMessage =  arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '4':
									//start no earlier than
									if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(dtEntryDate, dtConstraintDate, "d") > 0)
									{
										strMessage =  arrMessages[11].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '5':
									//Start no later than 
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
									{
										strMessage =  arrMessages[12].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '6':
									//Finish no eariler than
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
									{
										strMessage =  arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
								case '7':
									//finish no later than
									if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
									{
										strMessage =  arrMessages[14].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n';
									}
									break;
							}
							
							if (strMessage != "")
							{
								if (blnDisplayMessage == true)
								{
									alert(strMessage);
								}
								switch(ConstraintType)
								{
									case '3':
										if ((DateDiff(dtEntryDate, dtConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0))
										{
											objCheckBox.checked = false;
											GetObjectReference('frmWeeklyTimesheet', strCellID).innerHTML = "";
											fmt = "dummy1";
										}
										break;
									case '7':
										if (DateDiff(dtEntryDate, dtConstraintDate, "d") < 0)
										{
											objCheckBox.checked = false;
											GetObjectReference('frmWeeklyTimesheet', strCellID).innerHTML = "";
										}
										break;
									case '6':
										objCheckBox.checked = false;
										break;
								}
								
								blnDisplayMessage = false;
							}
						}
					}//End of for loop
					
					if (ConstraintType == '6' && fmt == "dummy")
					{
						if (arguments.length > 1 && DateDiff(arguments[1], dtConstraintDate, "d") > 0 ) 
						{
							blnDisplayMessage = false;
						}
						else if (arguments.length == 1)
						{
							blnDisplayMessage = false;
						}
						if (blnDisplayMessage == false)
						{
							objCheckBox.checked = false;
							alert(arrMessages[13].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n');
						}
					}

					if (ConstraintType == '3' && fmt == "dummy")
					{
						if (arguments.length > 1 && DateDiff(arguments[1], dtmConstraintDate, "d") != 0 ) 
						{
							blnDisplayMessage = false;
						}
						else if (arguments.length == 1)
						{
							blnDisplayMessage = false;
						}
						if (blnDisplayMessage == false)
						{
							objCheckBox.checked = false;
							alert(arrMessages[10].replace('<=>',strConstraintDate).replace('<=>',strConstraintDate) + '\n');
						}
					}
				}//End of if(isEnforceConstraint(objCheckBox.id) != false)
				//Track of edited or clicked check box
				InsertIntoArray(arrChkBox,getTaskID(objCheckBox.id) + ':' + getProjectID(objCheckBox.id));
			}
			
			function ValidationForBackDateEntry(strCellID)
			{
				var strErrorMessage;
				if(intBackDating.length != 0)
				{
					if (isProjectBackdateEntry(strCellID) != true)
					{
						if (DateDiff(DateAdd(new Date(getEntryDate_1(strCellID)), intBackDating, 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") > 0 )
						{
							//strErrorMessage = arrMessages[7] + '\n';
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							alert("<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>");
							setFocus_TS(strCellID);
							return false;
						}
					}
				}
			}
			function ValidationForForwardDateEntry(strCellID)
			{
				var strErrorMessage;
				if(intFwdDating.length != 0)
				{//alert(intFwdDating);
					if (isProjectForwarddateEntry(strCellID) != true)
					{
						if (DateDiff(DateAdd(new Date(getEntryDate(strCellID)), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
						{
							//strErrorMessage = arrMessages[7] + '\n';
							//ProcessError(strCellID,"ERROR",strErrorMessage);
							alert("<%=MyBase.GetResourceString("MSG_TIMESHEET_BLOCKED")%>");
							setFocus_TS(strCellID);
							return false;
						}
					}
				}
			}
			function ValidationForWorkPerDay(strCellID)
			{
				var fltColTotal = getColumnTotal(strCellID);
				var intMax = getMaxEntry(strCellID) - 0;
				var intIndex = getCellIndex(strCellID);// == 3
				var EntryOn=0;
				switch(intIndex)
				{
					case '3':
						EntryOn = <%=m_dblEntryDay1%>;
						break;
					case '4':
						EntryOn = <%=m_dblEntryDay2%>;
						break;
					case '5':
						EntryOn = <%=m_dblEntryDay3%>;
						break;
					case '6':
						EntryOn = <%=m_dblEntryDay4%>; 
						break;
					case '7':
						EntryOn = <%=m_dblEntryDay5%>; 
						break;
					case '8':
						EntryOn = <%=m_dblEntryDay6%>; 
						break;
					case '9':
						EntryOn = <%=m_dblEntryDay7%>; 
						break;
				}
				var strErrorMessage;
				//
				if(parseFloat(fltColTotal) + parseFloat(EntryOn) > parseFloat(intMax))
				{
					strErrorMessage = arrMessages[28].replace('<=>',intMax) + '\n';
					//ProcessError(strCellID,"ERROR",strErrorMessage);
					alert(strErrorMessage);
					setFocus_TS(strCellID);
					return false;
				}
			}
			function ProcessError(strCellID,Status,strMsg)
			{
				if(isInvalidCell(strCellID) == false)// check if already exixt in arrInvalidCells array
				{
					var objEC = Set_as_ErrorCell(strCellID,Status);
				}
				else
				{
					var objEC = getErrorObj(strCellID);
					setImage(objEC,Status);
				}
				if(Status = "ERROR")
				{
					objEC.EMsg.push(strMsg);//atteching message to cell
				}
				else
				{
					objEC.WMsg.push(strMsg);//atteching message to cell
				}
			}
			function isProjectBackdateEntry(strCellID)
			{	var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectBackdateEntry;
					}
				}
			}
			function isProjectForwarddateEntry(strCellID)
			{	var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectFwddateEntry;
					}
				}
			}
			function getMaxEntry(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].MaxEntry;
					}
				}
				//return 24;
			}
			function getTaskType(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].WhichTask;
					}
				}	
			}
			function isEnforceConstraint(strCellID)
			{//its a project specific property and if its true then function will return true
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].EnforceConstraint;
					}
				}
			}
			function getConstraintType(strCellID)
			{//return constraint type(task specific)
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ConstraintType;
					}
				}
			}
			function getConstraintDate(strCellID)
			{//return constraint date(task specific)
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ConstraintDate;
					}
				}
			}
			function isTimeBookedAgainstTask(strCellID)
			{//if time booked agained task then return true
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].TimeBookedAgainstTask;
					}
				}
			}
			function getProjectID(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].ProjectID;
					}
				}
			}	
			function getResponse(strCellID)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						return arrProjectTasks[i].Response;
					}
				}
			}
			function setResponse(strCellID,intResponse)
			{
				var strTaskID = getTaskID(strCellID);
				for(var i=0;i<arrProjectTasks.length;i++)
				{
					if(arrProjectTasks[i].TaskID == strTaskID)
					{
						arrProjectTasks[i].Response = intResponse;
					}
				}
			}
			function CallOnMouseMove(ObjCell,RowNo,ColNo,strProjectID)
			{
				//var ObjTable = document.getElementById ("tbl_" + strProjectID);
				var ObjTable = document.getElementById ("tblList");
				var CurrentElement = ObjCell.id;
				var StartSelection = false;
				var startCellIndex;
				
				if (event.button==1) 
				{ 
					//alert(RowNo + '-' + ColNo);
					ElementClicked = "";
					for(var i=0; i< ObjTable.rows.length ; i++)
					{
						for(var j=2;j<= 9; j++ )
						{
							if( j >= StartingCol && j <= ColNo && i <= RowNo && i >= StartingRow)
							{	
								if(ObjTable.rows[i].cells[j] != null )
								{
									var strTdcolor = ObjTable.rows[i].cells[j].bgColor;
									if(strTdcolor != "" && strTdcolor != strRedColor && strTdcolor != strYellowColor && ObjTable.rows[i].cells[j].style.borderTopColor != strBorderColor)
									{
										ObjTable.rows[i].cells[j].bgColor=strBgcolor;
										ElementClicked = ElementClicked + ObjTable.rows[i].cells[j].id + ",";
									}
								}
							}
							else
							{
								if(ObjTable.rows[i].cells[j] != null )
								{
									var strTdcolor = ObjTable.rows[i].cells[j].bgColor;
									if(strTdcolor != "" && strTdcolor != strRedColor && strTdcolor != strYellowColor && ObjTable.rows[i].cells[j].style.borderTopColor != strBorderColor)
									{
										ObjTable.rows[i].cells[j].bgColor=strBaseColor;
									}
									
								}
								
							}
							
						}
					}
				}
			}

			function SelectCell(ObjCell,RowNo,ColNo,strProjectID)
			{
				if (event.button==1 ) 
				{	//alert(RowNo + '-' + ColNo);
					if(ObjCell.style.borderTopColor != strBorderColor)
					{
						if(ObjCell.bgColor == strBgcolor)
						{
							ResetCell(ObjCell);
						}
						else
						{
							ElementClicked = ElementClicked + ObjCell.id + ",";
							HighLightElements();
						}
					}
					//alert(ObjCell.offsetWidth);
					//----------------
					StartingElement = ObjCell.id;
					StartingCol = ColNo;
					StartingRow = RowNo;
				}
				else
				{
					StartingElement = "";
					StartingCol = 0;
					StartingRow = 0;
					ResetCells();
				}
			}

			function ResetCell(ObjCell)
			{
				ObjCell.bgColor = strBaseColor;
				ElementClicked = ElementClicked.replace(ObjCell.id,'');
			}
			function ResetCells()
			{//to unselect selected cells
				var arrElements =  ElementClicked.split(",");
				for (var i=0; i < arrElements.length; i++)
				{
					var obj1 ;
					obj1 = document.getElementById (arrElements[i]);
					
					if(obj1 != null)
					{
					
						obj1.className = "";
						obj1.bgColor=strBaseColor;
					}
				}
				ElementClicked = "";
			}


			function HighLightElements()
			{
				var arrElements =  ElementClicked.split(",");
				for (var i=0; i < arrElements.length; i++)
				{
					var obj1 ;
					obj1 = document.getElementById (arrElements[i]);
					if(obj1 != null)
					{
						obj1.bgColor=strBgcolor;
					}
				}
			}
				
			//START_AJ
			function PlotControls(ObjCell,strProjectID, TDID)
			{	 
			    //debugger;
				appendControl("text", "Numeric", TDID, strProjectID);
				/*var objControl=GetObjectReference('frmWeeklyTimesheet',"ctr"+TDID);
				if (objControl != null)
				{
				objControl.select();
				objControl.focus();
				}*/
				setFocus_TS("ctr"+TDID);
			}
			function setFocus_TS (obj)
			{
			var FocusTosetobj = GetObjectReference("frmWeeklyTimesheet", obj);
				if (FocusTosetobj != null)
				{
					FocusTosetobj.value='';
					FocusTosetobj.select();
					FocusTosetobj.focus();
				}
			}
			function appendControl(ctrlType, ctrlCaption, TDID, strProjectID)
			{
			    var objTD = GetObjectReference('frmWeeklyTimesheet',"TDD"+TDID);
			    //if (objTD.innerHTML != "") return;        COMMENTED BY Puneet M ON 19-11-2015
				if (objTD.innerHTML != "" && objTD.innerHTML != "\n") return;   // ADDED BY PUNEET M ON 19-11-2015
				var i=0, str="";
				i=TDID.indexOf("_");
				str=TDID.substring(i+1);
				var objTR = GetObjectReference('frmWeeklyTimesheet','TRD_'+strProjectID+'_'+str);
				var control, objControl;
				if(objTR != null && objTD != null)
				{
					if (GetObjectReference('frmWeeklyTimesheet',"ctr"+TDID)== null)
					{
						var oNewTD = document.createElement("TD");
						oNewTD.id = "TDD"+TDID;
						
						control = document.createElement("INPUT");
						control.type=ctrlType;
						control.id="ctr"+TDID;
						control.width = 45;
						oNewTD.appendChild(control);
						control.onblur = function(){SendXMLHTTP_Save(this.id);};
						objTR.replaceChild(oNewTD, objTD);
																							
						objControl=GetObjectReference('frmWeeklyTimesheet',control.id);
						if (objControl!= null && ctrlType=="text")
						{
							objControl.className="clsTextbox";
							objControl.style.textAlign="right";
							//Modified BY VarunA on 27-Aug-2008 RequestID-15303
							//Purpose : To solve the alignment issue
							//objControl.style.width=45;
							objControl.style.width="45px";
							//getElementById(control.id).style.width='50 !important';
							//End By VarunA on 27-Aug-2008 RequestID-15303
							
							
						}
					}
				}
			}
			function SendXMLHTTP_Save(id)
			{ 
	 			var obj = document.getElementById(id);
	 			//Added by GaneshD on 11 Sep 2009 for PMLifeLine IssueID-32208
	 			if (isNaN(obj.value))
	 			{   
	 			    alert('Please enter numeric value');
	 			    obj.value="";
	 			    obj.focus();
	 			    return;
	 			}
	 			// End of addition by GaneshD on 11 Sep 2009
				var value = eval(obj.value-0);
				
				//Added by by GokulP on 06 Nov 2009 for PMLifeLine IssueID-33827
				if(value==0)
				{
				  obj.value="";
				}
				//End of Addition by GokulP on 06 Nov 2009 for PMLifeLine IssueID-33827
				
				if (value !="")
				obj.value=value.toFixed(2);
				if ((((obj.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((obj.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
				{
					alert(arrMessages[20] + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
					obj.value = "";
					obj.focus();
					return;
				}
				if((obj.value-0) > intMaxHoursPerDay || (obj.value-0)< 0)
				{
					alert(arrMessages[6].replace('<=>',intMaxHoursPerDay) + '\n');
					obj.value = "";
					obj.focus();
					return;
				}
				if(value!="")
				ElementClicked=ElementClicked+id+","
				
				InsertIntoArray(arrEditedCells, id); //Track of edited cells
				ValidateEditedCells_1(id);
			}
			function getEntryDate_1(strCellID)
			{
				var intIndex=getCellIndex(strCellID) - 0;
				var objDT = document.getElementById ('hdnStartDate');
				//var dtSDate = new Date(getDateFromFormat(objDT.value));
				//var dtSDate = new Date(GetDateInFormat(objDT, '', "rev"))
				var dtSDate = objDT.value.replace("-", "");
				return DateAdd(new Date(dtSDate), intIndex - 3, 0, 0);//cell index start with 3
			}
			function ValidateEditedCells_1(objCellToBeValidated)
			{
				var _blnStatus = true;
				var fltActualWork;
				var fltAllocatedWork;
				var fltRowTotal;
				var strErrorMessage='';
						//Clear all error and warning messages if any
						var _Obj = getErrorObj(objCellToBeValidated);
						if(_Obj != null){ClearArray(_Obj.EMsg); ClearArray(_Obj.WMsg); }
						//=====================================
						fltCurrentCellValue = getCellValue(objCellToBeValidated);
						if(fltCurrentCellValue != null)
						{
							fltRowTotal = getRowTotal(objCellToBeValidated);
							fltAllocatedWork = getAllocatedWork(objCellToBeValidated);
							fltActualWork = getActualWork(objCellToBeValidated);
							var strTaskStartDate = trimString(getTaskStartDate(objCellToBeValidated));
							var strTaskEndDate = trimString(getTaskEndDate(objCellToBeValidated));
							var strWhichTask = getTaskType(objCellToBeValidated);
							var blnRestrictDurationChange = false;
							
							//validation for backdate entry
							if(ValidationForBackDateEntry(objCellToBeValidated) == false)
							{
								return;
							}
							//validation for forward date entry
							if(ValidationForForwardDateEntry(objCellToBeValidated) == false)
							{
								return;
							}
							//total work per day should not be between 0 to 24
							if(ValidationForWorkPerDay(objCellToBeValidated) == false)
							{
								return;
							}
							
							//Trupti
							var strjoinigdate=GetObjectReference('frmWeeklyTimesheet','hdnJoiningdate');
								
								if(strjoinigdate != '')
								{
									var dtjoinigdate=getDate(strjoinigdate.value);
									var dtCurrentDate1=getEntryDate(objCellToBeValidated);	
									var objDT1 = document.getElementById ('hdnStartDate');
									//alert(dtCurrentDate1); 
									//alert(GetDateInFormat(dtCurrentDate1, '', 'rev'));
									if(dtjoinigdate > dtCurrentDate1)
									{
										//Comment and modification by SuchitraP on 9-Apr-2009 for issueID : 29949
										//Purpose : Correction in alert message
										//alert('You can not logged efforts before joining date ('+ strjoinigdate.value+ ')');
										alert('You can not log efforts before the joining date ('+ strjoinigdate.value+ ')');
										//End of modification by SuchitraP on 9-Apr-2009
										setFocus_TS(objCellToBeValidated); return true;
									}
								
								}
								//end by Trupti
								
							//----------------------------------------------------------------------------------
							//constraint validation
							if(isEnforceConstraint(objCellToBeValidated) != false)
							{
								if(ConstraintValidation(objCellToBeValidated) == false)
								{
									return;
								}
							}
							//-------------------------------------------------------------------------------
							//if entry is not allowed for mpp and assigned task
							if(strWhichTask == "M")
							{
								if(strRestrict_MPPTasks == 'True')
								{
									blnRestrictDurationChange = true;
									return;
								}
							}
							else if(strWhichTask == "O")
							{
								if(strRestrict_AssignedTasks == 'True')
								{
									blnRestrictDurationChange = true;									
								}
							}
							else if(strWhichTask == "B")
							{
								if(strRestrict_AssignedTasks == 'True')
								{
									blnRestrictDurationChange = true;									
								}
							}
							else
							{
								blnRestrictDurationChange = true;
							}
							//entry date should be between task start date and end date.///Schedule Variance
							if (getTaskType(objCellToBeValidated)=='O' || getTaskType(objCellToBeValidated)== 'M' || getTaskType(objCellToBeValidated)== 'B' )
							{
								if(strTaskStartDate != '' && strTaskEndDate != '')
								{
									var dtTaskStartDate = getDate(strTaskStartDate);
									var dtTaskEndDate = getDate(strTaskEndDate);
									var dtCurrentDate = getEntryDate(objCellToBeValidated);
									if(dtCurrentDate < dtTaskStartDate || dtCurrentDate > dtTaskEndDate)
									{
										strErrorMessage = arrMessages[1].replace('<=>',strTaskStartDate).replace('<==>',strTaskEndDate) + '\n';
										if(isInvalidCell(objCellToBeValidated) == false)// check if already exixt in arrInvalidCells array
										{
											if (blnRestrictDurationChange == true)
											{	
												alert(strErrorMessage);
												setFocus_TS(objCellToBeValidated); return false;												
											}
											else
											{
												if (window.confirm(strErrorMessage))
													return true;
												setFocus_TS(objCellToBeValidated); return false;
											}
										}
										else
										{
											var objEC = getErrorObj(objCellToBeValidated);
											if (blnRestrictDurationChange == true)
											{	
												alert(strErrorMessage);
												setFocus_TS(objCellToBeValidated);return false;
											}
											else
											{
												if (window.confirm(strErrorMessage))
													return true;
												setFocus_TS(objCellToBeValidated); return false;
											}
										}
										_blnStatus = false;
									}
								}
								//Actual efforts should be less or equal to allocated efforts///Efforts Variance
								if(parseFloat(fltRowTotal) + parseFloat(fltActualWork) > parseFloat(fltAllocatedWork))
								{
									strErrorMessage = arrMessages[3].replace('<=>',fltAllocatedWork).replace('<==>',(fltRowTotal + fltActualWork)) + '\n';
									if(isInvalidCell(objCellToBeValidated) == false)// check if already exixt in arrInvalidCells array
									{
										if (blnRestrictDurationChange == true)
										{	
											alert(strErrorMessage);
											setFocus_TS(objCellToBeValidated);return false;
										}
										else
										{
											if (window.confirm(strErrorMessage))
												return true;
											setFocus_TS(objCellToBeValidated);return false;
										}
									}
									else
									{
										var objEC = getErrorObj(objCellToBeValidated);
										if (blnRestrictDurationChange == true)
										{	
											alert(strErrorMessage);
											setFocus_TS(objCellToBeValidated);return false;
										}
										else
										{
											if (window.confirm(strErrorMessage))
												return true;
											setFocus_TS(objCellToBeValidated);return false;
										}
									}
									_blnStatus = false;
								}
							}
									
							if (_blnStatus == true)//if all condition satisfied then reset cell
							{
								//Reset_ErrorCell(arrEditedCells[i]);
							}
						}
						else
						{
							//Reset_ErrorCell(objCellToBeValidated);
						}
				}
			//END_AJ	
			/*function PostHours_OnClick()
			{	//function name : PostHours_OnClick
				//purpose       : set cell value from combo and keeps track of edited cells
			
				var Elements = ElementClicked.split(",")
				var ObjCbohours = document.getElementById ('Cbohours');
				var hrs;
				if (ObjCbohours != null)
				{
					hrs = trimString(ObjCbohours.options[ObjCbohours.selectedIndex].text);
					if (hrs == '')return;
				}
				else 
				{
					ObjCbohours = document.getElementById ('txtHours');
					hrs = trimString(ObjCbohours.value);
					if (hrs == '')return;
					if ( (((ObjCbohours.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((ObjCbohours.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
					{
						alert(arrMessages[20] + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
						ObjCbohours.value = "";
						ObjCbohours.focus();
						return;
					}
					if((ObjCbohours.value-0) > intMaxHoursPerDay || (ObjCbohours.value-0)< 0)
					{
						alert(arrMessages[6].replace('<=>',intMaxHoursPerDay) + '\n');
						ObjCbohours.value = "";
						ObjCbohours.focus();
						return;
					}
					
				}
				for (var i=0; i < Elements.length-1; i++)
				{
					obj1 = document.getElementById (Elements[i])
					if(obj1 != null)
					{
						
						InsertIntoArray(arrEditedCells,Elements[i]); //treck of edited cells
						obj1.innerHTML = (hrs-0).toFixed(2);
					}
				}
				ResetCells();
				Elements="";
				//-----------
				ValidateEditedCells();
			
			}
			function ClearHours_OnClick()
			{
				var Elements = ElementClicked.split(",")
				for (var i=0; i < Elements.length-1; i++)
				{
					var obj1 = document.getElementById (Elements[i]);
					if(obj1 != null)
					{
						Reset_ErrorCell(Elements[i]);
						obj1.innerHTML = "";
						RemoveFromArray(arrEditedCells,Elements[i]);
					}
				}
				ResetCells();
				Elements="";	
				//-----------
				ValidateEditedCells();
			}*/
			function msoCommentShow(com_id,CellId) 
			{
				var c = document.all(com_id);
				var OblCell = document.getElementById (CellId);
				var strMsg;
				
				strAnchorCellID=CellId;
				//alert(com_id + "-" + anchor_id + "-" + CellId);
				if (OblCell != null)// && (OblCell.style.BORDERTOP == strBorderStyleRed || OblCell.style.BORDERTOP==strBorderStyleYellow))
				{//alert(OblCell.style.BORDERTOP);
					if (null != c ) 
					{
						c.style.position="absolute";
						if(getCellIndex(CellId) == 3)
						{xPos = event.clientX - 250;}
						else{xPos = event.clientX - 300;}//291
						yPos = event.clientY;
						var ObjE = getErrorObj(CellId);
						c.innerHTML = getCommentText(CellId,ObjE.Status);
						c.style.visibility = "visible";
						var ObjLblError = document.getElementById ('lblErrors');
						var ObjLblWarning = document.getElementById ('lblWarnings');
						ObjLblError.innerHTML = getErrorMessages(CellId);
						ObjLblWarning.innerHTML = getWarningMessages(CellId);
						if (ObjE.Status == "ERROR")ObjLblWarning.innerHTML += '\n\n' + arrMessages[23]
						else ObjLblWarning.innerHTML += '\n\n' + arrMessages[22]
						if(yPos + c.offsetHeight > document.body.scrollTop + document.body.clientHeight)
						{
							yPos = yPos - c.offsetHeight;
						}
						c.style.top = yPos;
						c.style.left = xPos;
					}
				}
			}
			function getCommentText(strCellID,Status)
			{
				var border,fcolor, backcolor,textcolor ,HdrColor,HeaderText; 
				border = "3"; 
				fcolor = "#FFFFF"; 
				backcolor = "#00008b";//"#b8860b"; 
				textcolor ="#000000"; 
				HdrColor = "#FFFFFF"; 
				HeaderText = "Errors and Warnings";
				//-----------------
				var ErrColor = "red";
				var Wcolor = "#000000";
				
				var str = "<TABLE  WIDTH=99.9% BORDER=0 CELLPADDING="+border+" CELLSPACING=0 BGCOLOR=\""+backcolor+"\">";
				str += "<Tr><TD align=center style='FONT-SIZE: 10pt;'><FONT FACE=\"Arial,Verdana\" COLOR=\""+HdrColor+"\" ><b>" + HeaderText + "</b></FONT></TD></TR>";
				str += "<Tr><TD>";
				str += "<TABLE WIDTH=99.9% BORDER=0 CELLPADDING=2 CELLSPACING=0 BGCOLOR=\""+fcolor+"\">";
				str += "<TR><TD><FONT FACE=\"Arial,Verdana\" COLOR=\""+ErrColor+"\" ><label style='FONT-SIZE: 10pt;' id='lblErrors'>Errors:</label></FONT></TD></TR>";
				str += "<TR><TD><FONT FACE=\"Arial,Verdana\" COLOR=\""+Wcolor+"\" ><label style='FONT-SIZE: 10pt;' id='lblWarnings'>Warnings:</label></FONT></TD></TR>";
				str += "<Tr><TD align=center>"
				if (Status == "ERROR")
				{str += "<center><Input class=ButtonStyle id='OK3_' type=button value='OK' onclick=OK_OnClick('" + strCellID + "','" + Status + "')></center>" ;}
				else
				{	str += "<center><Input class=ButtonStyle id='OK3_' type=button value='OK' onclick=OK_OnClick('" + strCellID + "','" + Status + "')>" ;
					str += "&nbsp;<Input class=ButtonStyle id='Cancel3_' type=button value='Cancel' onclick=Cancel_OnClick('" + strCellID + "')><center>" ;
				}
				str += "</TD></TR>";
				str += "</TABLE></TD></TR></TABLE>"
				return str;
			}
			function msoCommentPersist(com_id) 
			{
				var c = document.all(com_id);
				var OblCell = document.getElementById (strAnchorCellID);
				var ObjLblError = document.getElementById ('lblErrors');
				var ObjLblWarning = document.getElementById ('lblWarnings');
				var ObjBtnOK = document.getElementById ('OK3_');
				var ObjBtnC = document.getElementById ('Cancel3_');
				if (OblCell != null)
				{	if (null != c ) 
					{	c.style.position="absolute";
						c.style.top = yPos;
						c.style.left = xPos;
						c.style.visibility = "visible";				
					}
				}
			}
			function msoCommentHide(com_id) 
			{	c = document.all(com_id)
				if (null != c) {
					c.style.visibility = "hidden";
					c.style.left = "-10000";
					c.style.top = "-10000";
				}
			}
			function msoCommentReset(com_id) 
			{	c = document.all(com_id)
				if (null != c) 
				{	c.style.visibility = "hidden";
					c.style.left = "-10000";
					c.style.top = "-10000";
				}
			}
			function OK_OnClick(strCellID,Status)
			{
				if(Status != "ERROR")
				{
					var intResponse = 1;
					setResponse(strCellID,intResponse);
					Reset_ErrorCell(strCellID);
				}
				msoCommentHide('com3_');
			}
			function Cancel_OnClick(strCellID,Status)
			{
				var intResponse = 0;
				setResponse(strCellID,intResponse);
				Reset_ErrorCell(strCellID);
				document.getElementById(strCellID).innerHTML = "";
				RemoveFromArray(arrEditedCells,strCellID);
				msoCommentHide('com3_');
			}
			function txtPercentComplete_OnBlur(objTextbox)
			{			
				//Purpose	:	To perform the validations for the 'Actual % Complete' textbox.
				objtxtActualComplete = GetObjectReference('frmWeeklyTimesheet', objTextbox.id);
				if (disallowBlank1(objtxtActualComplete, arrMessages[4], "frmWeeklyTimesheet") == true)
				{
					return;
				}
				if (disallowNonNumeric1(objtxtActualComplete, arrMessages[17], "frmWeeklyTimesheet") == true)
				{
					return;
				}
				if (disallowValueRangeViolation1(objtxtActualComplete, 0, 100, arrMessages[5], "frmWeeklyTimesheet") == true)
				{
					return;
				}
			}
			
			function BuiltValueString()
			{	var strQueryString="";
				var objHdn1 = document.getElementById ('hdnQueryString');
				var objHdn2 = document.getElementById ('hdnTP');
				var objHdn3 = document.getElementById ('hdnChk');
				for(var i=0;i<arrEditedCells.length;i++)
				{	var cellValue = getCellValue(arrEditedCells[i]);
					var strTaskId = getTaskID(arrEditedCells[i]);
					var strProjectID = getProjectID(arrEditedCells[i]);
					var strCellIndex = getCellIndex(arrEditedCells[i]);
					var strResponse = getResponse(arrEditedCells[i]);
					strQueryString += cellValue + ':' + strCellIndex + ':' + strTaskId + ':' + strProjectID + ':' + strResponse + ';' ;
				}
				objHdn1.value = strQueryString;
				strQueryString = "";
				for(var i=0;i<arrTxtBox.length;i++)
				{strQueryString += arrTxtBox[i] + ';';}
				objHdn2.value = strQueryString;
				strQueryString = "";
				for(var i=0;i<arrChkBox.length;i++)
				{strQueryString += arrChkBox[i] + ';';}
				objHdn3.value = strQueryString;
			}
			function txtPercentComplete_OnChange(ObjTextBox)
			{	var strTaskID = getTaskID(ObjTextBox.id);
				var strProjectID = getProjectID(ObjTextBox.id);
				InsertIntoArray(arrTxtBox,strTaskID + ':' + strProjectID);
			}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!			
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        <%Else%>
			function Save2_OnClick()
			{
			
			//debugger;
				intProject = document.getElementById ('hdnProjectID').value;
												
				if ((strProjectsOnHold != "") && (intProject != ""))
				{
					if (strProjectsOnHold.indexOf(',' + intProject + ',') != -1)
					{
						alert(arrMessages[18]);
					}				
				}
				var objDAIDs = GetObjectReference('frmWeeklyTimesheet','hdnDAID',true);
				var intEnd = 0;
				if (objDAIDs != null)
				{	
					intEnd = objDAIDs.length==0?-1:(objDAIDs.length-1);
						for(var i=0; i <= intEnd;i++)
						{
							var objDes = GetObjectReference('frmWeeklyTimesheet','txtDescription_' + objDAIDs[i].value);
							if(objDes != null)
							{
								if (disallowMaxlengthViolation(objDes, 2000, arrMessages[19], 1) == true)
								{
									return;
								}
							}
							var objTxt = GetObjectReference('frmWeeklyTimesheet','txtDuration_' + objDAIDs[i].value);
							if(objTxt != null)
							{
								if (disallowBlank(objTxt, arrMessages[16]) == true)
								{
									return;
								}
							}
						}
				}
				
				
				
				if (intEnd >= 0 )//no da present then no action on save link
				{
					var ObjForm = GetFormReference('frmWeeklyTimesheet');
					if(strDetail == 0)
					{
						/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
						if ("<%=m_strFromWhere%>" == "Proxy")
						{
							ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
						}
						 //Added if condition by NitinC on 30 Nov 2011 for PMLifeLine (Issue Fix:56399)
						else if ("<%=strScrumFromWhere%>" == "WScrumTimeSheet")
						{
						    ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=WScrumTimeSheet&Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
						}
						 //End of Added if condition by NitinC on 30 Nov 2011 for PMLifeLine (Issue Fix:56399)
						else
						{
						    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
						    //ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
						    ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&FromWhere=DT&ShowDetails=1&Detail=" + strDetail;
						    //End of Addition by Dhanashri S on 11 Aug 2016
						}
						/*Addition End by SantoshK on 20th March 2006*/
					
						//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
					}
					else
					{
					
						/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
						if ("<%=m_strFromWhere%>" == "Proxy")
						{
							ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
						}
						//Added if condition by NitinC on 30 Nov 2011 for PMLifeLine (Issue Fix:56399)
						else if ("<%=strScrumFromWhere%>" == "WScrumTimeSheet")
						{
						    ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=WScrumTimeSheet&Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
						}
						 //End of Added if condition by NitinC on 30 Nov 2011 for PMLifeLine (Issue Fix:56399)

						else
						{
						    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
						    //ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
						    ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&FromWhere=DT&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
						    //End of Addition by Dhanashri S on 11 Aug 2016
						}
						/*Addition End by SantoshK on 20th March 2006*/
					
						//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=save&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
					}
					EnableTextArea();
				    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
					var MenuTags = document.getElementsByTagName('A');
					for (i = 0; i < MenuTags.length; i++) {
					    if (MenuTags[i].className == "Menu") {
					        //MenuTags[i].style.display= "none";
					        MenuTags[i].parentNode.style.display = "none";
					    }
					}
					setFrameLoader();  
				    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
					SubmitForm(ObjForm);	
				}
			}
			function EnableTextArea()
			{
				var objDAIDs = GetObjectReference('frmWeeklyTimesheet','hdnDAID',true);
				var intEnd = 0;
				if (objDAIDs != null)
				{	
					intEnd = objDAIDs.length==0?-1:(objDAIDs.length-1);
					for(var i=0; i <= intEnd;i++)
					{
						var objDes = GetObjectReference('frmWeeklyTimesheet','txtDescription_' + objDAIDs[i].value);												
						objDes.disabled = false;
					}
				}
			}
			function Delete_OnClick()
			{
				var objCHK = GetObjectReference('frmWeeklyTimesheet','chkDelete',true);
				if(objCHK != null && objCHK.length > 0)
				{
					var ObjForm = GetFormReference('frmWeeklyTimesheet');
					var intEnd = objCHK.length==0?-1:(objCHK.length-1);
					var blnDelete = false;
					for(var i=0; i <= intEnd;i++)
					{
						if(objCHK[i].checked == true)
						{
							blnDelete= true;
						}
					}
					if(blnDelete == true)
					{
						if (window.confirm(arrMessages[25]) == true)
						{//debugger;
							if(strDetail == 0)
							{
								/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
								if ("<%=m_strFromWhere%>" == "Proxy")
								{
									ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
								}
								//Added if condition by NitinC on 05 Jan 2011 for PMLifeLine (Issue Fix:58188)
								else if ("<%=strScrumFromWhere%>" == "WScrumTimeSheet")
						        {
                                    ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=WScrumTimeSheet&Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
						        }
						        //End of Added if condition by NitinC on 05 Jan 2011 for PMLifeLine (Issue Fix:58188)
								else
								{
									ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
								}
								/*Addition End by SantoshK on 20th March 2006*/
							
								//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
							}
							else
							{
								/*Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
								if ("<%=m_strFromWhere%>" == "Proxy")
								{
									ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=<%=m_strFromWhere%>&EmployeeID=<%=m_strSessionUserID%>&Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
								}
								//Added if condition by NitinC on 05 Jan 2011 for PMLifeLine (Issue Fix:58188)
								else if ("<%=strScrumFromWhere%>" == "WScrumTimeSheet")
						        {
                                    ObjForm.action = "TS_WeeklyTimesheet.aspx?Fromwhere=WScrumTimeSheet&Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail;
						        }
						        //End of Added if condition by NitinC on 05 Jan 2011 for PMLifeLine (Issue Fix:58188)
								else
								{
									ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
								}
								/*Addition End by SantoshK on 20th March 2006*/
							
								//ObjForm.action = "TS_WeeklyTimesheet.aspx?Mode=delete&MasterTagID=3583&ShowDetails=1&Detail=" + strDetail + "&DAID=" + GetObjectReference('frmWeeklyTimesheet', "hdnTaskID").value;
							}
						    //Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
						    setFrameLoader();  
						    //End Of Added By Vidya Jadhav ON 12 Oct 2016 Purpose::For Page Loader
							SubmitForm(ObjForm);	
						}
					}
				}
			}
			function Close_OnClick()
			{
				/*var ObjForm = GetFormReference('frmWeeklyTimesheet');
				ObjForm.action="TS_WeeklyTimesheet.aspx?FromWhere=DT&MasterTagID=3583";
				//ObjForm.submit();
				SubmitForm(ObjForm);*/
				//refreshParent('frmWeeklyTimesheet', 'TS_WeeklyTimesheet.aspx', 'TS_WeeklyTimesheet.aspx?FromWhere=DT&MasterTagID=3583');
				window.close();
			}
			function txtDuration_OnBlur(Obj,MaxEntry,OldValue,AllocatedW,ActualW,EntryOn,strWhichTask,dtmStartDate,dtmEndDate, dtmEntryDateNew)
			{
				//alert(AllocatedW);
				var strDAID = getDAID(Obj.id)
				var fltCurrentValue = parseFloat(Obj.value);
				var fltTot = getTotal();
				var strMsg="";
				var strMessage="";
				var strResponse = true;
				objHoursComplete = GetObjectReference('frmWeeklyTimesheet', Obj.id);
				<% If m_blnActualWorkHrs = False Then %>
	
					if (objHoursComplete.value.replace(/(^\s+|\s+$)/g, "") != "" && disallowNonNumeric(objHoursComplete, '', 0) == false)
					{
						objHoursComplete.value = (objHoursComplete.value-0).toFixed(2);
					}
					
					if (disallowBlank1(objHoursComplete , arrMessages[16], "frmWeeklyTimesheet") == true)
					{
						return;
					}
					
					if (disallowNonNumeric1(objHoursComplete , arrMessages[27], "frmWeeklyTimesheet") == true)
					{
						return;
					}
					
					//##Modified
					if (disallowValueRangeViolation1(objHoursComplete,0,MaxEntry ,arrMessages[6].replace('<=>',MaxEntry),"frmWeeklyTimesheet") == true)
					{
						objHoursComplete.value = (OldValue-0).toFixed(2);
						return;
					}
					if ( (((objHoursComplete.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((Obj.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
					{
						alert(arrMessages[20] + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
						Obj.value = (OldValue-0).toFixed(2);
						Obj.focus();
						return;
					}
				<% Else %>
					//If the value of the combobox is blank, then restore the previous value, and exit the subroutine. (i.e. Cancel the update.)
					if (Obj.value == "")
					{
						alert(arrMessages[16]);
						//objTextBox.value = FormatHours(dblPreviousValue)
						Obj.value = (OldValue-0).toFixed(2);
						return;
					}
				<% End If %>
				strProjectBackdateEntry = "<%=m_blnProjectBackdateEntry%>"
				strProjectFwddateEntry = "<%=m_blnProjectFwddateEntry%>"
				objEntryDate = GetObjectReference('frmWeeklyTimesheet','hdnEntryDate_' + strDAID);
				if(intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(objEntryDate.value), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0 )
						{
							alert(arrMessages[7]);
							objHoursComplete.value = OldValue.toFixed(2);
							return;
						}
					}
				}
				
				if(intFwdDating.length != 0)
				{
					if (strProjectFwddateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(objEntryDate.value), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert(arrMessages[7]);
							objHoursComplete.value = OldValue.toFixed(2);
							return;
						}
					}
				}
				dblTotalHoursForDay = EntryOn - OldValue + fltCurrentValue;
				if (dblTotalHoursForDay  > MaxEntry)
				{
					strMsg = arrMessages[21];
					strMsg = strMsg.replace('<=>',MaxEntry);
					strMsg = strMsg.replace('<==>',EntryOn);
					strMsg = strMsg.replace('<===>',(dblTotalHoursForDay - EntryOn));
					strMsg = strMsg.replace('<====>',MaxEntry);
					strMsg = strMsg.replace('<=====>',MaxEntry);
					alert(strMsg);
					//Get the excess hours entered.
					dblExcessHours = dblTotalHoursForDay - MaxEntry;
					
					//Subtract the excess hours from the combobox value, Total hours for that day, and Total hours for the Task.					
					if (((fltCurrentValue-0) - (dblExcessHours-0)) < 0)
					{
						Obj.value = '0.00';
					}
					else
					{
						Obj.value = ((fltCurrentValue-0) - (dblExcessHours-0)).toFixed(2);
					}
					
				}
				var blnPromptOnDurationChange = false;
				var blnRestrictDurationChange = false;		
				var blnDateViolation = false;
				var blnHoursViolation = false;		
				if(strWhichTask == "M")
				{
					blnPromptOnDurationChange = true;
					if(strRestrict_MPPTasks == 'True')
					{
						blnRestrictDurationChange = true;
						
					}
				}
				else if(strWhichTask == "O")
				{
					blnPromptOnDurationChange = true;
					if(strRestrict_AssignedTasks == 'True')
					{
						blnRestrictDurationChange = true;
					}
				}
				else if(strWhichTask == "B")
				{
					blnPromptOnDurationChange = true;
					if(strRestrict_AssignedTasks == 'True')
					{
						blnRestrictDurationChange = true;
					}
				}
				//Commented by AJ
				// Please refer to the comment in TS_WeeklyTimesheet.vb code -> DrawTaskDetail subroutine.
				// Search for this comment ...

				//dtmEntryDate = objEntryDate.value;
				if (blnRestrictDurationChange == true)
				{
					//If the entry had been made out of schedule, then...
					if( compareDates(dtmEntryDateNew, dtmStartDate) < 0 || compareDates(dtmEntryDateNew, dtmEndDate) > 0)
					{
						blnDateViolation = true;
						strMessage = 'Entry date for this task does not fall between the start date [' +  dtmStartDate + '] and end date [' + dtmEndDate + '].';
					}
				}
				
				// Check if the Total Hours exceed the allocated hours. If yes, then set the hours violation.
				var dblTotalHoursForTask = ActualW-OldValue + fltCurrentValue;
				if (fltCurrentValue > OldValue)
				{
					if(dblTotalHoursForTask > AllocatedW)
					{
						blnHoursViolation = true;
						strMessage = strMessage + '\nYou were allocated ' + AllocatedW + ' hour(s) to complete this task. With this entry, the total hours that will be booked against this task is ' + dblTotalHoursForTask + ' hour(s).';
					}
				}
				
				//If the entry date is not within the specified date range, or the actual work hours is exceeding the estimated hours, then pop up the message.				
				if(blnDateViolation==true || blnHoursViolation==true)
				{
					if(blnPromptOnDurationChange==true)
					{
						if(blnRestrictDurationChange==true)
						{
							strMessage = strMessage + 'Your project schedule may be affected. You will not be allowed to save this entry.'
							strResponse = alert(strMessage);
							Obj.value = (OldValue-0).toFixed(2);
							strResponse = false;
						}
						else
						{
							strMessage = strMessage + '\nYour project schedule may be affected. Do you want to continue?';
							strResponse = window.confirm(strMessage);
						}
					}
					else
					{
						strResponse = true;
					}
								
					if (strResponse == true)
					{
						GetObjectReference('frmWeeklyTimesheet', 'hdnDuCh_' + strDAID).value = "1";
					}
					
				}

				if (strResponse == false)
				{
					if (!isNaN((OldValue-0)))
					{
						Obj.value = (OldValue-0).toFixed(2);
					}
				}
				
			}
			function getTotal()
			{
				var flt=0.0;
				var objDAIDs = GetObjectReference('frmWeeklyTimesheet','hdnDAID',true);
				if (objDAIDs != null)
				{
					for(var i=0;i<objDAIDs.length-1;i++)
					{
						var objTxt = GetObjectReference('frmWeeklyTimesheet','txtDuration_' + objDAIDs[i]);
						if(objTxt != null)
						{
							flt = flt + parseFloat(objTxt.value);
						}
					}
				}
				return flt;
			}
			function  getDAID(strCellID)
			{
				var DAID;
				var startIndex = strCellID.indexOf("_") + 1;
				DAID = strCellID.substring(startIndex);
				return DAID;
			}
			function CallOnLoad()
			{
			}
			
			
        <%End If%>
	</SCRIPT>
	<%DrawAfterForm%>
<%--	<%END IF%>--%>
	</body>
</HTML>
