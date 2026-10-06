<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_QueryAction.aspx.vb" Inherits="Whiz.QRB_QueryAction" %>
<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.QRB_QueryList", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("WINDOW_TITLE_ADMIN"),,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%>
	<%MyBase.InitializeResources("Resources.StandardMenu", "Resources")%>

<head>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
   

</head>
	<body class='clsBody' MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmQueryAction" name="frmQueryAction" method="post" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
			<%PageInit()%>
		</form>
		<script language="javascript">
		var objdivlist;
		var objform;
		var intcount,i;
		var arrDBUsers;
						
		objform=GetFormReference('frmQueryAction');
		objdivlist=GetObjectReference('frmQueryAction','DivList');
				
		intcount=<%=m_arrDBUsersID.Length%>;
		arrDBUsers = new Array(intcount);
		for(i=0;i<intcount;i++)
			{ arrDBUsers[i]= new Array(2); }
		
		<%For m_intCnt = 0 to m_arrDBUsers.Length-1%>
			arrDBUsers[<%=m_intCnt%>][0] = "<%=m_arrDBUsersID(m_intCnt)%>";
			arrDBUsers[<%=m_intCnt%>][1] = "<%=m_arrDBUsers(m_intCnt)%>";
		<%Next%> 
				
		<%MyBase.InitializeResources("Resources.QRB_QueryList", "Resources")%>;
	<% 'WAF3_PB_42 April 11, 2007 UmeshJ START%>		
	function window_onload()		
	{
		var intFillFactor=(arguments.length>0)?arguments[0]:40;
		windowSize_common(intFillFactor);
		var strMsg;
		WindowLoading();		
		strMsg = "<%=m_strMsgDel%>" + "";
		if(strMsg != "")
		{alert(strMsg);}	
	}
	function window_onresize()		
	{
		var intFillFactor=(arguments.length>0)?arguments[0]:40;
		windowSize_common(intFillFactor);			
		UpdateWindowSize();	
	}	
	<% 'WAF3_PB_42 April 11, 2007 UmeshJ END%>					
		function Tab_OnClick(tab)
		{
			var objTxt;
			objTxt = GetObjectReference('frmQueryAction','hdtxtTab');
			objTxt.value = tab;
			objTxt = GetObjectReference('frmQueryAction','hdtxtAlphabet');
			objTxt.value = "-1";
			
			objform.action = "QRB_QueryAction.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>"; 
			objform.submit();  		
		}
	
		function Paging_OnClick(strAlphabet)
		{
			var objTxt;
			objTxt = GetObjectReference('frmQueryAction','hdtxtAlphabet');
			objTxt.value = URLEncode(strAlphabet);//Modified By Shrikant IssueID 20608
			
			objform.action = "QRB_QueryAction.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&alphabet="+ URLEncode(strAlphabet);  //Modified By Shrikant For Issue ID 14279
			objform.submit();  		
		}
		function Sort_OnClick(sortby,sortorder)
		{
			objform.action = "QRB_QueryAction.aspx?MasterTagID=<%=m_intMasterTagID%>&SortBy=" + sortby + "&SortOrder=" + sortorder; 
			objform.submit();  
		}
		function Query_OnClick(QID)
		{
			var strUsers;
			var ans,i,strURL;
			var show=true;
			for(i=0;i<intcount;i++)
				{				
					if(QID==arrDBUsers[i][0])
					{
						strUsers = arrDBUsers[i][1];
						<% 'Modification by VinayB on 30 MAR 2009 IssueID->28837 %>
						ans = window.confirm("<%=mybase.GetResourceString("MSG_DBSHARE1")%> : " + strUsers + "\r\n<%=mybase.GetResourceString("MSG_DBSHARE2")%>\r\n<%=mybase.GetResourceString("MSG_DBSHARE3",False)%>"); 
						if(ans==true)
							show=true;
						else
							show=false;								
					}
				}	
			if(show==true)
			{
				strURL = "QRB_QueryBuilder.aspx?FromWhere=ADMIN&Tab=<%=m_strTab%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&QueryID=" + QID + "&Mode=EDIT&Alphabet=<%=m_strAlphabet%>&SortOrder=<%=m_strSortOrder%>&SortField=<%=m_strSortBy%>";
				window.open(strURL,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-650)/2 + ",width=780,height=650"); <% 'WAF3_PB_42 April 06, 2007 UmeshJ set width 780 %>
			}	
		}
		function Review_OnClick(QID,strReviewer)
		{
			window.open("QRB_ReviewAssignment.aspx?Mode=<%=CONST_REVIEWASSIGN%>&MasterTagID=<%=m_intMasterTagID%>&Tab=<%=m_strTab%>&SortBy=<%=m_strSortby%>&ParentSortOrder=<%=m_strSortOrder%>&ParentAlphabet=<%=m_strAlphabet%>&QueryID=" + QID,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-530)/2 + ",top=" + (window.screen.height-500)/2 + ",width=530,height=500"); 
		}
		function Execute_OnClick(QID)
		{
			window.open("QRB_UIBuilder.aspx?Tab=<%=m_strTab%>&QueryID=" + QID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-500)/2 + ",width=600,height=500"); 
		}
		function MakePublic_OnClick(QID)
		{
			var strUsers;
			var ans,i;
			var show=true;
			for(i=0;i<intcount;i++)
				{				
					if(QID==arrDBUsers[i][0])
					{
						strUsers = arrDBUsers[i][1];
						<% 'Modification by VinayB on 30 MAR 2009 IssueID->28837%>
						ans = window.confirm("<%=mybase.GetResourceString("MSG_DBSHARE1")%> :\r\n" + "-" + strUsers + "\r\n<%=mybase.GetResourceString("MSG_DBSHARE2")%>\r\n<%=mybase.GetResourceString("MSG_DBSHARE3",False)%>");
						if(ans==true)
							show=true;
						else
							show=false;								
					}
				}	
			if(show==true)
				window.open("<%=m_strQuerySharing_PageURL%>?Mode=ACCESS&Tab=<%=m_strTab%>&MasterTagID=<%=m_intMasterTagID%>&ParentSortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strAlphabet%>&QueryID=" + QID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-470)/2 + ",width=600,height=470"); 
		}
		function Reject_OnClick(QID)
		{
			var ans;
			ans = window.confirm("<%=mybase.GetResourceString("MSG_REJECT")%>"); 
			if(ans==true)
			{
				objform.action = "QRB_QueryAction.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_ACTION_REJECT%>&QueryID=" + QID; 
				objform.submit();  
			}
		}
		function Export_OnClick(QID)
		{
			objform.action = "QRB_QueryAction.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_ACTION_EXPORT%>&QueryID=" + QID; 
			objform.submit();
		}
		function Delete_OnClick()
		{
		    //Added By Ninad on 20 Aug 2007, issue ID - 14474
	        var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmQueryAction','chkDelete')
            if (blnIsRecordSelected == false) {return;}
            //End Addition By Ninad on 20 Aug 2007, issue ID - 14474
			var ans;
			ans = window.confirm("<%=mybase.GetResourceString("MSG_DELETE")%>");
			if(ans==true)
			{
				objform.action = "QRB_QueryAction.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_ACTION_DELETE%>"; 
				objform.submit();
			}
		}
		function SetAccess_OnClick(QID)
		{
			var strUsers;
			var ans,i;
			var show=true;
			for(i=0;i<intcount;i++)
				{				
					if(QID==arrDBUsers[i][0])
					{
						strUsers = arrDBUsers[i][1];
							<% 'Modification by VinayB on 30 MAR 2009 IssueID->28837 %>
						ans = window.confirm("<%=mybase.GetResourceString("MSG_DBSHARE1")%> : " + strUsers + "\r\n<%=mybase.GetResourceString("MSG_DBSHARE2")%>\r\n<%=mybase.GetResourceString("MSG_DBSHARE3",False)%>");
						if(ans==true)
							show=true;
						else
							show=false;								
					}
				}	
			if(show==true)
			window.open("<%=m_strQuerySharing_PageURL%>?Mode=ACCESS&Tab=<%=m_strTab%>&MasterTagID=<%=m_intMasterTagID%>&ParentAlphabet=<%=m_strAlphabet%>&ParentSortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&QueryID=" + QID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-470)/2 + ",width=600,height=470"); 
		}
		function ShowHelp_OnClick(sStatus)
		{
					
			//Getting the help_id based on the current query status selection
			if(sStatus=='<%=CONST_SUBMITTED%>')
			{
				Help_OnClick('QRB_SUBMITTED_QUERIES_ADMIN');
			}
			else if(sStatus=='<%=CONST_PUBLIC%>')
			{
				Help_OnClick('QRB_PUBLIC_QUERIES_ADMIN');
			}
			else if(sStatus=='<%=CONST_EXPORTED%>')
			{
				Help_OnClick('QRB_EXPORTED_QUERIES_ADMIN');
			}
			else 
			{
				Help_OnClick('QRB_SUBMITTED_QUERIES_ADMIN');
			}
		}
		function SelectAll_OnClick()
		{	var rowcount;
			var objTxt,i;
			
			objTxt = GetObjectReference('frmQueryAction','hdtxtRowCount'); 
			rowcount = objTxt.value;
			if(rowcount>0)
			{
				var objChk;
				objChk = GetObjectReference('frmQueryAction','chkDelete',true); 
					
				for(i=0;i<rowcount;i++)
					objChk[i].checked = true;
			}
		}
        <% 'Added By - PushkarK On 04-Jun-2007 For Requirement ID - WAF3_PB_47 %>
        <%=m_strCtMnJs%>
		</script>
	</body>
