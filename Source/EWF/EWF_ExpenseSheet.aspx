<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_ExpenseSheet.aspx.vb" Inherits="PbNIT.EWF_ExpenseSheet" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag("Print Expense Sheet")%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
   

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

        //document.body.style.height =  window.innerHeight-3;
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
        //document.body.style.height =  window.innerHeight-3;
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

	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
	<form name="frmEWF_ExpenseSheet" id="frmEWF_ExpenseSheet" method="post" action="EWF_ExpenseSheet.aspx"
			runat="server" oncontextmenu = "return false">
			<input type="hidden" name="txtCommand" id="txtCommand">
			<%PageInit()%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmEWF_ExpenseSheet');
		var objdivlist=GetObjectReference('frmEWF_ExpenseSheet','PageDiv');
		//var objdivlist=GetObjectReference('frmEWF_ExpenseSheet','DivMain');
		// Code added by SwapnilR on 17th Oct 2006
		// Addition by PrashantSJ on 07 July 2006
		// PURPOSE: To navigate to the selected RFI in the list.	
		var objcboExpensSheetID=GetObjectReference('frmRFI_RFI','cboExpenseSheetIDs');
		var blnReject=false;
		//End of addition by PrashantSJ on 07 July 2006
		// End of code addition by SwapnilR on 17th Oct 2006
		var objActor = "<%=m_lngActor%>";
		var objexpensesheetID = "<%=m_strExpenseSheetID%>";
		var blnFinanceApproverNotSet = '<%=m_blnFinanceApproverNotSet%>';
		var Status="<%=m_strExpenseSheetStatus%>";
		var Action="<%=m_lngAction%>";
		var m_lngTagId="<%=m_lngTagId%>";
		
		 <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		

		    var brw=isIE();
		function window_onload()
		{
		    //document.body.style.height =  window.innerHeight-3;
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    
                //COMMENTED AND ADDED BY NILESH G 0N 8/12/2015 FOR ISSUE ID 2701
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    if(brw=="IE"){
			        intDivHeight=window.innerHeight-229;
			    }
			   else if(brw=="CR")
			        {
			       intDivHeight=window.innerHeight-229;
			        }
			   else if(brw=="FF")
			            {
			       intDivHeight=window.innerHeight-229;
			            }
			    else
			       intDivHeight=window.innerHeight -229;
			    
			    
			    //END OF COMMENTED AND ADDED BY NILESH G 0N 8/12/2015 FOR ISSUE ID 2701
			   
			    if (intDivHeight < 100)	intDivHeight = 100;
			   // objdivlist.style.height = intDivHeight-50 +'px';
			    objdivlist.style.height = intDivHeight  +'px';// Added By Shamkant  S on 15 Dec 2015

			  

			//Added by PurvaJ on 18 April 2006 for whiziblesem 6 issue ID 2318 for expenses workflow 
			if(GetObjectReference('frmEWF_ExpenseSheet','txtTitle'))
			if (GetObjectReference('frmEWF_ExpenseSheet','txtTitle').disabled==false)
				GetObjectReference('frmEWF_ExpenseSheet','txtTitle').focus()
			//End Addtion PurvaJ
			}			
		// added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
			var showmsg;
		
			showmsg = "<%=m_intShowMessage%>";
			if (showmsg == "1" )
			{
				alert("There are no items to show in this view!");
				window.close();
				return;
			}
			/* else
			{
			
			var intDivHeight ;
			var intDivHeightRisk;

			//	filename="<%=m_strFileName%>//";		
			//	if (trimString(filename).length > 0 )
			//	{
			//	window.parent.close();
			//	window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report","");
			//	}
		//	} */
