<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TCM_ShowReport.aspx.vb" Inherits="PbNIT.TCM_ShowReport" %>

<!DOCTYPE HTML>
<HTML>
	 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("")%>
<%--	<%CommonFunctions.General.PlotPageHeadTag("Test Session Report")%>

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
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
					<form id="frmTCMReport" name="frmTCMReport" method="post">
						
									<%WritePage()%>
							
					</form>
			
					<script language="javascript">
					
					    <%' Added By SonalD on 13th Jan 2009 %>
                        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                            disableRightClick();
                        <%End If%>
                        <%' Added By SonalD on 13th Jan 2009 %>
            
						var objform = GetFormReference('frmTCMReport');								
						var objdiv = GetObjectReference('frmTCMReport','divList');
						var objchkAllOpenSessions=GetObjectReference('frmTCMReport','chkAllOpenSessions');
						var objchkAllClosedSessions=GetObjectReference('frmTCMReport','chkAllClosedSessions');
						var objchkAllNegativeResponse=GetObjectReference('frmTCMReport','chkAllNegativeResponse');
						var objchkAllPositiveResponse=GetObjectReference('frmTCMReport','chkAllPositiveResponse');
						
						function window_onload()
						{ 
								var intDivHeight;
							
								if(objdiv!=null)
								{	 
								    // Commented and added by Yogesh J on 18-Nov-2015
								    //   intDivHeight= document.body.offsetHeight - objdiv.offsetTop - 90 ;
								    if(WhichBrowser()=='IE')
								    {
								        
								        intDivHeight = window.innerHeight - objdiv.offsetTop - 62;
								    }
								    else if(WhichBrowser()=='FF')
								    {
								      
								        intDivHeight = window.innerHeight - objdiv.offsetTop - 62;
								    }
								    else{
								   
								        intDivHeight = window.innerHeight - objdiv.offsetTop - 62;
								    }
								    //End of addition by Yogesh J on 18-Nov-2015
								    if (intDivHeight < 100)
								    intDivHeight = 100;
    								
								    objdiv.style.height = intDivHeight + "px";
								}
								
								var showmsg;		
								showmsg = <%=m_intShowMessage%>;
								 
								if (showmsg == 1 )
								{
									alert("There are no items to show in this view!");
									window.close();
									return;
								}
								/*else
								{			
									var intDivHeight ;
									var intDivHeightRisk;
									var filename;
									
									filename="<%=m_strFileName%>";		
									if (trimString(filename).length > 0 )
									{
								
									window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report","");
									}
								}*/	
						} 
						

						function window_onresize()
						{ 
													 
								var intDivHeight;
								
								if(objdiv!=null)
								{	
								    intDivHeight= document.body.offsetHeight - objdiv.offsetTop - 90 ;
								    if (intDivHeight < 100)	intDivHeight = 100;
								    //Comment added on 11 Dec 2015 by Viraj P
								    //objdivlist.style.height = intDivHeight;
                                    //Commented And Added By Usha Pandit On 09.07.2020 For javascript due to incorrect field name
								    //objdivlist.style.height = intDivHeight + 'px';
                                    objdiv.style.height = intDivHeight + 'px';
                                    //End Of Added By Usha Pandit On 09.07.2020 For javascript due to incorrect field name

								      
								}
								
								var showmsg;		
								showmsg = <%=m_intShowMessage%>;
								 
								if (showmsg == 1 )
								{
									alert("There are no items to show in this view!");
									return;
								}
								else
								{			
									var intDivHeight ;
									var intDivHeightRisk;
									var filename;
									
									filename="<%=m_strFileName%>";		
									if (trimString(filename).length > 0 )
									{
								
									window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report","");
									}
								}	
						} 
						
					    /*Added by Yogesh J on 18-Nov-2015*/
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
                        /*End of addition by Yogesh J on 18-Nov-2015*/
						function Filter_change()
					    {
						    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
						      setFrameLoader();  
						    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
							objform.action = "TCM_ShowReport.aspx?MasterTagID=<%=intMasterTagID.toString%>&Mode=Change&ChangedCombo&ReportID=<%=intReportID%>";
							objform.submit();								
						}
						
						//Added By VarunA on 25-July-2007 PMLifeLine Development & Release
						function Filter_Session_change()
						{
							var objcboTestSessionSummary = GetObjectReference('frmTCMReport','cboTestSession_Summary');
							if(objcboTestSessionSummary.value=="")
							{
								objchkAllOpenSessions.disabled=false;
								objchkAllClosedSessions.disabled=false;
							}
							else
							{
								objchkAllOpenSessions.disabled=true;
								objchkAllClosedSessions.disabled=true;
								if(	objchkAllOpenSessions.checked==true || objchkAllClosedSessions.checked==true)
								{
									objchkAllOpenSessions.checked=false;
									objchkAllClosedSessions.checked=false;
								}
							}		
						    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
						     setFrameLoader();  
						    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
							objform.action = "TCM_ShowReport.aspx?MasterTagID=<%=intMasterTagID.toString%>&Mode=Change&ChangedCombo&ReportID=<%=intReportID%>";
							objform.submit();
						}
						//End By VarunA on 25-July-2007

						function ViewReport_OnClick(format)
						{//debugger;
							var intMasterTagID =<%=intMasterTagID.toString%>;	
							
							//Added by NitinC on 03 Jan 2011 For PMLifeLine - Agile Module (Issue Fix : 57763)
							if(intMasterTagID==9023 || intMasterTagID==9024 || intMasterTagID==9025)
							{
							    var valUserStory = GetObjectReference('frmTCMReport','cboUserStory').value;
							    if (valUserStory=="")
							    {
							        alert('Please select user story!');
							        return;
							    }
							}
							if(intMasterTagID==9024)
							{
							    var valcboTestSet_TS = GetObjectReference('frmTCMReport','cboTestSet_TS').value;
							    if (valcboTestSet_TS=="")
							    {
							        alert('Please select test set value!');
							        return;
							    }
							    
							}
							if(intMasterTagID==9023)
							{
							    var valcboTestSesion = GetObjectReference('frmTCMReport','cboTestSession_TestCases').value;
							    if (valcboTestSesion=="")
							    {
							        alert('Please select test session value!');
							        return;
							    }
							    
							}
							//End of Added by NitinC on 03 Jan 2011 For PMLifeLine - Agile Module (Issue Fix : 57763)
																										
							var objTestSet = GetObjectReference('frmTCMReport','cboTestSet_TS');
							var objTestSession = GetObjectReference('frmTCMReport','cboTestSession_TestCases');
							objform.target="_blank";							
							if(intMasterTagID==3654)
							{
								var objcboTestSession =  GetObjectReference('frmTCMReport','cboTestSession2');
								var objcboRequestType =  GetObjectReference('frmTCMReport','cboRequestType');
								  
								var TestSessionID = objcboTestSession.value;
							    //Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
								setFrameLoader();  
							    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader	
								if(objcboRequestType.value == 0 )
								{
								  					
									objform.action = "TCM_ShowReport.aspx?Mode=VIEW&ReportID=2057&Type=0&UniqueID="+ TestSessionID + "&Format="+ format ;
									objform.submit();
								}
								else
								{	 
									objform.action = "TCM_ShowReport.aspx?Mode=VIEW&ReportID=2038&Type=1&UniqueID="+ TestSessionID + "&Format="+ format ;
									objform.submit();
																
								}
								RemoveFrameLoader();
							}
							else
							{	if(intMasterTagID==3823 && objTestSet.value=="")
								{
									alert("Please select Test Set")
								}
								
								else if(intMasterTagID==3824 && objTestSession.value=="")
								{
									alert("Please select Test Session")
								}
								else
								{   //Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
								    setFrameLoader();  
								    //End Of Added By Vidya Jadhav oN 12 Oct 2016 Purpose: Page Loader
									objform.action = "TCM_ShowReport.aspx?MasterTagID=<%=intMasterTagID.toString%>&Mode=VIEW&ReportID=<%=intReportID%>&UniqueID=<%=intTestSessionID%>&Format="+ format ;
									objform.submit();
									RemoveFrameLoader();
								}
							}
						   
									   
							objform.target="_self";
						
						}
											
						 
						 
						 
						 function Enable_Disable_CheckBox()
						 {
							var objcboTestResult = GetObjectReference('frmTCMReport','cboTestCaseResult');
							if(objcboTestResult.value=="")
							{
								objchkAllNegativeResponse.disabled=false;
								objchkAllPositiveResponse.disabled=false;
							}
							else
							{
								objchkAllNegativeResponse.disabled=true;
								objchkAllPositiveResponse.disabled=true;
								if(	objchkAllNegativeResponse.checked==true || objchkAllPositiveResponse.checked==true)
								{
									objchkAllNegativeResponse.checked=false;
									objchkAllPositiveResponse.checked=false;
								}
							}			
						 }
						 
						 
						 
						function OpenSessionCheckBox_OnClick()
						{
							if(objchkAllOpenSessions.checked==true)
							{
								objchkAllClosedSessions.checked=false;
							}
						}	
						
						function ClosedSessionCheckBox_OnClick()
						{
							if(objchkAllClosedSessions.checked==true)
							{
								objchkAllOpenSessions.checked=false;
							}
						}	
						 
						 function NegativeResponseCheckBox_OnClick()
						 {
																
							if(objchkAllNegativeResponse.checked==true)
							{
								objchkAllPositiveResponse.checked=false;
							}
						}
							 
						 function PositiveResponseCheckBox_OnClick()
						 {
						  if(objchkAllPositiveResponse.checked==true)
							{
									objchkAllNegativeResponse.checked=false;
							}
						 }
							
						  function Back_OnClick()	
		                  {
		                        window.location.href="../PM/PM_Scrum_ViewOtherReports.aspx?MasterTagID=9010&FromWhere=PM"	
		                  }	
												
					</script>
				
	</body>
</HTML>
