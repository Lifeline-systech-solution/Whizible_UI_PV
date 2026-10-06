<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_RequestDetail.aspx.vb" Inherits="PbNIT.CRM_RequestDetail"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Request Details")%>
	<link rel='stylesheet' type='text/css' href='../General/tab-view.css'/> 
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="FlowLayout" >

		<form id="frmRequestDetails" name="frmRequestDetails" method="post" runat="server">

		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 99.9%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>			
			<%ModifyWritePage%>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

	<script src="../../responsive/responsive.js"></script>
	<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
 
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle !important;
    }
    .footerMenuTable
    {
            bottom: 4px;
            position: absolute;
            left: -4px;
    }
    /*Added by Dhanashri S on 7 Dec 2015 For IssueID:1928 */
    /*Commented By Vaijat K ON 09/02/2016*/
    /*.clsTable td
    {
        vertical-align: top !important;
    }*/
     pre {
        background-color: transparent !important;
        border: 0px !important;
    }
    /*End of Addition by Dhanashri S on 7 Dec 2015*/
</style>

<script type="text/javascript">
    $(document).ready(function()
    {
       // alert(1);
        //setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
	<script language="javascript">

	    //window.onload = function(){
	    //    RemoveFrameLoader();
	    //}
	  	var objform;
		var objdivlist;
		var objcboFunction;
		var objcboSubRequestType;
		var objcboRequestType;
		var objtxtSubject;
		var objcboPriority;
		var objtxtResolutionDate;
		var objtxtCRMResolutionDate;
		var objcboStatus;
		var objcboTargetLocation;
		var objcboFeedback;var objtxtFeedbackComments;
		var objcboAssignTo;
		var objtxtHiddenServerDate;
		var objtxtHiddenPrevResolutionDate;
		var objtxtHiddenCRMPrevResolutionDate;
		//Added By JyotiG for Help Desk Issue (04-Jan-2007)
		//Start_JG_9145_04-Jan-2007
		var strExposeToCust;
		//End_JG_9145_04-Jan-2007
		//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4262
		// Code Added By PradipK for Help Desk SLA 
		var objtxtStatusChangeDate;
		var objtxtStatusChangeTIme;
		var objStatusTime
		var objStatusDate
		var objCurrentDate
		var objOldStatus
		var objOldStatusChangeDate
		var objOldStatusChangeTime
		var objNewStatus
		var objDate
		var  objResolutionDate
		var objTime
		// End Addition By PradipK for Help Desk SLA 
		//End Integration
		var objtxtHiddenFilterState;
		var objtxtHiddenFilter;
		var objtxtHiddenDepartment;
		var objtxtHiddenStatus;
		var CanSave;
		CanSave=true;
		var objlblSave= GetObjectReference('frmRequestDetails','lblSave',true);
		
		//Modified by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
			var LoginType="<%=m_strLoginType%>";
		 	var Db_FilterID ;
		 	var Md_FilterID ;
			var Sr_FilterID ;
			var Ar_FilterID ;
			var DepartmentID;
			var StatusID ;
			 var PageNumber = GetObjectReference('frmRequestDetails','hidPageNumber');
			if(PageNumber != null)
			PageNumber = PageNumber.value;
			 
		//Ended by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
		
		var showSubRequest = "<%=m_strShowSubRequest%>";
			var blnViewAccessOrHRM = <%=blnViewAccessOrHRM%> ;
			
		
		objform = GetFormReference('frmRequestDetails');
		objdivlist = GetObjectReference('frmRequestDetails','divList');
		objcboFunction = GetObjectReference('frmRequestDetails','cboFunction');
		
		//To Solve Page Crash Issue for Validation
		//Code Chaged By SantoshK on 29th Jan 2004
		//Issue 15404 - While adding an New helpDesk Request the page crashes. 
		if (showSubRequest == "True" )
		{			
			objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
		}
		else
		{
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
		}
		//Addition Ends
		
		objtxtSubject = GetObjectReference('frmRequestDetails','txtSubject');
		//Added by PrajaktaR on 17th Feb 2007 for Disabling the control if Status is closed PMLifeLine SP9 IssueID 10295
		objtxtDescription = GetObjectReference('frmRequestDetails','txtDescription');
		objtxtchangedTime = GetObjectReference('frmRequestDetails','txtchangedTime');
		objcboproject = GetObjectReference('frmRequestDetails','cboproject');
		objFFE29587WHIZ_txtResolutionDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtResolutionDate');
		objFFE29587WHIZ_txtchangedDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDate');
		//Added by ShraddhaM on 27,Mar 2008
		objFFE29587WHIZ_txtCRMResolutionDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtCRMResolutionDate');
		//End of additon bt ShraddhaM on 27,mar 2008
		objcboProduct = GetObjectReference('frmRequestDetails','cboProduct');
		objcboModule = GetObjectReference('frmRequestDetails','cboModule');
		objcboSeverity = GetObjectReference('frmRequestDetails','cboSeverity');
		//END OF Addition by PrajaktaR on 17th Feb 2007 for Disabling the control if Status is closed PMLifeLine SP9 IssueID 10295
		objcboPriority = GetObjectReference('frmRequestDetails','cboPriority');
		objtxtResolutionDate = GetObjectReference('frmRequestDetails','txtResolutionDate');
		objtxtCRMResolutionDate= GetObjectReference('frmRequestDetails','txtCRMResolutionDate');
		objcboStatus = GetObjectReference('frmRequestDetails','cboStatus');
		objcboTargetLocation = GetObjectReference('frmRequestDetails','cboTargetLocation');
		objcboFeedback = GetObjectReference('frmRequestDetails','cboFeedback');
		objtxtFeedbackComments = GetObjectReference('frmRequestDetails','txtFeedbackComments');
		objcboAssignTo = GetObjectReference('frmRequestDetails','cboAssignTo');
		objtxtHiddenServerDate = GetObjectReference('frmRequestDetails','txtHiddenServerDate');
		objtxtHiddenPrevResolutionDate = GetObjectReference('frmRequestDetails','txtHiddenPrevResolutionDate');
		objtxtHiddenCRMPrevResolutionDate = GetObjectReference('frmRequestDetails','txtHiddenCRMPrevResolutionDate');
		objtxtHiddenSubmittedDate = GetObjectReference('frmRequestDetails','txtHiddenSubmittedDate');
		objtxtCRMResolutionDate = GetObjectReference('frmRequestDetails','txtCRMResolutionDate');
		
		objtxtHiddenFilterState = GetObjectReference('frmRequestDetails','txtHiddenFilterState');
		objtxtHiddenFilter = GetObjectReference('frmRequestDetails','txtHiddenFilter');
		objtxtHiddenDepartment = GetObjectReference('frmRequestDetails','txtHiddenDepartment');
		objtxtHiddenStatus = GetObjectReference('frmRequestDetails','txtHiddenStatus');
		
		//Added by ShraddhaM on 15,Feb 2008 to disable Date Controls
		var objtxtchangedDate=GetObjectReference('frmRequestDetails','txtchangedDate');
		var objtxtComments=GetObjectReference('frmRequestDetails','txtComments');
		//End of additon by ShraddhaM on 15,Feb 2008 to disable Date Controls
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function validate()
		{
			var mode = "<%=m_strMode%>";
			var fromwhere = "<%=m_strFromWhere%>";
			if (disallowBlank(objcboFunction,"<%=m_strFunction_Caption%> cannot be blank",true)) return false;

			//Solve Page crash Issue
			//Code Chaged By SantoshK on 29th Jan 2004
			////Issue 15404 - While adding an New helpDesk Request the page crashes. 
			if (showSubRequest == "True")
			{
				if (disallowBlank(objcboRequestType,"Request Type cannot be blank",true)) return false;
				if (disallowBlank(objcboSubRequestType,"<%=m_strSubRequestType_Caption%> cannot be blank",true)) return false;
			}
			else
			{
				if (disallowBlank(objcboSubRequestType,"Request Type cannot be blank",true)) return false;
			}
			//Addition Ends
		
			//if (disallowBlank(objcboSubRequestType,"<%=m_strSubRequestType_Caption%> cannot be blank",true)) return false;
			if (disallowBlank(objtxtSubject,"<%=m_strSubject_Caption%> cannot be blank",true)) return false;
			if (disallowBlank(objcboPriority,"<%=m_strPriority_Caption%> cannot be blank",true)) return false;
			//Added By ShraddhaM on 4,July 2007
			//For Blank Validation of ResolutionDate , CRMResolutionDate
					  
			var objtxtResolutionDate = GetObjectReference('frmRequestDetails','txtResolutionDate');			 				 
			var objtxtCRMResolutionDate = GetObjectReference('frmRequestDetails','txtCRMResolutionDate');
			var FFE29587WHIZ_objtxtCRMResolutionDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtCRMResolutionDate');
//Addition by SuchitraP on 13 March 2008 for IssueID=16825
var objCRMDate_Visible;

if(objtxtCRMResolutionDate.type.toUpperCase()=="HIDDEN")
objCRMDate_Visible=FFE29587WHIZ_objtxtCRMResolutionDate;
else
objCRMDate_Visible=objtxtCRMResolutionDate;
//End of addition by SuchitraP
					
			if(fromwhere == "DB")
			{
				if(objtxtResolutionDate!=null)
				{
					if(objtxtResolutionDate.value=="")
					{
						alert('Exp. Date of Resolution should not be left blank');
						setFocus(objtxtResolutionDate);
						return;
					}
				}
				if(objtxtCRMResolutionDate!=null)
				{					 
					//Comment and modification by SuchitraP on 13 March 2008 for IssueID=16825
					//if(FFE29587WHIZ_objtxtCRMResolutionDate.style.display != "none")					
					if(objCRMDate_Visible.style.display != "none")
					//End of modification by SuchitarP	
					if(objtxtCRMResolutionDate.value=="")
					{
						alert("CRM's Exp. Date of Resolution should not be left blank");
						setFocus(objtxtCRMResolutionDate);
						return;
					}
				}
			}
			if(fromwhere == "SR")
			{
				if(LoginType=='E')
				{		
					if(objtxtResolutionDate!=null)
					{
						if(objtxtResolutionDate.value=="")
						{
							alert('Exp. Date of Resolution should not be left blank');
							setFocus(objtxtResolutionDate);
							return;
						}
					}
				}
			}
			if(fromwhere == "MD")
			{
							
							
				if(LoginType=='E')
				{		
					if(objtxtResolutionDate!=null)
					{
						if(objtxtResolutionDate.value=="")
						{
							alert('Exp. Date of Resolution should not be left blank');
							setFocus(objtxtResolutionDate);
							return;
						}
					}
				}
				if(objtxtCRMResolutionDate!=null)
				{
					//Commented and addded by ShraddhaM on 28,Mar 2008 for firefox change.
					//if(FFE29587WHIZ_objtxtCRMResolutionDate.style.display != "none")	
					if(objCRMDate_Visible.style.display != "none")
					//End of comment and addition by ShraddhaM  on 28,Mar 2008
					if(objtxtCRMResolutionDate.value=="")
					{
						alert("CRM's Exp. Date of Resolution should not be left blank");
						setFocus(objtxtCRMResolutionDate);
						return;
					}
				}
			} 
						
			//Ended By ShraddhaM on 4,July 2007
			
			//Integrated by SavitaS on 22 Dec 2005 to check whether ResolutionDate is null
			if(objtxtResolutionDate != null){
			//Commented by SrikanthY on 28 Feb 2007 To make Exp Date of Resolution Non Mandatory in Edit mode
			//if (disallowBlank(objtxtResolutionDate,"<%=m_strExpectedResolvedDate_Caption%> cannot be blank",true)) return false;
			//End of comments by SrikanthY
			if (mode != "EDIT" && fromwhere == "SR")
			{
				if (disallowDate1LessThanDate2(objtxtResolutionDate,objtxtHiddenServerDate,"Please enter a date not less than the current date"))return false;
			}
			}//End Integration by SavitaS
			if (mode == "EDIT")
			{
					if((objtxtResolutionDate != null)&& (objtxtHiddenSubmittedDate != null))
					{
						if (compareDates(objtxtResolutionDate.value,objtxtHiddenSubmittedDate.value)!=0)
						{
						if (disallowDate1LessThanDate2(objtxtResolutionDate,objtxtHiddenSubmittedDate,"<%=m_strExpectedResolvedDate_Caption%> cannot be less than the Request Submission date - " + objtxtHiddenSubmittedDate.value))
						{
						return false;
					
						}
						}
					}	
					if((objtxtCRMResolutionDate != null)&& (objtxtHiddenSubmittedDate != null))
					{
					if (compareDates(objtxtCRMResolutionDate.value,objtxtHiddenSubmittedDate.value) !=0)
					{
					if (disallowDate1LessThanDate2(objtxtCRMResolutionDate,objtxtHiddenSubmittedDate,"<%=m_strCRMExpectedResolvedDate_Caption%> cannot be less than the Request Submission date - " + objtxtHiddenSubmittedDate.value))
						{
						return false;						
						}
					}
					}			
				
			if (disallowBlank(objcboStatus,"<%=m_strStatus_Caption%> cannot be blank",true)) return false;	
			//Integrated by GaneshD on 04 Jun 2009 for StatusFlow configuration
                    var validStatusNew;
                    var validStatusExist;

                    var objOldStatus = GetObjectReference('frmRequestDetails','txtOldStatus');
                    var objNewStatus = GetObjectReference('frmRequestDetails','cboStatus');

                    var objCompareStatus = GetObjectReference('frmRequestDetails','CmbStatus');
                    var objPrevStatus = GetObjectReference('frmRequestDetails','CmbPrevStatus');
                    var objStatusFlowCount = <%=m_StatusFlowCount%>
                    var statusFlag=0;

                    validStatusNew = ""
                    validStatusExist = "\n\n";
/*
                        if(objStatusFlowCount > 0)
	                    {
                    		
		                    for(i=0;i<=objCompareStatus.length-1;i++)
		                    {
			                    validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
		                    }
                    		
		                    for(i=0;i<=objCompareStatus.length-1;i++)
		                    {
		                        if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].text)
			                    {
				                    validStatusNew = objNewStatus[objNewStatus.selectedIndex].value;
				                    break;
			                    }
		                    }
		                     //alert(objOldStatus[objOldStatus.selectedIndex].text);
		                     //alert(objOldStatus.value);
		                    if (objNewStatus[objNewStatus.selectedIndex].text==objOldStatus.value)
		                    {
		                        validStatusNew=objNewStatus[objNewStatus.selectedIndex].value;
		                    
		                    }
		                    if(validStatusNew == "")
		                    {
			                    if(validStatusExist =="\n\n")
			                    {
				                    alert("'"+objOldStatus.value +"' is the last status configured in the status flow.");
			                    }
			                    else
			                    {
				                    alert('Invalid Status, Status can be change to one of the following ' + validStatusExist);
			                    }
			                    return false;
		                    }
	                     } */		
                  // Addition end by GaneshD on 09 Jun 2009                                 
			}
			//Integrated by SavitaS on 22 Dec 2005 to check whether ResolutionDate is null
			if(objcboTargetLocation != null)
			{
			//Addition by SuchitraP on 13 March 2008 
			//To remove the alert of OU cannot be blank for Customer login
			if(objcboTargetLocation.style.display!="none"){
			//End of addition by SuchitraP
			if (disallowBlank(objcboTargetLocation,"<%=m_strTargetLocation_Caption%> cannot be blank",true)) return false;
			}
			}//End Integration 
			
					
			if (fromwhere == "SR" && mode == "EDIT")
			{
				if (objcboStatus.value == "2" )
				{
					if (disallowBlank(objcboFeedback,"Please give your feedback",true)) return false;
					if (disallowBlank(objcboStatus,"",false)==false) 
					{
						if (disallowMaxlengthViolation(objtxtFeedbackComments,1000,"Please enter your comments within 1000 characters")) return false;
					}
				}
			}
			return true;
		}
		//Integrated by SavitaS on 02 Jan 2005 for whiz2
		//added by harshada d on 28 Nov 2005 for Show History option in CRM
		function ShowHistory_OnClick()
		{
		    window.open ("../General/CommonList.aspx?&MasterTagID=3100&QueryID=<%=m_lngQueryID%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		//end of addition by harshada d on 28 Nov 2005 for Show History option in CRM
		//End Integration by SavitaS
	    function Save_OnClick()
	    {	
	          //Added by swapnil aswale on 17th Nov 2015 for special character validation
	            var objSubject;
	            objSubject = GetObjectReference('frmRequestDetails','txtSubject');
	            //if (disallowSpecialCharacters(objSubject,"Characters '/:*?+\"><,\\\\' are not allowed")) return false;
	            //Ended

	            //Added By VarunA on 21-Mar-2009 IssueID-28534
	            //Purpose : In Add mode to have Save & Close Link and close the the window	
	            var closeChildWindow=(arguments.length>0)?arguments[0]:0;
	            //End By VarunA on 21-Mar-2009 IssueID-28534
		
	            //added by harshada d on 31 may 2006 for issue : filters not getting set on refreshing the page		
	            var fromwhere = "<%=m_strFromWhere%>";
			
	            //end of addition by harshada d for PMLifeLine on 31 st may 2006
	            var mode = "<%=m_strMode%>";
			
	            //Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4262
	            // Code Added By PradipK for Help Desk SLA 
	            if(mode == "EDIT")
	            {		
						
	                //objOldStatusChangeDate = GetObjectReference('frmRequestDetails','txtchangedDatehidden1');
	                objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
	                //alert('1 :' +objOldStatusChangeDate.value);
	                //objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtarea1');
	                objOldStatusChangeTime=window.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
					 					 
	                //objCurrentChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDate'];
					 
	                objCurrentChangeDate = GetObjectReference('frmRequestDetails','txtchangedDate');
	                //alert('2 :' +objCurrentChangeDate.value);
	                objCurrentChangeTime = GetObjectReference('frmRequestDetails','txtchangedTime');
					 
	                objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');
					  
	                objNewStatus=GetObjectReference('frmRequestDetails','cboStatus');
					 
	                objTime=GetObjectReference('frmRequestDetails','CurrentTime');
				 	 
	                objDate=GetObjectReference('frmRequestDetails','CurrentDate');
					 
	                objResolutionDate=GetObjectReference('frmRequestDetails','txtResolutionDate');
				 
				 
				  
	                if(LoginType=='E')
	                {			
	                    if(objCurrentChangeDate!=null)
	                    {
	                        if(objCurrentChangeDate.value=="")
	                        {
	                            alert('Status Change Date should not be left blank');
	                            return;
	                        }
	                    }
		 

	                    if (objCurrentChangeTime!=null)
	                    {
						   
	                        if (disallowBlank(objCurrentChangeTime,"<%=MyBase.GetResourceString("BLANKREPORTEDTIME")%>",true))
	                            return;
									
	                        if(isTime(objCurrentChangeTime,"<%=mybase.GetResourceString("INVALIDTIME",false)%>")==false)
	                        {
	                            return ;
	                        }
	                    }	
					
	                    //Modified by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
 
 
	                    // Validation: If Status is not changed,Then Disallow to Change Status Change Date & Status Change Time 
					
					 
				
	                    if(objOldStatusChangeDate.value!="" && objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate  !=null && objOldStatusChangeTime !=null && objCurrentChangeDate!=null && objCurrentChangeTime!=null ) 
	                    { 
	                        if (objOldStatus.value==objNewStatus.value)
	                        { 
	                            if (objOldStatusChangeDate.value!=objCurrentChangeDate.value || objOldStatusChangeTime.value !=objCurrentChangeTime.value )
	                            { 
	                                alert('Status date/time change can be done only when Status is changed !');
	                                if(objOldStatusChangeDate.value!=objCurrentChangeDate.value)
	                                    //setFocus(objCurrentChangeDate);
	                                    if(objOldStatusChangeTime.value!=objCurrentChangeTime.value)
	                                        setFocus(objCurrentChangeTime);
	                                return;
	                            }
	                        }
	                    }
							
	                    //Ended by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
  
	                    // Added by PrajaktaR
	                    if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objDate!=null && objTime!=null )
	                    {
	                        //if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
	                        if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
	                            return ;
	                    }	
	                    // End Of Addition by PrajaktaR
	                    if (objOldStatus!=null && objNewStatus!=null )
	                    {	  
	                        if (objOldStatus.value!=objNewStatus.value )
	                        {
							
	                            if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime!=null )
	                            {
									
	                                if(objOldStatusChangeDate.value!="" && objOldStatusChangeTime.value!="" && objCurrentChangeDate.value!="" && objCurrentChangeTime.value!="" )
	                                {
											
	                                    if(objOldStatusChangeDate.value==objCurrentChangeDate.value && objOldStatusChangeTime.value==objCurrentChangeTime.value) 
	                                    {
													  
	                                        alert("Status Change date & time should be greater than previous status Change date and time.");
	                                        //setFocus(objCurrentChangeTime);
	                                        return;
	                                    }
	                                    //else
	                                    //if(disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate , objOldStatusChangeTime,objCurrentChangeDate,objCurrentChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
	                                    if(disAllowDateTime1LessThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objOldStatusChangeDate,objOldStatusChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
	                                        return ;
	                                }
	                            }
	                        }
	                    }	 
	                }
	                //Validation :Status Change Status Date & Time Can not Be Greater than Current SERVER Date & time.
				
	                //integrated by harshada d for  PMLifeLine SP7
	                //Commented By ShraddhaM on 18 Aug 2006
	                /*//Added By AmitJ For PSPL IssueId = 22880
                    //Get TimeSpan  = CurrentTime(Save OnClick) - RenderedTime(Windows_OnLoad)
                   
                   
                var dat=new Date(); 
                var hrs=dat.getHours();
                var mins=dat.getMinutes();
                var CurrentTime	;
                var TimeSpanMin;
                var TimeSpanHr;
                var TimeSpan;
                
                if (hrs < 10)
                    hrs= '0'+hrs;
                if(mins < 10)
                    mins='0'+mins;
                    
            CurrentTime = hrs+':'+mins;	
    
    
            TimeSpanMin = mins - RenderedMin;
            TimeSpanHr = hrs - RenderedHr;
            
                if (TimeSpanMin < 0)
                {
                    TimeSpanHr = TimeSpanHr - 1;
                    if (TimeSpanHr < 10)
                            {
                            TimeSpanHr = '0'+TimeSpanHr ;
                            }
                            
                    TimeSpanMin = 60+(TimeSpanMin) ;
                                
                    if (TimeSpanMin  < 10)
                        {
                        TimeSpanMin  = '0'+TimeSpanMin;
                        }
                }
            else
                if (TimeSpanHr < 10)
                            {
                                TimeSpanHr = '0'+TimeSpanHr ;
                            }
                            
                if (TimeSpanMin  < 10)
                        {
                            TimeSpanMin  = '0'+TimeSpanMin;
                        }
                        
            TimeSpan = TimeSpanHr+':'+TimeSpanMin;	
            
            var TempObjTime ;	
            //End Of Addition  By AmitJ
                        
                        
                    if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objDate!=null && objTime!=null )
                    {
                        //if(objCurrentDate.value==objOldStatusChangeDate.value
                        //Added by AmitJ for PSPL ISSue 22880
                        // Add TimeSpan in ObjTime.value (ServerTime @(Windows_OnLoad)) which will give ServerTime @(Save_OnClick)		
                            
                            TempObjTime = objTime.value;		
                            
                            var objTimehr,objTimeMin;
                            objTimeMin = Right(objTime.value,2);
                            objTimehr = Left(objTime.value,2);															
                            
                            if (objTimeMin < 10)
                                {
                                    objTimeMin = Right(objTimeMin,1);
                                }
                            if (TimeSpanMin < 10)
                                {
                                    TimeSpanMin = Right(TimeSpanMin,1);							
                                }
                                
                            
                            
                            if (objTimehr < 10)
                                {
                                    objTimehr = Right(objTimehr,1);
                                }
                                
                            if(TimeSpanHr < 10)	
                                {
                                    TimeSpanHr = Right(TimeSpanHr,1);
                                }
                                
                            objTimeMin = parseInt(objTimeMin) + parseInt(TimeSpanMin); 
                            objTimehr = parseInt(objTimehr) + parseInt(TimeSpanHr);																																									
                            
                            if (objTimeMin >= 60 )
                                {
                                    objTimeMin =  objTimeMin - 60;
                                    objTimehr =  objTimehr + 1;	
                                }
                            if (objTimeMin < 10 )
                                {
                                        objTimeMin = '0' + objTimeMin ;
                                }
                                
                            
                            if (objTimehr >= 24)	
                                {
                                    objTimehr = parseInt(objTimehr) - 24;	
                                    objDate = GetObjectReference('frmRequestDetails','CurrentDate1');
                                    
                                    var TempObjDate  = objDate.value;
                                     var StatusDate = new Date(objDate.value);									
                                        StatusDate = DateAdd(StatusDate,1,0,0);										
                                        var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 									
                                        StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																											
                                        StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
                                        objDate.value = StatusDate 																		
                                    
                                }
                            if (objTimehr < 10 )	
                                {
                                    objTimehr = '0' + objTimehr;
                                }					
                            
                            
                            
                        objTime.value = objTimehr +':'+objTimeMin;			
                            
                // End Of Addition by AmitJ		*/			
												
			
	                /*if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Server Date' + objDate.value + ' & Time.' + objTime.value))
						{
						//Added by AmitJ for PSPL ISSue 22880							
							objTime.value = TempObjTime ;
							if (TempObjDate != null)
							{
								objDate.value = TempObjDate;
							}
							
						//End of Addition by AmitJ
							return ;
						}
						
				}	*/
	                //end of integration by harshada d
	                /*
                    if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objDate!=null && objTime!=null )
                    {
                        //if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
                        if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
                                return ;
                    }*/	
				  
	            }
	            // End of EDIT Mode
	
	            // End Addition By PradipK for Help Desk SLA 
	            //End Integration
			
		
            
	            if (validate()==true)
	            {  
	                ///Added By Amol Changle On: 22 Jul 2009
	                ///Purpose: ;
	              //  setFrameLoader();
	                if(!ValidateCustomFields()) return false;
	                ///End Addition	 
                                                           
	                //Added by ShraddhaM for Feedback comment change on 22,Sep 2009
	                var objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');					  
	                var objNewStatus=GetObjectReference('frmRequestDetails','cboStatus');
	                var FromWhere = "<%=m_strFromWhere%>";
	                if (objOldStatus!=null && objNewStatus!=null )
	                {
	                    if((objOldStatus.value != objNewStatus.value) && objNewStatus.value == '2' && FromWhere == 'SR')
	                    {                            
	                        showCommentDiv(event)                               
	                    }
	                    else
	                    {
	                        SaveData(closeChildWindow)
	                    }
	                }
	                else
	                {
	                    SaveData(closeChildWindow)
	                }
	                //Ended by ShraddhaM for Feedback comment change on 22,Sep 2009
	            }
			         	
	        }
	   
		function SaveData(closeChildWindow)
		{	
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();//added by Nilesh g on 15/6/2016 for add Loader on save link
		//var closeChildWindow=(arguments.length>0)?arguments[0]:0;
                    var fromwhere = "<%=m_strFromWhere%>";
			
		  
			var mode = "<%=m_strMode%>";
			
		     			<%'//Added BY NitinVS on 'Modifed By nitinVS on 14 Mar 2007 for PMLifeLine IssueId 11691 %>
						<%'To Mark Feedbackcomments and feedback as enabled before save %>
						if (objcboFeedback != null)
							objcboFeedback.disabled = false; 
						if (objtxtFeedbackComments != null)
							objtxtFeedbackComments.disabled = false; 
							
						<%'//End Added BY NitinVS on 'Modifed By nitinVS on 14 Mar 2007 for  PMLifeLine SP 8 IssueId 11691 %>
						objtxtSubject.disabled = false;
						objcboFunction.disabled = false;
						
						if (showSubRequest == "True")
						{
							objcboRequestType.disabled = false;
						}

						objcboSubRequestType.disabled = false;
						
						if(objcboTargetLocation != null)	
						objcboTargetLocation.disabled = false;
						/*  Modified By NitinVS on 30 Sep 2005 for PMLifeLine SP4 IssueID 2 
							to Save the value of objtxtCRMResolutionDate need to Enable It before Save */
						if (objtxtCRMResolutionDate != null) 
							objtxtCRMResolutionDate.disabled = false;
						/* End Modification By NitinVS on 30 Sep 2005 for PMLifeLine SP4 IssueID 2 */
											

						// Added By NitinVS on 19 Feb 2007 for PMLifeLine SP 9 IssueID 10366 
						if(objcboProduct != null )
						{
							objcboProduct.disabled = false;
							objcboModule.disabled = false;
						}
						
						if(objcboModule != null )
						{
							objcboModule.disabled = false;
						}
						
						if(objcboSeverity !=null)
						{
							objcboSeverity.disabled=false;
						}
						if (objtxtchangedTime != null)
						{
							objtxtchangedTime.disabled = false;
						}
						
						//End Addition  By NitinVS on 19 July 2007 for PMLifeLine SP 9 IssueID 10366 
						if(objcboPriority)
						objcboPriority.disabled = false;												
												
						//Added by ShraddhaM to enable control hile saving record
						if(objtxtchangedDate)
							objtxtchangedDate.disabled = false;
						if(objFFE29587WHIZ_txtchangedDate)	
							objFFE29587WHIZ_txtchangedDate.disabled = false;
						if(objFFE29587WHIZ_txtCRMResolutionDate)
							objFFE29587WHIZ_txtCRMResolutionDate.disabled = false;
						if(objtxtCRMResolutionDate)
							objtxtCRMResolutionDate.disabled = false;
						if(objFFE29587WHIZ_txtResolutionDate)
							objFFE29587WHIZ_txtResolutionDate.disabled = false;
						if(objtxtResolutionDate)
							objtxtResolutionDate.disabled = false;
						if(objtxtComments)
							objtxtComments.disabled = false;	
						if(objtxtDescription)
						    objtxtDescription.disabled=false;						
						//End of addition by ShraddhaM
						
						 //Added by shraddhaM on 11,Aug 2009 to disable custom fields for close request.
						 if(GetObjectReference('frmRequestDetails','CustomFieldList'))
						 {
				            var arrCustomFieldList = (GetObjectReference('frmRequestDetails','CustomFieldList').value).split(",");
				            var CustomControl;
				            for(var i=0;i<arrCustomFieldList.length;i++)
				            {   
				                CustomControl = GetObjectReference('frmRequestDetails',arrCustomFieldList[i]) ;
				                if(CustomControl)
				                CustomControl.disabled = false;
				            }
				         }
				        //Ended by ShraddhaM
				
						if (mode == "EDIT")
						{
							//objcboAssignTo.disabled = false;No need - PrashantD
							objcboStatus.disabled = false;
						}	
						//added by harshada d on 31 st 2006 for issue : filters not getting set on refresh page
						if(fromwhere == "DB")
						{
						Db_FilterID =window.opener.document.forms['frmDashboard'].elements['cboFilter'].value	;
						//Db_FilterID =win.document.forms['frmDashboard'].elements['cboFilter'].value	;
						
						}
						//Added by PrashantSJ on 09 Nov 2006 For PMLifeLine SP8 Build 1
						//Purpose: added code for My e-Dashboard like e-Dashboard
						if(fromwhere == "MD")
						{	
							//Commented and Added By VijayD On 12 Jun 2009
						    //Purpose : To Refresh the Parent Page of The Current Page.
							////if (window.opener != null && window.opener.location.href.match("CRM_MyDashboard.aspx") == "CRM_RequestList.aspx")
						    if (window.opener != null && window.opener.location.href.match("CRM_MyDashboard.aspx") == "CRM_MyDashboard.aspx" || window.opener.location.href.match("CRM_Dashboard.aspx") == "CRM_Dashboard.aspx")
							//End Comment and Addition By VijayD On 12 Jun 2009
							 
								Md_FilterID =window.opener.document.forms['frmMyDashboard'].elements['cboFilter'].value	;
						//Db_FilterID =win.document.forms['frmDashboard'].elements['cboFilter'].value	;
						}
						//End of addition by PrashantSJ on 09 Nov 2006
						//Modified by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
						if(fromwhere == "SR")
						{
							if(mode=="NEW")
							{
							//alert(window.opener.document.forms['frmRequestList'].elements['cboFilter'].value);
									if(blnViewAccessOrHRM==0)
									{
									    Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									    if(Sr_FilterID!=null){
										Sr_FilterID = Sr_FilterID.elements['cboFilter'].value;
										//DepartmentID = window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
										StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
								        }
									}
									else
									{
										//Integrated By AmitJ for Yash IssueId = 5088 => Error While assigning request from Help Desk
										//Commented and Modified By JyotiG for Help Desk Issue (04-Jan-2006)
										//Start_JG_03-Jan-2006
										if (strExposeToCust=='0' || LoginType =='C')
										{
								            Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									        if(Sr_FilterID!=null){
											Sr_FilterID = Sr_FilterID.elements['cboFilter'].value;
											//DepartmentID = window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
											StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
											}
										}
										else
										{
										////Sr_FilterID = window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
								            Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									        if(Sr_FilterID!=null){
										        Sr_FilterID = Sr_FilterID.elements['cboFilter'].value;
										        //DepartmentID = window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
										        ////StatusID = window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
										        StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
										     }
									    }
										//End_JG_03-Jan-2006
										//End of Integration By AmitJ
									}
									//SrikanthY on 23 Jan 2007 Added code to avoid script errors.Issues-9640,9650
									if (opener.location.href.indexOf('MasterTagID=3101')!= -1)
							        {
							        objtxtHiddenFilterState.value = 1;
							        ////objtxtHiddenFilter.value = window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
							        objtxtHiddenFilter.value = window.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
							        //objtxtHiddenDepartment.value=window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
							        ////objtxtHiddenStatus.value=window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
							        objtxtHiddenStatus.value=window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
							        }
							        //End of addition by SrikanthY on 23 Jan 2007
							   }
							//SrikanthY on 23 Jan 2007 Commented code,Added new code below to avoid script errors.Issues-9640,9650		
							/*if(mode=="EDIT")
							{			 
							  				 
							  		if(blnViewAccessOrHRM==0)
									{
										Sr_FilterID=window.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
										DepartmentID=window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
										StatusID=window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
									
									} 
									else
									{
										Sr_FilterID=win.document.forms['frmRequestList'].elements['cboFilter'].value;
										DepartmentID=win.document.forms['frmRequestList'].elements['cboDepartment'].value;
										StatusID=win.document.forms['frmRequestList'].elements['cboStatus'].value;
									}
								 
									
							}*/
							if(mode=="EDIT")
							{			 
							  			 
							  	    if ("<%=m_FilterData%>" == 1)	
							        {
										////if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										if (window.opener  != null && window.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										{
										
										    Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									        if(Sr_FilterID!=null){
											////Sr_FilterID=window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
											Sr_FilterID=Sr_FilterID.elements['cboFilter'].value;
											//DepartmentID=window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
											////StatusID=window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
											StatusID=window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
											}
										}
										else
										{ 
										    if(objtxtHiddenFilter!=null){
										        
											    Sr_FilterID=objtxtHiddenFilter.value;
											//DepartmentID=objtxtHiddenDepartment.value;
											    StatusID=objtxtHiddenStatus.value;
											 }
										}
									
							        }
							        else

									{
										////if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										if (window.opener != null && window.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										{
											Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									        if(Sr_FilterID!=null){
											////Sr_FilterID=window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
											Sr_FilterID=Sr_FilterID.elements['cboFilter'].value;
											//DepartmentID=window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
											////StatusID=window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
											StatusID=window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
										    }
										}
										else
										{
										    Sr_FilterID =  window.opener.document.forms['frmRequestList'];
									        if(Sr_FilterID!=null){
											    Sr_FilterID=Sr_FilterID.elements['cboFilter'].value;
											    //DepartmentID=window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
											    StatusID=window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
										    }
										}
									
									}
						
							}
						//End of addition by SrikanthY on 23 Jan 2007
						
			 
						}
				 
						//Ended by ShraddhaM on Date 15 June,2006 for PMLifeLine Issue ID.4168
						if(fromwhere == "AR")
						{		
						//Code Modified by SavitaS on 11 Sept 2006 for SP7 IssueId 5633		
						Ar_FilterID =window.opener.document.forms['frmRequestList']	;
						
						if(Ar_FilterID!=null){
						    Ar_FilterID = Ar_FilterID.elements['cboFilter'].value
						    StatusID =window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;	
						}
												
						//Ar_FilterID =win.document.forms['frmRequestList'].elements['cboFilter'].value	;
						//StatusID =win.document.forms['frmRequestList'].elements['cboStatus'].value;
						//End of Code Modified by SavitaS on 11 Sept 2006 for SP7 IssueId 5633
						}
			 
			             if(objlblSave!=null)
			            {
			                for(i=0;i<=objlblSave.length-1;i++)
			                {
			                    objlblSave[i].style.display='none';
			                    objlblSave[i].style.visibility='hidden';
			                } 
			            }
			            
						//Modified by SonalD on 23rd March 2009...closeChildWindow will be set to 1 if 'Save and Close' link is clicked
						//objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&Action=SAVE&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>";
						objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&Action=SAVE&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>&closeChildWindow=" + closeChildWindow;
						//End of modification by SonalD on 23rd March 2009
			            objform.submit();
						
						//Added by PrashantD on 30 April 2007 for IssueID 12619
						//Purpose: Sorting set by user does not persist
						//&SortBy=ExpectedResolvedDate&SortOrder=ASC
						var sortby="",sortorder="";
						if(window.opener.document.getElementById('hidSortBy'))
						{
							sortby = window.opener.document.getElementById('hidSortBy').value;
							sortorder = window.opener.document.getElementById('hidSortOrder').value;
						}
						
						
						if(fromwhere == "DB")
						{
						 //Commented and added by ShraddhaM on 1,Aug 2007			 
			            //To persists Paging number after saving reuest from edit mode
						//window.opener.location.href="CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID ;
						//Comment and Modification by SuchitraP on 18-mar-2009 for IssueID 29248
						//Purpose:When closed the request from the request page on the list page discussion thread save link doesn't 
						//			get displayed unless the page is refreshed explicitly.
						//window.opener.location.href="CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID + "&PageNumber=" + PageNumber;
						window.opener.location.href="CRM_Dashboard.aspx?Mode=<%=m_strFromWhere%>&Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID + "&PageNumber=" + PageNumber;
						//End of Comment and Modification by SuchitraP on 18-mar-2009 for IssueID 29248
					
						//Ended by ShraddhaM
						//win.location.href="CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID ;
						}
						//Added by PrashantSJ on 09 Nov 2006 For PMLifeLine SP8 Build 1
						//Purpose: added code for My e-Dashboard like e-Dashboard
						if(fromwhere == "MD")
						{
						    //Commented and Added By VijayD On 12 Jun 2009
						    //Purpose : To Refresh the Parent Page of The Current Page.
							//if (window.opener != null && window.opener.location.href.match("CRM_MyDashboard.aspx") == "CRM_RequestList.aspx")
						    if (window.opener != null && window.opener.location.href.match("CRM_MyDashboard.aspx") == "CRM_MyDashboard.aspx" || window.opener.location.href.match("CRM_Dashboard.aspx") == "CRM_Dashboard.aspx")
							 //End Comment and Addition By VijayD On 12 Jun 2009
							 
							//Commented and added by ShraddhaM on 1,Aug 2007			 
			                //To persists Paging number after saving reuest from edit mode
						    //window.opener.location.href="CRM_MyDashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Md_FilterID ;
						        //Modification and comment by SuchitraP on 5-Sept-2008 for CRM workflow links visibility
								//window.opener.location.href="CRM_MyDashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Md_FilterID + "&PageNumber=" + PageNumber;
								window.opener.location.href="CRM_MyDashboard.aspx?Mode=MD&Action=SET_DEFAULT_FILTER&FilterID=" +Md_FilterID + "&PageNumber=" + PageNumber;
								//End by SuchitraP
						
						}
						//End of addition by PrashantSJ on 09 Nov 2006
						else if(fromwhere == "SR")
						{
									
							//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							
								if(mode == "NEW")
								{				
									<%' Modified By NitinVS on 10 MAy 2007 for PMLifeLine 7.0%>
									if (window.opener != null && window.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
									//if(strExposeToCust=='0')
									{
										//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
										//Commented and added by ShraddhaM on 1,Aug 2007			 
			                //To persists Paging number after saving reuest from edit mode
						    			//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID+"&SortBy="+ sortby + "&SortOrder="+sortorder;
						    			window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&StatusID="+StatusID+"&SortBy="+ sortby + "&SortOrder="+sortorder + "&PageNumber=" + PageNumber;
									}
									else
									{
										//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
										////if(window.opener.opener!= null)
										if(window.opener!= null)
										//Commented and added by ShraddhaM on 1,Aug 2007			 
			                            //To persists Paging number after saving reuest from edit mode
										//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID+"&SortBy="+ sortby + "&SortOrder="+sortorder;
										////window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID+"&SortBy="+ sortby + "&SortOrder="+sortorder + "&PageNumber=" + PageNumber;
										 
										window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID+"&SortBy="+ sortby + "&SortOrder="+sortorder + "&PageNumber=" + PageNumber;
										
									}
								}
								if(mode == "EDIT")
								{
									  //SrikanthY on 23 Jan 2007 Commented code,Added new code below to avoid script errors.Issues-9640,9650		
							
									   //window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
									   /*if(blnViewAccessOrHRM==0)
										{
											window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							
										}
										else
										{									
											win.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
										}*/
									if ("<%=m_FilterData%>" == 1)	
							        {
										////if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										if (window.opener != null && window.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										//Commented and added by ShraddhaM on 1,Aug 2007			 
			                //To persists Paging number after saving reuest from edit mode
										//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
										////window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
										window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
										else
										window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
									}
							        else
							        {
										////if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
										var objHome = window.opener.document.getElementById('tblGroup17');
							            if(objHome!=null){}
							            else{
										    if (window.opener != null && window.opener.location.href.match("CRM_RequestList.aspx") == "CRM_RequestList.aspx")
											    ////window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
											    window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
										    else
											    window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID  +"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
									        }
							        }
							        //End of addition by SrikanthY on 27 Jan 2007
										
								}
							
						}
						if(fromwhere == "AR")
						{
						    var objHome = window.opener.document.getElementById('tblGroup17');
							//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=AR&FilterID=" +Ar_FilterID+"&StatusID="+StatusID;
							if(objHome!=null){}
							else 
							    window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=AR&FilterID=" +Ar_FilterID+"&StatusID="+StatusID + "&PageNumber=" + PageNumber;
							
						}
								
			 
			//Ended by ShraddhaM on Date 20 June,2006 for PMLifeLine Issue ID.4168

				//end of addition by harshada d on 31 st of may 2006 						
				 
						if(LoginType=='E' && strExposeToCust=='1' )
						{
							if(mode == "NEW")
							{
							window.opener.close();
							}
						}
		}
		
		function AddAttachment_OnClick()
		{
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		//window.open ("../General/Attachment.aspx?FromWhere=CRM&ID=<%=m_lngQueryID%>&Page=../CRM/CRM_RequestDetail.aspx&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
		/// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
		//window.open ("../General/Attachment.aspx?&FromWhere=CRM&ID=<%=m_lngQueryID%>&Page=../CRM/CRM_RequestDetail.aspx&Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromRequestDetail%>&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
		
		    ///Added by NitinC on 16 March 2011 for PMLifeLine version 10.0
            //Commented and modified By Aniruddh Gujar on 25-Nov-2015 Purpose::SEM Issue fixing
		    //window.open ("../General/MultiAttachment.aspx?TagID=405&FromWhere=CRM&ID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>&Mode=<%=m_strMode%>&Page=../CRM/CRM_RequestDetail.aspx&Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromRequestDetail%>&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 960)/2 + ",top=" + (window.screen.height - 470)/2 + ",width=650,height=470");
		    window.open ("../General/MultiAttachment.aspx?TagID=405&FromWhere=CRM&ID=<%=m_lngQueryID%>&Mode=<%=m_strMode%>&Page=../CRM/CRM_RequestDetail.aspx&Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromRequestDetail%>&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 960)/2 + ",top=" + (window.screen.height - 470)/2 + ",width=650,height=470");
		    //End of Commented and modified By Aniruddh Gujar on 25-Nov-2015 Purpose::SEM Issue fixing

		///End of Added by NitinC on 16 March 2011 for PMLifeLine version 10.0
		///Commented by NitinC on 16 March 2011 for PMLifeLine version 10.0
		//window.open ("../General/Attachment.aspx?TagID=405&FromWhere=CRM&ID=<%=m_lngQueryID%>&Page=../CRM/CRM_RequestDetail.aspx&Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromRequestDetail%>&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
		///End of Commented by NitinC on 16 March 2011 for PMLifeLine version 10.0
		
		/// Endo Modified by Archanan on 1-Oct-2010
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		
		function DeleteAttachment_OnClick()
		{
		//Added by ManishK on 21 Feb 06 for PMLifeLine IssueID 2356 
				var objchkDelete;
				var intIndex;
				var flag;
				flag=0;

				objchkDelete = GetObjectReference('objfrmRequestDetails','chkDelete',true);
				
				for(intIndex=0 ;intIndex < objchkDelete.length ;intIndex++)
				{
					if (objchkDelete[intIndex].checked==true)
					{
						flag=1;	
					}
				}
				
				if (flag==1)
				{
		//End of Added by ManishK on 21 Feb 06 for PMLifeLine IssueID 2356 	
					if (confirm("Are you sure, you want to delete the selected attachments?")==true)
						{
							// START : Commented and modified by ParagD 29-Sept-2006
							// objform.action = "CRM_RequestDetail.aspx?Action=DELETE_ATTACHMENTS&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>";
							objform.action = "CRM_RequestDetail.aspx?Action=DELETE_ATTACHMENTS&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>";
							// END : Commented and modified by ParagD 29-Sept-2006
							objform.submit();
						}
					
				}

	   }
		//SrikanthY on 1 Mar 2007 Modified Assign Tasks page Height,Width values
		function AssignTask_OnClick()
		{
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=<%=m_lngQueryID%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=400");	 
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
		}
		//End of modification by SrikanthY on 1 Mar 2007
		//SrikanthY on 1 Mar 2007 Modified Assign Issues page Height,Width values
		function AssignIssue_OnClick()
		{
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
			//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
//Commented by SrikanthY on 20 Dec 2006 To Change the Design of Issue Details Page for HelpDesk Enhancements
			//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
			//End of Comments by SrikanthY
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		    //window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=yes,width=800,height=500"); 
		    window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Assignment","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600"); 
		}
		// Modified By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 		
		//End of modification by SrikanthY on 1 Mar 2007		
		// Changed the height to 625 and Top to 75
		
		
		 //Added by Amit Mahadik on 21 Mar 2011 Purpose:PMLifeLine 
		function DeleteDiscussion_OnClick(queryid)
		{
		
				var objCheckbox = GetObjectReference('frmRequestDetails','chkDiscussionThread',true);
		        var intItems;
		        var intCtr;
		        var blnSelected=false;
        		
		        if (objCheckbox != null)
		        {
        			
				        for (intCtr = 0;intCtr <= objCheckbox.length - 1; intCtr++)
				        {
					        if (objCheckbox[intCtr].checked== true)
					        {
						        blnSelected=true;	
						        break;
					        }
				        }		
		        }	
        		
		        if(!blnSelected) { alert('Please select atleast one Discussion thread for delete !'); return; }        		
        	if (confirm("Are you sure, you want to delete the selected Discussion Thread(s)?")==true)
				{
	                objform.action = "CRM_RequestDetail.aspx?Action=DELETE_DISCUSSION&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>";
	                //alert("CRM_RequestDetail.aspx?Action=DELETE_DISCUSSION&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>");
		            objform.submit();
		        }
		}
		  //End Added by Amit Mahadik on 21 Mar 2011 Purpose:PMLifeLine 
		function Discussion_OnClick()
		{
			//window.open("CRM_DiscussionThread.aspx?QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			window.open("CRM_DiscussionThread.aspx?FromWhere=<%=m_strFromWhere%>&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			
		}
		// End Modification By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 	
		function cboFunction_OnChange()
		{	//Commented and Modified By JyotiG 
			//Start_JG_9145_04-Jan-2007
			//objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&RequestID=<%=m_lngQueryID%>&Status=FUNCTION_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>";
			objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&RequestID=<%=m_lngQueryID%>&Status=FUNCTION_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>&ExposeCust="+strExposeToCust;
			//End_JG_9145_04-Jan-2007
			if (showSubRequest =="True")
						{
							objcboRequestType.value = "";
						}
							objcboSubRequestType.value = "";
			objform.submit();
														
		}
	// Added By SriaknthY on 04 Jan 2006 To Integrate Product and Component Details on Request Screen
		function cboProduct_OnChange()
		{
		
			objcboFunction.disabled = false;			
		 	objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');		 			if (objcboRequestType!=null)
		    objcboRequestType.disabled = false;
			var product;
			product=objcboProduct.value;
			objform.action = "CRM_RequestDetail.aspx?&IsProductChange=1&Product="+ product +"&QueryID=<%=m_lngQueryID%>&Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&RequestID=<%=m_lngQueryID%>&Status=PRODUCT_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>";
			
			objform.submit();
														
		}
		//End of Addition by SrikanthY
		
		function cboStatus_OnChange()
		{
				if ("<%=m_strFromWhere%>" == "SR")
				{
					if (trimString(objcboStatus.value)== "2")
					{
					    //Commented By VarunA on 24-Sep-2008 IssueID-22553
		                //Purpose : Alignment problem while changing status as closed (Mozilla)
						//TRFeedback.style.display = "block";
						//TRFeedbackComments.style.display = "block";
						//TRFeedback.style.display = "";
						//TRFeedbackComments.style.display = "";
						//End By VarunA on 24-Sep-2008 IssueID-22553
					}
					else
					{
						TRFeedback.style.display = "none";
						TRFeedbackComments.style.display = "none";
					}
				}
			
				//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4262
				// Code Added By PradipK for Help Desk SLA 
				var objStatusTime= GetObjectReference('frmRequestDetails','txtchangedTime');
				var objStatusDate=GetObjectReference('frmRequestDetails','txtchangedDate');
				var objCurrentDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_CurrentDate');
				//var objCurrentDate1 = GetObjectReference('frmRequestDetails','CurrentDate1');
				
				var objWhizStatusDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDate');
				var objCurrentTime=GetObjectReference('frmRequestDetails','CurrentTime');
	
				var objOldStatusChangeDate_Control=window.document.forms['frmRequestDetails'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
				var objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
	
				//Modified By shraddhaM on 31 Aug 2006 for Whiz2
				if(navigator.appName == 'Netscape')
				{
						//var objOldStatusChangeDate=window.document.forms['frmDiscussion'].elements['txtchangedDatehidden1'];
						var objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
						var objStatusTime= GetObjectReference('frmRequestDetails','txtchangedTime');
						var objStatusDate=GetObjectReference('frmRequestDetails','txtchangedDate');
						var objCurrentDate = GetObjectReference('frmRequestDetails','CurrentDate');
						 
						var objWhizStatusDate = GetObjectReference('frmRequestDetails','txtchangedDate');
						var objCurrentTime=GetObjectReference('frmRequestDetails','CurrentTime');
	
				}
				else
				{
					var objOldStatusChangeDate_Control=window.document.forms['frmRequestDetails'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
					var objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
				}				 
								//objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtarea1');
				var objOldStatusChangeTime=window.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
						 
				
				var objNewStatus = GetObjectReference('frmRequestDetails','cboStatus');
				var objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');
				var objReadOnlychangedDate = GetObjectReference('frmRequestDetails','txtReadOnlychangedDate');
					//Commented By ShraddhaM on 18 Aug 2006
					//var d=new Date(); 
					//var d;
					//d=objCurrentTime.value
					//var h=d.getHours();
					//var h=Left(d,2);
					//var m=d.getMinutes();
					//var m=Right(d,2);
					//alert(h);
					//alert(m);
		
					//integrated by harshada d for PMLifeLine sp7
					//Added By Amit J for PSPL IssueId  22880
					// Get StatusChangeTimeSpan = CurrentTime(clientTime)@(cboStatus_OnChange) - RenderedTime@(Windows_OnLoad)
					
	
					//Commented By ShraddhaM on 18 Aug 2006
								var objTimehr,objTimeMin;
								objTimeMin = Right(objCurrentTime.value,2);
								objTimehr =Left(objCurrentTime.value,2);
					
					/*var StatusChangeTimeSpanHr;
					var StatusChangeTimeSpanMin;
					var StatusChangeTimeSpan;
					
					
					StatusChangeTimeSpanHr = h - RenderedHr;	
					
						
					StatusChangeTimeSpanMin = m - RenderedMin;
					//StatusChangeTimeSpanHr = h - RenderedHr;
						
						if (StatusChangeTimeSpanMin < 0)
							{
								StatusChangeTimeSpanHr = Number(StatusChangeTimeSpanHr) - 1;
								if (StatusChangeTimeSpanHr < 10)
										{
										StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
										}
										
								StatusChangeTimeSpanMin = 60+(StatusChangeTimeSpanMin) ;
											
								if (StatusChangeTimeSpanMin  < 10)
									{
									StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
									}
							}
						else
							if (StatusChangeTimeSpanHr < 10)
										{
											StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
										}
										
							if (StatusChangeTimeSpanMin  < 10)
									{
										StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
									}
									
						StatusChangeTimeSpan = StatusChangeTimeSpanHr +':'+ StatusChangeTimeSpanMin;			
					
					//End of Addition  BY AmitJ.
					//end of integration by harshada d	
					
					 
					objTimeMin=Number(objTimeMin)+Number(StatusChangeTimeSpanMin);
					objTimehr=Number(objTimehr)+Number(StatusChangeTimeSpanHr);

					if (objTimehr<10)
						objTimehr='0'+objTimehr;
					if(objTimeMin<10)
						objTimeMin='0'+objTimeMin;*/
		  
		 
			if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
				{
				
							if (objOldStatus.value==objNewStatus.value )
							{
								if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
								{
								 
									objStatusDate.value= objOldStatusChangeDate.value;
									objWhizStatusDate.value=objOldStatusChangeDate_Control.value //objOldStatusChangeDate.value;
									objStatusTime.value=objOldStatusChangeTime.value;
									if(objReadOnlychangedDate!=null)
									objReadOnlychangedDate.value=objOldStatusChangeDate.value;
									
									
									
								}
								
							}
							else
							{
							 
									objStatusDate.value=objCurrentDate.value;
									
									objWhizStatusDate.value=objCurrentDate.value;
									objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate').value;
									//objStatusTime.value=objTimehr+':'+objTimeMin
									objStatusTime.value=objCurrentTime.value;
									
									 
									
									if(objReadOnlychangedDate!=null)
									objReadOnlychangedDate.value=objCurrentDate.value;
									
							}
				}    	  
		
							//Added by PrashantD on 14 April 2006 for SLA
							/*if ((objStatusDate!= null) && (objStatusTime!= null))
							{
									if (objOldStatus.value==objNewStatus.value )
									{
									objStatusDate.value =GetObjectReference('frmRequestDetails','txtchangedDatehidden1').value;
									objStatusTime.value = GetObjectReference('frmRequestDetails','txtchangedTimehidden1').value;
									}
									else
									{
						//integrated by harshada d for PMLifeLine sp7
						//Added by AmitJ For PSPL IssuId - 22880									
									// CurrentTime(servertime)@(cboStatus_OnChange)= StatusChangeTimeSpan + CurrentTime(ServerTime)@(Window_Onload)			
									objStatusTime.value = GetObjectReference('frmRequestDetails','CurrentTime').value;				
									
									var StatusHr;
									var StatusMin;					
									var StatusTime;		
										
										StatusHr = 	Left(objStatusTime.value,2);
										StatusMin = Right(objStatusTime.value,2);					
										
										if (StatusHr < 10)
											{
												StatusHr = Right(StatusHr,1);
											}
										if(StatusMin < 10)
											{
												StatusMin = Right(StatusMin,1);
											}
											
										StatusHr = parseInt(StatusHr)+ parseInt(StatusChangeTimeSpanHr);
										StatusMin = parseInt(StatusMin)	 + parseInt(StatusChangeTimeSpanMin);					
										
										
										if (StatusMin >= 60)
											{
												StatusMin = parseInt(StatusMin) - 60 ; 							
												StatusHr = parseInt(StatusHr) + 1 ;
											
											}	
												if (StatusMin < 10)
													{
														StatusMin = '0' + StatusMin;								
													}	
													
												if (StatusHr < 10)		
													{
														StatusHr = '0' + StatusHr;
													}
												
												if (StatusHr >= 24)
													{
														StatusHr = parseInt(StatusHr) - 24;	
														if (StatusHr < 10)		
															{
																StatusHr = '0' + StatusHr;
															}									
														objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate1').value;
														var StatusDate = new Date(objStatusDate.value);									
														StatusDate = DateAdd(StatusDate,1,0,0);																												
														var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 																		
														StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																		
														//alert('afterconvert'+StatusDate);
														StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
														objStatusDate.value = StatusDate 
													}										
						 							objStatusTime.value = StatusHr+':'+StatusMin;  
										
									//End of Addition AmitJ
								//end of integration by harshada d
								 
									objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate').value;
									 
									objStatusTime.value=objTimehr+':'+objTimeMin;
									}
								}*/
									
							//End Addition By PradipK for Help Desk SLA 	
							//End Integration	
							
							/*//Added by ShraddhaM to feedback change
			            
			            if(objcboStatus.value == '2')
			            {
			                showCommentDiv();
			                
			            }
			            else
			            {
			                objFeedBackDiv = GetObjectReference('frmRequestDetails','DivFeedBack');
                            objFeedBackDiv.style.display  = 'none';
			            }
			            //Endedby shraddhaM	*/
		}
		
		function cboSubRequestType_OnChange()
		{	
			objcboFunction.disabled = false;
			
		 	objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');
		 	if(objcboRequestType!=null)
		 objcboRequestType.disabled = false;
		//Addition Ends
		
		
			//Commented and Modified By JyotiG 
			//Start_JG_9145_04-Jan-2007
			//objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&QueryID=<%=m_lngQueryID%>&Status=SUBREQUESTTYPE_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>";
			objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&QueryID=<%=m_lngQueryID%>&Status=SUBREQUESTTYPE_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>&ExposeCust=" + strExposeToCust;
			//End_JG_9145_04-Jan-2007
			objform.submit();
		}
		
		//Commented and added by nilesh g on 1/3/2016 for add PKTOKEN	
		//function ViewTemplates_OnClick(SubRequestTypeID)
		//{
		//	window.open ("CRM_OtherDetails.aspx?Mode=TEMPLATE_LIST&SubRequestTypeID=" + SubRequestTypeID ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=350,height=300" );	
	    //}
	    function ViewTemplates_OnClick(SubRequestTypeID,m_strToken)
	    {
	        window.open ("CRM_OtherDetails.aspx?Mode=TEMPLATE_LIST&PKToken=" + m_strToken + "&SubRequestTypeID=" + SubRequestTypeID ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=350,height=300" );	
	    }
	    //end of Commented and added by nilesh g on 1/3/2016 for add PKTOKEN	
		function window_onload()
		{ 
		  
		   
			//window.moveTo(80,80);	
			window.moveTo(30,80);	
			//Code Commented By PradipK to Change UI of Help Desk Page
			// window.resizeTo(700,500);
			//Code Added By PradipK to Change UI of Help Desk Page	 	
			window.resizeTo(975,500);					
						
			
			//Adde by JyotiG for Help Desk Issue (04-Jan-2007)
			//Start_JG_9145_04-Jan-2007
			strExposeToCust='<%=Request.Querystring("ExposeCust")%>';
			//End_JG_9145_04-Jan-2007
		//alert(win.document.forms['frmRequestList'].name);	 			 
		//added by PrashantD on 25 Feb for IssueID 2480
		var objcboFunction = GetObjectReference('frmRequestDetails','cboFunction');
		if (objcboFunction && objcboFunction.isDisabled == false)
		{
			objcboFunction.focus();
		}
		//End Of Addition by PrashantD
			var intDivHeight ;
			var intDivHeightRisk;
			var mode = "<%=m_strMode%>";
			var blnViewAccessOrHRM = "<%=blnViewAccessOrHRM%>" ;
			objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
			objcboProduct=GetObjectReference('frmRequestDetails','cboProduct');
			//objform.style.height = 1200 ;
			//integrated by harshada d for PMLifeLine sp7
			//Added by AmitJ for PSPL ISSue 22880	
			//Get Current Time at the time of Onload 
			var dt=new Date(); 
			var hr=dt.getHours();
			var min=dt.getMinutes();
			var browser = isIE();

			if (hr<10)
				hr='0'+hr;
			if(min<10)
				min='0'+min;
		
			RenderedTime = hr+':'+min;
			RenderedMin = min;
			RenderedHr = hr;
			//End of Addition
			//end of integration by harshada d

			intDivHeight = window.innerHeight - objdivlist.offsetTop - 23;
			//'Modified by ShraddhaM on Date 26 June,2006 for PMLifeLine Issue ID.4168
			if(navigator.appName == 'Netscape')
			{   
					if(mode=="NEW")
					{  
					    intDivHeight = window.innerHeight - objdivlist.offsetTop - 23;
					}
					else if(mode=="EDIT")
					{
						 
						if ("<%=m_strFromWhere%>" == "SR")						 					
						    intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
						else if ("<%=m_strFromWhere%>" == "DB")
						{
						    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 120 ;
						    if(browser=='IE')
						        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
						    else if(browser == 'FF')
						        intDivHeight = window.innerHeight - objdivlist.offsetTop - 27 ;
						    else
						        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
						}
						else if ("<%=m_strFromWhere%>" == "AR")
						    intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
						else if ("<%=m_strFromWhere%>" == "MD")
						    intDivHeight = window.innerHeight - objdivlist.offsetTop - 23;
					}
			}

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	
			
			if (objcboFunction != null)
			{
			objcboFunction.isDisabled == false		
			}
			
			//Added by PrashantSJ on 09 Nov 2006 For PMLifeLine SP8 Build 1
			//Purpose: added code for My e-Dashboard like e-Dashboard
			//if ("<%=m_strFromWhere%>" == "DB" )
			if ("<%=m_strFromWhere%>" == "DB" || "<%=m_strFromWhere%>" == "MD")
			//End of addition by PrashantSJ on 09 Nov 2006
				{
					
				if( blnViewAccessOrHRM == 0 )
				{
					if (objcboFunction != null)
			        {
					objcboFunction.disabled= true ;
					}
					if (objcboSubRequestType != null)
			        {
					objcboSubRequestType.disabled = true ;
					}
					if (showSubRequest == "True" )
					{
					
					if (objcboSubRequestType != null)
			        {
					objcboRequestType.disabled = true ;
					}
					}
					//objcboAssignTo.disabled = true ; No need - PrashantD
					//Added by ShraddhaM on 27,Mar 2008 to disable CRM comments for NonHRM user 
					if(objtxtComments)
					{
						objtxtComments.disabled = true;
					}
					//End of addtion by ShraddhaM 
				
				
				}
				else
				{					
					if (objcboFunction != null)
					{
					objcboFunction.disabled= true ;
					}
					if (objcboSubRequestType != null)
					{
					objcboSubRequestType.disabled = false ;
					}
					if (showSubRequest == "True" )
					{
					if (objcboRequestType != null)
					{
					objcboRequestType.disabled = false ;
					}
					}
					//objcboAssignTo.disabled = false ; No need - PrashantD
				}			
					
				}
							
				
			// for whiziblsem 6.0 issue id 1936 for helpdesk enhancements
			if (<%=m_intShowMandatoryAttachmentMsg%> ==1)
			{
				alert("For the current request attachment is mandatory.\nPlease attach the required files once the request is saved.");
			}
			
			//Added by PrajaktaR on 17th Feb 2007 for Disabling the control if Status is closed PMLifeLine SP9 IssueID 10295
			//Modified By VarunA on 5-Sep-2008 IssueID-18965
			//Purpose : To disable the control if the request is been closed and it is been seen from 'Assigned Request'
			
			if (("<%=m_strFromWhere%>" == "SR" && "<%=m_strMode%>" == "EDIT" && "<%=intRequestStatus%>" == "2")	|| ("<%=m_strFromWhere%>" == "MD" && "<%=intRequestStatus%>" == "2")  || ("<%=m_strFromWhere%>" == "AR" && "<%=m_strMode%>" == "EDIT" && "<%=intRequestStatus%>" == "2"))
			//End By VarunA on 5-Sep-2008 IssueID-18965
			{
				
				if (objtxtSubject != null)
				{
					objtxtSubject.disabled = true;
				}
				if (objcboPriority != null)
				{
					objcboPriority.disabled = true;
				}
				if (objFFE29587WHIZ_txtResolutionDate != null)
				{
					objFFE29587WHIZ_txtResolutionDate.disabled = true;
				}
				//Added by ShraddhaM on 15,Feb 2008 to disable Date Controls
				if (objtxtResolutionDate != null)
				{
					objtxtResolutionDate.disabled = true;
				}				
				//End of Addition
				//Added by ShraddhaM on 27,mar 2008
				if(objFFE29587WHIZ_txtCRMResolutionDate)
				{
					objFFE29587WHIZ_txtCRMResolutionDate.disabled = true;
				}
				//End of addition by ShraddhaM on 27,mar 2008
				
				if (objtxtCRMResolutionDate != null)
				{
					objtxtCRMResolutionDate.disabled = true;
				}
				
				if (objcboStatus != null)
				{
					objcboStatus.disabled = true;
				}
				
				if (objcboTargetLocation != null)
				{
					objcboTargetLocation.disabled = true;
				}
				
				if (objFFE29587WHIZ_txtchangedDate != null)
				{
					objFFE29587WHIZ_txtchangedDate.disabled = true;
				}
				
				//Added by ShraddhaM on 15,Feb 2008 to disable Date Controls
				 
				if (objtxtchangedDate != null)
				{
					objtxtchangedDate.disabled = true;
				}
				
				//End of Addition
				
				if (objcboRequestType != null)
				{
					objcboRequestType.disabled = true;
				}
				
				if (objcboSubRequestType != null)
				{
					objcboSubRequestType.disabled = true;
				}
				if (objcboproject != null)
				{
					objcboproject.disabled = true;
				}
				if (objcboFunction != null)
				{
					objcboFunction.disabled = true;
				}
				if (objtxtDescription != null)
				{
					objtxtDescription.disabled = true;

				}
				if (objtxtchangedTime != null)
				{
					objtxtchangedTime.disabled = true;
				}
				/*if (objcboAssignTo != null)
				{
					objcboAssignTo.disabled = true; No need - PrashantD
				}	*/ 
								
				if (objcboProduct != null)
				{
					objcboProduct.disabled = true;
				}

				if (objcboModule != null)
				{
					objcboModule.disabled = true;
				}
				
				if (objcboSeverity != null)
				{
					objcboSeverity.disabled = true;
				}
							
				//Added by ShraddhaM on 27,Mar 2008 to disable CRM comments when status is closed 
				
				if(objtxtComments)
				{
					objtxtComments.disabled = true;
				}
				//End of addtion by ShraddhaM 
				 
			    //Added by shraddhaM on 11,Aug 2009 to disable custom fields for close request.
			    if(GetObjectReference('frmRequestDetails','CustomFieldList'))
			    {
				    var arrCustomFieldList = (GetObjectReference('frmRequestDetails','CustomFieldList').value).split(",");
				    var CustomControl;
				    for(var i=0;i<arrCustomFieldList.length;i++)
				    {   
				    
                        if(arrCustomFieldList[i].toLowerCase().indexOf("customfielddate")!=-1)
                            CustomControl = GetObjectReference('frmRequestDetails','FFE29587WHIZ_'+arrCustomFieldList[i]) ;
				        else
				            CustomControl = GetObjectReference('frmRequestDetails',arrCustomFieldList[i]) ;
				        
				        if(CustomControl)
				        CustomControl.disabled = true;
				        
				    }
				 }
				//Ended by ShraddhaM
				
				
				//Added By Amol Changle On: 19 Aug 2009
				for(var i=0;i<window.document.images.length;i++)
				{
				    if(window.document.images[i].src.toLowerCase().indexOf("zoomin.gif")!=-1)
				        window.document.images[i].style.display="none";
                    if(window.document.images[i].src.toLowerCase().indexOf("calendar.gif")!=-1 && window.document.images[i].parentElement.tagName=="A"){
				        window.document.images[i].parentElement.onclick="";}
				}
				//End Addition
				
			/*
				var m_objtxtResolutionDate= GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtResolutionDate');	
				m_objtxtResolutionDate.disabled = true;	
			*/
			}
			//END Of Addition by PrajaktaR on 17th Feb 2007 for Disabling the control if Status is closed PMLifeLine SP9 IssueID 10295
			
			
		    if (document.getElementById('fillDiv') != null)
		    document.getElementById('fillDiv').style.display="none";
		 
		}
		
		function window_onresize()		
		{
			var mode = "<%=m_strMode%>";
			var intDivHeight;
			var intDivHeightRisk;
			var browser = isIE();
			//Addition done by SuchitraP on 13 March 2008
			if(ns)
			{
			    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
			    if(browser=='IE')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
			    else if(browser == 'FF')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 25 ;
			    else
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
			}
			else
			{
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 45;
			    if(browser=='IE')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
			    else if(browser == 'FF')
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 25 ;
			    else
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 23 ;
			}
			//End of addition by SuchitraP
			//Comment by SuchitraP on 13 March 2008
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//End of comment by SuchitraP
			if (intDivHeight < 100)	intDivHeight = 100;
			
			/*if(navigator.appName == 'Netscape')
			{
			 
					if(mode=="NEW")
					{    
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 270;
					}
					else if(mode=="EDIT")
					{
						 alert('hi');
						if ("<%'=m_strFromWhere%>//" == "SR")						 					
						//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 400 ;
						//else if ("<%'=m_strFromWhere%>" == "DB")
						//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 680 ;
						//else if ("<%'=m_strFromWhere%>" == "AR")
						//i//ntDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 680 ;
						
				//	}
			//}*/
			objdivlist.style.height = intDivHeight;		
		}
		
		// Modified By NitinVS on 9 Aug 2005 for WhizibelSEM SP4 
		 //Added by VidyaJ for IssueID - 16585
		// Refresh and close the window
		function CloseOnClick()
		{/*
			var parent=window.opener.opener;
             if(parent!=null)
               {
					window.opener.opener.location.href=window.opener.opener.location.href;
					window.opener.location.href=window.opener.location.href;
					window.close();
				}
			  else
				 {
					window.opener.location.href=window.opener.location.href;
					window.close();
				 }
				 var parent=window.opener.opener ;
				 if(parent!=null)
               {
               window.opener.close();
                window.close();
               else
               {	*/			 
				 window.close();
				// }
	//End
	}
		// Added by NitinVS on 9 Aug 2005 for PMLifeLine SP4 IssueID 2 
		
		function Reject_Onclick()
		{ 
			//var objtxtQueryID = GetObjectReference('frmRequestDetails','txtRequestID');
			var objtxtQueryID = <%=m_lngQueryID%>
			//Integrated by GaneshD on 04 Jun 2009 for StatusFlow configuration
                    var validStatusNew;
                    var validStatusExist;

                    var objOldStatus = GetObjectReference('frmRequestDetails','txtOldStatus');
                    var objNewStatus = GetObjectReference('frmRequestDetails','cboStatus');
                    var Status = objNewStatus.value;
                    objNewStatus.value = '7';                   
                
                    var objCompareStatus = GetObjectReference('frmRequestDetails','CmbStatus');
                    var objPrevStatus = GetObjectReference('frmRequestDetails','CmbPrevStatus');
                    var objStatusFlowCount = <%=m_StatusFlowCount%>
                    var statusFlag=0;

                    validStatusNew = ""
                    validStatusExist = "\n\n";

                        if(objStatusFlowCount > 0)
	                    {
                    		
		                    for(i=0;i<=objCompareStatus.length-1;i++)
		                    {
			                    validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
		                    }
                    		 
		                    for(i=0;i<=objCompareStatus.length-1;i++)
		                    {
		                        //if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].text)
		                          
		                        if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].text)
			                    {
				                    validStatusNew = objNewStatus[objNewStatus.selectedIndex].value;
				                    break;
			                    }
		                    }
		                     //alert(objOldStatus[objOldStatus.selectedIndex].text);
		                     //alert(objOldStatus.value);
		                    if (objNewStatus[objNewStatus.selectedIndex].text==objOldStatus.value)
		                    {
		                        validStatusNew=objNewStatus[objNewStatus.selectedIndex].value;
		                    
		                    }
		                    /*
		                    objNewStatus.value = Status;
		                    if(validStatusNew == "")
		                    {
			                    if(validStatusExist =="\n\n")
			                    {
				                    alert("'"+objOldStatus.value +"' is the last status configured in the status flow.");
				                    return;
			                    }
			                    else
			                    {
				                    alert('Invalid Status, Status can be change to one of the following ' + validStatusExist);
			                    }
			                    return false;
		                    }*/
	                     }		
                  // Addition end by GaneshD on 09 Jun 2009  
			//window.open("CRM_RequestRejection.aspx?QueryID=" + objtxtQueryID ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );
			window.open("CRM_RequestRejection.aspx?QueryID=" + objtxtQueryID + "&PKToken=<%=m_PKToken_FromRequestDetail%>" ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );	
			
		}
		// End Addition By NitinVS on 9 Aug 2005 for PMLifeLine SP4 IssueID 2 
		//Integrated by SavitaS on 24 Nov 2005 for IssueID 1936
		//Added By SavitaS on 24 Nov 2005 for PMLifeLine SP4 enhancement 
		//Purpose:To allow resources to change the Department of HelpDesk Request
		
		function MoveToDept_OnClick()
		{	
		//Added by ShraddhaM on 13,Nov 2007 
		var fromwhere = "<%=m_strFromWhere%>";
		var FromDashboard;
		if(fromwhere == 'DB')
			FromDashboard = 'FromDB';
		if(fromwhere == 'MD')
			FromDashboard = 'FromRD';
		//End of addition  by ShraddhaM on 13,Nov 2007 
		
		var intIsTaskOrIssuesCreated = <%=intIsTask_IssueCreated%>;
			 //added by harshada d on 03 Feb 2006 for helpdesk enhancements 
		 if ( intIsTaskOrIssuesCreated == 1)
			 {
		 	alert('Either Tasks ,Issues ,Deliverables or Resources are already mapped to this request ! so cannot move this request to Other Department');
			}
		 else
			// end of addition by harshada d on 03 Feb 2006		 
			
			// START : Commented and modified by ParagD 26-Sept-2006 : Security Issue 6197
			// window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromRD&QueryID=<%=m_lngQueryID%>","","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 
			//Commented and added by ShraddhaM on 13,Nov 2007
			//window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromRD&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 
			window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=" + FromDashboard +"&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>","","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 
			//End of comment and addition by ShraddhaM on 13,Nov 2007
			// END : Commented and modified by ParagD 26-Sept-2006 : Security Issue 6197
		}
		//End Addition by SavitaS
		//End Integration by SavitaS
		
		//added by harshada d on 28 Nov 2005 for Show History option in CRM
		function ShowHistory_OnClick()
		{
		window.open ("../General/CommonList.aspx?&MasterTagID=3100&QueryID=<%=m_lngQueryID%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		//end of addition by harshada d on 28 Nov 2005 for Show History option in CRM
		
		//code commentated by harshada d 30 th jan 2006 for helpdesk patch
		
		//Added by ManishK on 11th Jan 06 to add Deliverable textbox on Helpdesk page
		function AddDeliverable_OnClick()
		{
		   // debugger;
		    objDeliverableID = GetObjectReference('frmRequestDetails','DeliverableID');

		    var DeliverableID;
		    var QueryID;
		    var FunctionID;

		    QueryID="<%=m_lngQueryID%>";
		    DeliverableID=objDeliverableID.value;
		    FunctionID="<%=lngFunctionID%>";

			if(objDeliverableID.value == ''|| objDeliverableID.value == 0)
			{
			// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
				//window.open ("../PM/Create_Deliverables.aspx?FromWhere=CRM&FunctionID=<%=lngFunctionID%>&QueryID=<%=m_lngQueryID%>", "_new", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
				window.open ("../PM/Create_Deliverables.aspx?FromWhere=CRM&FunctionID=<%=lngFunctionID%>&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>", "_new", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
				// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			}
			else
			{
			    //Commented and added By nilesh g on 28/1/2016
			    //Comment and modification by SuchitraP on 18-Sep-2008
			    //alert("Deliverable is already mapped to this request! "); 
			    //window.open ("../PM/Create_Deliverables.aspx?DeliverableID="+objDeliverableID.value+"&Disabled=1&FromWhere=CRM&FunctionID=<%=lngFunctionID%>&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail%>", "_new", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			    $.ajax({
			    type: 'POST',
			    dataType: 'json',
			    contentType: 'application/json',
			    url: 'CRM_RequestDetail.aspx/GenrateURLToken',
			    data: JSON.stringify({ DeliverableID: DeliverableID,QueryID: QueryID ,FunctionID:FunctionID}),
			    success: function (Result) {
			       // alert(Result.d);
			        window.open ("../PM/Create_Deliverables.aspx?DeliverableID="+objDeliverableID.value+"&Disabled=1&FromWhere=CRM&FunctionID=<%=lngFunctionID%>&QueryID=<%=m_lngQueryID%>&PKToken="+Result.d+"", "_new", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			    },
			    error: function () {
			       // alert("Error")
			    }
			});
				
			}
		    
		}
		
		//Code commented by SavitaS on 19 Jan 2006 to remove button next to deliverable text box 
		
		function SelectDeliverable()
		{
			objDeliverableID = GetObjectReference('frmRequestDetails','DeliverableID');
			window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=CRM&DeliverableID=' + objDeliverableID.value,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');
	    }
		//End of Added by ManishK on 11th Jan 06 to add Deliverable textbox on Helpdesk page
		
		function ViewRejectionComments_OnClick()
		{
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// window.open ("../CRM/CRM_RequestRejection.aspx?QueryID=<%=m_lngQueryID%>&FromWhere=CRM&Mode=VIEW", "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
		window.open ("../CRM/CRM_RequestRejection.aspx?QueryID=<%=m_lngQueryID%>&FromWhere=CRM&Mode=VIEW&PKToken=<%=m_PKToken_FromRequestDetail%>", "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
		}
		
		function SelectAll_OnClick()
			{
				var objchkDelete;
				var intIndex;
				objfrmRequestDetails= GetFormReference('frmRequestDetails');
				
				objchkDelete = GetObjectReference('objfrmRequestDetails','chkDelete',true);
				for(intIndex=0 ;intIndex < objchkDelete.length ;intIndex++)
				{
					if (objchkDelete[intIndex].disabled == false )
					objchkDelete[intIndex].checked=true;
				}

			}
			//added by harshada d on 05 April 2006 for Helpdesk Enhancements for PMLifeLine 6
	
			function ShowSchedule_OnClick()
			{
				
				var objEmployee, AssignTo;
				//Commented and Added By ShraddhaM on 13,July 2007 for CleanUp Activity
				//objEmployee = GetObjectReference('frmRequestDetails','cboAssignTo');
				objEmployeeName = GetObjectReference('frmRequestDetails','cboAssignTo');
				objEmployee = GetObjectReference('frmRequestDetails','hidtxtAssignTo');
				//hidtxtAssignTo
				//End of Comment and Addition By ShraddhaM on 13,July 2007 for CleanUp Activity
				if(disallowBlank(objEmployeeName, "Please Select The Resource !", true))
				return;				
				AssignTo = objEmployee.value ;
						 		
				var startDate = objtxtHiddenServerDate.value ;
				 
				var val = objtxtCRMResolutionDate.value ;
				
				//window.open("../PM/PM_ResourceSchedule.aspx?fromwhere=FromRD&QueryID=<%=m_lngQueryID%>&EmployeeID=" + AssignTo ,"","resizable=yes,scrollbars=no,left=100,top=100,height=500,width=800"); 
			  //Commented Added By Shamkant S on 20 Jan 2016
			    // window.open("../PM/PM_ResourceSchedule.aspx?&QueryID=<%=m_lngQueryID%>&EmployeeIDList=" + AssignTo + "&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");	
			    window.open("../PM/PM_ResourceSchedule.aspx?&PKToken=<%=m_PKToken_FromRequestDetail%>&FromWhere=CRM&QueryID=<%=m_lngQueryID%>&EmployeeIDList=" + AssignTo + "&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");		
			//Commented Ended by Shamkant s on 20 Jan 2016
			}
			//end of addition by harshada d on 05 April 2006 for Helpdesk Enhancements for PMLifeLine
			//Added by PrashantSJ on 09 Nov 2006 For PMLifeLine SP8 Build 1
			//Purpose: On click of Flag Request link this function is called
			//Modified by SrikanthY on 15 Jan 2007 for issues 9426,9447
			function FlagRequest_OnClick()
			{
			    var action = "<%=m_strAction%>";
				//window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=<%=m_lngQueryID%>&ContextType=HelpDeskRequest&FromWhere=<%=m_strFromWhere%>&FromWhich=HelpDesk&ContextName="+encodeURI("<%=m_strSubject%>"),"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
				if (action != "SAVE")
				{
				window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=<%=m_lngQueryID%>&ContextType=HelpDeskRequest&FromWhere=<%=m_strFromWhere%>&FromWhich=HelpDesk","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
			}
				else
				{
				window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=<%=m_lngQueryID%>&ContextType=HelpDeskRequest&FromWhere=<%=m_strFromWhere%>&FromWhich=HelpDesk&ParentQueryID=<%=m_lngQueryID%>&ParentQueryToken=<%=m_PKToken_FromRequestDetail%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
				}
			}
			//End of modification by SrikanthY
			//End of addition by PrashantSJ on 09 Nov 2006

			//Added By ShraddhaM on 13,July 2007 for DataCleanUp Activity
			function AssignTo_OnClick()
			{
				//resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"
				window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=0&FromWhere=CRM", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
			}
			
			//Added By VarunA on 3-Mar-2008 PMLifeLine Development & Release
			function Attachment_Onclick(strSystemFileName,strOriginalFileName)
			{//debugger;
				window.open("../General/ViewAttachment.aspx?FileName=" + strOriginalFileName + "&SystemFileName=" + strSystemFileName + "&FromWhere=CRM");
			}
			//End By VarunA on 3-Mar-2008
           function showHide_div(divName)
            {
                var ObjImg = GetObjectReference('frmRequestDetails','imgGadget');
                var ObjDiv = GetObjectReference('frmRequestDetails',divName);
                var IsCollapse = ObjImg.getAttribute("Collapse");
                if(IsCollapse=="N")
                { 
                    ObjImg.src='../../../responsive/images/plus.gif';
                    ObjDiv.style.display='none';
                    ObjImg.setAttribute("Collapse","Y");
                }
                else if(IsCollapse=="Y")
                { 
                    ObjImg.src='../../../responsive/images/minus.gif'; 
                    ObjDiv.style.display='';
                    ObjImg.setAttribute("Collapse","N");
                }
            }
            
            // Added by Anju on 29 April 09
            //Purpose: To load 
            function RequestTab_OnClick(intShow) 
            {
       
       			//objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&Action=SAVE&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>";
       			//objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&Action=&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>&Show=" + intShow;
       			//Added by AMIT MAHADIK on 29Mar2011 Purpose:PMLifeLine Show details of request for approver Added==>>&Approver=<%=m_strApprover%> 
       			objform.action = "CRM_RequestDetail.aspx?&Approver=<%=m_strApprover%>&Customer=<%=m_intCustomer%>&Employee=<%=m_intRequestedEmployee%>&Action=&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>&PKToken=<%=m_PKToken_FromRequestDetail%>&Show=" + intShow;
       			//end Added by AMIT MAHADIK on 29Mar2011 Purpose:PMLifeLine Show details of request for approver Added==>>&Approver=<%=m_strApprover%> 
			    objform.submit();
     
            }
            //End of modification by Anju 0n 29 April 09
			    //Added by ShraddhaM to display Fag for followUp
           function Flag_OnClick(QueryID)
		    {
               window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&PKToken=<%=m_PKToken_FromRequestDetail%>&ContextID=" + QueryID + "&ContextType=HelpDeskRequest&FromWhere=<%=m_strFromWhere%>&FromWhich=HelpDeskDtls","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
		    }
		    function ChangeHistory_OnClick()
		    {  
		        window.open ("../CRM/CRM_CommonList.aspx?MasterTagID=3991&QueryID=<%=m_lngQueryID%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=620,height=450" ); 
		    }
		    //Ended by ShraddhaM     
		    
		     
function showCommentDiv(ev)
{                
                objcboRequestType.style.visibility = 'hidden';

                objcboSubRequestType.style.visibility = 'hidden';
                
                objFeedBackDiv = GetObjectReference('frmRequestDetails','DivFeedBack');
                var mousePosition = getMousePosition(ev,objFeedBackDiv);
			    objFeedBackDiv.style.width  = '405px';
			    objFeedBackDiv.style.height  = '150px';
			    objFeedBackDiv.style.left =  mousePosition.x ;
			    objFeedBackDiv.style.top =  mousePosition.y ;		     
		        objFeedBackDiv.style.position ='absolute';
		        objFeedBackDiv.style.display  = '';
		        if (document.getElementById('fillDiv') != null)
			    document.getElementById('fillDiv').style.display="";
}
   function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        objContextMenu.style.left = intX - 200 ;
        objContextMenu.style.top = intY  ;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}
function SubmitOK_Onclick()
{
    var objFeedBack = GetObjectReference('frmRequestDetails','cboFeedback');
    var objFeedBackComments = GetObjectReference('frmRequestDetails','txtFeedbackComments');    
    var objFeedBackDiv = GetObjectReference('frmRequestDetails','cboFeedbackDiv');
    var objFeedBackCommentsDiv = GetObjectReference('frmRequestDetails','txtSubmitCommentsDiv');
    var objDiv = GetObjectReference('frmRequestDetails','DivFeedBack');
    
     if(Trim(objFeedBackCommentsDiv.value) == '')
     {
        alert('Please Enter Feedback comments');
        return;
     } 
     
    objFeedBack.value = objFeedBackDiv.value;
    objFeedBackComments.value = objFeedBackCommentsDiv.value;
    
     
     
    objDiv.style.display  = 'none';
    if (document.getElementById('fillDiv') != null)
    document.getElementById('fillDiv').style.display="none";
    
    
     
     SaveData()
     
     objcboRequestType.style.visibility = '';
     objcboSubRequestType.style.visibility = '';
}
function Cancel_OnClick()
{    
     var objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');
     var objNewStatus = GetObjectReference('frmRequestDetails','cboStatus');

    var objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
    var objOldStatusChangeTime=window.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
	var objWhizStatusDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDate');				 					 
	var objOldStatusChangeDate_Control=window.document.forms['frmRequestDetails'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
	
	var objCurrentChangeDate = GetObjectReference('frmRequestDetails','txtchangedDate');
	var objCurrentChangeTime = GetObjectReference('frmRequestDetails','txtchangedTime');
					 
    
    objcboRequestType.style.visibility = '';
    objcboSubRequestType.style.visibility = '';
    objCurrentChangeDate.value = objOldStatusChangeDate.value;
    objCurrentChangeTime.value = objOldStatusChangeTime.value;
    objNewStatus.value = objOldStatus.value;
    objWhizStatusDate.value=objOldStatusChangeDate_Control.value 
    objFeedBackDiv = GetObjectReference('frmRequestDetails','DivFeedBack');
    objFeedBackDiv.style.display  = 'none';
    if (document.getElementById('fillDiv') != null)
    document.getElementById('fillDiv').style.display="none";
    
    
}

function SelectCustomer_onClick()
{
    //window.open ("../HR/CustomerSelection_CommonList.aspx?MasterTagID=3710&PTagID=3101&FromWhere=PM&CustomerID=" , "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
    if (document.getElementById('fillDiv') != null)
        //Commented and added by Yogesh Jalamkar on 9-May-2016   Purpose:Page is getting disable while click on customer link 
        // document.getElementById('fillDiv').style.display="";
        document.getElementById('fillDiv').style.display="none";
    //End of addition by Yogesh Jalamkar on 9-May-2016   
    window.open ("../HR/CustomerSelection_CommonList.aspx?MasterTagID=3710&PTagID=3101&For=HelpDeskOnBehalfCUST&FromWhere=PM&CustomerID=" , "_customer", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
    
}

function SelectEmployee_onClick()
{
    //window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=3101&FromWhere=PM&CustomerName=" , "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
    if (document.getElementById('fillDiv') != null)
        //Commented and added by Yogesh Jalamkar on 9-May-2016   Purpose:Page is getting disable while click on customer link 
        // document.getElementById('fillDiv').style.display="";
        document.getElementById('fillDiv').style.display="none";
    //End of addition by Yogesh Jalamkar on 9-May-2016   
    window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=3101&FromWhere=PM&For=HelpDeskOnBehalfEMP&CustomerName=" , "_Employee", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");

}
function OnBehalfCust_onClick()
{
     var objCustomerLink = GetObjectReference('frmRequestDetails','CustomerLink');
     var objEmployeeLink = GetObjectReference('frmRequestDetails','EmployeeLink');
     //var objtxtOnBehalfCustomer = GetObjectReference('frmRequestDetails','txtOnBehalfCustomer');
      
     objCustomerLink.style.display ='';
     objEmployeeLink.style.display ='none';
     //objtxtOnBehalfCustomer.style.display ='';
     
     //document.getElementById('fillDiv').style.display="";
     //window.open ("../HR/CustomerSelection_CommonList.aspx?MasterTagID=3710&PTagID=3101&FromWhere=PM&CustomerID=" , "_customer", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
    
}
function OnBehalfEmp_onClick()
{
     var objEmployeeLink = GetObjectReference('frmRequestDetails','EmployeeLink');
     var objCustomerLink = GetObjectReference('frmRequestDetails','CustomerLink');
     //var objtxtOnBehalfEmployee = GetObjectReference('frmRequestDetails','txtOnBehalfEmployee');
     
     objEmployeeLink.style.display ='';
     objCustomerLink.style.display ='none';
     //objtxtOnBehalfEmployee.style.display ='';
     
     //document.getElementById('fillDiv').style.display="";
     //window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=3101&FromWhere=PM&CustomerName=" , "_Employee", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
}
function OnBehalfSelf_onClick()
{    
    window.open ("../CRM/CRM_RequestDetail.aspx?Mode=NEW&PageNumber=1&Customer=&Employee=&RTVal=I&ParentTagID=0&FromList=1&FromCL=1" , "_self", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=5,top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
}

//==========================================================================================================================================
//Added By AshwiniM on 26-FEB-2013 for E_Emphasys Customizations
function CopyToIssue_OnClick()
{
		 window.open("../CRM/CopyThreadToIssue.aspx?QueryID=<%=m_lngQueryID%>&PkToken=<%=m_PKToken_FromRequestDetail%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");				
}
//End of Added By AshwiniM on 26-FEB-2013 for E_Emphasys Customizations
//==========================================================================================================================================


			</script>
		</form>
	</body>
</HTML>