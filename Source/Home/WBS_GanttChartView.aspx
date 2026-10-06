<%@ Page Language="vb"  AutoEventWireup="false" CodeBehind="WBS_GanttChartView.aspx.vb" Inherits="PbNIT.WBS_GanttChartView" %>

<html >
<%  CommonFunctions.General.PlotPageHeadTag("Gantt Chart View")%>

<script language='javascript' src='../AdvancedTimesheet/timesheet.js'></script>
<script language='javascript' src='../DB/DateFormat.js'></script>

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>
  
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>

<body  class="clsBody" onresize="window_onResize()" onmouseup="clickDocUp(event)"  ondragstart="return false"
		onload="window_onLoad()" >
<div id='DateTitle' style=' BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:60px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Dec 2007</div>
		
		<div id="divLTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp; 
			12 Left 2007</div>
		<div id="divRTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Right 2007</div>
			
          <input type='hidden' id='txtDELID' value='' />
          <input type='hidden' id='txtToken' value='' />
          <input type ="hidden" id='txtDELTotalWork' value='' />          
          
		<form id="frmWBS_GanttChartView" method="post" >
   
			<%PageInit()%>
			
    </form>
    
<script language="javascript">
   
   // if(document.getElementById('fillDiv'))
     //   document.getElementById('fillDiv').style.display="block";
 
 
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
    var objfrm=GetFormReference('frmWBS_GanttChartView');
    var objdivlist=GetObjectReference('frmWBS_GanttChartView','divList');
     
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
	var HolidayOkConfirm = false;
	
	var clsRName="clsGanttChart";
	var clsWName="clsTDBlank";
	var objhldAlert=GetObjectReference('frmWBS_GanttChartView','hldAlert');
	var objlblMsg=GetObjectReference('frmWBS_GanttChartView','lblMsg');
	var strMsgg="";
	var objtxtDELID=GetObjectReference('','txtDELID');
    var objtxtToken=GetObjectReference('','txtToken');
	var objtaskTotal=GetObjectReference('','taskTotal');
	
	
	
	if(GetObjectReference('frmWBS_GanttChartView','txtNoOfPages'))
		{	
			var noOfPages = GetObjectReference('frmWBS_GanttChartView','txtNoOfPages').value;
			var objtxtpageNumber =  GetObjectReference('frmWBS_GanttChartView','txtPageNumber');
		}
		
    function window_onLoad()
    {
  
   

    if(objtaskTotal!=null)
        objtaskTotal.innerHTML=parseInt("<%=m_intRowCount %>")-parseInt("<%=m_intDeliverableCount %>");
        
      
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
			objdivlist.style.height = intDivHeight +'px';
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

var objdivAR=GetObjectReference('frmWBS_GanttChartView','divAR');
var objdivATT=GetObjectReference('frmWBS_GanttChartView','divATT');
var objdivAP=GetObjectReference('frmWBS_GanttChartView','divAP');
var objdivView=GetObjectReference('frmWBS_GanttChartView','divView');

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
        
    if(objdivMNPopup!=null)
        objdivMNPopup.style.display='none';
        
}
function clickDocUp(evt)
{
	//Added By VijayD On 25 August 2009
	//Validation While saving the Data    
	// debugger;
    if (curMoveVert!=null)
    {
         
        var arrTargetInfo = curMoveVert.getAttribute("Target").split("|");
        var oTargetDT = document.getElementById(curMoveVert.getAttribute("Target"));
        var TaskID=arrTargetInfo[0]; 
        dtCurrentDate=oTargetDT.getAttribute("Date");
        var dtHolidayDate=dtCurrentDate; 
        dtCurrentDate=GetFormat(dtCurrentDate,'dd-mmm-yyyy','MM/DD/YYYY');
        objstartDate = GetObjectReference(' frmWBS_GanttChartView','L|' + TaskID); 
        objEndDate = GetObjectReference(' frmWBS_GanttChartView','R|' + TaskID); 
        var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);

        var IsDeliverable="False";
        var objDeliverable=GetObjectReference('','txtIsDeliverable'+TaskID)
        if(objDeliverable!=null)
            IsDeliverable=String(objDeliverable.value);
        else
             IsDeliverable="False";
                     
        if("<%=m_strTagID%>"=="1038" && IsDeliverable=="False") //If the Validation is for the Tasks Within the Deliverables.
 		{	
          /*  if(!ValidateControl_All1(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID,"clickDocUp"))
                {    	                
	               //objCurrentWork.focus();
	                DT.style.display='none';
	                curMoveVert = null;
	                document.body.style.cursor = "Default"; 
	                curMoveVert = null;
	                document.body.onmousemove = function(){};  	                         
                    return false;  
                }*/
           if(!Check_Task_DailyActivity(dtHolidayDate,objstartDate.value,objEndDate.value,TaskID,"clickDocUp")) 
                {    
                    DT.style.display='none';
                    curMoveVert = null;
                    document.body.style.cursor = "Default";
                    document.body.onmousemove = function(){}; 	            
                    return false;
                }   
           if   (!Holiday(dtHolidayDate,objstartDate.value,objEndDate.value,TaskID,evt)) 
                { 
                    DT.style.display='none';
                    curMoveVert = null;
                    document.body.style.cursor = "Default";
                    document.body.onmousemove = function(){};             
                    return false; 
                }                 
        }        
        else        //Validation for the Deliverables.
        {
            
            strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=WBSBaseLineValidation&ID="+arrTargetInfo[0]+"&Type=DELI&FromWhere=DeliDates";
            ValidateTask_Baseline(strUrl);
            
            if(strResult!=null && strResult!="")
            {
              alert(strResult);
                DT.style.display='none';
                curMoveVert = null;
                document.body.style.cursor = "Default";
                document.body.onmousemove = function(){};                 
              return false;		    
            }  
        }        

         
    }  
      //End Addition By VijayD On 25 August 2009
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
	var ResourceStartDate;
	var ResourceEndDate;
	var objTaskTDID;
	var EmployeeID;
		if (isLorR == "L" )
		 fillColor = "white"; 
		else
		fillColor = evt ? "blue" : "white";
		
		//if moving does right hand
		 
		var arrTargetInfo = curMoveVert.getAttribute("Target").split("|");
		
		for(i=arrTargetInfo[2];i<=32;i++)
		{
			dtTD = document.getElementById(arrTargetInfo[0]+"|"+(parseInt(arrTargetInfo[1])+monInr)+"|"+i)
			//Added by ShraddhaM on 26,May 2009 for Resoucedate validation against Task Dates
			objTaskTDID = GetObjectReference('frmWBS_GanttChartView','Task' + arrTargetInfo[0]);
			if(objTaskTDID)
			{
			    ResourceStartDate = objTaskTDID.getAttribute("ResourceStartDate");
			    ResourceEndDate = objTaskTDID.getAttribute("ResourceEndDate");
			    EmployeeID = objTaskTDID.getAttribute("EmployeeID");
			    //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
			    if("<%=m_intFlag%>"=="1" && objTaskTDID != null)
			    {
			        UserStoryEndDate = objTaskTDID.getAttribute("UserStoryEndDate");
			    }
			    //End of Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)

			}			
			//Ended by ShraddhaM
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
				
				//if(!ValidateEndDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0])) {isCrossRightBoundary=true;break; }
				if(!ValidateEndDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceEndDate,EmployeeID,evt)) {isCrossRightBoundary=true;break; }
				}
            //End of addition by PrashantSJ on 16th March 2009									 
			if(dtTD)
			{
				
				var dtTDx = getPosition(dtTD).x;
				if (evt)
				{
					if((evt.clientX >= parseInt(dtTDx)) ) 
					{ 
					dtTD.bgColor = fillColor;
					/*if(fillColor=="red")
					    dtTD.className=clsRName;
					 else   
					    dtTD.className=clsWName;*/
					    
					 lastdtTD = dtTD;  }
					else break;
				}
				else
					dtTD.bgColor = fillColor;
				/*{	if(fillColor=="red")
					    dtTD.className=clsRName;
					 else   
					    dtTD.className=clsWName;
				}*/	    
			}
			else
			break;
			
			 
			
		}
		if(lastdtTD)
		{ 
			if(fillColor == "white")
				lastdtTD.bgColor = "blue";
				// lastdtTD.className="clsRName";
				 
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
    var EmployeeID;
    var ResourceStartDate;
    
	if (isLorR == "L")
				fillColor = "blue";
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
				
			//Added by ShraddhaM on 26,May 2009 for Resoucedate validation against Task Dates
			objTaskTDID = GetObjectReference('frmWBS_GanttChartView','Task' + arrTargetInfo[0]);
			if(objTaskTDID)
			{
			    ResourceStartDate = objTaskTDID.getAttribute("ResourceStartDate");
			    EmployeeID = objTaskTDID.getAttribute("EmployeeID");
			}
			
			//Ended by ShraddhaM
				
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
			
				 if(GantViewStartMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewStartDay == i && "<%=m_strGanttView%>"!=5 &&  "<%=m_strGanttView%>"!=6)
					{ isCrossLeftBoundary=true; //break;
					 }
				
				//Added By PrashantSJ on 16th March 2009
				if(dtTD!=null)
				{
				//if(!ValidateDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0] )) {isCrossLeftBoundary=true; break;}
				if(!ValidateDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceStartDate,EmployeeID,evt )) {isCrossLeftBoundary=true; break;}
				}
				//End of addition by PrashantSJ 16th March 2009
					
				if(dtTD)
				{
					
					var dtTDx = getPosition(dtTD).x;
					if(evt.clientX < (parseInt(dtTDx)+ DT_TD_width)) // && evt.clientX <= (parseInt(dtTDx)+ dtTD.offsetWidth)  )
					{ 
					    dtTD.bgColor = fillColor; 
					    /*if(fillColor=="red")
					    dtTD.className=clsRName;
					    else   
					    dtTD.className=clsWName;*/
					
					lastdtTD = dtTD;  
					
					}
					else break;
					
					
				}
				else
				break;
				
			}
			if(lastdtTD)
			{ 
				if(fillColor == "white")
				lastdtTD.bgColor = "blue";
				//lastdtTD.className="clsRName";
				    curMoveVert.setAttribute("Target",lastdtTD.id); setPosVert(curMoveVert,lastdtTD); 
				
			}
			
			if(isCrossLeftBoundary)
			clickDocUp(null);
			
}
function ValidateDates(dtCurrentDate,TaskID,ResourceStartDate,EmployeeID,evt)
 {
        dtProjectStartDate = "<%=m_strProjectStartDate%>" ;
        var dtHolidayCurrentDate = dtCurrentDate ;
        dtProjectStartDate  = GetFormat(dtProjectStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
        dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
         var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID); 
        var IsDeliverable="False";
        var objDeliverable=GetObjectReference('','txtIsDeliverable'+TaskID)
         
         if(objDeliverable!=null)
            IsDeliverable=String(objDeliverable.value);
          else
             IsDeliverable="False";
       
       
       if(ResourceStartDate)               
        ResourceStartDate = GetFormat(ResourceStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
        
                 
        if((dtProjectStartDate != null)  && (dtCurrentDate != null))
        {
           //if(dtCurrentDate < dtProjectStartDate)
            if(DateDiff(dtCurrentDate,dtProjectStartDate,'d')>0)
            {
                strMsg="Start date should be greater than project start date (<%=m_strProjectStartDate%>).";
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
        }
        if(IsCaseOneProject=="False" && objhidParentTaskID!=null && IsDeliverable=="False" )
	     {
	          var objhidParentTaskID=GetObjectReference('frmWBS_GanttChartView','hidParentTaskID'+TaskID);  
              var objParentTaskStartDate=GetObjectReference('frmWBS_GanttChartView','hidParentStartDate'+objhidParentTaskID.value);
           
            dtParentStartDate  = GetFormat(objParentTaskStartDate.value ,'dd-mmm-yyyy','MM/DD/YYYY');
            
             if(dtCurrentDate < dtParentStartDate)
            {
                strMsg='Task start date should be greater than parent task start date ('+objParentTaskStartDate.value+').';
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
              
         }      
          //Added by ShraddhaM on 26,May 2009 for Resoucedate validation against Task Dates and holiday-leave alerts
          var ResourceValidation = GetObjectReference('frmWBS_GanttChartView','hidResourceValidation'); 
          if(ResourceValidation)
           if(ResourceValidation.value == "True" && IsDeliverable=="False")
           {
                 if(ResourceStartDate != '')
                 if(DateDiff(dtCurrentDate,ResourceStartDate,'d')>0)
			        {	
				        strMsg="Start date should be greater than equal to Resource start date ("+ResourceStartDate+").";
				        //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
				        alert(strMsg);			
				        return false;
			        }
		   }
						        
		//Ended by ShraddhaM
		
    /************************ Added By VijayD 15 Jun 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
     
            //Remove Comment By VijayD On 15 Jun 2009
        if("<%=m_strTagID%>"=="1038" && IsDeliverable=="False")
 		   {
        	//if(!Holiday(dtHolidayCurrentDate,evt)) { return false;}//Commented By VijayD On 15 Jun 2009
			// var strResult='';
		  /*	
			if(EmployeeID!="" && EmployeeID!="-")
			{
			     strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId="+TaskID+"&PROJECT_SETTINGS=<%=m_strProjectSetting%>&FromDate=" + encodeURIComponent(dtHolidayCurrentDate) + "&ToDate=" + encodeURIComponent(dtHolidayCurrentDate)+ "&EmployeeIDs=" + EmployeeID ;
			    //if (strResult == "")
		        loadXMLDoc(strUrl,'');
    		    
		        if(strMsgg!="")
		        {
		          objlblMsg.innerHTML=strMsgg;
		          objhldAlert.style.width='250';
                  showmenuie(objhldAlert,evt);
                  strMsgg="";
                  return true;
                }  
                
           } */   
		    //End Comment By VijayD On 15 Jun 2009
 		     
 	        //Added By VijayD On 25 August 2009
	        //Validation While saving the Data    
            objstartDate = GetObjectReference(' frmWBS_GanttChartView','L|' + TaskID); 
            objEndDate = GetObjectReference(' frmWBS_GanttChartView','R|' + TaskID); 
            var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);		    
		    if(!ValidateControl_All(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID))
		    {
		     return false;		    
		    }	
		    	   
           	//End Addition By VijayD On 25 August 2009
                                
             }   
	    //************************End Addition By VijayD 15 Jun 2009**************************//                    
	return true;
}
    
    function ValidateEndDates(dtCurrentDate,TaskID,ResourceEndDate,EmployeeID,evt)
    {
      
        dtProjectEndDate = "<%=m_strProjectEndDate%>" ;
        var dtHolidayCurrentDate = dtCurrentDate ;
         var IsDeliverable="False";
         var objDeliverable=GetObjectReference('','txtIsDeliverable'+TaskID)
          var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID);  
         if(objDeliverable!=null)
            IsDeliverable=String(objDeliverable.value);
          else
             IsDeliverable="False";     
        
        dtProjectEndDate  = GetFormat(dtProjectEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
        dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');     
        
                 
        if(ResourceEndDate)      
        ResourceEndDate = GetFormat(ResourceEndDate ,'dd-mmm-yyyy','MM/DD/YYYY'); 
           
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
	    if(IsCaseOneProject=="False" && objhidParentTaskID!=null && IsDeliverable=="False")
	     {
	          var objhidParentTaskID=GetObjectReference('frmWBS_GanttChartView','hidParentTaskID'+TaskID);  
              var objParentTaskEndDate=GetObjectReference('frmWBS_GanttChartView','hidParentEndDate'+objhidParentTaskID.value);
             dtParentEndDate  = GetFormat(objParentTaskEndDate.value ,'dd-mmm-yyyy','MM/DD/YYYY');
             //if(dtCurrentDate < getDate(objParentTaskEndDate.value))
             if(DateDiff(dtParentEndDate,dtCurrentDate,'d')>0)
            {
                strMsg='Task end date should be less than parent task end date ('+objParentTaskEndDate.value+').';
			    //strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
				alert(strMsg);			
				return false;  
            }
              
         }   
          //Added by ShraddhaM on 26,May 2009 for Resoucedate validation against Task Dates and holiday-leave alerts
           var ResourceValidation = GetObjectReference('frmWBS_GanttChartView','hidResourceValidation'); 
           if(ResourceValidation)
           if(ResourceValidation.value == "True" && IsDeliverable=="False")
            {
                 if(ResourceEndDate != '')     
                 if(DateDiff(ResourceEndDate,dtCurrentDate,'d')>0)
			        {	
				        strMsg="End date should be less than equal to Resource end date ("+ResourceEndDate+").";
				        //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
				        alert(strMsg);			
				        return false;
			        }
			}

		//Ended by ShraddhaM
		
    /************************ Added By VijayD 15 Jun 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
            //Remove Comment By VijayD On 15 Jun 2009
         if("<%=m_strTagID%>"=="1038" && IsDeliverable=="False")
 		 {
			//if(!Holiday(dtHolidayCurrentDate,evt)) {  return false;}  //Commented By VijayD On 15 Jun 2009
			// var strResult='';
		/*	
			if(EmployeeID!="" && EmployeeID!="-")
			{
			    strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId="+TaskID+"&PROJECT_SETTINGS=<%=m_strProjectSetting%>&FromDate=" + encodeURIComponent(dtHolidayCurrentDate) + "&ToDate=" + encodeURIComponent(dtHolidayCurrentDate)+ "&EmployeeIDs=" + EmployeeID ;
			    //if (strResult == "")
		        loadXMLDoc(strUrl,'');
    		    
		        if(strMsgg!="")
		        {
		          objlblMsg.innerHTML=strMsgg;
		          objhldAlert.style.width='250';
                  showmenuie(objhldAlert,evt);
                   strMsgg="";
                  return true;
                }
            }  */ 
		    //End Comment By VijayD On 15 Jun 2009
		    
 		    
 	            //Added By VijayD On 25 August 2009
	            //Validation While saving the Data    
                objstartDate = GetObjectReference(' frmWBS_GanttChartView','L|' + TaskID); 
                objEndDate = GetObjectReference(' frmWBS_GanttChartView','R|' + TaskID); 
                var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);		    
		        if(!ValidateControl_All(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID))
		        {
		         return false;		    
		        }	
    		    	   
           	    //End Addition By VijayD On 25 August 2009                
             }                    
	    //************************End Addition By VijayD 15 Jun 2009**************************//                    
	return true;
}
//Added by ShraddhaM on 26,May 2009 for Holiday validation
//Added by ShraddhaM on 26,May 2009 for Holiday validation
function Holiday(dtCurrentDate,StartDate,EndDate,TaskID,evt)
{ 
    var strHolidays = "<%=m_strHolidays%>";  
       intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
		intCompanyWeekDays = <%=m_lngWeekDays%>;
        if(isLorR == "L")
        { StartDate=dtCurrentDate; }    
        else
        { EndDate=dtCurrentDate;}
        
		intHolidays=0;
		bitHoliday = false;
			
		if(strHolidays != "")
		{		
			strMsg="<%=MyBase.GetResourceString("THEDATES")%> ";
			strHolidayList = strHolidays.split(',');
			
					// If the holiday does not fall in the week end, then...
				for(intCount=0; intCount < strHolidayList.length-1 ; intCount++)
			    {
				//	if(DatePart("w", getDate(EndDate), 2) <= intCompanyWeekDays)		//Need to do
				//	{ 
						dtHoliday = getDate(strHolidayList[intCount]);	
						//Commented and Added By VijayD On 26 August 2009
						if(compareDates(StartDate,strHolidayList[intCount])<=0 && compareDates(EndDate,strHolidayList[intCount])>=0 )						
						//if((getDate(dtCurrentDate).getMonth() == dtHoliday.getMonth()) && (getDate(dtCurrentDate).getDate() == dtHoliday.getDate()) && (getDate(dtCurrentDate).getYear() == dtHoliday.getYear()))
						//End Addition and Comment  By VijayD On 26 August 2009
						{
							bitHoliday=true;
							strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
							strMsg = strMsg + "-" + getDate(dtCurrentDate).getYear() + "\n";
							intHolidays = intHolidays + 1;
						}
				//	}
			    }
		}
        var strURL;          
        if(isLorR == "L")
        { StartDate=dtCurrentDate;}    
        else
        { EndDate=dtCurrentDate;}
            
        strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=LeavesValidation&TaskId="+TaskID+"&StartDate="+encodeURIComponent(StartDate)+"&EndDate="+encodeURIComponent(EndDate);
        ValidateTask_Baseline(strUrl);

		if(bitHoliday == true)			
		{
			strMsgg="<img src='../../images/info.gif' border=0></img><font color='red'>"+strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>"+"</font>";			
                    
			if(strResult!=null && strResult!="")
            {
                strMsgg = strMsgg +"<br/><font color='Green'>"+strResult +"</font>";                
            } 
            else
            {   
                strMsgg = strMsgg //+"</p>"
            }           
       }
       else
       {
            if(strResult!=null && strResult!="")
            {
                strMsgg = "<img src='../../images/info.gif' border=0></img><font color='Green'>"+strResult +"</font>";                
                bitHoliday = true;
            }            
       }      
       if(bitHoliday == true)	
       {
	        strA=strMsgg.replace(/Ok = Save the selected dates.\nCancel = Go back to the previous screen without saving./g,'');
	        objlblMsg.innerHTML=strA;
	        objhldAlert.style.width='330';
	        showmenuie(objhldAlert,evt);
	        strMsgg="";
	  }      
	        return true;						
}

