<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TCM_Attachment.aspx.vb" Inherits="Whizible.TCM_Attachment"%>
<!DOCTYPE HTML>
<html>
 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("")%>
    
<%--<script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

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
<%--End of Commented and Added By Yogesh Jalamkar on 18th-September-2015 for Responsive Page--%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
						<form id='frmTCM_Attachment' method='post' runat='server' enctype='multipart/form-data'>						
									
									<%WritePage()%>								
					</form>
				
		<script language="javascript">
		
			var objForm;
			var objdivlist;
		
			objForm = GetFormReference('frmTCM_Attachment');
			objdivlist = GetObjectReference('frmTCM_Attachment','divList');
		
		    <%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
		
		function window_onload()
		{
		   // debugger;
		    var objcboTemplate = GetObjectReference('frmTCM_Attachment','cboTemplate');
		objcboTemplate.focus();
			var intDivHeight ;
			var intDivHeightRisk;
            //Commented added by Shamkant s on 28 Nov 2015
		    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 50
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 50 + 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
		    //Comment added on 11 Dec 2015 by Viraj P
		    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';

		}
		
            $('#txtFileName').change(async function () {
                //var fileName = $(this).val().split('\\').pop(); // Get the file name from the file input
                var fileUpload = document.getElementById("txtFileName");
                await validateForExe(fileUpload);
                //alert("hi");
            });

            var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
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

		
		async function Attach_OnClick(strID, strFromWhere,intProjectID )
		{
			var strQueryString;
		
		
			var objFileName = GetObjectReference('frmTCM_Attachment','txtFileName');
			var objtxtComments = GetObjectReference('frmTCM_Attachment','txtComments');
			var objcboTemplate = GetObjectReference('frmTCM_Attachment','cboTemplate');
			
			if (disallowBlank(objcboTemplate,"Please select the Test Case Template",1)	) {return;}
			if (disallowBlank(objFileName,"Please select the file",1)	) {return;}
			if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
			if (disallowMaxlengthViolation(objtxtComments,<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
     //       //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
     //       var fileUpload = document.getElementById("txtFileName");
     //       if (fileUpload.value != "") {
     //           var fileName = fileUpload.value;
     //           var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

     //           var objFileName = fileUpload;
     //           isValidTypeExeCheck = false;
     //           const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
     //           isValidTypeExeCheck = ValidExtsExe.includes(extension);

     //           if (isValidTypeExeCheck) {
     //               const file = fileUpload.files[0];
     //               //const error = await validateDocFileForExe(file);
     //               //console.log(error);
     //               //await checkFileForExe(file);
     //               await validateDocFileForExe(file)
     //                   .then(() => {
     //                       alert('File is valid and ready to upload.');

     //                       isValidTypeExeCheckFlag = true
     //                   })
     //                   .catch(error => {
     //                       console.log(error);
     //                       alert('Upload restricted: This file contains an embedded executable (EXE) file.');

     //                       isValidTypeExeCheck = false;
     //                       isValidTypeExeCheckFlag = false;
     //                       $(objtxtFileName).val("");
     //                       /*$(objFileName).attr("placeholder", "Upload File");*/
     //                       //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
     //                       return;
     //                   });



     //               if (!isValidTypeExeCheck) {
     //                   return;
     //               }
     //           }

     //           //$(objtxtFileName).val("");

     //           //Ended by Parth Godshelwar
     //       }
     ////End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
			// Check if extn. is xls
//			var str=objFileName.value;	
//			str=str.toLowerCase()
//			var pos=str.indexOf(".xls") 
//			if (pos==-1)
//			{
//				alert("Please select only Excel Files.");
//				return;				
//			}
            /// Added by Archanan on 1-Oct-2010
            if ('<%=m_strExtensionList%>'!='')
            {
			    if (ValidateFileExtensions('frmTCM_Attachment','txtFileName','<%=m_strExtensionList%>')==false)
			        return;
            }
			/// End of Added by Archanan on 1-Oct-2010

			var objtblFileAttachment = GetObjectReference('frmTCM_Attachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmTCM_Attachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
			
			
			strQueryString = "TCM_Attachment.aspx?Action=ATTACH&FromWhere=<%=m_strFromWhere%>&ID=" + strID + "&TestSetID=<%=m_strTestSetID%>&ProjectID=" + intProjectID + "&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
			objForm.action = strQueryString;
			objForm.submit();
			
		}	
		
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


        </script>
</body>
</HTML>