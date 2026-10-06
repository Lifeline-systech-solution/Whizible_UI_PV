<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_GraphSettings.aspx.vb" Inherits="Whiz.CDB_GraphSettings" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Graph Settings")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


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


	<body style="overflow:auto" class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmGraphSettings" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>		
	var objform;
	var objdivlist;
	var objcboBorderStyle;
	var objcboBorderColor;
	var objcboChartBackColor;
	var objcboChartAreaColor;
	var objcboCaptionColor;
	var objcboTitleColor;
	var objtxtUCL;
	var objcboUCLColor;
	var objtxtLCL;
	var objcboLCLColor;
	var objcboPieLabelStyle;
	var objchkShowLegends;
	var objchkShowExplodedPie;
	var objtxtXAxisMin;
	var objtxtXAxisMax;
	var objtxtXAxisInterval;
	
	objform = GetFormReference('frmGraphSettings');
	objdivlist = GetObjectReference('frmGraphSettings','DivList');
	objcboBorderStyle = GetObjectReference('frmGraphSettings','cboBorderStyle');
	objcboBorderColor = GetObjectReference('frmGraphSettings','cboBorderColor');
	objcboChartBackColor = GetObjectReference('frmGraphSettings','cboChartBackColor');
	objcboChartAreaColor = GetObjectReference('frmGraphSettings','cboChartAreaColor');
	objcboCaptionColor = GetObjectReference('frmGraphSettings','cboCaptionColor');
	objcboTitleColor = GetObjectReference('frmGraphSettings','cboTitleColor');
	objtxtUCL = GetObjectReference('frmGraphSettings','txtUCL'); //Modified By Ninad on 17 Aug 2007 Issue ID - 2614
	objcboUCLColor = GetObjectReference('frmGraphSettings','cboUCLColor');
	objtxtLCL = GetObjectReference('frmGraphSettings','txtLCL');
	objcboLCLColor = GetObjectReference('frmGraphSettings','cboLCLColor');
	objcboPieLabelStyle = GetObjectReference('frmGraphSettings','cboPieLabelStyle');
	objchkShowLegends = GetObjectReference('frmGraphSettings','chkShowLegends');
	objchkShowExplodedPie = GetObjectReference('frmGraphSettings','chkShowExplodedPie');
	objtxtXAxisMin = GetObjectReference('frmGraphSettings','txtXAxisMin');
	objtxtXAxisMax = GetObjectReference('frmGraphSettings','txtXAxisMax');
	objtxtXAxisInterval = GetObjectReference('frmGraphSettings','txtXAxisInterval');
	
	function SetGraphSkin()
	{
	    var iHeight=400,iWidth=600;	    
	    var sURL='../CDB/GraphSkins_CommonList.aspx?MasterTagID=1799&ParentTagID=0&From=<%=m_strFromWhere%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>';
	    var sFeatures='resizable=yes,scrollbars=no,top='+((window.screen.height - iHeight)/2) + ',left=' + ((window.screen.width - iWidth)/2) + ',width='+iWidth+',height='+iHeight;
	    window.open(sURL,'_Skin',sFeatures);	    
	}
	
	function validate()
	{
		var graphid;
		graphid = <%=m_intGraphID%>;
		if (disallowBlank(objcboBorderStyle,"Please select the border style")) return false;
		if (disallowBlank(objcboBorderColor,"Please select the border color")) return false;
		if (disallowBlank(objcboTitleColor,"Please select the graph title color")) return false;
		if (disallowBlank(objcboChartBackColor,"Please select the graph background color")) return false;
		if (disallowBlank(objcboChartAreaColor,"Please select the graph area color")) return false;
		if (disallowBlank(objcboCaptionColor,"Please select the caption color")) return false;
		//Added By Ninad on 17 Aug 2007 Issue ID - 2614
		if (graphid !=2 && graphid !=7)
		{
		    if (disallowNonNumeric(objtxtUCL,"Please enter a numeric value")) return false;
		    if (disallowNonNumeric(objtxtLCL,"Please enter a numeric value")) return false;
		    if (objtxtLCL.value!='' && objtxtUCL.value!='')
		    {
		        if (disallowValue1EqualToValue2(objtxtLCL,objtxtUCL,"The 'LCL' value and 'UCL' value cannot be same",true)) return false;
			    if (disallowMaxValueViolation(objtxtLCL,objtxtUCL.value,"The 'LCL' value cannot be greater than 'UCL' value",true)) return false;
		    }
        }	
		//End Addition By Ninad on 17 Aug 2007 Issue ID - 2614
		if (graphid == 2)
		{
			if (disallowBlank(objcboPieLabelStyle,"Please select the pie label style")) return false;
		}
		if (graphid !=2 && graphid !=7)
		{
			if (disallowBlank(objtxtXAxisMin,"",false)==false) 
			{
				if (disallowNonNumeric(objtxtXAxisMin,"Please enter a numeric value")) return false;
			}
			if (disallowBlank(objtxtXAxisMax,"",false)==false) 
			{
				if (disallowNonNumeric(objtxtXAxisMax,"Please enter a numeric value")) return false;
			}
			if (disallowBlank(objtxtXAxisInterval,"",false)==false) 
			{
				if (disallowNonNumeric(objtxtXAxisInterval,"Please enter a numeric value")) return false;
			}
			if (disallowBlank(objtxtXAxisMin,"",false)==false && disallowBlank(objtxtXAxisMax,"",false)==false) 
			{
				if (disallowMaxValueViolation(objtxtXAxisMin,objtxtXAxisMax.value,"The minimum value cannot be greater than maximum value",true)) return false;
				// added  June 03,2005 RajK, HotFix# 1.0.1-SP2-WAF
				if (disallowValue1EqualToValue2(objtxtXAxisMin,objtxtXAxisMax,"The minimum and maximum axes values cannot be same",true)) return false;
				// end addition June 03,2005 RajK, HotFix# 1.0.1-SP2-WAF
			}
			if (disallowBlank(objtxtXAxisInterval,"",false)==false && disallowBlank(objtxtXAxisMin,"",false)==false) 
			{
				if (disallowMinValueViolation(objtxtXAxisInterval,objtxtXAxisMin.value,"The interval cannot be less than the minimum value",true)) return false;
			}
			if (disallowBlank(objtxtXAxisInterval,"",false)==false && disallowBlank(objtxtXAxisMax,"",false)==false) 
			{
				if (disallowMaxValueViolation(objtxtXAxisInterval,objtxtXAxisMax.value,"The interval cannot be greater than the maximum value",true)) return false;
			}
		}
		//Added By PusharK for WAF3_CDB_25
		if (graphid != 1 && graphid !=12)
		{
		    var objtxtChartAreaWidth = GetObjectReference('frmGraphSettings','txtChartAreaWidth');
		    if (disallowNonInteger(objtxtChartAreaWidth,"Please enter integer value.",true)) return false;
		    if (disallowNegativeNumeric(objtxtChartAreaWidth,"Please enter positive integer.",true)) return false;
		    if (disallowValueRangeViolation(objtxtChartAreaWidth,70,100,"The value of 'Chart Area Width' should be in the range of (70-100).",true)) return false;
		    var objcboLegendStyle = GetObjectReference('frmGraphSettings','cboLegendStyle');
		    if (objcboLegendStyle){objcboLegendStyle.disabled=false;}
		}//Addition Ends By PusharK for WAF3_CDB_25
		return true;
	}
	
	//Added By PusharK for WAF3_CDB_25
	function ShowLegend_Click()
	{
		 var objcboLegendStyle = GetObjectReference('frmGraphSettings','cboLegendStyle');
		 var objchkShowLegends = GetObjectReference('frmGraphSettings','chkShowLegends');
		 if (objcboLegendStyle){objcboLegendStyle.disabled= !objchkShowLegends.checked;}
	}
	//Addition Ends By PusharK for WAF3_CDB_25
	
	function Next_OnClick()
	{
		if (validate())
		{
			blnNavigate = false;    //Added By Ninad WAF3_PB_64					
			objform.action = "CDB_GraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=NEXT&Mode=<%=m_strMode%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>";
			objform.submit();
		}
	}
	function Back_OnClick()
	{
		if(ShowNavigationAlert()==false) return;    //Added By Ninad WAF3_PB_64		
		window.location.href = "CDB_ItemDetail.aspx?FromWhere=<%=m_strFromWhere%>&Mode=EDIT&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>";
	}
	
	function Save_OnClick()
	{
		if (validate())
		{
			objform.action = "CDB_GraphSettings.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&Mode=<%=m_strMode%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemID%>";
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
	function window_onload()
	{
	    //Commentd added by Shamkant S on 30 Nov 2015
	    var intDivHeight;
	    if (objdivlist !=null) {
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 50;
	        if (navigator.appName == 'Netscape') {
	            intDivHeight = window.innerHeight - objdivlist.offsetTop - 140;
	        }

	        if (intDivHeight < 100) intDivHeight = 100;
	        objdivlist.style.height = intDivHeight + 'px';
	       
	    }
        //commentd Ended by Shamkant S on 30 nov 2015
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		if ("<%=m_intReresh%>" == "1")
		{
			refreshParent('frmItemList', 'CDB_ItemList.aspx','CDB_ItemList.aspx?FromWhere=<%=m_strFromWhere%>&DashboardID=<%=m_lngDashboardID%>');
		}
	}
	
	<% 'WAF3_PB_42 April 16, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 16, 2007 END%>
        </script>
	</body>
</HTML>
