<%@ Page Language="vb"  AutoEventWireup="false" CodeBehind="Home.aspx.vb" Inherits="PbNIT.Home" %>
<html >

<%  CommonFunctions.General.PlotPageHeadTag("Home")%>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="X-UA-Compatible" content="IE=5,8,9,11">
<meta http-equiv="X-UA-Compatible" content="chrome=1">

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<link rel='stylesheet' type='text/css' href='../Home/Home.css' />
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css' />
<link rel='stylesheet' type='text/css' href='../General/tab-view.css' />
<script type='text/javascript' src='../Home/homeTree.js'></script>
<script type='text/javascript' src='../General/SearchTree.js'></script>
        <script type="text/javascript">
        
            // Added by Kiran for Loader 2/11/15
            function setFrameLoaded()
            { 
                //Added by swapnil aswale on 14-12-2015 for Mulitple Login
                $("#frmMain").contents().find("a").click(function(){
                    $.ajax({url: "MultipleLogin.aspx", success: function(result){
                        
                    }});

                });
                //Ended
               
                //Added by swapnil aswale on 14-12-2015 for Mulitple Login
                //$("#frmMain").contents().find("#frmSub").find("a").click(function(){
                //    $.ajax({url: "MultipleLogin.aspx", success: function(result){
	          
                //    }});

                //});
                //Ended 

                jQuery("#preloader").fadeOut("slow");
                jQuery("#fillDiv").fadeOut("slow"); 
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
                //=====================
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
                //===========================
                RemoveFrameLoader();
            }
            function setFrameLoader()
            {   
        
                $("HTML").append("<div id='preloader'></div>"); 
                $("HTML").append("<div id='fillDiv'></div>");  
            }
            function RemoveFrameLoader()
            {   
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
                jQuery("#preloader").fadeOut("slow");
                jQuery("#fillDiv").fadeOut("slow"); 
                jQuery("#preloader").remove();
                jQuery("#fillDiv").remove();
            }
      
            //End by KIran for Loader 2/11/15
            
            //Commented and added by Yogesh J on 12-Feb-2016 for issue id=3160 
            function SetRollOverTD(obj,evt,act)
            {
	   

                if(obj!=null)
                {
                    //obj.style.background-color='#FFD695';
                    if(act==1)

                        obj.className='cMenu';
                    else
                        obj.className='clsTDScroll';
                }

            }
            function ModulesOnMouseOver(obj)
            {
	    
                obj.className='clsTRMenuMouseOver';
            }
            function ModulesOnMouseOut(obj)
            {
	    
                obj.className='clsTRMenu';
            }
            //End of addition by Yogesh J on 12-Feb-2016 for issue id=3160 
        </script>
<style type="text/css">

/* Commented added by Shamkant S on 19 Nov 2015  for issue id 2273*/
    /* Added By Puneet M ON 23-11-2015 PURPOSE: Top Border of Body in Main Iframe gap between TopLinks & Top Border */
    .clsBody {
        margin-top:0px !important;
    }
    /* Ended By Puneet M ON 23-11-2015 PURPOSE: Top Border of Body in Main Iframe gap between TopLinks & Top Border */
    #divTree a b
    {
        font-weight:bold;
    }
    #divTree {
        overflow:hidden !important;

    }
     #divTree:hover {
        overflow:auto !important;

    }
/*  ended Shamkant s */
	   TD.iMenu:hover
{
	padding-right: 3px;
	padding-left: 3px;
	padding-bottom: 3px;
	padding-top: 1px;
	border-right: black 0px solid;
	border-top: black 0px solid;
	font-weight: lighter;
	font-size: 10px;
	border-left: black 0px solid;
	color: black;
	border-bottom: black 0px solid;
	font-family: Verdana, Arial;
	background-color: #FFD695;
}
       /* Puneet M ON 24-11-2015 */
       TD.cMenu
{
	padding-right: 0px;
	padding-left: 0px;
	padding-bottom: 0px;
	padding-top: 0px;
	border-right:  #FFD695 1px solid;
	border-top: black 0px solid;
	font-weight: lighter;
	font-size: 11px;
	border-left: black 0px solid;
	color: black;
	border-bottom: black 0px solid;
	font-family: arial;
	background-color: #FFD695;
}
       /* END Puneet M ON 24-11-2015 */

       /*Added by Dhanashri on 4 Mar 2015*/
       /*
           
           Commented By Vaijat K ON 29/09/2016 For Dynamic Theme
           TD.clsTDScroll
{
	padding-right:0;
	padding-left: 0;
	padding-bottom: 0;
	margin: 0;
	color: #000000;
	padding-top: 0;
	border-right: #e39321 1px solid;
	border-top: black 0px solid;
	font-weight: lighter;
	font-size: 11px;
	border-left: black 0px solid;
	border-bottom: black 0px solid;
	font-family: arial;
    background-color:#e39321;
}
       BODY.clsBody
{
    BORDER-RIGHT: #e39321 4px solid;
    BORDER-TOP: #e39321 4px solid;
    PADDING-LEFT: 2px;
    SCROLLBAR-FACE-COLOR: #f5debe;
    FONT-SIZE: 14px;
    MARGIN: 2px 0px;
    SCROLLBAR-HIGHLIGHT-COLOR: #fbecd5;
    BORDER-LEFT: #000000 0px solid;
    SCROLLBAR-SHADOW-COLOR: #fbecd5;
    SCROLLBAR-3DLIGHT-COLOR: #fbecd5;
    LINE-HEIGHT: 1;
    SCROLLBAR-ARROW-COLOR: #e28a05;
    PADDING-TOP: 0px;
    SCROLLBAR-TRACK-COLOR: #fbecd5;
    BORDER-BOTTOM: #e39321 4px solid;
    BACKGROUND-REPEAT: repeat;
    FONT-FAMILY: Verdana, Arial;
    SCROLLBAR-DARKSHADOW-COLOR: #fbecd5;
    SCROLLBAR-BASE-COLOR: #e0e7ef;
    Commented by SuchitraP on 7-Apr-2009 ,KM UI scrollbar was not displayed
	overflow:visible  ;
	End by SuchitraP
}
        End of Commented   
           */


         /*Added by Kiran for Loader 2/11/15*/
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
        width: 64px;
        height: 64px;
        /*z-index: 99;
            height: 100%;*/
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
    }

    #fillDiv {
        opacity: 0.4;
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
   
    /*Added by Kiran for Loader 2/11/15*/


       /*End of Addition by Dhanashri*/
    #divTree
    {
        white-space:nowrap;
    }
   
</style>


<body class='clsBody'  onresize="window_onresize()" onload="window_onload()">
		<form id="frmHome" method="post"  runat="server"  > <!-- onclick="hideFloatingFrame()"-->
           <!-- <asp:Panel ID="Panel1" runat="server" Height="50px" Width="879px" BackColor='lightblue' style="border-bottom :lightblue 1px outset;"   >
            </asp:Panel>-->
			<%PageInit()%>
			<iframe id="iFloatingMenu" name="iFloatingMenu" style="display:none;z-index:100; position:absolute;overflow:visible;" ></iframe>
            
        
    </form>
    
