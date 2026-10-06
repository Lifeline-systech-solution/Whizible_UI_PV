<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyArena.aspx.vb" Inherits="PbNIT.MyArena" %>
<html >
<%  CommonFunctions.General.PlotPageHeadTag("My Arena")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<script type='text/javascript' src='../Home/homeTree.js'></script>

 <body class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmMyArena"  method="post" runat="server" >
			<%PageInit()%>
			<div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%">
            </div> 
			<div id="pleasewaitscreen"  name='pleasewaitscreen' style="position:absolute;z-index:105;top:30%;left:35%;display:none;">
            <table class="clsTable" border=1 cellpadding="0" cellspacing="0" height="200" width="300">
                <tr class="clsTRBlank">
                    <td width="100%" height="100%" align="center" valign="middle">
                        <br/><br/>   
                        <img src="../../Images/wait.gif" alt="Waiting" />
                        <b>Processing...  please wait...</b>
                        <br/><br/>
                    </td>
                </tr>
            </table>
        </div>			

    </form>
    <script language=javascript >
    
    function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			
			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop-15;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop-15;
		    }
			objdivlist.style.height = intDivHeight +'px';	
			
			if (intDivHeight < 100)	intDivHeight = 100;
			
			}	
			
			TabOnClick(1);
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 15 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 15;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			
			objdivlist.style.height = intDivHeight +'px';	}
		}
    
    function TabOnClick(intFlag)
    {
        var Mode = (arguments.length>1)?arguments[1]:"0";
        var  objWait = document.getElementById('pleasewaitscreen');//GetObjectReference('frmMyArena','pleasewaitscreen');
        //alert(document.getElementById('pleasewaitscreen'));
        var objForm=GetFormReference('frmMyArena');
        if (Mode == "0")
        {
            window.setTimeout('TabOnClick('+intFlag+',"1")',1)            
        }   
        if  (Mode == "1")
        {
            var objTabs=GetObjectReference('','li_Arena',true);
            var objtd_iframe=GetObjectReference('','td_iframe');
            
            objWait.style.display="";
            document.getElementById('fillDiv').style.display=""; 
            
            for(i=0;i<objTabs.length;i++)
            {
             
                if(i==intFlag)
                {
                    objTabs[i].className='selected';
                    objTabs[i].style.textDecorationNone=true;
                    intFlag=i; 
                }
                else
                {
                    objTabs[i].className='';
                    objTabs[i].style.textDecorationNone=false;
                }
            }
        
            switch (intFlag)
            {
                case 0 :
                    document.getElementById("frmMain").src='../General/CommonPage.aspx?MasterTagID=1085&ParentTagID=0';
                    break;
                case 1 :
                    document.getElementById("frmMain").src='../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI';
                    break;
                case 2 :
                    document.getElementById("frmMain").src='../DB/Alerts_CommonList.aspx?MasterTagID=3707&ParentTagID=0';
                    break;                
                case 3 :
                    document.getElementById("frmMain").src='../HR/MyLeaves_CommonList.aspx?MasterTagID=1208';
                    break;
                case 4 :
                    document.getElementById("frmMain").src='../Home/MyExpenses.aspx?ShortName=TabUI&FromWhere=TABUI';
                    break;
            }
        }
    }
    function calcHeight()
	{	
	    var height=window.innerWidth;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	     	
	    document.getElementById("frmMain").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-20)+"px";
	    document.getElementById("pleasewaitscreen").style.display="none";
	    document.getElementById("fillDiv").style.display="none";
		        //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-65)+"px";	  
        //ShowHideViews();
	}

function ShowSubTag(TabIndex)
{
    var objTabs=GetObjectReference('','li_Arena',true);
    /*for(i=0;i<objTabs.length;i++)
    {
        if(i==TabIndex)
        {
            objTabs[i].className='selected';
            objTabs[i].style.textDecorationNone=true;
            intTabIndex=i; 
        }
        else
        {
            objTabs[i].className='';
            objTabs[i].style.textDecorationNone=false;
        }
    }*/
}

function cboDashboard_OnChange()
	// For selecting the user's e-DB 
	{
		var strPageName;
		var arr;
		var objcboDashboard;
		objcboDashboard = GetObjectReference('GraphOutlook','cboDashboard');
		
		strPageName = objcboDashboard.value;
	
		if (trimString(strPageName + "") != "") 
		{
			arr = strPageName.split("|");
			
			if (isSubstringExists(arr[0],'?'))
			{
				window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
			}
			else
			{
				window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
			}
			
		}
		else
		{
			var lnk = window.location.href ;
			var arrlnk = lnk.split("?")
			var arrDashboardID= arrlnk[1].split("&");
			var arrIDs = arrDashboardID[0].split("=");
			window.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=Home%3FID=" + arrIDs[1]+"%26amp;DB=|0"; 	
		}
	 
	}
    </script>
</body>
</html>
