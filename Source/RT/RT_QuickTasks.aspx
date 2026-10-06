<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
      /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
        table
        {
            width:100% !important;
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_QuickTasks.aspx.vb" Inherits="PbNIT.RT_QuickTasks"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>		
		<%CommonFunctions.General.PlotPageHeadTag("Plan Task")%>
		<body class="clsBody" onresize="window_onresize()"  onload="window_onload()" MS_POSITIONING="GridLayout">
		<STYLE type="text/css"> .FixedTD { POSITION: relative; TOP:expression(document.getElementById('divTblGrid').scrollTop -1 ); }
		</Style>
		<form id="frmRT_QuickTasks" method="post" runat="server">
    		<%PageInit%>
			<div id=divTbl style="WIDTH: 50px;height:150px;DISPLAY:none;">
			<table id='tbl_popup' class='clsTable' width=99.99% cellspacing=0 style="border-top:thin solid gray;border-bottom:thin solid gray;border-left:thin solid gray;border-right:thin solid gray;">
			<tr class='clsTRColumnHeader'>
			<th colspan=2>Quick Task</th>
			</tr>
			</table>
			</div>
		</form> 
	  
<SCRIPT language="javascript">
var objform=GetFormReference('frmRT_QuickTasks');
var objDivMain=GetObjectReference('frmRT_QuickTasks','PageDiv');
var objDivTab=GetObjectReference('frmRT_QuickTasks','divTblGrid');
var objTaskSDt,objTaskEDt,objTaskHrs,objBalenceWork;			
var objTbl=GetObjectReference('frmRT_QuickTasks','QTasks');
var Project = new Array();
var TaskType = new Array();
var arrTT_ST = new Array();
var ReqSDeta=[];
var ReqD=[];
var ReqSubTaskDeta=[];
var objDivpopup;
var isClickImagePopup;
var strMessageDisplayed=0;
var QuickTaskTotalWork=0; 

<%' Added By SonalD on 13th Jan 2009 %>
<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
<%End If%>
<%' Added By SonalD on 13th Jan 2009 %>

var objTbl = GetObjectReference('','QTasks');          
var objQTaskCounter=GetObjectReference('','RowNumber');
var noOfRows; var LastRowNumber; LastRowNumber=-1; var isInValid = 0;

if (objQTaskCounter!=null)
    noOfRows=parseInt(objQTaskCounter.value)-1;
else
    noOfRows=0;
	
NewTR1 = objTbl.insertRow(objTbl.rows.length);
NewTR1.className = 'clsTRBlank';
NewTD1 = NewTR1.insertCell(0);
NewTD1.align='left';
NewTD1.innerHTML = "<td width=10px ALIGN='center' colspan='6'><A href='javascript:ShowHide_SectionTR()'><Img Border=0 id=tdShowHide Src='../../Images/right.gif' title='Click here to add new record'></A></td>";	
NewTD1 = NewTR1.insertCell(1);
NewTD1 = NewTR1.insertCell(2);
NewTD1 = NewTR1.insertCell(3);
NewTD1 = NewTR1.insertCell(4);
NewTD1 = NewTR1.insertCell(5);
NewTD1 = NewTR1.insertCell(6);

function ShowHide_SectionTR()
{
    createNewRow();            
}
function deleteRow(evt)
{
    objTbl.deleteRow(evt.parentNode.parentNode.rowIndex);
}

function DeleteThisTask(SelectedTaskID)
{
    //Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader    
    setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
    //End Of Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
   objform.action = "../RT/RT_QuickTasks.aspx?DeleteMode=DELETETHISTASK&SelectedTaskID="+SelectedTaskID;
   objform.submit(); 
}

function createNewRow()
{
    noOfRows = noOfRows+1;
  
    var strcombohtml;
    var NewTR,newTD;

    NewTR = objTbl.insertRow(objTbl.rows.length-1);
    NewTR.className = 'clsTREven';	
    NewTD = NewTR.insertCell(0);
    NewTD.align='left';
    NewTD.innerHTML = "<td > <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'deleteRow(this)'></td>";	

    //Project       
    NewTD = NewTR.insertCell(1);
    NewTD.align='left';	 
   	strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("ProjectID", "usp_Sel_ListOfProject_QuickTask 0", 150, "", "onchange=javascript:Project_Change", True, True, , True, , , 1).ToString.Replace("'","\'") %>'
    strcombohtml = strcombohtml.replace(/ProjectID/g,"ProjectID_" + noOfRows);
    strcombohtml = strcombohtml.replace(/Project_Change/g,"Project_Change(" + noOfRows+")");
    NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
	FillProjectDropdown(noOfRows);
	 
    //Task Name/Description
    NewTD = NewTR.insertCell(2);
    NewTD.align='left';
    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("Description", "Description", , 300, 255, , , , , , , , , True, , , , , 1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>'
    strcombohtml = strcombohtml.replace(/Description/g,"Description_" + noOfRows)
    NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	
    //Task Type
    NewTD = NewTR.insertCell(3);
    NewTD.align='left';
    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("TaskTypeID", "Usp_Sel_TaskType_QuickTask 0", 150, "", "onchange=Task_Change", True, True, ,True , , , 1).ToString.Replace("'","\'") %>'
    strcombohtml = strcombohtml.replace(/TaskTypeID/g,"TaskTypeID_" + noOfRows)
    strcombohtml = strcombohtml.replace(/Task_Change/g,"Task_Change(" + noOfRows+ ")");
    NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';

    //Sub Task Type
    NewTD = NewTR.insertCell(4);
    NewTD.align='left';
    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("SubTaskTypeID", "usp_Sel_SubTasks 0,0", 100, "", , True, True, , , , , 1).ToString.Replace("'","\'") %>'
    strcombohtml = strcombohtml.replace(/SubTaskTypeID/g,"SubTaskTypeID_" + noOfRows)
    NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
   
     //Priority
    NewTD = NewTR.insertCell(5);
    NewTD.align='left';
    strcombohtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("Priority", "usp_Sel_tbl_IB_Priorities", 90, "", , True, True, ,True , , , 1).ToString.Replace("'","\'") %>'
    strcombohtml = strcombohtml.replace(/Priority/g,"Priority_" + noOfRows)
    NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
     
    //Actual Work Hrs  
    NewTD = NewTR.insertCell(6);
    strcombohtml = ''        
    NewTD.align='right';
    strcombohtml = strcombohtml + '<%=CommonFunctions.HTMLControls.DrawTextBox("Work_" , "Work_", , 50, 20, , "Right", , , , , , , True, , , , , 1).ToString.Replace("'","\'") %>'
    strcombohtml = strcombohtml.replace(/Work_/g,"Work_" + noOfRows)
	NewTD.innerHTML = '<td>'+ strcombohtml + '</td>';
	   
    
    LastRowNumber = noOfRows;
}

function FillProjectDropdown(RowNumber)
{
	var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber);		
	var frmDate = GetObjectReference('frmRT_QuickTasks','Today');
	if(frmDate!=null)
	{
	   frmDate = frmDate.value; 
	}
	else
	{
	    frmDate = "";
	}
	if (objProjectID!=null)
	{
		objProjectID.length = 0;
		objProjectID.appendChild(AddOption('',''));
	}
		
	var xmlHttp;
	var strUrl;
	try	{   xmlHttp=new XMLHttpRequest();   }
	catch (e)
	{    // Internet Explorer  
	    try	{  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");  }
		catch (e)
		{      
	        try   { xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
		    catch (e)  {  alert("Your browser does not support AJAX!");   return false; }      
		}    
	}  
    xmlHttp.onreadystatechange=function()
    {
        if(xmlHttp.readyState==4)
        {
            if (xmlHttp.status==200)
            {
                var str = xmlHttp.responseText;
                ReqSDeta=str.split("|");
                if (str=='NO_ACCESS')
                {
                    alert("You have no access to create task for '"+objProjectID[objProjectID.selectedIndex].text+"' project.");
                    objProjectID.value='';
                    objProjectID.focus();
                }
                else   { InitialiseProject(RowNumber);  }
            }
       }
    }
			
	strUrl = new String();	
	strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&Action=Project&ProjectID="+objProjectID.value + "&RowNumber=" + RowNumber + "&Today=" + frmDate;		
	xmlHttp.open("GET",strUrl,true);
	xmlHttp.send(null);
}

function InitialiseProject(RowNumber)
{
	var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber);
	var j, i =0;
	var strProjectName;
	//Added to reinitialise an array
	Project.length = 0;
	
	for(j=0;j<ReqSDeta.length-2;j=j+2)
	{
		Project[i] = new Array(2);
		Project[i][0] = ReqSDeta[j];
		
		strProjectName = ReqSDeta[j+1]; 
		Project[i][1] = strProjectName;
		i=i+1;
    }     

	i=0;		
	objProjectID.length = 0;
	objProjectID.appendChild(AddOption('',''));
	for(i=0;i<Project.length;i++)
	{
		objProjectID.appendChild(AddOption(Project[i][0],Project[i][1]));	
	}
}

function Project_Change(RowNumber)
{
	var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber);
	var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber);
	var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID_'+RowNumber);
		
	if ((objTaskTypeID!=null)&&(objSubTaskTypeID!=null))
	{
		objTaskTypeID.length = 0;
		objTaskTypeID.appendChild(AddOption('',''));
		objSubTaskTypeID.length = 0;
		objSubTaskTypeID.appendChild(AddOption('',''));
	}
	if (objProjectID.value=='')	return;
		
	var xmlHttp;
	var strUrl;
	try	{   xmlHttp=new XMLHttpRequest();   }
	catch (e)
	{    // Internet Explorer  
	    try	{  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");  }
		catch (e)
		{      
	        try   { xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
		    catch (e)  {  alert("Your browser does not support AJAX!");   return false; }      
		}    
	}  
    xmlHttp.onreadystatechange=function()
    {
        if(xmlHttp.readyState==4)
        {
            if (xmlHttp.status==200)
            {
                var str = xmlHttp.responseText;
                ReqSDeta=str.split("|");
                if (str=='NO_ACCESS')
                {
                    alert("You have no access to create task for '"+objProjectID[objProjectID.selectedIndex].text+"' project.");
                    objProjectID.value='';
                    objProjectID.focus();
                }
                else   { InitialiseTaskType(RowNumber);  }
            }
       }
    }
			
	strUrl = new String();	
	strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&ProjectID="+objProjectID.value + "&RowNumber=" + RowNumber;	
	xmlHttp.open("GET",strUrl,true);
	xmlHttp.send(null);
}

function InitialiseTaskType(RowNumber)
{
	var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber);
	var j, i =0;
	var strTaskType;
	//Added to reinitialise an array
	TaskType.length = 0;
	
	for(j=0;j<ReqSDeta.length-2;j=j+2)
	{
		TaskType[i] = new Array(2);
		TaskType[i][0] = ReqSDeta[j];
		
		strTaskType = ReqSDeta[j+1]; 
		TaskType[i][1] = strTaskType;
		i=i+1;
    }     
	        
    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber); 
    var objTaskName = GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber); 
	var lngSelectedOUPool,lngSelectedProgram, intProjectID = objProjectID[objProjectID.selectedIndex].value;
	
	if(objTaskTypeID==null) return;
	
	if (intProjectID>0)
	{
		i=0;
		ngSelectedOUPool = objTaskTypeID[objTaskTypeID.selectedIndex].value;
		objTaskTypeID.length = 0;
		objTaskTypeID.appendChild(AddOption('',''));
		for(i=0;i<TaskType.length;i++)
		{
			objTaskTypeID.appendChild(AddOption(TaskType[i][0],TaskType[i][1]));
			if(objTaskTypeID.style.display!='none') 
			        objTaskName.focus();
			if(TaskType[i][1] == lngSelectedOUPool){
				objTaskTypeID.selectedIndex = objTaskTypeID.length - 1; }
		}
	}
	else
	{
		objTaskTypeID.length = 0;
		objTaskTypeID.appendChild(AddOption('',''));
	}	
}

