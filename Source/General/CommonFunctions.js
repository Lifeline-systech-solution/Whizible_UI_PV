/* //'DECLARATION: THIS IS A FRAMEWORK CODE ITEM. IT IS NOT EXPECTED TO MODIFY THIS AT THE APPLICATION LEVEL */
//fn.. checks for value to be present and shows the message if empty


//Added by Nilesh Gundecha on 27/10/2015 for quick view of project details

function myFunction1() {
    alert('You are not Authorize to view this record');
}

//added by Nilesh g on 8/1/2015 for loader
function setFrameLoader() {

    $("HTML").append("<div id='preloader'></div>");
    $("HTML").append("<div id='fillDiv'></div>");
}

function RemoveFrameLoader() {
    jQuery("#preloader").remove();
    jQuery("#fillDiv").remove();
    jQuery("#preloader").fadeOut("slow");
    jQuery("#fillDiv").fadeOut("slow");
    jQuery("#preloader").remove();
    jQuery("#fillDiv").remove();
}

//endded by Nilesh g on 8/1/2015 for loader
function ErrorMessage() {
    alert('You are not Authorize to view this record');
}

function myFunction(projectid, PageName, ColumnName, PrimaryKey) {
    //debugger;
    // alert(ColumnName +' '+ PrimaryKey +' '+ projectid);

    parent.document.getElementById("tdTree").style.display = "none";
    //if (isIE() == "FF")
    //    parent.document.getElementById("tblLeftNavigation").style.display = "block";
    //else
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

    $(parent.document.getElementById("tdDot2")).append("<div id='preloader'></div> <div id='fillDiv'></div>");

    // alert(parent.window.frames['ViewMain'].document.location.href="../Home/ShowProjectDetails.aspx?projectId="+projectid+"");
    var Browser = isIE();
    if (Browser == 'IE') {
        if (parent.window.frames['ViewMain'].document != undefined)
            parent.window.frames['ViewMain'].document.location.href = "" + PageName + "?projectId=" + projectid + "";
        parent.window.frames['ViewMain'].src = "" + PageName + "?projectId=" + projectid + "";
    }
    else {
        //alert(Browser);
        // parent.window.frames['ViewMain'].document.location.href = "../Home/ShowProjectDetails.aspx?projectId="+projectid+"";
        parent.window.frames['ViewMain'].src = "" + PageName + "?projectId= " + projectid + "&ColumnName=" + ColumnName + "&PrimaryKey=" + PrimaryKey + "";
    }
}

function isIE() {
    var brwser = '';
    var ua = navigator.userAgent, tem,
        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        //return 'IE '+(tem[1] || '');
        return 'IE';
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
        brwser = 'CR';
    }
    else if (M[1] === 'Firefox') {
        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
        brwser = 'FF';
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
    //return M.join(' ');
    return brwser;
}

//Ended by Nilesh Gundecha on 27/10/2015 for quick view of project details     

function IsEmpty(obj, strMessage) {
    if (trimString(obj.value) == "") {
        alert(strMessage);
        obj.value = "";
        obj.focus();
        return true;
    }
    else {
        return false;
    }
}
//fn.. trims the string
function trimString(str) {
    str = this != window ? this : str;
    return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

// fn.. to display the calendar control
function callcalendar(formname, datefield) {
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var RowIndex = (arguments.length > 2) ? arguments[2] : "0";
    var objdateObject;
    if (RowIndex == 0)
        objdateObject = GetObjectReference(formname, datefield);
    else
        objdateObject = GetObjectReference(formname, datefield, true)[RowIndex - 1];
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    if (objdateObject.disabled == true) { return; }
    var dtval;
    if (objdateObject.value == '')
        dtval = 'None'
    else
        dtval = objdateObject.value;

    //Issue ID 28888
    if (window.showModalDialog)
        calendar_window = window.open('../General/Calendar.aspx?datefield=' + datefield + '&formname=' + formname + '&dateval=' + dtval + '&RowIndex=' + RowIndex, 'calendar_window', 'top=0,left=0,width=348,height=260');
    else
        calendar_window = window.open('../General/Calendar.aspx?datefield=' + datefield + '&formname=' + formname + '&dateval=' + dtval + '&RowIndex=' + RowIndex, 'calendar_window', 'top=0,left=0,width=348,height=300');

    calendar_window.focus();
}

/* Added By SandeepA on 31 Aug,2005 For Requirement Tag : WAF3_CDB_7 and WAF3_CDB_19 */
function callcolorpalette(formname, colorfield) {
    /******************************************************************************
     ******************************************************************************
      Purpose : Function to display the ColorPalette window.
      Author  : SandeepA
      Date    : 31 Aug,2005.
      Modified: By PushkarK On 13-May-2009 for WAF3_CDB_28
      ******************************************************************************
      *****************************************************************************/
    var objcolorObject = GetObjectReference(formname, colorfield);
    if (objcolorObject.disabled == true) { return; }
    var colval;
    if (objcolorObject.value == '')
        colval = 'None';
    else
        colval = objcolorObject.value;
    if (window.showModalDialog)
        calendar_window = window.open('../General/ColorPalette.aspx?colorfield=' + colorfield + '&formname=' + formname + '&colorval=' + colval, 'ColorPalette_window', 'top=' + ((window.screen.height - 250) / 2) + ',left=' + ((window.screen.width - 326) / 2) + ',width=326,height=250'); //Modified By Ninad on 20 Aug 2007 Task Name  : Build 9 hot fix 2
    else
        calendar_window = window.open('../General/ColorPalette.aspx?colorfield=' + colorfield + '&formname=' + formname + '&colorval=' + colval, 'ColorPalette_window', 'top=' + ((window.screen.height - 250) / 2) + ',left=' + ((window.screen.width - 326) / 2) + ',width=326,height=250'); //Modified By Ninad on 20 Aug 2007 Task Name  : Build 9 hot fix 2		

    //ColorPalette_window.focus()
}
/* End of Addition (Function callcolorpalette) For Requirement Tag : WAF3_CDB_7 and WAF3_CDB_19 */


// fns.. to display help
function Help_OnClick(HelpID) {
    window.open("../General/Help.aspx?HelpID=" + HelpID, "_help", "resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
}
// help for pages in General folder
function OpenHelpPage(HelpID) {
    Help_OnClick(HelpID);
    //window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
}
// close the window
function Close_OnClick() {
    window.close();
}

var ns;
if (navigator.appName == 'Netscape')
    ns = true;
else
    ns = false;


function GetObjectReference(strFormId, strElementId, blnIsName) {
    var objElement;
    var objCombo;

    if (blnIsName) {
        objElement = document.getElementsByName(strElementId);
    }
    else if (!(blnIsName)) {
        objElement = document.getElementById(strElementId);
    }
    return objElement;

}
function GetParentFrameReference() {
    var objElement;
    //alert(top.frames[0].frames.length);
    //alert(window.parent.frames['frmDown']);
    objElement = window.parent.frames;
    return objElement;
}

function GetFormReference(strFormId) {
    var objElement;

    objElement = document.getElementById(strFormId);
    return objElement;

}
function GetObjectEvent(e) {
    var objElement;
    if (ns) {
        objElement = e.target;
    }
    else {
        objElement = e.srcElement;
    }

    return objElement;
}
function opentextdialog(frmName, txtObject, title, IsDisable, path) {
    //Function modified for Hotfix ID 2.0.37-SP4-WAF by UmeshJ 08-Sep-2006
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    //var path=(arguments.length>4)?arguments[4]:'null'; 
    var objDescription;
    var RowIndex = (arguments.length > 5) ? arguments[5] : "0";
    var objText;
    if (RowIndex == "0")
        objText = GetObjectReference(frmName, txtObject);
    else
        objText = GetObjectReference(frmName, txtObject, true)[parseInt(RowIndex) - 1];
    RowIndex = '&RowIndex=' + RowIndex;
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
    var maxLength = (arguments.length > 6) ? arguments[6] : 1500;	//Modified By Ninad on 16 Jan 2008 IssueID-26590, pass maxlength ahead

    //Issue ID 28888
    title = replaceSubstring(replaceSubstring(replaceSubstring(title, "&", "%26"), "#", "%23"), "+", "%2b");
    //Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
    objDescription = replaceSubstring(objText.value, "#", "%23")
    //End Of Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
    var strDescription;
    if (title == null)
        title = "";
    if (path == null || path == '') {
        //Issue ID 28888
        if (window.showModalDialog) {

            //Uncommented by Usha Pandit on 19-04-2019 for Text area custom field display issue 
            strDescription = window.showModalDialog("../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
            //strDescription = window.showModalDialog("../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
            //End of Uncommented by Usha Pandit on 19-04-2019 for Text area custom field display issue 
        } else {
            var strAddress;
            //Uncommented by Usha Pandit on 19-04-2019 for Text area custom field display issue 
            //strAddress = "../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
            //Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
            strAddress = "../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objDescription + RowIndex + "&MaxLength=" + maxLength;
            //End Of Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
            //strAddress = "../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
            //End of Uncommented by Usha Pandit on 19-04-2019 for Text area custom field display issue
            //Commented and Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
            //ShowWindow(strAddress, objText.value);
            ShowWindow(strAddress, objDescription);
            //End Of Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
        }
    } else {
        //Issue ID 28888
        if (window.showModalDialog) {
            strDescription = window.showModalDialog(path + '?Title=' + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
        } else {
            var strAddress;
            //strAddress = path + '?Title=' + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
            strAddress = path + '?Title=' + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objDescription + RowIndex + "&MaxLength=" + maxLength;
            //Commented and Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
            //ShowWindow(strAddress, objText.value);
            ShowWindow(strAddress, objDescription);
            //End Of Added By Nikhil A on 7-June-2019 To solve error if # is entered in description
        }
    }

    if ((IsDisable == "False") && (window.showModalDialog)) {
        objText.value = strDescription;
    }
}
//start Issue ID 28888
var winModalWindow;

function IgnoreEvents(e) {
    return false;
}

function ShowWindow(strAddress, value) {
    if (window.showModalDialog) {
        return window.showModalDialog(strAddress, value, "dialogWidth=545px;dialogHeight=530px");
    }
    else {
        window.top.captureEvents(Event.CLICK | Event.FOCUS);
        window.top.onclick = IgnoreEvents;
        window.top.onfocus = HandleFocus;
        winModalWindow = window.open(strAddress, "ModalChild", "dependent=yes,left=" + (window.screen.width - 545) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=545,height=600");
        winModalWindow.focus();
        //return winModalWindow
        //winModalWindow
    }
}

function HandleFocus() {
    if (winModalWindow) {
        if (!winModalWindow.closed) {
            winModalWindow.focus();
        }
        else {
            window.top.releaseEvents(Event.CLICK | Event.FOCUS);
            window.top.onclick = "";
        }
    }
    return false;
}
//End Issue ID 28888

// fns.. to display HTML Editor
function callHTMLEditor(formname, datefield) {
    var RowIndex = (arguments.length > 4) ? arguments[4] : "0"; //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var maxLength = (arguments.length > 5) ? arguments[5] : 1500;	//Modified By Ninad on 16 Jan 2008 IssueID-26590, pass maxlength ahead
    htmleditor_window = window.open('../General/HTMLEditor.aspx?datefield=' + datefield + '&formname=' + formname + '&RowIndex=' + RowIndex + "&MaxLength=" + maxLength, 'htmleditor_window', 'left=' + ((window.screen.width - 700) / 2) + ',top=' + ((window.screen.height - 500) / 2) + ',width=700,height=500'); //Modified By Ninad Text Area Req ID - WAF3_PB_48, WAF3_PB_55 
}

//this code is used for showing the image or HTML as tooltip for any control.	
var FADINGTOOLTIP;
var wnd_height, wnd_width;
var tooltip_height, tooltip_width;
var tooltip_shown = false;
var transparency = 100;
var timer_id = 1;
var m_adjustToolTip;
var m_fadedToolTip = "";

//window.onload = WindowLoading;
//window.onresize = UpdateWindowSize;
document.onmousemove = AdjustToolTipPosition;

function DisplayTooltip(tooltip_text) {

    if (FADINGTOOLTIP == null)
        return;
    FADINGTOOLTIP.innerHTML = tooltip_text;
    tooltip_shown = (tooltip_text != "") ? true : false;
    if (tooltip_text != "") {
        tooltip_height = (FADINGTOOLTIP.style.pixelHeight) ? FADINGTOOLTIP.style.pixelHeight : FADINGTOOLTIP.offsetHeight;
        transparency = 0;
        if (m_fadedToolTip == "")
            ToolTipFading();
    }
    else {
        clearTimeout(timer_id);
        FADINGTOOLTIP.style.visibility = "hidden";
    }
}

function DisplayTooltipCL(tooltip_text) {
    //Hotfix... 1.0.0-SP1-WAF
    document.onmousemove = AdjustToolTipPositionForCL;
    if (FADINGTOOLTIP == null)
        return;
    FADINGTOOLTIP.innerHTML = tooltip_text;
    tooltip_shown = (tooltip_text != "") ? true : false;
    if (tooltip_text != "") {
        tooltip_height = (FADINGTOOLTIP.style.pixelHeight) ? FADINGTOOLTIP.style.pixelHeight : FADINGTOOLTIP.offsetHeight;
        transparency = 0;
        if (m_fadedToolTip == "")
            ToolTipFading();
    }
    else {
        clearTimeout(timer_id);
        FADINGTOOLTIP.style.visibility = "hidden";
    }
}

function AdjustToolTipPosition(e) {
    if (m_adjustToolTip != null) {
        FADINGTOOLTIP.style.visibility = "visible";
        //modified RajK June 23 2005 issue id: 19358 
        //modified RajK 11-Aug-2005 issue id: 20642 
        //removed the comment for IE browser 
        if (navigator.appName == 'Microsoft Internet Explorer') {
            return;
        }
        //end modification RajK 11-Aug-2005 issue id: 20642 
        //end modification RajK June 23 2005 issue id: 19358 
    }

    if (tooltip_shown) {
        //modified RajK June 23 2005 issue id: 19358 
        if (navigator.appName != 'Microsoft Internet Explorer') {
            //Commented And Added By Vaijat K On 19/10/2015
            //FADINGOOLTIP.style.visibility = "visible";
            FADINGTOOLTIP.style.visibility = "visible";
            FADINGTOOLTIP.style.left = e.clientX + document.body.scrollLeft + 'px';//Math.min(wnd_width - tooltip_width - 10 , Math.max(3, e.clientX -150)) + document.body.scrollLeft + 'px';
            FADINGTOOLTIP.style.top = e.clientY + document.body.scrollTop + 'px';//+ offset_y + document.body.scrollTop + 'px';
        }
        else {
            offset_y = (event.clientY + tooltip_height - document.body.scrollTop + 30 >= wnd_height) ? - 15 - tooltip_height : 20;
            FADINGTOOLTIP.style.visibility = "visible";
            FADINGTOOLTIP.style.left = Math.min(wnd_width - tooltip_width - 10, Math.max(3, event.clientX - 350)) + document.body.scrollLeft + 'px';
            FADINGTOOLTIP.style.top = event.clientY + offset_y + document.body.scrollTop + 'px';
        }
        //end modification RajK June 23 2005 issue id: 19358 

    }

}

//Hotfix... 1.0.0-SP1-WAF
function AdjustToolTipPositionForCL(e) {
    if (m_adjustToolTip != null) {
        FADINGTOOLTIP.style.visibility = "visible";
        return;
    }
    if (tooltip_shown) {

        offset_y = (event.clientY + tooltip_height - document.body.scrollTop + 30 >= wnd_height) ? - 15 - tooltip_height : 20;
        FADINGTOOLTIP.style.visibility = "visible";
        FADINGTOOLTIP.style.left = Math.min(wnd_width - tooltip_width - 10, Math.max(3, event.clientX - 350)) + document.body.scrollLeft + 'px';
        FADINGTOOLTIP.style.top = event.clientY + offset_y + document.body.scrollTop + 'px';
        //alert(FADINGTOOLTIP.offsetWidth);
        //FADINGTOOLTIP.style.left=(window.screen.width- 280)/2
        //FADINGTOOLTIP.style.top=(window.screen.height-492)/2

    }

}

function WindowLoading(adjustToolTip, fadedToolTip) {
    FADINGTOOLTIP = document.getElementById('FADINGTOOLTIP');

    if (adjustToolTip != null) {
        m_adjustToolTip = adjustToolTip;
    }
    if (fadedToolTip != null) {
        m_fadedToolTip = fadedToolTip;
    }

    tooltip_width = (FADINGTOOLTIP.style.pixelWidth) ? FADINGTOOLTIP.style.pixelWidth : FADINGTOOLTIP.offsetWidth;

    tooltip_height = (FADINGTOOLTIP.style.pixelHeight) ? FADINGTOOLTIP.style.pixelHeight : FADINGTOOLTIP.offsetHeight;

    UpdateWindowSize();
}

function ToolTipFading() {
    if (transparency <= 100) {
        FADINGTOOLTIP.style.filter = "alpha(opacity=" + transparency + ")";
        transparency += 5;
        timer_id = setTimeout('ToolTipFading()', 35);
    }
}

function UpdateWindowSize(adjustToolTip, fadedToolTip) {
    if (adjustToolTip != null) {
        m_adjustToolTip = adjustToolTip;
    }
    if (fadedToolTip != null) {
        m_fadedToolTip = fadedToolTip;
    }
    wnd_height = document.body.clientHeight;
    wnd_width = document.body.clientWidth;
}

function DateDiff(start, end, interval, rounding) {

    var iOut = 0;

    // Create 2 error messages, 1 for each argument.</KBD> 
    var startMsg = "Check the Start Date and End Date\n"
    startMsg += "must be a valid date format.\n\n"
    startMsg += "Please try again.";

    var intervalMsg = "Sorry the dateAdd function only accepts\n"
    intervalMsg += "d, h, m OR s intervals.\n\n"
    intervalMsg += "Please try again.";

    var bufferA = Date.parse(start);
    var bufferB = Date.parse(end);

    // check that the start parameter is a valid Date. </KBD>
    if (isNaN(bufferA) || isNaN(bufferB)) {
        alert(startMsg);
        return null;
    }

    // check that an interval parameter was not numeric.</KBD> 
    if (interval.charAt == 'undefined') {
        // the user specified an incorrect interval, handle the error.</KBD> 
        alert(intervalMsg);
        return null;
    }
    var number = bufferB - bufferA;
    // what kind of add to do?</KBD> 
    switch (interval.charAt(0)) {
        case 'd': case 'D':
            iOut = parseInt(number / 86400000);
            if (rounding) iOut += parseInt((number % 86400000) / 43200001);
            break;
        case 'h': case 'H':
            iOut = parseInt(number / 3600000);
            if (rounding) iOut += parseInt((number % 3600000) / 1800001);
            break;
        case 'm': case 'M':
            iOut = parseInt(number / 60000);
            if (rounding) iOut += parseInt((number % 60000) / 30001);
            break;
        case 's': case 'S':
            iOut = parseInt(number / 1000);
            if (rounding) iOut += parseInt((number % 1000) / 501);
            break;
        default:
            // If we get to here then the interval parameter
            // didn't meet the d,h,m,s criteria.  Handle
            // the error.</KBD> 		
            alert(intervalMsg);
            return null;
    }
    return iOut;
}
function DateAdd(startDate, numDays, numMonths, numYears) {
    //Code obtained from http://javascript.about.com
    var returnDate = new Date(startDate.getTime());
    var yearsToAdd = numYears;

    var month = returnDate.getMonth() + numMonths;
    if (month > 11) {
        yearsToAdd = Math.floor((month + 1) / 12);
        month -= 12 * yearsToAdd;
        yearsToAdd += numYears;
    }
    returnDate.setMonth(month);
    returnDate.setFullYear(returnDate.getFullYear() + yearsToAdd);

    returnDate.setTime(returnDate.getTime() + 60000 * 60 * 24 * numDays);

    return returnDate;

}

function YearAdd(startDate, numYears) {
    //Code obtained from http://javascript.about.com
    return DateAdd(startDate, 0, 0, numYears);
}

function MonthAdd(startDate, numMonths) {
    //Code obtained from http://javascript.about.com
    return DateAdd(startDate, 0, numMonths, 0);
}

function DayAdd(startDate, numDays) {
    //Code obtained from http://javascript.about.com
    return DateAdd(startDate, numDays, 0, 0);
}

function MonthName(intMonth) {
    var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");

    if ((isInteger(intMonth) == false) || (intMonth < 0) || (intMonth > 11))
        return "";

    return strMonths[intMonth];
}
function GetDateInFormat(OriginalDate, fmt) {
    //The dtmToDate must be in MMM, dd yyyy
    //Returns in dd-MMM-yyyy format.
    var dtmToDate;
    var arrMakeOriginal;
    if (arguments.length > 2) {
        //This will reverse the logic and convert the 
        //original date in parsable format.
        if (arguments[2] == "rev") {
            var dtmToDate = replaceSubstring(OriginalDate, "-", " ");
            return (dtmToDate);
        }
    }
    if (fmt == "MMM, dd yyyy") {
        dtmToDate = replaceSubstring(OriginalDate, ", ", "-");
        dtmToDate = replaceSubstring(dtmToDate, " ", "-");
        arrMakeOriginal = dtmToDate.split("-");

        dtmToDate = arrMakeOriginal[1] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[0] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[2];
    }
    else if (fmt == "dd, MMM yyyy") {
        dtmToDate = replaceSubstring(OriginalDate, ", ", "-");
        dtmToDate = replaceSubstring(dtmToDate, " ", "-");
        arrMakeOriginal = dtmToDate.split("-");

        dtmToDate = arrMakeOriginal[0] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[1] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[2];
    }
    else if (fmt == "MMM dd,yyyy") {
        dtmToDate = replaceSubstring(OriginalDate, ", ", "-");
        dtmToDate = replaceSubstring(dtmToDate, ",", "-");
        dtmToDate = replaceSubstring(dtmToDate, " ", "-");
        arrMakeOriginal = dtmToDate.split("-");

        dtmToDate = arrMakeOriginal[1] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[0] + "-";
        dtmToDate = dtmToDate + arrMakeOriginal[2];
    }
    return (dtmToDate);
}

//------------------------------------------------------------------------------
//Purpose : Select all check boxes
//------------------------------------------------------------------------------
function SelectAll_OnClick(strFormName, strCheckbox)
//Pass FormName and the Checkbox's ID
{
    var objCheckbox = GetObjectReference(strFormName, strCheckbox, true);
    var intItems;
    var intCtr;

    if (objCheckbox != null) {
        intItems = objCheckbox.length;
        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                if (objCheckbox[intCtr].disabled == false)
                    objCheckbox[intCtr].checked = true;
            }
        }
        // Else, if single element exists, then...
        else if (intItems == 1) {
            if (objCheckbox[0].disabled == false)
                objCheckbox[0].checked = true;
        }
    }

}

//------------------------------------------------------------------------------
//Purpose : Clear all check boxes
//------------------------------------------------------------------------------
function ClearAll_OnClick(strFormName, strCheckbox)
//Pass FormName and the Checkbox's ID
{
    var objCheckbox = GetObjectReference(strFormName, strCheckbox, true);
    var intItems;
    var intCtr;

    if (objCheckbox != null) {
        intItems = objCheckbox.length;

        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                if (objCheckbox[intCtr].disabled == false)
                    objCheckbox[intCtr].checked = false;
            }
        }
        // Else, if single element exists, then...
        else if (intItems == 1) {
            if (objCheckbox[0].disabled == false)
                objCheckbox[0].checked = false;
        }
    }

}
//------------------------------------------------------------------------------
//Purpose : enable all check boxes
//------------------------------------------------------------------------------

function EnableCheckBoxes(strFormName, strCheckBox) {

    var objCheckbox = GetObjectReference(strFormName, strCheckBox, true);
    var intItems;
    var intCtr;

    if (objCheckbox != null) {
        intItems = objCheckbox.length;

        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                if (objCheckbox[intCtr].disabled == true)
                    objCheckbox[intCtr].disabled = false;
            }
        }
        // Else, if single element exists, then...
        else {
            if (objCheckbox[0].disabled == true)
                objCheckbox[0].disabled = false;
        }
    }

}

//------------------------------------------------------------------------------
//Purpose : disable all check boxes
//------------------------------------------------------------------------------

function DisableCheckBoxes(strFormName, strCheckBox) {

    var objCheckbox = GetObjectReference(strFormName, strCheckBox, true);
    var intItems;
    var intCtr;

    if (objCheckbox != null) {
        intItems = objCheckbox.length;

        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                if (objCheckbox[intCtr].disabled == false)
                    objCheckbox[intCtr].disabled = true;
            }
        }
        // Else, if single element exists, then...
        else {
            if (objCheckbox[0].disabled == false)
                objCheckbox[0].disabled = true;
        }
    }

}


//******************************************************************************
//******************		DATE FUNCTIONS START
//******************************************************************************
//------------------------------------------------------------------------------
//--		GET CLIENT MACHINE's DATE
//------------------------------------------------------------------------------
// -------------------------------------------------------------------
// getDate1()
// Returns date on client machine in following formats : 
// 1 : 15-Jan-2004
// 2 : 15 January 2004
// 3 : January 15, 2004
// 4 : Jan 15, 2004
// 5 : 15 Jan, 2004
// -------------------------------------------------------------------	
function getDate1(format) {
    var dateString;
    var months = new Array(13);
    months[0] = "January";
    months[1] = "February";
    months[2] = "March";
    months[3] = "April";
    months[4] = "May";
    months[5] = "June";
    months[6] = "July";
    months[7] = "August";
    months[8] = "September";
    months[9] = "October";
    months[10] = "November";
    months[11] = "December";
    var now = new Date();
    var monthnumber = now.getMonth();
    var monthname = months[monthnumber];
    var monthday = now.getDate();
    var year = now.getYear();
    if (year < 2000) { year = year + 1900; }

    switch (format) {
        case 1:
            dateString = monthday + '-' + Left(monthname, 3) + '-' + year;
            break;
        case 2:
            dateString = monthday + ' ' + monthname + ' ' + year;
            break;
        case 3:
            dateString = monthname + ' ' + monthday + ', ' + year;
            break;
        case 4:
            dateString = Left(monthname, 3) + ' ' + monthday + ', ' + year;
            break;
        case 5:
            dateString = monthday + ' ' + Left(monthname, 3) + ', ' + year;
            break;
        default:
            dateString = monthday + ' ' + monthname + ' ' + year;
    }
    return dateString;
} // function getCalendarDate()


// -------------------------------------------------------------------
// getTime
// Returns time on client machine in format : hh:mm:ss am/pm 
// -------------------------------------------------------------------	
function getTime() {
    var now = new Date();
    var hour = now.getHours();
    var minute = now.getMinutes();
    var second = now.getSeconds();
    var ap = "AM";
    if (hour > 11) { ap = "PM"; }
    if (hour > 12) { hour = hour - 12; }
    if (hour == 0) { hour = 12; }
    if (hour < 10) { hour = "0" + hour; }
    if (minute < 10) { minute = "0" + minute; }
    if (second < 10) { second = "0" + second; }
    var timeString = hour + ':' + minute + ':' + second + " " + ap;
    return timeString;
} // function getClockTime()


// -------------------------------------------------------------------
// Now()
// Returns date and time on client machine in following date formats : 
// 1 : 15-Jan-2004
// 2 : 15 January 2004
// 3 : January 15, 2004
// 4 : Jan 15, 2004
// 5 : 15 Jan, 2004
// -------------------------------------------------------------------	
function Now(format) {
    if (format != null)
        return getDate(format) + " " + getTime();
    else
        return getDate() + " " + getTime();
}

