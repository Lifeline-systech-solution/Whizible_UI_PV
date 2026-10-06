<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_ProductTree.aspx.vb" Inherits="PbNIT.CRM_ProductTree" %>

<!DOCTYPE HTML>
<style>
          /*Added By Yasmin on 25th july 2018*/
     .ui-tooltip {
	        padding: 5px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }
        .ui-tooltip-content::after, .ui-tooltip-content::before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
}

.bottom .ui-tooltip-content::after {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.bottom .ui-tooltip-content::before {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.top .ui-tooltip-content::after {
    top: -6px;
    left: 50%;
    border-bottom-color: #000;
    
    border-width: 0 6px 6px;
    margin-left: -6px;
}

.top .ui-tooltip-content::before {
     border-color: rgba(118, 118, 118, 0);
     border-bottom-color: #000;
     top: -6px;
     left: 50%;
     border-width: 0 6px 6px;
     margin-left: -6px;
 }
    #divLeft {
        position: absolute !important;
        top: 0px !important;
    }

    .clsTable {
        position: relative;
    }
    #divPage {
        overflow:hidden !important;
    }
  
</style>
<html>

    <%CommonFunctions.General.PlotPageHeadTag("")%>
<%Whizible.clsCommonFunctions.PlotPageHeadTag("ProductTree")%>
<!--Including files & Libraries by Miiint Solutions-->
<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>


<!--<script type="text/javascript" src="responsive/responsive.js"></script>-->
<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
<%--<meta charset="utf-8" />--%>
<meta name="description" content="" />
<meta name="author" content="" />

<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
<meta name='vs_defaultClientScript' content='JavaScript'>
<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Pragma" content="no-cache">


<!-- Bootstrap core CSS -->
<%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>


<%--<link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />--%>
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />

<script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

 <%--<link href='../../../General/loaderStylesheet.css' rel='stylesheet' />--%>

<style>
 



    .content-wrapper {
        margin-left: 0px !important;
        padding-left: 0px !important;
    }

 
    .h-tabs div .panel-heading {
        height: 21px;
        border-style: solid;
        border-color: #e3e2e2;
        border-width: 1px 0 1px 0;
        background: #cbddfa;
    }

    .table-responsive .btn-default.btn {
        padding: 0;
        background: none;
        border: none;
    }

    .table-responsive .fa {
        font-size: 15px;
    }

    .clsTRColumnHeader th:nth-child(2) {
        text-align: center;
    }

    .clsTRColumnHeader th:nth-child(3) {
        text-align: center;
    }

    .dataTables_wrapper .row:nth-child(1) {
        display: none;
    }


    .table-responsive {
        overflow: hidden;
    }

    .control-label {
        font-weight: normal !important;
    }


    td {
        font-family: helvetica !important;
        font-size: 12px !important;
    }

 
    table tr th {
        border: 1px solid #ddd !important;
    }
    tr.group,
    tr.group:hover {
        background-color: #ddd !important;
    }

    .dataTables_paginate, .dataTables_info {
        display: none;
    }
   .clsTable {
      font-family:helvetica !important;
    }
    a:hover,a:focus {
  font-family:helvetica !important;
  cursor:pointer !important;
  font-size:12px !important;
    }
     a:hover,a:focus {
        transition: none !important;
    }
    #divRight {
        width:104% !important;
        padding-right :1% !important;

    }
    #divLeft{
      
      overflow:hidden!important;
        
    }
    #divLeft:hover{
 overflow:auto !important;
    }
      .clsTRColumnHeader th {
            /*background-color:#F0D1A1;/*#e6ffff*/
            padding: 5px !important;
            position: relative;
            /*background-clip: padding-box;*/
            /*background-color:#f0ccc3!important;*/
            border: 1px solid white;
        }
    /*TD_Right {
        padding:0px !important;
    }*/
</style>

