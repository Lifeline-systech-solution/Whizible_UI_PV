<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_DashboardDetail.aspx.vb" Inherits="Whiz.CDB_DashboardDetail" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Dashboard Details")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>
    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body style="overflow:auto" MS_POSITIONING="GridLayout" class="clsBody"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)" onunload ="RefreshParent()"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ, by NinadP on 28 Aug 2007, Issueid - 14504 %>
		<form id="frmDashboardDetails" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
		    var blnRefreshOpener = true;	//Added By Ninad on 28 Aug 2007, Issue ID - 14504
		    var objform;
		    var objdivlist;
		    var objchkUseConfigurableDB;
		    var objtxtPageName;
		    var objcboDashboardType;
		    var objtxtDescription;

		    var objcboPalleteStyle;
		    var objtxtGraphHeight;
		    var objtxtGraphWidth;

		    objform = GetFormReference('frmDashboardDetails');
		    objdivlist = GetObjectReference('frmDashboardDetails', 'divList');
		    objchkUseConfigurableDB = GetObjectReference('frmDashboardDetails', 'chkUseConfigurableDB');
		    objtxtPageName = GetObjectReference('frmDashboardDetails', 'txtPageName');
		    objcboDashboardType = GetObjectReference('frmDashboardDetails', 'cboDashboardType');
		    objtxtDescription = GetObjectReference('frmDashboardDetails', 'txtDescription');

		    objcboPalleteStyle = GetObjectReference('frmDashboardSettings', 'cboPalleteStyle');
		    objtxtGraphHeight = GetObjectReference('frmDashboardSettings', 'txtGraphHeight');
		    objtxtGraphWidth = GetObjectReference('frmDashboardSettings', 'txtGraphWidth');

		    var objtrHideDBCombo = GetObjectReference('frmDashboardSettings', 'trHideDBCombo');
		    var objtrNoOfGraphsPerRow = GetObjectReference('frmDashboardSettings', 'trNoOfGraphsPerRow');
		    var objtblNote = GetObjectReference('frmDashboardSettings', 'tblNote');

		    //Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
		    var fwhere = "<%=m_strFromPage%>";
		    if (fwhere != "")
		        fwhere = fwhere.replace(/Home/g, '../CDB/CDB_Main.aspx');
		    //End of addition by Dhanashri S on 18 Aug 2016 

		    <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
		    disableRightClick();
		    <%End If%>
		    <%' Ended By Shamkant S on 8 Dec Jan 2015 %>
		    function validate() {
		        if (disallowBlank(objtxtDescription, "Please provide the dashboard name")) return false;
		        if (disallowSpecialCharacters(objtxtDescription, "Characters '/:*?+\"><,\\\\' are not allowed")) return false;
		        if (disallowBlank(objtxtPageName, "Please provide the page name")) return false;
		        if (objcboDashboardType.style.display == "block") {
		            if (disallowBlank(objcboDashboardType, "Please select the dashboard type")) return false;
		        }
		        if (disallowBlank(objcboPalleteStyle, "Please select the color scheme")) return false;
		        if (disallowBlank(objtxtGraphHeight, "Please provide the graph height")) return false;
		        if (disallowBlank(objtxtGraphWidth, "Please provide the graph width")) return false;
		        if (disallowNonInteger(objtxtGraphHeight, "Please provide an integer value")) return false;
		        if (disallowNonInteger(objtxtGraphWidth, "Please provide an integer value")) return false;
		        if (disallowMinValueViolation(objtxtGraphHeight, 100, "Please provide the height greater than 100")) return false;
		        if (disallowMinValueViolation(objtxtGraphWidth, 100, "Please provide the width greater than 100")) return false;
		        return true;
		    }
		    //Added By Ninad on 28 Aug 2007, Issue ID - 14504
		    function RefreshParent() {
		        //Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
		        try {
		            if (window.opener == null) return;
		            if (blnRefreshOpener == false) return;
		            //If the request come from DB List page then refresh parent
		            if (window.opener.location.href.indexOf('Source/General/CommonList.aspx') != -1) {
		                window.opener.document.forms['frmCommonList'].action = window.opener.location.href;
		                window.opener.document.forms['frmCommonList'].submit();
		            }
		        } catch (e) { } //Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
		    }
		    //End Addition By Ninad on 28 Aug 2007, Issue ID - 14504
		    function Configure_OnClick(DBID) {
		        //COMMENTED AND ADDED BY nILESH G ON 30/3/2016 FOR url SECURITY iSSUE
		        //window.open("CDB_Main.aspx?FromWhere=ADMIN&DashboardID=" + DBID,"_DBConfiguration","resizable=yes,scrollbars=yes,top=0,left=0,height=600,width=800")
		        $.ajax({
		            type: 'POST',
		            dataType: 'json',
		            contentType: 'application/json',
		            url: 'CDB_DashboardDetail.aspx/GenrateURLToken',
		            data: JSON.stringify({ DBID: DBID, EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            window.open("CDB_Main.aspx?FromWhere=ADMIN&PKToken=" + Result.d + "&DashboardID=" + DBID, "_DBConfiguration", "resizable=yes,scrollbars=yes,top=0,left=0,height=600,width=800")
	        },
	        error: function () {
	            //  alert("Error")
	        }
	    });

	    //END OF COMMENTED AND ADDED BY nILESH G ON 30/3/2016 FOR url SECURITY iSSUE

    }

    function Back_OnClick(DBID) {
        window.location.href = "<%=m_strFromPage%>";
	}

	function Save_OnClick(DBID) {
	    blnRefreshOpener = false //Added By Ninad on 28 Aug 2007, Issue ID - 14504
	    var fromwhere;
	    var existingnames;

	    fromwhere = "<%=m_strFromPage%>";
	    //Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
	    if (fromwhere != "")
	        fromwhere = fromwhere.replace(/Home/g, '../CDB/CDB_Main.aspx');
	    //End of addition by Dhanashri S on 18 Aug 2016
		if (validate() == true) {
		    if (trimString(fromwhere) == "") {
		        existingnames = ",<%=m_strExistingDashboardNames%>,"
			    if (isSubstringExists(existingnames, "," + objtxtDescription.value + ",")) {
			        alert("The dashboard name already exists!Please provide another name");
			        objtxtDescription.focus();
			        return;
			    }
			    objchkUseConfigurableDB.disabled = false;
			}


		    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
		    //Commented and Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
		    //objform.action = "CDB_DashboardDetail.aspx?FromPage=<%=m_strFromPage%>&Mode=<%=m_strMode%>&Action=SAVE&DashboardID=" + DBID + "&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>";
		    objform.action = "CDB_DashboardDetail.aspx?FromPage=" + fwhere + "&Mode=<%=m_strMode%>&Action=SAVE&DashboardID=" + DBID + "&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>";
		    //End of comment addition by Dhanashri S on 18 Aug 2016
		    blnNavigate = false;    //Added By Ninad WAF3_PB_64
		    objform.submit();
		}
    }

    function UseConfigurableDB_OnClick() {
        var fromwhere;
        fromwhere = "<%=m_strFromPage%>";
        //Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        if (fromwhere != "")
            fromwhere = fromwhere.replace(/Home/g, '../CDB/CDB_Main.aspx');
        //End of addition by Dhanashri S on 18 Aug 2016 
		if (trimString(fromwhere) == "") {
		    if (objchkUseConfigurableDB.checked == true) {
		        //Commented And Added By Chakshuta H on 28th-Oct-2015 Purpose::issue fixing
		        //objtxtPageName.value = "../CDB/CDB_Main.aspx";
		        //objtxtPageName.readOnly = true;
		        //objtxtPageName.style.backgroundcolor= "#d3d3d3";
		        //trDashboardType.style.display = "block";
		        //trPalleteStyle.style.display = "block";
		        //trHeight.style.display ="block";
		        //trWidth.style.display="block";
		        //if (objtrHideDBCombo){objtrHideDBCombo.style.display = "block";}
		        // if (objtrNoOfGraphsPerRow){objtrNoOfGraphsPerRow.style.display = "block";}
		        //if(objtblNote){objtblNote.style.display = "block";}

		        objtxtPageName.value = "../CDB/CDB_Main.aspx";
		        objtxtPageName.readOnly = true;
		        objtxtPageName.style.backgroundcolor = "#d3d3d3";
		        trDashboardType.style.display = "";
		        trPalleteStyle.style.display = "";
		        trHeight.style.display = "";
		        trWidth.style.display = "";
		        if (objtrHideDBCombo) { objtrHideDBCombo.style.display = ""; }
		        if (objtrNoOfGraphsPerRow) { objtrNoOfGraphsPerRow.style.display = ""; }
		        if (objtblNote) { objtblNote.style.display = ""; }
		        //End Of Comment And Addition By Chakshuta H on 28th-Oct-2015 Purpose::issue fixing
		    }
		    else {
		        objtxtPageName.readOnly = false;
		        objtxtPageName.style.backgroundcolor = "";
		        objtxtPageName.value = "";
		        trDashboardType.style.display = "none";
		        trPalleteStyle.style.display = "none";
		        trHeight.style.display = "none";
		        trWidth.style.display = "none";
		        if (objtrHideDBCombo) { objtrHideDBCombo.style.display = "none"; }
		        if (objtrNoOfGraphsPerRow) { objtrNoOfGraphsPerRow.style.display = "none"; }
		        if (objtblNote) { objtblNote.style.display = "none"; }
		    }
		}

    }
<% 'WAF3_PB_42 April 10, 2007 modified window_onload and removed window_onresize functions  %>
		    function window_onload() {
		        var intFillFactor = (arguments.length > 0) ? arguments[0] : 50;
		        windowSize_common(intFillFactor);
		        if (objtxtDescription.disabled == false) {
		            objtxtDescription.focus();
		        }
		    }<% 'WAF3_PB_42 April 10, 2007%>
		</script>
	</body>
</HTML>


 <script type="text/javascript">
     $(document).ready(function () {
         /*----------------------------------------------------------*/
         // Starts Feature Tag:whiz41-InnerMenuDropDown
         // Description:Creating DropDown for Top Table Inner Menu on document Ready
         // By Whom: Miiint
         // When:13/02/2015
         /*---------------------------------------------------------*/
         responsiveTopMenu();
         /*---------------------------------------------------------*/
         // Ends Feature Tag:whiz41-InnerMenuDropDown
         /*---------------------------------------------------------*/

         /*----------------------------------------------------------*/
         // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
         // Description:Creating DropDown for Footer Table Inner Menu on document Ready
         // By Whom: Miiint
         // When:13/02/2015
         /*---------------------------------------------------------*/
         responsiveFooterMenu();
         /*---------------------------------------------------------*/
         // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
         /*---------------------------------------------------------*/
     });

     $(window).resize(function () {
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