// end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //COMMENTED AND ADDED BY NILESH G 0N 8/12/2015 FOR ISSUE ID 2701
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    if(brw=="IE"){
			        intDivHeight=window.innerHeight-229;
			    }
			    else if(brw=="CR")
			    {
			        intDivHeight=window.innerHeight-229;
			    }
			    else if(brw=="FF")
			    {
			        intDivHeight=window.innerHeight-229;
			    }
			    else
			        intDivHeight=window.innerHeight -229;
			    
			    //END OF COMMENTED AND ADDED BY NILESH G 0N 8/12/2015 FOR ISSUE ID 2701
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
				
	
				
		function Page_Onclick(pagingChar)
		{
			frmEWF_ExpenseSheet.txtPaging.value = pagingChar ;
			document.forms[0].submit();			    // modified by puneet m on 23-12-2015
		}
		
		
		function Save_Onclick()
		{
		if (validateControl()==false)return;
		
			frmEWF_ExpenseSheet.txtCommand.value="0";
			//Added By Nikhil A on 15 Nov 2013 for PMLifeLine Issue Fixing
			var strSaveAsDraftLocation=window.location.href;
			frmEWF_ExpenseSheet.action=strSaveAsDraftLocation;
			//End Added By Nikhil A
			frmEWF_ExpenseSheet.submit();
		}
		
		function SaveAndSendForApproval()
		{
		
			frmEWF_ExpenseSheet.txtCommand.value="1";
			if (validateControl()==false)return;

			//frmEWF_ExpenseSheet.action="MyExpenseSheet_commonList.aspx?FromWhere=DT&MasterTagId=3593"
			//alert(frmEWF_ExpenseSheet.action);
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine issue fixing
			var strSaveAndSendForApprovalLocation=window.location.href; 
			frmEWF_ExpenseSheet.action=strSaveAndSendForApprovalLocation;
			//End Added by Nikhil A
			frmEWF_ExpenseSheet.submit();
		}
		
		function Add_ExpenseEntry ()
		{ var expenseSheetID = '<%=m_strExpenseSheetID%>' ;
		if (expenseSheetID == "") expenseSheetID= 1;
		// added by harshada d for Whiziblesem 6 for expenses on 4 April 2006
			//window.open("../EWF/SelectExpenseEntry_commonlist.aspx?FromWhere=SM&MasterTagID=3594&ExpenseSheetID=" + expenseSheetID ,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=400");
			window.open("../EWF/SelectExpenseEntry_Commonlist.aspx?FromWhere=SM&MasterTagID=3594&ExpenseSheetID=" + expenseSheetID ,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=400");
			// end of addition by harshada d for Whiziblesem 6 for expenses on 4 April 2006
		}	
		

		function Approve_Onclick()
		{
		//Modified By HarshK on 14 Apr 2006 IssueId 3350
	/*	this code is commented by harshada d for flashing alert expense entries are not set for fin approvers
		if ('<%=m_blnFinanceApproverNotSet%>'=="True")
		{
		alert('Finance Approver is not Set for some entries.');
		return; 
		}
		else 
		{
		end of commentation by harshada d for wrong flashing alert expense entries are not set for fin approvers
		*/
		
				frmEWF_ExpenseSheet.txtCommand.value="2";
				if (validateControl()==false) return; 	
				//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 			
				document.forms[0].submit();	
				
	//	}
		//End Modified By HarshK on 14 Apr 2006 IssueId 3350	
		}
		
		
		function Reject_Onclick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="3";
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 
			document.forms[0].submit();	
			
		}
		
		function Escalate_Onclick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="4";
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 
			document.forms[0].submit();	
		}
		
		function Disown_Onclick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="5";
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 
			document.forms[0].submit();	
		}
		function FinacneApprove_Onclick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="6";
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 
			document.forms[0].submit();	
		}
		
		function FinacneReject_Onclick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="7";
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PmLifeLine Issue fixing
				var strApproveLocation= window.location.href;
				frmEWF_ExpenseSheet.action=strApproveLocation;
				//End Added By Nikhil A 
			document.forms[0].submit();	
		}
		
		function SaveandResubmit()
		{
			
			
			frmEWF_ExpenseSheet.txtCommand.value="8";
			
			if (validateControl()==false) return; 
			//Added By Nikhil A on 15 Nov 2013 for PMLifeLine Issue Fixing
			var strResubmitLocation=window.location.href;
			frmEWF_ExpenseSheet.action=strResubmitLocation;
			//End Added By Nikhil A
			
			document.forms[0].submit();	
		
		}
		
	
			function Back_OnClick(Actor)	
		{
			var MasterTagID ; 
			 
			 
			if (Actor=="0")	MasterTagID	= 3593 ;
			if (Actor=="1") MasterTagID	= 3595 ;
			if (Actor=="2") MasterTagID	= 3596 ;
			if (Actor=="3") MasterTagID	= 3597 ;
			 
			if (MasterTagID==3593)
			{
				window.location.href="../EWF/MyExpenseSheet_commonList.aspx?FromWhere=DT&MasterTagId="+ MasterTagID;
			
			}
			if (MasterTagID==3595)
			{
				window.location.href="../EWF/ExpenseSheetApproval_CommonList.aspx?FromWhere=DT&MasterTagId="+ MasterTagID;
			
			}
			if (MasterTagID==3596)
			{
				window.location.href="../EWF/EscalatedExpenseSheets_CommonList.aspx?FromWhere=DT&MasterTagId="+ MasterTagID;
			
			}
			if (MasterTagID==3597)
			{
				window.location.href="../EWF/FinanceApproval_CommonList.aspx?FromWhere=DT&MasterTagId="+ MasterTagID;
			
			}
			
		}
		
		function Edit_OnClick(ExpenseEntryID,EntryDate,strPkToken)
		{ 
		// If the Actor is Finance Approver then he can Change the Finance Processing Center of the Entry
		//'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
		var m_lngTagId = <%=m_lngTagId%>
		 
			if (objActor == "3") 
			{
				window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&State=VIEW&FinanceApprover=1&MasterTagID=" + m_lngTagId + "&txtDate="+ EntryDate + "&PkToken=" +strPkToken +"&ExpensesEntryID=" + ExpenseEntryID,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");
			}
			else
			{
				//Abhijit 17-Nov-05 Added condition to check and set AdminVerifier for resource
				if (objActor == "1")
					window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&State=VIEW&AdminVerifier=1&MasterTagID=" + m_lngTagId + "&FinanceApprover=&txtDate="+ EntryDate + "&PkToken=" +strPkToken + "&ExpensesEntryID=" + ExpenseEntryID,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");				
				else
					window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&State=VIEW&FinanceApprover=&&MasterTagID=" + m_lngTagId + "&txtDate="+ EntryDate + "&PkToken=" +strPkToken + "&ExpensesEntryID=" + ExpenseEntryID,"_new","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");				
			}
		}
		
		function ShowDiscussions_OnClick(ExpenseEntryID)
		{
		}
		
		function FinanceVerified_Onclick()
		{
			var objChkFinanceVerified = GetObjectReference('frmEWF_ExpenseSheet','ChkFinanceVerified');
			if (objChkFinanceVerified !=null) 
			{	
			objChkFinanceVerified.checked=true;	
			frmEWF_ExpenseSheet.txtCommand.value="10";
			document.forms[0].submit();	
			}
		}
		
		function AdminVerified_Onclick()
		{
			var objChkAdminVerified = GetObjectReference('frmEWF_ExpenseSheet','ChkAdminVerified');
			if (objChkAdminVerified !=null) 
			{	
				objChkAdminVerified.checked=true;	
				frmEWF_ExpenseSheet.txtCommand.value="9";
				document.forms[0].submit();	    // modified by Puneet M ON 23-12-2015
			}	
		}	

		function validateControl()
		{	
			var objtxtTitle = GetObjectReference('frmEWF_ExpenseSheet','txtTitle');
			var objDescription = GetObjectReference('frmEWF_ExpenseSheet','txtDescription');
			//var objchkDelete = GetObjectReference('frmEWF_ExpenseSheet','chkDelete',1);
			var objchkDelete = GetObjectReference('frmEWF_ExpenseSheet','chkSelect',1);
			var atleastoneSelected = 0;
			// Validate Title 
				if( disallowBlank(objtxtTitle ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_TITLE")%>" ,true) == true ){return false};	
				
			// Validate Description 
			
				if( disallowBlank(objDescription ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_DESCRIPTION")%>" ,true) == true ){return false};	
				
				// Validate at least one entry is selected 
			
				for(i=0;i<objchkDelete.length;i++)
				{
					if (objchkDelete[i].disabled==false && objchkDelete[i].checked==true)	
					{	
						
						atleastoneSelected=1 ;
						//Modified By VarunA on 22-Sep-2008 IssueID-22504
						//Purpose : It wasn't working in firefox and to have object by name
						//var objtxtComments = GetObjectReference('frmEWF_ExpenseSheet','txtComments'+ objchkDelete[i].value);
						var objtxtComments = GetObjectReference('frmEWF_ExpenseSheet','txtComments'+ objchkDelete[i].value ,true);
						//End By VarunA on 22-Sep-2008 IssueID-22504
						var objtxtDisowned = GetObjectReference('frmEWF_ExpenseSheet','txtDisowned'+ objchkDelete[i].value );
						
						if ((objexpensesheetID=='') || ((objexpensesheetID!='') && (Action=="0")) || ((Status=="DRAFT")) && (Action=="-1"))
						//added by harshada d for whiziblesem 6 issue id 318 expenses workflow
						{
							if( disallowBlank(objtxtComments ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_COMMENTS")%>" ,true) == true )
							{
							return false;	
							}
						}
						//end of addition by harshada d for whiziblesem 6 issue id 318 expenses workflow
						if (objActor != "0" )
						{
							// Disowned Entry Can not Be Escalated again 
							if (frmEWF_ExpenseSheet.txtCommand.value=="4" && objtxtDisowned.value == 1)
							{
								alert("<%=MyBase.GetResourceString("VALIDATE_DISOWNED")%>");
								return false;
							}
							if (objtxtComments != null)
							{	
								// Commnet Is not Mandatory for Approval 
									if(frmEWF_ExpenseSheet.txtCommand.value=="2" && objtxtComments.value == "" )
									{
										if (confirm("Do you want to save changes without entering comments?")==false)	
										{
											return false;
										}
										else
										{
											return true;
										}

									}
									
									if( disallowBlank(objtxtComments ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_COMMENTS")%>" ,true) == true )
									{
										return false;	
									}

							}
						}
					}

			}
			
				if (atleastoneSelected == 0 )
				{
					alert("<%=MyBase.getResourceString("VALDATE_EXPENSE_ENTRY")%>");
					return false;
				}
			return true;
		}
		
		function ShowDicussionTherad(ExpenseEntryID, showdisabled )
		{
		 //Modified By ShraddhaM on 3/10/2006 for SP7 IssueId : 6564
			var txtComments="s"+ExpenseEntryID;		 
			var objtxtCommentsValue = GetObjectReference('frmEWF_ExpenseSheet',txtComments).value;
			window.open("../EWF/EWF_Discussion.aspx?txtComments=txtComments"+ExpenseEntryID+"&Comments=" + objtxtCommentsValue +"&ExpensesEntryID=" + ExpenseEntryID + "&ShowDisabled=" + showdisabled ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=730,height=500" );
		}
		//added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 28 Jun 2006
		//Modified by PrajaktaR on 26 June 2006 for Bristlecone
		function ViewReport_OnClick(format)
		{
			var strQuery;
			var expenseSheetID = '<%=m_strExpenseSheetID%>';
			var strPkToken="<%=m_strPKToken_Expense_SheetOld%>";
			objform.target="_blank";
			//added by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 13 July 2006
			//	objform.action  = "EWF_ExpenseSheet.aspx?MasterTagID=<%=m_lngTagId%>&ExpenseSheetID=" + expenseSheetID + "&Action=ShowReport&format=" + format ;
				objform.action  = "EWF_ExpenseSheet.aspx?Mode=EDIT&MasterTagID=<%=m_lngTagId%>" + "&PkToken=" + strPkToken + "&ExpenseSheetID=" + expenseSheetID + "&Action=ShowReport&format=" + format + "&Actor="+objActor;
				//end of addition by harshada d 
			objform.submit();
			}
		function Show_Report(strReportID)
		{
			var expenseSheetID = '<%=m_strExpenseSheetID%>' 
			var strPkToken="<%=m_strPKToken_Expense_SheetOld%>"
			var m_lngTagId="<%=m_lngTagId%>"
			//modified by harshada d for Whiziblesem SP7 for IssueID 4582 for Expenses Weekly View Enhancements on 13 July 2006
			window.open("EWF_ExpenseSheet.aspx?Mode=EDIT&Action=ShowReport&MasterTagID=" + m_lngTagId + "&PkToken=" + strPkToken + "&ExpenseSheetID=" + expenseSheetID + "&Actor=" + objActor + "&format= ","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 450)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=450,height=220")
			//window.open("EWF_ExpenseSheet.aspx?Action=ShowReport&ExpenseSheetID=" + expenseSheetID + "&format= ","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=400,height=150")
			//window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1974&UniqueID=" + expenseSheetID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=550,height=350")		
		}
		//END Of Modification by PrajaktaR on 26 June 2006 for Bristlecone
		// end of addition by harshada d for Whiziblesem SP7 for IssueID 4557 for Expenses Weekly View Enhancements 28 Jun 2006
				
		// Code added by SwapnilR on 17th Oct 2006
		// Purspose : To navigate to the previous and next Expense Sheet ID
		//            (PrashantSJ's code integration along with security patch)
	  	function Previous_OnClick()		
		{
			frmEWF_ExpenseSheet.txtCommand.value="0";
			// PURPOSE: To navigate to the previous ExpenseSheet ID  in the list.	
			if((objcboExpensSheetID.selectedIndex - 1) < 0)
				alert("You are currently viewing the first Expense Sheet in the list");
			else
				{
					var	strTokenData = getTokenData(objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex - 1].value)			
					var strMasterTagID = getMasterTagID()
					//objform.action ="EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID=" + objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex - 1].value;
					//objform.submit();
					window.location.href = "EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID=" + objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex - 1].value + "&MasterTagID=" + strMasterTagID + "&PkToken=" + strTokenData; 
				}
		}
					
		function Next_OnClick()
		{
			frmEWF_ExpenseSheet.txtCommand.value="0";
			// PURPOSE: To navigate to the next ExpenseSheet ID  in the list.	
			if((objcboExpensSheetID.selectedIndex + 1) >= objcboExpensSheetID.options.length)
				alert("You are currently viewing the last Expense Sheet in the list");
			else				
			{
				//objform.action ="EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID=" + objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex + 1].value;
				//objform.submit();
				var	strTokenData = getTokenData(objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex + 1].value)			
				var strMasterTagID = getMasterTagID()
				window.location.href = "EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID=" + objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex + 1].value + "&MasterTagID=" + strMasterTagID + "&PkToken=" + strTokenData; 
			}
		}
					
		function cboExpenseSheetID_OnChange()
		{	
			var	strTokenData = getTokenData(objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex].value)						
			var strMasterTagID = getMasterTagID()
			frmEWF_ExpenseSheet.txtCommand.value="0";
			// PURPOSE: To navigate to the selected ExpenseSheet ID in the list.	
			//objform.action ="EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID="+ objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex].value; 
			//objform.submit();
			window.location.href = "EWF_ExpenseSheet.aspx?Mode=EDIT&Actor="+objActor+"&ExpenseSheetID="+ objcboExpensSheetID.options[objcboExpensSheetID.selectedIndex].value + "&MasterTagID=" + strMasterTagID + "&PkToken=" + strTokenData; 
		}		
		
		function getTokenData(UniqueID)
		{
			var strData = '<%=Session("TokenForExpences")%>'
			var arrTst = strData.split("#")
			

			for(var i=0; i<arrTst.length-1; i++)
			{
				var arrTst1 
				arrTst1 = arrTst[i].split("+")
					if(arrTst1[0] == UniqueID)
						return arrTst1[1]
			}		
		}
		
		function getMasterTagID()
		{
			if (objActor=="0") MasterTagID	= 3593 ;
			if (objActor=="1") MasterTagID	= 3595 ;
			if (objActor=="2") MasterTagID	= 3596 ;
			if (objActor=="3") MasterTagID	= 3597 ;
			
			return MasterTagID;
		}
		// End of code addition by SwapnilR on 17th Oct 2006			
		</Script>
	</body>
</HTML>
