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

     /*Commented and added by Shamkant S on 30-Nov-2015*/
    #DIVLIST>.clsTable td{
    padding-left:5px;
    }
      /*End of addition by shamkant s on 30-Nov-2015*/

      /*Added by Dipali var content 6th july 2020 from height*/
    #divList2 {
        height:490px!important;
        overflow:auto!important;
    }
    /*End of Added by Dipali var content 6th july 2020 from height*/

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
        //if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        //{
        //    removeSectionHeader();
        //}
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
       
        if($('.clsgridtable').length > 0)
        {
            //var divName = $('#divListPageTag').find('div:first').attr('id');
           
            //alert($('.clsPageBody').find('#divSection2').find('#divListTag').attr)
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
        //responsiveFooterMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Sub Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableTopMenu();
        ///*---------------------------------------------------------*/
        //// Ends Feature Tag:whiz41-InnerMenuDropDown
        ///*---------------------------------------------------------*/

        ///*----------------------------------------------------------*/
        //// Starts Feature Tag:whiz41-InnerMenuDropDown
        //// Description:Creating DropDown for Sub Table Inner Menu on document Ready
        //// By Whom: Miiint
        //// When:14/01/2015
        ///*---------------------------------------------------------*/
        //responsiveSubTableFooterMenu();
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_SQERT.aspx.vb" Inherits="PbNIT.PM_SQERT" %>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%
	MyBase.InitializeResources("AppResources.PM_SQERT", "AppResources")
	CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("CAPTION_PROJECTSHEET"))%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_SQERT" method="post" runat="server">
					<%BuildPage()%>	
					</form>
                    <%--Added by Dhanashri S on 12 Oct 2016 For Page Loader--%>
                    <link href="../General/loaderStylesheet.css" rel="stylesheet" />
                    <%--End of Addition by Dhanashri S on 12 Oct 2016--%>

						<Script language="javascript">
		var objform=GetFormReference('frmPM_SQERT');
		
						    // Commented  by Viraj P on 16 Nov 2015
						    //var objdivlist=GetObjectReference('frmPM_SQERT','PageDiv');
		var objdivlist=GetObjectReference('frmPM_SQERT','DIVLIST');
						    //End of Comment  by Viraj P on 16 Nov 2015
        //Commented by Yogesh J on 21/12/2015 issue id=2804
		var objPageDiv = GetObjectReference('frmPM_SQERT','PageDiv');
       //End of comment by Yogesh J                     
		var objcboCategoryId = GetObjectReference('objform','cboCategoryID');
		var objcboBUId = GetObjectReference('objform','cboBUID');
		var objcboOUId = GetObjectReference('objform','cboOUID');
		var objcboProgramId = GetObjectReference('objform','cboProgramID');
		var objcboProjectId = GetObjectReference('objform','cboProjectID');
		var objtxtReportingDate = GetObjectReference('objform','txtReportingDate');
		var objoptReportingPeriod = GetObjectReference('objform','optReportingPeriod');
		//var objtxtLastLockedDate = GetObjectReference('objform','txtLastLockedDate');
		//Modified By ShraddhaM on 26,Sept 2006 for FireFox
		var objtxtLastLockedDate = window.document.forms['frmPM_SQERT'].elements['txtLastLockedDate'];
		
		var intVal;
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

    //Commented and added by Chetan M on 9th April 2020 for IssueID = 22994
		//function cboProject_change()
		//{
		//    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		//    setFrameLoader();
		//    //End of Addition by Dhanashri S on 12 Oct 2016
		//		objform.action="PM_SQERT.aspx?Mode=Change"
		//		objform.submit();
		//}

       function cboProject_change() {
           //ClearAllFilters_OnClick();
           GetObjectReference('objform', 'cboCategoryID').selectedIndex = 0;
           GetObjectReference('objform', 'cboBUID').selectedIndex = 0;
           GetObjectReference('objform', 'cboOUID').selectedIndex = 0;
           GetObjectReference('objform', 'cboProgramID').selectedIndex = 0;
           //Added by Dhanashri S on 12 Oct 2016 For Page Loader
           setFrameLoader();
           //End of Addition by Dhanashri S on 12 Oct 2016
           objform.action = "PM_SQERT.aspx?Mode=Change"
           objform.submit();
       }
    //End of Commented and added by Chetan M on 9th April 2020 for IssueID = 22994

		function cboCategory_change()
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.action="PM_SQERT.aspx?Mode=Change"
				objform.submit();
		}
		
		function cboBU_change()
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.action="PM_SQERT.aspx?Mode=Change"
				objform.submit();
		}
		function cboOU_change()
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.action="PM_SQERT.aspx?Mode=Change"
				objform.submit();
		}
		function cboProgram_change()
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.action="PM_SQERT.aspx?Mode=Change"
				objform.submit();
		}
		function ShowGraphLink_onClick()
		{
			window.open("PM_SQERT.aspx?Mode=TrendGraph&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",height=430,width=605");
		}
		function UpdateSQERTValues_Click()
		{
			//	alert(objtxtReportingDate.value + objcboProjectId.value );
			//	window.open("PM_SQERT.aspx?Mode=SQERTVALUES&txtReportingDate='<%=m_dtmReportingEndDate%>'&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				 
            //Commented and Added by Dhanashri S on 23 Dec 2015
				//if (objcboProjectId.value == '' ||  objtxtReportingDate.value == '')
				//{
				//	alert("Please select Project and the Reporting Date.");
				//	objcboProjectId.focus();
				//}	
				if (objcboProjectId.value == '' ||  objtxtReportingDate.value == '')
				{
				    if(objtxtReportingDate.value == '')
				    {
				        alert("Please select the Reporting Date.");
				        objtxtReportingDate.focus();
				    }
				    else if(objcboProjectId.value == '')
				    {
				        alert("Please select Project.");
				        objcboProjectId.focus();
				    }
				    
				}
                //End of Comment and Addition by Dhanashri S on 23 Dec 2015
				else
				{
				 
				    if(objtxtLastLockedDate.value != '')
				    {
				        var intDateDiff;
				        intDateDiff = DateDiff(getDate(objtxtReportingDate.value),getDate(objtxtLastLockedDate.value),"D");


				        if("<%=m_intSessionPostId%>" != "7")
				        {
				            if (objcboProjectId.value == <%=m_intSessionProjectId%> && intDateDiff >= 0)
				            {
				                //open window with disabled mode
				                window.open("PM_SQERT.aspx?Action=Disabled&Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
				                //	return;
				                //	alert ("open window with disabled mode 1");
				            }	
				            else
				            {
				                window.open("PM_SQERT.aspx?Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
				                //	return;
				                //	alert ("open window with enabled mode 2 ");
				            }
				        }	
				        else
				        {
				            if (intDateDiff >= 0)
				            {
				                window.open("PM_SQERT.aspx?Action=Disabled&Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
				                //return;
				                //alert ("open window with disabled mode 3");
				            }
				            else
				            {
				                window.open("PM_SQERT.aspx?Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
				                //return;
				                //alert ("open window with enabled mode 4");
				            }
				        }	
				    }
				    else
				    {
				        //alert("got no locked value!");					
				        if("<%=m_intSessionPostId%>" != "7")
				        {
				            //	alert("user other than 7");					
				            if (objcboProjectId.value == '<%=m_intSessionProjectId%>')
				            {
				                //	open window with disabled mode
								window.open ("PM_SQERT.aspx?Action=Disabled&Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
				            //return;
				            //	alert ("open window with disabled mode");
				             }	
				            else
				            {
				            window.open ("PM_SQERT.aspx?Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
				            //return;
				            //	alert ("open window with enabled mode");
				            }
				        }	
						else
						{
								window.open ("PM_SQERT.aspx?Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
								//return;
							//alert ("open window with enabled mode");
						}
					}
				}
		}
		
		
	function SaveSQERT_OnClick()
	{
	
		var objDesc = GetObjectReference('objform','txtScopeDesc');
		
		//ADDED BY VIVEKP ON 26 SEP 2005
		
		   if (isNumeric(GetObjectReference('objform','txtScope').value)!=true)
					{
						alert('\'Scope\' should be  numeic or float only.');
						setFocus(GetObjectReference('objform','txtScope'));
						return;
					}
			 if (isNumeric(GetObjectReference('objform','txtQuality').value)!=true)
					{
						alert('\'Quality\' should be  numeic or float only.');
						setFocus(GetObjectReference('objform','txtQuality'));
						return;
					}
		//END OF ADDITION BY VIVEKP 

			 if (Trim(document.forms[0].txtScope.value) == ""  || Trim(document.forms[0].txtQuality.value) == "" || Trim(document.forms[0].txtScopeDesc.value) == "" || Trim(document.forms[0].txtQualityDesc.value) == "" || Trim(document.forms[0].txtEffortDesc.value) == "" || Trim(document.forms[0].txtRiskDesc.value) == "" || Trim(document.forms[0].txtTimeDesc.value) == "" ) 
		{
			alert("Please enter all mandatory 'Description' fields.");
			return;
		}

			 if (parseInt(Trim(document.forms[0].txtScope.value)) < parseInt(Trim(document.forms[0].txtscopelow.value)) || parseInt(Trim(document.forms[0].txtScope.value)) > parseInt(Trim(document.forms[0].txtscopehigh.value))) 
		{
			     alert("Please enter scope in range " + Trim(document.forms[0].txtscopelow.value) + " to " + Trim(document.forms[0].txtscopehigh.value));
			frmPM_SQERT.txtScope.focus();
			return;
		}
	
			 if (parseInt(Trim(frmPM_SQERT.txtQuality.value)) < parseInt(Trim(document.forms[0].txtqualitylow.value)) || parseInt(Trim(frmPM_SQERT.txtQuality.value)) > parseInt(Trim(document.forms[0].txtqualityhigh.value))) 
		{
			     alert("Please enter quality in range " + Trim(document.forms[0].txtqualitylow.value) + " to " + Trim(document.forms[0].txtqualityhigh.value));
			frmPM_SQERT.txtQuality.focus();
			return;
		}	

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtScopeDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtScopeDesc.focus();
			return;
		}
		
		if (disallowMaxlengthViolation(GetObjectReference('objform','txtQualityDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtQualityDesc.focus();
			return;
		}

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtRiskDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtRiskDesc.focus();
			return;
		}
		
		if (disallowMaxlengthViolation(GetObjectReference('objform','txtEffortDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtEffortDesc.focus();
			return;
		}

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtTimeDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtTimeDesc.focus();
			return;
		}

		EnableControls(); // modified by puneet m on 23-12-2015
		
		document.forms[0].action="PM_SQERT.aspx?Mode=SaveSQERTValues&ProjectID=<%=m_strProjectID%>&Action=Update"

	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    var MenuTags = document.getElementsByTagName('A');
	    for (i = 0; i < MenuTags.length; i++) {
	        if (MenuTags[i].className == "Menu") {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display = "none";
	        }
	    }
	    setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
	    //End of Addition by Dhanashri S on 12 Oct 2016

	    document.forms[0].submit()
	}
	
	function AddNew_OnClick()   // Modified by puneet m on 23-12-2015
	{
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016

	    document.forms[0].action="PM_SQERT.aspx?Mode=SaveSQERTValues&Action=Add&ProjectID=<%=m_strProjectID%>"
	    document.forms[0].submit()
	}
	
	function ShowHistory_OnClick()
	{
		window.open("PM_SQERT.aspx?Mode=ShowHistory&ProjectID=<%=m_strProjectID%>", "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=500,width=850");
	}
	 // Added By MahendraV On 5:49 PM 7/19/2007 For PMLifeLine
     // To clear all filters  for 'Project Health Sheet'
     // Start_MV_ 7/19/2007
	function ClearAllFilters_OnClick()
	{
		GetObjectReference('objform','cboCategoryID').selectedIndex = 0;
		GetObjectReference('objform','cboBUID').selectedIndex = 0;
		GetObjectReference('objform','cboOUID').selectedIndex = 0;
		GetObjectReference('objform','cboProgramID').selectedIndex = 0;
		GetObjectReference('objform','cboProjectID').selectedIndex = 0;
		
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016

		objform.action="PM_SQERT.aspx?FromWhere=PM&MasterTagId=3068"
		objform.submit();
	}
	 // End_MV_ 7/19/2007
	function ViewReport_Click()
	{
		//CODE COMMENTED BY VIVEKP ON 20 SEP 2005
		/*	if (objcboCategoryId.value == '' && objcboBUId.value == '' && objcboProgramId.value == '' && objcboProjectId.value == '')
			{
				alert("Atleast one value out of the given four combo boxes must be selected.");
				objcboCategoryId.focus();
				return;
			}
		*/	
		//END OF CODE COMMENTING BY VIVEKP ON 20 SEP 2005
		
			if (objtxtReportingDate.value == '')
			{
				alert("Reporting date should not be left blank.");
				objform.focus();
				return;
			}
			
			/*	Commented By NitinVS on 14 Oct 2005 Resource Timesheet Frequency is to be shown 
			for(var i=0;i < 3;i++)
			{
				if(document.all("optReportingPeriod")[i].checked)
					intVal = document.all("optReportingPeriod")[i].value;
			} */
			 var intVal = GetObjectReference('objform','txtReportingFrequency').value;

			//window.open("PM_SQERT.aspx?Mode=ViewReport&cboCategoryID=" + objcboCategoryId.value + "&cboProgramID=" + objcboProgramId.value + "&cboProjectID=" + objcboProjectId.value + "&cboBUID=" + objcboBUId.value + "&txtReportingDate='" + objtxtReportingDate.value + "'&optReportingPeriod=" + intVal , "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
			window.open("PM_SQERT.aspx?Mode=ViewReport&cboCategoryID=" + objcboCategoryId.value + "&cboProgramID=" + objcboProgramId.value + "&cboProjectID=" + objcboProjectId.value + "&cboBUID=" + objcboBUId.value + "&cboOUID=" + objcboOUId.value + "&txtReportingDate=" + objtxtReportingDate.value + "&optReportingPeriod=" + intVal , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
	}
	
	function DetailsLink_onClick(strFlag)
	{
	
		var Issuetype;
		var FlagID;
		switch(strFlag)
		{
			case "SQERT" :
				window.open("PM_SQERT.aspx?Mode=SQERTDetails&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "Risk" :
				window.open("PM_SQERT.aspx?Mode=RISK&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalIssues" :
			// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=1&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "OpenIssues" :
				// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=2&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
				<% 'Added By Padmnabh to Display Issues Reported by Customer %>
			case "CustReportedIssues" :
			// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=5&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
				<% 'Addition By Padmnabh Ends %>
			case "ClosedIssues" :
			// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=3&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "OtherIssues" :
				// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=6&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "OverDueIssues" :
				// added by MahendraV On 11:10 AM 6/18/2007
				if (arguments.length>1)
				{
					Issuetype = arguments[1];
				}
				// End addition by MahendraV	
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=4&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			// added by MahendraV On 11:10 AM 6/18/2007
			case "IssuesAge" :
				
				if (arguments.length>2)
				{
					Issuetype = arguments[1];
					FlagID = arguments[2];
				}
			
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=" + FlagID +"&Issuetype=" + Issuetype, "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
				// End addition by MahendraV
			case "CompletedTasks" :
				window.open("PM_SQERT.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=2", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TobeCompletedTasks" :
				window.open("PM_SQERT.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=3", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			// Added By MahendraV On 4:47 PM 6/15/2007 To total planned task and planned deliverable
			// Start_MV_6/15/2007
			case "TotalPlannedTasks" :
				window.open("PM_SQERT.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=14", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break; 
			case "TotalPlannedDeliverables" :
				window.open("PM_SQERT.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=15", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			// Start_MV_6/15/2007   
			case "SLIPPINGTASKS" :
				window.open("PM_SQERT.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=6", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break; 
			case "CompletedDeliverables" :
				window.open("PM_SQERT.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=8", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "SlippingDeliverables":
				window.open("PM_SQERT.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=10", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TobeCompletedDeliverables":
				window.open("PM_SQERT.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=12", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			// Added By MahendraV On 4:58 PM 6/21/2007 To adding details on total issues
			// Start_MV_6/21/2007
			case "TotalOpenIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=16", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalCloseIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=17", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalOthersIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=18", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "Total_Issues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=19", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalLessThenFiveIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=20" , "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalInBetweenFiveToTenIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=21" , "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalMoreThenTenIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_strReportedDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=22" , "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalShownToCustomerIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=23" , "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalOverDueIssues" :
				window.open("PM_SQERT.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=24" , "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			// Start_MV_6/21/2007
			
		}
	
	}
		
		function Close_Click()
		{
			window.close();
		}
		
		//The div tag has id as PageDiv 
		 //Modified by JyotiG on Date 11 July,2006 for PMLifeLine Issue ID.4168
		function window_onload()
		{
		   
		    var intDivHeight ;
			
			
		    if (objdivlist !=null) {
                //Commented by Yogesh J on 10/12/2015 issue id=2729
		        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop;
		        //if(navigator.appName == 'Netscape')
		        //{
		        //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 2210;
		        //}
		        if(WhichBrowser()=="FF")
		        {      //Added By Vidya J ON 22 Aug 2016 
		            if ('<%=m_strMode%>' == 'SQERTVALUES')
		            {
		                intDivHeight = window.innerHeight - objdivlist.offsetTop - 140;
		            
		        }
		        else
		            {
		                //End Of Added By Vidya J ON 22 Aug 2016 
		                intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		        }
		        }
		        else if(WhichBrowser()=='CR')
		        {     //Added By Vidya J ON 22 Aug 2016 
		            if ('<%=m_strMode%>' == 'SQERTVALUES')
		            {
		                intDivHeight = window.innerHeight - objdivlist.offsetTop - 141;
		           
		        }
		            else{
		                //End Of Added By Vidya J ON 22 Aug 2016 
		                document.body.style.height = window.innerHeight - 5 + 'px'; //Added By Yogesh J ON 15/12/2015 for issue id=2729
		                intDivHeight = window.innerHeight - objdivlist.offsetTop - 41;
		           
		        
		        }
		        }
		        else
		        {
		           
		            //Added By Vidya J ON 22 Aug 2016 
		              if ('<%=m_strMode%>' == 'SQERTVALUES')
		                {
		                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 39-100;
		                    
		                }
		                else
		                {
		                    intDivHeight = window.innerHeight - objdivlist.offsetTop - 39;
		                }
		           
		            //End Of Added By Vidya J ON 22 Aug 2016 
		        }
		        //End of comment by Yogesh J on on 10/12/2015 issue id=2729
		        if (intDivHeight < 100)	intDivHeight = 100;
		        objdivlist.style.height = intDivHeight + 'px';
            
		    }
		        //Commented by Yogesh J on 21/12/2015 issue id=2804
		     if(objPageDiv !=null)
		    {
		        if(WhichBrowser()=="FF")
		        {
		            intDivHeight = window.innerHeight - objPageDiv.offsetTop - 40;
		        }
		        else if(WhichBrowser()=='CR')
		        {
		            intDivHeight = window.innerHeight - objPageDiv.offsetTop - 41;
		        }
		        else
		        {
		            intDivHeight = window.innerHeight - objPageDiv.offsetTop - 39;
		        }
		       
		        if (intDivHeight < 100)	intDivHeight = 100;
		        objPageDiv.style.height = intDivHeight + 'px';
		    }
		    //End of comment by Yogesh J on on 21/12/2015 issue id=2804
		}
			
			
			
     
		
		function window_onresize()		
		{
		    var intDivHeight ;
			
			
		    if (objdivlist !=null) 
		    {
		        //Commented by Yogesh J on 10/12/2015 issue id=2729
		        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop;
		        //if(navigator.appName == 'Netscape')
		        //{
		        //    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 2210;
		        //}
		        if(WhichBrowser()=="FF")
		        {
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		        }
		        else if(WhichBrowser()=='CR')
		        { document.body.style.height = window.innerHeight - 5 + 'px'; //Added By Yogesh J ON 15/12/2015 for issue id=2729
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 41;
		        }
		        else
		        {
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 39;
		        }
		        //End of comment by Yogesh J on on 10/12/2015 issue id=2729
		        if (intDivHeight < 100)	intDivHeight = 100;
		        objdivlist.style.height = intDivHeight + 'px';
            
		    }
		        //Commented by Yogesh J on 21/12/2015 issue id=2804
		    if(objPageDiv !=null)
		    {
		        if(WhichBrowser()=="FF")
		        {
		            intDivHeight = window.innerHeight - objPageDiv.offsetTop - 40;
		        }
		        else if(WhichBrowser()=="CR")
		        {
		        intDivHeight = window.innerHeight - objPageDiv.offsetTop - 39;
		        }
		        else
		        {
		            intDivHeight = window.innerHeight - objPageDiv.offsetTop - 39;
		        }
		       
		        if (intDivHeight < 100)	intDivHeight = 100;
		        objPageDiv.style.height = intDivHeight + 'px';
		    }
		    //End of comment by Yogesh J on on 21/12/2015 issue id=2804
		}	


		// Commented  by Viraj P on 16 Nov 2015
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
		//End of Comment  by Viraj P on 16 Nov 2015
		
		function OnlyNumeric(intAllowDecimal)
		{
			var KeyAscii = window.event.keyCode;
			
			if (intAllowDecimal==1 && KeyAscii == 46 && KeyAscii == 45)
			{
			return;
			}
			
			else
			{
			if ( KeyAscii < 45 || KeyAscii > 57 ) 
				{ window.event.keyCode = 0; } 
			}	
		}
	
		function EnableControls()
		{
			GetObjectReference('objform','txtEffort').disabled=false;
			GetObjectReference('objform','txtRisk').disabled=false;
			GetObjectReference('objform','txtTime').disabled=false;
		}
		
		function SQERTProjectLink_onClick(intProjectID, intReportingPeriod, strReportedDate)
		{
			//alert ("PM_SQERT.aspx?Mode=ViewReport&cboProjectID=" + intProjectID + "&txtReportingDate='" + strReportedDate + "'&optReportingPeriod=" + intReportingPeriod , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900")
			window.open("PM_SQERT.aspx?Mode=ViewReport&cboProjectID=" + intProjectID + "&txtReportingDate=" + strReportedDate + "&optReportingPeriod=" + intReportingPeriod , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
		}
					</Script>
			</body>
</HTML>
