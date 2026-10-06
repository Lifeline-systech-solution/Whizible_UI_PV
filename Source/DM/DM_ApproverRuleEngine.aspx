<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DM_ApproverRuleEngine.aspx.vb" Inherits="PbNIT.DM_ApproverRuleEngine" %>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(mybase.GetResourceString("WINDOW_TITLE"))%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
    
   
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">

		<form name = "frm_DM_RuleEngine" id="frm_DM_RuleEngine" method="post" runat="server">
			<%PageInit%>
		</form>
									
	
		<script language="javascript">
		objform=GetFormReference('frm_DM_RuleEngine');
		objDivMain=GetObjectReference('frm_DM_RuleEngine','PageDiv');
		objDivGrid=GetObjectReference('frm_DM_RuleEngine','DivList');
		   
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
    	function window_onload()		
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			var objfocus = GetObjectReference('frm_DM_RuleEngine','cboFieldList');
			if (objfocus != null)
				objfocus.focus();
			if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 56;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 65;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
			}
			
			if(objDivGrid != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivGrid.offsetTop - 78;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivGrid.offsetTop - 88;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivGrid.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
			}
			
		}

		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ intDivHeight = window.innerHeight -  objDivMain.offsetTop - 56; }
				else
				{ intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 65; }
				
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;
			}
			
			if(objDivGrid != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ intDivHeight = window.innerHeight -  objDivGrid.offsetTop - 78; }
				else
				{	
					intDivHeight = document.body.offsetHeight - objDivGrid.offsetTop-88 ; 
				}
				
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivGrid.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015	;
			}
		}
		
		function Sort_OnClick(sortby, sortorder)
		{
			var strQueryString = "DM_ApproverRuleEngine.aspx?Mode=ApplyAll&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&SortBy=" + sortby;
			//strQueryString = strQueryString + "&ApproverID="+<%=intApproverID%>;
			
			objform.action = strQueryString;
			objform.submit();
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function Save_OnClick(strMode)
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			var strQueryString;
			if (objRule.value == '')
			{
				alert('<%=mybase.getresourcestring("MSG_RULE_NOT_DEFINED")%>');
				return;
			}
			if ((strMode == 'EDIT')||(strMode == 'CLEAR')||(strMode == 'SAVE'))
			{
			strQueryString = "DM_ApproverRuleEngine.aspx?Mode=Save&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>;
			strQueryString = strQueryString + "&ApproverID="+<%=intApproverID%>;
			//+"&Rule="+objRule.value+"&UserFriendlyRule="+objUserFriendlyRule.value
			}
			
			if (strMode == 'APPLYALL') 
			{
				
				var objSelected = GetObjectReference("frm_DM_RuleEngine","chkApplicable",true);
				var objStage = GetObjectReference("frm_DM_RuleEngine","chkStage",true);
				var objcboStage = GetObjectReference("frm_DM_RuleEngine","cboStage");
				var isRecordSelected = 0;
				for(var i=0;i<objSelected.length;i++)
				{
					if (objSelected[i].checked == true)
						{
							isRecordSelected = 1; 
							objStage[i].checked = true;
						}
				}	
				if (isRecordSelected == 0)
				{
					alert('<%=mybase.getresourcestring("MSG_APPROVER_NOT_SELECTED")%>');
					return;
				}
				
				if (confirm('<%=mybase.getresourcestring("MSG_ALLOW_UPDATE")%>'))
				{
					strQueryString = "DM_ApproverRuleEngine.aspx?Mode=ApplyAll&Action=SaveAll&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+objStage.value;
					strQueryString = strQueryString + "&ApproverID="+objSelected.value;
					if (objcboStage.value != '')
						strQueryString = strQueryString + "&StageChange=Yes&StageID="+objcboStage.value;
					
					//+"&Rule="+objRule.value+"&UserFriendlyRule="+objUserFriendlyRule.value
				}
				else
					return;
			}
			//Added By NitinVS on 16 Feb 2007 for IssueID = 
			//To confirm user for applying rulecreation to be applied for existing initiatives
			var applyRule="&ApplyRuleForExisting=";
			/*if(confirm("If a rule is defined for an approver for first time, we can apply this rule for existing initiatives \nof selected nature of initiative to set 'To Do List' or 'Watch list'.\nPress OK to assign initiatives as per rule.\nPress Cancel not to assign existing initiatives.")==true)
			{
			*/
				applyRule = applyRule + "1" ;
			/*}
			else
			{
				applyRule = applyRule + "0" ;
			}
			*/
			objform.action = strQueryString + applyRule ;
			objform.submit();
		}
		
		function ClearRule_OnClick()
		{
			var strQueryString = "DM_ApproverRuleEngine.aspx?Mode=Clear&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>;
			strQueryString = strQueryString + "&ApproverID="+<%=intApproverID%>;
			
			if (confirm('This action will clear the rule defined.\n Click Ok to continue.'))
			{
				objform.action = strQueryString;
				objform.submit();
			}
		}
		
		function Field_OnChange()
		{
			var objFieldList = GetObjectReference("frm_DM_RuleEngine","cboFieldList");
			var objField = GetObjectReference("frm_DM_RuleEngine","cboField");
			
			for (var i = 1; i < objFieldList.length; i++)
			{
				if (objField[i].value != 3)
					var objControl = GetObjectReference("frm_DM_RuleEngine",objFieldList.options[i].value);
				else
					var objControl = GetObjectReference("frm_DM_RuleEngine","FFE29587WHIZ_"+objFieldList.options[i].value);
				if (navigator.appName=="Netscape") 
				{	var objControl = GetObjectReference("frm_DM_RuleEngine",objFieldList.options[i].value);	}
				var objCal = GetObjectReference("frm_DM_RuleEngine","imgCalendar");
				
				if ((objFieldList.value == objControl.name)||("FFE29587WHIZ_"+objFieldList.value == objControl.name))
				{	
				 	objControl.style.display = '';
					if (objField[i].value == 3)
						objCal.style.display = '';
					else
					{
						if (objCal!=null)
							objCal.style.display = 'none';
						
					}
				}
				else
				{
					objControl.style.display = 'none';
				}
			}
			
			window_onresize();
		}
		
		function FilterField_OnChange()
		{
			return;
		}
		function Calender_OnClick(strForm,strControl)
		{			
			var objFieldList = GetObjectReference("frm_DM_RuleEngine","cboFieldList");   
			//var intFilterFlag = objFieldList.value;
	
			var objField = GetObjectReference("frm_DM_RuleEngine","cboField");
			
			for (var i = 1; i < objFieldList.length; i++)
			{
				if (objField[i].value != 3)
					var objControl = GetObjectReference("frm_DM_RuleEngine",objFieldList.options[i].value);
				else
					var objControl = GetObjectReference("frm_DM_RuleEngine",objFieldList.options[i].value);
					
				if (objFieldList.value == objControl.name)
				{
							
					var strControlID;
					//var objSubmittedOnDate = GetObjectReference("frm_DM_RuleEngine","objControl")
					strControlID = new String(objControl.id);
					callcalendar("frm_DM_RuleEngine",strControlID);
				}
			}
				//alert(strControlID);
			
		}
		function Edit_OnClick(ApproverID)
		{
			var strQueryString = "DM_ApproverRuleEngine.aspx?Mode=Edit&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>+"&ApproverID="+ApproverID;
			objform.action = strQueryString;
			objform.submit();
		}
		function Back_OnClick()
		{
			var strQueryString = "DM_ApproverRuleEngine.aspx?Mode=List&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>;
			objform.action = strQueryString;
			objform.submit();
		}
		
		function Append_OnClick()
		{
			var objFieldList = GetObjectReference("frm_DM_RuleEngine","cboFieldList");
			var objOperator = GetObjectReference("frm_DM_RuleEngine","cboOperator");
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			var objField = GetObjectReference("frm_DM_RuleEngine","cboField");
			var objValidationRule = GetObjectReference("frm_DM_RuleEngine","cboValidationRule");
			if(objFieldList.value=='') 
			{
				alert('<%=mybase.getresourcestring("MSG_FIELD_NOT_SELECTED")%>');
				objFieldList.focus();
				return;
			}
			if(objOperator.value=='') 
			{
				alert('<%=mybase.getresourcestring("MSG_OPERATOR_NOT_SELECTED")%>');
				objOperator.focus();
				return;
			}
			for (var i = 1; i < objFieldList.length; i++)
			{
			
				var objControl = GetObjectReference("frm_DM_RuleEngine",objFieldList.options[i].value);
				if (objFieldList.value == objControl.name)
				{
					if(objControl.value=='') 
					{
						alert('<%=mybase.getresourcestring("MSG_VALUE_NOT_SELECTED")%>');
						objControl.focus();
						return;
					}
					else
					{
						// Combo 					
						if (objField[i].value == 1)
						{
							if ((objOperator.value != '=') && (objOperator.value != '<>'))
							{
								var strAlert = '<%=mybase.getresourcestring("MSG_INVALID_OPERATOR")%>';
								alert(strAlert.replace(/&#39;/g,'\''));
								objOperator.focus();
								return;
							}
							
							objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl.value;
							objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[objControl.selectedIndex].text;			
						}
						// Text Box
						if (objField[i].value == 2)
						{
							if (isValid(objValidationRule[i],objControl)==false)
									return;
							objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl.value;
							objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.value;		
						}
						// Date Control
						if (objField[i].value == 3)
						{
							objRule.value = objRule.value + " " + objFieldList.value + " " + objOperator.value + " '" + objControl.value + "'";
							objUserFriendlyRule.value = objUserFriendlyRule.value + " " + objFieldList.options[objFieldList.selectedIndex].text + " " + objOperator.value + " '" + objControl.value + "'";		
						}
						// List
						if (objField[i].value == 4)
						{
							var chkFirstSelected = 1;
							if ((objOperator.value != '=') && (objOperator.value != '<>'))
							{
								alert('<%=mybase.getresourcestring("MSG_INVALID_OPERATOR")%>'.replace(/&#39;/g,"'"));
								objOperator.focus();
								return;			
							}
							for (var j=0;j<objControl.length;j++)
							{
								if (objControl.options[j].selected)
								{
								
									if (chkFirstSelected == 1)						
									{	
										objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl[j].value;
										objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[j].text;
										chkFirstSelected = 0;
									}
									else
									{
									     objRule.value = objRule.value + ' OR ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl[j].value;
									     objUserFriendlyRule.value = objUserFriendlyRule.value + ' OR ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[j].text;
									     
									}
								}
							}
						}//End of List Box Append
						
					}
				}
			}
				
		}
		function ClearAll_OnClick()
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = '';
			objUserFriendlyRule.value = '';
		}
		function OpeningBracket_OnClick()
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + '(';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + '(';
		}
		
		function ClosingBracket_OnClick()
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + ')';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + ')';
		}
		
		function And_OnClick()
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + 'AND';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + 'AND';
		}
		function Or_OnClick()
		{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + 'OR';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + 'OR';
		}
		
		function History_OnClick(FieldID)
		{
			var TagID = 2049;
			
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=1&TagID=" + TagID + "&UniqueID=" + FieldID + "&ProjectID=0", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		
		function cboStage_Change()
		{
			var objStage = GetObjectReference('frm_DM_InitiativeReallocation','cboStage');
			var strQueryString;
			
			strQueryString = "DM_ApproverRuleEngine.aspx?Mode=ApplyAll&NatureOfDemandID="+<%=intNatureOfDemandID%>;
			
			if (objStage.value != '')
				strQueryString = strQueryString + "&StageChange=Yes&StageID="+objStage.value;
			objStage.focus()			
			objform.action = strQueryString;
			objform.submit();
		}
		
		function isValid(objRule,objFieldValue)
		{
			var strRule=new String(objRule.value);
			var arrRule = new Array();
			
			arrRule  = strRule.split(',');
			for(var i=0;i<arrRule.length;i++)
			{
				switch(arrRule[i])
				{
					case '13': if (disallowNegativeNumeric(objFieldValue) == true)
								{	
									alert('<%=mybase.getresourcestring("MSG_POS_NUM")%>');
									return false;
								}
								break;
					
					case '20': if ((isInteger(objFieldValue.value) == false)||(parseInt(objFieldValue.value) < 0))
								{
									alert('<%=mybase.getresourcestring("MSG_POS_INT")%>');
									return false;
								}
				}
			}
			return true;
		}

		// To add functionality to allow all and Allow none
	function AllowAll_OnClick()
	{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = ' ' + "1 =1";
			objUserFriendlyRule.value = ' ' + "Allow All";	
	}
	
	function AllowNone_OnClick()
	{
			var objRule = GetObjectReference("frm_DM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_DM_RuleEngine","txtUserFriendlyRule");
			objRule.value = ' ' + "1 = 2";
			objUserFriendlyRule.value = ' ' + "Deny All";
	
	}
	
		</script>
	</body>
</html>
