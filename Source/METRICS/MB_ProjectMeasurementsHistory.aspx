<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MB_ProjectMeasurementsHistory.aspx.vb" Inherits="PbNIT.MB_ProjectMeasurementsHistory"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Project Measurement History")%>
	<%MyBase.InitializeResources("AppResourcePPM.MB_ProjectMeasurementsHistory", "AppResourcePPM")%>

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


	<body MS_POSITIONING="GridLayout" class='clsBody'  onload='CL_window_onload()'>
		<form id="Form1" method="post" >
			<%Initialize()%>
		</form>
	</body>
	<script>
	
var objfrm;
   var objdivlist;
   objfrm = GetFormReference('Form1')
  // objdivlist=GetObjectReference('Form1','PageDiv')

   objdivlist=GetObjectReference('Form1','PageDiv')

window.status='';//window resize for Common list


	function CL_window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)
				intDivHeight = 100;
			
	    //Commented and added by Yogesh J on 11/12/2015
	    //objdivlist.style.height = intDivHeight ;
			objdivlist.style.height = intDivHeight + 'px';
		}
		//window onload for Common list
		function CL_window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var lc;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			if (intDivHeight < 100)
				intDivHeight = 100;
	
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight ;
			objdivlist.style.height = intDivHeight + 'px';
		}
		
		/*
	function CL_window_onresize()
	{
		var intDivHeight ;
		var intDivHeightRisk;
		var intDivListPageHeight ;
		//if (objdivlistPage != null) {
		intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 10;
		if (intDivHeight < 100)
			intDivHeight = 100;//}
				
		//objdivlistPage.style.height = intDivHeight	;}
		if (objdivlist != null) {
		intDivListPageHeight = intDivHeight - 5 ;
		objdivlist.style.height = intDivListPageHeight;}
	}
	//window onload for Common list
	function CL_window_onload()
	{
		var intDivHeight ;
		var intDivListPageHeight ;
		var intDivHeightRisk;
		var lc;
		//if (objdivlistPage != null) {
		intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - 10;
		alert(intDivHeight);
		if (intDivHeight < 100)
			intDivHeight = 100;//}
		//objdivlistPage.style.height = intDivHeight;}
		if (objdivlist != null) {
		intDivListPageHeight = intDivHeight;
		objdivlist.style.height = intDivListPageHeight;}
	}

*/
		
		//Function for Editmode .Is called on click of projectName
		function Project_OnClick(strProjectID,strSnapShotDate)
		{
			//Form1.document.location.href ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&Mode=EDIT&UniqueID=" + strProjectID +"&SnapShotDate=" + strSnapShotDate
			Form1.document.location.href ="../METRICS/ProjectDataPoint_EntrySheet.aspx?MasterTagID=2518&FromWhere=PM&SnapShotDate=" + strSnapShotDate
			
		}
	
	   //Function for Sorting	
		function Sort_OnClick(strSortBy,strSortOrder)
		{
			Form1.document.location.href ="../METRICS/MB_ProjectMeasurementsHistory.aspx?SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&Action=Grid"
		}
		//Function for ADD_NEW Mode
		function Add_Clk()
		{
		var objList;
		//window.open("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&UniqueID=5&CboChange=TRUE&Mode=ADD_NEW&FromWhere=UPDATEMETRIC",1,0,1)
		//Form1.document.location.href ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&Mode=ADD_NEW"		
		if(<%=intIsDateGreaterthanToday%>=='0')
		{
		   
		    alert('<%=MyBase.GetResourceString("FUTURE_DATE_ENTRIES_ALERT")%>');
		    return;
		}
		
        objList= GetObjectReference('Form1','txtFreq')
        if(objList.value=='' || objList.value=='0')
        {
            alert('Please first set Metric Generation Frequency');
            return;
        }
		
			Form1.document.location.href ="../Metrics/ProjectDataPoint_EntrySheet.aspx?Action=ADD&Mode=ADD_NEW";
		
		}
		//Function for BackOnClick i.e. Redirect to CL Page
		function Back_OnClick()
		{
		//window.open("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&UniqueID=65&CboChange=TRUE&Mode=ADD_NEW&FromWhere=UPDATEMETRIC",1,0,1)
		Form1.document.location.href ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Grid"
		}
		//Project Combo OnChnage
		function Project_OnChange(ChangedValue)
		{
		Form1.action ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&UniqueID=" + ChangedValue.value + "&CboChange=TRUE&Mode=ADD_NEW";
		Form1.submit();
		}
		//Function for Saving the Data
		function Save_OnClick()
		{
		 var cboProjectName=GetObjectReference('Form1','cboProjectName');
		 var txtTextControls=GetObjectReference('Form1','txtTextControls');
		 var dtDateControl=GetObjectReference('Form1','txtDate');
		 var strArray=new Array();
		 var length;
		 var blnResult;
		 var Counter;
		 var ObjTextControl;
	     
	     //EnableDate Control.
	     dtDateControl.disabled = false;
	     	     
	     // TextBox Validations on CommonPage.	
		 strArray=txtTextControls.value.split(",");
      	 length=strArray.length; 
		 		 	 
		for(Counter=0;Counter<length-1;Counter++)
		{
		       
		        ObjTextControl=GetObjectReference('Form1',strArray[Counter]);
		         
		         if(ObjTextControl.value=='')
		         {
		         alert('Value cannot be Blank.');
		         ObjTextControl.focus();
		         ObjTextControl.value=0;
		         return;
		         }
		         
		       	blnResult=disallowNonNumeric(ObjTextControl,'Only numeric values are allowed !',true);
				if(blnResult==true)
				   return;
		}
		 
		 if(cboProjectName.value==0)
		 {
		    alert("Project Name is mandatory ");
		    return;
		 }
		 
		 for(Counter=0;Counter<length-1;Counter++)
		{
		        ObjTextControl=GetObjectReference('Form1',strArray[Counter]);
		        ObjTextControl.disabled=false;
		}
		 
		 Form1.action ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Save";
		 Form1.submit();
		}			
		//Filters disabled as of now
		function Filter(txtFilter)
		{
		}
		//Practice Combo Change
