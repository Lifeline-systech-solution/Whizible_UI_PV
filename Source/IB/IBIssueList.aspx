<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IBIssueList.aspx.vb" Inherits="PbNIT.IBIssueList" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>

<!DOCTYPE HTML>

<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>
 
<HTML>

	<%PlotPageHeadTag()%>
    

	<body class="clsFullPageBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">	
					<form id="frmIssueList" method="post" runat="server">						
									<%BuildPage()%>
								
					</form>
				
					<script language="javascript">
					
		var objdivlist;
		var objDivIssueList;
		var objfrmIssueList;
		var objcboSelectQuery;
		var objchkDelete;
		//Added by SavitaS on 19 Sept 2006 for Security Issue 6197
		var objXMLHTTP;
		//End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
		/********Code Added********
		'By     :   DipaliS
		'Reason :   My Issues Feature
		'Date   :   3 July 2004
		'Requirement Number :   IB_PBN_ENT_03
		'Addition Made  :   Global Declaration of strDisplay.*/
		var strDisplay;
		strDisplay="";
		/*****End Addition******/
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		objfrmIssueList = GetFormReference('frmIssueList');
		objDivOtherInfo = GetObjectReference('frmIssueList','DivOtherInfo');
		objDivIssueList = GetObjectReference('frmIssueList','DivIssueList');
		objcboSelectQuery = GetObjectReference('frmIssueList','cboSelectQuery');
		objchkDelete = GetObjectReference('frmIssueList','chkDelete');
		//added by SandipL -- IssueID2135
		var strLocation;
		strLocation = "";
		//Modidied by PrajaktaR  on 13th April for PCFC 17574 , Added a querystring 'QueryID' to check Null Combo
		//function cboSelectQuery_OnChange()
		// strQueryID
		//Modified By Parag
		
		//Added by ShraddhaM on 23,Jul 2009 for Search Filters
    var objValidationControlID ; 
 
    var objdtFromDate_Search=GetObjectReference('frmIssueList','FFE29587WHIZ_dtFromDate_Search');
    var objdtToDate_Search=GetObjectReference('frmIssueList','FFE29587WHIZ_dtToDate_Search'); 
         
    var objdtFromDate_SearchWhiz=GetObjectReference('frmIssueList','dtFromDate_Search');
    var objdtToDate_SearchWhiz=GetObjectReference('frmIssueList','dtToDate_Search');
        
    var objcboSearch = GetObjectReference('frmIssueList','cboSearch'); 
    var objtxtSummary_Search=GetObjectReference('frmIssueList','txtSummary_Search');
    var objtxtDescription_Search=GetObjectReference('frmIssueList','txtDescription_Search');
    var objcboType_Search=GetObjectReference('frmIssueList','cboType_Search');
    var objcboStatus_Search=GetObjectReference('frmIssueList','cboStatus_Search');
    var objcboResponsible_Search=GetObjectReference('frmIssueList','cboResponsible_Search');
    var objcboSubmitted_Search=GetObjectReference('frmIssueList','cboSubmitted_Search');      
    var objCalendarFrom = GetObjectReference('frmIssueList','imgCalendarFrom');
    var objCalendarTo = GetObjectReference('frmIssueList','imgCalendarTo');
    var objSearchFor=GetObjectReference('frmIssueList','searchfor');
    var objFromCaption=GetObjectReference('frmIssueList','searchFromDate');
    var objToCaption=GetObjectReference('frmIssueList','searchToDate');
    //added by Nilesh g on 29/12/2015 for add deliverable
    var objcboDeliverable=GetObjectReference('frmIssueList','cboDeliverable');
    

    // Added by GaneshD on 24 Sep 2009
    var objShowToCustomer=GetObjectReference('frmIssueList','cboShowToCust_Search');
    
    //End of addition by GaneshD 
    objValidationControlID = objtxtSummary_Search;
    //Ended by ShraddhaM on 23,Jul 2009 for Search Filters
		
		 
    
    
    
		function cboSelectQuery_OnChange(strOrderBy,strAscOrDesc)
		{
		//Integrated by MrugajaB on 26th April 2005 for PMLifeLine SP3
		//Modified by PrajaktaR  on 13th April for PCFC 17574 , Added a querystring 'QueryID' to check Null Combo
//			objfrmIssueList.action="IBIssueList.aspx?Mode=&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>&QueryID="+strQueryID;
		//End of Modification by PrajaktaR  on 13th April for PCFC 17574 	
	
		//Parag
		// Modified by SandipL on 9 Feb 2006 added QueryID for Identification of Querychange
			 strLocation = "IBIssueList.aspx?QueryID=" + objcboSelectQuery.value; 
			if (strOrderBy != "")
			strLocation = strLocation + "&OrderBy=" + strOrderBy + "&ASCDESC=" + strAscOrDesc ;
			//objfrmIssueList.action="IBIssueList.aspx?OrderBy=" + strOrderBy + "&ASCDESC=" + strAscOrDesc + "&QueryID=" + objcboSelectQuery.value 
			objfrmIssueList.action=strLocation;
			objfrmIssueList.submit(); 	
		//End Modification by SandipL on 9 Feb 2006	
		//End By Parag
			
		}
		
		function Page_Onclick(PageNumber)
		{
			 
			// Modified by SandipL on 3 Feb 2006 
			 strLocation = "IBIssueList.aspx?PageNumber=" + PageNumber
			<%if m_OrderBy <> "" Then %>
			strLocation = strLocation + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
			<% End If %>
			//objfrmIssueList.action = "IBIssueList.aspx?PageNumber=" + PageNumber + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>" ;
			objfrmIssueList.action = strLocation
			objfrmIssueList.submit();
			/*window.location.href = "IBIssueList.aspx?PageNumber=" + PageNumber + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&QueryID" + objcboSelectQuery.value  ;*/
		}
		//ADDED BY AMIT MAHADIK ON 09 JUNE 2011  PMLifeLine ISSUE COPYING
		function IssueCopying_OnClick() 
		{   //Added ProjectID quarystring in url by NitinC on 01 Dec 2011 for  PMLifeLine (Issue 56385)
		    window.open ("../IB/IssueCopying_CommonList.aspx?ProjectID=<%=m_ProjectId%>&MasterTagID=9019" ,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=650");			
		}
		//END ADDED BY AMIT MAHADIK ON 09 JUNE 2011  PMLifeLine ISSUE COPYING  &Mode=CopyIssues
		function AddNew_OnClick() 
		{		
				//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
			//window.location.href = "IB_IssueEntry.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>"; 
			//Code uncommented by SavitaS on 25 Sept 2006
			//Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197			
			window.location.href = "IB_IssueEntry.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>"; 
			//window.location.href = "IB_IssueEntry.aspx?PKToken=<%=m_PKToken_FromIssueList%>&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>"; 			
			//End of Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197			
			//End of Code uncommented by SavitaS on 25 Sept 2006
		}
//integrated by harshada d on 21 DEC 2005 for  PMLifeLine Issue ID 989
	//Added by ManishK On 21th Nov 2005 for No of attachments to the Issue 
	
	function Document_OnClick(intProjectID,intIssueID)	
	{	//COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
        //window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","_Document","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");			
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IBIssueList.aspx/GenrateURLToken',
	        data: JSON.stringify({ intProjectID: intProjectID,EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&IssueID=" + intIssueID + "&PKToken=" + Result.d +"&TagID=0&DocumentType=Issue","_Document","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");			
	        },
	        error: function () {
	          //  alert("Error")
	        }
	    });	
	    
	    //END OF COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
	    
	    //	window.open ("../DB/DocumentType.aspx?IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		}
		
		//End of addition by ManishK On 21th Nov 2005 for No of attachments to the Issue 
//end of integrated by harshada d on 21 DEC 2005 for  PMLifeLine Issue ID 989

		function Query_OnClick()
		{
			window.open ("IB_QueryBuilder.aspx","_Query","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");						
		}
		
		function Views_OnClick()		
		{
			window.open ("IB_ViewBuilder.aspx","_Views","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
		}

		function Settings_OnClick()
		{
			window.open ("IB_UserSettings.aspx","_Settings","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		
		}
		
		function BatchUpdate_OnClick()
		{
			// START : Added by ParagD 14-Sept-2006 : Security Issue 6197		
			// window.open("IB_BatchUpdate.aspx","","resizable=yes,scrollbars=no,left=50,top=50,width=800,height=600");
			
			//commented by SuchitraP on 31-MAY-2007 
			//window.open("IB_BatchUpdate.aspx?PKToken=<%=m_PKToken_FromIssueList%>","","resizable=yes,scrollbars=no,left=50,top=50,width=800,height=600");
			//Addition by SuchitraP on 31-MAY-2007
			window.open("IB_BatchUpdate.aspx?PKToken=<%=m_PKToken_FromIssueList%>","_BatchUpdate","resizable=yes,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 700)/2 + ",width=850,height=700");
			//End of addition by SuchitraP on 31-MAY-2007
			
			// END : Added by ParagD 14-Sept-2006 : Security Issue 6197		
		}

		function SetFilter_OnClick()
		{
			//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
		    //window.open("IBFilters.aspx?OrderBy=<%=m_strSOrtBy%>&ASCDESC=<%=m_strAscOrDesc%>","","resizable=yes,scrollbars=no,left=0,top=" + (window.screen.height - 500)/2 + ",width=" + (window.screen.width-10) + ",height=500");
            //Commented and Modified By Anoruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
		    //window.open("IBFilters.aspx?OrderBy=<%=m_OrderBy%>&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>&ASCDESC=<%=m_strAscOrDesc%>","_SetFilter","resizable=yes,scrollbars=no,left=0,top=" + (window.screen.height - 500)/2 + ",width=" + (window.screen.width-10) + ",height=500");
		    window.open("IBFilters.aspx?OrderBy=<%=m_OrderBy%>&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>&ASCDESC=<%=m_strAscOrDesc%>","_SetFilter","resizable=yes,scrollbars=no,left=0,top=" + (window.screen.height - 500)/2 + ",width=" + (window.screen.width-45) + ",height=500");
		    //End of Commented and Modified By Anoruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
		}
		
		function ClearFilter_OnClick()
		{
				//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
			//objfrmIssueList.action ="IBIssueList.aspx?Filter=C&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value
			 strLocation = "IBIssueList.aspx?Filter=C&PageNumber=<%=m_intPageNumber%>&cboQuery=" + objcboSelectQuery.value ;
			<%if m_OrderBy <> "" Then %>
			strLocation = strLocation + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
			<% End If %>
			//	objfrmIssueList.action ="IBIssueList.aspx?Filter=C&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value ;
			objfrmIssueList.action = strLocation;
			objfrmIssueList.submit();			
		}
		
		function ApplyDefaultSettings_OnClick()
		{
			window.location.href = "IBIssueList.aspx?Mode=Default";		
		}	
		
		function Delete_OnClick()
		{
		//Added by MonikaI on 11-Sep-2006 IssueID : 6022
			if (IsCheckboxSelected('frmIssueList','chkDelete'))
			{
		//End by MonikaI
				if(!confirm('<%=mybase.getresourcestring("CONFIRMDELETE")%>'))
					return;
				//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
				//objfrmIssueList.action="IBIssueList.aspx?Mode=Delete&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>"
				strLocation = "IBIssueList.aspx?Mode=Delete";
				<%if m_OrderBy <> "" Then %>
				strLocation = strLocation + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>"
				<% End If %>
				objfrmIssueList.action = strLocation;
				objfrmIssueList.submit();		
			}
		}

		function Reports_OnClick()
		{
            //Commented by Nilesh gundecha on 14/10/2015 for change height of the window
		    //window.open ("IB2Dreports.aspx","_Reprots","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
		    window.open ("IB2Dreports.aspx","_Reprots","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=560");
		}
		
		function StatusBasedReport_OnClick()
		{
			window.open ("IB_StatusReport.aspx","_StatusBasedReport","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
		}
		
		function ShowReport_OnClick()
		{
			window.open ("IB_ShowReport.aspx","_ShowReport","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
		}
		
		function Refresh_OnClick()
		{
			//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
			//objfrmIssueList.action ="IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value
			 strLocation = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&cboQuery=" + objcboSelectQuery.value;
			<%if m_OrderBy <> "" Then %>
			strLocation = strLocation + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
			<% End If %>
			//objfrmIssueList.action ="IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value
			objfrmIssueList.action = strLocation ;
			objfrmIssueList.submit();
		}
		// Modified By NitinVS on 5 Aug 2005 for  PMLifeLine SP4 IssueID 63 Changed Height to 525	
		function ShowHistory_OnClick(IssueID)
		{
		    //window.open("IB_IssueHistory.aspx?IssueId=" + IssueID,"_ShowHistory","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
		    //Added By Vidya J ON 2 Feb 2016
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'IBIssueList.aspx/GenrateURLToken_ShowHistory_OnClick',
		        data: JSON.stringify({ IssueId: IssueID,EmployeeID: "<%=Session("intUserID")%>"}),
                   success: function (Result) {

                       window.open("IB_IssueHistory.aspx?IssueId=" + IssueID+"&PKToken="+ Result.d,"_ShowHistory","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
                   },
                   error: function () {
                       // alert("Error")
                   }

               });
		    //End Of Added By Vidya J ON 2 Feb 2016  
		}
		// End Modification By NitinVS on 5 Aug 2005 for  PMLifeLine SP4 IssueID 63 Changed Height to 525
	
	//Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197
	/*	function GO_OnClick()		
		{
			var objtxtIssueId;
			objtxtIssueId = GetObjectReference('frmIssueList','txtIssueId');
			if (!disallowBlank(objtxtIssueId,"<%=mybase.GetResourceString("ENTERISSUEID")%>",true) && (!disallowNonNumeric(objtxtIssueId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtIssueId,"<%=mybase.GetResourceString("POSITIVE")%>",true)))
				window.location.href = "IB_IssueEntry.aspx?Goto=1&IssueID=" + objtxtIssueId.value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";				
				//window.location.href = "IB_IssueEntry.aspx?Goto=1&PKTokenForGO="+PKToken+"&IssueID=" + objtxtIssueId.value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";				
		}
*/
	//function ShowDetails_OnClick()		
		//function ShowDetails_OnClick(PKToken)		
		//{
			/*alert("This functionality has not been implemented yet !!");
			return;*/
		/*   var objtxtIssueId;		
			objtxtIssueId = GetObjectReference('frmIssueList','txtIssueId');
			if (!disallowBlank(objtxtIssueId,'Please Enter IssueID !!',true) && (!disallowNonNumeric(objtxtIssueId,'IssueId must be numeric',true)) && (!disallowNegativeNumeric(objtxtIssueId,'IssueId must be Positive',true)))
				window.open ("IB_IssueDetails.aspx?IssueID=" + objtxtIssueId.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");								
				//window.open ("IB_IssueDetails.aspx?IssueID=" + objtxtIssueId.value+"&PKTokenFromShowDetails="+PKToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");								
		} */
		
		
		function ShowDetails_OnClick()		
		{
		    var objtxtIssueId,intIssueID;		
			objtxtIssueId = GetObjectReference('frmIssueList','txtIssueId');
			intIssueID = objtxtIssueId.value;
				if (!disallowBlank(objtxtIssueId,'Please Enter IssueID !!',true) && (!disallowNonNumeric(objtxtIssueId,'IssueId must be numeric',true)) && (!disallowNegativeNumeric(objtxtIssueId,'IssueId must be Positive',true)))
			     {   
			      //Modified By ShraddhaM on 3/10/2006 For SP7 IssuID : 6562
				// code for Mozilla, etc.
					if (navigator.appName =='Netscape')
					{
						var url="IBIssueList.aspx?IsXMLHTTP=1&IssueID=" + intIssueID +"&Fromwhere=ShowDetails"
			 			objXMLHTTP=new XMLHttpRequest()	
						objXMLHTTP.onreadystatechange=xmlhttpChange;
						objXMLHTTP.open("GET",url,true);
						objXMLHTTP.send(null);
					}
					else
					{
						var url="IBIssueList.aspx?IsXMLHTTP=1&IssueID=" + intIssueID +"&Fromwhere=ShowDetails"
			 			objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
						objXMLHTTP.onreadystatechange=xmlhttpChange;
						objXMLHTTP.open("GET",url,false);
						objXMLHTTP.send();
					}
					//Ended By ShraddhaM on 3/10/2006 For SP7 IssuID : 6562
				 } 
		}	
			
			function GO_OnClick()		
			{
			
			 	var objtxtIssueId,intIssueID;
				objtxtIssueId = GetObjectReference('frmIssueList','txtIssueId');
				intIssueID = objtxtIssueId.value;
				if (!disallowBlank(objtxtIssueId,"<%=mybase.GetResourceString("ENTERISSUEID")%>",true) && (!disallowNonNumeric(objtxtIssueId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtIssueId,"<%=mybase.GetResourceString("POSITIVE")%>",true)))			
 				 {					
 				 //Modified By ShraddhaM on 3/10/2006 For SP7 IssuID : 6562
				// code for Mozilla, etc.
					if (navigator.appName =='Netscape')
					{
						var url="IBIssueList.aspx?IsXMLHTTP=1&IssueID=" + intIssueID +"&Fromwhere=GO"
			 			objXMLHTTP=new XMLHttpRequest()		
						objXMLHTTP.onreadystatechange=xmlhttpChange;
						objXMLHTTP.open("GET",url,true);
						objXMLHTTP.send(null);
					}
					else
					{
						var url="IBIssueList.aspx?IsXMLHTTP=1&IssueID=" + intIssueID +"&Fromwhere=GO"
			 			objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
						objXMLHTTP.onreadystatechange=xmlhttpChange;
						objXMLHTTP.open("GET",url,false);
						objXMLHTTP.send();
					}
					//Ended By ShraddhaM on 3/10/2006 For SP7 IssuID : 6562
				 } 
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
						   		
							strIssueID=strNew[i]
							strFrom =strNew[i+1]
							strToken =strNew[i+2]
				 
				 	 if (strFrom=='GO')
						 {
							//window.location.href = "IB_IssueEntry.aspx?Goto=1&PKTokenForGO="+strToken+"&IssueID=" + strIssueID + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";				
							//SearchValue added by ShraddhaM on 12,Aug 2009 to persist Issue Filters
 				 			window.location.href = "IB_IssueEntry.aspx?Goto=1&PKToken="+strToken+"&IssueID=" + strIssueID +"&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";				
 				 		
						}						
						
						if (strFrom=='ShowDetails')
						{
						//window.open ("IB_IssueDetails.aspx?IssueID=" + strIssueID+"&PKTokenFromShowDetails="+strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");								
			               window.open ("IB_IssueDetails.aspx?IssueID=" + strIssueID+"&PKToken="+strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");								
						}		
						
					   if (strFrom=='KeyPress')
						{
							//window.location.href = "IB_IssueEntry.aspx?Goto=1&IssueID=" + objtxtIssueId.value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
							window.location.href = "IB_IssueEntry.aspx?Goto=1&IssueID=" + strIssueID + "&PKToken="+strToken +"&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
					
						}		
							 
					}
			   }
			}		
		}
	
	//Modified by SavitaS on 25 Sept 2006 for Security Issue 6197
		function txtIssueID_OnKeyPress(e)		
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtIssueId;
				objtxtIssueId = GetObjectReference('frmIssueList','txtIssueId');
				intIssueID = trimString(objtxtIssueId.value);
				if (!disallowBlank(objtxtIssueId,"<%=mybase.GetResourceString("ENTERISSUEID")%>",true) && (!disallowNonNumeric(objtxtIssueId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtIssueId,"<%=mybase.GetResourceString("POSITIVE")%>",true)))
					{
					//window.location.href = "IB_IssueEntry.aspx?Goto=1&IssueID=" + objtxtIssueId.value + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
					var url="IBIssueList.aspx?IsXMLHTTP=1&IssueID=" + intIssueID + "&Fromwhere=KeyPress"
					//objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
					if (document.all){
					    objXMLHTTP = new ActiveXObject("Msxml2.XMLHTTP");
					}
					else{
					    objXMLHTTP = new XMLHttpRequest();
					}
					objXMLHTTP.onreadystatechange=xmlhttpChange;
					objXMLHTTP.open("GET",url,false);
					objXMLHTTP.send();
					}
			 }
		} 
		//End of Modified by SavitaS on 25 Sept 2006 for Security Issue 6197
		
		//function IssueDetails(IssueId)
		function IssueDetails(IssueId,PKToken)
		{	
			//window.location.href = "IB_IssueEntry.aspx?IssueID=" + IssueId + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&IssueNavigation=1";
			//SearchType added by ShraddhaM on 23,Jul 2009 for Search functionality
			window.location.href = "IB_IssueEntry.aspx?IssueID=" + IssueId + "&PKToken="+PKToken+"&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&IssueNavigation=1";
		
		}
	//End of Commented and Modified by SavitaS on 19 Sept 2006 for Security Issue 6197	
		
		function ShowDA_OnClick(IssueID)
		{
			window.open("IB_IssueHistory.aspx?IssueID=" + IssueID + "&Mode=TimeSheet","_showDA","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
		}

		function Sort_OnClick(OrderBy,ASCDESC)
		{
			//alert("IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=" + OrderBy + "&ASCDESC="+ ASCDESC + "&cboQuery=" + objcboSelectQuery.value);
			//Modified by SandipL on 15 Feb 2006  added QueryID just for distinction if Previously Query id Unselected
			////window.location.href = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=" + OrderBy + "&ASCDESC="+ ASCDESC + "&cboQuery=" + objcboSelectQuery.value + "&QueryID=" + objcboSelectQuery.value;
			
			objfrmIssueList.action = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=" + OrderBy + "&ASCDESC="+ ASCDESC + "&cboQuery=" + objcboSelectQuery.value + "&QueryID=" + objcboSelectQuery.value;
			objfrmIssueList.submit();
			
			/*objfrmIssueList.action = "IBIssueList.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=" + OrderBy + "&ASCDESC="+ ASCDESC + "&cboQuery=" + objcboSelectQuery.value;
		//	objfrmIssueList.submit();*/
		}
		// Modified By NitinVS on 5 Aug 2005 for  PMLifeLine SP4 IssueID 63 Changed Height to 525
		//Modified by SavitaS on 19 Sept 2006 for Security Issue 6197
		//function ShowDiscussions_OnClick(IssueId)
		//modified by purvaj on 12 Aug 2009 StatusFlowCount parameter added
		function ShowDiscussions_OnClick(IssueId,strPKToken, StatusFlowCount)
		{
			//window.open("IB_Discussion.aspx?IssueID=" + IssueId+"&PageNumber=<%=m_intPageNumber%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
			window.open("IB_Discussion.aspx?IssueID=" + IssueId+"&FromReview=0&Fromwhere=Discussion&PKToken=" + strPKToken+"&PageNumber=<%=m_intPageNumber%>&StatusFlow="+StatusFlowCount+"&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>","_Discussion","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");
		}
		// End modification purvaj
		//End of Modified by SavitaS on 19 Sept 2006 for Security Issue 6197
		// End Modification By NitinVS on 5 Aug 2005 for  PMLifeLine SP4 IssueID 63 Changed Height to 525
				
		function ShowHideOtherInfo() 
		{			
			if(<%=m_ProjectId%>==0)
			return;
			var objtdShowHide_ShowHideOtherInfo = document.getElementById("tdShowHide_ShowHideOtherInfo");
			var objDivOtherInfo = document.getElementById("DivOtherInfo");
			//Code Commented By DipaliS And Added the Following
			// var strDisplay=(arguments.length>0)?arguments[0]:objDivOtherInfo.style.display;
			
				/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :  removed the declaration of strDisplay 
					*/
				strDisplay=(arguments.length>0)?arguments[0]:objDivOtherInfo.style.display;
				/*******End Addition*******/
			
			if (strDisplay != "none") 
			{			   
				//Code commented By Dipalis And Added the following
				//objDivIssueList.style.height = 340;
				/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :  Adjusted The Div height
					*/
					
						if("<%=m_LoginType%>"=="C")
						{
							objDivIssueList.style.height = 340;							
						}
						else
						{
							objDivIssueList.style.height = 480;							
						}
					/*End Addition*/
				
			    objDivOtherInfo.style.display="none";
                //Commented And Added By Vaijat K ON 11/02/2016 for change path of image 
			    //objtdShowHide_ShowHideOtherInfo.src='../../../responsive/images/plus.gif';
                //Added By Dipali Vekhande On 26th July 2016 Change Image Path
			    objtdShowHide_ShowHideOtherInfo.src='../../images/plus.gif';
			    //End Of Addition Dipali Vekhande On 26th July 2016 Change Image Path
			}
			else
			{
				
				//Code commented By Dipalis And Added the following
				//objDivIssueList.style.height = 280;
				/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :  Adjusted The Div height
					*/	if("<%=m_LoginType%>"=="C")
					    {					        
							objDivIssueList.style.height = 280;
					    }
						else
						{						    
							objDivIssueList.style.height = 400;
					    }
				/*End Addition*/
				
			    objDivOtherInfo.style.display="";
			    //Commented And Added By Vaijat K ON 11/02/2016 for change path of image    
				//objtdShowHide_ShowHideOtherInfo.src='../../../responsive/images/minus.gif';
				objtdShowHide_ShowHideOtherInfo.src='../../images/minus.gif';
			}
			//Code commented By Dipalis And Added the following
			
			//window_onresize(); 
			/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :  Adjusted The Div height
					*/
			if("<%=m_LoginType%>"=="C")
			{			   
				window_onresize(); 
			}
			else
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (objDivIssueList != null)
				{
						intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 240;
						if (intDivHeight < 100)
							intDivHeight = 100;			
											
						if (strDisplay != "none") 
						{						  
							objDivIssueList.style.height = intDivHeight+100;		
						}
						else
						{						   			    
							objDivIssueList.style.height = intDivHeight+40;
						}
				}
			}
			/*********End Addition**********/
			
		}

		function window_onresize()		
		{
			
		    document.body.style.height = window.innerHeight - 3 + 'px';
			var intDivHeight ;
			var intDivHeightRisk;
			if (objDivIssueList != null)
			{
				//Code commented By Dipalis And Added the following
					//intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 70;
					/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :   Adjusted the Div Height
					*/
			    if("<%=m_LoginType%>"=="C")
                         //Commented and Added by Yogesh J on 13-Jan-2016
					    //intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 50;
			            intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 50;
			        
					else
			        //intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 200;
			        intDivHeight = window.innerHeight - objDivIssueList.offsetTop - 220;
			    //End of Addition by Yogesh J on 13-Jan-2016
					/*End Addition*/
				if (intDivHeight < 100)
					intDivHeight = 100;			
					objDivIssueList.style.height = intDivHeight +'px';
					
					/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   3 July 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :   Adjusted the Div Height conditionaly..if OtherInfo is not visible it is more
					*/
					if(objDivOtherInfo.style.display=="none" && "<%=m_LoginType%>"!="C")
						objDivIssueList.style.height=intDivHeight + 90;
					/*********End Addition**********/
					//Code Added 8 July to resolve issue 11789
					if("<%=m_LoginType%>"=="E")
					{
					var objDivPaging = GetObjectReference('frmIssueList','DivPaging');
					if(objDivPaging!=null)
						objDivPaging.style.width=document.body.offsetWidth-35;
					objDivIssueList.style.width=document.body.offsetWidth-35;
					}
					//End Addition	
					
									
			}
		}
					
		function window_onload()
		{
		    document.body.style.height = window.innerHeight - 3 + 'px';
			var intDivHeight ;
			var intDivHeightRisk;
				if (objDivIssueList != null)
				{
				   //'Modified by ShraddhaM on Date 21 July,2006 for  PMLifeLine
					//Code commented By Dipalis And Added the following
					//intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 70;
					/*
					'****Code Added*******
					'By     :   DipaliS
					'Reason :   My Issues Feature
					'Date   :   25 June 2004
					'Requirement Number :   IB_PBN_ENT_03
					'Addition Made  :   Client Side Function for Tab_OnClick
					*/
					//if("<%=m_LoginType%>"=="C")
					intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 70;
					 
					/*if(navigator.appName == 'Netscape')
					{
					intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 200;
					}
						
					else
						intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 240;
						
						if(navigator.appName == 'Netscape')
					{
					intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 300;
					}*/
					
					if("<%=m_LoginType%>"=="C")
					{
						//intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 70;
						if(navigator.appName == 'Netscape')
						{
 
						intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 50;
						}
						
						else
						{
						   // intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 50;
						    intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 50;
						
						//if(navigator.appName == 'Netscape')
						//{
 
						//	intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 350;
						//}
						}
					/*End Addition*/
						if (intDivHeight < 100)
							intDivHeight = 100;
						objDivIssueList.style.height = intDivHeight +'px';
					}	
					//Code Added 8 July to resolve issue 11789
					if("<%=m_LoginType%>"=="E")
					{
					 
						var objDivPaging = GetObjectReference('frmIssueList','DivPaging');
						//Added by on 21 Feb 2005 For Issue Id 16218
						//Purpose:To resolve java script error when Issue tab is set as default tab.
						if (objDivPaging==null) {
						var intWidth=document.body.offsetWidth;
						<% ' Modification By NitinVS on 4 Nov 08 for Width Issue in wide screen %>
						//objDivIssueList.style.width=985;	
					    objDivIssueList.style.width=document.body.offsetWidth-35;			
						<% ' End Modification By NitinVS on 4 Nov 08 for Width Issue in wide screen %>					    			
						//return;
						}
						//End Addition	
						
						//if (objDivPaging !=null)
						//objDivPaging.style.width=document.body.offsetWidth-170;
						//objDivIssueList.style.width=document.body.offsetWidth-170;
						if(navigator.appName == 'Netscape')
						{
                            //Commented and added by Yogesh J on 13-Jan-2016
						   // intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 200;
						    intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 220;
						    //End of addition by Yogesh J on 13-Jan-2016
						}
						
						else
						{
						 
							//intDivHeight = document.body.offsetHeight - objDivIssueList.offsetTop - 200;//250;
						    intDivHeight = window.innerHeight  - objDivIssueList.offsetTop - 220;
						
						}
						if (intDivHeight < 100)
							intDivHeight = 100;
						objDivIssueList.style.height = intDivHeight +'px';
					}
					
				 
				}
				
		 
				 
		}
		/*
		 '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issues Feature
        'Date   :   25 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :   Client Side Function for Tab_OnClick
        */
        function Tab_OnClick(tab)
        {
				//Modified by PrajaktaR on 4 May 2005 .The variable <%=m_strSortBy%> changed to m_OrderBy 
			//objfrmIssueList.action ="IBIssueList.aspx?DisplayMode=" + tab + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value
			 strLocation = "IBIssueList.aspx?DisplayMode=" + tab + "&PageNumber=<%=m_intPageNumber%>&cboQuery=" + objcboSelectQuery.value;
			<%if m_OrderBy <> "" Then %>
			strLocation = strLocation + "&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>";
			<%End If%>
			//objfrmIssueList.action ="IBIssueList.aspx?DisplayMode=" + tab + "&PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_OrderBy%>&ASCDESC=<%=m_strAscOrDesc%>&cboQuery=" + objcboSelectQuery.value
			objfrmIssueList.action = strLocation;
			objfrmIssueList.submit();	
        }
        /*End Addition*/
        
        function Copy(IssueID)        
		{
			window.location.href = "IB_IssueEntry.aspx?PageNumber=<%=m_intPageNumber%>&OrderBy=<%=m_strSortBy%>&ASCDESC=<%=m_strAscOrDesc%>&Action=CopyIssue&IssueID=" + IssueID+"&IssueListSearchValue=<%=HttpUtility.HtmlEncode(SearchValue)%>&IssueListSearchType=<%=SearchType%>";			
		}
		
		// Added By NitinVS on 29 July 2005 for  PMLifeLine SP4 IssueID 63
        function txtPageNumber_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
			
				var objtxtpageNumber =  GetObjectReference('frmDashboard','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmDashboard','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
					
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						return;
					}
					Page_Onclick(objtxtpageNumber.value);
				}	
			}
		
		}
		// End Addition By NitinVS on 22 July 2005 IssueID 63 
		//Added by ManishK on 19th Jan 2006 For Select Project Combo on the Issue List Page
		function ChangeProject()
		{
			//Modified by SandipL to resolve Issue of Session Views and queries after Project Change
			//objfrmIssueList.action ="IBIssueList.aspx?FromWhere=BTS&ProjectChanged=1";
			objfrmIssueList.action ="IBIssueList.aspx?FromWhere=BTS&ProjectChanged=1";
			objfrmIssueList.submit();
		}
		//End of Added by ManishK on 19th Jan 2006 For Select Project Combo on the Issue List Page
		//Added by ShraddhaM on 11 July 2007 for CleanUp Activity
		if(GetObjectReference('frmIssueList','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('frmIssueList','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmIssueList','txtPageNumber');
		}

function validateNumPaging()
{

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
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_Onclick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{  

		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}		 
		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
				 
		Page_Onclick(objtxtpageNumber.value);
		 
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_Onclick(objtxtpageNumber.value);
	}
}
//End of addition by ShraddhaM on 11 July 2007

