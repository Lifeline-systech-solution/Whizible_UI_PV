<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_AssignTaskResources.aspx.vb" Inherits="PbNIT.PM_AssignTaskResources"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <head>
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
		<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
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


    </head>
		<body class="clsBody" onresize="window_onresize()"  onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmPM_AssignTaskResources" method="post" runat="server">
		<%PageInit%>
		</form> 
		<SCRIPT language="javascript">
			var objform=GetFormReference('frmPM_AssignTaskResources');
			var objdivlist=GetObjectReference('frmPM_AssignTaskResources','PageDiv');
			var objTaskSDt,objTaskEDt,objTaskHrs,objBalenceWork;			
			var strHolidays = "<%=m_strHolidays%>";
			var ProjectType;
			//added by HarshK for sp4 issueid 120,121 on 06/10/2005
			var intResourceValidation = <%=m_bitResourceValidation%>;
			//End added by HarshK for sp4 issueid 120,121 on 06/10/2005
			'<%MyBase.InitializeResources("AppResources.PM_AssignTaskResources", "AppResources")%>';
			 //Modified by JyotiG on Date 12 July, 2006 for WhizibleSEM Issue ID.4168 
			 
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>	 
			 
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (objdivlist !=null) {
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)	intDivHeight = 100;
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
				}
				
