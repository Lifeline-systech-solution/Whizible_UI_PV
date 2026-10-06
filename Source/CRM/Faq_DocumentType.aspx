<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Faq_DocumentType.aspx.vb" Inherits="PbNIT.Faq_DocumentType" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Document Attached")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
					<form id="frmShowHistory" method="post" runat="server">
									<%PageInit%>
					</form>
					<Script language="javascript">
		var objform=GetFormReference('frmShowHistory');
		var objdivlist=GetObjectReference('frmShowHistory','DivList');
		//onload="window_onload()" onresize="window_onresize()
		//The div tag has id as PageDiv 
	function window_onload()
	{
		var intDivHeight ;
		var intDivHeightRisk;
		if (objdivlist !=null) {
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
    }
	}
		
	function window_onresize()		
	{
		var intDivHeight;
		var intDivHeightRisk;
		if (objdivlist !=null) 
		{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
		}
	}	
		
	function Close_OnClick()
	{
		window.close();
	}
		
	function Page_OnClick(Char)		 
	{
		window.location.href='../CRM/Faq_DocumentType.aspx?ProjectID=<%=m_strProjectID%>&UniqueID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>&Paging='+ Char;
					
	}
	function Page_OnClickForIssue(Char)		 
	{
		window.location.href='../CRM/Faq_DocumentType.aspx?ProjectID=<%=m_strProjectID%>&IssueID=<%=m_strIssueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>&Paging='+ Char;
					
	}
	function Page_OnClickForCRM(Char)		 
	{
		window.location.href='../CRM/Faq_DocumentType.aspx?ProjectID=<%=m_strProjectID%>&QueryID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>&Paging='+ Char;
					
	}
	function Page_OnClickForDeliverable(Char)		 
	{
		window.location.href='../CRM/Faq_DocumentType.aspx?ProjectID=<%=m_strProjectID%>&ScheduleID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>&Paging='+ Char;
					
	}
	

	function Sort_OnClick_For_Issue(sortby,sortorder)
	{
		window.location.href = '../CRM/Faq_DocumentType.aspx?sortby=' + sortby + '&sortorder=' + sortorder + '&ProjectID=<%=m_strProjectID%>&IssueID=<%=m_strIssueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>';
	}


	function Sort_OnClick_For_Deliverable(sortby,sortorder)
	{
		window.location.href = '../CRM/Faq_DocumentType.aspx?sortby=' + sortby + '&sortorder=' + sortorder + '&ProjectID=<%=m_strProjectID%>&ScheduleID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>';
	}

	function Sort_OnClick_For_CRM(sortby,sortorder)
	{
		window.location.href = '../CRM/Faq_DocumentType.aspx?sortby=' + sortby + '&sortorder=' + sortorder + '&ProjectID=<%=m_strProjectID%>&QueryID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>&DocType=<%=m_strFrom%>';
	}

	function Sort_OnClick(sortby,sortorder)
	{
		window.location.href = '../CRM/Faq_DocumentType.aspx?sortby=' + sortby + '&sortorder=' + sortorder + '&ProjectID=<%=m_strProjectID%>&UniqueID=<%=m_strUniqueID%>&TagID=<%=m_strTagID%>';
	}
	
    function Document_OnClick(DID,ProjectID,Type)
    {
					
		var strTemp='../PM/PM_ViewDocument.aspx?DocumentID=' + DID +'&ProjectID='+ ProjectID + '&FromDashboard=Dashboard';
        window.open(strTemp);
                             
    }
		   
	function Document_OnClick_For_Issue(FileName)
    {
		var strTemp='../General/ViewAttachment.aspx?FromWhere=BTS&FileName=' + FileName;
		//var strTemp='../IB/IB_IssueEntry.aspx?IssueNavigation=0&Mode=Edit&IssueID='+ DID +'&AttachmentID=' + intAttachmentID + '&PageNumber=1&ProjectID=1121&FromWhere=BTS';
		window.open(strTemp);
    }
       
       //Added by Pramod D...On 13/07/2011
       //Purpose: To open the selected file                     
	function Document_OnClick_For_CRM(FileName,FilePath)
    {
    //FilePath Added by PramodD...For to show filwe name
      //Note : in Attachment.aspx which ges called while uploading a file from Helpdesk Page the FolderNames are hard coded in PerformAction method. Hence Fromwhere is Hard coded
		var strTemp='../General/ViewAttachment.aspx?FromWhere=FAQ&FileName='+ FileName +'&FilePath='+FilePath ;
		window.open(strTemp);
    }
    //Ended by pramod d...On 13/07/2011
            
    function Document_OnClick_For_Deliverable(FileName)
    {
	    var strTemp='../General/ViewAttachment.aspx?FromWhere=PD&FileName=' + FileName;
	    //var strTemp='../General/CLCP_Attachment.aspx?Operation=VIEW_ATTACHMENT&MappingID=' + intMappingID + '&SubTagFromCL=1&ForeignKey=ScheduleID&ForeignKeyValue=240&MasterTagID=2064&FromWhere=PM&SubTagPagingAlphabet=&ParentTagID=2133&SubTagSortBy=&SubTagSortOrder=';
	    window.open(strTemp);
    }
                            
    </Script>
	</body>
</HTML>
