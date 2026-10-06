<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MyFavorites.aspx.vb" Inherits="PbNIT.MyFavorites" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("MyFavorites")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmMyFavorites" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmMyFavorites');
		var objdivlist=GetObjectReference('frmMyFavorites','PageDiv');
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function AddToMyFavorites_OnClick()
		{
			window.open("MyFavorites.aspx?MODE=1","","resizable=yes,scrollbars=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 550)/2 + ",width=450,height=560");  
		}
		
		function Edit_Favorites_On_click(FavoriteID)
		{
			window.open("MyFavorites.aspx?MODE=3&FavoriteID=" + FavoriteID ,"","resizable=yes,scrollbars=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=500,height=250");  
		}
		
		function Delete_OnClick()
		{
			var objchkDelect = GetObjectReference('frmMyFavorites','chkSelect', true);	
			var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmMyFavorites','chkSelect');					
			if (blnIsRecordSelected == false) {return;}
		
			objform.action="MyFavorites.aspx?MODE=0&ACTION=0"
			objform.submit()
		}
		
		function ModuleChange()
		{
			var objModule = GetObjectReference('frmMyFavorites','cboModule');
			objform.action ="MyFavorites.aspx?MODE=1&MODULE=" + objModule.value;
			objform.submit();
			
		}
		function FavoritesSaveOnClick()
		{
		var objchkSelect = GetObjectReference('frmMyFavorites','chkSelect', true);	
		var objcboParent = GetObjectReference('frmMyFavorites','cboParent');	
		var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmMyFavorites','chkSelect')
		var objModule = GetObjectReference('frmMyFavorites','cboModule');
		
		if (blnIsRecordSelected == false) {return;}
		
		objform.action="MyFavorites.aspx?MODE=1&ACTION=1&MODULE=" + objModule.value + "&ParentNodeID=" + objcboParent.value 
		objform.submit()
			
		}
		
		function FavoritesUpdateOnClick()
		{
			var objcboParent = GetObjectReference('frmMyFavorites','cboParent');	
			objform.action="MyFavorites.aspx?MODE=3&ACTION=3&FavoriteID=<%=m_strFavoriteID%>&ParentNodeID=" + objcboParent.value 
			objform.submit()
		}
		
		function SelectAll_OnClick()
		{
			SelectAllCheckboxs('frmMyFavorites','chkSelect');return;
		}
		
		function AllClear()
		{			
			ClearAll_OnClick('frmMyFavorites','chkSelect');return;
		}
		
		function AddParent_OnClick() 
		{
			window.open("MyFavorites.aspx?MODE=2","","resizable=yes,scrollbars=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=500,height=250");  			
		}
		
		function AddParentSave_OnClick()
		{
			var objtxtParent = GetObjectReference('frmMyFavorites','txtParent');
			var objcboParent = GetObjectReference('frmMyFavorites','cboParent');	

			if (disallowBlank(objtxtParent,'<%=Mybase.getResourceString("MSG_PARENT_BLANK")%>' ,true) == true) return;
			
			objform.action="MyFavorites.aspx?MODE=2&ACTION=2&ParentNodeID=" + objcboParent.value ;
			objform.submit()			
		}
		function ListParent_OnClick()
		{
			window.open("MyFavorites.aspx?MODE=4","","resizable=yes,scrollbars=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=500,height=250");  			
		}
		
		function Edit_Parnet_On_click(FavoriteID)
		{
			var objcboParent = GetObjectReference('frmMyFavorites','cboParent');	
			
			window.open("MyFavorites.aspx?MODE=5&FavoriteID=" + FavoriteID  ,"","resizable=yes,scrollbars=no,statusbar=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=500,height=250");  
		}
		
		function ParnetUpdateOnClick()
		{
			var objtxtParent = GetObjectReference('frmMyFavorites','txtParent');
			var objcboParent = GetObjectReference('frmMyFavorites','cboParent');	
			if (disallowBlank(objtxtParent,'<%=Mybase.getResourceString("MSG_PARENT_BLANK")%>' ,true) == true) return;
			
			objform.action="MyFavorites.aspx?MODE=5&ACTION=5&FavoriteID=<%=m_strFavoriteID%>&ParentNodeID=" + objcboParent.value ;
			objform.submit();
		}
		
		function DeleteParent_OnClick()
		{
			var objchkDelect = GetObjectReference('frmMyFavorites','chkSelect', true);	
			var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmMyFavorites','chkSelect');					
			if (blnIsRecordSelected == false) {return;}
		
			objform.action="MyFavorites.aspx?MODE=4&ACTION=4";
			objform.submit();
		}
		</Script>
	</body>
</HTML>
