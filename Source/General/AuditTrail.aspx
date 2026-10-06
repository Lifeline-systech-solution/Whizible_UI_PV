<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AuditTrail.aspx.vb" Inherits="Whiz.AuditTrail" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>AuditTrail</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">
		<meta name="CODE_LANGUAGE" content="Visual Basic 7.0">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<LINK href="../General/StyleSheetChanakya.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../General/CommonFunctions.js"></script>
	</HEAD>
	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()">
		<form id="frmAuditTrail" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
			var objdivlist;
			objdivlist=GetObjectReference('frmControlGridView','DivList');
			
			<%' Added By SonalD on 22nd Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 22nd Jan 2009 %>
			
			function window_onresize()		
			{
				
				var intDivHeight ;
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				if (intDivHeight < 100)
					intDivHeight = 100;
						
				objdivlist.style.height = intDivHeight +'px'	;		
			}
					
			function window_onload()
			{
				var intDivHeight ;
					
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
				if (intDivHeight < 100)
					intDivHeight = 100;
				
				objdivlist.style.height = intDivHeight	 +'px';			
					
			}
			function Sort_OnClick(sortby,sortorder)
			{
				var objParamTagID = GetObjectReference('frmAuditTrail','paramTagID');
				var objParamIsSubTag = GetObjectReference('frmAuditTrail','paramIsSubTag');
				var objParamProjectID = GetObjectReference('frmAuditTrail','paramProjectID');
				var objParamUniqueID = GetObjectReference('frmAuditTrail','paramUniqueID');
				window.location.href = "AuditTrail.aspx?sortby=" + sortby + "&sortorder=" + sortorder + "&TagID=" + objParamTagID.value + "&IsSubTag=" + objParamIsSubTag.value + "&ProjectID=" + objParamProjectID.value + "&UniqueID=" + objParamUniqueID.value;
			}
		</script>
	</body>
</HTML>
