<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child {
        /*width: 35%;*/
        vertical-align: middle;
    }

    TR.clsTREven {
        height: 25px;
    }

        TR.clsTREven td:first-child {
            word-break: break-all;
        }

    .clsTDHeader table {
        margin-left: 3px;
    }

    #divContainer table:not(:first-child) tr td font {
        color: black !important;
    }

/*Added by Chetan M on 31 Dec 2020 for setting text colour*/
    #cboEmployee {
        color: black
    }

    #cboOrganizationUnit {
        color: black
    }
    /*ENd of Added by Chetan M on 31 Dec 2020 for setting text colour*/
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

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RPT_Calender.aspx.vb" Inherits="PbNIT.RPT_Calender" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<html>
<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("Calender"))%>
<body ms_positioning="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmCalender" method="post" runat="server">
        <%DrawPage()%>
    </form>

    <script language="javascript">
	//onload="window_onload()" onresize="window_onresize()"

        <%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

        function NextMonth_clicked() {
            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            var objEmployee = GetObjectReference('frmCalender', 'cboEmployee');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;
            var EmployeeID = objEmployee.value;

            var objtxtMonth = GetObjectReference('frmCalender', 'txtMonth');
            var objtxtYear = GetObjectReference('frmCalender', 'txtYear');
            var tempYear =<%=m_CurrYear%>;
        var tempMonth = objtxtMonth.value;


        if (objtxtYear.value < tempYear - 1) {
            alert("You can not enter value less than Previous year !")
            objtxtYear.focus();
            return;
        }

        if (tempMonth <= 0 || tempMonth > 12) {
            alert("You can not enter this value for month !")
            objtxtMonth.focus();
            return;
        }
        //Modified by MrugajaB on 19th July 2006 for WhizibleSEM SP7
        //Purpose:when value 12/9999 is entered and next month clicked then page crashes
        if (tempMonth == 12) {
            if (objtxtYear.value == 9999) {
                alert("Operation not Allowed !");
                objtxtMonth.focus();
                return;
            }
        }
		//End Modification

		//window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID +  "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
        window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + "<%=m_intMonth+1%>" + "&Year=" + "<%=m_intYear%>" + "&EmployeeID=" + EmployeeID + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";

        }


        function PreviousMonth_clicked() {
            try {//debugger;
                var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
                //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
                //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
                var objEmployee = GetObjectReference('frmCalender', 'cboEmployee');
                var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
                //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

                var txtOrganizationUnitID = objtxtOrganizationUnit.value;
                //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
                var OrganizationUnitID = objOrganizationUnit.value;
                //var DeliveryUnitID=objDeliveryUnit.value;
                //var DeliveryTeamID=objDeliveryTeam.value;

                var EmployeeID = objEmployee.value;

                var objtxtMonth = GetObjectReference('frmCalender', 'txtMonth');
                var objtxtYear = GetObjectReference('frmCalender', 'txtYear');
                var tempYear =<%=m_CurrYear%>;
        var tempMonth = objtxtMonth.value;


        //Added and modified By ShraddhaM on 14,Aug 2007
        var PrevYear;
        var PrevMonth;
        PrevYear = objtxtYear.value;

        if (tempMonth == 1) {
            PrevYear = parseInt(PrevYear) - 1;
        }

        if (PrevYear < tempYear - 1) {
            alert("You can not enter value less than Previous year !");
            objtxtYear.focus();
            return;
        }

        //End of addition and modification By ShraddhaM on 14,Aug 2007


        if (tempMonth <= 0 || tempMonth > 12) {
            alert("You can not enter this value for month !")
            objtxtMonth.focus();
            return;
        }


        if (<%=m_intMonth%>!= 1) {
			//window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID +  "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + "<%=m_intMonth-1%>" + "&Year=" + "<%=m_intYear%>" + "&EmployeeID=" + EmployeeID + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";
        }
        else {
			//window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID +  "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+ "&EmployeeID="+ EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + "<%=m_intMonth+11%>" + "&Year=" + "<%=m_intYear-1%>" + "&EmployeeID=" + EmployeeID + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";
                }
            }
            catch (ex) { }
        }

        function Year_OnClick(intMonth, intYear) {
            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            var objYear = GetObjectReference('frmCalender', 'cboYear');
            var objMonth = GetObjectReference('frmCalender', 'cboMonth');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;
            var Year = objYear.value;
            var MonthID = objMonth.value;

            //window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + MonthID + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + MonthID + "&Year=" + Year + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";

        }

        function Employee_OnClick(intMonth, intYear) {
            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            //var objYear=GetObjectReference('frmCalender','cboYear');
            //var objMonth=GetObjectReference('frmCalender','cboMonth');
            var objEmployee = GetObjectReference('frmCalender', 'cboEmployee');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;
            var objtxtMonth = GetObjectReference('frmCalender', 'txtMonth');
            var objtxtYear = GetObjectReference('frmCalender', 'txtYear');

            var Year = objtxtYear.value;
            var MonthID = objtxtMonth.value;
            var EmployeeID = objEmployee.value;

            //window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + MonthID + "&Year=" + Year + "&EmployeeID=" + EmployeeID+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + MonthID + "&Year=" + Year + "&EmployeeID=" + EmployeeID + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";

        }

        function Month_OnClick(intMonth, intYear) {
            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            var objYear = GetObjectReference('frmCalender', 'cboYear');
            var objMonth = GetObjectReference('frmCalender', 'cboMonth');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;
            var Year = objYear.value;
            var Month = objMonth.value;

            //window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + Month + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + Month + "&Year=" + Year + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";
        }


        function OrganizationUnit_OnClick(intMonth, intYear) {
            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');

            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;

            //window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + intMonth + "&Year=" + intYear + "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID
            window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + intMonth + "&Year=" + intYear + "&txtOrganizationUnit=" + txtOrganizationUnitID +"&DashboardID=<%=m_strDashboardID%>";
        }

        function Show_clicked() {

            var objOrganizationUnit = GetObjectReference('frmCalender', 'cboOrganizationUnit');
            //var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
            //var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
            var objtxtOrganizationUnit = GetObjectReference('frmCalender', 'txtOrganizationUnit');
            var objtxtMonth = GetObjectReference('frmCalender', 'txtMonth');
            var objtxtYear = GetObjectReference('frmCalender', 'txtYear');
            //var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');
            var ObjcboEmployee = GetObjectReference('frmCalender', 'cboEmployee');
            var txtOrganizationUnitID = objtxtOrganizationUnit.value;
            //var txtDeliveryUnitID= objtxtDeliveryUnit.value;
            var OrganizationUnitID = objOrganizationUnit.value;
            //var DeliveryUnitID=objDeliveryUnit.value;
            //var DeliveryTeamID=objDeliveryTeam.value;

            var tempYear =<%=m_CurrYear%>;
    var tempMonth = objtxtMonth.value;
    var preYear = tempYear - 1;

    if (isBlank(Trim(tempMonth)) == true) {
        alert("'Month' can not be blank !")
        objtxtMonth.focus();
        return;
    }

    if (isBlank(Trim(objtxtYear.value)) == true) {
        alert("'Year' can not be blank !")
        objtxtYear.focus();
        return;
    }


    if (Trim(objtxtYear.value) < tempYear - 1) {
        alert("You can only enter value for  year " + preYear + " and above !")
        objtxtYear.focus();
        return;
    }
    if (Trim(tempMonth) <= 0 || Trim(tempMonth) > 12) {
        alert("You can enter value between '1-12' for month !")
        objtxtMonth.focus();
        return;
    }

    var Year = Trim(objtxtYear.value);
    var Month = Trim(objtxtMonth.value);

    if (isInteger(Month) == false) {
        alert("Please enter only numeric value for 'Month'!");
        objtxtMonth.focus();
        return;
    }
    if (isInteger(Year) == false) {
        alert("Please enter only numeric value for 'Year'!");
        objtxtYear.focus();
        return;
    }
    //Modified By : SujataK
    //Modified On : 6/4/2006
    //For         : Resource Calender View
    //Issue ID    : 3106  
    window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + Month + "&Year=" + Year + "&txtOrganizationUnit=" + txtOrganizationUnitID + "&employeeid=" + ObjcboEmployee.value +"&DashboardID=<%=m_strDashboardID%>";
            //End of Modification


        }


