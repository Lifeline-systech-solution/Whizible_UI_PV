<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ChecklistTemplate.aspx.vb" Inherits="PbNIT.PRO_ChecklistTemplate"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><html>
 	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPRO_ChecklistTemplate"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmPRO_ChecklistTemplate');
		var objdivlist=GetObjectReference('frmPRO_ChecklistTemplate','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//var intCustomResponseCount= new Number(0);
		//var intCustomResponseID= new Number(0);
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
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
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}	
					
			var objTmp;
			objTmp = GetObjectReference('frmPRO_ChecklistTemplate','txtChecklistItem');
			objTmp.focus();					
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
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
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}
		}	
		
		function Save_OnClick()
		{
			var strPageNumber_ChecklistItem;
			
			if(ValidateControls()== true)
			{
				//Get the current page number.
				objform.action = "PRO_ChecklistTemplate.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&ChecklistSectionID=<%=m_strChecklistSectionID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&ChecklistID=<%=m_strChecklistID%>&ChecklistItemID=<%=m_strChecklistItemID%>";
				objform.submit();
			}
		}
		function Back_OnClick()
		{
			window.location.href = "../General/CommonList.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&ChecklistID=<%=m_strChecklistID%>&ChecklistSectionID=<%=m_strChecklistSectionID%>";
		}
		function ValidateControls()
		{
			var flag,isValid=false;
			var objTxt,intLen,strValue,i;
			var objChk,objOpt;
			
			objTxt = GetObjectReference('frmPRO_ChecklistTemplate','txtChecklistItem');
			flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_CHECKLISTITEM_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			strValue = new String(objTxt.value);
			flag = disallowMaxlengthViolation(objTxt,1000,'<%=MyBase.GetResourceString("MSG_CHECKLISTITEM_MAX_LEN")%>',true);
			if(flag==true)
				return false;
			
			//duplication validation
			intLen = strChecklistItemsArray.length;
			for(i=0;i<intLen;i++)
				if(strValue.toUpperCase()==strChecklistItemsArray[i])
				{
					alert('<%=MyBase.GetResourceString("MSG_CHECKLISTITEM_DUPLICATE")%>');
					objTxt.focus();
					return false;
				}
				
			//Order Number
			objTxt = GetObjectReference('frmPRO_ChecklistTemplate','txtOrderNumber');
			flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_ORDERNUMBER_EMPTY")%>',true);
			if(flag==true)
				return false;
				
			flag = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_ORDERNUMBER_NAN")%>',true);
			if(flag==true)
				return false;
				
			flag = disallowNegativeNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_ORDERNUMBER_NEGATIVE")%>',true);
			if(flag==true)
				return false;
			
			//standard response format
			objOpt = GetObjectReference('frmPRO_ChecklistTemplate','optStandardFormat');
			if(objOpt.checked==true)
			{
				//Validation : At least one option must be specified. 
				objTxt = GetObjectReference('frmPRO_ChecklistTemplate','txtStandardResponseID',true);
				if(objTxt==null)
				{
					alert('<%=MyBase.GetResourceString("MSG_OPTION_NOT_SPECIFIED")%>');
					return false;
				}
				else
				{
					try
					{
						intLen = objTxt.length;
						var blnOptionSelected = false;
						var blnIsExpectedResponseSelected = true;
						var intStandardResponseID;
						
						if(intLen>0)
						{
							for(i=0;i<intLen;i++)
							{
								intStandardResponseID = objTxt[i].value;
								
								objChk = GetObjectReference('frmPRO_ChecklistTemplate','chkShowOption' + intStandardResponseID);
								if(objChk.checked==true)
								{
									blnOptionSelected=true;
									break;
								}
								
								objOpt = GetObjectReference('frmPRO_ChecklistTemplate','optStdIsExpectedResponse' + intStandardResponseID);
								if(objChk.checked==true)
								{
									blnIsExpectedResponseSelected =true;
									break;
								}
							}							
						}
						
						if(blnOptionSelected == false)
						{
							alert('<%=MyBase.GetResourceString("MSG_OPTION_NOT_SELECTED")%>');
							return false;
						}
						if(blnIsExpectedResponseSelected == false)
						{
							if(window.confirm('<%=MyBase.GetResourceString("MSG_EXPECED_RESPONSE_NOT_SELECTED")%>')==false)
								return false;
						}	
						objTxt=null;					
					}
					catch(e){}
				}
			}
			else	//custom response format
			{
				var intCustomResponseID;
				
				//At least one option must be specified. Or The comments checkbox must be checked.
				var objCustomResponseID = GetObjectReference('frmPRO_ChecklistTemplate','txtCustomResponseID',true);
				if(objCustomResponseID==null)
					return false;
					
				if(objCustomResponseID.length<=1)
				{
					alert('<%=MyBase.GetResourceString("MSG_OPTION_NOT_SPECIFIED")%>');
					return false;
				}
				else
				{
					try
					{
						intLen = objCustomResponseID.length;
						
						if(intLen>0)
						{
							var strCustomResponseArray = new Array(intLen);
							blnIsExpectedResponseSelected = false;
														
							for(i=0;i<intLen;i++)
							{
								intCustomResponseID = objCustomResponseID[i].value;
								//Validation : All the details of the options must be filled.
								//Caption, OrderNumber are mandatory fields.						
								if(intCustomResponseID!='')
								{
									var objRow;
									objRow = tblCustomOptions.rows("trOption" + intCustomResponseID);
									var objCusResponseCaption = objRow.all.item("txtCusResponseCaption");
									
									if(objCusResponseCaption != null)
									{
										//Validation : Response Caption (Not blank)
										flag = disallowBlank(objCusResponseCaption,'<%=MyBase.GetResourceString("MSG_CAPTION_EMPTY")%>',true);
										if(flag==true)
											return false;
										else
										{
											//Check for duplication of options.
											strValue = new String(objCusResponseCaption.value);
											var j;
											for(j=0;j<intLen;j++)
												if(strValue.toUpperCase()==strCustomResponseArray[j])
												{
													alert(strValue + ' ' + '<%=MyBase.GetResourceString("MSG_OPTION_DUPLICATE")%>');
													objCusResponseCaption.focus();
													return false;
												}
											strCustomResponseArray[i]=strValue.toUpperCase(); 
										}
									}
									objCusResponseCaption=null;
									
									var objCusOrderNumber = objRow.all.item("txtCusOrderNumber");
									if(objCusOrderNumber!=null)
									{
										//Validation : Order Number (Not blank)
										flag = disallowBlank(objCusOrderNumber,'<%=MyBase.GetResourceString("MSG_ORDERNUMBER_EMPTY")%>',true);
										if(flag==true)
											return false;
										
										flag = disallowNonNumeric(objCusOrderNumber,'<%=MyBase.GetResourceString("MSG_ORDERNUMBER_NAN")%>',true);
										if(flag==true)
											return false;
									}
									
									//Check if the Is Expected Response is selected for this option.
									var objCusIsExpectedResponse  = objRow.all.item("optCusIsExpectedResponse");
									if(objCusIsExpectedResponse.style.display == "none")
										objCusIsExpectedResponse = objRow.all.item("chkCusIsExpectedResponse");
									
									if(objCusIsExpectedResponse.checked==true)
										blnIsExpectedResponseSelected = true;
								}
							}
						}
						if(blnIsExpectedResponseSelected==false)
						{
							if(window.confirm('<%=MyBase.GetResourceString("MSG_EXPECED_RESPONSE_NOT_SELECTED")%>')==false)
								return false;
						}
					}
					catch(e){}
				}
			}
			return true;
		}
		function optStandardFormat_OnClick()
		{
			var objTbl;
			//PURPOSE: To display the standard responses, and hide the custom responses.
			objTbl = GetObjectReference('frmPRO_ChecklistTemplate','tblStandardResponseFormat');
			objTbl.style.display = "";
			objTbl.style.visibility = "visible";
			
			objTbl = GetObjectReference('frmPRO_ChecklistTemplate','tblCustomResponseFormat');
			objTbl.style.display = "none";
			objTbl.style.visibility = "hidden";		
		}
		function optCustomFormat_OnClick()
		{
			var objTbl;
			//PURPOSE: To display the custom responses, and hide the standard responses.
			objTbl = GetObjectReference('frmPRO_ChecklistTemplate','tblCustomResponseFormat');
			objTbl.style.display = "";
			objTbl.style.visibility = "visible";
			
			objTbl = GetObjectReference('frmPRO_ChecklistTemplate','tblStandardResponseFormat');
			objTbl.style.display = "none";
			objTbl.style.visibility = "hidden";		
		}
		function chkShowOption_OnClick(StandardResponseID)
		{
			var objShowOption =  GetObjectReference('frmPRO_ChecklistTemplate','chkShowOption' + StandardResponseID);
			var objAcceptComments = GetObjectReference('frmPRO_ChecklistTemplate','chkAcceptComments');
			
			//PURPOSE: To enable/disable the standard option attributes, 
			//depending on whether the option must be shown or no.
			if(StandardResponseID!='')
			{
				var objStdIsExpectedResponse = GetObjectReference('frmPRO_ChecklistTemplate','optStdIsExpectedResponse' + StandardResponseID);
				var objStdIsCommentMandatory = GetObjectReference('frmPRO_ChecklistTemplate','chkStdIsCommentMandatory' + StandardResponseID);
				
				if(objShowOption.checked==false)
				{
					objStdIsExpectedResponse.disabled = true;
					objStdIsExpectedResponse.checked = false;
					objStdIsCommentMandatory.disabled = true;
					objStdIsCommentMandatory.checked = false;				
				}
				else
				{
					objStdIsExpectedResponse.disabled = false;
					if(objAcceptComments.checked==true)
						objStdIsCommentMandatory.disabled = false;						
				}
			}
			objShowOption = null;
		}
		function chkAcceptComments_OnClick()
		{
			//PURPOSE: To enable/disable the Is Comment Mandatory checkboxes, 
			//depending on whether the Accept Comments checkbox is checked/unchecked.
			var intLen,i,intStandardResponseID,objShowOption;
			var objAcceptComments = GetObjectReference('frmPRO_ChecklistTemplate','chkAcceptComments');
			
			objStdIsCommentMandatory = GetObjectReference('frmPRO_ChecklistTemplate','chkStdIsCommentMandatory',true);
			if(objStdIsCommentMandatory!=null)
			{
				intLen = objStdIsCommentMandatory.length;
				
				if(intLen>0)
				{
					for(i=0;i<intLen;i++)
					{
						intStandardResponseID = objStdIsCommentMandatory(i).value;
						objShowOption = GetObjectReference('frmPRO_ChecklistTemplate','chkShowOption' + intStandardResponseID);
						if(!(objShowOption.checked==false && objAcceptComments.checked==true))
							objStdIsCommentMandatory(i).disabled =  !(objAcceptComments.checked);
					}
				}
			}
			objStdIsCommentMandatory=null;
			
			var intItems=0;
			var objCusIsCommentMandatory = GetObjectReference('frmPRO_ChecklistTemplate','chkCusIsCommentMandatory',true);
			if(objCusIsCommentMandatory!=null)
			{
				intLen = objCusIsCommentMandatory.length;
				if(intLen>0)
				{
					for(i=0;i<intLen;i++)
						objCusIsCommentMandatory(i).disabled = ! objAcceptComments.checked;
				}
			}			
			objCusIsCommentMandatory =null;
		}
		function optOptionButtons_OnClick()
		{
			//PURPOSE: To hide the checkboxes and show the option buttons when the "Single selection (use option buttons)"
			// custom response format is selected.
			var intLen,i;
			var objChkCusIsExpectedResponse = GetObjectReference('frmPRO_ChecklistTemplate','chkCusIsExpectedResponse',true);
			var objOptCusIsExpectedResponse = GetObjectReference('frmPRO_ChecklistTemplate','optCusIsExpectedResponse',true);
			
			if(objChkCusIsExpectedResponse!=null)
			{
				intLen = objChkCusIsExpectedResponse.length;
				if(intLen>0)
				{
					for(i=0;i<intLen;i++)
					{
						objChkCusIsExpectedResponse(i).style.display = "none";
						objChkCusIsExpectedResponse(i).style.visibility = "hidden";
						
						objOptCusIsExpectedResponse(i).style.display = "block";
						objOptCusIsExpectedResponse(i).style.visibility = "visible";
					}
				}
				objChkCusIsExpectedResponse = null;
				objOptCusIsExpectedResponse = null;
			}
		}
		function optCheckBoxes_OnClick()
		{
			//PURPOSE: To hide the option buttons and show the check boxes when the 
			//"Multiple selection (use check boxes)" custom response format is selected.		
			var intLen,i;
			var objChkCusIsExpectedResponse = GetObjectReference('frmPRO_ChecklistTemplate','chkCusIsExpectedResponse',true);
			var objOptCusIsExpectedResponse = GetObjectReference('frmPRO_ChecklistTemplate','optCusIsExpectedResponse',true);
			
			if(objChkCusIsExpectedResponse!=null)
			{
				intLen = objChkCusIsExpectedResponse.length;
				if(intLen>0)
				{
					for(i=0;i<intLen;i++)
					{
						objChkCusIsExpectedResponse(i).style.display = "block";
						objChkCusIsExpectedResponse(i).style.visibility = "visible";
						
						objOptCusIsExpectedResponse(i).style.display = "none";
						objOptCusIsExpectedResponse(i).style.visibility = "hidden";
					}
				}
				objChkCusIsExpectedResponse = null;
				objOptCusIsExpectedResponse = null;
			}
		}
		function AddNewOption_OnClick()
		{
			// PURPOSE: To add a new custom option row.			
			//Validation: Max 10 options allowed.
			if(intCustomResponseCount>10)
			{
				alert('<%=MyBase.GetResourceString("MSG_MAX_ROWS_ADDED")%>');
				return;	
			}		
			
			var tblTBODY = tblCustomOptions.getElementsByTagName("TBODY")[0];
			var objRowTemplate = tblTemplate.rows("trTemplate").cloneNode(true);
			
			//The Custom Response ID hidden control.
			objRowTemplate.all.item("txtCustomResponseID").value = intCustomResponseID;
			objRowTemplate.all.item("txtCustomResponseID").name = "txtCustomResponseID";
			
			//The saved Response ID hidden control.
			objRowTemplate.all.item("txtCusResponseID").name = "txtCusResponseID" + intCustomResponseID.toString();
			//The Response Caption textbox control.
			objRowTemplate.all.item("txtCusResponseCaption").name = "txtCusResponseCaption" + intCustomResponseID.toString(); 
						
			//The Is Expected Response checkbox control.
			objRowTemplate.all.item("chkCusIsExpectedResponse").value = intCustomResponseID;						
			objRowTemplate.all.item("chkCusIsExpectedResponse").name = "chkCusIsExpectedResponse" + intCustomResponseID.toString();
			 	
			//The Is Expected Response option button control.
			objRowTemplate.all.item("optCusIsExpectedResponse").value = intCustomResponseID;
			objRowTemplate.all.item("optCusIsExpectedResponse").name = "optCusIsExpectedResponse";										
			objRowTemplate.all.item("optCusIsExpectedResponse").id = "optCusIsExpectedResponse" + intCustomResponseID.toString(); 

			//The Is Comment Mandatory checkbox control.
			objRowTemplate.all.item("chkCusIsCommentMandatory").value = intCustomResponseID;					
			objRowTemplate.all.item("chkCusIsCommentMandatory").name = "chkCusIsCommentMandatory" + intCustomResponseID.toString();
			
			//The Order Number textbox control.
			objRowTemplate.all.item("txtCusOrderNumber").value = intCustomResponseID;
			objRowTemplate.all.item("txtCusOrderNumber").name = "txtCusOrderNumber" + intCustomResponseID.toString();
			
			objRowTemplate.all.item("lnkDeleteOption").href = "javascript:RemoveOption_OnClick(" + intCustomResponseID.toString() + ")";						
			objRowTemplate.all.item("lnkDeleteOption").id = "";
			objRowTemplate.id = "trOption" + intCustomResponseID.toString();
 
			//Append new row with Customize options
			tblTBODY.appendChild(objRowTemplate);
			
			intCustomResponseID++;
			intCustomResponseCount++;

			//Set focus on the newly added option's caption textbox.
			objRowTemplate.all.item("txtCusResponseCaption").focus();

		}				
		function RemoveOption_OnClick(intCustomResponseID)
		{
			//PURPOSE: To remove a custom response option.
			var tblTBODY = tblCustomOptions.getElementsByTagName("TBODY")(0);
			var intIndex = tblTBODY.rows("trOption" + intCustomResponseID.toString()).rowIndex;
			var objResponseID = tblTBODY.rows("trOption" + intCustomResponseID.toString()).all.item("txtCusResponseID");
			var intCusResponseID;
			
			if(objResponseID!=null)
				intCusResponseID = objResponseID.value;
			
			tblTBODY.deleteRow(intIndex);
			
			//If the custom response option was saved previously, then store the PK of that record, 
			//so that it can be deleted from the table.					
			if(intCusResponseID!=null && intCusResponseID!='')
				objform.txtDeletedCustomResponseOptions.value = objform.txtDeletedCustomResponseOptions.value + "," + intCusResponseID.toString();
			
			intCustomResponseCount--;
		}
		
	</Script>
  </body>
</html>
