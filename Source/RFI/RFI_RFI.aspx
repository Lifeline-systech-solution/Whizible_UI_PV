<script type="text/javascript" src="../../responsive/responsive.js"></script>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

	tr.clsTRBody td{
		text-align: right;
	}
</style>

<script type="text/javascript">
    $(document).ready(function()
    {
       $('td [title="Invoice Items"]').css('float','right');
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RFI_RFI.aspx.vb" Inherits="PbNIT.RFI_RFI"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
	<%CommonFunctions.General.PlotPageHeadTag("RFI_RFI")%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout" >
		
					<form id="frmRFI_RFI" method="post" runat="server">
									<%PageInit%>
		
					</form>
		<link href="../General/loaderStylesheet.css" rel="stylesheet" />
					<SCRIPT language="javascript">
		var objform=GetFormReference('frmRFI_RFI');
		var objdivlist=GetObjectReference('frmRFI_RFI','PageDiv');
		var objRFIType=GetObjectReference('frmRFI_RFI','cboRFITypeID');
		var objCustomer=GetObjectReference('frmRFI_RFI','cboCustomerID');
		//Integrated by TruptiK
		//Added by PrashantSJ on 11 Dec 2006
		//Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod)
		var objSalesPeriod=GetObjectReference('frmRFI_RFI','txtSalesPeriod');
		//End of addition by PrashantSJ on 11 Dec 2006
		//End of integration by TruptiK
		var objCustomerAddress=GetObjectReference('frmRFI_RFI','txtCustomerAddressID');
		var objCustomerContact=GetObjectReference('frmRFI_RFI','cboCustomerContactID');
		var objCredit=GetObjectReference('frmRFI_RFI','txtCreditDays');
		var objBilling=GetObjectReference('frmRFI_RFI','cboBillingCurrencyID');
		var objEmail=GetObjectReference('frmRFI_RFI','txtConfirmEmailID');
		var objContract=GetObjectReference('frmRFI_RFI','txtcontract');
		var objHeader=GetObjectReference('frmRFI_RFI','txtRFIHeader');	
		var objCustomerContactEmail=GetObjectReference('frmRFI_RFI','cboCustomerContactEmailID');	
		//var objItemList=GetObjectReference('frmRFI_RFI','divItems');
		var objCheckListInstanceID=GetObjectReference('frmRFI_RFI','txtChecklistInstanceID');
		var objcboRFIID=GetObjectReference('frmRFI_RFI','cboRFIIDs');
		var objDivRFIItems=GetObjectReference('frmRFI_RFI','divItems');
		var objtxtRFIID=GetObjectReference('frmRFI_RFI','txtRFIID');
		var objControls=GetObjectReference('frmRFI_RFI','divControls');
		//Added by TruptiK on 19-Jun-2007
		var objtxtcontractid=GetObjectReference('frmRFI_RFI','txtcontractid');
		//End of addition by TruptiK
		//The div tag has id as PageDiv 
		function window_onload()
		{
		  
			
			var intDivHeight ;
			var intDivHeightRisk;
			 
			if (objdivlist !=null) {
			
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    if (intDivHeight < 100)	intDivHeight = 100;
			    //'Modified by ShraddhaM on Date 03 Jully,2006 for WhizibleSEM Issue ID.4168
			
			    if(navigator.appName == 'Netscape')
			    {			   
			        intDivHeight = window.innerHeight  - objdivlist.offsetTop - 40;
				 
			        ///*if("<%=m_strMode%>" == 'Edit')
			        //{
					  
			        //		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 110;
			        //	}
			        //	else if("<%=m_strMode%>" == 'New')
			        //	{
					    
			        //		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 280;
			        //	} */ 
			    }

			    
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;
			    objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //	objdivlist.style.width =document.body.offsetWidth;}	
			}
            //COMMENTED BY nILESH G ON 29/12/2015
			//if(objDivRFIItems!=null)
			//{	
			//	//objDivRFIItems.style.width=document.body.offsetWidth-60;
			//	if(objControls!=null)
				//{	if("<%=m_blnReadOnly%>"=="True")
			//				{
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop - 370;
			//				objDivRFIItems.style.height= document.body.offsetHeight - objControls.offsetTop -330;
			//				}
			//			else
			//				{
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop - 325;
			//				objDivRFIItems.style.height= document.body.offsetHeight - objControls.offsetTop -368;
			//				}
							
			//	}
			//	objDivRFIItems.style.width=document.body.offsetWidth-28;
			//}
			//else
			//{
				
			//	if(objControls!=null)
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop - 40;
			//				//objControls.style.height=document.body.offsetHeight - objControls.offsetTop - 60;
					
		    //}
		    //END OF COMMENTED BY nILESH G ON 29/12/2015
			
				
			if("<%=m_strDeletionStatus%>"!="")
				alert("<%=m_strDeletionStatus%>")
			
			if("<%=m_sSQL%>"!="")
				alert("<%=m_sSQL%>");	
			//Integrated  by SavitaS on 14 Mar 2006 for IssueID-2836
			//Added by GaneshG on 13 Mar 06 
			if(objCustomer != null)	
			intIndex = objCustomer.selectedIndex;						
			//End Addition 
			//End Integration by SavitaS
			setFocus(objRFIType);
				
		}
		
		function window_onresize()		
		{
		
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    if(navigator.appName == 'Netscape')
			    {			   
			        intDivHeight = window.innerHeight  - objdivlist.offsetTop - 40;
			    }
			    //	if (intDivHeight < 100)	intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;
			    objdivlist.style.height = intDivHeight + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //	objdivlist.style.width =document.body.offsetWidth;}
			
			    //'Modified by ShraddhaM on Date 19 July,2006 for WhizibleSEM 
			} 
		    //COMMENTED BY nILESH G ON 29/12/2015
			//if(objDivRFIItems!=null)
			//{
			//	//objDivRFIItems.style.width=document.body.offsetWidth-28;
				 
			//	//objDivRFIItems.style.height=document.body.offsetHeight-objDivRFIItems.offsetTop-360;
		 
				
			//	if(objControls!=null)
			//	{		
				//		if("<%=m_blnReadOnly%>"=="True")
			//				{
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop ;
			//				objDivRFIItems.style.height= document.body.offsetHeight - objControls.offsetTop ;
			//				}
			//			else
			//				{
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop ;
			//				objDivRFIItems.style.height= document.body.offsetHeight - objControls.offsetTop ;
			//				}
							
			//	}
			//	objDivRFIItems.style.width=document.body.offsetWidth;
				
			//}
			//else
			//{
				
			//	if(objControls!=null)
			//				objControls.style.height=document.body.offsetHeight - objControls.offsetTop ;
					
		    //}
		    //END OF COMMENTED BY nILESH G ON 29/12/2015
				
		}	
		function Save_OnClick()
		{
		    
			// PURPOSE: To save the RFI details.
		    // Validate the controls on the RFI entry screen.
		    var Mode = (arguments.length > 0) ? arguments[0] : "0";
		    if (Mode == "0") {	           
		        document.body.readonly=true;
		        window.setTimeout('Save_OnClick("1")', 1);
		    }
		    if (Mode == "1") {
		        if(ValidateControls() == true)
		        {
		            EnableControls();	
		            //Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
		            //Modified By GaneshG on 16 Jan 2006
		            //objform.action="RFI_RFI.aspx?Mode=" + "<%=m_strMode%>" + "&Action=Save&RFIID=" + <%=m_intRFIID%> + "&PageNumber=1"
		            //Added By Sanyogeeta R on 12-Oct-2016 For Page Loader
		            //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
		            var MenuTags = document.getElementsByTagName('A');
		            for (i = 0; i < MenuTags.length; i++) {
		                if (MenuTags[i].className == "Menu") {
		                    //MenuTags[i].style.display= "none";
		                    MenuTags[i].parentNode.style.display = "none";
		                }
		            }
		            // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
		            //End Of Addition By Sanyogeeta R on 12-Oct-2016 For Page Loader
		            setFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link	
		            objform.action="RFI_RFI.aspx?PKToken=" + "<%=m_strToken%>" + "&Mode=" + "<%=m_strMode%>" + "&Action=Save&UserType=" + "<%=m_strUserType%>" + "&RFIID=" + <%=m_intRFIID%> + "&PageNumber=1"
		            //End of Modification 
		            //End Integration
		            objform.submit();
		        }
		    }
		}	
		function ValidateControls()		
		{
					// PURPOSE : To validate the controls before saving the RFI details.
					
					var result;	
					result = true;
						
					// Validation - Not blank. (RFI Type)
					if (disallowBlank(objRFIType,"<%=MyBase.GetResourceString("MSG_TYPE_BLANK")%>",true))
							return false;
						
					// Validation - Not blank. (Customer)
					if (disallowBlank(objCustomer,"<%=MyBase.GetResourceString("MSG_CUST_BLANK")%>",true))
							return  false;
					
					// Validation - Not blank. (Customer Address)
					if (disallowBlank(objCustomerAddress,"<%=MyBase.GetResourceString("MSG_CUSTADD_BLANK")%>",true))
							return  false;											
			
					// Validation - Not blank. (Contact Person)
					if (disallowBlank(objCustomerContact,"<%=MyBase.GetResourceString("MSG_CONATCT_BLANK")%>",true))
							return  false;							
			
					// Credit Days.
					// Validation - Not Blank.
					if (disallowBlank(objCredit,"<%=MyBase.GetResourceString("MSG_CREDIT_BLANK")%>",true))
							return  false;	
			
					// Validation - Positive Numeric.
					if (disallowNegativeNumeric(objCredit,"<%=MyBase.GetResourceString("MSG_NUM_CREDIT")%>",true))
							return  false;
			
					//Validation - Not blank. (Currency)
					if (disallowBlank(objBilling,"<%=MyBase.GetResourceString("MSG_BLANK_CURRENCY")%>",true))
							return  false;						
						
					// Validation - Valid Email ID. (Email Confirm)
					if(objEmail.value != "")
					{
						if(ValidateEmailID(objEmail.value)==false)
						{
							alert("<%=MyBase.GetResourceString("MSG_EMAIL_BLANK")%>")
							objEmail.focus();
							return false;
							
						}
					}
				//	/*if (disallowBlank(objEmail,"<%=MyBase.GetResourceString("MSG_EMAIL_BLANK")%>",true))
				//			return  false;		*/
						
					// Validation - Not blank. (Contract)
					if (disallowBlank(objContract,"<%=MyBase.GetResourceString("MSG_CONTACT_BLANK")%>",true))
							return  false;		
						
					// Validation : Max length - RFI Header.
					if (disallowMaxlengthViolation(objHeader,2000,"<%=MyBase.GetResourceString("MSG_HEADER_MAX")%>",true))
							return  false;	
					//Integrated by TruptiK
					//Added by PrashantSJ on 11 Dec 2006
					//Purpose: To plot the Salesperiod Combobox (using this we can select any open salesperiod)
					// Validation - Not blank. (Salesperiod)
					if (disallowBlank(objSalesPeriod,"<%=MyBase.GetResourceString("MSG_BLANK_SALESPERIOD")%>",true))
							return  false;		
					//End of addition by PrashantSJ on 11 Dec 2006
					//End of integration by TruptiK		
					return true;
						
				}			
					
				function EnableControls()
				{
					// PURPOSE: To enable the disabled controls.
						
					objCustomer.disabled = false;
					objRFIType.disabled = false;
					objBilling.disabled = false;
				}
				
				function SelectSalesPersons()
				{
					window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2070","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300"); 
				}
				//Added by TruptiK on 19-Jun-2007
				//Purpose:-Now contract is selected not from combo box from new contractlist page.
				function SelectContract()
				{
					//var objcontractid=GetObjectReference('frmRFI_RFI',txtcontractid).value;
					
					if(objCustomer.value=="")
					{ 
					alert('Please select the customer');
					return;
					}
							
					var intCustomerID;	
					if(objCustomer!=null)
					intCustomerID=objCustomer.value;
					else
					intCustomerID="0";					
					window.open("../RFI/RFI_Contract_Details_CommonList.aspx?FromWhere=PM&CustomerID=" + intCustomerID + "&MasterTagID=3816","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=800,height=350");
				}
				//End of Addition by Truptik
				//Added By MohitS on 3 Jan 2006 
				//Added by TruptiK on 21-Jun-2007
				function SelectSalesPeriod()
				{
				window.open("../RFI/RFI_SalesPeriod_CommonList.aspx?FromWhere=PM&MasterTagID=3814","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=750,height=300");
				}
					//End of Addition by Truptik

//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function SelectMilestones()
				function SelectMilestones()
				{	
					//window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=3084&customer=" + objCustomer.value  ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
					//window.open("../General/CommonList.aspx?MasterTagID=3084&UserType=" + "<%=m_strUserType%>" + "&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
					//window.open("../General/CommonList.aspx?MasterTagID=3585&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
					window.open("../RFI/RFI_Milestone_CommonList.aspx?MasterTagID=3585&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> + "&PKToken=" + "<%=m_strToken%>" ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
				}
//End by MonikaI

				//End of MohitS
				
				//Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
				//Added by GaneshG on 11 Jan 2006

//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function SelectDeliverable()
				function SelectDeliverable()
				{	
					//window.open("../General/CommonList.aspx?MasterTagID=3086&UserType=" + "<%=m_strUserType%>" + "&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
					//window.open("../General/CommonList.aspx?MasterTagID=3586&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> ,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
					window.open("../General/CommonList.aspx?MasterTagID=3586&Customer=" + objCustomer.value + "&RFIID=" +  <%=m_intRFIID%> + "&PKToken= " + "<%=m_strToken%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=700,height=300"); 					
				}
//End by MonikaI

				//End of addition
				//End Integration by SavitaS
				
				function cboCustomerContactID_OnChange()
				{
					
					var intIndex = objCustomerContact.selectedIndex;
					objCustomerContactEmail.selectedIndex=intIndex;
					objEmail.value = objCustomerContactEmail.value;
				}
				function SelectDevelopmentTools()
				{
					window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2065","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300"); 
				}
				function SelectOperatingSystems()
				{
					window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2066","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300"); 
				}
				function AddNewItem_OnClick()
				{
					if(((trimString(objRFIType.value)) != <%=m_intRFITypeID%>)==true)
					{
						alert("<%=MyBase.GetResourceString("MSG_TYPE_CHG")%>");
						return;
					} 
				
					
				//	/*if(((trimString(objBilling.value)) != "<%=m_intBillingCurrencyID%>")==true)
				//	{
						
				//		alert("<%=MyBase.GetResourceString("MSG_CUR_CHG")%>");
				//		return;
				//	} */
				//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
					//window.open("RFI_RFIItem.aspx?Mode=New&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=700,height=350");
					//Commented and added by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
					//Purpose: To increase height of page
					//window.open("RFI_RFIItem.aspx?PKToken=<%=m_strNewItemToken%>&Mode=New&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=700,height=350");
					window.open("RFI_RFIItem.aspx?PKToken=<%=m_strNewItemToken%>&Mode=New&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");
					//End of Comment and addition by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
				//End by MonikaI
				}

//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function Submit_OnClick()
				function Submit_OnClick()
				{
					// PURPOSE: To submit the RFI.
					//Added by PrashantSJ on 22nd June 2007 For WhizibleSEM 7.0
					//Purpose: Validation of IR Approver have to present before submitting IR
					if ("<%=m_sIRApproverID%>"=="0")
					{
						alert("Please set the IR Approver for project!!");
						return;
					}
						
					
					//End of addition by PrashantSJ on 22nd June 2007
					if(objCheckListInstanceID.value == "0")
					{
						//window.open("RFI_RFIChecklist.aspx?RFIID=<%=m_intRFIID%>&SubmitRFI=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
						window.open("RFI_RFIChecklist.aspx?PKToken=<%=m_strSubmitToken%>&RFIID=<%=m_intRFIID%>&SubmitRFI=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
						return;
					}
					//window.open("../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
					window.open("../General/CommonPage.aspx?PKToken=<%=m_strSubmitToken%>&Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Submit&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
				}
//End by MonikaI

				function Back_OnClick(TagID,FromWhere)
				{
							
					// PURPOSE: To navigate back to the RFI list screen.
					window.location.href  ="../General/Commonlist.aspx?FromWhere=" + FromWhere + "&MasterTagID=" +TagID;
				}	
				function Previous_OnClick()		
				{
					// PURPOSE: To navigate to the previous RFI in the list.	
				//Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
					var arrToken;
					var strToken;
					var intIndex;
					
					intIndex=objcboRFIID.selectedIndex - 1;
					strToken = '<%=m_arrToken%>';
					arrToken = strToken.split(",");
					strToken = arrToken[intIndex];
				//End by MonikaI

					if((objcboRFIID.selectedIndex - 1) < 0)
						alert("<%=Mybase.GetResourcestring("MSG_PRE")%>");
					else
						{
					    objtxtRFIID.value = "0";
					    //ADDED BY Sanyogeeta  R ON 12/2/2016 For Page Loader
					    setFrameLoader();
					    //End Of Addition BY Sanyogeeta  R ON 12/2/2016 For Page Loader
						//objform.action = "RFI_RFI.aspx?Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex - 1].value;
						objform.action = "RFI_RFI.aspx?PKToken=" + strToken + "&Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex - 1].value;
						
						objform.submit();
						}
				}
					
					
				
					
					
				function Next_OnClick()
				{
					// PURPOSE: To navigate to the next issue in the list.	
				//Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
					var arrToken;
					var strToken;
					var intIndex;
					intIndex=objcboRFIID.selectedIndex + 1;
					strToken = '<%=m_arrToken%>';
					arrToken = strToken.split(",");
					strToken = arrToken[intIndex];
				//End by MonikaI

					if((objcboRFIID.selectedIndex + 1) >= objcboRFIID.options.length)
						alert("<%=Mybase.GetResourcestring("MSG_NEXT")%>");
					else				
					{
						objtxtRFIID.value = "0";
						//objform.action = "RFI_RFI.aspx?Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex + 1].value;
						objform.action = "RFI_RFI.aspx?PKToken=" + strToken + "&Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex + 1].value;
						objform.submit();
					}
				}

				function cboRFIID_OnChange()
				{
					// PURPOSE: To navigate to the selected RFI in the list.	
					objtxtRFIID.value = "0";
				//Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
					var arrToken;
					var strToken;
					var intIndex;
					intIndex=objcboRFIID.selectedIndex;
					strToken = '<%=m_arrToken%>';
					arrToken = strToken.split(",");
					strToken = arrToken[intIndex];
					//objform.action = "RFI_RFI.aspx?Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex].value; 
					objform.action = "RFI_RFI.aspx?PKToken=" + strToken + "&Mode=<%=m_strMode%>&RFIID=" + objcboRFIID.options[objcboRFIID.selectedIndex].value; 
				//End by MonikaI
					objform.submit();

				}
				function ChangeStatus_OnClick(strToken)
				{		
					// PURPOSE: To change the status of the selected RFI.
					//Accounts Person
					if ( "<%=m_strUserType%>"=="Accounts")
						{
						//Modified By JyotiG
						//Issue Id : 6197
						//Start	
						//window.open("../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Accounts&Comments=Details&RFIMode=Cancel&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
						window.open("../General/CommonPage.aspx?PKToken=" + strToken + "&Mode=ADD_NEW&ChangedBy=Accounts&Comments=Details&RFIMode=Cancel&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
						//End
						}
					else
						{		
						//Modified By JyotiG
						//Issue Id : 6197
						//Start			
						//window.open("../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&RFIMode=Approve&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
						window.open("../General/CommonPage.aspx?PKToken=" + strToken + "&Mode=ADD_NEW&ChangedBy=Approver&Comments=Details&RFIMode=Approve&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
						//End
						}
				}			
				function CheckList_OnClick()
				{
					window.open("../General/CommonList.aspx?MasterTagID=2069&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");					
				}	
				function QRB_OnClick()
				{
					window.open("../QRB/QRB_QueryList.aspx?MasterTagID=587", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");			
				}
				function SelectAll_OnClick()
				{
					var objCheckbox = GetObjectReference('frmRFI_RFI','chkDeleteItem',true);
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
									objCheckbox[intCtr].checked = true;							
							}
						}
						// Else, if single element exists, then...
						else if(intItems == 1)
						{
							objCheckbox = GetObjectReference('frmRFI_RFI','chkDeleteItem');
							if (objCheckbox.disabled == false) 
								objCheckbox.checked = true;						
						}
					}
				}
				//Added by TruptiK on 19-Jun-2007
				//Purpose:-To add ClearAll Function.
				function ClearAll_OnClick()
				{
					
					var objCheckbox = GetObjectReference('frmRFI_RFI','chkDeleteItem',true);
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
									objCheckbox[intCtr].checked = false;							
							}
						}
						// Else, if single element exists, then...
						else if(intItems == 1)
						{
							objCheckbox = GetObjectReference('frmRFI_RFI','chkDeleteItem');
							if (objCheckbox.disabled == false) 
								objCheckbox.checked = false;						
						}
					}
				}
				//End of addition by TruptiK on 19-Jun-2007
				function DeleteItem_OnClick()
				{
				//Integrated by TruptiK on 27-Jun-2007
				//Added by PrashantSJ on 31st July 2006
				//Purpose: Dont' allow to fire the msg when you are not selecting the item and click on the delete action link
				//Added by TruptiK on 24-Apr-09
				//Purpose:-Invoice discount change.
				var objRFIID
				var objRFIAmount
				var objtotalAmount
				var total=0
				
				objtotalAmount=GetObjectReference('frmRFI_RFI','hid_txttotalAmount');
				
				//End of addition by TruptiK
					var objCheckbox = GetObjectReference('frmRFI_RFI','chkDeleteItem',true);
					var blnChecked=false;
					if (objCheckbox != null)
					{
					   for (i=0;i<objCheckbox.length;i++)
					   {
//Added by TruptiK on 24-Apr-09
					    //Purpose:-Invoice discount change.
					  	if (objCheckbox[i].checked==true)
					     {
						objRFIID=objCheckbox[i].value;
						objRFIAmount=GetObjectReference('frmRFI_RFI','hid_txtRFIAmount_'+ objRFIID);
						
						
							total=parseFloat(total)+ parseFloat(objRFIAmount.value)
						
							
						}
						//End of addition by TruptiK on 24-Apr-09					
					     if (objCheckbox[i].checked==true)
					     {
						  blnChecked=true;
						 //break;
					     }
					   }
					}
					
 //Added by TruptiK on 24-Apr-09
					 //Purpose:-Invoice discount change.
					if(parseFloat(total)>parseFloat(objtotalAmount.value))
					{
						alert('Invoice amount can not be negative');
						return;
					}
					//End of addition by TruptiK on 24-Apr-09
					if (blnChecked==false)
					 return;
				  //End of addition by PrashantSJ on 31st July 2006		
				  //End of intrgration by TruptiK on 27-Jun-2007 
										
					if(window.confirm("<%=Mybase.GetResourceString("MSG_DEL")%>")==true)
					{
						EnableControls();
						//Commented and Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
						//objform.action="RFI_RFI.aspx?Mode=" + "<%=m_strMode%>" + "&Action=DeleteItem&RFIID=" + "<%=m_intRFIID%>";
						objform.action="RFI_RFI.aspx?PKToken=<%=m_strToken%>&Mode=" + "<%=m_strMode%>" + "&UserType=" + "<%=m_strUserType%>" + "&Action=DeleteItem&RFIID=" + "<%=m_intRFIID%>";
						//End Integration 
						objform.submit();
						
					}
				}
				
			// Added By NageshM on Date 16th Nov 2005
		function EditItemForMilestone_OnClick(intRFIItemID,intMilestoneID)
			{
				// Added By NageshM On Date 15the Nov 2005
					if (intRFIItemID==0)
				
				///window.open("../General/CommonPage.aspx?MilestoneID_PK=4&MasterTagID=34&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300")					
				window.open("../General/CommonPage.aspx?MilestoneID_PK=" + intMilestoneID + "&MasterTagID=20099&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1","","resizable=No,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 200)/2 + ",width=600,height=200")					
					
				//	alert(" This Item is not Editable if u want to  change the vaues then please set it's values at milestone level");
					
					
			}
			// End Of Addition
			
//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function EditItem_OnClick(intRFIItemID)
				
				function EditItem_OnClick(strItemToken,intRFIItemID)
		        {
				    //debugger;
				// PURPOSE: To edit the RFI Item details.	
					//window.open("RFI_RFIItem.aspx?Mode=Edit&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>&RFIItemID=" + intRFIItemID,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=700,height=350");					
					//Commented and added by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
					//Purpose: To increase height of page
					//window.open("RFI_RFIItem.aspx?Mode=Edit&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>&PKToken=" + strItemToken + "&RFIItemID=" + intRFIItemID,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=700,height=350");				
					window.open("RFI_RFIItem.aspx?Mode=Edit&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>&PKToken=" + strItemToken + "&RFIItemID=" + intRFIItemID,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");						
					//End of Comment and addition by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
				}
//End by MonikaI

//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function ReSubmit_OnClick()
				function ReSubmit_OnClick()
				{
					//Added by PrashantSJ on 22nd June 2007 For WhizibleSEM 7.0
					//Purpose: Validation of IR Approver have to present before resubmitting IR
					if ("<%=m_sIRApproverID%>"=="0")
					{
						alert("Please set the IR Approver for project!!");
						return;
					}	
					//End of addition by PrashantSJ on 22nd June 2007
					// PURPOSE: To re-submit the RFI.
					//window.open("../General/CommonPage.aspx?Mode=ADD_NEW&ChangedBy=Initiator&Comments=Details&RFIMode=Resubmit&MasterTagID=2073&RFIID_PK=<%=m_intRFIID%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
					//window.open("RFI_RFIChecklist.aspx?RFIID=<%=m_intRFIID%>&SubmitRFI=1&ReSubmit=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
					window.open("RFI_RFIChecklist.aspx?PKToken=<%=m_strSubmitToken%>&RFIID=<%=m_intRFIID%>&SubmitRFI=1&ReSubmit=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
				}
//End by MonikaI

				function ShowHistory_OnClick(intTagID,intUniqueID,intProjectID)
				{
					//Modified By ShraddhaM on 13 Sep 2006 for SP7 Issue ID : 6211

					window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=" +intTagID+ "&UniqueID=" +intUniqueID+ "&ProjectID="+ intProjectID , "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
					//window.open("../General/AuditTrail.aspx?TagID=" + intTagID + "&UniqueID=" + intUniqueID + "&ProjectID=" + intProjectID,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500")
				}
				
				function cboCustomerID_OnChange()
				{
						//Integrated by SavitaS on 14 Mar 2006 for IssueID-2836
						//Modified by GaneshG on 13 Mar 06	
					//if(objRFIType.disabled == true) // if Type is disabled then there exists the line items. 
					//{
						//if(window.confirm("You are changing the customer, so the milestone line items related to previous customer will be deleted.\n Do you want to continue?")==true)
						//{			
							// PURPOSE: To refresh screen and populate new customer contacts.
							//EnableControls();
							//Integrated by SavitaS on 13 Mar 2006 for IssueID-2836
							//objform.action="RFI_RFI.aspx?Mode=" + "<%=m_strMode%>" + "&Action=ChangeCustomer&RFIID=" + "<%=m_intRFIID%>";
							//objform.action="RFI_RFI.aspx?Mode=" + "<%=m_strMode%>" + "&UserType=" + "<%=m_strUserType%>" + "&Action=ChangeCustomer&RFIID=" + "<%=m_intRFIID%>";
							//End Integration
							//objform.submit();				
						//}
				    	//else
						//{
						//objCustomer.selectedIndex = intIndex;					 
						//}					
					//}
					//else
					//{
					    // PURPOSE: To refresh screen and populate new customer contacts.					
						EnableControls();
						objform.action="RFI_RFI.aspx?Mode=" + "<%=m_strMode%>" + "&UserType=" + "<%=m_strUserType%>" + "&Action=ChangeCustomer&RFIID=" + "<%=m_intRFIID%>";
						objform.submit();
					//}
					//End Modification
				}
				//End Integration by SavitaS on 14 Mar 2006
				
				//Modified By VidyaJ - Security issue - 6197
				function CustomerAddress_OnClick(strtoken)
				{
					// PURPOSE: To open the customer address window.
					var intContractID;	
					if(objCustomer!=null)
					{ 
					intContractID=objCustomer.value;
					if(trimString(intContractID) == "")
					{
						
						alert("<%=Mybase.GetResourceString("MSG_CUSTADD_DETAILS")%>");
						setFocus(objCustomer);
						return;
					}
					}
					
					var custID;
					custID=0;
					
					if(objCustomerAddress!=null)
						custID=objCustomerAddress.value;
					else
						custID=<%=m_intCustomerAddressID%>;
						
					if("<%=m_blnReadOnly%>" == "True")
						window.open("../General/CommonPage.aspx?PKToken=" + strtoken +"&FromWhere=SM&MasterTagID=2114&CustomerAddressID=" + custID + "&CustomerID=<%=m_intCustomerID%>&ReadOnly=1", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=500,height=350");						
					else
						//window.open("../General/CommonPage.aspx?FromWhere=SM&MasterTagID=2114&CustomerAddressID=<%=m_intCustomerAddressID%>&CustomerID=<%=m_intCustomerID%>&ReadOnly=0", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=500,height=350");						
						window.open("../General/CommonPage.aspx?PKToken=" + strtoken +"&FromWhere=SM&MasterTagID=2114&CustomerAddressID=" + custID + "&CustomerID=<%=m_intCustomerID%>&ReadOnly=0", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=500,height=350");						
					
				}
				
				//Modified By VidyaJ - IssueID - 6197 - Security patch
				function ContractDetails_OnClick(strToken)						
				{
					
		
					//Modified by TruptiK on 19-Jun-2007
					//Purpose:-Now there is text box for contract person so we take contractid from taxt box not from combo box.
			
					var intContractID;
					//var objcboContractID=GetObjectReference('frmRFI_RFI','cboContractID');
					var objtxtcontractid=GetObjectReference('frmRFI_RFI','txtcontractid');
					var objtxtcontractname=GetObjectReference('frmRFI_RFI','txtcontract');
					var objtxtToken=GetObjectReference('frmRFI_RFI','txtHiddenToken1').value;
					
					if("<%=m_blnReadOnly%>"=="False")
					{
						//if(objcboContractID!=null)
						if(objtxtcontractid!=null)
						{
							//intContractID=objcboContractID.value;
							intContractID=objtxtcontractid.value;
							if(trimString(intContractID) == "0")
							{
								
								alert("<%=Mybase.GetResourceString("MSG_CON_DETAILS")%>");
								//setFocus(objcboContractID);
								setFocus(objtxtcontractname);
								//End of modification by TruptiK on 19-Jun-2007
								return;
							}
						}
					}
					else
					{
						intContractID=<%=m_intContractID%>; 
					}
						
					window.open("../General/CommonPage.aspx?PKToken=" + objtxtToken +"&ContractID_PK=" + intContractID + "&MasterTagID=2130&FromWhere=SM&ParentTagID=0&FromCL=1", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
					
				}
				//Modified By JyotiG
				//Issue Id : 6197
				//Start			
				//function GenerateInvoice_OnClick(intRFIID)		
				function GenerateInvoice_OnClick(strToken)		
				//End
				{



					// PURPOSE: To generate invoice from the RFI.

					/*Code added by	:	ShubhadaL
					  Added on		:   26 Aug,2005
					  purpose		:   To check whether contract has been expired or not,if yes then dont allow to generate invoice.
					  */
					
					if(<%=m_verifyBit%> == 1)
					{
					alert("<%=Mybase.GetResourceString("CONTRACT_EXPIRED")%>");
					return;
					}
					//End of addition by  ShubhadaL
					//Integrated by TruptiK
					//Commented By PrashantSJ on 11 Dec 2006
					// If no sales period is open, no Invoices can be generated.
					//if(<%=m_intSalesPeriodID_OpenPeriod%> == 0)
						//alert("<%=Mybase.GetResourceString("PERIOD_BLANK")%>");
						
						//Comment End By PrashantSJ on 11 Dec 2006	
						
					//End of integration by TruptiK
					// If no Currency is marked as the base currency, no Invoices can be generated.
					else if("<%=m_strBaseCurrencyCode%>" == "")
						alert("<%=Mybase.GetResourceString("MSG_BASE")%>");
						
						
					// If no Currency is marked as the local currency, no RFIs can be added.
					//Commented by Trupitk on 27-Jun-2007
					//Purpose:-To remove local currency validation.
					//else if("<%=m_strLocalCurrencyCode%>" == "")
					//alert("<%=Mybase.GetResourceString("MSG_LOCAL")%>");
					//End by TruptiK
					// If no series information is entered for invoice number generation, no Invoices can be generated.
					//Code Commented by Dipalis on 24 July 2004
					//else if("<%=m_strFormula%>" == "")
					
					else if("<%=m_blnFormulaExists%>" == "False")
						alert("<%=Mybase.GetResourceString("MSG_FORMUA")%>");					
					else
						//Modified By JyotiG
						//Issue Id : 6197
						//Start			
						//window.open("RFI_InvoiceGeneration.aspx?RFIID=<%=m_intRFIID%>&FromDetails=1", "",  "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
						window.open("RFI_InvoiceGeneration.aspx?PKToken=" + strToken + "&RFIID=<%=m_intRFIID%>&FromDetails=1", "",  "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
						//End
				
				}
				
			function ValidateEmailID(strEmailList)
			{			
				var strEmailArray;
				var intCtr
				
				if( strEmailList == "")
				{
					return false;
				}
				
				objRegularExp = new RegExp("[\\,,\\ ,\\;]")						
				strEmailArray = strEmailList.split(objRegularExp);
				
				if ( strEmailArray.length == 0 )
					return false;
				
				for(intCtr = 0; intCtr < strEmailArray.length; intCtr++)
				{				
					if(isEmail(strEmailArray[intCtr]) == false)
					{
						//alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
						return false;
					}				
				}				
				return true;				
			}	
			
			function isEmail(str) 
			{
				/*
				'=====================================================================
				' Procedure Name        :   isEmail
				' Description           :   Generic function which validates if the Email Id entered by the user
				'							is in a proper format.	
				' Purpose               :   To Validate the email id is in proper format or not
				' Parameters Passed     :   Email ID which is to be validated
				' Returns               :
				' Parameters Affected   :   None
				' Assumptions           :
				' Dependencies          :
				' Author                :   UmaB
				' Created               :   11th September 2000
				' Revisions             :
				'=====================================================================
				*/		
					// Are regular expressions supported ?
					var supported = 0;
					
					if (window.RegExp) 
					{
						var tempStr = "a";
						var tempReg = new RegExp(tempStr);
						if (tempReg.test(tempStr)) supported = 1;
					}
					
					if (!supported) 
						return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);
					
					var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
					var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");
					
					return (!r1.test(str) && r2.test(str));
					
				}	
							
				
				//Added By VivekP On 4 May 2005 For PCFC			
//Commented and modified by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
				//function ProjectTimesheet_OnClick()
				function ProjectTimesheet_OnClick()
				{	
					//window.open ("RFI_ProjectTimesheetSelection.aspx?UserType=<%=m_strUserType%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=550,height=250");
					window.open ("RFI_ProjectTimesheetSelection.aspx?PKToken=<%=m_strToken%>&UserType=<%=m_strUserType%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=550,height=250");
				}
//End by MonikaI
				//End of Addition
				//Added by TruptiK on 2-May-2007
				function ProjectExpense_OnClick()
				{
				//window.open ("RFI_ProjectExpensesSelection.aspx?UserType=<%=m_strUserType%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=450");
				//window.open ("RFI_ProjectExpensesSelection.aspx?UserType=<%=m_strUserType%>&RFIID=<%=m_intRFIID%>","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=800,height=550");
				
				window.open ("RFI_ProjectExpensesSelection.aspx?UserType=<%=m_strUserType%>&RFIID=<%=m_intRFIID%>&PKToken=" + "<%=m_strToken%>","","resizable=no,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=800,height=550");
				//window.open("RFI_RFIItem.aspx?Mode=Edit&RFIID=<%=m_intRFIID%>&RFITypeID=<%= m_intRFITypeID%>&PKToken=" + strItemToken + "&RFIItemID=" + intRFIItemID,"","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=700,height=350");					
				}
				//End of addition by TruptiK on 2-May-2007
				//Added by PrashantSJ on 22nd June 2007 For WhizibleSEM 7.0
				//Purpose: Added one billing Entity called Project Monthly Fixed Fee billing
				function ProjectFixedFee_OnClick()
				{
					
					if (confirm("Do you want to create invoice line items for Project Fixed Fee ?"))
						{
						EnableControls();
						
						objform.action="RFI_RFI.aspx?PKToken=" + "<%=m_strToken%>" + "&Mode=" + "<%=m_strMode%>" + "&Action=FixedFee&UserType=" + "<%=m_strUserType%>" + "&RFIID=" + "<%=m_intRFIID%>"
						//objform.action="RFI_RFI.aspx?PKToken=<%=m_strToken%>&Mode=" + "<%=m_strMode%>" + "&UserType=" + "<%=m_strUserType%>" + "&Action=FixedFee&RFIID=" + "<%=m_intRFIID%>";
						objform.submit();		
						}
					
				}
				//End of addition by PrashantSJ on 22nd June 2007
				
				
					</SCRIPT>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