//========================================================================================================
function DatePart(strInterval, dtDate, intFirstDayOfWeek, intFirstWeekOfYear) {
    /*
        '====================================================================
        ' Function Name        : DatePart
        ' Parameters Passed    : strInterval - Interval of time to return.
        '			 dtDate		 - The Date to evaluate.
        '			 intFirstDayOfWeek - First Day of Week. By default SUNDAY (1). - Optional
        '			 intFirstWeekOfYear - First Week of Year. By default Week of 1st Jan. - Optional
        ' Returns              : The integer which contains the specified part of the given Date.
        '						 On Error returns -1
        ' Parameters Affected  : None
        ' Purpose              : Same as VBScript DatePart function.
        ' Description          : Alomost same as 'DatePart' function of VBScript.
        ' Assumptions          : Refer the below defined constants (commented).
        ' Dependencies         : None
        ' Author               : JayavantK
        ' Created              : June 08, 2004
        ' Revisions            : 
        '=====================================================================
            const SUNDAY = 1;
            const MONDAY = 2;
            const TUESDAY = 3;
            const WEDNESDAY = 4;
            const THURSDAY = 5;
            const FRIDAY = 6;
            const SATURDAY = 7;
    */
    var intDaysInWeek = 7;


    if ((strInterval == null) || (strInterval == ''))
        return -1;
    if ((dtDate == null) || (dtDate == ''))
        return -1;

    if ((intFirstDayOfWeek == null) || (intFirstDayOfWeek == ''))
        intFirstDayOfWeek = 1; // Set default value to SUNDAY (1)
    if ((intFirstDayOfWeek > intDaysInWeek) || (intFirstDayOfWeek < 1))
        return -1;

    if ((intFirstWeekOfYear == null) || (intFirstWeekOfYear == ''))
        intFirstWeekOfYear = 1; // Set default value to 1 - Week of Jan 1st.
    if ((intFirstWeekOfYear > 3) || (intFirstWeekOfYear <= 0))
        return -1;

    if (strInterval.toUpperCase() == "YYYY") {
        return (dtDate.getFullYear());
    }

    else if (strInterval.toUpperCase() == "Q") {
        return (parseInt(dtDate.getMonth() / 3) + 1);
    }

    else if (strInterval.toUpperCase() == "M") {
        return (dtDate.getMonth() + 1);
    }

    else if (strInterval.toUpperCase() == "Y") {
        var dtFirstDay = new Date();

        dtFirstDay.setDate(1);
        dtFirstDay.setMonth(0);
        dtFirstDay.setFullYear(dtDate.getFullYear());
        dtFirstDay.setHours(0);
        dtFirstDay.setMinutes(0);
        dtFirstDay.setSeconds(0);

        return (DateDiff(dtFirstDay, dtDate, "d") + 1);
    }

    else if (strInterval.toUpperCase() == "D") {
        return (dtDate.getDate());
    }

    else if (strInterval.toUpperCase() == "W") {
        // This date is taken for reference or for comparison. It was SATURDAY (7) on that day
        var dtReferenceDate = new Date('Sat, 1 Jan 2000 00:00:00'), intReferenceDay = 7;
        var intReturn = 0, intDayNumber, intTemp = 0;

        intTemp = DateDiff(dtReferenceDate, dtDate, "d");
        if (intTemp < 0) {
            intTemp = -1 * intTemp;
            intDayNumber = (intTemp % intDaysInWeek) + 1;
            if (intDayNumber >= intReferenceDay)
                intReturn = (intDaysInWeek - (intDayNumber - intReferenceDay));
            else
                intReturn = (intReferenceDay - intDayNumber);

            intReturn = (intReturn - intFirstDayOfWeek + 1);
            if (intReturn <= 0)
                intReturn = intDaysInWeek + intReturn;
        }
        else {
            intDayNumber = ((intTemp + (intReferenceDay - 1)) % intDaysInWeek) + 1;
            intReturn = (((intDaysInWeek - intFirstDayOfWeek) + intDayNumber) % intDaysInWeek) + 1;
        }
        return (intReturn);
    }

    else if (strInterval.toUpperCase() == "WW")//
    {
        var dtFirstDay = new Date(), intFirstDayOfYear;
        var intDayOfYear, intWeekDay, intReturn = 0;

        dtFirstDay.setDate(1);
        dtFirstDay.setMonth(0);
        dtFirstDay.setFullYear(dtDate.getFullYear());
        dtFirstDay.setHours(0);
        dtFirstDay.setMinutes(0);
        dtFirstDay.setSeconds(1);

        intFirstDayOfYear = DatePart('w', dtFirstDay, 1);
        intDayOfYear = DateDiff(dtFirstDay, dtDate, "d");
        intReturn = Math.ceil((intDayOfYear + intFirstDayOfYear) / intDaysInWeek);
        intWeekDay = DatePart('w', dtDate, 1);


        if (intFirstDayOfWeek > intFirstDayOfYear)
            intReturn = intReturn + 1;
        if (intFirstDayOfWeek > intWeekDay)
            intReturn = intReturn - 1;

        if (intFirstWeekOfYear == 2) //Start with First Week with at least 4 days
        {
            if (intFirstDayOfYear >= intFirstDayOfWeek) {
                if ((intFirstDayOfYear - intFirstDayOfWeek) >= 4)
                    intReturn = intReturn - 1;
            }
            else if ((intFirstDayOfWeek - intFirstDayOfYear) < 4)
                intReturn = intReturn - 1;

        }
        if (intFirstWeekOfYear == 3) //Start with first full week of the year.
        {
            if ((intFirstDayOfYear - intFirstDayOfWeek) != 0)
                intReturn = intReturn - 1;
        }

        return (intReturn);
    }

    else if (strInterval.toUpperCase() == "H") {
        return (dtDate.getHours());
    }

    else if (strInterval.toUpperCase() == "N") {
        return (dtDate.getMinutes());
    }

    else if (strInterval.toUpperCase() == "S") {
        return (dtDate.getSeconds());
    }

    else
        return -1;
}
//========================================================================================================
//******************************************************************************
//******************		DATE FUNCTIONS END
//******************************************************************************


//..fn to get the Object Reference on parent form.
//frm -> id/name of the form
//ctrl -> id/name of the control.
function GetParentObjectReference(frm, ctrl) {
    return window.opener.document.forms[frm].elements[ctrl];
}


//..fn to get the Form Reference of Parent form
//frm -> id/name of the form.
function GetParentFormReference(frm) {
    return window.opener.document.forms[frm];
}

//******************************************************************************
//	URL Encode/Decode functions
//******************************************************************************
function URLEncode(plaintext) {
    // The Javascript escape and unescape functions do not correspond
    // with what browsers actually do...
    var SAFECHARS = "0123456789" +					// Numeric
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +	// Alphabetic
        "abcdefghijklmnopqrstuvwxyz" +
        "-_.!~*'()";					// RFC2396 Mark characters
    var HEX = "0123456789ABCDEF";

    var encoded = "";
    for (var i = 0; i < plaintext.length; i++) {
        var ch = plaintext.charAt(i);
        if (ch == " ") {
            encoded += "+";				// x-www-urlencoded, rather than %20
        } else if (SAFECHARS.indexOf(ch) != -1) {
            encoded += ch;
        } else {
            var charCode = ch.charCodeAt(0);
            if (charCode > 255) {
                //encoded += "+";
                encoded += encodeURI(ch);
            } else {
                encoded += "%";
                encoded += HEX.charAt((charCode >> 4) & 0xF);
                encoded += HEX.charAt(charCode & 0xF);
            }
        }
    } // for

    return encoded;
}
function URIEncode(plaintext) {
    // The Javascript escape and unescape functions do not correspond
    // with what browsers actually do...
    var SAFECHARS = "0123456789" +					// Numeric
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +	// Alphabetic
        "abcdefghijklmnopqrstuvwxyz" +
        "-_.!~*'()";					// RFC2396 Mark characters
    var HEX = "0123456789ABCDEF";

    var encoded = "";
    for (var i = 0; i < plaintext.length; i++) {
        var ch = plaintext.charAt(i);
        if (ch == " ") {
            encoded += "+";				// x-www-urlencoded, rather than %20
        } else if (SAFECHARS.indexOf(ch) != -1) {
            encoded += ch;
        } else {
            var charCode = ch.charCodeAt(0);
            if (charCode > 255) {
                //encoded += "+";
                encoded += encodeURI(ch);
            } else {
                encoded += "%";
                encoded += HEX.charAt((charCode >> 4) & 0xF);
                encoded += HEX.charAt(charCode & 0xF);
            }
        }
    } // for

    return encoded;
}


function URLDecode(plaintext) {
    // Replace + with ' '
    // Replace %xx with equivalent character
    // Put [ERROR] in output if %xx is invalid.
    var HEXCHARS = "0123456789ABCDEFabcdef";
    var encoded = "";
    var i = 0;
    while (i < encoded.length) {
        var ch = encoded.charAt(i);
        if (ch == "+") {
            plaintext += " ";
            i++;
        } else if (ch == "%") {
            if (i < (encoded.length - 2)
                && HEXCHARS.indexOf(encoded.charAt(i + 1)) != -1
                && HEXCHARS.indexOf(encoded.charAt(i + 2)) != -1) {
                plaintext += unescape(encoded.substr(i, 3));
                i += 3;
            } else {
                plaintext += "%[ERROR]";
                i++;
            }
        } else {
            plaintext += ch;
            i++;
        }
    } // while
    return plaintext;

}

//fn... To get name from ID.
function getNameFromID(obj) {
    if (arguments.length > 1) {
        return (obj.getAttribute(arguments[1]));
    }
    else {
        return (obj.getAttribute("name"));
    }
}

//____________________________________________________________________________________
//__________Added By UmeshJ on July 16, 2004
//__________Check if the any check box is selected
//__________Return TRUE if any one check box is selected else false
//____________________________________________________________________________________
function IsCheckboxSelected(strFormName, strCheckbox)
//Pass FormName and the Checkbox's ID
{
    var objCheckbox = GetObjectReference(strFormName, strCheckbox, true);
    var intItems; var intCtr;
    if (objCheckbox != null) {
        intItems = objCheckbox.length;
        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {
                if (objCheckbox[intCtr].disabled == false)
                    if (objCheckbox[intCtr].checked == true)
                        return true;
            }
        }
        // Else, if single element exists, then...
        else if (intItems == 1) {
            if (objCheckbox[0].disabled == false)
                if (objCheckbox[0].checked == true)
                    return true;
        }
    }
    return false;
}
//____________________________________________________________________________________
//______________________________SCROLLABEL JS START
function scrollME(objDIV) {
    var objTH = document.getElementById('colheader');
    var objBody = document.getElementById('divListTag');
    objTH.style.position = 'absolute';
    objTH.style.left = 0 - objBody.scrollLeft - parseInt(objBody.offsetLeft);
}
//______________________________SCROLLABEL JS END
//______________________________TYPE AHEAD COMBO START_______________________________
/* **** ARRAY EXTENSION FOR NON-SUPPORTING BROWSERS **** */
if (typeof Array.prototype.push == 'undefined') {
    Array.prototype.push = function () {
        var i = 0,
            b = this.length,
            a = arguments;
        for (i; i < a.length; i++) {
            this[b + i] = a[i];
        }
        return this.length;
    }
}
/* **** STRING EXTENSION FOR PUNCTUATION **** */
if (typeof (String.fromCharCode) == 'undefined') {
    String.fromCharCode = function () {
        if (arguments.length = 0) {
            return "";
        }
        var charCodeChars = new Array(32),
            returnString = "",
            i;
        charCodeChars[9] = '\t';
        charCodeChars[13] = '\n';
        charCodeChars.push(' ', '!', '"', '#', '$', '%', '', "'", '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@');
        charCodeChars.push('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`');
        charCodeChars.push('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~');
        for (i = 0; arguments.length > i; i++) {
            returnString += charCodeChars[arguments[i]];
        }
        return returnString;
    }
}
String.fromKeyCode = function (keyCode, evtType) {
    if (!evtType || !evtType.length) {
        evtType = "keyDown";
    } else if (evtType.toLowerCase() == "keypress") {
        return String.fromCharCode(keyCode);
    }
    var keyDownChars = new Array(16);
    keyDownChars[8] = '[Bksp]';
    keyDownChars[9] = '[Tab]';
    keyDownChars[12] = '[N5+shift]';
    keyDownChars[13] = '[Enter]';
    keyDownChars.push('[Shift]', '[Ctrl]', '[Alt]', '[Pause]', '[CapsLock]');
    for (i = 11; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars[27] = '[Esc]';
    keyDownChars.push(' ', '[PgUp]', '[PgDn]', '[End]', '[Home]', '[Left]', '[Up]', '[Right]', '[Down]');
    for (i = 7; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars[45] = '[Ins]';
    keyDownChars[46] = '[Del]';
    keyDownChars.push(['0', ')'], ['1', '!'], ['2', '@'], ['3', '#'], ['4', '$'], ['5', '%'], ['6', '^'], ['7', '&'], ['8', '*'], ['9', '(']);
    for (i = 7; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars.push('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[WinKey]');
    for (i = 4; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars.push('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '*', '+', 'undefined', '-', '.', '/', '[F1]', '[F2]', '[F3]', '[F4]', '[F5]', '[F6]', '[F7]', '[F8]', '[F9]', '[F10]', '[F11]', '[F12]');
    for (i = 62; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars[144] = '[NumLock]';
    keyDownChars[145] = '[ScrollLock]';
    keyDownChars.push([';', ':'], ['=', '+'], [',', '<'], ['-', '_'], ['.', '>'], ['/', '?'], ['`', '~']);
    for (i = 26; i; --i) {
        keyDownChars.push('undefined');
    }
    keyDownChars.push(['[', '{'], ['\\', '|'], [']', '}'], ["'", '"']);
    return keyDownChars[keyCode];
}

/* **** COMBOBOX CODE **** */
/**************************************************
Original Version (1.0):
Glenn G. Vergara
http://www21.brinkster.com/gver/
glenngv AT yahoo DOT com
Makati City, Philippines
	
Object-Based Version:
Eric C. Davis
http://www.10mar2001.com/
eric AT 10mar2001 DOT com
Atlanta, GA, US
	
(Keep the above intact if you want to use it! Thanks.)
	
Current Version: 2.5b
Last Update: 1 December 2003
	
********
Change Log:
New in version 2.5b:
    - Reversed selectItem() loop to prevent default IE6/Win rapid-change behaviour (skipped to second on match of first)
    - Outfitted for DOM2-style event handling; uses detection and falls back to DOM0 events
    - Resets immediately on ALT+TAB to prevent IE6/Win's loss of the reset timer.
	
New in version 2.4:
    - Added accepting of non-existent option
    - Added punctuation as acceptable input
    - Added setValueByValue() convenience method
	
New in version 2.2:
    - Many properties made private
    - Getters and setters for nearly all properties
	
New in version 2.0:
    - Object-oriented properties and methods using prototype
    - Constructor can accept a select element object or a select element object's ID string
    - Invocation reduced to single line of script: varName = new TypeAheadCombo('selectElementID');
	
New in version 1.4:
    - Allowable character set ranges use dynamic evaluation
    - Display of typed characters in status bar can be disabled
	
New in version 1.2:
    - Replaced major if/elseif/.../else statement with switch/case
    - Correction of characters typed on the numpad, reassigning to actual character values
********
	
********
API:
Constructor:
    new TypeAheadCombo(someSelectElement) // as an object or object reference
    new TypeAheadCombo('someSelectElementID') // as a string
    new TypeAheadCombobox('someSelectElementID', true) // to allow an undefined value
	
Privileged Methods: (these interact with private properties and act as helper functions)
    getTyped()
        - returns the string typed by the user since the last timeout
    setTyped(str)
        - argument "str" - string which will replace the value in the type buffer
    type(str)
        - argument "str" - string which will be appended to the type buffer
    resetTyped()
        - clears what has been typed from the buffer
    getIndex()
        - returns the location of the option currently selected
    setIndex(val)
        - stores the location of the option being selected
    getPrev()
        - returns the location of the option previously selected
    setPrev(val)
        - stores the location of the option previously selected
    setResetTime(val)
        - sets the timeout interval for the reset timers
    getResetTime()
        - returns the timeout interval for the reset timers
    setResetTimer()
        - sets the timeout for the reset of the typed buffer
    clearResetTimer()
        - clears the timeout of the reset of the typed buffer
    validChar(charCode)
        - validates that the charCode passed is acceptable to the typed buffer
    setDisplayStatus(bool)
        - set whether to display the typed buffer in the status bar
    getDisplayStatus()
        - returns the current setting for status bar display of the typed buffer
	
Public Methods:
    detectKey()
        - detects the keyCode, parses whether it is acceptable, and adds it to the typed buffer if so
    selectItem()
        - finds the first option that matches the typed buffer and selects it
    reset()
        - clears the typed buffer and the status display
    updateIndex()
        - handles the onclick and onblur events
    elementFocus()
        - handles the onfocus event
    elementKeydown()
        - handles the onkeydown event
********
	
***************************************************/
//function TypeAheadCombo (anElement,acceptNewValue) {
//	// DEGRADE UNSUPPORTED
//	if (document.layers) {
//		return;
//	}
//	// VALIDATION
//	if (!anElement) {
//		return false;
//	}
//	if (typeof anElement == "string") { // try for the ID
//		anElement = document.getElementById ? document.getElementById(anElement) : document.all ? document.all[anElement] : anElement;
//	}
//	if (typeof anElement == "string") { // the grab failed: typeof null yields "object"
//		return false;
//	}
//	// ASSOCIATION
//	this.element = anElement;
//	this.id = this.element.id + 'Combo';
//	this.element.combo = this;
//	// ELEMENT EVENT HANDLERS
//	if (this.element.addEventListener) {
//		// first try DOM2 methods
//		this.element.addEventListener("keydown", this.elementKeydown, false);
//		this.element.addEventListener("focus", this.elementFocus, false);
//		this.element.addEventListener("click", this.updateIndex, false);
//		this.element.addEventListener("blur", this.updateIndex, false);
//	} else {
//		// now try DOM0 methods
//		this.element.onkeydown = this.elementKeydown;
//		this.element.onfocus = this.elementFocus;
//		this.element.onclick = this.updateIndex;
//		this.element.onblur = this.updateIndex;
//	}
//	this.element.reset = this.reset;
//	// PRIVATE PROPERTIES
//	var self = this,	// corrects privatization bug
//		typed = "",
//		index = prev = 0,
//		displayStatus = true,
//		selector, resetter, nullStarter, acceptNew,
//		resetTime = 1600,
//		numberRangeStart = 48,
//		numberRangeEnd = 57,
//		charRangeStart = 65,
//		charRangeEnd = 90,
//		punctRangeStart = 146,
//		punctRangeEnd = 223;
//	if (this.element.options[0].text.length == 0 && (this.element.options[0].value.length == 0 || this.element.options[0].value == 0)) {
//		nullStarter = true;
//	} else {
//		nullStarter = false;
//	}
//	if (typeof acceptNewValue != 'undefined' && acceptNewValue) {
//		acceptNew = true;
//		resetTime = 2400;
//	} else {
//		acceptNew = false;
//	}
//	// PRIVATE METHODS
//	var getResetTime = function () {
//		return resetTime;
//	}
//	var charInRanges = function (charCode) {
//		if ((charCode >= numberRangeStart && charCode <= numberRangeEnd) || (charCode >= charRangeStart && charCode <= charRangeEnd) || (charCode >= punctRangeStart && charCode <= punctRangeEnd)) {
//			return true;
//		} else {
//			return false;
//		}
//	}
//	// PRIVILEDGED METHODS
//	this.hasNullStarter = function () {
//		return nullStarter;
//	}
//	this.getAcceptsNew = function () {
//		return acceptNew;
//	}
//	this.getTyped = function () {
//		return typed;
//	}
//	this.setTyped = function (str) {
//		typed = str;
//		return true;
//	}
//	this.resetTyped = function () {
//		typed = "";
//		return true;
//	}
//	this.type = function (str) {
//		typed += str;
//		return true;
//	}
//	this.getIndex = function () {
//		return index;
//	}
//	this.setIndex = function (val) {
//		if (!isNaN(val)) {
//			index = val;
//		}
//	}
//	this.getPrev = function () {
//		return (prev ? prev : 0);
//	}
//	this.setPrev = function (val) {
//		if (!isNaN(val)) {
//			prev = val;
//		}
//	}
//	this.setResetTime = function (val) {
//		if (!isNaN(val)) {
//			resetTime = val;
//		}
//	}
//	this.setResetTimer = function () {
//		resetter = setTimeout("document.forms['"+this.element.form.name+"'].elements['"+this.element.name+"'].reset();", getResetTime());
//	}
//	this.clearResetTimer = function () {
//		clearTimeout(resetter);
//	}
//	this.delayedSelect = function () {
//		selector = setTimeout("document.forms['"+this.element.form.name+"'].elements['"+this.element.name+"'].combo.selectItem();", 10);
//	}
//	this.cancelDelay = function () {
//		clearTimeout(selector);
//	}
//	this.validChar = function (evt, charCode) {
//		if ((evt.ctrlKey) || (evt.altKey)) {
//			return false;
//		} else if ((evt.shiftKey) && charInRanges(charCode)) {
//			return true;
//		} else if (evt.shiftKey) {
//			return false;
//		} else {
//			return charInRanges(charCode);
//		}
//	}
//	this.setDisplayStatus = function (bool) {
//		if (bool == true || bool == false) {
//			displayStatus = bool;
//		}
//	}
//	this.getDisplayStatus = function () {
//		return displayStatus;
//	}
//	this.cancel = function (evt) {
//		if (evt) {
//			evt.preventDefault();
//		} else {
//			window.event.returnValue = false;
//		}
//		return false;
//	}
//}

///*
//PUBLIC METHODS
//*/

//TypeAheadCombo.prototype.detectKey = function (evt){
//	this.clearResetTimer();
//	this.cancelDelay();
//	var combo_letter = "";
//	var combo_code = (evt) ? evt.keyCode : window.event ? window.event.keyCode : evt.which;
//	var event = (evt) ? evt : window.event;
//	if (combo_code <= 105 && combo_code >= 96) { // make up for numPad typing
//		combo_code = combo_code - 48;
//	}
//	switch (combo_code) {
//		case 27:	//ESC key
//			this.reset();
//			this.setIndex(this.getPrev());
//			// Put a little delay to override NS6/Mozilla's built-in behavior of ESC inside select element
//			setTimeout("document.forms['"+this.element.form.name+"'].elements['"+this.element.name+"'].selectedIndex = document.forms['"+this.element.form.name+"'].elements['"+this.element.name+"'].index",0);
//			return false;
//			break;
//		case 13:	//ENTER key
//		case 9:		//TAB key
//			this.reset();
//			if (this.element.onchange) {
//				// set timer to prevent stack overflow in IE.
//				setTimeout(eval("document.forms['" + this.element.form.name + "'].elements['" + this.element.name + "'].onchange()"), 1);
//			}
//			//eval("document.forms['" + this.element.form.name + "'].elements['" + this.element.name + "'].onchange()")
//			return true;
//			break;
//		case 8:		//BACKSPACE key
//			this.setTyped(this.getTyped().substring(0,this.getTyped().length-1));
//			if (this.getAcceptsNew() && this.getIndex() == 0) {
//				this.makeNewValue();
//			}
//			if (this.getTyped() == "") {
//				this.reset();
//				this.setIndex(this.getPrev());
//				this.element.selectedIndex = this.getIndex();
//				if (evt) {
//					evt.preventDefault();
//				} else {
//					window.event.returnValue = false;
//				}
//				return false;
//			} else {
//				this.setResetTimer();
//			}
//			break;
//		case 33:	//PAGEUP key
//		case 34:	//PAGEDOWN key
//		case 35:	//END key
//		case 36:	//HOME key
//		case 38:	//UP arrow
//		case 40:	//DOWN arrow
//			this.reset();
//			return true;
//			break;
//		case 37:	//LEFT arrow	(translates to %)
//		case 39:	//RIGHT arrow	(translates to ')
//			this.reset();
//			return false;
//			break;
//		case 32:	//SPACE key	(not in accepted ranges)
//			combo_letter = " ";
//			this.setResetTimer();
//			break;
//		default:
//			if (this.validChar(event, combo_code)) {
//				combo_letter = String.fromKeyCode(combo_code);
//				if (combo_letter.length > 1) {
//					if (event.shiftKey) {
//						combo_letter = combo_letter[1];
//					} else {
//						combo_letter = combo_letter[0];
//					}
//				}
//				this.setResetTimer();
//			} else {
//				return true;
//			}
//			break;
//	}
//	this.type(combo_letter);
//	if (this.getDisplayStatus()) {
//		window.status = this.getTyped();
//	}
//	if (document.all) {
//		return this.selectItem();
//	} else {
//		return this.delayedSelect();
//	}
//}

//TypeAheadCombo.prototype.selectItem = function (){
//	var i = this.element.options.length,
//		match = false;
//	do {
//		if (this.element.options[--i].text.toUpperCase().indexOf(this.getTyped().toUpperCase()) == 0){
//			this.element.selectedIndex = i;
//			this.setIndex(i);	//remember selected index
//			match = true;
//		}
//	} while (i > 0);
//	if (match) {
//		return false; // always return false;
//	}
//	if (this.getAcceptsNew()) {
//		this.makeNewValue();
//	} else {
//		this.element.selectedIndex = this.getIndex();	//re-select previously selected option even if there's no match
//	}
//	return false;  //always return false
//}

//TypeAheadCombo.prototype.makeNewValue = function () {
//	this.removeNewValue();
//	var tmpText = this.getTyped(),tmpStart = tmpEnd = "",tmpArr,i;
//	if (this.hasNullStarter()) {
//		newOption = this.element.options[0];
//	} else if (tmpText.length > 0) {
//		newOption = document.createElement("option");
//		this.element.insertBefore(newOption, this.element.firstChild);
//		this.newOption = newOption;
//	} else {
//		this.newOption = null;
//		return;
//	}
//	tmpArr = tmpText.split(" ");
//	i = tmpArr.length;
//	if (tmpText.indexOf(" ") >= 0) {
//		do {
//			tmpStart = tmpArr[--i].substring(0,1);
//			tmpEnd = tmpArr[i].substring(1,tmpArr[i].length);
//			tmpArr[i] = tmpStart.toUpperCase() + tmpEnd.toLowerCase();
//		} while (i);
//		tmpText = tmpArr.join(" ");
//	} else {
//		tmpStart = tmpText.substring(0,1);
//		tmpEnd = tmpText.substring(1,tmpText.length);
//		tmpText = tmpStart.toUpperCase() + tmpEnd.toLowerCase();
//	}
//	newOption.value = tmpText;
//	newOption.text = tmpText;
//	this.element.selectedIndex = 0;
//	this.setIndex(0);
//}

//TypeAheadCombo.prototype.removeNewValue = function () {
//	if (this.hasNullStarter()) {
//		this.element.options[0].text = '';
//		this.element.options[0].value = '';
//	} else if (this.newOption) {
//		this.element.remove(this.newOption);
//	}
//}

//TypeAheadCombo.prototype.setValueByValue = function (aValue) {
//	var i = this.element.options.length;
//	do {
//		if (this.element.options[--i].value == aValue) {
//			this.element.selectedIndex = i;
//			break;
//		}
//	} while (i);
//}

//TypeAheadCombo.prototype.reset = function () {
//	theCombo = this;
//	if (this.combo) {
//		theCombo = this.combo;
//	}
//	theCombo.element.selectedIndex = theCombo.getIndex();
//	theCombo.resetTyped();
//	if (theCombo.getDisplayStatus()) {
//		window.status = window.defaultStatus ? window.defaultStatus : '';
//	}
//}

//TypeAheadCombo.prototype.updateIndex = function (evt){
//	var theCombo, theEl;
//	if (evt && window.addEventListener) {
//		// ready for handler with DOM2 event properties
//		var e = new DOM2Event(evt, window.event, this);
//		theEl = e.target;
//	} else {
//		theEl = this;
//	}
//	theCombo = theEl.combo;
//	theCombo.setIndex(theEl.selectedIndex);
//	theCombo.setPrev(theCombo.getIndex());
//}

//TypeAheadCombo.prototype.elementFocus = function (evt) {
//	var theCombo;
//	if (evt && window.addEventListener) {
//		// ready for handler with DOM2 event properties
//		var e = new DOM2Event(evt, window.event, this);
//		theCombo = e.target.combo;
//	} else {
//		theCombo = this.combo;
//	}
//	theCombo.setIndex(theCombo.element.selectedIndex);
//}

//TypeAheadCombo.prototype.elementKeydown = function (evt) {
//	var theCombo;
//	if (evt && window.addEventListener) {
//		// ready for handler with DOM2 event properties
//		if (DOM2Event) {
//			var e = new DOM2Event(evt, window.event, this);
//		}
//		theCombo = e.target.combo;
//	} else {
//		theCombo = this.combo;
//	}
//	if (!theCombo.detectKey(e)) {
//		return theCombo.cancel(e);
//	}
//}
//______________________________TYPE AHEAD COMBO END_______________________________

//header row, data row, data div, header div
function init(rhe, fre, dse, hse) {
    var rh = document.getElementById(rhe);
    var fr = document.getElementById(fre);
    var ds = document.getElementById(dse);
    var hs = document.getElementById(hse);
    //alert(hs.style);

    //alert('onbefscroll')
    hs.style.top = ds.offsetTop;
    hs.style.left = ds.offsetLeft;
    hs.style.visibility = 'visible';
    //
    // alert(ds.onscroll)
    //alert(ds);
    //window.onresize=syncResize;
    //alert('sync resize')
    //syncResize(hs,ds,rh,fr);
    ds.onresize = function () {



        //document.recalc(true);
        for (i = 0; i < rh.childNodes.length; i++) {
            if (fr.childNodes[i].offsetWidth >= rh.childNodes[i].offsetWidth)
                rh.childNodes[i].width = fr.childNodes[i].offsetWidth;
            else
                fr.childNodes[i].width = rh.childNodes[i].offsetWidth;
            //
            // document.recalc(true);

        }
        document.recalc();
        //  hs.style.top = ds.offsetTop;
        //  hs.style.left = ds.offsetLeft;
        //  hs.style.visibility = 'visible';

        hs.style.width = ds.offsetWidth - (ds.offsetWidth - ds.clientWidth);
        if (navigator.userAgent.toLowerCase().indexOf('gecko') != -1) {
            alert('gecko');
            hs.style.overflow = '-moz-scrollbars-none';
        }
        //  alert(ds.offsetTop + ":" + hs.offsetTop + hs.id)
        // fr.style.top = 150;

        //ds.style.top =  rh.offsetHeight;// + hs.style.height; 
        //
    }

    //fr.style.top = rh.style.offsetTop;// + rh.style.height;

    ds.onresize();

    ds.onscroll = function () {
        //alert('scroll')
        hs.scrollLeft = ds.scrollLeft;//document.recalc(true);
        //document.recalc(true);
    } //syncScroll//(hs,ds);
    /*   try
      {
       
        //ds.onscroll = eval('malert()');
        }
        catch e {}
      */
}

/*
function syncScroll(hs,ds) {

 hs.scrollLeft = ds.scrollLeft;
  
}
*//*
function syncResize(hs,ds,rh,fr) {
// alert(hs)
  hs.style.width = ds.offsetWidth-(ds.offsetWidth - ds.clientWidth);
  
  for( i =0; i < rh.childNodes.length; i++ ) {
     rh.childNodes[i].width = fr.childNodes[i].offsetWidth;
  } 
}
*/
//Added By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10

//Added By ShrikantB On 12 Aug 2008 For Issue Id 21844
function validateNumPaging(FormName, name, MaxPageSize, PositiveValueMsg, MaxRangeMsg, MinRangeMsg) {

    var objTextBox = GetObjectReference(FormName, name);

    if ((disallowNegativeInteger(objTextBox) == true) || (disallowBlank(objTextBox) == true)) {
        //alert('Please Enter only positive integer');
        alert(PositiveValueMsg);
        return false;
    }

    if (objTextBox.value < 1) {
        //alert('Please Enter value greater than or equal to 1');
        alert(MinRangeMsg);
        return false;
    }
    if (objTextBox.value > MaxPageSize) {
        //alert('Please Enter value less than or equal to ' + MaxPageSize);
        alert(MaxRangeMsg);
        return false;
    }


    return true;
}
//Addition End By ShrikantB On 12 Aug 2008 For Issue Id 21844

function numeric_nav_prev_click(FormName, PagePath, CurrentPageNo, MaxPageSize, name, PositiveValueMsg, FirstRecordMsg, MaxRangeMsg, MinRangeMsg)//Modified By Shrikant B On 12 Aug 2008 For Issue ID 21844 :ADD MaxRangeMsg and MinRangeMsg
{
    var objTextBox = GetObjectReference(FormName, name);

    //Added By Shrikant B On 12 Aug 2008 For Issue Id 21844
    if (!validateNumPaging(FormName, name, MaxPageSize, PositiveValueMsg, MaxRangeMsg, MinRangeMsg))
        return;

    if (parseInt(objTextBox.value) <= 1) {
        //alert('This is the first page');
        alert(FirstRecordMsg);
        return;
    }
    var objfrm;
    objfrm = GetFormReference(FormName);
    objfrm.action = PagePath + "&PagingNavigation=PREV";
    objfrm.submit();
}

function numeric_nav_next_click(FormName, PagePath, CurrentPageNo, MaxPageSize, name, PositiveValueMsg, LastRecordMsg, MaxRangeMsg, MinRangeMsg)//Modified By Shrikant B On 12 Aug 2008 For Issue ID 21844 :ADD MaxRangeMsg And MinRangeMsg
{

    var objTextBox = GetObjectReference(FormName, name);
    //Added By Shrikant B On 12 Aug 2008 For Issue Id 21844
    if (!validateNumPaging(FormName, name, MaxPageSize, PositiveValueMsg, MaxRangeMsg, MinRangeMsg))
        return;
    if (parseInt(objTextBox.value) + 1 > MaxPageSize) {
        alert(LastRecordMsg);
        return;
    }

    var objfrm;
    objfrm = GetFormReference(FormName);
    objfrm.action = PagePath + "&PagingNavigation=NEXT";
    objfrm.submit();
}

function numeric_paging_OnKeyPress(e, FormName, PagePath, CurrentPageNo, MaxPageSize, name, PositiveValueMsg, MinRangeMsg, MaxRangeMsg) {

    var code;
    if (e.keyCode) code = e.keyCode;
    else if (e.which) code = e.which;
    if (code == 13) {
        var objTextBox = GetObjectReference(FormName, name);

        //Added By Shrikant B On 12 Aug 2008 For Issue Id 21844
        if (!validateNumPaging(FormName, name, MaxPageSize, PositiveValueMsg, MaxRangeMsg, MinRangeMsg))
            return;
        //Addition End By Shrikant B On 12 Aug 2008 For Issue Id 21844

		/*Commented By Shrikant B On 12 Aug 2008
		            if (disallowNegativeInteger(objTextBox) == true)
		            {
			            //alert('Please Enter only positive integer');
			            alert(PositiveValueMsg);
			            return;
		            } 
		
            		if (objTextBox.value < 1)
          			{
            				//alert('Please Enter value greater than or equal to 1');
           				alert(MinRangeMsg);
          				return;
           			}
           		if (objTextBox.value > MaxPageSize)
            			{
           				//alert('Please Enter value less than or equal to ' + MaxPageSize);
          				alert(MaxRangeMsg);
           				return;
          		}
        Commenteb By Shrikant B On 12 Aug 2008*/

        var objfrm;
        objfrm = GetFormReference(FormName);
        objfrm.action = PagePath + "&PagingNavigation=CURR&PagingControl=" + name;
        //alert(objfrm.action);
        objfrm.submit();
    }
    else {
        if ((code >= 48 && code <= 57) == false) {
            if (navigator.appName == 'Microsoft Internet Explorer')
                e.keyCode = 0
            else
                return false;
        }
    }
}
//End Of Addition By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
//Added By NileshD on 4 Oct 2005 ReqID -  WAF3_PB_10
//Modified following two functions By PushkarK On 04-Oct-2007 for IssueID: 15627
function numeric_nav_first_click(FormName, PagePath, CurrentPageNo, FirstRecordMsg) {
    if (CurrentPageNo == 1) {
        alert(FirstRecordMsg);
        return;
    }
    var objfrm;
    var strPaging;
    strPaging = "&PagingNumber=" + CurrentPageNo;
    PagePath = replaceSubstring(PagePath, strPaging, "");
    objfrm = GetFormReference(FormName);
    objfrm.action = PagePath + "&PagingNumber=1";
    objfrm.submit();
}

function numeric_nav_last_click(FormName, PagePath, CurrentPageNo, MaxPageSize, LastRecordMsg) {
    if (CurrentPageNo == MaxPageSize) {
        alert(LastRecordMsg);
        return;
    }
    var objfrm;
    var strPaging;
    strPaging = "&PagingNumber=" + CurrentPageNo;
    PagePath = replaceSubstring(PagePath, strPaging, "");
    objfrm = GetFormReference(FormName);
    objfrm.action = PagePath + "&PagingNumber=" + MaxPageSize;
    objfrm.submit();
}
//------------------------------------------------------------------------------
//Purpose : Select all check boxes
//------------------------------------------------------------------------------
function SelectAllCheckboxs(strFormName, strCheckbox)
//Pass FormName and the Checkbox's ID
{
    var objCheckbox = GetObjectReference(strFormName, strCheckbox, true);
    var intItems;
    var intCtr;

    if (objCheckbox != null) {
        intItems = objCheckbox.length;
        if (intItems > 1) {
            for (intCtr = 0; intCtr <= intItems - 1; intCtr++) {

                if (objCheckbox[intCtr].disabled == false) {
                    objCheckbox[intCtr].checked = 'checked';
                }

            }
        }
        // Else, if single element exists, then...
        else if (intItems == 1) {
            if (objCheckbox[0].disabled == false)
                objCheckbox[0].checked = true;
        }
    }

}
//End Of Adiition ReqID -  WAF3_PB_10
// Added By NileshD on 14 Nov 2005 for REQID:WAF3_PB_12
function DateControl_StandardOnblur(formname, controlname, format, message) {
    var RowIndex = (arguments.length > 4) ? arguments[4] : "0"; //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    if (validateFormat(formname, controlname, format, message, RowIndex) == true)
        return true;
    else
        return false;

}
function validateFormat(formname, controlname, format, message)
/*
FUNCTION	:	validateFormat()
I/P PARAM	:	value, format for the date string
RETURNS		:	separator
*/ {
    var objRegExp;
    var objControl;
    var objOriginalControl;
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var RowIndex = (arguments.length > 4) ? arguments[4] : "0";
    if (RowIndex == "0") {
        objControl = GetObjectReference(formname, 'FFE29587WHIZ_' + controlname);
        //Added By Bharat T on 13th-Oct-2015
        if (objControl == null)
            objControl = GetObjectReference(formname, controlname);
        //End of Added By Bharat T on 13th-Oct-2015
        if (objControl)
            //
            objOriginalControl = GetObjectReference(formname, controlname);
    }
    else {
        objControl = GetObjectReference(formname, 'FFE29587WHIZ_' + controlname, true)[parseInt(RowIndex) - 1];
        //Added By Bharat T on 13th-Oct-2015
        if (objControl == null)
            objControl = GetObjectReference(formname, controlname, true)[parseInt(RowIndex) - 1];
        //End od Added By Bharat T on 13th-Oct-2015
        objOriginalControl = GetObjectReference(formname, controlname, true)[parseInt(RowIndex) - 1];
    }
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var originalDate;
    var standardDate;
    var arrDate;
    var arrFormat;
    var intCount;
    var separator;
    var formatSeparator;
    if (objControl.value == '') {
    objOriginalControl.value = '';
        return true;
    }
    objControl.value = Trim(objControl.value);
    arrFormat = format.split('/');
    formatSeparator = '/';
    if (arrFormat.length != 3) {
        arrFormat = format.split('-');
        formatSeparator = '-';
        if (arrFormat.length != 3) {
            arrFormat = format.split('.');
            formatSeparator = '.';
        }
    }
    format = format.toUpperCase();
    switch (true) {
        case (formatSeparator == '/'):
            {
                objControl.value = replaceSubstring(objControl.value, '.', formatSeparator);
                objControl.value = replaceSubstring(objControl.value, '-', formatSeparator);
                break;
            }
        case (formatSeparator == '-'):
            {
                objControl.value = replaceSubstring(objControl.value, '.', formatSeparator);
                objControl.value = replaceSubstring(objControl.value, '/', formatSeparator);
                break;
            }
        case (formatSeparator == '.'):
            {
                objControl.value = replaceSubstring(objControl.value, '/', formatSeparator);
                objControl.value = replaceSubstring(objControl.value, '-', formatSeparator);
                break;
            }
    }

    arrFormat = objControl.value.split(formatSeparator);
    if (arrFormat.length != 3) {
        if (message != '')
            alert(message);
        if (navigator.appName == 'Microsoft Internet Explorer')
            setFocus(objControl);
        else
            window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1); return false;
        return false;
    }
    switch (true) {
        case (format == 'DD-MM-YYYY' || format == 'DD.MM.YYYY' || format == 'DD/MM/YYYY'):
            {
                objRegExp = /^(0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])[-\/.](19|20)\d\d$/;
                if (objControl.value.length != 10) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'D');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'M');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'YYYY');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'MM-DD-YYYY' || format == 'MM.DD.YYYY' || format == 'MM/DD/YYYY'):
            {
                objRegExp = /^(0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](19|20)\d\d$/;
                if (objControl.value.length != 10) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'M');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'D');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'YYYY');

                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'YYYY-DD-MM' || format == 'YYYY.DD.MM' || format == 'YYYY/DD/MM'):
            {
                objRegExp = /^(19|20)\d\d[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])$/;
                if (objControl.value.length != 10) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'YYYY');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'D');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'M');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'YYYY-MM-DD' || format == 'YYYY.MM.DD' || format == 'YYYY/MM/DD'):
            {
                objRegExp = /^(19|20)\d\d[-\/.](0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])$/;
                if (objControl.value.length != 10) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'YYYY');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'M');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'D');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'DD-MM-YY' || format == 'DD.MM.YY' || format == 'DD/MM/YY'):
            {
                objRegExp = /^(0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])[-\/.]\d\d$/;
                if (objControl.value.length != 8) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'D');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'M');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'YY');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'MM-DD-YY' || format == 'MM.DD.YY' || format == 'MM/DD/YY'):
            {
                objRegExp = /^(0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.]\d\d$/;
                if (objControl.value.length != 8) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'M');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'D');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'YY');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'YY-DD-MM' || format == 'YY.DD.MM' || format == 'YY/DD/MM'):
            {
                objRegExp = /^\d\d[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])$/;
                if (objControl.value.length != 8) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'YY');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'D');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'M');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        case (format == 'YY-MM-DD' || format == 'YY.MM.DD' || format == 'YY/MM/DD'):
            {
                objRegExp = /^\d\d[-\/.](0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])$/;
                if (objControl.value.length != 8) {
                    arrDate = objControl.value.split(formatSeparator);
                    arrDate[0] = FormatDayMonthYear(arrDate[0], 'YY');
                    arrDate[1] = FormatDayMonthYear(arrDate[1], 'M');
                    arrDate[2] = FormatDayMonthYear(arrDate[2], 'D');
                    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
                    //alert(objControl.value);     
                }
                break;
            }
        default:
            if (message != '')
                alert(message);
            if (navigator.appName == 'Microsoft Internet Explorer')
                setFocus(objControl);
            else
                window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1);
            return false;
            break;
    }

    if (!objRegExp.test(objControl.value) == true) {
        //invalid format return false
        if (message != '')
            alert(message);
        if (navigator.appName == 'Microsoft Internet Explorer')
            setFocus(objControl);
        else
            window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1);
        return false;
    }
    else {
        // date format pattern matched!

        //check the validity of the separator and get the separator
        separator = formatSeparator; //getSeparator(objControl.value, format);
        //validate the date now
        standardDate = '';
        standardDate = ConvertDateToStanderFormat(formname, controlname, format, separator, RowIndex);//Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
        if (standardDate != '') {
            objOriginalControl.value = standardDate;
            //alert(objOriginalControl.value);
            originalDate = objControl.value;
            objControl.value = standardDate;
            if (isDate(objControl, null, false) == true) {
                objControl.value = originalDate;
                //alert(objControl.value);
                return true;
            }
            objControl.value = originalDate;
            if (message != '')
                alert(message);
            if (navigator.appName == 'Microsoft Internet Explorer')
                setFocus(objControl);
            else
                window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 0);
            return false;
            //alert(objControl.value);
        }

    }
    return false;
}


