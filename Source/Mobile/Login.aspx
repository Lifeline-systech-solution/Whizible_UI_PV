<%@ Page Language="VB" AutoEventWireup="true" Inherits="PbNIT.Login" CodeBehind="Login.aspx.vb" %>

<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%> 

<!--Including files & Libraries by Miiint Solutions-->
<%--/*Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<%--<script src="../../responsive/jquery/jquery-2.1.3.min.js" type="text/javascript"></script>--%>
<!-- <script src="../../responsive/jquery/jquery-3.5.1.min.js" type="text/javascript"></script> -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%><script type="text/javascript" src="../../responsive/responsive.js"></script>

<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        width: 35%;
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body>
    <mobile:Form ID="frmApprovals" Runat="server">
        <mobile:Panel ID="Panel" Runat="server">
            <mobile:Image ImageUrl="../../Images/cssImages/Link images/close.gif" Runat="server" NavigateUrl="Mobile_Approvals.aspx" ID="Img" SoftKeyLabel="Hi1" AlternateText="Hi2"></mobile:Image>
        </mobile:Panel>
        <mobile:Label ID="lbl1" Runat="server" Font-Bold="True" Font-Size="Large" Text="Whizible Mobile" />
        <br />
        <mobile:Label ID="lblLgnID" Runat="server" Text="Login ID:  " BreakAfter="False">Login ID   :  </mobile:Label>
        <mobile:TextBox Runat="server" ID="txtLogin" Size="17" MaxLength="30" />
        <mobile:Label ID="lblpwd" Runat="server" Text="Password: " BreakAfter="False">Password: </mobile:Label>
        <mobile:TextBox Runat="server" ID="txtPassword" Size="17" MaxLength="30" Password="True" />
        <mobile:Command ID="cmdLogin" Runat="server">Login</mobile:Command>
        <mobile:RequiredFieldValidator ID="LoginIDValidator" ControlToValidate="txtLogin" Text="Please enter your Login ID !!!" Runat="server" />
        <mobile:RequiredFieldValidator ID="PasswordValidator" ControlToValidate="txtPassword" Text="Please enter your Password !!!" Runat="server" />
        <mobile:Label ID="lblError" Runat="server" ForeColor="red" Text="" />
        <mobile:TextBox Runat="server" ID="txtInvalidLogin" Visible="False" />
        <mobile:TextBox Runat="server" ID="txtIsCookiesExist" Visible="False" />
        <mobile:TextBox Runat="server" ID="txtClientLoggedInAt" Visible="False" />
        <mobile:TextBox Runat="server" ID="txtContentTab" Visible="False" />

    </mobile:Form>
    <!--     <mobile:form ID="frmApprovalMenu" Runat="server"  BackColor="LightBlue">
     <mobile:Link id="LeaveApprovalLink"  Runat="server"  NavigateUrl="Mobile_LeaveApprovalList.aspx"   text="Leave Approval"></mobile:Link>
    <mobile:Link ID="TimeSheetApprovalLink"  Runat="server"  NavigateUrl="#frmApprovals" text="TimeSheet Appproval"></mobile:Link>
    
    </mobile:form> -->

</body>
</html>
