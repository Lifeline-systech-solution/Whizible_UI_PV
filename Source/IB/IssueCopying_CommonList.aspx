<%@ Page Language="vb" AutoEventWireup="false" Codebehind="InheritedCommonList.aspx.vb" Inherits="PbNIT.IssueCopying_CommonList" %>
<%CommonFunctions.General.PlotPageHeadTag("")%>
 
 	<script language="javascript">

         
 function Copy_OnClick(IssueID)        
		{
			window.location.href = "../IB/IB_IssueEntry.aspx?Action=CopyIssue&IssueID="+IssueID;			
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
//ADDED BY AMIT MAHADIK ON 04th OCTOBER 2011 PMLifeLine ISSUE COPYING
function Type_OnChange()
{//debugger;
	var objType=GetObjectReference('frmCommonList','CmbType');
    var SelectedType= (objType.options[objType.selectedIndex].value);
    var ProjectId = <%=mstrCurrentProjectID%>;
    var Browser = WhichBrowser();
	                       //*******************************AJAX CALL to get sub types*****************************************
                        var strUrl="../IB/AjaxCall.aspx?Flag=GETSUBTYPEFROMTYPE&Type=" + SelectedType + "&ProjectID=" + ProjectId;// +"&ID="+ ReleaseID;
                        if (Browser == 'IE') 
                            {   objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
					            objXHttp.onreadystatechange = HandlerOnReadyState;
					            objXHttp.open('GET',strUrl, false); 
					            objXHttp.send();          
                            }  
                        else  {
                            objXHttp = new XMLHttpRequest(); 
                            objXHttp.onreadystatechange = HandlerOnReadyState(); 
                            objXHttp.open('GET',strUrl, false);
                            objXHttp.send(null);  
                            if (objXHttp.responseText != null) {
                                xmlDoc = document.implementation.createDocument("", "", null);
                                xmlDoc.async = false;
                                if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                                    xmlDoc.load(objXHttp.responseXML);
                                strResult = objXHttp.responseText;
                            }
                            //Added By Vaijat K ON 27/11/2015
                          
                                if (objXHttp.responseText != null) 
                                {
                                    arrStr = strResult.split(',');
                                    document.getElementById('CmbSubType').options.length = 0;
                                    for(var j=0; j<arrStr.length; j++)
                                    {
                                        var opt = document.createElement("option");
                                        document.getElementById('CmbSubType').options.add(opt);
                                        document.getElementById('CmbSubType').options[j].value=arrStr[j];
                                        document.getElementById('CmbSubType').options[j].text=arrStr[j];
                                        
                                    }
                                }                            
                            //End of Addition By Vaijat K ON 27/11/2015
                        }
                        var strDateMsg='';
                        var objXHttp;
                        var blnFlag = false;        
                        var strText = new String();
                        var arrStr = new Array();   
                        function HandlerOnReadyState()
                        {
				            if (objXHttp.readyState==4)
				            {
				                if (objXHttp.responseText != null) 
				                {
				                    strText = objXHttp.responseText;  
				                    arrStr = strText.split(',');
                                    document.getElementById('CmbSubType').options.length = 0;
                                    for(var j=0; j<arrStr.length; j++)
                                    {
                                        var opt = document.createElement("option");
                                            document.getElementById('CmbSubType').options.add(opt);
                                            document.getElementById('CmbSubType').options[j].value=arrStr[j];
                                            document.getElementById('CmbSubType').options[j].text=arrStr[j];
                                        
                                    }
				                }
				            }
                        }
                       AJAXCALLtogetStatus();
                        //************************************************************************
                         
	
	}
	
	
	function AJAXCALLtogetStatus()
	{
	var objType=GetObjectReference('frmCommonList','CmbType');
    var SelectedType= (objType.options[objType.selectedIndex].value);
	var ProjectId = <%=mstrCurrentProjectID%>;
	var RoleId = <%=m_intRoleId%>;
	var Browser = WhichBrowser();
	
	//*******************************AJAX CALL to get Status*****************************************
                        var strUrl="../IB/AjaxCall.aspx?Flag=GETSTATUS&Type=" + SelectedType + "&ProjectID=" + ProjectId +"&RoleId=" + RoleId;// +"&ID="+ ReleaseID;
                        if (Browser == 'IE') 
                            {   objXHttp = new ActiveXObject('Msxml2.XMLHTTP');  
					            objXHttp.onreadystatechange = HandlerOnReadyState;
					            objXHttp.open('GET',strUrl, false); 
					            objXHttp.send();          
                            }  
                        else   {
                            //objXHttp = new XMLHttpRequest(); 
                            //objXHttp.onreadystatechange = HandlerOnReadyState(); 
                            //objXHttp.open('GET',strUrl, false);
                            //objXHttp.send(null);  
                            objXHttp = new XMLHttpRequest(); 
                            objXHttp.onreadystatechange = HandlerOnReadyState(); 
                            objXHttp.open('GET',strUrl, false);
                            objXHttp.send(null);  
                            if (objXHttp.responseText != null) {
                                xmlDoc = document.implementation.createDocument("", "", null);
                                xmlDoc.async = false;
                                if (Browser == 'FF') // Added By Vaijat K ON 26/11/2015
                                    xmlDoc.load(objXHttp.responseXML);
                                strResult = objXHttp.responseText;
                            }
                            //Added By Vaijat K ON 27/11/2015
                            
                                if (objXHttp.responseText != null) 
                                {
                                    arrStr = strResult.split(',');
                                    document.getElementById('CmbStatus').options.length = 0;
                                    for(var j=0; j<arrStr.length; j++)
                                    {
                                        var opt = document.createElement("option");
                                        document.getElementById('CmbStatus').options.add(opt);
                                        document.getElementById('CmbStatus').options[j].value=arrStr[j];
                                        document.getElementById('CmbStatus').options[j].text=arrStr[j];
                                        
                                    }
                                }
                            //End OF Addition By Vaijat K ON 27/11/2015
                            }
                        var strDateMsg='';
                        var objXHttp;
                        var blnFlag = false;        
                        var strText = new String();
                        var arrStr = new Array();   
                        function HandlerOnReadyState()
                        {
				            if (objXHttp.readyState==4)
				            {
				                if (objXHttp.responseText != null) 
				                {
				                    strText = objXHttp.responseText;  
				                    arrStr = strText.split(',');
                                    document.getElementById('CmbStatus').options.length = 0;
                                    for(var j=0; j<arrStr.length; j++)
                                    {
                                        var opt = document.createElement("option");
                                        document.getElementById('CmbStatus').options.add(opt);
                                            document.getElementById('CmbStatus').options[j].value=arrStr[j];
                                            document.getElementById('CmbStatus').options[j].text=arrStr[j];
                                        
                                    }
				                }
				            }
                        }
                       
                        //************************************************************************
	}
	
	
	
	
	
	
	
	
//END ADDED BY AMIT MAHADIK ON 04th OCTOBER 2011 PMLifeLine ISSUE COPYING


function ValidateControls()
	{
        var objReportedBy= GetObjectReference('frmCommonList','CmbReportedBy');
        var objReportedDate= GetObjectReference('frmCommonList','dtReportedDate');
        var objReportedTime= GetObjectReference('frmCommonList','txtReportedTime');
        var objType= GetObjectReference('frmCommonList','CmbType');
        var objSubType= GetObjectReference('frmCommonList','CmbSubType');
        var objStatus= GetObjectReference('frmCommonList','CmbStatus');

        //Added by NitinC on 12 Jan 2011 For PMLifeLine - Agile Module (Issue Fix 57924)
        if ("<%=m_intFlag%>" == "1")
        {
            var objRelease= GetObjectReference('frmCommonList','CmbRelease');
            var objIteration= GetObjectReference('frmCommonList','CmbIteration');
            var objUserStory= GetObjectReference('frmCommonList','CmbUserStory');
        }
        //End of Added by NitinC on 12 Jan 2011 For PMLifeLine - Agile Module (Issue Fix 57924)
	
        var objCurrentDate = GetObjectReference('frmCommonList','CurrentDate');
        var objCurrentTime = GetObjectReference('frmCommonList','CurrentTime');


	     if(disallowBlank(objType,'Type should not be left blank.',false)){
           	setFocus(objType);
            return;
         }
         if(disallowBlank(objSubType,'Sub Type should not be left blank.',false)){
          	setFocus(objSubType);
            return;
         }
	     if(disallowBlank(objStatus,'Status should not be left blank.',false)){
           	setFocus(objStatus);
            return;
         }
            
         if(disallowBlank(objReportedBy,'Reported By should not be left blank.',false)){
      	    setFocus(objReportedBy);
            return;
         }
        
         if(disallowBlank(objReportedDate,'Reported Date  should not be left blank.',false)){
          	setFocus(objReportedDate);
            return;
         }
         if(disallowBlank(objReportedTime,'Reported Time should not be left blank.',false)){
           	setFocus(objReportedTime);
            return;
         }
         //Added by NitinC on 12 Jan 2011 For PMLifeLine - Agile Module (Issue Fix 57924)
         if ("<%=m_intFlag%>" == "1")
         {
             if(disallowBlank(objRelease,'Release should not be left blank.',false)){
           	    setFocus(objRelease);
                return;
             }
             if(disallowBlank(objIteration,'Iteration should not be left blank.',false)){
           	    setFocus(objIteration);
                return;
             }
             if(disallowBlank(objUserStory,'User Story should not be left blank.',false)){
           	    setFocus(objUserStory);
                return;
             }
         }
         //End of Added by NitinC on 12 Jan 2011 For PMLifeLine - Agile Module (Issue Fix 57924)

 	
		if(objReportedDate!=null && objCurrentDate !=null)
		{
            if(compareDates(objCurrentDate.value, Trim(objReportedDate.value))==-1) 
            {
                    alert("The 'reported date' cannot be a future date");       
                    setFocus(objReportedDate);
                    return false;
            }
        }                      
               		
 
		
		/*
		 '****Code Added*******
        'By     :   AMIT MAHADIK
        'Reason :   Reported Time VALIDATIONS
        'Date   :   05TH OCTOBER 2011
         
        */
			
			if (objReportedTime!=null)
				{
					if (disallowBlank(objReportedTime,"Reported time should not be left blank",true))
							return false;
					if(isTime(objReportedTime,"Please enter valid time in format hh:mm!!\n\r(Hours(0-23) : Minutes(0-59))")==false)
						{
							return false;
						}
				}
        		
return true;
}

//Added by NitinC on 29 Dec 2011 For PMLifeLine -Agile Module (Issue Fix: 57837)
      
		 function GetIterations()
         {
             var objRelease=GetObjectReference('frmCommonList','CmbRelease');
             var ReleaseIdVal = objRelease.options[objRelease.selectedIndex].value;
             var Browser = WhichBrowser();
             //alert(ReleaseIdVal);
                if(ReleaseIdVal!="")
                {   try 
                        { 
                            //alert(ReleaseIdVal);
                    var strUrl = "../PM/AjaxCallIteration.aspx?EntityName=Issue&ReleaseId=" + ReleaseIdVal;
                       //Added by Dipali V On 21st Jun 2019 For On Chrome Dropdwon not working
                    if (Browser == 'IE') {
                        objXHttp = new ActiveXObject('Msxml2.XMLHTTP');
                        objXHttp.onreadystatechange = HandlerOnReadyState;
                        objXHttp.open('GET', strUrl, false);
                        objXHttp.send();
                        //alert(objXHttp.responseText);
                    }
                    else {
                        //alert(Browser);

                        objXHttp = new XMLHttpRequest();

                        objXHttp.onreadystatechange = HandlerOnReadyState;
                        objXHttp.open('GET', strUrl, false);
                        objXHttp.send(null);
                        //alert(objXHttp.responseText);
                        if (objXHttp.responseText != null) {
                            xmlDoc = document.implementation.createDocument("", "", null);
                            xmlDoc.async = false;
                            strResult = objXHttp.responseText;
                            if (Browser == 'FF') {
                                // Added By Vaijat K ON 19/11/2015
                                xmlDoc.load(objXHttp.responseXML);
                                strResult = objXHttp.responseText;

                            }
                        }
                    }
                             //  alert(objXHttp.responseText);
                            //Added By Vaijat K ON 27/11/2015
                          
                                      {
                                        if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                            alert(objXHttp.responseText);
                                        else
                                            //debugger;
                                            var data; 
                                            data =objXHttp.responseText; 
                                            var data1 = data.substring(1).split(","); 
                                             var objControl; 
                                     
                                            document.getElementById('CmbIteration').options.length = 0;
                                            //Added by NitinC on 19 Jan 2012 For PMLifeLine - Agile Module (Issue Fix : 57924)
                                            document.getElementById('CmbUserStory').options.length = 0;
                                            //End of Added by NitinC on 19 Jan 2012 For PMLifeLine - Agile Module (Issue Fix : 57924)
                                            if (data=='' || data==",Not Available$--$Not Available,Not Available#--#Not Available")
                                            {return;}
                                            //document.getElementById('BuildID').options.length = 0;
                                            //document.getElementById('UserStoryID').options.length = 0;
                                            for(var i=0;i<data1.length;i++) 
                                            {
                                                var str = data1[i].split(","); 
                                                for(var j=0; j<str.length; j++)
                                                {
                                                    var opt = document.createElement("option");
                                                    var val;
                                                    if(str[j].indexOf("$--$")!=-1 && str[j]!="Not Available$--$Not Available")
                                                    {
                                                        objControl = document.getElementById('CmbIteration')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("$--$");
                                                    }
                                                    else if(str[j].indexOf("@--@")!=-1)
                                                    {
                                                        //objControl = document.getElementById('BuildID')
                                                        objControl.options.add(opt); val=str[j].split("@--@");
                                                    }
                                                    /*else if(str[j].indexOf("#--#")!=-1 && str[j]!="Not Available#--#Not Available")
                                                    {
                                                        objControl = document.getElementById('UserStoryID')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("#--#");
                                                    } */
                                                   
                                                    if(val[0]!='')
                                                    {
                                                        for(var k=0;k<objControl.options.length;k++)
                                                        {
                                                            if(objControl.options[k].value=="")
                                                            {
                                                                objControl.options[k].value=val[0];
                                                                objControl.options[k].text=val[1]; 
                                                            } 
                                                         } 
                                                     } 
                                                     
                                                  } 
                                             }
                                             var objIterationID = document.getElementById('CmbIteration'); 
                                            //var objBuildID = document.getElementById('BuildID');
                                            //var objUserStoryID = document.getElementById('UserStoryID'); 
                                            var opt = document.createElement("option");  
                                            objIterationID.options.add(opt,0); 
                                            objIterationID.selectedIndex=0; 
                                            /*if(objBuildID.options.innerText!="Not Available")
                                            {
                                                var opt = document.createElement("option"); 
                                                objBuildID.options.add(opt,0);
                                                objBuildID.selectedIndex=0; 
                                            }*/
                                            //if(objUserStoryID.options.innerText!="Not Available")
                                            //{
                                                //var opt = document.createElement("option"); 
                                                //objUserStoryID.options.add(opt,0);
                                                //objUserStoryID.selectedIndex=0;
                                            //}

                                        }                      
                            //End of Addition By Vaijat K ON 27/11/2015
                        }
                       //End of Added by Dipali V On 21st Jun 2019 For On Chrome Dropdwon not working
                           // objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                           //// alert("1");
                           // objXHttp.onreadystatechange = function() 
                           // {
                           //     if(objXHttp.readyState==4)
                           //     {  
                           //         if(objXHttp.responseText != null)   
                                     
                           //         } 
                           // }
                           // alert(strUrl);
                           //     objXHttp.open("GET",strUrl, false); 
                           //     objXHttp.send(); 
                       
                        catch(e)    
                        {    
                        } 
                  }
                  else
                  {
                        document.getElementById('CmbIteration').options.length = 0;
                        document.getElementById('CmbUserStory').options.length = 0;
                  }
         }
		 
		    
		    // /IB/IB_IssueEntry.aspx?ReviewStatisticsID=0&ReviewActionID=0&ReviewType=&IssueNavigation=0&Mode=New&Action=TypeChange&PageNumber=1&ProjectID=90&FromWhere=&IssueID=0&ASCDESC=Desc&OrderBy=IssueID&PKToken=&FromReview=0&QueryToken=&QueryID=
		
		 function GetUserStories(UserStory)
		 {
		    var objIteration=GetObjectReference('frmCommonList','CmbIteration');
                var IterationIdVal= (objIteration.options[objIteration.selectedIndex].value);
                if(IterationIdVal!="")
                {
                        try 
                        { 
                            var strUrl="../PM/AjaxCallIteration.aspx?Action=GetUserStory&IterationId=" + IterationIdVal;
                            //objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                            if (document.all){
                                objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                            }
                            else{
                                objXHttp = new XMLHttpRequest();
                            }
                            objXHttp.onreadystatechange = function() 
                            {
                                if(objXHttp.readyState==4)
                                {  
                                    if(objXHttp.responseText != null)   
                                    {
                                        if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                            alert(objXHttp.responseText);
                                        else
                                            //debugger;
                                            var data; 
                                            data =objXHttp.responseText; 
                                            var data1 = data.substring(1).split(","); 
                                            var objControl; 
                                            document.getElementById('CmbUserStory').options.length = 0;
                                            if (data=='')
                                            {return;}
                                            for(var i=0;i<data1.length;i++) 
                                            {
                                                var str = data1[i].split(","); 
                                                for(var j=0; j<str.length; j++)
                                                {
                                                    var opt = document.createElement("option");
                                                    var val;
                                                    if(str[j].indexOf("$--$")!=-1 && str[j]!="Not Available#--#Not Available")
                                                    {
                                                        objControl = document.getElementById('CmbUserStory')
                                                        objControl.options.add(opt);
                                                        val=str[j].split("$--$");
                                                    }
                                                                                                      
                                                    if(val[0]!='')
                                                    {
                                                        for(var k=0;k<objControl.options.length;k++)
                                                        {
                                                            if(objControl.options[k].value=="")
                                                            {
                                                                objControl.options[k].value=val[0];
                                                                objControl.options[k].text=val[1]; 
                                                            } 
                                                         } 
                                                     } 
                                                     
                                                  } 
                                             }
                                            
                                            var objUserStoryID = document.getElementById('CmbUserStory'); 
                                            var opt = document.createElement("option");  
                                            objUserStoryID.options.add(opt,0); 
                                            objUserStoryID.selectedIndex=0; 
                                        } 
                                    } 
                                }
                                objXHttp.open("GET",strUrl, false); 
                                objXHttp.send(); 
                        } 
                        catch(e)    
                        {    
                        } 
                  }
                  else
                  {
                        document.getElementById('CmbUserStory').options.length = 0;
                  }
		 }
		 
		 function setFilter(strHiddenControlName,e,IsText)
{//debugger;
	if (IsText==false) {
	    objControl = GetObjectEvent(e);
	    objHiddenControl = GetObjectReference('frmCommonList',strHiddenControlName);
	        if(validateTagFilter()==false){return};
	    if (objHiddenControl != null) 
			{
				objHiddenControl.value = objControl.options[objControl.selectedIndex].innerText;
	        }
	}
	else {
	    var code;
	    if (e.keyCode) code = e.keyCode;
	    else if (e.which) code = e.which;
	    if(code==13) {
	        if(validateTagFilter()==false){return};
	        objControl = GetObjectEvent(e);
	        objHiddenControl = GetObjectReference('frmCommonList',strHiddenControlName);
	        if (objHiddenControl != null) 
	        {objHiddenControl.value = objControl.value;}
	    }
	    else {return;}
	}
	var ProjectID=GetObjectReference('frmCommonList','hidtxtDestProjectID').value;
    objfrm.action = "IssueCopying_CommonList.aspx?SetFilter=1&ProjectID="+ProjectID
	objfrm.submit();
}
 	    //End of Added by NitinC on 29 Dec 2011 For PMLifeLine -Agile Module (Issue Fix: 57837)

</script>
