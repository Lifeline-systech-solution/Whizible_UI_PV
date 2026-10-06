<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Iterations_CommonPage.aspx.vb" Inherits="PbNIT.Iterations_CommonPage" %>

<script language="javascript">
/*function Save_OnClick()
{ //debugger;
if (!ValidateForm_HeaderSection()) { return;}

EnableControlsHeaderSection();

    var isValid =1; //debugger;
    var StartDate = GetObjectReference('frmCommonPage', 'StartDate').value;
    var EndDate = GetObjectReference('frmCommonPage', 'EndDate').value;
    var ReleaseID = GetObjectReference('frmCommonPage', 'ReleaseID').value;
    var Duration = 0
    var Velocity = 0
    if(GetObjectReference('frmCommonPage', 'IterationID_PK').value=='')
    {
        Duration = GetObjectReference('frmCommonPage', 'Duration').value;
        Velocity = GetObjectReference('frmCommonPage', 'Velocity').value;
        var arrSDate = GetObjectReference('frmCommonPage', 'FFE29587WHIZ_StartDate').value.split('/');
        var arrEDate = GetObjectReference('frmCommonPage', 'FFE29587WHIZ_EndDate').value.split('/');
        var SDate = arrSDate[1]+'/'+arrSDate[0]+'/'+arrSDate[2];
        var EDate = arrEDate[1]+'/'+arrEDate[0]+'/'+arrEDate[2];
        var d1 = new Date(SDate); var d2 = new Date(EDate);
        // The number of milliseconds in one day
        var ONE_DAY = 1000 * 60 * 60 * 24
        // Convert both dates to milliseconds
        var date1_ms = d1.getTime(); var date2_ms = d2.getTime();
        // Calculate the difference in milliseconds
        var difference_ms = Math.abs(date1_ms - date2_ms)
        // Convert back to days and return
        var diff = Math.round(difference_ms/ONE_DAY); if(Duration != 0)
        { 
            if(diff+1 < Duration || diff+1 > Duration) 
            {
                alert('Duration for iteration should be same as duration of start date and end date!');  
                return; 
            }
        }
    }
        var strUrl="../PM/AjaxCallIteration.aspx?Flag=Release&StartDate=" + StartDate +"&EndDate=" + EndDate +"&ID="+ReleaseID+"&Duration="+Duration+"&Velocity="+Velocity; 
        if (document.all)  
        {   
            objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
            objXHttp.onreadystatechange = HandlerOnReadyState; 
            objXHttp.open('GET',strUrl, false);  
            objXHttp.send();        
        }      
        else  
        {
        
            objXHttp = new XMLHttpRequest(); objXHttp.onreadystatechange = HandlerOnReadyState(); 
            objXHttp.open('GET',strUrl, false);   
            objXHttp.send(null);  
        }    
        var strDateMsg='';  
        var objXHttp; 
        var blnFlag = false; 
        var strText = new String();  
        var arrStr = new Array();   
        function HandlerOnReadyState()
        {	
            if (objXHttp.readyState==4)
            { 
                if (objXHttp.responseText != null) 
                {   
                    strText = objXHttp.responseText;  
                    arrStr = strText.split(','); 
                    strTextisValid = arrStr[0]; 
                    strTextReleaseStartDate = arrStr[1]; 
                    strTextReleaseEndDate = arrStr[2]; 
                    if (strTextisValid == 0)     
                    { 	
                        isValid = 0;
                        alert('Start Date and End Date should be between Release Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);
                        return;
                    } 
                    if(arrStr[3]!='Valid')
                    {
                        isValid = 0; 
                        alert(arrStr[3]); 
                        return;
                    } 
                }
            }
        }
        var objCurrentIterationStartDate =GetObjectReference('frmCommonPage','StartDate').value;
        var objCurrentIterationEndDate =GetObjectReference('frmCommonPage','EndDate').value;
        var objTaskMinStartDate = GetObjectReference('frmCommonPage','NonDatabase1').value;
        var objTaskMaxEndDate = GetObjectReference('frmCommonPage','NonDatabase2').value;
        if (compareDates(objTaskMaxEndDate,objCurrentIterationEndDate)==1)  
        {
            isValid=0
            alert('Iteration End Date should not be less than active scrum task(s) under this iteration Max End Date (' + objTaskMaxEndDate + ') on Project.');
            return; 
        }
        if (compareDates(objCurrentIterationStartDate,objTaskMinStartDate)==1)  
        {
            isValid=0
            alert('Iteration Start Date should not be greater than active Scrum Task(s) Min Start Date (' + objTaskMinStartDate + ') on Project.');
            return; 
        }
        if (isValid == 0)   
        {
            return;
        }
        else
        {
            var L1 = GetObjectReference('frmCommonPage','SAVEUI_HEAD0-8084');if (L1 != null) { L1.style.display= "none";}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_HEAD0-8084');if (L2 != null) { L2.style.display= "none";}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_HEAD0-8084');if (L3 != null) { L3.style.display= "none";}var L1 = GetObjectReference('frmCommonPage','SAVEUI_FOOT0-8084');if (L1 != null) { L1.style.display= "none";}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_FOOT0-8084');if (L2 != null) { L2.style.display= "none";}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_FOOT0-8084');if (L3 != null) { L3.style.display= "none";}
            objfrm.action="Iterations_CommonPage.aspx?Operation=SAVE&IterationID=&MasterTagID=8084&FromWhere=PM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1"
            objfrm.submit()
        }
        
        
        

}




function SaveAdd_OnClick()
{
    if (!ValidateForm_HeaderSection()) { return;}

    EnableControlsHeaderSection();

    var isValid =1; //debugger;
    var StartDate = GetObjectReference('frmCommonPage', 'StartDate').value;
    var EndDate = GetObjectReference('frmCommonPage', 'EndDate').value;
    var ReleaseID = GetObjectReference('frmCommonPage', 'ReleaseID').value;
    var Duration = 0
    var Velocity = 0
    if(GetObjectReference('frmCommonPage', 'IterationID_PK').value=='')
    {
        Duration = GetObjectReference('frmCommonPage', 'Duration').value;
        Velocity = GetObjectReference('frmCommonPage', 'Velocity').value;
        var arrSDate = GetObjectReference('frmCommonPage', 'FFE29587WHIZ_StartDate').value.split('/');
        var arrEDate = GetObjectReference('frmCommonPage', 'FFE29587WHIZ_EndDate').value.split('/');
        var SDate = arrSDate[1]+'/'+arrSDate[0]+'/'+arrSDate[2];
        var EDate = arrEDate[1]+'/'+arrEDate[0]+'/'+arrEDate[2];
        var d1 = new Date(SDate); var d2 = new Date(EDate);
        // The number of milliseconds in one day
        var ONE_DAY = 1000 * 60 * 60 * 24
        // Convert both dates to milliseconds
        var date1_ms = d1.getTime(); var date2_ms = d2.getTime();
        // Calculate the difference in milliseconds
        var difference_ms = Math.abs(date1_ms - date2_ms)
        // Convert back to days and return
        var diff = Math.round(difference_ms/ONE_DAY); if(Duration != 0)
        { 
            if(diff+1 < Duration || diff+1 > Duration) 
            {
                alert('Duration for iteration should be same as duration of start date and end date!');  
                return; 
            }
        }
    }
        var strUrl="../PM/AjaxCallIteration.aspx?Flag=Release&StartDate=" + StartDate +"&EndDate=" + EndDate +"&ID="+ReleaseID+"&Duration="+Duration+"&Velocity="+Velocity; 
        if (document.all)  
        {   
            objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
            objXHttp.onreadystatechange = HandlerOnReadyState; 
            objXHttp.open('GET',strUrl, false);  
            objXHttp.send();        
        }      
        else  
        {
        
            objXHttp = new XMLHttpRequest(); objXHttp.onreadystatechange = HandlerOnReadyState(); 
            objXHttp.open('GET',strUrl, false);   
            objXHttp.send(null);  
        }    
        var strDateMsg='';  
        var objXHttp; 
        var blnFlag = false; 
        var strText = new String();  
        var arrStr = new Array();   
        function HandlerOnReadyState()
        {	
            if (objXHttp.readyState==4)
            { 
                if (objXHttp.responseText != null) 
                {   
                    strText = objXHttp.responseText;  
                    arrStr = strText.split(','); 
                    strTextisValid = arrStr[0]; 
                    strTextReleaseStartDate = arrStr[1]; 
                    strTextReleaseEndDate = arrStr[2]; 
                    if (strTextisValid == 0)     
                    { 	
                        isValid = 0;
                        alert('Start Date and End Date should be between Release Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);
                        return;
                    } 
                    if(arrStr[3]!='Valid')
                    {
                        isValid = 0; 
                        alert(arrStr[3]); 
                        return;
                    } 
                }
            }
        }
        var objCurrentIterationStartDate =GetObjectReference('frmCommonPage','StartDate').value;
        var objCurrentIterationEndDate =GetObjectReference('frmCommonPage','EndDate').value;
        var objTaskMinStartDate = GetObjectReference('frmCommonPage','NonDatabase1').value;
        var objTaskMaxEndDate = GetObjectReference('frmCommonPage','NonDatabase2').value;
        if (compareDates(objTaskMaxEndDate,objCurrentIterationEndDate)==1)  
        {
            isValid=0
            alert('Iteration End Date should not be less than active scrum task(s) under this iteration Max End Date (' + objTaskMaxEndDate + ') on Project.');
            return; 
        }
        if (compareDates(objCurrentIterationStartDate,objTaskMinStartDate)==1)  
        {
            isValid=0
            alert('Iteration Start Date should not be greater than active Scrum Task(s) Min Start Date (' + objTaskMinStartDate + ') on Project.');
            return; 
        }
        if (isValid == 0)   
        {
            return;
        }
        else
        {
            var L1 = GetObjectReference('frmCommonPage','SAVEUI_HEAD0-8084');if (L1 != null) { L1.style.display= "none";}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_HEAD0-8084');if (L2 != null) { L2.style.display= "none";}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_HEAD0-8084');if (L3 != null) { L3.style.display= "none";}var L1 = GetObjectReference('frmCommonPage','SAVEUI_FOOT0-8084');if (L1 != null) { L1.style.display= "none";}var L2 = GetObjectReference('frmCommonPage','SAVE_ADDUI_FOOT0-8084');if (L2 != null) { L2.style.display= "none";}var L3 = GetObjectReference('frmCommonPage','SAVE_CLOSEUI_FOOT0-8084');if (L3 != null) { L3.style.display= "none";}
            objfrm.action="Iterations_CommonPage.aspx?Operation=SAVE&SubOperation=ADD&Mode=&IterationID=1502406&MasterTagID=8084&FromWhere=PM&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0&PagingNumber=1"
            objfrm.submit()
        }
}
*/
</script>
	