<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ConfigureGadgetNodes.aspx.vb" Inherits="PbNIT.ConfigureGadgetNodes" %>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Cofigure Gadget Node")%>
<body class="clsFullPageBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">
		<STYLE type="text/css"> 
	        #PictBox .PictBox_content { BORDER-RIGHT: #317082 2px solid; PADDING-RIGHT: 5px; BORDER-TOP: #317082 2px solid; PADDING-LEFT: 5px; FONT-SIZE: 0.5em; Z-INDEX: 1000; PADDING-BOTTOM: 5px; OVERFLOW: auto; BORDER-LEFT: #317082 2px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #317082 2px solid; BACKGROUND-COLOR: #ffffff; }
	    </STYLE>
					<form id="frmConfigGadgetNode" method="post" runat="server" enctype='multipart/form-data'>
									<%WritePage()%>
							
		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER:alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
				
		<div class="PictBox" id="PictBox" style="Z-INDEX:1000;display:none;position:absolute;width:500px;left:200;top:300"> 
		<form action="" name="frmFile" id="frmFile" method="post"   target="frame" enctype="multipart/form-data">
		<input type="hidden" name="frmFile_hidOldFileQues" id="frmFile_hidOldFileQues" value="" />
		
		
		<div class="PictBox_content">
		<Table class="clsTable" width="99.9%" >
		<tr class="clsTREven">
		<td>
			<input  size="74" class="clsTextBox" type="file" name="PictFile" id="PictFile" onkeydown='return false' onbeforepaste='return false' onpaste='return false' />
		</td>
		</tr>
		<tr>
		<td>
			<input type="button" class="ButtonStyle" onclick="uploadPict()" value="Upload" />
			<input type="button" class="ButtonStyle" onclick="ClosePictBox()" value="Cancel" />
		</td>
		</tr>	
		</Table>
		</div>
		</form>
	</div>
</form>

<script language="javascript">

var objfrm = GetFormReference('frmConfigGadgetNode');
var objdivlist = GetObjectReference('frmConfigGadgetNode', 'PageDiv');
var oDivFile = GetObjectReference("","PictBox");
var ofillDiv = GetObjectReference("","fillDiv");
var objCheckbox = GetObjectReference('frmConfigGadgetNode','chkSelect',true);
var GroupName = GetObjectReference('frmConfigGadgetNode','chkSelect',true);
var ModuleName = GetObjectReference('frmConfigGadgetNode','chkSelect',true);
var ParentNode = GetObjectReference('frmConfigGadgetNode','chkSelect',true);

var objcboModuleNAme=GetObjectReference('frmConfigGadgetNode','cboModuleName');
var objcboGadgetName=GetObjectReference('frmConfigGadgetNode','cboGadgetName');
var objtxtNodeName=GetObjectReference('frmConfigGadgetNode','txtNewNodeName');

<%' Added By SonalD on 22nd Jan 2009 %>
<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
<%End If%>
<%' Added By SonalD on 22nd Jan 2009 %>

function window_onload()
{
		var intDivHeight;
		var intDivHeightRisk;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 42;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - 42;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight;
		objdivlist.HEIGHT = intDivHeight +'px';
		
	//var blnreadonly=<%=m_isreadonly%>";
	//	alert(blnreadonly);
	//	if (blnreadonly==true)
	//	{
	//	objcboModuleNAme.disabled=true;
	//	objcboGadgetName.disabled=true;
	//	}
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
    		
    objdivlist.style.height = intDivHeight +'px';
    	
}

function comboChanged()
{  
//****
    objfrm.action='ConfigureGadgetNodes.aspx?Action=comboChanged';
    objfrm.submit();
}

function comboNodeChanged()
{
    var x=document.getElementById("cboGadgetName");
    objtxtNodeName.value=x.options[x.selectedIndex].text;
    
}

/*function Parent_onChange()
{
    objfrm.action='ConfigureGadgetNodes.aspx?Action=comboChanged';
    objfrm.submit();
}*/

function Save_OnClick()
{
    var SelectedIDs=GetObjectReference('frmConfigGadgetNode','chkSelect',true);
    var IsSelected=GetObjectReference('frmConfigGadgetNode','hidIsSelected');
    var count=0;
    
    if(validateConrols() != false)
    {
        if (SelectedIDs!=null)
        {
            for(var i=0;i<SelectedIDs.length-1;i++)
            {
                if(SelectedIDs[i].checked==true)
                {
                    count+=1;
                }
            }
        }
         if(count>10)
        {
            alert('Gadgets cannot be more than 10');
            return;
        }
        //****
        objcboModuleNAme.disabled=false;
 	    objcboGadgetName.disabled=false;
        objfrm.action='ConfigureGadgetNodes.aspx?Action=SAVE&Mode=EDIT&Access=1&IsSelected=' + IsSelected.value;
        objfrm.submit();
    }
}

