// JScript File

var g_sResponseText='';
var g_oValidateXMLHttp;
function ValidateData(strURL,MasterTagID,ParentTagID,strFocusOnControl)
{    
        //start .Added mode option in parameter list to the function         
        var blnPROGFlag = (arguments.length > 5)?arguments[5]:0;
        //End
        var strResult;
		var strNavigator;
		g_sResponseText = '';
		var browser;
		strNavigator = navigator.appName;
		strNavigator = strNavigator.toUpperCase();	
			
		
		//strURL = "../PasswordManagement/Ajax_XMLHttp.aspx?&MasterTagID=" + MasterTagID + "&ParentTagID=" + ParentTagID + "&" + strURL;
		
		browser = isIE();

		if (browser == 'IE')
		{ 
			g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
			//hook the event handler
			g_oValidateXMLHttp.onreadystatechange = GetResponseText;
			//prepare the call, http method=GET, false=asynchronous call
			g_oValidateXMLHttp.open("GET",strURL, false);
			//finally send the call
			g_oValidateXMLHttp.send();         
		} 
		else 
		{ 
			// Mozilla - based browser 
			g_oValidateXMLHttp = new XMLHttpRequest(); 
			//hook the event handler
			g_oValidateXMLHttp.onreadystatechange = GetResponseText();
			//prepare the call, http method=GET, false=asynchronous call
			g_oValidateXMLHttp.open("GET",strURL, false);
			//finally send the call
			g_oValidateXMLHttp.send(null);
		}				

		/*g_oValidateXMLHttp = null;

        if(isBlank(g_sResponseText)==false)
        {
            var blnValidateData = (arguments.length > 4)?arguments[4]:true;
            
            if (blnValidateData == true)
            {
			    //alert(g_sResponseText);
			    g_sResponseText = '';
			    var objCtr = GetObjectReference('',strFocusOnControl);
			    if(objCtr) {objCtr.focus();}
			    return false;
			}
			if (blnValidateData == false) //i.e. ReturnData
            {
                return g_sResponseText;
            }
		}
		return true;*/
		if ( g_oValidateXMLHttp.responseText != null)
		{
            strResult = g_oValidateXMLHttp.responseText;
        } 
        return strResult;
}

// START OF CODING BY PS
/*
function returnData(strURL,MasterTagID,ParentTagID,strFocusOnControl)
{
		var strNavigator;
		g_sResponseText='';
		strNavigator = navigator.appName;
		strNavigator = strNavigator.toUpperCase();		
		strURL="../General/AjaxValidation.aspx?MasterTagID=" + 	MasterTagID + "&ParentTagID=" +ParentTagID + "&" + strURL;

		if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
		{ 
			g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
			//hook the event handler
			g_oValidateXMLHttp.onreadystatechange = GetResponseText;
			//prepare the call, http method=GET, false=asynchronous call
			g_oValidateXMLHttp.open("GET",strURL, false);
			//finally send the call
			g_oValidateXMLHttp.send();         
		} 
		else 
		{ 
			// Mozilla - based browser 
			g_oValidateXMLHttp = new XMLHttpRequest(); 
			//hook the event handler
			g_oValidateXMLHttp.onreadystatechange = GetResponseText();
			//prepare the call, http method=GET, false=asynchronous call
			g_oValidateXMLHttp.open("GET",strURL, false);
			//finally send the call
			g_oValidateXMLHttp.send(null);
		}				

		g_oValidateXMLHttp = null;

        if(isBlank(g_sResponseText)==false)
        {
			return g_sResponseText;
		}
		return true;
}
*/
//END OF CODING BY PS

function GetResponseText()
{
	if (g_oValidateXMLHttp.readyState==4)
	{
		if (g_oValidateXMLHttp.responseText != null)
		{			
			g_sResponseText = g_oValidateXMLHttp.responseText;
		}
	}		
}

/*

function ValidateResourceOnProject(url) 
{// TO SEE IF WE ARE RUNNING IN IE 
var strResult;
strNavigator = navigator.appName;strNavigator = strNavigator.toUpperCase();
if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
{g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");	
//hook the event handler
g_objXHttp.onreadystatechange = state_change_del_validation;
//prepare the call, http method=GET, false=asynchronous call
g_objXHttp.open("GET",url, false);g_objXHttp.send();}
else{// Mozilla - based browser , Netscape
g_objXHttp = new XMLHttpRequest();
//hook the event handler
g_objXHttp.onreadystatechange = state_change_del_validation;
//prepare the call, http method=GET, false=asynchronous call
g_objXHttp.open("GET",url, false);
//finally send the call	
g_objXHttp.send(null);}
if ( g_objXHttp.responseText != null){//xmlDoc.load(g_objXHttp.responseXML);
strResult = g_objXHttp.responseText;} return strResult;} 
	
function state_change_del_validation(){if (g_objXHttp.readyState == 4) {	
if (g_objXHttp.status == 200){if (window.ActiveXObject){
xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
xmlDoc.async=false;xmlDoc.loadXML(g_objXHttp.responseText);}
// code for Mozilla, etc.
else if (document.implementation && document.implementation.createDocument)
{xmlDoc= document.implementation.createDocument("","",null);
xmlDoc.async=false;xmlDoc.load(g_objXHttp.responseXML);}
//Save the Result in a Global variable				
strResult=g_objXHttp.responseText;}}}

*/