/// <reference path="SearchTree.js" />
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
        strHTML+="&nbsp;<img style=\"vertical-align:middle;\"  src='../Images/Home/TabItem.gif' border=0>&nbsp;";
        
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

function createSearchTree(arrName, SearchText,startNode, openNode,ImagesFolderPath,IsFavouriteTree) {

    strHTML = '';
    //Bharat on 6th-Oct-2015
    pathprefix = (arguments.length > 4) ? arguments[4] : "../../Images/";
    if (pathprefix == "" || pathprefix == null) pathprefix = "../../Images/";
    //Bharat on 6th-Oct-2015
	nodes = arrName;
	
	if(SearchText=="" && IsFavouriteTree!=1)
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

		    //alert(nodeValues[3]);

			if (trimString(nodeValues[3]) !="")
			// Modified by purvaj on 30 Jun 2009 for 8.1 Issue fixes
			    // tooltip was wrong. title added
                //Commented and Added By Bharat T on 8th-Oct-2015 for on any page click, left tree is get hidden.
			    //strHTML += "<a title='" + nodeValues[2] + "' onClick=HighlightSelected(this," + nodeValues[8] + ") href='" + nodeValues[3] + "' style='text-decoration:none' target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";			    
			    strHTML += "<a title='" + nodeValues[2] + "' onClick=HighlightSelected(this) href='javascript:TabItemOnClick(\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ") ' style='text-decoration:none' target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";
			    //End of Commented and Added By Bharat T on 8th-Oct-2015 for on any page click, left tree is get hidden.
			else
			{	//alert(nodeValues[5]);
			    //Commented and Added By Bharat T on 8th-Oct-2015
			    //if(trimString(nodeValues[5])=="0")
			    if (trimString(nodeValues[7]) == "0")
			        //End of Commented and Added By Bharat T on 8th-Oct-2015
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
					//strHTML+="<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/folder";
					//	if (ino)strHTML+="open";
					////document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
				    //strHTML+=".gif' align=\"absbottom\" alt='"+nodeValues[4] +"' border=0/>";
				    var className;
				    if (ino)
				        className = 'folderOpen'
				    else
				        className = 'folder'

				    strHTML += "<img src='data:image/gif;base64,R0lGODlhAQABAPcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAAP8ALAAAAAABAAEAAAgEAP8FBAA7' class='" + className + "' id=\"icon" + nodeValues[0] + "\" style='background:url(" + pathprefix + "TreeNodeImages/folder";
				    if (ino) strHTML += "open";
				    //document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
				    strHTML += ".gif)' align=\"absbottom\" />";
				    //End Added By Vaijat K ON 23/09/2016 For Dynamic Theme
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
			//alert(nodeValues[3]);
			if (trimString(nodeValues[3]) !="")
				strHTML+="</a><br />";
			else
			{   //alert(nodeValues[5]);
                //Commented and Added By Bharat T on 8th-Oct-2015
			    //if(trimString(nodeValues[5])=="0")
			    if (trimString(nodeValues[7]) == "0")
			        //end of Commented and Added By Bharat T on 8th-Oct-2015
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
			    //theIcon.src = icons[5].src;
			    //Added By Vaijat K ON 23/09/2016 For Dynamic Theme
			    theIcon.style.background = "url:(" + icons[5].src + ")";
			    theIcon.className = "folderOpen"
			    //End Added By Vaijat K ON 23/09/2016 For Dynamic Theme
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
		    //theIcon.src = icons[4].src;
		    //Added By Vaijat K ON 23/09/2016 For Dynamic Theme
		    theIcon.style.background = "url:(" + icons[4].src + ")";
		    theIcon.className = "folder"
		    //End Added By Vaijat K ON 23/09/2016 For Dynamic Theme
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


function HighlightSelected(NewSelectedMenu,TagID)
{
    if (parent.document.getElementById('Frame2') != null || parent.document.getElementById('Frame2') != undefined) {
        var iframe2 = parent.document.getElementById('Frame2');
        iframe2.contentWindow.parent.document.getElementById('fillDiv').style.display = 'block';
        iframe2.contentWindow.parent.document.getElementById('preloader').style.display = 'block';
    }
    else if (parent.document.getElementById('Frame3') != null || parent.document.getElementById('Frame3') != undefined) {
        var iframe3 = parent.document.getElementById('Frame3');
        iframe3.contentWindow.parent.document.getElementById('fillDiv').style.display = 'block';
        iframe3.contentWindow.parent.document.getElementById('preloader').style.display = 'block';
    }

    if(ShowNavigationAlert()==false) return; //Added By Ninad 16 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
	if (SelectedMenu != null)
	{
		SelectedMenu.style.color=NewSelectedMenu.style.color;
		SelectedMenu.style.fontWeight=NewSelectedMenu.style.fontWeight;
	}
	SelectedMenu=NewSelectedMenu;
	SelectedMenu.style.color='red';
	SelectedMenu.style.fontWeight='bold';
	
	var ObjTDAddRemoveFavourite=GetObjectReference('','TDAddRemoveFavourite');
	var ObjtxtFavouriteTagIDs=GetObjectReference('','txtFavouriteTagIDs');

	if (TagID!=null && TagID!="" && TagID!="0" && ObjTDAddRemoveFavourite!=null && ObjtxtFavouriteTagIDs!=null)
	{
	    if((","+ObjtxtFavouriteTagIDs.value+",").indexOf(","+TagID+",")==-1)
	    {
	        ObjTDAddRemoveFavourite.innerHTML="<a title='Add to favourites' href=\"javascript:AddRemoveFavourites(0,"+TagID+")\"><img src='../Images/TreeNodeImages/AddFavorite.gif' style=\"border:none;\" /></a>";
	    }
	    else
	    {
	        ObjTDAddRemoveFavourite.innerHTML="<a title='Remove from favourites' href=\"javascript:AddRemoveFavourites(1,"+TagID+")\"><img src='../Images/TreeNodeImages/RemoveFavorite.gif' style=\"border:none;\" /></a>";
	    }
	}
}

//Added By Amol Changle On: 03 Dec 209

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
	    if(SelectedTab=="All")
	        SearchTree();
	    else
	        SearchFavouriteTree(); 	   
    }       
}

