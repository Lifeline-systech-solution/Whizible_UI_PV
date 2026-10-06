<!-- Commented by Madhuri.K on 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%CommonFunctions.General.PlotPageHeadTag("")%>
<!-- End of Commented by Madhuri.K on 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
 
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page  Language="vb" AutoEventWireup="true" codebehind="WhizVisualProcessTree.aspx.vb" Inherits="PbNIT.WhizVisualProcessTree" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>
<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page--><html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quality Center</title>
    <link href="../General/StyleSheetChanakya_WhizP2007.css" rel="stylesheet" type="text/css" />    
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<link rel='stylesheet' type='text/css' href='../General/tab-view.css'/>     
    <script type='text/javascript' src="../General/CommonFunctions.js"></script>
    <script type='text/javascript' src="../General/CommonValidations.js"></script>
    <script type='text/javascript' src='../Home/homeTree.js'></script>    
<style type="text/css">  
	   TD.iMenu:hover
{
	padding-right: 3px;
	padding-left: 3px;
	padding-bottom: 3px;
	padding-top: 1px;
	border-right: black 0px solid;
	border-top: black 0px solid;
	font-weight: lighter;
	font-size: 10px;
	border-left: black 0px solid;
	color: black;
	border-bottom: black 0px solid;
	font-family: Verdana, Arial;
	background-color: #FFD695;
}
</style>    
    
    
<script id="Infragistics" type="text/javascript"> 

