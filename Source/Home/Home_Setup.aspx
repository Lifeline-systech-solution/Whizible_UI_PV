<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home_Setup.aspx.vb" Inherits="PbNIT.Home_Setup" %>

<html >
<%  CommonFunctions.General.PlotPageHeadTag("Home")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<link rel='stylesheet' type='text/css' href='../General/tab-view.css'/> 
<script type='text/javascript' src='../Home/homeTree.js'></script>

<body id='tab1' class='clsBody'  onresize="window_onresize()" onload="window_onload()">
		<form id="frmHome" method="post"  runat="server"  > <!-- onclick="hideFloatingFrame()"-->
           <!-- <asp:Panel ID="Panel1" runat="server" Height="50px" Width="879px" BackColor='lightblue' style="border-bottom :lightblue 1px outset;"   >
            </asp:Panel>-->
			<%PageInit()%>
			<iframe id="iFloatingMenu" style="display:none;z-index:100; position:absolute;overflow:visible" ></iframe>
    </form>
    

    
   
<script language="javascript">
    var objform=GetFormReference('frmHome');
    var objDivMain=GetObjectReference('frmHome','divMain');
    var objdivTab=GetObjectReference('frmHome','divTab');
    var xmlhttp;
    var objhidPageURL=GetObjectReference('frmHome','hidDefaultPageURL');
    var objhidtagid=GetObjectReference('frmHome','hidDefaultTagID');
    var objhidcontrolitemid=GetObjectReference('frmHome','hidDefaultControlItemID');
    var objimgfav=GetObjectReference('frmHome','imgFav');
    var objdivHeader=GetObjectReference('frmHome','divHeader');
    var objcboTheme=GetObjectReference('frmHome','cboTheme');
    var showFloatingmenu='0';
   	var ie5=document.all&&document.getElementById
    var ns6=document.getElementById&&!document.all
    
    var objFrame=GetObjectReference('','iFloatingMenu');
        
   function calcHeight()
	{	
	    var height=window.innerWidth;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	     	
	    document.getElementById("frmMain").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-40)+"px";
	    document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-65)+"px";	  
	}
	
	function TabGroupOnClick(GroupTabID)
	{
	    var URL='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	    
	    loadXMLDoc(URL,'')
	    
	  // objform.action='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	  // objform.submit();
	}
	function TabItemOnClick(PageName,TagID,ControlItemID)
	{
	    /*var URL='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&TabGroupItemID='+TabGroupItemID+"&GroupTabID="+TabGroupID;
	     loadXMLDoc(URL,'');*/
	     if(TagID==1 || TagID==654 || TagID ==428 )
	     {
	        if(TagID==1) index=0;
	        if(TagID==654) index=1;
	        if(TagID==428) index=2;
	        
	        ShowModules(index)
	        return;
	     }
	     
	      var objTab=GetObjectReference('','atab_'+TagID);
	     var objAllTab=GetObjectReference('','atab',true);
	  
	     if(objAllTab!=null && objTab!=null)
	     {
	  
	        for(i=0;i<objAllTab.length;i++)
	        {
	        
	            objAllTab[i].className='';
	        }
	     }
	      if(objTab!=null )
	            objTab.className='selectedTab';//'tabSelected';//'selectedTab';
	            
	     document.getElementById("frmMain").src=PageName;
	     objhidPageURL.value=PageName;
	     objhidtagid.value=TagID;
	     objhidcontrolitemid.value=ControlItemID;
	     
	     if(objcboTheme!=null)
	        objcboTheme.value='';
	      DrawFavImage();
	      
	      calcHeight();
	}
	
	function window_onresize()
    {   	    
        var height=window.innerWidth;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	    	   	   
        calcHeight();
        
    }
    function window_onload()
    {
   
       var intDivHeight=0;

		    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop+50 ; //130
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop+50;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
					
					 
					var height=window.innerWidth;//Firefox
   	  	            if (document.body.clientHeight)
	                {
		                height=document.body.clientHeight;//IE
	                }
	                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-65)+"px";
	                
				objDivMain.style.height = intDivHeight+"px";
			   
			}		
			/*if(ns)
			{*/
			    var URL = GetObjectReference('','hidDefaultPageURL');
                document.getElementById("frmMain").src=URL.value;
             //}   
             	
            //Commented By Amol Changle On: 03 Apr 2009
            //DrawFavImage();
            var objtxtSearch=GetObjectReference('','txtSearch');
            setFocus(objtxtSearch);
           //ShowHideViews();
    }

    function DrawFavImage()
    {   
       var objimgfav=GetObjectReference('frmHome','imgFav');
        if(objhidcontrolitemid.value!="" && objhidcontrolitemid.value!="0")
        {
            objimgfav.src='../../Images/Home/favorites-.gif';
            objimgfav.title='Remove from favourites';
            //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"D")';
        }   
        else
        {
             objimgfav.src='../../Images/Home/favorites+.gif';
             objimgfav.title='Add to favourites';
             //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"A")';
        }
            
    }
 function loadXMLDoc(url,reqQuery,forwhich)
{
// code for Mozilla, etc.
if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    if(forwhich=="FAV")
        xmlhttp.onreadystatechange=state_Change;
     else if(forwhich=="PAGEING")
        xmlhttp.onreadystatechange=Page_state_Change;  
         else if(forwhich=="FAVTAB")   
                xmlhttp.onreadystatechange=FAVTab_state_Change;  
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
             if(forwhich=="FAV")
                xmlhttp.onreadystatechange=state_Change;
             else if(forwhich=="PAGEING")
                xmlhttp.onreadystatechange=Page_state_Change; 
              else if(forwhich=="FAVTAB")   
                xmlhttp.onreadystatechange=FAVTab_state_Change; 
            xmlhttp.open("POST",url,true)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send(reqQuery)
        }
    }
}

