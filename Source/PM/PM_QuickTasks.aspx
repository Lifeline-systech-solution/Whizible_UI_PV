<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_QuickTasks.aspx.vb" Inherits="PbNIT.PM_QuickTasks"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Quick Tasks")%>
	
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


		<body class="clsBody" onresize="window_onresize()"  onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmPM_QuickTasks" method="post" runat="server">
			<%PageInit%>
		</form> 
		
		<SCRIPT language="javascript">
			var objform=GetFormReference('frmPM_QuickTasks');
			var objDivMain=GetObjectReference('frmPM_QuickTasks','PageDiv');
			var objTaskSDt,objTaskEDt,objTaskHrs,objBalenceWork;			
			var objTbl=GetObjectReference('frmPM_QuickTasks','QTasks');
			var TaskType = new Array();
			var arrTT_ST = new Array();
			var ReqSDeta=[];
			var ReqD=[];
			var ReqSubTaskDeta=[];
			
			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
    	function window_onload()		
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			if(objDivMain != null)
			{
			if (navigator.appName=="Netscape") 
			 {
				intDivHeight = window.innerHeight -  objDivMain.offsetTop - 40;
			 }
			 else
			 {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
			 }
			 
			 if (intDivHeight < 100)
				intDivHeight = 100;
			    //objDivMain.style.height = intDivHeight;
			 objDivMain.style.height = intDivHeight + 'px';
				
			}
			
		}
		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ intDivHeight = window.innerHeight -  objDivMain.offsetTop - 52; }
				else
				{ intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 48; }
				
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight + 'px';
			}
			
		}
		
		function Project_OnChange(RowNumber)
		{
			var objProjectID = GetObjectReference('frmPM_QuickTasks','ProjectID_'+RowNumber);
			var objTaskTypeID = GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+RowNumber);
			var objSubTaskTypeID = GetObjectReference('frmPM_QuickTasks','SubTaskTypeID_'+RowNumber);
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
				try
					{      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      }
					catch (e)
					{      
				try
					{        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        }
					catch (e)
					{        alert("Your browser does not support AJAX!");        return false;        
				}      
				}    
				}  
				xmlHttp.onreadystatechange=function()
				{
				if(xmlHttp.readyState==4)
					{
						if (xmlHttp.status==200)
						{
							
							var str = xmlHttp.responseText;
							//ReqD=str.split("$#TD#$");
							ReqSDeta=str.split("|");
							InitialiseTasks(RowNumber);
						}
					}
				}
				
				strUrl = new String();
				
				strUrl = "../PM/PM_QuickTasks.aspx?FromXML=1&ProjectID="+objProjectID.value;
				
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
				try
					{      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      }
					catch (e)
					{      
				try
					{        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        }
					catch (e)
					{        alert("Your browser does not support AJAX!");        return false;        
				}      
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
				
				strUrl = "../PM/PM_QuickTasks.aspx?FromXML=1&DeleteTask="+strPKID;
				
				xmlHttp.open("GET",strUrl,true);
				xmlHttp.send(null)
		}
		
		function Add_OnClick()
		{
			createRow(GetObjectReference('frmPM_QuickTasks','RowNumber').value);
		}

		function createRow(RowNumber)
		{	
			var row,c1;
			row=objTbl.insertRow(RowNumber);
			row.className="clsTREvenRow";
			createCells(row, RowNumber);
			var objRowNumber = GetObjectReference('frmPM_QuickTasks','RowNumber');
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
			//strHtml="<Textarea wrap=off  name='Description_"+RowNumber+"' id='Description_"+RowNumber+"' class='clsTextArea' "
			//strHtml = strHtml + "style='OVERFLOW:scroll;width:150px  ; height:50px  ; text-align:Left' "
			//strHtml = strHtml + "></Textarea>"
			strHtml="<Input  Type=Textbox  name='Description_"+RowNumber+"' id='Description_"+RowNumber+"' class='clsTextBox' style='width:200px  ; ";
			strHtml+="text-align:left' maxlength=200 value='' >"
			
			
			
			/*
			strHtml = strHtml + "<A Href='JavaScript:opentextdialog(&quot;frmPM_QuickTasks&quot;,&quot;Description_"+RowNumber+"&quot;,&quot;Description&quot;,&quot;False&quot;)'";
			strHtml = strHtml + " onFocus='this.style.backgroundColor=#316ac5;' onblur='this.style.backgroundColor=;' ><img Border=0 valign=Top src='../../images/zoomin.gif' "; 
			strHtml = strHtml + " alt='Double click the text area to add more text'></img></a>";
			*/
			/*
			strHtml = strHtml + "<A Href='JavaScript:opentextdialog(&quot;frmPM_QuickTasks&quot;,&quot;Description_"+RowNumber+"&quot;,&quot;Description&quot;,&quot;False&quot;)'";
			strHtml = strHtml + " onFocus='this.style.backgroundColor=&quot;#316ac5;&quot;' onblur='this.style.backgroundColor=;' ><img Border=0 valign=Top src='../../images/zoomin.gif' "; 
			strHtml = strHtml + " alt='Double click the text area to add more text'></img></a>";
			*/
			
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
			var objUniqueID = GetObjectReference('frmPM_QuickTasks','UniqueID_'+RowNumber);
			var strPKID = objUniqueID.value;
			
			objTbl.deleteRow(RowNumber);
			if (RowNumber>1)
			{
				prevCell=objTbl.rows[RowNumber-1].cells;
				prevCell[5].innerHTML="<A HREF='Javascript:Cancel_OnClick("+(RowNumber-1)+")' Title='Cancel' >Cancel</A>";
			}
			var objRowNumber = GetObjectReference('frmPM_QuickTasks','RowNumber');
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
		
		function Task_OnChange(RowNumber)
		{
			var objProjectID = GetObjectReference('frmPM_QuickTasks','ProjectID_'+RowNumber);
			var objTaskTypeID = GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+RowNumber);
			var objSubTaskTypeID = GetObjectReference('frmPM_QuickTasks','SubTaskTypeID_'+RowNumber); 
			var selected = objTaskTypeID.value;
			var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;
			
			///To Reinitialize Task Array
			var xmlHttp;
			var strUrl;
			try
				{    // Firefox, Opera 8.0+, Safari   
				xmlHttp=new XMLHttpRequest();    
				}
				catch (e)
				{    // Internet Explorer  
				try
					{      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      }
					catch (e)
					{      
				try
					{        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        }
					catch (e)
					{        alert("Your browser does not support AJAX!");        return false;        
				}      
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
							InitializeSubTask(RowNumber);
							
						}
					}
				}
				
				strUrl = new String();
				
				strUrl = "../PM/PM_QuickTasks.aspx?FromXML=1&Action=TaskType&ProjectID="+objProjectID.value;
				
				xmlHttp.open("GET",strUrl,true);
				xmlHttp.send(null)	
			///End of Reinitialize Task Array
			/*
			if(objTaskTypeID==null || objSubTaskTypeID == null ) return;
			if(intTTID > 0){ i = 0;
				lngSelectedOUPool = objSubTaskTypeID[objSubTaskTypeID.selectedIndex].value;
				objSubTaskTypeID.length = 0;
			objSubTaskTypeID.appendChild(AddOption('',''));
				for(i=0; i < arrTT_ST.length;i++){
				if(intTTID == arrTT_ST[i][0]){
					objSubTaskTypeID.appendChild(AddOption(arrTT_ST[i][1],arrTT_ST[i][2]));
					if(objSubTaskTypeID.style.display!='none') 
					objSubTaskTypeID.focus();
					if(arrTT_ST[i][1] == lngSelectedOUPool){
						objSubTaskTypeID.selectedIndex = objSubTaskTypeID.length - 1;
					}
				}
				}
			}
			else
			{
				objSubTaskTypeID.length = 0;
				objSubTaskTypeID.appendChild(AddOption('',''));
			} */
			
		}
		
		function InitialiseTasks(RowNumber)
		{
			var objProjectID = GetObjectReference('frmPM_QuickTasks','ProjectID_'+RowNumber);
			var j, i =0;
			var strTaskType;
			for(j=0;j<ReqSDeta.length-2;j=j+2)
			{
				TaskType[i] = new Array(2);
				TaskType[i][0] = ReqSDeta[j];
				
				strTaskType = ReqSDeta[j+1]; 
				TaskType[i][1] = strTaskType;
				i=i+1;
	        }     
	        /*
	        //arrTT_ST
	        i=0;
			for(j=0;j<ReqSubTaskDeta.length-3;j=j+3)
			{
				arrTT_ST[i] = new Array(3);
				arrTT_ST[i][0] = ReqSubTaskDeta[j];
				arrTT_ST[i][1] = ReqSubTaskDeta[j+1]
				strTaskType = ReqSubTaskDeta[j+2]; 
				arrTT_ST[i][2] = strTaskType;
				i=i+1;
	        }      */
			var objTaskTypeID = GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+RowNumber); 
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
		function InitializeSubTask(RowNumber)
		{
			//arrTT_ST
			
			var objTaskTypeID = GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+RowNumber);
			var objSubTaskTypeID = GetObjectReference('frmPM_QuickTasks','SubTaskTypeID_'+RowNumber); 
			var selected = objTaskTypeID.value;
			var lngSelectedOUPool,lngSelectedProgram,j, i, intTTID = objTaskTypeID[objTaskTypeID.selectedIndex].value;
			
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
			if(intTTID > 0){ i = 0;
				lngSelectedOUPool = objSubTaskTypeID[objSubTaskTypeID.selectedIndex].value;
				objSubTaskTypeID.length = 0;
			objSubTaskTypeID.appendChild(AddOption('',''));
				for(i=0; i < arrTT_ST.length;i++){
				if(intTTID == arrTT_ST[i][0]){
					objSubTaskTypeID.appendChild(AddOption(arrTT_ST[i][1],arrTT_ST[i][2]));
					if(objSubTaskTypeID.style.display!='none') 
					objSubTaskTypeID.focus();
					if(arrTT_ST[i][1] == lngSelectedOUPool){
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
		function Save_OnClick()
		{
			var objRowNumber = GetObjectReference('frmPM_QuickTasks','RowNumber');
			var dblTotalWork, objWork, strMsg; 
			var i,k;
			for(i=1;i<objRowNumber.value;i++)
			{
				//Project Validation
				if(GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).value=='')
				{
					alert('Please select Project.'); 
					GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).focus();
					return;
				}
				
				//TaskType Validation
				if(GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+i).value=='')
				{
					alert('Please select Task Type.'); 
					GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+i).focus();
					return;
				}
				
				objWork = GetObjectReference('frmPM_QuickTasks','Work_'+i);
				if (objWork.value != '')
				{
					objWork = GetObjectReference('frmPM_QuickTasks','Work_'+i);
					
					if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true))
					{ return; }

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
					
					for(k=0;k<Project.length;k++)
					{
						if(GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).value==Project[k][0])
						{
							
							if (parseFloat(objWork.value) > parseFloat(Project[k][2]))
							{
								alert('The total work (Hours) of a task should not exceed the projet work hours.\nBalanced work hours are '+Project[k][2]+'.');
								objWork.focus();
								return;
							}
						}
					} 
				} //if (objWork.value != '')
			}
			objform.action = "../PM/PM_QuickTasks.aspx?Mode=SAVE&Rows="+objRowNumber.value;
			objform.submit(); 		
		}
		
		function Submit_OnClick()
		{
			var objRowNumber = GetObjectReference('frmPM_QuickTasks','RowNumber');
			var dblTotalWork, objWork, strMsg; 
			var i,k, TotalWork=0;
			
			for(i=1;i<objRowNumber.value;i++)
			{
				//Project Validation
				if(GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).value=='')
				{
					alert('Please select Project.'); 
					GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).focus();
					return;
				}
				
				//Description 
				if(GetObjectReference('frmPM_QuickTasks','Description_'+i).value=='')
				{
					alert('Please enter Description.'); 
					GetObjectReference('frmPM_QuickTasks','Description_'+i).focus();
					return;
				}
				
				if((GetObjectReference('frmPM_QuickTasks','Description_'+i).value).length > 200)
				{
					alert('Max length for Description is 200.'); 
					GetObjectReference('frmPM_QuickTasks','Description_'+i).focus();
					return;
				}
				
				//TaskType Validation
				if(GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+i).value=='')
				{
					alert('Please select Task Type.'); 
					GetObjectReference('frmPM_QuickTasks','TaskTypeID_'+i).focus();
					return;
				}
				
				//Work Validations
				objWork = GetObjectReference('frmPM_QuickTasks','Work_'+i);
				if(objWork.value=='')
				{
					alert('Please enter work (Hrs.).'); 
					objWork.focus();
					return;
				}
				if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true))
					{ return; }

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
					
				TotalWork = TotalWork + objWork.value;
				//alert(TotalWork);
				
				for(k=0;k<Project.length;k++)
				{
					if(GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).value==Project[k][0])
					{
						
						if ((Project[k][3]==3) && (GetObjectReference('frmPM_QuickTasks','SubTaskTypeID_'+i).value==''))
						{
							alert('Please select an Activity.'); 
							GetObjectReference('frmPM_QuickTasks','SubTaskTypeID_'+i).focus();
							return;
						}
						
						if (Project[k][6]=='0')
						{
							alert('Task Date should for '+Project[k][1]+' should be between Project start date ('+Project[k][4]+') and end date ('+Project[k][5]+').');
							GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).focus();
							return;
						}
						
						
						if (Project[k][7]=='0')
						{
							alert("Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project '"+Project[k][1]+"' is not Approved.")
							GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).focus();
							return;
						}
						
						if (Project[k][8]=='1')
						{
							alert("Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project '"+Project[k][1]+"' is OnHold.")
							GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).focus();
							return;
						}
						
						
						if (parseFloat(objWork.value) > parseFloat(Project[k][2]))
						{
							alert('The total work (Hours) of a task should not exceed the projet work hours.\nBalanced work hours are '+Project[k][2]+'.');
							objWork.focus();
							return;
						}
					} //if(GetObjectReference('frmPM_QuickTasks','ProjectID_'+i).value==Project[k][0])
				}//for(k=0;k<Project.length;k++)
			}//for(i=1;i<objRowNumber.value;i++)
			
			if (IsInValidWorkforAssignedTasks())
				return;
		
			var objAssignedTaskRow = GetObjectReference('frmPM_QuickTasks','AssignedTaskCount');
			for(i=0;i<objAssignedTaskRow.value;i++)
			{
				TotalWork = TotalWork + GetObjectReference('frmPM_QuickTasks','WorkForDA_'+i).value;
			}
			
			var objActualDA = GetObjectReference('frmPM_QuickTasks','ActualDA');
			TotalWork = TotalWork + objActualDA.value;
			
			if (parseFloat(TotalWork)>parseFloat('24'))
			{
				///alert('You can book only 24 hrs in a day.\n[You have already booked '+objActualDA.value +' hours.]')
				strMsg = 'You can book only 24 hours in a day.';
				if ((objActualDA.value!='0'))
					strMsg = strMsg + '\n[You have already booked '+objActualDA.value +' hours.]'
				alert(strMsg);	
				return;
			}
			
			objform.action = "../PM/PM_QuickTasks.aspx?Mode=SUBMIT&Rows="+objRowNumber.value+"&AssignedTasks="+objAssignedTaskRow.value;
			objform.submit(); 
		} //function Submit
		
		function IsInValidWorkforAssignedTasks()
		{
			var objAssignedTaskRow = GetObjectReference('frmPM_QuickTasks','AssignedTaskCount');
			var i, objWork, objPlannedWork;
			for(i=0;i<objAssignedTaskRow.value;i++)
			{
				objWork = GetObjectReference('frmPM_QuickTasks','WorkForDA_'+i);
				objPlannedWork = GetObjectReference('frmPM_QuickTasks','AssignedWork_'+i);
				//Work Validations
				/*if(objWork.value=='')
				{
					alert('Please enter work (Hrs.).'); 
					objWork.focus();
					return true;
				}
				*/
				if (objWork.value!='')
				{
					if (disallowNegativeNumeric(objWork,'Please enter only positive numeric value!!!',true))
					{ return true; }

					dblTotalWork = objWork.value;
					if ((dblTotalWork / <%=dblMinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=dblMinHoursForDAEntry%>))
					{
						strMsg = "Please specify the work (hours) in multiples of <%=dblMinHoursForDAEntry%> hours.\nThis is necessary because the user can only fill a minimum of <%=dblMinHoursForDAEntry%> hours in the timesheet.";
						alert(strMsg);
						setFocus(objWork);
						return true;
					}
					
					if( ( parseFloat(objWork.value) < parseFloat(<%=dblMinHoursForDAEntry%>) )||( parseFloat(objWork.value) > 24 ))
					{
						alert('Work should be in a range (<%=dblMinHoursForDAEntry%>-24) Hours.'); 
						objWork.focus();
						return true;
					}
					
					if (parseFloat(objPlannedWork.value) < parseFloat(objWork.value))
					{
						alert('You were allocated only '+objPlannedWork.value+' hour(s) to complete the task.'); 
						objWork.focus();
						return true;
					} 
				} //if (objWork.value!='')
			} //for(i=0;i<objAssignedTaskRow.value;i++)
			
			return false;
		}
	</script>

  </body>
</html>
