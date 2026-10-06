<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RFI_RFIItem.aspx.vb" Inherits="PbNIT.RFI_RFIItem"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
	<%MyBase.InitializeResources("AppResources.RFI_RFIItem", "AppResources")%>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("WINDOW_TITLE"))%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmRFI_RFIItem" method="post" runat="server">
		
									<%PageInit%>
					</form>
        <link href="../General/loaderStylesheet.css" rel="stylesheet" />
					<Script language="javascript">
		var objform=GetFormReference('frmRFI_RFIItem');
		var objdivlist=GetObjectReference('frmRFI_RFIItem','PageDiv');
		var objtxtBillingToBaseConversionRate=GetObjectReference('frmRFI_RFIItem','txtBillingToBaseConversionRate');
		//commented by TruptiK on 23-Jun-2007	
		//var objtxtLocalToBaseConversionRate=GetObjectReference('frmRFI_RFIItem','txtLocalToBaseConversionRate');
		//End of commented by TruptiK
		//Integrated by TruptiK on 26-Apr-2007
		//Added by PrashantSJ on 18th July 2006 For Bristlecon
		//Purpose:  To Store the Company Currency related information in IR items  table
		var objtxtCompanyBaseConversionRate=GetObjectReference('frmRFI_RFIItem','txtCompanyBaseConversionRate');
		var objlblCompanyBaseConversionRate=GetObjectReference('frmRFI_RFIItem','lblCompanyBaseConversionRate');
		//End by PrashantSJ on 18th July 2006 For Bristlecon
		//End of integration by TruptiK
		var objCmbHidOrderNumber=GetObjectReference('frmRFI_RFIItem','cmbHidOrderNumber');
		var objQuantity =GetObjectReference('frmRFI_RFIItem','txtQuantity');
		var objRate=GetObjectReference('frmRFI_RFIItem','txtRate');
		var objtxtBillingCurrencyAmount=GetObjectReference('frmRFI_RFIItem','txtBillingCurrencyAmount');
		var objtxtOrderNumber=GetObjectReference('frmRFI_RFIItem','txtOrderNumber');
		var objlblBillingToBaseConversionRate=GetObjectReference('frmRFI_RFIItem','lblBillingToBaseConversionRate');
		//var objlblLocalToBaseConversionRate=GetObjectReference('frmRFI_RFIItem','lblLocalToBaseConversionRate');
		var objParent=GetParentFormReference('frmRFI_RFI');
		var strValidationScript;
		
			var dblBillingToBaseConversionRate;
			var  dblLocalToBaseConversionRate;
				
			var dblStandard_BillingToBaseConversionRate;
			var dblStandard_LocalToBaseConversionRate;
				
			var dblBillingCurrencyAmount;
			var dblBaseCurrencyAmount;
			var dblLocalCurrencyAmount;	
			//Integrated by TruptiK on  26-Apr-2007
			//Added by PrashantSJ on 18th July 2006 For Bristlecon
			//Purpose:  To Store the Company Currency related information in IR items  table
			var dblCompanyBaseConversionRate;
			var dblStandard_CompanyBaseConversionRate;
			var dblCompanyBaseCurrencyAmount;
			//End by PrashantSJ on 18th July 2006 For Bristlecon
			//End of integration by TruptiK
			 //Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
			//Added by GaneshG on 7 Mat 06
			var dblBalanceBillAmount;			
			//End Addition 	//End Integration by SavitaS
			dblStandard_BillingToBaseConversionRate = <%=m_dblStandard_BillingToBaseConversionRate%>;
			// To insert line feed in the DLL.
			dblStandard_LocalToBaseConversionRate = <%=m_dblStandard_LocalToBaseConversionRate%>;
			// To insert line feed in the DLL.	
			dblBillingToBaseConversionRate = <%=m_dblBillingToBaseConversionRate%>;
			// To insert line feed in the DLL.
			//dblLocalToBaseConversionRate = <%=m_dblLocalToBaseConversionRate%>;
			// To insert line feed in the DLL.
			//Integrated by TruptiK on  26-Apr-2007
			//Added by PrashantSJ on 18th July 2006 For Bristlecon
			//Purpose:  To Store the Company Currency related information in IR items  table
			dblCompanyBaseConversionRate=<%=m_dblCompanyBaseConversionRate%>;
			dblStandard_CompanyBaseConversionRate=<%=m_dblstandared_CompanyBaseConversionRate%>;
			dblCompanyBaseCurrencyAmount=<%=m_dblCompanyBaseCurrencyAmount%>;
			//End by PrashantSJ on 18th July 2006 For Bristlecon
			//End of integration by TruptiK
			dblBillingCurrencyAmount = <%=m_dblAmount%>;
			 //Integrated by SavitaS on 16 Mar 2006 for IssueID-2836
				//Added by GaneshG on 7 Mat 06
			dblBalanceBillAmount = <%=m_dblBalanceBillAmount%>;
			//End Addition 
			//End Integration by SavitaS
			// To insert line feed in the DLL.
			dblBaseCurrencyAmount = <%=m_dblBaseCurrencyAmount%>;
			// To insert line feed in the DLL.