function state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
        if(xmlhttp.responseText!="")
           
           { //objdivHeader.innerHTML=xmlhttp.responseText;
             var objtdTabs=GetObjectReference('','tdTabs');
                 
                 if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
           
           } 
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}

//////////////////////////////////
function Page_state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
  {
  // if "OK"
  if (xmlhttp.status==200)
  {
        if(objdivTab!=null)
        {
         objdivTab.innerHTML=xmlhttp.responseText;
         
       
          //  DrawFrameWithURL();
        }        
  }
  else
  {
  alert("Problem in transfering data:" + xmlhttp.statusText)
  }
  }
}
//////////////////////////////////
function Search_OnClick(ev)
{
/*    	strLocation = "Home_Setup.aspx?PageNumber=1";
		
			objform.action = strLocation
    		objform.submit();
*/
var arrNodeValue;
		var TagName;
		var URL;
		var intIndex;
		var HTML;
		var strSearch=document.getElementById("TxtSearch").value;
        var objdivlist=GetObjectReference('frmTree','DivTree');

		NewTree.length=0;
		intCnt=0;
		for(i=0;i<Tree.length;i++)
		{
		    arrNodeValue=Tree[i].split("|");
			TagName=arrNodeValue[2];
			IsChild=arrNodeValue[7];
			if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			{
			    addParentNode(arrNodeValue[1]);
			    NewTree[intCnt]=Tree[i];        
			    intCnt+=1;
            }
        }
        
        if('<%=m_intUseNewUITree.ToString()%>'=='1')
        {
            NoofLinks=NewTree.length;
            MaxNoofPages=parseInt(NoofLinks/ 20) ; 
            if(NewTree.length % 20>0)
                MaxNoofPages+=1;
            objPageNumber.value="1";
            PageOnClick();
            PageNumber=1;
			HTML=createHomeTree(NewTree,StartIndex,EndIndex,1);
			objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
        }
        else
        {
            var objtxtTemplateID = GetObjectReference('','txtTemplateID');
            HTML=createSearchTree(NewTree,strSearch);

            objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
            if(strSearch=="")
            {
            //NodeIndex=GetSelectedNodeIndex(3);
            
/*            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(3,0,arrNode0Values[6]);
            }*/
                if (objtxtTemplateID.value== 'SM')
                    NodeIndex=GetSelectedNodeIndex(1);
                if (objtxtTemplateID.value== 'PRO')
                    NodeIndex=GetSelectedNodeIndex(654);
                if (objtxtTemplateID.value== 'RM')
                    NodeIndex=GetSelectedNodeIndex(428);


            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                if (objtxtTemplateID.value== 'SM')
                    oc(1,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'PRO')
                    oc(654,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'RM')
                    oc(428,0,arrNode0Values[6]);

            }  
            }
            LoadFirstNode(NewTree);
        }    		
}
/*function txtSearch_OnKeyup(evt)
{
 var code;
if (evt.keyCode) code = evt.keyCode;
else if (evt.which) code = evt.which;

if(code==13)
{   objhidPageURL.value=""; 
    Search_OnClick();
}
}*/
function DrawFrameWithURL()
{  
      calcHeight();
         var URL = GetObjectReference('','hidDefaultPageURL');
               
         var objhidtagid=GetObjectReference('frmHome','hidDefaultTagID');
         var objhidcontrolitemid=GetObjectReference('frmHome','hidDefaultControlItemID');
                 
         TabItemOnClick(URL.value,objhidtagid.value,objhidcontrolitemid.value);
                
               
}