function ProcessTredd_EditKeyDown(treeId, nodeId, keyCode)
{
    
	//Add code to handle your event here.
	if(keyCode==1)
	{
        var node = igtree_getNodeById(nodeId);	    
        var dataKeyVal = node.getDataKey();
        strArr = dataKeyVal.split('|');
        var pk_value= dataKeyVal.substring(dataKeyVal.lastIndexOf("|")+1,dataKeyVal.length)  ;

        
        if(nodeId=="UltraWebTree1_1")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizQualityCenterHelp.aspx";
        }
        else if(strArr[1]=="T")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizTemplate.aspx?ACTION=MODIFY&PKID=0|TS&TemplateID_PK=" + pk_value ;        
        }
        else if(strArr[1]=="G")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizGuidelines.aspx?ACTION=MODIFY&PKID=0|GS&GuidelineID_PK=" + pk_value ;        
        }
        else if(strArr[1]=="TK")
        {
            parentActivtykey = nodeId.substring(0,nodeId.lastIndexOf("_"));
            parentActivty = igtree_getNodeById(parentActivtykey);
            parentActivtyvalue= parentActivty.getDataKey();
            strParentValue = parentActivtyvalue.split("|");
           window.open("WhizActivityTasks.aspx?Mode=MODIFY&ActivityID=" + strParentValue[2] + "&ActivityTaskID_PK=" + pk_value, "_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450)/2) + ",top=" + ((window.screen.height - 150)/2) + ",width=450,height=150");
        }
        else if(strArr[1]=="CS")
        {
		    window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcessDetails.aspx?PKID=" + dataKeyVal;
        }
        
        else if(strArr[1]=="C")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizCheckList.aspx?ACTION=MODIFY&PKID=0|CS&QuestionnaireID_PK=" + pk_value ;                
        }
        else if(strArr[1]=="MS")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcessDetails.aspx?PKID=" + dataKeyVal;
        }
        else if(strArr[1]=="M")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizMetrics.aspx?ACTION=MODIFY&PKID=0|MS&MetricID_PK=" + pk_value ;                
        }
        else if(strArr[1]=="PT")
        {
            //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="../General/CommonList.aspx?FromWhere=PRO&MasterTagId=1037";               
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcessDetails.aspx?PKID=0|PT"; 
        }
        else if(strArr[1]=="PTL")
        {
            //window.parent.frames['WhizVisualProcessGrid'].document.location.href ="../Process/PRO_ProjectTypeConfiguration.aspx?TypeID="+pk_value+"&MasterTagID=1037&FromWhere=PRO&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";                
             window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProjectType.aspx?ProjectTypeID="+pk_value;                
        }        
        else if(strArr[1]=="PCB")
        {
            window.parent.frames['WhizVisualProcessGrid'].document.location.href ="../General/CommonList.aspx?FromWhere=PRO&MasterTagId=1052" ;                
        }
        else if(strArr[1]=="PCBL")
        {
        window.parent.frames['WhizVisualProcessGrid'].document.location.href ="../Process/PRO_ComputePMI.aspx?PMIID="+pk_value+"&MasterTagID=1052&FromWhere=PRO&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
        }        
        
        else
        {
		    window.parent.frames['WhizVisualProcessGrid'].document.location.href ="WhizProcessDetails.aspx?PKID=" + dataKeyVal;
		}
	    //window.parent.frames['WhizVisualProcessGrid'].document.locati
	}
	/* Commented By NitinVS on 26 Dec 2006 Right click floating Menu to be implemented in next release
	if(keyCode == 2)
	{
        var node = igtree_getNodeById(nodeId);
        var strArr = new Array();
        strArr = node.getDataKey().split('|');
        var tree = igtree_getTreeById(treeId);

        switch(strArr[1])
        {
            
            case 'PS':
                igmenu_showMenu('mnuProcessMenu',tree.event);
                break;
            default :
                //igmenu_showMenu('mnuRootMenu', tree.event);
                break;
        }
		return true;
	}
	*/
}
/*
blnTreeHide=0;
		var blnTreeHide=0;
		
function showHide()
{

			  var img1;
			  var img2;
			  var img=GetObjectReference('frmTree','showHideTree');
			  img1='../../images/TreeOff.gif';
			  img2='../../images/TreeOn.gif';
			  var pf;
			  pf=GetParentFrameReference();
			  alert(blnTreeHide);
			  if(blnTreeHide==0)
			  {
				blnTreeHide=1
				//Commented by PrasannaP for Netscape Implementation on 31/5/2005
				//Issue ID 28888
				//pf['frmDown'].cols='0,*';
				//End Comment
				//Added by PrasannaP for Netscape Implementation on 31/5/2005
				//document.getElementById('frmTree').cols='0,*'
				//End addition
				img.src=img2;
				alert(img.src);
			 }
			  else
			  {
				blnTreeHide=0;
				var strcols;
				strcols='230' + ',*'
				//Commented by PrasannaP for Netscape Implementation on 31/5/2005
				//Issue ID 28888
				//pf['frmDown'].cols=strcols;
				//End Comment
				//Added by PrasannaP for Netscape Implementation on 31/5/2005
				//document.getElementById('frmTree').cols=strcols;	
				//End addition	
				img.src=img1;
			  }
}
*/
</script>

    
</head>
<body class="clsBody" onload="window_onload()" onresize="window_onload()">
    <form id="frmTree" runat="server">
   
                    <ignav:UltraWebTree ID="UltraWebTree1" runat="server" BackImageUrl="" Cursor="Default"
                        Indentation="20" JavaScriptFilename="" JavaScriptFileNameCommon="" WebTreeTarget="ClassicTree"
                        FileUrl="" Font-Names="Tahoma" Font-Size="8pt" LeafNodeImageUrl="" ParentNodeImageUrl=""
                        RootNodeImageUrl="" TargetFrame="" TargetUrl="" DataKeyOnClient="True" Height="99.9%" Width="200px"
                        CollapseImage="" DefaultIslandClass="" DefaultItemClass="" DisabledClass="" ExpandImage=""
                        HiliteClass="" HoverClass="" NodeEditClass="" BorderStyle="None"  BackColor="AliceBlue" ForeColor="Navy" ImageDirectory="../../images/p12/QC/">
                        <ClientSideEvents NodeClick="ProcessTredd_EditKeyDown" AfterBeginNodeEdit="" AfterEndNodeEdit="" 
                            AfterNodeSelectionChange="" AfterNodeUpdate="" BeforeBeginNodeEdit="" BeforeEndNodeEdit=""
                            BeforeNodeSelectionChange="" BeforeNodeUpdate="" DemandLoad="" Drag="" DragEnd=""
                            DragEnter="" DragLeave="" DragOver="" DragStart="" Drop="" EditKeyDown="" EditKeyUp="" KeyDown="" KeyUp="" NodeChecked="" NodeCollapse="" NodeExpand="" />
                        <NodeEditStyle Font-Names="Microsoft Sans Serif" Font-Size="9pt">
                        </NodeEditStyle>
                        <SelectedNodeStyle BackColor="Navy" BorderStyle="Solid" BorderWidth="1px" Cursor="Default"
                            ForeColor="White">
                            <Padding Bottom="1px" Left="2px" Right="2px" Top="1px" />
                        </SelectedNodeStyle>
                        <RootNodeStyle Font-Bold="True" Font-Names="Tahoma" Font-Size="8pt" />
                    </ignav:UltraWebTree>
                    &nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
                    <ignav:UltraWebMenu ID="mnuRootMenu" runat="server" Cursor="Default" JavaScriptFilename=""
                        JavaScriptFileNameCommon="" ScrollImageBottom="ig_menu_scrolldown.gif" ScrollImageBottomDisabled="ig_menu_scrolldown_disabled.gif"
                        ScrollImageTop="ig_menu_scrollup.gif" ScrollImageTopDisabled="ig_menu_scrollup_disabled.gif"
                        SubMenuImage="ig_menuTri.gif" BorderStyle="Solid" BorderWidth="1px" CompactRendering="False"
                        DisabledClass="" EnableViewState="False" EnhancedRendering="True" FileUrl=""
                        ItemPaddingSubMenus="0" ItemPaddingTop="0" ItemSpacingSubMenus="2" ItemSpacingTop="2"
                        LeafItemImageUrl="" ParentItemImageUrl="" TargetFrame="" TargetUrl="" TopAligment="Center"
                        TopItemSpacing="Compact" TopLevelItemImageUrl="" TopSelectedClass="" WebMenuStyle="XPClient"
                        WebMenuTarget="PopupMenu" CssClass="" DefaultImage="" DefaultIslandClass="" DefaultItemClass=""
                        HoverClass="" SeparatorClass="" XSLFile="">
                        <HoverItemStyle BackColor="LightSteelBlue" Cursor="Default" ForeColor="White" BorderColor="RoyalBlue"
                            BorderStyle="Solid" BorderWidth="1px">
                            <Margin Bottom="0px" Left="0px" Right="0px" Top="0px" />
                        </HoverItemStyle>
                        <IslandStyle BackColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px" Cursor="Default"
                            BorderColor="Black" Font-Names="MS Sans Serif" Font-Size="8pt" ForeColor="Black">
                        </IslandStyle>
                        <Levels>
                            <ignav:Level Index="0" />
                            <ignav:Level Index="1" />
                        </Levels>
                        <DisabledStyle Font-Names="MS Sans Serif" Font-Size="8pt" ForeColor="LightGray">
                        </DisabledStyle>
                        <ItemStyle Font-Names="MS Sans Serif" Font-Size="9pt" ForeColor="Black" BorderWidth="0px"
                            Width="100%">
                            <Margin Bottom="1px" Left="1px" Right="1px" Top="1px" />
                        </ItemStyle>
                        <SeparatorStyle BackgroundImage="ig_menuSep.gif" CssClass="SeparatorClass" CustomRules="background-repeat:repeat-x; " />
                        <ExpandEffects ShadowColor="LightGray" Opacity="80" Type="Slide" />
                        <MenuClientSideEvents InitializeMenu="" ItemChecked="" ItemClick="" ItemHover=""
                            SubMenuDisplay="" />
                        <Items>
                            <ignav:Item AccessKey="" Text="Add">
                                <Items>
                                    <ignav:Item AccessKey="" Text="Activity">
                                    </ignav:Item>
                                </Items>
                            </ignav:Item>
                        </Items>
                    </ignav:UltraWebMenu>
                    <ignav:UltraWebMenu ID="mnuProcessMenu" runat="server" Cursor="Default" JavaScriptFilename=""
                        JavaScriptFileNameCommon="" ScrollImageBottom="ig_menu_scrolldown.gif" ScrollImageBottomDisabled="ig_menu_scrolldown_disabled.gif"
                        ScrollImageTop="ig_menu_scrollup.gif" ScrollImageTopDisabled="ig_menu_scrollup_disabled.gif"
                        SubMenuImage="ig_menuTri.gif" BorderStyle="Solid" BorderWidth="1px" CompactRendering="False"
                        DisabledClass="" EnableViewState="False" EnhancedRendering="True" FileUrl=""
                        ItemPaddingSubMenus="0" ItemPaddingTop="0" ItemSpacingSubMenus="2" ItemSpacingTop="2"
                        LeafItemImageUrl="" ParentItemImageUrl="" TargetFrame="" TargetUrl="" TopAligment="Center"
                        TopItemSpacing="Compact" TopLevelItemImageUrl="" TopSelectedClass="" WebMenuStyle="XPClient"
                        WebMenuTarget="PopupMenu">
                        <HoverItemStyle BackColor="LightSteelBlue" Cursor="Default" ForeColor="White" BorderColor="RoyalBlue"
                            BorderStyle="Solid" BorderWidth="1px">
                            <Margin Bottom="0px" Left="0px" Right="0px" Top="0px" />
                        </HoverItemStyle>
                        <IslandStyle BackColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px" Cursor="Default"
                            BorderColor="Black" Font-Names="MS Sans Serif" Font-Size="8pt" ForeColor="Black">
                        </IslandStyle>
                        <Levels>
                            <ignav:Level Index="0" />
                            <ignav:Level Index="1" />
                        </Levels>
                        <DisabledStyle Font-Names="MS Sans Serif" Font-Size="8pt" ForeColor="LightGray">
                        </DisabledStyle>
                        <ItemStyle Font-Names="MS Sans Serif" Font-Size="9pt" ForeColor="Black" BorderWidth="0px"
                            Width="100%">
                            <Margin Bottom="1px" Left="1px" Right="1px" Top="1px" />
                        </ItemStyle>
                        <SeparatorStyle BackgroundImage="ig_menuSep.gif" CssClass="SeparatorClass" CustomRules="background-repeat:repeat-x; " />
                        <ExpandEffects ShadowColor="LightGray" Opacity="80" Type="Slide" />
                        <TopSelectedStyle BackColor="SteelBlue" BorderColor="#0000C0" BorderStyle="Solid"
                            BorderWidth="1px">
                            <Margin Bottom="0px" Left="0px" Right="0px" Top="0px" />
                        </TopSelectedStyle>
                        <MenuClientSideEvents InitializeMenu="" ItemChecked="" ItemClick="" ItemHover=""
                            SubMenuDisplay="" />
                        <Items>
                            <ignav:Item Text="Add">
                                <Items>
                                    <ignav:Item AccessKey="" Text="Activity">
                                    </ignav:Item>
                                </Items>
                            </ignav:Item>
                            <ignav:Item Text="Modify">
                            </ignav:Item>
                            <ignav:Item Text="Delete">
                            </ignav:Item>
                        </Items>
                        <TopSelectedStyle BackColor="SteelBlue" BorderColor="#0000C0" BorderStyle="Solid"
                            BorderWidth="1px">
                            <Margin Bottom="0px" Left="0px" Right="0px" Top="0px" />
                        </TopSelectedStyle>
                    </ignav:UltraWebMenu>
        
        <% Response.Write(GetModules())%>
    </form>