<script language="javascript">


    $(document).ready(function () { 
        

        $("HTML").append("<div id='preloader'></div>"); 
        $("HTML").append("<div id='fillDiv'></div>");  
        //Added By Sanyogeeta R On 25 Nov 2016 For Display leftarrow.png and rigntarrow.png in chrome browser
        if (typeof($("#imgExpandTab").css("background-image")) != "undefined") {
            var strPath = $("#imgExpandTab").css("background-image").replace('url("', '');
            strPath = strPath.substring(0, strPath.length - 2);
            $("#imgExpandTab").attr("src", strPath);
        }
        if (typeof($("#imgclosetab").css("background-image")) != "undefined") {
            var strPath = $("#imgclosetab").css("background-image").replace('url("', '');
            strPath = strPath.substring(0, strPath.length - 2);
            $("#imgclosetab").attr("src", strPath);
        } 
        //End Of Added By Sanyogeeta R On 25 Nov 2016 For Display leftarrow.png and rigntarrow.png in Crome Browser
    });
    
  
  		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		
    var objform=GetFormReference('frmHome');
    var objDivMain=GetObjectReference('frmHome','divMain');
    var objdivTab=GetObjectReference('frmHome','divTab');
    var xmlhttp;
    var objhidPageURL=GetObjectReference('frmHome','hidDefaultPageURL');
    var objhidtagid=GetObjectReference('frmHome','hidDefaultTagID');
    var objhidcontrolitemid=GetObjectReference('frmHome','hidDefaultControlItemID');
    var objdivHeader=GetObjectReference('frmHome','divHeader');

    var objcboTheme=GetObjectReference('frmHome','cboTheme');
    var objifTD=GetObjectReference('frmHome','ifTD');
    var objbrowserType=GetObjectReference('','browserType');
    
    var showFloatingmenu='0';
   	var ie5=document.all&&document.getElementById
    var ns6=document.getElementById&&!document.all
    
    var objtrGM=GetObjectReference('','trGM');
    
    var objFrame=GetObjectReference('','iFloatingMenu');
    var objhidtxtThemeID=GetObjectReference('frmHome','hidTxtThemeID');
    var blnLoadFirstNode;
    blnLoadFirstNode=false;
        
   function calcHeight()
    {
        var height;//Firefox
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
	    else

	       height=window.innerWidth;

       

        if(typeof(height)!='undefined')
	     {                     	
	        document.getElementById("frmMain").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-40)+"px";
	        if('<%=m_intUseNewUITree.ToString()%>'=='1')
	        {
	          //  document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-87)+"px";	  
            }
            else
            {
                              
              
	            if (navigator.appName=="Netscape") 
	            {
	                //ht= parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+135));
	                //document.getElementById("divTree").style.height=ht+"px";//parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+135))+"px";	  

	                //if(document.getElementById("divTree").scrollHeight>document.getElementById("divTree").offsetHeight)
	                    //document.getElementById("tdTree_Inner").style.height=document.getElementById("tdTree_Inner").offsetHeight;
	                //else
	                //    document.getElementById("tdTree_Inner").style.height=document.getElementById("tdTree_Inner").offsetHeight+15;

	            }       
	            else{
	                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight+65))+"px";
	            }
            }
        }
        
            ShowHideViews();
	}
	
	function TabGroupOnClick(GroupTabID)
	{
	    var URL='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	    
	    loadXMLDoc(URL,'')
	    
	  // objform.action='../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA&GroupTabID='+GroupTabID;
	  // objform.submit();
	}
	function SearchText_OnClick()
	{
	   
	        
	    var srURL=objhidPageURL.value;
	    if(srURL.indexOf('MasterTagID') >=0)
	        return;
	        
	    var PageURL='';
	    var objtTSearch=GetObjectReference('','txtSearch');
	    if(objtTSearch!=null)
	    {
	        if(srURL.indexOf('&txtSearch') >=0)
	            PageURL=srURL.substring(0,srURL.lastIndexOf("&"));
	         else
	            PageURL=srURL;
	            
	         PageURL=PageURL+"&txtSearch="+encodeURIComponent(objtTSearch.value);
	      
	                   
	        TabItemOnClick(PageURL,0,0);
	    }
	    
	            
	}
	
	function TabItemOnClick(PageName,TagID,ControlItemID,ev)
	{
       
	     // added  by purvaj on 9 jul 2009
	    
	    PageName=PageName.replace(/&#124;/g, "|");
        //Added by Nilesh g on 12/5
	     if (PageName=="../Home/DetailView.aspx?MenuGroupID=16")
	     {
             var str1="&PkToken="+'<%=m_strToken%>';
	         PageName=PageName+str1;
	     }
	    //Added by Yogesh J on 13/08/2016
	    if (PageName=="../PM/PM_ProjectDocuments.aspx?MasterTagID=467&FromWhere=PM")
	    {
	        var str1="&PkToken=0";
            PageName=PageName+str1;
	    }
	    //End of addition by Yogesh J on 13/08/2016
	    	 
	    //Added by swapnil aswale on 14-12-2015 for Mulitple Login
	     $("a").click(function(){
	         $.ajax({url: "MultipleLogin.aspx", success: function(result){
	          
	         }});
	     });
        //Ended

	     var objulExpenses,objul_Myedashboard,objul_edashboard,objul_MyRequests,objul_Inbox;
	     var TotalItems;
	        if('<%=m_strProjectID %>'=='0' && ev!=null && TagID > 0 && TagID !=32 && TagID!=3936 && TagID!=5 && TagID!=10 && TagID!=1085 && TagID!=3707 && TagID!=1208 )//&& "<%=m_strTemplateID %>"== 'PM'
            {
                // added By purvaj on 14 jul 2009 SEM 8.1 Show alert only for session Project dependent pages.
                if(PageName.indexOf('FromWhere=PM') >=0)
                {
                //end addition purvaj
                    alert("No project selected.\nPlease, select a project.");
                    ShowFloatingmenu('Project',ev);
                    return;
                }
            }
	        // if(document.getElementById("frmMain").src!=PageName){
    	     
	         var objTab=GetObjectReference('','atab_'+TagID);
	         var objAllTab=GetObjectReference('','atab',true);
    	  
	         if(objAllTab!=null)
	         {
    	  
	            for(i=0;i<objAllTab.length;i++)
	            {
    	        
	                objAllTab[i].className='';
	            }
	         }
	          if(objTab!=null )
	                objTab.className='selectedTab';//'tabSelected';//'selectedTab';
    	            
    	
	         //"../CRM/CRM_RequestList.aspx"  
            // alert(PageName.indexOf('FinanceApproval'))
	         if (PageName.indexOf('MyExpenses')>=0)
	         {
	             //ADDED BY KIRAN KK FOR LOADER 2/11/15. 
	             setFrameLoader();
	             //END BY KIRAN KK FOR LOADER 2/11/15.
	            document.getElementById("frmMain").src="../EWF/MyExpenseSheet_CommonList.aspx?FromWhere=DT&MasterTagId=3593";
	             objhidPageURL.value=PageName;
              }
            //Added By Dipali V On 7th June 2019 For Restirct to  Redirect to Timesheet Page;
            else if (PageName.indexOf('FinanceApproval')>=0)
	             {
	                 //ADDED BY KIRAN KK FOR LOADER 2/11/15. 
	                 setFrameLoader();
	                 //END BY KIRAN KK FOR LOADER 2/11/15.
	                 document.getElementById("frmMain").src="../EWF/FinanceApproval_CommonList.aspx?FromWhere=DT&MasterTagId=3597";
	                 objhidPageURL.value=PageName;
             }
           //End of Added By Dipali V On 7th June 2019 For Restirct to  Redirect to Timesheet Page;
	         else
	         {
	             //ADDED BY KIRAN KK FOR LOADER 2/11/15. 
	             setFrameLoader();
	             //END BY KIRAN KK FOR LOADER 2/11/15.
                 //Added By Aniruddh Gujar on 06-Dec-2018
                 if ((TagID == 10 && ControlItemID == 10) || TagID == 21000 || TagID == 21006 || TagID == 5) {
                     if ('<%= AllowVersionChange%>' == "1") {
                         document.getElementById("frmMain").src = PageName;
                         objhidPageURL.value = PageName;
                     }
                     else {
                         $.ajax({
                            url: "../General/Navigation.aspx/ChangeVersion",
                            data: JSON.stringify({ VersionID: "2" }),
                            dataType: "json",
                            contentType: "application/json",
                            type: "POST",
                             success: function (result) {
                                 //debugger;
                                 var strFromWhere = '<%=Session("strActiveModule")%>';
                                 //if(TagID)
                                window.open("../General/Navigation.aspx?FromWhere=" + strFromWhere + "&FromOld="+ TagID +"", "_top")
                              },
                              error: function (xhr) {
                                 // alert();
                                  
                                  window.parent.location.href = "../../Default.aspx?Message=SessionExpired";
                                  console.log('Request Status: ' + xhr.status + ' Status Text: ' + xhr.statusText + ' ' + xhr.responseText);

                             }
                        })
                     }
                 }
                 //End of Added By Aniruddh Gujar on 06-Dec-2018
                 else {
                     document.getElementById("frmMain").src = PageName;
                     objhidPageURL.value = PageName;
                 }
	          }  
	         objhidtagid.value=TagID;
	         objhidcontrolitemid.value=ControlItemID;
    	     
	         if(objcboTheme!=null)
	            objcboTheme.value='';
    	        
    	       //  if ("<%=m_strTemplateID %>"!="PRO")
	             //   {
	           
	             //if(typeof(ev)!='undefined' && typeof(ev)!='null')
	                DrawFavImage(ev);
                    

	           /*  else if ("<%=m_strTemplateID %>"== 'CRM' || "<%=m_strTemplateID %>"== 'PRO' || "<%=m_strTemplateID %>"== 'DB' || "<%=m_strTemplateID %>"== 'KM') 
	                 { var objaFav=GetObjectReference('','aFav');if(objaFav!=null) objaFav.style.display='none'; }           */
	                     
    	  	            ShowHideViews();
    	  	       //  } 
	          //Commented by purvaj on 23 jul 2009
    	      //modified by purvaj on 14 Jul 2009 do not hide tree for HOME and CRM
    	      //&& ("<%=m_strTemplateID %>" != 'DB') && ("<%=m_strTemplateID %>"!= 'CRM') condition added
	          
	          if( ((TagID==5 || TagID==10)  &&   (PageName.indexOf('Issue') >=0 || PageName.indexOf('AdvancedTimesheet') >=0 ))  )
              {
                ObjTd=GetObjectReference('','tdTree');
                ObjImg=GetObjectReference('','ImgShowHide');
                ObjLeftnavigation=GetObjectReference('','tblLeftNavigation');
                  
                if(ObjTd!=null && ObjImg!=null)
                {
                    
                        ObjTd.style.display='none';
                        ObjImg.src='../../Images/Home/RightMove.gif';
                        ObjLeftnavigation.style.display='';
                }

    	       
	          }  
	    //Added by Nilesh g on 18/1/2015 for display support node on full Large view
	          if (((TagID==22234 ||TagID==2 || TagID==3|| TagID==4|| TagID==5|| TagID==6 || TagID==8|| TagID==9) && (PageName.indexOf('PM') >=0 || PageName.indexOf('CRM') >=0 || PageName.indexOf('Home') >=0) ))
	          {
	              ObjTd=GetObjectReference('','tdTree');
	              ObjImg=GetObjectReference('','ImgShowHide');
	              ObjLeftnavigation=GetObjectReference('','tblLeftNavigation');
                  
	              if(ObjTd!=null && ObjImg!=null)
	              {
                    
	                  ObjTd.style.display='none';
	                  ObjImg.src='../../Images/Home/RightMove.gif';
	                  ObjLeftnavigation.style.display='';
	              }
	        
	          }
	    //endded by Nilesh g on 18/1/2015        
	          //End comment purvaj
	          //Added by PrashantSJ on 24th June 2009
	           
	           //Commented by PrashantSJ on 14th Aug 2009
	         //calcHeight();    
	          //End of comment by PrashantSJ n 14th Aug 2009
	           
	       //  }
	       var objtdDot1=GetObjectReference('','tdDot1');
	       if(objtdDot1!=null)
	       {
	            if(objtdDot1.disabled)
	                objtdDot1.disabled=false;
	       }     
	    //Added By Vaijat K On 16/11/2015
	       if (document.getElementById("tdDot2") != undefined)
	       {
	           if (document.getElementById("tdDot2").style.display != 'none'){
	               document.getElementById("ifTD").style.width = "100%";
	               document.getElementById("tdDot2").style.width = "0%";
	               document.getElementById("tdDot2").style.display = "none"
	               document.getElementById("tdTree").style.display = "";
	               document.getElementById("tblLeftNavigation").style.display = "none";
	           }
	       }
	    //End of Addition By Vaijat K On 16/11/2015
	     
	}

    //Added By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page
    function f_imgExpand()
    {
        document.getElementById("tblLeftNavigation").style.display = "";
        document.getElementById("ifTD").style.width = "0%";
        document.getElementById("ImgShowHide").setAttribute('src', '../../Images/Home/RightMove.gif');
        //if (isIE() == "FF")
        //    parent.document.getElementById("tdDot2").style.display = "block";
        //else
        document.getElementById("tdDot2").style.display = "";
        document.getElementById("tdDot2").style.height = "100%";
        document.getElementById("tdDot2").style.width = "99.9%";
    }
    //End of Added By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page

    function f_imgClose()
    {
       
        var WhichBrowser = isIE();
        var objImg,  objImgNetwork;
        //Added By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page
        if(WhichBrowser == 'IE')
        {
            objImg = parent.document.frames[2].frmMain.document.getElementById('imgHideShow');
            objImgNetwork = parent.document.frames[2].frmMain.document.getElementById('imgHideShowNetwork');
        }
        else
        {
            objImg = window.parent.frames[2].frmMain.document.getElementById('imgHideShow');
            objImgNetwork = window.parent.frames[2].frmMain.document.getElementById('imgHideShowNetwork');
        }
        //Ended By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page

        //Added By Vaijat K On 17/11/2015
        if (document.getElementById("tdDot2") != undefined)
        {
            if (document.getElementById("tdDot2").style.display != 'none'){
                document.getElementById("ifTD").style.width = "100%";
                document.getElementById("tdDot2").style.width = "0%";
                document.getElementById("tdDot2").style.display = "none"
                document.getElementById("tdTree").style.display = "";
                document.getElementById("tblLeftNavigation").style.display = "none";

                //Added By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page
                if(objImg != null || objImg != undefined)
                    objImg.src = '../../Images/Home/leftarrow.png';

                if(objImgNetwork != null || objImgNetwork != undefined)
                    objImgNetwork.src = '../../Images/Home/leftarrow.png';
                //Ended By Bharat Tekade on 27th-Apr-2016 to change arrow direction of gantt view page
            }
        }
        //End of Addition By Vaijat K On 17/11/2015
    }


    function AdjustAlignment()
    {

        var PageURL=objhidPageURL.value;
        if(PageURL.indexOf('CDB_Main') >=0)
            document.getElementById("frmMain").scrolling='yes';
    }
    
    function isIE () {
        var brwser = '';
        var ua= navigator.userAgent, tem,
        M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
        if(/trident/i.test(M[1])){
            tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
            //return 'IE '+(tem[1] || '');
            return 'IE';
        }
        if(M[1]=== 'Chrome'){
            tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
            if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
            brwser = 'CR';
        }
        else if(M[1]==='Firefox')
        {
            tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
            if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
            brwser = 'FF';
        }
        M = M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
        if((tem= ua.match(/version\/(\d+)/i))!= null) M.splice(1, 1, tem[1]);
        //return M.join(' ');
        return brwser;
    }


    var brw = isIE();   // ADDED BY PUNEET MAKODE ON 16th June 2015


    function window_onload()
    {
        var intDivHeight=0;
       
        if(objDivMain != null)
        {

            if (navigator.appName == 'Microsoft Internet Explorer'){
                intDivHeight = document.body.offsetHeight - objDivMain.offsetTop+50;
            }
            else{
                intDivHeight = window.innerHeight - objDivMain.offsetTop+50;
            }

            if (intDivHeight < 100)
                intDivHeight = 100;
					
				
            var height;//Firefox
            if (document.body.clientHeight)
            {
                height=document.body.clientHeight;//IE
            }
            else
                height=window.innerWidth;
	                   
	                
            if(typeof(height)!='undefined')
            {
	                        
                if('<%=m_intUseNewUITree.ToString()%>'=='1')
	                  {
                    
                    document.getElementById("divTree").style.height = parseInt(height-document.getElementById("frmMain").offsetTop-85)+"px";
	                    
	                  }
	                  else
	                  {
	                      // document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-65)+"px";
	                      // document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-280)+"px";
                    if ("<%=m_strTemplateID %>"!= 'CRM')
                    {  
                        if (navigator.appName!= 'Microsoft Internet Explorer')
                        {
                             
                            ht= parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+135));
                                
                            // ADDED BY PUNEET M ON 16th June 2015
                            //ht = parseInt(ht)+60;         // Commented AND ADDED BY PUNEET M ON 26-11-2015
                            ht = parseInt(ht) + 60 - 26;
	                            
                            document.getElementById("divTree").style.height=ht+4+"px";
                            //parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+135))+"px";
                            document.getElementById("divTree").style.verticalAlign="top";
				                
	                             
                        }   
                        else
                        {
                            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+61))+"px";

                        }

                    }     
                        //Added by Yogesh J on 23/12/2015 for issue id=2763
                    else{
                      
                        if(brw == 'FF')
                            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-104+"px";
                        else
                            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-101+"px";
                        
                    }
                    //End of Comment by Yogesh J on  23/12/2015 for issue id=2763
                    
	                }

	                
                    if (intDivHeight!=null)
                    {
                        // ADDED BY PUNEET MAKODE ON 16th JUNE 2015
                        var objfrmMain=document.getElementById('frmMain');
                        var objdivTab=document.getElementById('divTab');
                        var tblInnertdTree = document.getElementById('tblInnertdTree');
                        if(brw == 'IE')                                         
                        {   
                            
                            objdivTab.style.height = (intDivHeight-54) + "px";  
                        }
                        else if(brw == 'CR')
                        {
                            objdivTab.style.height = (intDivHeight-68) + "px";
                       }
                        else if(brw == 'FF')
                        {
                            objdivTab.style.height = (intDivHeight-73) + "px";       
                        }
                        else
                            objdivTab.style.height = (intDivHeight) + "px"; 

                        if(tblInnertdTree !=null)
                        {   
                            if(brw == 'FF')
                                tblInnertdTree.style.height = (intDivHeight-60) + "px";
                            else
                            tblInnertdTree.style.height = (intDivHeight-57) + "px";
                        }
                                        
                        if (objfrmMain!=null){
                            if(brw == 'IE')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                            {                             
                                objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-17)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                                  
                            }
                            else if(brw == 'CR')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                            {                               
                                objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-18)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                                
                            }
                            else if(brw == 'FF')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                            {                               
                                objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-22)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                            }
                            else
                                objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-15)+"px";    //  Added BY PUNEET M on 15thJune2015
                        }
                        // ENDDED BY PUNEET MAKODE ON 16th JUNE 2015
                        /*Code added by miiint ends*/
                    }

                }
            }		
        /*if(ns)
        {*/
        //PrashantSJ on 16th July 2009
        //    var URL = GetObjectReference('','hidDefaultPageURL');
        //    document.getElementById("frmMain").src=URL.value;
        //PrashantSJ on 16th July 2009
        //}   
             
        //Commented By Amol Changle On: 03 Apr 2009

       
	              
        if(objhidPageURL.value =='' || objhidPageURL.value.indexOf('Introduction.aspx') >=0 )
        {
            
            TabItemOnClick('../General/Introduction.aspx?FromWhere=<%=m_strTemplateID %>',0,0,null);        
            calcHeight(); 
        }
	                
        //DrawFavImage();
              var objtxtSearch=GetObjectReference('','txtSearch');
              setFocus(objtxtSearch);
        //ShowHideViews();
           
        // added by puneet
              objdivTab.style.overflow = "";
          
                
    }

    function window_onresize()
    {   	    
       
        var height;//Firefox
        var intDivHeight;
	    
        if (document.body.clientHeight)
        {

            height=document.body.clientHeight - objDivMain.offsetTop+50;//IE
        }
        else
            height=window.innerWidth-objDivMain.offsetTop+50;
	     
        if(typeof(height)!='undefined')
        {
            if('<%=m_intUseNewUITree.ToString()%>'=='1')
	        {
                
	            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-85)+"px";

	        }
	        else
            {
                
                if ("<%=m_strTemplateID %>"!= 'CRM')
                {
                    //cOMMENTED AND ADDED BY NILESH G ON 27/11/2015
                    //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-105+"px";
                    //Added By Vaijat K ON 10/02/2016
                    if (document.getElementById("tblLeftNavigation").style.display != "none"){
                        if(document.getElementById("trModuleBar").style.display != "none"){
                            if(brw == 'FF')
                                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(41))-104+"px";
                            else
                                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(41))-101+"px";
                        }
                        else
                        {
                            if(brw == 'FF')
                                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(220))-104+"px";
                            else
                                document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(220))-101+"px";
                        }
                    }
                   //Ended
                    else {
                        
                        if(brw == 'FF')
                            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-104+"px";
                        else
                            document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-101+"px";
                   
                    }
                     //END OF cOMMENTED AND ADDED BY NILESH G ON 27/11/2015
                }
                    //Added by Yogesh J on 23/12/2015 for issue id=2763
                else{
                      
                    if(brw == 'FF')
                        document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-104+"px";
                    else
                        document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-101+"px";
                        
                }
                //End of Comment by Yogesh J on  23/12/2015 for issue id=2763
                 
	        }
            if(height !=null)
            {

                //objDivMain.style.height = height+"px";
                /*Code added by miiint starts*/
                /*To set the height to iframe 'frmMain' and to div 'divTab'*/
                               
                //objfrmMain.style.height = (height-objdivTab.offsetTop-15)+"px";

                // ADDED BY PUNEET MAKODE ON 23-11-2015
                if (navigator.appName == 'Microsoft Internet Explorer'){
                    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop+50;
                }
                else{
                    intDivHeight = window.innerHeight - objDivMain.offsetTop+50;
                }

                if (intDivHeight < 100)
                    intDivHeight = 100;

                // ADDED BY PUNEET MAKODE ON 16th JUNE 2015
                var objfrmMain=document.getElementById('frmMain');
                var objdivTab=document.getElementById('divTab');
                var tblInnertdTree = document.getElementById('tblInnertdTree');
                if(brw == 'IE')                                         
                {   
                            
                    objdivTab.style.height = (intDivHeight-54) + "px";  
                   
                }
                else if(brw == 'CR')
                {
                    objdivTab.style.height = (intDivHeight-68) + "px";
                }
                else if(brw == 'FF')
                {
                    objdivTab.style.height = (intDivHeight-72) + "px";       
                }
                else
                    objdivTab.style.height = (intDivHeight) + "px"; 


                if(tblInnertdTree !=null)
                {
                    if(brw == 'FF')
                        tblInnertdTree.style.height = (intDivHeight-60) + "px";
                    else
                        tblInnertdTree.style.height = (intDivHeight-57) + "px";
                }
                                        
                if (objfrmMain!=null){
                    if(brw == 'IE')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                    {                               
                        objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-17)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                                
                    }
                    else if(brw == 'CR')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                    {                               
                        objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-18)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                                
                    }
                    else if(brw == 'FF')                                          // ADDED BY PUNEET M ON 16th JUNE 2015  PURPOSE: CHECK FOR BROWSER IS IE OR NOT
                    {                               
                        objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-22)+"px";    // Added By Puneet M ON 16th JUNE 2015          WORKING FOR IE 11
                                
                    }
                    else
                        objfrmMain.style.height = (intDivHeight-objdivTab.offsetTop-15)+"px";    //  Added BY PUNEET M on 15thJune2015
                }
                // ENDDED BY PUNEET MAKODE ON 16th JUNE 2015
                /*Code added by miiint endas*/

                // ADDED BY PUNEET M
                //objdivTab.style.height = (height-57)+"px";
                //objDivMain.style.height = (height-55)+"px";
            }

        }

    	    //calcHeight();
        
    }

    function ShowHideViews()
    {

       var objhrefviews=GetObjectReference('','hfView');
      // var objhrefDV=GetObjectReference('','hrefDV');
        
       if(objhrefviews!=null && objhidtagid!=null )
         {
           var strTagIDList=",1038,661,34,2133,1019,454,";
            
            if(strTagIDList.match(','+objhidtagid.value+',')!=null)
            {
                if("<%=m_strAllowResourceAllocation%>"=="True" && objhidtagid.value=="1019") 
                    objhrefviews.style.display='none';
                else
                    objhrefviews.style.display='';
               // objhrefDV.style.display='';
            }    
            else
            {
               objhrefviews.style.display='none';
              // objhrefDV.style.display='none';
            }    
        }
    }
    function DrawFavImage(ev)
    {

        var objimgfav=GetObjectReference('frmHome','imgFav');
        var objaFav=GetObjectReference('','aFav');

        
        if (objimgfav==null)
            return;
        
        if(objhidcontrolitemid.value!="" && objhidcontrolitemid.value!="0")
        {
           
          if(typeof(ev)!='undefined' && typeof(ev)!='null')
                objaFav.style.display='';
          else if ("<%=m_strTemplateID %>"== 'CRM' || "<%=m_strTemplateID %>"== 'PRO' || "<%=m_strTemplateID %>"== 'DB' || "<%=m_strTemplateID %>"== 'KM' )  
                 objaFav.style.display='none';
          else
                objaFav.style.display='';
                         
          if(String(objhidcontrolitemid.value)=="5" || String(objhidcontrolitemid.value)=="10")
                    objaFav.style.display='none';
                          
            objimgfav.src='../../Images/Home/favorites-.gif';
            objimgfav.title='Remove from Favorites';
            //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"D")';
            
        }   
        else
        {
             
         if ("<%=m_strTemplateID %>"== 'CRM' || "<%=m_strTemplateID %>"== 'PRO' || "<%=m_strTemplateID %>"== 'DB' || "<%=m_strTemplateID %>"== 'KM')  
                objaFav.style.display='none';
          else
                objaFav.style.display='';
            //Commented and Added By Bharat T on 25th-Nov-2015                                
            //objimgfav.src='../../Images/Home/fav+.gif';
            objimgfav.src='../../Images/Home/favplus.gif';
            //End of Commented and Added By Bharat T on 25th-Nov-2015
             objimgfav.title='Add To Favorites';
             //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"A")';
        }
        //Added By Bharat Tekade on 1st-Feb-2016
        $.ajax({
            type: 'POST',
            url: '../General/XMLHttp.aspx?TagID='+ objhidtagid.value +'&Action=ValidateFavTree',
            success: function (Result) {
                DrawFavTreeImage(ev,Result)
            },
            error: function () {
              //  alert("Error")
            }
        });
        //End of Added By Bharat Tekade on 1st-Feb-2016
            
    }
    //Added By Bharat Tekade on 1st-Feb-2016
    function DrawFavTreeImage(ev,TagID)
    {
        
        var objimgfavTree=GetObjectReference('frmHome','imgFavT');
        var objtFav=GetObjectReference('','tFav');
        var FavTreeImageShow;

        if (objimgfavTree==null)
            return;
        
        if(TagID!="" && TagID!="0")
        {
           
            if(typeof(ev)!='undefined' && typeof(ev)!='null')
                objtFav.style.display='';
            else if ("<%=m_strTemplateID %>"== 'CRM' || "<%=m_strTemplateID %>"== 'PRO' || "<%=m_strTemplateID %>"== 'DB' || "<%=m_strTemplateID %>"== 'KM' )  
                objtFav.style.display='none';
          else
                objtFav.style.display='';
                         
            if(String(TagID)=="5" || String(TagID)=="10")
                objtFav.style.display='none';
                          
            objimgfavTree.src='../../Images/Home/FavTreeMinus.gif';
            objimgfavTree.title='Remove From Fav Tree';
            //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"D")';
            
      }   
      else
      {
             
          if ("<%=m_strTemplateID %>"== 'CRM' || "<%=m_strTemplateID %>"== 'PRO' || "<%=m_strTemplateID %>"== 'DB' || "<%=m_strTemplateID %>"== 'KM')  
              objtFav.style.display='none';
            else
              objtFav.style.display='';
            //Commented and Added By Bharat T on 25th-Nov-2015                                
            //objimgfav.src='../../Images/Home/fav+.gif';
            objimgfavTree.src='../../Images/Home/FavTreePlus.gif';
            //End of Commented and Added By Bharat T on 25th-Nov-2015
            objimgfavTree.title='Add To Fav Tree';
            //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"A")';
        }

    }
    //End of Added By Bharat Tekade on 1st-Feb-2016
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
      //debugger;
        if(xmlhttp.responseText!="")
           
           { //objdivHeader.innerHTML=xmlhttp.responseText;
             var objtdTabs=GetObjectReference('','tdTabs');
                 
                 if(objtdTabs!=null)
                    objtdTabs.innerHTML=xmlhttp.responseText;
           
           } 
            
        /* objdivTab.innerHTML=xmlhttp.responseText;
         calcHeight();
         var URL = GetObjectReference('','hidDefaultPageURL');
                document.getElementById("frmMain").src=URL.value;*/
                

       
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
       
       
            DrawFrameWithURL();
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

    SearchTree();
   
