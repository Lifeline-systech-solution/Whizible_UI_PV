$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:Include script and link tag dynamically
    // Description:To hide some data in Mobile and Tablet view
    // By Whom: Miiint
    // When:23/12/2014
    /*---------------------------------------------------------*/

    /* Dynamically creating script tag for footable.min.js and appending it to body*/
    $('font').attr('face', 'helvetica');
    $('font').attr('size', '2px');

    var js = document.createElement("script");
    var jsFilePath ='../../responsive/js/footable.min.js';
    js.type = "text/javascript";
    js.src = jsFilePath;
    $("body").append(js);

    /* Dynamically creating script tag for bootstrap.min.js and appending it to body*/
    var bootstrapJs = document.createElement("script");
     /*  Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade*/
    /* var bootstrapJsFilePath='../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js';*/

    var bootstrapJsFilePath = '../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js';
    bootstrapJs.type = "text/javascript";
    bootstrapJs.src = bootstrapJsFilePath;
    $("body").append(bootstrapJs);

    /*Dynamically creating link tag for footable.metro.min.css and appending it to body*/

    var link = document.createElement("link");
    var cssFilePath ='../../responsive/css/footable.metro.min.css';
    link.type = "text/css";
    link.rel="stylesheet";
    link.href = cssFilePath;
    $("body").append(link);

    /*Dynamically creating link tag for footable.core.min.css and appending it to body*/

    var coreLink = document.createElement("link");
    var coreCssFilePath ='../../responsive/css/footable.core.min.css';
    coreLink.type = "text/css";
    coreLink.rel="stylesheet";
    coreLink.href = coreCssFilePath;

    $("body").append(coreLink);

    /*Dynamically creating link tag for bootstrap.min.css and appending it to body*/
    var bootstrapLink = document.createElement("link");
    /*  Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade*/
/*    var bootstrapCssFilePath = '../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css';*/

    var bootstrapCssFilePath = '../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css';
    bootstrapLink.type = "text/css";
    bootstrapLink.rel="stylesheet";
    bootstrapLink.href = bootstrapCssFilePath;
    $("body").append(bootstrapLink);

    /*---------------------------------------------------------*/
    // Ends Feature Tag:Include script and link tag dynamically
    /*---------------------------------------------------------*/
   
});

/*----------------------------------------------------------*/
// Starts Feature Tag:FooTable Functionality
// Description:To hide some data in Mobile and Tablet view
// By Whom: Miiint
// When:23/12/2014
/*---------------------------------------------------------*/

/* Function for Footable starts*/
function dataCollapse(div_name)
{
    var tableClassName;
    $('#'+div_name).find('table.clsGridTable').each(function(){
        if($(this).find('thead').length >0)
        {
        }
        else
        {
            var codehtml=$(this).find('tr:first').html();
            $(this).find('tbody').before('<thead></thead>');
            $(this).find('tbody').find('tr:first').appendTo($(this).find('thead'));
            var newCodehtml=codehtml.replace(/<td/g, "<th");
            newCodehtml=newCodehtml.replace(/td>/g, "th>");
            $(this).find('tr:first').html(newCodehtml);
        }
        $(this).addClass('gridFootable');
        tableClassName='gridFootable';
    });

    $('.'+tableClassName).each(function()
    {
        /* Applying footable functionality to header part starts*/
        if($(this).find('tr:first').find('th').length> 0)
        {
            /* If index of header part is greater than 1*/
            $(this).find('tr:first').find('th').each(function(){
                if($(this).index()>1)
                {
                    /* Display two columns of header in Tablet and Mobile view*/
                    $(this).attr('data-hide','phone,tablet');
                }
            });
        }
        /* Applying footable functionality to header part ends*/

        /* Applying footable functionality to table td part starts*/
        else
        {
            $(this).find('tr:first').find('td').each(function(){
                /* If index of table td part is greater than 1*/
                if($(this).index()>1)
                {
                    /* Display two columns of td in Tablet and Mobile view*/
                    $(this).attr('data-hide','phone,tablet');
                }
            });
        }
        /* Applying footable functionality to table part ends*/
        $(this).footable();
    });
    //to solve select all issue, expanding first time & then again closing div for tablet view on Window load
    if($(window).width()< 992)
    {
        for(var i=0; i<2; i++)
        {
            //expanding first time & then again closing div for tab view
            $(".footable tbody tr:not(.footable-row-detail)").each(function(){
                $(this).trigger('footable_toggle_row');
            });
        }
        if($('.ContextMenu').length > 0)
        {
            $('.ContextMenu').css('display','none');//if context menu (i.e. onclick of link we get options) is present then we make it hide on ready
        }

        /*Reflect the checkbox state in Laptop view as per the checkbox state in Tablet view*/
        /*If reviewTypeContent div is present*/
        if($('#reviewTypeContent').length > 0)
        {
            $('.footable').each(function(){
                /*If row has footable-row-detail class*/
                $(this).find('tbody tr.footable-row-detail').each(function(){
                    $(this).click(function(){
                        $(this).find('.clsCheckBox').each(function(){
                            var checkboxId= $(this).attr('id');
                            var isChecked= $(this).prop('checked');
                            var trId=$(this).closest('tr').prev('tr').attr('id');
                            $(this).closest('tr').prev().find('#'+checkboxId ).prop('checked',isChecked);
                            if($(this).closest('table').hasClass('large_visible'))
                            {
                                $(this).closest('table').next().find('.small_visible').find('#'+trId).each(function(){
                                    $(this).find('#'+checkboxId ).prop('checked',isChecked);
                                });
                            }
                            else
                            {
                                $(this).closest('table').parent().prev().find('#'+trId).each(function(){
                                    $(this).find('#'+checkboxId ).prop('checked',isChecked);
                                });
                            }
                        });
                    });
                });
            });
        }
        /*If reviewTypeContent div is not present*/
        else
        {
            /*If row has footable-row-detail class*/
            $('.footable tbody tr.footable-row-detail').each(function(){
                $(this).click(function(){
                    $(this).find('.clsCheckBox').each(function(){
                        var checkboxId= $(this).attr('id');
                        var isChecked= $(this).prop('checked');
                        $(this).closest('tr').prev().find('#'+checkboxId ).prop('checked',isChecked);
                    });
                });
            });
        }
    }
    else
    {
        /*If reviewTypeContent div is present*/
        if($('#reviewTypeContent').length > 0)
        {
            $('.footable').each(function(){
                /*If row has no footable-row-detail class*/
                $(this).find('tbody tr:not(.footable-row-detail)').each(function(){
                    $(this).click(function(){
                        $(this).find('.clsCheckBox').each(function(){
                            var checkboxId= $(this).attr('id');
                            var isChecked= $(this).prop('checked');
                            var trId=$(this).closest('tr').attr('id');
                            if($(this).closest('table').hasClass('large_visible'))
                            {
                                $(this).closest('table').next().find('.small_visible').find('#'+trId).each(function(){
                                    $(this).find('#'+checkboxId).prop('checked',isChecked);
                                });
                            }
                            else
                            {
                                $(this).closest('table').parent().prev().find('#'+trId).each(function(){
                                    $(this).find('#'+checkboxId).prop('checked',isChecked);
                                });
                            }
                        });
                    });
                });
            });
        }
        /*If reviewTypeContent div is not present*/
        else
        {
            /*Reflect the checkbox state in Tablet view as per the checkbox state in Laptop view*/
            /*If row has footable-row-detail class*/
            $('.footable tbody tr.footable-row-detail').each(function(){
                $(this).click(function(){
                    $(this).find('.clsCheckBox').each(function(){
                        var checkboxId= $(this).attr('id');
                        var isChecked= $(this).prop('checked');
                        $(this).closest('tr').next().find('#'+checkboxId ).prop('checked',isChecked);
                    });
                });
            });
        }
    }
}

/* Function for Footable ends*/

