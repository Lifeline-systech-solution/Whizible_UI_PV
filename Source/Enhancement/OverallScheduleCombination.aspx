<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OverallScheduleCombination.aspx.vb" Inherits="PbNIT.OverallScheduleCombination" %>

<!DOCTYPE html>

<html>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<% CommonFunctions.General.PlotPageHeadTag("WBS Combination")%>

<head runat="server">
    <title>Resource Timesheet Detail View</title>             
    <script type="text/javascript" language='javascript' src='../Enhancement/Customer_XMLHttp.js'></script>
</head>

     <body class="clsFullPageBody">	
	    <form id="frmOSCombination" method="post" runat="server">						
		<%DrawPage()%>
        </form>
				
<script language="javascript" type="text/javascript">

    var objform1 = GetFormReference('frmOSCombination');
    var objSubProject= GetObjectReference('frmOSCombination','SubProject');
    var objModule= GetObjectReference('frmOSCombination','Module');
    var objIteration= GetObjectReference('frmOSCombination','Iteration');
    var objIncreament= GetObjectReference('frmOSCombination','Increament');
    var objPhase= GetObjectReference('frmOSCombination','Phase');
    var objMilestone= GetObjectReference('frmOSCombination','Milestone');
    var objDeliverable= GetObjectReference('frmOSCombination','ProjectDeliverable');
    var objIncrement= GetObjectReference('frmOSCombination','Increment');
    var objRelease= GetObjectReference('frmOSCombination','Release');
    
//Deliverable
    var objCombination = '<%=strValidate %>';

    var strMode ; 

function cboRelease_onChange()
{
var objform=GetFormReference('frmOSCombination');
 var objSubProject= GetObjectReference('frmOSCombination','SubProject');
    var objModule= GetObjectReference('frmOSCombination','Module');
    var objIteration= GetObjectReference('frmOSCombination','Iteration');
    var objIncreament= GetObjectReference('frmOSCombination','Increament');
    var objPhase= GetObjectReference('frmOSCombination','Phase');
    var objMilestone= GetObjectReference('frmOSCombination','Milestone');
    var objDeliverable= GetObjectReference('frmOSCombination','ProjectDeliverable');
    var objIncrement= GetObjectReference('frmOSCombination','Increment');
    
 var objRelease= GetObjectReference('frmOSCombination','Release');
   //alert(objRelease.value);
    if (objRelease.value=='')
       {
       // objform.action='Enhancement/OverallScheduleCombination.aspx?ReleaseID=' + ReleaseID;
       // objform.submit();
        return;
       }
        ReleaseID=objRelease.value;
        //objform.action='../Enhancement/OverallScheduleCombination.aspx?ReleaseID=' + ReleaseID;
        objform.action='../Enhancement/OverallScheduleCombination.aspx?ReleaseID=' + ReleaseID +'&SubProject='+ objSubProject.value +'&Module='+ objModule.value +'&Phase='+ objPhase +'&Milestone='+ objMilestone.value +'&ProjectDeliverable='+objDeliverable.value+'&Increment='+objIncrement.value;
        objform.submit();
    

}


  /* function SaveAdd_OnClick()
   {  
        //strMode="SaveAdd";
        if(Validate() == false)
                    return;
		var objform=GetFormReference('frmOSCombination');
		objform.action='../Enhancement/OverallScheduleCombination.aspx?Mode=SaveAdd&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SaveAdd';
		objform.submit();
        //window.location.reload();
       
   } */
function SaveAdd_OnClick()
   {    
    
        strMode="SaveAdd";
        Add_Record();
   } 
   
   
   
   
   function Save_OnClick()
   {    
        strMode="Save";
        Add_Record();
   }
   
    /*function Save_OnClick()
	{//debugger;
		  if(Validate() == false)
                    return;
		var objform=GetFormReference('frmOSCombination');
		objform.action='../Enhancement/OverallScheduleCombination.aspx?Mode=SAVE&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=SAVE';
		objform.submit();
	    window.opener.location.href = window.opener.location.href;
    
	}*/

        function Delete_OnClick()
        {           
            var objDelete = document.getElementById('chkDelete');   
		    objform.action='../Enhancement/OverallScheduleCombination.aspx?Mode=DELETE&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1&Action=DELETE';
           // objform.action='../Quinnox2015/AddCalendarDetails.aspx?BillingDetailsId='+strBillingCalendarID+'&CustomerID='+strCustomerID+'&MasterTagID=20106&FromWhere=SM&Action=DELETE&RowCount='+noOfRows;

            objform.submit();  
        		        	
            //window.location.href=window.location.href;
        }   

          function Validate()
       {//debugger;
            var objSubProject= GetObjectReference('frmOSCombination','SubProject');
            var objModule= GetObjectReference('frmOSCombination','Module');
            var objIteration= GetObjectReference('frmOSCombination','Iteration');
            var objIncreament= GetObjectReference('frmOSCombination','Increament');
            var objPhase= GetObjectReference('frmOSCombination','Phase');
            var objMilestone= GetObjectReference('frmOSCombination','Milestone');
            var objDeliverable= GetObjectReference('frmOSCombination','ProjectDeliverable');
            var objProjectID="<%=intProjectID %>"     
        
	          if (objPhase != null)
              {                                
                     if (disallowBlank(objPhase,"Please Select the Phase!"))
                     {
                            return false;
                     }                            
                            
               }  
                if (objPhase != null)
                {
 
                            strURL="Action=VALIDATECOMBINATION&SubProject="+ objSubProject.value +"&Module="+ objModule.value + "&Phase="+ objPhase.value +"&ProjectDeliverable="+objDeliverable.value+"&Milestone="+objMilestone.value+"&ProjectID=" + objProjectID + "";
                            strResult = ValidateData(strURL,0,0,0); 
                            if(strResult != '')
                            {
                                alert(strResult);
                                //                                  
                                return false;
                            }
                }
                
           
          }
    function CheckBlank(obj)
    {
        if(obj==null)
            return '';
        else
            return obj.value;
    }
      