/*
	    var arrNodeValue;
		var TagName;
		var URL;
		var intIndex;
		var HTML;
		var strSearch="";
		if(document.getElementById("txtSearch")!=null)
		     strSearch=document.getElementById("txtSearch").value;
		     
        var objdivlist=GetObjectReference('frmTree','divTree');
		
		NewTree.length=0;
		intCnt=0;
		for(i=0;i<Tree.length;i++)
		{
		    arrNodeValue=Tree[i].split("|");
			TagName=arrNodeValue[2];
			IsChild=arrNodeValue[7];
			
			//if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			if((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0") || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB")))
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
			HTML=createHomeTree(NewTree,StartIndex,EndIndex,IsProjectSelected);
			objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
        }
        else
        {
            HTML=createSearchTree(NewTree,strSearch);
            objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
            if(strSearch=="")
            {
            NodeIndex=GetSelectedNodeIndex(3);
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
            }  
            }
            LoadFirstNode(NewTree);
        }
       // ShowHideModules(null);*/
}
//function txtSearch_OnKeyup(evt)
//{
// var code;
//if (evt.keyCode) code = evt.keyCode;
//else if (evt.which) code = evt.which;

//if(code==13)
//{   objhidPageURL.value=""; 
//    Search_OnClick(evt);
//}
//}