/*
function DeliveryUnit_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmCalender','cboOrganizationUnit');
	var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
	var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
	var objtxtOrganizationUnit=GetObjectReference('frmCalender','txtOrganizationUnit');
	var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');
	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	var txtDeliveryUnitID= objtxtDeliveryUnit.value;
	var OrganizationUnitID=objOrganizationUnit.value;
	var DeliveryUnitID=objDeliveryUnit.value;
	var DeliveryTeamID=objDeliveryTeam.value;
	
	window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + intMonth + "&Year=" + intYear + "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID

}

function DeliveryTeam_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmCalender','cboOrganizationUnit');
	var objDeliveryUnit=GetObjectReference('frmCalender','cboDeliveryUnit');
	var objDeliveryTeam=GetObjectReference('frmCalender','cboDeliveryTeam');
	var objtxtOrganizationUnit=GetObjectReference('frmCalender','txtOrganizationUnit');
	var objtxtDeliveryUnit=GetObjectReference('frmCalender','txtDeliveryUnit');
	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;
	var txtDeliveryUnitID= objtxtDeliveryUnit.value;
	var OrganizationUnitID=objOrganizationUnit.value;
	var DeliveryUnitID=objDeliveryUnit.value;
	var DeliveryTeamID=objDeliveryTeam.value;
	
	window.location.href = "RPT_Calender.aspx?OrganizationUnitID=" + OrganizationUnitID + "&DeliveryUnitID=" + DeliveryUnitID + "&DeliveryTeamID=" + DeliveryTeamID + "&Month=" + intMonth + "&Year=" + intYear+ "&txtOrganizationUnit="+txtOrganizationUnitID + "&txtDeliveryUnit="+txtDeliveryUnitID

}

*/	
		function window_onload()
		{ try{
		
			var objdivContainer = GetObjectReference('GraphOutlook','divContainer');

			var intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
			if (intDivHeight < 100)
				intDivHeight = 100;	// Let the minimum height of the div tag be 100

			objdivContainer.style.height = intDivHeight;
			Assignments_clicked(<%=m_intListNumber%>);
		}
		 catch (ex) { }		 
		
		}

        function window_onresize() {
           
            try {
                var intDivHeight;
                var objdivContainer = GetObjectReference('GraphOutlook', 'divContainer');
                if (objdivContainer) {
                    intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
                    if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100

                    objdivContainer.style.height = intDivHeight
                }
            }
            catch (ex) { }
        }	


        function cboDashboard_OnChange()
        // For selecting the user's e-DB 
        {
            var strPageName;
            var arr;
            var objcboDashboard;
            var objcboDashboard = GetObjectReference('frmCalender', 'cboDashboard');
            strPageName = objcboDashboard.value;

            if (trimString(strPageName + "") != "") {
                arr = strPageName.split("|");
                /*
                Modified By		:	HiteshS on 27th Jan.2005
                IssueID			:	15626
                Description		:	After splitting for "|", before setting the href
                                    check for any existing querystring and if exists
                                    then append to that only.
                */
                if (isSubstringExists(arr[0], '?')) {
                    window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
                }
                else {
                    window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
                }
                //window.location.href = arr[0] + "?DashboardID=" + arr[1];
                /*
                End of Modification by HiteshS on 27th Jan.2005
                */
            }
            else {
                window.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=<%=m_strDB_PageName%>&DashboardID=0";
            }

        }

        var objdivlist = GetObjectReference('frmCalender', 'divContainer');
        function window_onload() {

            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
                if (intDivHeight < 100) intDivHeight = 100;
                //Comment added on 11 Dec 2015 by Viraj P
                //objdivlist.style.height = intDivHeight;	
                objdivlist.style.height = intDivHeight + 'px';
            }

            //CallOnLoadForTW()
            CallOnLoad()
        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
                if (intDivHeight < 100) intDivHeight = 100;
                //Comment added on 11 Dec 2015 by Viraj P
                //objdivlist.style.height = intDivHeight;	
                objdivlist.style.height = intDivHeight + 'px';
            }
            CallOnLoad()
        }



        function CallOnLoad() {// debugger;
            var xl = tblHeader.offsetLeft;
            var yt = tblHeader.offsetTop;
            var tl = tblHeader;

            while (tl.tagName != "BODY") {
                tl = tl.offsetParent; xl = xl + tl.offsetLeft; yt = yt + tl.offsetTop;
            }

            var headerTableRow = tblOver.rows[0];
            var originalTableRow = tblHeader.rows[0];

            //for (var i = 0; i <	headerTableRow.cells.length; i++) 
            //	{ 
            headerTableRow.cells[0].width = originalTableRow.cells[0].offsetWidth;
            //headerTableRow.cells[0].height = originalTableRow.cells[0].offsetHeight; 
            headerTableRow.cells[0].innerHTML = originalTableRow.cells[0].innerHTML;
            headerTableRow.cells[0].align = originalTableRow.cells[0].align;
            //	}					

            tblOver.style.top = yt;
            tblOver.style.left = 0;
            //tblOver.style.left =tblHeader.style.left ; 
            tblOver.style.position = 'absolute';
            tblOver.style.display = "block";


        }

        function LoadDetails(strStartDate, intEmployeeID, strEndDate) {
            window.open("../PM/PM_ResourceSchedule.aspx?PageType=Schedule&EmployeeIDList=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550) / 2 + ",top=" + (window.screen.height - 350) / 2 + ",width=650,height=450");
        }
    </script>

    <table id="tblOver" style='height: 0px; table-layout: fixed; display: none' border="0" cellpadding="0" cellspacing="0">
        <tr>
            <%--Commented by Nilesh P on 12 Aug 2020--%>
            <%--<td class='clsTDHeader'  align='center' width='10%'></td>--%>
            <%--End of Commented by Nilesh P on 12 Aug 2020--%>
        </tr>
    </table>
</body>
</html>