function ConvertDateToStanderFormat(formname, controlname, format, separator)
/*
FUNCTION	:	ConvertDateToStanderFormat()
I/P PARAM	:	date string to be checked, format for the string
RETURNS		:	true if valid else false
*/ {
    var intDay;
    var strMonth;
    var intYear;
    var strSeparator;
    var arrayDate;
    var datePos;
    var monthPos;
    var yearPos;
    var fullDate = '';
    var arrayLookup = { '01': 'Jan', '02': 'Feb', '03': 'Mar', '04': 'Apr', '05': 'May', '06': 'Jun', '07': 'Jul', '08': 'Aug', '09': 'Sep', '10': 'Oct', '11': 'Nov', '12': 'Dec' };
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var objControl;
    var RowIndex = (arguments.length > 4) ? arguments[4] : "0";
    if (RowIndex == "0")
        objControl = GetObjectReference(formname, 'FFE29587WHIZ_' + controlname);
    else
        objControl = GetObjectReference(formname, 'FFE29587WHIZ_' + controlname, true)[parseInt(RowIndex) - 1];
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007

    switch (true) {
        case (format == 'DD-MM-YYYY' || format == 'DD.MM.YYYY' || format == 'DD/MM/YYYY'):
            datePos = 0;
            monthPos = 1;
            yearPos = 2;
            break;
        case (format == 'MM-DD-YYYY' || format == 'MM.DD.YYYY' || format == 'MM/DD/YYYY'):
            datePos = 1;
            monthPos = 0;
            yearPos = 2;
            break;
        case (format == 'YYYY-DD-MM' || format == 'YYYY.DD.MM' || format == 'YYYY/DD/MM'):
            datePos = 1;
            monthPos = 2;
            yearPos = 0;
            break;
        case (format == 'YYYY-MM-DD' || format == 'YYYY.MM.DD' || format == 'YYYY/MM/DD'):
            datePos = 2;
            monthPos = 1;
            yearPos = 0;
            break;
        case (format == 'DD-MM-YY' || format == 'DD.MM.YY' || format == 'DD/MM/YY'):
            datePos = 0;
            monthPos = 1;
            yearPos = 2;
            break;
        case (format == 'MM-DD-YY' || format == 'MM.DD.YY' || format == 'MM/DD/YY'):
            datePos = 1;
            monthPos = 0;
            yearPos = 2;
            break;
        case (format == 'YY-DD-MM' || format == 'YY.DD.MM' || format == 'YY/DD/MM'):
            datePos = 1;
            monthPos = 2;
            yearPos = 0;
            break;
        case (format == 'YY-MM-DD' || format == 'YY.MM.DD' || format == 'YY/MM/DD'):
            datePos = 2;
            monthPos = 1;
            yearPos = 0;
            break;
        default:
            return fullDate;
            break;
    }


    //get the array with date variables
    arrayDate = objControl.value.split(separator);

    //the date
    intDay = arrayDate[datePos];
    strMonth = arrayLookup[arrayDate[monthPos]];
    intYear = arrayDate[yearPos];
    if (intYear.length == 2)
        if (intYear.substring(0, 1) == '0')
            intYear = 2000 + parseInt(intYear.substring(1, 2));
        else
            intYear = 2000 + parseInt(intYear.toString());
    fullDate = intDay.toString() + '-' + strMonth + '-' + intYear.toString();
    //alert(fullDate + ' ' + format);
    return fullDate;
}

function getSeparator(value, format)
/*
FUNCTION	:	getSeparator()
I/P PARAM	:	format for the date string
RETURNS		:	separator
*/ {

    var separator;
    switch (true) {
        case (format == "MM-DD-YY" || format == "DD-MM-YY" || format == "YY-MM-DD" || format == "YY-DD-MM" || format == "MM-DD-YYYY" || format == "DD-MM-YYYY"):
            separator = value.substring(2, 3);
            if (separator == "-")
                return "-"
            else
                return "";
            break;
        case (format == "YYYY-MM-DD" || format == "YYYY-DD-MM"):
            separator = value.substring(4, 5);
            if (separator == "-")
                return "-"
            else
                return "";
            break;
        case (format == "MM.DD.YY" || format == "DD.MM.YY" || format == "YY.MM.DD" || format == "YY.DD.MM" || format == "MM.DD.YYYY" || format == "DD.MM.YYYY"):
            separator = value.substring(2, 3);
            if (separator == ".")
                return "."
            else
                return "";
            break;
        case (format == "YYYY.MM.DD" || format == "YYYY.DD.MM"):
            separator = value.substring(4, 5);
            if (separator == ".")
                return "."
            else
                return "";
            break;
        case (format == "MM/DD/YY" || format == "DD/MM/YY" || format == "YY/MM/DD" || format == "YY/DD/MM" || format == "MM/DD/YYYY" || format == "DD/MM/YYYY"):
            separator = value.substring(2, 3);
            if (separator == "/")
                return "/"
            else
                return "";
            break;
        case (format == "YYYY/MM/DD" || format == "YYYY/DD/MM"):
            separator = value.substring(4, 5);
            if (separator == "/")
                return "/"
            else
                return "";
            break;
        default:
            break;
    }
    return "";
}
function FormatDayMonthYear(value, format) {
    switch (true) {
        case (format == 'D' || format == 'M' || format == 'YY'):
            {
                if (value.length < 2)
                    value = '0' + value;
                break;
            }
        case (format == 'YYYY'):
            {
                if (value.length < 4) {
                    if (value.length == 3)
                        value = '2' + value;
                    if (value.length == 2)
                        value = '20' + value;
                    if (value.length == 1)
                        value = '200' + value;
                }
            }
        default:
            break;
    }

    return value;
}
//End Of Addition By NileshD on 14 Nov 2005 for REQID:WAF3_PB_12
//Added By UmeshJ on 04 Apr 2006
//Added By NinadP :	13 Feb 2007 : Requirement Tag - WAF3_PB_33