/*				if('<%=m_strMode%>'=='<%=CONST_MODE_SUBTASK%>')
				{	
					window.resizeTo(770,500);	
					window.moveTo((window.screen.width - 770)/2,(window.screen.height - 500)/2);
				}*/			
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
				//Commented and added by Yogesh J on 11/12/2015
				    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';
            }
			}
					
	//******************************************************************************************
	///Added by ManishK  on 7th Feb 06 for whizibleSem sp6 WFH customization
	//******************************************************************************************
		var strResult='';
		var brw=isIE(); 
		var req;
		function generateRequest(url) 
			{ 
		  		// Mozilla and Friends 
			/*	if (window.XMLHttpRequest) 
				{ 
					req = new XMLHttpRequest(); 
				} else if (window.ActiveXObject) { 
					// Internet Explorer 
					req = new ActiveXObject("Microsoft.XMLHTTP"); 
				} 
				
				req.onreadystatechange = Process;
				req.open("POST", url,true); 
				req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				req.send(null);*/
				
				//Mrugaja
					strNavigator = navigator.appName;
							strNavigator = strNavigator.toUpperCase();
		    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
							if(brw=="IE")
							{ 
								g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
								//hook the event handler
								g_objXHttp.onreadystatechange = Process;
								//prepare the call, http method=GET, false=asynchronous call
								g_objXHttp.open("GET",url, false);
								//finally send the call
								g_objXHttp.send();
							}
							else
							{
							
								// Mozilla - based browser , Netscape
								g_objXHttp = new XMLHttpRequest();
								//hook the event handler
								g_objXHttp.onreadystatechange = Process;
								//prepare the call, http method=GET, false=asynchronous call
								g_objXHttp.open("GET",url, false);
								//finally send the call
								g_objXHttp.send(null);
								
								if ( g_objXHttp.responseText != null)
								{
										xmlDoc= document.implementation.createDocument("","",null);
										xmlDoc.async=false;
								    if(brw=="FF")//added by Nilesh g on 10/12/2015
									xmlDoc.load(req.responseXML);
									//xmlDoc.load(g_objXHttp.responseXML);
										strResult=g_objXHttp.responseText;
										//added by PrashantD for making synchronous XMLHttp request in mozilla. Same code runs in IE also
                                    //Commented By Usha Pandit On 28.04.2020 For same resource was getting saved twice
                                    //if (ProjectType == 2)
									//save_onClick_2();
									//else if (ProjectType==3)
									//SaveRows_OnClick_2();
                                    //End Of Commented By Usha Pandit On 28.04.2020 For same resource was getting saved twice
								}
								
							}
							//Mrugaja
				//delete req;
				return true;
			} 
			
			function Process() 
			{
				
		  		// wait until the request is done 
				if (g_objXHttp.readyState == 4) 
				{
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if(brw=="IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							if(brw=="FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
						
						
							strResult=g_objXHttp.responseText;
                        
							//added by PrashantD for making synchronous XMLHttp request in mozilla. Same code runs in IE also
							if (ProjectType==2)
							save_onClick_2();
							else if (ProjectType==3)
							SaveRows_OnClick_2();
					}
				}
			}
				
				
	         //******************************************************************************************
             ///End of Added by ManishK  on 7th Feb 06 for whizibleSem sp6 WFH customization
		     //******************************************************************************************
	
				
			function Save_OnClick()
			{

				debugger;
				var flag,objTxt;
				var dblWorkHrs,EmpID;
				var dblMinWork=0.0;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtBalenceWork');
				var dblBalenceWork;
				dblBalenceWork = Number(objTxt.value);
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtMinHrs');
				dblMinWork = objTxt.value;
			
	        // added By purvaj on 7 Nov 2008 for Whiziblesem 8.0
		    // validation currentwork should be greater than actual work hours filled
		    objActualWork = GetObjectReference('frmTaskAssignment','hid_txtActualWork');
                objCurrentWork = GetObjectReference('frmTaskAssignment', 'txtWorkHrs');
                //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
			    objtxthidCurrentWork = GetObjectReference('frmPM_AssignTaskResources','txthidWorkHrs');
			    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

                 //Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change
                 if(objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                objtxthidCurrentWork.value = objCurrentWork.value;
                 //End of Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change
                
		    //Added by TruptiK on 20-May-09
                if ('<%=m_strSubMode%>' == '<%=CONST_SUBMODE_EDIT%>')
                //End of Addition by TruptiK
                {
                    //Commented And Added By Usha Pandit On 29.04.2020 For work hour field validation           
                    ////Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    ////if (objCurrentWork!=null && objActualWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
                    //if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(objtxthidCurrentWork.value) < parseFloat(objActualWork.value))
                    ////End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    //{
                    //    alert('Current Work hours should be greater than Actual work hours (' + objActualWork.value + ').');
                    //    objCurrentWork.focus();
                    //    objCurrentWork.select();
                    //    return;
                    //}                    

                    var curWorkHrs = objtxthidCurrentWork.value;
                    var data = JSON.stringify({ HMHours: curWorkHrs });
                    var dectxthidCurrentWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", data, false);
                    var curActualHrs = objActualWork.value;
                    data = JSON.stringify({ DecimalHours: curActualHrs });
                    var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", data, false);
                    if (objtxthidCurrentWork != null && objActualWork != null && parseFloat(dectxthidCurrentWork.d) < parseFloat(objActualWork.value)) {
                        alert('Current Work hours should be greater than Actual work hours ( ' + HMActualHrs.d + ' ).');
                        objCurrentWork.focus();
                        objCurrentWork.select();
                        return;
                    }
                    //End Of Added By Usha Pandit On 29.04.2020 For work hour field validation           
                }
		    // End addition purvaj
		 //Added by TruptiK on 24-Mar-09
		    var objActualStartDate=GetObjectReference('frmTaskAssignment','hid_txtActualStartdate');
		    var objcurrentdate=GetObjectReference('frmTaskAssignment','txtStartDate');
		    var objcurrentenddate=GetObjectReference('frmTaskAssignment','txtEndDate');
		    
		    dtActualStartDate=getDate(objActualStartDate.value);
		    dtcurrentdate=getDate(objcurrentdate.value); 
		    dtcurrentenddate=getDate(objcurrentenddate.value); 
		  
		    if('<%=m_strSubMode%>'=='<%=CONST_SUBMODE_EDIT%>')
			{		
		    if (objcurrentdate!='' && objActualStartDate.value!='' && dtcurrentdate>dtActualStartDate)
		    {
		        alert('Current Start Date should not be greater than Actual Start Date ('+objActualStartDate.value +').');
				return;
		    }
		    if (objcurrentenddate!=null && objActualStartDate.value!='' && dtcurrentenddate < dtActualStartDate)
		    {
		        alert('Current End Date should not be less than Actual Start Date ('+objActualStartDate.value +').');
				return;
		    }
		    }
		    //End of addition by TruptiK
		
				if('<%=m_strSubMode%>'!='<%=CONST_SUBMODE_EDIT%>')
				{		
					objTxt = GetObjectReference('frmPM_AssignTaskResources','cboResource');	
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_RESOURCE_EMPTY")%>",true);
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					if(flag==true)
						return;
					EmpID = objTxt.value;
									
					objTxt = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeIDList');
					var EmpIDList;
					EmpIDList = new String(objTxt.value);
					if(EmpIDList.indexOf(',' + EmpID + ',',0)>= 0)
					{
						//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_EMPLOYEE_ALREADYSELECTED")%>","&#39;","'"));
						//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						objTxt = GetObjectReference('frmPM_AssignTaskResources','cboResource');	
						objTxt.focus();
						return;
					}  
				}
								
                objTxt = GetObjectReference('frmPM_AssignTaskResources', 'txtWorkHrs');
                  var objVal=objTxt.value;
                 //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                objtxthidCurrentWork = GetObjectReference('frmPM_AssignTaskResources', 'txthidWorkHrs');

               
                 //Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change
                 if(objtxthidCurrentWork != null && objtxthidCurrentWork != undefined)
                objtxthidCurrentWork.value = objCurrentWork.value;
                 //End of Added by Usha Pandit on 01-Apr-2019 Purpose::Whizible 2 Work field change


                //Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                if (objTxt.value == "") {
                    alert("Work (hrs) can not be left blank.");
                    objTxt.focus();
                    return false;
                }

                var objVal = objTxt.value;
                var objnewVal = objTxt.value;

                objTxt.value = objTxt.value.replace(":", ".");
                var isdigit = isNumeric(objTxt.value);
                objTxt.value = objVal;
                if (isdigit == false) {
                    alert("Please Enter only positive numeric value For Work(Hrs) in hh:mm format.");
                    objTxt.focus();
                    return false;
                }
                //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                //Commented And Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                //if(objTxt.value.indexOf(':')==-1){
                //    alert("Please enter Work (hrs) in hh:mm format.");
                //    return false;
                //}
                if (objTxt.value.indexOf(':') == -1) {
                    objTxt.value = objnewVal + ':00';
                    objnewVal = objTxt.value;
                }
                //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                if (objTxt.value.indexOf('.') >= 0) {
                    alert('Please enter Review Work in (HH:MM) format.');
                    //Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    objTxt.value = objVal;
                    objTxt.focus();
                    //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    return false;
                }
                objTxt.value = objTxt.value.replace(/:/g, ".");
                var precision = objTxt.value.split(".")[1];                
               
			    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                if (precision.length > 2) {
                    alert("Please enter minutes in two decimal and less than 60.");                   
                    //Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    objTxt.focus();
                    //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    return false;
                }
			    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                if (precision > 60 || precision < 0) {
                    alert('Please enter minutes between (0-59) range');
                    objTxt.value = objTxt.value.split('.').join(':');
                    //Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    objTxt.focus();
                    //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    return false;
                }

                if (precision == 60) {
                    objTxt.value = (objTxt.value.split(".")[0] - 0) + 1;
                }
                var pattern = /^\d+(\.\d{1,2})?$/;
                if (pattern.test(objTxt.value)) {
                }
                else {
                    alert("Please enter Work (hrs) in hh:mm format.");
                    objTxt.value = objTxt.value.split('.').join(':');
                    //Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    objTxt.focus();
                    //End Of Added By Usha Pandit On 28.04.2020 Purpose::Whizible 2 Work field change
                    return false;
                }
			    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change

				//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)	
				flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_WORKHRS_EMPTY")%>",true);
				//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                if (flag == true) {
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
			        objTxt.value = objTxt.value.split('.').join(':');
			        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    return;
                }
				//objTxt = GetObjectReference('frmPM_AssignTaskResources','txtWorkHrs');
				//modified by HarshK on 05/09/05 for sp4 issueid 136	
				flag = disallowNonNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_WORKHRS_NAN")%>",true);
				//End modified by HarshK on 05/09/05 for sp4 issueid 136
                if (flag == true) {
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
			        objTxt.value = objTxt.value.split('.').join(':');
			        //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    return;
                }
				dblWorkHrs = Number(objTxt.value);
				//Modified By VarunA on 20-July-2009 RequestID-21909
				//Purpose : To have work hours greater than zero.
				//if(dblWorkHrs <=0 )
				if(dblWorkHrs <0 )//End By VarunA on 20-July-2009 RequestID-21909
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_WORKHRS_INVALID")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136
                     //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
				    objTxt.value = objTxt.value.split('.').join(':');
				    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
					objTxt.focus();
					return;
				}
				
                //Added By VarunA on 20-July-2009 RequestID-21909
				//Purpose : To have work hours greater than zero.
				if(dblWorkHrs == 0 )
                {

                    alert("Please enter 'Work Hours' greater than zero.");
                     //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    objTxt.value = objTxt.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
					objTxt.focus();
					return;
				}
				//End By VarunA on 20-July-2009 RequestID-21909

                //Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box
                var curdata = JSON.stringify({ DecimalHours: dblBalenceWork });
                var HMBalenceWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", curdata, false);                
                var decBalenceWork = HMBalenceWork.d;
                decBalenceWork = decBalenceWork.replace(/:/g, ".");
                //End Of Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box

                //Commented And Added By Usha Pandit on 06.05.2020 For compairing work hours with balance work hours
                //if(dblWorkHrs > dblBalenceWork)
                //{
                if (dblWorkHrs > decBalenceWork) {
                    //End Of Added By Usha Pandit on 06.05.2020 For compairing work hours with balance work hours
                    //modified by HarshK on 05/09/05 for sp4 issueid 136
                    alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_WORKHRS_EXCEEDS")%>", "&#39;", "'"));
                    //End modified by HarshK on 05/09/05 for sp4 issueid 136
                    //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    objTxt.value = objTxt.value.split('.').join(':');
                    //End of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                    objTxt.focus();
                    return;
                }
				 
				 //Commented and Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
			    <%-- if((dblWorkHrs % dblMinWork)!=0)
			    {
			        //modified by HarshK on 05/09/05 for sp4 issueid 136 (single quote replaced by double quotes)
			        alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE1")%>","&#39;","'") + " " + dblMinWork + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE2")%>","&#39;","'") + " " + dblMinWork + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE3")%>","&#39;","'"));
                    //End modified by HarshK on 05/09/05 for sp4 issueid 136
                    objTxt.focus();
                    return;
                }--%>

			   
			   
			    var MinDAENtryDisplay = "";
			    var MinDAEntry = dblMinWork;
                if (MinDAEntry == 0.25) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:15"
                }
                else if (MinDAEntry == 0.50) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:30"
                }
                else if (MinDAEntry == 0.75) {
                    MinDAEntry = MinDAEntry
                    MinDAENtryDisplay = "00:45"
                }
               
                dblWorkHrs = objTxt.value;
                if("<%=m_RestrictByMinHours%>" == "True"){ 
                    if (MinDAEntry == 0.016) {
                    }
                    else
                    {
                        var minutes = dblWorkHrs.toString().split('.');
                        var p = minutes[0];
                        var dec = minutes[1];
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);
                       
                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) 
                        {
                            //alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE1")%>","&#39;","'") + " " + MinDAENtryDisplay + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE2")%>","&#39;","'") + " " + MinDAENtryDisplay + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE3")%>","&#39;","'"));
                            alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min" );
                            objTxt.value = objTxt.value.split('.').join(':');
                            objTxt.focus();
                            return;
                        }    
                    }
                }
			    //ENd of Commented and Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                
				  
                if (IsDateValid() == false) {
                    objTxt.value = objVal
                    return;
                }
		
		
			//******************************************************************************************		
		 ///Added by ManishK  on 8th Feb 06 for whizibleSem sp6 WFH customization
		 //******************************************************************************************
					
		var strUrl; 
		var strEmployeeList;
		objStartDate = GetObjectReference('frmTaskAssignment','txtStartDate');
		objEndDate=GetObjectReference('frmTaskAssignment','txtEndDate');
		objEmployeeID=GetObjectReference('frmTaskAssignment','cboResource');
		var empIdinEditMode = '<%=m_strResourceID%>';
				
		
		strEmployeeList='';
		if (objEmployeeID != null)
		{
			if(objEmployeeID)
			strEmployeeList=objEmployeeID.value + ':' + objStartDate.value + ':' + objEndDate.value + ';';
			
			
		}else{
			var strEmployeeID;
			if ("<%=Request.querystring("ResourceID")%>" != "" )
			{
				strEmployeeID="<%=Request.querystring("ResourceID")%>"
				strEmployeeList=strEmployeeID + ':' + objStartDate.value + ':' + objEndDate.value + ';';
			}
			else
			strEmployeeList=empIdinEditMode + ':' + objStartDate.value + ':' + objEndDate.value + ';';
		}
		
	
		
		var intCounter;
			
		strUrl = new String();
		
		//Modified By VidyaJ - For DSS IssueID - 2075
		var objTaskID;
		var objParentTaskID;
		objTaskID= GetObjectReference('frmTaskAssignment','txtTaskID');
		objParentTaskID=GetObjectReference('frmTaskAssignment','txtParentTaskID');

		<%' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 moved leave valiation to XMLHTTP.aspx %>
		//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
		//Added token parameter
        //strUrl = "PM_AssignTaskResources.aspx?ParentTaskID=2768&TaskID=2768&FromWhere=XMLHTTP&EmployeeIDs=" + encodeURIComponent(strEmployeeList); 
        strUrl = "../General/XMLHTTP.aspx?TagId=1038&PROJECT_SETTING=ACtivity&ParentTaskID=" + objParentTaskID.value + "&TaskID=" + objTaskID.value + "&FromWhere=XMLHTTP&EmployeeIDs=" + encodeURIComponent(strEmployeeList) + "&PkToken=<%=m_strToken%>"; 
		//End Modification
		<% 'End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 %>
        //PrashantD
        <% ' Added bY NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 regression Issue 11132 %>
     	if ("<%=FromTimesheet%>" =="CreateTask")
		{
			strUrl = strUrl + "&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>"; 
		}
		<% ' End Addition by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 regression Issue 11132%>
                ProjectType = 2;
                //Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format
                var oldobjTxt = objTxt.value;
                oldobjTxt = oldobjTxt.replace('.', ':');
                if (oldobjTxt.toString().indexOf(":") != -1) {
                    var chkhr = oldobjTxt.split(":")[0];
                    var chkmin = oldobjTxt.split(":")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        objTxt.value = chkhr + ":" + chkmin;
                    }
                    if (chkmin.length == 1) {
                        chkmin = chkmin + "0";
                        objTxt.value = chkhr + ":" + chkmin;
                    }
                }
                objTxt.value = objTxt.value.replace(/:/g, ".");                
                //End Of Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format
       if (strResult == "")
		generateRequest(strUrl);
	}
			
	//save_onClick_2() is Created by PrashantD
	//Purpose : To make XMLhttp synchronous in mozilla, all code in save_onClick_2() is from stmt of  if (generateRequest(strUrl)==true)
		function save_onClick_2()
		{

				if(strResult!=null)
				{
					if(strResult!='')
					{
						
								strResult=strResult.split("<=>");
								var intCount , Count;
								for(intCount=0;intCount<strResult.length;intCount++)
									{
										strLH=strResult[intCount];	
										strLH=strLH.split("<==>");
										for(Count=0;Count<strLH.length;Count++)
										{	
											if(strLH[Count]!='')
											{
											if(strLH[Count]!=' ')
												{
													if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
													{
														strResult=""; //added by PrashantD for Mozilla support. sync xmlhttp
														return;
													}
												}	
											}	
										}	
									}
								
						}
				}	
		//} this brace was of if stmt of "generateRequest(strUrl)==true" in Save_OnClick function.
		//******************************************************************************************
	 //End of Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box
	 //******************************************************************************************
	
						
				//Modified By VivekP on 3 Jun 2005	
				if ("<%=FromTimesheet%>"!="CreateTask")
                {
				//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
				//Added token parameter
				objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_SAVE%>&PkToken=<%=m_strToken%>";
				//End Modification
				}
				else
				objform.action = "PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_SAVE%>";
		    //End of Modification On 3 Jun 2005
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		    objform.submit();	
			
			}

			function IsDateValid()
            {
				var objTaskSDT, objTaskEDT, objWorkHrs;
				var objSDT,objEDT;
				var dtStartDate,dtEndDate;
				var dtTaskStartDate,dtTaskEndDate;
				
				objSDT = GetObjectReference('frmPM_AssignTaskResources','txtStartDate');
				//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				flag = disallowBlank(objSDT,"<%=MyBase.GetResourceString("MSG_STARTDATE_EMPTY")%>",true);
				//End modified by HarshK on 05/09/05 for sp4 issueid 136
				<%' Modified By nitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12045 added set foucs%>
				objWhizSDT = GetObjectReference('frmPM_AssignTaskResources','FFE29587WHIZ_txtStartDate');
				if(flag==true)
				{
					if(objWhizSDT != null )
					objWhizSDT.focus();
					return false;
				}					

				dtStartDate = getDate(objSDT.value);
				
				objEDT = GetObjectReference('frmPM_AssignTaskResources','txtEndDate');
				objWhizEDT = GetObjectReference('frmPM_AssignTaskResources','FFE29587WHIZ_txtEndDate');				
				//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				flag = disallowBlank(objEDT,"<%=MyBase.GetResourceString("MSG_ENDDATE_EMPTY")%>",true);
				//End modified by HarshK on 05/09/05 for sp4 issueid 136 
				if(flag==true)
				{
					if(objWhizEDT != null)
						objWhizEDT.focus(); 
					return false;
				}	
				<%' End Modification By nitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression Issue 12045 %>				
				dtEndDate = getDate(objEDT.value);
				
				//start date can not be > than end date
				if(DateDiff(dtEndDate,dtStartDate,"d")>0)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_STARTDATE_GREATER")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				//Commented by SandipL on 8 Dec 2005 -- No need to focus on DtControl as it is disabled	
					//objSDT.focus();
					//End commenting by SandipL
					return false;
				}
									
				objTaskSDT = GetObjectReference('frmPM_AssignTaskResources','txtTaskStartDate');
				objTaskEDT = GetObjectReference('frmPM_AssignTaskResources','txtTaskEndDate');
				objWorkHrs = GetObjectReference('frmPM_AssignTaskResources','txtWorkHrs');	
                 //Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
                objWorkHrs.value = objWorkHrs.value.replace(/:/g, ".");
                //ENd of Added By Aniruddh Gujar on 28-Feb-2019 Purpose::Whizible 2 Work field change
				dtTaskStartDate = getDate(objTaskSDT.value);
				dtTaskEndDate = getDate(objTaskEDT.value);
				//Start Date >= Task Start Date
				//Issue 15152 -Compare with Parent Task dates
				//Changed By SantoshK on 1st Feb 2005 
				if(DateDiff(dtStartDate,"<%=m_ParentTaskStartDate%>","d")>0)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                    //Commented & Added By dipali V On 7th July 2020 For Issue Id 25599
					<%--//alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TASKSTARTDATE_GREATER")%>","&#39;","'") + " : " + "<%=m_strParentTaskStartDate%>");--%>
                  alert(replaceSubstring("Please enter a &#39;start date&#39; greater than or equal to &#39;task start date&#39;","&#39;","'") + " : " + "<%=m_strParentTaskStartDate%>");
                    //End of Commented & Added By dipali V On 7th July 2020 For Issue Id 25599
                    //End modified by HarshK on 05/09/05 for sp4 issueid 136
					//Commented by SandipL on 8 Dec 2005 -- No need to focus on DtControl as it is disabled	
					//objSDT.focus();
					//End commenting by SandipL
					return false;
				}
				
				//End Date <= Task End Date
				if(DateDiff("<%=m_ParentTaskEndDate%>",dtEndDate,"d")>0)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TASKENDDATE_LESSER")%>","&#39;","'") + " : " + "<%=m_strParentTaskEndDate%>");
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					//Commented by SandipL on 8 Dec 2005 -- No need to focus on DtControl as it is disabled	
					//objEDT.focus();
					//End commenting by SandipL
					return false;		
				}
                
				/*Added By JayavantK, On-17-Aug-2004*/
				if(ValidateWork_And_Dates(dtStartDate, dtEndDate, objWorkHrs.value) == false)
					return false;
				/*End Addition*/
				/*Added by harshk on 01/08/2005 for whiziblesem Sp4 IssueID 120,121 */
				var dtTempSDate, dtTempEDate;
				var dtTempTaskSDate, dtTempTaskEDate;
				var strErrorMsg;
				objEmp = GetObjectReference('frmPM_AssignTaskResources','cboResource');	
                                
                if (intResourceValidation == 1)//on 06/10/2005
				{
					if (objEmp !=null )
					{	
						objResourceSDt = GetObjectReference('frmPM_AssignTaskResources','cboResourceStartDate');
						objResourceEDt = GetObjectReference('frmPM_AssignTaskResources','cboResourceEndDate');
						if(objResourceSDt !=null && objResourceEDt!=null)
						{
							dtTempTaskSDate = getDate(objSDT.value);
							dtTempTaskEDate = getDate(objEDT.value);
							
							dtTempSDate=getDate(objResourceSDt[objEmp.selectedIndex].text); 
							dtTempEDate=getDate(objResourceEDt[objEmp.selectedIndex].text);
							if(DateDiff(dtTempTaskSDate,dtTempSDate,"d") > 0)
							{
								//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>";
								//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = replaceSubstring(strErrorMsg, '<=>', objEmp[objEmp.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objEmp.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objEmp.selectedIndex].text);
								alert(strErrorMsg);
								return false;
							}
							if(DateDiff(dtTempEDate,dtTempTaskEDate,"d")>0)
							{
								//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>";
								//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = replaceSubstring(strErrorMsg, '<=>', objEmp[objEmp.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objEmp.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objEmp.selectedIndex].text);
								alert(strErrorMsg);
								return false;
							}				
						}
					}
					else 
					{	
						objResourceSDt = GetObjectReference('frmPM_AssignTaskResources','cboResourceStartDate');
						objResourceEDt = GetObjectReference('frmPM_AssignTaskResources','cboResourceEndDate');
						if(objResourceSDt !=null && objResourceEDt!=null)
						{	
							
							dtTempTaskSDate = getDate(objSDT.value);
							dtTempTaskEDate = getDate(objEDT.value);
							
							dtTempSDate=getDate(objResourceSDt[objResourceSDt.selectedIndex].text); 
							dtTempEDate=getDate(objResourceEDt[objResourceEDt.selectedIndex].text);
							
							if(DateDiff(dtTempTaskSDate,dtTempSDate,"d") > 0)
							{
								//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>";
								//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = replaceSubstring(strErrorMsg, '(<=>)', '');
								strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objResourceSDt.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objResourceSDt.selectedIndex].text);
								alert(strErrorMsg);
								return false;
							}
							if(DateDiff(dtTempEDate,dtTempTaskEDate,"d")>0)
							{
								//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>";
								//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
								strErrorMsg = replaceSubstring(strErrorMsg, '(<=>)', '');
								strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objResourceSDt.selectedIndex].text);
								strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objResourceSDt.selectedIndex].text);
								alert(strErrorMsg);
								return false;
							}				
						}
					}
				}
				var strParentTaskSDt,strParentTaskEDt;
				var dtParentTaskSDt, dtParentTaskEDt,dtCSDt,dtCEDt;
				var strMsg2;
				strParentTaskSDt = '<%=m_strParentTaskStartDate%>';
				strParentTaskEDt = '<%=m_strParentTaskEndDate%>';
				if(strParentTaskSDt != '' && strParentTaskEDt != '')
				{
					dtParentTaskSDt = getDate(strParentTaskSDt);
					dtParentTaskEDt = getDate(strParentTaskEDt);
					dtCSDt = getDate(objSDT.value);
					dtCEDt = getDate(objEDT.value);
					if(DateDiff(dtCSDt,dtParentTaskSDt,"d") > 0)
					{
						<%' Modified By NitinVS on 21 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11367 %>
						//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						//<%--strMsg2 = replaceSubstring("<%=MyBase.GetResourceString("MSG_TASKSTARTDATE_GREATER")%>" ,"&#39;", "'" );--%>
                        strMsg2 = replaceSubstring("Please enter a &#39;start date&#39; greater than or equal to &#39;task start date&#39;", "&#39;", "'");
						//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						<%' End Modified By NitinVS on 21 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11367 %>
						
						strMsg2 = strMsg2 + ':' + strParentTaskSDt
						alert(strMsg2);
						return false;
					}
					if(DateDiff(dtParentTaskEDt,dtCEDt,"d")>0)
					{
						//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						strMsg2 = replaceSubstring("<%=MyBase.GetResourceString("MSG_TASKENDDATE_LESSER")%>","&#39;","'");
						//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						strMsg2 = strMsg2 + ':' + strParentTaskEDt;
						alert(strMsg2);
						return false;
					}	
				}
				/*end HarshK for whiziblesem Sp4 IssueID 120,121 */
				return true;			
			} 

			function SendMail_OnClick(TID,EmpID)
			{
				window.open('../General/SendEmail.aspx?MessageID=202&TaskID=' + TID + '&EmployeeID=' + EmpID,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');
			}
			function AddNew_OnClick()
			{
				var objTxt;
				var intRecordCount,i,dblMinHrs;
				intRecordCount=0;
				dblMinHrs=0.0;
								
				objTaskSDt = GetObjectReference('frmPM_AssignTaskResources','txtTaskStartDate');
				objTaskEDt = GetObjectReference('frmPM_AssignTaskResources','txtTaskEndDate');
				objTaskHrs = GetObjectReference('frmPM_AssignTaskResources','txtTaskHrs');
				objBalenceWork = GetObjectReference('frmPM_AssignTaskResources','txtBalenceWork');	
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtMinHrs');
				dblMinHrs = objTxt.value;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtRowCount');
				intRecordCount = objTxt.value;
								
				//validate each row data
				for(i=1;i<=intRecordCount;i++)
				{
					if(ValidateControls(i)==false)
						return;
						
					objTxt = GetObjectReference('frmPM_AssignTaskResources','txtLCE' + i);
					dblLCE = objTxt.value;
					
				    //Commented by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				    <%--if((dblLCE % dblMinHrs)!=0)
					{
						//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE1")%>","&#39;","'") + " " + dblMinHrs + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE2")%>","&#39;","'") + " " + dblMinHrs + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE3")%>","&#39;","'"));
						//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						objTxt.focus();
						return;
					}	--%>	
				    //End of Commented by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				}
				//Modified By VivekP On 3 jun 2005
				if ("<%=FromTimesheet%>"!="CreateTask")
				{
				//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
				//Added token parameter
				objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_ADDNEW%>&PkToken=<%=m_strToken%>";
				//End Modification
				}
				else
				objform.action = "PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_ADDNEW%>";
			    //End Of modification On 3 jun 2005
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
			    objform.submit();
			}
			function ResourceLoading_OnClick(RowID)
			{
				var objTxt;
				var empId;
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeID' + RowID);
				empId = objTxt.value;
				if(empId=='' || empId ==null)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_RESOURCE_EMPTY")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					objTxt = GetObjectReference('frmPM_AssignTaskResources','cboEmployee' + RowID);
					objTxt.focus();
					return;
				}
				
				//call the resource loading page
				window.open("PM_ResourceHistory.aspx?EmployeeID=" + empId, "", "resizable=yes,menubar=no,scrollbars=yes,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=800,height=500");
			}
			function Employee_OnChnage(RowID)
			{
				var objTxt,objCbo;
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeID' + RowID);
				objCbo = GetObjectReference('frmPM_AssignTaskResources','cboEmployee' + RowID);
				
				objTxt.value = objCbo.value;
				//modified by vivekP On 3 jun 2005
				if ("<%=FromTimesheet%>"!="CreateTask")
				{
				//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
				//Added token parameter
				objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&PkToken=<%=m_strToken%>";
				//End Modification
				}
				else
				objform.action = "PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>";
			    //End if modification On 3 Jun 2005

			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.submit();
			}
			function SubTask_OnChnage(RowID)
			{
				var objCbo,objTxt;
				
				objCbo = GetObjectReference('frmPM_AssignTaskResources','cboSubTaskType' + RowID);
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtSubTaskType' + RowID);
				objTxt.value = objCbo.options[objCbo.selectedIndex].text;
				
				//objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>";
				//objform.submit();
			}
			function Cancel_OnClick()
			{
				var objChk,objTxt;
				var intCnt;
				var blnSelected;
				blnSelected=false;
				intCnt=0;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtRowCount');
				intCnt=objTxt.value;
				
				var i;
				for(i=1;i<=intCnt;i++)
				{
					objChk = GetObjectReference('frmPM_AssignTaskResources','chkCancel' + i);
					if(objChk.checked==true)
					{
						blnSelected=true;
						break;
					}
				}
				
				if(blnSelected==false)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TASK_NOTSELECTED")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					return;
				}
				//Modified By VivekP On 4 Jun 2005
				if ("<%=FromTimesheet%>"!="CreateTask")
				{
				//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
		//Added token parameter
				objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_CANCEL%>&PkToken=<%=m_strToken%>";
				//End Modification
				}
				else
				objform.action = "PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_CANCEL%>";
			    //End Of Modification On 4 Jun 2005

			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016

				objform.submit();
			}
			//*********************************************************************
			//Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box 
			var strEmployeeList;
			strEmployeeList=''
						
			function GetEmployeeList(intRow)
			{
				var objEmployeeID,objSDt,objEDt;
											
				objSDt = GetObjectReference('frmPM_AssignTaskResources','txtStartDate' + intRow);
				objEDt = GetObjectReference('frmPM_AssignTaskResources','txtEndDate' + intRow);
				objEmployeeID = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeID' + intRow);
				strEmployeeList+=objEmployeeID.value+':'+objSDt.value+':'+objEDt.value +';';
							
			}
						
			////******************************************************************
			//End of Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box
			
					
		
			function SaveRows_OnClick()
			{
				//Check if the start and end dates have been specified for those activities for 
				//which the LCE is specified
			    //debugger;
				var intCount,intRow, intRecordCount, intActivityID, intResourceCnt
				var strControlName, strResourceName
				var strActivityName
				var strActivities,strEmployeeIDList;
				var dblTotalLCE, dblAllocatedLCE,dblMinHrs,dblLCE,dblTaskHrs,dblBalanceWork,dblInactiveActualHrs;
				var objTxt;
				intRecordCount=0;
				dblMinHrs=0.0;
				dblLCE=0.0;
				dblTotalLCE=0.0;
				dblTaskHrs=0.0;
				dblBalanceWork=0;	
				dblInactiveActualHrs=0;
				
				objTaskSDt = GetObjectReference('frmPM_AssignTaskResources','txtTaskStartDate');
				objTaskEDt = GetObjectReference('frmPM_AssignTaskResources','txtTaskEndDate');
				objTaskHrs = GetObjectReference('frmPM_AssignTaskResources','txtTaskWork');
				objInactiveActualHrs = GetObjectReference('frmPM_AssignTaskResources','txtInActiveActualHrs');
				dblTaskHrs = Number(objTaskHrs.value);
				objBalenceWork = GetObjectReference('frmPM_AssignTaskResources','txtBalenceWork');				
				dblBalanceWork=Number(objBalenceWork.value);
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtMinHrs');
				dblMinHrs = objTxt.value;
				dblInactiveActualHrs=Number(objInactiveActualHrs.value);
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtRowCount');
				intRecordCount = objTxt.value;
				strEmployeeList='';
				
				//validate each row data
				for(i=1;i<=intRecordCount;i++)
				{
				
					if(ValidateControls(i)==false)
						return;
		//******************************************************************************************		
		 ///Added by ManishK  on 8th Feb 06 for whizibleSem sp6 WFH customization
		 //******************************************************************************************
		 
					GetEmployeeList(i)
					
				//******************************************************************************************
				//End of Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box
				//******************************************************************************************
						
						
					objTxt = GetObjectReference('frmPM_AssignTaskResources','txtLCE' + i);
					dblLCE = Number(objTxt.value);
					dblTotalLCE = dblTotalLCE + dblLCE;
				    
				    //Commented by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				    <%--if((dblLCE % dblMinHrs)!=0)
					{
						//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE1")%>","&#39;","'") + " " + dblMinHrs + " " + replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE2")%>","&#39;","'") + " " + dblMinHrs + " " +  replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_INMULTIPLEOF_MINLCE3")%>","&#39;","'"));
						//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
						objTxt.focus();
						return;
					}--%>	
				    objTxt.value = objTxt.value.replace('.', ':');
				    //End of Commented by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				}
				
				//added by harshada d for whiziblesem sp 7.5 on 30 Aug 2006
				//Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25598
				//if((dblTotalLCE+dblInactiveActualHrs)> dblTaskHrs)
                if ((dblTotalLCE) > dblTaskHrs)
                 //End of Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25598
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TOTALLCE_GREATER_TASKLCE")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					return;
				}
				//end of addition by harshada d
				
			//******************************************************************************************
			//Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box
			//******************************************************************************************
		
					var strUrl; 
			

					var intCounter;
					var strLH;
					strLH='';
					strUrl = new String();
					//Modified By VidyaJ - For DSS IssueID - 2075
					var objTaskID;
					var objParentTaskID;
					objTaskID= GetObjectReference('frmTaskAssignment','txtTaskID');
					objParentTaskID=GetObjectReference('frmTaskAssignment','txtParentTaskID');
					
					<%' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 moved leave valiation to XMLHTTP.aspx %>
					//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
					//Added token parameter
					strUrl = "../General/XMLHTTP.aspx?TagId=1038&PROJECT_SETTING=ACtivity&ParentTaskID=" + objParentTaskID.value + "&TaskID=" + objTaskID.value + "&FromWhere=XMLHTTP&EmployeeIDs=" + encodeURIComponent(strEmployeeList) + "&PkToken=<%=m_strToken%>";					
					//End Modification
					<%'End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 %>					
				//	strUrl = "PM_AssignTaskResources.aspx?ParentTaskID=2768&TaskID=2768&FromWhere=XMLHTTP&EmployeeIDs=" + encodeURIComponent(strEmployeeList); 
					//strUrl="PM_AssignTaskResources.aspx?ParentTaskID=2768&TaskID=2768"
					//PrashantD
				<% ' Added by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 regression Issue 11132  %>
     			if ("<%=FromTimesheet%>" =="CreateTask")
				{
					strUrl = strUrl + "&FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>"; 
				}
				<% ' End Addition by NitinVS on 3 Apr 2007 for WhizibleSEM SP 8 regression Issue 11132%>					
					ProjectType=3;
					if (strResult == "")
						generateRequest(strUrl);
					
       				
					
			}
			
			
			function SaveRows_OnClick_2()
			{
				var intCount,intRow, intRecordCount, intActivityID, intResourceCnt
				var strControlName, strResourceName
				var strActivityName
				// Integrated by ArchanaN on 26 Apr 2007
			 	//Added By JyotiG
					//Start_JG_9242_09-Jan-2007
					var strNewResult;
					//End_JG_9242_09-Jan-2007
				 // Integration Ends

				var strActivities,strEmployeeIDList;
				var dblTotalLCE, dblAllocatedLCE,dblMinHrs,dblLCE,dblTaskHrs,dblBalanceWork,dblInactiveActualHrs;
					if(strResult!=null)
						{
							if(strResult!=' ')
							{
							// Integrated by ArchanaN on 26 Apr 2007
		 					//Commented and Modified By JyotiG
								//Start_JG_9242_09-Jan-2007						
								//strResult=strResult.split("<=>");
								strNewResult=strResult.split("<=>");
								strResult="";
								//End_JG_9242_09-Jan-2007						
								var intCount, Count;
								//Commented and Modified By JyotiG
								//Start_JG_9242_09-Jan-2007
								//for(intCount=0;intCount<strNewResult.length;intCount++)
								for(intCount=0;intCount<strNewResult.length;intCount++)
								{
									
									//strLH=strResult[intCount];	
									strLH=strNewResult[intCount];	
									//End_JG_9242_09-Jan-2007 
							 // Integration Ends

									
									strLH=strLH.split("<==>");
									for(Count=0;Count<strLH.length;Count++)
									{	
										if(strLH[Count]!='')
										{
											if(strLH[Count]!=' ')
											{
												if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
												{
													strResult=""; //added by PrashantD for Mozilla support. sync xmlhttp
													// Integrated by ArchanaN on 26 Apr 2007
													 	//Added By JyotiG
													//Start_JG_9242_09-Jan-2007
													strNewResult="";
													//End_JG_9242_09-Jan-2007
													
													 // Integration Ends

													return;
												}
											}	
										}	
									}	
								}
													
							}
						}
					//} PrashantD
				
		
			//******************************************************************************************
			//End of Added By ManishK  on 8th Feb 2006 For WhizibleSem SP6 WFH and Leave Customization for confirm box
			//******************************************************************************************
			
				if((dblTotalLCE+dblInactiveActualHrs)> dblTaskHrs)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_TOTALLCE_GREATER_TASKLCE")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					return;
				}
				
				//check if same resource and its activity is selected
				var arrResourceID;
				var j,strActivityID,intActivityID;
				//added By purvaj on 19 nov 2008 for whiziblesem 8.0
							//Planned hours can be reduced less than actual hours filled
				var objactualHours,objCurrentWork,intAlertFlag;
				intAlertFlag = 0
				//end addition purvaj
				
				// Integrated by ArchanaN on 26 Apr 2007
				//Adde by JyotiG
				//Start_JG_9242_05-Jan-2007
				var	objTxtRowCountVal = GetObjectReference('frmPM_AssignTaskResources','txtRowCount');
				intRecordCount = objTxtRowCountVal.value;
				//End_JG_9242_05-Jan-2007
			
				 // Integration Ends

				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeIDList');
				strEmployeeIDList = new String(objTxt.value);
				arrResourceID = strEmployeeIDList.split(",");
				strActivityID = new String();
				//j=new Number();
				for(i=0;i<arrResourceID.length;i++)
				{
					strActivityID='';
					if(arrResourceID[i]!='')
					{
						for(j=1;j<=intRecordCount;j++)
						{
							//validation applies to newly added tasks only
							var strObj = 'txtTaskID' + j.toString();
							 
							objTxt = GetObjectReference('frmPM_AssignTaskResources','txtTaskID' + j);
							//added By purvaj on 19 nov 2008 for whiziblesem 8.0
							//Planned hours can be reduced less than actual hours filled
							objactualHours = GetObjectReference('frmPM_AssignTaskResources','txtHidActualHours' + j);
							objCurrentWork = GetObjectReference('frmTaskAssignment','txtLCE'+j);
		                    if (objCurrentWork!=null && objactualHours!=null && parseFloat(objCurrentWork.value) < parseFloat(objactualHours.value))
		                    {
		                        alert('Current Work hours should be greater than Actual work hours ('+objactualHours.value +').');
		                        objCurrentWork.focus();
		                        objCurrentWork.select();
		                        intAlertFlag= 1;
		                        return;
		                    }
		                    // End addition purvaj
		                     //Added by TruptiK on 25 Mar 09
		                    objCurrentStartDt=GetObjectReference('frmPM_AssignTaskResources','txtStartDate' + j);
		                    objActualStartDt=GetObjectReference('frmPM_AssignTaskResources','txtHidActualStartDate' + j);
		                    var objcurrentenddate=GetObjectReference('frmTaskAssignment','txtEndDate'+ j);
		                   
		                    if (objActualStartDt != null)
		                    {
								dtActualStartDate=getDate(objActualStartDt.value);
								dtcurrentdate=getDate(objCurrentStartDt.value);
								 dtcurrentenddate=getDate(objcurrentenddate.value);  
								if (objActualStartDt.value!='' && dtActualStartDate < dtcurrentdate)
								{
									
									alert('Current start date should not be greater than Actual Start Date ('+objActualStartDt.value +').');
		                   			intAlertFlag= 1;
									return;
								}
								
								if (objcurrentenddate!=null && objActualStartDt.value!='' && dtcurrentenddate < dtActualStartDate)
							{
								alert('Current End Date should not be less than Actual Start Date ('+objActualStartDt.value +').');
								return;
							}
		
							}
		                    //end of addotion by TruptiK*/
		    
							//end addition purvaj
							//objTxt = GetObjectReference('frmPM_AssignTaskResources','txtTaskID');
							if(objTxt.value=='' || objTxt.value==null)
							{
								objTxt = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeID' + j);
								if(objTxt.value != '' && objTxt.value != null)
								{
									if(objTxt.value == arrResourceID[i])
									{
										objCbo = GetObjectReference('frmPM_AssignTaskResources','cboSubTaskType' + j);
										intActivityID = objCbo.value;
										if(strActivityID.indexOf("," + intActivityID,0)<0)
											strActivityID = strActivityID + "," + intActivityID;
										else
										{
											var strActivityName;
											var strResourceName;
											objTxt = GetObjectReference('frmPM_AssignTaskResources','txtSubTaskType' + j);
											strActivityName = objTxt.value;
											objTxt = GetObjectReference('frmPM_AssignTaskResources','cboEmployee' + j);
											strResourceName = objTxt.options[objTxt.selectedIndex].text;
											//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
											alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_ACTIVITY_REASSIGN1")%>","&#39;","'") + " [" + strActivityName + "] " + replaceSubstring("<%=MyBase.GetResourceString("MSG_ACTIVITY_REASSIGN2")%>","&#39;","'") + " [" + strResourceName + "]");
											//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
											return; 
										}
									}
								}
							}
						}
					}
				}
				//Modified by VivekP On 3 Jun 2005
				if ("<%=FromTimesheet%>"!="CreateTask")
				{
				//Modified by MrugajaB on 22nd Sept 2006 for Whiziblesem SP7 Issue ID.6197
				//Added token parameter
				objform.action = "PM_AssignTaskResources.aspx?Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_SAVE%>&PkToken=<%=m_strToken%>";
				//End Modification
				}
				else
				{
				   if (intAlertFlag == 0)
				        objform.action = "PM_AssignTaskResources.aspx?FromTimesheet=CreateTask&ProjectID=<%=TempProjectId%>&Mode=<%=m_strMode%>&ResourceID=<%=m_strResourceID%>&Action=<%=CONST_ACTION_SAVE%>";
				}
			    //End Of Modification On 3 jun 2005
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
				objform.submit();
				}

            var SelectedAllWorkHours = 0;
            var Total = 0;
			function ValidateControls(intRow)
            {
				var objTxt,objSDt,objEDt;
				/*Added by harshk 0n 29/07/2005 for whiziblesem Sp4 IssueID 120,121 */
				var objResourceSDt,objResourceEDt,objEmp  
				var cmbEmpIndex;
				/*End Added by harshk 0n 29/07/2005 for whiziblesem Sp4 IssueID 120,121 */
				var flag;
				var dblLCE,dblBalenceLCE,dtSDt,dtEDt;
				var dblAllocatedLCE,dblCurrentLCE,dblTaskHrs;
				dblAllocatedLCE=0.0;
				dblLCE=0.0;
				dblBalenceLCE=0.0;
				dblCurrentLCE=0.0;
				dblTaskHrs=0.0;
				
				//employee must be selected
				objTxt = GetObjectReference('frmPM_AssignTaskResources','cboEmployee' + intRow);
				if(objTxt!=null)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_RESOURCE_EMPTY")%>",true);
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					if(flag==true)
						return false;
				}
				
				//task must be selected
				objTxt = GetObjectReference('frmPM_AssignTaskResources','cboSubTaskType' + intRow);
				if(objTxt!=null)
				{
					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_TASK_EMPTY")%>",true);
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					if(flag==true)
						return false;
				}
				
			    objTxt = GetObjectReference('frmPM_AssignTaskResources','txtLCE' + intRow);
			    //Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
			    var objTxtOld = objTxt.value;
			    //End of Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
			    //modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				flag = disallowBlank(objTxt,"<%=MyBase.GetResourceString("MSG_LCE_EMPTY")%>",true);
				//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				if(flag==true)
					return false;
				//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				
			    //Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
				if (objTxt.value.indexOf('.') >= 0) {
				    objTxt.value = objTxtOld;
				    alert('Please enter planned work in H:M format.');
           
				    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				    setFocus(objTxt);
				    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
				    return false;
            
           
				}
				if (objTxt.value.indexOf(":") != -1) {
				    objTxt.value = objTxt.value.replace(':', '.');
				}
			    //End of Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
				
				flag = disallowNonNumeric(objTxt,"<%=MyBase.GetResourceString("MSG_WORKHRS_NAN")%>",true);
				
			    //End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				if(flag==true)
					return false;
				
				//Commented and Added By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
				//dblLCE = Number(objTxt.value);
				dblLCE= objTxt.value;
			    //End of Commented By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change

				if(dblLCE <= 0)
				{
				    //Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
				    objTxt.value = objTxtOld;
				    //End of Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change

					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_LESS_THAN_ZERO")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					objTxt.focus();
					return false;	
				}
			  
			    //Added by Usha Pandit on 20.03.2019 for set focus on HH:MM validation alert
			    objTxt.value = objTxt.value.replace('.', ':');
			    //End of script for disallow special characters

			    if (objTxt.value.indexOf(':') == -1) {
			        //alert('Please enter Review Work in (HH:MM) format.');
			        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        //setFocus(objtxtETC);
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        //return false;

			        objTxt.value = objTxt.value + ':00';
			      
			    }

			    var WorkHour = objTxt.value; 
			    WorkHour = WorkHour.trim(); //Removing unnecessary spaces
			    var idxColon = WorkHour.indexOf(':');
			    var hrs = WorkHour.substring(0, idxColon);
			    var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

			    if (mins.length == 1 && mins > 5) {
			        mins = mins + "0";
			    }
			    if (mins == "") {
			        //mins = "00";
			        objTxt.value=objTxtOld;
			        alert('Please enter planned work in H:M format.');                  
			        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        setFocus(objTxt);
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        return false;
			    }
			   			  
			    //Validating Hours
			    if (hrs <= 0 && mins <= 0) {
			        objTxt.value=objTxtOld;
			        alert('Hours should not be less than or equal to zero (0).');
			        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        setFocus(objTxt);
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        return false;
			    }			   
			   
			    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
			    if (mins.length > 2) {
			        alert("Please enter minutes in two decimal and less than 60.");                   
			        setFocus(objTxt);
			        return false;
			    }
			    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                 //Validating Minutes range (0 - 59)
			    if (mins > 59 || mins < 0) {
			        objTxt.value=objTxtOld;
			        alert('Please enter minutes between (0-59) range');
			        //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        setFocus(objTxt);
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			        return false;
                }

			    var MinDAENtryDisplay = "";
			    var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
			    //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
			    if (MinDAEntry == 0.25) {
			        MinDAEntry = MinDAEntry
			        MinDAENtryDisplay = "00:15"
			    }
			    else if (MinDAEntry == 0.50) {
			        MinDAEntry = MinDAEntry
			        MinDAENtryDisplay = "00:30"
			    }
			    else if (MinDAEntry == 0.75) {
			        MinDAEntry = MinDAEntry
			        MinDAENtryDisplay = "00:45"
			    }
			   
			    if ("<%=m_RestrictByMinHours%>" == 'True') {
			        if (MinDAEntry == 0.016) {
			        }
			        else {
			            var minutes = objTxt.value.split(':');
			            var p = minutes[0];
			            var dec = minutes[1];
			            if (dec == undefined) { dec = 0; }
			            d = (dec - 0) / 60 + (p - 0);

			            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
			                //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")");
			                alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
			                setFocus(objTxt);
			                objTxt.value = objTxt.value.split('.').join(':');
			                return false;
			            }
			        }
			    }

			    objTxt.value = objTxt.value.replace(':', '.');
			    //End of Added by Usha Pandit on 20.03.2019 for set focus on HH:MM validation alert

				//objTxt = GetObjectReference('frmPM_AssignTaskResources','txtBalenceLCE' + intRow);
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtBalenceWork');
				dblBalenceLCE = Number(objTxt.value);
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtTaskWork');
				dblTaskHrs = objTxt.value;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtAllocatedLCE' + intRow);
				dblAllocatedLCE = objTxt.value;
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtCurrentLCE' + intRow);
				dblCurrentLCE = objTxt.value;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtTaskID' + intRow);
				<%--/*if(objTxt.value != '' && objTxt.value != null && objTxt.value != '0')
				{
					if((((dblAllocatedLCE-dblTaskHrs)-dblCurrentLCE)+ dblLCE)>dblAllocatedLCE)
					{
						alert('<%=MyBase.GetResourceString("MSG_LCE_GREATERTHAN_BALENCE")%>');
						objTxt = GetObjectReference('frmPM_AssignTaskResources','txtLCE' + intRow);
						objTxt.focus();
						return false;
					}
				}
				else */--%>
               //Added By Dipali V On 7th July 2020
                if (SelectedAllWorkHours != "" && intRow > 1) {
                    Total =   parseInt(SelectedAllWorkHours) +  parseInt(dblLCE);
                    SelectedAllWorkHours = Total;
                    //sum += parseInt(nums[i]);
                } else {
                    //Total = dblLCE;
                    SelectedAllWorkHours = dblLCE;
                }

                //End of Added By Dipali V On 7th July 2020
               //alert(Total);
				if(Total > dblTaskHrs)//Added By Dipali V On 7th July 2020
				{
				   

					//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					alert(replaceSubstring("<%=MyBase.GetResourceString("MSG_LCE_GREATERTHAN_BALENCE")%>","&#39;","'"));
					//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
					objTxt = GetObjectReference('frmPM_AssignTaskResources','txtLCE' + intRow);
				    //Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
					
					objTxt.value = objTxt.value.replace('.', ':');
				    //End of Added by By Usha Pandit on 20-March-2019 Purpose::Whizible 2 Work field change
					objTxt.focus();
					return false;
				}
				<%' Modified By NitinVS on 13 Apr 2007 for WhizibleSEM SP 8 Regression Issues need to set focus on Editable date control %>
				objSDt = GetObjectReference('frmPM_AssignTaskResources','txtStartDate' + intRow);
				objEDt = GetObjectReference('frmPM_AssignTaskResources','txtEndDate' + intRow);
				objWhizSDt = GetObjectReference('frmPM_AssignTaskResources','FFE29587WHIZ_txtStartDate' + intRow);
				objWhizEDt = GetObjectReference('frmPM_AssignTaskResources','FFE29587WHIZ_txtEndDate' + intRow);
				
				//modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				flag = disallowBlank(objSDt,"<%=MyBase.GetResourceString("MSG_STARTDATE_EMPTY")%>",true);
				
				if(flag==true)
				{
					if (objWhizSDt != null)
						objWhizSDt.focus();
					return false;
				}	
				
				flag = disallowBlank(objEDt,"<%=MyBase.GetResourceString("MSG_ENDDATE_EMPTY")%>",true);
				
				if(flag==true)
				{
					if (objWhizEDt != null)
						objWhizEDt.focus();					
					return false;
				}	
				<% ' End Modification  By NitinVS on 13 Apr 2007 for WhizibleSEM SP 8 Regression Issues need to set focus on Editable date control  %>
				flag = disallowDate1LessThanDate2(objEDt,objSDt,"<%=MyBase.GetResourceString("MSG_STARTDATE_GREATER")%>",true);

                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
				//if(flag==true)
				//	return false;

                if (flag == true) {                    
                    var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);                    
                    objTxtLCE.value = objTxtLCE.value.replace(".", ":");                    
                    return false;
                }
                //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion

				//Added & Commented By Dipali V On 7th July 2020 For Alert changes
				<%--flag = disallowDate1LessThanDate2(objSDt,objTaskSDt,"<%=MyBase.GetResourceString("MSG_TASKSTARTDATE_GREATER")%>",true);--%>
                flag = disallowDate1LessThanDate2(objSDt, objTaskSDt, "Please enter a start date greater than or equal to task start date", true);
                //End of Added & Commented By Dipali V On 7th July 2020 For Alert changes

                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                //if(flag==true)
				//	return false;

                if (flag == true) {
                    var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                    objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                    return false;
                }
	            //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion

				flag = disallowDate1LessThanDate2(objTaskEDt,objEDt,"<%=MyBase.GetResourceString("MSG_TASKENDDATE_LESSER")%>",true);

                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                //if(flag==true)
				//	return false;

                if (flag == true) {
                    var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                    objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                    return false;
                }
                //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion

				//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
				/*Added By JayavantK, On-17-Aug-2004*/

                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                //if(ValidateWork_And_Dates(getDate(objSDt.value), getDate(objEDt.value), dblLCE) == false)
				//	return false;

                if (ValidateWork_And_Dates(getDate(objSDt.value), getDate(objEDt.value), dblLCE) == false) {
                    var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                    objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                    return false;
                }
                //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                
				/*End Addition*/
				/*Added by harshk on 29/07/2005 for whiziblesem Sp4 IssueID 120,121 */
				if(intResourceValidation == 1)//on 06/10/2005
				{
					objResourceSDt = GetObjectReference('frmPM_AssignTaskResources','cboEmployeeStartDate');
					objResourceEDt = GetObjectReference('frmPM_AssignTaskResources','cboEmployeeEndDate');
					objEmp = GetObjectReference('frmPM_AssignTaskResources','cboEmployee' + intRow);		
					if (objEmp !=null)
                    {
						var dtTempSDate, dtTempEDate;
						var dtTempTaskSDate, dtTempTaskEDate;
						var strErrorMsg;
						dtTempTaskSDate = getDate(objSDt.value);
						dtTempTaskEDate = getDate(objEDt.value);
						
						dtTempSDate=getDate(objResourceSDt[objEmp.selectedIndex].text); 
						dtTempEDate=getDate(objResourceEDt[objEmp.selectedIndex].text);
                        if (DateDiff(dtTempTaskSDate, dtTempSDate, "d") > 0) {
                            //modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                            strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>";
                            strErrorMsg = replaceSubstring(strErrorMsg, '<=>', objEmp[objEmp.selectedIndex].text);
                            strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objEmp.selectedIndex].text);
                            strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objEmp.selectedIndex].text);
                            alert(strErrorMsg);
                            //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                            var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                            objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                            //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                            return false;
                        }
						if(DateDiff(dtTempEDate,dtTempTaskEDate,"d")>0)
						{
							strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>";
							//End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
							strErrorMsg = replaceSubstring(strErrorMsg, '<=>', objEmp[objEmp.selectedIndex].text);
							strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objEmp.selectedIndex].text);
							strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objEmp.selectedIndex].text);
                            alert(strErrorMsg);
                            //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                            var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                            objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                            //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
							return false;
						}				
					}
					else 
                    {
						var dtTempSDate, dtTempEDate, objtxtEmpID;
						var dtTempTaskSDate, dtTempTaskEDate;
						var strErrorMsg,intIndexD;
						dtTempTaskSDate = getDate(objSDt.value);
						dtTempTaskEDate = getDate(objEDt.value);
						objtxtEmpID = GetObjectReference('frmPM_AssignTaskResources','txtEmployeeID' + intRow);
						if (objtxtEmpID !=null)
						{
							for(intIndexD=0;intIndexD< objResourceSDt.length;intIndexD++)
							{	
								if(objResourceSDt[intIndexD].value == objtxtEmpID.value)
								{
									objResourceSDt.selectedIndex = intIndexD;
									objResourceEDt.selectedIndex = intIndexD;
								}
							}
							dtTempSDate=getDate(objResourceSDt[objResourceSDt.selectedIndex].text); 
							dtTempEDate=getDate(objResourceEDt[objResourceEDt.selectedIndex].text);
                            if (DateDiff(dtTempTaskSDate, dtTempSDate, "d") > 0) {
                                //modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                                strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_ON_PROJECT")%>";
                                strErrorMsg = replaceSubstring(strErrorMsg, '<=>', GetObjectReference('frmPM_AssignTaskResources', 'hdnEmployeeName' + intRow).value);
                                strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objResourceSDt.selectedIndex].text);
                                strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objResourceEDt.selectedIndex].text);
                                alert(strErrorMsg);
                                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                                var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                                objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                                //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                                return false;
                            }
                            if (DateDiff(dtTempEDate, dtTempTaskEDate, "d") > 0) {
                                strErrorMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_ON_PROJECT")%>";
                                //End modified by HarshK on 05/09/05 for sp4 issueid 136 (single quotes replaced by double quotes)
                                strErrorMsg = replaceSubstring(strErrorMsg, '<=>', GetObjectReference('frmPM_AssignTaskResources', 'hdnEmployeeName' + intRow).value);
                                strErrorMsg = replaceSubstring(strErrorMsg, '<==>', objResourceSDt[objResourceSDt.selectedIndex].text);
                                strErrorMsg = replaceSubstring(strErrorMsg, '<===>', objResourceEDt[objResourceEDt.selectedIndex].text);
                                alert(strErrorMsg);
                                //Commented And Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                                var objTxtLCE = GetObjectReference('frmPM_AssignTaskResources', 'txtLCE' + intRow);
                                objTxtLCE.value = objTxtLCE.value.replace(".", ":");
                                //End Of Added By Usha Pandit On 05.08.2020 to prevent H:M hours to decimal conversion
                                return false;
                            }
						}				
					}
				}	
				
				/*End  Added by harshk on 29/07/2005 for whiziblesem Sp4 IssueID 120,121 */
				return true;
			}
			
			function Data_OnChange1(intRow)
			{
				var objTxt;
				var flag;
				
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtDataChanged' + intRow);
				if(objTxt != null)
				{
					objTxt.value = "1";
				}	
			//Commented and modified by MonikaI on 10th Oct 2006 IssueID : 6932
				//flag=DateControl_StandardOnblur('frmPM_AssignTaskResources','txtStartDate'+intRow,'DD-MM-YYYY','Invalid Date format or Invalid Date.');
				//flag= DateControl_StandardOnblur('frmPM_AssignTaskResources','txtEndDate'+intRow,'DD-MM-YYYY','Invalid Date format or Invalid Date.');
				flag=DateControl_StandardOnblur('frmPM_AssignTaskResources','txtStartDate'+intRow,'<%=strDateFormat%>','Invalid Date format or Invalid Date.');
				flag= DateControl_StandardOnblur('frmPM_AssignTaskResources','txtEndDate'+intRow,'<%=strDateFormat%>','Invalid Date format or Invalid Date.');
			//End by MonikaI
			}
			function Data_OnChange(intRow)
			{
				var objTxt;
				objTxt = GetObjectReference('frmPM_AssignTaskResources','txtDataChanged' + intRow);
				if(objTxt != null)
				{
					objTxt.value = "1";
				}				
			}
