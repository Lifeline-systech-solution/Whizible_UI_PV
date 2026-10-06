<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_PipelineGraphicalView.aspx.vb" Inherits="PbNIT.HR_PipelineGraphicalView"%>

<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Graphical View - Staffing Plan")%>
	
	<script language='javascript' src='../DB/DateFormat.js'></script>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
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
        responsiveTopMenu();
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



	<body class="clsBody" onresize="window_onResize()" onmouseup="clickDocUp(event)" ondragstart="return false;"
		onload="window_onLoad()">
		<div id='DateTitle' style=' BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:60px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Dec 2007</div>
		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
		<div id="divLTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp; 
			12 Left 2007</div>
		<div id="divRTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Right 2007</div>
		<SCRIPT>
//if(document.getElementById('fillDiv'))
document.getElementById('fillDiv').style.display="block";
		</SCRIPT>
		<form name="frmPipelineGraphicalView" method="post" action="HR_PipelineGraphicalView.aspx"
			id="frmPipelineGraphicalView">
			<%PageInit()%>
		</form>
		<SCRIPT>
if(document.getElementById('fillDiv'))
document.getElementById('fillDiv').style.display="block";

var isWinOnLoadExecComplete = false;
var isPageRenderedComplete = false;
var arrVertLeftTopPos = new Array();
var arrVertRightTopPos = new Array();
var vertTopBondary,vertBottomBondary;
	var curMoveVert;
	var vertPosTD;
	var StartX;
	var vert;
	var lastTD;
	var pix = "px";
	var i;
	var DT,objdivlist;
	var isLorR,DT_TD_width;
	var LB,RB,LBid,RBid;
	var objfrm;
	var LToolTip,RToolTip;
	var divForeCast,objdivFilter;
	//ADDED BY SANAS
	
	var g_PRJID,g_SD,g_ED,g_EMPNAME,g_EMPID,g_ROLEID;
	var g_RECPER,g_TENDATE,g_JD,g_Pipe_OR_Team_PK;
	//END ADDITON BY sANAS

 var Pass1_2_CheckedBox;

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
 		 
