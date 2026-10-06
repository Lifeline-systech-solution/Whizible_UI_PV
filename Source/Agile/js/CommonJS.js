/// <reference path="../../../responsive/jquery/jquery-2.1.3.min.js" />





//Added by Sagar N on 12-Apr-2019 Purpose:: Issue ID 11993
var opDateFormat = '';
//End of Added by Sagar N on 12-Apr-2019 Purpose:: Issue ID 11993
$(document).ready(function () {

    //Added by Sagar N on 12-Apr-2019 Purpose:: Issue ID 11993
    try {
        opDateFormat = getInputDateFormatValue();
    }
    catch (ex) { }
    //End of Added by Sagar N on 12-Apr-2019 Purpose:: Issue ID 11993

    SetWidthHeight();
    //$('#add-btn').on('click', function () {
    //    debugger;
    //    var currentID = $('#divGrid .inner').length + 1;
    //    var inner = $('<div class="inner"><div class="col-lg-12 col-md-12 col-sm-12 col-xs-12"><div class="scrum-grid" ><div class="scrum-title collapse fade in"><i class="fa fa-image icon" aria-hidden="true"></i><div><p class="drag-text"><i class="fa fa-hand-o-up drag-handler" aria-hidden="true"></i>Drag task between list</p></div></div><div class="scrum-content"><center><div class="input-box" style="background-color:transparent"><input type="text" id="txtNewStage" style="" class="input-box-p"  onfocusout="AddNewStage_Onclick()" placeholder="Enter Stage Name"/></div></center><h5></h5></div><div id="connected"><div class="list divDraggable" ></div></div></div></div></div>')
    //       .clone()

    //       .attr('id', 'innder-' + currentID)
    //       .text(inner)
    //       .appendTo('#table');
    //    $('#innder-' + currentID).insertAfter("#innder-2");

    //    setTimeout(function () {
    //        $('#innder-' + currentID).addClass('highlight')
    //    });

    //    setTimeout(function () {
    //        $('#innder-' + currentID).removeClass('highlight');
    //    }, 3000);


    //    $(".arrow-to-display").css("cursor", "pointer");
    //    $(".divDraggable [draggable='true']").sortable({
    //        connectWith: ".divDraggable",
    //        helper: 'clone',
    //        activate: function (ev, ui) {

    //        }
    //    });
    //});
    AutoResizeTextArea();
    var clicked = false, clickY;
    $(window).mousemove(function (e) {
        clicked && updateScrollPos(e);
    });
    $(window).mouseup(function () {
        clicked = false;
        $('#divUserStroryDetails').css('cursor', 'auto');
    });
    $('#divUserStroryDetails').mousedown(function (e) {
        clicked = true;
        clickY = e.pageY + $('#divUserStroryDetails').scrollTop();
    });
    var updateScrollPos = function (e) {
        $('#divUserStroryDetails').css('cursor', 's-resize');
        $('#divUserStroryDetails').scrollTop(clickY - e.pageY);
        e.preventDefault();
    }
    //if (window.addEventListener) window.addEventListener('DOMMouseScroll', wheel, false);
    //window.onmousewheel = document.onmousewheel = wheel;

    //function wheel(event) {
    //    var delta = 0;
    //    if (event.wheelDelta) delta = event.wheelDelta / 50;
    //    else if (event.detail) delta = -event.detail / 3;

    //    handle(delta);
    //    if (event.preventDefault) event.preventDefault();
    //    event.returnValue = false;
    //}

    //function handle(delta) {
    //    var time = 1000;
    //    var distance = 300;

    //    $('#divUserStroryDetails').stop().animate({
    //        scrollTop: $(window).scrollTop() - (distance * delta)
    //    }, time);
    //}
})

function SetWidthHeight() {
    //debugger;
    // $("#divMain").css("height", window.innerHeight - 100 + 'px');
    $("#divGrid").css("height", window.innerHeight - 80 + 'px');
    $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');
    //$(".Main").css("width", "100%");
    //$(".Main").css("height", window.innerHeight - 80 + 'px');
    //commented by kashish for UI change
    //$("#divProductBacklog_Body").css("height", (window.innerHeight / 1.5) - 30 + 'px');
    if ($(window).width() > 768) {
        $(".divDraggable1").css("min-height", window.innerHeight - 80 + 'px');
        $(".divDraggable1").css("height", '100%');
        //$(".Main").css("height", window.innerHeight - 80 + 'px');
        $(".divDraggable1").css("width", (window.innerWidth / 3) - 35 + 'px');
    }
    else {
        $(".divDraggable1").css("min-height", '');
        $(".divDraggable1").css("height", '');
        $(".Main").css("height", '');
        $(".divDraggable1").css("width", '100%');
    }

    $(".panel").hover(function () {
        $(this).find(".view").css("display", "block");
        //$(this).css("background-color", "#f5f5f5")
    }, function () {
        $(this).find(".view").css("display", "");
        $(this).css("background-color", "")
    })


    $(".divDraggable").sortable({
        connectWith: ".divDraggable",
        placeholder: "ui-state-highlight",
        activate: function (ev, ui) {
            var display = $("#icnShow").parent().parent().css("display");
            if (display == "block") {
                $(".divDraggable").each(function (id, val) {
                    if ($(this).css("display") == "none") {
                        $(this).css("display", "")
                        $(this).css("visibility", "hidden")
                    }
                })
            }
            //    $("#icnShow").click();
        },
        update: function (event, ui) {
            // debugger;
            var struserStoryIDs = ""
            $(ui.item).parent().find(".panel").each(function (id, val) {
                if (struserStoryIDs == "") {
                    struserStoryIDs = $(this).find("#lblUserStory").html();
                    //struserStoryIDs = $("#hdnUSnew").val();
                    //struserStoryIDs = $(this).find("#hdnUSnew").val();
                    // alert(struserStoryIDs);
                }
                else {
                    struserStoryIDs += "," + $(this).find("#lblUserStory").html();
                    // struserStoryIDs += "," + $("#hdnUSnew").val();
                    // struserStoryIDs += "," + $(this).find("#hdnUSnew").val();
                }
            })

            var strResult = ajaxCall("frmProductBacklog.aspx/ChangeCategory", "POST", "application/json", "json", JSON.stringify({ strCategoryID: $(ui.item).parent().attr("id"), strUserStoryID: $(ui.item).find("#lblUserStory").html(), strUserStoryIDs: struserStoryIDs }))

            if (strResult != undefined) {
                if (strResult.d == "1") {
                    //alert("Saved");
                    //alert(strResult.d);
                    //RefreshGrid();
                    var UserStoryID = "";
                    var url = "frmProductBacklog.aspx/RefreshGrid";
                    var data = JSON.stringify({ UserStoryID: "" });
                    var strResult1 = ajaxCall(url, "POST", "application/json", "json", data);
                    document.getElementById("divGrid").innerHTML = strResult1.d;
                    $(".Outerdiv").css("height", window.innerHeight - 150 + 'px');
                    $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
                    $(".adjustheight").css("height", window.innerHeight - 220 + 'px');

                    $("#divGrid").css("height", window.innerHeight - 80 + 'px');
                    $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');
                    //$(".Main").css("width", "100%");
                    //$(".Main").css("height", window.innerHeight - 80 + 'px');
                    //commented by kashish for UI change
                    //$("#divProductBacklog_Body").css("height", (window.innerHeight / 1.5) - 30 + 'px');
                    if ($(window).width() > 768) {
                        $(".divDraggable1").css("min-height", window.innerHeight - 80 + 'px');
                        $(".divDraggable1").css("height", '100%');
                        //$(".Main").css("height", window.innerHeight - 80 + 'px');
                        $(".divDraggable1").css("width", (window.innerWidth / 3) - 35 + 'px');
                    }
                    else {
                        $(".divDraggable1").css("min-height", '');
                        $(".divDraggable1").css("height", '');
                        $(".Main").css("height", '');
                        $(".divDraggable1").css("width", '100%');
                    }

                    $(".panel").hover(function () {
                        $(this).find(".view").css("display", "block");
                        //$(this).css("background-color", "#f5f5f5")
                    }, function () {
                        $(this).find(".view").css("display", "");
                        $(this).css("background-color", "")
                    })


                    SetWidthHeight();



                    // alert(strResult.d);
                    //$(".attachment").tooltip();
                    //$(".discussion").tooltip();
                    //$(".issue").tooltip();
                    //$(".details").tooltip();
                    //$(".charts").tooltip();
                    //$(".priority").tooltip();
                    //$(".drag").tooltip();
                    //$(".story_point").tooltip();
                    //$(".view_story").tooltip();
                    //$(".delete_story").tooltip();
                    //$(".user_story").tooltip();
                    //$(".rank").tooltip();
                    //$(".issue").tooltip();
                    //$(".user-story-description").tooltip();
                    //$(".fa-ellipsis-h").tooltip();
                    //$('[data-bs-toggle="tooltip"]').tooltip();
                }
            }
            var display = $("#icnShow").parent().parent().css("display");

            if (display == "block") {
                $(".divDraggable").each(function (id, val) {
                    if ($(this).css("visibility") == "hidden") {
                        $(this).css("display", "none")
                        $(this).css("visibility", "")
                    }
                })
            }
        },
        cancel: ".clsCategory",
        cancel: ".blankdiv"
    });
    //debugger;
    //
    $('[data-bs-toggle="tooltip"]').tooltip();
    $(".divDraggable").disableSelection();
    $("#icnShow").click(function () {
        $(".divDraggable").css("display", "");
        $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');
        $("#icnShow").parent().parent().css("display", "none");
    })
}
$(window).resize(function () {
    SetWidthHeight()
    $('[data-bs-toggle="tooltip"]').tooltip();
})
var newChartTab = "";

//Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar
function HideScrollbar() {
    if (isIE() == "FF") {

        //if (!$("#DivHistorykList").find(".dataTables_wrapper").hasClass("clsHistoryTableBorder")) {
        //    //alert(1);
        //    $("#divhistoryList").find("#DivHistorykList").find(".dataTables_scrollBody").addClass("clsHistoryTableBorder");
        //    //$("#DataTables_Table_0_wrapper").addClass("clsHistoryTableBorder");//.css("cssText", "position: relative; !important;overflow: auto;width: 100%;border-right: 1px solid #ddd;"); //.find(".row").find(".col-sm-12").find(".dataTables_scroll").find(".dataTables_scrollBody").addClass("clsHistoryTableBorder");
        //}
        //if (!$("#DivHistorykList").find(".dataTables_wrapper").hasClass("clsHistoryTableBorder")) {
        //    alert(2);
        //    $("#DivHistorykList").find(".dataTables_wrapper").addClass("clsHistoryTableBorder"); //.find(".row").find(".col-sm-12").find(".dataTables_scroll").find(".dataTables_scrollBody").addClass("clsHistoryTableBorder");
        //}

        $("#DivHistorykList").css("cssText", "overflow: hidden !important;");
        $("#DivHistorykList").find(".dataTables_scrollBody").css("cssText", "position: relative; !important;overflow: auto;width: 103%;");
        $("#DivHistorykList").find(".dataTables_scrollBody").find("table").addClass("clsHistoryTableBorder");
    }
    else {
        $("#DivHistorykList").find(".dataTables_scrollBody").css("cssText", "position: relative; !important;overflow: auto;width: 100%;");
        $("#DivHistorykList").find(".dataTables_scrollBody").find("table").removeClass("clsHistoryTableBorder");
    }
}
//Added by Chetan M on 31st Jully 2020 for IssueID = 25479
var GblUserStoryID = 0;
//End of Added by Chetan M on 31st Jully 2020 for IssueID = 25479
//End of Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar
function EditUserStory(userStoryID, flag) {

    //Added by Chetan M on 31st Jully 2020 for IssueID = 25479
    if (flag != "delete") {
        GblUserStoryID = userStoryID;
        userStoryID = GblUserStoryID;
    }
    else {
        userStoryID = strUserStoryId;
    }
    //End of Added by Chetan M on 31st Jully 2020 for IssueID = 25479
    strUserStoryId = userStoryID
    var strResult = ajaxCall("frmProductBacklog.aspx/GetUserStoryDetails", "POST", "application/json", "json", JSON.stringify({ UserStoryId: userStoryID }))
    //$("#divProductBacklog_Body").html("");
    $("#divProductBacklog_Body").html(strResult.d);
    //$("#cboRevieStatus option:first").attr('selected', true);
    $("#cboRevieStatus").find('option:eq(0)').attr('selected', true);


    //var count = lines.length; //now you can count thses lines.
    //console.log(count);
    AutoResizeTextArea();
    getRows();
    RemoveTextArea();
    $('#txtReviewStartDate').datepicker(
        {
            changeMonth: true,
            changeYear: true,
            // yearRange: '2000:2060'
            yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
        });
    $('#txtReviewEnddate').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });
    //autosize(document.querySelectorAll('textarea'));
    //if ($("#SectionHeader") != undefined) {
    //    $("#SectionHeader").css('display', 'none');
    //}
    $("#divProductBacklog #ClsModal").css("width", "100%");
    $("#divProductBacklog #frmDetails").removeClass('clsBox1')
    $("#divProductBacklog #frmDetails").addClass('clsBox')

    $('#divUserStroryDetails').css("height", ((window.innerHeight / 2) - 35 + 'px'));
    $('#ulTabs li').click(function () {
        var h = $(this).text();
        var h = $(this).text();
        if (h == "Substories") {
            AutoResizeTextArea();
            getRows();
            $("#txtSubStoryDesc").click();
        }
        else {
            $("#txtSubStoryDesc").css("height", "");
        }
        $('#ulTabs li a').css("text-decoration", "none");
        $('#ulTabs li a').css("color", "");
        $("a", this).css("text-decoration", "underline");
        $("a", this).css("color", "#60ffa7");
    });
    $(".clsBox").hover(function () {
        $('#ulTabs li a').css("text-decoration", "none");
        $('#ulTabs li a').css("color", "");
        $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
        $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
    });
    if (flag != undefined) {
        setTimeout(function () {

            $("[href=#" + flag + "]").click();
            //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25479
            //var scrollPos = $("#" + flag + "").offset().top;
            // $("#divUserStroryDetails").scrollTop(scrollPos - 250);
            if ($("#" + flag + "").offset() != undefined) {
                var scrollPos = $("#" + flag + "").offset().top;
                $("#divUserStroryDetails").scrollTop(scrollPos - 250);
            }
            //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25479

        }, 500)
    }
    else {
        $("#txtSubStoryDesc").css("height", "");
    }
    $('#ulTabs li a').css("text-decoration", "none");
    $('#ulTabs li a').css("color", "");
    $("a", this).css("text-decoration", "underline");
    $("a", this).css("color", "#60ffa7");



    $(".clsBox").hover(function () {
        $('#ulTabs li a').css("text-decoration", "none");
        $('#ulTabs li a').css("color", "");
        $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
        $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
    })
    if (flag != undefined) {
        setTimeout(function () {

            $("[href=#" + flag + "]").click();
            //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25479
            //var scrollPos = $("#" + flag + "").offset().top;
            //$("#divUserStroryDetails").scrollTop(scrollPos - 250);
            if ($("#" + flag + "").offset() != undefined) {
                var scrollPos = $("#" + flag + "").offset().top;
                $("#divUserStroryDetails").scrollTop(scrollPos - 250);
            }
            //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25479
        }, 500)
    }

    $('.counter-count').each(function () {
        $(this).prop('Counter', 0).animate({
            Counter: $(this).text()
        }, {
            duration: 5000,
            easing: 'swing',
            step: function (now) {
                $(this).text(Math.ceil(now));
            }
        });
    });

    newChartTab = $('#myScrollspy ul li').click(function () {
        newChartTab.removeClass('active');
        $(this).addClass('active');

    });

    $(".tabcontentChart").hover(function () {
        //Commented and Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue
        //$('#myScrollspy ul li a').css("background-color", "white");
        //$('#myScrollspy ul li a').css("color", "black");
        //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
        //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

        $('#myScrollspy ul li').removeClass('active');
        $("[href=#" + $(this).attr("id") + "]").parent().addClass('active');


        $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
       /* $('#myScrollspy ul li a').css("cssText", "color:black!important;");*/


        $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
        $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");
        //End of Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue

    });
    HighLightChart();

    // $("#txtDiscussion").Editor();
    $('[data-bs-toggle="tooltip"]').tooltip();


    if ($("#FilterDivHistorykList").val() > 0) {
        datatables('DivHistorykList', 'txtSearchhistory', '')
    }

    if ($("#FilterDivSubTabIssuesList").val() > 0) {
        datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
    }

    if ($("#FilterDivReviewList").val() > 0) {
        datatables('DivReviewList', 'txtSearchReviews', '')
    }

    if ($("#FilterDivTaskList").val() > 0) {
        datatables('DivTaskList', 'txtSearchTask', '')
    }

    HideScrollbar();


    // ID = ' txtReported'
    // timeNow(ID);

    $('#txtEndDate').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });
    $('#txtStartDate').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });
    $('#txtStartDate0').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });
    $('#txtEndDate0').datepicker(
        {
            changeMonth: true,
            changeYear: true,
            // yearRange: '2000:2060'
            yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
        });
    $('#txtReviewStartDate').datepicker(
        {
            changeMonth: true,
            changeYear: true,
            // yearRange: '2000:2060'
            yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
        });
    $('#txtReviewEnddate').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });

    GetLineBurnUP(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
    GetLineBurnDown(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");

    GetLineBurnUPEffortS(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
    GetLineBurnDownStoryPoints(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");


    //GetLineVelocityEffortBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnDown");
    // GetLineVelocityStoryBar(userStoryID, 'UserStory', 'divGraph' + userStoryID, "", "BurnUp");


    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
        var output = document.querySelector('.demo-droppable');
        output.innerHTML = '';
        for (var i = 0; i < files.length; i++) {
            arrFile[0] = files[i];
            output.innerHTML += '<p>' + files[i].name + '</p>';
        }
    });
    document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 120) + 'px';
    $('[data-bs-toggle="tooltip"]').tooltip();
    $('.fa-pencil').tooltip();
    var projectid = $("#hdnProjectID").val();
    // debugger;
    IssueType_OnChange(projectid)
}

/*Added by Usha on 11 june 2018 for Burn Up / Burn Down chart button highlight issue*/
function HighLightChart() {

    $('#myScrollspy ul li').click(function () {


        //$('#myScrollspy ul li a').removeClass("activecharttab");
        //$(this).addClass("activecharttab");

        //$('#myScrollspy ul li a').css("background-color", "white");
        //$('#myScrollspy ul li a').css("color", "black");
        //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
        //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

        $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
        $('#myScrollspy ul li a').css("cssText", "color:black!important;");


        $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
        /*$('#myScrollspy ul li.active a').css("cssText", "color:white!important;");*/

        //$(this).css("cssText", "background-color:#337ab7!important;");
        //$(this).css("cssText", "color:white!important;");
        //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
        //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



    });

    $('#myScrollspy ul li a').click(function () {


        //$('#myScrollspy ul li a').removeClass("activecharttab");
        //$(this).addClass("activecharttab");

        //$('#myScrollspy ul li a').css("background-color", "white");
        //$('#myScrollspy ul li a').css("color", "black");
        //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
        //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

        $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
        $('#myScrollspy ul li a').css("cssText", "color:black!important;");


        $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
        $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");


        //$(this).css("cssText", "background-color:#337ab7!important;");
        //$(this).css("cssText", "color:white!important;");
        //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
        //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



    });
}
/*End of Added by Usha on 11 june 2018 for Burn Up / Burn Down chart button highlight issue*/
//function getRows() {
//    $('#txtUserDesc').autosize({ append: "" });
//        var str = document.getElementById("txtUserDesc").value;
//        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//        document.getElementById("txtUserDesc").value = str;
//        $("#txtUserDesc").attr("style", "height: auto!important");

//        $('#txtFeatureName').autosize({ append: "" });
//        var str = document.getElementById("txtFeatureName").value;
//        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//        document.getElementById("txtFeatureName").value = str;
//        $("#txtFeatureName").attr("style", "height: auto!important");

//        $('#txtAcceptanceCriteria').autosize({ append: "" });
//        var str = document.getElementById("txtAcceptanceCriteria").value;
//        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//        document.getElementById("txtAcceptanceCriteria").value = str;
//        $("#txtAcceptanceCriteria").attr("style", "height: auto!important");


//}
//function AutoResizeTextArea() {
//    $('#txtDescriptionSprint').autosize({ append: "" });
//   $('#txtDescription').autosize({ append: "" });
//   $("#txtDescriptionSprint").attr("style", "height: auto!important");
//   $("#txtDescription").attr("style", "height: auto!important");

//    //var str = document.getElementById("txtUserDesc").value;
//    //str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//    //document.getElementById("txtUserDesc").value = str;
//}