//////////////////////////////////////////////////////////
//Commmented By Amol Changle On: 07 May 2009
//Purpose: To plot old tree
//function txtSearch_OnKeyup(e)
//{
//    var code;
//    var strSearch=document.getElementById("txtSearch").value;
//			if (e.keyCode) 
//				code = e.keyCode;
//			else
//				if (e.which) 
//					code = e.which;
//					
//			if(code==13) 
//			{  
//			   var arrNodeValue;
//			   var TagName;
//			   var URL;
//			   var intIndex;
//			   var HTML;
//			   var ParentTagName;
//			   NewTree.length=0;
//			   intCnt=0;
//			   
//			   for(i=0;i<Tree.length;i++)
//			   {
//			        arrNodeValue=Tree[i].split("|");
//			        TagName=arrNodeValue[2];
//			        URL=arrNodeValue[3];
//			        if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && URL!="")
//			        {
//			            NewTree[intCnt]=Tree[i];        
//			            intCnt+=1;
//			        }
//			       
//			   }
//			   
//			   NoofLinks=NewTree.length;
//               MaxNoofPages=parseInt(NoofLinks/ 20) ; 
//               if(NewTree.length % 20>0)
//                    MaxNoofPages+=1;
//               objPageNumber.value="1";
//                PageOnClick();
//			  
////              HTML=createHomeTree(NewTree);
////			  objdivlist.innerHTML=HTML;
//			}
//}