if(GetObjectReference('frmAdvancedTimesheet','txtNoOfPages'))
{	
	var noOfPages = GetObjectReference('frmAdvancedTimesheet','txtNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmAdvancedTimesheet','txtPageNumber');
}
function ShowPreviousPage()
{
	/*if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_Onclick(objtxtpageNumber.value);
	}*/
	
  if(objPageNumber.value=="1" || NewTree.length==0)
        alert("This is the first page.");
    else
    {
       objPageNumber.value=parseInt(objPageNumber.value)-1;
       PageOnClick();
    }		
		
}

function ShowNextPage()
{
/*	if (isBlank(objtxtpageNumber.value))
		Page_Onclick(1);
	else
	{  
		
		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}	
			 
		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
				 
		Page_Onclick(objtxtpageNumber.value);
		 
	}
*/
    if(objPageNumber.value==MaxNoofPages || NewTree.length==0 )
        alert("This is the last page.");
    else
       {    
            objPageNumber.value=parseInt(objPageNumber.value)+1;
            PageOnClick();  
       }    
}

//        function Page_Onclick(PageNumber)
//		{     objhidPageURL.value="";
			
//			// Modified by SandipL on 3 Feb 2006 
//			strLocation = "Home.aspx?IsXMLHTTP=1&PageNumber=" + String(parseInt(PageNumber));
//		
//			/*objform.action = strLocation
//			objform.submit();*/
//			
//		    loadXMLDoc(strLocation,'',"PAGEING")

