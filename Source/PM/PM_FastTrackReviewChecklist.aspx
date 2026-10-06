<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_FastTrackReviewChecklist.aspx.vb" Inherits="PbNIT.PM_FastTrackReviewChecklist" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag("Checklist Item")%>
		
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
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


		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<script language='javascript' src='../General/CommonFunctions.js'></script>
		<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
	</HEAD>
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_resize()">
		<form id="frmChecklist" name="frmChecklist" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
				
			/*var objform;
			objform=GetFormReference('frmChecklist');*/
			var objDivMain = GetObjectReference('frmTaskSelection','DivMain');
			
			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			function window_onload()		
			{
			  
			    var intDivHeight;
			    if (objDivMain != null) {
			        //Commented by Yogesh J on 08/01/2016
			        //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop-40;
			        intDivHeight = window.innerHeight - objDivMain.offsetTop;
			        //End of addition by Yogesh J 08/01/2016
			        if (intDivHeight < 100)
			            intDivHeight = 100;
			        //Commented and added by Yogesh J on 11/12/2015
			        //objDivMain.style.height = intDivHeight;
			        objDivMain.style.height = intDivHeight + 'px';
			       
			    }
			  

				
			}

		    //Commented by Yogesh J on 08/01/2016
			function window_resize() {
			    var intDivHeight;
			    if (objDivMain != null) {
			       
			        intDivHeight = window.innerHeight - objDivMain.offsetTop;
			        if (intDivHeight < 100)
			            intDivHeight = 100;
			          objDivMain.style.height = intDivHeight + 'px';
			    }
			}
		    //End of addition by Yogesh J 08/01/2016

			
			function EnterComments_OnClick (intChecklistItemID ,intContextID ,strReviewer,blnMappedToReviewIssue)
			{
				if(blnMappedToReviewIssue == "1")
					window.open ("AddChecklistComments.aspx?Mode=Edit&ChecklistItemId=" & intChecklistItemID & "&ContextId=" & intContextID & "&Reviewer=" & strReviewer , "_new", "resizable=yes,scrollbars=yes,left=" & (window.screen.width - 550)/2 & ",top=" & (window.screen.height - 300)/2 & ",width=550,height=300");
				else	
					alert('<%=MyBase.GetResourceString("CAP_ISSUE_MAPPINT_MISSING_ALERT")%>');
											
			}
			function Save_OnClick()
			{
				//Added by DipaliS 
		        //ADDED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
			    var isValidSave;
				//END ADDED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
					if("<%=m_intMappedToReviewIssue%>" != "1")
						{
						alert('<%=MyBase.GetResourceString("CAP_ISSUE_MAPPINT_MISSING_RES")%>');
						return;
						}
						
					if("<%=m_intChecklistID%>"=="0")
						{
						alert('<%=MyBase.GetResourceString("MSG_NO_CHK")%>')
						return;
						}
						
						
					var hdnIssueCorpSubType,hdnIssueSubType,hdnIssueCorpStatus,hdnIssueStatus;
					var hdnChecklistItemCount,hdnRadioButtonsCount,hdnCheckBoxesCount;
					
					hdnIssueCorpSubType=GetObjectReference('frmChecklist','hdnIssueCorpSubType');
					hdnIssueSubType=GetObjectReference('frmChecklist','hdnIssueSubType');
					hdnIssueCorpStatus=GetObjectReference('frmChecklist','hdnIssueCorpStatus');
					hdnIssueStatus=GetObjectReference('frmChecklist','hdnIssueStatus');
					
					hdnChecklistItemCount=GetObjectReference('frmChecklist','hdnChecklistItemCount');
					hdnRadioButtonsCount=GetObjectReference('frmChecklist','hdnRadioButtonsCount');
					hdnCheckBoxesCount=GetObjectReference('frmChecklist','hdnCheckBoxesCount');
					
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
						    alert('<%=MyBase.GetResourceString("MSG_NO_RESP")%>')
						    return;
						}
					
					
					if(hdnIssueCorpSubType!=null && hdnIssueSubType!=null && hdnIssueCorpStatus!=null && hdnIssueStatus!=null)
					{
					
					if(hdnIssueCorpSubType.value=="" || hdnIssueSubType.value=="" || hdnIssueCorpStatus.value=="" || hdnIssueStatus.value=="")
						{
						
						alert('<%=MyBase.GetResourceString("MSG_SUB_STATUS")%>')
						return;
						}
					}
					else
					{
					    alert('<%=MyBase.GetResourceString("MSG_SUB_STATUS")%>')
						return;
					}
						
											
						var intSelRadios=0; //is used to count selected radio as well as selected checkboxes..
						var intTotalOptions=0;//is used to count selected and non selected radio as well as checkboxes.i.e.total count
						var intIssues=0;
						
						if(intTotCount>0)
						{
							var intCtr=0;
							var strItem;				
							//debugger;	
							if(intTotCount==1)			
							{
							 //COMMENT ADDED BY AMIT MAHADIK ON 06 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
							 //In current situation of Project Functionality,this code will never execute.
							 //If this executes, need to modify this code like else...below..
							 //END COMMENT ADDED BY AMIT MAHADIK ON 06 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
								        var intCtr1;
								        var hdnProjectChecklistItemId=GetObjectReference('frmChecklist','hdnProjectChecklistItemId');
								        var hdnNegativeResponseId=GetObjectReference('frmChecklist','hdnNegativeResponseId');
								        if(hdnProjectChecklistItemId!=null)
									        strItem = "optOption" + Left(hdnProjectChecklistItemId.value,hdnProjectChecklistItemId.value.length-1);
								        var radios=GetObjectReference('frmChecklist',strItem,true);
								        if(radios!=null)
								        {
									        for(intCtr1=0;intCtr1<radios.length;intCtr1++)
									        {
										        if(radios[intCtr1].checked==true)
										        {
											        intSelRadios=1; //is used to count selected radio as well as selected checkboxes..
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
									
								        var hdnProjectChecklistItemId=GetObjectReference('frmChecklist','hdnProjectChecklistItemId',true);
								        var hdnNegativeResponseId=GetObjectReference('frmChecklist','hdnNegativeResponseId',true);
        								
						            //MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780
        						 
							        //FIND TOTAL OPTIONS FIRST.... AMIT M ******************
							        //debugger;
								        for(intCtr=0;intCtr<hdnProjectChecklistItemId.length;intCtr++)
								        {
								        //isValidSave = true; // amit m
									        strItem="";
									        var strRadioOrCheck; //should be R or C
									        var isCheckListMandatory; //should be 1 or 0
									        var radios;
        									
									        if(hdnProjectChecklistItemId[intCtr]!=null)
									        //amit m
									        strRadioOrCheck = Right(hdnProjectChecklistItemId[intCtr].value,2);
									        strRadioOrCheck = Left(strRadioOrCheck,strRadioOrCheck.length-1);// will extract rightside R or C
									        isCheckListMandatory = Right(hdnProjectChecklistItemId[intCtr].value,1) // will extract rightside 1 or 0
        										
									        if (strRadioOrCheck == "R")
									        {
									            strItem = "optOption" + Left(hdnProjectChecklistItemId[intCtr].value,hdnProjectChecklistItemId[intCtr].value.length-2);
									        }
									        else if (strRadioOrCheck == "C")
									        {
									            strItem = "chkOption" + Left(hdnProjectChecklistItemId[intCtr].value,hdnProjectChecklistItemId[intCtr].value.length-2);
									        }
									        //debugger;
									        radios=GetObjectReference('frmChecklist',strItem,true);
								           isValidSave = true; // amit m
								            if(radios!=null)
									        {
										        for(intCtr1=0;intCtr1<radios.length;intCtr1++)
										        {
											        //intTotalOptions +=1;
											        if(isCheckListMandatory == "1" && radios[intCtr1].checked==false)
											        {
											          isValidSave = false; // amit m
											        }
											        else
											        {
											          isValidSave = true; // amit m
											          break;
											        }
        											
										        }
									        }
									        if(isValidSave == false)
									        {
									            alert('Please respond to all mandatory checklist items.')//<%=MyBase.GetResourceString("MSG_SEL_ALL")%>
							                    return;
									        }
								        }   								
								        //******************************************************************
								        for(intCtr=0;intCtr<hdnProjectChecklistItemId.length;intCtr++)
								        {
								            //isValidSave = true; // amit m
									        strItem="";
									        var strRadioOrCheck; //should be R or C
									        var isCheckListMandatory; //should be 1 or 0
									        var radios;
        									
									        if(hdnProjectChecklistItemId[intCtr]!=null)
									        //amit m
									        strRadioOrCheck = Right(hdnProjectChecklistItemId[intCtr].value,2);
									        strRadioOrCheck = Left(strRadioOrCheck,strRadioOrCheck.length-1);// will extract rightside R or C
									        isCheckListMandatory = Right(hdnProjectChecklistItemId[intCtr].value,1) // will extract rightside 1 or 0
        										
									        if (strRadioOrCheck == "R")
									        {
									            strItem = "optOption" + Left(hdnProjectChecklistItemId[intCtr].value,hdnProjectChecklistItemId[intCtr].value.length-2);
									        }
									        else if (strRadioOrCheck == "C")
									        {
									            strItem = "chkOption" + Left(hdnProjectChecklistItemId[intCtr].value,hdnProjectChecklistItemId[intCtr].value.length-2);
									        }
									        //debugger;
									        radios=GetObjectReference('frmChecklist',strItem,true);
									        if(radios!=null)
									        {
										        for(intCtr1=0;intCtr1<radios.length;intCtr1++)
										        {
										            //
											        if(isCheckListMandatory == "1" && radios[intCtr1].checked==true)
											        {
												        intSelRadios+=1;//is used to count selected radio as well as selected checkboxes..
												        if(hdnNegativeResponseId[intCtr]!=null)
												        {        												
													        if(radios[intCtr1].value==hdnNegativeResponseId[intCtr].value )
														        intIssues+=1;        														
												        }
											        }
											        //
											        else if(isCheckListMandatory == "0" && radios[intCtr1].checked==true)
											        {
												        intSelRadios+=1;//is used to count selected radio as well as selected checkboxes..
												        if(hdnNegativeResponseId[intCtr]!=null)
												        {        												
													        if(radios[intCtr1].value==hdnNegativeResponseId[intCtr].value )
														        intIssues+=1;        														
												        }
											        }
											        //
											        else if(isCheckListMandatory == "1" && radios[intCtr1].checked==false)
											        {
												        //..no count increment
											        }
											        //
											        else if(isCheckListMandatory == "0" && radios[intCtr1].checked==false)
											        {
												        intSelRadios+=1;//is used to count selected radio as well as selected checkboxes..
												        if(hdnNegativeResponseId[intCtr]!=null)
												        {        												
													        if(radios[intCtr1].value==hdnNegativeResponseId[intCtr].value )
														        intIssues+=1;        														
												        }
											        }
										         }//for(intCtr1=0;intCtr1<radios.length;intCtr1++)
									         }//if(radios!=null)
								        }//	for(intCtr=0;intCtr<hdnProjectChecklistItemId.length;intCtr++)        								
							} //else					
						/* DELETED BY AMIT MAHADIK
						if(intSelRadios<intRadioButtons)
							{The responses to the check list items will be saved and issue/s will be created for negative responses. Do you want to continue?

							alert('<%=MyBase.GetResourceString("MSG_SEL_ALL")%>//')
							//return;
							//}							
						// END DELETED BY AMIT MAHADIK*/
				
			}
						
				//End addition by DipaliS
				//Modified by Noble K on 17th Jan 2005 
				//Changed the MSG_CONFIRM to MSG_CONFIRM_NEW
			    //debugger;
			   
				    ///modified by Amit Mahadik to chane message...//<%=MyBase.GetResourceString("MSG_CONFIRM_NEW")%>
				    var strMsg='The responses to the checklist items will be saved and issue(s) will be created for negative responses. Do you want to continue?';
				    ///END modified by Amit Mahadik to chane message...//<%=MyBase.GetResourceString("MSG_CONFIRM_NEW")%>
				    //var strMsg='<%=MyBase.GetResourceString("MSG_CONFIRM")%>';
				    ////strMsg=strMsg.replace("<intIssues>",intIssues); //deleted by Amit Mahadik, as no use..
				        if(window.confirm(strMsg)==true)
				        { 
				            frmChecklist.action="PM_FastTrackReviewChecklist.aspx?Action=Save&ReviewStatisticsID=" + "<%=m_lngReviewStatisticsId%>";
				            frmChecklist.submit();
				            //Added By MAhendraV On 6:43 PM 7/25/2007 For WhizibleSEM 7.0
				            // To close window after saving the checklist information.
				            //Start_MV_7/25/2007
				            
				            //window.close(); Commented By Vaijat K ON 17/12/2015 Issue ID -2680
				            refreshParent('frmCommonPage', 'CommonPage.aspx', 'CommonPage.aspx?FocusOn=SUBTAG&SubTagPagingAlphabet=&SubTagSortBy=&SubTagSortOrder=&SubTagID=2106');
				            //End_MV_7/25/2007
				            
				        }
				
         //END MODIFIED BY AMIT MAHADIK ON 05 MAY 2011 ,WHIZIBLESEM 10.0-Project  Reviews and RequestID 28780				
	}//function ends 
			
			//Integrated by SuchitraP on 8-May-2009 
			//Added By VarunA on 24-Apr-2009 RequestID-20061
		    //Purpose : To refresh the page depending upon dropdown selection
		    window.onunload = function(){
		        refreshParent('frmCommonPage', 'CommonPage.aspx', 'CommonPage.aspx?FocusOn=SUBTAG&SubTagPagingAlphabet=&SubTagSortBy=&SubTagSortOrder=&SubTagID=2106'); // Added By Vaijat K ON 28/12/2015 IssueID-2680
		    }
			function ResponseBy_OnChange(strReq)
			{		
			
			    var objform=GetFormReference('frmChecklist');
			    objform.action="../PM/PM_FastTrackReviewChecklist.aspx?ReviewStatisticsID=<%=m_lngReviewStatisticsId%>&ResponseBy=" + strReq.value ;
			    objform.submit();
			}
		        //End By VarunA on 24-Apr-2009 RequestID-20061
		        //End of Integration by SuchitraP
			
        </script>
	</body>
</HTML>