function DisplayLookup(frmName, ControlName, ControlCaption, ParentTagID, TagID, ControlTagID, IsEdit, GroupingColumn, ConnectionID, bIsModalPopupEnabled, RowIndex) {
    //Modified Function Definition - Added parameter bIsModalPopupEnabled for Modal Popup integration
    //By NikhilM 26 Oct 2010
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var RowIndex = (arguments.length > 10) ? arguments[10] : "0";
    var objDS;
    var bAllowDragForModalPopup = true;
    //Added By Shrikant B On 27 June 2008 For Issue ID 4717
    if (frmName == "frmMultiInsetGrid") {

        var strControlName;
        if (RowIndex.length == 1)
            strControlName = ControlName.substring(0, ControlName.length - 1);
        else
            strControlName = ControlName.substring(0, ControlName.length - 2);

        objDS = GetObjectReference(frmName, 'hd' + strControlName);
        RowIndex = 0;
    }
    //Addition End By Shrikant B On 27 June 2008 For Issue ID 4717
    else {
        if (RowIndex == "0")
            objDS = GetObjectReference(frmName, 'hd' + ControlName);
        else
            objDS = GetObjectReference(frmName, 'hd' + ControlName, true)[parseInt(RowIndex) - 1];
    }
    RowIndex = '&RowIndex=' + RowIndex
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
    strAddress = "../General/Lookup_CommonList.aspx?FormName=" + frmName + "&ControlName=" + ControlName + "&ControlCaption=" + ControlCaption + "&ParentTagID=" + ParentTagID + "&TagID=" + TagID + "&ControlTagID=" + ControlTagID + "&IsEditMode=" + IsEdit + "&GroupingColumn=" + GroupingColumn + "&DS=" + objDS.value + "&ConnectionID=" + ConnectionID + RowIndex; //Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    strParameters = "resizable=yes,left=" + (window.screen.width - 545) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=545,height=500";

    //call this method only when the framework key for modal dialog is enabled
    /*
        Parameters: 1 - Target Url 
                    2 - width
                    3 - height (added by NikhilM 3 Nov 2010 for allowing to set height of modal popup div)	                    
                    4 - Top position for div of modal popuo
                    5 - Caption to be displayed as title of modal popup
                    6 - Enable DragDrop for modal popup (default allowed)
                    7 - Opacity (Range - 0 to 10)
    */
    if (bIsModalPopupEnabled == 'True') {
        if (ParentTagID == '0' || RowIndex.search(/0/i) == -1)
            SetModalPopupParams(strAddress, 430, 0, 70, ControlCaption, bAllowDragForModalPopup, 6);
        else
            SetModalPopupParams(strAddress, 215, 0, 35, ControlCaption, bAllowDragForModalPopup, 6);
    }
    else {
        window.open(strAddress, "Lookup", strParameters);
    }
}
//End of Addition
//MyViews called from CommonList Page WAF3_PB_24 NinadP
function MyViews(TagID) {
    window.open("../General/ViewProperties_CommonList.aspx?MasterTagID=1719&TagID=" + TagID, "MyViews", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 800) / 2) + ",top=" + ((window.screen.height - 500) / 2) + ",width=800,height=500");
}
//Added By Chakshuta H on 13th Oct 2015
/*	onSelection (FormName , ChangedControlName , Dependand Control , TagID , Primary Key , 'ADD/EDIT' , ProjectID )
	This method can be called to plot the dependent controls
	Customer -> Product ,
	Product -> Component 
*/
function onSelection(strFrm, strCtrl, strDependentCtrl, strTagID, strPK, strMode, ProjectID) {
    var objCbo; var strUrl; var strMasterPKValue; var depCbo;
    var strCustomerControlValue;
    var strComponentValue;

    var ProjectID = (arguments.length > 6) ? arguments[6] : false;
    if (ProjectID == false) {
        ProjectID = '';
    }

    if (GetObjectReference(strFrm, strPK))
        strMasterPKValue = GetObjectReference(strFrm, strPK).value;
    else
        strMasterPKValue = 0;

    global_strFrm = strFrm; global_strDependentCtrl = strDependentCtrl;
    objCbo = GetObjectReference(strFrm, strCtrl);
    depCbo = GetObjectReference(strFrm, strDependentCtrl);
    // Modification By NitinVS on 7 Jun 2006 
    // if the dependant control is having any value selected then only set the values else set to 0  
    if (depCbo.selectedIndex != -1)
        depCboValue = depCbo[depCbo.selectedIndex].value;
    // End Modification By NitinVS on 7 Jun 2006 
    if (objCbo != null) {
        if (objCbo.value != '0' || objCbo.value != '') {
            strUrl = new String();
            //Added By MahendraV On 12:54 PM 6/7/2007 for ReviewType value along with TaskType
            //Start_MV_6/7/2007
            if (strTagID == '2010') {

                strUrl = "../General/XMLHttp.aspx?TagID=" + strTagID + "&PhaseTaskID=" + objCbo.value;

            }
            else {
                //End_MV_6/7/2007
                if (objCustomerCBO != null) {
                    strCustomerControlValue = objCustomerCBO.value;
                    if (strCustomerControlValue != 0) {
                        strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=" + strCustomerControlValue + "&MasterPKField=" + strPK + "&MasterPKValue=" + strMasterPKValue + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                    }
                    else {
                        strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=0&MasterPKField=" + strPK + "&MasterPKValue=" + strMasterPKValue + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                    }
                }
                else {
                    strUrl = "../PRD/PRD_CommonFunctions.aspx?TagID=" + strTagID + "&CustomerComboValue=NULL&MasterPKField=" + strPK + "&MasterPKValue=" + strMasterPKValue + "&DependentControlName=" + strDependentCtrl + "&CboValue=" + objCbo.value + "&ProjectID=" + ProjectID;
                }
            }

            if (objCbo.selectedIndex > -1) {
                //INSTANTIATE XmlHttpRequest
                // Checking if IE-specific document.all collection exists 
                // TO SEE IF WE ARE RUNNING IN IE 

                //Commented And Added By Usha Pandit On 23.03.2020 For getting Review Type for selected Task Type
                //if (document.all)
                //{ 
                if (isIE() == 'IE') {
                    //End Of Added By Usha Pandit On 23.03.2020 For getting Review Type for selected Task Type
                    objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    //hook the event handler
                    objXHttp.onreadystatechange = HandlerOnReadyState;

                    //prepare the call, http method=GET, false=asynchronous call
                    objXHttp.open("GET", strUrl, false);
                    //finally send the call
                    objXHttp.send();
                }
                else {
                    // Mozilla - based browser 
                    objXHttp = new XMLHttpRequest();
                    //hook the event handler
                    objXHttp.onreadystatechange = HandlerOnReadyState();
                    //prepare the call, http method=GET, false=asynchronous call
                    objXHttp.open("GET", strUrl, false);
                    //finally send the call
                    objXHttp.send(null);

                    // Modified By MahendraV On 12:29 PM 7/25/2007 For PMLifeLine
                    // To Mozilla - based browser , Netscape- based browser
                    // Start_MV_7/25/2007
                    if (objXHttp.responseText != null) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        //xmlDoc.load(req.responseXML);
                        if (isIE() == 'FF')//Added by Nilesh g on date 10/11/2016 Purpose:Cobobox Issue 
                            xmlDoc.load(objXHttp.responseXML);
                        HandlerOnReadyState();

                    }

                    // End_MV_7/25/2007
                }
            }
        }
    }
}


function HandlerOnReadyState() {
    var strNavigator = navigator.appName;
    strNavigator = strNavigator.toUpperCase();

    var objCbo = GetObjectReference(global_strFrm, global_strDependentCtrl);
    if (objXHttp.readyState == 4) {

        var i = 0;
        var objOption;
        var strText = new String();
        var arrValue = new Array();
        var arrStr = new Array();
        objCbo.innerHTML = "";
        if (objXHttp.status == 200) {
            //responseXML contains an XMLDOM object
            if (objXHttp.responseText != null) {

                strText = objXHttp.responseText;
                arrStr = strText.split("|");
            }
            for (i = 0; i < arrStr.length; i++) {
                objOption = new Option();
                arrValue = arrStr[i].split("->");
                objOption.text = arrValue[0];
                objOption.value = arrValue[1];
                // Modified By MahendraV On 4:51 PM 7/25/2007 For PMLifeLine
                // To Mozilla - based browser , Netscape- based browser
                // Start_MV_7/25/2007
                if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
                    objCbo.add(objOption);
                else
                    objCbo.add(objOption, null);
                // End_MV_7/25/2007
                if (arrValue[1] == depCboValue) {
                    arrValue[1].selectedIndex = arrValue.length - 1;
                }
                objOption = null;
            }
        }
    }
}

//End Of Added By Chakshuta H on 13th Oct 2015
//WAF3_PB_42 April 06, 2007 START
//on load function
var DraftQueryMsg;
var objdivlist;
function window_onload() {

    if (objdivlist != null) {
        var intFillFactor = (arguments.length > 0) ? arguments[0] : 40;
        windowSize_common(intFillFactor);
    }
    // if there is a message to display 
    if (DraftQueryMsg != null) {
        if (trimString(DraftQueryMsg) != "") {
            alert(DraftQueryMsg);
        }
    }
}
function window_onresize() {
    var intFillFactor = (arguments.length > 0) ? arguments[0] : 40;
    windowSize_common(intFillFactor);
    try { hideAll(); } catch (e) { }
}
function windowSize_common(intFillFactor) {

    if (objdivlist != null) {
        var intDivHeight;
        if (navigator.appName == 'Microsoft Internet Explorer') {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - intFillFactor;
        }
        else {
            intDivHeight = window.innerHeight - objdivlist.offsetTop - intFillFactor;
        }
        if (intDivHeight < 100)
            intDivHeight = '100';
        //alert(objdivlist.style.height);
        objdivlist.style.height = intDivHeight + 'px';
    }
}
// This function returns Internet Explorer's major version number,
// or 0 for others. It works by finding the "MSIE " string and
// extracting the version number following the space, up to the decimal
// point, ignoring the minor version number
function msieversion() {
    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE ");

    if (msie > 0)      // If Internet Explorer, return version number
        return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)));
    else                 // If another browser, return 0
        return 0
}
//WAF3_PB_42 April 06, 2007 END
//WAF3_PB_44 May 09, 2007 START
function TabControl_OnClick(index, NoOfTabs, formID, Tabdiv) {
    for (i = 0; i < NoOfTabs; i++) {
        var oDiv = GetObjectReference(formID, Tabdiv + i);
        var oHREF = GetObjectReference(formID, 'HREF' + Tabdiv + i);
        if (oDiv != null) {
            if (i == index) { oDiv.style.display = 'block'; oHREF.className = 'clsTabSelected'; }
            else { oDiv.style.display = 'none'; oHREF.className = 'navtab'; }
        }
    }
}
//WAF3_PB_44 May 09, 2007 END

//WAF3_PB_47 17-May-2007 START
var WHIZ_TD_ROLLED_OVER;
var WHIZ_TD_PREVIOUS_BG_IMG = 'none';
var WHIZ_DIV_CONTEXT_MENU;
function SetPositionForContextMenu(ev, sContextMenuID) {
    var intX, intY, intBottom;
    var objContextMenu = GetObjectReference('', sContextMenuID);
    if (objContextMenu) {
        objContextMenu.style.display = '';
        intX = ev.clientX;
        intY = ev.clientY;
        intBottom = document.body.offsetTop + document.body.offsetHeight;

        if (intBottom - intY < objContextMenu.offsetHeight) { intY = intY - objContextMenu.offsetHeight; }

        objContextMenu.style.left = intX + 'px';
        objContextMenu.style.top = intY + 'px';

        /*if there are multiple context menu, then following
          object will be used to reset/hide the div*/
        WHIZ_DIV_CONTEXT_MENU = objContextMenu;
        if (WHIZ_TD_ROLLED_OVER) {
            WHIZ_TD_ROLLED_OVER.style.backgroundImage = GetStyleSheetImagePath();
        }

    }
}
function GetStyleSheetImagePath() {
    var strPath = '../../images/cssImages/';
    var objLnkStyle = GetObjectReference('', 'lnkWhizStyleSheetImgDir');
    if (objLnkStyle) {
        strPath = objLnkStyle.href;
        if (!strPath) { strPath = '../../images/cssImages/'; }
        else if (strPath == '') { strPath = '../../images/cssImages/'; }
    }
    strPath = 'url(' + strPath + 'tdRolledOver.jpg)';
    return strPath;
}
function SetRolledOverTD(obj, sContextMenuID) {
    var strImgPath = GetStyleSheetImagePath();
    var objContextMenu = GetObjectReference('', sContextMenuID);
    if (obj) {
        if (obj != WHIZ_TD_ROLLED_OVER) {
            objContextMenu.style.display = 'none';
            if (WHIZ_TD_ROLLED_OVER) {
                WHIZ_TD_ROLLED_OVER.style.backgroundImage = WHIZ_TD_PREVIOUS_BG_IMG;
            }
            WHIZ_TD_PREVIOUS_BG_IMG = obj.style.backgroundImage;
        }
        obj.style.backgroundImage = strImgPath;
        //Commented by Vinay on 30 Sept. 2008
        //obj.style.cursor='hand';
        obj.style.cursor = 'pointer';
        //Commented End by Vinay on 30 Sept. 2008 Reason:-in firefox cursor:pointer 
        WHIZ_TD_ROLLED_OVER = obj;
    }
}
function HideContextMenu() {
    if (WHIZ_DIV_CONTEXT_MENU) {
        WHIZ_DIV_CONTEXT_MENU.style.display = 'none';
        if (WHIZ_TD_ROLLED_OVER) {
            WHIZ_TD_ROLLED_OVER.style.backgroundImage = WHIZ_TD_PREVIOUS_BG_IMG;
        }
    }
}
//WAF3_PB_47_Extended: Starts
function ReplaceSubStringForCtMn(sInput) {
    if (sInput) {
        sInput = replaceSubstring(sInput, '$|$', "\\\\");
        sInput = replaceSubstring(sInput, '%|%', "\\\"");
        sInput = replaceSubstring(sInput, '#|#', ' ');
    }
    return sInput;
}

function WHIZ_SetContextMenuNode(sNodeID, sfunction, sLinkImage, sLinkName, sLinkTitle) {
    var objCtNode = GetObjectReference('', sNodeID);
    var objCtName, objCtImage;

    if (sNodeID.length > 2) {
        objCtName = GetObjectReference('', 'td' + sNodeID.substring(2, sNodeID.length));
        if (objCtName) {
            sLinkName = ReplaceSubStringForCtMn(sLinkName);
            objCtName.innerHTML = sLinkName + "&nbsp;";
        }
        objCtImage = GetObjectReference('', 'tdImg' + sNodeID.substring(2, sNodeID.length));
        if (objCtImage) {
            if (sLinkImage && trimString(sLinkImage) != '') {
                sLinkImage = ReplaceSubStringForCtMn(sLinkImage);
                objCtImage.innerHTML = "<img src='" + sLinkImage + "'>";
            }
            else {
                objCtImage.innerHTML = "";
            }
        }
    }
    if (objCtNode) {
        if (sfunction != '') {
            objCtNode.className = 'CtMn_Node';
            objCtNode.onmouseover = function () { this.className = 'CtMn_Node_Hover'; };
            objCtNode.onmouseout = function () { this.className = 'CtMn_Node'; };
        }
        else {
            objCtNode.className = 'CtMn_Node_Disabled';
            objCtNode.onmouseover = '';
            objCtNode.onmouseout = '';
        }

        if (navigator.appName == 'Microsoft Internet Explorer') {
            objCtNode.onclick = function () { sfunction = ReplaceSubStringForCtMn(sfunction); eval(sfunction); }
        }
        else {
            objCtNode.onmousedown = function () { sfunction = ReplaceSubStringForCtMn(sfunction); eval(sfunction); return; }
        }

        if (sLinkTitle) {
            sLinkTitle = ReplaceSubStringForCtMn(sLinkTitle);
            objCtNode.title = sLinkTitle;
        }
        else {
            objCtNode.title = '';
        }
    }
}
//WAF3_PB_47_Extended: Ends
//WAF3_PB_47 17-May-2007 END

function OpenProperties(PropertyPage, TagID, SubTagID, FromElement, ElementName, FocusOn) {
    /*
    Function Name   :   OpenProperties
    Input Parameters:   1)PropertyPage - Identifies which property pages to open i.e. Actions,Control,Page
                        2)TagID     - TagID
                        3)SubTagID     - SubTagID
                        4)FromElement  - Tag or SubTag
                        5)ElementName  - i.e. Control name, action link name etc
                        6)FocusOn      -  Property control name to focus
    Author          :   NinadP
    Created         :   29 May 2007
    ReqID           :   WAF3_PB_48
    */
    try {
        var url;
        try { blnNavigate = false; } catch (e) { }//Added By Ninad 19 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        if (PropertyPage == 'ACTIONLINKPROPERTIES') {//Open Action properties
            url = "../SM/PB_TabFrame.aspx?FromWhere=InformativeSections&FromElement=" + FromElement + "&TagID=" + TagID + "&SubTagID=" + SubTagID + "&DisplaySection=A&TITLE=&ElementName=" + ElementName;
            window.document.open(url, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 1000) / 2) + ",top=" + ((window.screen.height - 600) / 2) + ",width=1000,height=600");
        }
        if (PropertyPage == 'CONTROLPROPERTIES') {//Open control properties
            url = "../SM/PB_TabFrame.aspx?FromWhere=Control&FromElement=" + FromElement + "&TagID=" + TagID + "&SubTagID=" + SubTagID + "&DisplaySection=H&TITLE=&ElementName=" + ElementName + "&FocusOn=" + FocusOn;
            window.document.open(url, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 1000) / 2) + ",top=" + ((window.screen.height - 575) / 2) + ",width=1000,height=575");
        }
        if (PropertyPage == 'PAGEPROPERTIES') {//Open page properties
            url = "../SM/PB_PageProperties.aspx?FromWhere=Control&FromElement=" + FromElement + "&TagID=" + TagID + "&SubTagID=" + SubTagID + "&DisplaySection=PT&TITLE=&ElementName=" + ElementName;
            window.document.open(url, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 1000) / 2) + ",top=" + ((window.screen.height - 575) / 2) + ",width=1000,height=575");
        }
    } catch (e) { }
}

var SmartNavigation_IsEnabled = 2;// 2 Not Applicable, 1 Enabled, 0 disabled, it is required to refresh the opener in case of SmartNavigation is changed
function RefreshWebFormDesigner() {
    /*
    Function Name   :   RefreshWebFormDesigner
    Input Parameters:   None
    Desc            :   Refresh the Web Form Designer page i.e. CommonList or CommonPage or any Inherited page                   
    Author          :   NinadP
    Created         :   29 May 2007
    ReqID           :   WAF3_PB_48
    */
    try {
        if (arguments.length == 0 && parent.window.opener.location.href.indexOf('/PB_PageCanvas.aspx?') != -1) return;
        var url;
        var query;
        url = window.opener.location.href.substring(0, window.opener.location.href.indexOf(window.opener.location.search)) + '?';
        query = window.opener.location.search.substring(1);
        try {
            if (window.location.href.indexOf('PB_PageProperties.aspx?') != -1 && opener.document.getElementById('ParentTagID').value == 0) {//Request comes from page properties for Tag
                if (arguments.length != 0 && SmartNavigation_IsEnabled != 2) {//Page is of advance type having SmartNavigation_IsEnabled property
                    if (SmartNavigation_IsEnabled == 1) {//Smart Navigation is enabled
                        if (window.opener.parent.frames['whizFRMECL'] == null) {//SmartNavigation is now enabled, so we need to open it in new SmartNavigation page
                            var tmpurl = url.substring(0, url.indexOf('?'));
                            tmpurl = tmpurl.substring(0, url.lastIndexOf('/')) + '/' + 'SmartNavigation.aspx';
                            tmpurl = tmpurl + '?' + query;
                            window.opener.location.href = tmpurl;

                            //refresh Web form Wizard
                            try {
                                objForm = window.opener.opener.document.getElementById('frmCommonList');
                                if (objForm != null) {
                                    url = window.opener.opener.location.href.substring(0, window.opener.opener.location.href.indexOf(window.opener.opener.location.search)) + '?';
                                    query = window.opener.opener.location.search.substring(1);
                                    objForm.action = url;
                                    objForm.submit();
                                }
                            } catch (e) { }
                            return;
                        }
                        else {//SmartNavigation is already enabled, so just need to refresh common list page, so also need to generate the url according to list page
                            url = window.opener.parent.frames['whizFRMECL'].location.href.substring(0, window.opener.parent.frames['whizFRMECL'].location.href.indexOf(window.opener.parent.frames['whizFRMECL'].location.search)) + '?';
                            query = window.opener.parent.frames['whizFRMECL'].location.search.substring(1);
                            window.opener.parent.frames['whizFRMECL'].location.href = BuildURLToRefreshParent(url, query);
                            return;
                        }
                    }
                    else {//Smart Navigation is disabled
                        if (window.opener.parent.frames['whizFRMECL'] != null) {//SmartNavigation is now disabled, so we need to open it in new commonList/CommonPage page
                            //refresh Web form Wizard
                            //The hidden variable below is required to refresh the Web Form Wizard, so as to identify that the Smart Navigation is disabled
                            //this hidden variable is retrieved in Smart Navigations OnUnload event

                            try {
                                //opener.opener is web form wizard so refresh it
                                objForm = window.opener.opener.document.getElementById('frmCommonList');
                                if (objForm != null) {
                                    var RefreshWFW = window.opener.parent.document.createElement('hidden');
                                    RefreshWFW.setAttribute('id', 'hidFlagToRefreshWFW');
                                    window.opener.parent.document.appendChild(RefreshWFW);
                                }
                            } catch (e) { }

                            //Refresh Opener       

                            url = window.opener.parent.frames['whizFRMECL'].location.href.substring(0, window.opener.parent.frames['whizFRMECL'].location.href.indexOf(window.opener.parent.frames['whizFRMECL'].location.search)) + '?';
                            query = window.opener.parent.frames['whizFRMECL'].location.search.substring(1);
                            window.opener.parent.location.href = BuildURLToRefreshParent(url, query);
                            return;
                        }
                    }
                }
            }
            else {
                //request come for control or action properties
                if (window.opener.parent.frames['whizFRMECL'] != null) {
                    //smart navigation is enabled
                    if (window.location.search.indexOf('FromElement=Tag') != -1) {
                        url = window.opener.parent.frames['whizFRMECL'].location.href.substring(0, window.opener.parent.frames['whizFRMECL'].location.href.indexOf(window.opener.parent.frames['whizFRMECL'].location.search)) + '?';
                        query = window.opener.parent.frames['whizFRMECL'].location.search.substring(1);
                        window.opener.parent.frames['whizFRMECL'].location.href = BuildURLToRefreshParent(url, query);
                        return;
                    }
                }
            }
        } catch (e) { }
        //The part below is executed for the Control, Action and Page properties for the Normal case (i.e. not for Smart Navigation)
        if (window.opener.document.getElementById('frmCommonList') != null)
            objForm = window.opener.document.getElementById('frmCommonList');//to refresh Common List Page 
        else if (window.opener.document.getElementById('frmCommonPage') != null)
            objForm = window.opener.document.getElementById('frmCommonPage'); //to refresh Common Page 
        else
            objForm = window.opener.document.getElementById('frmSample'); //to refresh Page canvas

        url = BuildURLToRefreshParent(url, query);
        objForm.action = url;
        objForm.submit();
        try {
            if (window.opener.document.getElementById('frmCommonPage') != null && opener.document.getElementById('ParentTagID').value != 0) {//When property page is opened from sub tag Form page then we need to refresh sub tag list page also
                //Smart Navigation is not enabled for main tag, then refresh sub tag list page(i.e common page of Tag) 
                url = window.opener.opener.location.href.substring(0, window.opener.opener.location.href.indexOf(window.opener.opener.location.search)) + '?';
                query = window.opener.opener.location.search.substring(1);
                objForm = window.opener.opener.document.getElementById('frmCommonPage'); //to refresh Common Page 
                url = BuildURLToRefreshParent(url, query);
                objForm.action = url;
                objForm.submit();
            }
        } catch (e) { }
    } catch (e) { }
}


function BuildURLToRefreshParent(url, query) {
    /*
    Function Name   :   BuildURLToRefreshParent
    Input Parameters:   url - The URL of the page (including '?')
                    :   query - is the string containing the query string parameters 
    Desc            :   To build the URL which is required to refresh the Web Form Wizard, CommonList, CommonPage, Smart Navigation page or any Inherited page                   
    Author          :   NinadP
    Created         :   14 June 2007
    ReqID           :   WAF3_PB_48
    */
    try {
        var parms = query.split('&');
        for (var i = 0; i < parms.length; i++) {
            var pos = parms[i].indexOf('=');
            var key = parms[i].substring(0, pos);
            if (key != 'Operation' && key != 'SetFilter' && key != 'PagingNumber' && key != 'PagingNavigation' && key != 'SortBy' && key != 'SortOrder') {
                if (key == 'Mode') {
                    if (query.indexOf('Operation=SAVE') == -1 && query.indexOf('Mode=ADD_NEW') == -1)
                        url += parms[i] + '&';
                }
                else {
                    url += parms[i] + '&'
                }
            }
        }
        url = url.substring(0, url.length - 1);
        return url;
    } catch (e) { }
}

function MultiInsertSubTabOnClick(SubTagID) {
    /*
    Function Name   :   MultiInsertSubTabOnClick
    Input Parameters:   SubTagID - SubTagId of subtag on which user clicks
    Desc            :   To select the required subtag(on which user click) and hide the rest of subtags.
    Author          :   NinadP
    Created         :   10 Dec 2007
    ReqID           :   WAF3_PB_55
    */

    //SubTagIDs - contains comma seperated list of subtagid of plotted subtag
    var SubTags = document.getElementById('SubTagIDs').value.split(',');
    //iterate through a loop for all subtag
    //hide the rest of subtag (except selected one)
    //set the class for the anchor of the tab(to show unselected)
    for (var i = 0; i < SubTags.length; i++) {
        if (SubTags[i] != SubTagID) {
            document.getElementById('AncSubTagTab' + SubTags[i]).className = 'navtab';
            document.getElementById('clsSubTagTable' + SubTags[i]).style.display = 'none';
        }
    }
    //Show the selected subtag
    //set the class for the anchor of the tab(to show it selected)
    document.getElementById('AncSubTagTab' + SubTagID).className = 'clsTabSelected';
    document.getElementById('clsSubTagTable' + SubTagID).style.display = '';
}

function SetMultiInsertSubTabInitialRecordCount() {
    /*
    Function Name   :   SetMultiInsertSubTabInitialRecordCount
    Input Parameters:   
    Desc            :   To set the record count on subtag tab on page load
    Author          :   NinadP
    Created         :   10 Dec 2007
    ReqID           :   WAF3_PB_55
    */

    //SubTagIDs - contains comma seperated list of subtagid of plotted subtag
    var SubTags = document.getElementById('SubTagIDs').value.split(',');
    var len;
    //iterate through a loop for all subtag
    for (var i = 0; i < SubTags.length; i++) {
        var SubTagGridtableID = 'tblGrid' + document.getElementById('MasterTagID').value + SubTags[i];
        if (document.getElementById(SubTagGridtableID) != null) {
            if (document.getElementById(SubTagGridtableID + '_SummaryExists') == null)
                len = document.getElementById(SubTagGridtableID).rows.length;
            else
                len = document.getElementById(SubTagGridtableID).rows.length - 1;
            try {
                document.getElementById('RecordCountOnTab' + SubTags[i]).innerHTML = document.getElementById('RecordCountOnTab' + SubTags[i]).innerHTML.replace('(0)', '(' + (len - 1) + ')');
            } catch (e) { }
        }
    }
}

function AddNewRow_MultiInsertGrid(SubTagID, SubTagGridtableID) {
    /*
    Function Name   :   AddNewRow_MultiInsertGrid
    Input Parameters:   SubTagID - SubTagId of subtag on which user clicks
                        SubTagGridtableID - Sub Tag grid table name in which we add control row
                        arguments[] - it is control defination array, length differ according to the no of controls
    Desc            :   To add control new row for multi insert subtag.
    Author          :   NinadP
    Created         :   10 Dec 2007
    ReqID           :   WAF3_PB_55
    */
    if (arguments.length > 2) {
        var table = document.getElementById(SubTagGridtableID);
        var len;
        //get the table row count (row count differ where summary row exists)
        if (document.getElementById(SubTagGridtableID + '_SummaryExists') == null)
            len = table.rows.length;
        else
            len = table.rows.length - 1;

        var row = table.insertRow(len);
        //Added By Ninad on 27 JAn 2009,IssueID-26668, Show first col excel like
        if (document.getElementById('blnShowFirstColExcelLike') != null) {
            var cell = row.insertCell(row.cells.length);
            cell.className = 'clsTDFirstColumn';
            cell.style.width = '20px';
        }
        //End Addition By Ninad on 27 JAn 2009,IssueID-26668
        //If the delete link is plotted then only show delete checkbox, for plotting Delete column at First
        if (document.getElementById('DELETELIST_HEAD' + document.getElementById('MasterTagID').value + '-' + SubTagID) != null && document.getElementById('ShowDeleteColumnFirst' + SubTagID).value == 'True') {
            var cell = row.insertCell(row.cells.length);
            cell.innerHTML = '<Input type=checkbox name="chkDelete' + SubTagID + '" id="chkDelete' + SubTagID + '" class="clsCheckBox" />';
            cell.align = 'center';
            cell.style.verticalAlign = 'top';
            cell.noWrap = true;
        }
        //debugger;
        //insert control in the grid columns
        for (var i = 2; i < arguments.length; i++) {
            var cell = row.insertCell(row.cells.length);
            //cell.innerHTML = replaceSubstring(replaceSubstring(arguments[i],'<ROW_INDEX>','\'+GetContainerRowIndex(this)+\''),'\"\"\"\"','&quot;');//Modified By Ninad on 25 June IssueID-31277
            cell.innerHTML = replaceSubstring(replaceSubstring(arguments[i], '<ROW_INDEX>', len.toString()), '\"\"\"\"', '&quot;');//Modified By Ninad on 25 June IssueID-31277
            cell.align = 'center';
            cell.style.verticalAlign = 'top';
            cell.noWrap = table.rows(len - 1).cells(row.cells.length - 1).noWrap;
        }
        //set focus on first column control of newly added row
        //Modified By Ninad IssueID 29626
        if (document.getElementById('blnShowFirstColExcelLike') != null) { try { table.rows(len).cells(1).children(0).focus(); } catch (e) { } }
        else { try { table.rows(len).cells(0).children(0).focus(); } catch (e) { } }
        //End Modification By Ninad IssueID 29626
        //If the delete link is plotted then only show delete checkbox, for plotting Delete column at last
        if (document.getElementById('DELETELIST_HEAD' + document.getElementById('MasterTagID').value + '-' + SubTagID) != null && document.getElementById('ShowDeleteColumnFirst' + SubTagID).value == 'False') {
            var cell = row.insertCell(row.cells.length);
            cell.innerHTML = '<Input type=checkbox name="chkDelete' + SubTagID + '" id="chkDelete' + SubTagID + '" class="clsCheckBox" />';
            cell.align = 'center';
            cell.style.verticalAlign = 'top';
            cell.noWrap = true;
        }
        //set the style for the newly added row
        if ((len % 2) == 0)
            row.className = 'clsTREven';
        else
            row.className = 'clsTROdd';

        //set record count on tab and grid    
        try {
            document.getElementById('RecordCountOnTab' + SubTagID).innerHTML = document.getElementById('RecordCountOnTab' + SubTagID).innerHTML.replace('(' + (len - 1) + ')', '(' + (len) + ')');
        } catch (e) { }
        try {
            document.getElementById('RecordCountOnGrid' + SubTagID).innerHTML = document.getElementById('RecordCountOnGrid' + SubTagID).innerHTML.replace(' :' + (len - 1), ' :' + (len));
        } catch (e) { }
        //set the summary after adding new row (it is required bcoz, newly added column may contains default value)
        if (document.getElementById(SubTagGridtableID + '_SummaryExists') != null)
            SetMultiInsertSubtagSummaryTotal(document.getElementById(SubTagGridtableID + '_SummaryExists').value);
    }
}