//commented by TruptiK on 23-Jun-2007	
			//dblLocalCurrencyAmount = <%=m_dblLocalCurrencyAmount%>;
			//End of commented by TruptiK
			// To insert line feed in the DLL.
			//Integrated by TruptiK on 26-Apr-2007
			//Added by PrashantSJ on 02 Aug 2006
			//Purpose: The Company Base currency amount section always in hide mode when we first time visit the page
			var objtdShowHide_HideShowCompanyBaseAmountSection = document.getElementById("tdShowHide_HideShowCompanyBaseAmountSection");
			var objDivCompanyBaseAmountSection = document.getElementById("DivCompanyBaseAmountSection");
				//End of addition by PrashantSJ on 02 Aug 2006
				//End of integration by TruptiK
				
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
        
		//The div tag has id as PageDiv 
		function window_onload()
		{
			//Added by PrashantSJ on 02 Aug 2006
			//Purpose: The Company Base currency amount section always in hide mode when we first time visit the page
		
			objDivCompanyBaseAmountSection.style.display="none";
		
			objtdShowHide_HideShowCompanyBaseAmountSection.src='../../Images/plus.gif';
			//End of addition by PrashantSJ on 02 Aug 2006
			
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight; + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
				}	
			var objDescription=GetObjectReference('frmRFI_RFIItem','txtItemDescription');
			if (objDescription!=null)
				setFocus(objDescription);
		}
		
		function window_onresize()		
		{
			
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight; + 'px';
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/	}
			
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
		    
		        var i;
			
					
		        if (ValidateControls() == true)
		        {
		            if(isNaN(objtxtOrderNumber.value) || objtxtOrderNumber.value<=0 || disallowNonInteger(objtxtOrderNumber))
		            { 
		                alert("Please enter the positive numeric value");
		                setFocus(objtxtOrderNumber);
		                return; 				
		            }
		            for(i=0;i< objCmbHidOrderNumber.options.length;i++)
		            {
		                if(parseInt(objCmbHidOrderNumber.options[i].value) == parseInt(objtxtOrderNumber.value))
		                {
		                    //objtxtOrderNumber.value	
		                    alert("This sequence number already exists !");
		                    setFocus(objtxtOrderNumber)
		                    return; 		
		                }
		
		            }	
		            objtxtBillingToBaseConversionRate.value = <%=m_dblBillingToBaseConversionRate%>
					objtxtCompanyBaseConversionRate.value=<%=m_dblCompanyBaseConversionRate%>;
		            //objtxtLocalToBaseConversionRate.value = <%=m_dblLocalToBaseConversionRate%>
		            //objform.action = "RFI_RFIItem.aspx?Mode=<%=m_strMode%>&Action=Save&RFIID=<%=m_intRFIID%>&RFIItemID=<%=m_intRFIItemID%>";
		            //Integrated by TruptiK on 8-Apr-09
		            //Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
		            //''Code added by SwatiC on 26 Apr 2007 For Invoice Discount Changes
                    ///debugger;
		            var TotalAmount = <%=m_fltTotalAmount%>;
		            var objBillingCurrencyAmount = GetObjectReference('frmRFI_RFIItem','txtBillingCurrencyAmount');	
		            var objRate = GetObjectReference('frmRFI_RFIItem','txtRate');	
                    var CurrentAmount = objBillingCurrencyAmount.value;
                    if (TotalAmount != "0") {//For Discount
                        var CurrentTotalAmount = eval(TotalAmount) + eval(CurrentAmount);

                        if (CurrentTotalAmount < 0 || CurrentTotalAmount == 0) {
                            alert("Invoice Amount should be greater than 0.");
                            if (objRate)
                                objRate.focus();
                            //objBillingCurrencyAmount.value = "";
                            //objBillingCurrencyAmount.focus();
                            return;
                        }

                    }
		            //''End of Code addition by SwatiC on 26 Apr 2007 For Invoice Discount Changes 
					
		            //End of Code addition by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
		            //End Integrated by TruptiK on 8-Apr-09
		            setFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link	
		            objform.action = "RFI_RFIItem.aspx?PKToken=<%=m_strToken%>&Mode=<%=m_strMode%>&Action=Save&RFIID=<%=m_intRFIID%>&RFIItemID=<%=m_intRFIItemID%>";
		            objform.submit();	
											
		        }	
				
		    }
			
				
		}
		
		
		
		function CalculateAmount()
		{

				//' PURPOSE: To calculate the Amount value.
			
				var dblAmount = 0.00;
				var dblQuantity;
				
				// Get the "Quantity" value.
				dblQuantity = 1;
				
				if(objQuantity !=null)
				{ 
					
					if(trimString(objQuantity.value) != "")
					{
						if(isNumeric(trimString(objQuantity.value))==true)
						{
							
							if(parseFloat(objQuantity.value) > 0)
								dblQuantity = parseFloat(objQuantity.value);
						}
					}
				}
					
				// Get the "Rate" value.
				var dblRate = 0	;	
				if(objRate!=null)
				{
					if(trimString(objRate.value) != "" )
					{
						if(isNumeric(trimString(objRate.value))==true)
						{
								//Integrated by TruptiK on 8-Apr-09
							//Code Commented by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
							//''Code Commented by SwatiC on 26 Apr 2007 For Invoice Discount Changes
							//if(parseFloat(objRate.value) > 0)
							//''End of commentation by SwatiC on 26 Apr 2007 For Invoice Discount Changes
						//End of Code Commentation by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
						//End of integration by TruptiK
								dblRate = parseFloat(objRate.value) ;
						}
					}
				}

				// Calculate the Amount.
				//alert('rate'+dblRate);
				//alert('QTY'+dblQuantity);
				
				dblAmount = dblRate.toFixed(2) * dblQuantity.toFixed(2);
				
				//alert('Amt'+dblAmount);
				dblAmount= Math.round(dblAmount*100)/100;
				//alert('Amt'+dblAmount);
				
				//alert(objtxtBillingCurrencyAmount);
				
				objtxtBillingCurrencyAmount.value = dblAmount;
				
				//Added by MonikaI on 17th Aug 2006 for Whizible SP 7.2
				txtBillingCurrencyAmount_OnChange();
				//End of addition by MonikaI.
				
				//Code added by MrugajaB on 12th july 2006 for Whiziblesem SP7 issue ID 4168
				if (navigator.appName =='Netscape')
				{
					
					txtBillingCurrencyAmount_OnChange()
				}
				//End Addition
				//txtBaseCurrencyAmount 
			}		
			
		
			function txtRate_OnChange()
			{
				// PURPOSE: To calculate the Amount value if the rate value is changed.
				
				CalculateAmount();
			}
		
			function txtQuantity_OnChange()
			{
				// PURPOSE: To calculate the Amount value if the Quantity value is changed.
				
				CalculateAmount();
			}
			function ValidateControls()
			{
				// PURPOSE : To validate the controls before saving the RFI details.
	objDivCompanyBaseAmountSection.style.display="";	
				objtdShowHide_HideShowCompanyBaseAmountSection.src='../../Images/minus.gif';
				
				if(Validate()==false)
					return false;
				// Validation - Order Number.
				if (disallowBlank(objtxtOrderNumber,"<%=MyBase.GetResourceString("MSG_ORDER_BLANK")%>",true))
							return  false;	
				if (disallowNegativeNumeric(objtxtOrderNumber,"<%=MyBase.GetResourceString("MSG_PRDER_NUM")%>",true))
							return  false;	
				if (disallowMinValueViolation(objtxtOrderNumber,1,"<%=MyBase.GetResourceString("MSG_PRDER_NUM")%>",true))
							return  false;	
							
			
				
				return true;
			}
			
			
		
				
			//function txtBillingCurrencyAmount_OnPropertyChange()								
			function txtBillingCurrencyAmount_OnChange()
			{
				// PURPOSE : 1. To update the Base Currency (USD) Amount.
				//			2. To update the Local Currency (INR) Amount.
				
				// Get the new Billing Currency Amount.
				//alert('txtBillingCurrencyAmount');

				dblBillingCurrencyAmount	= objtxtBillingCurrencyAmount.value;										
					//alert(dblBillingCurrencyAmount);
				// Update the Base Currency (USD) Amount.
				if(dblBillingToBaseConversionRate == 0)
				{
					dblBaseCurrencyAmount = 0;						
				}
				else
				{
				 
				 
					dblBaseCurrencyAmount = dblBillingCurrencyAmount * dblBillingToBaseConversionRate;
				}		
						dblBaseCurrencyAmount = dblBillingCurrencyAmount * dblBillingToBaseConversionRate;
				//Integrated by TruptiK on 26-Apr-2007		
				//Added by PrashantSJ on 18th July 2006 For Bristlecon
				//Purpose:  To Store the Company Currency related information in IR items  table			
				if(dblCompanyBaseConversionRate==0)
					dblCompanyBaseCurrencyAmount=0
				else
                    dblCompanyBaseCurrencyAmount=dblBillingCurrencyAmount * dblCompanyBaseConversionRate;				   				
                    
                UpdateCompanyBaseCurrencyAmount();					    
                //End of addition by PrashantSJ on 18th July 2006 For Bristlecon
                //End of integration by TruptiK
				
				UpdateBaseCurrencyAmount();
									
				// Update the Local Currency (INR) Amount.
				 //commented by TruptiK on 23-Jun-2007	
				//dblLocalCurrencyAmount = dblBaseCurrencyAmount * dblLocalToBaseConversionRate;
				//dblLocalCurrencyAmount = dblBaseCurrencyAmount / dblLocalToBaseConversionRate;
				
				//UpdateLocalCurrencyAmount();		
				//End of commented by TruptiK		
			}
				//Integrated by TruptiK on 26-APr-2007
				//Added by PrashantSJ on 18th July 2006 For Bristlecon
			//Purpose:  To Store the Company Currency related information in IR items  table
			function txtBaseCurrencyAmount_OnChange()				
			{   
			 //PURPOSE : 1. To update the Company Base Currency (INR) Amount.
				//		2. To update the Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				// Get the new Company Base Currency (USD) Amount.
				dblCompanyBaseCurrencyAmount		= objtxtCompanyBaseCurrencyAmount.value;
					
				// Validate the newly entered Base Currency (USD) Amount.
				// If the amount is not valid, the Local Currency (INR) Amount should not be editable.
				if(isNumeric(dblCompanyBaseCurrencyAmount)==false)
				{
					dblCompanyBaseCurrencyAmount = 0;				
					
				}
				else if(dblCompanyBaseCurrencyAmount < 0)
				{
					dblCompanyBaseCurrencyAmount = 0;												
					
				}
							
								
				// Update the Currency Conversion Rate between the Company Base Currency (USD) and Billing Currency.
				if(dblCompanyBaseCurrencyAmount == 0)
					dblCompanyBaseConversionRate = 0;
				else
					dblCompanyBaseConversionRate = dblBillingCurrencyAmount / dblCompanyBaseCurrencyAmount;
				
				UpdateCompanyBaseConversionRate();      
			}
			//End of addition by PrashantSJ on 18th July 2006 For Bristlecon	
			//End of integration by TruptiK
			function UpdateBillingToBaseConversionRate()
			{
				// PURPOSE : To show the updated Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				if((Math.round(dblBillingToBaseConversionRate*100000)/100000) != (Math.round(dblStandard_BillingToBaseConversionRate*100000)/10000))
					objlblBillingToBaseConversionRate.innerHTML = "<FONT color=red>" + Math.round(dblBillingToBaseConversionRate*100000)/100000 + "</FONT>"
				else
					objlblBillingToBaseConversionRate.innerHTML = Math.round(dblBillingToBaseConversionRate*100000)/100000;
						
			}
				/*
				// PURPOSE : 1. To update the Local Currency (INR) Amount.
				//		2. To update the Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				// Get the new Base Currency (USD) Amount.
				dblBaseCurrencyAmount		= objtxtBaseCurrencyAmount.value;
					
				// Validate the newly entered Base Currency (USD) Amount.
				// If the amount is not valid, the Local Currency (INR) Amount should not be editable.
				if(isNumeric(dblBaseCurrencyAmount)==false)
				{
					dblBaseCurrencyAmount = 0;				
					objtxtLocalCurrencyAmount.readOnly = true;														
				}
				else if(dblBaseCurrencyAmount < 0)
				{
					dblBaseCurrencyAmount = 0;												
					objtxtLocalCurrencyAmount.readOnly = true;
				}
				else
					objtxtLocalCurrencyAmount.readOnly = false;
				
					
				// Update the Local Currency (INR) Amount.
				//commented by TruptiK on 23-Jun-2007	
				dblLocalCurrencyAmount = dblBaseCurrencyAmount * dblLocalToBaseConversionRate;
				UpdateLocalCurrencyAmount();				
					
				// Update the Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				if(dblBaseCurrencyAmount == 0)
					dblBillingToBaseConversionRate = 0;
				else
					dblBillingToBaseConversionRate = dblBillingCurrencyAmount / dblBaseCurrencyAmount;
					
				UpdateBillingToBaseConversionRate();
									
			}
			*/
			//commented by TruptiK on 23-Jun-2007	
			/*function txtLocalCurrencyAmount_OnChange()					
			{
			   
				// PURPOSE : 1. To update the Currency Conversion Rate between the Base Currency (USD) and Local Currency (INR).
				// Get the new Local Currency (INR) Amount.
				dblLocalCurrencyAmount		= objtxtLocalCurrencyAmount.value;
					
				//Validate the newly entered Local Currency (INR) Amount.
				if(isNumeric(dblLocalCurrencyAmount)==false)
					dblLocalCurrencyAmount = 0;						
				else if(isNumeric(dblLocalCurrencyAmount)==false)
					dblLocalCurrencyAmount = 0;						
									
				// Update the Currency Conversion Rate between the Base Currency (USD) and Local Currency (INR).
				if(dblBaseCurrencyAmount == 0)
					dblLocalToBaseConversionRate = 0;
				else					
					dblLocalToBaseConversionRate = dblLocalCurrencyAmount / dblBaseCurrencyAmount;
				
				UpdateLocalToBaseConversionRate();
				
				if("<%=m_strBaseCurrencyCode%>"== "<%=m_strBillingCurrencyCode%>")
				{				
					dblBillingToBaseConversionRate = dblLocalToBaseConversionRate;
					UpdateBillingToBaseConversionRate();
				}
			}*/			//End of commented by Trupti
				//Integrated by TruptiK on 26-APr-2007
				//Added by PrashantSJ on 18th July 2006 For Bristlecon
			//Purpose:  To Store the Company Currency related information in IR items  table
				function txtCompanyBaseCurrencyAmount_OnChange()				
			{
			 	// PURPOSE : 1. To update the Company Base Currency (INR) Amount.
				//		2. To update the Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				// Get the new Company Base Currency (USD) Amount.
				dblCompanyBaseCurrencyAmount		= objtxtCompanyBaseCurrencyAmount.value;
					
				// Validate the newly entered Base Currency (USD) Amount.
				// If the amount is not valid, the Local Currency (INR) Amount should not be editable.
				if(isNumeric(dblCompanyBaseCurrencyAmount)==false)
				{
					dblCompanyBaseCurrencyAmount = 0;				
					
				}
				else if(dblCompanyBaseCurrencyAmount < 0)
				{
					dblCompanyBaseCurrencyAmount = 0;												
					
				}
							
								
				// Update the Currency Conversion Rate between the Company Base Currency (USD) and Billing Currency.
				if(dblCompanyBaseCurrencyAmount == 0)
					dblCompanyBaseConversionRate = 0;
				else
					dblCompanyBaseConversionRate = dblBillingCurrencyAmount / dblCompanyBaseCurrencyAmount;
				
				UpdateCompanyBaseConversionRate();      
			}
			//End of addition by PrashantSJ on 18th July 2006 For Bristlecon	
			//End of integration by TruptiK
			function UpdateCompanyBaseCurrencyAmount()
			{
				// PURPOSE : To show the updated Company Base (INR) Amount.
				objtxtCompanyBaseCurrencyAmount.value = Math.round(dblCompanyBaseCurrencyAmount*100)/100;
			}
			function UpdateCompanyBaseConversionRate()
			{
			// PURPOSE : To show the updated Currency Conversion Rate between the Company Base Currency (USD) and Billing Currency.
				if((Math.round(dblCompanyBaseConversionRate*100000)/100000) != (Math.round(dblStandard_CompanyBaseConversionRate*100000)/10000))
					objlblCompanyBaseConversionRate.innerHTML = "<FONT color=red>" + Math.round(dblCompanyBaseConversionRate*100000)/100000 + "</FONT>"
				else
					objlblCompanyBaseConversionRate.innerHTML = Math.round(dblCompanyBaseConversionRate*100000)/100000;
			}
			//End of addition by PrashantSJ on 18th July 2006 For Bristlecon
			function UpdateBillingToBaseConversionRate()
			{
				// PURPOSE : To show the updated Currency Conversion Rate between the Base Currency (USD) and Billing Currency.
				if((Math.round(dblBillingToBaseConversionRate*100000)/100000) != (Math.round(dblStandard_BillingToBaseConversionRate*100000)/10000))
					objlblBillingToBaseConversionRate.innerHTML = "<FONT color=red>" + Math.round(dblBillingToBaseConversionRate*100000)/100000 + "</FONT>"
				else
					objlblBillingToBaseConversionRate.innerHTML = Math.round(dblBillingToBaseConversionRate*100000)/100000;
						
			}
				//commented by TruptiK on 23-Jun-2007	
			/*function UpdateLocalToBaseConversionRate()
			{
				
				// PURPOSE : To show the updated Currency Conversion Rate between the Base Currency (USD) and Local Currency (INR).
				if((Math.round(dblLocalToBaseConversionRate*100000)/100000) != (Math.round(dblStandard_LocalToBaseConversionRate*100000)/100000))
					objlblLocalToBaseConversionRate.innerHTML = "<FONT color=red>" + Math.round(dblLocalToBaseConversionRate*100000)/100000 + "</FONT>";
				else
					objlblLocalToBaseConversionRate.innerHTML = Math.round(dblLocalToBaseConversionRate*100000)/100000;
			}*///End of commented by TruptiK
				
			function UpdateBaseCurrencyAmount()
			{
				// PURPOSE : To show the updated Base Currency (USD) Amount.
				objtxtBaseCurrencyAmount.value = Math.round(dblBaseCurrencyAmount*100)/100;
				
			}
			  //commented by TruptiK on 23-Jun-2007	
			//function UpdateLocalCurrencyAmount()
			//{
				// PURPOSE : To show the updated Local Currency (INR) Amount.
				
				//objtxtLocalCurrencyAmount.value = Math.round(dblLocalCurrencyAmount*100)/100;
			//}
			//End of commented by TruptiK
			function ShowHistory_OnClick(intTagID,intUniqueID,intProjectID)
			{
				//Commented and Modified By SavitaS on 29 Sep 2006 for SP7 Issue ID : 6611
				//window.open("../General/AuditTrail.aspx?TagID=" + intTagID + "&UniqueID=" + intUniqueID + "&ProjectID=" + intProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500")
				window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=" + intTagID + "&UniqueID=" + intUniqueID + "&ProjectID=" + intProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500")
				//End of Commented and Modified By SavitaS on 29 Sep 2006 for SP7 Issue ID : 6611
			}
			
				function txtOrderNumber_Onchange()
			{
				//if(<%=m_strMode%>="Edit")
				/*
				var i;
				
				if(isNaN(objtxtOrderNumber.value) || objtxtOrderNumber.value<=0 || disallowNonInteger(objtxtOrderNumber))
				{ 
					alert("Please enter the positive numeric value");
					setFocus(objtxtOrderNumber);
				    return; 				
				}
				for(i=0;i< objCmbHidOrderNumber.options.length;i++)
				{
				    if(parseInt(objCmbHidOrderNumber.options[i].value) == parseInt(objtxtOrderNumber.value))
				    {
				    //objtxtOrderNumber.value	
					  alert("This sequence number already exists !");
					  setFocus(objtxtOrderNumber)
					  return; 		
					}
			
					}*/	
			}
			
		
			</Script>
	</body>
</HTML>
