<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_ResourceCalendarView.aspx.vb" Inherits="PbNIT.HR_ResourceCalendarView" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<%--Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<%--<script src="../../responsive/jquery/jquery-2.1.3.min.js" type="text/javascript"></script>--%>
<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--End of Commented And Added By Rutuja D. on 14th Dec 2020 For Jquery Change Version 3.5.1--%>
<HTML>
	<!--<title>Resource Calender View</title>-->

	<%CommonFunctions.General.PlotPageHeadTag("Resource Calender View")%>
    

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmHRResourceCalenderView" method="post" runat="server">
			<%DrawPage()%>
		</form>
        <%-- ADDED BY Puneet M ON 19-11-2015 --%>
        <style>
            .clsTable td
            {
                vertical-align: middle !important;
            }

            #txtMonth
            {
                margin-top: 0px;
            }

            #txtYear
            {
                margin-top: 0px;
            }
            /*Added by Nilesh g on 5/12/2015 for issue id 2629*/
            table
            {
                width: 100% !important;
            }

            #divContainer a
            {
                cursor: pointer;
            }
     /*Added by swapnil a on 22/12/2015 for issue id 2753*/
            u
            {
                cursor: pointer;
            }
			/* Added By Gauri On 29th Aug 2024 For Alignment Issue */
			#tblHeader .clsTRPageCaption td{
				border: 1px solid #d3d3d3;
				font-weight: 500;
			}
			#tblHeader .clsTREven td{
				border: 1px solid #bbb;
			}
			/* End of Added By Gauri On 29th Aug 2024 For Alignment Issue */
        </style>
        <%-- ENDED BY Puneet M ON 19-11-2015 --%>
		<script language="javascript">
					var ProjectStartDate = "<%=ProjectStartDate%>";
					var ProjectEndDate = "<%=ProjectEndDate%>";
					objform = GetFormReference('frmHRResourceCalenderView');
					
					
	var objResourcePool=GetObjectReference('frmHRResourceCalenderView','cboResourcePool');
	var noOfPages;
	
	if(GetObjectReference('frmHRResourceCalenderView','hidNoOfPages')!=null)
	    noOfPages = GetObjectReference('frmHRResourceCalenderView','hidNoOfPages').value;
	 
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	
	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
					
	function NextMonth_clicked()
	{		
		 
		var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource').value;		
		var EmployeeID=objEmployee.value;	
		var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value;	
		var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value;	
		var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU').value;	
		var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT').value;	
		var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType').value;	
		var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment').value;	
		var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value;	
		var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value;	
		var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value;		
		var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		
		var tempYear =<%=m_CurrYear%>;
		var tempMonth =objtxtMonth.value;	
		
		
		 
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
		//window.location.href = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+1%>"+ "&Year=" + "<%=m_intYear%>"+ "&employeeid=" + objEmployee.value   
    if(objtxtpageNumber!=null)		
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+1%>" + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + "<%=m_intYear%>";  
	else
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+1%>" + "&PageNumber=&Year=" + "<%=m_intYear%>";  
	    
	enableAllControls();
	objform.submit();
	}
	
	
	function PreviousMonth_clicked()
	{try
	 {
		var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource');
		var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value;	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value;	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU').value;	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT').value;	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType').value;	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment').value;	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value;	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value;	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value;		
		var EmployeeID=objEmployee.value;
		
		var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
		var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		var tempYear =<%=m_CurrYear%>;
		var tempMonth =objtxtMonth.value;
	
	
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}			
					
			if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
		if(<%=m_intMonth%>!=1)
		{			
			//window.location.href = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth-1%>"+ "&Year=" + "<%=m_intYear%>"+ "&Employeeid=" + objEmployee.value   
			 if(objtxtpageNumber!=null)	
			    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth-1%>" + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + "<%=m_intYear%>";  
			 else
			    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth-1%>" + "&PageNumber=&Year=" + "<%=m_intYear%>";     
			enableAllControls();
			objform.submit();
		}
		else{
			//window.location.href = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+11%>"+ "&Year=" + "<%=m_intYear-1%>"+ "&employeeid=" + objEmployee.value   
			if(objtxtpageNumber!=null)	
			    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+11%>" + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + "<%=m_intYear-1%>";  
			else
			    objform.action = "HR_ResourceCalendarView.aspx?Month=" + "<%=m_intMonth+11%>" + "&PageNumber=&Year=" + "<%=m_intYear-1%>";  
			    
			enableAllControls();
			objform.submit();
	
		}
	 }
	 catch(ex){}
	}
	
