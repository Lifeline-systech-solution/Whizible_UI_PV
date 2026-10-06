<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
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
            //Commented And Added By Vaijat K ON 23/12/2015
            //removeSectionHeader();
            dataCollapse("divListTag");
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MB_ProjectMeasurement_CommonPage.aspx.vb" Inherits="PbNIT.MB_ProjectMeasurement_CommonPage" %>

<script language="javascript">
var objform;
objform = GetFormReference('frmCommonPage');
function GetLatestRevision(UniqueID)
{
    if(confirm("This will regenerate the metric as per new revision.Do you want to continue?"))
    {
    //modified by purvaj on 22 Apr 2010 to accept from date to recalculate the metrics
    window.open("../METRICS/ProjectMetrics_GetLatestRevision.aspx?MetricProjectMappingID="+UniqueID+"&FromWhere=PM&FROM=GETLATEST", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=200");
    //objform.action ="../METRICS/MB_ProjectMeasurement_CommonPage.aspx?MasterTagID=2506&FromWhere=PM&Mode1=GetLatest&MetricID=" + UniqueID;
    //objform.submit();
    }
    else
    return;
}

function Publish(UniqueID,RevisionNo)
{
    if(RevisionNo!="0")
    {
        if(confirm("This will regenerate the metric as per new revision.Do you want to continue?"))
        {
        //modified by purvaj on 22 Apr 2010 to accept from date to recalculate the metrics
        window.open("../METRICS/ProjectMetrics_GetLatestRevision.aspx?MetricProjectMappingID="+UniqueID+"&FromWhere=PM&FROM=PUBLISH", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=200");
        //objform.action ="../METRICS/MB_ProjectMeasurement_CommonPage.aspx?MasterTagID=2506&FromWhere=PM&Mode1=GetLatest&MetricID=" + UniqueID;
        //objform.submit();
        }
        else
        return;
     }
     else
     {
     window.open("../METRICS/PublishProjectMetrics_CommonPage.aspx?Mode=ADD_NEW&FromWhere=PM&MasterTagID=8069&ParentTagID=0&FromCL=1&MetricProjectMappingID=" + UniqueID, "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 500)/2) + ",top=" + ((window.screen.height - 300)/2) + ",width=500,height=250");
     }
//window.open("../METRICS/PublishProjectMetrics_CommonPage.aspx?Mode=ADD_NEW&FromWhere=PM&MasterTagID=20097&ParentTagID=0&FromCL=1&MetricProjectMappingID=" + UniqueID, "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 500)/2) + ",top=" + ((window.screen.height - 300)/2) + ",width=500,height=250");
}
function OpenNewlyAdded(UniqueID,ProjectID)
{
     window.open("../METRICS/ProjectLevelMetricBuilder_CommonPage.aspx?MetricID_PK=" + UniqueID + "&MasterTagID=8068&ParentTagID=0&FromCL=1&ProjectID=" + ProjectID , "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=900,height=600");
}


function cboMetric_OnChange()
{var arr = new Array();
var objMetric = GetObjectReference('frmCommonPage', 'MetricID');
var objHdMetric = GetObjectReference('frmCommonPage', 'NonDatabase1');
var objDel = GetObjectReference('frmCommonPage', 'ConsiderForDeliverable');
var objPhase = GetObjectReference('frmCommonPage', 'ConsiderForPhase');
var objMil = GetObjectReference('frmCommonPage', 'ConsiderForMilestone');
var objPMD = GetObjectReference('frmCommonPage', 'IsEnableForPMD');
var objRevNo = GetObjectReference('frmCommonPage', 'RevisionNo');
var objGuidelines = GetObjectReference('frmCommonPage', 'Guidelines');
var objUDFormula = GetObjectReference('frmCommonPage', 'UDFormula');
var objIsCorporate = GetObjectReference('frmCommonPage', 'IsCorporate');
var objAbove = GetObjectReference('frmCommonPage', 'Above');
var objBelow = GetObjectReference('frmCommonPage', 'Below');
alert(objMetric.selectedIndex);
alert(objHdMetric.value );
alert(objMetric.value );
objHdMetric.value = objHdMetric[objMetric.selectedIndex].value;
if (objHdMetric != null && objHdMetric.value !="")
{arr = objHdMetric.value.split("|");
	if (arr[4]=='1'){objPhase.checked= true;objPhase.disabled=false;}
	else {objPhase.checked= false;objPhase.disabled=true;}
	if (arr[4]=='1')
	{objMil.checked= true;objMil.disabled=false;}
	else
	{objMil.checked=false;objMil.disabled=true;}
	if (arr[4]=='1')
	{objDel.checked= true;objDel.disabled=false;}
	else
	{objDel.checked= false;objDel.disabled=true;}
	if (arr[4]=='1')
	{objPMD.checked= true;objPMD.disabled=true;}
	else
	{objPMD.checked= false;objPMD.disabled=true;}
	if(objGuidelines)
	{objGuidelines.value = arr[5];}
    if(objRevNo)
	{objRevNo.value = arr[6];}
	if(objUDFormula)
	{objUDFormula.value = arr[7];
	}
	 if(objUDFormula)
	{objIsCorporate.value = 1;}
	if(objAbove){objAbove.value = arr[8];}
	if(objBelow){objBelow.value = arr[9];}
}
else
{objPhase.value= "";objMil.value = "";objDel.value = "";  
objPMD.value = "";  objGuidelines.value = "";objRevNo.value ="" ;
objUDFormula="" ;
objAbove="";
objBelow="";objMetric="";objMetric.selectedIndex=0;} 
 }
</script>
