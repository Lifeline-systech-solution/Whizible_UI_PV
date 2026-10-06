<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="Links.aspx.vb" Inherits="PbNIT.Links" %>
<!DOCTYPE HTML>
<HTML>
		<%
	If m_blnDefaultNavigation = False Then 
	CommonFunctions.General.PlotPageHeadTag("", , , , "<LINK rel='stylesheet' type='text/css' href='" & m_CSSFile &"'></LINK>")
	Else
		CommonFunctions.General.PlotPageHeadTag("")
	End If
%>
    <!-- dhanashri -->
    <style type="text/css"> 
        BODY.clsBodylnks
       {
            background-color:#e39321;
       }
    </style>

	<!--<body topMargin="0" class="clsBodyLinks" onLoad="showRequestedMenu()" leftMargin="0" rightMargin="0" bottomMargin="0">-->
	<!--Integrated by MrugajaB on 19th Dec 2005-->
<!-- Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 - For applying new navigation theme. -->
	<body class=
	<%If m_blnEnableTabNavigation = True Then 
		CommonFunctions.General.WriteHTML("""clsBodyLinks""")
	Else
		CommonFunctions.General.WriteHTML("""clsBodylnks""")
	End If%>
		style="margin-top:0; margin-left:0; margin-right:0 ;margin-bottom:0" 
	<%If m_blnDefaultNavigation = False Then 
		CommonFunctions.General.WriteHTML(" onLoad=""showRequestedMenu()""")
	End If%>  onload='DrawModules()'>
	<!-- Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 -->

	<iframe id="iFloatingMenu" style="display:none;z-index:100; position:absolute;overflow:visible;" ></iframe>
	
		<!--Modified by RajeshB Issue 14303: Dec 08, 2004.-->
		<%If m_blnDefaultNavigation = True Then 
		CommonFunctions.General.WriteHTML("<form id=""frmLink"" method=""post"" runat=""server"">")
		End If%>
		<!--Modification Ends -->
		<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
        <script type="text/javascript" src="../../responsive/responsive.js"></script>
        <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
		<script language="javascript" src="radmenu_client.js"></script>

		<SCRIPT language="javascript">	

		    //Add By Dipali Vekhande On 16th Aug 2016 For Close Login Window After Session Out
		    $(document).ready(function () {

		        if (parent.document.getElementById("closehidden") != null)
		            parent.document.getElementById("closehidden").value = 1;

		        $(document).mousedown(function (e) {

		            if (parent.document.getElementById("closehidden") != null)
		                parent.document.getElementById("closehidden").value = e.button;

		            if (e.button == 2) {
		                alert('Due to security reason,Right Click is not allowed!');
		                return false;
		            } else {
		                return true;
		            }

		        });

		    });
		    //End of Addition By Dipali Vekhande On 16th Aug 2016 for Close Login Window After Session Out


			var objForm;
			objForm=GetFormReference('frmLink');
			var source;	
		  var objFrame=GetObjectReference('','iFloatingMenu');
		  
	function SetDefaultProject()
		  {
	    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
	    setFrameLoader();
	    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		objForm.action = "Links.aspx?Mode=SetDefaultProject"
		objForm.submit();
	}
	function ResetDefault()
	{
	    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
	    setFrameLoader();
	    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		objForm.action = "Links.aspx?Mode=ResetDefault"
		objForm.submit();
	}
	function SetDefaultModule()
	{
	    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
	    setFrameLoader();
	    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		objForm.action="Links.aspx?Mode=SetDefaultModule"
		objForm.submit();
	}
	function MyProfile_OnClick()
	{
		window.open("CommonPage.aspx?MasterTagID=1085&ParentTagID=0", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
	}
		function MyTheme_OnClick()
	{
		window.open("CommonPage.aspx?MasterTagID=1511&ParentTagID=0", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=350,height=240");
		}
function Documents_OnClick()
{
		window.open("../Enhancement/DocumentDownLoad.aspx?MasterTagID=21179&FromWhere=SM&ParentTagID=0", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=500,height=400");

}
 
	//Added By VarunA on 9-May-2008 
	function MyProject_OnClick()
	{
		window.open("../PM/ProjectSelection_CommonList.aspx?FromWhere=PM&MasterTagID=8026", "","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height -760)/2 + ",width=800,height=660");
	}
	//End By VarunA on 9-May-2008

	function Tab_OnClick(strFromWhere)
	{
	                   
		window.open("Navigation.aspx?FromWhere=" + strFromWhere,"_top")
	}
	function changeUser()
	{
	   
	    window.open("../../Default.aspx?Message=CU", "_top");
	}

	function Logout(strLogoutPage)
	{
	   
        if (confirm("Are you sure want to logout?")) {
            
            var allowADFSRedirection = '<%=System.Configuration.ConfigurationManager.AppSettings("AllowADFSRedirection").ToString%>';
            var strAPIUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("IntegrationAPIUrl").ToString%>';
            if (allowADFSRedirection == '1') {
                $(document).ready(function () {
                        $.ajax({
                            type: "GET",
                            url: strAPIUrl + "Auth/Logout",
                            dataType: "json",
                            contentType: "application/json",
                            success: function (data) {
                                window.open("../../Default.aspx?Message=LOGOUT", "_top");
                            },
                            error: function (xhr, status, error) {
                                window.open("../../Default.aspx?Message=LOGOUT", "_top");
                            }
                        });
                })
            }
        }
	}

		    //Added by kiran k k 
	 
	function Download_OnClick() { 
	   // var did = 136;
	    //window.open("../PM/PM_ViewDocument.aspx?MasterTagID=20175&FromWhere=SM&DocumentID=" + DID, "", "left=" + (window.screen.width - 500) / 2 + ",top=" + (window.screen.height - 400) / 2 + ",width=500,height=300");
		window.open("../Enhancement/DocumentDownLoad.aspx?MasterTagID=21179&FromWhere=SM&ParentTagID=0", "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=500,height=400");
	   //Commented Added By shamkant S on 5 Dec 2015
	   // window.open("../General/ViewAttachment.aspx?FileName=Lighthouse.exe&FromWhere=Documents");
	} 

            //added end by kirank k 
        </SCRIPT>
			<%Call PageInit%>
			</FORM>
		<!--Integrated by MrugajaB on 19th Dec 2005-->
		<!-- Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 - For applying new navigation theme. -->
		<%
		If m_blnEnableTabNavigation = True Then
			If m_blnDefaultNavigation = True Then 
			CommonFunctions.General.WriteHTML("<script language='javascript' src='staticlogo3.js'></script>")
			End IF
		End IF
		%>
        <!-- Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 -->
		<!--End Integration-->
		
		<SCRIPT language='javascript' src='CommonFunctions.js'></SCRIPT>

		<SCRIPT language="javascript">	
			var intframewidth;
			intframewidth="<%=intFrameWidth%>";
			var blnTreeHide;
			blnTreeHide=0;
			var img;
			img=GetObjectReference('frmLink','ImgID');
			
			<%'Modified BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 Swaped the Img1 and Img2%>
//			function hideshowtree()
//			{
//			  var img1;
//			  var img2;
//			  img1='../../images/TreeOff.gif';
//			  img2='../../images/TreeOn.gif';
//			  var pf;
//			  pf=GetParentFrameReference();
//			  if(blnTreeHide==0)
//			  {
//				blnTreeHide=1
//				//Commented by PrasannaP for Netscape Implementation on 31/5/2005
//				//Issue ID 28888
//				//pf['frmDown'].cols='0,*';
//				//End Comment
//				//Added by PrasannaP for Netscape Implementation on 31/5/2005
//				window.top.document.getElementById('frmDown').cols='0,*'
//				//End addition
//				img.src=img2;
//			 }
//			  else
//			  {
//				blnTreeHide=0;
//				var strcols;
//				strcols=intframewidth + ',*'
//				//Commented by PrasannaP for Netscape Implementation on 31/5/2005
//				//Issue ID 28888
//				//pf['frmDown'].cols=strcols;
//				//End Comment
//				//Added by PrasannaP for Netscape Implementation on 31/5/2005
//				window.top.document.getElementById('frmDown').cols=strcols;
//				//End addition
//				img.src=img1;
//			  }
//			}

/*----------------------------------------------------------*/
// Starts whiz41-ResponsiveHideTreeArrowFunctionality:
// Description:This function is used to hide and show the tree on click of the arrow
// By Whom: Miiint
// When:20/01/2015
/*---------------------------------------------------------*/

		function hideshowtree()
			{
			  var img1;
			  var img2;
			  var subWidth;
			  img1='../../images/TreeOff.gif';
			  img2='../../images/TreeOn.gif';
			  var pf;

			  pf=GetParentFrameReference();
			  if(blnTreeHide==0)
			  {
				blnTreeHide=1;
				window.top.document.getElementById('Main').style.display='none';
				var subClassName=window.top.document.getElementById("Sub").getAttribute("class");
				var modClassName=subClassName+' '+'hideTree';
				window.top.document.getElementById("Sub").setAttribute("class",modClassName);

				img.src=img2;
			 }

			  else
			 {
				blnTreeHide=0;
				var strcols;

				strcols=intframewidth + ',*';

				window.top.document.getElementById('Main').style.display='block';
				var subClassName=window.top.document.getElementById("Sub").getAttribute("class");
                var modClassName;
               if(subClassName.indexOf("hideTree") > 0)
               {

                    modClassName=subClassName.replace('hideTree','');

               }
               else
               {
                    modClassName=subClassName;
               }
                window.top.document.getElementById("Sub").setAttribute("class",modClassName);

				img.src=img1;
			  }
			}
/*---------------------------------------------------------*/
// Ends whiz41-whiz41-ResponsiveHideTreeArrowFunctionality:
/*---------------------------------------------------------*/
			<%'End Modification BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 Swaped the Img1 and Img2%>			
			
			function Alerts_OnClick()
			{
			//window.open("CommonList.aspx?MasterTagID=5147&ParentTagID=0", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
			//Commented and added by SUchitraP on 22-Aug-2008 for Alert Change
			//window.open("../DB/Alerts_CommonList.aspx?MasterTagID=3707&ParentTagID=0", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
			//Added '_popup' for IssueID 24167 :  Multiple windows for project alerts get open.
			window.open("../General/Tab_Viewpage.aspx?FromWhere=ALERTS", "_popup2", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 800)/2 + ",width=900,height=800");
			//End by SuchitraP
			}
			var objModuleDiv=GetObjectReference('','divModules');
			    
			function ShowModuleDiv(e)
			{
			if(objModuleDiv.style.display=='none')
			    showmenuie(objModuleDiv,e);
			  else
			      objModuleDiv.style.display='none';
			   /*objModuleDiv.style.display=''
			   objModuleDiv.style.left=0;*/
			}
			function HideModuleDiv()
			{
			if(objModuleDiv.style.display=='')
			    objModuleDiv.style.display='none';
			}

    var ie5=document.all&&document.getElementById;
    var ns6=document.getElementById&&!document.all;
    
	function showmenuie(objdiv,objevent)
	{
       objdiv.style.display='';
       objdiv.style.position = 'absolute'; 
  // objdiv.style.z-index='100';
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
   var objtdModule=GetObjectReference('','tdModule');
   var objcboModule=GetObjectReference('','cboModules');
   var noofmoduels=0;
   
   function ShowPreviousModule()
   { 

    var objhidTxtModuleON=GetObjectReference('','hidTxtModuleON');

         var j=0; t=3;  
     var strHTML="";
     var strOrderNumber="";
     
         for (i=0;i<objcboModule.length;i++)
        {
            if(String(objcboModule[i].value)==String(objhidTxtModuleON.value))
              {
                        j=i; 
                        break;
              }    
         }     
  // debugger;
   
   if(noofmoduels==0)
            noofmoduels=3;
     
    
        j=j-(noofmoduels-1);
        
        noofmoduels=0;
    
        if(j==2)
         t=2;
         
        if(j==1)
         t=1;
     
        for(k=t;k>=1;k--)
        {
          
           if(j-k < 0)
                return;
                
                if(objcboModule[j-k]!=null)
                {
                  strHTML= strHTML+ objcboModule[j-k].text;
                  strOrderNumber=objcboModule[j-k].value;
                  noofmoduels=noofmoduels+1;
                 } 
                  else
                  {
                    if(objcboModule[j-k-1]!=null)
                        strOrderNumber=objcboModule[j-k-1].value;
                  }  
            
        }  
            
                
            objhidTxtModuleON.value=strOrderNumber;
            
        if(strHTML!="")                    
          objtdModule.innerHTML='&nbsp;&nbsp;'+strHTML;
    
   }
   function ShowNextModule()
   {
    var objhidTxtModuleON=GetObjectReference('','hidTxtModuleON');
    noofmoduels=0;
    
         var j=0;   
     var strHTML="";
     var strOrderNumber="";
     
         for (i=0;i<objcboModule.length;i++)
        {
            if(String(objcboModule[i].value)==String(objhidTxtModuleON.value))
              {
                        j=i; 
                        break;
              }    
         }     
        
        for(k=1;k<=3;k++)
        {
            if(objcboModule[j+k]!=null)
            {
              strHTML= strHTML+ objcboModule[j+k].text;
              strOrderNumber=objcboModule[j+k].value;
              noofmoduels=noofmoduels+1;
             } 
              else
              {
                if(objcboModule[j+k-1]!=null)
                    strOrderNumber=objcboModule[j+k-1].value;
              }  
        }  
            
                
            objhidTxtModuleON.value=strOrderNumber;
            
        if(strHTML!="")                    
          objtdModule.innerHTML='&nbsp;&nbsp;'+strHTML;
       
   }
   function ScrollTillEnd()
   {
  
  /*  for(i=0;i<3;i++)
    {
        ShowNextModule();
    }*/
   }
   
   function DrawModules()
   {
       if(objtdModule==null)
       return;
   
     var objhidTxtModuleON=GetObjectReference('','hidTxtModuleON');
     var j=0;   
     var strHTML="";
     var strOrderNumber="";
     
         for (i=0;i<objcboModule.length;i++)
        {
            if(String(objcboModule[i].value)==String(objhidTxtModuleON.value))
              {
                        j=i; 
                        break;
              }    
         }     
         if(j>0)
         {
            if(objcboModule[j-1]!=null)
            {
                 strHTML= strHTML+ objcboModule[j-1].text;
                 strOrderNumber=objcboModule[j-1].value;
            }     
          
            if(objcboModule[j]!=null){
                 strHTML= strHTML+ objcboModule[j].text;
                 strOrderNumber=objcboModule[j].value;
                 }
            
            if(objcboModule[j+1]!=null){
                 strHTML= strHTML+ objcboModule[j+1].text;
                 strOrderNumber=objcboModule[j+1].value;
                    }
          
            objhidTxtModuleON.value=strOrderNumber;
         }
         else
         {
            if(objcboModule[j]!=null)
            {
              strHTML= strHTML+ objcboModule[j].text;
              strOrderNumber=objcboModule[j].value;
             } 
          
            if(objcboModule[j+1]!=null){
                 strHTML= strHTML+ objcboModule[j+1].text;
                 strOrderNumber=objcboModule[j+1].value;
                } 
            
            if(objcboModule[j+2]!=null)
            {
                 strHTML= strHTML+ objcboModule[j+2].text;
                 strOrderNumber=objcboModule[j+2].value;
             }    
                 
           objhidTxtModuleON.value=strOrderNumber;
            
         } 
                    
          objtdModule.innerHTML='&nbsp;&nbsp;'+strHTML;

   }

		</SCRIPT>
		<style type="text/css">
            /* .tabbed
             {
                 width: 90%;
                 float: left;
             }*/

             .clsTableBannerFrame .clsTableNavLinks
             {
                 width: 100%;
                 float: left;
             }

             .arrow_img
             {
                 width: 2%;
                 float: left;
                 BACKGROUND: url(../../Images/cssImages/blue_color_2.gif);
                 height: 30px;
             }

             .arrow_img img
             {
                position: absolute;
                bottom: 28px;
             }
           /*  ul.tabbed {
                 margin:auto;
                 padding: 0;

             }
             ul.tabbed li {
                 float: left;
                 list-style: none;
                 *//* width:110px;*//*
             }*/

                /*Added by Dhanashri on 5 Mar 2015*/
             .clsTableBannerFrame .clsTableNavLinks td a {
                    /*font-size: 14px;*/
                    font-size:11px;
                    font-weight:bolder;
             }
             /*Ended by Dhanashri*/

             #custom_ul li {
                 float: left;
                 list-style: none;
                 font-size: 14px;
                 padding-left:10px;
                 padding-right:10px;
                 /* width:110px;*/
             }

             ul li {
                 float: left;
                 list-style: none;
                 font-size: 14px;
                 padding-left:5px;
                 padding-right:5px;
                 /* width:110px;*/
             }

             ul
             {
                 padding:0px;
             }
             .additional_menu
             {
                 width: 50%;
                 float:right;
                 /*border: 1px solid red;*/
                 BACKGROUND: url(../../Images/cssImages/blue_color_2.gif);
             }
             .additional_menu li
             {
                 width: 100%;
             }

             a.clsNavTab
    {
        font-family: 'Helvetica';
        /*font-size: 11px;*/
		font-size:9px;
        COLOR: #ffffff;
        FONT-WEIGHT: bold;
        TEXT-DECORATION: none;
        POSITION: relative;
		margin-left:20px;
    }
         </style>

         <script type="text/javascript">
          //var windowwidth;
          //    $(document).ready(function() {

          //        });


          </script>

	</body>
</HTML>
