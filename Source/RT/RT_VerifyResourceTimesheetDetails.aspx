<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_VerifyResourceTimesheetDetails.aspx.vb" Inherits="PbNIT.RT_VerifyResourceTimesheetDetails" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
	
	<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 );}
	#Tajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	#Tajax_tooltipObj DIV { POSITION: absolute; }
	#Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	#Bajax_tooltipObj DIV { POSITION: absolute; }
	#Tajax_tooltipObj .ajax_tooltip_TLarrow { BACKGROUND-POSITION: right top; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }
	#Bajax_tooltipObj .ajax_tooltip_BRarrow { BACKGROUND-POSITION: bottom right ; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/BRarrow.gif'); BACKGROUND-REPEAT: no-repeat; }
	#Tajax_tooltipObj .ajax_tooltip_Tcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; top:18px }
	#Bajax_tooltipObj .ajax_tooltip_Bcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	</STYLE>
	
	
		<form id="frmVerifyResourceTimesheetDetails" name="frmVerifyResourceTimesheetDetails"
			method="post" runat="server">
			<%PageInit()%>
			<DIV id="Tajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
				<DIV class="ajax_tooltip_Tcontent" id="Tajax_tooltip_content" ></DIV> <!-- followign code removed by purvaj on 30 jun 2009 8.1 issue fixes. Div was not getting displayed at the proper place
				             style="POSITION: absolute; TOP: 165px" -->
				<DIV class="ajax_tooltip_TLarrow" id="Tajax_tooltip_arrow"></DIV>
			</DIV>
			<DIV id="Bajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
				<DIV class="ajax_tooltip_Bcontent" id="Bajax_tooltip_content"></DIV>
				<DIV class="ajax_tooltip_BLarrow" id="Bajax_tooltip_arrow" ></DIV>
			</DIV>
		</form>
		<script language="javascript">
			var objDivMain = GetObjectReference('frmVerifyResourceTimesheetDetails','DivMain');
			var objForm;
			objForm = GetFormReference('frmVerifyResourceTimesheetDetails');
			
			var blnSelectAll;
			blnSelectAll = false;
	        var gEvt;
			var box,arr,con;
			var wbox,hbox; 
			var bwidth = document.body.offsetWidth;
			var bheight = document.body.offsetHeight;
		    
		    <%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
		    
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;

					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight	;
			objDivMain.style.height = intDivHeight + 'px';
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				    intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight	;	
				objDivMain.style.height = intDivHeight + 'px';
			}
			
			
			/* Ported Code*/
			
			function ShowHelp()
			{
				window.open("../General/Help.aspx?HelpID=<%=m_TagVerifyTimesheetList%>","","resizable=yes,scrollbars=yes,Left=0,Top=0,height=250,width=250");
			}
			
					
			function Back_OnClick()
			{
					//window.location.href = "../General/CommonList.aspx?FromWhere=SM&MasterTagID=<%=m_TagVerifyTimesheetList%>";
				//modofied by harshK on 11/08/2005 - issue ID - 86 - SP4
				window.location.href = "../RT/RT_TimesheetApproval.aspx";
				
				
			}
			
			
			function UnverifyTimesheet()
			{
				var OneChecked;
				OneChecked = false;
				//alert('Code Entering');
						var blnSaveRemarks;
						var blnChecked;
						
						var blnRemarksAdded;
						var objText;
						
						var blnAtLeastOneRemark;
						var blnAtlEastOneChecked;
						var strRemarksID;
						
						blnSaveRemarks = false;
						blnChecked=false;
						blnRemarksAdded = false;
						
						blnAtLeastOneRemark=false;
						blnAtlEastOneChecked=false;
						
						//Code Added by Noble K on 20th Jan 2005 to check whether The Remarks textbox does not 
						//allow only blank spaces
						var blnAtleastOneCharacter = true;
						var intCharacterPosition = 0;
						var intLengthOfRemarks;
						var blnNoRemarks;
						//End of Code Added by Noble K on 20th Jan 2005
						
				var objchkVerify = GetObjectReference('frmVerifyResourceTimesheetDetails','chkVerify',true);
				
				if(objchkVerify!=null)
				{
										
								
						intArrayLength = objchkVerify.length;
						//alert(intArrayLength);
						if(intArrayLength==1)
						{
						
							if(objchkVerify[0].checked == false)
							{
								blnChecked=false;
							}
							else
							{
								blnChecked=true;
							}
							
						
							strRemarksID = 'txtRemarks' + objchkVerify[0].value;
							objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
														
							
							if(isBlank(objText.value) == true)
							{
								blnRemarksAdded = false;
							}
							else
							{
								blnRemarksAdded = true;
							}
								//alert('blnChecked=' + blnChecked);
								//alert('blnRemarksAdded=' + blnRemarksAdded)
								//alert(SaveWithVerification);
								
								
								//Code Addition by Noble K on 20th Jan 2005 Starts
								if(blnRemarksAdded == true)
								{
									blnNoRemarks = false;
									blnAtleastOneCharacter = true;
									var strText = objText.value;
									//alert(strText);
									intLengthOfRemarks = strText.length;
									//alert(intLengthOfRemarks);
									/*if(intLengthOfRemarks == 0)
									{
										alert('Remarks cannot be blank. Please enter the Remarks');
										return;
									}*/
									for(intCharacterPosition = 0 ; intCharacterPosition < intLengthOfRemarks ; intCharacterPosition++ )
									{
										if(strText.charAt(intCharacterPosition)==" ")
										{
											blnAtleastOneCharacter = false;
											//alert("if...strText.charAt(intCharacterPosition)==' '")
										}
										else
										{
											blnAtleastOneCharacter = true;
											//alert("else...strText.charAt(intCharacterPosition)==' '")
											break;
										}
									}
									if(blnAtleastOneCharacter == false)
									{
										//alert("If....blnAtLeastOneCharacter == false");
										alert('Remarks cannot be blank. Please enter the Remarks');
										objText.focus();
										return;
									}
								}
								//Code Addition by Noble K on 20th Jan 2005 Ends
								
								
								if(blnRemarksAdded == false)
								{
									alert('Add remarks to atleast one activity');
									return;
								}
						}	
						
						else
						{ 
							for (var intCtr = 0;intCtr <= intArrayLength - 1; intCtr++)
							{
								if(! objchkVerify[intCtr].checked) 
								{
									blnChecked=false;
								}
								else
								{
									blnChecked=true;
									
								}
								if(blnAtlEastOneChecked == false)
								{
									if(objchkVerify[intCtr].checked)
									{
										blnAtlEastOneChecked = true;
									}	
								}
								strRemarksID = 'txtRemarks' + objchkVerify[intCtr].value;
								objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
								if(isBlank(objText.value) == true)
								{
									blnRemarksAdded = false;
								}
								else
								{
									blnRemarksAdded = true;
								}
								if(blnAtLeastOneRemark == false)
								{
									if(objText.value != '')
									{
										blnAtLeastOneRemark = true;
									}
								}

								//Code Addition by Noble K on 20th Jan 2005 Starts
								if(blnChecked == false)
								{
									blnNoRemarks = false;
									blnAtleastOneCharacter = true;
									var strText = objText.value;
									//alert(strText);
									intLengthOfRemarks = strText.length;
									//alert(intLengthOfRemarks);
									/*if(intLengthOfRemarks == 0)
									{
										alert('Remarks cannot be blank. Please enter the Remarks');
										return;
									}*/
									for(intCharacterPosition = 0 ; intCharacterPosition < intLengthOfRemarks ; intCharacterPosition++ )
									{
										if(strText.charAt(intCharacterPosition)==" ")
										{
											blnAtleastOneCharacter = false;
											//alert("if...strText.charAt(intCharacterPosition)==' '")
										}
										else
										{
											blnAtleastOneCharacter = true;
											//alert("else...strText.charAt(intCharacterPosition)==' '")
											break;
										}
									}
									if(blnAtleastOneCharacter == false)
									{
										//alert("If....blnAtLeastOneCharacter == false");
										alert('Remarks cannot be blank. Please enter the Remarks');
										objText.focus();
										return;
									}
								}
								//Code Addition by Noble K on 20th Jan 2005 Ends
							}
							
							if(blnAtLeastOneRemark == false)
							{
								
								alert('Add remarks to atleast one activity to reject TimeSheet');
								return;
							}
							//}
						}
						if(confirm("Are you sure you want to reject this timesheet and save the remarks for the unchecked tasks?"))
						{
							objForm.action = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=<%=m_strTimesheetID%>&EmployeeID=<%=strResourceID%>&Mode=Unverify&SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&TimesheetStatus=<%=m_strTimesheetStatus%>";
							objForm.submit();
						}
					//}
				}
			}
			
			function VerifyAll()
			{
				VerifySelectAll_OnClick('frmVerifyResourceTimesheetDetails','chkVerify');		
			}  
			
			function VerifySelectAll_OnClick(strFormName, strCheckbox)
			{
				var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
				var intItems;
				var intCtr;
				var strRemarksID;
				var objText;
				
				if (objCheckbox != null)
				{
					intItems = objCheckbox.length;
					if(intItems > 1) 
					{
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{
							if (objCheckbox[intCtr].disabled == false)
							{
								objCheckbox[intCtr].checked = true;	
								strRemarksID = 'txtRemarks' + objCheckbox[intCtr].value;
								objText= GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
								objText.value = '';
								objText.disabled = true;
							}							
						}
					}
					
					// Else, if single element exists, then...
					else if(intItems == 1)
					{
						if (objCheckbox[0].disabled == false) 
						{
							objCheckbox[0].checked = true;
							strRemarksID = 'txtRemarks' + objCheckbox[0].value;
							objText= GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
							objText.value = '';
							objText.disabled = true;						
						}
					}
				
				}
			}
			
			
			function VerifyClearAll_OnClick(strFormName, strCheckbox)
			{
				var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
				var intItems;
				var intCtr;
				var strRemarksID;
				var objText;
				
				
				if (objCheckbox != null)
				{
					
					intItems = objCheckbox.length;			
					if(intItems > 1) 
					{
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{
							if (objCheckbox[intCtr].disabled == false)
							{
								objCheckbox[intCtr].checked = false;
								strRemarksID = 'txtRemarks' + objCheckbox[intCtr].value;
								objText= GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
								objText.disabled = false;
							}
															
						}
					}
				
					// Else, if single element exists, then...
					else if(intItems == 1)
					{
						if (objCheckbox[0].disabled == false) 
						{
							objCheckbox[0].checked = false;						
							strRemarksID = 'txtRemarks' + objCheckbox[0].value;
							objText = GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
							objText.disabled = false;
						}
					}
				
				}
			}
			
			
			function ClearAll()
			{
				VerifyClearAll_OnClick('frmVerifyResourceTimesheetDetails','chkVerify');		
			}
			
			
			/* Save_OnClick()*/
			function Save_OnClick(SaveWithVerification)
			{	
						//alert('Save_OnClick()');
						var blnSaveRemarks;
						var blnChecked;
						var blnRemarksAdded;
						var objText;
						
						var blnAtLeastOneRemark;
						var blnAtlEastOneChecked;
						var strRemarksID;
						
						//Code Added by Noble K on 20th Jan 2005 to check whether The Remarks textbox does not 
						//allow only blank spaces
						var blnAtleastOneCharacter = true;
						var intCharacterPosition = 0;
						var intLengthOfRemarks;
						var blnNoRemarks;
						//End of Code Added by Noble K on 20th Jan 2005						
						
						
						blnSaveRemarks = false
						blnChecked=false
						blnRemarksAdded = false
						
						blnAtLeastOneRemark=false
						blnAtlEastOneChecked=false
						
						var objchkVerify = GetObjectReference('frmVerifyResourceTimesheetDetails','chkVerify',true);
						intArrayLength = objchkVerify.length;
						
						
						
						//alert(intArrayLength);
						if(intArrayLength==1)
						{
							if(objchkVerify[0].checked == false)
							{
								blnChecked=false;
							}
							else
							{
								blnChecked=true;
							}
							
							strRemarksID = 'txtRemarks' + objchkVerify[0].value;
							objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
														
							
							if(isBlank(objText.value) == true)
							{
								blnRemarksAdded = false;
							}
							else
							{
								blnRemarksAdded = true;
							}
							
							
								//alert('blnChecked=' + blnChecked);
								//alert('blnRemarksAdded=' + blnRemarksAdded)
								//alert(SaveWithVerification);
							
							//Code Addition by Noble K on 20th Jan 2005 Starts
								if(blnRemarksAdded == true)
								{
									blnNoRemarks = false;
									blnAtleastOneCharacter = true;
									var strText = objText.value;
									//alert(strText);
									intLengthOfRemarks = strText.length;
									//alert(intLengthOfRemarks);
									/*if(intLengthOfRemarks == 0)
									{
										alert('Remarks cannot be blank. Please enter the Remarks');
										return;
									}*/
									for(intCharacterPosition = 0 ; intCharacterPosition < intLengthOfRemarks ; intCharacterPosition++ )
									{
										if(strText.charAt(intCharacterPosition)==" ")
										{
											blnAtleastOneCharacter = false;
											//alert("if...strText.charAt(intCharacterPosition)==' '")
										}
										else
										{
											blnAtleastOneCharacter = true;
											//alert("else...strText.charAt(intCharacterPosition)==' '")
											break;
										}
									}
									if(blnAtleastOneCharacter == false)
									{
										//alert("If....blnAtLeastOneCharacter == false");
										alert('Remarks cannot be blank. Please enter the Remarks');
										obtText.focus();
										
										return;
									}
								}
								//Code Addition by Noble K on 20th Jan 2005 Ends
							
							
							
							if(SaveWithVerification == '0')  //Save remarks 
							{
								if(blnRemarksAdded == false)
								{
									alert('Add remarks to atleast one activity');
									return;
								}
							}
							else //Only Verify
							{
								if(blnChecked == false) 
								{
									alert('Select Activities to approve.');
									return;
								}
							}	
							if(blnChecked == true && blnRemarksAdded == true)
							{ 
								alert("Uncheck activities for which remarks are added"); 
								return;
							}
						}	
						
						else
						{ 
							for (var intCtr = 0;intCtr <= intArrayLength - 1; intCtr++)
							{
								if(! objchkVerify[intCtr].checked) 
								{
									blnChecked=false;
								}
								else
								{
									blnChecked=true;
								}
								

								if(blnAtlEastOneChecked == false)
								{
									if(objchkVerify[intCtr].checked)
									{
										blnAtlEastOneChecked = true;
									}	
									
								}
								
								strRemarksID = 'txtRemarks' + objchkVerify[intCtr].value;
								objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
								if(isBlank(objText.value) == true)
								{
									blnRemarksAdded = false;
								}
								else
								{
									blnRemarksAdded = true;
								}
								
								if(blnChecked == true && blnRemarksAdded == true)
								{
									alert('Uncheck activities for which remarks are added'); 
									return;
								}
								
								//Code Addition by Noble K on 20th Jan 2005 Starts
								if(blnChecked == false)
								{
									blnNoRemarks = false;
									blnAtleastOneCharacter = true;
									var strText = objText.value;
									//alert(strText);
									intLengthOfRemarks = strText.length;
									//alert(intLengthOfRemarks);
									/*if(intLengthOfRemarks == 0)
									{
										alert('Remarks cannot be blank. Please enter the Remarks');
										return;
									}*/
									for(intCharacterPosition = 0 ; intCharacterPosition < intLengthOfRemarks ; intCharacterPosition++ )
									{
										if(strText.charAt(intCharacterPosition)==" ")
										{
											blnAtleastOneCharacter = false;
											//alert("if...strText.charAt(intCharacterPosition)==' '")
										}
										else
										{
											blnAtleastOneCharacter = true;
											//alert("else...strText.charAt(intCharacterPosition)==' '")
											break;
										}
									}
									if(blnAtleastOneCharacter == false)
									{
										//alert("If....blnAtLeastOneCharacter == false");
										alert('Remarks cannot be blank. Please enter the Remarks');
										objText.focus();
									  
										return;
									}
								}
								//Code Addition by Noble K on 20th Jan 2005 Ends
								
								
								if(blnAtLeastOneRemark == false)
								{
									if(objText.value != '')
									{
										blnAtLeastOneRemark = true;
									}
									
								}
								
							}
							
							if(SaveWithVerification == '0') //Save remoarks 
							{
								if(blnAtLeastOneRemark == false)
								{
									alert('Add remarks to atleast one activity');
									return;
								}
							}
							else
							{
								if(blnAtlEastOneChecked == false)
								{
									alert('Select Activities to approve.');
									return;
								}
							}
							
						}
						
						
						///if(confirm("Are you sure you want to reject this timesheet ?"))
						//{
						    //Modified by RajkumarM on 6-Oct-2008
						    //objForm.action = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=<%=m_strTimesheetID%>&EmployeeID=<%=strResourceID%>&Mode=Verify&Verification=" + SaveWithVerification + "&SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&TimesheetStatus=<%=m_strTimesheetStatus%>;
							objForm.action = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID=<%=m_strTimesheetID%>&EmployeeID=<%=strResourceID%>&Mode=Verify&Verification=" + SaveWithVerification + "&SortField=<%=strSortByField%>&SortOrder=<%=strAscOrDesc%>&TimesheetStatus=<%=m_strTimesheetStatus%>&Chkcount=" + intArrayLength;
							//end of modification by RajkumarM ends
							objForm.submit();
						//}
				}
			/*End*/
			
			
			/*End*/
			function txtRemarks_OnClick(intCount)
			{
				var objchkVerify = GetObjectReference('frmVerifyResourceTimesheetDetails','chkVerify',true);
				objchkVerify[intCount - 1].checked = false;
			}
			function chkVerify_OnClick(intCount,intEntryID)
			{
				var objText;	
				var strRemarksID;
				var objchkVerify = GetObjectReference('frmVerifyResourceTimesheetDetails','chkVerify',true);
				intArrayLength = objchkVerify.length;
				
				if(intArrayLength==1)
				{
					if(objchkVerify[0].checked == true)
					{
						strRemarksID = 'txtRemarks' + objchkVerify[0].value;
						objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
						objText.value = '';
						//objText.disabled = true;
					}
					else
					{
						strRemarksID = 'txtRemarks' + objchkVerify[0].value;
						objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
						objText.disabled = false;
					}
					
				}
				else if(intArrayLength > 1)
				{
					
					if(objchkVerify != null)
					{
						if(objchkVerify[intCount - 1].checked == true)
						{
							
							strRemarksID = 'txtRemarks' + objchkVerify[intCount-1].value;
							objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
							objText.value = '';
							//objText.disabled = true;
						}
						else
						{
							strRemarksID = 'txtRemarks' + objchkVerify[intCount-1].value;
							objText=GetObjectReference('frmVerifyResourceTimesheetDetails',strRemarksID);
							objText.disabled = false;
						}
					}
					
				}
				
			}
			
			
		//Added For History functionality
		function ShowHistory_OnClick(intTimesheetID)
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TimesheetHistoryForApprover%>&ResourceTimesheetID=" + intTimesheetID,null,"Left=125,Top=150,height=450,width=875,status=no,toolbar=no,menubar=no,location=no,resizable=yes")
		}
		//End Addition	
		//Start_AJ_16-Oct-2006
		//Addition By SnehalV 2nd Nov 2006 for WhizibleSEM SP8 Integration
		function Previous_OnClick()		
		{
			var obj = GetObjectReference('frmVerifyResourceTimesheetDetails', 'cboTSIDs');
			if((obj.selectedIndex - 1) < 0)
				alert("You are currently viewing the first Timesheet in the list.");
			else
				{
				var strEmpID, strStatus, strPKToken;
				var strData = '<%=Session("TSIDsWithToken")%>';
				var arrTst = strData.split("#");
				var arrTst1;
				TSID = parseInt(obj.options[obj.selectedIndex-1].value);
				//AUJ
				var obj1 = GetObjectReference('frmVerifyResourceTimesheetDetails','cboTSIDsHidden');
				strStatus=obj1.options[obj.selectedIndex-1].text;
				//AUJ
				for(var i=0; i<arrTst.length-1; i++)
				{
					arrTst1 = arrTst[i].split("+");
						if(arrTst1[0] == TSID)
							{
								strEmpID=arrTst1[1];
								//strStatus=arrTst1[2];
								strPKToken=arrTst1[3];
							}
				}
				
				window.location.href = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID="+ TSID+"&EmployeeID="+strEmpID+"&TimesheetStatus="+strStatus+"&PKToken="+strPKToken+"&TagID=2125"; 
				}
		}
					
		function Next_OnClick()
		{
			var obj = GetObjectReference('frmVerifyResourceTimesheetDetails', 'cboTSIDs');
			
			if((obj.selectedIndex + 1) >= obj.options.length)
				alert("You are currently viewing the last Timesheet in the list.");
			else				
			{
				var strEmpID, strStatus, strPKToken;
				var strData = '<%=Session("TSIDsWithToken")%>';
				var arrTst = strData.split("#");
				var arrTst1;
				
				TSID = parseInt(obj.options[obj.selectedIndex+1].value);
				//AUJ
				var obj1 = GetObjectReference('frmVerifyResourceTimesheetDetails','cboTSIDsHidden');
				strStatus=obj1.options[obj.selectedIndex+1].text;
				//AUJ
				for(var i=0; i<arrTst.length-1; i++)
				{
					arrTst1 = arrTst[i].split("+");
						if(arrTst1[0] == TSID)
							{
								strEmpID=arrTst1[1];
								//strStatus=arrTst1[2];
								strPKToken=arrTst1[3];
							}
				}
			
				window.location.href = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID="+ TSID+"&EmployeeID="+strEmpID+"&TimesheetStatus="+strStatus+"&PKToken="+strPKToken+"&TagID=2125"; 
			}
		}
		
		function cboTSID_OnChange()
		{
			// PURPOSE: To navigate to the selected ExpenseSheet ID in the list.	
			var strData = '<%=Session("TSIDsWithToken")%>';
			var arrTst = strData.split("#");
			var arrTst1;
			var obj = GetObjectReference('frmVerifyResourceTimesheetDetails', 'cboTSIDs');
			TSID = obj.options[obj.selectedIndex].value;
			var strEmpID, strStatus, strPKToken;

			//AUJ
			var obj1 = GetObjectReference('frmVerifyResourceTimesheetDetails','cboTSIDsHidden');
			strStatus=obj1.options[obj.selectedIndex].text;
			//AUJ
			for(var i=0; i<arrTst.length-1; i++)
			{
				arrTst1 = arrTst[i].split("+");
					if(arrTst1[0] == TSID)
						{
							strEmpID=arrTst1[1];
							//strStatus=arrTst1[2];
							strPKToken=arrTst1[3];
						}
			}
			window.location.href = "RT_VerifyResourceTimesheetDetails.aspx?TimesheetID="+ TSID+"&EmployeeID="+strEmpID+"&TimesheetStatus="+strStatus+"&PKToken="+strPKToken+"&TagID=2125"; 
		}
		//End of Addition by SnehalV
		//End_AJ_16-Oct-2006
		//Added by ShraddhaM on 3,Apr 2008 for Task popup.
		function ShowTaskPopUp(evt,TaskID)
		{ 
					
			evt = window.event || evt;
			
			if(!gEvt)
			{
				
				gEvt = evt;
				xPos = evt.clientX || evt.pageX;
				yPos = evt.clientY || evt.pageY;
				 
				var url="RT_VerifyResourceTimesheetDetails.aspx?FromXML=1&TaskID=" + TaskID;
				loadXMLDoc(url,'')	
			}	
	
	}



