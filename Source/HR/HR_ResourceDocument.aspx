<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_ResourceDocument.aspx.vb" Inherits="PbNIT.HR_ResourceDocument" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<%CommonFunctions.General.PlotPageHeadTag("Documents")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>

<script src="../../responsive/responsive.js"></script>
   <script src="../General/CommonFunctions.js"></script>
<link href="../General/loaderStylesheet.css" rel="stylesheet" />
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
</style>
<html>
<!-- <%CommonFunctions.General.PlotPageHeadTag("Documents")%> -->
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
   



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

<body class="clsBody" onresize="window_onresize()" onload="window_onload()" ms_positioning="GridLayout">


    <form id="frmResourceDocuments" name="frmResourceDocuments" method="post" enctype="multipart/form-data"
        runat="server">

        <%PageInit()%>
    </form>

    <script language="javascript">
        var objform, objdivlist;
        objform = GetFormReference('frmResourceDocuments');
       
        //Commented and addede by nilesh g on 5/12/2015 for issue id 2639
        //  objdivlist = GetObjectReference('frmResourceDocuments', 'DivList');
        //Added by Yogesh J on 15/12/2015 
        var mode = getParameterByName('Mode');
        if (mode == 'UPLOAD') {
            objdivlist = GetObjectReference('frmResourceDocuments', 'DivList');
        }
        else if (mode == 'URL') {
            objdivlist = GetObjectReference('frmResourceDocuments', 'divList');
        }
        else {
            objdivlist = GetObjectReference('frmResourceDocuments', 'DivList');
        }
        //end of addition by Yogesh J on 15/12/2015 
       
        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

        function window_onload() {
            //Mode=<%=CONST_MODE_ATTACHURL%>&Action=<%=CONST_ACTION_ATTACHURL%>
		<% If ((Request.QueryString("Mode") = CONST_MODE_UPLOAD And Request.QueryString("Action") = CONST_ACTION_UPLOAD) Or (Request.QueryString("Mode") = CONST_MODE_ATTACHURL And Request.QueryString("Action") = CONST_ACTION_ATTACHURL)) Then%>
	    var strParentPage = new String();
	    if (window.opener != null) {
	        var MtagID = '<%=m_strOpenerTagID%>'

		    if (MtagID != "") {
		        var objTokenPK = window.opener.document.getElementById('PKToken');
		        var objIDPK = window.opener.document.getElementById('OpportunityID_PK');
		        strParentPage = '../HR/HR_Opportunity_CommonPage.aspx?';
		        strParentPage = strParentPage + 'OpportunityID_PK=' + objIDPK.value + '&PKToken=' + objTokenPK.value;
		        strParentPage = strParentPage + '&MasterTagID=' + MtagID + '&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';

		        refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage)
		    }
		    window.close();
		}
		<%End If%>

	    var intDivHeight;
	    var intDivHeightRisk;
	    strIsReview = '<%=Request.Querystring("IsReview")%>';

		if (navigator.appName == 'Netscape') {
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		}
		else {
		    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		}
		if (intDivHeight < 100)
		    intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';
    }

    function window_onresize() {
        var intDivHeight;
        var intDivHeightRisk;

        if (navigator.appName == 'Netscape') {
            intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
        }
        else {
            intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        }
        if (intDivHeight < 100)
            intDivHeight = 100;
        objdivlist.style.height = intDivHeight +'px';
    }



    function UploadDoc_OnClick() {
        window.open("../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>", "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=400");
	}

	function AttachURL_OnClick() {
	    window.open("../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>", "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=350");
	}


	function cboCategory_OnChange() {
	    var url;
	    var CatID = GetObjectReference('', 'cboCategory').value;
	    url = new String();
	    url = ""


	    url = "../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>&FromXML=1&CategoryID=" + CatID;

		loadXMLDoc(url, '');
		return;

    }

    function loadXMLDoc(url, reqQuery) {
        if (window.XMLHttpRequest) {
            xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = state_Change;
            if (ns) {
                xmlhttp.open('GET', url, true);
                xmlhttp.send(null);
            }
            else {
                xmlhttp.open('POST', url, false);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery);
            }
        }
        else if (window.ActiveXObject) {
            xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
            if (xmlhttp) {
                xmlhttp.onreadystatechange = state_Change;
                xmlhttp.open('POST', url, false);
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(reqQuery);
            }
        }

    }

    function state_Change() {
        if (parseInt(xmlhttp.readyState) == 4) {
            if (xmlhttp.status == 200) {

                GetObjectReference('', 'tdSubCategory').innerHTML = xmlhttp.responseText;
            }
        }
    }

    function cboAttachCategory_OnChange() {
        var url;
        var CatID = GetObjectReference('', 'cboAttachCategory').value;
        url = new String();
        url = ""


        url = "../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&FromXML=1&CategoryID=" + CatID;

		loadXMLDoc(url, '');
		return;


    }

        function Upload_OnClick() {
            var objCbo, objTxt, objDesc;

            objTxt = GetObjectReference('frmResourceDocuments', 'txtFileName');
            if (disallowBlank(objTxt) == true) {
                alert('Select document to upload.');
                objTxt.focus();
                return;
            }

            //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
            var countOfDot, FileNameCharCount;
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
            var intActualFileSize = (objTxt.files['0'].size);
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
            var validateExtensions;

            validateExtensions = strFileExtension.split(",");
            if (strFileExtension.length > 0) {
                var allowSubmit = false;
                var file = objTxt.value;
                var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

                for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                    var strExtn;
                    strExtn = validateExtensions[cnt];
                    if (strExtn.toLowerCase() == extension)
                    //Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
                    //{ allowSubmit = false; }
                    { allowSubmit = true; }
                    //End of Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
                }
                if (allowSubmit == false) {
                    alert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
                    return false;
                }
            }

            if (objTxt.files['0'].name != '')
                var countOfDot = objTxt.files['0'].name.split(".").length - 1;

            if (countOfDot > 1) {
                alert('File with two or more extensions is not allowed!');
                return false;
            }

            if (objTxt.files['0'].name != '')
                FileNameCharCount = objTxt.files['0'].name.split(".")[0].length;

            if (FileNameCharCount > 120) {
                alert('File name should not exceed 120 characters!');
                return false;
            }

            if (intActualFileSize < intMinFileSize) {
                alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                return false;
            }

            //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement

            objCbo = GetObjectReference('frmResourceDocuments', 'cboCategory');
            if (disallowBlank(objCbo) == true) {
                alert('Select document Category.');
                objCbo.focus();
                return;
            }

            objDesc = GetObjectReference('frmResourceDocuments', 'txtDescription');
            if (disallowBlank(objDesc) == true) {
                alert('Enter description for document.');
                objDesc.focus();
                return;
            }
            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            
            setFrameLoader();
            
            setTimeout(function () {
            }, 3000);
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            objform.action = "../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>&Action=<%=CONST_ACTION_UPLOAD%>";
            objform.submit();
        }

  function Attach_OnClick() {
      var objAttachCbo, objAttachURL, objAttachDesc;
      var flag;

      objAttachURL = GetObjectReference('frmResourceDocuments', 'txtURL');
      if (disallowBlank(objAttachURL) == true) {
          alert('Please enter URL.');
          objAttachURL.focus();
          return;
      }

      flag = IsValidURL(objAttachURL.value)
      if (flag == false) {
          alert('Please enter valid URL.');
          flag = true;
          objAttachURL.focus();
          return;
      }

      objAttachCbo = GetObjectReference('frmResourceDocuments', 'cboAttachCategory');
      if (disallowBlank(objAttachCbo) == true) {
          alert('Select document Category.');
          objAttachCbo.focus();
          return;
      }

      objAttachDesc = GetObjectReference('frmResourceDocuments', 'txtDescription');
      if (disallowBlank(objAttachDesc) == true) {
          alert('Enter description for document.');
          objAttachDesc.focus();
          return;
      }
      //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
      setFrameLoader();
      // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
      objform.action = "../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&Action=<%=CONST_ACTION_ATTACHURL%>";
	  objform.submit();
  }

  function Download_OnClick(DocID) {

      window.open("../HR/HR_ResourceDocument.aspx?DocumentID=" + DocID + "&Mode=<%=CONST_MODE_HISTORY%>&Action=<%=CONST_ACTION_HISTORYDOWNLOAD%>", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=600,height=400")
	}

    </script>

</body>
</html>
