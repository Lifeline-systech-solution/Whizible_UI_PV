/**************************************************************************
	Copyright (c) 2001 Geir Landrö (drop@destroydrop.com)
	JavaScript Tree - www.destroydrop.com/hugi/javascript/tree/
	Version 0.96	

	This script can be used freely as long as all copyright messages are
	intact.
**************************************************************************/

// Arrays for nodes and icons
var nodes		= new Array();;
var openNodes	= new Array();
var icons		= new Array(6);
var SelectedMenu;

/* Modified By NileshD on 23 June 2005
	User can pass one parameter for the path of Report folder in createTree function. This is useful if we use this "js" from any page in 
	Source directory. "pathprefix" variable will contain that value.
	e.g. "../../Reports/"
*/
var pathprefix	= ""

// Loads all icons that are used in the tree
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = pathprefix + "../../Images/WF_plus.gif";
	icons[1] = new Image();
	icons[1].src = pathprefix + "../../Images/WF_plusbottom.gif";
	icons[2] = new Image();
	icons[2].src = pathprefix + "../../Images/WF_minus.gif";
	icons[3] = new Image();
	icons[3].src = pathprefix + "../../Images/WF_minusbottom.gif";
	icons[4] = new Image();
	icons[4].src = pathprefix + "../../Images/folder.gif";
	icons[5] = new Image();
	icons[5].src = pathprefix + "../../Images/folderopen.gif";
}
// Create the tree
function createTree(arrName, startNode, openNode) {
pathprefix = (arguments.length>2)?arguments[3]:"";
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
			document.write("<nobr><a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" +  pathprefix + "../../Images/folderopen.gif' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />");
		} 
	
		var recursedNodes = new Array();
		document.write("<div id=\"divMain \" nowrap=true style=\"BACKGROUND-REPEAT: no-repeat; BACKGROUND-POSITION: center center; BORDER-TOP-STYLE: solid; BORDER-RIGHT-STYLE: solid; BORDER-LEFT-STYLE: solid;BORDER-BOTTOM-STYLE: solid;HEIGHT:425px;transparent;\">");
		addNode(startNode, recursedNodes);
		document.write("</div>");
	}
}
// Returns the position of a node in the array
function getArrayId(node) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==node) return i;
	}
}
// Puts in array nodes that will be open
function setOpenNodes(openNode) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==openNode) {
			openNodes.push(nodeValues[0]);
			setOpenNodes(nodeValues[1]);
		}
	} 
}
// Checks if a node is open
function isNodeOpen(node) {
	for (i=0; i<openNodes.length; i++)
		if (openNodes[i]==node) return true;
	return false;
}
// Checks if a node has any children
function hasChildNode(parentNode) {
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) return true;
	}
	return false;
}
// Checks if a node is the last sibling
function lastSibling (node, parentNode) {
	var lastChild = 0;
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode)
			lastChild = nodeValues[0];
	}
	if (lastChild==node) return true;
	return false;
}
// Adds a new node in the tree
function addNode(parentNode, recursedNodes) {
	for (var i = 0; i < nodes.length; i++) {

		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {
			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = isNodeOpen(nodeValues[0]);

			
			// Write out line & empty icons
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) document.write("<nobr><img src='" + pathprefix + "../../Images/line.gif' align=\"absbottom\" alt=\"\" border=0 />");
				else  document.write("<nobr><img src='" + pathprefix + "../../Images/empty.gif' align=\"absbottom\" alt=\"\" border=0 />");
			}

			// put in array line & empty icons
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);
						
			// Write out join icons
			if (hcn) {
				if (ls) {
				
					document.write("<nobr><a href=\"javascript: oc(" + nodeValues[0] + ", 1);\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/WF_");
					//document.write("<nobr><a href=\"javascript: oc(" + i + ", 1);\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/WF_");
					 	if (ino) document.write("minus");
						else document.write("plus");
					document.write("bottom.gif' align=\"absbottom\" alt=\"Open/Close node\" border=0 /></a>");
				} else {
					document.write("<nobr><a href=\"javascript: oc(" + nodeValues[0] + ", 0);\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/WF_");
					//document.write("<nobr><a href=\"javascript: oc(" + i + ", 0);\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/WF_");
						if (ino) document.write("minus");
						else document.write("plus");
					document.write(".gif' align=\"absbottom\" alt=\"Open/Close node\" border=0/></a>");
				}
			} else {
				if (ls) document.write("<nobr><img src='" + pathprefix + "../../Images/join.gif' align=\"absbottom\" alt=\"\" border=0/>");
				else document.write("<nobr><img src='" + pathprefix + "../../Images/joinbottom.gif' align=\"absbottom\" alt=\"\" border=0/>");
			}

			// Start link
			//document.write("<a href=\"" + nodeValues[3] + "\" target=Sub onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");

			if (trimString(nodeValues[3]) !="")
			// Modified by SandipL on 11 Jan 2006 -- To avoid Jscript error if nodeTooltip contains single quote or VBCRLF
				//document.write("<nobr><a Style='TEXT-DECORATION:none' href=\"" + nodeValues[3] + "\" target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
				document.write("<nobr><a Style='TEXT-DECORATION:none' href=\"" + nodeValues[3] + "\" target=Sub Title=\"" + nodeValues[4] + "\" onmouseover=\"window.status='" + nodeValues[4].replace(/'/g,"\\'").replace(/\n/g," ") + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
			// End modification by SandipL	
			else
			{	
				if(trimString(nodeValues[5])=="0")
					document.write("<nobr><span id=Inactive>")	
			}
			
			// Write out folder & page icons
			if (hcn) {
				document.write("<nobr><img border=0 id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/" + nodeValues[6] + "'")
				//if (ino) document.write("open");
				//document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
				
				// Modified by SandipL on 11 Jan 2006 -- To avoid Jscript error if nodeTooltip contains single quote
				//document.write("align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>");	
				document.write("align=\"absbottom\" alt=\""+nodeValues[4] +"\" border=0/>");	
			} else //document.write("<nobr><img border=0 id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/" + nodeValues[6] + "' align=\"absbottom\" alt='"+ nodeValues[4] +"'/>");
			document.write("<nobr><img border=0 id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "../../Images/" + nodeValues[6] + "' align=\"absbottom\" alt=\""+ nodeValues[4] +"\"/>");
			
			//End modification by SandipL
			
			//document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../Images/page.gif\" align=\"absbottom\" alt=\"Page\" />");
			
			// Write out node name
			document.write(nodeValues[2]);

			// End link
			if (trimString(nodeValues[3]) !="")
				document.write("</a><br />");
			else
			{
				if(trimString(nodeValues[5])=="0")
					document.write("</span><br />");
				else
					document.write("<br />");
			}
			// If node has children write out divs and go deeper
			if (hcn) {
				document.write("<div border=0 id=\"div" + nodeValues[0] + "\" nowrap=true style=\"");
					if (!ino) document.write("display: none;\"");
				document.write(">");
				addNode(nodeValues[0], recursedNodes);
				document.write("</div>");
			}
			
			// remove last line or empty icon 
			recursedNodes.pop();
		
		}
	}
}
// Opens or closes a node
function oc(node, bottom) {
	var theDiv = document.getElementById("div" + node);
	var theJoin	= document.getElementById("join" + node);
	var theIcon = document.getElementById("icon" + node);
	var nodeval = new Array;
	// Modified by SandipL on 9 Mar 2006
	var index;
	index = getArrayId(node);
	nodeval = nodes[index].split("|");
	//nodeval = nodes[node-1].split("|");
	// End modification by SandipL
	if(theJoin)
	{
		if (theDiv.style.display == 'none') {
			if (bottom==1) theJoin.src = icons[3].src;
			else theJoin.src = icons[2].src;
			theIcon.src = "../../Images/" + nodeval[6] //icons[5].src;
			theDiv.style.display = '';
			//theDiv.style.backgroundcolor='lavender';
		} else {
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;
		theIcon.src = "../../Images/" + nodeval[6] //icons[4].src;
		theDiv.style.display = 'none';
		//theDiv.style.backgroundcolor='lavender';
		}
	}
}
// Push and pop not implemented in IE(crap!    don´t know about NS though)
if(!Array.prototype.push) {
	function array_push() {
		for(var i=0;i<arguments.length;i++)
			this[this.length]=arguments[i];
		return this.length;
	}
	Array.prototype.push = array_push;
}
if(!Array.prototype.pop) {
	function array_pop(){
		lastElement = this[this.length-1];
		this.length = Math.max(this.length-1,0);
		return lastElement;
	}
	Array.prototype.pop = array_pop;
}
function trimString (str) 
{
	str = this != window? this : str;
	return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
}