function window_onLoad()
{  
DT = document.getElementById("DateTitle"); //Date Title
objdivlist = document.getElementById("divList");
objfrm = GetFormReference('frmPipelineGraphicalView');
LToolTip = document.getElementById('divLTooltip');
RToolTip = document.getElementById('divRTooltip');
divForeCast = document.getElementById('divForecast')
objdivFilter = GetObjectReference('frmPipelineGraphicalView','divFilter');

 


	var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if(objdivlist)
		{
			if (navigator.appName == 'Microsoft Internet Explorer'){
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
			}
			else{
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
		}
		//objdivlist.HEIGHT = intDivHeight;
	
		
	
	isLorR = "R";		
	for(i=0;i<arrVertRight.length;i++)
	{
		vert = document.getElementById('verR'+i);
		lastTD = document.getElementById(arrVertRight[i]);
		if(vert && lastTD)
		{
			if(!DT_TD_width)
			DT_TD_width = lastTD.offsetWidth;	
			initVert(vert,lastTD);
			vert.setAttribute("RB_TDID",arrVertRightRB[i]);
			vert.setAttribute("Index",i);
			arrVertRightTopPos[i] = getPosition(vert).y;
			
		}
		
		
	}
	isLorR = "L";		
	for(i=0;i<arrVertLeft.length;i++)
	{
		vert = document.getElementById('verL'+i);
		lastTD = document.getElementById(arrVertLeft[i]);
		if(vert && lastTD)
		{
			if(!DT_TD_width)
			DT_TD_width = lastTD.offsetWidth;	
			initVert(vert,lastTD);
			vert.setAttribute("LB_TDID",arrVertLeftLB[i]);
			vert.setAttribute("Index",i);
			arrVertLeftTopPos[i] = getPosition(vert).y;
		}
		
	}
	
	if(!objdivlist)
		objdivlist=document.getElementById('divList1');
		
	vertTopBondary = getPosition(document.getElementById('Role')).y - 2 ; // - document.getElementById('Role').offsetHeight;
	vertBottomBondary = getPosition(document.getElementById('Role')).y + objdivlist.offsetHeight - (document.getElementById('Role').offsetHeight/2);
	
	
	
	objdivlist.onscroll=Scroll;	
	Scroll();
	
	
	var arrChk = GetObjectReference('','chkSelect',true);
	for(i=0;i<arrChk.length;i++)
	arrChk[i].setAttribute("chkIndex",i);
	
	isWinOnLoadExecComplete = true;
	
	<%if m_PageType=PageType.Pass1 OR m_PageType=PageType.Pass2 then %>
		if(document.getElementById('cboBG').value=="" && document.getElementById('cboOU').value=="" && document.getElementById('cboRole').value=="" && document.getElementById('cboSkill').value=="" )
		Filters_OnClick()
		else if (isWinOnLoadExecComplete==true && isPageRenderedComplete == true)
		document.getElementById('fillDiv').style.display="none";
		
	<%else%>
	if (isWinOnLoadExecComplete==true && isPageRenderedComplete == true)
	document.getElementById('fillDiv').style.display="none";
	<%End if %>
	
	
	
	
}
function Scroll(evt)
{
	
	
	for(i=0;i<arrVertLeft.length;i++)
	{
		vert = document.getElementById('verL'+i);
		if(vert && document.getElementById(arrVertLeft[i]))
		{
			if(vertTopBondary > (arrVertLeftTopPos[i] - objdivlist.scrollTop))
			vert.style.display="none";
			else if(vertBottomBondary < (arrVertLeftTopPos[i] - objdivlist.scrollTop))
			vert.style.display="none";
			else
			{
				vert.style.top = arrVertLeftTopPos[i] - objdivlist.scrollTop;  
				vert.style.display="";
				
			}
			
		}
	}
	
	for(i=0;i<arrVertRight.length;i++)
	{
		vert = document.getElementById('verR'+i);
		if(vert && document.getElementById(arrVertRight[i]))
		{
		
		
			if(vertTopBondary > (arrVertRightTopPos[i] - objdivlist.scrollTop))
			vert.style.display="none";
			else if(vertBottomBondary < (arrVertRightTopPos[i] - objdivlist.scrollTop))
			vert.style.display="none";
			else
			{

				vert.style.top = arrVertRightTopPos[i] - objdivlist.scrollTop;  
				vert.style.display="";
				
			}
			
		}
		
		
	}
	
	
}

function setLeftVertBoundary(vertIndex)
{
    if(document.getElementById("verR"+vertIndex))
	var R_SiblingVertTD = document.getElementById(document.getElementById("verR"+vertIndex).getAttribute("Target"));
	var Lvert = document.getElementById("verL"+vertIndex);
	
	
	if(Lvert)
	{
	    var MaxLB_TDID = Lvert.getAttribute("LB_TDID");
	    if(!R_SiblingVertTD)
	    R_SiblingVertTD=document.getElementById(MaxLB_TDID.split("|")[0]+"|"+GantViewEndMon+"|"+GantViewEndDay);
	    RB = getPosition(R_SiblingVertTD).x - DT_TD_width;
    	
	    RBid = R_SiblingVertTD.id;
    	
	    LB = getPosition(document.getElementById(MaxLB_TDID)).x ;
	    LBid = MaxLB_TDID;
	}
	  
}
function setRightVertBoundary(vertIndex)
{
     
    if(document.getElementById("verL"+vertIndex))
	var L_SiblingVertTD = document.getElementById(document.getElementById("verL"+vertIndex).getAttribute("Target"));;
	var Rvert = document.getElementById("verR"+vertIndex);
	
	
	if(Rvert)
	{
	    var MaxRB_TDID = Rvert.getAttribute("RB_TDID");
    	
	    if(!L_SiblingVertTD)
	    L_SiblingVertTD=document.getElementById(MaxRB_TDID.split("|")[0]+"|"+GantViewStartMon+"|"+GantViewStartDay)
    	
	    LB = getPosition(L_SiblingVertTD).x;
    	
	    LBid = L_SiblingVertTD.id;
	}
	if(document.getElementById(MaxRB_TDID))
	{
		RB = getPosition(document.getElementById(MaxRB_TDID)).x; //document.getElementById(MaxRB_TDID).offsetWidth;
		RBid = MaxRB_TDID;
	}
	else
	{
		RB =  getPosition(document.getElementById(MaxRB_TDID.split("|")[0]+"|"+GantViewEndMon + "|" +GantViewEndDay));
		RBid = MaxRB_TDID.split("|")[0]+"|"+GantViewEndMon + "|" +GantViewEndDay;
	}	
	
	
	
}
function clickDownVert(evt)
{
evt=evt||window.event;
curMoveVert = evt.srcElement || evt.target;
//curMoveVert.setAttribute("StartX",evt.clientX);
StartX = evt.clientX;
document.body.onmousemove = function() { moveVert(evt); };
document.body.style.cursor = "e-resize";

vertPosTD=document.getElementById(curMoveVert.getAttribute("Target"));

if (curMoveVert.id.substring(0,4) == "verL")
{  DToffX=-66; DTOffY=-6;
	isLorR = "L";
	setLeftVertBoundary(curMoveVert.id.substring(4));
 }
else
{ DToffX=6,DTOffY=-6; 
	isLorR = "R";
	setRightVertBoundary(curMoveVert.id.substring(4));
}


	DT.innerHTML = vertPosTD.title;
	DT.style.left = evt.clientX +DToffX;
	DT.style.top = parseInt(curMoveVert.style.top)+DTOffY;

	DT.style.display='';
}

var DToffX=0,DTOffY=0;
var RB,LB; //Right boundary Left Boundary


function moveVert(evt)
{

evt=evt||window.event;

 

	if(curMoveVert)
	{
	
			vertPosTD=document.getElementById(curMoveVert.getAttribute("Target"));	
	
			var Rtarget,RctrTarget,oHidPipe,Ltarget,LctrTarget;
			
			if(RB + (DT_TD_width*2)  <= evt.clientX)
			{
				
				Rtarget = document.getElementById(RBid); 
				curMoveVert.setAttribute("Target",Rtarget.id); setPosVert(curMoveVert,Rtarget); 
				if(isLorR == "L")
				oHidPipe = document.getElementById("L|"+Rtarget.id.split("|")[0]);
				else
				oHidPipe = document.getElementById("R|"+Rtarget.id.split("|")[0]);
				
				//MoveVertRightHand(null);
				FillNoColorBeyondBoundaries(curMoveVert.id.substring(4));
				
				
				if(Rtarget && oHidPipe )
				oHidPipe.value = Rtarget.getAttribute("Date");
				
				DT.style.display='none';
				curMoveVert = null;
				document.body.style.cursor = "Default";
				document.body.onmousemove = function(){};
				
				return; 
			}
			else if(LB - (DT_TD_width*2) > evt.clientX)
			{
				Ltarget = document.getElementById(LBid); 
				curMoveVert.setAttribute("Target",Ltarget.id); setPosVert(curMoveVert,Ltarget); 
				if(isLorR == "L")
				oHidPipe = document.getElementById("L|"+Ltarget.id.split("|")[0]);
				else
				oHidPipe = document.getElementById("R|"+Ltarget.id.split("|")[0]);
				
				FillNoColorBeyondBoundaries(curMoveVert.id.substring(4));
				
				if(Ltarget && oHidPipe )
				oHidPipe.value = Ltarget.getAttribute("Date");

				
				DT.style.display='none';
				curMoveVert = null;
				document.body.style.cursor = "Default";
				document.body.onmousemove = function(){};
				
				return; 
			}
	
	
	
			if(isLorR == "L")
			{  
			
				DToffX=-66; DTOffY=-6; 
			}
			else
			{
			DToffX=6,DTOffY=-6;
			}
			 
			curMoveVert.style.position = "absolute"; 
			curMoveVert.style.left = evt.clientX;
			calcMoveVert(evt);
		
		
			DT.innerHTML = vertPosTD.title;
			DT.style.left = evt.clientX +DToffX;
			if(curMoveVert)
			DT.style.top = parseInt(curMoveVert.style.top)+DTOffY;
		
		
	  }

}

function clickDocUp(evt)
{

	if(evt)
	evt=evt||window.event;
	var oTargetDT,oTargetPipeID,oHidPipe;	//oHidPipe - hidden ctrl of L/R with PipeID

		
	if(curMoveVert)
	{
		
		
		oTargetPipeID=curMoveVert.getAttribute("Target").split("|")[0];
		oTargetDT = document.getElementById(curMoveVert.getAttribute("Target"));
		
		if(evt)	
		calcMoveVert(evt);			
		
		if(isLorR == "L")
		{  
			DToffX=-66; DTOffY=-6; 
			oHidPipe = document.getElementById("L|"+oTargetPipeID);
			if(oTargetDT && oHidPipe )
			oHidPipe.value = oTargetDT.getAttribute("Date");
			
		}
		else
		{ 
			DToffX=6; DTOffY=-6; 
			oHidPipe = document.getElementById("R|"+oTargetPipeID);
			if(oTargetDT && oHidPipe )
			oHidPipe.value = oTargetDT.getAttribute("Date");
		}
		
		/*
		DT.innerHTML = vertPosTD.title;
		DT.style.left = evt.clientX +DToffX;
		DT.style.top = parseInt(curMoveVert.style.top)+DTOffY;
		*/		
		
	}
	DT.style.display='none';
	curMoveVert = null;
	document.body.style.cursor = "Default";
	document.body.onmousemove = function(){};
}

function MoveVertRightHand(evt)
{
	var isCrossRightBoundary = false;
	var dtTD,lastdtTD; //dates TD
	var monInr = 0; //month incrementer
	var dtTDx; 
	var fillColor;
	
		if (isLorR == "L" )
		 fillColor = "white"; 
		else
		fillColor = evt ? "red" : "white";
		
		//if moving does right hand
		var arrTargetInfo = curMoveVert.getAttribute("Target").split("|");
		
		for(i=arrTargetInfo[2];i<=32;i++)
		{
			dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
			if (!dtTD)
			{
			
				monInr++;
				if( (parseInt(arrTargetInfo[1]) + monInr) == 13 ) //for moving/increase from Dec to feb 
				monInr = 1 - parseInt(arrTargetInfo[1]);
				
				i=1;
				dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
			}
			
			if(dtTD!=null)
		    {   	     
		     
		    var objPsDate = GetObjectReference('frmPipelineGraphicalView','HidProjectEndDate');
		    var ProjectEndDate;
		        if(objPsDate)
		        {
		            ProjectEndDate = objPsDate.value
			        if(!ValidateEndDates(dtTD.getAttribute("Date"),ProjectEndDate,evt)) {isCrossRightBoundary=true; break;  }
			    }
		    }
		
			
			if(GantViewEndMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewEndDay == i )
					{ isCrossRightBoundary=true; break; }
			if(dtTD)
			{
				
				var dtTDx = getPosition(dtTD).x;
				if (evt)
				{
					if(evt.clientX >= parseInt(dtTDx)) 
					{ dtTD.bgColor = fillColor; lastdtTD = dtTD; }
					else break;
				}
				else
					dtTD.bgColor = fillColor;
			}
			else
			break;
		}
		if(lastdtTD)
		{ 
			if(fillColor == "white")
				lastdtTD.bgColor = "red";
			curMoveVert.setAttribute("Target",lastdtTD.id); setPosVert(curMoveVert,lastdtTD); 
		}
		if(isCrossRightBoundary)
			clickDocUp(null);	
	
				
}

function ValidateEndDates(dtCurrentDate,ProjectEndDate,evt)
 {
                
        dtProjectEndDate  = GetFormat(ProjectEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
        dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
       
       //alert(dtProjectEndDate);
       //alert(dtCurrentDate);
                 
        if((dtProjectEndDate != null)  && (dtCurrentDate != null))
        {
            
            if(DateDiff(dtCurrentDate,dtProjectEndDate,'d')<0)
            {             //alert('Error');    		
				return false;  
            }
            else
            {
                return true;
            }
        }
        
 } 
 
function MoveVertLeftHand(evt)
{
	var dtTD,lastdtTD; //dates TD
	var monInr = 0; //month incrementer
	var dtTDx;
	var fillColor;
	var isCrossLeftBoundary = false;
	
	if (isLorR == "L")
				fillColor = "red";
			else
				fillColor = "white";
			//if moving does left hand
			var arrTargetInfo = curMoveVert.getAttribute("Target").split("|");
			
			if(GantViewStartMon == arrTargetInfo[1] && GantViewStartDay == arrTargetInfo[2] )
			alert("caught it");
			else
			for(i=arrTargetInfo[2];i>=0;i--)
			{
				dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
				if (!dtTD)
				{
					monInr--;
					if( (parseInt(arrTargetInfo[1]) + monInr) == 0 ) //for moving/decrease from feb to Dec
					monInr = 12 - parseInt(arrTargetInfo[1]);
					i=31;
					dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
					
					if(!dtTD)
					{
						i=30;
						dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
						
					}
					if(!dtTD)
					{
						i=29;
						dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
					}
					if(!dtTD)
					{
						i=28;
						dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
					}
					
				}
				if(GantViewStartMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewStartDay == i )
					{ isCrossLeftBoundary=true; break; }
					
				if(dtTD)
				{
					
					var dtTDx = getPosition(dtTD).x;
					if(evt.clientX < (parseInt(dtTDx)+ DT_TD_width)) // && evt.clientX <= (parseInt(dtTDx)+ dtTD.offsetWidth)  )
					{ dtTD.bgColor = fillColor; lastdtTD = dtTD;  }
					else break;
					
				}
				else
				break;
			}
			if(lastdtTD)
			{ 
				if(fillColor == "white")
				lastdtTD.bgColor = "red";
				curMoveVert.setAttribute("Target",lastdtTD.id); setPosVert(curMoveVert,lastdtTD); 
			}
			if(isCrossLeftBoundary)
			clickDocUp(null);
			
}
function calcMoveVert(evt)
{
	if(curMoveVert)
	{
		if(parseInt(StartX) < evt.clientX)
		{
			MoveVertRightHand(evt);
			StartX = evt.clientX;
		}
		else if(parseInt(StartX) > evt.clientX)
		{
			MoveVertLeftHand(evt);
			StartX = evt.clientX;
		}
		
	}
}

disableSelection();
function disableSelection(){
var target = document.body;
if (typeof target.onselectstart!="undefined") //IE route
	target.onselectstart=function(){return false}
else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
	target.style.MozUserSelect="none"
else //All other route (ie: Opera)
	target.onmousedown=function(){return false}
target.style.cursor = "default"
}

function initVert(vert,target){


 vert.style.height ="15px"; // work in progress to remove hard code
 vert.setAttribute("Target",target.id);
 setInitialPosVert(vert,target);
}

function setPosVert(vert,target)
{
	var positions = getPositionVert(vert,target);
	vert.style.left= positions.x;
	vert.style.top= positions.y
}
function getPositionVert(vert,target)
{
	var xy = getPosition(target);
	if (isLorR == "L")
	{
		//vert.style.left=xy.x;
		xy.y=arrVertLeftTopPos[vert.getAttribute("Index")] - objdivlist.scrollTop; 
	}
	else
	{
		xy.x=xy.x + DT_TD_width;
		xy.y=arrVertRightTopPos[vert.getAttribute("Index")] - objdivlist.scrollTop; 
	}
	
	return { x:xy.x,y:xy.y}
	
}

function setInitialPosVert(vert,target)
{
var xy = getPosition(target);

if (isLorR == "L")
{
	vert.style.left=xy.x;
	vert.style.top=xy.y-6;
}
else
{
	vert.style.left=xy.x + DT_TD_width;
	vert.style.top=xy.y-6;
}


}

function getPosition(e){
	var left = 0;
	var top  = 0;

	while (e.offsetParent){
		left += e.offsetLeft;
		top  += e.offsetTop;
		e     = e.offsetParent;
	}

	left += e.offsetLeft;
	top  += e.offsetTop; 

	return {x:left, y:top};
}
function window_onResize()
{

var intDivHeight ;
var intDivHeightRisk;
if (navigator.appName == 'Microsoft Internet Explorer'){
intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
}
else{
intDivHeight = window.innerHeight - 42;
}
if (intDivHeight < 100)
	intDivHeight = 100;

if(document.getElementById('divList'))		
objdivlist.style.height = intDivHeight + 'px';

for(i=0;i<arrVertRight.length;i++)
	{
		vert = document.getElementById('verR'+i);
		lastTD = document.getElementById(arrVertRight[i]);
		if(vert && lastTD)
		initVert(vert,lastTD);
		
		
	}
	for(i=0;i<arrVertLeft.length;i++)
	{
		vert = document.getElementById('verL'+i);
		lastTD = document.getElementById(arrVertLeft[i]);
		if(vert && lastTD)
		initVert(vert,lastTD);
		
		
	}
}

function Save_OnClick()
{
	var objPKIDs = document.getElementById('hidPKID');
	var arrPKIDs;
	if(objPKIDs)
	{
		arrPKIDs = objPKIDs.value.split(",");
		for(i=0;i<arrPKIDs.length;i++)
		{
			if(document.getElementById("L|"+arrPKIDs[i]))
			if(document.getElementById("L|"+arrPKIDs[i]).value == document.getElementById("L|"+arrPKIDs[i]).defaultValue)
			if(document.getElementById("R|"+arrPKIDs[i]).value == document.getElementById("R|"+arrPKIDs[i]).defaultValue)
			document.getElementById("L|"+arrPKIDs[i]).value = "DONTSAVE";
			
		} 
	}
	
	objfrm.action="HR_PipelineGraphicalView.aspx?ACTION=SAVE" ;
	objfrm.submit();
	
}
	
function Add_OnClick()
{	
	window.open("HR_PipeLine_Addition_CommonList.aspx?MasterTagID=3874&From=G&Operation=ADD&OpportunityID=<%=m_strMasterPK%>", "", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 200)/2) + ",width=600,height=200");
}