/////////End Comments
/////////////////////////////////////////////////////////////


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
//	if (isBlank(objtxtpageNumber.value))
//		Page_Onclick(1);
//	else
//	{
//		
//		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
//			objtxtpageNumber.value=objtxtpageNumber.value -1;
//		Page_Onclick(objtxtpageNumber.value);
//	}
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
//	if (isBlank(objtxtpageNumber.value))
//		Page_Onclick(1);
//	else
//	{  
//		
//		if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}	
//			 
//		objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
//				 
//		Page_Onclick(objtxtpageNumber.value);
//		 
//	}
    if(objPageNumber.value==MaxNoofPages || NewTree.length==0 )
        alert("This is the last page.");
    else
       {    
            objPageNumber.value=parseInt(objPageNumber.value)+1;
            PageOnClick();  
       }    
}

//function Page_Onclick(PageNumber)
//{     
//       objhidPageURL.value="";
//      objform.submit();
//}


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
        //Added by Tejal D date 12/10/2016 to set setFrameLoader
        setFrameLoader();
        //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
        objform.submit();
    }   
	
	function addRemoveFavorites(intTagID,strMode)
    {
	// A Add to Favourites
	// D delete from Favourites
	    // R Remove all 
	 
       var objimgfav=GetObjectReference('','imgFav');
       var intTagID=objhidtagid.value;       
       var strResult;
     
	    //Added By Bharat Tekade on 5th-Feb-2016 to restrict favorites item to 5
       if($('.mainTabsSectionEasyMenu a')!=null)

           var favoriteCount = $('.mainTabsSectionEasyMenu a').length;

        //Added By Bharat T on 10th-Nov-2016 for MasterCard Nextgen Upgrade issue fixing
       if(objimgfav.title.toUpperCase() != "REMOVE FROM FAVORITES")
       {
           if(favoriteCount >= 5)
           {
               alert('Maximum limit is 5.');
               return;
           }
       }
	   //End of Added By Bharat T on 10th-Nov-2016 for MasterCard Nextgen Upgrade issue fixing

       //else{
           //End of Added By Bharat Tekade on 5th-Feb-2016 to restrict favorites item to 5
           // if(objhidcontrolitemid.value!="" && objhidcontrolitemid.value!="0")
           if(objimgfav.title !='Add To Favorites')
           {
               strMode='D'; // Mode passed in querysting for database update purpose, 
               //while image source and title are UI purpose which take place immidiately
               objimgfav.src='../../Images/Home/favplus.gif';
               objimgfav.title='Add To Favorites';
             
           }      
           else
           {
               strMode='A';
               objimgfav.src='../../Images/Home/favorites-.gif';
               objimgfav.title='Remove From Favorites';  
           }      
	    
           //objimgfav.onclick=addRemoveFavorites;	         
           loadXMLDoc("Home.aspx?IsFavXMLHTTP=1&FromWhere=<%=m_strTemplateID %>","Mode="+strMode+"&FavTagID="+intTagID,"FAV")
      
       //}
	    //objform.submit();
			
	} 	
    function addRemoveFavoritesFromTree(intTagID,strMode)
    {
        // A Add to Favourites
        // D delete from Favourites
        // R Remove all 
        //debugger;
        var objimgfav=GetObjectReference('','imgFavT');
        var intTagID=objhidtagid.value;       
        var strResult;
       
        // if(objhidcontrolitemid.value!="" && objhidcontrolitemid.value!="0")
        if(objimgfav.title !='Add To Fav Tree')
        {
            strMode='DT'; // Mode passed in querysting for database update purpose, 
            //while image source and title are UI purpose which take place immidiately
            objimgfav.src='../../Images/Home/FavTreePlus.gif';
            objimgfav.title='Add To Fav Tree';
             
        }      
        else
        {
            strMode='AT';
            objimgfav.src='../../Images/Home/FavTreeMinus.gif';
            objimgfav.title='Remove From Fav Tree';  
        }      
	    
        //objimgfav.onclick=addRemoveFavorites;	         
        loadXMLDoc("Home.aspx?IsFavXMLHTTP=0&FromWhere=<%=m_strTemplateID %>","Mode="+strMode+"&FavTagID="+intTagID,"FAVTREENODE")

	   
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
		if(String(objLinkType.value)!="" && ("<%=m_strProjectID %>"!="0" && "<%=m_strProjectID %>"!=""))
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
        //Added by Tejal D date 12/10/2016 to set setFrameLoader
        setFrameLoader();
        //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
        objform.action='../Home/Home.aspx?&From_Where=HRHome&FromWhere=HOME&Action=SelectProject&ProjectID='+ProjectID;
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
        //added by purvaj
        ObjLeftnavigation=GetObjectReference('','tblLeftNavigation');
        //end adition purvaj
        
        if(ObjTd!=null && ObjImg!=null)
        {
            if(ObjImg.src.toUpperCase().match('RIGHTMOVE.GIF'))
            {
                ObjTd.style.display='';
                ObjImg.src="<%=m_strNavigationBarImage %>"//'../../Images/Home/LeftMove.gif';
                ObjLeftnavigation.style.display='none';
            }
            else
            {
                ObjTd.style.display='none';
                ObjImg.src="<%=m_strRNavigationBarImage %>"
                ObjLeftnavigation.style.display='';
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
        var ObjSearch;
        <%-- if('<%=m_strProjectID %>'=='0' && Mode!='Project' && Mode!='GoTo')
        {
            alert("No project selected.\nPlease, select a project.");
            ShowFloatingmenu('Project',ev);
            return;
        } --%>
             
        if(objFrame==null)
            return;
        //objFrame.style.width="";
        objFrame.style.display='';
       
       if(Mode=='Project')
       {
            objFrame.style.height="350px";
            objFrame.src='../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&FromHome=1&MasterTagID=8026';
            
            showmenuie('iFloatingMenu',ev);
       }
       else if(Mode=='SearchIn')
       {
        var objText;
        var objdiv = GetObjectReference('','iFloatingMenu');

        objdiv.style.display='';
        objdiv.style.position = 'absolute';        
        objdiv.style.left=5;
        objdiv.style.top=30;
        ObjSearch=GetObjectReference('','txtSearch');
        objFrame.style.height="250px";
        objFrame.style.width="150px";
        
        objText = URLEncode(replaceSubstring(trimString(ObjSearch.value),"'","|"));
        objFrame.src="../Home/Home_TextSearch.aspx?FromWhere=Home&Mode=1&TextSearch="+objText;
       }
       else
       {
            if(Mode=='Views')
            {   
                var strTagIDList=",1038,661,34,2133,1019,454,";
                
                if(strTagIDList.match(','+objhidtagid.value+',')!=null);
                else
                {
                    alert('Views is not applicable for this page !');
                    return;
                }    
                objFrame.style.height="140px";
             }   
       
            if(Mode=='GoTo')
            {
                objFrame.style.height="450px";//"225px";
                objFrame.style.width="300px";
            }    
                
            objFrame.src='../Home/Home_FloatingMenu.aspx?Mode='+Mode+"&TagID="+objhidtagid.value+"&TemplateID="+"<%= m_strTemplateID%>";
            
            
            showmenuie('iFloatingMenu',ev);
            
       }
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

    /*if (objDivH > 200)
        objDivH=200;*/
        
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
       //Commented And Added By Vaijat K ON 28/11/2015
    //if(ie5)
    //    window.event.cancelBubble = true;
    //else if(ns6)
    //    e.stopPropagation();
    if (!e) var e = window.event
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
       //Ended
   return false;
  
   }
   
   function ShowModules(index)
   {
        var i;
        var ObjLink;
        
        for(i=0;i<5;i++)
        {
            ObjLink=GetObjectReference('','Span'+String(i));
            
            if(ObjLink!=null)
            {
                if(i==index)
                    ObjLink.style.backgroundImage="url(../../Images/Home/TabSelected.gif)";  
                else
                    ObjLink.style.backgroundImage="url(../../Images/Home/Tab.gif)";               
            }
        }
        
        if(index==0)
        {
            document.getElementById("frmMain").src="../Home/MyToDoList.aspx?FromWhere=HOME";
        }
        
        if(index==1)
        {
            document.getElementById("frmMain").src="../Home/Home_Approvals.aspx?FromWhere=HOME";
        }
        
        if(index==2)
        {
            //document.getElementById("frmMain").src="../Home/CrossTabGridReport.aspx?FromWhere=HOME&CTReportID=1";
            document.getElementById("frmMain").src="../Home/DetailView.aspx?MenuGroupID=1";
        }
        
        if(index==3)
        {
            //document.getElementById("frmMain").src="../AdvancedTimesheet/Advanced_Timesheet.aspx?FromWhere=DA";
            document.getElementById("frmMain").src="../AdvancedTimesheet/Main_TabPage.aspx?FromWhere=DA";
        }
         if(index==4)
        {
            //document.getElementById("frmMain").src="../AdvancedTimesheet/Advanced_Timesheet.aspx?FromWhere=DA";
            document.getElementById("frmMain").src="../IB/IBIssueList.aspx?StartPage=1&FromWhere=BTS";
        }
        
        //Added by PrashantSJ on 2nd Apr 2009
       objhidtagid.value=0;
        //End of addition by PrashantSJ on 2nd Apr 2009
   }
   
   function HideFrame()
   {
       objFrame=GetObjectReference('','iFloatingMenu');
        
        if(objFrame==null)
            return;
        
        objFrame.style.display='none';    
        objFrame.src="";
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
var strSearch="";

var SortedTreeIndex;

//3rd Aug 2009

if(Tree.length <=1 )
{
    var objimgFav=GetObjectReference('','imgFav');
    var objhfView=GetObjectReference('','hfView');
    
    if(objimgFav!=null)
        objimgFav.style.display='none';
     
     if(objhfView!=null)   
            objhfView.style.display='none';
    
}

//3rd Aug 2009

if(document.getElementById("txtSearch")!=null)
     strSearch=document.getElementById("txtSearch").value;

//Modified By Amol Changle On: 08 May 2009
//Purpose: To plot Old/New tree

    if('<%=m_strProjectID %>'=='' || '<%=m_strProjectID %>'=='0' )
        IsProjectSelected=false;
    else
        IsProjectSelected=true;

    if ("<%=m_strTemplateID %>"!="PM")
        IsProjectSelected=true;
        
if('<%=m_intUseNewUITree.ToString()%>'=='1')
{
    var intCnt=0;
	for(StartIndex=0;StartIndex<Tree.length;StartIndex++)
	{
	    arrNodeValue=Tree[StartIndex].split("|");
		TagName=arrNodeValue[2];
		IsChild=arrNodeValue[7];
		//if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
		if((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0") || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB")))
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
        //PrashantSJ on 14th Aug 2009
        calcHeight(); 
    }
    else objdivlist.innerHTML="";
}
else
{

    ////Added By Amol Changle On: 23 Jul 2009
    ////To reorder tree
    NewTree.length=0;
    SortedTreeIndex=0; 

     if ("<%=m_strTemplateID %>"=="PRO")
     {
   		SortTree(0);
            
            
        for(i=0;i<NewTree.length;i++)
        {
            Tree[i]=NewTree[i];
        }
       /* for(i=0;i<Tree.length;i++)
        {
            NewTree[i]=Tree[i];
        }*/        
     }
     else
     {
            SortTree(0);
            
            
        for(i=0;i<NewTree.length;i++)
        {
            Tree[i]=NewTree[i];
        }
    }
   
    ///End Addition


    ////-----------------
		NewTree.length=0;
		intCnt=0;
		for(i=0;i<Tree.length;i++)
		{
		    arrNodeValue=Tree[i].split("|");
			TagName=arrNodeValue[2];
			IsChild=arrNodeValue[7];
			//if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			if((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0") || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB")))
			{
			    addParentNode(arrNodeValue[1]);
			    NewTree[intCnt]=Tree[i];        
			    intCnt+=1;
            }
        }
/////////////////////----------------------------
////---------------------------------------------
//    if(Tree.length >0 )
//    {
//        TagID=objhidtagid.value;
//        if(TagID=='0' || TagID=='')
//        {
//            if(IsProjectSelected)
//            {
//                TagID=27;
//            }
//            else
//            {
//                TagID=32;
//            }
//        }
//            
//        FirstNodeValues=Tree[GetSelectedNodeIndex(TagID)].split("|");
//        if(!IsProjectSelected  && FirstNodeValues[0]!=32)
//        {
//            FirstNodeValues=GetProjectListNode().split("|");
//        } 
//        TabItemOnClick(FirstNodeValues[3],FirstNodeValues[0],FirstNodeValues[5]);
//        HTML=createSearchTree(Tree,'');
//        objdivlist.innerHTML=HTML;
//        var arrNode0Values=Tree[0].split("|");
//        oc(3,0,arrNode0Values[6]);
//        var arrNode1Values=Tree[5].split("|");
//        oc(8006,0,arrNode1Values[6]);
//    }

    if(NewTree.length >0 )
    {  
        TagID=objhidtagid.value;
        if(TagID=='0' || TagID=='')
        {
            if(IsProjectSelected && "<%=m_strTemplateID %>"== 'PM')
            {
                TagID=27;
            }
            else if("<%=m_strTemplateID %>"== 'PM')
            {
                TagID=32;
            }
        }
        
        NodeIndex=GetSelectedNodeIndex(TagID);
        if(NodeIndex!=-1)
        {    
            FirstNodeValues=Tree[NodeIndex].split("|");
         
            if(!IsProjectSelected  && FirstNodeValues[0]!=32)
            {
                FirstNodeValues=GetProjectListNode().split("|");
            }    
            
          //if ("<%=m_strTemplateID %>"!= 'DB')
                TabItemOnClick(FirstNodeValues[3],FirstNodeValues[0],FirstNodeValues[5]);
                  //PrashantSJ on 14th Aug 2009
        calcHeight();
               
                    
        }
        HTML=createSearchTree(NewTree,strSearch);
        //Commented by purvaj on 13 Jul 2009 SEM 8.1 dispay tree for Helpdesk and home                
       // if ( "<%=m_strTemplateID %>"!= 'CRM' && "<%=m_strTemplateID %>"!= 'DB')//
             objdivlist.innerHTML=HTML;
       //End addition purvaj     
        if(strSearch=="")
        {
            
            NodeIndex=GetSelectedNodeIndex(3);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(3,0,arrNode0Values[6]);
            }
            NodeIndex=GetSelectedNodeIndex(8006);
         
            /////////////////////////////////////////////////
                if ("<%=m_strTemplateID %>"== 'SM')
                    NodeIndex=GetSelectedNodeIndex(1);
                if ("<%=m_strTemplateID %>"== 'PRO')
                    NodeIndex=GetSelectedNodeIndex(-1);
                if ("<%=m_strTemplateID %>"== 'RM')
                    NodeIndex=GetSelectedNodeIndex(428);
                if ("<%=m_strTemplateID %>"== 'FA')
                    NodeIndex=GetSelectedNodeIndex(357);
                if ("<%=m_strTemplateID %>"== 'MR')
                    NodeIndex=GetSelectedNodeIndex(404);
                    // Added By purvaj on 13 Jul 2009
                if ("<%=m_strTemplateID %>"== 'CRM')
                    NodeIndex=GetSelectedNodeIndex(1);  
                if ("<%=m_strTemplateID %>"== 'DB')
                    NodeIndex=GetSelectedNodeIndex(1);                    
                    //End addition purvaj
                if ("<%=m_strTemplateID %>"== 'KM')
                    NodeIndex=GetSelectedNodeIndex(-1);                    
                    
            ///////////////////////////////////////////////////        
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(8006,0,arrNode0Values[6]);
             
                ///////////////////////////////////////////////
                if ("<%=m_strTemplateID %>"== 'SM')
                    oc(1,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'PRO')
                    oc(-1,0,arrNode0Values[6]);
                    
                if ("<%=m_strTemplateID %>"== 'RM')
                    oc(428,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'FA')
                    oc(357,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'MR')
                    oc(404,0,arrNode0Values[6]);
                    // Added By purvaj on 13 Jul 2009
                if ("<%=m_strTemplateID %>"== 'CRM')
                   oc(1,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'DB')
                   oc(1,0,arrNode0Values[6]);
                    //End addition purvaj
                if ("<%=m_strTemplateID %>"== 'KM')
                {
                   oc(-1,0,arrNode0Values[6]);
                   oc(-2,0,arrNode0Values[6]);
                 }  

               /////////////////////////////////////////////////     
            }
        }
       
        
        if(objhidPageURL.value == '' && String(objhidtagid.value)!="10"){
            
            LoadFirstNode(NewTree);
        }
        else if(String(objhidtagid.value)=="10")
            TabItemOnClick("../AdvancedTimesheet/Main_TabPage.aspx", objhidtagid.value,objhidcontrolitemid.value);
        else{
            
            TabItemOnClick(objhidPageURL.value, objhidtagid.value,objhidcontrolitemid.value);
        }       //PrashantSJ on 14th Aug 2009
          
           calcHeight();    
    }
///------------------------------------
////===================================
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

function txtSearch_OnKeyup(e)
{
    var code;
  
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
	   SearchTree()
    }
}
function SearchTree()
{
        var objtxtSearch=GetObjectReference('frmTree','txtSearch');
        var strSearch=objtxtSearch.value;
        var objdivlist=GetObjectReference('frmTree','divTree');
       // var WhichfavTab = $('#TdAll span#selected');
       // debugger;
    
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
			//if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
			if((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0") || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB")))
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
//            StartIndex=(PageNumber-1)*PageSize;
//            EndIndex=(NoofLinks - (PageNumber-1)*PageSize) <  PageSize ?  (NoofLinks - (PageNumber-1)*PageSize) :  PageSize ;
			HTML=createHomeTree(NewTree,StartIndex,EndIndex,IsProjectSelected);
			objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
        }
        else
        {
            HTML=createSearchTree(NewTree,strSearch);
            /////if ("<%=m_strTemplateID %>"!= 'CRM')
                objdivlist.innerHTML=HTML;//.replace(/<nobr>/g,'');
            if(strSearch=="")
            {
//                var arrNode0Values=Tree[0].split("|");
//                oc(3,0,arrNode0Values[6]);
//                var arrNode1Values=Tree[5].split("|");
//                oc(8006,0,arrNode1Values[6]);
            NodeIndex=GetSelectedNodeIndex(3);
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(3,0,arrNode0Values[6]);
            }
            NodeIndex=GetSelectedNodeIndex(8006);
            
             /////////////////////////////////////////////////
                if ("<%=m_strTemplateID %>"== 'SM')
                    NodeIndex=GetSelectedNodeIndex(1);
                if ("<%=m_strTemplateID %>"== 'PRO')
                    NodeIndex=GetSelectedNodeIndex(-1);
                if ("<%=m_strTemplateID %>"== 'RM')
                    NodeIndex=GetSelectedNodeIndex(428);
                if ("<%=m_strTemplateID %>"== 'FA')
                    NodeIndex=GetSelectedNodeIndex(357);
                if ("<%=m_strTemplateID %>"== 'MR')
                    NodeIndex=GetSelectedNodeIndex(404);
                    //Added By purvaj on 13 jul 2009
                if ("<%=m_strTemplateID %>"== 'CRM')
                    NodeIndex=GetSelectedNodeIndex(1);
                if ("<%=m_strTemplateID %>"== 'DB')
                    NodeIndex=GetSelectedNodeIndex(1);

                    //End addition purvaj
                if ("<%=m_strTemplateID %>"== 'KM')
                     NodeIndex=GetSelectedNodeIndex(-1);
                     
            ///////////////////////////////////////////////////     
            
            if(NodeIndex!=-1)
            {
                var arrNode0Values=Tree[NodeIndex].split("|");
                oc(8006,0,arrNode0Values[6]);
                
                 ///////////////////////////////////////////////
                if ("<%=m_strTemplateID %>"== 'SM')
                    oc(1,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'PRO')
                    oc(-1,0,arrNode0Values[6]);
                
                if ("<%=m_strTemplateID %>"== 'RM')
                    oc(428,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'FA')
                    oc(357,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'MR')
                    oc(404,0,arrNode0Values[6]);
                    //Added By purvaj on 13 jul 2009
                if ("<%=m_strTemplateID %>"== 'CRM')
                    oc(1,0,arrNode0Values[6]);
                if ("<%=m_strTemplateID %>"== 'DB')
                    oc(1,0,arrNode0Values[6]);
                    //End addition purvaj
                if ("<%=m_strTemplateID %>"== 'KM')
                {
                    oc(-1,0,arrNode0Values[6]);
                    oc(-2,0,arrNode0Values[6]);
                 }  
               ///////////////////////////////////////////////// 
            }  
            }
            //Added By Bharat T on 23rd-Feb-2016 for fav tab refresh issue
            if(objtxtSearch.value!='')
                //End of Added By Bharat T on 23rd-Feb-2016 for fav tab refresh issue
                LoadFirstNode(NewTree);
        }
        
}
function LoadFirstNode(NewTree)
{
 //   blnLoadFirstNode = true;

    var i;
    var Node;
    var arr;
    var strPageName;
    var objST=GetObjectReference('frmTree','txtSearch');
    
    for(i=0;i<NewTree.length;i++)
    {
        Node=NewTree[i].split("|");

        
        //added By purvaj on 14 jul 2009
        //TabItemOnClick('../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI',3,3);
         if ("<%=m_strTemplateID %>"=="DB" )
         {
             if ("<%=m_CRMDefaultPage%>" !=  "" && objST.value=="")
             {
               arr = ("<%=m_CRMDefaultPage%>").split("|");
           
            // TabItemOnClick('../General/CommonPage.aspx?MasterTagID=1085&ParentItemID=0',0,0);
                if(arr[0].indexOf("?")<0)
                    strPageName = arr[0]+ "?DashboardID="+arr[1];
                else
                    strPageName = arr[0]+ "&DashboardID="+arr[1];
            }
            else
            {
                if(Node[3]!="")
                    strPageName= Node[3];
                else
                    strPageName=""    
            }
            
            if(strPageName!="")
            {
             TabItemOnClick(strPageName,0,0);
             break;
            } 
         } 
         else
         { 
           
            if ( "<%=m_strTemplateID %>"=="CRM" )
            {
                    if(objST.value!="")
                    {
                        if(Node[3]!="")
                        {
                            TabItemOnClick(Node[3],0,0);
                            break;
                        }    
                    }    
                    else 
                    {   
                        TabItemOnClick("<%=m_CRMDefaultPage%>",0,0);
                          break;
                     }     
            }
           else // end addition purvaj 
           {
                if(Node[7]=="0")
                {
                
                        if(IsProjectSelected || Node[0]=="32" || Node[0]=="3936")
                        {
                        
                            TabItemOnClick(Node[3],Node[0],Node[5]);
                            break; 
                        }
            //            else
            //            {
            //                if(Node[7]=="32" || )
            //            }
                    
                }
          }
       }
    }   
}