function ResetMultiInsertSubtagControls(strMultiInsertSubTagID) {
    /*
    Function Name   :   ResetMultiInsertSubtagControls
    Input Parameters:   strMultiInsertSubTagID - ParentTagID + SubTagId to identify the multiinsert subtag 
    Desc            :   Same as above
    Author          :   NinadP
    Created         :   1 Sept 2009
    ReqID           :   IssueID-32775,32815
    */
    try {//debugger;
        var ControlName = new Array();
        var Length = 0;
        //Set checkbox values
        ControlName = eval("strCheckBoxControls" + strMultiInsertSubTagID + ".split(',')");
        for (var i = 0; i < ControlName.length; i++) {
            var controlArray = document.getElementsByName(ControlName[i]);
            if (Length == 0)
                Length = controlArray.length;
            for (var j = 0; j < controlArray.length; j++) {
                controlArray[j].value = j + 1;
            }
        }
        //Set Option buttons ID and Name 
        ControlName = eval("strOptionButtonControls" + strMultiInsertSubTagID + ".split(',')");
        if (ControlName.length > 0) {
            for (var k = 0; k < ControlName.length; k++) {
                var ele = null;
                ele = eval('tblGrid' + strMultiInsertSubTagID + '.all');
                for (i = 0; i < ele.length; i++) {
                    if (ele[i].type != null) {
                        if (ele[i].type == "radio") {
                            if (ele[i].name.indexOf(ControlName[k]) != -1) {
                                var checkBoxControlArray = document.getElementsByName(ele[i].name);
                                var intIndex = 0;
                                for (var j = 0; j < checkBoxControlArray.length; j++) {
                                    var objOption = checkBoxControlArray[j];
                                    if (objOption != null) {
                                        objOption.name = ControlName[k] + GetContainerRowIndex(objOption)
                                        objOption.id = ControlName[k] + GetContainerRowIndex(objOption) + intIndex
                                        intIndex++;
                                    }
                                }
                                i = i + intIndex
                            }
                        }
                    }
                }
            }
        }
        return;
    } catch (e) { }
}
function GetContainerRowIndex(obj) {
    /*
    Function Name   :   GetContainerRowIndex
    Input Parameters:   Object calling methode
    Desc            :   To get row index of controls parent row in multi insert subtag.
    Author          :   NinadP
    Created         :   1 Sept 2009
    ReqID           :   IssueID-32775,32815
    */
    try {

        if (obj.onclick.toString().indexOf('callHTMLEditor') != -1)
            return obj.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.rowIndex;

        return obj.parentElement.parentElement.rowIndex;
    } catch (e) {
        return obj.parentElement.parentElement.rowIndex;
    }
}
function SetMultiInsertSubtagSummaryTotal(ControlNames) {
    /*
    Function Name   :   SetMultiInsertSubtagSummaryTotal
    Input Parameters:   ControlNames - comma seperated control names for which we need to set summary
    Desc            :   To set summary for the columns on which summary is applied.
    Author          :   NinadP
    Created         :   10 Dec 2007
    ReqID           :   WAF3_PB_55
    */
    var ControlName = new Array();
    ControlName = ControlNames.split(',');
    for (var i = 0; i < ControlName.length; i++) {
        var controlArray = document.getElementsByName(ControlName[i]);
        var total = 0.0;
        for (var j = 0; j < controlArray.length; j++) {
            if (disallowNonNumeric(controlArray[j], 'Please enter only numeric values !!!', false)) {
                setFocus_MultiInsertGrid(controlArray[j], j);
                return false;
            }
            if (isNaN(parseInt(controlArray[j].value)) == false)
                total = total + parseInt(controlArray[j].value);
        }
        document.getElementById(ControlName[i] + '_MultiInsertSummary').innerHTML = formatNumber(parseInt(total), 2, ',', '.', '', '', '-', '');
    }
    return;
}


function formatNumber(num, dec, thou, pnt, curr1, curr2, n1, n2)
/*
Function Name   :   formatNumber
Input Parameters:   
                    The first parameter is the number to format
                    The second parameter is the number of decimal places that the number should have. If the number contains more decimal places than required it will be rounded to the nearest number with that number of decimal places. If it has fewer decimal places than specified zeroes will be added to the end. 
                    The third parameter is the thousands separator. a space, comma or period may be used as required for our location. 
                    The fourth parameter is the decimal point. Either a period or comma is normal here. 
                    The fifth and sixth parameters are used for monetary values and one or other of them will contain the currency symbol when required. If your location uses a currency symbol hard against the left of numbers then place that symbol by itself in the fifth parameter eg. '$'. If you normally have a space after the currency symbol then add it after the symbol in this '$ '. If your currency symbol comes after the amount instead of before then place it in the sixth parameter instead of the fifth parameter. 
                    The seventh and eighth parameters define the symbols to place around the number when the value is negative. The usual values for these parameters would be '-','' but you may have a situation where you want to use '(',')' or even '',' CR'. 
Desc            :   To format number (required to set summary for the columns on which summary is applied)
Author          :   NinadP
Created         :   10 Dec 2007
ReqID           :   WAF3_PB_55
*/ {
    var x = Math.round(num * Math.pow(10, dec));
    if (x >= 0)
        n1 = n2 = '';
    var y = ('' + Math.abs(x)).split('');
    var z = y.length - dec;
    if (z < 0)
        z--;
    for (var i = z; i < 0; i++)
        y.unshift('0');
    y.splice(z, 0, pnt);
    while (z > 3) {
        z -= 3;
        y.splice(z, 0, thou);
    }
    var r = curr1 + n1 + y.join('') + n2 + curr2;
    return r;
}

function GetQueryStringParamater(paramName) {
    /*
    Function Name   :   GetQueryStringParamater
    Desc            :   To retrieve requested query string paramater value
    Input Parameters:   paramName - Name of the query string paramater
    Author          :   NinadP
    Created         :   26 March 2008
    ReqID		:   WAF3_PB_62	
    */
    try {
        if (window.location.search.indexOf(paramName) == -1)
            return '';
        var parms = window.location.search.substring(1).split('&');
        for (var i = 0; i < parms.length; i++) {
            var pos = parms[i].indexOf('=');
            var key = parms[i].substring(0, pos);
            if (key.toUpperCase() == paramName.toUpperCase()) {
                return parms[i].substring(pos + 1);
            }
        }

        return '';
    } catch (e) { }
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

//Added By Ninad 15 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
//Modified By Ninad 22 Oct 2008, Req ID - WAF3_GEN_17 - Tab Collection
var blnFrameExists = true;
var blnTabCollectionExists = false;
var strControlsToExcludeFrmNavAlert = '';
var intCurrentTabIndex = 0;
function confirmExit() {
    //debugger;
    try {
        if (window.parent.parent.frames('sub') != null)
            blnFrameExists = true;
        else
            blnFrameExists = false;
    } catch (e) { blnFrameExists = false; }
    if (blnFrameExists == true) {
        if (window.parent.parent.frames('sub').blnTabCollectionExists == true) {
            blnTabCollectionExists = true;
            intCurrentTabIndex = window.parent.parent.frames('sub').intCurrentTabIndex;
        }
    }

    try {
        if (blnFrameExists == true) {
            if (blnTabCollectionExists == true) { if (window.parent.parent.frames('sub').frames[intCurrentTabIndex].blnShowNavigationAlert != true) return; }
            else { if (window.parent.parent.frames('sub').blnShowNavigationAlert != true) return; }
        }
        else { if (blnShowNavigationAlert != true) return; }
    } catch (e) { return; }


    //check for each control of the container control i.e. div for header, footer etc
    var objContainerDivs = new Array();
    var objContainerDiv = null;
    if (blnFrameExists == true) {
        if (blnTabCollectionExists == true)
            objContainerDivs = window.parent.parent.frames('sub').frames[intCurrentTabIndex].strContainerDivs.split(',');
        else
            objContainerDivs = window.parent.parent.frames('sub').strContainerDivs.split(',');
    }
    else { objContainerDivs = strContainerDivs.split(','); }
    for (var i = 0; i < objContainerDivs.length; i++) {
        try {
            if (blnFrameExists == true) {
                if (blnTabCollectionExists == true)
                    objContainerDiv = window.parent.parent.frames('sub').frames[intCurrentTabIndex].document.getElementById(objContainerDivs[i]);
                else
                    objContainerDiv = window.parent.parent.frames('sub').document.getElementById(objContainerDivs[i]);
            }
            else { objContainerDiv = document.getElementById(objContainerDivs[i]); }
        } catch (e) { }
        if (objContainerDiv != null) {
            if (blnFrameExists == true) {
                if (blnTabCollectionExists == true) {
                    if (window.parent.parent.frames('sub').frames[intCurrentTabIndex].blnNavigate == null || window.name == 'link') {
                        try {
                            if (window.parent.parent.frames('sub').frames[intCurrentTabIndex].strControlsToExcludeFrmNavigationAlert != undefined)
                                strControlsToExcludeFrmNavAlert = ',' + window.parent.parent.frames('sub').frames[intCurrentTabIndex].strControlsToExcludeFrmNavigationAlert.toUpperCase() + ',';
                        } catch (e) { }
                        if (isFormChanged(objContainerDiv)) {
                            return "You have made some changes to this page, modified data will be lost if you continue.";
                        }
                    }
                }
                else {
                    if (window.parent.parent.frames('sub').blnNavigate == null || window.name == 'link') {
                        try {
                            if (window.parent.parent.frames('sub').strControlsToExcludeFrmNavigationAlert != undefined)
                                strControlsToExcludeFrmNavAlert = ',' + window.parent.parent.frames('sub').strControlsToExcludeFrmNavigationAlert.toUpperCase() + ',';
                        } catch (e) { }
                        if (isFormChanged(objContainerDiv)) {
                            return "You have made some changes to this page, modified data will be lost if you continue.";
                        }
                    }
                }
            }
            else
                if (blnNavigate == null) {
                    try {
                        if (strControlsToExcludeFrmNavigationAlert != undefined)
                            strControlsToExcludeFrmNavAlert = ',' + strControlsToExcludeFrmNavigationAlert.toUpperCase() + ',';
                    } catch (e) { }
                    if (isFormChanged(objContainerDiv)) {
                        return "You have made some changes to this page, modified data will be lost if you continue.";
                    }
                }
        }
    }
}

function isFormChanged(objContainerDiv) {
    var rtnVal = false;
    var ele = null;
    if (objContainerDiv != null) {
        ele = objContainerDiv.all;
        for (i = 0; i < ele.length; i++) {
            if (ele[i].type != null) {
                if (isElementChanged(ele, i)) {
                    //debugger;
                    rtnVal = true;
                    break;
                }
            }
        }
    }
    return rtnVal;
}

function isElementChanged(ele, i) {//debugger;
    if ((ele[i].type == "text" || ele[i].type == "password" || ele[i].type == "textarea" || ele[i].type == "select-one" || ele[i].type == "checkbox" || ele[i].type == "radio" || ele[i].type == "select-multiple" || ele[i].type == "file" || ele[i].type == "hidden") && ele[i].style.display != 'none') {
        if (strControlsToExcludeFrmNavAlert != ',,') {
            if (strControlsToExcludeFrmNavAlert.indexOf(',' + ele[i].id.toUpperCase() + ',') != -1)
                return false;
            if (strControlsToExcludeFrmNavAlert.indexOf(',' + ele[i].name.toUpperCase() + ',') != -1)
                return false;
        }
        var isEleChanged = false;
        switch (ele[i].type) {
            case "text":
                if (ele[i].value != ele[i].defaultValue) return true;
                break;

            case "password":
                if (ele[i].value != ele[i].defaultValue) return true;
                break;

            case "textarea":
                if (ele[i].value != ele[i].defaultValue) return true;
                break;

            case "select-one":
                var blndefaultSelected = false;
                for (var x = 0; x < ele[i].length; x++) {
                    if (ele[i].options[x].defaultSelected == true) {
                        blndefaultSelected = true;
                        break;
                    }
                }
                if (ele[i].selectedIndex == 0 && blndefaultSelected == false) return false;
                for (var x = 0; x < ele[i].length; x++) {
                    if (ele[i].options[x].selected != ele[i].options[x].defaultSelected) return true;
                }
                break;

            case "checkbox":
                if (ele[i].checked != ele[i].defaultChecked) return true;
                break;
            case "radio":
                if (ele[i].checked != ele[i].defaultChecked) return true;
                break;
            case "select-multiple":
                for (var x = 0; x < ele[i].length; x++) {
                    if (ele[i].options[x].selected != ele[i].options[x].defaultSelected) return true;
                }
                break;
            case "file":
                if (ele[i].value != ele[i].defaultValue) return true;
                break;
            case "hidden":
                if (ele[i].id == 'FreeTextBox') {

                    FTB_CopyHtmlToHidden(FreeTextBox_editor, document.getElementById('FreeTextBox'), FreeTextBox_HtmlMode);
                    if (ele[i].value != ele[i].defaultValue) return true;
                }
                break;
            default:
                return false;
                break;
        }
    }
    return false;
}

function ShowNavigationAlert() {

    var strConfirmExit = '';
    strConfirmExit = confirmExit();
    if (strConfirmExit != '' && strConfirmExit != undefined) {
        strConfirmExit = 'Are you sure you want to navigate away from this page?\n\n' + strConfirmExit + '\n\nPress OK to continue, or Cancel to stay on the current page.';
        if (confirm(strConfirmExit) == false) {
            try { window.event.returnValue = false; } catch (e) { }
            if (blnFrameExists == true) {
                if (blnTabCollectionExists == true)
                    window.parent.parent.frames('sub').frames[intCurrentTabIndex].blnNavigate = null;
                else
                    window.parent.parent.frames('sub').blnNavigate = null;
            }
            else { blnNavigate = null; }
            return false;
        }
        else {
            if (blnFrameExists == true) {
                if (blnTabCollectionExists == true)
                    window.parent.parent.frames('sub').frames[intCurrentTabIndex].blnNavigate = false;
                else
                    window.parent.parent.frames('sub').blnNavigate = false;
            }
            else { blnNavigate = false; }
            return null;
        }
    }
}
function SetTabBG(obj) {
    //Commented and Added By Chakshuta H Purpose::Theme issue fixing
    //obj.style.backgroundImage="url('" + document.getElementById('lnkWhizStyleSheetImgDir').href + "navtab_hover_bg.gif')";
    obj.style.backgroundImage = "url('" + document.getElementById('lnkWhizStyleSheetImgDir').href + "navtab_bg.gif')";
    //End Of Commented and Added By Chakshuta H Purpose::Theme issue fixing
}
function ResetTabBG(obj) {
    obj.style.backgroundImage = "url('" + document.getElementById('lnkWhizStyleSheetImgDir').href + "navtab_bg.gif')";
}
//End Modification By Ninad 22 Oct 2008, Req ID - WAF3_GEN_17 - Tab Collection
//End Addition By Ninad 15 May 2008, Req ID - WAF3_PB_64 - - Show Navigation Alert

var g_strResponseText = '';
var g_objValidateEmailXMLHttp;
function ValidateTenantData(strFrm, strCtrl, strWordCtrl) {
    var objEmailIDCtr, objWordVerificationCtr;
    var strUrl; var strNavigator;

    objEmailIDCtr = GetObjectReference(strFrm, strCtrl);
    objWordVerificationCtr = GetObjectReference(strFrm, strWordCtrl);
    if (objEmailIDCtr != null) {
        if (objEmailIDCtr.value != "") {
            strUrl = new String();
            strUrl = "../SaaS/SaaS_RegistrationValidation.aspx?Email=" + objEmailIDCtr.value + "&TenantImgCode=";
            if (objWordVerificationCtr != null) {
                strUrl += objWordVerificationCtr.value;
            }
            /*INSTANTIATE XmlHttpRequest
            Checking if IE-specific document.all collection exists 						
            TO SEE IF WE ARE RUNNING IN IE */

            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
                g_objValidateEmailXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objValidateEmailXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_objValidateEmailXMLHttp.open("GET", strUrl, false);
                //finally send the call
                g_objValidateEmailXMLHttp.send();
            }
            else {
                // Mozilla - based browser 
                g_objValidateEmailXMLHttp = new XMLHttpRequest();
                //hook the event handler
                g_objValidateEmailXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_objValidateEmailXMLHttp.open("GET", strUrl, false);
                //finally send the call
                g_objValidateEmailXMLHttp.send(null);
            }
        }
    }
    g_objValidateEmailXMLHttp = null;
    if (g_strResponseText == "CASE1") //Email ID Is Duplicate
    {
        g_strResponseText = '';
        alert('There is already a Tenant Account with the specified Email-id.');
        objEmailIDCtr.focus();
        return false;
    }
    if (g_strResponseText == "CASE2") 	//Email ID does not exist, but the word entered is wrong.
    {
        g_strResponseText = '';
        alert('Please enter the text correctly.');
        objWordVerificationCtr.focus();
        return false;
    }
    if (g_strResponseText == "CASE3") //Email ID does not exist, and the word entered is correct.
    {
        g_strResponseText = '';
        return true;
    }
    return false;
}

function GetResponseText() {
    if (g_objValidateEmailXMLHttp.readyState == 4) {
        if (g_objValidateEmailXMLHttp.responseText != null) {
            g_strResponseText = g_objValidateEmailXMLHttp.responseText;
        }
    }
}
//Added GetRowID function on 17 Sept.2008 by Vinay
function GetRowID() {
    /*
    Function Name   :   GetRowID
    Input Parameters:   
    Desc            :   To get RowID from URL
    Author          :   NinadP,Vinay
    Created         :   29 Nov 2007
    ReqID           :   
    */
    try {
        var parms = window.location.search.substring(1).split('&');
        for (var i = 0; i < parms.length; i++) {
            var pos = parms[i].indexOf('=');
            var key = parms[i].substring(0, pos);
            if (key.toUpperCase() == 'ROWINDEX') {
                return parseInt(parms[i].substring(pos + 1)) - 1;
            }
        }

        return 0;
    } catch (e) { }
}
//Addition End by Vinay on 187 Sept. 2008

/*Added By PushkarK On 22-Apr-2009 for Req.ID: WAF3_PB_69*/
function ShowModalDlgWait(sWaitMsg) {
    var iBodyOffsetHeight = 0, iBodyOffsetWidth = 0;
    var oDiv, oTbl;
    var sDivID = 'dvFaddingEffect', sTblId = 'tblFaddingEffect';
    var sInnerHtml = '';

    if (sWaitMsg == null || sWaitMsg == '')
        sWaitMsg = '&nbsp;';
    oDiv = document.getElementById(sDivID);
    if (oDiv == null) {
        oDiv = document.createElement('DIV');
        oDiv.id = sDivID;
        oDiv.className = "clsDivWait";

        sInnerHtml = '<table id="' + sTblId + '" class="clsTblWait">';
        sInnerHtml += '<tr class="clsTrWait">';
        sInnerHtml += '<td class="clsTdWait">';
        sInnerHtml += '<img src="../../Images/processing.gif" alt="Processing" />';
        sInnerHtml += '<br/>';
        sInnerHtml += sWaitMsg;
        sInnerHtml += '</td>';
        sInnerHtml += '</tr>';
        sInnerHtml += '</table>';
        oDiv.innerHTML = sInnerHtml;
        document.body.appendChild(oDiv);
    }
    if (navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER') {
        iBodyOffsetHeight = document.body.offsetHeight;
        iBodyOffsetWidth = document.body.offsetWidth;
    }
    else {
        iBodyOffsetHeight = window.innerHeight;
        iBodyOffsetWidth = window.innerWidth;
    }
    oDiv.style.width = iBodyOffsetWidth;
    oDiv.style.height = iBodyOffsetHeight;

    oTbl = document.getElementById(sTblId);
    oTbl.style.width = iBodyOffsetWidth;
    oTbl.style.height = iBodyOffsetHeight;

    oTbl = null; oDiv = null;
}
/*Addition Ends By PushkarK On 22-Apr-2009 for Req.ID: WAF3_PB_69*/

/*Added By PushkarK On 13-May-2009 for Req.ID: WAF3_CDB_68*/
function IsDarkColor(Color) {
    var bIsDarkColor = false;
    var bIsLightColor = false;

    var iLoop = 0, iLen = 13;

    var arrDarkColors = new Array();
    arrDarkColors[0] = "BLACK";
    arrDarkColors[1] = "RED";
    arrDarkColors[2] = "MAROON";
    arrDarkColors[3] = "NAVY";
    arrDarkColors[4] = "GREEN";
    arrDarkColors[5] = "FORESTGREEN";
    arrDarkColors[6] = "SEAGREEN";
    arrDarkColors[7] = "TEAL";
    arrDarkColors[8] = "SIENNA";
    arrDarkColors[9] = "INDIGO";
    arrDarkColors[10] = "PURPLE";
    arrDarkColors[11] = "CRIMSON";
    arrDarkColors[12] = "CRIMSON";
    arrDarkColors[13] = "FIREBRICK";

    var sExceptinoalLightColors = ",ALICEBLUE,POWDERBLUE,SKYBLUE";
    Color = Color.toUpperCase();

    bIsLightColor = (Color.indexOf("LIGHT") > -1);
    if (bIsLightColor == false) {
        bIsLightColor = (sExceptinoalLightColors.indexOf("," + Color + ",") > -1)
    }

    if (bIsLightColor == true)
        return false;

    bIsDarkColor = (Color.indexOf("DARK") > -1 || Color.indexOf("BLUE") > -1 || Color.indexOf("BROWN") > -1 || Color.indexOf("GRAY") > -1 || Color.indexOf("VIOLET") > -1)

    if (bIsDarkColor == false) {
        for (iLoop = 0; iLoop < iLen; iLoop++) {
            if (arrDarkColors[iLoop] == Color) { bIsDarkColor = true; break; }
        }
    }

    return bIsDarkColor;
}
/*Addition Ends By PushkarK On 13-May-2009 for Req.ID: WAF3_CDB_68*/


function SetTabCollectionBodyStyle(IsSmartNavPage) {
    /*
    Function Name   :   SetTabCollectionBodyStyle
    Input Parameters:   None 
    Desc            :   Set Body Style for page if it is opened in TabCollection 
    Author          :   NinadP
    Created         :   3 July 2009
    ReqID           :   WAF3_PB_74 Tab Collection enhancement
    */
    try {
        var bHideBorders = false;

        if (IsSmartNavPage == 0) {
            bHideBorders = (parent != null && parent.document != null && parent.document.forms['frmTabCollection'] != null);
        }
        else {
            if (parent != null && parent.document != null && parent.document.frames != null && parent.document.frames[0] != null && parent.document.frames[0].parent)
                bHideBorders = (parent.document.frames[0].parent.parent != null && parent.document.frames[0].parent.parent.document != null && parent.document.frames[0].parent.parent.document.forms['frmTabCollection'] != null);
        }
        if (bHideBorders == true) {
            document.body.style.borderRightWidth = '0px';
            document.body.style.borderBottomWidth = '0px';
            document.body.style.borderTopWidth = '0px';
            document.body.style.borderLeftWidth = '0px';
            setTimeout('CL_window_onload()', 15);
        }
    } catch (ex) { }
}


// Added by Ninad on 31 July 2009 Integration of Dpopup

//****** Advanced DHTML Popup Pro Version 2.490.0141.209.024,  Build: 170 ******

// Copyright (c) Digital Flow Software 2005-2009
// The present javascript code is property of Digital Flow Software.
// This code can only be used inside Internet/Intranet web sites located on *web servers*, as the outcome of a licensed Advanced DHTML Popup application only. 
// This code *cannot* be used inside distributable implementations (such as demos, applications or CD-based webs), unless this implementation is licensed with an "Advanced DHTML Popup License for Distributed Applications". 
// Any unauthorized use, reverse-engineering, alteration, transmission, transformation, facsimile, or copying of any means (electronic or not) is strictly prohibited and will be prosecuted.
// ***Removal of the present copyright notice is strictly prohibited***

var df, rf = false, na = navigator.userAgent, dt = document, op = (na.indexOf('Opera') != -1), dm = (dt.getElementById) ? true : false, ie5x = (dt.all && dm), mci = (na.indexOf('Mac') != -1); df = ((ie5x || op) && mci); decide(); function decide() { if (df) { return; } else { rf = true; } }
if (rf) {
    function initADP() {
        bdf = 0;
    }
    if (window.attachEvent) { window.attachEvent('onload', initADP); } else { if (typeof window.onload == 'function') { var preADP = window.onload; window.onload = function () { preADP(); initADP(); } } else { window.onload = initADP; } }
}
function ShowWhizAlert(msg) {/*
Function Name   :   ShowWhizAlert
Input Parameters:   msg - Message to show in popup
                    title - Title of popup(default is blank)
                    type - Type of popup(default is FADE_IN_FADE_OUT)  
                    DisplayTime - Time till which popup is shown(default is 2 sec, required only for FADE_IN_FADE_OUT type)
Desc            :   Show the alert using Dpopup
Author          :   NinadP
Created         :   31 July 2009
ReqID           :   Integration of Dpopup
*/
    var title = (arguments.length > 1) ? arguments[1] : "";
    var type = (arguments.length > 2) ? arguments[2] : "FADE_IN_FADE_OUT";
    if (type == 'FADE_IN_FADE_OUT') {
        var DisplayTime = (arguments.length > 3) ? arguments[3] : "2";
        msg = "<table id='tblWhizPopup' name='tblWhizPopup' style=\"\"><tr><td colspan=3 style=\"height:20;\"></td></tr><tr><td style=\"width:30;\"></td><td align='center' valign='middle' nowrap ><table><tr><td nowrap ><p style=\"text-align:left; font-size:11px; font-family:Verdana;\" >" + msg + "</p></td></tr></table></td><td style=\"width:30;\"></td></tr><tr><td colspan=3 style=\"height:20;\"></td></tr></table>"
        try {
            //If there is existing popup then remove it (it is required to reflect the Popup title if need to show multiple time)        
            var objWhizPopupParent = document.getElementById('tblWhizPopup').parentNode.parentNode;
            objWhizPopupParent.parentNode.removeChild(objWhizPopupParent);
        } catch (e) { }
        //Create the Popup object    
        new adp("WhizFadeOut", msg, title);
        document.getElementById('WhizFadeOut_adpB').style.backgroundColor = '';
        document.getElementById('WhizFadeOut_adpC').style.backgroundColor = '';
        document.getElementById('WhizFadeOut_adpT').style.backgroundColor = '';
        document.getElementById('WhizFadeOut_adpB').className = 'WhizDpopup_Title';
        document.getElementById('WhizFadeOut_adpT').className = 'WhizDpopup_Title';
        document.getElementById('WhizFadeOut_adpC').className = 'WhizDpopup_body';
        adpContent('WhizFadeOut', msg)
        adpFadein('WhizFadeOut');
        setTimeout('SetWhizPopupDisplay();', 250);
        adpTimer('WhizFadeOut', '', '', 'adpFadeout', '', '', DisplayTime);
    }
}

function SetWhizPopupDisplay() {/*
Function Name   :   SetWhizPopupDisplay
Input Parameters:   None
Desc            :   Sets the height, width, and top, left position of the popup
Author          :   NinadP
Created         :   31 July 2009
ReqID           :   Integration of Dpopup
*/
    //debugger;


    width = document.getElementById('tblWhizPopup').getBoundingClientRect().right - document.getElementById('tblWhizPopup').getBoundingClientRect().left + 10;
    height = document.getElementById('tblWhizPopup').getBoundingClientRect().bottom - document.getElementById('tblWhizPopup').getBoundingClientRect().top + 26;
    adpSize('WhizFadeOut', width, height);
    xPos = (screen.availWidth / 2) - (width / 2) - screenLeft;
    yPos = (screen.availHeight / 2) - (height / 2) - screenTop;
    adpLocation('WhizFadeOut', xPos, yPos, 0, event);
}