<script>
 

    var nodes = new Array();;
    var openNodes = new Array();
    var icons = new Array(6);
    var SelectedMenu;

    var pathprefix = "../"
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
 
    function getArrayId(node) {
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[0] == node) return i;
        }
    }
    // Puts in array nodes that will be open
    function setOpenNodes(openNode) {
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[0] == openNode) {
                openNodes.push(nodeValues[0]);
                setOpenNodes(nodeValues[1]);
            }
        }
    }
    // Checks if a node is open
    function isNodeOpen(node) {
        for (i = 0; i < openNodes.length; i++)
            if (openNodes[i] == node) return true;
        return false;
    }
    // Checks if a node has any children
    function hasChildNode(parentNode) {
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[1] == parentNode) return true;
        }
        return false;
    }
    // Checks if a node is the last sibling
    function lastSibling(node, parentNode) {
        var lastChild = 0;
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[1] == parentNode)
                lastChild = nodeValues[0];
        }
        if (lastChild == node) return true;
        return false;
    }
    // Adds a new node in the tree
  
    // Opens or closes a node
    function oc(node, bottom) {
        var theDiv = document.getElementById("div" + node);
        var theJoin = document.getElementById("join" + node);
        var theIcon = document.getElementById("icon" + node);
        var nodeval = new Array;
        // Modified by SandipL on 9 Mar 2006
        var index;
        index = getArrayId(node);
        nodeval = nodes[index].split("|");
        //nodeval = nodes[node-1].split("|");
        // End modification by SandipL
        if (theJoin) {
            if (theDiv.style.display == 'none') {
                if (bottom == 1) theJoin.src = icons[3].src;
                else theJoin.src = icons[2].src;
                theIcon.src = "../../Images/" + nodeval[6] //icons[5].src;
                theDiv.style.display = '';
                //theDiv.style.backgroundcolor='lavender';
            } else {
                if (bottom == 1) theJoin.src = icons[1].src;
                else theJoin.src = icons[0].src;
                theIcon.src = "../../Images/" + nodeval[6] //icons[4].src;
                theDiv.style.display = 'none';
                //theDiv.style.backgroundcolor='lavender';
            }
        }
    }
    // Push and pop not implemented in IE(crap!    don´t know about NS though)
    if (!Array.prototype.push) {
        function array_push() {
            for (var i = 0; i < arguments.length; i++)
                this[this.length] = arguments[i];
            return this.length;
        }
        Array.prototype.push = array_push;
    }
    if (!Array.prototype.pop) {
        function array_pop() {
            lastElement = this[this.length - 1];
            this.length = Math.max(this.length - 1, 0);
            return lastElement;
        }
        Array.prototype.pop = array_pop;
    }
    function trimString(str) {
        str = this != window ? this : str;
        return str.replace(/^\s+/g, '').replace(/\s+$/g, '');
    }

    //Issue ID 28888
    function GetObjectReference(strFormId, strElementId, blnIsName) {
        var objElement;
        var objCombo;

        if (blnIsName) {
            objElement = document.getElementsByName(strElementId);
        }
        else if (!(blnIsName)) {
            objElement = document.getElementById(strElementId);
        }
        return objElement;

    }

    function GetFormReference(strFormId) {
        var objElement;

        objElement = document.getElementById(strFormId);
        return objElement;

    }
    //End
    //Added by SandipL on 9 Mar 2006 to open all nodes
    function OpenAllNodes() {
        var intCount;
        var nodeValues;
        for (intCount = 0; intCount <= nodes.length - 1; intCount++) {
            nodeValues = nodes[intCount].split("|");
            oc(nodeValues[0], 0)

        }

    }


    //added by SanaS on 19-Nov-2009 for Product tree issue

    function createSearchTree(arrName, SearchText, startNode, openNode) {

        strHTML = '';
        pathprefix = (arguments.length > 2) ? arguments[3] : "../../../Images/";
        nodes = arrName;

        if (SearchText == "")
            ShowOpen = false;
        else
            ShowOpen = true;

        if (nodes.length > 0) {
            preloadIcons();
            if (startNode == null) startNode = 0;
            if (openNode != 0 || openNode != null) setOpenNodes(openNode);

            if (startNode != 0) {
                var nodeValues = nodes[getArrayId(startNode)].split("|");
                if (nodeValues[6] != "page.gif") {
                    strHTML += "<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />";
                }
                else {
                    strHTML += "<a href=\"" + nodeValues[3] + "\" onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\"><img src='" + pathprefix + "TreeNodeImages/folderopen.gif' align=\"absbottom\" alt=\"\" border=0/>" + nodeValues[2] + "</a><br />";
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

                var ls = lastSibling(nodeValues[0], nodeValues[1]);
                var hcn = hasChildNode(nodeValues[0]);
                var ino = ShowOpen;//isNodeOpen(nodeValues[0]);

                // Write out line & empty icons
                for (g = 0; g < recursedNodes.length; g++) {
                    if (recursedNodes[g] == 1) strHTML += "<img src='" + pathprefix + "TreeNodeImages/line.gif' align=\"absbottom\" alt=\"\" border=0 />";
                    else strHTML += "<img src='" + pathprefix + "TreeNodeImages/empty.gif' align=\"absbottom\" alt=\"\" border=0 />";
                }

                // put in array line & empty icons
                if (ls) recursedNodes.push(0);
                else recursedNodes.push(1);

                // Write out join icons
                if (hcn) {
                    if (ls) {
                        strHTML += "<a href=\"javascript: oc(" + nodeValues[0] + ", 1,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/";
                        if (ino) strHTML += "minus";
                        else strHTML += "plus";
                        strHTML += "bottom.gif' align=\"absbottom\" alt=\"Open/Close node\" border=0 /></a>";
                    } else {
                        strHTML += "<a href=\"javascript: oc(" + nodeValues[0] + ", 0,'" + nodeValues[6] + "');\"><img id=\"join" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/";
                        if (ino) strHTML += "minus";
                        else strHTML += "plus";
                        strHTML += ".gif' align=\"absbottom\" alt=\"Open/Close node\" border=0/></a>";
                    }
                } else {
                    if (ls) strHTML += "<img src='" + pathprefix + "TreeNodeImages/join.gif' align=\"absbottom\" alt=\"\" border=0/>";
                    else strHTML += "<img src='" + pathprefix + "TreeNodeImages/joinbottom.gif' align=\"absbottom\" alt=\"\" border=0/>";
                }

                // Start link
                //document.write("<a href=\"" + nodeValues[3] + "\" target=Sub onmouseover=\"window.status='" + nodeValues[2] + "';return true;\" onmouseout=\"window.status=' ';return true;\">");

                if (trimString(nodeValues[3]) != "")
                    // Modified by purvaj on 30 Jun 2009 for 8.1 Issue fixes
                    // tooltip was wrong. title added
                    strHTML += "<a title='" + nodeValues[2] + "' onClick=TabItemOnClick(this,\"" + nodeValues[3] + "\"," + nodeValues[0] + "," + nodeValues[5] + ") ' style='text-decoration:none' border=0 target=Sub Title='" + nodeValues[4] + "' onmouseover=\"window.status='" + nodeValues[4] + "';return true;\" onmouseout=\"window.status=' ';return true;\">";
                else {
                    if (trimString(nodeValues[7]) == "0")
                        strHTML += "<span id=Inactive>";
                    else
                        strHTML += "<a href='#' style='text-decoration:none;cursor:pointer' ><b>";
                }

                // Write out folder & page icons
                if (hcn) {
                    if (nodeValues[6] != "page.gif") {
                        strHTML += "<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='" + nodeValues[4] + "' border=0/>";
                    }
                    else {
                        strHTML += "<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/folder";
                        if (ino) strHTML += "open";
                        //document.write(".gif\" align=\"absbottom\" alt=\"Folder\" />");
                        strHTML += ".gif' align=\"absbottom\" alt='" + nodeValues[4] + "' border=0/>";
                    }
                } else {
                    if (nodeValues[6] != "page.gif") {
                        strHTML += "<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/" + nodeValues[6] + "' align=\"absbottom\" alt='" + nodeValues[4] + "' border=0/>";
                    }
                    else {
                        strHTML += "<img id=\"icon" + nodeValues[0] + "\" src='" + pathprefix + "TreeNodeImages/page.gif' align=\"absbottom\" alt='" + nodeValues[4] + "' border=0 />";
                    }
                }
                //document.write("<img id=\"icon" + nodeValues[0] + "\" src=\"img/page.gif\" align=\"absbottom\" alt=\"Page\" />");

                // Write out node name
                strHTML += nodeValues[2];


                // End link
                if (trimString(nodeValues[3]) != "")
                    strHTML += "</a><br />";
                else {
                    if (trimString(nodeValues[7]) == "0")
                        strHTML += "</span><br />";
                    else
                        //strHTML+="</b><br />";
                        strHTML += "</b></a><br />";
                }

                // If node has children write out divs and go deeper
                if (hcn) {
                    strHTML += "<div id=\"div" + nodeValues[0] + "\" nowrap=true";
                    if (!ino) strHTML += " style=\"display: none;\"";
                    strHTML += ">";
                    addSearchTreeNode(nodeValues[0], recursedNodes);
                    strHTML += "</div>";
                }

                // remove last line or empty icon 
                recursedNodes.pop();
            }
        }
    }


    // Loads all icons that are used in the tree


    // Puts in array nodes that will be open
    function setOpenNodes(openNode) {
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[0] == openNode) {
                openNodes.push(nodeValues[0]);
                setOpenNodes(nodeValues[1]);
            }
        }
    }

    function oc(node, bottom, strImageName) {


        //debugger;
        var theDiv = document.getElementById("div" + node);
        var theJoin = document.getElementById("join" + node);
        var theIcon = document.getElementById("icon" + node);
        if (strImageName == undefined) strImageName = "page.gif"
        if (theJoin) {
            if (theDiv.style.display == 'none') {
                if (bottom == 1) theJoin.src = icons[3].src;
                else theJoin.src = icons[2].src;

                if (strImageName != "page.gif") {
                    theIcon.src = pathprefix + "TreeNodeImages/" + strImageName;
                }
                else {
                    theIcon.src = icons[5].src;
                }
                theDiv.style.display = '';
            } else {
                if (bottom == 1) theJoin.src = icons[1].src;
                else theJoin.src = icons[0].src;
                if (strImageName != "page.gif") {
                    theIcon.src = pathprefix + "TreeNodeImages/" + strImageName;
                }
                else {
                    theIcon.src = icons[4].src;
                }
                theDiv.style.display = 'none';
            }
        }
    }

    // Checks if a node has any children
    function hasChildNode(parentNode) {
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[1] == parentNode) return true;
        }
        return false;
    }
    // Checks if a node is the last sibling
    function lastSibling(node, parentNode) {
        var lastChild = 0;
        for (i = 0; i < nodes.length; i++) {
            var nodeValues = nodes[i].split("|");
            if (nodeValues[1] == parentNode)
                lastChild = nodeValues[0];
        }
        if (lastChild == node) return true;
        return false;
    }


    function HighlightSelected(NewSelectedMenu) {
        //if (ShowNavigationAlert() == false) return; //Added By Ninad 16 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        if (SelectedMenu != null) {
            SelectedMenu.style.color = NewSelectedMenu.style.color;
            SelectedMenu.style.fontWeight = NewSelectedMenu.style.fontWeight;
        }
        SelectedMenu = NewSelectedMenu;
        SelectedMenu.style.color = 'red';
        SelectedMenu.style.fontWeight = 'bold';
    }
