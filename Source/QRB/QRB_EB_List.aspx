<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_EB_List.aspx.vb" Inherits="Whiz.QRB_EB_List"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("TITLE"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	

    <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	<form id="frm" method="post" runat="server">
	<%WritePage()%>
	</form>
	</body>
</HTML>

<script language="javascript">
	var objdiv;
	var objfrm;
	objfrm = GetFormReference('frm');
	objdivlist = GetObjectReference('frm','DivList');<% 'WAF3_PB_42 renamed objdiv to objdivlist (used in QueryBuilder.js onload function)%>
	
	function Expression_OnClick(expid)
	{
		window.location.href = "QRB_EB_Definition.aspx?MasterTagID=1558&Mode=EDIT&ExpressionID=" + expid + "&alphabet=<%=m_strAlphabet%>"; //Modified By Vinay Issue 14864
	}
	
	function RemoveSharing_OnClick(expid)
	{
		if (confirm("<%=Mybase.GetResourceString("MSG_REMOVE_SHARING")%>")==true)
		{
			objfrm.action = "QRB_EB_List.aspx?MasterTagID=1558&Action=REMOVE_SHARING&ExpressionID=" + expid; 
			objfrm.submit();
		}
	}
	
	function ShowOnDashboard_OnClick(expid)
	{
		window.location.href = "QRB_EB_List.aspx?MasterTagID=1558&alphabet=<%=m_strAlphabet%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Action=SHOWONDB&ExpressionID=" + expid ; 
	}
	
	function RemoveFromDashboard_OnClick(expid)
	{
		window.location.href = "QRB_EB_List.aspx?MasterTagID=1558&alphabet=<%=m_strAlphabet%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Action=REMOVEFROMDB&ExpressionID=" + expid ; 
	}
	
	function Share_OnClick(expid)
	{
		window.open("../General/CommonList.aspx?MasterTagID=1561&ExpressionID=" + expid ,"EB_Share","resizable=yes,left=" + (window.screen.width-750)/2 + ",top=" + (window.screen.height-500)/2 + ",scrollbars=no,width=750,height=500");<%'WAF3_PB_42 UmeshJ 20 April 2007 %>
	}
	
	function AddNew_OnClick()
	{
		window.location.href = "QRB_EB_Definition.aspx?MasterTagID=1558&Mode=NEW"; 
	}
	

	function Page_OnClick(alphabet)
	{
		
		window.location.href = "QRB_EB_List.aspx?MasterTagID=1558&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=" + URLEncode(alphabet);//Modified By Shrikant IssueID 20608
	}
	
	function Sort_OnClick(col, order)
	{
		window.location.href = "QRB_EB_List.aspx?MasterTagID=1558&alphabet=<%=m_strAlphabet%>&sortby=" + col + "&sortorder=" + order; 
	}
	
	function Delete_OnClick()
	{
		if (IsCheckboxSelected('frm','chkDelete')==true)
		{
		if (confirm("<%=Mybase.GetResourceString("MSG_DELETE")%>")==true)
		{
		objfrm.action = "QRB_EB_List.aspx?MasterTagID=1558&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=<%=m_strAlphabet%>&Action=DELETE";
		objfrm.submit();
		}
		}
	}
	
	function Execute_OnClick(expid)
	{
        //COMMENTED AND ADDED BY NILESH G ON 2/3/2016 FOR ADD PKTOKEN
	    //window.open("QRB_EB_Output.aspx?MasterTagID=1558&ExpressionID=" + expid ,"EB_Execute","resizable=yes,left=" + (window.screen.width-450)/2 + ",top=" + (window.screen.height-300)/2 + ",scrollbars=no,width=450,height=300");<%'WAF3_PB_42 UmeshJ 20 April 2007 %>
        
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'QRB_EB_List.aspx/GenrateURLToken_RequestShow_TaskType',
	        data: JSON.stringify({ EXPID: expid }),
	        success: function (Result) {
	           // window.open("../PM/PM_EntityAlerts.aspx?AlertEntityID=" + AlertEntityID + "&PKToken=" + Result.d + "&EmployeeAlertID=" + EmployeeAlertID, "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=600,height=460");
	            window.open("QRB_EB_Output.aspx?From=QUERY&MasterTagID=1558&ExpressionID=" + expid + "&PKToken=" + Result.d, "EB_Execute", "resizable=yes,left=" + (window.screen.width - 450) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",scrollbars=no,width=450,height=300");<%'WAF3_PB_42 UmeshJ 20 April 2007 %>
	        },
	        error: function () {
	            alert("Error")
	        }
	    });
	    //END OF COMMENTED AND ADDED BY NILESH G ON 2/3/2016 FOR ADD PKTOKEN
	}	
	<% 'WAF3_PB_42 April 10, 2007 Removed local functions for window onload and resize %>
</script>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

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

    $(window).resize(function(){
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
