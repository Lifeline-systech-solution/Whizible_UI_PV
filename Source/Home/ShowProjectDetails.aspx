<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ShowProjectDetails.aspx.vb" Inherits="PbNIT.ShowProjectDetails" %>

<!DOCTYPE html>
<html>
        <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <title></title>
<%--     <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="ProjectDetails.css" rel="stylesheet" />
<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>

    <style type="text/css">
        #tab-6 {
            display: none;
        }

        #tab-7 {
            display: none;
        }
         #tabLab-6 {
            display: none;
        }

        #tabLab-7 {
            display: none;
        }
        .divLabel {
            position: relative;
            top: -23px;
            left: 10px;
        }

        #container {
            text-align: center;
            margin: 20px;
        }

        h2 {
            color: #CCC;
        }

        a {
            text-decoration: none;
            color: #EC5C93;
        }

        .divLeft {
            position: relative;
            top: 1px;
            /*left:-145px;*/
            margin-left: 2px !important;
        }

        .divRight {
            position: relative;
            margin-left: 5px !important;
            top: 1px;
        }

        .bar-main-container {
            margin: 10px auto;
            width: 49%;
            height: 16px;
            /*-webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;*/
            font-family: sans-serif;
            font-weight: normal;
            font-size: 0.8em;
            color: #FFF;
            display: inline-block;
        }

        .wrap {
            padding: 8px;
        }

        .bar-percentage {
            float: left;
            /*background: rgba(0,255,0,0.13);*/
            /*-webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;*/
            padding: 9px 0px;
            width: 18%;
            height: 16px;
            display: none;
        }

        .bar-container {
            float: right;
            /*-webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;*/
            height: 22px;
            /*background: rgba(0,255,0,0.13);*/
            width: 100%;
            margin: 12px 0px;
            overflow: hidden;
        }

        .bar {
            float: left;
            /*background: #CCC;*/
            height: 100%;
            /*-webkit-border-radius: 10px 0px 0px 10px;
            -moz-border-radius: 10px 0px 0px 10px;
            border-radius: 10px 0px 0px 10px;*/
            -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
            filter: alpha(opacity=100);
            -moz-opacity: 1;
            -khtml-opacity: 1;
            opacity: 1;
        }

        /* COLORS */
        .azure {
            background: #38B1CC;
        }

        .emerald {
            background: #2CB299;
        }

        .violet {
            background: #8E5D9F;
        }

        .yellow {
            background: #EFC32F;
        }

        .red {
            background: #E44C41;
        }

        body {
            background: #f6eee4;
        }

        label {
            display: inline-block;
            max-width: 100%;
            margin-bottom: 5px;
            font-weight: 100 !important;
        }

        hr {
            margin-top: 2px;
            margin-bottom: 16px;
            border: 0;
            border-top: 1px solid #eee;
        }

        ul.tabs {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }

            ul.tabs li {
                /*float: left;*/
                margin: 0 .25em 0 0;
                padding: .25em .5em;
            }

                ul.tabs li a {
                    color: black;
                    text-decoration: none;
                }

                ul.tabs li.active {
                    background: gray;
                }

                    ul.tabs li.active a {
                        color: white;
                    }

        .clr {
            clear: both;
        }

        article {
            border-top: gray solid 1px;
            padding: 0 1em;
        }

        .tableQuick {
            border-bottom: 1px solid;
        }

            .tableQuick tr {
                border-bottom: 1px solid rgba(226, 221, 221, 0.61);
                /*border-style:double*/
                /*border:1px double black;*/
            }
        /*Added by Kiran for Loader 2/11/15*/
        #preloader {
            /*position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;*/
            /*border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;*/
            /* background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
            width: 90px;
            height: 84px;*/
            /*z-index: 99;
            height: 100%;*/
            /*background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
            opacity: 0.6;
            filter: alpha(opacity=40);*/
        }

        #fillDiv {
            /*opacity: 0.7;
            background-color: ghostwhite;*/
            /*DISPLAY: none;*/
            /*z-index: 100;
            left: 0px;
            visibility: visible;
            width: 100%;
            position: absolute;
            top: 0px;
            height: 100%;
            float: right;*/
        }
        /************** ADDED BY PUNEET M ON 17-12-2015, PURPOSE: CSS ADDED FOR TABLE *****************/
        div#MainDivSection {
            width: 50px;
            height: 140px;
            /*border: 1px solid black;*/
        }

        div.mousescroll {
            overflow: hidden;
        }

            div.mousescroll:hover {
                overflow-y: scroll;
            }

        ul {
            list-style-type: none;
        }

        .slimScrollDiv {
            border: 1px solid #ccc;
            margin: 10px;
        }
        /************** ENDED BY PUNEET M ON 17-12-2015, PURPOSE: CSS ADDED FOR TABLE *****************/
        .clsTabGraphTypeDDL {
            float: right;
        }

        .tab {
            line-height: 2 !important;
        }

            .tab:hover {
                cursor: pointer;
            }

        /************** ADDED BY PUNEET M ON 17-12-2015, PURPOSE: CSS ADDED FOR SCROLLBAR *****************/
        ::-webkit-scrollbar {
            width: 8px;
        }
        /* Track */
        ::-webkit-scrollbar-track {
            -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            -webkit-border-radius: 8px;
            border-radius: 8px;
        }
        /* Handle */
        ::-webkit-scrollbar-thumb {
            -webkit-border-radius: 5px;
            border-radius: 8px;
            /*background: rgba(255,0,0,0.8);*/
            background: #4F4F4F;
            -webkit-box-shadow: inset 0 0 6px #4F4F4F;
        }

            ::-webkit-scrollbar-thumb:window-inactive {
                background: #4F4F4F;
            }
        /************** ENDED BY PUNEET M ON 17-12-2015, PURPOSE: CSS ADDED FOR SCROLLBAR *****************/
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
        .progress {
            height: 20px;
            margin-bottom: 20px;
            overflow: hidden;
            background-color: #f5f5f5;
            border-radius: 0px !important;
            -webkit-box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
            box-shadow: inset 0 1px 2px rgba(0,0,0,.1);
        }
    </style>

    <!--------- DO NOT MODIFY BELOW JS CODE ----------->
    <!-- BELOW JS ADDED FOR SLIM SCROLLBAR [BY PUNEET M ON 17-12-2015] -->
    <script type="text/javascript">
        //Added By Vaijat K ON 22/09/2016 For Dynamic Theme

        var link = document.createElement("link");
        link.href = "../General/<%=CommonFunctions.Data.GetDataScalar("usp_get_StyleSheet " & Session("intUserID") & ",N'" & Session("LoginType") & "',0", True)%>";
        link.rel = "stylesheet";
        document.head.appendChild(link);
        //End Added By Vaijat K ON 22/09/2016 For Dynamic Theme

        (function ($) {
            jQuery.fn.extend({
                slimScroll: function (o) {

                    var ops = o;
                    //do it for every element that matches selector
                    this.each(function () {

                        var isOverPanel, isOverBar, isDragg, queueHide, barHeight,
                            divS = '<div></div>',
                            minBarHeight = 30,
                            wheelStep = 30,
                            o = ops || {},
                            cwidth = o.width || 'auto',
                            cheight = o.height || '250px',
                            size = o.size || '7px',
                            color = o.color || '#000',
                            position = o.position || 'right',
                            opacity = o.opacity || .4,
                            alwaysVisible = o.alwaysVisible === true;

                        //used in event handlers and for better minification
                        var me = $(this);

                        //wrap content
                        var wrapper = $(divS).css({
                            position: 'relative',
                            overflow: 'hidden',
                            width: cwidth,
                            height: cheight
                        }).attr({ 'class': 'slimScrollDiv' });

                        //update style for the div
                        me.css({
                            overflow: 'hidden',
                            width: cwidth,
                            height: cheight
                        });

                        //create scrollbar rail
                        var rail = $(divS).css({
                            width: '15px',
                            height: '100%',
                            position: 'absolute',
                            top: 0
                        });

                        //create scrollbar
                        var bar = $(divS).attr({
                            'class': 'slimScrollBar ',
                            style: 'border-radius: ' + size
                        }).css({
                            background: color,
                            width: size,
                            position: 'absolute',
                            top: 0,
                            opacity: opacity,
                            display: alwaysVisible ? 'block' : 'none',
                            BorderRadius: size,
                            MozBorderRadius: size,
                            WebkitBorderRadius: size,
                            zIndex: 99
                        });

                        //set position
                        var posCss = (position == 'right') ? { right: '1px' } : { left: '1px' };
                        rail.css(posCss);
                        bar.css(posCss);

                        //wrap it
                        me.wrap(wrapper);

                        //append to parent div
                        me.parent().append(bar);
                        me.parent().append(rail);

                        //make it draggable
                        bar.draggable({
                            axis: 'y',
                            containment: 'parent',
                            start: function () { isDragg = true; },
                            stop: function () { isDragg = false; hideBar(); },
                            drag: function (e) {
                                //scroll content
                                scrollContent(0, $(this).position().top, false);
                            }
                        });

                        //on rail over
                        rail.hover(function () {
                            showBar();
                        }, function () {
                            hideBar();
                        });

                        //on bar over
                        bar.hover(function () {
                            isOverBar = true;
                        }, function () {
                            isOverBar = false;
                        });

                        //show on parent mouseover
                        me.hover(function () {
                            isOverPanel = true;
                            showBar();
                            hideBar();
                        }, function () {
                            isOverPanel = false;
                            hideBar();
                        });

                        var _onWheel = function (e) {
                            //use mouse wheel only when mouse is over
                            if (!isOverPanel) { return; }

                            var e = e || window.event;

                            var delta = 0;
                            if (e.wheelDelta) { delta = -e.wheelDelta / 120; }
                            if (e.detail) { delta = e.detail / 3; }

                            //scroll content
                            scrollContent(0, delta, true);

                            //stop window scroll
                            if (e.preventDefault) { e.preventDefault(); }
                            e.returnValue = false;
                        }

                        var scrollContent = function (x, y, isWheel) {
                            var delta = y;

                            if (isWheel) {
                                //move bar with mouse wheel
                                delta = bar.position().top + y * wheelStep;

                                //move bar, make sure it doesn't go out
                                delta = Math.max(delta, 0);
                                var maxTop = me.outerHeight() - bar.outerHeight();
                                delta = Math.min(delta, maxTop);

                                //scroll the scrollbar
                                bar.css({ top: delta + 'px' });
                            }

                            //calculate actual scroll amount
                            percentScroll = parseInt(bar.position().top) / (me.outerHeight() - bar.outerHeight());
                            delta = percentScroll * (me[0].scrollHeight - me.outerHeight());

                            //scroll content
                            me.scrollTop(delta);

                            //ensure bar is visible
                            showBar();
                        }

                        var attachWheel = function () {
                            if (window.addEventListener) {
                                this.addEventListener('DOMMouseScroll', _onWheel, false);
                                this.addEventListener('mousewheel', _onWheel, false);
                            }
                            else {
                                document.attachEvent("onmousewheel", _onWheel)
                            }
                        }

                        //attach scroll events
                        attachWheel();

                        var getBarHeight = function () {
                            //calculate scrollbar height and make sure it is not too small
                            barHeight = Math.max((me.outerHeight() / me[0].scrollHeight) * me.outerHeight(), minBarHeight);
                            bar.css({ height: barHeight + 'px' });
                        }

                        //set up initial height
                        getBarHeight();

                        var showBar = function () {
                            //recalculate bar height
                            getBarHeight();
                            clearTimeout(queueHide);

                            //show only when required
                            if (barHeight >= me.outerHeight()) {
                                return;
                            }
                            bar.fadeIn('fast');
                        }

                        var hideBar = function () {
                            //only hide when options allow it
                            if (!alwaysVisible) {
                                queueHide = setTimeout(function () {
                                    if (!isOverBar && !isDragg) { bar.fadeOut('slow'); }
                                }, 1000);
                            }
                        }

                    });

                    //maintain chainability
                    return this;
                }
            });

            jQuery.fn.extend({
                slimscroll: jQuery.fn.slimScroll
            });

        })(jQuery);

        // [MAIN CALL] Scrollbar Called to the DIV Element
        $('#MainDivSection').slimscroll({
            color: '#00f',
            size: '10px',
            width: '50px',
            height: '150px'
        });
    </script>
    <!-- END OF JS ADDED FOR SLIM SCROLLBAR [BY PUNEET M ON 17-12-2015] -->

