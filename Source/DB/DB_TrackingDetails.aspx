<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_TrackingDetails.aspx.vb" Inherits="PbNIT.DB_TrackingDetails" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>Tracking Details</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">

		<script language='javascript' src='../General/CommonFunctions.js'></script>
	    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
		<%CommonFunctions.General.PlotPageHeadTag("Tracking Details")%>
   <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
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
        setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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

	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="FrmTrackingDetails" method="post" runat="server">
			<%WritePage()%>
		</form>
        <link href="../General/loaderStylesheet.css" rel="stylesheet" />
		<script language="Javascript">
		    //  window.onload =setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
		    window.onload = function () {
		        RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
		    }
		var objform;
		var objdivlist;
		var objtxtComment;
		var objtxtFromWhich;
		var objdtDueDate;
		var obchkComplete;
		var objCurrentDate;
		var objtxtFromWhere;
		var tag;
		var filter;
		var status;
		var Location;
		//Added By JyotiG
		//Issue ID : 5809
		//Start
		var objcbFlagTo;
		//End
		
		objform = GetFormReference('FrmTrackingDetails');
		objdivlist = GetObjectReference('FrmTrackingDetails','divList');
		objdtDueDate = GetObjectReference('FrmTrackingDetails','dtDueDate');
		objtxtFromWhich = GetObjectReference('FrmTrackingDetails','txtFromWhich');
		objtxtFromWhere=GetObjectReference('FrmTrackingDetails','txtFromWhere');
		var objTempDate =GetObjectReference('FrmTrackingDetails','FFE29587WHIZ_dtDueDate');
		//Mofified By JyotiG
        //Start
        //Purpose : On Blur Event Added to set Focus
        //Issue ID : 5825
		obchkComplete = GetObjectReference('FrmTrackingDetails','chkComplete');
		//End
		
		//Added By JyotiG
		//Issue ID : 5809
		//Start
		objcbFlagTo = GetObjectReference('FrmTrackingDetails','cbFlagTo');
		//End
		// Integrated by ArchanaN on 26 Apr 2007
		 	var intParentQueryID = <%=m_ParentQueryID%>;
			//var strParentQueryToken = '<%=m_ParentQueryToken%>';
		 // Integration Ends

        <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		    window.onunload=function(){window.close();}//Added by Nilesh g on 15/1/2015 
		function Clear_OnClick()
		{
		 
		    //Added by Tejal D date 12/10/2016 to set setFrameLoader
		    setFrameLoader();
		    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader

             //Commented and Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
            //objform.action = "DB_TrackingDetails.aspx?Action=Clear";
            objform.action = "DB_TrackingDetails.aspx?Action=Clear&PKToken=" + "<% =m_TokenKEY %>";
            //End of Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
            objform.submit();
             //Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
            window.onunload = refreshMyParent;
            function refreshMyParent() {
                //End of Added by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
                if (objtxtFromWhich.value == 'PMDashboard')
                //refreshParent('Graph','PMDashboard.aspx','PMDashboard.aspx');
                {
                    opener.location.href = opener.location.href;
                }
                else if (objtxtFromWhich.value == 'BTS') {
                    opener.location.href = opener.location.href;
                }
                //Added by PrashantSJ on 09 Nov 2006 For PMLifeline
                //To refer the parent for HelpDesk My e-Dashboard
                else if (objtxtFromWhich.value == 'HelpDesk' && objtxtFromWhere.value == 'MD')
                //refreshParent('Graph','DeveloperDB.aspx','DeveloperDB.aspx');
                {
                    opener.opener.location.href = opener.opener.location.href;

                }
                //End of addition by PrashantSJ on 09 Nov 2006
                // Added by SrikanthY on 30 Nov 2006
                else if (objtxtFromWhich.value == 'FlagTrack') {
                    //opener.location.href = "../DB/Alerts_CommonList.aspx?MasterTagID=5147&ParentTagID=0";
                    tag = opener.location.href.indexOf('MasterTagID')
                    filter = opener.location.href.indexOf('SetFilter')
                    if (filter != -1) {
                        opener.location.href = opener.location.href.substring(0, filter) + 'MasterTagID=3707';
                    }
                    if (filter == -1) {
                        if (tag == -1) {
                            opener.location.href = opener.location.href + '&MasterTagID=3707';
                        }
                        else {
                            opener.location.href = opener.location.href;
                        }
                    }
                }
                // End of addition by SrikanthY

                else if (objtxtFromWhich.value != 'HelpDesk') {
                    if (objtxtFromWhich.value != 'BTS' && objtxtFromWhich.value != 'FlagTrack') {
                        if (objtxtFromWhich.value == 'HelpDeskDtls') {
                            var ReplacedURL;

                            ReplacedURL = replaceSubstring(window.opener.location.href, 'Action=', 'Action1=');
                            ReplacedURL = replaceSubstring(ReplacedURL, 'Apply=', 'Apply1=');

                            window.opener.location.href = ReplacedURL;


                            if (intParentQueryID == 0) {
                                filter = opener.opener.location.href.indexOf('FilterID')
                                //Added By ShraddhaM on 25,July 2007 
                                //HelpDesk - e-Dashboard-> Filter value does not persist
                                status = opener.opener.location.href.indexOf('StatusID');
                                Location = opener.opener.location.href.indexOf('LocationID');
                                var Href = opener.opener.location.href;
                                //End of Addition By ShraddhaM on 25,July 2007 
                                if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestDetail.aspx") != "CRM_RequestDetail.aspx") {
                                    //Added by PrashantD on 7 Nov 2007 for Sierra Issue
                                    if (Href.substring(Href.length - 4, Href.length).toUpperCase() == "ASPX")
                                        Href = Href + "?";


                                    //For Filter Combo
                                    if (filter == -1)
                                        //ADDED BY NILESH G ON 23/8/2016 pURPOSE :jAVASCRIPT ISSUE
                                        //  Href = Href + "&FilterID=" + window.opener.opener.document.getElementById('cboFilter').value;
                                        if (window.opener.opener.document.getElementById('cboFilter')) {
                                            Href = Href + "&FilterID=" + window.opener.opener.document.getElementById('cboFilter').value;
                                        }
                                        else
                                            Href = Href;

                                    //For Status Combo
                                    if (status == -1)
                                        //ADDED BY NILESH G ON 23/8/2016 pURPOSE :jAVASCRIPT ISSUE
                                        //Href = Href + "&StatusID=" + window.opener.opener.document.getElementById('cboStatus').value; 
                                        if (window.opener.opener.document.getElementById('cboStatus')) {
                                            Href = Href + "&StatusID=" + window.opener.opener.document.getElementById('cboStatus').value;
                                        }
                                        else
                                            Href = Href;

                                    opener.opener.location.href = Href;

                                }


                            }
                        }
                        else {
                            opener.location.href = opener.location.href; //"../DB/DeveloperDB.aspx";
                        }
                    }

                }
                // Integrated by ArchanaN on 26 Apr 2007
                //Added by SrikanthY On 08 Jan 2007 For clearing the Details when called form HelpDesk
                //Commented By ShraddhaM on 1,Aug 2007
                //Filter values not persisting on My-Dashboard page when u clear the flag.
                /*
                else if (objtxtFromWhich.value == 'HelpDesk' && objtxtFromWhere.value == 'DB')
                {
                          opener.location.href = opener.location.href; 
                }*/
                //End of comment By ShraddhaM on 1,Aug 2007
                //Added By ShraddhaM on 1,Aug 2007
                //Filter values not persisting on My-Dashboard page when u clear the flag.
                else if (objtxtFromWhich.value == 'HelpDesk') {

                    if (intParentQueryID == 0) {
                        filter = opener.location.href.indexOf('FilterID')

                        status = opener.location.href.indexOf('StatusID');
                        Location = opener.location.href.indexOf('LocationID');
                        var Href = opener.location.href;

                        if (window.opener != null && window.opener.location.href.match("CRM_RequestDetail.aspx") != "CRM_RequestDetail.aspx") {
                            //Added by PrashantD on 7 Nov 2007 for Sierra Issue
                            if (Href.substring(Href.length - 4, Href.length).toUpperCase() == "ASPX")
                                Href = Href + "?";
                            //End of addition by PrashantD on 7 Nov 2007

                            //For Filter Combo
                            if (filter == -1)
                                Href = Href + "&FilterID=" + window.opener.document.getElementById('cboFilter').value;
                            else
                                Href = Href;

                            //For Status Combo
                            if (status == -1)
                                Href = Href + "&StatusID=" + window.opener.document.getElementById('cboStatus').value;
                            else
                                Href = Href;

                            //For Location Combo
                            /*if (Location == -1)
                            Href = Href + "&LocationID=" + window.opener.document.getElementById('cboLocation').value; 
                            else
                            Href = Href;*/

                            opener.location.href = Href;

                        }


                    }


                }
                //End of Addition By ShraddhaM on 1,Aug 2007
                //End of addition by SrikanthY

                // Integration Ends
                //Commented by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
                //window.close();
                //End ofCommented by Usha Pandit on 07.06.2019 for Clear Flag Refresh issue
            }
		}

		function Save_OnClick()
		{

			if (validate() == true)
			{
				//'Added by ShraddhaM on 20, July 2007
				//Purpose : If DueDate is Less than Today's date then IsComplete should be 1
				objCurrentDate = GetObjectReference('FrmTrackingDetails','dtCurrentDate');
				if(compareDates(objdtDueDate.value,objCurrentDate.value) == -1)
				{	 
					obchkComplete.checked = true;
				}
				//End of Addition by ShraddhaM on 20, July 2007
			
				var CheckVal;
				obchkComplete = GetObjectReference('FrmTrackingDetails','chkComplete');
				if (obchkComplete.checked == true)
					CheckVal = 1;
				else
					CheckVal = 0;
			    //Added by Tejal D date 12/10/2016 for Loader Before Save
			    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
				var MenuTags = document.getElementsByTagName('A');
				for (i = 0; i < MenuTags.length; i++) {
				    if (MenuTags[i].className == "Menu") {
				        //MenuTags[i].style.display= "none";
				        MenuTags[i].parentNode.style.display = "none";
				    }
				}
				setFrameLoader();
			    //ADDED BY Tejal D ON 12/2/2016 FOR SAVE ISSUE  
			    // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 

			    //End of Addtion by tejal Deshmukh date 12/10/2016 for Loader Before Save
                //Commented and Added by Usha Pandit on 07.06.2019 for Save Refresh issue
                //objform.action = "DB_TrackingDetails.aspx?Action=Generate&IsCheck=" + CheckVal;
                objform.action = "DB_TrackingDetails.aspx?Action=Generate&IsCheck=" + CheckVal + "&PKToken=" + "<% =m_TokenKEY %>";
                //End of Added by Usha Pandit on 07.06.2019 for Save Refresh issue
                objform.submit();
				 
				  //Added by Usha Pandit on 07.06.2019 for Save Refresh issue
            window.onunload = refreshMyParent;
                function refreshMyParent() {
                    //End of Added by Usha Pandit on 07.06.2019 for Save Refresh issue 

                    if (objtxtFromWhich.value == 'PMDashboard')
                    //refreshParent('Graph','PMDashboard.aspx','PMDashboard.aspx');
                    {
                        opener.location.href = opener.location.href; //"../DB/PMDashboard.aspx";
                    }
                    else if (objtxtFromWhich.value == 'BTS') {
                        opener.location.href = opener.location.href;
                    }
                    // Added by SrikanthY on 30 Nov 2006
                    else if (objtxtFromWhich.value == 'FlagTrack') {
                        //opener.location.href = "../DB/Alerts_CommonList.aspx?MasterTagID=5147&ParentTagID=0";
                        tag = opener.location.href.indexOf('MasterTagID')
                        filter = opener.location.href.indexOf('SetFilter')

                        if (filter != -1) {
                            opener.location.href = opener.location.href.substring(0, filter) + 'MasterTagID=3707';
                        }
                        if (filter == -1) {
                            if (tag == -1) {

                                opener.location.href = opener.location.href + '&MasterTagID=3707';
                            }
                            else {

                                opener.location.href = opener.location.href;
                            }
                        }
                    }
                    // End of addition by SrikanthY

                    else if (objtxtFromWhich.value != 'HelpDesk')
                    //refreshParent('Graph','DeveloperDB.aspx','DeveloperDB.aspx');
                    {
                        if (objtxtFromWhich.value != 'BTS' && objtxtFromWhich.value != 'FlagTrack') {
                            if (objtxtFromWhich.value == 'HelpDeskDtls') {
                                //opener.location.href = opener.location.href; 

                                var ReplacedURL;

                                ReplacedURL = replaceSubstring(window.opener.location.href, 'Action=', 'Action1=');
                                ReplacedURL = replaceSubstring(ReplacedURL, 'Apply=', 'Apply1=');

                                window.opener.location.href = ReplacedURL;

                                if (intParentQueryID == 0) {
                                    filter = opener.opener.location.href.indexOf('FilterID')
                                    //Added By ShraddhaM on 25,July 2007 
                                    //HelpDesk - e-Dashboard-> Filter value does not persist
                                    status = opener.opener.location.href.indexOf('StatusID');
                                    Location = opener.opener.location.href.indexOf('LocationID');
                                    var Href = opener.opener.location.href;
                                    //End of Addition By ShraddhaM on 25,July 2007 
                                    if (window.opener.opener != null && window.opener.opener.location.href.match("CRM_RequestDetail.aspx") != "CRM_RequestDetail.aspx") {
                                        //Added by PrashantD on 7 Nov 2007 for Sierra Issue
                                        if (Href.substring(Href.length - 4, Href.length).toUpperCase() == "ASPX")
                                            Href = Href + "?";


                                        //For Filter Combo
                                        if (filter == -1)
                                            //ADDED BY NILESH G ON 23/8/2016 pURPOSE :jAVASCRIPT ISSUE
                                            //  Href = Href + "&FilterID=" + window.opener.opener.document.getElementById('cboFilter').value;
                                            if (window.opener.opener.document.getElementById('cboFilter')) {
                                                Href = Href + "&FilterID=" + window.opener.opener.document.getElementById('cboFilter').value;
                                            }
                                            else
                                                Href = Href;

                                        //For Status Combo
                                        if (status == -1)
                                            //ADDED BY NILESH G ON 23/8/2016 pURPOSE :jAVASCRIPT ISSUE
                                            //Href = Href + "&StatusID=" + window.opener.opener.document.getElementById('cboStatus').value; 
                                            if (window.opener.opener.document.getElementById('cboStatus')) {
                                                Href = Href + "&StatusID=" + window.opener.opener.document.getElementById('cboStatus').value;
                                            }
                                            else
                                                Href = Href;

                                        opener.opener.location.href = Href;

                                    }


                                }
                            }
                            else {
                                opener.location.href = opener.location.href; //"../DB/DeveloperDB.aspx";
                            }
                        }
                    }
                    // Integrated by ArchanaN on 26 Apr 2007
                    //Modified by SrikanthY on 15 Jan 2007 for issues 9426,9443
                    //Added by SrikanthY On 05 Jan 2007 For Saving the Details when called form HelpDesk
                    else if (objtxtFromWhich.value == 'HelpDesk') {

                        if (intParentQueryID == 0) {
                            filter = opener.location.href.indexOf('FilterID')
                            //Added By ShraddhaM on 25,July 2007 
                            //HelpDesk - e-Dashboard-> Filter value does not persist
                            status = opener.location.href.indexOf('StatusID');
                            Location = opener.location.href.indexOf('LocationID');
                            var Href = opener.location.href;
                            //End of Addition By ShraddhaM on 25,July 2007 
                            if (window.opener != null && window.opener.location.href.match("CRM_RequestDetail.aspx") != "CRM_RequestDetail.aspx") {
                                //Added by PrashantD on 7 Nov 2007 for Sierra Issue
                                if (Href.substring(Href.length - 4, Href.length).toUpperCase() == "ASPX")
                                    Href = Href + "?";
                                //End of addition by PrashantD on 7 Nov 2007
                                //Commented By ShraddhaM on 25,July 2007 
								/*if (filter == -1)
								opener.location.href = opener.location.href + "&FilterID=" + window.opener.document.getElementById('cboFilter').value; 
								else
								opener.location.href = opener.location.href;*/
                                //End of Comment By ShraddhaM on 25,July 2007 

                                //Added By ShraddhaM on 25,July 2007 
                                //HelpDesk - e-Dashboard-> Filter value does not persist

                                //For Filter Combo
                                if (filter == -1)
                                    Href = Href + "&FilterID=" + window.opener.document.getElementById('cboFilter').value;
                                else
                                    Href = Href;

                                //For Status Combo
                                if (status == -1)
                                    Href = Href + "&StatusID=" + window.opener.document.getElementById('cboStatus').value;
                                else
                                    Href = Href;

                                //								//Commneted By VijayD On 12 Jun 2009
                                //								//Purpose : CboLocation is removed from opener page.
                                //								//For Location Combo
                                //								if (Location == -1)
                                //								Href = Href + "&LocationID=" + window.opener.document.getElementById('cboLocation').value; 
                                //								else
                                //								Href = Href;
                                //								
                                opener.location.href = Href;
                                //								//End of Addition By ShraddhaM on 25,July 2007 	 
                                //                              //End Commnet By VijayD On 12 Jun 2009
                            }


                        }
                        //else
                        //{
                        //alert(opener.location.href.substring(0,filter)+'?Mode=EDIT&FromWhere=SR&QueryID='+<%=m_ParentQueryID%>+'&PKToken='+<%=m_ParentQueryToken%>);
                        ////opener.location.href = opener.location.href.substring(0,filter)+'?Mode=EDIT&FromWhere=SR&QueryID='+<%=m_ParentQueryID%>+'&PKToken='+<%=m_ParentQueryToken%>;
                        //}

                    }


                    //End of Addition by Srikanth
                    //End of Modification by SrikanthY		 
                    // Integration Ends


                    //window.close(); Commented by Nilesh g on 15/1/2015 

                }
			}
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function Help_OnClick()
		{	//Help ID Updated for PM and Developer DB by JyotiG(29-Aug-2006)
			//Issue ID : 5815
			if (objtxtFromWhich.value == 'PMDashboard')
			{
				window.open ("../General/Help.aspx?HelpID=Tracking","_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
			}	
			else
			{
			//window.open("../General/Help.aspx?HelpID=" + 32 ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250"); 
				window.open ("../General/Help.aspx?HelpID=Tracking","_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
			}
		}
		
		function validate()
		{
			objCurrentDate = GetObjectReference('FrmTrackingDetails','dtCurrentDate');

			if (disallowBlank(objdtDueDate,"Due Date cannot be blank",true)) return false;
		
			//Commented by ShraddhaM on 20, July 2007
			//Purpose : Allow Flag for follow up for Previous Date
            //Uncommented By  Usha Pandit on 19.06.2019 for not allowing Due date less than todays date
			if(disallowDate1LessThanDate2(objdtDueDate,objCurrentDate,"Due date should not be less than today's date.", true)) return;
            //End of Uncommented By  Usha Pandit on 19.06.2019 for not allowing Due date less than todays date
            //End of Comment by ShraddhaM on 20, July 2007
			
			return true;
		}
		
				
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;		
			//Added By JyotiG
			//Issue Id : 5809
			//Start
			
			objcbFlagTo.focus();
			
			//objTempDate.tabIndex='2';
			//objdtDueDate.tabIndex='3';
			//obchkComplete.tabIndex='4';
			//End
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;		
		}

	//-------------------------------------------------------------------
	//	refreshParent(parentFormName,submitToPage[,closeChildWindow])
	//		Refresh the parent window
	//		parentFormName		-	Parent Form Name
	//		submitToPage		-	Submit to page name
	//		closeChildWindow	-	Optional parameter
	//								If true then close the window
	//-------------------------------------------------------------------
		function refreshParent(parentFormName,parentPage,submitToPage) 
		{
			var closeChildWindow=(arguments.length>3)?arguments[3]:false;
       		var strParentPage;
			strParentPage = new String();
			strParentPage = opener.location.href;
			// If the document loaded in the parent window is the Page to submit, then refresh the page.
			if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1)
			{
        		window.opener.document.forms[parentFormName].action = submitToPage;
        		window.opener.document.forms[parentFormName].submit();
			}
			if (closeChildWindow==true) { window.close(); }
		}
		//Mofified By JyotiG
        //Start
        //Purpose : On Blur Event Added to set Focus
        //Issue ID : 5825
		function cbFlagTo_OnBlur()
		{
			var objTempDate =GetObjectReference('FrmTrackingDetails','FFE29587WHIZ_dtDueDate');
			setFocus(objTempDate);
			
		}
		//End
        </script>
	</body>
</HTML>