/*Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/
function isIE() {
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
/*End of Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/

function AutoResizeTextArea() {
    jQuery.each(jQuery('textarea[data-autoresize]'), function () {
        //var offset = this.offsetHeight - this.clientHeight;

        var resizeTextarea = function (el) {
            //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
        };
        jQuery(this).on('keyup input', function () {
            if ($(this).attr("id") == "txtUserDesc") {
                Maxlength(this, "countdown", 1000);
            }
            if ($(this).attr("id") == "txtFeatureName") {
                Maxlength(this, "countdownFN", 200);
            }
            if ($(this).attr("id") == "txtAcceptanceCriteria") {
                Maxlength(this, "countdownAC", 1000);
            }
            resizeTextarea(this);
        }).removeAttr('data-autoresize');


    });
}
function RemoveTextArea() {
    $('textarea').keydown(function (e) {
        var $this = $(this),
            rows = parseInt($this.attr('rows')),
            lines;

        // on enter
        if (e.which === 13)
            $this.attr('rows', rows + 1);

        // on backspace -- THIS IS THE PROBLEM
        if (e.which === 8 && rows !== 2) {
            lines = $(this).val().split('\n')
            console.log(lines);
            if (!lines[lines.length - 1]) {
                $this.attr('rows', rows - 1);
            }
        }
    });
}

function EditListUS(userStoryID, flag) {

    EditUserStory(userStoryID);
    //strUserStoryId = userStoryID
    //var strResult = ajaxCall("frmProductBacklog.aspx/GetUserStoryDetails",
    //"POST", "application/json", "json", JSON.stringify({ UserStoryId: userStoryID }))
    //$("#divProductBacklog_Body").html(strResult.d);
    // $("#DivSprintlist").modal('show');
    // alert(strResult.d);
}
function AutoGrowTextArea(textField) {
    //Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
    if (textField.value.length >= 2000) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Please Enter Discussion less than 2000 characters.', 'error', 5);
        $(textField).focus();
    }
    //End of Commented and Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
    if (textField.clientHeight < textField.scrollHeight) {
        textField.style.height = textField.scrollHeight + "px";
        if (textField.clientHeight < textField.scrollHeight) {
            textField.style.height =
                (textField.scrollHeight * 2 - textField.clientHeight) + "px";
        }
    }
}

function getRows() {
    if ($("#txtUserDesc").val() != undefined) {
        //debugger;

        var numberOfColumns = 70;
        var numberOfLines = 1;
        //numberOfColumns = document.getElementById("txtActionItems").cols;
        var eachLine = $("#txtUserDesc").val().split('\n');
        var lineheight = $("#txtUserDesc").val();
        numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
        characterCount = lineheight.length + numberOfLineBreaks;

        if (characterCount > numberOfColumns) {
            numberOfLines = parseInt(characterCount / numberOfColumns);
            var height = document.getElementById("txtUserDesc").rows = numberOfLines + 1;
            $("#txtUserDesc").attr("style", "height: auto !important");
        }

    }
    if ($("#txtFeatureName").val() != undefined) {
        var numberOfColumns1 = 70;
        var numberOfLines1 = 1;
        var characterCount1;
        //numberOfColumns = document.getElementById("txtActionItems").cols;
        var eachLine = $("#txtFeatureName").val().split('\n');
        var lineheight1 = $("#txtFeatureName").val();
        numberOfLineBreaks1 = (lineheight1.match(/\n/g) || []).length;
        characterCount1 = lineheight1.length + numberOfLineBreaks1;

        if (characterCount1 > numberOfColumns1) {
            numberOfLines1 = parseInt(characterCount1 / numberOfColumns1);
            var height1 = document.getElementById("txtFeatureName").rows = numberOfLines1 + 1;
            $("#txtFeatureName").attr("style", "height: auto !important");
        }

    }
    if ($("#txtAcceptanceCriteria").val() != undefined) {
        var numberOfColumns2 = 70;
        var numberOfLines2 = 1;
        var characterCount2;
        //numberOfColumns = document.getElementById("txtActionItems").cols;
        var eachLine2 = $("#txtAcceptanceCriteria").val().split('\n');
        var lineheight2 = $("#txtAcceptanceCriteria").val();
        numberOfLineBreaks2 = (lineheight2.match(/\n/g) || []).length;
        characterCount2 = lineheight2.length + numberOfLineBreaks2;

        if (characterCount2 > numberOfColumns2) {
            numberOfLines2 = parseInt(characterCount2 / numberOfColumns2);
            var height2 = document.getElementById("txtAcceptanceCriteria").rows = numberOfLines2 + 1;
            $("#txtAcceptanceCriteria").attr("style", "height: auto !important");
        }

    }


}
//function getRows() {
//    //alert(document.getElementById('txtAcceptanceCriteria').value.split("\n").length);
//    var str = document.getElementById("txtFeatureName").value;
//    str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//    document.getElementById("txtFeatureName").value = str;
//    var lineheight = document.getElementById('txtFeatureName').value.split("\n").length + 1;
//    var height = document.getElementById("txtFeatureName").rows = lineheight;

//    var str1 = document.getElementById("txtUserDesc").value;
//    str1 = str1.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//    document.getElementById("txtUserDesc").value = str1;
//    var lineheight1 = document.getElementById('txtUserDesc').value.split("\n").length + 1;
//    var height1 = document.getElementById("txtUserDesc").rows = lineheight1;

//    if ($("#txtAcceptanceCriteria").val() != undefined) {
//        var str = document.getElementById("txtAcceptanceCriteria").value;
//        str = str.replace(/(?!$|\n)([^\n]{90}(?!\n))/g, '$1\n');
//        document.getElementById("txtAcceptanceCriteria").value = str;
//        var lineheight2 = document.getElementById("txtAcceptanceCriteria").value.split("\n").length + 1;
//        var height2 = document.getElementById("txtAcceptanceCriteria").rows = lineheight2;

//        $("#txtAcceptanceCriteria").attr("style", "height: auto !important");
//    }

//    $("#txtUserDesc").attr("style", "height: auto !important");
//    $("#txtFeatureName").attr("style", "height: auto !important");
//    //$("#txtAcceptanceCriteria").attr("style", "height: auto !important");


//}
//For BurnDown Graph
function GetLineBurnDown(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

    //debugger
    var ctx = $("#BurnDown" + UniqueID);
    var strResult, data;
    data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
    strResult = AJAXCallWithResult("frmProductBacklog.aspx/GetGraphDetails", data, false);

    var strInRate1 = [];
    var strOutRate1 = [];
    var strOutStanding1 = [];
    var arrBackColor1 = [];
    var strLabels1 = [];
    if (strResult.d != "") {
        // debugger;
        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels1.push(object["EntryDate"]);
            strInRate1.push(object["Planned"]);
            strOutRate1.push(object["Remained"]);
            // strOutStanding1.push(object["OutStanding"]);

            // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }

    var lineChartData1 = {
        labels: strLabels1,
        datasets: [{
            label: "Planned",
            borderColor: "orange",
            backgroundColor: "orange",
            fill: false,
            data: strInRate1,
            //yAxisID: "y-axis-1",
        }, {
            label: "Remaining",
            borderColor: "#4cae4c",
            backgroundColor: "#4cae4c",
            fill: false,
            data: strOutRate1,
            //yAxisID: "y-axis-2"
        },

        ]
    };
    //options
    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Burn Down Chart(Efforts)",
            fontSize: 13,
            fontColor: "#111"
        },
        //Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {

                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    //if (data.datasets[tooltipItems.datasetIndex].label == "Available") {
                    //    var HMAvailableEfforts = tooltipItems.yLabel.toFixed(2);
                    //    HMAvailableEfforts = HMAvailableEfforts.toString().replace(".", ":");
                    //    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMAvailableEfforts;
                    //}
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }

            }
        },
        //End Of Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },


    };


    var chart = new Chart(ctx, {
        type: "line",
        data: lineChartData1,
        options: options
    });

}
function GetLineBurnUP(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

    // debugger;

    var ctx1 = $("#BurnUp" + UniqueID);
    // var ctx1 = $("#line-chartcanvas1");
    var strResult, data;
    data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetailsStoryPoint", data, false);

    var strInRate1 = [];
    var strOutRate1 = [];
    var strOutStanding1 = [];
    var arrBackColor1 = [];
    var strLabels1 = [];
    if (strResult.d != "") {
        // debugger;
        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels1.push(object["EntryDate"]);
            strInRate1.push(object["Planned"]);
            strOutRate1.push(object["Remained"]);
            // strOutStanding1.push(object["OutStanding"]);

            // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }

    var lineChartData1 = {
        labels: strLabels1,
        datasets: [{
            label: "Planned",
            borderColor: "orange",
            backgroundColor: "orange",
            fill: false,
            data: strInRate1,
            //yAxisID: "y-axis-1",
        }, {
            label: "Remaining",
            borderColor: "#4cae4c",
            backgroundColor: "#4cae4c",
            fill: false,
            data: strOutRate1,
            //yAxisID: "y-axis-2"
        },

        ]
    };
    //options
    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Burn Down Chart(Story Points)",
            fontSize: 13,
            fontColor: "#111"
        },
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },
    };




    var chart = new Chart(ctx1, {
        type: "line",
        data: lineChartData1,
        options: options
    });



}
//End of BurnDown Graph


//For Burnup Graph
function GetLineBurnUPEffortS(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {


    var BurnupGraphEfforts = $("#BurnupGraphEfforts" + UniqueID);
    var strResult, data;
    data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
    strResult = AJAXCallWithResult("frmProductBacklog.aspx/GetGetBurnUpChartGraphDetails", data, false);

    var strInRate1 = [];
    var strOutRate1 = [];
    var strOutStanding1 = [];
    var arrBackColor1 = [];
    var strLabels1 = [];
    if (strResult.d != "") {
        // debugger;
        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels1.push(object["EntryDate"]);
            strInRate1.push(object["Planned"]);
            strOutRate1.push(object["Remained"]);
            // strOutStanding1.push(object["OutStanding"]);

            // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }

    var lineChartData1 = {
        labels: strLabels1,
        datasets: [{
            label: "Planned",
            //Added by swapna to change color of burnup
            //borderColor: "#55acee",
            //backgroundColor: "#55acee",
            borderColor: "orange",
            backgroundColor: "orange",
            //End by swapna
            fill: false,
            data: strInRate1,
            //yAxisID: "y-axis-1",
        }, {
            label: "Actual Completed",
            //Added by swapna to change color of burnup
            //borderColor: "#4c66a4",
            //backgroundColor: "#4c66a4",
            borderColor: "#4cae4c",
            backgroundColor: "#4cae4c",
            //End by swapna
            fill: false,
            data: strOutRate1,
            //yAxisID: "y-axis-2"
        },

        ]
    };
    //options
    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Burn Up Chart(Efforts)",
            fontSize: 13,
            fontColor: "#111"
        },
        //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {

                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Actual Completed") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }

            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format

        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },
        scales: {
            xAxes: [{
                ticks: {
                    // autoSkip: false,
                    // maxRotation: 90,
                    // minRotation: 90
                }
            }],
            yAxes: [{
                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                //position: "left",
                //id: "y-axis-1",
                ticks: {
                    min: 0
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Efforts'
                }
                //}, {
                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                //    display: true,
                //  //  position: "right",
                //  //  id: "y-axis-2",
                //    scaleLabel: {
                //        display: true,
                //        // labelString: 'cumulative % (0-100%)'
                //    }
            }],
        }
    };

    var chart = new Chart(BurnupGraphEfforts, {
        type: "line",
        data: lineChartData1,
        options: options
    });

}
function GetLineBurnDownStoryPoints(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {



    var BurnupGraphStoryPoints = $("#BurnupGraphStoryPoints" + UniqueID);
    // var ctx1 = $("#line-chartcanvas1");
    var strResult, data;
    data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetBurnUpStoryPoint", data, false);

    var strInRate1 = [];
    var strOutRate1 = [];
    var strOutStanding1 = [];
    var arrBackColor1 = [];
    var strLabels1 = [];
    if (strResult.d != "") {
        // debugger;
        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels1.push(object["EntryDate"]);
            strInRate1.push(object["Planned"]);
            strOutRate1.push(object["Remained"]);
            // strOutStanding1.push(object["OutStanding"]);

            // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }

    var lineChartData1 = {
        labels: strLabels1,
        datasets: [{
            label: "Planned",
            //Added by swapna to change color of burnup
            //borderColor: "#55acee",
            //backgroundColor: "#55acee",
            borderColor: "orange",
            backgroundColor: "orange",
            //End by swapna
            fill: false,
            data: strInRate1,
            //yAxisID: "y-axis-1",
        }, {
            label: "Actual Completed",
            //Added by swapna to change color of burnup
            //borderColor: "#4c66a4",
            //backgroundColor: "#4c66a4",
            borderColor: "#4cae4c",
            backgroundColor: "#4cae4c",
            //End by swapna
            fill: false,
            data: strOutRate1,
            //yAxisID: "y-axis-2"
        },

        ]
    };
    //options
    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Burn Up Chart(Story Points)",
            fontSize: 13,
            fontColor: "#111"
        },
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },
        scales: {
            xAxes: [{
                ticks: {
                    // autoSkip: false,
                    // maxRotation: 90,
                    // minRotation: 90
                }
            }],
            yAxes: [{
                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                //position: "left",
                //id: "y-axis-1",
                ticks: {
                    min: 0
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Story Points'
                }
                //}, {
                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                //    display: true,
                //  //  position: "right",
                //  //  id: "y-axis-2",
                //    scaleLabel: {
                //        display: true,
                //        // labelString: 'cumulative % (0-100%)'
                //    }
            }],
        }
    };




    var chart = new Chart(BurnupGraphStoryPoints, {
        type: "line",
        data: lineChartData1,
        options: options
    });



}
//End of Burnup Graph

//For Velocity Bar Graph
var preChartVelocity;
function GetLineVelocityEffortBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

    var VelocityEffortBar = document.getElementById("VelocityEffortBar" + UniqueID).getContext("2d");

    var strResult, data;

    data = JSON.stringify({ strGraphFilter: "Effort", UniqueID: UniqueID });

    console.log(data)
    strResult = AJAXCallWithResult("frmProductBacklog.aspx/GetVelocityData", data, false);
    var strEntityCount = [];
    var PercentCount = [];
    var arrBackColor = [];
    var strLabels = [];
    if (strResult.d != "") {

        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels.push(object["IterationName"]);
            strEntityCount.push(object["Velocity"]);
            PercentCount.push(object["Efforts"]);
            // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }
    //  alert(strEntityCount)
    //   alert(PercentCount)
    var config1 = {
        type: 'bar',
        data: {
            labels: strLabels,
            datasets: [{
                type: 'bar',
                label: 'Velocity',
                backgroundColor: [
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)"
                ],
                borderColor: [
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)"
                ],
                borderWidth: 1,
                //fill: false,
                data: strEntityCount,
                // yAxisID: "y-axis-2",
            }, {

                type: 'bar',
                label: 'Efforts',
                // data: PercentCount,
                backgroundColor: [
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)"
                ],
                borderColor: [
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)"
                ],
                borderWidth: 1,
                data: PercentCount,
                //  borderColor: 'white',
                // borderWidth: 2,
                // yAxisID: "y-axis-1",
            }]
        },

    };


    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Velocity Bar Graph(Effort)",
            fontSize: 13,
            fontColor: "#111"
        },
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },
        //scales: {
        //    yAxes: [{
        //        ticks: {
        //            min: 0
        //        }
        //    }]
        //},
        //scaleLabel: {
        //    display: true,
        //    labelString: 'Story Points'
        //}
        scales: {
            xAxes: [{
                ticks: {
                    // autoSkip: false,
                    // maxRotation: 90,
                    // minRotation: 90
                }
            }],
            yAxes: [{
                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                //position: "left",
                //id: "y-axis-1",
                ticks: {
                    min: 0
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Efforts'
                }
                //}, {
                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                //    display: true,
                //  //  position: "right",
                //  //  id: "y-axis-2",
                //    scaleLabel: {
                //        display: true,
                //        // labelString: 'cumulative % (0-100%)'
                //    }
            }],
        }
    };

    // Remove the old chart and all its event handles
    if (preChartVelocity) {
        preChartVelocity.destroy();
    }

    // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
    var temp = jQuery.extend(true, {}, config1);
    temp.type = 'bar';
    temp.options = options;
    preChartVelocity = new Chart(VelocityEffortBar, temp);
};
var preChartVelocityStoryBar;
function GetLineVelocityStoryBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

    var VelocitySToryPoints = document.getElementById("VelocitySToryPoints" + UniqueID).getContext("2d");

    var strResult, data;

    data = JSON.stringify({ strGraphFilter: "Storypoint", UniqueID: UniqueID });

    console.log(data)
    strResult = AJAXCallWithResult("frmProductBacklog.aspx/GetVelocityData", data, false);
    var strEntityCount = [];
    var PercentCount = [];
    var arrBackColor = [];
    var strLabels = [];
    if (strResult.d != "") {

        $.each(JSON.parse(strResult.d), function (id, object) {
            strLabels.push(object["IterationName"]);
            strEntityCount.push(object["Velocity"]);
            PercentCount.push(object["Efforts"]);
            // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
        });

    }

    var config1 = {
        type: 'bar',
        data: {
            labels: strLabels,
            datasets: [{
                type: 'bar',
                label: 'Velocity',
                backgroundColor: [
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)",
                    "rgba(10,20,30,0.3)"
                ],
                borderColor: [
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)",
                    "rgba(10,20,30,1)"
                ],
                borderWidth: 1,
                //fill: false,
                data: strEntityCount,
                // yAxisID: "y-axis-2",
            }, {

                type: 'bar',
                label: 'Efforts',
                // data: PercentCount,
                backgroundColor: [
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)",
                    "rgba(50,150,200,0.3)"
                ],
                borderColor: [
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)",
                    "rgba(50,150,200,1)"
                ],
                borderWidth: 1,
                data: PercentCount,
                //  borderColor: 'white',
                // borderWidth: 2,
                // yAxisID: "y-axis-1",
            }]
        },

    };


    var options = {
        responsive: true,
        title: {
            display: true,
            position: "top",
            text: "Velocity Bar Graph(Story Points)",
            fontSize: 13,
            fontColor: "#111"
        },
        legend: {
            display: true,
            position: "bottom",
            labels: {
                fontColor: "#333",
                fontSize: 12
            }
        },
        //scales: {
        //    yAxes: [{
        //        ticks: {
        //            min: 0
        //        }
        //    }]
        //},
        //scaleLabel: {
        //    display: true,
        //    labelString: 'Story Points'
        //}
        scales: {
            xAxes: [{
                ticks: {
                    // autoSkip: false,
                    // maxRotation: 90,
                    // minRotation: 90
                }
            }],
            yAxes: [{
                // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                display: true,
                //position: "left",
                //id: "y-axis-1",
                ticks: {
                    min: 0
                },
                scaleLabel: {
                    display: true,
                    labelString: 'Story Points'
                }
                //}, {
                //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                //    display: true,
                //  //  position: "right",
                //  //  id: "y-axis-2",
                //    scaleLabel: {
                //        display: true,
                //        // labelString: 'cumulative % (0-100%)'
                //    }
            }],
        }
    };

    // Remove the old chart and all its event handles
    if (preChartVelocityStoryBar) {
        preChartVelocityStoryBar.destroy();
    }

    // // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
    var temp = jQuery.extend(true, {}, config1);
    temp.type = 'bar';
    temp.options = options;
    preChartVelocityStoryBar = new Chart(VelocitySToryPoints, temp);




};
//End  of  Velocity Bar Graph


//For Datatable
function datatables(divID, txtBoxID, height) {
    $('#' + divID + ' > table').removeClass("clsGridTable");
    if (divID == "excelDataDivInner") {

        $('#' + divID + ' table').addClass("table-bordered table-stripped");
    }
    else {
        $('#' + divID + ' table').addClass("table table-bordered table-stripped");

    }
    var table = $('#' + divID + ' > table').DataTable({
        responsive: true,
        "pageLength": 5,
        //scrollY: '275px',
        pagingType: "numbers",
        sorting: false,
        ordering: false,
        scrollX: true,
        tooltip: true,
        "drawCallback": function (settings) { //Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar

            HideScrollbar(); //Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar
        }

    }).on('page.dt', function () {     //Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar

        HideScrollbar(); //Added by Usha Pandit on 06 June 2018 for hiding vertical scrollbar
    });

    //  table.$('tr').tooltip();

    if (txtBoxID != "") {
        $('#' + txtBoxID).on('keyup change', function () {
            table.search($(this).val()).draw();
        })
    }


}

function datatablesExcelUpload(divID, txtBoxID, height) {
    $('#' + divID + ' > table').removeClass("clsGridTable");
    $('#' + divID + ' table').addClass("table-bordered table-stripped");


    var table = $('#' + divID + ' > table').DataTable({
        responsive: true,
        "pageLength": 5,
        scrollY: '275px',
        pagingType: "numbers",
        sorting: true,
        scrollX: true,
        tooltip: true,


    });

    //  table.$('tr').tooltip();

    if (txtBoxID != "") {
        $('#' + txtBoxID).on('keyup change', function () {
            table.search($(this).val()).draw();
        })
    }


}
var arrFile = [];

var arrProcessFile = [];   /*Added By Ankush T on 22/05/2018*/
function ajaxCall(url, type, contentType, dataType, data) {
    var ajaxResult;
    $.ajax({
        url: url,
        type: type,
        contentType: contentType,
        dataType: dataType,
        data: data,
        async: false,
        success: function (result) {
            ajaxResult = result;
        },
        error: function (xhr) {
            console.log(xhr);
        }
    })

    return ajaxResult;
}

function ApplyView_OnClick(Mode) {
    var strUserStory = ''

    var SelectedCheckboxValues = $('.clsCheckbox:checked').map(function () { return this.value; }).get().join(',');
    SelectedCheckboxValues = SelectedCheckboxValues
    var data = JSON.stringify({ SelectedCheckboxValues: SelectedCheckboxValues, DefaultView: 'NO' });
    var result = ajaxCall('frmProductBacklog.aspx/SaveView', "POST", "application/json", "json", data)
    //Added by Usha Pandit on 31 may 2018 for showing alert after applying settings 
    if (result != undefined) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Settings Saved Successfully', 'success', 20);
    }
    //End of Added by Usha Pandit on 31 may 2018 for showing alert after applying settings 
}

function Default_OnClick(Mode) {
    var strUserStory = ''

    var SelectedCheckboxValues = $('.clsCheckbox:checked').map(function () { return this.value; }).get().join(',');
    SelectedCheckboxValues = SelectedCheckboxValues
    //Commented BY Dipali V On 23rd April 2018 For Mandatory 
    var str = "UserStoryName,Description,Priority,InitialEstimate"//UserStoryName,Priority,Complexity,InitialEstimate
    //End of Commented BY Dipali V On 23rd April 2018 For Mandatory 
    $('#tblColumnView .clsCheckbox').each(function (index) {
        if ($(this).attr("disabled") == "disabled") {
        }
        else {
            if (str.indexOf($(this).val()) == -1) {
                this.checked = false;
            }
            else {
                this.checked = true;
            }
        }
    });
    var data = JSON.stringify({ SelectedCheckboxValues: "", DefaultView: 'YES' });
    ajaxCall('frmProductBacklog.aspx/SaveView', "POST", "application/json", "json", data)
}
function PerformSearchForPTI() {
    $.each($(".panel"), function (id, val) {
        var strHTML = String($(this).html()).toLowerCase();
        var n = strHTML.search(String($("#txtSearchPendingP").val()).toLowerCase());
        if (n == -1) {
            $(this).css("display", "none");
        }
        else {
            $(this).css("display", "");
        }
    })
}

function ClearSpan(txt, span) {

    if ($('#' + txt).val() == "") {
    }
    else {
        $('#' + txt).css('border-color', '#d8dade');
        $('#' + txt).css('border-width', '1px');
        $('#' + span).text("");
    }
}


function GetComplexityUniqueNo(ExistingUniqueNo, objComplexity, Priority) {
    if (objComplexity == "High") {
        switch (Priority) {
            case '1':
                UniqueNo = '1.1.' + ExistingUniqueNo;

                break;
            case '2':
                UniqueNo = '2.1.' + ExistingUniqueNo;
                break;
            case '3':
                UniqueNo = '3.1.' + ExistingUniqueNo;
                break;
            case '4':
                UniqueNo = '4.1.' + ExistingUniqueNo;
                break;
            default:
        }
    }
    else if (objComplexity == "Medium") {
        switch (Priority) {
            case '1':
                UniqueNo = '1.2.' + ExistingUniqueNo;
                break;
            case '2':
                UniqueNo = '2.2.' + ExistingUniqueNo;
                break;
            case '3':
                UniqueNo = '3.2.' + ExistingUniqueNo;
                break;
            case '4':
                UniqueNo = '4.2.' + ExistingUniqueNo;
                break;
            default:
        }
    }
    else if (objComplexity == "Low") {
        switch (Priority) {
            case '1':
                UniqueNo = '1.3.' + ExistingUniqueNo;
                break;
            case '2':
                UniqueNo = '2.3.' + ExistingUniqueNo;
                break;
            case '3':
                UniqueNo = '3.3.' + ExistingUniqueNo;
                break;
            case '4':
                UniqueNo = '4.3.' + ExistingUniqueNo;
                break;
            default:
        }
    }
    else {
        switch (Priority) {
            case '1':
                UniqueNo = '1.0.' + ExistingUniqueNo;
                break;
            case '2':
                UniqueNo = '2.0.' + ExistingUniqueNo;
                break;
            case '3':
                UniqueNo = '3.0.' + ExistingUniqueNo;
                break;
            case '4':
                UniqueNo = '4.0.' + ExistingUniqueNo;
                break;
            default:
        }
    }

    return UniqueNo;
}
var objComplexityTemp;
var PriorityTemp;
var strUserStoryId = "";
function GetExistingUniqueNumberFromDB(objComplexity, Priority) {


    objComplexityTemp = objComplexity;
    PriorityTemp = Priority;

    if (PriorityTemp != "") {
        var url = "frmProductBacklog.aspx/GetExistingUniqueNumberFromDB";
        var data = JSON.stringify({ objComplexity: objComplexity, Priority: Priority, strUserStoryId: strUserStoryId });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        GetExistingUniqueNumberFromDB_Success(strResult);
    }
    else {
        if (SaveValidation() == 0) {


            var ProjectId = document.getElementById('hdnProjectID').value;
            var url = "frmProductBacklog.aspx/SaveUserStory";
            objPriority = document.getElementById('cboPriority');




            if (ProjectId != "") {
                if (objPriority != null)
                    var selectedText = objPriority.options[objPriority.selectedIndex].text;

                if (objStoryPoint == null) {
                    objStoryPoint = ""
                }
                else {
                    objStoryPoint = objStoryPoint.value;
                }

                objIterationName = "";
                //if (EditModeFlag == 1) {
                //    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                //} else {
                var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity.value, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
                //}
                var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
                SaveSuccess(strUserResult)



            }
        }
    }
}
function SaveSuccess(result) {

    //Added by Usha Pandit on 08 June 2018 for showing alert on save records
    alertify.dismissAll();
    alertify.set('notifier', 'position', 'top-right');
    alertify.notify('User story details updated successfully', 'success', 10);
    //End of Added by Usha Pandit on 08 June 2018 for showing alert on save records
    EditUserStory(result.d);
    newcreatedUSID = result.d;
    //alert(strUserStoryId);

}
function SaveValidation() {
    var objPriorityForCompare = document.getElementById('cboPriority');
    var objSpanPriorityForCompare = document.getElementById('spanPriority');

    // var CheckFlag = 0;
    //if (RestrictNonNumeric(objStoryPoint)) {

    //    $("#" + objStoryPoint.id).css('border-color', 'red');
    //    $("#" + objStoryPoint.id).css('border-width', '1px');
    //    $("#" + spanStoryPoint.id).text("Please Enter Numeric Value");
    //    CheckFlag = 1;
    //}
    //if (ValidateBlankField(objFeatureName, objSpanFeatureName, "Feature Name should not be blank") == 1) {
    //    CheckFlag = 1;
    //}
    //if (ValidateBlankField(objUserDesc, objSpanUserDesc, "User Description should not be blank") == 1) {
    //    CheckFlag = 1;
    //}
    //if (objPriorityForCompare != null && objSpanPriorityForCompare != null) {
    //    if (ValidateBlankField(objPriorityForCompare, objSpanPriorityForCompare, "Priority should not be blank") == 1) {
    //        CheckFlag = 1;
    //    }
    //}

    //if (String(objUserDesc.value).length > 1000) {
    //    $("#txtUserDesc").css({ 'border-color': 'red', 'border-width': '1px' });
    //    var Msg = "User Description shhould not be grater than 1000 characters.";
    //    Msg = Msg.replace('<control_name>', 'User Description');
    //    Msg = Msg.replace('<max_length>', '1000');
    //    Msg = Msg.replace('<L>', $("#txtUserDesc").val().length);
    //    $("#spanUserDesc").html(Msg);

    //    if (CheckFlag == 1) {
    //        $("#txtUserDesc").focus();
    //    }
    //    CheckFlag = 1;
    //}
    //return CheckFlag;

    var checkvalue = 0;
    var Flag = 0;
    var strmsg = "";
    var errorMsg = "<ul>"


    if ($("#txtFeatureName").val() == "") {
        strmsg = '- User Story Name should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }
    //Added By Riddhesh Patil on 11-NOV-2022 
    else if (checkSpecialCharacter($("#txtFeatureName").val(), WebConfigSpecialCharacters) == true) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.error('User Story Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
        $("#txtFeatureName").focus();
        Flag = 1;
        checkvalue = 1;
    }
    //End of Added By Riddhesh Patil

    if ($("#txtUserDesc").val() == "") {
        strmsg = '- User Description should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }
    //Added By Riddhesh Patil on 11-NOV-2022 
    else if (checkSpecialCharacter($("#txtUserDesc").val(), WebConfigSpecialCharacters) == true) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.error('User Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
        $("#txtUserDesc").focus();
        Flag = 1;
        checkvalue = 1;
    }
    //End of Added By Riddhesh Patil

    if ($("#txtUserDesc").val() != "") {

        if (String($("#txtUserDesc").val()).length > 1000) {


            strmsg = '- You Can Enter Only 1000 Character for User Story Description';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
    }



    //if (RestrictNonNumeric(document.getElementById('txtStoryPoint')) == true) {


    //    strmsg = '- Please Enter Numeric Value For Story Point';
    //    errorMsg += "<li>" + strmsg + "</li></br>";
    //    Flag = 1;
    //    checkvalue = 1;
    //}


    if ($("#cboPriority").val() == "") {
        strmsg = '- Priority should not be blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if ($("#txtBusinessValue").val() != "") {

        if (RestrictNonNumeric(document.getElementById('txtBusinessValue')) == true) {


            strmsg = '- Please Enter Numeric Value For Business Value';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        if (parseFloat($("#txtBusinessValue").val()) < 0 && $("#txtBusinessValue").val() != '') {
            //alert('Please enter positive number');
            strmsg = '- Please enter positive Value For Business Value';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
            $("#txtBusinessValue").focus();

        }

    }

    //  debugger;
    if ($("#txtStoryPoint").val() != undefined) {

        if ($("#txtStoryPoint").val() != "") {
            if (RestrictNonNumeric(document.getElementById('txtStoryPoint')) == true) {


                strmsg = '- Please Enter Numeric Value For Story Point';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            else if (parseFloat($("#txtStoryPoint").val()) < 0 && $("#txtStoryPoint").val() != '') {
                //alert('Please enter positive number');
                strmsg = '- Please enter positive Value For Story Point';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
                $("#txtStoryPoint").focus();

            }
            //Added By Usha Pandit On 25.04.2020 For only allowing story point greater than 0
            else if (parseFloat($("#txtStoryPoint").val()) == 0) {
                //alert('Please enter positive number');
                strmsg = '- Please enter Story Point greater than 0';
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
                $("#txtStoryPoint").focus();

            }
            //End Of Added By Usha Pandit On 25.04.2020 For only allowing story point greater than 0
            else {

                var n = $("#txtStoryPoint").val();
                var result = (n - Math.floor(n)) !== 0;

                // alert(result);
                if (result) {
                    strmsg = '- Please enter Story Points without decimal';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                    $("#txtStoryPoint").focus();

                }

            }

        }
    }




    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkvalue;

}
var ExistingUniqueNo = 0;
var UniqueNo = 0;
var newcreatedUSID = 0;
function SaveNew_UserStory() {
    //alert(strUserStoryId);
    //Added By Dipali V On 12nd April 2018 For Update Details
    if (strUserStoryId != "") {
        strUserStoryId = strUserStoryId;

        getRows();
        RemoveTextArea();
        //autosize(document.querySelectorAll('textarea'));
    }
    else {

        strUserStoryId = 0;
    }

    //End of Added By Dipali V On 12nd April 2018 For Update Details

    objFunctionalNumber = document.getElementById("txtFunctionalNumber")
    objFeatureName = document.getElementById('txtFeatureName');
    objSpanFeatureName = document.getElementById('spanFeatureName');
    objUserDesc = document.getElementById('txtUserDesc');
    objSpanUserDesc = document.getElementById('spanUserDesc');
    objPriority = document.getElementById('cboPriority');
    objSpanPriority = document.getElementById('spanPriority');
    objComplexity = document.getElementById('cboComplexity');
    objSpanComplexity = document.getElementById('spanComplexity');
    objStoryPoint = document.getElementById('txtStoryPoint');
    spanStoryPoint = document.getElementById('spanStoryPoint');

    objBusinessValue = document.getElementById('txtBusinessValue');
    objState = document.getElementById('cboStateEdit');
    objCategory = document.getElementById('cboCategory');
    objVersion = document.getElementById('cboVersion');
    objIterationName = document.getElementById('cboIterationName');
    objReleaseName = document.getElementById('cboReleaseName');
    objlblFunctionalNumber = document.getElementById('lblFunctionalNumber');
    objFixedVersion = document.getElementById('cboFixedVersion');
    objAcceptanceCriteria = document.getElementById('txtAcceptanceCriteria');

    if (objFunctionalNumber == null) {
        objFunctionalNumber = ""
    }
    else {
        objFunctionalNumber = objFunctionalNumber.value;
    }

    if (objBusinessValue == null) {
        objBusinessValue = ""
    }
    else {
        objBusinessValue = objBusinessValue.value;
    }

    if (objState == null) {
        //added & commented By dipali V On 13th May 2019 for History Capture when Desc Update
        objState = "Active"
        // objState = ""
        //End of added & commented By dipali V On 13th May 2019 for History Capture when Desc Update
    }
    else {

        objState = objState.value;
    }

    if (objCategory == null) {
        objCategory = ""
    }
    else {
        objCategory = objCategory.value;
    }
    if (objVersion == null) {
        objVersion = ""
    }
    else {
        objVersion = objVersion.value;
    }
    if (objIterationName == null) {
        objIterationName = ""
    }
    else {
        objIterationName = objIterationName.value;
    }
    if (objReleaseName == null) {
        objReleaseName = ""
    }
    else {
        objReleaseName = objReleaseName.value;
    }
    if (objlblFunctionalNumber == null) {
        objlblFunctionalNumber = ""
    }
    else {
        objlblFunctionalNumber = objlblFunctionalNumber.value
    }
    if (objFixedVersion == null) {
        objFixedVersion = ""
    }
    else {
        objFixedVersion = objFixedVersion.value;
    }
    if (objAcceptanceCriteria == null) {
        objAcceptanceCriteria = ""
    }
    else {
        objAcceptanceCriteria = objAcceptanceCriteria.value;
    }


    if (objComplexity == null) {
        objComplexity = ""
    }
    else {
        objComplexity = objComplexity.value;
    }

    if (objPriority == null) {
        objPriority = ""
    }
    else {
        objPriority = objPriority.value;
    }
    GetExistingUniqueNumberFromDB(objComplexity, objPriority); // To get Already No. associate with userstory;
}

function GetExistingUniqueNumberFromDB_Success(result) {

    ExistingUniqueNo = result.d;

    switch (PriorityTemp) {

        case '1':
            UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '1');
            break;
        case '2':
            UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '2');
            break;
        case '3':
            UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '3');
            break;
        case '4':
            UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '4');
            break;
        default:

    }

    if (SaveValidation() == 0) {
        var ProjectId = document.getElementById('hdnProjectID').value;
        var url = "frmProductBacklog.aspx/SaveUserStory";

        if (ProjectId != "") {

            objPriority = document.getElementById('cboPriority');
            if (objPriority != null)
                var selectedText = objPriority.options[objPriority.selectedIndex].text;
            if (objStoryPoint == null) {
                objStoryPoint = ""
            }
            else {
                objStoryPoint = objStoryPoint.value;
            }
            objIterationName = "";
            var featureName = ""
            if (objFeatureName != null)
                featureName = objFeatureName.value;
            //if (EditModeFlag == 1) {
            //    var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: objFeatureName.value, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
            //} else {

            var data = JSON.stringify({ strUserStoryId: strUserStoryId, FunctionalNumber: objFunctionalNumber, FeatureName: featureName, UserDesc: objUserDesc.value, Priority: selectedText, Complexity: objComplexity, BusinessValue: objBusinessValue, State: objState, StoryPoint: objStoryPoint, Category: objCategory, Version: objVersion, IterationName: "", ReleaseName: "", FixedVersion: objFixedVersion, AcceptanceCriteria: objAcceptanceCriteria, UniqueNo: UniqueNo })
            //}


            var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
            SaveSuccess(strUserResult)
        }
    }


}
function Delete_UserStory(ID, Flag) {

    var UserStoryID = ID;
    var USID;
    //if (ID == "") {
    USID = $("#hdnusid").val();
    //}
    //else {
    //    USID = UserStoryID;
    //}
    //alert(ID);
    if (USID == undefined) {

        USID = "";
    }
    var url = "frmProductBacklog.aspx/DeleteEntryValidation";
    var data = JSON.stringify({ UserStoryID: UserStoryID, USID: USID });
    var para = []
    para.push(UserStoryID, Flag, USID)
    //  alert(UserStoryID);
    // alert(USID);
    var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
    DeleteEntrySuccess(strUserResult, para)
}


function DeleteEntrySuccess(result, para) {
    //alert(result.d)
    if ((result.d == "0" || result.d == "1" || result.d == "2")) {
        // alert(result.d);
        var url = "frmProductBacklog.aspx/DeleteEntry";
        var data = JSON.stringify({ UserStoryID: para[0], Flag: para[1], USID: para[2] });
        var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
        if (para[1] == "SubUS") {
            BindSubGrid(strUserResult)
        }
        else {
            BindGrid(strUserResult)
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('User Stories Deleted Successfully', 'success', 20);
        }
        //debugger;
        //Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25479
        //EditUserStory(para[0]);//Added By Dipali v On 26th June 2020 For  Refresh Left Side Tree
        EditUserStory(para[0], "delete");
        //Commented and added by Chetan M on 30th Jully 2020 for Issue ID = 25479
    }
    else {
        alertify.set('notifier', 'position', 'top-right');

        alertify.notify('Following User Story is in use.You can not delete this user story', 'error', 20);
        return

        //var url = "frmProductBacklog.aspx/DeleteEntry";
        //var data = JSON.stringify({ UserStoryID: para[0], Flag: para[1], USID: para[2] });
        //var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
        //if (para[1] == "SubUS") {
        //    BindSubGrid(strUserResult)
        //}
        //else {
        //    BindGrid(strUserResult)
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('User Stories Deleted Successfully', 'success', 20);
        //}
    }

}



function DeleteEntry() {



}

function BindGrid(result) {
    // var MainResult = result.d.split("||");
    var display = $("#icnShow").parent().parent().css("display");
    $("#divProductBacklog").modal('hide');
    //document.getElementById("divGrid").innerHTML = "";
    document.getElementById("divGrid").innerHTML = result.d;
    // document.getElementById("divSubstoryList").innerHTML = MainResult[0];
    // document.getElementById("divGrid").innerHTML = MainResult[1];
    //SetWidthHeight();
    if (display == "none")
        $("#icnShow").click();

    //  document.getElementById("divSubstoryList").innerHTML = result.d;
    SetWidthHeight();
    $(".attachment").tooltip();
    $(".discussion").tooltip();
    $(".issue").tooltip();
    $(".details").tooltip();
    $(".charts").tooltip();
    $(".priority").tooltip();
    $(".drag").tooltip();
    $(".story_point").tooltip();
    $(".view_story").tooltip();
    $(".delete_story").tooltip();
    $(".user_story").tooltip();
    $(".rank").tooltip();
    $(".issue").tooltip();
    $(".user-story-description").tooltip();
    $(".fa-ellipsis-h").tooltip();
    $('[data-bs-toggle="tooltip"]').tooltip();
    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'
    // $("#divUS").modal('hide');

}

function BindSubGrid(result) {


    document.getElementById("divSubstoryList").innerHTML = result.d;
    alertify.set('notifier', 'position', 'top-right');
    alertify.notify('User Stories Deleted Successfully', 'success', 20);


}

function FilterData(entity, entityID, obj) {
    obj.style.backgroundColor = "#ddd";
    var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: entityID, strEntity: entity }));
    document.getElementById("divUserStories").innerHTML = strUserResult.d;
    document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 120) + 'px'
    $(".attachment").tooltip();
    $(".discussion").tooltip();
    $(".issue").tooltip();
    $(".details").tooltip();
    $(".charts").tooltip();
    $(".priority").tooltip();
    $(".drag").tooltip();
    $(".story_point").tooltip();
    $(".view_story").tooltip();
    $(".delete_story").tooltip();
    $(".user_story").tooltip();
    $(".rank").tooltip();
    $(".view").tooltip();
    $(".user-story-description").tooltip();
    $(".fa-ellipsis-h").tooltip();


    $('[data-bs-toggle="tooltip"]').tooltip();
}

