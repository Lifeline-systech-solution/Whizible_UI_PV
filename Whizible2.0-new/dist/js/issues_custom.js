//Remove tooltip
$('body').on('click', function () {
    $('.tooltip').remove();
}); 

    //Task show and Hide
$("a.issuelistcollapse[data-toggle='collapse']").click(function() {
  $(this).toggleClass("ilcollapsdown");

});

//tooltip
//$(function () {
//  $('[data-toggle="tooltip"]').tooltip();
//  $('[data-toggle="tab"]').tooltip();
//  $('[data-toggle="collapse"]').tooltip();
//  $('[data-toggle="dropdown"]').tooltip();
//  $('[data-toggle="modal"]').tooltip();
//})
$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();

var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
});

//Freezetable
/*$(document).ready(function() {
    $('.table-fixed-header').fixedHeader();
});*/
  
//backbtn code
function goBack() {
    window.history.back();
}


$('.fplist').on('click', '.checkAll', function (event) {  //on click 
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

//checkbox_in_more_project_popup
$('.checkAll').click(function (event) {  //on click 
    var $boxes = $(this).closest('table').find('input[type="checkbox"]');
    if (this.checked)
    { // check select status
        $boxes.each(function () { //loop through each checkbox
            this.checked = true;  //select all checkboxes                
        });
    } else
    {
        $boxes.each(function () { //loop through each checkbox
            this.checked = false; //deselect all checkboxes under the checkAll checkbox                      
        });
    }
});

//addrow
//$(document).ready(function () {
//    var counter = 0;

//    $("#addrow").on("click", function () {
//        var newRow = $("<tr>");
//        var cols = "";

//        cols += '<td class=""><select class="form-control" name="name' + counter + '"><option>And</option><option>Or</option></select></td>';
//        cols += '<td class=""><select id="multiselect" class="form-control selectpicker" multiple="multiple" name="name' + counter + '"><option>Approval Status</option><option>Assigned To</option><option>Assigned 5</option><option>Assigned 1</option></select></td>';
//        cols += '<td class=""><select class="form-control" name="name' + counter + '"><option>=</option><option>&lt;&lt;</option><option>&gt;&gt;</option><option>&lt;</option><option>&gt;</option><option>&lt;=</option><option>&gt;=</option><option>Not Like</option><option>Like</option></select></td>';
//        cols += '<td class=""><input type="text" class="form-control" name="field' + counter + '"/></td>';        
        
//        cols += '<td class=""><button data-toggle="tooltip" data-placement="top" title="clear" id="ibtnDel" class="nostylebtn"><i class="far fa-trash-alt"></i></button></td>';
//        newRow.append(cols);
//        $("table.order-list").append(newRow);
//        counter++;
//    });



//    $(".addfilterrow").on("click", "#ibtnDel", function (event) {
//        $(this).closest("tr").remove();       
//        counter -= 1
//    });
//	$(".addfilterrow").on("click", ".clearallbtn", function (event) {
//        $(".issueorder-list").closest("tr").remove();       
//        counter -= 1
//    });


//});


//backbtn code

function goBack() {
    window.history.back();
}

//closable-alert
function Save_OnCLick() {
            $('#btnSave').prop("disabled", true);
            $('.alert-autocloseable-success').show();

            $('.alert-autocloseable-success').delay(5000).fadeOut("fast", function () {
                // Animation complete.
                $('#btnSave').prop("disabled", false);
            });
        }


//custome_input_file
function alertFilename() {
  var thefile = document.getElementById('thefile');
  document.getElementById('fileName').innerHTML =  thefile.value; }
  
  
  /* to toggle the sidebar, just switch the CSS classes */
//$(document).ready(function () {
//			$(".toggle-sidebar").click(function () {
//				$(this).toggleClass('topen');
//				$("#sidebarpanel").toggleClass("collapsed");
//				$("#contentfull").toggleClass("col-md-12 col-md-8");
				
//				return false;
//			});
//		});
  
  
  
//Readmore and read less
$(document).ready(function() {
    // Configure/customize these variables.
    var showChar = 72;  // How many characters are shown by default
    var ellipsestext = "...";
    var moretext = "more >>";
    var lesstext = "<< less";
    

    $('.more').each(function() {
        var content = $(this).html();
 
        if(content.length > showChar) {
 
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);
 
            var html = c + '<span class="moreellipses">' + ellipsestext+ '&nbsp;</span><span class="morecontent"><span style="display:none;">' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';
 
            $(this).html(html);
        }
 
    });
 
    $(".morelink").click(function(){
        if($(this).hasClass("less")) {
            $(this).removeClass("less");
            $(this).html(moretext);
        } else {
            $(this).addClass("less");
            $(this).html(lesstext);
        }
        $(this).parent().prev().toggle();
        $(this).prev().toggle();
        return false;
    });
    $("th span, .ui-corner-all").hover(function () {
        $("th span, .ui-corner-all").tooltip('update');
    }); //added by pradip on 24-3-2023

    //Added By RehanC for Tab Navigation Issue on 30th Mar 2023
    $(document).on('click', '.canceldetailpanel', function (event) {
        $('.detailsubtabs>li:first-child a[data-bs-toggle="tab"]').tab('show');

    });
    //End of Comment By RehanC for Tab navigation Issue on 30th Mar 2023

    //Added By RehanC for filter pop-up not closing issue on 30th Mar 2023
    $("body").on("click", ".nav-tabs [data-bs-toggle='dropdown']", function () {
        $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
        $(this).closest(".nav-tabs']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

    });
    
    $('body').on('click', function (e) {
        $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
            // hide any open popovers when the anywhere else in the body is clicked
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                $(".nav-tabs .dropdown-menu").removeClass('show');
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

    $("body").on("click", "[data-bs-toggle='dropdown']", function () {
        $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
        $(this).closest(".dropdown']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

    });

    $('body').on('click', function (e) {
        $('[data-bs-toggle="dropdown"]').each(function (e) {
            // hide any open popovers when the anywhere else in the body is clicked
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                $(".dropdown-menu").removeClass('show');
            }
        });
    });
            //modified by pradip on 10-5-2023
});


$("#adnewfilterbtn").click(function(){
 $(".hiddennewrow").show(); 
  });  

function showCalendar(ctrl) {
    $("#" + ctrl).datepicker({
        autoclose: true,
        changeMonth: true,
        dateFormat: 'dd M yy'
    });
    $("#" + ctrl).datepicker("show");
}

function validateDate(ctr) {
    if (ctr.value != "") {
        var pattern = /^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
      //  var pattern = /^([0-9]{2})\/(January | February | March | April | May | June | July | August | September | October | November | December)\/([0-9]{4})$/; 
        if (pattern.test(ctr.value)) {
            var d = new Date(ctr.value);
            if (isNaN(d.getDate())) {
                ctr.value = "";
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Enter Valid Date in MM/dd/YYYY format', 'error');
            }
        }
        else {
            ctr.value = "";
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Enter Valid Date in MM/dd/YYYY format', 'error');
        };
    }
}

function StartLoader(bodyID) {

    var progress2 = new LoadingOverlayProgress({
        bar: {
            "background": "#ddd",
            "top": "50px",
            "height": "30px",
            "border-radius": "15px",
            /*  Commented & Added By Dipali V On 4th April 2023 For Loader Image Path*/
            "background": " url('../../../Whizible2.0-new/dist/img/loading.gif') rgba( 255, 255, 255, .8 ) 100% 100% no-repeat"
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


$('#multiselect').selectpicker();

var arr = new Array();
$('.selectpicker').on('change', function(){
     $(this).find("option").each(function()
     {
         if($(this).is(":selected"))
         {             
            id = $(this).attr("id");
            if(arr.indexOf(id) == -1)
            {
               arr.push(id);
            }
         }
         else
         {
             id = $(this).attr("id");
             arr = jQuery.grep(arr, function(value) {
              return value != id;
            });             
         }
     });
  });