//             objform.submit();
//		}
		
		function PageOnClick()
{
    PageNumber=objPageNumber.value;

    StartIndex=(PageNumber-1)*PageSize;
    EndIndex=(NoofLinks - (PageNumber-1)*PageSize) <  PageSize ?  (NoofLinks - (PageNumber-1)*PageSize) :  PageSize ;

    if(NewTree.length >0 ){

     FirstNodeValues=NewTree[StartIndex].split("|");

    if(!IsProjectSelected  && FirstNodeValues[0]!=32)
    {
        FirstNodeValues=GetProjectListNode().split("|");
    } 

    //if(FirstNodeValues[5]==0)
    //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Add To favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites+.gif'  /></a>";
    //else
    //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Remove From favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' /></a>";

        HTML=createHomeTree(NewTree,StartIndex,EndIndex,IsProjectSelected);
    //    objdivlist.innerHTML=FavouriteHTML+HTML;
        objdivlist.innerHTML=HTML;
        TabItemOnClick(FirstNodeValues[3],FirstNodeValues[0],FirstNodeValues[5]); 
        }  
        else
        objdivlist.innerHTML="";
}  


    function Refresh_OnClick()
    {
        objform.submit();
    }   
	
	function addRemoveFavorites(intTagID,strMode)
    {
	// A Add to Favourites
	// D delete from Favourites
	// R Remove all 
       var objimgfav=GetObjectReference('','ImgFav');
	   var intTagID=objhidtagid.value; 
       // if(objhidcontrolitemid.value!="" && objhidcontrolitemid.value!="0")
        if(objimgfav.title !='Add to favourites')
        {
              strMode='D'; // Mode passed in querysting for database update purpose, 
                            //while image source and title are UI purpose which take place immidiately
              objimgfav.src='../../Images/Home/favorites+.gif';
              objimgfav.title='Add to favourites';
             
        }      
	    else
	    {
	         strMode='A';
	         objimgfav.src='../../Images/Home/favorites-.gif';
             objimgfav.title='Remove from favourites';  
	    }      
	    
        //objimgfav.onclick=addRemoveFavorites;	         
	    loadXMLDoc("Home_Setup.aspx?IsFavXMLHTTP=1","Mode="+strMode+"&FavTagID="+intTagID,"FAV")
	    //objform.submit();
			
    } 	
    function OptionLinks_OnChange(objLinkType)
    {
       /* if(String(objLinkType.value)=="1") 
        { 
        strLocation = "Home.aspx?PageNumber=1";
		
			objform.action = strLocation
			objform.submit();
		}
		else*/
		if(String(objLinkType.value)!="" )
		{
	     document.getElementById("frmMain").src=String(objLinkType.options[objLinkType.selectedIndex].value);
            
            if(objcboTheme!=null)
	        objcboTheme.value=''; 
		}    	
			//loadXMLDoc(strLocation,'',"PAGEING")
    }   
    function MyTaskList_Click()
    {
	     document.getElementById("frmMain").src= "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
    }
    function Approval_Click()
    {
	     document.getElementById("frmMain").src= "../Home/Home_Approvals.aspx?FromWhere=HOME";
    }

    function LastUpdated_Click()
    {
    //window.location.href = url+"&From_Where=HRHome";
    }
    function CrossTab_Click()
    {
         document.getElementById("frmMain").src= "../Home/CrossTabGridReport.aspx?FromWhere=HOME&CTReportID=1";
    }
    function cboTheme_OnChange(obj)
    {
      var URL = GetObjectReference('','hidDefaultPageURL');
      var GanttURL;
      
      if(String(objhidtagid.value)=="1038" || String(objhidtagid.value)=="34")
      {
        if(String(objcboTheme.options[objcboTheme.selectedIndex].value)=="1")
        {
          
            document.getElementById("frmMain").src="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID="+String(objhidtagid.value);  
        }
        else
            document.getElementById("frmMain").src=URL.value;//"../PM/PM_AssignedTaskList.aspx?MasterTagID=1038&FromWhere=PM";  
      }         
    }
    
    function ProjectSelection()
    {
        //window.open("../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&FromHome=1&MasterTagID=8026", "","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height -760)/2 + ",width=800,height=660");
        
        objFrame=GetObjectReference('','iFloatingMenu');
        
        if(objFrame==null)
            return;
       
        objFrame.style.left='50px';       
        objFrame.style.top='50px';
        objFrame.style.height="350px";
        objFrame.src='../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&FromHome=1&MasterTagID=8026';
        objFrame.style.display='';
        showFloatingmenu='1';		
    }
    
    function SelectProject(ProjectID)
    {
        objform.action='../Home/Home_Setup.aspx?&From_Where=HRHome&FromWhere=HOME&Action=SelectProject&ProjectID='+ProjectID;
        objform.submit();    
    }
    
    function CloseDiv_OnClick()
    {
                var objPopUpDiv;
        		objPopUpDiv=GetObjectReference('','PopUp');
        		
        		objPopUpDiv.style.display='none';
    }
    
    function TablItem_onmouseover(ObjHref)
    {
        ObjHref.style.textDecorationNone=false;
    }

    function TablItem_onmouseout(ObjHref)
    {
        ObjHref.style.textDecorationNone=true;
    }
    
    function HideTree()
    {
        ObjTd=GetObjectReference('','tdTree');
        ObjImg=GetObjectReference('','ImgShowHide');
        
        if(ObjTd!=null && ObjImg!=null)
        {
            if(ObjImg.src.toUpperCase().match('SCROLLRIGHT.GIF'))
            {
                ObjTd.style.display='';
                ObjImg.src='../../Images/ScrollLeft.gif';
            }
            else
            {
                ObjTd.style.display='none';
                ObjImg.src='../../Images/ScrollRight.gif';
            }
        }
            
        /*ObjTd=GetObjectReference('','tdDot0');
        if(ObjTd!=null)
            ObjTd.style.display='none';
            
        ObjTd=GetObjectReference('','tdDot1');
        if(ObjTd!=null)
            ObjTd.style.display='none';
            
        ObjTd=GetObjectReference('','tdDot2');
        if(ObjTd!=null)
            ObjTd.style.display='none';*/
    }
    
    function ShowTree()
    {
        ObjTd=GetObjectReference('','tdTree');
        if(ObjTd!=null)
            ObjTd.style.display='';
    }

   function ShowFloatingmenu(Mode,ev)
   {
        
        var objTemplateID = GetObjectReference('','txtTemplateID');
             
        if(objFrame==null)
            return;
       
       if(Mode=='Project')
       {
            objFrame.style.height="350px";
            objFrame.src='../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&FromHome=1&MasterTagID=8026';
       }
       else
       {
            if(Mode=='Views')
                objFrame.style.height="140px";
       
            if(Mode=='GoTo'){
                objFrame.style.height="450px";//"225px";
                objFrame.style.width="300px";
                }
            objFrame.src='../Home/Home_FloatingMenu.aspx?Mode='+Mode+"&TagID="+objhidtagid.value+"&TemplateID="+objTemplateID.value;
       }
            
        showmenuie('iFloatingMenu',ev)
        showFloatingmenu='1';
   }
   
   function hideFloatingFrame()
   {
        objFrame=GetObjectReference('','iFloatingMenu');
        
        if(objFrame==null)
            return;
          if(showFloatingmenu=='0')
               objFrame.style.display='none';    
               
          showFloatingmenu='0'; 
          objFrame.src="";    
   }
   
   function showmenuie(divCM,objevent){

var objdiv = GetObjectReference('',divCM);

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

    if (objDivH >400)
        objDivH=400;
              
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
   
   function ShowModules(index)
   {
        var i;
        var ObjLink;
        
        var objTemplateID = GetObjectReference('','txtTemplateID');
        
      /*  for(i=0;i<3;i++)
        {
            ObjLink=GetObjectReference('','Span'+String(i));
            
            if(i==index)
                ObjLink.style.backgroundImage="url(../../Images/Home/TabSelected.gif)";  
            else
                ObjLink.style.backgroundImage="url(../../Images/Home/Tab.gif)";               
            
        }*/
        
        if(index==0)
        {
            
            if (objTemplateID !=null)
            {
                objTemplateID.value= 'SM';
            }
            objform.submit();
            document.getElementById("frmMain").src="../Home/HRHome.aspx?ShortName=SM&FromWhere=SM";
        }
        
        if(index==1)
        {
            
            if (objTemplateID !=null)
            {
                objTemplateID.value= 'PRO';
            } 
            objform.submit();         
            document.getElementById("frmMain").src="../Home/HRHome.aspx?ShortName=PRO&FromWhere=PRO";  
        }
        
        if(index==2)
        {
            //document.getElementById("frmMain").src="../Home/CrossTabGridReport.aspx?FromWhere=HOME&CTReportID=1";
            
            if (objTemplateID !=null)
            {
                objTemplateID.value= 'RM';
            }  
            objform.submit();    
            document.getElementById("frmMain").src="../Home/HRHome.aspx?ShortName=RM&FromWhere=RM";      
        }
        
        if(index==3)
        {
            //document.getElementById("frmMain").src="../AdvancedTimesheet/Advanced_Timesheet.aspx?FromWhere=DA";
            document.getElementById("frmMain").src="../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA";
        }
        
   }
   
   function HideFrame()
   {
       objFrame=GetObjectReference('','iFloatingMenu');
        
        if(objFrame==null)
            return;
        
        objFrame.style.display='none';    
        objFrame.src="";
   }
   
function txtSearch_OnKeyup(e)
{
    var code;
    var strSearch=document.getElementById("TxtSearch").value;
    var objdivlist=GetObjectReference('frmTree','DivTree');
	if (e.keyCode) 
	{
	    code = e.keyCode;
    }
    else
    {
	    if (e.which) 
	    {
		    code = e.which;
        }
    }
					
	if(code==13) 
	{   
	    var arrNodeValue;
		var TagName;
		var URL;
		var intIndex;
		var HTML;
		NewTree.length=0;
		intCnt=0;
		for(i=0;i<Tree.length;i++)
		{
		    arrNodeValue=Tree[i].split("|");
			TagName=arrNodeValue[2];
			IsChild=arrNodeValue[7];
			if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			{
			    addParentNode(arrNodeValue[1]);
			    NewTree[intCnt]=Tree[i];        
			    intCnt+=1;
            }
        }
		   
//        if(Tree.length >0 )
//        {
//            FirstNodeValues=Tree[GetSelectedNodeIndex(objhidtagid.value)].split("|");

//            if(!IsProjectSelected  && FirstNodeValues[0]!=32)
//            {
//                FirstNodeValues=GetProjectListNode().split("|");
//            } 

//            //if(FirstNodeValues[5]==0)
//            //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Add To favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites+.gif'  /></a>";
//            //else
//            //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Remove From favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' /></a>";
//        }
		
        if('<%=m_intUseNewUITree.ToString()%>'=='1')
        {
            NoofLinks=NewTree.length;
            MaxNoofPages=parseInt(NoofLinks/ 20) ; 
            if(NewTree.length % 20>0)
                MaxNoofPages+=1;
            objPageNumber.value="1";
            PageOnClick();
            PageNumber=1;
//            StartIndex=(PageNumber-1)*PageSize;
//            EndIndex=(NoofLinks - (PageNumber-1)*PageSize) <  PageSize ?  (NoofLinks - (PageNumber-1)*PageSize) :  PageSize ;
			HTML=createHomeTree(NewTree,StartIndex,EndIndex,IsProjectSelected);
			objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
        }
        else
        {
            var objtxtTemplateID = GetObjectReference('','txtTemplateID');
            HTML=createSearchTree(NewTree,strSearch);
            objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
            if(strSearch=="")
            {
//                var arrNode0Values=Tree[0].split("|");
//                oc(3,0,arrNode0Values[6]);
//                var arrNode1Values=Tree[5].split("|");
//                oc(8006,0,arrNode1Values[6]);
            /*NodeIndex=GetSelectedNodeIndex(3);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(3,0,arrNode0Values[6]);
            }
            NodeIndex=GetSelectedNodeIndex(8006);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(8006,0,arrNode0Values[6]);
            }  */
            
            if (objtxtTemplateID.value== 'SM')
                NodeIndex=GetSelectedNodeIndex(1);
            if (objtxtTemplateID.value== 'PRO')
                NodeIndex=GetSelectedNodeIndex(654);
            if (objtxtTemplateID.value== 'RM')
                NodeIndex=GetSelectedNodeIndex(428);


            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                if (objtxtTemplateID.value== 'SM')
                    oc(1,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'PRO')
                    oc(654,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'RM')
                    oc(428,0,arrNode0Values[6]);

            }              
            }
            LoadFirstNode(NewTree);
        }
    }
}


