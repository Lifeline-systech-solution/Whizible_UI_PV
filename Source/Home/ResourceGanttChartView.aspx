<%@ Page Language="vb"  AutoEventWireup="false" CodeBehind="ResourceGanttChartView.aspx.vb" Inherits="PbNIT.ResourceGanttChartView" %>

<html >
<%  CommonFunctions.General.PlotPageHeadTag("Resource Chart View")%>

<script language='javascript' src='../AdvancedTimesheet/timesheet.js'></script>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>

<body class="clsBody" onresize="window_onResize()" onmouseup="clickDocUp(event)" ondragstart="return false;"
		onload="window_onLoad()" >
<div id='DateTitle' style=' BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:60px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Dec 2007</div>
		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
		<div id="divLTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp; 
			12 Left 2007</div>
		<div id="divRTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Right 2007</div>
		<SCRIPT>
//if(document.getElementById('fillDiv'))
//document.getElementById('fillDiv').style.display="block";
		</SCRIPT>
		<form id="frmResGanttChartView" method="post" >
           <!-- <asp:Panel ID="Panel1" runat="server" Height="50px" Width="879px" BackColor='lightblue' style="border-bottom :lightblue 1px outset;"   >
            </asp:Panel>-->
			<%PageInit()%>
			
    </form>
    
