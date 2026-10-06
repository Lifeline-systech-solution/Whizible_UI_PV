<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx.vb" Inherits="PbNIT.EffortsSplit_OSCombination_CommonList_20177_CommonList"%>

<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"type="text/javascript"></script>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->


<script src="../../responsive/responsive.js"></script>

<style>
  .clsGridTable tr.clsTRColumnHeader td
{
font-weight:normal !important;
}
/*.divListPageTag
{
 height:680px !important;
}*/
#divListTag
{   
    height:293px !important;      
}
/*Added By Bharat Tekade on 26th-Apr-2016 to increase the height of all tr on os page for gantt displaying purpose*/
#divListTag .clsGridTable tr:not(.clsTRColumnHeader)
{
    height:56px;
}

  
#GanttChart
{
    width:99.9%;
    text-align:right;
    z-index:99;
    position:relative;
    /*text-transform:uppercase;*/
    text-indent:65px;
}
    .Blank_1 
    {
          display:none;
    }
    .Blank_2
    {
          display:none;
    }
    .Blank_3 
    {
          display:none;
    }
/*Ended By Bharat Tekade on 26th-Apr-2016 to increase the height of all tr on os page for gantt displaying purpose*/
</style>

<script type="text/javascript">
    $(document).ready(function () {//debugger;     

        $(".clsComboBox").change(function () {
            //debugger;
            var SubProject = $('#SubProjectID').val();
            var Module = $('#ModuleID').val();
            var Phase = $('#PhaseID').val();
            var Deliverable = $('#Deliverableid').val();
            var Milestone = $('#MilestoneID').val();
            var OS = $('#OS').val();
            var PageName = 'OverallSchedule_GanttView.aspx';
            var projectid = '<%=Session("intProjectID")%>';

            if (isIE() == 'FF')
                var topPosition = $('#osNote').offset().top - 6;
            else
                var topPosition = $('#osNote').offset().top + 8;

            var querystring = "&SubProject=" + SubProject + "&Module=" + Module + "&Phase=" + Phase + "&Deliverable=" + Deliverable + "&Milestone=" + Milestone + "&OS=" + OS + "";

            if (isIE() == 'IE') {
                    if (parent.window.frames['ViewMain'].document != undefined)
                        parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&Mode=OSFILTER" + querystring + "";
            }
            else {                             
                parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId= " + projectid + "&GanttChartType=1&top=" + topPosition + "&Mode=OSFILTER" + querystring + "";
            }
        });
        $("#OS").keypress(function (e) {
            if (e.which == 13) {
                var SubProject = $('#SubProjectID').val();
                var Module = $('#ModuleID').val();
                var Phase = $('#PhaseID').val();
                var Deliverable = $('#Deliverableid').val();
                var Milestone = $('#MilestoneID').val();
                var OS = $('#OS').val();
                var PageName = 'OverallSchedule_GanttView.aspx';
                var projectid = '<%=Session("intProjectID")%>';
                if (isIE() == 'FF')
                    var topPosition = $('#osNote').offset().top - 6;
                else
                    var topPosition = $('#osNote').offset().top + 8;

            var querystring = "&SubProject=" + SubProject + "&Module=" + Module + "&Phase=" + Phase + "&Deliverable=" + Deliverable + "&Milestone=" + Milestone + "&OS=" + OS + "";

            if (isIE() == 'IE') {
                if (parent.window.frames['ViewMain'].document != undefined)
                    parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&Mode=OSFILTER" + querystring + "";
            }
            else {
                parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId= " + projectid + "&GanttChartType=1&top=" + topPosition + "&Mode=OSFILTER" + querystring + "";
            }
            }
        });
     
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        $('body').attr('MS_POSITIONING', 'GridLayout');
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
        ObjTd=window.frames.parent.document.getElementById('tdTree')
        ObjImg=window.frames.parent.document.getElementById('ImgShowHide')
        ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')
              
        if(ObjTd!=null && ObjImg!=null)
        {
                
                ObjTd.style.display='none';
                ObjImg.src = '../../Images/Home/RightMove.gif';
                ObjLeftnavigation.style.display='';
        }
        
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
    window.onload = function () {
        /*Start_Added_by_RachanaG_on_24/02/2011*/
        objdivlistPage = GetObjectReference('frmCommonList', 'divListPageTag')
        tempdivheightval = objdivlistPage.style.height;
             

        var intDivHeight;
        var divHeightFactor = 30;
        if (objdivlistPage != null) {
            if (isIE() == 'IE') {
                intDivHeight = window.innerHeight - objdivlistPage.offsetTop - divHeightFactor;
            }
            else {
                intDivHeight = window.innerHeight - objdivlistPage.offsetTop - divHeightFactor;
            }
            setTimeout(function(){
                objdivlistPage.style.height = intDivHeight + 'px';                
            },500)
           
        }
        /*End_Added_by_RachanaG_on_24/02/2011*/
    }
    window.onresize = function () {
        /*Start_Added_by_RachanaG_on_24/02/2011*/
        objdivlistPage = GetObjectReference('frmCommonList', 'divListPageTag')
        tempdivheightval = objdivlistPage.style.height;


        var intDivHeight;
        var divHeightFactor = 30;
        if (objdivlistPage != null) {
            if (isIE() == 'IE') {
                intDivHeight = window.innerHeight - objdivlistPage.offsetTop - divHeightFactor;
            }
            else {
                intDivHeight = window.innerHeight - objdivlistPage.offsetTop - divHeightFactor;
            }
            setTimeout(function () {
                objdivlistPage.style.height = intDivHeight + 'px';
            }, 500)

        }
        /*End_Added_by_RachanaG_on_24/02/2011*/
    }

        $(window).load(function () {
        // executes when complete page is fully loaded, including all frames, objects and images
        //alert("window is loaded");
        RemoveFrameLoader();
        var intDivHeight;
       

        var objdivlist = GetObjectReference('frmCommonList', 'divListTag');
       
        objdivlist.style.overflow = '';

        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 500;
        if (intDivHeight < 100) intDivHeight = 100;
    
        objdivlist.style.height = intDivHeight + 'px';
     

        //Added By Bharat Tekade on 27th-Apr-2016 to make os grid column header height accourding gantt view grid height
        if(isIE() == 'CR')
        {
            $('#divListTag .clsGridTable tr:not(.clsTRColumnHeader)').css('height', '55px');
        }
        if (isIE() == 'FF') {
            $('#divListTag .clsGridTable tr:not(.clsTRColumnHeader)').css('height', '63px');
        }
        
        //Ended By Bharat Tekade on 27th-Apr-2016 to make os grid column header height accourding gantt view grid height
    });
</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

<script language='javascript' src='../Enhancement/Customer_XMLHttp.js'></script>
<script language="javascript" type="text/javascript">

 function SaveBreakup()
        {//debugger;
            if(Validation() == false)
                return;
            var objfrm=GetFormReference('frmCommonList');
            objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Save";  
            objfrm.submit();  return;
          
        }
function SaveAsDraft(flag)
 {//debugger;

    //Modified By Bharat Tekade on 29th-APR-2016 to save data before baseline
    if (flag == 'setbaseline') {
        if (Validation() == false)
            return false;
    }
    else {
        if (Validation() == false)
            return;
    }
    //End of Modified By Bharat Tekade on 29th-APR-2016 to save data before baseline

            var objfrm=GetFormReference('frmCommonList');
            objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Draft";  
            objfrm.submit();  return;
          
        }
 function Setbaseline()
        {//debugger;
    
             //Chakshuta
             //Added By Bharat Tekade on 29th-APR-2016 to save data before baseline
     if (SaveAsDraft('setbaseline') == false)
         return;
   
             //End of Added By Bharat Tekade on 29th-APR-2016 to save data before baseline

           //Modified By Chakshuta H on 1st-Apr-2016 Purpose::Sem OS Enhancement
            var objfrm = GetFormReference('frmCommonList');
            if (confirm("If you want to set the baseline details to current details,click Ok.")) {
                objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Rebaseline";  
                objfrm.submit();  return;
            }
            else
            {
            if(Validation() == false)
              return;
            //Chakshuta
            var objOSIDs = GetObjectReference('frmCommonList','txtHidUniqueIDs',true);
            for(i=0;i<objOSIDs.length;i++)

            {  
                  strURL = "Action=ISALLDATAPRESENT&OverallScheduleID=" + objOSIDs[i].value + "";
                             strResult = ValidateData(strURL, 0, 0, 0);
                             if (strResult != '') {
                                 alert(strResult);
                                  return;  
                             }
            }

                objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Baseline";  
                objfrm.submit();  return;
            }

            //var objfrm=GetFormReference('frmCommonList');
            //objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=Baseline";  
            //objfrm.submit();  return;
            //End Of Modified By Chakshuta H on 1st-Apr-2016 Purpose::Sem OS Enhancement
          
 }
 function ImportBaseLine() {//debugger;
     //Added By Bharat Tekade on 05th-May-2016 to put confirm box
     if (confirm("Import baseline will affect only those combination that have been baselined previously, Do you still want to continue?")) {
         strURL = "Action=ImportBaseLine";
         strResult = ValidateData(strURL, 0, 0, 0);
         if (strResult != '') {
             alert(strResult);

         }
         var objfrm = GetFormReference('frmCommonList');
         //objfrm.action = "EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=ImportBaseLine";
         objfrm.submit(); return;
     }
     //End of Added By Bharat Tekade on 05th-May-2016 to put confirm box

 }
/*function CloseTasks()
        {debugger;
            //if(Validation() == false)
              // return;
            var objfrm=GetFormReference('frmCommonList');
            objfrm.action="EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?MasterTagID=20177&FromWhere=Enhancement&PagingAlphabet=-1&SortBy=OS&SortOrder=ASC&ParentTagID=0&FromCL=1&PagingNumber=1&Mode=CloseTasks";  
            objfrm.submit();  return;
          
        }*/
function Validation()
{//debugger;
var objOSIDs = GetObjectReference('frmCommonList','txtHidUniqueIDs',true);
var strProjectStartDate = '<%=strProjectStartDate%>'
var strProjectEndDate = '<%=strProjectEndDate%>'

 if (objOSIDs == null || objOSIDs.length == 0) 

   {alert('There are no items to save.');return false;}
 
    //Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)
         strURL = "Action=CHECKWBSDATES"
         strResult = ValidateData(strURL, 0, 0, 0);
         if (strResult != '') {
             alert(strResult);
             //                                  
             return false;
         }
    //End of Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)

    for(i=0;i<objOSIDs.length;i++)

    {  
       var objBaseLineStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtBaselineStartDate'+objOSIDs[i].value);
        //var objBaseLineStartDate = GetObjectReference('frmCommonList', 'txtBaselineStartDate'+objOSIDs[i].value);
       var objBaselineEndDate=GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtBaselineEndDate'+objOSIDs[i].value);
        //var objBaselineEndDate=GetObjectReference('frmCommonList', 'txtBaselineEndDate'+objOSIDs[i].value);
       var objActualStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtActualStartDate'+objOSIDs[i].value);
       var objActualEndDate=GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtActualEndDate'+objOSIDs[i].value);

       var objActualStartDate1 = GetObjectReference('frmCommonList', 'txtActualStartDate'+objOSIDs[i].value);
       var objActualEndDate1 =GetObjectReference('frmCommonList', 'txtActualEndDate'+objOSIDs[i].value);
       var objBaseLineStartDate1 = GetObjectReference('frmCommonList', 'txtBaselineStartDate'+objOSIDs[i].value);
       var objBaselineEndDate1 = GetObjectReference('frmCommonList', 'txtBaselineEndDate'+objOSIDs[i].value);
       var objBEfforts = GetObjectReference('frmCommonList', 'txtBaselineEfforts' + objOSIDs[i].value);


        //Added By Bharat Tekade on 28th-APR-2016 to validate current dates and efforts
       var objCurrentStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtCurrentStartDate' + objOSIDs[i].value);
       var objCurrentEndDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtCurrentEndDate' + objOSIDs[i].value);
       var objCurrentEfforts = GetObjectReference('frmCommonList', 'txtCurrentEfforts' + objOSIDs[i].value);

       var objCurrentStartDate1 = GetObjectReference('frmCommonList', 'txtCurrentStartDate' + objOSIDs[i].value);
       var objCurrentEndDate1 = GetObjectReference('frmCommonList', 'txtCurrentEndDate' + objOSIDs[i].value);
        //End of Added By Bharat Tekade on 28th-APR-2016 to validate current dates and efforts

            /*if(disallowDate1LessThanDate2(objBaselineEndDate1 , objBaseLineStartDate1) == true)
			
			{				
				alert("Baseline End Date cannot be less tha the baseline start date.");
				return false;
			}
            if(disallowDate1LessThanDate2(objActualEndDate1 , objActualStartDate1) == true)
			
			{
				
				alert("Actual End Date cannot be less tha the Actual start date.");
				return false;
			}*/

        //Commented and Added By Bharat Tekade on 28th-APR-2016 to move all validation of baseline to current
            //if(trimString(objBaseLineStartDate.value)=="")

            //    {   alert('Please Enter Baseline Start Date.');objBaseLineStartDate.focus();  return false;}
            //if(trimString(objBaselineEndDate.value)=="")

            //    {   alert('Please Enter Baseline End Date.');objBaselineEndDate.focus();  return false;}
 
            //if(trimString(objBEfforts.value)=="")

            //    {   alert('Please Enter Baseline Efforts.');objBEfforts.focus();  return false;} 

            //if((trimString(objBEfforts.value)=="0") ||(trimString(objBEfforts.value)=="0.00"))

        //{ alert('Baseline Efforts should not be zero.'); objBEfforts.focus(); return false; }
               if (trimString(objCurrentStartDate.value) == "")

               { alert('Please Enter Current Start Date.'); objCurrentStartDate.focus(); return false; }

               if (trimString(objCurrentEndDate.value) == "")

               { alert('Please Enter Current End Date.'); objCurrentEndDate.focus(); return false; }

               if (trimString(objCurrentEfforts.value) == "")

               { alert('Please Enter Current Efforts.'); objCurrentEfforts.focus(); return false; }

               if ((trimString(objCurrentEfforts.value) == "0") || (trimString(objCurrentEfforts.value) == "0.00"))

               { alert('Current Efforts should not be zero.'); objCurrentEfforts.focus(); return false; }
     

             ////if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '')
             ////   {
 
             ////               //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
             ////               strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value +"&ActualStartDate="+ objActualStartDate.value +"&ActualEndDate="+ objActualEndDate.value + "";
             ////               strResult = ValidateData(strURL,0,0,0); 
             ////               if(strResult != '')
             ////               {
             ////                   alert(strResult);
             ////                   //                                  
             ////                   return false;
             ////               }
             ////   }
             ////   if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '')
             ////   {//debugger;
 
                            
             ////               strURL="Action=VALIDATEBASELINEEFFORTSONSAVE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value +"&BaselineEfforts="+ objBEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
             ////               strResult = ValidateData(strURL,0,0,0); 
             ////               if(strResult != '')
             ////               {
             ////                   alert(strResult);
             ////                   //                                  
             ////                   return false;
             ////               }
        ////   }

               if (objCurrentStartDate.value != '' && objCurrentEndDate.value != '') {

                   //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
                   strURL = "Action=VALIDATEBASELINE&CurrentStartDate=" + objCurrentStartDate.value + "&CurrentEndDate=" + objCurrentEndDate.value + "&ActualStartDate=" + objActualStartDate.value + "&ActualEndDate=" + objActualEndDate.value + "";
                   strResult = ValidateData(strURL, 0, 0, 0);
                   if (strResult != '') {
                       alert(strResult);
                       //                                  
                       return false;
                   }
               }
               if (objCurrentStartDate.value != '' && objCurrentEndDate.value != '') {//debugger;


                   strURL = "Action=VALIDATEBASELINEEFFORTSONSAVE&CurrentStartDate=" + objCurrentStartDate.value + "&CurrentEndDate=" + objCurrentEndDate.value + "&CurrentEfforts=" + objCurrentEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
                   strResult = ValidateData(strURL, 0, 0, 0);
                   if (strResult != '') {
                       alert(strResult);
                       //                                  
                       return false;
                   }
               }

        //End of Commented and Added By Bharat Tekade on 28th-APR-2016 to move all validation of baseline to current
               
           /* if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

                {

                    var myDate1 = new Date(objBaseLineStartDate.value);

                    var myDate2 = new Date(objBaselineEndDate.value);

                    if (myDate1 > myDate2)

                    {

                        alert('Baseline End Date should not be less than Baseline Start Date.');

                        objBaseLineStartDate.focus();

                        return false;

                    }	
                    if (objBaseLineStartDate.value > objBaselineEndDate.value)
                    {
                        alert('Baseline End Date should not be less than Baseline Start Date.');

                        objBaseLineStartDate.focus();

                        return false;
                    }

                }	*/	
           /* if (objActualStartDate.value != '' && objActualEndDate.value != '') 

                {

                    var myDate1 = new Date(objActualStartDate.value);

                    var myDate2 = new Date(objActualEndDate.value);

                    if (myDate1 > myDate2)

                    {

                        alert('Actual End Date should not be less than Actual Start Date.');

                        objActualEndDate.focus();

                        return false;

                    }	

                }	*/	

               /*  if (objBaseLineStartDate.value != '' && strProjectStartDate != '') 

                {

                    var myDate1 = new Date(objBaseLineStartDate.value);

                    var myDate2 = new Date(strProjectStartDate);

                    if (myDate1 < myDate2)

                    {

                        alert('Baseline Start Date should not be less than Project Start Date.');

                        objBaseLineStartDate.focus();

                        return false;

                    }	

                }	*/
                /* if (objBaselineEndDate.value != '' && strProjectEndDate != '') 

                {

                    var myDate1 = new Date(objBaselineEndDate.value);

                    var myDate2 = new Date(strProjectEndDate);

                    if (myDate1 > myDate2)

                    {

                        alert('Baseline End Date should not be greater than Project End Date.');

                        objBaselineEndDate.focus();

                        return false;

                    }	

                }	*/

    }
}

function OnSave_Validation(intUniqueID)

{  //debugger; 

var strProjectStartDate = '<%=strProjectStartDate%>'
var strProjectEndDate = '<%=strProjectEndDate%>'

    var objOSIDs = GetObjectReference('frmCommonList','txtHidUniqueIDs',true);

    var objOSListIDs = GetObjectReference('frmCommonList','txtHidListUniqueIDs');

    var objNonPhaseRow  = GetObjectReference('frmCommonList','txtHidNonPhaseRow');

    var objhdnIsMPPAvailable  = GetObjectReference('frmCommonList','hdnIsMPPAvailable');

    

    var strOSListIDs ='';

    var objOnsite, objReuse, objOffshore, flag, flag1, ReuseEff, onsiteEff, offshoreEff, i, objBaseLineStartDate, objBaselineEndDate;

    //Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
    var objCurrentStartDate, objCurrentEndDate, objCurrentEfforts, varCurrentEfforts;
    var intCurrentEfforts = 0;
    //End of Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current


    var objBEfforts,varBEfforts,strhdnDeliverySubProgram,objActualworkingdays,objActualWork;

    flag=0;flag1=0;

    var intBaselineEfforts=0;

    var objArrDeliverySubProgram=new Array(); //objArrDeliverySubProgram[0]=BaseLineStartDate

    var i=0;                                 //objArrDeliverySubProgram[1]=BaseLineEndDate

    var blnflag=0;                           //objArrDeliverySubProgram[2]=BaseLineEfforts 

    var objhdnDeliverySubProgram = GetObjectReference('frmCommonList','hdnVerify_DeliverySubprogram');

    var MinDate,MaxDate;

	// added by mitesh on 11 oct 2010 for checking first row

    var flagmindt=0;flagmaxdt=0;

    if (objhdnDeliverySubProgram !=null)

    {

        strhdnDeliverySubProgram=objhdnDeliverySubProgram.value; 

        objArrDeliverySubProgram=strhdnDeliverySubProgram.split("#");    

    }    

    

   if (objOSIDs == null || objOSIDs.length == 0) 

   {alert('There are no items to save.');return false;}
 
    //Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)
   strURL = "Action=CHECKWBSDATES"
   strResult = ValidateData(strURL, 0, 0, 0);
   if (strResult != '') {
       alert(strResult);
       //                                  
       return false;
   }
    //End of Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)

    for(i=0;i<objOSIDs.length;i++)
    {  

        objBaseLineStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtBaselineStartDate'+objOSIDs[i].value);

        objBaselineEndDate=GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtBaselineEndDate'+objOSIDs[i].value);

        objOnsite = GetObjectReference('frmCommonList', 'txtOnsiteEfforts'+objOSIDs[i].value);

        objOffshore=GetObjectReference('frmCommonList', 'txtOffshoreEfforts'+objOSIDs[i].value);

        objReuse=GetObjectReference('frmCommonList', 'txtReuseEfforts'+objOSIDs[i].value);

        objBEfforts=GetObjectReference('frmCommonList', 'txtBaselineEfforts'+objOSIDs[i].value);

        objActualworkingdays=GetObjectReference('frmCommonList', 'txtActualworkingdays'+objOSIDs[i].value);

        objActualWork=GetObjectReference('frmCommonList', 'txtActualWork'+objOSIDs[i].value);
       var objActualStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtActualStartDate'+objOSIDs[i].value);
       var objActualEndDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtActualEndDate' + objOSIDs[i].value);

        //Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
       objCurrentStartDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtCurrentStartDate'+objOSIDs[i].value);
       objCurrentEndDate = GetObjectReference('frmCommonList', 'FFE29587WHIZ_txtCurrentEndDate' + objOSIDs[i].value);
       objCurrentEfforts = GetObjectReference('frmCommonList', 'txtCurrentEfforts' + objOSIDs[i].value);
        //End of Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current

       //Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
            ////     if(objBEfforts != null)
            ////    {            

            ////        if (disallowNegativeNumeric(objBEfforts,'Please enter only positive numeric value!!!',true))

            ////            { objBEfforts.focus(); return false; }    
            ////    }
            ////     if (objBaseLineStartDate != null )

            ////    {    

            ////        if(trimString(objBaseLineStartDate.value)=="")

            ////            {   alert('Please Enter Baseline Start Date.');objBaseLineStartDate.focus();  return false;}

            ////    }     
            ////    if (objBaselineEndDate != null )

            ////    {    

            ////        if(trimString(objBaselineEndDate.value)=="")

            ////            {   alert('Please Enter Baseline End Date.');objBaselineEndDate.focus();  return false;}

            ////    }  
            ////if(trimString(objBEfforts.value)=="")

            ////    {   alert('Please Enter Baseline Efforts.');objBEfforts.focus();  return false;} 

            ////if((trimString(objBEfforts.value)=="0") ||(trimString(objBEfforts.value)=="0.00"))

        ////{ alert('Baseline Efforts should not be zero.'); objBEfforts.focus(); return false; }

       if (objCurrentEfforts != null) {

           if (disallowNegativeNumeric(objCurrentEfforts, 'Please enter only positive numeric value!!!', true))

           { objCurrentEfforts.focus(); return false; }
       }
       if (objCurrentStartDate != null) {

           if (trimString(objCurrentStartDate.value) == "")

           { alert('Please Enter Current Start Date.'); objCurrentStartDate.focus(); return false; }

       }
       if (objCurrentEndDate != null) {

           if (trimString(objCurrentEndDate.value) == "")

           { alert('Please Enter Current End Date.'); objCurrentEndDate.focus(); return false; }

       }
       if (trimString(objCurrentEfforts.value) == "")

       { alert('Please Enter Current Efforts.'); objCurrentEfforts.focus(); return false; }

       if ((trimString(objCurrentEfforts.value) == "0") || (trimString(objCurrentEfforts.value) == "0.00"))

       { alert('Current Efforts should not be zero.'); objCurrentEfforts.focus(); return false; }

        //End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
  
                if(objActualworkingdays != null)

                {            

                    if (disallowNegativeNumeric(objActualworkingdays,'Please enter only positive numeric value!!!',true))

                        { objActualworkingdays.focus(); return false; }    
                }
                if (disallowNegativeNumeric(objBEfforts,'Please enter only positive numeric value!!!',true))

                {   objBEfforts.focus(); return false; }       
                if (disallowNegativeNumeric(objActualworkingdays,'Please enter only positive numeric value!!!',true))

                {   objActualworkingdays.focus(); return false; }      
                if (disallowNegativeNumeric(objActualWork,'Please enter only positive numeric value!!!',true))

                {   objActualWork.focus(); return false; }      


        //Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
                ////if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '')
                ////{
 
                ////            //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
                ////            strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value +"&ActualStartDate="+ objActualStartDate.value +"&ActualEndDate="+ objActualEndDate.value + "";

                ////            strResult = ValidateData(strURL,0,0,0); 
                ////            if(strResult != '')
                ////            {
                ////                alert(strResult);
                ////                //                                  
                ////                return false;
                ////            }
                ////}
                
                            
                ////            strURL="Action=VALIDATEBASELINEEFFORTSONSAVEASSNAP&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value +"&BaselineEfforts="+ objBEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
                ////            strResult = ValidateData(strURL,0,0,0); 
                ////            if(strResult != '')
                ////            {
                ////                alert(strResult);
                ////                //                                  
                ////                return false;
                ////            }
                ////            //Added By Chakshuta on 11th-Mar-2016 Purpose::OS Changes
                ////            strURL="Action=VALIDATEISDATABASELINED";
                ////            strResult = ValidateData(strURL,0,0,0); 
                ////            if(strResult != '')
                ////            {
                ////                alert(strResult);
                ////                //                                  
                ////                return false;
                ////            }
                ////            //End Of Addition By Chakshuta H
             
                ////if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '')
                ////{
 
                            
                ////            strURL="Action=VALIDATEBASELINEEFFORTS&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value +"&BaselineEfforts="+ objBEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
                ////            strResult = ValidateData(strURL,0,0,0); 
                ////            if(strResult != '')
                ////            {
                ////                alert(strResult);
                ////                //                                  
                ////                return false;
                ////            }
        ////}

                if (objCurrentStartDate.value != '' && objCurrentEndDate.value != '') {

                    //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
                    strURL = "Action=VALIDATEBASELINE&CurrentStartDate=" + objCurrentStartDate.value + "&CurrentEndDate=" + objCurrentEndDate.value + "&ActualStartDate=" + objActualStartDate.value + "&ActualEndDate=" + objActualEndDate.value + "";

                    strResult = ValidateData(strURL, 0, 0, 0);
                    if (strResult != '') {
                        alert(strResult);
                        //                                  
                        return false;
                    }
                }


                strURL = "Action=VALIDATEBASELINEEFFORTSONSAVEASSNAP&CurrentStartDate=" + objCurrentStartDate.value + "&CurrentEndDate=" + objCurrentEndDate.value + "&CurrentEfforts=" + objCurrentEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
                strResult = ValidateData(strURL, 0, 0, 0);
                if (strResult != '') {
                    alert(strResult);
                    //                                  
                    return false;
                }
        //Added By Chakshuta on 11th-Mar-2016 Purpose::OS Changes
                strURL = "Action=VALIDATEISDATABASELINED";
                strResult = ValidateData(strURL, 0, 0, 0);
                if (strResult != '') {
                    alert(strResult);
                    //                                  
                    return false;
                }
        //End Of Addition By Chakshuta H

                if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') {


                    strURL = "Action=VALIDATEBASELINEEFFORTS&BaseLineStartDate=" + objBaseLineStartDate.value + "&BaselineEndDate=" + objBaselineEndDate.value + "&BaselineEfforts=" + objBEfforts.value + "&OverallScheduleID=" + objOSIDs[i].value + "";
                    strResult = ValidateData(strURL, 0, 0, 0);
                    if (strResult != '') {
                        alert(strResult);
                        //                                  
                        return false;
                    }
                }

        //End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
                /*if (objBaseLineStartDate.value != '' && strProjectStartDate != '') 

                {

                    var myDate1 = new Date(objBaseLineStartDate.value);

                    var myDate2 = new Date(strProjectStartDate);

                    if (myDate1 < myDate2)

                    {

                        alert('Baseline Start Date should not be less than Project Start Date.');

                        objBaseLineStartDate.focus();

                        return;

                    }	

                }	*/
                 /*if (objBaselineEndDate.value != '' && strProjectEndDate != '') 

                {

                    var myDate1 = new Date(objBaselineEndDate.value);

                    var myDate2 = new Date(strProjectEndDate);

                    if (myDate1 > myDate2)

                    {

                        alert('Baseline End Date should not be greater than Project End Date.');

                        objBaselineEndDate.focus();

                        return;

                    }	

                }	*/
                /*if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

                {

                    var myDate1 = new Date(objBaseLineStartDate.value);

                    var myDate2 = new Date(objBaselineEndDate.value);

                    if (myDate1 > myDate2)

                    {

                        alert('Baseline End Date should not be less than Baseline Start Date.');

                        objBaseLineStartDate.focus();

                        return;

                    }	

                }*/		

                	
}
for(i=0;i<objOSIDs.length;i++)

    {  
        if(objNonPhaseRow !=null) 

        {   

            if (objNonPhaseRow.value==objOSIDs[i].value)

            {

                if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

                {

                    var myDate1 = new Date(objBaseLineStartDate.value);

                    var myDate2 = new Date(objBaselineEndDate.value);

                    if (myDate1 > myDate2)

                    {

                        //alert('Baseline End Date should not be less than Baseline Start Date.');

                        //objBaseLineStartDate.focus();

                       // return;

                    }	

                }		

                //Commented and Added By Bharat Tekade on 29th-Apr-2016 to move all validation of baseline to current
                //if(objBEfforts != null)

                //{            

                //    if (disallowNegativeNumeric(objBEfforts,'Please enter only positive numeric value!!!',true))

                //        { objBEfforts.focus(); return false; }    

                        

                //    if (objBEfforts.value=='') { varBEfforts=0;objBEfforts.value=0; }

                //    else  {varBEfforts=objBEfforts.value;}    

                //}     

                //intBaselineEfforts = parseFloat(intBaselineEfforts) + parseFloat(objBEfforts.value);

                if (objCurrentEfforts != null) {

                    if (disallowNegativeNumeric(objCurrentEfforts, 'Please enter only positive numeric value!!!', true))

                    { objCurrentEfforts.focus(); return false; }



                    if (objCurrentEfforts.value == '') { varCurrentEfforts = 0; objCurrentEfforts.value = 0; }

                    else { varCurrentEfforts = objBEfforts.value; }

                }
                intCurrentEfforts = parseFloat(intCurrentEfforts) + parseFloat(objCurrentEfforts.value);
                //End of Commented and Added By Bharat Tekade on 29th-Apr-2016 to move all validation of baseline to current                                                                              

                 	

                    if (objhdnDeliverySubProgram !=null)

                    {             

                        if(objArrDeliverySubProgram[0]!= '-1' ||objArrDeliverySubProgram[1]!= '-1')

                        {

                            if(objArrDeliverySubProgram[0]=='0' || objArrDeliverySubProgram[1]=='0' )

                            { alert("Approved Delivery Subprogram plan is not available.");return false; }  

                            if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

                            { 

                                var myDate1 = new Date(objArrDeliverySubProgram[0]);

                                var myDate2 = new Date(objArrDeliverySubProgram[1]);

            

                                if(i==0)

                                {      

                                    MinDate=new Date(objBaseLineStartDate.value) ;

                                    MaxDate=new Date(objBaselineEndDate.value) ;

   								// added by mitesh v on 11 oct 2010

                                    flagmindt=1;

                                    flagmaxdt=1;

                                }

                                else

                                {

                                    var myDate3 = new Date(objBaseLineStartDate.value);

                                    var myDate4 = new Date(objBaselineEndDate.value);                        

                                  

                                    if(MinDate>myDate3 || flagmindt==0)

                                    {

                                        MinDate=new Date(objBaseLineStartDate.value);                            

                                            flagmindt=1;

                                            }

                                

                                    if(MaxDate < myDate4 || flagmaxdt==0)

                                        {

                                        MaxDate=new Date(objBaselineEndDate.value);      

                                        flagmaxdt=1;

                                        }

                                        

                                }                     

                             }  

                         }

                     }         							             

                           

                continue;     

            }   

       }

 
        //Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
        ////if (objBaseLineStartDate != null )

        ////{    

        ////    if(trimString(objBaseLineStartDate.value)=="")

        ////        {   alert('Please Enter Baseline Start Date.');objBaseLineStartDate.focus();  return false;}

        ////}        

        ////if (objBaselineEndDate != null )

        ////{

        ////    if(trimString(objBaselineEndDate.value)=="")

        ////        {   alert('Please Enter Baseline End Date.');objBaselineEndDate.focus();  return false;}  

    ////} 

        ////if (objBEfforts != null) {

        ////    if (trimString(objBEfforts.value) == "")

        ////    { alert('Please Enter Baseline Efforts.'); objBEfforts.focus(); return false; }

        ////    if (trimString(objBEfforts.value) == "0")

        ////    { alert('Baseline Efforts should not be zero.'); objBEfforts.focus(); return false; }

        ////    if (disallowNegativeNumeric(objBEfforts, 'Please enter only positive numeric value!!!', true))

        ////    { objBEfforts.focus(); return false; }



        ////    if (objBEfforts.value == '') { varBEfforts = 0; objBEfforts.value = 0; }

        ////    else { varBEfforts = objBEfforts.value; }

        ////}

        if (objCurrentStartDate != null) {

            if (trimString(objCurrentStartDate.value) == "")

            { alert('Please Enter Current Start Date.'); objCurrentStartDate.focus(); return false; }

        }

        if (objCurrentEndDate != null) {

            if (trimString(objCurrentEndDate.value) == "")

            { alert('Please Enter Current End Date.'); objCurrentEndDate.focus(); return false; }

        }

    
   
        if (objCurrentEfforts != null)
        {                       

            if (trimString(objCurrentEfforts.value) == "")

            { alert('Please Enter Current Efforts.'); objCurrentEfforts.focus(); return false; }

            if (trimString(objCurrentEfforts.value) == "0")

            { alert('Current Efforts should not be zero.'); objCurrentEfforts.focus(); return false; }

            if (disallowNegativeNumeric(objCurrentEfforts, 'Please enter only positive numeric value!!!', true))

            { objCurrentEfforts.focus(); return false; }

                

            if (objCurrentEfforts.value == '') { varCurrentEfforts = 0; objCurrentEfforts.value = 0; }

            else { varCurrentEfforts = objCurrentEfforts.value; }

        }         
    //End of Commented and Added By Bharat Tekade on 28th-Apr-2016 to move all validation of baseline to current
        if (objBaseLineStartDate != null && objBaselineEndDate != null )

        {                

            if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

            {

                var myDate1 = new Date(objBaseLineStartDate.value);

                var myDate2 = new Date(objBaselineEndDate.value);

                if (myDate1 > myDate2)

                {

                    //alert('Baseline End Date should not be less than Baseline Start Date.');

                    //objBaseLineStartDate.focus();

                    //return false;

                }	

            }	

        }    	            

        if (objOnsite != null)

        {   

            if (disallowNonNumeric(objOnsite,'Please enter only positive numeric value!!!',true))

                {   objOnsite.focus();return false;}                         

            if (disallowNegativeNumeric(objOnsite,'Please enter only positive numeric value!!!',true))

                {   objOnsite.focus();return false;}

            if(trimString(objOnsite.value)=="")

                {   alert('Please Enter Onsite Effort %.'); objOnsite.focus(); return false;}

                

            if (objOnsite.value=='')    onsiteEff=0;

            else   onsiteEff=objOnsite.value;                                

        }  

        if (objOffshore != null)

        {  

            if(trimString(objOffshore.value)=="")

                {   alert('Please Enter Offshore Effort %.');objOffshore.focus();  return false;}   

            if (disallowNonNumeric(objOffshore,'Please enter only positive numeric value!!!',true))

                {   objOffshore.focus();return false;}

            if (disallowNegativeNumeric(objOffshore,'Please enter only positive numeric value!!!',true))

                {   objOffshore.focus();return false;}   

                

            if (objOffshore.value=='') offshoreEff=0;

            else   offshoreEff=objOffshore.value;                

        }

        if (objReuse != null)

        {                   

            if (disallowNonNumeric(objReuse,'Please enter only positive numeric value!!!',true))

                {objReuse.focus();return false;}

            if (disallowNegativeNumeric(objReuse,'Please enter only positive numeric value!!!',true))

                {objReuse.focus();return false;}

            

            if (objReuse.value=='')  { ReuseEff=0;objReuse.value=0; }

            else   {ReuseEff=objReuse.value;}                        

        }                       

        //Added By VijayD oN 5 Jan 2010 

        //Purpose : To check if Current Delivery Plan is between Approved Delivery SubProgram Plan   

        if (objhdnDeliverySubProgram !=null)

        {             

            if(objArrDeliverySubProgram[0]!= '-1' ||objArrDeliverySubProgram[1]!= '-1')

            {

                if(objArrDeliverySubProgram[0]=='0' || objArrDeliverySubProgram[1]=='0' )

                { alert("Approved Delivery Subprogram plan is not available.");return false; }  

                if (objBaseLineStartDate.value != '' && objBaselineEndDate.value != '') 

                { 

                    var myDate1 = new Date(objArrDeliverySubProgram[0]);

                    var myDate2 = new Date(objArrDeliverySubProgram[1]);

                    if(i==0)

                    {      

                        MinDate=new Date(objBaseLineStartDate.value) ;

                        MaxDate=new Date(objBaselineEndDate.value) ;

                       

                                    flagmindt=1;

                                    flagmaxdt=1;
                    }

                    else

                    {

                        var myDate3 = new Date(objBaseLineStartDate.value);

                        var myDate4 = new Date(objBaselineEndDate.value);                        

                 

                        if(MinDate>myDate3 ||  flagmindt==0)

                            {

                                    MinDate=new Date(objBaseLineStartDate.value);                            

                                  flagmindt=1;

                                  }

                    

                        if(MaxDate < myDate4 || flagmaxdt==0)

                        {

                            MaxDate=new Date(objBaselineEndDate.value);      

                            flagmaxdt=1;

                            }

                            

                    }                     

                 }  

             }

         }         							             

      


        if (parseFloat(onsiteEff)+parseFloat(offshoreEff)!=100)

        { flag=1;break; }

        if(parseFloat(ReuseEff) > parseFloat(varBEfforts))

        { flag1=1;break; }

       	

        intBaselineEfforts=parseFloat(intBaselineEfforts)+ parseFloat(objBEfforts.value);		

      
    }



    



    


    if (objhdnDeliverySubProgram !=null)

    {  
   
        var objTtlBaselineEfforts = GetObjectReference('frmCommonList','hdnVerify_TtlBaselineEfforts');
  
        if(objArrDeliverySubProgram[0]!= '-1' ||objArrDeliverySubProgram[1]!= '-1')

        {



            var myDate1 = new Date(objArrDeliverySubProgram[0]);

            var myDate2 = new Date(objArrDeliverySubProgram[1]);        

          
            if( MinDate<myDate1||  MaxDate>myDate2)
            {

                alert("Latest approved program plan has the details for all sub programs. Please ensure that the sub program's schedule matches with the corresponding details in program plan.");

                objBaseLineStartDate.focus();

                return false;            

            }

	if (Math.round(parseFloat(intBaselineEfforts)*Math.pow(10,2))/Math.pow(10,2)> Math.round((parseFloat(objArrDeliverySubProgram[2])-parseFloat(objTtlBaselineEfforts.value))*Math.pow(10,2))/Math.pow(10,2))
            {
          
                alert("Baseline Efforts should be less than or equal to approved Delivery Subprogram plan baseline Efforts.");            

                return false;

            }

        }

    }        

   


    if (parseFloat(intBaselineEfforts) >= 10000.0 && objhdnIsMPPAvailable.value=='0') // i.e (250*8*5).

    {

                    alert("Please use Microsoft Project Plan as a tool for scheduling in your project.");                         

    }

    

    return true;

}

function checkCalculate(rowCnt,option)
{
//debugger;
var strProjectStartDate = '<%=strProjectStartDate%>'
var strProjectEndDate = '<%=strProjectEndDate%>'

var objBaseOffshore = 'txtOffshoreBaselineEfforts'+rowCnt;
 var ObjOffshoreBaselineEfforts  = GetObjectReference('frmCommonList',objBaseOffshore);

 
 var  objOfshore = 'txtOffshoreEfforts'+rowCnt; 
 var ObjOfshoreEfforts  = GetObjectReference('frmCommonList',objOfshore);

 
 var  objBaseline = 'txtBaselineEfforts'+rowCnt; 
 var ObjBaselineEfforts  = GetObjectReference('frmCommonList',objBaseline);

var  objActualworking = 'txtActualworkingdays'+rowCnt; 
 var objActualworkingdays  = GetObjectReference('frmCommonList',objActualworking);

var  objActualeffort = 'txtActualWork'+rowCnt; 
 var objActualefforts  = GetObjectReference('frmCommonList',objActualeffort);

 var  objBaselineStart = 'FFE29587WHIZ_txtBaselineStartDate'+rowCnt; 
 var objBaselineStartDate  = GetObjectReference('frmCommonList',objBaselineStart);

 var  objBaselineEnd = 'FFE29587WHIZ_txtBaselineEndDate'+rowCnt; 
 var objBaselineEndDate  = GetObjectReference('frmCommonList',objBaselineEnd);
 
 var objOnshore = 'txtOnsiteEfforts'+rowCnt; 
 var ObjOnshoreEfforts  = GetObjectReference('frmCommonList',objOnshore);
 
  var objBaselineOnshore = 'txtOnshoreBaselineEfforts'+rowCnt; 
  var ObjOnshoreBaselineEfforts = GetObjectReference('frmCommonList', objBaselineOnshore);

    //Added By Bharat Tekade on 29th-APR-2016 to move all the validations from baseline to current
  var strCurrentEfforts = 'txtCurrentEfforts' + rowCnt;
  var objCurrentEfforts = GetObjectReference('frmCommonList', strCurrentEfforts);
    //End of Added By Bharat Tekade on 29th-APR-2016 to move all the validations from baseline to current
 
if (option==1)//Checking For 'offshore_befforts'
  {//debugger;

   if(isNaN(ObjOffshoreBaselineEfforts.value)){alert("Please enter numeric data!");ObjOffshoreBaselineEfforts.focus();}
  else
     {
     ObjOffshoreBaselineEfforts.value=isNaN(parseFloat(ObjOffshoreBaselineEfforts.value))? 0: parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2);
     ObjBaselineEfforts.value=isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value).toFixed(2);
 
       if (ObjBaselineEfforts.value != null )
           {
            // if (ObjBaselineEfforts.value != null)
    
                //{
                   if(ObjOffshoreBaselineEfforts.value != null )
                     {  
                   
                     if ( parseFloat(ObjOffshoreBaselineEfforts.value) > parseFloat(ObjBaselineEfforts.value))
                         {
                         alert("Offshore Baseline Efforts Can not be more than Baseline Efforts");
                        ObjOffshoreBaselineEfforts.focus();
                         return;
                        
                         }
                       
                   	     ObjOfshoreEfforts.value=((isNaN(parseFloat(ObjOffshoreBaselineEfforts.value))? 0: parseFloat(ObjOffshoreBaselineEfforts.value))/(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))* 100;
                         ObjOfshoreEfforts.value=isNaN(parseFloat(ObjOfshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOfshoreEfforts.value).toFixed(2);
                    
                        ObjOnshoreBaselineEfforts.value= parseFloat(ObjBaselineEfforts.value) - parseFloat(ObjOffshoreBaselineEfforts.value);
                        ObjOnshoreBaselineEfforts.value=isNaN(parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2))? 0: parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2);

                    
                         ObjOnshoreEfforts.value=((isNaN(parseFloat(ObjOnshoreBaselineEfforts.value))? 0: parseFloat(ObjOnshoreBaselineEfforts.value))/(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))* 100;
                         ObjOnshoreEfforts.value=isNaN(parseFloat(ObjOnshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOnshoreEfforts.value).toFixed(2);
                    
                     } 
                 //}
                 
            }
      else
     {
      ObjBaselineEfforts.value=0;
      ObjOnshoreBaselineEfforts.value=0;
     } 
   }
 }