function SaveAndClose_OnClick()
{
	var objTokenPK = window.opener.document.getElementById('PKToken');
	var strParentPage = new String();
	var m_strOpenerTagID = window.opener.document.getElementById('MasterTagID').value;
	
	<% if m_PageType = PageType.OPPORTUNITY then %>
	strParentPage = "../HR/HR_Opportunity_CommonPage.aspx?";
	strParentPage = strParentPage + "OpportunityID_PK=" + "<%=m_strMasterPK%>" + "&PKToken=" + objTokenPK.value;
	strParentPage = strParentPage + "&MasterTagID=" + m_strOpenerTagID + "&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
	<% elseif m_PageType = PageType.PROJECT_STAFFINGPLAN then %>
    strParentPage = "../HR/HR_CommonList.aspx?FromWhere=PM&MasterTagId=3855";
	<% end if %>
	//End of addition By ShraddhaM on 14,Feb 2008 for refresh parent
	objfrm.action="HR_PipelineGraphicalView.aspx?ACTION=SAVECLOSE" ;
	objfrm.submit();
	<% if m_PageType = PageType.OPPORTUNITY then %>
		refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage);  
	<% elseif m_PageType = PageType.PROJECT_STAFFINGPLAN then %>
		refreshParent('frmCommonList', 'HR_CommonList.aspx', strParentPage); 
	<% end if %>	
	window.close();
}
function Close_OnClick()
{
	<% if m_PageType = PageType.OPPORTUNITY then %>
	
		var objTokenPK = window.opener.document.getElementById('PKToken');
		var strParentPage = new String();
		 
		var m_strOpenerTagID = window.opener.document.getElementById('MasterTagID').value;
			
		strParentPage = "../HR/HR_Opportunity_CommonPage.aspx?";
		strParentPage = strParentPage + "OpportunityID_PK=" + "<%=m_strMasterPK%>" + "&PKToken=" + objTokenPK.value;
		strParentPage = strParentPage + "&MasterTagID=" + m_strOpenerTagID + "&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
		refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage);  
    
    
    <% elseif m_PageType = PageType.PROJECT_STAFFINGPLAN then %>
	
			strParentPage = "../HR/HR_CommonList.aspx?FromWhere=PM&MasterTagId=3855";
			refreshParent('frmCommonList', 'HR_CommonList.aspx', strParentPage); 
	<% end if %>	
	
	
	
	window.close();
}
function FillNoColorBeyondBoundaries(vertIndex)
{

	var arrTargetInfo,arrTDInfo;
	var vertL =  document.getElementById('verL'+vertIndex);
	var vertR =  document.getElementById('verR'+vertIndex);
	var fillColor = "white";
	var monInr = 0;
	
	//seting Left side white spaces
	if(vertR.getAttribute("Target"))
	{
		arrTargetInfo = vertR.getAttribute("Target").split("|");
		monInr=arrTargetInfo[1];			
	
		for(i=arrTargetInfo[2];i<=32;i++)
			{
				
				dtTD = document.getElementById(arrTargetInfo[0]+"|"+monInr+"|"+i)
				if (!dtTD)
				{
				
					monInr++;
					if( parseInt(monInr) == 13 ) //for moving/increase from Dec to feb 
					monInr = 1;//- parseInt(arrTargetInfo[1]);
					
					i=1;
					dtTD = document.getElementById(arrTargetInfo[0]+"|"+monInr+"|"+i)
				}
				if(dtTD)
				{
					arrTDInfo = dtTD.id.split("|");
					if(arrTDInfo[1] == GantViewEndMon && arrTDInfo[2] == GantViewEndDay)
					break;
					else
					dtTD.bgColor = fillColor;
					
				}
				else
				break;
			}
			document.getElementById(vertR.getAttribute("Target")).bgColor = "red";
		}
		if(vertL.getAttribute("Target"))
		{
			arrTargetInfo = vertL.getAttribute("Target").split("|");
			monInr=GantViewStartMon;
			for(i=GantViewStartDay;i<=32;i++)
			{
				
				dtTD = document.getElementById(arrTargetInfo[0]+"|"+monInr+"|"+i)
				if (!dtTD)
				{
				
					monInr++;
					if( parseInt(monInr) == 13 ) //for moving/increase from Dec to feb 
					monInr = 1;
					
					i=1;
					dtTD = document.getElementById(arrTargetInfo[0]+"|"+monInr+"|"+i)
				}
				if(dtTD)
				{
					arrTDInfo = dtTD.id.split("|");
					if(arrTDInfo[1] == arrTargetInfo[1] && arrTDInfo[2] == arrTargetInfo[2])
					break;
					else
					dtTD.bgColor = fillColor;
					
				}
				else
				break;
			}
			document.getElementById(vertL.getAttribute("Target")).bgColor = "red";
		}
	
	
}
function previousYear_OnClick()
{
	var objYearIncr = document.getElementById('YearIncr');
	objYearIncr.value = parseInt(objYearIncr.value)-1;
	objfrm.action="HR_PipelineGraphicalView.aspx" ;
	objfrm.submit();
}
function NextYear_OnClick()
{
	var objYearIncr = document.getElementById('YearIncr');
	objYearIncr.value = parseInt(objYearIncr.value)+1;
	objfrm.action="HR_PipelineGraphicalView.aspx";
	objfrm.submit();
}
function hideshowMaintree()
{
	if(window.parent.parent.frames[0].window.hideshowtree)
		window.parent.parent.frames[0].window.hideshowtree();
}
function chkSelect_onclick(src)
{

	var isChecked = src.checked;
	var arrChk = GetObjectReference('','chkSelect',true);
	var arrRefImg = GetObjectReference('','refImg',true);
	
	
	for(i=0;i<arrChk.length;i++)
	{
		arrChk[i].checked = false;
//		if(arrChk[i] == src)
//		chkIndex=i;
	}
	if(Pass1_2_CheckedBox)
	arrRefImg[Pass1_2_CheckedBox.getAttribute("chkIndex")].style.visibility="hidden";
	
	src.checked = isChecked
	if(isChecked==true)
	{
		Pass1_2_CheckedBox=src;
		arrRefImg[src.getAttribute("chkIndex")].style.visibility="visible";
		//Integrated by SanaS on 29-Sep-2009
		SetDefaultFilterPass2(Pass1_2_CheckedBox.value);
	}
	else
	{
		Pass1_2_CheckedBox=null;
		arrRefImg[src.getAttribute("chkIndex")].style.visibility="hidden";
	}
}
// Integrated by SanaS on 29-sep-2009
//Added By SanaS on 17-Sep-2009 
function SetDefaultFilterPass2(strChkValue)
{

		var ForecastInfo=strChkValue.split('|');

        		
		var objRolePass2=document.getElementById('cboRolePass2')
		var objSkillPass2=document.getElementById('cboSkillPass2')
		var SelectedRole=ForecastInfo[2];
	    var SelectedSkill=ForecastInfo[3];
        var i;
    
        for (i=0;i<objRolePass2.length;i++)
        {
            if (objRolePass2.options[i].value==SelectedRole)
                objRolePass2.selectedIndex=i;
        }
        for (i=0;i<objSkillPass2.length;i++)
        {
            if (objSkillPass2.options[i].value==SelectedSkill)
                objSkillPass2.selectedIndex=i;
        }
		
}
	    //End Addition by SanaS on 17-Sep-2009
	    //End Integrated by SanaS on 29-sep-2009
	    
	    //added by RohiniK on 30 Oct 09 for S1 Changes
