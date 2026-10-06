<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_QueryList.aspx.vb" Inherits="Whiz.QRB_QueryList" %>
<!DOCTYPE HTML>
<HTML><%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle,,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%>
	<head>

        <!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
        <script src="../../responsive/responsive.js"></script>
      <style>
          /*Added by Yogesh J on 13 Jan 2016*/
          #DivList {
              overflow:auto;
              /*Ended  by Yogesh J on 13 Jan 2016*/
          }
      </style>
	</head>
	<body class='clsBody' onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmQueryList" name="frmQueryList" method="post" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
			<%PageInit()%>
		</form>
<script type="text/javascript">
    $(document).ready(function(){

        // Commented And Added By  tejal D for Sodexo Issue Fixing
        $("table").each(function(index){
            if (index==3){
                $(this).css("display","inline-block");
               
            }
        });
       
    //var windowWidth=$(window).width();
   /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:09/02/2015
    /*---------------------------------------------------------*/
   // $("#tblEntityFilter").next().next('.clsTable').addClass('gridTabsOuterTable');
   // $(".gridTabsOuterTable").find('table:first').addClass('responsiveNavigationTabsClass');
   // var responsiveNavigationClass='responsiveNavigationTabsClass';
   // var responsiveNavigationParentTblClass='gridTabsOuterTable';
   // if(windowWidth < 992)
   // {

   //    responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
   // }
   // else
   // {
   //    $(".gridTabsOuterTable").find('table:first').css('display','block');
   // }

   ///*---------------------------------------------------------*/
   //// Ends Feature Tag:whiz41-Responsive Navigation Tabs
   ///*---------------------------------------------------------*/

   // /*----------------------------------------------------------*/
   // // Starts Feature Tag:whiz41-Application Administration >Query >Builder
   // // Description:Apply FooTable
   // // By Whom: Miiint
   // // When:17/01/2015
   // /*---------------------------------------------------------*/

   // if($('.clsGridTable').length > 0)
   // {
   //     var divName;

   //     if($('#DivList1').length >0 )
   //     {
   //        divName=$('.clsBody').find('#DivList1').attr('id');
   //     }
   //     else if($('#DivList2').length >0)
   //     {
   //        divName=$('.clsBody').find('#DivList2').attr('id');
   //     }
   //     else
   //     {
   //       divName=$('.clsBody').find('#DivList').find('#DivList').attr('id');
   //     }
   //     dataCollapse(divName);
   // }
   // /*---------------------------------------------------------*/
   // // Ends Feature Tag:whiz41-Application Administration >Query >Builder
   // /*---------------------------------------------------------*/



   // /*----------------------------------------------------------*/
   //     // Starts Feature Tag:whiz41-InnerMenuDropDown
   //     // Description:Creating DropDown for Top Table Inner Menu on document Ready
   //     // By Whom: Miiint
   //     // When:10/02/2015
   // /*---------------------------------------------------------*/
   // responsiveTopMenu();
   // /*---------------------------------------------------------*/
   // // Ends Feature Tag:whiz41-InnerMenuDropDown
   // /*---------------------------------------------------------*/

   // /*----------------------------------------------------------*/
   //     // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
   //     // Description:Creating DropDown for Footer Table Inner Menu on document Ready
   //     // By Whom: Miiint
   //     // When:10/02/2015
   // /*---------------------------------------------------------*/
   // responsiveFooterMenu();
   // /*---------------------------------------------------------*/
   // // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
   // /*---------------------------------------------------------*/

   // /*----------------------------------------------------------*/
   // // Starts Feature Tag:whiz41-Footable no items
   // // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
   // // By Whom: Miiint
   // // When:21/04/2015
   // /*---------------------------------------------------------*/


   // $('#DivList').find('.clsGridTable').find('td').each(function()
   // {

   //  if($(this).text()=='There are no items to show in this view.')
   //  {
   //      $(this).parents().removeClass('footable-loaded footable');
   //  }
   // });

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footable no items
    /*---------------------------------------------------------*/

//});
//$(window).resize(function()
//{
//    /*----------------------------------------------------------*/
//    // Starts Feature Tag:whiz41-Responsive Navigation Tabs
//    // Description:Display navigation tabs in dropdown
//    // By Whom: Miiint
//    // When:09/02/2015
//    /*---------------------------------------------------------*/

//    responsiveNavigationTabsResize();

//    /*---------------------------------------------------------*/
//    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
//    /*---------------------------------------------------------*/

//    /*----------------------------------------------------------*/
//    // Starts Feature Tag:whiz41-InnerMenuDropDown
//    // Description:Creating DropDown for Table Inner Menu on Window Resize
//    // By Whom: Miiint
//    // When:14/01/2015
//    /*---------------------------------------------------------*/
//    responsiveTopMenuResize();
//    /*---------------------------------------------------------*/
//    // Ends Feature Tag:whiz41-InnerMenuDropDown
//    /*---------------------------------------------------------*/

//    /*----------------------------------------------------------*/
//    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
//    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
//    // By Whom: Miiint
//    // When:10/02/2015
//    /*---------------------------------------------------------*/
//    responsiveFooterMenuResize();
//    /*---------------------------------------------------------*/
//    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
//    /*---------------------------------------------------------*/

//    /*----------------------------------------------------------*/
//    // Starts Feature Tag:whiz41-collapse & close for tablet view
//    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
//    // By Whom: Miiint
//    // When:17/02/2015
//    /*---------------------------------------------------------*/
//    collapseDivsResize();
//    /*---------------------------------------------------------*/
//    // Ends Feature Tag:whiz41-collapse & close for tablet view
//    /*---------------------------------------------------------*/
        // End of Commented code And Addedion(of code) By  tejal D for JDTIAC_NextGen on 16/1/2017*/ 
});