else if (option==2)//Checking For offshore_percent 
   {
     if(isNaN(ObjOfshoreEfforts.value)){alert("Please enter numeric data");ObjOfshoreEfforts.focus();}
        else
            {
             ObjBaselineEfforts.value=isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value).toFixed(2);
             ObjOfshoreEfforts.value=isNaN(parseFloat(ObjOfshoreEfforts.value))? 0: parseFloat(ObjOfshoreEfforts.value).toFixed(2);

              if (ObjBaselineEfforts.value != null)
                  {
                    //if (ObjBaselineEfforts.value != null)
    
                      // {
                          if(ObjOfshoreEfforts.value != null )
                             {  
                               if ( parseFloat(ObjOfshoreEfforts.value) > parseFloat(100))
                                    {
                                     alert("Offshore Efforts % Can not be more than 100%");
                                     ObjOfshoreEfforts.focus();
                                      return;                        
                                     }
                             
            			       ObjOffshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOfshoreEfforts.value))? 0: parseFloat(ObjOfshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			                   ObjOffshoreBaselineEfforts.value=parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2);
                           
                           
                              ObjOnshoreEfforts.value= parseFloat(100) - parseFloat(ObjOfshoreEfforts.value);
                              ObjOnshoreEfforts.value=isNaN(parseFloat(ObjOnshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOnshoreEfforts.value).toFixed(2);

                              ObjOnshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOnshoreEfforts.value))? 0: parseFloat(ObjOnshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			                  ObjOnshoreBaselineEfforts.value=parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2);
                           
                          
                           
                             } 
                       // }
                  }
              else
               {

                 ObjOffshoreBaselineEfforts.value=0;
 
               } 

            }
    }