function Search_OnClick(src,strCheckBoxForPass_value)
{
    Pass1_2_CheckedBox=src;
    SetDefaultFilterPass2(strCheckBoxForPass_value);
    
    if(Pass1_2_CheckedBox) 
	{
		var foreCastFilterInfo = strCheckBoxForPass_value.split("|"); //Pass1_2_CheckedBox.value.split("|");
		var sd = document.getElementById('L|'+foreCastFilterInfo[1]).value;
		var ed =document.getElementById('R|'+foreCastFilterInfo[1]).value;
		var RoleID = foreCastFilterInfo[2];
		var type = ''
		var SkillID = foreCastFilterInfo[3];
		 
		var pk = foreCastFilterInfo[4];
		var IsDorP = foreCastFilterInfo[0];
		
		// alert(' RoleID' + RoleID);
		 
		if(document.getElementById('cboForecast'))
		    type = document.getElementById('cboForecast').value;
		    // Integrated by SanaS on 29-sep-2009
		    //Added By SanaS on 17-Sep-2009 for adding filters 
		
        if(document.getElementById('cboRolePass2'))
		{   
            if (document.getElementById('cboRolePass2').value != "")
            {
                RoleID=parseInt(document.getElementById('cboRolePass2').value);
                Pass1_2_CheckedBox.value= IsDorP+'|' + foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
            }
            else
            {
                RoleID =0;	
                Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
            }               
		}					 
        if(document.getElementById('cboSkillPass2'))
        {
	        if (document.getElementById('cboSkillPass2').value != "")
	        {
                SkillID = parseInt(document.getElementById('cboSkillPass2').value);	
                Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
            }   
            else
            {
                SkillID =0;	
                Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
            }     
		}    
		loadXMLDoc("../HR/HR_PipelineGraphicalView.aspx?IsRoleBase=<%=IsRoleBase%>&IsDorP="+IsDorP+"&PK="+pk+"&FromXML=1&RoleID="+RoleID+"&SkillID="+SkillID+"&Type="+type+"&ED="+ed+"&SD="+sd+"&For="+document.getElementById('HidFor').value+"&YearIncr="+document.getElementById('YearIncr').value,"","ForeCast");
		
	}
}
//End of addition by RohiniK on 30 Oct 09 for S1 Changes
	    
	    
function Forecast_OnClick()
{

	if(Pass1_2_CheckedBox) {
	
		var foreCastFilterInfo = Pass1_2_CheckedBox.value.split("|");
		var sd = document.getElementById('L|'+foreCastFilterInfo[1]).value;
		var ed =document.getElementById('R|'+foreCastFilterInfo[1]).value;
		var RoleID = foreCastFilterInfo[2];
		var type = ''
		var SkillID = foreCastFilterInfo[3];
		 
		var pk = foreCastFilterInfo[4];
		var IsDorP = foreCastFilterInfo[0];
		
		if(document.getElementById('cboForecast'))
		    type = document.getElementById('cboForecast').value;
		    // Integrated by SanaS on 29-sep-2009
		//Added By SanaS on 17-Sep-2009 for adding filters 
		
        if(document.getElementById('cboRolePass2'))
		    {   
		        if (document.getElementById('cboRolePass2').value != "")
		        {
		            RoleID=parseInt(document.getElementById('cboRolePass2').value);
		            Pass1_2_CheckedBox.value= IsDorP+'|' + foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
		        }
		     else
                   {
                    RoleID =0;	
                  Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
                }    
		    }
					 
        if(document.getElementById('cboSkillPass2'))
            {
		        if (document.getElementById('cboSkillPass2').value != "")
		        {
                    SkillID = parseInt(document.getElementById('cboSkillPass2').value);	
                  Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
                }   
                else
                   {
                    SkillID =0;	
                  Pass1_2_CheckedBox.value= IsDorP+'|' +foreCastFilterInfo[1]+ '|' +RoleID+'|'+SkillID+'|'+ pk;
                }     
		    }    
		loadXMLDoc("../HR/HR_PipelineGraphicalView.aspx?IsRoleBase=<%=IsRoleBase%>&IsDorP="+IsDorP+"&PK="+pk+"&FromXML=1&RoleID="+RoleID+"&SkillID="+SkillID+"&Type="+type+"&ED="+ed+"&SD="+sd+"&For="+document.getElementById('HidFor').value+"&YearIncr="+document.getElementById('YearIncr').value,"","ForeCast");
		
		
	}
}