function OkCancel_OnClick(flag)
{
    if(flag==1)
        objhldAlert.style.display='none';
}
//Ended by ShraddhaM
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
//disableSelection();
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

/*var intDivHeight ;
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
objdivlist.style.height = intDivHeight;


	
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
		
		
	} */
	window_onLoad(); 
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
					/*{ if(fillColor=="red")
					    dtTD.className=clsRName;
					 else   
					    dtTD.className=clsWName;
					}*/
				}
				else
				break;
			}
			document.getElementById(vertR.getAttribute("Target")).bgColor = "blue";
			//document.getElementById(vertR.getAttribute("Target")).clsRName = clsRName;
			
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
					/*{if(fillColor=="red")
					    dtTD.className=clsRName;
					 else   
					    dtTD.className=clsWName;
					}*/
				}
				else
				break;
			}
			document.getElementById(vertL.getAttribute("Target")).bgColor = "blue";
			//document.getElementById(vertL.getAttribute("Target")).className=clsRName;
		}
	
	
}
function showToolTip(src,evt)
{
if(curMoveVert)
return;

var r_tp_top,r_tp_left;
var l_tp_top,l_tp_left;
var r_tp_text,t_tp_text;
//Added by Dhanashri S on 17 June 2015
var l_tp_text;
//End of Addition by Dhanashri S on 17 June 2015
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
    //Commented and Added By Bharat T on 26th-Nov-2015
    //vertOfrIndex = document.getElementById('VerR'+rIndex);
    vertOfrIndex = document.getElementById('verR'+rIndex);
    //End of Commented and Added By Bharat T on 26th-Nov-2015
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

    //Commented and Added By Bharat T on 26th-Nov-2015
    //vertOfrIndex = document.getElementById('VerL'+rIndex);
    vertOfrIndex = document.getElementById('verL'+rIndex);
    //End of Commented and Added By Bharat T on 26th-Nov-2015
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

 

LToolTip.innerHTML = l_tp_text;
RToolTip.innerHTML = r_tp_text; 



if (l_tp_text!="")
LToolTip.style.display="";
LToolTip.style.left= l_tp_left; // parseInt(Ltarget.left) - 70;
//PrashantSJ
LToolTip.style.top= l_tp_top-15; //parseInt(Ltarget.top) - src.offsetHeight/3;

if (r_tp_text!="")
RToolTip.style.display="";


if ( (r_tp_left+RToolTip.offsetWidth+35) > document.body.offsetWidth )
{

r_tp_left = r_tp_left - L_TP_width; //assume L_TP_width is same for R ToolTip div
r_tp_top = r_tp_top + ((src.offsetHeight/3) * 2 );
}
 

RToolTip.style.left=r_tp_left; 
RToolTip.style.top=r_tp_top-15;


}

}
function hideToolTip(src,evt)
{
	LToolTip.style.display="none";
	RToolTip.style.display="none";
}
function FilterTasks()
{
    //Added by Tejal D date 12/10/2016 to set setFrameLoader
    setFrameLoader();
    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
    objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1&GanttChartType=<%=m_strGanttView%>";  
    objfrm.submit();
}
function NextOrPrevPeriod(Period)
{
    //Added by Tejal D date 12/10/2016 to set setFrameLoader
    setFrameLoader();
    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
    objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1&Period="+Period+"&GanttChartType=<%=m_strGanttView%>";   
    objfrm.submit();
}

