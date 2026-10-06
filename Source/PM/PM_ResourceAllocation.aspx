<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ResourceAllocation.aspx.vb" Inherits="PbNIT.PM_ResourceAllocation"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
          <script src="../../responsive/responsive.js"></script>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_ResourceAllocation" method="post" runat="server">
			<%PageInit%>
			<div id="divGraphs" style="DISPLAY:none;OVERFLOW:auto" runat="server">
				<Table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle">
				</Table>
			</div>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_ResourceAllocation');
		var objdivlist=GetObjectReference('frmPM_ResourceAllocation','PageDiv');
		var ObjRequestTypeId=GetObjectReference('frmPM_ResourceAllocation','cboRequest');
		var objproject=GetObjectReference('frmPM_ResourceAllocation','txtProject');
		var objRequestID=GetObjectReference('frmPM_ResourceAllocation','txtRequestID');
		
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
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	}
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
		}
		
		function Sort_OnClick(strFieldName, strAscOrDesc)
		{
			var objSortBy, objSortOrder;
			
			if (IsValidInput() == true)
			{
				objSortBy = GetObjectReference('frmPM_ResourceAllocation','txthidSortBy');
				objSortOrder = GetObjectReference('frmPM_ResourceAllocation','txthidSortOrder');
				objSortBy.value = strFieldName;
				objSortOrder.value = strAscOrDesc;
				objform.submit();
			}
		}
		//Trupti 28-May-09
	function comboChanged()
    {
        
        var objRequestID = GetObjectReference('frmPM_ResourceAllocation','txtRequestID');
			    if (objRequestID)
			    {        
			        if((isNumeric(objRequestID.value)==false || parseInt(objRequestID.value) < 0) && Trim(objRequestID.value) != "")
                    {
                        alert('Please enter positive numeric Request ID');
                        setFocus(objRequestID);
                        return;
                    }
                }
        objform.action="../PM/PM_ResourceAllocation.aspx?Status=" + ObjRequestTypeId.value + "&FromWhere=RM&MasterTagId=<%=m_lngTagId%>";
      
        objform.submit();
    }
		
		
		function Projectenter(e)
		{
			var code;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			if(code==13) 
			{
			    var objRequestID = GetObjectReference('frmPM_ResourceAllocation','txtRequestID');
			    if (objRequestID)
			    {        
			        if((isNumeric(objRequestID.value)==false || parseInt(objRequestID.value) < 0) && Trim(objRequestID.value) != "")
                    {
                        alert('Please enter positive numeric Request ID');
                        setFocus(objRequestID);
                        return;
                    }
                }
                
			    objform.action="../PM/PM_ResourceAllocation.aspx?Project=" + objproject.value + "&FromWhere=RM&MasterTagId=<%=m_lngTagId%>";
                objform.submit();
			}
			}
			
			function RequestIDenter(e)
			{
			var code;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			if(code==13) 
			{
			    var objRequestID = GetObjectReference('frmPM_ResourceAllocation','txtRequestID');
			    if (objRequestID)
			    {        
			        if((isNumeric(objRequestID.value)==false || parseInt(objRequestID.value) < 0) && Trim(objRequestID.value) != "")
                    {
                        alert('Please enter positive numeric Request ID');
                        setFocus(objRequestID);
                        return;
                    }
                }
			    objform.action="../PM/PM_ResourceAllocation.aspx?RequestID=" + objRequestID.value + "&FromWhere=RM&MasterTagId=<%=m_lngTagId%>";
                objform.submit();
			}
			}
			//End 28-May-09
		function Status_OnClick()
		{
			var objStatus, strType, intCnt;
			var strPrevStatus = "<%=m_strStatus%>";
			
			objStatus = GetObjectReference('frmPM_ResourceAllocation','optStatus', true);
			if (IsValidInput() == true)
			{
				objform.action = "../PM/PM_ResourceAllocation.aspx?Status=" + strChoice + "&FromWhere=RM&MasterTagId=<%=m_lngTagId%>";
				objform.submit();
			}
			else
			{
				for(intCnt=0; intCnt < objStatus.length; intCnt++)
				{
					if(objStatus[intCnt].value == strPrevStatus)
						objStatus[intCnt].checked = true;
					else
						objStatus[intCnt].checked = false;
				}
			}
		}
		
		function callDetail(itemid,showdrilldowns)
		{
			if (showdrilldowns == 1)
			{	
				window.open ("../CDB/CDB_DrillDown_Detail.aspx?FromWhere=RM&DashboardID=<%=DASHBOARD_ID%>&ItemID=" + itemid , "_drillDown","left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
			}
			window.status = "View drill downs";
		}
		
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
			window.open("../CDB/CDB_DrillDown_Detail.aspx?FromWhere=RM&DashboardID=<%=DASHBOARD_ID%>&ItemID=" + itemid + "&colname=" + replaceSubstring(URLEncode(colname),"|||","'") + "&colvalue=" + replaceSubstring(URLEncode(colvalue),"|||","'") , "_drillDown","left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
			window.status = "View drill downs";
		}
		/*
		function Summary_OnClick()
		{
			window.open("../HR/HR_ResourceSkill_Summary.aspx","_blank","Left=150,Top=150,height=350,width=600,status=no,toolbar=no,menubar=no,location=no,scrollbars=yes");
		}*/
		
		function ExtendBooking(intRequestID)
			{
							
				var intCnt,status;
				objopt = GetObjectReference('frmPM_ResourceAllocation','optStatus',1);
				for(intCnt=0; intCnt < objopt.length; intCnt++)
			{
				if(objopt[intCnt].checked)
					status = objopt[intCnt].value;
					alert(status);
			}
				
				if (ObjRequestTypeId.value=='P')
				window.open("../PM/PM_PreponeBooking.aspx?Mode=Assign&RequestID=" + intRequestID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=450,width=650");
				else
				window.open("../PM/PM_ExtendBooking.aspx?Mode=Assign&RequestID=" + intRequestID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=450,width=650");
						
			}
		
		function Display_Details(intRequestID,RequestType)
		{
							
				var intCnt,status;
				objopt = GetObjectReference('frmPM_ResourceAllocation','optStatus',1);

				for(intCnt=0; intCnt < objopt.length; intCnt++)
			{
				if(objopt[intCnt].checked)
					status = objopt[intCnt].value;
			}
				
				if(ObjRequestTypeId.value=='P' || RequestType=='Prepone')
				window.open("../PM/PM_PreponeBooking.aspx?Mode=Assign&RequestID=" + intRequestID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=450,width=650");
				else if (ObjRequestTypeId.value=='E' || RequestType=='Extend')
				window.open("../PM/PM_ExtendBooking.aspx?Mode=Assign&RequestID=" + intRequestID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=450,width=650");
				else if (ObjRequestTypeId.value=='CHANGE' || RequestType=='C')
				window.open("../PM/PM_ChangeAllocationType.aspx?Mode=Assign&RequestID=" + intRequestID,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=450,width=650");
				else
				    //Commented added by Shamkant s on 16 Feb 2016
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'PM_ResourceAllocation.aspx/Request_OnClick',
				        data: JSON.stringify({ RequestID:intRequestID }),
				        success: function (Result) {
				            window.open("../PM/PM_ResourceAllocationDetails.aspx?Token=" + Result.d + "&RequestID=" + intRequestID ,"_blank","resizable=yes,scrollbars=no,Left=30,Top=50,height=520,width=950");
				           
				        },
				        error: function () {
				            //     alert("Error")
				        }
				    });
		    //Commented Ended by Shamkant s on 16 Feb 2016
				//window.open("../PM/PM_ResourceAllocationDetails.aspx?RequestID=" + intRequestID ,"_blank","resizable=yes,scrollbars=no,Left=30,Top=50,height=520,width=950");
		}
		
		function ViewRequestDetails(intRequestID)
		{
			window.open("../General/CommonPage.aspx?MasterTagID=1223&RequestID=" + intRequestID.toString() ,"_blank","resizable=yes,scrollbars=no,Left=100,Top=75,height=590,width=800");
		}
		
		function ViewComments(intRequestID)
		{
			var objStatus, strType, intCnt;
			objStatus = GetObjectReference('frmPM_ResourceAllocation','optStatus', true);
			for(intCnt=0; intCnt < objStatus.length; intCnt++)
			{
				if(objStatus[intCnt].checked)
					strType = objStatus[intCnt].value;
			}
			window.open("../HR/HR_AddComments.aspx?From=ResourceAllocation&Mode=SHOW_COMMENTS&RequestID=" + intRequestID + "&RequestType=" + ObjRequestTypeId.value,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}
		
		function Show_OnClick()
		{
			if (IsValidInput() == true)
			{
				objform.action = "../PM/PM_ResourceAllocation.aspx?Status=<%=m_strStatus%>&FromWhere=RM&MasterTagId=<%=m_lngTagId%>";
				objform.submit();
			}
		}
		
		function EscalateRequest_OnClick(lngRequestID)
		{
		
		   			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2021&RequestID=" + lngRequestID.toString(),"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_RM_OnClick(lngRequestID, blnIsEscalatedFromOUPool)
		{
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2058&RequestID=" + lngRequestID.toString(),"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_OUM_OnClick(lngRequestID,Manager,level,BG)
		{
		    
		    if (Manager=="" && level=='GRP')
		    {
		        alert("Please set Global Resource Pool Manager");
		        return;
		       
		    }
		    
		     else if (Manager=="")
		    {
		         var strMsg='Please set Manager for Business Group <=>'
		         strMsg = replaceSubstring(strMsg, '<=>',"'"+ BG + "'"); 
		         alert(strMsg);
		        return;
		       
		    }
		    
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2027&RequestID=" + lngRequestID.toString(),"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_BGM_OnClick(lngRequestID,Manager,level)
		{
		     if (Manager=="")
		    {
		        alert("Please set Global Resource Pool Manager");
		        return;
		        
		    }
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2078&RequestID=" + lngRequestID.toString(),"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}
		
		function Reminder_OnClick(lngRequestID)
		{
			window.open("../General/SendEmail.aspx?MessageID=<%=m_intMessageID%>&EmployeeID=<%=m_lngUserID%>&RequestID=" + lngRequestID,"","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
		}
		
		function IsValidInput()
		{
			var objFromDate, objToDate;
			
			objFromDate = GetObjectReference('frmPM_ResourceAllocation','txtFromDate');
			objToDate = GetObjectReference('frmPM_ResourceAllocation','txtToDate');
			objRequestID=GetObjectReference('frmPM_ResourceAllocation','txtRequestID');
			if(disallowDate1GreaterThanDate2(objFromDate, objToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
				return false;
			if (disallowNegativeInteger(objRequestID)==true)
				{	alert('Please enter only positive integer value for Request ID');
					return false;
				}
			return true;
		}
		
		/*Commented by SuchitraP on 21 Feb 2008
		<%'Added by ArchanaN on 5 Nov 2007 for Opportinity Details tab%>
		function ItemTab_OnClick(strWhich)
		{ 
			if (strWhich =='Opportunity')
				window.location.href = '../HR/HR_OpportunityDetails_CommonList.aspx?FromWhere=RM&MasterTagId=3866';
		}*/	
		</Script>
	</body>
</HTML>