function Year_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmHRResourceCalenderView','cboOrganizationUnit');	
	var objYear=GetObjectReference('frmHRResourceCalenderView','cboYear');
	var objMonth=GetObjectReference('frmHRResourceCalenderView','cboMonth');
	var objtxtOrganizationUnit=GetObjectReference('frmHRResourceCalenderView','txtOrganizationUnit');	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;	
	var OrganizationUnitID=objOrganizationUnit.value;	
	var Year=objYear.value;
	var MonthID=objMonth.value;
	window.location.href = "HR_ResourceCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + MonthID + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID 

}
var ShowFilter='0';
function showFilters(show)
{
    objtblFilter = GetObjectReference('FrmScoreCardReview','tblFilter');
    objimgFilter =GetObjectReference('FrmScoreCardReview','imgFilter');
	img1='../../Images/cssImages/Link images/close.gif';
	img2='../../Images/cssImages/Link Images/Filter.gif';    

    if (ShowFilter=='0')
    {
    objtblFilter.style.top=40;
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
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource').value;	
	
	var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value;	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value;	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU').value;	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT').value;	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType').value;	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment').value;	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value;	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value;	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value;		
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
	var Year=objtxtYear.value;
	var MonthID=objtxtMonth.value;
	
	var tempMonth =objtxtMonth.value;
	
	if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			showFilters(0);
			return;
		}
		
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
	if(objtxtpageNumber!=null)
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + MonthID + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + Year;  
	else
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + MonthID + "&PageNumber=&Year=" + Year;  
	        
	enableAllControls();
	objform.submit();
}

function ClearFilter()
{
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource').value = '';	
	var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value = '';	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value = '';	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU').value = '';	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT').value = '';	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType').value = '';	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment').value = '';	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value = '';	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value = '';	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value = '';		
	var objDeployable=GetObjectReference('frmHRResourceCalenderView','cboDeployable').value = '';
	
	var objResourcePool=GetObjectReference('frmHRResourceCalenderView','cboResourcePool')
	
	if(objResourcePool.disabled == false)
	objResourcePool.value = '';	
	
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
	var Year=objtxtYear.value;
	var MonthID=objtxtMonth.value;
	
	var tempMonth =objtxtMonth.value;
	
	if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			showFilters(0);
			return;
		}
		
		 if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
			
	if(objtxtpageNumber!=null)
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + MonthID + "&PageNumber=" + objtxtpageNumber.value + "&Year=" + Year;  
	else
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + MonthID + "&PageNumber=&Year=" + Year;  
	        
	enableAllControls();
	objform.submit();
	
}
function BG_onChange()
{
 var BGID = GetObjectReference('frmHRResourceCalenderView','cboBG').value;
var url;
url= "HR_ResourceCalendarView.aspx?FromXML=1&From=BG&BGID=" + BGID;
loadXMLDoc(url,'');
var objOU = GetObjectReference('frmHRResourceCalenderView','cboOU');
setFocus(objOU);
}
function OU_onChange()
{
var BGID = GetObjectReference('frmHRResourceCalenderView','cboBG').value;
var OUID = GetObjectReference('frmHRResourceCalenderView','cboOU').value;
var objDU = GetObjectReference('frmHRResourceCalenderView','cboDU');
var objDT = GetObjectReference('frmHRResourceCalenderView','cboDT');

var url;
if(BGID != "" && OUID=="")
{
objDT.innerHTML=""; insBlankOpt(objDT); objDU.innerHTML=""; insBlankOpt(objDU);
}
else
{
url= "HR_ResourceCalendarView.aspx?FromXML=1&From=OU&OUID=" + OUID+"&BGID="+BGID;
loadXMLDoc(url,'');
var objDU = GetObjectReference('frmHRResourceCalenderView','cboDU');
setFocus(objDU);
}
}

