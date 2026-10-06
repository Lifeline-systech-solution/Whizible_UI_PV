<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ShowProjectDetailGraph.aspx.vb" Inherits="PbNIT.ShowProjectDetailGraph" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("e-Dashboard")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        //disablerightclick();
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
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

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body style="overflow:auto"  MS_POSITIONING="GridLayout"  class="clsFullPageBody">
        <script type="text/javascript" language="javascript">
            var ShowDescriptiveAlert;
            var ShowNeedleGraphs;
            var ShowOtherGraphs;
            var ShowMyQueries;
            var strFromWhere = '<%=m_strFromWhere%>';
            var strFromWhereQS = 'FromWhere=' + strFromWhere;
            var strDashboardIDQS = '&DashboardID=<%=m_lngDashboardID%>';
            var strCommonQueryString = strFromWhereQS + '&DashboardID=<%=m_lngDashboardID%>';
            
            /*Edited By KIRAN K K  FOR ISSUE ID:2442 28-11*/
            							
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
            <%End If%>
            /*Edited  END By KIRAN K K  FOR ISSUE ID:2442 28-11*/
            function SetGraphSkin()
            {
                var sFromWhere=strFromWhere;
                if (sFromWhere!='ADMIN') sFromWhere='DB';
                var iHeight=600,iWidth=700;	    
                var sURL='../CDB/GraphSkins_CommonList.aspx?MasterTagID=1799&ParentTagID=0&From='+sFromWhere;
                var sFeatures='resizable=yes,scrollbars=no,top='+((window.screen.height - iHeight)/2) + ',left=' + ((window.screen.width - iWidth)/2) + ',width='+iWidth+',height='+iHeight;
                window.open(sURL,'_Skin',sFeatures);	    
            }
            
            function ShowHide_divNeedleGraph() 
            {
                var objtdShowHide_divNeedleGraph = document.getElementById("tdShowHide_ShowHide_divNeedleGraph");
                var objdivNeedleGraph = document.getElementById("divNeedleGraph");
                var strDisplay=(arguments.length>0)?arguments[0]:objdivNeedleGraph.style.display;
                if (strDisplay != "none") 
                {
                    ShowNeedleGraphs=0;
                    objdivNeedleGraph.style.display="none";
                    objtdShowHide_divNeedleGraph.src='../../Images/plus.gif';
                }
                else
                {
                    ShowNeedleGraphs=1;
                    objdivNeedleGraph.style.display="";
                    objtdShowHide_divNeedleGraph.src='../../Images/minus.gif';
                }
            }
            function ShowHide_divOtherGraph() 
            {
                var objtdShowHide_divOtherGraph = document.getElementById("tdShowHide_ShowHide_divOtherGraph");
                var objdivOtherGraph = document.getElementById("divOtherGraph");
                var strDisplay=(arguments.length>0)?arguments[0]:objdivOtherGraph.style.display;
                if (strDisplay != "none")
                {
                    ShowOtherGraphs=0;
                    objdivOtherGraph.style.display="none";
                    objtdShowHide_divOtherGraph.src='../../Images/plus.gif';
                }
                else
                {
                    ShowOtherGraphs=1;
                    objdivOtherGraph.style.display="";
                    objtdShowHide_divOtherGraph.src='../../Images/minus.gif';
                }
            }
            function ShowHide_divMyQueries() 
            {
                var objtdShowHide_ShowHide_divMyQueries = document.getElementById("tdShowHide_ShowHide_divMyQueries");
                var objdivMyQueries = document.getElementById("divMyQueries");
                var strDisplay=(arguments.length>0)?arguments[0]:objdivMyQueries.style.display;
                if (strDisplay != "none") 
                {
                    ShowMyQueries =0;
                    objdivMyQueries.style.display="none";
                    objtdShowHide_ShowHide_divMyQueries.src='../../Images/plus.gif';
                }
                else
                {
                    ShowMyQueries =1;
                    objdivMyQueries.style.display="";
                    objtdShowHide_ShowHide_divMyQueries.src='../../Images/minus.gif';
                }
            }    		
            function Sort_OnClick(sortby, sortorder)
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.location.href = "CDB_Main.aspx?" + strCommonQueryString + "&sortby=" + sortby + "&sortorder=" + sortorder + "&displayalertid=<%=m_lngDisplayAlertID%>&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries;
            }
            function Settings_OnClick(DBID)
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }

                if (ShowDescriptiveAlert  != 0 && ShowDescriptiveAlert !=1)
                {
                    ShowDescriptiveAlert =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.open ("CDB_DashboardSettings.aspx?" + strFromWhereQS + "&DashboardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>","_DashboardSettings","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 500)/2) + ",top=" + ((window.screen.height - 250)/2) + ",width=500,height=250"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function Set_Sections_OnClick(DBID)
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }
                if (ShowDescriptiveAlert  != 0 && ShowDescriptiveAlert !=1)
                {
                    ShowDescriptiveAlert =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.open ("CDB_Sections.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=400"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function Set_Links_OnClick(DBID)
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }

                if (ShowDescriptiveAlert  != 0 && ShowDescriptiveAlert !=1)
                {
                    ShowDescriptiveAlert =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.open ("CDB_Links.aspx?"+ strFromWhereQS + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&parentsortby=<%=m_strSortBy%>&parentsortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Alerts", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=400"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function Set_Graphs_OnClick(DBID)
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }

                if (ShowDescriptiveAlert  != 0 && ShowDescriptiveAlert !=1)
                {
                    ShowDescriptiveAlert =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.open ("../CDB/CDB_ItemList.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>" , "_Configuration", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function Set_Alerts_OnClick(DBID)
            {
                window.open ("CDB_AlertList.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID, "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function DrillDown_OnClick(intDisplayType,intShowCT,itemid,colname,colvalue)
            {
                if (intShowCT == 1)
                {
                    window.open ("../CDB/CDB_DrillDown.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname,"'","|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||")) + "&ShowCT=1" , "_drillDown","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
                }
                else
                {
                    var sUrl  = "../CDB/CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname,"'","|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||")) + "&ShowCT=0";
                    if (intDisplayType == 0)
                    {
                        window.open (sUrl,  "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                    else
                    {
                        window.open (sUrl,  "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                }

                window.status = "View drill downs";
            }    		
            function callDetail(itemid,showdrilldowns,intShowCT,intDisplayType)
            {
                if (showdrilldowns == 1)
                {	
                    if (intShowCT == 1)
                    {
                        window.open ("../CDB/CDB_DrillDown.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=1", "_drillDown","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
                    }
                    else
                    {
                        var sUrl = "../CDB_DrillDown_Detail.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=0";
                        if (intDisplayType == 0)
                        {		                
                            window.open (sUrl, "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385"); //WAF3_PB_42 April 17, 2007 NinadP
                        }
                        else
                        {
                            window.open (sUrl, "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620"); //WAF3_PB_42 April 17, 2007 NinadP
                        }
                    }
                }
                window.status = "View drill downs"
            }    		
            function Link_OnClick(LinkURL)
            {
                window.open (LinkURL,"_Link","menubar=yes,resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
            }	
            function SetAlerts_OnClick(DBID)
            {
                window.open ("CDB_AlertList.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID, "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function cboDashboard_OnChange()
            {
                var PageName;
                var arr = new Array();
                var objcboDashboard = GetObjectReference('frmCDBMain','cboDashboard');
                PageName = objcboDashboard.value;
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }
    			
                if (ShowDescriptiveAlert  != 0 && ShowDescriptiveAlert !=1)
                {
                    ShowDescriptiveAlert =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                if (trimString(objcboDashboard.value) != "") 
                {
                    arr = PageName.split("|");
                    if (isSubstringExists(arr[0],'?'))
                    {
                        window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
                    }
                    else
                    {
                        window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
                    }
                }
                else
                {
                    window.location.href = "../CDB/CDB_DashboardDetail.aspx?" + strCommonQueryString + "&MODE=NEW&FromPage=<%=m_strFromPage%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert;
        }
    }    		
    function SetDefaultDashboard(setreset)
    {
        if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
        {
            ShowNeedleGraphs =1;
        }
        if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
        {
            ShowOtherGraphs =1;
        }
        if (ShowMyQueries  != 0 && ShowMyQueries !=1)
        {
            ShowMyQueries =1;
        }
        window.location.href = "CDB_Main.aspx?" + strCommonQueryString + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Mode=SET_DEFAULT&SetDefault=" + setreset + "&FromPage=<%=m_strFromPage%>&displayalertid=<%=m_lngDisplayAlertID%>&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries;
            }
            function Refresh_OnClick()
            {
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.location.href = "CDB_Main.aspx?" + strCommonQueryString + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&FromPage=<%=m_strFromPage%>&displayalertid=<%=m_lngDisplayAlertID%>&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries;
            }
            function Alert_Display(alertid)
            {
                if (alertid == 0)
                {
                    alertid = -1;
                }
                if (ShowNeedleGraphs != 0 && ShowNeedleGraphs !=1)
                {
                    ShowNeedleGraphs =1;
                }
                if (ShowOtherGraphs != 0 && ShowOtherGraphs !=1)
                {
                    ShowOtherGraphs =1;
                }
                if (ShowMyQueries  != 0 && ShowMyQueries !=1)
                {
                    ShowMyQueries =1;
                }
                window.location.href = "CDB_Main.aspx?" + strCommonQueryString + "&sortby=&sortorder=&displayalertid=" + alertid + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries;
            }    		
            function Show_AlertDetail(queryid,alertid)
            {
                window.open ("CDB_QueryOutput.aspx?" + strFromWhereQS + "&QueryID=" + queryid + "&AlertID=" + alertid, "_AlertDetail","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 550)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=550,height=500"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function LinkQuery_OnClick(colname,colvalue,queryid,height,width)
            {
                window.open ("CDB_QueryOutput.aspx?" + strFromWhereQS + "&QueryID=" + queryid + "&colname=" + replaceChar(replaceChar(colname,'&','38'),'+','43') + "&colvalue=" + replaceChar(replaceChar(colvalue,'&','38'),'+','43') ,"_AlertDetail","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 550)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=550,height=500"); //WAF3_PB_42 April 17, 2007 NinadP
            }    		
            function LinkURL_OnClick(url,height,width)
            {
                window.open(replaceSubstring(url,"|||","'"),"_url","left=" + ((window.screen.width - width)/2) + ",top=" + ((window.screen.height - height)/2) + ",menubar=yes,scrollbars=yes,resizable=yes,status=no,height="+ height +",width="+ width); //WAF3_PB_42 April 17, 2007 NinadP
            }    	
            <% 'Added by VinayB on 15-APR-2009 IssueID-30072 %>
            function OpenFavorites(strType)
            {
                var strURL = '../CDB/CDB_ShowOnDashboard.aspx?MasterTagID=1590' + strDashboardIDQS + '&IsCrossTabQuery=';
                var strURL2 = '../QRB/QRB_EB_List.aspx?MasterTagID=1558&FromDB=1';
                if (strType == 'QRB')
                {window.open(strURL + '0','favQueriesOnDB','resizable=yes,scollbars=no,menubar=no,height=520,width=500,left=' + ((window.screen.width-500)/2) + ',top=' + ((window.screen.height-520)/2));}
                else if (strType == 'CTB')
                {window.open(strURL + '1','favQueriesOnDB','resizable=yes,scollbars=no,menubar=no,height=520,width=500,left=' + ((window.screen.width-500)/2) + ',top=' + ((window.screen.height-520)/2));}
                else if (strType == 'EB')
                {window.open(strURL2,'favQueriesOnDB','resizable=yes,scollbars=no,menubar=no,height=600,width=700,left=' + ((window.screen.width-700)/2) + ',top=' + ((window.screen.height-600)/2));}
            }	
            <%'Modification End by VinayB on 15-APR-2009-30072 %>
            function Execute_OnClick(queryid,type)
            {
                switch(true)
                {
                    case (type=='QRB'): 
                        window.open("../QRB/QRB_UIBuilder.aspx?FromWhere=CDB&QueryID=" + queryid ,"_QueryResult","resizable=yes,menubar=no,scrollbars=no,status=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-500)/2 + ",width=600,height=500");
                        break;
                    case (type=='CTB'):
                        window.open("../QRB/QRB_CT_Output.aspx?From=CDB&MasterTagID=1562&CTQueryID=" + queryid ,"CT_Execute","menubar=yes,resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
                        break;
                    case (type=='EB'):
                        window.open("../QRB/QRB_EB_Output.aspx?From=CDB&MasterTagID=1558&ExpressionID=" + queryid ,"EB_Execute","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 300)/2) + ",width=450,height=300"); //WAF3_PB_42 April 17, 2007 NinadP
                        break;
                    default:
                        break;
                }
            }    		
            function Palette_OnClick()
            {
                if (strFromWhere.toUpperCase() == "ADMIN")
                {
                    window.open("../CDB/CDB_SystemPaletteCommonList.aspx?MasterTagID=1621" , "_SystemPalette", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height - 550)/2) + ",width=750,height=550"); //WAF3_PB_42 April 17, 2007 NinadP
                }
                else
                {
                    window.open("../CDB/CDB_PaletteCommonList.aspx?MasterTagID=1618" , "_Palette", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height - 550)/2) + ",width=700,height=550"); //WAF3_PB_42 April 17, 2007 NinadP
                }
            }            
            function Dashboards_OnClick(intDashboardID)
            {
                window.open ("CDB_Dashboard_CommonList.aspx?MasterTagID=1871&ParentTagID=0&DashboardID=" + intDashboardID + "&FromLink=" + strFromWhere, "_Dashboards","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 622)/2) + ",width=800,height=622"); //WAF3_PB_42 April 17, 2007 NinadP
            }
        </script>
        <form id="frmCDBMain" method="post" runat="server">           	
            <%WritePage()%>
            <div id="divGraphs" runat="server">
                <table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle"></table>
            </div>
        </form>
        <div class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></div>
        <script type="text/javascript" language="javascript">
            var _objcboDashboard;
            var intcount;
            var index;
            _objcboDashboard = GetObjectReference('frmCDBMain','cboDashboard');
            //Commented added by Shamkant S on 10 Dec 2015
            objdivOtherGraphs=GetObjectReference('frmCDBMain','divOtherGraph');
            document.body.onload = window_load();
            //Commented ended  by Shamkant S on 10 Dec 2015
            intcount=<%=m_arrDBUsersID.Length%>;
            arrDBUsers = new Array(intcount);
            for(index=0;index<intcount;index++)
            {
                arrDBUsers[index]= new Array(2); 
            }
            <%For m_intCnt = 0 to m_arrDBUsers.Length-1%>
            arrDBUsers[<%=m_intCnt%>][0] = "<%=m_arrDBUsersID(m_intCnt)%>";
            arrDBUsers[<%=m_intCnt%>][1] = "<%=m_arrDBUsers(m_intCnt)%>";
            <%Next%>
            <%MyBase.InitializeResources("Resources.QRB_QueryList", "Resources")%>        	
            window.onload = WindowLoading;
            window.onresize = UpdateWindowSize;
            <% If m_blnIsDBIdZero Then %>
            if(_objcboDashboard){_objcboDashboard.selectedIndex = -1;}
            <% End If %>
            //commented added by Shamkant s On 10 Dec 2015
            function window_load()
            {
               
                var intDivHeight ;
                if(objdivOtherGraphs)
                {
                    // alert();
                    intDivHeight = window.innerHeight - objdivOtherGraphs.offsetTop-18 ;
            
                    if(navigator.appName == 'Netscape')
                    {
                        intDivHeight = window.innerHeight - objdivOtherGraphs.offsetTop-18 ;
                    }

                    if (intDivHeight < 100)	intDivHeight = 100;
                    objdivOtherGraphs.style.height = intDivHeight + 'px';	
            
                }
            }
            //Commented ended by Shamkant S on 10 Dec 2015
            function Query_OnClick(QID,type)
            {
                switch(true)
                {
                    case (type=='QRB'):
                        var strUsers;
                        var ans,i;
                        var show=true;
                        for(i=0;i<intcount;i++)
                        {				
                            if(QID==arrDBUsers[i][0])
                            {
                                strUsers = arrDBUsers[i][1];
                                ans = window.confirm("<%=mybase.GetResourceString("MSG_DBSHARE1")%> :\r\n" + "-" + strUsers + "\r\n<%=mybase.GetResourceString("MSG_DBSHARE2")%>\r\n<%=mybase.GetResourceString("MSG_DBSHARE3",False)%>");
					            if(ans==true)
					                show=true;
					            else
					                show=false;								
                            }
                        }	
                        if(show==true)
                        {
                            window.open("../QRB/QRB_QueryBuilder.aspx?QueryID=" + QID + "&Mode=EDIT" ,"_QRB","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-780)/2 + ",top=" + (window.screen.height-600)/2 + ",width=780,height=600"); <% 'WAF3_PB_42 April 19, 2007 NinadP %>
			            }
                        break;
                    case (type=='CTB'):
                        window.open("../QRB/QRB_CT_Definition.aspx?From=CDB&MasterTagID=1562&Mode=EDIT&CTQueryID=" + QID,"_CT","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-550)/2 + ",width=700,height=550");<% 'WAF3_PB_42 April 19, 2007 NinadP %>
		                break;
                    case (type=='EB'):
    					  
                        window.open("../QRB/QRB_EB_Definition.aspx?From=CDB&MasterTagID=1558&Mode=EDIT&ExpressionID=" + QID ,"_EB","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-600)/2 + ",width=700,height=600");
                        break;
                    default:
                        break;				
                }
            }
        </script>
        <%=m_strClientSideScript%>
    </body>
</html>


<script type="text/javascript">

    $(document).ready(function(){
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


