<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_CreateEmployeeWiseAlerts.aspx.vb" Inherits="PbNIT.PM_CreateEmployeeWiseAlerts" %>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Select Alerts")%>
    
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


	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmSelectAlerts" method="post" runat="server">
						 
									<%WritePage()%>
							 
		</form>
		<script language="javascript">
		var objPageDiv=GetObjectReference('frmSelectAlerts','PageDiv');
		var objform=GetFormReference('frmSelectAlerts');
		
		 var objcboIssueType1=GetObjectReference('frmSelectAlerts','cboIssueType1');
         var objcboIssueType2=GetObjectReference('frmSelectAlerts','cboIssueType2');
         var objcboIssueType3=GetObjectReference('frmSelectAlerts','cboIssueType3');
         var objcboReviewType=GetObjectReference('frmSelectAlerts','cboReviewType');
		 //Commented by SuchitraP on 5-Nov-2008
		 //var objtxtAlertName=GetObjectReference('frmSelectAlerts','txtAlertName');			
		 //End by SuchitraP
		 
		 <%' Added By SonalD on 13th Jan 2009 %>
	     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
             disableRightClick();
         <%End If%>
         <%' Added By SonalD on 13th Jan 2009 %>
		 
		function window_onload()
		{		
		    //Commented by SuchitraP on 5-Nov-2008	
		    ////Added by sonalD on 18th Sept 2208
		    //objtxtAlertName.focus();
		    ////End of Addition 
		    //End by SuchitraP
		    
			var intDivHeight ;
			var intDivHeightRisk;
			if (objPageDiv !=null) {
			intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
			if (intDivHeight < 100)	intDivHeight = 100;
			objPageDiv.style.height = intDivHeight;	}
			
			var intDivHeight ;
		    var intDivHeightRisk;
		    
		    if (navigator.appName == 'Microsoft Internet Explorer'){
		    intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 42;
		    }
		    else{
		    intDivHeight = window.innerHeight - objPageDiv.offsetTop - 42;
		    }
		    if (intDivHeight < 100)
		        intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    objPageDiv.style.height = intDivHeight + 'px';			
		}
			
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objPageDiv !=null) 
			{
				intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 30;
				if (intDivHeight < 100)	intDivHeight = 100;
				objPageDiv.style.height = intDivHeight;	
			}
			
			var intDivHeight ;
            var intDivHeightRisk;
            if (navigator.appName == 'Microsoft Internet Explorer'){
            intDivHeight = document.body.offsetHeight - objPageDiv.offsetTop - 42;
            }
            else{
            intDivHeight = window.innerHeight - 42;
            }
            if (intDivHeight < 100)
	            intDivHeight = 100;
            		
		    //Commented and added by Yogesh J on 11/12/2015
            objPageDiv.style.height = intDivHeight + 'px';

			 
		}			
		function Save_OnClick()
		{			    
		    
		    var objhidEntityID=GetObjectReference('frmSelectAlerts','hidEntityDetailIDs').value;
		    var arrhidEntityID=objhidEntityID.split(",");
		    var objSendMail;
		    var objSMS; 
		    //Commented and addition by SuchitraP on 5-Nov-2008	
		    ////Added By SonalD on 18th Sept 2008
		    //if (disallowBlank(objtxtAlertName,'Alert Name should not be blank !',true)) return false;
		    ////End of addition 
		    var arrAlertEntityID;
		    //End by SuchitraP
		    
		    for(var cnt=0;cnt<arrhidEntityID.length-1;cnt++)
		    {
		        arrAlertEntityID=arrhidEntityID[cnt].split("|");
		        
		        for(var i=0;i<arrAlertEntityID.length-1;i++)
		        {
		            //debugger;
		            objSendMail = GetObjectReference('frmSelectAlerts', 'chkSendMail' + arrAlertEntityID[0]);
		            //objSMS = GetObjectReference('frmSelectAlerts', 'chkSMS' + arrAlertEntityID[0]);
		            objFrequency = GetObjectReference('frmSelectAlerts','cboFrequency'+arrAlertEntityID[0]);
    		        
		            if(GetObjectReference('frmSelectAlerts','chkEntityDetailID'+arrAlertEntityID[0]).checked==true)
		            {
                        //Commented and Added by Dhanashri S on 1 Mar 2016 
		                //if (objSendMail.checked != true && objSMS.checked != true)
		                if (objSendMail.checked != true)
                        //End of Comment and Addition by Dhanashri S on 1 Mar 2016
		                {
		                    alert('Please select send Mail or send SMS');
		                    return;
		                }
		                if(GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]).value=='')
		                {		            
		                    alert('Duration cannot be left blank..');
    		                
		                    GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]).focus();
		                    return;
		                }
    		        
		                if(disallowNonNumeric(GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]),"Please enter a numeric value"))
		                {
		                    return false;
		                }
    		            
		                if(disallowNegativeNumeric(GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]),"Please enter a positive numeric value"))
		                {
		                    return false;
		                }
    		            
        		       
		                if(GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]).value==0)
		                {		            
		                    alert('Duration cannot be zero.');
		                    GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]).focus();
		                    return;
		                }
		                
		               //Addition by SuchitraP on 2-Dec-2008 for IssueID:23258
		               //Purpose:For overdue,delayed,due,open issue,change request etc duration need not be decimal value.
		                if(arrAlertEntityID[0]!=2&&arrAlertEntityID[0]!=3&&arrAlertEntityID[0]!=6&&arrAlertEntityID[0]!=7&&arrAlertEntityID[0]!=10&&arrAlertEntityID[0]!=11&&arrAlertEntityID[0]!=14&&arrAlertEntityID[0]!=15)
		                {	
		                    if (disallowNegativeInteger(GetObjectReference('frmSelectAlerts','txt'+arrAlertEntityID[0]),"Please enter numeric value for this field.") == true) {return false;}	            
		                }
		                //End by SuchitraP on 2-Dec-2008
		                	                
		                if(objFrequency.value == '')
		                {
		                    alert('Frequency cannot be left blank.');		                
		                    GetObjectReference('frmSelectAlerts','cboFrequency'+arrAlertEntityID[0]).focus();
		                    return;
		                }
		            }
		        }
		         
		    }
		    
		    if(GetObjectReference('frmSelectAlerts','chkEntityDetailID17').checked==true)
		    {
	            if((GetObjectReference('frmSelectAlerts','cboIssueType1').value=='') && (GetObjectReference('frmSelectAlerts','cboIssueType2').value=='') && (GetObjectReference('frmSelectAlerts','cboIssueType3').value==''))
                {
                    alert('Issue Type cannot be left blank..');
                    GetObjectReference('frmSelectAlerts','cboIssueType1').focus();
                    return;
                }
     
            }
            
            var objcboIssueType1 = GetObjectReference('frmSelectAlerts','cboIssueType1');
            var objcboIssueType2 = GetObjectReference('frmSelectAlerts','cboIssueType2');
            var objcboIssueType3 = GetObjectReference('frmSelectAlerts','cboIssueType3');
		    //Addition by SuchitraP on 2-Dec-2008 for IssueID:23258
		    //Purpose:Same issue type should not be selected for all the three combos
		    if(GetObjectReference('frmSelectAlerts','chkEntityDetailID17').checked==true)
		    {
		        //if(GetObjectReference('frmSelectAlerts','cboIssueType1').value!=''&&GetObjectReference('frmSelectAlerts','cboIssueType2').value!=''&&GetObjectReference('frmSelectAlerts','cboIssueType3').value!='')
		        //if(objcboIssueType1.value!='' && )
		        //{
		            if(objcboIssueType1.value==objcboIssueType2.value && objcboIssueType2.value!='')
		            {
		                alert('Issue type already selected.');
		                GetObjectReference('frmSelectAlerts','cboIssueType2').focus();
		                return;
		            }
		            else if(objcboIssueType1.value==objcboIssueType3.value && objcboIssueType1.value!='')
		            {
		    	        alert('Issue type already selected.');
		                objcboIssueType3.focus();
		                return;
		            }
		            else if(objcboIssueType2.value==objcboIssueType3.value && objcboIssueType3.value!='')
		            {
                        alert('Issue type already selected.');
		                objcboIssueType3.focus();
		                return; 
		            }
		        //}
		    }
		    //End by SuchitraP on 2-Dec-2008 
		                
		   
            
            		    
		    objform.action="../PM/PM_CreateEmployeeWiseAlerts.aspx?action=SAVE";
		    objform.submit();		    
		}
		
		function SaveandAdd_OnClick()
		{
		    //Commented by SuchitraP on 5-Nov-2008	
		    ////Added By SonalD on 18th Sept 2008
		    //if (disallowBlank(objtxtAlertName,'Alert Name should not be blank !',true)) return false;
		    ////End of addition 
		    //End by SuchitraP
		    Save_OnClick();
		    objform.action="../PM/PM_CreateEmployeeWiseAlerts.aspx?action=SAVEADD";
		    objform.submit();
		}
		
		//Added AlertEntityID by SuchitraP on 5-Nov-2008
		function ProjectSelection_OnClick(AlertEntityID)
		{
		    var EmployeeAlertID = GetObjectReference('frmSelectAlerts','hidEmployeeAlertID').value;
		    //Added AlertEntityID by SuchitraP on 5-Nov-2008
		    //Commented and added by Nilesh g on 29-Jan-2016 to generate token
		    //window.open ("../PM/PM_EntityAlerts.aspx?AlertEntityID="+AlertEntityID+"&EmployeeAlertID=" + EmployeeAlertID , "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=600,height=460");
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'PM_CreateEmployeeWiseAlerts.aspx/GenrateURLToken_RequestShow_TaskType',
		        data: JSON.stringify({ AlertEntityID: AlertEntityID, EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	           window.open("../PM/PM_EntityAlerts.aspx?AlertEntityID=" + AlertEntityID + "&PKToken=" + Result.d + "&EmployeeAlertID=" + EmployeeAlertID, "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 450) / 2 + ",width=600,height=460");
	        },
	        error: function () {
	            alert("Error")
	        }
             });
		    
		}
			function Back_OnClick()
        {
            window.location.href="../General/CommonList.aspx?MasterTagId=3939"; 
        }
        
        function EntityDetail_OnClick(e)
        {  
           var stralertID = e.value;
           var arrEntityDetail=stralertID.split('|');
                   
           if(e.value=='17|5')
           {
               
               if(e.checked==true)
               {
                   objcboIssueType1.disabled=false; 
                   objcboIssueType2.disabled=false;
                   objcboIssueType3.disabled=false;
               }
               else
               {
                   objcboIssueType1.value='';
                   objcboIssueType2.value='';
                   objcboIssueType3.value='';
                   objcboIssueType1.disabled=true; 
                   objcboIssueType2.disabled=true;
                   objcboIssueType3.disabled=true;
               } 
           }
           
           if(e.value==25)
           {
                if(e.checked==true)
                    objcboReviewType.disabled=false;
                else
                {
                    objcboReviewType.value='';
                    objcboReviewType.disabled=true;
                }
           }
           
           for(j=0;j<arrEntityDetail.length-1;j++)
           {
               if(GetObjectReference('frmSelectAlerts','chkEntityDetailID'+arrEntityDetail[0]).checked==true)
               {
                    GetObjectReference('frmSelectAlerts','txt'+arrEntityDetail[0]).disabled=false;
                    GetObjectReference('frmSelectAlerts','txt'+arrEntityDetail[0]).focus();
                    GetObjectReference('frmSelectAlerts','chkSendMail'+arrEntityDetail[0]).checked = true;
                    //GetObjectReference('frmSelectAlerts','chkSMS'+arrEntityDetail[0]).checked = true;
                    GetObjectReference('frmSelectAlerts','chkSendMail'+arrEntityDetail[0]).disabled=false;
                    //GetObjectReference('frmSelectAlerts','chkSMS'+arrEntityDetail[0]).disabled=false;
                    GetObjectReference('frmSelectAlerts','cboFrequency'+arrEntityDetail[0]).disabled=false;
               }
               else
               {
                    //GetObjectReference('frmSelectAlerts','txt'+e.value).value='';
                    GetObjectReference('frmSelectAlerts','txt'+arrEntityDetail[0]).disabled=true;
                    GetObjectReference('frmSelectAlerts','chkSendMail'+arrEntityDetail[0]).checked = false;
                    //GetObjectReference('frmSelectAlerts','chkSMS'+arrEntityDetail[0]).checked = false;
                    GetObjectReference('frmSelectAlerts','chkSendMail'+arrEntityDetail[0]).disabled=true;
                    //GetObjectReference('frmSelectAlerts','chkSMS'+arrEntityDetail[0]).disabled=true;
                    GetObjectReference('frmSelectAlerts','cboFrequency'+arrEntityDetail[0]).disabled=true;
               }
           }
         
        }
		</script>
</body>
</html>