function DU_onChange()
{
var BGID = GetObjectReference('frmHRResourceCalenderView','cboBG').value;
var OUID = GetObjectReference('frmHRResourceCalenderView','cboOU').value;
var DUID = GetObjectReference('frmHRResourceCalenderView','cboDU').value;
var objDT = GetObjectReference('frmHRResourceCalenderView','cboDT');
var url;

if( (BGID != "" || OUID !== "") && DUID=="")
{
objDT.innerHTML=""; insBlankOpt(objDT);
}
else
{
	url= "HR_ResourceCalendarView.aspx?FromXML=1&From=DU&DUID=" + DUID+"&BGID="+BGID+"&OUID="+OUID;
	loadXMLDoc(url,'');
	var objDT = GetObjectReference('frmHRResourceCalenderView','cboDT');
	setFocus(objDT);
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
var objDU=GetObjectReference('','cboDU');
var objDT=GetObjectReference('','cboDT');

if (parseInt(xmlhttp.readyState)==4) { if (xmlhttp.status==200){
strIDsAndNames = xmlhttp.responseText.split("$___#");
if(strIDsAndNames[0] == "BG")
{ objCbo=objLoc; objDU.innerHTML=""; insBlankOpt(objDU); objDT.innerHTML = ""; insBlankOpt(objDT); }
else if(strIDsAndNames[0] == "OU")
{ objCbo=objDU; objDT.innerHTML = ""; insBlankOpt(objDT); }
else if(strIDsAndNames[0] == "DU")
objCbo=objDT;
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

function Month_OnClick(intMonth,intYear)
{
	var objOrganizationUnit=GetObjectReference('frmHRResourceCalenderView','cboOrganizationUnit');	
	var objYear=GetObjectReference('frmHRResourceCalenderView','cboYear');
	var objMonth=GetObjectReference('frmHRResourceCalenderView','cboMonth');
	var objtxtOrganizationUnit=GetObjectReference('frmHRResourceCalenderView','txtOrganizationUnit');	
	var txtOrganizationUnitID= objtxtOrganizationUnit.value;	
	var OrganizationUnitID=objOrganizationUnit.value;
	
	var Year=objYear.value;
	var Month=objMonth.value;
	window.location.href = "HR_ResourceCalendarView.aspx?OrganizationUnitID=" + OrganizationUnitID + "&Month=" + Month + "&Year=" + Year+ "&txtOrganizationUnit="+txtOrganizationUnitID 
}


function Show_clicked()
{	
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
	var ObjcboEmployee = GetObjectReference('frmHRResourceCalenderView','txtResource');	
	var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value;	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value;	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU').value;	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT').value;	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType').value;	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment').value;	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value;	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value;	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value;		
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;
	var preYear =tempYear-1; 
	 
	if (isBlank(Trim(tempMonth))==true)
	{
		alert("'Month' can not be blank !")
		objtxtMonth.focus();
		return;
	}
		
	if (isBlank(Trim(objtxtYear.value))==true)
	{
		alert("'Year' can not be blank !")
		objtxtYear.focus();
		return;
	}
		

	if(Trim(objtxtYear.value)<= 0)
	{
		alert("Please Enter Valid Year ")
		objtxtYear.focus();
		return;
	} 
	if(Trim(tempMonth)<=0 ||Trim(tempMonth)>12 )
	{
		alert("Please enter value between '1-12' for month !")
		objtxtMonth.focus();
		return;
	}
	
	var Year=Trim(objtxtYear.value);
	var Month=Trim(objtxtMonth.value);
	
	if(isInteger(Month)==false)
	{
		alert("Please enter only numeric value for 'Month'!");
		objtxtMonth.focus();
		return;
	}
	if(isInteger(Year)==false )
	{
		alert("Please enter only numeric value for 'Year'!");
		objtxtYear.focus();
		return;
	}
	 
		Year = Number(Year);		 
		Year = String(Year);	 
		
	if(Year.length < 4)
	{
		var NewYear = String(tempYear).substring(0,4-Year.length) + Year ;
		
		Year = NewYear ;
	}
	 
	  if (parseInt(objtxtYear.value) < 1760)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
	
	//window.location.href = "HR_ResourceCalendarView.aspx?Month=" + Month + "&Year=" + Year+ "&employeeid=" + ObjcboEmployee.value   
	if(objtxtpageNumber!=null)
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + Month + "&PageNumber=" + objtxtpageNumber.value  + "&Year=" + Year;  
	else
	    objform.action = "HR_ResourceCalendarView.aspx?Month=" + Month + "&PageNumber=&Year=" + Year;  
	        
	enableAllControls();
	objform.submit();
	
}
 
		 //   var objdivlist=GetObjectReference('frmHRResourceCalenderView','divContainer');
		    var objdivlist=GetObjectReference('frmHRResourceCalenderView','divPage');

		    //Added by Dhanashri S on 7 Dec 2015 For IssueID : 2030
		    var objdivContainer = GetObjectReference('frmHRResourceCalenderView', 'divContainer');
		    //End of Addition by Dhanashri S on 7 Dec 2015
		    
	
		function window_onload()
		    {
		 
			//commented and added by nilesh g
			//var intDivHeight ;
			//var intDivHeightRisk;
			//if (objdivlist !=null) {
			//    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			//}
			//if (intDivHeight < 100)	intDivHeight = 100;
			//intDivHeight = 100;
		    //objdivlist.style.height = intDivHeight+'px';
		    var intDivHeight ;
		    var intDivHeightRisk;
		   //Commented and added by Yogesh J on 27-NOV-2015
		    //   if (navigator.appName == 'Microsoft Internet Explorer')
		    if (objdivlist !=null)
		    {
		        if(WhichBrowser() == 'IE')
		        {
		          
		            // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
		            intDivHeight = window.innerHeight - objdivlist.offsetTop-4;
		          
		            //End of addition by Yogesh J on 27-NOV-2015
		        }
		       else if(WhichBrowser() == 'FF')
		        {
		          
		            // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
		           intDivHeight = window.innerHeight - objdivlist.offsetTop-6;
		           
		            //End of addition by Yogesh J on 27-NOV-2015
		        }
		        else if(WhichBrowser() == 'CR')
		        {
		            intDivHeight = window.innerHeight - objdivlist.offsetTop-4 ;
		        
		        }
		        else{
		        
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 31;
		        }
		        if (intDivHeight < 100)
		            intDivHeight = 100;
		        objdivlist.style.height = intDivHeight+'px';
		    }
		  
		    if(objdivContainer !=null)
		        //Added by Dhanashri S on 7 Dec 2015 For IssueID : 2030
		        if(WhichBrowser() == 'IE')
		        {
		          
		            // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
		            intDivHeight = window.innerHeight - objdivContainer.offsetTop-28;
		           
		            //End of addition by Yogesh J on 27-NOV-2015
		        }
		        else if(WhichBrowser() == 'FF')
		        {
		          
		            // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
		            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
		            //End of addition by Yogesh J on 27-NOV-2015
		        }
		        else if(WhichBrowser() == 'CR')
		        {
		            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
		        }
		        else{
		        
		            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
		        }
            if (intDivHeight < 100)
                intDivHeight = 100;
            objdivContainer.style.height  = intDivHeight+'px';
		   // objdivContainer.style.height = intDivHeight - 120 + 'px';
		    //End of Addition by Dhanashri S on 7 Dec 2015
		    
     
			//CallOnLoadForTW()
			
			//CallOnLoad() 
		
		}
            //Added by Yogesh J on 27-NOV-2015
			
		

            //End of addition by Yogesh J on 27-NOV-2015
		function window_onresize()		
		{
		 
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) 

			{  //Commented and added by Yogesh J on 27-NOV-2015
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30 ;
			    if (objdivlist !=null)
			    {
			        if(WhichBrowser() == 'IE')
			        {
		          
			            // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			            intDivHeight = window.innerHeight - objdivlist.offsetTop-4;
			            
			            //End of addition by Yogesh J on 27-NOV-2015
			        }
			        else if(WhichBrowser() == 'FF')
			        {
			  
			            intDivHeight = window.innerHeight - objdivlist.offsetTop-6;
			          
			        }
			        else if(WhichBrowser() == 'CR')
			        {
			            intDivHeight = window.innerHeight - objdivlist.offsetTop-4;
			          
			        }
			        else{
			            intDivHeight = window.innerHeight - objdivlist.offsetTop - 31;
			        }
			        if (intDivHeight < 100)	intDivHeight = 100;
			        objdivlist.style.height = intDivHeight +'px';	
			    }
			    //End of addition by Yogesh J on 27-NOV-2015
			}

			if(objdivContainer !=null)
			    //Added by Dhanashri S on 7 Dec 2015 For IssueID : 2030
			    if(WhichBrowser() == 'IE')
			    {
		          
			        // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			        intDivHeight = window.innerHeight - objdivContainer.offsetTop-28;
			        
			        //End of addition by Yogesh J on 27-NOV-2015
			    }
			    else if(WhichBrowser() == 'FF')
			    {
		          
			        // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 30;
			        intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
			        //End of addition by Yogesh J on 27-NOV-2015
			    }
			    else if(WhichBrowser() == 'CR')
			    {
			        intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
			    }
			    else{
		        
			        intDivHeight = window.innerHeight - objdivContainer.offsetTop - 31;
			    }
			if (intDivHeight < 100)
			    intDivHeight = 100;
			objdivContainer.style.height  = intDivHeight+'px';
			 
		}	
		
		function WhichBrowser() {

		    var brwser = '';
		    var ua = navigator.userAgent, tem,
            M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
		    if (/trident/i.test(M[1])) {
		        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
		        //return 'IE '+(tem[1] || '');
		        return 'IE';
		    }
		    if (M[1] === 'Chrome') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'CR';
		    }
		    else if (M[1] === 'Firefox') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'FF';
		    }
		    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
		    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
		    //return M.join(' ');
		    return brwser;
		}
		 
 
	function CallOnLoad()
			{	
			
			 
				var xl = tblHeader.offsetLeft;				
				var yt = tblHeader.offsetTop;				
				var tl = tblHeader;
				while (tl.tagName != "BODY") 
						{
							tl = tl.offsetParent;
							xl = xl + tl.offsetLeft;
							yt = yt + tl.offsetTop;
						}
				
								var headerTableRow = tblHDF.rows[0];						 			
								var originalTableRow = tblHeader.rows[0];									 
								headerTableRow.height =originalTableRow.offsetHeight;
							for (var i = 0; i < 1; i++) 
							{
								var O_Width = originalTableRow.cells[i].offsetWidth;
								var O_Height = originalTableRow.cells[i].offsetHeight;
								var In_HTML = originalTableRow.cells[i].innerHTML;							
												
								headerTableRow.cells[i].width = O_Width; 
								headerTableRow.cells[i].height = O_Height; 
								headerTableRow.cells[i].innerHTML = In_HTML; 
								headerTableRow.cells[i].align = 'center';
							}			
														   
										
								//divList.style.width = tblList.offsetWidth + 20 + 'px';
								tblHDF.style.left =xl; 
								tblHDF.style.top = yt ; //176
								tblHDF.style.position = 'absolute';
								tblHDF.style.display="block";
								
				
			}
			
		function LoadHrsDetails(intEmployeeID,strStartDate,strEndDate)
		{			
		    //Commented and added by Yogesh J on 05-Feb-2016 to generate Token
		   // window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		  
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'HR_ResourceCalendarView.aspx/GenrateURLToken_LoadHrsDetails_OnClick',
		        data: JSON.stringify({ EmployeeID: intEmployeeID, StartDate: strStartDate, EndDate: strEndDate }),
			        success: function (Result) {   
			            //window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate +"&Token="+Result.d , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			            window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate +"&PkToken="+Result.d , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

			        },
			        error: function () {
			           //  alert("Error")
			        }
			    });
		    //End of addition by Yogesh J on 05-Feb-2016 to generate Token
			 	
		}		
		
				
		function Close_OnClick()
		{
			window.close();
			
		}		
		
		/*var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmHRResourceCalenderView','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
		}*/


 