/* Added By Vaijat K ON 03/11/2015 Purpose: HelpDesk Custom Forms Responsive Data Grid*/
function divDatacollapse(div_name) {
    var tableClassName;
    $('#' + div_name).find('table.clsGridTable').each(function () {
        if ($('#' + div_name).find('table.clsGridTable').find('thead').length > 0) {
        }
        else {
            var codehtml = $('#' + div_name).find('table.clsGridTable').find('.clsTRColumnHeader').html();
            $('#' + div_name).find('table.clsGridTable').find('tbody').before('<thead></thead>');
            $('#' + div_name).find('table.clsGridTable').find('tbody').find('.clsTRColumnHeader').appendTo($('#' + div_name).find('table.clsGridTable').find('thead'));
            var newCodehtml = codehtml.replace(/<td/g, "<th");
            newCodehtml = newCodehtml.replace(/td>/g, "th>");
            $('#' + div_name).find('table.clsGridTable').find('.clsTRColumnHeader').html(newCodehtml);
        }
        $('#' + div_name).find('table.clsGridTable').addClass('gridFootable');
        tableClassName = 'gridFootable';
    });

    $('.' + tableClassName).each(function () {
        /* Applying footable functionality to header part starts*/
        if ($(this).find('tr:first').find('th').length > 0) {
            /* If index of header part is greater than 1*/
            $(this).find('tr:first').find('th').each(function () {
                if ($(this).index() > 1) {
                    /* Display two columns of header in Tablet and Mobile view*/
                    $(this).attr('data-hide', 'phone,tablet');
                }
            });
        }
            /* Applying footable functionality to header part ends*/

            /* Applying footable functionality to table td part starts*/
        else {
            $(this).find('tr:first').find('td').each(function () {
                /* If index of table td part is greater than 1*/
                if ($(this).index() > 1) {
                    /* Display two columns of td in Tablet and Mobile view*/
                    $(this).attr('data-hide', 'phone,tablet');
                }
            });
        }
        /* Applying footable functionality to table part ends*/
        $(this).footable();
    });
    //to solve select all issue, expanding first time & then again closing div for tablet view on Window load
    if ($(window).width() < 992) {
        for (var i = 0; i < 2; i++) {
            //expanding first time & then again closing div for tab view
            $(".footable tbody tr:not(.footable-row-detail)").each(function () {
                $(this).trigger('footable_toggle_row');
            });
        }
        if ($('.ContextMenu').length > 0) {
            $('.ContextMenu').css('display', 'none');//if context menu (i.e. onclick of link we get options) is present then we make it hide on ready
        }

        /*Reflect the checkbox state in Laptop view as per the checkbox state in Tablet view*/
        /*If reviewTypeContent div is present*/
        if ($('#reviewTypeContent').length > 0) {
            $('.footable').each(function () {
                /*If row has footable-row-detail class*/
                $(this).find('tbody tr.footable-row-detail').each(function () {
                    $(this).click(function () {
                        $(this).find('.clsCheckBox').each(function () {
                            var checkboxId = $(this).attr('id');
                            var isChecked = $(this).prop('checked');
                            var trId = $(this).closest('tr').prev('tr').attr('id');
                            $(this).closest('tr').prev().find('#' + checkboxId).prop('checked', isChecked);
                            if ($(this).closest('table').hasClass('large_visible')) {
                                $(this).closest('table').next().find('.small_visible').find('#' + trId).each(function () {
                                    $(this).find('#' + checkboxId).prop('checked', isChecked);
                                });
                            }
                            else {
                                $(this).closest('table').parent().prev().find('#' + trId).each(function () {
                                    $(this).find('#' + checkboxId).prop('checked', isChecked);
                                });
                            }
                        });
                    });
                });
            });
        }
            /*If reviewTypeContent div is not present*/
        else {
            /*If row has footable-row-detail class*/
            $('.footable tbody tr.footable-row-detail').each(function () {
                $(this).click(function () {
                    $(this).find('.clsCheckBox').each(function () {
                        var checkboxId = $(this).attr('id');
                        var isChecked = $(this).prop('checked');
                        $(this).closest('tr').prev().find('#' + checkboxId).prop('checked', isChecked);
                    });
                });
            });
        }
    }
    else {
        /*If reviewTypeContent div is present*/
        if ($('#reviewTypeContent').length > 0) {
            $('.footable').each(function () {
                /*If row has no footable-row-detail class*/
                $(this).find('tbody tr:not(.footable-row-detail)').each(function () {
                    $(this).click(function () {
                        $(this).find('.clsCheckBox').each(function () {
                            var checkboxId = $(this).attr('id');
                            var isChecked = $(this).prop('checked');
                            var trId = $(this).closest('tr').attr('id');
                            if ($(this).closest('table').hasClass('large_visible')) {
                                $(this).closest('table').next().find('.small_visible').find('#' + trId).each(function () {
                                    $(this).find('#' + checkboxId).prop('checked', isChecked);
                                });
                            }
                            else {
                                $(this).closest('table').parent().prev().find('#' + trId).each(function () {
                                    $(this).find('#' + checkboxId).prop('checked', isChecked);
                                });
                            }
                        });
                    });
                });
            });
        }
            /*If reviewTypeContent div is not present*/
        else {
            /*Reflect the checkbox state in Tablet view as per the checkbox state in Laptop view*/
            /*If row has footable-row-detail class*/
            $('.footable tbody tr.footable-row-detail').each(function () {
                $(this).click(function () {
                    $(this).find('.clsCheckBox').each(function () {
                        var checkboxId = $(this).attr('id');
                        var isChecked = $(this).prop('checked');
                        $(this).closest('tr').next().find('#' + checkboxId).prop('checked', isChecked);
                    });
                });
            });
        }
    }
}
/*End Added By Vaijat K ON 03/11/2015 */

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-collapse & close for tablet view
// Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
// By Whom: Miiint
// When:17/02/2015
/*---------------------------------------------------------*/
function collapseDivsResize()
{
    if($(window).width()< 991)
    {
        if($('.ContextMenu').length==0)
        {
            for(var i=0; i<2; i++)
            {
                $(".footable tbody tr:not(.footable-row-detail)").each(function(){
                    $(this).trigger('footable_toggle_row');
                });
            }
            setTimeout(function(){for(var i=0; i<2; i++)
            {
                $(".footable tbody tr:not(.footable-row-detail)").each(function(){
                    $(this).trigger('footable_toggle_row');
                });
            } }, 500);
        }
        setTimeout(function(){  if($('.footable-row-detail').length >0){checkboxState_resize();}},1000);
    }
    else
    {
        changeCheckboxState_resize();
    }
}