function Search_OnClick()
{
    if(SelectedTab=="All")
	    SearchTree();
    else
	    SearchFavouriteTree(); 	   
}

function SearchTree()
{
    //debugger
        var objtxtSearch=GetObjectReference('frmTree','txtSearch');
        var strSearch=objtxtSearch.value;
        var objdivlist=GetObjectReference('frmTree','divTree');
    
	    var arrNodeValue;
		var TagName;
		var URL;
		var intIndex;
		var HTML;
		NewTree.length=0;
		intCnt=0;

            if(strSearch=="")
            {
                //bharat on 7th-Oct-2015
                //HTML=createSearchTree(Tree,"",null,null,"../Images/");
                HTML = createSearchTree(Tree, "", null, null, "../../Images/");
                objdivlist.innerHTML=HTML;
                OpenNodes();
            }
            else
            {
            
                for(i=0;i<Tree.length;i++)
		        {
		            arrNodeValue=Tree[i].split("|");
			        TagName=arrNodeValue[2];
			        IsChild=arrNodeValue[5];
        			
			        if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")// || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB")))
			        {
			            addParentNode(arrNodeValue[1]);
			            NewTree[intCnt]=Tree[i];        
			            intCnt+=1;
                    }
                }
                //Bharat on 6th-Oct-2015
                HTML = createSearchTree(NewTree, strSearch, null, null, "../../Images/");
                //Bharat on 6th-Oct-2015
                objdivlist.innerHTML=HTML;
             }                
       
}
//function ValidateTask_Baseline(url) {
//    // TO SEE IF WE ARE RUNNING IN IE 
//    strNavigator = navigator.appName;
//    strNavigator = strNavigator.toUpperCase();
//    if (window.ActiveXObject || 'ActiveXObject' in window) {
//        g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
//        //hook the event handler
//        g_objXHttp.onreadystatechange = TaskValidation_state_change;
//        //prepare the call, http method=GET, false=asynchronous call
//        g_objXHttp.open("GET", url, false);
//        //finally send the call
//        g_objXHttp.send();
//    }
//    else {

