<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ProjectTask.aspx.vb" Inherits="PbNIT.PM_ProjectTask"  validateRequest="false"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>

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


	<body MS_POSITIONING="FlowLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmProjectTask" method="post" runat="server">
			<%WritePage%>
		</form>
		<script language="javascript">
// =============================== Common To all Mode=====================//
var objForm, objdivlist, objForFocus,objchkbaseline;
	
	objForm = GetFormReference('frmProjectTask');
	objdivlist = GetObjectReference('frmProjectTask','divList');
	objForFocus = GetObjectReference('frmProjectTask','cboEmployee');
	objchkbaseline=GetObjectReference('frmProjectTask','chkBaseline');
	//added by TruptiK on 14-Aug-2008
	
	//End of addition by TruptiK
	<%' Modified BY NitinVS on 11 Jun 2007 for Whizible 7%>
	if (objForFocus != null)
	setFocus(objForFocus);
	<%'End Modification BY NitinVS on 11 Jun 2007 for Whizible 7 %>	
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
		
	function window_onload()
	{
		var intDivHeight ;
		//Modified By VidyaJ - Browser Issue - IssueID - 809 
		//if condition is added by RajashriK for netscape implementation on 21.3.2005
		//Divlist is modified for netscape on 11.4.2005
		if (objdivlist != null) 
		{ 
             <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
		    //	if(navigator.appName == 'Netscape')
		    //		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop+120;
		    //	else
		    //		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    //	if (intDivHeight < 100)	
		    //		{intDivHeight = 100};
			
		    //objdivlist.style.height = intDivHeight;
		    if (navigator.appName == 'Microsoft Internet Explorer') { 
		        intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 46; 
		    }
		    else if (navigator.appName == 'Netscape') { 
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
		    }
		    else { 
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 46; 
		    }   
		    if (intDivHeight < 100)
		        intDivHeight = 100; 
		    objdivlist.style.height = intDivHeight+"px";	
                <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>
		}
			
	}
	
	function window_onresize()		
	{
	//Modified By VidyaJ - Browser Issue - IssueID - 809 
		if (objdivlist !=null) 
		{
			var intDivHeight;
			//if condition is added by RajashriK for netscape implementation on 21.3.2005
			//Divlist is modified for netscape on 11.4.2005
			if(navigator.appName == 'Netscape')
                 <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop ;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;
			else
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46;

			if (intDivHeight < 100)	intDivHeight = 100;
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight+"px";
            <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>
		}		
	}
