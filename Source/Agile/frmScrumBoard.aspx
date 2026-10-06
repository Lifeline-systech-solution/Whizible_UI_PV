<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmScrumBoard.aspx.vb" Inherits="PbNIT.frmScrumBoard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Scrum Board</title>
<%--    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">--%>
    <%CommonFunctions.General.PlotPageHeadTag("Scrum Board")%>

    <link href="css/ScrumBoard.css?v=1.17" rel="stylesheet" />
<%--    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/fontawesome/css/all.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />

<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>  
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
    <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>     --%>
    <script src="js/CommonJS.js?v=4.0"></script>
    <%--<script src="../../Whizible2.0-new/dist/js/bootbox.min.js"></script>--%>    
<%--    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

   
</head>
     <style>
        /*Added by Swapna*/
        .tooltip {
            word-break: break-all;
            white-space: normal;
        }
        .scrum-header{position:relative;margin-bottom:0}
        .clsDivHeader{margin-top: 3px !important;padding-left:42px}
        .scrum-stories-list{padding: 10px 8px;}
        .drag-handler {font-size: 14px !important;margin-right: 3px;}
        .arrow-to-display, .add-dynamic-div{padding: 5px 8px;}
        .fixe{position:initial;width:100%}
        .input-group-addon {
            padding: 13px 12px;
            font-size: 11.5px; 
            /* Modified By Madhuri.K On 26-03-2026 */
    font-weight: 400;
    line-height: 1;
    color: #555;
    text-align: center;
    background-color: #eee;
    border: 1px solid #ccc;
    border-radius: 4px;
}
        .fas.fa-arrows-alt{margin-top:5px}
        .scrum-content h5{margin: 2px 0;padding: 0;}
    </style>