</head>
<body id="showProjectDetailsBody" onload="" style="overflow: auto;">
    <form id="form1" runat="server">
        <div style="text-align: center;">
            <b style="font-size: large;">Project Details</b>

        </div>
        <div>
            <div id="MainDivSection" class="mousescroll" style="width: 96%; margin-left: auto; margin-right: auto;">
                <hr style="height: 1px; background-color: #2a6496" />
                <%PlotProjectInformation()%>
                <%--<hr  style ="height:1px;background-color:#2a6496"/>--%>
            </div>
        </div>
        <%--<div id='preloader'></div>
        <div id='fillDiv'></div>--%>
    </form>

    <script type="text/javascript">
        /*********      Global variable Declaration Starts here       **********/
        var arrGraph = [];
        var arrGraphTypeID = [];
        var arrGraphTypeVal = [];
        var i = 0; var sbhtml = '';
        var reportPath = "<%=HttpUtility.JavaScriptStringEncode(strReportPath)%>"
        var logerrorpath = "<%=HttpUtility.JavaScriptStringEncode(strLogPath)%>";
        var logo = "<%=HttpUtility.JavaScriptStringEncode(strLogo)%>";
        /*********      Global variable Declaration Ends Here      **********/

        $(document).ready(function () {
            // $("#preloader").fadeIn("slow");
            $("#MainDivSection").height(parent.$("#ViewMain").height() - 50);
            document.getElementById("MainDivSection").style.height = window.innerHeight - 30 + 'px'
            ChangeAttribute(document.getElementById("cboAttributes"));
            //ajaxSchedule();
           
                
        });
        //window.onload = function () {
        //    //setTimeout(function () {
        //    //    LoadProjectDetail();
        //    //}, 2500);
        //}
        window.onresize = function () {
            document.getElementById("MainDivSection").style.height = window.innerHeight - 30 + 'px'
        }
        // Tab On_Click Function Starts Here
        function assignID(objTab, ind, ProjectID) {
            var cnt = document.getElementById("hdnTabsCount").value;
            for (var i = 0; i < cnt; i++) {
                $("#tab-" + i).height("34"); $(".content" + i).hide();
            }

            if ($("#tab-" + ind).height() == 34) { $("#tab-" + ind).height("360"); $(".content" + ind).show(); }
            else { $("#tab-" + ind).height("34"); $(".content" + ind).hide(); }

            $.ajax({
                type: "POST",
                url: "ShowProjectDetails.aspx/GetGraphTypeDropDown",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {},
                success: function (results) {
                    sbhtml += "<select id='ddl " + ind + "' style='margin-top: 5px;' onchange='ChangeGraphType(this.value)' style='float:right;'>";
                    //sbhtml += "<option value=0>Select Graph type</option>";
                    $.each(JSON.parse(results.d), function (id, val) {
                        if (id != 0){
                            if(val.GraphTypeID == 15 || val.GraphTypeID == 12 || val.GraphTypeID == 10 || val.GraphTypeID == 11){
                            }
                            else{
                                sbhtml += "<option value='" + val.GraphTypeID + "'>" + val.UFGraphTypeName + "</option>";
                            }
                        }
                        i++;
                    });
                    sbhtml += "</select>";
                    document.getElementById("TabGraphTypeDDL" + ind).innerHTML = sbhtml;
                    sbhtml = "";

                    //$.ajax({
                    //    type: "POST",
                    //    url: "ShowProjectDetails.aspx/GetScheduleVariance",
                    //    contentType: "application/json; charset=utf-8",
                    //    dataType: "json",
                    //    data: '{ "ProjectID":  '+ProjectID+' }',
                    //    success: function (results) {
                    //        //alert(JSON.stringify(results));
                    //        //DrawBarChart(results.d, ind);
                    //    } ByVal DashboardID As Long, ByVal UserID As Long, ByVal DivHeight As Integer, ByVal SectionName As String
                    //});

                    var DashboardID = "20003";
                    var UserID = "";
                    var DivHeight = "";
                    var SectionName = "";
                    //$.ajax({
                    //    type: "POST",
                    //    url: "ShowProjectDetails.aspx/DisplayNonNeedleGraphs",
                    //    contentType: "application/json; charset=utf-8",
                    //    dataType: "json",
                    //    data: '{ "DashboardID":  ' + DashboardID + ',"UserID":  ' + UserID + ', "DivHeight": ' + DivHeight + ', "SectionName": ' + SectionName + ' }',
                    //    success: function (results) {
                    //        alert("success");

                    //    }
                    //});
                    //ValidateResourceDate_XML("ShowProjectDetails.aspx?Mode=Get&DashboardID=20018")

                    document.getElementById("hdnTabID").value = ind;
                    document.getElementById("ddl " + ind).value=3;
                    ChangeGraphType(3);
                }
            });
        }
        function assignID1(objTab, ind, ProjectID) {
            var cnt = document.getElementById("hdnTabsCount").value;
            for (var i = 0; i < cnt; i++) {
                $("#tab-" + i).height("34"); $(".content" + i).hide();
            }

            if ($("#tab-" + ind).height() == 34) { $("#tab-" + ind).height("360"); $(".content" + ind).show(); }
            else { $("#tab-" + ind).height("34"); $(".content" + ind).hide(); }

            $.ajax({
                type: "POST",
                url: "ShowProjectDetails.aspx/GetGraphTypeDropDown",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: {},
                success: function (results) {
                    sbhtml += "<select id='ddl " + ind + "' style='margin-top: 5px;' onchange='ChangeGraphType(this.value)' style='float:right;'>";
                    //sbhtml += "<option value=0>Select Graph type</option>";
                    $.each(JSON.parse(results.d), function (id, val) {
                        if (id != 0) {
                            if (val.GraphTypeID == 15 || val.GraphTypeID == 12 || val.GraphTypeID == 10 || val.GraphTypeID == 11) {
                            }
                            else {
                                sbhtml += "<option value='" + val.GraphTypeID + "'>" + val.UFGraphTypeName + "</option>";
                            }
                        }
                        i++;
                    });
                    sbhtml += "</select>";
                    document.getElementById("TabGraphTypeDDL" + ind).innerHTML = sbhtml;
                    sbhtml = "";

                    //$.ajax({
                    //    type: "POST",
                    //    url: "ShowProjectDetails.aspx/GetScheduleVariance",
                    //    contentType: "application/json; charset=utf-8",
                    //    dataType: "json",
                    //    data: '{ "ProjectID":  '+ProjectID+' }',
                    //    success: function (results) {
                    //        //alert(JSON.stringify(results));
                    //        //DrawBarChart(results.d, ind);
                    //    } ByVal DashboardID As Long, ByVal UserID As Long, ByVal DivHeight As Integer, ByVal SectionName As String
                    //});

                    var DashboardID = "20003";
                    var UserID = "";
                    var DivHeight = "";
                    var SectionName = "";
                    //$.ajax({
                    //    type: "POST",
                    //    url: "ShowProjectDetails.aspx/DisplayNonNeedleGraphs",
                    //    contentType: "application/json; charset=utf-8",
                    //    dataType: "json",
                    //    data: '{ "DashboardID":  ' + DashboardID + ',"UserID":  ' + UserID + ', "DivHeight": ' + DivHeight + ', "SectionName": ' + SectionName + ' }',
                    //    success: function (results) {
                    //        alert("success");

                    //    }
                    //});
                    //ValidateResourceDate_XML("ShowProjectDetails.aspx?Mode=Get&DashboardID=20018")

                    document.getElementById("hdnTabID").value = ind;
                    document.getElementById("ddl " + ind).value = 3;
                    ChangeGraphType(3);
                }
            });
        }
        // Tab On_Click Function Ends Here

        // Attribute On_Change Event
        function ChangeAttribute(AttributeID) {
            //Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
            if(AttributeID != null)
            {
                //End of Added By Aniruddh Gujar on 17-May-2016 Purpose::To remove Quick View for Agile Project Type
                snapshotCount = 1;
                var Attribute = AttributeID.options[AttributeID.selectedIndex].text;
                if (Attribute == "Milestones")
                    Attribute = "MileStone"
                else if (Attribute == 'Deliverables')
                    Attribute = "Deliverable"
                else if (Attribute == 'Sub Projects')
                    Attribute = "SubProject"
                ValidateResourceDate_XML("ShowProjectDetails.aspx?projectId=" + <%=strProjectID%> +"&Mode=Select&AttributeID=" + Attribute + "&TabID=0");
                var i = document.getElementById("hdnTabID").value
                if (i != "") {
                    var GraphTypeID = document.getElementById("ddl " + i).value;
                    //document.getElementById("frameGraph0").src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018";
                    if (GraphTypeID != 0) {
                        document.getElementById("frameGraph" + i).src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018&GraphTypeID=" + GraphTypeID + "&ProjectID=" + <%=strProjectID%> + "&TabID=" + i + "&Attribute=" + Attribute  + "&Snapshot=" + snapshotCount;
                   
                    }
                }
                ajaxSchedule()
                //document.getElementById("frameGraph").src = "../CDB/CDB_Main.aspx?FromWhere=ADMIN&DashboardID=20018";
            }
        }

        // Grap-type On_Change Event
        function ChangeGraphType(GraphTypeID) {
            var Attribute = document.getElementById("cboAttributes").options[document.getElementById("cboAttributes").selectedIndex].text;
            if (Attribute == "Milestones")
                Attribute = "MileStone"
            else if (Attribute == 'Deliverables')
                Attribute = "Deliverable"
            else if (Attribute == 'Sub Projects')
                Attribute = "SubProject"
            var i = document.getElementById("hdnTabID").value
            
            if (document.getElementById("hdnTabID").value == 0) {

                ValidateResourceDate_XML("ShowProjectDetails.aspx?Mode=Update&DashboardID=20018&GraphTypeID=" + GraphTypeID);
                //ValidateResourceDate_XML("ShowProjectDetails.aspx?Mode=Get&DashboardID=20018");
                //document.getElementById("frameGraph" + i).src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018";
                //document.getElementById("frameGraph").src = "../CDB/CDB_Main.aspx?FromWhere=ADMIN&DashboardID=20018";
            }
            else {

            }
            if (GraphTypeID != 0)
                document.getElementById("frameGraph" + i).src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018&GraphTypeID=" + GraphTypeID + "&ProjectID=" + <%=strProjectID%> + "&TabID=" + i + "&Attribute=" + Attribute  + "&Snapshot=" + snapshotCount;
            else
                document.getElementById("frameGraph" + i).src = "";
        }
        function ajaxSchedule() {
            var Attribute = document.getElementById("cboAttributes").options[document.getElementById("cboAttributes").selectedIndex].text;
            if (Attribute == "Milestones")
                Attribute = "MileStone"
            else if (Attribute == 'Deliverables')
                Attribute = "Deliverable"
            else if (Attribute == 'Sub Projects')
                Attribute = "SubProject"
            var strUrl;
            var param;
            strUrl = "ShowProjectDetails.aspx/GetScheduleVariancePercentage"
            param = JSON.stringify({ intProjectID: '<%=strProjectID%>', strType: Attribute })
            ajaxCallForall(strUrl, param, 0);

           
            strUrl = "ShowProjectDetails.aspx/SelectEffortVariance"
            param = JSON.stringify({ projectID: '<%=strProjectID%>', AttributeID: Attribute,userID:'<%=Session("intUserID").ToString()%>' })
            ajaxCallForall(strUrl, param, 1);


           
            strUrl = "ShowProjectDetails.aspx/SelectOnTimeDelivery"
            param = JSON.stringify({ projectId: '<%=strProjectID%>',userid:'<%=Session("intUserID").ToString()%>' })
            ajaxCallForall(strUrl, param, 2);
   

       
            strUrl = "ShowProjectDetails.aspx/SelectDefectDensity"
            param = JSON.stringify({ projectId: '<%=strProjectID%>' ,userid:'<%=Session("intUserID").ToString()%>'})
            ajaxCallForall(strUrl, param, 3);
      

       
            strUrl = "ShowProjectDetails.aspx/SelectReworkHours"
            param = JSON.stringify({ projectId: '<%=strProjectID%>',userID:'<%=Session("intUserID").ToString()%>' })
            ajaxCallForall(strUrl, param, 4);
    
           
            strUrl = "ShowProjectDetails.aspx/SelectNoOfDeliverablesOpen"
            param = JSON.stringify({ projectId: '<%=strProjectID%>', userID:'<%=Session("intUserID").ToString()%>'})
            ajaxCallForall(strUrl, param, 5);
           
            strUrl = "ShowProjectDetails.aspx/SelectNoOfDeliverablesOpen"
            param = JSON.stringify({ projectId: '<%=strProjectID%>', userID:'<%=Session("intUserID").ToString()%>' })
            ajaxCallForall(strUrl, param, 6);
      

       
            strUrl = "ShowProjectDetails.aspx/SelectNoOfDeliverablesClosed"
            param = JSON.stringify({ projectId: '<%=strProjectID%>' })
            ajaxCallForall(strUrl, param, 7);
    
       
            strUrl = "ShowProjectDetails.aspx/SelectScheduleSlippageOnTask"
            param = JSON.stringify({ projectId: '<%=strProjectID%>', AttributeID: Attribute,userID:'<%=Session("intUserID").ToString()%>'})
            ajaxCallForall(strUrl, param, 8);
        
        }

        /*function ajaxCallForall(url, param, i) {
            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (results) {
                    debugger;
                    if (results.d == "") {
                        Percentage = 0;
                    }
                    else {
                        Percentage = results.d;
                    }
                    if (i == 5)
                        document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + ")";
                    else
                        document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                    //Percentage = document.getElementById("lbl0").innerHTML.split("%")[0];
                    //Percentage = Percentage.split("(");
                    //Percentage = parseFloat(Percentage[1]);
                    Percentage = parseFloat(Percentage);
                    $("#bar-5" + i).css("background-color","");
                    $("#bar-5" + i).removeAttr("class");
                    $("#anc" + i).find(".progress").css("background-color", "")
                    if (Percentage < 0) {
                        //$("#bar-5" + i).append('<td>' + Percentage + '</td>');
                        $("#bar-5" + i).addClass("progress-bar progress-bar-success progress-bar-striped");
                    
                    }
                    else if (Percentage > 5) {
                        if (Percentage > 100) {
                            // alert(Percentage)
                            Percentage = 0;
                        }
                        else {
                            Percentage = 100 - Percentage;
                        }
                        $("#bar-5" + i).css("background-color", "#F5F5F5");
                        $("#anc" + i).find(".progress").addClass("progress-bar-striped")

                        $("#anc" + i).find(".progress").css("background-color", "#D9534F")

                        $("#bar-5" + i).addClass("progress-bar progress-bar-danger progress-bar-striped");
                    }
                    else if (Percentage >= -5 && Percentage <= 5)
                    {
                        if (Percentage == 0) {
                            Percentage = 100;
                            $("#bar-5" + i).css("background-color", "#F5F5F5");
                            $("#anc" + i).find(".progress").css("background-color", "#F5F5F5")
                                
                            //$("#bar-5" + i).addClass("progress-bar progress-bar-info progress-bar-striped");
                        }
                        else {
                            if (Percentage > 0) {

                                Percentage = 100 - Percentage;

                                $("#bar-5" + i).css("background-color", "#F5F5F5");
                                $("#anc" + i).find(".progress").addClass("progress-bar-striped")

                                $("#anc" + i).find(".progress").css("background-color", "#F0AD4E")

                                $("#bar-5" + i).addClass("progress-bar progress-bar-warning progress-bar-striped");
                            }
                            else {

                                $("#bar-5" + i).addClass("progress-bar progress-bar-warning progress-bar-striped");
                            }
                        }


                    }
               
                    $("#bar-5" + i).css("width", Math.abs(Percentage) + "%");
             
                }
            });
        }*/
        
        function ajaxCallForall(url, param, i) {
            $.ajax({
                type: "POST",
                url: url,
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (results) {
                   // debugger;
                    if (results.d == "") {
                        Percentage = 0;
                    }
                    else {
                        Percentage = results.d;
                    }
                    if (i == 5)
                        document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + ")";
                    else
                        document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                    if (i == 5)
                        document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + ")";
                    else
                        document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + "%)";

                    //Percentage = document.getElementById("lbl0").innerHTML.split("%")[0];
                    //Percentage = Percentage.split("(");
                    //Percentage = parseFloat(Percentage[1]);
                    Percentage = parseFloat(Percentage);
                    $("#bar-5" + i).css("background-color", "");
                    $("#bar-5" + i).removeAttr("class");
                    $("#bar-51" + i).css("background-color", "");
                    $("#bar-51" + i).removeAttr("class");
                    $("#cap1" + i).css("display", "block");
                    $("#cap" + i).css("display", "block");

                    //$("#anc" + i).find(".progress").css("background-color", "")
                    if (Percentage < 0) {
                        //$("#bar-5" + i).append('<td>' + Percentage + '</td>');
                        $("#bar-5" + i).addClass("progress-bar progress-bar-success progress-bar-striped");
                        $("#bar-5" + i).css("width", Math.abs(Percentage) + "%");
                        //$("#bar-51" + i).removeAttr("class");
                        //$("#cap1" + i).html("");
                        $("#cap1" + i).css("display", "none");
                        $("#anc" + i).find(".progress").css("border-radius", "0px");
                        
                       // $("#bar-51" + i).removeAttr("label");
                        //document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + ")";

                    }
                    else if (Percentage > 5) {
                        //if (Percentage > 100) {
                        //    // alert(Percentage)
                        //    Percentage = 0;
                        //}
                        //else {
                        //    Percentage = 100 - Percentage;
                        //}
                       // $("#bar-51" + i).css("background-color", "#F5F5F5");
                        //$("#anc" + i).find(".progress").addClass("progress-bar-striped")

                        //$("#anc" + i).find(".progress").css("background-color", "#D9534F")

                        $("#bar-51" + i).addClass("progress-bar progress-bar-danger progress-bar-striped");
                        $("#bar-51" + i).css("width", Math.abs(Percentage) + "%");
                        //$("#cap" + i).html("");
                        $("#cap" + i).css("display", "none");
                        $("#anc" + i).find(".progress").css("border-radius", "0px");
                        //document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                    }
                    else if (Percentage >= -5 && Percentage <= 5) {
                        if (Percentage == 0) {
                            //Percentage = 100;
                           // $("#bar-51" + i).css("background-color", "#F5F5F5");
                            //$("#anc" + i).find(".progress").css("background-color", "#F5F5F5")
                            $("#bar-51" + i).css("width", Math.abs(Percentage) + "%");
                            //$("#cap" + i).html("");
                            $("#cap" + i).css("display", "none");
                            $("#anc" + i).find(".progress").css("border-radius", "0px");
                            //document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                            //$("#bar-5" + i).addClass("progress-bar progress-bar-info progress-bar-striped");
                        }
                        else {
                            if (Percentage > 0) {

                               // Percentage = 100 - Percentage;

                              //  $("#bar-51" + i).css("background-color", "#F5F5F5");
                                //$("#anc" + i).find(".progress").addClass("progress-bar-striped")

                                //$("#anc" + i).find(".progress").css("background-color", "#F0AD4E")

                                $("#bar-51" + i).addClass("progress-bar progress-bar-warning progress-bar-striped");
                                $("#bar-51" + i).css("width", Math.abs(Percentage) + "%");
                                //$("#cap" + i).html("");
                                $("#cap" + i).css("display", "none");
                                $("#anc" + i).find(".progress").css("border-radius", "0px");
                                //document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                            }
                            else {

                                $("#bar-51" + i).addClass("progress-bar progress-bar-warning progress-bar-striped");
                                $("#bar-51" + i).css("width", Math.abs(Percentage) + "%");
                                //$("#cap" + i).html("");
                                $("#cap" + i).css("display", "none");
                                $("#anc" + i).find(".progress").css("border-radius", "0px");
                                //document.getElementById("lbl1" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
                            }
                        }


                    }

                    //$("#bar-5" + i).css("width", Math.abs(Percentage) + "%");

                }
            });
        }

        
        //// Body On_Load event starts here
        //function LoadProjectDetail() {
        //    //ajaxSchedule(); 
        //    //$("#preloader").fadeOut("slow");
        //    //$("#fillDiv").fadeOut("slow");
        //    //var myOption = "<option>Select Attribute</option>";
        //    var index = 1;
        //    //$(myOption).insertBefore("#cboAttributes option:nth-child(" + index + ")");
        //    document.getElementById("cboAttributes").selectedIndex = "0";
        //    $("#cboAttributes").css("margin-right", "10px");

        //    var cnt = document.getElementById("hdnTabsCount").value;
        //    var Percentage = 0;
        //    var i;

        //    //for (i = 0; i < cnt; i++) {
        //    //    //alert("#anc" + i + " " + $("#anc" + i));
        //    //    if (i != 0) {
        //    //        Percentage = 50 + (i * 8);
        //    //        if (Percentage <= 50) {
        //    //            //$("#anc" + i).css("background", "-webkit-linear-gradient(left, #F9B653 " + Percentage + "%, white " + Percentage + "%)");
        //    //            document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
        //    //        }
        //    //        else if (Percentage > 50 && Percentage <= 100) {
        //    //            //$("#anc" + i).css("background", "-webkit-linear-gradient(left, #6889EA " + Percentage + "%, white " + Percentage + "%)");
        //    //            document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
        //    //        }
        //    //        else if (Percentage > 100) {
        //    //            //$("#anc" + i).css("background", "-webkit-linear-gradient(left, #DC3333 " + Percentage + "%, white " + Percentage + "%)");
        //    //            document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
        //    //        }
        //    //    }

        //    //    if (i == 8) {
        //    //        Percentage = -50;

        //    //    }
        //    //    else if (i == 7)
        //    //    {
        //    //        Percentage = 4;
        //    //        document.getElementById("lbl" + i).innerHTML = "&nbsp;(" + Percentage + "%)";
        //    //    }


        //    //}
        //}
        // Body On_Load event Ends here
        var snapshotCount = 1;
        //Save as SnapShot Click Event
        function f_SaveSnapshot() {
            var objForm = document.getElementById("form1")
         
            
            //alert("Ajaxcall for save as snapshot");
            var Attribute = document.getElementById("cboAttributes").options[document.getElementById("cboAttributes").selectedIndex].text;
            if (Attribute == "Milestones")
                Attribute = "MileStone"
            else if (Attribute == 'Deliverables')
                Attribute = "Deliverable"
            else if (Attribute == 'Sub Projects')
                Attribute = "SubProject"
            var i = document.getElementById("hdnTabID").value;

            //Added By Bharat Tekade on 20th-May-2016 for give an alert if snapshot is not taken to view the report
            var chkFlag = false;
            $.ajax({
                type: "POST",
                url: "ShowProjectDetails.aspx/CheckSnapshotTaken",
                data: JSON.stringify({ ProjectID: '<%=strProjectID%>' }),  //,path:reportPath ,errorPath:logerrorpath,custLogo:logo
                contentType: "application/json;charset-utf=8",
                dataType: "json",
                async:false,
                success: function (result) {
                    if (result.d == 'SnapshotNotTaken') {
                        alert('Please take the snapshot at Overall Schedule page before taking the Report ');
                        chkFlag = true;
                    }
                },
                error: function () {

                }
            });
            if (chkFlag == true)
                return;
            //End of Added By Bharat Tekade on 20th-May-2016 for give an alert if snapshot is not taken to view the report

            if (confirm("Are you sure, want to view the report?")) {
            //if (i != "") {
               
            //        if (snapshotCount <= 3){
                       
            //            if (snapshotCount == 3){
            //                snapshotCount =3;
            //            }
            //            else{
            //                snapshotCount = snapshotCount + 1
            //            }
                       
                       // ValidateResourceDate_XML("ShowProjectDetails.aspx?Mode=Snapshot&AttributeID=" + Attribute + "&SnapshotCount=" + snapshotCount + "&projectId=" + <%=strProjectID%>);
                       // var GraphTypeID = document.getElementById("ddl " + i).value;
                        //document.getElementById("frameGraph0").src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018";
                      //  if (GraphTypeID != 0) {
                      //      document.getElementById("frameGraph" + i).src = "../Home/ShowProjectDetailGraph.aspx?FromWhere=ADMIN&DashboardID=20018&GraphTypeID=" + GraphTypeID + "&ProjectID=" + <%=strProjectID%> + "&TabID=" + i + "&Attribute=" + Attribute + "&Snapshot=" + snapshotCount;
                      //      $.ajax({
                      //          type:"POST",
                       //         url:"ShowProjectDetails.aspx/ShowReport",
                      //          data:JSON.stringify({TabID:i,userID:'<%=Session("intUserID")%>',attribute:Attribute}),  //,path:reportPath ,errorPath:logerrorpath,custLogo:logo
                      //          contentType:"application/json;charset-utf=8",
                       //         dataType:"json",
                      //          success:function(result){
                      //              window.open("../CRW/CRW_ReportExport.aspx?FileName=" + result.d);
                     //           },
                     //           error:function(){
                     ///               alert("error");
                     //           }
                     //       })
                     //   }
                    //}
               // }
            
           // else{
                i="all";
                $.ajax({
                    type:"POST",
                    url:"ShowProjectDetails.aspx/ShowReport",
                    data:JSON.stringify({TabID:i,userID:'<%=Session("intUserID").ToString()%>',attribute:Attribute}),  //,path:reportPath ,errorPath:logerrorpath,custLogo:logo
                    contentType:"application/json;charset-utf=8",
                    dataType:"json",
                    success:function(result){
                        window.open("../CRW/CRW_ReportOutput.aspx?FileName=" + result.d);
                    },
                    error:function(){
                        alert("error");
                    }
                })
            }
            //}
        }
       

        var strResult;
        // AjaxCall using XMLHttpRequest starts here
        function ValidateResourceDate_XML(strUrl) {

            // TO SEE IF WE ARE RUNNING IN IE 
            var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
            {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            else {
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                        xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                }
            }
            return strResult;
        }
        function TaskValidation_state_change() {
            var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
            if (g_objXHttp.readyState == 4) {
                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {
                    //if (window.ActiveXObject)
                    if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);
                    }
                        // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                            xmlDoc.load(g_objXHttp.responseXML);
                    }
                    //Save the Result in a Global variable
                    strResult = g_objXHttp.responseText;

                }
            }
        }
        // AjaxCall using XMLHttpRequest Ends here

        // Function to Check Browser-Type Starts Here
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
        function GetPercentage(divID) {
            $('' + divID + ' .bar-percentage[data-percentage]').each(function () {
                var progress = $(this);
                var percentage = Math.ceil($(this).attr('data-percentage'));
                for (var countNum = 0; countNum <= percentage; countNum++) {
                    progress.siblings().children().css('width', countNum + '%');
                }

                //    $({ countNum: 0 }).animate({ countNum: percentage }, {
                //        duration: 2000,
                //        easing: 'linear',
                //        step: function () {
                //            debugger;
                //            // What todo on every count
                //            var pct = '';
                //            if (percentage == 0) {
                //                pct = Math.floor(this.countNum) + '%';
                //            } else {
                //                pct = Math.floor(this.countNum + 1) + '%';
                //            }
                //            //progress.text(pct) &&
                //            progress.siblings().children().css('width', pct);
                //        }
                //    });
            });
        }
        // Function to Check Browser-Type Ends Here
    </script>

</body>
</html>