function Task_Change(RowNumber)
{
    var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber);
    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber);
    var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID_'+RowNumber); 
    var selected = objTaskTypeID.value;
    var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;

    ///To Reinitialize Task Array
    var xmlHttp;
    var strUrl;
    try { xmlHttp=new XMLHttpRequest();  }
    catch (e)
    {    // Internet Explorer  
        try {  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP"); }
        catch (e)
        {      
            try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e){  alert("Your browser does not support AJAX!");  return false;    }      
        }    
    }  
    xmlHttp.onreadystatechange=function()
    {
        if(xmlHttp.readyState==4)
        {
            if (xmlHttp.status==200)
            {
                var str = xmlHttp.responseText;
                ReqSubTaskDeta=str.split("|");
                InitializeSubTaskType(RowNumber);
            }
        }
    }
    strUrl = new String();
    strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&Action=TaskType&ProjectID="+objProjectID.value;

    xmlHttp.open("GET",strUrl,true);
    xmlHttp.send(null)	
    ///End of Reinitialize Task Array
}

function InitializeSubTaskType(RowNumber)
{
    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber);
    var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID_'+RowNumber); 
    var selected = objTaskTypeID.value;
    var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;

    //Added to reinitialise an array
    arrTT_ST.length=0;
    i=0;
    for(j=0;j<ReqSubTaskDeta.length-3;j=j+3)
    {
        arrTT_ST[i] = new Array(3);
        arrTT_ST[i][0] = ReqSubTaskDeta[j];
        arrTT_ST[i][1] = ReqSubTaskDeta[j+1]
        strTaskType = ReqSubTaskDeta[j+2]; 
        arrTT_ST[i][2] = strTaskType;
        i=i+1;
    }     

    if(objTaskTypeID==null || objSubTaskTypeID == null ) return;
    if(intTTID > 0)
    { 
        i = 0;
        lngSelectedOUPool = objSubTaskTypeID[objSubTaskTypeID.selectedIndex].value;
        objSubTaskTypeID.length = 0;
        objSubTaskTypeID.appendChild(AddOption('',''));
        for(i=0; i < arrTT_ST.length;i++)
        {
            if(intTTID == arrTT_ST[i][0])
            {
                objSubTaskTypeID.appendChild(AddOption(arrTT_ST[i][1],arrTT_ST[i][2]));
                if(objSubTaskTypeID.style.display!='none') 
                    objSubTaskTypeID.focus();
                if(arrTT_ST[i][1] == lngSelectedOUPool)
                {
                    objSubTaskTypeID.selectedIndex = objSubTaskTypeID.length - 1;
                }
            }
        }
    }
    else
    {
    objSubTaskTypeID.length = 0;
    objSubTaskTypeID.appendChild(AddOption('',''));
    }
}

