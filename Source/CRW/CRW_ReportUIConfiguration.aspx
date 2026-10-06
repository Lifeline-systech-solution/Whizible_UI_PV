<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_ReportUIConfiguration.aspx.vb" Inherits="Whiz.CRW_ReportUIConfiguration" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmReportUIConfiguration" method="post" runat="server">
			<%WriteUIControls()%>
		</form>
	</body>
	<script language="javascript">
	var _objform;
	var _objcboTable;
	var _objtxtMaxLength;
	var _objtxtMaxValue;
	var _objtxtMinValue;
	var _objtxtCaption;
	var _objcboControlType;
	var _objtxtRow;
	var _objtxtOrder;
	var _objtxtWidth;
	var _objchkMandatory;
	
	<%'Added By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
	var _objcboSessionVariable;
	var _objtxtQuerystringParameter;
	var _objchkHideFromReport;
	<%'Addition Ends By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
	
	<%'Added By - PushkarK On - Tuesday, Aug 29, 2006 For WAF3_PB_26 %>
	var objPKToken = GetObjectReference('frmDesigner','PKToken');
	if (objPKToken){strPKToken = objPKToken.value;}
	<%'Addition Ends By - PushkarK On - Tuesday, Aug 29, 2006 For WAF3_PB_26 %>
		
	_objcboTable = GetObjectReference('frmReportUIConfiguration','cboTable',true);
	_objtxtMaxLength = GetObjectReference('frmReportUIConfiguration','txtMaxLength',true);
	_objtxtMaxValue = GetObjectReference('frmReportUIConfiguration','txtMaxValue',true);
	_objtxtMinValue = GetObjectReference('frmReportUIConfiguration','txtMinValue',true);
	_objtxtCaption = GetObjectReference('frmReportUIConfiguration','txtCaption',true);
	_objcboControlType = GetObjectReference('frmReportUIConfiguration','cboControlType',true);
	_objtxtRow = GetObjectReference('frmReportUIConfiguration','txtRow',true);
	_objtxtOrder = GetObjectReference('frmReportUIConfiguration','txtOrder',true);
	_objtxtWidth = GetObjectReference('frmReportUIConfiguration','txtWidth',true);
	_objchkMandatory = GetObjectReference('frmReportUIConfiguration','chkMandatory',true);
	_objform = GetFormReference('frmReportUIConfiguration');
	var objdivlist=GetObjectReference('frmReportUIConfiguration','divList');// 'WAF3_PB_42 April 13, 2007 NinadP %>
	<%'Added By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
	    _objcboSessionVariable = GetObjectReference('frmReportUIConfiguration', 'cboSessionVariable', true);;
        //commented by Nilesh G on 26/10/2015 for get Reference
	    //_objtxtQuerystringParameter=GetObjectReference('frmReportUIConfiguration','txtQuerystringParameter',true);;
	    _objtxtQuerystringParameter = GetObjectReference('frmReportUIConfiguration', 'txtQueryStringParameter', true);;
	    //end of commented by Nilesh G on 26/10/2015 for get Reference
	_objchkHideFromReport=GetObjectReference('frmReportUIConfiguration','chkHideFromReport',true);;
	<%'Addition Ends By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
	
	function cboTable_OnChange(_index1)
	{
	}
	
	function cboControlType_OnChange(_index)
	{
		if (trimString(_objcboControlType[_index].value) == "3") 
		{
			_objcboTable[_index].disabled=true;
			_objcboTable[_index].value="";
			_objtxtMaxLength[_index].readOnly=false;
			_objtxtMaxValue[_index].readOnly=false;
			_objtxtMinValue[_index].readOnly=false;
			_objtxtMaxLength[_index].style.backgroundColor="";
			_objtxtMaxValue[_index].style.backgroundColor="";
			_objtxtMinValue[_index].style.backgroundColor="";		
		}
		else
		{
			if ((trimString(_objcboControlType[_index].value) == "1") ||(trimString(_objcboControlType[_index].value) == "5"))
			{
				_objcboTable[_index].disabled=false;			
			}
			else
			{
				_objcboTable[_index].disabled=true;
				_objcboTable[_index].value="";			
			}
			
			<%'Added By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
			if (trimString(_objcboControlType[_index].value) == "6")
			{
				_objcboSessionVariable[_index].disabled=false;
				
				_objtxtQuerystringParameter[_index].readOnly=false;
				_objtxtQuerystringParameter[_index].style.backgroundColor="";		
	
				_objchkMandatory[_index].checked = false;
				_objchkMandatory[_index].disabled = true;
			}
			else
			{
				_objcboSessionVariable[_index].selectedIndex = 0;
				_objcboSessionVariable[_index].disabled=true;
				
				_objtxtQuerystringParameter[_index].value = "";
				_objtxtQuerystringParameter[_index].readOnly=true;
				_objtxtQuerystringParameter[_index].style.backgroundColor="#d3d3d3";			
			
				_objchkMandatory[_index].disabled = false;
			}
			<%'Addition Ends By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
			
			_objtxtMaxLength[_index].value="";
			_objtxtMaxValue[_index].value="";
			_objtxtMinValue[_index].value="";
			_objtxtMaxLength[_index].readOnly=true;
			_objtxtMaxValue[_index].readOnly=true;
			_objtxtMinValue[_index].readOnly=true;
			_objtxtMaxLength[_index].style.backgroundColor="#d3d3d3";
			_objtxtMaxValue[_index].style.backgroundColor="#d3d3d3";
			_objtxtMinValue[_index].style.backgroundColor="#d3d3d3";
		} 
	}
	
	function Save_OnClick(_reportid)
	{
		var _controlcount;
		var _index;
		_controlcount = "<%=m_intControlCount%>";	
		for(_index = 0; _index < _controlcount; _index++)
		{
			_objchkMandatory[_index].disabled=false;
			_objcboTable[_index].disabled=false;
			if (IsEmpty(_objtxtCaption[_index],"Please provide the caption.")) return;
			if (IsEmpty(_objtxtRow[_index],"Please provide the row number.")) return;
<%	'Added By-PushkarK On-Wednesday, November 30, 2005 Issue ID-814 Reason-Do not allow invalid and non numeric data. %>
			if (disallowNonNumeric(_objtxtRow[_index],'Please enter only numeric data in the \'Row Number.\'.',true)==true)
				return;
			if(disallowNegativeNumeric(_objtxtRow[_index],'Please enter only positive value for \'Row Number\'.',true)==true) 
				return;		
<%	'Addition Ends By-PushkarK On- Wednesday, November 30, 2005	Issue ID-814 %>
			if (IsEmpty(_objtxtOrder[_index],"Please provide the order number.")) return;

<%	'Added By-PushkarK On-Wednesday, November 30, 2005 Issue ID-814 Reason-Do not allow invalid and non numeric data. %>
			if (disallowNonNumeric(_objtxtOrder[_index],'Please enter only numeric data in the \'Order Number.\'.',true)==true)
				return;
			if(disallowNegativeNumeric(_objtxtOrder[_index],'Please enter only positive value for \'Order Number\'.',true)==true) 
				return;		
<%	'Addition Ends By-PushkarK On- Wednesday, November 30, 2005	Issue ID-814 %>
			if ((trimString(_objcboControlType[_index].value) == "1") ||(trimString(_objcboControlType[_index].value) == "5"))
			{
				if (IsEmpty(_objcboTable[_index],"Please select the table.")) return;
			}
			if (IsEmpty(_objtxtWidth[_index],"Please provide the width.")) return;
			if (trimString(_objcboControlType[_index].value) == "3")
			{
				if (trimString(_objtxtMaxLength[_index].value) != "") 
				{
					if (isNaN(_objtxtMaxLength[_index].value))
					{
						alert("Please enter a numeric value");
						_objtxtMaxLength[_index].focus();
						return;
					}
				}
				if (trimString(_objtxtMinValue[_index].value) != "") 
				{
					if (isNaN(_objtxtMinValue[_index].value))
					{
						alert("Please enter a numeric value");
						_objtxtMinValue[_index].focus();
						return;
					}
				}			
				if (trimString(_objtxtMaxValue[_index].value) != "") 
				{
					if (isNaN(_objtxtMaxValue[_index].value))
					{
						alert("Please enter a numeric value");
						_objtxtMaxValue[_index].focus();
						return;
					}
				}	
				if ((trimString(_objtxtMaxValue[_index].value) != "") && (trimString(_objtxtMinValue[_index].value) != ""))
				{
					if (parseFloat(_objtxtMaxValue[_index].value)< parseFloat(_objtxtMinValue[_index].value))
					{
						alert("Please enter a value greater than the Min.Value");
						_objtxtMaxValue[_index].focus();
						return;
					}
				}					
			}
			<%'Added By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
			_objcboSessionVariable[_index].disabled=false;
			_objtxtQuerystringParameter[_index].readOnly=false;
			_objchkMandatory[_index].disabled = false;
			
			if (trimString(_objcboControlType[_index].value) == "6")
			{
				if (_objcboSessionVariable[_index].selectedIndex <=0 && _objtxtQuerystringParameter[_index].value == "")
				{
					alert("Please select Session Variable or enter Query String Parameter for the Hidden-Control.");
					return;
				}
				if (_objcboSessionVariable[_index].selectedIndex >0 && _objtxtQuerystringParameter[_index].value != "")
				{
					alert("You cannot select Session Variable and Query String Parameter both for the Hidden-Control.");
					return;
				}
			}
			<%'Addition Ends By - PushkarK On - Tuesday, May 09, 2006 For WAF3_CRW_11 %>
		}
		if(_controlcount!=0)
		{	var strURL = "CRW_ReportUIConfiguration.aspx?mode=save&ReportID=" + _reportid + "&MasterTagID=545&PKToken="+ strPKToken;
			_objform.action = strURL;
			_objform.submit();
		}
		else
		{
			alert('<%=MyBase.GetResourceString("NO_ITEMS_TO_SAVE")%>')
		}
	}
	function Preview_OnClick(_reportid)
	{
		var strURL = "CRW_ReportUIBuilder.aspx?ReportID=" + _reportid;
		window.open (strURL,"_ReportUIPreview","resizable=yes,scrollbars=no,left=100,top=100,width=700,height=500" ) 
	}
	<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 13, 2007 END%>
	</script>
</HTML>
