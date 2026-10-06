<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_ActionProperties.aspx.vb" Inherits="Whiz.PB_ActionProperties" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_ActionProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<body onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout"
		class="clsBody">
		<form id="frmActionProperties" method="post" runat="server">
									<%PageInit()%>
								</form>
					<script language="javascript">
	//=================================================================================================================				
	//Added By	: Ninad
	//Purpose	: To show/Hide visibility setting combobox
	//Req. ID	: WAF3_PB_27
	//Date		: 27 July 2006
	//=================================================================================================================
	function ShowHideVisibility(comboDisplayPosition,comboVisibility)
	{   
	    var trVisibility = document.getElementById('tr' + comboVisibility);
	    var comboDisplayPosition = document.getElementById(comboDisplayPosition);
	     //IF Display position selected for UI then only show visibility combo  
		if (comboDisplayPosition.value.toUpperCase().indexOf('UI') == -1)
		{
			trVisibility.style.display="none";
		}
		else
		{
			trVisibility.style.display="";
		}
		var objShowInContextMenu = document.getElementById('ShowInContextMenu');
		var objTrShowInContextMenu = document.getElementById('trShowInContextMenu');
		if (objTrShowInContextMenu)
		{
		    if (comboDisplayPosition.value.toUpperCase().indexOf('GRID') == -1)
		    {
		        if (objShowInContextMenu) {objShowInContextMenu.disabled=true;}
		        objTrShowInContextMenu.style.display="none";
            }
		    else 
		    {
		        if (objShowInContextMenu) {objShowInContextMenu.disabled=false;}
		        objTrShowInContextMenu.style.display="";
            }
		}
	}
	//=================================================================================================================
	//End Addition By Ninad
	//=================================================================================================================
	var objdivlist;
	var objFrm;
	objFrm=GetFormReference('frmActionProperties');
	objdivlist=GetObjectReference('frmActionProperties','myDiv');
	function window_onresize()		
		{
			var x,b;
			var intDivHeight;
			var intDivHeightRisk;
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
			intDivHeight = 100;
				

	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';

		}
		var ActionID; //HotfixID - 2.0.10-SP7-WAF renamed and declared global
		var valLinkType; //HotfixID - 2.0.10-SP7-WAF renamed and declared global
		function window_onload()
		{
				var intDivHeight ;
				var intDivHeightRisk;
				var objLinkName;
				var objDisplayPosition;
				
			    if (GetObjectReference('frmActionProperties','hdActionID')==null) return; // Added By Ninad Req ID - WAF3_PB_48
				ActionID=GetObjectReference('frmActionProperties','hdActionID').value; 
				if (ActionID==0) 
				{
					objDisplayPosition=GetObjectReference('frmActionProperties','DisplayPosition')
					objDisplayPosition.selectedIndex=-1;
    				valLinkType=GetObjectReference('frmActionProperties','LinkType').value;
					if(valLinkType=='C')
					{
						expandcollapse('trCustomLink','');
					}
					else if(valLinkType=='D')
					{
						expandcollapse('trSpToExecute','');
						expandcollapse('trIdentifier','');
					}
				}
				else
				{
					valLinkType=GetObjectReference('frmActionProperties','hdLinkType').value;
					if (valLinkType=='Common Engine')
					{
						expandcollapse('trCustomLink','');
					}	
					else if(valLinkType=='Custom')
					{
						expandcollapse('trSpToExecute','');
						expandcollapse('trIdentifier','');
					}
					else if(valLinkType=='System')
					{
						expandcollapse('trSpToExecute','');
						expandcollapse('trIdentifier','');	
						expandcollapse('trCustomLink','');
					}			
				}
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;

		    //Comment added on 11 Dec 2015 by Viraj P
		    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';

				
				objLinkName=GetObjectReference('frmActionProperties','LinkName');
				objLinkName.focus();
		}
		
		
		function Save_OnClick(Operation)
		{
		
		//Added by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF 
	
		var objSPToExecute;
		
		if (ActionID==0) 
	    {
	        valLinkType=GetObjectReference('frmActionProperties','LinkType').value;
	        if(valLinkType=='C')
	        {
	            objSPToExecute= GetObjectReference('frmActionProperties','SpToExecute');
	            if (disallowBlank(objSPToExecute, "<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_SPTOEXECUTE")%>"))
	                return ;
	        }
	    }
	    
	       else
	       {
	        if (valLinkType=='Common Engine')
	        {
	            objSPToExecute= GetObjectReference('frmActionProperties','SpToExecute');
		        if (disallowBlank(objSPToExecute, "<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_SPTOEXECUTE")%>"))
		            return ;
		    }
		  
	    }
		//End Addition by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF
		var validateflag;
		validateflag=Validate_OnClick();
		var objLinkName = GetObjectReference('frmActionProperties','LinkName');
		var objImageURL= GetObjectReference('frmActionProperties','ImageURL');
		
		if (objLinkName.value == "" & objImageURL.value == "")
		{
			alert('Title or Virtual Path of Image is required');
			validateflag = false;
		}
		if( validateflag==true)
		{
			var objform;
			if (ActionID==0) 
			{
				var paramFromElement=GetObjectReference('frmActionProperties','paramFromElement');
				var paramTagID=GetObjectReference('frmActionProperties','paramTagID');
				var paramTitle=GetObjectReference('frmActionProperties','paramTitle');
				var paramSubTagID=GetObjectReference('frmActionProperties','paramSubTagID');
				
				
				if(paramFromElement.value=='Tag')
				{
					var objAction=GetObjectReference('frmGraphProperties','paramaction');
					objAction.value=Operation;	//Added By - Ninad : Req ID - WAF3_PB_48
					objform=GetFormReference('frmActionProperties')
					objform.action = "PB_ActionProperties.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&TITLE=" + paramTitle.value;
					EnableDisabledControls();
					objform.submit();
					if(Operation=='SAVE') //Added By - Ninad : Req ID - WAF3_PB_48
					    parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&DisplaySection=A";
				}
				else if(paramFromElement.value=='SubTag')
				{
					var objAction=GetObjectReference('frmGraphProperties','paramaction');
					objAction.value=Operation;	//Added By - Ninad : Req ID - WAF3_PB_48
					objform=GetFormReference('frmActionProperties')
					objform.action = "PB_ActionProperties.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&TITLE=" + paramTitle.value;
					EnableDisabledControls();
					objform.submit();
					if(Operation=='SAVE') //Added By - Ninad : Req ID - WAF3_PB_48
					    parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&DisplaySection=A";
				}
			}
			else
			{
				var paramFromElement=GetObjectReference('frmActionProperties','paramFromElement');
				var paramTagID=GetObjectReference('frmActionProperties','paramTagID');
				var paramTitle=GetObjectReference('frmActionProperties','paramTitle');
				var paramSubTagID=GetObjectReference('frmActionProperties','paramSubTagID');
				if(paramFromElement.value=='Tag')
				{
					var objAction=GetObjectReference('frmGraphProperties','paramaction');
					objAction.value=Operation;	//Added By - Ninad : Req ID - WAF3_PB_48
					objform=GetFormReference('frmActionProperties')
					objform.action = "PB_ActionProperties.aspx?ActionID=" + ActionID + "&FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&TITLE=" + paramTitle.value;
					EnableDisabledControls();
					objform.submit();
					if(Operation=='SAVE') //Added By - Ninad : Req ID - WAF3_PB_48
					    parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&TagID=" + paramTagID.value + "&DisplaySection=A";
				}
				else if(paramFromElement.value=='SubTag')
				{
					var objAction=GetObjectReference('frmGraphProperties','paramaction');
					objAction.value=Operation; //Added By - Ninad : Req ID - WAF3_PB_48
					objform=GetFormReference('frmActionProperties')
					objform.action = "PB_ActionProperties.aspx?ActionID=" + ActionID + "&FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&TITLE=" + paramTitle.value;
					EnableDisabledControls();
					objform.submit();
					if(Operation=='SAVE') //Added By - Ninad : Req ID - WAF3_PB_48
					    parent.frVerticalLeft.location.href="PB_InformativeSections.aspx?FromElement=" + paramFromElement.value + "&SubTagID=" + paramSubTagID.value + "&DisplaySection=A";
				}
				
			}
			//parent.frVerticalLeft.location.reload();
		}
	}
	
	function Close_OnClick()
	{
		parent.window.close(); 
	}
	
	function expandcollapse(trchildid,obj)
	{
		var coll=document.getElementsByName(trchildid);
		
		for(i=0;i<coll.length;i++)
		{
			var elementstyle=coll(i).style.display;
			if(elementstyle!='none')
			{	
				coll(i).style.display = 'none';
				if(obj!='')
				{
				obj.src="Img\\plus.gif";	
				obj.alt="Expand";
				}
			}
			else
			{
				coll(i).style.display = 'block';
				obj.src="Img\\minus.gif";
				obj.alt="Collapse";
			}
		}
	}
	
	function LinkTypesubmit()
	{
		objform=GetFormReference('frmActionProperties')
		var objSubmitFlag;
		objSubmitFlag=GetObjectReference('frmActionProperties','hdSubmitFlag');
		objSubmitFlag.value='False';
		objform.action = "PB_ActionProperties.aspx";
		objform.submit();
	}
	function EnableDisabledControls()
	{
		var objClientSideFunction = GetObjectReference('frmActionProperties', 'ClientSideFunctionName');
		if (objClientSideFunction != null && objClientSideFunction.disabled == true)
			objClientSideFunction.disabled = false;
	}
	//Added By NinadP :	15 Oct 2007 : Requirement Tag - WAF3_PB_53 
	function AvailableKeyboardShortcuts_OnClick(IsSubTag,TagID)
	{
	    window.open('../../Source/General/CommonList.aspx?FromWhere=SM&IsSubTag=' + IsSubTag + '&TagID=' + TagID + '&MasterTagID=1530'  , 'AvailableKeyboardShortcuts', 'width=500,height=430, location=no, menubar=no, status=no, toolbar=no, scrollbars=no, resizable=yes,left=' + (window.screen.width - 500)/2 + ',top=' + (window.screen.height - 430)/2);
	}
	//End Addition By NinadP :	15 Oct 2007 : Requirement Tag - WAF3_PB_53 

                    </script>
			
	</body>
</HTML>
