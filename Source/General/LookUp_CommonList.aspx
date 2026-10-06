<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LookUp_CommonList.aspx.vb" Inherits="Whiz.LookUp_CommonList" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmLookUPList" name="frmLookUPList" method="post" runat="server">
			<%WritePage()%>
		</form>
		
		<SCRIPT language="javascript">

			var g_objdivlist;
			var g_objfrm;
			var g_objMode;
			var g_strURL;

			g_objdivlist = GetObjectReference('frmLookUPList','DivList');
			g_objfrm = GetFormReference('frmLookUPList');
			g_strURL = "../General/LookUp_CommonList.aspx";
			
			if('<%=m_bIsModalPopupEnabled%>' == 'True')
			{
			    document.body.className = 'clsModalBody'; 
			}
			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				
				intDivHeight = document.body.offsetHeight - g_objdivlist.offsetTop - 38;
				if (intDivHeight < 100)
					intDivHeight = 100;
				g_objdivlist.style.height = intDivHeight;
			}

			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;

				intDivHeight = document.body.offsetHeight - g_objdivlist.offsetTop - 38;
				if (intDivHeight < 100)
					intDivHeight = 100;

				g_objdivlist.style.height = intDivHeight;		
			}


			function Link_OnClick(strSelectedVal)
			{		
					
				var objParentCombo,index,count,intCurrIndex;
				if('<%=m_bIsModalPopupEnabled%>' == 'True')
				{
                    if('<%=m_strRowIndex%>'=='')
				        objParentCombo = window.parent.document.getElementById('<%=m_strControlName%>');
				    else
				        objParentCombo = window.parent.document.getElementsByName('<%=m_strControlName%>')<%=m_strRowIndex%>;				    
				}
				else
				{
				    if('<%=m_strRowIndex%>'=='')
				        objParentCombo = GetParentObjectReference('<%=m_strFormName%>','<%=m_strControlName%>');
				    else
				        objParentCombo = window.opener.document.getElementsByName('<%=m_strControlName%>')<%=m_strRowIndex%>;
					    //objParentCombo = GetParentObjectReference('<%=m_strFormName%>','<%=m_strControlName%>',true)<%=m_strRowIndex%>;
			    }
				if(objParentCombo!=null)
				{
					for(count=0; count < objParentCombo.length; count++)
					{
						if(objParentCombo.options[count].value == strSelectedVal)
						{
							index = count; 
							break;
						}
					}
					intCurrIndex = objParentCombo.selectedIndex;
					if (intCurrIndex != index)
					{
						objParentCombo.selectedIndex=index;
						if(navigator.appName == 'Microsoft Internet Explorer')
						{objParentCombo.fireEvent('onChange');}
						else{objParentCombo.onchange();}
					}
					objParentCombo = null;
				}
				if('<%=m_bIsModalPopupEnabled%>' == 'True')
				{
				    CloseDivForModalPopUp(true);
				}
				else
				{
				    window.close();
				}
			}
			
		</SCRIPT>		
	</body>
</HTML>