function Validation(RowNumber)
{   
    if (GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber) != null)
    {         
         //Project Validation   
        if(GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber).value=='')
        {            
            isInValid = 1;
            alert('Please select Project.'); 
            GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber).focus();
            return;
        }
       //Description       
        var ObjTaskDescription = GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber);
        
        if(ObjTaskDescription!=null)
        {
            var TaskDescription = ObjTaskDescription.value;
          
            if(trimString(TaskDescription)== "")
            {
                isInValid = 1;
                alert('\'Task / Description\' can not left blank.'); 
                ObjTaskDescription.value = "";
                ObjTaskDescription.focus();
                return;
            }
        }     
        
        if((GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber).value).length > 200)
        {
            isInValid = 1;
            alert('Max length for Description is 200.'); 
            GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber).focus();
            return;
        }
       
        //TaskType Validation
        if(GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber).value=='')
        {
            isInValid = 1;
            alert('Please select Task Type.'); 
            GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber).focus();
            return;
        }
       
        //Priority Validation
        if(GetObjectReference('frmRT_QuickTasks','Priority_'+RowNumber).value=='')
        {
            isInValid = 1;
            alert('Please select Priority.'); 
            GetObjectReference('frmRT_QuickTasks','Priority_'+RowNumber).focus();
            return;
        }
        
        var objWork = GetObjectReference('frmRT_QuickTasks','Work_'+RowNumber);
        if(objWork.value!='')
        {
            if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true)) { isInValid = 1; return; }

            dblTotalWork = objWork.value;
            if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
            {
                isInValid = 1;
                strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
                alert(strMsg);
                setFocus(objWork);
                return;
            }
            if( ( parseFloat(objWork.value) < 0 )||( parseFloat(objWork.value) > 24 ))
            {
                isInValid = 1;
                alert('Work should be in a range (0 - 24) Hours.'); 
                objWork.focus();
                return;
            }
            
           QuickTaskTotalWork = parseFloat(QuickTaskTotalWork) + parseFloat(objWork.value); 
            
        }//if(objWork.value!='')
        if(GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber).value=='')
        {
            var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+RowNumber);
            var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID_'+RowNumber);
            var objDescription = GetObjectReference('frmRT_QuickTasks','Description_'+RowNumber);

            objDescription.value = objTaskTypeID[objTaskTypeID.selectedIndex].text;
            if (objSubTaskTypeID.value!='')
            objDescription.value = objDescription.value + '->' + objSubTaskTypeID[objSubTaskTypeID.selectedIndex].text;
        }
        
        //Added by GokulP on 07 Oct 2009 for IssueID : 33612 -- GokulKP
        //alert(ProjectDetails.length);       
        
        for(k=0;k<ProjectDetails.length && RowNumber > <%=intAssignedTaskRows%> ;k++)
        {   
            if(GetObjectReference('frmRT_QuickTasks','ProjectID_'+RowNumber).value==ProjectDetails[k][0])
            {		
                if(objWork.value!='' && (parseFloat(ProjectDetails[k][2]) < parseFloat(objWork.value)))
                {   
	                if (confirm('You are assigning '+objWork.value +' hours work per day for \''+ObjTaskDescription.value+'\' task. \n (OU working hours per day are '+ProjectDetails[k][2]+' hours.) for \''+ProjectDetails[k][1]+'\' Project. Do you want to continue?')==false) 
	                 {
	                    isInValid = 1;
	                    objWork.focus();                   
	                    return;			                
	                 }		        
	            }
            } 
        }
        //End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612 
     }   
} 


function window_onload()		
{
    var strFirstTaskValidationMessage = "<%=m_strFirstTaskValidationMessage%>";
    if(strFirstTaskValidationMessage!='' && strMessageDisplayed==0) 
    {
        alert(strFirstTaskValidationMessage);       
        strMessageDisplayed = 1;
    }
    
	var intDivHeight ;
	var intDivHeightRisk;
	var intScriptNo;
	document.body.style.visibility='visible';
	objDivpopup = document.getElementById("divTbl");
	if(objDivMain != null)
	{
	    if (navigator.appName=="Netscape") {intDivHeight = window.innerHeight -  objDivMain.offsetTop - 40;  }
	    else  { intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70; }	 
	    if (intDivHeight < 100)  intDivHeight = 100;
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objDivMain.style.height = intDivHeight;	
	    objDivMain.style.height = intDivHeight + 'px';		
	}	
}

// fn.. to display the calendar control
function callcalendar(formname,datefield)
{
	var objdateObject=GetObjectReference(formname,datefield)
	var dtval;
	
	if(objdateObject.value =='') dtval='None';
	else dtval=objdateObject.value;
	calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval+'&FromWhere=QT','calendar_window','top=0,left=0,width=348,height=260');calendar_window.focus();
}
		
function window_onresize()		
{
    var strFirstTaskValidationMessage = "<%=m_strFirstTaskValidationMessage%>";
    if(strFirstTaskValidationMessage!='' &&  strMessageDisplayed==0)
    {
        alert(strFirstTaskValidationMessage);  
         strMessageDisplayed = 1;      
    }
        
	if(objDivMain != null)
	{
		var intDivHeight ;
		var intDivHeightRisk;
		if (navigator.appName=="Netscape") { intDivHeight = window.innerHeight -  objDivMain.offsetTop - 52; }
		else { intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 48; }
		
		if (intDivHeight < 100) intDivHeight = 100;
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objDivMain.style.height = intDivHeight;	
		objDivMain.style.height = intDivHeight + 'px';		
	}	
}
		
