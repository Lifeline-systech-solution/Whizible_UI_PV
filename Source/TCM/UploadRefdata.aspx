 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--<script type="text/javascript" src="../../responsive/responsive.js"></script>--%>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Bharat T on 14th-Oct-2015*/
    .footerMenuTable
    {
        position:relative;
    }
    /*Ended By Bharat T on 14th-Oct-2015*/
</style>

<%--<script type="text/javascript">
    $(document).ready(function () {


        
        if (getParameterByName("Mode") == "ADD_NEW") {
            document.body.style.height = 198 + 'px'; //Added By Yogesh J ON 14/12/2015
            $("#divAttachment").css("height", "135px !important");
        }
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
        if (getParameterByName("Mode") == "ADD_NEW") {
            document.body.style.height = 198 + 'px'; //Added By Yogesh J ON 14/12/2015
            $("#divAttachment").css("height", "135px !important");
        }
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

</script>--%>
<%--End of Commented and Added By Yogesh Jalamkar on 18th-September-2015 for Responsive Page--%>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="UploadRefdata.aspx.vb" Inherits="PbNIT.UploadRefdata" %>
<script language="javascript">
async function Attach_Onclick() {
  
 var objtxtDescription=GetObjectReference('','txtDescription');
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
  
   
    if (disallowBlank(objFile,'Please select the file.')) 
    { return; }
    if (disallowSpecialCharacters(objFile,'Character &#39;#&#39; is not allowed in the file name.',true,'#')) 
     { return; }
    if (disallowFileNameLengthGreaterThanMax(objFile,150,'Please make sure that, the length of file name does not exceed 150 characters.',true)) 
    { return; }
    if(disallowMaxlengthViolation(objtxtDescription, 200, 'Please enter a description within 200 characters', true) == true)
    {
				return;
    }

    //Added by Aditya J. on 12-11-2024 for restricting special characters in the description
    if (
        disallowSpecialCharacters(objtxtDescription, 'These ' + WebConfigSpecialCharacters + '  Characters are not allowed in the Description.', true, WebConfigSpecialCharacters)
      )
     {           
         return;
        }
        //End of Added by Aditya J. on 12-11-2024 for restricting special characters in the description
    //Added By Bharat Tekade on 30th-Jun-2016 for SEM Enhancements
    var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
    var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
    //End of Added By Bharat Tekade on 30th-Jun-2016 for SEM Enhancements

    //Added By Rutuja D. on 25 Dec 2020 For MaxFileSize Declaration
    var fileUpload = document.getElementById("fileAttach");
    var intActualFileSize = (fileUpload.files['0'].size);
    var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>'
     //End Added By Rutuja D. on 25 Dec 2020 For MaxFileSize Declaration

    /// Added by Archanan on 1-Oct-2010
    //if ('<%=m_strExtensionList%>'!='')
    if (strFileExtension != '')
    {
        //if (ValidateFileExtensions('frmAttachment', 'txtFileName', '<%=m_strExtensionList%>') == false)
        if (ValidateFileExtensions('frmAttachment', 'fileAttach', strFileExtension, intMinFileSize) == false)
	        return;
    }
	/// End of Added by Archanan on 1-Oct-2010
    // Added by Rutuja D. on 30 Dec 2020 for File Excceded crash Issue
    if (intActualFileSize > intMaxFileSize) {
        alert('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !');
        return false;
    }
  //'End of Added by Rutuja D. on 30 Dec 2020 for File Excceded crash Issue

    ////added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
    //if (fileUpload.value != "") {
    //    var fileName = fileUpload.value;
    //    var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

    //    var objFileName = fileUpload;
    //    isValidTypeExeCheck = false;
    //    const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
    //    isValidTypeExeCheck = ValidExtsExe.includes(extension);

    //    if (isValidTypeExeCheck) {
    //        const file = fileUpload.files[0];
    //        //const error = await validateDocFileForExe(file);
    //        //console.log(error);
    //        //await checkFileForExe(file);
    //        await validateDocFileForExe(file)
    //            .then(() => {
    //                alert('File is valid and ready to upload.');
                
    //                isValidTypeExeCheckFlag = true
    //            })
    //            .catch(error => {
    //                console.log(error);
    //                alert('Upload restricted: The DOC file contains an embedded executable (EXE) file.');
                 
    //                isValidTypeExeCheck = false;
    //                isValidTypeExeCheckFlag = false;
    //                $(objtxtFileName).val("");
    //                /*$(objFileName).attr("placeholder", "Upload File");*/
    //                //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
    //                return;
    //            });



    //        if (!isValidTypeExeCheck) {
    //            return;
    //        }
    //    }

    //    //$(objtxtFileName).val("");

    //    //Ended by Parth Godshelwar
    //}
    // //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


    objSNAtt = GetObjectReference('frmAttachment','upldT');
        if (objSNAtt != null)
            {
                objSNAtt.style.display='none';
             }
    objSNAtt = GetObjectReference('frmAttachment','upldB');
        if (objSNAtt != null)
            {objSNAtt.style.display='none';}
    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
        setFrameLoader();
    //ENd Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Page Loader
	    objfrm.action="UploadRefdata.aspx?Mode=ATTACH&RefreshScript=1";
	    objfrm.submit();
    }


    //added by Parth Godshelwar
    $('#fileAttach').change(async function () {
        //var fileName = $(this).val().split('\\').pop(); // Get the file name from the file input
        var fileUpload = document.getElementById("fileAttach");
        await validateForExe(fileUpload);
        //alert("hi");
    });


    
    async function validateForExe(file) {
        //debugger;
        if (!file) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error("Please Select File");
            return
        }
        //var fileData =file;
        //console.log(fileData);
        //added by Parth Godshelwar
        var isValidTypeExeCheck;
        var objFile = file;
        var fileName = objFile.files[0].name;
        var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


        isValidTypeExeCheck = false;
        //Commented and Added by Aditya J. on 25-11-2024
        //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
        var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of comment Added by Aditya J. on 25-11-2024
        isValidTypeExeCheck = ValidExtsExe.includes(extension);

        if (isValidTypeExeCheck) {
            const file = objFile.files[0];
            //await checkFileForExe(file);
            await validateDocFileForExe(file)
                .then(() => {
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.success("File is valid and ready to upload.");
                    alert("File is valid and ready to upload.");
                })
                .catch(error => {
                    console.log(error);
                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                    //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                    alert("Upload restricted: This file contains an embedded executable (EXE) file.");
                    isValidTypeExeCheck = false;
                    console.log($(objFile).val);
                    $(objFile).val("");
                    console.log($(objFile).val);
                    /*$(objFileName).attr("placeholder", "Upload File");*/
                    //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                    return;
                });



            if (!isValidTypeExeCheck) {
                return;
            }
        }

        //$(objtxtFileName).val("");

        //Ended by Parth Godshelwar

    }



    //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
    //function validateDocFileForExe(file) {

    //    return new Promise((resolve, reject) => {
    //        //debugger;

    //        const reader = new FileReader();

    //        reader.onload = function (e) {
    //            const arrayBuffer = e.target.result;
    //            const uint8 = new Uint8Array(arrayBuffer);

    //            // Function to search for a specific byte sequence
    //            const containsSignature = (signature) => {
    //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
    //                    let found = true;
    //                    for (let j = 0; j < signature.length; j++) {
    //                        if (uint8[i + j] !== signature[j]) {
    //                            found = false;
    //                            break;
    //                        }
    //                    }
    //                    if (found) return true;
    //                }
    //                return false;
    //            };

    //            // Check for 'MZ' signature (common for Windows EXE files)
    //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
    //            if (containsSignature(mzSignature)) {
    //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
    //                return;
    //            }

    //            // Additional checks can be added here (e.g., searching for .exe strings)
    //            // Example: Check for ".exe" string in ASCII
    //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
    //            if (containsSignature(exeString)) {
    //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
    //                return;
    //            }

    //            // If no signatures are found, the file is considered safe
    //            resolve();
    //        };

    //        reader.onerror = function () {
    //            reject("Error reading the file. Please try again.");
    //        };

    //        // Read the file as an ArrayBuffer
    //        reader.readAsArrayBuffer(file);
    //    });
    //}

        //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
</script>  
