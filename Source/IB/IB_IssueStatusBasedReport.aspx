<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_IssueStatusBasedReport.aspx.vb" Inherits="PbNIT.IB_IssueStatusBasedReport"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("System Issue Status Report")%>
	

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()">
		
					<form id="frmIB_IssueStatusBasedReport" method="post" runat="server">
						<%PageInit%>
									<Table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="center" border="0"
										height="0" width="10%">
									</Table>
								
									
								</TD>
							</TR>
							<!--End Of Table Tag To Draw The Graph On The Status Based Report--></TABLE>
					</form>

        <%-- Added by Dhanashri S on 14 Oct 2015--%>
        <style>
            .clsTable td {
                     vertical-align: middle !important;
                    padding: 2px;
                }
        </style>
        <%--End of addition by Dhanashri S on 14 Oct 2014--%>
			
					<Script language="javascript">
		var objform=GetFormReference('frmIB_IssueStatusBasedReport');
		var objdivlist=GetObjectReference('frmIB_IssueStatusBasedReport','DivList');
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 25 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}			
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
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 25 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
		}	
		
		function ChangeStatus(val) {
            //Commented by Yogesh J on 02-Feb-2016 to pass Token
	   //	frmIB_IssueStatusBasedReport.action = "IB_IssueStatusBasedReport.aspx?ProjectID=<%=intProjectID%>&Mode=DISPLAY&ComboVal="+val;
		    frmIB_IssueStatusBasedReport.action = "IB_IssueStatusBasedReport.aspx?ProjectID=<%=intProjectID%>&PKToken=<%=m_strToken%>&Flag=1&Mode=DISPLAY&ComboVal=" + val;
            frmIB_IssueStatusBasedReport.submit();
		}
		
		function ChangeStatus1(val){
		frmIB_IssueStatusBasedReport.action = "IB_IssueStatusBasedReport.aspx?CustomerID=<%=customerid%>&Mode=Dashboard&ComboVal="+val;
		frmIB_IssueStatusBasedReport.submit();
		}
		function ChangeStatus2(val){
		frmIB_IssueStatusBasedReport.action = "IB_IssueStatusBasedReport.aspx?CustomerID=<%=customerid%>&Mode=Dashboard&ComboVal="+val;
		frmIB_IssueStatusBasedReport.submit();
		}
function Status_OnClick(strDiv, strStatus)
		{

	/*		var objDiv
			var objLbl
	
			objDiv = eval('document.all.div' + strDiv);
			objLbl = eval('document.all.lblStatus' + strDiv);
	
			if (objDiv.style.display == "none")
			{
				objDiv.style.display = "";
				objLbl.innerHTML = "<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Status_OnClick(" + strDiv + "," + '"' + strStatus + '"' + ")'><B>-<B></A>&nbsp;<font size='2' face='Arial'>" + strStatus + "</font>"
			}
			else
			{
			objDiv.style.display = "none";
			//objLbl.innerHTML = "<A STYLE=TEXT-DECORATION:NONE Href ='JavaScript:Status_OnClick(" + strDiv + "," + '"' + strStatus + '"' + ")'><B>+<B></A>&nbsp;<font size='2' face='Arial'>" + strStatus + "</font>"
			}	
			window.location.href = "IB_IssueStatusBasedReport.aspx?Status=true"
			frmIB_IssueStatusBasedReport.action = "IB_IssueStatusBasedReport.aspx?Status="+strStatus+"&StatusVal=true";
			frmIB_IssueStatusBasedReport.submit(); */
			//window.open("IB_IssueStatusBasedReport.aspx?Status="+strStatus+"&StatusVal=true","_blank","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500")
		
         //Commented by Yogesh J on 02-Feb-2016 to pass token
		//	window.open("IB_IssueStatusBasedReport.aspx?ComboVal=<%=index%>&ProjectID=<%=intProjectID%>&Status="+strStatus+"&StatusVal=true","_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=1000")
    window.open("IB_IssueStatusBasedReport.aspx?ComboVal=<%=index%>&ProjectID=<%=intProjectID%>&PKToken=<%=m_strToken%>&Status=" + strStatus + "&Flag=1&StatusVal=true", "_self", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=900,height=1000")
      //End of addition by Yogesh J on 02-Feb-2016 to pass token

}
		
		function Status1_OnClick(CustomerID,strStatus)
		{

			
			window.open("IB_IssueStatusBasedReport.aspx?Mode=Dashboard&customerid=" + CustomerID+ "&Status="+strStatus+"&StatusVal=true","_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=1000")

		}
		
		function Status2_OnClick(CustomerID,strStatus)
		{

			
			window.open("IB_IssueStatusBasedReport.aspx?Mode=Dashboard&&Detail=Issue&customerid=" + CustomerID+ "&Status="+strStatus+"&StatusVal=true","_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=900,height=1000")

		}

	function Back_OnClick()
		{
            //Commented by Yogesh J on 02-Feb-2016 to pass Token
			//window.open("IB_IssueStatusBasedReport.aspx?ProjectID=<%=intProjectID%>&ComboVal=<%=index%>","_self","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=600")
	    window.open("IB_IssueStatusBasedReport.aspx?ProjectID=<%=intProjectID%>&PKToken=<%=m_strToken%>&Flag=1&ComboVal=<%=index%>", "_self", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=600")
	    //End of addition by Yogesh J on 02-Feb-2016 to pass Token
	}
		
		function Back1_OnClick()
		{
			window.open("IB_IssueStatusBasedReport.aspx?CustomerID=<%=customerid%>&Mode=Dashboard","_self","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=600")
		}
		
		function Sort_OnClick(OrderBy,ASCDESC)
		{
			
			window.location.href = "IB_IssueStatusBasedReport.aspx?ComboVal=<%=index%>&ProjectID=<%=intProjectID%>&Status=<%=strStatusChange%>&StatusVal=true&OrderBy=" + OrderBy + "&ASCDESC="+ ASCDESC;
		}
		
		
		  function Document_OnClick(intQueryID,strToken)
	{
	//window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	
	
	function ShowSLA_OnClick(QueryID)
{
	window.open ("../CRM/CRM_SLADetails.aspx?Mode=DB&RequestSLA=1&QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
}

function Discussion_OnClick(QueryID,PKToken)
 {
    window.open("IB_IssueStatusBasedReport.aspx?Mode=Discussionthread&QueryID="+QueryID,"" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
 }
	/*	function Help_OnClick(HelpID)
	{
		window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
	}*/

					</Script>
				
	</body>
</HTML>