function addParentNode(ParentNodeID)
{
    var index;
    var ParentNodeIndex=-1;
    for(index=0;index<Tree.length;index++)
    {
        arrNodeValue=Tree[index].split("|");
        if(arrNodeValue[0]==ParentNodeID)
        {
            ParentNodeIndex=index;
            break;
        }
    }

    if(ParentNodeID!=0)
    {
        if(Tree[ParentNodeIndex]!=null && !IsNodeExists(Tree[ParentNodeIndex]))
        {
             arrNodeValue=Tree[ParentNodeIndex].split("|");
             addParentNode(arrNodeValue[1]);
             NewTree[intCnt]=Tree[ParentNodeIndex];
             intCnt+=1;
        }
    }
}

function IsNodeExists(Node)
{
    for(ii=0;ii<NewTree.length;ii++)
        if(NewTree[ii]==Node)
            return true;
    return false;        
}



function LoadFirstNode(NewTree)
{
    var i;
    var Node;
    for(i=0;i<NewTree.length;i++)
    {
        Node=NewTree[i].split("|");
        if(Node[7]=="0")
        {
            if(IsProjectSelected || Node[0]=="32" || Node[0]=="3936")
            {
                TabItemOnClick(Node[3],Node[0],Node[5]);
                break; 
            }
        }
    }   
}


