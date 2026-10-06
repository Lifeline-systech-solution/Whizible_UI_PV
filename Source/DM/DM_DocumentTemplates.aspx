<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DM_DocumentTemplates.aspx.vb" Inherits="PbNIT.DM_DocumentTemplates" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Document Settings")%>


<!--Including files & Libraries by Miiint Solutions-->
   
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
  
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>



	<body MS_POSITIONING="GridLayout" class='clsBody' onresize="window_onresize()" onload="window_onload()">
					<form id="frmDocumentTemplates" name="frmDocumentTemplates" method="post" runat="server"
						enctype='multipart/form-data'>
									<%PageInit()%>
					</form>
					
			<script language="javascript">
			var objdivlist;
			var objform;
							
			objform = GetFormReference('frmDocumentTemplates');
			objdivlist = GetObjectReference('frmDocumentTemplates','DivList');
			
			'<%MyBase.InitializeResources("AppResources.DM_DocumentTemplates", "AppResources")%>';
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
			
			if ('Template' != '<%=m_strMode%>')	
			{
				cboCategory_OnChange();	
				objCbo = GetObjectReference('frmDocumentTemplates','cboSubCategory');
			}	
			
			if (objdivlist)
				{
					if(navigator.appName == 'Netscape')
					{		  
						intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
					}
					else
					{
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					}
						if (intDivHeight < 100)
						intDivHeight = 100;
						objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	;	
				}	
				
				var objApplicable = GetObjectReference('frmDocumentTemplates','chkApplicable');
				var objMandatory = GetObjectReference('frmDocumentTemplates','chkMandatory');
				
				
				if (objApplicable)
				{
					Applicable_OnClick(objApplicable)
				}	
				if (objMandatory)
				{
					var Ischecked = objMandatory.checked; 
					if (Ischecked==true)
					{
						objMandatory.disabled=false;
						objMandatory.checked=true;
					}
				}	
				


			}
				
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (objdivlist)
				{
					if(navigator.appName == 'Netscape')
					{		  
						intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
					}
					else
					{
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					}
					if (intDivHeight < 100)
						intDivHeight = 100;
					objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	;	
				}	
			}	
			
					
			function cboCategory_OnChange()
			{
				var intCounter;
				var strString;
				var arrCatID
				var strCat
				
				//Populate Sub Category combo for selected category
				objCbo = GetObjectReference('frmDocumentTemplates','cboCategory');	
				strString="	<select id=cboSubCategory name=cboSubCategory class=clsComboBox style='height=70px; width=250px'> ";								
				
				
				strString = strString + "<OPTION value =''" + "></OPTION>"
				for(intCounter=0;intCounter<  arrsubCategories.length;intCounter++) {
					
					strCat=arrsubCategories[intCounter]
					arrCatID =strCat.split(",");
					//alert(arrCatID[0]);
					if(arrCatID[0]==objCbo.value)
					{ 
					
						if ( arrCatID[1]=='<%=strSubCategory%>')
						{
							strString=strString + "  <option  selected value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
						}
						else
						{
							strString=strString + "  <option value=  " + arrCatID[1] + " > " + arrCatID[2] + " </option>" ;
						}
						
					}		
				}	
				//strString=strString + " </select><IMG src='../../Images/Star.gif' border=0> "    
				document.all.tdSubCategory.innerHTML=strString;								
			} 
			
		
			function Upload_OnClick()
			{
				var objCbo,objTxt,objSubCbo;
				var flag;
				
//				objTxt = GetObjectReference('frmDocumentTemplates','txtTemplateName');	
//				flag = disallowBlank(objTxt,'Enater Template Name to upload document.',true);
//				if(flag==true)
//					return;
//				
//				objTxt = GetObjectReference('frmDocumentTemplates','txtFileName');	
//				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_FILE_EMPTY")%>',true);
//				if(flag==true)
//					return;
					
				objCbo = GetObjectReference('frmDocumentTemplates','cboCategory');	
				flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_CATEGORY_EMPTY")%>',true);
				if(flag==true)
					return;
				
//				objSubCbo = GetObjectReference('frmDocumentTemplates','cboSubCategory');	
//				flag = disallowBlank(objSubCbo,'Select Document Sub Category',true);
//				if(flag==true)
//					return;
						
				objTxt = GetObjectReference('frmDocumentTemplates','txtDescription');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DESC_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = disallowMaxlengthViolation(objTxt,3000,'<%=MyBase.GetResourceString("MSG_DESC_MAX_LEN")%>',true);
				if(flag==true)
					return;
				
//				var objTbl = GetObjectReference('frmDocumentTemplates','tblMsg');	
//				objTbl.style.display='';
				document.body.style.cursor = "wait";
				objform.action="DM_DocumentTemplates.aspx?&Action=Upload&NatureOfDemandID=<%=m_NatureOfDemandID%>&RequestStageID=<%=m_RequestStageID%>";
				objform.submit();
				
				
			}

												
			// To Make the Document Sub category as blank when the page loads
			var objDocumentSubCategory = GetObjectReference('frmDocumentTemplates','cboSubCategory');	
			if (objDocumentSubCategory != null )
			{
				objDocumentSubCategory.length=0;
			}
						
			function Delete_OnClick()
			{
				var intRowCnt,i,blnSelected=false,ans;
					var objChk;
					
					objChk = GetObjectReference('frmDocumentTemplates','chkDelete',true);	
					intRowCnt = objChk.length;
					
					if(intRowCnt>0)
						for(i=0;i<intRowCnt;i++)
							if(objChk[i].checked==true)
								{
									blnSelected=true;
									break;  
								}

					if(blnSelected==false)
					{
						alert('<%=mybase.GetResourceString("MSG_NO_RECORD_SELECTED")%>');
						return;
					}
					ans = window.confirm('<%=mybase.GetResourceString("MSG_DELETE_CONFIRM")%>'); 
					if(ans==true)
					{
						objform.action="DM_DocumentTemplates.aspx?Mode=Delete&NatureOfDemandID=<%=m_NatureOfDemandID%>&RequestStageID=<%=m_RequestStageID%>";
						objform.submit();
					}	
			}
			
			function Template_OnClick(TemplateID)
			{
				objform.action="DM_DocumentTemplates.aspx?Mode=Edit&NatureOfDemandID=<%=m_NatureOfDemandID%>&RequestStageID=<%=m_RequestStageID%>&TemplateID="+ TemplateID;
				objform.submit();
			}
			
			function Save_OnClick(TemplateID)
			{
			
//				objTxt = GetObjectReference('frmDocumentTemplates','txtTemplateName');	
//				flag = disallowBlank(objTxt,'Enater Template Name to upload document.',true);
//				if(flag==true)
//					return;
//			
//				objTxt = GetObjectReference('frmDocumentTemplates','txtFileName');	
//				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_FILE_EMPTY")%>',true);
//				if(flag==true)
//					return;
					
				objCbo = GetObjectReference('frmDocumentTemplates','cboCategory');	
				flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_CATEGORY_EMPTY")%>',true);
				if(flag==true)
					return;
	// Commented by MahendraV on 17-Nov-2008 for WhizibleSEM8_Whiz3
	// Purpose :IssueID (23673) Project Creation Workflow : Process > Workflows > Required Documents : In edit mode mandatory check for Sub Category is present
	//          To removed validation check for sub category.
	            
	// Start_MV_17-Nov-2008
				/*objSubCbo = GetObjectReference('frmDocumentTemplates','cboSubCategory');	
				flag = disallowBlank(objSubCbo,'Select Document Sub Category',true);
				if(flag==true)
					return;*/
	// End_MV_17-Nov-2008					
				objTxt = GetObjectReference('frmDocumentTemplates','txtDescription');	
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DESC_EMPTY")%>',true);
				if(flag==true)
					return;
					
				flag = disallowMaxlengthViolation(objTxt,3000,'<%=MyBase.GetResourceString("MSG_DESC_MAX_LEN")%>',true);
				if(flag==true)
					return;
				objform.action="DM_DocumentTemplates.aspx?Mode=Save&NatureOfDemandID=<%=m_NatureOfDemandID%>&RequestStageID=<%=m_RequestStageID%>&TemplateID="+TemplateID;
				objform.submit();
			}
			
			function DownloadTemplate(TemplateID)
			{
				window.open("DM_ViewDocument.aspx?DemandID=<%=m_NatureOfDemandID%>&StageID=<%=m_RequestStageID%>&RevisionID=<%=m_RevisionID%>&FromWhere=Template&DocumentID=" + TemplateID ,"","left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=300");
				
				
			}
			function Applicable_OnClick(obj)
			{
				//debugger;
				var objMandatory = GetObjectReference('frmDocumentTemplates','chkMandatory');
				//objMandatory.checked = false;
				if (obj.checked==true)
				{
					objMandatory.disabled=false;
				}
				else
				{
					objMandatory.checked = false;
					objMandatory.disabled=true;
				}
				
			}
					
</script>
 </body>
</HTML>
