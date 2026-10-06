function StartLoader(bodyID) {

    var progress2 = new LoadingOverlayProgress({
        bar: {
            "background": "#ddd",
            "top": "50px",
            "height": "30px",
            "border-radius": "15px",
            /*  Commented & Added By Dipali V On 4th April 2023 For Loader Image Path*/
            /* "background": " url('../../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"*/
            "background": " url('../../Whizible2.0-new/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
            /*  End of Commented & Added By Dipali V On 4th April 2023 For Loader Image Path*/
        },

    });
    $(bodyID).LoadingOverlay("show", {
        custom: progress2.Init()
    });
}

function StopLoader(bodyID) {
    jQuery(window).load(function () {
        // This gets executed when the content is loaded
        $(bodyID).LoadingOverlay("hide", {

        });
    });
}

function StopAjaxLoader(bodyID) {
    // This gets executed when the content is loaded
    $(bodyID).LoadingOverlay("hide", {

    });

}