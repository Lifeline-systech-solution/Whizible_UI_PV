<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_DrillDown_Detail.aspx.vb" Inherits="Whiz.CDB_DrillDown_Detail" %>
<!DOCTYPE HTML>
<html>

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
	<script src="../../responsive/responsive.js"></script>
<%CommonFunctions.General.PlotPageHeadTag("Drill Down Details")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>



<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added End by KIRAN K K FOR ISSUE ID:2730*/
    .clsGridTable tr td
    {
        white-space: nowrap;
    }

    th:nth-child(2)
    {
        width: 40%;
    }
    /*Added by KIRAN K K FOR ISSUE ID:2730*/
</style>
    <%--<%CommonFunctions.General.PlotPageHeadTag("Drill Down Details")%>--%>
    <body MS_POSITIONING="GridLayout" class="clsCDBBody"  onresize="CDB_window_onresize()" onload="CDB_window_onload()" >
        <form id="frmDrillDown" name="frmDrillDown" runat="server">
            <div class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></div>
                <%WriteMenu()%>
                <table class="clsTable" width='100%' cellpadding="0" cellspacing="0">
                <tr class="clsTrEven">
                    <td  align=left nowrap width='10%'><%WriteDrillDownAttributesCombo()%></td>
                    <td align="right">
					    <a href="javascript:ZoomOut_OnClick(<%=m_intGraphHeight%>,<%=m_intGraphWidth%>)"><img src='../../Images/zoomin.gif' border="0" title='zoom in'></a>
						<a href="javascript:ZoomIn_OnClick(<%=m_intGraphHeight%>,<%=m_intGraphWidth%>)" title='zoom out'><img src='../../Images/zoomout.gif' border="0"></a>
                    </td>
                </tr>
            </table>
            <div id="divMain" style='overflow-x: auto; height: 100%; width: 100%;'>
            <%If (m_intDisplayType = 0) Then%>
                <table class="clsTable" style="width:99.9%;height:100%;" id="tblMain" cellpadding="0" cellspacing="0">                
                    <tr class="clsTrOdd" valign="top">
                        <td width='50%'>
                            <%BuildGrid()%>
                        </td>
                        <td width='50%'>
                            <div id="DivGraph" style="overflow-y:auto;height:260px;width:100%;" >
                                <table class="clsTable" id="tblGraph" width="99.9%;" runat="server"></table>
                            </div>
                        </td>
                    </tr>
                </table>
            <%Else%>
                <br/>
                <div id="DivGraph" style="overflow:auto;height:260px;width:100%;vertical-align:middle;" >
                    <table class="clsTable" id="tblGraph2" style="width:99.9%;height:100%;" runat="server"></table>
                </div>
                <br/>
                <%BuildGrid()%>
            <%End If%>
            </div>			
            
        </form>
    </body>

<style type="text/css">
td.clsSummayTD
{text-align: center;}
    