function Add_Record()
{
       var strURL;
        var strQuerystring;


       //if (disallowBlank(objPhase,'&#39;Phase&#39; should not be left blank.',true) )
       // {return; }
   
        if (disallowBlank(objRelease,'&#39;Releases&#39; should not be left blank.',true) )
                {return; }
        if (disallowBlank(objIncrement,'&#39;Iterations&#39; should not be left blank.',true) )
                {return; }

    //Added By Bharat Tekade on 11th-May-2016 for OS issue fixing
           

        if (CheckBlank(objSubProject) == '' && CheckBlank(objModule) == '' && CheckBlank(objPhase) == '' && CheckBlank(objMilestone) == '' && CheckBlank(objDeliverable) == '')
        {
            alert('Please select at least one value to create a combination!');
            return;
        }
        //End of Added By Bharat Tekade on 11th-May-2016 for OS issue fixing
    
       if( objSubProject ==null || objSubProject.value=='') 
            strQuerystring='&SubProject=NULL';
        else
            strQuerystring='&SubProject='+ objSubProject.value;
       if( objModule ==null || objModule.value=='') 
            strQuerystring=strQuerystring+'&Module=NULL';
       else
            strQuerystring=strQuerystring+'&Module='+ objModule.value;
        
      if( objPhase ==null || objPhase.value=='' ) 
            strQuerystring=strQuerystring+'&Phase=NULL';  
       else
            strQuerystring=strQuerystring+'&Phase='+ objPhase.value;

       if( objMilestone ==null || objMilestone.value=='' ) 
            strQuerystring=strQuerystring+'&Milestone=NULL';  
       else
            strQuerystring=strQuerystring+'&Milestone='+ objMilestone.value;

//objDeliverable
       if( objDeliverable ==null || objDeliverable.value=='' ) 
            strQuerystring=strQuerystring+'&ProjectDeliverable=NULL';  
       else
            strQuerystring=strQuerystring+'&ProjectDeliverable='+ objDeliverable.value;

//objIncrement
if( objIncrement ==null || objIncrement.value=='' ) 
            strQuerystring=strQuerystring+'&Increment=NULL';  
       else
            strQuerystring=strQuerystring+'&Increment='+ objIncrement.value;

//objRelease
if( objRelease ==null || objRelease.value=='' ) 
            strQuerystring=strQuerystring+'&Release=NULL';  
       else
            strQuerystring=strQuerystring+'&Release='+ objRelease.value;

     if( objPhase == null || objPhase.value=='' ) 
    {//debugger;
         if (confirm("Phases should be selected for each sequences for better planning.Do you still want to continue ?")) {
            
             //Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)
             strURL = "Action=CHECKCOMBINATIONDATES"+ strQuerystring 
             strResult = ValidateData(strURL, 0, 0, 0);
             if (strResult != '') {
                 alert(strResult);
                 //                                  
                 return false;
             }
             //End of Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)

                   var strURL = "../Enhancement/OverallScheduleCombination.aspx?Mode="+strMode+""+strQuerystring; 
                    loadXMLDoc(strURL,"");
                }
                else
                    return;
    }

    if( objPhase !=null && objPhase.value!='' ) 
    {
       
        //Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)
        strURL = "Action=CHECKCOMBINATIONDATES" + strQuerystring 
        strResult = ValidateData(strURL, 0, 0, 0);
        if (strResult != '') {
            alert(strResult);
            //                                  
            return false;
        }
        //End of Added By Bharat Tekade on 09th-May-2016 to validate child node date is between parent node dates of (Phase,SubProject,Module,Milestone,Del)
        var strURL = "../Enhancement/OverallScheduleCombination.aspx?Mode="+strMode+""+strQuerystring; 
        loadXMLDoc(strURL,"");
    }
}


