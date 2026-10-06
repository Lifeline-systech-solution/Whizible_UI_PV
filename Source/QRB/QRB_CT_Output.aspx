<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_CT_Output.aspx.vb" Inherits="Whiz.QRB_CT_Output"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"),,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%><% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	

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
	objdivlist = GetObjectReference('frm','DivListCT');<% 'WAF3_PB_42 renamed objDiv to objDivList (used in QueryBuilder.js onload function)%>
	
	function Detail_OnClick(y,x,queryid, detailqueryid)
	{
		x = replaceSubstring(x,"|||","'");
		y = replaceSubstring(y,"|||","'");
		window.open("QRB_CT_OutputDetail.aspx?QueryID="+ detailqueryid  + "&CTQueryID=" + queryid + "&y=" + y + "&x=" + x,"CT_OutputDetail","menubar=yes,resizable=yes,scrollbars=no,top=100,left=100,height=500,width=600"); 
	}
	
	function ShowGraph_OnClick(queryid)
	{
		window.open("QRB_CT_Graph.aspx?CTQueryID=" + queryid ,"CT_Graph","resizable=yes,scrollbars=no,top=100,left=100,height=560,width=700"); <% 'WAF3_PB_42 April 10, 2007 Change Height%>
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