</HTML>

<!--Including files & Libraries by Miiint Solutions-->
<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:17/01/2015
    /*---------------------------------------------------------*/

    if($('.clsGridTable').length > 0)
    {
        var divName=$('#DivList').attr('id');
        dataCollapse(divName);
    }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Apply FooTable
    /*---------------------------------------------------------*/



    /*----------------------------------------------------------*/
         // Starts Feature Tag:whiz41-Responsive Navigation Tabs
         // Description:Display navigation tabs in dropdown
         // By Whom: Miiint
         // When:09/02/2015
     /*---------------------------------------------------------*/
     var windowWidth=$(window).width();
     $("#tblCap00").next().next('.clsTable').addClass('gridTabsOuterTable');
     $(".gridTabsOuterTable").find('table:first').addClass('responsiveNavigationTabsClass');
     var responsiveNavigationClass='responsiveNavigationTabsClass';
     var responsiveNavigationParentTblClass='gridTabsOuterTable';
     if(windowWidth < 992)
     {
        responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
     }
     else
     {
        $(".gridTabsOuterTable").find('table:first').css('display','block');
     }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    /*---------------------------------------------------------*/


     /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

});



$(window).resize(function()
{
    /*----------------------------------------------------------*/
         // Starts Feature Tag:whiz41-Responsive Navigation Tabs
         // Description:Display navigation tabs in dropdown
         // By Whom: Miiint
         // When:09/02/2015
     /*---------------------------------------------------------*/

     responsiveNavigationTabsResize();


    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    /*---------------------------------------------------------*/


    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on Window Resize
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
    // Starts Feature Tag:whiz41-collapse & close for tablet view
    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
    // By Whom: Miiint
    // When:17/02/2015
    /*---------------------------------------------------------*/
    collapseDivsResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-collapse & close for tablet view
    /*---------------------------------------------------------*/

});
</script>
