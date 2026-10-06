<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TabCollection_CommonPage.aspx.vb" Inherits="Whiz.TabCollection" %>
	<script language="javascript">
	function Validate()
		{//debugger;
			var Tabs=",";
			var subTabs=",";
			var altMsg ;
			var TabSEmapty;
			objTab = GetObjectReference("frmCommonPage","TagDescription",true);
			objTabTagID= GetObjectReference("frmCommonPage","TagID",true);			
		    TabSEmapty=0;
            var Count=objTab.length;
			for(var i=0; i < Count ; i++ )
			{		
					sTab = objTab[i].value;	
					sTabTagID =Trim(objTabTagID[i].value);
					if (sTab !='')
					{
					    TabSEmapty = TabSEmapty+1;
					}								
			            if (!isBlank(sTabTagID)) 
				         {
					        if(isSubstringExists(subTabs,"," + sTabTagID + ",")) 
					        { 
					           altMsg ='<%=strVALIDATION_MSG_TAB_SELECTED%>';  
					           altMsg =altMsg.replace("<PAGE>", "'" + objTab[i].value + "'").replace("<TABNO>",(i+1))
						       alert(altMsg); 
						        return false; 
					        } 
					        else
						        { subTabs= subTabs+ sTabTagID + ","; }
				          }
		    	}
			  if( TabSEmapty < 2)
				  {
				       alert('<%=strVALIDATION_MSG_TAB_NOT_SELECTED%>'); 
				       New_OnClick_Tab300();
				       return false;	
			   	 }
			   	   
			return true;
	}
	function Module_OnChange()
	{//debugger;
	    try
    {
        var objTemplateID= GetObjectReference("frmCommonPage","TemplateID");	
        var objParentNodeID= GetObjectReference("frmCommonPage","ParentNodeID");	
        var TemplateID= objTemplateID.value;	
        var strUrl="TabCollection_CommonPage.aspx?operation=GETPARENTCOMBO&TemplateID=" + TemplateID ;
        var objXHttp;
        var strNavigator = navigator.appName;
		strNavigator = strNavigator.toUpperCase();
        if(strNavigator == "MICROSOFT INTERNET EXPLORER")
			{ 
				objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
				//hook the event handler
				//prepare the call, http method=GET, false=asynchronous call
				objXHttp.open("GET",strUrl, false);
				//finally send the call
				objXHttp.send();
                if (objXHttp.responseText != null)
                {
                       objParentNodeID.outerHTML= objXHttp.responseText;
                       setFocus(objParentNodeID);
	             }
			}
			else
			{
				// Mozilla - based browser , Netscape
				objXHttp = new XMLHttpRequest();
				//hook the event handler
				//prepare the call, http method=GET, false=asynchronous call
				objXHttp.open("GET",strUrl, true);
				//finally send the call
				objXHttp.send(null);
				 if (objXHttp.responseText != null)
                {
                       objParentNodeID.outerHTML= objXHttp.responseText;
                       setFocus(objParentNodeID);
	             }
			}
    }
    catch(e){alert('Error occured while sending XMLHTTP request')}
	}
	
    function New_OnClick_Tab300()
    {
        var ControlDef_TagDescription_300='';
        var ControlDef_OrderNo_300='';
        var ControlDef_ShowOnNextRow_300='';
        var ControlDef_IsDefaultTab_300='';
        try{ControlDef_TagDescription_300=document.getElementById('ControlDef_TagDescription_300').value;} catch (e) {}
        try{ControlDef_OrderNo_300=document.getElementById('ControlDef_OrderNo_300').value;} catch (e) {}
        try{ControlDef_ShowOnNextRow_300=document.getElementById('ControlDef_ShowOnNextRow_300').value;} catch (e) {}
        try{ControlDef_IsDefaultTab_300=document.getElementById('ControlDef_IsDefaultTab_300').value;} catch (e) {}
        AddNewRow_MultiInsertGrid('300','tblGrid1606300',ControlDef_TagDescription_300,ControlDef_OrderNo_300,ControlDef_ShowOnNextRow_300,ControlDef_IsDefaultTab_300);
        SetShowOnNextRow();
        var objOrderNo=document.getElementsByName('OrderNo');
        for (var i=0; i<objOrderNo.length; i++) 
        {
            if(i==objOrderNo.length-1)
            {
                objOrderNo[i].value=i+1;
                objOrderNo[i].focus();
            }
         }
    }

    function SetShowOnNextRow()
    {
        var objShowOnNextRow=document.getElementsByName('ShowOnNextRow');
        for (var i=0; i<objShowOnNextRow.length; i++) 
        {
            if (document.getElementById('Display').value=='1')
                objShowOnNextRow[i].disabled=false;
            else   
                objShowOnNextRow[i].disabled=true;
         }
    }	
    SetShowOnNextRow()
	function TabLookup(Rowindex)
    {
        window.open("../General/CommonList.aspx?MasterTagID=1907&RowIndex="+Rowindex, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 550)/2) + ",width=600,height=550");
    }

    if(document.getElementById('TagName').value=='')
    {
        New_OnClick_Tab300();
        New_OnClick_Tab300();
        New_OnClick_Tab300();
        New_OnClick_Tab300();
        New_OnClick_Tab300();
        var objOrderNo=document.getElementsByName('OrderNo');
        for (var i=0; i<objOrderNo.length; i++) 
        {
          objOrderNo[i].value=i+1;
        }
        document.getElementById('TagName').focus();
    }
    function SetIsDefaultTab(intRowIndex)
    {
        intRowIndex=intRowIndex-1;
        objIsDefaultTab=document.getElementsByName('IsDefaultTab');
        for (var i=0; i<objIsDefaultTab.length; i++) 
        {
                 if (intRowIndex!=i)
                {
                   objIsDefaultTab[i].checked=false;
                 }
        } 
    }	
    strControlsToExcludeFrmNavigationAlert='OrderNo,ShowOnNextRow';
	</script>