function ShowUploadDialog(GadgetNodeId,TagID)
{
    GetObjectReference("","PictFile").value="";
    oDivFile.style.display="";
    oDivFile.setAttribute("GadgetNodeId",GadgetNodeId);
    oDivFile.setAttribute("TagID",TagID);
    ofillDiv.style.display="";
    
}

 function uploadPict()
 {
    var GadgetNodeId = oDivFile.getAttribute("GadgetNodeId");
    var TagID = oDivFile.getAttribute("TagID");
    var Fromwhere;
    var IsSelected=GetObjectReference('frmConfigGadgetNode','hidIsSelected'); 
    
    if (TagID==0)
    Fromwhere="Header";
    else
    Fromwhere="Detail";
    //modified by SonalD on 25th Sept 2008 
    //objfrm.action="ConfigureGadgetNodes.aspx?Upload=1&Fromwhere=" + Fromwhere + "&GadgetNodeId=" + GadgetNodeId + "&TagID=" + TagID;
    objfrm.action="ConfigureGadgetNodes.aspx?Upload=1&Fromwhere=" + Fromwhere + "&GadgetNodeId=" + GadgetNodeId + "&TagID=" + TagID + "&IsSelected=" + IsSelected.value + "&Access=1";
    
    oDivFile.style.display="none";
    ofillDiv.style.display="none";
    var fileName = GetObjectReference("","PictFile").value;
    
    if(fileName!="")
    {   
       objfrm.submit();
    }
 }
 
  function ClosePictBox()
   {
    oDivFile.style.display="none";    
    ofillDiv.style.display="none";    
   }
   
   function validateConrols()
   { 
       // objcboModuleNAme=GetObjectReference('frmConfigGadgetNode','cboModuleName');
       // objcboGadgetName=GetObjectReference('frmConfigGadgetNode','cboGadgetName');
        if (disallowBlank(objcboModuleNAme,'Module Name should not be blank !',true))
		return false;
		if (disallowBlank(objcboGadgetName,'Gadget Name should not be blank !',true))
		return false;
		if (disallowBlank(objtxtNodeName,'Node Name should not be blank !',true))
		return false;
		
//        if (objCheckbox != null)
//        {
//	        intItems = objCheckbox.length;
//	        for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
//	        {
//	        if(objCheckbox[intCtr].checked == true)
//	        {
////		        var objtxtON=GetObjectReference('frmConfigGadgetNode','txtTagOrderNo_'+objCheckbox[intCtr].value)
////		        if(objtxtON!=null)
////		        {	
////		         
////			        if (disallowBlank(objtxtON,'Order No. should not be blank !',true))
////					        return false;
////			        if (disallowNegativeInteger(objtxtON,'Please enter only positive integer only !',true))
////					        return false;
////			        if(parseInt(objtxtON.value) == 0)
////			        { alert('Order No should be greater than zero !');return false;}	
////        		
////		        IsSelected = true;
////	          }
//	        }
//    	   	
//           }
//        	
//        }
   }
   
   function ModuleFilter_onChange()
   {
        var IsSelected=GetObjectReference('frmConfigGadgetNode','hidIsSelected');
        objfrm.action='ConfigureGadgetNodes.aspx?Action=AppliedFilter&Access=1&IsSelected=' + IsSelected.value;
        objfrm.submit();
   }
   function txtPageName_OnKeyPress(e)
   {
    var code; 
    var IsSelected=GetObjectReference('frmConfigGadgetNode','hidIsSelected');
	if (e.keyCode)
		code = e.keyCode;
	else
		if (e.which)
	code = e.which; 
	if(code==13) 
	{
		objfrm.action='ConfigureGadgetNodes.aspx?Action=AppliedFilter&Access=1&IsSelected='+ IsSelected.value; 
		objfrm.submit();
		 
	}
   }
   
   function Back_OnClick()
   {
      // window.location.href="../General/CommonList.aspx?FromWhere=SM&MasterTagId=3966"; 
        window.location.href="../General/ConfigureGadgetNode_CommonList.aspx?FromWhere=SM&MasterTagId=3966"; 
    }
    
    function ShowSelectedPages_OnClick()
    {
        
        objfrm.action='ConfigureGadgetNodes.aspx?IsSelected=1'; 
		objfrm.submit();
    }
    function ShowAllPages_OnClick()
    {
        objfrm.action='ConfigureGadgetNodes.aspx?IsSelected=0'; 
		objfrm.submit();
    }
    
//    function SaveandAdd_OnClick()
//    {
//        Save_OnClick();
//        window.location.href="../General/ConfigureGadgetNodes.aspx?Mode=ADD_NEW&MasterTagID=20013&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
//    }

//    function UploadImageForNode()
//    {
//        alert("Hello");
//        var GadgetNodeId = oDivFile.getAttribute("GadgetNodeId");
//        objfrm.action="ConfigureGadgetNodes.aspx?Upload=1&GadgetNodeId=" + GadgetNodeId;
//    
//        oDivFile.style.display="none";
//        ofillDiv.style.display="none";
//        var fileName = GetObjectReference("","PictFile").value;
//    
//        if(fileName!="")
//        {   
//            objfrm.submit();
//        }
//    }   
    
</script>
   
</body>
</html>