<script language="javascript">
   
   // if(document.getElementById('fillDiv'))
     //   document.getElementById('fillDiv').style.display="block";
 
 
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
    var objfrm=GetFormReference('frmResGanttChartView');
    var objdivlist=GetObjectReference('frmResGanttChartView','divList');
     
    var ie5=document.all&&document.getElementById
    var ns6=document.getElementById&&!document.all
      
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
	var DT;
	var isLorR,DT_TD_width;
	var LB,RB,LBid,RBid;
	var objfrm;
	var LToolTip,RToolTip;
	var divForeCast,objdivFilter;
	var dtProjectStartDate = getDate('<%=m_strProjectStartDate%>');
	var	dtProjectEndDate = getDate('<%=m_strProjectEndDate%>');
	var IsCaseOneProject="<%=IsCaseOneProject%>";
	var IsCase3Project="<%=IsCase3Project%>";
	
	if(GetObjectReference('frmResGanttChartView','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('frmResGanttChartView','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmResGanttChartView','txtPageNumber');
		}
		
    function window_onLoad()
    {

    DT = document.getElementById("DateTitle"); //Date Title

     
    LToolTip = document.getElementById('divLTooltip');
    RToolTip = document.getElementById('divRTooltip');

        var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if(objdivlist)
		{
			if (navigator.appName == 'Microsoft Internet Explorer'){
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
			}
			else{
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
		}
			
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
	if(document.getElementById('Task'))
	{
        vertTopBondary = getPosition(document.getElementById('Task')).y - 2 ; // - document.getElementById('Role').offsetHeight;
	    vertBottomBondary = getPosition(document.getElementById('Task')).y + objdivlist.offsetHeight - (document.getElementById('Task').offsetHeight/2);
    }  
      objdivlist.onscroll=Scroll;	
		Scroll();
			
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

var objdivAR=GetObjectReference('frmResGanttChartView','divAR');
var objdivATT=GetObjectReference('frmResGanttChartView','divATT');
var objdivAP=GetObjectReference('frmResGanttChartView','divAP');
var objdivView=GetObjectReference('frmResGanttChartView','divView');

function OffOpenDivs()
{
    if(objdivAR!=null )
            objdivAR.style.display='none';
    
    if(objdivATT!=null )
        objdivATT.style.display='none';
      
     if(objdivAP!=null)  
             objdivAP.style.display='none';
             
      if(objdivView!=null)         
        objdivView.style.display='none';
   
   if(objdivASTA!=null)         
        objdivASTA.style.display='none';
        
}
function clickDocUp(evt)
{
    OffOpenDivs();
   
    
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
			if(GantViewEndMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewEndDay == i )
					{ isCrossRightBoundary=true; //break;
								 }
			///Added by PrashantSJ on 16th March 2009					 
		if(dtTD!=null)
				{
				
				
				if(!ValidateEndDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0])) {isCrossRightBoundary=true;break; }
				}
            //End of addition by PrashantSJ on 16th March 2009									 
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
function MoveVertLeftHand(evt)
{//PrashantSJ on 16th March 2009
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
			//Prashant
			/*if(GantViewStartMon == arrTargetInfo[1] && GantViewStartDay == arrTargetInfo[2] )
			alert("caught it");
			else*/
			
			
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
					{ isCrossLeftBoundary=true; //break;
					 }
				
				//Added By PrashantSJ on 16th March 2009
				if(dtTD!=null)
				{
				if(!ValidateDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0] )) {isCrossLeftBoundary=true; break;}
				}
				//End of addition by PrashantSJ 16th March 2009
					
				if(dtTD)
				{
					
					var dtTDx = getPosition(dtTD).x;
					if(evt.clientX < (parseInt(dtTDx)+ DT_TD_width)) // && evt.clientX <= (parseInt(dtTDx)+ dtTD.offsetWidth)  )
					{ dtTD.bgColor = fillColor; lastdtTD = dtTD;  
					
					}
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
function ValidateDates(dtCurrentDate,TaskID)
 {

        // dtCurrentStartDate=getDate(dtTD.title);
        if((dtProjectStartDate != null)  && (dtCurrentDate != null))
        {
           if(dtCurrentDate < dtProjectStartDate)
            {
                strMsg="Start date should be greater than project start date (<%=m_strProjectStartDate%>).";
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
        }
        if(IsCaseOneProject=="False" && objhidParentTaskID!=null )
	     {
	          var objhidParentTaskID=GetObjectReference('frmResGanttChartView','hidParentTaskID'+TaskID);  
              var objParentTaskStartDate=GetObjectReference('frmResGanttChartView','hidParentStartDate'+objhidParentTaskID.value);
           
             if(dtCurrentDate < getDate(objParentTaskStartDate.value))
            {
                strMsg='Task start date should be greater than parent task start date ('+objParentTaskStartDate.value+').';
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
              
         }       
        
   	return true;
}
    
    function ValidateEndDates(dtCurrentDate,TaskID)
    {
       //dtCurrentEndDate=getDate(dtTD.title);
        if((dtProjectEndDate != null) &&  (dtCurrentDate != null))
		{
			//if(dtCurrentDate > dtProjectEndDate)
			if(DateDiff(dtProjectEndDate,dtCurrentDate,'d')>0)
			{	
				strMsg="End date should be less than project end date (<%=m_strProjectEndDate%>).";
				//strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
				alert(strMsg);			
				return false;
			}
		}
	    if(IsCaseOneProject=="False" && objhidParentTaskID!=null)
	     {
	          var objhidParentTaskID=GetObjectReference('frmResGanttChartView','hidParentTaskID'+TaskID);  
              var objParentTaskEndDate=GetObjectReference('frmResGanttChartView','hidParentEndDate'+objhidParentTaskID.value);
           
             //if(dtCurrentDate < getDate(objParentTaskEndDate.value))
             if(DateDiff(getDate(objParentTaskEndDate.value),dtCurrentDate,'d')>0)
            {
                strMsg='Task end date should be less than parent task end date ('+objParentTaskEndDate.value+').';
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
              
         }   
	return true;
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
function showToolTip(src,evt)
{
if(curMoveVert)
return;

var r_tp_top,r_tp_left;
var l_tp_top,l_tp_left;
var r_tp_text,t_tp_text;
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

vertOfrIndex = document.getElementById('VerR'+rIndex);
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
	vertOfrIndex = document.getElementById('VerL'+rIndex);
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
function FilterTasks()
{
    objfrm.action="../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
    objfrm.submit();
}
function NextOrPrevPeriod(Period)
{
    objfrm.action="../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1&Period="+Period;  
    objfrm.submit();
}
function Save_OnClick()
{
        if(!ValidateControls()) return;
        objfrm.action="../Home/ResourceGanttChartView.aspx?From_Where=HRHome&Mode=Save";  
        objfrm.submit();
}
function ValidateControls()
{
    var objchkSelect=GetObjectReference('frmResGanttChartView','chkSelect',true);
 
    if(objchkSelect!=null)
    {
        for(var i=0;i<objchkSelect.length;i++)
        {
            if(objchkSelect[i].checked==true)
            {
                  objHidtxtARID=GetObjectReference('frmResGanttChartView','hidTxtARID'); 
                  objHidtxtATTID=GetObjectReference('frmResGanttChartView','hidTxtTTID'); 
                  objHidtxtAPR=GetObjectReference('frmResGanttChartView','hidTxtAPR'); 
                  var objhidTxtASTA=GetObjectReference('frmResGanttChartView','hidTxtASTA'); 
                  
                  if(objHidtxtARID.value=='') 
                  {
                        alert('Please select resource ');
                        return false;
                  }
                  if(objHidtxtATTID.value=='') 
                  {
                        alert('Please select task type ');
                        return false;
                  }
                  
                  
                  if(objhidTxtASTA!=null && IsCase3Project=="True")
                  {
                    if(objhidTxtASTA.value=='')
                     {
                        alert('Please select Activity ');
                        return false;
                     }
                  } 
                  
                  if(objHidtxtAPR.value=='')
                  {
                        alert('Please select priority ');
                        return false;
                  }  
            }
        }
    }
    return true;
}
//function txtWork_OnBlur(objCurrentWork,TaskID,ParentTaskID)
//{
//    objActualWork = GetObjectReference('frmResGanttChartView','txtActualWork'+TaskID);
//   
//    
//	if(disallowBlank(objCurrentWork, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))
//			return ;
//	if(disallowMinValueViolation(objCurrentWork, 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>",true))
//			return ;
//			
//	if(objActualWork!=null && objCurrentWork!=null)
//	{
//	    if(parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
//	    {
//	          alert('Planned Hours Should be greater than actual hours (' +objActualWork.value+')');
//	          setFocus(objCurrentWork);
//	          return ;
//	    }
//	}
//	
//	if(IsCaseOneProject=="False")
//	{
//	    var PlannedHours = GetObjectReference('frmResGanttChartView','hidAllChildTaskWork' + ParentTaskID, true);
//	    var objParentTask= GetObjectReference('frmResGanttChartView','hidParentTaskWork'+ParentTaskID);
//	    var objhidChildTaskWork=GetObjectReference('frmResGanttChartView','hidChildTaskWork'+TaskID);
//	    
//	    if(PlannedHours!=null)
//	    {
//	    var intCnt, ChildPlanned=0, TotalChildplanned=0;
//		for (intCnt=0; intCnt < PlannedHours.length; intCnt++)
//		{
//			ChildPlanned = parseFloat(PlannedHours[intCnt].value);
//			TotalChildplanned = TotalChildplanned + ChildPlanned;
//		}
//		
//		TotalChildplanned=TotalChildplanned-parseFloat(objhidChildTaskWork.value);
//		
//		TotalChildplanned=TotalChildplanned+parseFloat(objCurrentWork.value);
//		} 
//		if(objParentTask!=null)
//		{	
//		    if(parseFloat(objParentTask.value) < TotalChildplanned)
//		    {
//		        alert('Planned Hours should not be greater than the Parent Planned Hours (' +objParentTask.value + ').');
//		        setFocus(objCurrentWork);
//		        return;
//		    }	
//		        
//		}    
//	}	
//		
//}
function Views_OnChange()
{
     objfrm.action="../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
     objfrm.submit();
} 
function Page_Onclick(PageNumber)
{
	
	// Modified by SandipL on 3 Feb 2006 
  strLocation = "../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=" + String(parseInt(PageNumber));

	objfrm.action = strLocation
	objfrm.submit();

} 
function EntityName_OnKeyup(e)
{
   var code;
    if (e.keyCode) 
	    code = e.keyCode;
    else
	    if (e.which) 
		    code = e.which;
    		
    if(code==13) 
    {
     strLocation = "../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1";

	objfrm.action = strLocation
	objfrm.submit(); 
    }
}    
function GanttView_OnChange()
{
     strLocation = "../Home/ResourceGanttChartView.aspx?From_Where=HRHome";

	objfrm.action = strLocation
	objfrm.submit(); 

}
function CreateRowForTasks()
		{
		
			//noOfRows = noOfRows + 1;
			var objTbl = GetObjectReference('frmResGanttChartView','tblGanttTask');
			var objItemCount = GetObjectReference('frmResGanttChartView','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmResGanttChartView','txtPreItemCount');
			
			if (objItemCount!=null){
				intItemCount = parseInt(objItemCount.value);
			}
			if (objItemCount!=null){
				intPreItemCount = parseInt(objtxtPreItemCount.value);
			}
			
				    
			var startMandHTML = " ";
			var NewTR,newTD;
			var strFrequencyHTML;
			var strHTML;
			var strcombohtml;


			NewTR = objTbl.insertRow(parseInt(intItemCount+1));
			

			NewTR.className = 'clsTRBlank';
			NewTD = NewTR.insertCell(0);
			NewTD.align='center';
			strHTML= "<td class='clsTDBlank' width='2%'><IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
			NewTD.innerHTML= strHTML+"</td>";
						
				
			NewTD = NewTR.insertCell(1);
			NewTD.align='left';
			NewTD.innerHTML = "<td class='clsTDBlank' width='28%' ><Input type=textbox name=txtTaskName_"+String(intPreItemCount)+" id=txtTaskName_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:200px;text-align:Left' maxlength=255  /></td>";	
			
			NewTD = NewTR.insertCell(2);
			NewTD.align='center';	
			NewTD.innerHTML = "<td class='clsTDBlank'></td>"		
           
            NewTD = NewTR.insertCell(3);
			NewTD.align='center';	
			NewTD.innerHTML = "<td class='clsTDBlank'></td>"		
			
			NewTD = NewTR.insertCell(4);
			NewTD.align='center';	
			NewTD.innerHTML = "<td class='clsTDBlank'></td>"		
			
			NewTD = NewTR.insertCell(5);
			NewTD.align='center';	
			NewTD.innerHTML = "<td class='clsTDBlank'></td>"		
			
			setSectionRowCount(1,intPreItemCount);
			
		}
		function setSectionRowCount(flag,noOfRows)
		{
			var objtxtItems=GetObjectReference('frmResGanttChartView','txtItems');
			var objItemCount = GetObjectReference('frmResGanttChartView','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmResGanttChartView','txtPreItemCount');
			
			if(flag==1)
			{
				if(objItemCount!=null){
					objItemCount.value=parseInt(objItemCount.value)+1;
					
				}
				if(objtxtItems!=null){
					objtxtItems.value=objtxtItems.value + noOfRows+",";
				}
				if(objtxtPreItemCount!=null){
					objtxtPreItemCount.value=parseInt(objtxtPreItemCount.value)+1;
				}	

					
			}
			else
			{
				if(objItemCount!=null){
					objItemCount.value=parseInt(objItemCount.value)-1;
				}
				if(objtxtItems!=null){
					objtxtItems.value=objtxtItems.value.replace(noOfRows+",","");
				}
									
			}
       window_onLoad();
		}
		function deleteRow(objImg, rowID)
		{   
	
			var objTbl = GetObjectReference('frmResGanttChartView','tblGanttTask');
			var objtxtItemCount=GetObjectReference('frmResGanttChartView','txtItemCount');
			var rowNo=objImg.parentElement.parentElement.rowIndex
			
			objTbl.deleteRow(rowNo);
			setSectionRowCount(0,rowID);
		}
		function optTaskType_OnClick()
		{
        strLocation = "../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1";

	    objfrm.action = strLocation
	    objfrm.submit(); 
		}
		
		
		    
		function AHref_OnClick(HrefID,e)
		{
		
		var objdiv,objhr;
	
		 if(HrefID=="hrAR")
		 {
		    objdiv=GetObjectReference('frmResGanttChartView','divAR');
		    objhr=GetObjectReference('frmResGanttChartView','hrAR');    
		 } else if (HrefID=="hrATT")
		 {
		     objdiv=GetObjectReference('frmResGanttChartView','divATT');
		     objhr=GetObjectReference('frmResGanttChartView','hrATT'); 
		 }
		 else if(HrefID=="hrAP")
		 {
		     objdiv=GetObjectReference('frmResGanttChartView','divAP');
		     objhr=GetObjectReference('frmResGanttChartView','hrAP'); 
		 }
		 else if(HrefID=="hrView")
		 {
		      objdiv=GetObjectReference('frmResGanttChartView','divView');
		       objhr=GetObjectReference('frmResGanttChartView','hrView'); 
		  }
		  else if(HrefID=="hrASTA")
		 {
		      objdiv=GetObjectReference('frmResGanttChartView','divSTA');
		       objhr=GetObjectReference('frmResGanttChartView','hrASTA'); 
		  }
		    
		    if(objdiv!=null)
		    {
		        showmenuie(objdiv,e);
		  /*    if(objdiv.style.display=='none')
		        {
		        objdiv.style.top= objhr.style.top;
		        if(HrefID=="hrAR")
                    objdiv.style.left=objhr.style.left+111;
                else if (HrefID=="hrATT")
                    objdiv.style.left=objhr.style.left+421;
                else if (HrefID=="hrAP")  
                    objdiv.style.left=objhr.style.left+700;
                else
                    objdiv.style.left=objhr.style.left;
                        
                objdiv.zIndex=99;
                objdiv.style.display='block';
                }
                else
                   objdiv.style.display='none'*/
		    }
		    
		}
		function showmenuie(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

    if (objDivH > 200)
        objDivH=200;
              
    if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX

    //same concept with the vertical position
    if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
  if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        e.stopPropagation();
   
  
  return false;
  
   }
		function Attribute_OnClick(sID,sText,HrefID)
		{
		    var objdiv,objhr,objHidtxtAtt;
		
		     if(HrefID=="hrAR")
		     {
		        objdiv=GetObjectReference('frmResGanttChartView','divAR');
		        objhr=GetObjectReference('frmResGanttChartView','hrAR');  
		        objHidtxtAtt=GetObjectReference('frmResGanttChartView','hidTxtARID');  
		      
		        
		     } else if (HrefID=="hrATT")
		     {
		         objdiv=GetObjectReference('frmResGanttChartView','divATT');
		         objhr=GetObjectReference('frmResGanttChartView','hrATT'); 
		         objHidtxtAtt=GetObjectReference('frmResGanttChartView','hidTxtTTID'); 
		          
		        
		         
		     }
		     else if (HrefID=="hrAP")
		     {
		         objdiv=GetObjectReference('frmResGanttChartView','divAP');
		         objhr=GetObjectReference('frmResGanttChartView','hrAP'); 
		         objHidtxtAtt=GetObjectReference('frmResGanttChartView','hidTxtAPR');
		        
		     }
		    else if (HrefID=="hrView")
		     {
		         objdiv=GetObjectReference('frmResGanttChartView','divView');
		         objhr=GetObjectReference('frmResGanttChartView','hrView'); 
		         objHidtxtAtt=GetObjectReference('frmResGanttChartView','cboViews');
		        
		     }
		     else if (HrefID=="hrASTA")
		     {
		         objdiv=GetObjectReference('frmResGanttChartView','divSTA');
		         objhr=GetObjectReference('frmResGanttChartView','hrASTA'); 
		         objHidtxtAtt=GetObjectReference('frmResGanttChartView','hidTxtASTA');
		        
		     }
		    //objhr.innerHTML=sText;
		    objhr.value=sText;
		    objdiv.style.display='none';
		    
			 if (HrefID=="hrATT" && IsCase3Project=="True")
		     {
		        var objhr1=GetObjectReference('frmResGanttChartView','hrASTA'); 
		        if(objhr1!=null) 
		            objhr1.value='';
		        loadXMLDoc("../Home/AJAXHttp.aspx?MasterTagID=1038","TaskTypeID="+sID);
		         
		     }
			
			
		   if(objHidtxtAtt!=null)
		            objHidtxtAtt.value=sID;
		            
		   if (HrefID=="hrView") 
		   {
		       objhr.title=sText;
		       objfrm.action="../Home/ResourceGanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
               objfrm.submit();
		   }         
		     
		    
		}
		function SelectOnClick(objSelect)
		{
		    if(objSelect!=null)
		    {
		        var objtxtWork=GetObjectReference('frmResGanttChartView','txtWork'+objSelect.value);  
		        if(objtxtWork!=null)
		        {
		            if(parseFloat(objtxtWork.value)<=0)
		            {
		                alert('Work (hrs) should be greater than zero (0) !');
		                objSelect.checked=false;
		               // setFocus(objtxtWork);
		                return;
		            }
		        }    
		    } 
		}
		
		function ShowEntityEditMode(intPKId,m_strToken,FromDate,ToDate)
		{			 		
		    
			 window.open ("../HR/HR_RCV_ProjectAllocation.aspx?EmployeeID="+intPKId+"&From=ResGanttView&FromDate=" + FromDate + "&ToDate=" + ToDate, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=600");
			 
		}

var xmlhttp;		
function loadXMLDoc(url,reqQuery)
{
// code for Mozilla, etc.
if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    xmlhttp.onreadystatechange=state_Change;
if (ns)
{
    xmlhttp.open("GET",url+"&"+reqQuery,true)
    xmlhttp.send(false)
}

else
{
    xmlhttp.open("POST",url,true)
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send(reqQuery)

}
}

// code for IE
else if (window.ActiveXObject)
    {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
        if (xmlhttp)
        {
            xmlhttp.onreadystatechange=state_Change
            xmlhttp.open("POST",url,true)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery)
        }
    }
}

var objdivASTA=GetObjectReference('','divSTA');

function state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
        if(objdivASTA!=null)
            objdivASTA.innerHTML=xmlhttp.responseText;
        
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}


var ShowFilter='0';
function showFilters(show)
{
    objtblFilter = GetObjectReference('FrmScoreCardReview','tblFilter');
    objimgFilter =GetObjectReference('FrmScoreCardReview','imgFilter');
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
	var objtxtpageNumber =  GetObjectReference('frmResGanttChartView','txtPageNumber');
//	var objEmployee=GetObjectReference('frmResGanttChartView','txtResource').value;	
//	
//	var objBG=GetObjectReference('frmResGanttChartView','cboBG').value;	
//	var objOU=GetObjectReference('frmResGanttChartView','cboOU').value;	
//	var objDU=GetObjectReference('frmResGanttChartView','cboDU').value;	
//	var objDT=GetObjectReference('frmResGanttChartView','cboDT').value;	
//	var objEmpTypeID=GetObjectReference('frmResGanttChartView','cboEmpType').value;	
//	var objDepartmentID = GetObjectReference('frmResGanttChartView','cboDepartment').value;	
//	var objRole=GetObjectReference('frmResGanttChartView','cboRole').value;	
//	var objDesignation=GetObjectReference('frmResGanttChartView','cboDesignation').value;	
//	var objSkill=GetObjectReference('frmResGanttChartView','cboSkill').value;		
	//var objtxtMonth=GetObjectReference('frmResGanttChartView','txtMonth');
	//var objtxtYear=GetObjectReference('frmResGanttChartView','txtYear');	
	//var Year=objtxtYear.value;
	//var MonthID=objtxtMonth.value;
	
	//objform.action = "frmResGanttChartView.aspx?Month=" + MonthID + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + Year;  
	objfrm.action = "ResourceGanttChartView.aspx?PageNumber=" + objtxtpageNumber.value;  
	//enableAllControls();
	objfrm.submit();
}

function ClearFilter()
{
	var objtxtpageNumber =  GetObjectReference('frmResGanttChartView','txtPageNumber');
	var objEmployee=GetObjectReference('frmResGanttChartView','txtResource').value = '';	
	var objBG=GetObjectReference('frmResGanttChartView','cboBG').value = '';	
	var objOU=GetObjectReference('frmResGanttChartView','cboOU').value = '';	
	var objDU=GetObjectReference('frmResGanttChartView','cboDU').value = '';	
	var objDT=GetObjectReference('frmResGanttChartView','cboDT').value = '';	
	var objEmpTypeID=GetObjectReference('frmResGanttChartView','cboEmpType').value = '';	
	var objDepartmentID = GetObjectReference('frmResGanttChartView','cboDepartment').value = '';	
	var objRole=GetObjectReference('frmResGanttChartView','cboRole').value = '';	
	var objDesignation=GetObjectReference('frmResGanttChartView','cboDesignation').value = '';	
	var objSkill=GetObjectReference('frmResGanttChartView','cboSkill').value = '';		
	var objDeployable=GetObjectReference('frmResGanttChartView','cboDeployable').value = '';
	
	var objResourcePool=GetObjectReference('frmResGanttChartView','cboResourcePool')
	
	if(objResourcePool.disabled == false)
	objResourcePool.value = '';	
	
//	var objtxtMonth=GetObjectReference('frmResGanttChartView','txtMonth');
//	var objtxtYear=GetObjectReference('frmResGanttChartView','txtYear');	
//	var Year=objtxtYear.value;
//	var MonthID=objtxtMonth.value;
	
	pageNumber = objtxtpageNumber.value;
	if(pageNumber == '')
		pageNumber = '1';
		
	//objfrm.action = "ResourceGanttChartView.aspx?Month=" + MonthID + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + Year;  
	objfrm.action = "ResourceGanttChartView.aspx?PageNumber=" + pageNumber;
	
	//enableAllControls();
	objfrm.submit();
	
}
function BG_onChange()
{
 var BGID = GetObjectReference('frmResGanttChartView','cboBG').value;
var url;
url= "ResourceGanttChartView.aspx?FromXML=1&From=BG&BGID=" + BGID;
loadXMLDoc(url,'');
var objOU = GetObjectReference('frmResGanttChartView','cboOU');
setFocus(objOU);
}
function OU_onChange()
{
var BGID = GetObjectReference('frmResGanttChartView','cboBG').value;
var OUID = GetObjectReference('frmResGanttChartView','cboOU').value;
var objDU = GetObjectReference('frmResGanttChartView','cboDU');
var objDT = GetObjectReference('frmResGanttChartView','cboDT');

var url;
if(BGID != "" && OUID=="")
{
objDT.innerHTML=""; insBlankOpt(objDT); objDU.innerHTML=""; insBlankOpt(objDU);
}
else
{
url= "ResourceGanttChartView.aspx?FromXML=1&From=OU&OUID=" + OUID+"&BGID="+BGID;
loadXMLDoc(url,'');
var objDU = GetObjectReference('frmResGanttChartView','cboDU');
setFocus(objDU);
}
}

function DU_onChange()
{
var BGID = GetObjectReference('frmResGanttChartView','cboBG').value;
var OUID = GetObjectReference('frmResGanttChartView','cboOU').value;
var DUID = GetObjectReference('frmResGanttChartView','cboDU').value;
var objDT = GetObjectReference('frmResGanttChartView','cboDT');
var url;

if( (BGID != "" || OUID !== "") && DUID=="")
{
objDT.innerHTML=""; insBlankOpt(objDT);
}
else
{
	url= "ResourceGanttChartView.aspx?FromXML=1&From=DU&DUID=" + DUID+"&BGID="+BGID+"&OUID="+OUID;
	loadXMLDoc(url,'');
	var objDT = GetObjectReference('frmResGanttChartView','cboDT');
	setFocus(objDT);
}
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
var strIDsAndNames,objOption,objCbo;
var objLoc=GetObjectReference('','cboOU');
var objDU=GetObjectReference('','cboDU');
var objDT=GetObjectReference('','cboDT');

if (parseInt(xmlhttp.readyState)==4) { if (xmlhttp.status==200){
strIDsAndNames = xmlhttp.responseText.split("$___#");
if(strIDsAndNames[0] == "BG")
{ objCbo=objLoc; objDU.innerHTML=""; insBlankOpt(objDU); objDT.innerHTML = ""; insBlankOpt(objDT); }
else if(strIDsAndNames[0] == "OU")
{ objCbo=objDU; objDT.innerHTML = ""; insBlankOpt(objDT); }
else if(strIDsAndNames[0] == "DU")
objCbo=objDT;
objCbo.innerHTML = "";
insBlankOpt(objCbo);
for(var i = 1;i<strIDsAndNames.length-1;i=i+2)
{ objOption = new Option();
 objOption.text =  strIDsAndNames[i+1];
 objOption.value = strIDsAndNames[i];
 if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
 objCbo.add(objOption);
 else
 objCbo.add(objOption,null);
}}}}


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

function ProjectAllocation_clicked(FromDate,ToDate)
{
  
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource') ;	
	var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG') ;	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU') ;	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU') ;	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT') ;	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType');	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment') ;	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole') ;	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation') ;	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill') ;		
	var objDeployable=GetObjectReference('frmHRResourceCalenderView','cboDeployable') ;
	
	var objResourcePool=GetObjectReference('frmHRResourceCalenderView','cboResourcePool')
		
//	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
//	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
//	var Year=objtxtYear.value;
//	var MonthID=objtxtMonth.value;
	var pageNumber;
	
	pageNumber = objtxtpageNumber.value;
	if(pageNumber == '')
		pageNumber = '-1';
	 
	
	 
	var strQueryString = "?From=RESGanttView&PageNumber=" + pageNumber + "&EmployeeName=" +objEmployee.value + "&BGID=" + objBG.value +"&OUID=" + objOU.value ;	
	strQueryString = strQueryString + "&DUID=" +objDU.value + "&DTID=" + objDT.value + "&EmpType=" +objEmpTypeID.value ;
	strQueryString = strQueryString + "&DeptID=" +objDepartmentID.value + "&RoleID=" +objRole.value + "&DesignationID=" + objDesignation.value;
	strQueryString = strQueryString + "&SkillID=" + objSkill.value + "&Deployable=" + objDeployable.value + "&ResourcePoolID=" + objResourcePool.value;
	strQueryString = strQueryString + "&FromDate=" + FromDate + "&ToDate=" + ToDate ;
	 
	
	window.open("../HR/HR_RCV_ProjectAllocation.aspx" + strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
}

   function SwitchToAllocationMode()
   {		
        window.open("../HR/ResourceAllocationDashbaord.aspx?FromWhere=MDB&MasterTagId=3982", "_self");
   }

  	   </script>


    
</body>
</html>
