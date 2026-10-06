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
<%@Page Language="vb" AutoEventWireup="true" CodeBehind="WhizActivity.aspx.vb" Inherits="PbNIT.WhizActivity" enableEventValidation="false" %>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Activity</title>
    <link rel="stylesheet" type="text/css" href="../General/core.css" />
    <link rel="stylesheet" type="text/css" href="../General/PWAStyle.css" />
    <script type="text/javascript" language='javascript' src='../General/CommonFunctions.js'></script>
    <script type="text/javascript" language='javascript' src="../General/CommonValidations.js" ></script>
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
        function ShowCurrent(type)
        {
            
            var multipleItemsSelected=false;counter=0;counterSelectedItems=0;
            switch(type)
            {
                case "G":
                {
                    var AvailableGuidelines = document.getElementById("lstAvailableGuidelines");
                    if(AvailableGuidelines!=null && AvailableGuidelines.length>0)
                    {   
                        for(counter=0;counter<AvailableGuidelines.length;counter++)
                        {
                            if(AvailableGuidelines.options[counter].selected==true)
                               {
                                counterSelectedItems+=1;
                               } 
                        }
                        if(counterSelectedItems>1)
                            multipleItemsSelected=true;
                            
                        if(multipleItemsSelected==false && counterSelectedItems==1)    
                            document.getElementById("CurrentGuideline").innerHTML = AvailableGuidelines.options(AvailableGuidelines.selectedIndex).text;
                        if(multipleItemsSelected== true) 
                            document.getElementById("CurrentGuideline").innerHTML ="Multiple items selected";
                        if(counterSelectedItems==0)               
                            document.getElementById("CurrentGuideline").innerHTML ="";
                    }
                    break;
                }
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
        var objActivityStageID = document.getElementById('txtActivityStageID');
        objActivityStageID.focus();

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
            
            //////////////////////////////////////////////////////
            
            var objdivlistPage = GetObjectReference('frmProcessDetails','DivMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
	
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 900;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 900;
		    }
		    if (intDivHeight < 900)
			    intDivHeight = 450;
		    objdivlistPage.style.height = 450;}//intDivHeight;}
            ///////////////////////////////////////////////////////
            
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
            var objlstSelectedGuidelines = document.getElementById('lstSelectedGuidelines'); 
            var objlstAvailableGuidelines = document.getElementById('lstAvailableGuidelines'); 
            var objlstSelectedChecklists = document.getElementById('lstSelectedChecklists'); 
            var objlstAvailableChecklists = document.getElementById('lstAvailableChecklists'); 
            var objlstSelectedTemplates = document.getElementById('lstSelectedTemplates'); 
            var objlstAvailableTemplates = document.getElementById('lstAvailableTemplates'); 
                        
                        
            var counter=0;
            if (objlstSelectedGuidelines==null || objlstAvailableGuidelines==null)
                return;
                
             for(counter=0;counter<objlstSelectedGuidelines.length;counter++)    
             {
                objlstSelectedGuidelines.options[counter].selected=true;
             }
             
             for(counter=0;counter<objlstAvailableGuidelines.length;counter++)    
             {
                objlstAvailableGuidelines.options[counter].selected=true;
             }
             
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
<body onload="window_OnLoad()" >
    <form id="frmWhizProcessesActivity" runat="server">
    <div id="DivMain" style="width:100%;overflow:auto;">
        <div id="Div1" runat="server" enableviewstate="true" >
            <table toplevel border='0' cellpadding='0' cellspacing='0' width='95%'>
                <tr>
                    <td style="height: 47px; width: 905px;">
                        <table border='0' cellpadding='0' cellspacing='0' width='100%'>
                            <tr class='ms-WPHeader'>
                                <td accesskey='W' tabindex='0' title='Add Modify Activity' id='WebPartTitleWPQ1'
                                    style='width: 50%'>
                                    <div class='ms-WPTitle'>
                                        <nobr>
                    <span>Activity</span>
                    <span id='WebPartCaptionWPQ1'></span>
                    </nobr>
                                    </div>
                                </td>
                                <td class='ms-sectionheader' style='padding-top: 4px' valign="top" height="22" align='right'>
                                    <span id="objAddMode" style='cursor: hand' onclick="javascript:OpenHelpPage('1040-109')">|?|&nbsp;</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table style="width: 95%">
                <tr>
                    <td class="ms-stdtxt" align="right" style="width: 900px">
                        <span class="AlertText">*</span><label>&nbsp;indicates a required field</label>
                    </td>
                </tr>
                <tr>
                    <td height="10" class="ms-descriptiontext" align="right" style="width: 900px">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                            ShowSummary="False" ValidationGroup="AllValidator" />
                        <asp:Button ID="btnTopSave" runat="server" Height="25px" Text="Save" Width="70px"
                            OnClick="btnTopSave_Click" ValidationGroup="AllValidator" OnClientClick="ValidateGCT" AccessKey="s" />&nbsp;
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
                    <td class="ms-sectionheader" style="padding-top: 4px;width: 20%;" valign="top">
                        <a style='cursor: hand' href="javascript:ShowHideSection('imgActivitySection','objControls1')">
                            <img id="imgActivitySection" style='border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                                border-right-width: 0px' alt='Hide/Show' src='../../Images/minus.gif' border='0' />&nbsp;&nbsp;
                        <asp:Label ID="lblActivitySection" runat="server" Text="Modify Activtiy"></asp:Label> </a>
                    </td>
                    <td style="width: 80%">
                        <div id='objControls1' style='display: inline'>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            &nbsp;Activity Stage ID:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtActivityStageID" runat="server" Width="200px" MaxLength="200"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Activity Order &nbsp;Number:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtOrderNumber" runat="server" Width="50px" MaxLength="8" style="text-align:right" ></asp:TextBox>&nbsp;<span
                                            class="AlertText"></span> &nbsp;
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtOrderNumber"
                                            Display="None" ErrorMessage="'Activity Order Number' should not be left blank"
                                            ValidationGroup="AllValidator"></asp:RequiredFieldValidator>
                                        <asp:RangeValidator ID="RangeValidator1" runat="server" Display="None" ErrorMessage="'Activity Order Number' should be positive integer only."
                                            MaximumValue="99999999" MinimumValue="1" ValidationGroup="AllValidator" ControlToValidate="txtOrderNumber" Type="Integer"></asp:RangeValidator>
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidateDuplicateOrderNumber"
                                            ControlToValidate="txtOrderNumber" Display="None" ErrorMessage="'Activty Order number' already exists."
                                            ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Activity &nbsp;Name:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtActivityName" runat="server" Width="408px" MaxLength="200" CssClass="ms-input"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtActivityName"
                                            Display="None" ErrorMessage="'Activity Name' should not be left blank" ValidationGroup="AllValidator"></asp:RequiredFieldValidator><span
                                            class="AlertText"></span></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Activity Details:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        &nbsp;<asp:TextBox ID="txtActivityDetails" runat="server" Height="88px" TextMode="MultiLine"
                                            Width="416px" CssClass="ms-input"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtActivityDetails"
                                            Display="None" ErrorMessage="'Activity Details' should not be left blank" ValidationGroup="AllValidator"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator4" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtActivityDetails" Display="None" ErrorMessage="Max Length of 'Activity Details' is 4500 characters." ToolTip="4500" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            <span style="color: #ff0000">*</span>Objective:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtObjective" runat="server" Height="80px" TextMode="MultiLine"
                                            Width="416px" CssClass="ms-input"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                                runat="server" ControlToValidate="txtObjective" Display="None" ErrorMessage="'Objective' should not be left blank"
                                                ValidationGroup="AllValidator"></asp:RequiredFieldValidator>
                                        <asp:CustomValidator ID="CustomValidator2" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtObjective" Display="None" ErrorMessage="Max Length of 'Objective' is 500 characters." ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator><span class="AlertText"></span></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            Scope:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtScope" runat="server" Height="80px" TextMode="MultiLine" Width="416px" CssClass="ms-input"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator3" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtScope" Display="None" ErrorMessage="Max Length of 'Scope' is 500 characters." ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            Input &nbsp;Criteria:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style='text-align: justify'>
                                        &nbsp;<asp:TextBox ID="txtInputCriteria" runat="server" Height="88px" TextMode="MultiLine"
                                            Width="416px" CssClass="ms-input"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator5" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtInputCriteria" Display="None" ErrorMessage="Max Length of 'Input Criteria' is 500 characters." ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                        <label for="idResType" accesskey="?">
                                            Inputs:</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 7px;">
                                        &nbsp;<asp:TextBox ID="txtInputs" runat="server" Height="88px" TextMode="MultiLine" Width="416px" CssClass="ms-input"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator6" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtInputs" Display="None" ErrorMessage="Max Length of 'Inputs' is 500 characters."
                                            Font-Bold="True" ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class="ms-authoringcontrols" width="99%" border="0">
                                <tr>
                                    <td>
                                        Exit Criteria:</td>
                                </tr>
                                <tr>
                                    <td style="height: 23px; text-align: justify">
                                        &nbsp;<asp:TextBox ID="txtExitCriteria" runat="server" Width="416px" Height="88px" TextMode="MultiLine" CssClass="ms-input"></asp:TextBox>
                                        <asp:CustomValidator ID="CustomValidator7" runat="server" ClientValidationFunction="validateMaxLength"
                                            ControlToValidate="txtExitCriteria" Display="None" ErrorMessage="Max Length of 'Exit Criteria' is 500 characters."
                                            Font-Bold="True" ToolTip="500" ValidationGroup="AllValidator"></asp:CustomValidator></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td style="height: 15px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        <asp:CheckBox ID="chkDoesThisActivityGetReviewedFrequently" runat="server" Text="Does This Activity Get Reviewed Frequently" /></td>
                                </tr>
                            </table>
                            <table class='ms-authoringcontrols' width='99%' border="0">
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: justify; height: 23px;">
                                        <asp:CheckBox ID="chkIsActive" runat="server" Text="Active" Checked="True" />
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
                        <a style='cursor: hand' onclick="javascript:ShowHideSection('ImgAssociateGuidelines','objControls2')" >
                            <img id="ImgAssociateGuidelines" style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                                border-right-width: 0px; font-weight: bold;" alt='Hide/Show' src='../../Images/plus.gif' border='0'/>&nbsp;Associate Guidelines</a>
                    </td>
                    <td style="width:80%">
                        <div id='objControls2' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="idLbl_users_Alpha" accesskey="U" for="users_Alpha">
                                                        Available Guidelines:</label></th>
                                                <th style="width: 80px">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom;">
                                                    <label id="idLbl_users_Beta" accesskey="R" for="users_Beta">
                                                        Selected Guidelines</label>
                                                    :</th>
                                            </tr>
                                            <tr>
                                                <td id="idSwpUsers_AlphaList_Container" style="width: 166px; height: 108px;" valign="top">
                                                    <asp:ListBox ID="lstAvailableGuidelines" runat="server" Height="115px" Width="225px" onchange="javascript:ShowCurrent('G','lstAvailableGuidelines')" ondblclick="removeItem('lstAvailableGuidelines','lstSelectedGuidelines')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="idSwpUsers_AddRemove_Container" style="height: 108px; width: 80px;">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="idSwpUsers_BtnRemoveItem_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='SelectGuideline' title="Add"
                                                                        style="width: 80px" value="Add >" onclick="removeItem('lstAvailableGuidelines','lstSelectedGuidelines')"/></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRemoveAll_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='SelectAllGuidelines' title=""
                                                                        style="width: 80px" value="Add All >>" onclick="removeAll('lstAvailableGuidelines','lstSelectedGuidelines')"/></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRestoreAll_Container">
                                                                <td style="width: 80px">
                                                                    <input type="button" class='pwa-ButtonHeight' id='RemoveAllGuidelines' title="" style="width: 80px"
                                                                        value="<< Remove All" onclick="restoreAll('lstAvailableGuidelines','lstSelectedGuidelines')" /></td>
                                                            </tr>
                                                            <tr id="idSwpUsers_BtnRestoreItem_Container">
                                                                <td style="width: 80px; height: 19px;" valign="middle">
                                                                    <input type="button" class='pwa-ButtonHeight' id='RemoveGuideline' title="" style="width: 80px"
                                                                        value="< Remove" onclick="restoreItem('lstAvailableGuidelines','lstSelectedGuidelines')"/></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="idSwpUsers_BetaList_Container" style="height: 108px; width: 231px;" valign="top">
                                                    <asp:ListBox ID="lstSelectedGuidelines" runat="server"  Height="115px" Width="225px" ondblclick="restoreItem('lstAvailableGuidelines','lstSelectedGuidelines');" SelectionMode="Multiple">
                                                    </asp:ListBox></td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="CurrentGuideline" runat="server" ForeColor="Black"></asp:Label></td>
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
                        <a style='cursor: hand' onclick="javascript:ShowHideSection('imgChecklistSection','objControls3')" >
                            <img id="imgChecklistSection" style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                                border-right-width: 0px; font-weight: bold;" alt='Hide/Show' src='../../Images/plus.gif' border='0' />&nbsp;Associate Checklists</a></td>
                    <td style="width:80%">
                        <div id='objControls3' style='display: none'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="Label1" accesskey="U" for="users_Alpha">
                                                        Available Checklists:</label>
                                                </th>
                                                <th style="height: 17px; width: 79px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 17px;">
                                                    <label id="Label2" accesskey="R" for="users_Beta">
                                                        Selected Checklists:</label></th>
                                            </tr>
                                            <tr>
                                                <td valign="top">
                                                    <asp:ListBox ID="lstAvailableChecklists" runat="server" Height="115px" Width="225px" onchange="javascript:ShowCurrent('C','lstAvailableChecklists')" ondblclick="removeItem('lstAvailableChecklists','lstSelectedChecklists')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td3" style="width: 79px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr1">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectChecklist" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeItem('lstAvailableChecklists','lstSelectedChecklists')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr2">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectAllChecklists" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeAll('lstAvailableChecklists','lstSelectedChecklists')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr3">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveAllChecklists" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreAll('lstAvailableChecklists','lstSelectedChecklists')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr4">
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveChecklist" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreItem('lstAvailableChecklists','lstSelectedChecklists')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td4" style="height: 108px; width: 231px;" valign="top">
                                                    <asp:ListBox ID="lstSelectedChecklists" runat="server" Height="115px" Width="225px" ondblclick="restoreItem('lstAvailableChecklists','lstSelectedChecklists')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="CurrentChecklist" runat="server" ForeColor="Black"></asp:Label></td>
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
                        <a style='cursor: hand' onclick="javascript:ShowHideSection('imgTemplateSection','objControls4')" >
                            <img id="imgTemplateSection" style="border-top-width: 0px; border-left-width: 0px; border-bottom-width: 0px;
                                border-right-width: 0px; font-weight: bold;" alt='Hide/Show' src='../../Images/plus.gif' border='0' />&nbsp;Associate Templates</a>&nbsp;</td>
                    <td style="width: 80%">
                        <div style='display: none' id='objControls4'>
                            <table class='ms-authoringcontrols' width='99%'>
                                <tr>
                                    <td>
                                        <table class='ms-authoringcontrols' cellspacing="1" cellpadding="1" border="0">
                                            <tr>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label3" accesskey="U" for="users_Alpha">
                                                        Available Templates:</label>
                                                </th>
                                                <th style="width: 80px; height: 15px;">
                                                    &nbsp;</th>
                                                <th style="vertical-align: bottom; height: 15px;">
                                                    <label id="Label4" accesskey="R" for="users_Beta">
                                                        Selected Templates:</label>
                                                </th>
                                            </tr>
                                            <tr>
                                                <td id="Td7" valign="top">
                                                    <asp:ListBox ID="lstAvailableTemplates" runat="server" Height="115px" Width="225px" onchange="javascript:ShowCurrent('T','lstAvailableTemplates')" ondblclick="removeItem('lstAvailableTemplates','lstSelectedTemplates')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                                <td id="Td8" style="width: 80px">
                                                    <table class="ms-stdtxt" cellspacing="1" cellpadding="1">
                                                        <tbody>
                                                            <tr id="Tr5" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectTemplate" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeItem('lstAvailableTemplates','lstSelectedTemplates')">
                                                                        Add &gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr6" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="SelectAllTemplates" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="removeAll('lstAvailableTemplates','lstSelectedTemplates')">
                                                                        Add All &gt;&gt;</button></td>
                                                            </tr>
                                                            <tr id="Tr7" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveAllTemplates" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreAll('lstAvailableTemplates','lstSelectedTemplates')">
                                                                        &lt;&lt; Remove All</button></td>
                                                            </tr>
                                                            <tr id="Tr8" valign=top>
                                                                <td style="width: 104px">
                                                                    <button class="pwa-ButtonHeight" id="RemoveTemplate" title="" style="width: 80px" enabled
                                                                        accesskey="" onclick="restoreItem('lstAvailableTemplates','lstSelectedTemplates')">
                                                                        &lt; Remove</button></td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td id="Td9" valign="top" style="width: 231px">
                                                    <asp:ListBox ID="lstSelectedTemplates" runat="server" Height="115px" Width="225px" ondblclick="restoreItem('lstAvailableTemplates','lstSelectedTemplates')" SelectionMode="Multiple">
                                                    </asp:ListBox>
                                                </td>
                                            </tr>
                                        </table>
                                        <strong><span style="color: black">Current Item:</span></strong>&nbsp;<asp:Label
                                            ID="CurrentTemplate" runat="server" ForeColor="Black"></asp:Label></td>
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
                    <td class="ms-descriptiontext" align="right" style="height: 10px">
                        <asp:Button ID="btnBottomModify" runat="server" Height="25px" Text="Save" Width="70px"
                             OnClick="btnTopSave_Click" ValidationGroup="AllValidator" OnClientClick="ValidateGCT()" />
                        &nbsp;
                        <asp:Button ID="btnBottomCancel" runat="server" Height="25px" Text="Cancel" Width="70px"
                            OnClick="btnBottomCancel_Click" /></td>
                </tr>
            </table>
        </div>
        </div>
        <asp:TextBox ID="txtActivityID" runat="server" Visible="False">0</asp:TextBox>
        <asp:TextBox ID="txtExistingOrderNumbers" runat="server" style="display:none"></asp:TextBox>
        <select id="cboselectedList" style="display: none">
            <option selected="selected"></option>
        </select>
        
    </form>
</body>
</html>
