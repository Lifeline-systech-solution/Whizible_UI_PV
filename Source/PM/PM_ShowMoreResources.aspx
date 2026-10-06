<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ShowMoreResources.aspx.vb" Inherits="PbNIT.PM_ShowMoreResources"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
	
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
    .detailInfo tr td:first-child
    {
         padding-top: 0px !important;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        $('#body').height=window.innerHeight-3+'px';
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


	<body  class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_ShowMoreResources" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_ShowMoreResources');
		var objdivlist=GetObjectReference('frmPM_ShowMoreResources','PageDiv');
		//Integrated By SanaSon 23-Oct-2009
		//Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 to avoid duplicate entries in Resources 
		var blnIsSaveClicked=0;
		//End: Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 
		//End Integrated By SanaSon 23-Oct-2009
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
			//added by SanaS on 14-Sep-2009
		var dtStartDate,dtEndDate,workhours;
		
		//End Addition 
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			////intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			////'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    //}
			//if (intDivHeight < 100)	intDivHeight = 100;
			//    //Commented and added by Yogesh J on 11/12/2015
			    //    //objdivlist.style.height = intDivHeight;

		    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 47 ;
			
			objdivlist.style.height = intDivHeight + 'px';
				}
			AdjustSectionResourcesHeight();
			//added by SanaS on 14-Sep-2009
			dtStartDate=GetObjectReference('frmPM_ShowMoreResources','txtFromDate').value;
			dtEndDate=GetObjectReference('frmPM_ShowMoreResources','txtToDate').value;
			workhours=GetObjectReference('frmPM_ShowMoreResources','txtHours').value;
			//End Addition  on 14-Sep-2009
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //}
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 47 ;
			    
			    objdivlist.style.height = intDivHeight + 'px';
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
				}
			AdjustSectionResourcesHeight();
		}
		//For adjusting the height resources list	
		function AdjustSectionResourcesHeight()
		{
			var objdivResources=GetObjectReference('frmPM_ShowMoreResources','divSectionResources');
			var objdivResourcesList=GetObjectReference('frmPM_ShowMoreResources','divResourcesList');
			var intDivHeight;
			if (objdivResources !=null) 
			{
			    intDivHeight = document.body.offsetHeight - objdivResources.offsetTop - 370;
			  
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivResources.style.height = intDivHeight;

				
			}
			//commented by Nilesh g on 5/12/2015 for issue id 2637
		    //if (objdivResourcesList !=null) 
			//{
			//	intDivHeight = document.body.offsetHeight - objdivResourcesList.offsetTop - 370;
			//	if (intDivHeight < 100)	intDivHeight = 100;	
			//	objdivResourcesList.style.height = intDivHeight-20;	
			//}
		}
		<%=m_strClientSideScript%>
		
		function ShowResume(intEmployeeID)
		{
			window.open ("../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");
		}
		
		function ShowResourceLoading(intEmployeeID)
		{
			var dtToday = new Date();
			
				//Modified By VarunA on 3-Feb-2009 IssueID-29135
			//Purpose : To handle the year in Mozilla
			//window.open("../PM/PM_ResourceHistory.aspx?EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getYear(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			window.open("../PM/PM_ResourceHistory.aspx?EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getFullYear(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			//End By VarunA on 3-Feb-2009 RequestID-29135
		}

		function Search_OnClick()
		{
			if(ValidateInput('SEARCH') == true)
			{
				objform.action = "../PM/PM_ShowMoreResources.aspx?AssignedResources=<%=m_intTotalResourcesAssigned%>&RequestedResources=<%=m_intTotalResourcesRequested%>&ProjectID=<%=m_lngProjectId%>&RequestID=<%=m_lngRequestId%>&Action=<%=ACTION_SEARCH%>";
				objform.submit();
			}
		}

		function Allocate_OnClick()
		{
			var objWorkHours;
			var url=new String();
			var objFromDate,objToDate,objWorkHours,objEmployeeID;
			var objchkAssign,intCnt;
			var lngRequestId = <%=m_lngRequestId%>;
			var strHtm='';
	//Added by TrutpiK on 09-Feb-09
			//Purpose:-To validate extra workhours.
			var check1;
			var strEmpName="";
			var objTypeTotalWorkHours = GetObjectReference('frmPM_ShowMoreResources','optTotalWorkHour');
			objTypePerDay = GetObjectReference('frmPM_ShowMoreResources','optPerDay');
			//End of addition by TrutpiK
			//Integrated By SanaSon 23-Oct-2009
			//Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 to avoid duplicate entries in Resources 
			if (blnIsSaveClicked != 0)  {return;} 
			//End: Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 
			//End Integrated By SanaSon 23-Oct-2009
		
			
			if(ValidateInput('ALLOCATE') == true)
			{
				objWorkHours = GetObjectReference('frmPM_ShowMoreResources','txtHours');
				
				strMsg = "<%=MyBase.GetResourceString("VALID_WORK_HOURS")%>";
				if(disallowBlank(objWorkHours, strMsg))
				{
					setFocus(objWorkHours);
					return;
				}
				
				if(parseFloat(objWorkHours.value) <= 0)
				{
					alert("<%=MyBase.GetResourceString("WORK_HOURS_MORE_THAN_ZERO")%>");
					setFocus(objWorkHours);
					return;
				}
				//debugger;
				objchkAssign = GetObjectReference('frmPM_ResourceAllocationDetails','chkAssign', true);
				for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
			{
					if(objchkAssign[intCnt].checked == true)
					{
							objEmployeeID=objchkAssign[intCnt].value;
	                    //Added by TrutpiK on 09-Feb-09
						//Purpose:-ThirdWare Change of Resource Allocation Percentage.
						var obj_hid_txtFreehours;
						obj_hid_txtFreehours = GetObjectReference('frmPM_ShowMoreResources','hid_txtFreehours_'+ objEmployeeID);
						var objEmpName = GetObjectReference('frmPM_ShowMoreResources','txthidEmployeeName_' + objEmployeeID);
                        var obj_hid_txtWorkFreehours=GetObjectReference('frmPM_ShowMoreResources','hid_txtWorkFreehours_' + objEmployeeID);                   
                        var perhours=GetObjectReference('frmPM_ShowMoreResources','txthidProjectWorkHours');
                        var objtxtHours=GetObjectReference('','txtHours')
                        var perdayworkhrs=((parseFloat(perhours.value))*(parseFloat(objtxtHours.value)))/100
                   
                       //alert(perdayworkhrs);
                        if(objTypeTotalWorkHours.checked == true)
                       {
                        if(parseFloat(obj_hid_txtFreehours.value) < parseFloat(GetObjectReference('','txtHours').value))
                        {
							
                            strEmpName=strEmpName+objEmpName.value + ',';
                            check1=1;
                           
                        }
                        }
                        else if (objTypePerDay.checked== true)
                        {
                              if(parseFloat(obj_hid_txtWorkFreehours.value) < parseFloat(GetObjectReference('','txtHours').value))
                        {
                            strEmpName=strEmpName+objEmpName.value + ',';
                            check1=1;
                           
                        }
                        }
                        else
                        {
                            if(parseFloat(obj_hid_txtWorkFreehours.value) < parseFloat(perdayworkhrs))
                            {
                             strEmpName=strEmpName+objEmpName.value + ',';
                             check1=1;
                             }
                        }
                        
						
											
	/*
							objFromDate = GetObjectReference('frmPM_ShowMoreResources','txtFromDate').value;
							objToDate = GetObjectReference('frmPM_ShowMoreResources','txtToDate').value;
							objWorkHours = GetObjectReference('frmPM_ShowMoreResources','txtHours').value;
							strHtm=strHtm + objEmployeeID+'|'+objFromDate+'|'+objToDate+'|'+objWorkHours+','
	*/
					}
			}
			
			//alert(strHtm);
			
				strEmpName=strEmpName.substring(0,strEmpName.length-1);
						strMsg='Resource '+ strEmpName +' is overallocated.You can not allocate him/her on project.'
						if (check1==1)
						{
						    alert(strMsg);
						    //Integrated By SanaSon 23-Oct-2009
						    //Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 to avoid duplicate entries in Resources 
							blnIsSaveClicked=0;
							//End: Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 
							//End Integrated By SanaSon 23-Oct-2009
						    
						    return;
						 }
			//End of addition by TrutpiK on 09-Feb-09
			//url=objform.action = "../PM/PM_ShowMoreResources.aspx?AssignedResources=<%=m_intTotalResourcesAssigned%>&RequestedResources=<%=m_intTotalResourcesRequested%>&ProjectID=<%=m_lngProjectId%>&RequestID=<%=m_lngRequestId%>&Action=<%=ACTION_ALLOCATE%>&FromXML=1&SelectedResources="+strHtm;
			//alert(url);
			//loadXMLDoc(url,'');
			//return;
				
				objform.action = "../PM/PM_ShowMoreResources.aspx?AssignedResources=<%=m_intTotalResourcesAssigned%>&RequestedResources=<%=m_intTotalResourcesRequested%>&ProjectID=<%=m_lngProjectId%>&RequestID=<%=m_lngRequestId%>&Action=<%=ACTION_ALLOCATE%>";
				objform.submit();
			}
		}
	//End Addition by TruptiK
		function loadXMLDoc(url,reqQuery)
		{
		if (window.XMLHttpRequest)
			{
				xmlhttp=new XMLHttpRequest();
				xmlhttp.onreadystatechange= state_Change;
				if (ns) 
				{
				xmlhttp.open('GET',url,true);
				xmlhttp.send(null);
				}
				else 
				{
				xmlhttp.open('POST',url,false);
				xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				xmlhttp.send(reqQuery);
				}
			}
		else if (window.ActiveXObject)
			{
				xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
				if (xmlhttp) 
				{
					xmlhttp.onreadystatechange=state_Change;
					xmlhttp.open('POST',url,false);
					xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
					xmlhttp.send(reqQuery);
				}
			}

		}
	
