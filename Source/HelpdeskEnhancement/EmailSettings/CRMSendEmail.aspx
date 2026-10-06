<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRMSendEmail.aspx.vb" Inherits="Whizible.CRMSendEmail"    EnableViewStateMac="True"%>


<!DOCTYPE HTML>
<HTML>
    <%--commented and added by Shamkant s--%>
    <%CommonFunctions.General.PlotPageHeadTag("")%>
    <head>
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <!-- <link href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" rel="stylesheet" />
        <link href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" rel="stylesheet" /> -->
        <link  href="../../../Whizible2.0-new/dist/css/style.css"  rel="stylesheet" />
        <link href="../../../Whizible2.0-new/dist/css/reqdetail.css" rel="stylesheet" />     
        <link  href="../../../Whizible2.0-new/dist/css/setting.css" rel="stylesheet"/>
        <link  href="../../../Whizible2.0-new/dist/css/sb-admin.css" rel="stylesheet"/>
        <!-- <link  href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet"/> -->
        <link  href="../../../Whizible2.0-new/dist/css/timepicker.min.css" rel="stylesheet"/>    
        <!-- <link  href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" /> -->
        <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

    </head>
  
    <style>
        @media only screen and (min-width: 767px) {
            form > table:last-child {
                display: table;
            }
        }
        @media only screen and (max-width: 767px) {
            form > table:last-child {
                display: none;
            }
        }

        .modal {
            top: -80px !important;
        }

        #FileControlUploadDiv {
        display:none;
        }
        #txtCCToEmailID {
            margin-left:-2%;
            font-size:12px;
        }
        #txtToEmailID {
           margin-left:-1%;
           font-size:12px;
        }

        #DivBody {
           width:104%;
           margin-top: -3%;
           margin-left: -2%;
        }

       .btn-default {
            background-color:#343660!important;
            width:100px!important;
             color:white!important;
        }
        .btn-default:hover {
            background-color:#343660!important;
             color:white!important;
        }

      


        .bottom-bar {
            width:109%!important;
        }
       /*#btncancel{
                 background-color:#343660!important;
                 width:100px!important;
                 color:white!important;

            }
       #btncancel:hover {
                 background-color:#343660!important;
                 color:white!important;
            }*/

        #txtSubject {
            width: 496px!important;
            font-size:12px;
        }

        #txtMessage {
            font-size:12px;
        }
        .clsTREven1 {
            background-color:white!important;
        }

        .close:hover, .close:focus {
            color:white!important;
        }
         /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
        color: #bbb!important;
        }
        /*Added By Dipali V On 14th Dec 2021 For Wrap Alert Text*/

        .ajs-message {
            position: fixed;
            z-index: 5000;
            bottom: 10px;
            right: 10px;
            width: auto;
        }

        .alertify-notifier .ajs-message {
            width:360px;
             word-break:break-word;
        }
        .alertify-notifier.ajs-right .ajs-message.ajs-visible {
            right: 350px;
        }
        /*Added By Dipali V On 28th March 2023 For Font Size Issue*/
        #tblFiles {
            font-size:12px!important
        }
       /*End of Added By Dipali V On 28th March 2023 For Font Size Issue*/
    /*End of Added By Dipali V On 14th Dec 2021 For Wrap Alert Text*/

    .form-control,
    input.form-control:not([type="button"]), 
    textarea.form-control, textarea.form-control::placeholder {
        font-weight: 400 !important;
    }
    </style>

	<%'Whizible.clsCommonFunctions.PlotPageHeadTag(m_strWindowTitle)%>
    <%--Commented And Added By Usha Pandit On 24.02.2021 To add loader--%>