//VijayD
    function ShowPage(Period)
    {          
        var objPageNumber = GetObjectReference('frmWBS_GanttChartView','txtPageNumber');
        if (objPageNumber){var PageNumber=objPageNumber.value;}
        
        if (Period=="FIRST")
        {
            PageNumber=1;
        }
        else if(Period=="PREV")
        {
            if (PageNumber==1)
            {
                alert("first Page!");
            }
            else
                PageNumber=parseInt(PageNumber)-1;
        }
        else if(Period=="NEXT")
        {
            if (PageNumber=="<%=Math.Ceiling(dblRatio).ToString%>")
            {
                alert("Last Page!");
            }
            else
                PageNumber=parseInt(PageNumber)+1;
        }
        else if (Period=="LAST")
        {
         PageNumber="<%=Math.Ceiling(dblRatio).ToString%>";
        }
        //Added by Tejal D date 12/10/2016 to set setFrameLoader
        setFrameLoader();
        //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
        objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber="+PageNumber+"&Period="+Period+"&GanttChartType=<%=m_strGanttView%>";   
        objfrm.submit();
    }
//VijaYD

function Save_OnClick()
{
        //Added By VijayD On 25 August 2009
	   //Validation While saving the Data 

        if("<%=m_strTagID%>"=="1038")
 		{
	        var objTotalAllocatedTaskLCE;
            var objOrgWork = GetObjectReference(' frmWBS_GanttChartView','txtOrgWork',true);
            var i,TaskID;
            var objstartDate ,objEndDate;

            for (i=0;i<objOrgWork.length;i++)
            { 
                TaskID=objOrgWork[i].name;
                TaskID=TaskID.replace('txtOrgWork','');
                       
                objstartDate = GetObjectReference(' frmWBS_GanttChartView','L|' + TaskID); 
                objEndDate = GetObjectReference(' frmWBS_GanttChartView','R|' + TaskID); 
            
                var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);	
		        var objTotalAllocatedTaskLCE = parseFloat(objOrgWork[i].value);	
		    
		        objCurrentWork.disabled=false; //To Enabled the Control Useful While Saving the Data
		        CWork = parseFloat(objCurrentWork.value);	     
				
				//Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
   		        var valhrUS = GetObjectReference('frmGanttChartView','hrUS');
                if("<%=m_intFlag%>"=="1" && valhrUS.value != "")
                {	     
				      if(!ValidateUSDates(objstartDate.value,objEndDate.value,CWork,TaskID))
                      {
                           return false;
                      }		
                }
                //Added by NitinC on 05 April 2012 For PMLifeLine(Issue Fix : 61089)

		        if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		        {
		            var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
			        alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
			        setFocus(objCurrentWork);
			        return ;
		        }
		        //Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
		        if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		        {
			        var dblBalancedHrs;
			        dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
			        strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
			        strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
			        strMsg = replaceSubstring(strMsg, "<==>", CWork.toFixed(2));
			        alert(strMsg);
			        return ;
		        }
		    }   
	     }	 
		 //End Addition By VijayD On 25 August 2009 
 
        if(!ValidateControls()) return;
       
    //Added by Tejal D date 12/10/2016 to set setFrameLoader
        setFrameLoader();
    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
        objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&Mode=Save&GanttChartType="+"<%=m_strGanttView %>";  
        objfrm.submit();
}
//Added By NitinC On 05 April 2012 For PMLifeLine(Issue Fix : 61089)
function ValidateUSDates(StartDate,EndDate,CurrentWork,TaskID)
{
    //Validation with user story startdate and end date 
    //debugger;
    
    var isValid =1;
    var strUrl="../PM/AjaxCallIteration.aspx?Flag=GraphicalView&StartDate=" + StartDate + "&EndDate=" + EndDate +"&ID="+ TaskID;
    if (document.all)  
    {   objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
        objXHttp.onreadystatechange = HandlerOnReadyState;
        objXHttp.open('GET',strUrl, false); 
        objXHttp.send();          
    }  
    else  {
    objXHttp = new XMLHttpRequest(); 
    objXHttp.onreadystatechange = HandlerOnReadyState(); 
    objXHttp.open('GET',strUrl, false);
    objXHttp.send(null);  
    }
    var strDateMsg='';
    var objXHttp;
    var blnFlag = false;        
    var strText = new String();
    var arrStr = new Array();   
    function HandlerOnReadyState()
    {
        if (objXHttp.readyState==4)
        {
            if (objXHttp.responseText != null) 
            {
                strText = objXHttp.responseText;  
                arrStr = strText.split(',');
                strTextisValid = arrStr[0];  //Is Valid StartDate and EndDate of task  
                strTextReleaseStartDate = arrStr[1];    //User Story Start Date 
                strTextReleaseEndDate = arrStr[2]; //User Story End Date
                strInitialEstimate = arrStr[3];  // User Story Initial Estimate 
                strTextUserStoryName = arrStr[4]; //User Story Name 
                strEffort = arrStr[5]; // Sum of efforts of all task entered till date for that user story 
                intSum =  parseInt(strEffort) + parseInt(CurrentWork) // Sum of current effort and calculated all efforts till date        
                if (strTextisValid == 0)           
                { 
                    isValid = 0;
                    alert('Start Date and End Date should be between User Story : "'+strTextUserStoryName+'" Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);
                    return false;
                }
                if (parseInt(intSum) > parseInt(strInitialEstimate))
                {
			        
                    var cnf = confirm('Your planned Estimate for User Story ['+strTextUserStoryName+'] is : '+strInitialEstimate+' hrs\nAnd till date you have estimated hours for tasks under this user story is : '+strEffort+' hrs\nNow you have entered '+CurrentWork+' hrs which will break your estimation. \nSystem will automatically increase your estimated hrs for user story.\nDo you want to save anyway?');
                    if (cnf == false){isValid = 0; return false;}
                    if (cnf == true){isValid = 1; return true;}
                }
            }
        }
    }
    if (isValid == 0)           
    { 
        return false;
    }
    else
    {
        return true;
    }    
}
//End of Added By NitinC On 05 April 2012 For PMLifeLine (Issue Fix : 61089)

//Added By NitinC On 05 April 2012 For PMLifeLine(Issue Fix : 61089)
function ValidateUserStory(StartDate,EndDate,CurrentWork,UserStoryID)
{
    
    try
    { 
        var strUrl="../PM/AjaxCallIteration.aspx?Flag=AssignedTask&UserStoryID=" + objhidTxtUSID.value;
        //objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
        if (document.all){
            objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        else{
            objXHttp = new XMLHttpRequest();
        }
        objXHttp.onreadystatechange = function()
        {
            if(objXHttp.readyState==4)
            {
                if(objXHttp.responseText != null)
                {
                    if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                        alert(objXHttp.responseText);
                    else
                        var data;
                        data =objXHttp.responseText;
                        var strUSDetails = data.split(',');
                        IsStoryComplete = strUSDetails[2];
                } 
             } 
         }
        objXHttp.open("GET",strUrl, false);
        objXHttp.send();
    } 
    catch(e){}
    if (IsStoryComplete=="True")
    {
        alert('You do not add task as selected user story has already completed. \nPlease re-open the user story!'); 
        return false;
    }
    //Validation with user story startdate and end date 
    //debugger;
    
    var isValid =1;
    var strUrl="../PM/AjaxCallIteration.aspx?Flag=UserStory&StartDate=" + StartDate + "&EndDate=" + EndDate +"&ID="+ UserStoryID;
    if (document.all)  
    {   objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
        objXHttp.onreadystatechange = HandlerOnReadyState;
        objXHttp.open('GET',strUrl, false); 
        objXHttp.send();          
    }  
    else  {
    objXHttp = new XMLHttpRequest(); 
    objXHttp.onreadystatechange = HandlerOnReadyState(); 
    objXHttp.open('GET',strUrl, false);
    objXHttp.send(null);  
    }
    var strDateMsg='';
    var objXHttp;
    var blnFlag = false;        
    var strText = new String();
    var arrStr = new Array();   
    function HandlerOnReadyState()
    {
        if (objXHttp.readyState==4)
        {
            if (objXHttp.responseText != null) 
            {
                strText = objXHttp.responseText;  
                arrStr = strText.split(',');
                strTextisValid = arrStr[0];  //Is Valid StartDate and EndDate of task  
                strTextReleaseStartDate = arrStr[1];    //User Story Start Date 
                strTextReleaseEndDate = arrStr[2]; //User Story End Date
                strInitialEstimate = arrStr[3];  // User Story Initial Estimate 
                strTextUserStoryName = arrStr[4]; //User Story Name 
                strEffort = arrStr[5]; // Sum of efforts of all task entered till date for that user story 
                intSum =  parseInt(strEffort) + parseInt(CurrentWork) // Sum of current effort and calculated all efforts till date        
                if (strTextisValid == 0)           
                { 
                    isValid = 0;
                    alert('Start Date and End Date should be between User Story : "'+strTextUserStoryName+'" Dates i.e. '+ strTextReleaseStartDate + ' and ' + strTextReleaseEndDate);
                    return false;
                }
                if (parseInt(intSum) > parseInt(strInitialEstimate))
                {
			        
                    var cnf = confirm('Your planned Estimate for User Story ['+strTextUserStoryName+'] is : '+strInitialEstimate+' hrs\nAnd till date you have estimated hours for tasks under this user story is : '+strEffort+' hrs\nNow you have entered '+CurrentWork+' hrs which will break your estimation. \nSystem will automatically increase your estimated hrs for user story.\nDo you want to save anyway?');
                    if (cnf == false){isValid = 0; return false;}
                    if (cnf == true){isValid = 1; return true;}
                }
            }
        }
    }
    if (isValid == 0)           
    { 
        return false;
    }
    else
    {
        return true;
    }
    
    
   
}
//End of Added By NitinC On 05 April 2012 For PMLifeLine (Issue Fix : 61089)
function ValidateControls()
{
    var objchkSelect=GetObjectReference('frmWBS_GanttChartView','chkSelect',true); 
    var ResourceValidation = GetObjectReference('frmWBS_GanttChartView','hidResourceValidation'); 
    var ResourceStartDate;
    var ResourceEndDate;                  
 
     //Added By VijayD To Validate the Pagging Number   On 25 August 2009           
    var objtxtpageNumber =  GetObjectReference('frmWBS_GanttChartView','txtPageNumber');
    var objtxtNoOfPages = GetObjectReference('frmWBS_GanttChartView','txtNoOfPages');
    if(objtxtpageNumber!=null)
    {
        if (!disallowBlank(objtxtpageNumber,"Please enter page number !",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true)) & (!disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true)))				
        {	        
	        if (Number(objtxtpageNumber.value) ==0)
	        {
		        alert("Page number should be greater than zero!");
		        return false;
	        }
	        if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
	        {
    		    alert("Invalid Page Number !");
		        return false;
	        }
	        objtxtpageNumber.focus();
       }	
       else
       {
          return false;
       }
   }         
    //End Addition By VijayD 
    
    if(objchkSelect!=null)
    {
        for(var i=0;i<objchkSelect.length;i++)
        {
            if(objchkSelect[i].checked==true)
            {
                  objHidtxtARID=GetObjectReference('frmWBS_GanttChartView','hidTxtARID'); 
                  objHidtxtATTID=GetObjectReference('frmWBS_GanttChartView','hidTxtTTID'); 
                  objHidtxtAPR=GetObjectReference('frmWBS_GanttChartView','hidTxtAPR'); 
                  var objhidTxtASTA=GetObjectReference('frmWBS_GanttChartView','hidTxtASTA'); 
                  
             
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
                   //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
                  if("<%=m_intFlag%>"=="1")
                  {
                      objhidTxtUSID=GetObjectReference('frmGanttChartView','hidTxtUSID');
                      if(objhidTxtUSID.value=='') 
                      {
                            alert('Please select User Story ');
                            return false;
                      }
                      var StartDate = GetObjectReference('frmGanttChartView','L|' + objchkSelect[i].value).value; 
                      var EndDate = GetObjectReference('frmGanttChartView','R|' + objchkSelect[i].value).value;
                      var CurrentWork = GetObjectReference('frmGanttChartView','txtWork' + objchkSelect[i].value).value;
                      var UserStoryID = objhidTxtUSID.value
                      var IsStoryComplete = "False"
                      if(UserStoryID != '')
                      {
                          if(!ValidateUserStory(StartDate,EndDate,CurrentWork,UserStoryID))
                          {
                               return false;
                          }
                      }
                  }
                  //End of added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089) 

                  if(ResourceValidation)
                  if(ResourceValidation.value == "True")
                  {
                          var objhr=GetObjectReference('frmWBS_GanttChartView','hrAR');  
                          
                          
                          if(objhr)
                          {
                            ResourceStartDate = objhr.getAttribute('ResourceStartDate');
                            ResourceEndDate = objhr.getAttribute('ResourceEndDate');
             
                            if(ResourceStartDate!=null)
                                ResourceStartDate = GetFormat(ResourceStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
                            else
                                ResourceStartDate='';
                                
                            if(ResourceEndDate!=null)    
                                ResourceEndDate = GetFormat(ResourceEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
                            else
                                ResourceEndDate='';
                                
                            /*ResourceStartDate = GetFormat(ResourceStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
                            ResourceEndDate = GetFormat(ResourceEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');    */
                          }  
                              objstartDate = GetObjectReference('frmWBS_GanttChartView','L|' + objchkSelect[i].value); 
                              objEndDate = GetObjectReference('frmWBS_GanttChartView','R|' + objchkSelect[i].value); 
                               
                              startDate = objstartDate.value;
                              EndDate = objEndDate.value;    
                             
                              startDate  = GetFormat(startDate ,'dd-mmm-yyyy','MM/DD/YYYY');
                              EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
                                                   
                     
                            if(ResourceStartDate != '')     
                            if(DateDiff(startDate,ResourceStartDate,'d')>0)
			                {	
				                strMsg="Start date should be greater than equal to Resource start date ("+ResourceStartDate+").";
				                //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
				                alert(strMsg);			
				                return;
			                }
                			         
                            if(ResourceEndDate != '')     
                            if(DateDiff(ResourceEndDate,EndDate,'d')>0)
			                {	
				                strMsg="End date should be less than equal to Resource end date ("+ResourceEndDate+").";
				                //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
				                alert(strMsg);			
				                return;
			                }
			    }
			
      
            }
        }
    }
    
    //Added by Shraddha M on 25,May 2009 for Approve,close and on-Hold project validation
    var IsProjectApproved = GetObjectReference('frmWBS_GanttChartView','hidIsProjectApproved'); 
    var IsProjectOnHold = GetObjectReference('frmWBS_GanttChartView','hidIsProjectOnHold'); 
    var IsProjectOver = GetObjectReference('frmWBS_GanttChartView','hidIsProjectOver'); 
       
   /*    if(IsProjectApproved)
       if(IsProjectApproved.value == "False")
       {
            alert('You cannot create a task since Project is not Approved.');
            return false;
       }
  */
 
        if("<%=m_strTagID%>"=="1038")
 		{    
	        if ("<%=m_blnIsProjectCreationWorkflowReqd%>"== "True")
	        {
                if ("<%=m_intBaselineNumber%>"== 0)
                {
	                alert("Project related activities such as adding Task entry cannot be performed as the Project is not Approved." );
                    return false;
                }
            }   
        }         
       if(IsProjectOnHold)
       if(IsProjectOnHold.value == "True")
       {
            alert('You cannot create/update a task since Project is On-Hold');
             return false;
       }
       if(IsProjectOver)
       if(IsProjectOver.value == "True")
       {
            alert('You cannot create/update a task since Project is Closed');
             return false;
       }
       
       
    //Ended by Shraddha M
    return true;
}
function txtWork_OnBlur(objCurrentWork,TaskID,ParentTaskID)
{
    objActualWork = GetObjectReference('frmWBS_GanttChartView','txtActualWork'+TaskID);
    objOrgWork = GetObjectReference('frmWBS_GanttChartView','txtOrgWork'+TaskID);
    
	if(disallowBlank(objCurrentWork, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))
			return ;
	if(disallowMinValueViolation(objCurrentWork, 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>",true))
			return ;

    //Modified by vidyak on 09 Sep 2010 for Display Planned Efforts related Alerts  on Restrict Duration/Work Change for Assigned tasks flag.
    //Added if(TaskRistValidation == "True")
    var TaskRistValidation = "<%=CommonFunctions.Application.RestrictDurationChange_O%>";
    if(TaskRistValidation == "True")
    {		
	        if(objActualWork!=null && objCurrentWork!=null)
	        {
	            if(parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
	            {
	                  alert('Planned Hours Should be greater than actual hours (' +objActualWork.value+')');
	                  setFocus(objCurrentWork);
	                  return ;
	            }
	        }
	}//End if(TaskRistValidation == "True")
	//Added by Shraddha M on 22,May 2009 for validate dates and hrs.
	
    objstartDate = GetObjectReference('frmWBS_GanttChartView','L|' + TaskID); 
    objEndDate = GetObjectReference('frmWBS_GanttChartView','R|' + TaskID); 
    //objWorkHrs = GetObjectReference('frmWBS_GanttChartView','txtWork'+ TaskID); 
    if(objCurrentWork)
    {
      
      startDate = objstartDate.value;
      EndDate = objEndDate.value;    
     
      startDate  = GetFormat(startDate ,'dd-mmm-yyyy','MM/DD/YYYY');
      EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
    
      CNTDateDiff = DateDiff(startDate,EndDate,"d") + 1;
      CNTDateDiff = parseFloat(CNTDateDiff);
     
      WorkHrs = parseFloat(objCurrentWork.value);
       
         if((WorkHrs/CNTDateDiff) > 24.0)
         {
            alert('Please check work hrs for a day.You can enter 24 hrs per day.');
            setFocus(objCurrentWork);
            return;
         }		
   
    	 
	    if(WorkHrs % <%=CommonFunctions.Application.MinHoursForDAEntry%> != 0.0)
	    {
	        alert('Please enter work hours multiple of <%=CommonFunctions.Application.MinHoursForDAEntry%>');
	        setFocus(objCurrentWork);
	        return ;
	    }
	}
	
	//Ended by Shraddha M
	
	    /////////////////////////////////////////////////////////////////////
	 
	 
	    var objTotalAllocatedTaskLCE;
		CWork = parseFloat(objCurrentWork.value)
		objTotalAllocatedTaskLCE = parseFloat(objOrgWork.value);		
						
		if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		{
		var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
			alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
			setFocus(objCurrentWork);
			return false;
		}
		//End Modification by SavitaS for TechUnified Issue ID-1257				
		// END : Integrated by ParagD On 14-Aug-2006 for PMLifeLine SP 7.2
		
		//Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
		if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		{
			var dblBalancedHrs;
			dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
			strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
			strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
			strMsg = replaceSubstring(strMsg, "<==>", CWork.toFixed(2));
			alert(strMsg);
			return false;
		}
		///////////////////////////////////////////////////////////////////
	if(IsCaseOneProject=="False")
	{
	    //var PlannedHours = GetObjectReference('frmWBS_GanttChartView','hidAllChildTaskWork' + ParentTaskID, true);
	    var PlannedHours = GetObjectReference('frmWBS_GanttChartView','hidAllChildTaskWork' + ParentTaskID);
	    var objParentTask= GetObjectReference('frmWBS_GanttChartView','hidParentTaskWork'+ParentTaskID);
	    var objhidChildTaskWork=GetObjectReference('frmWBS_GanttChartView','hidChildTaskWork'+TaskID);
	     var objhidParentTaskActualWork=GetObjectReference('frmGanttChartView','hidParentTaskActualWork'+ParentTaskID);
	     
	    if(PlannedHours!=null)
	    {
	    var intCnt, ChildPlanned=0, TotalChildplanned=0;
		/*for (intCnt=0; intCnt < PlannedHours.length; intCnt++)
		{
			ChildPlanned = parseFloat(PlannedHours[intCnt].value);
			TotalChildplanned = TotalChildplanned + ChildPlanned;
		}*/
		  TotalChildplanned=PlannedHours.value;
		
		    if(objhidChildTaskWork)
		    {
		        TotalChildplanned=TotalChildplanned-parseFloat(objhidChildTaskWork.value);
		    }
		
	    	TotalChildplanned=TotalChildplanned+parseFloat(objCurrentWork.value);
		} 
		
		if(objParentTask!=null)
		{	
		    if(parseFloat(objParentTask.value) < TotalChildplanned+ parseFloat(objhidParentTaskActualWork.value))
		    {
		        alert('Planned Hours should not be greater than the Parent Planned Hours (' +objParentTask.value + ').');
		        setFocus(objCurrentWork);
		        return;
		    }	
		        
		}    
	}	
		
}
function Views_OnChange()
{
     objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
     objfrm.submit();
} 
function Page_Onclick(PageNumber)
{
	// Modified by SandipL on 3 Feb 2006 
  strLocation = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=" + String(parseInt(PageNumber))+"&GanttChartType=<%=m_strGanttView%>";


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
     strLocation = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1&GanttChartType=<%=m_strGanttView%>";

	objfrm.action = strLocation
	objfrm.submit(); 
    }
}    
function GanttView_OnChange()
{
     strLocation = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome";

	objfrm.action = strLocation
	objfrm.submit(); 

}
function CreateRowForTasks(DeliverableID)
{
		    //debugger;
		    var objTotalAllocatedTaskLCE;
		    var CWork = parseFloat(<%=m_dblOUWorkingHrs%>);
	        var objTotalAllocatedTaskLCE = parseFloat(<%=m_dblProjectTaskTotal%>);		
						
		    if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		    {
		        var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
			    alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
			    return;
		    }
		    
		    //Added By VijayD On 29 August 2009
		    ///To Validate For The Task-Deliverable BaseLine
        if(isNumeric(DeliverableID)==true)
	    {	    
           /* strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=WBSBaseLineValidation&ID="+DeliverableID+"&Type=DELI&FromWhere=AddTasks";
            ValidateTask_Baseline(strUrl);

            if(strResult!=null && strResult!="")
            {
              alert(strResult);
              return;		    
            }*/  
            //End Addition By VijayD On 29 August 2009		
			//noOfRows = noOfRows + 1;
			var objTbl = GetObjectReference('frmWBS_GanttChartView','tblGanttTask');
			var objItemCount = GetObjectReference('frmWBS_GanttChartView','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmWBS_GanttChartView','txtPreItemCount');
			var objTRAdd=GetObjectReference('frmWBS_GanttChartView','TRAdd_'+DeliverableID);
			
			//alert(objTRAdd.rowIndex);
			
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


			//NewTR = objTbl.insertRow(parseInt(intItemCount+1));
			NewTR = objTbl.insertRow(parseInt(objTRAdd.rowIndex));

			NewTR.className = 'clsTRBlank';
			NewTD = NewTR.insertCell(0);
			NewTD.align='center';
            //commented and added by nilesg g on 21/2/2016 for image issue
            //strHTML= "<td class='clsTDBlank' width='2%'><IMG BORDER=0 src='../../../responsive/images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
			strHTML= "<td class='clsTDBlank' width='2%'><IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
            //end of commented and added by nilesg g on 21/2/2016
			NewTD.innerHTML= strHTML+"</td>";
						
				
			NewTD = NewTR.insertCell(1);
			NewTD.align='left';
			//Commented and added by bharat tekade on 1st-aug-2014 purpose:pmlifeline_sp2 upgrade issue
		    //NewTD.innerHTML = "<td class='clsTDBlank' width='28%' ><Input type=textbox name=txtTaskName_"+String(intPreItemCount)+" id=txtTaskName_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:200px;text-align:Left' maxlength=255' onblur='txtTask_onBlur(this)' onkeyup='txtTask_OnKeyup(this,event)' /><Input type=hidden name=txtDELID_"+String(intPreItemCount)+" id=txtDELID__"+String(intPreItemCount)+" value='"+String(DeliverableID)+"' /></td>";	

		    NewTD.innerHTML = "<td class='clsTDBlank' width='28%' ><Input type=textbox name=txtTaskName_"+String(intPreItemCount)+" id=txtTaskName_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:200px;text-align:Left' maxlength=255' onkeyup='txtTask_OnKeyup(this,event)' /><Input type=hidden name=txtDELID_"+String(intPreItemCount)+" id=txtDELID__"+String(intPreItemCount)+" value='"+String(DeliverableID)+"' /></td>";	

		    //ended by bharat tekade
			    
			for(i=2;i<=15;i++)
			{
			    if(i >6 && "<%=m_strGanttView %>"=="1" )
			        break;
			    
			    if(i >10 && "<%=m_strGanttView %>"=="5" )
			        break;
			            
			    NewTD = NewTR.insertCell(i);
			    NewTD.align='center';	
			    NewTD.innerHTML = "<td class='clsTDBlank'></td>"
			    		
            }           
			
			setSectionRowCount(1,intPreItemCount);
			var objtxt=GetObjectReference('','txtTaskName_'+String(intPreItemCount));
			setFocus(objtxt);
		}	
}
		function setSectionRowCount(flag,noOfRows)
		{
			var objtxtItems=GetObjectReference('frmWBS_GanttChartView','txtItems');
			var objItemCount = GetObjectReference('frmWBS_GanttChartView','txtItemCount');
			var objtxtPreItemCount=GetObjectReference('frmWBS_GanttChartView','txtPreItemCount');
			
			
			
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
	
			var objTbl = GetObjectReference('frmWBS_GanttChartView','tblGanttTask');
			var objtxtItemCount=GetObjectReference('frmWBS_GanttChartView','txtItemCount');
			var rowNo=objImg.parentElement.parentElement.rowIndex
			
			objTbl.deleteRow(rowNo);
			setSectionRowCount(0,rowID);
		}
		function optTaskType_OnClick()
		{
        strLocation = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1";

	    objfrm.action = strLocation
	    objfrm.submit(); 
		}
		
		
		    
		function AHref_OnClick(HrefID,e)
		{
		
		var objdiv,objhr;
	
		 if(HrefID=="hrAR")
		 {
		    objdiv=GetObjectReference('frmWBS_GanttChartView','divAR');
		    objhr=GetObjectReference('frmWBS_GanttChartView','hrAR');    
		 }
		 //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
		 if("<%=m_intFlag%>"=="1" && HrefID=="hrUS")
         {
 		     
	        objdiv=GetObjectReference('frmGanttChartView','divUS');
	        objhr=GetObjectReference('frmGanttChartView','hrUS');    
		     
		 }
		 //End of added by NitinC on 05 April 2012 For PMLifeLine(Issue Fix : 61089)
 
		 else if (HrefID=="hrATT")
		 {
		     objdiv=GetObjectReference('frmWBS_GanttChartView','divATT');
		     objhr=GetObjectReference('frmWBS_GanttChartView','hrATT'); 
		 }
		 else if(HrefID=="hrAP")
		 {
		     objdiv=GetObjectReference('frmWBS_GanttChartView','divAP');
		     objhr=GetObjectReference('frmWBS_GanttChartView','hrAP'); 
		 }
		 else if(HrefID=="hrView")
		 {
		      objdiv=GetObjectReference('frmWBS_GanttChartView','divView');
		       objhr=GetObjectReference('frmWBS_GanttChartView','hrView'); 
		  }
		  else if(HrefID=="hrASTA")
		 {
		      objdiv=GetObjectReference('frmWBS_GanttChartView','divSTA');
		       objhr=GetObjectReference('frmWBS_GanttChartView','hrASTA');
		       objhratt=GetObjectReference('frmWBS_GanttChartView','hrATT');  
		       
		       if(objhratt!=null)
		        {
		          if(objhratt.value=='')
		            return; 
		        }
		  }
		    
		    if(objdiv!=null)
		    {
		        showmenuie(objdiv,e);
		
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
      //Commented and Added by Dhanashri S on 17 June 2015
      //  e.stopPropagation();
      objevent.stopPropagation();
    //End of Addition by Dhanashri S on 17 June 2015
   
  
  return false;
  
   }
		function Attribute_OnClick(sID,sText,HrefID,ResourceStartDate,ResourceEndDate)
		{
		    var objdiv,objhr,objHidtxtAtt;
		
		     if(HrefID=="hrAR")
		     {
		        objdiv=GetObjectReference('frmWBS_GanttChartView','divAR');
		        objhr=GetObjectReference('frmWBS_GanttChartView','hrAR');  
		        objHidtxtAtt=GetObjectReference('frmWBS_GanttChartView','hidTxtARID');  
		      
		      
		      	if(objhr)
		      	{	      
		            objhr.setAttribute('ResourceStartDate',ResourceStartDate);
		            objhr.setAttribute('ResourceEndDate',ResourceEndDate);
		        }
		        
		     }
		     //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
		     if("<%=m_intFlag%>"=="1" && HrefID=="hrUS")
             {
		        
	             objdiv=GetObjectReference('frmGanttChartView','divUS');
	             objhr=GetObjectReference('frmGanttChartView','hrUS'); 
	             objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtUSID'); 
		        
		     }
		     //End of added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089) 
 
		     else if (HrefID=="hrATT")
		     {
		         objdiv=GetObjectReference('frmWBS_GanttChartView','divATT');
		         objhr=GetObjectReference('frmWBS_GanttChartView','hrATT'); 
		         objHidtxtAtt=GetObjectReference('frmWBS_GanttChartView','hidTxtTTID'); 
		          
		        
		         
		     }
		     else if (HrefID=="hrAP")
		     {
		         objdiv=GetObjectReference('frmWBS_GanttChartView','divAP');
		         objhr=GetObjectReference('frmWBS_GanttChartView','hrAP'); 
		         objHidtxtAtt=GetObjectReference('frmWBS_GanttChartView','hidTxtAPR');
		        
		     }
		    else if (HrefID=="hrView")
		     {
		         objdiv=GetObjectReference('frmWBS_GanttChartView','divView');
		         objhr=GetObjectReference('frmWBS_GanttChartView','hrView'); 
		         objHidtxtAtt=GetObjectReference('frmWBS_GanttChartView','cboViews');
		        
		     }
		     else if (HrefID=="hrASTA")
		     {
		         objdiv=GetObjectReference('frmWBS_GanttChartView','divSTA');
		         objhr=GetObjectReference('frmWBS_GanttChartView','hrASTA'); 
		         objHidtxtAtt=GetObjectReference('frmWBS_GanttChartView','hidTxtASTA');
		        
		     }
		    //objhr.innerHTML=sText;
		    objhr.value=sText;
		    objdiv.style.display='none';
		    
			 if (HrefID=="hrATT" && IsCase3Project=="True")
		     {
		        var objhr1=GetObjectReference('frmWBS_GanttChartView','hrASTA'); 
		        if(objhr1!=null) 
		            objhr1.value='';
		        loadXMLDoc("../Home/AJAXHttp.aspx?MasterTagID=1038","TaskTypeID="+sID,"ASS");
		         
		     }
			
			
		   if(objHidtxtAtt!=null)
		            objHidtxtAtt.value=sID;
		            
		   if (HrefID=="hrView") 
		   {
		       objhr.title=sText;
		       objfrm.action="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&PageNumber=1&GanttChartType=<%=m_strGanttView%>";  
               objfrm.submit();
		   }         
		     
		    
		}
		function SelectOnClick(objSelect)
		{
		    if(objSelect!=null)
		    {
		        var objtxtWork=GetObjectReference('frmWBS_GanttChartView','txtWork'+objSelect.value);  
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
		        if(objSelect.checked)
		           {
		           if(objtrAssig.style.display!='')
		           {
		            objtrAssig.style.display='';
                    objimgAssig.src='../../images/minus.gif';
                    }
                    //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
                    if("<%=m_intFlag%>"=="1" && objtrUSAssig.style.display!='')
                    {
                        objtrUSAssig.style.display='';
                        objimgAssig.src='../../images/minus.gif';
                    }
                   //End of added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)

                    window_onLoad(); 
		           }
		    } 
		}
		
		function ShowEntityEditMode(intPKId,m_strToken)
		{
			//var strFilter;
			
			//strFilter = GetFilterQueryString();
			//" + strFilter + "
	        if("<%=m_strTagID%>"=="1038")		
	        {	            
			        window.open ("../PM/PM_TaskAssignment.aspx?TaskId=" + intPKId + "&Mode=Edit&MasterTagID=<%=m_strTagID%>&PkToken=" + m_strToken+"&GanttChartType=<%=m_strGanttView%>", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=600");
			        //window.open ("../General/CommonPage.aspx?ScheduleID_PK=" + intPKId + "&MasterTagID=2133&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			}    
			else if("<%=m_strTagID%>"=="34")		    
			    window.open ("../General/CommonPage.aspx?MilestoneID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			else if("<%=m_strTagID%>"=="661")
			    //Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 		    
			    //window.open ("../General/CommonPage.aspx?SubProjectID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    window.open ("../PM/SubProject_CommonPage.aspx?SubProjectID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    //End of Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 
			else if("<%=m_strTagID%>"=="2133")		    
			    window.open ("../General/CommonPage.aspx?ScheduleID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			else if("<%=m_strTagID%>"=="1019")
			    //Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 		    		    
			    //window.open ("../General/CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    window.open ("../PM/Resources_CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    //End of Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited
			else if("<%=m_strTagID%>"=="454")		    
			    window.open ("../General/CommonPage.aspx?ModuleID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");    
			    
			    //
		}

    var objdivMNPopup=GetObjectReference('','divMNPopup');
    var intDeliverableID,strToken;
    
    function ShowContextMenu(intPKId,m_strToken,ev)
    {
        objtxtDELID.value=intPKId;
        objtxtToken.value=m_strToken;
        
        showmenuie(objdivMNPopup,ev);
    }
    
    function mouseOverPopupMenu(evt)
	{
		    
			evt = evt || window.event;
			var source = evt.target || evt.srcElement;
			
			var objTblMN= source;
			while(objTblMN.tagName != "TABLE")
			objTblMN=objTblMN.parentNode;
			
			while(source.tagName != "TR")
			source=source.parentNode;
						
			for(c=0;c<objTblMN.rows.length;c++)
			objTblMN.rows[c].className="clsTRBlank";//"clsTROdd";
			
			source.className="clsTRColumnHeader";
	}	
	
	function mouseDownPopupMenu(From)
	{
	    if(From=="V")
	        //Added By VijaYD On 31 August 2009 : +"&COPYDATA=1"
	        window.open ("../General/CommonPage.aspx?ScheduleID_PK=" + objtxtDELID.value + "&MasterTagID=2133&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&PkToken=" +  objtxtToken.value, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
	    else
	          loadXMLHTTPDoc("../General/XMLHttp.aspx?TagID=2133&ScheduleID="+objtxtDELID.value,"")  
	}
var xmlhttp;
		
function loadXMLHTTPDoc(url,reqQuery)
{
// code for Mozilla, etc.
 

if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    xmlhttp.onreadystatechange=statePD_Change;
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

function statePD_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
        
        if(xmlhttp.responseText!="")
           
           { 
           //var strHTML="<script language='javascript'>" + xmlhttp.responseText + "<\script>";
           //  document.write(strHTML); 
           
            eval(xmlhttp.responseText);
           
           } 
            
      
                

       
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}
		
function loadXMLDoc(url,reqQuery,forwhich)
{
// code for Mozilla, etc.
 

if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    if(forwhich=="ASS")
        xmlhttp.onreadystatechange=state_Change;
    else    
        xmlhttp.onreadystatechange=DELstate_Change;
        
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
           
        //Added by ShraddhaM on 26,May 2009 for Leave validation
        else
        {             
            strResult = xmlhttp.responseText;
            
            if(strResult!=null)
			{
				if(strResult!='')
				{
					
					strResult=strResult.split("<=>");
							var intCount, Count;
								for(intCount=0;intCount<strResult.length;intCount++)
								{
									strLH=strResult[intCount];	
									strLH=strLH.split("<==>");
									for(Count=0;Count<strLH.length;Count++)
									{	
										if(strLH[Count]!='')
										{
											if(strLH[Count]!=' ')
											{
												/*if(confirm(strLH[Count]+ ' \n Do you want to continue ?')==false)
												{
													strResult=""; //added by PrashantD for Mozilla support. sync xmlhttp
													return;
												}*/
												strMsgg="<img src='../../images/info.gif' border=0></img>&nbsp;<font color='red'>"+strLH[Count] + "</font>";
						                                                                       			
			                                  
												
											}
										}		
									}	
								}
					
					
				}
			}
			
			
        }
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}

function txtTask_onBlur(obj)
{
 
     if(disallowBlank(obj,"Please enter task name!",true))
     {     
           //alert("Please enter task name!")    
            return;
           
     }
  
}

function txtTask_OnKeyup(objtxtTask,e)
{


    
        
   var code;
    if (e.keyCode) 
	    code = e.keyCode;
    else
	    if (e.which) 
		    code = e.which;
    		
    if(code==13) 
    {
     //Added by AmitJ on 30-Mar-2010 Hotfix :9.0.008
        //Purpose:Planned work hrs for completed task becomes zero when task is created using "create new task" feature.
          if("<%=m_strTagID%>"=="1038")
         {
             var objOrgWork = GetObjectReference('frmWBS_GanttChartView','txtOrgWork',true);
            var i,TaskID;       
            for (i=0;i<objOrgWork.length;i++)
            { 
                TaskID=objOrgWork[i].name;
                TaskID=TaskID.replace('txtOrgWork','');                     
                         
                var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);			        	    
		        objCurrentWork.disabled=false; //To Enabled the Control
               
            }
           }
		  //End Of Addition by AmitJ
  strLocation = "../Home/WBS_GanttChartView.aspx?From_Where=HRHome&Mode=Save&GanttChartType="+"<%=m_strGanttView %>";  

	 objfrm.action = strLocation
	 objfrm.submit(); 
	
    } 
   
}

function HideShowFilterAtPostBack()
{
    var objtrFilter=GetObjectReference('','trFilter');
    var objimgFilter=GetObjectReference('','imgFilter');
    if(objtrFilter.style.display=='')
    {
        objtrFilter.style.display='';
        objimgFilter.src='../../images/minus.gif';
    }
    
  
}

function HideShowFilter()
{
    var objtrFilter=GetObjectReference('','trFilter');
    var objimgFilter=GetObjectReference('','imgFilter');
    if(objtrFilter.style.display=='none')
    {
        objtrFilter.style.display='';
        objimgFilter.src='../../images/minus.gif';
    }
    else
    {
        objtrFilter.style.display='none';
        objimgFilter.src='../../images/plus.gif';
    }
     window_onLoad();
}

 var objtrAssig=GetObjectReference('','trAssig');
 var objimgAssig=GetObjectReference('','imgAssig');
 
  //Added by NitinC on 05 April 2012 For PMLifeLine(Issue Fix : 61089)
 if("<%=m_intFlag%>"=="1")
 {		    
    var objtrUSAssig=GetObjectReference('','trUSAssig');
    
 }
 //End of added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)


function HideShowAssignment()
{
    
    if(objtrAssig.style.display=='none')
    {
        objtrAssig.style.display='';
        objimgAssig.src='../../images/minus.gif';
        objdivlist.onscroll=Scroll;
        Scroll();	
    }
    else
    {
        objtrAssig.style.display='none';
        objimgAssig.src='../../images/plus.gif';
    }
    //Added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
     if("<%=m_intFlag%>"=="1")
     {		    
        if(objtrUSAssig.style.display=='none')
        {
            objtrUSAssig.style.display='';
            objimgAssig.src='../../images/minus.gif';
            objdivlist.onscroll=Scroll;
            Scroll();	
        }
        else
        {
            objtrUSAssig.style.display='none';
            objimgAssig.src='../../images/plus.gif';
        }
    }
    //End of added by NitinC on 05 April 2012 For PMLifeLine (Issue Fix : 61089)
    window_onLoad();
}

    /************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
    var brw=isIE(); 
    var strResult="";
		   function ValidateTask_Baseline(url) 
			{ 		
			// TO SEE IF WE ARE RUNNING IN IE 
						strNavigator = navigator.appName;
						strNavigator = strNavigator.toUpperCase();
		       //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
						if(brw=="IE")
						{ 
							g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send();
						}
						else
						{
						
							// Mozilla - based browser , Netscape
							g_objXHttp = new XMLHttpRequest();
							//hook the event handler
							g_objXHttp.onreadystatechange = TaskValidation_state_change;
							//prepare the call, http method=GET, false=asynchronous call
							g_objXHttp.open("GET",strUrl, false);
							//finally send the call
							g_objXHttp.send(null);
							
							if ( g_objXHttp.responseText != null)
							{
								xmlDoc= document.implementation.createDocument("","",null);
								xmlDoc.async=false;
								if(brw=="FF")//added by Nilesh g on 10/12/2015
								xmlDoc.load(g_objXHttp.responseXML);
								strResult=g_objXHttp.responseText;
						     }
							
						}
					return 	strResult;			
			} 
			
			function TaskValidation_state_change() 
			{			
				if (g_objXHttp.readyState == 4) 
				{
					
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if(brw=="IE")
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
												
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
							if(brw=="FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
						
							strResult=g_objXHttp.responseText;		
							
				    }
				}
			}	     

	   //Added By VijayD On 25 August 2009
	   //Validation While saving the Data 
    function ValidateControl_All(dtCurrentDate,StartDate,EndDate,WorkHrs,TaskID)			
    {
       if(WorkHrs)
        {
          StartDate  = GetFormat(StartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
          EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
          if(isLorR == "L")
            { StartDate=dtCurrentDate;}    
              else
            { EndDate=dtCurrentDate;}
         
            CNTDateDiff = DateDiff(StartDate,EndDate,"d") + 1;  
          
          CNTDateDiff = parseFloat(CNTDateDiff);
          
          if ( CNTDateDiff!=0 ) 
          {
            if((parseFloat(WorkHrs)/CNTDateDiff) > 24.0)
            {
                alert('Please check work hrs for a day.You can enter 24 hrs per day.');
                return false;
            }		
             
            if(parseFloat(WorkHrs) % 0.25 != 0.0)
            {
                alert('Please enter work hours multiple of 0.25');
                return false;
            }
          }   
        } 		     	   
        
	    var objTotalAllocatedTaskLCE;
		 
	    var objOrgWork = GetObjectReference(' frmWBS_GanttChartView','txtOrgWork'+TaskID);
	    if(objOrgWork != null)//Added by Shamkant S on 18 Dec 2015
	    {
	        var objTotalAllocatedTaskLCE = parseFloat(objOrgWork.value);		
	    }		
		if(parseFloat(WorkHrs) + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		{
		var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
			alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
			//setFocus(objCurrentWork);
			return false;
		}
		//Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
		if(parseFloat(WorkHrs) + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
		{
			var dblBalancedHrs;
			dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
			strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
			strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
			strMsg = replaceSubstring(strMsg, "<==>", WorkHrs.toFixed(2));
			alert(strMsg);
			return false;
		}
		   return true;        

    }
    function ValidateControl_All1(dtCurrentDate,StartDate,EndDate,WorkHrs,TaskID,strFrom)			
    {        
        if(WorkHrs)
        {
          StartDate  = GetFormat(StartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
          EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');   
           var objCurrentWork=GetObjectReference(' frmWBS_GanttChartView','txtWork'+TaskID);    
           
           var strURL;
            var intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
            var dblAvgHoursPerDay = WorkHrs/CNTDateDiff;           
		    if(dblAvgHoursPerDay > intCompanyHrsPerDay)
		    {
			    strMsg = "You are assigning <=> hours work per day. \n(OU working hours per day are <==> hours.) \nDo you wish to continue?";
			    strMsg = replaceSubstring(strMsg,"<=>",dblAvgHoursPerDay.toFixed(2));
			    strMsg = replaceSubstring(strMsg,"<==>",intCompanyHrsPerDay.toString());
			    if(!confirm(strMsg))
			    {
			    
				    setFocus(objCurrentWork);
				    return false;
			    }
		    }                
           else 
           {
                if (strFrom!="Save")
                {
                    if(isLorR == "L")
                    { StartDate=dtCurrentDate;}    // EndDate=""; 
                    else
                    { EndDate=dtCurrentDate;}//  StartDate="";
                }    

                strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId="+TaskID+"&StartDate="+encodeURIComponent(StartDate)+"&EndDate="+encodeURIComponent(EndDate)+"&DeliverableID=&ModuleID=&SubProjectID=&MilestoneID=&Work="+String(WorkHrs);
                ValidateTask_Baseline(strUrl);

                if(strResult!=null && strResult!="")
                {
                  alert(strResult);
                  return false;		    
                }   
            }
    		//strUrl = "../General/XMLHttp.aspx?TagID=1038&TaskId=0&PROJECT_SETTINGS=Normal&FromDate=" + encodeURIComponent(StartDate) + "&ToDate=" + encodeURIComponent(EndDate)+ "&EmployeeIDs=" + strEmployeeList ;
                        
        }   
        return true;    
    }		
    
    function Check_Task_DailyActivity(dtCurrentDate,StartDate,EndDate,TaskID,strFrom)   
    {
           var strURL;
           if(strFrom!="Save")
           {
                if(isLorR == "L")
                { StartDate=dtCurrentDate;}    
                else
                { EndDate=dtCurrentDate;}
           }
            strUrl = "../General/XMLHttp.aspx?TagID=0&Mode=DailyActivity_Gantt&TaskId="+TaskID+"&StartDate="+encodeURIComponent(StartDate)+"&EndDate="+encodeURIComponent(EndDate);
            ValidateTask_Baseline(strUrl);
            if(strResult!=null && strResult!="")
            {
              alert(strResult);
              return false;		    
            }   
       return true;    
    }			
	    //************************End Addition By VijayD 25 May 2009**************************//
var prevDelID=0;
var arrDelID = new Array();
	        
function ShowHideDelivTasks(DeliverableID,flag)
{  
    var objtr=GetObjectReference('','trDel_' + DeliverableID);
    var objtrTask=GetObjectReference('','trDelTask_' + DeliverableID,true);
   
    var objimg=GetObjectReference('','imgDel_'+DeliverableID);
    var objTRAdd=GetObjectReference('frmWBS_GanttChartView','TRAdd_'+DeliverableID);
    var objverL;
    var objverR;
    
    
            
   // if(parseInt(prevDelID)!=parseInt(DeliverableID) && parseInt(prevDelID)!=0)
            //    ShowHideDelivTasks(prevDelID,1);     
   
   
    if((objimg.src).match('plus'))
    {
        
        objimg.src='../../images/minus.gif';
        if(objTRAdd!=null)
            objTRAdd.style.display='';
            
        for(i=0;i<objtrTask.length;i++)
        {
            objtrTask[i].style.display='';
        }
        window_onLoad();  
        
            
        for(i=0;i<objtrTask.length;i++)
        {
                                  
            objverL=GetObjectReference('','verL'+objtrTask[i].getAttribute("vertIndex"));
            objverR=GetObjectReference('','verR'+objtrTask[i].getAttribute("vertIndex"));
            
          
            
            objverL.style.display='';
            objverR.style.display='';
            
        }
        
        //if(parseInt(prevDelID)!=parseInt(DeliverableID) && parseInt(prevDelID)!=0)
          //  ShowHideVert(prevDelID,0);    
    }
    else
    {
        if(objTRAdd!=null)
            objTRAdd.style.display='none';
         
         for(i=0;i<objtrTask.length;i++)
        {
            objtrTask[i].style.display='none';
                 
        }
        
        window_onLoad();  
       
       
       for(i=0;i<objtrTask.length;i++)
        {
                                
            objverL=GetObjectReference('','verL'+objtrTask[i].getAttribute("vertIndex"));
            objverR=GetObjectReference('','verR'+objtrTask[i].getAttribute("vertIndex"));
            
                      
            objverL.style.display='none';
            objverR.style.display='none';
           
        }
        
        objimg.src='../../images/plus.gif';
     
        // if(parseInt(prevDelID)!=parseInt(DeliverableID) && parseInt(prevDelID)!=0)
        // ShowHideVert(prevDelID,1);    
    }
     
  ShowHideVert();     

}

function ShowHideVert()
{



     var objimg;
     var objverL;
     var objverR;
     
     for(i=0;i<arrScheduleID.length;i++)
        {
            objimg=GetObjectReference('','imgDel_'+arrScheduleID[i]);
            
            objtrTask=GetObjectReference('','trDelTask_' + arrScheduleID[i],true);
                                              
                      
          for(j=0;j<objtrTask.length;j++)
          {
          
           objverL=GetObjectReference('','verL'+objtrTask[j].getAttribute("vertIndex"));
           objverR=GetObjectReference('','verR'+objtrTask[j].getAttribute("vertIndex"));
           
          if((objimg.src).match('plus'))
            {       
                 objverL.style.display='none';
                 objverR.style.display='none';
            }
            else
            {       
                objverL.style.display='';
                objverR.style.display='';
            }
         }   
       }
     
}
function Add_OnClick()
{
    window.open ("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2246", "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=600,height=450");
}    

function Period_OnChange(obj)
{
    if(String(obj.value)=="4")
    {
        window.location.href="../General/CommonList.aspx?MasterTagID=2133&FromWhere=PM";
    }
    else if(String(obj.value)=="3")
    {
        window.location.href="../Home/Home_OutlookView.aspx?List=9";
    }
    else
    {
        // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
      if(document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("tdDot1")!=null )
      {  
       if(String(obj.value)=='5') 
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("tdDot1").disabled=true;
       else
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("tdDot1").disabled=false;      
      }  
        window.location.href="../Home/WBS_GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType="+obj.value;
    
    } 
}

var objtxtDELTotalWork=GetObjectReference('','txtDELTotalWork');
var strWorkAlert='';

function txtDELWork_OnBlur(obj,PKID,flag)
{
    /*if(disallowBlank(obj, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))
			return ;*/
	if(disallowMinValueViolation(obj, 0, "Please enter positive numeric value !",true))
			return ;

    if( parseFloat(obj.value) > parseFloat("<%=m_dblTotalLCE%>"))
		{
		    
			alert("The total work (hours) of the deliverable should not exceed the project work hours "+ <%=m_dblTotalLCE%> + " .");
			setFocus(obj);
			return false;
		}

	 loadXMLDoc("../Home/AJAXHttp.aspx?MasterTagID=2133&ScheduleID="+PKID,"","DEL");
	

    if(parseFloat(strWorkAlert) > parseFloat(obj.value)) 
       {
            alert("Work (" + String(obj.value) + ") should not be less than sum of estimated task efforts ("+strWorkAlert+")");
            setFocus(obj);
            return 
       } 
       
       
     /*  eval(strWorkAlert);
       setFocus(obj);
       return; */
       

} 

function DELstate_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
        if(xmlhttp.responseText!="")
           
           { 
              strWorkAlert=xmlhttp.responseText;
              //xmlhttp.responseText;
           }             
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}

</script>


    
</body>
</html>
