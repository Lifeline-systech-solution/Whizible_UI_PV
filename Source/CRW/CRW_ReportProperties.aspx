<%@ Page Language="vb" EnableViewState="false" AutoEventWireup="false" Codebehind="CRW_ReportProperties.aspx.vb" Inherits="Whiz.CRW_ReportProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmReportProperties" name="frmReportProperties" method="post" runat="server">
			<%GenerateReportPropertiesUI%>
			<script language="javascript">
			
			 var objdivlist; 
			 var objfrm; 
			 var objtxtPageHeight; 
			 
			 objfrm= GetFormReference('frmReportProperties');
			 objdivlist=GetObjectReference('frmReportProperties','divBody');
			 objtxtReportTitle=GetObjectReference('frmReportProperties','txtReportTitle');
			 
			 
			 function window_onload() 
			 { 
        	var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
				 
				objtxtReportTitle.focus(); 
				
				showMessage=<%=m_intErrorNo%>
				
				if(showMessage > 0)
				{
					ShowAlert(showMessage);
					if(showMessage==1)
						objtxtReportTitle.focus();
				}
				//<%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>				
				//window.document.title='<%=MyBase.GetResourceString("REPORT_PROPERTIES_PAGETITLE")%>'
			} 
			
		<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>

		//Initialize Resource File	
		<%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>
		
		function Save_OnClick(lngReportID)
		{
	
			if(ValidateControls()==true)
			{	
			
				var objCboAuthors = GetObjectReference('frmReportProperties','cboAuthor');
				if (objCboAuthors != null)
				{
					objCboAuthors.disabled = false;
				}
			 	var strAction="CRW_ReportProperties.aspx?ReportID=" + lngReportID 
			 	var objform = GetFormReference('frmReportProperties'); 
				objform.action = strAction; 
				objform.submit(); 
			 			
			}
		}
					
		function ValidateControls()
		{
		 var blnIsblank; 
		 var blnIsNumeric; 
		 var blnIsNegative;
		 var blnMinValue;
		 var blnMaxValue;
		 var dblMinPageHeight = 0.5;
		 var blnValid=false;
		  
		var objText=GetObjectReference('frmReportProperties','txtReportTitle'); 

		blnIsblank= disallowBlank(objText,'<%=MyBase.GetResourceString("ERR_MSG_REPORT_TITLE_BLANK")%>'); 
		
		if (blnIsblank==false) 
		{ 
		 objText=GetObjectReference('frmReportProperties','txtPageHeight'); 
			
		 blnIsblank= disallowBlank(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_BLANK")%>',true);
						
		 if (blnIsblank==false)
		 {
		  blnIsNumeric=disallowNonNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_NONNUMERIC")%>',true);
		  if (blnIsNumeric==false)
		  {
		   blnIsNegative=disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_NONNEGATIVE")%>',true);
		   if (blnIsNegative==false)
		   {
			objText = GetObjectReference('frmReportProperties','txtHiddenIsSubreport');
			if(objText.value == '1') 
				{	dblMinPageHeight = 0.5; }
			else
				//modified july 15 2005 RajK changed the report min height to 5
				
				{	dblMinPageHeight = 1;	} <%'modified Shrikant B On 29 Dec 2008  changed the report min height to 1 in For Issue ID 26326%>
			
			objText=GetObjectReference('frmReportProperties','txtPageHeight');
			blnMinValue = disallowMinValueViolation(objText,dblMinPageHeight,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MINVALUE_VIOLATION")%>' + ' ' + dblMinPageHeight + ' ' + '<%=MyBase.GetResourceString("INCHES")%>',true);
			if(blnMinValue==false)
			{
			 blnMaxValue=disallowMaxValueViolation(objText,15,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_HEIGHT_MAXVALUE_VIOLATION")%>' + ' 15 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true);
			 if(blnMaxValue==false) 
			 {
			   blnValid=true; 
			 }
			}	
		   }
	      }
	     }
	    }   
	     
	     objText=GetObjectReference('frmReportProperties','txtPageWidth'); 
	     
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
			    var objTextHidden=GetObjectReference('frmPageSettings','txtPageWidthHidden'); 
				//var dblMinvalue=parseFloat(objTextHidden.value);
				var dblMinvalue=1;		 <%'modified Shrikant B On 29 Dec 2008  changed the report min Width to 1 in  For Issue ID 26326 %>
			    blnMinValue=disallowMinValueViolation(objText,dblMinvalue,'<%=MyBase.GetResourceString("ERR_MSG_PAGE_WIDTH_MINVALUE_VIOLATION")%> ' + dblMinvalue + ' <%=MyBase.GetResourceString("INCHES")%>',true)
			  			  
			   if (blnMaxValue==false && blnMinValue==false)
			   {
					blnValid=true; 
			   }
			   else 
			   {		
					blnValid=false; 
					//objText.value=objTextHidden.value	
			   }
			  }
		     }						
	        }
		   }
		   <%'Added By Shrikant B On 31 Dec 2008 %>
		   if (blnValid==true)
		   {
		       var objText=GetObjectReference('frmReportProperties','txtLeftMargin');
		            if(disallowMaxValueViolation(objText,22,'Left <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MAXVALUE_VIOLATION")%>' + ' 22 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true))return false;
		            if(disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_LEFT_MARGIN_NONNEGATIVE")%>',true))return false;
		       var objText=GetObjectReference('frmReportProperties','txtRightMargin'); 
		            if(disallowMaxValueViolation(objText,22,'Right <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MAXVALUE_VIOLATION")%>' + ' 22 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true))return false;
		            if(disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("ERR_MSG_Right_MARGIN_NONNEGATIVE")%>',true))return false;
		       var objText=GetObjectReference('frmReportProperties','txtTopMargin'); 
		            if(disallowMaxValueViolation(objText,22,'Top <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MAXVALUE_VIOLATION")%>' + ' 22 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true))return false;
		            if(disallowMinValueViolation(objText,-22,'Top <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MINVALUE_VIOLATION")%> ' + '-22' + ' <%=MyBase.GetResourceString("INCHES")%>',true))return false;
		       var objText=GetObjectReference('frmReportProperties','txtBottomMargin'); 
		            if(disallowMaxValueViolation(objText,22,'Bottom <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MAXVALUE_VIOLATION")%>' + ' 22 ' + '<%=MyBase.GetResourceString("INCHES")%>'  ,true))return false;
		            if(disallowMinValueViolation(objText,-22,'Bottom <%=MyBase.GetResourceString("ERR_MSG_MARGIN_MINVALUE_VIOLATION")%> ' + '-22' + ' <%=MyBase.GetResourceString("INCHES")%>',true))return false;
		   }
	 <%'Addition End By Shrikant B On 31 Dec 2008 %>
		return blnValid;
		
	 }
					
			</script>
		</form>
	</body>
</HTML>
