<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_ResourceDeamnd_ActivityPlan.aspx.vb" Inherits="PbNIT.HR_ResourceDeamnd_ActivityPlan" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
    
	<%CommonFunctions.General.PlotPageHeadTag("Role Details")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>

<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*#divTblGrid
    {
        height:752px !important; // Commented By Vidya J ON 19-12-2015  Issue ID:2437
    }*/
    /*Added by dipali v on 31st Dec 2020 For Scroll issue*/
    #divTblGrid {
        overflow: scroll;
        width: 100%;
        height: 569px!important;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
       
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
    //    responsiveTopMenu(); Commented By Nilesh G on 16/11/2015 for show Filter Image
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        //    responsiveFooterMenu();   Commented By Nilesh G on 16/11/2015
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

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

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
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        //   responsiveFooterMenuResize(); Commented By Nilesh G on 16/11/2015
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 );}
	#Tajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; margin-left:-370px; }/*modified by pradip on 04-12-2021*/
	#Tajax_tooltipObj DIV { POSITION: absolute; }
	#Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; BORDER-RIGHT: red 2px solid; BORDER-BOTTOM: red 2px solid; BORDER-TOP: red 2px solid; BORDER-LEFT: red 2px solid; }
	#Bajax_tooltipObj DIV { POSITION: absolute; }

	/*#Tajax_tooltipObj .ajax_tooltip_TLarrow { BACKGROUND-POSITION: right top; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }*/
	/*#Tajax_tooltipObj .ajax_tooltip_TLarrow { Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/TLarrow.gif'); WIDTH: 40px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 63px }*/ 
    /*commented css by pradip on 12-4-2021*/

#Tajax_tooltipObj>div, #Bajax_tooltipObj>div{ width:370px!important; min-width:200px!important;}

    /*add css by pradip on 12-4-2021*/
    #Tajax_tooltipObj .ajax_tooltip_TLarrow {
    Z-INDEX: 999;
    BACKGROUND-IMAGE: url(../../Images/TLarrow.gif);
    WIDTH: 40px;
    BACKGROUND-REPEAT: no-repeat;
    HEIGHT: 63px;
    transform: skewX(-54deg);
    background-position: 0px 3px;
    left: 330px;
}  /*End css by pradip on 12-4-2021*/
	

    /*#Bajax_tooltipObj .ajax_tooltip_BRarrow { BACKGROUND-POSITION: bottom right ; Z-INDEX: 999; BACKGROUND-IMAGE: url('../../Images/BRarrow.gif'); BACKGROUND-REPEAT: no-repeat; }*/
        /*add css by pradip on 12-4-2021*/
    #Bajax_tooltipObj .ajax_tooltip_BRarrow {
    Z-INDEX: 999;
    BACKGROUND-IMAGE: url(../../Images/TLarrow.gif);
    WIDTH: 40px;
    BACKGROUND-REPEAT: no-repeat;
    HEIGHT: 63px;
    transform: skewX(-54deg);
    background-position: 0px 3px;
    left: 330px;
}  /*End css by pradip on 12-4-2021*/
   #Bajax_tooltipObj { Z-INDEX: 1000; TEXT-ALIGN: left; margin-left:-370px; }/*modified by pradip on 04-12-2021*/

	#Tajax_tooltipObj .ajax_tooltip_Tcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; top:18px }
	#Bajax_tooltipObj .ajax_tooltip_Bcontent { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	</STYLE>
		<form id="frmHR_OpportunityRole" method="post" runat="server" ScrollBars="Vertical" width="100%">
			<%PageInit%>
            <%--Commented And Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue--%>
			<%--<DIV id="Tajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">--%>
            <DIV id="Tajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
                <%--End Of Added By Usha Pandit On 25.07.2020 For  Arrow of pop up pointing to correct link issue--%>
				<DIV class="ajax_tooltip_Tcontent" id="Tajax_tooltip_content"></DIV>
				<DIV class="ajax_tooltip_TLarrow" id="Tajax_tooltip_arrow"></DIV>
			</DIV>
            <%--Commented And Added By Usha Pandit On 25.07.2020 For  Arrow of pop up pointing to correct link issue--%>
			<DIV id="Bajax_tooltipObj" style="DISPLAY: none; LEFT: 188px; POSITION: absolute; TOP: 165px">
                <%--End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue--%>
				<DIV class="ajax_tooltip_Bcontent" id="Bajax_tooltip_content"></DIV>
				<DIV class="ajax_tooltip_BLarrow" id="Bajax_tooltip_arrow"></DIV>
			</DIV>
		</form>
		<SCRIPT language="javascript">
