

//timepopupbox_hide_And_show
function AfterPlot() {

    $(document).ready(function () {
        //Added by pradip on 28-3-2023
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
        //$("#cboProxyResource").removeAttr("title");

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip();

        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='tab']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").hover(function () {
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal'], [data-bs-toggle='tab']").tooltip('update');
        });

       


        //Added by pradip_03-01-2018 for remove checkaall
        $("#ProjectFilterList li:not(:first-child)").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#ProjectFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });

        //Added By dipali V On 8th Jan 2018 For Task Type of smallPop 
        $("#selectprojecttask #FilterTaskCategories li:not(:first-child)").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#FilterTaskCategories li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });
        //End of Added By dipali V On 8th Jan 2018 For Task Type of smallPop 
        $("#TaskTypeFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskTypeFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });

        $("#TaskPhaseFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskPhaseFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });
        $("#TaskModuleFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskModuleFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });

        $("#TaskCategoryFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskCategoryFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });

        $("#TaskPriorityFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskPriorityFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });

        $("#TaskMilestoneFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskMilestoneFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });
        $("#TaskDeliverableFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskDeliverableFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });
        $("#TaskSubProjectFilterList").on('click', '[type=checkbox]', function () {
            if ($(this).is(":checked") == false) {
                $("#TaskSubProjectFilterList li:first-child input[type='checkbox']").removeAttr('checked');
            }
        });






        //Added by pradip_03-01-2018 for hide multiple pophoverr
        $('.dropdown.subtasktitle img[data-bs-toggle="popover"]').on('click', function (e) {
            $('img[data-bs-toggle="popover"]').not(this).popover('hide');

            $(".projecttaskinfo_tooltipbox_schedule .row .col-xs-7:empty").parent().hide();
            $(".projecttaskinfo_tooltipbox_schedule .row .issuetext:empty").parent().hide();

       

        });



        //Hide_filter
        $('body *').not('.statusfiltertble, .statusfiltertble *').click(function () {
            $('.statusfiltertble .tblfiltering').collapse('hide');
        });

        $('.statusfiltertble .tblfiltering').on('click', function (e) {
            if ($(this).hasClass('tblfiltering')) {
                e.stopPropagation();
            }
        });




        //table header top
        $(window).scroll(function () {
            var scroll = $(window).scrollTop();

            //>=, not <=
            if (scroll >= 100) {
                //clearHeader, not clearheader - caps H                    
                $("#tableheadfixer").removeClass("tblefixheadertop").addClass("tblefixheadertop");
            }
            else {
                $("#tableheadfixer").removeClass("tblefixheadertop");
                $(".timesheettable table tr th").css({ 'position': 'initial!important' });
            }

        });

       

        ////maintable_table_freez
        //; (function ($) {

        //    'use strict';

        //    $.fn.extend({

        //        tableHeadFixer: function (options) {

        //            var offset = this.offset(),       // Get the position coordinates of the table on the page
        //                th = this.find('th'),     // Get the header th tag
        //                delayTimer = null,                // Event throttling
        //                defaults = {
        //                    //'bgColor': '#e7edf0',           // Background color of the header
        //                    'z-index': '999',              //The z-index of the header
        //                    'transition': '0.3s ease-in-out 0s'          // Let the meter move slowly
        //                };

        //            options = $.extend({}, defaults, options);


        //            // Determine if there is a th tag, if it exists, go to the next step, otherwise, output ‘please write html structure according to the specification
        //            if (th.length === 0) {

        //                if (!!window.console) {
        //                    console.log('Please write the html structure according to the specification');
        //                }

        //            } else {

        //                // Add screen scroll event listener
        //                $(window).on('scroll', function () {

        //                    if (!delayTimer) {

        //                        delayTimer = setTimeout(function () {

        //                            var top = Math.max(document.body.scrollTop, document.documentElement.scrollTop),
        //                                left = Math.max(document.body.scrollLeft, document.documentElement.scrollLeft);

        //                            th.css({
        //                                'position': 'relative',
        //                                'top': (top > offset.top) ? (top - offset.top) : 0,
        //                                //'background-color': options.bgColor,
        //                                'z-index': options['z-index'],
        //                                'transition': options.transition
        //                            });

        //                            delayTimer = null;

        //                        }, 20);
        //                    }


        //                });

        //            }

        //        }


        //    });

        //})(jQuery);



        






       // $('#tableheadfixer').tableHeadFixer();

        $("div#ProxyResource .bootstrap-select button").tooltip({
            //$(this).hide();
        });

        $('.entryselectpro_selectfield button, #createtaskmodal .bootstrap-select button').hover(function (e) {
            $(this).attr('title', '');
        });

        //Added By RehanC for filter pop-up not closing issue on 30th Mar 2023
        $("body").on("click", ".nav-tabs [data-bs-toggle='dropdown']", function () {
            $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
            $(this).closest(".nav-tabs']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

        });

        $('body').on('click', function (e) {
            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".dropdown-menu").removeClass('show');
                }
            });
        });
        $(document).on("click", ".fa-pencil-alt, .edit_filter, .custom_chckbox_markblue label.clsHideTooltip, .custom_chckbox_markblue>span i", function () {
            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".nav-tabs .dropdown-menu").removeClass('show');
                }
            });
        });
         //End of Comment By RehanC for filter pop - up not closing issue on 30th Mar 2023

    });

    //tablefixer
    //$('#tableheadfixer').tableHeadFixer();



   




    $('body').mouseout(function () {
        $('.timepopupbox').hide();
    });
    $('.notelisticon').mouseover(function () {
        $('.timepopupbox').show();
    });

    $('.timepopupbox').mouseover(function () {
        $(this).show();
    });


    //start bootstrap datepicker css

    $('#datepicker').datepicker({
        autoclose: true
    });

    //start bootstrap datepicker css

    $('#STselectdate, #STpostdate, #RTselectdate, #CTselectdate').datepicker({
        autoclose: true
    });

    //End bootstrap datepicker css

    $("th span, .ui-corner-all").hover(function () {    
        $("th span, .ui-corner-all").tooltip('update');
    }); //added by pradip on 28-3-2023


    //table data input digits
    var time = document.getElementsByClassName('timenoinput'); //Get all elements with class "time"
    for (var i = 0; i < time.length; i++) { //Loop trough elements
        time[i].addEventListener('keypress', function () { //Add event listener to every element
            var reg = /[0-9]/;
            if (this.value.length == 2 && reg.test(this.value)) this.value = this.value + ":"; //Add colon if string length > 2 and string is a number 
            if (this.value.length > 5) this.value = this.value.substr(0, this.value.length - 1); //Delete the last digit if string length > 5
        });
    }
    var time = document.getElementsByClassName('hrss'); //Get all elements with class "time"
    for (var i = 0; i < time.length; i++) { //Loop trough elements
        time[i].addEventListener('keypress', function () { //Add event listener to every element
            var reg = /[0-9]/;
            if (this.value.length == 2 && reg.test(this.value)) this.value = this.value + ":"; //Add colon if string length > 2 and string is a number 
            if (this.value.length > 5) this.value = this.value.substr(0, this.value.length - 1); //Delete the last digit if string length > 5
        });
    }


    //either you can do this ( this is not optimised approach )

    //value remove on click
    //$('.timenoinput, .selecttimeno input').on('click focusin', function () {
    //    this.value = '';
    //});




    //autocomplete_focus
    $(document).on('focus', ':input', function () {
        $(this).attr('autocomplete', 'off');
    });

   

    //hidecolumn

    $(".click-me").click(function () {
        $(".table .toggleDisplay").toggleClass("in");
        $(".exapnd_and_collaps_column").toggleClass("extraweekdaycolshow");
    });

  


    //Task show and Hide
    $(".projecttitle_actions a[data-bs-toggle='collapse']").click(function () {

        $(this).toggleClass("procollapsdown");

    });



    //infopopup
    //$("document").ready(function () {
    $('.dropdown-menu.timeinfopopup').on('click', function (e) {
        if ($(this).hasClass('timeinfopopup')) {
            e.stopPropagation();
        }
    });
    //});


    //modalclose
    $('.modal').on('shown.bs.modal', function () {
        //$("input.live-search").val('');
        //$("input.live-search").trigger("keyup");
        var modalDiv = $(this);
        modalDiv.modal({ backdrop: false, show: true });

        //modal draggable 
        $('.modal-dialog').draggable({
            handle: ".modal-header"
        });

    });





    //togle button
    //$(document).ready(function () {
    $('#Mmenu_togglebtn').click(function () {
        $(this).toggleClass('open');
    });
    //});

    // change svg color


    //Checkall checkbox
    $('.checkAll').click(function (event) {  //on click 
  
        var $boxes = $(this).closest('div').find('input[type="checkbox"]');
        if (this.checked) { // check select status
            $boxes.each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes                
            });
        } else {
            $boxes.each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes under the checkAll checkbox                      
            });
        }
    });
    //Uncheck   one task then All should get deselected
    //$(".clsFilterTaskCategoryList").click(function () {
    //    $("#selectprojecttask .checkAll").attr('checked', false);
    //});
    $('.modal-content .close,.uncheckbtn').click(function () {
        $("#modaltaskfilte").removeClass("in");
        $("i.fas.fa-filter").attr("aria-expanded", "false");
        $(".optgroup-header input[type='checkbox']").attr("checked", false);
    });



    $("#hdScrollfixedtbl1 #Tapprovalall").click(function () {

        if (this.checked) {
            $("#fixedtbl1 input[type='checkbox']").attr("checked", true)

        }
        else {


            $("#fixedtbl1 input[type='checkbox']").attr("checked", false)
        }


    });
    //checkbox_in_more_project_popup
    $('#selectprojecttask .checkAll, #selectsubtask .checkAll').click(function (event) {  //on click 

        var $boxes = $(this).closest('table').find('input[type="checkbox"]');
        if (this.checked) { // check select status
            $boxes.each(function () { //loop through each checkbox
                this.checked = true;  //select all checkboxes                
            });
        } else {
            $boxes.each(function () { //loop through each checkbox
                this.checked = false; //deselect all checkboxes under the checkAll checkbox                      
            });
        }
    });

    $('.header-copy:gt(0)').hide();

    ////jquery for weekly and daily view calendar
    //$(".tab-slider--nav li").click(function () {

    //    if ($("#Dailytab").is(":visible")) {
    //        $("#dailyviewcal").hide();
    //        $("#weeklyviewcal").show();
    //    } else {
    //        $("#weeklyviewcal").hide();
    //        $("#dailyviewcal").show();
    //    }

    //});




    //weeekly and daily tab
    //$("document").ready(function () {

    //$("#dailyviewcal").show();

    //});

    $(".tab-slider--nav li").click(function () {
        $(".tab-slider--body").hide();
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn();
        if ($(this).attr("rel") == "Dailytab") {
            $('.tab-slider--tabs').addClass('slide');
        } else {
            $('.tab-slider--tabs').removeClass('slide');
        }
        $(".tab-slider--nav li").removeClass("active");
        $(this).addClass("active");
    });



    //tooltip
    $(function () {
        $('[data-bs-toggle="tooltip"]').tooltip();
        $('[data-bs-toggle="popover"]').tooltip();
        $('[data-bs-toggle="collapse"]').tooltip();
        $('[data-bs-toggle="dropdown"]').tooltip();
        $('[data-bs-toggle="modal"]').tooltip();
    });

    $("[data-bs-toggle=popover]").each(function (i, obj) {
     
        $(this).popover({
            html: true,
            content: function () {
                var id = $(this).attr('id')
                return $('#popover-content-' + id).html();
            }
        });

    });
    $(document).tooltip({
        selector: '.issuetext'
    });
    //close info dropdown
    /*$(".projecttaskinfo_tooltipbox .close img").click(function(){
     if ($('.timeinfopopup').is(':visible') ) {
      $(".timeinfopopup").fadeOut();
    }
    
     else {
     $(".timeinfopopup").fadeIn();
    
     }
      });*/

    $('.projecttaskinfo_tooltipbox .close').click(function () {
        $(this).parents('.dropdown').find('img.dropdown-toggle').dropdown('toggle')
    });



    //Status Tab

    $('.navstatuslink li a').on('click', function () {
        //Commented & Added By Dipali V On 19th May 2023 For Check box
        // $('input:checkbox').removeAttr('checked');
        $('input:checkbox').prop('checked', false);
            //End of Commented & Added By Dipali V On 19th May 2023 For Check box
        var $target = $(this).data('target');
        if ($target != 'all') {

            $('.table.statusfiltertble tbody  tr').css('display', 'none');
            $('.table.statusfiltertble tbody tr[data-status="' + $target + '"]').fadeIn('slow');
        } else {
            $('.table.statusfiltertble tbody tr').css('display', 'none').fadeIn('slow');
        }
    });









    $(".subtask").each(function (i) {
        var len = $(this).text().length;
        if (len > 25) {
            $(this).text($(this).text().substr(0, 25) + '..');
        }
    });
    $(".issuetext").each(function (i) {
        var len = $(this).text().length;
        if (len > 32) {
            $(this).text($(this).text().substr(0, 32) + '..');
        }
    });




    /*$('.navstatuslink li a').on('click', function () {
     navstatuslink*/


    /*if ($('.modal').height() > 700) {
   
       
        $(this).css('position':'absolute');
    }*/

    //Readmore and read less
    //$(document).ready(function () {
    // Configure/customize these variables.
    //var showChar = 81;  // How many characters are shown by default
    //var ellipsestext = "...";
    //var moretext = "more >";
    //var lesstext = "< less";


    //$('.more').each(function () {
    //    var content = $(this).html();

    //    if (content.length > showChar) {

    //        var c = content.substr(0, showChar);
    //        var h = content.substr(showChar, content.length - showChar);

    //        var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

    //        $(this).html(html);
    //    }

    //});

    //$(".morelink").click(function () {
    //    if ($(this).hasClass("less")) {
    //        $(this).removeClass("less");
    //        $(this).html(moretext);
    //    } else {
    //        $(this).addClass("less");
    //        $(this).html(lesstext);
    //    }
    //    $(this).parent().prev().toggle();
    //    $(this).prev().toggle();
    //    return false;
    //});
    //});


    //status tab desktop
    $(".customelinks li.statusapproved a, .customelinks li.statussubmitted a").on('click', function () {
        $(".btnlistinline").hide();
    });

    $(".customelinks li.statusrejected a, .customelinks li.statusallactive a").on('click', function () {
        $(".btnlistinline").show();
    });
    var isWeeklyView = 1;
    
    $("document").ready(function () {
   
    });
    
    $(".editviewtimesheet").on('click', function () {



        $(".taskdescriptionbox").hide();
        $(".timeinfopopupeditable").show();

        $(".editviewtimesheet").hide();
        $(".viewtimesheetsavetbtn").show();

        //backbutton
        $(".backbtn").show();

        $(".mainheadingtop").replaceWith("<div class='mainheadingtop'>Timesheet > Edit </div>");

        $('.viewtimesheetwrap .timenoinput, .viewtimesheetwrap .workcomplted, .viewtimesheetwrap table .projectsmenuicon, .viewtimesheetwrap table .custom_chckbox, .viewtimesheetwrap .selecttimeno, .viewtimesheetwrap .quickentryrecord, .viewtimesheetwrap table .borderbtn').css('pointer-events', 'unset');
        $('.MTdetail_wrap .timenoinput, .MTdetail_wrap .workcomplted, .MTdetail_wrap table .projectsmenuicon, .MTdetail_wrap table .custom_chckbox, .MTdetail_wrap .selecttimeno, .MTdetail_wrap .quickentryrecord, .MTdetail_wrap table .borderbtn').css('pointer-events', 'unset');

    });

    $(".mainheaderrighticons .editviewaction").on('click', function () {
        $(".mventryreplycomment").hide();
        $(".mventryreplybox textarea").show();

        $(".editviewaction").hide();
        $(".saveviewaction").show();
        $(".mainheadingtop").replaceWith("<div class='mainheadingtop'>Timesheet > Edit </div>");

        $('.mv_viewtimesheet .Mv_timeentryfield').css('pointer-events', 'unset');
    });




    if ($(".viewtimesheet_list").is(':visible')) {
        //$('.editviewaction').css('display','none');
    }
    else {
        $('.editviewaction').css('display', 'block');

    }

    //refresh on save click of save button in view timesheet screen
    $('.viewtimesheetwrap .viewtimesheetsavetbtn, .saveviewaction').click(function () {
        location.reload(true);
    });    // RELOAD PAGE ON BUTTON CLICK EVENT.



    //Freezetable
    //$(document).ready(function () {
    //Commeted by dipali V On 23rd Dec 2020 For Jquery Version
    //    $('.table-fixed-header').fixedHeader();
    //End of  Commeted by dipali V On 23rd Dec 2020 For Jquery Version
    //});



    //backbtn code

    function goBack() {
        window.history.back();
    }


    $(".tsapprovaltbl .custom_chckbox input[type='checkbox']").change(function () {
        $(this).closest('tr').toggleClass('activerow');
    });

    //statuslink_active  
    //  $(document).ready(function () {
    $(".navstatuslink>li>a").click(function () {
        $(".navstatuslink>li>a").removeClass("active");
        $(this).addClass("active");
    });

    //active-filter-color  
    $('.list-to-filter ul li input[type="checkbox"]').click(function (event) {  //on click 

        if ($('.list-to-filter ul li input[type="checkbox"]').is(':checked')) {
            $(this).parents('th').find('.fa-filter').css({ "color": "#1359a6" });
        } else {
            $(this).parents('th').find('.fa-filter').css({ "color": "#464a4c" });
        }


    });





    //uncheck
    $('.uncheckbtn').click(function () {
        $(".filterpanelbody input[type='checkbox']").attr("checked", false);
        FilterProjectData();
    });
    //uncheck
    $('.modal-content .close').click(function () {
        $(".optgroup-header input[type='checkbox']").attr("checked", false);

        //$("#hdScrollhistoryfixtbl").css("height","auto");

        //for remove previous search
        //$("input.live-search").val('');
        //$("input.live-search").trigger("keyup");

        //$("#projecttasksearch").val('');
        //$("#projecttasksearch").trigger("keyup");

    });


    //   });

    $("#subtasksearch").on("keyup", function () {
        //debugger;
        //var value = $(this).val().toLowerCase();
        //evt = (evt) ? evt : window.event;
        //var charCode = (evt.which) ? evt.which : evt.keyCode;
        //if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        //{

        //}
        //else {
        //    $("#SubTaskListTable tr").filter(function () {
        //        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        //    });
        //}

        var value = $(this).val().toLowerCase();

        $("#SubTaskListTable tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });
    });
   
    $("#projecttasksearch").on("keyup", function () {

        //var input, filter, table, tr, td, i, txtValue;
        //input = document.getElementById("projecttasksearch");
        //filter = input.value.toUpperCase();
        //table = document.getElementById("FilterTaskBody");
        //tr = table.getElementsByTagName("tr");
        //for (i = 0; i < tr.length; i++) {
        //    td = tr[i].getElementsByTagName("td")[0];
        //    if (td) {
        //        txtValue = td.textContent || td.innerText;
        //        if (txtValue.toUpperCase().indexOf(filter) > -1) {
        //            tr[i].style.display = "";
        //        } else {
        //            tr[i].style.display = "none";
        //        }
        //    }
        //}
        var value = $(this).val().toLowerCase();

        $("#FilterTaskBody tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
        });

    });
    $("#txtSearchBoxProjectNames").on("keyup", function (evt) {
        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#ProjectFilterList li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }
    });
    $("#txtSearchBoxTaskTypes").on("keyup", function (evt) {
        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#TaskTypeFilterList li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }
    });
    $("#subtasksearch").on("keyup", function (evt) {
        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#SubTaskListTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }
    });
    $("#TaskCategoriesSearch").on("keyup", function (evt) {

        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#FilterTaskCategories li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }

    });



    $("#txtSearchEmployee").on("keyup", function (evt) {
        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#EmployeeFilter li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }
    });
    $("#txtSearchStatus").on("keyup", function (evt) {
        var value = $(this).val().toLowerCase();
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode == 32)//|| (charCode == 8 || charCode == 46)
        {

        }
        else {
            $("#StatusFilterList li").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        }
    });
    

}

