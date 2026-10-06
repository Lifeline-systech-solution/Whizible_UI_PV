<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_ReportTemplates.aspx.vb" Inherits="Whiz.CRW_ReportTemplates" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmReportTemplate" name="frmReportTemplate" method="post" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
			<%GenerateReportTemplates%>
		</form>
	<script language="javascript">
			function SubmitForm()	
            {
				var objform;
				objform = GetFormReference('frmReportTemplate');
				
				objform.action = "CRW_ReportTemplates.aspx?MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
			
			function Template_OnClick(intTemplateID,intReportType,intReportLayout)
			{	var strMode='ADD';
				var strOpenFile='CRW_WIZ_CreateReport.aspx?MasterTagID=<%=m_strMasterTagID%>&TemplateID='+intTemplateID+'&ReportType='+intReportType+'&Layout='+intReportLayout+'&Mode='+strMode
				window.open(strOpenFile,'','height=450,width=850,resizable=yes,left=130,top=125');<% 'WAF3_PB_42 April 10, 2007 Change Width to 850 and left to 130  %>
				window.close();
			}
			
			function Preview_OnClick(intTemplateID)
			{
				var strOpenFile ='CRW_TemplatePreview.aspx?TemplateID='+intTemplateID
				
				window.open(strOpenFile,'','height=420,width=500,resizable=yes,left=' + (window.screen.width-500)/2 + ',top=' + (window.screen.height-420)/2 )
				
			}
	
				var objdivlist;
		
				var objfrm;
				objfrm=	GetFormReference('frmReportTemplate')
				objdivlist=GetObjectReference('frmReportTemplate','divBody')
				<% 'WAF3_PB_42 April 10, 2007 modified window_onload and window_onresize functions  %>
				function window_onload()
				{
					var intFillFactor=(arguments.length>0)?arguments[0]:50;
                    windowSize_common(intFillFactor);					
					WindowLoading();
				}	
				function window_onresize()		
				{
					var intFillFactor=(arguments.length>0)?arguments[0]:50;
                    windowSize_common(intFillFactor);					
					UpdateWindowSize();	
				}<% 'WAF3_PB_42 April 10, 2007%>
			</script>
	</BODY>
</HTML>


<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
 
<script type="text/javascript" src="../General/responsive/responsive.js"></script>


<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Report >Report Builder
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:09/02/2015
    /*---------------------------------------------------------*/

    if($('.clsGridTable').length > 0)
    {
        var divName=$('#divListPageTag').find('div:first').attr('id');
        dataCollapse(divName);
    }
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration >Report >	Report Builder
    /*---------------------------------------------------------*/

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
});
</script>