<!-- Commented by Madhuri.K on 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Madhuri.K on 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="WhizChecklist.aspx.vb" Inherits="PbNIT.WhizChecklist" %>


<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Checklist</title>
    <link rel="stylesheet" type="text/css" href="../General/core.css" /><link rel="stylesheet" type="text/css" href="../General/PWAStyle.css" />
    <link rel="stylesheet" type="text/css" href="../General/StyleSheetChanakya_WhizP2007.css" />
    <script type="text/javascript" language='javascript' src='../General/CommonFunctions.js'></script>
    <script  type="text/javascript" language='javascript' src='../General/CommonValidations.js'></script>
    
    <style type="text/css">
	.zz1_TopNavigationMenu_0 { background-color:white;visibility:hidden;display:none;position:absolute;left:0px;top:0px; }
	.zz1_TopNavigationMenu_1 { text-decoration:none; }
	.zz1_TopNavigationMenu_2 {  }
	.zz1_TopNavigationMenu_3 { border-style:none; }
	.zz1_TopNavigationMenu_4 {  }
	.zz1_TopNavigationMenu_5 {  }
	.zz1_TopNavigationMenu_6 { border-style:none; }
	.zz1_TopNavigationMenu_7 {  }
	.zz1_TopNavigationMenu_8 {  }
	.zz1_TopNavigationMenu_9 { border-style:none; }
	.zz1_TopNavigationMenu_10 {  }
	.zz1_TopNavigationMenu_11 { border-style:none; }
	.zz1_TopNavigationMenu_12 {  }
	.zz1_TopNavigationMenu_13 { border-style:none; }
	.zz1_TopNavigationMenu_14 {  }
	.zz1_TopNavigationMenu_15 { border-style:none; }
	.zz1_TopNavigationMenu_16 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_0 { background-color:white;visibility:hidden;display:none;position:absolute;left:0px;top:0px; }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_1 { text-decoration:none; }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_2 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_3 { border-style:none; }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_4 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_5 { border-style:none; }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_6 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_7 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_8 {  }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_9 { border-style:none; }
	.ctl00_PlaceHolderLeftNavBar_idPwaQuickLaunch_10 {  }
	.ctl00_PlaceHolderMain_Header_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_Left_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_Middle_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_Right_0 { border-color:Black;border-width:1px;border-style:Solid; }
	.ctl00_PlaceHolderMain_Footer_0 { border-color:Black;border-width:1px;border-style:Solid; }

