<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ChangeAllocationType.aspx.vb" Inherits="PbNIT.PM_ChangeAllocationType" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Change Allocation")%>
	
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
		<form id="frmPM_ChangeAllocation" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
	var objform=GetFormReference('frmPM_ChangeAllocation');
	var objdivlist=GetObjectReference('frmPM_ChangeAllocation','PageDiv');
	//var objcboresourcepool=GetObjectReference('frmPM_ChangeAllocation','cboResourcePool');


	<%' Added By SanaS on 14th Aug 2009 %>
	     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            document.oncontextmenu=new Function("return false");
        <%End If%>
        <%' Added By  SanaS on 14th Aug 2009 %>
        
        var objXHttp;
		var blnFlag = false;
		
		function HandlerOnReadyState()
		{	
			if (objXHttp.readyState==4)
			{
				if (objXHttp.responseText != null) 
				{
					var objWorkHours = GetObjectReference('frmPM_ChangeAllocation','txtHours');
				var objTotalhrsSpan= GetObjectReference('frmPM_ChangeAllocation','TotalHrsSpan');
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
		if (objdivlist !=null) 
		{
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
		if (objdivlist !=null) 
		{
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
	}	



	function Save_OnClick()
    {
		var objEffctiveFrmDate = GetObjectReference('frmPM_ChangeAllocation','txtEffectiveFromDate');
		var objEndDate = GetObjectReference('frmPM_ChangeAllocation','txtEndDate');
		var objWorkHours = GetObjectReference('frmPM_ChangeAllocation','txtHours');
		var objProjEndDate =GetObjectReference('frmPM_ChangeAllocation','txtProjEndDate');
		var objReqEndDate = GetObjectReference('frmPM_ChangeAllocation','txtReqEndDate');
		var objWHIZReqEndDate = GetObjectReference('frmPM_ChangeAllocation','FFE29587WHIZ_txtReqEndDate');	
		var objNewAllocation=GetObjectReference('frmPM_ChangeAllocation','txtNewAllocation');
		var objCurrentDate = GetObjectReference('frmPM_ChangeAllocation','txtCurrentDate');
		var strMsg;
		
		objprojEndDate=getDate1(objProjEndDate.value);
		objWorkHours.disabled=false;
		objReqEndDate.disabled=false;
		strMsg = "Please enter Effective End Date ";
	if (disallowBlank(objEffctiveFrmDate,strMsg) == false )
		{
			strMsg = "<%=MyBase.GetResourceString("ADDITIONAL_HOURS_MESSAGE")%>";
			if (disallowBlank(objWorkHours,strMsg) == false )
			{  
				if(disallowDate1GreaterThanDate2(objCurrentDate, objEffctiveFrmDate) == true)
				{
					alert("EffectiveDate Should Not Be Less Than Current Date.");
					return;
				}
				else
				{
					if(disallowDate1GreaterThanDate2(objEffctiveFrmDate,objEndDate) == true)
					{
						alert("Effective From Date Should Not Be Greater Than End Date.");					
						return;
					}
					else
					{
						if(disallowDate1GreaterThanDate2(objEffctiveFrmDate,objProjEndDate) == true)
						{
							alert("Effctive From Date Should Not Be Greater Than Project End Date (" + objProjEndDate.value + ")");
							return;
						}	
						else
						{
							if (disallowNegativeNumeric(objWorkHours,strMsg)== false)
							{ 
								strMsg = "Please enter Positive value for Work Hours";	
								if (objWorkHours.value<0)
								{
									alert(strMsg);
									return;
                                }

                                //Added By Usha Pandit On 10.04.2020 For random alert issue
                                if (objNewAllocation.value == '<%=m_OldAllocation%>') {
                                    alert('New Allocation should be different than current Allocation');
                                    return false;
                                }
                                //End Of Added By Usha Pandit On 10.04.2020 For random alert issue

								objform.action = "../PM/PM_ChangeAllocationType.aspx?MODE=SAVE&ProjectEmployeeRoleID=" + '<%=m_intProjectEmployeeRoleId%>';
							    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
							    var MenuTags = document.getElementsByTagName('A');
							    for (i = 0; i < MenuTags.length; i++) {
							        if (MenuTags[i].className == "Menu") {
							            //MenuTags[i].style.display= "none";
							            MenuTags[i].parentNode.style.display = "none";
							        }
							    }
							    setFrameLoader();
							    //End of Addition by Dhanashri S on 12 Oct 2016
								objform.submit();
							}
						}
					}
				}				
			}
			else
			{
			objWorkHours.disabled=true;
			}
		} 
	}	
	function Assign_OnClick()
		{
			var objReqEndDate = GetObjectReference('frmPM_ChangeAllocation','txtReqEndDate');
			var objWHIZReqEndDate = GetObjectReference('frmPM_ChangeAllocation','FFE29587WHIZ_txtReqEndDate');		
			var objEndDate = GetObjectReference('frmPM_ChangeAllocation','txtEndDate');
			var objProjEndDate =GetObjectReference('frmPM_ChangeAllocation','txtProjEndDate');
			var objStartDate=GetObjectReference('frmPM_ChangeAllocation','txtStartDate');
			var objWorkHours = GetObjectReference('frmPM_ChangeAllocation','txtHours');
			var objEffectiveDate= GetObjectReference('frmPM_ChangeAllocation','txtEffectiveFromDate');
			var objWhizEffectiveDate= GetObjectReference('frmPM_ChangeAllocation','FFE29587WHIZ_txtEffectiveFromDate');
			var objNewAllocation=GetObjectReference('frmPM_ChangeAllocation','txtNewAllocation');
			var strMsg,strmsg1;
			objprojEndDate=getDate1(objProjEndDate.value);
			objWorkHours.disabled=false;
			objEffectiveDate.disabled=false;
			objReqEndDate.disabled=false;
			objNewAllocation.disabled=false;
			strMsg = "<%=MyBase.GetResourceString("REQUESTED_DATE_MESSAGE")%>";
			if (disallowBlank(objReqEndDate,strMsg) == false )
		  	{
		  		strMsg = "Please enter value for Work Hours";
				if (disallowBlank(objWorkHours,strMsg) == false )
		  		{
		  		if (disallowDate1GreaterThanDate2(objEffectiveDate,objReqEndDate,"Requested Effective Date should be less than Resource End Date on Project.") == false) 
		  			{
		  				if (ValidAllocation()==true)
		  				{
		  				    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		  				    setFrameLoader();
		  				    //End of Addition by Dhanashri S on 12 Oct 2016
		  					objform.action = "../PM/PM_ChangeAllocationType.aspx?MODE=AssignSave&RequestID=" + '<%=m_intRequestID%>';
							objform.submit();
						}
						else
						{
							objWorkHours.disabled=true;
							objWhizEffectiveDate.disabled=true;
							objReqEndDate.disabled=true;
						}
					} 
		  		}
		  		else
				{
					objWorkHours.disabled=true;
					objWhizEffectiveDate.disabled=true;
					objReqEndDate.disabled=true;
					objNewAllocation.disabled=true;
				}
		  	}
		}
function Cancel_OnClick()
{
    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
    setFrameLoader();
    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action = "../PM/PM_ChangeAllocationType.aspx?MODE=CANCEL&RequestID=<%=intRequestID%>";
			objform.submit();
		}
	function ValidAllocation()
    {
			var objNewAllocation= GetObjectReference('frmPM_ChangeAllocation','txtNewAllocation');
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

        //Commented By Usha Pandit On 10.04.2020 For random alert issue
        <%--if (objNewAllocation.value == '<%=m_OldAllocation%>') {
            alert('New Allocation should be different than current Allocation');
            return false;
        }--%>
		//End Of Commented By Usha Pandit On 10.04.2020 For random alert issue		
					if ('<%=strRequestType%>'=='P')
					{
					
						 strMsg='New Allocation Percentage should be in the range of 1 To <%=m_StdAllocationPercentage%>';
					 	if(disallowValueRangeViolation(objNewAllocation, 1, '<%=m_StdAllocationPercentage%>', strMsg))
					     { objNewAllocation.value='';
					      return false;
					      }
					
					}	
					if ('<%=strRequestType%>'=='HPD')
					{
						strMsg = 'New Work Hours per day should be in the range of 1 To 24';
						if(disallowValueRangeViolation(objNewAllocation, 1, 24, strMsg))
						{ objNewAllocation.value='';
							return false;
						}
					}	
			return true;
		}
			function RejectRequest_OnClick()
		{
			if(confirm("<%=MyBase.GetResourceString("REJECT_REQUEST_CONFIRM")%>"))
			{
				window.open("../HR/HR_AddComments.aspx?From=ChangeAllocation&Mode=REJECT_REQUEST&RequestID=<%=m_intRequestID%>&Flag=3","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
			}
		}
		
		function GetWorkHoursold()
		{			
			var strUrl; 
			var objReqEndDate = GetObjectReference('frmPM_ChangeAllocation','txtReqEndDate');
			var objWHIZReqEndDate = GetObjectReference('frmPM_ChangeAllocation','FFE29587WHIZ_txtReqEndDate');		
			var objEndDate = GetObjectReference('frmPM_ChangeAllocation','txtEndDate');
			var objProjEndDate =GetObjectReference('frmPM_ChangeAllocation','txtProjEndDate');
			var objStartDate=GetObjectReference('frmPM_ChangeAllocation','txtStartDate');
			var objWorkHours = GetObjectReference('frmPM_ChangeAllocation','txtHours');
			var objEffectiveDate= GetObjectReference('frmPM_ChangeAllocation','txtEffectiveFromDate');
			var objWhizEffectiveDate= GetObjectReference('frmPM_ChangeAllocation','FFE29587WHIZ_txtEffectiveFromDate');
			if(objWhizEffectiveDate==null)
			    var objWhizEffectiveDate= GetObjectReference('frmPM_ChangeAllocation','txtEffectiveFromDate');
		    //End of Commented and added by Bharat T on 14th-Oct-2015
			var objNewAllocation=GetObjectReference('frmPM_ChangeAllocation','txtNewAllocation');
			var objTotalhrsSpan= GetObjectReference('frmPM_ChangeAllocation','TotalHrsSpan');
			if (ValidAllocation()==false)
				return false;
			if ('<%=strRequestType%>'=='TH')
			{
			objWorkHours.value=objNewAllocation.value;
			objTotalhrsSpan.innerHTML=objNewAllocation.value;
			return;
			}
		    //Commented And Added On 24/05/2016 For Javascript Error On date Control
		    //if(!DateControl_StandardOnblur('frmCommonPage','txtEffectiveFromDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
		    if(!DateControl_StandardOnblur('frmPM_ChangeAllocation','txtEffectiveFromDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
                //End of Addition By Vaijat K
	       { return false; }
		 if (objWhizEffectiveDate.value == '' || objEffectiveDate.value == '')
			{
				objWorkHours.value = '';
	            //alert('Please Enter Effective Date');
				return;
			}
			else
			{
				if (disallowDate1GreaterThanDate2(objEffectiveDate,objReqEndDate,"Requested Effective Date should be less than Resource End Date on Project.") == false) 
		  		{
		  			if (disallowDate1GreaterThanDate2(objStartDate,objEffectiveDate,"Requested Effective Date should  be greater than Resource start date on Project.") == false)
		  			{
		  				strUrl = new String();
			
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
						    //Added by Dhanashri S on 5 Jan 2016	
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
                            //End of Addition by Dhanashri S on 5 Jan 2016
						}
		  			}
		  			else
		  			{
		  			objWhizEffectiveDate.value = '';
					objWorkHours.value = '';
		  			}
		  		}
		  		else
		  		{
		  			objWhizEffectiveDate.value = '';
					objWorkHours.value = '';
		  		}
		  	}
            } 

            function GetWorkHours() {
                var strUrl;
                var objReqEndDate = GetObjectReference('frmPM_ChangeAllocation', 'txtReqEndDate');
                var objWHIZReqEndDate = GetObjectReference('frmPM_ChangeAllocation', 'FFE29587WHIZ_txtReqEndDate');
                var objEndDate = GetObjectReference('frmPM_ChangeAllocation', 'txtEndDate');
                var objProjEndDate = GetObjectReference('frmPM_ChangeAllocation', 'txtProjEndDate');
                var objStartDate = GetObjectReference('frmPM_ChangeAllocation', 'txtStartDate');
                var objWorkHours = GetObjectReference('frmPM_ChangeAllocation', 'txtHours');
                var objEffectiveDate = GetObjectReference('frmPM_ChangeAllocation', 'txtEffectiveFromDate');
                var objWhizEffectiveDate = GetObjectReference('frmPM_ChangeAllocation', 'FFE29587WHIZ_txtEffectiveFromDate');
                if (objWhizEffectiveDate == null)
                    var objWhizEffectiveDate = GetObjectReference('frmPM_ChangeAllocation', 'txtEffectiveFromDate');
                //End of Commented and added by Bharat T on 14th-Oct-2015
                var objNewAllocation = GetObjectReference('frmPM_ChangeAllocation', 'txtNewAllocation');
                var objTotalhrsSpan = GetObjectReference('frmPM_ChangeAllocation', 'TotalHrsSpan');
                if (ValidAllocation() == false)
                    return false;

                if ('<%=strRequestType%>' == 'TH') {
                    objWorkHours.value = objNewAllocation.value;
                    objTotalhrsSpan.innerHTML = objNewAllocation.value;
                    return;
                }
                //Commented And Added On 24/05/2016 For Javascript Error On date Control
                //if(!DateControl_StandardOnblur('frmCommonPage','txtEffectiveFromDate','<%=CommonFunctions.Application.InputeDateFormat()%>','Invalid Date format or Invalid Date.'))
                if (!DateControl_StandardOnblur('frmPM_ChangeAllocation', 'txtEffectiveFromDate', '<%=CommonFunctions.Application.InputeDateFormat()%>', 'Invalid Date format or Invalid Date.'))
                //End of Addition By Vaijat K
                { return false; }
                if (objWhizEffectiveDate.value == '' || objEffectiveDate.value == '') {
                    objWorkHours.value = '';
                    //alert('Please Enter Effective Date');
                    return;
                }
                else {
                    if (disallowDate1GreaterThanDate2(objEffectiveDate, objReqEndDate, "Requested Effective Date should be less than Resource End Date on Project.") == false) {
                        if (disallowDate1GreaterThanDate2(objStartDate, objEffectiveDate, "Requested Effective Date should  be greater than Resource start date on Project.") == false) {
                            strUrl = new String();

                            strUrl = '../General/XMLHttp.aspx?TagID=1019&Action=GETWORKHRS&Mode=PreponeBooking&EndDate=' + objReqEndDate.value + '&ProjectEmployeeRoleId=<%=m_intProjectEmployeeRoleId%>&EffectiveDate=' + objEffectiveDate.value + '&NewAllocation=' + objNewAllocation.value;
                            //if (document.all)
                            //{ 
                            //	objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
                            //	objXHttp.onreadystatechange = HandlerOnReadyState; 
                            //	objXHttp.open('GET',strUrl, false); 
                            //	objXHttp.send();           
                            //}  
                            //else  
                            //{

                            //Added by Dhanashri S on 5 Jan 2016	
                            if (WhichBrowser() == 'IE') // Added By Vaijat K ON 08/12/2015 IssueID-2660
                            {
                                objXHttp = new ActiveXObject('Msxml2.XMLHTTP');
                                objXHttp.onreadystatechange = HandlerOnReadyState;
                                objXHttp.open('GET', strUrl, false);
                                objXHttp.send();
                            }
                            else {

                                objXHttp = new XMLHttpRequest();
                                objXHttp.onreadystatechange = HandlerOnReadyState();
                                objXHttp.open('GET', strUrl, false);
                                objXHttp.send(null);

                                if (objXHttp.responseText != null) {
                                    xmlDoc = document.implementation.createDocument("", "", null);
                                    xmlDoc.async = false;
                                    if (WhichBrowser() == 'FF') // Added By Vaijat K ON 08/12/2015
                                        xmlDoc.load(objXHttp.responseXML);
                                    strResult = objXHttp.responseText;

                                    var objWorkHours = GetObjectReference('frmPM_ChangeAllocation', 'txtHours');
                                    var objTotalhrsSpan = GetObjectReference('frmPM_ChangeAllocation', 'TotalHrsSpan');
                                    objWorkHours.value = objXHttp.responseText
                                    var arrValues = objXHttp.responseText.split("|");
                                    objWorkHours.value = arrValues[1];
                                    objTotalhrsSpan.innerHTML = arrValues[1];
                                }
                            }
                            //End of Addition by Dhanashri S on 5 Jan 2016
                            //}
                        }
                        else {
                            objWhizEffectiveDate.value = '';
                            objWorkHours.value = '';
                        }
                    }
                    else {
                        objWhizEffectiveDate.value = '';
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
	       
			<%=m_strScript%>		
			
		</Script>
		
	</body>
</HTML>
