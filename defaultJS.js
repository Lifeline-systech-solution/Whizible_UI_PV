$(document).ready(function () {

    $.ajax({
        type: "GET",
        url: "LoginPage/DefaultXML.xml",
        dataType: "xml",
        success: function (xml) {

            // String Exists - In this case Blank space is there
            // If Custom is Blank then Print Default
            var loginImage = '';
            var loginText = '';

            if (($(xml).find('CustomLoginPage').text()).indexOf('\n') != -1 || $(xml).find('CustomLoginPage').text() != '') {

                //Header Section
                if (($(xml).find('CustomHeaderSection').find('HeaderSection').text()).indexOf('\n') != -1 || $(xml).find('CustomHeaderSection').find('HeaderSection').text() != '') {

                    $(xml).find('CustomHeaderSection').each(function (i, e) {
                        //Custom Header Section
                        $(this).find('LoginImage').each(function (i, e) {
                            document.getElementById("loginImage").innerHTML = '<img src="' + $(e).find('Name').text() + '">';
                            loginImage = document.getElementById("loginImage").innerHTML;
                        });
                        $(this).find('LoginText').each(function (i, e) {
                            document.getElementById("loginText").innerHTML = '<h4 style="font-size:15px;"><b>' + $(e).find('Name').text() + '</b></h4>';

                            loginImage = document.getElementById("loginText").innerHTML;
                        });
                        $.get($(e).find('HeaderSection').text(), function (data) {

                            document.getElementById('header').innerHTML = '<table><tbody><tr><td style="width:94%"><iframe frameBorder="0" height=78 width=100% src=' + $(e).find('HeaderSection').text() + ' scrolling="no"></iframe></td><td><div id="menu"><ul><li><a  id="LoginBtn" class="link" data-toggle="modal" href="#popmodel" class="btn btn-primary" >Login</a></li></ul></div></td></tr></tbody></table>';
                        });
                    });
                }
                else {
                    //Default Header Section
                    var data11 = '';

                    $(xml).find('DefaultHeaderSection').each(function (i, e) {
                        $(this).find('LoginImage').each(function (i, e) {
                            document.getElementById("loginImage").innerHTML = '<img src="' + $(e).find('Name').text() + '">';
                            loginImage = document.getElementById("loginImage").innerHTML;
                        });
                        $(this).find('LoginText').each(function (i, e) {
                            document.getElementById("loginText").innerHTML = '<h4 style="font-size:15px;"><b>' + $(e).find('Name').text() + '</b></h4>';
                            loginImage = document.getElementById("loginText").innerHTML;
                        });
                        //  $("#header").load("Header.html");
                        $.get($(e).find('HeaderSection').text(), function (data) {

                            document.getElementById('header').innerHTML = '<iframe frameBorder="0" height=78 width=100% src=' + $(e).find('HeaderSection').text() + ' scrolling="no"></iframe>';

                        });

                    });

                }

                //Slider Section 
                if (($(xml).find('CustomSliderSection').find('SliderSection').text()).indexOf('\n') != -1 || $(xml).find('CustomSliderSection').find("SliderSection").text() != '') {
                    $(xml).find('CustomSliderSection').each(function (i, e) {

                        $.get($(e).find('SliderSection').text(), function (data) {
                          
                            if ($(window).width() <= 720) {
                                document.getElementById("sliderTR").innerHTML = '<iframe id="iframeSlider" frameBorder="0" width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no" style="height:240px"></iframe>';
                            }
                            else if (($(window).width() >= 720) && ($(window).width() <= 850)) {
                                document.getElementById("sliderTR").innerHTML = '<iframe id="iframeSlider" frameBorder="0" width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no" style="height:280px"></iframe>';
                            }
                            else if (($(window).width() >= 850) && ($(window).width() <= 1000))
                            {
                                document.getElementById("sliderTR").innerHTML = '<iframe id="iframeSlider" frameBorder="0" width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no" style="height:350px"></iframe>';
                            }
                            else if (($(window).width() >= 1000) && ($(window).width() <= 1200)) {
                                document.getElementById("sliderTR").innerHTML = '<iframe id="iframeSlider" frameBorder="0" width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no" style="height:400px"></iframe>';
                            }
                            else {
                                document.getElementById("sliderTR").innerHTML = '<iframe id="iframeSlider" frameBorder="0" width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no" style="height:460px"></iframe>';
                            }

                        });
                    });

                }
                else {

                    //Default Slider Section
                    $(xml).find('DefaultSliderSection').each(function (i, e) {

                        $.get($(e).find('SliderSection').text(), function (data) {
                            if ($(window).width() <= 720) {
                                document.getElementById("sliderTR").innerHTML = '<iframe frameBorder="0" height=160 width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no"></iframe>';
                            }
                            else if (($(window).width() >= 720) && ($(window).width() <= 1000)) {
                                document.getElementById("sliderTR").innerHTML = '<iframe frameBorder="0" height=350 width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no"></iframe>';
                            }

                            else if (($(window).width() >= 1000) && ($(window).width() <= 1200)) {
                                document.getElementById("sliderTR").innerHTML = '<iframe frameBorder="0" height=400 width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no"></iframe>';
                            }
                            else {

                                document.getElementById("sliderTR").innerHTML = '<iframe frameBorder="0" height=460 width=100% src=' + $(e).find('SliderSection').text() + ' scrolling="no"></iframe>';
                            }

                        });
                    });

                }



                //Tab Section 
                var sbhtmlTabLinks = '';
                var sbTabsli = ''; var sbDivTabs = '';
                if (($(xml).find('CustomTabs').find('Tabs').text()).indexOf('\n') != -1 || $(xml).find('CustomTabs').find('Tabs').text() != '') {
                    // debugger;
                    $(xml).find('CustomTabs').each(function (i, e) {

                        $.get($(e).find('Tabs').text(), function (data) {

                            document.getElementById("TabTR").innerHTML = '<iframe width=100% height=400 frameBorder="0" src=' + $(e).find('Tabs').text() + ' scrolling="no"></iframe>';
                        });
                    });
                }
                else {
                    //Default Tabs Section

                    $(xml).find('DefaultTabs').each(function (i, e) {

                        $.get($(e).find('Tabs').text(), function (data) {

                            document.getElementById("TabTR").innerHTML = '<iframe width=100% height=400 frameBorder="0" src=' + $(e).find('Tabs').text() + ' scrolling="no"></iframe>';
                        });
                    });


                }

                //Footer Section
                if (($(xml).find('CustomFooterSection').find('FooterSection').text()).indexOf('\n') != -1 || $(xml).find('CustomFooterSection').find("FooterSection").text() != '') {

                    $(xml).find('CustomFooterSection').each(function (i, e) {


                        $.get($(e).find('FooterSection').text(), function (data) {

                            document.getElementById("footerTR").innerHTML = '<iframe onload="setFrameLoaded();" width=100% height=100 frameBorder="0" src=' + $(e).find('FooterSection').text() + ' scrolling="no"></iframe>';
                        });

                    });
                }
                else {
                    //   //Default Footer Section 

                    $(xml).find('DefaultFooterSection').each(function (i, e) {
                        $.get($(e).find('FooterSection').text(), function (data) {

                            document.getElementById("footerTR").innerHTML = '<iframe onload="setFrameLoaded();" width=100% height=100 frameBorder="0" src=' + $(e).find('FooterSection').text() + ' scrolling="no"></iframe>';
                        });

                    });

                }

            }
            else {

                $(xml).find('DefaultLoginPage').each(function (i, e) {
                    $.get($(e).find('DefaultPage').text(), function (data) {


                        document.body.innerHTML = '<iframe width=100% onload="setFrameLoaded();" height=1000 frameBorder="0" src=' + $(e).find('DefaultPage').text() + ' scrolling="no"></iframe>';

                    });

                });
            }
        },

        error: function () {
            alert("Error occured in Reading XML.");
        }


    });



});
$(window).resize(function () {
    if ($(window).width() <= 720) {
        $("#iframeSlider").css("height", "240px");
    }
    else if (($(window).width() >= 720) && ($(window).width() <= 850)) {
        $("#iframeSlider").css("height", "280px");
    }
    else if (($(window).width() >= 850) && ($(window).width() <= 999)) {
        $("#iframeSlider").css("height", "350px");
    }
    else if (($(window).width() >= 1000) && ($(window).width() <= 1200)) {
        $("#iframeSlider").css("height", "400px");
    }
    else {
        $("#iframeSlider").css("height", "460px");
    }
});



