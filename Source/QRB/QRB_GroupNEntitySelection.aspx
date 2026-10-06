<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_GroupNEntitySelection.aspx.vb" Inherits="Whiz.QRB_GroupNEntitySelection"%>
<!DOCTYPE HTML>
<HTML>
	<% CommonFunctions.General.PlotPageHeadTag("Group and Entity Selection", , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	

    <body class="clsCommonSubTagBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		<form id="frmQRBGroupNEntity" name="frmQRBGroupNEntity" method="post" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; LEFT: 200px; TOP: 10px; VISIBILITY: hidden; POSITION: absolute"></DIV>
			<%PageInit()%>
		</form>
	</body>
</HTML>
<script language="javascript">
	var objdivlist;
	var objform;
			
	objform=GetFormReference('frmQRBGroupNEntity');
	objdivlist=GetObjectReference('frmQRBGroupNEntity','DivList');
	
	function Group_OnClick(groupid)
	{
		// Modified Dec 15,2004 Rajanikant Khethawatt
		window.location.href = "QRB_GroupNEntitySelection.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_strMasterTagID%>&Mode=ENTITYLIST&GroupID=" + groupid;  
	}
	
	function Back_OnClick()
	{
		// Modified Dec 15,2004 Rajanikant Khethawatt
		window.location.href = "QRB_GroupNEntitySelection.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_strMasterTagID%>&Mode=GROUPLIST"; 
	}
	
	function Entity_OnClick(entityid)
	{
		var objTxt,strAlphabet;
		objTxt = GetObjectReference('frmQRBGroupNEntity','hdAlphabet');
		strAlphabet=objTxt.value;
		// Modified Dec 15,2004 Rajanikant Khethawatt
		if ("<%=m_strFromWhere%>" == "QRB_CT")		
		{
		window.location.href = "QRB_CT_Definition.aspx?MasterTagID=1562&FromWhere=<%=m_strFromWhere%>&GroupID=<%=m_lngGroupID%>&SortOrder=<%=m_strSortOrder%>&Mode=NEW&EntityID=" + entityid + "&Alphabet=" + strAlphabet ; 
		}
		else
		{
		window.location.href = "QRB_QueryBuilder.aspx?MasterTagID=<%=m_strMasterTagID%>&GroupID=<%=m_lngGroupID%>&SortOrder=<%=m_strSortOrder%>&Mode=NEW&EntityID=" + entityid + "&Alphabet=" + strAlphabet ; 
		}
	}
	
	// Added Dec 15,2004 Rajanikant Khethawatt
	function BackToCT_OnClick()
	{
		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562";
	}
	// end addition
	function Sort_OnClick(sortby,sortorder)
	{
		objform.action = "QRB_GroupNEntitySelection.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_strMasterTagID%>&Mode=ENTITYLIST&GroupID=<%=m_lngGroupID%>&SortOrder=" + sortorder; 
		objform.submit();  
		//window.location.href = "QRB_GroupNEntitySelection.aspx?Mode=ENTITYLIST&GroupID=<%=m_lngGroupID%>&SortBy=" + sortby + "&SortOrder=" + sortorder; 
	}
	function Paging_OnClick(strAlphabet)
	{
		var objTxt;
		objTxt = GetObjectReference('frmQRBGroupNEntity','hdAlphabet');
		objTxt.value = URLEncode(strAlphabet);//Modified By Shrikant IssueID 20608
		
		objform.action = "QRB_GroupNEntitySelection.aspx?FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_strMasterTagID%>&Mode=<%=m_strMode%>&GroupID=<%=m_lngGroupID%>&SortOrder=<%=m_strSortOrder%>"; 
		objform.submit();  		
	}
	function Detail_OnClick(EntityID)
	{
		window.open("../General/Help.aspx?FROM=QRB&HelpID="+ EntityID ,"","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
	}
	
	function window_onload()		
	{
	   var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>	
		WindowLoading(true,true);	
	}
	function window_onresize()		
	{
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		UpdateWindowSize(true,true);	
	}
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

