<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SM_CCToList.aspx.vb" Inherits="PbNIT.SM_CCToList"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(Print_Title())%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
	<form id="frmSM_CCToList" method="post" runat="server">
				<%PageInit%>
	</form>
	<script language="javascript">
	objform=GetFormReference('frmSM_CCToList');
	objDivMain=GetObjectReference('frmSM_CCToList','PageDiv');
	
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
			document.body.style.visibility='visible';
			if(objDivMain != null)
			{
			if (navigator.appName=="Netscape") 
			 {
				if ('<%=m_strProjectID%>'=='')
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 35;
				else
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 70;
			 }
			 else
			 {
				if ('<%=m_strProjectID%>'=='')
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
				else
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
			 }
			 
			 if (intDivHeight < 100)
				intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight;
			 objDivMain.style.height = intDivHeight + 'px';
			}
			
		}
		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ 
					if ('<%=m_strProjectID%>'=='')
						intDivHeight = window.innerHeight -  objDivMain.offsetTop - 35;
					else
						intDivHeight = window.innerHeight -  objDivMain.offsetTop - 70; 
				}
				else
				{ 
				
					if ('<%=m_strProjectID%>'=='')
						intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
					else
						intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
				}
				
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight + 'px';
			}
			
		}
		
	function Sort_OnClick(sortby,sortorder)
	{
		var strQueryString;
		strQueryString = "SM_CCToList.aspx?Mode=Display&Entity=<%=m_ConfigureFor%>";
		
		if ('<%=m_ConfigureFor%>'=='BG')
			strQueryString += "&BusinessGroupID=<%=m_ConfigureID%>";
		if ('<%=m_ConfigureFor%>'=='OU')
			strQueryString += "&LocationID=<%=m_ConfigureID%>";
		if ('<%=m_ConfigureFor%>'=='DU')
			strQueryString += "&ResourcePoolID=<%=m_ConfigureID%>";
		if ('<%=m_ConfigureFor%>'=='DT')
			strQueryString += "&GroupID=<%=m_ConfigureID%>";
			
		if ('<%=m_ConfigureFor%>'=='CORPORATE')	
			strQueryString += "&CorporateCC=<%=m_strCorporateCCList%>";
	
		if ('<%=m_ConfigureFor%>'=='EXCLUDEROLE')
			strQueryString += "&ExcludeRoleList=<%=m_strExcludeRoleList%>";
	
		strQueryString += "&Paging=<%=m_strpaging%>";
		strQueryString += "&SortBy=" + sortby + "&SortOrder=" + sortorder;
		
		objform.action = strQueryString;
		//objform.action = "SM_CCToList.aspx?SortBy=" + sortby + "&SortOrder=" + sortorder;
		objform.submit();  
	}
	
	function Save_OnClick()
	{
		var objSelected = GetObjectReference("frm_PM_InitiativeMapping","chkApplicable",true);
		var isRecordSelected = 0;
		var strChecked = '';
		var strUnchecked = '';
		for(var i=0;i<objSelected.length;i++)
		{
			if (objSelected[i].checked == true)
				isRecordSelected = 1; 
		}	
		/*
		if (isRecordSelected == 0)
		{
			if (confirm('This action will Configure a Timesheet Defaulter Email without a CC List.\nPress OK to continue.')==false)
							return;
		}*/
		
		for(var i=0;i<objSelected.length;i++)
		{
			if (objSelected[i].checked == true)
				strChecked = strChecked + objSelected[i].value + ',';
			else
				strUnchecked = strUnchecked + objSelected[i].value + ',';

		}
		
		if ('<%=m_ConfigureFor%>'=='CORPORATE')
			objform.action = "SM_CCToList.aspx?Mode=Save&Entity=<%=m_ConfigureFor%>&List="+strChecked+"&Unchecked="+strUnchecked+"&CorporateCC=<%=m_strCorporateCCList%>";
		else if ('<%=m_ConfigureFor%>'=='EXCLUDEROLE')
		{
			objform.action = "SM_CCToList.aspx?Mode=Save&Entity=<%=m_ConfigureFor%>&List="+strChecked+"&Unchecked="+strUnchecked+"&ExcludeRoleList=<%=m_strExcludeRoleList%>";
		}
				
		else
		{	
			if ('<%=m_strProjectID%>'!='')
				objform.action = "SM_CCToList.aspx?Mode=Save&Action=Project&Entity=<%=m_ConfigureFor%>&ID=<%=m_ConfigureID%>&ProjectID=<%=m_strProjectID%>";
			else
				objform.action = "SM_CCToList.aspx?Mode=Save&Action=CC&Entity=<%=m_ConfigureFor%>&ID=<%=m_ConfigureID%>&List="+strChecked+"&Unchecked="+strUnchecked;
		}
			
		objform.submit();
	}
	
	function Close_OnClick()
	{
		window.close();
	}
	
	function ConfigureCC_Onclick(ProjectID)
	{
		
		window.open("../SM/SM_CCToList.aspx?Mode=Display&Entity=<%=m_ConfigureFor%>&ID=<%=m_ConfigureID%>&ProjectID="+ProjectID, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400")
		
	}
	
	function Filter_OnChange(e,IsText)
	{
			
			var strQueryString;
			strQueryString = "SM_CCToList.aspx?Mode=Display&Entity=<%=m_ConfigureFor%>";
			
			if ('<%=m_ConfigureFor%>'=='BG')
				strQueryString += "&BusinessGroupID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='OU')
				strQueryString += "&LocationID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='DU')
				strQueryString += "&ResourcePoolID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='DT')
				strQueryString += "&GroupID=<%=m_ConfigureID%>";
				
			if ('<%=m_ConfigureFor%>'=='CORPORATE')	
				strQueryString += "&CorporateCC=<%=m_strCorporateCCList%>";
			
			//Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
			if ('<%=m_ConfigureFor%>'=='EXCLUDEROLE')	
				strQueryString += "&ExcludeRoleList=<%=m_strExcludeRoleList%>";
				
			//End Addition
				/*
				
			var objRole = GetObjectReference('frmSM_CCToList','cboRole');
			var objDesignation = GetObjectReference('frmSM_CCToList','cboDesignationName');
			var objDepartment = GetObjectReference('frmSM_CCToList','cboDepartment');
			
			var objDesignation = GetObjectReference('frmSM_CCToList','cboBusinessGroupID');
			var objDepartment = GetObjectReference('frmSM_CCToList','cboLocation');
			var objEmployeeName = GetObjectReference('frmSM_CCToList','EmployeeName');			
			
			if (objRole.value != '')
				strQueryString = strQueryString + "&Stage="+objStage.value;
				
			if (objBG.value != '')
				strQueryString = strQueryString + "&BG="+objBG.value;
				
			if (objNOI.value != '')
				strQueryString = strQueryString + "&NOI="+objNOI.value;
			
			*/
			strQueryString += "&Paging=<%=m_strpaging%>";
			strQueryString += "&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>";
			if (IsText==true)
			{
				var objEmployeeName = GetObjectReference('frmSM_CCToList','EmployeeName');			
				if (e.keyCode) code = e.keyCode;
				else if (e.which) code = e.which;
				if(code==13)
				{
					objform.action = strQueryString;
					objform.submit();	
					
				}
				else
					return;
				
			}
			else
			{
				objform.action = strQueryString;
				objform.submit();	
			}
		
	}
	function Page_Onclick(strPaging)
		{
			var strQueryString;
			strQueryString = "SM_CCToList.aspx?Mode=Display&Entity=<%=m_ConfigureFor%>";
			
			if ('<%=m_ConfigureFor%>'=='BG')
				strQueryString += "&BusinessGroupID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='OU')
				strQueryString += "&LocationID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='DU')
				strQueryString += "&ResourcePoolID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='DT')
				strQueryString += "&GroupID=<%=m_ConfigureID%>";
			if ('<%=m_ConfigureFor%>'=='CORPORATE')	
				strQueryString += "&CorporateCC=<%=m_strCorporateCCList%>";
				
			//Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
			if ('<%=m_ConfigureFor%>'=='EXCLUDEROLE')	
				strQueryString += "&ExcludeRoleList=<%=m_strExcludeRoleList%>";
			//End Addition
			
			strQueryString += "&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>";
			
			strQueryString += "&Paging="+strPaging;
			objform.action = strQueryString;
			objform.submit(); 
		}
		
	function chkSelect_OnClick(obj)
		{
		var objToBeAdded, objToBeDeleted,strToBeAdded,strToBeDeleted;
		
		objToBeAdded = GetObjectReference('frmCommonPage','txtEmptobeadded');		
		objToBeDeleted = GetObjectReference('frmCommonPage','txtEmptobedeleted');
		strToBeAdded = new String (objToBeAdded.value)
		strToBeDeleted = new String (objToBeDeleted.value)
			
		var EmpID = obj.value;
		
		if(obj.checked==true)
				{
					//if not in the list then add 
					if(strToBeAdded.indexOf("," + EmpID +",",0)==-1)
					{
						strToBeAdded = strToBeAdded + EmpID + ",";
						objToBeAdded.value = strToBeAdded; 
						
					}    			
				}
				else
				{
					if(strToBeDeleted.indexOf("," + EmpID +",",0) == -1)
					{
						//Remove the Employee ID from the comma separated list.
						strToBeDeleted = strToBeDeleted + EmpID + ",";
						objToBeDeleted.value = strToBeDeleted; 
						
					}
				}
		}
	function SelectAll_OnClick()
	{
			var objchkApplicable = GetObjectReference('frmSM_CCToList','chkApplicable',true);
			var LoopCtr; 
			
			if (objchkApplicable.length == 0)
			{
				alert("There are no records to select.");
				return;
			}	
			
			for (LoopCtr = 0; LoopCtr < objchkApplicable.length; LoopCtr++)
			{
				objchkApplicable[LoopCtr].checked=true;
			}
			return;
	}
	
	function ClearAll_OnClick()
	{
			var objchkApplicable = GetObjectReference('frmSM_CCToList','chkApplicable',true);
			var LoopCtr; 
			
			if (objchkApplicable.length == 0)
			{
				alert("There are no records to clear.");
				return;
			}	
			
			for (LoopCtr = 0; LoopCtr < objchkApplicable.length; LoopCtr++)
			{
				objchkApplicable[LoopCtr].checked=false;
			}
			return;
	}
	</script>
	</body>
</HTML>
