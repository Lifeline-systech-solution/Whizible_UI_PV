
<script>
    var intDivGridListHeight, dragUserStoryD = '', ReleaseID = '';
$(document).ready(function () {
    $('.fa').tooltip();
    $('span').tooltip();
    $('p').tooltip();
        
    $(".clsrightdiv").sortable({
        connectWith: ".clsrightdiv ",
        scroll: true,
        cursor: "move",
        opacity: 0.7,
    });

    $('.clsrightdiv .card:not(.DivDetailss)').hover(function () {
        $(this).css("border", "2px solid lightgray");
        $(this).css("box-shadow", "2px 5px lightgray");
    }, function () {
        $(this).css("box-shadow", "");
        $(this).css("border", "");
    });


    $(".clsrightdiv").sortable({
        connectWith: ".clsrightdiv",
        placeholder: "ui-state-highlight",
        activate: function (ev, ui) {
             
        },
        update: function (event, ui) {
            var strIterationID = "";
            var label = "", ReleaseID = 0;
               
            // alert(display1);
            if (ui.sender == null)
            {
                //debugger;
                $('.lblIDS').each(function () {
                    label = label + $(this).text() + ',';
                    alert(label);

                });
            }
            else
            {
                alert("Another");
                //debugger;
                var getDivID = $(this).attr('id');
                if (getDivID == "RightDiv") {
                    ReleaseID = 74;
                }
                else 
                {
                    ReleaseID = 0;
                }

                alert(ReleaseID);
                if (strIterationID == "") {
                    strIterationID = $(ui.item).find("#hdnhdnIterationID").val();
                }
                else {
                    strIterationID += "," + $(ui.item).find("#hdnhdnIterationID").val();
                }
                var ProjectID = document.getElementById('hdnProjectID').value;
                      
                if (ui.sender != null)
                {
                    if (strIterationID != undefined) {
                        if (getDivID == "RightDiv") {
                            $.ajax({
                                url: "frmReleasePlanning.aspx/CheckReleaseDates",
                                data: JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID, strProjectID: ProjectID }),
                                type: "POST",
                                contentType: "application/json;charset-utf=8",
                                dataType: "json",
                                success: function (result) {
                                    var strTextReleaseStartDate;
                                    var strTextReleaseEndDate;
                                    var strTextisValid;
                                    var strText;
                                    var arrStr;
                                    strText = String(result.d);
                                    arrStr = strText.split(",");
                                    strTextisValid = arrStr[0];
                                    strTextReleaseStartDate = arrStr[1];
                                    strTextReleaseEndDate = arrStr[2];
                                    //     alert(arrStr[4]);
                                    if (arrStr[4] == 1) {
                                        //ShowPopup("ITERATIONMAPPING");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('ITERATIONMAPPING.', 'error');
                                        $(ui.sender).sortable("cancel");
                                        return;
                                    }

                                    if (arrStr[5] == "Sprint Cancelled") {
                                        //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Selected sprint is cancelled, you can not map cancelled sprint to release.', 'error');
                                        return;
                                    }

                                    if (arrStr[6] == "1") {
                                        // ShowPopup("Release is already started, you can not map sprint to release.");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                                        return;
                                    }

                                    else if (strTextisValid == 0) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Start Date and End Date should be between Release Datesi.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                                        // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                                        $(ui.sender).sortable("cancel");
                                        return;
                                    }

                                    data = JSON.stringify({ strIterationID: strIterationID, ReleaseID: ReleaseID });
                                    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/MapSprintToRelease", data, false);
                                    var Result = strResult.d.split("||")
                                    if (Result[0] != "") {

                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Sprint Mapped to Release successfully', 'success');
                                        $("#MainDiv").html(Result[1]);
                                        refresh();

                                    }
                                }
                            });
                        }
                        else
                        {
                            var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID }), false);
                            if (strResult.d == "2") {
                                // obj.disabled=true;

                                var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: strIterationID, strRemark: "", ReleaseID: ReleaseID }), false);
                                if (result.d != "") {
                                    var ResultLefdiv = result.d.split("||")
                                    //alert(ResultLefdiv[1]);
                                    $("#MainDiv").html("");
                                    $("#MainDiv").html(ResultLefdiv[1]);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Sprint UnMapped to Release successfully', 'success');
                                    // $("#Remark").modal("hide");
                                    refresh();
                                }
                                // GetIterationData(iterationID);
                            }
                            else if (strResult.d == "1") {
                                // ShowPopup("Release is released.You can not terminate Sprint.");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify('Release is released.You can not terminate Sprint.', 'error');

                            }
                            else if (strResult.d == "3") {
                                //ShowPopup("You can not terminate Sprint.");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify('You can not terminate Sprint', 'error');
                            }
                            else {
                                //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
                            }
                        }
                                  
                    }

                    else {

                        $(this).sortable("cancel");
                    }

                } 
            }

        },
        cancel: "#DivDetailss"
    });
    $(".clsrightdiv").disableSelection();
    intDivGridListHeight = parseInt(window.innerHeight);
    $(".vl").css('height', intDivGridListHeight + 350 + 'px');
    $(".vl1").css('height', intDivGridListHeight + 350 + 'px');

});

