<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskReallocation.aspx.vb" Inherits="PbNIT.PM_TaskReallocation" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%=CommonFunctions.General.PlotPageHeadTag(m_strPageTitle)%>
	
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
    #PageDiv {
        overflow:auto;   /*Added by Yogesh J on 14/12/2015*/
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


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmPM_TaskReallocation" method="post" runat="server">
		<%' Modified By NitinVS 0n 26 Apr 2007 for WhizilbeSEM SP 8 regression Fixes %>	
		<%' call the pageInit Method inplace of ShowTaskList %>	
									<%call PageInit()%>
		<%' End Modification By NitinVS 0n 26 Apr 2007 for WhizilbeSEM SP 8 regression Fixes %>									
					</form>
				
					<Script language="javascript">
		var objform=GetFormReference('frmPM_TaskReallocation');
		var objdivlist = GetObjectReference('frmPM_TaskReallocation', 'PageDiv');
		 
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
            //Added And Commented By Vidya J On 8-12-2015
		    
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist != null) {
			    //Commented And Added By Vaijat K ON 30/11/2015
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



			    //intDivHeight = window.innerHeight - objdivlist.offsetTop + 272;

			    if (WhichBrowser() == 'IE') {
			        //Commented and Added By Bharat T on 24th-Nov-2015
			        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 579;
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			        //End Of Commented and Added By Bharat T on 24th-Nov-2015			      			        
			    }
			    else
			        if (WhichBrowser() == 'CR') {
			            //Commented and Added By Bharat T on 24th-Nov-2015
			            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 468;
			            intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			            //End of Commented and Added By Bharat T on 24th-Nov-2015			            
			        }
			        else
			            if (WhichBrowser() == 'FF') {
			                //Commented and Added By Bharat T on 24th-Nov-2015
			                //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 460;
			                intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
			                //End of Commented and Added By Bharat T on 24th-Nov-2015			
			            }
			    //End Added By Vaijat K ON 30/11/2015
			    if (intDivHeight < 100) intDivHeight = 100;
			    objdivlist.style.height = intDivHeight + "px";
			}

			 

		    //objdivlist.style.height=intDivHeight;

        }


	 
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
		
					    // End Of Added And Commented By Vidya J On 8-12-2015

		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist != null) {
			    //Commented And Added By Vaijat K ON 30/11/2015
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
                //Commented by Yogesh J on 14/12/2015
			    // intDivHeight = window.innerHeight - objdivlist.offsetTop + 272;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 26;
                //End of comment by Yogesh J on 14/12/2015
			    //Commented And Added By Vaijat K ON 30/11/2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	}
		}	
		
		function Assign_onClick()
			{
				if (confirm("<%=MyBase.getResourceString("MSG_CONFIRM")%>"))
				{					
				//strList=strList+window.frmPM_TaskReallocation.chkReallocate[window.frmPM_TaskReallocation.chkReallocate.length].value
				//Modified by HarshK for sp4 issueid 120,121
				window.location.href="PM_TaskReallocation.aspx?PageID=2&mode=Assign&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=<%=m_lngEmployeeID%>" + "&hdnInvalidTaskIDs=" + GetObjectReference('frmPM_TaskReallocation','hdnInvalidTaskIDs').value;
				//End Modified by HarshK for sp4 issueid 120,121
				}			
			}
			
		//Function Name :Next_onClick
		//Purpose : Set mode=Next and redirects to Next page with Reallocate Task list.
		//Parameters :None
		//Returns : None	
		function Next_onClick(intPageID)
			{
			var iCount
			var strList
			var ToBeReallocatedCount=0
			
				if (intPageID == 1) 
				{
					//Modified by MrugajaB on 31st Aug 2006 for Whiziblesem SP 7 Issue ID.4168
			//var objchkReallocate=document.getElementById("chkReallocate")
			var objchkReallocate=GetObjectReference('frmPM_TaskReallocation','chkReallocate',true)
				
					if(!objchkReallocate)
						{
							return;
						}
						strList=""
						/*for (iCount=0;iCount<window.frmPM_TaskReallocation.chkReallocate.length;iCount++)
						{
						
							if (window.frmPM_TaskReallocation.chkReallocate[iCount].checked)
								{
								//alert (window.frmPM_TaskReallocation.chkReallocate[iCount].value)
								strList=strList + window.frmPM_TaskReallocation.chkReallocate[iCount].value + ","
								ToBeReallocatedCount++;
								}
						}*/
						
						for (iCount=0;iCount<objchkReallocate.length;iCount++)
						{
						
							if (objchkReallocate[iCount].checked)
								{
								//alert (window.frmPM_TaskReallocation.chkReallocate[iCount].value)
								strList=strList + objchkReallocate[iCount].value + ","
								ToBeReallocatedCount++;
								}
						}
						
					//If chkReallocate is not a array and is a single check box
					if(ToBeReallocatedCount==0)
						{	
							//if not a array only single check box is present
							if (objchkReallocate.checked)
								{
								strList=strList + objchkReallocate.value+ ","
								ToBeReallocatedCount++;
								}
						}
						
					if(ToBeReallocatedCount>0)
						{
								//strList=strList+window.frmPM_TaskReallocation.chkReallocate[window.frmPM_TaskReallocation.chkReallocate.length].value
								
								window.location.href="PM_TaskReallocation.aspx?EmployeeID=<%=m_lngEmployeeID%>&PageID=1&mode=Reallocate&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&ReallocateTaskList=" + strList 
								
						}
					else
						{
							alert("<%=MyBase.getResourceString("MSG_SELECTTASK")%>")
						}	
						
				}
				
				if (intPageID == 2)
				{
					//Modified by MrugajaB on 31st Aug 2006 for Whiziblesem SP 7 Issue ID.4168
					//var objResource=document.getElementById("cboResource")
					var objResource=window.document.forms['frmPM_TaskReallocation'].elements['cboResource'];
					
					if(!objResource)
						{
							return;
						}
					//var strResource=window.frmPM_TaskReallocation.cboResource.value	
					var strResource=objResource.value;
					var url
					strResource=strResource*1
					//End Mdification by MrugajaB
					if(strResource)
						{
								//strList=strList+window.frmPM_TaskReallocation.chkReallocate[window.frmPM_TaskReallocation.chkReallocate.length].value
								//commented and added by SuchitraP on 31-July-2007
								//purpose:To display an alert msg when startdate and enddate of Resource does not
								//        fall in between startdate and enddate of selected task
								//window.location.href="PM_TaskReallocation.aspx?PageID=2&mode=Reallocatetemp&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=" + strResource 
								url="../PM/PM_TaskReallocation.aspx?FromXML=1&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=" + GetObjectReference('frmPM_TaskReallocation','cboResource').value; 
								loadXMLDoc(url,'');
								
								//end of comment and addition by SuchitraP on 31-July-2007
								
						}
					else
						{
							alert("<%=MyBase.getResourceString("PAGE_CAPTIONSECOND")%>")
						}
					}
					
			}
			
	//addition done by SuchitraP on 31-July-2007
					    function loadXMLDoc(url, reqQuery) {
					        //Commented and added by Yogesh J on 22/12/2015 for Issue id=2778
					        if (window.XMLHttpRequest) {
					            //xmlhttp=new XMLHttpRequest();
					            //Commented By VarunA on 24-Sep-2008 IssueID-22545
					            //Purpose : Mozilla 
					            //xmlhttp.onreadystatechange=state_Change;
					            //End By VarunA on 24-Sep-2008 IssueID-22545
					            // 	if (ns) 
					            // 	{   
					            // 	        //Commented and Added By VarunA on 24-Sep-2008 IssueID-22545
					            //             //Purpose : Mozilla 
					            //             //xmlhttp.open('GET',url+'&'+reqQuery,false);
					            // 			//xmlhttp.send(false);
					            // 	        xmlhttp.onreadystatechange = state_Change();
					            // 	        xmlhttp.open('GET',url+'&'+reqQuery,false);
					            // 	        xmlhttp.send(null);
					            // 	        if (xmlhttp.responseText != null)
					            //             {
					            // 	            xmlDoc= document.implementation.createDocument("","",null);
					            // 	            xmlDoc.async=false;
					            // 	            xmlDoc.load(xmlhttp.responseXML);
					            // 	            state_Change();						
					            //             }
					            // 	        //End By VarunA on 24-Sep-2008 IssueID-22545				   
					            // 	}
					            // 	else 
					            // 	{       //Added By VarunA on 24-Sep-2008 IssueID-22545
					            //             //Purpose : Internet Explorer 
					            // 	        xmlhttp.onreadystatechange=state_Change;
					            // 	        //End By VarunA on 24-Sep-2008 IssueID-22545
					            // 	        xmlhttp.open('POST',url,false);
					            // 			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
					            // 			xmlhttp.send(reqQuery);
					            // 	}
					            //  }
					            //else if (window.ActiveXObject) 
					            //  {
					            //     xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
					            // 	if (xmlhttp) 
					            // 	  {
					            // 			xmlhttp.onreadystatechange=state_Change;
					            // 			xmlhttp.open('POST',url,false);
					            // 			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
					            // 			xmlhttp.send(reqQuery);
					            // 	   }
					            //  }
					            if (WhichBrowser() == 'IE') {
					                xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
					                if (xmlhttp) {
					                    xmlhttp.onreadystatechange = state_Change;
					                    xmlhttp.open('POST', url, false);
					                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
					                    xmlhttp.send(reqQuery);
					                }

					            }
					            else {
					                xmlhttp = new XMLHttpRequest();
					                xmlhttp.open('GET', url + '&' + reqQuery, false);
					                //xmlhttp.send(false);
					                xmlhttp.onreadystatechange = state_Change();
					                xmlhttp.open('GET', url + '&' + reqQuery, false);
					                xmlhttp.send(null);
					                if (xmlhttp.responseText != null) {
					                    xmlDoc = document.implementation.createDocument("", "", null);
					                    xmlDoc.async = false;
					                    if (WhichBrowser() == 'FF')
					                        xmlDoc.load(xmlhttp.responseXML);
					                    state_Change();
					                }
					            }
					        }
                            //End of additon by Yogesh J on 22/12/2015 for issue id=2778
					    }
       

        function state_Change() 
        {
			var str;
			var arrOptions;
			var iterator,showTasks;
			var strTasks='';
			var strResrc;
            if (xmlhttp.readyState==4)
				{
					if (xmlhttp.status==200)
						{
						  str=xmlhttp.responseText;
       
							if(str!='' && str!=null)
							{
								strResrc=GetObjectReference('frmPM_TaskReallocation','cboResource');
								arrOptions=str.split('|');
								if(arrOptions[0]=="1")
								{
									for(iterator=3;iterator<arrOptions.length;iterator=iterator+1)
									{
										strTasks+=arrOptions[iterator]+','
									}
									showTasks=replaceSubstring(strTasks.substring(0,strTasks.length-1),',',',\n');
									alert('StartDate,EndDate should be between Resource ('+strResrc.options[strResrc.selectedIndex].innerHTML+') StartDate ('+arrOptions[1]+') and EndDate ('+arrOptions[2]+') on project for tasks:- \n'+showTasks);
								}
								else
								{
									window.location.href="PM_TaskReallocation.aspx?PageID=2&mode=Reallocatetemp&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=" + strResrc.value 
								}
							}
				 
						}
				 }
		}
		//end of addition done by SuchitraP on 31-July-2007		
			
		//Function Name :Back_onClick
		//Purpose : To redirect to Previous page .
		//Parameters :None
		//Returns : None
		
				function Back_onClick(intPage)
		{
			//Go Back To previous page 
			if (intPage==0)
			{
				//Modified by MrugajaB on 31st Aug 2006 for Whiziblesem SP 7 Issue ID.4168
					//var objResource=document.getElementById("cboResource")
					//var objResource=GetObjectReference('frmPM_TaskReallocation','cboResource',true)
					var objResource=window.document.forms['frmPM_TaskReallocation'].elements['cboResource'];
				if(!objResource)
					{
						return;
					}
				
				strResource=objResource.value;	
				strResource=strResource*1;
				
				window.location.href="PM_TaskReallocation.aspx?PageID=0&mode=Tasks&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=" + strResource ;
				//End Modification
			}
			if (intPage==1)
			{
				window.location.href="PM_TaskReallocation.aspx?PageID=1&mode=Resource&ReallocateTaskList=<%=m_strReallocateTaskList%>&ProjectEmployeeRoleID=<%=m_lngEmpRoleID%>&EmployeeID=<%=m_lngEmployeeID%>"
			}
       }
       	
			
		//Function Name :ClearAll_onClick
		//Purpose : Deselects all the checkboxes for Reallocation
		//Parameters :None
		//Returns : None	
			
			
			function ClearAll_onClick()
			{
			//Selects or Deselects all the checkboxes
			var iCount
			var strList
			//If object does not exist then return
			
			//Modified by MrugajaB on 31st Aug 2006 for Whiziblesem SP 7 Issue ID.4168
			//var objchkReallocate=document.getElementById("chkReallocate")
			var objchkReallocate=GetObjectReference('frmPM_TaskReallocation','chkReallocate',true)
			
			
			<%'Modified By NitinVS on 5 July 2007 for WhizibleSEM 7 %>
			if(objchkReallocate.length==0)
				{
					return;
				}
			<%' End Modified By NitinVS on 5 July 2007 for WhizibleSEM 7 %>
			
			strList=""
				//Clear all checkboxes and set flag to Select
				/*	for (iCount=0;iCount<window.frmPM_TaskReallocation.chkReallocate.length;iCount++)
						{
							if (window.frmPM_TaskReallocation.chkReallocate[iCount].checked==true)
							{
								window.frmPM_TaskReallocation.chkReallocate[iCount].checked=false
							}
						}
					if (iCount == 0)
						{
						if (window.frmPM_TaskReallocation.chkReallocate.checked==true)
							{
								window.frmPM_TaskReallocation.chkReallocate.checked=false
							}
						}*/
						
							for (iCount=0;iCount<objchkReallocate.length;iCount++)
						{
							if (objchkReallocate[iCount].checked==true)
							{
								objchkReallocate[iCount].checked=false
							}
						}
					if (iCount == 0)
						{
						if (objchkReallocate.checked==true)
							{
								objchkReallocate.checked=false
							}
						}
						//End Modification by MrugajaB for Whiziblesem SP7 Issue ID.4168
			}
			
		//Function Name :SelectAll_onClick
		//Purpose : Selects/Deselects all the checkboxes for deletion
		//Parameters :None
		//Returns : None
		function SelectAll_onClick()
			{
			//Selects or Deselects all the checkboxes
			var iCount
			var strList
			//If object does not exist then return
			
			//Modified by MrugajaB on 31st Aug 2006 for Whiziblesem SP 7 Issue ID.4168
			//var objchkReallocate=document.getElementById("chkReallocate")
			var objchkReallocate=GetObjectReference('frmPM_TaskReallocation','chkReallocate',true)
			<%'Modified By NitinVS on 5 July 2007 for WhizibleSEM 7 %>
			if(objchkReallocate.length==0)
				{
					return;
				}
			<%' End Modified By NitinVS on 5 July 2007 for WhizibleSEM 7 %>
			strList=""
		
				//select allcheckboxes and set flag to Clear
					//for (iCount=0;iCount<window.frmPM_TaskReallocation.chkReallocate.length;iCount++)				
					for (iCount=0;iCount<objchkReallocate.length;iCount++)				
						{
						/*if (window.frmPM_TaskReallocation.chkReallocate[iCount].checked==false)
							{
								if(window.frmPM_TaskReallocation.chkReallocate[iCount].disabled==false)
									window.frmPM_TaskReallocation.chkReallocate[iCount].checked=true
							}
						}*/
						
						if (objchkReallocate[iCount].checked==false)
							{
								if(objchkReallocate[iCount].disabled==false)
									objchkReallocate[iCount].checked=true
							}
						}
					if (iCount == 0)
						{
						if (objchkReallocate[iCount].checked==false)
							{
								objchkReallocate[iCount].checked=true
							}
						}
						//End Modification
							
			}
			
	
		//Function Name :Help_onClick
		//Purpose : To redirect to Help Page.
		//Parameters :None
		//Returns : None
		function Help_onClick(strHelpID)
			{
			window.open("../General/Help.aspx?HelpID=" + strHelpID + "","","menubar=no,scrollbars=yes,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=200")
			}
		//Function Name :Close_onClick
		//Purpose : To redirect to Previous page .
		//Parameters :None
		//Returns : None
		
			function Close_onClick()
		{
			//To Close page 
			window.close();
        }
        
					</Script>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