function RestrictNonNumeric(obj) {
    if (obj == null) { return false; }
    if (isBlank(getInputValue(obj))) { return false; }

    var dofocus = (arguments.length > 1) ? arguments[1] : true;
    if (!isNumeric(getInputValue(obj))) {
        if (dofocus) {
            setFocus(obj);
        }
        return true;
    }
    return false;
}
function ValidateBlankField(obj, spanObj, Msg) {
    var checkValue = 0;
    if ($("#" + obj.id).val() == "") {
        $("#" + obj.id).css('border-color', 'red');
        $("#" + obj.id).css('border-width', '1px');
        $("#" + spanObj.id).text(Msg);
        if (checkValue != 1) {
            $("#" + obj.id).focus()
        }
        checkValue = 1;
    }
    return checkValue;
}

function MoveCategory(CategoryID, Order) {

    //if (Order == 1) {



    //}
    var display = $("#icnShow").parent().parent().css("display");
    var strUserResult = ajaxCall("frmProductBacklog.aspx/MoveCategory", "POST",
        "application/json", "json", JSON.stringify({ CateGoryID: CategoryID, strFlag: Order }));
    document.getElementById("divGrid").innerHTML = strUserResult.d;
    SetWidthHeight();
    if (display == "none")
        $("#icnShow").click();
}

function ShowModal(type, categoryID) {
    try {
        // debugger;
        // Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
        var dtfmt = '';
        // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

        $('.dropdown-item').removeClass('activelist');
        $('.dropdown-item  li').addClass('activelist');
        $('[data-bs-toggle="tooltip"]').tooltip();
        var strUserResult = ajaxCall("frmProductBacklog.aspx/AddUserStoryModal", "POST", "application/json", "json", JSON.stringify({ CategoryID: categoryID, type: type }));
        if (type == "User") {
            //$("#divProductBacklog_Body")
            strUserStory = 0;
            $("#divProductBacklog #ClsModal").addClass('modal-lg');
            document.getElementById("divProductBacklog_Body").innerHTML = strUserResult.d;
            getRows();
            RemoveTextArea();
            // autosize(document.querySelectorAll('textarea'));
            $("#divProductBacklog_Body").find("input,textarea,select").removeAttr("disabled");
            $("#divProductBacklog_Body").find("input,textarea,select").removeAttr("readonly");
            $("#divProductBacklog").modal('show');
        }

        else if (type == "Sprint" || type == "Release") {
            $("#SprintBody").html(strUserResult.d);
            AutoResizeTextArea();
            RemoveTextArea();
            $("#CreateSprint").modal('show');
            if (type == "Sprint") {
                $("#HeaderCreate").html('Create Sprint')
                $("#SprintStartdate,#SprintEnddate").change(function () {
                    GetDuration("Edit");
                });
                // Commented and Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                //$('#SprintStartdate,#SprintEnddate').datepicker(
                //    {
                //        changeMonth: true,
                //        changeYear: true,
                //        // yearRange: '2000:2060'
                //    }
                //);
                var dtfmt = dtFormat(opDateFormat);

                $('#SprintStartdate,#SprintEnddate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        // yearRange: '2000:2060',
                        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10),
                        dateFormat: dtfmt
                    }
                );
                $('#SprintStartdate,#SprintEnddate').prop('readonly', true);
                //End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            }


            else {
                $("#HeaderCreate").html('Create Release')
                $("#RstartDate,#txtEndDate").change(function () {
                    GetDuration("Release");
                });
                $('#RstartDate,#txtEndDate').datepicker(
                    {
                        changeMonth: true,
                        changeYear: true,
                        // yearRange: '2000:2060'
                        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
                    }
                );
                $('#RstartDate,#txtEndDate').prop('readonly', true);
            }
        }

        //Commented By Ankush T on 22/05/2018 for Excel upload
        //else if (type == "ExcelUpload") {

        //    document.getElementById("ExcelUploadProductBacklock").innerHTML = strUserResult.d;
        //    $("#ExcelUpload").modal('show');
        //    $('[data-bs-toggle="tooltip"]').tooltip();
        //}
        //End of Commented By Ankush T on 22/05/2018 for Excel upload
        //Added By Ankush T on 22/05/2018 for Excel upload
        else if (type == "ExcelUploadNew") {
            //alert();
            // debugger;
            $("#ExcelUploadNew").html("");
            $("#ExcelUploadNew").html(strUserResult.d);
            // document.getElementById("ExcelUploadNew").innerHTML = strUserResult.d;
            //alert(strUserResult.d);
            //alert($("#ExcelUploadNew").length);
            //alert($("#NewExcelUpload").length);
            $("#lblstep").text("Step 1");
            $("#NewExcelUpload").modal('show');
            makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                var output = document.querySelector('.demo-droppable');
                output.innerHTML = '';
                for (var i = 0; i < files.length; i++) {
                    arrProcessFile[0] = files[i];
                    output.innerHTML += '<p>' + files[i].name + '</p>';
                    // $("#Filename").text(files[i].name);
                }
            });
            arrProcessFile[0] = [];
            arrExcelFields1 = [];
            //  $("#ExcelUploadNew").html("");//tblFieldList
            //  $("#ExcelUploadNew").html(strUserResult.d);//tblFieldList
            $('[data-bs-toggle="tooltip"]').tooltip();

        }
        //End of Added By Ankush T on 22/05/2018 for Excel upload
    }
    catch (ex) {
        //alert(ex.message);
    }
}
var IsFlagcountdownFN = 0;
var IsFlagcountdownAC = 0;
var IsFlagcountdownSummary = 0;
var IsFlagSubus = 0;
var IsFlag = 0;

//var IsFlag = 0;
function limitText(limitField, limitCount, limitNum) {

    //if (limitCount.innerHTML != 0) {


    //}
    var length;
    //debugger;
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } else {
        limitCount.innerHTML = (limitNum - limitField.value.length);

        if (limitCount.innerHTML != 0) {
            //debugger;
            IsFlagcountdownSummary = 0;
            IsFlagcountdownFN = 0;
            IsFlagcountdownAC = 0;
            IsFlagSubus = 0;
            IsFlag = 0;
            // alert(limitCount.innerHTML);
        }
    }
    //alert(limitCount.innerHTML);
    if (limitCount.innerHTML == 0) {

        if (limitCount.id == 'countdownFN') {
            if (IsFlagcountdownFN != 1) {
                document.getElementById("countdownFN").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanBusinessValue').html("You Can Enter Only 1000 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 200 Character', 'error', 25);
                IsFlagcountdownFN = 1;
                return IsFlagcountdownFN;
            }
        }
        else if (limitCount.id == 'countdownAC') {
            if (IsFlagcountdownAC != 1) {
                document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error', 25);
                IsFlagcountdownAC = 1;
                return IsFlagcountdownAC;
            }
        }
        else if (limitCount.id == 'countdownSummary') {
            if (IsFlagcountdownSummary != 1) {
                document.getElementById("countdownSummary").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 500 Character', 'error', 25);
                IsFlagcountdownSummary = 1;
                return IsFlagcountdownSummary;
            }
        }
        else if (limitCount.id == 'countSubUSdown') {
            if (IsFlagSubus != 1) {
                document.getElementById("countSubUSdown").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error', 25);
                IsFlagSubus = 1;
                return IsFlagSubus;
            }
        }
        else {
            if (IsFlag != 1) {
                // document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanUserDesc').html("You Can Enter Only 1000 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error', 25);
                IsFlag = 1;
                return IsFlag;
            }
        }
    }
    else {
        if (limitCount.id == 'countdownBU') {
            document.getElementById("countdownBU").style.color = 'black'
            //  $('#spanBusinessValue').text("");
        }
        else if (limitCount.id == 'countdownAC') {
            document.getElementById("countdownAC").style.color = 'black'
            // $('#spanAcceptanceCriteria').text("");
        }
        else if (limitCount.id == 'countdownFN') {
            document.getElementById("countdownFN").style.color = 'black'
            // $('#spanUserDesc').text("");
        }
        else {
            document.getElementById("countdown").style.color = 'black'
            // $('#spanUserDesc').text("");
        }

    }
    if (limitField.clientHeight < limitField.scrollHeight) {
        limitField.style.height = limitField.scrollHeight + "px";
        if (limitField.clientHeight < limitField.scrollHeight) {
            limitField.style.height =
                (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
        }
    }
}


function SelectPriorityColor(PriorityID) {

    var PriorityID = PriorityID.value;
    if (PriorityID != "") {
        var url = "frmProductBacklog.aspx/GetPriorityColor";
        var data = JSON.stringify({ PriorityID: PriorityID });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        GetPriorityColor_Success(strResult);
    }
}
function GetPriorityColor_Success(result) {

    var arrPriority = String(result.d).split("||")
    var cColor = arrPriority[0]
    var ChangeColorTD = arrPriority[1];
    $("#tblPriorityColor").html("")
    $("#tblPriorityColor").append(ChangeColorTD);
    $("#iPriorityColor").css("color", cColor)
}
function SelectCategoryColor(categoryID) {

    var categoryID = categoryID.value;
    if (categoryID != "") {
        var url = "frmProductBacklog.aspx/GetCategoryColor";
        var data = JSON.stringify({ categoryID: categoryID });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        GetCategoryColor_Success(strResult);
    }
}
var ChangeGlobalColorTD = ""
function GetCategoryColor_Success(result) {
    var arrPriority = String(result.d).split("||")
    var cColor = arrPriority[0]
    ChangeColorTD = arrPriority[1];
    ChangeGlobalColorTD = ChangeColorTD;
    $("#tblCategoryColor").html("")
    $("#tblCategoryColor").append(ChangeColorTD);
    $("#oColor").css("color", cColor)
    //alert(ChangeGlobalColorTD);
}

function SelectVersionColor(versionID) {
    var versionID = versionID.value;
    if (versionID != "") {
        var url = "frmProductBacklog.aspx/GetVersionColor";
        var data = JSON.stringify({ versionID: versionID, Mode: 'Version' });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        GetversionColor_Success(strResult);
    }
}
function SelectFVersionColor(versionID) {

    var versionID = versionID.value;
    if (versionID != "") {
        var url = "frmProductBacklog.aspx/GetVersionColor";
        var data = JSON.stringify({ versionID: versionID, Mode: 'FVersion' });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        GetFversionColor_Success(strResult)
    }
}
function GetFversionColor_Success(result) {
    var arrPriority = String(result.d).split("||")

    var cColor = arrPriority[0]
    var ChangeColorTD = arrPriority[1];
    $("#tblVersionColor2").html("")
    $("#tblVersionColor2").append(ChangeColorTD);
    $("#iFVersion").css("color", cColor)



}
function GetversionColor_Success(result) {
    var arrPriority = String(result.d).split("||")

    var cColor = arrPriority[0]
    var ChangeColorTD = arrPriority[1];
    $("#tblVersionColor").html("")
    $("#tblVersionColor").append(ChangeColorTD);
    $("#iVersion").css("color", cColor)
}
var cColor;
function ChangeColor(ID, color, mode) {
    cColor = color;
    var url = "frmProductBacklog.aspx/ChangeColor";
    var data = JSON.stringify({ ID: ID, color: color, mode: mode });
    var strResult = ajaxCall(url, "POST", "application/json", "json", data);
    ChangeColor_Success(strResult);

}
function ChangeColor_Success(result, para) {

    if (result.d == 1) {
        $("#iPriorityColor").attr("style", "font-size:16px;color:" + cColor + "!important")
    }
    if (result.d == 2) {
        $("#oColor").attr("style", "font-size:16px;color:" + cColor + "!important")
    }
    if (result.d == 3) {
        $("#iVersion").attr("style", "font-size:16px;color:" + cColor + "!important")
    }
    if (result.d == 4) {
        $("#iFVersion").attr("style", "font-size:16px;color:" + cColor + "!important")
    }
    //var url = "frmProductBacklog.aspx/RefreshGrid";
    //var data = JSON.stringify({});
    //AJAXCall(url, data, BindGrid);

}

function RefreshGrid() {
    //  debugger;
    if (filterFlag != "ListView") {
        var url = "frmProductBacklog.aspx/RefreshGrid";
        var data = JSON.stringify({ UserStoryID: "" });
        var strResult = ajaxCall(url, "POST", "application/json", "json", data);
        BindGrid(strResult);
        strUserStoryId = 0;
        $('[data-bs-toggle="tooltip"]').tooltip();
        $(".fa-ellipsis-h").tooltip();
    }
    else {
        $(".modal-backdrop").remove();
        ShowFilter('', 'ListView');

    }

    $(".Outerdiv").css("height", window.innerHeight - 220 + 'px');
    $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
    $(".adjustheight").css("height", window.innerHeight - 220 + 'px');
    $(".attachment").tooltip();
    $(".discussion").tooltip();
    $(".issue").tooltip();
    $(".details").tooltip();
    $(".charts").tooltip();
    $(".priority").tooltip();
    $(".drag").tooltip();
    $(".story_point").tooltip();
    $(".view_story").tooltip();
    $(".delete_story").tooltip();
    $(".user_story").tooltip();
    $(".rank").tooltip();
    $(".view").tooltip();
    $(".user-story-description").tooltip();
    $(".fa-ellipsis-h").tooltip();


    $('[data-bs-toggle="tooltip"]').tooltip();


    $("#idfilter").css("display", "none");
    // $("#uldropdown").css("display", "none")
    $("#ProductFilterRelease").val('');
    $("#ProductFilterSprint").val('');




    $('[data-bs-toggle="tooltip"]').tooltip();
}


var strFlag = "";
function Save_SubTab_Data(UserStoryID, SubTabFlag, pageFlag) {
    //End by swapna
    //Added by swapna
    if (pageFlag == undefined) {
        pageFlag = 0;
    }
    //end by swapna

    var objComplexity = document.getElementById("cboComplexity");
    var objPriority = document.getElementById("cboPriority");



    if (SubTabFlag == "SubStory") {

        //Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting
        var objSubComplexity = document.getElementById("SubcboComplexity");
        var objSubCategory = document.getElementById("SubcboCategory");
        //End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting


        var checkFlag = 0;
        var objSubStoryName, objSubStoryDesc;
        var selectedText = ""
        objSubStoryName = $('#txtSubStoryName');
        objSubStoryDesc = $('#txtSubStoryDesc');



        var checkFlag = 0;
        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"


        if ($("#txtSubStoryName").val() == "") {
            strmsg = '- Sub User Story name should not left blank.';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        else if ($("#txtSubStoryName").val() != "") {
            if (checkSpecialCharacter($("#txtSubStoryName").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Sub User Story name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtSubStoryName").focus();
                Flag = 1;
                checkFlag = 1;
            }
        }
        //End of Added By Riddhesh Patil
        if ($("#txtSubStoryDesc").val() == "") {
            strmsg = '- Sub User Story Description should not left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtSubStoryDesc").focus();
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        else if (checkSpecialCharacter($("#txtSubStoryDesc").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Sub User Story Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtSubStoryDesc").focus();
            Flag = 1;
            checkFlag = 1;
        }
        //End of Added By Riddhesh Patil
        if (document.getElementById("txtSubStoryDesc").value.length > 1000) {
            strmsg = '- Sub User Story Description should not greater than 1000 characters.';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#txtSubStoryDesc").focus();
            // $("#spanSubStoryDesc").html("Sub User Story Description should not greater than 2000 characters. You have entered " + document.getElementById("txtSubStoryDesc").value.length + " characters.");



        }

        if ($("#SubcboPriority").val() == "") {
            strmsg = '- Priority should not left blank.';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkFlag = 1;
            $("#SubcboPriority").focus();
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        if ($("#txtStoryPoint").val() != "") {
            if (checkSpecialCharacter($("#txtStoryPoint").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Story Point should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtStoryPoint").focus();
                Flag = 1;
                checkFlag = 1;
            }
        }
        //End of Added By Riddhesh Patil

        else {

            selectedText = document.getElementById("SubcboPriority").options[document.getElementById("SubcboPriority").selectedIndex].text;
            //alert(selectedText);
        }
        if (checkFlag == 1) {
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 15);

            }
            return;
        }




        var objPriority = document.getElementById("SubcboPriority");

        var objComplexityTemp;
        var PriorityTemp;
        if (objComplexity != null)
            objComplexityTemp = objComplexity.value;
        else
            objComplexityTemp = '';

        PriorityTemp = objPriority.value;

        var url1 = "frmProductBacklog.aspx/GetExistingUniqueNumberFromDB";
        var data1 = JSON.stringify({ objComplexity: objComplexityTemp, Priority: objPriority.value, strUserStoryId: UserStoryID });
        var result1 = ajaxCall(url1, "POST", "application/json", "json", data1, false);
        ExistingUniqueNo = result1.d;
        //debugger;
        //  alert(ExistingUniqueNo)
        switch (PriorityTemp) {

            case '1':
                UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '1');
                break;
            case '2':
                UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '2');
                break;
            case '3':
                UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '3');
                break;
            case '4':
                UniqueNo = GetComplexityUniqueNo(ExistingUniqueNo, objComplexityTemp, '4');
                break;
            default:

        }

        if (pageFlag != 0) {
            strUserStoryID = UserStoryID;
        }

        //Commented and Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting
        //var data = JSON.stringify({ strUserStoryID: UserStoryID, SubStoryName: objSubStoryName.val(), SubStoryDesc: objSubStoryDesc.val(), strPriority: selectedText, strRank: UniqueNo });
        var data = JSON.stringify({ strUserStoryID: UserStoryID, SubStoryName: objSubStoryName.val(), SubStoryDesc: objSubStoryDesc.val(), strPriority: selectedText, strRank: UniqueNo, Complexity: objSubComplexity.value, Category: objSubCategory.value });
        //End of Added by Usha Pandit On 26 March 2019 for Sub User Story Complexity and category control plotting

        if (pageFlag != 0) {
            var result = ajaxCall("UserStoryDetails.aspx/SaveSubStories", "POST", "application/json", "json", data);

        }
        else {
            var result = ajaxCall("frmProductBacklog.aspx/SaveSubStories", "POST", "application/json", "json", data);
            document.getElementById("divSubstoryList").innerHTML = result.d;
        }
        $('#txtSubStoryName').val('')
        $('#txtSubStoryDesc').val('')
        $('#SubcboPriority').val('')
        $('#SubcboComplexity').val('')
        $('#SubcboCategory').val('')
        if (pageFlag == 0) {

            ShowData('List', 'SubUS');
           // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
            //document.getElementById("divUserStories").innerHTML = strUserResult.d;
            //document.getElementById("tblUserStory_body").innerHTML = "";
            //document.getElementById("tblUserStory_body").innerHTML = strUserResult.d;
        }

        //added By Dipali V On 30th Mach 2018 For Sub Us Creation
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Sub User Story Created successfully', 'success', 25);
        if (pageFlag == 0) {
           // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 120) + 'px'
            $('[data-bs-toggle="tooltip"]').tooltip();
        }
        //End of added By Dipali V On 30th Mach 2018 For Sub Us Creation
    }

    else if (SubTabFlag == "Issue") {
        if (validateissue() == 0) {

            //   debugger
            var Summary = $("#txtSummary").val()
            var Description = $("#txtDescription").val()
            var IssueType = $("#cboIssueType").val()
            var SubIssueType = $("#cboSubIssueType").val()
            var reporter = $("#cboreporter").val()
            var Resonsible = $("#cboResonsible").val()
            var Status = $("#cboStatus").val()
            //Added by Swapna
            if (pageFlag != 0) {
                strUserStoryId = UserStoryID;
            }
            //End by Swapna
            var data = JSON.stringify({

                UserStoryId: strUserStoryId,
                Summary: Summary,
                Description: Description,
                IssueType: IssueType,
                SubIssueType: SubIssueType,
                reporter: reporter,
                Resonsible: Resonsible,
                Status: Status

            });
            //Added By Swapna
            if (pageFlag != 0) {
                var result = ajaxCall("UserStoryDetails.aspx/SaveUSIssue", "POST", "application/json", "json", data);

            }

            else {
                var result = ajaxCall("frmProductBacklog.aspx/SaveUSIssue", "POST", "application/json", "json", data);


            }
            //End by swapna
            if (result.d != "") {
                $("#txtSummary").val('')
                $("#txtDescription").val('')
                $("#cboIssueType").val('')
                $("#cboSubIssueType").val('')
                $("#cboreporter").val('')
                $("#cboResonsible").val('')
                $("#cboStatus").val('')
                if (result.d != 1) {

                    document.getElementById("divIssuesList").innerHTML = result.d;
                    //alert(1);
                    document.getElementById("txtSummary").style.height = "30px";
                    document.getElementById("txtDescription").style.height = "30px";
                    $("#countdownSummary").text(500);
                    $("#countdownSummary").css("color", "black");
                    $("#countdownDescription").text(1000);
                    ShowData('List', 'subIssue');
                    if ($("#FilterDivSubTabIssuesList").val() > 0) {
                        datatables('DivSubTabIssuesList', 'txtSearchIssue', '')
                    }
                    // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
                    // document.getElementById("divUserStories").innerHTML = strUserResult.d;
                    //added By Dipali V On 30th Mach 2018 For Sub Us Creation
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Issue Created successfully', 'success', 25);
                    //limitText("$txtSummary", countdownSummary, 500);
                    //ClearSpan('txtSummary', 'spanUserDesc');
                    AutoResizeTextArea();
                    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
                else {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Issue Created successfully', 'success', 25);
                }


            }
        }

    }
    else if (SubTabFlag == "Task") {

        if (validateTask() == 0) {

            // debugger;
            saveFlag = 1;
            var htRowCount = document.getElementsByName("hdrownumber");
            for (var i = 0; i < htRowCount.length; i++) {
                if (htRowCount[i] != null) {

                    var objTaskName = $('#txtTaskName' + htRowCount[i].value);
                    var objResource = $('#cboresource' + htRowCount[i].value);
                    var StoryPoints = $('#txtStoryPoints' + htRowCount[i].value).val();
                    var objWorkHrs = $('#txtWorkHrs' + htRowCount[i].value);
                    var objStartDate = $('#txtStartDate' + htRowCount[i].value);
                    var objEndDate = $('#txtEndDate' + htRowCount[i].value);

                    //  cboresource
                    var objPriorities = "";
                    // var objTaskType = "";
                    // var StoryPoints = ""
                    var BillableValue, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;


                    var PracticeID = 0;
                    var extraPara = [];
                    extraPara.push(htRowCount[i].value);
                    //extraPara.push(strPrimaryKey);

                    BillableValue = "0"
                    OnHoldValue = "0"

                    if (StoryPoints == "") {

                        StoryPoints = 0;

                    }
                    else {
                        StoryPoints = StoryPoints;

                    }


                    var objPhase = 0;
                    var objModule = 0;
                    var objSubProject = 0;
                    var objMilestone = 0;
                    var objChangeRequest = 0;
                    var objDeliverable = 0;


                    if (objPhase == 0)
                        PhaseVal = 0

                    if (objModule == 0)
                        ModuleVal = 0

                    if (objSubProject == 0)
                        SubProjectVal = 0

                    if (objMilestone == 0)
                        MilestoneVal = 0

                    if (objChangeRequest == 0)
                        ChangeRequestVal = 0

                    if (objDeliverable == 0)
                        DeliverableVal = 0
                }


                var URL, data;



                URL = 'frmProductBacklog.aspx/SaveTask';

                var AssignTaskData = [];

                AssignTaskData.push({
                    TaskID: 0,
                    TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                    Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                    MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                    UserStoryID: strUserStoryId, strEntity: "", StoryPoints: StoryPoints
                });

                data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: strUserStoryId, });
                // alert(data)
                AJAXCallWithPara(URL, data, AfterSaveTask, extraPara);
            }



        }




    }

    else if (SubTabFlag == "Review") {
        //added by swapna
        if (validateReview(pageFlag) == 0) {
            //end by swapna
            // var ResoureallIDs;
            var ReviewID = "0";
            var Reviewtitle = $('#txtReviewtitle').val();
            var Reviewtype = $('#cboReviewtype').val();
            var RevieweeWork = $('#txtReviewHrs').val();
            var ReviewStartDate = $('#txtReviewStartDate').val();
            var ReviewEnddate = $('#txtReviewEnddate').val();
            // var Reviewer = $('#cboReviewer option:selected').text();
            var Reviewer = $('#cboReviewer').val();

            var reviewstatus = $('#cboRevieStatus').val();
            var objTaskType = $('#cboTtypetask').val();
            var Reviewee = $('#cboReviewee').val();
            // var Reviewee = $('#cboReviewee option:selected').text();
            // var RevieweeWork = "";

            var RevieweeActualfrom = "";
            var RevieweeActualto = "";

            var ReviewPhase = "";
            var defects = "";
            var per = "";
            var unit = "";
            var reviewnote = "";
            //var reviewstatus = "";
            var billable;
            var billable = "0"
            var workproduct = "";
            var workproductname = "";
            var conculsion = "";
            var Delivariables = "";

            var Requestor = "";
            var Coordinator = "";
            var method = "";
            var Deviation = "";
            var Completion = "";
            var Disposition = "";
            var Checklist = $("#cboChecklist").val();


            //if (ReviewerIDs == "") {
            //    ReviewerIDs = 0;
            //}
            //else {

            //    var ReviewerIDs = $("#ReviewerIDs" + EntityID).val();
            //    var RevieweeIDs = $("#RevieweeIDs" + EntityID).val();
            //    //alert(ReviewerIDs);
            //}
            // var ResoureIDs = "";
            var ModuleID = "";
            var offline = "";
            if (Reviewee == null)
                Reviewee = ""

            else {
                offline = "0"
            }
            // StartLoader("CreateEditView");
            var MileStone = "";
            var ProjectID = "";
            // StartLoader("CreateEditView");
            var MileStone = "";
            //alert(ResoureIDs);
            //  alert(Reviwers);
            //Added by Swapna
            if (pageFlag != 0) {
                strUserStoryId = UserStoryID;
                var url = "UserStoryDetails.aspx/SaveReviewDetails";
            }
            else {

                var url = "frmProductBacklog.aspx/SaveReviewDetails";
            }
            //End by Swapna
            var data = JSON.stringify({
                ReviewID: ReviewID, Reviewtype: Reviewtype, Reviewtitle: Reviewtitle,
                Reviewer: String(Reviwers),
                offline: offline, Reviewee: String(ResoureIDs),
                ReviewPlanned: ReviewStartDate, ReviewPlannedto: ReviewEnddate,
                RevieweeWork: RevieweeWork, RevieweeActualfrom: RevieweeActualfrom,
                RevieweeActualto: RevieweeActualto, ReviewPhase: ReviewPhase,
                Delivariables: Delivariables, ModuleID: ModuleID,
                defects: defects, per: per, unit: unit, reviewnote: reviewnote,
                reviewstatus: reviewstatus, billable: billable, workproduct: workproduct,
                workproductname: workproductname, conculsion: conculsion, Requestor: Requestor,
                Coordinator: Coordinator, method: method, Deviation: Deviation, Completion: Completion,
                Disposition: Disposition, Checklist: Checklist, MileStone: MileStone,
                strEntityID: strUserStoryId, strEntity: ""
            })


            //StartLoader("#projectrisk")
            var result = AJAXCallWithResult(url, data, false);
            // var strResult = String(result.d).split("||");divReviewList
            var strResult = String(result.d)

            if (strResult != '') {
                //  debugger;
                $('#txtReviewtitle').val('');
                $('#cboReviewtype').val('');
                $('#txtReviewStartDate').val('');
                $('#txtReviewEnddate').val('');
                $('#cboReviewer').val('');
                $('#cboRevieStatus').val('');
                $('#cboTtypetask').val('');
                $('#cboReviewee').val('');
                $('#txtReviewHrs').val('');
                $('#txtReviewStartDate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    // yearRange: '2000:2060'
                    yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
                });
                $('#txtReviewEnddate').datepicker({
                    changeMonth: true,
                    changeYear: true,
                    // yearRange: '2000:2060'
                    yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
                });
                //Added by swapna
                if (pageFlag == 0) {
                    document.getElementById('divReviewList').innerHTML = "";
                    document.getElementById('divReviewList').innerHTML = result.d;

                    ShowData('List', 'subReview');
                    if ($("#FilterDivReviewList").val() > 0) {
                        datatables('DivReviewList', 'txtSearchReviews', '')
                    }

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Review Created successfully', 'success', 25);
                    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
                    $('[data-bs-toggle="tooltip"]').tooltip();
                }
                else {
                    $('#txtReviewHrs').val('');
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Review Created successfully', 'success', 25);
                    ShowDataReviewTable();
                }
                //end by swapna
            }
            //if (strResult.length > 0) {
            //    if (strResult.length == 1) {
            //        document.getElementById("SpnMainReview" + EntityID).innerHTML = strResult[0];
            //    }
            //    else {
            //        document.getElementById("SpnMainReview" + EntityID).innerHTML = strResult[0];
            //        document.getElementById("SpnMainReview" + strResult[1]).innerHTML = strResult[2];
            //    }
            //}
            // StopAjaxLoader("CreateEditView")
        }




    }

}

