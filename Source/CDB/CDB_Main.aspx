<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_Main.aspx.vb" Inherits="Whiz.CDB_Main" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("e-Dashboard")%>
	<body MS_POSITIONING="GridLayout" class="clsFullPageBody">
        <script type="text/javascript" language="javascript">
            var ShowDescriptiveAlert;
            var ShowNeedleGraphs;
            var ShowOtherGraphs;
            var ShowMyQueries;
            var strFromWhere = '<%=m_strFromWhere%>';
            var strFromWhereQS = 'FromWhere=' + strFromWhere;
            var strDashboardIDQS = '&DashboardID=<%=m_lngDashboardID%>';
            var strCommonQueryString = strFromWhereQS + '&DashboardID=<%=m_lngDashboardID%>';
            
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
                    //window.open("CDB_DashboardSettings.aspx?" + strFromWhereQS + "&DashboardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_DashboardSettings", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 500) / 2) + ",top=" + ((window.screen.height - 250) / 2) + ",width=500,height=250"); //WAF3_PB_42 April 17, 2007 NinadP
                var token = GeneratePkTokern(DBID);
                 //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                <%--window.open ("CDB_DashboardSettings.aspx?" + strFromWhereQS + "&PKToken=" +token + "&DashboardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>","_DashboardSettings","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 500)/2) + ",top=" + ((window.screen.height - 250)/2) + ",width=500,height=250"); //WAF3_PB_42 April 17, 2007 NinadP--%>
            window.open("CDB_DashboardSettings.aspx?" + strFromWhereQS + "&PKToken=" + token + "&DashboardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_DashboardSettings", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 500) / 2) + ",top=" + ((window.screen.height - 250) / 2) + ",width=500,height=250"); //WAF3_PB_42 April 17, 2007 NinadP
            //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
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
                window.open("CDB_Sections.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=600,height=400"); //WAF3_PB_42 April 17, 2007 NinadP
                //var token = GeneratePkTokern(DBID);
                 //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                <%--window.open ("CDB_Sections.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&PKToken=" +token + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=400"); //WAF3_PB_42 April 17, 2007 NinadP--%>
                //window.open("CDB_Sections.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&PKToken=" + token + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Alerts", "resizable=yes,scrollbars=yes,status=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 400) / 2) + ",width=600,height=400"); //WAF3_PB_42 April 17, 2007 NinadP
                //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
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
                window.open("CDB_ItemList.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Configuration", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 700) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=700,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
                //var token = GeneratePkTokern(DBID);
                 //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                <%--window.open ("CDB_ItemList.aspx?" + strFromWhereQS + "&PKToken=" +token +"&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>" , "_Configuration", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600"); //WAF3_PB_42 April 17, 2007 NinadP--%>
                //window.open("CDB_ItemList.aspx?" + strFromWhereQS + "&PKToken=" + token + "&DashBoardID=" + DBID + "&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert + "&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>", "_Configuration", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 700) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=700,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
                //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
            }    		
            function Set_Alerts_OnClick(DBID)
            {
                window.open("CDB_AlertList.aspx?" + strFromWhereQS + "&DashBoardID=" + DBID, "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
                 //var token = GeneratePkTokern(DBID);
                //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                //window.open ("CDB_AlertList.aspx?" + strFromWhereQS +"&PKToken=" +token +  "&DashBoardID=" + DBID, "_Alerts", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
                //window.open("CDB_AlertList.aspx?" + strFromWhereQS + "&PKToken=" + token + "&DashBoardID=" + DBID, "_Alerts", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=600,height=600"); //WAF3_PB_42 April 17, 2007 NinadP
                //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup

            }    		
            function DrillDown_OnClick(intDisplayType,intShowCT,itemid,colname,colvalue)
            {
	            if (intShowCT == 1)
	            {
		            window.open ("CDB_DrillDown.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname,"'","|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||")) + "&ShowCT=1" , "_drillDown","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
	            }
	            else
	            {
	                var sUrl  = "CDB_DrillDown_Detail.aspx?" + strCommonQueryString + "&ItemID=" + itemid + "&colname=" + URLEncode(replaceSubstring(colname,"'","|||")) + "&colvalue=" + URLEncode(replaceSubstring(colvalue,"'","|||")) + "&ShowCT=0";
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
            //Modified by RajK August 20, 2018 AUG2018R2
            //function callDetail(itemid,showdrilldowns,intShowCT,intDisplayType)
            //{
	        //    if (showdrilldowns == 1)
	        //    {	
		    //        if (intShowCT == 1)
		    //        {
			//            window.open ("CDB_DrillDown.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=1", "_drillDown","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); //WAF3_PB_42 April 17, 2007 NinadP
		    //        }
		    //        else
		    //        {
		    //            var sUrl = "CDB_DrillDown_Detail.aspx?colname=&colvalue=&" + strCommonQueryString + "&ItemID=" + itemid + "&ShowCT=0";
		    //            if (intDisplayType == 0)
	        //            {		                
			//                window.open (sUrl, "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385"); //WAF3_PB_42 April 17, 2007 NinadP
            //            }
            //            else
            //            {
            //                window.open (sUrl, "_drillDown","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620"); //WAF3_PB_42 April 17, 2007 NinadP
            //            }
		    //        }
	        //    }
	        //    window.status = "View drill downs"
            //}    		
            //calling the new page here to display the DB base graph first
            function callDetail(itemid,intShowCT,intDisplayType,intNeedleGraph)
            {
                
                if (intShowCT == 1)
                {
                    window.open ("CDB_Main_Graph.aspx?mode=base&colname=&colvalue=&" + strCommonQueryString + "&NeedleGraph=" + intNeedleGraph + "&ItemID=" + itemid + "&ShowCT=1", "","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990)/2) + ",top=" + ((window.screen.height - 640)/2) + ",width=990,height=640"); 
                }
                else
                {
                    var sUrl = "CDB_Main_Graph.aspx?mode=base&colname=&colvalue=&" + strCommonQueryString + "&NeedleGraph=" + intNeedleGraph + "&ItemID=" + itemid + "&ShowCT=0";
                    if (intDisplayType == 0)
                    {		                
                        window.open (sUrl, "","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 385)/2) + ",width=840,height=385"); 
                    }
                    else
                    {
                        window.open (sUrl, "","resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 840)/2) + ",top=" + ((window.screen.height - 620)/2) + ",width=840,height=620"); 
                    }
                }
                
                window.status = "View graph"
            }    		
            //End Modification by RajK August 20, 2018 AUG2018R2

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
                       // window.open("../QRB/QRB_EB_Output.aspx?From=CDB&MasterTagID=1558&ExpressionID=" + queryid, "EB_Execute", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 450) / 2) + ",top=" + ((window.screen.height - 300) / 2) + ",width=450,height=300"); //WAF3_PB_42 April 17, 2007 NinadP
                         //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                    //window.open("../QRB/QRB_EB_Output.aspx?From=CDB&MasterTagID=1558&ExpressionID=" + queryid ,"EB_Execute","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 300)/2) + ",width=450,height=300"); //WAF3_PB_42 April 17, 2007 NinadP
                        window.open("../QRB/QRB_EB_Output.aspx?From=CDB&MasterTagID=1558&ExpressionID=" + queryid, "EB_Execute", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 450) / 2) + ",top=" + ((window.screen.height - 300) / 2) + ",width=450,height=300"); //WAF3_PB_42 April 17, 2007 NinadP
                    //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
			            break;
		            default:
			            break;
	            }
            }    		
            function Palette_OnClick()
            {
	            if (strFromWhere.toUpperCase() == "ADMIN")
	            {
                    //window.open("../CDB/CDB_SystemPaletteCommonList.aspx?MasterTagID=1621", "_SystemPalette", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 750) / 2) + ",top=" + ((window.screen.height - 550) / 2) + ",width=750,height=550"); //WAF3_PB_42 April 17, 2007 NinadP
                    //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
                //window.open("../CDB/CDB_SystemPaletteCommonList.aspx?MasterTagID=1621" , "_SystemPalette", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height - 550)/2) + ",width=750,height=550"); //WAF3_PB_42 April 17, 2007 NinadP
                    window.open("../CDB/CDB_SystemPaletteCommonList.aspx?MasterTagID=1621", "_SystemPalette", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 750) / 2) + ",top=" + ((window.screen.height - 550) / 2) + ",width=750,height=550"); //WAF3_PB_42 April 17, 2007 NinadP
                //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
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
                <table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle" width="100%"></table>
            </div>
        </form>
        <div class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></div>
        <script type="text/javascript" language="javascript">
            var _objcboDashboard;
            var intcount;
            var index;
            _objcboDashboard = GetObjectReference('frmCDBMain','cboDashboard');
        	
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
        <style>
            /*Added By Dipali V On 15th feb 2021 For Scroll issue*/
            #DivList {
                overflow: auto !important;
                height: 539px !important;
            }
             /*End of Added By Dipali V On 15th feb 2021 For Scroll issue*/

        </style>
    </body>
</html>


<!--Including files & Libraries by Miiint Solutions-->


    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>

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

    //Added By Pradip on 3rd Nov 2020 For scroll
    //dynamically set height
        function resizeSection(tag) {
            var frmheight = $(window).height();
            $('#frmCDBMain').css({ 'height': frmheight - 30, "overflow-y": "auto" });
           
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
    });
     //End of Added By Pradip on 3rd Nov 2020 For scroll
</script>