//function Start() {


//}
function StartLoader(bodyID) {    
    $(bodyID).addClass('preloader');
}


function StopLoader(bodyID) {
    jQuery(window).load(function () {

    });

   
}
function StopAjaxLoader(bodyID) {
    $(bodyID).removeClass("center");
    $(bodyID).removeClass("preloader");
    $(".resource_allocation").removeClass('clsShowHide');
}


//function StartLoader(bodyID) {

//    var progress2 = new LoadingOverlayProgress({
//        bar: {
//            "background": "#ddd",
//            "top": "50px",
//            "height": "30px",
//            "border-radius": "15px",
//            "background": " url('../../../Whizible2.0/dist/img/KloaderImage.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
//        },

//    });
//    $(bodyID).LoadingOverlay("show", {
//        custom: progress2.Init()
//    });
//}

//function StopLoader(bodyID) {
//    jQuery(window).load(function () {
//        // This gets executed when the content is loaded
//        $(bodyID).LoadingOverlay("hide", {

//        });
//    });
//}

//function StopAjaxLoader(bodyID) {
//    // This gets executed when the content is loaded
//    $(bodyID).LoadingOverlay("hide", {

//    });

//}



$("input[type='checkbox'].task").click(function () {
    

    var a = $("input[type='checkbox'].task");
    if (a.length == a.filter(":checked").length) {

        $("#Tapprovalall").prop('checked', true);

    }
    else {
        $("#Tapprovalall").prop('checked', false);
    }
});



$("th span, .ui-corner-all").hover(function () {
    $("th span, .ui-corner-all").tooltip('update');
}); //added by pradip on 28-3-2023