else if (option==3) //Checking For onsite_befforts
  {
    if(isNaN(ObjOnshoreBaselineEfforts.value)){alert("Please enter numeric data");ObjOnshoreBaselineEfforts.focus();}
      else
         {
          ObjBaselineEfforts.value=isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value).toFixed(2);
          ObjOnshoreBaselineEfforts.value=isNaN(parseFloat(ObjOnshoreBaselineEfforts.value))? 0: parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2);

          if (ObjBaselineEfforts.value != null)
              {
                //if (ObjBaselineEfforts.value != null)
                //{
                  if(ObjOnshoreBaselineEfforts.value != null )
                      {  
                      if ( parseFloat(ObjOnshoreBaselineEfforts.value) > parseFloat(ObjBaselineEfforts.value))
                           {
                            alert("Onsite  Baseline Efforts Can not be more than Baseline Efforts");
                            ObjOnshoreBaselineEfforts.focus();
                            return;
                           }
                         
            			 ObjOnshoreEfforts.value=((isNaN(parseFloat(ObjOnshoreBaselineEfforts.value))? 0: parseFloat(ObjOnshoreBaselineEfforts.value))/(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))* 100;
                         ObjOnshoreEfforts.value=isNaN(parseFloat(ObjOnshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOnshoreEfforts.value).toFixed(2);
                      
                        ObjOffshoreBaselineEfforts.value= parseFloat(ObjBaselineEfforts.value) - parseFloat(ObjOnshoreBaselineEfforts.value);
                        ObjOffshoreBaselineEfforts.value=isNaN(parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2))? 0: parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2);

                    
                         ObjOfshoreEfforts.value=((isNaN(parseFloat(ObjOffshoreBaselineEfforts.value))? 0: parseFloat(ObjOffshoreBaselineEfforts.value))/(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))* 100;
                         ObjOfshoreEfforts.value=isNaN(parseFloat(ObjOfshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOfshoreEfforts.value).toFixed(2);
                    
                      
                       } 
                 //}
             }
          else
       {
        ObjBaselineEfforts.focus();
       }
     }
  }