//Addition done by SuchitraP on 13 Feb 2008
function ShowOpenProj()
{
    var objcboProj=GetObjectReference('frmIssueList','cboProject').value='';
	objfrmIssueList.action="../IB/IBIssueList.aspx?StartPage=1&FromWhere=BTS&SelectAll=0";
	objfrmIssueList.submit();
}

function ShowAllProj()
{
	var objcboProj=GetObjectReference('frmIssueList','cboProject').value='';
	objfrmIssueList.action="../IB/IBIssueList.aspx?StartPage=1&FromWhere=BTS&SelectAll=1";
	objfrmIssueList.submit();
}

//End of addition by SuchitraP

 
if(objcboSearch)
    var SearchType = objcboSearch.value;  
    
     switch (SearchType)
    {
        case "1" :   
           objValidationControlID = objtxtSummary_Search;
            break;
        case "2" :     
          
           objValidationControlID = objtxtDescription_Search;
            break;
        case "3" :
            
             objValidationControlID = objcboType_Search;
            break;
        case "4" :            
               objValidationControlID = objcboStatus_Search;
            break;
        case "5" :
               objValidationControlID = objcboResponsible_Search;
            break;
        case "6" :
               objValidationControlID = objcboSubmitted_Search;
            break;       
         case "10":
             objValidationControlID = objcboDeliverable;
        }
