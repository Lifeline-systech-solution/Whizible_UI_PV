<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_CopyReport.aspx.vb" Inherits="Whiz.CRW_CopyReport" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmCopyReport" name="frmCopyReport" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript"> 
			var objdivlist;
			 var objfrm; var objtxtReportTitle; 
			 var arrTagDesc,intLength;
			 
			objfrm= GetFormReference('frmCopyReport'); 
			objdivlist=GetObjectReference('frmCopyReport','divBody'); 
			objtxtReportTitle=GetObjectReference('frmCopyReport','txtReportTitle'); 
			
			intLength = <%=m_arrTagDesc.Length%>;
			arrTagDesc = new Array(intLength);
			
			<%For m_intCnt = 0 to m_arrTagDesc.Length-1%>
				arrTagDesc[<%=m_intCnt%>] = "<%=m_arrTagDesc(m_intCnt)%>";
			<%Next%> 
						
			<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>;
			
			function window_onload() 
			{ 
				var showMessage;
				var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		        windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
				if (objtxtReportTitle.disabled==false)
					objtxtReportTitle.focus(); 
				
				showMessage=<%=m_intMsg%>;
																
				if(showMessage > 0)
				{
					ShowAlert(showMessage);
									
					if(showMessage==1)
						objtxtReportTitle.focus();
					if(showMessage==3)
						window.close();							 
				}
				
			} 
			
			<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>

			
			function ShowAlert(showMessage)
			{
				var strMsg;
				
				<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>;
				
				if(showMessage==1)
					{
						strMsg= '<%=MyBase.GetResourceString("COPY_REPORT_MSG_TITLE")%>';
						alert(strMsg);
					}
				else if(showMessage==2)
					{
						strMsg='<%=MyBase.GetResourceString("COPY_REPORT_MSG_REPORTCOPIED")%>';
						alert(strMsg);
					}
			}
			
			function Save_OnClick(ReportID)
			{
				var blnIsblank; 
				var objText=GetObjectReference('frmCopyReport','txtReportTitle'); 
				blnIsblank= disallowBlank(objText,'<%=mybase.getResourcestring("MSG_BLANK_REPORT_TITLE")%>'); 
				if(blnIsblank==false) 
					{ 
						frmCopyReport.action="CRW_CopyReport.aspx?ReportID=" + ReportID + "&Mode=<%=CONST_COPY_REPORT_MODE%>&Action=<%=CONST_ACTION_SAVE%>";
						frmCopyReport.submit();  
					}			
			}
			function ReleaseSave_OnClick(RID)
			{
				var isDuplicate,i;
				var strNewTagDesc,blnFlag;
				var str;
				var objText = GetObjectReference('frmCopyReport','txtReportTitle'); 
				// Added July 15 2005 RajK Issue #19941
				var objcboModule = GetObjectReference('frmCopyReport','cboModule'); 
				var objcboNode = GetObjectReference('frmCopyReport','cboNode'); 
				// End Addition July 15 2005 RajK Issue #19941
				
				blnFlag = disallowBlank(objText,'<%=mybase.getResourcestring("MSG_BLANK_REPORT_TITLE")%>'); 
				// Added July 15 2005 RajK Issue #19941
				if (disallowBlank(objcboModule, 'Module Name cannot be blank.')==true) return;
				if (disallowBlank(objcboNode, 'Parent Node cannot be blank.')==true) return;
				// End Addition July 15 2005 RajK Issue #19941
				if(blnFlag==false) 
				{	
					blnFlag = disallowSpecialCharacters(objText,'<%=MyBase.GetResourceString("MSG_SPECIALCHARACTER_REPORT_TITLE")%>',true);
					if(blnFlag==false)
					{									
						isDuplicate=false;
						strNewTagDesc = objText.value;
						for(i=0;i<intLength-1;i++)
						{
							if(strNewTagDesc == arrTagDesc[i])
							{
								isDuplicate=true;
								break;
							}
						}
						if(isDuplicate==false)
						{
							objText = GetObjectReference('frmCopyReport','txtOrderNumber'); 
							blnFlag = disallowBlank(objText,'<%=mybase.getResourcestring("MSG_BLANK_ORDER_NUMBER")%>'); 
							if(blnFlag==false)
							{
								blnFlag = disallowSpecialCharacters(objText,'<%=MyBase.GetResourceString("MSG_ORDER_NUMBER_INVALID")%>',true);
								if(blnFlag==false)
								{	
									blnFlag = ValidateOrderNumber(objText);
									if(blnFlag == true)
									{
										frmCopyReport.action="CRW_CopyReport.aspx?ReportID=" + RID + "&Mode=<%=CONST_RELEASE_MODE%>&Action=<%=CONST_ACTION_SAVE%>";
										frmCopyReport.submit();  
									}
									else
									{
										alert('<%=MyBase.GetResourceString("MSG_ORDER_NUMBER_INVALID")%>')
										objText.focus();
									}
								}
							}
						}
						else
						{
							alert('<%=mybase.getResourcestring("MSG_DUPLICATE_REPORT_TITLE")%>');
						}
					}
				}
				
			}			
			function Module_OnChange(RID)
			{
				frmCopyReport.action="CRW_CopyReport.aspx?ReportID=" + RID + "&Mode=<%=CONST_RELEASE_MODE%>";
				frmCopyReport.submit();  
			}
			function Node_OnChange(RID)
			{
				frmCopyReport.action="CRW_CopyReport.aspx?ReportID=" + RID + "&Mode=<%=CONST_RELEASE_MODE%>";
				frmCopyReport.submit();  
			}		
			function ValidateOrderNumber(obj)
			{
				var i,j;
				var valid=true;
				var found=false;
				var orderNumber = obj.value;
				var str = "0123456789.";
				
				if(orderNumber.charAt(0) == '.' || orderNumber.charAt(orderNumber.length-1) == '.')
					valid=false;
				if(valid==true && isSubstringExists(orderNumber,'..')==true)
					valid=false;
				if(valid==true)
				{
					for(i=0;i < orderNumber.length;i++)
					{
						for(j=0;j<str.length;j++)
						{
							if(orderNumber.charAt(i) == str.charAt(j))	
							{
								found=true;
								break;
							}
						}		
						if(found==true)
							found=false;
						else
						{
							valid=false;
							break;
						}
					}
				}				
				return valid;
			}
		</script>
	</body>
</HTML>

<!--Including files & Libraries-->


<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>



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
});
</script>