</style>
    <script language="javascript" type="text/javascript">            
        var strCommonQueryString = "FromWhere=<%=m_strFromWhere%>&DashboardID=<%=m_lngDashboardID%>";
        var intJSDisplayType = <%=m_intDisplayType%>;
        var intJSShowCT=<%=m_intShowCT%>;
        try{document.getElementById('SummaryTD').innerHTML='<B><%=GetFromResourceFile("TITLE_TOTALS")%></B>';}catch(e){}//Added by Ninad on 6 Jan 2009 Req.ID. - WAF3_QRB_17
		function ZoomOut_OnClick(height,width)
		{				
			window.location.href = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&CURR=<%=m_intCurrDrillDown - 1%>&ItemID=<%=m_lngItemID%>&colname=" + URLEncode("<%=m_strPrevAttributeNameForZoom%>") + "&colvalue=" + URLEncode(replaceSubstring("<%=m_strPrevAttributeValueForZoom%>","'","|||")) + "&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE,"|||","'"))%>&height=" + (height+50) + "&width=" + (width+50) + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath,"|||","'"))%>&ShowCT=" + intJSShowCT;			
		}
		function ZoomIn_OnClick(height,width)
		{
			if ((height>100) && (width>100))
			{				
				window.location.href = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&CURR=<%=m_intCurrDrillDown - 1%>&ItemID=<%=m_lngItemID%>&colname=" + URLEncode("<%=m_strPrevAttributeNameForZoom%>") + "&colvalue=" + URLEncode(replaceSubstring("<%=m_strPrevAttributeValueForZoom%>","'","|||")) + "&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE,"|||","'"))%>&height=" + (height-50) + "&width=" + (width-50) + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath,"|||","'"))%>&ShowCT=" + intJSShowCT;				
			}
		}
		function Configuration_OnClick()
		{
			window.open("CDB_DrillDownSettings.aspx?Mode=EDIT&" + strCommonQueryString + "&ItemID=<%=m_lngItemID%>","_ItemConfiguration" , "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 540)/2) + ",height=540,width=600");
		}
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
			colname = replaceSubstring(colname,"|||","'");
			colvalue = replaceSubstring(colvalue,"|||","'");
			if (intJSShowCT == 1)
			{
				window.open ("CDB_DrillDown.aspx?" + strCommonQueryString + "&CURR=<%=m_intCurrDrillDown%>&ItemID="+ itemid + "&colname=" + URLEncode(colname)+ "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||"))+ "&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE,"'","|||"))%>" + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath,"'","|||"))%>" + "&ShowCT=1", "_drillDown<%=m_intCurrDrillDown%>","scrollbars=no,resizable=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640");
			}
			else
			{
			    var sURL = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&CURR=<%=m_intCurrDrillDown%>&ItemID="+ itemid + "&colname=" + URLEncode(colname)+ "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||"))+ "&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE,"'","|||"))%>" + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath,"'","|||"))%>" + "&ShowCT=0";
			    if (intJSDisplayType ==0)
			    {
			        window.open (sURL, "_drillDown<%=m_intCurrDrillDown%>"  ,"scrollbars=no,resizable=yes,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385");
                }
                else
                {
                    window.open (sURL, "_drillDown<%=m_intCurrDrillDown%>"  ,"scrollbars=no,resizable=yes,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620");
                }
			}
		}

        
		function Detail_OnClick(queryid,colname, colvalue)
		{
			var strWhereClause;
			
			colname = replaceSubstring(colname,"|||","'");
			colvalue = replaceSubstring(colvalue,"|||","'");
			window.open ("CDB_DetailQuery_Output.aspx?" + "colname=" + URLEncode(colname)+ "&colvalue=" + URLEncode(colvalue) + "&QueryID=" + queryid + "&" +  strCommonQueryString + "&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&TransactionPageID=<%=m_lngTransactionPageID%>" , "_queryoutput<%=m_intCurrDrillDown%>"  ,"scrollbars=no,resizable=yes,status=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=700,height=500");
		}
		function NextLevel_OnClick()
		{
			if (intJSShowCT == 1)
			{
				window.open ("CDB_DrillDown.aspx?"+ strCommonQueryString + "&ItemID=<%=m_lngItemId%>&CURR=<%=m_intCurrDrillDown%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE, "'", "|||"))%>" + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath, "'", "|||"))%>" + "&ShowCT=1", "_nextlevel<%=m_intCurrDrillDown%>","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640");
			}
			else
			{
			    var sURL = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&ItemID=<%=m_lngItemId%>&CURR=<%=m_intCurrDrillDown%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(Replace(m_strCurrWHERE, "'", "|||"))%>" + "&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(Replace(m_strCurrentDrillDownPath, "'", "|||"))%>" + "&ShowCT=0";
                if (intJSDisplayType ==0)
			    {
				    window.open (sURL, "_nextlevel<%=m_intCurrDrillDown%>" ,"resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385");
                }
                else
                {
                    window.open (sURL, "_nextlevel<%=m_intCurrDrillDown%>" ,"resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620");
                }
			}
		}
		function cboDrillDownAttribut_OnChange()
		{
			var cboDrillDownAttributes = GetObjectReference('frmDrillDown','cboDrillDownAttributes');
			var cboDrillDownVal = cboDrillDownAttributes[cboDrillDownAttributes.selectedIndex].value;
			window.location.href = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&CURR=<%=m_intCurrDrillDown - 1%>&ItemID=<%=m_lngItemID%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(m_strCurrentDrillDownPath)%>&cboVal=" + cboDrillDownVal + "&ShowCT=" + intJSShowCT;
		}
		function CDB_window_onload()
		{		  			
			CDB_windowSize_Changed();	
			WindowLoading();		
		}
		function CDB_window_onresize()
		{
		    CDB_windowSize_Changed();
			UpdateWindowSize();				
		}				
		function CDB_windowSize_Changed()
		{
			var objdivMain = GetObjectReference('frmDrillDown','divMain');
			var objDivGraph = GetObjectReference('','DivGraph');			
		    var objDivList2 = GetObjectReference('','DivList2');
			var intDivHeight; var intFillFactor = 0;//Modified by Ninad on 7 Jan 2009 Req.ID. - WAF3_QRB_17
			if (navigator.appName == 'Microsoft Internet Explorer')
			{intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - intFillFactor;}
			else
			{intDivHeight = window.innerHeight - objdivMain.offsetTop - intFillFactor;}
			if (intDivHeight < 100){intDivHeight = 100;}
			objdivMain.style.height = intDivHeight+'px';
			<%If (m_intDisplayType = 0) Then%>
			intFillFactor=10;
			if (objDivGraph){objDivGraph.style.height=intDivHeight-intFillFactor+'px';}
			if (objDivList2){objDivList2.style.height=intDivHeight-intFillFactor+'px';}
			<%Else%>		
		    if (objDivGraph){objDivGraph.style.height=(intDivHeight- objDivGraph.offsetTop)/2 + 30+'px';}
		    if (objDivList2){objDivList2.style.height=((intDivHeight- objDivGraph.offsetTop)/2)-35+'px';}
			<%End If%>
		}	
    </script>
</html>



