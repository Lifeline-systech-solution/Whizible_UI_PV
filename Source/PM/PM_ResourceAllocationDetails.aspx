<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ResourceAllocationDetails.aspx.vb" Inherits="PbNIT.PM_ResourceAllocationDetails"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("PAGE_TITLE"))%>
	
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


	<body  class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_ResourceAllocationDetails" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
			
			
				<Script language="javascript">
		var objform=GetFormReference('frmPM_ResourceAllocationDetails');
		var objdivlist=GetObjectReference('frmPM_ResourceAllocationDetails','PageDiv');
		//Added By PradeepD to resolve Issue Tavant 17713 on 28-Nov-2005 to avoid duplicate entries in Resources 
		var blnIsSaveClicked=0;
		//End: Added By PradeepD to resolve Issue Tavant 17713 on 28-Nov-2005 
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		   
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 13 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 13;
			    //}

			    intDivHeight =window.innerHeight  - objdivlist.offsetTop-37;
			    
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
		     	objdivlist.style.height = intDivHeight + 'px';	
			Tab_OnClick('<%=m_intSelectedTab%>');
			}
			Resize_SubTagsDivs();
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
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 13 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 13;
			    //}
			intDivHeight =window.innerHeight  - objdivlist.offsetTop-37;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';		}
			Resize_SubTagsDivs();
		}
		
		function Resize_SubTagsDivs()
		{
			var intDivHeight;
			var intDivHeightRisk;
			var objTabDiv, intOffsetTop = 0, intOffset=300;
			
			//Skills Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divSkillList');
			if (objTabDiv !=null) 
			{
				intOffsetTop = objTabDiv.offsetTop; 
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
				objTabDiv.style.height = intDivHeight+'px';	
			}
			//Allocated Resources Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divAllocatedResourcesList');
			if (objTabDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
				objTabDiv.style.height = intDivHeight+'px';	
			}
			//Similar requests Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divSimilarRequestsList');
			if (objTabDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
				objTabDiv.style.height = intDivHeight+'px';	
			}
			//Decline request Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divDeclineRequestComments');
			if (objTabDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
                //Commented and Added by Dhanashri S on 9 Dec 2015 For IssueID:2667
				//objTabDiv.style.height = intDivHeight;	
				objTabDiv.style.height = intDivHeight + 85 + 'px';
                //End of Comment and Addition by Dhanashri S on 9 Dec 2015
				
			}
			//Probable Resources Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divProbableResourcesList');
			if (objTabDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
				objTabDiv.style.height = intDivHeight+'px';	
			}
			//Configure Days Tab
			objTabDiv = GetObjectReference('frmPM_ResourceAllocationDetails','divConfigureDaysDetails');
			if (objTabDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - intOffsetTop - intOffset;
				if (intDivHeight < 100)	intDivHeight = 100;
				objTabDiv.style.height = intDivHeight+'px';	
			}
		}
		
		<%=m_strClientSideScript%>

		function CloseWindow()
		{
			window.opener.location=window.opener.location;
			window.close();
		}
		
		function ShowMore_OnClick()
		{
		    //Commented and added by Yogesh J on 15-Feb-2016 to generate Token
		  //  window.open("../PM/PM_ShowMoreResources.aspx?ProjectID=<%=m_lngRequestProjectId%>&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 940)/2 + ",top=" + (window.screen.height - 590)/2 + ",width=940,height=590");

		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'PM_ResourceAllocationDetails.aspx/GenrateURLToken_ShowMore_OnClick',
		        data: JSON.stringify({ ProjectID: "<%=m_lngRequestProjectId%>",RequestID:"<%=m_lngRequestID%>" }),
		        success: function (Result) {
		            window.open("../PM/PM_ShowMoreResources.aspx?FromWhere=PM&ProjectID=<%=m_lngRequestProjectId%>&RequestID=<%=m_lngRequestID%>&Token="+Result.d,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 940)/2 + ",top=" + (window.screen.height - 590)/2 + ",width=940,height=590");

		        },
		        error: function () {
		            //      alert("Error")
		        }
		    });
		    //End of addition by Yogesh J on 15-Feb-2016 to generate Token
		}