function AJAXCallWithPara(url, data, method, para) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        contentType: "application/json",
        //timeout: 180000,
        success: function (result) {
            method(result, para);
            // $(".loadingoverlay", parent.document).css("display", "none");
            // Stop();
        },
        error: function (xhr, status, error) {
            // Stop();
            // StopAjaxLoader("body");
            // $(".loadingoverlay", parent.document).css("display", "none");
            console.log(xhr.responseText);
            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

}
function AfterSaveTask(data, extraPara) {
    var Id = extraPara[0];
    //$('#txtTaskName' + Id).val('');
    //$('#cboresource' + Id).val('');
    //$('#txtWork'+ Id).val('');
    //$('#txtStartDate').val('');
    //$('#tASKEnddate').val('');
    //$('#cboPrioritytask').val('');
    //$('#cboTtypetask').val('');
    //$('#txtStoryPoints').val('');
    var strProjectID = document.getElementById('hdnProjectID').value;
    document.getElementById("divTasks").innerHTML = data.d;
    // ShowData('List', 'subTask');
    //  datatables('DivTaskList', 'txtSearchTask', '')
    // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
    // document.getElementById("divUserStories").innerHTML = strUserResult.d;
    //added By Dipali V On 30th Mach 2018 For Sub Us Creation
    alertify.set('notifier', 'position', 'top-right');
    alertify.notify('Task Created successfully', 'success', 25);
    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
    $('[data-bs-toggle="tooltip"]').tooltip();
    isValid = 0;
    saveFlag = 0;


}

function EditTask(UserStoryID, TaskID) {

    if (TaskID != "") {
        var strProjectID = document.getElementById('hdnProjectID').value;
        $('[data-bs-toggle="tooltip"]').tooltip();
        $("#tblProjectDetail").find("#txtStartDate" + TaskID).removeAttr("disabled")
        $("#tblProjectDetail").find("#txtEndDate" + TaskID).removeAttr("disabled")
        $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
        $("#tblProjectDetail").find("#txtWorkHrs" + TaskID).removeAttr("disabled")
        $("#tblProjectDetail").find("#dpEnddate" + TaskID).removeAttr("disabled")
        $("#tblProjectDetail").find("#dpstartdate" + TaskID).removeAttr("disabled")
        $('#txtEndDate' + TaskID).datepicker();
        $('#txtStartDate' + TaskID).datepicker();
        $("#Update" + TaskID).html("");
        //cboresource
        document.getElementById('Update' + TaskID).innerHTML = "<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  id='UpdateBtn' data-bs-toggle='tooltip' title='Update Task' class='fa fa-refresh' onclick=UpdateTask(" + TaskID + ") ></i>"

        // var strmsg = "";
        // var errorMsg = "<ul>"


        //if ($("#txtStartDate" + TaskID).val() == "")
        //{       
        //    strmsg = '- Start Date should not left blank.';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //    $("#txtStartDate" + TaskID).focus();
        //}


        //if ($("#txtEndDate" + TaskID).val() == "") {
        //    strmsg = '- End Date should not left blank.';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //    $("#txtEndDate" + TaskID).focus();
        //}


        //if ($("#txtWorkHrs" + TaskID).val() == "") {
        //    strmsg = '- WorkHrs should not left blank.';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //    $("#txtWorkHrs" + TaskID).focus();
        //}

        //if ($("#cboresource" + TaskID).val() == "") {
        //    strmsg = '- Resource should not left blank.';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //    $("#txtWorkHrs" + TaskID).focus();
        //}


        //var InitialEstimate = $("#txtStoryPoint").val();


        //if ($("#txtStoryPoints" + TaskID).val() > InitialEstimate) {

        //    strmsg = '- Story Point should be less than ' + InitialEstimate + '(assigned on User story)';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkFlag = 1;
        //    $("#txtStoryPoints" + TaskID).focus();

        //}

        //if ($("#hdnInitialEstimate").val() < $("#hdnSumEfforts").val()) {

        //    strmsg = '- The sum of tasks was greater that Story point of User Story.';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //    $("#txtStoryPoints" + TaskID).focus();

        //}

        //if (strmsg != "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify(errorMsg, 'error', 15);

        //}
        //return checkFlag;
        //return isValid;
    }
}

function validateupdatetask(TaskID) {
    // debugger;
    var strmsg = "";
    var checkFlag = 0;
    var ProjectID = document.getElementById('hdnProjectID').value;
    var errorMsg = "<ul>"
    var dtStartDate = document.getElementById('txtStartDate' + TaskID);
    var dtEndDate = document.getElementById('txtEndDate' + TaskID);

    if ($("#txtStartDate" + TaskID).val() == "") {
        strmsg = '- Start Date should not left blank.';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
        $("#txtStartDate" + TaskID).focus();
    }


    if ($("#txtEndDate" + TaskID).val() == "") {
        strmsg = '- End Date should not left blank.';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
        $("#txtEndDate" + TaskID).focus();
    }



    if (CompairDates(dtStartDate, dtEndDate) == 1) {
        strmsg = '- Task Start date should not be less than Task End date';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        //$("#txtReviewEnddate").focus();

    }


    if (checkFlag == 0) {
        var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + TaskID).val(), EndDate: $("#txtEndDate" + TaskID).val() });
        var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

        if (Newresult.d != '') {
            var arrResult = Newresult.d.split('##');

            if (arrResult[0] == '1') {


                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }
            if (arrResult[0] == '2') {
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;

            }

            if (arrResult[0] == '3') {
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }
        }

    }







    if ($("#txtWorkHrs" + TaskID).val() == "") {
        strmsg = '- Work(Hrs) should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
        $("#txtWorkHrs" + TaskID).focus();
    }

    if ($("#txtWork" + TaskID != "")) {
        if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + TaskID)) == true) {


            strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
            errorMsg += "<li>" + strmsg + "</li></br>";
            isValid = 1;
            checkFlag = 1;
        }

        else if (($("#txtWorkHrs" + TaskID).val() - 0) == 0) {

            strmsg = '- Please Enter only  Work(Hrs) greater than 0';
            errorMsg += "<li>" + strmsg + "</li></br>";
            isValid = 1;
            checkFlag = 1;

        }

        else if (parseFloat($("#txtWorkHrs" + TaskID).val()) < 0 && $("#txtWorkHrs" + TaskID).val() != '') {

            strmsg = '- Please enter positive Value For  Work(Hrs)';
            errorMsg += "<li>" + strmsg + "</li></br>";
            isValid = 1;
            checkFlag = 1;
            $("#txtWorkHrs").focus();

        }

    }

    if ($("#cboTaskType" + TaskID).val() == "0") {
        strmsg = '- Task Type should not left blank.';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
        $("#cboTaskType" + TaskID).focus();
    }


    if ($("#cboresource" + TaskID).val() == "0") {
        strmsg = '- Resource should not left blank.';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
        $("#cboresource" + TaskID).focus();
    }




    if ($("#txtStoryPoints" + TaskID).val() != "") {
        if (RestrictNonNumeric(document.getElementById('txtStoryPoints')) == true) {


            strmsg = '- Please Enter  only positive numeric value  For Story Point';
            errorMsg += "<li>" + strmsg + "</li></br>";
            isValid = 1;
            checkFlag = 1;
        }
    }

    if ($("#txtStoryPoints" + TaskID).val() == "0") {


        strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
        errorMsg += "<li>" + strmsg + "</li></br>";
        isValid = 1;
        checkFlag = 1;
    }


    if (checkFlag == 0) {
        var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + TaskID).val() });
        var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);

        if (Newresult.d != '') {
            strmsg = Newresult.d;
            errorMsg += "<li>" + strmsg + "</li></br>";
            isValid = 1;
            checkFlag = 1;
            $("#txtStoryPoints" + TaskID).focus();
        }
    }
    //var InitialEstimate = ($("#txtStoryPoint").val() - 0);
    //if (($("#txtStoryPoints" + TaskID).val() - 0) > InitialEstimate) {

    //    strmsg = '- Story Point should be less than ' + InitialEstimate + '(assigned on User story)';
    //    errorMsg += "<li>" + strmsg + "</li></br>";
    //    Flag = 1;
    //    checkFlag = 1;
    //    $("#txtStoryPoints" + TaskID).focus();

    //}

    //if (($("#hdnInitialEstimate").val() - 0) < ($("#hdnSumEfforts").val() - 0)) {

    //    strmsg = '- The sum of tasks was greater that Story point of User Story.';
    //    errorMsg += "<li>" + strmsg + "</li></br>";
    //    isValid = 1;
    //    checkFlag = 1;
    //    $("#txtStoryPoints" + TaskID).focus();

    //}



    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkFlag;
    return isValid;

}

function UpdateTask(TaskID) {
    $('[data-bs-toggle="tooltip"]').tooltip();
    if (TaskID != "") {
        // debugger;


        if (validateupdatetask(TaskID) == 0) {

            saveFlag = 1;

            var objTaskName = $('#txtTaskName' + TaskID);
            var objResource = $('#cboresource' + TaskID);
            var objWorkHrs = $('#txtWorkHrs' + TaskID);
            var objStartDate = $('#txtStartDate' + TaskID);
            var objEndDate = $('#txtEndDate' + TaskID);
            var objPriorities = "";
            var objTaskType = "";
            var StoryPoints = $('#txtStoryPoints' + TaskID);
            var BillableValue, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;


            var PracticeID = 0;
            var extraPara = [];
            extraPara.push(TaskID);
            //extraPara.push(strPrimaryKey);

            BillableValue = "0"
            OnHoldValue = "0"

            if (StoryPoints == "") {

                StoryPoints = 0;
            }

            var objPhase = 0;
            var objModule = 0;
            var objSubProject = 0;
            var objMilestone = 0;
            var objChangeRequest = 0;
            var objDeliverable = 0;


            if (objPhase == 0)
                PhaseVal = 0

            if (objModule == 0)
                ModuleVal = 0

            if (objSubProject == 0)
                SubProjectVal = 0

            if (objMilestone == 0)
                MilestoneVal = 0

            if (objChangeRequest == 0)
                ChangeRequestVal = 0

            if (objDeliverable == 0)
                DeliverableVal = 0

            var URL, data;



            URL = 'frmProductBacklog.aspx/SaveTask';

            var AssignTaskData = [];

            AssignTaskData.push({
                TaskID: TaskID,
                TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                UserStoryID: strUserStoryId, strEntity: "", StoryPoints: StoryPoints.val()
            });

            data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: strUserStoryId, });
            //alert(data)
            AJAXCallWithPara(URL, data, AfterEditTask, extraPara);


        }



    }



    $('[data-bs-toggle="tooltip"]').tooltip();
    $('#txtEndDate').datepicker();
    $('#txtStartDate').datepicker();

}

function DeleteTask(USID, taskId) {
    // debugger;
    var extraPara = [];
    extraPara.push(taskId);
    //var AssignDeletetaskData = [];
    URL = 'frmProductBacklog.aspx/AfterDeleteTask';
    //AssignDeletetaskData.push({
    //    taskId: taskId

    //});

    data = JSON.stringify({ taskId: taskId, UserStoryId: strUserStoryId, });
    AJAXCallWithPara(URL, data, AfterDeleteTask, extraPara);
    $('#txtEndDate').datepicker();
    $('#txtStartDate').datepicker();
    $('[data-bs-toggle="tooltip"]').tooltip();
}
function AfterDeleteTask(data, extraPara) {
    var Id = extraPara[0];

    var strProjectID = document.getElementById('hdnProjectID').value;
    document.getElementById("divTasks").innerHTML = data.d;

    alertify.set('notifier', 'position', 'top-right');
    alertify.notify('Task Deleted successfully', 'success', 25);
    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
    $('[data-bs-toggle="tooltip"]').tooltip();
    $('#txtEndDate').datepicker();
    $('#txtStartDate').datepicker();
    isValid = 0;
    saveFlag = 0;


}

function AfterEditTask(data, extraPara) {
    var Id = extraPara[0];
    //$('#txtTaskName' + Id).val('');
    //$('#cboresource' + Id).val('');
    //$('#txtWork'+ Id).val('');
    //$('#txtStartDate').val('');
    //$('#tASKEnddate').val('');
    //$('#cboPrioritytask').val('');
    //$('#cboTtypetask').val('');
    //$('#txtStoryPoints').val('');
    var strProjectID = document.getElementById('hdnProjectID').value;
    document.getElementById("divTasks").innerHTML = data.d;
    // ShowData('List', 'subTask');
    //  datatables('DivTaskList', 'txtSearchTask', '')
    // var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterData", "POST", "application/json", "json", JSON.stringify({ strEntityID: "", strEntity: "" }));
    // document.getElementById("divUserStories").innerHTML = strUserResult.d;
    //added By Dipali V On 30th Mach 2018 For Sub Us Creation
    alertify.set('notifier', 'position', 'top-right');
    alertify.notify('Task Update successfully', 'success', 25);
    // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
    $('[data-bs-toggle="tooltip"]').tooltip();

    isValid = 0;
    saveFlag = 0;

}



function validateReview(pageFlag) {

    // debugger;
    var checkFlag = 0;
    var Flag = 0;
    var strmsg = "";
    var errorMsg = "<ul>"
    var dtStartDate, dtEndDate;
    if (pageFlag == 0) {

        var ProjectID = document.getElementById('hdnProjectID').value;
    }
    else {

        var ProjectID = pageFlag;
    }
    dtStartDate = document.getElementById("txtReviewStartDate");
    dtEndDate = document.getElementById("txtReviewEnddate");

    if ($("#txtReviewtitle").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Review title should not left blank.';
        strmsg = ' Review title should not left blank.';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#txtReviewtitle").focus();
    }

    if ($("#cboReviewtype").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Review type should not left blank';
        strmsg = ' Review type should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboReviewtype").focus();
    }
    //Added By Dipali On 23rd April 2018 For Validate new Fiedls Work Hrs


    if ($("#txtReviewStartDate").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        // strmsg = '- Review Start Date should not left blank';
        strmsg = ' Review Start Date should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        // $("#txtReviewStartDate").focus();
    }

    if ($("#txtReviewEnddate").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Review End date should not left blank';
        strmsg = ' Review End date should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        // $("#txtReviewEnddate").focus();
    }

    if (CompairDates(dtStartDate, dtEndDate) == 1) {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Review Start date should be less than Review End date';
        strmsg = ' Review Start date should be less than Review End date';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        //$("#txtReviewEnddate").focus();

    }

    //alert($("#txtUserStoryID").text());
    //Added by Usha Pandit on 07.06.2019 for checking sprint start date and end date validation
    if (dtStartDate.value != '' && checkFlag == 0) {
        var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: $("#txtUserStoryID").text().trim(), strStartDate: dtStartDate.value, strEndDate: dtEndDate.value }), false);
        if (result.d != "") {
            var strMsg = String(result.d).split("_");
            if (strMsg[0] == "1") {
                // $('#spndtStartDate').text(strMsg[1]);
                //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                //strmsg = '- ' + strMsg[1];
                strmsg = ' ' + strMsg[1];
                if (strmsg.indexOf('Task') > -1) {
                    strmsg = strmsg.replace('Task', 'Review');
                }
                //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                errorMsg += "<li>" + strmsg + "</li></br>";

            }
            else {
                //$('#spndtEndDate').text(strMsg[1]);
                //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                //strmsg = '- ' + strMsg[1];
                strmsg = ' ' + strMsg[1];
                if (strmsg.indexOf('Task') > -1) {
                    strmsg = strmsg.replace('Task', 'Review');
                }
                //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                errorMsg += "<li>" + strmsg + "</li></br>";

            }
            Flag = 1;
            checkFlag = 1;
        }
    }
    //Added by Usha Pandit on 07.06.2019 for checking sprint start date and end date validation
    if (checkFlag == 0) {

        var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
        var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

        if (result.d != '') {

            var arrResult = result.d.split('##');

            if (arrResult[0] == '1') {

                //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                //strmsg = '-' + arrResult[1];
                strmsg = '' + arrResult[1];
                //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
            }
            if (arrResult[0] == '2') {
                //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                //strmsg = '-' + arrResult[1];
                strmsg = '' + arrResult[1];
                //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
            }

            if (arrResult[0] == '3') {
                //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                //strmsg = '-' + arrResult[1];
                strmsg = '' + arrResult[1];
                //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkFlag = 1;
            }
        }

    }

    if ($("#cboReviewer").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Reviewer should not left blank';
        strmsg = ' Reviewer should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboReviewer").focus();
    }

    if ($("#cboReviewee").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Reviewee should not left blank';
        strmsg = ' Reviewee should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboReviewee").focus();
    }

    if ($("#cboRevieStatus").val() == "" || $("#cboRevieStatus").val() == null) {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Status should not left blank';
        strmsg = ' Status should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboRevieStatus").focus();
    }

    if ($("#txtReviewHrs").val() == "") {
        //Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        //strmsg = '- Work Hrs should not left blank';
        strmsg = ' Work Hrs should not left blank';
        //End of Commented and added by Chetan M on 19th Aug 2020 for IssueID = 25462
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#txtReviewHrs").focus();
    }

    if ($("#txtReviewHrs").val() != "" && checkFlag == 0) {
        //debugger;
        //Added by swapna
        //if (RestrictNonNumeric(document.getElementById('txtReviewHrs')) == true) {


        //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //}

        //Commented and added by Ankush T on 29 mar 2019 work field changes

        //if (isNaN($("#txtReviewHrs").val()) == true) {


        //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    isValid = 1;
        //    checkFlag = 1;
        //}
        //    //End by swapna
        //else if (($("#txtReviewHrs").val() - 0) == 0) {
        //    strmsg = '- Work(Hrs) should be  more than 0';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkFlag = 1;
        //}

        //else if (($("#txtReviewHrs").val() - 0) > 24) {
        //    strmsg = '-  one day you can assign only 24 hrs';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkFlag = 1;
        //}

        //else if (parseFloat($("#txtReviewHrs").val()) < 0 && $("#txtReviewHrs").val() != '') {
        //    //alert('Please enter positive number');
        //    // alertify.set('notifier', 'position', 'top-right');
        //    // alertify.notify('- Please enter positive Value For Category Order.', 'error');
        //    strmsg = '- Please enter positive Value For Work(Hrs)';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkFlag = 1;
        //    $("#txtReviewHrs").focus();

        //}

        //debugger;
        var blnHMFormat = true;
        var objHMEffort = document.getElementById('txtReviewHrs');
        var objVal = objHMEffort.value;
        var objnewVal = objHMEffort.value;

        objHMEffort.value = objHMEffort.value.replace(":", ".");
        var isdigit = isNumeric(objHMEffort.value);
        objHMEffort.value = objVal;
        if (blnHMFormat == true) {
            if (isdigit == false) {
                strmsg = 'Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                blnHMFormat = false;
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewHrs").focus();
            }
        }

        if (objHMEffort.value.indexOf(":") == -1) {
            //strmsg = 'Please enter efforts in valid format hh:mm!!';
            //errorMsg += "<li>" + strmsg + "</li></br>";
            //blnHMFormat = false;
            ////setFocus(objHMEffort);
            //isValid = 1;
            //checkFlag = 1;
            objHMEffort.value = objnewVal + ':00';
            objnewVal = objHMEffort.value;
        }

        if (objHMEffort.value.indexOf(":") != -1) {
            objHMEffort.value = objHMEffort.value.replace(':', '.');
        }

        //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
        var tempEffort = objHMEffort.value.replace('-', '');
        if (checkSpecialCharacter(tempEffort) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = 'Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            objHMEffort.value = objVal;
            Flag = 1;
            checkFlag = 1;
            $("#txtReviewHrs").focus();
        }

        //if (blnResult == true) {
        //    isValid = 1;
        //    checkFlag = 1;
        //}

        //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
        if (blnHMFormat == true) {
            if (RestrictNonNumeric(document.getElementById('txtReviewHrs')) == true) {
                strmsg = 'Please enter Work(Hrs) in H:M format.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                objHMEffort.value = objVal;
                blnHMFormat = false;
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewHrs").focus();
            }
        }
        //if (blnResult == true) {
        //    isValid = 1;
        //    checkFlag = 1;
        //}

        objHMEffort.value = objHMEffort.value.replace('.', ':');



        var WorkHour = objHMEffort.value;

        WorkHour = WorkHour.trim();
        var idxColon = WorkHour.indexOf(':');

        var hrs = WorkHour.substring(0, idxColon);


        var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

        if (mins.length == 1 && mins > 5) {
            mins = mins + "0";
        }
        if (blnHMFormat == true) {
            if (mins == "") {
                //mins = "00";
                strmsg = "Please enter Work(Hrs) in H:M format.";
                errorMsg += "<li>" + strmsg + "</li></br>";
                blnHMFormat = false;
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewHrs").focus();
            }

            if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                strmsg = 'Hours should not be less than or equal to zero (0).';
                errorMsg += "<li>" + strmsg + "</li></br>";
                blnHMFormat = false;
                Flag = 1;
                checkFlag = 1;
                $("#txtReviewHrs").focus();
            }

            // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
            if (blnHMFormat == true) {
                if (mins.length > 2) {
                    strmsg = 'Please enter minutes in two decimal and less than 60.';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    blnHMFormat = false;
                    Flag = 1;
                    checkFlag = 1;
                    $("#txtReviewHrs").focus();
                }
            }
            // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015
            if (blnHMFormat == true) {
                if (mins > 59 || mins < 0) {
                    strmsg = 'Please enter minutes between (0-59) range';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    blnHMFormat = false;
                    Flag = 1;
                    checkFlag = 1;
                    $("#txtReviewHrs").focus();
                }
            }
        }

        //Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

        if (dtStartDate.value != "" && dtEndDate.value != "") {

            var dblTotalDuration = DateDiff(dtStartDate.value, dtEndDate.value, "d") + 1;

            var data = JSON.stringify({ HMHours: WorkHour });
            var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
            var dblTotalWork = decTotalWorkResult.d;

            dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
            // alert(dblAvgHoursPerDay);
            // alert(dblTotalDuration);
            if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////                           

                strmsg = 'You cannot assign more than 24 hours work per day';
                errorMsg += "<li>" + strmsg + "</li></br>";
                blnHMFormat = false;
                isValid = 1;
                checkFlag = 1;
            }
        }
        //End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

        var MinDAENtryDisplay = "";

        var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
        var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

        var MinDAEntry = resMinHoursForDAEntry.d;

        if (MinDAEntry == 0.25) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:15"
        }
        else if (MinDAEntry == 0.50) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:30"
        }
        else if (MinDAEntry == 0.75) {
            MinDAEntry = MinDAEntry
            MinDAENtryDisplay = "00:45"
        }

        var data = JSON.stringify({ Flag: "RestrictByMinHours" });
        var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

        if (resRestrictByMinHours.d == 'True') {
            if (MinDAEntry == 0.016) {
            }
            else {
                var minutes = WorkHour.split(':');

                var p = minutes[0];
                var dec = minutes[1];

                if (dec != undefined) {
                    if (dec.length > 2) {
                        dec = dec.substring(0, 2);
                    }
                    if (dec.length == 1) {
                        dec = dec + "0";
                    }

                    if (dec == undefined) { dec = 0; }
                    d = (dec - 0) / 60 + (p - 0);

                    if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                        //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                        if (blnHMFormat == true) {
                            strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                            errorMsg += "<li>" + strmsg + "</li></br>";
                            Flag = 1;
                            checkFlag = 1;
                            $("#txtReviewHrs").focus();
                        }
                    }
                }
            }
        }
        if (checkFlag == 1) {
            objHMEffort.value = objVal;
        }
        else {

            if (objHMEffort.value.toString().indexOf(":") != -1) {
                var chkhr = objHMEffort.value.split(":")[0];
                var chkmin = objHMEffort.value.split(":")[1];
                if (chkhr.length == 1) {
                    chkhr = "0" + chkhr;
                    objHMEffort.value = chkhr + ":" + chkmin;
                }
                if (chkmin.length == 1) {
                    chkmin = chkmin + "0";
                    objHMEffort.value = chkhr + ":" + chkmin;
                }
            }
        }
        //End of Commented and added by Ankush T on 29 mar 2019 work field changes

    }
    //End of Added By Dipali On 23rd April 2018 For Validate new Fiedls Work Hrs



    if (strmsg != "") {

        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkFlag;


}


