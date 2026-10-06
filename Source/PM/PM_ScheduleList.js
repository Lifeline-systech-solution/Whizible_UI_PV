/**************************************************************************
	Copyright (c) 2001 Geir Landrö (drop@destroydrop.com)
	JavaScript Tree - www.destroydrop.com/hugi/javascript/tree/
	Version 0.96	

	This script can be used freely as long as all copyright messages are
	intact.
**************************************************************************/
document.write("<link href='../general/StyleSheetChanakya.css' type='text/css' rel='stylesheet'>")

// Arrays for nodes and icons
var nodes		= new Array();;
var openNodes	= new Array();
var icons		= new Array(6);

// Loads all icons that are used in the tree
function preloadIcons() {
	icons[0] = new Image();
	icons[0].src = "../../images/plus.gif";
	icons[1] = new Image();
	icons[1].src = "../../images/plusbottom.gif";	
	icons[2] = new Image();
	icons[2].src = "../../images/minus.gif";
	icons[3] = new Image();
	icons[3].src = "../../images/minusbottom.gif";
	icons[4] = new Image();
	icons[4].src = "../../images/folder.gif";
	icons[5] = new Image();
	icons[5].src = "../../images/folderopen.gif";
}
// Create the tree
function createTree(arrName, rootName, startNode, openNode) {
	nodes = arrName;
	if (nodes.length > 0) {
		preloadIcons();
		if (startNode == null) startNode = 0;
		if (openNode != 0 || openNode != null) setOpenNodes(openNode);
			document.write(" <table width='99.9%'><tr><td> ")
		if (startNode !=0) {
			var nodeValues = nodes[getArrayId(startNode)].split("|");
			//document.write("<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src=\"../../images/folderopen.gif\" align=\"absbottom\" alt=\"\" />" + nodeValues[2] + "</a><br />");
		} else //document.write("<img src=\"../../images/base.gif\" border='0'   align=\"absbottom\" alt=\"\" />" + rootName + "<br />");
		document.write(" </td></tr></table >")
		var recursedNodes = new Array();
		document.write(" <table width='99.9%'> ")
		addNode(startNode, recursedNodes);
		document.write(" </table >")
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
			document.write("  <tr><td width='25%' class=clsTDOdd align=left>")
			// Write out line & empty icons
			for (g=0; g<recursedNodes.length; g++) {
				if (recursedNodes[g] == 1) document.write("<img src=\"../../images/line.gif\" align=\"absbottom\" alt=\"\" />");
				else  document.write("<img src=\"../../images/empty.gif\" align=\"absbottom\" alt=\"\" />");
			}
			//document.write(" </td>")
			// put in array line & empty icons
			if (ls) recursedNodes.push(0);
			else recursedNodes.push(1);

			// Write out join icons
			//document.write(" <td width='30%' align=left>")
			if (hcn) {
				if (ls) {
					///document.write(" <td width='30%' align=left>")
					
					document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 1);\"><img border='0' id=\"join" + nodeValues[0] + "\" src=\"../../images/");
					 	if (ino) document.write("minus");
						else document.write("plus");
					document.write("bottom.gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
					
					//document.write(" </td>")
				} else {
					//document.write(" <td width='30%' align=left>")
					document.write("<a href=\"javascript: oc(" + nodeValues[0] + ", 0);\"><img  border='0' id=\"join" + nodeValues[0] + "\" src=\"../../images/");
						if (ino) document.write("minus");
						else document.write("plus");
					document.write(".gif\" align=\"absbottom\" alt=\"Open/Close node\" /></a>");
					
					//document.write(" </td>")
				}
			} else {
				if (ls) document.write("<img src=\"../../images/join.gif\" align=\"absbottom\" alt=\"\" />");
				else document.write("<img src=\"../../images/joinbottom.gif\" align=\"absbottom\" alt=\"\" />");
			}
			//document.write(" </td>")
			
			// Start link
			//document.write(" <td width='30%'>")
			// Write out folder & page icons
			if (hcn) {
				
				document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/folder")
					if (ino) document.write("open");
				document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
				
				
			} else
			{
				//Added by Priyanka
				document.write("<font style='color:" + nodeValues[10] + "'>");
				document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"../../images/page.gif\" align=\"absbottom\" alt=\"Page\" />");
				
				//Added by Priyanka
				document.write("</font>");
			 }
			//document.write(" </td>")
			
			//document.write("<td width='15%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			//document.write("<a href=\"" + nodeValues[3] + "\" target=main onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
			document.write( nodeValues[2] );
			document.write("</font>");
			document.write("</td>")
			
			document.write("<td  class=clsTDOdd align=left width='10%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[3] );
			document.write("</font>"); 
			document.write( "</td>" );
			
			//Added By Priyanka
			//document.write("<a href=\"" + nodeValues[3] + "\" target=main onclick=\"top.window.frames(0).lblSelectedItem.innerHTML='" + nodeValues[2] + "'; return true;\" onmouseover=\"window.status='" + top.window.frames.length + "';return true;\" onmouseout=\"window.status=' ';return true;\">");
			document.write("</td>")
			document.write("<td  class=clsTDOdd  align=left width='15%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[4] );
			document.write("</font>"); 
			document.write( "</td>" );
			
			document.write("</td><td  class=clsTDOdd align=right width='10%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[5] );
			if (nodeValues[10] == 1) {
			document.write("</font>")}
			document.write( "</td>" );

			//document.write("</td><td  class=clsTDOdd align=left width='15%'>")
			//document.write("<font style='color:" + nodeValues[10] + "'>");
			//document.write( nodeValues[9] );
			//document.write("</font>"); 
			//document.write( "</td>" );			

			document.write("</td><td  class=clsTDOdd align=left width='15%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[6] );
			document.write("</font>"); 
			document.write( "</td>" );
			
			document.write("</td><td  class=clsTDOdd align=left width='15%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[7] );
			document.write("</font"); 
			document.write( "</td>" );
			
			document.write(" <td class=clsTDOdd align=right width='10%'>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			// Write out node name
			document.write(nodeValues[8]);
			document.write("</font>"); 
			
			// End link
			document.write("<br />");
			document.write(" </td></tr>")
			
			//Added by Priyanka, 3rd Dec 2003
			document.write("<tr><td class=clsTDOdd align=left colspan=3></td>")
			document.write("</td><td  class=clsTDOdd align=right>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[9] );
			document.write("</font>"); 
			document.write( "</td>" );			

			document.write("</td><td  class=clsTDOdd align=left>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[11] );
			document.write("</font>"); 
			document.write( "</td>" );			

			document.write("</td><td  class=clsTDOdd align=left>")
			document.write("<font style='color:" + nodeValues[10] + "'>");
			document.write( nodeValues[12] );
			document.write("</font>"); 
			document.write( "</td>" );			
			//End Of Addition
						
			// If node has children write out divs and go deeper
			if (hcn) {
					document.write(" </table>")
				document.write("<div id=\"div" + nodeValues[0] + "\"");
					if (!ino) document.write(" style=\"display: none;\"");
				document.write(">");
				//Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

				document.write(" <table width='99.9%'> ")
				addNode(nodeValues[0], recursedNodes);
				document.write(" </table>")
				document.write("</div>");
				//document.write(" </table>")
				document.write(" <table width='99.9%'> ")
				}
			else
			{	document.write(" </table>")
				document.write(" <table width='99.9%'> ")
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
	
	if (theDiv.style.display == 'none') {
		if (bottom==1) theJoin.src = icons[3].src;
		else theJoin.src = icons[2].src;
		theIcon.src = icons[5].src;
		theDiv.style.display = '';
	} else {
		if (bottom==1) theJoin.src = icons[1].src;
		else theJoin.src = icons[0].src;
		theIcon.src = icons[4].src;
		theDiv.style.display = 'none';
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