//****** Advanced DHTML Popup Pro Version 2.490.141.209.024,  Build: 170 ******

// Copyright (c) Digital Flow Software 2005-2009
// The present javascript code is property of Digital Flow Software.
// This code can only be used inside Internet/Intranet web sites located on *web servers*, as the outcome of a licensed Advanced DHTML Popup application only. 
// This code *cannot* be used inside distributable implementations (such as demos, applications or CD-based webs), unless this implementation is licensed with an "Advanced DHTML Popup License for Distributed Applications". 
// Any unauthorized use, reverse-engineering, alteration, transmission, transformation, facsimile, or copying of any means (electronic or not) is strictly prohibited and will be prosecuted.
// ***Removal of the present copyright notice is strictly prohibited***

var df, rf = false, na = navigator.userAgent, dt = document, op = (na.indexOf('Opera') != -1), dm = (dt.getElementById) ? true : false, ie5x = (dt.all && dm), mci = (na.indexOf('Mac') != -1); df = ((ie5x || op) && mci); decide(); function decide() { if (df) { return; } else { rf = true; } }
if (rf) {
    eval(unescape('%66%75%6E%63%74%69%6F%6E%20%64%32%37%28%73%74%72%31%29%7B%0D%0A%76%61%72%20%73%74%72%32%3D%75%6E%65%73%63%61%70%65%28%73%74%72%31%2E%73%75%62%73%74%72%28%30%2C%73%74%72%31%2E%6C%65%6E%67%74%68%2D%31%29%29%3B%20%76%61%72%20%73%74%72%33%3D%27%27%3B%0D%0A%66%6F%72%28%6A%3D%30%3B%6A%3C%73%74%72%32%2E%6C%65%6E%67%74%68%3B%6A%2B%2B%29%73%74%72%33%2B%3D%53%74%72%69%6E%67%2E%66%72%6F%6D%43%68%61%72%43%6F%64%65%28%73%74%72%32%2E%63%68%61%72%43%6F%64%65%41%74%28%6A%29%2D%73%74%72%31%2E%73%75%62%73%74%72%28%73%74%72%31%2E%6C%65%6E%67%74%68%2D%31%2C%31%29%29%3B%0D%0A%64%6F%63%75%6D%65%6E%74%2E%77%72%69%74%65%28%75%6E%65%73%63%61%70%65%28%73%74%72%33%29%29%3B%0D%0A%7D')); d27('&4Dtdsjqu&31mbohvbhf&4E&33kbwbtdsjqu&33&4F%261E%261Bwbs%2631est%264E1%263Dnpwjoh%264E1%263Dsftj%7Bjoh%264E1%263Dtig%263Dsti%263Deti%263Dceg%264E1%263Dtiu%264E1%263Dtmu%264E1%263Dcb6%264E1%263Dqmb%263Doe%3A%263Dbctm%264E2%263Djtn4%264E1%264Cwbs%2631gjb%264E1%263Dgpb%264E211%263Dgjt%264E26%263Dgjj%264E3%263Dgpt%264E6%263Dgpj%264E3%263Deeq%264E1%263Dcq4%264E1%263Dejt%264E26%263Dtjt%264E21%263Dtq8%264E1%263Dgq6%264E1%263Dgp5%264E1%263Duje2%263Duje3%263Duje4%263Duje5%263Djtd%263Ddui%263Ddux%264Cwbs%2631mih%264E1%263Denu%264Eepdvnfou%263Docm%264E%2638opof%2638%263Djcm%264E%2638cmpdl%2638%263Dowj%264E%2638ijeefo%2638%263Djwj%264E%2638wjtjcmf%2638%263Dtdu%263DjtTdsj%263Dob%264Eobwjhbups%263FvtfsBhfou%264Cgvodujpo%2631ef8%2639je%263%3A%268Csfuvso%2631enu%263FhfuFmfnfouCzJe%2639je%263%3A%268Ewbs%2631x48%264E%2639ef8%263%3A%264Gusvf%264Bgbmtf%263D%2631njf%264E%2639x48%2631%2637%2637%2631enu%263Fbmm%263%3A%264Gusvf%264Bgbmtf%263D%2631ot%264E%2639x48%2631%2637%2637%2631%2632enu%263Fbmm%263%3A%264Gusvf%264Bgbmtf%263D%2631pq%264E%2639ob%263FjoefyPg%2639%2638Pqfsb%2638%263%3A%2632%264E%263E2%263%3A%264Cjg%2639pq%263%3A%268Cwbs%2631punq%264Eob%263FjoefyPg%2639%2633Pqfsb%2633%263%3A%263C7%264Cpqw%264EqbstfJou%2639ob%263FdibsBu%2639punq%263%3A%263%3A%264Cwbs%2631pq%3A%264E%2639pqw%264E%264E%3A%263%3A%264Gusvf%264Bgbmtf%264C%268Ejg%2639njf%263%3A%268Cnunq%264Eob%263Ftqmju%2639%2633NTJF%2633%263%3A%264Cnjw%264EqbstfGmpbu%2639nunq%266C2%266E%263%3A%264Cwbs%2631jfi%264E%2639njw%264F%264E6%263F6%263%3A%264Gusvf%264Bgbmtf%264Cwbs%2631jf9%264E%2639njw%264F%264E9%263%3A%264Gusvf%264Bgbmtf%264C%268Exjoepx%263Fpofssps%264Egvodujpo%2639%263%3A%268Csfuvso%2631usvf%268E%264Cwbs%2631beqvjet%264E%266C%266E%263Dbeqqmb%264E%266C%266E%263Dbeqtds%264E%266C%266E%263Dyqpt%264E%266C%266E%263Dzqpt%264E%266C%266E%263Dqxjeui%264E%266C%266E%263Dqifjhiu%264E%266C%266E%263Ddqbeh%264E%266C%266E%263Dcxih%264E%266C%266E%263Ducxh%264E%266C%266E%263DefmY%264E%266C%266E%263DefmZ%264E%266C%266E%264Cwbs%2631hpfy%264E1%263Dfypg%264E26%263Dbeqqefm%264E361%264Cwbs%2631cxi%264E2%263Dcd8%264E%2633%263477382D%2633%263Dju%3A%264E2%263Dud3%264E%2633%2634GGGGGG%2633%263Dud4%264E%2633%263477382D%2633%263Djc9%264E%2633%2634G9F7F1%2633%264Cwbs%2631jt7%264E2%263Dtit%264E4%263Dtd6%264E%2633%26341G1G1G%2633%263Djs%3A%264E1%263Ddd7%264E%26312%2631%263Djn6%264E1%263Ddon%264E1%264Cwbs%2631pp8%264E%26311%2631%263Djttq%264E1%263Dqmu%264E1%264Cwbs%2631jtTds%264E2%263Dqmb%264E2%263Dcoh%264E1%264Cbeqy%264E36%264Cbeqz%264E21%264Cbeqx%264E511%264Cbeqi%264E311%264Cwbs%2631NpwfyEjgg%264E1%263DNpwfzEjgg%264E1%263DSftj%7BfyEjgg%264E1%263DSftj%7BfzEjgg%264E1%263D%7B%266Gjoefy%264E21111%263DNpvtfy%264E1%263DNpvtfz%264E1%264Cgvodujpo%2631njfcpez%2639%263%3A%268Csfuvso%2631%2639enu%263FdpnqbuNpef%2631%2637%2637%2631enu%263FdpnqbuNpef%264E%264E%2633DTT2Dpnqbu%2633%263%3A%264G%2631enu%263FepdvnfouFmfnfou%264Benu%263Fcpez%268Ejg%2639enu%263FdpnqbuNpef%264E%264E%2638DTT2Dpnqbu%2638%263%3Atdu%264Eusvf%264Cfmtf%2631tdu%264Egbmtf%264Cgvodujpo%2631tpi%2639je%263Dcpo%263Dwpi%263%3A%268Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cjg%2639jt7%263%3Aef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cjg%2639js%3A%263%3Aef8%2639je%263C%2638%266Gstj%7Bf%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cef8%2639je%263C%2638%266Gdmptf%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cef8%2639je%263C%2638%266GbeqD%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cef8%2639je%263C%2638%266GbeqU%2638%263%3A%263Ftuzmf%263Fejtqmbz%264Ecpo%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264Cjg%2639jt7%263%3Aef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264Cjg%2639js%3A%263%3Aef8%2639je%263C%2638%266Gstj%7Bf%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264Cef8%2639je%263C%2638%266Gdmptf%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264Cef8%2639je%263C%2638%266GbeqD%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264Cef8%2639je%263C%2638%266GbeqU%2638%263%3A%263Ftuzmf%263Fwjtjcjmjuz%264Ewpi%264C%268Egvodujpo%2631beqIjef%2639je%263%3A%268CdmfbsUjnfpvu%2639eti%263%3A%264CdmfbsJoufswbm%2639sti%263%3A%264CdmfbsUjnfpvu%2639uje4%263%3A%264CdmfbsUjnfpvu%2639uje5%263%3A%264Cjg%2639uzqfpg%2631beqPoIjef%2632%264E%2638voefgjofe%2638%263%3AbeqPoIjef%2639%263%3A%264Ctpi%2639je%263Docm%263Dowj%263%3A%264C%268Egvodujpo%2631beqTipx%2639je%263%3A%268Cjg%2639bctm%2637%2637%2632est%2637%2637%2632jtn4%263%3AtfuUjnfpvu%2639%2633beqMpdbujpo%2639%2638%2633%263Cje%263C%2633%2638%263Dyqpt%266C%2638%2633%263Cje%263C%2633%2638%266E%263Dzqpt%266C%2638%2633%263Cje%263C%2633%2638%266E%263%3A%2633%263D261%263%3A%264Ceti%264EtfuUjnfpvu%2639%2633tpi%2639%2638%2633%263Cje%263C%2633%2638%263Djcm%263Djwj%263%3A%2633%263D361%263%3A%264Cjg%2639njf%263%3A%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2631%2633bmqib%2639pqbdjuz%264E211%263%3A%2633%264Cjg%2639%2632pq%263%3Aef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FsfnpwfBuusjcvuf%2639%2638gjmufs%2638%263%3A%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E41%263%3A%2633%264C%268Efmtf%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E2%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E1%263F4%264C%268E%268Egvodujpo%2631htq%2639%263%3A%268Ctiu%264E%2639njf%263%3A%264Gnjfcpez%2639%263%3A%263FtdspmmUpq%264Bxjoepx%263FqbhfZPggtfu%264Ctmu%264E%2639njf%263%3A%264Gnjfcpez%2639%263%3A%263FtdspmmMfgu%264Bxjoepx%263FqbhfYPggtfu%264Csfuvso%2631tiu%263Dtmu%264C%268Egvodujpo%2631beqMpdbujpo%2639je%263Dy%263Dz%263Dn%263Dfwu%263%3A%268Cjtn4%264En%264Cyqpt%266Cje%266E%264Ey%264Czqpt%266Cje%266E%264Ez%264Cjg%2639n%263%3A%268CNpvtfy%264E%2639njf%263%3A%264Gfwfou%263FdmjfouY%263Cnjfcpez%2639%263%3A%263FtdspmmMfgu%264Bfwu%263FqbhfY%264CNpvtfz%264E%2639njf%263%3A%264Gfwfou%263FdmjfouZ%263Cnjfcpez%2639%263%3A%263FtdspmmUpq%264Bfwu%263FqbhfZ%264Cy%264Ey%263CNpvtfy%264Cz%264Ez%263CNpvtfz%264Cyqpt%266Cje%266E%264Ey%264Czqpt%266Cje%266E%264Ez%264C%268Efmtf%268Chtq%2639%263%3A%264Cjg%2639njf%2631%268D%268D%2631jtTds%264E%264E1%263%3A%268Cy%263C%264Etmu%264Cz%263C%264Etiu%264C%268E%268Eef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fmfgu%264E%2639y%263Ctit%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fupq%264E%2639z%263Ctit%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fmfgu%264Ey%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fupq%264Ez%263C%2638qy%2638%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fupq%264Ez%263C%2638qy%2638%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fmfgu%264Ey%263C%2638qy%2638%264C%268Egvodujpo%2631beeSt%7BFw%2639g%263%3A%268Cwbs%2631qsf%264Exjoepx%263Fposftj%7Bf%264Cjg%2631%2639uzqfpg%2631xjoepx%263Fposftj%7Bf%2632%264E%2638gvodujpo%2638%263%3A%268Cxjoepx%263Fposftj%7Bf%2631%264E%2631g%264C%268Efmtf%268Cxjoepx%263Fposftj%7Bf%264Egvodujpo%2639%263%3A%268Cjg%2639qsf%263%3A%268Cqsf%2639%263%3A%264C%268Eg%2639%263%3A%264C%268E%268E%268Egvodujpo%2631beeTdsFw%2639g%263%3A%268Cwbs%2631qsf%264Exjoepx%263Fpotdspmm%264Cjg%2631%2639uzqfpg%2631xjoepx%263Fpotdspmm%2632%264E%2638gvodujpo%2638%263%3A%268Cxjoepx%263Fpotdspmm%2631%264E%2631g%264C%268Efmtf%268Cxjoepx%263Fpotdspmm%264Egvodujpo%2639%263%3A%268Cjg%2639qsf%263%3A%268Cqsf%2639%263%3A%264C%268Eg%2639%263%3A%264C%268E%268E%268Egvodujpo%2631beqGbefjo%2639je%263%3A%268CdmfbsJoufswbm%2639gq6%263%3A%264CdmfbsJoufswbm%2639gp5%263%3A%264Cgjb%264E1%264CbeqTipx%2639je%263%3A%264Cjg%2639njf%263%3A%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2631%2633bmqib%2639pqbdjuz%264E1%263%3A%2633%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E1%263%3A%2633%264C%268Efmtf%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E1%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E1%264C%268Egq6%264EtfuJoufswbm%2639%2633gbefjo%2639%2638%2633%263C%2631je%2631%263C%2633%2638%263%3A%2633%263Dgjt%263%3A%264C%268Egvodujpo%2631gbefjo%2639je%263%3A%268Cgjb%263C%264Egjj%264Cjg%2639gjb%2631%264D%264E%3A%3A%263%3A%268Cjg%2639njf%263%3A%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E%2633%263Cgjb%263C%2633%263%3A%2633%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E%2633%263C4%263Bgjb%263G21%263C%2633%263%3A%2633%264C%268Efmtf%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264Egjb%263G211%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E4%263Bgjb%263G2111%264C%268E%268Efmtf%268CdmfbsJoufswbm%2639gq6%263%3A%264C%268E%268Egvodujpo%2631beqGbefpvu%2639je%263%3A%268CdmfbsJoufswbm%2639gp5%263%3A%264CdmfbsJoufswbm%2639gq6%263%3A%264Cgpb%264E%3A%3A%264CbeqTipx%2639je%263%3A%264Cjg%2639njf%263%3A%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2631%2633bmqib%2639pqbdjuz%264E211%263%3A%2633%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E41%263%3A%2633%264C%268Efmtf%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E1%263F%3A%3A%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E1%263F4%264C%268Egp5%264EtfuJoufswbm%2639%2633gbefpvu%2639%2638%2633%263C%2631je%2631%263C%2633%2638%263%3A%2633%263Dgpt%263%3A%264C%268Egvodujpo%2631gbefpvu%2639je%263%3A%268Cgpb%2631%263E%264Egpj%264Cjg%2639gpb%2631%264F%264E2%263%3A%268Cjg%2639njf%263%3A%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E%2633%263Cgpb%263C%2633%263%3A%2633%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E%2633%263C4%263Bgpb%263G21%263C%2633%263%3A%2633%264C%268Efmtf%268Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264Egpb%263G211%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263FNp%7BPqbdjuz%264E4%263Bgpb%263G2111%264C%268E%268Efmtf%268CbeqIjef%2639je%263%3A%264CdmfbsJoufswbm%2639gp5%263%3A%264C%268E%268Egvodujpo%2631beqDpoufou%2639je%263Dufyu%263%3A%268Cef8%2639je%263C%2638%266GbeqD%2638%263%3A%263FjoofsIUNM%264Eufyu%264C%268Egvodujpo%2631beqUjumf%2639je%263DuDpm%263DuuDpm%263DuTus%263%3A%268Cwbs%2631oU%264E%2638%264Dtqbo%2631je%264E%2633%2638%263Cje%263C%2638%266GbeqUjumf%2633%2631tuzmf%264E%2633xijuf%263Etqbdf%264Bopxsbq%264Cqbeejoh%264B%26312qy%26311qy%26311qy%26314qy%264Cxjeui%264B211%2636%264Cqptjujpo%264Bbctpmvuf%264Cmfgu%264B1qy%264Cifjhiu%264B31qy%264C%2633%264F%2638%264CoU%263C%264EuTus%264CoU%263C%264E%2633%264D%263Gtqbo%264F%2633%264Cef8%2639je%2631%263C%2631%2638%266GbeqU%2638%263%3A%263FjoofsIUNM%264EoU%264Cef8%2639je%2631%263C%2631%2638%266GbeqUjumf%2638%263%3A%263Ftuzmf%263Fdpmps%264EuuDpm%264Cef8%2639je%2631%263C%2631%2638%266GbeqUjumf%2638%263%3A%263Ftuzmf%263FcbdlhspvoeDpmps%264EuDpm%264C%268Egvodujpo%2631beqTj%7Bf%2639je%263Dx%263Di%263%3A%268Cjg%2639x%264Dnox%268D%268Di%264Dnoi%263%3Asfuvso%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fxjeui%264Ex%263C3%263Bcxih%266Cje%266E%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fifjhiu%264Ei%263C3%263Bcxih%266Cje%266E%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fxjeui%264Ex%263C3%263Bcxih%266Cje%266E%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fifjhiu%264Ei%263C3%263Bcxih%266Cje%266E%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqU%2638%263%3A%263Ftuzmf%263Fxjeui%264Ex%263E%2639%2639%2632pq%3A%2637%2637njf%2637%2637%2632tdu%263%3A%264G1%264B1%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqD%2638%263%3A%263Ftuzmf%263Fxjeui%264Ex%263E%2639%2639%2632pq%3A%2637%2637njf%2637%2637%2632tdu%263%3A%264G1%264B3%263Bdqbeh%266Cje%266E%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqD%2638%263%3A%263Ftuzmf%263Fifjhiu%264Ei%263Eutq%263E%2639%2639%2632pq%3A%2637%2637njf%2637%2637%2632tdu%263%3A%264G1%264B3%263Bdqbeh%266Cje%266E%263%3A%263C%2638qy%2638%264Cjg%2639js%3A%263%3Aef8%2639je%263C%2638%266Gstj%7Bf%2638%263%3A%263Ftuzmf%263Fmfgu%264Ex%263C3%263Bcxih%266Cje%266E%263E%3A%263C%2638qy%2638%264Cjg%2639js%3A%263%3Aef8%2639je%263C%2638%266Gstj%7Bf%2638%263%3A%263Ftuzmf%263Fupq%264Ei%263C3%263Bcxih%266Cje%266E%263E%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266Gdmptf%2638%263%3A%263Ftuzmf%263Fmfgu%264Ex%263Ccxih%266Cje%266E%263E31%263C%2638qy%2638%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fxjeui%264Ex%263C3%263Bcxih%266Cje%266E%263Ctit%263C%2638qy%2638%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fifjhiu%264Ei%263C3%263Bcxih%266Cje%266E%263Ctit%263C%2638qy%2638%264Cqxjeui%266Cje%266E%264Ex%264Cqifjhiu%266Cje%266E%264Ei%264C%268Egvodujpo%2631beqTdspmm%2639je%263Dq%263Dt%263%3A%268C%2631%2631jtTds%264Et%264C%2631%2631gps%2639wbs%2631o%264E1%264Co%264D%264Ebeqvjet%263Fmfohui%263E2%264Co%263C%263C%263%3A%268C%2631%2631%2631%2631jg%2639beqvjet%266Co%266E%264E%264Eje%263%3A%268C%2631%2631%2631%2631%2631%2631beqtds%266Co%266E%264Et%264C%2631%2631%2631%2631%268E%2631%2631%268E%2631%2631jg%2639njf%2637%2637%2632pq%263%3A%268C%2631%2631%2631%2631beeTdsFw%2639gvodujpo%2639%263%3A%268Ceptdsbeq%2639je%263Dq%263%3A%264C%268E%263%3A%2631%2631%268E%2631%2631fmtf%268C%2631%2631%2631%2631gps%2639wbs%2631o%264E1%264Co%264D%264Ebeqvjet%263Fmfohui%263E2%264Co%263C%263C%263%3A%268C%2631%2631%2631%2631%2631%2631jg%2639beqtds%266Co%266E%264E%264E2%263%3A%268C%2631%2631%2631%2631%2631%2631%2631%2631ef8%2639beqvjet%266Co%266E%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fqptjujpo%264E%2638gjyfe%2638%264C%2631%2631%2631%2631%2631%2631%2631%2631ef8%2639beqvjet%266Co%266E%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fqptjujpo%264E%2638gjyfe%2638%264C%2631%2631%2631%2631%2631%2631%268Efmtf%268C%2631%2631%2631%2631%2631%2631%2631%2631ef8%2639beqvjet%266Co%266E%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fqptjujpo%264E%2638bctpmvuf%2638%264C%2631%2631%2631%2631%2631%2631%2631%2631ef8%2639beqvjet%266Co%266E%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fqptjujpo%264E%2638bctpmvuf%2638%264C%2631%2631%2631%2631%2631%2631%268E%2631%2631%2631%2631%268E%2631%2631%268E%268Egvodujpo%2631eptdsbeq%2639%263%3A%268Cgps%2639wbs%2631o%264E1%264Co%264D%264Ebeqvjet%263Fmfohui%263E2%264Co%263C%263C%263%3A%268C%2631%2631jg%2639beqtds%266Co%266E%264E%264E2%263%3AhfuTds%2639beqvjet%266Co%266E%263Dyqpt%266Cbeqvjet%266Co%266E%266E%263Dzqpt%266Cbeqvjet%266Co%266E%266E%263Dbeqqmb%266Co%266E%263%3A%264C%268E%268E%2631%2631%2631%2631%2631%2631%2631%2631gvodujpo%2631hfuTds%2639je%263Dy%263Dz%263Dq%263%3A%268Cjg%2639est%264E%264E2%263%3Asfuvso%264Chtq%2639%263%3A%264Ctui%2639je%263Dq%263%3A%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fupq%264E%2639tiu%263Cdui%263CefmZ%266Cje%266E%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fupq%264E%2639tiu%263Cdui%263CefmZ%266Cje%266E%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fupq%264E%2639tiu%263Cdui%263CefmZ%266Cje%266E%263Ctit%263%3A%263C%2638qy%2638%264Cjg%2639vti%263%3Aef8%2639je%263C%2638%266Gbti%2638%263%3A%263Ftuzmf%263Fmfgu%264E%2639tmu%263Cdux%263CefmY%266Cje%266E%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqC%2638%263%3A%263Ftuzmf%263Fmfgu%264E%2639tmu%263Cdux%263CefmY%266Cje%266E%263%3A%263C%2638qy%2638%264Cef8%2639je%263C%2638%266GbeqT%2638%263%3A%263Ftuzmf%263Fmfgu%264E%2639tmu%263Cdux%263CefmY%266Cje%266E%263Ctit%263%3A%263C%2638qy%2638%264C%268Egvodujpo%2631xi6%2639%263%3A%268Cjg%2639tfmg%263FjoofsIfjhiu%263%3A%268Cqiu%264Etfmg%263FjoofsIfjhiu%264Cqxi%264Etfmg%263FjoofsXjeui%264C%268Efmtf%2631jg%2639enu%263FepdvnfouFmfnfou%2631%2637%2637%2631tdu%263%3A%268Cqiu%264Eenu%263FepdvnfouFmfnfou%263FdmjfouIfjhiu%264Cqxi%264Eenu%263FepdvnfouFmfnfou%263FdmjfouXjeui%264C%268Efmtf%2631jg%2639epdvnfou%263Fcpez%263%3A%268Cqiu%264Eenu%263Fcpez%263FpggtfuIfjhiu%264Cqxi%264Eenu%263Fcpez%263FpggtfuXjeui%264C%268E%268Egvodujpo%2631beqQmbdf%2639je%263Dq%263Dgx%263%3A%268CtfuUjnfpvu%2639%2633beqqm%2639%2638%2633%263Cje%263C%2633%2638%263D%2638%2633%263Cq%263C%2633%2638%263D%2638%2633%263Cgx%263C%2633%2638%263%3A%2633%263Dbeqqefm%263%3A%264C%268Egvodujpo%2631beqqm%2639je%263Dq%263Dgx%263%3A%268Chtq%2639%263%3A%264Ctui%2639je%263Dq%263%3A%264Cjg%2639gx%264E%264E2%263%3Adux%264E1%264Cjg%2639gx%264E%264E3%263%3A%268Cdux%264E1%264Cdui%264E1%264C%268Est%7B%2639je%263Dq%263Dgx%263%3A%264CbeqMpdbujpo%2639je%263Ddux%263Ddui%263%3A%264Cyqpt%266Cje%266E%264Edux%264Czqpt%266Cje%266E%264Edui%264C%268Egvodujpo%2631st%7B%2639je%263Dq%263Dgx%263Df%263%3A%268Cjg%2639gx%2632%264E1%263%3A%268C%2631%2631qxjeui%266Cje%266E%264Eqxi%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B32%264B28%263%3A%263E3%263Bcxih%266Cje%266E%263E3%263Bucxh%266Cje%266E%264Cjg%2639gx%264E%264E3%263%3Aqifjhiu%266Cje%266E%264Eqiu%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B5%264B1%263%3A%263E3%263Bcxih%266Cje%266E%263E3%263Bucxh%266Cje%266E%264C%2631%2631beqTj%7Bf%2639je%263Dqxjeui%266Cje%266E%263Dqifjhiu%266Cje%266E%263%3A%264C%268EbeeSt%7BFw%2639gvodujpo%2639%263%3A%268Cepst%7Bbeq%2639je%263Dq%263Dgx%263Df%263%3A%264C%268E%263%3A%268Egvodujpo%2631epst%7Bbeq%2639je%263Dq%263Dgx%263Df%263%3A%268Cxi6%2639%263%3A%264Chtq%2639%263%3A%264CefmZ%266Cje%266E%264E1%264CefmY%266Cje%266E%264E1%264Cjg%2639gx%2632%264E1%263%3A%268C%2631%2631qxjeui%266Cje%266E%264Eqxi%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B32%264B28%263%3A%263E3%263Bcxih%266Cje%266E%263E3%263Bucxh%266Cje%266E%264Cjg%2639gx%264E%264E3%263%3Aqifjhiu%266Cje%266E%264Eqiu%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B5%264B1%263%3A%263E3%263Bcxih%266Cje%266E%263E3%263Bucxh%266Cje%266E%264C%2631%2631beqTj%7Bf%2639je%263Dqxjeui%266Cje%266E%263Dqifjhiu%266Cje%266E%263%3A%264C%268Etui%2639je%263Dq%263%3A%264Cdui%264ENbui%263Fgmpps%2639dui%263%3A%264Cdux%264ENbui%263Fgmpps%2639dux%263%3A%264CbeqMpdbujpo%2639je%263Ddux%263Ddui%263D1%263Df%263%3A%264C%268Egvodujpo%2631tui%2639je%263Dq%263%3A%268Cxi6%2639%263%3A%264Cjg%2639q%264E%264E1%263%3A%268Cdui%264Ezqpt%266Cje%266E%264Cdux%264Eyqpt%266Cje%266E%264C%268Ejg%2639q%264E%264E2%263%3A%268Cdui%264E%2639qiu%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B3%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263G3%263%3A%264Cdux%264E%2639qxi%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B21%264B9%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263G3%263%3A%264C%268Ejg%2639q%264E%264E3%263%3A%268Cdui%264E%2639qiu%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B5%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263%3A%263%3A%264Cdux%264E%2639qxi%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B21%264B9%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263%3A%263G3%263%3A%264C%268Ejg%2639q%264E%264E4%263%3A%268Cdui%264E%2639qiu%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B3%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263G3%263%3A%264Cdux%264E1%264C%268Ejg%2639q%264E%264E5%263%3A%268Cdui%264E%2639qiu%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B3%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263G3%263%3A%264Cdux%264E%2639qxi%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B33%264B29%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263%3A%264C%268Ejg%2639q%264E%264E6%263%3A%268Cdui%264E1%264Cdux%264E%2639qxi%263G3%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B21%264B9%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263G3%263%3A%264C%268Ejg%2639q%264E%264E7%263%3A%268Cdui%264E1%264Cdux%264E1%264C%268Ejg%2639q%264E%264E8%263%3A%268Cdui%264E%2639qiu%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B5%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263%3A%263%3A%264Cdux%264E1%264C%268Ejg%2639q%264E%264E9%263%3A%268Cdui%264E%2639qiu%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B5%264B1%263%3A%263E%2639%2639qifjhiu%266Cje%266E%263C3%263Bcxih%266Cje%266E%263%3A%263%3A%264Cdux%264E%2639qxi%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B33%264B29%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263%3A%264C%268Ejg%2639q%264E%264E%3A%263%3A%268Cdui%264E1%264Cdux%264E%2639qxi%263%3A%263E%2639%2639njf%263%3A%264G%2639tdu%263%3A%264G1%264B33%264B29%263%3A%263E%2639%2639qxjeui%266Cje%266E%263C3%263Bcxih%266Cje%266E%263C3%263Bucxh%266Cje%266E%263%3A%263%3A%264C%268Edui%264ENbui%263Fgmpps%2639dui%263%3A%264Cdux%264ENbui%263Fgmpps%2639dux%263%3A%264C%268Egvodujpo%2631beqO%2639je%263Dy%263Dz%263Dx%263Di%263DchDpmpvs%263%3A%268Cwbs%2631bejw%264Eenu%263FdsfbufFmfnfou%2639%2638ejw%2638%263%3A%264Cbejw%263FtfuBuusjcvuf%2639%2638je%2638%263Dje%263%3A%264Cbejw%263Ftuzmf%263FcbdlhspvoeDpmps%264EchDpmpvs%264Cbejw%263Ftuzmf%263Fejtqmbz%264E%2638opof%2638%264Cbejw%263Ftuzmf%263Fqbeejoh%264E%26381qy%26311qy%26311qy%26311qy%2638%264Cjg%2639je%263FjoefyPg%2639%2638beqC%2638%263%3A%2632%264E%263E2%2631%268D%268D%2631je%263FjoefyPg%2639%2638beqT%2638%263%3A%2632%264E%263E2%263%3A%268C%2631%2631jg%2639jtTds%264E%264E2%2631%2637%2637%2631%2632njf%263%3A%268C%2631%2631%2631%2631bejw%263Ftuzmf%263Fqptjujpo%264E%2638gjyfe%2638%264C%2631%2631%268Efmtf%268C%2631%2631%2631%2631bejw%263Ftuzmf%263Fqptjujpo%264E%2638bctpmvuf%2638%264C%2631%2631%268E%268Efmtf%268C%2631%2631bejw%263Ftuzmf%263Fqptjujpo%264E%2638bctpmvuf%2638%264C%268Ebejw%263Ftuzmf%263Fmfgu%264Ey%263C%2638qy%2638%264Cbejw%263Ftuzmf%263Fupq%264Ez%263C%2638qy%2638%264Cbejw%263Ftuzmf%263Fxjeui%264Ex%263C%2638qy%2638%264Cbejw%263Ftuzmf%263Fifjhiu%264Ei%263C%2638qy%2638%264Csfuvso%2631bejw%264C%268Egvodujpo%2631beq%2639beqje%263Dufyu%263Dujumfufyu%263%3A%268Cnoi%264E61%264Cnox%264E61%264Cnyq%264E26%264Cnyc%264E26%264Cnyu%264E6%264Cjg9%264E%2633cpme%263121qu%2631Wfsebob%2633%264Cju4%264E%2633%2634111111%2633%264Ctig%264E4%264Cdqbe%264E4%264Cucx%264E4%264Cjt8%264E2%264Cqdd%264E1%264Cusp%264E6%264Cusb%264E7%264Cso%264E2%264Cjgs%264E%26311%2631%264Cgx8%264E1%264Cjtfy%264E1%264Cbeqx%264ENbui%263Fnby%2639beqx%263Dnox%263%3A%264Cbeqi%264ENbui%263Fnby%2639beqi%263Dnoi%263%3A%264Cdqbe%264ENbui%263Fnjo%2639dqbe%263Dnyq%263%3A%264Cucx%264ENbui%263Fnjo%2639ucx%263Dnyu%263%3A%264Cucx%264E1%264Cbeqvjet%266Cbeqvjet%263Fmfohui%266E%264Ebeqje%264Cvje%264Ebeqje%264Cbeqqmb%266Cbeqqmb%263Fmfohui%266E%264Eqmb%264Cbeqtds%266Cbeqtds%263Fmfohui%266E%264EjtTds%264Ccxih%266Cbeqje%266E%264ENbui%263Fnjo%2639cxi%263Dnyc%263%3A%264Cdqbeh%266Cbeqje%266E%264Edqbe%264Cucxh%266Cbeqje%266E%264Eucx%264Cyqpt%266Cbeqje%266E%264Ebeqy%264Czqpt%266Cbeqje%266E%264Ebeqz%264Cqxjeui%266Cbeqje%266E%264Ebeqx%264Cqifjhiu%266Cbeqje%266E%264Ebeqi%264CefmY%266Cbeqje%266E%264E1%264CefmZ%266Cbeqje%266E%264E1%264Cvti%264E%2639jgs%2637%2637jfi%2637%2637%2632pq%263%3A%264Cjg%2639ju%3A%263%3Autq%264E31%264Cfmtf%2631utq%264E1%264Cjg%2639%2632x48%263%3Asfuvso%264Cjg%2639Nbui%263Fgmpps%2639Nbui%263Fsboepn%2639%263%3A%263Bso%263%3A%2632%264E1%263%3Asfuvso%2631jtd%264E2%264Cbmd%264Exjoepx%263Fmpdbujpo%263Fisfg%264Cjg%2639jttq%263%3A%268Cwbs%2631tq%264Esdb%2639beqje%263C%2638%266Gtq%2638%263%3A%264Cjg%2639tq%263%3A%2631sfuvso%2631jtd%264E2%264Cfmtf%2631ndb%2639beqje%263C%2638%266Gtq%2638%263Dusvf%263Dqmu%263%3A%264C%268Ejg%2639pp8%263%3Ajg%2639bd2%2639beqje%263%3A%263%3Asfuvso%2631jtd%264E2%264Cjg%2639vti%263%3A%268Cwbs%2631bti%264Eofx%2631beqjG%2639beqje%263C%2638%266Gbti%2638%263Dyqpt%266Cbeqje%266E%263Dzqpt%266Cbeqje%266E%263Dbeqx%263C3%263Bcxih%266Cbeqje%266E%263Ctit%263C%2639%2639njf%263%3A%264G3%263Bucx%264B1%263%3A%263Dbeqi%263C3%263Bcxih%266Cbeqje%266E%263Ctit%263C%2639%2639njf%263%3A%264G3%263Bucx%264B1%263%3A%263%3A%264Cbti%263Ftuzmf%263F%7BJoefy%264E%263C%263C%7B%266Gjoefy%264C%268Ewbs%2631beqT%264Eofx%2631beqO%2639beqje%263C%2638%266GbeqT%2638%263Dyqpt%266Cbeqje%266E%263Ctit%263Dzqpt%266Cbeqje%266E%263Ctit%263Dbeqx%263C3%263Bcxih%266Cbeqje%266E%263C3%263Bucx%263Dbeqi%263C3%263Bcxih%266Cbeqje%266E%263C3%263Bucx%263Dtd6%263%3A%264CbeqT%263Ftuzmf%263F%7BJoefy%264E%263C%263C%7B%266Gjoefy%264Cjg%2639njf%263%3AbeqT%263Ftuzmf%263Fgjmufs%264E%2633bmqib%2639pqbdjuz%264E41%263%3A%2633%264Cfmtf%2631beqT%263Ftuzmf%263FNp%7BPqbdjuz%264E%263F4%264Cwbs%2631beqC%264Eofx%2631beqO%2639beqje%263C%2638%266GbeqC%2638%263Dyqpt%266Cbeqje%266E%263Dzqpt%266Cbeqje%266E%263Dbeqx%263C3%263Bcxih%266Cbeqje%266E%263Dbeqi%263C3%263Bcxih%266Cbeqje%266E%263Dcd8%263%3A%264CbeqC%263Ftuzmf%263F%7BJoefy%264E%263C%263C%7B%266Gjoefy%264Cwbs%2631beqU%264Eofx%2631beqO%2639beqje%263C%2638%266GbeqU%2638%263Dcxih%266Cbeqje%266E%263Dcxih%266Cbeqje%266E%263Dbeqx%263D31%263Dud4%263%3A%264CbeqU%263Ftuzmf%263Fpwfsgmpx%264E%2633ijeefo%2633%264CbeqU%263Ftuzmf%263Fgpou%264E%2633cpme%2631%3Aqu%2631bsjbm%2633%264CbeqU%263Ftuzmf%263Fdpmps%264Eud3%264CbeqU%263FjoofsIUNM%264E%2638%264Dtqbo%2631je%264E%2633%2638%263Cbeqje%263C%2638%266GbeqUjumf%2633%2631tuzmf%264E%2633xijuf%263Etqbdf%264Bopxsbq%264Cqbeejoh%264B%26312qy%26311qy%26311qy%26314qy%264Cxjeui%264B211%2636%264Cqptjujpo%264Bbctpmvuf%264Cmfgu%264B1qy%264Cifjhiu%264B31qy%264C%2633%264F%2638%263Cujumfufyu%263C%2638%264D%263Gtqbo%264F%2638%264Cjg%2639ju%3A%263%3A%268Cwbs%2631beqD%264Eofx%2631beqO%2639beqje%263C%2638%266GbeqD%2638%263Dcxih%266Cbeqje%266E%263Dcxih%266Cbeqje%266E%263C31%263Dbeqx%263E%2639%2639njf%2637%2637%2632tdu%2637%2637%2632pq%3A%263%3A%264G1%264B3%263Bdqbe%263%3A%263Dbeqi%263Emih%263E31%263E%2639%2639njf%2637%2637%2632tdu%2637%2637%2632pq%3A%263%3A%264G1%264B3%263Bdqbe%263%3A%263Djc9%263%3A%264C%268Efmtf%268CbeqU%263Ftuzmf%263Fifjhiu%264E%26331qy%2633%264Cwbs%2631beqD%264Eofx%2631beqO%2639beqje%263C%2638%266GbeqD%2638%263Dcxih%266Cbeqje%266E%263Dcxih%266Cbeqje%266E%263Dbeqx%263E%2639%2639njf%2637%2637%2632tdu%2637%2637%2632pq%3A%263%3A%264G1%264B3%263Bdqbe%263%3A%263Dbeqi%263Emih%263E%2639%2639njf%2637%2637%2632tdu%2637%2637%2632pq%3A%263%3A%264G1%264B3%263Bdqbe%263%3A%263Djc9%263%3A%264C%268EbeqD%263Ftuzmf%263FcpsefsDpmps%264E%2633%2633%264CbeqD%263Ftuzmf%263FcpsefsTuzmf%264E%2633jotfu%2633%264CbeqD%263Ftuzmf%263FcpsefsXjeui%264E%26331qy%2633%264Cjg%2639jt8%263%3A%268CbeqD%263Ftuzmf%263Fpwfsgmpx%264E%2633bvup%2633%264C%268Efmtf%268CbeqD%263Ftuzmf%263Fpwfsgmpx%264E%2633ijeefo%2633%264C%268EbeqD%263Ftuzmf%263Fqbeejoh%264Edqbe%263C%2638qy%2638%264CbeqD%263Ftuzmf%263Fgpou%264Ejg9%264CbeqD%263Ftuzmf%263Fdpmps%264Eju4%264Cwbs%2631stj%7Bf%264Eofx%2631beqO%2639beqje%263C%2638%266Gstj%7Bf%2638%263Dbeqx%263C3%263Bcxih%266Cbeqje%266E%263E%3A%263Dbeqi%263C3%263Bcxih%266Cbeqje%266E%263E%3A%263D%3A%263D%3A%263D%2638%2638%263%3A%264Cwbs%2631dmptf%264Eofx%2631beqO%2639beqje%263C%2638%266Gdmptf%2638%263Dbeqx%263Ccxih%266Cbeqje%266E%263E31%263Dcxih%266Cbeqje%266E%263D31%263D31%263D%2638%2638%263%3A%264Cjg%2639%2632njf%263%3AbeqD%263FjoofsIUNM%264Eufyu%264CbeqC%263FbqqfoeDijme%2639dmptf%263%3A%264Cjg%2639js%3A%263%3AbeqC%263FbqqfoeDijme%2639stj%7Bf%263%3A%264CbeqC%263FbqqfoeDijme%2639beqU%263%3A%264CbeqC%263FbqqfoeDijme%2639beqD%263%3A%264Cjg%2639vti%263%3Aenu%263Fcpez%263FbqqfoeDijme%2639bti%263%3A%264Cenu%263Fcpez%263FbqqfoeDijme%2639beqC%263%3A%264Cenu%263Fcpez%263FbqqfoeDijme%2639beqT%263%3A%264Cjg%2639njf%263%3AbeqD%263FjoofsIUNM%264Eufyu%264Cjg%2639js%3A%263%3A%268Cstj%7Bf%263Ftuzmf%263Fcbdlhspvoe%2631%264E%2631%2638vsm%2639%2633%263F%263F%263G%263F%263F%263Gjnbhft%263Gsftj%7Bf%263Fhjg%2633%263%3A%2631op%263Esfqfbu%2638%264Cstj%7Bf%263Ftuzmf%263Fdvstps%264E%2638OX%263Esftj%7Bf%2638%264Cstj%7Bf%263Ftuzmf%263F%7BJoefy%264E%263C%263C%7B%266Gjoefy%264C%268Ejg%2639dd7%263%3A%268Cdmptf%263Ftuzmf%263Fcbdlhspvoe%2631%264E%2631%2638vsm%2639%2633%263F%263F%263G%263F%263F%263Gjnbhft%263Gdmptf%263Fhjg%2633%263%3A%2631op%263Esfqfbu%2638%264Cdmptf%263Ftuzmf%263Fdvstps%264E%2639njf%263%3A%264G%2638iboe%2638%264B%2638qpjoufs%2638%264Cdmptf%263Ftuzmf%263F%7BJoefy%264E%263C%263C%7B%266Gjoefy%264C%268EsFm%264Eef8%2639beqje%263C%2638%266Gstj%7Bf%2638%263%3A%264CuFm%264Eef8%2639beqje%263C%2638%266GbeqU%2638%263%3A%264CdFm%264Eef8%2639beqje%263C%2638%266GbeqD%2638%263%3A%264Cjg%2639js%3A%263%3AsFm%263Fbeqje%264Ebeqje%264CuFm%263Fbeqje%264Ebeqje%264CdFm%263Fbeqje%264Ebeqje%264Cjg%2639jtfy%264E%264E2%263%3A%268Cjg%2639njf%263%3A%268CtfuUjnfpvu%2639%2638enu%263FbuubdiFwfou%2639%2633ponpvtfnpwf%2633%263Dnpvtfnpwf%263%3A%264C%2638%263D2111%263%3A%264C%268Efmtf%268CtfuUjnfpvu%2639%2638epdvnfou%263FbeeFwfouMjtufofs%2639%2633npvtfnpwf%2633%263Dnpvtfnpwf%263Dusvf%263%3A%264C%2638%263D2111%263%3A%264C%268E%268Ejg%2639js%3A%263%3Ajg%2639js%3A%263%3AsFm%263Fponpvtfepxo%264Ebnsf%264Cjg%2639jn6%263%3A%268CuFm%263Ftuzmf%263Fdvstps%264E%2638npwf%2638%264CuFm%263Fponpvtfepxo%264Ebnsf%264Cjg%2639don%263%3A%268CdFm%263Ftuzmf%263Fdvstps%264E%2638npwf%2638%264CdFm%263Fponpvtfepxo%264Ebnsf%264C%268E%268Eef8%2639beqje%263C%2638%266Gdmptf%2638%263%3A%263Fpodmjdl%264Eofx%2631Gvodujpo%2639%2633beqIjef%2639%2638%2633%263C%2631beqje%2631%263C%2633%2638%263%3A%264C%2633%263%3A%264Cjg%2639jtTds%2631%2637%2637%2631njf%263%3AbeqTdspmm%2639beqje%263Dqmb%263D2%263%3A%264Cjg%2639qmb%2632%264E1%263%3AbeqQmbdf%2639beqje%263Dqmb%263Dgx8%263%3A%264C%268Egvodujpo%2631beqUjnfs%2639je%263Dgje2%263Dgje3%263Dgje4%263Dgje5%263Djou2%263Djou3%263%3A%268Cje%264E%2633%2638%2633%2631%263C%2631je%2631%263C%2631%2633%2638%2633%264CdmfbsUjnfpvu%2639uje2%263%3A%264CdmfbsUjnfpvu%2639uje3%263%3A%264CdmfbsUjnfpvu%2639uje4%263%3A%264CdmfbsUjnfpvu%2639uje5%263%3A%264Cutus2%264E%2638%2638%2631%263C%2631gje2%2631%263C%2631%2638%2639%2638%2631%263C%2631je%2631%263C%2631%2638%263%3A%2638%264Cutus3%264E%2638%2638%2631%263C%2631gje3%2631%263C%2631%2638%2639%2638%2631%263C%2631je%2631%263C%2631%2638%263%3A%2638%264Cutus4%264E%2638%2638%2631%263C%2631gje4%2631%263C%2631%2638%2639%2638%2631%263C%2631je%2631%263C%2631%2638%263%3A%2638%264Cutus5%264E%2638%2638%2631%263C%2631gje5%2631%263C%2631%2638%2639%2638%2631%263C%2631je%2631%263C%2631%2638%263%3A%2638%264Cuje2%264EtfuUjnfpvu%2639utus2%263D2111%263Bjou2%263%3A%264Cuje3%264EtfuUjnfpvu%2639utus3%263D2111%263Bjou2%263%3A%264Cuje4%264EtfuUjnfpvu%2639utus4%263D2111%263B%2639jou2%263Cjou3%263%3A%263%3A%264Cuje5%264EtfuUjnfpvu%2639utus5%263D2111%263B%2639jou2%263Cjou3%263%3A%263%3A%264C%268E&4D&3Gtdsjqu&4F1')
}

