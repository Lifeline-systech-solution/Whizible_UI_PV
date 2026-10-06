<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Tab_Viewpage.aspx.vb" Inherits="PbNIT.Tab_Viewpage" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Alerts")%>
	<link rel='stylesheet' type='text/css' href='../General/tab-view.css'/>
	<style>
		A.clsSelected {
			color: #000 !important;
		}
			A.clsSelected:hover {
				color: #000 !important;
			}
	</style>
	<Script language="javascript">
	
	// this will resize the iframe every
	// time you change the size of the window.
	//window.onresize=calcHeight;      
    
	function calcHeight()
	{	
	    var height=window.innerWidth;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	     	
	    document.getElementById("iTabDetails").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop)+"px";
	}
	
	var objTabs=GetObjectReference('','Tabs',true)
	 //GetObjectReference('','cmbHidGO',true);
	
	function window_onresize()
    {
        calcHeight();
    }
    function window_onload()
    {
         var URL = GetObjectReference('','hidDefaultPageURL');
         document.getElementById("iTabDetails").src=URL.value;
         
    }

	function Change_CSS(obj,TabID,RowNo,ColNo,PageName)
		{
		    document.getElementById("iTabDetails").src=PageName;
			
			obj=GetObjectReference('','Tab_'+String(TabID));
			
			var objtxtRTabID=GetObjectReference('','txtRTabID'+String(TabID));
			var objtxtCTabID=GetObjectReference('','txtCTabID'+String(TabID));
			
			if(objTabs!=null)
			{
				for(i=0;i<=objTabs.length-1;i++)
				{
					if(objTabs[i].className=='selectedTab')
					{
							objTabs[i].className='';
							break;	
					}		
				}
			}
			 
			if(obj!=null)
				obj.className='selectedTab';
			
			/*if(objtxtRTabID.value==1)
				Move_Tabs(TabID,RowNo,ColNo,String(parseInt(objtxtRTabID.value)+1)+String(objtxtCTabID.value));*/
					
		}
		
		//added by SuchitraP on 22-Aug-2008 for Alert Change
		function Tab_OnClick(AlertType)
		{
		    var PageName;
		    var obj=GetObjectReference('','Tab_'+AlertType);
		    		    
		    if(AlertType=='HelpdeskAlert')
		    {
		        PageName='../DB/Alerts_CommonList.aspx?MasterTagID=3707&ParentTagID=0';
		    }
		    else if(AlertType=='ProjectAlert')
		    {
		        //Commont and modification by SuchitraP on 3-Nov-2008
		        //PageName='../General/CommonList.aspx?FromWhere=&MasterTagID=3939';
		        PageName='../PM/PM_CreateEmployeeWiseAlerts.aspx';
		        //End by SuchitraP
		    }
		    else
		    {
		        PageName='../PM/PM_OutlookConfiguration.aspx';
		    }
		    document.getElementById("iTabDetails").src=PageName;
		    
		    if(objTabs!=null)
			{
				for(i=0;i<=objTabs.length-1;i++)
				{
					if(objTabs[i].className=='clsSelected')
					{
							objTabs[i].className='';
							break;	
					}		
				}
			}
			
			if(obj!=null)
				obj.className='clsSelected';
		}
		//End by SuchitraP
	
	
	 function Move_Tabs(TabID,RowNo,ColNo,txtTabValue)
	 {

				var objtxtRC=GetObjectReference('','txtRC'+String(txtTabValue));
			
				var objSelectedTab=GetObjectReference('','Tab_'+String(TabID));
				var objReplacementTab=GetObjectReference('','Tab_'+String(objtxtRC.value));
				var objtxtSTabID=GetObjectReference('','txtRTabID'+String(TabID));
				var objtxtRTabID=GetObjectReference('','txtRTabID'+String(objtxtRC.value));
				
				if(objSelectedTab!=null && objReplacementTab!=null)
				{
					var strSHREF=objSelectedTab.href;//'javascript:Change_CSS(this,'+TabID+','+ (parseInt(RowNo)+1) +','+ColNo+',"'+PageName+'")';
					var strSIH=objSelectedTab.innerHTML;
					var strSTitle=objSelectedTab.title;

					var strRHREF=objReplacementTab.href;//'javascript:Change_CSS(this,'+String(objtxtRC.value)+','+RowNo+','+ColNo+',"'+PageName+'")';
					var strRIH=objReplacementTab.innerHTML;
					var strRTitle=objReplacementTab.title;
					
					objReplacementTab.href=strSHREF;
					objReplacementTab.id='Tab_'+String(TabID);
					objReplacementTab.innerHTML=strSIH;
					objReplacementTab.title=strSTitle;
					objReplacementTab.className='selectedTab';
																				
					objSelectedTab.href=strRHREF;
					objSelectedTab.id='Tab_'+String(objtxtRC.value)
					objSelectedTab.innerHTML=strRIH;
					objSelectedTab.title=strRTitle;
					objSelectedTab.className=''
									
										
					//document.getElementById("iTabDetails").src=strHREF;
					
				}
				objtxtRTabID.value="1";
				objtxtSTabID.value="2";		
			
	 }
	 function refreshTabs(QStr)
	 {	 
	    if(window.location.href.match(QStr) == null)
	        window.location.href = window.location.href + QStr;
	           
	 }
	 function showHide_divGadget(divName)
	 {
	    var ObjImg = GetObjectReference('frmTabviewPage','imgGadget');
	    var ObjDiv = GetObjectReference('frmTabviewPage',divName);
	    var IsCollapse = ObjImg.getAttribute("Collapse");
	    
	    if(IsCollapse=="N")
	    {		 
		    ObjImg.src='../../Images/plus.gif';
		    ObjDiv.style.display='none';
		    ObjImg.setAttribute("Collapse","Y");
	    }
	    else if(IsCollapse=="Y")
	    {		 
		    ObjImg.src='../../Images/minus.gif';		
		    ObjDiv.style.display='';
		    ObjImg.setAttribute("Collapse","N");
	    }
	 }
	 
	   </script>
	<body MS_POSITIONING="GridLayout" class="clsBody" background-color:"#D3E4FB;" onload='window_onload()' onresize='window_onresize()' >
		<form id="frmTabviewPage" method="post">
		<%PageInit()%>
		</form>
		<Script language="javascript">
		//var objTabs=GetObjectReference('frmTabviewPage','Tabs',true)
		
	   </script>
	
	  
	   
	</body>
	
</html>