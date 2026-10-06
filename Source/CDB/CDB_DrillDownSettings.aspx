<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_DrillDownSettings.aspx.vb" Inherits="Whiz.CDB_DrillDownSettings" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Drill Down Settings")%>

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)" style="overflow:auto"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmDrillDownSettings" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'frmDrillDownSettings';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objchkSelect;
	var objchkShowDrillDown;
	var TotalRows=0;
	objform = GetFormReference('frmDrillDownSettings');
	objdivlist = GetObjectReference('frmDrillDownSettings','DivList');
	objchkSelect = GetObjectReference('frmDrillDownSettings','chkSelect',true);
	objchkShowDrillDown = GetObjectReference('frmDrillDownSettings','chkShowDrillDowns');
	TotalRows = "<%=m_intTotalRows%>";
	
	function ClearAll_OnClick()
	{
	    var LoopCtr;
	    var ObjchkEnableAttributeSorting=GetObjectReference('frmDrillDownSettings','chkEnableAttributeSorting',true);
        if (TotalRows != 0)
		{   if(TotalRows == 1)
			{
				objchkSelect[0].checked = false;
				if(objchkShowDrillDown){objchkShowDrillDown.checked=false;}
			}
			else
			{
				for (LoopCtr = 0;LoopCtr < TotalRows;LoopCtr++)
				{
				    objchkSelect[LoopCtr].checked=false;
				    ObjchkEnableAttributeSorting[LoopCtr].checked=false;
                }
			}
        }
        if(objchkShowDrillDown){objchkShowDrillDown.checked=false;}
	}
	function SelectAll_OnClick()
	{
		var LoopCtr;			
		if (TotalRows == 0){alert("There are no attributes to select");return;}	
		else if(TotalRows == 1)
		{
			objchkSelect[0].checked = true;				
		}
		else
		{
			for (LoopCtr = 0;LoopCtr < TotalRows;LoopCtr++)
			    {objchkSelect[LoopCtr].checked=true;}
		}
		if(objchkShowDrillDown){objchkShowDrillDown.checked=true;}
	}
	function validate()
	{
        /*
        Modified by SandeepA on 11 Aug,2005 For
        For Requirement Tag:WAF2_CDB_1
        For the Validation of Checkboxes.
        If the EnableAttributeSorting checkbox is checked 
        then corresponding Select checkbox should also be checked.
        */	  
	   var ObjfrmDrillDownSettings=GetFormReference('frmDrillDownSettings');
	   var ObjchkEnableAttributeSorting=GetObjectReference('frmDrillDownSettings','chkEnableAttributeSorting',true);
	   var LoopCtr;
	   var Count;
	  
       if (TotalRows != 0)
       {  
           if (TotalRows>1)
           {
	           Count=ObjchkEnableAttributeSorting.length;// Get the length of the Array
	           for(LoopCtr=0;LoopCtr<Count;LoopCtr++)
	             if(ObjchkEnableAttributeSorting[LoopCtr].checked==true )
	 	            if(objchkSelect[LoopCtr].checked==false)
	 	            // If EnableAttributeSorting Col is Checked and Corresponding Select Col is not Checked then 
	 	            // display meassge.
	                {
	                  alert("To enable sorting the corresponding attribute should be selected ");
	                  return false;
	                 }
		          /*End of Modifications For Requirement Tag:WAF2_CDB_1*/
            }
            else
            {
	             if(ObjchkEnableAttributeSorting[0].checked==true && objchkSelect[0].checked==false)
	 	            // If EnableAttributeSorting Col is Checked and Corresponding Select Col is not Checked then 
	 	            // display meassge.
	                {
	                  alert("To enable sorting the corresponding attribute should be selected ");
	                  return false;
	                 }
		          /*End of Modifications For Requirement Tag:WAF2_CDB_1*/
            }
        }		  
		var objGraphHeight = GetObjectReference('frmDrillDownSettings','txtGraphHeight');
		if (disallowBlank(objGraphHeight,"'Graph Height' cannot be blank") == true) {return false;}
    	if (disallowNonInteger(objGraphHeight,"Please enter integer value for 'Graph Height'") == true) {return false;}
    	if (disallowNegativeInteger(objGraphHeight,"Please enter positive integer value for 'Graph Height'") == true) {return false;}
        if (disallowMinValueViolation(objGraphHeight,100,"Please enter value greater than 100 for 'Graph Height'") == true) {return false;}
        
		var objGraphWidth = GetObjectReference('frmDrillDownSettings','txtGraphWidth');
		if (disallowBlank(objGraphWidth,"'Graph Width' cannot be blank") == true) {return false;}
        if (disallowNegativeInteger(objGraphWidth,"Please enter positive integer value for 'Graph Width'") == true) {return false;}
        if (disallowMinValueViolation(objGraphWidth,100,"Please enter value greater than 100 for 'Graph Width'") == true) {return false;}

		return true;
	}
		
	function Back_OnClick()
	{
		if(ShowNavigationAlert()==false) return;    //Added By Ninad WAF3_PB_64	
		var graphid;
		graphid = <%=m_intGraphID%>;
		if (graphid!=1)
		{
			window.location.href = "CDB_GraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>";
		}
		else
		{
			window.location.href =  "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
		}
	}
	
	function Next_OnClick()
	{
		if (validate())
		{
			blnNavigate = false;    //Added By Ninad WAF3_PB_64					
			objform.action = "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=NEXT&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>&GraphID=<%=m_intGraphID%>";
			objform.submit();
		}
	}
	
	function Save_OnClick()
	{
		if (validate())
		{
			objform.action = "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>&GraphID=<%=m_intGraphID%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64			
			objform.submit();
			 
		}
	}	
	function ChainLink_OnClick(pos)
	{
		if(ShowNavigationAlert()==false) return;    //Added By Ninad WAF3_PB_64		
		var graphid;
		graphid = <%=m_intGraphID%>;
		if (graphid==1)
		{
			switch(true)
			{
			case (pos==1):
				window.location.href =  "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==2):
				window.location.href =  "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==3):
				window.location.href =  "CDB_ItemAlert.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			default:
				break;
			}
		}
		else
		{
			switch(true)
			{
			case (pos==1):
				window.location.href =  "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==2):
				window.location.href =  "CDB_GraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==3):
				window.location.href =  "CDB_DrillDownSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			case (pos==4):
				window.location.href =  "CDB_AdvancedGraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>";
				break;
			default:
				break;
			}
		}
	}
	
	//Added 03-Oct-2005 RajK R.No#WAF3_CDB_7
	function Attribute_OnClick(AttributeName)
	{
		window.open("../CDB/CDB_DrillDown_LevelSettings.aspx?ItemID=<%=m_lngItemID%>&DashboardID=<%=m_lngDashboardID%>&FromWhere=<%=m_strFromWhere%>&Attribute=" + AttributeName , "_DrillDownLevelSettings", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height - 250)/2) + ",width=750,height=250") ; //WAF3_PB_42 April 17, 2007 NinadP
	}
	//End addition 03-Oct-2005 RajK R.No#WAF3_CDB_7
	
	function window_onload()
	{
        //commented added by Shamkant S on 30 Nov 2015
	    var intDivHeight;
	    if (objdivlist !=null) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
	        if (navigator.appName == 'Netscape') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 180;
	        }

	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';
	        
	       
	    }
        //Ened by Shamkant S on 30 Nov 2015
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		if ("<%=m_intReresh%>" == "1")
		{
			refreshParent('frmItemList', 'CDB_ItemList.aspx','CDB_ItemList.aspx?FromWhere=<%=m_strFromWhere%>&DashboardID=<%=m_lngDashboardID%>');
		}
	}
	<% 'WAF3_PB_42 April 16, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 16, 2007 END%>

    function chkSelect_OnClick()
	{	
	    if (objchkSelect !=null && objchkShowDrillDown !=null)
	    {
            var intSelectLength=0;var intCnt=0;
	        var blnIsSelected = false;
	        if (TotalRows>=2)
	        {
	            intSelectLength = objchkSelect.length;
	            for (intCnt=0;intCnt<intSelectLength;intCnt++)
		        {
			        if (objchkSelect[intCnt].checked == true)
			        {blnIsSelected=true; break;}
		        }
            }
            else{blnIsSelected=objchkSelect[0].checked;}
		    objchkShowDrillDown.checked=blnIsSelected;
	    }
	}
</script>



 <script type="text/javascript">
    $(document).ready(function(){

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-DDB -> CDB_DrillDownSettings
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/
        if($('.clsGridTable').length > 0)
        {
            var divName=$('#DivList').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Application Administration >Query >Builder
        /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/
});

$(window).resize(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Table Inner Menu on Window Resize
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
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
});
 </script>


