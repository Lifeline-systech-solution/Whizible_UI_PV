<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_WBSGetTaskDetails.aspx.vb" Inherits="PbNIT.PM_WBSGetTaskDetails" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    <%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
  <HEAD>
		
      <%--    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.9">
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
   <script src="../../responsive/responsive.js"></script>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.9">
 <%--   <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
   <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

     <script src="../../Whizible2.0-new/dist/js/custom.js"></script>
 <%--   <script src="../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
      /*//Added By Dipali V On 14th Nov 2019 For hide Help Link*/ 
        .responsive_clsTRMenu li:nth-child(3) {

            display:none

        }

          .footer_responsive_clsTRMenu li:nth-child(3) {

            display:none

        }
  /*//Added By Dipali V On 14th Nov 2019 For hide Help Link*/ 
/*New css style added by pradip on 13-11-2019*/
        
        .clsTextbox {
    display: block;
    width: auto;
    height: 34px;
    padding: 4px 8px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
    -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
        .clsTable td { padding:4px;
        }
        TR.clsTRSectionHeader {BACKGROUND-COLOR: #e7edf0;
        }
.clsTRSectionHeader td {
    padding-top: 10px; font-weight:bold;
    text-align: center;
}
#TasksTable tr > td {
    border: 1px solid #ddd;
    vertical-align: top;
}
SELECT.clsComboBox{ background-image:none;height: 30px;}
table.clsTable:last-child td, table.clsTable:last-child td em {
    font-size: 12px!important;
}
#TasksTable tr > td select {
    margin: 0 0 10px!important;
}
tr.clsTRPageCaption {
    background: #4263c1;
    font-size: 14px;
    padding: 0px 0; color:#fff;
}
tr.clsTRPageCaption td {
    padding: 10px 4px;
}
#DivMain{ padding:15px;}
.notebox{ background:#e7edf0;}

.clsTable td lebel {
    font-weight: 700;
}
TR.clsTRMenu{BACKGROUND: #e7edf0; height:34px;}
TR.clsTRMenu li{ margin:0 0 0 5px;border: none;}
TR.clsTRMenu a.Menu {
    font-weight: 700;
    padding: 4px 14px;
    border: 1px solid #1359ac!important;
    color: #1359ac;
    border-radius: 4px;
    text-shadow: none;
    margin: 0 0px; transition:0.4s ease-in-out 0s;
}
    TR.clsTRMenu li:first-child a.Menu {background: #fbb03b; border: 1px solid #fbb03b!important;
    color: #fff;
    }
        TR.clsTRMenu li:first-child a.Menu:hover {background: #e29214!important; border: 1px solid #e29214!important;
    color: #fff;
        }
/*New css style added by pradip on 13-11-2019*/
 .alertify-notifier {
            z-index: 99999 !important;
            font-size:12px !important;
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
               // debugger;
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
                //debugger; 
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
                var chackval = 0;
				var objControl;	
		        //debugger;
                //Added By Dipali V On 14th Nov 2019 For Validation 
                var objHdnFields = document.getElementsByClassName('clsMandatoryFields');
                var i = 0;
               // alert($("#cboPriority").val());
                if ($("#cboPriority").val() == "") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Priority Should not be blank");
                    $("#cboPriority").focus()
                    chackval = 1;
                }

                if (chackval != 1) {
                    for (i = 0; i < objHdnFields.length; i++) {
                        if (chackval != 1) {
                            var object = document.getElementById(objHdnFields[i].id);
                            //alert(object.getAttribute('ismandatory'));
                            if (object.getAttribute('ismandatory') == "1" || object.getAttribute('ismandatory') == "True") {
                                if (object.value == "") {
                                    var Caption = object.id.replace("cbo", " ");
                                    Caption  = Caption.replace("ID", " ");
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error(Caption + " Should not be blank");
                                    object.focus()
                                    chackval = 1;
                                }
                            }
                        }
                    }
                }
            if (chackval == 1) {
                return false;
            }
            else {
                return true;
            }
				  //End of Added By Dipali V On 14th Nov 2019 For Validation 
			<%--	<%=m_sbValidationScript%>--%>
				//return true;
           
			}
		</script>
	</body>
</HTML>
