<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyHome_TabUI.aspx.vb" Inherits="PbNIT.MyHome_TabUI" %>
<html>
<%  CommonFunctions.General.PlotPageHeadTag("My Home")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<script type='text/javascript' src='../Home/homeTree.js'></script>

 <body class='clsPageBody'  onresize="window_onresize()" onload="window_onload()">
    <form id="frmHome_TabUI"  method="post" runat="server" >
			<%PageInit()%>
			<div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%">
            </div> 
			<div id="pleasewaitscreen" name="pleasewaitscreen" style="filter: alpha(opacity=60);background-color:#d1d1d1;position:absolute;z-index:105;top:30%;left:35%;display:none;">
            <table class="clsTable" border=1 cellpadding="0" cellspacing="0" height="200" width="300">
                <tr class="clsTRBlank" style="background-color:#d1d1d1;">
                    <td width="100%" height="100%" align="center" valign="middle">
                        <br/><br/>   
                        <img src="../../Images/wait.gif" alt="Waiting" />
                        <b>Processing...  please wait...</b>
                        <br/><br/>
                    </td>
                </tr>
            </table>
        </div>
			<INPUT type='hidden' id='txthid_Period' name='txthid_Period' value='1'>
			<INPUT type='hidden' id='txtExpanded' name='txtExpanded' value='0'>
			
						<DIV id="divTbl" runat="server">
				<TABLE class="clsGridTable" id="tbl_popup">
					<TR class="clsTRColumnHeader">
						<Div name='fieldset1' id='fieldset1'></Div>
					</TR>
				</TABLE>
			</DIV>
			
         </form>
    <script  type="text/javascript"  language="javascript">

        var objfrm = GetFormReference('frmHome_TabUI');
		var objdivlist=GetObjectReference('frmHome_TabUI','PageDiv');
		var objtxtSearch=GetObjectReference('frmHome_TabUI','txtSearch');
	  //  var objnoOfPages = GetObjectReference('frmHome_TabUI','txtNoOfPages') ;
      //  var objtxtpageNumber =  GetObjectReference('frmHome_TabUI','txtPageNumber');
       // var objtxtNoOfPages = GetObjectReference('frmHome_TabUI','txtNoOfPages');	
       // var objtxtpageNumber =  GetObjectReference('frmHome_TabUI','txtPageNumber');
        		var objfield = document.getElementById("fieldset1");
        		
		var xmlhttp,noOfPages = 1,menugroupID
        
      //  if (objnoOfPages != null)
           //  noOfPages= objnoOfPages.value;
             

		var strUniqueIDs = "";
		
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			
			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop-10;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop-10;
		    }
			objdivlist.style.height = intDivHeight +'px';	
			
			if (intDivHeight < 100)	intDivHeight = 100;
			
			}	
	
			//document.forms(0).parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("pleasewaitscreen").style.display="none";
			//document.forms(0).parentElement.ownerDocument.parentWindow.frames.parent.frames(0).parent.document.all("fillDiv").style.display="none"; 
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 5 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 5;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			
			objdivlist.style.height = intDivHeight +'px';	}
			
		}

    function Configure_Section()
	{
	   window.open("../Home/HR_Employee_ApplicableSections.aspx?MasterTagID=2731&FromWhere=PEM","", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}		
		
    function OpenPage_Onclick(url,height,width,ControlItemID,intTagID)
	{
       if (url.indexOf("CRM") > 0)
       {
         window.location.href = url;
       }
       else 
       if (url.indexOf("BTS") > 0)
       {
         window.location.href = url;
       }
       else
       if (url.indexOf("KM") > 0)
       {
           // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
         document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.parent.frames['link'].document.location.href ='../General/Navigation.aspx?FromWhere=KM';
         document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.location.href=url;
         document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.parent.frames['link'].document.location.reload();
       //Ended
       }
       else
       {
        window.location.href = url;
       }
	}




   /* function Previous_Onclick(intGroupID,intPanel)
    {
        var objCurrentPageNumber = GetObjectReference('','txtCurrentPage_'+intGroupID);
        var objfrm=GetFormReference('frmHome_TabUI');
        var objTxt = GetObjectReference('frmHome_TabUI','txthid_Period');
        
        objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) - 1 ;
          
        menugroupID = intGroupID;
        if (parseInt(objCurrentPageNumber.value)>=0)
        {
            if (intGroupID ==23)
                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&PageNumber="+objCurrentPageNumber.value+"&Period="+objTxt.value) 
            else
                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&PageNumber="+objCurrentPageNumber.value) 
        }                
        else
        {
            alert('This is First Page.')
            objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) + 1 ;
            return;
        }
    }

    function Next_Onclick(intGroupID,intPanel)
    {
        var objCurrentPageNumber = GetObjectReference('','txtCurrentPage_'+intGroupID);
        var objfrm=GetFormReference('frmHome_TabUI'); 
        var objTxt = GetObjectReference('frmHome_TabUI','txthid_Period');
        var objTxtNoofPages = GetObjectReference('frmHome_TabUI','txtNoOfPages_'+intGroupID);
        
        objCurrentPageNumber.value = parseInt(objCurrentPageNumber.value) + 1 ;
        menugroupID = intGroupID;
        if (intGroupID ==23)
            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&PageNumber="+objCurrentPageNumber.value+"&Period="+objTxt.value)        
        else
            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&PageNumber="+objCurrentPageNumber.value)        
    }
    
    */
    
function loadXMLDocForApprove(strUnique,strComment)
{
    var reqQuery  = "UniqueID="+strUnique+"&Comment="+strComment;
    if (window.XMLHttpRequest)
      {// code for IE7, Firefox, Opera, etc.
        xmlhttp=new XMLHttpRequest();
       if (xmlhttp!=null)
        {
        xmlhttp.onreadystatechange=xmlhttpChange;
        xmlhttp.open("GET",url+"&"+reqQuery, false);//
        //xmlhttp.setResponseHeader('Content-Type', 'application/x-www-form-urlencoded');
        xmlhttp.send(null);
        }
      }
    else if (window.ActiveXObject)
      {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        if (xmlhttp!=null)
        {
            xmlhttp.onreadystatechange=xmlhttpChangeApprove;
            xmlhttp.open("POST","../General/XMLHttp.aspx?TagID=2125&"+reqQuery,false)
            xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlhttp.send()
        }
      }     
}
function loadXMLDoc(url,reqQuery)
{
    if (window.XMLHttpRequest)
      {// code for IE7, Firefox, Opera, etc.
        xmlhttp=new XMLHttpRequest();
       if (xmlhttp!=null)
        {
        xmlhttp.onreadystatechange=xmlhttpChange;
        xmlhttp.open("GET",url+"&"+reqQuery, true);//
        //xmlhttp.setResponseHeader('Content-Type', 'application/x-www-form-urlencoded');
        xmlhttp.send(null);
        }
      }
    else if (window.ActiveXObject)
      {// code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
        if (xmlhttp!=null)
        {
        xmlhttp.onreadystatechange=xmlhttpChange;
        xmlhttp.open("POST",url,true)
        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xmlhttp.send(reqQuery)
        }
      }     
}
 
function xmlhttpChange()
	{
		if (xmlhttp.readyState==4)
		{
		 	if (xmlhttp.status==200)
			{	//alert(xmlhttp.responseText);
				//alert('item saved');
				var objTab;
				var HTML; 

				var  objWait = GetObjectReference('frmHome_TabUI','pleasewaitscreen');
				objWait.style.display="none";
                document.getElementById('fillDiv').style.display="none";
                
				HTML = xmlhttp.responseText;

                    
				//alert(HTML);
			    if (HTML.indexOf("Session##") >= 0)
			    {
			        var arr = new Array();
                    arr = HTML.split("##");
                    
                    if (arr[1].indexOf("CommonPage")>=0)
                    {
                        //parent.frames['link'].document.location.reload();
                        // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
                        document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.parent.frames['link'].document.location.reload();
                        //Ended
                    	
                	    arr[1] = arr[1].replace(/:/g,"&");
                    }
                    if (arr[1].indexOf("RT")>=0)
                    {
                	    arr[1] = arr[1].replace(/:/g,"&");
                    }
			        window.open(arr[1] + "&PKTOken=" + arr[2],"", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=900,height=600");
			    }
			    else
			    {
			        if (HTML.indexOf("Tasks##") >= 0)
			        {
			            var arr = new Array();
			            var objTD = GetObjectReference('frmHome_TabUI','TD_Period');
                        arr = HTML.split("##");
			            objTab = GetObjectReference('frmHome_TabUI','tblGroup23');
			            //objTab = GetObjectReference('frmHome_TabUI','DivGroup23');
				        
			            var objTxtExpanded = GetObjectReference('frmHome_TabUI','txtExpanded');
                        if (objTab != null)
                        {
	                        objTab.outerHTML =arr[3];
	                        //objTab.innerHTML=arr[3];
	                        //if (objTxtExpanded.value=="1")
                                objTD.innerHTML = arr[1] + ' - ' + arr[2];
                            //else
                                //objTD.innerHTML = '';
                        }
			        }
			        else
			        {
                        objTab = GetObjectReference('frmHome_TabUI','tblGroup'+menugroupID);
                        if(objTab!=null){
                            if( menugroupID == 17 || menugroupID == 22 || menugroupID == 25){
                                objTotalRows = GetObjectReference('frmHome_TabUI','TotalRowsForMyWorkbox_'+menugroupID); 
                                 var TotalRows;
                                    if(HTML!="")
                                    {
                                      TotalRows =  HTML.split("#=##=#"); 
                                      m_strTotalRows = TotalRows[1];
                                    
                                    }
                                   if(objTotalRows!=null)
                                        objTotalRows.innerHTML = "("+m_strTotalRows+")";
                                    objTab.outerHTML =TotalRows[0] ;

                    
                             }
                            else
                                objTab.outerHTML =HTML ;
                        }
                    }
			    }
			}
		}
	}

   
    function OpenPage(URL,strPKToken,intProjectID,EntityID)
    {
        if (URL.indexOf("IB/")> 0)
        {
            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=OpenIssuePage&URL="+URL+"&PKToken="+strPKToken+"&ProjectID="+intProjectID)        
        }
        else
        {
            if (URL.indexOf("CommonPage")> 0)
            {
                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=OpenWBSPage&URL="+URL.replace(/&/g,":")+"&PKToken="+strPKToken+"&ProjectID="+intProjectID)        
            }
            else
            {
                if (URL.indexOf("RT")> 0)
                {
                    loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=OpenTimesheet&URL="+URL.replace(/&/g,":")+"&PKToken="+strPKToken+"&ProjectID="+intProjectID+"&TimesheetID="+EntityID)        
                }
                else
                    window.open(URL + "&PKTOken=" + strPKToken,"", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 650)/2 + ",width=700,height=600");
            }
        }
        
            
    }
    
    function ChangeMouseOverStyle(Obj)
    {
        Obj.style.backgroundColor='#FFD695';
    }
    
    function ChangeMouseOutStyle(Obj)
    {
        Obj.style.backgroundColor='#FFFFFF';
    }
    
    function ShowTasks(intPeriod)
    {
        var objCurrentPage = GetObjectReference('frmHome_TabUI','txtCurrentPage_23'); 
        if(objCurrentPage!=null){
            objCurrentPage.value=0;
        }
        objTxt = GetObjectReference('frmHome_TabUI','txthid_Period');
        var objTxtExpanded = GetObjectReference('frmHome_TabUI','txtExpanded');
        objTxt.value = intPeriod;
        if (objTxtExpanded.value == "1")
            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=ShowTasks&ShowAll=1&Period="+intPeriod)        
        else
            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=ShowTasks&Period="+intPeriod)        
    }
    var m_strTotalRows = 0;
    function ExpandSection_Onclick(intGroupID,intPanel)
    {
        var Mode = "0",strTagID="0";
        if(intGroupID == 17 || intGroupID == 20 || intGroupID == 24){
            strTagID = (arguments.length>2)?arguments[2]:"0";
            Mode = (arguments.length>3)?arguments[3]:"0";
        }
        else
            Mode = (arguments.length>2)?arguments[2]:"0";
            
        var objWait = GetObjectReference('frmHome_TabUI','pleasewaitscreen');
        
        if (Mode == "0")
        {
            if(intGroupID == 17 || intGroupID == 20 || intGroupID == 24)
                window.setTimeout('ExpandSection_Onclick('+intGroupID+','+intPanel+','+strTagID+',"1")',1)            
            else
                window.setTimeout('ExpandSection_Onclick('+intGroupID+','+intPanel+',"1")',1) 
        }   
  
        if  (Mode == "1")
        {
           
            objWait.style.display="";
            document.getElementById('fillDiv').style.display=""; 
                        
            var intTagNumber = intPanel;
            var intCnt;
            var objTxtExpanded = GetObjectReference('frmHome_TabUI','txtExpanded');
            var objtdFilter= GetObjectReference('frmHome_TabUI','td_filter_'+intGroupID); 
            var objimgExpand = GetObjectReference('frmHome_TabUI','imgExpand_'+intGroupID);
            var objimgCollpse= GetObjectReference('frmHome_TabUI','imgCollpse_'+intGroupID);

           var objtxtSearch = GetObjectReference('','txtSearch_'+intGroupID);
            var i;
            var imgcloseTab = GetObjectReference('frmHome_TabUI','closeTab_'+intGroupID);
            var strFilter;
            
           

            imgcloseTab.style.display='none';
         

               var objTotalRows,objTotalRowsForWB;
                if(intGroupID!= 22 && intGroupID!= 25){
                   objTotalRows = GetObjectReference('frmHome_TabUI','TotalRowsForMyWorkbox_'+intGroupID); 
                   objTotalRowsForWB = document.getElementById('TotalRowsForWorkBox_'+intGroupID+"_"+strTagID); 
               
                    if(objTotalRows!=null)
                        if(objTotalRowsForWB!=null)
                            objTotalRows.innerHTML = "("+objTotalRowsForWB.value+")";
                    
                 }

            if(objimgCollpse!=null)
                objimgCollpse.style.display='';
            if(objimgExpand!=null)
                objimgExpand.style.display='none';
            
            if (objtdFilter !=null)
                objtdFilter.style.display='';
            
            
            objTxtExpanded.value = "1";
            if(intGroupID == 23){
                GetObjectReference('','TD_233').style.width='99.9%';
                GetObjectReference('','TD_233').style.height='99.9%';
                GetObjectReference('','TD_233').align='left';
                GetObjectReference('','TD_233').colSpan=5;
            
            }
            else
            {
                GetObjectReference('','TD_'+intPanel).style.width='99.9%';
                GetObjectReference('','TD_'+intPanel).style.height='99.9%';
                GetObjectReference('','TD_'+intPanel).align='left';
                GetObjectReference('','TD_'+intPanel).colSpan=5;
            }
            if(intGroupID!=23){
                    GetObjectReference('','TD_233').style.display='none';
                    GetObjectReference('','TDSpace_233').style.display='none';
                    GetObjectReference('','TR_233').style.display='none';
            }
            var intCnt1=0,intR=0;
            switch(intPanel){
                case 0:
                    intR=0;break;
                case 1:
                    intR=0;break;
                case 2:
                    intR=2;break;
                case 3:
                    intR=2;break;
                case 4:
                    intR=3;break;
                case 5:
                    intR=3;break;
                case 6:
                    intR=4;break;
                case 7:
                    intR=4;break;
                case 8:
                    intR=5;break;
                case 9:
                    intR=5;break;
                case 10:
                    intR=6;break;
                case 11:
                    intR=6;break;
            
            }
            for(intCnt1=0; intCnt1<=8 ;intCnt1++)
            {
                
                if(intGroupID!=23)
                {
                    if(intCnt1!=intR){
                    if(GetObjectReference('','TR_'+intCnt1)!=null)
                        GetObjectReference('','TR_'+intCnt1).style.display='none';
                    }
                                        
                }
                  
            }
            
            for(intCnt=0; intCnt<=7 ;intCnt++)
            {
                if(intGroupID==23){
                        if (GetObjectReference('','TD_'+intCnt) !=null)
                        {
                            GetObjectReference('','TD_'+intCnt).style.display='none';
                            GetObjectReference('','TDSpace_'+intCnt).style.display='none';
                        }
                }
                else
                {
                    if (intCnt !=intPanel)
                    {
                        if (GetObjectReference('','TD_'+intCnt) !=null)
                        {
                            GetObjectReference('','TD_'+intCnt).style.display='none';
                            GetObjectReference('','TDSpace_'+intCnt).style.display='none';
                        }
                      
                    }
                }
            }        
 
            GetObjectReference('','txtExpanded').value=1;
            menugroupID = intGroupID;
           if (intGroupID == 23)
                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&From=ShowTasks&MenuGroupID="+intGroupID+"&ShowAll=1") 
            else
            {
                if (intGroupID == 17 || intGroupID == 20 || intGroupID == 24){
                                    
                    loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&ShowAll=1&TagID="+strTagID) 
                }
                else{
                    loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&MenuGroupID="+intGroupID+"&ShowAll=1") 

                    }
            }
                

                                   
       }
    }
    
    function CollapseSection_Onclick(intGroupID,intPanel)
    {
         window.location.href = "../Home/MyHome_TabUI.aspx?ShortName=TabUI&FromWhere=TABUI&DashboardID=0"

    }

    function txtSearch_onkeypress(intGroupID,evt)
    {

            var strTagID = (arguments.length>2)?arguments[2]:"0";


            var code;
            var objtxtSearch = GetObjectReference('','txtSearch_'+intGroupID);
            var objTxt = GetObjectReference('frmHome_TabUI','txthid_Period');
            var selected,i;
            var SearchText;

            if (evt.keyCode) code = evt.keyCode;
            else if (evt.which) code = evt.which;
    	    
            selected='';
    	    
            if(code==13) 
            {
                     SearchText = objtxtSearch.value;
            	    
                       if (intGroupID ==23)
                            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+intGroupID+"&SearchText="+SearchText+"&Period="+objTxt.value);
                       else{
                            if(intGroupID == 17 || intGroupID == 20 || intGroupID == 24)
                                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+intGroupID+"&SearchText="+SearchText+"&TagID="+strTagID);       
                            else
                                loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+intGroupID+"&SearchText="+SearchText);       
                         
                            }

                    
            }
          //alert("Hi2"); 
    }
   function CloseSection(intGroupID, intPanel)
    {
        var objPanel;
        var TREndSpace;
        var TabHeading;
        switch (intGroupID)
        {
            case 17: TabHeading = 'My Workbox'; break;
            case 18: TabHeading = 'Act Now'; break;
            case 19: TabHeading = 'Timesheet'; break;
            case 20: TabHeading = 'My Requests'; break;
            case 21: TabHeading = 'My Responsibility'; break;
            case 22: TabHeading = 'People I Know'; break;
            case 23: TabHeading = '1-7-14-31'; break;
            case 24: TabHeading = 'Helpdesk'; break;
            case 25: TabHeading = 'Knowledge'; break;
        }
        if(confirm('Are you sure you want to delete "'+TabHeading+'" Tab from Home Page?\nPress OK to continue.')==true)
        {
            menugroupID = intGroupID;
            var objfrm = GetFormReference('frmHome_TabUI');
            objfrm.action = 'MyHome_TabUI.aspx?FromWhere=TABUI&Mode=CloseTab&MenuGroupID='+intGroupID;
            objfrm.submit();
          
         }
         
    }

        var noOfPages ;
		var objtxtpageNumber;
		function validateNumPaging(intMenuGroupID)
		{
		     if(GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID)!=null)
			    noOfPages = GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID).value; 
			objtxtpageNumber = GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
						
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
		function ShowPreviousPage(intMenuGroupID,TagID)
		{	 
                
		     if(GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID)!=null)
			    noOfPages = GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID).value; 
			    
			 objtxtpageNumber = GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
							
			 if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intMenuGroupID,TagID);
			else
			{
				if(!validateNumPaging(intMenuGroupID))
				return;
				
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
					objtxtpageNumber.value=objtxtpageNumber.value -1;
				NumPage_OnClick(objtxtpageNumber.value,intMenuGroupID,TagID);
			}
		}
		function ShowFirstPage(intMenuGroupID,TagID)
		{
		    if(GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID)!=null)
			    noOfPages = GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID).value; 
			objtxtpageNumber = GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
						
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intMenuGroupID,TagID);
			else
			{
				if(!validateNumPaging(intMenuGroupID))
				return;
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				objtxtpageNumber.value=1;
				NumPage_OnClick(objtxtpageNumber.value,intMenuGroupID,TagID);
			}
			
			
		}
		function ShowNextPage(intMenuGroupID,TagID)
		{	
		    if(GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID)!=null)
			    noOfPages = GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID).value; 
			objtxtpageNumber = GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
					
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intMenuGroupID,TagID);
			else
			{
				if(!validateNumPaging(intMenuGroupID))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
					objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
				NumPage_OnClick(objtxtpageNumber.value,intMenuGroupID,TagID);
			}	
		}
		function ShowLastPage(intMenuGroupID,TagID)
		{
		    if(GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID)!=null)
			    noOfPages = GetObjectReference('frmHome_TabUI','hidNoOfPages'+intMenuGroupID).value; 
			objtxtpageNumber = GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
							
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(noOfPages,intMenuGroupID,TagID);
			else
			{	
				if(!validateNumPaging(intMenuGroupID))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				objtxtpageNumber.value=noOfPages;
				NumPage_OnClick(objtxtpageNumber.value,intMenuGroupID,TagID);
			}
		}
		var isCheckedAtLeastOne = false;
		function NumPage_OnClick(page,intMenuGroupID,TagID)
		{
			

			var Mode = "0";
            Mode = (arguments.length>3)?arguments[3]:"0";
            var objTxt = GetObjectReference('frmHome_TabUI','txthid_Period');
            var objWait = GetObjectReference('frmHome_TabUI','pleasewaitscreen');
            
            if (Mode == "0")
            {
                if(intMenuGroupID == 17 && TagID == "2125")
                {
                    var strArrSelectedApproved = strUniqueIDs.split(",");
                    var strUnique="",strComment="";
                    var intCnt=0;
                    for(intCnt=0; intCnt < strArrSelectedApproved.length; intCnt++)
                    {
                        strUnique = strArrSelectedApproved[intCnt];
                        strComment = GetObjectReference('frmHome_TabUI','txt_'+strUnique).value;
                        if(strUnique!="")
                            loadXMLDocForApprove(strUnique,strComment);
                    
                    }
                 } 
                window.setTimeout('NumPage_OnClick('+page+','+intMenuGroupID+','+TagID+',"1")',1) ;  
            }   
            if  (Mode == "1")
            {
        
                 objWait.style.display="";
                 document.getElementById('fillDiv').style.display=""; 

			     var SearchText="";
		         var objtxtSearch = GetObjectReference('frmHome_TabUI','txtSearch_'+intMenuGroupID);
                 if(objtxtSearch!=null)
                    SearchText = objtxtSearch.value;
			     if (intMenuGroupID ==23)
                    loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+menugroupID+"&SearchText="+SearchText+"&Period="+objTxt.value+"&PageNumber="+page);
                 else{
                        if(intMenuGroupID == 17 || intMenuGroupID == 20 || intMenuGroupID == 24)
                        {
                              loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+menugroupID+"&SearchText="+SearchText+"&TagID="+TagID+"&PageNumber="+page);       
                            
                        }
                        else
                            loadXMLDoc("MyHome_TabUI.aspx?IsXMLHTTP=1","&ShowAll=1&MenuGroupID="+menugroupID+"&SearchText="+SearchText+"&PageNumber="+page);       
             
                    }
            }
			
		}
		function txtPageNumber_KeyPress(e,intMenuGroupID,TagID)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				objtxtpageNumber =  GetObjectReference('frmHome_TabUI','txtPageNumber'+intMenuGroupID);
				objtxtNoOfPages = GetObjectReference('frmHome_TabUI','txtNoOfPages'+intMenuGroupID);
				if (!disallowBlank(objtxtpageNumber,"Page number should be blank.",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number should be numeric.",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number should be paositive integer.",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number should be integer.",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Please enter value less than or equal to " +objtxtNoOfPages.value);
						return;
					}
					NumPage_OnClick(objtxtpageNumber.value,intMenuGroupID,TagID);
				}	
			}
		
		}
        function chkShow_OnClick()
		{		
		
			var objCheckboxShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);	//GetCheckboxShowObject(intGridNo);	
			var IsSelected=false;
			if (objCheckboxShow!=null)
			{	
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
							GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).disabled=false;
							IsSelected =true;
					}
					else
					{
						GetObjectReference('frmHome_TabUI','txt_'+objCheckboxShow[intCnt].value).value = "";
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).src = '../../Images/Home/Details.gif';
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).disabled=true;
					}			
				}
				if ( IsSelected == false)
                {
                
                    if(GetObjectReference('frmHome_TabUI','img_0')!=null)
			        {
        			
			            GetObjectReference('frmHome_TabUI','img_0').src = '../../Images/Home/Details.gif';
				        GetObjectReference('frmHome_TabUI','txt_0').value = "";
				        GetObjectReference('frmHome_TabUI','img_0').width = "17";
				        GetObjectReference('frmHome_TabUI','img_0').height = "19";
			        }
                
                
                }
			}
		}
		function DisplayComment(evt,UniqueID)
		{	
			var url;
			var objTblpopup;
			evt = evt || window.event;
			var source=evt.target||evt.srcElement;
			var mouseXY;
			var objDivpopup;
			var intUniqueID ;
			var objComment;
			var objCheckboxShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);//GetCheckboxShowObject(intGridNo);	
			
			mouseXY=mouseCoords(evt);
			intUniqueID = UniqueID;

            if(intUniqueID=="0")
            {
            	var intCnt=0,IsSelected=false;
	            for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
	            {
	                if (objCheckboxShow[intCnt].checked == true)
	                {
	                   IsSelected=true;
                    }
                }
                if ( IsSelected == false)
                {
                    alert("Please select at least one checkbox to approve");
                    return;
                }
            }

			loadComment(intUniqueID);				
			objDivpopup = document.getElementById("divTbl");
			objTblpopup = document.getElementById("tbl_popup");
						
			objDivpopup.style.position = 'absolute';
			objDivpopup.style.left = mouseXY.x- 391;
			objDivpopup.style.top  = 150;
			objDivpopup.style.width  = '325px';
			objDivpopup.style.height  = '130px';
			objDivpopup.style.display  = '';
			var objT = GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID);
			objT.focus();
			objT.select();
			
			
			 if (objCheckboxShow!=null)
			 {					
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
						if (intUniqueID==objCheckboxShow[intCnt].value)
						{
							GetObjectReference('frmHome_TabUI','img_'+intUniqueID).width = "30";
							GetObjectReference('frmHome_TabUI','img_'+intUniqueID).height = "25";	
						}
						else
						{
							if(Right(GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).src,14)== '../../Imeges/Home/Details.gif')
							{
								GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
							else
							{
								GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
						}
					}			
				}
			}	
		}
		function loadComment(intUniqueID)
		{
			var strElement;	
			var m_UniqueID="";
			var objid = GetObjectReference('frmHome_TabUI','txt_' + intUniqueID);
			
			if (objid == null) 
				m_UniqueID = ""
			else
				m_UniqueID = objid.value;
				
				strElement	=	'<b>Comment</b><br><textarea wrap=Hard  name="txtUniqueID'+ intUniqueID + '" id="txtUniqueID' + intUniqueID + '" maxlength=1000 class=clsTextArea style="width:325px; height:70px; text-align:Left"; rows=5; cols =20>'+ m_UniqueID + '</textarea>';
				strElement	+= '<br><span style="text-align:center"><input type=button id=btnOK name=btnOK Value = "  OK   " style ="font size=9 width=10pts" onClick = getComment_Onclick("' + intUniqueID + '")>';
				strElement	+= '<input type=button id= btnCancel name= btnCancel style ="font size=9" Value = CANCEL onClick = cancel_OnClick("' + intUniqueID + '")> </span>';
				objfield.innerHTML = strElement;	
				GetObjectReference('frmHome_TabUI','img_'+intUniqueID).width = "30";
				GetObjectReference('frmHome_TabUI','img_'+intUniqueID).height = "25";
				
						
		}
		function getComment_Onclick(intUniqueID)
		{		
			var strElement;	
			var chkcomment;
			var intCnt;
			var objDivpopup = document.getElementById("divTbl");
			objid = GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID);
			GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value = objid.value;

			if(GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).value.length > 1000)
			{
				alert("Comment should not be more than 1000 characters.");
				GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).focus();			
				return; 
			}
			
			if (disallowBlank(GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID),'&#39;Comment&#39; should not be left blank.',true) )
			{ 
				GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).value= "";
				GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).focus();
				GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).select();
				return; 
			}
			
			objDivpopup.style.display="none";		
			GetObjectReference('frmHome_TabUI','img_'+intUniqueID).src = '../../Images/Home/page.gif';														
			GetObjectReference('frmHome_TabUI','img_'+intUniqueID).width = "22";
			GetObjectReference('frmHome_TabUI','img_'+intUniqueID).height = "17";

			if(intUniqueID == "0")	
			{
			
			    var objCheckboxShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);
			    if(objCheckboxShow!=null)
			    {

			        var intCnt=0;
				    for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				    {
				        if (objCheckboxShow[intCnt].checked == true)
				        {
				            var UniqueID = objCheckboxShow[intCnt].value;
				      	    GetObjectReference('frmHome_TabUI','img_'+UniqueID).src = '../../Images/Home/page.gif';														
			                GetObjectReference('frmHome_TabUI','img_'+UniqueID).width = "22";
			                GetObjectReference('frmHome_TabUI','img_'+UniqueID).height = "17";
			                GetObjectReference('frmHome_TabUI','txt_'+UniqueID).value =  GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value;
				        }
				    }
				}
			
			}
					
		}
		function mouseCoords(ev)
		{
			if(ev.pageX || ev.pageY){
			return {x:ev.pageX, y:ev.pageY};
			}
			return {
				x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:ev.clientY + document.body.scrollTop  - document.body.clientTop - 40
			};
		}
		
		function cancel_OnClick(intUniqueID)
		{
			var objDivpopup = document.getElementById("divTbl");
			if(GetObjectReference('frmHome_TabUI','txtUniqueID'+intUniqueID).value.length > 1000)
			{ 
				GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value = ""
			}
			if (disallowBlank(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID),'',true))
			{ GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value = ""
			}
			if (GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value == "")
			{ 
				GetObjectReference('frmHome_TabUI','img_'+intUniqueID).src = '../../Images/Home/Details.gif'
			}
			objDivpopup.style.display="none"; 	
			
						
			var objCheckboxShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);
			
			if (objCheckboxShow!=null)
			{		
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if(Right(GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).src,14)== '../../Imeges/Home/Details.gif')
					{
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).width = "17";
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).height = "19";	
					}
					else
					{
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).width = "22";
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).height = "17";	
					}
				}
			}
		}
		var blnApproveall =false;
	    function Approve_OnClick(PageNumber,intMenuGroupID,TagID)
		{
			
			isCheckedAtLeastOne = false;
			var objCheckRTboxShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);	
			if (objCheckRTboxShow != null){	// FOR RESOURCE TIMESHEET APPROVALS
				if (validateSelectedCheckBox(objCheckRTboxShow)==false)
					return;}
			if ( isCheckedAtLeastOne == false)
			{
				alert("Please select at least one checkbox to approve");
				return;
			}
			else
			{		
					NumPage_OnClick(PageNumber,intMenuGroupID,TagID);
			    
            }
     	}
		function xmlhttpChangeApprove()
	    {
		    if (xmlhttp.readyState==4)
		    {
		 	    if (xmlhttp.status==200)
			    {	
			        var strString = xmlhttp.responseText;
		        }
	        }
	   }
		function validateSelectedCheckBox(objCheckboxShow)
		{
			var intUniqueID;
			var strTitle;
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == false)
					continue;
				else
				{
					isCheckedAtLeastOne = true;
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frmHome_TabUI','Title_'+intUniqueID).value;
					strUniqueIDs = strUniqueIDs+","+intUniqueID;
					if (GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value == "")
					{
						alert("Comment should not be left blank to '"+strTitle+"'.");
						GetObjectReference('frmHome_TabUI','img_'+intUniqueID).src = '../../Images/Home/Details.gif';								
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).disabled=false;
						return false;	
					} 
					else if(GetObjectReference('frmHome_TabUI','txt_'+intUniqueID).value.length > 1000)
					{
						alert("Comment should not be more than 1000 characters for '"+strTitle+"' approve.");
						return false;
					}
					
				}
			}
			if (isCheckedAtLeastOne == false)
				return true;
		
		}
		
		function SelectAll_OnClick()
		{	
			SelectAllCheckboxs('frmHome_TabUI','chkResourceTimeSheetShow'); // FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);	
			
		    if (objCheckboxRTShow!=null)
				SelectAllSettings(objCheckboxRTShow)
			
		}
		function ClearAllOnClick()
		{
			ClearAll_OnClick('frmHome_TabUI','chkResourceTimeSheetShow');// FOR RESOURCE TIMESHEET APPROVALS
			
			var objCheckboxRTShow = GetObjectReference('frmHome_TabUI','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxRTShow!=null)
				ClearAllSettings(objCheckboxRTShow);
			
		}
		function SelectAllSettings(objCheckboxShow)
		{
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
						GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).disabled=false;		
			}
		}
		function ClearAllSettings(objCheckboxShow)
		{

			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).src = '../../Images/Home/Details.gif';
				GetObjectReference('frmHome_TabUI','txt_'+objCheckboxShow[intCnt].value).value = "";
				GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).disabled=true;		
				GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).width = "17";
				GetObjectReference('frmHome_TabUI','img_'+objCheckboxShow[intCnt].value).height = "19";
			}

			if(GetObjectReference('frmHome_TabUI','img_0')!=null)
			{
			
			    GetObjectReference('frmHome_TabUI','img_0').src = '../../Images/Home/Details.gif';
				GetObjectReference('frmHome_TabUI','txt_0').value = "";
				GetObjectReference('frmHome_TabUI','img_0').width = "17";
				GetObjectReference('frmHome_TabUI','img_0').height = "19";
			}
		
		}
	</Script>

 </body>
</html>

