<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuickTask.aspx.vb" Inherits="PbNIT.QuickTask" ValidateRequest="false" EnableViewState="true" %>

<!DOCTYPE HTML>
<html>
<%WritePageHead()%>
<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

    #QTasks TD
    {
        white-space: nowrap;
    }

    #QTasks TH
    {
        text-align: center;
    }

    .footerMenuTable
    {
        visibility: visible !important;
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


<%'Modified By NitinVS on 17 Mar 2007 for PMLifeLine SP 8 Regression Issue 11318 div resizing was not working%>
<body class="clsBody" ms_positioning="GridLayout" onload="window_onload()" onresize="window_onresize()">
    <%'End Modification By NitinVS on 17 Mar 2007 for PMLifeLine SP 8 Regression Issue 11318 div resizing was not working%>
    <form id="frmQuickTask" method="post" runat="server">

        <%WritePage()%>
    </form>
    <script language="javascript">
        var objTbl = GetObjectReference('frmQuickTask', 'QTasks');
        //var divPageDiv = GetObjectReference('frmQuickTask', 'PageDiv');
        var divPageDiv = GetObjectReference('frmQuickTask', 'divTblGrid');
        divTblGrid
        var LastRowNumber;
        var LastRowNumber = -1;
        var isInValid = 0;
        var EmployeeData;

        var deleteButtonHitCountMSSection = 0;
        var deleteButtonHitCountInputSection = 0;

        var noOfRows;
        var tabCountChange;
        var deleteArr = new Array();

        var objtxtHidRCMSSection = GetObjectReference('frmQuickTask', 'txtHidRC');

        if (objtxtHidRCMSSection != null)
            noOfRows = parseInt(objtxtHidRCMSSection.value);
        else
            noOfRows = 0;
        //IF Add Button is not clicked
        totalMSRowCount = noOfRows;
        var objtblMSSection = GetObjectReference('frmQuickTask', 'QTasks');
        var totalcount = objtblMSSection.rows.length - 1;
        var objForm = GetFormReference('frmQuickTask');

        var MaxNumber;
        var ValidateFlag = true;
        var bitLeave;
        var strHolidays = "<%=m_strHolidays%>";
        function CreateTasks_OnClick() {
           
            var blnIsRecordSelected = false;
            totalcount = totalcount + parseInt(deleteButtonHitCountMSSection);
            ValidateFlag = true;
            var returnValue = ValidateTasks();

            if (returnValue == false) {
                return;               
            }
            else if(returnValue== 'disallow'){
                return;
            }
            else{
                objForm.action = '../Home/QuickTask.aspx?ProjectID=<%=strProjectID%>&FromTimesheet=CreateTask&Action=CreateTask&RowCount=<%=TotalRowCount%>'
                objForm.submit();
            }

            // window.open('../Home/QuickValidate.aspx?FromWhere=PM', '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 1000)/2 + ',top=' + (window.screen.height - 800)/2 + ',width=1000,height=800');
        }
        function ValidateTasks()
        {

            var url;
            intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
            intCompanyWeekDays = <%=m_lngWeekDays%>;
            var intHolidays = 0;
            var bitHoliday = false;
            var dtCurrentStartDate, dtCurrentEndDate,dtHoliday, dtCurrentDate,strHolidayList,strMsg,strUrl;
            var ValidateRowCount = totalcount + parseInt(deleteButtonHitCountMSSection);
            var firstCall = false;
       
          
            for (var j = 1; j <= ValidateRowCount; j++) {

              

                var objImage = document.getElementById('validImage' + j);
                var objImageDel = document.getElementById('imgDelete_' + j);
                var objAnchorImage = document.getElementById('anchorImage_' + j);
                var objCopyImage = document.getElementById('copyImage' + j);


               
                var objTaskName = GetObjectReference('frmQuickTask', 'txtTaskName' + j);
                var objStartDate = GetObjectReference('frmQuickTask', 'txtStartDate' + j);
                var objEndDate = GetObjectReference('frmQuickTask', 'txtEndDate' + j);
                var objWorkHrs = GetObjectReference('frmQuickTask', 'txtWorkHrs' + j);
                var objTaskNotes = GetObjectReference('frmQuickTask', 'txtTaskNotes' + j);
                var objDeliverableID = GetObjectReference('frmQuickTask', 'txtDeliverableID' + j);
                var objResource = GetObjectReference('frmQuickTask', 'cboResource' + j);
                var objBillable = GetObjectReference('frmQuickTask', 'chkBillable' + j);
                var objModuleID = GetObjectReference('frmQuickTask', 'cboModuleID' + j);
                var objSubProjectID = GetObjectReference('frmQuickTask', 'cboSubProjectID' + j);
                var objMilestoneID = GetObjectReference('frmQuickTask', 'cboMilestoneID' + j);
                var objChangeRequestID = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + j);
                var objPriority = GetObjectReference('frmQuickTask', 'cboPriority' + j);
                var objTaskType = GetObjectReference('frmQuickTask', 'cboTaskType' + j);
                var objPhaseID = GetObjectReference('frmQuickTask', 'cboPhaseID' + j);

                if(objStartDate!=null)
                    dtCurrentStartDate = getDate(objStartDate.value);

                if(objEndDate!=null)
                    dtCurrentEndDate = getDate(objEndDate.value);
                if(objTaskName!=null)
                {
                    if (disallowSpecialCharacters(objTaskName,"Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in &#39;Task Name&#39; ",true,'[@/:*?+\';\"<|{}^#&%[,\\\\]')) 
                    {
                        objTaskName.focus(); 
                        return 'disallow';
                    }
                    if(objTaskName.value.indexOf(']')>=0) 
                    {
                        alert("Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in 'Task Name'");
                        objTaskName.focus(); 
                        return 'disallow';
                    }
                }

                if(objTaskNotes!=null)
                {
                    if (disallowSpecialCharacters(objTaskNotes,"Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in &#39;Task Notes&#39; ",true,'[@/:*?+\';\"<|{}^#&%[,\\\\]')) 
                    {
                        objTaskNotes.focus(); 
                        return 'disallow';
                    }
                    if(objTaskNotes.value.indexOf(']')>=0) 
                    {
                        alert("Special characters " + '[@/:*?+\';\"<|{}^#&%[,\]'  + " are not allowed in 'Task Notes'");
                        objTaskNotes.focus(); 
                        return 'disallow';
                    }
                }
                if(objWorkHrs!=null)
                {
                    if (disallowNegativeNumeric(objWorkHrs,'Please enter only positive numeric value!!!',true)) 
                    { 
                        return 'disallow'; 
                    }
                }





                if (objImageDel != null) {

                    //Holiday Validation
                    if(objResource!=null)
                        var strResource = objResource.options[objResource.selectedIndex].text;
                    if(objStartDate!=null && objEndDate!=null)
                    {
                        if(objStartDate.value !='' && objEndDate.value!='')
                        {
                            if (strHolidays != "") {
                                strMsg = "" + strResource + ": The dates \n";
                                strHolidayList = strHolidays.split(',');
                                bitHoliday = false;
                                for (intCount = 0; intCount < strHolidayList.length - 1 ; intCount++) {
                                    intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
                                    for (intCnt = 0; intCnt <= intDays; intCnt++) {
                                        dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
                                        // If the holiday does not fall in the week end, then...
                                        if (DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
                                        {
                                            dtHoliday = getDate(strHolidayList[intCount]);
                                            //if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))

                                            //Integrated by MrugajaB on 30th APr 2005 for PMLifeLine SP3
                                            /*Added Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/
                                            if ((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
                                                //if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))
                                                /*End of Addition Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/ {
                                                bitHoliday = true;
                                                //Need the month string
                                                strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
                                                //Commented And Added By Chakshuta H on 19th-Nov-2015
                                                //strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
                                                strMsg = strMsg + "-" + dtCurrentDate.getFullYear() + "\n";
                                                //End Of Commented And Added By Chakshuta H on 19th-Nov-2015
                                                intHolidays = intHolidays + 1;
                                            }
                                        }
                                    }
                                }
                            }
                            //if (bitHoliday == true)			//Remove Comments after added the function DatePart
                            //{
                            //    if (!confirm(strMsg + "falling between the start date and end date for this task are holidays.\nDo you want to maintain the start and end date.\nOk = Save the selected dates.\nCancel = Go back to the previous screen without saving."))
                            //    {
                            //        ValidateFlag=false;
                            //        setFocus(objStartDate);
                            //        return false;
                            //    }
                            //}

                            var intCounter;
                            var strEmployeeList;
                            strEmployeeList='';
                            if (objResource!=null)
                            {
                                for(intCounter=0;intCounter < objResource.options.length;intCounter++)
                                {
                                    if(objResource.options[intCounter].selected==true)
                                    {
                                        strEmployeeList+= objResource.options[intCounter].value	+ ','
                                    }
				
                                }
                            }
                     
                       
                            strUrl = new String();
                            strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId=0&PROJECT_SETTINGS=<%=m_strProjectSetting%>&FromDate=" + encodeURIComponent(objStartDate.value) + "&ToDate=" + encodeURIComponent(objEndDate.value)+ "&EmployeeIDs=" + strEmployeeList ;

                            if (strResult == "")
                            {                               
                                if( generateRequest(strUrl) == false)
                                {
                                    ValidateFlag =  false;
                                }
                            }
                        }
                    }

                    if (firstCall == false) {
                        url = "Action=Validate&FromWhere=DB&RowNumber=" + j + "&IsFirst=1&MaxNumber=" + MaxNumber + "";
                        firstCall = true;
                    }
                    else {
                        url = "Action=Validate&FromWhere=DB&RowNumber=" + j + "&MaxNumber=" + MaxNumber + "";
                    }

                    if (objTaskName != null)
                        url += "&TaskName=" + objTaskName.value + ""
                    if (objStartDate != null)
                        url += "&StartDate=" + objStartDate.value + ""
                    if (objEndDate != null)
                        url += "&EndDate=" + objEndDate.value + ""
                    if (objWorkHrs != null)
                        url += "&WorkHrs=" + objWorkHrs.value + ""
                    if (objTaskNotes != null)
                        url += "&TaskNote=" + objTaskNotes.value + ""
                    if (objDeliverableID != null)
                        url += "&DeliverableID=" + objDeliverableID.value + ""
                    if (objResource != null)
                        url += "&Resource=" + objResource.value + ""
                    if (objBillable != null)
                        url += "&Billable=" + objBillable.value + ""
                    if (objModuleID != null)
                        url += "&ModuleID=" + objModuleID.value + ""
                    if (objSubProjectID != null)
                        url += "&SubProjectID=" + objSubProjectID.value + ""
                    if (objMilestoneID != null)
                        url += "&MilestoneID=" + objMilestoneID.value + ""
                    if (objChangeRequestID != null)
                        url += "&ChangeRequestID=" + objChangeRequestID.value + ""
                    if (objPriority != null)
                        url += "&Priority=" + objPriority.value + ""
                    if (objTaskType != null)
                        url += "&TaskType=" + objTaskType.value + ""
                    if (objPhaseID != null)
                        url += "&PhaseID=" + objPhaseID.value + ""

                    if (bitHoliday == true)
                        url += "&Holiday=true"
                    else
                        url += "&Holiday=false"

                    if (bitLeave == true)
                        url += "&Leave=true"
                    else
                        url += "&Leave=false"

                    if (objImageDel != null)
                        url += "&ImgDelete=" + objImageDel.value + ""

                    if (objAnchorImage != null) {
                        objAnchorImage.href = "javascript:ValidImage_OnClick(" + MaxNumber + ")";
                        MaxNumber = parseInt(MaxNumber) + 1;
                    }

                    if (objImage != null) {
                        EmployeeData = ValidateData(url, 0, 0, 0);

                        if (EmployeeData == 0) {
                            objImage.src = "../../Images/Home/wrongtick.png";
                            objCopyImage.src = ""
                            ValidateFlag = false;
                        }
                        else if(EmployeeData == 2){
                            objImage.src = "../../Images/Home/alertmark.png"
                            objCopyImage.src = "../../Images/Copy.gif"
                        }
                        else{
                            objImage.src = "../../Images/Home/righttick.jpg"
                            objCopyImage.src = "../../Images/Copy.gif"
                        }
                    }
                }

                                
            }

            if (ValidateFlag == false)
                return false;
            else
                return true;
          
        }


        function CreateRowForResource()
        {
            var strUrl = "Action=GetMaxNumber";
            MaxNumber = ValidateData(strUrl, 0, 0, 0);

            if (MaxNumber == '')
                MaxNumber = 0;
            else
                MaxNumber = parseInt(MaxNumber) + 1;

            var returnValue= ValidateTasks();

            if(returnValue == 'disallow')
            {
                return;
            }


            var strcombohtml;
            var startMandHTML = " ";
            var NewTR, NewTD;
            var NewTR1, newTD1;


            if (noOfRows == 0) {
                noOfRows = 1;
            }
            else
                noOfRows = noOfRows + 1;


            objtblMSSection = GetObjectReference('frmQuickTask', 'QTasks');
            totalcount = objtblMSSection.rows.length - 2;

            if (noOfRows == 0) {
                noOfRows = 1;
                totalcount = 1;
            }
            else {
                noOfRows = noOfRows + 1;
                totalcount = totalcount + 1;
            }

            totalcount = totalcount + parseInt(deleteButtonHitCountMSSection);
            objtxtHidRCMSSection.value = totalcount;
            tabCountChange = totalcount;
            NewTR = objtblMSSection.insertRow(objtblMSSection.rows.length - 1);
            NewTR.className = 'clsTREven';
            NewTR.id = 'TR' + totalcount;

            NewTD = NewTR.insertCell(0);
            NewTD.align = 'center';
            NewTD.title = 'Delete';
            NewTD.width = '1%';
            NewTD.innerHTML = "<td ><Input type=hidden name='txtMSSectionID" + totalcount + "' id='txtMSSectionID" + totalcount + "' value=0  /> <IMG ID='imgDelete" + totalcount + "' BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRowSection(this," + totalcount + ")'>";
            
            NewTD.innerHTML += "<Input type=hidden name='imgDelete_" + totalcount + "' id='imgDelete_" + totalcount + "' value='" + totalcount + "'  /></td>"

            //Select checkbox
            NewTD = NewTR.insertCell(1);
            NewTD.align = 'left';
           // strcombohtml = '<CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , False, , False, , True, False, , , , ).ToString.Replace("'", "\'")%>';
            //strcombohtml = strcombohtml.replace(/chkSelect/g, "chkSelect" + totalcount);
            //NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
            NewTD.innerHTML = NewTD.innerHTML + "<td><a id='anchorCopyimage_" + totalcount + "' href='javascript:CopyImage_OnClick(" + totalcount + ")'><img id='copyImage" + totalcount + "' src='' height='20px' width='20px' alt='Image'></img></a></td>"


            // var taskid = totalcount - 1;
            //TaskID
            NewTD = NewTR.insertCell(2);
            NewTD.align = 'left';
            NewTD.innerHTML = NewTD.innerHTML + "<td style='text-align:center;'><a id='anchorImage_" + totalcount + "' href='javascript:ValidImage_OnClick(" + MaxNumber + ")'><img id='validImage" + totalcount + "' src='' height='15px' width='15px' alt='Image'></img></a></td>"
           

            //Task Name
            NewTD = NewTR.insertCell(3);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 150, 255, , , , , , , , , True, True, , , , 1,EnableHTMLEncode:=True ).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtTaskName/g, "txtTaskName" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
            
            //Task Notes
            NewTD = NewTR.insertCell(4);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", , , , "frmQuickTask", , , 150, 40, 2000, , returnHTML:=True, Wrap:="Soft",EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtTaskNotes/g, "txtTaskNotes" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
            GetObjectReference('frmQuickTask','txtTaskNotes'+ totalcount).maxLength = 2000;

            //Resource
            NewTD = NewTR.insertCell(5);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboResource", "EXEC usp_Sel_CurrentTeamMembers " + m_lngProjectId.ToString(), 150, , , True, True, , True, , False).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/cboResource/g, "cboResource" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Work Hrs
            NewTD = NewTR.insertCell(6);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs", "txtWorkHrs", , 50, 6, , , , , , , , , True, True, , , , 1, ).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtWorkHrs/g, "txtWorkHrs" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Billable
            NewTD = NewTR.insertCell(7);
            NewTD.align = 'left';
            strcombohtml = '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", , , "ON", returnHTML:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/chkBillable/g, "chkBillable" + totalcount)
            NewTD.innerHTML = "<td style='text-align:center;'>" + strcombohtml + "</td>";

            //Start Date
            NewTD = NewTR.insertCell(8);
            NewTD.align = 'left';
            strcombohtml = '<%= CommonFunctions.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , 80, , , "frmQuickTask","../../images/Calendar.gif", returnHTML:=True, IsMandatory:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtStartDate/g, "txtStartDate" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //End Date
            NewTD = NewTR.insertCell(9);
            NewTD.align = 'left';
            strcombohtml = '<%= CommonFunctions.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , 80, , , "frmQuickTask", "../../images/Calendar.gif", returnHTML:=True, IsMandatory:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtEndDate/g, "txtEndDate" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Priority
            NewTD = NewTR.insertCell(10);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "EXEC usp_Sel_tbl_IB_Priorities", 150, , , True, ReturnAsHTML:=True, IsMandatory:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/cboPriority/g, "cboPriority" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Deliverable
            NewTD = NewTR.insertCell(11);
            NewTD.align = 'left';
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , 150, , , , , True, True, , , , True, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/txtDeliverableID/g, "txtDeliverableID" + totalcount)
            var strDelivarable = '<%=CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , "SelectDeliverable", 12, 12, , True)%>'
            strDelivarable = strDelivarable.replace(/SelectDeliverable/g, "SelectDeliverable("+totalcount +")")
            var strHiddenDeliverable = "<Input type=hidden name='txtHidDeliverableID" + totalcount + "' id='txtHidDeliverableID" + totalcount + "' />";
            NewTD.innerHTML = '<td>' + strcombohtml + strDelivarable + strHiddenDeliverable + '</td>';

            //Task Type
            NewTD = NewTR.insertCell(12);
            NewTD.align = 'left';
            //onChange=TaskTypeID_OnChange(value)
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "EXEC usp_Sel_tbl_PM_Project_TaskTypes_Names " + m_lngProjectId.ToString(), 150, , " ", True, ReturnAsHTML:=True, IsMandatory:=True).ToString.Replace("'", "\'")%>'
            strcombohtml = strcombohtml.replace(/cboTaskType/g, "cboTaskType" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Phase
            NewTD = NewTR.insertCell(13);
            NewTD.align = 'left';

            <% If m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 0) = True Then%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", "Exec usp_PRS_GetProjectPhasesForSQA " + m_lngProjectId.ToString(), 150,  , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_PHASE, 1)).ToString.Replace("'", "\'")%>'
            <%Else%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboPhaseID", "Exec usp_PRS_GetProjectPhasesForSQA " + m_lngProjectId.ToString(), 150, ,"disabled", True, True).ToString.Replace("'", "\'")%>'
            <%End If%>
            strcombohtml = strcombohtml.replace(/cboPhaseID/g, "cboPhaseID" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Module
            NewTD = NewTR.insertCell(14);
            NewTD.align = 'left';

            <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 0) Then%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", "Exec usp_Sel_tbl_PM_Module " + m_lngProjectId.ToString() + ",null,'A',null", 150, , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MODULE, 1)).ToString.Replace("'", "\'")%>'
            <%Else%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", "Exec usp_Sel_tbl_PM_Module " + m_lngProjectId.ToString() + ",null,'A',null", 150, , "disabled" , True, True).ToString.Replace("'", "\'")%>'
            <%End If%>

            strcombohtml = strcombohtml.replace(/cboModuleID/g, "cboModuleID" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //SubProject
            NewTD = NewTR.insertCell(15);
            NewTD.align = 'left';

            <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 0) Then%>
            strcombohtml = '<%= CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", "Exec usp_Sel_tbl_PM_SubProject " + m_lngProjectId.ToString() + ",null,'T',null", 150, , , True, True,,IsMandatory:= m_arrControlDetails(ControlIndex.CTRL_INDEX_SUBPROJECT, 1)).ToString.Replace("'", "\'")%>'
            <%Else%>
            strcombohtml = '<%= CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", "Exec usp_Sel_tbl_PM_SubProject " + m_lngProjectId.ToString() + ",null,'T',null", 150, , "disabled", True, True).ToString.Replace("'", "\'")%>'
            <%End If%>

            strcombohtml = strcombohtml.replace(/cboSubProjectID/g, "cboSubProjectID" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Milestone
            NewTD = NewTR.insertCell(16);
            NewTD.align = 'left';

            <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 0) Then%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", "Exec usp_Sel_tbl_PM_Milestones " + m_lngProjectId.ToString() + ",'T',null", 150, , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_MILESTONE, 1)).ToString.Replace("'", "\'")%>'
            <%Else%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", "Exec usp_Sel_tbl_PM_Milestones " + m_lngProjectId.ToString() + ",'T',null", 150, , "disabled", True, True).ToString.Replace("'", "\'")%>'
            <%End If%>

            strcombohtml = strcombohtml.replace(/cboMilestoneID/g, "cboMilestoneID" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';

            //Change Request
            NewTD = NewTR.insertCell(17);
            NewTD.align = 'left';

            <%If m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 0) Then%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "Exec usp_Sel_tbl_PM_ChangeRequest_Master "+ m_lngProjectId.ToString(), 150, , , True, True,,IsMandatory:=m_arrControlDetails(ControlIndex.CTRL_INDEX_CHANGEREQUEST, 1)).ToString.Replace("'", "\'")%>'
            <%Else%>
            strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "Exec usp_Sel_tbl_PM_ChangeRequest_Master "+ m_lngProjectId.ToString(), 150, ,  "disabled", True, True).ToString.Replace("'", "\'")%>'
            <%End If%>

            strcombohtml = strcombohtml.replace(/cboChangeRequestID/g, "cboChangeRequestID" + totalcount)
            NewTD.innerHTML = '<td>' + strcombohtml + '</td>';
 
        }
       
        function deleteRowSection(evt, deleteRow) {
            objtblMSSection.deleteRow(evt.parentNode.parentNode.rowIndex);
            deleteButtonHitCountMSSection = parseInt(deleteButtonHitCountMSSection) + 1;
            noOfRows = noOfRows - 1;
            totalcount = totalcount - 1;
            deleteArr.push(deleteRow);
          
        }
        var g_sResponseText = '';
        var g_oValidateXMLHttp;
        function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
            //start .Added mode option in parameter list to the function         
            var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
            //End
            var strResult;
            var strNavigator;
            g_sResponseText = '';
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();


            strURL = "../Home/QuickTask.aspx?MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;


            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send();
            }
            else {
                // Mozilla - based browser 
                g_oValidateXMLHttp = new XMLHttpRequest();
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send(null);
            }
           
            if (g_oValidateXMLHttp.responseText != null) {
                strResult = g_oValidateXMLHttp.responseText;
            }
            return strResult;
        }
        function GetResponseText() {
            if (g_oValidateXMLHttp.readyState == 4) {
                if (g_oValidateXMLHttp.responseText != null) {
                    g_sResponseText = g_oValidateXMLHttp.responseText;
                }
            }
        }
        function ValidImage_OnClick(MaxNumber)
        {
          
            //window.open('../PM/QuickTask_Validate_CommonList.aspx?MasterTagID=20176&FromWhere=PM', '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 1000) / 2 + ',top=' + (window.screen.height - 800) / 2 + ',width=1000,height=800')
            window.open("../PM/QuickTask_Validate_CommonList.aspx?MasterTagID=20176&FromWhere=PM&TMSTaskID=" + MaxNumber + "", "", "resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - 990) / 2) + ",top=" + ((window.screen.height - 640) / 2) + ",width=990,height=640");
        }

        function SelectDeliverable(RowCount) {
            var objDeliverableID;
            objDeliverableID = document.getElementsByName('txtDeliverableID');
            if ("<%=FromTimesheet%>" != "CreateTask")
                window.open("../General/CommonList.aspx?MasterTagID=2176&FromWhere=QuickCreate&DeliverableID=0&RowCount="+ RowCount +"","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
            else
                window.open("../General/CommonList.aspx?FromTimesheet=CreateTask&ProjectID=<%=m_lngProjectId%>&MasterTagID=2176&FromWhere=PM&DeliverableID=0", "","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=800,height=500");
        }
        function CopyImage_OnClick(RowNumber)
        {
           
            CreateRowForResource();

            var CopyRowNumber = totalcount ;

            //Copy Row Details
            
            var objTaskName1 = GetObjectReference('frmQuickTask', 'txtTaskName' + RowNumber);
            var objStartDate1 = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtStartDate' + RowNumber);
            var objEndDate1 = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtEndDate' + RowNumber);
            var objWorkHrs1 = GetObjectReference('frmQuickTask', 'txtWorkHrs' + RowNumber);
            var objTaskNotes1 = GetObjectReference('frmQuickTask', 'txtTaskNotes' + RowNumber);
            var objDeliverableID1 = GetObjectReference('frmQuickTask', 'txtDeliverableID' + RowNumber);
            var objHdnDeliverableID1 = GetObjectReference('frmQuickTask', 'txtHidDeliverableID' + RowNumber);
            var objResource1 = GetObjectReference('frmQuickTask', 'cboResource' + RowNumber);
            var objBillable1 = GetObjectReference('frmQuickTask', 'chkBillable' + RowNumber);
            var objModuleID1 = GetObjectReference('frmQuickTask', 'cboModuleID' + RowNumber);
            var objSubProjectID1 = GetObjectReference('frmQuickTask', 'cboSubProjectID' + RowNumber);
            var objMilestoneID1 = GetObjectReference('frmQuickTask', 'cboMilestoneID' + RowNumber);
            var objChangeRequestID1 = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + RowNumber);
            var objPriority1 = GetObjectReference('frmQuickTask', 'cboPriority' + RowNumber);
            var objTaskType1 = GetObjectReference('frmQuickTask', 'cboTaskType' + RowNumber);
            var objPhaseID1 = GetObjectReference('frmQuickTask', 'cboPhaseID' + RowNumber);

            //New Row in that data will be copy
            var objTaskName = GetObjectReference('frmQuickTask', 'txtTaskName' + CopyRowNumber);
            var objStartDate = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtStartDate' + CopyRowNumber);
            var objEndDate = GetObjectReference('frmQuickTask', 'FFE29587WHIZ_txtEndDate' + CopyRowNumber);
            var objWorkHrs = GetObjectReference('frmQuickTask', 'txtWorkHrs' + CopyRowNumber);
            var objTaskNotes = GetObjectReference('frmQuickTask', 'txtTaskNotes' + CopyRowNumber);
            var objDeliverableID = GetObjectReference('frmQuickTask', 'txtDeliverableID' + CopyRowNumber);
            var objHdnDeliverableID = GetObjectReference('frmQuickTask', 'txtHidDeliverableID' + CopyRowNumber);
            var objResource = GetObjectReference('frmQuickTask', 'cboResource' + CopyRowNumber);
            var objBillable = GetObjectReference('frmQuickTask', 'chkBillable' + CopyRowNumber);
            var objModuleID = GetObjectReference('frmQuickTask', 'cboModuleID' + CopyRowNumber);
            var objSubProjectID = GetObjectReference('frmQuickTask', 'cboSubProjectID' + CopyRowNumber);
            var objMilestoneID = GetObjectReference('frmQuickTask', 'cboMilestoneID' + CopyRowNumber);
            var objChangeRequestID = GetObjectReference('frmQuickTask', 'cboChangeRequestID' + CopyRowNumber);
            var objPriority = GetObjectReference('frmQuickTask', 'cboPriority' + CopyRowNumber);
            var objTaskType = GetObjectReference('frmQuickTask', 'cboTaskType' + CopyRowNumber);
            var objPhaseID = GetObjectReference('frmQuickTask', 'cboPhaseID' + CopyRowNumber);

            objTaskName.value =  objTaskName1.value;
            objTaskNotes.value = objTaskNotes1.value;
            //objResource.value = objResource1.value;
            objWorkHrs.value = objWorkHrs1.value;
            objBillable.checked = objBillable1.checked;
            objStartDate.value = objStartDate1.value;
            GetObjectReference('frmQuickTask', 'txtStartDate' + CopyRowNumber).value = GetObjectReference('frmQuickTask', 'txtStartDate' + RowNumber).value;
            objEndDate.value = objEndDate1.value;
            GetObjectReference('frmQuickTask', 'txtEndDate' + CopyRowNumber).value = GetObjectReference('frmQuickTask', 'txtEndDate' + RowNumber).value;
            objPriority.value = objPriority1.value;
            objDeliverableID.value = objDeliverableID1.value;
            objHdnDeliverableID.value = objHdnDeliverableID1.value;
            objTaskType.value =  objTaskType1.value;
            objPhaseID.value =  objPhaseID1.value;
            objModuleID.value = objModuleID1.value;
            objSubProjectID.value = objSubProjectID1.value;
            objMilestoneID.value = objMilestoneID1.value;
        }

        function window_onload() {
            var intDivHeight;
            var intDivHeightRisk;
            if (divPageDiv != null) {
               
                if (intDivHeight < 100) intDivHeight = 100;
             

                if (navigator.appName == 'Netscape') {
                    intDivHeight = window.innerHeight - divPageDiv.offsetTop - 5;
                }
                else {
                    intDivHeight = window.innerHeight - divPageDiv.offsetTop - 5;
                }
              
                divPageDiv.style.height = intDivHeight + 'px';
            }
            var ObjTd=window.frames.parent.document.getElementById('tdTree')
            var ObjImg=window.frames.parent.document.getElementById('ImgShowHide')
            var ObjLeftnavigation=window.frames.parent.document.getElementById('tblLeftNavigation')
              
            if(ObjTd!=null && ObjImg!=null)
            {
                
                ObjTd.style.display='none';
                ObjImg.src='../../Images/Home/RightMove.gif';
                ObjLeftnavigation.style.display='';
            }
        }
        var strResult='';
        var req; //PrashantD
        var g_objXHttp;
        function generateRequest(url) 
        { 								
				
            // TO SEE IF WE ARE RUNNING IN IE             
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            var browser = isIE();
            if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            { 
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send();
            }
                //added By Bharat T on 13th-Oct-2015
            else if(browser=='IE')
            {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send();
            }
                //End of Added By Bharat T on 13th-Oct-2015
            else
            {
							
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET",url, false);
                //finally send the call
                g_objXHttp.send(null);
								
                if ( g_objXHttp.responseText != null)
                {
                    xmlDoc= document.implementation.createDocument("","",null);
                    xmlDoc.async=false;
                    //xmlDoc.load(req.responseXML);
                    //if (browser == 'FF') // Added By Vaijat K on 20/11/2015
                    //xmlDoc.load(g_objXHttp.responseXML);
                    strResult=g_objXHttp.responseText;
                    if(save_onClick_2() == false)
                    {
                        ValidateFlag = false;                        
                        return false;
                    }
                }
								
            }
				
            //delete req; PrashantD
				
            
        } 
        //var objCbo = GetObjectReference(g_strFrm,g_strDependentCtrl);
		
			
        function state_change() 
        {
            var browser = isIE(); 
				
            if (g_objXHttp.readyState == 4) 
            {
					
                // Make sure request came back OK 
                //if (req.status == 200) 
                if (g_objXHttp.status == 200) 
                {
				 
                    if (window.ActiveXObject || "ActiveXObject" in window)
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async=false;
                        //xmlDoc.loadXML(req.responseText);
                        xmlDoc.loadXML(g_objXHttp.responseText);
												
                    }
                        // code for Mozilla, etc.
                    else if (document.implementation &&	document.implementation.createDocument)
                    {
                        xmlDoc= document.implementation.createDocument("","",null);
                        xmlDoc.async=false;
                    }
										

                    strResult=g_objXHttp.responseText;

                    if ( isIE() == 'IE') // Added By Vidya J ON 01/12/2015
                    {
                        if(save_onClick_2() == false)
                        {
                            return false;
                        }
                    }
                }					
            }				
        }
        function save_onClick_2()
        {
	    
            var objBaselineStartDate; //it was declared previously in Save_OnClick function. 
            bitLeave = false;
            if(strResult!=null)
            {
                if(strResult!='')
                {
					
                    strResult=strResult.split("<=>");
                    var intCount, Count;
                    
                    for(intCount=0;intCount<strResult.length;intCount++)
                    {
                        strLH=strResult[intCount];	
                        strLH=strLH.split("<==>");
                        for(Count=0;Count<strLH.length;Count++)
                        {	
                            if(strLH[Count]!='')
                            {
                                if(strLH[Count]!=' ')
                                {			
                                    strResult="";                                    
                                    bitLeave = true;
                                    return false;
                                    //if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
                                    //}
                                }
                            }		
                        }	
                    }
					
					
                }
            }
        }
    </script>
