<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="KM_Home.aspx.vb" Inherits="PbNIT.KM_Home" %>

<html>
<!--onresize="window_onresize()" onload="window_onload()"-->
<%CommonFunctions.General.PlotPageHeadTag("Knowledge Home", , , , "<script type='text/javascript' src='../Home/homeTree.js'></script>")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css' />
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css' />
<link rel='stylesheet' type='text/css' href='../General/tab-view.css' />
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>


<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
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

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
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

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

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
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmKMHome" method="post" runat="server">
        <%WritePage()%>
        <iframe id="iFloatingMenu" name="iFloatingMenu" style="display: none; z-index: 100; position: absolute; overflow: visible;"></iframe>
    </form>

    <script type="text/javascript">
        var objForm;
        var objFrame = GetObjectReference('', 'iFloatingMenu');
        var showFloatingmenu = '0';
        var ie5 = document.all && document.getElementById
        var ns6 = document.getElementById && !document.all
        var objdivlist = GetObjectReference('frmTree', 'tree');

        var strSearch = "";



        objForm = GetFormReference('frmKMHome');

        <%' Added By SonalD on 13th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then%>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 13th Jan 2009 %>

        var objDivMain = GetObjectReference('frmKMList', 'divPage');
        var objDivTree = GetObjectReference('frmKMList', 'Tree');
        var objtrGM = GetObjectReference('', 'trGM');
        var objhidtxtThemeID = GetObjectReference('frmHome', 'hidTxtThemeID');

        function window_onload() {
            var intDivHeight;
            var HeightDiff;

            if (navigator.appName == "Netscape")
                calcHeight();

            if (objDivMain != null) {
                if (navigator.appName == "Netscape") {
                    intDivHeight = window.innerHeight - 30;
                }
                else {
                    intDivHeight = document.body.offsetHeight - 30;
                }

                if (intDivHeight < 100)
                    intDivHeight = 100;
                objDivMain.style.height = intDivHeight + "px";
                objDivTree.style.height = intDivHeight + "px";

            }
            //document.body.style.height=document.body.clientHeight;
            if (navigator.appName == 'Microsoft Internet Explorer')
                calcHeight();
        }

        function window_onresize() {
            //document.body.style.height=document.body.clientHeight;
            var intDivHeight;
            var HeightDiff;

            if (objDivMain != null) {
                if (navigator.appName == "Netscape") {
                    intDivHeight = window.innerHeight + 10;
                }
                else {
                    intDivHeight = document.body.offsetHeight + 50;
                }

                if (intDivHeight < 100)
                    intDivHeight = 100;
                objDivMain.style.height = intDivHeight +'px';
                objDivTree.style.height = intDivHeight + "px";
                var objtable = GetObjectReference('frmKMHome', 'tblMain')

            }
            calcHeight();
        }

        function ProdVersion_OnClick(ProductLineID, ProductID, VersionID) {
            //	     var strDisplayStyleProd,strDisplayStyleProdVer; 
            //	     var objTblProd = GetObjectReference('frmKMHome','tblProd'+ProductLineID);
            //	     var objTblProdVer = GetObjectReference('frmKMHome','tblProdVer'+ProductID);
            //	     strDisplayStyleProd = objTblProd.style.display;
            //	     strDisplayStyleProdVer = objTblProdVer.style.display;
            //	     if(strDisplayStyleProd != 'none') 
            //	     {  
            //	        strDisplayStyleProd = 'x';
            //	     }
            //	     if(strDisplayStyleProdVer != 'none') 
            //	     {  
            //	        strDisplayStyleProdVer = 'y';
            //	     }
            objForm.action = "KM_Home.aspx?DisplayStyleProd=1|" + ProductLineID + "&DisplayStyleProdVer=1|" + ProductID + "&SelectList=8&VersionNumber=" + VersionID;
            objForm.submit();
        }

        function Home_OnClick() {
            window.location.href = "../KM/Km_Home.aspx?SelectList=1";
            //document.getElementById("iTabDetails").src="../KM/Km_MySpace.aspx?From=HOME"; //?SelectList=1"
        }

        function TopTen_OnClick() {
            //window.location.href="../KM/Km_Home.aspx?SelectList=2";
            //document.getElementById("iTabDetails").src="../KM/Km_List.aspx?SelectList=2"; 
            GetObjectReference('frmKMHome', 'txtsearch').value = '';
            objForm.action = "KM_Home.aspx?SelectList=2";
            objForm.submit();


        }

        function Go_OnClick(intFlag) {
            //window.open("KM_Home.aspx?SelectList=3","_self","resizable=no,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=750,height=650");

            /*if(GetObjectReference('frmKMHome','txtsearch').value=='')
            {
                alert('Enter text to search...');
                GetObjectReference('frmKMHome','txtsearch').focus();
                return true;
            }
           
            var strSelectList=GetObjectReference('frmKMHome','hidSelectList').value;
            
            objForm.action="KM_Home.aspx?SelectList=3";
            objForm.submit();*/

            if ('<%=strSelectList %>' == 3 || '<%=strSelectList %>' == 1 || '<%=strSelectList %>'==2)
            {
	         /*    if(GetObjectReference('frmKMHome','txtsearch').value=='')
	           {
	                alert('Enter text to search...');
	                GetObjectReference('frmKMHome','txtsearch').focus();
	                return;
	            }*/
    	   if (intFlag == 1)
	             objForm.action="KM_Home.aspx?SelectList=3&Search=Tree";
	       else
	            objForm.action="KM_Home.aspx?SelectList=3&Search=Text";
	            
	             objForm.submit();
	         }
	        else
	        {
	            if (intFlag == 1)
	             objForm.action="KM_Home.aspx?SelectList=<%=strSelectList %>&Search=Tree";
	            else
	                objForm.action = "KM_Home.aspx?SelectList=<%=strSelectList %>&Search=Text";
	             
	             objForm.submit();
	        }
	   
	    
	}
	
	function MyArticle_OnClick()
	{

	   var txtSearch=GetObjectReference('frmKMHome','txtsearch').value;
	   var strSelectList=GetObjectReference('frmKMHome','hidSelectList').value;
	   GetObjectReference('frmKMHome','txtsearch').value='';
	   objForm.action="KM_Home.aspx?SelectList=4&txtSearch="+txtSearch;
	   objForm.submit();
	}
	
	function MySpace_OnClick()
	{
	   var txtSearch=GetObjectReference('frmKMHome','txtsearch').value;
	   var strSelectList=GetObjectReference('frmKMHome','hidSelectList').value;
	   GetObjectReference('frmKMHome','txtsearch').value='';
	   objForm.action="KM_Home.aspx?SelectList=5&txtSearch="+txtSearch;
	   objForm.submit();
	}
	
	
	function MyTeam_OnClick()
	{
	   var txtSearch=GetObjectReference('frmKMHome','txtsearch').value;
	   var strSelectList=GetObjectReference('frmKMHome','hidSelectList').value;
	   GetObjectReference('frmKMHome','txtsearch').value='';
	   objForm.action="KM_Home.aspx?SelectList=6&txtSearch="+txtSearch;
	   objForm.submit();
	}
	
	function textSearch_OnKeyPress(e)
	{
        //alert('<%=strSelectList %>');
	    var code;
	    var objtxtSearch = GetObjectReference('frmKMHome', 'txtsearch');
	    //var strPagePath=
	    if (e.keyCode) code = e.keyCode;
	    else if (e.which) code = e.which;

	    if (code == 13) {
	        if ('<%=strSelectList %>' == 3 || '<%=strSelectList %>' == 1 || '<%=strSelectList %>' == 2) {
                /*  if(GetObjectReference('frmKMHome','txtsearch').value=='')
                  {   
                      //alert('Enter text to search...');
                      GetObjectReference('frmKMHome','txtsearch').focus();
                      return true;
                  }
                  else
                  {   */
                objForm.action = "KM_Home.aspx?SelectList=3&Search=Tree";//3
                objForm.submit();
                //}
            }
            else {
                objForm.action = "KM_Home.aspx?SelectList=<%=strSelectList %>";
	             objForm.submit();
	        }
	    }
	}
	
	 function RateArticle(ArticleID)
		{
		    window.open("../../Source/KM/KM_ArticleRating.aspx?From=HOME&ProcedureID="+ArticleID+"" ,null,"resizable=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 290)/2 + ",width=400,height=290");
		    
		}
		
    function calcHeight()
	{
	    var height=window.innerWidth;//Firefox
	    //var Tdheight=document.getElementById(tdMainRight).offsetheight;
	    if (document.body.clientHeight)
	    {
		    height=document.body.clientHeight;//IE
	    }
    	document.getElementById("iTabDetails").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop -40)+"px";
    	
    	if (navigator.appName=="Netscape") 
		    document.getElementById("tree").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop-(objtrGM.offsetHeight+40))+"px";	  
		else    	
    	    document.getElementById("tree").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop-(objtrGM.offsetHeight+40))+"px";	  
    	
    	//alert(document.getElementById("tree").style.height);
  
    	
	}
	
	function ShowHideProdCol()
	{
	
	    //var objTbl = GetObjectReference('frmKMHome','tblProdCol');
	    var objTbl = GetObjectReference('frmKMHome','tblProdCol');
	    var objMenuImage=GetObjectReference('frmKMHome','tdShowHideProdCol');
		if (objTbl.style.display=="none")
	    {
	            objTbl.style.display="";
	            objMenuImage.src = "../../Images/minus.gif";
	    }
	    else
	    {
	             objTbl.style.display="none";
	             objMenuImage.src = "../../Images/plus.gif"
	    }
	}

