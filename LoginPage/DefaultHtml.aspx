<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="PbNIT.Login1" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title></title>
    <!-- it works the same with all jquery version from 1.x to 2.x -->
    <script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
    <!-- use jssor.slider.mini.js (40KB) instead for release -->
    <!-- jssor.slider.mini.js = (jssor.js + jssor.slider.js) -->
    <script type="text/javascript" src="../js/jssor.js"></script>
    <script type="text/javascript" src="../js/jssor.slider.js"></script>
    <link rel="stylesheet" type="text/css" href="../images/NewHomePage2/TransitionsForFirefox/demos/demos.css" media="screen,projection" />
     <link href="DefaultCSS.css" rel="stylesheet" />
    <script src="../Source/General/CommonFunctions.js"></script>
    <script src="../js/cbpFWTabs.js"></script>
    <script src="../js/Pmlifeline.js"></script>

    <style>
       
        .captionOrange, .captionBlack
        {
            color: #fff;
            font-size: 20px;
            line-height: 30px;
            text-align: center;
            border-radius: 4px;

        }
        .captionOrange
        {
            background: #EB5100;
            background-color: rgba(235, 81, 0, 0.6);
        }
        .captionBlack
        {
        	font-size:16px;
            background: #000;
            background-color: rgba(0, 0, 0, 0.4);
        }
        a.captionOrange, A.captionOrange:active, A.captionOrange:visited
        {
        	color: #ffffff;
        	text-decoration: none;
        }
        a.captionOrange:hover
        {
            color: #eb5100;
            text-decoration: underline;
            background-color: #eeeeee;
            background-color: rgba(238, 238, 238, 0.7);
        }
        .bricon
        {
            background: url(img/browser-icons.png);
        }

        div.logbox
        {
            width: 21%;
            display: block;
            background: #FFFFFF;
            /* float: left; */
            border: 1px solid #d5d5d5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
               z-index: 1;
            height: 300px;
            position:absolute;
            right: 12%;
            
        }

        input.loginbutton
        {
            cursor: hand;
            border: 1px solid #000000;
            background-color: #FFFFFF;
            FONT-SIZE: 12px;
            padding-top: 1pt;
            padding-bottom: 1pt;
            padding-left: 0pt;
            padding-right: 0pt;
            text-decoration: none;
            font-family: Verdana, Arial;
            position: absolute;
            color: #000000;
        }

        #menu li
        {
            display: inline;
            padding: 5px;
        }
        a.link
        {
            cursor: hand;
            border: 1px solid #FFFFFF;
            background-color: #FFFFFF;
            border-radius: 15px;
            FONT-SIZE: 12px;
            padding-top: 1pt;
            padding-bottom: 1pt;
            padding-left: 2pt;
            padding-right: 2pt;
            text-decoration: none;
            font-family: Verdana, Arial;
            /*  border-right: black 1px solid;
	            border-top: black 1px solid;
	            border-left: black 1px solid;
	            border-bottom: black 1px solid;*/
            color: #000000;
        }
        #linkstyle
        {
            font-family:Arial,Helvatica,sans-serif;
            font-size:17px;
            color:#454545;
                
        }

       .mediabox:hover
        {

            overflow:auto;
        }

        .mediabox
        {
            height:300px;
        }

        #LoginBtn
        {
         font-family:Arial,Helvatica,sans-serif;
            font-size:17px;
            color:#454545;
        }
        #imgheight
        {
            /*height:460px !important;*/
           
        }


        .modal-login {
    box-shadow:none;
    /*font-size: 1em; Commented and added by Nilesh G on 19/11/2015 for issue id 1669*/
    font-size:12px;
    font-weight: 300;
    font-style: normal;
    padding: 0 .5em;
    background: transparent;
    color: #101010;
    border: 0;
    border-radius: 0;
    border-bottom: 1px solid #cfd2d5;
}

     @media (max-width:961px) {
        #divContent{
                        margin-bottom:2% !important; /* Added By Vaijat K ON 23/11/2015*/ 
                    }
   
    }
 #divModal{
            max-height:none !important; /* Added By Vaijat K ON 23/11/2015*/ 
    }
    .mediabox:hover
        {
           overflow:auto;
           height:300px;
        }
    </style>
    
    <script>

        var objdivlist;
        var objtxtlogin;
        var objtxtpwd
        var objclientdate;
        var objfrm;
        var IsLoginCalled = false;
        function Password_OnKeyPress(e) {
            var code;
            if (e.keyCode) code = e.keyCode;
            else if (e.which) code = e.which;
            if (code == 13)
                login();
        }
        function SendMail_OnClick() {
            //window.open("Source/General/SendEmail.aspx?MessageID=23","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 460)/2 + ",width=600,height=460");
            <% ' Integrated By ManishK on 4th Jan 06 																	%>
            <% ' Added by NageshM on date 15th jul 2005																	%>
			 
            <% '	  =====================================================================								%>
            <% '        ' Purpose               : To open the page of forgot password when automailservice is on  %>
            <% '        ' Description           : same as above														%>
            <% '        ' Author                : NageshM																%>
            <% '        ' Created               : 12th jul 2005															%>
            <% '        ' Revisions             :																		%> 
         <% '=====================================================================	%>

            if ("<%=M_AutoServiceID%>" == "True") {
                //Commented  And Added By Vaijat K ON 23/11/2015
                //window.open("Source/SM/SM_ForgotPassword.aspx", "", "resizable=no,left=" + (window.screen.width - 300) / 2 + ",top=" + (window.screen.height - 260) / 2 + ",width=400,height=160");
                window.open("Source/SM/SM_ForgotPassword.aspx", "", "resizable=no,left=" + (window.screen.width - 300) / 2 + ",top=" + (window.screen.height - 260) / 2 + ",width=300,height=160");
            }
            else {
                window.open("Source/General/SendEmail.aspx?MessageID=23", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
            }
        }
        // ADDED BY PUNEET MAKODE ON 23rd JUNE 2015
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }


        // Added By Puneet M on 26-06-2015
        function window_onload() {
            if (getParameterByName("Message") == "InvalidLogin" || getParameterByName("Message") == "PBNInvalidLogin") {
                $("#popmodel").modal('show');
                document.getElementById("lblLoginError").innerHTML = "Invalid Login";

            }
            if (getParameterByName("Message") == "ALREADY_LOGGEDIN") {

                $("#popmodel").modal('show');
                //Commented and Added by Dhanashri S on 2 Nov 2015
                //var x = document.getElementById('lblLoginError'); x.innerHTML = "ALREADY LOGGEDIN";
                var x = document.getElementById('lblLoginError'); x.innerHTML = "Already Logged In";
                //End of Comment and Addition by Dhanashri S on 2 Nov 2015
            }
            if (getParameterByName("Message") == "LDAPINVALIDLOGIN") {

                $("#popmodel").modal('show');
                var x = document.getElementById('lblLoginError'); x.innerHTML = "LDAP INVALIDLOGIN";
            }
            if (getParameterByName("Message") == "SESSIONEXPIRED") {

                document.getElementById("txtLogin").value = getParameterByName("strLogin")
                document.getElementById("txtPassword").value = getParameterByName("strPass")

                login();
                if (getParameterByName("strPass") == "") {
                    $("#popmodel").modal('show');
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "SESSION EXPIRED";
                }
            }
            if (getParameterByName("Message") == "SessionExpired") {

                document.getElementById("txtLogin").value = getParameterByName("strLogin")
                document.getElementById("txtPassword").value = getParameterByName("strPass")

                login();
                if (getParameterByName("strPass") == "") {
                    $("#popmodel").modal('show');
                    var x = document.getElementById('lblLoginError'); x.innerHTML = "SESSION EXPIRED";
                }
            }
            if (getParameterByName("Message") == "INVALIDDOMAIN") {

                $("#popmodel").modal('show');
                var x = document.getElementById('lblLoginError'); x.innerHTML = "Invalid Domain";
            }
            if (getParameterByName("Message") == "LOGGEDOUT") {

                $("#popmodel").modal('show');
                var x = document.getElementById('lblLoginError'); x.innerHTML = "Successfully logged out";
            }
            $("#txtLogin").val('');
        }
        // End of Added By Puneet M on 26-06-2015


        //ADDED by Amit Mahadik on 24 August 2011 Purpose:PMLifeLine
        //fn.. checks for value to be present and shows the message if empty
        function IsEmptyLogin(obj, strMessage) {
            if (trimString(obj.value) == "") {
                var x = document.getElementById('lblLoginError'); x.innerHTML = strMessage;
                obj.value = "";
                obj.focus();
                return true;
            }
            else {
                return false;
            }
        }
        function Cancel(id) {
            $('#' + id).modal('hide');
            //Added And Commented By Vidya J On 30-11-2015
            document.getElementById('lblLoginError').textContent = "";
            //End Of Added And Commented By Vidya J On 30-11-2015
        }
        ////End ADDED by Amit Mahadik on 24 August 2011 Purpose:PMLifeLine

        function login() {

            //getelem();
            if (IsLoginCalled == false) {
                //Commented and added by shamkant s
                if (document.getElementById("txtLogin").value == '' && document.getElementById("txtPassword").value == '') {
                    //debugger;
                    document.getElementById("lblLoginError").innerHTML = "Enter LOGIN ID and Password";
                    objtxtlogin.focus();
                    return;
                }
                if (document.getElementById("txtLogin").value == '') {
                    document.getElementById("lblLoginError").innerHTML = "Enter LOGIN ID ";
                    objtxtlogin.focus();
                    return;
                }
                if (document.getElementById("txtPassword").value == '') {
                    document.getElementById("lblLoginError").innerHTML = "Enter PASSWORD  ";
                    objtxtlogin.focus();
                    return;
                }
                //Commented ended  shamkant s
                if (IsEmptyLogin(objtxtlogin, "<%=MyBase.GetResourceString("ENTER_LOGIN_ID")%>")) {
                    objtxtlogin.focus();
                    return;
                }



                //objclientdate.value = new Date();
                objfrm.submit();
            }
            if (IsLoginCalled == false) {
                IsLoginCalled = true;
            }
            // End_MV_13-May-2010
            //window.frmLogin.submit(); 
        }

        function getelem() {

            if (document.getElementById("txtLogin").value != '') {
                document.getElementById("txtLoginM").value = document.getElementById("txtLogin").value;
                document.getElementById("txtPasswordM").value = document.getElementById("txtPassword").value;
            }
            else if (document.getElementById("txtLoginM").value != '') {
                document.getElementById("txtLogin").value = document.getElementById("txtLoginM").value;
                document.getElementById("txtPassword").value = document.getElementById("txtPasswordM").value;
            }

            //alert(document.getElementById("txtPassword").value + ' ' + document.getElementById("txtPasswordM").value)
        }



        $(document).ready(function () {

            objfrm = GetFormReference('frmLogin');
            //objfrm = document.getElementById("frmLogin");
            objtxtlogin = GetObjectReference('frmLogin', 'txtLogin');
            //objtxtlogin = document.getElementById("txtLogin");
            //objdivlist=GetObjectReference('frmLogin','divList')
            //objclientdate = GetObjectReference('frmLogin', 'txtClientDate')


            //commented and added by Shamkant s
            $("#LoginBtn").click(function () { $("#txtLogin").val(''); })
            $("#LoginBtn").click(function () { $("#txtPassword").val(''); })
            $("#LoginBtn").click(function () { $("#lblLoginError").val(''); })
            //commented  ended by Shamkant s
            document.getElementById("tblMain").style.height = (parseInt($(window).height()) - 30) + "px";
            $("#LoginBtn").click(function () {
                $('#loginbox').slideToggle("slow");
            });

            document.getElementById("popmodel").onfocus = function () { objtxtlogin.focus(); }; //Added By Vaijat K ON 20/11/2015


            var _CaptionTransitions = [];
            _CaptionTransitions["L"] = { $Duration: 900, x: 0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
            _CaptionTransitions["R"] = { $Duration: 900, x: -0.6, $Easing: { $Left: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
            _CaptionTransitions["T"] = { $Duration: 900, y: 0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
            _CaptionTransitions["B"] = { $Duration: 900, y: -0.6, $Easing: { $Top: $JssorEasing$.$EaseInOutSine }, $Opacity: 2 };
            _CaptionTransitions["ZMF|10"] = { $Duration: 900, $Zoom: 11, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear }, $Opacity: 2 };
            _CaptionTransitions["RTT|10"] = { $Duration: 900, $Zoom: 11, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseOutQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInExpo }, $Opacity: 2, $Round: { $Rotate: 0.8 } };
            _CaptionTransitions["RTT|2"] = { $Duration: 900, $Zoom: 3, $Rotate: 1, $Easing: { $Zoom: $JssorEasing$.$EaseInQuad, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInQuad }, $Opacity: 2, $Round: { $Rotate: 0.5 } };
            _CaptionTransitions["RTTL|BR"] = { $Duration: 900, x: -0.6, y: -0.6, $Zoom: 11, $Rotate: 1, $Easing: { $Left: $JssorEasing$.$EaseInCubic, $Top: $JssorEasing$.$EaseInCubic, $Zoom: $JssorEasing$.$EaseInCubic, $Opacity: $JssorEasing$.$EaseLinear, $Rotate: $JssorEasing$.$EaseInCubic }, $Opacity: 2, $Round: { $Rotate: 0.8 } };
            _CaptionTransitions["CLIP|LR"] = { $Duration: 900, $Clip: 15, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic }, $Opacity: 2 };
            _CaptionTransitions["MCLIP|L"] = { $Duration: 900, $Clip: 1, $Move: true, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic } };
            _CaptionTransitions["MCLIP|R"] = { $Duration: 900, $Clip: 2, $Move: true, $Easing: { $Clip: $JssorEasing$.$EaseInOutCubic } };

            var options = {
                $FillMode: 2,                                       //[Optional] The way to fill image in slide, 0 stretch, 1 contain (keep aspect ratio and put all inside slide), 2 cover (keep aspect ratio and cover whole slide), 4 actual size, 5 contain for large image, actual size for small image, default value is 0
                $AutoPlay: true,                                    //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
                $AutoPlayInterval: 4000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
                $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

                $ArrowKeyNavigation: true,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
                $SlideEasing: $JssorEasing$.$EaseOutQuint,          //[Optional] Specifies easing for right to left animation, default value is $JssorEasing$.$EaseOutQuad
                $SlideDuration: 800,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
                $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
                //$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
                //$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
                $SlideSpacing: 0, 					                //[Optional] Space between each slide in pixels, default value is 0
                $DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
                $ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
                $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
                $PlayOrientation: 1,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
                $DragOrientation: 1,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

                //$CaptionSliderOptions: {                            //[Optional] Options which specifies how to animate caption
                //    $Class: $JssorCaptionSlider$,                   //[Required] Class to create instance to animate caption
                //    $CaptionTransitions: _CaptionTransitions,       //[Required] An array of caption transitions to play caption, see caption transition section at jssor slideshow transition builder
                //    $PlayInMode: 1,                                 //[Optional] 0 None (no play), 1 Chain (goes after main slide), 3 Chain Flatten (goes after main slide and flatten all caption animations), default value is 1
                //    $PlayOutMode: 3                                 //[Optional] 0 None (no play), 1 Chain (goes before main slide), 3 Chain Flatten (goes before main slide and flatten all caption animations), default value is 1
                //},

                $BulletNavigatorOptions: {                          //[Optional] Options to specify and enable navigator or not
                    $Class: $JssorBulletNavigator$,                 //[Required] Class to create navigator instance
                    $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                    $AutoCenter: 1,                                 //[Optional] Auto center navigator in parent container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
                    $Steps: 1,                                      //[Optional] Steps to go for each navigation request, default value is 1
                    $Lanes: 1,                                      //[Optional] Specify lanes to arrange items, default value is 1
                    $SpacingX: 8,                                   //[Optional] Horizontal space between each item in pixel, default value is 0
                    $SpacingY: 8,                                   //[Optional] Vertical space between each item in pixel, default value is 0
                    $Orientation: 1                                 //[Optional] The orientation of the navigator, 1 horizontal, 2 vertical, default value is 1

                },

                $ArrowNavigatorOptions: {                           //[Optional] Options to specify and enable arrow navigator or not
                    $Class: $JssorArrowNavigator$,                  //[Requried] Class to create arrow navigator instance
                    $ChanceToShow: 1,                               //[Required] 0 Never, 1 Mouse Over, 2 Always
                    $AutoCenter: 2,                                 //[Optional] Auto center arrows in parent container, 0 No, 1 Horizontal, 2 Vertical, 3 Both, default value is 0
                    $Steps: 1                                       //[Optional] Steps to go for each navigation request, default value is 1
                }
            };

            var jssor_slider1 = new $JssorSlider$("slider1_container", options);
            //responsive code begin
            //you can remove responsive code if you don't want the slider scales while window resizes
            function ScaleSlider() {
                var bodyWidth = document.body.clientWidth;
                if (bodyWidth)
                    jssor_slider1.$ScaleWidth(Math.min(bodyWidth, 1920));
                else
                    window.setTimeout(ScaleSlider, 30);
            }
            ScaleSlider();

            $(window).bind("load", ScaleSlider);
            $(window).bind("resize", ScaleSlider);
            $(window).bind("orientationchange", ScaleSlider);
            //responsive code end

            var options1 = {
                $AutoPlay: false,                                   //[Optional] Whether to auto play, to enable slideshow, this option must be set to true, default value is false
                $AutoPlaySteps: 1,                                  //[Optional] Steps to go for each navigation request (this options applys only when slideshow disabled), the default value is 1
                $AutoPlayInterval: 4000,                            //[Optional] Interval (in milliseconds) to go for next slide since the previous stopped if the slider is auto playing, default value is 3000
                $PauseOnHover: 1,                                   //[Optional] Whether to pause when mouse over if a slider is auto playing, 0 no pause, 1 pause for desktop, 2 pause for touch device, 3 pause for desktop and touch device, 4 freeze for desktop, 8 freeze for touch device, 12 freeze for desktop and touch device, default value is 1

                $ArrowKeyNavigation: true,   			            //[Optional] Allows keyboard (arrow key) navigation or not, default value is false
                $SlideDuration: 500,                                //[Optional] Specifies default duration (swipe) for slide in milliseconds, default value is 500
                $MinDragOffsetToSlide: 20,                          //[Optional] Minimum drag offset to trigger slide , default value is 20
                //$SlideWidth: 600,                                 //[Optional] Width of every slide in pixels, default value is width of 'slides' container
                //$SlideHeight: 300,                                //[Optional] Height of every slide in pixels, default value is height of 'slides' container
                $SlideSpacing: 5, 					                //[Optional] Space between each slide in pixels, default value is 0
                $DisplayPieces: 1,                                  //[Optional] Number of pieces to display (the slideshow would be disabled if the value is set to greater than 1), the default value is 1
                $ParkingPosition: 0,                                //[Optional] The offset position to park slide (this options applys only when slideshow disabled), default value is 0.
                $UISearchMode: 1,                                   //[Optional] The way (0 parellel, 1 recursive, default value is 1) to search UI components (slides container, loading screen, navigator container, arrow navigator container, thumbnail navigator container etc).
                $PlayOrientation: 2,                                //[Optional] Orientation to play slide (for auto play, navigation), 1 horizental, 2 vertical, 5 horizental reverse, 6 vertical reverse, default value is 1
                $DragOrientation: 3,                                //[Optional] Orientation to drag slide, 0 no drag, 1 horizental, 2 vertical, 3 either, default value is 1 (Note that the $DragOrientation should be the same as $PlayOrientation when $DisplayPieces is greater than 1, or parking position is not 0)

                $ThumbnailNavigatorOptions: {
                    $Class: $JssorThumbnailNavigator$,              //[Required] Class to create thumbnail navigator instance
                    $ChanceToShow: 2,                               //[Required] 0 Never, 1 Mouse Over, 2 Always

                    $ActionMode: 1,                                 //[Optional] 0 None, 1 act by click, 2 act by mouse hover, 3 both, default value is 1
                    $AutoCenter: 3,                                 //[Optional] Auto center thumbnail items in the thumbnail navigator container, 0 None, 1 Horizontal, 2 Vertical, 3 Both, default value is 3
                    $Lanes: 1,                                      //[Optional] Specify lanes to arrange thumbnails, default value is 1
                    $SpacingX: 0,                                   //[Optional] Horizontal space between each thumbnail in pixel, default value is 0
                    $SpacingY: 0,                                   //[Optional] Vertical space between each thumbnail in pixel, default value is 0
                    $DisplayPieces: 5,                              //[Optional] Number of pieces to display, default value is 1
                    $ParkingPosition: 0,                            //[Optional] The offset position to park thumbnail
                    $Orientation: 2,                                //[Optional] Orientation to arrange thumbnails, 1 horizental, 2 vertical, default value is 1
                    $DisableDrag: true                              //[Optional] Disable drag or not, default value is false
                }
            };


            if (isIE() == "IE") {
                document.getElementById("slider1_container").style.width = "";
            }
            else if (isIE() == "CR") {
                document.getElementById("slider1_container").style.width = "";
            }



        });

        $(window).resize(function () {
            document.getElementById("tblMain").style.height = (parseInt($(window).height()) - 30) + "px";
        });

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

        function ChangePwd_OnClick() {
            //Commented  by Viraj P on 23 Nov 2015
            //     window.open("Source/SM/SM_ChangePassword.aspx", "", "resizable=no,width=300,height=195,Left=400,Top=230");
            window.open("Source/SM/SM_ChangePassword.aspx", "", "resizable=no,width=300,height=210,Left=400,Top=230");
            //End of Comment  by Viraj P on 23 Nov 2015
        }
    </script>

