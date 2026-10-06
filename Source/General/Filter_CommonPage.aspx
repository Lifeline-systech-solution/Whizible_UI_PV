<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Filter_CommonPage.aspx.vb" Inherits="Whiz.Filter_CommonPage" %>

<script language="javascript">
    function fn_IsBlank(obj) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        return true;
    }
</script>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<%--Added by Dhanashri S on 3 Nov 2015--%>
<style>
    .clsTable td {
        vertical-align: top !important;
    }
</style>
<%--End of Addition by Dhanashri S on 3 Nov 2015--%>
<%--ADDED BY KIRAN K K FOR 2482--%>
<style>
    #Remarks {
        margin-top: 0px !important;
    }
    /*Added By Vaijat K ON 07/12/2015 Issue ID-2482*/
    #divSection1 table td {
        white-space: nowrap;
    }
    /*Added by Yogesh Jalamkar on 08-Nov-2016 Purpose: Field alignment is not proper */
    select {
        vertical-align: top;
    }

    textarea {
        margin-top: 0px !important;
    }
    /*End of addition by Yogesh Jalamkar on 08-Nov-2016*/

    /*Added By Dipali V On 10th July for Control Width*/
    #FFE29587WHIZ_ActualStartDate {
        width: 41px !important;
    }

    #FFE29587WHIZ_ReviewStartDate {
        width: 41px !important;
    }

    #FFE29587WHIZ_ReviewEndDate {
        width: 41px !important;
    }

    #FFE29587WHIZ_ActualEndDate {
        width: 41px !important;
    }
    /*End of Added By Dipali V On 10th July for Control Width*/
    /* Added By Chetan M On 30 Dec 2020 for control alignment*/
    #SAVEUI_HEAD0-3862 {
        display: inline-block;
    }

    #BACKUI_HEAD0-3862 {
        display: inline-block;
    }
    
    #SAVEUI_HEAD0-3848 {
        display: inline-block;
    }
    #BACKUI_HEAD0-3848 {
        display: inline-block;
    }
    /*Added & Commented By Dipali V On 18th Jan 2020 For Alignment Issues*/
    #divSection1 {
        overflow:hidden!important;
        height:auto!important;
    }


    /* End of Added By Chetan M On 30 Dec 2020 for control alignment*/
</style>
<%--End of Addition ADDED BY KIRAN K K FOR 2482--%>
<script type="text/javascript">


    $(document).ready(function () {

        // ADDED BY PUNEET M ON 18-11-2015
        function getURLParameter(name) {
            return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || null
        }

        if ($("#Sel_Description").length > 0 && getURLParameter("MasterTagID") == "1040") {
            document.getElementById("Sel_Description").style.verticalAlign = "bottom";
            document.getElementById("Sel_EntryCriteria").style.verticalAlign = "bottom";
            document.getElementById("Sel_ExitCriteria").style.verticalAlign = "bottom";
            document.getElementById("Sel_Measurements").style.verticalAlign = "bottom";
        }
        else if ($("#Sel_Description").length > 0 && getURLParameter("MasterTagID") == "1041") {
            document.getElementById("Sel_Description").style.verticalAlign = "bottom";
        }
        else if ($("#Sel_Scope").length > 0 && getURLParameter("MasterTagID") == "658") {
            document.getElementById("Sel_Scope").style.verticalAlign = "bottom";
            document.getElementById("Sel_Objective").style.verticalAlign = "bottom";
            document.getElementById("Sel_GuidelineDetails").style.verticalAlign = "bottom";
        }
        // ENDED BY PUNEET M ON 18-11-2015

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });


    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:16/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });

    //ADDED BY Nilesh G on 5/11/2015 for issue id  1807
    function Back_FilterList(url) {
        if (ShowNavigationAlert() == false) return;
        window.location.href = url;
        //ENDDED BY Nilesh G on 5/11/2015 for issue id  1807
    }
    //ADDED BY Nilesh G on 16/12/2015 
    function ResourceSelection() {
        var objReportingTo = GetObjectReference('', 'ReportingTo');
        if (objReportingTo) { window.open("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=23&FromWhere=RM", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=1000,height=400"); }
    }
    //ENDDED BY Nilesh G on 16/12/2015 
</script>

