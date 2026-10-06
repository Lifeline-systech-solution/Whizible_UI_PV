<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="KM_MySpace.aspx.vb" Inherits="PbNIT.KM_MySpace" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
<%WritePageHead()%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>



<%CommonFunctions.General.PlotPageHeadTag("")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>



<style>
    .clsTable .clsTRMenu td:first-child {
        /*width: 35%;*/
        vertical-align: middle;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px';
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
        document.body.style.height = window.innerHeight - 3 + 'px';
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
    <form id="frmKMMySpace" method="post" runat="server">
        <%WritePage()%>
    </form>
    <script>
        objForm = GetFormReference('frmKMMySpace');
        objdivMain = GetObjectReference('frmKMMySpace', 'divMain');
        objtxtTitle = GetObjectReference('frmKMMySpace', 'txtTitle');
        objtxtLabels = GetObjectReference('frmKMMySpace', 'txtLabels');
        objtxtDescription = GetObjectReference('frmKMMySpace', 'txtDescription');

        objchkEdit = GetObjectReference('frmKMMySpace', 'chkEdit');
        objchkView = GetObjectReference('frmKMMySpace', 'chkView');

        <%' Added By SonalD on 15th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
    <%' Added By SonalD on 15th Jan 2009 %>


        function window_onload() {
            var intDivHeight;
            if (objdivMain != null) {
                // Commented And Added By Vaijat K ON 24/11/2015
                //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
                //if (navigator.appName == 'Netscape') {
                //    intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
                //}
                intDivHeight = window.innerHeight - objdivMain.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivMain.style.height = intDivHeight + 'px';
            }
            if (objchkView) {
                ShowHideTr('tr_ViewUsers', objchkView)
            }
            if (objchkEdit) {
                ShowHideTr('tr_EditUsers', objchkEdit)
            }
        }

        function window_onresize() {
            var intDivHeight;
            if (objdivMain != null) {
                //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35; // Commented And Added By Vaijat K ON 24/11/2015
                intDivHeight = window.innerHeight - objdivMain.offsetTop - 30;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivMain.style.height = intDivHeight + 'px';
            }
        }

        //Added By Reshma chavan on 10th Aug 2021 For Restrict Special Characters
        function checkSpecialCharacter(value) {
            var regularExpression = "";
            regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/?';

            var isSpecialCharacter = 0;
            for (var i = 0; i < regularExpression.length; i++) {
                if (value != undefined && value != null) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                else {
                    isSpecialCharacter = 0;
                }
            }
            if (isSpecialCharacter == 1) {
                return true;
            }
            else {
                return false;
            }
        }
        //End of Added By Reshma chavan on 10th Aug 2021 For Restrict Special Characters

        function Save_OnClick() {

            var strTeamID = '<%=m_strTeamID%>';

            //var objhidSpaceName=GetObjectReference('frmKMMyPage','hidSpaceName').value;

            if (disallowBlank(objtxtTitle, "Space Name should not be left blank")) return;
            //Added By Reshma chavan on 10th Aug 2021 For Restrict Special Characters
            var SpaceName = objtxtTitle.value;
            if (SpaceName != "") {
                if (checkSpecialCharacter(SpaceName) == true) {
                    alert('Space Name cannot contain any of these /\\:*?<>|,"+- Characters');
                    objtxtTitle.focus();
                    return;
                }
            }
            //End of Added By Reshma chavan on 10th Aug 2021 For Restrict Special Characters
            if (disallowBlank(objtxtLabels, "Search Labels should not be left blank")) return;
            if (disallowBlank(objtxtDescription, "Description should not be left blank")) return;
            if (disallowMaxlengthViolation(objtxtTitle, 50, "Space Name should not exceed 50 characters.")) return;
            if (disallowMaxlengthViolation(objtxtDescription, 1000, "Description should not exceed 1000 characters.")) return;
            //Added By Yogesh J on 21-Oct-2015 Purpose::To Provide validation
            if (disallowMaxlengthViolation(objtxtLabels, 2000, "Search labels should not exceed 2000 characters.")) return;
            //End of Added By Yogesh J on 21-Oct-2015 Purpose::To Provide validation
            if (GetObjectReference('frmKMMySpace', 'chkEdit').checked == true && GetObjectReference('', 'txtEditUsers').value == '') {
                alert('Please select atleast one user.');
                return;
            }


	   <%-- var objhidSpaceName = '<%=strSpaceNameDB %>'.replace(/\s/g, "X").replace(/'/g, '"');--%>

            //Added  By Dipali V On 1july 2020 For Javascript
            var objhidSpaceName = '<%=strSpaceNameDB.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n").Replace(" ", String.Empty).Replace("\n", Environment.NewLine).Replace(vbCr, "").Replace(vbLf, "") %>';
            //End of Added  By Dipali V On 1july 2020 For Javascript
            if (objhidSpaceName.indexOf(',' + Trim(objtxtTitle.value) + ',') >= 0 && '<%=flag%>' == '1') {
                alert('Space "' + objtxtTitle.value + '" already created.');
                // Commented By Rutuja D. on 30 March 2020 For Issueid = 23165
                //objtxtTitle.value = '';
                //objtxtLabels.value = '';
                //objtxtDescription.value = '';
                //End Commented By Rutuja D. on 30 March 2020 For Issueid = 23165
                objtxtTitle.focus();
                return;
            }
            else {
                if ('<%=m_strActionLink %>' == 'More') {
                objForm.action = "KM_MySpace.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Popup=1&Myflag=<%=flag %>&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strMode%>&SubTab=<%=m_strSubTab %>&TeamID=<%=m_strTeamID%>&Action=SAVE&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>";
            }
            else {

                objForm.action = "KM_MySpace.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Popup=<%=m_strPopup%>&Myflag=<%=flag %>&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strMode%>&SubTab=<%=m_strSubTab %>&TeamID=<%=m_strTeamID%>&Action=SAVE&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>";

            }
            //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 
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

            //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 


            objForm.submit();
            //Added By Reshma Chavan on 11th Aug 2021 For Refresh Issue on Add New Space
            window.onunload = refreshMyParent;
            refreshMyParent();
            //End of Added By Reshma Chavan on 11th Aug 2021 For Refresh Issue on Add New Space

            //Addition by SuchitraP on 25-Aug-2008

            if (strTeamID != '' && strTeamID != 'NULL' && strTeamID != 0) {

                //commented by Nilesg g on 9/12/2015 for issue id 2521
                //if (window.opener != null) {
                if (parent.window.opener != null) {

                    window.opener.location.href = "../KM/KM_Team.aspx?Myflag=<%=flag %>&PageNumber=<%=m_strPagingNumber %>&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&Mode=Edit&TeamID=<%=m_strTeamID%>";
                    //commented by Nilesg g on 9/12/2015 for issue id 2521
                    // window.close();
                }
                else {
                    window.document.forms[0].submit();
                }
            }
            else if ("<%=m_strFrom %>" == "Manage")
                //End by SuchitraP
                {
                    //commented by Nilesg g on 9/12/2015 for issue id 2521
                    // if (window.opener != null) {
                    if (parent.window.opener != null) {

                        window.opener.location.href = "../km/KM_List.aspx?Tab=MY&Subtab=MY SPACES";
                    }
                }

                else {
                    if (window.opener != null) {

                        window.opener.document.forms[0].submit();
                        //commented by Nilesg g on 9/12/2015 for issue id 2521
                        //  window.close();
                    }
                    //window.opener.document.forms[0].submit();
                }
            }

        }

        //Added By Reshma Chavan on 11th Aug 2021 For Refresh Issue on Add New Space
        function refreshMyParent() {
            opener.location.href = opener.location.href;
        }
        //End of Added By Reshma Chavan on 11th Aug 2021 For Refresh Issue on Add New Space
        function validateHeaderSection() {

            if (disallowBlank(objtxtTitle, "Title should not be left blank")) return;
            if (disallowBlank(objtxtLabels, "Labels should not be left blank")) return;
            if (disallowBlank(objtxtDescription, "Description should not be left blank")) return;

        }

        function AddPage_OnClick(subTab, strMode, strFrom) {

            if (strFrom == "MyTeam") {
                window.open("KM_PageListings.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=<%=flag %>&PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID%>&FromWhere=MyTeam&Mode=" + strMode + "&txtSearch=<%=m_strtxtSearch %>&SpaceID=<%=m_intSpaceID%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
        }
        else if (strFrom == "MySpace") {
            window.open("KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&FromWhere=MySpace&txtSearch=<%=m_strtxtSearch %>&Mode=" + strMode + "&SpaceID=<%=m_intSpaceID%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
        }
        else if (strFrom == "MyTeamEdit") {
            window.open("KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&TeamID=<%=m_strTeamID%>&FromWhere=MyTeamEdit&Mode=" + strMode + "&txtSearch=<%=m_strtxtSearch %>&SpaceID=<%=m_intSpaceID%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
        }
        else {
            window.open("KM_PageListings.aspx?PageNumber=<%=m_strPagingNumber %>&FromWhere=Search&txtSearch=<%=m_strtxtSearch %>&Mode=" + strMode + "&SpaceID=<%=m_intSpaceID%>", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
            }
        }

        function DeletePage_OnClick() {

            var blnIsRecordSelected = false;
            blnIsRecordSelected = IsCheckboxSelected('frmKMMySpace', 'chkDelete')
            if (blnIsRecordSelected == false) { alert("Please select atleast one Article to delete."); return; }

            if (confirm("Are you sure you want to delete the Article?") == true) {
                if ('<%=m_strActionLink %>' == 'More') {
            objForm.action = "KM_MySpace.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&PageNumber=<%=m_strPagingNumber %>&FromWhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&Myflag=5&Action=DELETE_PAGES&SpaceID=<%=m_intSpaceID%>";
        }
        else {
            objForm.action = "KM_MySpace.aspx?PageNumber=<%=m_strPagingNumber %>&FromWhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&Myflag=<%=flag %>&Action=DELETE_PAGES&SpaceID=<%=m_intSpaceID%>";
                }
                //Added by Tejal D date 12/10/2016 to set setFrameLoader
                setFrameLoader();
                //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
                objForm.submit();
                //Commented by Yogesh J on 02-Dec-2015 issueid:2551
                // if (window.opener != null) {
                //     window.opener.location.href = window.opener.location.href;
                // }
                //End of comment by Yogesh J on 02-Dec-2015
            }
        }

        //Added SpaceID by SuchitraP
        function Page_OnClick(PageID, strMode, SpaceID, strFrom) {

            if (SpaceID == 0) {
                window.open("KM_PageView.aspx?Fromwhere=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>&SpaceID=" + SpaceID + "&Mode=" + strMode + "&PageID=" + PageID, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=900,height=650");
        }
        else
        //End by SuchitraP
        {
            //window.open("KM_MyPage.aspx?Myflag=2&Fromwhere=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>&SpaceID=" + SpaceID + "&Mode=" + strMode + "&PageID=" + PageID, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=900,height=650");

            //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'KM_MySpace.aspx/GenrateArticleToken',
                data: JSON.stringify({ PageID: PageID, SpaceID: SpaceID, EmployeeId: "<%=Session("intUserID")%>" }),
                success: function (Result) {
                    window.open("KM_MyPage.aspx?Myflag=2&Fromwhere=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>&SpaceID=" + SpaceID + "&Mode=" + strMode + "&PageID=" + PageID + "&PKToken=" + Result.d, "", "resizable=no,scrollbars=Yes,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=900,height=650");
                },
                error: function () {
                    // alert("Error")
                }
            });

                //End of addition by Dhanashri S on 29 Mar 2016
            }

        }

        function UserSelection_Onclick(strMode) {
            objtxtViewUserIDs = GetObjectReference('frmKMMySpace', 'txtViewUserIDs');
            objtxtEditUserIDs = GetObjectReference('frmKMMySpace', 'txtEditUserIDs');

            if (strMode == "View") {
                window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtViewUsers&UserIDsTextBox=txtViewUserIDs&FormName=frmKMMySpace&UserIDs=" + objtxtViewUserIDs.value, "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=850,height=400");
            }
            else {
                window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtEditUsers&UserIDsTextBox=txtEditUserIDs&FormName=frmKMMySpace&UserIDs=" + objtxtEditUserIDs.value, "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 850) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=850,height=400");
            }
        }

        function ShowHideTr(strTrName, objCheckBox) {

            objTr = GetObjectReference('frmKMMySpace', strTrName);
            if (objCheckBox.checked == true)
                objTr.style.display = ""
            else
                objTr.style.display = "None"

        }

        //Addition by SuchitraP on 25-Aug-2008 to display AddPage link only if that user has Edit Access for that Space
        function AddPage(intSpaceID) {
            //alert('test');
            //window.location.href="../km/KM_PageListings.aspx?SpaceID="+intSpaceID;
            window.open("KM_PageListings.aspx?FromWhere=ViewEdit&SpaceID=" + intSpaceID + "", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=750,height=650");
        }

        function AddNewPage(intSpaceID) {
        //window.open("KM_MyPage.aspx?Myflag=1&PageNumber=<%=m_strPagingNumber %>&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&SpaceID=" + intSpaceID + "", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 750) / 2 + ",width=900,height=750");
        //Added By Chakshuta H on 11th-Aug-2016  to generate and validate Token
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'KM_MySpace.aspx/GenrateAddpageToken',
            data: JSON.stringify({ SpaceID: intSpaceID, EmployeeId: "<%=Session("intUserID")%>" }),
            success: function (Result) {

                //window.open("../../Source/KM/KM_ArticleRating.aspx?From=<%=m_strFromWhere%>&PKToken=" + Result.d + "&ProcedureID=" + ArticleID + "", null, "resizable=no,scrollbars=yes,left=" + (window.screen.width - 400) / 2 + ",top=" + (window.screen.height - 290) / 2 + ",width=400,height=290");
                window.open("KM_MyPage.aspx?Myflag=1&PageNumber=<%=m_strPagingNumber %>&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&SpaceID=" + intSpaceID + "&PKToken=" + Result.d + "", "", "resizable=no,scrollbars=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 750) / 2 + ",width=900,height=750");
            },
            error: function () {
                //   alert("Error")
            }
        });

            //End of Added By Chakshuta H on 11th-Aug-2016
        }
        //End of addition by SuchitraP

        //Added by SuchitraP on 30-Sep-2008 for IssueID 22958
        //If User want to Edit another Space after editing previous space window had to be closed initially
        function Back_OnClick(strFrom, SpaceID) {

            //window.location.href="../General/CommonList.aspx?From=Manage&MasterTagID=3960";
            if (strFrom == 'MySpace') {
                window.location.href = "../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere=" + strFrom + "&Tab=MY&Subtab=MY SPACES&SelectList=5&txtSearch=<%=m_strtxtSearch %>";
        }
        else if (strFrom == 'MyTeam') {
            if ('<%=m_strActionLink %>' == 'More') {
                window.location.href = "../KM/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere=" + strFrom + "&Action=<%=m_strActionLink %>&Tab=MY&Subtab=MY TEAMS&PrimaryKey=<%=m_strPrimaryKey %>";
            }
            else {
                window.location.href = "../KM/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere=" + strFrom + "&Tab=MY&Subtab=MY TEAMS&SelectList=6&txtSearch=<%=m_strtxtSearch %>";
            }
        }
        else if (strFrom == 'Search') {
            if ('<%=m_strActionLink %>' == 'More') {
                window.location.href = "../Km/KM_List.aspx?Action=More&Tab=HOME&From=Spaces&FromWhere=" + strFrom + "&txtSearch=<%=m_strtxtSearch %>";
            }
            else {
                window.location.href = "../Km/Km_List.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere=" + strFrom + "&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
            }
        }
        else if (strFrom == 'MySpaceEdit') {
            window.location.href = "../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere=" + strFrom + "&Tab=MY&Subtab=MY SPACES&SelectList=5&txtSearch=<%=m_strtxtSearch %>";
        }
        else if (strFrom == 'LatestFeatured') {
            window.location.href = "../Km/Km_List.aspx?PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere=" + strFrom + "&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
            }

        }
//End by SuchitraP

    </script>
</body>
</html>
