<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskDetails.aspx.vb" Inherits="PbNIT.PM_TaskDetails"%>
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


	<body MS_POSITIONING="GridLayout" class='clsBody' onresize="window_onresize()" onload="window_onload()" >
		<form id="frmTaskDetails" name="frmTaskDetails" method="post" runat="server">
			<%PageInit()%>
		</form>
	<script language="javascript">
	    var objdivlist;
	    var objform;
	    var objValue;
	    var strUnDoValue, strReDoValue;
	    var blnReDoFlag;
	    var objCalendar;
	    var blnAndOrSelected, intBracketCount;
	    blnAndOrSelected = true;
	    intBracketCount = 0;
	    blnReDoFlag = false;
	    strReDoValue = '';
	    strUnDoValue = '';

	    objform = GetFormReference('frmTaskDetails');
	    objdivlist = GetObjectReference('frmTaskDetails', 'DivList');
	    objValue = GetObjectReference('frmTaskDetails', 'txtValue');
	    objCalendar = GetObjectReference('frmTaskDetails', 'imgCalendar');

	    '<%MyBase.InitializeResources("AppResources.PM_TaskDetails", "AppResources")%>';
			
	    <%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
	    disableRightClick();
	    <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>

	    function window_onload() {
	        var intDivHeight;
	        var intDivHeightRisk;

	        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 70;
	        //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

	        //if(navigator.appName == 'Netscape')
	        //{
	        //    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
	        //    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 70;
	        //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
	        //    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
	        //}
	        //else
	        //{
	        //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 70;
	        //}
	        var brw = isIE();
	        var MasterTagId = getParameterByName('MasterTagId');
	        if (MasterTagId = 406) {
	            if (brw == "FF") {
	                intDivHeight = window.innerHeight - objdivlist.offsetTop - 76;
	            }
	            if (brw == "IE") {
	                intDivHeight = window.innerHeight - objdivlist.offsetTop - 65;
	            }
	            else
	                intDivHeight = window.innerHeight - objdivlist.offsetTop - 66;
	        }
	        else
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 38;
	        if (MasterTagId != 406) {
	            if (intDivHeight < 100)
	                intDivHeight = 100;
	        }
	        //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
	        //objdivlist.style.height = intDivHeight;
	        objdivlist.style.height = intDivHeight + 'px';
	        //End of Comment and Addition by Dhanashri S on 10 Dec 2015


	        if ('<%=m_blnIsValidQuery%>' == 'False') {
				    alert('<%=mybase.GetResourceString("MSG_INVALID_QUERY")%>');
				}

                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
                if (Trim(objTxt.value) != '' && Trim(objTxt.value) != null) {
                    blnAndOrSelected = false;
                    //strUnDoValue = objTxt.value;
                }
            }
            function window_onresize() {
                var intDivHeight;
                var intDivHeightRisk;
                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 70;
                //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

                //if(navigator.appName == 'Netscape')
                //{		  
                //    //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
                //    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 70;
                //    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
                //    //End of Comment and Addition by Dhanashri S on 10 Dec 2015
                //}
                //else
                //{
                //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 70;
                //}
                var brw = isIE();
                var MasterTagId = getParameterByName('MasterTagId');
                if (MasterTagId = 406) {
                    if (brw == "FF") {
                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 76;
                    }
                    if (brw == "IE") {
                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 66;

                    }
                    else
                        intDivHeight = window.innerHeight - objdivlist.offsetTop - 66;
                }
                else
                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 38;

                if (MasterTagId != 406) {
                    if (intDivHeight < 100)
                        intDivHeight = 100;
                }
                //Commented and Added by Dhanashri S on 10 Dec 2015 for IssueID:2530
                //objdivlist.style.height = intDivHeight;

                objdivlist.style.height = intDivHeight + 'px';
                //End of Comment and Addition by Dhanashri S on 10 Dec 2015
            }
            function Field_OnChange() {
                //debugger;
                var objCbo;
                var strField;
                try {
                    objCbo = GetObjectReference('frmTaskDetails', 'cboFieldName');
                    strField = new String(objCbo.value);

                    objValue.style.display = 'none';
                    objCalendar.style.display = 'none';
                    /* Added By NitinVS on  3 Dec 2005 for Editable Date Control Problem IssueID 672*/
					<% if m_UseEditableDateControl=true then %>
				    {
				        if (navigator.appName != 'Netscape') {
				            objFFE29587WHIZ_txtStartDate = GetObjectReference('frmTaskDetails', 'FFE29587WHIZ_txtStartDate');
				            objFFE29587WHIZ_txtStartDate.style.display = 'none';
				            objFFE29587WHIZ_txtStartDate.value = '';
				            objFFE29587WHIZ_txtEndDate = GetObjectReference('frmTaskDetails', 'FFE29587WHIZ_txtEndDate');
				            objFFE29587WHIZ_txtEndDate.style.display = 'none';
				            objFFE29587WHIZ_txtEndDate.value = '';
				        }

				    }
					<% end if %>
				    /* end Addion By NitinVS on  3 Dec 2005 for Editable Date Control Problem IssueID 672*/

				    objValue = null;

				    if (strField.toUpperCase() == 'USERNAME')
				        objValue = GetObjectReference('frmTaskDetails', 'cboResources');
				    else if (strField.toUpperCase() == 'WHICHTASK')
				        objValue = GetObjectReference('frmTaskDetails', 'cboWhichTask');
				    else if (strField.toUpperCase() == 'TASKTYPE')
				        objValue = GetObjectReference('frmTaskDetails', 'cboTaskType');
				    else if (strField.toUpperCase() == 'PHASE')
				        objValue = GetObjectReference('frmTaskDetails', 'cboPhase');
				    else if (strField.toUpperCase() == 'MODULE')
				        objValue = GetObjectReference('frmTaskDetails', 'cboModule');
				    else if (strField.toUpperCase() == 'SUBPROJECT')
				        objValue = GetObjectReference('frmTaskDetails', 'cboSubproject');
				    else if (strField.toUpperCase() == 'MILESTONE')
				        objValue = GetObjectReference('frmTaskDetails', 'cboMilestone');
				    else if (strField.toUpperCase() == 'PROJECTFEATUREID')
				        objValue = GetObjectReference('frmTaskDetails', 'cboFeature');
				    else if (strField.toUpperCase() == 'STARTDATE') {
                        //Commented And Added By Vaijat K ON 12/03/2016
				        //objValue = GetObjectReference('frmTaskDetails', 'txtStartDate');
				        objValue = GetObjectReference('frmTaskDetails', 'FFE29587WHIZ_txtStartDate');
                        //Ended
				        objCalendar = GetObjectReference('frmTaskDetails', 'imgCalendar');
				    }
				    else if (strField.toUpperCase() == 'ENDDATE') {
				        //Commented And Added By Vaijat K ON 12/03/2016
				        //objValue = GetObjectReference('frmTaskDetails', 'txtEndDate');
				        objValue = GetObjectReference('frmTaskDetails', 'FFE29587WHIZ_txtEndDate');
                        //Ended
				        objCalendar = GetObjectReference('frmTaskDetails', 'imgCalendar');
				    }
				    else if (strField.toUpperCase() == 'TASKNAME')
				        objValue = GetObjectReference('frmTaskDetails', 'txtTaskName');
				        //Added by HarshK for sp4 issueid 200
				    else if (strField.toUpperCase() == 'DELIVERABLENAME')
				        objValue = GetObjectReference('frmTaskDetails', 'cboDeliverable');
				        //End Added by HarshK for sp4 issueid 200
				    else
				        objValue = GetObjectReference('frmTaskDetails', 'txtValue');


				    //display the control				
				    objValue.style.display = '';
				    //alert(objValue.id);
				    //populate the TD with control
				    var objTD;
				    objTD = GetObjectReference('frmTaskDetails', 'TDFieldValue');
				    //objTD.innerHTML="";
				    objTD.appendChild(objValue);

				    //if date control then display the calender link.
				    if ((strField.toUpperCase() == 'STARTDATE') || (strField.toUpperCase() == 'ENDDATE')) {
				        //objTD.innerHTML += "<A Href='javascript:Calender_OnClick()'><Image BORDER=0 src='../../Images/calendar.gif' alt='Click to open calendar' ></A>";							

				        /* Modified By NitinVS on  3 Dec 2005 for Editable Date Control Problem IssueID 672*/
						<% if m_UseEditableDateControl=true then %>
					    {

					        if (navigator.appName != 'Netscape') {
					            if ((strField.toUpperCase() == 'STARTDATE')) {
					                objFFE29587WHIZ_txtEndDate.style.display = 'none';
					                objTD.appendChild(objFFE29587WHIZ_txtStartDate);
					                objFFE29587WHIZ_txtStartDate.style.display = '';
					            }
					            if ((strField.toUpperCase() == 'ENDDATE')) {
					                objFFE29587WHIZ_txtStartDate.style.display = 'none';
					                objFFE29587WHIZ_txtEndDate.style.display = '';
					                objTD.appendChild(objFFE29587WHIZ_txtEndDate)

					            }
					        }
					    }
						<% end if %>
					    objTD.appendChild(objCalendar);
					    objCalendar.style.display = '';

					}
					else {

					    if (navigator.appName != 'Netscape') {
							<% if m_UseEditableDateControl=true then %>
						    {
						        objFFE29587WHIZ_txtStartDate.style.display = 'none';
						        objFFE29587WHIZ_txtEndDate.style.display = 'none';
						    }
							<% end if%>
						}
					}
				    /* End Modification By NitinVS on  3 Dec 2005 for Editable Date Control Problem IssueID 672 */
				}
			    catch (e)
			    { }
			}
			function Calender_OnClick() {
			    var strControlID;
			    strControlID = new String(objValue.id);
			    //Added By Vaijat K ON 12/03/2016
			    if (objValue.id == 'FFE29587WHIZ_txtStartDate')
			        strControlID = 'txtStartDate'
			    else if (objValue.id == 'FFE29587WHIZ_txtEndDate')
			        strControlID = 'txtEndDate'
                //Ended
			    callcalendar('frmTaskDetails', strControlID);
			}
			function Execute_OnClick() {
			    var objTxt, flag;

			    if (intBracketCount > 0) {
			        alert('<%=MyBase.GetResourceString("MSG_BRACKET_OPEN")%>');
				    return;
				}

                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
                flag = disallowMaxlengthViolation(objTxt, 7000, '<%=MyBase.GetResourceString("MSG_QUERY_MAX_LENGTH")%>')
				if (flag == true) {
				    objValue.focus();
				    return;
                }
                
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
				setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016

				objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=CONST_MODE_QUERY%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
				objform.submit();
            }
            function Save_OnClick() {
                var objTxt, strCol;
                var flag;
                if ('<%=m_strMode%>' == '<%=CONST_MODE_COUNT%>') {
				    objTxt = GetObjectReference('frmTaskDetails', 'txtColumnName');
				    strCol = new String(objTxt.value);

				    if (strCol.toUpperCase() == 'PHASE') {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColPhase');
				        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_PHASE_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
                    if (strCol.toUpperCase() == 'MODULENAME') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColTaskType');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_TAKSTYPE_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
                    if (strCol.toUpperCase() == 'MODULE') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColModule');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_MODULE_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
                    if (strCol.toUpperCase() == 'SUBPROJECT') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColSubProject');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_SUBPROJECT_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
                    if (strCol.toUpperCase() == 'MILESTONE') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColMilestone');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_MILESTONE_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
                    if (strCol.toUpperCase() == 'PROJECTFEATUREID') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColFeature');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_FEATURES_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
				    //Intigrated by HarshK for sp4 issueid 200
                    if (strCol.toUpperCase() == 'DELIVERABLEID') {
                        objTxt = GetObjectReference('frmTaskDetails', 'cboColDeliverable');
                        flag = disallowBlank(objTxt, '<%=MyBase.GetResourceString("MSG_DELIVERABLES_EMPTY")%>', true);
						if (flag == true)
						    return;
                    }
				    //End Intigrated by HarshK for sp4 issueid 200
                }
                else {
                    objTxt = GetObjectReference('frmTaskDetails', 'cboColTaskType');
                    flag = disallowBlank(objTxt, '', false);

                    if (flag == true && '<%=m_blnShowPhase%>' == 'True') {
					    objTxt = GetObjectReference('frmTaskDetails', 'cboColPhase');
					    flag = disallowBlank(objTxt, '', true);
					}
					if (flag == true && '<%=m_blnShowModule%>' == 'True') {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColModule');
				        flag = disallowBlank(objTxt, '', true);
				    }
				    if (flag == true && '<%=m_blnShowSubproject%>' == 'True') {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColSubProject');
				        flag = disallowBlank(objTxt, '', true);
				    }
				    if (flag == true && '<%=m_blnShowMilestone%>' == 'True') {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColMilestone');
				        flag = disallowBlank(objTxt, '', true);
				    }
				    if (flag == true && '<%=m_blnShowFeatures%>' == 'True') {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColFeature');
				        flag = disallowBlank(objTxt, '', true);
				    }
				    //Modified By VidyaJ - issueid 200 - 2p4
				    if (flag == true) {
				        objTxt = GetObjectReference('frmTaskDetails', 'cboColDeliverable');
				        flag = disallowBlank(objTxt, '', true);
				    }

				    if (flag == true) {
				        alert('<%=MyBase.GetResourceString("MSG_ALL_EMPTY")%>');
					    return;
					}
                }

                if (flag == false) {
                    var blnSelected = false;
                    var objChk = GetObjectReference('frmTaskDetails', 'chkApply', true);
                    var intLen = objChk.length;
                    flag = true;
                    if (intLen > 0) {
                        var i;
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                break;
                            }
                    }

                    if (blnSelected == false) {
                        alert('<%=MyBase.GetResourceString("MSG_TASK_NOT_SELECTED")%>');
					    return;
					}
					else
					    flag = false;
                }

			    //Added by GokulP on 08 Sept 2009 for IssueID = 33076 and 33086
			    //**************************************************************************************************

                var objModuleID = GetObjectReference('frmTaskDetails', 'cboColModule');
                var objSubProjectID = GetObjectReference('frmTaskDetails', 'cboColSubProject');
                var objMilestoneID = GetObjectReference('frmTaskDetails', 'cboColMilestone');
                var objDeliverableID = GetObjectReference('frmTaskDetails', 'cboColDeliverable');

			    //Integrated by GokulP on 10 May 2010 for SP1   
			    //Modified by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]
                var intSelectedModuleID = 0;
                var intSelectedSubProjectID = 0;
                var intSelectedMilestoneID = 0;
                var intSelectedDeliverableID = 0;

                if (objModuleID) {
                    var strSelectedModule = objModuleID.value;
                    //var intSelectedModuleID = strSelectedModule.substring(0,strSelectedModule.indexOf("|"));
                    intSelectedModuleID = strSelectedModule.substring(0, strSelectedModule.indexOf("|"));
                }
                if (objSubProjectID) {
                    var strSelectedSubProject = objSubProjectID.value;
                    //var intSelectedSubProjectID = strSelectedSubProject.substring(0,strSelectedSubProject.indexOf("|")); 
                    intSelectedSubProjectID = strSelectedSubProject.substring(0, strSelectedSubProject.indexOf("|"));
                }
                if (objMilestoneID) {
                    var strSelectedMilestone = objMilestoneID.value;
                    //var intSelectedMilestoneID = strSelectedMilestone.substring(0,strSelectedMilestone.indexOf("|"));
                    intSelectedMilestoneID = strSelectedMilestone.substring(0, strSelectedMilestone.indexOf("|"));
                }
                if (objDeliverableID) {
                    intSelectedDeliverableID = objDeliverableID.value;
                }
			    //End of Modification by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           	
			    //End of Integratition by GokulP on 10 May 2010 for SP1           
                var strURL;
                var fmt = 'MMM dd,yyyy';
                var IsValidTask = 1;

                if (flag == false) {
                    var blnSelected = false;
                    var objChk = GetObjectReference('frmTaskDetails', 'chkApply', true);
                    var intLen = objChk.length;

                    if (intLen > 0) {
                        var i;
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                //Integrated by GokulP on 10 May 2010 for SP1
                                //Modified by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           																						
                                //strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&FromWhichPage=TaskMapping&TaskId="+objChk[i].value+"&StartDate=&EndDate=&DeliverableID="+objDeliverableID.value+"&ModuleID="+String(intSelectedModuleID)+"&SubProjectID="+String(intSelectedSubProjectID)+"&MilestoneID="+String(intSelectedMilestoneID)+"&Work=";
                                strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&FromWhichPage=TaskMapping&TaskId=" + objChk[i].value + "&StartDate=&EndDate=&DeliverableID=" + intSelectedDeliverableID + "&ModuleID=" + String(intSelectedModuleID) + "&SubProjectID=" + String(intSelectedSubProjectID) + "&MilestoneID=" + String(intSelectedMilestoneID) + "&Work=";
                                //End of Modification by GokulP on 17 Feb 2010 for Removing Javascipt Error [IssueID : 24937]           	
                                //End of Integration by GokulP on 10 May 2010 for SP1
                                ValidateTask_Baseline(strUrl);

                                if (strResult != null && strResult != "") {
                                    alert(strResult);
                                    IsValidTask = 0;
                                }
                                break;
                            }
                    }
                }
                if (IsValidTask == 0) {
                    return false;
                }

			    //End of Addition by GokulP on 08 Sept 2009 for IssueID = 33076 and 33086    

			    //**************************************************************************************************


                if (flag == false) {
                    //MODIFIED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-91					
                    objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
				    objform.submit();
				    //Code Integrated By PradipK for IsseueID=3926 on 19 Dec 2006
				    //window.opener.location.href=window.opener.location.href;								//Modified By VidyaJ For Comsoft IssueId 3926 :Project Module - Task Management - Task Mapping
				    //window.opener.location.href=window.opener.location.href
				    window.opener.location.href = replaceSubstring(window.opener.location.href, 'Operation=Save', '');
				    //End of Modifications
				    //END OF MODIFICATION BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-91					
				}
            }
            function Task_OnClick(TID) {
                window.open("PM_ProjectTask.aspx?Mode=TaskType&TaskID=" + TID, "", "resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 300) / 2 + ",width=500,height=300");
            }
            function SelectAll_OnClick() {
                var objChk, objTxt;
                var intCnt, i;

                objTxt = GetObjectReference('frmTaskDetails', 'txtRecordCount');
                intCnt = objTxt.value;

                objChk = GetObjectReference('frmTaskDetails', 'chkApply', true);
                for (i = 0; i < intCnt; i++)
                    objChk[i].checked = true;
            }
            function ClearAll_OnClick() {
                var objChk, objTxt;
                var intCnt, i;

                objTxt = GetObjectReference('frmTaskDetails', 'txtRecordCount');
                intCnt = objTxt.value;

                objChk = GetObjectReference('frmTaskDetails', 'chkApply', true);
                for (i = 0; i < intCnt; i++)
                    objChk[i].checked = false;
            }
            function Count_OnClick(strCol) {
                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtColumnName');
                objTxt.value = strCol;

                objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=CONST_MODE_COUNT%>&Alphabet=<%=m_strAlphabet%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
				objform.submit();
            }
            function ColumnClear_OnClick(strCol) {
                var intRowCount, intLen, i;
                var objTxt, objChk;
                var blnSelected;
                blnSelected = false;

                objTxt = GetObjectReference('frmTaskDetails', 'txtRecordCount');
                intRowCount = objTxt.value;
                if (intRowCount > 0) {
                    objChk = GetObjectReference('frmTaskDetails', 'chkApply', true);
                    intLen = objChk.length;
                    if (intLen > 0) {
                        for (i = 0; i < intLen; i++)
                            if (objChk[i].checked == true) {
                                blnSelected = true;
                                break;
                            }
                    }

                    if (blnSelected == true) {
                        var str;
                        str = new String(strCol);

                        if (str.toUpperCase() == 'MODULENAME')
                            strCol = "Task Type";
                        else if (str.toUpperCase() == 'SUBPROJECT')
                            strCol = "Sub Project";
                        else if (str.toUpperCase() == 'PROJECTFEATUREID')
                            strCol = "Feature";
                            //Intigrated by Harshk for sp4 issueid 200
                            //Purpose to 
                        else if (str.toUpperCase() == 'DELIVERABLEID')
                            strCol = "Deliverable";
                        //End Intigrated by Harshk for sp4 issueid 200	
                        var ans;
                        ans = window.confirm('<%=MyBase.GetResourceString("MSG_COLUMN_CLEAR_1")%>' + strCol + ' ' + '<%=MyBase.GetResourceString("MSG_COLUMN_CLEAR_2")%>');
						if (ans == true) {
						    objTxt = GetObjectReference('frmTaskDetails', 'txtColumnName');
						    objTxt.value = str;

						    objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_CLEAR%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
							objform.submit();
                        }
                    }
                    else {
                        alert('<%=MyBase.GetResourceString("MSG_TASK_NOT_SELECTED")%>');
					}
                }
            }
            function Append_OnClick() {
                var obj, flag, strField;
                var strValue, strQuery, objTxt;

                obj = GetObjectReference('frmTaskDetails', 'cboFieldName');
                flag = disallowBlank(obj, '<%=MyBase.GetResourceString("MSG_FIELD_EMPTY")%>', true);
				if (flag == true)
				    return;

				strField = obj.value;

				obj = GetObjectReference('frmTaskDetails', 'cboOperator');
				flag = disallowBlank(obj, '<%=MyBase.GetResourceString("MSG_OPERATOR_EMPTY")%>', true);
				if (flag == true)
				    return;

				strValue = new String(objValue.value);
			    //if(strValue.indexOf("'")>=0)
                strValue = replaceSubstring(strValue, "'", "''");
                //Added By Usha Pandit On 19.02.2021 For correct query execution
                if (strField == "StartDate") {
                    strValue = $("#txtStartDate").val();
                }
                if (strField == "EndDate") {
                    strValue = $("#txtEndDate").val();
                }
                //End Of Added By Usha Pandit On 19.02.2021 For correct query execution
				if (obj.value == 'LIKE' || obj.value == 'NOT LIKE')
				    strValue = '%' + strValue + '%';

				if (objValue.value == "NULL")
				    strValue = "NULL";
				else
				    strValue = "'" + strValue + "'";

				strQuery = strField + ' ' + obj.value + ' ' + strValue;

				if (blnAndOrSelected == false) {
				    alert('<%=MyBase.GetResourceString("MSG_JOIN_CONDITION")%>');
				    return;
				}

                blnAndOrSelected = false;
                intBracketCount = 0;

                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
			    //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
			    //strUnDoValue = objTxt.innerHTML;
			    //objTxt.innerHTML += strQuery; 
                strUnDoValue = objTxt.innerHTML;
                objTxt.innerHTML += strQuery;
			    //End Modification

            }
            function Bracket_OnClick(strBkt) {
                if (strBkt == '(') {
                    if (blnAndOrSelected == false) {
                        alert('<%=MyBase.GetResourceString("MSG_JOIN_CONDITION")%>');
					    return;
					}

                    intBracketCount += 1;
                }
                else if (strBkt == ')')
                { intBracketCount -= 1; }

                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
			    //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
			    //strUnDoValue = objTxt.innerHTML;
			    //objTxt.innerHTML += ' ' + strBkt + ' ';				
                strUnDoValue = objTxt.innerHTML;
                objTxt.innerHTML += ' ' + strBkt + ' ';
			    //End Modification

            }
            function Operator_OnClick(strOp) {
                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
                //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                //strUnDoValue = objTxt.innerHTML;
                //objTxt.innerHTML += ' ' + strOp + ' ';

                strUnDoValue = objTxt.innerHTML;
                objTxt.innerHTML += ' ' + strOp + ' ';
                //End Modification
                blnAndOrSelected = true;
            }
            function Clear_OnClick() {
                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
                //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                //strUnDoValue = objTxt.innerHTML;
                //objTxt.innerHTML = '';
                strUnDoValue = objTxt.innerHTML;
                objTxt.innerHTML = '';
                //End modification	
                blnAndOrSelected = true;
                intBracketCount = 0;
                strReDoValue = '';
            }
            function Redo_OnClick() {
                var objTxt;

                if (blnReDoFlag == true) {
                    objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');
                    //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                    //strUnDoValue=objTxt.innerHTML;
                    //objTxt.innerHTML = strReDoValue;
                    strUnDoValue = objTxt.innerHTML;
                    objTxt.innerHTML = strReDoValue;
                    //End Modification
                    blnReDoFlag = false;
                }
            }
            function Undo_OnClick() {
                var objTxt;
                objTxt = GetObjectReference('frmTaskDetails', 'txtQueryText');

                //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                //if(Trim(objTxt.innerHTML)!='')
                if (Trim(objTxt.innerHTML) != '') {
                    //strReDoValue = objTxt.innerHTML;
                    strReDoValue = objTxt.innerHTML;
                    //End Modification
                    blnReDoFlag = true;
                    //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
                    //objTxt.innerHTML = strUnDoValue;
                    objTxt.innerHTML = strUnDoValue;
                    //End Modification
                    strUnDoValue = '';
                    blnAndOrSelected = true;
                    intBracketCount = 0;
                }
            }
            function Paging_OnClick(chr) {
                objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=m_strMode%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=" + chr + "&OrderBy=<%=m_strOrderBy%>&SortOrder=<%=m_strSortOrder%>";
			    objform.submit();
			}
			function Sort_OnClick(sortby, sortorder) {
			    objform.action = "PM_TaskDetails.aspx?MasterTagID=406&Mode=<%=m_strMode%>&Execute=<%=CONST_ACTION_EXECUTE%>&Alphabet=<%=m_strAlphabet%>&OrderBy=" + sortby + "&SortOrder=" + sortorder;
			    objform.submit();
			}
			//Added by HarshK for sp4 issueid 200(popup page for selecting type) on 14/09/2005
			function ImgButton_OnClick(strWhichPage) {
			    var objSelectedID;
			    var strID;
			    if (strWhichPage == "DELIVERABLE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColDeliverable');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=TaskMap&DeliverableID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "FEATURE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColFeature');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=786&FromWhere=TaskMap&XXXID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "MILESTONE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColMilestone');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=3064&FromWhere=TaskMap&MileStoneID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "SUBPROJECT") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColSubProject');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=3065&FromWhere=TaskMap&SubProjectID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "MODULE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColModule');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=3063&FromWhere=TaskMap&ModuleID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "PHASE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColPhase');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=3067&FromWhere=TaskMap&ProjectPhaseID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }
			    else if (strWhichPage == "TASKTYPE") {
			        objSelectedID = GetObjectReference('frmTaskDetails', 'cboColTaskType');
			        if (objSelectedID.value == "")
			            strID = "0";
			        else strID = objSelectedID.value
			        strID = strID.substring(0, strID.indexOf("|"));
			        window.open('../General/CommonList.aspx?MasterTagID=3066&FromWhere=TaskMap&TaskTypeID=' + strID, '', 'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800) / 2 + ',top=' + (window.screen.height - 500) / 2 + ',width=800,height=500');
			    }

			    //     
			}
			//End Added by HarshK for sp4 issueid 200(popup page for selecting type) on 14/09/2005

			//Added By GokulP 08 Sept 2009
			//Purpose: To validate Task assignment for baseline (IssueID 33076)

			var strResult = "";
			function ValidateTask_Baseline(url) {
			    // TO SEE IF WE ARE RUNNING IN IE 
			    strNavigator = navigator.appName;
			    strNavigator = strNavigator.toUpperCase();

			    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
			    //if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
			    if (brw == "IE") {
			        g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
			        //hook the event handler
			        g_objXHttp.onreadystatechange = TaskValidation_state_change;
			        //prepare the call, http method=GET, false=asynchronous call
			        g_objXHttp.open("GET", strUrl, false);
			        //finally send the call
			        g_objXHttp.send();
			    }
			    else {

			        // Mozilla - based browser , Netscape
			        g_objXHttp = new XMLHttpRequest();
			        //hook the event handler
			        g_objXHttp.onreadystatechange = TaskValidation_state_change;
			        //prepare the call, http method=GET, false=asynchronous call
			        g_objXHttp.open("GET", strUrl, false);
			        //finally send the call
			        g_objXHttp.send(null);

			        if (g_objXHttp.responseText != null) {
			            xmlDoc = document.implementation.createDocument("", "", null);
			            xmlDoc.async = false;
			            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
			            if (brw == "FF")
			                xmlDoc.load(g_objXHttp.responseXML);
			            strResult = g_objXHttp.responseText;
			        }

			    }
			    return strResult;
			}
			var brw = isIE();
			function TaskValidation_state_change() {

			    if (g_objXHttp.readyState == 4) {

			        // Make sure request came back OK 
			        if (g_objXHttp.status == 200) {
			            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
			            //if (window.ActiveXObject)
			            if (brw == "IE") {
			                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
			                xmlDoc.async = false;
			                xmlDoc.loadXML(g_objXHttp.responseText);

			            }
			                // code for Mozilla, etc.
			            else if (document.implementation && document.implementation.createDocument) {
			                xmlDoc = document.implementation.createDocument("", "", null);
			                xmlDoc.async = false;
			                //added by Nilesh g on 10/12/2015 for issue id 2721
			                if (brw == "FF")
			                    xmlDoc.load(g_objXHttp.responseXML);
			            }

			            //Save the Result in a Global variable
			            strResult = g_objXHttp.responseText;

			        }
			    }
			}
			//End Addition By GokulP 08 Sept 2009

	</script>		
	</body>
</HTML>
