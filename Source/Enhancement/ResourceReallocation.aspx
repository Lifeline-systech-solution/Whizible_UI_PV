<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ResourceReallocation.aspx.vb"  Inherits="PbNIT.ResourceReallocation" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <% CommonFunctions.General.PlotPageHeadTag("Resource Reallocation")%>

    <style>
        /* Added By Gauri On 04th Sep 2024 For Alignment Issue */
        .clsTable{
            border-collapse: separate;
        }
        /* End of Added By Gauri On 04th Sep 2024 For Alignment Issue */
    </style>
<%--<body style="margin:0px;">--%>
    <form id="frmResourceReallocation" name="frmResourceReallocation" method="post" runat="server">
        <%PageInit%>	
    </form>
    <script language='javascript' src='../Enhancement/Customer_XMLHttp.js'></script>
    <script language= "javascript" type="text/javascript" >

        var objform = GetFormReference('frmResourceReallocation');
        var objDivMain=GetObjectReference('frmResourceReallocation','divList');
    var objStartDate, objEndDate;
    //objStartDate = GetObjectReference('frmResourceReallocation','txtStartDate');
    //objEndDate = GetObjectReference('frmResourceReallocation','txtEndDate');
   


    function IsEmpty(value,replaceValue)
    {
        if(value)
        {
            return value;
        }
        else
        {
            return replaceValue;
        }
    }
    function Controls_OnBlur(object)
    {
         if(object!=null)
         {
             if (disallowNegativeNumeric(object,"Please enter a numeric value")) 
             {
                object.value="";
                object.focus();   
                return false;
             } 
                            
             if (disallowSpecialCharacters(object,"Special characters are not allowed",true,'[@/:*?+\';\.">()^{}<|#&%[,\\\\]')) 
             {
                 object.focus(); 
                 return false;
             }

             if(object.value.indexOf(']')>=0) 
             {
                 alert("Special characters are not allowed");
                 object.focus(); 
                 return false;
             }
         }
    }
    function validateControls()
    {   
        var objStartDate = GetObjectReference('frmResourceReallocation', 'dtStartDate');
        var objEndDate = GetObjectReference('frmResourceReallocation', 'dtEndDate');
        var objAllocation = GetObjectReference('frmResourceReallocation', 'txtAllocation');
       
       
        
            if (disallowBlank(objAllocation, "Please Enter Allocation!")) {
                objAllocation.focus();
                return false;
            }
            //objTicketNumber.disabled = false;

            if (disallowBlank(objStartDate, "Please enter start date.")) {
                return false;
            }
            if (disallowBlank(objEndDate, "Please enter end date.")) {
                return false;
            }
           if (disallowDate1GreaterThanDate2(objStartDate, objEndDate)) {
               
               alert("Please enter 'End Date' greater than 'From Date'");
               return false;

            }
            if (disallowNonNumeric(objAllocation, "Allocation should be numeric only !", true))
                return false;
       
    
    }
    function Save_OnClick()
    {
        var chkCount;
        chkCount = 0;
        var iCount;
        var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
        for (iCount = 0; iCount < objSelect.length; iCount++) {
            if (objSelect[iCount].checked == true) {
                chkCount = chkCount + 1;
                break;
            }
        }
        if (chkCount < 1) {
            alert('Please select atleast one record!');
            return false;
        }

        if (Validate() != false)
          {                       
              
              objform.action = "ResourceReallocation.aspx?MasterTagID=22193&Action=Save";
              objform.submit();
         }
    }
    //function Save_OnClick(id) { //debugger;
    //    var strHREF;
    //    var objConfirm = GetObjectReference('frmAddTravelDetails', id);
        
    //    objform.action = "ResourceReallocation.aspx?MasterTagID=22193&Action=Save&EmployeeID="+ objConfirm;
    //    objform.submit();
    //    //if (objConfirm != null) {
    //    //    if (objConfirm.checked == true) {
    //    //        objConfirm.value = "1";
    //    //    }
    //    //    else {
    //    //        objConfirm.value = "0";
    //    //    }
    //    //}

        //}
    //function chkSelect_onclick(id) { //debugger;
    //    var strHREF;
    //    var objConfirm = GetObjectReference('frmResourceReallocation', id);
    //    //var objConfirm = GetObjectReference('frmAddTravelDetails','chkConfirm',true); 
    //    //var objTicket = GetObjectReference('frmAddTravelDetails',id);
    //    if (objConfirm != null) {
    //        if (objConfirm.checked == true) {
    //            objConfirm.value = "1";
    //        }
    //        else {
    //            objConfirm.value = "0";
    //        }
    //    }

        //}
    function Validate() {//debugger;	

        var objSec1_StartDate = GetObjectReference('frmResourceReallocation', 'dtStartDate');
        var objSec1_EndDate = GetObjectReference('frmResourceReallocation', 'dtEndDate');
        var objSec1_Allocation = GetObjectReference('frmResourceReallocation', 'txtPercAllocation');
        var objSec1_StartDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtStartDate');
        var objSec1_EndDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtEndDate');

        if ((objSec1_StartDate1.value == '') && (objSec1_EndDate1.value == '') && (objSec1_Allocation.value == '')) {

            var flagUnit = 0;
            var objtblMSSection = GetObjectReference('frmResourceReallocation', 'tbl_Page');
            //var totalcount = objtblMSSection.rows.length - 2;
            //totalcount = totalcount + parseInt(deleteButtonHitCountMSSection);
            //noOfRows = noOfRows + parseInt(deleteButtonHitCountMSSection);
            //GetObjectReference('', 'txtHidRC').value = noOfRows;
            var count = GetObjectReference('frmResourceReallocation', 'txtHidRC');
            var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
            //Added By rupali nimbalkar On:09 DEC 2014 Purpose:SIRO Phase3 issue fixing
            if (count.value == "0") {
                return false;
            }
            //End of Added By rupali nimbalkar On:09 DEC 2014 Purpose:SIRO Phase3 issue fixing
            var objResource, objRole;
            //alert(count.value);

            for (var j = 0; j < objSelect.length; j++) {
                var objIterator = 1;
                var objAllocation, objStartDate, objEndDate, objTravelModeID, objSourceLocationID, objDestinationLocationID, objTravelDate, objAmount
                var intMaxEntry;
                intMaxEntry = 24;
                //objAllocation = GetObjectReference('', 'txtAllocation' + j);
                //objStartDate = GetObjectReference('', 'txtStartDate' + j);
                //objEndDate = GetObjectReference('', 'txtEndDate' + j);
                var objStartDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtStartDate' + objSelect[j].value);
                var objEndDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtEndDate' + objSelect[j].value);
                var objAllocation = GetObjectReference('frmResourceReallocation', 'txtAllocation' + objSelect[j].value);
                //objAmount = GetObjectReference('', 'txtAmount' + j);
                counter = 0;


                
                    //objTicketNumber.disabled = false;

                    if (disallowBlank(objStartDate, "Please enter start date.")) {
                        return false;
                    }
                    if (disallowBlank(objEndDate, "Please enter end date.")) {
                        return false;
                    }
                    if (objAllocation != null) {
                        if (disallowBlank(objAllocation, "Please Enter Percent Allocation!")) {
                            objAllocation.focus();
                            return false;

                     if (objAllocation.value == '' || objAllocation.value == 0)
                     {
                         alert('Percent Allocation should be greater than 0'); return false;
                     }
                    }
                    //if (disallowDate1LessThanDate2(objEndDate, objStartDate, "'End Date' :" + objEndDate.value + " cannot be less than 'Start Date' :" + objStartDate.value) == true) {
                    //    //objEndDate.focus();
                    //    return false;
                    //}     
                    //if (disallowDate1GreaterThanDate2(objStartDate, objEndDate, "Please enter End Date not less than Start Date ") == true) {
                    //    return;
                    //}
                    if (disallowDate1GreaterThanDate2(objStartDate, objEndDate)) {

                        alert("Please enter 'End Date' greater than 'Start Date'");
                        return false;

                    }
                    if (disallowNonNumeric(objAllocation, "Percent Allocation should be numeric only !", true))
                        return false;
                    //if (objAllocation.value == '' || objAllocation.value == 0)
                    //{ alert('Resource percentage should be greater than 0'); return false; }
                    //Chakshuta
                    if (objStartDate.value != '' && objEndDate.value != '' && objAllocation.value != '') {
                        if (objSelect[j].checked == true) {
                            //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
                            //strURL = "Action=VALIDATESTARTDATERESOURCEREALLOC&StartDate=" + objStartDate.value + "&EndDate=" + objEndDate.value + "&EmployeeID=" + objSelect[j].value + "";
                            strURL = "Action=VALIDATESTARTDATERESOURCEREALLOC&StartDate=" + objStartDate.value + "&EndDate=" + objEndDate.value + "&hidValidateResAllocation=" + objAllocation.value + "&EmployeeID=" + objSelect[j].value + "";
                            strResult = ValidateData(strURL, 0, 0, 0);
                            if (strResult != '') {
                                alert(strResult);
                                //                                  
                                return false;
                            }
                        }
                    }
                    
                    //Chakshuta
                }

            }
        }
        else {
            //debugger;
            //Chakshuta

            //Chakshuta
            
            //objTicketNumber.disabled = false;

            if (disallowBlank(objSec1_StartDate1, "Please enter start date.")) {
                return false;
            }
            if (disallowBlank(objSec1_EndDate1, "Please enter end date.")) {
                return false;
            }
            //if (disallowDate1GreaterThanDate2(objSec1_StartDate, objSec1_EndDate)) {

            //    alert("Please enter 'End Date' greater than 'Start Date'");
            //    return false;

            //}
            if (disallowBlank(objSec1_Allocation, "Please Enter Percent Allocation!")) {
                objSec1_Allocation.focus();
                return false;
            }
            if (disallowNonNumeric(objSec1_Allocation, "Percent Allocation should be numeric only !", true))
                return false;

            //if (objSec1_Allocation.value == '' || objSec1_Allocation.value == 0)
            //{ alert('Percent Allocation should be greater than 0'); return false; }
            //Chakshuta
            //var chkCount;
            //chkCount = 0;
            //var iCount;
            //for (iCount = 0; iCount < objChkDelete.length; iCount++) {
            //    if (objChkDelete[iCount].checked == true) {
            //        chkCount = chkCount + 1;
            //        break;
            //    }
            //}
            //if (chkCount < 1) {
            //    alert('Please select atleast one record!');
            //    return false;
            //}
            var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
            for (var i = 0; i < objSelect.length; i++) {
                if (objSec1_StartDate1.value != '' && objSec1_EndDate1.value != '' && objSec1_Allocation.value != '') {
                    if (objSelect[i].checked == true) {
                        //chkCount = chkCount + 1;
                        //strURL="Action=VALIDATEBASELINE&BaseLineStartDate="+ objBaseLineStartDate.value +"&BaselineEndDate="+ objBaselineEndDate.value + "";
                        //strURL = "Action=VALIDATESTARTDATERESOURCEREALLOC&StartDate=" + objSec1_StartDate1.value + "&EndDate=" + objSec1_EndDate1.value + "&EmployeeID=" + objSelect[i].value + "";
                        strURL = "Action=VALIDATESTARTDATERESOURCEREALLOC&StartDate=" + objSec1_StartDate1.value + "&EndDate=" + objSec1_EndDate1.value + "&hidValidateResAllocation=" + objSec1_Allocation.value + "&EmployeeID=" + objSelect[i].value + "";
                        strResult = ValidateData(strURL, 0, 0, 0);
                        if (strResult != '') {
                            alert(strResult);
                            //                                  
                            return false;
                        }
                        
                    }
                }
            }
            //Chakshuta

           
        }

        }
  

    /*function chkSelect_onclick(objchkSelect) {
        debugger;
        var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
        var objSec1_StartDate = GetObjectReference('frmResourceReallocation', 'dtStartDate');
        var objSec1_EndDate = GetObjectReference('frmResourceReallocation', 'dtEndDate');
        var objSec1_Allocation = GetObjectReference('frmResourceReallocation', 'txtAllocation');

        for (var i = 0; i < objSelect.length; i++) {
            var objtxtStartDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtStartDate' + objSelect[i].value);
            var objtxtEndDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtEndDate' + objSelect[i].value);            
            var objAllocation = GetObjectReference('frmResourceReallocation', 'txtAllocation' + objSelect[i].value);

           // if (objSelect[i].checked == true) {
            if ((objSelect[i].checked == true) && (objSec1_StartDate.value == '') && (objSec1_EndDate.value == '') && (objSec1_Allocation.value == '')) {

                if (objtxtStartDate != null)
                    objtxtStartDate.disabled = false;
                    //setFocus(objtxtStartDate);

                if (objtxtEndDate != null)
                    objtxtEndDate.disabled = false;

                if (objAllocation != null)
                    objAllocation.disabled = false;

                //objform.action = "ResourceReallocation.aspx?MasterTagID=22193&Action=IsChecked&Select=1";
                //objform.submit();
                //objSelect[i].value = "1";
                //if(objchkESL!=null)	
                //	objchkESL.disabled=false;

            }
            else {
                if (objtxtStartDate != null)
                    objtxtStartDate.disabled = true;

                if (objtxtEndDate != null)
                    objtxtEndDate.disabled = true;

                if (objAllocation != null)
                    objAllocation.disabled = true;

                //objform.action = "ResourceReallocation.aspx?MasterTagID=22193&Action=IsChecked&Select = 0 ";
                //objform.submit();
               // objSelect[i].value = "0";
                //if(objchkESL!=null)		
                //	objchkESL.disabled=true;
            }
        }



    }*/
    function chkSelect_onclick(objchkSelect) {
        //debugger;
        var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
        var objSec1_StartDate = GetObjectReference('frmResourceReallocation', 'dtStartDate');
        var objSec1_EndDate = GetObjectReference('frmResourceReallocation', 'dtEndDate');
        var objSec1_StartDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtStartDate');
        var objSec1_EndDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtEndDate');
        
        var objSec1_Allocation = GetObjectReference('frmResourceReallocation', 'txtPercAllocation');

        for (var i = 0; i < objSelect.length; i++) {
            var objtxtStartDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtStartDate' + objSelect[i].value);
            var objtxtEndDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtEndDate' + objSelect[i].value);
            var objtxtStartDate1 = GetObjectReference('frmResourceReallocation', 'txtStartDate' + objSelect[i].value);
            var objtxtEndDate1 = GetObjectReference('frmResourceReallocation', 'txtEndDate' + objSelect[i].value);
            var objAllocation = GetObjectReference('frmResourceReallocation', 'txtAllocation' + objSelect[i].value);

            // if (objSelect[i].checked == true) {
            if ((objSelect[i].checked == true) && (objSec1_StartDate1.value == '') && (objSec1_EndDate1.value == '') && (objSec1_Allocation.value == '')) {

                if (objSec1_StartDate != null)
                    objSec1_StartDate.disabled = true;
                    objSec1_StartDate1.disabled = true;
                //setFocus(objtxtStartDate);

                if (objSec1_EndDate != null)
                    objSec1_EndDate.disabled = true;
                    objSec1_EndDate1.disabled = true;

                if (objSec1_Allocation != null)
                    objSec1_Allocation.disabled = true;

                break
                //if (objtxtStartDate != null)
                //    objtxtStartDate.disabled = false;
                //    objtxtStartDate1.disabled = false;

                //if (objtxtEndDate != null)
                //    objtxtEndDate.disabled = false;
                //    objtxtEndDate1.disabled = false;

                //if (objAllocation != null)
                //    objAllocation.disabled = false;
                //objform.action = "ResourceReallocation.aspx?MasterTagID=22193&Action=IsChecked&Select=1";
                //objform.submit();
                //objSelect[i].value = "1";
                //if(objchkESL!=null)	
                //	objchkESL.disabled=false;

            }
            else {
                if (objSec1_StartDate != null)
                    objSec1_StartDate.disabled = false;
                    objSec1_StartDate1.disabled = false;
                //setFocus(objtxtStartDate);

                if (objSec1_EndDate != null)
                    objSec1_EndDate.disabled = false;
                    objSec1_EndDate1.disabled = false;

                if (objSec1_Allocation != null)
                    objSec1_Allocation.disabled = false;

                //if (objtxtStartDate != null)
                //    objtxtStartDate.disabled = false;
                //    objtxtStartDate1.disabled = false;

                //if (objtxtEndDate != null)
                //    objtxtEndDate.disabled = false;
                //    objtxtEndDate1.disabled = false;

                //if (objAllocation != null)
                //    objAllocation.disabled = false;



                //objform.action = "ResourceReallocation.aspx?MasterTagID=22193&PTagID=1019&FromWhere=PM";
                //objform.submit();
                // objSelect[i].value = "0";
                //if(objchkESL!=null)		
                //	objchkESL.disabled=true;
            }
        }



    }
    function Date_OnClick(controlid,obj)
    {
        //debugger;
        //if (obj != null)
            //GetObjectReference('frmResourceReallocation', controlid).value = obj.value;

        var dateInputFormat='<%=CType(CommonFunctions.Application.InputeDateFormat, String)%>'
        var id = obj.id;

        if (obj != "1") 
        {
        //if (id != 'undefined') {
            DateControl_StandardOnblur('frmResourceReallocation', controlid, dateInputFormat, 'Invalid Date format or Invalid Date.');
        }
        var objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
        var objSec1_StartDate = GetObjectReference('frmResourceReallocation', 'dtStartDate');
        var objSec1_EndDate = GetObjectReference('frmResourceReallocation', 'dtEndDate');
        var objSec1_Allocation = GetObjectReference('frmResourceReallocation', 'txtPercAllocation');
        var objSec1_StartDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtStartDate');
        var objSec1_EndDate1 = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_dtEndDate');

        for (var i = 0; i < objSelect.length; i++) {
            var objtxtStartDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtStartDate' + objSelect[i].value);
            var objtxtEndDate = GetObjectReference('frmResourceReallocation', 'FFE29587WHIZ_txtEndDate' + objSelect[i].value);
            var objtxtStartDate1 = GetObjectReference('frmResourceReallocation', 'txtStartDate' + objSelect[i].value);
            var objtxtEndDate1 = GetObjectReference('frmResourceReallocation', 'txtEndDate' + objSelect[i].value);
            var objAllocation = GetObjectReference('frmResourceReallocation', 'txtAllocation' + objSelect[i].value);
            // if (objSelect[i].checked == true) {
            if ((objSec1_StartDate1.value != '') || (objSec1_EndDate1.value != '') || (objSec1_Allocation.value != '')) {

                if (objtxtStartDate != null)
                    objtxtStartDate.disabled = true;
                    objtxtStartDate1.disabled = true;
                    //objtxtStartDate.style.backgroundColor = "lightgray"
                //objtxtStartDate1.style.backgroundColor = "lightgray"
                //objtxtStartDate.style.fontWeight="bold";
                //objtxtStartDate1.style.fontWeight="bold";

                if (objtxtEndDate != null)
                    objtxtEndDate.disabled = true;
                    objtxtEndDate1.disabled = true;
               
                    //objtxtEndDate.style.backgroundColor = "lightgray"
                    //objtxtEndDate1.style.backgroundColor = "lightgray"

                if (objAllocation != null)
                    objAllocation.disabled = true;
                //objAllocation.style.backgroundcolor = "lightgray;";

            }
              else {
                if (objtxtStartDate != null)
                    objtxtStartDate.disabled = false;
                    objtxtStartDate1.disabled = false;
                    //objtxtStartDate.style.backgroundColor = "white"
                    //objtxtStartDate1.style.backgroundColor = "white"

                if (objtxtEndDate != null)
                    objtxtEndDate.disabled = false;
                    objtxtEndDate1.disabled = false;
                    //objtxtEndDate.style.backgroundColor = "white"
                    //objtxtEndDate1.style.backgroundColor = "white"

                if (objAllocation != null)
                    objAllocation.disabled = false;
                    //objAllocation.style.backgroundColor = "white"

            }

        }
    }

    function SelectAll_OnClick() {
        //debugger;

        var strChecked = '';
        var strArr = '';
        var objRecruiterID, objSelect;

        //SelectAllCheckboxs('frmRecruiterAssignment','chkSelect')
        objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);
        //objSelect = document.GetElementByName('chkSelect');

        for (var i = 0; i < objSelect.length; i++) {
            if (objSelect[i].checked == false) {
                objSelect[i].checked = true;
            }
        }
    }
    function ClearAll_OnClick() {
        var strChecked = '';
        var strArr = '';
        var objRecruiterID, objSelect;

        objSelect = GetObjectReference('frmResourceReallocation', 'chkSelect', true);

        for (var i = 0; i < objSelect.length; i++) {
            if (objSelect[i].checked == true) {
                objSelect[i].checked = false;
            }
        }

    }
    </script>
</body>
</html>
