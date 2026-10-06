
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        width: 35%;
        vertical-align: middle;
    }
     .footerMenuTable
    {
        bottom:-10px; /*Added By Vaijat K On 25/11/2015*/
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectProfitablityByCustomer.aspx.vb" Inherits="PbNIT.ProjectProfitablityByCustomer"%>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
		<%CommonFunctions.General.PlotPageHeadTag("Project Profitability ")%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmProjectProfitabilityByCustomer" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script language="javascript">	
var objform=GetFormReference('frmProjectProfitabilityByCustomer');
var objdivlist= GetObjectReference('frmProjectProfitabilityByCustomer','DivMain');

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
	//Added and Commented by Vidya J on 26-11-2015
	//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 100;

	    //if (navigator.appName == 'Microsoft Internet Explorer')

	    if (WhichBrowser() == 'FF') {


	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
		}
		else {
             //Commented and added by Yogesh J on 23-Nov-2015
		    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;
		    //End of comment by Yogesh J on 23-Nov-2015
		}

	    if (intDivHeight < 100) intDivHeight = 100;
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
	    objdivlist.style.height = intDivHeight;
	    objdivlist.style.height = intDivHeight+'px';
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
	
}
    //End of Added and Commented by Vidya J on 26-11-2015
}
  //Added and Commented by Vidya J on 26-11-2015

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
		    //End of Added and Commented by Vidya J on 26-11-2015
function window_onresize()		
{
	var intDivHeight;
	var intDivHeightRisk;
	if (objdivlist !=null) {
	 
	if (intDivHeight < 100)	intDivHeight = 100;
	    //Added and Commented by Vidya J on 26-11-2015
	    //	if (navigator.appName == 'Microsoft Internet Explorer'){

	if (WhichBrowser() == 'FF') {
	    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
	    intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
		}
		else{
		    //Commented and added by Yogesh J on 23-Nov-2015
		    
	    // intDivHeight = window.innerHeight - objdivlist.offsetTop - 48;
	    intDivHeight = window.innerHeight - objdivlist.offsetTop - 47;
		    //End of comment by Yogesh J on 23-Nov-2015
	    //End of Added and Commented by Vidya J on 26-11-2015
	}
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
	//objdivlist.style.height = intDivHeight;
	objdivlist.style.height = intDivHeight+'px';
	    /*Commented And Added by KIRAN K K For Height Issue fixing*/
		}
}	
function ApplyFilter_OnClick()
{
 
 objCustomerID=GetObjectReference('frmProjectProfitabilityByCustomer','cboCust');
 window.location.href="../PRJPROFIT/ProjectProfitablityByCustomer.aspx?FromWhere=PM&MasterTagId=20015&Action=Display&CustomerID="+objCustomerID.value;
}
function Back_OnClick()
{
 window.location.href="../PRJPROFIT/ProjectProfitablityByCustomer.aspx?FromWhere=PM&MasterTagId=20015&Action=Menu";
}
function cboCust_change()
{
				objform.action="../PRJPROFIT/ProjectProfitablityByCustomer.aspx?FromWhere=PM&MasterTagId=20015&Action=Menu";
				objform.submit();
}
function CallGPM(ProjectID)
{
  
    //Commented and added by Yogesh J on 10-Feb-2016 to generate Token
   //  window.open('../PRJPROFIT/GrossProfitMargin.aspx?MasterTagId=20010&FromWhere=Customer&ProjectID=' + ProjectID, '', 'resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 950) / 2 + ',top=' + (window.screen.height - 550) / 2 + ',width=950,height=550');

 $.ajax({
     type: 'POST',
     dataType: 'json',
     contentType: 'application/json',
     url: 'ProjectProfitablityByCustomer.aspx/GenrateURLToken_CallGPM_OnClick',
     data: JSON.stringify({ Project: ProjectID, EmployeeID: "<%=Session("intUserID")%>" }),
        success: function (Result) {
            window.open('../PRJPROFIT/GrossProfitMargin.aspx?MasterTagId=20010&FromWhere=Customer&ProjectID=' + ProjectID +'&PKToken='+ Result.d, '', 'resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 950) / 2 + ',top=' + (window.screen.height - 550) / 2 + ',width=950,height=550');

        },
        error: function () {
            //      alert("Error")
        }
    });
    //End of addition by Yogesh J on 10-Feb-2016 to generate Token
}

function cboProject_change()
{
	objform.action="../PRJPROFIT/ProjectProfitablityByCustomer.aspx?FromWhere=PM&MasterTagId=20015&Action=Menu";
	objform.submit();
}

		</script>
	</body>
</HTML>
