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
<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="WhizTemplate.aspx.vb" Inherits="PbNIT.WhizTemplates"  ValidateRequest="false"  %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Template</title>
        <link rel="stylesheet" type="text/css" href="../General/core.css" /><link rel="stylesheet" type="text/css" href="1033/styles/PWAStyle.css" />
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
        
        function showCalander(calander)
        {
            
            var objspan = document.getElementById(calander);
            var objReferenceDate = document.getElementById("RevisionDate");
            var RevisionDateLeft = objReferenceDate.offsetLeft;
            
            var RevisionDatetop = objReferenceDate.offsetTop;
                        
            var spandisplay = objspan.style.display;
            if(spandisplay=="none")
            {
                objspan.style.display="inline";
                //objspan.style.position="absolute";
                objspan.style.top = RevisionDatetop+ 20;
                objspan.style.left=RevisionDateLeft;
                objspan.style.height=150;
                objspan.style.width=150;
            } 
            else
            {
                objspan.style.display="none";
                objspan.style.height=0;
                objspan.style.width=0;
            }    
        }

        function ValidateSpecialCharacters(source, arguments)
        {
           if( disallowSpecialCharacters(GetObjectReference('frmWhizTemplate',source.controltovalidate),source.title)==true) 
             arguments.IsValid=false;
        
        }  
        function UploadDocument()
        {   objtxtTemplateID = document.getElementById("txtTemplateID");
            window.open("WhizDocumentManagement.aspx?", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 650)/2) + ",top=" + ((window.screen.height - 200)/2) + ",width=650,height=200");
        }      
    </script>
</head>