function validateissue() {
    //   debugger;
    var checkFlag = 0;
    var Flag = 0;
    var strmsg = "";
    var errorMsg = "<ul>"


    if ($("#txtSummary").val() == "") {
        strmsg = '- Summary should not left blank.';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#txtSummary").focus();
    }

    if ($("#txtDescription").val() == "") {
        strmsg = '- Description should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#txtDescription").focus();
    }

    if ($("#cboIssueType").val() == "" || $("#cboIssueType").val() == null) {
        strmsg = '- Issue Type should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboIssueType").focus();
    }

    if ($("#cboSubIssueType").val() == "" || $("#cboSubIssueType").val() == null) {
        strmsg = '- Sub Issue Type should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboSubIssueType").focus();
    }

    if ($("#cboreporter").val() == "" || $("#cboreporter").val() == null) {
        strmsg = '- Reported By should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboreporter").focus();
    }
    //Commented And Added By Usha Pandit On 17.07.2020 For Responsible Person validation
    //if ($("#cboResonsible").val() == "") {
    if ($("#cboResonsible").val() == "" || $("#cboResonsible").val() == null) {
        //End Of Added By Usha Pandit On 17.07.2020 For Responsible Person validation
        strmsg = '- Responsible Person should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboResonsible").focus();
    }

    if ($("#cboStatus").val() == "") {
        strmsg = '- Status should not left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkFlag = 1;
        $("#cboStatus").focus();
    }


    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkFlag;


}

function ClearSpans() { }

var isValid = 0;
function validateTask() {
    // debugger;
    var checkFlag = 0;
    // debugger;
    var strmsg = "";
    var errorMsg = "<ul>"
    var dtStartDate = "", dtEndDate = "";
    var ProjectID = document.getElementById('hdnProjectID').value;
    var InitialEstimate = $("#txtStoryPoint").val();
    var htRowCount = document.getElementsByName("hdrownumber");
    // alert(InitialEstimate);
    for (var i = 0; i < htRowCount.length; i++) {
        if (htRowCount[i] != null) {
            //if ($("#txtReviewtitle" + htRowCount[i].value).val() == 0) {
            //    Flag = 1;
            //    checkFlag = 1;
            //    $("#txtReviewtitle" + htRowCount[i].value).css("border", "1px solid red");
            //}
            dtStartDate = document.getElementsByName("txtStartDate" + htRowCount[i].value);
            dtEndDate = document.getElementsByName("txtEndDate" + htRowCount[i].value);

            if ($("#txtTaskName" + htRowCount[i].value).val() == "") {
                strmsg = '- Task Name should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtTaskName" + htRowCount[i].value).focus();
            }


            if ($("#txtStartDate" + htRowCount[i].value).val() == "") {
                strmsg = '- Start Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                // $("#txtStartDate" + htRowCount[i].value).focus();
            }

            if ($("#txtEndDate" + htRowCount[i].value).val() == "") {
                strmsg = '- End Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if (CompairDates(dtStartDate, dtEndDate) == 1) {
                strmsg = '- Task Start date should not be less than Task End date';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtReviewEnddate").focus();

            }


            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#txtStartDate" + htRowCount[i].value).val(), EndDate: $("#txtEndDate" + htRowCount[i].value).val() });
                var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                if (Newresult.d != '') {
                    var arrResult = Newresult.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }

                    //if (arrResult[0] == '3') {
                    //    strmsg = '-' + arrResult[1];
                    //    errorMsg += "<li>" + strmsg + "</li></br>";
                    //    isValid = 1;
                    //    checkFlag = 1;
                    //}
                }

            }







            if ($("#txtWorkHrs" + htRowCount[i].value).val() == "") {
                strmsg = '- Work(Hrs) should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#txtWorkHrs" + htRowCount[i].value).focus();
            }

            if ($("#txtWork" + htRowCount[i].value).val() != "") {
                if (RestrictNonNumeric(document.getElementById('txtWorkHrs' + htRowCount[i].value)) == true) {


                    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }

                else if (($("#txtWorkHrs" + htRowCount[i].value).val() - 0) == 0) {

                    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;

                }

                else if (parseFloat($("#txtWorkHrs" + htRowCount[i].value).val()) < 0 && $("#txtWorkHrs" + htRowCount[i].value).val() != '') {

                    strmsg = '- Please enter positive Value For  Work(Hrs)';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtWorkHrs").focus();

                }


            }


            if ($("#txtStoryPoints" + htRowCount[i].value).val() != "") {
                if (RestrictNonNumeric(document.getElementById('txtStoryPoints' + htRowCount[i].value)) == true) {


                    strmsg = '- Please Enter only positive numeric value For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }




            }

            if ($("#txtStoryPoints" + htRowCount[i].value).val() == "0") {


                strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }



            if (checkFlag == 0) {
                var data = JSON.stringify({ UserStoryID: $("#hdnusid").val(), StoryPoints: $("#txtStoryPoints" + htRowCount[i].value).val() });
                var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);

                if (Newresult.d != '') {
                    strmsg = Newresult.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#txtStoryPoints" + htRowCount[i].value).focus();
                }
            }


            if ($("#cboTaskType" + htRowCount[i].value).val() == "0") {
                strmsg = '- Task Type should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboTaskType" + htRowCount[i].value).focus();
            }




            if ($("#cboresource" + htRowCount[i].value).val() == "0") {
                strmsg = '- Resource should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboresource" + htRowCount[i].value).focus();
            }








        }
    }
    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkFlag;
    return isValid;

}
function ShowData(type, WhichTab) {
    // debugger;
    if (WhichTab == 'SubUS') {
        if (type == 'List') {
            $("#divSubstoryList").css("display", "")
            $("#divSubstoryForm").css("display", "none")
        }
        else if (type == "Form") {
            $("#divSubstoryList").css("display", "none")
            $("#divSubstoryForm").css("display", "")
            $('#txtSubStoryName').val('');
            $('#txtSubStoryDesc').val('');
            $('#SubcboPriority').val('');
        }
    }
    else if (WhichTab == 'subTask') {
        if (type == 'List') {
            $("#divTaskList").css("display", "")
            $("#divTaskForm").css("display", "none")
        }
        else if (type == "Form") {
            $('#txtTaskName').val('');
            $('#cboresource').val('');
            $('#txtWork').val('');
            $('#txtStartDate').val('');
            $('#txtEnddate').val('');
            $('#cboPrioritytask').val('');
            $('#cboTtypetask').val('');
            $('#txtStoryPoints').val('');
            $("#divTaskList").css("display", "none")
            $("#divTaskForm").css("display", "")
            AutoResizeTextArea();
            RemoveTextArea();
        }
    }
    else if (WhichTab == 'subIssue') {
        if (type == 'List') {
            $("#divIssuesList").css("display", "")
            $("#divIssueForm").css("display", "none")
        }
        else if (type == "Form") {
            $("#txtSummary").val('')
            $("#txtDescription").val('')
            $("#cboIssueType").val('')
            $("#cboSubIssueType").val('')
            $("#cboreporter").val('')
            $("#cboResonsible").val('')
            $("#cboStatus").val('')
            // ID = ' txtReported'
            // timeNow(ID);
            $("#divIssuesList").css("display", "none")
            $("#divIssueForm").css("display", "")
        }
    }
    else if (WhichTab == 'subReview') {
        if (type == 'List') {
            $("#divReviewList").css("display", "")
            $("#divReviewForm").css("display", "none")
        }
        else if (type == "Form") {
            $('#txtReviewtitle').val('');
            $('#cboReviewtype').val('');
            $('#txtReviewStartDate').val('');
            $('#txtReviewEnddate').val('');
            $('#cboReviewer').val('');
            $('#cboRevieStatus').val('');
            $('#cboTtypetask').val('');
            $('#cboReviewee').val('');
            ResoureIDs = "";
            Reviwers = "";
            // timeNow(ID);
            $("#divReviewList").css("display", "none")
            $("#divReviewForm").css("display", "")

            $(".k-checkboxcboReviewer").each(function () {
                $(this).prop('checked', false);
            });

            $(".k-checkbox").each(function () {
                $(this).prop('checked', false);
            });

            // alert();
            //   $('#cboReviewer').val($("#hdnstrUserName").val());

        }
    }
}

function timeNow(i) {
    var d = new Date(),
        h = (d.getHours() < 10 ? '0' : '') + d.getHours(),
        m = (d.getMinutes() < 10 ? '0' : '') + d.getMinutes();
    i.value = h + ':' + m;
}

(function (window) {
    function triggerCallback(e, callback) {
        if (!callback || typeof callback !== 'function') {
            return;
        }
        var files;
        if (e.dataTransfer) {
            files = e.dataTransfer.files;
        } else if (e.target) {
            files = e.target.files;
        }
        callback.call(null, files);
    }
    function makeDroppable(ele, callback) {
        // debugger;
        var input = document.createElement('input');
        input.setAttribute('type', 'file');
        input.setAttribute('multiple', true);
        input.style.display = 'none';
        input.addEventListener('change', function (e) {
            triggerCallback(e, callback);
        });
        ele.appendChild(input);

        ele.addEventListener('dragover', function (e) {
            e.preventDefault();
            e.stopPropagation();
            ele.classList.add('dragover');
        });

        ele.addEventListener('dragleave', function (e) {
            e.preventDefault();
            e.stopPropagation();
            ele.classList.remove('dragover');
        });

        ele.addEventListener('drop', function (e) {
            e.preventDefault();
            e.stopPropagation();
            ele.classList.remove('dragover');
            triggerCallback(e, callback);
        });

        ele.addEventListener('click', function () {
            input.value = null;
            input.click();
        });
        ele.addEventListener('dragenter', function (event) {
            if (event.preventDefault)
                event.preventDefault();

        });
        ele.addEventListener("dragover", function (e) {
            e.stopPropagation();
            e.preventDefault();
            e.dataTransfer.dropEffect = 'copy';
            //e.dataTransfer.effectAllowed = "move";
        });

    }
    window.makeDroppable = makeDroppable;
})(this);

// Added By Gauri On 16th Sep 2024 For Tooltip Overlapping Issue
function disposeTooltip(){
    var tooltipTrigger = document.querySelector('[data-bs-toggle="tooltip"]');
    var tooltip = bootstrap.Tooltip.getInstance(tooltipTrigger); 
    if (tooltip) {
        tooltip.dispose(); 
    }
    new bootstrap.Tooltip(tooltipTrigger);
}
// End of Added By Gauri On 16th Sep 2024 For Tooltip Overlapping Issue

async function UploadData(userStoryID) {
    //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


    if (arrFile[0] != "") {
        var objtxtFileName = arrFile[0].name;
        var objFile = objtxtFileName;
        var fileName = objtxtFileName;
        var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


        isValidTypeExeCheck = false;
        //var fileName = arrFile[0];
        //    var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

        //  var objFileName = arrFile[0] ;
        isValidTypeExeCheck = false;
       // const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
        const ValidExtsExe = ValidateFileExtension.split(",");
        isValidTypeExeCheck = ValidExtsExe.includes(extension);

        if (isValidTypeExeCheck) {
            const file = arrFile[0];
            //const error = await validateDocFileForExe(file);
            //console.log(error);
            //await checkFileForExe(file);
            await validateDocFileForExe(file)
                .then(() => {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("File is valid and ready to upload.");
                    isValidTypeExeCheckFlag = true
                })
                .catch(error => {
                    console.log(error);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                    $("#Filename").text("Drag files here or click to upload");
                    $(".demo-droppable p").text("Drag files here or click to upload");
                    arrFile = [];
                    isValidTypeExeCheck = false;
                    isValidTypeExeCheckFlag = false;
                  //  $(objtxtFileName).val("");
                    /*$(objFileName).attr("placeholder", "Upload File");*/
                    //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                    return;
                });



            if (!isValidTypeExeCheck) {
                return;
            }
        }

        //$(objtxtFileName).val("");

        //Ended by Parth Godshelwar
    }





            //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
    if (arrFile[0] != undefined) {
        var formdata = new FormData();
        formdata.append('file', arrFile[0]);
        formdata.append('Mode', 'Upload');
        formdata.append('UserStoryID', userStoryID);
        $.ajax({
            type: 'post',
            url: 'frmProductBacklog.aspx',
            data: formdata,
            success: function (status) {
                //  debugger;
                // alert(status);
                if (status == "Invalid") {
                    // alert("Invalid content type!");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Invalid content type!", 'error', 25);
                }
                else {
                    document.getElementById("divAttachmentList").innerHTML = status;
                    $('[data-bs-toggle="tooltip"]').tooltip();

                    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                        var output = document.querySelector('.demo-droppable');
                        output.innerHTML = '';
                        for (var i = 0; i < files.length; i++) {
                            arrFile[0] = files[i];
                            output.innerHTML += '<p>' + files[i].name + '</p>';
                        }
                    });

                    disposeTooltip();
                    // $('.radio-inline').tooltip()
                }
                arrFile = [];
            },
            processData: false,
            contentType: false,
            error: function (error) {
                //alertify.set('notifier', 'position', 'top-right');
                // alertify.notify("oops something went wrong!", 'error', 25);
                // alert("oops something went wrong!");
                // alert(error.status);
                // alert(error.responseText);
            }
        });
    }

    else {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify("Please select file to  Upload", 'error', 25);


    }


    //  document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px';
    //if (arrFile[0] == undefined) {
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify("Please Upload file!", 'error', 25);
    //}
}



//function UploadData(userStoryID) {
//    try {
//        debugger;
//        var blobOrFile = new FormData();
//        blobOrFile.append("file", arrFile[0]);
//        var filename = arrFile[0];
//        var xhr = new XMLHttpRequest();
//        xhr.open('POST', 'frmProductBacklog.aspx?Mode=Upload', true);
//      //  xhr.setRequestHeader('Content-length', arrFile[0].size);

//       // xhr.setRequestHeader('fileName', filename);

//        //if ($('#Yes').is(':checked')) {
//        //    isReadyToUpload = true;
//        //}
//        //else {
//        //    isReadyToUpload = false;
//        //}
//        //xhr.setRequestHeader('UploadFlag', true);

//        xhr.onload = function (e) {
//            //progressBar.value = 0;
//            //progressBar.textContent = progressBar.value;
//        };

//        // Listen to the upload progress.
//        //var progressBar = document.querySelector('progress');
//        //xhr.upload.onprogress = function (e) {
//        //    if (e.lengthComputable == true) {
//        //        progressBar.value = (e.loaded / e.total) * 100;
//        //        progressBar.textContent = progressBar.value; // Fallback.
//        //    }
//        //};
//        xhr.onreadystatechange = function () {
//            if (xhr.readyState == 4 && xhr.status == 200) {
//                alert(xhr.responseText);
//            }
//        };


//        xhr.send(arrFile[0]);
//    }
//    catch (exception) {
//        alert(exception.message.toString());
//    }
//}
var DiscussionID = 0; strnewDiscussionID = 0;
//function insertUserStorytDiscussion(userStoryID, Flag, obj) {
//    if ($("#FreeTextBox_editor").html() == "")
//    {
//        return;
//    }
//    var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: userStoryID, DiscussionComment: $("#FreeTextBox_editor").html(), DiscussionID: DiscussionID }));
//    document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
//    $("#txtDiscussion").val('');
//    $("#FreeTextBox_editor").html('');
//    DiscussionID = 0;
//    $("#btnSend").html('Post');
//}


function insertuserStoryDiscussion(UniqueID, Flag, obj, txtID, pageFlag) {

    //debugger;
    if ($("#DiscussionTextArea").val() != "") {
        //Commented by Chetan M on 21th Aug 2020 for Issue ID =25478
        //////Added by Chetan M on 31st Jully 2020 for Issue ID =25478
        // if ($("#DiscussionTextArea").val().length >= 2000) {
        //     $("#DiscussionTextArea").focus();
        //     alertify.set('notifier', 'position', 'top-right');
        //     alertify.notify('Please Enter Discussion less than 2000 characters, you have entered ' + $("#DiscussionTextArea").val().length +' characters.', 'error', 5);
        // }
        // else {
        //     //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
        //End of Commented by Chetan M on 21th Aug 2020 for Issue ID =25478
        if (pageFlag != undefined) {
            DiscussionID = pageFlag;
            var strUserResult = ajaxCall("UserStoryDetails.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
        }
        else {
            //  alert(DiscussionID)
            var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
        }
        if (strUserResult.d != 1) {
            document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
            $("#spanpost").html('');

            AutoResizeTextArea();
            RemoveTextArea();
            $("#spanpost").html('Post');
            $("#DiscussionTextArea").val('');
            $("#DiscussionTextArea").prop("placeholder", "Post New Discussion");
            $("#collapse_" + strnewDiscussionID).addClass('in');


            //  $("#FreeTextBox_editor").html('');
            DiscussionID = 0;
            $("#SprintReleaseAddDiscussion").attr('disabled');
            
            // Added By Gauri On 16th Sep 2024 For Tooltip Issue
            $('[data-bs-toggle="tooltip"]').tooltip();
            let postTxt = document.getElementById("spanpost").textContent;
            const postTooltip = bootstrap.Tooltip.getInstance('#spanpost');
            
            // let postTxt = 'Post'; 
            if (postTxt === 'Post') {
                postTooltip.setContent({
                    '.tooltip-inner': 'Post'
                }); 
                $('[data-bs-toggle="tooltip"]').tooltip();
                disposeTooltip();
            }
            $(".bs-tooltip-auto").removeClass('show');
            // End of Added By Gauri On 16th Sep 2024 For Tooltip Issue
        }
        //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
        //Commented by Chetan M on 21th Aug 2020 for Issue ID =25478
        //}
        //End of Commented by Chetan M on 21th Aug 2020 for Issue ID =25478
        //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
    }
    else {
        $("#DiscussionTextArea").focus();
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('- Please Enter Discussion', 'error', 25);
    }
}

function reply_onclick(userstoryID, discussionID, Flag) {
    //if ($("#DiscussionTextArea").val() != "") {

    AutoResizeTextArea();
    RemoveTextArea();
    strnewDiscussionID = discussionID;
    $("#DiscussionTextArea").focus();
    $("#DiscussionTextArea").prop("placeholder", "Reply New Discussion");
    $("#spanpost").html('Reply');
    $('#spanpost').attr('data-original-title', 'Reply');

    //$("#spanpost").attr('title', '');
    DiscussionID = discussionID;
    //$("#spanpost").attr('title', '');
    $("#SprintReleaseAddDiscussion").removeAttr('disabled');

    //}
    //else {
    //    $("#DiscussionTextArea").focus();
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify('-Please Add Discussion', 'error', 25);
    //}

    // Added By Gauri On 16th Sep 2024 For Tooltip Issue
    $('[data-bs-toggle="tooltip"]').tooltip();
    let replyTxt = document.getElementById("spanpost").textContent;
    const replyTooltip = bootstrap.Tooltip.getInstance('#spanpost');

    if (replyTxt === 'Reply') {
        replyTooltip.setContent({
            '.tooltip-inner': 'Reply'
        });
        $('[data-bs-toggle="tooltip"]').tooltip();
        disposeTooltip();
    } 
    $(".bs-tooltip-auto").removeClass('show');
    // End of Added By Gauri On 16th Sep 2024 For Tooltip Issue
}

function AddNewDiscussion(UniqueID, Flag, obj, txtID, pageFlag) {
    //debugger;
    //End by swapna
    var DiscussionID = 0; strnewDiscussionID = 0;
    if ($("#DiscussionTextArea").val() != "") {
        //Added by swapna 

        if (pageFlag == 1) {

            var strUserResult = ajaxCall("UserStoryDetails.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
        }
        else {
            var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
        }

        if (strUserResult.d != 1) {

            document.getElementById("divDiscussionList").innerHTML = strUserResult.d;


            $("#spanpost").html('');

            AutoResizeTextArea();
            RemoveTextArea();
            $("#spanpost").html('Post');
            $("#DiscussionTextArea").val('');
            $("#DiscussionTextArea").prop("placeholder", "Post New Discussion");
            $("#collapse_" + strnewDiscussionID).addClass('in');


            //  $("#FreeTextBox_editor").html('');
            DiscussionID = 0;
            $('[data-bs-toggle="tooltip"]').tooltip();
            $("#SprintReleaseAddDiscussion").attr('disabled');
            $("#DiscussionTextArea").val("");
        }
        //end by swapna
    }
    else {

        $("#DiscussionTextArea").focus();
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('- Please Add Discussion', 'error', 25);
    }

}
//Added by swapna 20-07-2018
//function Delete_Attachment(AttachmentID, UserStoryID) {
//    var strUserResult = ajaxCall("frmProductBacklog.aspx/DeleteAttachment", "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: 'UserStory' }));
//    strUserResult = String(strUserResult.d);

//    document.getElementById("divDiscussionList").innerHTML = strUserResult[1];
//    alertify.set('notifier', 'position', 'top-right');
//    alertify.notify(strUserResult[0], 'success', 25);
//}
var strUser
function Delete_Attachment(AttachmentID, UserStoryID, Flag, pageFlag) {
    // debugger;
    // alert(AttachmentID);
    var strUserResult = ajaxCall("frmProductBacklog.aspx/DeleteAttachment", "POST", "application/json", "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: Flag }));
    strUser = strUserResult.d.split("||")
    //  alert(strUserResult.d)
    // alert(strUserResult[1]);
    if (pageFlag == 1) {
        BindAttachementsData(UserStoryID);
    }
    else {
        document.getElementById("Attachmentus").innerHTML = "";
        // document.getElementById("attachmentdata").innerHTML = "";
        document.getElementById("Attachmentus").innerHTML = strUser[2];
        // document.getElementById("attachmentdata").innerHTML = strUserResult[1];
        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });
    }
    //Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
    if (strUser[1] == 0) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strUser[0], 'error', 15);
    }
    else {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strUser[0], 'success', 15);
    }
    //End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
}
//Added by swapna 20-07-2018
function ShowMoreLess(discussionID, obj) {
    if (document.getElementById(discussionID).style.display == "none") {
        //Commented and Added By Usha Pandit on 08 June 2018 for wrap large text in IE
        //document.getElementById(discussionID).style.display = "inline";
        document.getElementById(discussionID).style.display = "block";
        //End of Added By Usha Pandit on 08 June 2018 for wrap large text in IE
        obj.innerHTML = "Less"
    }
    else {
        document.getElementById(discussionID).style.display = "none";
        obj.innerHTML = "More"
    }
}



//Added By Dipali V On 2nd April 2018 For Sprint & release Description Validation
var IsFlag = 0;
function Maxlength(limitField, limitCount, limitNum, Flag) {

    var length;
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } else {
        limitCount.innerHTML = (limitNum - limitField.value.length);
    }

    if (limitCount.innerHTML == 0) {
        if (Flag == 'Sprint') {
            if (IsFlag != 1) {
                document.getElementById("countdownSprint").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanBusinessValue').html("You Can Enter Only 100 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
                IsFlag = 1
            }
        }
        else if (Flag == 'Release') {
            if (IsFlag != 1) {
                document.getElementById("countdownRelease").style.color = 'red' //when Char 0 length  then Color red
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
                IsFlag = 1;
            }
        }

    }
    else {
        if (Flag == 'Sprint') {
            document.getElementById("countdownSprint").style.color = 'black'
            // $('#spanBusinessValue').text("");
        }
        else if (Flag == 'Release') {
            document.getElementById("countdownRelease").style.color = 'black'
            // $('#spanAcceptanceCriteria').text("");
        }

    }
    if (limitField.clientHeight < limitField.scrollHeight) {
        limitField.style.height = limitField.scrollHeight + "px";
        if (limitField.clientHeight < limitField.scrollHeight) {
            limitField.style.height =
                (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
        }
    }
}

//End of Added By Dipali V On 2nd April 2018 For Sprint & release Description Validation


//Added By Dipali V On 2nd April 2018 For Sprint & release Saving

var SprintID = 0;
var ReleaseID = 0;
function SaveSprintRelease(Flag) {
    try {
        if (Flag == "Sprint") {

            if (validationSprit() == 0) {


                var Sprintname = $("#Sprintname").val();

                // Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993    
                //var SprintStartdate = $("#SprintStartdate").val();
                //var SprintEnddate = $("#SprintEnddate").val();
                //End of Commented by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                var txtDescriptionSprint = $("#txtDescriptionSprint").val();

                var txtCalendar = $("#txtCalendar").val();
                var txtBusiness = $("#txtBusiness").val();
                var txtEfforts = $("#txtEfforts").val();
                var ProjectID = document.getElementById('hdnProjectID').value;

                // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                var SprintStartdate = dtsdt;
                var SprintEnddate = dtedt;

                //End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

                if (Sprintname == "") {
                    Sprintname = "";
                }
                else {
                    Sprintname = Sprintname;
                }

                if (txtDescriptionSprint == "") {
                    txtDescriptionSprint = "";
                }
                else {
                    txtDescriptionSprint = txtDescriptionSprint;
                }


                if (txtEfforts == "") {
                    txtEfforts = "";
                }
                else {
                    txtEfforts = txtEfforts;
                }
                // debugger;
                ReleaseID = "0";

                var SprintID = $("#hdnSprintIDnew").val();
                //alert(SprintID);
                if (SprintID != undefined) {
                    SprintID = SprintID;
                } else {
                    SprintID = "0";
                }


                var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveSprintRelease", "POST", "application/json", "json", JSON.stringify({ Flag: Flag, SprintID: SprintID, ProjectID: ProjectID, Sprintname: Sprintname, ReleaseID: ReleaseID, txtDescriptionSprint: txtDescriptionSprint, SprintStartdate: SprintStartdate, SprintEnddate: SprintEnddate, txtCalendar: txtCalendar, txtEfforts: txtEfforts, txtBusiness: txtBusiness }));

                if (strUserResult.d != "") {
                    //alert();
                    var NewSprintID = strUserResult.d;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint Created Successfully', 'success');
                    $("#CreateSprint").modal('hide');
                    //  $("#hdnNewCreatedReleaseID").val(NewSprintID)
                    //   debugger;
                    // alert(NewSprintID);
                    //  debugger;
                    if (strUserResult.d != "") {
                        NewSprintID = strUserResult.d;

                    }
                    else {
                        NewSprintID = $("#hdnSprintIDnew").val();

                    }
                    // AfterRelaseSprintSave(Flag, NewSprintID)

                }
            }
            else {


            }
        }

        else {
            if (validationRelease() == 0) {
                //  debugger;
                var ReleaseName = $("#ReleaseName").val();
                var RstartDate = $("#RstartDate").val();
                var txtDescription = $("#txtDescription").val();
                var txtEndDate = $("#txtEndDate").val();
                var txtRelCalendar = $("#txtRelCalendar").val();
                // var txtBusiness = $("#txtBusiness").val();
                var txtRelEfforts = $("#txtRBusinessDuration").val();
                var ProjectID = document.getElementById('hdnProjectID').value;



                if (ReleaseName == "") {
                    ReleaseName = "";
                }
                else {
                    ReleaseName = ReleaseName;
                }

                if (txtDescription == "") {
                    txtDescription = "";
                }
                else {
                    txtDescription = txtDescription;
                }


                if (txtRelEfforts == "") {
                    txtRelEfforts = "";
                }
                else {
                    txtRelEfforts = txtRelEfforts;
                }

                var ReleaseID = $("#hdnSprintIDnew").val();
                if (ReleaseID != undefined) {
                    ReleaseID = ReleaseID;
                } else {
                    ReleaseID = "0";
                }

                SprintID = "0";
                var strUserResult = ajaxCall("frmProductBacklog.aspx/SaveSprintRelease", "POST", "application/json", "json", JSON.stringify({ Flag: Flag, SprintID: SprintID, ProjectID: ProjectID, Sprintname: ReleaseName, ReleaseID: ReleaseID, txtDescriptionSprint: txtDescription, SprintStartdate: RstartDate, SprintEnddate: txtEndDate, txtCalendar: txtRelCalendar, txtEfforts: txtRelEfforts, txtBusiness: "" }));

                if (strUserResult.d != "") {
                    //  debugger;
                    // alert(strUserResult.d);

                    var NewSprintID = strUserResult.d;
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Release Created Successfully', 'success');
                    $("#CreateSprint").modal('hide');

                    // AfterRelaseSprintSave(Flag, NewSprintID)


                }
            }
        }

    }
    catch (ex) {
        //alert(ex.message);
    }
}