else if (option==4)//For Checking onsite_percent
{

   if(isNaN(ObjOnshoreEfforts.value)){alert("Please enter numeric data");ObjOnshoreEfforts.focus();}
    else
       {
       ObjBaselineEfforts.value=isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value).toFixed(2);
       ObjOnshoreEfforts.value=isNaN(parseFloat(ObjOnshoreEfforts.value))? 0: parseFloat(ObjOnshoreEfforts.value).toFixed(2);

      if (ObjBaselineEfforts.value != null)
          {
           //if (ObjBaselineEfforts.value != null)
            // {
              if(ObjOnshoreEfforts.value != null )
                {  
                  if ( parseFloat(ObjOnshoreEfforts.value) > parseFloat(100))
                         {
                           alert("Onsite Efforts % Can not be more than 100%");
                           ObjOnshoreEfforts.focus();
                           return;                        
                          }
                ObjOnshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOnshoreEfforts.value))? 0: parseFloat(ObjOnshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			    ObjOnshoreBaselineEfforts.value=parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2);
               
                ObjOfshoreEfforts.value= parseFloat(100) - parseFloat(ObjOnshoreEfforts.value);
                ObjOfshoreEfforts.value=isNaN(parseFloat(ObjOfshoreEfforts.value).toFixed(2))? 0: parseFloat(ObjOfshoreEfforts.value).toFixed(2);

                ObjOffshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOfshoreEfforts.value))? 0: parseFloat(ObjOfshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			    ObjOffshoreBaselineEfforts.value=parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2);                        
            
                } 
            // }
          }
      else
       {
        ObjOnshoreBaselineEfforts.value=0;
       } 
     }
 }
