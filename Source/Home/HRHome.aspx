<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HRHome.aspx.vb" Inherits="PbNIT.HRHome" %>
<html>
<% CommonFunctions.General.PlotPageHeadTag("HR Home")%>
 <body class="clsFullPageBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmHRHome"  method="post" runat="server" >
			<%PageInit()%>
         </form>
    <Script  type="text/javascript"  language="javascript">
		var objform=GetFormReference('frmHRHome');
		var objdivlist=GetObjectReference('frmHRHome','PageDiv');
		var objtxtSearch=GetObjectReference('frmHRHome','txtSearch');
		var xmlhttp;
		
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
			
			if (objtxtSearch)
			objtxtSearch.focus();
			
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 15 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 15;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			
			objdivlist.style.height = intDivHeight +'px';	}
		}
    function OpenPage_Onclick(url,height,width,ControlItemID,intTagID)
		{
        // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
	    document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("hidDefaultTagID").value=intTagID;
       
	    if(ControlItemID!="" && ControlItemID!="0")
        {
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("imgFav").src='../../Images/Home/favorites-.gif';
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("imgFav").title='Remove from favourites';
        }   
        else
        {
             document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("imgFav").src='../../Images/Home/favorites+.gif';
             document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent.document.all("imgFav").title='Add to favourites';
        }
	    window.location.href = url + "&From_Where=HRHome";
        //Ended
	}
		
	function ShowHideGroup_Onclick(intGroupID)
	{
	   
	    var objMenuTable=GetObjectReference('frmHRHome',"tblGroup" + intGroupID);
	    var objMenuImage=GetObjectReference('frmHRHome',"imgGroup" + intGroupID);
	    if (objMenuTable.style.display=="none")
	    {
	        objMenuTable.style.display="";
	        objMenuImage.src = "../../Images/Home/MoveUp.GIF";
	    }
	    else
	    {
	         objMenuTable.style.display="none";
	         objMenuImage.src = "../../Images/Home/MoveDown.GIF"
	    }
	}
	function ShowDetails_Onclick(intGroupID)
	{
	 //window.location.href = "DetailView.aspx?MenuGroupID=" + intGroupID;
	// window.location.href = "../Home/DetailsViewLink.aspx?MenuGroupID=" + intGroupID;//,"";
	    if ("<%=m_intShowMarqueeSection %>" == "1")
	    {
	        window.open("../Home/DetailView.aspx?ShowMarquee=1&MenuGroupID=" + intGroupID,"DetailsView","");
	        window.open("../Home/Marquee.aspx?MenuGroupID=" + intGroupID,"MarqueeHome","");
	    }
	    else
	    {
	        window.location.href = "../Home/DetailView.aspx?MenuGroupID=" + intGroupID,"";
	    }
	}    
	//Added  by SujitG on 04 Aug 2008
	function Configure_Section()
	{
	   window.open("../Home/HR_Employee_ApplicableSections.aspx?MasterTagID=2731&FromWhere=PEM","", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}
	//End of addition by SujitG on 04 Aug 2008
	//Added  by PiyushB on 19 Aug 2008
	        var objfrm = GetFormReference('frmHRHome');
            var objnoOfPages = GetObjectReference('frmHRHome','txtNoOfPages') ;
	        var objtxtpageNumber =  GetObjectReference('frmHRHome','txtPageNumber');
		    var objtxtNoOfPages = GetObjectReference('frmHRHome','txtNoOfPages');	
		    var noOfPages = 1
            if (objnoOfPages != null)
                 noOfPages= objnoOfPages.value;
            var objtxtpageNumber =  GetObjectReference('frmHRHome','txtPageNumber');
	function MessageOnClick(MessageID)
    {
        var MessageType ;
        var objtxtMessageType =  GetObjectReference('frmHRHome','txtMessageType');
        MessageType = objtxtMessageType.value ;
        window.open("../ORGSSTR/MyMessage.aspx?MessageID=" + MessageID +"&MessageType=" + MessageType ,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=400" );
    }
    function ShowCompose(Employee)
    {
        window.open("../ORGSSTR/MyMessage.aspx?&MessageType=3&EmployeeID="+ Employee,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 400)/2) + ",width=600,height=400" );
    }
   
    function DeleteOnClick(Employee)
    {
        if(ValidateMessages()==false)
        return;
        var objtxtmesageaction = GetObjectReference('frmHRHome','txtmesageaction');
        GetObjectReference('','DisplayDiv').value="2";
        
        objtxtmesageaction.value="1" ;
        
	    objfrm.submit();
    }
    function ValidateMessages()
    {
        var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmHRHome','chkDelete');
        if (blnIsRecordSelected == false) {return false;}    

         if (confirm("Are you sure, you want to delete selected records?") == true)  
         {return true;} 
         else
         {return false;}      
    }
    function ShowMessage(Employee,MessageType)
    {
        var objtxtMessageType =  GetObjectReference("frmHRHome","txtMessageType");
        if (objtxtMessageType.value != MessageType)
         {
            objtxtpageNumber.value ="1";
            objtxtMessageType.value = MessageType ;   
         }   
            
	    //objfrm.action= window.location.href;
	    GetObjectReference('','DisplayDiv').value="2";
	    objfrm.submit();
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

function validateNumPaging()
{
        var objtxtpageNumber =  GetObjectReference('frmHRResourceCalenderView','txtPageNumber');
		var objtxtNoOfPages = GetObjectReference('frmHRResourceCalenderView','txtNoOfPages');	
	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	if(parseInt(objtxtpageNumber.value)<=0)
	{
	    alert("Please enter positive integer only.");
		return false;
	}    
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}		
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
		        var objtxtpageNumber =  GetObjectReference('frmHRHome','txtPageNumber');
		        var objtxtNoOfPages = GetObjectReference('frmHRHome','txtNoOfPages');								
		        if (!disallowBlank(objtxtpageNumber,"Page Number should not be blank!",true) && (!disallowNonNumeric(objtxtpageNumber,"Please enter 'Page Number' as positive interger only",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Please enter 'Page Number' as positive interger only",true)) & (!disallowNonInteger(objtxtpageNumber,"Please enter 'Page Number' as positive interger only!",true)))				
		        {
			        if (Number(objtxtpageNumber.value) ==0)
			        {
				        alert("Page number should be greater than zero!");
				        return;
			        }
        			
			        if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
			        {
				        alert("'Page Number' is not available!");
				        return;
			        }
			        Page_OnClick(objtxtpageNumber.value);
		        }
	    }

    }
  function ShowMyProfile(EmployeeId,PKtoken)
    {
    	//window.open("../HR/MyProfile_CommonPage.aspx?EmployeeID_PK="+EmployeeId+"&PKToken="+PKtoken+"&MasterTagID=2404&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","_new", "resizable=yes,scrollbars=no,left=" + (((window.screen.width - 950)/2)+75) + ",top=" + (((window.screen.height - 650)/2)-40) + ",width=800,height=675");  
    	window.open("../Home/MyProfile_CommonPage.aspx?EmployeeID_PK="+EmployeeId+"&PKToken="+PKtoken+"&MasterTagID=2404&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1","_new", "resizable=yes,scrollbars=no,left=" + (((window.screen.width - 1000)/2)+75) + ",top=" + (((window.screen.height - 700)/2)-40) + ",width=900,height=700");  
    }
   function ClassicalView_onClick()
   {
   
      window.location.href ='../ORGSSTR/HomePage.aspx?FromWhere=MH';
   } 
   function UploadEmployeeImage(ev,m_intUserID)
   {
    
    var objPopUpDiv = GetObjectReference('','PopUpDiv');
    objPopUpDiv.style.display='';
    var objtxtFileName = GetObjectReference('','txtFileName');
    objtxtFileName.value='';
    objPopUpDiv.style.left = ev.clientX;
    objPopUpDiv.style.top = ev.clientY;
    return;
   
   }
   function UploadDocOnClick()
    {
        var objtxtFileName = GetObjectReference('','txtFileName');
        var objPopUpDiv = GetObjectReference('','PopUpDiv');
       
        if(objtxtFileName.value == '')
        {
            alert('Please select photo to upload');
            return;
         } 
       
        var objfrm = GetFormReference("frmCommonPage");
        objform.action = "../Home/HRHome.aspx?FromWhere=MH&UploadPhoto=1&FilePath="+objtxtFileName.value;
        objform.submit();
    }
    function CancelOnClick()
	{
	        var objPopUpDiv = GetObjectReference('','PopUpDiv');
	        objPopUpDiv.style.display = 'none';
	}	
    //End of Addition By PiyushB on 19 Aug 2008
    
    //Added by SujitG on 05 Sep 2008 
    function LastUpdated(strURL)
    {
        window.location.href = strURL;
    }
    //End of addition by SujitG on 05 Sep 2008 
    //Added By PiyushB on 17 Sep 2008
    //Purpose : To get the menu for My Remonders 
    function AddReminders(empID)
    {
     window.open("../ORGSSTR/MyReminders_CommonPage.aspx?Mode=ADD_NEW&MasterTagID=2521&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&PagingNumber=1&FromCL=1","MyReminders","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=400,height=300");
    }
    function DeleteReminders()
    {
        var objCheckedIDs = GetObjectReference('frmHRHome','chkDeleteRemind',true);
        var loopCount;
        var flag=0;
      
        if (objCheckedIDs.length==0)
        {
            alert('No reminders to delete.');
            return;
        }
        for(loopCount=0;loopCount<objCheckedIDs.length;loopCount++)
        {
            if (objCheckedIDs(loopCount).checked==true)
            {
                 flag = 1;
                loopCount= objCheckedIDs.length;
            }         
            
        }
        if (flag!=1)
        {
             alert('Please select reminders to delete.');
             return;
        }
        objform.action = "HRHome.aspx?";
		objform.submit();
    }
    function ShowCalendar()
    {
           window.open("../ORGSSTR/RemindarCalendar.aspx?MasterTagID=2604&FromWhere=PA","ReminderCalendar","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 715)/2 + ",width=800,height=675")
    }
    //End of Addition by PiyushB on 17 Sep 2008
    function Search_OnClick()
    {
            //var objReminderDiv=GetObjectReference('','MyreminderDiv');
            //if(objReminderDiv.style.display=='')
                GetObjectReference('','DisplayDiv').value="1";
            //else
                //GetObjectReference('','DisplayDiv').value="2";
        
        objform.submit();
    }
    function ShowHideReminder()
    {
         
        var objReminderDiv=GetObjectReference('','MyreminderDiv');
        var objNewsAlertsDiv=GetObjectReference('','MyNewsAlertsDiv');
//        if (objReminderDiv.style.display=='none')
//        {
            objReminderDiv.style.display='';
            objNewsAlertsDiv.style.display='none';
            GetObjectReference('','DisplayDiv').value="1";
//        }
//        else
//        {
//            objNewsAlertsDiv.style.display='';
//            objReminderDiv.style.display='none';
//        }
    }
    //Added by SujitG on 05 Dec 2008
    
    function ShowHideInbox()
    {
         
        var objReminderDiv=GetObjectReference('','MyreminderDiv');
        var objNewsAlertsDiv=GetObjectReference('','MyNewsAlertsDiv');
//        if (objReminderDiv.style.display=='none')
//        {
//            objReminderDiv.style.display='';
//            objNewsAlertsDiv.style.display='none';
//            
//        }
//        else
//        {
            objNewsAlertsDiv.style.display='';
            objReminderDiv.style.display='none';
            GetObjectReference('','DisplayDiv').value="2";
//        }
    }    
    //End of addition by SujitG on 05 Dec 2008
    
    
    
 function Search_OnKeyPress(e)
{
		var code;
       if (e.keyCode) code = e.keyCode;
	    else if (e.which) code = e.which;
	    if(code==13) {
		objfrm.action = "../Home/HRHome.aspx";
		objfrm.submit(); 
		}

}
function Page_OnClick(page)
{		
        objfrm.action = "../Home/HRHome.aspx";
		objfrm.submit();
}

function addRemoveFavorites(intControlItemID,strMode)
{
	// A Add to Favourites
	// D delete from Favourites
	// R Remove all 

/*	var objFavCount =GetObjectReference('frmHRHome','hid_favCount');
	
	if(objFavCount !=null)
	{
		if (strMode == 'A')
		{
			objFavCount.value = parseInt(objFavCount.value) + 1;
		}
		
		if (strMode == 'D')
		{
			objFavCount.value = parseInt(objFavCount.value) - 1;
		}
		if (strMode == 'R')
		{
			objFavCount.value = 0;
		}
	*/
	//alert(objFavCount.value);
	//if (parseInt(objFavCount.value) > 10)
	//{
//		alert('Maximum 10 items allowed into favourites.');
//		return;
//	}
	
	//}
	var objimgFav = GetObjectReference('frmHRHome','imgFav'+intControlItemID);
     if (objimgFav!=null)
     {
        if(strMode=='A')
        {
            objimgFav.src = '../../Images/Home/RemoveFavorite.gif';
            objimgFav.onclick="addRemoveFavorites("+intControlItemID+",'D')";
            objimgFav.title="Remove from favourites";
        }
        else
        {

            objimgFav.src = "../../Images/Home/AddFavorite.gif";
            objimgFav.onclick="addRemoveFavorites("+intControlItemID+",'A')";
            objimgFav.title="Add to favourites";
        }
     }

	
	loadXMLDoc("HRHome.aspx?IsXMLHTTP=1","Mode="+strMode+"&ControlItemID="+intControlItemID)
	/*if (navigator.appName =='Netscape')
	{
		var url="HRHome.aspx?IsXMLHTTP=1&Mode="+strMode+"&ControlItemID="+intControlItemID;
		objXMLHTTP=new XMLHttpRequest();		
		objXMLHTTP.onreadystatechange=xmlhttpChange;
		objXMLHTTP.open("GET",url,true);
		objXMLHTTP.send(null);
	}
	else
	{
		var url="HRHome.aspx?IsXMLHTTP=1&Mode="+strMode+"&ControlItemID="+intControlItemID;
		objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP")
		objXMLHTTP.onreadystatechange=xmlhttpChange;
		objXMLHTTP.open("GET",url,false);
		objXMLHTTP.send();
	}*/
				
 } 
			 
function loadXMLDoc(url,reqQuery)

{
// code for Mozilla, etc.
if (window.XMLHttpRequest)
{
    xmlhttp=new XMLHttpRequest()
    xmlhttp.onreadystatechange=xmlhttpChange;

    if (ns)
    {
        xmlhttp.open("GET",url+"&"+reqQuery,true)
        xmlhttp.send(false)
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
        xmlhttp.onreadystatechange=xmlhttpChange
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
				{	
					//alert(xmlhttp.responseText);
					//alert('item saved');
					var objDivFav = GetObjectReference('frmHRHome','DivFav');
					
					if (objDivFav != null)
					{
						//alert(1);
						objDivFav.innerHTML = xmlhttp.responseText;
					}
                    
						
				}
			}
}
function MyTaskList_Click()
{
	window.location.href = "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
}
function Approval_Click()
{
	window.location.href = "../Home/Home_Approvals.aspx?FromWhere=HOME";
}

function LastUpdated_Click()
{
//window.location.href = url+"&From_Where=HRHome";
}
function CrossTab_Click()
{
    window.location.href = "../Home/CrossTabGridReport.aspx?FromWhere=HOME&CTReportID=1";
}

	</Script>

 </body>
</html>
