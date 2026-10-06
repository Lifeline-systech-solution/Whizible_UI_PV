<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_Display.aspx.vb" Inherits="PbNIT.KM_Display" ValidateRequest="False" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
  <%WritePageHead%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


       <%CommonFunctions.General.PlotPageHeadTag("")%>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmDisplay" method="post" runat="server">
		<%WritePage%>
   
<script language="javascript">
// =============================== Common To all Mode=====================//
	var objForm, objdivlist, objForFocus;
	
	objForm = GetFormReference('frmDisplay');
	objdivlist = GetObjectReference('frmDisplay','divList');
	<%If m_strWhatToShow = SHOW_DETAILS Then%>
		objForFocus = GetObjectReference('frmDisplay','txtProcedureTitle');
		setFocus(objForFocus);
	<%ElseIf m_strWhatToShow <> SHOW_ATTACHMENTS Then%>
		objForFocus = GetObjectReference('frmDisplay','txtCode');
		setFocus(objForFocus);
	<%End If%>
	
	        <%' Added By SonalD on 13th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>
	
	function window_onload()
	{
		var intDivHeight ;
		if(objdivlist)
		{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			//'Modified by ShraddhaM on Date 05 Jully,2006 for WhizibleSEM Issue ID.4168
			if(navigator.appName == 'Netscape')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
			}

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	
		}
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivlist)
		{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';
		}
	}
// =============================== Common To all Mode =====================//

	<%=m_strClientSideScript%>

	function Back_OnClick()
	{
		<%If m_lngPreviousId = 0 Then%>
			window.location.href ="../General/Introduction.aspx?FromWhere=KM";
			//Changed by DipaliS 15-04-04 
			//window.location.href ="../KCCS/KM_Introduction.aspx?FromWhere=KM";
		<%Else%>
			window.location.href ="KM_PlainTextDisplay.aspx?Type=<%=m_strType%>&ID=<%=m_lngPreviousId%>";
		<%End If%>
	}
	
	function Details_OnClick()
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_DETAILS%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
	}
	
	function Code_OnClick()
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_PROCEDURECODE%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
		
	}

	function Comment_OnClick()
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_PROCEDURECOMMENT%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
	}

	function Example_OnClick()
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_PROCEDUREEXAMPLE%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
	}

	function Attach_OnClick()
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_ATTACHMENTS%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
	}
	
	function Show_File(intAttachmentID)
	{
		window.location.href = "KM_Display.aspx?WhatToShow=<%=SHOW_ATTACHMENTS%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>&AttachmentID=" + intAttachmentID;
	}

	function AddAttachment_OnClick()
	{
		window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_lngProcedureId%>&Page=../KM/KM_Display.aspx&QueryString=" + "<%=Server.UrlEncode("WhatToShow=" & SHOW_ATTACHMENTS & "&ProcedureID=" & m_lngProcedureId.ToString() & "&Type=" & m_strType & "&PrevID=" & m_lngPreviousId)%>",null,"resizable=yes,left=0,top=0,width=550,height=240");
	}
	
	function DeleteAttachments_OnClick()
	{
		if(confirm("<%=MyBase.GetResourceString("CONFIRM_DELETE")%>"))
		{
			objForm.action = "KM_Display.aspx?WhatToShow=<%=SHOW_ATTACHMENTS%>&ProcedureID=<%=m_lngProcedureId%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>&Action=<%=ACTION_DELETE%>";
			objForm.submit()				
		}
	}
	
	function KnowledgeArticle_OnClick()
	{
		rowCategory.style.visibility = "visible";
		rowCategory.style.display = "block";
		
		rowTemplate.style.visibility = "hidden";
		rowTemplate.style.display = "none";				
	}
	
	function QSDArticle_OnClick()
	{
		rowTemplate.style.visibility = "visible";
		rowTemplate.style.display = "block";
	
		rowCategory.style.visibility = "hidden";
		rowCategory.style.display = "none";		
	}
	
	function Save_OnClick()
	{
		var intProcedureId, strWhatToShow;
		var objProcedureTitle, objCboCategory, objCboTemplate;
		var objoptKnowledgeArticle, objoptSibling, objoptQSDArticle;
		
		intProcedureId = <%=m_lngProcedureId%>;
		strWhatToShow = "<%=m_strWhatToShow%>";
		if(strWhatToShow == "<%=SHOW_DETAILS%>")
		{
			objProcedureTitle = GetObjectReference('frmDisplay','txtProcedureTitle');
			if(disallowBlank(objProcedureTitle, "<%=MyBase.GetResourceString("ENTER_TITLE")%>"))
				return;
				
			<%If m_strMode = MODE_NEW Then%>
				objoptKnowledgeArticle = GetObjectReference('frmDisplay','optKnowledgeArticle');
				if(objoptKnowledgeArticle.checked == true)
				{	
					objCboCategory = GetObjectReference('frmDisplay','cboCategory');
					if(disallowBlank(objCboCategory, "<%=MyBase.GetResourceString("SELECT_CATEGORY")%>"))
						return;
				}
				else
				{
					objCboTemplate = GetObjectReference('frmDisplay','cboTemplate');
					objoptSibling = GetObjectReference('frmDisplay','optSibling');
					if(objoptSibling.checked == true)
					{
						if(disallowBlank(objCboTemplate, "<%=MyBase.GetResourceString("SELECT_TEMPLATE")%>"))
							return;
					}
					else
					{
						if(disallowBlank(objCboTemplate, "<%=MyBase.GetResourceString("SELECT_TEMPLATE_UNDER")%>"))
							return;
					}
				}
				objoptQSDArticle = GetObjectReference('frmDisplay','optQSDArticle');
				objoptKnowledgeArticle.disabled = false;
				objoptQSDArticle.disabled = false;

			<%ElseIf m_strType <> TYPE_QSD Then%>
				objCboCategory = GetObjectReference('frmDisplay','cboCategory');
				if(disallowBlank(objCboCategory, "<%=MyBase.GetResourceString("SELECT_CATEGORY")%>"))
					return;
			<%End If%>
		}
		objForm.action ="KM_Display.aspx?ProcedureID=" + intProcedureId.toString() + "&WhatToShow=" + strWhatToShow + "&Mode=<%=MODE_SAVE%>&Type=<%=m_strType%>&PrevID=<%=m_lngPreviousId%>";
		objForm.submit();
	}
</Script>
 </form>
  </body>
</html>