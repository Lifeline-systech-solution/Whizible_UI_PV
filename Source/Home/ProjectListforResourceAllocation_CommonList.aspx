<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectListforResourceAllocation_CommonList.aspx.vb" Inherits="PbNIT.ProjectListforResourceAllocation_CommonList"%>

<script type='text/javascript'>

    function AllocateResources(ProjectID) {
        var strUrl;
        strUrl = new String();
        strUrl = '../General/XMLHttp.aspx?TagID=20053&ProjectID=' + ProjectID;
        //Commented And Added By Usha Pandit On 21.05.2020 For open popup after click on Manage Resource link
        //if (document.all)
        //   { 
        // objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
        // objXHttp.onreadystatechange = HandlerOnReadyState; 
        // objXHttp.open('GET', strUrl, false); 
        // objXHttp.send();           
        //}
        //else  
        //   {
        // objXHttp = new XMLHttpRequest();  
        // objXHttp.onreadystatechange = HandlerOnReadyState(); 
        // objXHttp.open('GET', strUrl, false);
        // objXHttp.send(null);  
        //}

        var Browser = isIE();
        if (Browser == 'IE')
        {
            objXHttp = new ActiveXObject('Msxml2.XMLHTTP');
            objXHttp.onreadystatechange = HandlerOnReadyState;
            objXHttp.open('GET', strUrl, false);
            objXHttp.send();
        }
        else {
            objXHttp = new XMLHttpRequest();
            objXHttp.onreadystatechange = HandlerOnReadyState;
            objXHttp.open('GET', strUrl, false);
            objXHttp.send(null);

            if (objXHttp.responseText != null) {

                xmlDoc = document.implementation.createDocument("", "", null);
                xmlDoc.async = false;

                //if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                //    xmlDoc.load(objXHttp.responseXML);
                strResult = objXHttp.responseText;
            }
        }
        //End Of Added By Usha Pandit On 21.05.2020 For open popup after click on Manage Resource link
    }
    
    function HandlerOnReadyState()
		{						
			if (objXHttp.readyState == 4)
			{
			    if (objXHttp.responseText == 'True') 				
			    window.open('../General/CommonList.aspx?FromWhere=PM&MasterTagId=1019','ResourceAllocation','resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 750)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=750,height=500');																	
			}
		}
    
</script>