</script>
<body ms_positioning="GridLayout" class="" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPRD_ProductTree" method="post" runat="server">
     
            <%PageInit()%>
           
    </form>
    <script language="javascript" type="text/javascript">
        var objform = GetFormReference('frmPRD_ProductTree');
        var objdivlist = GetObjectReference('frmPRD_ProductTree', 'PageDiv');
        var objdivLeft = GetObjectReference('frmPRD_ProductTree', 'divLeft');
        var objdivRight = GetObjectReference('frmPRD_ProductTree', 'divRight');
        var objdivpage = GetObjectReference('frmPRD_ProductTree', 'divPage');
        var strResult = "";
        var strPageName = "CRM_ProductTree.aspx";
      
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
        disableRightClick();
        <%End If%>
     
      

        function window_onload() {
         

            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                if (intDivHeight < 100) intDivHeight = 100;
                //Commented and added by Yogesh J on 11/12/2015
                //objdivlist.style.height = intDivHeight;

                objdivlist.style.height = intDivHeight + 'px';

            }
             
            else if (objdivpage != null) {
                intDivHeight = window.innerHeight - objdivpage.offsetTop - 250;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivpage.style.height = intDivHeight + 'px';
            }

            if (objdivLeft != null && objdivRight != null) {
                intDivHeight = window.innerHeight - objdivpage.offsetTop - 280;
                objdivRight.style.height = intDivHeight + 'px';
                objdivLeft.style.height = intDivHeight + 'px';

            }
          
        }

        function window_onresize() {
            var intDivHeight;
            var intDivHeightRisk;
            if (objdivlist != null) {
                intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
                if (intDivHeight < 100) intDivHeight = 100;

                objdivlist.style.height = intDivHeight + 'px';
            }

                /*Commented and added by Yogesh J on 19/12/2015* issue id = 2752 */
            else if (objdivpage != null) {
                intDivHeight = window.innerHeight - objdivpage.offsetTop - 38;
                if (intDivHeight < 100) intDivHeight = 100;
                objdivpage.style.height = intDivHeight + 'px';

            }
            if (objdivLeft != null && objdivRight != null) {
                intDivHeight = window.innerHeight - objdivpage.offsetTop - 45;
                objdivRight.style.height = intDivHeight + 'px';
                objdivLeft.style.height = intDivHeight + 'px';

            }
          
        }
     
        function TabItemOnClick(NewSelectedMenu, PageName, TagID, ControlItemID, ev) {

            if (SelectedMenu != null) {
                SelectedMenu.style.color = NewSelectedMenu.style.color;
                SelectedMenu.style.fontWeight = NewSelectedMenu.style.fontWeight;
            }
            SelectedMenu = NewSelectedMenu;
            SelectedMenu.style.color = 'red';
            SelectedMenu.style.fontWeight = 'bold';
            var num;
            var str = PageName;
            str = str.split("(");
            num = str[1];
            num = num.substring(0, num.length - 1);
            Node_OnClick(num);
          

        }
  
        function Node_OnClick(NodeID) {

     
            document.getElementById("divLeft").style.position = ""
    



            var data;
            var strResult;
            setFrameLoader();
            data = JSON.stringify({ NodeID: NodeID })
            strResult = AJAXCallWithResult(strPageName + "/GenerateInformation", data, false);
            if (strResult.d != null) {

                $("#divRight").html("");
                $("#divRight").html(strResult.d);
                datatables("divRight");
            
           
            }
            RemoveFrameLoader();
            window.parent.jQuery("#preloader").remove();
            window.parent.jQuery("#fillDiv").remove();
            window.parent.jQuery("#preloader").fadeOut("slow");
            window.parent.jQuery("#fillDiv").fadeOut("slow");
            window.parent.jQuery("#preloader").remove();
            window.parent.jQuery("#fillDiv").remove();
        }
        var brw = WhichBrowser();

      





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
        function AJAXCallWithResult(url, data, async) {
            console.log(url);
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                //timeout: 180000,
                async: async,
                success: function (result) {
                    AjaxResult = result;
                    $(".loadingoverlay", parent.document).css("display", "none");
                    //Stop();
                },
                error: function (xhr, status, error) {
                    //Stop();
                    //StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }
        function datatables(divID, txtBoxID) {
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' > table').DataTable({
                columnDef: [
             { "visible": false, "targets": 0 }
                ],
                "ordering": false,
                responsive: true,
                //"pageLength": 3,
                "paging": false,
                //scrollY: '120px',
                //pagingType: "simple_numbers",
                //scrollX: true,
                language: {

                },


            });
            $(".clsTRColumnHeader th").css("top", "0px")
            $("#divRight").scroll(function () {
                $(".clsTRColumnHeader th").css("top", $("#divRight").scrollTop() - 1);
            });

            var color = $('.clsTRColumnHeader').css('background-color');
            $(".clsTRColumnHeader th").css("background-color", color);
            //$(".clsTROdd td:first-child").html("");
            //$(".clsTREvenRow td:first-child").html("");
        }
        $(function () {
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });

        });
        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });

    </script>

</body>
</html>
