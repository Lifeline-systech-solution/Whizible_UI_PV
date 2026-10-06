<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_IssueEntry.aspx.vb" Inherits="PbNIT.IB_IssueEntry"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%PlotPageHeadTag()%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
  
	<body class="clsPageBody" MS_POSITIONING="GridLayout" onload="Window_OnLoad()" onresize="Window_OnResize()">
		
					<form id="frmIBIssueEntry" method="post" runat="server">
									<%BuildPage()%>
					</form>

<script language="javascript">
		var RenderedTime;
		var RenderedMin;
		var RenderedHr;
		//Added by TruptiK on 7-Jan-09
		var objchkDelete;	
		//Comment and modification by SuchitraP on 13-Mar-2009 for IssueID 29289
		//Purpose : User is not able to delete the attachment [Mozilla]
		//objchkDelete = GetObjectReference('frmIBIssueEntry','chkDelete',true);
		objchkDelete = GetObjectReference('frmIBIssueEntry','ChkDelete',true);
		//End of Comment and modification by SuchitraP
		 //End of addition by TruptiK on 7-Jan-09
		 
		     <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		 
	function Priority_OnChange()
 { 
	var objPriorityFixInDays; 
	var objPriority; 
	var objAssignTo;
	var objDueDate; 

	objPriorityFixInDays = GetObjectReference('frmIBIssueEntry','PriorityFixInDays'); 
	objPriority = GetObjectReference('frmIBIssueEntry','Priority'); 
	objPriorityFixInDays.selectedIndex=objPriority.selectedIndex-1;
	
	objAssignTo = GetObjectReference('frmIBIssueEntry','AssignTo');
	if(objAssignTo == null || objAssignTo.value == '') return;
		objDueDate = GetObjectReference('frmIBIssueEntry','DueDate'); 

	if(objDueDate==null || objDueDate.value=='') 
		return; 
	var dtDueDate = new Date(); 
	if(objPriorityFixInDays.value!='') 
	{ 
		var intNoDays = objPriorityFixInDays.value;
 		objDueDate.value = DayAdd(dtDueDate,intNoDays);
	} 
	else
 		objDueDate.value = getDate(dtDueDate); 
} 
	<%MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")%>
	

	var objfrmIBIssueEntry;
	objfrmIBIssueEntry = GetFormReference('frmIBIssueEntry');


	<%=declarevariables%>

	<%if instr(declarevariables,"Keywords")=0 then %>
		var	objKeywords = GetObjectReference('frmIBIssueEntry','Keywords');
	<%end if%>

	//var objcboIssue = GetObjectReference('frmIBIssueEntry','cboIssue');
	//Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
    //Purpose : Firefox Support
	var objcboIssue = document.forms['frmIBIssueEntry'].elements['cboIssue'];
	//Modification Ends by SantoshK on June 6, 2006
	var objDueDate = GetObjectReference('frmIBIssueEntry','DueDate');
	var	objAssignTo = GetObjectReference('frmIBIssueEntry','AssignTo');
	var objtxtPreviousIssueID = GetObjectReference('frmIBIssueEntry','txtPreviousIssueID');
	var objtxtNextIssueID = GetObjectReference('frmIBIssueEntry','txtNextIssueID');
	var objOldAssignTo = GetObjectReference('frmIBIssueEntry','OldAssignTo');
	var objShowToCustomer = GetObjectReference('frmIBIssueEntry','ShowToCustomer');

	// Integrated by ArchanaN on 26 Apr 2007
	//Integrated by PrashantD on 2 March 2007 for Product Execution Project
	// Added By NitinVS on 28 May 2006 for Roamware Customization
	objCustomer = GetObjectReference('frmCommonPage','CustomerID');
	objProductVersionID = GetObjectReference('frmCommonPage','ProductVersionID');
	objComponentID = GetObjectReference('frmCommonPage','ComponentID');
	//End Addition  By NitinVS on 28 May 2006 for Roamware Customization
	//End of Integration by PrashantD on 2 March 2007
	 // Integration Ends

	function AddNew_OnClick()
	{
	    //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
		window.location.href = "IB_IssueEntry.aspx?PageNumber=<%=m_intPageNumber%>";		
		//window.location.href = "IB_IssueEntry.aspx?&PKToken=<%=m_strToken_AddNewMode%>&PageNumber=<%=m_intPageNumber%>";		
		 //End of Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
	}

