<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_WIZ_PageSettings.aspx.vb" Inherits="Whiz.CRW_WIZ_PageSettings" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmPageSettings" name="frmPageSettings" method="post" runat="server" onsubmit="CloseWindow_OnSubmit()">
			<%GeneratePageSettingsUI%>
		</form>
        <script language="javascript">
            var objdivlist; 
            var objtxtPageHeight; 
		 
            objdivlist=GetObjectReference('frmPageSettings','divBody')
            objtxtPageHeight=GetObjectReference('frmPageSettings','txtPageHeight');
            <% 'WAF3_PB_42 April 10, 2007 removed window_onload and window_onresize functions  %>
		    function SubmitForm(strAction) 
		    { 
			    var objform; 
			    objform = GetFormReference('frmPageSettings'); 
			    objform.action = strAction; 
			    objform.submit(); 
		    }
		     
		    function Back_OnClick(strBackPageName,lngReportID,intLayout,strMode,intShowGroupLink)
		    {document.location=strBackPageName + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout +"&Mode=" + strMode+ "&ShowGroupLink=" + intShowGroupLink;}
		    
            function Finish_OnClick(strSubmitToPage,lngReportID,intLayout,strMode,strLinkName)
            {	
                if(ValidateControls()==true)
                {			
                    var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName  ;
			 	    SubmitForm(strAction);
                    <%'Modified By PushkarK on 04-Sep-2006 For WAF3_PB_26%>	 	
                    var objPKToken = GetObjectReference('frmDesigner','PKToken');
                    if (objPKToken){strPKToken = objPKToken.value;}
                    window.open("CRW_ReportDesigner.aspx?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Mode=None&PKToken=" + strPKToken,"","resizable=yes,menubar=no,scrollbars=no");
                    <%'Modification By PushkarK on 04-Sep-2006 For WAF3_PB_26%>		
                    CloseWindow_OnSubmit();
                }
            }
            function Next_OnClick(strSubmitToPage,lngReportID,intLayout,strMode,strLinkName,intShowGroupLink)
            {	
                if(ValidateControls()==true)
                {			
                    var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName + "&ShowGroupLink=" + intShowGroupLink ;
                    SubmitForm(strAction);
                }
            }
            <%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>
			function ValidateControls()
            {
                var blnIsblank; 
                var blnIsNumeric; 
                var blnIsNegative;
                var blnMinValue;
                var blnMaxValue;
                var dblMinPageHeight;
                var blnValid=false;
                var objText=GetObjectReference('frmPageSettings','txtPageHeight'); 
                blnIsblank= disallowBlank(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_BLANK")%>',true);
                if (blnIsblank==false)
                {
                    blnIsNumeric=disallowNonNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_NONNUMERIC")%>',true);
                    if (blnIsNumeric==false)
                    {
                        blnIsNegative=disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_NONNEGATIVE")%>',true);
                        if (blnIsNegative==false)
                        {
                            objText = GetObjectReference('frmReportProperties','txtIsSubreport');
                            if(objText.value == '0'){dblMinPageHeight = 10;}
                            else{dblMinPageHeight = 0.5;}
                            objText=GetObjectReference('frmPageSettings','txtPageHeight');
                            blnMinValue=disallowMinValueViolation(objText,dblMinPageHeight,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MINVALUE_VIOLATION")%>' + ' ' + dblMinPageHeight + ' ' + '<%=MyBase.GetResourceString("INCHES")%>',true);
                            if(blnMinValue==false)
                            {
			                    blnMaxValue=disallowMaxValueViolation(objText,15,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MAXVALUE_VIOLATION")%>' + ' 15 ' + '<%=MyBase.GetResourceString("INCHES")%>',true);
			                    if(blnMaxValue==false)
			                    {blnValid=true;}
			                }	
                        }
                    }
                }
                objText=GetObjectReference('frmPageSettings','txtPageWidth');
                if(blnValid==true)
                {
		            blnValid=false;	
                    blnIsblank= disallowBlank(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_BLANK")%>',true);
                    if(blnIsblank==false)
                    {
                        blnIsNumeric=disallowNonNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_NONNUMERIC")%>',true);
                        if(blnIsNumeric==false)
                        {
                            blnIsNegative=disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_NONNEGATIVE")%>',true);	
                            if(blnIsNegative==false)
                            {
                                blnMaxValue=disallowMaxValueViolation(objText,125,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_MAXVALUE_VIOLATION")%>' + ' 125 ' + '<%=MyBase.GetResourceString("INCHES")%>',true)
                                if (blnMaxValue==false){blnValid=true;}
                                else{blnValid=false;}
					        }
					    }
                    }
                }
                return blnValid;
            }
            function CloseWindow_OnSubmit(){window.close();}
   
        </script>
	</BODY>
</HTML>