var Mode = 'Edit';
var dtstart = '';
var dtend = '';
function GetDuration(MODE) {

    try {
        //   debugger;
        var objStart;
        var objEnd;
        Mode = MODE;

        if (MODE == "Release") {
            objStart = document.getElementById("RstartDate");
            objEnd = document.getElementById("txtEndDate");
            var dtstartNew = new Date(objStart.value);
            var dtendNew = new Date(objEnd.value);

            if (isNaN(dtstartNew.getTime()) && isNaN(dtendNew.getTime())) {
            }
            else {
                if (objStart.value != "" && objEnd.value != "") {
                    var url = "frmProductBacklog.aspx/GetDuration"
                    var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                    AJAXCall(url, data, bindDuration);
                }
            }
        }
        else {
            objStart = document.getElementById("SprintStartdate");
            objEnd = document.getElementById("SprintEnddate");

            //var dtstart = new Date(objStart.value);
            //var dtend = new Date(objEnd.value);
            //dtstart = new Date(objStart.value);
            //dtend = new Date(objEnd.value);

            // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            var oldobjStartVal = objStart.value;
            var oldobjEndVal = objEnd.value;


            getInputDateFormat(objStart, objEnd, 1, opDateFormat);
            //alert(dtstart);
            //End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
            //dtstart = Date.parse(dtstart);
            //dtedt = Date.parse(dtend);

            if (isNaN(dtstart.getTime()) && isNaN(dtend.getTime())) {
            }
            else {
                if (objStart.value != "" && objEnd.value != "") {
                    var url = "frmProductBacklog.aspx/GetDuration"
                    var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                    AJAXCall(url, data, bindDuration);
                }
            }

            // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

            objStart.value = oldobjStartVal;
            objEnd.value = oldobjEndVal;

            var dtformatval = dtFormat(opDateFormat);

            $('#SprintStartdate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    // yearRange: '2000:2060'
                    yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
                    // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                    , dateFormat: dtformatval
                    // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                }
            );

            $('#SprintEnddate').datepicker(
                {
                    changeMonth: true,
                    changeYear: true,
                    // yearRange: '2000:2060'
                    yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
                    // Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
                    , dateFormat: dtformatval
                    // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993           
                }
            );
        }
    }
    catch (ex) {
        //alert(ex.message);
    }
    // End of Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

}

function AJAXCall(url, data, method) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        contentType: "application/json",
        //timeout:180000,
        success: function (result) {
            method(result);
            $(".loadingoverlay", parent.document).css("display", "none");
            // Stop();
        },
        error: function (xhr, status, error) {
            // Stop();
            // StopAjaxLoader("body");
            $(".loadingoverlay", parent.document).css("display", "none");
            console.log(xhr.responseText);
            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

}

function bindDuration(result) {
    var strArray = String(result.d).split("|");
    if (Mode == "New") {
        document.getElementById("txtDuration").value = strArray[0];
        document.getElementById("txtDurationBusiness").value = strArray[1];
    }
    else if (Mode == "Release") {
        document.getElementById("txtRelCalendar").value = strArray[0];
        document.getElementById("txtRBusinessDuration").value = strArray[1];
    }
    else {
        document.getElementById("txtCalendar").value = strArray[0];
        document.getElementById("txtBusiness").value = strArray[1];
    }
}


function validationSprit() {

    var checkvalue = 0;
    var Flag = 0;
    var checkvalue = 0;
    var strmsg = "";
    var errorMsg = "<ul>"
    dtStartDate = document.getElementById("SprintStartdate");
    dtEndDate = document.getElementById("SprintEnddate");
    var ProjectID = document.getElementById('hdnProjectID').value;
    if ($("#Sprintname").val() == "") {
        strmsg = '- Sprint Name should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if ($("#Sprintname").val() != "") {
        //if (checkSpecialCharacter($('#Sprintname').val()) == true) {
        //    // alertify.set('notifier', 'position', 'top-right');
        //    strmsg = '- Sprint Name cannot contain any of these /\\:*?<>|,"+- Characters';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //    checkvalue = 1;

        //}
        //Added By Riddhesh Patil on 11-NOV-2022 
        if (checkSpecialCharacter($("#Sprintname").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Sprint Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#Sprintname").focus();
                Flag = 1;
            checkvalue = 1;
        }
        //End of Added By Riddhesh Patil

        $.ajax({
            url: "frmProductBacklog.aspx/CheckIterationName",
            data: JSON.stringify({ strIterationName: $("#Sprintname").val(), strProjectID: ProjectID, flag: "Sprint" }),
            dataType: "json",
            type: "POST",
            contentType: "application/json",
            async: false,
            success: function (result) {
                if (result.d != 0) {
                    strmsg = result.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    /// checkvalue = 1;
                    if (checkvalue != 1) {
                        $("#Sprintname").focus();
                    }
                    checkvalue = 1;
                }
            }
        })
    }
    //Added By Riddhesh Patil on 11-NOV-2022 
    if ($("#txtDescriptionSprint").val() != "") {
        if (checkSpecialCharacter($("#Sprintname").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Sprint Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtDescriptionSprint").focus();
            Flag = 1;
            checkvalue = 1;
        }
    }
    //End of Added By Riddhesh Patil

    if ($("#SprintStartdate").val() == "") {
        strmsg = '- Sprint Start Date should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if ($("#SprintEnddate").val() == "") {
        strmsg = '- Sprint End date should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    //Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993

    oldobjStartVal = dtStartDate.value;
    oldobjEndVal = dtEndDate.value;

    // Commented & Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
    //getInputDateFormat(dtStartDate, dtEndDate, 1);
    getInputDateFormat(dtStartDate, dtEndDate, 1, opDateFormat);
    // End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993

    // End of Commented & Added by Sagar N on 11-Apr-2019 Purpose:: Agile Issue ID- 11993

    if (CompairDates(dtStartDate, dtEndDate) == 1) {
        strmsg = '- Sprint End date should be greater than Sprint start date';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;

    }

    if (checkvalue == 0 && dtsdt != undefined && dtedt != undefined && dtsdt != '' && dtedt != '') {
        // Commented & Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
        var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtsdt, EndDate: dtedt });
        // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

        var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
        result = result.d;

        if (result != '') {
            var arrResult = result.split('##');

            if (arrResult[0] == '1') {
                //dtStartDate.style.borderColor = 'red';
                //dtStartDate.style.borderWidth = '1px';
                //spandtStartDate.innerHTML = arrResult[1];

                //checkvalue = 1;
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            if (arrResult[0] == '2') {

                //dtEndDate.style.borderColor = 'red';
                //dtEndDate.style.borderWidth = '1px';
                //spandtEndDate.innerHTML = arrResult[1];

                //checkvalue = 1;
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
        }
        // Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        dtStartDate.value = oldobjStartVal;
        dtEndDate.value = oldobjEndVal;
        // End of added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
    }




    if (RestrictNonNumeric(document.getElementById('txtCalendar')) == true) {
        // alertify.set('notifier', 'position', 'top-right');
        strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
        errorMsg += "<li>" + strmsg + "</li></br>";
        //alertify.notify('', 'error');
        checkvalue = 1;

    }

    if (RestrictNonNumeric(document.getElementById('txtBusiness')) == true) {
        // alertify.set('notifier', 'position', 'top-right');
        strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
        errorMsg += "<li>" + strmsg + "</li></br>";
        //alertify.notify('', 'error');
        checkvalue = 1;

    }


    if ($("#txtEfforts").val() == "") {
        strmsg = '- Efforts should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    //Commented and Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 
    //if ($("#txtEfforts").val() != "") {
    //    if (RestrictNonNumeric(document.getElementById('txtEfforts')) == true) {
    //        // alertify.set('notifier', 'position', 'top-right');
    //        strmsg = ' - Please Enter only positive numeric value for Efforts !!!';
    //        errorMsg += "<li>" + strmsg + "</li></br>";
    //        //alertify.notify('', 'error');
    //        checkvalue = 1;

    //    }
    //    else if (checkSpecialCharacter($('#txtEfforts').val()) == true) {
    //        // alertify.set('notifier', 'position', 'top-right');
    //        strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
    //        errorMsg += "<li>" + strmsg + "</li></br>";
    //        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
    //        checkvalue = 1;

    //    }
    //}

    if ($("#txtEfforts").val() != "") {
        try {
            //alert(4);
            var blnHMFormat = true;
            var objHMEffort = document.getElementById("txtEfforts");
            var objVal = objHMEffort.value;
            var objnewVal = objHMEffort.value;

            objHMEffort.value = objHMEffort.value.replace(":", ".");
            var isdigit = isNumeric(objHMEffort.value);
            objHMEffort.value = objVal;

            if (isdigit == false) {
                strmsg = ' - Please Enter only positive numeric value For Efforts in H:M format.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                blnHMFormat = false;
                Flag = 1;
                checkvalue = 1;
            }


            if (objHMEffort.value.indexOf(":") == -1) {
                //strmsg = ' - Please enter efforts in valid format hh:mm!!';
                //errorMsg += "<li>" + strmsg + "</li></br>";
                //blnHMFormat = false;
                ////setFocus(objHMEffort);
                //Flag = 1;
                //checkvalue = 1;
                objHMEffort.value = objnewVal + ':00';
                objnewVal = objHMEffort.value;
            }

            if (objHMEffort.value.indexOf(":") != -1) {
                objHMEffort.value = objHMEffort.value.replace(':', '.');
            }

            //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
            var tempEffort = objHMEffort.value.replace('-', '');
            if (checkSpecialCharacter(tempEffort) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Efforts cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                objHMEffort.value = objVal;
                Flag = 1;
                checkvalue = 1;
            }

            //if (blnResult == true) {
            //    checkvalue = 1;
            //}

            //blnResult = disallowNonNumeric(objHMEffort, "Please enter efforts in valid format hh:mm!!");
            if (blnHMFormat == true) {
                if (RestrictNonNumeric(document.getElementById("txtEfforts")) == true) {
                    strmsg = ' - Please enter Efforts in H:M format.';
                    errorMsg += "<li>" + strmsg + "</li>";
                    objHMEffort.value = objVal;
                    blnHMFormat = false;
                    Flag = 1;
                    checkvalue = 1;
                }
            }
            //if (blnResult == true) {
            //    checkvalue = 1;
            //}

            objHMEffort.value = objHMEffort.value.replace('.', ':');

            var WorkHour = objHMEffort.value;

            WorkHour = WorkHour.trim();
            var idxColon = WorkHour.indexOf(':');

            var hrs = WorkHour.substring(0, idxColon);

            var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

            if (mins.length == 1 && mins > 5) {
                mins = mins + "0";
            }
            if (blnHMFormat == true) {
                if (mins == "") {
                    //mins = "00";
                    strmsg = " - Please enter Efforts in H:M format.";
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    blnHMFormat = false;
                    Flag = 1;
                    checkvalue = 1;
                }

                if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                    strmsg = ' - Hours should not be less than or equal to zero (0).';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    blnHMFormat = false;
                    Flag = 1;
                    checkvalue = 1;
                }

                // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                //alert(mins)
                if (blnHMFormat == true) {
                    if (mins.length > 2) {
                        strmsg = "Please enter minutes in two decimal and less than 60.";
                        errorMsg += "<li>" + strmsg + "</li>";
                        blnHMFormat = false;
                        Flag = 1;
                        checkvalue = 1;
                    }
                }
                // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                if (blnHMFormat == true) {
                    if (mins > 59 || mins < 0) {
                        strmsg = ' - Please enter minutes between (0-59) range';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        blnHMFormat = false;
                        Flag = 1;
                        checkvalue = 1;
                    }
                }
            }

            var MinDAENtryDisplay = "";

            var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
            var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

            var MinDAEntry = resMinHoursForDAEntry.d;

            if (MinDAEntry == 0.25) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:15"
            }
            else if (MinDAEntry == 0.50) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:30"
            }
            else if (MinDAEntry == 0.75) {
                MinDAEntry = MinDAEntry
                MinDAENtryDisplay = "00:45"
            }

            var data = JSON.stringify({ Flag: "RestrictByMinHours" });
            var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

            if (resRestrictByMinHours.d == 'True') {
                if (MinDAEntry == 0.016) {
                }
                else {
                    var minutes = WorkHour.split(':');

                    var p = minutes[0];
                    var dec = minutes[1];

                    if (dec != undefined) {
                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }

                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            //strmsg = ' - Please enter the work hrs. in multiple of min.work hrs (' + MinDAENtryDisplay + ')';
                            if (blnHMFormat == true) {
                                strmsg = 'Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                errorMsg += "<li>" + strmsg + "</li></br>";
                                Flag = 1;
                                checkvalue = 1;
                            }
                        }
                    }
                }
            }
            if (checkvalue == 1) {
                objHMEffort.value = objVal;
            }
            else {

                if (objHMEffort.value.toString().indexOf(":") != -1) {
                    var chkhr = objHMEffort.value.split(":")[0];
                    var chkmin = objHMEffort.value.split(":")[1];
                    if (chkhr.length == 1) {
                        chkhr = "0" + chkhr;
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                    if (chkmin.length == 1) {
                        chkmin = chkmin + "0";
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                }
            }
        }
        catch (ex) {
            //alert(ex.message);
        }
    }

    //End of Added By Usha Pandit on 01-Mar-2019 Purpose::Project Work field level changes 

    //if (checkvalue == 0) {
    if (dtStartDate != null && dtEndDate != null && (dtStartDate.value != "" && dtEndDate.value != "")) {
        // Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
        //var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Sprint" });
        var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtsdt, EndDate: dtedt, Flag: "Sprint" });
        // End of Commented & Added by sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993

        var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
        if (result1.d != '') {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(result1.d, 'error', 15);
            checkvalue = 1;
            return;

        }
        //Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
        dtStartDate.value = oldobjStartVal;
        dtEndDate.value = oldobjEndVal;
        //End of Added by Usha Pandit on 27.03.2019 for Input Date Format set on Sprint Creation
    }
    //}


    if (checkvalue == 0) {
        var data = JSON.stringify({
            strIterationID: "",
            strEfforts: $('#txtEfforts').val()
        })
        var strResultEfforts = AJAXCallWithResult("frmSprintPlanning.aspx/CheckSprintEfforts", data, false)
        if (strResultEfforts.d != '') {
            checkvalue = 1;
            strmsg = strResultEfforts.d;
            errorMsg += "<li>" + strResultEfforts.d + "</li></br>";
        }
    }

    //Added By Dipali V On  25th April 2018 
    //if ($("#SprinttxtStoryPoint").val() != "") {

    //    if (RestrictNonNumeric(document.getElementById('SprinttxtStoryPoint')) == true) {


    //        strmsg = '- Please Enter Numeric Value For Story Point';
    //        errorMsg += "<li>" + strmsg + "</li></br>";
    //        Flag = 1;
    //        checkvalue = 1;
    //    }
    //    if (parseFloat($("#SprinttxtStoryPoint").val()) < 0 && $("#SprinttxtStoryPoint").val() != '') {
    //        //alert('Please enter positive number');
    //        strmsg = '- Please enter positive Value For Story Point';
    //        errorMsg += "<li>" + strmsg + "</li></br>";
    //        Flag = 1;
    //        checkvalue = 1;
    //        $("#SprinttxtStoryPoint").focus();

    //    }
    //    else {

    //        var n = $("#SprinttxtStoryPoint").val();
    //        var result = (n - Math.floor(n)) !== 0;

    //        // alert(result);
    //        if (result) {
    //            strmsg = '- Please enter Story Points without decimal';
    //            errorMsg += "<li>" + strmsg + "</li></br>";
    //            Flag = 1;
    //            checkvalue = 1;
    //            $("#SprinttxtStoryPoint").focus();

    //        }

    //    }

    //}
    //End of Added By Dipali V On  25th April 2018 

    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkvalue;




}