//        // Mozilla - based browser , Netscape
//        g_objXHttp = new XMLHttpRequest();
//        //hook the event handler
//        g_objXHttp.onreadystatechange = TaskValidation_state_change;
//        //prepare the call, http method=GET, false=asynchronous call
//        g_objXHttp.open("GET", url, false);
//        //finally send the call
//        g_objXHttp.send(null);

//        if (g_objXHttp.responseText != null) {
//            xmlDoc = document.implementation.createDocument("", "", null);
//            xmlDoc.async = false;
//            xmlDoc.load(g_objXHttp.responseXML);
//            strResult = g_objXHttp.responseText;
//        }

//    }
    
//}

//function TaskValidation_state_change() {
//    if (g_objXHttp.readyState == 4) {

//        // Make sure request came back OK 
//        if (g_objXHttp.status == 200) {

//            if (window.ActiveXObject || 'ActiveXObject' in window) {
//                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
//                xmlDoc.async = false;
//                xmlDoc.loadXML(g_objXHttp.responseText);

//            }
//                // code for Mozilla, etc.
//            else if (document.implementation && document.implementation.createDocument) {
//                xmlDoc = document.implementation.createDocument("", "", null);
//                xmlDoc.async = false;
//                xmlDoc.load(g_objXHttp.responseXML);
//            }

//            //Save the Result in a Global variable

//            strResult = g_objXHttp.responseText;

//        }
//    }
//}

function WhichBrowser() {

    var brwser = '';
    var ua = navigator.userAgent, tem,
    M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
    if (/trident/i.test(M[1])) {
        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
        //return 'IE '+(tem[1] || '');
        return 'IE';
    }
    if (M[1] === 'Chrome') {
        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
        brwser = 'CR';
    }
    else if (M[1] === 'Firefox') {
        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
        brwser = 'FF';
    }
    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
    //return M.join(' ');
    return brwser;
}
//Added By Bharat T on 25th-Nov-2015
var strResult;
function ValidateResourceDate_XML(strUrl) {
    // TO SEE IF WE ARE RUNNING IN IE 
    var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
    strNavigator = navigator.appName;
    strNavigator = strNavigator.toUpperCase();
    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
    if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
    {
        g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
        //hook the event handler
        g_objXHttp.onreadystatechange = TaskValidation_state_change;
        //prepare the call, http method=GET, false=asynchronous call
        g_objXHttp.open("GET", strUrl, false);
        //finally send the call
        g_objXHttp.send();
    }
    else {
        // Mozilla - based browser , Netscape
        g_objXHttp = new XMLHttpRequest();
        //hook the event handler
        g_objXHttp.onreadystatechange = TaskValidation_state_change;
        //prepare the call, http method=GET, false=asynchronous call
        g_objXHttp.open("GET", strUrl, false);
        //finally send the call
        g_objXHttp.send(null);

        if (g_objXHttp.responseText != null) {
            xmlDoc = document.implementation.createDocument("", "", null);
            xmlDoc.async = false;
            if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                xmlDoc.load(g_objXHttp.responseXML);
            strResult = g_objXHttp.responseText;
        }
    }
    return strResult;
}