/*	function AddAttachment_OnClick()
	{
	//Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
		<%If Not Request.QueryString("IssueNavigation") Is Nothing Then
            If Request.QueryString("IssueNavigation") = "1" or Request.QueryString("IssueNavigation") = "True" Then%>
                    // window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=1&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
                     window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=1&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
              <%else%>
				//window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
				window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
              <%end if%>
        <%else%>
				//window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
				window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
		<%End If%>		
	//End of Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
		//window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
	} */
	
	function Attachment_OnClick(intAttachmentID)			
	{
		var ProjectId = <%=m_ProjectID%>, FromWhere;
        //Added Byu VijaYD On 17 Aug 2009
        var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType').value ;
        var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
        //End Addition By 17 Aug 2009		
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		<%If Trim(Request.QueryString("FromWhere"))<>"" Then %>
			FromWhere="<%=m_FromWhere%>";
		<%Else%>
			FromWhere = "";
		<%End If%>

		EnableControls();
		
		<%If Not Request.QueryString("GoTo") Is Nothing Then
            If Request.QueryString("GoTo") = "1" Then%>
				//Reviewtype parameter added by MrugajaB on 9th Feb 2006 for multiple reviewees feature
                //objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&AttachmentID=" + intAttachmentID + "&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;                               
                objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&AttachmentID=" + intAttachmentID + "&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere="+FromWhere+"&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
            <%end if%>
        <%else%>
               //objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&AttachmentID=" + intAttachmentID + "&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
               objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&AttachmentID=" + intAttachmentID + "&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere="+FromWhere+"&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
        <%End If%>
				//End Modification By MrugajaB
		
		//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&AttachmentID=" + intAttachmentID + "&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
		objfrmIBIssueEntry.submit();
	}

	//Added By GaneshG on 08 Nov 06	-- Flag setting for Issue
	//Purpose : To open a popup window to maintain the tracking details. 
	function Flag_OnClick()
	{
			//window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + <%=m_ProjectId%> + "&ContextID=" + <%=m_lngIssueId%> + "&PkToken=" + <%=m_strToken%> + "&ContextType=IB&FromWhich=BTS&ContextName=" + URLEncode("<%=m_strIssueSummary%>"),"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	    window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + <%=m_ProjectId%> + "&ContextID=" + <%=m_lngIssueId%> + "&PkToken=<%=m_strTokenFlagToFollow%>&ContextType=IB&FromWhich=BTS&fromwhere=Issue&ContextName=" + URLEncode("<%=m_strIssueSummary%>"),"_Tracking","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}
	//End Addition By GaneshG 
	
	
	//added by ManishK on 11th Jan 06 to add AddDeliverable link on Issue page
	function AddDeliverable_OnClick()	
	{
		objDeliverableID = GetObjectReference('frmRequestDetails','DeliverableID');
		// Commented and added by MonikaI on 10th Oct 2006 IssueID : 6940
			//if(objDeliverableID.value == '' || objDeliverableID.value == 0)
			if(<%=m_intDeliverableID%> == 0)
		// End by MonikaI on 10th Oct 2006
			{
			// START : Modified BY ParagD On 5-Sept-2006
			// Purpose : PMLifeLine SP7 Issue : To persist ShowToCustomer flag for Issue
			//Modified By shraddhaM for CashTech IssueID : 5351 on 8,Mar 2007 IssueID 11545
			//Purpose : Error on ConvertTO Delivarable Link in Expose to Customer is not in Layout
			//Checked object is not null
			var objShowToCustomer = GetObjectReference('frmIBIssueEntry','ShowToCustomer');
			if(objShowToCustomer != null)
			{
				var strShowToCustomer = objShowToCustomer.value;
			}
			//End of modification By shraddhaM for CashTech IssueID : 5351 on 8,Mar 2007
			//modified by harshada d on 25 Jan 2006
			// window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>", "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			
			// Modified by JijeshP on 24 Aug 2006
				var IssueNavigation ;
			// START : Modified By ParagD On 5-Sept-2006
			// added 1 extra parameter "ShowToCustomer".
			// Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
			//window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&ShowToCustomer="+strShowToCustomer, "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
				<%If m_blnIssueNavigation Then %>
                 IssueNavigation = "1"
             <%else%>
				 IssueNavigation = "0"
              <%end if%>
            //Commented By JyotiG
            //Start_JG_07-Nov-2006
			//window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&ShowToCustomer="+strShowToCustomer, "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			//Comment End_JG_07-Nov-2006 
			//End of Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
			// END : Modified By ParagD On 5-Sept-2006
			
                //Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
			    //window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&IssueNavigation=" + IssueNavigation + "&ShowToCustomer=" + strShowToCustomer  , "_CreateDeliverable", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			    //window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&IssueNavigation=" + IssueNavigation + "&ShowToCustomer=" + strShowToCustomer  , "_CreateDeliverable", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=340");

			    //Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'IB_IssueEntry.aspx/GenrateAddDeliverableToken1',
			        data: JSON.stringify({ IssueID: '<%=m_lngIssueId%>',EmployeeID: "<%=Session("intUserID")%>"}),
                     success: function (Result) {
                         //window.open("../DM/DM_CheckListResponse.aspx?Mode=SHOW&view=1&ShowPreview=1&RevisionID=1&cboApproverID=0&CheckListID=" + QuestionnaireID + "&PKCheckListToken=" + Result.d, "", "resizable=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=900,height=500");
                         
                         window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&IssueNavigation=" + IssueNavigation + "&ShowToCustomer=" + strShowToCustomer + "&PkConvert2DelivarableToken=" +Result.d  , "_CreateDeliverable", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=340");

                     },
                     error: function () {
                         //alert("Error")
                     }
                 });

			    //End Of Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
			    //End of Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
			//End modification by JijeshP
			//end of modification by harshada d on 25 Jan 2006
			
			// END : Modified BY ParagD On 5-Sept-2006

			}else
			{
				alert("Deliverable is already mapped to this issue!");
				window.close();
			}
			
		
	
	}
	//End of added by ManishK on 11th Jan 06 to add AddDeliverable link on Issue page
	
	function DeleteAttachment_OnClick()
	{
	    //Added Byu VijaYD On 17 Aug 2009
        var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType').value ;
        var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
        var strQuerystringFilter="&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
        //End Addition By 17 Aug 2009
        	
	    //Added by TruptiK on 7-Jan-09
	  	var blnChecked=false;
	  	var i;
					if (objchkDelete != null)
					{
					   for (i=0;i<objchkDelete.length;i++)
					   {
					     if (objchkDelete[i].checked==true)
					     {
						  blnChecked=true;
						  break;
					     }
					   }
					}
					
					if (blnChecked==false)
					{
					    //Changed the spelling of attachment by SuchitraP on 20-may-2009 for IssueID : 29256
					    alert('Please select at least one Attachment');
					    //End by SuchitraP
					 return;
					 }
					 //End of addition by TruptiK on 7-Jan-09
		if(confirm('<%=mybase.GetResourceString("DELETEATTACHMENTS",false)%>'))
		{
			EnableControls();
			
			//Modified By VidyaJ - For IssueID - 63 - SP4
			//Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
			//Reviewtype parameter added by MrugajaB on 9th Feb 2006 for multiple reviewees feature
			<%If Not Request.QueryString("GoTo") Is Nothing Then
				If Request.QueryString("GoTo") = "1" Then%>
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>"+strQuerystringFilter;
				<%else%>
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>"+strQuerystringFilter;
				<%end if%>
			<%elseif Not Request.QueryString("IssueNavigation") Is Nothing Then
				If Request.QueryString("IssueNavigation") = "1" or Request.QueryString("IssueNavigation") = "True" Then%>
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&IssueNavigation=1&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>"+strQuerystringFilter;
				<%else%>
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=0&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>"+strQuerystringFilter;
				<%end if%>
			<%else%>
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
					objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&IssueNavigation=1&ReviewType=<%=strIssueAddedFrom%>&Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>"+strQuerystringFilter;
			<%End If%>
			//End Modification by MrugajaB
			//End of Modified by SavitaS on 19 Sept 2006 for Security Issue 6197 
			//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?Mode=<%=m_strMode%>&Action=DeleteAttachments&PageNumber=<%=m_intPageNumber%>";
			objfrmIBIssueEntry.submit();								
		}
	}
	
	function AssignIssue_OnClick()
	{
	
		//Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
		//Purpose: Not allow to do any activity if Project is not baselined 	
			if ("<%=m_blnIsProjectCreationWorkflowReqd%>"== "True")
			{
			if ("<%=m_intBaselineNumber%>"== 0)
			    {
			 		alert("Project related activities such as adding Task or Resource or Timesheet entry cannot be performed as the Project is not Baselined." );
                    return;
                }
            }           
            //End of addition 
	    var objControl, intFixInDays;
	    var IssueID;
	    intFixInDays=0;
	    IssueID=<%=m_lngIssueId%>;
		objControl = GetObjectReference('frmIBIssueEntry','PriorityFixInDays');
		if (objControl!=null)
		{
			intFixInDays = objControl.value;
		}

	    //COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
	    //window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","_Document","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");			
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    contentType: 'application/json',
		    url: 'IB_IssueEntry.aspx/GenrateURLToken',
		    data: JSON.stringify({ IssueID: IssueID,intFixInDays:intFixInDays }),
		    success: function (Result) {
		        window.open ("IB_IssueAssignment.aspx?IssueID=<%=m_lngIssueId%>&PKToken=" + Result.d +"&FROMWHERE=Issue&FixInDays=" + intFixInDays,"_IssueAssignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 1100)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=1100,height=400");
		    },
		    error: function () {
		        //  alert("Error")
		    }
		});	
	    
	    //END OF COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
		// Modified by SavitaS on 20 Sept 2006 for Security Issue 6197 
		//window.open ("IB_IssueAssignment.aspx?IssueID=<%=m_lngIssueId%>&FixInDays=" + intFixInDays,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
		//Modified By VarunA on 3-Oct-2008 IssueID-22517
		//Purpose : Alignment problem in Mozilla
	    //window.open ("IB_IssueAssignment.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&FixInDays=" + intFixInDays,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
        //Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
	    //window.open ("IB_IssueAssignment.aspx?IssueID=<%=m_lngIssueId%>&PKToken=<%=m_strToken%>&FixInDays=" + intFixInDays,"_IssueAssignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=400");
	   
	    //End of Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
		//End By VarunA on 3-Oct-2008 IssueID-22517
	   //End of Modified by SavitaS on 20 Sept 2006 for Security Issue 6197 
	}
	
	function ShowHistory_OnClick()
	{
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IB_IssueEntry.aspx/GenrateAddDeliverableToken',
	        data: JSON.stringify({ IssueID: '<%=m_lngIssueId%>',EmployeeID: "<%=Session("intUserID")%>" }),
			        success: function (Result) {
			            //window.open("../DM/DM_CheckListResponse.aspx?Mode=SHOW&view=1&ShowPreview=1&RevisionID=1&cboApproverID=0&CheckListID=" + QuestionnaireID + "&PKCheckListToken=" + Result.d, "", "resizable=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=900,height=500");
			            window.open ("IB_IssueHistory.aspx?PKToken=" +Result.d+"&IssueID=<%=m_lngIssueId%>","_ShowHistory","resizable=yes,scrollbars=no,left=" +(window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		               
		//	            window.open ("../PM/Create_Deliverables.aspx?FromWhere=IB&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_strToken%>&IssueNavigation=" + IssueNavigation + "&ShowToCustomer=" + strShowToCustomer + "&PkConvert2DelivarableToken=" +Result.d  , "_CreateDeliverable", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=340");

                     },
                     error: function () {
                         //alert("Error")
                     }
         });
		//window.open ("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueId%>","_ShowHistory","resizable=yes,scrollbars=no,left=" +(window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		
	}
	
	function ShowTimeSheet_OnClick()
	{
		 //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
		//window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueId%>&Mode=TimeSheet","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
	    //window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueId%>&Mode=TimeSheet&PKToken=<%=m_strToken%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
	    window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueId%>&Mode=TimeSheet&ProjectId=<%=mStrProjectID%>&PKToken=<%=m_strToken%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
		 //End of Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
	}
	// Modified By NitinVS on 5 Aug 2005 for PMLifeLine SP4 IssueID 63 Changed Height to 525
	function DiscussionThread_OnClick()
	{	      
        //Added Byu VijaYD On 17 Aug 2009
        var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType').value ;
        var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
        var strQuerystringFilter="&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
        //End Addition By 17 Aug 2009
        
	    //Modified By ShraddhaM on 3/10/2006 For SP7 IssuID : 6558
				// code for Mozilla, etc.
				//Added by GaneshD on Jun 08 2009 for Issue Base status flow configuration
				//Purpose :- Statu Flow should be applicable to discussion thread page also. 
				//            As we can change the status of the issue from there also
        var StatusFlowCount = '<%=m_StatusFlowCount%>';
				 // Addition End by GaneshD on 08 Jun 2009
				if (navigator.appName =='Netscape')
				{
				    //var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=Discussion";
					var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=Discussion"+strQuerystringFilter;
					//Added by GaneshD on Jun 08 2009 for Issue Base status flow configuration
				//Purpose :- Statu Flow should be applicable to discussion thread page also. 
				//            As we can change the status of the issue from there also
					if (StatusFlowCount>0)
					{
					 url=url+"&StatusFlow=1";
					}
					// Addition End by GaneshD
			 		objXMLHTTP=new XMLHttpRequest()		
					objXMLHTTP.onreadystatechange=xmlhttpChange;
					objXMLHTTP.open("GET",url,true);
					objXMLHTTP.send(null);
				}
				else
				{
				    //var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=Discussion";
					var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=Discussion"+strQuerystringFilter;
					//Added by GaneshD on Jun 08 2009 for Issue Base status flow configuration
				//Purpose :- Statu Flow should be applicable to discussion thread page also. 
				//            As we can change the status of the issue from there also
					if (StatusFlowCount>0)
					{
					 url=url+"&StatusFlow=1"
					}
					// Addition End by GaneshD
			 		objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
					objXMLHTTP.onreadystatechange=xmlhttpChange;
					objXMLHTTP.open("GET",url,false);
					objXMLHTTP.send(); 
				}
					
					
         
         //Commnted by SavitaS on 19 Sept 2006 for Security Issue 6197 				
		//window.open ("IB_Discussion.aspx?IssueID=<%=m_lngIssueId%>&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&IssueNavigation=" + IssueNavigation,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=650,height=525");		
		//End of Commnted by SavitaS on 19 Sept 2006 for Security Issue 6197 
		//End Addition
	}
		function AddAttachment_OnClick()
	{

                //Added Byu VijaYD On 17 Aug 2009
                var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType').value ;
                var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
                var strQuerystringFilter="&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
                //End Addition By 17 Aug 2009
                
            	//Modified By ShraddhaM on 3/10/2006 For SP7 IssuID : 6555
				// code for Mozilla, etc.
				if (navigator.appName =='Netscape')
				{
				    //var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=AddAttachment";
					var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=AddAttachment"+strQuerystringFilter;
			 		objXMLHTTP=new XMLHttpRequest()			 		
					objXMLHTTP.onreadystatechange=xmlhttpChange
					objXMLHTTP.open("GET",url,true)
					objXMLHTTP.send(null)
				}
				else // For IE
				{
				    //var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=AddAttachment"
					 var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=<%=m_lngIssueId%>&Fromwhere=AddAttachment"+strQuerystringFilter;
			 		objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
					objXMLHTTP.onreadystatechange=xmlhttpChange;
					objXMLHTTP.open("GET",url,false);
					objXMLHTTP.send(); 
				}	
				//Ended By ShraddhaM on 3/10/2006 For SP7 IssuID : 6555	
		
	}
		function xmlhttpChange()
		{		
			if (objXMLHTTP.readyState==4)
			{
			 	if (objXMLHTTP.status==200)
				{		
				  if(objXMLHTTP.responseText != 0)
				    {
				    	  var i=0,strToken,strIssueID,strFrom;				 
							var strOld=objXMLHTTP.responseText
				   			var strNew = strOld.split(',');		
				   			var strNew = strOld.split(',');		
                            //Added Byu VijaYD On 17 Aug 2009
                                var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType').value ;
                                var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
                                var StrQueryStringFilter="&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType;
                            //End Addition By 17 Aug 2009
                            						   		
							strIssueID=strNew[i]
							strFrom =strNew[i+1]
							strToken =strNew[i+2]		
				
						 if (strFrom=='Discussion')
						 {		
						 //Added by MrugajaB for PMLifeLine SP7			
								var IssueNavigation ;
							<%If m_blnIssueNavigation Then %>
									IssueNavigation = "1"
							 <%else%>
									 IssueNavigation = "0"
							 <%end if%>  
							 //Added by GaneshD on Jun 08 2009 for Issue Base status flow configuration
				    //Purpose :- Statu Flow should be applicable to discussion thread page also. 
				    //            As we can change the status of the issue from there also
				    var StatusFlowCount = <%=m_StatusFlowCount%>
				     // Addition End by GaneshD on 08 Jun 2009
						  //Commnted and Modified by SavitaS on 03 Oct 2006 for SP7 IssueId 6494	 
						  //window.open ("IB_Discussion.aspx?IssueID="+strIssueID+"&PKToken="+strToken+"&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&IssueNavigation=" + IssueNavigation,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=650,height=525");							  						  
				  		// Integrated by ArchanaN on 26 Apr 2007
						 //window.open ("IB_Discussion.aspx?IssueID="+strIssueID+"&PKToken="+strToken+"&PageNumber=<%=m_intPageNumber%>&OrderBy=IssueID&ASCDESC=<%=m_strSortOrder%>&IssueNavigation=" + IssueNavigation + "&Fromwhere=<%=m_FromWhere%>&FromReview=<%=m_strFromReview%>","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=650,height=525");							  
						   //Added by SrikanthY on 21 Dec 2006 To pass parent query details if it called from Dashboard
						   // Added StatusFlow parameter in the Querystring passed- By GaneshD on 08 Jun 2009
						   
						   //window.open ("IB_Discussion.aspx?IssueID="+strIssueID+"&PKToken="+strToken+"&PageNumber=<%=m_intPageNumber%>&OrderBy=IssueID&ASCDESC=<%=m_strSortOrder%>&IssueNavigation=" + IssueNavigation + "&Fromwhere=<%=m_FromWhere%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&StatusFlow="+StatusFlowCount+"&QueryID=<%=m_Queryid%>","","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=650,height=525");							  
						   window.open ("IB_Discussion.aspx?IssueID="+strIssueID+"&PKToken="+strToken+"&PageNumber=<%=m_intPageNumber%>&OrderBy=IssueID&ASCDESC=<%=m_strSortOrder%>&IssueNavigation=" + IssueNavigation + "&Fromwhere=<%=m_FromWhere%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&StatusFlow="+StatusFlowCount+"&QueryID=<%=m_Queryid%>"+StrQueryStringFilter,"_IssueDescussion","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=650,height=525");							  
						   
						   //End of Addition by SrikanthY
						  // Integration Ends

						 //End of Commnted and Modified by SavitaS on 03 Oct 2006 for SP7 IssueId 6494   
						}						
						
						if (strFrom=='AddAttachment')
						{
							//Integrated by PrashantSJ on 06 Nov 2006
							//Purpose: For Multi attachement Enhacements
							// replaced Attachment.aspx with MultiAttachment.aspx
								
								<%If Not Request.QueryString("IssueNavigation") Is Nothing Then
								If Request.QueryString("IssueNavigation") = "1" or Request.QueryString("IssueNavigation") = "True" Then%>
								 // window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=1&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//	window.open ('../General/MultiAttachment.aspx?FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=1&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");										
								//Modified width by SuchitraP for IssueID 29288 ,prupose : At the bottom of the large space is provided in [Mozilla]
								window.open ('../General/MultiAttachment.aspx?TagID=5&FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=1&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>'+StrQueryStringFilter, "_MultiAttachment","resizable=yes,left=0,top=0,width=550,height=200");										
							   <%else%>
								//window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//window.open ('../General/MultiAttachment.aspx?FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//Modified width by SuchitraP for IssueID 29288 ,prupose : At the bottom of the large space is provided in 
								window.open ('../General/MultiAttachment.aspx?TagID=5&FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>'+StrQueryStringFilter, "_MultiAttachment","resizable=yes,left=0,top=0,width=550,height=200");	
								
								<%end if%>
								<%else%>
								//window.open ('../General/Attachment.aspx?FromWhere=BTS&ID=<%=m_lngIssueID%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//window.open ('../General/MultiAttachment.aspx?FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//Modified by shraddhaM on 23,Feb 2007 for e-Emphasys Issue Id : 5687 ( added PkToken )
								//window.open ('../General/MultiAttachment.aspx?FromWhere=BTS&ID='+strIssueID+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>', "_new","resizable=yes,left=0,top=0,width=550,height=240");	
								//Modified width by SuchitraP for IssueID 29288 ,prupose : At the bottom of the large space is provided in 
								window.open ('../General/MultiAttachment.aspx?TagID=5&FromWhere=BTS&ID='+strIssueID+'&PKToken='+strToken+'&Mode=<%=m_strMode%>&Page=../IB/IB_IssueEntry.aspx&QueryString=<%=Server.UrlEncode("IssueNavigation=0&Mode=Edit&IssueID=" + m_lngIssueId.ToString)%>'+StrQueryStringFilter, "_MultiAttachment","resizable=yes,left=0,top=0,width=550,height=200");	
								//End of modification by shradhaM on 23,Feb 2007 for e-Emphasys Issue Id : 5687 ( added PkToken )
								<%End If%>	
								//End of Integration by PrashantSJ on 06 Nov 2006		
					
						}		
							if (strFrom=='Issueonchange')
						{
						    // Modified by GaneshD on 07 Oct 2009 to Persist the search filters - PMLifeLine IssueID-33515
							//window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Issueonchange";
							window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Issueonchange"+StrQueryStringFilter;								
							// End of modification by GaneshD on 07 Oct 2009
						}	 
							 
						if(strFrom=='Previous')
						{	
						// Modified by GaneshD on 07 Oct 2009 to Persist the search filters - PMLifeLine IssueID-33515	
						//window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Previous";				
						window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Previous"+StrQueryStringFilter;		
						// End of modification by GaneshD on 07 Oct 2009
						}	 
						
						if(strFrom=='Next')
						{	
						    // Modified by GaneshD on 07 Oct 2009 to Persist the search filters - PMLifeLine IssueID-33515
						    //window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Next";					
							window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&PKToken="+strToken+"&strFlag=Next"+StrQueryStringFilter;
							// End of modification by GaneshD on 07 Oct 2009
		    
						}
							 
					}
			   }
			}		
		}
	// End Modification By NitinVS on 5 Aug 2005 for PMLifeLine SP4 IssueID 63 Changed Height to 525
	
	function Back_OnClick()
	{
		// Modified by SandipL -- If Project Is changed then do not keep previous QueryID
		//Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
		var IssueListSearchType = GetObjectReference('frmIBIssueEntry','IssueListSearchType') ;
	    var IssueListSearchValue = GetObjectReference('frmIBIssueEntry','IssueListSearchValue').value ;
	    //End of addition by ShraddhaM
		var strLocation 
		<%if m_strSortField <> "" And m_blnProjectChanged = False Then %> 
		strLocation = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>&cboQuery=<%=Session("intQueryID")%>";
		<%ElseIf m_blnProjectChanged = False Then %>
		strLocation = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&cboQuery=<%=Session("intQueryID")%>";
		<%Else%>
		strLocation = "IBIssueList.aspx?&cboQuery=<%=Session("intQueryID")%>";
		<%End If %>
		<%If m_blnProjectChanged = False Then %>
		strLocation = strLocation + "&FromIssueEntry=1";
		<%End If %>
		//Modified by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
		window.location.href = strLocation + "&IssueListSearchValue="+IssueListSearchValue+"&IssueListSearchType="+IssueListSearchType.value;
				
		//End of modification by ShraddhaM
		// End Modification by SandipL
	}
	
	function EnableControls()
	{
		<%If strEnableControlsScript <>"" then%>
		<%=strEnableControlsScript%>
		<%End If%>
		// Integrated by ArchanaN on 26 Apr 2007
		 //Integrated by PrashantD on 2 March 2007 for Product Execution Project	
		/*Added By NitinVS on 2 Jun 2006 for Roamware Customization		*/
		if (objCustomer != null) 
			objCustomer.disabled =false; 
		/* End Added By NitinVS on 2 Jun 2006 for Roamware Customization		*/
		//End of Integration by PrashantD on 2 March 2007
		 // Integration Ends

	}
	
	function ValidateControls()
	{
	  
		var intCtr1; 
		var intCtr2;
        /* Added And Commented By VijayD On 12 August 2009*/
        var objCurrentDate = GetObjectReference('frmIBIssueEntry','CurrentDate');
        var objCurrentTime = GetObjectReference('frmIBIssueEntry','CurrentTime');
        var objReportedDate = GetObjectReference('frmIBIssueEntry','ReportedDate');
        var objReportedTime = GetObjectReference('frmIBIssueEntry','ReportedTime');
         /* End Addition By VijayD On 12 August 2009 */   
         		
		var objTextArea;

		PopulateDefaultValues();
		
		<%If strClientSideScript <> "" then %>
		<%=strClientSideScript%>
		<%End If%>
		

		if (objKeywords!=null)
		{
			for(intCtr1=0;intCtr1<=4;intCtr1++)
			{
				for(intCtr2=intCtr1+1;intCtr2<=4;intCtr2++)
				{
					if(objKeywords[intCtr1].value != "")
					{
						if(objKeywords[intCtr1].value == objKeywords[intCtr2].value)
						{
							//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							alert("<%=Mybase.getResourceString("DIFFERENTKEYWORD",false)%>");
							//End modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							ShowHideKeywords("none");
							setFocus(objKeywords[intCtr2]);
							return false;
						}
					}
				}
			}
		}
		if(objReportedDate!=null && objCurrentDate !=null)
		{
            /* Added And Commented By VijayD On 12 August 2009
            Purpose : Assign Validation  to Reported Date and Reported Time  */
            if(compareDates(objCurrentDate.value, Trim(objReportedDate.value))==-1) //Replace GetDate()
            {			
                //modified by harshk for sp4 issueid 136 (single quote changed to double quote)
                alert("<%=mybase.GetResourceString("FUTUREREPORTED",false)%>"); 
                //END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
               // Tab_OnClick(0);  'Commented By VijayD oN 16 Aug 2009
                setFocus(objReportedDate);
                return false;
            }
        }                      
            /* End Addition By VijayD On 12 August 2009 */     		
 
		
		if((objDueDate!=null)&&(objReportedDate!=null))
		{
			if(compareDates(objDueDate.value,objReportedDate.value)==-1)
			{
				//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
				alert("<%=mybase.GetResourceString("DUEDATE>REPORTEDDATE",false)%>");
				//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
				//Tab_OnClick(0);  'Commented By VijayD oN 16 Aug 2009
				setFocus(objDueDate);
				return false;
			}
		}
		
		if((objDueDate!=null)&&(objAssignTo!=null))
		{
			if (objDueDate.disabled==false) 
			{
				if (Trim(objAssignTo.value)!="")
				{
					if (Trim(objDueDate.value)="") 
					{
						alert("<%=mybase.GetResourceString("ENTERDUEDATE",false)%>" + "\n" + "<%=mybase.GetResourceString("WHYDUEDATE",false)%>");
						//Tab_OnClick(0); 'Commented By VijayD oN 16 Aug 2009						
						setFocus(objDueDate);
						return false;
					}
					
					if (objOldAssignTo.value != objAssignTo.value)
					{
						if(compareDates(getDate1() , Trim(objDueDate.value))==-1)//
						{
							//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							alert("<%=mybase.GetResourceString("FUTUREDUEDATE",false)%>");
							//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							//Tab_OnClick(0);	 'Commented By VijayD oN 16 Aug 2009					
							setFocus(objDueDate);
							return false;
						}
					}
				}				
			}			
		}
		/*
		 '****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement Number :   IB_PBN_ENT_04
        'Addition Made  :   Validation for 
        */
			var objReportedTime=GetObjectReference('frmIBIssueEntry','ReportedTime')
			if (objReportedTime!=null)
				{
					if (disallowBlank(objReportedTime,"<%=MyBase.GetResourceString("BLANKREPORTEDTIME")%>",true))
							return false;
					if(isTime(objReportedTime,"<%=mybase.GetResourceString("INVALIDTIME",false)%>")==false)
						{
							return false;
						}
				}
        /*******End Addition*******/
        
			//'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
			/*
			'****Code Added*******
			'By     :   PradipK
			'Date   :   15 Feb 2006
			'Addition Made  :   Validation for Status Change Time Control
			*/
         
			if (("<%=m_LoginType%>" != 'C') && ("<%=m_IsIssueSLAApplicable%>" == 'True'))
			{
				var objStatusChangeTime=GetObjectReference('frmIBIssueEntry','StatusChangeTime')
				if (objStatusChangeTime!=null)
					{
						if (disallowBlank(objStatusChangeTime,"Status Change Time should not be blank.",true))
								return false;
							//	alert(objStatusChangeTime.value);
						if(isTime(objStatusChangeTime,"<%=mybase.GetResourceString("INVALIDTIME",false)%>")==false)
							{
								return false;
							}
					}			

	        	
					var objStatusTime = GetObjectReference('frmIBIssueEntry','StatusChangeTime');
					var objStatusDate = GetObjectReference('frmIBIssueEntry','StatusChangeDate');
					
					//alert(objStatusDate.value);
					var objCurrentDate = GetObjectReference('frmIBIssueEntry','CurrentDate');
					var objCurrentTime = GetObjectReference('frmIBIssueEntry','CurrentTime');
					var objReportedDate = GetObjectReference('frmIBIssueEntry','ReportedDate');
					var objReportedTime = GetObjectReference('frmIBIssueEntry','ReportedTime');
					var objOldStatus = GetObjectReference('frmIBIssueEntry','txtOldStatus');
					var objNewStatus = GetObjectReference('frmIBIssueEntry','Status');

					var objOldStatusChangeDate = GetObjectReference('frmIBIssueEntry','OldStatusChangeDate');
					var objOldStatusChangeTime = GetObjectReference('frmIBIssueEntry','OldStatusChangeTime');
                

					// Validation: If Status is not changed,Then Disallow to Change Status Change Date & Status Change Time .
					if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
					{

					//If objOldStatusChangeDate & objOldStatusChangeTime is null the allow to add StatusChangeDate/Time is 
					if (objOldStatusChangeDate.value!="" || objOldStatusChangeTime.value!="" )
					{
					if (objOldStatus.value.toLowerCase()==objNewStatus.value.toLowerCase() )
						{
					if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
							{
								alert('Status change date and/or time will be not be changed for this status!');
								if(objOldStatusChangeDate.value!=objStatusDate.value )
								setFocus(objStatusDate);
								if(objOldStatusChangeTime.value !=objStatusTime.value)
								setFocus(objStatusTime);
								return;
							}
							else
							
							return true;
							
							
						}
					}	

		
				}


				//Validation :Status Change Status Date & Time Can not Be Less than Previous Status Change Date & Time.

				   
				//Validation :Status Change Status Date & Time Can not Be Greater than Current Date & time.
				//alert('ok1');


			if(objStatusDate!=null && objStatusTime!=null && objCurrentDate!=null && objCurrentTime!=null )
			{

			if(disAllowDateTime1GreaterThanDateTime2(objStatusDate,objStatusTime,objCurrentDate,objCurrentTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
			return ;
			}
			//alert('ok2');
			//Validation :Status Change Status Date & Time Can not Be Less than Reported Date & time.
			//alert(objReportedDate.value);
			//alert(objStatusDate.value);
			if(objStatusDate!=null && objStatusTime!=null && objReportedDate!=null && objReportedTime!=null )
			{
			if(disAllowDateTime1GreaterThanDateTime2(objReportedDate,objReportedTime,objStatusDate,objStatusTime,'Status Change Date & Time should not be less than Reported Date & Time.'))
			return ;
			}

			//Validation :Status Change Status Date & Time Can not Be Less than Previous Status Change Date & Time.
			//alert('ok');
			if (objOldStatus.value.toLowerCase()!=objNewStatus.value.toLowerCase())
			{
			//alert('ok');
			if(objStatusDate!=null && objStatusTime!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime!=null )
				{ 
				
			if(objOldStatusChangeDate.value!="" && objOldStatusChangeTime.value!="" && objStatusDate.value!="" && objStatusTime.value!="" )
					{
			//alert('ok1111');
			if(objOldStatusChangeDate.value==objStatusDate.value && objOldStatusChangeTime.value==objStatusTime.value) 
						{
			alert("Status Change date & time should be greater than previous status Change date and time.");
			setFocus(objStatusTime);
			return;
						}
			else

			//if(disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate,objOldStatusChangeTime,objStatusDate,objStatusTime))
			if(disAllowDateTime1LessThanDateTime2(objStatusDate,objStatusTime,objOldStatusChangeDate,objOldStatusChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
			return ;
			//}
					}
				}
			}

		}	
		/*******End Addition*******/
		//Added by GaneshD on 04 Jun 2009 for StatusFlow configuration
            var validStatusNew;
            var validStatusExist;
            
            var objOldStatus = GetObjectReference('frmIBIssueEntry','txtOldStatus');
            var objNewStatus = GetObjectReference('frmIBIssueEntry','Status');

            var objCompareStatus = GetObjectReference('frmIBIssueEntry','CmbStatus');
            var objPrevStatus = GetObjectReference('frmIBIssueEntry','CmbPrevStatus');
            var objCheckStatus = GetObjectReference('frmIBIssueEntry','CmbCheckStatus');

            var objIsConfStatusFlow = <%=m_IsConfStatusFlow%>;//GetObjectReference('frmIBIssueEntry','IsConfStatusFlow');
            var objStatusFlowCount = <%=m_StatusFlowCount%>;
            var AllStatus ='';//<%=m_strAllStatusInStatusFlow %>;
            AllStatus=<%="'"+m_strAllStatusInStatusFlow+"'"%>;
            var statusFlag=0;
            var IssueTypeChanged;
            var IsAllowToChangeStatus;
            IsAllowToChangeStatus=true;

            validStatusNew = "";
            validStatusExist = "\n\n";
            IssueTypeChanged=<%=m_IsIssueTypechanged %>;
        if (IssueTypeChanged!=1)
        {
        if(objIsConfStatusFlow!=0)
        {
            if(objStatusFlowCount > 0)
	        {
        		
		        for(i=0;i<=objCompareStatus.length-1;i++)
		        {
			        validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
		        }
        		
		        for(i=0;i<=objCompareStatus.length-1;i++)
		        {
			        if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].value)
			        {
				        validStatusNew = objNewStatus[objNewStatus.selectedIndex].value;
				        break;
			        }
		        }
        		//Added by GaneshD on 17 aug 2009
        		//Purpose :- To save the issue entry even if we have not changed the status
        		    if (objNewStatus[objNewStatus.selectedIndex].value==objOldStatus.value)
                    {
                        validStatusNew=objNewStatus[objNewStatus.selectedIndex].value;
                    
                    }
                  // End of addition by GaneshD on 17 Aug 2009   
                    
                    
                    if (AllStatus.indexOf(objOldStatus.value)<0)
                    {
                        return true;
                    }
                       
		        if(validStatusNew == "")
		        {
			        if(validStatusExist =="\n\n")
			        {
				        alert("This is the last status configured in the status flow.");
			        }
			        else
			        {
				        alert('Invalid Status, Status can be change to one of the following ' + validStatusExist);
			        }
			        return false;
		        }
        	  
	        }
        }
        }
        //Integrated by GaneshD on 04 Jun 2009
        		
		//Added by vidyak on 21 May 2010-PMLifeLine SP1
        var objCusTextArea1 = GetObjectReference('frmIBIssueEntry','CustomFieldTextArea1');
        var objCusTextArea2 = GetObjectReference('frmIBIssueEntry','CustomFieldTextArea2');
        var objCusTextArea3 = GetObjectReference('frmIBIssueEntry','CustomFieldTextArea3');
        var objDesc = GetObjectReference('frmIBIssueEntry','Description');
        if (disallowMaxlengthViolation(objCusTextArea1,8000,"Please enter the text within 8000 characters")) return false;        		
        if (disallowMaxlengthViolation(objCusTextArea2,8000,"Please enter the text within 8000 characters")) return false;        		
        if (disallowMaxlengthViolation(objCusTextArea3,8000,"Please enter the text within 8000 characters")) return false;        		
        if (disallowMaxlengthViolation(objDesc,8000,"Please enter the Description within 8000 characters")) return false;        		
        //End Added by vidyak on 21 May 2010-PMLifeLine SP1
        		
        		
	        return true;
        }
        
			
	//'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
	//Added By PradipK on 13 March 2006 for SLA Management
	function Status_OnChange()
	{
			//Modified by MrugajaB on 24th July 2006 for PMLifeLine SP7 Issue ID.4262
				var objStatusTime= GetObjectReference('frmIBIssueEntry','StatusChangeTime');
				var objStatusDate=GetObjectReference('frmIBIssueEntry','StatusChangeDate');
				var objWhizStatusDate = GetObjectReference('frmIBIssueEntry','FFE29587WHIZ_StatusChangeDate');
				//var objCurrentDate = GetObjectReference('frmIBIssueEntry','CurrentDate');
				var objCurrentDate = GetObjectReference('frmIBIssueEntry','FFE29587WHIZ_CurrentDate');
				var objCurrentTime = GetObjectReference('frmIBIssueEntry','CurrentTime');
				
				var WhizobjCurrentDate = GetObjectReference('frmIBIssueEntry','FFE29587WHIZ_CurrentDate');
				//var objWhizStatusDate = GetObjectReference('frmIBIssueEntry','FFE29587WHIZ_StatusChangeDate');
				var objOldStatusChangeDate = GetObjectReference('frmIBIssueEntry','OldStatusChangeDate');
				var WhizobjOldStatusChangeDate = GetObjectReference('frmIBIssueEntry','FFE29587WHIZ_OldStatusChangeDate');
				var objOldStatusChangeTime = GetObjectReference('frmIBIssueEntry','OldStatusChangeTime');
				var objNewStatus = GetObjectReference('frmIBIssueEntry','Status');
				var objOldStatus = GetObjectReference('frmIBIssueEntry','txtOldStatus');

				/*var d=new Date(); 
				var h=d.getHours();
				var m=d.getMinutes();

				if (h<10)
					h='0'+h;
				if(m<10)
					m='0'+m;
					
					//Modified by Shraddham on 8th Aug 2006 for PMLifeLine SP7 Issue ID.4262
					
					var objTimehr,objTimeMin;
					objTimeMin = Right(objCurrentTime.value,2);
					objTimehr =Left(objCurrentTime.value,2);
					//alert(objTimehr);
					var StatusChangeTimeSpanHr;
					var StatusChangeTimeSpanMin;
					var StatusChangeTimeSpan;
				
	
					StatusChangeTimeSpanHr = h - RenderedHr;	
					
						
					StatusChangeTimeSpanMin = m - RenderedMin;
					//StatusChangeTimeSpanHr = h - RenderedHr;
						
						if (StatusChangeTimeSpanMin < 0)
							{
								StatusChangeTimeSpanHr = Number(StatusChangeTimeSpanHr) - 1;
								if (StatusChangeTimeSpanHr < 10)
										{
										StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
										}
										
								StatusChangeTimeSpanMin = 60+(StatusChangeTimeSpanMin) ;
											
								if (StatusChangeTimeSpanMin  < 10)
									{
									StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
									}
							}
						else
							if (StatusChangeTimeSpanHr < 10)
										{
											StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
										}
										
							if (StatusChangeTimeSpanMin  < 10)
									{
										StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
									}
									
						StatusChangeTimeSpan = StatusChangeTimeSpanHr +':'+ StatusChangeTimeSpanMin;			
					
					//End of Addition  BY AmitJ.
					//end of integration by harshada d	
					//integrated by harshada d for PMLifeLine SP7.3
										 
					objTimeMin=Number(objTimeMin)+Number(StatusChangeTimeSpanMin);
						if(objTimeMin>=60)
					{
						objTimeMin=Number(objTimeMin) - 60 ;
						objTimehr = Number(objTimehr) + 1
					}	
				
					if(objTimeMin<10)
					{
						objTimeMin='0'+objTimeMin;
					}	

				objTimehr=Number(objTimehr)+ Number(StatusChangeTimeSpanHr);
					//Added by SandipL on 9 Aug 2006
					if(objTimehr >=24)
					{
						objTimehr=Number(objTimehr) - 24 ;
					}	
					//End addition by SandipL on 9 Aug 2006
					if(objTimehr<10)
					{
						objTimehr='0'+objTimehr;
					}*/
					
					//End of Addition By AmitJ	
					//end of integration
					//Modified by Shraddham on 8th Aug 2006 for PMLifeLine SP7 Issue ID.4262
					 
				if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
					{
						if (objOldStatus.value==objNewStatus.value )
						{
							if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
							{
							
								objStatusDate.value=objOldStatusChangeDate.value;
								objWhizStatusDate.value=WhizobjOldStatusChangeDate.value;
								objStatusTime.value=objOldStatusChangeTime.value;
							}
						}
						else
						{
								//objStatusDate.value=objCurrentDate.value;
								//objWhizStatusDate.value=WhizobjCurrentDate.value;
								//objStatusTime.value=h+':'+m
								
			
								objStatusDate.value=objCurrentDate.value;
								objStatusDate.value = GetObjectReference('frmIBIssueEntry','CurrentDate').value;
								objWhizStatusDate.value=objCurrentDate.value;
					
								objStatusTime.value =objCurrentTime.value;
					
				
						}
					}    
					
					//End Modification by  ShraddhaM	
					
					
				/*	//Added by PrashantD on 14 April 2006 for SLA
		if ((objStatusDate!= null) && (objStatusTime!= null))
		{
			
				
				if (((objOldStatus!= null) && (objNewStatus!= null))&&(objOldStatus.value==objNewStatus.value ))
				{
				var objtxtchangedDatehidden1 = GetObjectReference('frmIBIssueEntry','txtchangedDatehidden1')
				var objtxtchangedTimehidden1 = GetObjectReference('frmIBIssueEntry','txtchangedTimehidden1')
				//modified by harshada d for PMLifeLine SP 7.3 on 17 th july 2006
				//objStatusDate.value =GetObjectReference('frmIBIssueEntry','txtchangedDatehidden1').value;
				//objStatusTime.value = GetObjectReference('frmIBIssueEntry','txtchangedTimehidden1').value;
				
				if (objtxtchangedDatehidden1!=null)
				objStatusDate.value =objtxtchangedDatehidden1.value;
				if (objtxtchangedTimehidden1!=null)
				objStatusTime.value = objtxtchangedTimehidden1.value;
				//end of modification by harshada d
				}
				else
				{
	//integrated by harshada d for PMLifeLine sp7
	//Added by AmitJ For PSPL IssuId - 22880									
				// CurrentTime(servertime)@(cboStatus_OnChange)= StatusChangeTimeSpan + CurrentTime(ServerTime)@(Window_Onload)			
				objStatusTime.value = GetObjectReference('frmIBIssueEntry','CurrentTime').value;				
				
				var StatusHr;
				var StatusMin;					
				var StatusTime;		
					
					StatusHr = 	Left(objStatusTime.value,2);
					StatusMin = Right(objStatusTime.value,2);					
					
					if (StatusHr < 10)
						{
							StatusHr = Right(StatusHr,1);
						}
					if(StatusMin < 10)
						{
							StatusMin = Right(StatusMin,1);
						}
						
					StatusHr = parseInt(StatusHr)+ parseInt(StatusChangeTimeSpanHr);
					StatusMin = parseInt(StatusMin)	 + parseInt(StatusChangeTimeSpanMin);					
					
					
					if (StatusMin >= 60)
						{
							StatusMin = parseInt(StatusMin) - 60 ; 							
							StatusHr = parseInt(StatusHr) + 1 ;
						
						}	
							if (StatusMin < 10)
								{
									StatusMin = '0' + StatusMin;								
								}	
								
							if (StatusHr < 10)		
								{
									StatusHr = '0' + StatusHr;
								}
							
							if (StatusHr >= 24)
								{
									StatusHr = parseInt(StatusHr) - 24;	
									if (StatusHr < 10)		
										{
											StatusHr = '0' + StatusHr;
										}									
									objStatusDate.value = GetObjectReference('frmIBIssueEntry','CurrentDate1').value;
									var StatusDate = new Date(objStatusDate.value);									
									StatusDate = DateAdd(StatusDate,1,0,0);																												
									var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 																		
									StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																		
									//alert('afterconvert'+StatusDate);
									StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
									objStatusDate.value = StatusDate 
								}										
						 		objStatusTime.value = StatusHr+':'+StatusMin;  
					
				//End of Addition AmitJ
			//end of integration by harshada d
			 
				objStatusDate.value = GetObjectReference('frmIBIssueEntry','CurrentDate').value;
				 
				objStatusTime.value=objTimehr+':'+objTimeMin;
				}
			}
					/////////ShraddhaM */
		// Integrated by ArchanaN on 26 Apr 2007 for Product Execution Project	 
			/*Added By NitinVS on 2 Jun 2006 for Roamware Customization		*/
			//Commneted by GaneshD for PMLifeLine on 21,Oct 2009 IssueID : 33786
			/*if (objCustomer != null) 
				objCustomer.disabled =false; */
			/* End Added By NitinVS on 2 Jun 2006 for Roamware Customization		*/
		// Integration Ends

		 
	}
	//End Addition By PradipK on 13 March 2006 for SLA Management
	
	function PopulateDefaultValues()
	{
		<%If strDefaultScript <>"" then%>
		<%=strDefaultScript%>
		<%End If%>
	}
	
    function Previous_OnClick()		
    {
        //Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
        //Purpose : Firefox Support
        objcboIssue=document.forms['frmIBIssueEntry'].elements['cboIssue']; 
        //Modification Ends by SantoshK on June 6, 2006
        var browser=WhichBrowser();  //Added By Vaijat K ON 04/11/2015
		
        if (objcboIssue==null) return;
        var intIssueID;
	
        if(((objcboIssue.selectedIndex-1)>=0) && (objcboIssue.selectedIndex-1<objcboIssue.length))
        {
            //Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
            //Purpose : Firefox Support
            //To use [] instead of () which is supported by all browsers
            //intIssueID = objcboIssue.options(objcboIssue.selectedIndex-1).value;
            intIssueID = objcboIssue.options[objcboIssue.selectedIndex-1].value;
            //Modification Ends by SantoshK on June 6, 2006
            //SAVITA 03 Oct 2006
            //window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + intIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";
		
            var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=" + intIssueID + "&Fromwhere=Previous"
            //debugger;
            //Added By VarunA on 24-Sep-2008 IssueID-22540
            //Purpose : next link works in Mozilla 
            if(document.all)
            {
                //End By VarunA on 24-Sep-2008 IssueID-22540
                objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
                objXMLHTTP.onreadystatechange=xmlhttpChange;
                objXMLHTTP.open("GET",url,false);
                objXMLHTTP.send(); 		
                //Added By VarunA on 24-Sep-2008 IssueID-22540
                //Purpose : next link works in Mozilla 
            }
            else 
            { 
                //Added By Vaijat K ON 04/11/2015
                if (browser == 'IE'){
                    objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
                    objXMLHTTP.onreadystatechange=xmlhttpChange;
                    objXMLHTTP.open("GET",url,false);
                    objXMLHTTP.send(); 
                }
                else{
                    objXMLHTTP = new XMLHttpRequest(); 
                    objXMLHTTP.onreadystatechange = xmlhttpChange();
                    objXMLHTTP.open("GET",url,false);
                    objXMLHTTP.send(null); 
                        if (objXMLHTTP.responseText != null)
                        {
                            xmlDoc= document.implementation.createDocument("","",null);
                            xmlDoc.async=false;         
                            if (browser == 'FF') // Added By Vaijat K ON 09/11/2015
                                xmlDoc.load(objXMLHTTP.responseXML);
                            xmlhttpChange();					
                        }
                }
            }
            //End By VarunA on 24-Sep-2008 IssueID-22540
        }
        else
            //modified by harshk for sp4 issueid 136 (single quote changed to double quote)
            alert("<%=mybase.GetResourceString("FIRSTRECORD",false)%>");
        //END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
    }
	
	function Next_OnClick()
	{
		if (objcboIssue==null) 
			return;
		var intIssueID;
		var browser=WhichBrowser();  //Added By Vaijat K ON 04/11/2015
		//debugger;
		if(((objcboIssue.selectedIndex+1)>=0) && (objcboIssue.selectedIndex+1<objcboIssue.length))
		{	
			//Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
			//Purpose : Firefox Support
			//use [] instead of () which is supported by all browsers
			//intIssueID = objcboIssue.options(objcboIssue.selectedIndex+1).value;
			intIssueID = objcboIssue.options[objcboIssue.selectedIndex+1].value;
			//Modification Ends by SantoshK on June 6, 2006			
			//SAVITA 03 Oct 2006
			//window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + intIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";
		    var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=" + intIssueID + "&Fromwhere=Next"
		     //Added By VarunA on 24-Sep-2008 IssueID-22540
		    //Purpose : next link works in Mozilla 
		    if(document.all)
		    {
		        //End By VarunA on 24-Sep-2008 IssueID-22540
		        objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
		        objXMLHTTP.onreadystatechange=xmlhttpChange;
		        objXMLHTTP.open("GET",url,false);
		        objXMLHTTP.send(); 
		        //Added By VarunA on 24-Sep-2008 IssueID-22540
		        //Purpose : next link works in Mozilla 
		    }
		    else 
		    { 
		        //Added By Vaijat K ON 04/11/2015
		        if (browser == 'IE'){
		            objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
		            objXMLHTTP.onreadystatechange=xmlhttpChange;
		            objXMLHTTP.open("GET",url,false);
		            objXMLHTTP.send(); 
		        }
		        else{
		            objXMLHTTP = new XMLHttpRequest(); 
		            objXMLHTTP.onreadystatechange = xmlhttpChange();
		            objXMLHTTP.open("GET",url,false);
		            objXMLHTTP.send(null);
		            if (objXMLHTTP.responseText != null)
		            {
		                xmlDoc= document.implementation.createDocument("","",null);
		                xmlDoc.async=false;
		                if (browser == 'FF') // Added By Vaijat K ON 09/11/2015
		                    xmlDoc.load(objXMLHTTP.responseXML);
		                xmlhttpChange();						
		            }
		        }
		    }
			//End By VarunA on 24-Sep-2008 IssueID-22540
		}
		else
			//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
			alert("<%=mybase.GetResourceString("LASTRECORD",false)%>");
			//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
	}
	
	function Save_OnClick()
	{	   
		var ProjectId = <%=m_ProjectID%>, FromWhere;
		<%'ADDED BY ARCHANAN for Issue ID 13326%>
		<%If m_EnableProjectProductExecution = True Then%>
		{
		var objtdShowHide_ShowHideProductDetails = document.getElementById("tdShowHide_ShowHideProductDetails");
			if (objtdShowHide_ShowHideProductDetails != null)
			{
					//if (objtdShowHide_ShowHideProductDetails.src == 'http://localhost/WhizibleSEM8/Images/plus.gif')	
					var a = objtdShowHide_ShowHideProductDetails.src.toString();
					//alert(a.substring(a.indexOf("Images"),a.length) == 'Images/plus.gif')
					if (a.substring(a.indexOf("Images"),a.length) == 'Images/plus.gif')				
					{
						//alert(objtdShowHide_ShowHideProductDetails.src);
						PopulateDefaultValues();
						if(typeof(objCustomerID) != "undefined")
						if(disallowBlank(objCustomerID,'Customer should not be left blank.',false)){
							ShowHideProductDetails();
							ShowHideIssueDetails("none");
							//HideShowCommonFieldsSection("none");
							setFocus(objCustomerID);	
							return;
						}
				
						if(disallowBlank(objProductVersionID,'Product should not be left blank.',false)){
							ShowHideProductDetails()
							ShowHideIssueDetails("none");
							HideShowCommonFieldsSection("none");
							setFocus(objProductVersionID);
							return;
						}
					}
				}	
			}
			
			<%End If%>
			<%'END BY ARCHANAN%>
			
			if(!ValidateControls()) 
			return;
		
		<%If m_blnAssignIssueToResponsiblePerson = True And dblDefaultWork = 0 Then%>
			if(objAssignTo!=null)
			{			
				if(objAssignTo.value!="")
				{
					var dblWork  = 0;
					dblWork  = Trim(window.prompt('<%=mybase.GetResourceString("ENTERWORKHOURS",false)%>' + "\n" + '<%=mybase.GetResourceString("DEFAULTWORKHOURS",false)%>'));
					while(1)
					{
						if(dblWork!=null)
						{
							if(isNumeric(dblWork))
							{
								if(dblWork > 0)
								{
									if((parseFloat(dblWork) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)== parseInt(parseFloat(dblWork) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
									{
										var objWorkInHours;
										
										objWorkInHours = document.createElement("INPUT");
										objWorkInHours.name = "txtWorkInHours";
										objWorkInHours.type = "hidden";
										objWorkInHours.value = dblWork;
										objfrmIBIssueEntry.appendChild(objWorkInHours);
										break;
									}
								}
								else
								//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
								alert("<%=mybase.GetResourceString("POSITIVE",false)%>");
								//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							}
							else
							//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							alert("<%=mybase.GetResourceString("ONLYNUMERIC",false)%>");
							//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
						}
						else
							//modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							alert("<%=mybase.GetResourceString("PROVIDEINFO",false)%>");
							//END modified by harshk for sp4 issueid 136 (single quote changed to double quote)
							
						dblWork  = Trim(window.prompt('<%=mybase.GetResourceString("ENTERWORKHOURS",false)%>' + "\n" + '<%=mybase.GetResourceString("DEFAULTWORKHOURS",false)%>'));
					}
				}
			}
		<%End If%>
		
		EnableControls();
		
		
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		<%If Trim(Request.QueryString("FromWhere"))<>"" Then %>
			FromWhere= "<%=m_FromWhere%>";
		<%Else%>
			FromWhere = "";
		<%End If%>
		//Reviewtype parameter added by MrugajaB on 9th Feb 2006 for multiple reviewees feature
		//Modified by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
		<%If Not Request.QueryString("GoTo") Is Nothing Then
            If Request.QueryString("GoTo") = "1" Then%>
               objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewType=<%=strIssueAddedFrom%>&ReviewActionID=<%=intReviewActionID%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=Save&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&FromReview=<%=m_strFromReview%>";
                
            <%end if%>
        <%else%>
		  //Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
			//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewType=<%=strIssueAddedFrom%>&ReviewActionID=<%=intReviewActionID%>&IssueID=<%=m_lngIssueId%>&IssueNavigation=<%=m_blnIssueNavigation%>&Mode=<%=m_strMode%>&Action=Save&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;				
			// Integrated by ArchanaN on 26 Apr 2006
		     //objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewType=<%=strIssueAddedFrom%>&ReviewActionID=<%=intReviewActionID%>&IssueID=<%=m_lngIssueId%>&IssueNavigation=<%=m_blnIssueNavigation%>&Mode=<%=m_strMode%>&Action=Save&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&FromReview=<%=m_strFromReview%>&PKToken=<%=m_strToken%>";		
			//Added by SrikanthY on 21 Dec 2006 To pass parent Query details it it called from Helpdesk Dashboard 
			objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewType=<%=strIssueAddedFrom%>&ReviewActionID=<%=intReviewActionID%>&IssueID=<%=m_lngIssueId%>&IssueNavigation=<%=m_blnIssueNavigation%>&Mode=<%=m_strMode%>&Action=Save&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&FromReview=<%=m_strFromReview%>&PKToken=<%=m_strToken%>&QueryToken=<%=m_PKQueryToken%>&Queryid=<%=m_Queryid%>";		
			//End of Addition by SriaknthY
	        // Integration Ends
	      //End of Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
		<%End If%>
		//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?Mode=<%=m_strMode%>&Action=Save&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
		//Code added by PrashantD on 13 July 2007 for hiding Save link
		var L1 = GetObjectReference('frmMyPage','SAVEUP',true);
		if (L1 != null) {
		L1[0].style.display= "none";
		L1[1].style.display= "none";
		}
		
		objfrmIBIssueEntry.submit();			
		//End Modification by MrugajaB
	}
	
	function ShowToCustomer_OnClick()			
	{
		if (objShowToCustomer==null)
			return;
		if (objShowToCustomer.checked == true)
			objShowToCustomer.value = "1";
		else
			objShowToCustomer.value = "0";		
	}
	
	function InsertTimeStamp()
	{
		var strValue = objDescription.value;
		strValue = strValue + "\n" + "[" + Now(1) + " - <%=Session("strUserName")%>]";
		objDescription.value = strValue;
		setFocus(objDescription);
	}
	
	function cboIssue_onchange()
	{	
	    var browser=WhichBrowser(); //Added By Vaijat K ON 04/11/2015
		//Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
		//Purpose : Firefox Support
		var objIssue = document.forms['frmIBIssueEntry'].elements['cboIssue'];
		//SAVITA 03 Oct 2006
		//window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + objIssue.options[objcboIssue.selectedIndex].value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";										
		    var url="IB_IssueEntry.aspx?IsXMLHTTP=1&IssueID=" + objIssue.options[objcboIssue.selectedIndex].value + "&Fromwhere=Issueonchange"
	    //Added By Vaijat K ON 04/11/2015
		    if (browser == 'IE'){
		        objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
		        objXMLHTTP.onreadystatechange=xmlhttpChange;
		        objXMLHTTP.open("GET",url,false);
		        objXMLHTTP.send(); 
		    }
		    else{
		        objXMLHTTP = new XMLHttpRequest(); 
		        objXMLHTTP.onreadystatechange = xmlhttpChange();
		        objXMLHTTP.open("GET",url,false);
		        objXMLHTTP.send(null);
		        if (objXMLHTTP.responseText != null)
		        {
		            xmlDoc= document.implementation.createDocument("","",null);
		            xmlDoc.async=false;
		            if (browser == 'FF') // Added By Vaijat K ON 09/11/2015
		                xmlDoc.load(objXMLHTTP.responseXML);
		            xmlhttpChange();						
		        }
		    }	
		//Modification Ends by SantoshK on June 6, 2006
		//window.location.href = "IB_IssueEntry.aspx?IssueNavigation=1&IssueID=" + objcboIssue.options(objcboIssue.selectedIndex).value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";							
	}
	
	
	function funcGetDate(strDate) 			
	{
		var strDay;
		var strMonth
		var strYear;
		
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
		
		if ((strDate==null)||(strDate==""))
			return ;
		
		//if(isDate(strDate))
		//{
			var strDate = new date(strDate);
			strMonth = strDate.getMonth;
			strDay = strDate.getDay; 
			if(parseInt(strDay)<= 9) strDay="0" + parseInt(strDay);
			if(parseInt(strMonth)<=9) strMonth="0" + parseInt(strMonth);
			strYear = strDate.getFullYear;
			return Trim(strDay) + "-" + Left(months[strMonth],3) + "-" + Trim(strYear);
		//}
		//else
		//{
			//return ;
		//}
	}
	
	function Type_OnChange()
	{
	
		var ProjectId = <%=m_ProjectID%>, FromWhere;
	
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		<%If Trim(Request.QueryString("FromWhere"))<>"" Then %>
			FromWhere="<%=m_FromWhere%>";
		<%Else%>
			FromWhere = "";
		<%End If%>
		//Reviewtype parameter added by MrugajaB on 9th Feb 2006 for multiple reviewees feature
		EnableControls();	
		<%If Not Request.QueryString("IssueNavigation") Is Nothing Then%>
			//Added by DipaliS the OR Clause
			//Commented and Modified by SavitaS on 21 Sept 2006 for Security Issue 6197 
			//Modified by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
			<%If Request.QueryString("IssueNavigation") = "1" or Request.QueryString("IssueNavigation") = "True" Then%>
			   // objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=1&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>" ;			    
			   objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=1&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>&PKToken=<%=m_strToken%>&FromReview=<%=m_strFromReview%>";			    
			 //Added by DipaliS Else Part
			<%else%>
				//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>";				
				//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>&PKToken=<%=m_strToken%>&FromReview=<%=m_strFromReview%>";				
				 objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>&PKToken=<%=m_strToken%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>";				
            <%end if%>
        <%else%>
				//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&&OrderBy=<%=m_strSortField%>";				
				//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&&OrderBy=<%=m_strSortField%>&PKToken=<%=m_strToken%>&FromReview=<%=m_strFromReview%>"
				objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewType=<%=strIssueAddedFrom%>&IssueNavigation=0&Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere + "&IssueID=<%=m_lngIssueId%>&ASCDESC=<%=m_strSortOrder%>&OrderBy=<%=m_strSortField%>&PKToken=<%=m_strToken%>&FromReview=<%=m_strFromReview%>&QueryToken=<%=m_PKQueryToken%>&QueryID=<%=m_Queryid%>"
	
		<%End If%>
		//End of Modified by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
		//End of Commented and Modified by SavitaS on 21 Sept 2006 for Security Issue 6197 
		//End Modification
		
		//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?Mode=<%=m_strMode%>&Action=TypeChange&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
		objfrmIBIssueEntry.submit();
	}
	
	function ImportIssue_OnClick()
	{
	
		var ProjectId = <%=m_ProjectID%>, FromWhere;
	
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		<%If Trim(Request.QueryString("FromWhere"))<>"" Then %>
			FromWhere="<%=m_FromWhere%>";
		<%Else%>
			FromWhere = "";
		<%End If%>
		
		if(!ValidateControls()) 
			return;
		EnableControls();
		
		<%If Not Request.QueryString("GoTo") Is Nothing Then
            If Request.QueryString("GoTo") = "1" Then%>
                objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=0&Mode=<%=m_strMode%>&Action=ImportIssue&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
			<%end if%>
        <%else%>
				objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?IssueNavigation=1&Mode=<%=m_strMode%>&Action=ImportIssue&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
       <%End If%>
		
		//objfrmIBIssueEntry.action = "IB_IssueEntry.aspx?Mode=<%=m_strMode%>&Action=ImportIssue&PageNumber=<%=m_intPageNumber%>&ProjectID=" + ProjectId + "&FromWhere=" + FromWhere;
		objfrmIBIssueEntry.submit();
	}
	 //Modified by JyotiG on Date 11 July,2006 for PMLifeLine Issue ID.4168
	function Window_OnLoad()
	{
	//Code uncomment and added by PrashantD on 15 March 2007 for IssueID 11420,11469
	<% if request.queryString("FromWhere")&"" = "" OR request.queryString("FromWhere") = "IB" OR request.queryString("FromWhere") = "IssueBase" %>
	    GetObjectReference('frmIBIssueEntry','Summary').style.width="850px";//"98.9%"; 
		GetObjectReference('frmIBIssueEntry','Description').style.width="850px";//"96%"; 
	<%else%>
		GetObjectReference('frmIBIssueEntry','Summary').style.width="98.9%"; 
		GetObjectReference('frmIBIssueEntry','Description').style.width="98.9%"; 
	<% End If %>
	//End of addition by PrashantD on 15 Marh 2007 	
	    var browser=WhichBrowser();
		var intDivHeight ;
		var intDivHeightRisk;
		objDivMain = GetObjectReference('frmIBIssueEntry','DivMain');
	
		if (objDivMain != null)
		{
            //Addede by Nilesh gundecha on 13/10/2015 for change heigth in IE browser
		    if(browser=='IE')
		    {
		       // intDivHeight = (document.body.offsetHeight - objDivMain.offsetTop)+234;
		        intDivHeight = window.innerHeight - objDivMain.offsetTop-48;
		    }
		    else
		    {
		        if (browser == 'CR'){//Added by Vaijat k ON 04/11/2015
		            //intDivHeight = (document.body.offsetHeight - objDivMain.offsetTop - 40);
		            intDivHeight = window.innerHeight - objDivMain.offsetTop-48;}
		        else if(browser == 'FF')
		        { 
		            //Modified by GaneshD on 07 Oct 2009 for PMLifeLine Issue ID-33342- Issue Entry-Edit mode attachment scroll bar
		            //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop + 30;
		            // intDivHeight = (document.body.offsetHeight - objDivMain.offsetTop - 30) + 263;
		            intDivHeight = window.innerHeight - objDivMain.offsetTop-48;
		            // End of modification by GaneshD
		           
		        }
		    }
		
		if (intDivHeight < 100)
		    intDivHeight = 100;
		objDivMain.style.height = intDivHeight+'px';		
		
		}
		<%if strOnloadClientScript<>""%>
		<%=strOnloadClientScript%>
		<%end if%>
		
		if(objShowToCustomer!=null)
		{
			ShowToCustomer_OnClick();
		}
		
		<%IF m_strMode="New" and m_strAction <> "Save" then%>
		if(objSummary!=null)
			setFocus(objSummary);
		<%End IF%>
		//Modified by Shraddham on 8th Aug 2006 for PMLifeLine SP7 Issue ID.4262
		var dt=new Date(); 
			var hr=dt.getHours();
			var min=dt.getMinutes();

			if (hr<10)
				hr='0'+hr;
			if(min<10)
				min='0'+min;
		
			RenderedTime = hr+':'+min;
			RenderedMin = min;
			RenderedHr = hr;
		// End Modification
	}	

	function Window_OnResize()
	{
	
		var intDivHeight ;
		var intDivHeightRisk;
		objDivMain = GetObjectReference('frmIBIssueEntry','DivMain');

		if (objDivMain != null)
		{
			//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			if (intDivHeight < 100)
				intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';		
		}
	}		
	
	function Close_OnClick()
	{
		window.close();
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
	         
	         //added by VivekP On 2 Apr 2005 for copy functionality
	function cboCopyIssue_onchange()
	{	
		//Modified by SantoshK on Date June 6, 2006 for PMLifeLine Issue ID.4168
		//Purpose : Firefox Support
		//var objcboCopyIssue = GetObjectReference('frmIBIssueEntry','cboCopyIssue');
		var objcboCopyIssue = document.forms['frmIBIssueEntry'].elements['cboCopyIssue'];
		//if(objcboCopyIssue.options(objcboCopyIssue.selectedIndex).value != "")
	    if(objcboCopyIssue.options[objcboCopyIssue.selectedIndex].value != "")
			window.location.href = "IB_IssueEntry.aspx?Action=CopyIssue&IssueID=" + objcboCopyIssue.options[objcboCopyIssue.selectedIndex].value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";							
			//window.location.href = "IB_IssueEntry.aspx?Action=CopyIssue&IssueID=" + objcboCopyIssue.options(objcboCopyIssue.selectedIndex).value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortField%>&ASCDESC=<%=m_strSortOrder%>";							
		//Modification Ends by SantoshK on June 6, 2006
	}
	//Added by ManishK on 11th Jan 06 to add Deliverable LINK
	function SelectDeliverable()
    {
	    objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');
	    var DeliverableID= objDeliverableID.value;
		//modified y harshada d for creating deliverable from issues PMLifeLine issue id 1937
		//window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=IB&DeliverableID=' + objDeliverableID.value + '&ProjectID=<%=Session("IssueProject")%>','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');
	     window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=IB&DeliverableID=' + objDeliverableID.value + '&ProjectID=<%=HttpContext.Current.Session("IssueProject")%>','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');
		//end of modification y harshada d for creating deliverable from issues PMLifeLine issue id 1937
    }
//eND OF Added by ManishK on 11th Jan 06 to add Deliverable LINK
         
	
	<%
		if m_strmode.toupper = "NEW" then 
		call PopulateDefaultValues
		end if
	%>	

	//Integrated by ArchanaN on 27 Apr 2007 for Product Execution Project
		// Addded By NitinVS on 24 May 06 for Roamware Customization
		function ProductVersion_OnChange()
		{ 
			getCustomerComboValue('objfrmIBIssueEntry' ,'CustomerID') ;
			
			if (objProductVersionID != null && objProductVersionID.selectedIndex==0)
			{	
				objComponentID.length=0;
				return;
			}
			
			//onSelection('frmCommonPage' ,'MainControl','DependentControl' ,'TagID','PrimaryKeyOfCLCP','Mode');
			onSelection('objfrmIBIssueEntry','ProductVersionID','ComponentID','2133','IssueID','EDIT',<%=m_ProjectId.ToString%>);
		}
	
		function Customer_OnChange()
		{	
		  
			if (objCustomer.selectedIndex==0)
				{	
					objProductVersionID.length=0;
					objComponentID.length=0;
					
					return;
				}
				
			getCustomerComboValue('objfrmIBIssueEntry' ,'CustomerID') ;
		
			onSelection('objfrmIBIssueEntry','CustomerID','ProductVersionID','2133','IssueID','EDIT',<%=m_ProjectId.ToString%>);
			objComponentID.length=0;
		}	
	
	/* Call the  change event for customer and product version if plotted
		
		if (objCustomer != null)
		{
			Customer_OnChange();
			ProductVersion_OnChange();	
		}	
		
		if 	(objProductVersionID != null)
		{
			ProductVersion_OnChange();	
		}
	
		// End Addition By NitinVS on 24 May 06 for Roamware Customization */
		//End of Integration by PrashantD on 2 March 2007
		
		
		
		
		///////////////////////////////////////////////////////////////////////
		<!-- Added By ParagD On 24-May-2006 -->

var depCboValue;

<!--  For Customer Level Product Execution -->

var objCustomerCBO;
var objProductVersionID;
 
function getCustomerComboValue(strForm ,strCustomerCombo) 
{
objCustomerCBO = GetObjectReference(strForm,strCustomerCombo);
}
/*	onSelection (FormName , ChangedControlName , Dependand Control , TagID , Primary Key , 'ADD/EDIT' , ProjectID )
	This method can be called to plot the dependent controls
	Customer -> Product ,
	Product -> Component 
*/

function onSelection(strFrm,strCtrl,strDependentCtrl ,strTagID ,strPK ,strMode,ProjectID)
            {
 				var objCbo; var strUrl; var strMasterPK ; var depCbo;
				var strCustomerControlValue;
				var strComponentValue;
				
				var ProjectID = (arguments.length>6)?arguments[6]:false;
				if (ProjectID == false)
				{
					ProjectID = '';
				}
				
				strMasterPK = GetObjectReference(strFrm,strPK);
				
				global_strFrm = strFrm; global_strDependentCtrl = strDependentCtrl;
				objCbo = GetObjectReference(strFrm,strCtrl);
				depCbo = GetObjectReference(strFrm,strDependentCtrl);
				// Modification By NitinVS on 7 Jun 2006 
				// if the dependant control is having any value selected then only set the values else set to 0  
				if (depCbo.selectedIndex!=-1)
					depCboValue = depCbo[depCbo.selectedIndex].value;
				// End Modification By NitinVS on 7 Jun 2006 
				if (objCbo != null)
				{
					if (objCbo.value != '0' || objCbo.value != '')
					{
						strUrl = new String();
						
						if (objCustomerCBO != null)
						{					
							strCustomerControlValue = objCustomerCBO.value;
							if (strCustomerControlValue != 0)			
							{
							strUrl= "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=" + strCustomerControlValue + "&MasterPKField=" + strPK + "&MasterPKValue=" +strMasterPK.value+ "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID ; 
							}
							else
							{
							strUrl= "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=0&MasterPKField=" + strPK + "&MasterPKValue=" +strMasterPK.value+ "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID ;
							}
						}	
						else
						{
						strUrl= "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=NULL&MasterPKField=" + strPK + "&MasterPKValue=" +strMasterPK.value+ "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID ;
						}
							
						if (objCbo.selectedIndex>-1)
						{
							//INSTANTIATE XmlHttpRequest
							// Checking if IE-specific document.all collection exists 
							// TO SEE IF WE ARE RUNNING IN IE 
							//if (document.all)
						    //{ 
						    if (isIE() == 'IE')
						    {
								objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
								//hook the event handler
								objXHttp.onreadystatechange = HandlerOnReadyState;
								//prepare the call, http method=GET, false=asynchronous call
								objXHttp.open("GET",strUrl, false);
								//finally send the call
								objXHttp.send();          
							} 
							else 
							{ 
                                //Added by Yogesh Jalamkar on 14-June-2016 for Javascript issue
						
							        //End of addition by Yogesh Jalamkar on 14-June-2016
							        // Mozilla - based browser 
							        objXHttp = new XMLHttpRequest(); 
							        //hook the event handler
							        objXHttp.onreadystatechange = HandlerOnReadyState();
							        //prepare the call, http method=GET, false=asynchronous call
							        objXHttp.open("GET",strUrl,false);
							        //finally send the call
							        objXHttp.send(null);
							        //Added By VarunA on 23-Sep-2008 IssueID-22513
							        //Purpose : To have Product & Module/Component value in combo for (Mozilla)
							        if (objXHttp.responseText != null)
							        {
							            xmlDoc= document.implementation.createDocument("","",null);
							            xmlDoc.async=false;
							            //xmlDoc.load(req.responseXML);
							            if (isIE() == 'FF')//Added by Nilesh g on date 10/11/2016 Purpose:Cobobox Issue 
							            xmlDoc.load(objXHttp.responseXML);
							            HandlerOnReadyState();
									
							        }							    
								//End By VarunA on 23-Sep-2008 IssueID-22513
							}
						}
					}
				}
			}
		
		function HandlerOnReadyState()
{

		 
			    //Added By VarunA on 23-Sep-2008 IssueID-22513
                //Purpose : To have Product & Module/Component value in combo for (Mozilla)
			   	var strNavigator = navigator.appName;
					strNavigator = strNavigator.toUpperCase();
			    //End By VarunA on 23-Sep-2008 IssueID-22513
				var objCbo = GetObjectReference(global_strFrm,global_strDependentCtrl);
				if (objXHttp.readyState==4)
				{
				    var i=0;
					var objOption;
					var strText = new String();
					var arrValue = new Array();
					var arrStr = new Array();
					objCbo.innerHTML = "";
					//responseXML contains an XMLDOM object
					if (objXHttp.responseText != null)
					{					
						strText = objXHttp.responseText;
						arrStr = strText.split("|");
					}
					for (i=0; i<arrStr.length; i++)
					{
						objOption = new Option();
						arrValue = arrStr[i].split("->");
						objOption.text =  arrValue[0];
						objOption.value = arrValue[1];
						
						//Modified By VarunA on 23-Sep-2008 IssueID-22513
                        //Purpose : To have Product & Module/Component value in combo for (Mozilla)
						//objCbo.add(objOption);
					//	if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
					    if (isIE() == 'IE')
						    objCbo.add(objOption);
						else
							objCbo.add(objOption,null);
					    //End By VarunA on 23-Sep-2008 IssueID-22513
							
						if(arrValue[1] == depCboValue)
						{
						arrValue[1].selectedIndex = arrValue.length - 1;
						}
						objOption = null;
					}
				}
			}	
			
			//Integrated By ChaitraliH For 'Extend Custom Field' on 26 May 10
			function AddExtCustFields_OnClick()
			{				
				window.open("../IB/IB_ExtendedCustomFields.aspx?IssueID=<%=m_lngIssueID%>&ProjectID=<%=m_ProjectId%>&PkToken=<%=m_strToken%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");				
			}
	 	 //End:Integrated By ChaitraliH For 'Extend Custom Field' on 26 May 10
		 // Integration Ends
		 
		 
    //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 56320)
    //dhn
    var strResult;
    var brw = isIE();
    //dhn
		 function GetIterations(Release)
         {
                var objRelease=GetObjectReference('frmCommonPage','ReleaseID');
                var ReleaseIdVal= (objRelease.options[objRelease.selectedIndex].value);
                if(ReleaseIdVal!="")
                {
                        try 
                        { 
                            var strUrl="../PM/AjaxCallIteration.aspx?EntityName=Issue&ReleaseId=" + ReleaseIdVal;
                            //dhn
                            if (brw == "IE")
                            {
                                objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                            }
                            //dhn
                            else{
                                objXHttp = new XMLHttpRequest();
                            }
                            //dhn
                            objXHttp.onreadystatechange = function() 
                            {
                                if(objXHttp.readyState==4)
                                {  
                                    if(objXHttp.responseText != null)   
                                    {
                                        if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                            alert(objXHttp.responseText);
                                        else
                                            //debugger;
                                            var data; 
                                        data =objXHttp.responseText; 
                                            var data1 = data.substring(1).split(","); 
                                            var objControl; 
                                            document.getElementById('IterationID').options.length = 0;
                                            if (data=='' || data==",Not Available$--$Not Available,Not Available#--#Not Available")
                                            {return;}
                                            //document.getElementById('BuildID').options.length = 0;
                                            //document.getElementById('UserStoryID').options.length = 0;
                                            for(var i=0;i<data1.length;i++) 
                                            {
                                                var str = data1[i].split(","); 
                                                for(var j=0; j<str.length; j++)
                                                {
                                                    var opt = document.createElement("option");
                                                    var val;
                                                    if(str[j].indexOf("$--$")!=-1 && str[j]!="Not Available$--$Not Available")
                                                    {
                                                        objControl = document.getElementById('IterationID')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("$--$");
                                                    }
                                                    else if(str[j].indexOf("@--@")!=-1)
                                                    {
                                                        //objControl = document.getElementById('BuildID')
                                                        objControl.options.add(opt); val=str[j].split("@--@");
                                                    }
                                                    /*else if(str[j].indexOf("#--#")!=-1 && str[j]!="Not Available#--#Not Available")
                                                    {
                                                        objControl = document.getElementById('UserStoryID')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("#--#");
                                                    } */
                                                   
                                                    if(val[0]!='')
                                                    {
                                                        for(var k=0;k<objControl.options.length;k++)
                                                        {
                                                            if(objControl.options[k].value=="")
                                                            {
                                                                objControl.options[k].value=val[0];
                                                                objControl.options[k].text=val[1]; 
                                                            } 
                                                         } 
                                                     } 
                                                     
                                                  } 
                                             }
                                             var objIterationID = document.getElementById('IterationID'); 
                                            //var objBuildID = document.getElementById('BuildID');
                                            //var objUserStoryID = document.getElementById('UserStoryID'); 
                                            var opt = document.createElement("option");  
                                            objIterationID.options.add(opt,0); 
                                            objIterationID.selectedIndex=0; 
                                            /*if(objBuildID.options.innerText!="Not Available")
                                            {
                                                var opt = document.createElement("option"); 
                                                objBuildID.options.add(opt,0);
                                                objBuildID.selectedIndex=0; 
                                            }*/
                                            //if(objUserStoryID.options.innerText!="Not Available")
                                            //{
                                                //var opt = document.createElement("option"); 
                                                //objUserStoryID.options.add(opt,0);
                                                //objUserStoryID.selectedIndex=0;
                                            //}

                                        } 
                                    } 
                                }
                                objXHttp.open("GET",strUrl, false); 
                                objXHttp.send(); 
                        } 
                        catch(e)    
                        {    
                        } 
                  }
                  else
                  {
                        document.getElementById('IterationID').options.length = 0;
                        //document.getElementById('UserStoryID').options.length = 0;
                  }
         }
		 
		    
		    // /IB/IB_IssueEntry.aspx?ReviewStatisticsID=0&ReviewActionID=0&ReviewType=&IssueNavigation=0&Mode=New&Action=TypeChange&PageNumber=1&ProjectID=90&FromWhere=&IssueID=0&ASCDESC=Desc&OrderBy=IssueID&PKToken=&FromReview=0&QueryToken=&QueryID=
		
		 function GetUserStories(UserStory)
		 {
		    var objIteration=GetObjectReference('frmCommonPage','IterationID');
                var IterationIdVal= (objIteration.options[objIteration.selectedIndex].value);
                if(IterationIdVal!="")
                {
                        try 
                        { 
                            var strUrl="../PM/AjaxCallIteration.aspx?Action=GetUserStory&IterationId=" + IterationIdVal;
                            //dhn
                            if (brw == "IE")
                            {
                                objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                            }
                                //dhn
                            else{
                                objXHttp = new XMLHttpRequest();
                            }
                            //dhn
                            objXHttp.onreadystatechange = function() 
                            {
                                if(objXHttp.readyState==4)
                                {  
                                    if(objXHttp.responseText != null)   
                                    {
                                        if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                            alert(objXHttp.responseText);
                                        else
                                            //debugger;
                                            var data; 
                                            data =objXHttp.responseText; 
                                            var data1 = data.substring(1).split(","); 
                                            var objControl; 
                                            document.getElementById('UserStoryID').options.length = 0;
                                            if (data=='')
                                            {return;}
                                            for(var i=0;i<data1.length;i++) 
                                            {
                                                var str = data1[i].split(","); 
                                                for(var j=0; j<str.length; j++)
                                                {
                                                    var opt = document.createElement("option");
                                                    var val;
                                                    if(str[j].indexOf("$--$")!=-1 && str[j]!="Not Available#--#Not Available")
                                                    {
                                                        objControl = document.getElementById('UserStoryID')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("$--$");
                                                    }
                                                                                                      
                                                    if(val[0]!='')
                                                    {
                                                        for(var k=0;k<objControl.options.length;k++)
                                                        {
                                                            if(objControl.options[k].value=="")
                                                            {
                                                                objControl.options[k].value=val[0];
                                                                objControl.options[k].text=val[1]; 
                                                            } 
                                                         } 
                                                     } 
                                                     
                                                  } 
                                             }
                                            
                                            var objUserStoryID = document.getElementById('UserStoryID'); 
                                            var opt = document.createElement("option");  
                                            objUserStoryID.options.add(opt,0); 
                                            objUserStoryID.selectedIndex=0; 


                                        //dhn
                                            if (brw == "FF")
                                            {
                                                xmlDoc= document.implementation.createDocument("","",null);
                                                xmlDoc.async=false;
                                                if (brw == 'FF') // Added By Vaijat K ON 19/11/2015
                                                    xmlDoc.load(objXHttp.responseXML);
                                                var data; 
                                                data =objXHttp.responseText; 
                                                var data1 = data.substring(1).split(","); 
                                                var objControl; 
                                                document.getElementById('UserStoryID').options.length = 0;
                                                if (data=='')
                                                {return;}
                                                for(var i=0;i<data1.length;i++) 
                                                {
                                                    var str = data1[i].split(","); 
                                                    for(var j=0; j<str.length; j++)
                                                    {
                                                        var opt = document.createElement("option");
                                                        var val;
                                                        if(str[j].indexOf("$--$")!=-1 && str[j]!="Not Available#--#Not Available")
                                                        {
                                                            objControl = document.getElementById('UserStoryID')
                                                            objControl.options.add(opt);
                                                            val=str[j].split("$--$");
                                                        }
                                                                                                      
                                                        if(val[0]!='')
                                                        {
                                                            for(var k=0;k<objControl.options.length;k++)
                                                            {
                                                                if(objControl.options[k].value=="")
                                                                {
                                                                    objControl.options[k].value=val[0];
                                                                    objControl.options[k].text=val[1]; 
                                                                } 
                                                            } 
                                                        } 
                                                     
                                                    } 
                                                }
                                            
                                                var objUserStoryID = document.getElementById('UserStoryID'); 
                                                var opt = document.createElement("option");  
                                                objUserStoryID.options.add(opt,0); 
                                                objUserStoryID.selectedIndex=0; 
                                            }
                                        //dhn
                                    }//objXHttp.responseText != null 
                                } //objXHttp.readyState==4
                            }//objXHttp.onreadystatechange
                           
                                objXHttp.open("GET",strUrl, false); 
                                objXHttp.send(); 
                        } //try
                        catch(e)    
                        {    
                        } 
                  }
                  else
                  {
                        document.getElementById('UserStoryID').options.length = 0;
                  }
		 }
		 //End of added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 56320)
				</script>
		</body>
</HTML>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /* Added by Vaijat K ON 05-Nov-2015 */
    .additional_clsTRMenu {
        position: absolute;
        z-index: 999;
        width:200px !important;
        right: 8px !important;
        top: 26px !important;
        display: none;
    }
</style>

<script type="text/javascript">
    $(document).ready(function()
    {

        //Added By Dipali  V On 6th Juy 2020 Get Login Resource name as selected
        if ('<%=m_FromWhere%>' == 'Review') {
            $("#ReportedBy").val('<%=Session("StrUserName")%>');
        }
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