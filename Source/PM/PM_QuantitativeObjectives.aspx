<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_QuantitativeObjectives.aspx.vb" Inherits="PbNIT.PM_QuantitativeObjectives" validateRequest="false"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
    <%CommonFunctions.General.PlotPageHeadTag("")%>

    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    
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



	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmQuantativeObjectives" method="post" runat="server">
			<%WritePage%>
		</form>
		<script language="javascript">
// =============================== Common To all Mode=====================//
var objForm, objdivlist, objForFocus;
	
objForm = GetFormReference('frmQuantativeObjectives');
            //Added By Bharat T on 15th-Oct-2015
           objdivlist = GetObjectReference('frmQuantativeObjectives','divList');
            if(objdivlist==null)
            objdivlist = GetObjectReference('frmQuantativeObjectives','DivList');
		    //Commented and Added By Bharat T on 15th-Oct-2015
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
		
	function window_onload()
	{
	  //  debugger;
	 	var intDivHeight ;
	 	 
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
			    intDivHeight = window.innerHeight  - objdivlist.offsetTop - 30 ;
		    }
		    else
		    {
			   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight  - objdivlist.offsetTop - 30 ;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
	    //Commented and added by Yogesh J on 11/12/2015
	    //objdivlist.style.height = intDivHeight;	
		objdivlist.style.height = intDivHeight + 'px';	
	}
	
	function window_onresize()		
	{
	   
		var intDivHeight;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight = window.innerHeight  - objdivlist.offsetTop - 38 ;
		    }
		    else
		    {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight  - objdivlist.offsetTop - 38 ;
			   
		    }
		
		if (intDivHeight < 100)	intDivHeight = 100;
	    //Commented and added by Yogesh J on 11/12/2015
	    //objdivlist.style.height = intDivHeight;	
		objdivlist.style.height = intDivHeight + 'px';		
	}
// =============================== Common To all Mode =====================//
<%If m_strMode = MODE_LIST Then%>
// =============================== Specific To List Mode =====================//
	objForFocus = GetObjectReference('frmQuantativeObjectives','txtObjective');
	setFocus(objForFocus);

	function SaveRevision_OnClick()
	{
		//alert('Functionality to be implemented.');
		var strData, objAction;
		if(ValidateNorms() == true)
		{
			/*strData = window.showModalDialog("PM_QuantitativeObjectives.aspx?Mode=<%=MODE_SHOW_REVISION%>", "_new", "dialogWidth:600px;dialogHeight:240px");
			//alert(strData);
			objAction = GetObjectReference('frmQuantativeObjectives','txthidAction');
			objAction.value = "<%=ACTION_SAVE%>";
			objForm.action = "PM_QuantitativeObjectives.aspx?Mode=<%=MODE_LIST%>&MasterTagId=<%=m_lngTagId%>&Data=" + strData;
			objForm.submit();*/
			window.open("PM_QuantitativeObjectives.aspx?Mode=<%=MODE_SHOW_REVISION%>", "_new", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 220)/2 + ",width=600,height=220");
		}
	}
	
	/*The following function is used only because the the window is not opened Modal to accept the Revision Comments*/
	function Render(strData)
	{
		var objAction, objData;
		
		//alert(strData);
		objAction = GetObjectReference('frmQuantativeObjectives','txthidAction');
		objData = GetObjectReference('frmQuantativeObjectives','txthidData');
		objData.value = strData;	
		objAction.value = "<%=ACTION_SAVE%>";
		objForm.action = "PM_QuantitativeObjectives.aspx?Mode=<%=MODE_LIST%>&MasterTagId=<%=m_lngTagId%>";
		objForm.submit();
	}
	
	function Save_OnClick()
	{
		var objAction, objObjectives;
		
		objObjectives = GetObjectReference('frmQuantativeObjectives','txtObjective');
		if(objObjectives != null)
		{
			if(disallowMaxlengthViolation(objObjectives, 2000, "<%=MyBase.GetResourceString("LENGTH_OF_OBJECTIVE")%>"))
				return;
		}
		
		if(ValidateNorms() == true)
		{
			objAction = GetObjectReference('frmQuantativeObjectives','txthidAction');
			objAction.value = "<%=ACTION_SAVE%>";
			objForm.action = "PM_QuantitativeObjectives.aspx?Mode=<%=MODE_LIST%>&MasterTagId=<%=m_lngTagId%>";
			objForm.submit();
		}
	}
	
	function ValidateNorms()
	{
		var objNorms, objRowCount, intCnt;
		
		objRowCount = GetObjectReference('frmQuantativeObjectives','txthidRowCount');
		if(objRowCount.value > 0)
		{
			for(intCnt=1; intCnt <= objRowCount.value; intCnt++)
			{
				objNorms = GetObjectReference('frmQuantativeObjectives','txtNorms' + intCnt);
				if(objNorms != null)
				{
					if(disallowNonNumeric(objNorms, "<%=MyBase.GetResourceString("ONLY_NUMBERS_ALLOED")%>"))
						return false;
						 //Addtion By PrachiK on 22 Feb 2005 for Issue ID. 16260
						//Purpose: For a particular Metric , Enter a value as '+96' in the field 'Target set for this project',The page crashes.
					/*var str=objNorms.value;	
					var pos=str.indexOf("+")
					if (pos>=0)
					{
					alert('Please enter only Numeric values.');
					return false;
					}*/
					//Addtion ended

				}
			}
		}
		return true;
	}
