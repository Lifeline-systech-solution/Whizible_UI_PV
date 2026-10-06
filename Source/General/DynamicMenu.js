//Dropdown Menu
leftX=0;rightX=0;leftY=0;topY=0;lastMenu=null;topMenu=1;hControls="";aMenuId="";
function initializemenu(mainManu,subMenu,MenuTopFillFactor,MenuLeftFillFactor)
{
    
    if (MenuTopFillFactor == 2){MenuTopFillFactor = 1;}
	if(navigator.appName != 'Netscape') {	
			oMainmenu = eval(mainManu);
			oSubmenu = eval(subMenu + ".style");
			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
			
			MenuTopFillFactor = MenuTopFillFactor + 5;
			oSubmenu.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
			oSubmenu.top  = document.all[mainManu].offsetHeight + MenuTopFillFactor;
			}
	else
	{
			oMainmenu= document.getElementById(mainManu);
			oSubmenu = document.getElementById(subMenu);
			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
			
	    /********     COMMENTED AND ADDED BY Nilesh G ON 18-11-2015      ***********/
	    //if(divContainer!= null){
	    //	MenuTopFillFactor=eval(document.getElementById(divContainer).scrollTop * -1);
	    //	MenuLeftFillFactor=document.getElementById(divContainer).scrollLeft;
	    //}
	    /*******      END OF COMMENTED AND ADDED BY Nilesh G ON 18-11-2015     ************/
			if (document.getElementById('divContainer') != null || document.getElementById('divContainer') != undefined) {
			    MenuTopFillFactor = eval(document.getElementById('divContainer').scrollTop * -1);
			    MenuLeftFillFactor = document.getElementById('divContainer').scrollLeft;
			
			}
			oSubmenu.style.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
			oSubmenu.style.top  = calculateTotalOffset(oMainmenu, 'offsetTop')+ oMainmenu.offsetHeight+MenuTopFillFactor; //oMainmenu.offsetHeight + MenuTopFillFactor;
	}		
}
//function showmenu(mainManu,subMenu,MenuTopFillFactor,MenuLeftFillFactor,leftYFillFactor,EnclosingDiv,hideControls,actionMenuId)
//{
//	topY=0;
//	if(hideControls==null) {hControls=""}
//	else {hControls=hideControls;}

//	if(actionMenuId==null) {aMenuId=""}
//	else {aMenuId=actionMenuId;}

//    if (MenuTopFillFactor == 2){MenuTopFillFactor = 1;}
//	if(navigator.appName != 'Netscape') {	
//			oMainmenu = eval(mainManu);
//			oSubmenu = eval(subMenu + ".style");
//			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
//			
//        	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected";}		

//			MenuTopFillFactor = MenuTopFillFactor + 5;
//			oSubmenu.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
//			
//			oSubmenu.top  = document.all[mainManu].offsetHeight + MenuTopFillFactor;
//        	topY=calculateTotalOffset(oMainmenu, 'offsetTop')-3;
//	        if(EnclosingDiv!= "" && EnclosingDiv!= null){
//	            topY = topY - document.getElementById(EnclosingDiv).scrollTop;
//	        }
//			oSubmenu.visibility = "visible";		
//			//alert("Menu Left=" + oSubmenu.left + " Menu Top=" + oSubmenu.top+ " MenuLeftFillFactor=" + MenuLeftFillFactor);
//			leftX  = document.all[subMenu].style.posLeft;
//			rightX = leftX + document.all[subMenu].offsetWidth;
//			leftY  = document.all[subMenu].style.posTop+document.all[subMenu].offsetHeight + leftYFillFactor;
//			//topY = window.event.clientY-document.all[subMenu].offsetHeight; }
//			leftY=leftY + calculateTotalOffset(oMainmenu, 'offsetTop');
//			//alert("leftX=" + leftX + " rightX=" + rightX + " leftY=" + leftY + " topY=" + topY )
//			//hide controls that are displayed on top of the dropdown for IE versions older than 7.0 
//			if (msieversion() < 7)
//			{
//			    if(hControls != "") {
//			    var hideControls_array=hControls.split(',');
//			    for (i=0;i<hideControls_array.length;i++) {
//				    if (hideControls_array[i]!=null)
//					    {
//						    var oHd = document.getElementById(hideControls_array[i]);
//						    if (oHd != null) {oHd.style.visibility="hidden";}//Modified by PushkarK for WAF3_PB_47: used visibility instead of display
//					    }	
//			    }}
//			}
//	}
//	else
//	{
//			oMainmenu= document.getElementById(mainManu);
//			oSubmenu = document.getElementById(subMenu);
//			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
//			
//        	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected";}		

