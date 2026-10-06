<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
    $(document).ready(function()
    {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 16/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 16/12/2015
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_UpdateTaskCompletePerc.aspx.vb" Inherits="PbNIT.RT_UpdateTaskCompletePerc" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmUpdateTaskCompletePerc" name="frmUpdateTaskCompletePerc" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objDivMain = GetObjectReference('frmUpdateTaskCompletePerc','DivMain');
			var objForm;
			objForm = GetFormReference('frmUpdateTaskCompletePerc');
			
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
				
				intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				    intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight	;
				objDivMain.style.height = intDivHeight + 'px'	;
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				    intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight	;	
				objDivMain.style.height = intDivHeight + 'px'	;
				//alert(document.body.clientWidth);
			}
		
			
			function OnlyNumeric(intAllowDecimal)
			{
				var KeyAscii = window.event.keyCode;
				
				if (intAllowDecimal==1 && KeyAscii == 46)
				{
				return;
				}
				
				else
				{
				if ( KeyAscii < 48 || KeyAscii > 57 ) 
					{ window.event.keyCode = 0; } 
				}	
			}
			
			function ShowHelp()
			{
				window.open("../../Source/General/Help.aspx?HelpID=UPD_TASK_COMP","","resizable=yes,scrollbars=yes,Left=0,Top=0,height=250,width=250");
			}
			
			function CloseWindow()
			{
				window.close();
			}
			
			function ApplyFilter()
			{
				objForm.action = "UpdateTaskCompletePerc.asp?SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&Mode=<%=strMode%>&StartDate=<%=strStartDate%>&EndDate=<%=strEndDate%>";
				objForm.submit();;
			}
			
			/*function SortBy(strFieldName, strAscOrDesc)	
			{
				objForm.txtSortField.value = strFieldName
				frmTaskProgress.txtSortOrder.value = strAscOrDesc
				frmTaskProgress.action = "UpdateTaskCompletePerc.asp?SortField=" & strFieldName & "&SortOrder=" & strAscOrDesc & "&Mode=<%=strMode%>&StartDate=<%=strStartDate%>&EndDate=<%=strEndDate%>"
				frmTaskProgress.submit
			}*/
			
			function SaveTaskProgress()	
			{
				var checkValidateData;
				checkValidateData = ValidateData();
				
				//Validate % current progress values 
				if(checkValidateData)
				{
					objForm.action = "RT_UpdateTaskCompletePerc.aspx?SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&Mode=Save&StartDate=<%=strStartDate%>&EndDate=<%=strEndDate%>";
					objForm.submit();
				}
				
			}
			
			function SaveCloseTaskProgress()
			{
				var checkValidateData;
				checkValidateData = ValidateData();
				
				//Validate % current progress values 
				if(checkValidateData)
				{
					objForm.action = "RT_UpdateTaskCompletePerc.aspx?SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&Mode=Save&Link=Close&StartDate=<%=strStartDate%>&EndDate=<%=strEndDate%>";
					objForm.submit();
				}
			}
			
			
			
			/* ##### Function Validaite Data */
			function ValidateData() 
			{
				/*
				Modified By		:	HiteshS
				Modified On		:	11th Jan. 2005
				Changes For		:	Issue No - 15215
				Description		:	Validations changed to restrict Negative/String values (e.g. -12/2.2.2)
									Changed to alert messages
				*/
				var intCtr;
				var intCount;
				var checkValidation = false;
				var strObjName;
				var strObj;
				var objtxtPercentage = GetObjectReference('frmUpdateTaskCompletePerc','txtPercentageHidden',true);
				
				
				//Added on 28 JUL 2004
				var intRowCount = GetObjectReference('frmUpdateTaskCompletePerc','RowCount').value;
				//alert(intRowCount);
				
				if(intRowCount > 0)
				{
					for(intCtr = 1;intCtr <= intRowCount ; intCtr++)
					{
						strObjName = 'txtPercentage' + intCtr;
						strObj= GetObjectReference('frmUpdateTaskCompletePerc',strObjName);

						if(strObj != null)
						{
							if(strObj.value == '')
							{
								strObj.value = '0';
								checkValidation = true;
							}
							else if (isNaN(strObj.value) || (strObj.value < 0))
							{
								
								alert("'Task % Complete Till Date' should contain positive numeric values only.");
								strObj.select();
								checkValidation = false;
								break;
							}
							else if(strObj.value > 100) 
							{
								alert("The value of 'Task % Complete Till Date' should not exceed 100%.");
								strObj.select();
								checkValidation = false;
								break;
							}
							else
								checkValidation = true;
						}
					}	
					return checkValidation;
				}
				
				/*
				intCount = objtxtPercentage.length;
									//--- Check for  % Current Progress value. It should not exceed 100 
				if(intCount > 1)
				{
					alert('in multiple');
					for(intCtr = 0;intCtr <= intCount - 1; intCtr++)
					{
						if(objtxtPercentage[intCtr].value == '')
						{
							strObjName = 'txtPercentage' + intCtr;
							strObj= GetObjectReference('frmUpdateTaskCompletePerc',strObjName);
							strObj.value = '0';
						}
						else if(objtxtPercentage[intCtr].value > 100) Then
						{
							alert("The value of 'Current Progress %' should not exceed 100 !!");
							//return false;
							strObjName = 'txtPercentage' + intCtr;
							strObj= GetObjectReference('frmUpdateTaskCompletePerc',strObjName);
							strObj.focus();
							return false;
						}
					}	
					
				}
				else if(intCount == 1)
				{
						alert('in single');
						alert(objtxtPercentage[0].value);
						if(objtxtPercentage[0].value == '')
						{ 
							
							strObj= GetObjectReference('frmUpdateTaskCompletePerc','txtPercentage1');
							strObj.value = '0';
						}
						else if(objtxtPercentage[0].value > 100)
						{
							alert("The value of 'Current Progress %' should not exceed 100 !!");
							strObj= GetObjectReference('frmUpdateTaskCompletePerc','txtPercentage1');
							strObj.focus();
							return false;
						}
				}
				*/
				
	
			}	
			
			/* ##### End */


			

		</script>
	</body>
</HTML>
