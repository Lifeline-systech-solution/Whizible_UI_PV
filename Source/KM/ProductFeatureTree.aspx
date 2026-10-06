<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProductFeatureTree.aspx.vb" Inherits="PbNIT.ProductFeatureTree" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Product Feature Tree")%>
<%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

 <script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class=clsTreeBody>
<form id=FeatureTree name=FeatureTree action=ProductFeatureTree.aspx method=post>
			<% DrawPage() %>
			<script src="../KM/PRDTree.js" type=text/javascript></script>

<div id=tree>
				<%DrawTreeVariables()%>
			</DIV></FORM>
<script>
		if(window.parent.parent.frames[0].window.blnTreeHide==0)
		window.parent.parent.frames[0].window.hideshowtree();
		
			//createTree(Tree);
			//OpenAllNodes();
		//oc(6,0);
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
		
	function txtIndex_OnKeyPress(e)
	{	
		var code;
		var intCounter;
		var strSearchText;
		var objList =GetObjectReference('FeatureTree','lstFeatureList')
		var objIndex =GetObjectReference('FeatureTree','txtIndex')

		if (e.keyCode) code = e.keyCode;
		else if (e.which) code = e.which;
		if( code!=13) 
				{
					strSearchText=objIndex.value;
					
					for(intCounter=1;intCounter<=<%=mintmax%>;intCounter++)
					{
					  if (objList.options[intCounter].text.toUpperCase().indexOf(strSearchText.toUpperCase()) == 0)
					  {
							objList.selectedIndex = intCounter;
							//objList.focus();
							//lstFeatureList_OnDblClick();
							//window.event.returnValue = false;
							break;
					  } 
					}
				
				}
		if( code==13)
		{
			var targetWindow = window.parent.document.getElementById('PRDPage');
			var objList =GetObjectReference('FeatureTree','lstFeatureList')
			window.event.returnValue = false;
			if(objList.selectedIndex>0)
			targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;

		
		}		
	}

  function txtSearch_OnKeyPress(e)
	{	
		var code;
		var intCounter;
		var strSearchText;
		var objList =GetObjectReference('FeatureTree','lstFeatureList')
		var objIndex =GetObjectReference('FeatureTree','txtIndex')

		if (e.keyCode) code = e.keyCode;
		else if (e.which) code = e.which;
		if(code==13 ) 
				{
					var objChk =GetObjectReference('FeatureTree','chkTech')
					var TechVal;
					if(objChk.checked==true)
					TechVal="1";
					else
						TechVal="0"

					var objText =GetObjectReference('FeatureTree','txtSearch')
					window.event.returnValue = false;
					var targetWindow = window.parent.document.getElementById('PRDTree') ;
					targetWindow.src = "ProductFeatureTree.aspx?HelpFromWhere=Search&SearchText=" + objText.value  + "&Tech=" + TechVal ;

				}
	}
	
	

		
function lstFeatureList_OnDblClick()
{
var targetWindow = window.parent.document.getElementById('PRDPage');
var objList =GetObjectReference('FeatureTree','lstFeatureList')
if(objList.selectedIndex>0)
targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;


}
function ListTopic_OnClick()
{
var objText =GetObjectReference('FeatureTree','txtSearch')
var objChk =GetObjectReference('FeatureTree','chkTech')
var TechVal;
if(objChk.checked==true)
   TechVal="1";
 else
	TechVal="0"

var targetWindow = window.parent.document.getElementById('PRDTree') ;
		targetWindow.src = "ProductFeatureTree.aspx?HelpFromWhere=Search&SearchText=" + objText.value  + "&Tech=" + TechVal ;

}

function DisplayFav_OnClick()
{
var targetWindow = window.parent.document.getElementById('PRDPage');
var objList =GetObjectReference('FeatureTree','lstFavoriteList')
if(objList.selectedIndex>-1)
targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;

}
function Display_OnClick()
{
var targetWindow = window.parent.document.getElementById('PRDPage');
var objList =GetObjectReference('FeatureTree','lstSearchFeatureList')
if(objList.selectedIndex>-1)
targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;


}

function lstFavoriteList_OnDblClick()
{
var targetWindow = window.parent.document.getElementById('PRDPage');
var objList =GetObjectReference('FeatureTree','lstFavoriteList')
if(objList.selectedIndex>-1)
targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;


}

function AddFav_OnClick()
{
	var targetWindow = window.parent.document.getElementById('PRDTree') ;
	targetWindow.src = "ProductFeatureTree.aspx?HelpFromWhere=Favorites&Mode=Add" ;

}

function Remove_OnClick()
{
	var targetWindow = window.parent.document.getElementById('PRDTree') ;
	var objList =GetObjectReference('FeatureTree','lstFavoriteList')
	if(objList.selectedIndex>-1)
	targetWindow.src = "ProductFeatureTree.aspx?HelpFromWhere=Favorites&Mode=Remove&RemoveFeatureID=" + objList[objList.selectedIndex].value;
	
}


function lstSearchFeatureList_OnDblClick()
{
var targetWindow = window.parent.document.getElementById('PRDPage');
var objList =GetObjectReference('FeatureTree','lstSearchFeatureList')
if(objList.selectedIndex>-1)
targetWindow.src = "DisplayFeatureDetails.aspx?FeatureId=" + objList[objList.selectedIndex].value;


}

	function Tab_OnClick(strFromWhere)
	{
		//window.open("ProductFeature.aspx?HelpFromWhere=" + strFromWhere,"_top")
		var targetWindow = window.parent.document.getElementById('PRDTree') ;
		targetWindow.src = "ProductFeatureTree.aspx?HelpFromWhere=" + strFromWhere;

		
	}
		function Page_Onclick(PageChar)
		{
			var objfrm = GetFormReference('RMTree');
			objfrm.action = "ProductFeatureTree.aspx?PagingChar="+PageChar;
			objfrm.submit();
		}
		function addRequirement_onClick()
		{
		
			var targetWindow = window.parent.document.getElementById('RMPage') ;
			
			var objLnkReq = window.parent.frames[1].document.getElementById('LnkReq');
			var objLnkDet = window.parent.frames[1].document.getElementById('LnkDet'); 
			var objLnkImp = window.parent.frames[1].document.getElementById('LnkImp'); 
			var objLnkDoc = window.parent.frames[1].document.getElementById('LnkDoc');  

			objLnkReq.className = 'clsNavTab';
			objLnkDet.className = 'clsNavTab';
			objLnkImp.className = 'clsNavTab';
			objLnkDoc.className = 'clsNavTab';
			
			//window.parent.frames[1].document.getElementById('reqCaption').innerHTML="Requirement:	 &nbsp;";  
			window.parent.frames[1].window.disableAllLinks();
			
			
			
			//
		}
		</script>

	</body>
</HTML>