<%--	<body MS_POSITIONING="GridLayout" class="" onresize="window_onresize()" onload="window_onload()">--%>
        <body MS_POSITIONING="GridLayout" class="clsLoader" onresize="window_onresize()" onload="window_onload()">
            <%--End Of Added By Usha Pandit On 24.02.2021 To add loader--%>
		<form id="frmCRMSendEmail" name="frmCRMSendEmail" method="post"  enctype="multipart/form-data">
            <IMG Border=0 style='display:none'  SRC='../../../Images/TemporaryImages/2.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader'>
			<%PageInit()%>
            <input type="hidden" id="hdncount"/>
		</form>
		<script language="javascript">
		    var objdivlist;
            var objform;
            var fileObject = [];
            var cnt = 0;

		    objform = GetFormReference('frmCRMSendEmail');
		    objdivlist = GetObjectReference('frmCRMSendEmail', 'DivBody');

		  
		    '<%MyBase.InitializeResources("Resources.SendEmail", "Resources")%>';

            // $(document).ready(function ()
            //{
            //    var n = $("$hdncount").val();
            //    for (var j = 0; j < n; j++)
            //    {                     
            //        fileObject[j] = j;                                               
            //    }
            //});

			function WhichBrowser() {

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
		

			function window_onload() {

			    var intDivHeight;
			    var intDivHeightRisk;

			    if (WhichBrowser() == 'IE') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;

			    }
			    else if (WhichBrowser() == 'FF') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;

			    }
			    else if (WhichBrowser() == 'CR') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
			    }
			    else {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;
			    }
			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			  

            }

			function window_onresize() {
			  

			    var intDivHeight;
			    var intDivHeightRisk;

			    if (WhichBrowser() == 'IE') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;

			    }
			    else if (WhichBrowser() == 'FF') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;

			    }
			    else if (WhichBrowser() == 'CR') {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 15;
			    }
			    else {
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 20;
			    }
			    if (intDivHeight < 100)
			        intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + 'px';
			   
			}

            //Added by Dipali V On 26th Oct 2017 For NexGen Version2
			function Send_OnClick()
            {
                //debugger;
			    var objTxt;
			    var flag;
			    var checkValu = 0;
			    objTxt = GetObjectReference('frmCRMSendEmail', 'txtFromEmailID');
                //alert(1);
			    if ($('#txtToEmailID').val() == "")
			    {
				    $('#txtToEmailID').css('border-color', 'red');
				    $('#txtToEmailID').css('border-width', '1px');
				    $('#SpantxtToEmailID').text("Please Specified EmailId");
				    if (checkValu != 1) {
				        $('#txtToEmailID').focus()
				    }
				    checkValu = 1;
				}
			    if ($('#txtToEmailID').val() != "")
			    {
			        objTxt = GetObjectReference('frmCRMSendEmail', 'txtToEmailID');
			        flag = ValidateEmailID(objTxt.value);
			        if (flag == false) {
			            // alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
			            $('#txtToEmailID').css('border-color', 'red');
			            $('#txtToEmailID').css('border-width', '1px');
			            $('#SpantxtToEmailID').text("Please Enter Valid EmailID");
			            // objTxt.focus();
			            if (checkValu != 1) {
			                $('#txtToEmailID').focus()
			            }
			            checkValu = 1;
			        }
			    }
			    if ($('#txtCCToEmailID').val() != "") {
			        objTxt = GetObjectReference('frmCRMSendEmail', 'txtCCToEmailID');
			        if (objTxt.value != '') {
			            flag = ValidateEmailID(objTxt.value);
			            if (flag == false) {
			                // alert('<%=MyBase.GetResourceString("MSG_INVALID_EMAIL_ID")%>');
			                $('#txtCCToEmailID').css('border-color', 'red');
			                $('#txtCCToEmailID').css('border-width', '1px');
			                $('#SpantxtCCToEmailID').text("Please Enter Valid EmailID");
			                if (checkValu != 1) {
			                    $('#txtCCToEmailID').focus()
			                }
			                checkValu = 1;
			            }
			        }
			    }

			    objTxt = GetObjectReference('frmCRMSendEmail', 'txtSubject');
                //flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_SUBJECT_EMPTY")%>', true);
				//if (flag == true)
				   // return;
               
			    if ($('#txtSubject').val() == "") {
			        $('#txtSubject').css('border-color', 'red');
			        $('#txtSubject').css('border-width', '1px');
			        $('#SpantxtSubject').text("Subject Should not be blank!");
			        if (checkValu != 1) {
			            $('#txtSubject').focus()
			        }
			        checkValu = 1;
			    }


				objTxt = GetObjectReference('frmCRMSendEmail', 'txtMessage');
				//flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_MESSAGE_EMPTY")%>', true);
				//if (flag == true)
			    //  return;

			    if ($('#txtMessage').val() == "") {
			        $('#txtMessage').css('border-color', 'red');
			        $('#txtMessage').css('border-width', '1px');
			        $('#SpantxtMessage').text("Message Should not be blank!");
			        if (checkValu != 1) {
			            $('#txtMessage').focus()
			        }
			        checkValu = 1;
			    }
			    //Integrated by Yogesh Jalamkar on 29-Nov-2017 Purpose: for Mime type
			    var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
			    var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
			    var validateExtensions = strFileExtension.split(",");

                for (var i = 0; i < fileObject.length; i++) {
			        if (fileObject[i].length > 0) {
			            var allowSubmit = false;
			            var intActualFileSize = (fileObject[i][0].size);
			            //formData.append("TxtComment_" + [i], document.getElementById('txtComments' + [i]).value);
			            // formData.append("Internal_" + [i], 1);
			            if (intActualFileSize < intMinFileSize) {
			                alertify.set('notifier', 'position', 'top-right');
			                alertify.notify( fileObject[i][0].name + ' File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'error', 25);
			                checkValu = 1;
			            }
			            var file = fileObject[i][0].name;
			            var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
			            for (var cnt = 0; cnt < validateExtensions.length ; cnt++) {
			                var strExtn;
			                strExtn = validateExtensions[cnt];
			                if (strExtn.toLowerCase() == extension)
			                { allowSubmit = true; }
			            }
			            if (allowSubmit == false) {
			                alertify.set('notifier', 'position', 'top-right');
			                alertify.notify("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'error', 25);
			                checkValu = 1;
			            }
			        }
                }
                //alert('aaaa');
			    //End by yogesh Jalamkar
			    if (checkValu == 0)
			    {
                        <%--Added By Usha Pandit On 24.02.2021 For adding loader--%>
                        StartLoader(".clsLoader");
                        <%--End Of Added By Usha Pandit On 24.02.2021 For adding loader--%>
                        var MenuTags = document.getElementsByTagName('A');
				    for (i = 0; i < MenuTags.length; i++) {
				        if (MenuTags[i].className == "Menu") {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.style.display = "none";
				        }
				    }
				    //setFrameLoader();
                  
                   //Added By Dipali V On 12th May 2020 For IssueID  24129
                    objform.action = "CRMSendEmail.aspx?Action=SEND&Mode=EMAIL&MessageID=<%=m_lngMessageID%>&DiscussionID=<%=m_DiscussionID%>&QueryID=<%=m_lngQueryID%>";
                   
                    //End of Added By Dipali V On 12th May 2020 For IssueID  24129

				    objform.submit();
                        <%--Added By Usha Pandit On 24.02.2021 For adding loader--%>
                        window.onunload = refreshParent;
                        function refreshParent() {
                            StopAjaxLoader(".clsLoader");
                        }
                        <%--End Of Added By Usha Pandit On 24.02.2021 For adding loader--%>
                    }
            }
		    //End of Added by Dipali V On 26th Oct 2017 For NexGen Version2


            //Added By Dipali V On 28th March 2023 For Get GetFormReference Reff
            function GetFormReference(strFormId) {
                var objElement;

                objElement = document.getElementById(strFormId);
                return objElement;

            }
            //End of Added By Dipali V On 28th March 2023 For Get GetFormReference Reff


            function ValidateEmailID(strEmailList) {
                var strEmailArray;
                var intCtr
                var strNewEmailList
                if (strEmailList == "") {
                    return false;
                }
                //Added By NikitaD of Send Mail functionality in 4.0
                //Added by swapnil aswale on 31/3/2016
                //if (strEmailList.charAt(strEmailList.length - 2) == ";") {
                if (strEmailList.charAt(strEmailList.trim().length - 1) == ";") {
                    strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
                }
                    //Ended
                else {
                    strNewEmailList = strEmailList;
                }
                strNewEmailList = strNewEmailList.replace(/ /g, '');
                //End Added By NikitaD of Send Mail functionality in 4.0
                objRegularExp = new RegExp("[\\,,\\ ,\\;]")
                strEmailArray = strNewEmailList.split(objRegularExp);

                if (strEmailArray.length == 0)
                    return false;

                for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
                    if (isEmail(strEmailArray[intCtr]) == false) {
                        //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                        return false;
                    }
                }
                return true;
            }

            function isEmail(str) {
                /*
				'=====================================================================
				' Procedure Name        :   isEmail
				' Description           :   Generic function which validates if the Email Id entered by the user
				'							is in a proper format.	
				' Purpose               :   To Validate the email id is in proper format or not
				' Parameters Passed     :   Email ID which is to be validated
				' Returns               :
				' Parameters Affected   :   None
				' Assumptions           :
				' Dependencies          :
				' Author                :   UmaB
				' Created               :   11th September 2000
				' Revisions             :
				'=====================================================================
				*/
                // Are regular expressions supported ?
                var supported = 0;

                if (window.RegExp) {
                    var tempStr = "a";
                    var tempReg = new RegExp(tempStr);
                    if (tempReg.test(tempStr)) supported = 1;
                }

                if (!supported)
                    return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

                var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
                var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

                return (!r1.test(str) && r2.test(str));

            }
          
            function ShowDescription_onClick() {
                var objTR = GetObjectReference('frmDashboard', 'Description');
                var objImg = GetObjectReference('', 'imgSummaryShowHide');
                var IsCollapse = objImg.getAttribute("Collapse");

                if (IsCollapse == "Y") {
                    objImg.src = '../../../Images/plus.gif';
                    objTR.style.display = 'none';
                    objImg.setAttribute("Collapse", "N");
                }
                else if (IsCollapse == "N") {
                    objImg.src = '../../../Images/minus.gif';
                    objTR.style.display = '';
                    objImg.setAttribute("Collapse", "Y");
                }

            }
		   
		    //Added by Dipali V On 26th Oct 2017 For NexGen Version2

            function SelectFile()
            {
               
                var strFileCount = $("#btnSelectFile").attr("FileCount");
                var objCurrentFileControl = $("#txtFileName" + strFileCount);

                objCurrentFileControl.click();
            }

         var FileCount = 0;
         
         var FileCount_toDisable = 0;
       //  var fileObject = [];
            function addFileinGrid()
            {
                //var FileCount1 = ($("#hdncount").val() - 0);
                var FileCount1 = $("#hdncount").val();
                if (FileCount1 == undefined || FileCount1 == null || FileCount1 =="")
                {
                    FileCount1 = 0;
                    $("#hdncount").val(FileCount1);
                }

                var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                var objFileGrid = document.getElementById('tblFiles');
                objFileGrid.style.display = "";
                var newRow = objFileGrid.insertRow(objFileGrid.rows.length);

                newRow.id = 'FILENAME' + FileCount1;
                newRow.name = 'txtFileName';
                newRow.className = "clsTREven1";
               // newRow.style="background-color:white"
                var newCell = newRow.insertCell(0);

                var fileName = objtxtFileName.value;
                var index = fileName.lastIndexOf("\\");
                if (index == -1)
                    index = fileName.lastIndexOf("/");

                if (index != -1)
                    fileName = fileName.substring(index + 1, fileName.length);

                newCell.innerHTML = fileName;


                newCell = newRow.insertCell(1);
                //newCell.innerHTML = "<A class='' style='' HREF='Javascript:RemoveAttachement1(" + FileCount1 + ")' Title='Remove Attachment' >(Remove)</A>";
                newCell.innerHTML = "<A class='' style='' HREF='Javascript:RemoveAttachmentFromSenMail(" + cnt + ","+ FileCount1 +")' Title='Remove Attachment' >(Remove)</A>";

                parentTD = objtxtFileName.parentNode;
                objtxtFileName.style.display = "none";

                FileCount++;
                cnt++;
                FileCount_toDisable++;

                var FileControl;
                FileControl = document.createElement("INPUT");
                FileControl.type = "FILE";
                FileControl.id = "txtFileName" + FileCount;
                FileControl.name = "txtFileName" + FileCount;
                FileControl.className = 'clsTextBox';
                FileControl.size = 74;
                FileControl.style = "display:none;";

                FileControl.onkeydown = function () { return false; };
                FileControl.onbeforepaste = function () { return false; };
                FileControl.onpaste = function () { return false; };
                FileControl.onkeydown = function () { return false; };
                FileControl.onbeforepaste = function () { return false; };
                FileControl.onpaste = function () { return false; };
                FileControl.onchange = addFileinGrid;

                if (FileCount_toDisable == 5)
                    FileControl.disabled = true;
                parentTD.appendChild(FileControl);
                $("#btnSelectFile").attr("FileCount", FileCount);
                //Integrated by Yogesh Jalamkar on 29-Nov-2017 Purpose: for Mime type
                for (var j = 0; j < tblFiles.rows.length; j++)
                {
                    if ($("#txtFileName" + j)[0] != undefined)
                    {
                        fileObject[j] = $("#txtFileName" + j)[0].files;   
                    }                        
                }
                //End by Yogesh Jalamkar

                FileCount1++;
                $("#hdncount").val(FileCount1);
            }

            function RemoveAttachement(FileNO)
            {
                //alert(fileObject.length);
                //for (i = 0; i < fileObject.length; i++)
                //{
                //    if (i == FileNO)
                //    {                       
                //        fileObject.splice(i, 1);
                //        //alert(fileObject[i][0].name);
                //    }
                //    //alert(fileObject[i][0].name + ' ' + i + ' FileNo :- ' + FileNO);
                //}
                               
                //const input = document.getElementById('files')
                //input.addEventListener('change', () => {
                //  const fileListArr = Array.from(input.files)
                //  fileListArr.splice(1, 1)
                //  console.log(fileListArr)
                //})

                var objTR = document.getElementById('FILENAME' + FileNO);
                var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
                var objFileGrid = document.getElementById('tblFiles');

                objFileGrid.deleteRow(objTR.rowIndex);

                if (toRemoveFileControl != null)
                    
                    toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
                document.getElementById("txtFileName" + FileCount).disabled = false;;

                if (objFileGrid.rows.length == 1) {
                    objFileGrid.style.display = 'none';
                }
            
                FileCount_toDisable--;
            }

            function RemoveAttachmentFromSenMail (FileNO, FileCountNo)
            {
                for (i = 0; i < fileObject.length; i++)
                {
                    if (i == FileNO)
                    {                       
                        fileObject.splice(i, 1);
                    }
                    //alert(fileObject[i][0].name + ' ' + i + ' FileNo :- ' + FileNO);
                }

                var objTR = document.getElementById('FILENAME' + FileCountNo);
                var toRemoveFileControl = document.getElementById('txtFileName' + FileCountNo);
                var objFileGrid = document.getElementById('tblFiles');

                objFileGrid.deleteRow(objTR.rowIndex);

                if (toRemoveFileControl != null)
                    
                    toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
                document.getElementById("txtFileName" + FileCount).disabled = false;;

                if (objFileGrid.rows.length == 1) {
                    objFileGrid.style.display = 'none';
                }
            
                FileCount_toDisable--;
            }

            function ClearSpan(txt, span)
            {

                if ($('#' + txt).val() == "")
                {

                }
                else
                {
                    $('#' + txt).css('border-color', '#d8dade');
                    $('#' + txt).css('border-width', '1px');
                    $('#' + span).text("");
                }
            }

            function Cancel_OnClick() {
                window.close();
                $("#DivBody").hide();
            }

            //$("#btncancel").on("click", function () {
            //    alert();
            //    // $("#DivBody").hide();
            //    // window.close();
            //});

            
		    //End of Added by Dipali V On 26th Oct 2017 For NexGen Version2


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

            function opentextdialog(frmName, txtObject, title, IsDisable, path) {
                //Function modified for Hotfix ID 2.0.37-SP4-WAF by UmeshJ 08-Sep-2006
                //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
                //var path=(arguments.length>4)?arguments[4]:'null'; 
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

                var strDescription;
                if (title == null)
                    title = "";
                if (path == null || path == '') {
                    //Issue ID 28888
                    if (window.showModalDialog) {
                        strDescription = window.showModalDialog("../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
                    } else {
                        var strAddress;
                        strAddress = "../../General/TextDialogBox.aspx?Title=" + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
                        ShowWindow(strAddress, objText.value);
                    }
                } else {
                    //Issue ID 28888
                    if (window.showModalDialog) {
                        strDescription = window.showModalDialog(path + '?Title=' + title + "&Disable=" + IsDisable + RowIndex + "&MaxLength=" + maxLength, objText, "dialogWidth:545px;dialogHeight:530px");
                    } else {
                        var strAddress;
                        strAddress = path + '?Title=' + title + "&Disable=" + IsDisable + "&ParentFormName=" + frmName + "&TextAreaName=" + txtObject + "&TextAreaValue=" + objText.value + RowIndex + "&MaxLength=" + maxLength;
                        ShowWindow(strAddress, objText.value);
                    }
                }

                if ((IsDisable == "False") && (window.showModalDialog)) {
                    objText.value = strDescription;
                }
            }


        </script>
		


	</body>
  
    <%--<script src="../../../Whizible2.0-new/OnlineFiles/js/jquery/3.3.5/jquery-3.5.1.min.js"></script>--%>
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script> -->

    <script src="../../../Whizible2.0-new/dist/js/popper.min.js"></script>
    <!-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>    
    <script src="../../General/CommonFunctions.js"></script> -->
     
</HTML>