//Chakshuta
else if (option==6)//For Checking objActualworkingdays
{

   if(isNaN(objActualworkingdays.value)){alert("Please enter numeric data");objActualworkingdays.focus();}
    else
  {
     objActualworkingdays.value=isNaN(parseFloat(objActualworkingdays.value))? 0: parseFloat(objActualworkingdays.value).toFixed(2);}
      
    
 }
else if (option==7)//For Checking objActualefforts
{

   if(isNaN(objActualefforts.value)){alert("Please enter numeric data"); objActualefforts.focus();}
    else
  {
       objActualefforts.value = isNaN(parseFloat(objActualefforts.value)) ? 0 : parseFloat(objActualefforts.value).toFixed(2);
   }  
}
 //Added By Bharat Tekade on 29th-APR-2016 to move all validations of baseline to current
else if (option == 10)//For Checking objActualworkingdays
{
    if (isNaN(objCurrentEfforts.value)) { alert("Please enter numeric data"); objCurrentEfforts.focus(); }
    else
    {
        objCurrentEfforts.value = isNaN(parseFloat(objCurrentEfforts.value)) ? 0 : parseFloat(objCurrentEfforts.value).toFixed(2);
    }
}
// End of Added By Bharat Tekade on 29th-APR-2016 to move all validations of baseline to current
/*else if (option==8)//For Checking objBaselineStartDate
{
  
  	
    if (objBaselineStartDate.value != '' && strProjectStartDate != '') 

                {

                    var myDate1 = new Date(objBaselineStartDate.value);

                    var myDate2 = new Date(strProjectStartDate);

                    if (myDate1 < myDate2)

                    {

                        alert('Baseline Start Date should not be less than Project Start Date.');

                        objBaselineStartDate.focus();

                        return;

                    }	

                }		    
 }
else if (option==9)//For Checking objBaselineEndDate
{
  
  	
    if (objBaselineEndDate.value != '' && strProjectEndDate != '') 

                {

                    var myDate1 = new Date(objBaselineEndDate.value);

                    var myDate2 = new Date(strProjectEndDate);

                    if (myDate1 > myDate2)

                    {

                        alert('Baseline End Date should not be greater than Project End Date.');

                        objBaselineEndDate.focus();

                        return;

                    }	

                }		    
 }*/