function SeachChange()
{                    
  
       var SearchType = objcboSearch.value;  
              
           objtxtSummary_Search.value="";            
           objtxtDescription_Search.value="";
           objcboType_Search.value="";
           objcboStatus_Search.value="";
           objcboResponsible_Search.value="";
           objcboSubmitted_Search.value="";
           //added by Nilesh g on 29/12/2015 for add deliverable
           objcboDeliverable.value="";
           //objdtFromDate_Search.value="";
          // objdtToDate_Search.value="";
          
          //Commented By Vaijat K On 04/11/2015
   //if (navigator.appName =='Netscape')
   // {    
   //      objdtFromDate_Search=GetObjectReference('frmIssueList','dtFromDate_Search');
   //      objdtToDate_Search=GetObjectReference('frmIssueList','dtToDate_Search');
   // }
           
           objtxtSummary_Search.style.display="none";            
           objtxtDescription_Search.style.display="none";
           objcboType_Search.style.display="none";
           objcboStatus_Search.style.display="none";
           objcboResponsible_Search.style.display="none";
           objcboSubmitted_Search.style.display="none";           
           objdtFromDate_Search.style.display="none";
           objdtToDate_Search.style.display="none";  
           objShowToCustomer.style.display="none"; 
           //added by Nilesh g on 29/12/2015 for add deliverable
           objcboDeliverable.style.display="none";
            
          if(objCalendarFrom)
           objCalendarFrom.style.display="none";
           if(objCalendarTo)
           objCalendarTo.style.display="none";
           objFromCaption.style.display="none";
           objToCaption.style.display="none";
           objSearchFor.style.display="none";           
            
          switch (SearchType)
    {  
        case "1" :  //Summary
            
            objSearchFor.style.display="";
            objtxtSummary_Search.style.display="";  
            objValidationControlID = objtxtSummary_Search;
            //objdtFromDate_Search.value="";
            //objdtToDate_Search.value="";
            break;
        case "2" :  //Description
            
            objSearchFor.style.display=""; 
            objtxtDescription_Search.style.display="";
            objValidationControlID = objtxtDescription_Search;
            //objdtFromDate_Search.value="";
           // objdtToDate_Search.value="";
            break;
        case "3" :  //Issue type
            objSearchFor.style.display="";
            objcboType_Search.style.display="";
             objValidationControlID = objcboType_Search;
            // objdtFromDate_Search.value="";
           // objdtToDate_Search.value="";
            break;
        case "4" :  //Status
            objSearchFor.style.display="";        
            objcboStatus_Search.style.display="";
            objValidationControlID = objcboStatus_Search;
           // objdtFromDate_Search.value="";
            //objdtToDate_Search.value="";
            break;
        case "5" :  //Responsible Person
            objSearchFor.style.display="";
            objcboResponsible_Search.style.display="";
            objValidationControlID = objcboResponsible_Search;
            //objdtFromDate_Search.value="";
           // objdtToDate_Search.value="";
            break;
        case "6" :  //Submitted by
            objSearchFor.style.display="";
            objcboSubmitted_Search.style.display="";          
            objValidationControlID = objcboSubmitted_Search;
            //objdtFromDate_Search.value="";
           // objdtToDate_Search.value="";
            break;
        case "7"  :  //Reported Dates
                    
           objdtFromDate_Search.style.display="";
           //objdtFromDate_Search.value="<%=strSearchFromDate%>";
           
           objdtToDate_Search.style.display="";
           //objdtToDate_Search.value="<%=strSearchToDate%>"
            
           objCalendarFrom.style.display="";
           objCalendarTo.style.display="";
           objFromCaption.style.display="";
           objToCaption.style.display="";
                
            break;
            // Added by GaneshD on 24 Sep 2009
        case "8" :  //Status
            objSearchFor.style.display="";      
            objShowToCustomer.style.display="";
            objValidationControlID = objShowToCustomer;
           // objdtFromDate_Search.value="";
            //objdtToDate_Search.value="";
            break;
        case "9" :  //Last Updated
                    
           objdtFromDate_Search.style.display="";
           //objdtFromDate_Search.value="<%=strSearchFromDate%>";
           
           objdtToDate_Search.style.display="";
           //objdtToDate_Search.value="<%=strSearchToDate%>"
            
           objCalendarFrom.style.display="";
           objCalendarTo.style.display="";
           objFromCaption.style.display="";
           objToCaption.style.display="";
                
            break;
            // End of addition by GaneshD
            //added by Nilesh g on 29/12/2015 for add deliverable
              case "10" :
                  objSearchFor.style.display=""; 
                  objcboDeliverable.style.display="";
                  objValidationControlID =objcboDeliverable;
                  break;
        default:
           objtxtSummary_Search.style.display="none";            
           objtxtDescription_Search.style.display="none";
           objcboType_Search.style.display="none";
           objcboStatus_Search.style.display="none";
           objcboResponsible_Search.style.display="none";
           objcboSubmitted_Search.style.display="none";
           objdtFromDate_Search.style.display="none";
           objdtToDate_Search.style.display="none";
           if(objCalendarFrom)
           objCalendarFrom.style.display="none";
           if(objCalendarTo)
           objCalendarTo.style.display="none";
           objFromCaption.style.display="none";
           objToCaption.style.display="none";
           // Added by GaneshD on 24 Sep 2009
           objShowToCustomer.style.display="none";
            // End of addition by GaneshD
            //added by Nilesh g on 29/12/2015 for add deliverable
           objcboDeliverable.style.display="none";
    } 
    
}
function Calender_OnClick(ControlID)
			{					 
				callcalendar('frmIssueList',ControlID);
			}
			