/* Added By JayavantK, On 17-Aug-2004*/
			function ValidateWork_And_Dates(dtCurrentStartDate, dtCurrentEndDate, dblTotalWork)
            {
                //Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box
                var curdblTotalWork = dblTotalWork.replace('.', ':');
                if (curdblTotalWork.toString().indexOf(":") != -1) {
                    var chkhr = curdblTotalWork.split(":")[0];
                    var chkmin = curdblTotalWork.split(":")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        curdblTotalWork = chkhr + ":" + chkmin;
                    }
                    if (chkmin.length == 1) {
                        chkmin = chkmin + "0";
                        curdblTotalWork = chkhr + ":" + chkmin;
                    }
                }
                
			    var curdata = JSON.stringify({ HMHours: curdblTotalWork });
                var decdblTotalWork = AJAXCallWithResult("PM_TaskAssignment.aspx/getDecimalHours", curdata, false);
                dblTotalWork = decdblTotalWork.d;
                //End Of Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box                
                
				var intHolidays, bitHoliday, dtHoliday, strHolidayList;
				var intCount, dtCurrentDate, strMsg, intCnt;
				var intCompanyWeekDays, dblTotalDuration;
				var intCompanyHrsPerDay, dblAvgHoursPerDay;
							
				intCompanyWeekDays = <%=m_lngWeekDays%>;
				intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
				intHolidays=0;
				bitHoliday = false;
				if(strHolidays != "")
				{		
					strMsg="<%=MyBase.GetResourceString("MSG_THEDATES")%>\n";
					strHolidayList = strHolidays.split(',');
					for(intCount=0; intCount < strHolidayList.length-1 ; intCount++)
					{
						intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
						for(intCnt=0; intCnt <= intDays; intCnt++)
						{
							dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
							// If the holiday does not fall in the week end, then...
							if(DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		
							{
							
							/*  Modified By	: NitinVS on 3 May 2005 for WhizibleSEM SP3 
								IssueID		: 18256 
											  In Assigned Tasks for the Resource for a particular Date, the last years holiday is also being considered.
								Modifications : Added match for Year of the Current Date and Holiday Date in if Condition			  
							*/
								
								dtHoliday = getDate(strHolidayList[intCount]);	
								if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getFullYear() == dtHoliday.getFullYear() ))
								{
							/* End Modification By NitinVS on 3 May 2005 for WhizibleSEM SP3 IssueID = 18256 */
							
							
									bitHoliday=true;
									//Need the month string
									strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
									
                                    //Commented And Added By Chakshuta H on 19th-Nov-2015
							//strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
                              strMsg = strMsg + "-" + dtCurrentDate.getFullYear() + "\n";
                            //End Of Commented And Added By Chakshuta H on 19th-Nov-2015
									intHolidays = intHolidays + 1;
								}
							}
						}
					}
				}
				if(bitHoliday == true)			
				{
					if(! confirm(strMsg + "<%=MyBase.GetResourceString("MSG_DATE_HOLIDAY")%>"))
					{
						return false;
					}
				}		
				for(intCnt=0; intCnt <= DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d"); intCnt++)
				{
					dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
					if(DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		
						intHolidays = intHolidays + 1;
				}
				
				
				
				dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
				
				//Modified By VidyaJ on 3rd Feb 2004
				//For IssueID - 15739
				//dblTotalDuration = dblTotalDuration - intHolidays;
				if((Number(dblTotalDuration) - Number(intHolidays)) != 0)
					dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
				else
				{
				
					if(!confirm("<%=MyBase.GetResourceString("MSG_DAYS_ARE_HOLIDAYS")%>"))
						return false;			
					dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
					dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
				}		

				if(dblAvgHoursPerDay > 24)
				{
					alert("<%=MyBase.GetResourceString("WORK_PER_DAY_MORE_THAN_24")%>");
					return false;
				}
				else if(dblAvgHoursPerDay > intCompanyHrsPerDay)
				{
                    strMsg = "<%=MyBase.GetResourceString("WORK_PER_DAY_EXEEDS_MAX")%>";
                    //Commented And Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box
					//strMsg = replaceSubstring(strMsg,"<=>",dblAvgHoursPerDay.toFixed(2));
                    curdata = JSON.stringify({ DecimalHours: dblAvgHoursPerDay.toFixed(2) });
                    var HMActualHrs = AJAXCallWithResult("PM_TaskAssignment.aspx/getHMHours", curdata, false);                                       
                    strMsg = replaceSubstring(strMsg, "<=>", HMActualHrs.d);
                    //End Of Added By Usha Pandit on 06.05.2020 For showing work hours in H:M format in Confirm box
					strMsg = replaceSubstring(strMsg,"<==>",intCompanyHrsPerDay.toString());
					if(!confirm(strMsg))
					{
						return false;
					}
				}
			}
	<%' Added BY nitinVson 23 Mar 2007 for WhizibleSEM SP 8 regression issue 12059 %>			
	function ShowSchedule_OnClick()
	{
		var strEmployeeList, intCtr;
		
		objCurrentStartDate = GetObjectReference('frmTaskAssignment','txtStartDate');
		objCurrentEndDate=GetObjectReference('frmTaskAssignment','txtEndDate');

		var empIdinEditMode = '<%=m_strResourceID%>';
		
		objEmployee = GetObjectReference('frmTaskAssignment','cboResource');
		if (objEmployee != null )
		{
			if(disallowBlank(objEmployee, "Please select the resource", true))
			return;		
		}	
				

		if(disallowBlank(objCurrentStartDate, "<%=MyBase.GetResourceString("MSG_STARTDATE_EMPTY")%>", true))
			return;
		
		if(disallowBlank(objCurrentEndDate, "<%=MyBase.GetResourceString("MSG_ENDDATE_EMPTY")%>", true))
			return;
		
		if(disallowDate1LessThanDate2(objCurrentEndDate, objCurrentStartDate, "<%=MyBase.GetResourceString("MSG_STARTDATE_GREATER")%>", true))
			return;
		
		if (objEmployee != null)	
		{
			strEmployeeList = objEmployee.value;
		}
		else
		{
			strEmployeeList = empIdinEditMode; 
		}

		window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + strEmployeeList + "&FromDate=" + objCurrentStartDate.value + "&ToDate=" + objCurrentEndDate.value, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=650,height=450");

	}			
	</SCRIPT>
	</body>
</HTML>
<%'XMLHTTP_GetLeaves%>

