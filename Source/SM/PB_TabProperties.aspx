<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_TabProperties.aspx.vb" Inherits="Whiz.PB_TabProperties" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_TabProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmInitialTabProperties" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
			var objdivlist;
			objdivlist=GetObjectReference('frmInitialTabProperties','InitialDiv');
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
			}
			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -40;
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
				objTitle = GetObjectReference('frmInitialTabProperties','txtTitle');
				objTitle.focus();
			}
			
			function Close_OnClick()
			{
				window.close()
			}
			
			function DataSource_OnChange()
			{
				var objForm;
				var flag;
				
				objForm = GetObjectReference('frmInitialTabProperties','frmInitialTabProperties');
				objtxtHidden = GetObjectReference('frmInitialTabProperties','txtInputHidden');
				objtxtHidden.value = 'False';
				objForm.submit();				
			}

			function PageType_OnChange()
			{
				var objForm;
				var flag;
				
				objForm = GetObjectReference('frmInitialTabProperties','frmInitialTabProperties');
				objtxtHidden = GetObjectReference('frmInitialTabProperties','txtInputHidden');
				objtxtHidden.value = 'False';
				objForm.submit();				
			}

			function Next_OnClick()
			{
				var objForm;
				var flag;
				var arrValues = Array();
				var valCount;				
				var index;
				var attachmentFlag;
                var objAttachedBy;
				var objDateAttached;
				var objDescription; 
				var objFileName; 
				var objFKField; 
				var objLoginType; 
				var objOrgFileName; 
							
				objtxtHidden = GetObjectReference('frmInitialTabProperties','txtInputHidden');
				objtxtHidden.value = 'True';
				
				objForm = GetObjectReference('frmInitialTabProperties','frmInitialTabProperties');
				objDataSource = GetObjectReference('frmInitialTabProperties','cboDataSource');
				objTitle = GetObjectReference('frmInitialTabProperties','txtTitle');
				objType = GetObjectReference('frmInitialTabProperties','cboPageType');
				objPrimaryKey = GetObjectReference('frmInitialTabProperties','txtPrimaryKey');
                objVirtualPath = GetObjectReference('frmInitialTabProperties', 'txtVirtualPath'); 
				objAttachedBy = GetObjectReference('frmInitialTabProperties', 'cboAttachedBy');
				objDateAttached = GetObjectReference('frmInitialTabProperties', 'cboDateAttached');
				objDescription = GetObjectReference('frmInitialTabProperties', 'cboDescription');
				objFileName = GetObjectReference('frmInitialTabProperties', 'cboFileName');
				objFKField = GetObjectReference('frmInitialTabProperties', 'cboFKFieldAtt');
				objLoginType = GetObjectReference('frmInitialTabProperties', 'cboLoginType');
				objOrgFileName = GetObjectReference('frmInitialTabProperties', 'cboOrgFileName');
				objFKFieldName = GetObjectReference('frmInitialTabProperties', 'cboFKFieldName');//Added By NileshD on 6 dec. 2004
               					  
                if (objVirtualPath != null)
					attachmentFlag = 'True';
                
				<%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>
				
				flag = disallowBlank(objTitle, "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
				if (flag == false)
				{
					flag = disallowSpecialCharacters(objTitle, "<%=MyBase.GetResourceString("DISALLOW_NON_ALPHABETS")%>");
					if (flag == false)
					{
						flag = disallowBlank(objDataSource,  "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
						if (flag == false)
						{
							if (flag == false)
							{
								//Added By NileshD on 6 dec. 2004
								if ((attachmentFlag != 'True') && (objFKFieldName.selectedIndex == -1))
								{
								  alert('Please Select the table (Data source) which has relation with master');
								  return;
								}
								//End Of Addition
							
								if (objVirtualPath != null)
								{
									flag = disallowBlank(objVirtualPath,  "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>");
									if (flag == true)
									{
										return;
									}

									if (isBlank(getInputValue(objPrimaryKey)))
									{
										alert("Select a table which has primary key");
										return;
									}
								}
								if (attachmentFlag == 'True')
								{
									arrValues = StoreValues(attachmentFlag, 'cboFKFieldAtt');
									flag = disallowDuplicates(objFKField, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboOrgFileName');
									flag = disallowDuplicates(objOrgFileName, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboFileName');
									flag = disallowDuplicates(objFileName, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboAttachedBy');
									flag = disallowDuplicates(objAttachedBy, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>', true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboDateAttached');
									flag = disallowDuplicates(objDateAttached, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboDescription');
									flag = disallowDuplicates(objDescription, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

									arrValues = StoreValues(attachmentFlag, 'cboLoginType');
									flag = disallowDuplicates(objLoginType, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true,1);
									if ( flag == true)
									{	
										return;
									}

								}			
								<%MyBase.InitializeResources("Resources.PB_Resources", "Resources")%>
								alert("<%=MyBase.GetResourceString("PAGE_CREATED")%>");
								objType.disabled = false;
								if (objPrimaryKey != null)
									objPrimaryKey.disabled = false;
								objForm.submit();
							}
						}
					}
				}
			}
			function StoreValues(attachmentFlag, controlID)
			{
				var index;
				var arrValues = new Array();
				var objSingleRecord = GetObjectReference('frmInitialTabProperties', 'chkIsSingleRecord');
				index=0;
				if (attachmentFlag == 'True')
				{
					if (objSingleRecord.checked == false)
					{
						objPrimaryKey = GetObjectReference('frmInitialTabProperties', 'txtPrimaryKey');
						arrValues[index] = getInputValue(objPrimaryKey);
						index++;
					}
					if ( controlID != 'cboAttachedBy')
					{
						objAttachedBy = GetObjectReference('frmInitialTabProperties', 'cboAttachedBy');
						arrValues[index] = getInputValue(objAttachedBy);
						index++;
					}
					if ( controlID != 'cboDateAttached')
					{
						objDateAttached = GetObjectReference('frmInitialTabProperties', 'cboDateAttached');
						arrValues[index] = getInputValue(objDateAttached);
						index++;
					}
					if ( controlID != 'cboDescription')
					{
						objDescription = GetObjectReference('frmInitialTabProperties', 'cboDescription');
						arrValues[index] = getInputValue(objDescription);
						index++;
					}
					if ( controlID != 'cboFileName' )
					{
						objFileName = GetObjectReference('frmInitialTabProperties', 'cboFileName');
						arrValues[index] = getInputValue(objFileName);
						index++;
					}
					if ( controlID != 'cboFKFieldAtt' )
					{
						objFKField = GetObjectReference('frmInitialTabProperties', 'cboFKFieldAtt');
						arrValues[index] = getInputValue(objFKField);
						index++;
					}
					if (controlID != 'cboLoginType' )
					{
						objLoginType = GetObjectReference('frmInitialTabProperties', 'cboLoginType');
						arrValues[index] = getInputValue(objLoginType);
						index++;
					}
					if (controlID != 'cboOrgFileName' )
					{
						objOrgFileName = GetObjectReference('frmInitialTabProperties', 'cboOrgFileName');
						arrValues[index] = getInputValue(objOrgFileName);
						index++;
					}
				}
				return arrValues;
			}
			
		</script>
	</body>
</HTML>
