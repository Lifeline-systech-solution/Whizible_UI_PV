<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_PlainTextDisplay.aspx.vb" Inherits="PbNIT.KM_PlainTextDisplay" ValidateRequest="False" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
  <%WritePageHead()%>




<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>


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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPlainTextDisplay" name="frmPlainTextDisplay" method="post" runat="server">
		<%WritePage()%>
    </form>
    
    <script language="javascript">

	var objForm, objdivlist;
	
	objForm = GetFormReference('frmPlainTextDisplay');
	objdivlist = GetObjectReference('frmPlainTextDisplay','divList');
	
	        <%' Added By SonalD on 13th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>
	
	function window_onload()		
	{
		var intDivHeight ;
		var intDivHeightRisk;
		var intScriptNo;
		
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)		
		intDivHeight = 100;
		
		//'Modified by ShraddhaM on Date 29 June,2006 for WhizibleSEM Issue ID.4168

		if(navigator.appName == 'Netscape')
		{
			 
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 180;
		}
		objdivlist.style.height = intDivHeight +'px'	;
		
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';		
	}
	
	function MenuLink_OnClick(strMenuLink)
	{
		location.href = strMenuLink;
	}

// =============================== Common To all Mode =====================//
	<%=m_strClientSideScript%>

<%If Not m_strType = TYPE_LESSON Then%>

	// Open the tree selectively, depending on the node that needs to be show.
	function SelectiveOpen(objChild)
	{		
		var objULTags, objParent;
			
		// Check if it has any ul tag.
		objULTags = objChild.getElementsByTagName("UL");
			
		// If no ol tags is present, then it is a book.
		if(objULTags.length != 0)
		{		
			// Change the current tags state to open book.
			objChild.className = "clsShowHideShowing";
			objULTags(0).className = "clsItemsShow";												
		}
			
		// Go the the parent LI Tag.
		objParent = objChild.parentElement;
		if(objParent== null)
			return;
							
		// Now get the parent element, and open it.
		while (objParent.tagName != "LI")
		{
			objParent = objParent.parentElement;
			if(objParent == null)
				return;
		}
		SelectiveOpen(objParent)		
	}

	function SynchronizeTOC()
	{					
		var strArticleType, strArticleID;
		var objLeafNode, strTreeNodeID;
			
		strArticleType = "<%=m_strType%>";
		strArticleID = "<%=m_lngArticleId%>";
		
		if(strArticleType == "SearchedArticle")
			strTreeNodeID = "SALeaf" + strArticleID;
		else if(strArticleType == "WhatsNew")
			strTreeNodeID = "WNLeaf" + strArticleID;
		else if(strArticleType == "Article")
			strTreeNodeID = "KALeaf" + strArticleID;
		else if(strArticleType == "Favorite")
			strTreeNodeID = "FVLeaf" + strArticleID;
		else if(strArticleType == "Lesson")
			strTreeNodeID = "LLLeaf" + strArticleID;
		else if(strArticleType == "QSD")
			strTreeNodeID = "QSDLeaf" + strArticleID;
		else if(strArticleType == "Unauthenticated")
			strTreeNodeID = "UALeaf" + strArticleID;
		else if(strArticleType == "MyArticle")
			strTreeNodeID = "MALeaf" + strArticleID;
			
		objLeafNode = window.parent.frames("Main").document.getElementById(strTreeNodeID);
			
		if(objLeafNode != null)
		{
			SelectiveOpen(window.parent.frames("Main").document.getElementById(strTreeNodeID));
			objLeafNode.scrollIntoView;
		}
	}
	
	function Back_OnClick()
	{	
		window.location.href = "../KM/KM_SearchResults.aspx";
	}
	
	function RemoveFavorite_OnClick()
	{
		window.location.href = "KM_Display.aspx?Mode=RemoveFavorite&ProcedureID=<%=m_lngArticleId%>&Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>";			
	}
	
	function AddToFavorite_Onclick()
	{
		window.location.href = "KM_Display.aspx?Mode=AddToFavorite&ProcedureID=<%=m_lngArticleId%>&Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>"				
	}
	
	function New_OnClick()
	{
		window.location.href = "KM_Display.aspx?Mode=New&PrevID=<%=m_lngArticleId%>&Type=<%=m_strType%>";
	}
	
	function Edit_OnClick()
	{
		window.location.href = "KM_Display.aspx?ProcedureID=<%=m_lngArticleId%>&PrevID=<%=m_lngArticleId%>&Type=<%=m_strType%>";
	}

	function Delete_OnClick()
	{
		if(confirm("<%=MyBase.GetResourceString("DELETE_CONFIRM")%>"))
			window.location.href = "KM_Display.aspx?Mode=Delete&ProcedureID=<%=m_lngArticleId%>";
	}
	
	function Authenticate_OnClick()
	{
		//window.location.href = "KM_Display.aspx?Mode=Authenticate&ProcedureID=<%=m_lngArticleId%>&Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>";		
		//Changed by DipaliS
		var customize
		customize="<%=m_blnCustomize%>"
		if(customize == "True")
		{
			window.location.href = "<%=Configurationsettings.Appsettings("PBN_KMBaseURL")%>" + "RateArticle.aspx?Mode=Authenticate&ProcedureID=<%=m_lngArticleId%>&Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>&UserID=<%=Session("intUserID")%>&Path=<%=configurationsettings.appsettings("PBN_BaseURL")%>";
		}
		else
		{
			window.location.href = "KM_Display.aspx?Mode=Authenticate&ProcedureID=<%=m_lngArticleId%>&Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>";
		}
	}
		
	function Rights_OnClick()
	{
		window.open("../KM/KM_UserAuthentication.aspx", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");
	}
		
	function Show_File(intAttachmentID)
	{
		window.location.href = "KM_PlainTextDisplay.aspx?ID=<%=m_lngArticleId%>&Type=<%=m_strType%>&Mode=ShowFile&AttachmentID=" + intAttachmentID.toString();
	}

	function Search_OnClick()
	{
		window.open("../KM/KM_SearchDialog.aspx","","scrollbars=no,toolbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 225)/2 + ",height=225,width=500");
	}
	
	function ClearSearch_OnClick()
	{
		location.href = "../KM/KM_Display.aspx?Type=<%=m_strType%>&PrevID=<%=m_lngArticleId%>&Mode=ClearSearch";									
	}	
	
	//Added by DipaliS
	function RateArticle_OnClick(intArticleID)
	{
		window.open("../KCCS/RateArticle1.aspx?UserID=<%=Session("intUserID")%>&ArticleID=" + intArticleID ,"","scrollbars=no,resizable=yes,toolbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 225)/2 + ",height=250,width=350")
	}	
	
	function Home_OnClick()	
	{
		window.location.href =  "../KCCS/KM_Introduction.aspx"
	}
	
	//End of Addition
					
	
<%End If%>
</script>

  </body>
</html>