// =============================== Specific To List Mode =====================//
<%ElseIf m_strMode = MODE_SHOW_REVISION Then%>
// =============================== Specific To Show Revision Mode =====================//
	objForFocus = GetObjectReference('frmQuantativeObjectives','txtRevision');
	setFocus(objForFocus);

	function Save_OnClick()
	{
		var objRevision;
		objRevision = GetObjectReference('frmQuantativeObjectives','txtRevision');
		if(disallowMaxlengthViolation(objRevision, 1000, "<%=MyBase.GetResourceString("LENGTH_OF_REVISION")%>"))
			return;
			
		//window.returnValue = objRevision.value;
		window.opener.Render(objRevision.value);
		window.close();
	}
// =============================== Specific To Show Revision Mode =====================//
<%End If%>

function AddNew_OnClick()
{
    //Added By Nilesh g on 2/1/2016 for url issue
    //window.open("PM_QuantitativeObjectives.aspx?Mode=<%=CONST_MODE_ADDMETRIC%>&MasterTagId=<%=m_lngTagId%>,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-450)/2 + ",width=650,height=450");		
    window.open("PM_QuantitativeObjectives.aspx?Mode=<%=CONST_MODE_ADDMETRIC%>&MasterTagId=<%=m_lngTagId%>&PKtoken=<%=m_PKToken%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-450)/2 + ",width=650,height=450");		
}
function SaveMetric_OnClick()
{
	var objChk,objAction;
	var intLen=0;
	var blnSelected=false;
	
	objChk = GetObjectReference('frmQuantativeObjectives','chkSelect',true);
	intLen = objChk.length;
	
	if(intLen>0)
	{
		for(i=0;i<intLen;i++)
			if(objChk[i].checked==true)
			{
				blnSelected=true;
				break;
			}
	}
	
	if(blnSelected==true)
	{
		objAction = GetObjectReference('frmQuantativeObjectives','txthidAction');
		objAction.value = "<%=CONST_ACTION_ADD%>";
	    objForm.action = "PM_QuantitativeObjectives.aspx?Mode=<%=CONST_MODE_ADDMETRIC%>&MasterTagId=<%=m_lngTagId%>&PKtoken=<%=m_PKToken%>";
		objForm.submit();
	}
	else
	{
		alert('<%=MyBase.GetResourceString("MSG_METRIC_NOT_SELECTED")%>');
	}
}
	</script>
	</body>
</HTML>