function loadXMLDoc(url,reqQuery)	
{
	
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change() 
{
	 
	if (parseInt(xmlhttp.readyState)==4) 
	{ 
		if (xmlhttp.status==200)
		{
			SetBox(xmlhttp.responseText);
			gEvt = null;
			xPos=0;
			yPos=0;
			
		}
	}
	
}


function SetBox(resText)
{
		var evt = gEvt;
		if (!evt)					
		return;
		if( yPos < (bheight/2) )
		{
			box = document.getElementById('Tajax_tooltipObj');
			
			document.getElementById('Bajax_tooltipObj').style.display="none";
			
			arr = document.getElementById('Tajax_tooltip_arrow');
			con = document.getElementById('Tajax_tooltip_content');
			
			con.innerHTML = resText;
			box.style.display = "";
			
			wbox = con.firstChild.offsetWidth;
			if ( wbox > (bwidth-50))
			wbox = bwidth-50;
			hbox = con.firstChild.offsetHeight;
			con.style.width = wbox;
				if ((xPos - wbox + 20) < 0)
				{
				    box.style.left = 10;
				
					arr.style.width = xPos -8;
				}
				else
				{
					
					box.style.left = (xPos - wbox + 20)
					arr.style.width = wbox - 20;
				}
				box.style.top = yPos;
				con.className = "ajax_tooltip_Tcontent";
		        // Commnted By Purvaj on 25 Sept 2008 for firefox issue. Div was not getting displayed.
		        if (navigator.appName!="Netscape") 
		        {
		            con.style.width="";
    	            box.style.width="";	
    	        }
                 // End comment Purvaj
		}
		else
		{
	
			box = document.getElementById('Bajax_tooltipObj');
			
			document.getElementById('Tajax_tooltipObj').style.display="none";
			
			arr = document.getElementById('Bajax_tooltip_arrow');
			con = document.getElementById('Bajax_tooltip_content');
			
			
			con.innerHTML = resText;
			// Added By purvaj on 25 sept 2008 for Firefox issue
			if (navigator.appName=="Netscape") 
			{
			    //alert(1);
				con.style.width = '505px';
			}
			// End addition Purvaj
			box.style.display = "";
			
			wbox = con.offsetWidth;
			hbox = con.offsetHeight;
			
			arr.className = "ajax_tooltip_BRarrow";
			
			if((xPos -wbox + 18) < 0)
			{
				box.style.left = 10;
				arr.style.width = xPos - 10;
				
			}
			else
			{
				box.style.left = xPos - wbox + 18;
				arr.style.width = wbox -18;
				
			}
				
			arr.style.height = hbox + 18;
			
			box.style.top = yPos - hbox -18 ;	
			con.className = "ajax_tooltip_Bcontent";
        // Commnted By Purvaj on 25 Sept 2008 for firefox issue. Div was not getting displayed.
        if (navigator.appName!="Netscape") 
        {
	        con.style.width="";
	        box.style.width="";		
        }
        // End comment Purvaj
		}
        
		
}	

function CloseDiv()
{
	if(document.getElementById('btnClose'))
	{
		document.getElementById('btnClose').parentNode.removeChild(document.getElementById('btnClose'));
	}
	
	document.getElementById('Bajax_tooltipObj').style.display="none";
	document.getElementById('Tajax_tooltipObj').style.display="none";
}


		//End of addition by ShraddhaM
		
		</script>
	</body>
</HTML>