//function Project_OnChange(RowNumber)
function Project_OnChange()
{
	var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID');
	var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID');
	var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID');
	
	if ((objTaskTypeID!=null)&&(objSubTaskTypeID!=null))
	{
		objTaskTypeID.length = 0;
		objTaskTypeID.appendChild(AddOption('',''));
		objSubTaskTypeID.length = 0;
		objSubTaskTypeID.appendChild(AddOption('',''));
	}
	if (objProjectID.value=='')
		return;
	
	var xmlHttp;
	var strUrl;
	try
	{    // Firefox, Opera 8.0+, Safari   
	    xmlHttp=new XMLHttpRequest();    
	}
	catch (e)
	{    // Internet Explorer  
	    try { xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      }
		catch (e)
		{      
	        try {   xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");    }
		    catch (e) {    alert("Your browser does not support AJAX!");   return false;  }      
	    }    
	}  
	xmlHttp.onreadystatechange=function()
	{
	    if(xmlHttp.readyState==4)
	    {
		    if (xmlHttp.status==200)
		    {					
			    var str = xmlHttp.responseText;
			    ReqSDeta=str.split("|");
			    //InitialiseTasks();
			    //Added for Task creation Access
			    if (str=='NO_ACCESS')
			    {
				    alert("You have no access to create task for '"+objProjectID[objProjectID.selectedIndex].text+"' project.");
				    objProjectID.value='';
				    objProjectID.focus();
			    }
			    else { InitialiseTasks();	}
			    //End of Addition for Task creation Access
		    }
	    }
	}
	
	strUrl = new String();		
	strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&ProjectID="+objProjectID.value;		
	xmlHttp.open("GET",strUrl,true);
	xmlHttp.send(null);
}

function DeleteFromDB(strPKID)
{
	var xmlHttp;
	var strUrl;
	try
	{    // Firefox, Opera 8.0+, Safari   
	    xmlHttp=new XMLHttpRequest();    
	}
	catch (e)
	{    // Internet Explorer  
	    try{      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");   }
		catch (e)
		{      
		    try {  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");  }
			catch (e) { alert("Your browser does not support AJAX!");  return false; }      
		}    
	}  
	xmlHttp.onreadystatechange=function()
	{
	    if(xmlHttp.readyState==4)
		{
			if (xmlHttp.status==200)
			{
				var str = xmlHttp.responseText;
			}
		}
	}
	
	strUrl = new String();		
	strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&DeleteTask="+strPKID;		
	xmlHttp.open("GET",strUrl,true);
	xmlHttp.send(null)
}

function Add_OnClick()
{
	createRow(GetObjectReference('frmRT_QuickTasks','RowNumber').value);
}

function createRow(RowNumber)
{	
	var row,c1;
	row=objTbl.insertRow(RowNumber);
	row.className="clsTREven";
	createCells(row, RowNumber);
	var objRowNumber = GetObjectReference('frmRT_QuickTasks','RowNumber');
	objRowNumber.value = parseInt(objRowNumber.value) + 1; 
}

function createCells(row, RowNumber)
{
	var cell;
	var strHtml;
	var prevCell;
	
	cell=row.insertCell(0);
	cell.align="left";
	strHtml = "<SELECT onchange=Project_OnChange("+RowNumber+") id=ProjectID_"+RowNumber+" name=ProjectID_"+RowNumber+" class=clsComboBox style='width:200px '>"
	strHtml = strHtml + "<FONT size=1><OPTION value =''></OPTION>"
	for(i=0;i<Project.length;i++)
	{
		strHtml=strHtml+"<OPTION value ='"+Project[i][0]+"'>"+Project[i][1]+"</OPTION>"
	}
	strHtml = strHtml +"</FONT></SELECT>"	
	strHtml = strHtml + "<Input  Type=hidden  name='UniqueID_"+RowNumber+"' id='UniqueID_"+RowNumber+"' class='clsTextBox' style='width:50px ; value='' > ";
	cell.innerHTML=strHtml; 
		
	cell=row.insertCell(1); 
	cell.align="left";
	strHtml="<Input  Type=Textbox  name='Description_"+RowNumber+"' id='Description_"+RowNumber+"' class='clsTextBox' style='width:200px  ; ";
	strHtml+="text-align:left' maxlength=200 value='' >"
	cell.innerHTML=strHtml;	
	
	cell=row.insertCell(2); 	
	cell.align="left";
	cell.valign="top";
	strHtml = "<SELECT onchange=Task_OnChange("+RowNumber+") id=TaskTypeID_"+RowNumber+" name=TaskTypeID_"+RowNumber+" class=clsComboBox style='width:120px '>"
	strHtml = strHtml + "<FONT size=1><OPTION value =''></OPTION>"	
	strHtml = strHtml +"</FONT></SELECT>"
	cell.innerHTML=strHtml; 
	
	cell=row.insertCell(3); 
	cell.align="left";
	strHtml = "<SELECT id='SubTaskTypeID_"+RowNumber+"' name='SubTaskTypeID_"+RowNumber+"' class=clsComboBox style='width:120px '>"
	strHtml = strHtml + "<FONT size=1><OPTION value =''></OPTION>"
	strHtml = strHtml +"</FONT></SELECT>"
	cell.innerHTML=strHtml;
	
	cell=row.insertCell(4); 
	cell.align="right";
	strHtml="<Input  Type=Textbox  name='Work_"+RowNumber+"' id='Work_"+RowNumber+"' class='clsTextBox' style='width:50px  ; ";
	strHtml+="text-align:right' maxlength=8 value='' >"
	cell.innerHTML=strHtml;
	
	prevCell=objTbl.rows[RowNumber-1].cells;
	prevCell[5].innerHTML="Cancel";
	
	cell=row.insertCell(5); 
	cell.align="center";
	strHtml="<A HREF='Javascript:Cancel_OnClick("+RowNumber+")' Title='Cancel' >Cancel</A>";
	cell.innerHTML=strHtml;
}

function Cancel_OnClick(RowNumber)
{
	var objUniqueID = GetObjectReference('frmRT_QuickTasks','UniqueID_'+RowNumber);
	var strPKID = objUniqueID.value;
	
	objTbl.deleteRow(RowNumber);
	if (RowNumber>1)
	{
		prevCell=objTbl.rows[RowNumber-1].cells;
		prevCell[5].innerHTML="<A HREF='Javascript:Cancel_OnClick("+(RowNumber-1)+")' Title='Cancel' >Cancel</A>";
	}
	var objRowNumber = GetObjectReference('frmRT_QuickTasks','RowNumber');
	objRowNumber.value = parseInt(objRowNumber.value) - 1;
	if (objRowNumber.value < 1)
		objRowNumber.value='1';
	
	if (strPKID!='')
	{
		DeleteFromDB(strPKID);
	}		
}

function AddOption(strValue,strText)
{
    objNewElement = document.createElement('OPTION');
    objNewElement.innerHTML = strText;
    objNewElement.value = strValue;
    return objNewElement;
}

function Task_OnChange()
{
    var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID');
    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID');
    var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID'); 
    var selected = objTaskTypeID.value;
    var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;

    ///To Reinitialize Task Array
    var xmlHttp;
    var strUrl;
    try { xmlHttp=new XMLHttpRequest();  }
    catch (e)
    {    // Internet Explorer  
        try {  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP"); }
        catch (e)
        {      
            try {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e){  alert("Your browser does not support AJAX!");  return false;    }      
        }    
    }  
    xmlHttp.onreadystatechange=function()
    {
        if(xmlHttp.readyState==4)
        {
            if (xmlHttp.status==200)
            {
                var str = xmlHttp.responseText;
                ReqSubTaskDeta=str.split("|");
                //InitializeSubTask(RowNumber);
                InitializeSubTask();
            }
        }
    }
    strUrl = new String();
    strUrl = "../RT/RT_QuickTasks.aspx?FromXML=1&Action=TaskType&ProjectID="+objProjectID.value;

    xmlHttp.open("GET",strUrl,true);
    xmlHttp.send(null)	
    ///End of Reinitialize Task Array
}
			
function InitialiseTasks()
{
    var objProjectID = GetObjectReference('frmRT_QuickTasks','ProjectID');
    var j, i =0;
    var strTaskType;
    //Added to reinitialise an array
    TaskType.length = 0;

    for(j=0;j<ReqSDeta.length-2;j=j+2)
    {
        TaskType[i] = new Array(2);
        TaskType[i][0] = ReqSDeta[j];

        strTaskType = ReqSDeta[j+1]; 
        TaskType[i][1] = strTaskType;
        i=i+1;
    }     

    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID'); 
    var lngSelectedOUPool,lngSelectedProgram, intProjectID = objProjectID[objProjectID.selectedIndex].value;

    if(objTaskTypeID==null) return;

    if (intProjectID>0)
    {
        i=0;
        ngSelectedOUPool = objTaskTypeID[objTaskTypeID.selectedIndex].value;
        objTaskTypeID.length = 0;
        objTaskTypeID.appendChild(AddOption('',''));
        for(i=0;i<TaskType.length;i++)
        {
            objTaskTypeID.appendChild(AddOption(TaskType[i][0],TaskType[i][1]));
            if(objTaskTypeID.style.display!='none') 
                objTaskTypeID.focus();
            if(TaskType[i][1] == lngSelectedOUPool){
                objTaskTypeID.selectedIndex = objTaskTypeID.length - 1; }
        }
    }
    else
    {
    objTaskTypeID.length = 0;
    objTaskTypeID.appendChild(AddOption('',''));
    }

}
	
function InitializeSubTask()
{
    var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID');
    var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID'); 
    var selected = objTaskTypeID.value;
    var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;

    //Added to reinitialise an array
    arrTT_ST.length=0;
    i=0;
    for(j=0;j<ReqSubTaskDeta.length-3;j=j+3)
    {
        arrTT_ST[i] = new Array(3);
        arrTT_ST[i][0] = ReqSubTaskDeta[j];
        arrTT_ST[i][1] = ReqSubTaskDeta[j+1]
        strTaskType = ReqSubTaskDeta[j+2]; 
        arrTT_ST[i][2] = strTaskType;
        i=i+1;
    }     

    if(objTaskTypeID==null || objSubTaskTypeID == null ) return;
    if(intTTID > 0)
    { 
        i = 0;
        lngSelectedOUPool = objSubTaskTypeID[objSubTaskTypeID.selectedIndex].value;
        objSubTaskTypeID.length = 0;
        objSubTaskTypeID.appendChild(AddOption('',''));
        for(i=0; i < arrTT_ST.length;i++)
        {
            if(intTTID == arrTT_ST[i][0])
            {
                objSubTaskTypeID.appendChild(AddOption(arrTT_ST[i][1],arrTT_ST[i][2]));
                if(objSubTaskTypeID.style.display!='none') 
                       objSubTaskTypeID.focus();
                if(arrTT_ST[i][1] == lngSelectedOUPool)
                {
	                    objSubTaskTypeID.selectedIndex = objSubTaskTypeID.length - 1;
                }
            }
        }
    }
    else
    {
        objSubTaskTypeID.length = 0;
        objSubTaskTypeID.appendChild(AddOption('',''));
    }
}
	
function Submit_OnClick()
{
    QuickTaskTotalWork = 0;
    
    //Added for plan task
    var objRowNumber = GetObjectReference('frmRT_QuickTasks','RowNumber');
    var dblTotalWork, objWork, strMsg; 
    var i,k, TotalWork=0;
           
    //Added to check Timsheet blocking
    if (<%=m_IsTimesheetBlocked%>==1)
    {
        alert('Timesheet entry has been blocked. You cannot enter timesheet for this date.');
        return;
    }
    //End of addition for timesheet blocking
    
    if(objRowNumber!=null)
    {
        for(i=1;i<objRowNumber.value;i++)
        {           
            var ObjTaskDescription = GetObjectReference('frmRT_QuickTasks','Description_'+i);
            var ObjTaskType = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+i);
            var ObjPriority = GetObjectReference('frmRT_QuickTasks','Priority_'+i);
            var ObjProject = GetObjectReference('frmRT_QuickTasks','ProjectID_'+i);
            
            //Project Validation
            if(ObjProject!=null)
            { 
                if(trimString(ObjProject.value)== "")
                {   
                    alert('Please select Project.');          
                    ObjProject.focus();
                    return;
                }
            }
              
            if(ObjTaskDescription!=null)
            {                 
                if(trimString(ObjTaskDescription.value)== "")
                {
                    alert('\'Task / Description\' can not left blank.'); 
                    ObjTaskDescription.value = "";
                    ObjTaskDescription.focus();
                    return;
                }
            }
            if(ObjTaskDescription!=null)
            {
                if((ObjTaskDescription).length > 200)
                {           
                    alert('Max length for Description is 200.'); 
                    ObjTaskDescription.focus();
                    return;
                }
            }            
            //TaskType Validation
            if(ObjTaskType!=null)
            { 
                if(trimString(ObjTaskType.value)== "")
                {
                    alert('Please select Task Type.');               
                    ObjTaskType.focus();
                    return;
                }
            }
            
            //Priority Validation
            if(ObjPriority!=null)
            { 
                if(trimString(ObjPriority.value)== "")
                {
                    alert('Please select Priority.');                
                    ObjPriority.focus();
                    return;
                }
            }                          
           
            //Work Validations
            objWork = GetObjectReference('frmRT_QuickTasks','Work_'+i);
            
            if(objWork.value==0)
                objWork.value = '';
                
            if(objWork.value!='')
            {
                if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true)) 
                { 
                    return; 
                }
                dblTotalWork = objWork.value;
                
                if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
                {
	                strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
	                alert(strMsg);
	                setFocus(objWork);
	                return;
                }
                if( ( parseFloat(objWork.value) < 0 )||( parseFloat(objWork.value) > parseFloat(24) ))
                {
	                alert('Work should be in a range (0 - 24) Hours.'); 
	                objWork.focus();
	                return;
                }
            	
                TotalWork = parseFloat(TotalWork) + parseFloat(objWork.value);
            } 
           
            //Added by GokulP on 07 Oct 2009 for IssueID : 33612
            for(k=0;k<ProjectDetails.length && i > <%=intAssignedTaskRows%> ;k++)
            {
                if(GetObjectReference('frmRT_QuickTasks','ProjectID_'+i).value==ProjectDetails[k][0])
                {		
	                if(objWork.value!='' && (parseFloat(ProjectDetails[k][2]) < parseFloat(objWork.value)))
                    { 	           
		                if (confirm('You are assigning '+objWork.value +' hours work per day for \''+ObjTaskDescription.value+'\' task. \n (OU working hours per day are '+ProjectDetails[k][2]+' hours.) for \''+ProjectDetails[k][1]+'\' Project. Do you want to continue?')==false) 
		                 {
		                    setFocus(objWork);		                   
		                    return;			                
		                 }		        
		            }
                } 
            }
            //End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612    
        }
    }
    
    if (IsInValidWorkforAssignedTasks())
    return;
 
    var objAssignedTaskRow = GetObjectReference('frmRT_QuickTasks','AssignedTaskCount');

    var objActualDA = GetObjectReference('frmRT_QuickTasks','ActualDA');
    
    var TotalRow;
    TotalRow = LastRowNumber + 1;
    isInValid = 0;
    for (i=objRowNumber.value; i<TotalRow; i++)
    {
       Validation(i);
       if(isInValid==1) return;
    }
    
    if(parseFloat(TotalWork)+ parseFloat(QuickTaskTotalWork)==0)
    {
        alert('There is no task(s) having work greater than 0(zero) hours to fill Daily activities.');
        return;
    } 
        
    TotalWork = parseFloat(TotalWork) + parseFloat(objActualDA.value) + parseFloat(QuickTaskTotalWork);
    
    if (parseFloat(TotalWork)>parseFloat('24'))
    {
        strMsg = 'You can book only 24 hours in a day.';
        if ((objActualDA.value!='0'))
            strMsg = strMsg + '\n[You have already booked '+objActualDA.value +' hours.]'
        alert(strMsg);	
        return;
    }
    
    if(isInValid==0)
    {        
        if (confirm('This action will fill Daily activities for tasks for which Actual Work has been entered.\nPress OK to continue.')==false) return;
        //Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
        var MenuTags = document.getElementsByTagName('A');
        for (i = 0; i < MenuTags.length; i++) {
            if (MenuTags[i].className == "Menu") {
                //MenuTags[i].style.display= "none";
                MenuTags[i].parentNode.style.display = "none";
            }
        }
        setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
        //End Of Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
        objform.action = "../RT/RT_QuickTasks.aspx?Mode=SUBMIT&Rows="+TotalRow+"&AssignedTasks="+objAssignedTaskRow.value;
                                                             
        objform.submit(); 
    }
} //function Submit

function IsInValidWorkforAssignedTasks()
{   
	var objAssignedTaskRow = GetObjectReference('frmRT_QuickTasks','AssignedTaskCount');
	var objRowCount = GetObjectReference('frmRT_QuickTasks','RowNumber');
	var i, objWork, objPlannedWork, objWhichTask, objTaskWork;
	
	for(i=1;i<=objAssignedTaskRow.value;i++)
	{
		objWork = GetObjectReference('frmRT_QuickTasks','Work_'+i);
		objPlannedWork = GetObjectReference('frmRT_QuickTasks','AssignedWork_'+i);
		objWhichTask = GetObjectReference('frmRT_QuickTasks','WhichTask_'+i);
		objAssignTaskName = GetObjectReference('frmRT_QuickTasks','TaskName_'+i);
		objProjectOUWorkHrs = GetObjectReference('frmRT_QuickTasks','OUWorkingHrs_'+i);
		objTaskProjectName = GetObjectReference('frmRT_QuickTasks','TaskProjectName_'+i);		
				
		//Work Validations
		if (objWork.value!='')
		{		    
			if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true)) { return true; }
			dblTotalWork = objWork.value;
			if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
			{
				strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
				alert(strMsg);
				setFocus(objWork);
				return true;
			}			
			if( ( parseFloat(objWork.value) < 0 ) || ( parseFloat(objWork.value) > 24 ))
			{
				alert('Work should be in a range (0 - 24) Hours.'); 
				objWork.focus();
				return true;
			}
			// Which Task
			objTaskWork = GetObjectReference('frmRT_QuickTasks','TaskWork_'+i);
			
			if(objWhichTask!=null)
			{
			    if(objWhichTask.value=='M')
			    {
				    if ((<%=m_RestrictDurationChange_M%>==1) && (parseFloat(objPlannedWork.value) < parseFloat(objWork.value)))
				    {
					    if (parseFloat(objPlannedWork.value)>0)
					    {						   
						    alert('You were allocated only '+objTaskWork.value+' hour(s) to complete \''+objAssignTaskName.value+'\' task.\nSave/submit action is not allowed for this entry, as it may affect the project schedule.');
					    }
					    else
					    {						 
						    alert('You were allocated only '+objTaskWork.value+' hour(s) to complete \''+objAssignTaskName.value+'\' task.\nSave/submit action is not allowed for this entry, as it may affect the project schedule.');
					    }
					    objWork.focus();
					    return true;
				    }
			    }
				
			    else
			    {   
				    if ((<%=m_RestrictDurationChange_O%>==1) && (parseFloat(objPlannedWork.value) < parseFloat(objWork.value)))
				    {
					    if (parseFloat(objPlannedWork.value)>0)
					    {						    
						    alert('You were allocated only '+objTaskWork.value+' hour(s) to complete \''+objAssignTaskName.value+'\' task.\nSave/submit action is not allowed for this entry, as it may affect the project schedule.');
					    }
					    else
					    {						  
						    alert('You were allocated only '+objTaskWork.value+' hour(s) to complete \''+objAssignTaskName.value+'\' task.\nSave/submit action is not allowed for this entry, as it may affect the project schedule.');
					    }
					    objWork.focus();
					    return true;
				    }
				    else
				    {
				        //Added by GokulP on 07 Oct 2009 for IssueID : 33612
				       if(parseFloat(objProjectOUWorkHrs.value) < parseFloat(objWork.value))
				        {		            		            
				            if (confirm('You are assigning '+objWork.value +' hours work per day for \''+objAssignTaskName.value+'\' task. \n (OU working hours per day are '+objProjectOUWorkHrs.value+' hours.) for \''+objTaskProjectName.value+'\' Project. Do you want to continue?')==false) 
				             {
				                setFocus(objWork);
				                return true;			                
				             }
				        }
				        //End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612
				        
				        if(parseFloat(objPlannedWork.value) < parseFloat(objWork.value))
				        {
				             if (confirm('You were allocated ' + objPlannedWork.value + ' hour(s) to complete \''+objAssignTaskName.value+'\' task. With this entry, the total hours that will be booked against this task is '+objWork.value +' hour(s).\nYour project schedule may be affected. Do you want to continue?')==false) 
				             {
				                setFocus(objWork);
				                return true;			                
				             }
				        }
				    }
			    } 
			}		
		} 
	} 
	return false;	
}

    function Save_OnClick(QTaskID)
    { 
        //Added for plan task
        //added by Nilesh g on 14/1/2016 for add loader on save link
        var Mode = (arguments.length > 1) ? arguments[1] : "0";
        if (Mode == "0") {
            document.body.readonly=true;
            window.setTimeout('Save_OnClick("' + QTaskID + '","1")', 1);
        }
        if (Mode == "1") {
       //end of added by Nilesh g on 14/1/2016 for add loader on save link
            var objRowNumber = GetObjectReference( 'frmRT_QuickTasks','RowNumber');
            var dblTotalWork, objWork, strMsg; 
            var i,k, TotalWork=0;
           
            //Added to check Timsheet blocking
            if (<%=m_IsTimesheetBlocked%>==1)
            {
                alert('Timesheet entry has been blocked. You cannot enter timesheet for this date.');
                return;
            }
            //End of addition for timesheet blocking

            if(objRowNumber!=null)
            {
                for(i=1;i<objRowNumber.value;i++)
                {           
                    var ObjTaskDescription = GetObjectReference('frmRT_QuickTasks','Description_'+i);
                    var ObjTaskType = GetObjectReference('frmRT_QuickTasks','TaskTypeID_'+i);
                    var ObjPriority = GetObjectReference('frmRT_QuickTasks','Priority_'+i);
                    var ObjProject = GetObjectReference('frmRT_QuickTasks','ProjectID_'+i);
                
                    //Project Validation
                    if(ObjProject!=null)
                    { 
                        if(trimString(ObjProject.value)== "")
                        {   
                            alert('Please select Project.');          
                            ObjProject.focus();
                            return;
                        }
                    }
              
                    if(ObjTaskDescription!=null)
                    { 
                        if(trimString(ObjTaskDescription.value)== "")
                        {
                            alert('\'Task / Description\' can not left blank.'); 
                            ObjTaskDescription.value = "";
                            ObjTaskDescription.focus();
                            return;
                        }
                    }
                    if(ObjTaskDescription!=null)
                    {
                        if((ObjTaskDescription).length > 200)
                        {           
                            alert('Max length for Description is 200.'); 
                            ObjTaskDescription.focus();
                            return;
                        }
                    }
               
                    //TaskType Validation
                    if(ObjTaskType!=null)
                    { 
                        if(trimString(ObjTaskType.value)== "")
                        {
                            alert('Please select Task Type.');               
                            ObjTaskType.focus();
                            return;
                        }
                    }
            
                    //Priority Validation
                    if(ObjPriority!=null)
                    { 
                        if(trimString(ObjPriority.value)== "")
                        {
                            alert('Please select Priority.');                
                            ObjPriority.focus();
                            return;
                        }
                    }                          
           
                    //Work Validations
                    objWork = GetObjectReference('frmRT_QuickTasks','Work_'+i);
            
                    if(objWork.value==0)
                        objWork.value = '';
                
                    if(objWork.value!='')
                    {
                        if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true)) 
                        { 
                            return; 
                        }
                        dblTotalWork = objWork.value;
                
                        if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
                        {
                            strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
                            alert(strMsg);
                            setFocus(objWork);
                            return;
                        }
                        if( ( parseFloat(objWork.value) < 0 )||( parseFloat(objWork.value) > parseFloat(24) ))
                        {
                            alert('Work should be in a range (0 - 24) Hours.'); 
                            objWork.focus();
                            return;
                        }
            	
                        TotalWork = parseFloat(TotalWork) + parseFloat(objWork.value);
                    }
           
                    //Added by GokulP on 07 Oct 2009 for IssueID : 33612
                    for(k=0;k<ProjectDetails.length && i > <%=intAssignedTaskRows%> ;k++)
                    {               
                        if(GetObjectReference('frmRT_QuickTasks','ProjectID_'+i).value==ProjectDetails[k][0])
                        {		
                            if(objWork.value!='' && (parseFloat(ProjectDetails[k][2]) < parseFloat(objWork.value)))
                            {  		            
                                if (confirm('You are assigning '+objWork.value +' hours work per day for \''+ObjTaskDescription.value+'\' task. \n (OU working hours per day are '+ProjectDetails[k][2]+' hours.) for \''+ProjectDetails[k][1]+'\' Project. Do you want to continue?')==false) 
                                {
                                    setFocus(objWork);		                    
                                    return;			                
                                }		        
                            }
                        } 
                    }
                    //End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612        
                }            
            }
     
            if (IsInValidWorkforAssignedTasks())
                return;
  
            var objAssignedTaskRow = GetObjectReference('frmRT_QuickTasks','AssignedTaskCount');

            var objActualDA = GetObjectReference('frmRT_QuickTasks','ActualDA');
    
            var TotalRow;
            TotalRow = LastRowNumber + 1;
            isInValid = 0;
            for (i=objRowNumber.value; i<TotalRow; i++)
            {
                Validation(i);
                if(isInValid==1) return;
            }
    
            TotalWork = parseFloat(TotalWork) + parseFloat(objActualDA.value);
    	
            if (parseFloat(TotalWork)>parseFloat('24'))
            {
                strMsg = 'You can book only 24 hours in a day.';
                if ((objActualDA.value!='0'))
                    strMsg = strMsg + '\n[You have already booked '+objActualDA.value +' hours.]'
                alert(strMsg);	
                return;
            }
    
            if(isInValid==0)
            {
                //setFrameLoader();//added by Nilesh g on 14/1/2016 for add loader on save link
                //Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
                var MenuTags = document.getElementsByTagName('A');
                for (i = 0; i < MenuTags.length; i++) {
                    if (MenuTags[i].className == "Menu") {
                        //MenuTags[i].style.display= "none";
                        MenuTags[i].parentNode.style.display = "none";
                    }
                }
                setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
                //End Of Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
                objform.action = "../RT/RT_QuickTasks.aspx?Mode=PLANWORK&Rows="+TotalRow+"&AssignedTasks="+objAssignedTaskRow.value;
                
                objform.submit(); 
            }   
   
        }
    }
	
