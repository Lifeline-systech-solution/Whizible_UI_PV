

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectInformation_CommonPage.aspx.vb" Inherits="PbNIT.ProjectInformation_CommonPage" %>

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>
<script src="../Enhancement/Customer_XMLHttp.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /* Commented And Added By Vaijat K ON 03/11/2015*/
             /* width: 35%;*/
        /*width: 100% !important;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {

        //Added By Usha Pandit On 06.05.2020 For numderic field validation
        $('*[id*=CustomFieldNumeric]').each(function () {
            $(this).keypress(function (e) {
                var x = e.which || e.keycode;
                
                if ((x >= 48 && x <= 57) || x == 8 ||
                    (x >= 35 && x <= 40) || x == 46 || x == 45)
                    return true;
                else
                    return false;
            });
            $(this).keyup(function (e) {
                var curId = $(this).attr("id");
                //alert($("#" + curId).val());                
                if (disallowNonNumeric($("#" + curId)) == true) {
                    alert("Please enter only numeric value!!!");
                    $("#" + curId).val(0);
                    $("#" + curId).focus();
                }                
            });
        });
        //End Of Added By Usha Pandit On 06.05.2020 For numderic field validation

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        //Commented And Added By Vaijat K on 29/10/2015
          //  responsiveTopMenu();
        //Added By Usha Pandit On 09.04.2020 For javascript error
        if ($("#ProjectStatusID option:selected").val() == null) {
            $("#ProjectStatusID").val(1);
        }
        //End Of Added By Usha Pandit On 09.04.2020 For javascript error
        $("table").each(function (idd,val) {
            var cls = $(this).attr("class");
            //alert($(this).attr("width"))
            if (idd == 5)
            { 
                if ($(this).find('td').size() == 1) {
                    $(this).find('td').before('<td></td>');
                    }
                $(this).addClass('topInnerMenu');
                /* Append arrow image after right td for displaying additional menus*/
                //Commented and added by Yogesh J on 09/12/2015 issue id=2707
                //$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img src="../General/responsive/images/downarrow.png"/></div>');
                //Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
                //$('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img src="../General/responsive/images/downarrow.png" title="Expand"/></div>');
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').after('<div class="menu_arrow_img"><img id="imgDownArrow" style="background-image:url(../General/responsive/images/downarrow.png);background-repeat: no-repeat;height: 18px;" title="Expand"/></div>');
                //END Commented And Added By Vaijat K ON 22/09/2016 For Dynamic Theme
                // Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768              
                // Added By Sanyogeeta R ON 30/11/2016 For Resolution 1366*768               
               
                if (typeof ($("#imgDownArrow").css("background-image")) != "undefined") {
                    var strPath = $("#imgDownArrow").css("background-image").replace('url("', '');
                    strPath = strPath.substring(0, strPath.length - 2);
                    $("#imgDownArrow").attr("src", strPath);
                }
                // Added By Sanyogeeta R ON 24/11/2016 For Resolution 1366*768
                //End of addition by Yogesh J on 09/12/2015 issue id=2707
                /* Append ul after arrow image for displaying additional menus (Vertical Menus)*/
                $('.menu_arrow_img').after('<ul class="additional_clsTRMenu" style="display:none;position:absolute;z-index:999;"></ul>');
                /* Append custom ul to body for taking proper width*/
                $('body').append('<ul id="clsTRMenu_ul" style="visibility:hidden;" ></ul>');
                /* Append ul to body to display responsive menus (Horizantal Menus)*/
                $('body').append('<ul class="responsive_clsTRMenu" style="display:none;margin-top: 0%"></ul>');
                /* Append li to custom ul and copy each links from right td into it.*/
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function () {
                    $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
                    $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
                });

                /* Take width of right td */
                var wwidth = $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
                var calcWidth = wwidth;
                /*initially counter is zero*/
                var counter = 0;
                /*initially tempWidth is zero*/
                var tempWidth = 0;

                /* Calculate outer width for each li in custom ul */
                $('#clsTRMenu_ul').find('li').each(function () {    
                    var width = $(this).outerWidth();
                    tempWidth += width + 10;
                    /*if tempWidth is less than calculated width increment counter*/
                    if (tempWidth < calcWidth) {
                        counter++;
                    }
                });

                /* Display none custom ul*/
                $('#clsTRMenu_ul').css('display', 'none');

                /*if index of each anchor in right td is less than counter */
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('a').each(function () {
                    /* Code to remove separator of each anchor text in right td starts*/
                    var text = $(this).html();
                    if (text.indexOf("|") >= 0) {
                        var menuText = text.replace('|', '');
                        $(this).html(menuText);
                    }
                    /* Code to remove separator of each anchor text in right td ends*/

                    if ($(this).index() < counter) {
                        /* then append li to responsive menu ul */
                        $('.responsive_clsTRMenu').append('<li style="float: left;"></li>');
                        /* then copy  right td and append it to responsive ul*/
                        var default_li = $(this).clone();
                        $('.responsive_clsTRMenu').find('li').each(function () {
                            default_li.appendTo(this);
                        });
                    }
                        /*if index of each anchor in right td is greater than counter */
                    else {
                        /* then append li to additional menu ul*/
                        $('.additional_clsTRMenu').append('<li></li>');
                        /* then copy  right td and append it to additional ul */
                        var new_li = $(this).clone();
                        $('.additional_clsTRMenu').find('li').each(function () {
                            new_li.appendTo(this);
                        });
                    }
                });

                /* Make right td empty */
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
                /*clone responsive ul and append it to the right td*/
                $('.responsive_clsTRMenu:last').clone().appendTo($('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)'));
                /*Display block the responsive ul*/
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu').css('display', 'block');
                /* If additional Menu ul contains li then only display arrow image */
                if ($('.additional_clsTRMenu').find('li').length == 0) {
                    $('.menu_arrow_img').css({ 'display': 'none' });
                }

                $('.menu_arrow_img').find('img').click(function (e) {
                    e.stopPropagation();
                    $('.additional_clsTRMenu').slideToggle();
                });

                $('.additional_clsTRMenu').mouseleave(function () {
                    $(this).css('display', 'none');
                });

                $('.additional_clsTRMenu').click(function (e) {
                    e.stopPropagation();
                });

                $(document).hover(function () {
                    $('.additional_clsTRMenu').slideUp();
                });
            }
            //alert($(".clsPageBody> table:first").attr("class"));
            // compare id to what you want
        });
        //End Added By Vaijat K on 29/10/2015
        //responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/
        if (windowWidth < 992) {
            $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
            $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        //responsiveTopMenuResize();

        $("table").each(function (idd,val) {
            var cls = $(this).attr("class");
            //alert($(this).attr("width"))
            if (idd == 5) {
             
                /* Make Custom Menu ul empty*/
                $('#clsTRMenu_ul').empty();
                /* Display block Custom ul*/
                $('#clsTRMenu_ul').css('display', 'block');
                /* Make Responsive Menu ul empty*/
                $('.responsive_clsTRMenu:last').empty();
                /* Append li to custom ul and copy each links of responsive Menu ul to custom ul.*/
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu:first').find('a').each(function () {
                    $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
                    $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
                });
                /* Append li to custom ul and copy each links of Additional Menu ul to custom ul.*/
                $('.topInnerMenu').find('.clsTRMenu').find('.additional_clsTRMenu:first').find('a').each(function () {
                    $('#clsTRMenu_ul').append('<li style="float:left;list-style-type: none;"></li>');
                    $(this).clone().appendTo($('#clsTRMenu_ul').find('li:last'));
                });

                /* Make Additional ul empty*/
                $('.additional_clsTRMenu').empty();
                /* Take width of right td */
                var wwidth = $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').width();
                var calcWidth = wwidth;
                /*initially counter is zero*/
                var counter = 0;
                /*initially tempWidth is zero*/
                var tempWidth = 0;
                /* Calculate outer width for each li in custom ul */
                $('#clsTRMenu_ul').find('li').each(function () {
                    var width = $(this).outerWidth();
                    tempWidth += width + 10;            // +10 Modified By Vaijat K ON 23-11-2015
                    /*if tempWidth is less than calculated width increment counter*/
                    if (tempWidth < calcWidth) {
                        counter++;
                    }
                });

                /*if index of each li in custom ul is less than counter */
                $('#clsTRMenu_ul').find('li').each(function () {
                    if ($(this).index() < counter) {
                        /*then append li to responsive menu ul*/
                        $('.responsive_clsTRMenu:last').append('<li style="float: left;"></li>');
                        /*then copy  right td and append it to responsive ul*/
                        var default_li = $(this).find('a').clone();
                        $('.responsive_clsTRMenu:last').find('li').each(function () {
                            default_li.appendTo(this);
                        });
                    }

                    else {
                        /* then append li to additional menu ul*/
                        $('.additional_clsTRMenu').append('<li></li>');
                        /* then copy  right td and append it to additional ul */
                        var new_li = $(this).find('a').clone();
                        $('.additional_clsTRMenu').find('li').each(function () {
                            new_li.appendTo(this);
                        });
                    }
                });

                /* Make Custom ul display none*/
                $('#clsTRMenu_ul').css('display', 'none');

                /* make right td empty*/
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').empty();
                /*clone responsive ul and append it to the right td*/
                $('.responsive_clsTRMenu:last').clone().appendTo($('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)'));
                /*Display block the responsive ul*/
                $('.topInnerMenu').find('.clsTRMenu').find('td:nth-child(2)').find('.responsive_clsTRMenu').css('display', 'block');
                /* If additional Menu ul does not contains li then do not display arrow image */
                if ($('.additional_clsTRMenu').find('li').length == 0) {
                    $('.menu_arrow_img').css({ 'display': 'none' });
                }
                    /* If additional Menu ul contains li then display arrow image */
                else {
                    $('.menu_arrow_img').css({ 'display': 'block' });
                }
                /* slideToggle effect to additional Menu on onClick of arrow image starts */
                $('.menu_arrow_img').find('img').click(function (e) {
                    e.stopPropagation();
                });
                $('.additional_clsTRMenu').click(function (e) {
                    e.stopPropagation();
                });

                $(document).hover(function () {
                    $('.additional_clsTRMenu').slideUp();
                });
            }
          });
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
            $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');
        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>