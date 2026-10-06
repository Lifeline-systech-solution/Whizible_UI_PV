<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_QueryResult.aspx.vb" Inherits="Whiz.QRB_QueryResult" %>
<!DOCTYPE HTML>
<html>
<style>
          #thisIsADummyControl
          {
              display:none;/*added By Chakshuta H to solve issue of small textbox plotting near pagination*/
          }
 </style>
	<%CommonFunctions.General.PlotPageHeadTag("Query Output",,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%>


    <body MS_POSITIONING="GridLayout" <%=m_strBodyClass%> onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>

		<form id='frmQueryResult' method='post' runat='server'>
			<%If m_blnUseServerGrid = False Then%>
		    <%  WritePage()%>
		    <%Else%>
		        <div id="DivList" style="width: 100%;height: 300 px;" runat="server"/>
		    <%End If%>
		</form>
		<script type="text/javascript" language="javascript">
		var objform;
		var objdivlist;
		var action;
		action ="<%=m_strAction%>";
		objform = GetFormReference('frmQueryResult');
		objdivlist = GetObjectReference('frmQueryResult','DivList');
		
		function ShowGraph_OnClick(queryid)
		{
			window.open ("QRB_QueryGraph.aspx?sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&QueryID=" + queryid ,"_QueryGraph","resizable=no,scrollbars=no,width=620,height=470");
		}
		<% ' Hotfix ID. - 2.0.16-SP5-WAF : Removed PageNumber_OnClick function %> 
		<% ' Changed Query String Parameter "CurrentPage" to "PagingNumber" %>	
		function Sort_OnClick(sortby, sortorder)
		{
		
			var action;
			<% '�Request ID: 180 - Used URLEncode%>		
			if (action=="PRINTER_FRIENDLY_VERSION")
			{
				querystring = "&Action=PRINTER_FRIENDLY_VERSION";
			}
			else
			{
				querystring = "&PagingNumber=<%=m_lngCurrentPage%>";
			}
			window.location.href = "QRB_QueryResult.aspx?QueryID=<%=m_lngQueryID%>&WhereClause=<%=Server.URLEncode(m_strWhereClause)%>&sortby=" + sortby + "&sortorder=" + sortorder + querystring; 
	    }
		function PrinterFriendlyVersion_OnClick()
		{
			<% '�Request ID: 180 - Used URLEncode%>
			window.open("QRB_QueryResult.aspx?Action=PRINTER_FRIENDLY_VERSION&QueryID=<%=m_lngQueryID%>&WhereClause=<%=Server.URLEncode(m_strWhereClause)%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>","_PrinterFriendlyOutput","resizable=yes,menubar=yes,scrollbars=yes,top=100,left=100,height=600,width=700");
		}
		function Export_OnClick(format)
		{
			window.open("QRB_QueryResult_Export.aspx?Format=" + format + "&EntityID=<%=m_lngEntityID%>&QueryID=<%=m_lngQueryID%>&ConnectionID=<%=m_lngConnectionID%>"); 
		}
<% 'WAF3_PB_42 April 11, 2007 UmeshJ START%>
		function window_onload()
		{
			if (action=="PRINTER_FRIENDLY_VERSION")return;			
		    var intFillFactor=(arguments.length>0)?arguments[0]:80;
		    windowSize_common(intFillFactor);
		}		
		function window_onresize()		
		{
			if (action=="PRINTER_FRIENDLY_VERSION")return;			
		    var intFillFactor=(arguments.length>0)?arguments[0]:80;
		    windowSize_common(intFillFactor);
		}
<% 'WAF3_PB_42 April 11, 2007 UmeshJ END%>			
		</script>
	</body>
</html>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<script type="text/javascript">

$(document).ready(function(){

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Query >Execute
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/

    if($('.clsGridTable').length > 0)
    {
        var divName=$('#DivList').attr('id');
        dataCollapse(divName);
    }
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration >Query >Builder
    /*---------------------------------------------------------*/
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
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
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
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
