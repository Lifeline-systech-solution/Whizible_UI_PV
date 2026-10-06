<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="KM_PageListings.aspx.vb" Inherits="PbNIT.KM_PageListings" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<%WritePageHead()%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
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

<body ms_positioning="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmKMPageList" method="post" runat="server">
        <%WritePage()%>
    </form>
    <script>
        var objForm, objdivlist;

        objForm = GetFormReference('frmKMPageList');
        objdivlist = GetObjectReference('frmKMPageList', 'divList');

        <%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>

        function window_onload() {
            var intDivHeight;
            var browser = isIE();
            if (objdivlist) {

                //Commented and Added By Bharat T on 30th-Nov-2015
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                //if (navigator.appName == 'Netscape') {
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
                //}
                if (browser == 'IE') {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 24;
                }
                else {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                //End of Commented and Added By Bharat T on 30th-Nov-2015

                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight+'px';
            }
        }

        function window_onresize() {
            var intDivHeight;
            var browser = isIE();
            if (objdivlist) {

                //Commented and Added By Bharat T on 30th-Nov-2015
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
                //if (navigator.appName == 'Netscape') {
                //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;
                //}
                if (browser == 'IE') {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                else if (browser == 'FF') {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 24;
                }
                else {
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 5;
                }
                //End of Commented and Added By Bharat T on 30th-Nov-2015
                if (intDivHeight < 100) intDivHeight = 100;
                objdivlist.style.height = intDivHeight + 'px';
            }
        }
        // Commented and Added by Usha Pandit on 11.06.2019 for added space not getting display in spacelist without refresh
        function Select_OnClickold() {
         
            var blnIsRecordSelected = false;
            blnIsRecordSelected = IsCheckboxSelected('frmKMPageList', 'chkSelect')
            if (blnIsRecordSelected == false) { alert("Please select atleast one Article to add"); return; }
            //Added by Tejal D date 12/10/2016 to set setFrameLoader
            setFrameLoader();
            //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
            objForm.action = "KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Action=SELECT&SpaceID=<%=m_lngSpaceID%>";
		objForm.submit();
	    //Modification by SuchitraP on 25-Aug-2008 to get the Mode when cliked on display link only if that user has Edit Access for that Space


		if ('<%=m_strFromWhere%>' == 'Search') {
		    if (window.opener != null) {
		        window.opener.document.forms[0].action = "KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=Search&SpaceID=<%=m_lngSpaceID%>&Mode=<%=m_strmode %>"
		        window.opener.document.forms[0].submit();
		    }
		  
		    // window.close();    //Commented by Yogesh J on 09/12/2015 issue id=2550
        }
		else if ('<%=m_strFromWhere%>' == 'MySpace') {
		    //Commented by Yogesh J on 09/12/2015 issue id=2550
            //if (window.opener != null && window.opener.opener)
		    if (window.opener != null && parent.window.opener.parent.window.opener)
		        //End of comment by Yogesh J on 09/12/2015 issue id=2550
            {

		        window.opener.opener.frmKMList.action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
		        window.opener.opener.frmKMList.submit();
		        window.opener.frmKMMySpace.action = "KM_MySpace.aspx?Myflag=2&SpaceID=<%=m_lngSpaceID%>"
		        window.opener.frmKMMySpace.submit();
		        //window.opener.document.forms[0].action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
		        //window.opener.document.forms[0].submit();
		      //  window.close();
            }
            else {
                if (window.opener != null) {

                    /*window.opener.frmKMList.action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
                    window.opener.frmKMList.submit();
                    /KM/KM_MySpace.aspx?PageNumber=1&Fromwhere=MySpace&txtSearch=&Subtab=MY SPACE&From=Manage&SpaceID=48&Mode=Edit*/
                    window.opener.location.href = "../KM/KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&SpaceID=<%=m_lngSpaceID%>"

            }
        }

    }
    else
		    //End of modification by SuchitraP
    {
        if (window.opener != null) {
            if ('<%=m_strTeamID %>' > '0') {
                    if ('<%=m_strActionLink %>' == 'More') {
                        window.opener.location.href = "KM_MySpace.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Myflag=5&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                       }
                       else {
                           window.opener.location.href = "KM_MySpace.aspx?PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Popup=1&Myflag=<%=flag %>&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                       }

                   }
                   else {
                       window.opener.location.href = "KM_MySpace.aspx?PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Myflag=2&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                }
                //window.opener.frmKMMySpace.submit();
                //window.opener.opener.frmKMTeam.action="/km/KM_Team.aspx?From=Manage&TeamID="+window.opener.GetElementById('','TeamID')+"&PKToken=2rGIuMmsGrdmOMuh9DCCg&MasterTagID=3961&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
                //window.opener.document.forms[0].action = "KM_MySpace.aspx?SpaceID=<%=m_lngSpaceID%>"
                //window.opener.document.forms[0].submit();
                /*window.opener.opener.frmKMList.action = "../km/KM_List.aspx?Tab=MY&Subtab=MY TEAMS"
		        window.opener.opener.frmKMList.submit();*/
            }
		    window.close();
		}
        }

          function Select_OnClick() {

            var blnIsRecordSelected = false;
            blnIsRecordSelected = IsCheckboxSelected('frmKMPageList', 'chkSelect')
            if (blnIsRecordSelected == false) { alert("Please select atleast one Article to add"); return; }
            //Added by Tejal D date 12/10/2016 to set setFrameLoader
            setFrameLoader();
            //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
            //Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
            //objForm.action = "KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Action=SELECT&SpaceID=<%=m_lngSpaceID%>";
             //objForm = GetFormReference('frmKMPageList');  //Added by Usha Pandit on 10 july 2018 for selecting form id
             //objForm.action = "../KM/KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Action=ADDSPACE&SpaceID=<%=m_lngSpaceID%>";

             //End Of Modified By Chakshuta H on 9th-Jun-2017 Purpose::QA issue fixing(change action from SELECT to ADDSPACE)
             //objForm.submit();
             //Modification by SuchitraP on 25-Aug-2008 to get the Mode when cliked on display link only if that user has Edit Access for that Space

             var strSelectedIDs = $('input[id=chkSelect]:checked').map(function () {
                 return this.value;
             }).get().join(',');

             var strAction = 'ADDSPACE';
             var lngSpaceID = '<%=m_lngSpaceID%>';

            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: '../KM/KM_PageListings.aspx/PerformAddition',
                data: JSON.stringify({ strAction: strAction, lngSpaceID: lngSpaceID, strSelectedIDs: strSelectedIDs }),
                success: function (Result) {

                    if ('<%=m_strFromWhere%>' == 'Search') {
                        if (window.opener != null) {
                            window.opener.document.forms[0].action = "KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=Search&SpaceID=<%=m_lngSpaceID%>&Mode=<%=m_strmode %>"
                            window.opener.document.forms[0].submit();
                        }

                        window.close();    //Commented by Yogesh J on 09/12/2015 issue id=2550
                    }
                    else if ('<%=m_strFromWhere%>' == 'MySpace') {
                        //Commented by Yogesh J on 09/12/2015 issue id=2550
                        //if (window.opener != null && window.opener.opener)
                        if (window.opener != null && parent.window.opener.parent.window.opener)
                            //End of comment by Yogesh J on 09/12/2015 issue id=2550
                        {

                            window.opener.opener.frmKMList.action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
                            window.opener.opener.frmKMList.submit();
                            window.opener.frmKMMySpace.action = "KM_MySpace.aspx?Myflag=2&SpaceID=<%=m_lngSpaceID%>"
                            window.opener.frmKMMySpace.submit();
                            //window.opener.document.forms[0].action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
                            //window.opener.document.forms[0].submit();
                            window.close();
                        }
                        else {
                            if (window.opener != null) {

                                /*window.opener.frmKMList.action = "KM_List.aspx?Tab=MY&Subtab=MY SPACES"
                                window.opener.frmKMList.submit();
                                /KM/KM_MySpace.aspx?PageNumber=1&Fromwhere=MySpace&txtSearch=&Subtab=MY SPACE&From=Manage&SpaceID=48&Mode=Edit*/
                                window.opener.location.href = "../KM/KM_MySpace.aspx?Myflag=2&PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&SpaceID=<%=m_lngSpaceID%>"
                                window.close();
                            }
                        }

                    }
                    else
                        //End of modification by SuchitraP
                    {
                        if (window.opener != null) {
                            if ('<%=m_strTeamID %>' > '0') {
                                if ('<%=m_strActionLink %>' == 'More') {
                                    window.opener.location.href = "KM_MySpace.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Myflag=5&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                                }
                                else {
                                    window.opener.location.href = "KM_MySpace.aspx?PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Popup=1&Myflag=<%=flag %>&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                                }

                            }
                            else {
                                window.opener.location.href = "KM_MySpace.aspx?PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Myflag=2&SubTab=MY TEAM&Mode=<%=m_strmode %>&SpaceID=<%=m_lngSpaceID%>"
                            }
                            //window.opener.frmKMMySpace.submit();
                            //window.opener.opener.frmKMTeam.action="/km/KM_Team.aspx?From=Manage&TeamID="+window.opener.GetElementById('','TeamID')+"&PKToken=2rGIuMmsGrdmOMuh9DCCg&MasterTagID=3961&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
                            //window.opener.document.forms[0].action = "KM_MySpace.aspx?SpaceID=<%=m_lngSpaceID%>"
                            //window.opener.document.forms[0].submit();
                            /*window.opener.opener.frmKMList.action = "../km/KM_List.aspx?Tab=MY&Subtab=MY TEAMS"
                            window.opener.opener.frmKMList.submit();*/
                        }
                        window.close(); //Commented by Usha Pandit on 10 july 2018 for adding existing articles, as window was getting closed before operation
                    }

                },
                error: function () {
                    // alert("Error")
                }
            });



    }

    // Commented and Added by Usha Pandit on 11.06.2019 for added space not getting display in spacelist without refresh
function txtSearch_KeyPress(e) {
    var code;
    if (e.keyCode)
        code = e.keyCode;
    else
        if (e.which)
            code = e.which;

    if (code == 13) {
        objForm.action = "KM_PageListings.aspx?Filter=1";
        objForm.submit();
    }
}

function AlphaNumericPaging_OnClick(chr) {
    //Added by Tejal D date 12/10/2016 to set setFrameLoader
    setFrameLoader();
    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
    objForm.action = "KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&Filter=1&PagingAlphabet=" + chr;
	    objForm.submit();
	}

	// Paging scripts
        function Page_OnClick(Page) {
            //Added by Tejal D date 12/10/2016 to set setFrameLoader
            setFrameLoader();
            //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
	    objForm.action = "KM_PageListings.aspx?txtSearch=<%=m_strtxtSearch%>&Fromwhere=<%=m_strFromWhere %>&PageNumber=" + Page;
	    objForm.submit();
	}

	var noOfPages = GetObjectReference('frmKMPageList', 'hidNoOfPages').value;
	var objtxtpageNumber = GetObjectReference('frmKMPageList', 'txtPageNumber');
	function validateNumPaging() {

	    if (isNaN(objtxtpageNumber.value)) {
	        alert("Please enter numeric value");
	        return false;
	    }
	    if (parseInt(noOfPages) < parseInt(objtxtpageNumber.value)) {
	        alert("Please enter value within range of 1 to " + noOfPages);
	        return false;
	    }
	    return true;
	}
	function ShowPreviousPage() {
	    if (isBlank(objtxtpageNumber.value))
	        Page_OnClick(1);
	    else {
	        if (!validateNumPaging())
	            return;

	        if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
	        objtxtpageNumber.value = objtxtpageNumber.value - 1;
	        Page_OnClick(objtxtpageNumber.value);
	    }

	}
	function ShowFirstPage() {
	    if (isBlank(objtxtpageNumber.value))
	        Page_OnClick(1);
	    else {
	        if (!validateNumPaging())
	            return;
	        if (objtxtpageNumber.value == 1) { alert("This is the first page"); return; }
	        objtxtpageNumber.value = 1;
	        Page_OnClick(objtxtpageNumber.value);
	    }
	}
	function ShowNextPage() {
	    if (isBlank(objtxtpageNumber.value))
	        Page_OnClick(1);
	    else {
	        if (!validateNumPaging())
	            return;
	        if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
	        objtxtpageNumber.value = parseInt(objtxtpageNumber.value) + 1;
	        Page_OnClick(objtxtpageNumber.value);
	    }
	}
	function ShowLastPage() {
	    if (isBlank(objtxtpageNumber.value))
	        Page_OnClick(noOfPages);
	    else {
	        if (!validateNumPaging())
	            return;
	        if (objtxtpageNumber.value == noOfPages) { alert("This is the last page"); return; }
	        objtxtpageNumber.value = noOfPages;
	        Page_OnClick(objtxtpageNumber.value);
	    }
	}
	function txtPageNumber_KeyPress(e) {
	    var code;
	    if (e.keyCode)
	        code = e.keyCode;
	    else
	        if (e.which)
	            code = e.which;

	    if (code == 13) {
	        var objtxtpageNumber = GetObjectReference('frmKMPageList', 'txtPageNumber');
	        var objtxtNoOfPages = GetObjectReference('frmKMPageList', 'txtNoOfPages');

	        if (!disallowBlank(objtxtpageNumber, "Please Enter Page number", true) && (!disallowNonNumeric(objtxtpageNumber, "Please Enter numeric value for Page number", true)) && (!disallowNegativeNumeric(objtxtpageNumber, "Please Enter positive integer value for Page number", true)) & (!disallowNonInteger(objtxtpageNumber, "Please Enter positive integer value for Page number", true))) {
	            if (Number(objtxtpageNumber.value) == 0) {
	                alert("Page number should be greater than zero!");
	                return;
	            }

	            if (Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value)) {
	                alert("Page number should not be greater than " + objtxtNoOfPages.value);
	                return;
	            }
	            Page_OnClick(objtxtpageNumber.value);
	        }
	    }
	}
	//End paging scripts
    </script>
</html>
