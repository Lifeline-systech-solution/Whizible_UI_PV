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
<%@ Page Language="vb" AutoEventWireup="true"  CodeBehind="WhizProcesses.aspx.vb" Inherits="PbNIT.WhizProcesses" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
    <title>Process</title>
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
           
           if( disallowMaxlengthViolation(GetObjectReference('frmWhizProcesses',source.controltovalidate),source.title)==true) 
             arguments.IsValid=false;
        }
        
        function validateDuplicateOrderNumber(source,args)
        { 
        
            var objtxtExistingOrderNumbers=GetObjectReference("frmWhizProcesses","txtExistingOrderNumbers")
          if(objtxtExistingOrderNumbers.value.indexOf(","+args.Value+",",0)!=-1) 
                args.IsValid=false;  
        }
       
        function window_onload()
	    {
	      
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','Div1');
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
	      
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','Div1');
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
<body id="txt" onload='window_onload()' onresize='window_onresize()'>
    <form id="frmWhizProcesses" runat="server" action="WhizProcesses.aspx" method="post" >
    <div id="Div1" runat="server" enableviewstate="true" style="width:100%;overflow:auto;">
        <table TOPLEVEL border='0' cellpadding='0' cellspacing='0' width='95%'>
        <tr>
        <td style="height: 47px; width: 905px;">
        <table border='0' cellpadding='0' cellspacing='0' width='100%'>
            <tr class='ms-WPHeader'>
                <td accesskey='W' tabindex='0' title='List of processes.' id='WebPartTitleWPQ1' style='width:50%'>
                <div  class='ms-WPTitle'>
                    <nobr>
                    <span>Process</span>
                    <span id='WebPartCaptionWPQ1'></span>
                    </nobr>
                </div>
                </td>
                <td  class='ms-sectionheader' style='PADDING-TOP: 4px' vAlign=top height=22 align='right'>
                    <span id='objAddMode' style='cursor:hand'>&nbsp;</span></td>
            </tr>
        </table>
        </td>
        </tr>
        </table>

        <table style="width:95%">
		
        <tr>
          <td class="ms-stdtxt" align="right" style="height: 15px; width: 900px;">
             <span class="AlertText">*</span><label>&nbsp;indicates a required field</label>
           </td>
       </tr>
		
        <tr>
			<td height="10" class="ms-descriptiontext" align="right" style="width: 900px">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                    ShowSummary="False" ValidationGroup="AllValidators" />
                <asp:Button ID="btnTopSave" runat="server" Height="25px" Text="Save" Width="60px" OnClick="btnTopSave_Click" CssClass="ButtonHeightWidth2" ValidationGroup="AllValidators" AccessKey="S" />&nbsp;
                <asp:Button ID="btnTopCancel" runat="server" Height="25px" Text="Cancel" Width="60px" OnClick="btnTopCancel_Click" CssClass="ButtonHeightWidth2" AccessKey="N" /></td>
		</tr>
       </table>
        
        <table border='0' cellpadding='2' cellspacing='0' width='95%'>
            <tr>
                <td class='ms-sectionline' colspan='2' style="height: 1px" >
                </td>
            </tr>
        
        
            <tr>
                <td class='ms-sectionheader' style="PADDING-TOP: 4px; width: 20%;" vAlign=top height=22>
                    <a style='cursor:hand' onclick="javascript:ShowHideSection('IMG1','objControls1')">
                    <img style='BORDER-TOP-WIDTH: 0px; BORDER-LEFT-WIDTH: 0px; BORDER-BOTTOM-WIDTH: 0px; BORDER-RIGHT-WIDTH: 0px' alt='Hide/Show' src='../../Images/minus.gif' border='0' id="IMG1"/>&nbsp;&nbsp;
                    <asp:Label ID="LblProcessSection" runat="server" Text="New Process" Width="160px"></asp:Label></a></td> 
                <td style="width: 77%">
                                <div id='objControls1' style='display:inline'>
                                  <table  class='ms-authoringcontrols' width='99%' border=0 id="TABLE1">
            <tr>
                <td style="height: 14px; width: 699px;">
                    &nbsp;<asp:Label ID="LblRevisionNumber" runat="server" Text="Revision Number" Width="99px"></asp:Label></td>
            </tr>
            <tr>
            <td style="text-align:justify; width: 699px;">
            &nbsp;<asp:TextBox ID="txtRevisionNumber" runat="server" Width="64px" Enabled="False" style="text-align:right" CssClass="clsTextBox"></asp:TextBox>
            </td>
            </tr>
            </table>
                                  <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td style="height: 15px">
                            <label for="idResType" accesskey="?">
                                <span style="color: #ff0000">*</span>Order &nbsp;Number:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtOrderNumber" runat="server" Width="64px" CausesValidation="True" MaxLength="8" style="text-align:right"></asp:TextBox>
                            &nbsp;
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOrderNumber"
                                Display="None" ErrorMessage="'Order Number' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                            &nbsp;&nbsp;
                            <asp:CustomValidator ID="CustomValidator5" runat="server"
                                ControlToValidate="txtOrderNumber" Display="None" ErrorMessage="'Order Number' already exists."
                                OnServerValidate="DuplicateOrdernumberValidation" ValidationGroup="AllValidators" SetFocusOnError="True" ClientValidationFunction="validateDuplicateOrderNumber"></asp:CustomValidator>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtOrderNumber"
                                Display="None" ErrorMessage="'Order Number' should be postive numeric only."
                                MaximumValue="99999999" MinimumValue="1" Type="Integer" ValidationGroup="AllValidators"></asp:RangeValidator>
                            </td>
                    </tr>
                </table>
                                  <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                <span style="color: #ff0000">*</span>Process Name:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtProcessName" runat="server" Width="408px" MaxLength="50" CssClass="ms-input"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                                ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtProcessName"
                                Display="None" ErrorMessage="'Process Name' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtProcessName"
                                Display="None" ErrorMessage="'Process Name' already exists." OnServerValidate="ProcessName_ServerValidate"
                                ValidationGroup="AllValidators"></asp:CustomValidator></td>
                    </tr>
                </table>
                                  <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                &nbsp;SEI CMM KPA:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:justify; height: 23px;">
                            &nbsp;<asp:TextBox ID="txtSEICMMKPA" runat="server" Width="296px" MaxLength="20" CssClass="ms-input"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                                  <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                &nbsp;ISO 9001 Clause Number:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtISO9001ClassNo" runat="server" Width="296px" MaxLength="20" CssClass="ms-input"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                <span style="color: #ff0000">*</span>Description:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtDescription" runat="server" Height="80px" TextMode="MultiLine" Width="416px" CausesValidation="True" MaxLength="8000" CssClass="ms-input"></asp:TextBox>&nbsp;<span class="AlertText"><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDescription"
                                Display="Dynamic" ErrorMessage="'Description' should not be left blank." ValidationGroup="AllValidators">*</asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="validateMaxLength"
                                    ControlToValidate="txtDescription" Display="None" ErrorMessage="Max Length of 'Description' is 8000 characters."
                                    ValidationGroup="AllValidators" SetFocusOnError="True" ToolTip="8000"></asp:CustomValidator></span></td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td style="height: 31px">
                            <label for="idResType" accesskey="?">
                                &nbsp;Entry Criteria:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtEntryCriteria" runat="server" Height="80px" TextMode="MultiLine" Width="416px" CausesValidation="True" MaxLength="2000" CssClass="ms-input"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="validateMaxLength"
                                ControlToValidate="txtEntryCriteria" Display="None" ErrorMessage="Max Length of Entry Criteria' is 2000 characters."
                                ValidationGroup="AllValidators" SetFocusOnError="True" ToolTip="2000"></asp:CustomValidator></td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                &nbsp;Exit Criteria:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style='text-align:justify'>
                            &nbsp;<asp:TextBox ID="txtExitCriteria" runat="server" Height="88px" TextMode="MultiLine" Width="416px" CausesValidation="True" MaxLength="2000" CssClass="ms-input"></asp:TextBox>
                            <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="validateMaxLength"
                                ControlToValidate="txtExitCriteria" Display="None" ErrorMessage="Max Length of 'Exit Criteria' is 2000 characters."
                                ValidationGroup="AllValidators" SetFocusOnError="True" ToolTip="2000"></asp:CustomValidator></td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td style="height: 15px">
                            <label for="idResType" accesskey="?">
                                &nbsp;Measurement Criteria:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:justify; height: 7px;">
                            &nbsp;<asp:TextBox ID="txtMeasurementCriteria" runat="server" Height="88px" TextMode="MultiLine" Width="416px" CausesValidation="True" MaxLength="2000" CssClass="ms-input"></asp:TextBox>&nbsp;
                            <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="validateMaxLength"
                                ControlToValidate="txtMeasurementCriteria" Display="None" ErrorMessage="Max Length of 'Measurement Criteria' is 2000 characters."
                                ValidationGroup="AllValidators" SetFocusOnError="True" ToolTip="2000"></asp:CustomValidator></td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                    <tr>
                        <td>
                            <label for="idResType" accesskey="?">
                                <span style="color: #ff0000">*</span>Department:</label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align:justify; height: 23px;">
                            &nbsp;<asp:DropDownList ID="cboDepartment" runat="server" Width="256px">
                            </asp:DropDownList>&nbsp;
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cboDepartment"
                                Display="None" ErrorMessage="'Department' should not be left blank." ValidationGroup="AllValidators"></asp:RequiredFieldValidator></td>
                    </tr>
                </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align:justify; height: 23px;">
                                    <asp:CheckBox ID="chkIsProcessActive" runat="server" Text="Is Process Active" /></td>
                            </tr>
                        </table>
                    <table  class='ms-authoringcontrols' width='99%' border=0>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:justify; height: 23px;">
                                <asp:CheckBox ID="chkIsSDLCProcess" runat="server" Text="Is SDLC Process" />
                            </td>
                        </tr>
                    </table>
                                    </div>
                </td>

            </tr>

            <tr>
                <td class='ms-sectionline' colspan='2'>
                </td>
            </tr>
        </table>
        
        <table style="width:95%">
            <tr>
            <td class="ms-descriptiontext" align="right" style="height: 10px; width: 951px;">
                <asp:Button ID="btnBottomModify" runat="server" Height="25px" Text="Save" Width="60px" OnClick = "btnTopSave_Click" ValidationGroup="AllValidators" AccessKey="s"/>
                &nbsp;
                <asp:Button ID="btnBottomCancel" runat="server" Height="25px" Text="Cancel" Width="60px" OnClick="btnTopCancel_Click" AccessKey="N" /></td>
        </tr>
        </table>        
    </div>
        <asp:TextBox ID="txtProcessID" runat="server" Visible="False">0</asp:TextBox>
        <asp:TextBox ID="txtExistingOrderNumbers" runat="server" style="display:none" ></asp:TextBox>
       
    </form>
</body>
</html>