//Added By Amol Changle On: 03 Apr 2009
//Purpose: To plot left tree in Javascript
var objdivlist=GetObjectReference('frmTree','divTree');
var objPageNumber=GetObjectReference('frmTree','txtPageNumber');
var arrNodeValue;
var TagName;
var URL;
var intIndex;
var HTML;
var ParentTagName;
var PageNumber=1;
var NoofLinks;
var MaxNoofPages;
var PageSize=10;
var StartIndex;
var EndIndex;
var NewTree=new Array;
var IsProjectSelected;
var FirstNodeValues;
//var FavouriteHTML;
var NodeIndex;
var strSearch=document.getElementById("txtSearch").value;

//Modified By Amol Changle On: 08 May 2009
//Purpose: To plot Old/New tree

        IsProjectSelected=true;

if('<%=m_intUseNewUITree.ToString()%>'=='1')
{
    var intCnt=0;
	for(StartIndex=0;StartIndex<Tree.length;StartIndex++)
	{
	    arrNodeValue=Tree[StartIndex].split("|");
		TagName=arrNodeValue[2];
		IsChild=arrNodeValue[7];
		if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
		{
		    NewTree[intCnt]=Tree[StartIndex];        
			intCnt+=1;
		}
			       
	}
    NoofLinks=NewTree.length;
    MaxNoofPages=parseInt(NoofLinks/ 20) ; 
    if(NewTree.length % 20>0)
        MaxNoofPages+=1;
    PageNumber=objPageNumber.value;
    StartIndex=(PageNumber-1)*PageSize;
    EndIndex=(NoofLinks - (PageNumber-1)*PageSize) <  PageSize ?  (NoofLinks - (PageNumber-1)*PageSize) :  PageSize ;

    if(NewTree.length>0)
    {
        FirstNodeValues=NewTree[StartIndex].split("|");
        if(!IsProjectSelected  && FirstNodeValues[0]!=32)
        {
            FirstNodeValues=GetProjectListNode().split("|");
        } 

        //if(FirstNodeValues[5]==0)
        //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Add To favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites+.gif'  /></a>";
        //else
        //    FavouriteHTML="<a class='clsLinkChildNavMenu' href='javascript:addRemoveFavorites()' title='Remove From favourites' style='vertical-align:top;' ><img id=imgFav border=0 src='../../Images/Home/favorites-.gif' /></a>";

        HTML=createHomeTree(NewTree,StartIndex,EndIndex,IsProjectSelected);
        objdivlist.innerHTML=HTML;

        var objimgfav=GetObjectReference('frmHome','imgFav');
        TabItemOnClick(FirstNodeValues[3],FirstNodeValues[0],FirstNodeValues[5]);
    }
    else objdivlist.innerHTML="";
}
else
{
    ////-----------------
		NewTree.length=0;
		intCnt=0;
		for(i=0;i<Tree.length;i++)
		{
		    arrNodeValue=Tree[i].split("|");
			TagName=arrNodeValue[2];
			IsChild=arrNodeValue[7];
			if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			{
			    addParentNode(arrNodeValue[1]);
			    NewTree[intCnt]=Tree[i];        
			    intCnt+=1;
            }
        }

    if(NewTree.length >0 )
    {
        TagID=objhidtagid.value;
       /* if(TagID=='0' || TagID=='')
        {
            if(IsProjectSelected)
            {
                TagID=27;
            }
            else
            {
                TagID=32;
            }
        }*/
        NodeIndex=GetSelectedNodeIndex(TagID);
        if(NodeIndex!=-1)
        {    
            FirstNodeValues=Tree[NodeIndex].split("|");
            if(!IsProjectSelected  && FirstNodeValues[0]!=32)
            {
                FirstNodeValues=GetProjectListNode().split("|");
            }    
            TabItemOnClick(FirstNodeValues[3],FirstNodeValues[0],FirstNodeValues[5]);
        }
        HTML=createSearchTree(NewTree,strSearch);
        objdivlist.innerHTML=HTML;
        if(strSearch=="")
        {
          /*  NodeIndex=GetSelectedNodeIndex(3);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(3,0,arrNode0Values[6]);
            }
            NodeIndex=GetSelectedNodeIndex(8006);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(8006,0,arrNode0Values[6]);
            }*/
            var objtxtTemplateID = GetObjectReference('','txtTemplateID');
            if (objtxtTemplateID.value== 'SM')
                NodeIndex=GetSelectedNodeIndex(1);
            if (objtxtTemplateID.value== 'PRO')
                NodeIndex=GetSelectedNodeIndex(654);
            if (objtxtTemplateID.value== 'RM')
                NodeIndex=GetSelectedNodeIndex(428);


            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                if (objtxtTemplateID.value== 'SM')
                    oc(1,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'PRO')
                    oc(654,0,arrNode0Values[6]);
                if (objtxtTemplateID.value== 'RM')
                    oc(428,0,arrNode0Values[6]);

            }  
            
        }
        LoadFirstNode(NewTree);
    }
