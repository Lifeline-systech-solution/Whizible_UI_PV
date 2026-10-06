<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_GetTaskDetails.aspx.vb" Inherits="PbNIT.PM_PM_GetTaskDetails" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
  <HEAD>
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


		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
  </HEAD>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmTaskDetails" name="frmTaskDetails" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objDivMain = GetObjectReference('frmTaskDetails','DivMain');
			var objForm;
			objForm = GetFormReference('frmTaskDetails');
            
            <%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
            
			function window_onload()		
			{
				var intDivHeight;
				var intPhaseTaskID;
				var objTaskNotes;

				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				//if (intDivHeight < 100)
					//intDivHeight = 100;
					//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		    }
			    //Commented and added by Yogesh J on 11/12/2015
			    //objDivMain.style.height = intDivHeight;
			objDivMain.style.height = intDivHeight + 'px';
				intPhaseTaskID = "<%=m_lngTaskID%>";
				objTaskNotes = GetParentObjectReference("frmTaskSelection", "txtPhaseTaskNotes" + intPhaseTaskID);

				if (typeof(objTaskNotes) == "object" && objTaskNotes != null)
					frmTaskDetails.txtTaskNotes.value = objTaskNotes.value;	
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }

				if (intDivHeight < 100)
					intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight + 'px';
			}

			function Save_OnClick()
			{
				var objTaskType;
				var objOpenerObject;
				var objThisObject;
				var intPhaseTaskID = "0";
                 
				if(ValidateControls()==false)
					return;
				
				intPhaseTaskID = "<%=m_lngTaskID%>";

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtPhaseTaskNotes" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "txtTaskNotes");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtPriority" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboPriority");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtEstimationTypeID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboProjectEstimationTypeID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtPhaseID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboPhaseID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtModuleID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboModuleID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtSubProjectID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboSubProjectID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtMilestoneID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboMilestoneID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtChangeRequestID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboChangeRequestID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				objOpenerObject = GetParentObjectReference("frmTaskSelection", "txtFeatureID" + intPhaseTaskID);
				objThisObject = GetObjectReference("frmTaskDetails", "cboProjectFeatureID");
				UpdateValuesInParent(objOpenerObject, objThisObject);

				window.close();
			}

			function UpdateValuesInParent(objOpenerObject, objThisObject)
			{
				if (typeof(objThisObject) == "object" && objThisObject != null)
				{
					if (typeof(objOpenerObject) == "object" && objOpenerObject != null)
						objOpenerObject.value = objThisObject.value;
				}
			}

			function Close_OnClick()
			{
				window.close();
			}

    /************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
			var brw = isIE();
			function ValidateTask_Baseline(url)
			{ 		
			// TO SEE IF WE ARE RUNNING IN IE 
						strNavigator = navigator.appName;
						strNavigator = strNavigator.toUpperCase();
			    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
						if (brw == "IE")
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
								xmlDoc.async = false;
								if (brw == "FF")//added by Nilesh g on 10/12/2015
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
				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if (brw == "IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async = false;
							if (brw == "FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
							strResult=g_objXHttp.responseText;		
							
				    }
				}
			}	     
	    //************************End Addition By VijayD 25 May 2009**************************//
	        var strResult="";
			function ValidateControls()
			{
			
	        /************************ Added By VijayD 25 May 2009********************************
                    Purpose: To validate Task assignment for baseline
             ************************ ***********************************************************/
             var objModuleID     = GetObjectReference("frmTaskDetails", "cboModuleID");
             var objSubProjectID = GetObjectReference("frmTaskDetails", "cboSubProjectID");
             var objMilestoneID  = GetObjectReference("frmTaskDetails", "cboMilestoneID");
             
		     var strURL;
		     var fmt = 'MMM dd,yyyy';
			    
			    strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId=0&StartDate=&EndDate=&DeliverableID=&ModuleID="+objModuleID.value+"&SubProjectID="+objSubProjectID.value+"&MilestoneID="+objMilestoneID.value+"&Work=";
			    ValidateTask_Baseline(strUrl);
    		    
    		    if(strResult!=null && strResult!="")
		        {
		          alert(strResult);
                  return false;		    
                }       	       
	       	       
	    //************************End Addition By VijayD 25 May 2009**************************//
			
				if(DynamicValidation() == false)
					return false;
				else
					return true;
			}

			function DynamicValidation()
			{
				var objControl;	
				
				<%=m_sbValidationScript%>
				return true;
			}
		</script>
	</body>
</HTML>
