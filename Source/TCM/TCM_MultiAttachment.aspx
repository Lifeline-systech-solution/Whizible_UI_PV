<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TCM_MultiAttachment.aspx.vb" Inherits="PbNIT.TCM_MultiAttachment"%>
<!DOCTYPE HTML>
<HTML>
	 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("")%>
<%--	<%CommonFunctions.General.PlotPageHeadTag("Attachment")%>
<script type="text/javascript" src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By Yogesh Jalamkar on 18th-September-2015 for Responsive Page--%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id='frmAttachment' method='post' enctype='multipart/form-data'>
						
									<%WritePage()%>
								
					</form>
				
					<script language="javascript">
		var objForm;
		var objdivlist;
		
		objForm = GetFormReference('frmAttachment');
		objdivlist = GetObjectReference('frmAttachment','divList');
		
		    <%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
		
		function Attach_OnClick(strID, strFromWhere, intProjectID)
		{
		
			var strQueryString;
			
			var i;
			var objFileName 
			
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			if (objFileGrid.rows.length==1)
			{
			 alert("Please select the file !")
			 return;
			}
			
			for (i=0;i<FileCount;i++)
			{
				objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
				if (objFileName!=null)
				{
					if (disallowBlank(objFileName,"Please select the file")	) {return;}
					if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
				}
			}
			
			objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
			if (objFileName !=null)
				objFileName.disabled=true;
			
			
			
	
			var objtblFileAttachment = GetObjectReference('frmAttachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmAttachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
			
			strQueryString = "../TCM/TCM_MultiAttachment.aspx?Action=ATTACH"
			if (GetObjectReference('frmAttachment','hidIssueID').value != '')
				if(confirm("One Issue belongs to this test case. \nDo you want to transfer attachements to this issue?"))
				strQueryString = "../TCM/TCM_MultiAttachment.aspx?Action=ATTACH&Mode=ATTACHIB"
		    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
			var MenuTags = document.getElementsByTagName('A');
			for (i = 0; i < MenuTags.length; i++) {
			    if (MenuTags[i].className == "Menu") {
			        //MenuTags[i].style.display= "none";
			        MenuTags[i].parentNode.style.display = "none";
			    }
			}
		    setFrameLoader();  
		    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
				
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

		function window_onload()
		{
		
		
		
		
			var ProjectTestCaseID = GetObjectReference('frmAttachment','ProjectTestCaseID');
			var objhidTotalAttachedFiles = GetObjectReference('frmAttachment','hidTotalAttachedFiles');
			
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			if (intDivHeight < 100)	intDivHeight = 100;
		    //Comment added on 11 Dec 2015 by Viraj P
		    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';

			<% if m_strAction = "ATTACH" OR m_strAction = "DELETE" then %>
						window.opener.window.setAttachmentNo('lblAtt'+ProjectTestCaseID.value,objhidTotalAttachedFiles.value);
			<%end if %>
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			if (intDivHeight < 100)	intDivHeight = 100;
		    //Comment added on 11 Dec 2015 by Viraj P
		    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';

		}
		
		
		var FileCount=0;
		var FileCount_toDisable = 0;
		function addFileinGrid()
		{
			
			var objtxtFileName = GetObjectReference('frmAttachment','txtFileName'+FileCount);
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			objFileGrid.style.display="";
			var newRow  = objFileGrid.insertRow(objFileGrid.rows.length);
		
			newRow.id='FILENAME'+FileCount;
			newRow.name='txtFileName';
			newRow.className = "clsTREven";
			var newCell = newRow.insertCell(0);
			
			var fileName = objtxtFileName.value;
			var index = fileName.lastIndexOf("\\");
			if (index==-1)
			index = fileName.lastIndexOf("/");
			
			if (index != -1)
				fileName = fileName.substring(index+1,fileName.length);
				
		
			newCell.innerHTML=fileName;
			newCell = newRow.insertCell(1);
			
			
			newCell.innerHTML="<A class='Menu' style='' HREF='Javascript:RemoveAttachement("+ FileCount +")' Title='Remove Attachment' >(Remove)</A>";
			
			parentTD = objtxtFileName.parentNode;
			objtxtFileName.style.display = "none";
			
			FileCount++;
			FileCount_toDisable++;
			
			var FileControl;
			FileControl=document.createElement("INPUT");
			FileControl.type="FILE";
			FileControl.id="txtFileName"+FileCount;
			FileControl.name="txtFileName"+FileCount;
			FileControl.className = 'clsTextBox';
			FileControl.size=74;
			
			FileControl.onkeydown=function(){return false;};
			FileControl.onbeforepaste=function(){return false;};
			FileControl.onpaste=function(){return false;}; 
			FileControl.onkeydown=function(){return txtFileName_onkeydown();}; 
			FileControl.onbeforepaste=function(){return txtFileName_onbeforepaste();}; 
			FileControl.onpaste=function(){return txtFileName_onpaste();}; 
			FileControl.onchange=addFileinGrid;
			
						
			if (FileCount_toDisable==3)
			FileControl.disabled=true;
			
			parentTD.appendChild(FileControl);
			//FileControl.fireEvent('onclick');
			
			
			
			
		}
		function RemoveAttachement(FileNO)
		{
			
			var objTR = GetObjectReference('frmAttachment','FILENAME'+FileNO); 
			var toRemoveFileControl = GetObjectReference('frmAttachment','txtFileName'+FileNO); 
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			
			objFileGrid.deleteRow(objTR.rowIndex);
			
			toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
			GetObjectReference('frmAttachment',"txtFileName"+FileCount).disabled=false;; 
			
			
			if (objFileGrid.rows.length==1)
			{
			 objFileGrid.style.display='none';
			}
			
			FileCount_toDisable--;
		}
		
		function DeleteAttachment()
		{
			var objchkDelete = GetObjectReference('frmAttachment','chkDelete',true); 
			var counter=0;
			var isAnyCheckBoxSelected = false;
			while(objchkDelete.length > counter)
			{
				if (objchkDelete[counter].checked == true)
				{		isAnyCheckBoxSelected=true; break;	 }
				counter++;
			}
			if (isAnyCheckBoxSelected == false)
			{		alert("Please select attachment(s) to delete"); return; }
		
		    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
			
			setFrameLoader();
		    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose::For Multiple Save Issue
			objForm.action = "../TCM/TCM_MultiAttachment.aspx?Action=DELETE";
			objForm.submit();
		}
		function showAttachment(src)
		{
		
		window.open("../General/ViewAttachment.aspx?FileName="+src+"&FromWhere=TCM/TestCaseResponses");
		}
					</script>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