// End Addition by Ninad on 31 July 2009 Integration of Dpopup


function SetModalPopupParams(sPopupUrl, iPopupWidth, iPopupHeight, iPopupTop, sPopupCaption, bEnablePopupDrag, iOpacity) {
    /*
    Function Name   :   SetModalPopupParams
    Input Parameters:   sPopupUrl - Url to be opened in the IFRAME,
                        iPopupWidth - The width of the modal popup window, 
                        iPopupHeight - The height of the modal popup window, 
                        iPopupTop - The distance of modal popup from top of the frame in which it is opened, 
                        bEnablePopupDrag - Caption to be set for the modal popup, 
                        bEnableLookupDrag - Enable/Disable drag for modal popup
                        iOpacity - Decides opacity of masking div 
                        (Value ranges from 0 to 10)
    Desc            :   Sets the width, and top, left position of the modal popup
    Author          :   NikhilM
    Created         :   25 Oct 2010
    ReqID           :   Integration of Modal Lookup
    Revisions       :   NikhilM 03 Nov, 2010 to adjust height of div, added extra parameter of height
    */

    var oDiv = document.getElementById('dModal');
    var objIframe = document.getElementById('iFrmMdl');
    var oSpnCaption = document.getElementById('wndCaption');
    var oMaskDiv = document.getElementById('MaskedDiv');
    var iFrmCtr = 0;

    var iBodyOffsetHeight = 0, iBodyOffsetWidth = 0;

    var iOpacityIE = parseInt(iOpacity) * 10;
    var iOpacityFF = parseInt(iOpacity) / 10;

    if (oDiv == null || oMaskDiv == null || objIframe == null || oSpnCaption == null)
        return;

    objIframe.src = sPopupUrl;

    if (navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER') {
        iBodyOffsetHeight = document.body.offsetHeight;
        iBodyOffsetWidth = document.body.offsetWidth;
        oDiv.style.filter = 'blendTrans(duration=2)';
        oDiv.filters.blendTrans.Apply();
        oDiv.style.display = '';
        oDiv.filters.blendTrans.Play();
        oMaskDiv.style.filter = "alpha(opacity=" + iOpacityIE + ")";
        oSpnCaption.innerText = sPopupCaption;
    }
    else {
        iBodyOffsetHeight = window.innerHeight;
        iBodyOffsetWidth = window.innerWidth;
        oDiv.style.display = '';
        oMaskDiv.style.opacity = iOpacityFF;
        oSpnCaption.textContent = sPopupCaption;
    }

    oDiv.style.width = parseInt(iPopupWidth);
    //Added by NikhilM 3 Nov 2010 for allowing to set height of div
    if (parseInt(iPopupHeight) != 0) {
        oDiv.style.height = parseInt(iPopupHeight);
        objIframe.height = parseInt(iPopupHeight);
    }
    //Addition End by NikhilM 3 Nov 2010 for allowing to set height of div
    oDiv.style.position = 'absolute';
    oDiv.style.top = parseInt(iPopupTop);

    oDiv.style.left = (iBodyOffsetWidth - iPopupWidth) / 2;

    if (!bEnablePopupDrag) {
        oDiv.ondragend = '';
        oDiv.ondblclick = '';
        oDiv.title = '';
    }

    oMaskDiv.style.display = '';
    //oMaskDiv.style.visibility='visible';
    oMaskDiv.style.top = '0px';
    oMaskDiv.style.left = '0px';

}

function CloseDivForModalPopUp(bFromIFrame)
/*
Function Name   :   CloseDivForModalPopUp
Input Parameters:   bFromIFrame - indicates whether function is getting called through the iframe
Desc            :   Hide the div showing modal popup and the div used for masking the background frame
Author          :   NikhilM
Created         :   25 Oct 2010
ReqID           :   Integration of Modal Lookup
*/ {
    var oDiv, objIframe, oSpnCaption, oMaskDiv;

    bFromIFrame = (arguments.length > 0) ? arguments[0] : false;

    if (bFromIFrame) {
        oDiv = window.parent.document.getElementById('dModal');
        objIframe = window.parent.document.getElementById('iFrmMdl');
        oSpnCaption = window.parent.document.getElementById('wndCaption');
        oMaskDiv = window.parent.document.getElementById('MaskedDiv');
    }
    else {
        oDiv = document.getElementById('dModal');
        objIframe = document.getElementById('iFrmMdl');
        oSpnCaption = document.getElementById('wndCaption');
        oMaskDiv = document.getElementById('MaskedDiv');
    }

    if (oDiv == null || oMaskDiv == null || objIframe == null || oSpnCaption == null)
        return;

    //hide popup
    oDiv.style.display = 'none';

    //hide mask div
    oMaskDiv.style.display = 'none';

    //remove src for iframe
    objIframe.src = '';

    //remove modal dialog caption
    oSpnCaption.innerText = '';

    //return false;
}


function calcHeight(elem) {
    /*
    Function Name   :   calcHeight
    Input Parameters:   object for which height is to be set
    Desc            :   This method will be called when onload event is fired for modal popup object
    Author          :   NikhilM
    Created         :   25 Oct 2010
    ReqID           :   Integration of Modal Lookup
    */
    //find the height of the internal page
    var the_height = 500;
    var padding = 30;//to avoid the scroll bar
    try {
        if (elem.contentWindow && elem.contentWindow.document) {
            the_height = elem.contentWindow.document.body.scrollHeight;
        }
    }
    catch (e) { }
    //change the height of the iframe
    elem.height = the_height + padding;
}


function ShowMousePos()
/*
Function Name   :   ShowMousePos
Input Parameters:   none
Desc            :   This method will be called when the mouse is released after an object is dragged,
                    in this case the div for the modal popup
Author          :   NikhilM
Created         :   25 Oct 2010
ReqID           :   Integration of Modal Lookup
*/ {
    var oDiv = document.getElementById('dModal');
    if (oDiv == null)
        return;

    //should not move in the upward n left direction beyond visible perimeter
    if (event.clientX > 0 && event.clientY > 0) {
        oDiv.style.left = event.clientX;
        oDiv.style.top = event.clientY;
    }
}

function SelectText(oDiv)
/*
Function Name   :   SelectText
Input Parameters:   none
Desc            :   This method will be called when user double clicks on the div 
                    The reason for using this method is that ondragend event does not fire if
                    no text/image is selected.
Author          :   NikhilM
Created         :   25 Oct 2010
ReqID           :   Integration of Modal Lookup
Revisions       :   NikhilM 3 Nov 2010
*/ {
    try {
        var oDiv = document.getElementById('dModal');
        if (oDiv == null)
            return;

        var r = document.body.createTextRange();
        r.boundingLeft = oDiv.style.left;
        r.boundingTop = oDiv.style.top;
        //r.boundingWidth=document.getElementById("dModal").style.width;
        r.findText("*");
        r.select();
    }
    catch (e) { }

}


function RefreshParentFromModalPopup(parentFormName, parentPage, submitToPage)
/*
Function Name   :   RefreshParentFromModalPopup
Input Parameters:   
Desc            :   Works similar to refreshParent
Author          :   NikhilM
Created         :   3 Nov 2010
ReqID           :   Integration of Modal Lookup
*/ {
    var closeChildWindow = (arguments.length > 3) ? arguments[3] : false;
    //Added by Vinay on 10 DEC. 2008 WAF3_GEN_18 implement try catch block
    try {
        // If the document loaded in the parent window is the Page to submit, then refresh the page.
        //window.document.forms[parentFormName].action = window.location.href;
        try {
            if (window.parent.document.forms[parentFormName].action == '')
                window.parent.document.forms[parentFormName].action = submitToPage;
            window.parent.document.forms[parentFormName].submit();
        } catch (e) { }//Modified By Ninad WAF3_PB_64
        if (closeChildWindow == true) { CloseDivForModalPopUp(true); }
    }
    catch (e) { }
}

/*PREDEFINED FUNCTIONS USED FOR LANGUAGE SUPPORT FUNCTIONALITY */
function plugin_load() {
    var str;
    if ((str = iPlugin_BrowserTest()) == '0')
        alert("Unsupported OS or Browser");
    IPlugin1.Script = "Marathi";
    IPlugin1.KeyBoard = "Phonetic";
    IPlugin1.ScriptKey = "0";
    IPlugin1.Init();

}

