<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverallSchedule_GanttView.aspx.vb" Inherits="PbNIT.OverallSchedule_GanttView" %>

<html>
<%  CommonFunctions.General.PlotPageHeadTag("Overall Schedule Gantt View")%>

<script language='javascript' src='../AdvancedTimesheet/timesheet.js'></script>
<script language='javascript' src='../DB/DateFormat.js'></script>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->


<script src="../../responsive/responsive.js"></script>
<script src="../../js/freezetablecolumns.js"></script>

<link rel='stylesheet' type='text/css' href='../Home/Home.css' />
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css' />
<style>
    #preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;
        border: 3px solid #ababab;
        box-shadow: 1px 1px 10px #ababab;
        border-radius: 20px;
        background-color: white;
        background: url("../../Images/KloaderImage.gif") rgba( 255, 255, 255, .8 ) 100% 100% no-repeat;
        width: 100px;
        height: 100px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
       
    }

    #fillDiv {
        opacity: 0.95;
        background-color: ghostwhite;
        /*DISPLAY: none;*/
        Z-INDEX: 100;
        LEFT: 0px;
        VISIBILITY: visible;
        WIDTH: 100%;
        POSITION: absolute;
        TOP: 0px;
        HEIGHT: 100%;
        float: right;
         
    }
    .LRDiv
    {
        cursor:e-resize;
        position:fixed;
        top:1px;
        left:1px;
        height:1px;
        width:1px;
        font-size:1px;
        border-left:groove 1px red;
    }
    .clsFreeze
    {
        left:0px;        
    }
</style>
<body class="clsBody" onresize="window_onResize()" onmouseup="clickDocUp(event)" ondragstart="return false"
    onload="window_onLoad()" MS_POSITIONING="GridLayout">
    <style>
        tbody.TRGroup:nth-child(even)
        {
           background-color: #f6eee4 ;
        }
    </style>

    <div id='DateTitle' style='BORDER-RIGHT: blue 1px groove; BORDER-TOP: blue 1px groove; DISPLAY: none; FONT-SIZE: 10px; LEFT: 1px; BORDER-LEFT: blue 1px groove; WIDTH: 60px; BORDER-BOTTOM: blue 1px groove; POSITION: absolute; TOP: 1px; BACKGROUND-COLOR: yellow'>
        &nbsp;12 
			Dec 2007
    </div>