//Issue ID 28888
function GetObjectReference(strFormId,strElementId,blnIsName)
{
	var objElement;
	var objCombo;
	
		if ( blnIsName )
		{
				objElement = document.getElementsByName(strElementId);
		}
		else if ( !(blnIsName) )
		{
			objElement = document.getElementById(strElementId);
		}
		return objElement;
	
}

function GetFormReference(strFormId)
{
	var objElement;
	
			objElement = document.getElementById(strFormId);
			return objElement;
	
}
//End
//Added by SandipL on 9 Mar 2006 to open all nodes
function OpenAllNodes() 
{
	var intCount;
	var nodeValues ;
	for (intCount=0;intCount<=nodes.length-1;intCount++)
	{
		nodeValues = nodes[intCount].split("|");
		oc(nodeValues[0],0)
		
	}

}


//added by SanaS on 19-Nov-2009 for Product tree issue

function createSearchTree(arrName, SearchText,startNode, openNode) {

strHTML='';
pathprefix = (arguments.length>2)?arguments[3]:"../../Images/";
	nodes = arrName;
	
	if(SearchText=="")
	    ShowOpen=false;
	else
	    ShowOpen=true;
	
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
	
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
			if(nodeValues[6]!="page.gif")
			{ 
				strHTML+="<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" +  pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />";
			}
			else
			{
				strHTML+="<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" +  pathprefix + "TreeNodeImages/folderopen.gif' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />";
			}
		} 
		var recursedNodes = new Array();
		addSearchTreeNode(startNode, recursedNodes);
	}
	return strHTML;
}