//			if(EnclosingDiv!= "" && EnclosingDiv!= null){
//				MenuTopFillFactor=eval((document.getElementById(EnclosingDiv).scrollTop * -1) + 3);
//				MenuLeftFillFactor=MenuLeftFillFactor + document.getElementById(EnclosingDiv).scrollLeft;
//			}
//			oSubmenu.style.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
//			oSubmenu.style.top  = calculateTotalOffset(oMainmenu, 'offsetTop')+ oMainmenu.offsetHeight+MenuTopFillFactor; //oMainmenu.offsetHeight + MenuTopFillFactor;
//            topY=calculateTotalOffset(oMainmenu, 'offsetTop')-3;
//	        if(EnclosingDiv!= "" && EnclosingDiv!= null){
//	            topY = topY - document.getElementById(EnclosingDiv).scrollTop;
//	        }
//			oSubmenu.style.visibility = "visible";			
//			//alert("Menu Left=" + oSubmenu.style.left + " Menu Top=" + oSubmenu.style.top);
//			leftX  = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
//			rightX = leftX + document.getElementById(subMenu).offsetWidth;
//			leftY  = document.getElementById(subMenu).offsetHeight + window.pageYOffset + leftYFillFactor;
//			//topY = window.pageYOffset-document.getElementById(subMenu).offsetHeight; //calculateTotalOffset(oMainmenu, 'offsetTop');
//			leftY=leftY + calculateTotalOffset(oMainmenu, 'offsetTop');
//			//alert("leftX=" + leftX + " rightX=" + rightX + " leftY=" + leftY + " topY=" + topY )
//	}
//	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected"; } 
//	lastMenu = oSubmenu;
//}

function showmenu(mainManu,subMenu,MenuTopFillFactor,MenuLeftFillFactor,leftYFillFactor,EnclosingDiv,hideControls,actionMenuId)
{
	topY=0;
//debugger;
	if(hideControls==null) {hControls=""}
	else {hControls=hideControls;}

	if(actionMenuId==null) {aMenuId=""}
	else {aMenuId=actionMenuId;}

    //if (MenuTopFillFactor == 2){MenuTopFillFactor = 1;}
	if(navigator.appName != 'Netscape') {	
			oMainmenu = eval(mainManu);
			oSubmenu = eval(subMenu + ".style");
			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
			
        	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected";}		

			//MenuTopFillFactor = MenuTopFillFactor + 125;
			oSubmenu.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
			
			oSubmenu.top  = document.all[mainManu].offsetTop + 14;
        	topY=calculateTotalOffset(oMainmenu, 'offsetTop')-3;
	        if(EnclosingDiv!= "" && EnclosingDiv!= null){
	            topY = topY - document.getElementById(EnclosingDiv).scrollTop;
	        }
			oSubmenu.visibility = "visible";		
			//alert("Menu Left=" + oSubmenu.left + " Menu Top=" + oSubmenu.top+ " MenuLeftFillFactor=" + MenuLeftFillFactor);
			leftX  = document.all[subMenu].style.posLeft;
			rightX = leftX + document.all[subMenu].offsetWidth;
			leftY  = document.all[subMenu].style.posTop+document.all[subMenu].offsetHeight + leftYFillFactor;
			//topY = window.event.clientY-document.all[subMenu].offsetHeight; }
			leftY=leftY + calculateTotalOffset(oMainmenu, 'offsetTop');
			//alert("leftX=" + leftX + " rightX=" + rightX + " leftY=" + leftY + " topY=" + topY )
			//hide controls that are displayed on top of the dropdown for IE versions older than 7.0 
			if (msieversion() < 7)
			{
			    if(hControls != "") {
			    var hideControls_array=hControls.split(',');
			    for (i=0;i<hideControls_array.length;i++) {
				    if (hideControls_array[i]!=null)
					    {
						    var oHd = document.getElementById(hideControls_array[i]);
						    if (oHd != null) {oHd.style.visibility="hidden";}//Modified by PushkarK for WAF3_PB_47: used visibility instead of display
					    }	
			    }}
			}
	}
	else
	{
			oMainmenu= document.getElementById(mainManu);
			oSubmenu = document.getElementById(subMenu);
			if (lastMenu != null && lastMenu != oSubmenu) hideAll();
			
        	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected";}		

			if(EnclosingDiv!= "" && EnclosingDiv!= null){
				MenuTopFillFactor=eval((document.getElementById(EnclosingDiv).scrollTop * -1) + 3);
				MenuLeftFillFactor=MenuLeftFillFactor + document.getElementById(EnclosingDiv).scrollLeft;
			}
			oSubmenu.style.left = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
			oSubmenu.style.top  = calculateTotalOffset(oMainmenu, 'offsetTop')+ oMainmenu.offsetHeight+MenuTopFillFactor; //oMainmenu.offsetHeight + MenuTopFillFactor;
            topY=calculateTotalOffset(oMainmenu, 'offsetTop')-3;
	        if(EnclosingDiv!= "" && EnclosingDiv!= null){
	            topY = topY - document.getElementById(EnclosingDiv).scrollTop;
	        }
			oSubmenu.style.visibility = "visible";			
			//alert("Menu Left=" + oSubmenu.style.left + " Menu Top=" + oSubmenu.style.top);
			leftX  = calculateTotalOffset(oMainmenu, 'offsetLeft')-MenuLeftFillFactor;
			rightX = leftX + document.getElementById(subMenu).offsetWidth;
			leftY  = document.getElementById(subMenu).offsetHeight + window.pageYOffset + leftYFillFactor;
			//topY = window.pageYOffset-document.getElementById(subMenu).offsetHeight; //calculateTotalOffset(oMainmenu, 'offsetTop');
			leftY=leftY + calculateTotalOffset(oMainmenu, 'offsetTop');
			//alert("leftX=" + leftX + " rightX=" + rightX + " leftY=" + leftY + " topY=" + topY )
	}
	if (aMenuId!="") {document.getElementById(aMenuId).className="Actions_Selected"; } 
	lastMenu = oSubmenu;
}