/*		
		function SimilarRequest()
		{
			window.open("../PM/PM_SimilarRequests.aspx?ProjectID=<%=m_lngRequestProjectId%>&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=350,width=750");
	//	}
//
		//function RequestDetails()
	//	{
	//		window.open("../General/CommonPage.aspx?MasterTagID=1223&ProjectID=<%=m_lngRequestProjectId%>&Mode=ShowDetails&RequestID=<%=m_lngRequestID%>" ,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=550,width=800");

	//	}

	//	function RejectRequest()
	//	{
	//		if(confirm("<%=MyBase.GetResourceString("REJECT_REQUEST_CONFIRM")%>"))
	//		{
	//			window.open("../HR/HR_AddComments.aspx?From=ResourceAllocation&ProjectID=<%=m_lngRequestProjectId%>&Mode=REJECT_REQUEST&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
	//		}
	//	}

	//	function ConfigureDays()
	//	{
	//		window.open("../PM/PM_ConfigureResourceAllocationDays.aspx?RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=350");
	//	}
//*///
		function ShowResume(intEmployeeID)
		{
			//window.open ("../HR/HR_EmployeeResume.aspx?EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");
		    //Commented added by Shamkant s on 16 Feb 2016
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    contentType: 'application/json',
			    url: 'PM_ResourceAllocationDetails.aspx/Resume_OnClick',
			    data: JSON.stringify({ EmployeeID:intEmployeeID }),
			    success: function (Result) {
			      
			        window.open ("../HR/HR_EmployeeResume.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");        
			    
			    },
			    error: function () {
			        //     alert("Error")
			    }
			});
		    //Commented Ended by Shamkant s on 16 Feb 2016
		}
		
		function ShowResourceLoading(intEmployeeID)
		{
			var dtToday = new Date();
			
				//Modified By VarunA on 3-Feb-2009 RequestID-18121
			//Purpose : To handle the year in Mozilla
			//window.open("../PM/PM_ResourceHistory.aspx?EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getYear(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			//window.open("../PM/PM_ResourceHistory.aspx?EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getFullYear(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
		    //End By VarunA on 3-Feb-2009 RequestID-18121
		    //Commented added by Shamkant s on 16 Feb 2016
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    contentType: 'application/json',
			    url: 'PM_ResourceAllocationDetails.aspx/ResourceLoad_OnClick',
			    data: JSON.stringify({ EmployeeID:intEmployeeID,Year:dtToday.getFullYear()}),
			    success: function (Result) {
			        window.open("../PM/PM_ResourceHistory.aspx?Token=" + Result.d + "&EmployeeID=" + intEmployeeID + "&Year=" + dtToday.getFullYear(), "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			      
			    
			    },
			    error: function () {
			        //     alert("Error")
			    }
			});
		    //Commented Ended by Shamkant s on 16 Feb 2016
		}
		
		function Allocate_OnClick()
		{
		
		//Added By PradeepD to resolve Issue Tavant 17713 on 28-Nov-2005 to avoid duplicate entries in Resources 
		//debugger;
		if (blnIsSaveClicked != 0)  {return;} 
		//End: Added By PradeepD to resolve Issue Tavant 17713
		 
		var url=new String();
		var objFromDate,objToDate,objWorkHours,objEmployeeID;
		var objchkAssign,intCnt;
		var lngRequestId = <%=m_lngRequestId%>;
		var strHtm='';
		
		if(ValidateInputs())
			{
			
			objchkAssign = GetObjectReference('frmPM_ResourceAllocationDetails','chkAssign', true);
			for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
			{
					if(objchkAssign[intCnt].checked == true)
					{
							objEmployeeID=objchkAssign[intCnt].value;
							objFromDate = GetObjectReference('frmPM_ResourceAllocationDetails','txtFromDate_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value).value;
							objToDate = GetObjectReference('frmPM_ResourceAllocationDetails','txtToDate_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value).value;
							objWorkHours = GetObjectReference('frmPM_ResourceAllocationDetails','txtWorkHours_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value).value;
							strHtm=strHtm + objEmployeeID+'|'+objFromDate+'|'+objToDate+'|'+objWorkHours+','
					}
			}
			
			
			
			url="../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_ALLOCATE%>&FromXML=1&SelectedResources="+strHtm;
			
			loadXMLDoc(url,'');
			return;
				//objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_ALLOCATE%>";
				//objform.submit();
			}
		}
		
		//Addition by TruptiK
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
		//Added by TrutpiK on 29-MAy-09
        //Purpose:-UI changes.

	function EmployeeName_onClick(EmployeeID)
	{
	 
	    var i=1;
        var objTD = GetObjectReference('',EmployeeID);
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
	function SearchByName_OnClick()
	{
	   window.open ("../General/CommonList.aspx?FromWhere=SM&MasterTagID=20079","_blank","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=700,height=550");
	}
	function close_OnClick()
	{
	    window.close();
	}
	function DeclineRequest()
	{
	   
	 // window.open("../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&Mode1=DeclineRequest&ResRequested=<%=m_intTotalResourcesRequested%>&ResAssigned=<%=m_intTotalResourcesAssigned%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 450)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=550,height=250");
	    //Commented added by Shamkant s on 16 Feb 2016
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PM_ResourceAllocationDetails.aspx/DeclineRequest_OnClick',
	        data: JSON.stringify({ RequestID:"<%=m_lngRequestID%>",ResRequested:"<%=m_intTotalResourcesRequested%>",ResAssigned:"<%=m_intTotalResourcesAssigned%>"}),
	        success: function (Result) {
	            window.open("../PM/PM_ResourceAllocationDetails.aspx?Token=" + Result.d + "&RequestID=<%=m_lngRequestID%>&Mode1=DeclineRequest&ResRequested=<%=m_intTotalResourcesRequested%>&ResAssigned=<%=m_intTotalResourcesAssigned%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 450)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=550,height=250");
	           // window.open("../HR/ResourceAllocationDashbaord.aspx?Token=" + Result.d + "&Mode=RESOURCE&EmployeeId="+EmployeeID+"&FinancialType=D&FinancialPeriodCount=0&SpecificDate=" + startdate ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 330)/2 + ",width=650,height=330")
				           
			    
	        },
	        error: function () {
	            //     alert("Error")
	        }
	    });
	    //Commented Ended by Shamkant s on 16 Feb 2016
	}
	
	//End of Addition by TruptiK on 29-MAy-09
	function state_Change() 
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
						
							if(arr1[2] >lngResourcePer&&lngResourcePer>0)
							{
								check=1
							   strEmpName=strEmpName+arr1[1]+','
							}
																								
					}
					strEmpName=strEmpName.substring(0,strEmpName.length-1);
					
					strMsg='Resource '+ strEmpName +' is overallocated. Do you want to continue?'
					
					
					if (check==1)
					{
						if (window.confirm(strMsg) != true)
						{
				
						blnIsSaveClicked=0;
						}
						
						else
						{
							objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_ALLOCATE%>";
							objform.submit();
						}
					}
					else
						{
							objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_ALLOCATE%>";
							objform.submit();
						}
					
					
			}}
	}
		//End of addition by TruptiK
		
		
		function ResourceAtProjectLocation_OnClick()
		{
			window.open("../PM/PM_ProjectLocationResources.aspx?ProjectID=<%=m_lngRequestProjectId%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
		}
		
		//added by harshk sp4 issueid 120,121 
		function GetJoiningDate(intEmployeeID)
		{
			var objcboJoiningDate;
			var intIndex;
			objcboJoiningDate = GetObjectReference('frmPM_ResourceAllocationDetails','cboJoiningDate');
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
			var objEmpName = GetObjectReference('frmPM_ResourceAllocationDetails','txthidEmployeeName_' + intEmployeeID);
			strJDate = GetJoiningDate(intEmployeeID);
			dtJDate = getDate(strJDate);
			dtSDate = getDate(objStartDate.value);
			if(dtSDate < dtJDate)
			{
				//modified by HarshK on 05/09/2005 for sp4 issueid 136 
				strMessage = "<%=MyBase.GetResourceString("RESOURCE_JOINING_VALIDATION")%>";
				//end modification by HarshK on 05/09/2005 for sp4 issueid 136
				strMessage = replaceSubstring(strMessage, '<=>',objEmpName.value);
				strMessage = replaceSubstring(strMessage, '<==>',strJDate);
				alert(strMessage);
				return false;
			}
			return true;
		}
		//END added by harshk sp4 issueid 120,121 
		function ValidateInputs()
		{
			var objProjectFromDate, objProjectToDate, objProjectWorkHours;
				var objFromDate, objToDate, objWorkHours, objchkAssign, intChecked, objMinAllocation;
			var dblRequestedWorkHours = <%=m_dblRequestedWorkHours%>, strType = '<%=m_strType%>'; 
			var lngRequestId = <%=m_lngRequestId%>, intCnt, strMsg, blnFound;
			var objEmployeeTeamID, objEmployeeName;
			var strEmployeeWithDiffTeam = '', lngRequestTeamID=<%=m_lngRequestTeamID%>, objProjectRole;
			//Added By NileshD on 10 Jan 2005
			var objRequestFromDate, objRequestToDate;
			intChecked = 0;
			
			var TotalWorkHours=0;
			var RequestHours="<%=m_dblRequestedWorkHours%>";
			var AssignedHours=GetObjectReference('frmPM_ResourceAllocationDetails','txthidTotalHrs');
			
			objProjectFromDate = GetObjectReference('frmPM_ResourceAllocationDetails','txthidProjectFromDate');
			objProjectToDate = GetObjectReference('frmPM_ResourceAllocationDetails','txthidProjectToDate');
			objProjectWorkHours = GetObjectReference('frmPM_ResourceAllocationDetails','txthidProjectWorkHours');
			//Added By NileshD on 10 Jan 2005
			objRequestFromDate = GetObjectReference('frmPM_ResourceAllocationDetails','txthidRequestFromDate');
			objRequestToDate = GetObjectReference('frmPM_ResourceAllocationDetails','txthidRequestToDate');
			
							
			blnFound = false;
			objchkAssign = GetObjectReference('frmPM_ResourceAllocationDetails','chkAssign', true);
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
				alert("<%=MyBase.GetResourceString("SELECT_ATLEAST_ONE_RESOURCE_TO_ASSIGN")%>");
				return false;
			}
			
			if(intChecked > (parseInt("<%=m_intTotalResourcesRequested%>") - parseInt("<%=m_intTotalResourcesAssigned%>")))
			{
				alert("<%=MyBase.GetResourceString("SELECTED_MORE_THAN_REQUESTED")%>");
				return false;
			}
			for(intCnt=0; intCnt < objchkAssign.length; intCnt++)
			{
				if(objchkAssign[intCnt].checked == true)
				{
					objFromDate = GetObjectReference('frmPM_ResourceAllocationDetails','txtFromDate_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);
					objToDate = GetObjectReference('frmPM_ResourceAllocationDetails','txtToDate_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);
					objWorkHours = GetObjectReference('frmPM_ResourceAllocationDetails','txtWorkHours_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);
	objResWorkHours = GetObjectReference('frmPM_ResourceAllocationDetails','txtWorkHourshid_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);                    
					objMinAllocation = GetObjectReference('frmPM_ResourceAllocationDetails','txtMinAllocation_' + lngRequestId.toString() + '_' + objchkAssign[intCnt].value);                                      
                    
                    TotalWorkHours=parseFloat(TotalWorkHours)+parseFloat(objWorkHours.value);
                	strMsg = "<%=MyBase.GetResourceString("SELECT_FROM_DATE")%>";
					if(disallowBlank(objFromDate, strMsg, true))
						return false;

					strMsg = "<%=MyBase.GetResourceString("SELECT_TO_DATE")%>";
					if(disallowBlank(objToDate, strMsg, true))
						return false;

					strMsg = "<%=MyBase.GetResourceString("TO_DATE_GREATER_THAN_FROM_DATE")%>";
					if(disallowDate1LessThanDate2(objToDate, objFromDate, strMsg, true))
						return false;

					strMsg = "<%=MyBase.GetResourceString("FROM_DATE_GREATER_THAN_PROJECT_START_DATE")%>";
					strMsg = replaceSubstring(strMsg, '<=>', objProjectFromDate.value);
					if(disallowDate1LessThanDate2(objFromDate, objProjectFromDate, strMsg, true))
						return false;

					strMsg = "<%=MyBase.GetResourceString("TO_DATE_NOT_GREATER_THAN_PROJECT_END_DATE")%>";
					strMsg = replaceSubstring(strMsg, '<=>', objProjectToDate.value);
					if(disallowDate1GreaterThanDate2(objToDate, objProjectToDate, strMsg, true))
						return false;

					//Added By NileshD on 10 Jan 2005
					strMsg = "<%=MyBase.GetResourceString("RESOURCE_FROM_DATE_NOT_GREATER_THAN_REQUEST_DATE")%>";
					strMsg=replaceSubstring(strMsg,"&#39;","'");
					if(disallowDate1LessThanDate2(objFromDate , objRequestFromDate,strMsg) == true)
					//Modified by TruptiK on 29-Feb-2008
					   //if (window.confirm(strMsg) != true)
					  // alert(strMsg);
						//return false;
						return;
						//end of addition by TruptiK
					
					strMsg = "<%=MyBase.GetResourceString("RESOURCE_TO_DATE_NOT_GREATER_THAN_REQUEST_DATE")%>";
					strMsg=replaceSubstring(strMsg,"&#39;","'");
					if(disallowDate1LessThanDate2(objRequestToDate, objToDate,strMsg) == true)
						//Modified by TruptiK on 29-Feb-2008
					   //if (window.confirm(strMsg) != true)
					   //alert(strMsg);
						//return false;
						return;
						//end of addition by TruptiK
					//End Of Addition
										
					strMsg = "<%=MyBase.GetResourceString("ENTER_ASSIGNED_WORK_HOURS")%>";
					if(disallowBlank(objWorkHours, strMsg))
						return false;
					
					strMsg = "<%=MyBase.GetResourceString("WORK_HOURS_POSITIVE_NUMBER")%>";
					if(disallowMinValueViolation(objWorkHours, 0.001, strMsg))
						return false;

	if (parseFloat(objWorkHours.value) > parseFloat(objResWorkHours.value))
					{	
						alert('Available Capacity of Resource is less than requested capacity. So can not allcoate the resource.');
						return false;
					}
					if(strType == "<%=TYPE_PER_DAY%>")
					{
						strMsg = "<%=MyBase.GetResourceString("VALID_WORK_HOURS")%>";
						if(disallowValueRangeViolation(objWorkHours, 1, 24, strMsg))
							return false;

						/*strMsg = "<%=MyBase.GetResourceString("WORK_HOURS_LESS_THAN_COMPANY_WORK_HOURS")%>";
						strMsg = replaceSubstring(strMsg, '<=>', objProjectWorkHours.value);
						if(disallowValue1GreaterThanValue2(objWorkHours, objProjectWorkHours, strMsg, true))
							return false;*/

						strMsg = "<%=MyBase.GetResourceString("ASSIGNED_WORKHOURS_NOT_GREATER_THAN_REQUESTED")%>";
						if(disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
							return false;
		
						strMsg = "Requested Work Hours are more than Maximum Free Hours Per Day. So can not allcoate the resource.";
						if(disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))
							return false;
					}
					else if(strType == "<%=TYPE_TOTAL_WORKHOURS%>")
					{
					//Added By NileshD on 10 Jan 2005 to resolve the issue 14875
						strMsg = "<%=MyBase.GetResourceString("ASSIGNED_WORKHOURS_NOT_GREATER_THAN_REQUESTED")%>";
						if(disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
						return false;
						
						//if (parseFloat(RequestHours)<=parseFloat(TotalWorkHours))
						//{
						 
						//if(!confirm("You are allocation all hours"))
						//{
				        // return;
				        // }
				         //}
							
					//End Of Addition
					}
					else if(strType == "<%=TYPE_PERCENT_WORKHOURS%>")
					{
						strMsg = "Allocated Resource Percentage is more than Requested resource percentage";
						if(disallowMaxValueViolation(objWorkHours, dblRequestedWorkHours, strMsg, true))
							return false;
						
						strMsg = "Requested Work Hours (%) is more than Maximum Free Percentage. So can not allcoate the resource. ";
						if(disallowMaxValueViolation(objWorkHours, objMinAllocation.value, strMsg, true))
					
							return false;
					}
/*					
					//Check for the team of the selected resource before allocation
					objEmployeeTeamID = GetObjectReference('frmPM_ResourceAllocationDetails','txthidTeamID_' + objchkAssign[intCnt].value);
					objEmployeeName = GetObjectReference('frmPM_ResourceAllocationDetails','txthidEmployeeName_' + objchkAssign[intCnt].value);
					if(lngRequestTeamID	!= objEmployeeTeamID.value)
					{
						strEmployeeWithDiffTeam = strEmployeeWithDiffTeam + objEmployeeName.value + '\n';
						objchkAssign[intCnt].checked = false;
						intChecked--;
					}
*/					//Added by HarshK whizibleSemsp4 issueid 120,121 
					if(JoiningDateValidation(objFromDate,objchkAssign[intCnt].value) == false)
					{
						return false;
					}
					//End Added by HarshK whizibleSemsp4 issueid 120,121 
				}
			}
/*			
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
			strmsg1="Please select the Resource status on Project"
			if(disallowBlank(objProjectRole, strMsg, true))
				return false;
				if(disallowBlank(objProjectStatus, strmsg1, true))
				return false;
				
				
				 if(strType == "<%=TYPE_TOTAL_WORKHOURS%>")
					{
					//Added By NileshD on 10 Jan 2005 to resolve the issue 14875
					//if 
					 TotalWorkHours=parseFloat(TotalWorkHours)+parseFloat(AssignedHours.value)						
						//alert(TotalWorkHours);
						if (parseFloat(RequestHours)<=parseFloat(TotalWorkHours))
						{
						 
						if(!confirm("You are allocating all work hours"))
						{
				         return;
				         }
				         }
				         }
				//End of addition by TruptiK
//End Addition
//Added By PradeepD to resolve Issue Tavant 17713 on 28-Nov-2005 to avoid duplicate entries in Resources
				blnIsSaveClicked =1;
//End: Added By PradeepD to resolve Issue Tavant 17713 on 28-Nov-2005 to avoid duplicate entries in Resources
			return true;
		}
		
		function DeclineRequest_OnClick()
		{
			var objComments, strMsg, intMaxLength=1500;
			
			objComments = GetObjectReference('frmPM_ResourceAllocationDetails','txtDeclineComments');
			
			if(disallowBlank(objComments, "Comments should not be left blank"))
				return;
			strMsg = "<%=MyBase.GetResourceString("COMMENTS_MAXLENGTH")%>";
			strMsg = replaceSubstring(strMsg, '<=>', intMaxLength.toString());
			if(disallowMaxlengthViolation(objComments, intMaxLength, strMsg))
				return;
			if(!confirm("Do you want to decline this request?"))
				return;
			
			objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_DECLINE_REQUEST%>";
			objform.submit();
		}
		
		function SaveConfigureDays_OnClick()
		{
			var objConfigureDays;
	  	    var strMsg;

			objConfigureDays = GetObjectReference('frmPM_ResourceAllocationDetails','txtNoOfDays');
			strMsg = "<%=MyBase.GetResourceString("NO_DAYS_MESSAGE")%>";
			if (disallowBlank(objConfigureDays,strMsg) == false ) 
			{
				if (disallowNonInteger(objConfigureDays,strMsg)== false)
				{
					if (disallowNegativeInteger(objConfigureDays,strMsg) == false)
					{
						objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Action=<%=ACTION_SAVE_CONFIGUREDAYS%>";
						objform.submit();
					}
				}
			}
		}
		
		function ShowRejectComments(intAssignmentID)
		{
			window.open("../HR/HR_AddComments.aspx?From=ResourceAllocation&Mode=REJECT_RESOURCE_VIEW&AssignmentID=" + intAssignmentID ,"_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_OnClick()
		{
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2021&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_RM_OnClick()
		{
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2058&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_OUM_OnClick(flag,Manager,level,BG)
		{
		   if (flag==1)    
		   {
		    if (Manager=="" && level=='GRP')
		    {
		    	alert("Please set Global Resource Pool Manager");
		        return;
		       
		    }
		   
		    
		     if (Manager=="")
		    {
		         var strMsg='Please set Manager for Business Group <=>'
		         strMsg = replaceSubstring(strMsg, '<=>',"'"+ BG + "'"); 
		         alert(strMsg);
		        return;
		       
		    }
		    
		    }
		  
		    
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2027&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}

		function EscalateRequest_BGM_OnClick(flag,Manager,level)
		{
		   if (Manager=="")
		    {
		        alert("Please set Global Resource Pool Manager");
		        return;
		        
		    }
			window.open("../General/CommonPage.aspx?From=RM&MasterTagID=2078&RequestID=<%=m_lngRequestID%>","_blank","resizable=yes,scrollbars=no,Left=100,Top=100,height=250,width=550");
		}
		
		function Sort_OnClick(strFieldName, strAscOrDesc)
		{
			var objSortBy, objSortOrder;
			var objSelectedTabIndex;
			
			objSelectedTabIndex = GetObjectReference('frmPM_ResourceAllocationDetails','txthidSelectedTabIndex');
			objSelectedTabIndex.value = <%=TAB_PROBABLE_RESOURCES%>;
			objSortBy = GetObjectReference('frmPM_ResourceAllocationDetails','txthidSortBy');
			objSortOrder = GetObjectReference('frmPM_ResourceAllocationDetails','txthidSortOrder');
			objSortBy.value = strFieldName;
			objSortOrder.value = strAscOrDesc;
			objform.action = "../PM/PM_ResourceAllocationDetails.aspx?RequestID=<%=m_lngRequestID%>&ProjectID=<%=m_lngRequestProjectId%>&Sort=1";
			objform.submit();
		}
				
	<%' Added By nitinVS on 28 Aug 2009 %>
		function ShowResourceAllocation(EmployeeID,startdate)		
		{
			//window.open("../HR/ResourceAllocationDashbaord.aspx?Mode=RESOURCE&EmployeeId="+EmployeeID+"&FinancialType=D&FinancialPeriodCount=0&SpecificDate=" + startdate ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 330)/2 + ",width=650,height=330")
		
				    <%' End Added By nitinVS on 28 Aug 2009 %>		
				    //Commented added by Shamkant s on 16 Feb 2016
				    $.ajax({
				        type: 'POST',
				        dataType: 'json',
				        contentType: 'application/json',
				        url: 'PM_ResourceAllocationDetails.aspx/ResourceAlloc_OnClick',
				        data: JSON.stringify({ EmployeeID:EmployeeID,FinancialPeriodCount:"0",SpecificDate:startdate}),
				        success: function (Result) {
				            window.open("../HR/ResourceAllocationDashbaord.aspx?Token=" + Result.d + "&Mode=RESOURCE&EmployeeId="+EmployeeID+"&FinancialType=D&FinancialPeriodCount=0&SpecificDate=" + startdate ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 330)/2 + ",width=650,height=330")
				           
			    
				        },
				        error: function () {
				            //     alert("Error")
				        }
				    });
		    //Commented Ended by Shamkant s on 16 Feb 2016
		}
	
	</Script>
		
	</body>
</HTML>
