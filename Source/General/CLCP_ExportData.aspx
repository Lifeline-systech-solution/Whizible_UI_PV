<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CLCP_ExportData.aspx.vb" Inherits="Whiz.CLCP_ExportData" %>

<!DOCTYPE HTML>
<html>
  <%CommonFunctions.General.PlotPageHeadTag("Export Data")%>
  <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
    <form id="frm" method="post" runat="server">
		<%WritePage()%>
    </form>
  </body>
</html>

<script language="javascript">  
	var objfrm = GetFormReference('frm');
	var objdivlist = GetObjectReference('frm','divList');
	
	<%MyBase.InitializeResources("Resources.CLCP_ExportData","Resources")%>

	function export_onclick(format)
	{
		objfrm.action = "CLCP_ExportData.aspx?<%=m_strQueryStringParameters%>&mode=EXPORT&format=" + format ;
		objfrm.submit();
	}
<% 'WAF3_PB_42 April 10, 2007 Removed local functions window_onresize and modifed window_onload %>
	function window_onload()
	{
		var filename;
		var showmsg;
		var intFillFactor=(arguments.length>0)?arguments[0]:40;
		windowSize_common(intFillFactor);		
		showmsg = <%=m_bytShowMessage%>;
								
		if (showmsg > 0 )
		{
			switch(true)
			{
			case (showmsg == 1 ):
				alert("<%=MyBase.GetResourceString("MSG_NO_ITEMS")%>");
				break;
			case (showmsg == 2 || showmsg == 3 || showmsg == 4):
				alert("<%=MyBase.GetResourceString("MSG_PAGE_EXPIRED")%>");
				window.close();
				break;
			default:
				break;
			}
		}
		else
		{
			filename="<%=m_strFileName%>";		
			if (trimString(filename).length > 0 )
			{
			window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report","");
			}
		}
	}
<% 'WAF3_PB_42 April 10, 2007 END %>	
</script>
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function()
{
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