function state_Change()
{
	// if xmlhttp shows "loaded"
	if (xmlhttp.readyState==4)
	{
	    // if "OK"
		if (xmlhttp.status==200)
		{
			//alert(xmlhttp.responseText);
			AppendData(xmlhttp.responseText);
		}
		else
		{
			alert("Problem in loading data:" + xmlhttp.statusText)
		}		
	}
}
/////////////////////////////////////////////////////////////////////////////////////////
function AppendData(strData)
{
    var newRow,newCell,i,r;
    var arrColumns = strData.split("$#TD#$");
    var QTaskID;
    var objTable = GetObjectReference('frmRT_QuickTasks','tbl_popup');
    var tablelength=objTable.rows.length - 1 ;

    for(i=tablelength;i>=1;i--)
    {
        objTable.deleteRow(i);
    }
    i=0;
    for(r=0;r<5;r++)
    {
        newRow = objTable.insertRow(objTable.rows.length);
        newRow.className='clsTROdd';
        //Create Cell
        newCell=newRow.insertCell(0);
        newCell.align='right';
        newCell.width='20%';
        newCell.valign='top';
        //newCell.borderWidth='1px;';
        newCell.innerHTML=arrColumns[i++];
        newCell=newRow.insertCell(1);
        newCell.align='left';
        newCell.width='60%';
        newCell.valign='top';
        //newCell.borderWidth='1px;';
        newCell.innerHTML=arrColumns[i++];
    }//for(r=0;r<=5;r++)

    QTaskID = GetObjectReference('frmRT_QuickTasks','UniqueID').value;
    newRow = objTable.insertRow(objTable.rows.length);
    newRow.className='clsTROdd';
    newCell=newRow.insertCell(0);
    newCell.align='right';
    newCell.width='20%';
    newCell.valign='middle';
    //newCell.borderWidth='1px;';
    newCell.innerHTML = '<input type=button id= btnOK name= btnOK Value = "   OK   " style ="font size=9 width=10pts" onClick = OK_Onclick(' + QTaskID + ')>';
    newCell=newRow.insertCell(1);
    newCell.align='left';
    newCell.width='60%';
    newCell.valign='middle';
    //newCell.borderWidth='1px;';
    newCell.innerHTML = '<input type=button id= btnCancel name= btnCancel style ="font size=9" Value = CANCEL onClick = cancel_OnClick(' + QTaskID + ')>';

    if (GetObjectReference('frmRT_QuickTasks','Description')!=null)
    GetObjectReference('frmRT_QuickTasks','Description').focus();			
}//function AppendData(strData)
/////////////////////////////////////////////////////////////////////////////////////////
function OK_Onclick(QTaskID)
{
    //Description 
    if((GetObjectReference('frmRT_QuickTasks','Description').value).length > 200)
    {
        alert('Max length for Description is 200.'); 
        GetObjectReference('frmRT_QuickTasks','Description').focus();
        return;
    }
    //Project Validation
    var objWork = GetObjectReference('frmRT_QuickTasks','Work');
    if(GetObjectReference('frmRT_QuickTasks','ProjectID').value=='')
    {
        alert('Please select Project.'); 
        GetObjectReference('frmRT_QuickTasks','ProjectID').focus();
        return;
    }
    //TaskType Validation
    if(GetObjectReference('frmRT_QuickTasks','TaskTypeID').value=='')
    {
        alert('Please select Task Type.'); 
        GetObjectReference('frmRT_QuickTasks','TaskTypeID').focus();
        return;
    }
    if(objWork.value!='')
    {
        if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true)) { return; }

        dblTotalWork = objWork.value;
        if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
        {
            strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
            alert(strMsg);
            setFocus(objWork);
            return;
        }
        if( ( parseFloat(objWork.value) < parseFloat(<%=dblMinHoursForDAEntry%>) )||( parseFloat(objWork.value) > 24 ))
        {
            alert('Work should be in a range (<%=dblMinHoursForDAEntry%>-24) Hours.'); 
            objWork.focus();
            return;
        }
    }//if(objWork.value!='')
    if(GetObjectReference('frmRT_QuickTasks','Description').value=='')
    {
        var objTaskTypeID = GetObjectReference('frmRT_QuickTasks','TaskTypeID');
        var objSubTaskTypeID = GetObjectReference('frmRT_QuickTasks','SubTaskTypeID');
        var objDescription = GetObjectReference('frmRT_QuickTasks','Description');

        objDescription.value = objTaskTypeID[objTaskTypeID.selectedIndex].text;
        if (objSubTaskTypeID.value!='')
        objDescription.value = objDescription.value + '->' + objSubTaskTypeID[objSubTaskTypeID.selectedIndex].text;
    }
    objDivpopup.style.display="none"; 
    objDivpopup.style.display="none"; 
    isClickImagePopup=false;

    //Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
    var MenuTags = document.getElementsByTagName('A');
    for (i = 0; i < MenuTags.length; i++) {
        if (MenuTags[i].className == "Menu") {
            //MenuTags[i].style.display= "none";
            MenuTags[i].parentNode.style.display = "none";
        }
    }
    setFrameLoader();//ADDED BY NILESH G ON 12/2/2016 FOR SAVE ISSUE  
    //End Of Added By Chakshuta H on 12th-Oct-2016 Purpose::To add Loader
    objform.action = "../RT/RT_QuickTasks.aspx?Mode=SAVE";
    objform.submit(); 
} //function OK_Onclick(QTaskID)

function cancel_OnClick()
{
	objDivpopup.style.display="none"; 
	objDivpopup.style.display="none"; 
	isClickImagePopup=false;
}

function change_date(e)
{
    var keynum
    if(window.event) // IE 
        {   keynum = e.keyCode  }
    else if(e.which) // Netscape/Firefox/Opera
        {   keynum = e.which   }
    if (keynum==13)  {  window.focus()  }
}

    
	</script>

  </body>
</html>

