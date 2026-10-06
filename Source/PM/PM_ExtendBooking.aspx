<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ExtendBooking.aspx.vb" Inherits="PbNIT.PM_ExtendBooking"%>
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


	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_ExtendBooking" method="post" runat="server">
						
									<%PageInit%>
							
					</form>
			
				<Script language="javascript">
		var objXHttp;
		var blnFlag = false;
		var MaxUnits = <%=m_strMaxUnits%>;
		
		function HandlerOnReadyState()
		{
			var objPercentage;

			objWorkHrsPerDay = GetObjectReference('frmPM_ExtendBooking','txtWorkHrsPerDay');						
			objTotalWorkHours = GetObjectReference('frmPM_ExtendBooking','txtTotalWorkHours');
			objPercentage = GetObjectReference('frmPM_ExtendBooking','txtPercentage');
			objSpanTotalWorkHours = GetObjectReference('frmPM_ExtendBooking','SpanTotalWorkHours');
			
			if (objXHttp.readyState==4)
			{
				if (objXHttp.responseText != null) 
				{
					var output;
					output = objXHttp.responseText.split("|");
					
					if (output[0] == "GETALLOCATIONDETAILS")
					{	
						if (objWorkHrsPerDay != null)
						{
							objWorkHrsPerDay.value = output[1];
						}
											
						if (objTotalWorkHours != null)
						{//Codition added by SanaS on 8-Oct-2009
							if (objSpanTotalWorkHours != null)
							{
							objSpanTotalWorkHours.innerHTML = output[2];
							}
						//End modifiaction by SanaS on 8-Oct-2009
							objTotalWorkHours.value = output[2];

						}	
											
						if (objPercentage != null)
						{
							objPercentage.value = output[3];
						}							
					}										
				}	
			}
		}

		var objform=GetFormReference('frmPM_ExtendBooking');
		var objdivlist=GetObjectReference('frmPM_ExtendBooking','PageDiv');
		//var objcboresourcepool=GetObjectReference('frmPM_ExtendBooking','cboResourcePool');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
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
			objdivlist.style.height = intDivHeight + 'px';
        }	
		
			//objcboresourcepool.disabled=true;
					
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
		
		<%=m_strScript%>
		
		function Save_OnClick()
		{
		 var objReqStartDate = GetObjectReference('frmPM_ExtendBooking','txtReqStartDate');
		 var objReqEndDate = GetObjectReference('frmPM_ExtendBooking','txtReqEndDate');
		 var objEndDate = GetObjectReference('frmPM_ExtendBooking','txtEndDate');		 
		 var objProjEndDate =GetObjectReference('frmPM_ExtendBooking','txtProjEndDate');
		 objprojEndDate=getDate1(objProjEndDate.value);
		 
		 var strMsg;
		 
		 var objNewUnits = GetObjectReference('frmPM_ExtendBooking','txt_New_Units');		 
		 
		 <% IF m_strMaxUnits <> 0 AND m_strType = "TH" THEN %>		 
			var objPercentage = GetObjectReference('frmPM_ExtendBooking','txtPercentage');
			if (objPercentage.value > MaxUnits)
		  {
				alert('Calculated percentage for &#39;' + objNewUnits.value + ' Hrs &#39; should be less than or equal to &#39;' + MaxUnits + '%&#39;' );				
				objNewUnits.focus();
				return;
			}						
		<% END IF %> 		 		 
		 	  						
				strMsg = "Please enter value for 'New Allocation'";
				if (disallowBlank(objNewUnits,strMsg) == false )
				{
					strMsg = "Please enter a value for 'New Effective Date '";
					if (disallowBlank(objReqStartDate,strMsg) == false )
			 {
						strMsg = "Please enter a value for 'New End Date'";
						if (disallowBlank(objReqEndDate,strMsg) == false )
						{
							objform.action = "../PM/PM_ExtendBooking.aspx?MODE=SAVE&ProjectEmployeeRoleID=" + <%=m_intProjectEmployeeRoleId%>;
							objform.submit();				
						
									/*
							//Modified By PrachiK on 15 Feb 2005 for Issue ID=15907. 
							//Purpose: Puting Project end date into hidden field for red date validation
							strMsg = "<%=MyBase.GetResourceString("DATE_RANGE_MESSAGE")%>";
										if (disallowDate1LessThanOrEqualToDate2(objReqEndDate,objEndDate,strMsg) == false && (disallowDate1LessThanDate2(objProjEndDate,objReqEndDate,"Requested End Date should not be greater than Project End Date (" + objProjEndDate.value + ")") == false))
								{
								  
											strMsg = "<%=MyBase.GetResourceString("HOURS_MESSAGE")%>";
											//Integrated Changes by SanaS on 24-Sep-2009
													if (disallowNegativeNumeric(objNewUnits,strMsg)== false)
							        { 
													 strMsg = "Please enter Positive value for Work Hours";	
		  												if (objNewUnits.value<0)
					                                {
					                                    alert(strMsg);
					                                      return;
					                                }
												
													    objform.action = "../PM/PM_ExtendBooking.aspx?MODE=SAVE&ProjectEmployeeRoleID=" + <%=m_intProjectEmployeeRoleId%>;
													    objform.submit();
													}
											//End Integration by SanaS on 24-Sep-2009		   
											   
										}*/
								}
			   }
		    } 
		  
		}
		
		function Assign_OnClick()
		{
			objform.action = "../PM/PM_ExtendBooking.aspx?MODE=AssignConfirm&RequestID=" + <%=m_intRequestID%>;
			objform.submit();
		
			/*							
			var objReqEndDate = GetObjectReference('frmPM_ExtendBooking','txtReqEndDate');
			var objEndDate = GetObjectReference('frmPM_ExtendBooking','txtEndDate');
			var objWorkHours = GetObjectReference('frmPM_ExtendBooking','txtHours');
		  
		 var strMsg;
		
		 strMsg = "<%=MyBase.GetResourceString("REQUESTED_DATE_MESSAGE")%>";
		  if (disallowBlank(objReqEndDate,strMsg) == false )
		  {
			strMsg = "<%=MyBase.GetResourceString("ADDITIONAL_HOURS_MESSAGE")%>";
			if (disallowBlank(objWorkHours,strMsg) == false )
			 {
				strMsg = "<%=MyBase.GetResourceString("DATE_RANGE_MESSAGE")%>";
				if (disallowDate1LessThanDate2(objReqEndDate,objEndDate,strMsg) == false)
				{
							strMsg = "<%=MyBase.GetResourceString("HOURS_MESSAGE")%>";
							//Integrated Changes by SanaS on 24-Sep-2009 
							if (disallowNegativeNumeric(objWorkHours,strMsg)== false)
							{ 
									
											strMsg = "Please enter Positive value for Work Hours";	
		  			                         if (objWorkHours.value<0)
					                                {
					                                    alert(strMsg);
					                                      return;
					                                }
								
									objform.action = "../PM/PM_ExtendBooking.aspx?MODE=AssignConfirm&RequestID=" + <%=m_intRequestID%>;
									objform.submit();
									}
							}
				 //}
					//End Integration by SanaS on 24-Sep-2009
			   }
		    } 
			*/
		}
		
		function RejectRequest_OnClick()
		{
			if(confirm("<%=MyBase.GetResourceString("REJECT_REQUEST_CONFIRM")%>"))
			{
				window.open("../HR/HR_AddComments.aspx?From=ExtenedBooking&Mode=REJECT_REQUEST&RequestID=<%=m_intRequestID%>&Flag=2","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
			}
		}
		
		//CANCEL LINK WILL BE ONLY AVAIALBLE WHEN pROJECT LEVEL RESOURCE ALLOCATION WORKFLOW IS ON
	function Cancel_OnClick()
		{
			objform.action = "../PM/PM_ExtendBooking.aspx?MODE=CANCEL&RequestID=<%=intRequestID%>";
			objform.submit();
		}
		function GetPercentage(objName)
		{
			var objHPD = GetObjectReference('frmPM_ExtendBooking',objName);
			var objPercentage;
			var strUrl; 
						
			if(objHPD != null && isBlank(objHPD.value)== false)
			{
				strUrl = new String();
				strUrl = '../General/XMLHttp.aspx?TagID=1019&Mode=ExtendBooking&Action=GetPerecentage&ProjectEmployeeRoleID=<%=m_intProjectEmployeeRoleId%>&PerDayEffort='+objHPD.value;
											
				if (document.all)
				{ 
					objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
					objXHttp.onreadystatechange = HandlerOnReadyState; 
					objXHttp.open('GET',strUrl, false); 
					objXHttp.send();           
				}  
				else  
				{
					objXHttp = new XMLHttpRequest();  
					objXHttp.onreadystatechange = HandlerOnReadyState(); 
					objXHttp.open('GET',strUrl, false);
					objXHttp.send(null);  
				}
			}
			else
			{
				objPercentage = GetObjectReference('frmPM_ExtendBooking','txtPercentage');
				
				if (objHPD != null){ objHPD.value = '';}
				if (objPercentage != null){ objPercentage.value = '';}
			}
		}
		
		function GetAllocationDetails()
		{									
			var objReqStartDate = GetObjectReference('frmPM_ExtendBooking','txtReqStartDate');	
			var objWHIZReqStartDate = GetObjectReference('frmPM_ExtendBooking','FFE29587WHIZ_txtReqStartDate');		
		    //Added By Bharat T on 14th-Oct-2015
			if(objWHIZReqStartDate==null)
			    var objWHIZReqStartDate = GetObjectReference('frmPM_ExtendBooking','txtReqStartDate');		
		    //Ended By Bharat T on 14th-Oct-2015
			
			var objReqEndDate = GetObjectReference('frmPM_ExtendBooking','txtReqEndDate');	
			var objWHIZReqEndDate = GetObjectReference('frmPM_ExtendBooking','FFE29587WHIZ_txtReqEndDate');	
		    //Added By Bharat T on 14th-Oct-2015
			if(objWHIZReqEndDate==null)
			    var objWHIZReqEndDate = GetObjectReference('frmPM_ExtendBooking','txtReqEndDate');		
		    //Ended By Bharat T on 14th-Oct-2015
			
			var objEndDate = GetObjectReference('frmPM_ExtendBooking','txtEndDate');
			var objProjEndDate = GetObjectReference('frmPM_ExtendBooking','txtProjEndDate');
						
			var objUnit = GetObjectReference('frmPM_ExtendBooking','txt_New_Units');
			var objPercentage = GetObjectReference('frmPM_ExtendBooking','txtPercentage');
			var objTotalWorkHours = GetObjectReference('frmPM_ExtendBooking','txtTotalWorkHours');
			var objWorkHrsPerDay = GetObjectReference('frmPM_ExtendBooking','txtWorkHrsPerDay');
			var objSpanTotalWorkHours = GetObjectReference('frmPM_ExtendBooking','SpanTotalWorkHours');
			 	
			var flag = true;					
			
			if (disallowNegativeNumeric(objUnit,'Please enter only positive numeric value for New Allocation', true) == true)
			{   
				flag = false;
			}									
			else if(!DateControl_StandardOnblur('frmCommonPage','txtReqStartDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
			{ 	objReqStartDate.value='';
				objWHIZReqStartDate.value = '';						
				flag = false;				
			}				
			else if(!DateControl_StandardOnblur('frmCommonPage','txtReqEndDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
			{ 	objReqEndDate.value='';
				objWHIZReqEndDate.value = '';
				flag = false;					
			}				
			else if (disallowDate1LessThanOrEqualToDate2(objReqStartDate,objEndDate,"Please enter 'New Effective Date ' greater than 'End Date'") == true)				
			{	objReqStartDate.value='';
				objWHIZReqStartDate.value = '';
				flag = false;
			}
			else if (disallowDate1LessThanDate2(objProjEndDate,objReqEndDate,"'New End Date' should not be greater than 'Project End Date' (" + objProjEndDate.value + ")") == true)
			{	objReqEndDate.value='';
				objWHIZReqEndDate.value = '';
				flag = false;
			}
			else if (disallowDate1LessThanDate2(objReqEndDate, objReqStartDate,"Please enter 'New End Date' greater than 'New Effective Date'") == true)
			{	objReqEndDate.value='';
				objWHIZReqEndDate.value = '';
				flag = false;
			}			
			<% IF m_strMaxUnits <> 0 AND m_strType <> "TH" THEN %>
			else if (objUnit.value > MaxUnits)
			{
				alert('New Allocation should be less than or equal to ' + MaxUnits );				
				objUnit.focus();
				flag = false;				
			}
			<% END IF %>
			//Added by SanaS 16-Nov-2009
			<% IF m_strMaxUnits <> 0 AND m_strType = "P" THEN %>
			else if (objUnit.value > MaxUnits ||objUnit.value < 1 )
					{	alert('New Allocation Percentage should be in the range of 1 To <%=m_strMaxUnits%>');
					  objUnit.focus();
				        flag = false;
					    				
					}	
			
			<% END IF %>		
			//End by SanaS 16-Nov-2009		
			else if (Trim(objUnit.value) != '' && objUnit.value == 0)
			{				
				alert('New Allocation should be greater than 0');				
				objUnit.focus();
				flag = false;
			}		
			
			else if (Trim(objWHIZReqStartDate.value) == '' || Trim(objWHIZReqEndDate.value) == '' || Trim(objUnit.value) == '')			
			{				
				flag = false;
			}
			else			
			{  
			
				var strUrl; 
				strUrl = new String();
				strUrl = '../General/XMLHttp.aspx?TagID=1019&Mode=ExtendBooking&Action=GetAllocationDetails&Type=<%=m_strType%>&Unit='+objUnit.value+'&ProjectEmployeeRoleID=<%=m_intProjectEmployeeRoleId%>&StartDate='+objReqStartDate.value+'&EndDate='+objReqEndDate.value;
											
				if (document.all)
				{ 
					objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
					objXHttp.onreadystatechange = HandlerOnReadyState; 
					objXHttp.open('GET',strUrl, false); 
					objXHttp.send();           
				}
				else  
				{
					objXHttp = new XMLHttpRequest();  
					objXHttp.onreadystatechange = HandlerOnReadyState(); 
					objXHttp.open('GET',strUrl, false);
					objXHttp.send(null);  
				}
			}
			
			if (flag == false)
			{
				if (objTotalWorkHours != null){ objTotalWorkHours.value = '';}
				if (objPercentage != null){ objPercentage.value = '';}
				if (objWorkHrsPerDay != null){ objWorkHrsPerDay.value = '';}
				if (objSpanTotalWorkHours != null){ objSpanTotalWorkHours.innerHTML = '';}
				
				return false;
			}	
			
		}
		
				</Script>
	</body>
</HTML>
