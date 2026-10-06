<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_DiscussionThread.aspx.vb" Inherits="PbNIT.CRM_DiscussionThread"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Discussion Thread")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
     #divList .clsTable tr td:first-child
    {
        vertical-align:top;
        padding-top:10px;
    }
    pre {
        background-color: transparent !important;
        border: 0px !important;
    }
</style>

<script type="text/javascript">
    
    $(document).ready(function () {


        setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onresize="window_onresize()"  onload="window_onload()" MS_POSITIONING="GridLayout">
		 
					<form id="frmDiscussion" method="post" runat="server">
   
			 <div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>			
		
									<%WritePage()%>
						 
					</form>
         <link href="../General/loaderStylesheet.css" rel="stylesheet" />
				 
					<script language="javascript">
					    window.onload = function () {
					          RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
					    }
					<%' Added By SonalD on 15th Jan 2009 %>
                    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                    disableRightClick();
                    <%End If%>
                    <%' Added By SonalD on 15th Jan 2009 %>
    
		var objform;
		var objdivlist;
		var objtxtComments;
		// Code Added By PradipK for Help Desk SLA 
		var objStatusTime
		var objStatusDate
		var objCurrentDate
		var objOldStatus
		var objOldStatusChangeDate
		var objOldStatusChangeTime
		var objNewStatus
		var objDate
		var  objResolutionDate
		// End Addition By PradipK for Help Desk SLA 
//integrated by harshada d for WhizSP7 on 3 rd of july 2006
	//Added By AmitJ For PSPL IssueId = 22880
		var RenderedTime
		var RenderedMin
		var RenderedHr
		
		//End of Addition by AmitJ
		 
		//End Of Addition
//end of integration by harshada d on 3 rd of july 2006
		
		objform = GetFormReference('frmDiscussion');
		objdivlist = GetObjectReference('frmDiscussion','divList');
		objtxtComments =  GetObjectReference('frmDiscussion','txtComments');
		objlblSave= GetObjectReference('frmDiscussion','lblSave',true);
		 //Added by Amit Mahadik on 15 Mar 2011 Purpose:Whizible 10.0 
		function Delete_OnClick(queryid)
		{
		
				var objCheckbox = GetObjectReference('frmDiscussion','chkDiscussionThread',true);
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
        		
		        if(!blnSelected) { alert('Please select atleast one Discussion thread to delete !'); return; }
        		
        		if (confirm("Are you sure, you want to delete the selected Discussion Thread(s)?")==true)
				{
	                objform.action = "CRM_DiscussionThread.aspx?FromWhere=<%=m_strFromWhere%>&Action=DELETE&QueryID=" + queryid;
		            objform.submit();
		        }
		}
		  //End Added by Amit Mahadik on 15 Mar 2011 Purpose:Whizible 10.0 
					    function Save_OnClick(queryid) {
					        var Mode = (arguments.length > 1) ? arguments[1] : "0";
					        if (Mode == "0") {
					           document.body.readonly=true;
					            window.setTimeout('Save_OnClick("' + queryid + '","1")', 1);
					        }
					       if (Mode == "1") {
					                // debugger;
					                //Added by VijayD on 11 Jun 2009 for StatusFlow configuration
					                if (ValidateStatusFlow(queryid) == false)
					                { return false; }
					                // Addition end by ViajyD on 11 Jun 2009 

					                //alert(window.opener.document.forms[0].name);
					                if (disallowBlank(objtxtComments, "Please add your comments")) {
					                 
					                    return;
					                }
					                if (disallowMaxlengthViolation(objtxtComments, 4000, "Please enter your comments in less than 4000 characters")) {
					                 
					                    return;
					                }
					                <%'Added By NitinVs on 15Mar 2007 for WhizibleSEM SP 8 Regression Issue 11684 SLA Validation not to be done for Customer Login%>
					                <%If m_strLoginType <> "C" %>
					                // Code Added By PradipK for Help Desk SLA 
					                //objOldStatusChangeDate = GetParentObjectReference('frmDiscussion','txtchangedDatehidden1');
					                objOldStatusChangeDate = window.document.forms['frmDiscussion'].elements['txtchangedDatehidden1'];

					                //objOldStatusChangeDate = GetParentObjectReference('frmDiscussion','txtchangedDatehidden1');
					                //alert(objOldStatusChangeDate);
					                //modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					                objOldStatusChangeTime = window.document.forms['frmDiscussion'].elements['txtchangedTimehidden1'];
					                //	objOldStatusChangeTime=window.opener.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
					                //end of modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					                //shraddhaM	
					                objCurrentChangeDate = GetObjectReference('frmDiscussion', 'txtchangedDate');

					                //objCurrentChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');

					                objCurrentChangeTime = GetObjectReference('frmDiscussion', 'txtchangedTime');
					                objOldStatus = GetObjectReference('frmDiscussion', 'cboStatusOld');
					                //modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					                objNewStatus = GetObjectReference('frmDiscussion', 'cbostatus');
					                //end of modification by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
					                objTime = GetObjectReference('frmDiscussion', 'CurrentTime');

					                objDate = GetObjectReference('frmDiscussion', 'CurrentDate');

					                objResolutionDate = GetObjectReference('frmDiscussion', 'txtResolutionDate')
					                if (objCurrentChangeDate != null) {
					                    if (objCurrentChangeDate.value == "") {
					                        alert('Status Change Date should not be left blank')
					                      
					                        return;
					                    }
					                }

					                if (objCurrentChangeTime != null) {
					                    if (disallowBlank(objCurrentChangeTime, "<%=MyBase.GetResourceString("BLANKREPORTEDTIME")%>", true))
					                        return;

					                    if (isTime(objCurrentChangeTime, "<%=mybase.GetResourceString("INVALIDTIME",false)%>") == false) {
					                        return;
					                    }
					                }



					                // Validation: If Status is not changed,Then Disallow to Change Status Change Date & Status Change Time 
					                if (objOldStatusChangeDate.value != '' && objOldStatus != null && objNewStatus != null && objOldStatusChangeDate != null && objOldStatusChangeTime != null && objCurrentChangeDate != null && objCurrentChangeTime != null) {

					                    if (objOldStatus.value == objNewStatus.value) {

					                        if (objOldStatusChangeDate.value != objCurrentChangeDate.value || objOldStatusChangeTime.value != objCurrentChangeTime.value) {

					                            alert('Status date/time change can be done only when Status is changed !');
					                            if (objOldStatusChangeDate.value != objCurrentChangeDate.value)
					                                //setFocus(objCurrentChangeDate);
					                                if (objOldStatusChangeTime.value != objCurrentChangeTime.value)
					                                    setFocus(objCurrentChangeTime);
					                            return;
					                        }
					                    }
					                }


					                if (objOldStatus != null && objNewStatus != null) {

					                    if (objOldStatus.value != objNewStatus.value) {

					                        if (objCurrentChangeDate != null && objCurrentChangeTime != null && objOldStatusChangeDate != null && objOldStatusChangeTime != null) {

					                            if (objOldStatusChangeDate.value != "" && objOldStatusChangeTime.value != "" && objCurrentChangeDate.value != "" && objCurrentChangeTime.value != "") {

					                                if (objOldStatusChangeDate.value == objCurrentChangeDate.value && objOldStatusChangeTime.value == objCurrentChangeTime.value) {

					                                    alert("Status Change date & time should be greater than previous status Change date and time.");
					                                    setFocus(objCurrentChangeTime);
					                                    {
					                                        
					                                        return;
					                                    }
					                                }
					                                else


					                                    if (disAllowDateTime1LessThanDateTime2(objCurrentChangeDate, objCurrentChangeTime, objOldStatusChangeDate, objOldStatusChangeTime, 'Status Change date & time should be greater than previous status Change date and time.'))
					                                        //if(disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate,objOldStatusChangeTime,objCurrentChangeDate,objCurrentChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
					                                    {
					                                      
					                                        return;
					                                    }

					                            }
					                        }
					                    }
					                }

					                var TempObjTime;

					                if (objCurrentChangeDate != null && objCurrentChangeTime != null && objDate != null && objTime != null) {
					                    //integration by harshadad 
					                    //Added by AmitJ for PSPL ISSue 22880
					                    // Add TimeSpan in ObjTime.value (ServerTime @(Windows_OnLoad)) which will give ServerTime @(Save_OnClick)		
					                    TempObjTime = objTime.value

					                    if (disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate, objCurrentChangeTime, objDate, objTime, 'Status Change Date & Time should not be greater than Current Date & Time.')) {
					                        {
					                          
					                            return;
					                        }
					                    }
					                }
					                <%END IF %>
					                <%'Added By NitinVs on 15Mar 2007 for WhizibleSEM SP 8 Regression Issue 11684 SLA Validation not to be done for Customer Login%>
					                // End Addition By PradipK for Help Desk SLA 
					                //Comment and Modification by SuchitraP on 18-mar-2009 for IssueID 29248
					                //When closed the request from the discussion thread the discussion thread page get opened which doesn't have the save link.
					                //objform.action = "CRM_DiscussionThread.aspx?Action=SAVE&QueryID=" + queryid;

					                //Added by ShraddhaM for Feedback comment change on 22,Sep 2009
					                var objOldStatus = GetObjectReference('frmRequestDetails', 'cboStatusOld');
					                var objNewStatus = GetObjectReference('frmRequestDetails', 'cboStatus');

					                var FromWhere = "<%=m_strFromWhere%>";


					                if (objOldStatus != null && objNewStatus != null) {
					                    if (objOldStatus.value != objNewStatus.value && FromWhere == 'SR') {
					                        if (objNewStatus.value == '2') {
					                            showCommentDiv(event)
					                        }
					                        else {
					                            SaveData(queryid)
					                        }
					                    }
					                    else {
					                        SaveData(queryid)
					                    }
					                }
					                else {
					                    SaveData(queryid)
					                }
					                //Ended by ShraddhaM for Feedback comment change on 22,Sep 2009

					               
					            }

					    }
		
		function SaveData(queryid)
		{
		    if(objlblSave!=null)
			    {
			        for(i=0;i<=objlblSave.length-1;i++)
			         {
			            objlblSave[i].style.display='none';
			            objlblSave[i].style.visibility='hidden';
			          } 
			     }
		        setFrameLoader();
			    objform.action = "CRM_DiscussionThread.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&QueryID=" + queryid;
			     //End of Comment and Modification by SuchitraP on 18-mar-2009 for IssueID 29248
                    			
			    objform.submit(); 
			    
		}
		function window_onload()
		{
	
		if (GetObjectReference('frmRequestDetails','cboStatus')!=null)
		GetObjectReference('frmRequestDetails','cboStatus').onchange = cboStatus_OnChange;
		//End Of addition by PrashantD
		//end of integration by harshada
			var intDivHeight ;
			var intDivHeightRisk;
				//Commented And Added By Vaijat K ON 05/12/2015 IssueID-2635
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (WhichBrowser() == 'IE')
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			else if (WhichBrowser() == 'CR')
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			else if (WhichBrowser() == 'FF')
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	
			objtxtComments.focus();
			if ("<%=m_strAction%>" == "SAVE")
			{	
				
				/*Modified by nitinVS on 22 Aug 2005 for WhizibleSEM SP4 IssueId 2 */
				var openerHref = window.opener.location.href; 

				if (openerHref.indexOf('Mode=NEW') == -1 )
				{	
					if ( openerHref.indexOf('&Search=1') >= 1 )
					{
					     
						window.opener.location.href = replaceSubstring(window.opener.location.href,'&Search=1','');
					}
					else
					{	
					window.opener.location.href= replaceSubstring(window.opener.location.href,'Action=','Action1=');
					}
				}
				else
				{ 
					// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
					// window.opener.location.href= "../CRM/CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=SR&QueryID=<%=m_lngQueryID%>";
					window.opener.location.href= "../CRM/CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=SR&QueryID=<%=m_lngQueryID%>&PKToken=<%=m_PKToken_FromDT%>";
					// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
				}				
				/* End  Modification by NitinVS on 22 Aug 2005 for WhizibleSEM SP4 IssueId 2  */				
			} 
		}
		
		function cboStatus_OnChange()
		{
		 
		   
			var objStatusTime= GetObjectReference('frmDiscussion','txtchangedTime');
			var objStatusDate=GetObjectReference('frmDiscussion','txtchangedDate');
			//var objCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
			if(navigator.appName == 'Netscape')
			{			 
				var objCurrentDate=window.document.forms['frmDiscussion'].elements['CurrentDate'];
			}
			else
			{
				var objCurrentDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_CurrentDate');
			}
				//var objCurrentDate = GetObjectReference('frmDiscussion','CurrentDate');
				var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');
				var objOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDatehidden1');
				var objOldStatusChangeTime = GetObjectReference('frmDiscussion','txtchangedTimehidden1');
				var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');
				var objOldStatus = GetObjectReference('frmDiscussion','cboStatusOld');
				var d=new Date(); 
				var h= d.getHours();
				var m= d.getMinutes();		
	
				//Added By Amit J for PSPL IssueId  22880
				// Get StatusChangeTimeSpan = CurrentTime(clientTime)@(cboStatus_OnChange) - RenderedTime@(Windows_OnLoad)
				var StatusChangeTimeSpanHr;
				var StatusChangeTimeSpanMin;
				var StatusChangeTimeSpan;
	
				objTime=GetObjectReference('frmDiscussion','CurrentTime');
				TempObjTime = objTime.value		
			 
				
					//alert(objCurrentDate.value);
					if(navigator.appName == 'Netscape')
					{
						var objCurrentTime=window.document.forms['frmDiscussion'].elements['CurrentTime'];
					}
					else
					{ 
						var objCurrentTime=GetObjectReference('frmDiscussion','CurrentTime');			
					}
					var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');
					if(navigator.appName == 'Netscape')
					{
						var objOldStatusChangeDate=window.document.forms['frmDiscussion'].elements['txtchangedDatehidden1'];
					}
					else
					{
						var objOldStatusChangeDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDatehidden1');
					}
					if(navigator.appName == 'Netscape')
					{
						var objOldStatusChangeTime=window.document.forms['frmDiscussion'].elements['txtchangedDatehidden1'];
					}
					else
					{
						var objOldStatusChangeTime = GetObjectReference('frmDiscussion','txtchangedTimehidden1');	
					}
					var objNewStatus = GetObjectReference('frmDiscussion','cbostatus');
					var objOldStatus = GetObjectReference('frmDiscussion','cboStatusOld');
					var d=new Date(); 
					var h=d.getHours();
					var m=d.getMinutes();
					var objReadOnlychangedDate = GetObjectReference('frmDiscussion','txtReadOnlychangedDate');
					if (h<10)
					h='0'+h;
					if(m<10)
					m='0'+m;				
				
				if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
				{
							if (objOldStatus.value==objNewStatus.value )
							{
								if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
								{
								//objStatusDate.value=objOldStatusChangeDate.value;
									objWhizStatusDate.value=objOldStatusChangeDate.value;
									objStatusTime.value=objOldStatusChangeTime.value;
									if(objReadOnlychangedDate!=null)
									objReadOnlychangedDate.value=objOldStatusChangeDate.value;
								}
							}
							else
							{							
					
									//objStatusDate.value=objCurrentDate.value;
									objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate').value;
																 
									//addition by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
									if (objWhizStatusDate!=null)
									//end of addition by harshada d on 3rd July 2006 for Whiziblesem IssueID 4168
									objWhizStatusDate.value=objCurrentDate.value;
									objStatusTime.value=objCurrentTime.value;
									
									//objStatusTime.value=objTime.value+StatusChangeTimeSpan;
									 
									if(objReadOnlychangedDate!=null)
									objReadOnlychangedDate.value=objCurrentDate.value;

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
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    //Commented And Added By Vaijat K ON 05/12/2015 IssueID-2635
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
            if (WhichBrowser()=='IE')
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
            else if (WhichBrowser() == 'CR')
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
            else if (WhichBrowser() == 'FF')
                intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';		
		}
    //Added by VijayD on 11 Jun 2009 for StatusFlow configuration
    function ValidateStatusFlow(QueryID)
    {
        var validStatusNew;
        var validStatusExist;

        var objOldStatus = GetObjectReference('frmDiscussion','txtOldStatus');
        var objNewStatus = GetObjectReference('frmDiscussion', 'cbostatus');

        var objCompareStatus = GetObjectReference('frmDiscussion','CmbStatus');
        var objPrevStatus = GetObjectReference('frmDiscussion','CmbPrevStatus');
        var objStatusFlowCount = GetObjectReference('frmDiscussion','StatusFlowCount');
        var intStatusFlowCount = objStatusFlowCount.value;
        var statusFlag=0;

        validStatusNew = ""
        validStatusExist = "\n\n";

            if(intStatusFlowCount > 0)
            {
        		
                for(i=0;i<=objCompareStatus.length-1;i++)
                {
                    validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
                }
        		
                for(i=0;i<=objCompareStatus.length-1;i++)
                {
                   //Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
                   if(objNewStatus!=null)
                   {
                    //End Of Addition 
                    if(objCompareStatus[i].value == objNewStatus[objNewStatus.selectedIndex].text)
                    {
	                    validStatusNew = objNewStatus[objNewStatus.selectedIndex].value;
	                    break;
                    }
                   }
                }
                //Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
                if(objNewStatus!=null)
               {
                //Ended By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
                if (objNewStatus[objNewStatus.selectedIndex].text==objOldStatus.value)
                {
                    validStatusNew=objNewStatus[objNewStatus.selectedIndex].value;                
                }
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
             }		
             return true;
    }

    // Addition end by ViajyD on 11 Jun 2009 
    
    function showCommentDiv(ev)
{                
                //objcboRequestType.style.visibility = 'hidden';

                //objcboSubRequestType.style.visibility = 'hidden';
                
                objFeedBackDiv = GetObjectReference('frmDiscussion','DivFeedBack');
                var mousePosition = getMousePosition(ev,objFeedBackDiv);
			    objFeedBackDiv.style.width  = '405px';
			    objFeedBackDiv.style.height  = '150px';
			    objFeedBackDiv.style.left =  mousePosition.x ;
			    objFeedBackDiv.style.top =  mousePosition.y ;		     
		        objFeedBackDiv.style.position ='absolute';
		        document.getElementById('fillDiv').style.display="";
			    objFeedBackDiv.style.display  = '';
			    
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
        
        objContextMenu.style.left = intX - 300 ;
        objContextMenu.style.top = intY  ;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}
function SubmitOK_Onclick()
{
    var objFeedBack = GetObjectReference('frmDiscussion','cboFeedback');
    var objFeedBackComments = GetObjectReference('frmDiscussion','txtFeedbackComments');    
    var objFeedBackDiv = GetObjectReference('frmDiscussion','cboFeedbackDiv');
    var objFeedBackCommentsDiv = GetObjectReference('frmDiscussion','txtSubmitCommentsDiv');
    var objDiv = GetObjectReference('frmDiscussion','DivFeedBack');
    
     if(Trim(objFeedBackCommentsDiv.value) == '')
     {
        alert('Please Enter Feedback comments');
        return;
     }      
      
       
    objFeedBack.value = objFeedBackDiv.value;
    objFeedBackComments.value = objFeedBackCommentsDiv.value;
    
  
    objDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";    
    
     
     SaveData(<%=m_lngQueryID%>)
     
     //objcboRequestType.style.visibility = '';
     //objcboSubRequestType.style.visibility = '';
}
function Cancel_OnClick()
{    
     var objOldStatus = GetObjectReference('frmDiscussion','cboStatusOld');
     var objNewStatus = GetObjectReference('frmDiscussion','cboStatus');

    var objOldStatusChangeDate=window.document.forms['frmDiscussion'].elements['txtchangedDatehidden1'];
    var objOldStatusChangeTime=window.document.forms['frmDiscussion'].elements['txtchangedTimehidden1'];
	var objWhizStatusDate = GetObjectReference('frmDiscussion','FFE29587WHIZ_txtchangedDate');				 					 
	var objOldStatusChangeDate_Control=window.document.forms['frmDiscussion'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
	
	var objCurrentChangeDate = GetObjectReference('frmDiscussion','txtchangedDate');
	var objCurrentChangeTime = GetObjectReference('frmDiscussion','txtchangedTime');
					 
    
    //objcboRequestType.style.visibility = '';
    //objcboSubRequestType.style.visibility = '';
    //objCurrentChangeDate.value = objOldStatusChangeDate.value;
    //objCurrentChangeTime.value = objOldStatusChangeTime.value;
    //objNewStatus.value = objOldStatus.value;
    //objWhizStatusDate.value=objOldStatusChangeDate_Control.value 
    objFeedBackDiv = GetObjectReference('frmDiscussion','DivFeedBack');
    objFeedBackDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";
    
    
}  
  //Integrated by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
//Added By Mandar N on 06-07-2011

		function Faq_Onlick()
		{		
		window.open("../CRM/FrequentlyAskQuestions_CommonList.aspx?QueryID=<%=m_lngQueryID%>&MasterTagId=9017&PKToken=<%=m_PKToken_FromDT%>&DepartmentName=<%=m_DepartmentName%>&Mode=RO&LinkMode=CD&FromWhere=<%=m_strFromWhere%>","FAQ","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
		}
		
		
		function Faq_Convert()
		{
		//debugger;
			var objChkSelect = GetObjectReference('frmDiscussion','chkConvertToFAQ',true);
			var icount;
			var chkCount;
			var icount1;
			var selectedids = "";
			var Queryid = "";
			var FromWhere = "";
			chkCount = 0;
			
		    for(icount=0;icount<objChkSelect.length;icount++)
		    {
			    if(objChkSelect[icount].checked==true)
				    {
				            //if(icount == (objChkSelect.length-1))
				            //{
			            //		document.getElementById("txtIdList").value+=objChkSelect[icount].value;
		            //		}
		            //		else
				            {
				                selectedids = selectedids+objChkSelect[icount].value;
				                selectedids = selectedids+",";
                				
				                document.getElementById("txtIdList").value+=objChkSelect[icount].value;
				                document.getElementById("txtIdList").value+=",";
                				
				                chkCount=chkCount+1; 
				             }
				    }
		    }  
	        if(chkCount<1)
                {
                   alert("Please select atleast one Discussion thread to Convert !");
                   return;                   
                }
	        else if(chkCount>0)
		        {
//		            if(confirm("Are you sure, you want to Convert the selected Discussion Thread(s) to FAQs?"))
//		            {		
	            //comented and Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue
	            //	window.open("../CRM/ConvertDisscussion.aspx?MasterTagID=20003&FromWhere=<%=m_strFromWhere%>&PKToken=<%=m_PKToken_FromDT%>&QueryID=<%=m_lngQueryID%>&CRMQueryDetailId="+selectedids+" ","FAQ","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
	            $.ajax({
	                type: 'POST',
	                dataType: 'json',
	                contentType: 'application/json',
	                url: 'CRM_DiscussionThread.aspx/GenrateURLToken',
	                data: JSON.stringify({Queryid:"<%=m_lngQueryID%>",selectedids:selectedids}),
		            success: function (Result) {
		                window.open("../CRM/ConvertDisscussion.aspx?MasterTagID=20003&FromWhere=<%=m_strFromWhere%>&PKToken=" + Result.d + "&QueryID=<%=m_lngQueryID%>&CRMQueryDetailId=" + selectedids + " ", "FAQ", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=920,height=600");
			             
		            },
		            error: function () {
		              //  alert("Error")
		            }
		        });
	            //endded by Nilesh Gundecha on 19/1/2015 for URL blocking issue
            
		   
			            //alert(document.getElementById("txtIdList").value);
			            //alert(objChkSelect.Checked);		
							
						//window.open("../General/CommonList.aspx?CRMQueryDetailId=144126&MasterTagID=8038")				
						//objform.submit();
				
//		            }
//		            else
//		            {
//		                window.location.reload();
//					}
		        }
	        else
		        {
		            return false;
		        }
        }//end function Faq_Convert()
		
		 //End Integrated by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)

//Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
//-------------------------------------------------------------------
	// disAllowDateTime1GreaterThanDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is greater than Date2-Time2
	//	 then show the message and return true.
					    //-------------------------------------------------------------------	
//function OpenPage1(Result,selectedids)
	//{
 //   window.open("../CRM/ConvertDisscussion.aspx?MasterTagID=20003&FromWhere=<%=m_strFromWhere%>&PKToken=" + Result + "&QueryID=<%=m_lngQueryID%>&CRMQueryDetailId=" + selectedids + " ", "FAQ", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=920,height=600");      
//	}
function disAllowDateTime1GreaterThanDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Date Formats if provided
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;

		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		//Date1 Cannot be Greater than Date2
		if(disallowDate1GreaterThanDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
		{
//alert(objDate1.value);
			return true;
		}
		//If Date1 is equal to Date 2
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Compare for the Time Values as Time1 cannot be Greater than Time2
			if(disAllowTime1GreaterThanTime2(objTime1,objTime2,msg,dofocus))
			return true;			
		}
		return false;
			
}
//End Of Addition
 </script>
</body>
</HTML>
