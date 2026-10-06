<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_SmartDesigner.aspx.vb" Inherits="Whiz.CRW_SmartDesigner"%>
<HTML><%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
<form id="frm_SmartDesigner" name="frm_SmartDesigner" method="post">
<%PageInit()%>
</form>
<script language="javascript">
var objdivlist,objform;
objform=GetFormReference('frm_SmartDesigner');
objdivlist=GetObjectReference('frm_SmartDesigner','DivList');
if (GetObjectReference("frm_SmartDesigner","txtCaption1")!=null)
setFocus(GetObjectReference("frm_SmartDesigner","txtCaption1"));
else setFocus(GetObjectReference("frm_SmartDesigner","txtRowNumber1"));
<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>
function Save_OnClick(ReportID)
{if(! Validate()) return;
objform.action="CRW_SmartDesigner.aspx?Operation=SAVE&ReportID=" + ReportID;
objform.submit();}
function Validate()
{var rowCount,row,obj;
 var dblMinPageHeight = 1;
 var dblMinPageWidth=1;	
rowCount = GetObjectReference('frm_SmartDesigner','txtNoOfRows').value;
for(row=1; row<=rowCount; row++)
{obj=GetObjectReference('frm_SmartDesigner','txtRowNumber'+ row)
if(disallowBlank(obj, '<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_BLANK")%>')) return false;
if(disallowNegativeInteger(obj,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true)) return false;
if(disallowMinValueViolation(obj,1,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_ZERO")%>',true)) return false;
obj=GetObjectReference('frm_SmartDesigner','txtLeftPosition'+ row)
if(disallowBlank(obj, '<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>')) return false;
if(disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true)) return false;
obj=GetObjectReference('frm_SmartDesigner','txtWidth'+ row)
if(disallowBlank(obj, '<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_BLANK")%>')) return false;
if(disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NUMERIC")%>',true)) return false;}
<%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>
obj=GetObjectReference('frm_SmartDesigner','txtReportHeight')
if(disallowBlank(obj, '<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_BLANK")%>')) return false;
if(disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_NONNEGATIVE")%>',true)) return false;
if (disallowMinValueViolation(obj,dblMinPageHeight,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MINVALUE_VIOLATION")%>' + ' ' + dblMinPageHeight + ' ' + '<%=MyBase.GetResourceString("INCHES")%>',true))return false;
if (disallowMaxValueViolation(obj,15,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MAXVALUE_VIOLATION")%>' + ' 15 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true))return false;
obj=GetObjectReference('frm_SmartDesigner','txtReportWidth')
if(disallowBlank(obj, '<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_BLANK")%>'))	return false;
if(disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_NONNEGATIVE")%>',true)) return false;
if(disallowMinValueViolation(obj,dblMinPageWidth,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_MINVALUE_VIOLATION")%> ' + dblMinPageWidth + ' <%=MyBase.GetResourceString("INCHES")%>',true)) return false;
return true;}
function Sort(ReportID)
{objform.action="CRW_SmartDesigner.aspx?Operation=SORT&ReportID=" + ReportID;
objform.submit();}
function Close_OnClick(){window.close();}
</script>
</body>
</HTML>
