<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_CT_QueryList.aspx.vb" Inherits="Whiz.QRB_CT_QueryList"%>
<!DOCTYPE HTML>
<html>
    <%--Added by Komal M on 30th DEC 2020--%> 
   <head>
       <style>
        #DivList {
            overflow-y:scroll;
            height:60%;
        }
</style>
 </head>
    <%--end of added by KomalM on 30th DEC 2020--%> 

	<% CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	

    <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmCTQueryList" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
    
</html>
<script language="javascript">
	var objdiv;
	var objfrm;
	<% '2.0.05-SP8-WAF: Changed the form name from frm to frmCTQueryList %>
	objfrm = GetFormReference('frmCTQueryList');
	objdivlist = GetObjectReference('frmCTQueryList','DivListMain');<% 'WAF3_PB_42 renamed objDiv to objDivList (used in QueryBuilder.js onload function)%>
		
	function Query_OnClick(queryid)
	{
	  		window.location.href = "QRB_CT_Definition.aspx?MasterTagID=1562&Mode=EDIT&CTQueryID=" + queryid+"&alphabet=<%=m_strAlphabet%>"; //Modified By Vinay Issue 14864
	}
	
	function AddNew_OnClick(queryid)
	{
		window.location.href = "QRB_GroupNEntitySelection.aspx?MasterTagID=1562&FromWhere=QRB_CT";
	}
	

	function Page_OnClick(alphabet)
	{

		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=" + URLEncode(alphabet);//Modified By Shrikant IssueID 20608
	}
	
	function Sort_OnClick(col, order)
	{
		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562&alphabet=<%=m_strAlphabet%>&sortby=" + col + "&sortorder=" + order+ "&Sharedsortby=<%=m_strSharedSortBy %>&Sharedsortorder=<%=m_strSharedSortOrder%>";  
	}
	//Added SortSharedQuery_OnClick Function by Vinay IssueID->26157
	function SortSharedQuery_OnClick(col, order)
	{
		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562&alphabet=<%=m_strAlphabet%>&Sharedsortby=" + col + "&Sharedsortorder=" + order+ "&sortby=<%=m_strSortBy %>&sortorder=<%=m_strSortOrder%>"; 
	}
	//Addition End by Vinay on 23 DEC. 2008
	
	function Delete_OnClick()
	{
		if (IsCheckboxSelected('frm','chkDelete')==true)
		{
		if (confirm("Are you sure, you want to delete the selected records?")==true)
		{
		objfrm.action = "QRB_CT_QueryList.aspx?MasterTagID=1562&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=<%=m_strAlphabet%>&Action=DELETE";
		objfrm.submit();
		}
		}
	}
	
	function Execute_OnClick(queryid)
	{
	    
	    //COMMENTED AND ADDED BY NILESH G ON 2/3/2016 FOR ADD PKTOKEN
	    //window.open("QRB_CT_Output.aspx?MasterTagID=1562&CTQueryID=" + queryid ,"CT_Execute","menubar=yes,resizable=yes,scrollbars=no,top=100,left=100,height=500,width=700") ;

	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'QRB_CT_QueryList.aspx/GenrateURLToken_RequestShow_TaskType',
	        data: JSON.stringify({ queryid: queryid }),
	        success: function (Result) {
	      
	            //window.open("QRB_EB_Output.aspx?From=QUERY&MasterTagID=1558&ExpressionID=" + expid + "&PKToken=" + Result.d, "EB_Execute", "resizable=yes,left=" + (window.screen.width - 450) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",scrollbars=no,width=450,height=300");<%'WAF3_PB_42 UmeshJ 20 April 2007 %>
	            window.open("QRB_CT_Output.aspx?MasterTagID=1562&CTQueryID=" + queryid + "&PKToken=" + Result.d, "CT_Execute", "menubar=yes,resizable=yes,scrollbars=no,top=100,left=100,height=500,width=700");
	        },
	        error: function () {
	            alert("Error")
	        }
	    });
	    //END OF COMMENTED AND ADDED BY NILESH G ON 2/3/2016 FOR ADD PKTOKEN
	}
	
	function ShowGraph_OnClick(queryid)
	{
		window.open("QRB_CT_Graph.aspx?MasterTagID=1562&CTQueryID=" + queryid ,"CT_Graph","resizable=yes,scrollbars=no,top=100,left=100,height=560,width=700"); <% 'WAF3_PB_42 April 10, 2007 Change Height%>
	}
	
	<% 'Modified By PushkarK On Thursday, December 07, 2006 For WAF3_QRB_11 %>
	function ShowOnDashboard_OnClick(queryid,isSharedQuery)
	{
	    if (isSharedQuery == null) {isSharedQuery = 0;}
	    
  		window.open("QRB_ShowOnDashboard.aspx?MasterTagID=1862&QueryID=" + queryid + "&IsSharedQuery=" + isSharedQuery + "&IsCrossTabQuery=1", "CT_ShowOnDB","resizable=yes,scrollbars=yes,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-500)/2 + ",height=400,width=600");
	}
	
	<% 'WAF3_PB_42 April 10, 2007 Removed local functions for window onload and resize %>
   	function AddRemoveSharing_OnClick(QID)
	{
		window.open("QRB_CT_QuerySharing.aspx?Mode=SHARE&MasterTagID=1562&CTQueryID=" + QID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-470)/2 + ",width=600,height=470");
	}
	function RemoveShare_OnClick(QID)
	{
		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562&CTQueryID=" + QID + "&Action=DELETE&IsSharedQuery=1&alphabet=<%=m_strAlphabet%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>";
	}
	<% 'Added By - PushkarK On 04-Jun-2007 For Requirement ID - WAF3_PB_47 %>
    <%=m_strCtMnJs%>
</script>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Query >Cross Tab Query
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:09/02/2015
    /*---------------------------------------------------------*/
    if($('.clsGridTable').length > 0)
    {
        var divName;
        if($('#DivList').length > 0)
        {
            divName=$('#DivList').attr('id');
        }
        if($('#DivList2').length > 0)
        {
            divName=$('#DivList2').attr('id');
        }
        dataCollapse(divName);
    }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration >Query >Cross Tab Query
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