// =============================== Common To all Mode =====================//
// =============================== Specific To List Mode=====================//
<%If m_strMode = MODE_LIST Then%>
	function ShowBaseline_OnClick(strTaskId)
	{
     //Commented and added by Yogesh J on 29-Jan-2016 to generate token
	 //	window.open("PM_ShowBaseline.aspx?FromWhere=TaskManagement&TaskId=" + strTaskId, "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");

         $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PM_ProjectTask.aspx/GenrateURLToken_RequestShow_TaskType',
	        data: JSON.stringify({TaskId: strTaskId , EmployeeID: "<%=Session("intUserID")%>" }),
		    success: function (Result) {
		        window.open("PM_ShowBaseline.aspx?FromWhere=TaskManagement&EmployeeID=<%=Session("intUserID")%>&PKToken=" + Result.d +"&TaskId=" + strTaskId, "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");

		        },
            error: function () {
                //alert("Error")
            }
         });
	    //End of addition by Yogesh J on 29-Jan-2016 to generate token
	}		
	
	function SelectTaskEntry()
	{
		window.open("PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_NEW%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>&SortByField=<%=m_strSortBy%>&ASCorDESC=<%=m_strSortOrder%>", "PM_SelectTasks","resizable=yes,scrollbars=no,left=0,top=0,width=500,height=450");
	}
	
	function ShowGeneralTasks()
	{
		var objActiveAll;
		objActiveAll = GetObjectReference('frmProjectTask','txthidActiveAll');
		if(objActiveAll.value == "<%=ACTIVEALL_ACTIVE%>")
			objActiveAll.value = "<%=ACTIVEALL_ALL%>";
		else
			objActiveAll.value = "<%=ACTIVEALL_ACTIVE%>";
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
		objForm.submit();
	}

	function Show_TaskDetails()
	{
		var objResource,  objOption, strQueryString, intCount;
		objResource = GetObjectReference('frmProjectTask','cboEmployee');
		objOption = GetObjectReference('frmProjectTask','optTask',true);
		for(intCount=0; intCount < objOption.length; intCount++)
		{
			if(objOption[intCount].checked == true)
			{
				strQueryString = "TaskType=" + objOption[intCount].value;
				break;
			}
		}
		if((objResource != null) && (objResource.selectedIndex != 0))
			strQueryString = strQueryString + "&Resource=" + objResource[objResource.selectedIndex].innerHTML;
		window.open("PM_TaskDetails.aspx?MasterTagId=406&" + strQueryString ,"PM_ShowTask","resizable=yes,scrollbars=no,left=25,top=100,width=960,height=550");
	}
	
	function CreateMPP()
	{
		window.open("PBNToMPP.aspx","PM_CreateMPP","resizable=Yes,scrollbars=yes,left=100,top=100,width=600,height=300");
	}
	//Modified by SiddharthS on 15 Feb 2005 for IssueID 15675
	//Purpose :To change the mapping for general task.
	function Show_TaskType(intTaskID)
	{
		
		//Added by Siddharths on 2 Apr 2005
		objOption = GetObjectReference('frmProjectTask','optTask',true);
		for(intCount=0; intCount < objOption.length; intCount++)
		{
			if(objOption[intCount].checked == true)
			{
				strString = "&optTask=" + objOption[intCount].value;
				break;
			}
		}
	    //End addition	

	    //Commented and Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
	    //window.open("PM_ProjectTask.aspx?Type=<%=m_strType%>&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&TaskID=" + intTaskID + "&optTask=<%=m_strTaskType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>&SortByField=<%=m_strSortBy%>&ASCorDESC=<%=m_strSortOrder%>" ,"PM_New","resizable=yes,scrollbars=no,left=200,top=200,width=500,height=300");
	    //window.open("PM_ProjectTask.aspx?Type=<%=m_strType%>&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&TaskID=" + intTaskID + strString +"&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>&SortByField=<%=m_strSortBy%>&ASCorDESC=<%=m_strSortOrder%>" ,"PM_New","resizable=yes,scrollbars=no,left=200,top=200,width=500,height=300");
		$.ajax({
		    type: 'POST',
		    dataType: 'json',
		    contentType: 'application/json',
		    url: 'PM_ProjectTask.aspx/GenrateURLToken_RequestShow_TaskType',
		    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
		    //data: JSON.stringify({TaskId: intTaskID , EmployeeID: "<%=Session("intUserID")%>" }),
		    data: JSON.stringify({TaskId: intTaskID , EmployeeID: "<%=Session("intUserID")%>", MasterTagId: "<%=m_lngTagId%>"}),
		    //End of Addition by Dhanashri S on 11 Aug 2016
		        success: function (Result) {
		            //window.open("PM_ProjectTask.aspx?Type=<%=m_strType%>&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&TaskID=" + intTaskID + "&optTask=<%=m_strTaskType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>&SortByField=<%=m_strSortBy%>&ASCorDESC=<%=m_strSortOrder%>" ,"PM_New","resizable=yes,scrollbars=no,left=200,top=200,width=500,height=300");
		            window.open("PM_ProjectTask.aspx?Type=<%=m_strType%>&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&TaskID=" + intTaskID + strString +"&PKToken=" + Result.d +"&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>&SortByField=<%=m_strSortBy%>&ASCorDESC=<%=m_strSortOrder%>&EmployeeID=<%=Session("intUserID")%>" ,"PM_New","resizable=yes,scrollbars=no,left=200,top=200,width=500,height=300");

		        },
		        error: function () {
		           // alert("Error")
		        }
		    });
	  

	    //End of addition by Yogesh J on 19-Jan-2016		
		
	}
	//End modification.
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
		var objSortBy, objSortOrder;
		objSortBy = GetObjectReference('frmProjectTask','txthidSortBy');
		objSortOrder = GetObjectReference('frmProjectTask','txthidSortOrder');
		objSortBy.value = strFieldName;
		objSortOrder.value = strAscOrDesc;
		objForm.submit();
	}
	
	function Page_Onclick(strPageNo)
	{
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&TaskType=<%=m_strType%>&PageNumber=" + strPageNo + "&SubPage=<%=m_intSubPage%>";
		objForm.submit();
	}
	
	function optTaskSelect(strType)
	{
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&TaskType=" + strType;
		objForm.submit();
	}
	
	function cboEmployeeChange()
	{
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
		objForm.submit();
	}
	
	//Function for grouping
	function ExpandCollapse_OnClick(group, IsExpanded)
	{
		var strGroup;
		if(IsExpanded == "1")
			IsExpanded = "0";
		else
			IsExpanded = "1";
		if(group == "Current")
			strGroup = "<%=GROUP_CURRENT%>";
		else if(group == "Baseline")
			strGroup = "<%=GROUP_BASELINE%>";
		else if(group == "Actual")
			strGroup = "<%=GROUP_ACTUAL%>";
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Operation=<%=OPERATION_SHOW_HIDE%>&Group=" + strGroup + "&Show=" + IsExpanded + "&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
		objForm.submit();
	}

	function Save_OnClick()
	{	    
	  	//Modified By VidyaJ - Performance Issue - Tasks - 86
		//var objChkActive;
		
		//objChkActive = GetObjectReference('frmProjectTask', 'chkActiveList');
		//if((objChkActive == null) && ("<%=m_strType%>") != "M")
		//	return;
	<% ' Modified bY NitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11967 %>		
	<% ' If General Task is selected and there is no general task available then do not perform save.%>
	objchkBillable = GetObjectReference('frmProjectTask', 'chkBillable');
	objchkActiveList = GetObjectReference('frmProjectTask', 'chkActiveList');
	
		if("<%=m_strType%>" =="O" && objchkBillable == null && objchkActiveList== null )
		{
			return;
		}
		
		
	    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
	    var MenuTags = document.getElementsByTagName('A');
	    for(i = 0; i < MenuTags.length; i++)
	    {
	        if (MenuTags[i].className == "Menu")
	        {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.parentNode.style.display= "none";
	        }
	    }
	    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Operation=<%=OPERATION_SAVE%>&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
		objForm.submit();
	}
	
	function txtActualPercentComplete_onblur(objTextBox)
	{
		if (disallowBlank(objTextBox, "<%=MyBase.GetResourceString("ENTER_ACTUAL_PERCENT_COMPLETE")%>"))
			return;
		if (disallowValueRangeViolation(objTextBox, 0, 100, "<%=MyBase.GetResourceString("VALUERANGE_ACTUAL_PERCENT_COMPLETE")%>", true))
			return;
	}
	
