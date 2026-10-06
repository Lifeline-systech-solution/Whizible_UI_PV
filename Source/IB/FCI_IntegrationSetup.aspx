<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FCI_IntegrationSetup.aspx.vb" Inherits="PbNIT.FCI_IntegrationSetup" %>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html  >
<head >
    
    <%CommonFunctions.General.PlotPageHeadTag("Integration Setup")%>
   

</head>
<BODY class=clsBody onresize=window_onresize() onload=window_onload()>
    <form id="frmIntegrationSetup"  method="post" runat="server">
    <%Page_Init()%>
    </form>
    
    <script language="javascript">
    var objDivMain = GetObjectReference('frmIntegrationSetup','DivMain');
    var objForm;
	objForm = GetFormReference('frmIntegrationSetup');
	
	function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight +'px'	;
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight +'px'	;	
			}
			
			function ItemTab_OnClick(strWhich)
			{	 	
			    var objcboSourceType = GetObjectReference('frmIntegrationSetup','cboSourceType');
			    var SysID;
			    if(objcboSourceType)
			        SysID = objcboSourceType.value
					    
			    if(strWhich == 'IntegrationDtls')
			    {
				    window.location.href = '../IB/FCI_IntegrationSetup.aspx?MasterTagID=8056&FromWhere=PM&Action='+strWhich+"&SysID=" + SysID;	
				}
				else if(strWhich == 'Attribute')
				{
				    window.location.href = '../IB/FCI_IntegrationSetup.aspx?MasterTagID=8056&FromWhere=PM&Action='+strWhich+"&SysID=" + SysID;
				}
				else if(strWhich == 'AttributeValue')
				{
				     window.location.href = '../IB/FCI_IntegrationSetup.aspx?MasterTagID=8056&FromWhere=PM&Action='+strWhich+"&SysID=" + SysID;
				}
			}
			function SysAttributeName_OnClick(WhizSysAttributeID)
			{
			    var strWhizSysAttributeID;
			   //window.open("../IB/ExternalSystemMaster_CommonPage.aspx?SubTagFromCL=1&MasterTagID=20053&FromWhere=SM&SubTagPagingAlphabet=-1&ParentTagID=20112&SubTagSortBy=&STAccessFirstTime=0&SubTagSortOrder=&PagingNumber=1&WhizSysAttributeID_PK=" +WhizSysAttributeID , "", " resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 350)/2) + ",width=600,height=250");
			   window.open("../IB/AttributeMappingForm_CommonPage.aspx?MasterTagID=8061&FromWhere=SM&PagingAlphabet=-1&SortBy=WhizAttributeName&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&WhizSysAttributeID_PK=" +WhizSysAttributeID , "", " resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 350)/2) + ",width=600,height=250")
			}
			function Save_OnClick(WhichSave)
			{
			    var WhichSave;
			    var objcboSourceType= GetObjectReference('','cboSourceType');
			    var objcboZone= GetObjectReference('','cboZone');
			   
			    if (objcboSourceType.value == '')
			    {
			        alert('Source Type should not be left blank.');
			        setFocus(objcboSourceType)
			        return;
			    }
			    
			    if (objcboZone.value == '')
			    {
			        alert('Time zone should not be left blank.');
			        setFocus(objcboZone)
			        return;
			    }
			    objcboSourceType.disabled= false
			    objcboZone.disabled= false;
			    //objForm.action = "../IB/FCI_IntegrationSetup.aspx?PerformAction=Save_"+WhichSave + "&Action=Attribute";
			    objForm.action = "../IB/FCI_IntegrationSetup.aspx?PerformAction=Save_"+WhichSave+"&Action=INTEGRATIONDTLS" ;
			    objForm.submit();
			}
			
			function ShowHistory_OnClick(UniqueID,ProjectID)
			{
			
			   window.open("../SM/AuditTrail_CommonList.aspx?MasterTagID=1500&ShowHistory=1&IsSubTagID=0&TagID=8056&UniqueID=" + UniqueID +"&ProjectID="+ProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500")
			}
			
			function Add_OnClick()
			{
			      //window.open("../IB/AttributeMapping_CommonList.aspx?MasterTagID=8052");
			     // window.open("../General/CommonPage.aspx?SubTagFromCL=1&MasterTagID=20053&FromWhere=SM&SubTagPagingAlphabet=-1&ParentTagID=20112&SubTagSortBy=&STAccessFirstTime=0&SubTagSortOrder=&PagingNumber=1&WhizSysAttributeID_PK=257");
			    
			}
			function AddAttribute_OnClick(Action,IntegrationID)
			{
			   			    
			   window.open("../IB/AttributeMapping_CommonList.aspx?MasterTagID=8052&IntegrationId="+ IntegrationID , "_popup", " resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=600,height=550");
			    		    
			    //window.open("../IB/AttributeMapping_CommonList.aspx?IntegrationID="+IntegrationID+"&MasterTagID=8052","_self");
			}
			function Delete_OnClick()
			{
			   var chkDel = GetObjectReference('frmIntegrationSetup','chkDelete',true);	   
			   
			   var DelIds;
			   DelIds='';
			    for (i=0;i<=chkDel.length-1;i++)
			    {
			            if (chkDel[i].checked===true)		
			                {
			                DelIds = DelIds + chkDel[i].value + ',';			                             
			                }
			                
			    }
		            alert(DelIds);
			  objForm.action = "FCI_IntegrationSetup.aspx?Action=Attribute&PerformAction=Delete&DeletedIDList=" + DelIds;
			   objForm.submit();
			}
			function chkUpdateAssignto_OnClick()
			{
			var UpdateAssignto = GetObjectReference('frmIntegrationSetup','chkUpdateAssignto');
			if (UpdateAssignto.checked==true)			
			    UpdateAssignto.value="1"
			 else
			    UpdateAssignto.value="0"
			}
					
			function chkSingleFLDDateTime_OnClick()
			{
			var chkSingleFLD = GetObjectReference('frmIntegrationSetup','chkSingleFLDDateTime');
			if (chkSingleFLD.checked==true)			
			    chkSingleFLD.value="1"
			else
			   chkSingleFLD.value="0"
			}	
			
			
			<%'Added by Archanan on 15-Jul-2010%>
			function EditValue(intAttributeID,intIntegrationID)
			{
			    window.open("../IB/AttributeValueMapping_CommonList.aspx?IntegrationID="+intIntegrationID+"&AttributeID="+intAttributeID+"&MasterTagID=8053","_self"); //,"resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no"); //,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
			}
			<%'End of Added by Archanan on 15-Jul-2010%>
			
			function setDateFilter()
            {
	            var objcboIsActive = GetObjectReference('frmIntegrationSetup','cboIsActive');
                objForm.action = '../IB/FCI_IntegrationSetup.aspx?Action=Attribute&ShowActive=' + objcboIsActive.value;
	            objForm.submit();
	        
            }

    </script>
    
</body>
</html>
