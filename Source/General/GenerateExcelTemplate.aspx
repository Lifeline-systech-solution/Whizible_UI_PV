<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GenerateExcelTemplate.aspx.vb" Inherits="Whiz.GenerateExcelTemplate" %>
<!DOCTYPE HTML>
<HTML>
<%CommonFunctions.General.PlotPageHeadTag(CommonFunctions.General.CheckIsNothing("Excel Download"))%>
<BODY class=clsBody onload='window_onload()' onresize='window_onresize()'>
<FORM id='frmDownload' name='frmDownload' method=post enctype='multipart/form-data'>

<script language=javascript >
   var objfrm;
          var objdivlist;
          var objFile =GetObjectReference('frmDownload','frmDownload');
          objfrm = GetFormReference('frmDownload')
          objdivlist=GetObjectReference('frmDownload','DivList');
 //window resize for Common Page"
        function window_onresize()
        	{
        		var intDivHeight ;
        		var intDivHeightRisk;
        		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        		if (intDivHeight < 100)
        			intDivHeight = 100;
        				
        		objdivlist.style.height = intDivHeight	;
        	}

        	//window onload for Common list
        	function window_onload()
        	{
        		var intDivHeight ;
        		var intDivHeightRisk;
        		var lc;
        		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
        		if (intDivHeight < 100)
        			intDivHeight = 100;
        		objdivlist.style.height = intDivHeight	;
        	}
        	function Close_Onclick() 
        	{
				window.close();
			}
        	
</script> 
</FORM>
</BODY>
</HTML>