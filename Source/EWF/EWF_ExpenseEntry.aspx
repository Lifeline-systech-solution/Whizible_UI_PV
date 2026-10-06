<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_ExpenseEntry.aspx.vb" Inherits="PbNIT.EWF_ExpenseEntry" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Expense Entry")%>
 
 
<%--   Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade
  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmEWF_ExpenseEntry" method="post" runat="server">
													<%PageInit%>
						
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmEWF_ExpenseEntry');
		//var objdivlist=GetObjectReference('frmEWF_ExpenseEntry','PageDiv');
		var objdivlist=GetObjectReference('frmEWF_ExpenseEntry','DivMain');
		var objMode = '<%=m_strParamMode%>';
		var m_lngTagId=<%=m_lngTagId%>;
		
		 <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //  intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
               
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 28; //Added by Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';
			}			
			//Added by PurvaJ on 14th April 2006 issue id 2886 
			if (GetObjectReference('frmEWF_ExpenseEntry','cboProject').disabled == false )
						GetObjectReference('frmEWF_ExpenseEntry','cboProject').focus()		
			//end addition
						
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 28; //Added by Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function ProjectComboSubmit(Mode)
		{
			var m_lngTagId=<%=m_lngTagId%>;
			var ProjectID=GetObjectReference('frmEWF_ExpenseEntry','cboProject').value;
			
			objform.action= "../EWF/EWF_ExpenseEntry.aspx?MasterTagID=" + m_lngTagId + "&ProjectID=" +ProjectID + "&Mode="+ Mode ;
			//objform.action= "../EWF/EWF_ExpenseEntry.aspx?Mode="+ Mode ;
			objform.submit();
		}
		
		function CostGroupComboSubmit(Mode)
		{
			var m_lngTagId=<%=m_lngTagId%>;
			objform.action= "../EWF/EWF_ExpenseEntry.aspx?MasterTagID=" + m_lngTagId + "&Mode="+ Mode ;
			//objform.action= "../EWF/EWF_ExpenseEntry.aspx?Mode="+ Mode ;
			objform.submit();
		}
		
		function CostHeadComboSubmit(Mode,d)
		{
			var m_lngTagId=<%=m_lngTagId%>;
			objform.action= "../EWF/EWF_ExpenseEntry.aspx?MasterTagID=" + m_lngTagId + "&Mode="+ Mode + "&d="+d ;
			objform.submit();

		}
		
		function Save_OnClick(intFlag)
		{
			var isSubmitted = "<%=m_blnisSubmitted%>";
			//  If the Finance Approver has logged in then he can change the Finance Processing Center	
			if ( isSubmitted == "True" && intFlag != 4) 
			{
				alert("<%=MyBase.getResourceString("MSG_EXPENSE_BLOCKED")%>");
				return ;
			}
			if (validateControl()== false) return ;			
			//Added By PradeepD to resolve IssueID 20983 on 12-Sep-2005
			//Commented by HarshK on 13 Apr 2006 for IssueID 3314
			//opener.location.reload();
			//END Commented by HarshK on 13 Apr 2006 for IssueID 3314
			//END: Added By PradeepD to resolve IssueID 20983 on 12-Sep-2005
			// Added By PradeepD to resolve Issue 21658 on 27-Oct-2005: Enable IsBillable checkbox 
			GetObjectReference('frmEWF_ExpenseEntry','chkIsBillable').disabled = false;
			//EnableControls();
			// END: Added By PradeepD to resolve Issue 21658 on 27-Oct-2005: Enable controls before saving
			//17-Nov-05 AbhijitD- Added finance Approver and admin verifier to the querystring
			objform.action= "../EWF/EWF_ExpenseEntry.aspx?RefreshDetailsWindow=" + intFlag + "&PKExpensesToken="+ "<%=m_strPKToken_Expense_Entry%>" +"&MasterTagID=" + m_lngTagId + "&Action=Save&Mode=<%=m_strParamMode%>&ExpensesEntryID=<%=m_lngExpensesEntryID%>&FinanceApprover=<%=m_strFinanceApprover%>&AdminVerifier=<%=m_strAdminVerifier%>";			
			objform.submit();
		}
		
		
		function EnableControls()
		{
			GetObjectReference('frmEWF_ExpenseEntry','cboProject').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtDate').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','cboCostGroup').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','cboCostHead').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtAmount').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','cboPaymentMode').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtDescription').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtCurrencyId').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtCountryId').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtFPCenterID').disabled = false;
			GetObjectReference('frmEWF_ExpenseEntry','txtDescription').disabled = false;
			// Added By PradeepD to resolve Issue 21332 on 27-Oct-2005: Enable IsBillable checkbox 
			GetObjectReference('frmEWF_ExpenseEntry','chkIsBillable').disabled = false;
			// END: Added By PradeepD to resolve Issue 21332 on 27-Oct-2005: Enable IsBillable checkbox 
		}
		function callcalendar(formname,datefield)
		{
			var objdateObject=GetObjectReference(formname,datefield)
			var dtval;
			if(objdateObject.value =='')
				dtval='None';
			else
				dtval=objdateObject.value;
			calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval + '&FromWhere=EWF&Mode=' + objMode ,'calendar_window','top=0,left=0,width=348,height=260');calendar_window.focus();
		}		
			
		
		function validateControl()
		{
		var objcboProject = GetObjectReference('frmEWF_ExpenseEntry','cboProject');
		var objTxtDate = GetObjectReference('frmEWF_ExpenseEntry','txtDate');
		var objcboCostGroup = GetObjectReference('frmEWF_ExpenseEntry','cboCostGroup');
		var objcboCostHead = GetObjectReference('frmEWF_ExpenseEntry','cboCostHead'); 
		var objtxtAmount = GetObjectReference('frmEWF_ExpenseEntry','txtAmount');
		//commented by PurvaJ on 14 April 2006 issue 2886
		//var objtxtAdvance = GetObjectReference('frmEWF_ExpenseEntry','txtAdvance');
		//End comment PurvaJ
		var objtxtPaymentMode = GetObjectReference('frmEWF_ExpenseEntry','cboPaymentMode');
		var objtxtDescription = GetObjectReference('frmEWF_ExpenseEntry','txtDescription');
		var objtxtCurrencyId = GetObjectReference('frmEWF_ExpenseEntry','CboCurrency');
		var objtxtCountryId = GetObjectReference('frmEWF_ExpenseEntry','CboCountry');
		var objtxtFPCenterID = GetObjectReference('frmEWF_ExpenseEntry','CboFpCenterID');
		var objProjectStartDate = GetObjectReference('frmEWF_ExpenseEntry','txtProjectStartDate');		
		var objProjectEndDate = GetObjectReference('frmEWF_ExpenseEntry','txtProjectEndDate');				
		var objtxtFinYearStartDate = GetObjectReference('frmEWF_ExpenseEntry','txtFinYearStartDate');				
		var objtxtFinYearEndDate = GetObjectReference('frmEWF_ExpenseEntry','txtFinYearEndDate');				
		var TodaysDate  = GetObjectReference('frmEWF_ExpenseEntry','txtTodaysDate');				
		var Messgae;
		
		// Validate Date 
			if ( disallowBlank( objTxtDate, "<%=MyBase.GetResourceString("VALIDATE_EMPTY_DATE")%>",true ) == true )return false;
			//forward dated entry is not allowed 
			if (disallowDate1GreaterThanDate2(objTxtDate, TodaysDate,"<%=MyBase.GetResourceString("VALIDATE_FUTURE_ENTRY")%>",true)==true) return false;
			
			// Date Should be between project start date and end date and financial Year Start Date and Financia Year End Date 
			
			//Review Comments : Project StartDate EnddAte validaiton is required ? Removed the Project Start date and end Date Validation
			Messgae = replaceSubstring("<%=Mybase.getresourceString("VALDATE_FIN_YEAR_STARTDATE")%>" , "<ENTRYDATE>" ,objTxtDate.value+"");
			Message = replaceSubstring(Messgae , "<FINANCIALYEARSTARTDATE>" ,objtxtFinYearStartDate.value+"");
			if (disallowDate1LessThanDate2(objTxtDate,objtxtFinYearStartDate,Message)==true) return false;
			
			Messgae = replaceSubstring("<%=Mybase.getresourceString("VALDATE_FIN_YEAR_ENDDATE")%>" , "<ENTRYDATE>" ,objTxtDate.value+"");
			Message = replaceSubstring(Messgae , "<FINANCIALYEARENDDATE>" ,objtxtFinYearEndDate.value+"");
			if (disallowDate1LessThanDate2(objtxtFinYearEndDate,objTxtDate,Message)==true) return false;
			
		// Validate Project 
			if( disallowBlank(objcboProject ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_PROJECT")%>",true ) == true )return false;
					
		// Validate Cost Head 
			if( disallowBlank(objcboCostHead ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_COSTHEAD")%>" ,true) == true )return false;
		
		// Validate Amount 
			if( disallowBlank(objtxtAmount ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_AMOUNT")%>" ,true) == true )return false;
			
			if( disallowNonNumeric(objtxtAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return false;
		
			if( disallowNegativeNumeric(objtxtAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return false;
		
			if (objtxtAmount.value  == 0)
			{
				alert("<%=MyBase.getresourceString("VALIDATE_POSITIVE_AMOUNT")%>");
				return false;
			}	
		// Validate Advance Amount 
		//Commented By PurvaJ on 14 April 2006 issue 2886
		//	if (objtxtAdvance.value!="")
			//{
				//if (disallowNonNumeric(objtxtAdvance ,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_ADVANCE")%>" ,true) == true )return false;
				
				//if( disallowNegativeNumeric(objtxtAdvance,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_ADVANCE")%>",true) ==true) return false;
				
			//}
		//end comment PurvaJ
		
		 // Validate Currency 
			if( disallowBlank(objtxtCurrencyId ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_CURRENCY")%>" ,true) == true)return false;	
	
		//Modified by HarshK on 14 Apr 2006 issueID 3346
		// Validate Description 
			if( disallowBlank(objtxtDescription ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_DESCRIPTION")%>" ,true) == true )return false;	
			
			if (disallowMaxlengthViolation(objtxtDescription,2000,"<%=MyBase.GetResourceString("VALIDATE_MAX_DESCRIPTION")%>" ,true) == true )return false;	
			
		// Validate Country 
			if( disallowBlank(objtxtCountryId ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_COUNTRY")%>" ,true) == true ){return false};	
			
	   
			// Validate FPCENTER
			if( disallowBlank(objtxtFPCenterID ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_FPCENER")%>" ,true) == true )return false;	
				
		// Valdate Payment Mode 
			if( disallowBlank(objtxtPaymentMode ,"<%=MyBase.GetResourceString("VALIDATE_PAYEMENT_MODE")%>" ,true) == true )return false;	

				
		//END Modified by HarshK on 14 Apr 2006 issueID 3346

		}
		
		function IsBillable_OnClick()
		{
			var objchkIsBillable = GetObjectReference('frmEWF_ExpenseEntry','chkIsBillable');
			if (objchkIsBillable.checked)
					objchkIsBillable.value=1;
			else 
					objchkIsBillable.value=0 ;
		}
		
		
					</Script>				
	</body>
</HTML>