function ShowHideProdLine(ProdLineID)
{
        
        var objhidProductLineID = GetObjectReference('frmKMHome','hidProductLineID').value;
        var objProductLineIds = objhidProductLineID.split(',');
        var cnt;
        var objTbl;
        var objMenuImage;
        
        for(cnt=0;cnt<objProductLineIds.length-1;cnt++)
        {
            objTbl = GetObjectReference('frmKMHome','tblProd'+objProductLineIds[cnt]);
	        objMenuImage=GetObjectReference('frmKMHome','tdShowHideProdLine'+objProductLineIds[cnt]);
		    if (objTbl.style.display=="none")
	        {
	                if(ProdLineID==objProductLineIds[cnt])
	                {
	                    objTbl.style.display="";
	                    objMenuImage.src = "../../Images/TreeNodeImages/bo.gif";
	                }
     
	        }
	        else
	        {       
	                if(ProdLineID==objProductLineIds[cnt])
	                {
	                    objTbl.style.display="none";
	                    objMenuImage.src = "../../Images/TreeNodeImages/base.gif"
	                }
	        }
	    }
}

function ShowHideProd(ProductID)
{
        var objhidProductID = GetObjectReference('frmKMHome','hidProductIDs').value;
        var objProductIds = objhidProductID.split(',');
        var cnt;
        var objTbl;
        var objMenuImage;
        
        for(cnt=0;cnt<objProductIds.length-1;cnt++)
        {
            objTbl = GetObjectReference('frmKMHome','tblProdVer'+objProductIds[cnt]);
	        objMenuImage=GetObjectReference('frmKMHome','tdShowHideProd'+objProductIds[cnt]);
		    if (objTbl.style.display=="none")
	        {
	                if(ProductID==objProductIds[cnt])
	                {
	                    objTbl.style.display="";
	                    objMenuImage.src = "../../Images/TreeNodeImages/bo.gif";
	                }
     
	        }
	        else
	        {       
	                if(ProductID==objProductIds[cnt])
	                {
	                    objTbl.style.display="none";
	                    objMenuImage.src = "../../Images/TreeNodeImages/base.gif"
	                }
	        }
	    }
	 
}

