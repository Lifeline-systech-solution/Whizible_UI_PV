<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_Bifurcation.aspx.vb" Inherits="PbNIT.EWF_Bifurcation" enableViewState="True" enableViewStateMac="True"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
   
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

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
					<form id="frmEWF_Bifurcation" method="post" runat="server">
		
									<%PageInit%>
					</form>
		
					<SCRIPT language="javascript">
		var objform=GetFormReference('frmEWF_Bifurcation');
		var objdivlist=GetObjectReference('frmEWF_Bifurcation','PageDiv');
		var strFilterType = "<%=m_strFilterType%>";
		var strMode = "<%=m_lngMode%>";
		var strFilterValue = "<%=m_strFilterValue%>";
		var m_lngTagId="<%=m_lngTagId%>";
		var m_strPKToken_Bifurcation="<%=m_strPKToken_Bifurcation%>"
		
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
			   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;//added By Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;//added By Shamkant S on 15 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function ShowDetails_OnClick()
		{
			if (ValidateControls(1) ==false) return; 
			//Modified by PrashantD on 8 March 2007 for IssueID 11111
			//Modification : Changed TagID from 3093 to 3598
			objform.action = "../EWF/EWF_Bifurcation.aspx?MODE=1&MasterTagId=3598&FILTERTYPE=" + strFilterType ;
			objform.submit();	
		}
		
		function ShowFilter(Type)
		{
			if (Type == 1)
			{
			objform.action ="../EWF/EWF_Bifurcation.aspx?MODE=0&PkToken=" + m_strPKToken_Bifurcation + "&MasterTagId=3093&FILTERTYPE=C" ;
			}
			else
			{
			objform.action ="../EWF/EWF_Bifurcation.aspx?MODE=0&PkToken=" + m_strPKToken_Bifurcation + "&MasterTagId=3093&FILTERTYPE=P"
			}
			objform.submit();
		}
		
		function Bifurcate_OnClick()
		{
		//m_lngExpensesEntryID
		//objform.action = "../EWF/EWF_Bifurcation.aspx?ACTION=BIFURCATE&PkToken=" + m_strPKToken_Bifurcation + "&MasterTagID=" + m_lngTagId + "&MODE=" + strMode + "&FILTERTYPE=" + strFilterType + "&FILTERVALUE=" + strFilterValue + "&ExpensesEntryID=<%=m_StrExpenseEntryList%>";
		
			if (ValidateControls(2)== false) return ;
			if (strMode == 2)
				objform.action = "../EWF/EWF_Bifurcation.aspx?ACTION=BIFURCATE&PkToken=" + m_strPKToken_Bifurcation + "&MasterTagID=" + m_lngTagId + "&MODE=" + strMode + "&FILTERTYPE=" + strFilterType + "&FILTERVALUE=" + strFilterValue + "&ExpensesEntryID=<%=m_StrExpenseEntryList%>";
			else
				objform.action = "../EWF/EWF_Bifurcation.aspx?ACTION=BIFURCATE&PkToken=" + m_strPKToken_Bifurcation + "&MasterTagID=" + m_lngTagId + "&MODE=" + strMode + "&FILTERTYPE=" + strFilterType + "&FILTERVALUE=" + strFilterValue ;

			objform.submit();
		}
		
		function ValidateControls(ModeType)
		{
			// if ModeType = 1 then validate if Dates are Present then From Date Should be Less than of equal to to date
			if (ModeType == 1)
			{
				var objtxtFromDate = GetObjectReference('frmEWF_Bifurcation','txtFromDate');
				var objtxtToDate = GetObjectReference('frmEWF_Bifurcation','txtToDate');
				
				if (objtxtFromDate.value !="" && objtxtToDate.value != "")
				{
					if (disallowDate1GreaterThanDate2(objtxtFromDate,objtxtToDate,"From Date [" + objtxtFromDate.value + "] should not be Greater than To Date [" + objtxtToDate.value + "]!", true)== true) return false;
				}
			}
			// To Validate Bifurcation for The Selected Entries 
			if(ModeType ==2)
			{
				var objchkDelete = GetObjectReference('frmEWF_Bifurcation','chkDelete',1);
				var atleastoneSelected = 0;
				
				<% If m_lngMode<>2 %>
				// Validate at least one entry is selected 
				if (objchkDelete != null)
				{
			 		for(i=0;i<objchkDelete.length;i++)
					{	
						var ExpenseEntryId = objchkDelete[i].value;
				<%Else%>
						var ExpenseEntryId = <%=m_StrExpenseEntryList%>
				<% End If %>				
						var objBillable = GetObjectReference('frmEWF_Bifurcation','txtBillable'+ExpenseEntryId);
						var objNonBillable = GetObjectReference('frmEWF_Bifurcation','txtNonBillable'+ExpenseEntryId);
						var objAmount = GetObjectReference('frmEWF_Bifurcation','txtAmount'+ExpenseEntryId);
						var objtxtComments = GetObjectReference('frmEWF_Bifurcation','txtComments'+ExpenseEntryId);

						<% If m_lngMode<>2 %>
						if (objchkDelete[i].disabled==false && objchkDelete[i].checked==true)	
						{	
						<% End If %>
							atleastoneSelected=1 ;
							//Added by PrashantD on 8 March 2007 for IssueID 11090
							if (objtxtComments.value.length > 1000)
							{ 
								alert("Max length of comment is 1000 characters.");
								objtxtComments.focus();
								return false;	
							}
							//End of Addition by PrashantD
							
							/// Validate Billable Amount 
							if( disallowBlank(objBillable ,"<%=MyBase.GetResourceString("VALIDATE_POSTIVE_BILLABLE")%>" ,true) == true )return false;
							
							if( disallowNonNumeric(objBillable,"<%=MyBase.GetResourceString("VALIDATE_POSTIVE_BILLABLE")%>",true) ==true) return false;
						
							if( disallowNegativeNumeric(objBillable,"<%=MyBase.GetResourceString("VALIDATE_POSTIVE_BILLABLE")%>",true) ==true) return false;

							/// Validate Non Billable Amount 
							if( disallowBlank(objNonBillable ,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_NON_BILLABLE")%>" ,true) == true )return false;
							
							if( disallowNonNumeric(objNonBillable,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_NON_BILLABLE")%>",true) ==true) return false;
						
							if( disallowNegativeNumeric(objNonBillable,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_NON_BILLABLE")%>",true) ==true) return false;

							//validate sum of Billable Amount and non billable Amount Should be equal to Amount
							var fltBillable = parseFloat (objBillable.value) ;
							var fltNonBillable = parseFloat(objNonBillable.value) ;
							var fltAmount = parseFloat(objAmount.value) ;
							
							if (fltBillable + fltNonBillable != fltAmount)
							{
								alert("The Sum of Billable Amount and Non Billable Amount should be equal to Amount!");
								objBillable.focus();
								return false;
							}
							
							// Validate Comments 
							if (objtxtComments.length>1000)
							{
								alert("Maximum length of Comments is 1000 Characters");
						
							}
				   <% If m_lngMode<>2 %>	
						}
					
					} // End For 
					
					if (atleastoneSelected == 0 )
					{	
						alert("Please select at least one Entry!");
						return false;
					}	
				} // End of IF for objDelete is Not Null 
				else
				{
					alert("Please select at least one Entry!");
					return false;
				}
				<% End If %>	
			} // End of If For ModeType ==2)
			
			
		} // End of Function Validate

		function MakeBillable_onClick(ExpenseEntryId)	
		{
			var objBillable = GetObjectReference('frmEWF_Bifurcation','txtBillable'+ExpenseEntryId);
			var objNonBillable = GetObjectReference('frmEWF_Bifurcation','txtNonBillable'+ExpenseEntryId);
			var objAmount = GetObjectReference('frmEWF_Bifurcation','txtAmount'+ExpenseEntryId);
			
			objBillable.value = objAmount.value;			
			objNonBillable.value= "0.00";
		}
		
		function MakeNonBillable_onClick(ExpenseEntryId)	
		{
			var objBillable = GetObjectReference('frmEWF_Bifurcation','txtBillable'+ExpenseEntryId);
			var objNonBillable = GetObjectReference('frmEWF_Bifurcation','txtNonBillable'+ExpenseEntryId);
			var objAmount = GetObjectReference('frmEWF_Bifurcation','txtAmount'+ExpenseEntryId);
			
			objNonBillable.value = objAmount.value;			
			objBillable.value = "0.00";
		}

		function Edit_OnClick(ExpenseEntryID,EntryDate,strPkToken)
		{ 
			window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&MasterTagId=3598&PkToken=" + strPkToken + "&State=VIEW&FinanceApprover=&txtDate="+ EntryDate +"&ExpensesEntryID=" + ExpenseEntryID,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");				
		//window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&MasterTagId=3598&State=VIEW&FinanceApprover=&txtDate="+ EntryDate +"&ExpensesEntryID=" + ExpenseEntryID,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");				
		
		}		
		
		function ShowDicussionTherad(ExpenseEntryID,strPkToken)
		{
			window.open("../EWF/EWF_Discussion.aspx?Mode=VIEW&MasterTagId=3598&PkToken=" +strPkToken + "&txtComments=txtComments"+ExpenseEntryID+"&Comments=&ExpensesEntryID=" + ExpenseEntryID ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=300" );
		}

		function Back_OnClick()
		{
			window.location.href="../EWF/ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598";
			//window.open("../EWF/ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598","_self");
		}		

					</SCRIPT>
	
	</body>
</HTML>