//For Refresh
function refresh() {

    $(".clsrightdiv").sortable({
        connectWith: ".clsrightdiv ",
        scroll: true,
        cursor: "move",
        opacity: 0.7,
    });

       
    $('.clsrightdiv .card:not(.DivDetailss)').hover(function () {
        $(this).css("border", "2px solid lightgray");
        $(this).css("box-shadow", "2px 5px lightgray");
    }, function () {
        $(this).css("box-shadow", "");
        $(this).css("border", "");
    });



    $(".clsrightdiv").sortable({
        connectWith: ".clsrightdiv",
        placeholder: "ui-state-highlight",
        activate: function (ev, ui) {

        },
        update: function (event, ui) {
            var strIterationID = "";
            var label = "", ReleaseID = 0;

            // alert(display1);
            if (ui.sender == null) {
                //debugger;
                $('.lblIDS').each(function () {
                    label = label + $(this).text() + ',';
                    alert(label);

                });
            }
            else {
                alert("Another");
                //debugger;
                var getDivID = $(this).attr('id');
                if (getDivID == "RightDiv") {
                    ReleaseID = 74;
                }
                else {
                    ReleaseID = 0;
                }

                alert(ReleaseID);
                if (strIterationID == "") {
                    strIterationID = $(ui.item).find("#hdnhdnIterationID").val();
                }
                else {
                    strIterationID += "," + $(ui.item).find("#hdnhdnIterationID").val();
                }
                var ProjectID = document.getElementById('hdnProjectID').value;

                if (ui.sender != null) {
                    if (strIterationID != undefined) {
                        if (getDivID == "RightDiv") {
                            $.ajax({
                                url: "frmReleasePlanning.aspx/CheckReleaseDates",
                                data: JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID, strProjectID: ProjectID }),
                                type: "POST",
                                contentType: "application/json;charset-utf=8",
                                dataType: "json",
                                success: function (result) {
                                    var strTextReleaseStartDate;
                                    var strTextReleaseEndDate;
                                    var strTextisValid;
                                    var strText;
                                    var arrStr;
                                    strText = String(result.d);
                                    arrStr = strText.split(",");
                                    strTextisValid = arrStr[0];
                                    strTextReleaseStartDate = arrStr[1];
                                    strTextReleaseEndDate = arrStr[2];
                                    //     alert(arrStr[4]);
                                    if (arrStr[4] == 1) {
                                        //ShowPopup("ITERATIONMAPPING");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('ITERATIONMAPPING.', 'error');
                                        $(ui.sender).sortable("cancel");
                                        return;
                                    }

                                    if (arrStr[5] == "Sprint Cancelled") {
                                        //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Selected sprint is cancelled, you can not map cancelled sprint to release.', 'error');
                                        return;
                                    }

                                    if (arrStr[6] == "1") {
                                        // ShowPopup("Release is already started, you can not map sprint to release.");
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                                        return;
                                    }

                                    else if (strTextisValid == 0) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Start Date and End Date should be between Release Datesi.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                                        // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                                        $(ui.sender).sortable("cancel");
                                        return;
                                    }

                                    data = JSON.stringify({ strIterationID: strIterationID, ReleaseID: ReleaseID });
                                    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/MapSprintToRelease", data, false);
                                    var Result = strResult.d.split("||")
                                    if (Result[0] != "") {

                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.notify('Sprint Mapped to Release successfully', 'success');
                                        $("#MainDiv").html(Result[1]);
                                        refresh();

                                    }
                                }
                            });
                        }
                        else {
                            var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: strIterationID, strReleaseID: ReleaseID }), false);
                            if (strResult.d == "2") {
                                // obj.disabled=true;

                                var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: strIterationID, strRemark: "", ReleaseID: ReleaseID }), false);
                                if (result.d != "") {
                                    var ResultLefdiv = result.d.split("||")
                                    //alert(ResultLefdiv[1]);
                                    $("#MainDiv").html("");
                                    $("#MainDiv").html(ResultLefdiv[1]);
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.notify('Sprint UnMapped to Release successfully', 'success');
                                    // $("#Remark").modal("hide");
                                    refresh();
                                }
                                // GetIterationData(iterationID);
                            }
                            else if (strResult.d == "1") {
                                // ShowPopup("Release is released.You can not terminate Sprint.");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify('Release is released.You can not terminate Sprint.', 'error');

                            }
                            else if (strResult.d == "3") {
                                //ShowPopup("You can not terminate Sprint.");
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.notify('You can not terminate Sprint', 'error');
                            }
                            else {
                                //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
                            }
                        }

                    }

                    else {

                        $(this).sortable("cancel");
                    }

                }
            }

        },
        cancel: "#DivDetailss"
    });
    $(".clsrightdiv").disableSelection();
      
      
    intDivGridListHeight = parseInt(window.innerHeight);
    $(".vl").css('height', intDivGridListHeight + 350 + 'px');
    $(".vl1").css('height', intDivGridListHeight + 350 + 'px');
                
    
    $('.fa').tooltip();
    $('span').tooltip();
    $('p').tooltip();
        
 


}
   
