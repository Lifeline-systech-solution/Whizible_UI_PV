/**************************************************************************
	Copyright (c) 2001 Geir Landrö (drop@destroydrop.com)
	JavaScript Tree - www.destroydrop.com/hugi/javascript/tree/
	Version 0.96	

	This script can be used freely as long as all copyright messages are
	intact.
**************************************************************************/
// Added by Ninad 12 Feb 2007,To hold currently selected menu item Req ID - WAF3_PB_40
var SelectedMenu;

// Arrays for nodes and icons
//Added By Nilesh G ON 11/02/2016
var nodes		= new Array();
var openNodes	= new Array();
var icons		= new Array(6);
/* Modified By NileshD on 23 June 2005
	User can pass one parameter for the path of Report folder in createTree function. This is useful if we use this "js" from any page in 
	Source directory. "pathprefix" variable will contain that value.
	e.g. "../../Reports/"
*/
/*
Modified By NiranjanS on 23 SEP 2005 R.No. WAF3_PB_9
Img Folder is now renamed as TreeNodeImages. Changes made at all appropriate places.

*/
var pathprefix	= ""

// Added by Ninad 9 Feb 2007,to highlight currently selected menu item Req ID - WAF3_PB_40
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
// Create the tree
//Modified By NiranjanS on 23 SEP 2005 R.No. WAF3_PB_9
function createTree(arrName, startNode, openNode) {
pathprefix = (arguments.length>2)?arguments[3]:"../Images/";
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
	
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
			if(nodeValues[6]!="page.gif")
			{ 
				document.write("<nobr><a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" +  pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />");
			}
			else
			{
				document.write("<nobr><a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" +  pathprefix + "TreeNodeImages/folderopen.gif' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />");
			}
		} 
		var recursedNodes = new Array();
		addNode(startNode, recursedNodes);
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
//Modified By NiranjanS on 23 SEP 2005 R.No. WAF3_PB_9
function addNode(parentNode, recursedNodes) {
	for (var i = 0; i < nodes.length; i++) {

		var nodeValues = nodes[i].split("|");
		if (nodeValues[1] == parentNode) {
			
			var ls	= lastSibling(nodeValues[0], nodeValues[1]);
			var hcn	= hasChildNode(nodeValues[0]);
			var ino = isNodeOpen(nodeValues[0]);

			// Write out line & empty icons
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) document.write("<nobr><img src='" + pathprefix + "TreeNodeImages/line.gif' align=\"absbottom\" alt=\"\" border=0 />");
				else  document.write("<nobr><img src='" + pathprefix + "TreeNodeImages/empty.gif' align=\"absbottom\" alt=\"\" border=0 />");
			}

			// put in array line & empty icons
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);

			// Write out join icons
			if (hcn) {
				if (ls) {
					document.write("<nobr><a href=\"javascript: oc(" + nodeValues[0] + ", 1,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/");
					 	if (ino) document.write("minus");
						else document.write("plus");
					document.write("bottom.gif' align=\"absbottom\" alt=\"Open/Close node\" border=0 /></a>");
				} else {
					document.write("<nobr><a href=\"javascript: oc(" + nodeValues[0] + ", 0,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/");
						if (ino) document.write("minus");
						else document.write("plus");
					document.write(".gif' align=\"absbottom\" alt=\"Open/Close node\" border=0/></a>");
				}
			} else {
				if (ls) document.write("<nobr><img src='" + pathprefix + "TreeNodeImages/join.gif' align=\"absbottom\" alt=\"\" border=0/>");
				else document.write("<nobr><img src='" + pathprefix + "TreeNodeImages/joinbottom.gif' align=\"absbottom\" alt=\"\" border=0/>");
			}

			// Start link
			//document.write("<a href=\"" + nodeValues[3] + "\" target=Sub onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");

			if (trimString(nodeValues[3]) !="")
				document.write("<nobr><a onClick=HighlightSelected(this) href=\"" + nodeValues[3] + "\" target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
			else
			{	
				if(trimString(nodeValues[5])=="0")
					document.write("<nobr><span id=Inactive>")	
			}
			
			// Write out folder & page icons
			if (hcn) {
				if(nodeValues[6]!="page.gif")
				{
					document.write("<nobr><img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>")
				}
				else
				{
					document.write("<nobr><img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/folder")
						if (ino) document.write("open");
					//document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
					document.write(".gif' align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>");
				}	
			} else
			{
				if(nodeValues[6]!="page.gif")
				{ 
					document.write("<nobr><img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='"+ nodeValues[4] +"'/>");
				}
				else
				{ 
					document.write("<nobr><img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/page.gif' align=\"absbottom\" alt='"+ nodeValues[4] +"'/>");
				}
			}
			//document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"img/page.gif\" align=\"absbottom\" alt=\"Page\" />");
			
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
				document.write("<div id=\"div" + nodeValues[0] + "\" nowrap=true");
					if (!ino) document.write(" style=\"display: none;\"");
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
//Modified By NiranjanS on 23 SEP 2005 R.No. WAF3_PB_9
function oc(node, bottom,strImageName) {
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
