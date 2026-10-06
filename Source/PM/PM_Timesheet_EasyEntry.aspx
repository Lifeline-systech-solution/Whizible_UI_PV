<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Timesheet_EasyEntry.aspx.vb" Inherits="PbNIT.PM_Timesheet_EasyEntry"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	
		<%CommonFunctions.General.PlotPageHeadTag("TimeSheet")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

      /*Added by Yogesh J on 05/12/2015*/
    pre {
        width:500px;
    }
    /*End of addition by Yogesh J on 05/12/2015*/

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmTimeSheetEasyEntry" method="post">
			
			<% WritePage()%>
			
		</form>
		<script> 
var xmlhttp;
var objfrm;
var noChkDel_ON = 0;
var isEdit_anyCtrl = false;
var arrCtrlIDs = new Array();
var objDivListTag = GetObjectReference('objfrmTimeSheet','DivListTag');
var objdivListPageTag=GetObjectReference('objfrmTimeSheet','divListPageTag');
objfrm = GetFormReference('frmTimeSheetEasyEntry');

            <%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>

function window_onresize(){
            var intDivHeight;
            //Added by Yogesh J on 03-Dec-2015

            //added by Nilesh g on 15/12/2015 for alignment
            if (objDivListTag != null) {
                if (isIE() == 'FF') {
                    intDivHeight = window.innerHeight - objDivListTag.offsetTop;
                }
                else {
                    intDivHeight = window.innerHeight - objDivListTag.offsetTop - 58;
                }
                if (intDivHeight < 100) intDivHeight = 100;

                if (objdivListPageTag != null)
                    objdivListPageTag.style.height = intDivHeight + "px";
                objDivListTag.style.height = intDivHeight + "px";

            }
            //end of added by Nilesh g on 15/12/2015 for alignment
            //End of addition by Yogesh J on 04-Dec-2015
        }
        function window_onload() {
            //added by Nilesh g on 15/12/2015 for alignment

            var intDivHeight;
            //Added by Yogesh J on 03-Dec-2015
            if (objDivListTag != null) {
                if (isIE() == 'FF') {
                    intDivHeight = window.innerHeight - objDivListTag.offsetTop;
                }
                else {
                    intDivHeight = window.innerHeight - objDivListTag.offsetTop - 58;
                }
                if (intDivHeight < 100) intDivHeight = 100;
                if (objdivListPageTag != null)
                    objdivListPageTag.style.height = intDivHeight + "px";
                objDivListTag.style.height = intDivHeight + "px";

            }
            //End of addition by Yogesh J on 04-Dec-2015
        }

        //filter related functions
        function showHide_div() {
            var objDIV = GetObjectReference('frmTimeSheetEasyEntry', 'FliterShow');
            var objimg = GetObjectReference('frmTimeSheetEasyEntry', 'imgShowHide');
            var objDivStatus = GetObjectReference('frmTimeSheetEasyEntry', 'hidFilterDivStatus');

            if (objDivStatus.value == 'Open') {

                objDIV.style.display = 'none';
                objimg.src = '../../Images/plus.gif';
                objDivStatus.value = "Close";
                return;
            }
            else {
                objDIV.style.display = '';
                objimg.src = '../../Images/minus.gif';

                objDivStatus.value = "Open";
                return;
            }
        }

        function clearFilter()
{

var objFromDate = GetObjectReference('frmTimeSheetEasyEntry','txtFromDate');
var objToDate = GetObjectReference('frmTimeSheetEasyEntry','txtToDate');
var objRole = GetObjectReference('frmTimeSheetEasyEntry','cboRole');
var objEmployee = GetObjectReference('frmTimeSheetEasyEntry','cboResource');

if (isBlank(objFromDate.value) && isBlank(objToDate.value) && isBlank(objRole.value) && isBlank(objEmployee.value )) 
return;

objFromDate.value="";
objToDate.value="";
objRole.value ="";
objEmployee.value ="";

<% if IsXMLHTTP_Off = true %>
	if (isEdit_anyCtrl == true )
		if ( confirm("Do you want to save changes?") )
			objfrm.action="../PM/PM_Timesheet_EasyEntry.aspx?Action=Save&TimeSheetID=<%=strTimeSheetID%>";
		else
			objfrm.action="../PM/PM_Timesheet_EasyEntry.aspx?Action=Save&TimeSheetID=<%=strTimeSheetID%>";
	else
		objfrm.action = "../PM/PM_Timesheet_EasyEntry.aspx?TimeSheetID=<%=strTimeSheetID%>";		
		
<% else %>
	objfrm.action = "../PM/PM_Timesheet_EasyEntry.aspx?TimeSheetID=<%=strTimeSheetID%>";		
<% end if %>
objfrm.submit();

}