function loadXMLDoc(url,reqQuery,forwhich)	
{

if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
if(forwhich && forwhich=='BG')
xmlhttp.onreadystatechange= BG_state_Change;
else
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {
	if(forwhich && forwhich=='BG')
	xmlhttp.onreadystatechange= BG_state_Change;
	else if(forwhich && forwhich=='SOFTBOOK')
	xmlhttp.onreadystatechange= SOFTBOOK_state_Change;
	else
	xmlhttp.onreadystatechange=state_Change;

xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function SOFTBOOK_state_Change()
{
    if (parseInt(xmlhttp.readyState)==4) { 
		if (xmlhttp.status==200) {
            ForeCast_onClose();
            }
          }
    
}

function state_Change() 
{
	if (parseInt(xmlhttp.readyState)==4) { 
		if (xmlhttp.status==200) {
			document.getElementById('secForecast').innerHTML = xmlhttp.responseText;
			
			
			divForeCast.style.display="";
			
			divForeCast.style.left = (document.body.offsetWidth-document.getElementById('tblMain').offsetWidth)/2 + 40;
			divForeCast.style.top= vertTopBondary; 
			
			document.getElementById('fillDiv').style.display="block";
			
			
			if(document.getElementById('secForecast').offsetHeight > 420)
				document.getElementById('divForecast').style.height = 420;
			else
				document.getElementById('divForecast').style.height="";
			
		}
	}	
}
//Integrated by SanaS on 29-sep-2009
//commented by SanaS on 17-sep-2009
//var ShowFilter='0';
var ShowFilter='1';
//End Integrated by SanaS on 29-sep-2009

function Filters_OnClick()
{
		if (ShowFilter=='0')
		{					
			objdivFilter.style.left = (document.body.offsetWidth)/15;
			objdivFilter.style.top= vertTopBondary; 
			objdivFilter.style.display='';
			ShowFilter='1';
			document.getElementById('fillDiv').style.display="";
			
		}
		else if(ShowFilter=='1')
		{						
			objdivFilter.style.display='none';
			ShowFilter='0';  
			document.getElementById('fillDiv').style.display="none";
		}
	 
	
}



function Apply_OnClick()
{
objfrm.action = "../HR/HR_PipelineGraphicalView.aspx?FromWhere=RM";
objfrm.submit();
}

function BG_onChange()
{
 var BGID = GetObjectReference('','cboBG').value;
var url;
url= "HR_PipelineGraphicalView.aspx?FromXML=1&For=OU&BGID=" + BGID;
loadXMLDoc(url,'','BG');
var objOU = GetObjectReference('','cboOU');
setFocus(objOU);
}

function ChangeRefreshDisabledImg(sourceImg,evt)
{
	//Comment and modification by SuchitraP on 19-Nov-2008 for Resource Demand Changes
	//sourceImg.src = '../../Images/RefreshDisabled.gif';
	sourceImg.src = '../../Images/search_img.gif';
	//End by SuchitraP
}
function ChangeRefreshEnabledImg(sourceImg,evt)
{
  //Comment and modification by SuchitraP on 19-Nov-2008 for Resource Demand Changes
    //sourceImg.src = '../../Images/RefreshEnabled.gif';
    sourceImg.src = '../../Images/search_img.gif';
    //End by SuchitraP
}

function BG_state_Change()
{
	var strIDsAndNames,objOption,objCbo;
	var objLoc=GetObjectReference('','cboOU');
	
	if (parseInt(xmlhttp.readyState)==4) { if (xmlhttp.status==200){
	strIDsAndNames = xmlhttp.responseText.split("$___#");
	if(strIDsAndNames[0] == "BG")
	{ objCbo=objLoc; }
	
	objCbo.innerHTML = "";
	insBlankOpt(objCbo);
	for(i = 1;i<strIDsAndNames.length-1;i=i+2)
	{ objOption = new Option();
	objOption.text =  strIDsAndNames[i+1];
	objOption.value = strIDsAndNames[i];
	if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
	objCbo.add(objOption);
	else
	objCbo.add(objOption,null);
	}}}
}
function insBlankOpt(objCbo)
{
objOption = new Option();
      objOption.text =  "";
      objOption.value = "";

if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
       objCbo.add(objOption);
      else
       objCbo.add(objOption,null);
}
function ForeCast_onClose()
{
document.getElementById('fillDiv').style.display="none";	
divForeCast.style.display="none";
objdivFilter.style.display="none";
ShowFilter='0';
}
function ForeCastView_onChange()
{
Forecast_OnClick();
}

function showToolTip(src,evt)
{
   
    
if(curMoveVert)
return;
 
var r_tp_top,r_tp_left;
var l_tp_top,l_tp_left;
var r_tp_text, t_tp_text;
//Added by Dhanashri S on 27 Oct 2015
var l_tp_text;
//End of Addition by Dhanashri S on 27 Oct 2015
var vertOfrIndex;
var rIndex = src.getAttribute("vertIndex");

if(LToolTip.style.display == "none")
{

var L_TP_width,pos; 
L_TP_width = parseInt(LToolTip.style.width);
if (src.getAttribute("R_TT_TD_ID"))
{
pos= getPosition(document.getElementById(src.getAttribute("R_TT_TD_ID")))
r_tp_text = document.getElementById(src.getAttribute("R_TT_TD_ID")).title; //src.getAttribute("RtoolTip");
r_tp_top = pos.y - 6 -src.offsetHeight/3 - divForeCast.scrollTop;
r_tp_left = pos.x;

}
else
{
  //EDITED BY kiran k k 24-11-15 for 2289
    vertOfrIndex = document.getElementById('verR' + rIndex);
    //EDITED end BY kiran k k 24-11-15 2289
if(vertOfrIndex)
{
    if(vertOfrIndex.getAttribute("Target"))
    r_tp_text = document.getElementById(vertOfrIndex.getAttribute("Target")).title;
    else
    r_tp_text = "";
    r_tp_top = parseInt(vertOfrIndex.style.top) - src.offsetHeight/3;
    r_tp_left = parseInt(vertOfrIndex.style.left) + 1;
}
}

if (src.getAttribute("L_TT_TD_ID"))
{

	pos = getPosition(document.getElementById(src.getAttribute("L_TT_TD_ID")));
	l_tp_text = document.getElementById(src.getAttribute("L_TT_TD_ID")).title; //src.getAttribute("LtoolTip");
	l_tp_top = pos.y - 6 - src.offsetHeight/3 - divForeCast.scrollTop;
	l_tp_left = pos.x - L_TP_width;

}
else
{
	vertOfrIndex = document.getElementById('verL'+rIndex);
	if(vertOfrIndex)
	{
	    if(vertOfrIndex.getAttribute("Target"))
	    l_tp_text = document.getElementById(vertOfrIndex.getAttribute("Target")).title;
	    else
	    l_tp_text = "";
    	
	    l_tp_top = parseInt(vertOfrIndex.style.top) - src.offsetHeight/3;
	    l_tp_left = parseInt(vertOfrIndex.style.left) - L_TP_width;
	}
}

 

LToolTip.innerHTML = l_tp_text  ;
RToolTip.innerHTML = r_tp_text; 

if (l_tp_text!="")
LToolTip.style.display="";
LToolTip.style.left= l_tp_left; // parseInt(Ltarget.left) - 70;
LToolTip.style.top= l_tp_top; //parseInt(Ltarget.top) - src.offsetHeight/3;

if (r_tp_text!="")
RToolTip.style.display="";


if ( (r_tp_left+RToolTip.offsetWidth+35) > document.body.offsetWidth )
{

r_tp_left = r_tp_left - L_TP_width; //assume L_TP_width is same for R ToolTip div
r_tp_top = r_tp_top + ((src.offsetHeight/3) * 2 );
}
 

RToolTip.style.left=r_tp_left; 
RToolTip.style.top=r_tp_top;


}

}
function hideToolTip(src,evt)
{
	LToolTip.style.display="none";
	RToolTip.style.display="none";
}

isPageRenderedComplete = true;

<%if m_PageType=PageType.Pass1 OR m_PageType=PageType.Pass2 then %>
		if(!(document.getElementById('cboBG').value=="" && document.getElementById('cboOU').value=="" && document.getElementById('cboRole').value=="" && document.getElementById('cboSkill').value=="" ))
		if (isWinOnLoadExecComplete==true && isPageRenderedComplete == true)
			{ document.getElementById('fillDiv').style.display="none";  }
		
	<%else%>
		if (isWinOnLoadExecComplete==true && isPageRenderedComplete == true)
		document.getElementById('fillDiv').style.display="none";
	<%End if %>
	
	//Added by ShraddhaM on 17,Sept 2008
	function allocate(DorP,PRJID,SD,ED,EMPNAME,EMPID,ROLEID,RECPER,TENDATE,JD,Pipe_OR_Team_PK,IsSoftBook,MapToProjectOnHold,OnHoldProjectName,IsProjectApproved,IsNewWF,IsOtherSoftBooked,SoftBookedDemands)
	{	
	    	     
	    if(IsSoftBook == '1')
	    {
	        alert("You have already soft booked to '" + EMPNAME + "'");
	        return;
	    }
	    
	 if(IsOtherSoftBooked == '1' && SoftBookedDemands != '')
	    {
				 blnContinue = window.confirm( EMPNAME + ' is already softbooked for the following demands : \n' + SoftBookedDemands + '\n Do you want to continue ?' );
				 
				 if(blnContinue == false)
				 {
					return;
				 }
				 
	    }
	    
	    if(DorP == 'D')
	    {			 
				if(getDate(SD) < getDate(JD))
				{
					alert("You cannot softbook '" + EMPNAME + "' before his joining date '" + JD + "'");
					return;
				}
			 
	    }
	    if(MapToProjectOnHold == 'True')
	    {
	        alert("Allocation of resource cannot be performed as '"+OnHoldProjectName+"' project is OnHold.");
	        return;
	    }
//	    if((IsProjectApproved != 'B' && IsProjectApproved != 'b') && IsApprovalWF == 'True')
//	    {
//	        alert("Allocation of resource cannot be performed as '"+OnHoldProjectName+"' project is not approved.");
//	        return;
//	    }
	    
	     if((IsProjectApproved != 'B' && IsProjectApproved != 'b') && IsNewWF == 'False')
	    {
	        alert("Allocation of resource cannot be performed as '"+OnHoldProjectName+"' project is not approved.");
	        return;
	    }
	    
	  	    
		var intPer = new Number(RECPER);
		 
		intPer = <%=m_SettingValueResAll%> - intPer;
		 
		if (DorP=="P" || DorP == "p")
		 {  //Added by SanaS- To put the selected project in session
		    var strUrl; 
		    g_PRJID=PRJID;
		    g_SD=SD;
		    g_ED=ED;
		    g_EMPNAME=EMPNAME;
		    g_EMPID=EMPID;
		    g_ROLEID=ROLEID;
		    g_RECPER=intPer;
		    g_TENDATE=TENDATE;
		    g_JD=JD;
		    g_Pipe_OR_Team_PK=Pipe_OR_Team_PK;
            strUrl = new String();
	        strUrl = '../General/XMLHttp.aspx?TagID=20053&ProjectID=' + PRJID;
    								
	        if (document.all)
	        { 
		        objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
		        objXHttp.onreadystatechange = HandlerOnReadyState; 
		        objXHttp.open('GET', strUrl, false); 
		        objXHttp.send();           
	        }
	        else  
	        {
		        objXHttp = new XMLHttpRequest();  
		        objXHttp.onreadystatechange = HandlerOnReadyState(); 
		        objXHttp.open('GET', strUrl, false);
		        objXHttp.send(null);  
	        }
		    //end addition by Sana
		    //Commneted by SanaS
		    //window.open("../../Source/General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&FromADSEARCH=1&Pipe_OR_Team_PK="+Pipe_OR_Team_PK+"&SD="+SD+"&ED="+ED+"&RECPER="+intPer+"&TENDATE="+TENDATE+"&RoleID="+ROLEID+"&EmpID="+EMPID+"&EmployeeName="+escape(EMPNAME)+"&PRJID="+PRJID,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=900,height=600", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=900,height=600");
		    //end Comment by SanaS
		    ForeCast_onClose();
		    
		 }
 	    else 
 	    { 			
 	        loadXMLDoc("HR_PipelineGraphicalView.aspx?FromXML=1&For=SOFTBOOK&Pipe_OR_Team_PK="+Pipe_OR_Team_PK+"&SD="+SD+"&ED="+ED+"&RECPER="+intPer+"&TENDATE="+TENDATE+"&RoleID="+ROLEID+"&EmpID="+EMPID+"&EmployeeName="+escape(EMPNAME)+"&PRJID="+PRJID,"","SOFTBOOK");
 	        alert('Resource successfully soft booked');
 	        ForeCast_onClose();
 	     }
	}
	//added by SanaS 
	function HandlerOnReadyState()
		{						
			if (objXHttp.readyState == 4)
			{  
			    if (objXHttp.responseText == 'True')
			    //Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited  				
			    //window.open("../../Source/General/CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&FromADSEARCH=1&Pipe_OR_Team_PK="+g_Pipe_OR_Team_PK+"&SD="+g_SD+"&ED="+g_ED+"&RECPER="+g_RECPER+"&TENDATE="+g_TENDATE+"&RoleID="+g_ROLEID+"&EmpID="+g_EMPID+"&EmployeeName="+escape(g_EMPNAME)+"&PRJID="+g_PRJID+"&JDATE="+g_JD,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=900,height=600", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=900,height=600");
			    window.open("../PM/Resources_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=1019&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&FromADSEARCH=1&Pipe_OR_Team_PK="+g_Pipe_OR_Team_PK+"&SD="+g_SD+"&ED="+g_ED+"&RECPER="+g_RECPER+"&TENDATE="+g_TENDATE+"&RoleID="+g_ROLEID+"&EmpID="+g_EMPID+"&EmployeeName="+escape(g_EMPNAME)+"&PRJID="+g_PRJID+"&JDATE="+g_JD,"", "resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=900,height=600", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=900,height=600");
			    //End of Commented and added by NitinC on 20 April 2011 for WhizibleSEM 10.0 after sub projects page is inherited 
			   
			}
		}
	//End addition by SanaS
//function ProjectAllocation_clicked(FromDate,ToDate)
function ProjectAllocation_OnClick(FromDate,ToDate)
{
    var strQueryString = "?From=Advancedsearch&FromDate=" + FromDate + "&ToDate=" + ToDate ;
   
	window.open("HR_RCV_ProjectAllocation.aspx" + strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
}

	//End of addition by ShraddhaM
	
function OptRoleSkill_OnChange(v)
{
    var objoptRoleSkill = GetObjectReference('','optRoleBase').value;
    var objform = GetFormReference('frmPipelineGraphicalView');
    
    objform.action = "HR_PipelineGraphicalView.aspx?For="+document.getElementById('HidFor').value;  
	objform.submit();
    
}
		</SCRIPT>
	</body>
</HTML>
