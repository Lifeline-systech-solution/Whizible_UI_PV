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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="WhizProjectType.aspx.vb"
    Inherits="PbNIT.WhizProjectType" EnableEventValidation="false" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Activity</title>
    <link rel="stylesheet" type="text/css" href="../General/core.css" />
    <link rel="stylesheet" type="text/css" href="../General/PWAStyle.css" />

    <script type="text/javascript" language='javascript' src='../General/CommonFunctions.js'></script>

    <script type="text/javascript" language='javascript' src="../General/CommonValidations.js"></script>

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

    <script type="text/javascript" language="javascript">
        //--------------------------------------------------------------------------------------------------------
        function ShowCurrent(strListName,strLableName)
        {
            var multipleItemsSelected=false;counter=0;counterSelectedItems=0;
            var objSelectedList = document.getElementById(strListName);
            if(objSelectedList!=null && objSelectedList.length>0)
            {   
                for(counter=0;counter<objSelectedList.length;counter++)
                {
                    if(objSelectedList.options[counter].selected==true)
                    {
                        counterSelectedItems+=1;
                    } 
                }
                if(counterSelectedItems>1)
                    multipleItemsSelected=true;
                            
                if(multipleItemsSelected==false && counterSelectedItems==1)    
                        document.getElementById(strLableName).innerHTML = objSelectedList.options(objSelectedList.selectedIndex).text;
                        if(multipleItemsSelected== true) 
                            document.getElementById(strLableName).innerHTML ="Multiple items selected";
                        if(counterSelectedItems==0)               
                            document.getElementById(strLableName).innerHTML ="";
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
                    objImg.src = '../../Images/P12/QC/minus.gif';
               }
               else
               {
                    objSection.style.display = 'none';
                    objImg.src = '../../Images/P12/QC/plus.gif';
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
                    case "lstAvailableGuidelines":
                    {
                        ShowCurrent("G");
                        break;
                    }
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
                    case "lstAvailableGuidelines":
                    {
                        document.getElementById("CurrentGuideline").innerHTML = "";
                        break;
                    }
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
                    case "lstAvailableGuidelines":
                    {
                        document.getElementById("SelectGuideline").disabled = true;
                        document.getElementById("SelectAllGuidelines").disabled = true;
                        document.getElementById("RemoveGuideline").disabled = false;
                        document.getElementById("RemoveAllGuidelines").disabled = false;
                        break;
                    }
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
                    case "lstAvailableGuidelines":
                    {
                        document.getElementById("SelectGuideline").disabled = false;
                        document.getElementById("SelectAllGuidelines").disabled = false;
                        document.getElementById("RemoveGuideline").disabled = false;
                        document.getElementById("RemoveAllGuidelines").disabled = false;
                        break;
                    }
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
                case "lstAvailableGuidelines":
                {
                    document.getElementById("SelectGuideline").disabled = true;
                    document.getElementById("SelectAllGuidelines").disabled = true;
                    document.getElementById("RemoveGuideline").disabled = false;
                    document.getElementById("RemoveAllGuidelines").disabled = false;
                    break;
                }
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
                case "lstSelectedGuidelines":
                {
                    document.getElementById("SelectGuideline").disabled = false;
                    document.getElementById("SelectAllGuidelines").disabled = false;
                    document.getElementById("RemoveGuideline").disabled = true;
                    document.getElementById("RemoveAllGuidelines").disabled = true;
                    break;
                }
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
                    case "lstAvailableGuidelines":
                    {
                        ShowCurrent("G");
                        break;
                    }
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
                    case "lstAvailableGuidelines":
                    {
                        document.getElementById("CurrentGuideline").innerHTML = "";
                        break;
                    }
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
                    case "lstSelectedGuidelines":
                    {
                        document.getElementById("SelectGuideline").disabled = false;
                        document.getElementById("SelectAllGuidelines").disabled = false;
                        document.getElementById("RemoveGuideline").disabled = true;
                        document.getElementById("RemoveAllGuidelines").disabled = true;
                        break;
                    }
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
                    case "lstSelectedGuidelines":
                    {
                        document.getElementById("SelectGuideline").disabled = false;
                        document.getElementById("SelectAllGuidelines").disabled = false;
                        document.getElementById("RemoveGuideline").disabled = false;
                        document.getElementById("RemoveAllGuidelines").disabled = false;
                        break;
                    }
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
            if(document.getElementById("lstAvailableGuidelines").options.length==0)
            {
                document.getElementById("SelectGuideline").disabled = true;
                document.getElementById("SelectAllGuidelines").disabled = true;
            }
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

            if(document.getElementById("lstSelectedGuidelines").options.length==0)
            {
                document.getElementById("RemoveGuideline").disabled = true;
                document.getElementById("RemoveAllGuidelines").disabled = true;
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
        function SelectListItems(strElementName,strStorageName)
        {
            var objList = document.getElementById(strElementName);
            var objStorage = document.getElementById(strStorageName);
            var strStorageValues = new String();
            strStorageValues = "";
            if(objList != null)
            {
                for(counter=0;counter < objList.length;counter++)    
                {
                    //objList.options[counter].selected=true;
                    strStorageValues = strStorageValues + objList.options[counter].value + ",";
                }
            }
            if(strStorageValues.length >0)
            {
                strStorageValues =  strStorageValues.substr(0,strStorageValues.length -1) ;
            }
            else
            {
                strStorageValues ="";
            }
            objStorage.value = strStorageValues;
        }
        
        function ValidateGCT()
        {
            SelectListItems('lstSelectedPlans','txtSelectedPlans');
            SelectListItems('lstSelectedPhases','txtSelectedPhases');
            SelectListItems('lstSelectedTaskTypes','txtSelectedTaskTypes');
            SelectListItems('lstSelectedIssueTypes','txtSelectedIssueTypes');
            SelectListItems('lstSelectedReviewTypes','txtSelectedReviewTypes');
            SelectListItems('lstSelectedCorporateRisks','txtSelectedCorporateRisks');
            /*SelectListItems('lstAvailablePhases');
            SelectListItems('lstAvailableTaskTypes');
            SelectListItems('lstAvailableIssueTypes');
            SelectListItems('lstAvailableReviewTypes');
            SelectListItems('lstAvailableCorporateRisks');*/

        }
        
        function CheckParent(objParent)
        {
            var objActivities = new Array();
            var strChildNames = objParent.name + 'C';
            objActivities =  document.getElementsByName(strChildNames);
            for(i=0;i< objActivities.length ;i++)
            {
                objActivities[i].checked = objParent.checked;
                CheckChild(objActivities[i]);
            }
        }
        
        function SetSelectedValues()
        {
            GetSelectedActivities();
            GetSelectedMetrics();
            return;
        }
        
        function GetSelectedActivities()
        {
            var objAvailableProcesses = document.getElementById("txtProcesses");
            var objConfiguredActivities = document.getElementById("txtConfiguredActivities");
            var arrActvities = new Array();
            var strSelectedChildren = new String() ;
            arrActvities = objAvailableProcesses.value.split(',');
            for(intCount = 0;intCount < arrActvities.length ; intCount ++)
            {
                var strParentName = 'P' + arrActvities[intCount].toString();
                var strChildName = strParentName + 'C';
                var arrChildren = new Array();
                arrChildren = document.getElementsByName(strChildName);
                
                 for(i = 0;i < arrChildren.length ; i++)
                 {
                    if(arrChildren[i].checked)
                    {
                        strSelectedChildren += "'" + arrChildren[i].value +  "',";
                    }
                 }
                 //objConfiguredActivities.value = '';
            }
            if(strSelectedChildren.length > 0)
            {
                 objConfiguredActivities.value=strSelectedChildren.substr(0,strSelectedChildren.length - 1);
            }
                         else
            {
            objConfiguredActivities.value = "";
            }

        }
        
        function GetSelectedMetrics()
        {
            var objAvailableCategories = document.getElementById("txtMetricCategories");
            var objConfiguredMetric = document.getElementById("txtConfiguredMetric");
            var arrMetric = new Array();
            var strSelectedChildren = new String() ;
            arrMetric = objAvailableCategories.value.split(',');
            for(intCount = 0;intCount < arrMetric.length ; intCount ++)
            {
                var strParentName = 'M' + arrMetric[intCount].toString();
                var strChildName = strParentName + 'C';
                var arrChildren = new Array();
                arrChildren = document.getElementsByName(strChildName);
                
                 for(i = 0;i < arrChildren.length ; i++)
                 {
                    if(arrChildren[i].checked)
                    {
                        var objLCL = document.getElementById(strParentName + arrChildren[i].value + "LCL");
                        var objUCL = document.getElementById(strParentName + arrChildren[i].value + "UCL");
                        strSelectedChildren +=  arrChildren[i].value +  "," + objLCL.value + "," + objUCL.value + "|";
                    }
                 }
                 //objConfiguredActivities.value = '';
            }
            if(strSelectedChildren.length > 0)
            {
                 objConfiguredMetric.value=strSelectedChildren.substr(0,strSelectedChildren.length - 1);
            }
            else
            {
            objConfiguredMetric.value = "";
            }

        }
        
        function HideDetailRow(strTableID,strRowId,objImg)
        {
            var objTable = document.getElementById(strTableID);
            strRowId = strRowId + 'C';
			for(i=0;i<objTable.rows.length;i++)
			{
				if(objTable.rows[i].id == strRowId)
				{
					if (objTable.rows[i].style.display == 'none')
					{
						objTable.rows[i].style.display = 'inline';
					}				
					else
					{
						objTable.rows[i].style.display = 'none';
					}
				}
			}
			var strImg = new String();
			strImg = objImg.src;
			strImg = strImg.substring(strImg.lastIndexOf("/")+1);
			if (strImg == 'whiteminus.gif')
			{
			    objImg.src = '../../Images/P12/QC/whiteplus.gif';
			}
			else
			{
			    objImg.src = '../../Images/P12/QC/whiteminus.gif';
			}
        }
        
        function HideRow(objRow)
        {
            objRow.style.display='none';
        }
        function ComputePMI()
        {
            window.open("../Process/PRO_ComputePMI.aspx?PMIID=<%=m_intPMIID.ToString()%>&MasterTagID=1052&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 800)/2) + ",width=800,height=800");
        }
        function ValidateLCLUCL(objText,e)
        {
            var strControlName = new String();
            strControlName = objText.id;
            strControlName = strControlName.substr(0,strControlName.length - 3); 
            var strLCLTextBox = strControlName + 'LCL';
            var strUCLTextBox = strControlName + 'UCL';
            var objLCL = document.getElementById(strLCLTextBox);
            var objUCL = document.getElementById(strUCLTextBox);
             !disallowNonNumeric(objText,'Please Enter Numeric Value',true);
            if(disallowValue1GreaterThanOrEqualToValue2(objLCL,objUCL,'LCL can not be greater than UCL'))
            return false;
        }
        function CheckChild(objChild)
        {
            
            var strControlName = new String();
            strControlName = objChild.name;
            strControlName = strControlName.substr(0,strControlName.length - 1)
            var objLCL = document.getElementById(strControlName + objChild.value + 'LCL');
            var objUCL = document.getElementById(strControlName + objChild.value + 'UCL');
            if(objLCL != null && objUCL != null)
            {
                if(objChild.checked)
                {
                    objLCL.style.display = 'inline';
                    objUCL.style.display = 'inline';
                }
                else
                {
                    objLCL.style.display = 'none';
                    objUCL.style.display = 'none';
                }
            }
        }
    </script>

</head>
<body>

    <form id="form1" runat="server">
        <div id="Div1" runat="server" enableviewstate="true">
            <table toplevel border='0' cellpadding='0' cellspacing='0' width='95%'>
                <tr>
                    <td style="height: 47px; width: 95%;">
                        <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                            <tr class='ms-WPHeader'>
                                <td accesskey='W' tabindex='0' title='Add Modify Activity' id='WebPartTitleWPQ1'
                                    style='width: 50%'>
                                    <div class='ms-WPTitle'>
                                        <nobr>Project Type&nbsp;<SPAN 
            id="WebPartCaptionWPQ1"></SPAN></nobr>
                                    </div>
                                </td>
                                <td class='ms-sectionheader' style='padding-top: 4px' valign="top" height="22" align='right'>
                                    <span id="objAddMode" style='cursor: hand' onclick="javascript:OpenHelpPage('1040-109')">
                                        |?|&nbsp;</span></td>
                            </tr>
                        </table>
                        <asp:Label ID="lblTemplateStatus" runat="server" ForeColor=Green></asp:Label></td>
                </tr>
            </table>
            <table style="width: 95%">
                <tr>
                    <td class="ms-stdtxt" align="right" style="width: 95%">
                        <span class="AlertText">*</span><label>&nbsp;indicates a required field</label>
                    </td>
                </tr>
                <tr>
                    <td height="10" class="ms-descriptiontext" align="right" style="width: 95%">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="AllValidator" />
                        <asp:Button ID="btnCreatePublishTemplate" runat="server" Height="25px" Text="Create Template"
                            Width="100px" OnClick="btnCreatePublishTemplate_Click" ValidationGroup="AllValidator"
                            OnClientClick="ValidateGCT" AccessKey="s" />&nbsp;
                        <asp:Button ID="btnTopSave" runat="server" Height="25px" Text="Save" Width="70px"
                            OnClick="btnTopSave_Click" ValidationGroup="AllValidator" OnClientClick="ValidateGCT"
                            AccessKey="s" />&nbsp;
                        <asp:Button ID="btnComputePMI" runat="server" Height="25px" Text="Compute PCB" Width="100px"
                            ValidationGroup="AllValidator" OnClientClick="ComputePMI" AccessKey="s" ToolTip="Compute PCB" />&nbsp;
                        <asp:Button ID="btnTopCancel" runat="server" Height="25px" Text="Cancel" Width="70px"
                            OnClick="btnBottomCancel_Click" /></td>
                </tr>
            </table>
            <table border='0' cellpadding='2' cellspacing='0' style="font-size: 8pt;" width='95%'>
                <tr>
                    <td class='ms-sectionline' colspan='2' style="height: 1px">
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgProjectType','objControls1')">
                            <img id="imgProjectType" style='border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                                border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/minus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="lblActivitySection" runat="server" Text="Modify Project Type"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div id='objControls1' style='display: inline'>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td style="height: 16px">
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Project Type:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        &nbsp;<asp:TextBox ID="txtProjectType" runat="server" Width="200px" MaxLength="500" CssClass="ms-input"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtProjectType"
                                            Display="None" ErrorMessage="'Project Type' should not be left blank" ValidationGroup="AllValidator"></asp:RequiredFieldValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Description:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        &nbsp;<asp:TextBox ID="txtProjectTypeDescription" runat="server" Width="408px" MaxLength="200" CssClass="ms-input"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtProjectTypeDescription"
                                            Display="None" ErrorMessage="'Description' should not be left blank" ValidationGroup="AllValidator"></asp:RequiredFieldValidator><span
                                                class="AlertText"></span></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociatePlans','objControls9')">
                            <img id="imgAssociatePlans" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="Label12" runat="server" Text="Associate Plans"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div id='objControls9' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="Label13" accesskey="U" for="users_Alpha">
                                                        Available Plans:</label></th>
                                                <th style="width: 80px">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom;">
                                                    <label id="Label14" accesskey="R" for="users_Beta">
                                                        Selected Plans</label>
                                                    :</th>
                                            </tr>
                                            <tr>
                                                <td id="Td12" style="width: 166px; height: 108px;" valign="top">
                                                    <asp:ListBox ID="lstAvailablePlans" runat="server" Height="115px" Width="225px" onchange="javascript:ShowCurrent('lstAvailablePlans','lblAssociatedPlans')"
                                                        ondblclick="removeItem('lstAvailablePlans','lstSelectedPlans')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td13" style="height: 108px; width: 80px;">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr17">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='Button9' title="Add" style="width: 80px"
                                                                        value="Add >" onclick="removeItem('lstAvailablePlans','lstSelectedPlans')" /></td>
                                                            </tr>
                                                            <tr id="Tr18">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='Button10' title="" style="width: 80px"
                                                                        value="Add All >>" onclick="removeAll('lstAvailablePlans','lstSelectedPlans')" /></td>
                                                            </tr>
                                                            <tr id="Tr19">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='Button11' title="" style="width: 80px"
                                                                        value="<< Remove All" onclick="restoreAll('lstAvailablePlans','lstSelectedPlans')" /></td>
                                                            </tr>
                                                            <tr id="Tr20">
                                                                <td style="width: 80px; height: 19px;" valign="middle">
                                                                    <input type="button" class='pwa-ButtonHeight' id='Button12' title="" style="width: 80px"
                                                                        value="< Remove" onclick="restoreItem('lstAvailablePlans','lstSelectedPlans')" /></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td14" style="height: 108px; width: 231px;" valign="top">
                                                    <asp:ListBox ID="lstSelectedPlans" runat="server" Height="115px" Width="225px" ondblclick="restoreItem('lstAvailablePlans','lstSelectedPlans');"
                                                        SelectionMode="Multiple"></asp:ListBox></td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblAssociatedPlans" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociatePhases','objControls2')">
                            <img id="imgAssociatePhases" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="Label7" runat="server" Text="Associate Phases"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div id='objControls2' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="idLbl_users_Alpha" accesskey="U" for="users_Alpha">
                                                        Available Phases:</label></th>
                                                <th style="width: 80px">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom;">
                                                    <label id="idLbl_users_Beta" accesskey="R" for="users_Beta">
                                                        Selected Phases</label>
                                                    :</th>
                                            </tr>
                                            <tr>
                                                <td id="idSwpUsers_AlphaList_Container" style="width: 166px; height: 108px;" valign="top">
                                                    <asp:ListBox ID="lstAvailablePhases" runat="server" Height="115px" Width="225px"
                                                        onchange="javascript:ShowCurrent('lstAvailablePhases','lblCurrentPhase')" ondblclick="removeItem('lstAvailablePhases','lstSelectedPhases')"
                                                        SelectionMode="Multiple"></asp:ListBox>
                                                </td>
                                                <td id="idSwpUsers_AddRemove_Container" style="height: 108px; width: 80px;">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="idSwpUsers_BtnRemoveItem_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='SelectGuideline' title="Add" style="width: 80px"
                                                                        value="Add >" onclick="removeItem('lstAvailablePhases','lstSelectedPhases')" /></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRemoveAll_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='SelectAllGuidelines' title="" style="width: 80px"
                                                                        value="Add All >>" onclick="removeAll('lstAvailablePhases','lstSelectedPhases')" /></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRestoreAll_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='RemoveAllGuidelines' title="" style="width: 80px"
                                                                        value="<< Remove All" onclick="restoreAll('lstAvailablePhases','lstSelectedPhases')" /></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRestoreItem_Container">
                                                                <td style="width: 80px; height: 19px;" valign="middle">
                                                                    <input type="button" class='pwa-ButtonHeight' id='RemoveGuideline' title="" style="width: 80px"
                                                                        value="< Remove" onclick="restoreItem('lstAvailablePhases','lstSelectedPhases')" /></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="idSwpUsers_BetaList_Container" style="height: 108px; width: 231px;" valign="top">
                                                    <asp:ListBox ID="lstSelectedPhases" runat="server" Height="115px" Width="225px" ondblclick="restoreItem('lstAvailablePhases','lstSelectedPhases');"
                                                        SelectionMode="Multiple"></asp:ListBox></td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblCurrentPhase" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociateTaskTypes','objControls3')">
                            <img id="imgAssociateTaskTypes" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="Label10" runat="server" Text="Associate Task Types"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div id='objControls3' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="Label1" accesskey="U" for="users_Alpha">
                                                        Available Task Types:</label>
                                                </th>
                                                <th style="height: 17px; width: 79px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="Label2" accesskey="R" for="users_Beta">
                                                        Selected Task Types:</label></th>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <asp:ListBox ID="lstAvailableTaskTypes" runat="server" Height="115px" Width="225px"
                                                        onchange="javascript:ShowCurrent('lstAvailableTaskTypes','lblCurrentTaskTypes')"
                                                        ondblclick="removeItem('lstAvailableTaskTypes','lstSelectedTaskTypes')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td3" style="width: 79px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr1">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectChecklist" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="removeItem('lstAvailableTaskTypes','lstSelectedTaskTypes')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr2">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectAllChecklists" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="removeAll('lstAvailableTaskTypes','lstSelectedTaskTypes')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr3">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveAllChecklists" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="restoreAll('lstAvailableTaskTypes','lstSelectedTaskTypes')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr4">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveChecklist" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="restoreItem('lstAvailableTaskTypes','lstSelectedTaskTypes')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td4" style="height: 108px; width: 231px;" valign="top">
                                                    <asp:ListBox ID="lstSelectedTaskTypes" runat="server" Height="115px" Width="225px"
                                                        ondblclick="restoreItem('lstAvailableTaskTypes','lstSelectedTaskTypes')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblCurrentTaskTypes" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociateIssueType','objControls4')">
                            <img id="imgAssociateIssueType" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="lblAssociateIssueType" runat="server" Text="Associate Issue Types"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div style='display: none' id='objControls4'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label3" accesskey="U" for="users_Alpha">
                                                        Available Issue Types:</label>
                                                </th>
                                                <th style="width: 80px; height: 15px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label4" accesskey="R" for="users_Beta">
                                                        Selected Issue Types:</label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td id="Td7" valign="top">
                                                    <asp:ListBox ID="lstAvailableIssueTypes" runat="server" Height="115px" Width="225px"
                                                        onchange="javascript:ShowCurrent('lstAvailableIssueTypes','lblCurrentIssueType')"
                                                        ondblclick="removeItem('lstAvailableIssueTypes','lstSelectedIssueTypes')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td8" style="width: 80px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr5" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectTemplate" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="removeItem('lstAvailableIssueTypes','lstSelectedIssueTypes')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr6" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectAllTemplates" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="removeAll('lstAvailableIssueTypes','lstSelectedIssueTypes')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr7" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveAllTemplates" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="restoreAll('lstAvailableIssueTypes','lstSelectedIssueTypes')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr8" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveTemplate" title="" style="width: 80px"
                                                                        enabled accesskey="" onclick="restoreItem('lstAvailableIssueTypes','lstSelectedIssueTypes')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td9" valign="top" style="width: 231px">
                                                    <asp:ListBox ID="lstSelectedIssueTypes" runat="server" Height="115px" Width="225px"
                                                        ondblclick="restoreItem('lstAvailableIssueTypes','lstSelectedIssueTypes')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblCurrentIssueType" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociateReviewType','objControls5')">
                            <img id="imgAssociateReviewType" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="lblAssociateReviewType" runat="server" Text="Associate Review Types"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div style='display: none' id='objControls5'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label5" accesskey="U" for="users_Alpha">
                                                        Available Review Types:</label>
                                                </th>
                                                <th style="width: 80px; height: 15px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label6" accesskey="R" for="users_Beta">
                                                        Selected Review Types:</label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td id="Td1" valign="top">
                                                    <asp:ListBox ID="lstAvailableReviewTypes" runat="server" Height="115px" Width="225px"
                                                        onchange="javascript:ShowCurrent('lstAvailableReviewTypes','lblCurrentReviewType')"
                                                        ondblclick="removeItem('lstAvailableReviewTypes','lstSelectedReviewTypes')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td2" style="width: 80px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr9" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button1" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeItem('lstAvailableReviewTypes','lstSelectedReviewTypes')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr10" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button2" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeAll('lstAvailableReviewTypes','lstSelectedReviewTypes')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr11" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button3" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreAll('lstAvailableReviewTypes','lstSelectedReviewTypes')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr12" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button4" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreItem('lstAvailableReviewTypes','lstSelectedReviewTypes')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td5" valign="top" style="width: 231px">
                                                    <asp:ListBox ID="lstSelectedReviewTypes" runat="server" Height="115px" Width="225px"
                                                        ondblclick="restoreItem('lstAvailableReviewTypes','lstSelectedReviewTypes')"
                                                        SelectionMode="Multiple"></asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblCurrentReviewType" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgAssociateCorporateType','objControls6')">
                            <img id="imgAssociateCorporateType" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;
                            <asp:Label ID="Label11" runat="server" Text="Associate Risks"></asp:Label>
                        </a>
                    </td>
                    <td style="width: 80%">
                        <div style='display: none' id='objControls6'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label8" accesskey="U" for="users_Alpha">
                                                        Available &nbsp;Risks:</label>
                                                </th>
                                                <th style="width: 80px; height: 15px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label9" accesskey="R" for="users_Beta">
                                                        Selected Risks:</label></th>
                                            </tr>
                                            <tr>
                                                <td id="Td6" valign="top">
                                                    <asp:ListBox ID="lstAvailableCorporateRisks" runat="server" Height="115px" Width="225px"
                                                        onchange="javascript:ShowCurrent('lstAvailableCorporateRisks','lblCurrentCorporateRisk')"
                                                        ondblclick="removeItem('lstAvailableCorporateRisks','lstSelectedCorporateRisks')"
                                                        SelectionMode="Multiple"></asp:ListBox>
                                                </td>
                                                <td id="Td10" style="width: 80px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr13" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button5" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeItem('lstAvailableCorporateRisks','lstSelectedCorporateRisks')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr14" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button6" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeAll('lstAvailableCorporateRisks','lstSelectedCorporateRisks')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr15" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button7" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreAll('lstAvailableCorporateRisks','lstSelectedCorporateRisks')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr16" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="Button8" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreItem('lstAvailableCorporateRisks','lstSelectedCorporateRisks')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td11" valign="top" style="width: 231px">
                                                    <asp:ListBox ID="lstSelectedCorporateRisks" runat="server" Height="115px" Width="225px"
                                                        ondblclick="restoreItem('lstAvailableCorporateRisks','lstSelectedCorporateRisks')"
                                                        SelectionMode="Multiple"></asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="lblCurrentCorporateRisk" runat="server" ForeColor="Black"></asp:Label></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class='ms-sectionline' colspan='2'>
                    </td>
                </tr>
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgConfigureProcesses','objControls7')">
                            <img id="imgConfigureProcesses" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;&nbsp;Configure Processes&nbsp;</a></td>
                    <td style="width: 80%">
                        <div id='objControls7' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        <%DrawProcessesTable()%>
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
                <tr>
                    <td class="ms-sectionheader" style="padding-top: 4px; width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgConfigureMetricesSection','objControls8')">
                            <img id="imgConfigureMetricesSection" style='border-top-width: 0px; border-left-width: 0px;
                                border-bottom-width: 0px; border-right-width: 0px' alt='Hide/Show' src='../../Images/P12/QC/plus.gif'
                                border='0' />&nbsp;&nbsp;Configure Metrices&nbsp;</a></td>
                    <td style="width: 80%">
                        <div id='objControls8' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        <%DrawMetricesTable()%>
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
            <table style="width: 95%">
                <tr>
                    <td class="ms-descriptiontext" align="right" style="width: 95%">
                        <asp:Button ID="btnBottomCreatePublishTemplate" runat="server" Height="25px" Text="Create Template"
                            Width="100px" OnClick="btnCreatePublishTemplate_Click" ValidationGroup="AllValidator"
                            OnClientClick="ValidateGCT" AccessKey="s" />&nbsp;
                        <asp:Button ID="btnBottomModify" runat="server" Height="25px" Text="Save" Width="70px"
                            OnClick="btnTopSave_Click" ValidationGroup="AllValidator" OnClientClick="ValidateGCT"
                            AccessKey="m" />&nbsp;
                        <asp:Button ID="btnBottomComputePMI" runat="server" Height="25px" Text="Compute PCB"
                            Width="100px" ValidationGroup="AllValidator" OnClientClick="ValidateGCT" AccessKey="s" ToolTip="Compute PCB" />&nbsp;
                        <asp:Button ID="btnBottomCancel" runat="server" Height="25px" Text="Cancel" Width="70px"
                            OnClick="btnBottomCancel_Click" /></td>
                </tr>
            </table>
        </div>
        <asp:TextBox ID="txtProcesses" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtConfiguredActivities" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtMetricCategories" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtConfiguredMetric" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedPhases" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedTaskTypes" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedIssueTypes" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedReviewTypes" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedCorporateRisks" runat="server" Style="display: none"></asp:TextBox>
        <asp:TextBox ID="txtSelectedPlans" runat="server" Style="display: none"></asp:TextBox>
    </form>
</body>
</html>