// =============================== Specific To List Mode=====================//
// =============================== Specific To Task Type Mode=====================//
<%Else If m_strMode = MODE_TASKTYPE Then%>
	function Save_OnClick()
	{		    
		var objControl;
		
		objControl = GetObjectReference('frmProjectTask', 'cboTaskType');
		if (disallowBlank(objControl, "<%=MyBase.GetResourceString("SELECT_TASKTYPE")%>"))
			return;
		objControl.disabled=false;
		
			        /************************ Added By VijayD 25 May 2009********************************
                    Purpose: To validate Task assignment for baseline
             ************************ ***********************************************************/
          /*   var objModuleID     = GetObjectReference('frmProjectTask', 'cboModule');
             var objSubProjectID = GetObjectReference('frmProjectTask', 'cboSubProject');
             var objMilestoneID  = GetObjectReference('frmProjectTask', 'cboMilestone');
             var objDeliverableID  =  GetObjectReference('frmProjectTask', 'cboDeliverable');
             
           
            var strSelectedModule = objModuleID.value;
	        var intSelectedModuleID = strSelectedModule.substring(0,strSelectedModule.indexOf("|"));
	        
            var strSelectedSubProject = objSubProjectID.value;
	       	var intSelectedSubProjectID = strSelectedSubProject.substring(0,strSelectedSubProject.indexOf("|")); 
	       	
	        var strSelectedMilestone = objMilestoneID.value;
	       	var intSelectedMilestoneID = strSelectedMilestone.substring(0,strSelectedMilestone.indexOf("|"));
	       		       	
		     var strURL;
		     var fmt = 'MMM dd,yyyy';
			    
			    strUrl = "../General/XMLHttp.aspx?TagID=1038&FromWhichPage=TaskMapping&Mode=TaskValidation&TaskId=<%=m_lngTaskId%>&StartDate=&EndDate=&DeliverableID="+objDeliverableID.value+"&ModuleID="+String(intSelectedModuleID)+"&SubProjectID="+String(intSelectedSubProjectID)+"&MilestoneID="+String(intSelectedMilestoneID)+"&Work=";
			    ValidateTask_Baseline(strUrl);
    		    
    		    if(strResult!=null && strResult!="")
		        {
		          alert(strResult);
                  return false;		    
                }       */	       	       	       
	    //************************End Addition By VijayD 25 May 2009**************************//	     
		<%=m_sbClientSideScript.ToString()%>
		//Modified by SiddharthS on 15 Feb 2005 for IssueID 15675
	//Purpose :To change the mapping for general task.
	
	//added by Siddharths on 2 Feb 
	objType = GetObjectReference('frmProjectTask','txtType');
	strTempString = "&txtType=" + objType.value;
	//end additon
	//objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&Operation=<%=OPERATION_SAVE%>&TaskId=<%=m_lngTaskId%>";
	    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
	    var MenuTags = document.getElementsByTagName('A');
	    for(i = 0; i < MenuTags.length; i++)
	    {
	        if (MenuTags[i].className == "Menu")
	        {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display= "none";
	        }
	    }
	    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
	    
	    //Commented and Added by Yogesh Jalamkar on 22-Aug-2016 For PkToken Security
	    // objForm.action = "PM_ProjectTask.aspx?" + strTempString + "&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&Operation=<%=OPERATION_SAVE%>&TaskId=<%=m_lngTaskId%>&EmployeeID=<%=m_EmployeeID%>";
	    objForm.action = "PM_ProjectTask.aspx?" + strTempString + "&MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_TASKTYPE%>&Operation=<%=OPERATION_SAVE%>&TaskId=<%=m_lngTaskId%>&PKToken=<%=strToken%>&EmployeeID=<%=m_EmployeeID%>";
	    //End of addition by Yogesh Jalamkar on 22-Aug-2016 For PkToken Security
	    //end modification
	   objForm.submit();
	}
	
	// =============================== Specific To Task Type Mode=====================//
