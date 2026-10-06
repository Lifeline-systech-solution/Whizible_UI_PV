<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_Attachment.aspx.vb" Inherits="Whizible.HR_Attachment" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Upload Excel")%>


<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
						<form id='frmHR_Attachment' method='post' runat='server' enctype='multipart/form-data'>						
									
									<%WritePage()%>								
					</form>
				
		<script language="javascript">
		
			var objForm;
			var objdivlist;
			var intTagID;
			intTagID = "<%=m_intTagID%>"
			objForm = GetFormReference('frmHR_Attachment');
			objdivlist = GetObjectReference('frmHR_Attachment','divList');
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		function window_onload()
		{
		//var objcboTemplate = GetObjectReference('frmHR_Attachment','cboTemplate');
	//	objcboTemplate.focus();
			var intDivHeight ;
			var intDivHeightRisk;
            //Commented by Yogesh J on 15/12/2015 for pop up bottom line issue
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
		    //End of comment by Yogesh J on 15/12/2015 for pop up bottom line issue
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    //Commented by Yogesh J on 15/12/2015 for pop up bottom line issue
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;
		    //End of comment by Yogesh J on 15/12/2015 for pop up bottom line issue
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';		
		}


            //added by Parth Godshelwar
            $('#txtFileName').change(async function () {
                //var fileName = $(this).val().split('\\').pop(); // Get the file name from the file input
                var fileUpload = document.getElementById("txtFileName");
                await validateForExe(fileUpload);
                //alert("hi");
            });
			

            //added by Parth Godshelwar
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
                //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
                const ValidExtsExe = ValidateFileExtension.split(",");
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


		async function Attach_OnClick()
		{
			var strQueryString;
		
			var objFileName = GetObjectReference('frmHR_Attachment','txtFileName');
			//var objtxtComments = GetObjectReference('frmHR_Attachment','txtComments');
		    //var objcboTemplate = GetObjectReference('frmHR_Attachment','cboTemplate');

            ////Added by Ajit L on 14/11/2024 for file upload validation
            //await ValidateForexeinFile(objFileName); 
            //if (fileFlag ==false) {
            //    return;
            //}
            // //Added by Ajit L on 14/11/2024 for file upload validation

		    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
            var countOfDot, FileNameCharCount;
          
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
            //Commented and Added By Reshma Chavan on 2nd Dec 2020 For Javascript error on Upload link
            //var intActualFileSize = (objFileName.files['0'].size);
            
            if (objFileName.files['0'] != null || objFileName.files['0'] != undefined) {
                var intActualFileSize = (objFileName.files['0'].size);
            }
             //End of Commented and Added By Reshma Chavan on 2nd Dec 2020 For Javascript error on Upload link
		    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
			
			//if (disallowBlank(objcboTemplate,"Please select the Resource Joining Pool Template",1)	) {return;}
			if (disallowBlank(objFileName,"Please select the file",1)	) {return;}
			if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
			//if (disallowMaxlengthViolation(objtxtComments,<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
			
			// Check if extn. is xls
			var str=objFileName.value;	
			str=str.toLowerCase()
			var pos=str.indexOf(".xls") 
			if (pos==-1)
			{
				alert("Please select only Excel Files.");
				return;				
			}

		    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
			if (objFileName.files['0'].name != '')
			    var countOfDot = objFileName.files['0'].name.split(".").length - 1;

			if (countOfDot > 1) {
			    alert('File with two or more extensions is not allowed!');
			    return false;
			}

			if (objFileName.files['0'].name != '')
			    FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

			if (FileNameCharCount > 120) {
			    alert('File name should not exceed 120 characters!');
			    return false;
			}

			if (intActualFileSize < intMinFileSize) {
			    alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
			    return false;
			}
		    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
				
			var objtblFileAttachment = GetObjectReference('frmHR_Attachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmHR_Attachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 		
			strQueryString = "HR_Attachment.aspx?Action=ATTACH&MasterTagId="+intTagID+"&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
			objForm.action = strQueryString;
			objForm.submit();
			
        }

        //Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it
        //var isValidTypeExeCheck = ''
        //var fileFlag = '';

            var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
        async function ValidateForexeinFile(file) {          
            var objFile = file;
            var fileName = objFile.files[0].name;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            isValidTypeExeCheck = false;
           // const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            const ValidExtsExe = ValidateFileExtension.split(",");
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.success("File is valid and ready to upload.");
                        alert("File is valid and ready to upload.");
                        fileFlag = true;
                    })
                    .catch(error => {
                        console.log(error);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        alert("Upload restricted: This file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        //$(objFile).val("");
                       // $(objFileName).val("");
                       // $("#txtFileName").val("");
                        fileFlag = false;

                        return;
                    });

                if (!isValidTypeExeCheck) {
                    return;
                }
            }
        }
        //End of Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it

        

		function txtFileName_onkeydown() 
		{
			event.returnValue = false;	
		}

		function txtFileName_onbeforepaste() 
		{
			event.returnValue = false;	
		}

		function txtFileName_onpaste() 
		{
			event.returnValue = false;	
		}


		function ViewRejectedFile(RejectedRecordsFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5CRejectedFiles%5C&FileName="+RejectedRecordsFilePath ); 
			
		}
		function ViewUploadedFile(ViewFilePath,DirPath)
		{						 
				window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5CRequests%5C&FileName="+ViewFilePath ); 
				
		}
		function ViewLogFile(logFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5Clogs%5C&FileName="+logFilePath ); 
			
		}
		
		function Download_onclick()
		{ 
			//var strQueryString;	
			if (intTagID == 23)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeTemplate.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			if (intTagID == 3873)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=cca96b2b.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			//window.open ("../General/commonlist.aspx?FromWhere=DXU&MasterTagID=3876", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			if (intTagID == 3949)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeePayrollTemplate.xls&SystemFileName=fc24ea88.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
					
					//Added By VarunA on 23-Mar-2009 IssueID-28582
			//Purpose : To upload Approved Employee Leave through Excel Upload.
			if (intTagID == 1207)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeLeaves.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			//End By VarunA on 23-Mar-2009 IssueID-28582
			
		}	
		
			
		function DeleteDetails_OnClick()
		{
			var objchkDelete = GetObjectReference('frmHR_Attachment','chkDelete',true);
			var blnIsCheckboxChecked;
			var intCounter;
			blnIsCheckboxChecked = false;
			
			if (objchkDelete.length > 0)
			{
				for(intCounter=0; intCounter < objchkDelete.length;intCounter++)
				{
					if (objchkDelete[intCounter].checked == true)
					{
						blnIsCheckboxChecked = true;
						break;
					}
				}
				
				if (blnIsCheckboxChecked == true)
				{
					if (confirm("Are you sure you want to delete the record(s)?")==true)
					{
						//Modified By VarunA 30-Sep-2008 IssueID-20106
					    //Purpose : To have the master TagID while deleting a record, b'cos the page get refreshed.
						//strQueryString = "HR_Attachment.aspx?Action=DELETEDETAILS&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
					    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
					    setFrameLoader();
					    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
					    strQueryString = "HR_Attachment.aspx?Action=DELETEDETAILS&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&MasterTagID=<%=m_intTagID%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
						//End By VarunA 30-Sep-2008 IssueID-20106
                        objForm.action = strQueryString;
                        
                        objForm.submit();	
                        ///Addd By Dipali V On 9th June 2020 For Issue ID 24897
                        alert('Record(s) Deleted successfully');
					}
				}
				else
				{
					alert("Please Select Record to delete");
				}	
			}
				
		}
		
		function SelectAll_Onclick()
		{
			var objchkDelete = GetObjectReference('frmHR_Attachment','chkDelete',true);
			for(i=0;i<objchkDelete.length;i++)
			{
				objchkDelete[i].checked = true;
			}
		}
		
		function ClearAll_Onclick()
		{
			var objchkDelete = GetObjectReference('frmHR_Attachment','chkDelete',true);
				for(i=0;i<objchkDelete.length;i++)
			{
				objchkDelete[i].checked = false;
			}
		}
		
		function Close_OnClick()
		{
			window.close();			
		}
		
        </script>
</body>
</HTML>