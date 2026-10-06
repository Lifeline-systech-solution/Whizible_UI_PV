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
<%@ Page Language="vb" AutoEventWireup="true" Codebehind="WhizActivityTailoringDaviation.aspx.vb" enableEventValidation="false"
    Inherits="PbNIT.WhizActivityTailoringDaviation" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Activity Tailoring / Daviation</title>
    <link rel="stylesheet" type="text/css" href="../General/core.css" />
    <link rel="stylesheet" type="text/css" href="../General/PWAStyle.css" />
    <link rel="stylesheet" type="text/css" href="../General/StyleSheetChanakya_WhizP2007.css" />

    <script type="text/javascript" language='javascript' src='../General/CommonFunctions.js'></script>

    <script type="text/javascript" language='javascript' src='../General/CommonValidations.js'></script>
    <script type="text/javascript" language="javascript">
        //--------------------------------------------------------------------------------------------------------
        function ShowCurrent(type)
        {
            
            var multipleItemsSelected=false;counter=0;counterSelectedItems=0;
            switch(type)
            {
                case "C":
                {
                    var AvailableChecklists = document.getElementById("lstAvailableChecklists");
                    if(AvailableChecklists!=null && AvailableChecklists.length>0)
                    {
                        for(counter=0;counter<AvailableChecklists.length;counter++)
                        {
                            if(AvailableChecklists.options[counter].selected==true)
                               {
                                counterSelectedItems+=1;
                               } 
                        }
                        if(counterSelectedItems>1)
                            multipleItemsSelected=true;
                         
                        if(multipleItemsSelected==false && counterSelectedItems>0)                           
                            document.getElementById("CurrentChecklist").innerHTML = AvailableChecklists.options(AvailableChecklists.selectedIndex).text;

                        if(multipleItemsSelected== true) 
                            document.getElementById("CurrentChecklist").innerHTML ="Multiple items selected";                           

                        if(counterSelectedItems==0)
                          document.getElementById("CurrentChecklist").innerHTML ="";                           
                    }
                    break;
                }
                case "T":
                {
                    var AvailableTemplates = document.getElementById("lstAvailableTemplates");
                    if(AvailableTemplates!=null && AvailableTemplates.length>0)
                    {
                        for(counter=0;counter<AvailableTemplates.length;counter++)
                        {
                            if(AvailableTemplates.options[counter].selected==true)
                               {
                                counterSelectedItems+=1;
                               } 
                        }
                        if(counterSelectedItems>1)
                            multipleItemsSelected=true;
                         
                        if(multipleItemsSelected==false && counterSelectedItems>0)                           
                            document.getElementById("CurrentTemplate").innerHTML = AvailableTemplates.options(AvailableTemplates.selectedIndex).text;
                            
                        if(multipleItemsSelected== true) 
                            document.getElementById("CurrentTemplate").innerHTML = "Multiple items selected";  
                            
                        if(counterSelectedItems==0)                            
                            document.getElementById("CurrentTemplate").innerHTML = "";  
                    }    
                    break;
                }
            }
        }
        //--------------------------------------------------------------------------------------------------------
        function ShowHideSection(strImg, strSectionId)
        {
               var objSection = document.getElementById(strSectionId);
               objImg = document.getElementById(strImg);
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
        //--------------------------------------------------------------------------------------------------------
        function removeItem(objList1,objList2)
        {
           
            var availableList = document.getElementById(objList1);
            var selectedList = document.getElementById(objList2);

            var counter=0;
            var addIndex;
            var availableCount=0;
            
            if(availableList==null || selectedList == null)
                return;
            
            availableCount = availableList.length;
            
            for(counter=availableCount-1;counter>=0;counter--)
            {
                if(availableList.options[counter].selected==true)
                {
                    addIndex=counter;
                    selectedList.appendChild(availableList.options.item(addIndex));
                 }   

            }
            
            if(availableList.options.length>0)
            {
                availableList.selectedIndex=0;
                switch(availableList.id)
                {
                    case "lstAvailableChecklists":
                    {
                        ShowCurrent("C");
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        ShowCurrent("T");
                        break;
                    }
                }
            }
            else
            {
                switch(availableList.id)
                {

                    case "lstAvailableChecklists":
                    {
                        document.getElementById("CurrentChecklist").innerHTML = "";
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        document.getElementById("CurrentTemplate").innerHTML = "";
                        break;
                    }
                }
            }
            
            if(availableList.options.length==0)
            {
                switch(availableList.id)
                {
                    case "lstAvailableChecklists":
                    {
                        document.getElementById("SelectChecklist").disabled = true;
                        document.getElementById("SelectAllChecklists").disabled = true;
                        document.getElementById("RemoveChecklist").disabled = false;
                        document.getElementById("RemoveAllChecklists").disabled = false;
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        document.getElementById("SelectTemplate").disabled = true;
                        document.getElementById("SelectAllTemplates").disabled = true;
                        document.getElementById("RemoveTemplate").disabled = false;
                        document.getElementById("RemoveAllTemplates").disabled = false;
                        break;
                    }
                }
            }
            else
            {
                switch(availableList.id)
                {
                    case "lstAvailableChecklists":
                    {
                        document.getElementById("SelectChecklist").disabled = false;
                        document.getElementById("SelectAllChecklists").disabled = false;
                        document.getElementById("RemoveChecklist").disabled = false;
                        document.getElementById("RemoveAllChecklists").disabled = false;
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        document.getElementById("SelectTemplate").disabled = false;
                        document.getElementById("SelectAllTemplates").disabled = false;
                        document.getElementById("RemoveTemplate").disabled = false;
                        document.getElementById("RemoveAllTemplates").disabled = false;
                        break;
                    }
                }
            
            }
        }   
        //--------------------------------------------------------------------------------------------------------
        function removeAll(objList1,objList2)
        {
            var availableList = document.getElementById(objList1);
            var selectedList = document.getElementById(objList2);
            
            var len = availableList.length-1;
            for(i=len; i>=0; i--)
            {
                selectedList.appendChild(availableList.item(i));
            }
            
            switch(availableList.id)
            {
                case ("lstAvailableChecklists"):
                {
                    document.getElementById("SelectChecklist").disabled = true;
                    document.getElementById("SelectAllChecklists").disabled = true;
                    document.getElementById("RemoveChecklist").disabled = false;
                    document.getElementById("RemoveAllChecklists").disabled = false;
                    break;
                }
                case ("lstAvailableTemplates"):
                {
                    document.getElementById("SelectTemplate").disabled = true;
                    document.getElementById("SelectAllTemplates").disabled = true;
                    document.getElementById("RemoveTemplate").disabled = false;
                    document.getElementById("RemoveAllTemplates").disabled = false;
                    break;
                }
            }
        }
        
        function restoreAll(objList1,objList2)
        {
            var availableList = document.getElementById(objList1);
            var selectedList = document.getElementById(objList2);

            var len = selectedList.length -1;

            for(i=len; i>=0; i--)
            {
                availableList.appendChild(selectedList.item(i));
            }
              
            switch(selectedList.id)
            {

                case ("lstSelectedChecklists"):
                {
                    document.getElementById("SelectChecklist").disabled = false;
                    document.getElementById("SelectAllChecklists").disabled = false;
                    document.getElementById("RemoveChecklist").disabled = true;
                    document.getElementById("RemoveAllChecklists").disabled = true;
                    break;
                }
                case ("lstSelectedTemplates"):
                {
                    document.getElementById("SelectTemplate").disabled = false;
                    document.getElementById("SelectAllTemplates").disabled = false;
                    document.getElementById("RemoveTemplate").disabled = true;
                    document.getElementById("RemoveAllTemplates").disabled = true;
                    break;
                }
            }
            availableList.focus();
            selectedList.focus()
            
        }
        //--------------------------------------------------------------------------------------------------------
        function restoreItem(objList1,objList2)
        {
            
            var availableList = document.getElementById(objList1);
            var selectedList = document.getElementById(objList2);
            var selIndex = selectedList.selectedIndex;
            if(selIndex < 0)
                return;
            var len = selectedList.length -1;

            for(i=len; i>=0; i--)
            {
                 if(selectedList.options[i].selected==true)
                {
                    availableList.appendChild(selectedList.options.item(i))
                }
            }    
            
            if(selectedList.options.length>0)
            {
                selectedList.selectedIndex=0;
            }
                
            if(availableList.options.length>0)
            {
                switch(availableList.id)
                {
                    case "lstAvailableChecklists":
                    {
                        ShowCurrent("C");
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        ShowCurrent("T");
                        break;
                    }
                }
            }
            else
            {
                switch(availableList.id)
                {
                    case "lstAvailableChecklists":
                    {
                        document.getElementById("CurrentChecklist").innerHTML = "";
                        break;
                    }
                    case "lstAvailableTemplates":
                    {
                        document.getElementById("CurrentTemplate").innerHTML = "";
                        break;
                    }
                }
            }
            
            
            if(selectedList.options.length==0)
            {
                switch(selectedList.id)
                {
                    case ("lstSelectedChecklists"):
                    {
                        document.getElementById("SelectChecklist").disabled = false;
                        document.getElementById("SelectAllChecklists").disabled = false;
                        document.getElementById("RemoveChecklist").disabled = true;
                        document.getElementById("RemoveAllChecklists").disabled = true;
                        break;
                    }
                    case ("lstSelectedTemplates"):
                    {
                        document.getElementById("SelectTemplate").disabled = false;
                        document.getElementById("SelectAllTemplates").disabled = false;
                        document.getElementById("RemoveTemplate").disabled = true;
                        document.getElementById("RemoveAllTemplates").disabled = true;
                        break;
                    }
                }
            }
            else
            {
                switch(selectedList.id)
                {
                    case ("lstSelectedChecklists"):
                    {
                        document.getElementById("SelectChecklist").disabled = false;
                        document.getElementById("SelectAllChecklists").disabled = false;
                        document.getElementById("RemoveChecklist").disabled = false;
                        document.getElementById("RemoveAllChecklists").disabled = false;
                        break;
                    }
                    case ("lstSelectedTemplates"):
                    {
                        document.getElementById("SelectTemplate").disabled = false;
                        document.getElementById("SelectAllTemplates").disabled = false;
                        document.getElementById("RemoveTemplate").disabled = false;
                        document.getElementById("RemoveAllTemplates").disabled = false;
                        break;
                    }
                }
            
            }
        }
        
        function window_OnLoad()
        {

            if(document.getElementById("lstAvailableChecklists").options.length==0)
            {
                document.getElementById("SelectChecklist").disabled = true;
                document.getElementById("SelectAllChecklists").disabled = true;
            }
            if(document.getElementById("lstAvailableTemplates").options.length==0)
            {
                document.getElementById("SelectTemplate").disabled = true;
                document.getElementById("SelectAllTemplates").disabled = true;
            }
            if(document.getElementById("lstSelectedChecklists").options.length==0)
            {
                document.getElementById("RemoveChecklist").disabled = true;
                document.getElementById("RemoveAllChecklists").disabled = true;
            }
            if(document.getElementById("lstSelectedTemplates").options.length==0)
            {
                document.getElementById("RemoveTemplate").disabled = true;
                document.getElementById("RemoveAllTemplates").disabled = true;
            }
            
        }
        
        function ValidateDuplicateOrderNumber(source,args)
        {
           
            var objtxtExistingOrderNumbers=GetObjectReference("frmWhizProcessesActivity","txtExistingOrderNumbers")
            if(objtxtExistingOrderNumbers.value.indexOf(","+args.Value+",",0)!=-1) 
                args.IsValid=false;  
        }
        
        function validateMaxLength(source,args)
        {
           if( disallowMaxlengthViolation(GetObjectReference('frmWhizProcessesActivity',source.controltovalidate),source.title)==true) 
                args.IsValid=false;
        }
        
        function ValidateGCT()
        {
            var objlstSelectedChecklists = document.getElementById('lstSelectedChecklists'); 
            var objlstAvailableChecklists = document.getElementById('lstAvailableChecklists'); 
            var objlstSelectedTemplates = document.getElementById('lstSelectedTemplates'); 
            var objlstAvailableTemplates = document.getElementById('lstAvailableTemplates'); 
                        
                        
            var counter=0;
                

             
             for(counter=0;counter<objlstSelectedChecklists.length;counter++)    
             {
                objlstSelectedChecklists.options[counter].selected=true;
             }                          
             
             for(counter=0;counter<objlstAvailableChecklists.length;counter++)    
             {
                objlstAvailableChecklists.options[counter].selected=true;
             }                            
             
             for(counter=0;counter<objlstSelectedTemplates.length;counter++)    
             {
                objlstSelectedTemplates.options[counter].selected=true;
             }                 
             
             for(counter=0;counter<objlstAvailableTemplates.length;counter++)    
             {
                objlstAvailableTemplates.options[counter].selected=true;
             }                 
                                     
        }
    </script>

</head>
<body>
    <form id="frmWhizActivityTailoring" runat="server">
        <div>
            <table border="0" cellpadding="0" cellspacing="0" toplevel="" width="95%">
                <tr>
                    <td style="width: 905px; height: 47px">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr class="ms-WPHeader">
                                <td id="WebPartTitleWPQ1" accesskey="W" style="width: 50%" tabindex="0" title="Add Modify Activity">
                                    <div class="ms-WPTitle">
                                        <nobr><SPAN>Activtiy Tailoring and 
            Deviation</SPAN></nobr>
                                    </div>
                                </td>
                                <td align="right" class="ms-sectionheader" height="22" style="padding-top: 4px" valign="top">
                                    <span id="objAddMode" onclick="javascript:OpenHelpPage('2022')" style="cursor: hand">
                                        |?|&nbsp;</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-stdtxt" style="width: 900px">
                    <span class="AlertText">*</span><label>
                        indicates a required field</label>
                </td>
            </tr>
            <tr>
                <td align="right" class="ms-descriptiontext" height="10" style="width: 900px">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                        ShowSummary="False" ValidationGroup="AllValidator" />
                    <asp:Button ID="btnTopSave" runat="server" AccessKey="s" Height="25px" OnClick="btnTopSave_Click"
                        OnClientClick="ValidateGCT" Text="Save" ValidationGroup="AllValidator" Width="70px" />&nbsp;
                    <asp:Button ID="btnTopCancel" runat="server" Height="25px" OnClick="btnBottomCancel_Click"
                        Text="Cancel" Width="70px" /></td>
            </tr>
        </table>
        <table border="0" cellpadding="2" cellspacing="0" style="font-size: 8pt" width="95%">
            <tr>
                <td class="ms-sectionline" colspan="2" style="height: 1px">
                </td>
            </tr>
            <tr>
                <td class="ms-sectionheader" style="width: 20%; padding-top: 4px;"
                    valign="top">
                    <a href="javascript:ShowHideSection('imgActivitySection','objControls1')" style="cursor: hand">
                        <img id="imgActivitySection" alt="Hide/Show" border="0" src="../../Images/minus.gif"
                            style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                            border-right-width: 0px" /><strong><span style="color: #083772; font-family: Tahoma">
                                &nbsp; </span></strong>
                        <asp:Label ID="lblActivitySection" runat="server" Text="Activtiy Tailoring and Deviation" Font-Bold="True"></asp:Label>
                    </a>
                </td>
                <td style="width: 80%;">
                    <div id="objControls1" style="display: inline">
                        <table border="0" class="ms-authoringcontrols" style="color: #083772" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        &nbsp;Activity &nbsp;Name:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: justify">
                                    &nbsp;<asp:Label ID="lblActivityName" runat="server"></asp:Label><span
                                            class="AlertText"></span></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" style="color: #083772" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        <span style="color: #083772">&nbsp;References</span>:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 23px; text-align: justify">
                                    &nbsp;<asp:TextBox ID="txtReference" runat="server" Height="80px" TextMode="MultiLine"
                                        Width="400px" CssClass="ms-input"></asp:TextBox>&nbsp;
                                    <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="validateMaxLength"
                                        ControlToValidate="txtReference" Display="None" ErrorMessage="Max Length of 'References' is 1000 characters."
                                        ToolTip="1000" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        &nbsp;Tailoring Description:</label><strong><span style="color: #000000">
                                        </span></strong>
                                </td>
                            </tr>
                            <tr style="font-weight: bold; color: #000000">
                                <td style="text-align: justify">
                                    &nbsp;<asp:TextBox ID="txtTailoring" runat="server" Height="80px" TextMode="MultiLine"
                                        Width="400px" CssClass="ms-input"></asp:TextBox>&nbsp;
                                    <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="validateMaxLength"
                                        ControlToValidate="txtTailoring" Display="None" ErrorMessage="Max Length of 'Tailoring Description' is 1000 characters."
                                        ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator><span class="AlertText"></span></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" style="color: #083772" width="99%">
                            <tr>
                                <td>
                                    <label accesskey="?" for="idResType">
                                        &nbsp;Deviation Description:</label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: justify">
                                    &nbsp;<asp:TextBox ID="txtDeviation" runat="server" Height="80px" TextMode="MultiLine"
                                        Width="400px" CssClass="ms-input"></asp:TextBox>
                                    <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="validateMaxLength"
                                        ControlToValidate="txtDeviation" Display="None" ErrorMessage="Max Length of 'Deviation Description' is 1000 characters."
                                        ToolTip="1000" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                            </tr>
                        </table>
                       <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td style="height: 15px">
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 23px; text-align: justify">
                                    <asp:CheckBox ID="ISPerformed" runat="server" Text="Has this been performed?" /></td>
                            </tr>
                        </table>
                        <table border="0" class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 23px; text-align: justify">
                                    <asp:CheckBox ID="ISRequired" runat="server" Checked="True" Text="Required (Yes/No)" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="ms-sectionline" colspan="2">
                </td>
            </tr>
            <tr>
                <td class="ms-sectionheader" style="width: 20%; padding-top: 4px" valign="top">
                    <a onclick="javascript:ShowHideSection('imgChecklistSection','objControls3')" style="cursor: hand">
                        <img id="imgChecklistSection" alt="Hide/Show" border="0" src="../../Images/minus.gif"
                            style="border-top-width: 0px; font-weight: bold; border-left-width: 0px; border-bottom-width: 0px;
                            border-right-width: 0px" />
                        Associate Checklists</a></td>
                <td style="width: 80%">
                    <div id="objControls3" style="display: inline">
                        <table class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="1" cellspacing="1" class="ms-authoringcontrols">
                                        <tr>
                                            <th style="vertical-align: bottom; height: 17px">
                                                <label id="Label1" accesskey="U" for="users_Alpha">
                                                    Available Checklists:</label>
                                            </th>
                                            <th style="width: 79px; height: 17px">
                                                &nbsp;</th>
                                            <th style="vertical-align: bottom; height: 17px">
                                                <label id="Label2" accesskey="R" for="users_Beta">
                                                    Selected Checklists:</label></th>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <asp:ListBox ID="lstAvailableChecklists" runat="server" Height="115px" onchange="javascript:ShowCurrent('C','lstAvailableChecklists')"
                                                    ondblclick="removeItem('lstAvailableChecklists','lstSelectedChecklists')" SelectionMode="Multiple"
                                                    Width="225px"></asp:ListBox>
                                            </td>
                                            <td id="Td3" style="width: 79px">
                                                <table cellpadding="1" cellspacing="1" class="ms-stdtxt">
                                                    <tbody>
                                                        <tr id="Tr1">
                                                            <td style="width: 104px">
                                                                <button id="SelectChecklist" accesskey="" class="pwa-ButtonHeight" enabled="" onclick="removeItem('lstAvailableChecklists','lstSelectedChecklists')"
                                                                    style="width: 80px" title="" type="button">
                                                                    Add &gt;</button></td>
                                                        </tr>
                                                        <tr id="Tr2">
                                                            <td style="width: 104px">
                                                                <button id="SelectAllChecklists" accesskey="" class="pwa-ButtonHeight" enabled=""
                                                                    onclick="removeAll('lstAvailableChecklists','lstSelectedChecklists')" style="width: 80px"
                                                                    title="" type="button">
                                                                    Add All &gt;&gt;</button></td>
                                                        </tr>
                                                        <tr id="Tr3">
                                                            <td style="width: 104px">
                                                                <button id="RemoveAllChecklists" accesskey="" class="pwa-ButtonHeight" enabled=""
                                                                    onclick="restoreAll('lstAvailableChecklists','lstSelectedChecklists')" style="width: 80px"
                                                                    title="" type="button">
                                                                    &lt;&lt; Remove All</button></td>
                                                        </tr>
                                                        <tr id="Tr4">
                                                            <td style="width: 104px">
                                                                <button id="RemoveChecklist" accesskey="" class="pwa-ButtonHeight" enabled="" onclick="restoreItem('lstAvailableChecklists','lstSelectedChecklists')"
                                                                    style="width: 80px" title="" type="button">
                                                                    &lt; Remove</button></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td id="Td4" style="width: 231px; height: 108px" valign="top">
                                                <asp:ListBox ID="lstSelectedChecklists" runat="server" Height="115px" ondblclick="restoreItem('lstAvailableChecklists','lstSelectedChecklists')"
                                                    SelectionMode="Multiple" Width="225px"></asp:ListBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <strong><span style="color: black">Current Item:</span></strong>
                                    <asp:Label ID="CurrentChecklist" runat="server" ForeColor="Black"></asp:Label></td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="ms-sectionline" colspan="2">
                </td>
            </tr>
            <tr>
                <td class="ms-sectionheader" style="width: 20%; padding-top: 4px" valign="top">
                    <a onclick="javascript:ShowHideSection('imgTemplateSection','objControls4')" style="cursor: hand">
                        <img id="imgTemplateSection" alt="Hide/Show" border="0" src="../../Images/minus.gif"
                            style="border-top-width: 0px; font-weight: bold; border-left-width: 0px; border-bottom-width: 0px;
                            border-right-width: 0px" />
                        Associate Templates</a>&nbsp;</td>
                <td style="width: 80%">
                    <div id="objControls4" style="display: inline">
                        <table class="ms-authoringcontrols" width="99%">
                            <tr>
                                <td>
                                    <table border="0" cellpadding="1" cellspacing="1" class="ms-authoringcontrols">
                                        <tr>
                                            <th style="vertical-align: bottom; height: 15px">
                                                <label id="Label3" accesskey="U" for="users_Alpha">
                                                    Available Templates:</label>
                                            </th>
                                            <th style="width: 80px; height: 15px">
                                                &nbsp;</th>
                                            <th style="vertical-align: bottom; height: 15px">
                                                <label id="Label4" accesskey="R" for="users_Beta">
                                                    Selected Templates:</label>
                                            </th>
                                        </tr>
                                        <tr>
                                            <td id="Td7" valign="top">
                                                <asp:ListBox ID="lstAvailableTemplates" runat="server" Height="115px" onchange="javascript:ShowCurrent('T','lstAvailableTemplates')"
                                                    ondblclick="removeItem('lstAvailableTemplates','lstSelectedTemplates')" SelectionMode="Multiple"
                                                    Width="225px"></asp:ListBox>
                                            </td>
                                            <td id="Td8" style="width: 80px">
                                                <table cellpadding="1" cellspacing="1" class="ms-stdtxt">
                                                    <tbody>
                                                        <tr id="Tr5" valign="top">
                                                            <td style="width: 104px">
                                                                <button id="SelectTemplate" accesskey="" class="pwa-ButtonHeight" enabled="" onclick="removeItem('lstAvailableTemplates','lstSelectedTemplates')"
                                                                    style="width: 80px" title="" type="button">
                                                                    Add &gt;</button></td>
                                                        </tr>
                                                        <tr id="Tr6" valign="top">
                                                            <td style="width: 104px">
                                                                <button id="SelectAllTemplates" accesskey="" class="pwa-ButtonHeight" enabled=""
                                                                    onclick="removeAll('lstAvailableTemplates','lstSelectedTemplates')" style="width: 80px"
                                                                    title="" type="button">
                                                                    Add All &gt;&gt;</button></td>
                                                        </tr>
                                                        <tr id="Tr7" valign="top">
                                                            <td style="width: 104px">
                                                                <button id="RemoveAllTemplates" accesskey="" class="pwa-ButtonHeight" enabled=""
                                                                    onclick="restoreAll('lstAvailableTemplates','lstSelectedTemplates')" style="width: 80px"
                                                                    title="" type="button">
                                                                    &lt;&lt; Remove All</button></td>
                                                        </tr>
                                                        <tr id="Tr8" valign="top">
                                                            <td style="width: 104px">
                                                                <button id="RemoveTemplate" accesskey="" class="pwa-ButtonHeight" enabled="" onclick="restoreItem('lstAvailableTemplates','lstSelectedTemplates')"
                                                                    style="width: 80px" title="" type="button">
                                                                    &lt; Remove</button></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td id="Td9" style="width: 231px" valign="top">
                                                <asp:ListBox ID="lstSelectedTemplates" runat="server" Height="115px" ondblclick="restoreItem('lstAvailableTemplates','lstSelectedTemplates')"
                                                    SelectionMode="Multiple" Width="225px"></asp:ListBox>
                                            </td>
                                        </tr>
                                    </table>
                                    <strong><span style="color: black">Current Item:</span></strong>
                                    <asp:Label ID="CurrentTemplate" runat="server" ForeColor="Black"></asp:Label></td>
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
        <table style="width: 95%">
            <tr>
                <td align="right" class="ms-descriptiontext" style="height: 10px">
                    <asp:Button ID="btnBottomModify" runat="server" Height="25px" OnClick="btnTopSave_Click"
                        OnClientClick="ValidateGCT()" Text="Save" ValidationGroup="AllValidator" Width="70px" />
                    &nbsp;
                    <asp:Button ID="btnBottomCancel" runat="server" Height="25px" OnClick="btnBottomCancel_Click"
                        Text="Cancel" Width="70px" /></td>
            </tr>
        </table>
        <table id='tblAsociatedDocuments' style="width: 95%">
            <tr>
                <td align="right" class="ms-descriptiontext">
                <%ShowAssociatedTemplates()%>
                </td>
            </tr>    
        </table>    
                

        
        <asp:TextBox ID="txtActivityID" runat="server" Visible="False">0</asp:TextBox><asp:TextBox
            ID="txtProcessID" runat="server" Style="display: none">0</asp:TextBox>
        <asp:TextBox ID="txtProjectID" runat="server" Style="display: none">0</asp:TextBox>
        <asp:TextBox ID="txtSDLCID" runat="server" Style="display: none">0</asp:TextBox>
    </form>
</body>
</html>