// =============================== Specific To New Mode=====================//
<%Else If m_strMode = MODE_NEW Then%>
	<%=m_sbClientSideScript.ToString()%>
	
	function Save_OnClick()
	{		   
		objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Mode=<%=MODE_NEW%>&Operation=<%=OPERATION_SAVE%>";
		objForm.submit();
	}
<%End If%>
//Added by TruptiK on 14-Aug-2008
function SetBaseline_OnClick()
{
    var blnIsRecordSelected=false;
    blnIsRecordSelected=IsCheckboxSelected('frmProjectTask','chkBaseline');
    //alert(objchkbaseline.value);
 if (blnIsRecordSelected == false)
 {
        return;
 }
 objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Operation=SetBaseline&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
 objForm.submit();
}
function ClearBaseline_OnClick()
{
    
    var blnIsRecordSelected=false;
    blnIsRecordSelected=IsCheckboxSelected('frmProjectTask','chkBaseline');
 if (blnIsRecordSelected == false)
 {
    return;
 }
 objForm.action = "PM_ProjectTask.aspx?MasterTagId=<%=m_lngTagId%>&Operation=ClearBaseline&TaskType=<%=m_strType%>&PageNumber=<%=m_strPageNumber%>&SubPage=<%=m_intSubPage%>";
 objForm.submit();
}
function ClearAll_OnClick()
{
var objCheckbox = GetObjectReference('frmProjectTask','chkBaseline',true);
					var intItems;
					var intCtr;
		
					if (objCheckbox != null)
					{
						intItems = objCheckbox.length;
						if(intItems > 1) 
						{
							for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
							{
								if (objCheckbox[intCtr].disabled == false)
									objCheckbox[intCtr].checked = false;							
							}
						}
						// Else, if single element exists, then...
						else if(intItems == 1)
						{
							objCheckbox = GetObjectReference('frmProjectTask','chkBaseline');
							if (objCheckbox.disabled == false) 
								objCheckbox.checked = false;						
						}
					}
}
//end of addition by TruptiK
// =============================== Specific To New Mode=====================//



	
    /************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
     var strResult="";
		   function ValidateTask_Baseline(url) 
			{ 		
			// TO SEE IF WE ARE RUNNING IN IE 
						strNavigator = navigator.appName;
						strNavigator = strNavigator.toUpperCase();
						if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
						{ 
							g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send();
						}
						else
						{
						
							// Mozilla - based browser , Netscape
							g_objXHttp = new XMLHttpRequest();
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send(null);
							
							if ( g_objXHttp.responseText != null)
							{
								xmlDoc= document.implementation.createDocument("","",null);
								xmlDoc.async=false;
								xmlDoc.load(g_objXHttp.responseXML);
								strResult=g_objXHttp.responseText;
						     }
							
						}
					return 	strResult;			
			} 
			
			function TaskValidation_state_change() 
			{			
				if (g_objXHttp.readyState == 4) 
				{
					
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
				 
						if (window.ActiveXObject)
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
							strResult=g_objXHttp.responseText;		
							
				    }
				}
			}	     
	    //************************End Addition By VijayD 25 May 2009**************************//
		</script>
	</body>
</HTML>