function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
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
				var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmHRResourceCalenderView','txtNoOfPages');
				
				var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	            var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');				
				var tempYear =<%=m_CurrYear%>;
	            var tempMonth =objtxtMonth.value;	
            		
            	 
				//if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				if (!disallowBlank(objtxtpageNumber,"Please Enter Page Number.",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number must be Numeric.",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number must be Positive.",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number must be Integer.",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page number is not valid.");
						return;
					}   		
            		 
		            if( tempMonth<=0 ||tempMonth>12 )
		            {
			            alert("Please enter value between '1-12' for month !")
			            objtxtMonth.focus();
			            return;
		            }
            		
		            if( tempMonth==12)
		            {
			             if (objtxtYear.value==9999)
			             {
				            alert("Operation not Allowed !");
				            objtxtMonth.focus();
				            return;
			            }
		            }	
		            
					Page_OnClick(objtxtpageNumber.value);
				}
			}
		
		}
		function Page_OnClick(page)
		{
				
				var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource').value;	
				var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG').value;	
				var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU').value;	
				var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole').value;	
				var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation').value;	
				var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill').value;		
				var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
				var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
				var Year=objtxtYear.value;
				var MonthID=objtxtMonth.value;
				var EmployeeID=objEmployee.value;
	
	            //var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	            //var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
            		
	            var tempYear =<%=m_CurrYear%>;
	            var tempMonth =objtxtMonth.value;	
            		
            		
            		 
		            if( tempMonth<=0 ||tempMonth>12 )
		            {
			            alert("Please enter value between '1-12' for month !")
			            objtxtMonth.focus();
			            return;
		            }
            		
		            if( tempMonth==12)
		            {
			             if (objtxtYear.value==9999)
			             {
				            alert("Operation not Allowed !");
				            objtxtMonth.focus();
				            return;
			            }
		            }	
		
				objform.action = "HR_ResourceCalendarView.aspx?Month=" + MonthID + "&PageNumber=" +page + "&Year=" + Year;  
				enableAllControls();
				objform.submit();
		}
		

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
    var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;	
		
		
		 
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
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
    var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;	
		
		
		 
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
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
	var noOfPages = GetObjectReference('frmHRResourceCalenderView','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;	
		
		
		 
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
		
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
	var noOfPages = GetObjectReference('frmHRResourceCalenderView','hidNoOfPages').value;
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');
		
	var tempYear =<%=m_CurrYear%>;
	var tempMonth =objtxtMonth.value;	
		
		
		 
		if( tempMonth<=0 ||tempMonth>12 )
		{
			alert("Please enter value between '1-12' for month !")
			objtxtMonth.focus();
			return;
		}
		
		if( tempMonth==12)
		{
			 if (objtxtYear.value==9999)
			 {
				alert("Operation not Allowed !");
				objtxtMonth.focus();
				return;
			}
		}	
		
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
		var objTDRolledNow;
		var objContextMenu;
		document.onmouseup=function()
		{
			objContextMenu = GetObjectReference('frmHRResourceCalenderView','divContextMenu');
			if(objContextMenu){objContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
			objdivLegendsContextMenu = GetObjectReference('frmHRResourceCalenderView','divLegendsContextMenu');
			if(objdivLegendsContextMenu){objdivLegendsContextMenu.style.visibility = 'hidden';}
			if(objTDRolledNow){objTDRolledNow.className = '';}
			
		}
		
		
function ShowContextMenu(ev,obj,blnSendMail,intEmployeeID,strStartDate,strEndDate,PkToken)
{//debugger;
 var LoginUser = "<%=session("intUserID")%>" ;	
			
	if(obj)
	{
		objTDRolledNow=obj;obj.className='clsTDRolledOver';
	}
	var objContextMenu = GetObjectReference('frmHRResourceCalenderView','divContextMenu');
	 
	var mousePosition = getMousePosition(ev,objContextMenu);
	 
	objContextMenu.style.visibility= 'visible';
	objContextMenu.style.position = 'absolute';
	//Commented And Added By Vaijat K ON 09/12/2015 Issue ID-2677
	//objContextMenu.style.left = mousePosition.x;
    //objContextMenu.style.top = mousePosition.y;
	if (WhichBrowser() !="FF"){
	    objContextMenu.style.left = event.pageX + 'px';
	    objContextMenu.style.top = event.pageY + 'px';
	}
	else{
	    //var e = (window.event) ? window.event : evt;
	    objContextMenu.style.left = ev.pageX + 'px';
	    objContextMenu.style.top = ev.pageY + 'px';
	}
    //Ended
	var strHref='../SM/PB_ModifyAccess.aspx';


	var objSendMail = GetObjectReference('frmHRResourceCalenderView','tdSendMail');
	
			if(objSendMail)
			{
				objSendMail.onclick=function()
				{		
						
						if(blnSendMail == 1) 
						{		 
							window.open("../General/SendEmail.aspx?MessageID=489&StartDate='" + strStartDate + "'&EmployeeID=" + intEmployeeID + "&LoginUser=" + LoginUser ,"","resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
						}
						
						else
						{
							alert('All Daily Activities are filled for this Month');
				}
			}
	}
var objTrMenuHR = GetObjectReference('frmHRResourceCalenderView','trMenuHR');
	if(objTrMenuHR){objTrMenuHR.className='Menu_Hr';}
	var objShowTasks = GetObjectReference('frmResourceCalenderView','tdShowTasks');
	var objProjectAllocation = GetObjectReference('frmResourceCalenderView','tdProjectAllocation');
	var objLeaveDetails = GetObjectReference('frmResourceCalenderView','tdLeavDetails');
	var objSkillView = GetObjectReference('frmResourceCalenderView','tdSkillView');
	var objResUtilization = GetObjectReference('frmResourceCalenderView','tdResourceUtilization');
	
	
	objShowTasks.onclick=function()
	{
	    //window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&FromDate=" + strStartDate + "&ToDate=" + strEndDate , "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

	    //Added by Dhanashri S on 28 Mar 2016 Purpose: To generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'HR_ResourceCalendarView.aspx/GenrateTaskToken',
	        data: JSON.stringify({ EmployeeID: intEmployeeID , FromDate: strStartDate, ToDate: strEndDate  }),
		    success: function (Result) {
		        //window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&PKTaskToken="+ Result.d +"&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		        window.open("../HR/HR_ResourceCalendarDetails.aspx?EmployeeID=" + intEmployeeID + "&PkToken="+ Result.d +"&FromDate=" + strStartDate + "&ToDate=" + strEndDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

		    },
		    error: function () {
		         //alert("Error")
		    }
		});
	   
	    //End of addition by Dhanashri S on 28 Mar 2016
	}
	
	objProjectAllocation.onclick=function()
	{
		window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3902&EmployeeID=" + intEmployeeID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	
	objLeaveDetails.onclick=function()
	{
		window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3906&EmployeeID=" + intEmployeeID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");
	}
	
	//tdResourceAllocation
	objSkillView.onclick=function()
	{
		//window.open("../General/CommonList.aspx?MasterTagID=3910&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		window.open("../HR/HR_RCV_Popups_CommonList.aspx?MasterTagID=3910&EmployeeID=" + intEmployeeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	//tdResourceUtilization
	objResUtilization.onclick=function()
	{
	    //window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&ResourceID=" + intEmployeeID + "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");

	    //Added by Dhanashri S on 28 Mar 2016 Purpose: To generate and validate Token
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'HR_ResourceCalendarView.aspx/GenrateResUtilToken',
	        data: JSON.stringify({ EmployeeID: intEmployeeID }),
	        success: function (Result) {
                //Commented and Added by Dhanashri S on 11 Aug 2016
	            //window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&ResourceID=" + intEmployeeID + "&PKResUtilToken="+ Result.d+ "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	            window.open("../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FromWhere=RCV&ResourceID=" + intEmployeeID + "&PkToken="+ Result.d+ "&Mode=DisplayDetails&BUID=NULL&OUID=NULL&DUID=NULL&FilterID=NULL&DateRangeID=3&Flag=FromCalender", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
                //End of Comment and Addition by Dhanashri S on 11 Aug 2016
	        },
	        error: function () {
	           // alert("Error")
	        }
	    });
	   
	    //End of addition by Dhanashri S on 28 Mar 2016
		
	}
	
}
 
