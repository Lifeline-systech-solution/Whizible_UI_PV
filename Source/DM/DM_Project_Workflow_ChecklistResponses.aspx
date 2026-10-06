<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="DM_Project_Workflow_ChecklistResponses.aspx.vb" Inherits="PbNIT.DM_Project_Workflow_ChecklistResponses" %>

<!DOCTYPE html>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Checklist Item")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
    
    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
     

<script src="../../responsive/responsive.js"></script>
     
     <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    
    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
  
  
       <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />

     <!-- custom style -->
  
   <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom.css" />
 
   <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?v=2.8" />

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    #DivMain {
        height:440px!important;
    }

     .alertify-notifier {
            z-index: 99999 !important;
            font-size:12px !important;
        }

        .responsive_clsTRMenu li:nth-child(3) {

            display:none

        }

        .responsive_clsTRMenu li:nth-child(2) {

            display:none

        }

           .footer_responsive_clsTRMenu li:nth-child(3) {

            display:none

        }

        .footer_responsive_clsTRMenu li:nth-child(2) {

            display:none

        }



/*13-11-2019 - added by pradip*/
TR.clsTRMenu{BACKGROUND: #e7edf0 !important; height:34px;}
TR.clsTRMenu li{ margin:0 0 0 5px;border: none;}
TR.clsTRMenu a.Menu {
    font-weight: 700;
    padding: 4px 14px;
    border: 1px solid #1359ac!important;
    color: #1359ac;
    border-radius: 4px;
    text-shadow: none;
    margin: 0 0px; transition:0.4s ease-in-out 0s;
}
    TR.clsTRMenu li:first-child a.Menu {background: #fbb03b; border: 1px solid #fbb03b!important;
    color: #fff;
    }
        TR.clsTRMenu li:first-child a.Menu:hover {background: #e29214!important; border: 1px solid #e29214!important;
    color: #fff;
        }
.clsTable td a {
    color: #1359ac;
}

.clsTable td { padding:4px;
        }
TR.clsTRSectionHeader, TR.clsTRColumnHeader {BACKGROUND-COLOR: #e7edf0 !important;
        }
    .clsGridTable td { padding:8px!important;
    }
    /* Added By Gauri On 30th Aug 2024 For Alignment Issue */
    /* .clsGridTable tbody tr td:last-child{
        text-align: left;
    } */
    /* End of Added By Gauri On 30th Aug 2024 For Alignment Issue */
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



	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload();">
		<form id="frmWorkflowChecklist" name="frmWorkflowChecklist" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
				
			var objform;
			objform=GetFormReference('frmWorkflowChecklist');
			var objDivMain = GetObjectReference('frmWorkflowChecklist','DivMain');
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function window_onload()		
			{ 
				var intDivHeight ;
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop-40;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;
				
			}
			
			function EnterComments_OnClick (intChecklistItemID ,intContextID ,strReviewer,blnMappedToReviewIssue)
			{
				if(blnMappedToReviewIssue == "1")
					window.open ("AddChecklistComments.aspx?Mode=Edit&ChecklistItemId=" & intChecklistItemID & "&ContextId=" & intContextID & "&Reviewer=" & strReviewer , "_new", "resizable=yes,scrollbars=yes,left=" & (window.screen.width - 550)/2 & ",top=" & (window.screen.height - 300)/2 & ",width=550,height=300");
				else	
					//alert('<%=MyBase.GetResourceString("CAP_ISSUE_MAPPINT_MISSING_ALERT")%>');
						   alertify.set('notifier', 'position', 'top-right');
                          alertify.notify('<%=MyBase.GetResourceString("CAP_ISSUE_MAPPINT_MISSING_ALERT")%>', 'error', 25);					
			}
			function Save_OnClick()
			{
				
					
					if("<%=m_intChecklistID%>"=="0")
						{
						  // alert('<%=MyBase.GetResourceString("MSG_NO_CHK")%>')
                           alertify.set('notifier', 'position', 'top-right');
                          alertify.notify('<%=MyBase.GetResourceString("MSG_NO_CHK")%>', 'error', 25);
						return;
						}
						
						
				
					var hdnChecklistItemCount,hdnRadioButtonsCount,hdnCheckBoxesCount;
					
			
					
					hdnChecklistItemCount=GetObjectReference('frmWorkflowChecklist','hdnChecklistItemCount');
					hdnRadioButtonsCount=GetObjectReference('frmWorkflowChecklist','hdnRadioButtonsCount');
					hdnCheckBoxesCount=GetObjectReference('frmWorkflowChecklist','hdnCheckBoxesCount');
					
					var intTotCount,intRadioButtons,intCheckBoxes;
					intTotCount=0;
					intRadioButtons=0;
					intCheckBoxes=0;
					
					
					if(hdnChecklistItemCount!=null)
						intTotCount=parseInt(hdnChecklistItemCount.value,10);
						
					if(hdnRadioButtonsCount!=null)
						intRadioButtons=parseInt(hdnRadioButtonsCount.value,10);
					if(hdnCheckBoxesCount!=null)
						intCheckBoxes=parseInt(hdnCheckBoxesCount.value,10);
						
						if(intTotCount==0)
						{
						//alert('<%=MyBase.GetResourceString("MSG_NO_RESP")%>')
                              alertify.set('notifier', 'position', 'top-right');
                          alertify.notify('<%=MyBase.GetResourceString("MSG_NO_RESP")%>', 'error', 25);	
						return;
						}
					
					
									
						
						
						
						var intSelRadios=0;
						var intIssues=0;
						
						if(intTotCount>0)
						{
							var intCtr=0;
							var strItem;				
								
							if(intTotCount==1)			
							{
							    var intCtr1;
                                //Commented And Added By Vaijat K ON 09/12/2015 Issue ID-2663
								//var hdnQuestionnaireQuestionID = GetObjectReference('frmWorkflowChecklist', 'hdnQuestionnaireQuestionID');
								var hdnQuestionnaireQuestionID = document.getElementsByName('hdnQuestionnaireQuestionID');
								var hdnNegativeResponseId=GetObjectReference('frmWorkflowChecklist','hdnNegativeResponseId');
								if(hdnQuestionnaireQuestionID!=null)
								    strItem = "optOption" + Left(hdnQuestionnaireQuestionID[0].defaultValue, hdnQuestionnaireQuestionID[0].defaultValue.length - 1);
								var radios=GetObjectReference('frmWorkflowChecklist',strItem,true);
								if(radios!=null)
								{
									for(intCtr1=0;intCtr1<radios.length;intCtr1++)
									{
										if(radios[intCtr1].checked==true)
										{
											intSelRadios=1;
											if(hdnNegativeResponseId!=null)
											{
												
												if(radios[intCtr1].value==hdnNegativeResponseId.value )
													intIssues=1;
											}
										}
									}
								}
							}
							else
							{
								var hdnQuestionnaireQuestionID=GetObjectReference('frmWorkflowChecklist','hdnQuestionnaireQuestionID',true);
								var hdnNegativeResponseId=GetObjectReference('frmWorkflowChecklist','hdnNegativeResponseId',true);
								for(intCtr=0;intCtr<hdnQuestionnaireQuestionID.length;intCtr++)
								{
									strItem="";
									if(hdnQuestionnaireQuestionID[intCtr]!=null)
										strItem = "optOption" + Left(hdnQuestionnaireQuestionID[intCtr].value,hdnQuestionnaireQuestionID[intCtr].value.length-1);
									var radios=GetObjectReference('frmWorkflowChecklist',strItem,true);
									if(radios!=null)
									{
										for(intCtr1=0;intCtr1<radios.length;intCtr1++)
										{
											if(radios[intCtr1].checked==true)
											{
												intSelRadios+=1;
												if(hdnNegativeResponseId[intCtr]!=null)
												{
												
													if(radios[intCtr1].value==hdnNegativeResponseId[intCtr].value )
														intIssues+=1;
														
												}
											}
										}
									}
										
								}
								
							}
						
						if(intSelRadios<intRadioButtons)
							{
							//alert('<%=MyBase.GetResourceString("MSG_SEL_ALL")%>')
                             alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('<%=MyBase.GetResourceString("MSG_SEL_ALL")%>', 'error', 25);	
							return;
							}
							
							
									
						}
					
						
				//End addition by DipaliS
				//Modified by Noble K on 17th Jan 2005 
				//Changed the MSG_CONFIRM to MSG_CONFIRM_NEW
				var strMsg='<%=MyBase.GetResourceString("MSG_CONFIRM_NEW")%>';
				//var strMsg='<%=MyBase.GetResourceString("MSG_CONFIRM")%>';
				//strMsg=strMsg.replace("<intIssues>",intIssues);
				if(window.confirm(strMsg)==true)
				{ 
				
				    //Added By Sanyogeeta R on 12-Oct-2016 For Page Loader
				    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
				    var MenuTags = document.getElementsByTagName('A');
				    for (i = 0; i < MenuTags.length; i++) {
				        if (MenuTags[i].className == "Menu") {
				            //MenuTags[i].style.display= "none";
				            MenuTags[i].parentNode.style.display = "none";
				        }
				    }
				    setFrameLoader();//ADDED BY Sanyogeeta  R ON 12/2/2016 FOR SAVE ISSUE  
				    // End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
				    //End Of Addition By Sanyogeeta R on 12-Oct-2016 For Page Loader
                       //added & Commented By Dipali v On 14th Nov 2019 For New page
				objform.action="../DM/DM_Project_Workflow_ChecklistResponses.aspx?Action=Save";
				objform.submit();

                 //Added by Dipali V On 22nd Jan 2021 For Refresh Parent Page  
				window.onunload = refreshParent;
                    function refreshParent() {
                        window.opener.location.reload();
                    }
				//refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG&SubTagPagingAlphabet=&SubTagSortBy=&SubTagSortOrder=&SubTagID=2106');
				//End_MV_7/25/2007
                //End of Added by Dipali V On 22nd Jan 2021 For Refresh Parent Page
				}
				
			}
			function Add_OnClick()
			{
			    //ADDED BY Sanyogeeta  R ON 12/2/2016 For Page Loader
			    setFrameLoader();
			    //End Of Addition BY Sanyogeeta  R ON 12/2/2016 For Page Loader
                //added & Commented By Dipali v On 14th Nov 2019 For New page
				//objform.action="../DM/DM_Workflow_ChecklistResponses.aspx?Mode=ADD";
                //objform.action = "../../DM/DM_Project_Workflow_ChecklistResponses.aspx?Mode=ADD";
                 objform.action="../DM/DM_Project_Workflow_ChecklistResponses.aspx?Mode=ADD";
                objform.submit();	
                   //added & Commented By Dipali v On 14th Nov 2019 For New page
			}
			function Back_OnClick()
			{
			    //ADDED BY Sanyogeeta  R ON 12/2/2016 For Page Loader
			    setFrameLoader();
			    //End Of Addition BY Sanyogeeta  R ON 12/2/2016 For Page Loader
                   //added & Commented By Dipali v On 14th Nov 2019 For New page
               // objform.action = "../DM/DM_Workflow_ChecklistResponses.aspx?Mode=VIEW";
                objform.action="../DM/DM_Project_Workflow_ChecklistResponses.aspx?Mode=VIEW";
                objform.submit();	
                   //added & Commented By Dipali v On 14th Nov 2019 For New page
			}
			function Checklist_OnClick(RespondedBy,StageID,ChecklistID)
			{
			    //ADDED BY Sanyogeeta  R ON 12/2/2016 For Page Loader
			    setFrameLoader();
			    //End Of Addition BY Sanyogeeta  R ON 12/2/2016 For Page Loader
                   //added & Commented By Dipali v On 14th Nov 2019 For New page
               // objform.action = "../DM/DM_Workflow_ChecklistResponses.aspx?Mode=EDIT&RespondedBy=" + RespondedBy + "&RequestStageID=" + StageID + "&CheckListID=" + ChecklistID;
                objform.action="../DM/DM_Project_Workflow_ChecklistResponses.aspx?Mode=EDIT&RespondedBy="+RespondedBy+"&RequestStageID="+StageID+"&CheckListID="+ChecklistID;
                objform.submit();	
                   //added & Commented By Dipali v On 14th Nov 2019 For New page
			}
		</script>
	</body>
</HTML>

