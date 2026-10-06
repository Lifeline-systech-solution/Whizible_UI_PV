<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverallSchedule_NetworkView.aspx.vb" Inherits="PbNIT.OverallSchedule_NetworkView" %>

<html>
<%  CommonFunctions.General.PlotPageHeadTag("Overall Schedule Network View")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>
<style>
    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 100px;
        height: 100px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.95;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
    }
    #PageDiv:hover
    {
        overflow:auto;
    }
    .clsSaveSnapshot {
            background: #e39321;
            padding: 5px;
            color: white;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(0,0,0,0.6);
            -moz-box-shadow: 0 0 10px rgba(0,0,0,0.6);
            -webkit-box-shadow: 0 0 8px rgba(0,0,0,0.6);
            -o-box-shadow: 0 0 10px rgba(0,0,0,0.6);
        }

            .clsSaveSnapshot:hover {
                cursor: pointer;
                text-decoration: none;
                background: #eba933;
                padding: 5px;
                color: white;
            }
</style>
    <script type="text/javascript">
        // Added by Kiran for Loader 2/11/15
        function setFrameLoaded() {
            //Added by swapnil aswale on 14-12-2015 for Mulitple Login

            //Ended

            //Added by swapnil aswale on 14-12-2015 for Mulitple Login
            //$("#frmMain").contents().find("#frmSub").find("a").click(function(){
            //    $.ajax({url: "MultipleLogin.aspx", success: function(result){

            //    }});

            //});
            //Ended 
            //Added by swapnil aswale on 14-12-2015 for Mulitple Login
            jQuery("#preloader").fadeOut("slow");
            jQuery("#fillDiv").fadeOut("slow");
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            //=====================
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            ////===========================
            RemoveFrameLoader();
        }
        function setFrameLoader() {

            $("HTML").append("<div id='preloader'></div>");
            $("HTML").append("<div id='fillDiv'></div>");
        }
        function RemoveFrameLoader() {
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            jQuery("#preloader").fadeOut("slow");
            jQuery("#fillDiv").fadeOut("slow");
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
        }

        //End by KIran for Loader 2/11/15