/*----------------------------------------------------------*/
// Starts Feature Tag:Select All Functionality
// Description:Maintaining state of checkbox on window resize
// By Whom: Miiint
// When:30/04/2015
/*---------------------------------------------------------*/
function checkboxState_resize() // For tablet and mobile resolution on window resize
{
    /*If reviewTypeContent div is present*/
    if($('#reviewTypeContent').length > 0)
    {
        $(".footable").each(function(){
            /*If row has footable-row-detail class*/
            if($('.footable-row-detail').length>0)
            {
                $(this).find("tbody tr:not(.footable-row-detail)").each(function(){
                    $(this ).find('.clsCheckBox').each(function(){
                        var checkBoxId=$(this).attr('id');
                        var isChecked=$(this).prop('checked');
                        $(this).closest('tr').next().find('#'+checkBoxId).prop('checked',isChecked);
                        var rowId=$(this).closest('tr').attr('id');
                        $(this).closest('table').parent().prev().find('#'+rowId).find('#'+checkBoxId ).prop('checked',isChecked);
                    });
                });
            }
        });
    }

    /*If reviewTypeContent div is not present*/
    else
    {
        /*If row has no footable-row-detail class*/
        $(".footable tbody tr:not(.footable-row-detail)").each(function(){
            $(this ).find('.clsCheckBox').each(function(){
                var checkBoxId=$(this).attr('id');
                var isChecked=$(this).prop('checked');
                $(this).closest('tr').next().find('#'+checkBoxId).prop('checked',isChecked);
            });
        });
    }

    changeCheckboxState_resize();
}
/*---------------------------------------------------------*/
// Ends Feature Tag:Select All Functionality
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:Select All Functionality
// Description:Changing the state of checkbox on window resize
// By Whom: Miiint
// When:30/04/2015
/*---------------------------------------------------------*/
function changeCheckboxState_resize()
{
    /*If reviewTypeContent div is present*/
    if($('#reviewTypeContent').length > 0)//for reviewTypeContent
    {
        /*Reflect the checkbox state in Laptop view as per the checkbox state in Tablet view*/
        /*If row has footable-row-detail class*/
        if($('.footable-row-detail').length >0)
        {
            $('.footable').each(function(){
                $(this).find('tbody tr.footable-row-detail').each(function(){
                    $(this).click(function(){
                        $(this).find('.clsCheckBox').each(function(){
                            var checkboxId= $(this).attr('id');
                            var isChecked= $(this).prop('checked');
                            var trId=$(this).closest('tr').prev('tr').attr('id');
                            $(this).closest('tr').prev().find('#'+checkboxId ).prop('checked',isChecked);
                            if($(this).closest('table').hasClass('large_visible'))
                            {
                                $(this).closest('table').next().find('.small_visible').find('tr #'+trId).each(function(){
                                    $(this).find('#'+checkboxId ).prop('checked',isChecked);
                                });
                            }
                            else
                            {
                                $(this).closest('table').parent().prev().find('#'+trId).each(function(){
                                    $(this).find('#'+checkboxId ).prop('checked',isChecked);
                                });
                            }
                        });
                    });
                });
            });
        }
    }

    /*If reviewTypeContent div is not present*/
    else
    {
        /*Reflect the checkbox state in Laptop view as per the checkbox state in Tablet view*/
        /*If row has footable-row-detail class*/
        if($('.footable-row-detail').length >0)
        {
            $('.footable tbody tr.footable-row-detail').each(function(){
                $(this).click(function(){
                    $(this).find('.clsCheckBox').each(function(){
                        var checkboxId= $(this).attr('id');
                        var isChecked= $(this).prop('checked');
                        $(this).closest('tr' ).prev().find('#'+checkboxId ).prop('checked',isChecked);
                    });
                });
            });
            $('.footable tbody tr:not(.footable-row-detail)').each(function () {
                $(this).click(function () {
                    $(this).find('.clsCheckBox').each(function () {
                        var checkboxId = $(this).attr('id');
                        var isChecked = $(this).prop('checked');
                        $(this).closest('tr').next().find('#' + checkboxId).prop('checked', isChecked);
                    });
                });
            });
        }
        /*Reflect the checkbox state in Tablet view as per the checkbox state in Laptop view*/
        /*If row has no footable-row-detail class*/
        else if($('.footable-row-detail').length ==0)
        {
            $('.footable tbody tr.footable-row-detail').each(function(){
                $(this).click(function(){
                    $(this).find('.clsCheckBox').each(function(){
                        var checkboxId= $(this).attr('id');
                        var isChecked= $(this).prop('checked');
                        $(this).closest('tr').prev().find('#'+checkboxId ).prop('checked',isChecked);
                    });
                });
            });
        }
    }
}
/*---------------------------------------------------------*/
// Ends Feature Tag:Select All Functionality
/*---------------------------------------------------------*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-collapse & close for tablet view
/*---------------------------------------------------------*/

