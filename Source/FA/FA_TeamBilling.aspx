<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FA_TeamBilling.aspx.vb" Inherits="PbNIT.FA_TeamBilling"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
  
 <%--   Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade
  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>



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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmFA_TeamBilling" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmFA_TeamBilling');
		var objdivlist=GetObjectReference('frmFA_TeamBilling','PageDiv');
		var objExclude,objEmployeeID;
		var strDateValidation,strResourceName;
		strDateValidation='';
		strResourceName='';
		
		<%MyBase.InitializeResources("AppResources.FA_TeamBilling", "AppResources")%>;
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		function Sort_OnClick(sortby,sortorder)
		{
			objform.action = "FA_TeamBilling.aspx?Mode=<%=m_strMode%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=" + sortby + "&SortOrder=" + sortorder; 
			objform.submit();  
		}
		function Invoice_OnClick(INO)
		{
			objform.action = "FA_TeamBilling.aspx?Mode=<%=CONST_MODE_INVOICE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>&InvoiceNo=" + INO; 
			objform.submit();  
		}
		function SelectAll_OnClick()
		{
			var rowcount;
			var objTxt,i;
				
			objTxt = GetObjectReference('frmFA_TeamBilling','hdtxtRowCount'); 
			rowcount = objTxt.value;
			if(rowcount>0)
			{
				var objChk;
				objChk = GetObjectReference('frmFA_TeamBilling','chkDelete',true); 
					
				for(i=0;i<rowcount;i++)
					objChk[i].checked = true;
			}
		}
		function Delete_OnClick()
		{
			var rowcount,blnSelected=false;
			var objTxt,i;
				
			objTxt = GetObjectReference('frmFA_TeamBilling','hdtxtRowCount'); 
			rowcount = objTxt.value;
			if(rowcount>0)
			{
				var objChk;
				objChk = GetObjectReference('frmFA_TeamBilling','chkDelete',true); 
					
				for(i=0;i<rowcount;i++)
					if(objChk[i].checked==true)
					{
						blnSelected=true;
						break;
					}
			}
			
			if(blnSelected==true)
			{
				if(window.confirm('<%=MyBase.GetResourceString("MSG_DELETE_CONFIRM")%>')==true)
				{
					objform.action = "FA_TeamBilling.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>"; 
					objform.submit();
				}			
			}
			else
				alert('<%=MyBase.GetResourceString("MSG_RECORD_NOTSELECTED")%>');
		}
		function AddNew_OnClick()
		{
			objform.action = "FA_TeamBilling.aspx?Mode=<%=CONST_MODE_INVOICE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>&InvoiceNo="; 
			objform.submit();
		}
		function Back_OnClick()
		{
			objform.action = "FA_TeamBilling.aspx?Mode=<%=CONST_MODE_LIST%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>&InvoiceNo="; 
			objform.submit();
		}
		function Save_OnClick()
		{
			var intItems,intTotalInvoiceItems,intCtr;
			var objUserName, objFromDate, objToDate, objMonthlyFee, objBillingPercentage;
						
			intTotalInvoiceItems = 0;
			objEmployeeID = GetObjectReference('frmFA_TeamBilling','txtEmployeeID',true); 
			if(objEmployeeID!=null)
			{
				intItems = objEmployeeID.length;
				
				objUserName = GetObjectReference('frmFA_TeamBilling','txtUserName',true); 
				objMonthlyFee = GetObjectReference('frmFA_TeamBilling','txtMonthlyFee',true); 
				objBillingPercentage = GetObjectReference('frmFA_TeamBilling','txtBillingPercentage',true); 
				objExclude = GetObjectReference('frmFA_TeamBilling','chkExclude',true);  
				
				if(intItems>0)
				{
					for(intCtr=0;intCtr<intItems;intCtr++)
					{
						if(objExclude[intCtr].checked==false)
						{
							objFromDate = GetObjectReference('frmFA_TeamBilling','txtFromDate' + objEmployeeID[intCtr].value);  
							objToDate = GetObjectReference('frmFA_TeamBilling','txtToDate' + objEmployeeID[intCtr].value);  
							if(IsDataValid(objEmployeeID[intCtr], objUserName[intCtr], objFromDate, objToDate, objMonthlyFee[intCtr], objBillingPercentage[intCtr])==false)
								return;
							else
								intTotalInvoiceItems++;
						}
					}
				}				
			}
			//If all the resources are excluded from the invoice, then do not allow to save the details.
			if(intTotalInvoiceItems == 0)
			{
				alert('<%=MyBase.GetResourceString("MSG_ALL_EXCLUDED")%>');
				return;
			}
			
			if(strDateValidation != '')
			{
				if(window.confirm('<%=MyBase.GetResourceString("MSG_CONFIRM1")%>' + '\r\n' + strDateValidation + '\r\n' + '<%=MyBase.GetResourceString("MSG_CONFIRM2")%>' + '\r\n' + '<%=MyBase.GetResourceString("MSG_CONFIRM3")%>')==false)
				{
					strDateValidation='';
					return;
				}  
			}
			
			objform.action = "FA_TeamBilling.aspx?Mode=<%=CONST_MODE_INVOICE%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>&InvoiceNo=<%=m_strInvoiceNo%>"; 
			objform.submit();
		}
		
		function IsDataValid(objEmployeeID, objUserName, objFromDate, objToDate, objMonthlyFee, objBillingPercentage)
		{
			var dtmMinDate, dtmMaxDate, blnResourceAddedToList;
			var intCtr,flag;
						
			dtmMinDate="";
			dtmMaxDate="";
			strResourceName = "\r\n[for " + objUserName.value + "]";
			
			//Validation - The From an To Dates must not be blank. The From Date cannot be greater than the To date.
			if(objFromDate.value == "")
			{
				//modified by HarshK on 06/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				alert("<%=MyBase.GetResourceString("MSG_FROMDATE_EMPTY")%>");
				//End modified by HarshK on 05/09/05 for sp4 issueid 136 
				//Commented by SandipL on 8 Dec 2005 -- No need to focus on DtControl as it is disabled
				//objFromDate.focus();
				//End commenting by SandipL
				return false;
			}
			if(objToDate.value == "")
			{
				//modified by HarshK on 06/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				alert("<%=MyBase.GetResourceString("MSG_TODATE_EMPTY")%>");
				//End modified by HarshK on 06/09/05 for sp4 issueid 136
				//Commented by SandipL on 8 Dec 2005 -- No need to focus on DtControl as it is disabled
				//objToDate.focus();
				//End commenting by SandipL
				return false;
			}
			
			var objFDt,objTDt;
			
			objFDt = getDate(objFromDate.value);
			objTDt = getDate(objToDate.value);
			//modified by HarshK on 06/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
			flag = disallowDate1GreaterThanOrEqualToDate2(objFromDate,objToDate,"<%=MyBase.GetResourceString("MSG_FROMDATE_GREATER")%>",true);
			//End modified by HarshK on 06/09/05 for sp4 issueid 136 
			if(flag==true)
				return false;
				
			/*if(DateDiff(getDate(objToDate.value),getDate(objFromDate.value),"d") > 0)
			{
				alert('<%=MyBase.GetResourceString("MSG_FROMDATE_GREATER")%>');
				objFromDate.focus();
				return false;
			}*/
			
			var objFDt1,objTDt1;	
			var blnResourceAddedToList = false;
			for(intCtr=0;intCtr<strDateArray.length;intCtr++)
			{
				if(objEmployeeID.value==strDateArray[intCtr][0])
				{
					objFDt = getDate(objFromDate.value);
					objTDt = getDate(objToDate.value);
					objFDt1 = getDate(strDateArray[intCtr][2]);
					objTDt1 = getDate(strDateArray[intCtr][1]); 
					
					if((DateDiff(objFDt,objFDt1,"d") < 0) || (DateDiff(objTDt,objTDt1,"d") > 0)) { }
					else
					{
						//If the resource has not been added to the lst, then add.
						if(blnResourceAddedToList ==false)
						{
							if(strDateValidation !="")
								strDateValidation += "\r\n";
							
							strDateValidation += objUserName.value + "\t";
							blnResourceAddedToList=true;
						}
						
						//Get the minimum Date.
						if(dtmMinDate=="")
							dtmMinDate = strDateArray[intCtr][1];
						else
						{
							if(DateDiff(getDate(dtmMinDate),objTDt1,"d") < 0)
								dtmMinDate = strDateArray[intCtr][1];
						}
						
						//Get the maximum Date.
						if(dtmMaxDate=="")
							dtmMaxDate = strDateArray[intCtr][2];
						else
						{
							if(DateDiff(getDate(dtmMaxDate),objFDt1,"d") > 0)
								dtmMinDate = strDateArray[intCtr][2];
						}						
					}
				}
			}
			
			//If the invoice has already been generated for the resource, then...
			if(blnResourceAddedToList == true)
				strDateValidation += "[" + dtmMinDate + " - " + dtmMaxDate + "]";
				
			//Validation - The Monthly Fee cannot be blank. It must hold a numeric value. 
			//It must have a value greater than 0.
			flag = disallowBlank(objMonthlyFee,'<%=MyBase.GetResourceString("MSG_MONTHLYFEE_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			/*if(objMonthlyFee.value=='')
			{
				alert('<%=MyBase.GetResourceString("MSG_MONTHLYFEE_EMPTY")%>');
				objMonthlyFee.focus();
				return false;
			}*/
			
			if(disallowNonNumeric(objMonthlyFee,'<%=MyBase.GetResourceString("MSG_MONTHLYFEE_NAN")%>',true)==true)
			{
				objMonthlyFee.focus();
				return false;
			}
			
			flag = disallowMinValueViolation(objMonthlyFee,0,'<%=MyBase.GetResourceString("MSG_MONTHLYFEE_ZERO")%>',true);
			if(flag==true)
				return false;
				
			var dblMFee = new Number(objMonthlyFee.value);
			if(dblMFee == 0)
			{
				alert('<%=MyBase.GetResourceString("MSG_MONTHLYFEE_ZERO")%>');
				objMonthlyFee.focus();
				return false;
			}		
			
			flag = disallowBlank(objBillingPercentage,'<%=MyBase.GetResourceString("MSG_BILLINGPER_EMPTY")%>',true);
			if(flag==true)
				return false;
				
			/*if(objBillingPercentage.value =='')
			{
				alert('<%=MyBase.GetResourceString("MSG_BILLINGPER_EMPTY")%>');
				objBillingPercentage.focus();
				return false;
			}*/
			
			if(disallowNonNumeric(objBillingPercentage,'<%=MyBase.GetResourceString("MSG_BILLINGPER_NAN")%>',true)==true)
			{
				objBillingPercentage.focus();
				return false;
			}	
			
			var dblBPer = new Number(objBillingPercentage.value);
			if(dblBPer <=0 || dblBPer > 100)
			{
				alert('<%=MyBase.GetResourceString("MSG_BILLINGPER_NOTINRANGE")%>');
				objBillingPercentage.focus();
				return false;
			}
			
			return true;
		}
		</Script>				
	</body>
</HTML>
