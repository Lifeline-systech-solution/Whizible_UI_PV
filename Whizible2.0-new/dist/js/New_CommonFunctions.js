

//Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax
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
            //Stop();
        },
        error: function (xhr, status, error) {
            //Stop();
            //StopAjaxLoader("body");
            $(".loadingoverlay", parent.document).css("display", "none");
            console.log(xhr.responseText);
            //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
        }
    });

    return AjaxResult;
}
//Endo f Added By Bharat T on 10th-Jan-2017 to return result from jquery ajax