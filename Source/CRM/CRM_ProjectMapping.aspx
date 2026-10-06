<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_ProjectMapping.aspx.vb" Inherits="PbNIT.CRM_ProjectMapping" %>

<!DOCTYPE HTML>

<html>
<%  CommonFunctions.General.PlotPageHeadTag("HelpRequest Project Mapping")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Commented and added by Yogesh J on 17-Nov-2015*/
    #txtPageNumber {
        height:20px;
        margin-top:0px;
    }
    /*End of addition by Yogesh J on 17-Nov-2015*/
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

<body class='clsBody' onload='window_onload()' onresize='window_onresize()'>
    <form id="frmCRMProjectMapping" runat="server" method='post' >
   
   <% PageInit()%>
   
    </form>
    
    <script language="javascript">
    var CreateRowCount = 0;  
	 
    objform=GetFormReference('frmCRMProjectMapping');
	objdivlist=GetObjectReference('frmCRMProjectMapping','divPage');
	var iterator = 1;
	var IsTrue;
        IsTrue = 1;		    
	var strCustomerHTML,strProjectHTML,strDeliverableHTML;		
	if(GetObjectReference('frmCRMProjectMapping','cboCustomer1'))	  
        strCustomerHTML = GetObjectReference('frmCRMProjectMapping','cboCustomer1').innerHTML;
    if(GetObjectReference('frmCRMProjectMapping','cboProject1'))	 
        strProjectHTML = GetObjectReference('frmCRMProjectMapping','cboProject1').innerHTML;		
    if(GetObjectReference('frmCRMProjectMapping','cboDeliverable1'))	 
	    strDeliverableHTML = GetObjectReference('frmCRMProjectMapping','cboDeliverable1').innerHTML;	
	if(GetObjectReference('frmCRMProjectMapping','cboEmployee1'))	 
	    strEmployeeHTML = GetObjectReference('frmCRMProjectMapping','cboEmployee1').innerHTML;
	
	 
function window_onload()
{	
		var intDivHeight ;
		var intDivHeightRisk;
		 
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight+'px';
        //commented by nilesh g on 13/10/2015 for show height
		//objdivlist.HEIGHT = intDivHeight
		
}

function window_onresize()
{
    var intDivHeight ;
    var intDivHeightRisk;
    if (navigator.appName == 'Microsoft Internet Explorer'){
    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
    }
    else{
    intDivHeight = window.innerHeight - 42;
    }
    if (intDivHeight < 100)
	    intDivHeight = 100;
    		
    objdivlist.style.height = intDivHeight;

		 
}