</script>
<body class="clsBody" onload="window_onLoad()">
    <STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 );}
	#Tajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	#Tajax_tooltipObj DIV { POSITION: absolute; }
	#Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; }
	#Bajax_tooltipObj DIV { POSITION: absolute; }
	#Tajax_tooltipObj .ajax_tooltip_TLarrow { BACKGROUND-POSITION: right top; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }
	#Bajax_tooltipObj .ajax_tooltip_BRarrow { BACKGROUND-POSITION: bottom right ; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/BRarrow.gif'); BACKGROUND-REPEAT: no-repeat; }
	#Tajax_tooltipObj .ajax_tooltip_Tcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; top:18px }
	#Bajax_tooltipObj .ajax_tooltip_Bcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	</STYLE>

       <div id='preloader'></div>
    <div id='fillDiv'></div>

    <form id="frmOSNetworkView" method="post">
        <%PageInit()%>
        <DIV id="Tajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
			<DIV class="ajax_tooltip_Tcontent" id="Tajax_tooltip_content" style="width:860px;height:124px;"></DIV> <!-- followign code removed by purvaj on 30 jun 2009 8.1 issue fixes. Div was not getting displayed at the proper place
			             style="POSITION: absolute; TOP: 165px" -->
			<DIV class="ajax_tooltip_TLarrow" id="Tajax_tooltip_arrow"></DIV>
		</DIV>
		<DIV id="Bajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
			<DIV class="ajax_tooltip_Bcontent" id="Bajax_tooltip_content" style="width:860px;height:124px;"></DIV>
			<DIV class="ajax_tooltip_BLarrow" id="Bajax_tooltip_arrow" ></DIV>
		</DIV>
    </form>
    <script language="javascript">
        $(window).ready(function () {
            $('body').append("<div id='preloader'></div> <div id='fillDiv'></div>");
        });
       
        </script>
    <script language="javascript">
        $(document).ready(function () {
            setFrameLoader();
            setTimeout(function () {
                RemoveFrameLoader();
            },1000);
        });
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
		<%End If%>
		
        var objfrm = GetFormReference('frmOSNetworkView');
        var objDivMain = GetObjectReference('frmOSNetworkView', 'PageDiv');
        var gEvt;
        var newxPos, newyPos;
        var bwidth = document.body.offsetWidth;
        var bheight = document.body.offsetHeight;
        var g_sResponseText = '';
        var g_oValidateXMLHttp;
     
        function window_onLoad() {
            RemoveFrameLoader();
            var objPageDiv = GetObjectReference('frmOSNetworkView', 'PageDiv');

            var intDivHeight;
            var divHeightFactor = 16;
            if (objPageDiv != null) {
                if (isIE() == 'IE') {
                    intDivHeight = window.innerHeight - objPageDiv.offsetTop - divHeightFactor;
                }
                else {
                    intDivHeight = window.innerHeight - objPageDiv.offsetTop - divHeightFactor;
                }
                setTimeout(function () {
                    objPageDiv.style.height = intDivHeight + 'px';
                }, 500)

            }
        }
        function ShowPopup(AttributeID, Attribute) {
            window.open("../Enhancement/OverallSchedule_AttributeDetails.aspx?AttributeID=" + AttributeID + "&Attribute=" + Attribute + "", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=750,height=400");
            return;
        }
        function Combo_onChange() {
            var objform = GetFormReference('frmOSNetworkView');
            objform.action = "OverallSchedule_NetworkView.aspx?FromWhere=Project";
            objform.submit();

        }
        function ShowTaskDetails(OSID) {
            window.open("../Enhancement/ProjectTasksDetails.aspx?Action=TASKDETAILS&FromWhere=PM&OverallScheduleID=" + OSID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=950,height=500");
        }
        function ShowTaskDiv(evt, OSID, ProjectID) {
            evt = window.event || evt;
            if (!gEvt) {
                gEvt = evt;
                xPos = evt.clientX || evt.pageX;
                yPos = evt.clientY || evt.pageY;

                newxPos = xPos;
                newyPos = yPos;

                var url = "OverallSchedule_NetworkView.aspx?FromXML=1&OSID=" + OSID + "&ProjectID=" + ProjectID;
                loadXMLDoc(url, '')
            }
        }
        function loadXMLDoc(url, reqQuery) {
            var strResult;
            var strNavigator;
            g_sResponseText = '';
            strNavigator = navigator.appName;
            strNavigator = isIE();
            if (strNavigator == 'IE') {
                g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", url, false);
                //finally send the call
                g_oValidateXMLHttp.send();
            }
            else {
                // Mozilla - based browser 
                g_oValidateXMLHttp = new XMLHttpRequest();
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET", url, false);
                //finally send the call
                g_oValidateXMLHttp.send(null);
            }
            if (g_oValidateXMLHttp.responseText != null) {
                SetBox(g_oValidateXMLHttp.responseText);
                gEvt = null;
                xPos = 0;
                yPos = 0;
            }
            //if (window.XMLHttpRequest) {
            //    xmlhttp = new XMLHttpRequest();
            //    xmlhttp.onreadystatechange = state_Change;
            //    if (ns) {
            //        xmlhttp.open('GET', url, true);
            //        xmlhttp.send(null);
            //    }
            //    else {
            //        xmlhttp.open('POST', url, false);
            //        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            //        xmlhttp.send(reqQuery);
            //    }
            //} else if (window.ActiveXObject) {
            //    xmlhttp = new ActiveXObject('Microsoft.XMLHTTP');
            //    if (xmlhttp) {
            //        xmlhttp.onreadystatechange = state_Change;
            //        xmlhttp.open('POST', url, false);
            //        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            //        xmlhttp.send(reqQuery);
            //    }
            //}
        }
        //function state_Change() {
        //    if (parseInt(xmlhttp.readyState) == 4) {
        //        if (xmlhttp.status == 200) {
        //            SetBox(xmlhttp.responseText);
        //            gEvt = null;
        //            xPos = 0;
        //            yPos = 0;

        //        }
        //    }
        //}
        function GetResponseText() {
            if (g_oValidateXMLHttp.readyState == 4) {
                if (g_oValidateXMLHttp.responseText != null) {
                    g_sResponseText = g_oValidateXMLHttp.responseText;
                    SetBox(g_oValidateXMLHttp.responseText);
                                gEvt = null;
                                xPos = 0;
                                yPos = 0;
                }
            }
        }
        function SetBox(resText) {
            var evt = gEvt;
            if (!evt)
                return;
            if (yPos < (bheight / 2)) {
                box = document.getElementById('Tajax_tooltipObj');

                document.getElementById('Bajax_tooltipObj').style.display = "none";

                arr = document.getElementById('Tajax_tooltip_arrow');
                con = document.getElementById('Tajax_tooltip_content');

                con.innerHTML = resText;
                box.style.display = "";

                wbox = con.firstChild.offsetWidth;
                if (wbox > (bwidth - 50))
                    wbox = bwidth - 50;
                hbox = con.firstChild.offsetHeight;
                con.style.width = wbox;
                if ((xPos - wbox + 20) < 0) {
                    box.style.left = 10;
                    arr.style.width = xPos - 8;
                }
                else {

                    box.style.left = (xPos - wbox + 20)
                    arr.style.width = wbox - 20;
                }
                box.style.top = yPos;
                con.className = "ajax_tooltip_Tcontent";
                if (navigator.appName != "Netscape") {
                    con.style.width = '860px';
                    box.style.width = "";
                }
            }
            else {

                box = document.getElementById('Bajax_tooltipObj');

                document.getElementById('Tajax_tooltipObj').style.display = "none";

                arr = document.getElementById('Bajax_tooltip_arrow');
                con = document.getElementById('Bajax_tooltip_content');


                con.innerHTML = resText;
                // Added By purvaj on 25 sept 2008 for Firefox issue
                if (navigator.appName == "Netscape") {
                    //alert(1);
                    con.style.width = '505px';
                }
                // End addition Purvaj
                box.style.display = "";

                wbox = con.offsetWidth;
                hbox = con.offsetHeight;

                arr.className = "ajax_tooltip_BRarrow";

                if ((xPos - wbox + 18) < 0) {
                    box.style.left = 10;
                    arr.style.width = xPos - 10;

                }
                else {
                    box.style.left = xPos - wbox + 18;
                    arr.style.width = wbox - 18;

                }

                arr.style.height = hbox + 18;

                box.style.top = yPos - hbox - 18;
                con.className = "ajax_tooltip_Bcontent";
                if (navigator.appName != "Netscape") {
                    con.style.width = '860px';
                    box.style.width = "";
                }
            }
        }

        function CloseDiv() {
            if (document.getElementById('btnClose')) {
                document.getElementById('btnClose').parentNode.removeChild(document.getElementById('btnClose'));
            }

            document.getElementById('Bajax_tooltipObj').style.display = "none";
            document.getElementById('Tajax_tooltipObj').style.display = "none";
        }
    </script>
</body>
</html>
