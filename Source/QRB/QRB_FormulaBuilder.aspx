<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_FormulaBuilder.aspx.vb" Inherits="Whiz.QRB_FormulaBuilder" %>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Formula Builder", , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 NinadP %>


    <body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		<form id='frmFormulaBuilder' method='post' runat='server'>
			<%WritePage()%>
		</form>
		<script language="javascript">
		var mode;
		var objform;
		var objdivlist;
		var objtxtFormulaName;
		var objchkDelete;
		var objtxtFormula;
		var objcboAttributes;
		var objcboFunction;
		var objtxtDescription;
		var intTotalCount;
		
		//	 Added By Shrikant B For WAF3_PB_64
        <% 
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("var strControlsToExcludeFrmNavigationAlert='chkDelete';")'Added By Ninad on 23 March 2009 IssueID-29539
        Response.Write("blnNavigate = null;")
        End If
        %>
        //End Addition by Shrikant B For WAF3_PB_64
		objform = GetFormReference('frmFormulaBuilder');
		objdivlist = GetObjectReference('frmFormulaBuilder','divList');
		objtxtFormulaName = GetObjectReference('frmFormulaBuilder','txtFormulaName');
		objchkDelete = GetObjectReference('frmFormulaBuilder','chkDelete',true);
		objtxtFormula = GetObjectReference('frmFormulaBuilder','txtFormula');
		objcboAttributes = GetObjectReference('frmFormulaBuilder','cboAttributes');
		objcboFunction = GetObjectReference('frmFormulaBuilder','cboFunction');
		objtxtDescription = GetObjectReference('frmFormulaBuilder','txtDescription');
		
		mode = "<%=UCase(Trim(m_strMode & ""))%>";
		if (mode == "LIST")
		{
			intTotalCount = <%=UBound(m_arrFormulaID)%>;
			if (intTotalCount < 0)
			{
				intTotalCount = 0
			} 
			var arrFormulaID =new Array(intTotalCount);
			var arrFormulaUsers =new Array(intTotalCount);
					
			<%For m_intCounterI = 0 to UBound(m_arrFormulaID)%>
				arrFormulaID [<%=m_intCounterI%>] = "<%=m_arrFormulaID(m_intCounterI)%>";
				arrFormulaUsers[<%=m_intCounterI%>] = "<%=m_arrFormulaUsers(m_intCounterI)%>";
			<%Next%>
		}
		//'Added By Ninad on 23 Aug 2007, Issue ID - 14057, SR ID - 263
		function AppendPlaceHolder_OnClick()
		{
		    window.open("QRB_Placeholders.aspx?FromWhere=FormulaBuilder","_Placeholders","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",height=600,width=600");
		}
		//End Added By Ninad on 23 Aug 2007, Issue ID - 14057, SR ID - 263
		function txtFormula_OnKeyPress()
		{
			var key;
			key = window.event.keyCode;
			if (key == 13)
			{
				window.event.keyCode=0; 
			}
		}
		function txtFormulaName_OnKeyPress()
		{
			var key;
			var oracle;
			if  ("<%=m_blnQueryUsesOracleDB%>" == "True")
			{
				key = window.event.keyCode;
				if (key == 32)
				{
					window.event.keyCode=0; 
				}
			}
		}
		
		
		function Clear_OnClick()
		{
			objtxtFormula.value = ""; 
			objtxtFormula.focus();
		}
		
		function Append_OnClick()
		{
			var strFunction;
			var strAttribute;
		
			if (disallowBlank(objcboAttributes,'<%=m_strMsgPleaseSelectAttribute%>')) return;
						strFunction = objcboFunction.value;
			strAttribute = objcboAttributes.value;
			if (trimString(strFunction)!="")
			{
				objtxtFormula.value =  	objtxtFormula.value + " " + strFunction + "(@" + strAttribute + "@)";
			}
			else
			{
				objtxtFormula.value =  	objtxtFormula.value + "  @" + strAttribute + "@";
			}
		}
		
		function Back_OnClick()
		{
		    if (ShowNavigationAlert()==false) return; //Added By Shrikant B WAE3_PB_64
			window.location.href = "QRB_FormulaBuilder.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>"; 

		}
		
		function AddNew_OnClick()
		{
			window.location.href = "QRB_FormulaBuilder.aspx?Mode=NEW&sortby=<%=m_strSortBy%>&EntityID=<%=m_lngEntityID%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>"; 
		}
		
		function Formula_OnClick(formulaid)
		{
			var index;
			for (index=0;index<arrFormulaID.length;index++ )
			{
				if (formulaid==arrFormulaID[index])
				{
					
					if (trimString(arrFormulaUsers[index])!= "")
					{
					//Issue ID	:	WAF3_QB_IssueFixes 1
						if (confirm('<%=m_strMsgConfirmationOnFormulaClickPart1%>' + arrFormulaUsers[index]+ '<%=m_strMsgConfirmationOnFormulaClickPart2%>')==false)
						{
							return;
						}
						;
					}
					break;
				}
			}
			window.location.href = "QRB_FormulaBuilder.aspx?Mode=EDIT&FormulaID=" + formulaid + "&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
		}
		
		function SelectAll_OnClick()
		{
				var LoopCtr; 
				var TotalRows;
		
				TotalRows = "<%=m_intTotalRows%>";
				if (TotalRows == 0)
				{
				//Issue ID	:	WAF3_QB_IssueFixes 1
					alert('<%=m_strMsgNoAlertSelected%>');
					return;
				}	
				
				for (LoopCtr = 0;LoopCtr < TotalRows;LoopCtr++)
				{
					objchkDelete[LoopCtr].checked=true;
				}
				return;
				
		}

		function Delete_OnClick(msg)
		{
		    //Added By Ninad on 20 Aug 2007, issue ID - 14474
	        var blnIsRecordSelected=false;blnIsRecordSelected=IsCheckboxSelected('frmFormulaBuilder','chkDelete')
            if (blnIsRecordSelected == false) {return;}
            //End Addition By Ninad on 20 Aug 2007, issue ID - 14474
			if (confirm(msg))
			{
				objform.action = "QRB_FormulaBuilder.aspx?Mode=LIST&Action=DELETE&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
	
		function Sort_OnClick(sortby, sortorder)
		{
			window.location.href = "QRB_FormulaBuilder.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&Alphabet=<%=m_strAlphabet%>&SortBy=" + sortby + "&SortOrder=" + sortorder ; 
		}
	
			
		function Page_OnClick(alphabet)
		{
			
			window.location.href = "QRB_FormulaBuilder.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet="  + URLEncode(alphabet);//Modified By Shrikant IssueID 20608
		}
		
		function Operator_OnClick(operator)
		{
			if (isNumeric(Right(objtxtFormula.value,1))==true)
			{
				if (isNumeric(operator))
				{
					objtxtFormula.value = objtxtFormula.value + operator;   
				}
				else
				{
					objtxtFormula.value = objtxtFormula.value + " " + operator;
				}
			}
			else
			{
				objtxtFormula.value = objtxtFormula.value + " " + operator;
			}
		}
		
		function Validate()
		{
			if (disallowBlank(objtxtFormula ,'Please provide the formula')) return false;
			if (disallowMaxlengthViolation(objtxtFormula,2000,"Please provide the formula within 2000 characters" ))return false;
			if (disallowMaxlengthViolation(objtxtDescription,2000,"Please provide the description within 2000 characters" ))return false;
			
			return true;
		}
		
		function Save_OnClick()
		{
			if (disallowBlank(objtxtFormulaName,'<%=m_strMsgEnterFormulaName%>')) return;
			if (disallowSpecialCharacters(objtxtFormulaName,'<%=m_strMsgSpecialCharatersAreNotAllowed%>')) return;
			if (Validate() == true)
			{
				objform.action = "QRB_FormulaBuilder.aspx?Mode=<%=m_strMode%>&Action=SAVE&FormulaID=<%=m_lngFormulaID%>&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
		
		function Validate_OnClick()
		{
			if (Validate() == true)
			{
				objform.action = "QRB_FormulaBuilder.aspx?Mode=<%=m_strMode%>&Action=VALIDATE&FormulaID=<%=m_lngFormulaID%>&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
		
		function Execute_OnClick()
		{
			//Issue ID	:	WAF3_QB_IssueFixes 1
        	if (disallowBlank(objtxtFormulaName,'<%=m_strMsgEnterFormulaName%>')) return;
     	
			if (Validate() == true)
			{
				objform.action = "QRB_FormulaBuilder.aspx?Mode=<%=m_strMode%>&Action=EXECUTE&FormulaID=<%=m_lngFormulaID%>&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
		
		function window_onload()
		{
		   	var msg;
			var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
			
			msg = "<%=m_strInvalidFormulaNameMsg%>";
			if (trimString(msg)!= "")
			{
				alert(msg);
				objtxtFormulaName.focus(); 
				return;
			}
			
			msg = "<%=m_strInvalidFormulaMsg%>";
			if (trimString(msg)!= "")
			{
				alert(msg);
				return;
			}
			
			msg = "<%=m_strFormulasCannotBeDeletedMsg%>";
			if (trimString(msg)!="")
			{
				alert(msg);
				return;
			}
		}
		
		<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>
	
		</script>
	</body>
</html>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<script type="text/javascript">

$(document).ready(function(){

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Application Administration >Query >Builder
    // Description:Apply FooTable
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/

    if($('.clsGridTable').length > 0)
    {
        var divName=$('#DivList').attr('id');
        dataCollapse(divName);
    }

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Application Administration >Query >Builder
    /*---------------------------------------------------------*/
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