function Save_OnClick()
{
 
    if(<%=SelectedOption%>  == 1)
    {
        var objcboProject = GetObjectReference('frmCRMProjectMapping','cboProject',true);
        var page = GetObjectReference('frmCRMProjectMapping','txtPageNumber').value;
        
        var ProjectIDs='';
        var EmployeeIDs='';
        
         for(i=0;i<objcboProject.length;i++)
         {
             
                ProjectIDs = ProjectIDs + objcboProject[i].value + ',';                 
                EmployeeIDs = EmployeeIDs + objcboProject[i].getAttribute('EmployeeID') + ",";
             
         }
          
      
     
        objform.action='CRM_ProjectMapping.aspx?Action=SAVE&PageNumber=' + page+'&ProjectIDs=' +ProjectIDs + '&EmployeeIDs='+EmployeeIDs;
        objform.submit();
    }
    else if(<%=SelectedOption%>  == 2)
    {
        var objTbl = GetObjectReference('frmCRMProjectMapping','CustomerDelMapping');
        
        var objcboCustomer;
        var objcboProject;
        var objcboDeliverable;
        
        var TableRows = objTbl.rows.length;
        
        for(i=1;i<= TableRows-2;i++)
        {
                  objcboCustomer = GetObjectReference('frmCRMProjectMapping','cboCustomer'+i);
                  objcboProject = GetObjectReference('frmCRMProjectMapping','cboProject'+i);
                  objcboDeliverable = GetObjectReference('frmCRMProjectMapping','cboDeliverable'+i);
                  
                  if(objcboCustomer.value != '' || objcboProject.value != '' || objcboDeliverable.value != '')
                  {
                          if(objcboCustomer.value == '')
                          {
                                alert('Please select customer');
                                setFocus(objcboCustomer);
                                return;
                          }
                          if(objcboProject.value == '') 
                          {
                                alert('Please select Project');
                                setFocus(objcboProject);
                                return;
                          }
                          if(objcboDeliverable.value == '') 
                          {
                                alert('Please select Deliverable');
                                setFocus(objcboDeliverable);
                                return;
                          }
                   }
        }
    
      var IsDuplicateRec = CheckDuplicateRecords();
         
      if(IsDuplicateRec == 1 )
      {    
          objform.action='CRM_ProjectMapping.aspx?Action=SAVECust&TableRows=' + TableRows;
          objform.submit();
      }     
      
    }
     else if(<%=SelectedOption%>  == 3)
    {
        var objTbl = GetObjectReference('frmCRMProjectMapping','EmpCustomerProjectMapping');
        
        var TableRows = objTbl.rows.length;

        objform.action='CRM_ProjectMapping.aspx?Action=SAVEEMPCUSTPRJ&TableRows=' + TableRows;
        objform.submit();
    }

}

function History_onClick(EmployeeID)
{
    window.open("../General/CommonList.aspx?MasterTagID=8040&EmployeeID="+EmployeeID,"History","resizable=yes,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=850,height=400");
}

