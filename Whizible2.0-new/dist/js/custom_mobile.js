//Mobile Menu
function AfterResponsivePlot() {
    $('#Mmenu_togglebtn').click(function () {
        $(this).toggleClass('open');
        $('.Mv_mobmenu').toggleClass('Mv_mobmenu_open animated SlideInUp');
        $('body').toggleClass('Mv_mobmenushow');


    });

    //entry week day active
    var leftTimeout, left = $('.left');

    function scrollLeft() {
        $('.weektable-wrapper').scrollLeft($('.weektable-wrapper').scrollLeft() - 50);
        //$('.weektable-wrapper table tr th').removeClass('activeday');

        $.each($table.find('tr'), function () {
            $(this).children().last().detach().prependTo(this);
        });
    }

    left.mousedown(function () {
        scrollLeft();
        leftTimeout = setInterval(function () {
            scrollLeft();
        }, 500);

        return false;
    });
    $(document).mouseup(function () {
        clearInterval(leftTimeout);
        return false;
    });

    var rightTimeout, right = $('.right');

    function scrollRight() {
        $('.weektable-wrapper').scrollLeft($('.weektable-wrapper').scrollLeft() + 50);

        $.each($table.find('tr'), function () {

            //$('.weektable-wrapper table tr th').addClass('activeday');
            $(this).children().first().detach().appendTo(this);
        });
    }

    right.mousedown(function () {
        scrollRight();
        leftTimeout = setInterval(function () {
            scrollRight();
        }, 500);

        return false;
    });
    $(document).mouseup(function () {
        clearInterval(rightTimeout);
        return false;
    });



    //entry week day active
    $(".mobview_weektablehead tr th").click(function () {
        $(".mobview_weektablehead tr th").removeClass("activeday");
        // $(".tab").addClass("active"); // instead of this do the below 
        $(this).addClass("activeday");
    });

    //Hide and show panel responsive
    var $contents = $('.tab-content');
    $contents.slice(1).hide();
    $('.tab').click(function () {
        var $target = $('#' + this.id + 'show').show();
        $contents.not($target).hide();
    });


    ////status tab responsive
    //$('.navstatuslink li a').click(function () {
    //    // debugger;
    //    //var $target = $(this).data('target');
    //    var $target = $(this).attr('data-target');
    //    var $target = "#" + $target
    //    $("#statusall").removeClass('active');
    //    if ($target != '#statusall') {
    //        $('#DivMainBody .tabstatusdiv').css('display', 'none');
    //        $('#DivMainBody ' + $target + '').css('display', 'block');
    //    }
    //    else {
    //        $('#DivMainBody .tabstatusdiv').css('display', 'block');
    //    }
    //});

    //status tab mobile
    $(".customelinks li.statusapproved a, .customelinks li.statussubmitted a").on('click', function () {
        $(".Mvstatustabhide").hide();
    });

    //$(".customelinks li.statusrejected a, .customelinks li.statusallactive a").on('click', function () {
        $(".customelinks li.statusrejected a, .customelinks li.statusall a").on('click', function () {
        $(".Mvstatustabhide").show();
    });



    $('#ApproveAll').change(function () {
        $('.approvechktbl').prop("checked", this.checked);
        $('.rejectchktbl').prop("checked", this.checked);

    });

  

   




}