var objform=GetFormReference('frmHR_OpportunityRole');
objdivlist = GetObjectReference('frmHR_OpportunityRole', 'divTblGrid');
var box,arr,con;
var wbox,hbox; 
var bwidth = document.body.offsetWidth;
var bheight = document.body.offsetHeight;
var gEvt;
var xPos,yPos;

//document.onmousedown = docOnDown;
//document.onmousemove = docOnmove;

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

function docOnmove(evt)
{
evt = window.event || evt;
//window.status= evt.clientX +"   " + evt.clientY;
}

function docOnDown(evt)
{
	evt = window.event || evt;
	if(gEvt)
	return;
	
}
	

	
function loadXMLDoc(url,reqQuery)	
{
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change() 
{
	
	if (parseInt(xmlhttp.readyState)==4) 
	{ 
		if (xmlhttp.status==200)
		{
			SetBox(xmlhttp.responseText);
			gEvt = null;
			xPos=0;
			yPos=0;
			
		}
	}
	
}

function mouseCoords(ev)
{
		if(ev.pageX || ev.pageY){
		return {x:ev.pageX, y:ev.pageY};
		}
		return {
			x:ev.clientX + document.body.scrollLeft - document.body.clientLeft ,
			y:ev.clientY + document.body.scrollTop  - document.body.clientTop 
		};
}

function Display_onClick(evt,strPipeLine,Mon,RoleID,SkillID,BGID,OUID,intMonth,CurDate)
	{	
	   
		evt = window.event || evt;
		
		if(!gEvt)
		{
			gEvt = evt;
			xPos = evt.clientX || evt.pageX;
			yPos = evt.clientY || evt.pageY;
			
			var url="HR_ResourceDeamnd_ActivityPlan.aspx?FromXML=1&IsRoleBase=<%=IsRoleBase%>&Pipeline="+strPipeLine+"&Month="+Mon+"&intRoleID="+RoleID+"&intSkillID="+SkillID+"&intBGID="+BGID+"&intOUID="+OUID+"&currentDate="+CurDate;
			
			loadXMLDoc(url,'')	
		}	
	
	}
            function SetBox(resText) {
                //Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                curdivTblGrid = document.getElementById('divTblGrid');
                //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                var evt = gEvt;
                if (!evt)
                    return;

                //debugger;
                if (yPos < (bheight / 2)) {
                    box = document.getElementById('Tajax_tooltipObj');

                    document.getElementById('Bajax_tooltipObj').style.display = "none";

                    arr = document.getElementById('Tajax_tooltip_arrow');
                    con = document.getElementById('Tajax_tooltip_content');

                    con.innerHTML = resText;
                    box.style.display = "";

                    wbox = con.firstChild.offsetWidth;
                    if (wbox > (bwidth - 50))
                        wbox = bwidth - 50;

                    hbox = con.firstChild.offsetHeight;


                    con.style.width = wbox;


                    if ((xPos - wbox + 20) < 0) {
                        box.style.left = 10;
                        arr.style.width = xPos - 8;
                    }
                    else {
                        //Commented And Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                        //box.style.left = (xPos - wbox + 20)
                        box.style.left = xPos + "px";
                        //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                        arr.style.width = wbox - 20;
                    }


                    //Commented And Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                    //box.style.top = yPos;
                    box.style.top = yPos + "px";
                    //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                    con.className = "ajax_tooltip_Tcontent";

                }
                else {


                    box = document.getElementById('Bajax_tooltipObj');

                    document.getElementById('Tajax_tooltipObj').style.display = "none";

                    arr = document.getElementById('Bajax_tooltip_arrow');
                    con = document.getElementById('Bajax_tooltip_content');


                    con.innerHTML = resText;
                    box.style.display = "";

                    wbox = con.offsetWidth;
                    hbox = con.offsetHeight;

                    arr.className = "ajax_tooltip_BRarrow";

                    if ((xPos - wbox + 18) < 0) {
                        box.style.left = 10;
                        arr.style.width = xPos - 10;

                    }
                    else {
                        //Commented And Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                        //box.style.left = xPos - wbox + 18;
                        box.style.left = xPos + "px";
                        //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                        arr.style.width = wbox - 18;

                    }

                    arr.style.height = hbox + 18;
                    //Commented And Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                    //box.style.top = yPos - hbox - 18;	
                    box.style.top = yPos + "px";
                    //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                    con.className = "ajax_tooltip_Bcontent";

                }
                //Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
                curdivTblGrid.onscroll = function () {
                    CloseDiv();
                };
                //End Of Added By Usha Pandit On 25.07.2020 For Arrow of pop up pointing to correct link issue
            }	
function window_onload()
{
 
	var intDivHeight ;
	var intDivHeightRisk;
	if (objdivlist != null) {
   //Commented and added by Yogesh J on 25-NOV-2015
	    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 25;

	    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;
        //Added And Commented By Vidya J ON 19-12-2015 
	    if (WhichBrowser() == 'IE') {

	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

	    }
	    else
	        if (WhichBrowser() == 'CR') {

	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

	        }
	        else
	            if (WhichBrowser() == 'FF') {

	                intDivHeight = window.innerHeight - objdivlist.offsetTop - 9;

	            }
	   
 //End of comment by Yogesh J On 25-Nov-2015
	if (intDivHeight < 100)	intDivHeight = 100;
	objdivlist.style.height = intDivHeight + 'px';	}
		
	document.getElementById('Bajax_tooltipObj').style.width=bwidth-100;
	document.getElementById('Bajax_tooltipObj').style.height=bheight/2 - 40 ;
	
	document.getElementById('Bajax_tooltip_content').style.width=bwidth-100;
	document.getElementById('Bajax_tooltip_content').style.height=bheight/2 - 40 ;
	
	document.getElementById('Tajax_tooltipObj').style.width=bwidth-100;
	document.getElementById('Tajax_tooltipObj').style.height=bheight/2  - 40;
	
	document.getElementById('Tajax_tooltip_content').style.width=bwidth-96;
	document.getElementById('Tajax_tooltip_content').style.height=bheight/2 - 40  ;
	
	
}

	
	
	var bwidth = document.body.offsetWidth;
	var bheight = document.body.offsetHeight;
				
function window_onresize()		
{
	var intDivHeight;
	var intDivHeightRisk;
	if (objdivlist !=null) 
	{
	    //Commented and added by Yogesh J on 25-NOV-2015
	    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 25 ;
	    //intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;
	    if (WhichBrowser() == 'IE') {

	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

	    }
	    else
	        if (WhichBrowser() == 'CR') {

	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 7;

	        }
	        else
	            if (WhichBrowser() == 'FF') {

	                intDivHeight = window.innerHeight - objdivlist.offsetTop - 9;

	            }
	    //End of comment by Yogesh J On 25-Nov-2015
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';	
	}
		
}	
function WhichBrowser() {

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

var ShowFilter='0';
function showFilters(show)
{
    objtblFilter = GetObjectReference('frmHR_OpportunityRole','tblFilter');
    objimgFilter =GetObjectReference('frmHR_OpportunityRole','imgFilter');
	img1='../../Images/cssImages/Link images/close.gif';
	img2='../../Images/cssImages/Link Images/Filter.gif';    

    if (ShowFilter=='0')
    {
    objtblFilter.style.top=40;
    objtblFilter.style.left=0;
    objtblFilter.zIndex=99;
    objtblFilter.style.display='';
    objimgFilter.src=img1;
    objimgFilter.alt='Hide filter'
    ShowFilter='1';

    }
    else if(ShowFilter=='1')
    {
    objtblFilter.style.display='none';
    objimgFilter.src=img2;
    ShowFilter='0';    
    objimgFilter.alt='Show filter' ;
    }
}
function applyFilter()
{
	var objRole=GetObjectReference('frmHR_OpportunityRole','cboRole').value;	
	var objSkill=GetObjectReference('frmHR_OpportunityRole','cboSkill')	
	var SkillID="" ;
	if (objSkill!=null)
	    SkillID=objSkill.value;		
    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	setFrameLoader();
    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	objform.action = "HR_ResourceDeamnd_ActivityPlan.aspx?RoleID=" + objRole + "&SkillID=" + SkillID;  
	objform.submit();
}

function ClearFilter()
{
	/*var objRole=GetObjectReference('frmHR_OpportunityRole','cboRole').value = '';	
	var objSkill=GetObjectReference('frmHR_OpportunityRole','cboSkill').value = '';		
	var objBG=GetObjectReference('frmHR_OpportunityRole','cboBG').value = '';	
	var objOU=GetObjectReference('frmHR_OpportunityRole','cboOU').value = '';	*/
	var objRole=GetObjectReference('frmHR_OpportunityRole','cboRole')
	var objSkill=GetObjectReference('frmHR_OpportunityRole','cboSkill');		
	var objBG=GetObjectReference('frmHR_OpportunityRole','cboBG');	
	var objOU=GetObjectReference('frmHR_OpportunityRole','cboOU');		
	if (objRole!=null)
	    objRole.value = '';	
	if (objSkill!=null)
	    objSkill.value = '';
	if (objBG!=null)
	    objBG.value = '';	
	if (objOU!=null)
	    objOU.value = '';
    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	setFrameLoader();
    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	objform.action = "HR_ResourceDeamnd_ActivityPlan.aspx";  
	objform.submit();
}

function getData(strPipeLine,intCol1,intSkillID,intSkillID)
{
	var strElement;
	//window.open("HR_OpportunityRole.aspx?PipeLine="+strPipeLine+"&Month="+intCol1+"&Role="+strRole+"&Skill=" + strSkill);  
	
	var objDivpopup = document.getElementById("divTbl");
	var url;
	//url= "HR_OpportunityRole.aspx?FromXML=1&PipeLine="+strPipeLine+"&Month="+intCol1+"&Role="+intSkillID+"&Skill=" + intSkillID;
	//loadXMLDoc(url,'');
	//debugger;	
	//objform.action = "HR_OpportunityRole.aspx?PipeLine="+strPipeLine+"&Month="+intCol1+"&Role="+intSkillID+"&Skill=" + intSkillID;  
	//objform.submit();
	/*var strTitle= GetObjectReference('','Title_1').value;
	strElement = "<TR class='clsTREven' align='Left' nowrap >";
    strElement = "<td align=left>strTitle</TD>";
    strElement = "<td align=left></TD>";
    strElement = "<td align=left></TD>";
    strElement = "<td align=left></TD>";
    strElement = "<td align=left></TD>";
    strElement = "</TR>";	
    objDivpopup = strElement;*/
}
	
 function Cancel_onclick()
 {
	var cnt= 1;
	var objDivpopup = document.getElementById("divTbl");
	objDivpopup.style.display="none"; 
}
 
function CloseDiv()
{
	if(document.getElementById('btnClose'))
	{
		//document.getElementById('btnApply').parentNode.removeChild(document.getElementById('btnClose'));
		//document.getElementById('btnApply').parentNode.removeChild(document.getElementById('btnApply'));
		document.getElementById('btnClose').parentNode.removeChild(document.getElementById('btnClose'));
	}
	
	document.getElementById('Bajax_tooltipObj').style.display="none";
	document.getElementById('Tajax_tooltipObj').style.display="none";
}

function ApplyDiv()
{

}
function Page_OnClick(strPaging)
{	
	var objRole=GetObjectReference('frmHR_OpportunityRole','cboRole').value;	
	var objSkill=GetObjectReference('frmHR_OpportunityRole','cboSkill')	
	var SkillID="" ;
	if (objSkill!=null)
	    SkillID=objSkill.value;		
	
	window.location.href.refresh;
    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	setFrameLoader();
    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	objform.action = "HR_ResourceDeamnd_ActivityPlan.aspx?RoleID=" + objRole + "&SkillID=" + SkillID + "&Paging=" + strPaging;  
	objform.submit();
}
function BG_onChange()
{
	var BGID = GetObjectReference('','cboBG').value;
	var url;
	url= "HR_ResourceDeamnd_ActivityPlan.aspx?FromXML=1&For=OU&BGID=" + BGID;
	loadXMLDoc(url,'','BG');
	var objOU = GetObjectReference('','cboOU');
	setFocus(objOU);
}
function OptRoleSkill_OnChange(v)
{
    var objoptRoleSkill = GetObjectReference('','optRoleBase').value;
   
    ClearFilter();
    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
    setFrameLoader();
    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
    objform.action = "HR_ResourceDeamnd_ActivityPlan.aspx";  
	objform.submit();
    
}
function Export_OnClick()
{
    var objRole=GetObjectReference('frmHR_OpportunityRole','cboRole').value;
	var objSkill=GetObjectReference('frmHR_OpportunityRole','cboSkill')	;
	var objoptRoleSkill = GetObjectReference('frmHR_OpportunityRole','optRoleBase',true);
	var SkillID="" ;
	if (objSkill!=null)
	    SkillID=objSkill.value;		
	var objIsRoleBase    ;
    if (objoptRoleSkill[0].checked==true)
           objIsRoleBase=1;
    else
           objIsRoleBase=0;
   
	window.open("HR_ResourceDeamnd_ActivityPlan.aspx?MODE=Print&ISRoleBase="+objIsRoleBase+"&RoleID=" + objRole + "&SkillID=" + SkillID+ "&Paging=" +"<%=m_strPaging%>");  
	
}

 
		</SCRIPT>
	</body>
</HTML>