function TextSearch_KeyPress(e)
{
    var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
	if(code==13) 
	{
         ApplyAdvancedFilter();
    }
}
function ApplyAdvancedFilter()
{    
    var objcboSearch = GetObjectReference('frmIssueList','cboSearch'); 
    var SearchType = objcboSearch.value;
         
    if(objcboSearch.value == '')
    {
        alert('Please select any search criteria');
        setFocus(objcboSearch);
        return;
    }
    // Added by GaneshD on 01 Oct 2009 For  PMLifeLine IssueID-33214
    if (SearchType == '1') 
    {
        if (objtxtSummary_Search!=null)
        {
            var valueOfSummary=objtxtSummary_Search.value;
            objtxtSummary_Search.value=valueOfSummary.replace('"',"''");
        }
    }
    if (SearchType == '2')
    {
        if (objtxtDescription_Search!=null)
        {
            var valueOfDes=objtxtDescription_Search.value;
            objtxtDescription_Search.value=valueOfDes.replace('"',"''");
        }
    }
    // end of addition by GaneshD on 01 Oct 2009 
    
    if(SearchType == '7' || SearchType == '9')
    {
        /*if(objdtFromDate_Search == '')
        {
            alert('Please enter FromDate');
            setFocus(objdtFromDate_Search);
            return;
        }
        
        if(objdtToDate_Search == '')
        {
            alert('Please enter FromDate');
            setFocus(objdtToDate_Search);
            return;
        }
        */
        
        if (navigator.appName =='Netscape')
	    {    
	         objdtFromDate_Search=GetObjectReference('frmIssueList','dtFromDate_Search');
             objdtToDate_Search=GetObjectReference('frmIssueList','dtToDate_Search');
	    }
	
       if (navigator.appName =='Netscape')
	    {   
	         objdtFromDate_SearchWhiz = objdtFromDate_Search;
             objdtToDate_SearchWhiz = objdtToDate_Search;
	    }
	    if (disallowDate1LessThanDate2(objdtToDate_SearchWhiz,objdtFromDate_SearchWhiz,"'To Date' cannot be less than 'From Date' : " + objdtFromDate_Search.value)== true)
		{
			return ;
		}	 
		
		
    }
    
    /*else if(objValidationControlID.value == '')
    {
        alert('Please enter search value');
        setFocus(objValidationControlID);
        return;
    }  
    */
    objfrmIssueList.action="../IB/IBIssueList.aspx?ApplySearch=1";
	objfrmIssueList.submit();
}
function Flag_OnClick(IssueID,PKToken)
	{			
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + <%=m_ProjectId%> + "&ContextID=" + IssueID  + "&PkToken="+PKToken+"&ContextType=IB&FromWhich=BTS&fromwhere=Issue","_FlagFollowUp","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}
//Ended by ShraddhM

function Analysis_OnClick()
{
    //Commented and Added by Dhanashri S on 26 Nov 2015
    //window.open ("../Home/DetailView.aspx?MenuGroupID=26","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500" );
    //Added By Vidya J ON 2 Feb 2016
    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'IBIssueList.aspx/GenrateURLToken_Analysis_OnClick',
        data: JSON.stringify({MenuGroupID: 26,EmployeeID: "<%=Session("intUserID")%>"}),
		                success: function (Result) {
		                    
		                    window.open ("../Home/DetailView.aspx?MenuGroupID=26&PKToken="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=950,height=600" );
	                    },
		                error: function () {
		                   // alert("Error")
		                }

		            });
    //End Of Added By Vidya J ON 2 Feb 2016  
  //  window.open ("../Home/DetailView.aspx?MenuGroupID=26","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=950,height=600" );
    //End of Comment and Addition by Dhanashri S on 26 Nov 2015
}
</script>				
	</body>
