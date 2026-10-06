<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ControlMenuGroup.aspx.vb" Inherits="PbNIT.ControlMenuGroup" %>



<html >
<%CommonFunctions.General.PlotPageHeadTag("Control Menu Group")%>	
<head runat="server">
    <title>Control Menu Group</title>
</head>
<body   class="clsBody" onload="window_onload()" onresize="window_onresize()">
   <form id="frmControlMenuGroup" method="post" runat="server">					
					<%WritePage()%>		
		
	</form>		
	<script type ="text/javascript"  language="javascript">
	
	objform = GetFormReference('frmControlMenuGroup');
	
	var ShowFilter='0';
   	var objDivMain = GetObjectReference("frmControlMenuGroup","divGrid"); 
	function window_onload()
    {
		var intDivHeight ;
		var intDivListPageHeight ;
		var intDivHeightRisk;
		var lc;
		if (objDivMain != null) {
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
		}
		else{
		intDivHeight = window.innerHeight - objDivMain.offsetTop - 40;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objDivMain.style.height = intDivHeight +'px';}
	
		if (objdivlist != null) {
		intDivListPageHeight = intDivHeight;
		if(isNaN(parseFloat(objDivMain.style.height))){objDivMain.style.height=intDivListPageHeight;}divHeight=parseFloat(objDivMain.style.height);
		if (parseFloat(objDivMain.style.height) > intDivListPageHeight){objDivMain.style.height = intDivListPageHeight +'px';}}
    }
    function window_onresize()
    {
			var intDivHeight;
			intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';	        
    }
    function Save_onClick()
    {
     var objControlItemIDs=GetObjectReference('frmControlMenuGroup','txtControlItemIDs');
     var ControlItemIDs =new Array();
     var ControlMenuID;
     var loopCount=0;
     var PriorityNumber="";
     var OrderNumber="";
     var TagID="";
     var RowNumber="";
     
     ControlMenuID=objControlItemIDs.value; 
     ControlItemIDs=ControlMenuID.split(",");
 
     for(loopCount=0;loopCount<ControlItemIDs.length -1;loopCount++)
     {
       var txtPriorityNumber=document.getElementById ("txtPriorityNumber_"+ControlItemIDs[loopCount]);
       var txtOrderNumber=document.getElementById ("txtOrderNumber_"+ControlItemIDs[loopCount]);
       var txtTagID=document.getElementById ("txtTagID_"+ControlItemIDs[loopCount]);
       var txtRowNumber=document.getElementById ("txtRowNumber_"+ControlItemIDs[loopCount]);
       if (txtPriorityNumber.value=="" || txtPriorityNumber.value==" ")
       {
         alert('Priority Number should not be blank.');
         txtPriorityNumber.focus();
         return;
       }
       if(!isNumeric(txtPriorityNumber.value))
       {
         alert('Priority Number should be positive');
         txtPriorityNumber.focus();
         return;
       }
      if(!isNumeric(txtOrderNumber.value))
       {
         alert('Order Number should be positive');
         txtOrderNumber.focus();
         return;
       }
       if(!isNumeric(txtTagID.value))
       {
         alert('Tag ID should be positive');
         txtTagID.focus();
         return;
       }
       if(!isNumeric(txtRowNumber.value))
       {
         alert('Row Number should be positive');
         txtRowNumber.focus();
         return;
       }
       //if (txtPriorityNumber.value=="0")
       // {
       //  alert('Priority Number should be greater than zero.');
       //  txtPriorityNumber.focus();
       //  return;
       //}
        PriorityNumber = PriorityNumber + txtPriorityNumber.value + ','
        if (txtOrderNumber.value=="" || txtOrderNumber.value==" ")
        {
         alert('Order Number should not be blank.');
         txtOrderNumber.focus();
         return;
       }
       //if (txtOrderNumber.value=="0")
       //{
       // alert('Order Number should be greater than zero.');
       //  txtOrderNumber.focus();
       //  return;
       //}
       OrderNumber = OrderNumber + txtOrderNumber.value + ','
        if (txtTagID.value=="" || txtTagID.value==" ")
       {
        alert('TagID should not be blank.');
       txtTagID.focus();
         return;
       }
       //if (txtTagID.value=="0")
       //{
       // alert('TagID should be greater than zero.');
       //  txtTagID.focus();
       //  return;
       //}
        TagID = TagID + txtTagID.value + ','
        if (txtRowNumber.value=="" || txtRowNumber.value==" ")
       {
         alert('Row Number should not be blank.');
         txtTagID.focus();
         return;
       }
       //if (txtRowNumber.value=="0")
       //{
       // alert('Row Number should be greater than zero.');
       //txtTagID.focus();
       //  return;
       //}
       RowNumber = RowNumber + txtRowNumber.value + ','
     }
    
    objform.action="../Home/ControlMenuGroup.aspx?Action=SAVE&MenuGroupID=" + <%=m_strMenuGroupID %> + "&PriorityNumbers="+PriorityNumber+"&OrderNumbers="+OrderNumber+"&RowNumbers="+RowNumber+"&TagIDs="+TagID +"&ControlItemIDs="+objControlItemIDs.value; 
    objform.submit();
    }
    function SaveAndClose_onClick()
    {
     var objControlItemIDs=GetObjectReference('frmControlMenuGroup','txtControlItemIDs');
     var ControlItemIDs =new Array();
     var ControlMenuID;
     var loopCount=0;
     var PriorityNumber="";
     var OrderNumber="";
     var TagID="";
     var RowNumber="";
     ControlMenuID=objControlItemIDs.value; 
     ControlItemIDs=ControlMenuID.split(",");
 
     for(loopCount=0;loopCount<ControlItemIDs.length -1;loopCount++)
     {
       var txtPriorityNumber=document.getElementById ("txtPriorityNumber_"+ControlItemIDs[loopCount]);
       var txtOrderNumber=document.getElementById ("txtOrderNumber_"+ControlItemIDs[loopCount]);
       var txtTagID=document.getElementById ("txtTagID_"+ControlItemIDs[loopCount]);
       var txtRowNumber=document.getElementById ("txtRowNumber_"+ControlItemIDs[loopCount]);
       if (txtPriorityNumber.value=="" || txtPriorityNumber.value==" ")
       {
         alert('Priority Number should not be blank.');
         txtPriorityNumber.focus();
         return;
       }
       if(!isNumeric(txtPriorityNumber.value))
       {
         alert('Priority Number should be positive');
         txtPriorityNumber.focus();
         return;
       }
      if(!isNumeric(txtOrderNumber.value))
       {
         alert('Order Number should be positive');
         txtOrderNumber.focus();
         return;
       }
       if(!isNumeric(txtTagID.value))
       {
         alert('Tag ID should be positive');
         txtTagID.focus();
         return;
       }
       if(!isNumeric(txtRowNumber.value))
       {
         alert('Row Number should be positive');
         txtRowNumber.focus();
         return;
       }
       
        PriorityNumber = PriorityNumber + txtPriorityNumber.value + ','
        if (txtOrderNumber.value=="" || txtOrderNumber.value==" ")
       {
         alert('Order Number should not be blank.');
         txtOrderNumber.focus();
         return;
       }
       
       OrderNumber = OrderNumber + txtOrderNumber.value + ','
        if (txtTagID.value=="" || txtTagID.value==" ")
       {
         alert('TagID should not be blank.');
         txtTagID.focus();
         return;
       }
      
        TagID = TagID + txtTagID.value + ','
        if (txtRowNumber.value=="" || txtRowNumber.value==" ")
       {
         alert('Row Number should not be blank.');
         txtTagID.focus();
         return;
       }
      
       RowNumber = RowNumber + txtRowNumber.value + ','
     }
    
    objform.action="../Home/ControlMenuGroup.aspx?Action=SAVE&MenuGroupID=" + <%=m_strMenuGroupID %> + "&PriorityNumbers="+PriorityNumber+"&OrderNumbers="+OrderNumber+"&RowNumbers="+RowNumber+"&TagIDs="+TagID +"&ControlItemIDs="+objControlItemIDs.value; 
    objform.submit();
    window.close();
    }
    function Close_OnClick()
    {
     window.close();
    }
     
       // function refreshParent()
       // {
       // var strParentPage= '../General/CommonPage.aspx?MasterTagID=2729';
       // refreshParent('frmCommonPage', 'CommonPage.aspx', strParentPage);
       // }
    
    </script>	
</body>
</html>
