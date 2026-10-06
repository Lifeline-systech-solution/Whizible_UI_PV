<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default_NewsArticles.aspx.vb" Inherits="PbNIT.Default_NewsArticles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<script language='javascript' src='../General/CommonFunctions.js'></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
<link href='../../images/NewHomePage2/images/skin.css' rel='stylesheet' type='text/css' />

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>

</head>



<body  >

    <form id="Frm_NewArticles" runat="server">
        <%DrawPage()%>
    </form>
    <script language="javascript" >
    
   /*var ObjModules=GetObjectReference('','trModules',true); 
   var CurrentModuleIndex=0;
    
   if(ObjModules.length>0)
    ObjModules[0].className='clsTRMenuMouseOver';  */
    
   function ModulesOnMouseOver(obj)
	{
	    obj.className='clsTRMenuMouseOver';
	}
	function ModulesOnMouseOut(obj,Index)
	{
	    if(CurrentModuleIndex!=Index)
	        obj.className='clsTRMenu';
	}
	
	function Tab_OnClick(ArticleID,Index)
	{   
	    var i;
	
	    CurrentModuleIndex=Index;
	    /*for(i=0;i<ObjModules.length;i++)
	    {
	        if(i==Index)
	            ObjModules[i].className='clsTRMenuMouseOver';
	        else
	            ObjModules[i].className='clsTRMenu';	            	        
	    }	   */ 
	
	    ObjParentFrame=GetParentFrameReference();
	    if (navigator.appName == 'Microsoft Internet Explorer')
	        ObjParentFrame["About"].location="../Home/Default_NewsArticles.aspx?ArticleID="+ArticleID;
	    else
	    {
	     for(i=0;i<ObjParentFrame.length;i++)
	     {
	        if(ObjParentFrame[i].frameElement.id=="About")
	        {
	            ObjParentFrame[i].frameElement.src="Source/Home/Default_NewsArticles.aspx?ArticleID="+ArticleID;
	            break;
            }
	     }
	   }
	}
	
	function MoveDown()
	{
	    ObjDiv=GetObjectReference('','DivMain1');
	    
	    if(ObjDiv!=null)
	    ObjDiv.scrollTop=ObjDiv.scrollTop+10;
	}
	
    function MoveUp()
	{
	    ObjDiv=GetObjectReference('','DivMain1');
	    
	    if(ObjDiv!=null)
	    ObjDiv.scrollTop=ObjDiv.scrollTop-10;
	}
	
		objDivMain=GetObjectReference('','DivMain');
        ObjTbl=GetObjectReference('','TblArticles');
        ObjDiv1=GetObjectReference('','DivMain1');
	
	function window_onload()
	{
        if (objDivMain != null) 
        {
            if (navigator.appName == 'Microsoft Internet Explorer')
            {
		        intDivHeight = document.body.offsetHeight - objDivMain.offsetTop;
            }
		    else
		    {
		        intDivHeight = window.innerHeight - objDivMain.offsetTop;
            }
		    if (intDivHeight < 100)
			    intDivHeight = 100;
        			
            objDivMain.style.height = intDivHeight +'px';
            if(ObjDiv1!=null)
            ObjDiv1.style.height= parseInt(intDivHeight * 68/100) +'px';
        }
        

	    if(ObjDiv1!=null && ObjTbl!=null)
	        if(ObjDiv1.offsetHeight>ObjTbl.offsetHeight)
	            ObjDiv1.style.height=ObjTbl.offsetHeight;   
     
	}	
	
	
   function window_onresize()
    {
			var intDivHeight;
			intDivHeight = document.body.offsetHeight - objDivMain.offsetTop-5  ;
			if (intDivHeight < 100)	intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';	        
    }
    


	
   </script>
</body>
</html>
