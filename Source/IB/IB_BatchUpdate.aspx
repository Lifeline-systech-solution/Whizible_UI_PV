<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_BatchUpdate.aspx.vb" Inherits="PbNIT.IB_BatchUpdate" ValidateRequest="False"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
  
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmBatchUpdate" method="post" runat="server">
			<%WritePage%>
		</form>
		<script language="javascript">

	var objForm, objdivlist, objFocus;
	
	//Addition done by SuchitraP on 30-May-2007 for IB Batch Update
	var objIsExecute=GetObjectReference('frmBatchUpdate','isExecute');
	//end of addition done by SuchitraP on 30-May-2007 for IB Batch Update
	
	objForm = GetFormReference('frmBatchUpdate');
	objFocus = GetObjectReference('frmBatchUpdate','cboQuery');
	setFocus(objFocus);
	
	//Addition done by SuchitraP on 31-MAY-2007 for IB Batch Update
	var objoffsetHeight=GetObjectReference('frmBatchUpdate','divCustomFields');
	//End of Addition done by SuchitraP on 31-MAY-2007 for IB Batch Update
	
	objdivlist = GetObjectReference('frmBatchUpdate','divList');
	
	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
	
	function window_onload()
	{
	
			
		var intDivHeight ;
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
		    
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';
		<%If m_strAction = ACTION_UPDATE_SUCCESSFUL Then%>
			alert("<%=MyBase.GetResourceString("UPDATE_SUCCESSFUL")%>");
		<%ElseIf m_strAction = ACTION_UPDATE_FAIL Then%>
			alert("<%=MyBase.GetResourceString("SELECT_THE_FIELDS")%>");
		<%End If%>
		//Added by PrashantD on 17 March 2007 for IssueID 11591
		<% If request.queryString("Action")=ACTION_UPDATE AND m_strAction = ACTION_UPDATE_SUCCESSFUL Then %>
		window.opener.location.href = window.opener.location.href ;
		<%End if %>
		//End of addition by PrashantD on 17 March 2007 
		
		//Addition done by SuchitraP on 31-MAY-2007 for IB Batch Update
				
				if(document.body.offsetHeight>=220)
				{
				   objoffsetHeight.style.overflow="auto";
				   height=200;
				}
	   //End of Addition done by SuchitraP on 31-MAY-2007 for IB Batch Update
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';		
	}
	
	function ClearAll_OnClick()
	{
	    //Addition done by SuchitraP on 25-JUN-2007 for IssueID 13506
	    var objQuery=GetObjectReference('frmBatchUpdate','cboQuery');
	    objQuery.value="";
	    //End of Addition done by SuchitraP on 25-JUN-2007 for IssueID 13506
		objForm.action = "IB_BatchUpdate.aspx?Action=<%=ACTION_CLEARALL%>";
		//Addition done by SuchitraP on 4-Jun-2007
		objIsExecute.value=0;
		//End of addition by SuchitraP on 4-Jun-2007
		objForm.submit();
	}
	
	function Update_OnClick()
	{
		var objQuery;
		
		objQuery = GetObjectReference('frmBatchUpdate','cboQuery');
		if (disallowBlank(objQuery, "<%=MyBase.GetResourceString("PLEASE_SELECT_QUERY")%>"))
			return;
			
		//Addition done by SuchitraP on 30-May-2007 for IB Batch Update
			if(objIsExecute.value==0)
			{
			   alert("Please execute query first..");
			   return;
			}
			
			if ('<%=m_intNumberOfRecordsOfQuery.ToString()%>'=='0')
			{
			   alert("Query is not selecting any record..");
			   return;
			}
		//end of addition done by SuchitraP on 30-May-2007 for IB Batch Update
		
		//Addition done by SuchitraP on 4-Jun-2007 for IssueID 13505  
		    if(isAnyFieldSelected()==false)
			{
			   alert("Please Select the fields to be Updated...");
			   return;
			}
			
		//End of Addition done by SuchitraP on 4-Jun-2007 for IssueID 13505
		
		//Addition done by SuchitraP on 25-MAY-2007 for IssueBase BatchUpdate
			if(!confirm("<%=m_intNumberOfRecordsOfQuery.ToString()%> records will be updated with selected fields.\n Do you want to continue?"))
			{
				return;	
			}
		//End of addition By SuchitraP on 25-MAY-2007 For IssueBase BatchUpdate
		
					
		//Modified by SavitaS on 25 Sept 2006 for Security Issue 6197	
		//objForm.action = "IB_BatchUpdate.aspx?Action=<%=ACTION_UPDATE%>";		
		objForm.action = "IB_BatchUpdate.aspx?Action=<%=ACTION_UPDATE%>&PKToken=<%=m_PKToken_BatchUpdate%>";		
	   //End of  Modified by SavitaS on 25 Sept 2006 for Security Issue 6197
		objForm.submit();
	}
	
	//Addition done by SuchitraP on 25-MAY-2007 for IssueBase BatchUpdate
	function QueryOnChange()
	{
	  objIsExecute.value=0;
	}
	//End of addition By SuchitraP on 25-MAY-2007 For IssueBase BatchUpdate
	
	function Execute_OnClick()
	{
	    //Addition done by SuchitraP on 4-JUN-2007 for issueID 13503
	    var objExec=GetObjectReference('frmBatchUpdate','cboQuery');
	    if (disallowBlank(objExec, "Please select the Query first"))
			return;
		//End of Addition done by SuchitraP on 4-JUN-2007 for issueID 13503
		
	    objForm.action="IB_BatchUpdate.aspx?Action=EXECUTE&PKToken=<%=m_PKToken_BatchUpdate%>";
	    //Addition done by SuchitraP on 25-MAY-2007 for IssueBase BatchUpdate
	    objIsExecute.value=1;
	    //End of addition By SuchitraP on 25-MAY-2007 For IssueBase BatchUpdate
	    objForm.submit();
	}
	
	function isAnyFieldSelected()
	{
	    //Addition done by SuchitraP on 4-Jun-2007 for IssueID 13505  
	     if(GetObjectReference('frmBatchUpdate','cboSubType'))
	        if((GetObjectReference('frmBatchUpdate','cboSubType').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboStatus'))
	        if((GetObjectReference('frmBatchUpdate','cboStatus').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboCodedBy'))
	        if((GetObjectReference('frmBatchUpdate','cboCodedBy').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboAssignTo'))
	        if((GetObjectReference('frmBatchUpdate','cboAssignTo').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboPriority'))
	        if((GetObjectReference('frmBatchUpdate','cboPriority').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboSeverity'))
	        if((GetObjectReference('frmBatchUpdate','cboSeverity').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboReportedInVersion'))
	        if((GetObjectReference('frmBatchUpdate','cboReportedInVersion').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboCorrectedInVersion'))
	        if((GetObjectReference('frmBatchUpdate','cboCorrectedInVersion').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboSourcePhase'))
	        if((GetObjectReference('frmBatchUpdate','cboSourcePhase').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboFoundInPhase'))
	        if((GetObjectReference('frmBatchUpdate','cboFoundInPhase').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboFixedInPhase'))
	        if((GetObjectReference('frmBatchUpdate','cboFixedInPhase').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboRootCause'))
	        if((GetObjectReference('frmBatchUpdate','cboRootCause').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboDeliverable'))
	        if((GetObjectReference('frmBatchUpdate','cboDeliverable').value)!="")
	            return true;
	     if(GetObjectReference('frmBatchUpdate','cboComplexity'))
	        if((GetObjectReference('frmBatchUpdate','cboComplexity').value)!="")
	            return true;
	    
	    //Added By VarunA on 7-Feb-2008 RequestID-11342
	    //Purpose : To validate for the custom fields
	    var i,j,k,l;
	    var objCustomFieldDate,objCustomFieldCombo,objCustomFieldText,objCustomFieldTextArea;
	    for(i=1;i<=5;i++)
	    {
			objCustomFieldDate = GetObjectReference('frmBatchUpdate','FFE29587WHIZ_CustomFieldDate'+i);
			if(objCustomFieldDate)
				if(objCustomFieldDate.value!="")
					return true;
		}
		for(j=1;j<=10;j++)
	    {
			objCustomFieldCombo = GetObjectReference('frmBatchUpdate','CustomFieldCombo'+j);
			if(objCustomFieldCombo)
				if(objCustomFieldCombo.value!="")
					return true;
		}
		for(k=1;k<=10;k++)
	    {
			objCustomFieldText = GetObjectReference('frmBatchUpdate','CustomFieldText'+k);
			if(objCustomFieldText)
				if(objCustomFieldText.value!="")
					return true;
		}
		for(l=1;l<=3;l++)
	    {
			objCustomFieldTextArea = GetObjectReference('frmBatchUpdate','CustomFieldTextArea'+l);
			if(objCustomFieldTextArea)
				if(objCustomFieldTextArea.value!="")
					return true;
		}
		//End By VarunA on 7-Feb-2008 RequestID-11342        
	            
	     return false;
	     //End of addition done by SuchitraP on 4-Jun-2007 for IssueID 13505  
	     
	}
	
		</script>
	</body>
</HTML>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