///------------------------------------
////===================================
}


   ////////////////////////////////////////////////////////////////////
   
	
	function ShowPreviousFAV()
    {
    if(GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
	}
	
	if(objtxtFAVPageNumber!=null)
	{
	    if (isBlank(objtxtFAVPageNumber.value))
		    PageFAV_Onclick(1);
	    else
	    {
		     		
		    if (objtxtFAVPageNumber.value==1){alert("This is the first favorites");return;}
			    objtxtFAVPageNumber.value=objtxtFAVPageNumber.value -1;
		    PageFAV_Onclick(objtxtFAVPageNumber.value);
	    }
	}	
   }
    
    function ShowNextFAV()
    {
    if(GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
	}
	if(objtxtFAVPageNumber!=null)
	{
	    if (isBlank(objtxtFAVPageNumber.value))
		    PageFAV_Onclick(1);
	    else
	    {  

		  
		    if (objtxtFAVPageNumber.value==parseInt(noOfFAVs)){alert("This is the last favorites");return;}		 
		    objtxtFAVPageNumber.value=parseInt(objtxtFAVPageNumber.value) + 1;
    		
		    PageFAV_Onclick(objtxtFAVPageNumber.value);
    		 
	    }
	  }  
   } 
   
   function PageFAV_Onclick(PageNumber)
		{
			
			
		    var strURL = "Home_FloatingMenu.aspx?Mode=GoTo&IsXMLHttp=1&TemplateID="+"<%=m_strTemplateID%>";
		
		    loadXMLDoc(strURL,"PageNumber=" + String(parseInt(PageNumber)),"FAVTAB");
		
		}
		
	function FAVTab_state_Change()
    {
    // if xmlhttp shows "loaded"
    if (xmlhttp.readyState==4)
      {
      // if "OK"
      if (xmlhttp.status==200)
      {
            
            if(xmlhttp.responseText!="")
              { 
                 var objtdTabs=GetObjectReference('','tdTabs');
                 
                 if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
               } 
         
             
      }
      else
      {
      alert("Problem in transfering data:" + xmlhttp.statusText)
      }
      }
    }
   ////////////////////////////////////////////////////////////////////


	   </script>





    
</body>
</html>