/*---------------------------------------------------------*/
// Ends Feature Tag:FooTable Functionality
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Inner Menu on document ready
// By Whom: Miiint
// When:08/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu on ready function Starts*/
function responsiveTopMenu()
{
    //Commented And Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1
    //if($('.clsHorizontalNavBody').length >0)
    //{
    //    if($('.clsHorizontalNavBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsHorizontalNavBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsHorizontalNavBody').find('table:first').addClass('topInnerMenu');
    //}
    //else if($('.clsBody').length > 0)
    //{
    //    if($('.clsBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsBody').find('table:first').addClass('topInnerMenu');
    //}

    //else if($('.clsPageBody').length > 0)
    //{
    //    if($('.clsPageBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsPageBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsPageBody').find('table:first').addClass('topInnerMenu');
    //}


    //else if($('.clsCommonSubTagBody').length > 0)
    //{
    //    if($('.clsCommonSubTagBody').find('table:first').find('td').size() ==1)
    //    {
    //        $('.clsCommonSubTagBody').find('table:first').find('td').before('<td></td>');
    //    }

    //    $('.clsCommonSubTagBody').find('table:first').addClass('topInnerMenu');
    //}

    //else if($('.clsFullPageBody').length >0)
    //{
    //    if($('.clsFullPageBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsFullPageBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsFullPageBody').find('table:first').addClass('topInnerMenu');
    //}
    //else if($('.clsHelpBody').length >0)
    //{
    //    if($('.clsHelpBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsHelpBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsHelpBody').find('table:first').addClass('topInnerMenu');
    //}


    if ($('.clsHorizontalNavBody').length > 0) {
        if ($('.clsHorizontalNavBody').find('table:first').find('td').length == 1) {
            $('.clsHorizontalNavBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsHorizontalNavBody').find('table:first').addClass('topInnerMenu');
    }
    else if ($('.clsBody').length > 0) {
        if ($('.clsBody').find('table:first').find('td').length == 1) {
            $('.clsBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsBody').find('table:first').addClass('topInnerMenu');
    }

    else if ($('.clsPageBody').length > 0) {
        if ($('.clsPageBody').find('table:first').find('td').length == 1) {
            $('.clsPageBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsPageBody').find('table:first').addClass('topInnerMenu');
    }


    else if ($('.clsCommonSubTagBody').length > 0) {
        if ($('.clsCommonSubTagBody').find('table:first').find('td').length == 1) {
            $('.clsCommonSubTagBody').find('table:first').find('td').before('<td></td>');
        }

        $('.clsCommonSubTagBody').find('table:first').addClass('topInnerMenu');
    }

    else if ($('.clsFullPageBody').length > 0) {
        if ($('.clsFullPageBody').find('table:first').find('td').length == 1) {
            $('.clsFullPageBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsFullPageBody').find('table:first').addClass('topInnerMenu');
    }
    else if ($('.clsHelpBody').length > 0) {
        if ($('.clsHelpBody').find('table:first').find('td').length == 1) {
            $('.clsHelpBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsHelpBody').find('table:first').addClass('topInnerMenu');
    }
    //End Of Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1


    /* Append arrow image after right td for displaying additional menus*/

    //Commented and added by Yogesh J on 09/12/2015 issue id=2707
    //$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img src="images/downarrow.png"/></div>');
    //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img src="images/downarrow.png" title="Expand"/></div>');
     $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img id="imgDownArrow" style="background-image:url(images/downarrow.png);background-repeat: no-repeat;height: 18px;" /></div>'); //title="Expand" src = "images/downarrow.png"
    //end Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //End of addition by Yogesh J issue id=2707
    // Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768
     
       if (typeof($("#imgDownArrow").css("background-image")) != "undefined") {
         var strPath = $("#imgDownArrow").css("background-image").replace('url("', '');
         strPath = strPath.substring(0, strPath.length - 2);
         $("#imgDownArrow").attr("src", strPath);
     }
    // Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768
    // Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    /* Append ul after arrow image for displaying additional menus (Vertical Menus)*/
    $('.menu_arrow_img').after('<ul class="additional_clsTRMenu" style="display:none;position:absolute;z-index:999;"></ul>');
    /* Append custom ul to body for taking proper width*/
    $('body').append('<ul id="clsTRMenu_ul" style="visibility:hidden;" ></ul>');
    /* Append ul to body to display responsive menus (Horizantal Menus)*/
    $('body').append('<ul class="responsive_clsTRMenu" style="display:none;margin-top: 0%"></ul>');
    /* Append li to custom ul and copy each links from right td into it.*/
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
    });

    /* Take width of right td */
    var wwidth=$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;

    /* Calculate outer width for each li in custom ul */
    $('#clsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width + 10; //Modified By Vaijat K ON 17/12/2015
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /* Display none custom ul*/
    $('#clsTRMenu_ul').css('display','none');

    /*if index of each anchor in right td is less than counter */
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        /* Code to remove separator of each anchor text in right td starts*/
        var text = $(this).html();
        if (text.indexOf("|") >= 0)
        {
            var menuText=text.replace('|', '');
            $(this).html(menuText);
        }
        /* Code to remove separator of each anchor text in right td ends*/

        if($(this).index() < counter)
        {
            /* then append li to responsive menu ul */
            $('.responsive_clsTRMenu').append('<li style="float: left;"></li>');
            /* then copy  right td and append it to responsive ul*/
            var default_li=$(this).clone();
            $('.responsive_clsTRMenu').find('li').each(function(){
                default_li.appendTo(this);
            });
        }
        /*if index of each anchor in right td is greater than counter */
        else
        {
            /* then append li to additional menu ul*/
            $('.additional_clsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).clone();
            $('.additional_clsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make right td empty */
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.responsive_clsTRMenu:last').clone().appendTo( $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu').css('display','block');
    /* If additional Menu ul contains li then only display arrow image */
    if($('.additional_clsTRMenu').find('li').length == 0)
    {
        $('.menu_arrow_img').css({'display':'none'});
    }

    $('.menu_arrow_img').find('img').click(function(e){
        e.stopPropagation();
        $('.additional_clsTRMenu').slideToggle();
    });

    $('.additional_clsTRMenu').mouseleave(function(){
        $(this).css('display','none');
    });

    $('.additional_clsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.additional_clsTRMenu').slideUp();
    });
}
/* Function for responsive Top Menu on ready function Ends*/
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Inner Menu on Window Resize
// By Whom: Miiint
// When:08/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu on Resize function Starts*/
function responsiveTopMenuResize()
{
    /* Make Custom Menu ul empty*/
    $('#clsTRMenu_ul').empty();
    /* Display block Custom ul*/
    $('#clsTRMenu_ul').css('display','block');
    /* Make Responsive Menu ul empty*/
    $('.responsive_clsTRMenu:last').empty();
    /* Append li to custom ul and copy each links of responsive Menu ul to custom ul.*/
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu:first').find('a').each(function(){
        $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
    });
    /* Append li to custom ul and copy each links of Additional Menu ul to custom ul.*/
    $('.topInnerMenu').find('.clsTRMenu').find('.additional_clsTRMenu:first').find('a').each(function(){
        $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
    });

    /* Make Additional ul empty*/
    $('.additional_clsTRMenu').empty();
    /* Take width of right td */
    var wwidth=$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;
    /* Calculate outer width for each li in custom ul */
    $('#clsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        //tempWidth += width;       Commented & Added by Puneet M ON 23-11-2015
        tempWidth += width + 10;
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /*if index of each li in custom ul is less than counter */
    $('#clsTRMenu_ul').find('li').each(function(){
        if($(this).index() < counter)
        {
            /*then append li to responsive menu ul*/
            $('.responsive_clsTRMenu:last').append('<li style="float: left;"></li>');
            /*then copy  right td and append it to responsive ul*/
            var default_li=$(this).find('a').clone();
            $('.responsive_clsTRMenu:last').find('li').each(function(){
                default_li.appendTo(this);
            });
        }

        else
        {
            /* then append li to additional menu ul*/
            $('.additional_clsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).find('a').clone();
            $('.additional_clsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make Custom ul display none*/
    $('#clsTRMenu_ul').css('display','none');

    /* make right td empty*/
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.responsive_clsTRMenu:last').clone().appendTo( $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu').css('display','block');
    /* If additional Menu ul does not contains li then do not display arrow image */
    if($('.additional_clsTRMenu').find('li').length == 0)
    {
        $('.menu_arrow_img').css({'display':'none'});
    }
    /* If additional Menu ul contains li then display arrow image */
    else
    {
        $('.menu_arrow_img').css({'display':'block'});
    }
    /* slideToggle effect to additional Menu on onClick of arrow image starts */
    $('.menu_arrow_img').find('img').click(function(e){
        e.stopPropagation();
    });
    $('.additional_clsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.additional_clsTRMenu').slideUp();
    });
}

/* Function for responsive Top Menu on Resize function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

/* Function for responsive Top Menu on ready function Starts*/
function responsiveFooterMenu()
{
    //Commented And Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1
    //if($('#divContextMenu').length >0)
    //{
    //    $('.clsTable:last').addClass('footerMenuTable');
    //    if($('.footerMenuTable').find('td').size()==1)
    //    {
    //        $('.footerMenuTable').find('td').before('<td></td>');
    //    }
    //}
    //else if($('#divCtMnCTQ').length >0)
    //{
    //    $('.clsTable:last').addClass('footerMenuTable');
    //    if($('.footerMenuTable').find('td').size()==1)
    //    {
    //        $('.footerMenuTable').find('td').before('<td></td>');
    //    }
    //}
    //else if($('#divCtMn_MyQri').length >0)
    //{
    //    $('.clsTable:last').addClass('footerMenuTable');
    //    if($('.footerMenuTable').find('td').size()==1)
    //    {
    //        $('.footerMenuTable').find('td').before('<td></td>');
    //    }
    //}
    //else
    //{
    //    if($('.clsBody').length >0)
    //    {
    //        if($('.clsBody').find('table:last').find('td').size()==1)
    //        {
    //            $('.clsBody').find('table:last').find('td').before('<td></td>');
    //        }
    //        $('.clsBody').find('table:last').addClass('footerMenuTable');
    //    }

    //    else if($('.clsPageBody').length > 0)
    //    {
    //        if($('.clsPageBody').find('table:last').find('td').size() ==1)
    //        {
    //            $('.clsPageBody').find('table:last').find('td').before('<td></td>');

    //        }
    //        $('.clsPageBody').find('table:last').addClass('footerMenuTable');
    //    }

    //    else if($('.clsCommonSubTagBody'). length > 0)
    //    {
    //        if($('.clsCommonSubTagBody').find('table:last').find('td').size() ==1)
    //        {
    //            $('.clsCommonSubTagBody').find('table:last').find('td').before('<td></td>');
    //        }
    //        $('.clsCommonSubTagBody').find('table:last').addClass('footerMenuTable');
    //    }

    //    else if($('.clsHelpBody').length >0)
    //    {
    //        if($('.clsHelpBody').find('table:last').find('td').size()==1)
    //        {
    //            $('.clsHelpBody').find('table:last').find('td').before('<td></td>');
    //        }
    //        $('.clsHelpBody').find('table:last').addClass('footerMenuTable');

    //    }

    //    /*else if($('.clsHorizontalNavPageBody').length >0)
    //     {
    //     if($('.clsHorizontalNavPageBody').find('table:last').find('td').size()==1)
    //     {
    //     $('.clsHorizontalNavPageBody').find('table:last').find('td').before('<td></td>');
    //     }
    //     $('.clsHorizontalNavPageBody').find('table:last').addClass('footerMenuTable');

    //     }
    //     */
    //}


    if ($('#divContextMenu').length > 0) {
        $('.clsTable:last').addClass('footerMenuTable');
        if ($('.footerMenuTable').find('td').length == 1) {
            $('.footerMenuTable').find('td').before('<td></td>');
        }
    }
    else if ($('#divCtMnCTQ').length > 0) {
        $('.clsTable:last').addClass('footerMenuTable');
        if ($('.footerMenuTable').find('td').length == 1) {
            $('.footerMenuTable').find('td').before('<td></td>');
        }
    }
    else if ($('#divCtMn_MyQri').length > 0) {
        $('.clsTable:last').addClass('footerMenuTable');
        if ($('.footerMenuTable').find('td').length == 1) {
            $('.footerMenuTable').find('td').before('<td></td>');
        }
    }
    else {
        if ($('.clsBody').length > 0) {
            if ($('.clsBody').find('table:last').find('td').length == 1) {
                $('.clsBody').find('table:last').find('td').before('<td></td>');
            }
            $('.clsBody').find('table:last').addClass('footerMenuTable');
        }

        else if ($('.clsPageBody').length > 0) {
            if ($('.clsPageBody').find('table:last').find('td').length == 1) {
                $('.clsPageBody').find('table:last').find('td').before('<td></td>');

            }
            $('.clsPageBody').find('table:last').addClass('footerMenuTable');
        }

        else if ($('.clsCommonSubTagBody').length > 0) {
            if ($('.clsCommonSubTagBody').find('table:last').find('td').length == 1) {
                $('.clsCommonSubTagBody').find('table:last').find('td').before('<td></td>');
            }
            $('.clsCommonSubTagBody').find('table:last').addClass('footerMenuTable');
        }

        else if ($('.clsHelpBody').length > 0) {
            if ($('.clsHelpBody').find('table:last').find('td').length == 1) {
                $('.clsHelpBody').find('table:last').find('td').before('<td></td>');
            }
            $('.clsHelpBody').find('table:last').addClass('footerMenuTable');

        }

        /*else if($('.clsHorizontalNavPageBody').length >0)
         {
         if($('.clsHorizontalNavPageBody').find('table:last').find('td').size()==1)
         {
         $('.clsHorizontalNavPageBody').find('table:last').find('td').before('<td></td>');
         }
         $('.clsHorizontalNavPageBody').find('table:last').addClass('footerMenuTable');

         }
         */
    }

    //End Of Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1

    /* Append arrow image after right td for displaying additional menus*/

    //Commented and added by Yogesh J on 09/12/2015 issue id=2707
    //$('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="footer_menu_arrow"><img src="images/uparrow.png"/></div>');
    //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //$('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="footer_menu_arrow"><img src="images/uparrow.png" title="Expand"/></div>');
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="footer_menu_arrow"><img id="imgUpArrow" style="background-image:url(images/uparrow.png);background-repeat: no-repeat;height: 18px;" title="Expand"/></div>'); //src = "images/uparrow.png"
    //End Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //End of addition by Yogesh J on 09/12/2015 issue id=2707
    //Commented And Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768
    if (typeof($("#imgUpArrow").css("background-image")) !== "undefined") {
        var strPath = $("#imgUpArrow").css("background-image").replace('url("', '');
        strPath = strPath.substring(0, strPath.length - 2);
        $("#imgUpArrow").attr("src", strPath);
    }
    //End Of Commented And Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768

    /* Append ul after arrow image for displaying additional menus (Vertical Menus)*/
    $('.footer_menu_arrow').after('<ul class="footer_additional_clsTRMenu" style="display:none;position:absolute;z-index:999;"></ul>');
    /* Append custom ul to body for taking proper width*/
    $('body').append('<ul id="footer_clsTRMenu_ul" style="visibility:hidden;" ></ul>');
    /* Append ul to body to display responsive menus (Horizantal Menus)*/
    $('body').append('<ul class="footer_responsive_clsTRMenu" style="display:none;margin-top: 0%"></ul>');
    /* Append li to custom ul and copy each links from right td into it.*/
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        $('#footer_clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_clsTRMenu_ul').find('li:last'));
    });

    /* Take width of right td */
    var wwidth=$('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;

    /* Calculate outer width for each li in custom ul */
    $('#footer_clsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width + 10; //+10 Modified By  Vaijat K ON 17/12/2015
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /* Display none custom ul*/
    $('#footer_clsTRMenu_ul').css('display','none');

    /*if index of each anchor in right td is less than counter */
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        /* Code to remove separator of each anchor text in right td starts*/
        var text = $(this).html();
        if (text.indexOf("|") >= 0)
        {
            var menuText=text.replace('|', '');
            $(this).html(menuText);
        }
        /* Code to remove separator of each anchor text in right td ends*/

        if($(this).index() < counter)
        {
            /* then append li to responsive menu ul */
            $('.footer_responsive_clsTRMenu').append('<li style="float: left;"></li>');
            /* then copy  right td and append it to responsive ul*/
            var default_li=$(this).clone();
            $('.footer_responsive_clsTRMenu').find('li').each(function(){
                default_li.appendTo(this);
            });
        }

        /*if index of each anchor in right td is greater than counter */
        else
        {
            /* then append li to additional menu ul*/
            $('.footer_additional_clsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).clone();
            $('.footer_additional_clsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make right td empty */
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.footer_responsive_clsTRMenu:last').clone().appendTo( $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_clsTRMenu').css('display','block');
    /* If additional Menu ul contains li then only display arrow image */
    if($('.footer_additional_clsTRMenu').find('li').length == 0)
    {
        $('.footer_menu_arrow').css({'display':'none'});
    }
    $('.footer_menu_arrow').find('img').click(function(e)
    {
        e.stopPropagation();
        $('.footer_additional_clsTRMenu').slideToggle();

    });

    $('.footer_additional_clsTRMenu').mouseleave(function(){
        $(this).css('display','none');

    });

    $('.footer_additional_clsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.footer_additional_clsTRMenu').slideUp();
    });

}
/* Function for responsive Top Menu on ready function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Footer InnerMenuDropDown
// Description:Creating DropDown for Footer Inner Menu on Window Resize
// By Whom: Miiint
// When:08/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu on Resize function Starts*/
function responsiveFooterMenuResize()
{
    /* Make Custom Menu ul empty*/
    $('#footer_clsTRMenu_ul').empty();
    /* Display block Custom ul*/
    $('#footer_clsTRMenu_ul').css('display','block');
    /* Make Responsive Menu ul empty*/
    $('.footer_responsive_clsTRMenu:last').empty();
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_clsTRMenu:first').find('a').each(function(){
        $('#footer_clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_clsTRMenu_ul').find('li:last'));
    });
    /* Append li to custom ul and copy each links of Additional Menu ul to custom ul.*/
    $('.footerMenuTable').find('.clsTRMenu').find('.footer_additional_clsTRMenu:first').find('a').each(function(){
        $('#footer_clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_clsTRMenu_ul').find('li:last'));
    });

    /* Make Additional ul empty*/
    $('.footer_additional_clsTRMenu').empty();
    /* Take width of right td */
    var wwidth=$('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;
    /* Calculate outer width for each li in custom ul */
    $('#footer_clsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        //tempWidth += width;
        tempWidth += width + 10;        // ADDED BY VAIJAT ON 23-11-2015
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /*if index of each li in custom ul is less than counter */
    $('#footer_clsTRMenu_ul').find('li').each(function(){
        if($(this).index() < counter)
        {
            /*then append li to responsive menu ul*/
            $('.footer_responsive_clsTRMenu:last').append('<li style="float: left;"></li>');
            /*then copy  right td and append it to responsive ul*/
            var default_li=$(this).find('a').clone();
            $('.footer_responsive_clsTRMenu:last').find('li').each(function(){
                default_li.appendTo(this);
            });
        }

        else
        {
            /* then append li to additional menu ul*/
            $('.footer_additional_clsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).find('a').clone();
            $('.footer_additional_clsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make Custom ul display none*/
    $('#footer_clsTRMenu_ul').css('display','none');

    /* make right td empty*/
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.footer_responsive_clsTRMenu:last').clone().appendTo( $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.footerMenuTable').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_clsTRMenu').css('display','block');
    /* If additional Menu ul does not contains li then do not display arrow image */
    if($('.footer_additional_clsTRMenu').find('li').length == 0)
    {
        $('.footer_menu_arrow').css({'display':'none'});
    }
    /* If additional Menu ul contains li then display arrow image */
    else
    {
        $('.footer_menu_arrow').css({'display':'block'});
    }
    /* slideToggle effect to additional Menu on onClick of arrow image starts */
    $('.footer_menu_arrow').find('img').click(function(e){
        e.stopPropagation();
    });
    $('.footer_additional_clsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.footer_additional_clsTRMenu').slideUp();
    });

}
/* Function for responsive Top Menu on Resize function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Footer InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Sub Table Inner Menu on document Ready
// By Whom: Miiint
// When:14/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu of Sub Table on ready function Starts*/
function responsiveSubTableTopMenu()
{

    //Commented And Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1
    //if($('.clsHorizontalNavPageBody').length >0)
    //{
    //    if($('.clsHorizontalNavPageBody').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsHorizontalNavPageBody').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsHorizontalNavPageBody').find('table:first').addClass('subTagTableMenu');
    //}

    //if($('.clsPageBody').find('.clsSubTagTable').length >0)
    //{
    //    if($('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').addClass('subTagTableMenu');
    //}

    //if($('.clsPageBody').find('#divSection2').find('table:first').length >0)
    //{
    //    if($('.clsPageBody').find('#divSection2').find('table:first').find('td').size() == 1)
    //    {
    //        $('.clsPageBody').find('#divSection2').find('table:first').find('td').before('<td></td>');
    //    }
    //    $('.clsPageBody').find('#divSection2').find('table:first').addClass('subTagTableMenu');
    //}

    if ($('.clsHorizontalNavPageBody').length > 0) {
        if ($('.clsHorizontalNavPageBody').find('table:first').find('td').length == 1) {
            $('.clsHorizontalNavPageBody').find('table:first').find('td').before('<td></td>');
        }
        $('.clsHorizontalNavPageBody').find('table:first').addClass('subTagTableMenu');
    }

    if ($('.clsPageBody').find('.clsSubTagTable').length > 0) {
        if ($('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').find('td').length == 1) {
            $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').find('td').before('<td></td>');
        }
        $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:first').addClass('subTagTableMenu');
    }

    if ($('.clsPageBody').find('#divSection2').find('table:first').length > 0) {
        if ($('.clsPageBody').find('#divSection2').find('table:first').find('td').length == 1) {
            $('.clsPageBody').find('#divSection2').find('table:first').find('td').before('<td></td>');
        }
        $('.clsPageBody').find('#divSection2').find('table:first').addClass('subTagTableMenu');
    }
    //End Of Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1

    var outerHeight=0;
    /* Append arrow image after right td for displaying additional menus*/

    //Commented by Yogesh J on 09/12/2015 issue id=2707 
    //$('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableMenuArrow"><img src="images/downarrow.png"/></div>');
    //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //$('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableMenuArrow"><img src="images/downarrow.png"  title="Expand"/></div>');
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableMenuArrow"><img id="imgDownArrow" style="background-image:url(images/downarrow.png);background-repeat: no-repeat;height: 18px;"  title="Expand"/></div>'); //src = "images/downarrow.png"
    //End Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //End of addition by Yogesh J on 09/12/2015 issue id=2707

    /* Append ul after arrow image for displaying additional menus (Vertical Menus)*/

    $('.subTableMenuArrow').after('<ul class="additional_subClsTRMenu" style="display:none;position:absolute;z-index:999;"></ul>');
    /* Append custom ul to body for taking proper width*/
    $('body').append('<ul id="subClsTRMenu_ul" style="visibility:hidden;" ></ul>');
    /* Append ul to body to display responsive menus (Horizantal Menus)*/
    $('body').append('<ul class="responsive_subClsTRMenu" style="display:none;margin-top: 0%"></ul>');
    /* Append li to custom ul and copy each links from right td into it.*/
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        $('#subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#subClsTRMenu_ul').find('li:last'));
    });

    /* Take width of right td */
    var wwidth=$('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;

    /* Calculate outer width for each li in custom ul */
    $('#subClsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width;
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /* Display none custom ul*/
    $('#subClsTRMenu_ul').css('display','none');

    /*if index of each anchor in right td is less than counter */
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        /* Code to remove separator of each anchor text in right td starts*/
        var text = $(this).html();
        if (text.indexOf("|") >= 0)
        {
            var menuText=text.replace('|', '');
            $(this).html(menuText);
        }
        /* Code to remove separator of each anchor text in right td ends*/

        if($(this).index() < counter)
        {
            /* then append li to responsive menu ul */
            $('.responsive_subClsTRMenu').append('<li style="float: left;"></li>');
            /* then copy  right td and append it to responsive ul*/
            var default_li=$(this).clone();
            $('.responsive_subClsTRMenu').find('li').each(function(){
                default_li.appendTo(this);
            });
        }
        /*if index of each anchor in right td is greater than counter */
        else
        {
            /* then append li to additional menu ul*/
            $('.additional_subClsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).clone();
            $('.additional_subClsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }


    });

    /* Make right td empty */
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.responsive_subClsTRMenu:last').clone().appendTo( $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_subClsTRMenu').css('display','block');
    /* If additional Menu ul contains li then only display arrow image */
    if($('.additional_subClsTRMenu').find('li').length == 0)
    {
        $('.subTableMenuArrow').css({'display':'none'});
    }

    $('.subTableMenuArrow').find('img').click(function(e)
    {
        e.stopPropagation();
        $('.additional_subClsTRMenu').slideToggle();
    });


    $('.additional_subClsTRMenu').mouseleave(function(){
        $(this).css('display','none');

    });

    $('.additional_subClsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){

        $('.additional_subClsTRMenu').slideUp();
    });
}
/* Function for responsive Top Menu of Sub Table on ready function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Sub Table Inner Menu on Window Resize
// By Whom: Miiint
// When:14/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu on Resize function Starts*/
function responsiveSubTableTopMenuResize()
{
    /* Make Custom Menu ul empty*/
    $('#subClsTRMenu_ul').empty();
    /* Display block Custom ul*/
    $('#subClsTRMenu_ul').css('display','block');
    /* Make Responsive Menu ul empty*/
    $('.responsive_subClsTRMenu:last').empty();
    /* Append li to custom ul and copy each links of responsive Menu ul to custom ul.*/
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_subClsTRMenu:first').find('a').each(function(){
        $('#subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#subClsTRMenu_ul').find('li:last'));
    });
    /* Append li to custom ul and copy each links of Additional Menu ul to custom ul.*/
    $('.subTagTableMenu').find('.clsTRMenu').find('.additional_subClsTRMenu:first').find('a').each(function(){
        $('#subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#subClsTRMenu_ul').find('li:last'));
    });

    /* Make Additional ul empty*/
    $('.additional_subClsTRMenu').empty();
    /* Take width of right td */
    var wwidth=$('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;
    /* Calculate outer width for each li in custom ul */
    $('#subClsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width;
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /*if index of each li in custom ul is less than counter */
    $('#subClsTRMenu_ul').find('li').each(function(){
        if($(this).index() < counter)
        {
            /*then append li to responsive menu ul*/
            $('.responsive_subClsTRMenu:last').append('<li style="float: left;"></li>');
            /*then copy  right td and append it to responsive ul*/
            var default_li=$(this).find('a').clone();
            $('.responsive_subClsTRMenu:last').find('li').each(function(){
                default_li.appendTo(this);
            });
        }

        else
        {
            /* then append li to additional menu ul*/
            $('.additional_subClsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).find('a').clone();
            $('.additional_subClsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make Custom ul display none*/
    $('#subClsTRMenu_ul').css('display','none');

    /* make right td empty*/
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.responsive_subClsTRMenu:last').clone().appendTo( $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.subTagTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_subClsTRMenu').css('display','block');
    /* If additional Menu ul does not contains li then do not display arrow image */
    if($('.additional_subClsTRMenu').find('li').length == 0)
    {
        $('.subTableMenuArrow').css({'display':'none'});
    }
    /* If additional Menu ul contains li then display arrow image */
    else
    {
        $('.subTableMenuArrow').css({'display':'block'});
    }
    /* slideToggle effect to additional Menu on onClick of arrow image starts */
    $('.subTableMenuArrow').find('img').click(function(e){
        e.stopPropagation();
    });
    $('.additional_subClsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.additional_subClsTRMenu').slideUp();
    });
}

/* Function for responsive Top Menu on Resize function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-InnerMenuDropDown
// Description:Creating DropDown for Sub Table Footer Inner Menu on document Ready
// By Whom: Miiint
// When:14/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Top Menu of Sub Table on ready function Starts*/
function responsiveSubTableFooterMenu()
{
    //Commented And Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1
    //if($('.clsHorizontalNavPageBody').length >0)
    //{
    //    if($('.clsHorizontalNavPageBody').find('table:last').find('td').size() == 1)
    //    {
    //        $('.clsHorizontalNavPageBody').find('table:last').find('td').before('<td></td>');
    //    }
    //    $('.clsHorizontalNavPageBody').find('table:last').addClass('footerSubTableMenu');
    //}

    //if($('.clsPageBody').length >0)
    //{
    //    if($('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:last').find('td').size()==1)
    //    {
    //        $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:last').find('td').before('<td></td>');
    //    }
    //    $('.clsPageBody').find('#divSection2').find('table:last').addClass('footerSubTableMenu');
    //}

    if ($('.clsHorizontalNavPageBody').length > 0) {
        if ($('.clsHorizontalNavPageBody').find('table:last').find('td').length == 1) {
            $('.clsHorizontalNavPageBody').find('table:last').find('td').before('<td></td>');
        }
        $('.clsHorizontalNavPageBody').find('table:last').addClass('footerSubTableMenu');
    }

    if ($('.clsPageBody').length > 0) {
        if ($('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:last').find('td').length == 1) {
            $('.clsPageBody').find('#divSection2').find('.clsSubTagTable').find('table:last').find('td').before('<td></td>');
        }
        $('.clsPageBody').find('#divSection2').find('table:last').addClass('footerSubTableMenu');
    }
    //End Of Added By Usha Pandit For changing size() with length as it is deprecated in jquery version 3.5.1

    /* Append arrow image after right td for displaying additional menus*/

    //Commented by Yogesh J on 09/12/2015 issue id=2707
    //$('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableFooterMenuArrow"><img src="images/uparrow.png"/></div>');
    //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //$('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableFooterMenuArrow"><img src="images/uparrow.png" title="Expand"/></div>');
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="subTableFooterMenuArrow"><img id="imgUpArrow" style="background-image:url(images/uparrow.png);background-repeat: no-repeat;height: 18px;" title="Expand"/></div>'); //src = "images/uparrow.png"
    //END Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //End of addition by Yogesh J on 09/12/2015

    /* Append ul after arrow image for displaying additional menus (Vertical Menus)*/
    $('.subTableFooterMenuArrow').after('<ul class="footer_additional_subClsTRMenu" style="display:none;position:absolute;z-index:999;"></ul>');
    /* Append custom ul to body for taking proper width*/
    $('body').append('<ul id="footer_subClsTRMenu_ul" style="visibility:hidden;" ></ul>');
    /* Append ul to body to display responsive menus (Horizantal Menus)*/
    $('body').append('<ul class="footer_responsive_subClsTRMenu" style="display:none;margin-top: 0%"></ul>');
    /* Append li to custom ul and copy each links from right td into it.*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        $('#footer_subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_subClsTRMenu_ul').find('li:last'));
    });

    /* Take width of right td */
    var wwidth=$('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;

    /* Calculate outer width for each li in custom ul */
    $('#footer_subClsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width;
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /* Display none custom ul*/
    $('#footer_subClsTRMenu_ul').css('display','none');

    /*if index of each anchor in right td is less than counter */
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function(){
        /* Code to remove separator of each anchor text in right td starts*/
        var text = $(this).html();
        if (text.indexOf("|") >= 0)
        {
            var menuText=text.replace('|', '');
            $(this).html(menuText);
        }
        /* Code to remove separator of each anchor text in right td ends*/

        if($(this).index() < counter)
        {
            /* then append li to responsive menu ul */
            $('.footer_responsive_subClsTRMenu').append('<li style="float: left;"></li>');
            /* then copy  right td and append it to responsive ul*/
            var default_li=$(this).clone();
            $('.footer_responsive_subClsTRMenu').find('li').each(function(){
                default_li.appendTo(this);
            });
        }
        /*if index of each anchor in right td is greater than counter */
        else
        {
            /* then append li to additional menu ul*/
            $('.footer_additional_subClsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).clone();
            $('.footer_additional_subClsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }


    });

    /* Make right td empty */
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.footer_responsive_subClsTRMenu:last').clone().appendTo( $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_subClsTRMenu').css('display','block');
    /* If additional Menu ul contains li then only display arrow image */
    if($('.footer_additional_subClsTRMenu').find('li').length == 0)
    {
        $('.subTableFooterMenuArrow').css({'display':'none'});
    }

    $('.subTableFooterMenuArrow').find('img').click(function(e){
        e.stopPropagation();
        $('.footer_additional_subClsTRMenu').slideToggle();
    });
    $('.footer_additional_subClsTRMenu').click(function(e){
        e.stopPropagation();
    });


    $('.footer_additional_subClsTRMenu').mouseleave(function(){
        $(this).css('display','none');

    });

    $(document).hover(function(){
        $('.footer_additional_subClsTRMenu').slideUp();
    });
}

/* Function for responsive Top Menu of Sub Table on ready function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-InnerMenuDropDown
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-SubTable FooterMenuDropDown
// Description:Creating DropDown for Sub Table Footer Menu on Window Resize
// By Whom: Miiint
// When:14/01/2015
/*---------------------------------------------------------*/

/* Function for responsive Footer Menu on Resize function Starts*/

function responsiveSubTableFooterMenuResize()
{

    /* Make Custom Menu ul empty*/
    $('#footer_subClsTRMenu_ul').empty();
    /* Display block Custom ul*/
    $('#footer_subClsTRMenu_ul').css('display','block');
    /* Make Responsive Menu ul empty*/
    $('.footer_responsive_subClsTRMenu:last').empty();
    /* Append li to custom ul and copy each links of responsive Menu ul to custom ul.*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_subClsTRMenu:first').find('a').each(function(){
        $('#footer_subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_subClsTRMenu_ul').find('li:last'));
    });
    /* Append li to custom ul and copy each links of Additional Menu ul to custom ul.*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('.footer_additional_subClsTRMenu:first').find('a').each(function(){
        $('#footer_subClsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
        $(this).clone().appendTo($('#footer_subClsTRMenu_ul').find('li:last'));
    });

    /* Make Additional ul empty*/
    $('.footer_additional_subClsTRMenu').empty();
    /* Take width of right td */
    var wwidth=$('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
    var calcWidth=wwidth;
    /*initially counter is zero*/
    var counter=0;
    /*initially tempWidth is zero*/
    var tempWidth=0;
    /* Calculate outer width for each li in custom ul */
    $('#footer_subClsTRMenu_ul').find('li').each(function(){
        var width = $(this).outerWidth();
        tempWidth+=width;
        /*if tempWidth is less than calculated width increment counter*/
        if(tempWidth < calcWidth)
        {
            counter++;
        }
    });

    /*if index of each li in custom ul is less than counter */
    $('#footer_subClsTRMenu_ul').find('li').each(function(){
        if($(this).index() < counter)
        {
            /*then append li to responsive menu ul*/
            $('.footer_responsive_subClsTRMenu:last').append('<li style="float: left;"></li>');
            /*then copy  right td and append it to responsive ul*/
            var default_li=$(this).find('a').clone();
            $('.footer_responsive_subClsTRMenu:last').find('li').each(function(){
                default_li.appendTo(this);
            });
        }

        else
        {
            /* then append li to additional menu ul*/
            $('.footer_additional_subClsTRMenu').append('<li></li>');
            /* then copy  right td and append it to additional ul */
            var new_li=$(this).find('a').clone();
            $('.footer_additional_subClsTRMenu').find('li').each(function(){
                new_li.appendTo(this);
            });
        }
    });

    /* Make Custom ul display none*/
    $('#footer_subClsTRMenu_ul').css('display','none');

    /* make right td empty*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
    /*clone responsive ul and append it to the right td*/
    $('.footer_responsive_subClsTRMenu:last').clone().appendTo( $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)'));
    /*Display block the responsive ul*/
    $('.footerSubTableMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.footer_responsive_subClsTRMenu').css('display','block');
    /* If additional Menu ul does not contains li then do not display arrow image */
    if($('.footer_additional_subClsTRMenu').find('li').length == 0)
    {
        $('.subTableFooterMenuArrow').css({'display':'none'});
    }
    /* If additional Menu ul contains li then display arrow image */
    else
    {
        $('.subTableFooterMenuArrow').css({'display':'block'});
    }
    /* slideToggle effect to additional Menu on onClick of arrow image starts */
    $('.subTableFooterMenuArrow').find('img').click(function(e){
        e.stopPropagation();
    });
    $('.footer_additional_subClsTRMenu').click(function(e){
        e.stopPropagation();
    });

    $(document).hover(function(){
        $('.footer_additional_subClsTRMenu').slideUp();
    });

}
/* Function for responsive Footer Menu on Resize function Ends*/

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-FooterMenuDropDown
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Web Form Extension Type
// Description:Remove section header row in Tablet and Mobile view
// By Whom: Miiint
// When:16/01/2015
/*---------------------------------------------------------*/

function removeSectionHeader()
{


    if($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0)
    {
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').addClass('tableHeaderParentDiv');
    }

    if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListPageTag').length ==0)
    {
        $('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').before('<div class="divListPageTag"></div>');
        $('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').appendTo($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('.divListPageTag'));
    }

    if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('.divListPageTag').find('table').find('.clsTRSectionHeader').length > 0)
    {
        $('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('.divListPageTag').addClass('tableHeaderParentDiv');
    }

    if($('.tableHeaderParentDiv').find('thead').length >0)
    {
    }

    else
    {
        var codehtml=$('.tableHeaderParentDiv').find('tr:first').html();
        $('.tableHeaderParentDiv').find('tbody').before('<thead></thead>');
        $('.tableHeaderParentDiv').find('tbody').find('tr:first').appendTo($('.tableHeaderParentDiv').find('thead'));
        var newCodehtml=codehtml.replace(/<td/g, "<th");
        newCodehtml=newCodehtml.replace(/td>/g, "th>");
        $('.tableHeaderParentDiv').find('tr:first').html(newCodehtml);
    }

    $('.tableHeaderParentDiv').find('div:first').after( '<div id="contentTableOuterdivTablet"></div>');

    $('.tableHeaderParentDiv').find('div:first').clone().appendTo($('.tableHeaderParentDiv').find('#contentTableOuterdivTablet'));
    var sectionHeaderText='';
    if($('.tableHeaderParentDiv').find('#contentTableOuterdivTablet').find('table').find('.clsTRSectionHeader').length > 0)
    {
        $('.tableHeaderParentDiv').find('#contentTableOuterdivTablet').find('table').find('tr').each(function(){
            if($(this).hasClass('clsTRSectionHeader'))
            {

                sectionHeaderText=$(this).find('td').text();

                $(this).remove();
            }
            else
            {

                $(this).find('td:first').text(sectionHeaderText);
            }
        });
    }
    $('#contentTableOuterdivTablet').find('div:first').removeAttr('id');
    $('#contentTableOuterdivTablet').find('div:first').attr('id','tabletDivListTag');
    var divName=$('#contentTableOuterdivTablet').find('div:first').attr('id');
    if($('.clsGridTable').length > 0)
    {
        dataCollapse(divName);
    }
    if($('.tableHeaderParentDiv').find('table').find('.clsTRSectionHeader').length > 0);
    {
        $('.tableHeaderParentDiv').find('div:first').addClass('hidden-sm hidden-xs');
        $('.tableHeaderParentDiv').find('#contentTableOuterdivTablet').find('table').removeClass('hidden-sm hidden-xs').addClass('hidden-lg hidden-md');
    }
}
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
/*---------------------------------------------------------*/

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-Responsive Navigation Tabs
// Description:Display navigation tabs in dropdown
// By Whom: Miiint
// When:07/02/2015
/*---------------------------------------------------------*/

function responsiveNavigationTabs(responsiveNavigationTableTab,ParentTblClass)
{
    $('.'+responsiveNavigationTableTab).after('<div id="selectedTabsDiv"></div>');
    $('.'+ParentTblClass).css('position','relative');
    $('.'+responsiveNavigationTableTab).css('display','none');
    /* Append arrow image after right td for displaying dropdown menus*/
    //$('.'+ParentTblClass).find('#selectedTabsDiv').after('<div class="navigation_arrow_img"><img src="images/navigationarrow.png"/></div>');

    //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    //$('.' + ParentTblClass).find('#selectedTabsDiv').after('<div class="navigation_arrow_img"><img src="images/navigationarrow.png" title="Expand"/></div>');
    $('.' + ParentTblClass).find('#selectedTabsDiv').after('<div class="navigation_arrow_img"><img id="imgNavigateArrow" style="background-image:url(images/navigationarrow.png);background-repeat: no-repeat;height:18px;" title="Expand"/></div>'); //<img src="images/navigationarrow.png" title="Expand"/>
    //End Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
    var divSecondSectionUL= $('.'+ParentTblClass).find('#selectedTabsDiv').after('<ul class="divSecondSectionUL"></ul>');

    $('.'+responsiveNavigationTableTab).find('.clsTRBody').find('td:not(:first)').each(function()
    {
        $('.divSecondSectionUL').append('<li></li>');
        $('.divSecondSectionUL').find('li:last').html($(this).html());

    });

    $('.'+ParentTblClass).find('.divSecondSectionUL').find('li').each(function()
    {
        if($(this).find('#selected').length > 0)
        {

            $(this).find('#selected').appendTo($('#selectedTabsDiv'));
            $(this).remove();

        }

    });

    $('.navigation_arrow_img').click(function(e)
    {
        e.stopPropagation();
        $('.'+ParentTblClass).find('.divSecondSectionUL').slideToggle();

    });

    $('.divSecondSectionUL').mouseleave(function(){
        $(this).css('display','none');

    });

    $('.divSecondSectionUL').click(function(e)
    {
        e.stopPropagation();
    });

    /*This code hides the dropdown when clicked on anywhere on the page*/
    $(document).hover(function()
    {
        $('.divSecondSectionUL').slideUp();
    });

    if($('.divSecondSectionUL').find('li').length >0)
    {

        $('.navigation_arrow_img').css('display','block');
    }

    else
    {

        $('.navigation_arrow_img').css('display','none');

    }
}


function responsiveNavigationTabsResize()
{

    var windowWidth=$(window).width();
    if(windowWidth < 992)
    {
        if($('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').length > 0)
        {
            $('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').css('display','block');
            $('.responsiveNavigationTabsClass').parent().find('.divSecondSectionUL').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.navigation_arrow_img').css('display','block');
            $('.gridTabsOuterTable').find('table:first').css('display','none');
        }
        else
        {
            var responsiveNavigationTabsClass='responsiveNavigationTabsClass';
            var responsiveNavigationParentTblClass='gridTabsOuterTable';
            responsiveNavigationTabs(responsiveNavigationTabsClass,responsiveNavigationParentTblClass);
        }

        if( $('.responsiveNavigationTabsClass').parent().find('.divSecondSectionUL').find('li').length > 0)
        {
            $('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').css('display','block');
            $('.responsiveNavigationTabsClass').parent().find('.divSecondSectionUL').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.navigation_arrow_img').css('display','block');
            $('.gridTabsOuterTable').find('table:first').css('display','none');
        }

        else
        {
            $('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.divSecondSectionUL').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.navigation_arrow_img').css('display','none');
            $('.gridTabsOuterTable').find('table:first').css('display','block');
        }

    }
    else
    {

        if($('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').length > 0)
        {
            $('.responsiveNavigationTabsClass').parent().find('#selectedTabsDiv').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.divSecondSectionUL').css('display','none');
            $('.responsiveNavigationTabsClass').parent().find('.navigation_arrow_img').css('display','none');
            $('.gridTabsOuterTable').find('table:first').css('display','block');
        }

    }

}

/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Responsive Navigation Tabs
/*---------------------------------------------------------*/


/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-onclick
// Description:applying onclick event to <u></u>
// By Whom: Miiint
// When:27/04/2015
/*---------------------------------------------------------*/
function display_contextmenu(tableId)
{
    $('#'+tableId).find('tr').find('td').each(function()
    {
        var onclick_string=$(this).attr('onclick');
        $(this).attr('onclick','');
        $(this).find('u').attr('onclick',onclick_string);
    });

}
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-onclick
/*---------------------------------------------------------*/

//Added by Ashwini M on 29-3-2023
//For need to apply patch on QA site
//End of Added by Ashwini M on 29-3-2023