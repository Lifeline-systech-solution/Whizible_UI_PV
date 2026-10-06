<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<%--<link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RFI_InvoiceGeneration.aspx.vb" Inherits="PbNIT.RFI_InvoiceGeneration"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><HTML>
	<%MyBase.InitializeResources("AppResources.RFI_InvoiceGeneration", "AppResources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("WINDOW_TITLE"))%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()" oncontextmenu="return false" >
		<form id="frmRFI_InvoiceGeneration" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmRFI_InvoiceGeneration');
		var objdivlist=GetObjectReference('frmRFI_InvoiceGeneration','divList');
		var objActiveDiv;
		var objActiveDiv1=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv1');
		var objActiveDiv2=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv2');
		var objActiveDiv3=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv3');
		var objActiveDiv4=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv4');
		var objDivList=GetObjectReference('frmRFI_InvoiceGeneration','divList',true);
		var objSave=GetObjectReference('frmRFI_InvoiceGeneration','lblSave',true);
		var objcboCustomerID=GetObjectReference('frmRFI_InvoiceGeneration','cboCustomerID');
		var objCustomerContact=GetObjectReference('frmRFI_InvoiceGeneration','cboCustomerContactID');
		var objCustomerContactEmail=GetObjectReference('frmRFI_InvoiceGeneration','cboCustomerContactEmailID');	
		var objEmail=GetObjectReference('frmRFI_InvoiceGeneration','txtConfirmEmailID');
		var intCurrentTaxNumber;
		intCurrentTaxNumber=0;
		
		
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			 //Modified by JyotiG on Date 12 July, 2006 for WhizibleSEM Issue ID.4168
			if (objdivlist !=null) 
			{
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    if (intDivHeight < 100)	intDivHeight = 100;
			     
			    if(navigator.appName == 'Netscape')
			    {
				    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 160;
				     intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			    }
			   
			   
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;	
			    objdivlist.style.height = intDivHeight +'px';	
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			}		
			objActiveDiv=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv1');
			// Resize the Div size according to the window size.
			SetAsActiveScreen(objActiveDiv);
			if(<%=m_intInvoiceID%>!=0)
						// Show the Save link.
							ShowSaveLink();								
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			 if(navigator.appName == 'Netscape')
			  {
				    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 160;
				     intDivHeight =window.innerHeight - objdivlist.offsetTop - 40;
			  }
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/
			    //objdivlist.style.height = intDivHeight;	
			 objdivlist.style.height = intDivHeight +'px';	
			    /*Commented And Added by KIRAN K K For Height Issue fixing*/	}
			// Resize the Div size according to the window size.
			SetAsActiveScreen(objActiveDiv);
			
		}	
		function ShowHistory_OnClick(intTagID, intUniqueID, intProjectID)
		{
			//PURPOSE: To display the audit trail/history screen.
			//Commented and Added by SavitaS on 18 Sept 2006 for SP7 Integration IssueID 6222			
			//window.open("../General/AuditTrail.aspx?TagID=" + intTagID + "&UniqueID=" + intUniqueID + "&ProjectID=" + intProjectID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
			window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=" + intTagID + "&UniqueID=" + intUniqueID + "&ProjectID=" + intProjectID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");			
			//End of Commented and Added by SavitaS on 18 Sept 2006 for SP7 Integration IssueID 6222
		}
		
		function SetAsActiveScreen(objDiv)
		{
		//Integrated by TruptiK on 19-May-09
        //Addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
		    //Purpose : Invoice>Invoice Genaration : For the step no 5 on the page the tax percentage field alignment  is not proper.(Mozilla)
			var i;
			var objLabel_TaxPercentage;
			var objText_TaxPercentage;
			//End of addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
		//end of Integrated by TruptiK on 19-May-09
			// PURPOSE: To change the active screen.
			if(objDiv!=null)
			{
				if(objActiveDiv!=null)
				{
					
					
						if(objActiveDiv.id != objDiv.id)
						{
							objActiveDiv.style.display = "none";
							objActiveDiv.style.visibility = "hidden";
						
							objDiv.style.display = "block";
							objDiv.style.visibility = "visible";
							//Integrated by TruptiK on 19-May-09
	                        //Addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
							//Purpose : Invoice>Invoice Genaration : For the step no 5 on the page the tax percentage field alignment  
							//          is not proper.(Mozilla)
							if(objDiv.id=='ActiveDiv4')
							{
								for(i=1;i< <%=m_intCounterForTax%> ;i++)
								{
								   objLabel_TaxPercentage =GetObjectReference('frmRFI_InvoiceGeneration','lblTaxPercentage' + i);
								   objText_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + i);
								   								   	   							
								   objLabel_TaxPercentage.style.display = "block";
								   objLabel_TaxPercentage.style.visibility = "visible";
									
								   objText_TaxPercentage.style.display = "none";
								   objText_TaxPercentage.style.visibility = "hidden";	
								}
							}
							//End of addition by SuchitraP on 20-Mar-2009 for IssueID : 29346
							//end of Integrated by TruptiK on 19-May-09
						}
					
				}	
				else
				{
						objDiv.style.display = "block";
						objDiv.style.visibility = "visible";
					
				}
				
				if(objDivList!=null)
				{     
					var intCtr;
					var intLength=objDivList.length;
										 
					var intDivHeight;
					for(intCtr=0;intCtr < intLength;intCtr++)
					{
					   
						intDivHeight = document.body.offsetHeight - objDivList[intCtr].offsetTop - 60;
						if(intDivHeight < 100)
							intDivHeight = 100	// Let the minimum height of the div tag be 100
					
						objDivList[intCtr].style.height = intDivHeight;			
					
					}
				}
				
				objActiveDiv = objDiv;
			}
			
			
		}		
		function ShowSaveLink()
		{
			// PURPOSE: To show the Save link.
			var intCtr;
			
			if("<%=m_blnReadOnly%>"== "False")
			{
				if(objSave!=null)
				{
					for(intCtr = 0; intCtr<=(objSave.length - 1);intCtr++)
					{
						
						objSave[intCtr].style.display = "";
						objSave[intCtr].style.visibility = "visible";
					}
				}
			}
			
			
		}
		
		function Save_OnClick()
        {
			// PURPOSE: To save the Invoice details.
			if(ValidateStep1() == false)
				{
				return;
				}
			if(ValidateStep2() == false)
				{
				return;
				}
				 
			if(ValidateStep3() == false)
				
				{
				 
				return;
				}
			
			if(ValidateStep4() == false)
				{
				
				return;
				}
			if(objcboCustomerID!=null)
			objcboCustomerID.disabled = false;
			
			//// Code Added by RajkumarM to remove Save link after 1st click
			if(objSave!=null)
				{
					for(intCtr = 0; intCtr<=(objSave.length - 1);intCtr++)
					{
						
						objSave[intCtr].style.display = "none";
						objSave[intCtr].style.visibility = "hidden";
					}
				}
		    //// Code Added by RajkumarM to remove Save link after 1st click
		    //Added By Sanyogeeta R on 12-Oct-2016 For Page Loader
		    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
			var MenuTags = document.getElementsByTagName('A');
			for (i = 0; i < MenuTags.length; i++) {
			    if (MenuTags[i].className == "Menu") {
			        //MenuTags[i].style.display= "none";
			        MenuTags[i].parentNode.style.display = "none";
			    }
            }


			setFrameLoader();//ADDED BY Sanyogeeta  R ON 12/2/2016 FOR SAVE ISSUE  
		    // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
		    //End Of Addition By Sanyogeeta R on 12-Oct-2016 For Page Loader
			objform.action = "RFI_InvoiceGeneration.aspx?Action=Save";
			objform.submit();
		
		}
		//Modified By VidyaJ - Security issue - 6197
		function CustomerAddress_OnClick(strtoken)
		{
			// PURPOSE: To open the customer address window.	
			var custID;
			var objCustomerAddress=GetObjectReference('frmRFI_InvoiceGeneration','txtCustomerAddressID');
					custID=0;
					
					if(objCustomerAddress!=null)
						custID=objCustomerAddress.value;
					else
						custID=<%=m_intCustomerAddressID%>;
						
			window.open("../General/CommonPage.aspx?PKToken=" + strtoken + "&FromWhere=SM&MasterTagID=2114&CustomerAddressID=" + custID + "&CustomerID=<%=m_intCustomerID%>&ReadOnly=0", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=500,height=350");						
			
			
		}
		function ValidateStep1()
		{
				
				//Added By ShraddhaM on 3,oct 2006 for IssueID : 6551
				if(navigator.appName == 'Netscape')
				{

				// PURPOSE: To validate controls on screen 1 (Checklist).
				objActiveDiv1=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv1');
				 
				// Get the checkbox object(single item or collection of check boxes).
				var objCheckBox;
				var appendValue;
				appendValue = GetObjectReference('frmRFI_InvoiceGeneration','txtChecklistItemID').value;
				 
				var chkChecklistItemResponse= "chkChecklistItemResponse" + 	appendValue;
				objCheckBox = GetObjectReference('frmRFI_InvoiceGeneration',chkChecklistItemResponse,true);
							 
				var intCtr;
				if(objCheckBox != null)
				{
					
					// Get the number of elements in the collection.
					var intLength;
					intLength = 0;
					intLength = objCheckBox.length; 
					  
					// If more than 1 elements found (then it is a collection)...
					if(intLength >= 1)
					{	
						 
						// For each check box...
						for(intCtr = 0;intCtr<=(intLength - 1);intCtr++)
						{
							// Get the corresponding comments text area...
							var txtComments="txtComments" + appendValue;
							 
							var objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtComments');
							 
							// If the check box is unchecked, comments is mandatory.
							if(objCheckBox[intCtr].checked == false)
							{
								if (disallowBlank(objTextBox,"<%=MyBase.GetResourceString("MSG_COMMENT_BLANK")%>",false))
								{
									
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return false;
								}
							}
							// Check for max length of the comments text area.	
							objTextBox.value = trimString(objTextBox.value);
							if (disallowMaxlengthViolation(objTextBox,2000,"<%=MyBase.GetResourceString("MSG_COMMENT_MAX")%>",false))
							{
								
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return  false;						
							}
						
								
						}
						
					}	
					else
					{	
						
						objCheckBox = GetObjectReference('frmRFI_InvoiceGeneration','chkChecklistItemResponse');
						// Get the corresponding comments text area...
						var objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtComments' + objCheckBox.value);
						// If the check box is unchecked, comments is mandatory.
						if (objCheckBox!=null)
						{
							if(objCheckBox.checked == false)
							{
								
								if (disallowBlank(objTextBox,"<%=MyBase.GetResourceString("MSG_COMMENT_BLANK")%>",false))
								{
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return false;
								}
							}
						}
							
						// Check for max length of the comments text area.
							objTextBox.value = trimString(objTextBox.value);
							if (disallowMaxlengthViolation(objTextBox,2000,"<%=MyBase.GetResourceString("MSG_COMMENT_MAX")%>",false))
							{
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return  false;						
							}
								
					}
					
				}
			
				// Show the Save link.
				ShowSaveLink();				
				
				return true;
	}
	//Ended By ShraddhaM on 3,oct 2006 for IssueID : 6551
				
				else
				{
				////////////////ShraddhaM
				// PURPOSE: To validate controls on screen 1 (Checklist).
				objActiveDiv1=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv1');
				 
				// Get the checkbox object(single item or collection of check boxes).
				var objCheckBox;
				objCheckBox = GetObjectReference('frmRFI_InvoiceGeneration','chkChecklistItemResponse',true);
							 
				var intCtr;
				if(objCheckBox != null)
				{
					
					// Get the number of elements in the collection.
					var intLength;
					intLength = 0;
					intLength = objCheckBox.length; 
					 
					// If more than 1 elements found (then it is a collection)...
					if(intLength > 1)
					{	
						 
						// For each check box...
						for(intCtr = 0;intCtr<=(intLength - 1);intCtr++)
						{
							// Get the corresponding comments text area...
							
							var objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtComments' + objCheckBox[intCtr].value);
							// If the check box is unchecked, comments is mandatory.
							if(objCheckBox[intCtr].checked == false)
							{
								if (disallowBlank(objTextBox,"<%=MyBase.GetResourceString("MSG_COMMENT_BLANK")%>",false))
								{
									
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return false;
								}
							}
							// Check for max length of the comments text area.	
							objTextBox.value = trimString(objTextBox.value);
							if (disallowMaxlengthViolation(objTextBox,2000,"<%=MyBase.GetResourceString("MSG_COMMENT_MAX")%>",false))
							{
								
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return  false;						
							}
						
								
						}
						
					}	
					else
					{	
						
						objCheckBox = GetObjectReference('frmRFI_InvoiceGeneration','chkChecklistItemResponse');
						// Get the corresponding comments text area...
						  
						var objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtComments' + objCheckBox.value);
						// If the check box is unchecked, comments is mandatory.
						if (objCheckBox!=null)
						{
							if(objCheckBox.checked == false)
							{
								
								if (disallowBlank(objTextBox,"<%=MyBase.GetResourceString("MSG_COMMENT_BLANK")%>",false))
								{
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return false;
								}
							}
						}
							
						// Check for max length of the comments text area.
							objTextBox.value = trimString(objTextBox.value);
							if (disallowMaxlengthViolation(objTextBox,2000,"<%=MyBase.GetResourceString("MSG_COMMENT_MAX")%>",false))
							{
									SetAsActiveScreen(objActiveDiv1);
									setFocus(objTextBox);
									return  false;						
							}
								
					}
					
				}
			
				// Show the Save link.
				ShowSaveLink();				
				
				return true;
				}//end of Else of IE
				
			}
			
			function GoToStep2_OnClick()
			{
				// PURPOSE: To go to the next step of invoice generation.
				
				// If all the controls are filled correctly, then go to the next screen.
				 
				if(ValidateStep1() == true)
				{
				 
					objActiveDiv2=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv2');
					 
					SetAsActiveScreen(objActiveDiv2);	
								
				}
					
			}
			
			function cboCustomerContactID_OnChange()
			{
				var intIndex = objCustomerContact.selectedIndex;
				objCustomerContactEmail.selectedIndex=intIndex;
				objEmail.value = objCustomerContactEmail.value;
			}
			
			function ValidateStep2()
			{
				
				objActiveDiv2=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv2');
				// PURPOSE: To validate controls on screen 2 (Invoice Details screen).
				// Validation - Not blank. (Invoice Date)
				var objtxtInvoiceDate	= GetObjectReference('frmRFI_InvoiceGeneration','txtInvoiceDate');
				if (disallowBlank(objtxtInvoiceDate,"<%=MyBase.GetResourceString("MSG_ID_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						return  false;											
				}
				
				// Validation - Invoice Date cannot be a future date.
							
				var objToday=GetObjectReference('frmRFI_InvoiceGeneration','txtCurrentDate');
														
				if (disallowDate1GreaterThanDate2(objtxtInvoiceDate,objToday,"<%=MyBase.GetResourceString("DATE_DIFF")%>",false)) 
				{
					SetAsActiveScreen(objActiveDiv2);
					return false
				}
				
				// Validation - Invoice Date must lie within the open period.
				var objSt=GetObjectReference('frmRFI_InvoiceGeneration','txtSPStartDate');
				var objEnd=GetObjectReference('frmRFI_InvoiceGeneration','txtSPEndDate');
				
				if((objSt.value != "") &&  (objEnd.value != "")==true)
				{
					if((disallowDate1LessThanDate2(objtxtInvoiceDate,objSt,"",false) || disallowDate1GreaterThanDate2(objtxtInvoiceDate,objEnd,"",false))==true)
					{
						SetAsActiveScreen(objActiveDiv2);
						alert(replaceSubstring(replaceSubstring("<%=MyBase.GetResourceString("MSG_ID_SP")%>","<start>",objSt.value),"<end>",objEnd.value));
						return false;
					}
				}
				
				
				// Validation - Not blank. (Due Date)
				var objtxtDueDate	= GetObjectReference('frmRFI_InvoiceGeneration','txtDueDate');
				
				if (disallowBlank(objtxtDueDate,"<%=MyBase.GetResourceString("MSG_DD_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						return  false;											
				}
				
				// Validation - Invoice Date <= Due Date.
				if (disallowDate1LessThanDate2(objtxtDueDate,objtxtInvoiceDate,"<%=MyBase.GetResourceString("DATE_DIFF_ID")%>",false)) 
				{
					SetAsActiveScreen(objActiveDiv2);
					return false
				}
				
				// Validation - Not blank. (Customer)
				var objcboCustomerID=GetObjectReference('frmRFI_InvoiceGeneration','cboCustomerID');
				if (disallowBlank(objcboCustomerID,"<%=MyBase.GetResourceString("MSG_CUST_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						return  false;											
				}
				
				// Validation - Not blank. (Customer Address)
				var objtxtCustomerAddressID=GetObjectReference('frmRFI_InvoiceGeneration','txtCustomerAddressID');
				if (disallowBlank(objtxtCustomerAddressID,"<%=MyBase.GetResourceString("MSG_CUSTADD_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						return  false;											
				}
				
				
				
				// Validation - Not blank. (Billing Currency)
				var objcboBillingCurrencyID =GetObjectReference('frmRFI_InvoiceGeneration','cboBillingCurrencyID');
				if (disallowBlank(objcboBillingCurrencyID,"<%=MyBase.GetResourceString("MSG_CURR_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						return  false;											
				}
					
				// Validation - Not blank. (Contact Person)
				var objcboCustomerContactID=GetObjectReference('frmRFI_InvoiceGeneration','cboCustomerContactID');
				if (disallowBlank(objcboCustomerContactID,"<%=MyBase.GetResourceString("MSG_CONT_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						setFocus(objcboCustomerContactID);
						return  false;											
				}
										
				
				// Validation - Not blank. (Mode of Payment)
				var objcboPaymentModeID=GetObjectReference('frmRFI_InvoiceGeneration','cboPaymentModeID');
				if (disallowBlank(objcboPaymentModeID,"<%=MyBase.GetResourceString("MSG_PAY_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						setFocus(objcboPaymentModeID);
						return  false;											
				}
							
				// Validation - Not blank. (Contract)
				var objcboContractID=GetObjectReference('frmRFI_InvoiceGeneration','cboContractID');
				if (disallowBlank(objcboContractID,"<%=MyBase.GetResourceString("MSG_CONTR_BLANK")%>",false))
				{
						SetAsActiveScreen(objActiveDiv2);
						setFocus(objcboContractID);
						return  false;											
				}
				
				// Validation - At least one item selected.
				if(IsItemSelected("chkRFIItemID") == false)
				{
					
					SetAsActiveScreen(objActiveDiv2);
					alert("<%=MyBase.GetResourceString("MSG_SNG_ITEM")%>");
					return false;
				}
				
				var intItems;
				
				
				if("<%=m_blnMultipleAccounts%>"=="True")
				{
						intItems = 0;
					
					// Get the checkbox element.
					var objCheckbox;
					objCheckbox = GetObjectReference('frmRFI_InvoiceGeneration','chkRFIItemID',true);
					
					// Check if the checkbox exists.
					if(objCheckbox!=null)
					{
					
						// Get the number of checkboxes (it could be a collection, or a single element).
						var intItems=objCheckbox.length;
						
						// If collection exists, then...
						if(intItems > 1 )
						{	
							var intCtr;
							for(intCtr = 0; intCtr<=(objCheckbox.length - 1);intCtr++)
							{
								if(objCheckbox[intCtr].checked ==true)
								{
									var objCombobox=GetObjectReference('frmRFI_InvoiceGeneration','cboAccountID' + objCheckbox[intCtr].value);
									if(objCombobox!=null)
                                    {
                                        //Commented And Added By Usha Pandit On 16.04.2020 For showing validation alert only on respective page
										<%--if (disallowBlank(objCombobox,"<%=MyBase.GetResourceString("MSG_ACC_BLANK")%>",false))
                                        {
											SetAsActiveScreen(objActiveDiv2);
											setFocus(objCombobox);
											return  false;											
                                        }--%>
                                        if ($("#divRFItems").css("visibility") != "hidden") {
                                            if (disallowBlank(objCombobox, "<%=MyBase.GetResourceString("MSG_ACC_BLANK")%>", false)) {
                                                SetAsActiveScreen(objActiveDiv2);
                                                setFocus(objCombobox);
                                                return false;
                                            }
                                        }
                                        else if ($("#divRFItems").css("visibility") == "hidden") {                                            
                                            if ($("#cboAccountID" + objCheckbox[intCtr].value).val() == "") {
                                                SetAsActiveScreen(objActiveDiv2);
                                                return false;
                                            }
                                        }
                                        //End Of Added By Usha Pandit On 16.04.2020 For showing validation alert only on respective page
									}
								}
							}
						}	
						// Else, if single element exists, then...
						else
						{
							objCheckbox = GetObjectReference('frmRFI_InvoiceGeneration','chkRFIItemID');
							if(objCheckbox!=null)
							{
								if(objCheckbox.checked == true)
								{
									var objCombobox = GetObjectReference('frmRFI_InvoiceGeneration','cboAccountID' + objCheckbox.value);
									if(objCombobox!=null)
                                    {
                                        //Commented And Added By Usha Pandit On 16.04.2020 For showing validation alert only on respective page
                                        
                                       <%-- if (disallowBlank(objCombobox, "<%=MyBase.GetResourceString("MSG_ACC_BLANK")%>", false)) {                                            
                                            SetAsActiveScreen(objActiveDiv2);
                                            setFocus(objCombobox);
                                            return false;
                                        }--%>
                                        if ($("#divRFItems").css("visibility") != "hidden") {
                                            if (disallowBlank(objCombobox, "<%=MyBase.GetResourceString("MSG_ACC_BLANK")%>", false)) {

                                                SetAsActiveScreen(objActiveDiv2);
                                                setFocus(objCombobox);
                                                return false;
                                            }
                                        }
                                        else if ($("#divRFItems").css("visibility") == "hidden") {                                            
                                            if ($("#cboAccountID" + objCheckbox.value).val() == "") {
                                                SetAsActiveScreen(objActiveDiv2);
                                                return false;
                                            }
                                        }
                                       
                                        //End Of Added By Usha Pandit On 16.04.2020 For showing validation alert only on respective page
                                        //$("#cboTaxID" + intCtr)
									}
								}
							}				
						}
					
					}	
				}
				
				if(!VerifyCAPAmount()) return false;
				
				return true;
				
			}
			function VerifyCAPAmount()
			{
			    if("<%=m_blnIsCAPAllowed%>"=="True")
				{
				    var dblSelInvoiceAmountItems =0.0;
				    var	objCheckbox = GetObjectReference('frmRFI_InvoiceGeneration','chkRFIItemID',true);
				    var i=0;
				
				    for (i=0;i<objCheckbox.length;i++)
				    {
				      if(objCheckbox[i].checked ==true)
					  {    
					    var objtxtItemBaseAmount=GetObjectReference('frmRFI_InvoiceGeneration','txtItemBaseCurrencyAmount'+ objCheckbox[i].value);
					    if (objtxtItemBaseAmount!=null)
					        dblSelInvoiceAmountItems+=parseFloat(objtxtItemBaseAmount.value);
					  }
				    }
				   
				    if((parseFloat(<%=m_dblTotalInvoiceAmount%>)+parseFloat(dblSelInvoiceAmountItems)) > (<%=m_dblProjectCAPAmount%>))
				    {
				        alert("After generation of this invoice, the total invoice amount [<%=m_strCorporateBaseCurrency%> "+(parseFloat(<%=m_dblTotalInvoiceAmount%>)+parseFloat(dblSelInvoiceAmountItems)) +"] " + '\n' + " will exceed the Cap amount [<%=m_strCorporateBaseCurrency%> <%=m_dblProjectCAPAmount%>]. This invoice cannot be generated !");
				        return false;
				    }
				}
			    return true
				
			}
            function GoBackToStep1_OnClick() {
                // PURPOSE: To go back to the previous step of invoice generation.
                objActiveDiv1 = GetObjectReference('frmRFI_InvoiceGeneration', 'ActiveDiv1');
                // If all the controls are filled correctly, then go to the next screen.
                //Commented And Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button
                //if (ValidateStep2() == true) {
                //    SetAsActiveScreen(objActiveDiv1);
                //}
                SetAsActiveScreen(objActiveDiv1);                
                //End Of Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button
            }			

			function GoToStep3_OnClick()
			{
				// PURPOSE: To go to the next step of invoice generation.
				
				// If all the controls are filled correctly, then go to the next screen.
				if( ValidateStep2() == true)
					SetAsActiveScreen(objActiveDiv3)										
				
			}
			function IsItemSelected(strCheckBoxName)				
			{
				// PURPOSE: To check if any of the check boxes are selected.
				var intItems;
				var intCtr;
				
						
				// Get the checkbox element.
				var  objCheckbox = GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName,true);
				// Check if the checkbox exists.
				if( objCheckbox !=null)
				{
				
					// Get the number of checkboxes (it could be a collection, or a single element).
					intItems = objCheckbox.length;
					
					// If collection exists, then...
					if(intItems > 1 )
					{
						for(intCtr = 0;intCtr<=(objCheckbox.length - 1);intCtr++)
						{
							if(objCheckbox[intCtr].checked == true)
							{
								break;
							}
						}
						
						if(intCtr == objCheckbox.length)
						{
							return false;
						}
					}	
					// Else, if single element exists, then...
					else
					{
						objCheckbox=GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName);
						if(objCheckbox!=null)
						{
						if(objCheckbox.checked == false)
							return false;
						}
						
					}
				}
				else
					return false
				
				return true;
				
			}
			
			function chkRFIItemID_Click(objCheckBox)
			{
				// PURPOSE: To update the total amount field depending on whether the item is selected or deselected.
				
				var dblBaseCurrencyAmount ;
				var dblBillingCurrencyAmount;
				var dblItemBaseCurrencyAmount;
				 //Added and commented by PrashantSJ on 31st July 2006
		        //Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
		        var dblCompanyBaseCurrencyAmount;
				var dblItemCompanyBaseCurrencyAmount;
				
				//End of addition by PrashantSJ on 31st July 2006
				var objTextBox;
				var objtxtBaseCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','txtBaseCurrencyAmount');
				//Added and commented by PrashantSJ on 31st July 2006
		        //Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
				var objtxtCompanyBaseCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','txtCompanyBaseCurrencyAmount');
				var objlblCompanyBaseCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','lblCompanyBaseCurrencyAmount');
				//End of addition by PrashantSJ on 31st July 2006
				var objtxtBillingCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','txtBillingCurrencyAmount');
				var objlblBaseCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','lblBaseCurrencyAmount');
				var objlblBillingCurrencyAmount=GetObjectReference('frmRFI_InvoiceGeneration','lblBillingCurrencyAmount');
				
				
				dblBaseCurrencyAmount=objtxtBaseCurrencyAmount.value;
				
				if(dblBaseCurrencyAmount == "")
					dblBaseCurrencyAmount = 0;
				//Added and commented by PrashantSJ on 31st July 2006
		        //Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
		        dblCompanyBaseCurrencyAmount=objtxtCompanyBaseCurrencyAmount.value;
		        
				if(dblCompanyBaseCurrencyAmount == "")
					dblCompanyBaseCurrencyAmount = 0;	
				
				//End of addition by PrashantSJ on 31st July 2006		
				dblBillingCurrencyAmount = objtxtBillingCurrencyAmount.value
				
				if(dblBillingCurrencyAmount == "")
					dblBillingCurrencyAmount = 0;
					
							
				//objCheckBox = window.event.srcElement;
				
				
				
				if(objCheckBox!=null)
				{
					
					// Get the corresponding base currency amount of the Item.
					objTextBox=GetObjectReference('frmRFI_InvoiceGeneration','txtItemBaseCurrencyAmount'+ objCheckBox.value);
					if(objTextBox!=null)
					{
						
						dblItemBaseCurrencyAmount = objTextBox.value;
						if(dblItemBaseCurrencyAmount == "")
							dblItemBaseCurrencyAmount = 0;
									
						
						// Now either add/subtract the item amount from the invoice amount depending on whether the checkbox is checked / unchecked.							
						
						if(objCheckBox.checked == true)
							dblBaseCurrencyAmount = parseFloat(dblBaseCurrencyAmount) + parseFloat(dblItemBaseCurrencyAmount);
						else
							dblBaseCurrencyAmount = parseFloat(dblBaseCurrencyAmount) - parseFloat(dblItemBaseCurrencyAmount);
						
						
					}
		//Code Integrated by TruptiK on 8-Apr-09
				 //Code added by RajkumarM On 12 March 2009 for PiTech 8.0 Integration
					//For Pitech Discount customization.
					if(dblBaseCurrencyAmount < 0)
					{
						alert("Invoice can not be generated with negative value. Amount = " + dblBaseCurrencyAmount);
						if (parseFloat(dblItemBaseCurrencyAmount) > 0)
							objCheckBox.checked = true;
						else
							objCheckBox.checked = false;
							
								return;			
					}	
					//Added and commented by PrashantSJ on 31st July 2006
					//Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
					
					objTextBox=GetObjectReference('frmRFI_InvoiceGeneration','txtItemCompanyBaseCurrencyAmount'+ objCheckBox.value);
					
					if(objTextBox!=null)
					{
						dblItemCompanyBaseCurrencyAmount = objTextBox.value;
						if(dblItemCompanyBaseCurrencyAmount == "")
							dblItemCompanyBaseCurrencyAmount = 0;	
							
						// Now either add/subtract the item amount from the invoice (Company base) amount depending on whether the checkbox is checked / unchecked.							
						
						if(objCheckBox.checked == true)
							
							dblCompanyBaseCurrencyAmount=parseFloat(dblCompanyBaseCurrencyAmount) + parseFloat(dblItemCompanyBaseCurrencyAmount);
						else
							dblCompanyBaseCurrencyAmount=parseFloat(dblCompanyBaseCurrencyAmount) - parseFloat(dblItemCompanyBaseCurrencyAmount);
							
					}
					//End of addition by PrashantSJ on 31st July 2006	
					// Get the corresponding Billing currency amount of the Item.
					
				
					
					objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtItemBillingCurrencyAmount'+ objCheckBox.value);
					
					if(objTextBox !=null)
					{
						
						dblItemBillingCurrencyAmount = objTextBox.value;
						if(dblItemBillingCurrencyAmount == "")
							dblItemBillingCurrencyAmount = 0;
						
						// Now either add/subtract the item amount from the invoice amount depending on whether the checkbox is checked / unchecked.							
						if(objCheckBox.checked == true)
							dblBillingCurrencyAmount = parseFloat(dblBillingCurrencyAmount) + parseFloat(dblItemBillingCurrencyAmount);
						else
							dblBillingCurrencyAmount = parseFloat(dblBillingCurrencyAmount) - parseFloat(dblItemBillingCurrencyAmount);
						
						
					}									
					
					// Enable/Disable the Accounts combo box if present.
					
					objComboBox = GetObjectReference('frmRFI_InvoiceGeneration','cboAccountID'+ objCheckBox.value);
					if(objComboBox!=null)
					{
						if(objCheckBox.checked == true)
							objComboBox.disabled = false;
						else
							objComboBox.disabled = true;							
						
					}
					
				}
				
				objtxtBaseCurrencyAmount.value = dblBaseCurrencyAmount;
				objlblBaseCurrencyAmount.innerHTML = Math.round(dblBaseCurrencyAmount*100)/100;
				//Added and commented by PrashantSJ on 31st July 2006
				//Purpose: To Display Company (IR) Base currency amount in Invoice Item details page.
				objtxtCompanyBaseCurrencyAmount.value=dblCompanyBaseCurrencyAmount
				objlblCompanyBaseCurrencyAmount.innerText=Math.round(dblCompanyBaseCurrencyAmount*100)/100;
				//End of addition by PrashantSJ on 31st July 2006	
				objtxtBillingCurrencyAmount.value = dblBillingCurrencyAmount;
				objlblBillingCurrencyAmount.innerHTML = Math.round(dblBillingCurrencyAmount*100)/100;
				
			}
			
			
			
			function ValidateSalesCommission(objTextBox)
			{
				// PURPOSE: To validate the 'Sales Commission %' text box.
							
				// Validation - Not Blank.
				
				if (disallowBlank(objTextBox,"<%=MyBase.GetResourceString("MSG_SC_BLANK")%>",false))
				{
							
							SetAsActiveScreen(objActiveDiv3);
							setFocus(objTextBox);
							return  false;											
				}
				
				 
				// Validation - Is Numeric.
			
				if (disallowNonNumeric(objTextBox,"<%=MyBase.GetResourceString("MSG_SC_NUMERIC")%>",false))
				{
							
							SetAsActiveScreen(objActiveDiv3);
							setFocus(objTextBox);
							return  false;											
				}
							
				// Validation - Value range [0 < n <=100].
				if (disallowValueRangeViolation(objTextBox,0,100,"<%=MyBase.GetResourceString("MSG_SC_RANGE")%>",false,false))
				{
				           
							SetAsActiveScreen(objActiveDiv3);
							setFocus(objTextBox);
							return  false;											
				}
				
				return true;
			
			}
			function ValidateStep3()
			{
			 
				
				// PURPOSE: To validate controls on screen 3 (Sales Commission screen).			
				objActiveDiv3=GetObjectReference('frmRFI_InvoiceGeneration','ActiveDiv3');	
					 
				// Get the checkbox object(single item or collection of check boxes).
				var objCheckBox=GetObjectReference('frmRFI_InvoiceGeneration','chkSalesPersonID',true);	
			 
				if(objCheckBox!=null)
				{
					
					// Get the number of elements in the collection.
					var intLength;
					intLength = 0;
					intLength = objCheckBox.length;
					 
					// If more than 1 elements found (then it is a collection)...
					if(intLength > 0)
					{
						 
						// For each check box...
						var intCtr;
						for( intCtr = 0;intCtr<=(intLength - 1);intCtr++)
						{													
							if(objCheckBox[intCtr].checked == true)
							{
								// Get the corresponding 'Sales Commission %' text box...
								var objTextBox=GetObjectReference('frmRFI_InvoiceGeneration','txtSalesCommissionPercentage'+ objCheckBox[intCtr].value );
								
								if (ValidateSalesCommission(objTextBox)==false)
										return false;
							}
						}
							
					}
					/*else
					{
						objCheckBox=GetObjectReference('frmRFI_InvoiceGeneration','chkSalesPersonID');	
						 
						if(objCheckBox!=null)
						{
						if(objCheckBox.checked == true)
						{
							// Get the corresponding 'Sales Commission %' text box...
							var objTextBox=GetObjectReference('frmRFI_InvoiceGeneration','txtSalesCommissionPercentage'+ objCheckBox.value );
								if(ValidateSalesCommission(objTextBox)==false)
								return false;
						}
						}
					}*/
					
				}
				
				return true;
			}
            function GoBackToStep2_OnClick() {
                // PURPOSE: To go back to the previous step of invoice generation.

                // If all the controls are filled correctly, then go to the next screen.
                //Commented And Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button
                //if (ValidateStep3() == true) {
                //    SetAsActiveScreen(objActiveDiv2);
                //}

                SetAsActiveScreen(objActiveDiv2);
                //End Of Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button
            }
			
			function GoToStep4_OnClick()
			{
				// PURPOSE: To go to the next step of invoice generation.
				 
				// If all the controls are filled correctly, then go to the next screen.
				if(ValidateStep3() ==true)
					SetAsActiveScreen(objActiveDiv4);					
			}
			//Integrated by TruptiK on 19-May-09
				//Comment and Modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
			//Invoice>invoice Generation> User is not able to edit the sales commission .(Mozilla)
			//function chkSalesPersonID_Click()
			function chkSalesPersonID_Click(obj)
			//End of Comment and modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
			//Integrated by TruptiK on 19-May-09
			{
				// PURPOSE: To enable the sales comm % text box.
				//Integrated by TruptiK on 19-May-09
			//Comment and Modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
				//Invoice>invoice Generation> User is not able to edit the sales commission .(Mozilla)
				//var objCheckBox = window.event.srcElement;
				var objCheckBox = GetObjectReference('frmRFI_InvoiceGeneration','chkSalesPersonID'+ obj);
				//if(objCheckBox!=null)
				if(obj!=null)
				//End of Comment and modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
				//Integrated by TruptiK on 19-May-09
				{	
				    //Comment and Modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
					//Invoice>invoice Generation> User is not able to edit the sales commission .(Mozilla)		
					//var objTextBox =GetObjectReference('frmRFI_InvoiceGeneration','txtSalesCommissionPercentage'+ objCheckBox.value);	
					var objTextBox = GetObjectReference('frmRFI_InvoiceGeneration','txtSalesCommissionPercentage'+ obj);	
					//End of Comment and modification by SuchitraP on 19-Mar-2009 for IssueID: 29345
					//end of Integrated by TruptiK on 19-May-09
					var intLength=objTextBox.length;
					if(objTextBox!=null)
					{
						if(objCheckBox.checked == true) 
							objTextBox.disabled = false;						
						else					
							objTextBox.disabled = true;					
									
					}
				
				}
			}
			
			function ValidateStep4()
			{
				// PURPOSE: To validate controls on screen 4 (Tax Details).	
						
				var objTaxID
				var objTaxPercentage
				var intCtr;
				for(intCtr = 1;intCtr<5;intCtr++)
				{
					objTaxID=GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intCtr);	
					objTaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intCtr);
                   
                    //Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
                    //if((objTaxID !=null) || (objTaxPercentage!=null)==true)
                    if ((objTaxID != null && $("#cboTaxID" + intCtr).css("display") != "none") || ((objTaxPercentage != null) == true) && $("#txtTaxPercentage" + intCtr).css("display") != "none") {
                        //End Of Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
                        if ($("#ActiveDiv4").css("display") != "none") {
                            if ((objTaxID.disabled == true) || (trimString(objTaxID.value) == "")) {
                                //Added by MonikaI on 28-Sep-2006 IssueID : 6500											
                                // Validation : if Tax % is not blank then Tax combo should not be blank
                                //Commented And Added By Usha Pandit On 17.04.2020 To provide Tax validation first
                                //if (objTaxPercentage.value > 0 && objTaxID.selectedIndex == 0) {
                                if (objTaxID.selectedIndex == 0) {
                                    //End Of Added By Usha Pandit On 17.04.2020 To provide Tax validation first                                
                                    alert('Tax can not be blank.');
                                    SetAsActiveScreen(objActiveDiv4);
                                    //AddOrEdit_OnClick(intCtr);
                                    setFocus(objTaxID);
                                    return false;
                                    //End of addition by MonikaI
                                }
                                else {
                                    break;
                                }
                            }
                        }

                        // Validation : Not Blank (Tax %)
                        if ($("#ActiveDiv4").css("display") != "none") {
                            if (disallowBlank(objTaxPercentage, "<%=MyBase.GetResourceString("MSG_TP_BLANK")%>", false)) {
                                SetAsActiveScreen(objActiveDiv4);
                                //AddOrEdit_OnClick(intCtr);
                                return false;
                            }
                        }

                        // Validation : Is Numeric (Tax %)
                        if (disallowNonNumeric(objTaxPercentage, "<%=MyBase.GetResourceString("MSG_NUM_TP")%>", false)) {
                            SetAsActiveScreen(objActiveDiv4);
                            //AddOrEdit_OnClick(intCtr);
                            return false;
                        }

                        // Validation : Valid Range (Tax %)
                        if (disallowValueRangeViolation(objTaxPercentage, 0, 100, "<%=MyBase.GetResourceString("MSG_TP_RANGE")%>", false)) {
                            SetAsActiveScreen(objActiveDiv4);
                            //AddOrEdit_OnClick(intCtr);
                            return false;
                        }

                    }				
										
				}
				
				if(intCurrentTaxNumber > 0)
				{
					if(ApplyFromValidate(intCurrentTaxNumber)==false)
					return false;
				}
						
				
								
				return true;
				
			}
			
            function GoBackToStep3_OnClick() {
                // PURPOSE: To go back to the previous step of invoice generation.

                // If all the controls are filled correctly, then go to the next screen.
                //Commented And Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button
                //if (ValidateStep4() == true)
                //    SetAsActiveScreen(objActiveDiv3);              
                SetAsActiveScreen(objActiveDiv3);
                $('*[id*=cboTaxID]').each(function () {
                    var curid = $(this).attr("id");
                    curid = curid.replace("cboTaxID", "");
                   
                    if ($(this).css("display") == "block" && $(this).css("visibility") == "visible") {
                        $(this).css("display", "none");
                        $(this).attr("visibility", "hidden");
                        var objLabel_AddOrEdit = GetObjectReference('frmRFI_InvoiceGeneration', 'lblAddOrEdit' + curid);
                        objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + curid + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + "</A>"
                    }
                });
                $('*[id*=txtTaxPercentage]').each(function () {
                    var curid = $(this).attr("id");
                    curid = curid.replace("cboTaxID", "");
                    if ($(this).css("display") == "block" && $(this).css("visibility") == "visible") {
                        $(this).css("display", "none");
                        $(this).attr("visibility", "hidden");
                    }
                });
                intCurrentTaxNumber = 0;
                //End Of Added By Usha Pandit On 16.04.2020 For showing validation alert only if click on save or next button				
            }
			function cboTaxID_OnChange(intTaxNumber)
			{
				// PURPOSE: To apply the standard tax percentage.
				
				var objTaxID			= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intTaxNumber);
				var objTaxAttributes	= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxAttributes' + intTaxNumber);	
				var objTaxPercentage	= GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intTaxNumber);
				var objTaxFormula		= GetObjectReference('frmRFI_InvoiceGeneration','lblTaxFormula' + intTaxNumber);
				var objLabel_TaxID		= 	GetObjectReference('frmRFI_InvoiceGeneration','lblTaxID' + intTaxNumber);					
				var objLabel_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','lblTaxPercentage' + intTaxNumber);		
				
				if((objTaxID !=null) || (objTaxAttributes !=null) || (objTaxPercentage !=null)==true)
				{
						
					objTaxAttributes.selectedIndex = objTaxID.selectedIndex;	
					
								
					if(trimString(objTaxID.value) != "") 
					{
						
						
						objTaxPercentage.value = objTaxAttributes.options[objTaxAttributes.selectedIndex].value;							
						
						objTaxFormula.innerHTML = objTaxAttributes.options[objTaxAttributes.selectedIndex].innerHTML;	
						
						objLabel_TaxID.innerHTML = objTaxID.options[objTaxID.selectedIndex].innerHTML;	
											
						objLabel_TaxPercentage.innerHTML = objTaxPercentage.value;
					}
					else					
					{	
							
						//objTaxPercentage.value = "";
						//objTaxFormula.innerHTML = "";							
						//objLabel_TaxID.innerHTML = "";
						//objLabel_TaxPercentage.innerHTML = "";
					}
				}	
			
				
            }
            //Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
            function Cancel_OnClick(intTaxNumber, curMode) {
                $("#cboTaxID" + intTaxNumber).css("display", "none");
                $("#txtTaxPercentage" + intTaxNumber).css("display", "none");
                $("#cboTaxID" + intTaxNumber).attr("visibility", "hidden");
                $("#txtTaxPercentage" + intTaxNumber).attr("visibility", "hidden");
                var objLabel_TaxID = 	GetObjectReference('frmRFI_InvoiceGeneration','lblTaxID' + intTaxNumber);

                var objLabel_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration', 'lblTaxPercentage' + intTaxNumber);

                objLabel_TaxID.style.display = "block";
                objLabel_TaxID.style.visibility = "visible";

                objLabel_TaxPercentage.style.display = "block";
                objLabel_TaxPercentage.style.visibility = "visible";

                var objLabel_AddOrEdit = GetObjectReference('frmRFI_InvoiceGeneration', 'lblAddOrEdit' + intTaxNumber);	
               
                
                if (curMode == "Add") {
                    objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + "</A>";
                }
                if (curMode == "Edit") {
                    objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("EDIT")%>" + "</A>";
                }
                intCurrentTaxNumber=0;
            }
            //End Of Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
			function AddOrEdit_OnClick(intTaxNumber)
			{
				if(intCurrentTaxNumber > 0)
					{
							Apply_OnClick(intCurrentTaxNumber);
					}
				
				var objLabel_AddOrEdit = GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + intTaxNumber);		
				
				var objLabel_TaxID = 	GetObjectReference('frmRFI_InvoiceGeneration','lblTaxID' + intTaxNumber);
				var objCombo_TaxID = GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intTaxNumber);
				
				var objLabel_TaxPercentage =GetObjectReference('frmRFI_InvoiceGeneration','lblTaxPercentage' + intTaxNumber);
				var objText_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intTaxNumber);
				
				if(objLabel_AddOrEdit.innerHTML != "<%=MyBase.GetResourceString("N/A")%>")
				{
					
					intCurrentTaxNumber = intTaxNumber;
								
					objLabel_TaxID.style.display = "none";
					objLabel_TaxID.style.visibility = "hidden";
				
					objCombo_TaxID.style.display = "block";
					objCombo_TaxID.style.visibility = "visible";
				
					objLabel_TaxPercentage.style.display = "none";
					objLabel_TaxPercentage.style.visibility = "hidden";
					
					
				
					objText_TaxPercentage.style.display = "block";
					objText_TaxPercentage.style.visibility = "visible";												
					var curMode = $("#lblAddOrEdit" + intTaxNumber).find("a").text();
				//Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
					//objLabel_AddOrEdit.innerHTML = "<A href='javascript:Apply_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("APPLY")%>" + "</A>";
                    //Commented And Added By Usha Pandit On 16.04.2020 For showing cross and correct ticks
                    //objLabel_AddOrEdit.innerHTML = "<A href='javascript:Apply_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("APPLY")%>" + "</A> <A href='javascript:Cancel_OnClick(" + intTaxNumber + ")'>" + "Cancel" + "</A>"
                    if (curMode == undefined || curMode == null) {
                        curMode = "";
                    }
                    objLabel_AddOrEdit.innerHTML = "<button data-toggle='modal' onclick='Apply_OnClick(" + intTaxNumber + ")' class='btn btn-outline-secondary' type='button' data-placement='top' title=''><i class='fas fa-check'></i></button>&nbsp;<button data-toggle='modal' onclick='Cancel_OnClick(" + intTaxNumber + ",&quot;" + curMode + "&quot;)' class='btn btn-outline-secondary' type='button' data-placement='top' title=''><i class='fas fa-times'></i></button>";
                    //End Of Added By Usha Pandit On 16.04.2020 For showing cross and correct ticks
                    //End Of Added By Usha Pandit On 19.02.2020 To provide facility for cancel button
				}
				
			}
			function ApplyFromValidate(intTaxNumber)
            {
				var objLabel_AddOrEdit = GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + intTaxNumber);		
				
				var objLabel_TaxID = 	GetObjectReference('frmRFI_InvoiceGeneration','lblTaxID' + intTaxNumber);
				var objCombo_TaxID = GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intTaxNumber);
				
				var objLabel_TaxPercentage =GetObjectReference('frmRFI_InvoiceGeneration','lblTaxPercentage' + intTaxNumber);
				var objText_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intTaxNumber);
			
						
				/*Set objTaxID = frmInvoice.all.item("txtTaxPercentage" + intCtr);
				Set objTaxPercentage = frmInvoice.all.item("txtTaxPercentage" + intCtr);*/
						
				// Validation : Not Blank (Tax %)
				if (disallowBlank(objText_TaxPercentage,"<%=MyBase.GetResourceString("MSG_TP_BLANK")%>",false))
				{
					
					SetAsActiveScreen(objActiveDiv4);
					setFocus(objText_TaxPercentage);
					return false;											
				}
				
				
				// Validation : Is Numeric (Tax %)
				if (disallowNonNumeric(objText_TaxPercentage,"<%=MyBase.GetResourceString("(MSG_NUM_TP)")%>",false))
				{
					SetAsActiveScreen(objActiveDiv4);
					setFocus(objText_TaxPercentage);
					return false;	
				}
			
						
				// Validation : Valid Range (Tax %)
				if (disallowValueRangeViolation(objText_TaxPercentage,0,100,"<%=MyBase.GetResourceString("MSG_TP_RANGE")%>",false))
				{
						SetAsActiveScreen(objActiveDiv4);
						setFocus(objText_TaxPercentage);
						return false;									
				}
			
								
				objLabel_TaxID.style.display = "block";
				objLabel_TaxID.style.visibility = "visible";
				
				objCombo_TaxID.style.display = "none";
				objCombo_TaxID.style.visibility = "hidden";
				
				objLabel_TaxPercentage.style.display = "block";
				objLabel_TaxPercentage.style.visibility = "visible";
				
				objText_TaxPercentage.style.display = "none";
				objText_TaxPercentage.style.visibility = "hidden";
				
				if(objCombo_TaxID.selectedIndex != -1)
					objLabel_TaxID.innerHTML = objCombo_TaxID.options[objCombo_TaxID.selectedIndex].innerHTML;
				else
					objLabel_TaxID.innerHTML = "";
								
				objLabel_TaxPercentage.innerHTML = objText_TaxPercentage.value;	
							
				if(trimString(objLabel_TaxID.innerHTML) == "")
				{
				
					objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + "</A>"					
					
					// Disable all the Tax combo boxes that come after the selected tax combo.
					for(intCtr =( intTaxNumber + 1);intCtr<=5;intCtr++)
					{					
						var objTaxID			= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intCtr);		
						var objTaxAttributes	= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxAttributes' + intCtr);
						var objTaxPercentage	= GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intCtr);	
						var objTaxFormula		= GetObjectReference('frmRFI_InvoiceGeneration','lblTaxFormula' + intCtr);											
						var objAddOrEdit		= GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + intCtr);
						
						if(objAddOrEdit!=null)
						{
							objTaxID.selectedIndex = -1;							
							objTaxAttributes.selectedIndex = -1;							
							cboTaxID_OnChange(intCtr);							
							objTaxPercentage.value = "";
							objTaxFormula.innerHTML = "";
							objAddOrEdit.innerHTML = "<%=MyBase.GetResourceString("N/A")%>";								
						}
						
					}
					
				}
				else
				{			
					
					objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("EDIT")%>" + "</A>"
					var objLabel_NextAddOrEdit =GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + (intTaxNumber + 1));		
					if(objLabel_NextAddOrEdit!=null)
					{						
						if(objLabel_NextAddOrEdit.innerHTML == "<%=MyBase.GetResourceString("N/A")%>")
							objLabel_NextAddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + ( intTaxNumber + 1 ) + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + " </A>"				
						
					}
					
					
				}
			}
			
			function Apply_OnClick(intTaxNumber)
			{
				
				var objLabel_AddOrEdit = GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + intTaxNumber);		
				
				var objLabel_TaxID = 	GetObjectReference('frmRFI_InvoiceGeneration','lblTaxID' + intTaxNumber);
				var objCombo_TaxID = GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intTaxNumber);
				
				var objLabel_TaxPercentage =GetObjectReference('frmRFI_InvoiceGeneration','lblTaxPercentage' + intTaxNumber);
				var objText_TaxPercentage = GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intTaxNumber);
			
						
				/*Set objTaxID = frmInvoice.all.item("txtTaxPercentage" + intCtr);
				Set objTaxPercentage = frmInvoice.all.item("txtTaxPercentage" + intCtr);*/

                //Added By Usha Pandit On 17.04.2020 To provide Tax validation first
                // Validation : if Tax % is not blank then Tax combo should not be blank
                if (objCombo_TaxID.selectedIndex == 0)
				{
					alert ('Tax can not be blank.');
					SetAsActiveScreen(objActiveDiv4);
					setFocus(objCombo_TaxID);
					return  ;	
                }	
                //End Of Added By Usha Pandit On 17.04.2020 To provide Tax validation first

				// Validation : Not Blank (Tax %)
                if (disallowBlank(objText_TaxPercentage, "<%=MyBase.GetResourceString("MSG_TP_BLANK")%>", false))
				{
					
					SetAsActiveScreen(objActiveDiv4);
					setFocus(objText_TaxPercentage);
					return ;											
				}
				
				
				// Validation : Is Numeric (Tax %)
				if (disallowNonNumeric(objText_TaxPercentage,"<%=MyBase.GetResourceString("MSG_NUM_TP")%>",false))
				{
					SetAsActiveScreen(objActiveDiv4);
					setFocus(objText_TaxPercentage);
					return ;	
				}
			
						
				// Validation : Valid Range (Tax %)
                if (disallowValueRangeViolation(objText_TaxPercentage, 0, 100, "<%=MyBase.GetResourceString("MSG_TP_RANGE")%>", false)) {
                    SetAsActiveScreen(objActiveDiv4);
                    setFocus(objText_TaxPercentage);
                    return;
                }
			
	            //Added by MonikaI on 28-Sep-2006 IssueID : 6500											
				// Validation : if Tax % is not blank then Tax combo should not be blank
                //Commented By Usha Pandit On 17.04.2020 To provide Tax validation first
                //if (objText_TaxPercentage.value > 0 && objCombo_TaxID.selectedIndex == 0)
				//{
				//	alert ('Tax can not be blank.');
				//	SetAsActiveScreen(objActiveDiv4);
				//	setFocus(objCombo_TaxID);
				//	return  ;	
				//}
                //End Of Commented By Usha Pandit On 17.04.2020 To provide Tax validation first
	//End of addition by MonikaI
								
				objLabel_TaxID.style.display = "block";
				objLabel_TaxID.style.visibility = "visible";
				
				objCombo_TaxID.style.display = "none";
				objCombo_TaxID.style.visibility = "hidden";
				
				objLabel_TaxPercentage.style.display = "block";
				objLabel_TaxPercentage.style.visibility = "visible";
				
				objText_TaxPercentage.style.display = "none";
				objText_TaxPercentage.style.visibility = "hidden";
				
				if(objCombo_TaxID.selectedIndex != -1)
					objLabel_TaxID.innerHTML = objCombo_TaxID.options[objCombo_TaxID.selectedIndex].innerHTML;
				else
					objLabel_TaxID.innerHTML = "";
								
				objLabel_TaxPercentage.innerHTML = objText_TaxPercentage.value;	
							
				
				if(trimString(objLabel_TaxID.innerHTML) == "")
				{				    
                    objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + "</A>"					                    
					
					// Disable all the Tax combo boxes that come after the selected tax combo.
					for(intCtr =( intTaxNumber + 1);intCtr<=5;intCtr++)
					{					
						
						var objTaxID			= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxID' + intCtr);		
						var objTaxAttributes	= GetObjectReference('frmRFI_InvoiceGeneration','cboTaxAttributes' + intCtr);
						var objTaxPercentage	= GetObjectReference('frmRFI_InvoiceGeneration','txtTaxPercentage' + intCtr);	
						var objTaxFormula		= GetObjectReference('frmRFI_InvoiceGeneration','lblTaxFormula' + intCtr);											
						var objAddOrEdit		= GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + intCtr);
						
						if(objAddOrEdit!=null)
						{
							objTaxID.selectedIndex = -1;							
							objTaxAttributes.selectedIndex = -1;							
							cboTaxID_OnChange(intCtr);							
							objTaxPercentage.value = "";
							objTaxFormula.innerHTML = "";
							objAddOrEdit.innerHTML = "<%=MyBase.GetResourceString("N/A")%>";								
						}
						
					}
					
				}
				else
				{
					objLabel_AddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + intTaxNumber + ")'>" + "<%=MyBase.GetResourceString("EDIT")%>" + "</A>"
                    
					var objLabel_NextAddOrEdit =GetObjectReference('frmRFI_InvoiceGeneration','lblAddOrEdit' + (intTaxNumber + 1));		
					
					if(objLabel_NextAddOrEdit!=null)
					{						
						if(objLabel_NextAddOrEdit.innerHTML == "<%=MyBase.GetResourceString("N/A")%>")
							objLabel_NextAddOrEdit.innerHTML = "<A href='javascript:AddOrEdit_OnClick(" + ( intTaxNumber + 1 ) + ")'>" + "<%=MyBase.GetResourceString("ADD")%>" + " </A>"				
						
					}
					
					
				}
				
			}
			function SelectAll_OnClick(strCheckBoxName)				
			{
				
				// PURPOSE: To check all the combo boxes.
				var intItems
				var blnPrevState;
				// Get the checkbox element.
				var objCheckbox =GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName,true);
				 
				
				// Check if the checkbox exists.
				if(objCheckbox!=null)
				{
				
					// Get the number of checkboxes (it could be a collection, or a single element).
					var intItems;
					intItems = objCheckbox.length;
									
					// If collection exists, then...
					if(intItems > 1 )
					{
						var intCtr;
						for(intCtr = 0;intCtr<=(objCheckbox.length - 1);intCtr++)
						{
							if(objCheckbox[intCtr].disabled == false)
							{
																
								blnPrevState = objCheckbox[intCtr].checked;
								objCheckbox[intCtr].checked = true;
								
								if (blnPrevState != objCheckbox[intCtr].checked )
									chkRFIItemID_Click(objCheckbox[intCtr]);
								
							}
						}
					}
					// Else, if single element exists, then...
					else
					{
						objCheckbox =GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName);
						//added by harshada d for Whiziblesem SP7 on 18 July 2006 -- if not even single element exists i.e. object is null
						if(objCheckbox !=null)
						{
						//end of addition by harshada d for whiziblesem SP7 on 18 th July 2006
						
						if( objCheckbox.disabled == false)
						{
							
							
							blnPrevState = objCheckbox.checked;
							
								
							objCheckbox.checked = true;
							
							
							if( blnPrevState != objCheckbox.checked)
								 chkRFIItemID_Click(objCheckbox);
							
							
						}
						//added by harshada d for Whiziblesem SP7 on 18 July 2006 -- if not even single element exists i.e. object is null
						}
					//end of addition by harshada d for whiziblesem SP7 on 18 th July 2006
					}
					
				}
				
			}
			///PrashantSJ on 01 Aug 2007
				function SelectSalesPeriod()
				{
				var objtxtCreditDays=GetObjectReference('frmRFI_InvoiceGeneration','txtCreditDays');
				
				window.open("../RFI/RFI_SalesPeriod_CommonList.aspx?FromWhere=FA&CreditDays="+objtxtCreditDays.value+"&MasterTagID=3814","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=750,height=300");
				}
			///End of addition by PrashantSJ on 01 Aug 2006	
			function ClearAll_OnClick(strCheckBoxName)				
			{
				
				// PURPOSE: To check all the combo boxes.
				var intItems
				var blnPrevState;
				// Get the checkbox element.
				var objCheckbox =GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName,true);
				
				// Check if the checkbox exists.
				if(objCheckbox !=null)
				{
					
					var intItems;
					// Get the number of checkboxes (it could be a collection, or a single element).
					intItems = objCheckbox.length;
						
					// If collection exists, then...
					if(intItems > 1)
					{
						var intCtr;
						for( intCtr = 0 ;intCtr<=(objCheckbox.length - 1);intCtr++)
						{
							if(objCheckbox[intCtr].disabled == false)
							{
							
								blnPrevState = objCheckbox[intCtr].checked;
														
								objCheckbox[intCtr].checked = false;
								
								if(blnPrevState != objCheckbox[intCtr].checked)
								 chkRFIItemID_Click(objCheckbox[intCtr]);
								
							}
						}
					}
					// Else, if single element exists, then...
					else
					{
						objCheckbox =GetObjectReference('frmRFI_InvoiceGeneration',strCheckBoxName);
						//added by harshada d for Whiziblesem SP7 on 18 July 2006 -- if not even single element exists i.e. object is null
						if(objCheckbox !=null)
						{
						//end of addition by harshada d for whiziblesem SP7 on 18 th July 2006
						if(objCheckbox.disabled == false)
						{
							
							blnPrevState = objCheckbox.checked;
													
							objCheckbox.checked = false;
							
							
							if(blnPrevState != objCheckbox.checked )
								 chkRFIItemID_Click(objCheckbox);
							
							
						}
					//added by harshada d for Whiziblesem SP7 on 18 July 2006 -- if not even single element exists i.e. object is null
						}
					//end of addition by harshada d for whiziblesem SP7 on 18 th July 2006
					}
					
				}
				
			}
			
				
			
		</Script>
	</body>
</HTML>
