<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EWF_WeeklyView.aspx.vb" Inherits="PbNIT.EWF_WeeklyView"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Expense Details")%>



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
		<form id="frmEWF_WeeklyView" method="post" runat="server">

			<%PageInit%>
		</form>
          <link href="../General/loaderStylesheet.css" rel="stylesheet" />
        <%-- COMMENTED BY nILESH G ON 17/12/2015 --%>
       <%-- <%If m_strBrowserName = "IE" Or m_strBrowserName = "Microsoft Internet Explorer" Then%>--%>
		<%--<%If m_strBrowserName = "IE" Or m_strBrowserName = "Microsoft Internet Explorer" Or m_strBrowserName = "InternetExplorer" Then%>  <%--added by Shamkant S on 15 Dec 2015--%>
		<Script language="javascript">
		//Modified by SantoshK on Date July 05,2006 for WhizibleSEM Issue ID.4168
		var strResult = new String();
		var arrElements = new Array();
		var arrRows = new Array();
		var arrRowData = new Array();
		var arrRowsData = new Array();
		var intCounter;
		//End of modification by SantoshK on July 05,2006 Isse ID.4168
		var objform=GetFormReference('frmEWF_WeeklyView');
		var objdivlist=GetObjectReference('frmEWF_WeeklyView','DivList');
		
		var objDivMain=GetObjectReference('frmEWF_WeeklyView','DivMain');
		//The div tag has id as PageDiv 
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		    var Browser = isIE();
		function window_onload()
		{
            
			var intDivHeight ;
			var intDivHeightRisk;
			
			if (objdivlist !=null) 
			{
			    if(Browser=='IE')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			    		        
			    else
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			    if (intDivHeight < 100)	intDivHeight = 100;
		
			    objdivlist.style.height = intDivHeight +'px';	
			  
			   
			}	
		    //ADDED BY NILESH G ON 17/12/2015
			if (objDivMain !=null) 
			{
			    if(Browser=='IE')
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 42;
			    		        
			    else
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
			    if (intDivHeight < 100)	intDivHeight = 100;
		
			    objDivMain.style.height = intDivHeight +'px';	
			 		   
			}
		    //ENDDED BY NILESH G ON 17/12/2015
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
			//ADDED BY NILESH G ON 17/12/2015
			if (objDivMain !=null) 
			{
			    if(Browser=='IE')
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 42;
			    		        
			    else
			        intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
			    if (intDivHeight < 100)	intDivHeight = 100;
		
			    objDivMain.style.height = intDivHeight +'px';	
			  		   
			}
		    //ENDDED BY NILESH G ON 17/12/2015
		}	

		function EditRow(intRowid)
		{
					
			var objRowCount = GetObjectReference('frmEWF_WeeklyView','hid_RowsCount'); 
			var strURL= 'EWF_WeeklyView.aspx?Action=EditRow&RowNumber=' + intRowid + "&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>";
			val=generateRequest(strURL); 
			if (val==true) 
			{ 
				var newRow = GetObjectReference('frmEWF_WeeklyView','tr_'+intRowid);
				var arrElements = strResult.split("<ELEMENT_SEPERATOR>");
				var loopCounter;
				cellno = newRow.cells;
				for(loopCounter=0; loopCounter<arrElements.length-1;loopCounter++)
				{
				    var nextloopCounter = loopCounter + 1
				    //Modified by swapnil a on 28/12/2015 for browser compatibility issue
				    var col = newRow.cells['td_'+ intRowid + '_' + nextloopCounter]
                    //Ended
					//if(loopCounter==arrElements.length-2)
					//	col.style.textAlign = 'center';
					//col.style.textAlign = 'right'
					col.innerHTML = arrElements[loopCounter];
				}
			} 
			
		}
		
		function EditProject(intProjectID)
		{
			//var strURL= 'EWF_WeeklyView.aspx?Action=EditProject&ProjectID=' + intProjectID;
			var strRows = GetObjectReference('frmEWF_WeeklyView','txthidRowsforProject_'+intProjectID);
			var arrRows = strRows.value.split(",");
			var strURL= 'EWF_WeeklyView.aspx?Action=EditProject&ProjectID=' + intProjectID +"&RowIDS=" + strRows.value+"&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>";
			var strTemp = new String();
			
			val=generateRequest(strURL); 
			if (val==true) 
			{ 
				var arrRowsData = strResult.split("<ROW_SEPERATOR>");
				//Modified by SantoshK on Date July 05,2006 for WhizibleSEM Issue ID.4168
			/*	if (arrRowsData.length > 0);
				//End of modification by SantoshK on July 05,2006 Isse ID.4168
				{
					for(intCounter=1; intCounter<arrRows.length;intCounter++)
					{
						if (arrRows[intCounter] != "")
						{
							var newRow = GetObjectReference('frmEWF_WeeklyView','tr_'+arrRows[intCounter]);
							strTemp = arrRowsData[intCounter-1];
							var arrElements = strTemp.split("<ELEMENT_SEPERATOR>");
							var loopCounter;
							cellno = newRow.cells;
							for(loopCounter=0; loopCounter<arrElements.length-1;loopCounter++)
							{
								var nextloopCounter = loopCounter + 1
								var col = newRow.cells('td_'+ arrRows[intCounter] + '_' + nextloopCounter)
								//if(loopCounter==arrElements.length-2)
								//	col.style.textAlign = 'center';
								//col.style.textAlign = 'right'
								col.innerHTML = arrElements[loopCounter];
							}
						}
					}
				}*/
					for(intCounter=0; intCounter<arrRows.length;intCounter++)
					{
						if (arrRows[intCounter] != "")
						{
							var newRow = GetObjectReference('frmEWF_WeeklyView','tr_'+arrRows[intCounter]);
							var arrElements = arrRowsData[intCounter-1].split("<ELEMENT_SEPERATOR>");
							var loopCounter;
							cellno = newRow.cells;
							for(loopCounter=0; loopCounter<arrElements.length-1;loopCounter++)
							{
							    var nextloopCounter = loopCounter + 1
							    
                                //Modified by swapnil a on 28/12/2015 for browser compatibility issue
							    var col = newRow.cells['td_'+ arrRows[intCounter] + '_' + nextloopCounter]
							   //Ended
								//if(loopCounter==arrElements.length-2)
								//	col.style.textAlign = 'center';
								//col.style.textAlign = 'right'
								col.innerHTML = arrElements[loopCounter];
							}	
						}
					}
			} 
		}
		   
          
		function Process() 
		{ 
			if (req.readyState == 4) 
			{ 
				if (req.status == 200) 
				{ 
				    //if (window.ActiveXObject)
				    if (Browser == 'IE') // Added By Nilesh g ON 10/12/2015
					{ 
						xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); 
						xmlDoc.async=false; 
						xmlDoc.loadXML(req.responseText); 
					} 
					else if (document.implementation &&	document.implementation.createDocument) 
					{ 
					    xmlDoc= document.implementation.createDocument("","",null); 
					    if (Browser == 'FF') // Added By Nilesh g ON 10/12/2015
						xmlDoc.load(req.responseXML); 
					} 
					strResult=req.responseText; 
				} 
			} 
		}
		
		function generateRequest(url)
		{ 
			if (window.XMLHttpRequest) 
			{ 	
				req = new XMLHttpRequest(); 
			} 
			else if (window.ActiveXObject) 
			{ 
				req = new ActiveXObject("Microsoft.XMLHTTP"); 
			}  
			req.onreadystatechange = Process; 
			req.open("POST", url,false); 
			//Modified by SantoshK on Date July 05,2006 for WhizibleSEM Issue ID.4168
			req.send(null);
			//End of modification by SantoshK on July 05,2006 Isse ID.4168
		 
			delete req; 
			return true; 
		}
		
		function PreviousWeek_OnClick()
		{
			objform.action = "EWF_WeeklyView.aspx?Move=<%=MOVE_PREVIOUS%>&txtDate=<%=m_dtStartDateOfWeek%>";
			objform.submit()
		}
		
		function NextWeek_OnClick()
		{
			objform.action = "EWF_WeeklyView.aspx?Move=<%=MOVE_NEXT%>&txtDate=<%=m_dtStartDateOfWeek%>";
			objform.submit()
		}
		    function Save_OnClick()
		    {
		        
		        //added by Nilesh g on 13/1/2016      
		        var Mode = (arguments.length > 0) ? arguments[0] : "0";
		        if (Mode == "0")
		        {
		          
		            document.body.readonly=true;
		            window.setTimeout('Save_OnClick("1")',1);         
		        }
		        if (Mode == "1")
		        {
		            var objCurrencyId = GetObjectReference('frmEWF_WeeklyView','CboCurrency');
		            var objCountryId = GetObjectReference('frmEWF_WeeklyView','CboCountry');
		            var objFPCenterID = GetObjectReference('frmEWF_WeeklyView','CboFpCenter');
			
		            if( disallowBlank(objCurrencyId ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_CURRENCY")%>",true) == true)
		            { 
		              //  RemoveFrameLoader();
		                return;}	
			
		            if( disallowBlank(objCountryId ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_COUNTRY")%>" ,true) == true)
		            {
		              //  RemoveFrameLoader();
		                return;	}

		            if( disallowBlank(objFPCenterID ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_FPCENER")%>"  ,true) == true)
		            {
		              //  RemoveFrameLoader();
		                return;	}

						
		            var objRowCount = GetObjectReference('frmEWF_WeeklyView','hid_RowsCount');
		            var intTotalRows = objRowCount.value;
		            var intRowCount;
		            var intColCount;
			
		            //Amount Validations
		            for (intRowCount = 1 ; intRowCount<=intTotalRows; intRowCount++)
		            {
		                for (intColCount = 1 ; intColCount <= 7 ; intColCount++)
		                {
		                    var objtxtAmount = GetObjectReference('frmEWF_ExpenseEntry','txtDay_' + intRowCount + "_" + intColCount);
			
		                    if( disallowNonNumeric(objtxtAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return ;
		
		                    if( disallowNegativeNumeric(objtxtAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return ;
					
		                    if (objtxtAmount)
		                    {
		                        if (objtxtAmount.value  == "0")
		                        {
		                            alert("<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>");
		                            objtxtAmount.focus();
		                           // RemoveFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link
		                            return;
		                        }		
		                    }
		                }
		            }
		            setFrameLoader();
		            objform.action = "EWF_WeeklyView.aspx?Action=SAVE&txtDate=<%=m_dtStartDateOfWeek%>&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>";
		            objform.submit()
		           // RemoveFrameLoader();//added by Nilesh on 8/1/2015 for loader add on save link
		        }
		       
		    }
		
		function ShowExpense(EntryDate,EmployeeID,ProjectID,CostHeadID)
		{
			window.open("EWF_WeeklyView.aspx?Mode=ShowDetails&hidEntrydate=" + EntryDate + "&hidEmployeeID=" + EmployeeID + "&hidProjectID=" + ProjectID + "&hidCostHeadID=" + CostHeadID +"&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>" ,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function SaveDetails_OnClick()
		{
			//Validations
			var objDetailsRowCount = GetObjectReference('frmEWF_WeeklyView','txthidDetailsRowCount');
			var intDetailsRowCount = objDetailsRowCount.value;
			var intRowCounter;
			for (intRowCounter = 1 ;intRowCounter<=intDetailsRowCount;intRowCounter++)
			{
				var objExpenseEntryID = GetObjectReference('frmEWF_WeeklyView','txthidExpenseEntry_' + intRowCounter);
				var strExpenseEntryID = objExpenseEntryID.value;
				
				//Check Amount
				var objAmount = GetObjectReference('frmEWF_WeeklyView','txtAmount_' + strExpenseEntryID);
							
				if( disallowBlank(objAmount ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_AMOUNT")%>" ,true) == true )return;
			
				if( disallowNonNumeric(objAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return;
		
				if( disallowNegativeNumeric(objAmount,"<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>",true) ==true) return;
		
				if (objAmount.value  == 0)
				{
					alert("<%=MyBase.GetResourceString("VALIDATE_POSITIVE_AMOUNT")%>");
					objAmount.focus();
					return;
				}					
				
				//Check Currency
				objCurrency = GetObjectReference('frmEWF_WeeklyView','cboDeailsCurrencyID_' + strExpenseEntryID);
				if( disallowBlank(objCurrency ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_CURRENCY")%>" ,true) == true)
					return;				

				//Check Description
				objDescription = GetObjectReference('frmEWF_WeeklyView','txtDescription_' + strExpenseEntryID);
				if(disallowBlank(objDescription ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_DESCRIPTION")%>" ,true) == true)
					return;			
					
				if(disallowMaxlengthViolation(objDescription,2000,"<%=MyBase.GetResourceString("VALIDATE_MAX_DESCRIPTION")%>" ,true) == true )
					return;						

				//Check Country
				objCountry = GetObjectReference('frmEWF_WeeklyView','cboDeailsCountryID_' + strExpenseEntryID);
				if( disallowBlank(objCountry ,"<%=MyBase.GetResourceString("VALDATE_EMPTY_COUNTRY")%>" ,true) == true)
					return;				
				
				//Check Finance Processing Center
				objFP = GetObjectReference('frmEWF_WeeklyView','cboDeailsFPID_' + strExpenseEntryID);
				if( disallowBlank(objFP ,"<%=MyBase.GetResourceString("VALIDATE_EMPTY_FPCENER")%>" ,true) == true)
					return;				
					
				//Check Payment Mode
				
				//Commented by JyotiG bcoz Payment mode is not compulsory.
				//Date : 11-Dec-2006
				objPaymentMode = GetObjectReference('frmEWF_WeeklyView','cboPaymentMode_' + strExpenseEntryID);
				/*if( disallowBlank(objPaymentMode ,"<%=MyBase.GetResourceString("VALIDATE_PAYEMENT_MODE")%>" ,true) == true)
					return;				
				*/
				objBillable = GetObjectReference('frmEWF_WeeklyView','chkIsBillable_' + strExpenseEntryID);					
				
				//Enabling all controls before save
				objAmount.disabled = false;
				objCurrency.disabled = false;
				objDescription.disabled = false;
				objCountry.disabled = false;
				objFP.disabled = false;
				objPaymentMode.disabled = false;					
				objBillable.disabled = false;	
				
			}
			
			objform.action = "EWF_WeeklyView.aspx?Mode=ShowDetails&Action=SAVEDETAILS&txtDate=<%=m_dtStartDateOfWeek%>&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>";
			objform.submit()
			window.opener.location.href="../EWF/EWF_WeeklyView.aspx?txtDate=<%=m_dtStartDateOfWeek%>&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>"
		}
		
		function Back_OnClick()
		{
			window.location.href = "../EWF/EWF_ExpenseEntryList.aspx?FromWhere=DT&MasterTagId=3556";
		}	
		
		function DeleteDetails_OnClick()
		{
			var objchkDelete = GetObjectReference('frmEWF_WeeklyView','chkDelete',1);
			var blnIsCheckboxChecked 
			var intCounter
			blnIsCheckboxChecked = false
			
			if (objchkDelete.length > 0)
			{
				for(intCounter=0; intCounter < objchkDelete.length;intCounter++)
				{
					if (objchkDelete[intCounter].checked == true)
					{
						blnIsCheckboxChecked = true;
						break;
					}
				}
				
				if (blnIsCheckboxChecked == true)
				{
					if (confirm("Are you sure you want to delete the selected records?")==true)
					{
						objform.action = "EWF_WeeklyView.aspx?Mode=ShowDetails&Action=DELETEDETAILS&txtDate=<%=m_dtStartDateOfWeek%>&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>"
						objform.submit();
						window.opener.location.href="../EWF/EWF_WeeklyView.aspx?txtDate=<%=m_dtStartDateOfWeek%>&StartDate=<%=m_dtStartDateOfWeek%>&EndDate=<%=m_dtEndDateOfWeek%>";
					}
				}
				else
				{
					alert("Select atleast one entry to delete");
				}	
			}
		}
		
		</Script>
<%
	If Request.QueryString("Action") = "EditRow" Then
	writeResponse()
	End If
	If Request.QueryString("Action") = "EditProject" Then
	EditProject()
	End If
%>
	</body>
</HTML>