function Statistics_OnClick()
{
	   var txtSearch=GetObjectReference('frmKMHome','txtsearch').value;
	   var strSelectList=GetObjectReference('frmKMHome','hidSelectList').value;
	   
	   objForm.action="KM_Home.aspx?SelectList=9&txtSearch="+txtSearch;
	   objForm.submit();
}	

    function HideTree()
    {
        ObjTd=GetObjectReference('','tdMainLeft');
        ObjImg=GetObjectReference('','ImgShowHide');
        //added by purvaj
        ObjLeftnavigation=GetObjectReference('','tblLeftNavigation');
        //end adition purvaj        
        
        if(ObjTd!=null && ObjImg!=null)
        {
            if(ObjImg.src.toUpperCase().match('RIGHTMOVE.GIF'))
            {
                ObjTd.style.display='';
                ObjImg.src='../../Images/Home/LeftMove.gif';
                ObjLeftnavigation.style.display='none';
            }
            else
            {
                ObjTd.style.display='none';
                ObjImg.src='../../Images/Home/RightMove.gif';
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
        ObjTd=GetObjectReference('','tdMainLeft');
        if(ObjTd!=null)
            ObjTd.style.display='';
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

/*function TabItemOnClick(PageName,TagID,ControlItemID)
{

    if(PageName.indexOf("javascript")>=0 )	
    {
        t= setTimeout(PageName,1);
    }
   
}*/
 ////////////////////////////////////////////////////////////////////

   function Tab_OnClick(strFromWhere)
	{
	    var subPage='../Home/Home.aspx?FromWhere='+strFromWhere;
	   // if(strFromWhere!='CRM')               
		    window.open("../General/Navigation.aspx?FromWhere="+strFromWhere,"_top")
		/*else
		    {
		      objform.action='../Home/Home.aspx?FromWhere=CRM';
              objform.submit();     
		    }    */
	}
	
	function ShowHideModules()
	{
	    var objimgUpDown=GetObjectReference('','imgUpDown');
	    var objTRModules=GetObjectReference('','trModules',true);
	    var objhidTxtModules=GetObjectReference('','hidTxtModules');
	    var objtdModuleBar=GetObjectReference('','tdModuleBar');
	    var objtrModuleBar=GetObjectReference('','trModuleBar');
	    var IsShrink=false;
	    
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
	    
	   if(IsShrink)
	   {
	            objimgUpDown.src='../../Images/Sort_up.gif';
	            if(objhidTxtModules!=null && objtrModuleBar!=null)
	            {
	                objtdModuleBar.innerHTML=objhidTxtModules.value;
	                objtrModuleBar.style.display='';
	             }   
	          
	            //lngHeight=parseInt(height-document.getElementById("iTabDetails").offsetTop- (objtrGM.offsetHeight+40))+"px";;
	            //document.getElementById("tree").style.height=lngHeight+"px";//200
	            document.getElementById("tree").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop - (objtrGM.offsetHeight+40))+"px";	  
	            
	            	  
	           //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight-120))+"px";	  
	           
	           
	           
	   }
	   else
	   {
	            objimgUpDown.src='../../Images/Sort_down.gif';
	            if(objhidTxtModules!=null && objtrModuleBar!=null)
	            {
	                 objtrModuleBar.style.display='none';
	             }  
	            
	            document.getElementById("tree").style.height=parseInt(height-document.getElementById("iTabDetails").offsetTop - (objtrGM.offsetHeight+40))+"px";	  
	            
	   }
	   
	} 
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
    
    function Tab_OnClick(strFromWhere)
	{
	    var subPage='../Home/Home.aspx?FromWhere='+strFromWhere;
	   // if(strFromWhere!='CRM')               
		    window.open("../General/Navigation.aspx?FromWhere="+strFromWhere,"_top")
		/*else
		    {
		      objform.action='../Home/Home.aspx?FromWhere=CRM';
              objform.submit();     
		    }    */
	}
	
function ShowPreviousFAV()
    {
    
        var objprevLeft=GetObjectReference('','prevLeft');
        
    if(GetObjectReference('frmKMHome','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmKMHome','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmKMHome','txtFAVPageNumber');
	}
	
	    if (isBlank(objtxtFAVPageNumber.value))
		    PageFAV_Onclick(1);
	    else
	    {
		     		
		    if (objtxtFAVPageNumber.value==1){if(objprevLeft!=null) objprevLeft.disbled=true; return; } //alert("This is the first favorites");return;}
		    
		    if(objprevLeft!=null) objprevLeft.disbled=false;
		    
			    objtxtFAVPageNumber.value=objtxtFAVPageNumber.value -1;

		    PageFAV_Onclick(objtxtFAVPageNumber.value);
	    }
		
    }	
	

 function ShowNextFAV()
    {
        var objprevRight=GetObjectReference('','prevRight');
        
    if(GetObjectReference('frmKMHome','txtNoOfFAV'))
	{	
			var noOfFAVs = GetObjectReference('frmKMHome','txtNoOfFAV').value;
			var objtxtFAVPageNumber =  GetObjectReference('frmKMHome','txtFAVPageNumber');
	}
	
	    if (isBlank(objtxtFAVPageNumber.value))
		    PageFAV_Onclick(1);
	    else
	    {  

		  
		    if (objtxtFAVPageNumber.value==parseInt(noOfFAVs)){objprevRight.disbled=true;return; }//alert("This is the last favorites");}		 
		    
		    objprevRight.disbled=false;
		    
		    objtxtFAVPageNumber.value=parseInt(objtxtFAVPageNumber.value) + 1;
    		
		    PageFAV_Onclick(objtxtFAVPageNumber.value);
    		 
	    }
   } 
   
   function PageFAV_Onclick(PageNumber)
		{
			//Added By purvaj on 14 Jul 2009 SEM 8.1 New UI favourites displayd on all the tabs now
			//var objhidTemplateID=GetObjectReference('','hidTemplateID'); 
			// End additon purvaj
			
		    var strURL = "../Home/Home_FloatingMenu.aspx?Mode=GoTo&IsXMLHttp=1&FromWhere=KM&TemplateID=KM";
		
		    if (navigator.appName=="Netscape") 
		        strURL=strURL+"&browserType=FireFox";
		    else
		        strURL=strURL+"&browserType=IE";
		    
		    loadXMLDoc(strURL,"PageNumber=" + String(parseInt(PageNumber)),"FAVTAB");
		
		}
		
		
function ShowFloatingmenu(Mode,ev)
   {
        var ObjSearch;
            
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
                
                if(strTagIDList.match(',8055,')!=null);
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
                
            objFrame.src='../Home/Home_FloatingMenu.aspx?Mode='+Mode+"&TagID=8055&TemplateID=KM";
            
            
            showmenuie('iFloatingMenu',ev);
            
       }
    showFloatingmenu='1';
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
    if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        e.stopPropagation();
   
  
   return false;
  
   }
   
   function TabItemOnClick(PageName,TagID,ControlItemID,ev)
	{
	
	  if('<%=m_strProjectID %>' == '0' && ev != null && TagID > 0 && TagID != 32 && TagID != 3936 && TagID != 5 && TagID != 10 && TagID != 1085 && TagID != 3707 && TagID != 1208)//&& "<%=m_strTemplateID %>"== 'PM'
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
            
	if(PageName.indexOf("javascript")>=0 )	
    {
        t= setTimeout(PageName,1);
    }
    else
    {
	     var objulExpenses,objul_Myedashboard,objul_edashboard,objul_MyRequests,objul_Inbox;
	     var TotalItems;
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
    	            
	         if (PageName.indexOf('MyExpenses')>=0)
	         {
	            document.getElementById("iTabDetails").src="../EWF/MyExpenseSheet_CommonList.aspx?FromWhere=DT&MasterTagId=3593";
	             //objhidPageURL.value=PageName;
	         }
	         else
	          {
	             document.getElementById("iTabDetails").src=PageName;
	             //objhidPageURL.value=PageName;
	          }  
	         //objhidtagid.value=TagID;
	         //objhidcontrolitemid.value=ControlItemID;
    	     
	         //if(objcboTheme!=null)
	         //   objcboTheme.value='';
    	        
	          //DrawFavImage();
    	  
	          //ShowHideViews();
	          if((TagID==5 || TagID==10) && ("<%=m_strTemplateID %>" != 'DB') && ("<%=m_strTemplateID %>" != 'CRM')) {
	             ObjTd = GetObjectReference('', 'tdTree');
	             ObjImg = GetObjectReference('', 'ImgShowHide');

	             if (ObjTd != null && ObjImg != null) {

	                 ObjTd.style.display = 'none';
	                 ObjImg.src = '../../Images/Home/RightMove.gif';

	             }

	         }
	    //Added by PrashantSJ on 24th June 2009

	    //  }
         }
       //Commented by PrashantSJ on 14th Aug 2009
       // calcHeight();    
       //End of comment by PrashantSJ n 14th Aug 2009
     }

     function DrawFavImage() {
         var objimgfav = GetObjectReference('frmHome', 'imgFav');
         if (objhidcontrolitemid.value != "" && objhidcontrolitemid.value != "0") {
             objimgfav.src = '../../Images/Home/favorites-.gif';
             objimgfav.title = 'Remove from favourites';
             //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"D")';
         }
         else {
             objimgfav.src = '../../Images/Home/fav+.gif';
             objimgfav.title = 'Add to favourites';
             //objimgfav.onclick=addRemoveFavorites;//(' +objhidtagid.value + ',"A")';
         }

     }
     function loadXMLDoc(url, reqQuery, forwhich) {
         // code for Mozilla, etc.
         if (window.XMLHttpRequest) {
             xmlhttp = new XMLHttpRequest()
             if (forwhich == "FAV")
                 xmlhttp.onreadystatechange = state_Change;
             else if (forwhich == "PAGEING")
                 xmlhttp.onreadystatechange = Page_state_Change;
             else if (forwhich == "FAVTAB")
                 xmlhttp.onreadystatechange = FAVTab_state_Change;
             if (ns) {
                 xmlhttp.open("GET", url + "&" + reqQuery, true)
                 xmlhttp.send(false)
             }

             else {
                 xmlhttp.open("POST", url, true)
                 xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                 xmlhttp.send(reqQuery)

             }
         }

             // code for IE
         else if (window.ActiveXObject) {
             xmlhttp = new ActiveXObject("Microsoft.XMLHTTP")
             if (xmlhttp) {
                 if (forwhich == "FAV")
                     xmlhttp.onreadystatechange = state_Change;
                 else if (forwhich == "PAGEING")
                     xmlhttp.onreadystatechange = Page_state_Change;
                 else if (forwhich == "FAVTAB")
                     xmlhttp.onreadystatechange = FAVTab_state_Change;

                 xmlhttp.open("POST", url, true)
                 xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                 xmlhttp.send(reqQuery)
             }
         }
     }

     function state_Change() {
         // if xmlhttp shows "loaded"
         if (xmlhttp.readyState == 4) {
             // if "OK"
             if (xmlhttp.status == 200) {

                 if (xmlhttp.responseText != "") { //objdivHeader.innerHTML=xmlhttp.responseText;
                     var objtdTabs = GetObjectReference('', 'tdTabs');

                     if (objtdTabs != null)
                         objtdTabs.innerHTML = xmlhttp.responseText;

                 }
             }
             else {
                 alert("Problem in transfering data:" + xmlhttp.statusText)
             }
         }
     }

     function Page_state_Change() {
         // if xmlhttp shows "loaded"
         if (xmlhttp.readyState == 4) {
             // if "OK"
             if (xmlhttp.status == 200) {
                 if (objdivTab != null) {
                     objdivTab.innerHTML = xmlhttp.responseText;


                     DrawFrameWithURL();
                 }
             }
             else {
                 alert("Problem in transfering data:" + xmlhttp.statusText)
             }
         }
     }

     function FAVTab_state_Change() {
         // if xmlhttp shows "loaded"
         if (xmlhttp.readyState == 4) {
             // if "OK"
             if (xmlhttp.status == 200) {

                 if (xmlhttp.responseText != "") {
                     var objtdTabs = GetObjectReference('', 'tdTabs');

                     if (objtdTabs != null)
                         objtdTabs.innerHTML = xmlhttp.responseText;
                 }


             }
             else {
                 alert("Problem in transfering data:" + xmlhttp.statusText)
             }
         }
     }


     function ModulesOnMouseOver(obj) {

         obj.className = 'clsTRMenuMouseOver';
     }
     function ModulesOnMouseOut(obj) {

         obj.className = 'clsTRMenu';
     }
    </script>


</body>
</html>


