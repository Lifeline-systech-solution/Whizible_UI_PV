<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_ModifyEntityDetails.aspx.vb" Inherits="Whiz.QRB_ModifyEntityDetails" %>
<!DOCTYPE HTML>
<HTML>
	<%MyBase.InitializeResources("Resources.QRB_EntityAccess", "Resources")%>
	<%
	If Request.QueryString("Mode") = CONST_EDIT_ENTITY Or Request.QueryString("Mode") = CONST_ATTRIBUTE_EDIT Then
        CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("WINDOW_TITLE_EDIT_ENTITY"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>") 'WAF3_PB_42 April 06, 2007 UmeshJ
    Else
	        CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("WINDOW_TITLE"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>") 'WAF3_PB_42 April 06, 2007 UmeshJ	        
    End If
    %>
	

    <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmModifyEntityDetails" name="frmModifyEntityDetails" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">

		var objdivlist;
		var objform;
		var intLength;
		var arrNames;
		
		
		//	 Added By Shrikant B For WAF3_PB_64
        <% 
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
        End If
        %>
        //End Addition by Shrikant B For WAF3_PB_64
		
		intLength = <%=m_arrEntityNAttributeName.Length%>;
		arrNames = new Array(intLength);
		
		<%For m_intCnt = 0 to m_arrEntityNAttributeName.Length-1%>
			arrNames[<%=m_intCnt%>] = "<%=m_arrEntityNAttributeName(m_intCnt)%>";
		<%Next%> 
						
		objform=GetFormReference('frmModifyEntityDetails');
		objdivlist=GetObjectReference('frmModifyEntityDetails','DivList');
		
		<%MyBase.InitializeResources("Resources.QRB_EntityAccess", "Resources")%>;
<% 'WAF3_PB_42 April 10, 2007 Removed local functions window_onresize and window_onload %>					
		function EntitySave_OnClick()
		{
			var save=false;
			var objTxt,cnt;
			var NewName;
			
			objTxt = GetObjectReference('frmModifyEntityDetails','txtEntityName');
			save = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_EMPTY_ENTITY_NAME")%>',true);
			if(save==false)
			{
				save = disallowSpecialCharacters(objTxt,'<%=MyBase.GetResourceString("MSG_SPECIALCHARACTER_ENTITY_NAME")%>',true);	
				if(save==false)
				{
					save=true;
					NewName = objTxt.value;
					for(cnt=0;cnt<intLength;cnt++)
					{
						if(NewName == arrNames[cnt])
						{
							save=false;
							alert('<%=MyBase.GetResourceString("MSG_DUPLICATE_ENTITY_NAME")%>');
							objTxt.focus();
							break;
						}							
					}
				}
				else
					save=false;
		
			}
			else
				save=false;
					
			if(save==true)
			{
				objform.action = "QRB_ModifyEntityDetails.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EntityID=<%=m_lngEntityID%>&AttributeID=<%=m_lngAttributeID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&RoleID=<%=m_lngRoleID%>"; 
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
		function Attribute_OnClick(AttID)
		{
			objform.action = "QRB_ModifyEntityDetails.aspx?Mode=<%=CONST_ATTRIBUTE_EDIT%>&EntityID=<%=m_lngEntityID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&RoleID=<%=m_lngRoleID%>&AttributeID=" + AttID; 
			objform.submit();
		}
		function Back_OnClick()
		{
			objform.action = "QRB_ModifyEntityDetails.aspx?Mode=<%=CONST_EDIT_ENTITY%>&EntityID=<%=m_lngEntityID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&RoleID=<%=m_lngRoleID%>";
			if (ShowNavigationAlert()==false) return;//Added By Shrikant B WAF3_PB_64
			objform.submit();
		}
		function AttributeSave_OnClick()
		{
			var save=false;
			var objTxt,val,NewName;
			var objChk;
			
			objTxt = GetObjectReference('frmModifyEntityDetails','txtAttributeName');
			save = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_EMPTY_ATTRIBUTE_NAME")%>',true);
			if(save==false)
			{
				save = disallowSpecialCharacters(objTxt,'<%=MyBase.GetResourceString("MSG_SPECIALCHARACTER_ATTRIBUTE_NAME")%>',true);	
				if(save==false)
				{
					save=true;
					NewName = objTxt.value;
					for(cnt=0;cnt<intLength;cnt++)
					{
						if(NewName == arrNames[cnt])
						{
							save=false;
							alert('<%=MyBase.GetResourceString("MSG_DUPLICATE_ATTRIBUTE_NAME")%>');
							objTxt.focus();
							break;
						}							
					}
				}
				else
					save=false;
				
			}
			else
				save=false;
		
			if("<%=m_strShowDrillDown%>" == "1")
			{
				objChk = GetObjectReference('frmModifyEntityDetails','chkIsDrillDown');
				if(objChk.checked == true )
				{
					objTxt = GetObjectReference('frmModifyEntityDetails','txtOrderNumber');
					save = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_EMPTY_ORDERNUMBER")%>',true);		
					if(save==false)
					{
						save=true;
						save = disallowNonNumeric(objTxt,'<%=MyBase.GetResourceString("MSG_NONNUMERIC_ORDERNUMBER")%>',true)
						if(save==false)
						{
							save=true;
							save = disallowNonInteger(objTxt,'<%=MyBase.GetResourceString("MSG_NONNUMERIC_ORDERNUMBER")%>',true)
							if(save==false)
							{
								save=true;
								save = disallowNegativeInteger(objTxt,'<%=MyBase.GetResourceString("MSG_NONNUMERIC_ORDERNUMBER")%>',true)
								if(save==false)
									save=true;
								else
									save=false;
							}
							else
								save=false;
						}
						else
							save=false;
					}
					else
						save=false;
				}
			}
			
			if(save==true)
			{
				objform.action = "QRB_ModifyEntityDetails.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EntityID=<%=m_lngEntityID%>&AttributeID=<%=m_lngAttributeID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&RoleID=<%=m_lngRoleID%>"; 
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
		function DrillDown_OnChange()
		{
			var objChk,objTxt;
			objChk = GetObjectReference('frmModifyEntityDetails','chkIsDrillDown');
			objTxt = GetObjectReference('frmModifyEntityDetails','txtOrderNumber');
			if(objChk.checked == false)
				objTxt.disabled=true;
			else
				objTxt.disabled=false;
		}
		function InheritSave_OnClick()
		{
			var save;
			var cboSource,cboDestination;
			
			cboSource = GetObjectReference('frmModifyEntityDetails','cboSourceRole');
			cboDestination = GetObjectReference('frmModifyEntityDetails','cboDestinationRole');
			
			save = disallowBlank(cboSource,'<%=MyBase.GetResourceString("MSG_EMPTY_SOURCEROLE")%>',true);		
			if(save==false)
			{
				save = disallowBlank(cboDestination,'<%=MyBase.GetResourceString("MSG_EMPTY_DESTINATIONROLE")%>',true);		
				if(save==false)	
				{
				//Requirement ID � WAF3_QB_IssueFixes 2
						if(cboSource.value==cboDestination.value)
						{
							alert('<%=m_strValidationMsgSourceDestinationSame%>');
							setFocus(cboDestination);
							return ;
						}
				
					objform.action = "QRB_ModifyEntityDetails.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&EntityID=<%=m_lngEntityID%>&AttributeID=<%=m_lngAttributeID%>&MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&RoleID=<%=m_lngRoleID%>"; 
					blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
					objform.submit();
				}
			}
		}

		</script>

	</body>
</HTML>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<script type="text/javascript">
$(document).ready(function()
{
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:17/02/2015
    /*---------------------------------------------------------*/
    if($('.clsGridTable').length > 0)
    {
        var divName=$('.clsBody').find('#DivList').attr('id');
        dataCollapse(divName);
    }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Apply FooTable
    /*---------------------------------------------------------*/


    /*----------------------------------------------------------*/
     // Starts Feature Tag:whiz41-InnerMenuDropDown
     // Description:Creating DropDown for Top Table Inner Menu on document Ready
     // By Whom: Miiint
     // When:17/02/2015
     /*---------------------------------------------------------*/
      responsiveTopMenu();
      /*---------------------------------------------------------*/
      // Ends Feature Tag:whiz41-InnerMenuDropDown
      /*---------------------------------------------------------*/


     /*----------------------------------------------------------*/
       // Starts Feature Tag:whiz41-InnerMenuDropDown
       // Description:Creating DropDown for Footer Table Inner Menu on document Ready
       // By Whom: Miiint
       // When:17/02/2015
       /*---------------------------------------------------------*/
       responsiveFooterMenu();
       /*---------------------------------------------------------*/
       // Ends Feature Tag:whiz41-InnerMenuDropDown
       /*---------------------------------------------------------*/
});


$(window).resize(function(){

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
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
