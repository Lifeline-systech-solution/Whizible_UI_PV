<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CDB_Main_Graph.aspx.vb" Inherits="Whiz.CDB_Main_Graph" %>
<!DOCTYPE html>

	<%CommonFunctions.General.PlotPageHeadTag("Graph")%>
	<body class="clsCDBBody"  onresize="CDB_window_onresize()" onload="CDB_window_onload()" >
        <form id="frmCDBMainGraph" method="post" runat="server">           	
            <% WritePage()%>
            <div id="divGraphs" runat="server">
                <table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle" width="100%"></table>
            </div>
        </form>
        <div class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></div>

        <script type="text/javascript">
            var strFromWhere = '<%=m_strFromWhere%>';
            var strFromWhereQS = 'FromWhere=' + strFromWhere;
            var strCommonQueryString = strFromWhereQS + '&DashboardID=<%=m_lngDashboardID%>';

            function DrillDown_OnClick(intDisplayType, intShowCT, itemid, colname, colvalue) {
                if (intShowCT == 1) {
                    window.open("CDB_DrillDown.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname, "'", "|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue, "'", "|||")) + "&ShowCT=1", "_drillDown", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990) / 2) + ",top=" + ((window.screen.height - 640) / 2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
                }
                else {
                    var sUrl = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname, "'", "|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue, "'", "|||")) + "&ShowCT=0";
                    if (intDisplayType == 0) {
                        window.open(sUrl, "_cdbmaingraph", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840) / 2) + ",top=" + ((window.screen.height - 385) / 2) + ",width=840,height=385"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                    else {
                        window.open(sUrl, "_cdbmaingraph", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840) / 2) + ",top=" + ((window.screen.height - 620) / 2) + ",width=840,height=620"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                }

                window.status = "View drill downs";
            }

            function callDetail(itemid, showdrilldowns, intShowCT, intDisplayType) {
                if (showdrilldowns == 1) {
                    if (intShowCT == 1) {
                        window.open("CDB_DrillDown.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=1", "_drillDown", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990) / 2) + ",top=" + ((window.screen.height - 640) / 2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                    else {
                        var sUrl = "CDB_DrillDown_Detail.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=0";
                        if (intDisplayType == 0) {
                            window.open(sUrl, "_cdbmaingraph", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840) / 2) + ",top=" + ((window.screen.height - 385) / 2) + ",width=840,height=385"); //WAF3_PB_42 April 17, 2007 NinadP
                        }
                        else {
                            window.open(sUrl, "_cdbmaingraph", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840) / 2) + ",top=" + ((window.screen.height - 620) / 2) + ",width=840,height=620"); //WAF3_PB_42 April 17, 2007 NinadP
                        }
                    }
                
                }
                else {
                    alert("No drilldowns are available for this graph!");
                }
            window.status = "View drill downs";
            }

            function CDB_window_onload() {
                CDB_windowSize_Changed();
                WindowLoading();
            }
            function CDB_window_onresize() {
                CDB_windowSize_Changed();
                UpdateWindowSize();
            }
            function CDB_windowSize_Changed() {

                var objDivGraph = GetObjectReference('', 'divGraphs');

                var intDivHeight; var intFillFactor = 0;//Modified by Ninad on 7 Jan 2009 Req.ID. - WAF3_QRB_17
                if (navigator.appName == 'Microsoft Internet Explorer')
                { intDivHeight = document.body.offsetHeight - objDivGraph.offsetTop - intFillFactor; }
                else
                { intDivHeight = window.innerHeight - objDivGraph.offsetTop - intFillFactor; }
                if (intDivHeight < 100) { intDivHeight = 100; }
                objDivGraph.style.height = intDivHeight;
			
                intFillFactor = 10;
                if (objDivGraph)
                { objDivGraph.style.height = intDivHeight - intFillFactor; }
			
                
			
            }
        </script>
        
        <script type="text/javascript">
        </script>
        <%=m_strClientSideScript%>
    </body>
</html>


<!--Including files & Libraries by Miiint Solutions-->

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>

<script type="text/javascript">

    $(document).ready(function () {
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
    });


    $(window).resize(function () {
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



