<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ProjectClosure.aspx.vb" Inherits="PbNIT.PM_ProjectClosure" ValidateRequest="False"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>
<!-- <script src="../General/CommonFunctions.js"></script> -->
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*ADDED BY nILESH G ON 18/8/2016 */
    .clsTable td
    {
        vertical-align:top !important;
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
		
					<form id="frmProjectClosure" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
		<Script language="javascript">
		var objform=GetFormReference('frmProjectClosure');
		var objdivlist=GetObjectReference('frmProjectClosure','PageDiv');

		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		    //The div tag has id as PageDiv 
	    var brw = isIE(); 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//COMMENTED AND ADDED BY NILESH G ON 28/11/2015 FOR ISSUE ID 2517
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //}
			if (navigator.appName == 'Microsoft Internet Explorer'){
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop;
			}
			else{
			    intDivHeight = window.innerHeight - objdivlist.offsetTop;
			}

			if (intDivHeight < 100)
			intDivHeight = 100;
			if(brw=="IE")
			{
			    
			    objdivlist.style.height = intDivHeight-39+'px';	
			}
			else 
			    if(brw=="CR")
			    {
			        
			        objdivlist.style.height = intDivHeight-39 +'px';
			    }
			    else
		    if(brw=="FF")
			        {
			            
			            objdivlist.style.height = intDivHeight-40 +'px';
			        }
		    else
            objdivlist.style.height = intDivHeight;	}
			<%=m_strClientSideScript%>
		}
		    //END OF COMMENTED AND ADDED BY NILESH G ON 28/11/2015  FOR ISSUE ID 2517
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
			    //COMMENTED AND ADDED BY NILESH G ON 28/11/2015 FOR ISSUE ID 2517
			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    //}
			//if (intDivHeight < 100)	intDivHeight = 100;
			//objdivlist.style.height = intDivHeight;	}
			    if (navigator.appName == 'Microsoft Internet Explorer'){
			        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop;
			    }
			    else{
			        intDivHeight = window.innerHeight - objdivlist.offsetTop;
			    }

			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    if(brw=="IE")
			    {
			    
			        objdivlist.style.height = intDivHeight-39+'px';	
			    }
			    else 
			        if(brw=="CR")
			        {
			        
			            objdivlist.style.height = intDivHeight-39 +'px';
			        }
			        else
			            if(brw=="FF")
			            {
			            
			                objdivlist.style.height = intDivHeight-40 +'px';
			            }
			            else
			                objdivlist.style.height = intDivHeight;	}
			
		}
		
		function Save_OnClick()
		{
			var MAXLENGTH = 500, strMsg;
			var objControl;

			objControl = GetObjectReference('frmProjectClosure','txtLinesOfCode');
			strMsg = "<%=MyBase.GetResourceString("ENTER_NUMERIC_NON_NEGATIVE_VALUE")%>";
			if(disallowNegativeNumeric(objControl, strMsg, true))
				return;
									
			objControl = GetObjectReference('frmProjectClosure','txtFunctionPoints');
			strMsg = "<%=MyBase.GetResourceString("ENTER_NUMERIC_NON_NEGATIVE_VALUE")%>";
			if(disallowNegativeNumeric(objControl, strMsg, true))
				return;
			
			objControl = GetObjectReference('frmProjectClosure','txtBackedUp');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("BACKUP_STATUS")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;			

			objControl = GetObjectReference('frmProjectClosure','txtDataLabeled');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("PROJECT_DATA_LABELED")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtSoftwaresReturned');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("USED_SOFTWARES_RETURNED")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;		
				
			objControl = GetObjectReference('frmProjectClosure','txtCProductsReturned');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("CUTOMER_PRODUCTS_RETURNED")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
		
			objControl = GetObjectReference('frmProjectClosure','txtProjectFeedback');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("PROJECT_FEEDBACK")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtSuggestions');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("SUGGESTIONS_AND_IMPROVEMENT")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtBestPractices');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("PRACTICES_FOLLOWED")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtShortcomings');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("SHORT_COMMINGS")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtReasonClosure');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("PROJECT_CLOSURE_REASON")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtOCommitments');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("OUTSTANDING_COMMITMENTS")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtFutureControl');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("FUTURE_PROJECT_CONTROL")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
				
			objControl = GetObjectReference('frmProjectClosure','txtSignoffDocuments');
			strMsg = "<%=MyBase.GetResourceString("MAXIMUM_SIZE")%>";
			strMsg = replaceSubstring(strMsg, "<=>", "<%=MyBase.GetResourceString("SIGNOFF_DOCUMENT")%>");
			if(disallowMaxlengthViolation(objControl, MAXLENGTH, strMsg, true))
				return;
	
				
			
			objControl = GetObjectReference('frmProjectClosure','txtEMailID');
			if((objControl != null) && (objControl.value != ""))
			{
				strMsg = "<%=MyBase.GetResourceString("ENTER_VALID_EMAIL_ID")%>";
				if(ValidateEmailIDs(objControl.value)==false)
				{	
					alert(strMsg);
					setFocus(objControl);
					return;
				}
			}
			//Start_AJ_10-Oct-2006
			var objDAEntryDate = GetObjectReference('frmProjectClosure','txtHidMaxDAEntryDate');
			var objActualEndDate = GetObjectReference('frmProjectClosure','txtActualEndDate');
			var objCurrentDate = GetObjectReference('frmProjectClosure','txtHidCurrentDate');
									
			if(disallowBlank(objActualEndDate, "Actual End Date should not be left blank.", true))
			return;
			
			if(disallowDate1LessThanDate2(objActualEndDate, objDAEntryDate, 'Actual End Date(' + objActualEndDate.value +') should not be less than Maximum of Timesheet Entry Date('+ objDAEntryDate.value+')/Todays Date('+objCurrentDate.value+').', true))
			return;
			
			if(disallowDate1GreaterThanDate2(objActualEndDate, objCurrentDate, 'Actual End Date(' + objActualEndDate.value +') should not be greater than Todays Date('+ objCurrentDate.value+').', true))
			return;
			
			var obj = GetObjectReference('frmProjectClosure','txtCnt');
			if (obj != null)
			if(parseInt(obj.value)!="0")
			{
			alert("Please close all the tasks before closing the Project.");
			window.open("../PM/PM_ProjectClosure_TaskClosure.aspx?FromSaveAndClose=1","","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=450");
			return;
			}
			//End_AJ_10-Oct-2006
						
			objform.action = "PM_ProjectClosure.aspx?MasterTagID=<%=m_lngMasterTagId%>&Action=<%=ACTION_SAVE%>";
			objform.submit();
		}
		
		function ReOpen_OnClick()
		{
			//var status=
			// Code added by SwapnilR on 10th Oct 2006
			// Purpose : To capture the reason for project reopening
			
			// objform.action = "PM_ProjectClosure.aspx?MasterTagID=<%=m_lngMasterTagId%>&Action=<%=ACTION_REOPEN%>";
			// objform.submit();
			//Added by TruptiK on 19-Mar-2008
			if (<%=m_status%>==0)
			{
				alert("Please map status to 'Reopen' at corporate level");
				return;
			}
			//End of addition by TruptiK on 19-Mar-2008
			window.open("../General/CommonPage.aspx?Mode=ADD_NEW&FromWhere=PM&MasterTagId=3659","_blank", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ", top=" + (window.screen.height - 500)/2 +",width=500,height=250")
			// End of code addition by SwapnilR on 10th Oct 2006
		}
		
		function SendEmail_OnClick()
		{
			window.open("../General/SendEmail.aspx?MessageID=17","","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
		}
		//Start_AJ_10-Oct-2006
		function Task_Closure()
		{
			window.open("../PM/PM_ProjectClosure_TaskClosure.aspx?FromSaveAndClose=0","","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
		}
		function Show_History()
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=3660","", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=800,height=600");
		}
		function Save_ProjectClsoureInfo()
		{

		    
			//Added By JyotiG
			//Start
			//1) Lines Of Code : 
			objControl = GetObjectReference('frmProjectClosure','txtLinesOfCode');
			strMsg = "<%=MyBase.GetResourceString("ENTER_NUMERIC_NON_NEGATIVE_VALUE")%>";
			if(disallowNegativeNumeric(objControl, strMsg, true))
				return;
									
			objControl = GetObjectReference('frmProjectClosure','txtFunctionPoints');
			strMsg = "<%=MyBase.GetResourceString("ENTER_NUMERIC_NON_NEGATIVE_VALUE")%>";
			if(disallowNegativeNumeric(objControl, strMsg, true))
				return;
			//End of Modification By JyotiG	
		    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
			var MenuTags = document.getElementsByTagName('A');
			for(i = 0; i < MenuTags.length; i++)
			{
			    if (MenuTags[i].className == "Menu")
			    {
			        //MenuTags[i].style.display= "none";
			        MenuTags[i].parentNode.style.display= "none";
			    }
			}
		    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
			objform.action = "PM_ProjectClosure.aspx?MasterTagID=<%=m_lngMasterTagId%>&Action=<%=ACTION_SAVEDATA%>";
			objform.submit();
		}
		//End_AJ_10-Oct-2006
		
		///// Function for Email Id Validation //////
		function isEmail(str) {
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
		
		function ValidateEmailIDs(strEmailList)
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
					return false;
				}				
			}
			return true;
		}
					</Script>
				
	</body>
</HTML>
