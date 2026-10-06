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
<%@ Page Language="vb" AutoEventWireup="true"  CodeBehind="WhizProcessDetails.aspx.vb" Inherits="PbNIT.WhizProcessDetails" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link rel="stylesheet" type="text/css" href="../General/core.css"/>
    <link rel="stylesheet" type="text/css" href="../General/PWAStyle.css"/>
    <link rel="stylesheet" type="text/css" href="../General/StyleSheetChanakya_WhizP2007.css"/>
    <script type="text/javascript" language='javascript' src='../General/CommonFunctions.js'></script>
    <script  type="text/javascript" language='javascript' src='../General/CommonValidations.js'></script>
    <script  type="text/javascript" language='javascript' src='../General/SharePointDocumentLibrary.js'></script>
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
    <script language = "javascript" type="text/javascript" >
        function ShowHideSection(strImg,strSectionID)
        {
            var objSection = document.getElementById(strSectionID);
            var objImg = document.getElementById(strImg);
            if(objSection.style.display == 'none')
            {
                objSection.style.display='inline';
                objImg.src='../../Images/minus.gif';
            }
            else
            {
                objSection.style.display='none';
                objImg.src='../../Images/plus.gif';
            }
        }
        
        function Delete(strLevelID,strPrimaryKey)
        {
                if(strPrimaryKey==0)
                {
                    var intCount = 0;
                    var objCheckBox = document.getElementsByName('chkTask');
                    var objHIDTextBOX = document.getElementById('txtSelectedTasks');
                    for(i=0;i < objCheckBox.length;i++)
                    {
                        if(objCheckBox[i].checked)
                        {
                            if (intCount == 0)
                            {
                               strPrimaryKey = objCheckBox[i].value;
                               intCount = 1;                                     
                            }
                            else
                            {
                                strPrimaryKey = strPrimaryKey + ',' + objCheckBox[i].value;
                            }
                        }
                    }
                    if(strPrimaryKey==0)
                        return;
                 }
                                    
            if(confirm("Are you sure you want to delete this record ?") == true)
            {
                /*window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcessDetails.aspx?ACTION=DELETE&PKID=" + strLevelID + "&ItemID=" + strPrimaryKey;
                window.parent.frames['infragisticsTree'].document.location.href = window.parent.frames['infragisticsTree'].document.location.href;*/
                window.location.href ="WhizProcessDetails.aspx?ACTION=DELETE&PKID=" + strLevelID + "&ItemID=" + strPrimaryKey;
            }
            else
            {
            
            }
        }
        
        function AddNew(strLevelID)
        {
	            var strArr = new Array();
	            strArr = strLevelID.split('|');
                switch(strArr[1])
                {
                    case 'P' :
                      //  window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizActivity.aspx?ACTION=ADD_NEW&PROCESSID=" + strArr[2];
                        window.location.href ="WhizActivity.aspx?ACTION=ADD_NEW&PROCESSID=" + strArr[2];
                        break;
                    case 'PS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcesses.aspx?ACTION=ADD_NEW";
                        window.location.href ="WhizProcesses.aspx?ACTION=ADD_NEW";
                        break;
                    case 'TS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizTemplate.aspx?ACTION=ADD_NEW" + "&PKID=" + strLevelID;
                        window.location.href ="WhizTemplate.aspx?ACTION=ADD_NEW" + "&PKID=" + strLevelID;
                        break;
                    case 'GS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizGuidelines.aspx?ACTION=ADD_NEW" + "&PKID=" + strLevelID;
                        window.location.href ="WhizGuidelines.aspx?ACTION=ADD_NEW" + "&PKID=" + strLevelID;
                        break;
                    case 'CS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizCheckList.aspx?ACTION=ADD_NEW&PKID=" + strLevelID ;
                        window.location.href ="WhizCheckList.aspx?ACTION=ADD_NEW&PKID=" + strLevelID ;
                        break;  
                    case 'MS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizMetrics.aspx?ACTION=ADD_NEW&PKID=" + strLevelID ;
                        window.location.href ="WhizMetrics.aspx?ACTION=ADD_NEW&PKID=" + strLevelID ;
                        break;  
                    case 'PT' :
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProjectType.aspx?ProjectTypeID=0";
                        window.location.href ="WhizProjectType.aspx?ProjectTypeID=0";
                        break;                          
                    default :
                        window.open("WhizActivityTasks.aspx?Mode=ADD_NEW&ActivityID=" + strArr[2], "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 150)/2) + ",width=450,height=150");
                        //window.location.href ="WhizActivityTasks.aspx?Mode=ADD_NEW&ActivityID=" + strArr[2];
                        break;
                }

        }
        
        function Modify(strLevelID,strPrimaryKey)
        {
            var strArr = new Array();
            strArr = strLevelID.split('|');
            switch(strArr[1])
            {
                    case 'P' :
                            //window.parent.frames['WhizVisualProcessGrid'].document.location.href = "WhizActivity.aspx?ACTION=ADD_NEW&PROCESSID=" + strArr[2] + "&ACTIVITY_PK=" + strPrimaryKey + "&PKID=" + strLevelID;
                            window.location.href = "WhizActivity.aspx?ACTION=ADD_NEW&PROCESSID=" + strArr[2] + "&ACTIVITY_PK=" + strPrimaryKey + "&PKID=" + strLevelID;
                        break;
                    case 'PS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcesses.aspx?ACTION=MODIFY&PROCESS_PK=" + strPrimaryKey + "&PKID=" + strLevelID;
                        window.location.href ="WhizProcesses.aspx?ACTION=MODIFY&PROCESS_PK=" + strPrimaryKey + "&PKID=" + strLevelID;
                        break;
                    case 'AS':
                        window.open("WhizActivityTasks.aspx?Mode=MODIFY&ActivityID=" + strArr[2] + "&ActivityTaskID_PK=" + strPrimaryKey, "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 150)/2) + ",width=450,height=150");
                        //window.location.href = "WhizActivityTasks.aspx?Mode=MODIFY&ActivityID=" + strArr[2] + "&ActivityTaskID_PK=" + strPrimaryKey;
                        break;                    
                    case 'TS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizTemplate.aspx?ACTION=MODIFY&TemplateID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        window.location.href ="WhizTemplate.aspx?ACTION=MODIFY&TemplateID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        break;                    
                    case 'GS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizGuidelines.aspx?ACTION=MODIFY&GuidelineID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        window.location.href ="WhizGuidelines.aspx?ACTION=MODIFY&GuidelineID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        break;  
                    case 'CS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizCheckList.aspx?ACTION=MODIFY&QuestionnaireID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        window.location.href ="WhizCheckList.aspx?ACTION=MODIFY&QuestionnaireID_PK=" + strPrimaryKey + "&PKID=" + strLevelID ;
                        break;  
                    case 'MS':
                        //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizMetrics.aspx?ACTION=MODIFY&MetricID_PK=" +strPrimaryKey +"&PKID=" + strLevelID ;
                       window.location.href ="WhizMetrics.aspx?ACTION=MODIFY&MetricID_PK=" +strPrimaryKey +"&PKID=" + strLevelID ;
                        break;  
                    case 'PT':
                        window.location.href ="WhizProjectType.aspx?ProjectTypeID=" +strPrimaryKey;                        
                        break;  
                    default :
                        break;
            }
        }
        
        function SelectDeselectAll(objParentCheckBox)
        {
            var objCheckBox = document.getElementsByName('chkTask');
            for(i=0;i < objCheckBox.length;i++)
            {
                objCheckBox[i].checked = objParentCheckBox.checked;
            }
        }

        function Publish(ActivityAssociated,intProcessID,strLevelID)
        {
            var strAlert ="";
            if (ActivityAssociated==0 )
                {
                    if(strLevelID=="0|PS")
                        strAlert="No activity is associated to the process, \n Press 'OK' to publish the process."
                    else if(strLevelID=="0|CS")
                        strAlert="No checklist item is associated to the checklist, \n Press 'OK' to publish the checklist."
                    if (confirm(strAlert)==false)
                        return;
                }
                
                
             // window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizPublishProcess.aspx?Mode=ADD_NEW&UniqueID=" + intProcessID + "&PKID=" + strLevelID  ;
               if(strLevelID=="0|PS")
                    window.open("WhizPublishProcess.aspx?Mode=ADD_NEW&UniqueID=" + intProcessID + "&PKID=" + strLevelID  ,"Publish" ,"resizable=yes,scrollbars=no,left=" + ((window.screen.width - 575)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=575,height=400");
                else
                {
                    var objForm = GetFormReference('frmProcessDetails');
                     objForm.action ="../QC/WhizProcessDetails.aspx?PKID=0|CS&FROMWHERE=PM&ACTION=PUBLISHPROCESS&UniqueID=" + intProcessID;
                     objForm.submit();
                }
              
           
        }
        function ShowDetails(strLevelID,uniqueID)
        {
            window.open("WhizProcessDetails.aspx?Mode=VIEW&UniqueID=" + uniqueID + "&PKID=" + strLevelID  ,"" ,"resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 575)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=575,height=400,menubar=yes,statusbar=yes");
        }
        
        function GetLatest_OnClick(strProcessID , strProjectId,strUniqueID)
        {
            if(confirm("Process(es) Removed from the Project Type ,but still available for the Project will be deleted from Project. \nFor New or Revised Process(es) at Project Type ,latest data will be taken.\nPress 'Ok' to continue.")==true)
            {
                var objForm = GetFormReference('frmProcessDetails');
                objForm.action ="../QC/WhizProcessDetails.aspx?PKID=0|PS&FROMWHERE=PM&ACTION=GETLATEST&ProcessID_PK=" + strProcessID +  "&ProcessID=" + strUniqueID ;
                objForm.submit();
            }
        }
        function DeleteProjectProcess_OnClick(strProcessID , strProjectId, strUniqueID)
        {
            if(confirm("Process will be deleted from Project,changed data for that Process(es) will be lost.\nPress 'Ok' to continue.")==true)
            {
                var objForm = GetFormReference('frmProcessDetails');
                objForm.action ="../QC/WhizProcessDetails.aspx?PKID=0|PS&FROMWHERE=PM&ACTION=DELETEPROCESS&ProcessID_PK=" + strProcessID + "&ProcessID=" + strUniqueID;
                objForm.submit();                
            }

        }
        
        function ViewProjectProcess_OnClick(strProcessID , strProjectId)
        {
            window.open("../QC/WhizProcessDetails.aspx?PKID=0|PS&FROMWHERE=PM&MODE=VIEW&ProcessID=" + strProcessID  ,"" ,"resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=800,height=600,menubar=yes,statusbar=yes" );
        }
        
        function TailoringAndDeviation(strSDLCId , strProcessID , strProjectId , strActivityID ,strSingleProcess )
        {
            window.open("../QC/WhizActivityTailoringDaviation.aspx?PKID=0|PS&FROMWHERE=PM&MODE=VIEW&ProcessID=" + strProcessID + "&ProjectID=" + strProjectId + "&ActivityID=" + strActivityID + "&singleProcesses=" + strSingleProcess + "&SDLCID=" + strSDLCId ,"_self" ,"resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=800,height=600,menubar=yes,statusbar=yes" );
        }
        function ShowProcessView( strProcessID )
        {
            window.open("../QC/WhizProcessDetails.aspx?PKID=" + strProcessID + "&MODE=VIEW","","resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=750,height=500,menubar=yes,statusbar=yes" );
        }
    </script>
</head>

<body  class='clsBody' onload='window_onload()' onresize='window_onresize()' >
    <form id="frmProcessDetails" runat="server" >
    <div id="DivMain" style="width:100%;overflow:auto;">
    <%GeneratePage(strLevelIdentifier)%>
    <input type="hidden" id="txtSelectedTasks" value="" />

    </div>
<script language="javascript" type="text/javascript" >
	    function window_onload()
	    {
	      // if("<%=strLevelIdentifier %>"!='0|PS')
	         //   return;
	        //ps-385
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','DivMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 450;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 450;
		    }
		    if (intDivHeight < 460)
			    intDivHeight = 460;
		    objdivlistPage.style.height = intDivHeight;}
	    } 
	     function window_onresize()
	    {
	      // if("<%=strLevelIdentifier %>"!='0|PS')
	         //   return;
	        //ps-385
	     
	        var objdivlistPage = GetObjectReference('frmProcessDetails','DivMain');
		    var intDivHeight ;
		    var intDivListPageHeight ;
		    var lc;
		    if (objdivlistPage != null) {
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 450;
		    }
		    else{
		    intDivHeight = window.innerHeight - objdivlistPage.offsetTop- 450;
		    }
		    if (intDivHeight < 460)
			    intDivHeight = 460;
		    objdivlistPage.style.height = intDivHeight;}
	    } 
	    
    </script>    
    </form>
</body>



</html>
