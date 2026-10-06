<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ReviewerSelection.aspx.vb" Inherits="PbNIT.PM_ReviewerSelection"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	
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


	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
					<form id="frmReviewerSelection" name="frmReviewerSelection" method="post" runat="server">
									<%PageInit()%>
					</form>
					<script language="javascript">
			var objdivlist;
			var objform;
			
			objform = GetFormReference('frmReviewerSelection');
			objdivlist = GetObjectReference('frmReviewerSelection','DivList');
			
			'<%MyBase.InitializeResources("AppResources.PM_ReviewerSelection", "AppResources")%>';
			 //Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
            
            <%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
            
			function window_onload()		
			{
			//debugger;
				var intDivHeight ;
				var intDivHeightRisk;
				
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100){	intDivHeight = 100; }
				//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
		     	objdivlist.style.height = intDivHeight + 'px';
				
			
				if('<%=IsPostBack%>'=='False')
				{
					<%If Request.QueryString("intReviewee") & "" = "1" Then %>
					var objTxt = GetObjectReference('frmReviewerSelection','txtRevieweeIDList');
					//Modified by SantoshK on Date June 8, 2006 for WhizibleSEM Issue ID.4168
					//Purpose : Firefox Support, used GetParentObjectReference instead of opener.frmCommonPage.NonDatabase12
					var objNDB12 = GetParentObjectReference('frmCommonPage','NonDatabase12');
					//objTxt.value = opener.frmCommonPage.NonDatabase12.value;		
					<%'//Modified By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507%>
					if(objNDB12!=null)
						objTxt.value = objNDB12.value;		

					<% else %>
					var objTxt = GetObjectReference('frmReviewerSelection','txtReviewerIDList');
					var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');
					//objTxt.value = opener.frmCommonPage.NonDatabase1.value;		
					if(objNDB1!=null)					
					objTxt.value = objNDB1.value;		
					<%'//End Modification  By nitinVS on 10 Mar 2007 for WhizibleSEM SP 8 IssueID 11507%>					
					<% end if %>
					objform.submit();
					//Modification Ends by SantoshK on June 8, 2006
					
				}						
			}
			function window_onresize()		
			
			{
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

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
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
				objdivlist.style.height = intDivHeight + 'px';
				
			}
			function Paging_OnClick(chr)
			{
			//Modified by MrugajaB for Issue ID.1835
			<%If Request.QueryString("intReviewee") & "" = "1" Then %>
				objform.action = "PM_ReviewerSelection.aspx?intReviewee=1&Mode=<%=m_strMode%>&Date=<%=m_strDate%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>&Alphabet=" + chr;
			<% else %>				
				objform.action = "PM_ReviewerSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>&Alphabet=" + chr;
			<% end if %>	
			//End Modification
				objform.submit();
			}
			function Filter_OnChange()
			{
				objform.action = "PM_ReviewerSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function Show_OnClick()
			{
				objform.action = "PM_ReviewerSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function Clear_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmReviewerSelection','txtFilter');
				objTxt.value='';
				
				objform.action = "PM_ReviewerSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function ShowReviewer_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmReviewerSelection','txtShowReviewers');
				objTxt.value='1';
				<%If Request.QueryString("intReviewee") & "" = "1" Then %>
					objform.action = "PM_ReviewerSelection.aspx?intReviewee=1&Date=<%=m_strDate%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				<% else %>
				objTxt = GetObjectReference('frmReviewerSelection','txtShowReviewers');	
				<% end if %>
				objform.submit();
			}
			function ShowAll_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmReviewerSelection','txtShowReviewers');
				objTxt.value='';
					<%If Request.QueryString("intReviewee") & "" = "1" Then %>
				objform.action = "PM_ReviewerSelection.aspx?intReviewee=1&Date=<%=m_strDate%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				<% else %>
				objform.action = "PM_ReviewerSelection.aspx?&Date=<%=m_strDate%>";
				<% end if %>
				objform.submit();
			}
			function ShowSchedule_OnClick(EmpID)
			{
			    //Commented and Added by Yogesh J on 01-Feb-2016 for to generate and validate Token
			   
			    //PURPOSE: To display the schedule of the user.
			   //   window.open("PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + EmpID + "&FromDate=<%=m_strDate%>&ToDate=<%=m_strDate%>", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=700,height=500");
			    $.ajax({
			        type: 'POST',
			        dataType: 'json',
			        contentType: 'application/json',
			        url: 'PM_ReviewerSelection.aspx/GenrateURLToken_ShowSchedule_OnClick',
			        data: JSON.stringify({ EmployeeList: EmpID, EmployeeID: "<%=Session("intUserID")%>",FromDate: "<%=m_strDate%>", ToDate:"<%=m_strDate%>"  }),
			        success: function (Result) {     
		          window.open("PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + EmpID + "&PKToken="+ Result.d +"&FromDate=<%=m_strDate%>&ToDate=<%=m_strDate%>", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=700,height=500");

		        },
		        error: function () {
		          //  alert("Error")
		        }
		    });
			   
			    //End of addition by Yogesh J on 01-Feb-2016
				
			}
			function ShowSkills_OnClick(EName)
			{
				var strEmpName = new String(EName);
				strEmpName = strEmpName.replace("|||","'");
			    //PURPOSE: To display the skill set of the user.

                //Added and Commented by Yogesh Jalamkar on 02-Mar-2016 to generate Token
				//window.open("PM_EmployeeSkills.aspx?PageType=Skills&UserName=" + strEmpName + "&Date=<%=m_strDate%>", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=550,height=350", "");

				$.ajax({
				    type: 'POST',
				    dataType: 'json',
				    contentType: 'application/json',
				    url: 'PM_ReviewerSelection.aspx/GenrateURLToken_ShowSkillls',
				    data: JSON.stringify({ EmployeeName: strEmpName, EmpDate: "<%=m_strDate%>" }),
			        success: function (Result) {
			            window.open("PM_EmployeeSkills.aspx?PageType=Skills&FromWhere=PM&UserName=" + strEmpName + "&Date=<%=m_strDate%>&PKToken="+Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=550,height=350", "");

			        },
                    
                      error: function () {
                          //  alert("Error")
                      }
                  });
			    //End of addition by Yogesh Jalamkar 02-Mar-2016 to generate Token
			}
			function SetReviewer_OnClick()
			{
				var objChk,intCnt,intLen;
				var blnSelected=false;
				
				objChk = GetObjectReference('frmReviewerSelection','chkSelect',true);
				try
				{
					intLen = objChk.length;
					if(intLen > 0)
					{
						for(intCnt=0;intCnt<intLen;intCnt++)
						{
							if(objChk[intCnt].checked==true)
							{
								blnSelected=true;
								break;
							}
						}
					}
					
					if(blnSelected==false)
					{
						<%If Request.QueryString("intReviewee") & "" = "1" Then%>
							
							//Added by MrugajaB on 4th Feb 2006
							//purpose:If offline review then all reviewees can be unchecked
							<%If Request.Querystring("IsOfflineReview")="False" Then %>
								alert('<%=MyBase.GetResourceString("MSG_RESOURCE_NOT_SELECTED_REVIEWEE")%>');
							<%else%>
								objform.action = "PM_ReviewerSelection.aspx?intReviewee=1&Date=<%=m_strDate%>&Action=<%=CONST_ACTION_SAVE%>"
								objform.submit();
							<%End If%>
							//End Addition
						<%else%>
							alert('<%=MyBase.GetResourceString("MSG_RESOURCE_NOT_SELECTED")%>');
						<%end if%>
					}
					else
					{
					<%If Request.QueryString("intReviewee") & "" = "1" Then %>
					objform.action = "PM_ReviewerSelection.aspx?intReviewee=1&Date=<%=m_strDate%>&Action=<%=CONST_ACTION_SAVE%>";	
					<%else %>	
					objform.action = "PM_ReviewerSelection.aspx?Date=<%=m_strDate%>&Action=<%=CONST_ACTION_SAVE%>";
					<%end if %>
						objform.submit();
					}
				}
				catch(e)
				{}
			}
			function chkSelect_OnClick(obj)
			{
			
				//PURPOSE: To update the ReviewerID list when a reviewer is selected / removed.
				var objTxt,strReviewerIDList;
				<%If Request.QueryString("intReviewee") & "" = "1" Then %>
				objTxt = GetObjectReference('frmReviewerSelection','txtRevieweeIDList');
				<% else %>
				objTxt = GetObjectReference('frmReviewerSelection','txtReviewerIDList');
				<% end if %>
				strReviewerIDList = new String(objTxt.value);
				
				var EmpID = obj.value;
				
				//If the resource has been added to the list of reviewers, then...
				if(obj.checked==true)
				{
					//if not in the list then add 
					if(strReviewerIDList.indexOf("," + EmpID +",",0)==-1)
					{
						strReviewerIDList = strReviewerIDList + EmpID + ",";
						objTxt.value = strReviewerIDList; 
					}    			
				}
				else
				{
					if(strReviewerIDList.indexOf("," + EmpID +",",0) != -1)
					{
						//Remove the Employee ID from the comma separated list.
						strReviewerIDList = replaceSubstring(strReviewerIDList,"," + EmpID + ",","," );
						objTxt.value = strReviewerIDList; 
					}
				}		
						
			}
					</script>
		
	</body>
</HTML>