//For Showwing All Release List
function ShowAllReleaseList() {
    var strResult, data;
    data = JSON.stringify({});
    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/ReleaseList", data, false);
       
    if (strResult.d != '') {
        $("#Idheader").html("Release")
        $("#DivRleaselist").modal('show');
        $("#divListdetails").html(strResult.d);
    }

}

//For Remark Validation
function CheckTextLength(obj, lbl, span) {
    var MaxLength = obj.getAttribute("maxlength");

    if (parseInt(String(obj.value).length) >= MaxLength) {
        $("#" + span).text("you can enter only " + MaxLength + " characters.");
    }
    else {
        $("#" + span).text("");
    }

    document.getElementById(lbl).innerHTML = '-' + (MaxLength - parseInt(String(obj.value).length));
}

//For Remark Focus
function focusTextBox(txtID, IterationID, ReleaseID) {
    // $("#" + txtID).focus();
    //debugger;
    var strResult, data;
    data = JSON.stringify({ IterationID: IterationID, ReleaseID: ReleaseID });
    strResult = AJAXCallWithResult("frmReleasePlanning.aspx/PlotTerminated", data, false);

    if (strResult.d != '') {

        $("#Remark").modal('show');
        $("#SprintHeader").html("Terminate From Sprint");
        $("#TerminateRemark").html(strResult.d);
        $("#" + txtID).focus();

        var txtRemark = document.getElementById(txtID);
        setTimeout(function () {
            txtRemark.focus();
        }, 100);

    }

}

//For Terminate Sprint
function TerminateSprint(iterationID, ReleaseID, txtID, obj) {
    // debugger;
    var txtRemark = document.getElementById(txtID);
    var spanRemark = document.getElementById("spanRemark" + iterationID);
    if (txtRemark.value != "") {
        var strResult = AJAXCallWithResult("frmReleasePlanning.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: iterationID, strReleaseID: ReleaseID }), false);
        if (strResult.d == "2") {
            // obj.disabled=true;

            var result = AJAXCallWithResult("frmReleasePlanning.aspx/TerminateSprint", JSON.stringify({ strIterationID: iterationID, strRemark: txtRemark.value, ReleaseID: ReleaseID }), false);
            //InsertFilterProject_Success(result.d);
            //   GetIterationData(iterationID) ;
            // ChangeReleaseName(ReleaseID);
               
            if (result.d != "") {
                var ResultLefdiv = result.d.split("||")
                //alert(ResultLefdiv[1]);
                $("#MainDiv").html("");
                $("#MainDiv").html(ResultLefdiv[1]);
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Sprint UnMapped to Release successfully', 'success');
                $("#Remark").modal("hide");
                refresh();
            }
            // GetIterationData(iterationID);
        }
        else if (strResult.d == "1") {
            // ShowPopup("Release is released.You can not terminate Sprint.");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Release is released.You can not terminate Sprint.', 'error');

        }
        else if (strResult.d == "3") {
            //ShowPopup("You can not terminate Sprint.");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You can not terminate Sprint', 'error');
        }
        else {
            //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
        }
    }
    else {
        $("#" + "txtRemark" + iterationID).css('border-color', 'red');
        $("#" + "txtRemark" + iterationID).css('border-width', '1px');
        $("#" + "spanRemark" + iterationID).text("Please Enter Remark");
        return false;
    }
}
</script>