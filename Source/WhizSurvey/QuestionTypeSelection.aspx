<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuestionTypeSelection.aspx.vb" Inherits="Whiz.QuestionTypeSelection" %>
<html>
<%  CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("QTYPE_PAGE_CAPTION"), , , , "<script language='JavaScript' src='../WhizSurvey/Survey_Common.js'></script>")%>

<body class='clsPageBody' onload='CP_window_onload()' onresize='CP_window_onresize()'>
    <form id='frmQuestionTypeSelection' name='frmQuestionTypeSelection' method=post>
        <%WritePage()%>
        
    <script language="javascript" type="text/javascript">
    var objfrm;
    var objdivlist;
    objfrm = GetFormReference('frmCommonPage')
    objdivlist=GetObjectReference('frmCommonPage','divPage')
    var iDivHeightMinus=42;
    var iQNum=<%=m_intQuestionNumber%>;
    var iSurveyID=<%=m_lngSurveyID%>;
    var iFromDesigner=<%=m_intFromDesigner%>;
    window.status='';
    var iMasterTagID=0;
    function QuestionType_OnClick(QType)
    {
        var sURL=new String();
        var iHeight=0;
        var iWidth=0;
        if(iSurveyID == 0)
        {
            sURL="../WhizSurvey/QuestionLibrary_CommonPage.aspx?FromCL=1&Mode=ADD_NEW&ParentTagID=0&QuestionType=" + QType  + "&MasterTagID=";
            if(QType != 4)
            {
                sURL+=1789;
                window.location.href=sURL;
            }
            else
            {
                sURL+=1788;
                iHeight=250;
                iWidth=800;
                window.opener.window.open(sURL, "_libQOpen","resizable=no,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - iWidth)/2 + ",top=" + (window.screen.height - iHeight)/2 + ",width="+iWidth+",height="+iHeight);
                window.close();
            }   
            
        }
        else            
        {
           iMasterTagID=1770+QType;                                        
            window.location.href="../WhizSurvey/QType" + QType + "_ManageQuestion_CommonPage.aspx?FromCL=1&FromDesigner="+iFromDesigner+"&MasterTagID=" + iMasterTagID + "&ParentTagID=0&Mode=ADD_NEW&QuestionNumber="+iQNum + "&SurveyID="+iSurveyID;
        }
    }
        
    function CP_window_onresize()
	{
		var intDivHeight ;
		var intDivHeightRisk;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - iDivHeightMinus;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop  - iDivHeightMinus;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
				
		objdivlist.style.height = intDivHeight;
	try{hideAll();} catch(e){}}
	//window onload for Common list
	function CP_window_onload()
	{
		var intDivHeight ;
		var intDivHeightRisk;
		var lc;
		if (navigator.appName == 'Microsoft Internet Explorer'){
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - iDivHeightMinus;
		}
		else{
		intDivHeight = window.innerHeight - objdivlist.offsetTop - iDivHeightMinus;
		}
		if (intDivHeight < 100)
			intDivHeight = 100;
		objdivlist.style.height = intDivHeight	;
        focusOnFirstControl()
	}
	function focusOnFirstControl() {
    var objFirstControl = GetObjectReference('frmCommonPage','lnk1')
    if (objFirstControl==null) {return;}
    setFocus(objFirstControl);
    function Close_OnClick()
    {window.close();}
    function Help_OnClick()
    {
        OpenHelpPage(6008);
    }
    }
    </script> 
    </form>
</body>
</html>