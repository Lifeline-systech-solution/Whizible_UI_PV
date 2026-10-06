<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_PreponeBooking.aspx.vb" Inherits="PbNIT.PM_PreponeBooking"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body  class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_PreponeBooking" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
		
				<Script language="javascript">
					
		var objform=GetFormReference('frmPM_PreponeBooking');
		var objdivlist=GetObjectReference('frmPM_PreponeBooking','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

        
        var objXHttp;
		var blnFlag = false;
		
		function HandlerOnReadyState()
		{	
			if (objXHttp.readyState==4)
			{
				if (objXHttp.responseText != null) 
				{
					var objWorkHours = GetObjectReference('frmPM_PreponeBooking','txtHours');
	var objTotalhrsSpan= GetObjectReference('frmPM_PreponeBooking','TotalHrsSpan');
					objWorkHours.value=objXHttp.responseText
					var arrValues =objXHttp.responseText.split("|");
					objWorkHours.value=arrValues[1];
objTotalhrsSpan.innerHTML=arrValues[1];
					
				}
			}
		}
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';}	
		 
					
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';	}
		}	
		
	
		
		function Save_OnClick()
		{
			var objReqEffectiveDate = GetObjectReference('PM_PreponeBooking','txtReqStart');
		 var objReqEndDate = GetObjectReference('PM_PreponeBooking','txtReqEndDate');
		 var objEndDate = GetObjectReference('PM_PreponeBooking','txtEndDate');
		 var objProjEndDate =GetObjectReference('PM_PreponeBooking','txtProjEndDate');
		 var objStartDate=GetObjectReference('PM_PreponeBooking','txtStartDate');
		 var objWorkHours = GetObjectReference('PM_PreponeBooking','txtHours');
		 var objPrevAllocation	 = GetObjectReference('PM_PreponeBooking','txtPrevAllocation');
		 var objNewAllocation	 = GetObjectReference('PM_PreponeBooking','txtNewAllocation');
		 var objToday = GetObjectReference('PM_PreponeBooking','txtToday');
		 var strMsg,strmsg1;
		 objprojEndDate=getDate1(objProjEndDate.value);
		 
		 

	        objPrevAllocation.disabled = false;
		        objWorkHours.disabled=false;
		 
        strMsg = "<%=MyBase.GetResourceString("REQUESTED_DATE_MESSAGE")%>";
		  if (disallowBlank(objReqEndDate,strMsg) == false )
		  	{
		  	strMsg = "Please enter value for Work Hours";
			if (disallowBlank(objWorkHours,strMsg) == false )
		  		{
		  		
		  		if (disallowDate1GreaterThanOrEqualToDate2(objReqEndDate,objEndDate,"'Requested End Date' should be less 'End Date'.") == false) 
		  			 {
		  			if (disallowDate1GreaterThanDate2(objStartDate,objReqEndDate,"'Requested End Date' should not be less than 'Start Date'.") == false)
		  			 {
		  			  strMsg = "Please enter positive integer";
					if (disallowNegativeNumeric(objWorkHours,strMsg)== false)
					{ 
		  			 strMsg = "Please enter Positive value for Work Hours";	
		  			 if (objWorkHours.value<0)
					{
					    alert(strMsg);
                        objWorkHours.disabled=true;
					     return;
					}
					if(objWorkHours.value==0)		
					{
					    alert('Work Hours should be greater than 0');
                        objWorkHours.disabled=true;
					    return;
					}
					 
					 if (disallowDate1GreaterThanDate2(objReqEffectiveDate,objReqEndDate,"Effective Date Should be less than Requested End Date") == true) 
					 {
						return;
					 }  
					
					  if (disallowDate1GreaterThanOrEqualToDate2(objToday,objStartDate) == false) 
					  {
						 if (disallowDate1GreaterThanDate2(objStartDate,objReqEffectiveDate,"Effective Date Should be greater than or equal Start Date") == true) 
						 {
						 return;
						 }
					  }
					  else
                            { if (parseFloat(objPrevAllocation.value)!=parseFloat(objNewAllocation.value))
					          {
						        if (disallowDate1GreaterThanDate2(objToday,objReqEffectiveDate,"Effective Date Should be greater than or equal to today.") == true) 
							        {
							        return;
							        }
					              }
					
		  		 
					        }
				 
					if ( ValidAllocation()==true)
		  			  {
		  			  objform.action = "../PM/PM_PreponeBooking.aspx?MODE=SAVE&ProjectEmployeeRoleID=" + <%=m_intProjectEmployeeRoleId%>;
						objform.submit();
						}
	                else
					{
					objWorkHours.disabled=true;
					}
		  		} 
		  		}
		  		}
		  		}
		  		
			/*strMsg = "<%=MyBase.GetResourceString("ADDITIONAL_HOURS_MESSAGE")%>";
			
			//if (disallowBlank(objWorkHours,strMsg) == false )
			 //{
							//Modified By PrachiK on 15 Feb 2005 for Issue ID=15907. 
							//Purpose: Puting Project end date into hidden field for red date validation
							/*strMsg = "<%=MyBase.GetResourceString("DATE_RANGE_MESSAGE")%>";
								if (disallowDate1LessThanDate2(objReqEndDate,objEndDate,strMsg) == false && (disallowDate1LessThanDate2(objProjEndDate,objReqEndDate,"Requested End Date should not be greater than Project End Date (" + objProjEndDate.value + ")") == false))
								{
								  
											strMsg = "<%=MyBase.GetResourceString("HOURS_MESSAGE")%>";
											if (disallowNonInteger(objWorkHours,strMsg)== false)
											{
													if (disallowNegativeInteger(objWorkHours,strMsg) == false)
													{
												
													objform.action = "../PM/PM_ExtendBooking.aspx?MODE=SAVE&ProjectEmployeeRoleID=" + <%=m_intProjectEmployeeRoleId%>;
													objform.submit();
													}
											   
											}
								}*/
							
			   //}
		    //} 
		    
		  
		}
		
	}
		
		function ValidAllocation()
		{
			var objNewAllocation	 = GetObjectReference('frmPM_PreponeBooking','txtNewAllocation');
			var objPrevAllocation	 = GetObjectReference('PM_PreponeBooking','txtPrevAllocation');
			var objReqEffectiveDate = GetObjectReference('PM_PreponeBooking','txtReqStart');
			var strMsg,strmsg1;
			strMsg = "Please enter value for New Allocation";
					if (disallowBlank(objNewAllocation,strMsg))
						return false;
		  			 if (objNewAllocation.value<0)
					{
						strMsg = 'Please enter Positive value for New Allocation';	
					    alert(strMsg);
					     objNewAllocation.value='';
					    return false;
					}
					if(objNewAllocation.value==0)		
					{
					    alert('New Allocation should be greater than 0');
					    return false;
					}
					if (objNewAllocation.value!=objPrevAllocation.value)
						{if (disallowBlank(objReqEffectiveDate,'Effective Date Cannot be blank') == true )
							    return;
							} 
					if ('<%=strType%>'=='P')
					{
					
						 strMsg='New Allocation Percentage should be in the range of 1 To <%=m_StdAllocationPercentage%>';
					 	if(disallowValueRangeViolation(objNewAllocation, 1, '<%=m_StdAllocationPercentage%>', strMsg))
					     { objNewAllocation.value='';
					      return false;
					      }
					
					}	
					if ('<%=strType%>'=='HPD')
					{
							strMsg = 'New Work Hours per day should be in the range of <%=CommonFunctions.Application.MinHoursForDAEntry%> To 24';
						if(disallowValueRangeViolation(objNewAllocation, '<%=CommonFunctions.Application.MinHoursForDAEntry%>', 24, strMsg))
						{ objNewAllocation.value='';
							return false;
						}
					}	
			return true;
		}
		
		function Assign_OnClick()
		{
		var objReqEndDate = GetObjectReference('frmPM_PreponeBooking','txtReqEndDate');
		 var objEndDate = GetObjectReference('frmPM_PreponeBooking','txtEndDate');
		 var objProjEndDate =GetObjectReference('frmPM_PreponeBooking','txtProjEndDate');
		  var objStartDate=GetObjectReference('frmPM_PreponeBooking','txtStartDate');
		  var objWorkHours = GetObjectReference('frmPM_PreponeBooking','txtHours');
		  var objNewAllocation=GetObjectReference('frmPM_PreponeBooking','txtNewAllocation');
		  var objPrevAllocation=GetObjectReference('frmPM_PreponeBooking','txtPrevAllocation');
		 objprojEndDate=getDate1(objProjEndDate.value);
		 
		 var strMsg,strmsg1;
		 objPrevAllocation.disabled=false;
		 objNewAllocation.disabled=false;
		 strMsg = "<%=MyBase.GetResourceString("REQUESTED_DATE_MESSAGE")%>";
		  if (disallowBlank(objReqEndDate,strMsg) == false )
		  	{
		  		strMsg = "Please enter value for Work Hours";
			if (disallowBlank(objWorkHours,strMsg) == false )
		  		{
		  		if (disallowDate1GreaterThanDate2(objReqEndDate,objEndDate,"Requested End Date should be less than Request End Date.") == false) 
		  			 {
		  			 if (disallowDate1GreaterThanDate2(objStartDate,objReqEndDate,"Requested End Date should be greater than request start date.") == false)
		  			 {
		  			 strMsg = "Please enter positive integer";
					if (disallowNegativeNumeric(objWorkHours,strMsg)== false)
					{ 
		  			  strMsg = "Please enter Positive value for Work Hours";	
		  			 if (objWorkHours.value<0)
					{
					    alert(strMsg);
					     return;
					}
					if(objWorkHours.value==0)		
					{
					    alert('Work Hours should be greater than 0');
					    return;
					}
		  			  objform.action = "../PM/PM_PreponeBooking.aspx?MODE=AssignSave&RequestID=" + <%=m_intRequestID%>;
						objform.submit();
		  		} 
		  		}
		  		}
		  		}
		  			else
						{
							objPrevAllocation.disabled=true;
							objNewAllocation.disabled=true;
						}
		  		}
		else
		{
			 objPrevAllocation.disabled=true;
			 objNewAllocation.disabled=true;
		}
			}
		
		function RejectRequest_OnClick()
		{
			if(confirm("<%=MyBase.GetResourceString("REJECT_REQUEST_CONFIRM")%>"))
			{
				window.open("../HR/HR_AddComments.aspx?From=PreponeBooking&Mode=REJECT_REQUEST&RequestID=<%=m_intRequestID%>&Flag=1","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
			}
		}
				    var strResult;
		function GetWorkHours()
		{		
		    var strUrl; 
			var objReqEndDate = GetObjectReference('frmPM_PreponeBooking','txtReqEndDate');
			var objWHIZReqEndDate = GetObjectReference('frmPM_PreponeBooking','FFE29587WHIZ_txtReqEndDate');		
			var objEndDate = GetObjectReference('frmPM_PreponeBooking','txtEndDate');
	        var objWhizEndDate = GetObjectReference('frmPM_PreponeBooking','FFE29587WHIZ_txtEndDate');
			var objProjEndDate =GetObjectReference('frmPM_PreponeBooking','txtProjEndDate');
			var objStartDate=GetObjectReference('frmPM_PreponeBooking','txtStartDate');
		    var objWhizStartDate=GetObjectReference('frmPM_PreponeBooking','FFE29587WHIZ_txtStartDate');
			var objWorkHours = GetObjectReference('frmPM_PreponeBooking','txtHours');
			var objEffectiveDate= GetObjectReference('frmPM_PreponeBooking','txtReqStart');
			var objWhizEffectiveDate= GetObjectReference('frmPM_PreponeBooking','FFE29587WHIZ_txtReqStart');
			var objNewAllocation=GetObjectReference('frmPM_PreponeBooking','txtNewAllocation');
	        var objTotalhrsSpan= GetObjectReference('frmPM_PreponeBooking','TotalHrsSpan');
			var objPrevAllocation=GetObjectReference('frmPM_PreponeBooking','txtPrevAllocation');
		
			if (ValidAllocation()==false)
				return false;
						
		    if(!DateControl_StandardOnblur('frmPM_PreponeBooking','txtReqEndDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
	      { return false; }
	     if(!DateControl_StandardOnblur('frmPM_PreponeBooking','txtReqStart','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
	       {return false; }
	       
	       if ('<%=strType%>'=='TH')
			{
			objWorkHours.value=objNewAllocation.value;
		    objTotalhrsSpan.innerHTML=objNewAllocation.value;
		
			return;
			}
			
		 if (objWHIZReqEndDate.value == '' || objReqEndDate.value == '')
			{
				objWorkHours.value = '';
				alert('Request End Date cannot be Blank');
				return;
			}
			
			else
			{   if(objNewAllocation.value!=objPrevAllocation.value)
			    {
			        if ( objWhizEffectiveDate.value=='' || objEffectiveDate.value=='')
			        {
			        alert('Effective Date cannot be Blank');
			        return;
			        }
			    }
				if (disallowDate1GreaterThanDate2(objReqEndDate,objEndDate,"Requested End Date should be less than Request End Date.") == false) 
		  		{
		  			if (disallowDate1GreaterThanDate2(objStartDate,objReqEndDate,"Requested End Date should  be greater than request start date.") == false)
		  			{
		  				strUrl = new String();
	                        if	(objNewAllocation.value==objPrevAllocation.value)
							{
							    if (objEffectiveDate.value!=objStartDate.value)
							    {
								alert('As Allocation is same resetting the effective date to Request Start Date');
								objWhizEffectiveDate.value=objWhizStartDate.value;
								objEffectiveDate.value=objStartDate.value;
								}
							}
			
						strUrl = '../General/XMLHttp.aspx?TagID=1019&Action=GETWORKHRS&Mode=PreponeBooking&EndDate='+objReqEndDate.value+'&ProjectEmployeeRoleId=<%=m_intProjectEmployeeRoleId%>&EffectiveDate='+objEffectiveDate.value+'&NewAllocation='+objNewAllocation.value ;
		  			    if (document.all)
		  			    { 
		  			        objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
		  			        objXHttp.onreadystatechange = HandlerOnReadyState; 
		  			        objXHttp.open('GET',strUrl, false); 
		  			        objXHttp.send();           
		  			    }  
		  			    else  
		  			    {
		  			        if (WhichBrowser() =='IE') // Added By Vaijat K ON 08/12/2015 IssueID-2660
		  			        {
		  			            objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
		  			            objXHttp.onreadystatechange = HandlerOnReadyState; 
		  			            objXHttp.open('GET',strUrl, false); 
		  			            objXHttp.send();   
		  			        }
		  			        else{

		  			            objXHttp = new XMLHttpRequest();  
		  			            objXHttp.onreadystatechange = HandlerOnReadyState(); 
		  			            objXHttp.open('GET',strUrl, false);
		  			            objXHttp.send(null);  
		  			            if ( g_objXHttp.responseText != null)
		  			            {
		  			                xmlDoc= document.implementation.createDocument("","",null);
		  			                xmlDoc.async=false;
		  			                if (WhichBrowser() == 'FF') // Added By Vaijat K ON 08/12/2015
		  			                    xmlDoc.load(objXHttp.responseXML);
		  			                strResult=objXHttp.responseText;
		  			            }								
		  			        }
		  			    }
		  			}
		  			else
		  			{
		  			objWHIZReqEndDate.value = '';
					objWorkHours.value = '';
		  			}
		  		}
		  		else
		  		{
		  			objWHIZReqEndDate.value = '';
					objWorkHours.value = '';
		  		}
		  	}
		}
				    function WhichBrowser() {

				        var brwser = '';
				        var ua = navigator.userAgent, tem,
                        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
				        if (/trident/i.test(M[1])) {
				            tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
				            //return 'IE '+(tem[1] || '');
				            return 'IE';
				        }
				        if (M[1] === 'Chrome') {
				            tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
				            if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
				            brwser = 'CR';
				        }
				        else if (M[1] === 'Firefox') {
				            tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
				            if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
				            brwser = 'FF';
				        }
				        M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
				        if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
				        //return M.join(' ');
				        return brwser;
				    }
	function Cancel_OnClick()
		{
			objform.action = "../PM/PM_PreponeBooking.aspx?MODE=CANCEL&RequestID=<%=intRequestID%>" ;
			objform.submit();
		}
			
			<%=m_strScript%>
		
				</Script>
		
	</body>
</HTML>
