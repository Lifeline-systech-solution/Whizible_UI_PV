<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmSprintBacklog.aspx.vb" Inherits="PbNIT.frmSprintBacklog" %>

<!DOCTYPE html>

<html>
<!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <title></title>

    <link href="css/SprintBacklog.css?v=1.5" rel="stylesheet" />
    <%--    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css?v=2.1" />
    <%--    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" /> --%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

    <%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script type="text/javascript" src="assets/js/dragdrop.js"></script>
    <%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <%--<script src="../../Whizible2.0-new/dist/js/bootbox.min.js"></script>--%>
    <%--    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script> 
    <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>
</head>
<style>
    textarea {
        overflow: hidden !important;
    }

    .control-label {
        margin-top: 10px;
    }

    .completed-list {
        padding: 10px 3px 21px 6px !important;
    }

    textarea {
        ceme;
    }

    .task-attribute {
        font-weight: 600;
        font-size: 14px;
        padding: 10px;
        margin-top: 30px;
        margin-bottom: 21px;
        border-bottom: 1px solid #ddd;
    }

    /*Added by pradip on 6-10-2020*/
    .HeaderFreeze {
        right: 0;
        left: 0;
        z-index: 1030;
          /* Changed by Madhuri.K on 09-03-2026 */
    background: #F8FAFC;
        /* background: #e7edf0; */
        padding: 12px;
        margin-top: 0px;
        display: flex
    }
    /*End Added by pradip*/


    @media (max-width:1189px) {
        .width {
            width: 100% !important;
        }
    }

    @media (max-width:1146px) {
        .drag-drop-popup {
            float: right;
            margin-top: 0% !important;
            position: absolute;
            right: 31px;
        }

        .task-high {
            margin-right: 3%;
        }

        .col-sm-2 {
            width: 100% !important;
            margin-top: 10px;
        }

        .col-sm-10 {
            width: 100% !important;
        }
    }
    /*@media (max-width:1100px) {
    .col-sm-2 {
    float: inherit!important;
}
}*/
    @media (min-width:992px) {
        .drag-drop-popup {
            float: right;
            margin-top: -12% !important;
        }

        .task-high {
            margin-right: 0%;
        }
    }

    @media (max-width: 1100px) {
        .modal-dialog {
            width: 770px !important;
            margin: 30px auto;
        }
    }

    .label-success {
        background-color: #5cb85c;
    }

    .label {
        display: inline;
        padding: 0.2em 0.6em 0.3em;
        font-size: 75%;
        font-weight: 700;
        line-height: 1;
        color: #fff;
        text-align: center;
        white-space: nowrap;
        vertical-align: baseline;
        border-radius: 0.25em;
    }

    .scrum-content {
        position: relative;
        overflow: inherit;
        margin-top: 45px !important;
        width: 100%
    }

    .scrum-stories-list {
        position: relative
    }

    @media (max-width: 1146px) {
        .drag-drop-popup {
            right: 10px;
        }
    }

    .scrum-title .fa-check-square {
        color: #8BC34A;
    }