//COMMENTED by TruptiK on 13-Mar-2008
 //Purpose:-ThirdWare Change of Resource Allocation Percentage.
/*	function state_Change() 
	{
		var str,intcnt,strEmpName="",check=0;
		var arr;
		var arr1;
		
		var lngResourcePer = <%=m_ResourceAllocationPercent%>;
		
		if (parseInt(xmlhttp.readyState)==4) {
			if (xmlhttp.status==200){
						str=xmlhttp.responseText;
						
						arr=str.split("|");
						for(intCnt=0; intCnt < arr.length-1; intCnt++)
						{
							
							arr1=arr[intCnt].split("$");
							
							if(arr1[2] >lngResourcePer)
							{
								check=1
							   strEmpName=strEmpName+arr1[1]+','
							}
																								
					}
					strEmpName=strEmpName.substring(0,strEmpName.length-1);
						strMsg='Resource '+ strEmpName +' is overallocated. Do you want to continue?'
					
					
					if (check==1)
					{
						if (window.confirm(strMsg) != false)
						{
						objform.action = "../PM/PM_ShowMoreResources.aspx?AssignedResources=<%=m_intTotalResourcesAssigned%>&RequestedResources=<%=m_intTotalResourcesRequested%>&ProjectID=<%=m_lngProjectId%>&RequestID=<%=m_lngRequestId%>&Action=<%=ACTION_ALLOCATE%>";
						objform.submit();
						}
						
						
					}
					
				else
						{
							objform.action = "../PM/PM_ShowMoreResources.aspx?AssignedResources=<%=m_intTotalResourcesAssigned%>&RequestedResources=<%=m_intTotalResourcesRequested%>&ProjectID=<%=m_lngProjectId%>&RequestID=<%=m_lngRequestId%>&Action=<%=ACTION_ALLOCATE%>";
							objform.submit();
						}
						
					
			}}
	}
		//End of addition by TruptiK
		*/		
	  //End of COMMENTED by TrupitK on 13-Mar-2008	
		//added by harshk issueid sp4 120,121 
		function GetJoiningDate(intEmployeeID)
		{
			var objcboJoiningDate;
			var intIndex;
			objcboJoiningDate = GetObjectReference('frmPM_ShowMoreResources','cboJoiningDate');
			if(objcboJoiningDate != null)
			{
				for(intIndex=0;intIndex<objcboJoiningDate.length;intIndex++)
				{
					if(objcboJoiningDate[intIndex].value == intEmployeeID)
					{
						return objcboJoiningDate[intIndex].text;
					}
				}
			}
		}
		function JoiningDateValidation(objStartDate,intEmployeeID)
		{
			var strMessage,strJDate;
			var dtJDate, dtSDate;
			var objEmpName = GetObjectReference('frmPM_ShowMoreResources','txthidEmployeeName_' + intEmployeeID);
			strJDate = GetJoiningDate(intEmployeeID);
			dtJDate = getDate(strJDate);
			dtSDate = getDate(objStartDate.value);
			if(dtSDate < dtJDate)
			{
				//modified by HarshK on 05/09/2005 for sp4 issueid 136 (single quotes replaced by double quotes)
				strMessage = "<%=MyBase.GetResourceString("RESOURCE_JOININGDATE_VALIDATION")%>";
				//end modified by HarshK on 05/09/2005 for sp4 issueid 136
				strMessage = replaceSubstring(strMessage, '<=>',objEmpName.value);
				strMessage = replaceSubstring(strMessage, '<==>',strJDate);
				alert(strMessage);
				return false;
			}
			return true;
		}
		//END added by harshk issueid sp4 120,121 
		function ValidateInput(strFrom)
		{
			var objFromDate, objToDate, objWorkHours, objchkAssign, objTypePerDay, objTypeTotal,objTypePercent;
			var intCnt, strMsg, blnFound, objToday, intChecked;
			var objEmployeeTeamID, objEmployeeName;
			var strEmployeeWithDiffTeam = '', lngRequestTeamID=<%=m_lngRequestTeamID%>;
			//Added By NileshD on 10 Jan 2005
			var objRequestFromDate, objRequestToDate;
	        var lngRequestId = <%=m_lngRequestId%>;
			var strType = '<%=m_strType%>';
			var dblRequestedWorkHours = <%=m_dblWorkHours%>;


			intChecked = 0;
			objProjectFromDate = GetObjectReference('frmPM_ShowMoreResources','txthidProjectFromDate');
			objProjectToDate = GetObjectReference('frmPM_ShowMoreResources','txthidProjectToDate');
			objProjectWorkHours = GetObjectReference('frmPM_ShowMoreResources','txthidProjectWorkHours');
			objToday = GetObjectReference('frmPM_ShowMoreResources','txthidToday');

			objFromDate = GetObjectReference('frmPM_ShowMoreResources','txtFromDate');
			objToDate = GetObjectReference('frmPM_ShowMoreResources','txtToDate');
			objWorkHours = GetObjectReference('frmPM_ShowMoreResources','txtHours');
			objTypePerDay = GetObjectReference('frmPM_ShowMoreResources','optPerDay');
			objTypeTotal = GetObjectReference('frmPM_ShowMoreResources','optTotalWorkHour');
			objTypePercent = GetObjectReference('frmPM_ShowMoreResources','optPercent');
		
					//Added By NileshD on 10 Jan 2005
			objRequestFromDate = GetObjectReference('frmPM_ShowMoreResources','txthidRequestFromDate');
			objRequestToDate = GetObjectReference('frmPM_ShowMoreResources','txthidRequestToDate');
			//Added By VarunA on 5-Sep-2008
			//Purpose : To check if To date is greater than Request To Date and From date should not be less than Request From Date
			var objReqFromDate,objReqToDate
			objReqFromDate = GetObjectReference('frmPM_ShowMoreResources','txthidReqFromDate');
			objReqToDate = GetObjectReference('frmPM_ShowMoreResources','txthidReqToDate');
			//End By VarunA on 5-Sep-2008
			//Added by SanaS on 15-Oct-2009		
		    if (objTypePerDay.checked==true)
		        {
		        dblRequestedWorkHours='<%=m_dblWorkHours%>';
		        strType = "<%=TYPE_HPD%>"
		        }
		    else if (objTypePercent.checked==true)
				{
				dblRequestedWorkHours='<%=m_dblPercentage%>'
				strType = "<%=TYPE_P%>"
				}
            else		
                {
                dblRequestedWorkHours='<%=m_dblTotalWorkHours%>'
                strType = "<%=TYPE_TH%>"
                }
            //end Addition    by SanaS on 15-Oct-2009		
        	if(strType == "<%=TYPE_HPD%>")
				strMsg = "Work hours are more than requested work hours.";
			else if(strType == "<%=TYPE_P%>")
				strMsg = "Work hours (%) is more than requested percentage.";			
			//Added by SanaS on 16-Sep-2009
			else
				strMsg = "Work hours is more than requested Total Work Hours.";			
				//End  by SanaS on 16-Sep-2009
			if(disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
			return false;
			
			if(strFrom == 'ALLOCATE')
			{
			    //Added by SanaS on 14-Sep-2009
				if (dtStartDate!=objFromDate.value || dtEndDate!=objToDate.value || parseFloat(workhours)< parseFloat(objWorkHours.value))
					{
						alert('Search criteria has been changed. Please search again for new value');
						return false;
					}
			    //End Addition by SanaS on 14-Sep-2009	
				blnFound = false;
				objchkAssign = GetObjectReference('frmPM_ShowMoreResources','chkAssign', true);
				for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
				{
					if(objchkAssign[intCnt].checked == true)
					{
						blnFound = true;
						intChecked++;
					}
				}

				if(blnFound == false)
				{
					alert("<%=MyBase.GetResourceString("SELECT_ATLEAST_ONE_RESOURCE")%>");
					return false;
				}
				
				if(intChecked > (parseInt("<%=m_intTotalResourcesRequested%>") - parseInt("<%=m_intTotalResourcesAssigned%>")))
				{
						//	alert("<%=MyBase.GetResourceString("SELECTED_MORE_THAN_REQUESTED")%>");
					alert("The number of resources selected for allocation are more than the number requested.");
					return false;
				}
				/*Added by harshk issueid sp4 120,121 */
				for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
				{
					if(objchkAssign[intCnt].checked == true)
					{
objMinAllocation = GetObjectReference('frmPM_ShowMoreResources','txtMinAllocation_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);                                      
					
						if(strType == "<%=TYPE_HPD%>")
						{		
							strMsg = "Requested Work Hours are more than Maximum Free Hours Per Day, So can not allcoate the resource.";
							if(disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))
							return false;
							
							strMsg = "Maximum Free Hours Per Day should be more than 0, So can not allocate the resource.";
							if(disallowMinValueViolation(objMinAllocation, 0, strMsg, true))
							return false;
						}
						else if(strType == "<%=TYPE_P%>")
						{	
							strMsg = "Requested Work Hours (%) is more than Maximum Free Percentage, So can not allcoate the resource. ";
							if(disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))
							return false;	
							
							strMsg = "Maximum Free Percentage should be more than 0, So can not allocate the resource.";
							if(disallowMinValueViolation(objMinAllocation, 0, strMsg, true))
							return false;					
						}
						if(JoiningDateValidation(objFromDate,objchkAssign[intCnt].value) == false)
						{
							return false;
						}						
					}
				}
				//end Added by harshk issueid sp4 120,121 
/*
				for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
				{
					if(objchkAssign[intCnt].checked == true)
					{
						//Check for the team of the selected resource before allocation
						objEmployeeTeamID = GetObjectReference('frmPM_ShowMoreResources','txthidTeamID_' + objchkAssign[intCnt].value);
						objEmployeeName = GetObjectReference('frmPM_ShowMoreResources','txthidEmployeeName_' + objchkAssign[intCnt].value);
						if(lngRequestTeamID	!= objEmployeeTeamID.value)
						{
							strEmployeeWithDiffTeam = strEmployeeWithDiffTeam + objEmployeeName.value + '\n';
							objchkAssign[intCnt].checked = false;
							intChecked--;
						}
					}
				}

				if(strEmployeeWithDiffTeam != '')
				{
					alert('<%=MyBase.GetResourceString("DIFFERENT_TEAM",False)%>' + strEmployeeWithDiffTeam);				
				}
				if(intChecked == 0)
				{
					return false;
				}
*/				
//Added By JayavantK, On 30-Aug-2004
			objProjectRole = GetObjectReference('frmPM_ResourceAllocationDetails','cboProjectRole');
			//Added by TruptiK on 21-Jan-09
			var strmsg1
			var objProjectStatus=GetObjectReference('frmPM_ResourceAllocationDetails','cboStatus');
			
			strMsg = "<%=MyBase.GetResourceString("SELECT_PROJECT_ROLE")%>";
			strmsg1="Please select the project status"
			if(disallowBlank(objProjectRole, strMsg, true))
				return false;
				if(disallowBlank(objProjectStatus, strmsg1, true))
				return false;
			//End of addition by TruptiK
//End Addition
			}
			strMsg = "<%=MyBase.GetResourceString("FROM_DATE_NO_BLANK")%>";
			if(disallowBlank(objFromDate, strMsg, true))
				return false;

			strMsg = "<%=MyBase.GetResourceString("TO_DATE_NO_BLANK")%>";
			if(disallowBlank(objToDate, strMsg, true))
				return false;

			//Added By NileshD on 10 Jan 2005
			strMsg = "<%=MyBase.GetResourceString("RESOURCE_FROM_DATE_NOT_GREATER_THAN_REQUEST_DATE")%>";
			strMsg=replaceSubstring(strMsg,"&#39;","'");
			//Modified By VarunA on 5-Sep-2008
			//Purpose : To check if from date is less than Request From Date
			//if(disallowDate1LessThanDate2(objFromDate , objRequestFromDate) == true)
			if(disallowDate1LessThanDate2(objFromDate , objReqFromDate) == true)
			//End BY VarunA on 5-Sep-2008
			{
				//commented by PrashantD on 15 Feb 2007. In Whiz 7.1 we wont allow to From date less than Request From Date
				//if (window.confirm(strMsg) != true)
				alert("Resource 'From Date' is not in the range of request 'From Date'.");
				return false;
			}
			
			strMsg = "<%=MyBase.GetResourceString("RESOURCE_TO_DATE_NOT_GREATER_THAN_REQUEST_DATE")%>";
			strMsg=replaceSubstring(strMsg,"&#39;","'");
			//Modified By VarunA on 5-Sep-2008
			//Purpose : To check if To date is greater than Request To Date
			//if(disallowDate1LessThanDate2(objRequestToDate, objToDate) == true)
			if(disallowDate1LessThanDate2(objReqToDate, objToDate) == true)
			//End BY VarunA on 5-Sep-2008
			{
				//commented by PrashantD on 15 Feb 2007. In Whiz 7.1 we wont allow to To date less than Request To Date
				//if (window.confirm(strMsg) != true)
				alert("Resource 'To Date' is not in the range of request 'To Date'.");
				return false;
			}
			//End Of Addition
			//Added By VarunA on 5-Sep-2008
			//Purpose : To check if From Date & To Date validation
			if(disallowDate1LessThanDate2(objToDate,objFromDate)==true)
			{
			    alert("'To Date' should not be less than 'From Date'");
			    return false;
			}
			//End By VarunA on 5-Sep-2008
/*
			strMsg = "<%=MyBase.GetResourceString("FROM_DATE_NO_LESS_THAN_TODAY")%>";
			if(disallowDate1LessThanDate2(objFromDate, objToday, strMsg, true))
				return false;

			strMsg = "<%=MyBase.GetResourceString("FROM_DATE_NO_LESS_THAN_TODATE")%>";
			if(disallowDate1LessThanDate2(objToDate, objFromDate, strMsg, true))
				return false;
*/
			strMsg = "<%=MyBase.GetResourceString("FROM_DATE_MORE_THAN_START_DATE")%>";
			strMsg = replaceSubstring(strMsg, '<=>',objProjectFromDate.value);
			if(disallowDate1LessThanDate2(objFromDate, objProjectFromDate, strMsg, true))
				return false;

			strMsg = "<%=MyBase.GetResourceString("TODATE_NO_MORE_THAN_END_DATE")%>";
			strMsg = replaceSubstring(strMsg, '<=>', objProjectToDate.value);
			if(disallowDate1GreaterThanDate2(objToDate, objProjectToDate, strMsg, true))
				return false;
			
			
			strMsg = "<%=MyBase.GetResourceString("VALID_WORK_HOURS")%>";
			if(disallowNegativeNumeric(objWorkHours, strMsg))
				return false;
                    
			if(objWorkHours.value != '')
			{
				if(objTypePerDay.checked == true)
				{
					/*strMsg = "<%=MyBase.GetResourceString("VALID_WORK_HOURS")%>";
					if(disallowValueRangeViolation(objWorkHours, 1, 24, strMsg))
						return false;*/
					
					/*strMsg = "<%=MyBase.GetResourceString("WORK_HOURS_LESS_THAN_COMPANY_WORK_HOURS")%>";
					strMsg = replaceSubstring(strMsg, '<=>', objProjectWorkHours.value);
					if(disallowValue1GreaterThanValue2(objWorkHours, objProjectWorkHours, strMsg, true))
						return false;
						*/
						
					//Requested Work hours limit.
				}
				else if(objTypeTotal.checked == true)
				{
				}
				else if(objTypePercent.checked == true)
				{
					/*strMsg = "<%=MyBase.GetResourceString("WORK_HOURS_PERCENT_INRANGE")%>";
					if(disallowValueRangeViolation(objWorkHours, 1, 100, strMsg))
						return false;*/
				}
			}
			//Integrated By SanaSon 23-Oct-2009
			//Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 to avoid duplicate entries in Resources 
				blnIsSaveClicked =1;
			//End: Added By RajkumarM to resolve Issue V2 23518 on 23-Oct-2009 
			//End Integrated By SanaSon 23-Oct-2009
			return true;
		}
