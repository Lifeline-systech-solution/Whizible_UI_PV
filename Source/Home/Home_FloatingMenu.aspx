<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home_FloatingMenu.aspx.vb" Inherits="PbNIT.Home_FloatingMenu" %>

<html>
<%  CommonFunctions.General.PlotPageHeadTag("Home: Floating Menu")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css' />
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css' />
<link rel='stylesheet' type='text/css' href='../General/tab-view.css' />
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<body id='tab1' class='clsPopUpBody' onresize="window_onresize()" onload="window_onload()">

    <form id="frmFloatingMenu" method="post" runat="server">

        <%PageInit()%>
    </form>



    <script language="javascript">

		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
		<%End If%>

        var objDivMain;

        objDivMain = GetObjectReference('', 'DivMain');
        var objfrm = GetObjectReference('', 'frmFloatingMenu');

        function window_onload() {
            if (objDivMain != null) {
                if (navigator.appName == 'Microsoft Internet Explorer') {
                    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 2;
                }
                else {
                    intDivHeight = window.innerHeight - objDivMain.offsetTop - 2;
                }
                if (intDivHeight < 100)
                    intDivHeight = 100;

                objDivMain.style.height = intDivHeight + 'px';
            }

        }

        function window_onresize() {
            var intDivHeight;
            intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 2;
            if (intDivHeight < 100) intDivHeight = 100;
            objDivMain.style.height = intDivHeight + 'px';
        }

        function ShowFavourites(PageName, TagID, ControlItemID) {
            //Commented And Added By Vaijat K ON 28/11/2015
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value=PageName;
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultTagID").value=TagID;
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultControlItemID").value=ControlItemID;

            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.style.display='none';
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.src="";
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href=PageName;      
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = PageName;
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultTagID").value = TagID;
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultControlItemID").value = ControlItemID;

            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.style.display = 'none';
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.src = "";
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = PageName;
            //Ended
        }

        function ShowView(ThemeID, TagID) {
            var List, Mode = "";

            //hidTxtThemeID
            //Commented And Added By Vaijat K ON 28/11/2015
            //if(document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidTxtThemeID")!=null)
            //    document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidTxtThemeID").value=ThemeID;

            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.style.display='none';
            //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.src="";
            if (document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidTxtThemeID") != null)
                document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidTxtThemeID").value = ThemeID;

            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.style.display = 'none';
            document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.src = "";
            //Ended
            if (TagID == "1038" || TagID == "34" || TagID == "661" || TagID == "2133" || TagID == "1019" || TagID == "454") {
                if (ThemeID == "1") {
                    if (TagID == "2133") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=1";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=1";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=1";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=1";
                        //Ended
                    }
                    else {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=1";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=1";  
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=1";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=1";
                        //Ended
                    }
                }

                if (ThemeID == "2") {
                    if (TagID == "2133") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=2";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=2";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=2";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=2";
                        //Ended
                    }
                    else {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=2";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=2";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=2";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=2";
                        //Ended
                    }
                }

                if (ThemeID == "5") {
                    if (TagID == "2133") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=5";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=5";  
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=5";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=5";
                        //Ended
                    }
                    else {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=5";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=5";  
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=5";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=5";
                        //Ended
                    }
                }
                if (ThemeID == "6") {
                    if (TagID == "2133") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //    document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=6";  
                        //    document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=6";  
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=6";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=6";
                        //Ended

                    }
                    else {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=6";  
                        // document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+TagID+"&GanttChartType=6";      
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=6";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=" + TagID + "&GanttChartType=6";
                        //Ended

                    }
                }

                if (ThemeID == "3") {
                    if (TagID == "34")
                        List = '6';
                    else if (TagID == "1038")
                        List = '1';
                    else if (TagID == "2133")
                        List = '9';
                    else if (TagID == "661")
                        List = '10';
                    else if (TagID == "1019")
                        List = '11';
                    else if (TagID == "454")
                        List = '12';
                    //Commented And Added By Vaijat K ON 28/11/2015
                    //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../Home/Home_OutlookView.aspx?List="+List;  
                    //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../Home/Home_OutlookView.aspx?List="+List;  
                    document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../Home/Home_OutlookView.aspx?List=" + List;
                    document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../Home/Home_OutlookView.aspx?List=" + List;
                    //Ended
                }

                if (ThemeID == "4") {
                    if (TagID == "1038") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";  
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";
                        //Ended
                    }
                    if (TagID == "34") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../General/CommonList.aspx?MasterTagID=34&FromWhere=PM";
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../General/CommonList.aspx?MasterTagID=34&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../General/CommonList.aspx?MasterTagID=34&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../General/CommonList.aspx?MasterTagID=34&FromWhere=PM";
                        //Ended
                    }
                    if (TagID == "661") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../General/CommonList.aspx?MasterTagID=661&FromWhere=PM";
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../General/CommonList.aspx?MasterTagID=661&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../General/CommonList.aspx?MasterTagID=661&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../General/CommonList.aspx?MasterTagID=661&FromWhere=PM";
                        //Ended
                    }
                    if (TagID == "2133") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href="../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";
                        //Ended

                    }
                    if (TagID == "1019") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM";
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../General/CommonList.aspx?MasterTagID=1019&FromWhere=PM";
                        //Ended
                    }
                    if (TagID == "454") {
                        //Commented And Added By Vaijat K ON 28/11/2015
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("hidDefaultPageURL").value="../General/CommonList.aspx?MasterTagID=454&FromWhere=PM";
                        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).location.href = "../General/CommonList.aspx?MasterTagID=454&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultPageURL").value = "../General/CommonList.aspx?MasterTagID=454&FromWhere=PM";
                        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href = "../General/CommonList.aspx?MasterTagID=454&FromWhere=PM";
                        //Ended

                    }
                }
            }
        }

        //document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all(""tdTabs"").innerHTML=



        function Close_Div() {
            //For Firefox

            if (navigator.appName == 'Microsoft Internet Explorer') {
                //for IE
                //Commented And Added By Vaijat K ON 28/11/2015
                //document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent[1].frameElement.style.display='none';
                //document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent[1].frameElement.src="";
                document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.style.display = 'none';
                document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.src = "";
                //Ended


            }
            else {

                window.parent.frames['iFloatingMenu'].frameElement.style.display = 'none';
                window.parent.frames['iFloatingMenu'].frameElement.src = "";


            }
        }

        function SelectAndClearAll_OnClick() {
            var obSCFilterX = GetObjectReference('', 'chkAll');

            if (obSCFilterX != null) {
                if (obSCFilterX.checked == true)
                    SelectClearAllX = 0;
                else
                    SelectClearAllX = 1;
            }
            if (SelectClearAllX == 0) {

                SelectAllCheckboxs('frmDashboard', 'chkField');
                SelectClearAllX = 1;
            }
            else {
                ClearAll_OnClick('frmDashboard', 'chkField');
                //  obhdnXAxisFilterString.value = "";
                SelectClearAllX = 0;
            }
        }
        function CloseFilter() {
            Close_Div();

        }
        function applyFilter() {           

            // objfrm.action='';
            var favChecked = $('form #chkField:checked').size();
            // document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("txtFAVPageNumber").value="1";
            //Added By Bharat Tekade on 5th-Feb-2016 to restrict favorites item to 5
            if ($('.mainTabsSectionEasyMenu a', window.parent.document) != null)
                var favoriteCount = $('.mainTabsSectionEasyMenu a', window.parent.document).length;
            if (favoriteCount >= 5 ) {
                //Added by Yogesh Jalamkar on 18-Aug-2016 restrict favorites item to 5
               if(  favChecked > 5){
                    alert('Maximum limit is 5.');
                    return;
                }
                else {
                   
                    if (navigator.appName == 'Microsoft Internet Explorer')
                        objfrm.action = "Home_FloatingMenu.aspx?Mode=Save&browserType=IE";
                    else
                        objfrm.action = "Home_FloatingMenu.aspx?Mode=Save&browserType=FireFox";

                    objfrm.submit();
                }
                //End of addition by Yogesh Jalamkar on 18-Aug-2016 restrict favorites item to 5
            }
            else {
                //Added by Yogesh Jalamkar on 18-Aug-2016 restrict favorites item to 5
                if (favChecked > 5) {
                    alert('Maximum limit is 5.');
                    return;
                }
                    //End of addition by Yogesh Jalamkar on 18-Aug-2016 restrict favorites item to 5
                else {
                    if (navigator.appName == 'Microsoft Internet Explorer')
                        objfrm.action = "Home_FloatingMenu.aspx?Mode=Save&browserType=IE";
                    else
                        objfrm.action = "Home_FloatingMenu.aspx?Mode=Save&browserType=FireFox";

                    objfrm.submit();
                }
            }
            // Close_Div();

        }
        function txtOrderNumber_OnBlur(obj) {
            if (obj != null) {
                if (disallowNegativeNumeric(obj, 'Please enter only positive numeric value for &#39;Order Number&#39;', true))
                { return }

            }
        }
        var xmlhttp;
        function loadXMLDoc(url, reqQuery) {
            // code for Mozilla, etc.
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest()
                xmlhttp.onreadystatechange = state_Change;

                if (ns) {
                    xmlhttp.open("GET", url + "&" + reqQuery, true)
                    xmlhttp.send(false)
                }

                else {
                    xmlhttp.open("POST", url, true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)

                }
            }
                // code for IE
            else if (window.ActiveXObject) {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
                if (xmlhttp) {

                    xmlhttp.onreadystatechange = state_Change;

                    xmlhttp.open("POST", url, true)
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(reqQuery)
                }
            }
        }
        function state_Change() {
            // if xmlhttp shows "loaded"
            if (xmlhttp.readyState == 4) {
                // if "OK"
                if (xmlhttp.status == 200) {

                    if (xmlhttp.responseText != "") {
                        //objdivHeader.innerHTML=xmlhttp.responseText;

                    }

                    /* objdivTab.innerHTML=xmlhttp.responseText;
                     calcHeight();
                     var URL = GetObjectReference('','hidDefaultPageURL');
                            document.getElementById("frmMain").src=URL.value;*/


                }
                else {
                    alert("Problem in transfering data:" + xmlhttp.statusText)
                }
            }
        }

        function SetDefaultTheme(ThemeID, TagID) {
            if (ThemeID == 0) return;

            loadXMLDoc("../Home/AJAXHttp.aspx?From=DefaultTheme", "ThemeID=" + ThemeID + "&MasterTagID=" + TagID);
            //  objhidtxtThemeID.value='';

            Close_Div();
        }

    </script>






</body>
</html>