</style>

    <script type="text/javascript"  language="javascript">
        function ShowHideSection(strImg, strSectionId)
        {
               var objSection = document.getElementById(strSectionId);
               var objImg = document.getElementById(strImg);
               if(objSection.style.display=='none')
               {
                    objSection.style.display = 'inline';
                    objImg.src = '../../Images/minus.gif';
               }
               else
               {
                    objSection.style.display = 'none';
                    objImg.src = '../../Images/plus.gif';
               }
        }
        
        function validateMaxLength(source , arguments )
        { 
           
           if( disallowMaxlengthViolation(GetObjectReference('frmWhizTemplate',source.controltovalidate),source.title)==true) 
             arguments.IsValid=false;
        }
     

        function ValidateSpecialCharacters(source, arguments)
        {
           if( disallowSpecialCharacters(GetObjectReference('frmWhizTemplate',source.controltovalidate),source.title)==true) 
             arguments.IsValid=false;
        
        }  
        
        function EditQuestion(QuestionnaireQuestionId , QuestionnaireID )      
        {
            //window.parent.frames['WhizVisualProcessGrid'].document.location.href = "WhizEditQuestion.aspx?MODE=MODIFY&QuestionnaireQuestionID_PK=" + QuestionnaireQuestionId +"&QuestionnaireID=" +  QuestionnaireID;
            window.location.href = "WhizEditQuestion.aspx?MODE=MODIFY&QuestionnaireQuestionID_PK=" + QuestionnaireQuestionId +"&QuestionnaireID=" +  QuestionnaireID;
        }
        
        function addItem_OnClick(QuestionnaireID)
        {
            //window.parent.frames['WhizVisualProcessGrid'].document.location.href = "WhizChecklistQuestion.aspx?QuestionnaireID_PK=" + QuestionnaireID;
            window.location.href = "WhizChecklistQuestion.aspx?QuestionnaireID_PK=" + QuestionnaireID;
        }
        function DeleteItem_OnClick(QuestionnaireID)
        {
            var objfrm = GetFormReference('frmWhizChecklist');
            var i=0;
            var objchkDelete = GetObjectReference("frmWhizChecklist","chkDelete",true);
            var objQuestions= GetObjectReference("frmWhizChecklist","txtQuestions");
            var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmWhizChecklist','chkDelete')
            if (blnIsRecordSelected == false) {return;}

            if(confirm("Are you sure you want to delete the selected records?")==false) return;

            objQuestions.value = "";
             for(i=0;i<objchkDelete.length;i++)
            {
                if(objchkDelete[i].checked==true)
                {
                    if(objQuestions.value=="")
                    {
                        objQuestions.value = objchkDelete[i].value;
                    }
                    else
                    {
                        objQuestions.value = objQuestions.value + "," + objchkDelete[i].value;
                    }    
                }
            } 
            
            objfrm.action="WhizCheckList.aspx?ACTION=MODIFY&MODE=DELETEQUESTION&PKID=0|CS&QuestionnaireID_PK="+ QuestionnaireID; 
            objfrm.submit();   
        }      
         function window_onload()
	    {
	      
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','divMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 400;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 400;
		    }
		    if (intDivHeight < 460)
			    intDivHeight = 460;
		    objdivlistPage.style.height = intDivHeight;}
	    } 
	     function window_onresize()
	    {
	      
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','divMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 400;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 400;
		    }
		    if (intDivHeight < 460)
			    intDivHeight = 460;
		    objdivlistPage.style.height = intDivHeight;}
	    } 
	      
    </script>    
