// JScript File

var SelectedMenu;
var pathprefix	= ""
// Arrays for nodes and icons
var nodes		= new Array();
var openNodes	= new Array();
var icons		= new Array(6);


//Function to plot tree in home module for New UI
function createHomeTree(Nodes,StartIndex,NoOfItems,IsProjectSelected)
{
    var PreviousParentTagName="";
    var i;
    var nodeValues;
    var strHTML="";
    
    for(i=StartIndex;i<StartIndex+NoOfItems;i++)
    {
        nodeValues = Nodes[i].split("|");
        
        if(PreviousParentTagName!=nodeValues[4])
        {
            if(PreviousParentTagName!="")
            {
                strHTML+="</div>";
                strHTML+="<div style=\"height:1px;\">&nbsp;</div>";
            }
             strHTML+="<a align='left' class='clstagGroup' >"+nodeValues[4]+"</a>";
             
             strHTML+="<div style=\"border:solid 1px black;\">";
        }
        strHTML+="<div style=\"height:20px;\">";
        strHTML+="&nbsp;<img style=\"vertical-align:middle;\"  src='../../Images/Home/TabItem.gif' border=0>&nbsp;";
        
        //For Project module, project not in session check need to be handelled
        if(IsProjectSelected || nodeValues[0]==32)
            strHTML+="<A class='clsLinkChildNavMenu' style=\"text-decoration:none;\" href='javascript:TabItemOnClick(\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ") ' onmouseover='javascript:TablItem_onmouseover(this)' onmouseout='javascript:TablItem_onmouseout(this)'>"
        else
            strHTML+="<A class='clsLinkChildNavMenu' style=\"text-decoration:none;\" href='#' >"
        strHTML+=nodeValues[2];
        strHTML+="</a>";
        strHTML+="</div>";
        
        PreviousParentTagName=nodeValues[4];
    }
    
    if(Nodes.length==0)
        strHTML+="</div>";
        
     strHTML+="</div>";
     
     return strHTML;
}

var strHTML;
var ShowOpen=true;

function GetSelectedNodeIndex(TagID)
{
   var NodeIndex=-1;
    for(index=0;index<Tree.length;index++)
    {
        arrNodeValue=Tree[index].split("|");
        if(arrNodeValue[0]==TagID)
        {
            NodeIndex=index;
            break;
        }
    }
    return NodeIndex;
}

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
				strHTML+="<a title='" + nodeValues[2] + "' onClick=HighlightSelected(this) href='javascript:TabItemOnClick(\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ") ' style='text-decoration:none' target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";
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
					strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='"+ nodeValues[4] +"'/>";
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