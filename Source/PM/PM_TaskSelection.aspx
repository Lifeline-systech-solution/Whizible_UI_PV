<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskSelection.aspx.vb" Inherits="PbNIT.PM_TaskSelection" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <HEAD>
        <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
        
        
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
        <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

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


	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmTaskList" name="frmTaskList" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
        
        <%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
           
		function Page_Onclick(strPageNumber)
		{
			objfrmTaskList = GetFormReference('frmTaskList');
			objfrmTaskList.action = "PM_TaskSelection.aspx?PageNumber=" + strPageNumber + "<%=m_strQSParameters%>&TaskType=<%=m_strTaskType%>";
			objfrmTaskList.submit();
		}

		function window_onload()		
		{
			objform=GetFormReference('frmTaskList');
			objDivMain=GetObjectReference('frmTaskList','DivMain');

			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			
			//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			if (intDivHeight < 100)
			    intDivHeight = 100;

		    //objDivMain.style.height = intDivHeight	;
			objDivMain.style.height = intDivHeight+'px';
			
		}
		function window_onresize()		
		{
			objform=GetFormReference('frmTaskList');
			objDivMain=GetObjectReference('frmTaskList','DivMain');
			
			var intDivHeight ;
			var intDivHeightRisk;
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			if (intDivHeight < 100)
				intDivHeight = 100;
		    //objDivMain.style.height = intDivHeight	;
			objDivMain.style.height = intDivHeight + 'px';
			
		}

		function Task_OnClick(strTaskType)
		{
			var objForm = GetFormReference('frmTaskList');
		
			<% If Trim(Request.QueryString("FromWhere")) = "TaskTypeTimesheet" Then %>
				objForm = "TTTimesheet";
			<% Else %>
				objForm = "DA";
			<% End If %>
						
			objfrmTaskList = GetFormReference('frmTaskList');
		
			switch (strTaskType)
			{	
				case "<%=DEFECTS_ASSIGNED%>":
					objTasks = GetParentObjectReference(objForm,"optDefectTasks");
					objTasks.checked = true;
					objTasks.onclick();
					break;
				case "<%=PROJECT_SPECIFIC_TASKS%>":
					objTasks = GetParentObjectReference(objForm,"optProjectTasks");
					objTasks.checked = true;
					objTasks.onclick();
					break;
				case "<%=GENERAL_TASKS%>":
					objTasks = GetParentObjectReference(objForm,"optGeneralTasks");
					objTasks.checked = true;
					objTasks.onclick();
					break;
				case "<%=ASSIGNED_TASKS%>":
					objTasks = GetParentObjectReference(objForm,"optAssignedTasks");
					objTasks.checked = true;
					objTasks.onclick();
					break;
			}
			objfrmTaskList.action = "PM_TaskSelection.aspx?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>&TaskType=" + strTaskType;
			objfrmTaskList.submit();
	}

	function GetParentObjectReference(frm,ctrl)
	{
		return window.opener.document.forms[frm].elements[ctrl];
	}
	
	function GetParentFormReference(frm)
	{
		return window.opener.document.forms[frm];
	}
	
    function LinkField_OnClick(strUniqueValue)
    {
   
		try
		{
	   	<% If Trim(Request.QueryString("FromWhere")) = "TaskTypeTimesheet" Then %>
			GetParentObjectReference("TTTimesheet","cboTaskID").value = strUniqueValue;
			GetParentObjectReference("TTTimesheet","cboTaskID").onchange();
		<% Else %>
			GetParentObjectReference("DA","cboTask").value = strUniqueValue;
			GetParentObjectReference("DA","cboTask").onchange();
		<% End If %>
        window.close();
        }
        catch(e)
        {
        }
	}

    function IncludeCompletedTasks(intFlag)
    {
     	var objForm = GetFormReference('frmTaskList');
     	<% If Trim(Request.QueryString("FromWhere")) = "TaskTypeTimesheet" Then %>
			GetParentObjectReference("TTTimesheet","txtIncludeCompletedTasks").value = intFlag;
			GetParentFormReference("TTTimesheet").action = "PM_TaskTypeTimesheet.aspx";
			GetParentFormReference("TTTimesheet").submit();
		<% Else %>				
			GetParentFormReference("DA").action = "PM_DailyActivity.aspx?Mode=New&IncludeCompletedTasks=" + intFlag;
			GetParentFormReference("DA").submit();
		<% End If %>
        
        objForm.action = "PM_TaskSelection.aspx?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>&IncludeCompletedTasks=" + intFlag;
        objForm.submit();
	}

    function TaskType_OnChange()
    {
    
		var objForm = GetFormReference('frmTaskList');
		<% If Trim(Request.QueryString("FromWhere")) = "TaskTypeTimesheet" Then %>
		    GetParentObjectReference("TTTimesheet","cboTaskTypeID").value = GetObjectReference('frmTaskList', 'cboTaskType').value;
			GetParentObjectReference("TTTimesheet","cboTaskTypeID").onchange();
			//Commented By VivekP 30 May 2005
		//<% Else %>
		//	GetParentObjectReference("DA","cboTaskType").value = GetObjectReference('frmTaskList', 'cboTaskType').value;
		//	GetParentObjectReference("DA","cboTaskType").onchange();
			<% End If %>
        objForm.action = "PM_TaskSelection.aspx?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>";
        objForm.submit();
	}

    function SortBy(strFieldName, strAscOrDesc)
    {
		var objForm = GetFormReference('frmTaskList');
		// Added if condition and else block by PrashantD on 27 March 2007 for IssueID 11133
		 <% If Request.QueryString("FromWhere") <> "TaskTypeTimesheet" Then %>
        objForm.txtSortField.value = strFieldName;
        objForm.txtSortOrder.value = strAscOrDesc;
        <% else %>
        objForm.txtSortField.value = "A." + strFieldName;
        objForm.txtSortOrder.value = strAscOrDesc;
        <%End if%>
        
        objForm.action = "PM_TaskSelection.aspx?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>";
        objForm.submit();
    }

    function SetFilter()
    {
		var objForm = GetFormReference('frmTaskList');
        objForm.action = "TaskSelection.asp?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>";
        objForm.submit();
    }

    function ClearFilter()
    {
		var objForm = GetFormReference('frmTaskList');
        objForm.txtFilter.value = "";
        objForm.action = "TaskSelection.asp?PageNumber=<%=m_strPageNumber%><%=m_strQSParameters%>";
        objForm.submit();
    }
    
    function Sort_OnClick(strFieldName, strAscOrDesc)
	{
		var objForm, objSortBy, objSortOrder;
		objForm = GetFormReference('frmTaskList');
		objSortBy = GetObjectReference('frmTaskList','txthidSortBy');
		objSortOrder = GetObjectReference('frmTaskList','txthidSortOrder');
		objSortBy.value = strFieldName;
		objSortOrder.value = strAscOrDesc;
		objForm.submit();		
	}

		</script>
	</body>
</HTML>