function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}

function enableAllControls()
{
	objResourcePool.disabled=false;
}

function ProjectAllocation_clicked(FromDate,ToDate)
{
 
	var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
	var objEmployee=GetObjectReference('frmHRResourceCalenderView','txtResource') ;	
	var objBG=GetObjectReference('frmHRResourceCalenderView','cboBG') ;	
	var objOU=GetObjectReference('frmHRResourceCalenderView','cboOU') ;	
	var objDU=GetObjectReference('frmHRResourceCalenderView','cboDU') ;	
	var objDT=GetObjectReference('frmHRResourceCalenderView','cboDT') ;	
	var objEmpTypeID=GetObjectReference('frmHRResourceCalenderView','cboEmpType');	
	var objDepartmentID = GetObjectReference('frmHRResourceCalenderView','cboDepartment') ;	
	var objRole=GetObjectReference('frmHRResourceCalenderView','cboRole') ;	
	var objDesignation=GetObjectReference('frmHRResourceCalenderView','cboDesignation') ;	
	var objSkill=GetObjectReference('frmHRResourceCalenderView','cboSkill') ;		
	var objDeployable=GetObjectReference('frmHRResourceCalenderView','cboDeployable') ;
	
	var objResourcePool=GetObjectReference('frmHRResourceCalenderView','cboResourcePool')
		
	var objtxtMonth=GetObjectReference('frmHRResourceCalenderView','txtMonth');
	var objtxtYear=GetObjectReference('frmHRResourceCalenderView','txtYear');	
	var Year=objtxtYear.value;
	var MonthID=objtxtMonth.value;
	var pageNumber='';
	
	if(objtxtpageNumber!=null)
	    pageNumber = objtxtpageNumber.value;
	    
	if(pageNumber == '')
	    pageNumber = '-1';
    //Commented and Added by Dhanashri S on 2 Aug 2016 For PK token validate
	$.ajax({
	    type: 'POST',
	    dataType: 'json',
	    contentType: 'application/json',
	    url: 'HR_ResourceCalendarView.aspx/GenrateProjectAllocationToken',
	    data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", BGID: objBG.value , OUID: objOU.value , DUID: objDU.value, DTID: objDT.value, DeptID: objDepartmentID.value, RoleID: objRole.value, DesignationID: objDesignation.value, SkillID: objSkill.value, ResourcePoolID: objResourcePool.value}),
	    success: function (Result) {

		        var strQueryString = "?From=" + "<%=strFromWhere%>" + "&PageNumber=" + pageNumber + "&EmployeeName=" +objEmployee.value + "&BGID=" + objBG.value +"&OUID=" + objOU.value ;	
		        strQueryString = strQueryString + "&DUID=" +objDU.value + "&DTID=" + objDT.value + "&EmpType=" +objEmpTypeID.value ;
		        strQueryString = strQueryString + "&DeptID=" +objDepartmentID.value + "&RoleID=" +objRole.value + "&DesignationID=" + objDesignation.value;
		        strQueryString = strQueryString + "&SkillID=" + objSkill.value + "&Deployable=" + objDeployable.value + "&ResourcePoolID=" + objResourcePool.value;
		        strQueryString = strQueryString + "&FromDate=" + FromDate + "&ToDate=" + ToDate ;
		        //strQueryString = strQueryString + "&EmployeeID=<%=Session("intUserID")%>&PkProjectAllocationToken=" + Result.d ;
	            strQueryString = strQueryString + "&EmployeeID=<%=Session("intUserID")%>&PkToken=" + Result.d ;
	 
	
		        window.open("HR_RCV_ProjectAllocation.aspx" + strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");


		    },
		    error: function () {
		        //  alert("Error")
		    }
    });
	 
	//var strQueryString = "?From=" + "<%=strFromWhere%>" + "&PageNumber=" + pageNumber + "&EmployeeName=" +objEmployee.value + "&BGID=" + objBG.value +"&OUID=" + objOU.value ;	
	//strQueryString = strQueryString + "&DUID=" +objDU.value + "&DTID=" + objDT.value + "&EmpType=" +objEmpTypeID.value ;
	//strQueryString = strQueryString + "&DeptID=" +objDepartmentID.value + "&RoleID=" +objRole.value + "&DesignationID=" + objDesignation.value;
	//strQueryString = strQueryString + "&SkillID=" + objSkill.value + "&Deployable=" + objDeployable.value + "&ResourcePoolID=" + objResourcePool.value;
	//strQueryString = strQueryString + "&FromDate=" + FromDate + "&ToDate=" + ToDate ;
	 
    //window.open("HR_RCV_ProjectAllocation.aspx" + strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
    //End of Comment and Adition by Dhanashri S on 2 Aug 2016
}
		</script>
	</body>
</HTML>