function addSearchTreeNode(parentNode, recursedNodes) {//debugger;
	for (var i = 0; i < nodes.length; i++) {

		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {
			
			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = ShowOpen;//isNodeOpen(nodeValues[0]);

			// Write out line & empty icons
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) strHTML+="<img src='" + pathprefix + "TreeNodeImages/line.gif' align=\"absbottom\" alt=\"\" border=0 />";
				else  strHTML+="<img src='" + pathprefix + "TreeNodeImages/empty.gif' align=\"absbottom\" alt=\"\" border=0 />";
			}

			// put in array line & empty icons
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);

			// Write out join icons
			if (hcn) {
				if (ls) {
					strHTML+="<a href=\"javascript: oc(" + nodeValues[0] + ", 1,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/";
					 	if (ino) strHTML+="minus";
						else strHTML+="plus";
					strHTML+="bottom.gif' align=\"absbottom\" alt=\"Open/Close node\" border=0 /></a>";
				} else {
					strHTML+="<a href=\"javascript: oc(" + nodeValues[0] + ", 0,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/";
						if (ino) strHTML+="minus";
						else strHTML+="plus";
					strHTML+=".gif' align=\"absbottom\" alt=\"Open/Close node\" border=0/></a>";
				}
			} else {
				if (ls) strHTML+="<img src='" + pathprefix + "TreeNodeImages/join.gif' align=\"absbottom\" alt=\"\" border=0/>";
				else strHTML+="<img src='" + pathprefix + "TreeNodeImages/joinbottom.gif' align=\"absbottom\" alt=\"\" border=0/>";
			}

			// Start link
			//document.write("<a href=\"" + nodeValues[3] + "\" target=Sub onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");

			if (trimString(nodeValues[3]) !="")
			// Modified by purvaj on 30 Jun 2009 for 8.1 Issue fixes
			// tooltip was wrong. title added
				//strHTML += "<a title='" + nodeValues[2] + "' onClick=HighlightSelected(this) href='javascript:TabItemOnClick(\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ") ' style='text-decoration:none' border=0 target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";
				strHTML += "<a title='" + nodeValues[2] + "' onClick=TabItemOnClick(\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ",this" + ")  style='text-decoration:none' border=0 target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";
			else
			{	
				if(trimString(nodeValues[7])=="0")
					strHTML+="<span id=Inactive>";
				else
                strHTML+="<a href='#' style='text-decoration:none;cursor:pointer' ><b>";
			}
			
			// Write out folder & page icons
			if (hcn) {
				if(nodeValues[6]!="page.gif")
				{
					strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>";
				}
				else
				{
					strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/folder";
						if (ino)strHTML+="open";
					//document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
					strHTML+=".gif' align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>";
				}	
			} else
			{
				if(nodeValues[6]!="page.gif")
				{ 
					strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='"+ nodeValues[4] +"' border=0/>";
				}
				else
				{ 
					strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/page.gif' align=\"absbottom\" alt='"+ nodeValues[4] +"' border=0 />";
				}
			}
			//document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"img/page.gif\" align=\"absbottom\" alt=\"Page\" />");
			
			// Write out node name
			strHTML+=nodeValues[2];


			// End link
			if (trimString(nodeValues[3]) !="")
				strHTML+="</a><br />";
			else
			{
				if(trimString(nodeValues[7])=="0")
					strHTML+="</span><br />";
				else
					//strHTML+="</b><br />";
                strHTML+="</b></a><br />";
			}
			
			// If node has children write out divs and go deeper
			if (hcn) {
				strHTML+="<div id=\"div" + nodeValues[0] + "\" nowrap=true";
					if (!ino) strHTML+=" style=\"display: none;\"";
				strHTML+=">";
				addSearchTreeNode(nodeValues[0], recursedNodes);
				strHTML+="</div>";
			}
			
			// remove last line or empty icon 
			recursedNodes.pop();
		}
	}
}