if(GetObjectReference('frmCRMProjectMapping','hidNoOfPages'))
var noOfPages = GetObjectReference('frmCRMProjectMapping','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('frmCRMProjectMapping','txtPageNumber');
function validateNumPaging()
{

	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_OnClick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function Page_OnClick(page)
{
    objform.action = "CRM_ProjectMapping.aspx?PageNumber=" + page;
	
	objform.submit();
}
		
		function txtPageNumber_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumber =  GetObjectReference('frmCRMProjectMapping','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmCRMProjectMapping','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}	
			}
		
		}		

var ShowFilter='0';
function showFilters(show)
{
    objtblFilter = GetObjectReference('frmCRMProjectMapping','tblFilter');
    objimgFilter =GetObjectReference('frmCRMProjectMapping','imgFilter');
	img1='../../Images/cssImages/Link images/close.gif';
	img2='../../Images/cssImages/Link Images/Filter.gif';    

    if (ShowFilter=='0')
    {
    objtblFilter.style.top=30;
    objtblFilter.style.left=0;
    objtblFilter.zIndex=99;
    objtblFilter.style.display='';
    objimgFilter.src=img1;
    objimgFilter.alt='Hide filter'
    ShowFilter='1';

    }
    else if(ShowFilter=='1')
    {
    objtblFilter.style.display='none';
    objimgFilter.src=img2;
    ShowFilter='0';    
    objimgFilter.alt='Show filter' ;
    }
}
function applyFilter()
{
	objform.action = "CRM_ProjectMapping.aspx";	 
	objform.submit();
}
function ClearFilter()
{
	 
	var objEmployee=GetObjectReference('frmCRMProjectMapping','txtResource').value = '';	
	var objBG=GetObjectReference('frmCRMProjectMapping','cboBG').value = '';	
	var objOU=GetObjectReference('frmCRMProjectMapping','cboOU').value = '';	 	
	var objRole=GetObjectReference('frmCRMProjectMapping','cboRole').value = '';	
	 
	objform.action = "CRM_ProjectMapping.aspx";	 
	 
	objform.submit();
	
}
function BG_onChange()
{
 var BGID = GetObjectReference('frmCRMProjectMapping','cboBG').value;
var url;
url= "CRM_ProjectMapping.aspx?FromXML=1&From=BG&BGID=" + BGID;
loadXMLDoc(url,'');
var objOU = GetObjectReference('frmCRMProjectMapping','cboOU');
setFocus(objOU);
}
function OU_onChange()
{
var BGID = GetObjectReference('frmCRMProjectMapping','cboBG').value;
var OUID = GetObjectReference('frmCRMProjectMapping','cboOU').value;
var objDU = GetObjectReference('frmCRMProjectMapping','cboDU');
var objDT = GetObjectReference('frmCRMProjectMapping','cboDT');

var url;
if(BGID != "" && OUID=="")
{
objDT.innerHTML=""; insBlankOpt(objDT); objDU.innerHTML=""; insBlankOpt(objDU);
}
else
{
url= "CRM_ProjectMapping.aspx?FromXML=1&From=OU&OUID=" + OUID+"&BGID="+BGID;
loadXMLDoc(url,'');
var objDU = GetObjectReference('frmHRResourceCalenderView','cboDU');
setFocus(objDU);
}
}


function loadXMLDoc(url,reqQuery)	
{
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change() 
{
var strIDsAndNames,objOption,objCbo;
var objLoc=GetObjectReference('','cboOU');

if (parseInt(xmlhttp.readyState)==4) { if (xmlhttp.status==200){
strIDsAndNames = xmlhttp.responseText.split("$___#");
if(strIDsAndNames[0] == "BG")
{ objCbo=objLoc;}

objCbo.innerHTML = "";
insBlankOpt(objCbo);
for(var i = 1;i<strIDsAndNames.length-1;i=i+2)
{ objOption = new Option();
 objOption.text =  strIDsAndNames[i+1];
 objOption.value = strIDsAndNames[i];
 if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
 objCbo.add(objOption);
 else
 objCbo.add(objOption,null);
}}}}

function insBlankOpt(objCbo)
{
objOption = new Option();
      objOption.text =  "";
      objOption.value = "";

if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
       objCbo.add(objOption);
      else
       objCbo.add(objOption,null);
}

 
function createNewRow(From)
{
    
    CreateRowCount = parseInt(CreateRowCount) + 1;
    
	var ctrlRole;
	if(From==2)
	{
	    var objTbl = GetObjectReference('frmCRMProjectMapping','CustomerDelMapping');
	}
	else if(From==3)
	{
	    var objTbl = GetObjectReference('frmCRMProjectMapping','EmpCustomerProjectMapping');
	}
	
    var Cnt;
    
    var ControlID
			
	ControlID = objTbl.rows.length - 2;	 	 
	  
	   
	NewTR = objTbl.insertRow(CreateRowCount + 1)
	NewTR.className = objTbl.rows[1].className;
	 
	Cnt = objTbl.rows.length - 2;
	
	NewTD = NewTR.insertCell(0);
	NewTD.align='left';
	NewTD.innerHTML = "<IMG BORDER=0 src='../../images/delete.gif' onclick = 'deleteRow(this,"+Cnt+","+From+")'>" ;//+ startImgHTML;
	
	if(From==2)
	{
	    NewTD = NewTR.insertCell(1);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboCustomer" +Cnt + " name=cboCustomer"+Cnt+" class=clsComboBox style='width:200px ' onchange=cboCustomer_onChange("+Cnt+")  >" + strCustomerHTML + "</SELECT>" ;//+ startImgHTML;
    	
	    NewTD = NewTR.insertCell(2);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboProject"+Cnt+" name=cboProject"+Cnt+" class=clsComboBox style='width:200px ' onchange=cboProject_onChange("+Cnt+")   >" + strProjectHTML + "</SELECT>";// + startImgHTML;
    	
	    NewTD = NewTR.insertCell(3);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboDeliverable"+Cnt+" name=cboDeliverable"+Cnt+" class=clsComboBox style='width:220px ' onchange=cboDeliverable_onChange("+Cnt+") >" + strDeliverableHTML + "</SELECT>";// + startImgHTML;
    	
	    NewTD = NewTR.insertCell(4);
	    NewTD.align='center';
	    NewTD.innerHTML = "<label id='Deldate"+Cnt+"' name='Deldate"+Cnt+"' >&nbsp;</label>" ;//+ startImgHTML;	
	}
	else if(From==3)
	{  
	    NewTD = NewTR.insertCell(1);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboEmployee"+Cnt+" name=cboEmployee"+Cnt+" class=clsComboBox style='width:220px ' onchange=cboEmployee_onChange("+Cnt+")  >" + strEmployeeHTML + "</SELECT>";// + startImgHTML;
    	    	
	    NewTD = NewTR.insertCell(2);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboCustomer" +Cnt + " name=cboCustomer"+Cnt+" class=clsComboBox style='width:200px '    >" + strCustomerHTML + "</SELECT>" ;//+ startImgHTML;
    	
	    NewTD = NewTR.insertCell(3);
	    NewTD.align='center';
	    NewTD.innerHTML = "<SELECT id=cboProject"+Cnt+" name=cboProject"+Cnt+" class=clsComboBox style='width:200px '   >" + strProjectHTML + "</SELECT>";// + startImgHTML;
    	
	}
	 
}

function deleteRow(objImg, rowID,From)
{   
			 
			if(From==2)
	        {
	            var objTbl = GetObjectReference('frmCRMProjectMapping','CustomerDelMapping');
	        }
	        else if(From==3)
	        {
	            var objTbl = GetObjectReference('frmCRMProjectMapping','EmpCustomerProjectMapping');
	        }
	
			var rowNo=objImg.parentElement.parentElement.rowIndex
			
			objTbl.deleteRow(rowNo);
		 
			
}
		
function cboProject_onChange(IDIndex)
{    
     
   var objcboProject = GetObjectReference('frmCRMProjectMapping','cboProject'+IDIndex);   
   
    url= "CRM_ProjectMapping.aspx?FromXML=1&From=ProjectChange&ProjectID=" + objcboProject.value;
    loadXMLDoc1(url,'',IDIndex);
   
}
function cboCustomer_onChange(CustIDIndex)
{
    var objcboCustomer = GetObjectReference('frmCRMProjectMapping','cboCustomer'+CustIDIndex);   
   
    url= "CRM_ProjectMapping.aspx?FromXML=1&From=CustomerChange&CustomerID=" + objcboCustomer.value;
    loadXMLDoc1(url,'',CustIDIndex);
}
function cboDeliverable_onChange(DelIDIndex)
{
    var objcboDeliverable = GetObjectReference('frmCRMProjectMapping','cboDeliverable'+DelIDIndex);   
   
    url= "CRM_ProjectMapping.aspx?FromXML=1&From=DeliverableChange&DeliverableID=" + objcboDeliverable.value;
    loadXMLDoc1(url,'',DelIDIndex);
}
function cboEmployee_onChange(EmpIDIndex)
{    
    var objcboEmployee = GetObjectReference('frmCRMProjectMapping','cboEmployee'+EmpIDIndex);   
    
    url= "CRM_ProjectMapping.aspx?FromXML=1&From=EmployeeChange&EmployeeID=" + objcboEmployee.value;
    loadXMLDoc1(url,'',EmpIDIndex);
}

function loadXMLDoc1(url,reqQuery,IDIndex)	
{  
    iterator = IDIndex;
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change1;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change1;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change1()
{     
    var strIDsAndNames,objOption,objCbo;

    if (parseInt(xmlhttp.readyState)==4) { if (xmlhttp.status==200)
    {
        strIDsAndNames = xmlhttp.responseText.split("$___#");     

        if(strIDsAndNames[0] == "Project")
        { 
            var objCbo=GetObjectReference('','cboDeliverable'+iterator);    
        }
        if(strIDsAndNames[0] == "Customer")
        { 
            var objCbo=GetObjectReference('','cboProject'+iterator);    
        }
        
        if(strIDsAndNames[0] == "Deliverable")
        { 
            var objDate=GetObjectReference('','Deldate'+iterator);  
            var strFromDate = strIDsAndNames[1];
            var strToDate = strIDsAndNames[2];
          
            if(typeof(strFromDate) == "undefined")
            {   
                strFromDate = "-";
            }
            if(typeof(strToDate) == "undefined")
            {
                strToDate = "-";
            }
            if(strFromDate == "-" && strToDate == "-")
            {
                objDate.innerHTML = "-" ;
            }
            else
            {
                 objDate.innerHTML = strFromDate + " To " + strToDate;
            }
            
        }
        else if(strIDsAndNames[0] == "DuplicateRecord")
        {            
           
            if(strIDsAndNames[1] != '')
            {
                 alert('Following record is already present : \n'+strIDsAndNames[1]);
                  IsTrue = 0;
                   return ;
            }
            else
            {
                IsTrue = 1;
            }
           
        }
        else
        { 

            objCbo.innerHTML = "";
            insBlankOpt(objCbo);
            
            for(var i = 1;i<strIDsAndNames.length-1;i=i+2)
            { objOption = new Option();
             objOption.text =  strIDsAndNames[i+1];
             objOption.value = strIDsAndNames[i];
             if(navigator.appName.toUpperCase() == 'MICROSOFT INTERNET EXPLORER')
             objCbo.add(objOption);
             else
             objCbo.add(objOption,null);
            }
        }
    }}
} 

function OptEmpCust_OnChange(v)
{
    objform.action = "CRM_ProjectMapping.aspx?SelectedOption="+v;
	objform.submit();    
}
function CheckDuplicateRecords()
{
    
    
    var objTbl = GetObjectReference('frmCRMProjectMapping','CustomerDelMapping');
        
        var objcboCustomer;
        var objcboProject;
        var objcboDeliverable;
        var objPK;
        
        var CustomerIDs = '';
        var ProjectIDs = '';
        var DeliverableIDs = '';
        var PK = '';
        
        var TableRows = objTbl.rows.length;
        
        for(i=1 ;i<= TableRows-2;i++)
        {
                  objcboCustomer = GetObjectReference('frmCRMProjectMapping','cboCustomer'+i);
                  objcboProject = GetObjectReference('frmCRMProjectMapping','cboProject'+i);
                  objcboDeliverable = GetObjectReference('frmCRMProjectMapping','cboDeliverable'+i);
                  objPK = GetObjectReference('frmCRMProjectMapping','PK'+i );
                                    
                  CustomerIDs = CustomerIDs + objcboCustomer.value + ',';
                  ProjectIDs = ProjectIDs + objcboProject.value + ',';
                  DeliverableIDs = DeliverableIDs + objcboDeliverable.value + ',';
                  if(objPK)
                  {
                    PK = PK + objPK.value + ',';
                  }
                  else
                  {
                    PK = PK + ',';
                  }
        }
    
    /*alert(CustomerIDs);
     alert(ProjectIDs);
      alert(DeliverableIDs);
    alert(PK);
     */
     
    url= "CRM_ProjectMapping.aspx?FromXML=1&From=DuplicateCheck&CustomerIDs="+CustomerIDs+"&ProjectIDs="+ProjectIDs+"&DeliverableIDs="+DeliverableIDs + "&PK=" + PK;
    loadXMLDoc1(url,''  );
    
    if(IsTrue == 0)
    {
        return 0;
    }
    else
    {
        return 1;
    }
    
}

function DeleteReocrds()
{    
    objform.action = "CRM_ProjectMapping.aspx?Action=DELETE";
	objform.submit();   
}

    </script>
    
</body>
</html>
