<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_EntityAccess.aspx.vb" Inherits="Whiz.QRB_EntityAccess" %>
<!DOCTYPE HTML>
<HTML>	
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle, , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>	
	

    <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmEntityAccess" name="frmEntityAccess" method="post" runat="server">
			<%PageInit()%>
		</form>	
		<script language=javascript>
			var objdivlist;
			var objform;
							
			objform=GetFormReference('frmEntityAccess');
			objdivlist=GetObjectReference('frmEntityAccess','DivList');
				
			<%MyBase.InitializeResources("Resources.QRB_EntityAccess", "Resources")%>;
					
			function window_onload(intFillFactor)		
			{
		        windowSize_common(intFillFactor);	<% 'WAF3_PB_42 April 10, 2007 Call function for the common code %>			
				intScriptNo = <%=m_lngClientSideScript%>;				
				if(intScriptNo >= 0)
				{
					if(intScriptNo==1)
					{
						Attribute_Back();
					}
					else if(intScriptNo==2)
					{
						opener.location.href="QRB_EntityAccess.aspx?Mode=<%=CONST_ROLE_LIST%>&EntityID=<%=m_lngEntityID%>&RoleID=<%=m_lngRoleID%>&MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
						window.close();						 
					}
				}
			}
<% 'WAF3_PB_42 April 10, 2007 Removed local functions for window resize %>			
			function Role_OnClick(RoleID)
			{
				window.open("QRB_EntityAccess.aspx?Mode=<%=CONST_ROLE_EDIT%>&MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>&EntityID=<%=m_lngEntityID%>&RoleID=" + RoleID ,"","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-650)/2 + ",top=" + (window.screen.height-450)/2 + ",width=650,height=450");
			}
			function Sort_OnClick(sortby,sortorder)
			{
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=m_strMode%>&MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>&strSortBy=" + sortby + "&strSortOrder=" + sortorder; 
				objform.submit();  
			}
			function SelectAll_OnClick()
			{	var rowcount;
				var objTxt,i;
				
				objTxt = GetObjectReference('frmEntityAccess','hdtxtRowCount'); 
				rowcount = objTxt.value;
				if(rowcount>0)
				{
					var objChk;
					objChk = GetObjectReference('frmEntityAccess','chkAccess',true); 
						
					for(i=0;i<rowcount;i++)
						objChk[i].checked = true;
				}
			}
			function RoleSave_OnClick()
			{
				var objTxt,objChk;
				var count,i;
				var selected=false;
								
				objTxt = GetObjectReference('frmEntityAccess','hdtxtRowCount'); 
				objChk = GetObjectReference('frmEntityAccess','chkAccess',true); 
				count = objTxt.value;
														
				for(i=0;i<count;i++)
				{
					if(objChk[i].checked==true && objChk[i].disabled==false)
					{						
						selected=true;		
						break;	
					}
				}
				
				if(selected==true)
				{
					objform.action = "QRB_EntityAccess.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ROLE_LIST_ACTION_SAVE%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>&strSortBy=<%=m_strSortBy%>&strSortOrder=<%=m_strSortOrder%>"; 
					objform.submit();  
				}
			}
			function RemoveAllAccess_OnClick()
			{
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ROLE_LIST_ACTION_REMOVE_ALL%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>&strSortBy=<%=m_strSortBy%>&strSortOrder=<%=m_strSortOrder%>"; 
				objform.submit();  
			}
			function InheritRole_OnClick()
			{
				window.open("QRB_ModifyEntityDetails.aspx?Mode=<%=CONST_INHERIT_ACCESS%>&EntityID=<%=m_lngEntityID%>&MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-550)/2 + ",top=" + (window.screen.height-250)/2 + ",width=550,height=250");
			}
			function ModifyEntity_OnClick()
			{
				window.open("QRB_ModifyEntityDetails.aspx?Mode=<%=CONST_EDIT_ENTITY%>&EntityID=<%=m_lngEntityID%>&MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-450)/2 + ",width=600,height=450");
			}
			function RoleEditSave_OnClick()
			{
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ROLE_EDIT_ACTION_SAVE%>&EntityID=<%=m_lngEntityID%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>&strSortBy=<%=m_strSortBy%>&strSortOrder=<%=m_strSortOrder%>"; 
				objform.submit();  
			}
			function RemoveEntityAccess_OnClick()
			{  
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ROLE_EDIT_ACTION_REMOVE_ALL%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>&strSortBy=<%=m_strSortBy%>&strSortOrder=<%=m_strSortOrder%>"; 
				objform.submit();  
			}
			function Role_Next()
			{
				var objTxt,objChk;
				var count,i;
				var selected=false;
				var RoleIDList;
				RoleIDList='';
				
				objTxt = GetObjectReference('frmEntityAccess','hdtxtRowCount'); 
				objChk = GetObjectReference('frmEntityAccess','chkAccess',true); 
				count = objTxt.value;
														
				for(i=0;i<count;i++)
				{
					if(objChk[i].checked==true && objChk[i].disabled==false)
					{						
						selected=true;		
						RoleIDList = RoleIDList + objChk[i].value + ",";
					}
				}
				
				if(selected==true)
				{	
					objform.action = "QRB_EntityAccess.aspx?Mode=<%=CONST_ATT_LIST%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>&RoleIDList=" + RoleIDList; 
					objform.submit();  
				}
				else
				{	
					alert("<%=mybase.getResourceString("MSG_SELECTROLE")%>");
				}
			}	
			function Role_Back()
			{
				window.location.href ="../General/CommonList.aspx?MasterTagID=<%=m_lngMasterTagID%>&FromWhere=<%=m_strFromWhere%>";
				
			}
			function Attribute_Back()
			{
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=CONST_ROLE_LIST%>&FromWhere=<%=m_strFromWhere%>&MasterTagID=<%=m_lngMasterTagID%>"; 
				objform.submit(); 
			}
			function AttributeSave_OnClick()
			{
				objform.action = "QRB_EntityAccess.aspx?Mode=<%=CONST_ATT_LIST%>&FromWhere=<%=m_strFromWhere%>&Action=<%=CONST_ATTRIBUTE_ACTION_SAVE%>&MasterTagID=<%=m_lngMasterTagID%>&strSortBy=<%=m_strSortBy%>&strSortOrder=<%=m_strSortOrder%>"; 
				objform.submit();  
			}
		</script>
	</body>
</HTML>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<script type="text/javascript">
$(document).ready(function(){

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:13/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:13/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

});


$(window).resize(function(){
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/
 });
 </script>