</script>
		<script language="javascript">

		var objdivlist;
		var objform;
		var intcount,i;
		var arrDBUsers;
						
		objform=GetFormReference('frmQueryList');
		objdivlist=GetObjectReference('frmQueryList','DivList');
		
		var strAlphabet = URLEncode("<%=m_strAlphabet%>");//Modified By Shrikant IssueID 20608
		
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
            
		    //Added By Vidya Jadhav ON 26 Sep 2016 For JDTIAC NextGen Upgrade
		    <%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
		    disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>
		    //End Of Added By Vidya Jadhav ON 26 Sep 2016 For JDTIAC NextGen Upgrade
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
	function Query_OnClick(QID)
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
		    //Added By Vidya J On 31 Mar 2016
		    //Uncomment Code by Tejal D for Sodexo Issue Fixing 
		    window.open("QRB_QueryBuilder.aspx?QueryID=" + QID + "&Mode=EDIT&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-600)/2 + ",width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ set width 780 %>
	       //End of Uncomment Code by tejal D for Sodexo Issue Fixing 

	    //Commented by tejal D for Sodexo ISSue Fixing 
		   // $.ajax({
		     //   type: 'POST',
		     //   dataType: 'json',
		      //  contentType: 'application/json',
		       // url: 'QRB_QueryList.aspx/GenrateURLToken_Query_OnClick',
		       // data: JSON.stringify({queryid: QID }),
		       // success: function (Result) {
	            
		           // window.open("QRB_QueryBuilder.aspx?FrmWhere=Query_Click&Token="+Result.d+"&QueryID=" + QID + "&Mode=EDIT&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-600)/2 + ",width=780,height=600");
	       // },
                 // error: function () {
                     // //   alert("Error")
                 // }
		  //  });
       
	    //End Of Addition By Vidya J On 31 Mar 2016
	    //End of Comment By Tejal D for Sodexo ISSue Fixing 
	}
		
	function AddNew_OnClick()
	{
		//modified May 23,05 RajK #BI_78 Issue ID#18878
		//set scrollbars=yes for netscape compatibility
		if(navigator.appName == 'Microsoft Internet Explorer')
				window.open("QRB_GroupNEntitySelection.aspx?MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&Tab=<%=m_strTab%>" ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-600)/2 + ",width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
				
		else
				window.open("QRB_GroupNEntitySelection.aspx?MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&Tab=<%=m_strTab%>" ,"","resizable=yes,menubar=no,scrollbars=yes,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-600)/2 + ",width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		//end modification May 23,05 RajK #BI_78 Issue ID#18878
	}
	function Delete_OnClick()
	{
		var ans;
		if (IsCheckboxSelected('frmQueryList','chkDelete'))
		{
			ans = window.confirm("<%=mybase.GetResourceString("MSG_DELETE")%>");
			if(ans==true)
			{
				objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_DELETE%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
				objform.submit();
			}
		}
	}
	function Move_OnClick(QID,canMove)
	{
		if(canMove==0)
		{
			alert('<%=mybase.GetResourceString("MSG_MOVETOMYQUERY")%>');
		}
		else
		{
			objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_MOVE_PRIVATE%>&QueryID=" + QID + "&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
			objform.submit();
		}
	}
		
	// Executing the query	<% 'WAF3_PB_42 April 11, 2007 UmeshJ Change Width from 600 to 700 %>	
	function Execute_OnClick(QID)
	{
	    
	    //Uncomment Code by tejal D for Sodexo ISSue Fixing 
	    window.open("QRB_UIBuilder.aspx?FromWhere=QUERYLIST&QueryID=" + QID + "&MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=700,height=500");
	   //End of Uncomment Code by tejal D for Sodexo ISSue Fixing 
	    //commented by Tejal D for JDTIAC ISSue Fixing date 19/1/2017
	    //Added By Vidya J On 30 Mar 2016
	  //  $.ajax({
	       // type: 'POST',
	      //  dataType: 'json',
	       // contentType: 'application/json',
	       // url: 'QRB_QueryList.aspx/GenrateURLToken_Execute_OnClick',
	       // data: JSON.stringify({queryid: QID }),
	       // success: function (Result) {
	             
	          //  window.open("QRB_UIBuilder.aspx?Token="+Result.d+"&FromWhere=QUERYLIST&QueryID=" + QID + "&MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=700,height=500");
	           
	      //  },
           // error: function () {
               // //   alert("Error")
            //}
	   // });
	   
	    //End Of Addition By Vidya J On 30 Mar 2016
	    // End of comment by Tejal D for JDTIAC ISSue Fixing date 19/1/2017
	}
	function AddRemoveFavorites_OnClick(QID,Flag)
	{
	
		if(Flag==1)
		{
			objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_ADD_FAVORITE%>&QueryID=" + QID + "&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
			objform.submit();
		}
		else
		{
			objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_REMOVE_FAVORITE%>&QueryID=" + QID + "&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
			objform.submit();	
		}
	}
	function RemoveFromFavorites_OnClick(QID)
	{
		objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_REMOVE_FAVORITE%>&QueryID=" + QID + "&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
		objform.submit();	
	} 
	function RemoveShare_OnClick(QID)
	{
		var ans;
		ans = window.confirm("<%=mybase.GetResourceString("MSG_REMOVESHARE")%>");
		if(ans==true)
		{			
			//Submit to self with the necessary action clause
			objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Action=<%=CONST_REMOVE_SHARE%>&QueryID=" + QID + "&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&ReqEntityID=<%=m_intRequestEntityID%>";
			objform.submit();
		}
	}
	
	//Sharing the query
	function Sharing_OnClick(QID)
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
			window.open("<%=m_strQuerySharing_Page%>?Mode=SHARE&Tab=<%=m_strTab%>&MasterTagID=<%=m_intMasterTagID%>&ParentSortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=" + strAlphabet + "&QueryID=" + QID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-470)/2 + ",width=600,height=470");
				
	}	
	// Submitting of a query to ADMIN
	function Submit_OnClick(QID)
	{		
		var mode;
		if('<%=m_strTab%>' == '<%=CONST_MYQUERY%>')
			mode = '<%=CONST_SUBMIT%>';
		else
			mode = '<%=CONST_REVIEWCOMPLETE%>';
			
		//opening the window to submitting the Query
		window.open("QRB_ReviewAssignment.aspx?Mode=" + mode + "&QueryID=" + QID + "&MasterTagID=<%=m_intMasterTagID%>&Tab=<%=m_strTab%>&SortBy=<%=m_strSortby%>&ParentSortOrder=<%=m_strSortOrder%>&ParentAlphabet=" + strAlphabet,"_New","resizable=yes,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-500)/2 + ",scrollbars=no,width=550,height=500");
	}
	
	function Sort_OnClick(sortby,sortorder)
	{
		objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&SortBy=" + sortby + "&SortOrder=" + sortorder + "&ReqEntityID=<%=m_intRequestEntityID%>&Sharedsortby=<%=m_strSharedSortBy%>&Sharedsortorder=<%=m_strSharedSortOrder%>"; 
		objform.submit();  
	}
		//Added SortSharedQuery_OnClick Function by Vinay IssueID->26157
		function SortSharedQuery_OnClick(sortby, sortorder)
	{
		objform.action = "QRB_QueryList.aspx?MasterTagID=<%=m_intMasterTagID%>&Sharedsortby=" + sortby + "&Sharedsortorder=" + sortorder + "&ReqEntityID=<%=m_intRequestEntityID%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>"; 
		objform.submit(); 
	}
	//Addition End by Vinay on 23 DEC. 2008
	function Copy_OnClick(QID)

	{	//Added By Vidya J On 30 Mar 2016		
		//sending to the query builder page in EDIT mode
	    //window.open("QRB_QueryBuilder.aspx?QueryID=" + QID + "&Mode=COPY&MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&Tab=<%=m_strTab%>","_New","resizable=yes,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-500)/2 + ",scrollbars=no,width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ set width 780 %>
	    
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'QRB_QueryList.aspx/GenrateURLToken_GenerateToken_OnClick',
	        data: JSON.stringify({queryid: QID }),
	        success: function (Result) {
	            
	             window.open("QRB_QueryBuilder.aspx?FrmWhere=Copy_Link&Token="+Result.d+"&QueryID=" + QID + "&Mode=COPY&MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&Tab=<%=m_strTab%>","_New","resizable=yes,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-500)/2 + ",scrollbars=no,width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ set width 780 %>
	          // window.open("QRB_QueryBuilder.aspx?FromWhere=Copy_Link&QueryID=" + QID + "&Token="+ Result.d +"&Mode=COPY&MasterTagID=<%=m_intMasterTagID%>&SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&Tab=<%=m_strTab%>","_New","resizable=yes,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-500)/2 + ",scrollbars=no,width=780,height=600");<% 'WAF3_PB_42 April 06, 2007 UmeshJ set width 780 %>
	        },
                error: function () {
                    //   alert("Error")
                }
	    });
        //End Of Addition By Vidya J On 30 Mar 2016
	}
	
	function Paging_OnClick(strAlphabet)
	{
		var objTxt;
		if (strAlphabet == 'AND') {strAlphabet="&";}
		objTxt = GetObjectReference('frmQueryList','hdtxtAlphabet');
		objTxt.value = URLEncode(strAlphabet);//Modified By Shrikant IssueID 20608
		
		objform.action = "QRB_QueryList.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&ReqEntityID=<%=m_intRequestEntityID%>"; 
		objform.submit();  		
	}
	function Tab_OnClick(tab)
	{
	
		var objTxt;
		objTxt = GetObjectReference('frmQueryList','hdtxtTab');
		objTxt.value = tab;
		GetObjectReference('frmQueryList','hdtxtAlphabet').value = '-1'; //Added by Ninad on 16 Aug 2007 Issue ID - 14504
		objform.action = "QRB_QueryList.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&ReqEntityID=<%=m_intRequestEntityID%>"; 
		objform.submit();  		
	}
	function ShowHelp_OnClick(helpID)
	{
		if(helpID=='<%=CONST_FAVORITE%>')
		{
			Help_OnClick('QRB_FAVORITE_QUERIES');
		}
		else if(helpID=='<%=CONST_MYQUERY%>')
		{
			Help_OnClick('QRB_PRIVATE_QUERIES');
		}
		else if(helpID=='<%=CONST_SUBMITTED%>')
		{
			Help_OnClick('QRB_SUBMITTED_QUERIES');
		}
		else if(helpID=='<%=CONST_REVIEW%>')
		{
			Help_OnClick('QRB_REVIEW_QUERIES');
		}
		else if(helpID=='<%=CONST_PUBLIC%>')
		{
			Help_OnClick('QRB_PUBLIC_QUERIES');
		}
		else if(helpID=='<%=CONST_EXPORTED%>')
		{
			Help_OnClick('QRB_EXPORTED_QUERIES');
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

		function Entity_OnChange()
		{	var objcboEntityFilter = GetObjectReference('frmQueryList','cboEntityFilter');
			var strReqEntityID = '0';
			var objTxt;
			objTxt = GetObjectReference('frmQueryList','hdtxtAlphabet');
			objTxt.value = '';
			if (objcboEntityFilter != null)
			{
				strReqEntityID = objcboEntityFilter[objcboEntityFilter.selectedIndex].value;
				if (strReqEntityID == '') {strReqEntityID = '0';}
				objform.action = "QRB_QueryList.aspx?SortBy=<%=m_strSortby%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_intMasterTagID%>&ReqEntityID=" + strReqEntityID; 
				objform.submit();
			}
		}
	    <% 'Added By PushkarK On Thursday, December 07, 2006 For WAF3_QRB_11 %>
	    function ShowOnDashboard_OnClick(queryid)
	    {
		    window.open("QRB_ShowOnDashboard.aspx?MasterTagID=1862&QueryID=" + queryid + "&IsCrossTabQuery=0", "QRB_ShowOnDB","resizable=yes,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-500)/2 + ",height=400,width=600");
	    }
	    <% 'Added By - PushkarK On 04-Jun-2007 For Requirement ID - WAF3_PB_47 %>   
	    <%=m_strCtMnJs%>
        </script>
	</body>
</HTML>