// Loads all icons that are used in the tree
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = pathprefix + "TreeNodeImages/plus.gif";
	icons[1] = new Image();
	icons[1].src = pathprefix + "TreeNodeImages/plusbottom.gif";
	icons[2] = new Image();
	icons[2].src = pathprefix + "TreeNodeImages/minus.gif";
	icons[3] = new Image();
	icons[3].src = pathprefix + "TreeNodeImages/minusbottom.gif";
	icons[4] = new Image();
	icons[4].src = pathprefix + "TreeNodeImages/folder.gif";
	icons[5] = new Image();
	icons[5].src = pathprefix + "TreeNodeImages/folderopen.gif";
}


// Puts in array nodes that will be open
function setOpenNodes(openNode) {
	for (i=0; i<nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[0]==openNode) {
			openNodes.push(nodeValues[0]);
			setOpenNodes(nodeValues[1]);
		}
	} 
}

function oc(node, bottom,strImageName) {
//debugger;
	var theDiv = document.getElementById("div" + node);
	var theJoin	= document.getElementById("join" + node);
	var theIcon = document.getElementById("icon" + node);
	if(strImageName==undefined)strImageName = "page.gif"
	if(theJoin)
	{
		if (theDiv.style.display == 'none') {
			if (bottom==1) theJoin.src = icons[3].src;
			else theJoin.src = icons[2].src;
			
			if(strImageName!="page.gif")
			{
				theIcon.src = pathprefix + "TreeNodeImages/" + strImageName;
			}
			else
			{
				theIcon.src = icons[5].src;
			}
			theDiv.style.display = '';
		} else {
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;
		if(strImageName!="page.gif")
		{
			theIcon.src = pathprefix + "TreeNodeImages/" + strImageName;
		}
		else
		{
			theIcon.src = icons[4].src;
		}					
		theDiv.style.display = 'none';
		}
	}
}

// Checks if a node has any children
function hasChildNode(parentNode) {
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) return true;
	}
	return false;
}
// Checks if a node is the last sibling
function lastSibling (node, parentNode) {
	var lastChild = 0;
	for (i=0; i< nodes.length; i++) {
		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode)
			lastChild = nodeValues[0];
	}
	if (lastChild==node) return true;
	return false;
}


function HighlightSelected(NewSelectedMenu)
{
    if(ShowNavigationAlert()==false) return; //Added By Ninad 16 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
	if (SelectedMenu != null)
	{
		SelectedMenu.style.color=NewSelectedMenu.style.color;
		SelectedMenu.style.fontWeight=NewSelectedMenu.style.fontWeight;
	}
	SelectedMenu=NewSelectedMenu;
	SelectedMenu.style.color='red';
	SelectedMenu.style.fontWeight='bold';
}
function TabItemOnClick(PageName, TagID, ControlItemID, NewSelectedMenu) {
	var num;
	var str = PageName;
	str = str.split("(");
	num = str[1];
	num = num.substring(0, num.length - 1);
	Node_OnClick(num);
	if (ShowNavigationAlert() == false) return; //Added By Ninad 16 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
	if (SelectedMenu != null) {
		SelectedMenu.style.color = NewSelectedMenu.style.color;
		SelectedMenu.style.fontWeight = NewSelectedMenu.style.fontWeight;
	}
	SelectedMenu = NewSelectedMenu;
	SelectedMenu.style.color = 'red';
	SelectedMenu.style.fontWeight = 'bold';

}
//ENDDED BY NILESH G ON 6/1/2015 FOR ISSUE ID 2752
function Node_OnClick(NodeID) {
	//Added by swapnil aswale on 12-09-2015
	document.getElementById("divLeft").style.position = ""
	//Ended
	var objDivRight = GetObjectReference('frmPRD_ProductTree', 'divRight');
	var strURL = "PRD_ProductTree.aspx?NodeID=" + NodeID + "&Mode=Edit";
	val = generateRequest(strURL);
	if (val == true) {
		objDivRight.innerHTML = strResult
	}

	window.parent.jQuery("#preloader").remove();
	window.parent.jQuery("#fillDiv").remove();
	window.parent.jQuery("#preloader").fadeOut("slow");
	window.parent.jQuery("#fillDiv").fadeOut("slow");
	window.parent.jQuery("#preloader").remove();
	window.parent.jQuery("#fillDiv").remove();
}
//end by SanaS