function SortTree(TagID)
{

    var i;
    var Values;
    ///Add Self
    for(i=0;i<Tree.length;i++)
    {
        Values=Tree[i].split("|");
        if(Values[0]==TagID)
        {
            NewTree[SortedTreeIndex]=Tree[i];
            SortedTreeIndex++;
            break;
        }
    }
    
    ///Add Child folders 
    for(i=0;i<Tree.length;i++)
    {
        Values=Tree[i].split("|");
        if(Values[1]==TagID )//&& Values[7]==-1)
        {
           NewTree[SortedTreeIndex]=Tree[i];
           SortedTreeIndex++;
            if(Values[7]=="-1")
            {
                SortTree(Values[0]);
            }
        }
    }

}   

//End Addition By Amol Changle



   
function GetProjectListNode()
{   
    var j;
    for(j=0;j<Tree.length;j++)
    {
        Values=Tree[j].split("|");
        if(Values[0]==32)
            return Tree[j];
     }
     
     return NewTree[0];  
}   
   
     function SetDefaultTheme()
   {
        var strTagIDList=",1038,661,34,2133,1019,454,";
    
        if(strTagIDList.match(','+objhidtagid.value+',')!=null)
        {
            loadXMLDoc("../Home/AJAXHttp.aspx?From=DefaultTheme","ThemeID="+objhidtxtThemeID.value+"&MasterTagID="+ objhidtagid.value,"FAV");
            objhidtxtThemeID.value='';
        }
        else
        {
            alert('Views is not applicable for this page !');
            return;
        }   
     
    
   }   
   ////////////////////////////////////////////////////////////////////
   
	
	function ShowPreviousFAV()
    {
    var objprevLeft=GetObjectReference('','prevLeft');
    if(GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
    }
    //Added By Chakshuta H on 19th-Aug-2016 Purpose:Qa issue fixing
    if(objtxtFAVPageNumber!=undefined)
    {
        //End Of Added By Chakshuta H on 19th-Aug-2016 Purpose:Qa issue fixing
        if (isBlank(objtxtFAVPageNumber.value))
            PageFAV_Onclick(1);
        else
        {
		     		
            if (objtxtFAVPageNumber.value==1){
                //alert("This is the first favorites");
                if(objprevLeft!=null) objprevLeft.disbled=false; objprevLeft.disabled=true;
                return;
            }
            objprevLeft.disabled=false;
            objtxtFAVPageNumber.value=objtxtFAVPageNumber.value -1;
            PageFAV_Onclick(objtxtFAVPageNumber.value);
        }
    }
		
    }
    
    function ShowNextFAV()
    {
        
        var objprevRight=GetObjectReference('','prevRight');
    
    if(GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmAdvancedTimesheet','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmAdvancedTimesheet','txtFAVPageNumber');
    }
        //Added By Chakshuta H on 19th-Aug-2016 Purpose:Qa issue fixing(Issue id -4434)
    if(objtxtFAVPageNumber!=undefined)
    {
        //End Of Added By Chakshuta H on 19th-Aug-2016 Purpose:Qa issue fixing
        if (isBlank(objtxtFAVPageNumber.value))
        {
	    
            PageFAV_Onclick(1);
        }    
        else
        {  
		 
            if (objtxtFAVPageNumber.value==parseInt(noOfFAVs)){
		     
                if(objprevRight!=null) objprevRight.disabled=true;
                //alert("This is the last favorites");
                return;
            }		 
            if(objprevRight!=null)  objprevRight.disabled=false;
            objtxtFAVPageNumber.value=parseInt(objtxtFAVPageNumber.value) + 1;
    		
            PageFAV_Onclick(objtxtFAVPageNumber.value);
    		 
        }
    }
   } 
   
   function PageFAV_Onclick(PageNumber)
		{
			//Added By purvaj on 14 Jul 2009 SEM 8.1 New UI favourites displayd on all the tabs now
			var objhidTemplateID=GetObjectReference('','hidTemplateID'); 
			// End additon purvaj
			
		    var strURL = "Home_FloatingMenu.aspx?Mode=GoTo&IsXMLHttp=1&FromWhere="+objhidTemplateID.value+"&TemplateID="+objhidTemplateID.value;
	
	       if (navigator.appName == 'Microsoft Internet Explorer')
	            strURL=strURL+"&browserType=IE";
	        else
	            strURL=strURL+"&browserType=FireFox";
	            	            
	            
		    loadXMLDoc(strURL+"&PageNumber=" + String(parseInt(PageNumber)),'',"FAVTAB");
		
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
                 {
                
                    objtdTabs.innerHTML=xmlhttp.responseText;
                 }   
                  
                    
               } 
         
             
      }
      else
      {
      alert("Problem in transfering data:" + xmlhttp.statusText)
      }
      }
    }
   ////////////////////////////////////////////////////////////////////

   function Tab_OnClick(strFromWhere)
   {
      // debugger;
	    var subPage='../Home/Home.aspx?FromWhere='+strFromWhere;
	   // if(strFromWhere!='CRM')           
       //Added By Aniruddh Gujar on 06-Dec-2018
       if (strFromWhere == 'CRM') {
           if ('<%= AllowVersionChange%>' == "1") {
               window.open("../General/Navigation.aspx?FromWhere=" + strFromWhere, "_top")
           }
           else {
               $.ajax({
                   url: "../General/Navigation.aspx/ChangeVersion",
                   data: JSON.stringify({ VersionID: "2" }),
                   dataType: "json",
                   contentType: "application/json",
                   type: "POST",
                   success: function (result) {
                       var strFromWhere = '<%=Session("strActiveModule")%>';
                       window.open("../General/Navigation.aspx?FromWhere=" + strFromWhere + "&FromOld=405", "_top")
                   }
               })
           }
       }
       //End of Added By Aniruddh Gujar on 06-Dec-2018
       else {
           window.open("../General/Navigation.aspx?FromWhere=" + strFromWhere, "_top")
       }
		/*else
		    {
		      objform.action='../Home/Home.aspx?FromWhere=CRM';
              objform.submit();     
		    }    */
	}
	
   function ShowHideModules(shrink)
   {

       var objimgUpDown=GetObjectReference('','imgUpDown');
       var objTRModules=GetObjectReference('','trModules',true);
       var objhidTxtModules=GetObjectReference('','hidTxtModules');
       var objtdModuleBar=GetObjectReference('','tdModuleBar');
       var objtrModuleBar=GetObjectReference('','trModuleBar');
	    
       var IsShrink=false;
	    
       //obj.className='clsTDScroll';
	    
       if(objimgUpDown==null && objTRModules==null)
           return;

 

       for(i=0;i<=objTRModules.length-1;i++)
       {
       
           if(objTRModules[i].style.display=='')
           {
               objTRModules[i].style.display='none'; 
               IsShrink=true;
	           
           }
           else
           {
               objTRModules[i].style.display=''; 
	          
               IsShrink=false;
           }
       } 
	  
       var height=window.innerWidth;//Firefox
       if (document.body.clientHeight)
       {
           height=document.body.clientHeight;//IE
       }
    
       if (shrink == null)
       {
           IsShrink=false;
       }
    
    
       if(IsShrink)
       {
           objimgUpDown.src="<%=m_strRModuleBarImage%>";//'../../Images/Sort_up.gif';
           if(objhidTxtModules!=null && objtrModuleBar!=null)
           {
               objtdModuleBar.innerHTML=objhidTxtModules.value;
               objtrModuleBar.style.display='';
           }   
           //Commented And Added By Vaijat K ON 12/01/2016
           //if (navigator.appName=="Netscape")     
           //    document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-340)+"px";
           //else    
           //    document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-110)+"px";
           if(WhichBrowser() == 'FF'){
               document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-97+"px";
           }
           else{
               document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-97+"px";
           }
           //Ended
           //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight-120))+"px";	  
           
           document.getElementById("divTree").style.verticalAlign="top";
       }
       else
       {
           objimgUpDown.src="<%=m_strModuleBarImage%>";//'../../Images/Sort_down.gif';
           if(objhidTxtModules!=null && objtrModuleBar!=null)
           {
               objtrModuleBar.style.display='none';
           }   
           //Commented And Added By Vaijat K ON 12/01/2016
           //if (navigator.appName=="Netscape")
           //    document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+135))+"px";

           //else
           //    document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+65))+"px";

           if(WhichBrowser() == 'FF'){
               document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-97+"px";
           }
           else{
               document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-(objtrGM.offsetHeight))-97+"px";
           }
           //Ended
       }
	   
       if (navigator.appName=="Netscape") 
       {
           if(IsShrink)
           {document.getElementById("tdTree_Inner").style.height="";}
           else
           {
               document.getElementById("tdTree_Inner").style.height=document.getElementById("tdTree_Inner").offsetHeight-8;
           }
       } 

   }
	
	
    ////////////////////////////////////////////////////////
    function cboDashboard_OnChange(ev)
	// For selecting the user's e-DB 
    {
        //debugger;
		var strPageName;
		var arr;
		var objcboDashboard;
		objcboDashboard = GetObjectReference('','cboDashboard');
		var strURL="";
		strPageName = objcboDashboard.value;
	
		if (trimString(strPageName + "") != "") 
		{
			arr = strPageName.split("|");
			
			if (isSubstringExists(arr[0],'?'))
			{
				strURL = "" + arr[0] + "&DashboardID=" + arr[1];
			}
			else
			{
				strURL = "" + arr[0] + "?DashboardID=" + arr[1];
			}
			
		}
		else
		{
			var lnk = window.location.href ;
			var arrlnk = lnk.split("?")
			var arrDashboardID= arrlnk[1].split("&");
			var arrIDs = arrDashboardID[0].split("=");
			strURL = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=Home%3FID=" + arrIDs[1]+"%26amp;DB=|0"; 	
		}
	
        if (trimString(strPageName + "") != "") {
            if (arr[1] == "21000") {
                TabItemOnClick(strURL, 21000, 0);
            }
            else if (arr[1] == "21006")
            {
                TabItemOnClick(strURL, 21006, 0);
            }
            else {
                        TabItemOnClick(strURL,0,0);
                    }
        }else {
            TabItemOnClick(strURL,0,0);
        }
	    
	  //  calcHeight(); 
	}
	
	


    ////////////////////////////////////////////////////////


</script>    
	 

</body>
</html>