</head>

<body onload="window_onload()" style="margin-left: 20px; margin-right: 20px;">
 <%If strSubmitToNavigation <> "" Then%>
    <form id="frmLogin" action="<%=strSubmitToNavigation%>" method="post" autocomplete="off" />
    <%Else%>
    <form id="Form1" action="Source/General/Navigation.aspx" method="post" autocomplete="off">
        <%  End If
            If Trim(Request.QueryString("Message") & "") <> "" Or Not m_blnIsWindowsAuthenticated Then
                
        %>
        
        <%End If%>
       
        <%-- </div>--%>
        <!--end by bharat tekade-->
   
    <table id="tblMain" style="width:99%;margin-left:auto;margin-right:auto;height:650px;border:0px solid black;border-collapse:collapse;" border="0">
        <tr style="height:12%;border:0px;">
            <td style="text-align:left;width:20%;border-right: 1px solid white;">                
                    <img src="../LoginImages/Logo.jpg" />                
            </td>
            <td style="width:60%">
                <div id="menu">
                    <ul>
                        <li><a  id="linkstyle" class="link" href="#" onclick="window.open ('../images/Support.html', 'child')">Support</a></li>
                        <li><a  id="linkstyle" class="link" href="#" onclick="window.open ('../images/Features.html', 'child')">Features Us</a></li>
                        <li><a  id="linkstyle" class="link" href="#" onclick="window.open ('../images/Company.html', 'child')">Company</a></li>
                        <li><a  id="linkstyle" class="link" href="#" onclick="window.open ('../images/Contact.html', 'child')">Contacts</a></li>
                        <li><a  id="linkstyle" class="link" href="#" onclick="window.open ('../images/Blogs.html', 'child')">Blogs</a></li>
                        <li><a  id="LoginBtn" class="link" data-toggle="modal" href="#popmodel" class="btn btn-primary" href="#popmodel">Login</a></li>                                           
                    </ul>                 
                </div>
               
                   <div class="leve-content">
                    <div class="innerleave-content">
                        <div class="workflow">
                            <div style="margin: 3% 0% 2% 3%;">
                                <%--<a data-toggle="modal" href="#popmodel" class="btn btn-primary" style="margin-left: -3%;">Submit Leave</a>--%>
                                <%--<button class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-lg" onclick="javascript:return false;">Submit Leave</button>--%>
                            </div>
                            <div class="Table-Header">
                            </div>
                            <table id="MyLeaveGridview" class="scroll">
                            </table>

                            <div id="MyLeaveNavigation" class="scroll" style="text-align: center;">
                            </div>
                        </div>
                        <div id="popmodel" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg" style="margin-left:auto; padding-top:7.25%">
                                <div id="divModal" class="modal-content ImageGalleryItems ">
                                   
                                    <div style="width:100%;text-align:right;margin-top: 1%;height: 10px;"><a href="#"><img src="../LoginImages/closebtn.png" onclick="Cancel('popmodel')" /></a> </div>
                                    <div style="width: 100%; text-align: right; margin-top: 1%;">
                                        <a href="#"></a>
                                    </div>
                                    <%-- Commented By Vaijat K ON 23/11/2015 --%>
                                    <%-- <div style="width:100%;text-align:center;margin-top: 10%;"><img src="LoginImages/Logo.jpg" /> </div>
                                    <center><label><h4><b>Sign In</b></h4></label></center>--%>
                                    <div id="divContent" style="width:100%;text-align:center;margin-bottom: 10%;"><table><tr><td style="width:50%"><img src="../LoginImages/Logo.jpg" /> </td><td style="width:50%;vertical-align: bottom;"><center><label><h4 style="font-size:15px;"><b>Login</b></h4></label></center></td></tr></table> </div>
                                    <center>
                                    <table class="ResponsiveFontSize">
                                        <tr>
                                            <td> <% DrawNewLoginBox1()%></td>
                                        </tr>
                       
                                    </table>
                                    </center>
                              
                                    </div>
                                </div>
                        </div>
                        </div>

                    </div>

            </td>
            <td style="width:20%;text-align:right;border-left: 1px solid white;">              
                    <img src="../LoginImages/easi-logo.jpg" />                
            </td>
        </tr>
        <tr style="height:30%;vertical-align:top;">
            <td colspan="3">
                 <!-- Jssor Slider Begin -->
                <!-- To move inline styles to css file/block, please specify a class name for each element. -->
                <div id="slider1_container" style="position: relative; margin: 0 auto; top: 0px; left: 0px; height: 350px; width: 1000px !important;">
                    <!-- Loading Screen -->
                    <div u="loading" style="position: absolute; top: 0px; left: 0px;">
                        <div style="filter: alpha(opacity=70); opacity: 0.7; position: absolute; display: block; top: 0px; left: 0px; width: 100%; height: 100%;">
                        </div>
                        <div style="position: absolute; display: block; background: url(../img/loading.gif) no-repeat center center; top: 0px; left: 0px; width: 100%; height: 100%;">
                        </div>
                    </div>
                    <!-- Slides Container -->
                    <div u="slides" style="cursor: move; position: absolute; left: 0px; top: 0px; width: 1000px; height: 350px; overflow: hidden;">
                        <div>
                            <img id="imgheight" u="image" src="../img/1920/purple.jpg"/>
                            <div u="caption" t="NO" t3="RTT|2" r3="137.5%" du3="3000" d3="500" style="position: absolute; width: 445px; height: 300px; top: 100px; left: 600px;">
                              <%--  <img src="img/new-site/c-phone.png" style="position: absolute; width: 445px; height: 300px; top: 0px; left: 0px;" />
                                <img u="caption" t="CLIP|LR" du="4000" t2="NO" src="img/new-site/c-jssor-slider.png" style="position: absolute; width: 102px; height: 78px; top: 70px; left: 130px;" />
                                <img u="caption" t="ZMF|10" t2="NO" src="img/new-site/c-text.png" style="position: absolute; width: 80px; height: 53px; top: 153px; left: 163px;" />
                                <img u="caption" t="RTT|10" t2="NO" src="img/new-site/c-fruit.png" style="position: absolute; width: 140px; height: 90px; top: 60px; left: 220px;" />
                                <img u="caption" t="T" du="4000" t2="NO" src="img/new-site/c-navigator.png" style="position: absolute; width: 200px; height: 155px; top: 57px; left: 121px;" />--%>
                            </div>
                            <div u="caption" t="RTT|2" r="-75%" du="1600" d="2500" t2="NO" style="position: absolute; width: 470px; height: 220px; top: 120px; left: 650px;">
                               <%-- <img src="img/new-site/c-phone-horizontal.png" style="position: absolute; width: 470px; height: 220px; top: 0px; left: 0px;" />
                                <img u="caption" t3="MCLIP|L" du3="2000" src="img/new-site/c-slide-1.jpg" style="position: absolute; width: 379px; height: 213px; top: 4px; left: 45px;" />
                                <img u="caption" t="MCLIP|R" du="2000" t2="NO" src="img/new-site/c-slide-3.jpg" style="position: absolute; width: 379px; height: 213px; top: 4px; left: 45px;" />
                                <img u="caption" t="RTTL|BR" x="500%" y="500%" du="1000" d="-3000" r="-30%" t3="L" x3="70%" du3="1600" src="img/new-site/c-finger-pointing.png" style="position: absolute; width: 257px; height: 300px; top: 80px; left: 200px;" />
                                <img src="img/new-site/c-navigator-horizontal.png" style="position: absolute; width: 379px; height: 213px; top: 4px; left: 45px;" />--%>
                            </div>
                           
                        </div>
                        <div>
                            <img id ="img1"  u="image" src="../img/1920/red.jpg" />
                          
                        </div>
                        <div>
                            <img id ="img2"  u="image" src="../img/1920/Blue.jpg" />
                           
                        </div>
                          <div>
                            <img id ="img3"  u="image" src="../img/1920/BlueNew.jpg" />
                           
                        </div>
                    </div>

                    <!--#region Bullet Navigator Skin Begin -->
                    <!-- Help: http://www.jssor.com/development/slider-with-bullet-navigator-jquery.html -->
                    <style>
                        
                        .jssorb21
                        {
                            position: absolute;
                        }

                            .jssorb21 div, .jssorb21 div:hover, .jssorb21 .av
                            {
                                position: absolute;
                                /* size of bullet elment */
                                width: 19px;
                                height: 19px;
                                text-align: center;
                                line-height: 19px;
                                color: white;
                                font-size: 12px;
                                background: url(../img/b21.png) no-repeat;
                                overflow: hidden;
                                cursor: pointer;
                            }

                            .jssorb21 div
                            {
                                background-position: -5px -5px;
                            }

                                .jssorb21 div:hover, .jssorb21 .av:hover
                                {
                                    background-position: -35px -5px;
                                }

                            .jssorb21 .av
                            {
                                background-position: -65px -5px;
                            }

                            .jssorb21 .dn, .jssorb21 .dn:hover
                            {
                                background-position: -95px -5px;
                            }
                    </style>
                    <!-- bullet navigator container -->
                    <div u="navigator" class="jssorb21" style="bottom: 26px; right: 6px;">
                        <!-- bullet navigator item prototype -->
                        <div u="prototype"></div>
                    </div>
                    <!--#endregion Bullet Navigator Skin End -->

                    <!--#region Arrow Navigator Skin Begin -->
                    <!-- Help: http://www.jssor.com/development/slider-with-arrow-navigator-jquery.html -->
                    <style>
                        
                        .jssora21l, .jssora21r
                        {
                            display: block;
                            position: absolute;
                            /* size of arrow element */
                            width: 55px;
                            height: 55px;
                            cursor: pointer;
                            background: url(../img/a21.png) center center no-repeat;
                            overflow: hidden;
                        }

                        .jssora21l
                        {
                            background-position: -3px -33px;
                        }

                        .jssora21r
                        {
                            background-position: -63px -33px;
                        }

                        .jssora21l:hover
                        {
                            background-position: -123px -33px;
                        }

                        .jssora21r:hover
                        {
                            background-position: -183px -33px;
                        }

                        .jssora21l.jssora21ldn
                        {
                            background-position: -243px -33px;
                        }

                        .jssora21r.jssora21rdn
                        {
                            background-position: -303px -33px;
                        }
                    </style>
                    <!-- Arrow Left -->
                    <span u="arrowleft" class="jssora21l" style="top: 123px; left: 8px;"></span>
                    <!-- Arrow Right -->
                    <span u="arrowright" class="jssora21r" style="top: 123px; right: 8px;"></span>
                    <!--#endregion Arrow Navigator Skin End -->
                    <a style="display: none" href="http://www.jssor.com">Bootstrap Slider</a>
                </div>
    <!-- Jssor Slider End -->
            </td>
        </tr>
        <tr style="vertical-align:top;">
            <td colspan="3">
               <div class="container">
			
		        	<div id="tabs" class="tabs">
				    <nav>
					    <ul>
						    <li><a href="#section-1" class="icon-shop"><span>Alert/Notification</span></a></li>
						    <li><a href="#section-2" class="icon-cup"><span>Training</span></a></li>
						    <li><a href="#section-3" class="icon-food"><span>Collaboration</span></a></li>
						    <li><a href="#section-4" class="icon-lab"><span>Blog</span></a></li>
						    <li><a href="#section-5" class="icon-truck"><span>Faq</span></a></li>
                            <li><a href="#section-6" class="icon-truck"><span>First Time User</span></a></li>
					    </ul>
				    </nav>
				    <div class="content" style="border: 1px solid rgb(71, 163, 218)">
					<section id="section-1">
						<div class="mediabox">
							<img src="../img/01.png" alt="img01" />
							<h3>Sushi Gumbo Beetroot</h3>
							<p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
                            <p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
                            <p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
                            <p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
                            <p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
						</div>
						<div class="mediabox">
							<img src="../img/02.png" alt="img02" />
							<h3>Pea Sprouts Fava Soup</h3>
							<p>Lotus root water spinach fennel kombu maize bamboo shoot green bean swiss chard seakale pumpkin onion chickpea gram corn pea.</p>
						</div>
						<div class="mediabox">
							<img src="../img/03.png" alt="img03" />
							<h3>Turnip Broccoli Sashimi</h3>
							<p>Nori grape silver beet broccoli kombu beet greens fava bean potato quandong celery. Bunya nuts black-eyed pea prairie turnip leek lentil turnip greens parsnip.</p>
						</div>
					</section>
					<section id="section-2">
						<div class="mediabox">
							<img src="../img/04.png" alt="img04" />
							<h3>Asparagus Cucumber Cake</h3>
							<p>Chickweed okra pea winter purslane coriander yarrow sweet pepper radish garlic brussels sprout groundnut summer purslane earthnut pea tomato spring onion azuki bean gourd. </p>
						</div>
						<div class="mediabox">
							<img src="../img/05.png" alt="img05" />
							<h3>Magis Kohlrabi Gourd</h3>
							<p>Salsify taro catsear garlic gram celery bitterleaf wattle seed collard greens nori. Grape wattle seed kombu beetroot horseradish carrot squash brussels sprout chard.</p>
						</div>
						<div class="mediabox">
							<img src="../img/06.png" alt="img06" />
							<h3>Ricebean Rutabaga</h3>
							<p>Celery quandong swiss chard chicory earthnut pea potato. Salsify taro catsear garlic gram celery bitterleaf wattle seed collard greens nori. </p>
						</div>
					</section>
					<section id="section-3">
						<div class="mediabox">
							<img src="../img/02.png" alt="img02" />
							<h3>Noodle Curry</h3>
							<p>Lotus root water spinach fennel kombu maize bamboo shoot green bean swiss chard seakale pumpkin onion chickpea gram corn pea.Sushi gumbo beet greens corn soko endive gumbo gourd.</p>
						</div>
						<div class="mediabox">
							<img src="../img/06.png" alt="img06" />
							<h3>Leek Wasabi</h3>
							<p>Sushi gumbo beet greens corn soko endive gumbo gourd. Parsley shallot courgette tatsoi pea sprouts fava bean collard greens dandelion okra wakame tomato.</p>
						</div>
						<div class="mediabox">
							<img src="../img/01.png" alt="img01" />
							<h3>Green Tofu Wrap</h3>
							<p>Pea horseradish azuki bean lettuce avocado asparagus okra. Kohlrabi radish okra azuki bean corn fava bean mustard tigernut wasabi tofu broccoli mixture soup.</p>
						</div>
					</section>
					<section id="section-4">
						<div class="mediabox">
							<img src="../img/03.png" alt="img03" />
							<h3>Tomato Cucumber Curd</h3>
							<p>Chickweed okra pea winter purslane coriander yarrow sweet pepper radish garlic brussels sprout groundnut summer purslane earthnut pea tomato spring onion azuki bean gourd. </p>
						</div>
						<div class="mediabox">
							<img src="../img/01.png" alt="img01" />
							<h3>Mushroom Green</h3>
							<p>Salsify taro catsear garlic gram celery bitterleaf wattle seed collard greens nori. Grape wattle seed kombu beetroot horseradish carrot squash brussels sprout chard.</p>
						</div>
						<div class="mediabox">
							<img src="../img/04.png" alt="img04" />
							<h3>Swiss Celery Chard</h3>
							<p>Celery quandong swiss chard chicory earthnut pea potato. Salsify taro catsear garlic gram celery bitterleaf wattle seed collard greens nori. </p>
						</div>
					</section>
					<section id="section-5">
						<div class="mediabox">
							<img src="../img/02.png" alt="img02" />
							<h3>Radish Tomato</h3>
							<p>Catsear cauliflower garbanzo yarrow salsify chicory garlic bell pepper napa cabbage lettuce tomato kale arugula melon sierra leone bologi rutabaga tigernut.</p>
						</div>
						<div class="mediabox">
							<img src="../img/06.png" alt="img06" />
							<h3>Fennel Wasabi</h3>
							<p>Sea lettuce gumbo grape kale kombu cauliflower salsify kohlrabi okra sea lettuce broccoli celery lotus root carrot winter purslane turnip greens garlic.</p>
						</div>
						<div class="mediabox">
							<img src="../img/01.png" alt="img01" />
							<h3>Red Tofu Wrap</h3>
							<p>Green horseradish azuki bean lettuce avocado asparagus okra. Kohlrabi radish okra azuki bean corn fava bean mustard tigernut wasabi tofu broccoli mixture soup.</p>
						</div>
					</section>
                     <section id="section6">
						<div class="mediabox">
							<img src="../img/02.png" alt="img02" />
							<h3>Radish Tomato</h3>
							<p>Catsear cauliflower garbanzo yarrow salsify chicory garlic bell pepper napa cabbage lettuce tomato kale arugula melon sierra leone bologi rutabaga tigernut.</p>
						</div>
						<div class="mediabox">
							<img src="../img/06.png" alt="img06" />
							<h3>Fennel Wasabi</h3>
							<p>Sea lettuce gumbo grape kale kombu cauliflower salsify kohlrabi okra sea lettuce broccoli celery lotus root carrot winter purslane turnip greens garlic.</p>
						</div>
						<div class="mediabox">
							<img src="../img/01.png" alt="img01" />
							<h3>Red Tofu Wrap</h3>
							<p>Green horseradish azuki bean lettuce avocado asparagus okra. Kohlrabi radish okra azuki bean corn fava bean mustard tigernut wasabi tofu broccoli mixture soup.</p>
						</div>
					</section>
				</div><!-- /content -->
		        	</div><!-- /tabs -->
			
		        </div>
		
		        <script>
		            new CBPFWTabs(document.getElementById('tabs'));
		        </script>       
            </td>
        </tr>
        
        <tr>
             <td colspan="3">
                <footer>
                    
                    <div class="middleContainer">
                    <span class="mobile-show copyrightclass">Support Desk Numbers: +91 20 30200777 / 778  |  </span><a href="/terms-condition/terms-and-conditions.page?" onclick="Sample code">Terms &amp; Conditions</a>&nbsp;|&nbsp;<a href="/do-not-call.page?">Do Not Call Registry</a>&nbsp;|&nbsp;<a href="/disclaimer.page?">Disclaimer</a>&nbsp;|&nbsp;<a href="/multilingual-disclaimer.page?">Multilingual Disclaimer</a>&nbsp;|&nbsp;<a href="/code-of-commitment.page?">Code of Commitment</a>&nbsp;|&nbsp;<a href="/managed-assets/docs/personal/general-links/code_of_business_conduct_ethics.pdf"> Group Code of Business Conduct and Ethics</a>&nbsp;|&nbsp;<a href="/unparliamentary-language-by-customers.page?">Use of Unparliamentary Language by Customers</a>&nbsp;|&nbsp;<a href="/privacy.page?">Privacy</a>&nbsp;|&nbsp;<a href="/usa-patriot-act-certification.page?">USA Patriot Act Certification</a>&nbsp;|&nbsp;<a href="/managed-assets/docs/personal/general-links/bank-fair-practices-code.pdf">Fair Practice Code for Lenders</a>
                    </div>
                </footer>

             </td>
        </tr>
       
    </table>

    </form>
</body>
</html>