//hide the submenu
function hideAll(){
	if(navigator.appName != 'Netscape'){
		if (lastMenu != null) 
			{lastMenu.visibility = "hidden";
			
			//Show controls that are displayed on top of the dropdown, and hidden on displying the dropdown
			if(hControls != "") {
			var hideControls_array=hControls.split(',');
			for (i=0;i<hideControls_array.length;i++) {
				if (hideControls_array[i]!=null)
					{
						var oHd = document.getElementById(hideControls_array[i]);
						if (oHd != null) {oHd.style.visibility="visible";}//Modified by PushkarK for WAF3_PB_47: used visibility instead of display
					}	
			}}
						
			}
	}else{
		if (lastMenu != null) 
			{lastMenu.style.visibility = "hidden";}
	}	
	
	if (lastMenu != null) {
	if (aMenuId	!= "")	{document.getElementById(aMenuId).className="Actions";}}
}

//used to calculate position of a submenu
function calculateTotalOffset(idItem, offsetName){
	var totalOffset = 0;
	var item = eval('idItem');
	do{
		totalOffset += eval('item.'+offsetName);		
		item = eval('item.offsetParent');
	} while (item != null);
	return (totalOffset);
}
//close menu on mouse out of menu containor
function updateIt(e){
	if(navigator.appName != 'Netscape'){
		var x = window.event.clientX;
		var y = window.event.clientY;
//alert("leftX=" + leftX + " x=" + x + " rightX=" + rightX + " y=" + y + " leftY=" + leftY + " topY=" + topY )
//alert(" y=" + y + " topY=" + topY )
		if (x > rightX || x < leftX) hideAll();
		else if (y > leftY || y < topY) hideAll();//|| y < topY
	}
	 else {
		var x = e.pageX;
		var y = e.pageY;
//alert("leftX=" + leftX + " x=" + x + " rightX=" + rightX + " y=" + y + " leftY=" + leftY + " topY=" + topY )
		if (x > rightX || x < leftX)hideAll();
		else if (y > leftY || y < topY) hideAll();//|| y < topY
	}
}
//set page to hide menus on a mouse click or on mouseout of menu container
if(navigator.appName != 'Netscape')
{
	document.body.onclick=hideAll;
	document.body.onscroll=hideAll;
	//document.body.onresize=hideAll;
	document.body.onmousemove=updateIt;
}
else
{
	document.body.onclick=hideAll;
	//document.body.onresize=hideAll;	
	//document.body.onmouseout=hideAll;
	document.body.onmousemove=updateIt;
}
// This function returns Internet Explorer's major version number,
// or 0 for others. It works by finding the "MSIE " string and
// extracting the version number following the space, up to the decimal
// point, ignoring the minor version number
function msieversion()
{
  var ua = window.navigator.userAgent
  var msie = ua.indexOf ( "MSIE " )

  if ( msie > 0 )      // If Internet Explorer, return version number
     return parseInt (ua.substring (msie+5, ua.indexOf (".", msie )))
  else                 // If another browser, return 0
     return 0
}