</HTML>



<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /* Added by Puneet M ON 02-Nov-2015 */
    .additional_clsTRMenu {
        position: absolute;
        z-index: 999;
        width:200px !important;
        right: 8px !important;
        top: 26px !important;
        display: none;
    }
    /*Added by Yogesh J on 25-NOV-2015*/
    #txtPageNumber {
        height:20px!important;
        margin-top:0px!important;
    }
    /*End of addition by Yogesh J on 25-NOV-2015*/
    .clsTable .clsTRMenu td:nth-child(2)
    {
		width:100% !important;
    }
    /*@media only screen and (max-width:1240px) and (min-width:992px)*/


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
            //removeSectionHeader();        //Commented By Puneet M ON 02-Nov-2015
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        //if($('.clsgridtable').length > 0)
        //{
        //    var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        
        // Added by Puneet M ON 02-Nov-2015
        if($('.clsFullPageBody').find("#frmIssueList").find(".clsSubtagTable").find("#DivIssueList").length > 0)
        {
            var divName=$('.clsFullPageBody').find("#frmIssueList").find(".clsSubtagTable").find("#DivIssueList").attr('id');
            var windowWidth=$(window).width();
            if(windowWidth < 992 )
            {
                dataCollapse(divName);
            }
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
        // Added by Puneet M on 02-Nov-2015
        if($('.clsFullPageBody').find("#frmIssueList").find(".clsSubtagTable").find("#DivIssueList").length > 0)
        {
            var divName=$('.clsFullPageBody').find("#frmIssueList").find(".clsSubtagTable").find("#DivIssueList").attr('id');
            dataCollapse(divName);
        }

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
