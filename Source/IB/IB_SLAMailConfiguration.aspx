<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_SLAMailConfiguration.aspx.vb" Inherits="PbNIT.IB_SLAMailConfiguration" ValidateRequest="False"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
    
	
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmSLAConfigureMails" method="post" runat="server">
				<%WritePage%>
		</form>
		<script language="javascript">
		
		var objForFocus;
		objForFocus = GetObjectReference('frmSLAConfigureMails','txtAlertBefore');
		setFocus(objForFocus);
		
				<%If m_strAction = ACTION_SAVE Then%>
					window.close();
				<%End If%>
				var objForm, objdivlist;
				
				objForm = GetFormReference('frmSLAConfigureMails');
				
				<%' Added By SonalD on 12th Jan 2009 %>
		        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                    disableRightClick();
		        <%End If%>
		        <%' Added By SonalD on 12th Jan 2009 %>
				
				function window_onload()
					{
						// PURPOSE: To resize the DIV size depending on the screen resolution.
						var intDivHeight, objdivlist;
						
						objdivlist = GetObjectReference('frmSLAConfigureMails','divListStatus');
						if(objdivlist != null)
						{
							intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
							intDivHeight = ( intDivHeight / 3 );
							if (intDivHeight < 100)	intDivHeight = 100;		// Let the minimum height of the div tag be 100
							objdivlist.style.height = intDivHeight;	
						}
						objdivlist = GetObjectReference('frmSLAConfigureMails','divListResources');
						if(objdivlist != null)
						{
							intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
							if (intDivHeight < 100)	intDivHeight = 100;		// Let the minimum height of the div tag be 100
							objdivlist.style.height = intDivHeight +'px';	
						}
					}
			
				function window_onresize()		
				{
					// PURPOSE: To resize the DIV size depending on the screen resolution.
					var intDivHeight, objdivlist;
					
					objdivlist = GetObjectReference('frmSLAConfigureMails','divListStatus');
					if(objdivlist != null)
					{
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
						intDivHeight = ( intDivHeight / 3 );
						if (intDivHeight < 100)	intDivHeight = 100;		// Let the minimum height of the div tag be 100
						objdivlist.style.height = intDivHeight;	
					}
					objdivlist = GetObjectReference('frmSLAConfigureMails','divListResources');
					if(objdivlist != null)
					{
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
						if (intDivHeight < 100)	intDivHeight = 100;		// Let the minimum height of the div tag be 100
						objdivlist.style.height = intDivHeight +'px';	
					}
				}
			
				function Save_OnClick()
				{
					var objchkIssueStatus, objMailToEmployeeIDList, blnStatusSelected = false, intCtr;
					var objAlertBefore,objAlertBeforeUnit;
					var objProjectSLANorm, objProjectSLANormUnit;
					var objstrSLANormUnit, objstrAlertBeforeUnit;
					var objProjectSLANormHours,objAlertBeforeHours;
					objchkIssueStatus = GetObjectReference('frmSLAConfigureMails','chkIssueStatus',true);
					objMailToEmployeeIDList = GetObjectReference('frmSLAConfigureMails','txthidMailToEmployeeIDList');
					<%If m_strAlert = "Alert" Then%>
						
						// alert('in alert');
					
						objAlertBefore=GetObjectReference('frmSLAConfigureMails','txtAlertBefore',true);
						objAlertBeforeUnit=GetObjectReference('frmSLAConfigureMails','cboAlertBeforeUnit',true);
						objProjectSLANorm=GetObjectReference('frmSLAConfigureMails','txthidProjectSLANorm',true);
						objProjectSLANormUnit=GetObjectReference('frmSLAConfigureMails','txthidProjectNormUnit',true);
						/*
						alert(getInputValue(objAlertBefore));
						alert(getInputValue(objAlertBeforeUnit));
						
						alert(getInputValue(objProjectSLANorm));
						alert(getInputValue(objProjectSLANormUnit));
						
						alert(objProjectSLANorm.value);
						alert(objProjectSLANormUnit.value); */
						
						if(objAlertBefore !=null)
						{//Modified by PurvaJ on 13 july 2006 roamware customization 'replace function added
						  if (disallowBlank(objAlertBefore,"<%=Replace(MyBase.GetResourceString("MSG_ALERTBEFORE"),"&#39;","'")%>",true))
								return ;
						  if(disallowNegativeNumericValueOfPointOneLess(objAlertBefore,"<%=Replace(MyBase.GetResourceString("MSG_ALERTBEFORE_NEGATIVENUMERIC"),"&#39;","'")%>",true))
								return;
							
						  if (getInputValue(objProjectSLANormUnit)==getInputValue(objAlertBeforeUnit))
								{
								// alert('Same Unit');
									//Modified by TruptiK on 23-Oct-2007
									//Purpose:-getInputValue() function returnd string convert it into float.
									//if(getInputValue(objProjectSLANorm)<=getInputValue(objAlertBefore))
									if (parseFloat(getInputValue(objProjectSLANorm))<=parseFloat(getInputValue(objAlertBefore)))
									//if(objAlertBefore.value<=objProjectSLANorm.value)
									//End of modification by TruptiK on 23-Oct-2007
										{
											//modified by purvaj on 13 july 2006 roamware customization
										   	alert("<%=Replace(MyBase.GetResourceString("MSG_VALUE_COMPARISON"),"&#39;","'")%>");
										   	//End modification purvaj
										   	//Added by TruptiK on 19-Nov-2007
										   	//Purpose:-To set focus on alerbefore
										   	setFocus(objForFocus);
										   	//end of addition by TruptiK
											return;
										}
								}
						  else
								{
									objstrSLANormUnit=getInputValue(objProjectSLANormUnit);
									objstrAlertBeforeUnit=getInputValue(objAlertBeforeUnit);
									if (objstrSLANormUnit.toUpperCase()=="DAYS")
										{
											objProjectSLANormHours=getInputValue(objProjectSLANorm)*24;
										}
									else
										{
											objProjectSLANormHours=getInputValue(objProjectSLANorm);
										}
									if	(objstrAlertBeforeUnit.toUpperCase()=="DAYS")
										{
											objAlertBeforeHours=getInputValue(objAlertBefore)*24;
										}
									else
										{
											objAlertBeforeHours=getInputValue(objAlertBefore);
										}
									if	( objProjectSLANormHours<=objAlertBeforeHours)
										{
										   //modified by purvaj on 13 july 2006 roamware customization
										   alert("<%=Replace(MyBase.GetResourceString("MSG_VALUE_COMPARISON"),"&#39;","'")%>");
										   //End Modification purvaj
										   	//Added by TruptiK on 19-Nov-2007
										   	//Purpose:-To set focus on alerbefore
										   	setFocus(objForFocus);
										   	//end of addition by TruptiK
											return;
										}
								}										
						}
						if(objAlertBeforeUnit !=null)
						{   //Modified by PurvaJ on 13 july 2006 roamware customization 'replace function added
							if (disallowBlank(objAlertBeforeUnit,"<%=Replace(MyBase.GetResourceString("MSG_ALERTBEFOREUNIT"),"&#39;","'")%>",true))
															return ;
						}
					<%End If%>
					if(objchkIssueStatus != null)
					{
						for(intCtr=0; intCtr < objchkIssueStatus.length; intCtr++)
						{
							if(objchkIssueStatus[intCtr].checked == true)
							{
								blnStatusSelected = true;
								break;
							}
						}
					}
					// If at least status value is selected, then...	
					if(blnStatusSelected == true)
					{
						if(disallowBlank(objMailToEmployeeIDList, "<%=MyBase.GetResourceString("SELECT_RESOURCE")%>"))
							return;
						if(objMailToEmployeeIDList.value == ",")
						{
							alert("<%=MyBase.GetResourceString("SELECT_RESOURCE")%>");
							return;
						}
					}
					objForm.action = "IB_SLAMailConfiguration.aspx?Action=<%=ACTION_SAVE%>&ProjectSLADetailID=<%=m_strProjectSLADetailID%>&From=<%=m_strAlert%>";
					objForm.submit();
				}
				
				function ConfigureMails_OnClick(strProjectIssueStatus)
				{
					// PURPOSE: To configure the mails (specific to a status).
					window.open("IB_SLAMailConfiguration.aspx?From=<%=m_strAlert%>&ProjectIssueType=<%=Server.URLEncode(m_strProjectIssueType)%>&ProjectIssueStatus=" + URLEncode(strProjectIssueStatus) ,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
				}

				function URLEncode(strQSParameter)
				{
					// PURPOSE: To handle the special characters in the query string.
					var strReturn = '';

					strReturn = strQSParameter;
					strReturn = replaceSubstring(strReturn, "#", "%23");
					strReturn = replaceSubstring(strReturn, "%", "%25");
					strReturn = replaceSubstring(strReturn, "&", "%26");
					strReturn = replaceSubstring(strReturn, "+", "%2B");
					return(strReturn);
				}
			
				function chkMailToList_OnClick(strEmployeeID)
				{
					var objToCheckBox, objCcCheckBox, objMailToEmployeeIDList, strMailToEmployeeIDList;
					var strTempArray, intCtr;
					
					objToCheckBox = GetObjectReference('frmSLAConfigureMails','chkMailToEmployeeID_' + strEmployeeID);
					objCcCheckBox = GetObjectReference('frmSLAConfigureMails','chkMailCCToEmployeeID_' + strEmployeeID);
					objMailToEmployeeIDList = GetObjectReference('frmSLAConfigureMails','txthidMailToEmployeeIDList');
					strMailToEmployeeIDList = objMailToEmployeeIDList.value;
					if(objToCheckBox.checked == true)
					{
						if(isSubstringExists(strMailToEmployeeIDList, "," + objToCheckBox.value + ",") == false)
							strMailToEmployeeIDList = strMailToEmployeeIDList + objToCheckBox.value + ",";
						objCcCheckBox.disabled = true;
					}
					else
					{
						if(isSubstringExists(strMailToEmployeeIDList, "," + objToCheckBox.value + ",") == true)
						{	
							strTempArray = strMailToEmployeeIDList.split(",");
							strMailToEmployeeIDList = ',';
							for(intCtr=0 ; intCtr < strTempArray.length ; intCtr++)
							{	
								if((strTempArray[intCtr] != objToCheckBox.value) && (strTempArray[intCtr] != ""))
									strMailToEmployeeIDList = strMailToEmployeeIDList + strTempArray[intCtr] + ',';
							}
						}
						objCcCheckBox.disabled = false;
					}
					objMailToEmployeeIDList.value = strMailToEmployeeIDList;
				}
				
				function chkMailCCToList_OnClick(strEmployeeID)
				{
					var objToCheckBox, objCcCheckBox, objMailCcToEmployeeIDList, strMailCcToEmployeeIDList;
					var strTempArray, intCtr;
					
					objCcCheckBox = GetObjectReference('frmSLAConfigureMails','chkMailCCToEmployeeID_' + strEmployeeID);
					objToCheckBox = GetObjectReference('frmSLAConfigureMails','chkMailToEmployeeID_' + strEmployeeID);
					objMailCcToEmployeeIDList = GetObjectReference('frmSLAConfigureMails','txthidMailCCToEmployeeIDList');
					strMailCcToEmployeeIDList = objMailCcToEmployeeIDList.value;
					if(objCcCheckBox.checked == true)
					{
						if(isSubstringExists(strMailCcToEmployeeIDList, "," + objCcCheckBox.value + ",") == false)
							strMailCcToEmployeeIDList = strMailCcToEmployeeIDList + objCcCheckBox.value + ",";
						objToCheckBox.disabled = true;
					}
					else
					{
						if(isSubstringExists(strMailCcToEmployeeIDList, "," + objCcCheckBox.value + ",") == true)
						{	
							strTempArray = strMailCcToEmployeeIDList.split(",");
							strMailCcToEmployeeIDList = ',';
							for(intCtr=0 ; intCtr < strTempArray.length ; intCtr++)
							{	
								if((strTempArray[intCtr] != objCcCheckBox.value) && (strTempArray[intCtr] != ""))
									strMailCcToEmployeeIDList = strMailCcToEmployeeIDList + strTempArray[intCtr] + ',';
							}
						}
						objToCheckBox.disabled = false;
					}
					objMailCcToEmployeeIDList.value = strMailCcToEmployeeIDList;
				}
				
				function Page_Onclick(strPageNumber)
				{
					var objPageNumber;
					
					objPageNumber = GetObjectReference('frmSLAConfigureMails','txthidPageNumber');
					objPageNumber.value = strPageNumber;
					objForm.action = "IB_SLAMailConfiguration.aspx?From=<%=m_strAlert%>&ProjectSLADetailID=<%=m_strProjectSLADetailID%>";
					objForm.submit();
				}
				function disallowNegativeNumericValueOfPointOneLess(obj)
				{
					if (obj == null) {return false;} 
					if (isBlank(getInputValue(obj))) {return false;}
					var msg=(arguments.length>1)?arguments[1]:"";
					msg=replaceSubstring(msg,"&#39;","'");
					var dofocus=(arguments.length>2)?arguments[2]:true;
					if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
					else if (getInputValue(obj) < 0.1) 
					{
						if(!isBlank(msg)){alert(msg);}
						if(dofocus)
						{
							setFocus(obj);
						}
					return true;
					}	
					return false;
				}
					</script>
	</body>
</HTML>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

// Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade
// <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
// End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