function EmployeeName_onClick(EmployeeID)
	{
	 
	  
        var objDiv = GetObjectReference('','EmployeeID'+EmployeeID);
        var objImg = GetObjectReference('','imgEmployeeShowHide'+EmployeeID);
        var IsCollapse = objImg.getAttribute("Collapse");
        var objTR = GetObjectReference('frmPM_ResourceAllocationDetails','Employee'+EmployeeID);
     
      if(IsCollapse=="Y")
        {   
            objImg.src='../../Images/plus.gif';
            objTR.style.display='none';
            objDiv.style.display='none';
            objImg.setAttribute("Collapse","N");
        }
        else if(IsCollapse=="N")
        {   
            objImg.src='../../Images/minus.gif';
            objTR.style.display=''; 
            objDiv.style.display='';            
            objImg.setAttribute("Collapse","Y");
        }
              
	}
		function Sort_OnClick(strFieldName, strAscOrDesc)
		{
			var objSortBy, objSortOrder;
			objSortBy = GetObjectReference('frmPM_ShowMoreResources','txthidSortBy');
			objSortOrder = GetObjectReference('frmPM_ShowMoreResources','txthidSortOrder');
			objSortBy.value = strFieldName;
			objSortOrder.value = strAscOrDesc;
			objform.submit();
		}
		
		function Type_OnClick()
		{
			var objTD, objTypePerDay, objTypePercent, objTypeTotalWorkHours;
			
			objTD = GetObjectReference('frmPM_ShowMoreResources','tdWorkHours');
			
			objTypePerDay = GetObjectReference('frmPM_ShowMoreResources','optPerDay');
			objTypePercent = GetObjectReference('frmPM_ShowMoreResources','optPercent');
			objTypeTotalWorkHours = GetObjectReference('frmPM_ShowMoreResources','optTotalWorkHour');
			
			if(objTypePerDay.checked == true)
				objTD.innerHTML = "<%=MyBase.GetResourceString("WORK_HOURS")%>";
			else if(objTypePercent.checked == true)
				objTD.innerHTML = "<%=MyBase.GetResourceString("WORK_HOURS")%>" + ' (%)';			
			else if(objTypeTotalWorkHours.checked == true)
				objTD.innerHTML = "<%=MyBase.GetResourceString("TOTAL_WORK_HOURS")%>";
		}
	<%' Added By nitinVS on 28 Aug 2009 %>	
		function ShowResourceAllocation(EmployeeID,startdate)		
		{
			window.open("../HR/ResourceAllocationDashbaord.aspx?Mode=RESOURCE&EmployeeId="+EmployeeID+"&FinancialType=D&FinancialPeriodCount=0&SpecificDate=" + startdate ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 330)/2 + ",width=650,height=330")
		}	
		<%' End Added By nitinVS on 28 Aug 2009 %>	
	
		</Script>
	</body>
</html>