</head>
<body onload='window_onload()' onresize='window_onresize()'>
    <form id="frmWhizChecklist" runat="server">
    <div id="divMain" style="width:100%;overflow:auto;">
        <table border="0" cellpadding="0" cellspacing="0" toplevel="" width="95%">
            <tr>
                <td style="height: 47px">
                    <table id="TABLE1" border="0" cellpadding="0" cellspacing="0" width="99.9%">
                        <tr class="ms-WPHeader">
                            <td id="WebPartTitleWPQ1" accesskey="W" style="width: 50%; height: 34px" tabindex="0"
                                title="List of processes.">
                                <div class="ms-WPTitle">
                                    <nobr><SPAN>Checklist</SPAN></nobr>
                                </div>
                            </td>
                            <td align="right" class="ms-sectionheader" style="width: 452px; padding-top: 4px;
                                height: 34px" valign="top">
                                <span id="objAddMode" style="cursor: hand" onclick="javascript:OpenHelpPage('2160')">|?|&nbsp;</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    <!--</div>-->
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-stdtxt" style="width: 900px; height: 15px">
                    <span class="AlertText">*</span><label>
                        indicates a required field</label>
                </td>
            </tr>
            <tr>
                <td align="right" class="ms-descriptiontext" height="10" style="width: 900px">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="AllValidators" />
                    <asp:Button ID="btnTopSave" runat="server" CssClass="ButtonHeightWidth2" Height="25px"
                        OnClick="btnTopSave_Click" Text="Save" ValidationGroup="AllValidators" Width="60px" />&nbsp;
                    <asp:Button ID="btnTopCancel" runat="server" CssClass="ButtonHeightWidth2" Height="25px"
                        OnClick="btnTopCancel_Click" Text="Cancel" Width="60px" /></td>
            </tr>
        </table>
        <table border="0" cellpadding="2" cellspacing="0" width="95%">
            <tr>
                <td class="ms-sectionline" colspan="2" style="height: 1px">
                </td>
            </tr>
            <tr>
                <td class="ms-sectionheader" style="width: 30%; padding-top: 4px; height: 200px;" valign="top">
                    <a onclick="javascript:ShowHideSection('IMGTemplateSection','objControls1')" style="cursor: hand">
                        <img id="IMGTemplateSection" alt="Hide/Show" border="0" src="../../Images/minus.gif" style="border-top-width: 0px;
                            border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" />
                        <asp:Label ID="LblChecklistSection" runat="server" Text="New Checklist" Width="101px"></asp:Label></a>
                </td>
                <td style="width: 70%; height: 200px;">
                    <div id="objControls1" style="display: inline">
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        <span style="color: #083772"></span><span style="color: #ff0000">* </span>Checklist:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 36px; text-align: justify">
                                    &nbsp;<asp:TextBox ID="txtQuestionnaireName" runat="server" MaxLength="400" Width="400px" CssClass="ms-input"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtQuestionnaireName"
                                        Display="None" ErrorMessage="'Checklist' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>&nbsp;
                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtQuestionnaireName"
                                        Display="Dynamic" ErrorMessage="'Checklist' already exists." OnServerValidate="CustomValidator2_ServerValidate"
                                        ValidationGroup="AllValidators"></asp:CustomValidator>
                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="ValidateSpecialCharacters"
                                        ControlToValidate="txtQuestionnaireName" Display="None" ErrorMessage="A 'Checklist' cannot contain any of these /\:*?<>|,&quot;+- characters."
                                        ValidationGroup="AllValidators">A 'Checklist' cannot contain any of these /\:*?<>|,"+- characters.</asp:CustomValidator></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td style="text-align: justify">
                                    <label accesskey="?" for="idResType">
                                        <span style="color: #ff0000">*
                                            <label>
                                            </label>
                                        </span>Description:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 90px; text-align: justify">
                                    &nbsp;<asp:TextBox ID="txtDescription" runat="server" CausesValidation="True" Height="80px"
                                        MaxLength="400" TextMode="MultiLine" Width="400px" CssClass="ms-input"></asp:TextBox>
                                    <span class="AlertText">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescription"
                                            Display="None" ErrorMessage="'Description' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtDescription" Display="None" ErrorMessage="Max Length of 'Description' is 400 characters."
                                            ToolTip="400" ValidationGroup="AllValidators"></asp:CustomValidator>&nbsp;
                                    </span>
                                </td>
                            </tr>
                        </table>
                   
                    <table border="0" class="ms-authoringcontrols" width="99%">
                        <tr>
                            <td style="width: 708px">
                                <label accesskey="?" for="idResType">
                                    <span style="color: #ff0000">*</span>Group:</label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 708px; text-align: justify">
                                &nbsp;<asp:DropDownList ID="cboGroupID" runat="server" AppendDataBoundItems="True"
                                    Style="z-index: -1" ValidationGroup="AllValidator" Width="300px">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;&nbsp;&nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="cboGroupID"
                                    Display="None" ErrorMessage="'Group' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator></td>
                        </tr>
                    </table>
                    <table border="0" class="ms-authoringcontrols" width="99%">
                        <tr>
                            <td style="width: 708px">
                                &nbsp;
                                <asp:label ID="lblReviNoCaption" accesskey="?" for="idResType" runat="server" >
                                    Revision No:</asp:label></td>
                        </tr>
                        <tr>
                            <td style="width: 708px; text-align: justify">
                                &nbsp;
                                <asp:Label ID="lblRevisionNo" runat="server" Text="0"></asp:Label></td>
                        </tr>
                    </table>
                     </div>
                    </td>
            </tr>
            <tr>
                <td class="ms-sectionline" colspan="2">
                </td>
            </tr>

        </table>
        <%ShowChecklistSections()%>
        
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-descriptiontext" style="width: 95%; height: 10px">
                    <asp:Button ID="btnBottomModify" runat="server" Height="25px" OnClick="btnTopSave_Click"
                        Text="Save" ValidationGroup="AllValidators" Width="60px" />
                    &nbsp;
                    <asp:Button ID="btnBottomCancel" runat="server" Height="25px" OnClick="btnTopCancel_Click"
                        Text="Cancel" Width="60px" /></td>
            </tr>
        </table>
        </div>
        <asp:TextBox ID="TxtQuestionnaireID" runat="server" Style="display: none">0</asp:TextBox>
        <asp:TextBox ID="txtQuestions" runat="server" Style="display: none"></asp:TextBox>
    </form>
</body>
</html>