<body  onload='window_onload()' onresize='window_onresize()'>
    <form id="frmWhizTemplate" runat="server">
    <div id="DivMain" style="width:100%;overflow:auto;">
        <table border="0" cellpadding="0" cellspacing="0" toplevel="" width="95%">
            <tr>
                <td style="height: 47px">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%" id="TABLE1" >
                        <tr class="ms-WPHeader">
                            <td id="WebPartTitleWPQ1" accesskey="W" style="width: 50%; height: 34px;" tabindex="0" title="List of processes.">
                                <div class="ms-WPTitle">
                                    <nobr><span>Template</span> <span 
            id="WebPartCaptionWPQ1"></span></nobr>
                                </div>
                            </td>
                            <td align="right" class="ms-sectionheader" style="padding-top: 4px; height: 34px;" valign="top">
                                <span id="objAddMode" style="cursor: hand" onclick="javascript:OpenHelpPage('1041')">|?|&nbsp;</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-stdtxt" style="height: 15px">
                    <span class="AlertText">*</span><label>
                        indicates a required field</label>
                </td>
            </tr>
            <tr>
                <td align="right" class="ms-descriptiontext" height="10">
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
                <td class="ms-sectionheader" style="width: 15%; padding-top: 4px; height: 231px;" valign="top">
                    <a onclick="javascript:ShowHideSection('IMGTemplateSection','objControls1')" style="cursor: hand">
                        <img id="IMGTemplateSection" alt="Hide/Show" border="0" src="../../Images/minus.gif" style="border-top-width: 0px;border-left-width: 0px; border-bottom-width: 0px; border-right-width: 0px" />&nbsp;&nbsp;
                        <asp:Label ID="LblTemplateSection" runat="server" Text="New Template" Width="160px"></asp:Label></a><asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#3366CC"
                                BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana"
                                style="position:absolute; left: 37px; top: 195px;"
                                Font-Size="8pt" ForeColor="#003399" Height="0px" Width="0px" OnSelectionChanged="Calendar1_SelectionChanged" OnVisibleMonthChanged="Calendar1_VisibleMonthChanged">
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                    Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>                    </td>
                <td style="width:85%; height: 231px;">
                    <div id="objControls1" style="display: inline">
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        <span style="color: #ff0000">*</span>Title:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: justify; height: 37px;">
                                    &nbsp;
                                    <asp:TextBox ID="txtTitle" runat="server" MaxLength="50" Width="399px" CssClass="ms-input"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txttitle"
                                        Display="None" ErrorMessage="'Title' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="txtTitle"
                                        Display="Dynamic" ErrorMessage="'Title' already exists." OnServerValidate="CustomValidator3_ServerValidate"
                                        ValidationGroup="AllValidators"></asp:CustomValidator>
                                    <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="ValidateSpecialCharacters"
                                        ControlToValidate="txtTitle" Display="None" ErrorMessage="A 'Title' cannot contain any of these /\:*?<>|,&quot;+- characters."
                                        ValidationGroup="AllValidators">A 'Title' cannot contain any of these /\:*?<>|,"+- characters.</asp:CustomValidator></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        <span style="color: #ff0000">*
                                            <label>
                                            </label>
                                        </span>Description:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: justify">
                                    &nbsp;
                                    <asp:TextBox ID="txtDescription" runat="server" CausesValidation="True" Height="80px"
                                        MaxLength="5000" TextMode="MultiLine" Width="400px" CssClass="ms-input"></asp:TextBox>
                                    <span class="AlertText">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescription"
                                            Display="None" ErrorMessage="'Description' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtDescription" Display="None" ErrorMessage="Max Length of 'Description' is 8000 characters."
                                            SetFocusOnError="True" ToolTip="8000" ValidationGroup="AllValidators"></asp:CustomValidator></span></td>
                            </tr>
                        </table>
                    <table border="0" class="ms-authoringcontrols" width="99%">
                        <tr>
                            <td>
                                <label accesskey="?" for="idResType">
                                    <span style="color: #ff0000"></span></label>
                                &nbsp;
                                <asp:Label ID="LblRevisionDate" runat="server" Text="Revision Date:"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="text-align: justify">
                                &nbsp;&nbsp;
                                <asp:TextBox ID="RevisionDate" runat="server" Width="80px" style="position:relative; left: -7px; top: 2px;" ></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:Image runat="server"  id="imgCalander" alt="Calander" style="position:relative; left: -13px; top: 4px; height: 15px;"  src="../../Images/CALENDAR.GIF" onclick="showCalander('Calendar1')" />
                                <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="RevisionDate" style="position:relative; left: -11px; top: 2px;"
                                    Display="Dynamic" ErrorMessage="Invalid date format." OnServerValidate="CustomValidator2_ServerValidate"
                                    SetFocusOnError="True" ToolTip="8000" ValidationGroup="AllValidators" Width="121px">Invalid date format.</asp:CustomValidator><br />
                            </td>                                    
                            </tr>
                            
                    </table>
                    </div>
                    <span id="spanCalendar1" style="z-index:99">
                    </span>
                </td>
            </tr>
            <tr>
                <td class="ms-sectionline" colspan="2">
                </td>
            </tr>
        </table>
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-descriptiontext" style="width: 924px; height: 10px">
                    &nbsp;<asp:Button ID="btnBottomModify" runat="server" Height="25px" OnClick="btnTopSave_Click"
                        Text="Save" ValidationGroup="AllValidators" Width="60px" />
                    &nbsp;
                    <asp:Button ID="btnBottomCancel" runat="server" Height="25px" OnClick="btnTopCancel_Click"
                        Text="Cancel" Width="60px" /></td>
            </tr>
        </table>
        <table style="width: 95%">
            <tr>                        
                <td>
                    <%'DrawDocumentGrid() %>
                </td>
            </tr>
        </table>    
    </div>
        <asp:TextBox ID="txtTemplateID" style="display:none" runat="server">0</asp:TextBox>
        <asp:TextBox runat="server"   id="txtDocUploadedFilesID"  style="display:none" ></asp:TextBox>
    </form>
</body>
<script type="text/javascript" > 
function showcal()
{

var objspan = document.getElementById('Calendar1');
if(objspan.style.display=="inline")
{
    objspan.style.display="none";
    showCalander('Calendar1');
}
}
showcal();    
 function window_onload()
	    {
	      
        return;
        
	        var objdivlistPage = GetObjectReference('frmProcessDetails','DivMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 65;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 65;
		    }
		    if (intDivHeight < 100)
			    intDivHeight = 100;
		    objdivlistPage.style.height = intDivHeight;}
		    
	    } 
	     function window_onresize()
	    {
	     
	     return;
	        var objdivlistPage = GetObjectReference('frmProcessDetails','DivMain');
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
		    if (intDivHeight < 100)
			    intDivHeight = 100;
		    objdivlistPage.style.height = intDivHeight;}
	    } 
	    
</script>
</html>

