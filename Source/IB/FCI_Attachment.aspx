<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FCI_Attachment.aspx.vb" Inherits="Whizible.FCI_Attachment" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!-- Added by Chakshuta H on 19th-Oct-2015 Purpose::Pagination alignment issue-->
<style>
    #txtPageNumber{
    margin: 0px;
    padding:2px;
    }
</style>
<!-- Ended by Chakshuta H on 19th-Oct-2015 Purpose::Pagination alignment issue-->
<!DOCTYPE HTML>
<html>

    <%--Added By Usha Pandit On 08.04.2020 For javascript for SetFrameLoader--%>
	
	<%CommonFunctions.General.PlotPageHeadTag("Upload Excel")%>

	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->


<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <script type="text/javascript" src="../../responsive/responsive.js"></script>

    <%--End Of Added By Usha Pandit On 08.04.2020 For javascript for SetFrameLoader--%>
  <!-- <%CommonFunctions.General.PlotPageHeadTag("Upload Excel")%> -->
    
 
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
		
		    
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    
		function window_onload()
		{
		//var objcboTemplate = GetObjectReference('frmHR_Attachment','cboTemplate');
	//	objcboTemplate.focus();
	        if ("<%=m_strReturnHTML%>" != "")
			    { alert("<%=m_strReturnHTML%>");return; }
			else
			{    
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	
	        }		
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';		
		}
            var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
			//added by Parth Godshelwar
            async function validateForExe(file) {
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


		function Attach_OnClick()
		{
			var strQueryString;
		
		
			var objFileName = GetObjectReference('frmHR_Attachment','txtFileName');
			//var objtxtComments = GetObjectReference('frmHR_Attachment','txtComments');
			//var objcboTemplate = GetObjectReference('frmHR_Attachment','cboTemplate');
			
			//if (disallowBlank(objcboTemplate,"Please select the Resource Joining Pool Template",1)	) {return;}
			if (disallowBlank(objFileName,"Please select the file",1)	) {return;}
			if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
			//if (disallowMaxlengthViolation(objtxtComments,<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
			
			// Check if extn. is xls
			var str=objFileName.value;	
			var pos; 
			str=str.toLowerCase()
			pos = str.indexOf(".xls") 
			if (pos==-1)
			{
			    pos = str.indexOf(".xlsx") 
			}
			
			if (pos==-1)
			{
				alert("Please select only Excel Files.");
				return;				
			}
			
		    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
			var countOfDot, FileNameCharCount;
			var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
		    var intActualFileSize = (objFileName.files['0'].size);

		    if (objFileName.files['0'].name != '')
		        var countOfDot = objFileName.files['0'].name.split(".").length - 1;

		    if (countOfDot > 1) {
		        alert('File with two or more extensions is not allowed!');
		        return;
		    }

		    if (objFileName.files['0'].name != '')
		        FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

		    if (FileNameCharCount > 120) {
		        alert('File name should not exceed 120 characters!');
		        return;
		    }

		    if (intActualFileSize < intMinFileSize) {
		        alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
		        return;
		    }
		    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement

			var objtblFileAttachment = GetObjectReference('frmHR_Attachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmHR_Attachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
					
			strQueryString = "FCI_Attachment.aspx?Action=ATTACH&MasterTagId="+intTagID+"&FromWhere=IB&Page=<%=m_strPage%>&Mode=<%=m_strMode%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		    objForm.action = strQueryString;
			objForm.submit();
            RemoveFrameLoader();
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


		function ViewRejectedFile(RejectedRecordsFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=IB%5CRejectedFiles%5C&FileName="+RejectedRecordsFilePath ); 
			
		}
		function ViewUploadedFile(ViewFilePath,DirPath)
		{						 
				window.open ("../General/ViewAttachment.aspx?FromWhere=IB%5CRequests%5C&FileName="+ViewFilePath ); 
				
		}
		function ViewLogFile(logFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=IB%5Clogs%5C&FileName="+logFilePath ); 
			
		}
		
		function Download_onclick()
		{ 
		   // window.open ("../General/ViewAttachment.aspx?FromWhere=FCI&FileName=EmployeeLeaves.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");			
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		    objForm.action = "FCI_Attachment.aspx?Action=EXPORT";
			objForm.submit();
            RemoveFrameLoader();
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
					    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
					    setFrameLoader();
					    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
						strQueryString = "FCI_Attachment.aspx?Action=DELETEDETAILS&FromWhere=IB&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&MasterTagID=<%=m_intTagID%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
						objForm.action = strQueryString;
						objForm.submit();
                        RemoveFrameLoader();
					}
				}
				else
				{
					alert("Please Select Record to delete");
					return;
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
	
	    function Page_OnClick(page)
		{
	        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	        setFrameLoader();
	        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		    objForm.action = "FCI_Attachment.aspx?MasterTagID=8055&FromWhere=PM&PageNumber=" + page;
			objForm.submit();
            RemoveFrameLoader();
	    }
	
	    function txtPageNumber_KeyPress(e)
	    {
		    var code;
		    if (e.keyCode) 
			    code = e.keyCode;
		    else
			    if (e.which) 
				    code = e.which;
					
		    if(code==13) 
		    {
			    var objtxtpageNumber =  GetObjectReference('frmMapReviewTasks','txtPageNumber');
			    var objtxtNoOfPages = GetObjectReference('frmMapReviewTasks','txtNoOfPages');
			    
////                      if (isTaskChanged == "1")
////                      {
////                        if(confirm("Are you sure you to navigate without saving the selected tasks?")==false)
////                            return;
////                      }
			    if (!disallowBlank(objtxtpageNumber,"Please enter the page number",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
			    {	
				    if (Number(objtxtpageNumber.value) ==0)
				    {
					    alert("Page number should be greater than zero!");
					    return;
				    }
				    if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
				    {
					    alert("Invalid Page Number.");
					    return;
				    }
				    Page_OnClick(objtxtpageNumber.value);
			    }	
		    }
		
	    }
	
	  
	        var noOfPages = GetObjectReference('frmMapReviewTasks','hidNoOfPages').value;
            var objtxtpageNumber =  GetObjectReference('frmMapReviewTasks','txtPageNumber');
      
        function validateNumPaging()
        {

            if(isNaN(objtxtpageNumber.value))
            {
	            alert("Please enter numeric value");
	            return false;
            }
        	
            if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
            {
	            alert("Please enter value within range of 1 to "+noOfPages);
	            return false;
            }
            return true;
        }
        function ShowPreviousPage()
        {
            if (isBlank(objtxtpageNumber.value))
            {
                Page_OnClick(1);   
            }
            else
            {
	            if(!validateNumPaging())
	            return;
        		
	            if (objtxtpageNumber.value==1){alert("This is the first page");return;}
                objtxtpageNumber.value=objtxtpageNumber.value -1;
	            Page_OnClick(objtxtpageNumber.value);
            }
        		
        }
        function ShowFirstPage()
        {
            if (isBlank(objtxtpageNumber.value))
            {
	          Page_OnClick(1);
	        }
            else
            {
	            if(!validateNumPaging())
	            return;
	            if (objtxtpageNumber.value==1){alert("This is the first page");return;}
	             
	            objtxtpageNumber.value=1;
	            Page_OnClick(objtxtpageNumber.value);
            }
        }
        function ShowNextPage()
        {
            
            if (isBlank(objtxtpageNumber.value))
	            Page_OnClick(1);
            else
            {
	            if(!validateNumPaging())
	            return;
	            if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
	             
		        objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
	            Page_OnClick(objtxtpageNumber.value);
            }
        }
        function ShowLastPage()
        {
            if (isBlank(objtxtpageNumber.value))
	            Page_OnClick(noOfPages);
            else
            {	
	            if(!validateNumPaging())
	            return;
	            if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
	            
	            objtxtpageNumber.value=noOfPages;
	            Page_OnClick(objtxtpageNumber.value);
            }
        }

        </script>
</body>
</HTML>