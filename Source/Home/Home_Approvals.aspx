<%@ Page Language="vb" EnableViewState="false" AutoEventWireup="false" Codebehind="Home_Approvals.aspx.vb" Inherits="PbNIT.Home_Approvals" %>
<HTML>
<%  PlotHeadTag()%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
	<BODY MS_POSITIONING="clsFullPageBody" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<FORM id="frm_Approvals" name ='frm_Approvals' method="post" runat="server">
				<DIV id="divTbl" runat="server" style="width: 10px;height:150px;display:none;overflow:hidden;border:black 1px outset;">
				<TABLE class="clsGridTable" id="tbl_popup">
					<TR class="clsTRBlankNEW">
						<Div name='fieldset1' id='fieldset1'></Div>
					</TR>
				</TABLE>
			</DIV>
			
			<%BuildPage()%>	
			<INPUT type="hidden" name="txtContentTab" id="txtContentTab" runat="server">
			
		<div id="divComments" style="width: 10px;height:150px;display:none;overflow:hidden;border:black 1px outset;">
        <table class='clstable' cellspacing=0 cellpadding=0 style='height:99.99%;'>
        <tr class='clstreven'><td><b>Comments</b></td></tr>
        <tr class='clstreven'><td>
        <textarea wrap='hard'  name='txtGlobalcomments' id='txtGlobalcomments' maxlength='1000'  class='clstextarea' style="width:350px; height:70px; text-align:left" rows='5' cols ='20'></textarea>
        </td></tr>
        <tr class='clstreven'><td><input type='button' id= 'btnGlobalok' name= 'btnGlobalok' value = 'Apply To All' style ="font-size:12px; width:100px" onclick = 'Globalok_onclick()'/> 
        <input type='button' id= 'btnGlobalcancel' name= 'btnGlobalcancel' style ="font-size:12px;width:60px" value = 'Cancel' onclick = 'Globalcancel_onclick()'/>
        </td></tr></table>
        </div>

		</FORM>
		<SCRIPT language="javascript">
		
		var objform=GetFormReference('frm_Approvals');
		var objfield = document.getElementById("fieldset1");
		var objDivMain=GetObjectReference('frm_Approvals','PageDiv');
		var objContentTab=GetObjectReference('frm_Approvals','txtContentTab');
		var objTabName=GetObjectReference('frm_Approvals','txtTabName');
		var objXMLHTTP;

		function ContentTab(TabName)
		{
			objContentTab.value = TabName;
			objform.action = "Home_Approvals.aspx?FromWhere=HOME";
			objform.submit();
		
		
		}
		function Logout(strLogoutPage)
		{
			window.open(strLogoutPage,"_top")
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			var intCnt;
			document.body.style.visibility='visible';
			
			/*if (objDivLeave!=null
				objDivLeave.style.visibility='visible';
			if (objDivProject!=null
				objDivProject.style.visibility='visible';*/
				
			if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				 {
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 30;
				 }
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 30;
				}
			 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight +'px';
				
				
			}
						
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);			
			// FOR IR APPROVALS
			var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);
			// FOR EXPENSE APPROVALS
			var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS
			var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);
			// FOR PROJECT TIMESHEET APPROVALS
			var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);
			
			if ( objCheckboxLShow != null)
				OnLoadSettings(objCheckboxLShow)
			if ( objCheckboxIRShow != null)
				OnLoadSettings(objCheckboxIRShow)
			if ( objCheckboxEShow != null)
				OnLoadSettings(objCheckboxEShow)
			if ( objCheckboxPShow != null)
				OnLoadSettings(objCheckboxPShow)
			if ( objCheckboxPTShow != null)
				OnLoadSettings(objCheckboxPTShow)
			if ( objCheckboxRTShow != null)
				OnLoadSettings(objCheckboxRTShow)
			
			window.location.href.refresh;			
			
		 }
		 function OnLoadSettings(objCheckboxShow)
		 {
		 
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
					GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					 
		 }
		 
		function Back_OnClick()
		{
			window.location.href ="HRHome.aspx?Fromwhere=HOME";
		}
		
		function DisplayComment(intGridNo,evt,UniqueID)
		{	
			var url;
			var objTblpopup;
			evt = evt || window.event;
			var source=evt.target||evt.srcElement;
			var mouseXY;
			var objDivpopup;
			var intUniqueID ;
			var objComment;
			
			mouseXY=mouseCoords(evt);
			intUniqueID = UniqueID;
			loadComment(intUniqueID,intGridNo);				
			objDivpopup = document.getElementById("divTbl");
			objTblpopup = document.getElementById("tbl_popup");
						
			objDivpopup.style.position = 'absolute';
			objDivpopup.style.left = mouseXY.x- 391;
			objDivpopup.style.top  = 150;
			objDivpopup.style.width  = '325px';
			objDivpopup.style.height  = '130px';
			objDivpopup.style.display  = '';
					var objT = GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID);
			objT.focus();
			objT.select();
			
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);
			 if (objCheckboxShow!=null)
			 {					
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
						if (intUniqueID==objCheckboxShow[intCnt].value)
						{
							GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "30";
							GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "25";	
						}
						else
						{
							if(Right(GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src,14)== '../../Imeges/Home/Details.gif')
							{
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
							else
							{
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
						}
					}			
				}
			}	
		}
		function GetCheckboxShowObject(intGridNo)
		{
			var objCheckboxShow
			switch(intGridNo)
			{
				case 1: // FOR LEAVE APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkLeaveShow',true);
					break    
				case 2: // FOR IR APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkIRShow',true);
					break
				case 3: // FOR EXPENSE APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkExpenseShow',true);
					break
				case 4: // FOR PROJECT APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkProjectShow',true);
					break
				case 5: // FOR PROJECT TIMESHEET APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);
					break 
				case 6: // FOR RESOURCE TIMESHEET APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);
					break
						
			}
			
			return objCheckboxShow;
		}
		function loadComment(intUniqueID,intGridNo)
		{
			var strElement;	
			var m_UniqueID="";
			var objid = GetObjectReference('frm_Approvals','txt_' + intUniqueID);
			
			if (objid == null) 
				m_UniqueID = ""
			else
				m_UniqueID = objid.value;
				
				strElement	=	'<br><b>Comment</b><br><br><textarea wrap=Hard  name="txtUniqueID'+ intUniqueID + '" id="txtUniqueID' + intUniqueID + '" maxlength=1000 class=clsTextArea style="width:325px; height:70px; text-align:Left"; rows=5; cols =20>'+ m_UniqueID + '</textarea>';
				strElement	+= '<br><span style="text-align:center"><input type=button id=btnOK name=btnOK Value = "  OK   " style ="font-size:11px;width=60px" onClick = getComment_Onclick("' + intUniqueID + '",' + intGridNo + ')>';
				strElement	+= '<input type=button id= btnCancel name= btnCancel style ="font-size:11px;width=60px" Value = CANCEL onClick = cancel_OnClick("' + intUniqueID + '",' + intGridNo + ')> </span>';
				objfield.innerHTML = strElement;	
				GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "30";
				GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "25";
				
						
		}
		function cancel_OnClick(intUniqueID,intGridNo)
		{
			var objDivpopup = document.getElementById("divTbl");
			if(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value.length > 1000)
			{ 
				GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = ""
			}
			if (disallowBlank(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID),'',true))
			{ GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = ""
			}
			if (GetObjectReference('frm_Approvals','txt_'+intUniqueID).value == "")
			{ 
				GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/Details.gif'
			}
			objDivpopup.style.display="none"; 	
			
						
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);	
			if (objCheckboxShow!=null)
			{		
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if(Right(GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src,14)== '../../Imeges/Home/Details.gif')
					{
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
					}
					else
					{
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
					}
				}
			}
		}
		function mouseCoords(ev)
		{
			if(ev.pageX || ev.pageY){
			return {x:ev.pageX, y:ev.pageY};
			}
			return {
				x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:ev.clientY + document.body.scrollTop  - document.body.clientTop - 40
			};
		}
		function getComment_Onclick(intUniqueID,intGridNo)
		{		
			var strElement;	
			var chkcomment;
			var intCnt;
			var objDivpopup = document.getElementById("divTbl");
			objid = GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID);
			GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = objid.value;

			if(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value.length > 1000)
			{
				alert("Comment should not be more than 1000 characters.");
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).focus();			
				return; 
			}
			
			if (disallowBlank(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID),'&#39;Comment&#39; should not be left blank.',true) )
			{ 
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value= "";
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).focus();
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).select();
				return; 
			}
			
			objDivpopup.style.display="none";		
			GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/page.gif';														
			GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "22";
			GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "17";	
					
		}
		function chkShow_OnClick(intUniqueID,intGridNo)
		{		
		
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);	
			if (objCheckboxShow!=null)
			{	
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
							GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;
					}
					else
					{
						GetObjectReference('frm_Approvals','txt_'+objCheckboxShow[intCnt].value).value = "";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src = '../../Images/Home/Details.gif';
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					}			
				}
			}
		}
		var noOfPages ;
		var objtxtpageNumber;
		function validateNumPaging(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
						
			if(isNaN(objtxtpageNumber.value))
			{
				alert("Please enter numeric value");
				return false;
			}
			
			if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
			{
				alert("Please enter value within range of 1 to "+noOfPages);
				return false;
			}
			return true;
		}			
		function ShowPreviousPage(intGridNo)
		{	
		
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
							
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
					objtxtpageNumber.value=objtxtpageNumber.value -1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
		}
		function ShowFirstPage(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
						
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				objtxtpageNumber.value=1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
			
			
		}
		function ShowNextPage(intGridNo)
		{	
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
					
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
					objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}	
		}
		function ShowLastPage(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
							
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(noOfPages,intGridNo);
			else
			{	
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				objtxtpageNumber.value=noOfPages;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
		}
		function NumPage_OnClick(page,intGridNo)
		{
			
			var LeavePage				= pagingSettings(page,intGridNo,1); // FOR LEAVE APPROVALS
			var IRPage					= pagingSettings(page,intGridNo,2); // FOR IR APPROVALS
			var ExpensePage				= pagingSettings(page,intGridNo,3); // FOR EXPENSE APPROVALS
			var ProjectPage				= pagingSettings(page,intGridNo,4); // FOR PROJECT APPROVALS
			var ProjectTimeSheetPage	= pagingSettings(page,intGridNo,5); // FOR PROJECT TIMESHEET APPROVALS
			var ResourceTimeSheetPage	= pagingSettings(page,intGridNo,6); // FOR RESOURCE TIMESHEET APPROVALS
			
			window.location.href.refresh;
			objform.action = "Home_Approvals.aspx?FromWhere=SM&MasterTagID=<%=m_lngTagID%>&LeavePageNumber="+ LeavePage + "&IRPageNumber="+ IRPage+ "&ExpensePageNumber="+ ExpensePage+ "&ProjectPageNumber="+ ProjectPage+"&ProjectTimeSheetPageNumber="+ ProjectTimeSheetPage+"&ResourceTimeSheetPageNumber="+ ResourceTimeSheetPage;
			//objform.action = "Approvals.aspx?FromWhere=SM&MasterTagID=<%=m_lngTagID%>&LeavePageNumber="+ LeavePage +"&ResourceTimeSheetPageNumber="+ ResourceTimeSheetPage;
			objform.submit();
		}
		function pagingSettings(page,intGridNo,intCallForGrid)
		{
			var pageNumber = -2;
			if (GetObjectReference('frm_Approvals','txtPageNumber'+intCallForGrid)!=null)
			{	
				if(page ==  "-1" && intGridNo == intCallForGrid)
					pageNumber	= -1;
				else if (page == 1 && intGridNo == intCallForGrid)
					pageNumber	= 1;
				else
					pageNumber	=  GetObjectReference('frm_Approvals','txtPageNumber'+intCallForGrid).value;
				if(pageNumber=="")
					pageNumber	= -1;
			}
			return pageNumber;
		
		}
		function txtPageNumber_KeyPress(e,intGridNo)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				objtxtpageNumber =  GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
				objtxtNoOfPages = GetObjectReference('frm_Approvals','txtNoOfPages'+intGridNo);
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Please enter value less than or equal to " +objtxtNoOfPages.value);
						return;
					}
					NumPage_OnClick(objtxtpageNumber.value,intGridNo);
				}	
			}
		
		}
		function SelectAll_OnClick()
		{	
			SelectAllCheckboxs('frm_Approvals','chkLeaveShow');			   // FOR LEAVE APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkIRShow');				   // FOR IR APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkExpenseShow');		   // FOR EXPENSE APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkProjectShow');		   // FOR PROJECT APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkProjectTimeSheetShow');  // FOR PROJECT TIMESHEET APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkResourceTimeSheetShow'); // FOR RESOURCE TIMESHEET APPROVALS
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);
			// FOR EXPENSE APPROVALS				
			var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);	
			// FOR PEROJECT APPROVALS		
			var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);		
			// FOR PROEJECT TIMESHEET APPROVALS	
			var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				SelectAllSettings(objCheckboxLShow)
			if (objCheckboxIRShow!=null)
				SelectAllSettings(objCheckboxIRShow)
			if (objCheckboxEShow!=null)
				SelectAllSettings(objCheckboxEShow)
			if (objCheckboxPShow!=null)
				SelectAllSettings(objCheckboxPShow)
			if (objCheckboxPTShow!=null)
				SelectAllSettings(objCheckboxPTShow)
			if (objCheckboxRTShow!=null)
				SelectAllSettings(objCheckboxRTShow)
			
		}
		function ClearAllOnClick()
		{
			ClearAll_OnClick('frm_Approvals','chkLeaveShow');			// FOR LEAVE APPROVALS
			ClearAll_OnClick('frm_Approvals','chkIRShow');				// FOR IR APPROVALS
			ClearAll_OnClick('frm_Approvals','chkExpenseShow');			// FOR EXPENSE APPROVALS
			ClearAll_OnClick('frm_Approvals','chkProjectShow');			// FOR PROJECT APPROVALS
			ClearAll_OnClick('frm_Approvals','chkProjectTimeSheetShow');	// FOR PROJECT TIMESHEET APPROVALS
			ClearAll_OnClick('frm_Approvals','chkResourceTimeSheetShow');// FOR RESOURCE TIMESHEET APPROVALS
			
			// to disable the comment while unselecting all the checkboxes using "Clear All" link
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);	
			// FOR EXPENSE APPROVALS			
			var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS			
			var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);			
			// FOR PROJECT TIMESHEET APPROVALS
			var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				ClearAllSettings(objCheckboxLShow);
			if (objCheckboxIRShow!=null)
				ClearAllSettings(objCheckboxIRShow);
			if (objCheckboxEShow!=null)
				ClearAllSettings(objCheckboxEShow);
			if (objCheckboxPShow!=null)
				ClearAllSettings(objCheckboxPShow);
			if (objCheckboxPTShow!=null)
				ClearAllSettings(objCheckboxPTShow);
			if (objCheckboxRTShow!=null)
				ClearAllSettings(objCheckboxRTShow);
			
		}
		function SelectAllSettings(objCheckboxShow)
		{
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;		
			}
		}
		function ClearAllSettings(objCheckboxShow)
		{
		
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src = '../../Images/Home/Details.gif';
				GetObjectReference('frm_Approvals','txt_'+objCheckboxShow[intCnt].value).value = "";
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;		
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";
			}
		
		}
		var isCheckedAtLeastOne = false;
		function Approve_OnClick()
		{
			isCheckedAtLeastOne = false;
			// FOR LEAVE APPROVALS
			var objCheckLboxShow	= GetObjectReference('frm_Approvals','chkLeaveShow', true);	
			// FOR IR APPROVALS			
			var objCheckIRboxShow	= GetObjectReference('frm_Approvals','chkIRShow', true);	
			// FOR EXPENSE APPROVALS				
			var objCheckEboxShow	= GetObjectReference('frm_Approvals','chkExpenseShow', true);
			// FOR PROJECT APPROVALS			
			var objCheckPboxShow	= GetObjectReference('frm_Approvals','chkProjectShow', true);		
			// FOR PROJECT TIMSHEET APPROVALS	
			var objCheckPTboxShow	= GetObjectReference('frm_Approvals','chkProjectTimeSheetShow', true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckRTboxShow	= GetObjectReference('frm_Approvals','chkResourceTimeSheetShow', true);	
			
			
			if (objCheckLboxShow != null){	// FOR LEAVE APPROVALS
				if (validateSelectedCheckBox(objCheckLboxShow,"LEAVE")==false)
					return;}
			if (objCheckIRboxShow != null)	// FOR IR APPROVALS		
				if (validateSelectedCheckBox(objCheckIRboxShow,"IR")==false)
					return;
			if (objCheckEboxShow != null)	// FOR EXPENSE APPROVALS
				if (validateSelectedCheckBox(objCheckEboxShow,"EXPENSE")==false)
					return;
			if (objCheckPboxShow != null)	// FOR PROJECT APPROVALS
				if (validateSelectedCheckBox(objCheckPboxShow,"PROJECT")==false)
					return;
			if (objCheckPTboxShow != null)	// FOR PROJECT TIMSHEET APPROVALS
				if (validateSelectedCheckBox(objCheckPTboxShow,"PROJECT TIMESHEET")==false)
					return;
			if (objCheckRTboxShow != null){	// FOR RESOURCE TIMESHEET APPROVALS
				if (validateSelectedCheckBox(objCheckRTboxShow,"RESOURCE TIMESHEET")==false)
					return;}
			if ( isCheckedAtLeastOne == false)
			{
				alert("Please select at least one checkbox to approve");
				return;
			}
			else
			{			
				window.location.href.refresh;
				//objform.action = "Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				if(confirm("Are you sure, Do you want to approve all selected records.?")){
				//objform.action = "Home_Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				objform.action = "../Home/Home_Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				
				objform.submit();}
			}
		
		}
		function validateSelectedCheckBox(objCheckboxShow,strTab)
		{
			var intUniqueID;
			var strTitle;
			//debugger;
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == false)
					continue;
				else
				{
					isCheckedAtLeastOne = true;
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frm_Approvals','Title_'+intUniqueID).value;
					
					/*if (GetObjectReference('frm_Approvals','txt_'+intUniqueID).value == "")
					{
						//alert("Comment should not be left blank to '"+strTitle+"'.");
						GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/Details.gif';								
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;
						return false;	
					} 
					else */
					if(GetObjectReference('frm_Approvals','txt_'+intUniqueID).value.length > 1000)
					{
						alert("Comment should not be more than 1000 characters for '"+strTitle+"' Initiative.");
						return false;
					}
				
					
					if(GetObjectReference('frm_Approvals','txt_'+intUniqueID).value=='' && (strTab=="IR" || strTab=="PROJECT TIMESHEET" || strTab=="PROJECT"))
					{
					    alert('Please enter approval comments !');
					    return false;
					}   
					
				}
			}
			if (isCheckedAtLeastOne == false)
				return true;
		
		}
		function ApplyComment(strTab)
		{
			//debugger;
			var intCnt;
			var objtxtComment = GetObjectReference('frm_Approvals','txtComments');
			switch(strTab)
			{
			case "LEAVE" :
				var objCheckboxShow	= GetObjectReference('frm_Approvals','chkLeaveShow',true);	
				break;
			case "RESOURCE TIMESHEET" :
				var objCheckboxShow	= GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
				break;
			}
			
			var objComment;
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
				{
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frm_Approvals','Title_'+intUniqueID).value;
					objComment = GetObjectReference('frm_Approvals','txt_'+intUniqueID);
					if(objComment!=null && objtxtComment!=null)
					{
						GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/Page.gif';								
						objComment.value = objtxtComment.value;
					}
					
				}
			}
		}
		
		function Comments_OnClick()
		{
		
		var objDivComments= GetObjectReference("frmCommonPage","divComments");
		objDivComments.style.width  = '305px';
		objDivComments.style.height  = '150px';
	    objDivComments.style.left =500;
	    objDivComments.style.top =20;
	    objDivComments.style.position ='absolute';
		objDivComments.style.display  = '';

		}
		
		function Globalcancel_onclick()
		{
		    var objDivComments= GetObjectReference("frmCommonPage","divComments");
		    objDivComments.style.display  = 'none';
		}
		function Globalok_onclick()
		{
		var intCnt;
		var strContentValue;
		var objtxtComment = GetObjectReference('frm_Approvals','txtGlobalcomments');
		strContentValue = '';
		if (objContentTab.value == '')
		        objContentTab.value = 'LEAVE';

        strContentValue = (objContentTab.value).toUpperCase();
        
		    strContentValue = strContentValue.replace('+','_');
			switch(strContentValue)
			{
			case "LEAVE" :
				var objCheckboxShow	= GetObjectReference('frm_Approvals','chkLeaveShow',true);	
				break;
			case "RESOURCE_TIMESHEET" :
				var objCheckboxShow	= GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
				break;
			}
			var objComment;
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
				{
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frm_Approvals','Title_'+intUniqueID).value;
					objComment = GetObjectReference('frm_Approvals','txt_'+intUniqueID);
					if(objComment!=null && objtxtComment!=null)
					{
					    GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/Page.gif';								
						objComment.value = objtxtComment.value;
					}
					
				}
			}
			
		var objDivComments= GetObjectReference("frmCommonPage","divComments");
		objDivComments.style.display  = 'none';
		
		}
        function Filter_OnClick()
        {
            objdivFilters=GetObjectReference('frmMyTaskList','divFilters');
            if(objdivFilters.style.display == '')
            {
                objdivFilters.style.display='none';
            }
            else
            {
            objdivFilters.style.display='';
            objdivFilters.style.left =600;
	        objdivFilters.style.top =20;
	        objdivFilters.style.position ='absolute';
            }
        }
        function applyFilter(intFlag)
        {
   		    var objcboproject=GetObjectReference('frmMyTaskList','cboProject');
		    //var objcboTaskTypeFilter=GetObjectReference('frmMyTaskList','cboType');

  	         if(parseInt(intFlag)==1)
	         {
			    objcboproject.value='';
			    //objcboTaskTypeFilter.value='';
	         }
		        objform.action = "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
			    objform.submit();
        }
        function Back_OnClick()
		{
			window.location.href ="HRHome.aspx?Fromwhere=HOME";
		}
		function MyTaskList_Click()
        {
	        window.location.href = "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
        }
        function Approval_Click()
        {
	        window.location.href = "../Home/Home_Approvals.aspx?FromWhere=HOME";
        }
        function LastUpdated_Click()
        {
        //window.location.href = url+"&From_Where=HRHome";
        }
        function ShowDetail(intGridNo,PKToken,UniqueID,EmployeeID)
        {
            switch(intGridNo)
			{
				case 1: // FOR LEAVE APPROVALS
					window.open ("../HR/MyLeaves_CommonPage.aspx?LeaveID_PK="+UniqueID+"&PKToken="+PKToken+"&FromWhere=RM&MasterTagID=1208&ParentTagID=0&FromCL=1","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break    
				case 2: // FOR IR APPROVALS
				    window.open ("../RFI/RFI_RFI.aspx?Mode=Edit&UserType=Approver&RFIID="+UniqueID+"&PKToken="+PKToken+"","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break
				case 3: // FOR EXPENSE APPROVALS
				    window.open ("../EWF/EWF_ExpenseSheet.aspx?Mode=EDIT&MasterTagID=3595&PkToken=" + PKToken + "&ExpenseSheetID=" + UniqueID + "&Actor=1" ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break
				case 4: // FOR PROJECT APPROVALS
					 window.open ("../General/CommonPage.aspx?ProjectID_PK="+UniqueID+"&PKToken="+PKToken+"&MasterTagID=32&FromWhere=PM&ParentTagID=0&FromCL=1","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break
				case 5: // FOR PROJECT TIMESHEET APPROVALS
				    window.open ("../FA/FA_TimesheetListing.aspx?ProjectID=NULL&NumberClick=NumberClick&TimeSheetAllOrCurrent=&strRejectedStatus=&AllTimesheet=YES&Mode=Details&MasterTagId=42&TimeSheetNo=" + UniqueID + "&PKToken=" + PKToken + "","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break 
				case 6: // FOR RESOURCE TIMESHEET APPROVALS
				    window.open ("../RT/RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=" + UniqueID + "&EmployeeID=" + EmployeeID + "&TimesheetStatus=R&PKToken=" + PKToken + "&TagID=2125","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					break
						
			}
        }
        function Scheduled_Tasks(intGridNo,UniqueID,EmployeeID,FromDate,ToDate)
        {
                if (intGridNo==1){
                           window.open ("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeID="+EmployeeID+"&FromDate="+FromDate+"&ToDate="+ToDate+"","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					            
                }
        
        }
        function Reject_OnClick()
		{
			isCheckedAtLeastOne = false;
			// FOR LEAVE APPROVALS
			var objCheckLboxShow	= GetObjectReference('frm_Approvals','chkLeaveShow', true);	
			// FOR IR APPROVALS			
			var objCheckIRboxShow	= GetObjectReference('frm_Approvals','chkIRShow', true);	
			// FOR EXPENSE APPROVALS				
			var objCheckEboxShow	= GetObjectReference('frm_Approvals','chkExpenseShow', true);
			// FOR PROJECT APPROVALS			
			var objCheckPboxShow	= GetObjectReference('frm_Approvals','chkProjectShow', true);		
			// FOR PROJECT TIMSHEET APPROVALS	
			var objCheckPTboxShow	= GetObjectReference('frm_Approvals','chkProjectTimeSheetShow', true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckRTboxShow	= GetObjectReference('frm_Approvals','chkResourceTimeSheetShow', true);	
			
			
			if (objCheckLboxShow != null){	// FOR LEAVE APPROVALS
				if (validateSelectedCheckBoxForReject(objCheckLboxShow)==false)
					return;}
			if (objCheckIRboxShow != null)	// FOR IR APPROVALS		
				if (validateSelectedCheckBoxForReject(objCheckIRboxShow)==false)
					return;
			if (objCheckEboxShow != null)	// FOR EXPENSE APPROVALS
				if (validateSelectedCheckBoxForReject(objCheckEboxShow)==false)
					return;
			if (objCheckPboxShow != null)	// FOR PROJECT APPROVALS
				if (validateSelectedCheckBoxForReject(objCheckPboxShow)==false)
					return;
			if (objCheckPTboxShow != null)	// FOR PROJECT TIMSHEET APPROVALS
				if (validateSelectedCheckBoxForReject(objCheckPTboxShow)==false)
					return;
			if (objCheckRTboxShow != null){	// FOR RESOURCE TIMESHEET APPROVALS
				if (validateSelectedCheckBoxForReject(objCheckRTboxShow)==false)
					return;}
			if ( isCheckedAtLeastOne == false)
			{
				alert("Please select at least one checkbox to reject");
				return;
			}
			else
			{			
				window.location.href.refresh;
				//objform.action = "Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				if(confirm("Are you sure, Do you want to reject all selected records.?")){
				//objform.action = "Home_Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=REJECTED";
				objform.action = "../Home/Home_Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=REJECTED";
				objform.submit();
				}
			}
		
		}
		function validateSelectedCheckBoxForReject(objCheckboxShow)
		{
			var intUniqueID;
			var strTitle;
			//debugger;
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == false)
					continue;
				else
				{
					isCheckedAtLeastOne = true;
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frm_Approvals','Title_'+intUniqueID).value;
					
					if (GetObjectReference('frm_Approvals','txt_'+intUniqueID).value == "")
					{
						alert("Comment should not be left blank to '"+strTitle+"'.");
						GetObjectReference('frm_Approvals','img_'+intUniqueID).src = '../../Images/Home/Details.gif';								
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;
						return false;	
					} 
					else
					if(GetObjectReference('frm_Approvals','txt_'+intUniqueID).value.length > 1000)
					{
						alert("Comment should not be more than 1000 characters for '"+strTitle+"'.");
						return false;
					}
					/*var objcmt=GetObjectReference('frm_Approvals','txt_'+intUniqueID);
					if(objcmt!=null)
					{
					    if(objcmt.value=='')
					    {
					        alert("Please enter rejection comment !");
					        return false;
					    }
					} */   
					
				}
			}
			if (isCheckedAtLeastOne == false)
				return true;
		
		}
		function Hyperlink1(EmployeeId,ExpenseSheetID)
        {

        window.open ("../General/CommonList.aspx?MasterTagID=3599&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ActorType=Approver&EmployeeId=" + EmployeeId + "&ExpenseSheetID=" + ExpenseSheetID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=300,height=300");
        }
        </SCRIPT>
	</BODY>
</HTML>