<%--    <div id="divLTooltip" style='BORDER-RIGHT: blue 1px groove; BORDER-TOP: blue 1px groove; DISPLAY: none; FONT-SIZE: 10px; Z-INDEX: 190001; LEFT: 1px; BORDER-LEFT: blue 1px groove; WIDTH: 80px; BORDER-BOTTOM: blue 1px groove; POSITION: absolute; TOP: 1px; BACKGROUND-COLOR: yellow'>
        &nbsp; 
			12 Left 2007
    </div>
    <div id="divRTooltip" style='BORDER-RIGHT: blue 1px groove; BORDER-TOP: blue 1px groove; DISPLAY: none; FONT-SIZE: 10px; Z-INDEX: 190001; LEFT: 10px; BORDER-LEFT: blue 1px groove; WIDTH: 80px; BORDER-BOTTOM: blue 1px groove; POSITION: absolute; TOP: 10px; BACKGROUND-COLOR: yellow'>
        &nbsp;12 
			Right 2007
    </div>--%>

    <div id="divLTooltip" align="center" style='text-align:center; BORDER-RIGHT: blue 1px groove; BORDER-TOP: blue 1px groove; DISPLAY: none; FONT-SIZE: 10px; Z-INDEX: 190001;  BORDER-LEFT: blue 1px groove; WIDTH: 80px; BORDER-BOTTOM: blue 1px groove; POSITION: absolute;  BACKGROUND-COLOR: yellow'>
        &nbsp; 
			12 Left 2007
    </div>
    <div id="divRTooltip" align="center" style='text-align:center; BORDER-RIGHT: blue 1px groove; BORDER-TOP: blue 1px groove; DISPLAY: none; FONT-SIZE: 10px; Z-INDEX: 190001;  BORDER-LEFT: blue 1px groove; WIDTH: 80px; BORDER-BOTTOM: blue 1px groove; POSITION: absolute;  BACKGROUND-COLOR: yellow'>
        &nbsp;12 
			Right 2007
    </div>
   <div id='preloader'></div>
    <div id='fillDiv'></div>

    <form id="frmOSGanttView" method="post">

        <%PageInit()%>
    </form>
     <script language="javascript">
        
         $(window).ready(function () {
             $('body').append("<div id='preloader'></div> <div id='fillDiv'></div>");    
             
             ////$('#divList').on("scroll",function(){       
             ////    var scrollTop = $(this).scrollTop();
             ////    var objParent = parent.document.frames.frmMain.document.getElementById('divListPageTag');
             ////    objParent.scrollTop = scrollTop;
             ////});
         });
         $(window).load(function () {
            // setFrameLoader();            
                 RemoveFrameLoader();           
         });
        </script>
      
    <script language="javascript">

		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
		<%End If%>
		
        var objfrm=GetFormReference('frmGanttChartView');
        var objdivlist=GetObjectReference('frmGanttChartView','divList');
     
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
        var intPreItemCount; // Added By Vaijat K ON 28/11/2015
        var clsRName="clsGanttChart";
        var clsWName="clsTDBlank";
        var objhldAlert=GetObjectReference('frmGanttChartView','hldAlert');
        var objlblMsg=GetObjectReference('frmGanttChartView','lblMsg');
        var strMsgg="";

        function setFrameLoader() {

            $("HTML").append("<div id='preloader'></div>");
            $("HTML").append("<div id='fillDiv'></div>");
            //$('#preloader').show();
            //$('#fillDiv').show();
        }
        function RemoveFrameLoader() {
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
            jQuery("#preloader").fadeOut("slow");
            jQuery("#fillDiv").fadeOut("slow");
            jQuery("#preloader").remove();
            jQuery("#fillDiv").remove();
        }
	
        if(GetObjectReference('frmGanttChartView','txtNoOfPages'))
        {	
            var noOfPages = GetObjectReference('frmGanttChartView','txtNoOfPages').value;
            var objtxtpageNumber =  GetObjectReference('frmGanttChartView','txtPageNumber');
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
                if (navigator.appName == 'Microsoft Internet Explorer')
                {
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

            //Added By Bharat Tekade on 26th-Apr-2016 to manage position of gantt view grid accourding to os scheduling grid
      
            //var position = $('#divListTag', window.parent.document).offset();
            var WhichBrowser = isIE();
         
          
            var top = getParameterByName("top");
            var from = getParameterByName("From");
            var objTBody = $(".TRGroup");
            var legendDivHeight = $('#legendDiv').height();
            var pageTitle = $('#pageTitle').height();
            top = parseInt(top) - legendDivHeight - pageTitle - 40;

            if(WhichBrowser == 'IE')
            {
                objTBody.css('height','15px');
                if (from == 'PlusMinusClick')
                {
                    top = top + 8;
                }
                else{
                    top = top + 4;
                }
            }
            else if(WhichBrowser == 'FF'){
                objTBody.css('height','46.3px');
                if (from == 'PlusMinusClick')
                {
                    top = parseInt(top) + 8;
                }
                else{
                    top = parseInt(top)+7;
                }
            }
            else 
            {
                //objTBody.css('height','46.3px');
                top = parseInt(top) - 13;
                $(".TRGroup tr").css('height','10px');
                if (from == 'PlusMinusClick')
                {
                    top = parseInt(top) + 22;
                }
                else{
                    top = parseInt(top) + 20;
                }
            }

            $('#tblGantt').css('position','relative');
            $('#tblGantt').css('top',top+'px');
            // var position = parent.document.getElementById("frmMain").contentDocument.forms.frmCommonList;
        

            RemoveFrameLoader();
            //Ended By Bharat Tekade on 26th-Apr-2016 to manage position of gantt view grid accourding to os scheduling grid
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
            {   DToffX=-66; DTOffY=-6;
                isLorR = "L";
                setLeftVertBoundary(curMoveVert.id.substring(4));
            }
            else
            {   DToffX=6,DTOffY=-6; 
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

        var objdivAR=GetObjectReference('frmGanttChartView','divAR');
        var objdivATT=GetObjectReference('frmGanttChartView','divATT');
        var objdivAP=GetObjectReference('frmGanttChartView','divAP');
        var objdivView=GetObjectReference('frmGanttChartView','divView');

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
            //Added By VijayD On 25 August 2009
            //Validation While saving the Data 
	 
            if (curMoveVert!=null)
            {

                var arrTargetInfo = curMoveVert.getAttribute("Target").split("|");
                var oTargetDT = document.getElementById(curMoveVert.getAttribute("Target"));
                var TaskID=arrTargetInfo[0]; 
                dtCurrentDate=oTargetDT.getAttribute("Date");
                var dtHolidayDate=dtCurrentDate; 
                dtCurrentDate=GetFormat(dtCurrentDate,'dd-mmm-yyyy','MM/DD/YYYY');
                objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
                objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
                var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);
                if("<%=m_strTagID%>"=="1038")
        {	
            var StartDate=objstartDate.value;
            var EndDate=objEndDate.value;
            StartDate  = GetFormat(StartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
            EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');  
            if(isLorR == "L")
            { StartDate=dtCurrentDate;}    // EndDate=""; 
            else
            { EndDate=dtCurrentDate;}//  StartDate="";
           
            var CNTDateDiff = DateDiff(StartDate,EndDate,"d") + 1;
            CNTDateDiff = parseFloat(CNTDateDiff);
            var intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
            var dblAvgHoursPerDay = objCurrentWork.value/CNTDateDiff;           
            if(dblAvgHoursPerDay > intCompanyHrsPerDay)
            {
                strMsg = "You are assigning <=> hours work per day. \n(OU working hours per day are <==> hours.) \nDo you wish to continue?";
                strMsg = replaceSubstring(strMsg,"<=>",dblAvgHoursPerDay.toFixed(2));
                strMsg = replaceSubstring(strMsg,"<==>",intCompanyHrsPerDay.toString());
                if(!confirm(strMsg))
                {		
                    DT.style.display='none';
                    curMoveVert = null;
                    document.body.style.cursor = "Default"; 
                    curMoveVert = null;
                    document.body.onmousemove = function(){};  				         
                    return false;
                }
            }            		
            /*if(!ValidateControl_All1(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID,"clickDocUp"))
                {    	                
	                //objCurrentWork.focus();
	                DT.style.display='none';
	                curMoveVert = null;
	                document.body.style.cursor = "Default"; 
	                curMoveVert = null;
	                document.body.onmousemove = function(){};  	                         
                    return false;  
                }    */
  
            if   (!Holiday(dtHolidayDate,objstartDate.value,objEndDate.value,TaskID,evt)) 
            { 
                DT.style.display='none';
                curMoveVert = null;
                document.body.style.cursor = "Default";
                document.body.onmousemove = function(){};             
                return; 
            }     
            if(!Check_Task_DailyActivity(dtCurrentDate,objstartDate.value,objEndDate.value,TaskID,"clickDocUp")) 
            {    
                DT.style.display='none';
                curMoveVert = null;
                document.body.style.cursor = "Default";
                document.body.onmousemove = function(){}; 	            
                return false;
            }         
            var CNTDateDiff = DateDiff(StartDate,EndDate,"d") + 1;
            CNTDateDiff = parseFloat(CNTDateDiff);
            var intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
            var dblAvgHoursPerDay = objCurrentWork.value/CNTDateDiff;           
            if(dblAvgHoursPerDay > intCompanyHrsPerDay)
            {
                strMsg = "You are assigning <=> hours work per day. \n(OU working hours per day are <==> hours.) \nDo you wish to continue?";
                strMsg = replaceSubstring(strMsg,"<=>",dblAvgHoursPerDay.toFixed(2));
                strMsg = replaceSubstring(strMsg,"<==>",intCompanyHrsPerDay.toString());
                if(!confirm(strMsg))
                {		     
                    DT.style.display='none';
                    curMoveVert = null;
                    document.body.style.cursor = "Default"; 
                    curMoveVert = null;
                    document.body.onmousemove = function(){};  				    
                    return false;
                }    
            }                                                 
        }    
        else  if("<%=m_strTagID%>"=="1019") 
        {
            var StartDate=objstartDate.value;
            var EndDate=objEndDate.value;
   
            StartDate  = GetFormat(StartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
            EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');  
            if(isLorR == "L")
            { StartDate=dtCurrentDate;}     
            else
            { EndDate=dtCurrentDate;} 
            strUrl = "../General/XMLHttp.aspx?TagID=0&Mode=ResourceJoing_Gantt&ResourceID="+TaskID+"&StartDate="+encodeURIComponent(StartDate)+"&EndDate="+encodeURIComponent(EndDate);
            ValidateTask_Baseline(strUrl);
            if(strResult!=null && strResult!="")
            {
                alert(strResult);
                DT.style.display='none';
                curMoveVert = null;
                document.body.style.cursor = "Default"; 
                curMoveVert = null;
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
{//debugger;
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
        objTaskTDID = GetObjectReference('frmGanttChartView','Task' + arrTargetInfo[0]);
        if(objTaskTDID)
        {
            ResourceStartDate = objTaskTDID.getAttribute("ResourceStartDate");
            ResourceEndDate = objTaskTDID.getAttribute("ResourceEndDate");
            EmployeeID = objTaskTDID.getAttribute("EmployeeID");
            //Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)
            if("<%=m_intFlag%>"=="1" && objTaskTDID != null)
			    {
			        UserStoryEndDate = objTaskTDID.getAttribute("UserStoryEndDate");
			    }
			    //End of Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)

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
            if(GantViewEndMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewEndDay == i  )
            { isCrossRightBoundary=true; //break;
            }
		    ///Added by PrashantSJ on 16th March 2009					 
            if(dtTD!=null)
            {			
				
                //if(!ValidateEndDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0])) {isCrossRightBoundary=true;break; }
                //Commented and Added by NitinC on 03 Feb 2012 For WhizibleSEM 11.0 (Issue Fix : 58806)
                //if(!ValidateEndDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceEndDate,EmployeeID,evt)) {isCrossRightBoundary=true;break; }
                if("<%=m_intFlag%>"=="1" && objTaskTDID != null)
		    {
		        if(!ValidateEndDatesForScrum(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceEndDate,UserStoryEndDate,EmployeeID,evt)) {isCrossRightBoundary=true;break; }
			            
		    }
		    else
		    {
		        if(!ValidateEndDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceEndDate,EmployeeID,evt)) {isCrossRightBoundary=true;break; }
		    }
		    //End of Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)

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
        objTaskTDID = GetObjectReference('frmGanttChartView','Task' + arrTargetInfo[0]);
        if(objTaskTDID)
        {
            ResourceStartDate = objTaskTDID.getAttribute("ResourceStartDate");
            EmployeeID = objTaskTDID.getAttribute("EmployeeID");
            //Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)
            if("<%=m_intFlag%>"=="1" && objTaskTDID != null)
			    {
			        UserStoryStartDate = objTaskTDID.getAttribute("UserStoryStartDate");
			    }
			    //End of Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)

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
		
            if(GantViewStartMon == (parseInt(arrTargetInfo[1])+monInr) && GantViewStartDay == i && "<%=m_strGanttView%>"!=5 &&  "<%=m_strGanttView%>"!=6 ) //&& "<%=m_strGanttView%>"!=5 &&  "<%=m_strGanttView%>"!=6
				{ isCrossLeftBoundary=true; //break;
				}
				
				
			    //Added By PrashantSJ on 16th March 2009
				if(dtTD!=null)
				{
				    //if(!ValidateDates(getDate(dtTD.getAttribute("Date")),arrTargetInfo[0] )) {isCrossLeftBoundary=true; break;}
				    //Commented and Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)
				    //if(!ValidateDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceStartDate,EmployeeID,evt )) {isCrossLeftBoundary=true; break;}
				    if("<%=m_intFlag%>"=="1" && objTaskTDID != null)
				    {
				        if(!ValidateDatesForScrum(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceStartDate,UserStoryStartDate,EmployeeID,evt )) {isCrossLeftBoundary=true; break;}
			            
				    }
				    else
				    {
				        if(!ValidateDates(dtTD.getAttribute("Date"),arrTargetInfo[0],ResourceStartDate,EmployeeID,evt )) {isCrossLeftBoundary=true; break;}
				    }
				    //End of Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)

				
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
        //Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)
        function ValidateDatesForScrum(dtCurrentDate,TaskID,ResourceStartDate,UserStoryStartDate,EmployeeID,evt)
        {

            dtProjectStartDate = "<%=m_strProjectStartDate%>" ;
    var dtHolidayCurrentDate = dtCurrentDate ;
    dtProjectStartDate  = GetFormat(dtProjectStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
    dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
    var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID); 
        
    if(ResourceStartDate)               
        ResourceStartDate = GetFormat(ResourceStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
        
    if(UserStoryStartDate)               
        UserStoryStartDate = GetFormat(UserStoryStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');
                 
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
        if(UserStoryStartDate != '')
        {
            if(DateDiff(dtCurrentDate,UserStoryStartDate,'d')>0)
            {	
                strMsg="Start date should be greater than equal to User Story start date ("+UserStoryStartDate+").";
                //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
               alert(strMsg);			
               return false;
           }
       }
       if(IsCaseOneProject=="False" && objhidParentTaskID!=null )
       {
           var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID);  
           var objParentTaskStartDate=GetObjectReference('frmGanttChartView','hidParentStartDate'+objhidParentTaskID.value);
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
         var ResourceValidation = GetObjectReference('frmGanttChartView','hidResourceValidation'); 
         if(ResourceValidation)
             if(ResourceValidation.value == "True")
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
     if("<%=m_strTagID%>"=="1038")
    {
        	
        //if(!Holiday(dtHolidayCurrentDate,evt)) { return false;}'Commented By VijayD On 26 August 2009
        	
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
        objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
        objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
        var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);		    
        if(!ValidateControl_All(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID))
        {
            return false;		    
        }	
		    	   
    //End Addition By VijayD On 25 August 2009
    }   
    //************************End Addition By VijayD 15 Jun 2009**************************//                    
    return true;
    }
    function ValidateEndDatesForScrum(dtCurrentDate,TaskID,ResourceEndDate,EmployeeID,evt)
    {
        dtProjectEndDate = "<%=m_strProjectEndDate%>" ;
    var dtHolidayCurrentDate = dtCurrentDate ;
        
    dtProjectEndDate  = GetFormat(dtProjectEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
    dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');     
    var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID); 
      
        
                 
    if(ResourceEndDate)      
        ResourceEndDate = GetFormat(ResourceEndDate ,'dd-mmm-yyyy','MM/DD/YYYY'); 
          
    if(UserStoryEndDate)               
        UserStoryEndDate = GetFormat(UserStoryEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');


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
        if(UserStoryEndDate != '')
        {     
            if(DateDiff(UserStoryEndDate,dtCurrentDate,'d')>0)
            {	
                strMsg="End date should be less than equal to User Story end date ("+UserStoryEndDate+").";
                //strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
                alert(strMsg);			
                return false;
            }
        }
        if(IsCaseOneProject=="False" && objhidParentTaskID!=null)
        {
            var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID);  
            var objParentTaskEndDate=GetObjectReference('frmGanttChartView','hidParentEndDate'+objhidParentTaskID.value);
   
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
         var ResourceValidation = GetObjectReference('frmGanttChartView','hidResourceValidation'); 
         if(ResourceValidation)
             if(ResourceValidation.value == "True")
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
    //Added and Commented By VijayD On 15 Jun 2009
     if("<%=m_strTagID%>"=="1038")
    {
        /*
                    if(!Holiday(dtHolidayCurrentDate,evt)) {  return false;} //Commented By VijayD On 15 Jun 2009
                    var strResult='';	
                    
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
         }  
         */ 
    //Validation While saving the Data     		    
         objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
         objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
         var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);		    
         if(!ValidateControl_All(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID))
         {
             return false;		    
         }
    //End Addition and Comment By VijayD On 15 Jun 2009
     }
     //************************End Addition By VijayD 15 Jun 2009**************************//                    
     return true;
     }
     //End of Added by NitinC on 03 Feb 2012 For PMLifeLine (Issue Fix : 58806)
     function ValidateDates(dtCurrentDate,TaskID,ResourceStartDate,EmployeeID,evt)
     {

         dtProjectStartDate = "<%=m_strProjectStartDate%>" ;
    var dtHolidayCurrentDate = dtCurrentDate ;
    dtProjectStartDate  = GetFormat(dtProjectStartDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
    dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');    
    var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID); 
        
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
        if(IsCaseOneProject=="False" && objhidParentTaskID!=null )
        {
            var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID);  
            var objParentTaskStartDate=GetObjectReference('frmGanttChartView','hidParentStartDate'+objhidParentTaskID.value);
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
         var ResourceValidation = GetObjectReference('frmGanttChartView','hidResourceValidation'); 
         if(ResourceValidation)
             if(ResourceValidation.value == "True")
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
     if("<%=m_strTagID%>"=="1038")
    {
        	
        //if(!Holiday(dtHolidayCurrentDate,evt)) { return false;}'Commented By VijayD On 26 August 2009
        	
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
        objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
        objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
        var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);		    
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
        
        dtProjectEndDate  = GetFormat(dtProjectEndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
        dtCurrentDate = GetFormat(dtCurrentDate ,'dd-mmm-yyyy','MM/DD/YYYY');     
        var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID); 
      
        
                 
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

        if(IsCaseOneProject=="False" && objhidParentTaskID!=null)
        {
            var objhidParentTaskID=GetObjectReference('frmGanttChartView','hidParentTaskID'+TaskID);  
            var objParentTaskEndDate=GetObjectReference('frmGanttChartView','hidParentEndDate'+objhidParentTaskID.value);
   
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
         var ResourceValidation = GetObjectReference('frmGanttChartView','hidResourceValidation'); 
         if(ResourceValidation)
             if(ResourceValidation.value == "True")
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
        //Added and Commented By VijayD On 15 Jun 2009
     if("<%=m_strTagID%>"=="1038")
        {
            /*
                        if(!Holiday(dtHolidayCurrentDate,evt)) {  return false;} //Commented By VijayD On 15 Jun 2009
                        var strResult='';	
                        
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
         }  
         */ 
        //Validation While saving the Data     		    
         objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
         objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
         var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);		    
         if(!ValidateControl_All(dtCurrentDate,objstartDate.value,objEndDate.value,objCurrentWork.value,TaskID))
         {
             return false;		    
         }
        //End Addition and Comment By VijayD On 15 Jun 2009
     }
     //************************End Addition By VijayD 15 Jun 2009**************************//                    
     return true;
     }
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
 
        /* var intDivHeight ;
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
                
                
            }*/
		
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
    //function showToolTip(src,evt)
    //{   
    
    //    LToolTip.innerHTML = '01-Apr-2016';
    //    RToolTip.innerHTML = '30-Apr-2016'; 
    //    var xPos = evt.clientX;
    //    var yPos = evt.clientY;
    //    //alert('xPos :' + xPos + 'yPos :'+ yPos);

    //    LToolTip.style.left = xPos - 10 + 'px';
    //    LToolTip.style.top = yPos - 10 + 'px';

    //    RToolTip.style.left = xPos + 60 + 'px';
    //    RToolTip.style.top = yPos - 10 + 'px';


    //    LToolTip.style.display=''
    //    RToolTip.style.display=''
    //}
    function showToolTip(src,evt,StartDate,EndDate,startTdId,endTDId)
    {   
        //debugger;
        if(curMoveVert)
            return;
        
        if(StartDate == '01-Jan-1900' || EndDate == '01-Jan-1900')
            return;
       //debugger;
        var r_tp_top,r_tp_left;
        var l_tp_top,l_tp_left;
        var r_tp_text,t_tp_text;
        var vertOfrIndex;
        //Added by Dhanashri S on 16 June 2015
        var l_tp_text;
        //End of Addition by Dhanashri S on 16 June 2015
        var rIndex = src.getAttribute("vertIndex");

       
        var objStartTD = document.getElementById(startTdId);
        var objEndTD = document.getElementById(endTDId);
       
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

                vertOfrIndex = document.getElementById('verR'+rIndex);

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

 

            LToolTip.innerHTML = StartDate  ;
            RToolTip.innerHTML = EndDate; 
           
            var docWidth = $(document).width() / 2; ;

            var trTop = evt.currentTarget.offsetTop;
            var currTop = $("#tblGantt").offset().top + parseInt(trTop) ;

            LToolTip.innerHTML = StartDate

            RToolTip.innerHTML = EndDate; 

            //LToolTip.style.left = docWidth - 80 + 'px';
            //RToolTip.style.left = docWidth + 40 + 'px';

            //alert(getPosition(objEndTD).x);
            //alert($(window).width());
            //alert($(document).width());
            //alert($('#tblGantt').width());
                 
            ////if((parseInt($('#divList')[0].offsetWidth) + parseInt($('#divList')[0].scrollLeft)) > 554)
            ////{
            ////    //alert(parseInt($('#divList')[0].offsetWidth));
            ////    //alert(parseInt($('#divList')[0].scrollLeft));
            ////    var toolLeft = parseInt(getPosition(objEndTD).x) - parseInt($('#divList')[0].scrollLeft)  + parseInt($('.clsTRVertIndex td table tbody tr td:first')[0].offsetWidth);
            ////    if(objEndTD!=null)
            ////        RToolTip.style.right = toolLeft + 'px';
            ////    RToolTip.style.left =  toolLeft - 80 + 'px';
            ////}
            ////else
            ////{
            ////    if(objEndTD!=null)
            ////        RToolTip.style.left = parseInt(getPosition(objEndTD).x) - parseInt($('#divList')[0].scrollLeft)  + parseInt($('.clsTRVertIndex td table tbody tr td:first')[0].offsetWidth) + 'px';
            ////}
            if( parseInt(getPosition(objEndTD).x) + 80 > parseInt($('#tblGantt').width()) )
            {
                var toolLeft = parseInt(getPosition(objEndTD).x) - parseInt($('#divList')[0].scrollLeft)  + parseInt($('.clsTRVertIndex td table tbody tr td:first')[0].offsetWidth);
                var rightToolTipDiff = parseInt($('#tblGantt').width()) - parseInt(getPosition(objEndTD).x);

                toolLeft = toolLeft + rightToolTipDiff;

                    if(objEndTD!=null)
                        RToolTip.style.right = toolLeft  + 'px';

                    RToolTip.style.left =  toolLeft - 80 + 'px';
            }
            else
            {
                if(objEndTD!=null)
                    RToolTip.style.left = parseInt(getPosition(objEndTD).x) - parseInt($('#divList')[0].scrollLeft)  + parseInt($('.clsTRVertIndex td table tbody tr td:first')[0].offsetWidth) + 'px';
            }

            //if(parseInt($('#divList')[0].scrollLeft) < 40)
            //{
            //    if(objStartTD!=null)
            //        LToolTip.style.left = parseInt(getPosition(objStartTD).x) - 80 - parseInt($('#divList')[0].scrollLeft)  + 'px';

            //}
            //else if( parseInt($('#divList')[0].scrollLeft) > 40 )
            //{
            //    if(objStartTD!=null)
            //        LToolTip.style.left = parseInt(getPosition(objStartTD).x) - 80 - parseInt($('#divList')[0].scrollLeft)  + 'px';
            //}

            if(parseInt(getPosition(objStartTD).x) > 80 )
            {
                if(objStartTD!=null)
                    LToolTip.style.left = parseInt(getPosition(objStartTD).x) - 80 - parseInt($('#divList')[0].scrollLeft)  + 'px';
            }
            else
            {
                if(objStartTD!=null)
                    LToolTip.style.left = 1 - parseInt($('#divList')[0].scrollLeft) + 'px';
            }

            LToolTip.style.top = parseInt(currTop) - 10 + 'px';
            RToolTip.style.top = parseInt(currTop) - 10 + 'px';
           
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
        objfrm.action="../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
        objfrm.submit();
    }
    function NextOrPrevPeriod(Period)
    {
        objfrm.action="../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1&Period="+Period+"&GanttChartType=<%=m_strGanttView%>";   
    objfrm.submit();
}
function Save_OnClick()
{

 
    //Added By VijayD On 25 August 2009
    //Validation While saving the Data 
    //Added by swapnil aswale on 17th Nov 2015 for special character validation
    var objTaskName;
    objTaskName = GetObjectReference('frmRequestDetails','txtTaskName_'+intPreItemCount);
    if (disallowSpecialCharacters(objTaskName,"Characters '/:*?+\"><,\\\\' are not allowed")) return false;
    //Ended
    if(!ValidateControls()) return;
	      
    if("<%=m_strTagID%>"=="1038")
	    {
	        var objTotalAllocatedTaskLCE;
           
	        var objOrgWork = GetObjectReference('frmGanttChartView','txtOrgWork',true); 
          
            
	        var i,TaskID;
	        var objstartDate ,objEndDate;
	        for (i=0;i<objOrgWork.length;i++)
	        { 
	            TaskID=objOrgWork[i].name;
	            TaskID=TaskID.replace('txtOrgWork','');
                       
	            objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
	            objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
            
	            var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);	
	            var objTotalAllocatedTaskLCE = parseFloat(objOrgWork[i].value);	
		    
	            //To Enabled the Control Useful While Saving the Data
	            CWork = parseFloat(objCurrentWork.value);
		        
	            //Added by NitinC on 18 Jan 2012 for PMLifeLine (Issue Fix : 58806)
	            var valhrUS = GetObjectReference('frmGanttChartView','hrUS');
	            if("<%=m_intFlag%>"=="1" && valhrUS.value != "")
   		        {	     
   		            if(!ValidateUSDates(objstartDate.value,objEndDate.value,CWork,TaskID))
   		            {
   		                return false;
   		            }		
   		        }
                //Added by NitinC on 18 Jan 2012 for PMLifeLine (Issue Fix : 58806)
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
                objCurrentWork.disabled=false;
            }   
        }	 
    //End Addition By VijayD On 25 August 2009 
    

        
        
        objfrm.action="../Home/GanttChartView.aspx?From_Where=HRHome&Mode=Save";  
        objfrm.submit();
    }
    //Added By NitinC On 05 Jan 2011 for PMLifeLine agile module (Issue Fix 58806)
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
    //End of Added By NitinC On 05 Jan 2011 for PMLifeLine agile module (Issue Fix 58806)

    //Added By NitinC On 05 Jan 2011 for PMLifeLine agile module (Issue Fix 58144)
    function ValidateUserStory(StartDate,EndDate,CurrentWork,UserStoryID)
    {
    
        try
        { 
            var strUrl="../PM/AjaxCallIteration.aspx?Flag=AssignedTask&UserStoryID=" + objhidTxtUSID.value;
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
    //End of Added By NitinC On 05 Jan 2011 for PMLifeLine (Issue Fix 58144)
    function ValidateControls()
    {//debugger;
        var objchkSelect=GetObjectReference('frmGanttChartView','chkSelect',true); 
        var ResourceValidation = GetObjectReference('frmGanttChartView','hidResourceValidation'); 
        var ResourceStartDate;
        var ResourceEndDate;    
        //Added By VijayD To Validate the Pagging Number   On 25 August 2009           
        var objtxtpageNumber =  GetObjectReference('frmGanttChartView','txtPageNumber');
        var objtxtNoOfPages = GetObjectReference('frmGanttChartView','txtNoOfPages');
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
                    objHidtxtARID=GetObjectReference('frmGanttChartView','hidTxtARID'); 
                    objHidtxtATTID=GetObjectReference('frmGanttChartView','hidTxtTTID'); 
                    objHidtxtAPR=GetObjectReference('frmGanttChartView','hidTxtAPR');
                    var objhidTxtASTA=GetObjectReference('frmGanttChartView','hidTxtASTA'); 
                  
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
                    //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
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
                //End of added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883) 

                  if(ResourceValidation)
                      if(ResourceValidation.value == "True")
                      {
                          var objhr=GetObjectReference('frmGanttChartView','hrAR');  
                          
                        
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
                          }  
                          objstartDate = GetObjectReference('frmGanttChartView','L|' + objchkSelect[i].value); 
                          objEndDate = GetObjectReference('frmGanttChartView','R|' + objchkSelect[i].value); 
                               
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
    
    //Commented AND Added By VijayD On 29 August 2009
    //Added by Shraddha M on 25,May 2009 for Approve,close and on-Hold project validation3
    /*       if(IsProjectApproved)
       if(IsProjectApproved.value == "False")
       {
            alert('You cannot create a task since Project is not Approved.');
            return false;
       }
    */ 
    var IsProjectApproved = GetObjectReference('frmGanttChartView','hidIsProjectApproved'); 
    var IsProjectOnHold = GetObjectReference('frmGanttChartView','hidIsProjectOnHold'); 
    var IsProjectOver = GetObjectReference('frmGanttChartView','hidIsProjectOver');     
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
       
            //End Comment AND Addition By VijayD On 29 August 2009
            if(IsProjectOnHold)
                if(IsProjectOnHold.value == "True")
                {
                    alert('Project related activities such as adding Task entry cannot be performed as the Project is On-Hold');
                    return false;
                }
            if(IsProjectOver)
                if(IsProjectOver.value == "True")
                {
                    alert('Project related activities such as adding Task entry cannot be performed as the Project is Closed');
                    return false;
                }       
        }
    //Ended by Shraddha M
        return true;
    }
    function txtWork_OnBlur(objCurrentWork,TaskID,ParentTaskID)
    {

        objActualWork = GetObjectReference('frmGanttChartView','txtActualWork'+TaskID);
        objOrgWork = GetObjectReference('frmGanttChartView','txtOrgWork'+TaskID);
    
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
    }//end  if(TaskRistValidation == "True")
	
    //Added by Shraddha M on 22,May 2009 for validate dates and hrs.
	
    objstartDate = GetObjectReference('frmGanttChartView','L|' + TaskID); 
    objEndDate = GetObjectReference('frmGanttChartView','R|' + TaskID); 
    //objWorkHrs = GetObjectReference('frmGanttChartView','txtWork'+ TaskID); 
    startDate = objstartDate.value;
    EndDate = objEndDate.value;    
     
    startDate  = GetFormat(startDate ,'dd-mmm-yyyy','MM/DD/YYYY');
    EndDate  = GetFormat(EndDate ,'dd-mmm-yyyy','MM/DD/YYYY');       
    
    CNTDateDiff = DateDiff(startDate,EndDate,"d") + 1;
    CNTDateDiff = parseFloat(CNTDateDiff);
    WorkHrs = parseFloat(objCurrentWork.value);   
      
    if(objCurrentWork)
    { 
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
    if(objOrgWork!=null)
        objTotalAllocatedTaskLCE = parseFloat(objOrgWork.value);		
						
    if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
	    {
	        var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
		    alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
		    setFocus(objCurrentWork);
		    return;
		}
    //End Modification by SavitaS for TechUnified Issue ID-1257				
    // END : Integrated by ParagD On 14-Aug-2006 for PMLifeLine
		
    //Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
    /* if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
    {
        var dblBalancedHrs;
        dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
			strMsg = "<%=MyBase.GetResourceString("ASSIGNEDTASKS_WORKHOURS_NOT_MORE_THAN_PROJECT_WORKHOURS")%>";
		    strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
		    strMsg = replaceSubstring(strMsg, "<==>", CWork.toFixed(2));
		    alert(strMsg);
		    return false;
		}*/
    ///////////////////////////////////////////////////////////////////
	
        if(IsCaseOneProject=="False")
        {

            //var PlannedHours = GetObjectReference('frmGanttChartView','hidAllChildTaskWork'+ ParentTaskID, true);
            var PlannedHours = GetObjectReference('frmGanttChartView','hidAllChildTaskWork'+ ParentTaskID);
            var objParentTask= GetObjectReference('frmGanttChartView','hidParentTaskWork'+ParentTaskID);
            var objhidChildTaskWork=GetObjectReference('frmGanttChartView','hidChildTaskWork'+TaskID);
            var objhidParentTaskActualWork=GetObjectReference('frmGanttChartView','hidParentTaskActualWork'+ParentTaskID);
	    
            if(PlannedHours!=null)
            {
                var intCnt, ChildPlanned=0, TotalChildplanned=0;
                /*	for (intCnt=0; intCnt < PlannedHours.length; intCnt++)
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
        objfrm.action="../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
        objfrm.submit();
    } 
    function Page_Onclick(PageNumber)
    {	
        // Modified by SandipL on 3 Feb 2006 
        strLocation = "../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=" + String(parseInt(PageNumber))+"&GanttChartType=<%=m_strGanttView%>";

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
        strLocation = "../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1";

        objfrm.action = strLocation
        objfrm.submit(); 
    }
}    
function GanttView_OnChange()
{
    strLocation = "../Home/GanttChartView.aspx?From_Where=HRHome";

    objfrm.action = strLocation
    objfrm.submit(); 

}
function CreateRowForTasks()
{
	
    var objTotalAllocatedTaskLCE;
    var CWork = parseFloat(<%=m_dblOUWorkingHrs%>);
		    var objTotalAllocatedTaskLCE = parseFloat(<%=m_dblProjectTaskTotal%>);		
						
    if(CWork + objTotalAllocatedTaskLCE > parseFloat("<%=m_dblTotalLCE%>"))
    {
        var dblBalancedHrs = <%=m_dblTotalLCE%> - objTotalAllocatedTaskLCE
		        alert("The total work (hours) of the assigned tasks should not exceed the project work hours.Balanced work hours are "+ dblBalancedHrs);
		        return;
		    }
		
    //noOfRows = noOfRows + 1;
            var objTbl = GetObjectReference('frmGanttChartView','tblGanttTask');
            var objItemCount = GetObjectReference('frmGanttChartView','txtItemCount');
            var objtxtPreItemCount=GetObjectReference('frmGanttChartView','txtPreItemCount');
			
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
            NewTD.align='left';
            NewTD.width='20%';
            NewTD.className='clsTDBlank'
    //strHTML= "<td class='clsTDBlank'><IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
            strHTML= "<IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+intPreItemCount+")'>";
    //NewTD.innerHTML= strHTML+"</td>";
            NewTD.innerHTML= strHTML;
						
				
            NewTD = NewTR.insertCell(1);
            NewTD.align='left';
            NewTD.className='clsTDBlank'
			
    //NewTD.innerHTML = "<td class='clsTDBlank' style='align:left;text-align:left;' ><Input type=textbox name=txtTaskName_"+String(intPreItemCount)+" id=txtTaskName_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:200px;text-align:Left' maxlength=255 onkeyup='txtTask_OnKeyup(this,event)' /></td>";	
            NewTD.innerHTML = "<Input type=textbox name=txtTaskName_"+String(intPreItemCount)+" id=txtTaskName_"+String(intPreItemCount)+" value='' class=clsTextBox style='width:200px;text-align:Left' maxlength=255 onkeyup='txtTask_OnKeyup(this,event)' />";	
			
			
            for(i=2;i<=14;i++)
            {
                if(i >4 && "<%=m_strGanttView %>"=="1" )
		            break;
			    
		        if(i >9 && "<%=m_strGanttView %>"=="5" )
		            break;
			            
		        NewTD = NewTR.insertCell(i);
		        NewTD.align='left';	
		        NewTD.className='clsTDBlank'
		        //NewTD.innerHTML = "<td class='clsTDBlank'></td>"
		        NewTD.innerHTML = "&nbsp;"
			    		
		    }
                    
			   
			    
            setSectionRowCount(1,intPreItemCount);
            var objtxt=GetObjectReference('','txtTaskName_'+String(intPreItemCount));
            setFocus(objtxt);
        }
        function setSectionRowCount(flag,noOfRows)
        {
            var objtxtItems=GetObjectReference('frmGanttChartView','txtItems');
            var objItemCount = GetObjectReference('frmGanttChartView','txtItemCount');
            var objtxtPreItemCount=GetObjectReference('frmGanttChartView','txtPreItemCount');
			
			
			
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
	
            var objTbl = GetObjectReference('frmGanttChartView','tblGanttTask');
            var objtxtItemCount=GetObjectReference('frmGanttChartView','txtItemCount');
            var rowNo=objImg.parentElement.parentElement.rowIndex
			
            objTbl.deleteRow(rowNo);
            setSectionRowCount(0,rowID);
			
        }
        function optTaskType_OnClick()
        {
            strLocation = "../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1";

            objfrm.action = strLocation
            objfrm.submit(); 
        }
		
		
		    
        function AHref_OnClick(HrefID,e)
        {
		
            var objdiv,objhr;
	
            if(HrefID=="hrAR")
            {
                objdiv=GetObjectReference('frmGanttChartView','divAR');
                objhr=GetObjectReference('frmGanttChartView','hrAR');    
            }
            //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
            if("<%=m_intFlag%>"=="1" && HrefID=="hrUS")
		 {
 		     
		     objdiv=GetObjectReference('frmGanttChartView','divUS');
		     objhr=GetObjectReference('frmGanttChartView','hrUS');    
		     
		 }
		     //End of added by NitinC on 08 Dec 2011 for PMLifeLine(Issue Fix : 55883)
		 else if (HrefID=="hrATT")
		 {
		     objdiv=GetObjectReference('frmGanttChartView','divATT');
		     objhr=GetObjectReference('frmGanttChartView','hrATT'); 
		 }
		 else if(HrefID=="hrAP")
		 {
		     objdiv=GetObjectReference('frmGanttChartView','divAP');
		     objhr=GetObjectReference('frmGanttChartView','hrAP'); 
		 }
		 else if(HrefID=="hrView")
		 {
		     objdiv=GetObjectReference('frmGanttChartView','divView');
		     objhr=GetObjectReference('frmGanttChartView','hrView'); 
		 }
		 else if(HrefID=="hrASTA")
		 {
		     objdiv=GetObjectReference('frmGanttChartView','divSTA');
		     objhr=GetObjectReference('frmGanttChartView','hrASTA');
		     objhratt=GetObjectReference('frmGanttChartView','hrATT');  
		       
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
             //e.stopPropagation();
             objevent.stopPropagation();
         //End of Comment and Addition by Dhanashri S on 17 June 2015 
   
  
         return false;
  
     }
     function Attribute_OnClick(sID,sText,HrefID,ResourceStartDate,ResourceEndDate)
     {
         var objdiv,objhr,objHidtxtAtt;
		
         if(HrefID=="hrAR")
         {
             objdiv=GetObjectReference('frmGanttChartView','divAR');
             objhr=GetObjectReference('frmGanttChartView','hrAR');  
             objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtARID');  
		      
		      
             if(objhr)
             {	      
                 objhr.setAttribute('ResourceStartDate',ResourceStartDate);
                 objhr.setAttribute('ResourceEndDate',ResourceEndDate);
             }
		        
         }
         //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
         if("<%=m_intFlag%>"=="1" && HrefID=="hrUS")
		     {
		        
		         objdiv=GetObjectReference('frmGanttChartView','divUS');
		         objhr=GetObjectReference('frmGanttChartView','hrUS'); 
		         objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtUSID'); 
		        
		     }
		         //End of added by NitinC on 08 Dec 2011 for PMLifeLine(Issue Fix : 55883) 
		     else if (HrefID=="hrATT")
		     {
		         objdiv=GetObjectReference('frmGanttChartView','divATT');
		         objhr=GetObjectReference('frmGanttChartView','hrATT'); 
		         objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtTTID'); 
		          
		        
		         
		     }
		     else if (HrefID=="hrAP")
		     {
		         objdiv=GetObjectReference('frmGanttChartView','divAP');
		         objhr=GetObjectReference('frmGanttChartView','hrAP'); 
		         objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtAPR');
		        
		     }
		     else if (HrefID=="hrView")
		     {
		         objdiv=GetObjectReference('frmGanttChartView','divView');
		         objhr=GetObjectReference('frmGanttChartView','hrView'); 
		         objHidtxtAtt=GetObjectReference('frmGanttChartView','cboViews');
		        
		     }
		     else if (HrefID=="hrASTA")
		     {
		         objdiv=GetObjectReference('frmGanttChartView','divSTA');
		         objhr=GetObjectReference('frmGanttChartView','hrASTA'); 
		         objHidtxtAtt=GetObjectReference('frmGanttChartView','hidTxtASTA');
		        
		     }
		    //objhr.innerHTML=sText;
		     objhr.value=sText;
		     objdiv.style.display='none';
		    
		     if (HrefID=="hrATT" && IsCase3Project=="True")
		     {
		         var objhr1=GetObjectReference('frmGanttChartView','hrASTA'); 
		         if(objhr1!=null) 
		             objhr1.value='';
		         loadXMLDoc("../Home/AJAXHttp.aspx?MasterTagID=1038","TaskTypeID="+sID);
		         
		     }
			
			
		     if(objHidtxtAtt!=null)
		         objHidtxtAtt.value=sID;
		            
		     if (HrefID=="hrView") 
		     {
		         objhr.title=sText;
		         objfrm.action="../Home/GanttChartView.aspx?From_Where=HRHome&PageNumber=1";  
		         objfrm.submit();
		     }         
		     
		    
         }
         function SelectOnClick(objSelect)
         {
             if(objSelect!=null)
             {
                 var objtxtWork=GetObjectReference('frmGanttChartView','txtWork'+objSelect.value);  
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
                     objtrAssig.style.display='';
                     objimgAssig.src='../../Images/minus.gif';
                    
                     //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
                     if("<%=m_intFlag%>"=="1")
                    {
                        objtrUSAssig.style.display='';
                        objimgAssig.src='../../Images/minus.gif';
                    }
		               //End of added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)

                    
                    window_onLoad(); 
                }
		                
            } 
        }
		
        function ShowEntityEditMode(intPKId,m_strToken)
        {
            //var strFilter;
			
            //strFilter = GetFilterQueryString();
            //" + strFilter + "
            if("<%=m_strTagID%>"=="1038")		// Added By VijaYD &GanttChartType=<%=m_strGanttView%>
		        window.open ("../PM/PM_TaskAssignment.aspx?TaskId=" + intPKId + "&Mode=Edit&MasterTagID=<%=m_strTagID%>&PkToken=" + m_strToken+"&PageType=GanttChart&GanttChartType=<%=m_strGanttView%>&FROMGANTTCHART=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=600");
	        else if("<%=m_strTagID%>"=="34")		    
	            window.open ("../General/CommonPage.aspx?MilestoneID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			else if("<%=m_strTagID%>"=="661")		    
			    //Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 
			    //window.open ("../General/CommonPage.aspx?SubProjectID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    window.open ("../PM/SubProject_CommonPage.aspx?SubProjectID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    //End of Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 
			else if("<%=m_strTagID%>"=="2133")		    
			    window.open ("../General/CommonPage.aspx?ScheduleID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			else if("<%=m_strTagID%>"=="1019")
			    //Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 		    		    		    
			    //window.open ("../General/CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    window.open ("../PM/Resources_CommonPage.aspx?ProjectEmployeeRoleId_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");
			    //End of Commented and added by NitinC on 20 April 2011 for PMLifeLine after sub projects page is inherited 
			else if("<%=m_strTagID%>"=="454")		    
			    window.open ("../General/CommonPage.aspx?ModuleID_PK=" + intPKId + "&MasterTagID=<%=m_strTagID%>&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FROMGANTTCHART=1&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=500");    
			    
		    //
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

function txtTask_OnKeyup(objtxtTask,e)
{ 
    if (objtxtTask.value.length>0) 
    {
        if(disallowBlank(objtxtTask,"Please enter task name!",true))
        {     
            objtxtTask.value="";
            // alert("Please enter task name!")    
            return;
        }
    }
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
	       
            var objOrgWork = GetObjectReference('frmGanttChartView','txtOrgWork',true);
            var i,TaskID;
            for (i=0;i<objOrgWork.length;i++)
            { 
                TaskID=objOrgWork[i].name;
                TaskID=TaskID.replace('txtOrgWork','');                       
                       
                var objCurrentWork=GetObjectReference('frmGanttChartView','txtWork'+TaskID);	          
                objCurrentWork.disabled=false;
            }  
        }
        //End Of Addition by AmitJ
		
        strLocation = "../Home/GanttChartView.aspx?From_Where=HRHome&Mode=Save";

        objfrm.action = strLocation
        objfrm.submit(); 
    } 
   
}

function HideShowFilter()
{
    var objtrFilter=GetObjectReference('','trFilter');
    var objimgFilter=GetObjectReference('','imgFilter');
    if(objtrFilter.style.display=='none')
    {
        objtrFilter.style.display='';
        objimgFilter.src='../../Images/minus.gif';
    }
    else
    {
        objtrFilter.style.display='none';
        objimgFilter.src='../../Images/plus.gif';
    }
    window_onLoad();
}
var objtrAssig=GetObjectReference('','trAssig');
var objimgAssig=GetObjectReference('','imgAssig');
 
//Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
if("<%=m_intFlag%>"=="1")
 {		    
     var objtrUSAssig=GetObjectReference('','trUSAssig');
    
 }
 //End of added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
 
 function HideShowAssignment()
 {
   
     if(objtrAssig.style.display=='none')
     {
         objtrAssig.style.display='';
         objimgAssig.src='../../Images/minus.gif';
         objdivlist.onscroll=Scroll;
         Scroll();	
     }
     else
     {
         objtrAssig.style.display='none';
         objimgAssig.src='../../Images/plus.gif';
     }
    
     //Added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
     if("<%=m_intFlag%>"=="1")
    {		    
        if(objtrUSAssig.style.display=='none')
        {
            objtrUSAssig.style.display='';
            objimgAssig.src='../../Images/minus.gif';
            objdivlist.onscroll=Scroll;
            Scroll();	
        }
        else
        {
            objtrUSAssig.style.display='none';
            objimgAssig.src='../../Images/plus.gif';
        }
    }
    //End of added by NitinC on 08 Dec 2011 for PMLifeLine (Issue Fix : 55883)
    window_onLoad();
}

/************************ Added By VijayD 25 May 2009********************************
        Purpose: To validate Task assignment for baseline
 ************************ ***********************************************************/
var strResult="";
var brw = isIE();
function ValidateTask_Baseline(url) 
{ 		
    // TO SEE IF WE ARE RUNNING IN IE 
    strNavigator = navigator.appName;
    strNavigator = strNavigator.toUpperCase();
               
    //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
    //if (strNavigator == 'MICROSOFT INTERNET EXPLORER')
    if (brw == "IE")
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
						
        if ( g_objXHttp.responseText != null && g_objXHttp.responseText!="")
        {
                               
            xmlDoc= document.implementation.createDocument("","",null);
            xmlDoc.async=false;
            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
            if (brw == "FF")
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
				 
            //Commented and added by Nilesh g on 10/12/2015 for issue id 2721
            //if (window.ActiveXObject)
            if (brw=="IE")
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
                //added by Nilesh g on 10/12/2015 for issue id 2721
                if (brw == "FF")
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
		 
    var objOrgWork = GetObjectReference('frmGanttChartView','txtOrgWork'+TaskID);
    if(objOrgWork!=null)
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
            var strURL;
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
 
	
    </script>
</body>
</html>