//Chakshuta
else if (option==5)
{
//

   if(isNaN(ObjBaselineEfforts.value)){alert("Please enter numeric data");ObjBaselineEfforts.focus();}
  else
  {
     ObjBaselineEfforts.value=isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value).toFixed(2);
 
  if (ObjBaselineEfforts.value>0)
  {
  if((ObjOnshoreEfforts!=null)&&(ObjOfshoreEfforts!=null))
{
    if (ObjOnshoreEfforts.value > 100)
       {
         ObjOnshoreEfforts.focus();
         return;
       }
   if (ObjOfshoreEfforts.value > 100)
      {
       ObjOfshoreEfforts.focus();
       return;
      }
  
  }
   if (ObjBaselineEfforts.value != null)
    
       {
if((ObjOnshoreEfforts!=null)&&(ObjOfshoreEfforts!=null))
{
          if(ObjOnshoreEfforts.value != null )
           {  
            

			 ObjOnshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOnshoreEfforts.value))? 0: parseFloat(ObjOnshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			  ObjOnshoreBaselineEfforts.value=parseFloat(ObjOnshoreBaselineEfforts.value).toFixed(2);
           } 
           
           if(ObjOfshoreEfforts.value != null )
           {  
            

			 ObjOffshoreBaselineEfforts.value=((isNaN(parseFloat(ObjOfshoreEfforts.value))? 0: parseFloat(ObjOfshoreEfforts.value))*(isNaN(parseFloat(ObjBaselineEfforts.value))? 0: parseFloat(ObjBaselineEfforts.value) ))/ 100;
			  ObjOffshoreBaselineEfforts.value=parseFloat(ObjOffshoreBaselineEfforts.value).toFixed(2);
           } 
           
       }
}
       
       
       
 }
 else
 {

 //ObjOffshoreBaselineEfforts.value=0;
 //ObjOfshoreEfforts.value=0;
 //ObjBaselineEfforts.value=0;
 //ObjOnshoreEfforts.value=0;
 //ObjOnshoreBaselineEfforts.value=0;
 
 } 

}


}

   

}
 

   var tempdivheightval;

  // debugger;
     objtdShowHide_showHide_div = GetObjectReference('','imgShowHide');
    if (objtdShowHide_showHide_div !=null)
    {
        objTable1 = GetObjectReference('','tblFilter');
           if ((objtdShowHide_showHide_div.src).search('minus.gif')>0)
            {              
                if (objTable1 != null)
                    {objTable1.style.display='none';}
                objtdShowHide_showHide_div.src='../../Images/plus.gif'
               //    GetObjectReference('','txttemp').value = 1;

               
                              
            }
    }
        function showHide_div()
    {
            
          if ((objtdShowHide_showHide_div.src).search('plus.gif')>0)
            {
                if (objTable1 != null)
                     {objTable1.style.display='';}
                 objtdShowHide_showHide_div.src='../../Images/minus.gif'
               //    GetObjectReference('','txttemp').value = 1;
               
                /*Start_Added_by_RachanaG_on_24/02/2011*/
                objdivlistPage=GetObjectReference('frmCommonList','divListPageTag')
                tempdivheightval=objdivlistPage.style.height;
                                
                var intDivHeight ;
                var divHeightFactor=30;
                if (objdivlistPage != null) 
                {if (navigator.appName == 'Microsoft Internet Explorer'){
                intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - divHeightFactor;
		        }
		        else{
		        intDivHeight = window.innerHeight - objdivlistPage.offsetTop - divHeightFactor;
		        }
               objdivlistPage.style.height = intDivHeight;
		      		        }
              /*End_Added_by_RachanaG_on_24/02/2011*/
            
            }
       
          else if ((objtdShowHide_showHide_div.src).search('minus.gif')>0)
                   {  
                     // var reqID = GetObjectReference('','ACMRequestID_PK').value           
                        objtdShowHide_showHide_div.src='../../Images/plus.gif';
                          if (objTable1 != null)
                             {objTable1.style.display='none';}
                             
                              /*Start_Added_by_RachanaG_on_24/02/2011*/
                              objdivlistPage=GetObjectReference('frmCommonList','divListPageTag')
                               intDivHeight1 = window.innerHeight - objdivlistPage.offsetTop - 30;
                               //objdivlistPage.style.height = tempdivheightval;
                                objdivlistPage.style.height = intDivHeight1;
                             /*End_Added_by_RachanaG_on_24/02/2011*/
                             
                             
             }
            
            /*Added By Bharat Tekade on 26th-Apr-2016 to manage position of gantt chart grid*/
          var WhichPage;
          var Browser = isIE();

          var topPosition = $('#divListTag').offset().top;
          var PageName = 'OverallSchedule_GanttView.aspx';
          var projectid = '<%=Session("intProjectID")%>';
            
            //Added By Bharat T on 17th-May-2016
            var SubProject = $('#SubProjectID').val();
            var Module = $('#ModuleID').val();
            var Phase = $('#PhaseID').val();
            var Deliverable = $('#Deliverableid').val();
            var Milestone = $('#MilestoneID').val();
            var OS = $('#OS').val();           

            var querystring = "&SubProject=" + SubProject + "&Module=" + Module + "&Phase=" + Phase + "&Deliverable=" + Deliverable + "&Milestone=" + Milestone + "&OS=" + OS + "&Mode=OSFILTER";

            //End of Added By Bharat T on 17th-May-2016
            if (Browser == 'IE') {

                WhichPage = parent.window.frames['ViewMain'].document.location.href;
                if (WhichPage.indexOf('OverallSchedule_NetworkView') < 0)
                { 
                      if (parent.window.frames['ViewMain'].document != undefined)
                          parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                      parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                }
          }
          else {
              //alert(Browser);
                // parent.window.frames['ViewMain'].document.location.href = "../Home/ShowProjectDetails.aspx?projectId="+projectid+"";
                WhichPage = parent.window.frames['ViewMain'].src;

                if (WhichPage.indexOf('OverallSchedule_NetworkView') < 0) {
                    parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId= " + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                }
          }
            /*Ended By Bharat Tekade on 26th-Apr-2016 to manage position of gantt chart grid*/
         
        }
////

var tempdivheightval1;

   
     objtdShowHide_showHide_div1 = GetObjectReference('','imgShowHide1');
    if (objtdShowHide_showHide_div1 !=null)
    {
        objTable2 = GetObjectReference('','tblFilter1');
           if ((objtdShowHide_showHide_div1.src).search('minus.gif')>0)
            {              
                if (objTable2 != null)
                    {objTable2.style.display='none';}
                objtdShowHide_showHide_div1.src='../../Images/plus.gif'
               //    GetObjectReference('','txttemp').value = 1;
                
                              
            }
    }
        function showHide_div1()
        {
          if ((objtdShowHide_showHide_div1.src).search('plus.gif')>0)
            {
                if (objTable2 != null)
                     {objTable2.style.display='';}
                 objtdShowHide_showHide_div1.src='../../Images/minus.gif'
               //    GetObjectReference('','txttemp').value = 1;
               
                /*Start_Added_by_RachanaG_on_24/02/2011*/
                objdivlistPage1=GetObjectReference('frmCommonList','divListPageTag')
                tempdivheightval1=objdivlistPage1.style.height;
                                
                var intDivHeight1 ;
                var divHeightFactor1=30;
                if (objdivlistPage1 != null) 
                {if (navigator.appName == 'Microsoft Internet Explorer'){
                intDivHeight1 = document.body.offsetHeight - objdivlistPage1.offsetTop - divHeightFactor1;
		        }
		        else{
		        intDivHeight1 = window.innerHeight - objdivlistPage1.offsetTop - divHeightFactor1;
		        }
               objdivlistPage1.style.height = intDivHeight1;
		      		        }
                /*End_Added_by_RachanaG_on_24/02/2011*/
            }
       
          else if ((objtdShowHide_showHide_div1.src).search('minus.gif')>0)
                   {  
                     // var reqID = GetObjectReference('','ACMRequestID_PK').value           
                        objtdShowHide_showHide_div1.src='../../Images/plus.gif';
                          if (objTable2 != null)
                             {objTable2.style.display='none';}
                             
                              /*Start_Added_by_RachanaG_on_24/02/2011*/
                              objdivlistPage1=GetObjectReference('frmCommonList','divListPageTag')
                              intDivHeight1 = window.innerHeight - objdivlistPage1.offsetTop - 30;
                               //objdivlistPage1.style.height = tempdivheightval1;
                                objdivlistPage1.style.height = intDivHeight1;
                             /*End_Added_by_RachanaG_on_24/02/2011*/
                             
                             
             }
            /*Added By Bharat Tekade on 26th-Apr-2016 to manage position of gantt chart grid*/
          var WhichPage;
          var Browser = isIE();
          var topPosition = $('#divListTag').offset().top;
          var PageName = 'OverallSchedule_GanttView.aspx';
          var projectid = '<%=Session("intProjectID")%>';
            //Added By Bharat T on 17th-May-2016
            var SubProject = $('#SubProjectID').val();
            var Module = $('#ModuleID').val();
            var Phase = $('#PhaseID').val();
            var Deliverable = $('#Deliverableid').val();
            var Milestone = $('#MilestoneID').val();
            var OS = $('#OS').val();
                    

            var querystring = "&SubProject=" + SubProject + "&Module=" + Module + "&Phase=" + Phase + "&Deliverable=" + Deliverable + "&Milestone=" + Milestone + "&OS=" + OS + "&Mode=OSFILTER";
            
            //End of Added By Bharat T on 17th-May-2016
            if (Browser == 'IE') {

                WhichPage = parent.window.frames['ViewMain'].document.location.href;
                if (WhichPage.indexOf('OverallSchedule_NetworkView') < 0) {

                    if (parent.window.frames['ViewMain'].document != undefined)
                        parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                    parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                }
          }
          else {
              //alert(Browser);
                // parent.window.frames['ViewMain'].document.location.href = "../Home/ShowProjectDetails.aspx?projectId="+projectid+"";
                WhichPage = parent.window.frames['ViewMain'].src;

                if (WhichPage.indexOf('OverallSchedule_NetworkView') < 0) {
                    parent.window.frames['ViewMain'].src = "../Enhancement/" + PageName + "?projectId= " + projectid + "&GanttChartType=1&top=" + topPosition + "&From=PlusMinusClick" + querystring + "";
                }
          }
            /*Ended By Bharat Tekade on 26th-Apr-2016 to manage position of gantt chart grid*/
         
        }
        function CloseAllTasks(OverallScheduleID) {

             strURL = "Action=ISTIMESHEETENTRYPRESENT&OverallScheduleID="+ OverallScheduleID +"";
             strResult = ValidateData(strURL, 0, 0, 0);
             if (strResult != '') {
                 alert(strResult);
                  return;  
             }
            var objfrm = GetFormReference('frmCommonList');
            if (confirm("Do you really want to close all the Tasks?")) {
                objfrm.action = "../Enhancement/EffortsSplit_OSCombination_CommonList_20177_CommonList.aspx?Mode=CloseTasks&FromWhere=PM&MasterTagID=20177&OverallScheduleID=" + OverallScheduleID;
                objfrm.submit();
                alert("All the Tasks get closed successfully.");
                return;
            }
            else
                return;
        }
        function Details_OnClick(OverallScheduleID) {
                           window.open ("../Enhancement/ProjectTasksDetails.aspx?Action=TASKDETAILS&FromWhere=PM&OverallScheduleID=" + OverallScheduleID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=950,height=500");
                           // window.open ("../Enhancement/ProjectTasksDetails.aspx?FromWhere=PM&OverallScheduleID=" + OverallScheduleID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
                
              
        }
        function Details_OnClick1(OverallScheduleID) {
                           window.open ("../Enhancement/ProjectTasksDetails.aspx?Action=BASELINETASKS&FromWhere=PM&OverallScheduleID=" + OverallScheduleID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");                              
        }

    //Added By Bharat Tekade on 25th-Apr-2016
        function setFrameLoader() {

            //$("HTML").append("<div id='preloader'></div>");
            //$("HTML").append("<div id='fillDiv'></div>");

            //parent.frames[1].document.all.frmOSGanttView.innerHTML += "<div id='preloader'></div>";
            //parent.frames[1].document.all.frmOSGanttView.innerHTML += "<div id='fillDiv'></div>";
        }
        function RemoveFrameLoader() {
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            jQuery("#preloader").fadeOut("slow");
            jQuery("#fillDiv").fadeOut("slow");
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
        }
        function GanttView_OnClick(obj) {
                      
                var objImg = document.getElementById('imgHideShow');
                var objImgNetwork = document.getElementById('imgHideShowNetwork');

                var img = objImg.src;
                var Browser = isIE();

                if (img.indexOf("leftarrow") > 0) {

                    if (Browser == 'IE')
                        parent.window.frames['ViewMain'].document.location.href = '';
                    else
                        parent.window.frames['ViewMain'].src = '';

                    parent.document.getElementById("tdTree").style.display = "none";
                    //if (isIE() == "FF")
                    //    parent.document.getElementById("tblLeftNavigation").style.display = "block";
                    //else
                    var PageName = 'OverallSchedule_GanttView.aspx';
                    var projectid = '<%=Session("intProjectID")%>';

                    parent.document.getElementById("tblLeftNavigation").style.display = "";
                    parent.document.getElementById("ifTD").style.width = "55%";
                    parent.document.getElementById("ImgShowHide").setAttribute('src', '../../Images/Home/RightMove.gif');
                    //if (isIE() == "FF")
                    //    parent.document.getElementById("tdDot2").style.display = "block";
                    //else
                    parent.document.getElementById("tdDot2").style.display = "";
                    parent.document.getElementById("tdDot2").style.height = "100%";
                    parent.document.getElementById("tdDot2").style.width = "45%";
                    //$(document).parent().find("#tdDot2").animate({"width": "35%" },"slow");
                    $(parent.document.getElementById("ifTD")).append("<div id='preloader'></div> <div id='fillDiv'></div>");                   
                    // alert(parent.window.frames['ViewMain'].document.location.href="../Home/ShowProjectDetails.aspx?projectId="+projectid+"");
                    //Added By Bharat T on 17th-May-2016
                    var SubProject = $('#SubProjectID').val();
                    var Module = $('#ModuleID').val();
                    var Phase = $('#PhaseID').val();
                    var Deliverable = $('#Deliverableid').val();
                    var Milestone = $('#MilestoneID').val();
                    var OS = $('#OS').val();                                  

                    //End of Added By Bharat T on 17th-May-2016
                  
                    var topPosition = $('#divListTag').offset().top;

                    var querystring = "&SubProject=" + SubProject + "&Module=" + Module + "&Phase=" + Phase + "&Deliverable=" + Deliverable + "&Milestone=" + Milestone + "&OS=" + OS + "&Mode=OSFILTER";

                    var url = "../Enhancement/" + PageName + "?projectId= " + projectid + "&GanttChartType=1&top=" + topPosition + "" + querystring + "";
                   // debugger;
                   // setFrameLoader();
                    if (Browser == 'IE') {
                        if (parent.window.frames['ViewMain'].document != undefined)
                            parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "" + querystring + "";
                        parent.window.frames['ViewMain'].src = "" + PageName + "?projectId=" + projectid + "&GanttChartType=1&top=" + topPosition + "";
                    }
                    else {
                        //alert(Browser);
                        parent.window.frames['ViewMain'].src = url;
                    }

                    objImg.src = '../../Images/Home/rightarrow.png';
                    objImgNetwork.src = '../../Images/Home/leftarrow.png';
                }
                else {

                    if (parent.document.getElementById("tdDot2") != undefined) {
                        if (parent.document.getElementById("tdDot2").style.display != 'none') {
                            parent.document.getElementById("ifTD").style.width = "100%";
                            parent.document.getElementById("tdDot2").style.width = "0%";
                            parent.document.getElementById("tdDot2").style.display = "none"
                            parent.document.getElementById("tdTree").style.display = "";
                            parent.document.getElementById("tblLeftNavigation").style.display = "none";

                            objImg.src = '../../Images/Home/leftarrow.png';
                            objImgNetwork.src = '../../Images/Home/leftarrow.png';
                        }
                    }
                }
                         
        }
   
    //End of Added By Bharat Tekade on 25th-Apr-2016
    function expcoll(cell) {
        var showStyle = "inline-table";
        var className = cell.className;
        var classType = className.split("_")[0];
        var classID = className.split("_")[1];
        //var ctrlClass = ((className == "BaselineBlank") ? "Baseline" : "BaselineBlank");
        var ctrlClass = ((classType == "Blank") ? "ch" : "Blank") + "_" + classID;

        $("." + className).css("display", "none");
        if(isIE() == 'IE')
            $("." + ctrlClass).css("display", showStyle);
        else
            $("." + ctrlClass).css("display", "table-cell");
    }
    function expcoll_new(cell) {
        var showStyle = "inline-table";
        var className = cell.className;
        var classType = className.split("_")[0];
        var classID = className.split("_")[1];
        //var ctrlClass = ((className == "BaselineBlank") ? "Baseline" : "BaselineBlank");
        var ctrlClass = ((classType == "Blank") ? "ch" : "Blank") + "_" + classID;

        $("." + className).css("display", "none");
        if (isIE() == 'IE')
            $("." + ctrlClass).css("display", showStyle);
        else
            $("." + ctrlClass).css("display", "");
    }
    //Added By Aniruddh Gujar on 28-APr-2016 Purpose::To plot the network view
    function NetworkView_OnClick(obj) {
        
        var objImg = document.getElementById('imgHideShowNetwork');
        var objImgGantt = document.getElementById('imgHideShow');

        var img = objImg.src;
        var Browser = isIE();
      
        if (img.indexOf("leftarrow") > 0) {

            if (Browser == 'IE')
                parent.window.frames['ViewMain'].document.location.href = '';
            else
                parent.window.frames['ViewMain'].src = '';

            parent.document.getElementById("tdTree").style.display = "none";

            var PageName = 'OverallSchedule_NetworkView.aspx';
            var projectid = '<%=Session("intProjectID")%>';


                parent.document.getElementById("tblLeftNavigation").style.display = "";
                parent.document.getElementById("ifTD").style.width = "55%";
                parent.document.getElementById("ImgShowHide").setAttribute('src', '../../Images/Home/RightMove.gif');

                parent.document.getElementById("tdDot2").style.display = "";
                parent.document.getElementById("tdDot2").style.height = "100%";
                parent.document.getElementById("tdDot2").style.width = "45%";

                $(parent.document.getElementById("ifTD")).append("<div id='preloader'></div> <div id='fillDiv'></div>");

                var topPosition = $('#divListTag').offset().top;
                var url = "../Enhancement/" + PageName + "?projectId=" + projectid + "&FromWhere=Project";

                if (Browser == 'IE') {
                    if (parent.window.frames['ViewMain'].document != undefined)
                        parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&FromWhere=Project";
                    parent.window.frames['ViewMain'].src = "" + PageName + "?projectId=" + projectid + "&FromWhere=Project";
                }
                else {
                    parent.window.frames['ViewMain'].src = url;
                }

                objImg.src = '../../Images/Home/rightarrow.png';
                objImgGantt.src = '../../Images/Home/leftarrow.png';
            }
            else {

                if (parent.document.getElementById("tdDot2") != undefined) {
                    if (parent.document.getElementById("tdDot2").style.display != 'none') {
                        parent.document.getElementById("ifTD").style.width = "100%";
                        parent.document.getElementById("tdDot2").style.width = "0%";
                        parent.document.getElementById("tdDot2").style.display = "none"
                        parent.document.getElementById("tdTree").style.display = "";
                        parent.document.getElementById("tblLeftNavigation").style.display = "none";

                        objImg.src = '../../Images/Home/leftarrow.png';
                        objImgGantt.src = '../../Images/Home/leftarrow.png';
                    }
                }
            }
    }
    function Combination_OnClick(OverallScheduleID) {
       // window.open("../Enhancement/OverallSchedule_NetworkView.aspx?FromWhere=OSCOMBINATION&OverallScheduleID=" + OverallScheduleID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000) / 2 + ",top=" + (window.screen.height - 650) / 2 + ",width=1000,height=700");

        var objImg = document.getElementById('imgHideShowNetwork');
        var objImgGantt = document.getElementById('imgHideShow');

        var img = objImg.src;
        var imgGantt = objImgGantt.src;
        var Browser = isIE();

        if (img.indexOf("rightarrow") > 0) {
            objImg.src = '../../Images/Home/leftarrow.png';
        }
        if (imgGantt.indexOf("rightarrow") > 0) {
            objImgGantt.src = '../../Images/Home/leftarrow.png';
        }
        //if (img.indexOf("leftarrow") > 0) {

            if (Browser == 'IE')
                parent.window.frames['ViewMain'].document.location.href = '';
            else
                parent.window.frames['ViewMain'].src = '';

            parent.document.getElementById("tdTree").style.display = "none";

            var PageName = 'OverallSchedule_NetworkView.aspx';
            var projectid = '<%=Session("intProjectID")%>';


            parent.document.getElementById("tblLeftNavigation").style.display = "";
            parent.document.getElementById("ifTD").style.width = "55%";
            parent.document.getElementById("ImgShowHide").setAttribute('src', '../../Images/Home/RightMove.gif');

            parent.document.getElementById("tdDot2").style.display = "";
            parent.document.getElementById("tdDot2").style.height = "100%";
            parent.document.getElementById("tdDot2").style.width = "45%";

            var topPosition = $('#divListTag').offset().top;
            var url = "../Enhancement/" + PageName + "?projectId=" + projectid + "&FromWhere=OSCOMBINATION&OverallScheduleID=" + OverallScheduleID;

            if (Browser == 'IE') {
                if (parent.window.frames['ViewMain'].document != undefined)
                    parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "&FromWhere=OSCOMBINATION&OverallScheduleID=" + OverallScheduleID;
                parent.window.frames['ViewMain'].src = "" + PageName + "?projectId=" + projectid + "&FromWhere=OSCOMBINATION&OverallScheduleID=" + OverallScheduleID;
            }
            else {
                parent.window.frames['ViewMain'].src = url;
            }

            //objImg.src = '../../Images/Home/rightarrow.png';
            //objImgGantt.src = '../../Images/Home/leftarrow.png';
        //}
        //else {

        //    if (parent.document.getElementById("tdDot2") != undefined) {
        //        if (parent.document.getElementById("tdDot2").style.display != 'none') {
        //            parent.document.getElementById("ifTD").style.width = "100%";
        //            parent.document.getElementById("tdDot2").style.width = "0%";
        //            parent.document.getElementById("tdDot2").style.display = "none"
        //            parent.document.getElementById("tdTree").style.display = "";
        //            parent.document.getElementById("tblLeftNavigation").style.display = "none";

        //            //objImg.src = '../../Images/Home/leftarrow.png';
        //            //objImgGantt.src = '../../Images/Home/leftarrow.png';
        //        }
        //    }
        //}
    }
    //End of Added By Aniruddh Gujar on 28-APr-2016 Purpose::To plot the network view
    //Added By Bharat Tekade on 16th-May-2016 for clear baseline on os page
    function ClearBaselineOnClick()
    {
        window.open("../Enhancement/OverSchedule_ClearBaseline.aspx?Action=ClearBaselineDetails", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=950,height=500");
    }
    //End of Added By Bharat Tekade on 16th-May-2016 for clear baseline on os page

</script>