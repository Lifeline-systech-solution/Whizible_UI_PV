<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_InheritStatusFlow.aspx.vb" Inherits="PbNIT.SM_InheritStatusFlow" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<%  CommonFunctions.General.PlotPageHeadTag("Inherit Status Flow")%>

<body class="clsBody" onload="window_onload()" onresize="window_onresize()">
    <form id="frmInheritStatusFlow" runat="server" method="post">
    <%PageInit()%>
     
    </form>
    
     <script language="javascript">
    var objdivlist = GetObjectReference('frmInheritStatusFlow', 'PageDiv');
    var objform = GetFormReference('frmInheritStatusFlow');
    
    function window_onresize()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (navigator.appName == 'Microsoft Internet Explorer')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 260;
			}
			else
			{
				intDivHeight = window.innerHeight + 260;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight;
			//CallOnLoad()		
		}

		function window_onload()
		{
								
				var intDivHeight ;
				var intDivHeightRisk;
				var lc;
				if (navigator.appName == 'Microsoft Internet Explorer'){
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 260;
				}
				else{
				intDivHeight = window.innerHeight - objdivlist.offsetTop + 260;
				}
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight;
				objdivlist.HEIGHT = intDivHeight;
				//CallOnLoad()
				
		}
		function Inherit_onClick()
		{
		
		     var objcboFromSubType = GetObjectReference('frmInheritStatusFlow','cboFromType');  
		     var objcboToSubType = GetObjectReference('frmInheritStatusFlow','cboToType');
		     if (objcboFromSubType.value=='')
		     {
		        alert('Please select From Sub type');
		        return;
		       }
		       if (objcboToSubType.value=='')
		        {
		        alert('Please select To Sub type');
		        return;
		       }
		    objform.action="SM_InheritStatusFlow.aspx?Action=INHERIT";
		    objform.submit();
		}
		function Close_onClick()
		{
		    window.close();
		}
		
		</script>
</body>
</html>