function plugin_unload() {
    IPlugin1.Stop();
}

function iPlugin_BrowserTest() {
    var ClientPlatform = navigator.userAgent.toLowerCase();
    if ((ClientPlatform.indexOf("windows nt") > -1) || (ClientPlatform.indexOf("winnt") > -1) || (ClientPlatform.indexOf("windows 95") > -1) || (ClientPlatform.indexOf("win95") > -1) || (ClientPlatform.indexOf("windows 98") > -1) || (ClientPlatform.indexOf("win98") > -1)) {
        switch (navigator.appName) {
            case "Microsoft Internet Explorer":
                if ((ClientPlatform.indexOf("windows nt") > -1) || (ClientPlatform.indexOf("winnt") > -1)) {
                    return ("IEonNTClient");
                }
                else if ((ClientPlatform.indexOf("windows 95") > -1) || (ClientPlatform.indexOf("win95") > -1) || (ClientPlatform.indexOf("windows 98") > -1) || (ClientPlatform.indexOf("win98") > -1)) {
                    return ("IEon9xClient");
                }
                else {
                    alert("iPlugin is supported on Windows NT/9x only. You are using " + ClientPlatform);
                    return ('0');
                }
                break;

            case "Netscape":
                {
                    return ("NetscapeClient");
                }
                break;
            default:
                alert("iPlugin is supported only on Netscape and MSIE family of browsers. You are using " + navigator.appName);
                return ('0');
        }

    }
    else {
        alert("iPlugin is supported on Windows NT/9x only. You are using " + ClientPlatform);
        return ('0');
    }
}
function plugin_open() {
    IPlugin1.Enable();
}
function plugin_close() {
    IPlugin1.Disable();
}
//Added By Chakshuta H on 14th-Oct-2015 Purpose::QA issue fixing
function DisplayComments(strCommentCaption, blnIsDisabled, strActionType, strUniqueID, lngTagID, strPage, PrimaryKeyName, objhidQueryID) {
    var url;
    var objTblpopup;
    var mouseXY;
    var objDivpopup;
    var intIdeaID;
    var objComment;


    objDivpopup = document.getElementById("DivComments");

    loadComment(strCommentCaption, blnIsDisabled, strActionType, strUniqueID, objDivpopup, lngTagID, strPage, PrimaryKeyName, objhidQueryID);

    objDivpopup.style.width = '355px';
    objDivpopup.style.height = '145px';
    objDivpopup.style.left = 50;
    objDivpopup.style.top = 50;
    objDivpopup.style.position = 'absolute';
    objDivpopup.style.display = '';

    var objT = document.getElementById('txtComments');
    if (blnIsDisabled != "1")
        objT.select();
    objT.focus();

}
function loadComment(strCommentCaption, blnIsDisabled, StrActionType, strUniqueID, objDivpopup, lngTagID, strPage, PrimaryKeyName, objhidQueryID) {
    var strElement;
    var strComments = "";
    var objtxtComments = GetObjectReference('frmCommonPage', 'txtComments');
    var strTextStyle = "";

    if (blnIsDisabled == "0") {
        strTextStyle = "clsTextArea"
    }
    else {
        strTextStyle = "clsTextBoxReadOnly readonly"
    }

    if (objtxtComments == null)
        strComments = ""
    else
        strComments = objtxtComments.value;

    strElement = '<Table class=clsTable cellspacing=0 cellpadding=0 style="height=99.99%;"><TR class=clsTREven><td><b>';
    strElement += strCommentCaption + '</b></td><TR class=clsTREven><td>';
    strElement += '<Textarea wrap=Hard  name=txtComments id=txtComments maxlength=500 class=' + strTextStyle + ' style="width:350px; height:70px; text-align:Left"; rows=5; cols =20>' + strComments + '</Textarea>';
    strElement += '<br><img src="../../images/star.gif"></td></TR><TR class=clsTREven><td>';
    strElement += '<input type=button id= btnOK name= btnOK '

    if (blnIsDisabled == "1")
        strElement += ' disabled ';

    strElement += 'Value = "   OK   " style ="font size=9 width=10pts" onClick = getComment_Onclick("' + StrActionType + '",' + strUniqueID + ',' + lngTagID + ',"' + strPage + '","' + PrimaryKeyName + '",' + objhidQueryID + ')>';
    strElement += '<input type=button id= btnCancel name= btnCancel style ="font size=9" Value = CANCEL onClick = Cancel_OnClick()>';
    strElement += '</td></tr></table>'

    if (objDivpopup != null)
        objDivpopup.innerHTML = strElement;
}

//Added QueryID as last parameter by SuchitraP on 28-july-2008 for CRM Workflow
function getComment_Onclick(StrActionType, strUniqueID, lngTagID, strPage, PrimaryKeyName, objhidQueryID) {
    var strElement;
    var intCnt;
    var objDivComments = GetObjectReference("frmCommonPage", "DivComments");

    objPopupComments = GetObjectReference('frmCommonPage', 'txtComments');
    objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtComments_hidden');

    if (objPopupComments != null && (objPopupComments.value).length > 500) {
        alert("Comment should not be more than 500 characters.");
        objPopupComments.focus();
        return;
    }

    if (objPopupComments != null) {
        if (disallowBlank(objPopupComments, "Please enter comments !", true))
            return;
    }

    objDivComments.style.display = "none";

    if (objPopupComments_hidden != null && objPopupComments != null)
        objPopupComments_hidden.value = objPopupComments.value;

    //Addition by SuchitraP on 28-july-2008 for CRM Workflow QueryID is required	
    if (objhidQueryID != null) {
        objfrm.action = strPage + '&WorkflowAction=' + StrActionType + '&' + PrimaryKeyName + '_PK=' + strUniqueID + '&FromWhere=CRM&QueryID=' + objhidQueryID;
        objfrm.submit();
    }
    else {
        //End by SuchitraP
        objfrm.action = strPage + '&WorkflowAction=' + StrActionType + '&' + PrimaryKeyName + '_PK=' + strUniqueID;
        objfrm.submit();
    }
}
function Submit_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName, strMode) {

    if (lngTagID == 8035) {
        //added By purvaj on 24 Nov 2008 PMLifeLine
        // for approving or rejecting information section should be expanded.
        var objtxtProceduretitle = GetObjectReference('frmCommonpage', 'ProcedureTitle');
        if (objtxtProceduretitle == null) {
            alert('To Submit an Article, Article Information should be displayed.\nPlease open an Article Information region.');
            return;
        }
    }
    //End addition Purvaj


    var objDivNOI = GetObjectReference("frmCommonPage", "DivNOI");
    objDivNOI.style.width = '305px';
    //Commented and added by Nilesh g on 2/2/2016 for change height of div
    //objDivNOI.style.height  = '150px';
    objDivNOI.style.height = '165px';
    objDivNOI.style.left = 20;
    objDivNOI.style.top = 20;
    objDivNOI.style.position = 'absolute';
    objDivNOI.style.display = '';
}


function Approve_Onclick(lngTagID, lngUniqueID, strPage, strPrimaryKeyName, intIsAppConfigured, Requeststage) {
    var objtxtHidIDU = GetObjectReference('', 'txtHidIDU');

    //'--- Added By purvaj On 23 August 2010 Alert added on click of approve, for resuming the timesheet
    var objtxtResumeTimesheet = GetObjectReference('', 'txtResumeTimesheet_hidden');
    if (objtxtResumeTimesheet != null && objtxtResumeTimesheet.value == 'True') {
        if (!confirm('The Resource timesheet entry is blocked currently.\nCurrent stage approvers have access to resume the timesheet.\nTo resume the timesheet, Click "RESUME TIMESHEET" link before approving.\nIf you want to continue without resuming timesheet click OK else click CANCEL.'))
            return;
    }
    //'--- End addition purvaj    

    //Addition by SuchitraP on 28-july-2008 for CRM Workflow QueryID is required
    if (GetObjectReference('frmCommonpage', 'QueryID')) { var objhidQueryID = GetObjectReference('frmCommonpage', 'QueryID').value; }
    //End by SuchitraP

	/*if(intIsAppConfigured == 0)
	{
		alert("Approvers are not configured for '"+Requeststage+"' stage. Please set the Approvers.");
		return;
	}*/
    if (objtxtHidIDU != null) {
        if (String(objtxtHidIDU.value) == "0") {
            alert("Please upload documents according to the document category mapped to the current stage !");
            return;
        }
    }
    if (lngTagID == 8035) {
        //added By purvaj on 24 Nov 2008 PMLifeLine
        // for approving or rejecting information section should be expanded.
        var objtxtProceduretitle = GetObjectReference('frmCommonpage', 'ProcedureTitle');
        if (objtxtProceduretitle == null) {
            alert('To Approve or Reject an Article, Article Information should be displayed.\nPlease open an Article Information region.');
            return;
        }
    }
    //End addition Purvaj

    //Added by SuchitraP on 28-july-2008 for CRM Workflow:Passed QueryID as last parameter
    if (GetObjectReference('frmCommonpage', 'QueryID')) {
        DisplayComments('Approval Comments', 0, 'SYS_APPROVE', lngUniqueID, lngTagID, strPage, strPrimaryKeyName, objhidQueryID);
    }
    else {
        objhidQuery = null;
        DisplayComments('Approval Comments', 0, 'SYS_APPROVE', lngUniqueID, lngTagID, strPage, strPrimaryKeyName, objhidQuery);
    }
    //End by SuchitraP

}
function Reject_Onclick(lngTagID, lngUniqueID, strPage, strPrimaryKeyName, intIsAppConfigured, Requeststage) {
    //Addition by SuchitraP on 28-july-2008 for CRM Workflow QueryID is required
    if (GetObjectReference('frmCommonpage', 'QueryID')) { var objhidQueryID = GetObjectReference('frmCommonpage', 'QueryID').value; }
    //End by SuchitraP

	/*if(intIsAppConfigured == 0)
	{
		alert("Approvers are not configured for '"+Requeststage+"' stage. Please set the Approvers.");
		return;
	}*/

    if (lngTagID == 8035) {
        //added By purvaj on 24 Nov 2008 PMLifeLine
        // for approving or rejecting information section should be expanded.
        var objtxtProceduretitle = GetObjectReference('frmCommonpage', 'ProcedureTitle');
        if (objtxtProceduretitle == null) {
            alert('To Approve or Reject an Article, Article Information should be displayed.\nPlease open an Article Information region.');
            return;
        }
    }
    //End addition Purvaj


    //Added by SuchitraP on 28-july-2008 for CRM Workflow:Passed QueryID as last parameter
    if (GetObjectReference('frmCommonpage', 'QueryID')) {
        DisplayComments('Rejection Comments', 0, 'SYS_REJECT', lngUniqueID, lngTagID, strPage, strPrimaryKeyName, objhidQueryID);
    }
    else {
        objhidQuery = null;
        DisplayComments('Rejection Comments', 0, 'SYS_REJECT', lngUniqueID, lngTagID, strPage, strPrimaryKeyName, objhidQuery);
    }
    //End by SuchitraP
}
function SubmitOK_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName, strMode) {
    var objcboNOI = GetObjectReference("frmCommonPage", "cboNOI");
    //var objcboApprovers= GetObjectReference("frmCommonPage","cboNOIApprovers");
    var objtxtNOIID = GetObjectReference("frmCommonPage", "txthidden_NOIID");
    var objPopupComments = GetObjectReference('frmCommonPage', 'txtSubmitComments');
    var objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtComments_hidden');
    var i;
    var objDivNOI = GetObjectReference("frmCommonPage", "DivNOI");
    var objfrm = GetFormReference("frmCommonPage");


	/*for(i=0;i<objcboApprovers.length;i++)
	{
		if(objcboApprovers[i].value == objcboNOI.value && objcboApprovers[i].text == 0)
		{
			alert("Approvers are not configured for stage. Please set the Approvers.");
			objDivNOI.style.display  = 'none';
			return;
		}
	}*/

    if (objcboNOI != null) {
        if (disallowBlank(objcboNOI, "Workflow should not be blank !", true))
            return;
    }

    if (objPopupComments != null) {
        if (disallowBlank(objPopupComments, "Please enter comments !", true))
            return;
    }

    objtxtNOIID.value = objcboNOI.value;

    if (objPopupComments_hidden != null && objPopupComments != null)
        objPopupComments_hidden.value = objPopupComments.value;


    objfrm.action = strPage + '&WorkflowAction=SYS_SUBMIT&' + strPrimaryKeyName + '_PK=' + lngPrimaryKey;
    objfrm.submit();
}

function HoldOK_Onclick(lngTagID, lngPrimaryKey) {
    var objDivHold = GetObjectReference("frmCommonPage", "DivHold");
    var objfrm = GetFormReference("frmCommonPage");
    var objPopupComments = GetObjectReference('frmCommonPage', 'txtHoldComments');
    var objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtHoldComments_hidden');

    if (objPopupComments != null) {
        if (disallowBlank(objPopupComments, "Please enter comments !", true))
            return;
    }

    objDivHold.style.display = 'none';

    if (objPopupComments_hidden != null && objPopupComments != null)
        objPopupComments_hidden.value = objPopupComments.value;

    objfrm.action = '../General/CommonPage.aspx?MasterTagID=32&WorkflowAction=PUTONHOLD';
    objfrm.submit();

}


function BlockDAOK_Onclick(lngTagID, lngPrimaryKey) {
    var objDivBlockDA = GetObjectReference("frmCommonPage", "DivBlockDA");
    var objfrm = GetFormReference("frmCommonPage");
    var objPopupComments = GetObjectReference('frmCommonPage', 'txtBlockDAComments');
    var objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtBlockDAComments_hidden');

    if (objPopupComments != null) {
        if (disallowBlank(objPopupComments, "Please enter comments !", true))
            return;
    }

    objDivBlockDA.style.display = 'none';

    if (objPopupComments_hidden != null && objPopupComments != null)
        objPopupComments_hidden.value = objPopupComments.value;

    objfrm.action = '../General/CommonPage.aspx?MasterTagID=32&WorkflowAction=BLOCKDA';
    objfrm.submit();
}


function JumpToStageOK_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName) {
    var objPopupComments = GetObjectReference('frmCommonPage', 'txtJumpToStage');
    var objNewStageID = GetObjectReference('frmCommonPage', 'cboJumpToStage');
    var objNewStageID_hidden = GetObjectReference('frmCommonPage', 'txtNewStageID_hidden');
    var objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtComments_hidden');

    if (objPopupComments_hidden != null && objPopupComments != null)
        objPopupComments_hidden.value = objPopupComments.value;


    objNewStageID_hidden.value = objNewStageID.value;

    objfrm.action = strPage + '&WorkflowAction=JUMPTOSTAGE&' + strPrimaryKeyName + '_PK=' + lngPrimaryKey;
    objfrm.submit();
}

function ForcePushOK_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName) {
    var objPopupComments_hidden = GetObjectReference('frmCommonPage', 'txtComments_hidden');
    var objPopupComments = GetObjectReference('frmCommonPage', 'txtForcePushComments');
    //var objPopupComments_hidden = GetObjectReference('frmCommonPage','txtForcePushComments_hidden');

    if (objPopupComments_hidden != null && objPopupComments != null) {
        //objPopupComments_hidden.value = objPopupComments.value;
        objPopupComments_hidden.value = objPopupComments.value;
    }

    objfrm.action = strPage + '&WorkflowAction=FORCEPUSH&' + strPrimaryKeyName + '_PK=' + lngPrimaryKey;
    objfrm.submit();
}

function JumpTo_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName, strMode) {
    var objDivJumpToStage = GetObjectReference("frmCommonPage", "DivJumpToStage");
    objDivJumpToStage.style.width = '305px';
    objDivJumpToStage.style.height = '150px';
    objDivJumpToStage.style.left = 20;
    objDivJumpToStage.style.top = 20;
    objDivJumpToStage.style.position = 'absolute';
    objDivJumpToStage.style.display = '';
}


function ChangeWorkflow_Onclick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName, strMode) {
    window.open("../DM/DM_ChangeNOI.aspx?TagID=" + lngTagID + "&UniqueID=" + lngPrimaryKey, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=850,height=550");
}

function ForcePush_OnClick(lngTagID, lngPrimaryKey, strPage, strPrimaryKeyName) {
    var objDivForcePush = GetObjectReference("frmCommonPage", "DivForcePush");
    objDivForcePush.style.width = '355px';
    objDivForcePush.style.height = '150px';
    objDivForcePush.style.left = 20;
    objDivForcePush.style.top = 20;
    objDivForcePush.style.position = 'absolute';
    objDivForcePush.style.display = '';
}

function showdetails(WFInstanceID, TagID, UniqueID) {
    window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + WFInstanceID + "&TagID=" + TagID + "&UniqueID=" + UniqueID, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
}


function Cancel_OnClick() {
    var objDivJumpToStage = GetObjectReference("frmCommonPage", "DivJumpToStage");
    var objDivForcePush = GetObjectReference("frmCommonPage", "DivForcePush");
    var objDivHold = GetObjectReference("frmCommonPage", "DivHold");
    var objDivBlockDA = GetObjectReference("frmCommonPage", "DivBlockDA");
    var objDivNOI = GetObjectReference("frmCommonPage", "DivNOI");
    var objDivComments = GetObjectReference("frmCommonPage", "DivComments");

    if (objDivComments != null)
        objDivComments.style.display = "none";
    if (objDivNOI != null)
        objDivNOI.style.display = "none";
    if (objDivBlockDA != null)
        objDivBlockDA.style.display = 'none';
    if (objDivHold != null)
        objDivHold.style.display = 'none';
    if (objDivJumpToStage != null)
        objDivJumpToStage.style.display = "none";
    if (objDivForcePush != null)
        objDivForcePush.style.display = "none";


}
//End Of Addition

/* END PREDEFINED FUNCTIONS USED FOR LANGUAGE SUPPORT FUNCTIONALITY */
//Added By Bharat T on 13th-Oct-2015
function showdetails(WFInstanceID, TagID, UniqueID) {
    window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + WFInstanceID + "&TagID=" + TagID + "&UniqueID=" + UniqueID, "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
}
function ValidateFileExtensions(FormName, ControlName, strFileExtension, intMinFileSize) {
    var objControlName;
    var flag;

    objControlName = GetObjectReference(FormName, ControlName);
    var validateExtensions;

    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
    var countOfDot, FileNameCharCount;
    var intActualFileSize = (objControlName.files['0'].size);
    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement

    validateExtensions = strFileExtension.split(",");
    if (strFileExtension.length > 0) {
        var allowSubmit = false;
        var file = objControlName.value;
        var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

        for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
            var strExtn;
            strExtn = validateExtensions[cnt];
            if (strExtn.toLowerCase() == extension) { allowSubmit = true; }
        }
        if (allowSubmit == false) {
            alert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are allowed!!!");
            return false;
        }
    }

    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
    if (objControlName.files['0'].name != '')
        var countOfDot = objControlName.files['0'].name.split(".").length - 1;

    if (countOfDot > 1) {
        alert('File with two or more extensions is not allowed!');
        return false;
    }

    if (objControlName.files['0'].name != '')
        FileNameCharCount = objControlName.files['0'].name.split(".")[0].length;

    if (FileNameCharCount > 120) {
        alert('File name should not exceed 120 characters!');
        return false;
    }

    if (intActualFileSize < intMinFileSize) {
        alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
        return false;
    }
    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement

}
//Ended By Bharat T on 13th-Oct-2015

function AttachPluginHandlerToMultiInsertControl()
/*
Function Name   :   AttachPluginHandlerToMultiInsertControl
Input Parameters:   none - but there will be parameters passed which will be used via arguments
Desc            :   Will be used exclusively for multi insert subtag
                    in case where a new row is added to the subtag.
                    This function will be plotted & called after the AddNewRow_MultiInsertGrid function
Author          :   NikhilM
Created         :   16 Nov 2010
ReqID           :   Integration of Language support
*/ {
    if (arguments.length > 0) {
        var iCtrlCnt = 0;
        var iCnt = 0;

        for (iCtrlCnt = 0; iCtrlCnt < arguments.length; iCtrlCnt++) {
            var sCtrlDef = new String();
            var sCtrlName = '';
            var arrCtrlDef;
            var objCtrlArray;
            var objCtrl;

            sCtrlDef = arguments[iCtrlCnt];
            arrCtrlDef = sCtrlDef.split("%$#@");

            if (arrCtrlDef != null) {
                if (arrCtrlDef[0] != null) {
                    sCtrlName = arrCtrlDef[0];
                    if (sCtrlName != '') {
                        objCtrlArray = document.getElementsByName(sCtrlName);

                        if (objCtrlArray != null) {
                            for (iCnt = 0; iCnt < objCtrlArray.length; iCnt++) {
                                objCtrl = objCtrlArray[iCnt];
                                objCtrl.onblur = function () {
                                    plugin_close();
                                    if (arrCtrlDef[1] != 'none')
                                        eval(arrCtrlDef[1]);
                                }

                                objCtrl.onfocus = function () {
                                    plugin_open();
                                    if (arrCtrlDef[2] != 'none')
                                        eval(arrCtrlDef[2]);
                                }
                            }
                        }
                    }
                }
            }

        }
    }
}

//Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax
var AjaxResult;
function AJAXCallWithResult(url, data, async) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        contentType: "application/json",
        //timeout: 180000,
        async: async,
        success: function (result) {
            AjaxResult = result;
            $(".loadingoverlay", parent.document).css("display", "none");
            //Stop();
        },
        error: function (xhr, status, error) {
            //Stop();
            //StopAjaxLoader("body");
            $(".loadingoverlay", parent.document).css("display", "none");
            console.log(xhr.responseText);
            //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

    return AjaxResult;
}
//Endo f Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax

//Added By Dipali V on 2nd Jan 2018 For NSEIT Issue Fixing
//Added By Chakshuta H on 23rd-Nov-2017 Purpose::Qa issue fixing
//Added By Bharat T on 24th-Aug-2017 for Microlink issue fixing
function getParent(obj, strPagePath, parentFormName, QueryString) {

    var strSearchString = strPagePath.split("/")[strPagePath.split("/").length - 1];

    if (obj.opener != null) {
        if (String(obj.opener.location.href).indexOf(strSearchString) == -1) {
            getParent(obj.opener, strSearchString, parentFormName, QueryString);
        }

        if (QueryString != '') {
            obj.opener.document.forms[parentFormName].action = '../' + strPagePath + "?SetFilter=1&" + QueryString;
        }
        else {
            obj.opener.document.forms[parentFormName].action = '../' + strPagePath + "?SetFilter=1";
        }

        obj.opener.document.forms[parentFormName].submit();

        //obj.opener.location.href = '../' + strPagePath + "?SetFilter=1";
        return;
    }

    if (QueryString != '') {
        obj.opener.document.forms[parentFormName].action = '../' + strPagePath + "?SetFilter=1&" + QueryString;
    }
    else {
        obj.opener.document.forms[parentFormName].action = '../' + strPagePath + "?SetFilter=1";
    }
    obj.opener.document.forms[parentFormName].submit();
}
//End of Added By Bharat T on 24th-Aug-2017 for Microlink issue fixing
//End On Added By Chakshuta H on 23rd-Nov-2017 Purpose::Qa issue fixing
//End of Added By Dipali V on 2nd Jan 2018 For NSEIT Issue Fixing




async function validateDocFileForExe(file) {
    const allowedExtensions = ['.doc', '.docx', '.ppt', '.pptx', '.xls', '.xlsx'];
    const fileName = file.name.toLowerCase();
    const fileExtension = fileName.slice(fileName.lastIndexOf('.'));

    if (!allowedExtensions.includes(fileExtension)) {
        throw "Invalid file type. Only Office documents are allowed.";
    }

    const reader = new FileReader();

    return new Promise((resolve, reject) => {
        reader.onload = async function (e) {
            const arrayBuffer = e.target.result;

            if (fileExtension.endsWith('x')) {
                try {
                    const JSZip = window.JSZip;
                    const zip = await JSZip.loadAsync(arrayBuffer);

                    for (const relativePath in zip.files) {
                        const fileEntry = zip.files[relativePath];
                       // console.log(`Inspecting file: ${fileEntry.name}, Directory: ${fileEntry.dir}`);

                        if (!fileEntry.dir) {
                            const entryName = fileEntry.name.toLowerCase();

                            if (entryName.includes('embeddings') || entryName.endsWith('.bin')) {
                               // console.log(`Inspecting embedded object: ${entryName}`);
                                const content = await fileEntry.async('uint8array');

                                // Check for PE headers or EXE-like patterns
                                if (containsPEHeader(content)) {
                                    reject(`Upload restricted: Executable content detected in "${entryName}".`);
                                    return;
                                }

                                // Check for EXE string patterns
                                if (containsExeString(content)) {
                                    reject(`Upload restricted: Executable string detected in "${entryName}".`);
                                    return;
                                }

                                // Detect high-entropy regions (possible obfuscated content)
                                if (isHighEntropy(content)) {
                                    reject(`Upload restricted: Suspicious high-entropy content detected in "${entryName}".`);
                                    return;
                                }

                                // Size check for large embedded binaries
                                if (content.length > 1_000_000) { // Assuming 1 MB threshold
                                    reject(`Upload restricted: Large embedded file detected (${content.length} bytes) in "${entryName}".`);
                                    return;
                                }

                               // console.log(`No issues detected in "${entryName}".`);
                            }
                        }
                    }
                    resolve();
                } catch (error) {
                    console.error("Error parsing ZIP archive:", error);
                    reject("Error inspecting the ZIP archive. Ensure the file format is correct.");
                }
            } else {
                const uint8 = new Uint8Array(arrayBuffer);
                if (containsPEHeader(uint8)) {
                    reject("Upload restricted: Executable content detected.");
                    return;
                }
                resolve();
            }
        };

        reader.onerror = () => reject("Error reading the file. Please try again.");
        reader.readAsArrayBuffer(file);
    });
}

function containsPEHeader(buffer) {
    for (let i = 0; i < buffer.length - 64; i++) {
        if (buffer[i] === 0x4D && buffer[i + 1] === 0x5A) { // MZ signature
            const peOffset = buffer[i + 0x3C] | (buffer[i + 0x3D] << 8);
            if (
                peOffset + 4 <= buffer.length &&
                buffer[peOffset] === 0x50 &&
                buffer[peOffset + 1] === 0x45 &&
                buffer[peOffset + 2] === 0x00 &&
                buffer[peOffset + 3] === 0x00
            ) {
               // console.log("PE header detected at offset:", peOffset);
                return true; // PE header detected
            }
        }
    }
    return false;
}

function containsExeString(buffer) {
    const exePattern = [0x2E, 0x65, 0x78, 0x65]; // ".exe" in ASCII
    for (let i = 0; i < buffer.length - exePattern.length + 1; i++) {
        let found = true;
        for (let j = 0; j < exePattern.length; j++) {
            if (buffer[i + j] !== exePattern[j]) {
                found = false;
                break;
            }
        }
        if (found) {
           /* console.log("Executable string (.exe) detected.");*/
            return true;
        }
    }
    return false;
}

function isHighEntropy(buffer, threshold = 7.5) {
    const frequency = new Array(256).fill(0);
    for (let i = 0; i < buffer.length; i++) {
        frequency[buffer[i]]++;
    }
    const totalBytes = buffer.length;
    const entropy = frequency.reduce((sum, count) => {
        if (count === 0) return sum;
        const p = count / totalBytes;
        return sum - p * Math.log2(p);
    }, 0);

  /*  console.log(`Calculated entropy: ${entropy}`);*/
    return entropy > threshold;
}