function loadXMLDoc(url,reqQuery)
{//debugger;
// code for Mozilla, etc.
if (window.XMLHttpRequest)
  {
		xmlhttp=new XMLHttpRequest()
		xmlhttp.onreadystatechange=state_Change;
		if (ns)
		{
			xmlhttp.open("GET",url+"&"+reqQuery,true)
			xmlhttp.send(false)
			if (xmlhttp.responseText != null)
            {
            xmlDoc= document.implementation.createDocument("","",null);
            xmlDoc.async=false;
            //xmlDoc.load(xmlhttp.responseXML);
            state_Change(); 
            }
		}
		else
		{
			xmlhttp.open("POST",url,true)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlhttp.send(reqQuery)
		}
		
  	}
	// code for IE
	else if (window.ActiveXObject)
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
		if (xmlhttp)
		{
			xmlhttp.onreadystatechange=state_Change;
			xmlhttp.open("POST",url,true)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
 			xmlhttp.send(reqQuery)
		}
	}
}

function state_Change()
{//debugger;

	// if xmlhttp shows "loaded"
	if (xmlhttp.readyState==4)
	{
	// if "OK"
		if (xmlhttp.status==200)
		{
            if(xmlhttp.responseText == 'False') 
		    {
                // alert("The combination already exist.");			    
                alert("The Sequence cannot be repeated.");
		    }
		    else
		    {		        
                alert("Record Saved Successfully!");	
                //alert("The Sequence cannot be repeated.");	

                if(strMode=="SaveAdd")
                {
                   if( objSubProject !=null) objSubProject.value=''; 
                   if( objModule !=null) objModule.value='';
                   if( objIteration !=null) objIteration.value='';
                   if( objIncreament !=null) objIncreament.value='';
                   if( objPhase !=null) objPhase.value='';
                   if( objMilestone !=null) objMilestone.value='';
                   if( objDeliverable !=null) objDeliverable.value='';
                   if( objIncrement != null) objIncrement.value='';
                   if( objRelease != null) objRelease.value='';
                   
                  
                   //Start_Commented_and_Added_by_rachana_on_26-Nov-2010
                // window.opener.location.href ='../General/CommonList.aspx?FromWhere=PM&MasterTagId=20176';
                 window.opener.location.href ='../Enhancement/CreateAttributeCombination_20176_CommonList_CommonList.aspx?FromWhere=PM&MasterTagId=20176';
                 //End_Commented_and_Added_by_rachana_on_26-Nov-2010
                }
                else
                    //Start_Commented_and_Added_by_rachana_on_26-Nov-2010
                    //window.opener.location.href ='../General/CommonList.aspx?FromWhere=PM&MasterTagId=20176';
                    window.opener.location.href ='../Enhancement/CreateAttributeCombination_20176_CommonList_CommonList.aspx?FromWhere=PM&MasterTagId=20176';
                     //End_Commented_and_Added_by_rachana_on_26-Nov-2010
		    }
        }
    }
}

    //Bharat on 13th-May-2016

var g_sResponseText = '';
var g_oValidateXMLHttp;
function ValidateData(strURL, MasterTagID, ParentTagID, strFocusOnControl) {
    //start .Added mode option in parameter list to the function         
    var blnPROGFlag = (arguments.length > 5) ? arguments[5] : 0;
    //End
    var strResult;
    var strNavigator;
    g_sResponseText = '';
    strNavigator = navigator.appName;
    strNavigator = strNavigator.toUpperCase();


    strURL = "../Enhancement/Customer_XMLHttp.aspx?MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;

    if (strNavigator == 'MICROSOFT INTERNET EXPLORER') {
        g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP");
        //hook the event handler
        g_oValidateXMLHttp.onreadystatechange = GetResponseText;
        //prepare the call, http method=GET, false=asynchronous call
        g_oValidateXMLHttp.open("GET", strURL, false);
        //finally send the call
        g_oValidateXMLHttp.send();
    }
    else {
        // Mozilla - based browser 
        g_oValidateXMLHttp = new XMLHttpRequest();
        //hook the event handler
        g_oValidateXMLHttp.onreadystatechange = GetResponseText();
        //prepare the call, http method=GET, false=asynchronous call
        g_oValidateXMLHttp.open("GET", strURL, false);
        //finally send the call
        g_oValidateXMLHttp.send(null);
    }

    
    if (g_oValidateXMLHttp.responseText != null) {
        strResult = g_oValidateXMLHttp.responseText;
    }
    return strResult;
}


function GetResponseText() {
    if (g_oValidateXMLHttp.readyState == 4) {
        if (g_oValidateXMLHttp.responseText != null) {
            g_sResponseText = g_oValidateXMLHttp.responseText;
        }
    }
}
    //End Bharat on 13th-May-2016
</script>
</body>
</html>