function TaskValidation_state_change() {
    var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
    if (g_objXHttp.readyState == 4) {
        // Make sure request came back OK 
        if (g_objXHttp.status == 200) {
            //if (window.ActiveXObject)
            if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
            {
                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                xmlDoc.async = false;
                xmlDoc.loadXML(g_objXHttp.responseText);
            }
                // code for Mozilla, etc.
            else if (document.implementation && document.implementation.createDocument) {
                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;
                if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                    xmlDoc.load(g_objXHttp.responseXML);
            }
            //Save the Result in a Global variable
            strResult = g_objXHttp.responseText;
        }
    }
}
//End of Added By Bharat T on 25th-Nov-2015
function SearchFavouriteTree()
{

        var objdivlist=GetObjectReference('frmTree','divTree');
        var objtxtSearch=GetObjectReference('frmTree','txtSearch');
        var objtxtFavouriteTagIDs = GetObjectReference('frmTree', 'txtFavouriteTagIDs');
        if (GetObjectReference('frmTree', 'hdnTemplate')!=null)
        var objhdnTemplate = GetObjectReference('frmTree', 'hdnTemplate').value;
        
    //Added By Bharat T on 25th-Nov-2015
        var url;
        //var a = "<%=m_strTemplateID %>";
        url = "../General/XMLHTTP.aspx?Action=GetFavIDs&FromWhere=" + objhdnTemplate + "";

        var result = ValidateResourceDate_XML(url);

        objtxtFavouriteTagIDs.value = result;
    //End of Added By Bharat T on 25th-Nov-2015
        var strSearch = objtxtSearch.value;
        
       if (objtxtFavouriteTagIDs != null) {
            var strFavouriteTagIDs = "," + objtxtFavouriteTagIDs.value + ",";
        //var strFavouriteTagIDs = ",2056,";

            var arrNodeValue;
            var TagName;
            var URL;
            var TagID;
            var intIndex;
            var HTML;
            NewTree.length = 0;
            intCnt = 0;

           //Commented and Added By Bharat T on 8th-Oct-2015
            //for (i = 0; i < Tree.length; i++) {
            //    arrNodeValue = Tree[i].split("|");
            //    //TagID = arrNodeValue[0];
            //    TagID = arrNodeValue[8];
            //    TagName = arrNodeValue[2];
            //    IsChild = arrNodeValue[5];

            //    if (strFavouriteTagIDs.indexOf("," + TagID + ",") != -1 && IsChild == "0") {
            //        if (trimString(strSearch) == "" || TagName.toLowerCase().indexOf(strSearch.toLowerCase()) != -1) {
            //            addParentNode(arrNodeValue[1]);
            //            NewTree[intCnt] = Tree[i];
            //            intCnt += 1;
            //        }
            //    }
    //}
            for (i = 0; i < Tree.length; i++) {
                arrNodeValue = Tree[i].split("|");
                TagName = arrNodeValue[2];
                IsChild = arrNodeValue[7];
                TagID = arrNodeValue[0];
                //if(TagName.toLowerCase().indexOf(strSearch.toLowerCase())!=-1 && IsChild=="0")
                if ((strFavouriteTagIDs.indexOf("," + TagID + ",")  != -1 && IsChild == "0") || ((TagName.toLowerCase().indexOf(strSearch.toLowerCase()) != -1) && ("<%=m_strTemplateID %>" == "CRM" || "<%=m_strTemplateID %>" == "DB"))) {
                    addParentNode(arrNodeValue[1]);
                    NewTree[intCnt] = Tree[i];
                    intCnt += 1;
                }
            }
            //Bharat on 6th-Oct-2015
            HTML = createSearchTree(NewTree, strSearch, null, null, "../../Images/", 1);
            //HTML = createSearchTree(NewTree, strSearch);
           //End of Commented and Added By Bharat T on 8th-Oct-2015
            objdivlist.innerHTML = HTML;
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


function Tree_onload()
{
    var intDivHeight ;
    var intDivWidth;
	var objdivTree=GetObjectReference('','divTree');
    
    if (navigator.appName=="Netscape") 
    {
        //intDivHeight = window.innerHeight - objdivTree.offsetTop - 5;  Commented & ADDED BY Puneet M on 10-SEPT-2015
        intDivHeight = (window.innerHeight - objdivTree.offsetTop - 5) - 12;
	    intDivWidth  = window.innerWidth  - objdivTree.offsetLeft - 5;
    }
	else
	{  
        //intDivHeight = document.body.offsetHeight - objdivTree.offsetTop - 5;  COMMENTED & ADDED BY PUNEET M ON 10-SEPT-2015
        intDivHeight = (window.innerHeight - objdivTree.offsetTop - 5) - 12;
		intDivWidth  = document.body.offsetWidth  - objdivTree.offsetLeft - 5;
    }
	if (intDivHeight < 100)	intDivHeight = 100;

    if (objdivTree != null )
    { 
        objdivTree.style.height = intDivHeight; 
        objdivTree.style.width  = intDivWidth;					
    }
}
		
function Tree_onresize()		
{
    var intDivHeight;
	var objdivTree=GetObjectReference('','divTree');
	var intDivWidth;
	
	if (navigator.appName=="Netscape") 
	{
	    intDivHeight = window.innerHeight - objdivTree.offsetTop - 5;
	    intDivWidth  = window.innerWidth  - objdivTree.offsetLeft - 5;
    }
	else
	{  
		intDivHeight = document.body.offsetHeight - objdivTree.offsetTop - 5;
		intDivWidth  = document.body.offsetWidth  - objdivTree.offsetLeft - 5;
    }
        
    if (intDivHeight < 100)	intDivHeight = 100;
	
    if (objdivTree != null ) 
    {
        objdivTree.style.height  = intDivHeight;			
        objdivTree.style.width  = intDivWidth;			
    }
        
        
}


function Tree_Switch(TabID)
{
    var ObjTabAll=GetObjectReference('','TdAll');
    var ObjTabFavourite=GetObjectReference('','TdFavourite');

    if(ObjTabAll==null || ObjTabFavourite==null)    return;
    
    if(TabID=="All")
    {
        ObjTabAll.innerHTML="<span id='selected'>All</span>";
        ObjTabFavourite.innerHTML="<a  class='navtab' Title='Favourite' href=\"javascript:Tree_Switch('Favourite')\">Favourite</a>";
        SelectedTab="All";
        SearchTree();
    }
    else
    {
        ObjTabAll.innerHTML="<a  class='navtab' Title='All' href=\"javascript:Tree_Switch('All')\">All</a>";
        ObjTabFavourite.innerHTML="<span id='selected'>Favourite</span>";
        SelectedTab="Favourite";
        SearchFavouriteTree();
    }
}

function AddRemoveFavourites(AddRemove,TagID)
{
    
    var ObjTDAddRemoveFavourite=GetObjectReference('','TDAddRemoveFavourite');
    if(ObjTDAddRemoveFavourite==null) return;
    
    if(AddRemove==0)
    {
        ObjTDAddRemoveFavourite.innerHTML="<a title='Remove from favourites' href=\"javascript:AddRemoveFavourites(1,"+TagID+")\"><img src='../Images/TreeNodeImages/RemoveFavorite.gif' style=\"border:none;\" /></a>";
    }
    else
    {
	    ObjTDAddRemoveFavourite.innerHTML="<a title='Add to favourites' href=\"javascript:AddRemoveFavourites(0,"+TagID+")\"><img src='../Images/TreeNodeImages/AddFavorite.gif' style=\"border:none;\" /></a>";
    }
    var XMLHttp = null;
	if (window.XMLHttpRequest) {// code for all new browsers
		XMLHttp = new XMLHttpRequest();
	}
	else if (window.ActiveXObject) {// code for IE5 and IE6
		XMLHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}

	if (XMLHttp == null) {
		alert("XMLHTTP object can not be created!");
		return;
	}

	XMLHttp.open("POST", '../Source/General/XMLHTTP.aspx?TagID=8&TemplateID='+TemplateID+"&FavouriteTagID="+TagID+"&AddRemove="+AddRemove, false);
	XMLHttp.send();
	if (XMLHttp.readyState == 4) {// 4 = "loaded"
		if (XMLHttp.status == 200) {// 200 = OK
			{
				var Response = XMLHttp.responseText;
				var objtxtFavouriteTagIDs=GetObjectReference('frmTree','txtFavouriteTagIDs'); 
				
				if(objtxtFavouriteTagIDs==null) return;
				
				objtxtFavouriteTagIDs.value=Response;
				if(SelectedTab=="Favourite") 
				    Tree_Switch("Favourite");
			}
		}
		else 
		{
			alert ("Problem retrieving XML data. URL may not exist or accessible or readystate problem or session expired");
			return;
		}
	}

}    	

//End Addition