function validationRelease() {

    var checkvalue = 0;
    var Flag = 0;
    var checkvalue = 0;
    var strmsg = "";
    var errorMsg = "<ul>"
    dtStartDate = document.getElementById("RstartDate");
    dtEndDate = document.getElementById("txtEndDate");
    var ProjectID = document.getElementById('hdnProjectID').value;

    if ($("#ReleaseName").val() == "") {
        strmsg = '- Release Name should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if ($("#ReleaseName").val() != "") {
        //if (checkSpecialCharacter($('#ReleaseName').val()) == true) {
        //    // alertify.set('notifier', 'position', 'top-right');
        //    strmsg = '- Release Name cannot contain any of these /\\:*?<>|,"+- Characters';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //    checkvalue = 1;

        //}
        //Added By Riddhesh Patil on 11-NOV-2022 
        if (checkSpecialCharacter($("#ReleaseName").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Release Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#ReleaseName").focus();
            Flag = 1;
            checkvalue = 1;
        }
        //End of Added By Riddhesh Patil

        else {
            $.ajax({
                url: "frmProductBacklog.aspx/CheckIterationName",
                data: JSON.stringify({ strIterationName: $("#ReleaseName").val(), strProjectID: ProjectID, flag: "Release" }),
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != 0) {
                        strmsg = result.d;
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        /// checkvalue = 1;
                        if (checkvalue != 1) {
                            $("#ReleaseName").focus();
                        }
                        checkvalue = 1;
                    }
                }
            })
        }
    }
    //Added By Riddhesh Patil on 11-NOV-2022 
    if ($("#txtDescription").val() != "") {
        if (checkSpecialCharacter($("#txtDescription").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtDescription").focus();
            Flag = 1;
            checkvalue = 1;
        }
    }
        //End of Added By Riddhesh Patil

    if ($("#RstartDate").val() == "") {
        strmsg = '- Release Start Date should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if ($("#txtEndDate").val() == "") {
        strmsg = '- Release End date should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }

    if (CompairDates(dtStartDate, dtEndDate) == 1) {
        strmsg = '- Release End date should be greater than Release start date';//End date should be greater than start date
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;

    }


    if (checkvalue == 0) {
        var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
        var result = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
        result = result.d;
        if (result != '') {
            var arrResult = result.split('##');

            if (arrResult[0] == '1') {
                //dtStartDate.style.borderColor = 'red';
                //dtStartDate.style.borderWidth = '1px';
                //spandtStartDate.innerHTML = arrResult[1];

                //checkvalue = 1;
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
            if (arrResult[0] == '2') {

                //dtEndDate.style.borderColor = 'red';
                //dtEndDate.style.borderWidth = '1px';
                //spandtEndDate.innerHTML = arrResult[1];

                //checkvalue = 1;
                strmsg = '-' + arrResult[1];
                errorMsg += "<li>" + strmsg + "</li></br>";
                Flag = 1;
                checkvalue = 1;
            }
        }

    }




    if (RestrictNonNumeric(document.getElementById('txtRelCalendar')) == true) {
        // alertify.set('notifier', 'position', 'top-right');
        strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
        errorMsg += "<li>" + strmsg + "</li></br>";
        //alertify.notify('', 'error');
        checkvalue = 1;

    }

    //if ($("#txtRelEfforts").val() == "") {
    //    strmsg = '- Efforts should not be left blank';
    //    errorMsg += "<li>" + strmsg + "</li></br>";
    //    Flag = 1;
    //    checkvalue = 1;
    //}

    if ($("#txtRBusinessDuration").val() != "") {
        if (RestrictNonNumeric(document.getElementById('txtRBusinessDuration')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Business Duration !!!';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //alertify.notify('', 'error');
            checkvalue = 1;

        }
        //else if (checkSpecialCharacter($('#txtRelEfforts').val()) == true) {
        //    // alertify.set('notifier', 'position', 'top-right');
        //    strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
        //    errorMsg += "<li>" + strmsg + "</li>";
        //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
        //    checkvalue = 1;

        //}
    }

    //if (RestrictNonNumeric(document.getElementById('txtBusiness')) == true) {
    //    // alertify.set('notifier', 'position', 'top-right');
    //    strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
    //    errorMsg += "<li>" + strmsg + "</li>";
    //    //alertify.notify('', 'error');
    //    checkvalue = 1;

    //}


    if (checkvalue == 0) {
        if (dtStartDate != null && dtEndDate != null) {
            var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Release" });
            var result1 = AJAXCallWithResult("frmProductBacklog.aspx/ValidateIterationDate", data, false);
            if (result1.d != '') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(result1.d, 'error', 15);
                checkValu = 1;
                return;

            }
        }
    }


    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkvalue;




}
var AjaxResult;
function AJAXCallWithResult(url, data, async) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        contentType: "application/json",
        //timeout: 180000,
        async: async,
        success: function (result) {
            AjaxResult = result;
            $(".loadingoverlay", parent.document).css("display", "none");
            // Stop();
        },
        error: function (xhr, status, error) {
            //  Stop();
            //  StopAjaxLoader("body");
            $(".loadingoverlay", parent.document).css("display", "none");
            console.log(xhr.responseText);
            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

    return AjaxResult;
}
function checkSpecialCharacter(value) {
    var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
    var isSpecialCharacter = 0;
    for (var i = 0; i < regularExpression.length; i++) {
        if (value.indexOf(regularExpression[i]) != -1) {
            isSpecialCharacter = 1
        }
    }
    if (isSpecialCharacter == 1) {
        return true;
    }
    else {
        return false;
    }
}
function RestrictNonNumeric(obj) {
    if (obj == null) { return false; }
    if (isBlank(getInputValue(obj))) { return false; }

    var dofocus = (arguments.length > 1) ? arguments[1] : true;
    if (!isNumeric(getInputValue(obj))) {
        if (dofocus) {
            setFocus(obj);
        }
        return true;
    }
    return false;
}
function CompairDates(obj1, Obj2) {
    var date1 = new Date(obj1.value);
    var date2 = new Date(Obj2.value);
    if (date1 > date2) {
        return 1;
    }
    else if (date1 < date2) {
        return -1;
    }
    else {
        return 0;
    }
}


var selectedobj = "";
var selectedDiv = "";
function ShowStatus(obj, divID) {
    //  alert();
    selectedobj = obj;
    selectedDiv = divID


    if ($(obj).hasClass("fa-plus-circle")) {
        $(obj).removeClass("fa-plus-circle");
        $(obj).addClass("fa-minus-circle");
        $("#" + divID).css("display", "block");
    }
    else if ($(obj).hasClass("fa-minus-circle")) {
        $(obj).removeClass("fa-minus-circle");
        $(obj).addClass("fa-plus-circle");
        $("#" + divID).css("display", "none");
    }
    //}
}

var strGlobaFilterField = "";
var strGlobalFilterValue = "";
var filterFlag;
function ShowFilter(Value, flag) {
    //$(selectedobj).removeClass("fa-minus-circle");
    // $(selectedobj).addClass("fa-plus-circle");


    filterFlag = flag;
    if (flag == "Release") {
        Value = document.getElementById("ProductFilterRelease").value;
    }
    else if (flag == "Sprint") {
        Value = document.getElementById("ProductFilterSprint").value;
    }

    if (flag == "Release" || flag == "Sprint") {
        strGlobaFilterField = flag;
        strGlobalFilterValue = Value;
        var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterPlotGrid", "POST", "application/json", "json", JSON.stringify({ Flag: flag, Value: Value }));
        if (strUserResult.d != null || strUserResult.d != undefined) {
            $("#divGrid").html("")
            $("#divGrid").html("");
            $("#divGrid").html(strUserResult.d);
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-filter').tooltip();

            $("#RightArrow").css("display", "none");
            // $("#uldropdown").css("display", "none");
            $("#idfilter").css("display", "block");
            //datatables('DivDailyScurmList', 'txtSearchDailyScrum', '')
        }

        ShowStatus(selectedobj, selectedDiv);
        //  $("#uldropdown").css("display", "none");
        // $("#ProductFilterRelease").val('');
        // $("#ProductFilterSprint").val('');
        $("#divMain").css("padding-right", "");
    }
    else if (flag == "ListView") {
        Value = "";
        var strResult, data;
        data = JSON.stringify({ strUserStoryId: "", Flag: "ListView", Value: Value });
        strResult = AJAXCallWithResult("frmProductBacklog.aspx/ScrumIterationList", data, false);

        if (strResult.d != '') {

            // $("#DivSprintlist").modal('show');//divProductBacklog
            $("#divGrid").html(strResult.d);
            // $("#divProductBacklog").modal('hide');
            // $("#divProductBacklog").removeClass('in');
            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterListCount").val() > 0) {
                datatables('Divlist', 'txtSearchPendingP', '');
            }
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-pencil').tooltip();
            $("#divMain").css("padding-right", "3%");
        }
        //Added by Usha Pandit on 22.04.2019 for showing clear filter on applying the other filers except sprint and release
        $("#idfilter").css("display", "block");
        //End of Added by Usha Pandit on 22.04.2019 for showing clear filter on applying the other filers except sprint and release
    }
    else {

        Value = "";
        var strResult, data;
        var strUserResult = ajaxCall("frmProductBacklog.aspx/FilterPlotGrid", "POST", "application/json", "json", JSON.stringify({ Flag: flag, Value: Value }));
        if (strUserResult.d != null || strUserResult.d != undefined) {
            $("#divGrid").html("")
            $("#divGrid").html("");
            $("#divGrid").html(strUserResult.d);
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('.fa-filter').tooltip();
            $(".Outerdiv").css("height", window.innerHeight - 220 + 'px');
            $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
            $(".adjustheight").css("height", window.innerHeight - 220 + 'px');
        }
        //Added by Usha Pandit on 22.04.2019 for showing clear filter on applying the other filers except sprint and release
        $("#idfilter").css("display", "block");
        //End of Added by Usha Pandit on 22.04.2019 for showing clear filter on applying the other filers except sprint and release
    }

    // $("#divMain").css("height", window.innerHeight - 12 + 'px');
    $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');
    $("#divGrid").css("height", window.innerHeight - 80 + 'px');
    if ($(window).width() > 768) {
        $(".divDraggable1").css("min-height", window.innerHeight - 80 + 'px');
        $(".divDraggable1").css("height", '100%');
        $(".divDraggable1").css("width", (window.innerWidth / 3) - 35 + 'px');
    }
    else {
        $(".divDraggable1").css("min-height", '');
        $(".divDraggable1").css("height", '');
        $(".Main").css("height", '');
        $(".divDraggable1").css("width", '100%');
    }
    $(".Outerdiv").css("height", window.innerHeight - 160 + 'px');
    $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
    $(".adjustheight").css("height", window.innerHeight - 220 + 'px');
    $(".attachment").tooltip();
    $(".discussion").tooltip();
    $(".issue").tooltip();
    $(".details").tooltip();
    $(".charts").tooltip();
    $(".priority").tooltip();
    $(".drag").tooltip();
    $(".story_point").tooltip();
    $(".view_story").tooltip();
    $(".delete_story").tooltip();
    $(".user_story").tooltip();
    $(".rank").tooltip();
    $(".view").tooltip();
    $(".user-story-description").tooltip();
    $(".fa-ellipsis-h").tooltip();


    $('[data-bs-toggle="tooltip"]').tooltip();
}

function show() {

}




var projectid, IssueField;
//function IssueType_OnChange(obj) {


//    projectid = obj;
//    IssueField = document.getElementById("cboIssueType").value;
//    var url = "frmProductBacklog.aspx/GetDropDownValue";
//    data = JSON.stringify({ ProjectID: projectid, WhichList: "IssueType", Mode: 'New', Issue_Type: IssueField });
//    objAbbrivatdName = projectid



//    CustomAJAXCall(url, data, BindDropDownValues);

//    var url = "frmProductBacklog.aspx/GetDropDownValue";
//    data = JSON.stringify({ ProjectID: projectid, WhichList: "Reporter", Mode: 'New', Issue_Type: IssueField });
//    CustomAJAXCall(url, data, BindDropDownValues1);

//    IssueField = document.getElementById("cboIssueType").value;
//    var url = "frmProductBacklog.aspx/GetDropDownValue";
//    data = JSON.stringify({ ProjectID: projectid, WhichList: 'SubType', Mode: 'New', Issue_Type: IssueField });
//    CustomAJAXCall(url, data, BindDropdownSubType);


//    //FieldValidation();
//}

//function BindDropDownValues(result) {
//    debugger;
//    var strArray = String(result.d).split("|")
//    objCbo = document.getElementById("cboIssueType");

//    var i = 0;
//    objCbo.innerHTML = "";
//    addCode(s);

//    var url = "frmProductBacklog.aspx/GetDefaultType";
//    data = JSON.stringify({ strResult: $("#hdnProjectID").val() });
//    var result = AJAXCallWithResult(url, data, false);
//    if (result.d == "") {
//        $.each(JSON.parse(strArray[0]), function (id, obj) {
//            // alert(strArray);
//            var objOption = document.createElement("OPTION");
//            objCbo.options.add(objOption);
//            objOption.text = obj.FieldID;
//            objOption.value = obj.FieldName;
//            // GetSelectedSubtype(FieldName)
//        });

//    }
//   // objCbo.options[objCbo.selectedIndex].text = result.d;
//    objCbo.value = result.d;
//    alert(result.d);
//    //addCode(s);

//}

//function BindDropDownValues1(result) {
//    //alert(result.d);
//    var strArray = String(result.d).split("|")
//    objCbo1 = document.getElementById("cboreporter");
//    var i = 0;

//    objCbo1.innerHTML = "";
//    $.each(JSON.parse(strArray[0]), function (id, obj) {

//        var objOption = document.createElement("OPTION");
//        objCbo1.options.add(objOption);
//        objOption.text = obj.UserName;
//        objOption.value = obj.UserName;

//    });

//    objCbo1.value = $("#hdnstrUserName").val();

//}



function IssueType_OnChange(obj) {


    // debugger;
    IssueField = document.getElementById("cboIssueType").value;
    projectid = obj;
    if (projectid == undefined)
        projectid = 0;

    var url = "frmProductBacklog.aspx/GetDropDownValue";
    data = JSON.stringify({ ProjectID: projectid, WhichList: "IssueType", Mode: 'New', Issue_Type: IssueField });
    CustomAJAXCall(url, data, BindDropDownValues);
    data = JSON.stringify({ ProjectID: projectid, WhichList: "Reporter", Mode: 'New', Issue_Type: IssueField });
    CustomAJAXCall(url, data, BindDropDownValues1);
    IssueField = document.getElementById("cboIssueType").value;

    var url = "frmProductBacklog.aspx/GetDropDownValue";
    data = JSON.stringify({ ProjectID: projectid, WhichList: 'SubType', Mode: 'New', Issue_Type: IssueField });
    CustomAJAXCall(url, data, BindDropdownSubType);

}



function BindDropDownValues(result) {


    var strArray = String(result.d).split("|")


    objCbo = document.getElementById("cboIssueType");

    var i = 0;

    objCbo.innerHTML = "";

    var url = "frmProductBacklog.aspx/GetDefaultType";
    data = JSON.stringify({ strResult: $("#hdnProjectID").val() });
    var result1 = AJAXCallWithResult(url, data, false);

    $.each(JSON.parse(strArray[0]), function (id, obj) {

        var objOption = document.createElement("OPTION");
        objCbo.options.add(objOption);
        objOption.text = obj.FieldID;
        objOption.value = obj.FieldName;

    });
    //$("#cboIssueType").val(result1.d);
    objCbo.value = result1.d;
    //objCbo.options[objCbo.selectedIndex].text = result1.d;
    var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
    addCode(s);

}


function addCode(code) {
    var JS = document.createElement('script');
    JS.text = code;
    document.body.appendChild(JS);
}

function BindDropDownValues1(result) {
    //alert(result.d);
    var strArray = String(result.d).split("|")
    objCbo1 = document.getElementById("cboreporter");
    var i = 0;

    objCbo1.innerHTML = "";
    $.each(JSON.parse(strArray[0]), function (id, obj) {

        var objOption = document.createElement("OPTION");
        objCbo1.options.add(objOption);
        objOption.text = obj.UserName;
        objOption.value = obj.UserName;

    });

    //document.getElementById("cboreporter").value = $("#hdnStrReporter").val();
    //$("#cboreporter").val($("#hdnstrUserName").val());
    // $('#cboReviewer').val($("#hdnstrUserName").val());

}

function BindDropdownSubType(result) {
    var strArray = String(result.d).split("|")
    objCbo1 = document.getElementById("cboSubIssueType");
    //document.getElementById("PlotDynamic_Control").innerHTML = "";
    //document.getElementById("PlotDynamic_Control").innerHTML = strArray[1];
    //var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
    var s = "document.getElementById('btnMainSave').onclick = function(){  " + strArray[2] + ";  SaveOnClick(); }; ";
    addCode(s);


    var i = 0;
    objCbo1.innerHTML = "";
    var url = "frmProductBacklog.aspx/GetDefaultValues";
    data = JSON.stringify({ strResult: document.getElementById("cboIssueType").value });
    var result1 = AJAXCallWithResult(url, data, false);



    $.each(JSON.parse(strArray[0]), function (id, obj) {

        var objOption = document.createElement("OPTION");
        objCbo1.options.add(objOption);
        objOption.text = obj.FieldID;
        objOption.value = obj.FieldName;

    });


    //$("#cboSubIssueType").val(result1.d);
    objCbo1.value = result1.d;
    $('#txtReviewStartDate').datepicker(
        {
            changeMonth: true,
            changeYear: true,
            // yearRange: '2000:2060'
            yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
        });
    $('#txtReviewEnddate').datepicker({
        changeMonth: true,
        changeYear: true,
        // yearRange: '2000:2060'
        yearRange: (new Date().getFullYear() - 10) + ':' + (new Date().getFullYear() + 10)
    });
    $('#txtReviewStartDate,#txtReviewStartDate').prop('readonly', true);
    //  objCbo1.options[objCbo1.selectedIndex].text = result1.d;
}

function GetSelectedSubtype(obj) {


    var url = "frmProductBacklog.aspx/GetSubType";

    data = JSON.stringify({ TypeID: obj.value, WhichList: 'SubType' });
    CustomAJAXCall(url, data, BindDropdownSubType);

    IssueField = document.getElementById("cboIssueType").value;
    if (IssueField != "") {
        var url = "frmProductBacklog.aspx/GetStatus";
        data = JSON.stringify({ ProjectID: projectid, Issue_Type: obj.value });
        CustomAJAXCall(url, data, BindStatus);

    }


}
//function BindDropdownSubType(result) {


//    var strArray = String(result.d).split("|")
//    objCbo1 = document.getElementById("cboSubIssueType");


//    var i = 0;

//    var url = "frmProductBacklog.aspx/GetDefaultValues";
//    data = JSON.stringify({ strResult: document.getElementById("cboSubIssueType").value });
//    var result = AJAXCallWithResult(url, data,true);



//    objCbo1.innerHTML = "";

//    $.each(JSON.parse(strArray[0]), function (id, obj) {

//        var objOption = document.createElement("OPTION");
//        objCbo1.options.add(objOption);
//        objOption.text = obj.FieldID;
//        objOption.value = obj.FieldName;

//    });

//    objCbo1.value = result.d;



//}


function BindStatus(result) {
    // debugger;
    var strArray = String(result.d).split("|")
    // alert(strArray);
    objCbo1 = document.getElementById("cboStatus");
    var i = 0;
    objCbo1.innerHTML = "";

    $.each(JSON.parse(strArray[0]), function (id, obj) {

        var objOption = document.createElement("OPTION");
        objCbo1.options.add(objOption);
        objOption.text = obj.FieldID;
        objOption.value = obj.FieldName;

    });

    // objCbo1.value = result.d;

}

function deleteRow(evt, rowID) {
    // alert(deleteButtonHitCountMSSection)
    objTbl.deleteRow(evt.parentNode.parentNode.rowIndex);
    checkValidation(parseInt(rowID) - 1, 'search');
    intResource -= 1;
}
function deleteRowSection(evt, deleteRow) {

    var objform = GetFormReference('form1');
    var objtblMSSection = GetObjectReference('form1', 'tblProjectDetail');
    var totalcount = objtblMSSection.rows.length - 1;
    var cnt = 0
    var deleteButtonHitCountMSSection = 0;
    objtblMSSection.deleteRow(evt.parentNode.parentNode.rowIndex);
    deleteButtonHitCountMSSection = parseInt(deleteButtonHitCountMSSection) + 1;
    noOfRows = noOfRows - 1;
    totalcount = totalcount - 1;
    deleteArr.push(deleteRow);


}
function GetFormReference(strFormId) {
    var objElement;

    objElement = document.getElementById(strFormId);
    return objElement;

}
function CustomAJAXCall(url, data, method) {
    $.ajax({
        type: "POST",
        url: url,
        data: data,
        dataType: "json",
        contentType: "application/json",
        timeout: 180000,
        async: false,
        success: function (result) {
            method(result);
            //Stop();
        },
        error: function (xhr, status, error) {
            // Stop();
            //  StopAjaxLoader("body");
            console.log(xhr.responseText);
            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

}
var isValid = 0;
var saveFlag = 0;
var intResource = 1;

var strcombohtml = "";
var strcombohtml1 = "";
var objform = GetFormReference('form1');
var objDivMain = GetObjectReference('form1', 'PageDiv');
var objDivTab = GetObjectReference('form1', 'divTblGrid');
var objTaskSDt, objTaskEDt, objTaskHrs, objBalenceWork;
var objTbl = GetObjectReference('form1', 'tblProjectDetail');
var objQTaskCounter = GetObjectReference('', 'RowNumber');

if (objQTaskCounter != null)
    noOfRows = parseInt(objQTaskCounter.value) - 1;
else
    noOfRows = 0;

if (objTbl != null) {
    NewTR1 = objTbl.insertRow(objTbl.rows.length);

    NewTD1 = NewTR1.insertCell(0);
    NewTD1 = NewTR1.insertCell(1);
    NewTD1 = NewTR1.insertCell(2);
    NewTD1 = NewTR1.insertCell(3);
    NewTD1 = NewTR1.insertCell(4);
    NewTD1 = NewTR1.insertCell(5);
    NewTD1 = NewTR1.insertCell(6);
    NewTD1 = NewTR1.insertCell(7);
    NewTD1 = NewTR1.insertCell(8);
}
var noOfRows;
var LastRowNumber;
LastRowNumber = -1; var isInValid = 0;
function ShowHide_SectionTR() {

    if (isValid == 0 && saveFlag == 1) {
        if (intResource < 5) {
            CreateRowForResource();
            isValid = 0;
            intResource += 1;
            $('[data-bs-toggle="tooltip"]').tooltip();

        }
    }
    else {

        validateTask();

    }
}




var objform = GetFormReference('form1');
var objtblMSSection = GetObjectReference('form1', 'tblProjectDetail');
if (objtblMSSection != null) {
    var totalcount = objtblMSSection.rows.length;
    var cnt = 0;
    var objtxtHidRCMSSection = GetObjectReference('form1', 'txtHidRC');

    if (objtxtHidRCMSSection != null)
        noOfRows = parseInt(objtxtHidRCMSSection.value);
    else
        noOfRows = 0;

    totalMSRowCount = noOfRows;
    //alert(totalMSRowCount)
}
function CreateRowForResource() {


    if (insertRow != null) {
        NewTR = tblProjectDetail.insertRow(tblProjectDetail.rows.length)
    }

    if (noOfRows == 0) {
        noOfRows = 1;
    }
    else
        noOfRows = noOfRows + 1;


    objTbl = GetObjectReference('form1', 'tblProjectDetail');
    totalcount = tblProjectDetail.rows.length - 1;
    // alert(totalcount)

    if (noOfRows == 0) {
        noOfRows = 1;
        totalcount = 1;
    }
    else {
        noOfRows = noOfRows;
        totalcount = totalcount;
    }

    newTD = NewTR.insertCell(0);
    // newTD.align = 'Left';
    newTD.innerHTML = "<td style='Width:5%;text-align:left' ><a onclick='deleteRow(this," + totalcount + ")'><i class='fa fa-remove ' style='color:Black;cursor:pointer;height:29px;width:10%;margin-top:21%;margin-left:23%'  data-bs-toggle='tooltip' title='Remove record' data-placement='right'></i></a></td>"



    //cell 2

    newTD = NewTR.insertCell(1);
    newTD.align = 'Left';
    NewTR.id = 'TR' + totalcount;
    strcombohtml += "<input type='text' placeholder='Task Name' class='form-control' id='txtTaskName" + totalcount + "' name='txtTaskName" + totalcount + "')>"
    strcombohtml = strcombohtml.replace(/txtTaskName/g, "txtTaskName")
    strcombohtml =
        strcombohtml += "<td  style='color:#dd4b39;font-size:16px'>"
    //strcombohtml += "<i id='spanRole" + totalcount + "' data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>";
    strcombohtml += "</td>";
    newTD.innerHTML = '<td style="width:20%"> ' + strcombohtml + '<input type=hidden name="hdrownumber" value=' + totalcount + ' /></td>';


    // alert(strcombohtml)


    newTD = NewTR.insertCell(2);
    newTD.align = 'Left';
    strcombohtml = "";
    strcombohtml += "<input type='text' placeholder='Start Date' class='form-control' id='txtStartDate" + totalcount + "' name='txtStartDate" + totalcount + "' )>"
    strcombohtml = strcombohtml.replace(/txtStartDate/g, "txtStartDate")
    strcombohtml += "<input type=hidden name='hdrownumber' value='" + totalcount + "' />"
    strcombohtml += " <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpstartdate" + totalcount + "'  onclick='$('#txtStartDate" + totalcount + "').datepicker();$('#txtStartDate" + totalcount + "').datepicker('show')'></i>"

    //strcombohtml = "<div class='input-group date'>"
    //strcombohtml += "<div class='input-group-addon'>"
    //strcombohtml += "<i class='fa fa-calendar'></i>"
    //strcombohtml += "</div>"
    //strcombohtml += "<input type='text' placeholder='Start Date' class='form-control pull-right' id='txtRresourceStartDate" + totalcount + "' name='txtRresourceStartDate" + totalcount + "' onchange=ClearSpans('txtRresourceStartDate" + totalcount + "','SpantxtRresourceStartDate0','spanStartDate" + totalcount + "','errorPopOver" + totalcount + "')>"
    //strcombohtml += "</div>"

    // alert(strcombohtml.replace(/txtName/g, "txtStartDate1" & LastRowNumber))
    newTD.innerHTML = '<td style="width:15%"> ' + strcombohtml + '</td>';
    // alert(NewTR.id)

    //newTD = NewTR.insertCell(3);
    //newTD.align = 'Left';
    //newTD.style = 'color:#dd4b39;font-size:16px'
    //strcombohtml = "<i id=spanStartDate" + totalcount + " data-bs-toggle='tooltip' style='display:none;' class='fa fa-info-circle' aria-hidden='true'></i>"
    //newTD.innerHTML = '<td >' + strcombohtml + '</td>';

    newTD = NewTR.insertCell(3);
    newTD.align = 'Left';
    strcombohtml = "";
    strcombohtml += "<input type='text' placeholder='End Date' class='form-control' id='txtEndDate" + totalcount + "' name='txtEndDate" + totalcount + "')>"
    strcombohtml = strcombohtml.replace(/txtEndDate/g, "tASKEndDate")
    strcombohtml += " <i class='fa fa-calendar-check-o' aria-hidden='true' style=' margin-top: 12px;color:#0099CC;' id='#dpEnddate" + totalcount + "'  onclick='$('#txtEndDate" + totalcount + "').datepicker();$('#txtEndDate" + totalcount + "').datepicker('show')'></i>"


    newTD.innerHTML = '<td style="width:15%"> ' + strcombohtml + '</td>';
    //  alert(NewTR.id)

    newTD = NewTR.insertCell(4);


    newTD.align = 'Left';
    strcombohtml = "";
    newTD.style = 'color:#dd4b39;font-size:16px'
    strcombohtml += "<input type='text' placeholder='Work Hrs' class='form-control' id='txtWorkHrs" + totalcount + "' name='txtWorkHrs" + totalcount + "')>"
    strcombohtml = strcombohtml.replace(/txtWorkHrs/g, "txtWorkHrs")
    newTD.innerHTML = '<td style="width:10%">' + strcombohtml + '</td>';




    newTD = NewTR.insertCell(5);


    newTD.align = 'Left';
    strcombohtml = "";
    newTD.style = 'color:#dd4b39;font-size:16px'
    // strcombohtml += "<%=CommonFunctions.HTMLControls.DrawComboBox("cboresource0", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", 120, , "class='form-control' ", True, True))"
    strcombohtml += "<select name='cboresource" + totalcount + "' name='cboresource" + totalcount + "' class='form-control' style='width:120px'>"
    strcombohtml = strcombohtml.replace(/cboresource/g, "cboresource")
    newTD.innerHTML = '<td style="width:10%">' + strcombohtml + '</td>';






    newTD = NewTR.insertCell(6);


    newTD.align = 'Left';
    strcombohtml = "";
    newTD.style = 'color:#dd4b39;font-size:16px;text-align:center'
    strcombohtml += "<i style='font-size:14px!important;text-align:center;color:#429ad4' data-bs-toggle='tooltip'  id='idEdit" + totalcount + "' data-bs-toggle='tooltip' title='Edit Task' class='fa fa-pencil' onclick='EditTask()'></i>"
    strcombohtml = strcombohtml.replace(/idEdit/g, "idEdit")
    newTD.innerHTML = '<td style="width:7%;text-align:center">' + strcombohtml + '</td>';



    newTD = NewTR.insertCell(7);


    newTD.align = 'Left';
    strcombohtml = "";
    newTD.style = 'color:#dd4b39;font-size:16px;text-align:center'
    strcombohtml += "<i style='font-size:14px!important;text-align:center;color:red;cursor:no-drop' data-bs-toggle='tooltip'  id='iddelete" + totalcount + "' title='Delete Task' class='fa fa-ban' onclick='DeleteTask()' disabled></i>"
    strcombohtml = strcombohtml.replace(/iddelete/g, "iddelete")
    newTD.innerHTML = '<td style="width:7%;text-align:center">' + strcombohtml + '</td>';




    //newTD = NewTR.insertCell(8);


    //newTD.align = 'Left';
    //strcombohtml = "";
    //newTD.style = 'color:#dd4b39;font-size:16px'
    //strcombohtml += "<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  id='SaveBtn" + totalcount + "' data-bs-toggle='tooltip' title='save Task' class='fa fa-save' onclick='Save_SubTab_Data(" & userStoryID & ",Task)'></i>"
    //strcombohtml = strcombohtml.replace(/SaveBtn/g, "SaveBtn" + totalcount)
    //newTD.innerHTML = '<td style="width:7%;text-align:center">' + strcombohtml + '</td>';

    newTD = NewTR.insertCell(8);


    newTD.align = 'Left';
    strcombohtml = "";
    // var flag = "Task";
    newTD.style = 'color:black;font-size:16px;text-align:center'
    strcombohtml += "<i style='font-size:14px!important;text-align:center' data-bs-toggle='tooltip'  id='SaveBtn" + totalcount + "' title='Save Task' class='fa fa-save' onclick=Save_SubTab_Data('" + strUserStoryId + "','Task')></i>"
    strcombohtml = strcombohtml.replace(/SaveBtn/g, "SaveBtn")
    newTD.innerHTML = '<td style="width:7%;text-align:center;color:black">' + strcombohtml + '</td>';


    newTD = NewTR.insertCell(9);
    newTD.align = 'Left';
    strcombohtml = "";
    newTD.innerHTML = '<td><a id=errorPopOver' + totalcount + '  style="font-size:15px;display:none" title="Header" data-bs-toggle="popover" data-target="#popOverDiv"  data-placement="left" data-content="" onmouseover="DataHover(this)" class="btn btn-block btn-danger fa fa-check-square-o errorList"></a></td>'

    newTD.innerHTML = '' + newTD.innerHTML + '';



    //BindEmployeeDetails(totalcount);

}

var ResoureIDs = "";
function SelectResource(object, EmployeeID, EmployeeName) {

    $("#cboReviewee").val('');
    $(".k-checkbox").each(function () {
        if ($(this).prop('checked')) {
            var value = $(this).val();
            // var ResoureName = value.split(",")
            // var ResoureIDAll = ResoureName[1];

            //$("#cboReviewee").val($("#cboReviewee").val() + ResoureName + ',');
            $("#cboReviewee").val($("#cboReviewee").val() + value + ',');
            // alert($("#cboReviewee").val());
            //ResoureIDs.push(ResoureIDAll)
            if (ResoureIDs == undefined) {
                ResoureIDs = '';
            }
            if (ResoureIDs.indexOf($("#hdnresourceID" + EmployeeID).val()) == -1) {
                ResoureIDs = ResoureIDs + $("#hdnresourceID" + EmployeeID).val() + ','
                ResoureallIDs = ResoureIDs;
            }

            // alert(ResoureallIDs);
            // $(this).css("background-color", "#3c7dcf");
            //  $(".dropdown-menu li").addClass('activecls');
            $(this).find('li').addClass('activecls');
        }
        else {
            // $(".dropdown-menu li").addClass('activecls');
            $(this).find('li').removeClass('activecls');
        }
    });

}


var Reviwers = "";
function SelectReviwer(object, EmployeeID, EmployeeName) {

    $("#cboReviewer").val('');
    $(".k-checkboxcboReviewer").each(function () {
        if ($(this).prop('checked')) {
            var value = $(this).val();
            //  $('#cboReviewer').val($("#hdnstrUserName").val());
            // $("#cboReviewer").val($("#hdnstrUserName").val() + ',' + value + ',');
            $("#cboReviewer").val($("#cboReviewer").val() + value + ',');
            if (Reviwers == undefined) {
                Reviwers = '';
            }
            if (Reviwers.indexOf($("#hdnReviwerID" + EmployeeID).val()) == -1) {
                //Reviwers = Reviwers + $("#hdnReviwerID" + EmployeeID).val() + ','
                Reviwers = Reviwers + $("#hdnReviwerID" + EmployeeID).val() + ','
                // $('#cboReviewer').val($("#hdnstrUserName").val());
            }

            //alert(Reviwers);
            // $(this).css("background-color", "#3c7dcf");
            //  $(".dropdown-menu li").addClass('activecls');
            $(this).find('li').addClass('activecls');
        }
        else {
            // $(".dropdown-menu li").addClass('activecls');
            $(this).find('li').removeClass('activecls');
        }
    });

}
function Filter_clear() {

    RefreshGrid();
    //Added by Usha Pandit on 29.04.2019 for not showing option list after clicking on clear filter
    if (filterFlag != "Release" && filterFlag != "Sprint") {
        $("#idfilter").dropdown('toggle');
    }
    //End of Added by Usha Pandit on 29.04.2019 for not showing option list after clicking on clear filter

    $(".fa-ellipsis-h").tooltip();
    $("#idfilter").css("display", "none");
    // $("#uldropdown").css("display", "none")
    $("#ProductFilterRelease").val('');
    $("#ProductFilterSprint").val('');
    $(".attachment").tooltip();
    $(".discussion").tooltip();
    $(".issue").tooltip();
    $(".details").tooltip();
    $(".charts").tooltip();
    $(".priority").tooltip();
    $(".drag").tooltip();
    $(".story_point").tooltip();
    $(".view_story").tooltip();
    $(".delete_story").tooltip();
    $(".user_story").tooltip();
    $(".rank").tooltip();
    $(".view").tooltip();
    $(".user-story-description").tooltip();
    $(".fa-ellipsis-h").tooltip();


    $('[data-bs-toggle="tooltip"]').tooltip();
}
function GetObjectReference(strFormId, strElementId, blnIsName) {
    var objElement;
    var objCombo;

    if (blnIsName) {
        objElement = document.getElementsByName(strElementId);
    }
    else if (!(blnIsName)) {
        objElement = document.getElementById(strElementId);
    }
    return objElement;

}


function GetMappedSprint(userStoryID, flag) {
    strUserStoryId = userStoryID
    var strResult, data;
    data = JSON.stringify({ strUserStoryId: userStoryID, Flag: "", Value: Value });
    strResult = AJAXCallWithResult("frmProductBacklog.aspx/ScrumIterationList", data, false);

    if (strResult.d != '') {

        $("#DivSprintlist").modal('show');//divProductBacklog
        $("#divListdetails").html(strResult.d);
        // $("#divProductBacklog").modal('hide');
        // $("#divProductBacklog").removeClass('in');
        if ($("#FilterDivSprintlist").val() > 0) {
            datatables('DivSprintlist', 'txtSprintSearch', '');
        }
        $('[data-bs-toggle="tooltip"]').tooltip();
    }



    //$('[data-bs-toggle="tooltip"]').tooltip();
}


function SelectOneSprintmappedtoUS(obj) {
    $('input.clscheckbox').on('change', function () {
        $('input.clscheckbox').not(this).prop('checked', false);
    });
}


//var strUserStoryId="";
function MappedSprint() {


    var strSeletedIteration = '';
    strSeletedIteration = $('input[name=chkIterationSel]:checked').map(function () {
        return this.value;
    }).get().join(',');

    if (strSeletedIteration.length <= 0) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Select at least one Sprint', 'error');
        return;
    }
    else {

        // strUserStoryId = $("#hdnusid").val();


        var strResult, data;
        data = JSON.stringify({ UserStoryID: strUserStoryId, IterationID: strSeletedIteration, strMapFlag: "MapWithoutTask" });
        strResult = AJAXCallWithResult("frmProductBacklog.aspx/Save_IterationUserStories", data, false);
        if (strResult.d != '') {

            $("#DivSprintlist").modal('hide');
            strUserStoryId = '';
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('User Story mapped to Sprint Successfully');

            RefreshGrid();
            $('[data-bs-toggle="tooltip"]').tooltip();
        }


    }

}


function RenameCategory(CategoryID) {
    EditCategoryName(CategoryID)
    // alert(CategoryID);
}

function DeleteCategory(CategoryID) {


    var result = AJAXCallWithResult("frmProductBacklog.aspx/DeleteCategory",
        JSON.stringify({ CategoryID: CategoryID }), false);


    if (result.d == "0") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.success('Category Deleted Successfully');
        RefreshGrid();
        $('[data-bs-toggle="tooltip"]').tooltip();


    }
    else {
        alertify.set('notifier', 'position', 'top-right');
        // Commented and Added by Sagar N on 08-Apr-2019 Purpose IsssueID-11860
        //alertify.notify('User Story created with that Category, You can not deleted ', 'error');
        alertify.notify('Can not delete swim lane because it contains user story', 'error');
        // End of Commented and Added by Sagar N on 08-Apr-2019 Purpose IsssueID-11860

    }
}


function EditCategoryName(CategoryID) {
    // alert(CategoryID);
    //if (CategoryID != "Null") {
    $("#txtCategoryname_" + CategoryID).prop('disabled', false);
    $("#txtCategoryname_" + CategoryID).css({ "background-color": "#fff", "color": "#000" });
    $("#txtCategoryname_" + CategoryID).focus();
    var val = $("#txtCategoryname_" + CategoryID).val();
    $("#txtCategoryname_" + CategoryID).val(''); // unset first
    $("#txtCategoryname_" + CategoryID).val(val); // re-set next
}

function Hide() {


}
function ChangeCategoryName(CategoryID) {
    /* Changes done by Usha Pandit on 01 June 2018 .trim() is added  */
    if ($("#txtCategoryname_" + CategoryID).val().trim() == "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Category Name should not be left blank.', 'error');
        $("#txtCategoryname_" + CategoryID).focus();

        return;
    }

    if ($("#txtCategoryname_" + CategoryID).val().trim().toUpperCase() == "UNCATEGORIZED") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Category Name should not be UnCategorized.', 'error');
        $("#txtCategoryname_" + CategoryID).focus();

        return;
    }

    //Added by Ankush T on 28 mar 2019 for special character not allowed
    //if (checkSpecialCharacter($("#txtCategoryname_" + CategoryID).val()) == true) {
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify('Category Name should not be contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters', 'error');
    //    return;
    //}
    //Added by Ankush T on 28 mar 2019 for special character  not allowed
    //Added By Riddhesh Patil on 11-NOV-2022 
    if (checkSpecialCharacter($("#txtCategoryname_" + CategoryID).val(), WebConfigSpecialCharacters) == true) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.error('Category Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
        $("#(txtCategoryname_ + CategoryID)").focus();
        return false;
    }
			//End of Added By Riddhesh Patil

    var result = AJAXCallWithResult("frmProductBacklog.aspx/ChangeCategoryname",
        JSON.stringify({ CategoryID: CategoryID, CategoryName: $("#txtCategoryname_" + CategoryID).val() }), false);
    if (result.d == "1") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.success('Category Renamed Successfully');
        RefreshGrid();
        $('[data-bs-toggle="tooltip"]').tooltip();
        $("#txtCategoryname_" + CategoryID).prop('disabled', true);

    }
    else if (result.d == "0") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('Category Name should not be duplicate.', 'error');
        $("#txtCategoryname_" + CategoryID).focus();
        return;
    }
}
var GlobalCategory = ""
function AddCategory(CategoryID) {
    // GlobalCategory = CategoryID
    var result = AJAXCallWithResult("frmProductBacklog.aspx/PlotCategoryDetails",
        JSON.stringify({ CategoryID: CategoryID }), false);//NewCategoryName: $("#txtCategoryname_" + CategoryID).val() 
    if (result.d != "") {
        $("#AddCategoryBody").html("");
        $("#AddCategoryBody").html(result.d);
        $("#AddCategory").modal('show');//divProductBacklog
        $('[data-bs-toggle="tooltip"]').tooltip();

        // RefreshGrid();
    }


}
function SaveCategory() {

    //debugger;

    if (ValidationAddCategory() == 0) {

        //ChangeColorTD = cColor;
        var CateGoryName = $("#CateGoryName").val();
        var CategoryOrder = $("#CategoryOrder").val();
        var result = AJAXCallWithResult("frmProductBacklog.aspx/AddNewCategory",
            JSON.stringify({ CateGoryName: CateGoryName, CategoryOrder: CategoryOrder }), false);
        // var strUserResult = AJAXCallWithResult("frmProductBacklog.aspx/AddNewCategory","POST", "application/json", "json", JSON.stringify({ CateGoryName: CateGoryName, ChangeColorTD: ChangeColorTD, CategoryOrder: CategoryOrder,

        // RefreshGrid();

        if (result.d != "") {
            //alert(result.d);
            document.getElementById("divGrid").innerHTML = result.d;
            alertify.set('notifier', 'position', 'top-right');
            alertify.success('Category added Successfully ');
            $("#AddCategory").modal('hide');

        }
    }
    RefreshGrid();

}

