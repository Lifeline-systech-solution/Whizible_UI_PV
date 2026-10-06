<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_RowwiseApprovers.aspx.vb" Inherits="PbNIT.EWF_RowwiseApprovers" %>
<!DOCTYPE HTML>
<HTML>
  <HEAD>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
	
		<script language='javascript' src='../General/CommonFunctions.js'></script>
	    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 

   

<!--Including files & Libraries by Miiint Solutions-->



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
<BODY class=clsBody onresize=window_onresize() onload=window_onload()>
		<%If Request.QueryString("Mode") <> "SetDefaultApprover" Then %>
			<div id='Headtbl'><TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width="100%">
			<TR class=clsTRMenu valign=middle>
			<TD noWrap>
			&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Timesheet Approvers' href='javascript:ItemTab_OnClick("Timesheet")' Timesheet?)?>Timesheet Approvers</a>
			&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Expense Approvers' href='javascript:ItemTab_OnClick("Expense")' Expense?)?>Expense Approvers</a></TD> </TR>
			</TABLE>
			</div>
			<script>
			
			function ItemTab_OnClick(strWhich)
			{
				if (strWhich=='Timesheet')
				window.location.href = '../RT/RT_RowwiseApprovers.aspx';	
			}
			</script>
		<%End If%>
		<form id="frmRowwiseApprovers" name="frmRowwiseApprovers" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		    var objDivMain = GetObjectReference('frmRowwiseApprovers', 'DivMain');
		    var objDivList = GetObjectReference('frmRowwiseApprovers', 'DivList');

			var objForm;
			objForm = GetFormReference('frmRowwiseApprovers');
			var blnApproverChanged
			blnApproverChanged=false;
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function cboApprover_onChange(intindex)
			{
				blnApproverChanged=true;
				//alert(blnApproverChanged);
			}
			var brw = isIE();
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
                //added by Nilesh g on 15/12/2015 
				if (brw == "IE") {
				    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 39;
				}
				else
				    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
				if (intDivHeight < 100)
				    intDivHeight = 100;
				
				objDivMain.style.height = intDivHeight + 'px';
				if (objDivList != null) {
				    objDivList.style.height = intDivHeight - 10 + 'px';
				}
			    //endded by Nilesh g on 15/12/2015 
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
			    //added by Nilesh g on 15/12/2015 
				if (brw == "IE") {
				    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 39;
				}
				else
				    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
				if (intDivHeight < 100)
				    intDivHeight = 100;
				
				objDivMain.style.height = intDivHeight + 'px';
				if (objDivList != null) {
				    objDivList.style.height = intDivHeight - 10 + 'px';
				}
			    //endded by Nilesh g on 15/12/2015 
			}
		
			function Save_OnClick()
			{
										
					// Added By NageshM on date 24th june 2005				 
					/// purpose : to disallow the same name of employee and approver.
					
					
			/*		var count =GetObjectReference('frmRowwiseApprovers','EmployeeCount');
					for(i=2;i<=count.value;i++)
				{
					
					var Approver =GetObjectReference('frmRowwiseApprovers','cboApprover'+i);
					var Employee =GetObjectReference('frmRowwiseApprovers','EmployeeID'+i);
					if (Employee.value==Approver.value)
					{
					alert("Employee Name and Approver Name should not be same");
					Approver.focus();
					return;				
					}
									
						
				}      		*/
					 					 
					//end of addition By NageshM
								
					//alert('after for loop');
					var intLength;
					var blnFound;
					var objApprover;
					blnFound ='true';
					var IsCheckBoxCheced;
					IsCheckBoxCheced = false
					var blnApproverSet;
					blnApproverSet = getApproverSet(); 
					//alert(blnApproverSet);	
						
					var objNewApprover = GetObjectReference('frmRowwiseApprovers','txtNewApprover');
					if (objNewApprover.value == "")
					{
						alert('Select the New Approver');
						return;
					}
					
					var objCheckbox = GetObjectReference('frmRowwiseApprovers','chkEmployeeID',true);
					var intItems;
					var intCtr;
					
					if (objCheckbox != null)
					{
						intItems = objCheckbox.length;
						if(intItems > 1) 
						{
							for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
							{
								if (objCheckbox[intCtr].disabled == false)
								{
									if (objCheckbox[intCtr].checked == true)
									{
										IsCheckBoxCheced = true ;
										break;
									}
								}						
							}
						}
						else if(intItems == 1)
						{
						if (objCheckbox[0].disabled == false) 
						{
							if (objCheckbox[0].checked == true)
							 	IsCheckBoxCheced = true ;						
						}
					}	
					}
			
				
				
					if (IsCheckBoxCheced == false)
					{
						alert('Select atleast one employee to set approver');
						return;
					}	
					
					 if(blnApproverChanged==true && blnApproverSet==1)
					{
						if(!window.confirm("This operation will redirect all pending approvals to newly set approver.Do you want to continue ?")) 
						{
							return;
						}	
						
					}
				
					 // Added By NageshM on date 24th june 2005				 
					/// purpose : to disallow the same name of employee and approver.
					
				/* 	var count =GetObjectReference('frmRowwiseApprovers','EmployeeCount');
					
					for(i=2;i<=count.value;i++)
				{
					
					var Approver =GetObjectReference('frmRowwiseApprovers','cboApprover'+i);
					var Employee =GetObjectReference('frmRowwiseApprovers','EmployeeID'+i);
					if (Employee.value==Approver.value)
					{
					alert("Employee Name and Approver Name should not be same");
					Approver.focus();
					return;				
					}
									
				}     */ 		
					 					 
					 // end of addition By NageshM
					if(blnFound=='true') 
					{	
						//Commented and Modified by JyotiG
						//Start_JG_11107_02-Apr-2007
						objForm.action = "EWF_RowwiseApprovers.aspx?Mode=Save&Alphabet=<%=Server.URLEncode(m_strAlphabet)%>"  
						//End_JG_11107_02-Apr-2007
						objForm.submit();
				      		return;	
					}	
				}


			function SetDefaultApprover_OnClick()
			{
				//Modified By VarunA on 3-July-2007 Whizible 7.0 Development & Release
				//window.open("EWF_RowwiseApprovers.aspx?Mode=SetDefaultApprover","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=400,height=250")
				window.open("EWF_RowwiseApprovers.aspx?Mode=SetDefaultApprover","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=500,height=180")
				//End By VarunA on 3-July-2007
			}

			function SaveDefaultApprover_OnClick()
			{/*
					objForm.action = "EWF_RowwiseApprovers.aspx?Mode=SaveDefaultApprover"  
					objForm.submit();
					window.close();
			*/		
					var objParent = GetParentFormReference('frmRowwiseApprovers');
				    objForm.action = "EWF_RowwiseApprovers.aspx?Mode=SaveDefaultApprover"  
					objForm.submit();
					objParent.submit();
					window.close();
			}			 
			 
			function ShowHistory_OnClick()
			{
				window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagShowHistory%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
		
			}
			
			function Paging_OnClick(str)
			{
				objForm.action = "EWF_RowwiseApprovers.aspx?Alphabet=" + str;
				objForm.submit();	
			}
			function SelectAll_OnClick()
			{
				SelectAllCheckboxs('frmRowwiseApprovers','chkEmployeeID'); 
			}	
			
			function ClearAll_Click()
			{
				ClearAll_OnClick('frmRowwiseApprovers','chkEmployeeID'); 
			}
					
			function Filter_OnChange()
			{
				objForm.action = "EWF_RowwiseApprovers.aspx"
				objForm.submit();
			}
			function SelectNewApprover()
			{
				window.open ("../RT/RT_SelectNewApprover.aspx", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300");
			}			
			

		</script>

	</BODY>
</HTML>
