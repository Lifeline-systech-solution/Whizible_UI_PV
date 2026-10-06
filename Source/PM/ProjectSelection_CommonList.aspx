<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Remove plus(+)in Tablet and Mobile view
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        /*Generating 'id' for table row if it has no 'id'*/
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

            var rowIndex = $(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false) {
            }

            else {
                $(this).attr('id', 'rowId' + rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
            $(this).remove();

        });
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Apply Footable For Grids
        // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('.clsTable:last').css({ 'display': 'none' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else {
            $('.clsTable:last').css({ 'display': 'block' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:21/01/2015
        /*---------------------------------------------------------*/

        responsiveFooterMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>

<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectSelection_CommonList.aspx.vb" Inherits="PbNIT.ProjectSelection_CommonList"%>


<!--<style type="text/css" >
SPAN.ProjectSpan {
	BORDER-RIGHT: #000 1px solid ; 
	PADDING-RIGHT: 3px; 
	BORDER-TOP:  #000 1px solid ; 
	PADDING-LEFT: 10px; 
	BACKGROUND: #484848;
	PADDING-BOTTOM: 0px; 
	BORDER-LEFT:  #000 1px solid ; 
	COLOR: #fff; 
	PADDING-TOP: 0px; 
	BORDER-BOTTOM:  #000 1px solid ;
	background-image:url(../../Images/demoChartBg12.gif);
	cursor:hand;
	font-size:15;
	color:Black ;
	vertical-align:middle ; 
	height:50px;
	width:375px
   }
</style>-->


<script language="javascript">

	 	var objdivPOPUP=document.getElementById("divContextMenu");
	 	var url;
	 	
	 	var ie5=document.all&&document.getElementById
        var ns6=document.getElementById&&!document.all
        var FromWhere=GetObjectReference('','FromWhere').value;
        
        document.body.className="clsPopUpBody";
        //debugger;
        GetObjectReference('','divListPageTag').style.border="black 1px outset";
        
        /*document.onmouseup=function(){HideCM('divContextMenu');}
        
	    document.onmousedown=function(evt)
	    {
	    if (objdivPOPUP!=null)
	        {
	          objdivPOPUP.innerHTML="";  
	          objdivPOPUP.style.visibility="hidden"; 
	        } 
	     	       
	    } */

function ShowContextMenu(ev,ProjectID)
{   
    WHIZ_SetContextMenuNode('trCtSelectProject','Javascript:SelectProject_OnClick(' + ProjectID + ')','',"Select Project","Select Project");
    WHIZ_SetContextMenuNode('trCtAddToFavourite','Javascript:AddToFavourites_OnClick('+ ProjectID +')','',"Add To Favourites","Add To Favourites");    
	WHIZ_SetContextMenuNode('trCtRemoveFromFavourite','Javascript:RemopveFromFavourites_OnClick(' + ProjectID+ ')','',"Remove From Favourites","Remove From Favourites");
		    
    var objTRSelectProject = GetObjectReference('','trCtSelectProject');
    var objTRAddToFavourites =GetObjectReference('','trCtAddToFavourite');
    var objTRRemoveFromFavourites =GetObjectReference('','trCtRemoveFromFavourite');
    var strAction='<%=strAction%>';
    
            if (objTRSelectProject != null)
                objTRSelectProject.style.display='';
                
            if (objTRAddToFavourites != null)    
            if(strAction=="" || strAction=="ADDFAV" || strAction=="SHOWALL" || strAction=="PROJSEL")
                objTRAddToFavourites.style.display=''; 
             else
                objTRAddToFavourites.style.display='none'; 
            
            
            if (objTRRemoveFromFavourites != null)
            if(strAction=="SHOWFAV" || strAction=="REMFAV")
                objTRRemoveFromFavourites.style.display='';
            else       
                objTRRemoveFromFavourites.style.display='none';
            
    showmenuie('divContextMenu',ev);
    //ShowPopup(ev,ev.clientX,ev.clientY,'divContextMenu');
}

function showmenuie(divCM,objevent){

var objdiv = GetObjectReference('',divCM);
var objDivList=GetObjectReference('','divListPageTag');

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
        objdiv.style.top=ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight
    else
    objdiv.style.top=ie5? document.body.scrollTop+event.clientY -(100-objDivList.scrollTop): 
        window.pageYOffset+objevent.clientY
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
    if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        e.stopPropagation();
   
  
   return false;
  
   }
   
   function WHIZ_SetContextMenuNode(sNodeID,sfunction,sLinkImage,sLinkName,sLinkTitle)
{      
    var objCtNode= GetObjectReference('',sNodeID);
    var objCtName,objCtImage;
    
    if (sNodeID.length > 2)
    {
        objCtName = GetObjectReference('','td' + sNodeID.substring(2,sNodeID.length));      
        if(objCtName)
        {
            sLinkName = ReplaceSubStringForCtMn(sLinkName);
            objCtName.innerHTML = sLinkName + "&nbsp;";
        }
        objCtImage = GetObjectReference('','tdImg' + sNodeID.substring(2,sNodeID.length));
        if(objCtImage)
        {
            if(sLinkImage && trimString(sLinkImage)!='')
            {
                sLinkImage = ReplaceSubStringForCtMn(sLinkImage);
                objCtImage.innerHTML = "<img src='" + sLinkImage + "'>";
            }
            else
            {
                objCtImage.innerHTML = "";
            }
        }
    }
    if (objCtNode)
    {
        if (sfunction != '')
        {
            objCtNode.className='CtMn_Node';
            objCtNode.onmouseover= function(){this.className='CtMn_Node_Hover';};
            objCtNode.onmouseout= function(){this.className='CtMn_Node';};
        }
        else
        {
            objCtNode.className='CtMn_Node_Disabled';
            objCtNode.onmouseover='';
            objCtNode.onmouseout='';
        }
        
		if(navigator.appName == 'Microsoft Internet Explorer')
        {
			objCtNode.onclick=function(){sfunction = ReplaceSubStringForCtMn(sfunction);eval(sfunction);}
		}
		else
		{
			objCtNode.onmousedown = function(){sfunction = ReplaceSubStringForCtMn(sfunction);eval(sfunction); return;}
		}

        if (sLinkTitle)
        {   
            sLinkTitle = ReplaceSubStringForCtMn(sLinkTitle);
            objCtNode.title = sLinkTitle;
        }
        else
        {
            objCtNode.title = '';
        }
    }
}

function HideCM(divCM)
{
    
    objCM=GetObjectReference('',divCM)
    if (objCM !=null)
    {
    objCM.style.display='none';
    }
}

function SelectProject_OnClick(ProjectID)
{
    objForm.action="../PM/ProjectSelection_CommonList.aspx?FromWhere="+FromWhere+"&MasterTagID=8026&Action=SelectProject&ProjectID="+ProjectID;
    objForm.submit();
}

function AddToFavourites_OnClick(ProjectID)
{
    objForm.action="../PM/ProjectSelection_CommonList.aspx?FromWhere="+FromWhere+"&MasterTagID=8026&Action=AddToFavourites&ProjectID="+ProjectID;
    objForm.submit();
}

function RemoveFromFavourites_OnClick(ProjectID)
{
    objForm.action="../PM/ProjectSelection_CommonList.aspx?FromWhere="+FromWhere+"&MasterTagID=8026&Action=RemoveFromFavourites&ProjectID="+ProjectID;
    objForm.submit();
}


function ShowPopup(evt,x,y,sContextMenuID)
    {      
        AdjustDiv('divContextMenu',evt,x,y);
    }
    
    function AdjustDiv(divCM,objevent,x,y)
    {
        var ie5=document.all&&document.getElementById;
        var ns6=document.getElementById&&!document.all;
        var objdiv = GetObjectReference('',divCM);
        var objPopUpDiv = GetObjectReference('','divContextMenu');
           objPopUpDiv.innerHTML =  objdiv.innerHTML;
           //objdiv.style.display='';
           //objdiv.style.position = 'absolute'; 
           
           objPopUpDiv.style.display='';
           objPopUpDiv.style.position = 'absolute'; 
           
           
           if((document.body.offsetHeight - y - 5) <= objPopUpDiv.offsetHeight)
            {
                 y = y - objPopUpDiv.offsetHeight;
            }
            if((document.body.offsetWidth - x - 5) <= objPopUpDiv.offsetWidth)
            {
                x = x - objPopUpDiv.offsetWidth;
            }
            objPopUpDiv.style.left = x;
            objPopUpDiv.style.top = y;
       }
    
    
    
	function mouseCoords(ev)
    {
		if(ev.pageX || ev.pageY){
		return {x:ev.pageX, y:ev.pageY};
		}
		return {
			x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
			y:ev.clientY + document.body.scrollTop  - document.body.clientTop
		};
	}
	
	function CloseFrame_OnClick() 
	{ 
//	    document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.style.display='none'; 
//	     document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent(1).frameElement.src=''; 	
 //For Firefox

      if (navigator.appName == 'Microsoft Internet Explorer')
    {
          //for IE
          // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.style.display='none';
        document.forms[0].parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent[1].frameElement.src = "";
          //Ended
          
        
      
    }
    else
    { 
    
        window.parent.frames['iFloatingMenu'].frameElement.style.display='none';
        window.parent.frames['iFloatingMenu'].frameElement.src="";
        
        
    }

    }
	     
	//Added By Amol Changle On: 10 Sep 2009
	//When page loaded in IFRAME n viewed in FireFox, if   bgColor not set it shoes transperent page  
	document.body.bgColor="white";
	
</script>

   