</body>
<script type="text/javascript" language="javascript">

   var objfrm;
   var objdivlist;
   objfrm = GetFormReference('frmTree');
   objdivlist=GetObjectReference('frmTree','T_UltraWebTree1');
   var objtrGM=GetObjectReference('','trGM');
   /*objimg= document.getElementById('ImageshowHide');
   objspan= document.getElementById('showHideTree');*/

	function window_onload()
	{
	    
		var intDivHeight ;
		var intDivWidth;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = window.frameElement.offsetHeight - objdivlist.offsetTop ;
		intDivWidth = window.frameElement.offsetWidth; 
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop;
		intDivWidth = window.innerwidth;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
			
		objdivlist.style.overflow='auto';
		//objdivlist.style.height = intDivHeight	;
            objdivlist.style.height =parseInt(intDivHeight-document.getElementById("frmTree").offsetTop-(objtrGM.offsetHeight+65))+"px";	  		
        // document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+65))+"px";
		//objspan.style.left= intDivWidth;
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
	
	function ShowHideModules(shrink)
	{
	    var objimgUpDown=GetObjectReference('','imgUpDown');
	    var objTRModules=GetObjectReference('','trModules',true);
	    var objhidTxtModules=GetObjectReference('','hidTxtModules');
	    var objtdModuleBar=GetObjectReference('','tdModuleBar');
	    var objtrModuleBar=GetObjectReference('','trModuleBar');
	    
	    var IsShrink=false;
	    
	    //obj.className='clsTDScroll';
	    
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
    
    if (shrink == null)
    {
        IsShrink=false;
    }
    
	   if(IsShrink)
	   {
	            objimgUpDown.src='../../Images/Sort_up.gif';
	            if(objhidTxtModules!=null && objtrModuleBar!=null)
	            {
	                objtdModuleBar.innerHTML=objhidTxtModules.value;
	                objtrModuleBar.style.display='';
	             }   
	                
	            //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop-110)+"px";	  
	            objdivlist.style.height =parseInt(intDivHeight-document.getElementById("frmTree").offsetTop-(objtrGM.offsetHeight-110))+"px";	  		
	           //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight-120))+"px";	  
	   }
	   else
	   {
	            objimgUpDown.src='../../Images/Sort_down.gif';
	            if(objhidTxtModules!=null && objtrModuleBar!=null)
	            {
	                 objtrModuleBar.style.display='none';
	             }   
	                
	            //document.getElementById("divTree").style.height=parseInt(height-document.getElementById("frmMain").offsetTop - (objtrGM.offsetHeight+65))+"px";	 
	            objdivlist.style.height =parseInt(intDivHeight-document.getElementById("frmTree").offsetTop-(objtrGM.offsetHeight+65))+"px";	  		 
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
    function ModulesOnMouseOver(obj)
	{
	    
	    obj.className='clsTRMenuMouseOver';
	}
	function ModulesOnMouseOut(obj)
	{
	    
	    obj.className='clsTRMenu';
	}
</script>

</html>