<body style="padding-right: 0px!important;">
    <form id="frmScrumBoard" runat="server">
        <div id="scroll" class="scrollbar">
            <div id="divMain">
                <%WritePage()%>
            </div>
        </div>
        <div class="inner inner-template"></div>

        <div class="row">
            <!--Popup for dynamic div stage-->
            <div class="modal fade" id="openEditpopup" role="dialog">
                <div class="modal-dialog modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Edit Custom Stage</h4>
                        </div>
                        <div class="modal-body" id="divEditStage">
                        </div>
                    </div>
                </div>
            </div>
            <!--Popup end for dynamic div stage-->

            <!--Popup for drag and drop-->
            <div class="modal fade dragdrop" id="DragDropModal" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Drag & Drop user story</h4>
                        </div>
                        <div class="modal-body" id="DragDropBody">
                        </div>
                    </div>
                </div>
            </div>
            <!--End for Popup for drag and drop-->
        </div>


    </form>
    <script type="text/javascript">
        $(document).ready(function () {



            var selected;
            //

            //Added by Usha Pandit on 18 Apr 2019 for user story save crash
            windowWidth = $(window).width();
            //End of Added by Usha Pandit on 18 Apr 2019 for user story save crash

            windowheight = $(window).height();


            $("#divMain").css("height", windowheight);
            // $("#divMain").css("width", windowWidth);
            $("#divMain").css("overflow", "auto");
            centerContent();
            RefreshLoadEvents();
            RefreshGrid();

            /*Added by Yasmin On 16th July 2018*/
            objSprint = document.getElementById("ScrumIterations");
            BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text
            //alert(BydafualtSprintText);
            SelectedCurrentSprint = BydafualtSprintText;
            //SelectedCurrentid = objSprint.options[objSprint.selectedIndex].val();
            SelectedCurrentid = $("#ScrumIterations").val();
            $(".sprintname").text(BydafualtSprintText);


            //Added By Yasmin S on 7th Feb 2019 for div height issue
            var largestheight = '';
            var currentheight = '';
            var finalheight = '';
            $("div[id*='stage_']").each(function () {

                var i = $(this).attr('id');

                var height = $("#" + $(this).attr('id')).height();
                if (largestheight == "") {
                    largestheight = height;
                }
                else {
                    finalheight = largestheight > height ? largestheight : height
                    largestheight = finalheight;
                }


            });
            var id
            $("div[id*='stage_']").css("height", finalheight + 15);
            $("div[id*='innder-']").each(function () {
                id = $(this).attr('id');
                //alert(id);
            });


            $("#divMain").scroll(function () {
                var currentScroll = ($("#divMain").scrollTop() - 45);
                if ($("#divMain").scrollTop()) {
                    $('.scrum-content').each(function () {
                        $('.scrum-content').addClass('fixe');
                        $('.scrum-content').css("top", currentScroll);

                        // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                    });

                } else {
                    $('.scrum-content').removeClass('fixe');
                }
            });



        });
        //to make scrollbar resizable
        $(window).on('resize', function () {
            if ($(this).width() != windowWidth && $(this).height() != windowheight) {
                windowWidth = $(this).width();
                windowheight = $(this).height();
                $("#divMain").css("height", windowheight);
                //$("#divMain").css("width", windowWidth);
                //$("#divMain").css("overflow", "auto");
                $("#divMain").css("overflow", "auto");

            }
        });
        $('#filterClear').click(function () {
            $('[data-bs-toggle="tooltip"]').tooltip("hide");

        });

        //Added By Dipali V On 18th Jan 2020 For When Click On filter that time unable to select option
        $(document).on('click', '.fixed-top .dropdown-menu', function (e) {
            e.stopPropagation();
        });
        //Added By Dipali V On 18th Jan 2020 For When Click On filter that time unable to select option
        //Added By Dipali V On 18th Jan 2020 For When Click On filter that time unable to select option
       
        $(".fa-close").click(function () {
            $(this).closest(".dropdown-menu").prev().dropdown("toggle");
        });

        //En dof Added By Dipali V On 18th Jan 2020 For When Click On filter that time unable to select option
       

        function centerContent() {
            var container = $('.input-box');
            var content = $('.input-box-p');
            content.css("left", (container.width() - content.width()) / 2);
            content.css("top", (container.height() - content.height()) / 2);
        }
        $(window).resize(function () {
            centerContent();
        });
        var BydafualtSprintText = "";
        var SelectedCurrentSprint = "";
        var objSprint = "";
        var SelectedCurrentid = "";


        function RefreshLoadEvents() {
            var $template = $('.inner-template');

            AddStage();
            $(".divDraggable").sortable({
                connectWith: ".divDraggable",
                helper: 'clone',
                activate: function (ev, ui) {
                    $(".tooltip").hide();
                    var largestheight = '';
                    var currentheight = '';
                    var finalheight = '';
                    $("div[id*='stage_']").each(function () {

                        var i = $(this).attr('id');

                        var height = $("#" + $(this).attr('id')).height();
                        if (largestheight == "") {
                            largestheight = height;
                        }
                        else {
                            finalheight = largestheight > height ? largestheight : height
                            largestheight = finalheight;
                        }


                    });
                    $("div[id*='stage_']").css("height", finalheight + 15);
                }
            });
            /*Tooltip*/
            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".scrum-header").tooltip();
            $(".content").tooltip();
            $(".fa-ellipsis-v").tooltip();

            /*Filter*/
            $("#myStories").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".to-do-list").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });


            /*Horizontal scroll*/
            $('.horizon-prev').on('click', function () {
                //event.preventDefault();
                $('#table').animate({
                    scrollLeft: "-=800"
                }, "slow");
            });

            $('.horizon-next').on('click', function () {
                //event.preventDefault();
                $('#table').animate({
                    scrollLeft: "+=820px"
                }, "slow");
            });
        }

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
        var SelectedCurrentid = "";
        function Release_OnChange(obj) {


            //debugger;

            var url = "frmScrumBoard.aspx/GetIterationName";
            var data = JSON.stringify({ ReleaseID: obj.value });
            var objUserStory = document.getElementById("ScrumIterations");
            var strUserResult = ajaxCall('frmScrumBoard.aspx/GetIterationName', "POST", "application/json", "json", data)
            var strSplitData = String(strUserResult.d).split("$$");
            objUserStory.innerHTML = "";
            var blankOpt = document.createElement("option");

            objUserStory.add(blankOpt);
            var value;
            for (var i = 0; i < strSplitData.length - 1; i++) {
                strOptionlist = strSplitData[i].split(",");
                var newOpt = document.createElement("option");
                newOpt.text = strOptionlist[1];
                newOpt.value = strOptionlist[0];
                objUserStory.add(newOpt);

                value = strOptionlist[0];
            }
            if ($("#ScrumReleases").val() == "") {

                objSprint = document.getElementById("ScrumIterations");
                BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text

                $(".sprintname").text(SelectedCurrentSprint);


            } else {
                $(".sprintname").html('');

            }

            if (document.getElementById("ScrumReleases").value != "" && document.getElementById("ScrumReleases").value || undefined) {
                ReleaseID = document.getElementById("ScrumReleases").value;
            }
            else {
                ReleaseID = "0";
            }

            if (document.getElementById("ScrumIterations").value != "" && document.getElementById("ScrumIterations").value || undefined) {
                IterationID = $("#ScrumIterations").val();
            }
            else {

                //SelectedCurrentid = $("#hdnIterationID").val();
            }

            var data = JSON.stringify({ ReleaseID: ReleaseID, IterationID: SelectedCurrentid });

            var objUserStory = document.getElementById("ScrumIterations");
            var strUserResult = ajaxCall('frmScrumBoard.aspx/PlotUserStories', "POST", "application/json", "json", data)

            $("#table").html("");
            $("#table").html(strUserResult.d);
            var largestheight = '';
            var currentheight = '';
            var finalheight = '';
            $("div[id*='stage_']").each(function () {

                var i = $(this).attr('id');

                var height = $("#" + $(this).attr('id')).height();
                if (largestheight == "") {
                    largestheight = height;
                }
                else {
                    finalheight = largestheight > height ? largestheight : height
                    largestheight = finalheight;
                }


            });
            $("div[id*='stage_']").css("height", finalheight + 15);


            $("#divMain").scroll(function () {
                var currentScroll = ($("#divMain").scrollTop() - 45);
                if ($("#divMain").scrollTop()) {
                    $('.scrum-content').each(function () {
                        $('.scrum-content').addClass('fixe');
                        $('.scrum-content').css("top", currentScroll);
                        // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                    });

                } else {
                    $('.scrum-content').removeClass('fixe');
                }
            });
            // centerContent();
            RefreshLoadEvents();
            RefreshGrid();

            // var strUserResult = ajaxCall('frmScrumBoard.aspx/ClearFilter', "POST", "application/json", "json", "")
            //// $("#filterClear").css("visibility", "hidden");
            // $("#divMain").html("");
            // $("#divMain").html(strUserResult.d);
            // RefreshLoadEvents();
            // RefreshGrid();


        }
        //Added By Dipali  V On 1st Aug 2018 For Issue ID 14360
        //var Entity = "";
        var SprintName = "";
        //Added By Dipali  V On 1st Aug 2018 For Issue ID 14360
        function Sprint_OnChange(obj) {
            
            var ReleaseID;
            var IterationID;
            if (obj.value != "" && obj.value || undefined) {
                IterationID = obj.value;
                $("#filterClear").css("visibility", "visible");
                 //Added by swapnagandha K. on 7/2/2019
                // $("#div1").removeClass("open");
               // $("#filter-dropdown").hide();
              //End Added by swapnagandha K. on 7/2/2019
            }
            else {
                IterationID = "0";
            }
            if (document.getElementById("ScrumReleases").value != "" && document.getElementById("ScrumReleases").value || undefined) {
                ReleaseID = document.getElementById("ScrumReleases").value;
            }
            else {
                ReleaseID = "0";
            }

            var data = JSON.stringify({ ReleaseID: ReleaseID, IterationID: IterationID });
            var objUserStory = document.getElementById("ScrumIterations");
            var strUserResult = ajaxCall('frmScrumBoard.aspx/PlotUserStories', "POST", "application/json", "json", data)

            $("#table").html("");
            $("#table").html(strUserResult.d);

            var strResult = ajaxCall('frmScrumBoard.aspx/GetEntityName', "POST", "application/json", "json", data)
            Entity = strResult.d.split("$$");
            //Commented By Dipali  V On 1st Aug 2018 For Issue ID 14360
            var Entity = Entity[0];

            //End of Commented By Dipali  V On 1st Aug 2018 For Issue ID 14360
            SprintName = Entity;
            $(".ReleaseName").html("");
            $(".ReleaseName").html("Release Name : " + Entity[1]);
            $(".SprintName").html("");
            $(".SprintName").html("Sprint Name : " + Entity[0]);
            /*Added by Yasmin On 13th July 2018*/
            $(".sprintname").html("");
            $(".sprintname").html(" " + SprintName);
            var largestheight = '';
            var currentheight = '';
            var finalheight = '';
            $("div[id*='stage_']").each(function () {

                var i = $(this).attr('id');

                var height = $("#" + $(this).attr('id')).height();
                if (largestheight == "") {
                    largestheight = height;
                }
                else {
                    finalheight = largestheight > height ? largestheight : height
                    largestheight = finalheight;
                }


            });
            $("div[id*='stage_']").css("height", finalheight + 15);


            $("#divMain").scroll(function () {
                //debugger;
                var currentScroll = ($("#divMain").scrollTop() - 45);
                if ($("#divMain").scrollTop()) {
                    $('.scrum-content').each(function () {
                        $('.scrum-content').addClass('fixe');
                        $('.scrum-content').css("top", currentScroll);
                        // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                    });

                } else {
                    $('.scrum-content').removeClass('fixe');
                }
            });


            RefreshGrid();

        }
        function RefreshGrid() {
            $(".scrum-stories-list").attr('draggable', 'true').on('dragstart.h5s', function (e) {
                //if (options.handle && !isHandle) {
                //    return false;
                //}
                //isHandle = false;
                //var dt = e.originalEvent.dataTransfer;
                //dt.effectAllowed = 'move';
                //dt.setData('Text', 'dummy');
                //index = (dragging = $(this)).addClass('sortable-dragging').index();
                //  alert();
                var largestheight = '';
                var currentheight = '';
                var finalheight = '';
                $("div[id*='stage_']").each(function () {

                    var i = $(this).attr('id');

                    var height = $("#" + $(this).attr('id')).height();
                    if (largestheight == "") {
                        largestheight = height;
                    }
                    else {
                        finalheight = largestheight > height ? largestheight : height
                        largestheight = finalheight;
                    }


                });
                $("div[id*='stage_']").css("height", finalheight + 15);
            })

            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".fa-arrows-alt").tooltip();
            $(".fa-flag").tooltip();

            $(".scrum-header").tooltip();
            //$("#filterClear").css("visibility", "visible");
            $("#myStories").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".to-do-list").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $(".divDraggable").sortable({
                connectWith: ".divDraggable",
                helper: 'clone',
                cursor: 'move',
                revert: true,
                placeholder: "sortable-placeholder",
                activate: function (ev, ui) {
                    console.log(ev);
                    console.log(ui);
                    $(".tooltip").hide();
                    var largestheight = '';
                    var currentheight = '';
                    var finalheight = '';
                    $("div[id*='stage_']").each(function () {

                        var i = $(this).attr('id');

                        var height = $("#" + $(this).attr('id')).height();
                        if (largestheight == "") {
                            largestheight = height;
                        }
                        else {
                            finalheight = largestheight > height ? largestheight : height
                            largestheight = finalheight;
                        }


                    });
                    $("div[id*='stage_']").css("height", finalheight + 15);
                }
                ,
                receive: function (event, ui) {
                    //var DropTdId = $(this).offsetParent().context.id;
                    var DropTdId = $(this).attr("id");
                    var UserStoryIDArr = [];
                    var StageID = String(DropTdId).split("_");
                    UserStoryIDArr = String(ui.item[0].id).split("_");
                    var UserStoryID = UserStoryIDArr[1];
                    var DragStageID = UserStoryIDArr[2];

                    var CurrentTdIDs = [];
                    var isCustom = $("#" + DropTdId).attr("Iscustom");
                    //Cancelled user story cannot dragged.
                    var IsCancelledUserStory = $("#" + String(ui.item[0].id)).attr("draggable");
                    if (IsCancelledUserStory.toUpperCase() == 'FALSE') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Cancelled User Story cannot be dragged.', 'error', 20);
                        $(ui.sender).sortable('cancel');
                        return;
                    }
                    //End for cancelled user story.
                    $('.divstage').each(function (index) {
                        CurrentTdIDs.push($(this).attr("id"));
                    });
                    var largestheight = '';
                    var currentheight = '';
                    var finalheight = '';
                    $("div[id*='stage_']").each(function () {

                        var i = $(this).attr('id');

                        var height = $("#" + $(this).attr('id')).height();
                        if (largestheight == "") {
                            largestheight = height;
                        }
                        else {
                            finalheight = largestheight > height ? largestheight : height
                            largestheight = finalheight;
                        }


                    });
                    $("div[id*='stage_']").css("height", finalheight + 15);

                    //if (DropTdId == CurrentTdIDs[0]) {

                    //    $(ui.sender).sortable('cancel');
                    //    // alert("User Story Cannot Drag")        
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('You cannot move the user story back to To-Do List', 'error', 20);

                    //}
                    $.ajax({
                        type: "POST",
                        url: "frmScrumBoard.aspx/ValidateLogPersonAccessUserStory",
                        data: JSON.stringify({ UserStoryID: UserStoryID }),
                        dataType: "json",
                        contentType: "application/json",
                        timeout: 180000,
                        async: false,
                        success: function (res) {

                            //if (DragStageID == 1) {
                            //    res.d = ""
                            //}
                            if (res.d != "") {
                                //var confirmResult = confirm(res.d);
                                bootbox.confirm({
                                    message: res.d,
                                    buttons: {
                                        cancel: {
                                            label: 'No',
                                            className: 'btn-danger float-end1'
                                        },
                                        confirm: {
                                            label: 'Yes',
                                            className: 'btn-success'
                                        }

                                    },
                                    callback: function (result) {

                                        if (result == true) {
                                            //if drop stage is a custom stage
                                            if (isCustom == 1) {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Custom" }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    timeout: 180000,
                                                    async: false,
                                                    success: function (result) {

                                                        if (result.d == "1") {
                                                            AfterDragRefresh();
                                                        }
                                                        else {
                                                            alertify.set('notifier', 'position', 'top-right');
                                                            alertify.notify(result.d, 'error', 20);
                                                            $(ui.sender).sortable('cancel');
                                                        }
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.log(xhr.responseText);

                                                    }
                                                });
                                            }
                                            //End of if drop stage is a custom stage
                                            //If drop stage is not a custom stage
                                            else {
                                                if (DropTdId == CurrentTdIDs[1]) {

                                                    //debugger;
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmScrumBoard.aspx/DropValidation",
                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                                        dataType: "json",
                                                        contentType: "application/json",
                                                        timeout: 180000,
                                                        async: false,
                                                        success: function (result) {

                                                            if (result.d != 0) {

                                                                bootbox.confirm({
                                                                    message: result.d,
                                                                    buttons: {
                                                                        cancel: {
                                                                            label: 'No',
                                                                            className: 'btn-danger float-end1'
                                                                        },
                                                                        confirm: {
                                                                            label: 'Yes',
                                                                            className: 'btn-success'
                                                                        }

                                                                    },
                                                                    callback: function (result) {

                                                                        if (result == true) {
                                                                            $.ajax({
                                                                                type: "POST",
                                                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                                dataType: "json",
                                                                                contentType: "application/json",
                                                                                timeout: 180000,
                                                                                async: false,
                                                                                success: function (result) {
                                                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                    if (result.d == "1") {
                                                                                        //End Added By Vaijat K ON 13/04/2017 
                                                                                        AfterDragRefresh();
                                                                                    }
                                                                                    else {
                                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                                        alertify.notify(result.d, 'error', 20);
                                                                                        $(ui.sender).sortable('cancel');
                                                                                    }
                                                                                },
                                                                                error: function (xhr, status, error) {
                                                                                    console.log(xhr.responseText);

                                                                                }
                                                                            });
                                                                        }
                                                                        else {
                                                                            $(ui.sender).sortable('cancel');
                                                                            return;
                                                                        }
                                                                    }
                                                                })
                                                            }
                                                            else {
                                                                // Update StageId
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                    dataType: "json",
                                                                    contentType: "application/json",
                                                                    timeout: 180000,
                                                                    async: false,
                                                                    success: function (result) {
                                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                        if (result.d == "1") {
                                                                            //End Added By Vaijat K ON 13/04/2017 
                                                                            AfterDragRefresh();
                                                                        }
                                                                        else {
                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                            $(ui.sender).sortable('cancel');
                                                                        }
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.log(xhr.responseText);

                                                                    }
                                                                });
                                                            }

                                                        },
                                                        error: function (xhr, status, error) {

                                                            console.log(xhr.responseText);

                                                        }
                                                    });

                                                }
                                                //For Complete Stage
                                                else if (DropTdId == CurrentTdIDs[CurrentTdIDs.length - 1]) {
                                                    //alert(DropTdId)
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmScrumBoard.aspx/DropValidation",
                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "1" }),
                                                        dataType: "json",
                                                        contentType: "application/json",
                                                        timeout: 180000,
                                                        async: false,
                                                        success: function (result) {
                                                            var arr = [];

                                                            if (String(result.d).indexOf("$$$") == -1) {
                                                                arr[0] = result.d
                                                            }
                                                            else {
                                                                arr = String(result.d).split("$$$")
                                                            }
                                                            if (arr[1] == 2) {

                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(arr[0], 'error', 20);
                                                                $(ui.sender).sortable('cancel');
                                                                return;
                                                            }
                                                            if (arr[1] == "1") {
                                                                if (arr[0] != "") {

                                                                    bootbox.confirm({
                                                                        message: arr[0],
                                                                        buttons: {
                                                                            cancel: {
                                                                                label: 'No',
                                                                                className: 'btn-danger float-end1'
                                                                            },
                                                                            confirm: {
                                                                                label: 'Yes',
                                                                                className: 'btn-success'
                                                                            }

                                                                        },
                                                                        callback: function (result) {

                                                                            if (result == true) {
                                                                                $.ajax({
                                                                                    type: "POST",
                                                                                    url: "frmScrumBoard.aspx/DropValidation",
                                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "0" }),
                                                                                    dataType: "json",
                                                                                    contentType: "application/json",
                                                                                    timeout: 180000,
                                                                                    async: false,
                                                                                    success: function (result) {
                                                                                        if (result.d != 0) {

                                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                                            alertify.notify(result.d, 'error', 20);
                                                                                            $(ui.sender).sortable('cancel');
                                                                                        }
                                                                                        else {
                                                                                            // Update StageId

                                                                                            $.ajax({
                                                                                                type: "POST",
                                                                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                                                dataType: "json",
                                                                                                contentType: "application/json",
                                                                                                timeout: 180000,
                                                                                                async: false,
                                                                                                success: function (result) {
                                                                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                                    if (result.d == "1") {
                                                                                                        //End Added By Vaijat K ON 13/04/2017 
                                                                                                        AfterDragRefresh();
                                                                                                    }
                                                                                                    else {
                                                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                                                        alertify.notify(result.d, 'error', 20);
                                                                                                        $(ui.sender).sortable('cancel');
                                                                                                    }
                                                                                                },
                                                                                                error: function (xhr, status, error) {
                                                                                                    console.log(xhr.responseText);

                                                                                                }
                                                                                            });
                                                                                        }
                                                                                    }
                                                                                });

                                                                            }
                                                                            else {

                                                                                if (result.d != undefined) {
                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify(result.d, 'error', 20);
                                                                                }
                                                                                $(ui.sender).sortable('cancel');
                                                                            }
                                                                        }
                                                                    });
                                                                }
                                                            }
                                                            else {
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmScrumBoard.aspx/DropValidation",
                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "0" }),
                                                                    dataType: "json",
                                                                    contentType: "application/json",
                                                                    timeout: 180000,
                                                                    async: false,
                                                                    success: function (result) {
                                                                        if (result.d != 0) {

                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                            $(ui.sender).sortable('cancel');
                                                                        }
                                                                        else {
                                                                            // Update StageId

                                                                            $.ajax({
                                                                                type: "POST",
                                                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                                dataType: "json",
                                                                                contentType: "application/json",
                                                                                timeout: 180000,
                                                                                async: false,
                                                                                success: function (result) {
                                                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                    if (result.d == "1") {
                                                                                        //End Added By Vaijat K ON 13/04/2017 
                                                                                        AfterDragRefresh();
                                                                                    }
                                                                                    else {
                                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                                        alertify.notify(result.d, 'error', 20);
                                                                                        $(ui.sender).sortable('cancel');
                                                                                    }
                                                                                },
                                                                                error: function (xhr, status, error) {
                                                                                    console.log(xhr.responseText);

                                                                                }
                                                                            });
                                                                        }
                                                                    }
                                                                });
                                                            }


                                                        },
                                                        error: function (xhr, status, error) {

                                                            console.log(xhr.responseText);

                                                        }
                                                    });
                                                }
                                                //End for Complete stage
                                                else if (DropTdId == CurrentTdIDs[0]) {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                        dataType: "json",
                                                        contentType: "application/json",
                                                        timeout: 180000,
                                                        async: true,
                                                        success: function (result) {

                                                            if (result.d == "1") {
                                                                AfterDragRefresh();

                                                            }
                                                            else {
                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(result.d, 'error', 20);
                                                                //   alert();
                                                                return;
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.log(xhr.responseText);

                                                        }
                                                    });
                                                }
                                            }
                                            //End if drop is not a custom stage

                                        }
                                        else {
                                            $(ui.sender).sortable('cancel');
                                            return;
                                        }
                                    }
                                })
                            }///////
                            else {
                                if (isCustom == 1) {
                                    $.ajax({
                                        type: "POST",
                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Custom" }),
                                        dataType: "json",
                                        contentType: "application/json",
                                        timeout: 180000,
                                        async: false,
                                        success: function (result) {

                                            if (result.d == "1") {
                                                AfterDragRefresh();
                                            }
                                            else {
                                                alertify.set('notifier', 'position', 'top-right');
                                                alertify.notify(result.d, 'error', 20);
                                                $(ui.sender).sortable('cancel');
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            console.log(xhr.responseText);

                                        }
                                    });
                                }
                                else {
                                    if (DropTdId == CurrentTdIDs[1]) {

                                        //debugger;
                                        $.ajax({
                                            type: "POST",
                                            url: "frmScrumBoard.aspx/DropValidation",
                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                            dataType: "json",
                                            contentType: "application/json",
                                            timeout: 180000,
                                            async: false,
                                            success: function (result) {

                                                if (result.d != 0) {

                                                    bootbox.confirm({
                                                        message: result.d,
                                                        buttons: {
                                                            cancel: {
                                                                label: 'No',
                                                                className: 'btn-danger float-end1'
                                                            },
                                                            confirm: {
                                                                label: 'Yes',
                                                                className: 'btn-success'
                                                            }

                                                        },
                                                        callback: function (result) {

                                                            if (result == true) {
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                    dataType: "json",
                                                                    contentType: "application/json",
                                                                    timeout: 180000,
                                                                    async: false,
                                                                    success: function (result) {
                                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                        if (result.d == "1") {
                                                                            //End Added By Vaijat K ON 13/04/2017 
                                                                            AfterDragRefresh();
                                                                        }
                                                                        else {
                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                            $(ui.sender).sortable('cancel');
                                                                        }
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.log(xhr.responseText);

                                                                    }
                                                                });
                                                            }
                                                            else {
                                                                $(ui.sender).sortable('cancel');
                                                                return;
                                                            }
                                                        }
                                                    })
                                                }
                                                else {
                                                    // Update StageId
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                        dataType: "json",
                                                        contentType: "application/json",
                                                        timeout: 180000,
                                                        async: false,
                                                        success: function (result) {
                                                            //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                            if (result.d == "1") {
                                                                //End Added By Vaijat K ON 13/04/2017 
                                                                AfterDragRefresh();
                                                            }
                                                            else {
                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(result.d, 'error', 20);
                                                                $(ui.sender).sortable('cancel');
                                                            }
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.log(xhr.responseText);

                                                        }
                                                    });
                                                }

                                            },
                                            error: function (xhr, status, error) {

                                                console.log(xhr.responseText);

                                            }
                                        });

                                    }
                                    //For Complete Stage
                                    else if (DropTdId == CurrentTdIDs[CurrentTdIDs.length - 1]) {
                                        //alert(DropTdId)
                                        $.ajax({
                                            type: "POST",
                                            url: "frmScrumBoard.aspx/DropValidation",
                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "1" }),
                                            dataType: "json",
                                            contentType: "application/json",
                                            timeout: 180000,
                                            async: false,
                                            success: function (result) {
                                                var arr = [];

                                                if (String(result.d).indexOf("$$$") == -1) {
                                                    arr[0] = result.d
                                                }
                                                else {
                                                    arr = String(result.d).split("$$$")
                                                }
                                                if (arr[1] == 2) {

                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify(arr[0], 'error', 20);
                                                    $(ui.sender).sortable('cancel');
                                                    return;
                                                }
                                                if (arr[1] == "1") {
                                                    if (arr[0] != "") {

                                                        bootbox.confirm({
                                                            message: arr[0],
                                                            buttons: {
                                                                cancel: {
                                                                    label: 'No',
                                                                    className: 'btn-danger float-end1'
                                                                },
                                                                confirm: {
                                                                    label: 'Yes',
                                                                    className: 'btn-success'
                                                                }

                                                            },
                                                            callback: function (result) {

                                                                if (result == true) {
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmScrumBoard.aspx/DropValidation",
                                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "0" }),
                                                                        dataType: "json",
                                                                        contentType: "application/json",
                                                                        timeout: 180000,
                                                                        async: false,
                                                                        success: function (result) {
                                                                            if (result.d != 0) {

                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify(result.d, 'error', 20);
                                                                                $(ui.sender).sortable('cancel');
                                                                            }
                                                                            else {
                                                                                // Update StageId

                                                                                $.ajax({
                                                                                    type: "POST",
                                                                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                                    dataType: "json",
                                                                                    contentType: "application/json",
                                                                                    timeout: 180000,
                                                                                    async: false,
                                                                                    success: function (result) {
                                                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                        if (result.d == "1") {
                                                                                            //End Added By Vaijat K ON 13/04/2017 
                                                                                            AfterDragRefresh();
                                                                                        }
                                                                                        else {
                                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                                            alertify.notify(result.d, 'error', 20);
                                                                                            $(ui.sender).sortable('cancel');
                                                                                        }
                                                                                    },
                                                                                    error: function (xhr, status, error) {
                                                                                        console.log(xhr.responseText);

                                                                                    }
                                                                                });
                                                                            }
                                                                        }
                                                                    });

                                                                }
                                                                else {

                                                                    if (result.d != undefined) {
                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                        alertify.notify(result.d, 'error', 20);
                                                                    }
                                                                    $(ui.sender).sortable('cancel');
                                                                }
                                                            }
                                                        });
                                                    }
                                                }
                                                else {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmScrumBoard.aspx/DropValidation",
                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "Completed", IssueOpenFlag: "0" }),
                                                        dataType: "json",
                                                        contentType: "application/json",
                                                        timeout: 180000,
                                                        async: false,
                                                        success: function (result) {
                                                            if (result.d != 0) {

                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(result.d, 'error', 20);
                                                                $(ui.sender).sortable('cancel');
                                                            }
                                                            else {
                                                                // Update StageId

                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                                                    dataType: "json",
                                                                    contentType: "application/json",
                                                                    timeout: 180000,
                                                                    async: false,
                                                                    success: function (result) {
                                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                        if (result.d == "1") {
                                                                            //End Added By Vaijat K ON 13/04/2017 
                                                                            AfterDragRefresh();
                                                                        }
                                                                        else {
                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                            $(ui.sender).sortable('cancel');
                                                                        }
                                                                    },
                                                                    error: function (xhr, status, error) {
                                                                        console.log(xhr.responseText);

                                                                    }
                                                                });
                                                            }
                                                        }
                                                    });
                                                }


                                            },
                                            error: function (xhr, status, error) {

                                                console.log(xhr.responseText);

                                            }
                                        });
                                    }
                                    //End for Complete stage
                                    else if (DropTdId == CurrentTdIDs[0]) {
                                        $.ajax({
                                            type: "POST",
                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID[1], Mode: "InProgress" }),
                                            dataType: "json",
                                            contentType: "application/json",
                                            timeout: 180000,
                                            async: true,
                                            success: function (result) {

                                                if (result.d == "1") {

                                                    AfterDragRefresh();
                                                }
                                                else {
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify(result.d, 'error', 20);
                                                    //   alert();
                                                    return;
                                                }
                                            },
                                            error: function (xhr, status, error) {
                                                console.log(xhr.responseText);

                                            }
                                        });
                                    }
                                }
                            }
                        }
                    })

                }

                , cancel: ".nodrop",
            }).disableSelection();
        }

        function AddNewStage_Onclick() {
            //if (!($("#CloseID").click())) {
            //    alert("1");
            var strStagename;
            var stractivityposition;
            var strstagebackgroundcolor;
            var stractivityicon;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "";

            strStagename = $("#txtNewStage").val();
            stractivityposition = $("#activityposition").val();
            strstagebackgroundcolor = $("#stagebackgroundcolor").val();
            stractivityicon = $("#activityicon").val();

            if (strStagename == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Stage Name should not be left blank.", 'error', 15);
                return;
            }
            if (strStagename != "") {
                if ($("[iscustom='1']").length >= 5) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Maximum limit for custom stage is 5", 'error', 15);
                    return;
                }
                if (strStagename.length > 50) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Maximum character's limit is 50 you have entered " + strStagename.length + " character's", 'error', 15);
                    return;
                }
                var strUserResult = ajaxCall('frmScrumBoard.aspx/IsStageNameExists', "POST", "application/json", "json", JSON.stringify({ StageName: strStagename, StageID: "" }))
                if (strUserResult.d != "") {
                    strmsg = '- ' + strUserResult.d;
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    //alertify.notify('', 'error');
                    if (strmsg != "") {

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 15);
                        return;

                    }
                    return
                }

                //if (stractivityposition == "") {
                //    strmsg = ' - Please enter the position for custom stage';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    //alertify.notify('', 'error');
                //    checkvalue = 1;
                //}
                //else if (RestrictNonNumeric($("#activityposition"))) {

                //    strmsg = ' - Please enter the numeric value for custom stage position';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    //alertify.notify('', 'error');
                //    checkvalue = 1;
                //}
                //else if (parseInt(stractivityposition) < 3 || parseInt(stractivityposition) > 99) {
                //    strmsg = ' - Please enter the position between 3 - 99';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    //alertify.notify('', 'error');
                //    checkvalue = 1;
                //}

                //if (stractivityicon == "0") {
                //    strmsg = ' - Please select the icon for custom stage.';
                //    errorMsg += "<li>" + strmsg + "</li></br>";
                //    //alertify.notify('', 'error');
                //    checkvalue = 1;
                //}


                var data = JSON.stringify({ StageID: "", StageName: strStagename, stageposition: "", stagebackgroundcolor: "", stageicon: "" });
                var strUserResult = ajaxCall('frmScrumBoard.aspx/AddStage', "POST", "application/json", "json", data)
                if (strUserResult.d == '1') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Stage added successfully", 'success', 15);
                    $("#openpopup .close").click()
                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                    $(".sprintname").html("");

                    $(".sprintname").html(" " + SprintName);
                    $("#add-btn").bind("click");
                    $("#add-btn").css("cursor", "pointer");
                    AddStage();
                }
            }
        }
        //else {
        //    alert('2');

        //}
        // }
        function AddStage() {
            $('#add-btn').on('click', function () {
                if ($('#add-btn').is(':disabled')) {
                    //textbox is disabled
                }
                else {

                    $('.inner').each(function () {



                    });
                    var currentID = $('#table .inner').length + 1;
                    var inner = $('<div class="inner"><div class="col-lg-12 col-md-12 col-sm-12"><div class="scrum-grid" ><div class="scrum-title collapse fade in"><i id="CloseID" class="fas fa-times close-stage" onClick="CloseNewStage()"></i><i class="fa fa-image icon" aria-hidden="true"></i><div><p class="drag-text"><i class="far fa-hand-point-up drag-handler" aria-hidden="true"></i>Drag task between list</p></div></div><div class="scrum-content"><center><div class="input-box" style="background-color:transparent"><input type="text" id="txtNewStage" style="" class="input-box-p"  onfocusout="AddNewStage_Onclick()" placeholder="Enter Stage Name"/></div></center><h5></h5></div><div id="connected"><div class="list divDraggable" ></div></div></div></div></div>')
                        .clone()
                        .removeClass('inner-template')
                        .attr('id', 'innder-' + currentID)
                        .text(inner)
                        .appendTo('#table');
                    $('#innder-' + currentID).insertBefore("#innder-3");
                    $('#innder-' + currentID).i

                    $("#txtNewStage").focus();
                    setTimeout(function () {
                        $('#innder-' + currentID).addClass('highlight');
                    });

                    setTimeout(function () {
                        $('#innder-' + currentID).removeClass('highlight');
                    }, 3000);


                    $(".arrow-to-display").css("cursor", "pointer");
                    $(".divDraggable [draggable='true']").sortable({
                        connectWith: ".divDraggable",
                        helper: 'clone',
                        activate: function (ev, ui) {
                            var largestheight = '';
                            var currentheight = '';
                            var finalheight = '';
                            $("div[id*='stage_']").each(function () {

                                var i = $(this).attr('id');

                                var height = $("#" + $(this).attr('id')).height();
                                if (largestheight == "") {
                                    largestheight = height;
                                }
                                else {
                                    finalheight = largestheight > height ? largestheight : height
                                    largestheight = finalheight;
                                }


                            });
                            $("div[id*='stage_']").css("height", finalheight + 15);
                        }
                    });

                    $("#add-btn").unbind("click");
                    $("#add-btn").css("cursor", "not-allowed");
                }
            });
        }
        function Edit_Stage(stageID) {
            var strUserResult = ajaxCall('frmScrumBoard.aspx/ShowEditStage', "POST", "application/json", "json", JSON.stringify({ StageID: stageID }))
            if (strUserResult.d != "") {
                $("#divEditStage").html();
                $("#divEditStage").html(strUserResult.d);
                $("#openEditpopup").modal('show');
                $('[data-bs-toggle="tooltip"]').tooltip();
            }


        }
        var SelectedPreStageColor = "";
        function Save_Stage(StageID) {
            //  debugger;
            var stractivityname;
            var stractivityposition;
            var strstagebackgroundcolor;
            var stractivityicon;
            var checkvalue = 0;
            var strmsg = "";
            var errorMsg = "";

            strStageName = $("#activityname").val();
            strStageposition = $("#activityposition").val();
            strstagebackgroundcolor = $("#stagebackgroundcolor").val();
            //Added by Dipali V On 5th June 2018 for Color Change Issues


            if (strstagebackgroundcolor == "") {
                strstagebackgroundcolor = SelectedPreStageColor;

            }
            else {
                strstagebackgroundcolor = strstagebackgroundcolor;

            }
            //End of Added by Dipali V On 5th June 2018 for Color Change Issues
            // alert(SelectedPreStageColor);
            if (document.getElementById("activityicon").value.toUpperCase() == 'OTHERS') {

                strStageicon = $("#txtactivityicon").val();
            }
            else {
                strStageicon = $("#activityicon").val();
            }

            if (strStageName == "") {
                strmsg = ' - Please enter custom stage name.';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }
            else {
                var strUserResult = ajaxCall('frmScrumBoard.aspx/IsStageNameExists', "POST", "application/json", "json", JSON.stringify({ StageName: strStageName, StageID: StageID }))
                if (strUserResult.d != "") {
                    strmsg = '- ' + strUserResult.d;
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
                if (strStageName.length > 50) {

                    strmsg = "Maximum character's limit is 50 you have entered " + strStageName.length + " character's"
                    errorMsg += '<li>' + strmsg + '</li>';
                    //alertify.notify('', 'error');
                    checkvalue = 1;
                }
            }
            if (strStageposition == "") {
                strmsg = ' - Please enter the position for custom stage';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }
            else if (RestrictNonNumeric($("#activityposition"))) {

                strmsg = ' - Please enter the numeric value for custom stage position';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }
            else if (parseInt(strStageposition) < 3 || parseInt(strStageposition) > 99) {
                strmsg = ' - Please enter the position between 3 - 99';
                errorMsg += "<li>" + strmsg + "</li>";
                //alertify.notify('', 'error');
                checkvalue = 1;
            }

            //if (strStageicon == "") {
            //    strmsg = ' - Please select the icon for custom stage.';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    alertify.notify('', 'error');
            //    checkvalue = 1;
            //}
            if (checkvalue == 1) {
                if (strmsg != "") {

                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("<ul>" + errorMsg + "</ul>", 'error', 15);
                    return;

                }
            }

            var data = JSON.stringify({ StageID: StageID, StageName: strStageName, stageposition: strStageposition, stagebackgroundcolor: strstagebackgroundcolor, stageicon: strStageicon });
            var strUserResult = ajaxCall('frmScrumBoard.aspx/AddStage', "POST", "application/json", "json", data)
            if (strUserResult.d == '1') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Stage details updated successfully", 'success', 15);
                $("#openEditpopup .close").click()
                Sprint_OnChange(document.getElementById("ScrumIterations"));
                $(".sprintname").html("");
                $(".sprintname").html(" " + SprintName);
                SelectedPreStageColor = strstagebackgroundcolor;
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
        function Open_DragPopUp(UserStoryID, StageID, IsCustom) {
            var data = JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, IsCustom: IsCustom });
            var strUserResult = ajaxCall('frmScrumBoard.aspx/PlotDragDrop', "POST", "application/json", "json", data)
            if (strUserResult.d != '') {
                $("#DragDropBody").html();
                $("#DragDropBody").html(strUserResult.d);
                $("#DragDropModal").modal('show');
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
        }
        function Delete_Stage(StageID) {
            var data = JSON.stringify({ StageID: StageID });
            var strUserResult = ajaxCall('frmScrumBoard.aspx/DeleteStage', "POST", "application/json", "json", data)
            if (strUserResult.d != '') {
                alertify.set('notifier', 'position', 'top-right');

                if (strUserResult.d.indexOf("success") > -1)
                    alertify.notify(strUserResult.d, 'success', 15);
                else
                    alertify.notify(strUserResult.d, 'error', 15);

                Sprint_OnChange(document.getElementById("ScrumIterations"));
                $(".sprintname").html("");
                $(".sprintname").html(" " + SprintName);
                $("#add-btn").bind("click");
                $("#add-btn").css("cursor", "pointer");
                AddStage();
            }
        }
        function CloseNewStage() {

            Sprint_OnChange(document.getElementById("ScrumIterations"));
            $(".sprintname").html("");
            $(".sprintname").html(" " + SprintName);
            $("#add-btn").bind("click");
            $("#add-btn").css("cursor", "pointer");

            if ($("#txtNewStage").val() == "undefined") {

            }
            else {
                AddStage();
            }
        }
        function ClearFilter(obj) {
            
            var strUserResult = ajaxCall('frmScrumBoard.aspx/ClearFilter', "POST", "application/json", "json", "")
            $("#filterClear").css("visibility", "hidden");
            $("#divMain").html("");
            $("#divMain").html(strUserResult.d);
            var largestheight = '';
            var currentheight = '';
            var finalheight = '';
            $("div[id*='stage_']").each(function () {

                var i = $(this).attr('id');

                var height = $("#" + $(this).attr('id')).height();
                if (largestheight == "") {
                    largestheight = height;
                }
                else {
                    finalheight = largestheight > height ? largestheight : height
                    largestheight = finalheight;
                }


            });
            $("div[id*='stage_']").css("height", finalheight + 15);
            RefreshLoadEvents();
            RefreshGrid();
            $('.tooltip ').removeClass("in");


        }
        function DragDrop_Onclick(UserStoryID, DragID, isCustom) {
          
            var UserStoryIDArr = [];
            var StageID = $("#ScrumStages").val();
            var UserStoryID = UserStoryID;
            var DragStageID = DragID;
            var DropTdId = "stage_" + StageID;
            var CurrentTdIDs = [];
            var intFlag = 0;

            if (StageID == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please select the stage to drop", 'error', 20);
                return;
            }
            $('.divstage').each(function (index) {
                CurrentTdIDs.push($(this).attr("id"));
            });
            //Check whether moving to custom stage
            if (StageID == '1' || StageID == '2' || StageID == '3') {
                isCustom = 0;
            }
            else {
                isCustom = 1;
            }
            //Added by swapnagandha K. On 25-6-2019
            if ($("#sortable_" + UserStoryID + "_" + DragStageID).attr("draggable") == "false") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Cancelled User Story cannot be dragged.', 'error', 20);
                return;
            }
          //End by swapnagandha K. On 25-6-2019
            //End for custom stage
            //if (DropTdId == CurrentTdIDs[0]) {

            //    $(ui.sender).sortable('cancel');
            //    // alert("User Story Cannot Drag")        
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('You cannot move the user story back to To-Do List', 'error', 20);

            //}
             
            $.ajax({
                type: "POST",
                url: "frmScrumBoard.aspx/ValidateLogPersonAccessUserStory",
                data: JSON.stringify({ UserStoryID: UserStoryID }),
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: true,
                success: function (res) {

                    //if (DragStageID == 1) {
                    //    res.d = ""
                    //}
                  
                    if (res.d != "") {
                        //var confirmResult = confirm(res.d);
                        bootbox.confirm({
                            message: res.d,
                            buttons: {
                                cancel: {
                                    label: 'No',
                                    className: 'btn-danger float-end1'
                                },
                                confirm: {
                                    label: 'Yes',
                                    className: 'btn-success'
                                }

                            },
                            callback: function (result) {

                                if (result == true) {
                                    //if drop stage is a custom stage
                                    if (isCustom == 1) {
                                        $.ajax({
                                            type: "POST",
                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Custom" }),
                                            dataType: "json",
                                            contentType: "application/json",
                                            timeout: 180000,
                                            async: true,
                                            success: function (result) {
                                               
                                                if (result.d == "1") {
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify("Stage Moved successfully", 'success', 20);
                                                    $("#DragDropModal .close").click();
                                                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                    //Added by swapnagandha K. On 25-6-2019
                                                    $("#filterClear").css("visibility", "hidden");
                                                      //End by swapnagandha K. On 25-6-2019
                                                    $(".sprintname").html("");
                                                    $(".sprintname").html(" " + SprintName);
                                                }
                                                else {
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify(result.d, 'error', 20);
                                                    return;
                                                }
                                            },
                                            error: function (xhr, status, error) {
                                                console.log(xhr.responseText);

                                            }
                                        });
                                    }
                                    //End of if drop stage is a custom stage
                                    //If drop stage is not a custom stage
                                    else {
                                        if (DropTdId == CurrentTdIDs[1]) {


                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {

                                                    if (result.d != 0) {

                                                        bootbox.confirm({
                                                            message: result.d,
                                                            buttons: {
                                                                cancel: {
                                                                    label: 'No',
                                                                    className: 'btn-danger float-end1'
                                                                },
                                                                confirm: {
                                                                    label: 'Yes',
                                                                    className: 'btn-success'
                                                                }

                                                            },
                                                            callback: function (result) {

                                                                if (result == true) {
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                                        dataType: "json",
                                                                        contentType: "application/json",
                                                                        timeout: 180000,
                                                                        async: true,
                                                                        success: function (result) {
                                                                            //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                            if (result.d == "1") {
                                                                                //End Added By Vaijat K ON 13/04/2017 
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify("Stage Moved successfully", 'success', 20);
                                                                                $("#DragDropModal .close").click();
                                                                                Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                 $("#filterClear").css("visibility", "hidden");
                                                                                $(".sprintname").html("");
                                                                                $(".sprintname").html(" " + SprintName);
                                                                            }
                                                                            else {
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify(result.d, 'error', 20);
                                                                                return;
                                                                            }
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);

                                                                        }
                                                                    });
                                                                }
                                                                else {

                                                                    return;
                                                                }
                                                            }
                                                        })
                                                    }
                                                    else {
                                                        // Update StageId
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {

                                                                if (result.d == "1") {

                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("Stage Moved successfully", 'success', 20);
                                                                    $("#DragDropModal .close").click();
                                                                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                     $("#filterClear").css("visibility", "hidden");
                                                                    $(".sprintname").html("");
                                                                    $(".sprintname").html(" " + SprintName);
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    //  alert();
                                                                    return;
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }

                                                },
                                                error: function (xhr, status, error) {

                                                    console.log(xhr.responseText);

                                                }
                                            });

                                        }
                                        //For Complete Stage
                                        else if (DropTdId == CurrentTdIDs[CurrentTdIDs.length - 1]) {
                                            //alert(DropTdId)
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "1" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {
                                                    var arr = [];

                                                    if (String(result.d).indexOf("$$$") == -1) {
                                                        arr[0] = result.d
                                                    }
                                                    else {
                                                        arr = String(result.d).split("$$$")
                                                    }
                                                    if (arr[1] == 2) {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(arr[0], 'error', 20);
                                                        $(ui.sender).sortable('cancel');
                                                        return;
                                                    }
                                                    if (arr[1] == "1") {
                                                        if (arr[0] != "") {

                                                            bootbox.confirm({
                                                                message: arr[0],
                                                                buttons: {
                                                                    cancel: {
                                                                        label: 'No',
                                                                        className: 'btn-danger float-end1'
                                                                    },
                                                                    confirm: {
                                                                        label: 'Yes',
                                                                        className: 'btn-success'
                                                                    }

                                                                },
                                                                callback: function (result) {

                                                                    if (result == true) {
                                                                        $.ajax({
                                                                            type: "POST",
                                                                            url: "frmScrumBoard.aspx/DropValidation",
                                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            timeout: 180000,
                                                                            async: true,
                                                                            success: function (result) {
                                                                                if (result.d != 0) {

                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify(result.d, 'error', 20);
                                                                                    return;
                                                                                }
                                                                                else {
                                                                                    // Update StageId

                                                                                    $.ajax({
                                                                                        type: "POST",
                                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                                                        dataType: "json",
                                                                                        contentType: "application/json",
                                                                                        timeout: 180000,
                                                                                        async: true,
                                                                                        success: function (result) {

                                                                                            if (result.d == "1") {
                                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                                alertify.notify("Stage Moved successfully", 'success', 20);
                                                                                                $("#DragDropModal .close").click();
                                                                                                Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                                 $("#filterClear").css("visibility", "hidden");
                                                                                                $(".sprintname").html("");
                                                                                                $(".sprintname").html(" " + SprintName);
                                                                                            }
                                                                                            else {
                                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                                alertify.notify(result.d, 'error', 20);
                                                                                                return;
                                                                                            }
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.log(xhr.responseText);

                                                                                        }
                                                                                    });
                                                                                }
                                                                            }
                                                                        });

                                                                    }
                                                                    else {

                                                                        if (result.d != undefined) {
                                                                            alertify.set('notifier', 'position', 'top-right');
                                                                            alertify.notify(result.d, 'error', 20);
                                                                        }

                                                                    }
                                                                }
                                                            });
                                                        }
                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/DropValidation",
                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {
                                                                if (result.d != 0) {

                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    return;
                                                                }
                                                                else {
                                                                    // Update StageId

                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmScrumBoard.aspx/UpdateStageID",
                                                                        data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                                        dataType: "json",
                                                                        contentType: "application/json",
                                                                        timeout: 180000,
                                                                        async: true,
                                                                        success: function (result) {


                                                                            if (result.d == "1") {

                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify("Stage Moved successfully", 'success', 20);
                                                                                $("#DragDropModal .close").click();
                                                                                Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                 $("#filterClear").css("visibility", "hidden");
                                                                                $(".sprintname").html("");
                                                                                $(".sprintname").html(" " + SprintName);
                                                                            }
                                                                            else {
                                                                                alertify.set('notifier', 'position', 'top-right');
                                                                                alertify.notify(result.d, 'error', 20);
                                                                                return;
                                                                            }
                                                                        },
                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);

                                                                        }
                                                                    });
                                                                }
                                                            }
                                                        });
                                                    }


                                                },
                                                error: function (xhr, status, error) {

                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }
                                        //End for Complete stage
                                        //When Drop to othe stage than inprogress and Complete  
                                        else if (DropTdId == CurrentTdIDs[0]) {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {

                                                    if (result.d == "1") {
                                                      
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify("Stage Moved successfully", 'success', 20);
                                                        $("#DragDropModal .close").click();
                                                        Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                           $("#filterClear").css("visibility", "hidden");
                                                        $(".sprintname").html("");
                                                        $(".sprintname").html(" " + SprintName);
                                                    }
                                                    else {
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                        //alert();
                                                        return;
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }
                                    }
                                    //End if drop is not a custom stage

                                }
                                else {

                                    return;
                                }
                            }
                        })
                    }///////
                    else {

                        if (isCustom == 1) {
                            $.ajax({
                                type: "POST",
                                url: "frmScrumBoard.aspx/UpdateStageID",
                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Custom" }),
                                dataType: "json",
                                contentType: "application/json",
                                timeout: 180000,
                                async: true,
                                success: function (result) {

                                    if (result.d == "1") {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify("Stage Moved successfully", 'success', 20);
                                        $("#DragDropModal .close").click();
                                        Sprint_OnChange(document.getElementById("ScrumIterations"));
                                         $("#filterClear").css("visibility", "hidden");
                                        $(".sprintname").html("");
                                        $(".sprintname").html(" " + SprintName);
                                    }
                                    else {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify(result.d, 'error', 20);
                                        return;
                                    }
                                },
                                error: function (xhr, status, error) {
                                    console.log(xhr.responseText);

                                }
                            });
                        }
                        //End of if drop stage is a custom stage
                        //If drop stage is not a custom stage
                        else {
                            if (DropTdId == CurrentTdIDs[1]) {


                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/DropValidation",
                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: "", Mode: "InProgress", IssueOpenFlag: "0" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: true,
                                    success: function (result) {

                                        if (result.d != 0) {

                                            bootbox.confirm({
                                                message: result.d,
                                                buttons: {
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-danger float-end1'
                                                    },
                                                    confirm: {
                                                        label: 'Yes',
                                                        className: 'btn-success'
                                                    }

                                                },
                                                callback: function (result) {

                                                    if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {
                                                                //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                if (result.d == "1") {
                                                                    //End Added By Vaijat K ON 13/04/2017 
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("Stage Moved successfully", 'success', 20);
                                                                    $("#DragDropModal .close").click();
                                                                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                     $("#filterClear").css("visibility", "hidden");
                                                                    $(".sprintname").html("");
                                                                    $(".sprintname").html(" " + SprintName);
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    return;
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }
                                                    else {

                                                        return;
                                                    }
                                                }
                                            })
                                        }
                                        else {
                                            // Update StageId
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/UpdateStageID",
                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {

                                                    if (result.d == "1") {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify("Stage Moved successfully", 'success', 20);
                                                        $("#DragDropModal .close").click();
                                                        Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                         $("#filterClear").css("visibility", "hidden");
                                                        $(".sprintname").html("");
                                                        $(".sprintname").html(" " + SprintName);
                                                    }
                                                    else {
                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                        //alert();
                                                        return;
                                                    }
                                                },
                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);

                                                }
                                            });
                                        }

                                    },
                                    error: function (xhr, status, error) {

                                        console.log(xhr.responseText);

                                    }
                                });

                            }
                            //For Complete Stage
                            else if (DropTdId == CurrentTdIDs[CurrentTdIDs.length - 1]) {
                                //alert(DropTdId)
                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/DropValidation",
                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "1" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: true,
                                    success: function (result) {
                                        var arr = [];

                                        if (String(result.d).indexOf("$$$") == -1) {
                                            arr[0] = result.d
                                        }
                                        else {
                                            arr = String(result.d).split("$$$")
                                        }
                                        if (arr[1] == 2) {

                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify(arr[0], 'error', 20);
                                            $(ui.sender).sortable('cancel');
                                            return;
                                        }
                                        if (arr[1] == "1") {
                                            if (arr[0] != "") {

                                                bootbox.confirm({
                                                    message: arr[0],
                                                    buttons: {
                                                        cancel: {
                                                            label: 'No',
                                                            className: 'btn-danger float-end1'
                                                        },
                                                        confirm: {
                                                            label: 'Yes',
                                                            className: 'btn-success'
                                                        }

                                                    },
                                                    callback: function (result) {

                                                        if (result == true) {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "frmScrumBoard.aspx/DropValidation",
                                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                timeout: 180000,
                                                                async: true,
                                                                success: function (result) {
                                                                    if (result.d != 0) {

                                                                        alertify.set('notifier', 'position', 'top-right');
                                                                        alertify.notify(result.d, 'error', 20);
                                                                        return;
                                                                    }
                                                                    else {
                                                                        // Update StageId

                                                                        $.ajax({
                                                                            type: "POST",
                                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            timeout: 180000,
                                                                            async: true,
                                                                            success: function (result) {

                                                                                if (result.d == "1") {
                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify("Stage Moved successfully", 'success', 20);
                                                                                    $("#DragDropModal .close").click();
                                                                                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                                     $("#filterClear").css("visibility", "hidden");
                                                                                    $(".sprintname").html("");
                                                                                    $(".sprintname").html(" " + SprintName);
                                                                                }
                                                                                else {
                                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                                    alertify.notify(result.d, 'error', 20);
                                                                                    return;
                                                                                }
                                                                            },
                                                                            error: function (xhr, status, error) {
                                                                                console.log(xhr.responseText);

                                                                            }
                                                                        });
                                                                    }
                                                                }
                                                            });

                                                        }
                                                        else {

                                                            if (result.d != undefined) {
                                                                alertify.set('notifier', 'position', 'top-right');
                                                                alertify.notify(result.d, 'error', 20);
                                                            }

                                                        }
                                                    }
                                                });
                                            }
                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmScrumBoard.aspx/DropValidation",
                                                data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "Completed", IssueOpenFlag: "0" }),
                                                dataType: "json",
                                                contentType: "application/json",
                                                timeout: 180000,
                                                async: true,
                                                success: function (result) {
                                                    if (result.d != 0) {

                                                        alertify.set('notifier', 'position', 'top-right');
                                                        alertify.notify(result.d, 'error', 20);
                                                        return;
                                                    }
                                                    else {
                                                        // Update StageId

                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmScrumBoard.aspx/UpdateStageID",
                                                            data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                                            dataType: "json",
                                                            contentType: "application/json",
                                                            timeout: 180000,
                                                            async: true,
                                                            success: function (result) {


                                                                if (result.d == "1") {

                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify("Stage Moved successfully", 'success', 20);
                                                                    $("#DragDropModal .close").click();
                                                                    Sprint_OnChange(document.getElementById("ScrumIterations"));
                                                                     $("#filterClear").css("visibility", "hidden");
                                                                    $(".sprintname").html("");
                                                                    $(".sprintname").html(" " + SprintName);
                                                                }
                                                                else {
                                                                    alertify.set('notifier', 'position', 'top-right');
                                                                    alertify.notify(result.d, 'error', 20);
                                                                    return;
                                                                }
                                                            },
                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);

                                                            }
                                                        });
                                                    }
                                                }
                                            });
                                        }


                                    },
                                    error: function (xhr, status, error) {

                                        console.log(xhr.responseText);

                                    }
                                });
                            }
                            //End for Complete stage
                            //When Drop to othe stage than inprogress and Complete  
                            else if (DropTdId == CurrentTdIDs[0]) {
                                $.ajax({
                                    type: "POST",
                                    url: "frmScrumBoard.aspx/UpdateStageID",
                                    data: JSON.stringify({ UserStoryID: UserStoryID, StageID: StageID, Mode: "InProgress" }),
                                    dataType: "json",
                                    contentType: "application/json",
                                    timeout: 180000,
                                    async: true,
                                    success: function (result) {

                                        if (result.d == "1") {

                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify("Stage Moved successfully", 'success', 20);
                                            $("#DragDropModal .close").click();
                                            Sprint_OnChange(document.getElementById("ScrumIterations"));
                                             $("#filterClear").css("visibility", "hidden");
                                            $(".sprintname").html("");
                                            $(".sprintname").html(" " + SprintName);
                                        }
                                        else {
                                            alertify.set('notifier', 'position', 'top-right');
                                            alertify.notify(result.d, 'error', 20);
                                            // alert();
                                            return;
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.log(xhr.responseText);

                                    }
                                });
                            }
                        }
                    }
                }
            })

        }
        function IconSelect_Onchange(obj) {


            if ($("#" + obj.id).val().toUpperCase() == "OTHERS") {

                $("#txtactivityicon").css("display", "block");
            }
            else {
                $("#txtactivityicon").css("display", "none");
            }

        }
        var cColor;
        function ChangeColor(ID, color, mode) {

            cColor = color;
            var url = "frmScrumBoard.aspx/ChangeColor";
            var data = JSON.stringify({ ID: ID, color: color, mode: mode });
            var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
            ChangeColor_Success(strUserResult);
        }
        function ChangeColor_Success(result) {

            if (result.d == 1) {
                $("#iPriorityColor").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 2) {
                $("#oColor").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 3) {
                $("#iVersion").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 4) {
                $("#iFVersion").attr("style", "font-size:14px;color:" + cColor + "!important")
            }
            if (result.d == 5) {
                $("#iScrumStage").attr("style", "font-size:14px;color:" + cColor + "!important");
                $("#stagebackgroundcolor").val(cColor);
            }
        }

        function AfterDragRefresh() {


            var url = "frmScrumBoard.aspx/RefreshPageAfterDraging";
            var data = JSON.stringify({});
            var strUserResult = ajaxCall(url, "POST", "application/json", "json", data);
            //alert(strUserResult.d);

            if (strUserResult.d != "") {
                $("#table").html("");
                $("#table").html(strUserResult.d);
                RefreshGrid();
                var largestheight = '';
                var currentheight = '';
                var finalheight = '';
                $("div[id*='stage_']").each(function () {

                    var i = $(this).attr('id');

                    var height = $("#" + $(this).attr('id')).height();
                    if (largestheight == "") {
                        largestheight = height;
                    }
                    else {
                        finalheight = largestheight > height ? largestheight : height
                        largestheight = finalheight;
                    }


                });
                $("div[id*='stage_']").css("height", finalheight + 15);
            }
        }

    </script>

</body>
</html>