function ValidationAddCategory() {
    // debugger;
    var checkvalue = 0;
    var Flag = 0;
    var strmsg = "";
    var errorMsg = "<ul>"

    //Added by Usha Pandit on 01 June 2018 for preventing Category name as uncategorized
    if ($("#CateGoryName").val().trim().toUpperCase() == "UNCATEGORIZED") {
        strmsg = '- Category Name should not be UnCategorized';
        errorMsg += "<li>" + strmsg + "</li></br>";

        $("#CateGoryName").focus();
        Flag = 1;
        checkvalue = 1;
    }
    //End of Added by Usha Pandit on 01 June 2018 for preventing Category name as uncategorized

    if ($("#CateGoryName").val() == "") {
        strmsg = '- Category Name should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }
    //Comment & Added By Riddhesh Patil on 11-NOV-2022 
    //Added by Ankush T on 28 mar 2019 for special character not allowed
    //if (checkSpecialCharacter($("#CateGoryName").val()) == true) {
    //    // alertify.set('notifier', 'position', 'top-right');
    //    strmsg = 'Category Name should not be contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
    //    errorMsg += "<li>" + strmsg + "</li></br>";
    //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
    //    Flag = 1;
    //    checkvalue = 1;
    //}
    //Added by Ankush T on 28 mar 2019 for special character  not allowed
    
    else if (checkSpecialCharacter($("#CateGoryName").val(), WebConfigSpecialCharacters) == true) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.error('Category Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
        $("#CateGoryName").focus();
        Flag = 1;
        checkvalue = 1; 
    }
			//End of Added By Riddhesh Patil
    if ($("#CategoryOrder").val() == "") {
        strmsg = '- Category Order should not be left blank';
        errorMsg += "<li>" + strmsg + "</li></br>";
        Flag = 1;
        checkvalue = 1;
    }
    if ($("#CategoryOrder").val() != "") {
        //  debugger;
        if (RestrictNonNumeric(document.getElementById("CategoryOrder")) == true) {


            strmsg = '- Please Enter  Numeric Value For Category Order';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if (parseFloat($("#CategoryOrder").val()) < 0 && $("#CategoryOrder").val() != '') {
            //alert('Please enter positive number');
            // alertify.set('notifier', 'position', 'top-right');
            // alertify.notify('- Please enter positive Value For Category Order.', 'error');
            strmsg = '- Please enter positive Value For Category Order';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
            $("#CategoryOrder").focus();

        }

        if (($("#CategoryOrder").val() - 0) == 0) {
            strmsg = '- Category Order should be  more than 0';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

    }
    if ($("#CateGoryName").val() != "")//For Categoryname
    {
        var strUserResult = ajaxCall('frmProductBacklog.aspx/IsCategoryorderExists', "POST", "application/json", "json", JSON.stringify({ CateGoryName: $("#CateGoryName").val(), CateID: "" }))
        if (strUserResult.d != "") {
            strmsg = strUserResult.d;
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;


        }


    }



    if (strmsg != "") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(errorMsg, 'error', 15);

    }
    return checkvalue;

}




function Document_OnClick(strSystemFileName, strOriginalFileName) {
    // debugger;
    // alert(strSystemFileName);
    // alert(strOriginalFileName);
    // debugger;
    var strTemp = '../General/ViewAttachment.aspx?FromWhere=Agile&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
    window.open(strTemp);
}
//End of Added By Dipali V On 2nd April 2018 For Sprint & release Saving


//Added By Ankush T on 22/05/2018 for Excel upload

async function Next_onclick() {
    // debugger;
    var Flag;
    var flag2 = "";
    try {
        // alert(arrProcessFile[0]);
        //formData.append('Mode', 'AdjustmentFile');

        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


        if (arrProcessFile[0] != "") {
            var objtxtFileName = arrProcessFile[0].name;
            var objFile = objtxtFileName;
            var fileName = objtxtFileName;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


            isValidTypeExeCheck = false;
            //var fileName = arrFile[0];
            //    var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            //  var objFileName = arrFile[0] ;
            isValidTypeExeCheck = false;
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            const ValidExtsExe = ValidateFileExtension.split(",");
            isValidTypeExeCheck = ValidExtsExe.includes(extension);
           
            if (isValidTypeExeCheck) {
                const file = arrProcessFile[0];
                //const error = await validateDocFileForExe(file);
                //console.log(error);
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        isValidTypeExeCheckFlag = true
                    })
                    .catch(error => {
                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        $("#Filename").text("Drag files here or click to upload");
                        $(".demo-droppable p").text("Drag files here or click to upload");
                        arrProcessFile = [];
                        isValidTypeExeCheck = false;
                        isValidTypeExeCheckFlag = false;
                        $(objtxtFileName).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

            //Ended by Parth Godshelwar
        }





            //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not



        if (arrProcessFile[0] != '') {
            if (arrProcessFile[0] != undefined) {
                if (arrProcessFile[0].name.indexOf(".xls") > 0 || arrProcessFile[0].name.indexOf(".xlsx") > 0) {

                    var strUserResult = ajaxCall("frmProductBacklog.aspx/ExcelUploadMapped", "POST", "application/json", "json",
                        JSON.stringify({ Flag: "", From: "", flag2: "" }));
                    // alert(strUserResult.d);
                    $("#NewExcelUpload").modal('show');
                    $("#lblstep").text("Step 2");
                    $("#ExcelUploadNew").html(strUserResult.d);//tblFieldList

                }
                else {

                    //alert("Only excel files are allowed");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Only excel files are allowed', 'error', 15);
                    return;
                }
            }
        }
        else {

            //alert("Select at least one file to upload");

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Select at least one file to upload', 'error', 15);
            return;
            // return;
        }
    }
    catch (ex) {
        //alert(ex.message);
    }
}

function Back_onclick() {
    //debugger;
    var Flag;
    var flag2 = "";
    //formData.append('Mode', 'AdjustmentFile');
    //if (arrFile[0] != undefined) {

    var strUserResult = ajaxCall("frmProductBacklog.aspx/ExcelUploadBack", "POST", "application/json", "json",
        JSON.stringify({ Flag: "Upload", From: "Back", flag2: "" }));
    // alert(strUserResult.d);
    $("#NewExcelUpload").modal('show');
    //$("#atag").text("Step 1");
    $("#lblstep").text("Step 1");
    $("#ExcelUploadNew").html("");//tblFieldList
    $("#ExcelUploadNew").html(strUserResult.d);//tblFieldList


    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
        var output = document.querySelector('.demo-droppable');
        // output.innerHTML = '';
        arrProcessFile = [];
        for (var i = 0; i < files.length; i++) {
            arrProcessFile[0] = files[i];
            // output.innerHTML += '<p>' + files[i].name + '</p>';
            $("#Filename").text(files[i].name);
        }
    });
    //alert(arrProcessFile[0]);
    if (arrProcessFile[0] != undefined) {
        //  alert(arrFile[0]);
        $("#Filename").text(arrProcessFile[0].name);
        // location.reload(true);

    }

    else {

        $("#Filename").text("Drag files here or click to upload");
        arrProcessFile = [];
        //location.reload(true);
    }

    while (arrPBFields.length > 0) {

        arrPBFields.pop();
    }
    // arrPBFields = [];
    while (arrExcelFields1.length > 0) {
        arrExcelFields1.pop();
    }
    //arrExcelFields1 = [];
    while (arrExcelFields.length > 0) {
        arrExcelFields.pop();
    }
    $('[data-bs-toggle="tooltip"]').tooltip();
}
//}
function BackProcess_onclick() {

    var Flag = "Upload";
    var flag2 = "afterprocess";
    //formData.append('Mode', 'AdjustmentFile');
    //if (arrFile[0] != undefined) {

    var strUserResult = ajaxCall("frmProductBacklog.aspx/ExcelUploadBackProcess", "POST", "application/json", "json",
        JSON.stringify({ Flag: "Upload", From: "Back", flag2: "afterprocess" }));
    // alert(strUserResult.d);
    $("#NewExcelUpload").modal('show');
    //$("#atag").text("Step 1");
    $("#lblstep").text("Step 1");
    $("#ExcelUploadNew").html("");//tblFieldList
    $("#ExcelUploadNew").html(strUserResult.d);//tblFieldList


    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
        var output = document.querySelector('.demo-droppable');
        // output.innerHTML = '';
        arrProcessFile = [];
        for (var i = 0; i < files.length; i++) {
            arrProcessFile[0] = files[i];
            // output.innerHTML += '<p>' + files[i].name + '</p>';
            $("#Filename").text(files[i].name);
        }
    });
    //alert(arrProcessFile[0]);
    if (arrProcessFile[0] != undefined) {
        //  alert(arrFile[0]);
        $("#Filename").text(arrProcessFile[0].name);
        // location.reload(true);

    }

    else {

        $("#Filename").text("Drag files here or click to upload");
        arrProcessFile = [];
        //location.reload(true);
    }

    while (arrPBFields.length > 0) {

        arrPBFields.pop();
    }
    // arrPBFields = [];
    while (arrExcelFields1.length > 0) {
        arrExcelFields1.pop();
    }
    //arrExcelFields1 = [];
    while (arrExcelFields.length > 0) {
        arrExcelFields.pop();
    }
    $('[data-bs-toggle="tooltip"]').tooltip();
}
function BackExcel_onclick() {
    //debugger;
    var Flag = "";
    var flag2 = "afterprocess";
    //formData.append('Mode', 'AdjustmentFile');
    //if (arrFile[0] != undefined) {

    var strUserResult = ajaxCall("frmProductBacklog.aspx/ExcelUploadMappedProcess", "POST", "application/json", "json",
        JSON.stringify({ Flag: "", From: "", flag2: "afterprocess" }));
    // alert(strUserResult.d);
    $("#NewExcelUpload").modal('show');
    $("#lblstep").text("Step 2");
    $("#ExcelUploadNew").html("");//tblFieldList
    $("#ExcelUploadNew").html(strUserResult.d);//tblFieldList

    while (arrPBFields.length > 0) {

        arrPBFields.pop();
    }
    // arrPBFields = [];
    while (arrExcelFields1.length > 0) {
        arrExcelFields1.pop();
    }
    //arrExcelFields1 = [];
    while (arrExcelFields.length > 0) {
        arrExcelFields.pop();
    }

    //makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
    //    var output = document.querySelector('.demo-droppable');
    //    output.innerHTML = '';
    //    for (var i = 0; i < files.length; i++) {
    //        arrProcessFile[0] = files[i];
    //        output.innerHTML += '<p>' + files[i].name + '</p>';
    //        //$("#Filename").text(files[i].name);
    //    }
    //});


    $('[data-bs-toggle="tooltip"]').tooltip();
}


function Process_Click() {
    //debugger;
    var strURL = "frmProductBacklog.aspx";
    var formData = new FormData();
    formData.append('File', arrProcessFile[0]);
    formData.append('Mode', 'ProcessFile');
    var PBFile = arrProcessFile[0];
    if (PBFile != undefined) {
        if (PBFile.name.indexOf(".xls") > 0 || PBFile.name.indexOf(".xlsx") > 0) {
            $.ajax({
                //Server script to process data
                type: 'POST',
                url: 'frmProductBacklog.aspx',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (result) {
                    $('#ExcelUploadNew').html(result);
                    $('#lblstep').text("Step 3");
                    // if ($('tr.clsValidRow ').length <= 0) {
                    var flag = 0;
                    $(".chkUS").each(function () {
                        // debugger;
                        var $this = $(this);
                        if ($this.is(":checked")) {
                            flag = 1;
                        }
                    });

                    if (flag == 1) {
                        // $("#modalFooter button.btn-primary").prop('disabled', 'false');
                        $("#modalFooter button.btn-primary").removeAttr("disabled")
                    }
                    else {
                        $("#modalFooter button.btn-primary").prop('disabled', 'true');
                        // $("#modalFooter button.btn-primary").addAttr("disabled")
                        //}
                        //    
                        // $("#modalFooter button.btn-primary").prop('disabled', 'true');
                    }

                    $('#modalFooter').show();

                    var intDivHeight;

                    //if (WhichBrowser() == 'IE') {
                    //    intDivHeight = window.innerHeight - ($('#excelDataDivInner').offset().top * 2.5) + 30;
                    //}
                    //else {
                    //    intDivHeight = window.innerHeight - ($('#excelDataDivInner').offset().top * 2.5) + 10;
                    //}

                    datatablesExcelUpload('excelDataDivInner', 'txtSearchExcelData', intDivHeight);

                    //$('.clsInValidRow').css('color','red');
                    //$('.clsValidRow').css('color','green');
                },

            });
        }
        else {
            // alert("Only excel files are allowed.");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Only excel files are allowed.', 'error');
        }
        if (document.getElementById("hdnIschecklimit") != undefined || document.getElementById("hdnIschecklimit") != null) {//Added By Dipali V On 20th May 2020 For Issue ID 23694
            if (document.getElementById("hdnIschecklimit").value == "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Only 100 User Stories can be uploaded at a time.", 'error');
                BackExcel_onclick();
            }
            else {
                var ValidRows = $("#hdnvalidRowCount").val();
                var InValidRows = $("#hdnInvalidRowCount").val();
                var strMsg = ""
                var strMsg1 = ""
                if (ValidRows != "" || InValidRows != "") {
                    strMsg += "Valid Records: " + ValidRows + ""
                    strMsg1 += "Invalid Records: " + InValidRows + ""

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strMsg, 'success');

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strMsg1, 'error');
                    //alert(strMsg);
                }
            }
        }
    }
}

function UploadExcel_Click(object) {
    // debugger;
    if ($("#hdnIschecklimit").val() != 1) {
        var AttachmentID = document.getElementById("hdnAttachmentID").value;

        var data = JSON.stringify({ AttachmentID: AttachmentID });
        var strResult = AJAXCallWithResult("frmProductBacklog.aspx/UploadDataExcel", data, false);

        var finalResult = strResult.d.split("||");
        // alert(finalResult[0]);
        // alert(finalResult[1]);
        if (finalResult[0] == "1") {
            //$("[data-dismiss=modal]").trigger({ type: "click" });
            $("#NewExcelUpload").modal('hide');
        }
        //alert($("#hdnIschecklimit").val());
        document.getElementById("divGrid").innerHTML = finalResult[1];
        $("#divMain").css("height", window.innerHeight - 12 + 'px');
        $(".Outerdiv").css("height", window.innerHeight - 220 + 'px');
        $(".blankdiv").css("height", window.innerHeight - 220 + 'px');
        $(".adjustheight").css("height", window.innerHeight - 220 + 'px');

        $(".Main").css("width", (((window.innerWidth / 3) - 30) * $(".divDraggable1").length) + 'px');

        if ($(window).width() > 768) {
            $(".divDraggable1").css("min-height", window.innerHeight - 80 + 'px');
            $(".divDraggable1").css("height", '100%');
            $(".divDraggable1").css("width", (window.innerWidth / 3) - 35 + 'px');
        }
        else {
            $(".divDraggable1").css("min-height", '');
            $(".divDraggable1").css("height", '');
            $(".Main").css("height", '');
            $(".divDraggable1").css("width", '100%');
        }
        SetWidthHeight();
        // arrProcessFile = [];
        // location.reload();

    }
    else {

        alertify.set('notifier', 'position', 'top-right');
        alertify.notify("Max 100  user stroies you can upload at a time ", 'error');

    }
    arrProcessFile[0] = [];
    //arrExcelFields1 = [];
    while (arrPBFields.length > 0) {

        arrPBFields.pop();
    }
    // arrPBFields = [];
    while (arrExcelFields1.length > 0) {
        arrExcelFields1.pop();
    }
    //arrExcelFields1 = [];
    while (arrExcelFields.length > 0) {
        arrExcelFields.pop();
    }
}

var arrPBFields = [];
var arrExcelFields1 = [];
var arrExcelFields = [];

function SaveConfig(object) {
    //debugger;
    var k;
    var strMsg = "";
    var IsPriorityPresent = 0;
    var IsDescriptionPresent = 0;
    var IsUSNamePresent = 0;

    arrExcelFields1 = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"];
    arrExcelFields = [];
    arrPBFields = [];

    for (k = 1; k <= 12; k++) {
        //var objcboUSField = document.getElementById("cboUSField_" + k);

        //var e = document.getElementById("cboUSField_" + k);

        //var objcboUSField = e.options[e.selectedIndex];

        objcboUSField = $("#cboUSFields_" + k + " option:selected").val();


        if (objcboUSField != null) {
            arrPBFields.push(objcboUSField);
            arrExcelFields.push(arrExcelFields1[k - 1]);

            if (objcboUSField == "Priority") {

                IsPriorityPresent = 1;
            }

            if (objcboUSField == "Description") {
                IsDescriptionPresent = 1;
            }

            if (objcboUSField == "UserStoryName") {
                IsUSNamePresent = 1;
            }
        }
    }

    if (hasDuplicates(arrPBFields) == true) {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('User Story Fields should not be mapped to multiple excel fields.', 'error');
        return;
    }

    if (IsPriorityPresent == 0)
        strMsg += "Priority,";

    if (IsDescriptionPresent == 0)
        strMsg += "Description,";

    if (IsUSNamePresent == 0)
        strMsg += "UserStoryName,";

    strMsg = strMsg.substr(0, strMsg.length - 1);

    if (strMsg != "") {
        strMsg += " fields are mandatory."
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify(strMsg, 'error');
        return;
    }
    else {

    }
    var data = JSON.stringify({ arrPBFields: arrPBFields, arrExcelFields: arrExcelFields });
    var strResult = AJAXCallWithResult("frmProductBacklog.aspx/SaveExcelConfiguration", data, false);

    //alert(arrPBFields);
    //alert(arrExcelFields);

    if (strResult.d == "1") {
        //alertify.set('notifier', 'position', 'top-right');
        // alertify.notify("Details Saved Successfully", 'success');
        //ExcelUploadClick();
        Process_Click();
        // arrProcessFile = []
    }

}
function hasDuplicates(array) {
    var valuesSoFar = Object.create(null);
    for (var i = 0; i < array.length; ++i) {
        var value = array[i];
        if (value != '') {
            if (value in valuesSoFar) {
                return true;
            }
        }
        valuesSoFar[value] = true;
    }
    return false;
}
function clearuploadFile() {
    //debugger;
    try {
        arrProcessFile = [];
        //arrPBFields.pop(objcboUSField.value);
        //arrExcelFields.pop(arrExcelFields1[k - 1]);
        while (arrPBFields.length > 0) {

            arrPBFields.pop();
        }
        // arrPBFields = [];
        while (arrExcelFields1.length > 0) {
            arrExcelFields1.pop();
        }
        //arrExcelFields1 = [];
        while (arrExcelFields.length > 0) {
            arrExcelFields.pop();
        }
        // arrExcelFields = [];
    }
    catch (ex) {
        //alert(ex.message);
    }
}

function USFields_OnChange(FieldID) {
    //debugger;
    var objcboUSField = document.getElementById("cboUSFields_" + FieldID);
    var objspnUSField = document.getElementById("spnUSFields_" + FieldID);

    if (objcboUSField.value == "Priority") {
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify("Priority should be in 'Must Have','Should Have','Could Have','Wont Have' only in excel ", 'error', 10)

    }
    else {
        $("#spnUSField_" + FieldID).text("");
    }
}
//Ended By  Ankush T on 29/05/2018 for Excel upload

//Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check
function DateDiff(start, end, interval, rounding) {

    var iOut = 0;

    // Create 2 error messages, 1 for each argument.</KBD> 
    //var startMsg = "Check the Start Date and End Date\n"
    //startMsg += "must be a valid date format.\n\n"
    //startMsg += "Please try again." ;

    //var intervalMsg = "Sorry the dateAdd function only accepts\n"
    //intervalMsg += "d, h, m OR s intervals.\n\n"
    //intervalMsg += "Please try again." ;

    var bufferA = Date.parse(start);
    var bufferB = Date.parse(end);

    //// check that the start parameter is a valid Date. </KBD>
    //if ( isNaN (bufferA) || isNaN (bufferB) )
    //{
    //    alert( startMsg ) ;
    //    return null ;
    //}

    // check that an interval parameter was not numeric.</KBD> 
    //if ( interval.charAt == 'undefined' ) 
    //{
    //    // the user specified an incorrect interval, handle the error.</KBD> 
    //    alert( intervalMsg ) ;
    //    return null ;
    //}

    //if(isDate($("#datepicker1"))==false){
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify('Please enter Start date in Valid format.', 'error');
    //    checkvalue = 1;
    //}
    //if(isDate($("#datepicker2"))==false){
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify('Please enter End date in Valid format.', 'error');
    //    checkvalue = 1;
    //}

    var number = bufferB - bufferA;
    // what kind of add to do?</KBD> 
    switch (interval.charAt(0)) {
        case 'd': case 'D':
            iOut = parseInt(number / 86400000);
            if (rounding) iOut += parseInt((number % 86400000) / 43200001);
            break;
        case 'h': case 'H':
            iOut = parseInt(number / 3600000);
            if (rounding) iOut += parseInt((number % 3600000) / 1800001);
            break;
        case 'm': case 'M':
            iOut = parseInt(number / 60000);
            if (rounding) iOut += parseInt((number % 60000) / 30001);
            break;
        case 's': case 'S':
            iOut = parseInt(number / 1000);
            if (rounding) iOut += parseInt((number % 1000) / 501);
            break;
        default:
            // If we get to here then the interval parameter
            // didn't meet the d,h,m,s criteria.  Handle
            // the error.</KBD> 		
            //alert(intervalMsg) ;
            return null;
    }
    return iOut;
}
//End of Added by Usha Pandit on 25.03.2019 for more than 24 hours per day validation check

// Added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993
//Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
var dtstart = '';
var dtend = '';
var dtsdt = '';
var dtedt = '';
var dtvsdt = '';
var dtvedt = '';
//End of Added by Sagar N on 12-Apr-2019 Purpose:: Agile Issue ID- 11993
function dtFormat(strDateFormat) {

    //debugger;

    var sprintDateFormat = '';
    switch (strDateFormat) {
        case 'DD.MM.YYYY':
            sprintDateFormat = 'dd.mm.yy';
            break;

        case 'DD-MM-YYYY':
            sprintDateFormat = 'dd-mm-yy';
            break;

        case 'DD/MM/YYYY':
            sprintDateFormat = 'dd/mm/yy';
            break;

        case 'MM-DD-YYYY':
            sprintDateFormat = 'mm-dd-yy';
            break;

        case 'MM/DD/YYYY':
            sprintDateFormat = 'mm/dd/yy';
            break;

        case 'MM.DD.YYYY':
            sprintDateFormat = 'mm.dd.yy';
            break;

        case 'YYYY-DD-MM':
            sprintDateFormat = 'yy-dd-mm';
            break;

        case 'YYYY.DD.MM':
            sprintDateFormat = 'yy.dd.mm';
            break;

        case 'YYYY/DD/MM':
            sprintDateFormat = 'yy/dd/mm';
            break;

        case 'YYYY-MM-DD':
            //Modified By VarunA on 6-Aug-2008 RequestID-14286
            //Purpose : To have month place instead of day
            //newDate=y + '-' + d + '-' + m;
            sprintDateFormat = 'yy-mm-dd';
            //End By VarunA on 6-Aug-2008 RequestID-14286
            break;

        case 'YYYY/MM/DD':
            sprintDateFormat = 'yy/mm/dd';
            break;

        case 'YYYY.MM.DD':
            sprintDateFormat = 'yy.mm.dd';
            break;

    }
    return sprintDateFormat;
}
function getInputDateFormat(dtStartDate, dtEndDate, Flag, strDateFormat) {

    /*debugger*/;
    switch (strDateFormat) {
        case 'DD.MM.YYYY':
            var arrStartDate = dtStartDate.value.toString().split(".");
            var dd = arrStartDate[0];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split(".");
            var dd = arrEndDate[0];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;
        case 'DD-MM-YYYY':
            var arrStartDate = dtStartDate.value.toString().split("-");
            var dd = arrStartDate[0];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("-");
            var dd = arrEndDate[0];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'DD/MM/YYYY':
            var arrStartDate = dtStartDate.value.toString().split("/");
            var dd = arrStartDate[0];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("/");
            var dd = arrEndDate[0];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY-DD-MM':
            var arrStartDate = dtStartDate.value.toString().split("-");
            var dd = arrStartDate[1];
            var mm = arrStartDate[2];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("-");
            var dd = arrEndDate[1];
            var mm = arrEndDate[2];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY.DD.MM':
            var arrStartDate = dtStartDate.value.toString().split(".");
            var dd = arrStartDate[1];
            var mm = arrStartDate[2];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split(".");
            var dd = arrEndDate[1];
            var mm = arrEndDate[2];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY/DD/MM':
            var arrStartDate = dtStartDate.value.toString().split("/");
            var dd = arrStartDate[1];
            var mm = arrStartDate[2];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("/");
            var dd = arrEndDate[1];
            var mm = arrEndDate[2];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY-MM-DD':
            //debugger;
            var arrStartDate = dtStartDate.value.toString().split("-");
            var dd = arrStartDate[2];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("-");
            var dd = arrEndDate[2];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY.MM.DD':
            var arrStartDate = dtStartDate.value.toString().split(".");
            var dd = arrStartDate[2];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split(".");
            var dd = arrEndDate[2];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;

        case 'YYYY/MM/DD':
            var arrStartDate = dtStartDate.value.toString().split("/");
            var dd = arrStartDate[2];
            var mm = arrStartDate[1];
            var yyyy = arrStartDate[0];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("/");
            var dd = arrEndDate[2];
            var mm = arrEndDate[1];
            var yyyy = arrEndDate[0];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;
        case 'MM-DD-YYYY':
            var arrStartDate = dtStartDate.value.toString().split("-");
            var dd = arrStartDate[1];
            var mm = arrStartDate[0];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("-");
            var dd = arrEndDate[1];
            var mm = arrEndDate[0];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;
        case 'MM.DD.YYYY':
            var arrStartDate = dtStartDate.value.toString().split(".");
            var dd = arrStartDate[1];
            var mm = arrStartDate[0];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split(".");
            var dd = arrEndDate[1];
            var mm = arrEndDate[0];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;
        case 'MM/DD/YYYY':
            var arrStartDate = dtStartDate.value.toString().split("/");
            var dd = arrStartDate[1];
            var mm = arrStartDate[0];
            var yyyy = arrStartDate[2];
            dtstart = mm + '/' + dd + '/' + yyyy;
            dtsdt = yyyy + '-' + mm + '-' + dd;
            dtvsdt = mm + '/' + dd + '/' + yyyy;
            var arrEndDate = dtEndDate.value.toString().split("/");
            var dd = arrEndDate[1];
            var mm = arrEndDate[0];
            var yyyy = arrEndDate[2];
            dtend = mm + '/' + dd + '/' + yyyy;
            dtedt = yyyy + '-' + mm + '-' + dd;
            dtvedt = mm + '/' + dd + '/' + yyyy;
            if (dtStartDate.value != "" && dtEndDate.value != "") {
                dtStartDate.value = dtsdt;
                dtEndDate.value = dtedt;
            }
            dtstart = new Date(dtstart);
            dtend = new Date(dtend);
            break;


    }



}

//End of added by Sagar N on 08-Apr-2019 Purpose:: Agile Issue ID- 11993