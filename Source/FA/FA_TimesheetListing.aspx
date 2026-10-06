<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FA_TimesheetListing.aspx.vb" Inherits="PbNIT.FA_TimesheetListing"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strPageTitle)%>
 
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
		
					<form id="frmTimesheetListing" method="post" runat="server">
						
									<%PageInit%>
							
					</form>
				
					<Script language="javascript">
					
					
					

		var objform=GetFormReference('frmTimesheetListing');
		var objdivlist=GetObjectReference('frmTimesheetListing','PageDiv');
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		var objTxtHidStatus;
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {

			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			  
			if (intDivHeight < 100)	intDivHeight = 100;
			//'Modified by ShraddhaM on Date 29 June,2006 for PMLifeLine Issue ID.4168
			//alert(mode);
			//Modified by JyotiG on Date 12 July, 2006 for PMLifeLine Issue ID.4168
		
          //cOMMENTED AND ADDED BY NILESH G ON 13/1/2016 FOR FOOTER ISSUE      
		//if(navigator.appName == 'Netscape')
			//{
			   // if('<%=HttpContext.Current.Request.QueryString("Mode")%>' == 'Details')
			//    { 
			//        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 70;
			//    }
			//    else{
			//        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 160;
			//        if (WhichBrowser() == 'IE')
			//        {
			//            //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			//            intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
			//        }
			//        else if(WhichBrowser() == 'CR')
			//        {
			//            //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			//            intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
			//        }
			//        else if (WhichBrowser() == 'FF')
			//        {
			//            //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 890;
			//            intDivHeight = (window.innerHeight - objdivlist.offsetTop - 37); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
		        
			//        }
			//        else
			//        {
			//            intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) + 895;
			//        }
			//    }
			    //}

			    if (WhichBrowser() == 'IE')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
			    }
			    else if(WhichBrowser() == 'CR')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
			    }
			    else if (WhichBrowser() == 'FF')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 890;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 37); //Added By Vaijat K ON 03/11/2015 Issue ID-2591
		        
			    }
			    else
			    {
			        intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) + 895;
			    }
			    objdivlist.style.height = intDivHeight + 'px';	}		
		    //END OF cOMMENTED AND ADDED BY NILESH G ON 13/1/2016 FOR FOOTER ISSUE      
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
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                //Added By Vaijat K ON 03/12/2015 Issue ID-2591
			    if (WhichBrowser() == 'IE')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
			    }
			    else if(WhichBrowser() == 'CR')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 895;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 34); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
			    }
			    else if (WhichBrowser() == 'FF')
			    {
			        //intDivHeight = (document.body.offsetHeight - objdivMain.offsetTop - 100) + 890;
			        intDivHeight = (window.innerHeight - objdivlist.offsetTop - 37); //Added By Vaijat K ON 03/11/2015 Issue ID-2597
		        
			    }
			    else
			    {
			        intDivHeight = (document.body.offsetHeight - objdivlist.offsetTop - 100) + 895;
			    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px' ;	}
		}	
		
	/*	function optType_OnClick()
		{
			objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>//&MasterTagId=<%=m_lngTagId%>//";
			//objform.submit();
		//}
	//*/
		//Added By vivekP On 3 August 2005 For PMLifeLine SP4 IssueID-87
		function status_OnChange()
		{
		objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>";
		objform.submit();
		}
		function project_OnChange()
		{
		objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>";
		objform.submit();
                        }                        
		function Show_OnClick()
        {
		objFromDate = GetObjectReference('frmTimesheetListing','FromDate');
		objToDate = GetObjectReference('frmTimesheetListing','ToDate');
            if (objFromDate.value != "") {
                if (objToDate.value == "") {
                    alert("'To Date' can not be left blank.");
                    return;
                }

            }
            //Added By Usha Pandit On 13.05.2021 For From Date validation
            if (objToDate.value != "") {
                if (objFromDate.value == "") {
                    alert("'From Date' can not be left blank.");
                    return;
                }
            }
            //End Of Added By Usha Pandit On 13.05.2021 For From Date validation

		if(disallowDate1LessThanDate2(objToDate, objFromDate, 'The \'From Date\' should be less than equal to  \'To Date\'.', true))
				return ;
				
		objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>";
		objform.submit();
		}
		function FinalReject_OnClick()
		{
		var strTimeSheetList="<%=strTimeSheetList%>"
		var TimeSheetListArray=strTimeSheetList.split(",");
		var intCount=0;
			for(intCount=0; intCount < TimeSheetListArray.length-1; intCount++)
				{	
					objComment = GetObjectReference('frmTimesheetListing','Comment'+TimeSheetListArray[intCount]);
					if(objComment.value=="")
					{
					alert('Please add comment for rejection.');
					setFocus(objComment);
					return;
					}
				<%' Modified by NitinVS on 28 Apr 2007 for PMLifeLine SP 8 Regression Fixes Added validation for maxlength %>
					if(disallowMaxlengthViolation(objComment,475,"The maximum length of the 'Comments' field is 475 characters",true))	return ;
				<%' End Modified by NitinVS on 28 Apr 2007 for PMLifeLine SP 8 Regression Fixes Added validation for maxlength %>
					
				}
			
			objform.action="FA_TimesheetListing.aspx?Action=RejectTimesheet&TimesheetList="+strTimeSheetList+"&Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>";
			objform.submit();
		}
		
		function FinalAuthenticate_OnClick()
		{
		var strTimeSheetList="<%=strTimeSheetList%>"
		var TimeSheetListArray=strTimeSheetList.split(",");
		var intCount=0;
			for(intCount=0; intCount < TimeSheetListArray.length-1; intCount++)
				{	
					objComment = GetObjectReference('frmTimesheetListing','Comment'+TimeSheetListArray[intCount]);
					if(objComment.value=="")
					{
					alert('Comment can\'t be left blank.');
					setFocus(objComment);
					return;
					}
				<%' Modified by NitinVS on 28 Apr 2007 for PMLifeLine SP 8 Regression Fixes Added validation for maxlength %>
					if(disallowMaxlengthViolation(objComment,500,"The maximum length of the 'Comments' field is 500 characters",true))	return ;
				<%' End Modified by NitinVS on 28 Apr 2007 for PMLifeLine SP 8 Regression Fixes Added validation for maxlength %>
				}
			
			objform.action="FA_TimesheetListing.aspx?FinalApproved=FinalApproved&TimesheetList="+strTimeSheetList+"&Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>&Action=<%=ACTION_AUTHENTICATE%>";
			objform.submit();
		}
		
		function RejectFromList_OnClick()
		{
		var objChkAuthenticate, intCount=0, blnChecked=false;
		var concatedlist="";
			objChkAuthenticate = GetObjectReference('frmTimesheetListing','chkAuthenticate',true);
			if((objChkAuthenticate != null) && (objChkAuthenticate.length > 0))
			{
				for(intCount=0; intCount < objChkAuthenticate.length; intCount++)
				{	
					if(objChkAuthenticate[intCount].checked == true)
					{
					concatedlist+=objChkAuthenticate[intCount].value +",";
					blnChecked=true;
					}
					
				}
			}
				
			if(blnChecked==false)
			{
			alert("Select the timesheet(s) to reject.");
			return;
			}
		    //Commented and added by Yogesh J on 11-Feb-2016 to generate Token
			//window.open("FA_TimesheetListing.aspx?Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&concatedlist="+concatedlist,"","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");

		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'FA_TimesheetListing.aspx/GenrateURLToken_RejectFromList_OnClick',
		        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>",concatedlist:  concatedlist}),
				        success: function (Result) {   
				            window.open("FA_TimesheetListing.aspx?Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&Token="+ Result.d +"&concatedlist="+concatedlist,"","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");

				        },
				        error: function () {
				            //   alert("Error")
				        }
				    });
		    //End of addition by Yogesh J on 11-Feb-2016 to generate Token
				
		}
		//End Of Addition By VivekP On 3 August 2005 For PMLifeLine SP4 IssueID-87
		//Modified By VivekP On 3 August 2005 For PMLifeLine SP4 IssueID-87
		function Authenticate_OnClick()
		{
		
		var objChkAuthenticate, intCount=0, blnChecked=false;
		var blnApproved=false,strApprovedList="";
		var concatedlist="";
			objChkAuthenticate = GetObjectReference('frmTimesheetListing','chkAuthenticate',true);
			
			objTxtHidStatus = GetObjectReference('frmTimesheetListing','txtHidStatus');
			
			if((objChkAuthenticate != null) && (objChkAuthenticate.length > 0))
			{
				for(intCount=0; intCount < objChkAuthenticate.length; intCount++)
				{	
					if(objChkAuthenticate[intCount].checked == true)
					{
					concatedlist+=objChkAuthenticate[intCount].value +",";
					blnChecked=true;
					
					objTxtHidStatus = GetObjectReference('frmTimesheetListing','txtHidStatus'+objChkAuthenticate[intCount].value);
						if(objTxtHidStatus.value.toUpperCase()=='APPROVED')
						{
							strApprovedList+=objChkAuthenticate[intCount].value +",";
							blnApproved=true;
						}	
					}
					
				}
			}
			
		//alert(concatedlist);
		
		if(blnChecked==false)
		{
		alert("<%=MyBase.GetResourceString("SELECT_TIMESHEET_AUTHETICATION")%>");
		//alert("Select the timesheet(s) to approve/reject.");
		return;
		}
		if(blnApproved==true)
		{
			alert("Following timesheet(s) are already approved ! "+'\n'+"Timesheet No.(s): "+ strApprovedList.substring(0,strApprovedList.length-1) )
			return;
		}
		
		window.open("FA_TimesheetListing.aspx?Mode=ApproveOrReject&ToApprove=ToApprove&MasterTagId=<%=m_lngTagId%>&concatedlist="+concatedlist,"","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		
		
				
			
			
			/*
			var objChkAuthenticate, intCount=0, blnChecked=false;
			
			objChkAuthenticate = GetObjectReference('frmTimesheetListing','chkAuthenticate',true);
			if((objChkAuthenticate != null) && (objChkAuthenticate.length > 0))
			{
				for(intCount=0; intCount < objChkAuthenticate.length; intCount++)
				{	
					if(objChkAuthenticate[intCount].checked == true)
					{
						blnChecked=true;
						break;
					}
				}
			}
			if(blnChecked == true)
			{
				objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>&Action=<%=ACTION_AUTHENTICATE%>";
				objform.submit();
			}
			else
			{
				alert("<%=MyBase.GetResourceString("SELECT_TIMESHEET_AUTHETICATION")%>");
			}
			*/
		}
		//End Of Modification By VivekP On 3 August 2005 For PMLifeLine SP4 IssueID-87
		
		function Delete_OnClick()
		{
			var objChkDelete, intCount=0, blnChecked=false;
			
			objChkDelete = GetObjectReference('frmTimesheetListing','chkDelete',true);
			if((objChkDelete != null) && (objChkDelete.length > 0))
			{
				for(intCount=0; intCount < objChkDelete.length; intCount++)
				{	
					if(objChkDelete[intCount].checked == true)
					{
						blnChecked=true;
						break;
					}
				}
			}
			if(blnChecked == true)
			{
				if(confirm("<%=MyBase.GetResourceString("DELETE_CONFIRM")%>"))
				{
					objform.action="FA_TimesheetListing.aspx?Mode=<%=MODE_TSLISTING%>&MasterTagId=<%=m_lngTagId%>&Action=<%=ACTION_DELETE%>";
					objform.submit();
				}
			}
			else
			{
				alert("<%=MyBase.GetResourceString("SELECT_TIMESHEET_DELETION")%>");
			}
		}
		
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		//function Number_OnClick(intTimesheetNo)
		function Number_OnClick(intTimesheetNo, strToken)
		{
		//Modified by VivekP on 2 August 2005 For PMLifeLine SP4 IssueID-87
		// window.open("FA_TimesheetListing.aspx?ProjectID=<%=strProjectID%>&NumberClick=NumberClick&TimeSheetAllOrCurrent=<%=m_strTimeSheetAllOrCurrent%>&strRejectedStatus=<%=strRejectedStatus%>&AllTimesheet=<%=strAllTimesheet%>&Mode=<%=MODE_TSDETAILS%>&MasterTagId=<%=m_lngTagId%>&TimeSheetNo=" + intTimesheetNo.toString(),"_self","scrollbars=no,menubar=yes,toolbar=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=800");
		window.open("FA_TimesheetListing.aspx?ProjectID=<%=strProjectID%>&NumberClick=NumberClick&TimeSheetAllOrCurrent=<%=m_strTimeSheetAllOrCurrent%>&strRejectedStatus=<%=strRejectedStatus%>&AllTimesheet=<%=strAllTimesheet%>&Mode=<%=MODE_TSDETAILS%>&MasterTagId=<%=m_lngTagId%>&TimeSheetNo=" + intTimesheetNo.toString() + "&PKToken=" + strToken,"_self","scrollbars=no,menubar=yes,toolbar=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=800");
		//End Of Modification by VivekP on 2 August 2005 For PMLifeLine SP4	 IssueID-87
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		
		function Send_OnClick()
		{
			var objTextArea;
			
			objTextArea = GetObjectReference('frmTimesheetListing','txtareaAuthenticate');
			if(disallowMaxlengthViolation(objTextArea, 500,"<%=MyBase.GetResourceString("MAXLENGTH_FOR_TEXTAREA")%>",true))
			{
				objTextArea.value = objTextArea.value.substring(0,490);
				return;
			}

			objform.action="FA_CustomerTimesheetFeedback.aspx?TimeSheetNo=<%=m_lngTimesheetNo%>";
			objform.submit();
		}
		// Code added by SwapnilR on 25th Nov 2004
		//Modified By vivekP On 19 Sep 2005 For PMLifeLine Sp4
		function Show_Report(lngUniqueID,strUserID,strTokenID)
		{
			
			//window.open ("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1888&FromWhere=PM&MasterTagId=566&UniqueID=" + lngUniqueID + "","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=600");
			// Code added by SwapnilR on 25th Sept 2006
			// Purpose : Adding security token for Show Report Link 
			window.open ("../General/Validate_Report.aspx?ReportID=1889&TagID=42&ParentTagID=0&UserID=" + strUserID + "&PKToken=" + strTokenID + "&UniqueID=" + lngUniqueID + "","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=600");
			// End of code addition by SwapnilR on 25th Sept 2006
			
		}
		//End Of Modification By VivekP On 19 Sep 2005 For PMLifeLine Sp4
		// End of code addtion
		
		//Code Added By VivekP on 2 August 2005 For SP4 PMLifeLine IssueID-87
		var refchild;
		
		function Reject_OnClick()
		{
		// START : Commented and modified By ParagD On 14-Sept-2006 : Security Issue 6197
		// window.open("FA_TimesheetListing.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&TimesheetNo_PK=<%=m_lngTimesheetNo%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		 
		    
		    //Commented and added by Shamkant S  17-Feb-2016 to generate Token
		   // window.open("FA_TimesheetListing.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&TimesheetNo_PK=<%=m_lngTimesheetNo%>&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		    
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'FA_TimesheetListing.aspx/Token_Reject_OnClick',
		        data: JSON.stringify({TimesheetNo_PK:"<%=m_lngTimesheetNo%>", EmployeeID: "<%=Session("intUserID")%>"}),
		        success: function (Result) {   
		         //   window.open("FA_TimesheetListing.aspx?Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&Token="+ Result.d +"&concatedlist="+concatedlist,"","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		            window.open("FA_TimesheetListing.aspx?Token="+ Result.d +"&FromDetail=FromDetail&Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=<%=m_lngTagId%>&TimesheetNo_PK=<%=m_lngTimesheetNo%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
				        },
				        error: function () {
				            //   alert("Error")
				        }
		    });
		    //End of addition by Shamkant S on 11-Feb-2016 to generate Token
            // END : Commented and modified By ParagD On 14-Sept-2006 : Security Issue 6197
		
		//refchild=window.open ("../General/CommonPage.aspx?TimesheetNo_PK=<%=m_lngTimesheetNo%>&TimesheetNo=<%=m_lngTimesheetNo%>&MasterTagID=3061&FromWhere=FA&FromCL=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,resizable=no,scrollbars=no,left=320,top=250,height=250,width=430");
		//alert(refchild);
		/*objtxtComment = GetObjectReference('frmTimesheetListing','txtComment');
		if(objtxtComment.value==""){
		alert("Please give comments for Rejection.");
		setFocus(objtxtComment);
		return;
		}*/
		//objform.action="FA_TimesheetListing.aspx?RejectAction=Reject&Mode=<%=MODE_TSDETAILS%>&MasterTagId=<%=m_lngTagId%>&TimeSheetNo=<%=m_lngTimesheetNo%>";
		//objform.submit();
		}
		function Close_OnClick()
		{
		//alert(refchild);
			if (refchild!=null)
			{
			refchild.close();
			}
		window.close();
		}
		
		function AuthenticateDetailPage_OnClick()
		{
		// START : Commented and modified By ParagD On 14-Sept-2006 : Security Issue 6197
		// window.open("FA_TimesheetListing.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToApprove=ToApprove&MasterTagId=<%=m_lngTagId%>&TimesheetNo_PK=<%=m_lngTimesheetNo%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		window.open("FA_TimesheetListing.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToApprove=ToApprove&MasterTagId=<%=m_lngTagId%>&TimesheetNo_PK=<%=m_lngTimesheetNo%>&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=850");
		// END : Added By ParagD On 14-Sept-2006 : Security Issue 6197
		}
		function View_Comment_OnClick()
		{
		window.open ("../General/CommonPage.aspx?ViewComment=ViewComment&TimesheetNo_PK=<%=m_lngTimesheetNo%>&TimesheetNo=<%=m_lngTimesheetNo%>&MasterTagID=3061&FromWhere=FA&FromCL=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,resizable=no,scrollbars=no,left=320,top=250,height=250,width=430");
		}
		function Back_OnClick()
		{
		window.location.href="../FA/FA_TimesheetListing.aspx?ProjectID=<%=strProjectID%>&BACK=BACK&TimeSheetAllOrCurrent=<%=m_strTimeSheetAllOrCurrent%>&Mode=Listing&MasterTagId=<%=m_lngTagId%>";
		}
		//End Of Addition by VivekP On 2 August 2005 For SP4 PMLifeLine  IssueID-87
					</Script>
				
	</body>
</HTML>
