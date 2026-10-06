<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuickView_Popup.aspx.vb" Inherits="PbNIT.QuickView_Popup" %>
<html >
<%  CommonFunctions.General.PlotPageHeadTag("My Arena")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<script type='text/javascript' src='../Home/homeTree.js'></script>

 <body  onresize="window_onresize()" onload="window_onload()">
    <form id="frmQuickView_Popup"  method="post" runat="server" >
			<%PageInit()%>
			<div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%">
            </div> 
			<div id="pleasewaitscreen" name="pleasewaitscreen" style="position:absolute;z-index:105;top:30%;left:35%;display:none;">
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



    </script>
</body>
</html>
