<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_EB_Variable_List.aspx.vb" Inherits="Whiz.QRB_EB_Variable_List"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("TITLE"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	
    <body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	<form id="frm" method="post" runat="server">
			<%WritePage()%>
	</form>

	<script language="javascript">
	var objdivlist; <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	var objfrm;
	objfrm = GetFormReference('frm');
	objdivlist = GetObjectReference('frm','DivList'); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	
	function Variable_OnClick(variableid)
	{
		window.location.href = "QRB_EB_Variable_Definition.aspx?MasterTagID=1560&Mode=EDIT&VariableID=" + variableid+"&alphabet=<%=m_strAlphabet%>"; //Added by Vinay issue id 14864
	}
	
	function AddNew_OnClick()
	{
		window.location.href = "QRB_EB_Variable_Definition.aspx?MasterTagID=1560&Mode=NEW"; 
	}
	

	function Page_OnClick(alphabet)
	{
		
		window.location.href = "QRB_EB_Variable_List.aspx?MasterTagID=1560&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet="  + URLEncode(alphabet);//Modified By Shrikant IssueID 20608
	}
	
	function Sort_OnClick(col, order)
	{
		window.location.href = "QRB_EB_Variable_List.aspx?MasterTagID=1560&alphabet=<%=m_strAlphabet%>&sortby=" + col + "&sortorder=" + order; 
	}
	
	function Delete_OnClick()
	{
		if (IsCheckboxSelected('frm','chkDelete')==true)
		{
		if (confirm("<%=Mybase.GetResourceString("MSG_DELETE")%>")==true)
		{
		objfrm.action = "QRB_EB_Variable_List.aspx?MasterTagID=1560&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=<%=m_strAlphabet%>&Action=DELETE";
		objfrm.submit();
		}
		}
	}
	
	
	<% 'WAF3_PB_42 April 10, 2007 START
	'Removed local functions for window onresize and load
	'WAF3_PB_42 April 10, 2007 END%>
			

	</script>
</body>
</HTML>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Query >BuilderBuilder>Variables
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:09/02/2015
    /*---------------------------------------------------------*/
    if($('.clsGridTable').length > 0)
    {
        var divName=$('#DivList').attr('id');
        dataCollapse(divName);
    }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration >Query >BuilderBuilder>Variables
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

