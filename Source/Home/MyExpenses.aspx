<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyExpenses.aspx.vb" Inherits="PbNIT.MyExpenses" %>
<html >
<%  CommonFunctions.General.PlotPageHeadTag("My Arena")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<script type='text/javascript' src='../Home/homeTree.js'></script>

 <body  onresize="window_onresize()" onload="window_onload()">
    <form id="frmMyExpenses"  method="post" runat="server" >
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
        var  objWait = GetObjectReference('frmMyExpenses','pleasewaitscreen');
        var objForm=GetFormReference('frmMyExpenses');
        if (Mode == "0")
        {
            window.setTimeout('TabOnClick('+intFlag+',"1")',1)            
        }   
        if  (Mode == "1")
        {
            var objTabs=GetObjectReference('','li_MyExpenses',true);
            var objtd_iframe=GetObjectReference('','td_iframe');
            
            objWait.style.display="block";
            document.getElementById('fillDiv').style.display="block"; 
            
            for(i=0;i<objTabs.length;i++)
            {
             
                if(i==intFlag)
                {
                    objTabs[i].className='selectedtab';
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
                    document.getElementById("frmMain").src='../EWF/EWF_ExpenseEntryList.aspx?FromWhere=DT&MasterTagId=3556';
                    break;
                case 1 :
                    document.getElementById("frmMain").src='../EWF/MyExpenseSheet_CommonList.aspx?FromWhere=DT&MasterTagId=3593';
                    break;
                case 2 :
                    document.getElementById("frmMain").src='../EWF/ExpenseSheetApproval_CommonList.aspx?FromWhere=DT&MasterTagId=3595';
                    break;                
                case 3 :
                    document.getElementById("frmMain").src='../EWF/EscalatedExpenseSheets_CommonList.aspx?FromWhere=DT&MasterTagId=3596';
                    break;
                case 4 :
                    document.getElementById("frmMain").src='../EWF/FinanceApproval_CommonList.aspx?FromWhere=DT&MasterTagId=3597';
                    break;
                case 5 :
                    document.getElementById("frmMain").src='../EWF/ExpenseBifurcation_CommonList.aspx?FromWhere=DT&MasterTagId=3598';
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

    </script>
</body>
</html>
