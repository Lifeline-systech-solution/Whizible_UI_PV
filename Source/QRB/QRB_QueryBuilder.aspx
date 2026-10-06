<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_QueryBuilder.aspx.vb" Inherits="Whiz.QRB_QueryBuilder" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Query Builder",,,,"<script language='javascript' src='../QRB/QueryBuilder.js'></script>")%>
	

    <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"><% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id='frmQueryBuilder' method='post' runat='server'>
			<%WritePage()%>
		</form>
		<script language="javascript">
		<%=m_strRefreshCSScript%>
		</script>
		<script language="javascript">
		
		//	 Added By Shrikant B For WAF3_PB_64
        <% 
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'frmQueryBuilder';")
        Response.Write("blnNavigate = null;")
        End If
        %>
        //End Addition by Shrikant B For WAF3_PB_64
		
		objform = GetFormReference('frmQueryBuilder');
		objdivlist = GetObjectReference('frmQueryBuilder','divList');
		objchkField = GetObjectReference('frmQueryBuilder','chkField');
		objtxtValue = GetObjectReference('frmQueryBuilder','txtValue');
		objcboFields = GetObjectReference('frmQueryBuilder','cboFields');
		objcboFields2 = GetObjectReference('frmQueryBuilder','cboFields2');
		objlinkValidInputs = GetObjectReference('frmQueryBuilder','linkValidInputs');
		objtxtWhereClause = GetObjectReference('frmQueryBuilder','txtWhereClause');
		objtxtHiddenWhereClause = GetObjectReference('frmQueryBuilder','txtHiddenWhereClause');
		objtxtUndo = GetObjectReference('frmQueryBuilder','txtUndo');
		objtxtUndo2 = GetObjectReference('frmQueryBuilder','txtUndo2');
		objtxtRedo = GetObjectReference('frmQueryBuilder','txtRedo');
		objtxtRedo2 = GetObjectReference('frmQueryBuilder','txtRedo2');
		objcboOperators = GetObjectReference('frmQueryBuilder','cboOperators');
		objcboHiddenFields = GetObjectReference('frmQueryBuilder','cboHiddenFields'); 
		objtxtQueryName = GetObjectReference('frmQueryBuilder','txtQueryName'); 
		objlstView_FieldList= GetObjectReference('frmQueryBuilder','lstView_FieldList'); 
		objlstView_SelectedFields= GetObjectReference('frmQueryBuilder','lstView_SelectedFields'); 
		objlstSort_FieldList= GetObjectReference('frmQueryBuilder','lstSort_FieldList'); 
		objlstSort_SelectedFields= GetObjectReference('frmQueryBuilder','lstSort_SelectedFields'); 
		objlstGroupBy_FieldList= GetObjectReference('frmQueryBuilder','lstGroupBy_FieldList'); 
		objlstGroupBy_SelectedFields= GetObjectReference('frmQueryBuilder','lstGroupBy_SelectedFields'); 
		objcboFunction = GetObjectReference('frmQueryBuilder','cboFunction');
		objchkDynamicField = GetObjectReference('frmQueryBuilder','chkDynamicField');
		
		intTotalCount = <%=UBound(m_arrValue)%>;
		intPlaceHolderCount = <%=UBound(m_arrPlaceHolders)%>;
		
		arrInputs=new Array(intTotalCount);
		arrDataTypes=new Array(intTotalCount);
		arrValues=new Array(intTotalCount);
		arrUFValues=new Array(intTotalCount);
		arrAttributeID=new Array(intTotalCount);
		
		arrPlaceHolders = new Array(intPlaceHolderCount);
		arrPlaceHolderDataTypes = new Array(intPlaceHolderCount);
		
		<%For m_intCounterI = 0 to UBound(m_arrValue)%>
			arrInputs[<%=m_intCounterI%>] = "<%=m_arrValidInputs(m_intCounterI)%>";
			arrDataTypes[<%=m_intCounterI%>] = "<%=m_arrDataType(m_intCounterI)%>";
			arrValues[<%=m_intCounterI%>]= "<%=m_arrValue(m_intCounterI)%>";
			arrUFValues[<%=m_intCounterI%>]="<%=m_arrText(m_intCounterI)%>";
			arrAttributeID[<%=m_intCounterI%>]="<%=m_arrAttributeID(m_intCounterI)%>";
		<%Next%>
		
		<%For m_intCounterI = 0 to UBound(m_arrPlaceHolders)%>
			arrPlaceHolders[<%=m_intCounterI%>] = "<%=m_arrPlaceHolders(m_intCounterI)%>";
			arrPlaceHolderDataTypes[<%=m_intCounterI%>] = "<%=m_arrPlaceHolderDataTypes(m_intCounterI)%>";
		<%Next%>
		
		if ("<%=m_blnQueryUsesOracleDB%>" == "True")
		{
			blnIsOracleDB = true;
		}
		DraftQueryMsg = "<%=m_strDraftQueryMsg%>";
		
		function Save_OnClick()
		{
			if (trimString(objtxtQueryName.value) == "")
			{
				alert("Please enter the Query name !");
				objtxtQueryName.focus();
				return;
			}
			//Added By Shrikant, IssueID 20608
			if (disallowSpecialCharacters(objtxtQueryName,"Characters [/:*?+\"><|,\\\\] are not allowed within the 'Query Name'."))
			 {
				objtxtQueryName.focus();
				return;
			}
			//End Addition By Shrikant, IssueID 20608
			if (ValidateAndSelectListItem() == true)
			{					
				objform.action = "QRB_QueryBuilder.aspx?Action=SAVE&mode=<%=m_strMode%>&EntityID=<%=m_lngEntityID%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_lngMasterTagID%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit(); 
			}
		}
		function Execute_OnClick()
		{
			var mode;
			mode = "<%=trim(m_strMode & "").toupper%>";
			if (mode=="EDIT"  )
			{
				window.open ("QRB_UIBuilder.aspx?QueryID=<%=m_lngQueryID%>&EntityID=<%=m_lngEntityID%>","_QueryUI","resizable=yes,scrollbars=no,top=100,left=100,height=500,width=600");
			}
			else
			{
				alert("Please save the query before executing");
			}
		}
		function Validate_OnClick()
		{
			if (ValidateAndSelectListItem() == true)
			{			
				objform.action = "QRB_QueryBuilder.aspx?Action=VALIDATE&mode=<%=m_strMode%>&EntityID=<%=m_lngEntityID%>&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&MasterTagID=<%=m_lngMasterTagID%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit(); 
			}
	
		}
		function FormulaBuilder_OnClick()
		{
			//window.open ("QRB_FormulaBuilder.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>","_FormulaBuilder","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 918)/2) + ",top=" + ((window.screen.height - 600)/2) + ",height=600,width=918"); //Modified By Ninad on 23 Aug 2007, Issue ID - 14057
		    //added By Shamkant S on 13 Jan 2016
            //Added and Commented By Vidya J On 30 Mar 2016
		   // window.open ("QRB_FormulaBuilder.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>","_FormulaBuilder","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 918)/2) + ",top=" + ((window.screen.height - 600)/2) + ",height=400,width=918");
		    window.open ("QRB_FormulaBuilder.aspx?FrmWhere=Formula_Builder&Mode=LIST&EntityID=<%=m_lngEntityID%>&Token=<%=m_strPKToken%>","_FormulaBuilder","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 918)/2) + ",top=" + ((window.screen.height - 600)/2) + ",height=400,width=918");
		    //End Of Addition and Commented By Vidya J On 30 Mar 2016
		}
		function Description_OnClick(queryid)
		{
			window.open("QRB_QueryDescription.aspx?QueryID="+ queryid,"_QueryDescription","resizable=yes,scrollbars=no,left=200,top=200,height=450,width=500"); 
		}
		function Back_OnClick()
		{
		     if (ShowNavigationAlert()==false) return; //Added By Shrikant B WAE3_PB_64
			window.location.href = "QRB_GroupNEntitySelection.aspx?Mode=ENTITYLIST&GroupID=<%=m_lngGroupID%>&MasterTagID=<%=m_lngMasterTagID%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
		}
		
		function PlaceHolders_OnClick()
		{
			window.open("QRB_Placeholders.aspx","_Placeholders","resizable=yes,scrollbars=no,left=200,top=100,height=600,width=600");
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
    // Description:Creating DropDown for Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
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
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
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