function filterChange()
{
<% if IsXMLHTTP_Off = true %>

	if (isEdit_anyCtrl == true )
	if ( confirm("Do you want to save changes?") )
		objfrm.action="../PM/PM_Timesheet_EasyEntry.aspx?Action=Save&TimeSheetID=<%=strTimeSheetID%>";
	else
	objfrm.action="../PM/PM_Timesheet_EasyEntry.aspx?TimeSheetID=<%=strTimeSheetID%>";
<% end if %>	
// Added by PrajaktaR on 16th June 2006 for Bristlecone 
	var objtxtFromDate = GetObjectReference('frmTimeSheetEasyEntry','txtFromDate');
	var objtxtToDate = GetObjectReference('frmTimeSheetEasyEntry','txtToDate');
	
	if(disallowDate1LessThanDate2(objtxtToDate, objtxtFromDate, "'From Date' should not be greater than 'To Date'.", true))
			return;	
	else	
// END Of Addition by PrajaktaR on 16th June 2006 for Bristlecone 
	objfrm.submit();
}
//end of filter related functions

//xmlHttp functions
        function loadXMLDoc(url, reqQuery) {
            // code for Mozilla, etc.

            if (window.XMLHttpRequest) {

                xmlhttp = new XMLHttpRequest()
                xmlhttp.onreadystatechange = state_Change;
                if (ns) {
                    xmlhttp.open("GET", url + "&" + reqQuery, true)
                    xmlhttp.send(false)
                }
                else {
                    xmlhttp.open("POST", url, true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
                }


            }
            // code for IE
            else if (window.ActiveXObject) {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
                if (xmlhttp) {
                    xmlhttp.onreadystatechange = state_Change
                    xmlhttp.open("POST", url, true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
                }
            }

        }

        function state_Change() {
            // if xmlhttp shows "loaded"
            if (xmlhttp.readyState == 4) {
                // if "OK"
                if (xmlhttp.status == 200) {
                    //  alert("Data is saved")
                }
                else {
                    alert("Problem in saving data:" + xmlhttp.statusText)
                }
            }
        }



        function SendXMLHTTP_Save(id) {

            if (id == null)
                objCtrl = event.srcElement;
            else
                objCtrl = GetObjectReference('frmTimeSheetEasyEntry', id)

            if (objCtrl == null) {
                alert("Check browser compatibilty");
                return;
            }

            var value = objCtrl.value;

            if (objCtrl.type == "checkbox") {

                if (objCtrl.checked == true)
                    value = "1"
                else
                    value = "0"
            }

            if (validate_controlValue(id) == false) {
                return;
            }

            var url = "../PM/PM_Timesheet_EasyEntry.aspx?FromXML=1";

            loadXMLDoc(url, "ctrlID=" + id + "&Value=" + value);

        }

        //end of xmlHttp functions

        //Runtime plotting controls functions
        function PlotControls(args) {
            //debugger;

            arrCtrlIDs.push(args);

            var objImg = GetObjectReference('frmTimeSheetEasyEntry', 'folderimg' + args);
            objImg.src = "../../images/TreeNodeImages/folderopen.gif";


            appendControl("Des" + args, "textArea", "Des");
            appendControl("Act" + args, "text", "Act");
            appendControl("Wsr" + args, "checkbox", "Wsr");
            appendControl("Del" + args, "checkbox", "Del");




        }

        function appendControl(args, ctrlType, shortCtrlName) {

            var lblValue;
            var lblCtrl;
            var objTD = GetObjectReference('frmTimeSheetEasyEntry', "TD" + args)

            if (objTD) {

                objTD.align = "center";
                if (GetObjectReference('frmTimeSheetEasyEntry', "ctr" + args) == null) {
                    lblCtrl = GetObjectReference('frmTimeSheetEasyEntry', "lbl" + args);
                    lblValue = "";
                    if (lblCtrl) {
                        //Added By JyotiG
                        //Start_JG_11229_23-Mar-2007
                        //Issue : Project -&gt; Project Timesheet -&gt; Open a PT in edit mode. Click on the link 
                        //'Easy Edit'. The column 'Description' is a text area. Enter a description with 
                        //Enter / newline Values. AFter saving it, data does not get saved with newline 
                        //values.
                        //lblValue = lblCtrl.innerHTML;
                        if (navigator.appName == 'Microsoft Internet Explorer') {	 //Commented and added by Yogesh J on 03-Dec-2015
                            // lblValue = lblCtrl.innerText;	
                            lblValue = lblCtrl.textContent;
                            //End of addition by Yogesh J on  on 03-Dec-2015
                        }
                        else {
                            //Commented and added by Yogesh J on 03-Dec-2015
                            //lblValue = lblCtrl.innerHTML;
                            lblValue = lblCtrl.textContent;
                            //End of addition by Yogesh J on  on 03-Dec-2015
                        }
                    }//End_JG_11229_23-Mar-2007
                    var control;
                    var objControl;

                    if (ctrlType == "text") {
                        control = document.createElement("INPUT");
                        control.type = ctrlType;
                        control.id = "ctr" + args;
                        control.name = "ctr" + args;

                        if (isBlank(lblValue.substring(lblValue.lastIndexOf(" "))))
                            lblValue = lblValue.substring(0, lblValue.lastIndexOf(" "))

                        control.value = lblValue;

                    }
                    if (ctrlType == "checkbox") {
                        control = document.createElement("INPUT");
                        control.type = ctrlType;
                        control.id = "ctr" + args;
                        control.name = "ctr" + args;
                        if (lblValue.search("Yes") == 0)
                            lblValue = 1;
                        else
                            lblValue = 0;
                        control.value = lblValue;
                    }
                    if (ctrlType == "textArea") {
                        control = document.createElement("TEXTAREA")
                        control.id = "ctr" + args;
                        control.name = "ctr" + args;
                        control.value = lblValue;
                        //control.wrap="hard";
                    }


                    if (document.getElementById("lbl" + args))
                        objTD.removeChild(document.getElementById("lbl" + args));

                    objTD.appendChild(control);

                    objControl = document.getElementById(control.id);

                    if (shortCtrlName == "Des") {
                        objControl.onchange = function () {
										<%=strJavafun_Description%>(this.id);
                }

                objControl.className = "clsTextArea";
                objControl.style.textAlign = "left";
                objControl.cols = 65;
                objControl.rows = 3;


                //objControl.style.width="400px";
                var control2;
                control2 = document.createElement("A");
                control2.href = "JavaScript:preopentextdialog('frmTimeSheetEasyEntry','ctr" + args + "','Description','False')"
                control2.innerHTML = "<img Border=0 valign=Top src='../../Images/zoomin.gif' alt=''></img>"
                objTD.appendChild(control2);


                //<A Href="JavaScript:opentextdialog(&quot;frmCommonPage&quot;,&quot;Description&quot;,&quot;Description&quot;,&quot;False&quot;)" ><img Border=0 valign=Top src='../../Images/zoomin.gif' alt=''></img></a> 

            }
            if (shortCtrlName == "Act") {
                objControl.onchange = function () {
										<%=strJavafun_Act%>(this.id);
                }
                control.className = "clsTextbox";
                objControl.style.textAlign = "right";
                objControl.style.width = 30;
            }
            if (shortCtrlName == "Wsr") {
                objControl.onchange = function () {
										<%=strJavafun_Wsr%>(this.id);
                }

                objControl.className = "clsCheckBox";
                if (lblValue == 1)
                    objControl.checked = true;

            }
            if (shortCtrlName == "Del") {
                objControl.onchange = function () {
										<%=strJavafun_Delete%>(this.id);
                        }
                        objControl.className = "clsCheckBox";

                    }


                }

            }

        }

        function editAll_onClick(args) {
            var TimeSheetIDs = new String(GetObjectReference('frmTimeSheetEasyEntry', 'hidTimesheetIDs' + args).value).split(",");
            var count = 0;
            while (count < TimeSheetIDs.length) {
                var objImg = GetObjectReference('frmTimeSheetEasyEntry', 'folderimg' + TimeSheetIDs[count]);
                if (objImg != null)
                    objImg.src = "../../images/TreeNodeImages/folderopen.gif";

                appendControl("Des" + TimeSheetIDs[count], "textArea", "Des");
                appendControl("Act" + TimeSheetIDs[count], "text", "Act");
                appendControl("Wsr" + TimeSheetIDs[count], "checkbox", "Wsr");
                appendControl("Del" + TimeSheetIDs[count], "checkbox", "Del");

                count++;
            }
        }

        function preopentextdialog(frmName,txtObject,title,IsDisable,path)
{
var	objText=GetObjectReference(frmName,txtObject);
var strAddress;
		strAddress = objText.value; 
		opentextdialog(frmName,txtObject,title,IsDisable,path);
		if (strAddress != objText.value)
		{
		
		<% if IsXMLHTTP_Off= false %>
			SendXMLHTTP_Save(objText.id);
		<%else%>
		Description_onChange(objText.id);
		<%end if%>
		}
		
}

        //end of Runtime plotting controls functions



        //General functions. Save and Delete click and Delete onChange 


        function Save_OnClick() {

<% if IsXMLHTTP_Off = true then %>
            var count = 0;

            while (count < arrCtrlIDs.length) {
                if (validate_controlValue('ctrAct' + arrCtrlIDs.pop()) == false)
                    return;
                count++;
            }
            objfrm.action = "../PM/PM_Timesheet_EasyEntry.aspx?Action=Save&TimeSheetID=<%=strTimeSheetID%>";

<% else %>
            var validationFlag = true;
            //Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            $('*[id*=ctrAct]').each(function () {

                var curId = $(this).attr("id")
                if (WorkHoursValidation(curId) == false) {
                    validationFlag = false;
                }
            });
            if (validationFlag == false) {
                return false;
            }
            //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            //Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            //objfrm.action = "../PM/PM_Timesheet_EasyEntry.aspx?TimeSheetID=<%=strTimeSheetID%>";
            objfrm.action = "../PM/PM_Timesheet_EasyEntry.aspx?Action=Save&TimeSheetID=<%=strTimeSheetID%>";
            //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
<% end if %>
            objfrm.submit();
            //Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
            window.onunload = refreshParent;
            function refreshParent() {
                //Commented & added by dipali v on 20th Dec 2021 For Refresh Parent
                //Commented And Added By Usha Pandit On 16.02.2021 For duplicate timesheet save issue
                window.opener.location.reload();

              <%--  var newpath = opener.window.location.href;
                newpath = newpath.toString().replace("Mode=StillGenerate", "Mode=Show&TimeSheetNo=<%=strTimeSheetID%>&PKToken=<%=m_strToken_PMTimesheet%>");
                opener.window.location.replace(newpath);--%>
                //End Of Added By Usha Pandit On 16.02.2021 For duplicate timesheet save issue
               //End of Commented & added by dipali v on 20th Dec 2021 For Refresh Parent
            }
            //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
        }
        function Delete_OnClick() {
            if (parseInt(noChkDel_ON) == 0) {
                alert('Please select task(s) to delete');
                return;
            }
            else {
                if (confirm("Are you sure you want to delete the selected task(s)?")) {
                    objfrm.action ="../PM/PM_Timesheet_EasyEntry.aspx?Action=Delete&TimeSheetID=<%=strTimeSheetID%>";
                    objfrm.submit();
                }
            }

        }

        //Modified by MrugajaB on Date 3rd July 2006 for WhizibleSEM Issue ID.4168
        function Delete_onChange(srcID) {

            var id = srcID;
            /*var id = event.srcElement.id ;
        	
            var id = id.substr(6,id.length);*/
            //var e = window.event.srcElement;

            var objDel = GetObjectReference('frmTimeSheetEasyEntry', id);
            var id = id.substr(6, id.length);
            var objhidDel = GetObjectReference('frmTimeSheetEasyEntry', 'hidDel' + id);
            //End Modification

            if (objhidDel) {

                if (objDel.checked == true) {
                    objhidDel.value = "1"
                    noChkDel_ON = noChkDel_ON + 1;
                }

                else {
                    objhidDel.value = "0"
                    noChkDel_ON = noChkDel_ON - 1;
                }

            }

        }


        function Close_OnClick()
{
	// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
	// window.opener.location.href="../PM/PM_Timesheet.aspx?TimeSheetNo=<%=strTimeSheetID%>&MasterTagID=1049&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1"
	window.opener.location.href="../PM/PM_Timesheet.aspx?TimeSheetNo=<%=strTimeSheetID%>&MasterTagID=1049&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&PKToken=<%=m_strToken_PMTimesheet%>" 
	// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
	window.close();

}
//end of General functions.

        //Normal behavious (not xmlhttp functions)
        function Description_onChange(id) {
            isEdit_anyCtrl = true;
        }

        function ActualWork_onChange() {
            isEdit_anyCtrl = true;

            validate_controlValue(event.srcElement.id);
        }
        function WSR_onChange() {
            isEdit_anyCtrl = true;

            var objWsr = GetObjectReference('frmTimeSheetEasyEntry', event.srcElement.id);
            if (objWsr.checked == true)
                objWsr.value = "1"
            else
                objWsr.value = "0"
        }
        //End of Normal behavious (not xmlhttp functions)

        //Validation functions
        function validate_controlValue(id) {
            var objCtrl = GetObjectReference('frmTimeSheetEasyEntry', id);            
            if (id.search("ctrAct") == 0 && objCtrl != null) {
                //Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                <%--if (isNumeric(objCtrl.value) != true || isBlank(objCtrl.value) || objCtrl.value < 0) {                   
                    alert("Please enter positive numeric value in multiple of <%=MinHoursForDAEntry%>");
            return false;
        }--%>
                var objHMEffort = GetObjectReference('frmTimeSheetEasyEntry', id);

                var objVal = objHMEffort.value;

                var objOldVal = objHMEffort.value;

                if (objHMEffort.value != "") {
                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    //alert(objHMEffort.value);
                    var isdigit = jQuery.isNumeric(objHMEffort.value);
                    objHMEffort.value = objOldVal;

                    if (objVal.indexOf(":") == -1) {
                        objHMEffort.value = objVal + ":00";
                        objVal = objHMEffort.value;
                    }

                    var mm = objVal.split(":")[1];

                    if (mm == "" || mm == undefined || mm == null) {
                        alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }
                    
                    if (objHMEffort.value.indexOf(":") == -1) {
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }
                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    var blnResult = disallowSpecialCharacters(objHMEffort, "");

                    if (blnResult == true) {
                        objHMEffort.value = objOldVal;
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }

                    blnResult = disallowNonNumeric(objHMEffort, "");
                    //Please enter Work (hrs) in H:M format.
                    if (blnResult == true) {
                        objHMEffort.value = objOldVal;
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }

                    objHMEffort.value = objHMEffort.value.replace('.', ':');

                    var WorkHour = objHMEffort.value;

                    WorkHour = WorkHour.trim();
                    var idxColon = WorkHour.indexOf(':');

                    var hrs = WorkHour.substring(0, idxColon);
                    var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                    if (mins.length == 1 && mins > 5) {
                        mins = mins + "0";
                    }
                    if (hrs.indexOf("-") != -1) {
                        alert("Hours should not be less than or equal to zero (0).");
                        objCtrl.focus();
                        return false;
                    }
                    if (hrs <= 0 && mins <= 0) {
                        alert("Hours should not be less than or equal to zero(0).");
                        objCtrl.focus();
                        return false;
                    }

                    if (mins.length > 2) {
                        //alert("Please enter Work (hrs) in H:M format.");
                        alert("Please enter minutes in two decimal and less than 60.");
                        objCtrl.focus();
                        return false;
                    }

                    if (mins > 59 || mins < 0) {
                        alert("Please enter minutes between (0-59) range");
                        objCtrl.focus();
                        return false;
                    }

                    RestrictByMinHours = '<%=RestrictByMinHours%>';
                    MinHoursForDAEntry = '<%=MinHoursForDAEntry%>';
                    var MinDAENtryDisplay = "";
                    var objMinWorkHrs = MinHoursForDAEntry;

                    var MinDAEntry = objMinWorkHrs;

                    var objRestrictByMinHours = RestrictByMinHours;


                    if (MinDAEntry == 0.25) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:15"
                    }
                    else if (MinDAEntry == 0.50) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:30"
                    }
                    else if (MinDAEntry == 0.75) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:45"
                    }
                    if (objRestrictByMinHours == 'True') {
                        if (MinDAEntry == 0.016) {
                            //alert(MinDAEntry);
                        }
                        else {
                            var minutes = WorkHour.split(':');

                            var p = minutes[0];
                            var dec = minutes[1];

                            if (dec.length > 2) {
                                dec = dec.substring(0, 2);
                            }
                            if (dec.length == 1) {
                                dec = dec + "0";
                            }
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);

                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                                objCtrl.focus();
                                return false;
                            }
                        }
                    }
                    var data = JSON.stringify({ HMHours: WorkHour });
                    var decTotalWorkResult = AJAXCallWithResult("PM_Timesheet_EasyEntry.aspx/getDecimalHours", data, false);
                    var decimalHrs = decTotalWorkResult.d;
                    if (decimalHrs > 24.0) {

                        alert("You can book only 24 hours in a day");
                        objCtrl.focus();

                        return false;
                    }
                }
                //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
        else {
            if (parseFloat(objCtrl.value) > 24.0) {

                alert("Actual work Hrs should not exceed 24 hours");
                objCtrl.focus();

                return false;
            }

            var Holdvalue = parseFloat(objCtrl.value) - parseInt(objCtrl.value);
                    if (Holdvalue % <%=MinHoursForDAEntry%> != 0.0) {                        
                alert("Please enter positive numeric value in multiple of <%=MinHoursForDAEntry%>");
                return false;
            }

            //Code by Sujata


            var TSid = id.substr(6, id.length);

            //Added By ShraddhaM on 4/10/2006 For SP7 IssuID : 6605
            // code for Mozilla
            if (navigator.appName == 'Netscape') {
                var objHours;
                var HidHrs = "hidHrs_" + TSid;
                var HiddenContolName ="<%=HiddenContolName%>";
                        var HiddenContolNameNew = "ctrAct" + TSid;
                        objHours = window.document.forms['frmTimeSheetEasyEntry'].elements[HiddenContolName];

                        var objHrsValues = objHours;
                        var intCnt;
                        var strSum = 0.0;

                        for (intCnt = 0; intCnt < objHrsValues.length; intCnt++) {

                            var strID = objHrsValues[intCnt].id.substr(7, objHrsValues[intCnt].id.length);

                            if (strID != TSid) {
                                strSum = parseFloat(strSum) + parseFloat(objHrsValues[intCnt].value);
                            }

                            if ((objCtrl.name).match(strID) != null) {
                                objHrsValues[intCnt].value = objCtrl.value;
                            }
                        }

                        strSum = parseFloat(strSum) + parseFloat(objCtrl.value);

                        if (strSum > 24.0) {
                            alert("You can book only 24 hours in a day");

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }
                            return false;
                        }
                        else {

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);

                            }

                        }

                    }//Firefox IF ENDS here..
                    //Endded By ShraddhaM on 4/10/2006 For SP7 IssuID : 6605
                    else {
                        var objHours = GetObjectReference('frmTimeSheetEasyEntry', 'HidHrs_' + TSid);

                        var ObjName = objHours.name;
                        var objHrsValues = GetObjectReference('frmTimeSheetEasyEntry', ObjName, true);
                        var intCnt;

                        var strSum = 0.0;

                        for (intCnt = 0; intCnt < objHrsValues.length; intCnt++) {
                            var strID = objHrsValues[intCnt].id.substr(7, objHrsValues[intCnt].id.length);

                            if (strID != TSid) {
                                strSum = parseFloat(strSum) + parseFloat(objHrsValues[intCnt].value);
                            }
                        }

                        strSum = parseFloat(strSum) + parseFloat(objCtrl.value);

                        if (strSum > 24.0) {
                            alert("You can book only 24 hours in a day");

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }
                            return false;
                        }
                        else {

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }

                        }

                    }//IE else End
                    //End of Code by Sujata

                }

            } //end of Actual

            else if (id.search("ctrDes") == 0 && objCtrl != null) {
                if (isBlank(objCtrl.value) == true) {
                    alert("Please enter description");
                    return false;
                }

                if (disallowMaxlengthViolation(objCtrl, 2000, "The maximum length of description is 2000 characters", true))
                    return false;

            }

            return true;
        }
        //end of Validation functions

        //Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
        function WorkHoursValidation(id) {            
            var objCtrl = GetObjectReference('frmTimeSheetEasyEntry', id);

            if (id.search("ctrAct") == 0 && objCtrl != null) {
                //Commented And Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                <%--if (isNumeric(objCtrl.value) != true || isBlank(objCtrl.value) || objCtrl.value < 0) {
                    alert("Please enter positive numeric value in multiple of <%=MinHoursForDAEntry%>");
                    return false;
                }--%>
                var objHMEffort = GetObjectReference('frmTimeSheetEasyEntry', id);

                var objVal = objHMEffort.value;

                var objOldVal = objHMEffort.value;

                if (objHMEffort.value != "") {
                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    //alert(objHMEffort.value);
                    var isdigit = jQuery.isNumeric(objHMEffort.value);
                    objHMEffort.value = objOldVal;

                    if (objVal.indexOf(":") == -1) {
                        objHMEffort.value = objVal + ":00";
                        objVal = objHMEffort.value;
                    }

                    var mm = objVal.split(":")[1];

                    if (mm == "" || mm == undefined || mm == null) {
                        alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }
                    
                    if (objHMEffort.value.indexOf(":") == -1) {
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }
                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    var blnResult = disallowSpecialCharacters(objHMEffort, "");

                    if (blnResult == true) {
                        objHMEffort.value = objOldVal;
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }

                    blnResult = disallowNonNumeric(objHMEffort, "");
                    //Please enter Work (hrs) in H:M format.
                    if (blnResult == true) {
                        objHMEffort.value = objOldVal;
                        alert("Please enter Work (hrs) in H:M format.");
                        objCtrl.focus();
                        return false;
                    }

                    objHMEffort.value = objHMEffort.value.replace('.', ':');

                    var WorkHour = objHMEffort.value;

                    WorkHour = WorkHour.trim();
                    var idxColon = WorkHour.indexOf(':');

                    var hrs = WorkHour.substring(0, idxColon);
                    var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                    if (mins.length == 1 && mins > 5) {
                        mins = mins + "0";
                    }
                    if (hrs.indexOf("-") != -1) {
                        alert("Hours should not be less than or equal to zero (0).");
                        objCtrl.focus();
                        return false;
                    }
                    if (hrs <= 0 && mins <= 0) {
                        alert("Hours should not be less than or equal to zero(0).");
                        objCtrl.focus();
                        return false;
                    }

                    if (mins.length > 2) {
                        //alert("Please enter Work (hrs) in H:M format.");
                        alert("Please enter minutes in two decimal and less than 60.");
                        objCtrl.focus();
                        return false;
                    }

                    if (mins > 59 || mins < 0) {
                        alert("Please enter minutes between (0-59) range");
                        objCtrl.focus();
                        return false;
                    }
                    RestrictByMinHours = '<%=RestrictByMinHours%>';
                    MinHoursForDAEntry = '<%=MinHoursForDAEntry%>';
                    var MinDAENtryDisplay = "";
                    var objMinWorkHrs = MinHoursForDAEntry;

                    var MinDAEntry = objMinWorkHrs;

                    var objRestrictByMinHours = RestrictByMinHours;

                    if (MinDAEntry == 0.25) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:15"
                    }
                    else if (MinDAEntry == 0.50) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:30"
                    }
                    else if (MinDAEntry == 0.75) {
                        MinDAEntry = MinDAEntry
                        MinDAENtryDisplay = "00:45"
                    }
                    if (objRestrictByMinHours == 'True') {
                        if (MinDAEntry == 0.016) {
                            //alert(MinDAEntry);
                        }
                        else {
                            var minutes = WorkHour.split(':');

                            var p = minutes[0];
                            var dec = minutes[1];

                            if (dec.length > 2) {
                                dec = dec.substring(0, 2);
                            }
                            if (dec.length == 1) {
                                dec = dec + "0";
                            }
                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);

                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                                objCtrl.focus();
                                return false;
                            }
                        }
                    }
                    var data = JSON.stringify({ HMHours: WorkHour });
                    var decTotalWorkResult = AJAXCallWithResult("PM_Timesheet_EasyEntry.aspx/getDecimalHours", data, false);
                    var decimalHrs = decTotalWorkResult.d;
                                        
                    if (decimalHrs > 24.0) {

                        alert("You can book only 24 hours in a day");
                        objCtrl.focus();

                        return false;
                    }
                }
               
                //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
                else {                    
                    if (parseFloat(objCtrl.value) > 24.0) {

                        alert("Actual work Hrs should not exceed 24 hours");
                        objCtrl.focus();

                        return false;
                    }

                    var Holdvalue = parseFloat(objCtrl.value) - parseInt(objCtrl.value);
                    if (Holdvalue % <%=MinHoursForDAEntry%> != 0.0) {
                        alert("Please enter positive numeric value in multiple of <%=MinHoursForDAEntry%>");
                        return false;
                    }

                    //Code by Sujata


                    var TSid = id.substr(6, id.length);

                    //Added By ShraddhaM on 4/10/2006 For SP7 IssuID : 6605
                    // code for Mozilla
                    if (navigator.appName == 'Netscape') {
                        var objHours;
                        var HidHrs = "hidHrs_" + TSid;
                        var HiddenContolName = "<%=HiddenContolName%>";
                        var HiddenContolNameNew = "ctrAct" + TSid;
                        objHours = window.document.forms['frmTimeSheetEasyEntry'].elements[HiddenContolName];

                        var objHrsValues = objHours;
                        var intCnt;
                        var strSum = 0.0;

                        for (intCnt = 0; intCnt < objHrsValues.length; intCnt++) {

                            var strID = objHrsValues[intCnt].id.substr(7, objHrsValues[intCnt].id.length);

                            if (strID != TSid) {
                                strSum = parseFloat(strSum) + parseFloat(objHrsValues[intCnt].value);
                            }

                            if ((objCtrl.name).match(strID) != null) {
                                objHrsValues[intCnt].value = objCtrl.value;
                            }
                        }

                        strSum = parseFloat(strSum) + parseFloat(objCtrl.value);

                        if (strSum > 24.0) {
                            alert("You can book only 24 hours in a day");

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }
                            return false;
                        }
                        else {

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);

                            }

                        }

                    }//Firefox IF ENDS here..
                    //Endded By ShraddhaM on 4/10/2006 For SP7 IssuID : 6605
                    else {
                        var objHours = GetObjectReference('frmTimeSheetEasyEntry', 'HidHrs_' + TSid);

                        var ObjName = objHours.name;
                        var objHrsValues = GetObjectReference('frmTimeSheetEasyEntry', ObjName, true);
                        var intCnt;

                        var strSum = 0.0;

                        for (intCnt = 0; intCnt < objHrsValues.length; intCnt++) {
                            var strID = objHrsValues[intCnt].id.substr(7, objHrsValues[intCnt].id.length);

                            if (strID != TSid) {
                                strSum = parseFloat(strSum) + parseFloat(objHrsValues[intCnt].value);
                            }
                        }

                        strSum = parseFloat(strSum) + parseFloat(objCtrl.value);

                        if (strSum > 24.0) {
                            alert("You can book only 24 hours in a day");

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }
                            return false;
                        }
                        else {

                            if (id.search("HidHrs_") != 0) {
                                objHours.value = parseFloat(objCtrl.value);
                            }

                        }

                    }//IE else End
                    //End of Code by Sujata

                }

            } //end of Actual

            else if (id.search("ctrDes") == 0 && objCtrl != null) {
                if (isBlank(objCtrl.value) == true) {
                    alert("Please enter description");
                    return false;
                }

                if (disallowMaxlengthViolation(objCtrl, 2000, "The maximum length of description is 2000 characters", true))
                    return false;

            }

            return true;
        }

        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: async,
                success: function (result) {
                    AjaxResult = result;

                },
                error: function (error) {
                    // alert(Error);
                }
            });

            return AjaxResult;
        }
        //End Of Added By Usha Pandit On 08.12.2020 Purpose::Whizible 2 Work field change
//end of Validation functions
    </script>
</body>
</html>