</style>
<body>
    <form id="frmSprintBacklog" runat="server">
        <div>
            <div class="container-fluid" style="margin-top: 8px; margin-left: 8px; margin-right: -20px;">
                <%PlotMainSection()%>
            </div>
        </div>
        <div class="modal fade dragdrop" id="DragDropModal" role="dialog">
            <div class="modal-dialog modal-sm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal" data-bs-toggle='tooltip' title="Close">&times;</button>
                        <h4 class="modal-title">Drag & Drop Task</h4>
                    </div>
                    <div class="modal-body" id="DragDropBody">
                        <form>
                            <div class="input-group stage-divide">
                                <span class="input-group-addon stage-info">
                                    <i class="fa fa-list"></i>
                                </span>
                                <select class="form-control" name="stageList">
                                    <option>To do list</option>
                                    <option>Progress</option>
                                </select>
                            </div>
                            <div class="input-group stage-divide">
                                <span class="input-group-addon  stage-info">
                                    <i class="fa fa-dot-circle-o"></i>
                                </span>
                                <select class="form-control" name="storyPosition">
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                            </div>
                            <div class="input-group col-md-12 col-sm-12 col-xs-12 align-center">
                                <input type="submit" class="btn btn-default submit-btn" name="setPosition" value="Submit">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="taskpopup" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h4 class="modal-title" style="font-size: 14px!important; font-weight: 600!important;">Task Detail</h4>
                    </div>
                    <div class="modal-body" id="modalPop">
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="updbtn0" class="btn btn-info" onclick="UpdateTask()">Update</button>
                    </div>
                </div>

            </div>
        </div>
    </form>



    <script>
        $(document).click(function () {
            $(".tooltip").removeClass("in");
        });

        $('#dropdown-content').on('click', function (e) {
            e.stopPropagation();
        });
    </script>

    <script>
        var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height();
        var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight

        console.log(Finalheight);
        $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
        windowheight = $(window).height();
        $(".main").css({ "height": windowheight, "overflow-y": "auto" });

        $(".main").scroll(function () {
            var currentScroll = ($("#divMain").scrollTop() - 45);
            if ($(".main").scrollTop()) {
                $('.scrum-content').each(function () {
                    $('.scrum-content').addClass('fixed-header');
                    $('.scrum-content').css("top", currentScroll);

                    // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                });

            } else {
                $('.scrum-content').removeClass('fixed-header');
            }
        });
        var globalUSID = "", globaltaskid = "", flag = "";
        function taskpopup(TaskID, UserStoryID, flag) {
            globalUSID = UserStoryID
            globaltaskid = TaskID
            //if (UserStoryID == null) {

            //    UserStoryID = $("#hdnUserStoryID").val();
            //}
            //else {

            //    UserStoryID = UserStoryID;
            //}
            //  alert(UserStoryID);
            var strUserResult = ajaxCall("frmSprintBacklog.aspx/TaskPopup",
                "POST", "application/json", "json",
                JSON.stringify({ TaskID: TaskID, UserStoryID: UserStoryID }));
            $("#modalPop").html("");
            $("#modalPop").html(strUserResult.d);
            $("#taskpopup").modal('show');
            $('#dtStartDateAssigntask').datepicker();
            $('#dtEndDateAssigntask').datepicker();
            if (flag == "Completed") {

                $("#updbtn0").attr("disabled", true)
            }
            else {
                $("#updbtn0").attr("disabled", false)

            }
            AutoResizeTextArea();
            RemoveTextArea();

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
        var IsFlagcountdownFN = 0;
        var IsFlagcountdownAC = 0;
        var IsFlagcountdownSummary = 0;
        var IsFlagSubus = 0;
        var IsFlag = 0;
        var IsFlagTaskname = 0;
        var IsFlagcountcountTaskNote = 0;
        var IsFlagcountcountTaskName = 0;
        function limitText(limitField, limitCount, limitNum) {
            // debugger;
            var length;
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                limitCount.innerHTML = '-' + (limitNum - limitField.value.length);

                if (limitCount.innerHTML != 0) {
                    IsFlagcountdownSummary = 0;
                    IsFlagcountdownFN = 0;
                    IsFlagcountdownAC = 0;
                    IsFlagSubus = 0;
                    IsFlag = 0;
                    IsFlagcountcountTaskNote = 0;
                    IsFlagcountcountTaskName = 0;
                }
            }
            //if (limitCount.innerHTML == -20) {
            //    limitCount.innerHTML = 0;

            //    IsFlagcountcountTaskName = 0;

            //}
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
                else if (limitCount.id == 'countdownBU') {
                    document.getElementById("countdownBU").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 200 Character', 'error', 25);
                }
                else if (limitCount.id == 'countSubUSdown') {
                    if (IsFlagSubus != 1) {
                        document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 1000 Character', 'error', 25);
                        IsFlagSubus = 1;
                        return IsFlagSubus;
                    }
                }
                else if (limitCount.id == 'countdownAC') {
                    document.getElementById("countdownAC").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanAcceptanceCriteria').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 200 Character', 'error', 25);
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
                else if (limitCount.id == 'countTaskNote') {
                    if (IsFlagcountcountTaskNote != 1) {
                        document.getElementById("countTaskNote").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 2000 Character', 'error', 25);
                        IsFlagcountcountTaskNote = 1;
                        return IsFlagcountcountTaskNote;
                    }
                }
                else if (limitCount.id == 'countTaskName') {
                    if (IsFlagcountcountTaskName != 1) {
                        document.getElementById("countTaskName").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanAcceptanceCriteria').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 255 Character', 'error', 25);
                        IsFlagcountcountTaskName = 1;

                        return IsFlagcountcountTaskName;

                    }
                }
                else {
                    document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanUserDesc').html("You Can Enter Only 1000 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 1000 Character', 'error', 25);
                }
            }
            else {
                if (limitCount.id == 'countdownBU') {
                    // document.getElementById("countdownBU").style.color = 'black'
                    // $('#spanBusinessValue').text("");
                }
                else if (limitCount.id == 'countdownAC') {
                    // document.getElementById("countdownAC").style.color = 'black'
                    // $('#spanAcceptanceCriteria').text("");
                }
                else {
                    // document.getElementById("countdown").style.color = 'black'
                    // $('#spanUserDesc').text("");
                }
            }
        }
        $("#clsdivtodolist").click(function () {


        });
        $('[data-bs-toggle="tooltip"]').tooltip();
        $(".taskname").tooltip();
        var divHeight1;
        var BydafualtSprintText = "";
        var objSprint = "";
        $(document).ready(function () {
            var selected;
            //
            windowheight = $(window).height();
            $(".main").css({ "height": windowheight, "overflow-y": "auto" });

            $(".main").scroll(function () {
                var currentScroll = ($("#divMain").scrollTop() - 45);
                if ($(".main").scrollTop()) {
                    $('.scrum-content').each(function () {
                        $('.scrum-content').addClass('fixed-header');
                        $('.scrum-content').css("top", currentScroll);

                        // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                    });

                } else {
                    $('.scrum-content').removeClass('fixed-header');
                }
            });
            /*Added by Yasmin On 16th July 2018*/
            objSprint = document.getElementById("SprintBacklogSprint");
            BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text
            //Added By Dipali V On 28th Feb 2022 For Placeholder
            if (BydafualtSprintText == "Select Sprint") {
                BydafualtSprintText = "";
            }
            //End of Added By Dipali V On 28th Feb 2022 For Placeholder
            $(".sprintname").text(BydafualtSprintText);
            RefreshGrid();

            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".taskname").tooltip();
            SelectedUD = "";

            $("#txtAssignedTo").click(function () {

                $("#emplistUL").show();



            });
            $("#emplistUL").mouseleave(function () {
                //alert("abc");
                $("#emplistUL").hide();



            });
            //CollapseExpand();

            //  RefreshGrid()
            serachFilter();
            RefreshGrid();

            var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
            var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight

            console.log(Finalheight);
            $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
            windowheight = $(window).height();
            $(".main").css({ "height": windowheight, "overflow-y": "auto" });

            $(".main").scroll(function () {
                var currentScroll = ($("#divMain").scrollTop() - 45);
                if ($(".main").scrollTop()) {
                    $('.scrum-content').each(function () {
                        $('.scrum-content').addClass('fixed-header');
                        $('.scrum-content').css("top", currentScroll);

                        // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                    });

                } else {
                    $('.scrum-content').removeClass('fixed-header');
                }
            });

        });
        //to make scrollbar resizable
        $(window).on('resize', function () {
            //Added by Usha Pandit on 29 Apr 2019 for windowWidth undefined javascript
            windowWidth = $(this).width();
            windowheight = $(this).height();
            //End of Added by Usha Pandit on 29 Apr 2019 for windowWidth undefined javascript
            if ($(this).width() != windowWidth && $(this).height() != windowheight) {
                windowWidth = $(this).width();
                windowheight = $(this).height();
                $(".main").css("height", windowheight);
                $(".main").css("overflow", "auto");

            }
        });
        function myFunction() {
            var input, filter, ul, li, a, i;
            input = document.getElementById("txtAssignedTo");
            filter = input.value.toUpperCase();
            ul = document.getElementById("emplistUL");
            li = document.getElementsByClassName("clsAssignedListItem");
            for (i = 0; i < li.length; i++) {
                a = li[i].innerText;
                if (a.toUpperCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";

                }
            }
        }
        function AssignToListClick(object) {
            $("#txtAssignedTo").val(object.name);
            $("#hdnAssignToId").val(object.id);

        }



        var SprintID = "", BydafualtSprintText = "", AssignFilterChecked;
        function Filter_onclickSprint(object) {
            objSprint = document.getElementById("SprintBacklogSprint");
            Value = document.getElementById("SprintBacklogSprint").value;

            // BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text;
            if ($("#TaskAssigntome").prop('checked')) {
                AssignFilterChecked = "1";
            }
            else {
                AssignFilterChecked = "0";
            }
            if (Value == "") {

                Value = $("#hdnCurrentIterationID").val();
                // BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text
                // alert(BydafualtSprintText);
            }
            //Added By Dipali V On 30th July 2018 For User Story 338
            $("#SprintBacklogSprint").val(Value);
            //End of Added By Dipali V On 30th July 2018 For User Story 338
            /*Added by Yasmin On 16th July 2018*/
            var objSprint = document.getElementById("SprintBacklogSprint");
            if (document.getElementById("SprintBacklogSprint").value != 0) { //Added By Dipali V On 28th Feb 2022 For Placeholder
                BydafualtSprintText = objSprint.options[objSprint.selectedIndex].text
                //Added By Dipali V On 28th Feb 2022 For Placeholder
                if (BydafualtSprintText == "Select Sprint") {
                    BydafualtSprintText = "";
                }
                $(".sprintname").text(BydafualtSprintText);
                //End of Added By Dipali V On 28th Feb 2022 For Placeholder
                SprintID = Value;
                // alert(SprintID)
                var strUserResult = ajaxCall("frmSprintBacklog.aspx/FilterPage",
                    "POST", "application/json", "json",
                    JSON.stringify({ SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }));
                if (strUserResult.d != null || strUserResult.d != undefined) {

                    document.getElementById('Allcardsdata').innerHTML = "";
                    document.getElementById('Allcardsdata').innerHTML = strUserResult.d;

                    //$("#todolist").mouseleave(function () {
                    //    alert(1);
                    //});
                    //$("#progresslist").draggable(function () {
                    //    alert(2);
                    //});

                    CollapseExpand();
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $(".taskname").tooltip();
                    $('#div1').removeClass('open');
                    SelectedUD = "";
                    RefreshGrid();
                    //divHeight1 = $('#todolist').height();
                    //$('#todolist').css('height', divHeight1 + 20);
                    //$('#progresslist').css('height', divHeight1 + 20);

                    //$('#completedlist').css('height', divHeight1 + 20);
                    var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                    var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight


                    $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                    windowheight = $(window).height();
                    $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                    $(".main").scroll(function () {
                        var currentScroll = ($("#divMain").scrollTop() - 45);
                        if ($(".main").scrollTop()) {
                            $('.scrum-content').each(function () {
                                $('.scrum-content').addClass('fixed-header');
                                $('.scrum-content').css("top", currentScroll);

                                // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                            });

                        } else {
                            $('.scrum-content').removeClass('fixed-header');
                        }
                    });
                    //RefreshPage();
                }
            }
            else {
                //Added By Dipali V On 28th Feb 2022 For Placeholder
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Sprint.', 'error', 20);
                return;
                //End of Added By Dipali V On 28th Feb 2022 For Placeholder
            }

        }


        function Clear_onclick(object) {
            $("#SprintBacklogSprint").val("");

            if ($("#TaskAssigntome").prop('checked')) {
                AssignFilterChecked = "1";
            }
            else {
                AssignFilterChecked = "0";
            }
            Filter_onclickSprint(this)
            CollapseExpand();
            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".taskname").tooltip();
        }

        function CollapseExpand() {
            $("#toggle").on('click', function () {
                var x = $("#sidebar").css("left");
                if (x == '0px') {
                    $("#sidebar").animate({
                        width: '34%'
                    });
                    $("#sidebarnew").animate({
                        height: '570px'
                    });
                    $("#sidebarnew").html("");
                    $("#sidebarnew").html("<i class='fa fa-sign-out' onclick='ShowOrignalView()' id='toggle2' aria-hidden='true' style='margin-left: 14px;  line-height: 49px;font-size: 14px;'></i><p style='white-space:nowrap;position: absolute; transform: rotateZ(-89deg);margin-top: 250px;font-weight: 600;  font-size: 14px;'>TO DO</p>");

                } else {
                    $("#sidebar").animate({
                        left: '0'
                    });
                }

            });
        }




        function serachFilter() {


            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".taskname").tooltip();
            $("#mytaskprogress").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".progresslist").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
            $("#completedtask").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".completed-list").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $("#Tasktodolist").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".todolist").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            $("#userstories").on("keyup", function () {
                var value = $(this).val().toLowerCase();

                $(".User-Story").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });


        }
        var SelectedDiv = "", SelectedUD = "", flag = "";
        function filterTask_US(obj, UserStoryID) {
            flag = "1";
            SelectedUD = UserStoryID;
            Globalobj = obj;
            // alert(SelectedUD);
            SelectedDiv = "SelectUS" + UserStoryID
            var SprintValue = document.getElementById("SprintBacklogSprint").value;
            if (SprintValue == "") {
                SprintValue = $("#hdnCurrentIterationID").val();

            }
            if ($("#TaskAssigntome").prop('checked')) {
                AssignFilterChecked = "1";
            }
            else {
                AssignFilterChecked = "0";
            }
            var strUserResult = ajaxCall("frmSprintBacklog.aspx/FilterDataPerUS",
                "POST", "application/json", "json",
                JSON.stringify({ SprintValue: SprintValue, UserStoryID: UserStoryID, AssignFilterChecked: AssignFilterChecked, SelectedDiv: SelectedDiv }));
            if (strUserResult.d != null || strUserResult.d != undefined) {

                document.getElementById('Allcardsdata').innerHTML = "";
                document.getElementById('Allcardsdata').innerHTML = strUserResult.d;
                // CollapseExpand();
                $('[data-bs-toggle="tooltip"]').tooltip();

                $(".taskname").tooltip();
                RefreshGrid();

                //$('[data-bs-toggle="tooltip"]').tooltip();
                // $(obj).css('border', '2px Solid Red');
                //$("#SelectUS" + UserStoryID).css('border', '2px Solid Red');
                //$("#SelectUS" + UserStoryID).css('border', '2px Solid Red');
            }


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

        function Open_DragPopUp(TaskID, Flag) {

            var data = JSON.stringify({ TaskID: TaskID, Flag: Flag });
            var strUserResult = ajaxCall('frmSprintBacklog.aspx/PlotDragDrop', "POST", "application/json", "json", data)
            if (strUserResult.d != '') {
                // alert(strUserResult.d);
                $("#DragDropBody").html();
                $("#DragDropBody").html(strUserResult.d);
                $("#DragDropModal").modal('show');
                $('[data-bs-toggle="tooltip"]').tooltip();
                $(".taskname").tooltip();
            }
        }
        var SprintSelected = "";


        function DragDrop_Onclick(TaskID, Flag) {

            //  debugger;
            SprintSelected = document.getElementById("SprintBacklogSprint").value;
            if (SprintSelected == "") {

                SprintSelected = $("#hdnCurrentIterationID").val();

            }
            if ($("#TaskAssigntome").prop('checked')) {
                AssignFilterChecked = "1";
            }
            else {
                AssignFilterChecked = "0";
            }
            SprintID = SprintSelected;


            if (Flag == "ToDOList") {

                var IsCompletedSprint = $("#clsdivtodolist").attr("draggable");

                if (IsCompletedSprint.toUpperCase() == 'FALSE') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is completed you can not drag tasks.', 'error', 20);
                    $(ui.sender).sortable('cancel');
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: "frmSprintBacklog.aspx/ValidateLogPersonAcessTask",
                    data: JSON.stringify({ StrTaskID: TaskID }),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",
                    //timeout: 180000,
                    success: function (res) {
                        // debugger;
                        if (res.d != "") {
                            bootbox.confirm({
                                message: res.d,
                                buttons: {
                                    confirm: {
                                        label: 'Yes',
                                        className: 'btn-success'
                                    },
                                    cancel: {
                                        label: 'No',
                                        className: 'btn-danger'
                                    }
                                },
                                callback: function (result) {
                                    if (result == true) {
                                        var value = $("#Stages").val();
                                        if (value == "2") {

                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                data: JSON.stringify({ StrTaskID: TaskID }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    if (result.d != "") {
                                                        //bootbox.confirm({
                                                        //    message: result.d,
                                                        //    buttons: {
                                                        //        confirm: {
                                                        //            label: 'Yes',
                                                        //            className: 'btn-success'
                                                        //        },
                                                        //        cancel: {
                                                        //            label: 'No',
                                                        //            className: 'btn-danger'
                                                        //        }
                                                        //    },
                                                        // callback: function (result) {
                                                        //if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    // alertify.set('notifier', 'position', 'top-right');
                                                                    // alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })
                                                        // }
                                                        // }

                                                        // });



                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    // alertify.set('notifier', 'position', 'top-right');
                                                                    // alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })



                                                    }
                                                }
                                            });
                                        }

                                        else if (value == "3") {

                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                data: JSON.stringify({ StrTaskID: TaskID }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    if (result.d != "") {
                                                        bootbox.confirm({
                                                            message: result.d,
                                                            buttons: {
                                                                confirm: {
                                                                    label: 'Yes',
                                                                    className: 'btn-success'
                                                                },
                                                                cancel: {
                                                                    label: 'No',
                                                                    className: 'btn-danger'
                                                                }
                                                            },
                                                            callback: function (result) {
                                                                if (result == true) {
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                        data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                                        dataType: "json",
                                                                        async: false,
                                                                        contentType: "application/json",
                                                                        //timeout: 180000,
                                                                        success: function (result) {
                                                                            var strResult = result.d.split("||")
                                                                            if (strResult[0] != "") {

                                                                                // alertify.set('notifier', 'position', 'top-right');
                                                                                // alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                                $("#Allcardsdata").html(strResult[1]);
                                                                            }
                                                                            RefreshGrid();
                                                                        },

                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);
                                                                            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                                        }
                                                                    })
                                                                }
                                                                else {
                                                                    //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                    $(ui.sender).sortable('cancel');
                                                                    return;
                                                                    //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                                }
                                                            }

                                                        });



                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //  alertify.set('notifier', 'position', 'top-right');
                                                                    //  alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })



                                                    }
                                                }
                                            });




                                        }
                                    }
                                }

                            });

                        }
                        else {


                            var value = $("#Stages").val();
                            if (value == "2") {

                                $.ajax({
                                    type: "POST",
                                    url: "frmSprintBacklog.aspx/DropValidation",
                                    data: JSON.stringify({ StrTaskID: TaskID }),
                                    dataType: "json",
                                    async: false,
                                    contentType: "application/json",
                                    //timeout: 180000,
                                    success: function (result) {
                                        if (result.d != "") {
                                            //bootbox.confirm({
                                            //    message: result.d,
                                            //    buttons: {
                                            //        confirm: {
                                            //            label: 'Yes',
                                            //            className: 'btn-success'
                                            //        },
                                            //        cancel: {
                                            //            label: 'No',
                                            //            className: 'btn-danger'
                                            //        }
                                            //    },
                                            //callback: function (result) {
                                            // if (result == true) {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    var strResult = result.d.split("||")
                                                    if (strResult[0] != "") {

                                                        //     alertify.set('notifier', 'position', 'top-right');
                                                        //    alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                        $("#Allcardsdata").html(strResult[1]);
                                                    }
                                                    RefreshGrid();
                                                },

                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);
                                                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                }
                                            })
                                            // }
                                            // }

                                            //});



                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    var strResult = result.d.split("||")
                                                    if (strResult[0] != "") {

                                                        //   alertify.set('notifier', 'position', 'top-right');
                                                        //   alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                        $("#Allcardsdata").html(strResult[1]);
                                                    }
                                                    RefreshGrid();
                                                },

                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);
                                                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                }
                                            })



                                        }
                                    }
                                });
                            }

                            else if (value == "3") {

                                $.ajax({
                                    type: "POST",
                                    url: "frmSprintBacklog.aspx/DropValidation",
                                    data: JSON.stringify({ StrTaskID: TaskID }),
                                    dataType: "json",
                                    async: false,
                                    contentType: "application/json",
                                    //timeout: 180000,
                                    success: function (result) {
                                        if (result.d != "") {
                                            bootbox.confirm({
                                                message: result.d,
                                                buttons: {
                                                    confirm: {
                                                        label: 'Yes',
                                                        className: 'btn-success'
                                                    },
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-danger'
                                                    }
                                                },
                                                callback: function (result) {
                                                    if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //      alertify.set('notifier', 'position', 'top-right');
                                                                    //       alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })
                                                    }
                                                    else {
                                                        //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                        $(ui.sender).sortable('cancel');
                                                        return;
                                                        //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                    }
                                                }

                                            });



                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    var strResult = result.d.split("||")
                                                    if (strResult[0] != "") {

                                                        //  alertify.set('notifier', 'position', 'top-right');
                                                        //   alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                        $("#Allcardsdata").html(strResult[1]);
                                                    }
                                                    RefreshGrid();
                                                },

                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);
                                                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                }
                                            })



                                        }
                                    }
                                });




                            }


                        }
                    }

                })
            }
            else if (Flag == "InProgress") {
                var IsCompletedSprint = $("#clsdivprogresslist").attr("draggable");

                if (IsCompletedSprint.toUpperCase() == 'FALSE') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is completed you can not drag tasks.', 'error', 20);
                    $(ui.sender).sortable('cancel');
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "frmSprintBacklog.aspx/ValidateLogPersonAcessTask",
                    data: JSON.stringify({ StrTaskID: TaskID }),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",
                    //timeout: 180000,
                    success: function (res1) {
                        ;
                        if (res1.d != "") {
                            bootbox.confirm({
                                message: res1.d,
                                buttons: {
                                    confirm: {
                                        label: 'Yes',
                                        className: 'btn-success'
                                    },
                                    cancel: {
                                        label: 'No',
                                        className: 'btn-danger'
                                    }
                                },
                                callback: function (result) {
                                    if (result == true) {
                                        var value = $("#Stages").val();
                                        //alert(value);
                                        if (value == "1") {

                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                data: JSON.stringify({ StrTaskID: TaskID }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    if (result.d != "") {
                                                        // bootbox.confirm({
                                                        //  message: result.d,
                                                        //buttons: {
                                                        //    confirm: {
                                                        //        label: 'Yes',
                                                        //        className: 'btn-success'
                                                        //    },
                                                        //    cancel: {
                                                        //        label: 'No',
                                                        //        className: 'btn-danger'
                                                        //    }
                                                        //},
                                                        // callback: function (result) {
                                                        //if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //    alertify.set('notifier', 'position', 'top-right');
                                                                    //    alertify.notify('Task Dragged In TO-DO List Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })
                                                        //  }
                                                        // }

                                                        //  });



                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //   alertify.set('notifier', 'position', 'top-right');
                                                                    //   alertify.notify('Task Dragged In TO-DO List Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })



                                                    }
                                                }
                                            });
                                        }

                                        else if (value == "3") {

                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                data: JSON.stringify({ StrTaskID: TaskID }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (completeTask) {
                                                    // alert(completeTask.d);
                                                    if (completeTask.d != "") {
                                                        bootbox.confirm({
                                                            message: completeTask.d,
                                                            buttons: {
                                                                confirm: {
                                                                    label: 'Yes',
                                                                    className: 'btn-success'
                                                                },
                                                                cancel: {
                                                                    label: 'No',
                                                                    className: 'btn-danger'
                                                                }
                                                            },
                                                            callback: function (result) {
                                                                if (result == true) {
                                                                    $.ajax({
                                                                        type: "POST",
                                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                        data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                                        dataType: "json",
                                                                        async: false,
                                                                        contentType: "application/json",
                                                                        //timeout: 180000,
                                                                        success: function (result) {
                                                                            var strResult = result.d.split("||")
                                                                            if (strResult[0] != "") {

                                                                                //    alertify.set('notifier', 'position', 'top-right');
                                                                                //    alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                                $("#Allcardsdata").html(strResult[1]);
                                                                            }
                                                                            RefreshGrid();
                                                                        },

                                                                        error: function (xhr, status, error) {
                                                                            console.log(xhr.responseText);
                                                                            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                                        }
                                                                    })
                                                                }
                                                                else {
                                                                    //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                    $(ui.sender).sortable('cancel');
                                                                    return;
                                                                    //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                                }
                                                            }

                                                        });



                                                    }
                                                    else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //   alertify.set('notifier', 'position', 'top-right');
                                                                    //   alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();

                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })



                                                    }
                                                }
                                            });




                                        }
                                    }
                                }

                            });



                        }
                        else {
                            var value = $("#Stages").val();

                            if (value == "1") {

                                $.ajax({
                                    type: "POST",
                                    url: "frmSprintBacklog.aspx/DropValidation",
                                    data: JSON.stringify({ StrTaskID: TaskID }),
                                    dataType: "json",
                                    async: false,
                                    contentType: "application/json",
                                    //timeout: 180000,
                                    success: function (result) {
                                        if (result.d != "") {
                                            bootbox.confirm({
                                                message: result.d,
                                                buttons: {
                                                    confirm: {
                                                        label: 'Yes',
                                                        className: 'btn-success'
                                                    },
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-danger'
                                                    }
                                                },
                                                callback: function (result) {
                                                    if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //    alertify.set('notifier', 'position', 'top-right');
                                                                    //    alertify.notify('Task Dragged In To-Do List  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })
                                                    }
                                                    else {
                                                        //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                        $(ui.sender).sortable('cancel');
                                                        return;
                                                        //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                    }
                                                }

                                            });



                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    var strResult = result.d.split("||")
                                                    if (strResult[0] != "") {

                                                        // alertify.set('notifier', 'position', 'top-right');
                                                        // alertify.notify('Task Dragged In To-Do list  Successfully', 'success');
                                                        $("#Allcardsdata").html(strResult[1]);
                                                    }
                                                    RefreshGrid();
                                                },

                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);
                                                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                }
                                            })



                                        }
                                    }
                                });
                            }
                            else if (value == "3") {

                                $.ajax({
                                    type: "POST",
                                    url: "frmSprintBacklog.aspx/DropValidation",
                                    data: JSON.stringify({ StrTaskID: TaskID }),
                                    dataType: "json",
                                    async: false,
                                    contentType: "application/json",
                                    //timeout: 180000,
                                    success: function (result) {
                                        if (result.d != "") {
                                            bootbox.confirm({
                                                message: result.d,
                                                buttons: {
                                                    confirm: {
                                                        label: 'Yes',
                                                        className: 'btn-success'
                                                    },
                                                    cancel: {
                                                        label: 'No',
                                                        className: 'btn-danger'
                                                    }
                                                },
                                                callback: function (result) {
                                                    if (result == true) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                            data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                            dataType: "json",
                                                            async: false,
                                                            contentType: "application/json",
                                                            //timeout: 180000,
                                                            success: function (result) {
                                                                var strResult = result.d.split("||")
                                                                if (strResult[0] != "") {

                                                                    //         alertify.set('notifier', 'position', 'top-right');
                                                                    //         alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                }
                                                                RefreshGrid();
                                                            },

                                                            error: function (xhr, status, error) {
                                                                console.log(xhr.responseText);
                                                                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                            }
                                                        })
                                                    }
                                                    else {
                                                        //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                        $(ui.sender).sortable('cancel');
                                                        return;
                                                        //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                    }
                                                }

                                            });



                                        }
                                        else {
                                            $.ajax({
                                                type: "POST",
                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                data: JSON.stringify({ StrTaskID: TaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                dataType: "json",
                                                async: false,
                                                contentType: "application/json",
                                                //timeout: 180000,
                                                success: function (result) {
                                                    var strResult = result.d.split("||")
                                                    if (strResult[0] != "") {

                                                        //  alertify.set('notifier', 'position', 'top-right');
                                                        //   alertify.notify('Task Dragged In Completed  Successfully', 'success');
                                                        $("#Allcardsdata").html(strResult[1]);
                                                    }
                                                    RefreshGrid();
                                                },

                                                error: function (xhr, status, error) {
                                                    console.log(xhr.responseText);
                                                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                }
                                            })



                                        }
                                    }
                                });




                            }

                        }
                    }

                })
            }

            else if (Flag == "Completed") {
                var IsCompletedSprint = $("#clsdivcompletedlist").attr("draggable");

                if (IsCompletedSprint.toUpperCase() == 'FALSE') {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint is completed you can not drag tasks.', 'error', 20);
                    $(ui.sender).sortable('cancel');
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "frmSprintBacklog.aspx/ValidateLogPersonAcessTask",
                    data: JSON.stringify({ StrTaskID: TaskID }),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",
                    //timeout: 180000,
                    success: function (res2) {
                        bootbox.confirm({
                            message: res2.d,
                            buttons: {
                                confirm: {
                                    label: 'Yes',
                                    className: 'btn-success'
                                },
                                cancel: {
                                    label: 'No',
                                    className: 'btn-danger'
                                }
                            },
                            callback: function (result) {
                                if (result == true) {
                                    var value = $("#Stages").val();
                                    if (value == "1") {

                                        $.ajax({
                                            type: "POST",
                                            url: "frmSprintBacklog.aspx/DropValidation",
                                            data: JSON.stringify({ StrTaskID: TaskID }),
                                            dataType: "json",
                                            async: false,
                                            contentType: "application/json",
                                            //timeout: 180000,
                                            success: function (result) {
                                                if (result.d != "") {
                                                    bootbox.confirm({
                                                        message: result.d,
                                                        buttons: {
                                                            confirm: {
                                                                label: 'Yes',
                                                                className: 'btn-success'
                                                            },
                                                            cancel: {
                                                                label: 'No',
                                                                className: 'btn-danger'
                                                            }
                                                        },
                                                        callback: function (result) {
                                                            if (result == true) {
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                    data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                                    dataType: "json",
                                                                    async: false,
                                                                    contentType: "application/json",
                                                                    //timeout: 180000,
                                                                    success: function (result) {
                                                                        var strResult = result.d.split("||")
                                                                        if (strResult[0] != "") {

                                                                            //   alertify.set('notifier', 'position', 'top-right');
                                                                            //   alertify.notify('Task Dragged In To-Do list  Successfully', 'success');
                                                                            $("#Allcardsdata").html(strResult[1]);
                                                                        }
                                                                        RefreshGrid();
                                                                    },

                                                                    error: function (xhr, status, error) {
                                                                        console.log(xhr.responseText);
                                                                        window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                                    }
                                                                })
                                                            }
                                                            else {
                                                                //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                $(ui.sender).sortable('cancel');
                                                                return;
                                                                //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                            }
                                                        }

                                                    });



                                                }
                                                else {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                        data: JSON.stringify({ StrTaskID: TaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                        dataType: "json",
                                                        async: false,
                                                        contentType: "application/json",
                                                        //timeout: 180000,
                                                        success: function (result) {
                                                            var strResult = result.d.split("||")
                                                            if (strResult[0] != "") {

                                                                //    alertify.set('notifier', 'position', 'top-right');
                                                                //    alertify.notify('Task Dragged In To-Do list  Successfully', 'success');
                                                                $("#Allcardsdata").html(strResult[1]);
                                                            }
                                                            RefreshGrid();
                                                        },

                                                        error: function (xhr, status, error) {
                                                            console.log(xhr.responseText);
                                                            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                        }
                                                    })



                                                }
                                            }
                                        });
                                    }

                                    else if (value == "2") {

                                        $.ajax({
                                            type: "POST",
                                            url: "frmSprintBacklog.aspx/DropValidation",
                                            data: JSON.stringify({ StrTaskID: TaskID }),
                                            dataType: "json",
                                            async: false,
                                            contentType: "application/json",
                                            //timeout: 180000,
                                            success: function (result) {
                                                if (result.d != "") {
                                                    bootbox.confirm({
                                                        message: result.d,
                                                        buttons: {
                                                            confirm: {
                                                                label: 'Yes',
                                                                className: 'btn-success'
                                                            },
                                                            cancel: {
                                                                label: 'No',
                                                                className: 'btn-danger'
                                                            }
                                                        },
                                                        callback: function (result) {
                                                            if (result == true) {
                                                                $.ajax({
                                                                    type: "POST",
                                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                    data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),

                                                                    dataType: "json",
                                                                    async: false,
                                                                    contentType: "application/json",
                                                                    //timeout: 180000,
                                                                    success: function (result) {
                                                                        var strResult = result.d.split("||")
                                                                        if (strResult[0] != "") {

                                                                            //      alertify.set('notifier', 'position', 'top-right');
                                                                            //      alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                                            $("#Allcardsdata").html(strResult[1]);
                                                                        }
                                                                        RefreshGrid();
                                                                    },

                                                                    error: function (xhr, status, error) {
                                                                        console.log(xhr.responseText);
                                                                        window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                                    }
                                                                })
                                                            }
                                                            else {
                                                                //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                $(ui.sender).sortable('cancel');
                                                                return;
                                                                //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                            }
                                                        }

                                                    });



                                                }
                                                else {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                        data: JSON.stringify({ StrTaskID: TaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                        dataType: "json",
                                                        async: false,
                                                        contentType: "application/json",
                                                        //timeout: 180000,
                                                        success: function (result) {
                                                            var strResult = result.d.split("||")
                                                            if (strResult[0] != "") {

                                                                //   alertify.set('notifier', 'position', 'top-right');
                                                                //   alertify.notify('Task Dragged In Progress  Successfully', 'success');
                                                                $("#Allcardsdata").html(strResult[1]);
                                                            }
                                                            RefreshGrid();
                                                        },

                                                        error: function (xhr, status, error) {
                                                            console.log(xhr.responseText);
                                                            window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                                                        }
                                                    })



                                                }
                                            }
                                        });




                                    }
                                }
                            }

                        });



                    }
                })
            }
            serachFilter();
            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".taskname").tooltip();
            $("#DragDropModal").modal('hide');
        }

        function Release_OnChange() {


        }

        //function ApplyDraggable() {

        //    $(".divDraggable").sortable({
        //        connectWith: ".divDraggable",
        //        helper: 'clone',
        //        activate: function (ev, ui) {

        //        }
        //    });
        //    $('[data-bs-toggle="tooltip"]').tooltip();
        //}

        function RefreshGrid() {


            $(".divDraggable").sortable({
                connectWith: ".divDraggable",
                helper: 'clone',
                start: function (ev, ui) {
                    var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                    var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                    console.log(Comapreheight);

                    console.log(Finalheight);
                    $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                    windowheight = $(window).height();
                    $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                    $(".main").scroll(function () {
                        var currentScroll = ($("#divMain").scrollTop() - 45);
                        if ($(".main").scrollTop()) {
                            $('.scrum-content').each(function () {
                                $('.scrum-content').addClass('fixed-header');
                                $('.scrum-content').css("top", currentScroll);

                                // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                            });

                        } else {
                            $('.scrum-content').removeClass('fixed-header');
                        }
                    });
                },
                activate: function (ev, ui) {
                    /*To Do List*/
                    var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                    var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                    console.log(Comapreheight);

                    console.log(Finalheight);
                    $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                    windowheight = $(window).height();
                    $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                    $(".main").scroll(function () {
                        var currentScroll = ($("#divMain").scrollTop() - 45);
                        if ($(".main").scrollTop()) {
                            $('.scrum-content').each(function () {
                                $('.scrum-content').addClass('fixed-header');
                                $('.scrum-content').css("top", currentScroll);

                                // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                            });

                        } else {
                            $('.scrum-content').removeClass('fixed-header');
                        }
                    });
                    $(".todolistheight").mouseenter(function () {
                        $(".tooltip").hide();
                    });





                }
                ,
                receive: function (event, ui) {

                    var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                    var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                    console.log(Comapreheight);

                    console.log(Finalheight);

                    $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                    windowheight = $(window).height();
                    $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                    $(".main").scroll(function () {
                        var currentScroll = ($("#divMain").scrollTop() - 45);
                        if ($(".main").scrollTop()) {
                            $('.scrum-content').each(function () {
                                $('.scrum-content').addClass('fixed-header');
                                $('.scrum-content').css("top", currentScroll);

                                // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                            });

                        } else {
                            $('.scrum-content').removeClass('fixed-header');
                        }
                    });
                    //Commented And Added By Usha Pandit On 18.01.2021 For issue due to jquery plugin change
                    //var DropTdId = $(this).offsetParent().context.id;
                    var DropTdId = $(this).attr("id");
                    //End Of Added By Usha Pandit On 18.01.2021 For issue due to jquery plugin change
                    var UserStoryIDArr = [];

                    var CurrentTdIDs = ["todolist", "progresslist", "completedlist"];
                    Value = document.getElementById("SprintBacklogSprint").value;
                    if (Value == "") {

                        Value = $("#hdnCurrentIterationID").val();

                    }
                    if ($("#TaskAssigntome").prop('checked')) {
                        AssignFilterChecked = "1";
                    }
                    else {
                        AssignFilterChecked = "0";
                    }
                    SprintID = Value;

                    var StrTaskID = "";
                    var CurrentTdID = ["todolist", "progresslist", "completedlist"];
                    //Commented And Added By Usha Pandit On 18.01.2021 For issue due to jquery plugin change
                    //var DropTdId = $(this).offsetParent().context.id
                    var DropTdId = $(this).attr("id");
                    //End Of Added By Usha Pandit On 18.01.2021 For issue due to jquery plugin change
                    if (StrTaskID == "") {
                        StrTaskID = $(ui.item).find("#todolisthdnTaskID").val();

                    }
                    else {

                        StrTaskID = $(ui.item).find("#todolisthdnTaskID").val();

                    }
                    var IsCompletedSprint = $("#" + String(ui.item[0].id)).attr("draggable");
                    if (IsCompletedSprint.toUpperCase() == 'FALSE') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Sprint is completed you can not drag tasks.', 'error', 20);
                        $(ui.sender).sortable('cancel');
                        return;
                    }
                    var ProjectID = document.getElementById('hdnProjectID').value;
                    var data;
                    $.ajax({
                        type: "POST",
                        url: "frmSprintBacklog.aspx/ValidateLogPersonAcessTask",
                        data: JSON.stringify({ StrTaskID: StrTaskID }),
                        dataType: "json",
                        contentType: "application/json",
                        //timeout: 180000,
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
                                            // alert(result);
                                            if (DropTdId == CurrentTdIDs[1]) {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmSprintBacklog.aspx/DropValidation",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: false,
                                                    success: function (result) {
                                                        if (result.d != "") {

                                                            //bootbox.confirm({
                                                            //message: result.d,
                                                            //buttons: {
                                                            //    cancel: {
                                                            //        label: 'No',
                                                            //        className: 'btn-danger float-end1'
                                                            //    },
                                                            //    confirm: {
                                                            //        label: 'Yes',
                                                            //        className: 'btn-success'
                                                            //    }

                                                            //},
                                                            //  callback: function (result) {

                                                            //  if (result == true) {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                //timeout: 180000,
                                                                async: false,
                                                                success: function (result) {
                                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                    //if (result.d == "1") {
                                                                    //    //End Added By Vaijat K ON 13/04/2017 

                                                                    //}
                                                                    //else {
                                                                    //    alertify.set('notifier', 'position', 'top-right');
                                                                    //    alertify.notify(result.d, 'error', 20);
                                                                    //    $(ui.sender).sortable('cancel');
                                                                    //}
                                                                    var strResult = result.d.split("||")
                                                                    if (strResult[0] != "") {

                                                                        // alertify.set('notifier', 'position', 'top-right');
                                                                        //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                        // alert(SelectedUD);
                                                                        if (SelectedUD != "") {
                                                                            filterTask_US(Object, SelectedUD)
                                                                        }
                                                                        else {
                                                                            $("#Allcardsdata").html(strResult[1]);
                                                                        }
                                                                        RefreshGrid();

                                                                    }

                                                                },
                                                                error: function (xhr, status, error) {
                                                                    console.log(xhr.responseText);

                                                                }
                                                            });
                                                            // }
                                                            //else {
                                                            //    $(ui.sender).sortable('cancel');
                                                            //    return;
                                                            //}
                                                            // }
                                                            // })
                                                        }
                                                        else {
                                                            // Update StageId
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                //timeout: 180000,
                                                                async: false,
                                                                success: function (result) {
                                                                    //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                    //if (result.d == "1") {
                                                                    //    //End Added By Vaijat K ON 13/04/2017 

                                                                    //}
                                                                    //else {
                                                                    //    alertify.set('notifier', 'position', 'top-right');
                                                                    //    alertify.notify(result.d, 'error', 20);
                                                                    //    $(ui.sender).sortable('cancel');
                                                                    //}
                                                                    var strResult = result.d.split("||")
                                                                    if (strResult[0] != "") {

                                                                        // alertify.set('notifier', 'position', 'top-right');
                                                                        //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                        if (SelectedUD != "") {
                                                                            filterTask_US(Object, SelectedUD)
                                                                        }
                                                                        else {
                                                                            $("#Allcardsdata").html(strResult[1]);
                                                                        }
                                                                        RefreshGrid();
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

                                            else if (DropTdId == CurrentTdIDs[2]) {
                                                //alert(DropTdId)
                                                $.ajax({

                                                    type: "POST",
                                                    url: "frmSprintBacklog.aspx/DropValidation",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: false,
                                                    success: function (result) {
                                                        //var arr = [];

                                                        //if (String(result.d).indexOf("$$$") == -1) {
                                                        //    arr[0] = result.d
                                                        //}
                                                        //else {
                                                        //    arr = String(result.d).split("$$$")
                                                        //}
                                                        //if (arr[1] == "1") {
                                                        if (result.d != "") {

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
                                                                            url: "frmSprintBacklog.aspx/DropValidation",
                                                                            data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            //timeout: 180000,
                                                                            async: false,
                                                                            success: function (result) {
                                                                                if (result.d != "") {

                                                                                    bootbox.confirm({
                                                                                        message: "Are you sure do you want to complete the task?",
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
                                                                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                                                    data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                                                    dataType: "json",
                                                                                                    contentType: "application/json",
                                                                                                    //timeout: 180000,
                                                                                                    async: false,
                                                                                                    success: function (result) {

                                                                                                        var strResult = result.d.split("||")
                                                                                                        if (strResult[0] != "") {

                                                                                                            // alertify.set('notifier', 'position', 'top-right');
                                                                                                            //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                                            if (SelectedUD != "") {
                                                                                                                filterTask_US(Object, SelectedUD)
                                                                                                            }
                                                                                                            else {
                                                                                                                $("#Allcardsdata").html(strResult[1]);
                                                                                                            }
                                                                                                            RefreshGrid();
                                                                                                        }
                                                                                                    },
                                                                                                    error: function (xhr, status, error) {
                                                                                                        console.log(xhr.responseText);

                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                            else {
                                                                                                //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                                                $(ui.sender).sortable('cancel');
                                                                                                return;
                                                                                                //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                                                            }
                                                                                        }
                                                                                    })
                                                                                }
                                                                                else {
                                                                                    // Update StageId
                                                                                    bootbox.confirm({
                                                                                        message: "Are you sure do you want to complete the task?",
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
                                                                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                                                    data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                                                    dataType: "json",
                                                                                                    contentType: "application/json",
                                                                                                    //timeout: 180000,
                                                                                                    async: false,
                                                                                                    success: function (result) {
                                                                                                        ////Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                                        //if (result.d == "1") {
                                                                                                        //    //End Added By Vaijat K ON 13/04/2017 

                                                                                                        //}
                                                                                                        //else {
                                                                                                        //    alertify.set('notifier', 'position', 'top-right');
                                                                                                        //    alertify.notify(result.d, 'error', 20);
                                                                                                        //    $(ui.sender).sortable('cancel');
                                                                                                        //}
                                                                                                        var strResult = result.d.split("||")
                                                                                                        if (strResult[0] != "") {

                                                                                                            // alertify.set('notifier', 'position', 'top-right');
                                                                                                            //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                                            if (SelectedUD != "") {
                                                                                                                filterTask_US(Object, SelectedUD)
                                                                                                            }
                                                                                                            else {
                                                                                                                $("#Allcardsdata").html(strResult[1]);
                                                                                                            }
                                                                                                            RefreshGrid();
                                                                                                        }
                                                                                                    },
                                                                                                    error: function (xhr, status, error) {
                                                                                                        console.log(xhr.responseText);

                                                                                                    }
                                                                                                });
                                                                                            }
                                                                                        }
                                                                                    })

                                                                                }

                                                                            }
                                                                        });

                                                                    }
                                                                    else {
                                                                        //Added By Usha Pandit On 04.07.2019 to cancel drag if No button is pressed
                                                                        $(ui.sender).sortable('cancel');
                                                                        return;
                                                                        //End Of Added By Usha Pandit On  04.07.2019 for drag cancel if No button is pressed

                                                                        //if (result.d != undefined) {
                                                                        //    alertify.set('notifier', 'position', 'top-right');
                                                                        //    alertify.notify(result.d, 'error', 20);
                                                                        //}
                                                                        //$(ui.sender).sortable('cancel');
                                                                    }
                                                                }
                                                            });
                                                        }

                                                        else {
                                                            $.ajax({
                                                                type: "POST",
                                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                                data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                //timeout: 180000,
                                                                async: false,
                                                                success: function (result) {
                                                                    if (result.d != "") {
                                                                        // alert(result.d);
                                                                        //alertify.set('notifier', 'position', 'top-right');
                                                                        //alertify.notify(result.d, 'error', 20);
                                                                        //$(ui.sender).sortable('cancel');
                                                                    }
                                                                    else {
                                                                        // Update StageId
                                                                        //debugger;
                                                                        bootbox.confirm({
                                                                            message: "Are you sure do you want to complete the task?",
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
                                                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                                        data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                                        dataType: "json",
                                                                                        contentType: "application/json",
                                                                                        //timeout: 180000,
                                                                                        async: false,
                                                                                        success: function (result) {
                                                                                            ////Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                            //if (result.d == "1") {
                                                                                            //    //End Added By Vaijat K ON 13/04/2017 

                                                                                            //}
                                                                                            //else {
                                                                                            //    alertify.set('notifier', 'position', 'top-right');
                                                                                            //    alertify.notify(result.d, 'error', 20);
                                                                                            //    $(ui.sender).sortable('cancel');
                                                                                            //}
                                                                                            var strResult = result.d.split("||")
                                                                                            if (strResult[0] != "") {

                                                                                                // alertify.set('notifier', 'position', 'top-right');
                                                                                                //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                                if (SelectedUD != "") {
                                                                                                    filterTask_US(Object, SelectedUD)
                                                                                                }
                                                                                                else {
                                                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                                                }
                                                                                                RefreshGrid();
                                                                                            }
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.log(xhr.responseText);

                                                                                        }
                                                                                    });
                                                                                }
                                                                                else {
                                                                                    //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                                    $(ui.sender).sortable('cancel');
                                                                                    return;
                                                                                    //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                                                }
                                                                            }
                                                                        })
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
                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: true,
                                                    success: function (result) {

                                                        //if (result.d == "1") {


                                                        //}
                                                        //else {
                                                        //    alertify.set('notifier', 'position', 'top-right');
                                                        //    alertify.notify(result.d, 'error', 20);
                                                        //    alert();
                                                        //    return;
                                                        //}
                                                        var strResult = result.d.split("||")
                                                        if (strResult[0] != "") {

                                                            // alertify.set('notifier', 'position', 'top-right');
                                                            //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                            if (SelectedUD != "") {
                                                                filterTask_US(Object, SelectedUD)
                                                            }
                                                            else {
                                                                $("#Allcardsdata").html(strResult[1]);
                                                            }
                                                            RefreshGrid();
                                                        }
                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.log(xhr.responseText);

                                                    }
                                                });
                                            }
                                        }
                                        //End if drop is not a custom stage


                                        else {
                                            $(ui.sender).sortable('cancel');
                                            return;
                                        }
                                    }
                                })
                            }///////

                            else {
                                if (DropTdId == CurrentTdIDs[1]) {
                                    $.ajax({
                                        type: "POST",
                                        url: "frmSprintBacklog.aspx/DropValidation",
                                        data: JSON.stringify({ StrTaskID: StrTaskID }),
                                        dataType: "json",
                                        contentType: "application/json",
                                        //timeout: 180000,
                                        async: false,
                                        success: function (result) {
                                            if (result.d != "") {

                                                //bootbox.confirm({
                                                //message: result.d,
                                                //buttons: {
                                                //    cancel: {
                                                //        label: 'No',
                                                //        className: 'btn-danger float-end1'
                                                //    },
                                                //    confirm: {
                                                //        label: 'Yes',
                                                //        className: 'btn-success'
                                                //    }

                                                //},
                                                //  callback: function (result) {

                                                //  if (result == true) {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: false,
                                                    success: function (result) {
                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                        //if (result.d == "1") {
                                                        //    //End Added By Vaijat K ON 13/04/2017 

                                                        //}
                                                        //else {
                                                        //    alertify.set('notifier', 'position', 'top-right');
                                                        //    alertify.notify(result.d, 'error', 20);
                                                        //    $(ui.sender).sortable('cancel');
                                                        //}
                                                        var strResult = result.d.split("||")
                                                        if (strResult[0] != "") {

                                                            // alertify.set('notifier', 'position', 'top-right');
                                                            //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                            // alert(SelectedUD);
                                                            if (SelectedUD != "") {
                                                                filterTask_US(Object, SelectedUD)
                                                            }
                                                            else {
                                                                $("#Allcardsdata").html(strResult[1]);
                                                            }
                                                            RefreshGrid();

                                                        }

                                                    },
                                                    error: function (xhr, status, error) {
                                                        console.log(xhr.responseText);

                                                    }
                                                });
                                                // }
                                                //else {
                                                //    $(ui.sender).sortable('cancel');
                                                //    return;
                                                //}
                                                // }
                                                // })
                                            }
                                            else {
                                                // Update StageId
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "2", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: false,
                                                    success: function (result) {
                                                        //Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                        //if (result.d == "1") {
                                                        //    //End Added By Vaijat K ON 13/04/2017 

                                                        //}
                                                        //else {
                                                        //    alertify.set('notifier', 'position', 'top-right');
                                                        //    alertify.notify(result.d, 'error', 20);
                                                        //    $(ui.sender).sortable('cancel');
                                                        //}
                                                        var strResult = result.d.split("||")
                                                        if (strResult[0] != "") {

                                                            // alertify.set('notifier', 'position', 'top-right');
                                                            //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                            if (SelectedUD != "") {
                                                                filterTask_US(Object, SelectedUD)
                                                            }
                                                            else {
                                                                $("#Allcardsdata").html(strResult[1]);
                                                            }
                                                            RefreshGrid();
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

                                else if (DropTdId == CurrentTdIDs[2]) {
                                    //alert(DropTdId)
                                    $.ajax({

                                        type: "POST",
                                        url: "frmSprintBacklog.aspx/DropValidation",
                                        data: JSON.stringify({ StrTaskID: StrTaskID }),
                                        dataType: "json",
                                        contentType: "application/json",
                                        //timeout: 180000,
                                        async: false,
                                        success: function (result) {
                                            //var arr = [];

                                            //if (String(result.d).indexOf("$$$") == -1) {
                                            //    arr[0] = result.d
                                            //}
                                            //else {
                                            //    arr = String(result.d).split("$$$")
                                            //}
                                            //if (arr[1] == "1") {
                                            if (result.d != "") {

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
                                                                url: "frmSprintBacklog.aspx/DropValidation",
                                                                data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                                dataType: "json",
                                                                contentType: "application/json",
                                                                //timeout: 180000,
                                                                async: false,
                                                                success: function (result) {
                                                                    if (result.d != "") {

                                                                        bootbox.confirm({
                                                                            message: "Are you sure do you want to complete the task?",
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
                                                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                                        data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                                        dataType: "json",
                                                                                        contentType: "application/json",
                                                                                        //timeout: 180000,
                                                                                        async: false,
                                                                                        success: function (result) {

                                                                                            var strResult = result.d.split("||")
                                                                                            if (strResult[0] != "") {

                                                                                                // alertify.set('notifier', 'position', 'top-right');
                                                                                                //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                                if (SelectedUD != "") {
                                                                                                    filterTask_US(Object, SelectedUD)
                                                                                                }
                                                                                                else {
                                                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                                                }
                                                                                                RefreshGrid();
                                                                                            }
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.log(xhr.responseText);

                                                                                        }
                                                                                    });
                                                                                }
                                                                                else {
                                                                                    //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                                    $(ui.sender).sortable('cancel');
                                                                                    return;
                                                                                    //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                                }
                                                                            }
                                                                        })
                                                                    }
                                                                    else {
                                                                        // Update StageId
                                                                        bootbox.confirm({
                                                                            message: "Are you sure do you want to complete the task?",
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
                                                                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                                        data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                                        dataType: "json",
                                                                                        contentType: "application/json",
                                                                                        //timeout: 180000,
                                                                                        async: false,
                                                                                        success: function (result) {
                                                                                            ////Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                            //if (result.d == "1") {
                                                                                            //    //End Added By Vaijat K ON 13/04/2017 

                                                                                            //}
                                                                                            //else {
                                                                                            //    alertify.set('notifier', 'position', 'top-right');
                                                                                            //    alertify.notify(result.d, 'error', 20);
                                                                                            //    $(ui.sender).sortable('cancel');
                                                                                            //}
                                                                                            var strResult = result.d.split("||")
                                                                                            if (strResult[0] != "") {

                                                                                                // alertify.set('notifier', 'position', 'top-right');
                                                                                                //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                                if (SelectedUD != "") {
                                                                                                    filterTask_US(Object, SelectedUD)
                                                                                                }
                                                                                                else {
                                                                                                    $("#Allcardsdata").html(strResult[1]);
                                                                                                }
                                                                                                RefreshGrid();
                                                                                            }
                                                                                        },
                                                                                        error: function (xhr, status, error) {
                                                                                            console.log(xhr.responseText);

                                                                                        }
                                                                                    });
                                                                                }
                                                                            }
                                                                        })

                                                                    }

                                                                }
                                                            });

                                                        }
                                                        else {
                                                            //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                            $(ui.sender).sortable('cancel');
                                                            return;
                                                            //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                            //if (result.d != undefined) {
                                                            //    alertify.set('notifier', 'position', 'top-right');
                                                            //    alertify.notify(result.d, 'error', 20);
                                                            //}
                                                            //$(ui.sender).sortable('cancel');
                                                        }
                                                    }
                                                });
                                            }

                                            else {
                                                $.ajax({
                                                    type: "POST",
                                                    url: "frmSprintBacklog.aspx/DropValidation",
                                                    data: JSON.stringify({ StrTaskID: StrTaskID }),
                                                    dataType: "json",
                                                    contentType: "application/json",
                                                    //timeout: 180000,
                                                    async: false,
                                                    success: function (result) {
                                                        if (result.d != "") {
                                                            // alert(result.d);
                                                            //alertify.set('notifier', 'position', 'top-right');
                                                            //alertify.notify(result.d, 'error', 20);
                                                            //$(ui.sender).sortable('cancel');
                                                        }
                                                        else {
                                                            // Update StageId
                                                            //debugger;
                                                            bootbox.confirm({
                                                                message: "Are you sure do you want to complete the task?",
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
                                                                            url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                                                            data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "3", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                                                            dataType: "json",
                                                                            contentType: "application/json",
                                                                            //timeout: 180000,
                                                                            async: false,
                                                                            success: function (result) {
                                                                                ////Added By Vaijat K ON 13/04/2017 For Validation of completed sprint

                                                                                //if (result.d == "1") {
                                                                                //    //End Added By Vaijat K ON 13/04/2017 

                                                                                //}
                                                                                //else {
                                                                                //    alertify.set('notifier', 'position', 'top-right');
                                                                                //    alertify.notify(result.d, 'error', 20);
                                                                                //    $(ui.sender).sortable('cancel');
                                                                                //}
                                                                                var strResult = result.d.split("||")
                                                                                if (strResult[0] != "") {

                                                                                    // alertify.set('notifier', 'position', 'top-right');
                                                                                    //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                                                    if (SelectedUD != "") {
                                                                                        filterTask_US(Object, SelectedUD)
                                                                                    }
                                                                                    else {
                                                                                        $("#Allcardsdata").html(strResult[1]);
                                                                                    }
                                                                                    RefreshGrid();
                                                                                }
                                                                            },
                                                                            error: function (xhr, status, error) {
                                                                                console.log(xhr.responseText);

                                                                            }
                                                                        });
                                                                    }
                                                                    else {
                                                                        //Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed
                                                                        $(ui.sender).sortable('cancel');
                                                                        return;
                                                                        //End Of Added By Usha Pandit On 18.01.2021 to cancel drag if No button is pressed

                                                                    }
                                                                }
                                                            })
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
                                        url: "frmSprintBacklog.aspx/UpdateTaskDetails",
                                        data: JSON.stringify({ StrTaskID: StrTaskID, StageID: "1", SprintID: SprintID, AssignFilterChecked: AssignFilterChecked }),
                                        dataType: "json",
                                        contentType: "application/json",
                                        //timeout: 180000,
                                        async: true,
                                        success: function (result) {

                                            //if (result.d == "1") {


                                            //}
                                            //else {
                                            //    alertify.set('notifier', 'position', 'top-right');
                                            //    alertify.notify(result.d, 'error', 20);
                                            //    alert();
                                            //    return;
                                            //}
                                            var strResult = result.d.split("||")
                                            if (strResult[0] != "") {

                                                // alertify.set('notifier', 'position', 'top-right');
                                                //alertify.notify('Task Dragged to Completed Successfully', 'success');
                                                if (SelectedUD != "") {
                                                    filterTask_US(Object, SelectedUD)
                                                }
                                                else {
                                                    $("#Allcardsdata").html(strResult[1]);
                                                }
                                                RefreshGrid();
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            console.log(xhr.responseText);

                                        }
                                    });
                                }



                            }
                        }
                    })

                },
                cancel: ".nodrop",

            }).disableSelection();
            serachFilter();
            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".taskname").tooltip();

            if ($("#hdncheckData").val() == 1) {
                $("#clsdivus").css("overflow", "auto");
                $("#clsdivus").css("height", "auto");
            }
            else { }


            if ($("#hdncheckDataTodolist").val() == 1) {
                var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                console.log(Comapreheight);

                console.log(Finalheight);

                $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                windowheight = $(window).height();
                $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                $(".main").scroll(function () {
                    var currentScroll = ($("#divMain").scrollTop() - 45);
                    if ($(".main").scrollTop()) {
                        $('.scrum-content').each(function () {
                            $('.scrum-content').addClass('fixed-header');
                            $('.scrum-content').css("top", currentScroll);

                            // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                        });

                    } else {
                        $('.scrum-content').removeClass('fixed-header');
                    }
                });
            }
            else { }

            if ($("#hdncheckDataInprogress").val() == 1) {
                var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                console.log(Comapreheight);

                console.log(Finalheight);

                $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                windowheight = $(window).height();
                $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                $(".main").scroll(function () {
                    var currentScroll = ($("#divMain").scrollTop() - 45);
                    if ($(".main").scrollTop()) {
                        $('.scrum-content').each(function () {
                            $('.scrum-content').addClass('fixed-header');
                            $('.scrum-content').css("top", currentScroll);

                            // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                        });

                    } else {
                        $('.scrum-content').removeClass('fixed-header');
                    }
                });
            }
            else { }

            if ($("#hdncheckCompleted").val() == 1) {
                var Comapreheight = ($('#todolist').height() > $('#progresslist').height()) ? $('#todolist').height() : $('#progresslist').height()
                var Finalheight = ($('#completedlist').height() > Comapreheight) ? $('#completedlist').height() : Comapreheight
                console.log(Comapreheight);

                console.log(Finalheight);

                $('#progresslist,#todolist,#completedlist').css('height', Finalheight);
                windowheight = $(window).height();
                $(".main").css({ "height": windowheight, "overflow-y": "auto" });

                $(".main").scroll(function () {
                    var currentScroll = ($("#divMain").scrollTop() - 45);
                    if ($(".main").scrollTop()) {
                        $('.scrum-content').each(function () {
                            $('.scrum-content').addClass('fixed-header');
                            $('.scrum-content').css("top", currentScroll);

                            // $('.scrum-content').css("top", ""+(currentScroll + 20)+"");
                        });

                    } else {
                        $('.scrum-content').removeClass('fixed-header');
                    }
                });
            }
            else { }

        }


        function ExpandCollapse(Divid, TooltipDiv) {

            //if ($("#" + Divid).hasClass('in')) {


            //}
            //else {
            //    $("#" + TooltipDiv)
            //}

        }

        function AutoResizeTextArea() {
            jQuery.each(jQuery('textarea[data-autoresize]'), function () {
                var offset = this.offsetHeight - this.clientHeight;

                var resizeTextarea = function (el) {
                    jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
                };
                jQuery(this).on('keyup input', function () {
                    // if ($(this).attr("id") == "txtTaskNotes") {
                    //   Maxlength(this, "countTaskNote", 1000);
                    //}
                    //if ($(this).attr("id") == "txtFeatureName") {
                    //    Maxlength(this, "countdownFN", 200);
                    //}

                    //if ($(this).attr("id") == "txtSubStoryDesc") {
                    //    Maxlength(this, "countSubUSdown", 1000);
                    //}

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
        function getRows() {
            //alert(document.getElementById('txtFeatureName').value.split("\n").length);
            if ($("#txtTaskNotes").val() != undefined) {
                var str2 = document.getElementById("txtTaskNotes").value;
                str2 = str2.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
                document.getElementById("txtTaskNotes").value = str2;
                var lineheight = document.getElementById("txtTaskNotes").value.split("\n").length + 2;
                var height = document.getElementById("txtTaskNotes").rows = lineheight;

                $("#txtTaskNotes").attr("style", "height: auto !important");
            }


        }




        var isValid = 0; saveFlag = 0;
        function validateAssignFormTask() {
            //  debugger;
            var checkFlag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var dtAssignStartDate = "", dtAssignEndDate = "";
            var ProjectID = document.getElementById('hdnProjectID').value;

            dtAssignStartDate = document.getElementsByName("dtStartDateAssigntask");
            dtAssignEndDate = document.getElementsByName("dtEndDateAssigntask");

            if ($("#AssigntxtTaskName").val() == "") {
                strmsg = '- Task Name should not left blank.';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtTaskName").focus();
            }


            if ($("#cboAssignResources").val() == "0") {
                strmsg = '- Resource should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#cboAssignResources").focus();
            }


            if ($("#AssigntxtWorkHrs").val() == "") {
                strmsg = '- Work(Hrs) should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                $("#AssigntxtWorkHrs").focus();
            }


            if ($("#AssigntxtWorkHrs").val() != "") {
                if (RestrictNonNumeric(document.getElementById('AssigntxtWorkHrs')) == true) {


                    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }

                else if (($("#AssigntxtWorkHrs").val() - 0) == 0) {

                    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;

                }

                else if (parseFloat($("#AssigntxtWorkHrs").val()) < 0 && $("#AssigntxtWorkHrs").val() != '') {

                    strmsg = '- Please enter positive Value For  Work(Hrs)';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#AssigntxtWorkHrs").focus();

                }


            }



            if ($("#dtStartDateAssigntask").val() == "") {
                strmsg = '- Start Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#dtEndDateAssigntask").val() == "") {
                strmsg = '- End Date should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            //if ($("#dtEndDateAssigntask").val() != '' && $("#dtStartDateAssigntask").val() != '') {
            //    if (CompairDates(dtAssignStartDate, dtAssignEndDate) == 1) {
            //        strmsg = '- Task Start date should not be less than Task End date';
            //        errorMsg += "<li>" + strmsg + "</li></br>";
            //        Flag = 1;
            //        checkFlag = 1;
            //        $("#dtEndDateAssigntask").focus();

            //    }
            //}
            //debugger;
            if ($("#dtStartDateAssigntask").val() != '' && $("#dtEndDateAssigntask").val() != '' && checkFlag == 0) {
                if (CompairDates1($("#dtStartDateAssigntask").val(), $("#dtEndDateAssigntask").val()) == 1 && CompairDates1($("#dtStartDateAssigntask").val(), $("#dtEndDateAssigntask").val()) != 0) {
                    // $('#dtEndDate').css('border-color', 'red');
                    // $('#dtEndDate').css('border-width', '1px');
                    strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
                    errorMsg += "<li>" + strmsg + "</li></br>";

                    // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
                    if (checkFlag != 1) {
                        //objEndDate.focus()
                    }
                    isValid = 1;
                    checkFlag = 1;
                }
            }


            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: ProjectID, StartDate: $("#dtStartDateAssigntask").val(), EndDate: $("#dtEndDateAssigntask").val() });
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



            if ($("#dtEndDateAssigntask").val() != '') {
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: document.getElementById('cboUserStory').value, strStartDate: $("#dtStartDateAssigntask").val(), strEndDate: $("#dtEndDateAssigntask").val() }), false);
                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        // $('#spndtStartDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    else {
                        //$('#spndtEndDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "<li>" + strmsg + "</li></br>";

                    }
                    isValid = 1;
                    checkFlag = 1;
                }
            }
            if ($("#AssigntaskcboPriorities").val() == "") {
                strmsg = '- Priority should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#AssigntaskcboTaskType").val() == "") {
                strmsg = '- Task Type should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#cboUserStory").val() == "") {
                strmsg = '- User Story should not left blank';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if ($("#AssigntxtStoryPoints").val() != "") {
                if (RestrictNonNumeric(document.getElementById('AssigntxtStoryPoints')) == true) {


                    strmsg = '- Please Enter only positive numeric value For Story Point';
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    isValid = 1;
                    checkFlag = 1;
                }
                else {
                    var n = $("#AssigntxtStoryPoints").val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }



            }

            if ($("#AssigntxtStoryPoints").val() == "0") {


                strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }


            //debugger;
            if (checkFlag == 0) {
                var TaskID = globaltaskid;
                if ($("#AssigntxtStoryPoints").val() != "") {
                    var data = JSON.stringify({ UserStoryID: globalUSID, StoryPoints: $("#AssigntxtStoryPoints").val(), TaskID: TaskID });
                    var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                    // alert(Newresult.d);
                    if (Newresult.d != '') {
                        strmsg = Newresult.d;
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#AssigntxtStoryPoints").focus();
                    }
                }
            }


            var objPhase = document.getElementById('cboPhase');
            var objModule = document.getElementById('cboModule');
            var objSubProject = document.getElementById('cboSubProject');
            var objMilestone = document.getElementById('cboMilestone');
            var objChangeRequest = document.getElementById('cboChangeRequest');
            var objDeliverable = document.getElementById('cboDeliverable');

            //debugger;
            if (objPhase != null) {
                if (objPhase.getAttribute("Mandatory") == "1") {
                    if (objPhase.value == '') {
                        //  objPhase1.css('border-color', 'red');
                        // objPhase1.css('border-width', '1px');
                        // $('#spnPhase').text('Phase should not left blank !');
                        strmsg = '- Phase should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;


                    }
                }
            }

            if (objModule != null) {
                if (objModule.getAttribute("Mandatory") == "1") {
                    if (objModule.value == '') {
                        //objModule1.css('border-color', 'red');
                        //objModule1.css('border-width', '1px');
                        //$('#spnModule').text('Module should not left blank !');

                        strmsg = '- Module should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }

            if (objSubProject != null) {
                if (objSubProject.getAttribute("Mandatory") == "1") {
                    if (objSubProject.value == '') {
                        // objSubProject1.css('border-color', 'red');
                        // objSubProject1.css('border-width', '1px');
                        // $('#spnSubProject').text('Sub Project should not left blank !');

                        //if (checkFlag != 1) {
                        //   objSubProject.focus()
                        //}
                        //checkFlag = 1;
                        strmsg = '- Sub Project should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }
            if (objMilestone != null) {
                if (objMilestone.getAttribute("Mandatory") == "1") {
                    if (objMilestone.value == '') {
                        // objMilestone1.css('border-color', 'red');
                        // objMilestone1.css('border-width', '1px');
                        // $('#spnMilestone').text('Milestone should not left blank !');

                        // if (checkFlag != 1) {
                        //     objMilestone.focus()
                        // }
                        //checkFlag = 1;
                        strmsg = '- Milestone should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }
            }

            if (objChangeRequest != null) {
                if (objChangeRequest.getAttribute("Mandatory") == "1") {
                    if (objChangeRequest.value == '') {
                        //objChangeRequest1.css('border-color', 'red');
                        //objChangeRequest1.css('border-width', '1px');
                        // $('#spnChangeRequest').text('Change Request should not left blank !');

                        //if (checkFlag != 1) {
                        //    objChangeRequest.focus()
                        //}
                        strmsg = '- Change Request should not left blank.'
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        isValid = 1;
                        checkFlag = 1;
                        //checkFlag = 1;
                    }
                }
            }

            if (($('#txtRelease') == "" || $('#txtIteration')) == "") {
                // $('#spnUserStory').text('Task cannot be created, As UserStory is not mapped to iteration or release!.');
                // document.getElementById('cboUserStory').focus()
                strmsg = '- Task cannot be created, As UserStory is not mapped to iteration or release.'
                errorMsg += "<li>" + strmsg + "</li></br>";
                isValid = 1;
                checkFlag = 1;
            }

            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 15);

            }
            return checkFlag;
            return isValid;

        }

        function UpdateTask() {
            if (validateAssignFormTask() == 0) {
                //alert(SprintID);

                saveFlag = 1;
                if (saveFlag == 1) {

                    // $("#updbtn0").css("display", "none");

                }
                // debugger;
                var TaskID = globaltaskid;//$("#hdnTaskID").val();
                // alert(globaltaskid);
                var BillableValue, USID, StoryPoints, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;
                var objTaskName = $('#AssigntxtTaskName');
                var objResource = $('#cboAssignResources');
                var objTaskType = $('#AssigntaskcboTaskType').val();
                var objWorkHrs = $('#AssigntxtWorkHrs');
                var objStartDate = $('#dtStartDateAssigntask');
                var objEndDate = $('#dtEndDateAssigntask');
                var objPriorities = $('#AssigntaskcboPriorities');
                var objBillable = $('#chkBillable');
                var objHold = $('#chkHold');
                var Objtasknote = $('#txtTaskNotes').val();
                var objPhase = document.getElementById('cboPhase');
                var objModule = document.getElementById('cboModule');
                var objSubProject = document.getElementById('cboSubProject');
                var objMilestone = document.getElementById('cboMilestone');
                var objChangeRequest = document.getElementById('cboChangeRequest');
                var objDeliverable = document.getElementById('cboDeliverable');

                if (objBillable[0].checked == true) {
                    BillableValue = "1"
                }
                else {
                    BillableValue = "0"
                }

                if (objHold[0].checked == true) {
                    OnHoldValue = "1"
                }
                else {
                    OnHoldValue = "0"
                }




                var PracticeID = 0;
                var extraPara = [];
                extraPara.push(TaskID);
                StoryPoints = $("#AssigntxtStoryPoints").val();


                if (StoryPoints == "") {
                    StoryPoints = 0
                } else {
                    StoryPoints = StoryPoints;
                }
                if (objPhase != null) {
                    PhaseVal = objPhase.value;
                }
                else {
                    PhaseVal = 0
                }

                if (objModule != null) {
                    ModuleVal = objModule.value;
                }
                else {
                    ModuleVal = 0
                }
                if (objSubProject != null) {
                    SubProjectVal = objSubProject.value;
                }
                else {
                    SubProjectVal = 0
                }
                if (objMilestone != null) {
                    MilestoneVal = objMilestone.value;
                }
                else {
                    MilestoneVal = 0
                }
                if (objChangeRequest != null) {
                    ChangeRequestVal = objChangeRequest.value;
                }
                else {
                    ChangeRequestVal = 0
                }
                if (objDeliverable != null) {
                    DeliverableVal = objDeliverable.value;
                }
                else {
                    DeliverableVal = 0
                }

                if (PhaseVal == '')
                    PhaseVal = 0

                if (ModuleVal == '')
                    ModuleVal = 0

                if (SubProjectVal == '')
                    SubProjectVal = 0

                if (MilestoneVal == '')
                    MilestoneVal = 0

                if (ChangeRequestVal == '')
                    ChangeRequestVal = 0

                if (DeliverableVal == '')
                    DeliverableVal = 0


                var URL, data;



                USID = globalUSID;


                URL = 'frmSprintBacklog.aspx/SaveTask';

                var AssignTaskData = [];

                AssignTaskData.push({
                    TaskID: TaskID,
                    TaskName: objTaskName.val(), EmployeeID: objResource.val(), WorkHrs: objWorkHrs.val(), StartDate: objStartDate.val(), EndDate: objEndDate.val(),
                    Priority: objPriorities.val(), TaskType: objTaskType, Billable: BillableValue, Hold: OnHoldValue, PhaseVal: PhaseVal, ModuleVal: ModuleVal, SubProjectVal: SubProjectVal,
                    MilestoneVal: MilestoneVal, ChangeRequestVal: ChangeRequestVal, DeliverableVal: DeliverableVal, strProjectID: $("#hdnProjectID").val(), PracticeID: PracticeID,
                    UserStoryID: USID, strEntity: "", StoryPoints: StoryPoints, Objtasknote: Objtasknote
                });
                if (SprintID == "") {

                    SprintID = document.getElementById("SprintBacklogSprint").value
                }
                else {

                    SprintID = SprintID;
                }


                data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: USID, SprintID: SprintID, flag: flag });

                AJAXCallWithPara(URL, data, AfterUpdateTask, extraPara);


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

        function AfterUpdateTask(data, extraPara) {
            var Id = extraPara[0];
            // alert(data.d);
            //var strProjectID = document.getElementById('hdnProjectID').value;
            document.getElementById("Allcardsdata").innerHTML = data.d;

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Updated successfully', 'success', 25);
            //// document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px'
            $('[data-bs-toggle="tooltip"]').tooltip();
            isValid = 0;
            saveFlag = 0;
            ///$("#updbtn0").css("display", "block");
            AutoResizeTextArea();
            RemoveTextArea();
            //$('#txtEndDate').datepicker();
            //$('#txtStartDate').datepicker();
            RefreshGrid();



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

        function CompairDates1(obj1, Obj2) {
            var date1 = obj1;
            var date2 = Obj2;
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
        function isBlank(val) {
            if (val == null) { return true; }
            for (var i = 0; i < val.length; i++) {
                if ((val.charAt(i) != ' ') && (val.charAt(i) != "\t") && (val.charAt(i) != "\n") && (val.charAt(i) != "\r")) { return false; }
            }
            return true;
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

        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: async,
                success: function (result) {
                    AjaxResult = result;

                },
                error: function (error) {
                    // alert(Error);
                }
            });

            return AjaxResult;
        }

    </script>


</body>
</html>