//		function cboPracticeChange(cboPractice)
//		{
//		 var objcboPractice=GetObjectReference('Form1','cboPractice');
//		 Form1.action="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Grid&Practice=PracticeChange&cboPractice=" + objcboPractice.value;
//		 Form1.submit();
//		}
		//Project Combo Change
//		function cboProjectChange(cboProject)
//		{
//		 var objcboProject=GetObjectReference('Form1','cboProject');
//		 var objcboPractice=GetObjectReference('Form1','cboPractice');
//		 Form1.action="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Grid&Project=ProjectChange&cboProject=" + objcboProject.value +"&cboPractice=" + objcboPractice.value;
//		 Form1.submit();
//		} 
	
		//Help for TagID-2130
		function Help()
		{
		 OpenHelpPage(2130);
		} 
		//Saving the data i.e UPDATE
		function Save_UpdateMetric_OnClick()
		{
		 var cboProjectName=GetObjectReference('Form1','cboProjectName');
		 var txtTextControls=GetObjectReference('Form1','txtTextControls');
		 var dtDateControl=GetObjectReference('Form1','txtDate');
		 var strArray=new Array();
		 var length;
		 var blnResult;
		 var Counter;
		 var ObjTextControl;
		 var strParentPage;
		 
		 //get parent window href. (location address)
		 strParentPage = new String();
		 strParentPage = opener.location.href;
		
	     //Enable Date Control and Project Combo Box
	      dtDateControl.disabled = false;
	      cboProjectName.disabled = false;	     
	     // TextBox Validations on CommonPage.	
		 strArray=txtTextControls.value.split(",");
      	 length=strArray.length; 
		 
		 	 
		for(Counter=0;Counter<length-1;Counter++)
		{
		        ObjTextControl=GetObjectReference('Form1',strArray[Counter]);
		       	blnResult=disallowNonNumeric(ObjTextControl,'Only numeric values are allowed !',true);
				if(blnResult==true)
				   return;
		}
		 
		 if(cboProjectName.value==0)
		 {
		    alert("Project Name is mandatory ");
		    return;
		 }
		 Form1.action ="../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=Save";
		 Form1.submit();
		 
		 //opener.parent.location.reload();
		 refreshParent("Form1","MB_MetricCommonList.aspx",strParentPage,true)
		 
		}
		
		//Close window on click of 'Close'
		function Close_OnClick()
		{
		  window.close();
		}
		
	</script>
</HTML>
