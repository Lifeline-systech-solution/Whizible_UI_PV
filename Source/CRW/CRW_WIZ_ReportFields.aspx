<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_WIZ_ReportFields.aspx.vb" Inherits="Whiz.CRW_WIZ_ReportFields" %>
<!DOCTYPE HTML>
<HTML>
    <!-- Added By Bharat Tekade on 22nd-jan-2016 -->
    <head>
        <style>
            tr:nth-child(2) td:nth-child(2n)
            {
                   vertical-align:middle;
            }
        </style>
        <!-- End of Added By Bharat Tekade on 22nd-jan-2016 -->
	    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    </head>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmReportFields" name="frmReportFields" onsubmit="CloseWindow_OnSubmit()" method="post"
			runat="server">
			<%GenerateReportFieldsUI%>
		</form>
		<script language="javascript">
			 var objdivlist; 
			 var objfrm; 
			 var objListShowFields; 
			 
			 objfrm= GetFormReference('frmReportFields'); 
			 objdivlist=GetObjectReference('frmReportFields','divBody');
			 objListShowFields=GetObjectReference('frmReportFields','lstFieldsToBeShown');
<% 'WAF3_PB_42 April 10, 2007 removed window_onload and window_onresize functions  %>
			function SubmitForm(strAction) 
			{ 
			   	var objform; 
				objform = GetFormReference('frmReportFields'); 
				objform.action = strAction; 
			
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				var Count=objListFieldsToBeShown.options.length;
			
				for (i=0;i<Count; i++)
					objListFieldsToBeShown.options[i].selected=true;//Modified By Shrikant FOr SR 324
						
				var objListFieldsToBeHidden=GetObjectReference('frmReportFields','lstFieldsToBeHidden'); 
				var Count=objListFieldsToBeHidden.options.length;
			
				for (i=0;i<Count; i++)
					objListFieldsToBeHidden.options[i].selected=true;//Modified By Shrikant FOr SR 324
								
				objform.submit(); 
			} 
		
		
		
			function Back_OnClick(strBackPageName,lngReportID,intLayout,strMode,intShowGroupLink)
			{
			  
				window.document.location=strBackPageName + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout + "&Mode=" + strMode + "&ShowGroupLink=" + intShowGroupLink ;
			}
		
		
		
			function Finish_OnClick(strSubmitToPage,lngReportID,intLayout,strMode,strLinkName)
			{	
				if(ValidateControls()==true)
				{			
			 		var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName  ;
			 		SubmitForm(strAction);
			 		<%'Modified By PushkarK on 04-Sep-2006 For WAF3_PB_26%>
			 		var objPKToken = GetObjectReference('frmDesigner','PKToken');
					if (objPKToken){strPKToken = objPKToken.value;}	
			 		//Added By Vidya J ON 27-01-2016
				    window.open("CRW_ReportDesigner.aspx?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Mode=None&PKToken=" + strPKToken, "", "resizable=yes,menubar=no,scrollbars=no,width = 400, height =600");
				    //End Of Added By Vidya J ON 27-01-2016
                    <%'Modification By PushkarK on 04-Sep-2006 For WAF3_PB_26%>
	 				CloseWindow_OnSubmit();
				}
			}
		
		//Initialize Resource File
		<%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>
				
			function ValidateControls()
			{
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				
				if(objListFieldsToBeShown.options.length==0)
				{
					alert('<%=MyBase.GetResourceString("ERR_MSG_REPORT_FILEDS_NOTSELECTED")%>');
					return false;
				}
				else
				{
					return true;
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
						
		
			function CloseWindow_OnSubmit()
			{
				window.close();
			}
		
		
			function AddAll_OnClick()
			{
				var objListFieldsToBeHidden=GetObjectReference('frmReportFields','lstFieldsToBeHidden'); 
				
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
							
				var Count=objListFieldsToBeHidden.options.length
				
				if (objListFieldsToBeHidden.length>0) 
				{	var intCounter;
					for (intCounter=0;intCounter< Count; )
					{
						var objOption = document.createElement("OPTION");				
													
						objListFieldsToBeShown.options.add(objOption);
						objOption.text=objListFieldsToBeHidden.options(intCounter).text	
						objOption.value=objListFieldsToBeHidden.options(intCounter).value	
						
						objListFieldsToBeHidden.options.remove(intCounter)
						Count=objListFieldsToBeHidden.options.length
									
						objListFieldsToBeShown.focus();
					}
				}	
			}
		
		
			function Add_OnClick()
			{
				var objListFieldsToBeHidden=GetObjectReference('frmReportFields','lstFieldsToBeHidden'); 
				
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
							
				var intCounter;
				for(intCounter=0;intCounter<objListFieldsToBeHidden.options.length;)
				{
					if(objListFieldsToBeHidden.options(intCounter).selected==true)
					{
						var objOption = document.createElement("OPTION");
						objListFieldsToBeShown.options.add(objOption);
						objOption.text=objListFieldsToBeHidden.options(intCounter).text	
						objOption.value=objListFieldsToBeHidden.options(intCounter).value	
						objListFieldsToBeHidden.options.remove(intCounter)
					}
					else
					{
					intCounter++;
					}
				}
			}
			
			
			
			function Remove_OnClick()
			{
			
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				
				var objListFieldsToBeHidden=GetObjectReference('frmReportFields','lstFieldsToBeHidden'); 
							
				var intCounter;
				for(intCounter=0;intCounter<objListFieldsToBeShown.options.length;)
				{
					if(objListFieldsToBeShown.options(intCounter).selected==true)
					{
						var objOption = document.createElement("OPTION");
						objListFieldsToBeHidden.options.add(objOption);
						objOption.text=objListFieldsToBeShown.options(intCounter).text	
						objOption.value=objListFieldsToBeShown.options(intCounter).value
				
						objListFieldsToBeShown.options.remove(intCounter)
					}
					else
					{
						intCounter++;
					}
				}	 
			}


			function RemoveAll_OnClick()
			{
				
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				
				var objListFieldsToBeHidden=GetObjectReference('frmReportFields','lstFieldsToBeHidden')
												
				var Count=objListFieldsToBeShown.options.length
				
				if (objListFieldsToBeShown.length>0) 
				{	var intCounter;
					for (intCounter=0;intCounter< Count; )
					{
						var objOption = document.createElement("OPTION");				
													
						objListFieldsToBeHidden.options.add(objOption);
						objOption.text=objListFieldsToBeShown.options(intCounter).text	
						objOption.value=objListFieldsToBeShown.options(intCounter).value	
						
						objListFieldsToBeShown.options.remove(intCounter)
						Count=objListFieldsToBeShown.options.length
										
						objListFieldsToBeHidden.focus();	
					}
				}	
			}


			function Top_OnClick()
			{
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				var intSelectedIndex=objListFieldsToBeShown.selectedIndex;			
				
				if (intSelectedIndex>0)
				{
					var strOptionText1 =objListFieldsToBeShown.options(intSelectedIndex).text
					var strOptionValue1 =objListFieldsToBeShown.options(intSelectedIndex).value
					
					var objOption2=objListFieldsToBeShown.options(intSelectedIndex-1)
					
					objListFieldsToBeShown.options(intSelectedIndex).text=objOption2.text
					objListFieldsToBeShown.options(intSelectedIndex).value=objOption2.value
					
					objOption2.text=strOptionText1
					objOption2.value=strOptionValue1
					
					objListFieldsToBeShown.selectedIndex=intSelectedIndex-1
					objListFieldsToBeShown.focus();
				}
												
			}
		
			function Bottom_OnClick()
			{
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
							
				var intSelectedIndex=objListFieldsToBeShown.selectedIndex;
				var intOptionCount=objListFieldsToBeShown.length-1;
				
				if (intSelectedIndex<intOptionCount && intSelectedIndex!=-1)
				{
					var strOptionText1 =objListFieldsToBeShown.options(intSelectedIndex).text
					var strOptionValue1 =objListFieldsToBeShown.options(intSelectedIndex).value
					
					var objOption2=objListFieldsToBeShown.options(intSelectedIndex+1)
					
					objListFieldsToBeShown.options(intSelectedIndex).text=objOption2.text
					objListFieldsToBeShown.options(intSelectedIndex).value=objOption2.value
					
					objOption2.text=strOptionText1
					objOption2.value=strOptionValue1
					
					objListFieldsToBeShown.selectedIndex=intSelectedIndex+1
					objListFieldsToBeShown.focus();
				}
				
			}
		
			function TopMost_OnClick()
			{
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				
				var intSelectedIndex=objListFieldsToBeShown.selectedIndex;
				
				if (intSelectedIndex>0)
				{
					var strOptionText1 =objListFieldsToBeShown.options(intSelectedIndex).text;
					var strOptionValue1 =objListFieldsToBeShown.options(intSelectedIndex).value;
					
					objListFieldsToBeShown.remove(intSelectedIndex);
					
					var ObjOptionCreated = document.createElement("OPTION");
					objListFieldsToBeShown.options.add(ObjOptionCreated,0);
					ObjOptionCreated.innerText = strOptionText1;
					ObjOptionCreated.value = strOptionValue1;
									
					objListFieldsToBeShown.selectedIndex=0;
					objListFieldsToBeShown.focus();
				}
			}
		
			function BottomMost_OnClick()
			{
						
				var objListFieldsToBeShown=GetObjectReference('frmReportFields','lstFieldsToBeShown'); 
				
				var intSelectedIndex=objListFieldsToBeShown.selectedIndex;
				var intOptionCount=objListFieldsToBeShown.length-1;
				
				if (intSelectedIndex<intOptionCount && intSelectedIndex!=-1)
				{
					var strOptionText1 =objListFieldsToBeShown.options(intSelectedIndex).text;
					var strOptionValue1 =objListFieldsToBeShown.options(intSelectedIndex).value;
					
					objListFieldsToBeShown.remove(intSelectedIndex);
					var ObjOptionCreated = document.createElement("OPTION");
					objListFieldsToBeShown.options.add(ObjOptionCreated);
					ObjOptionCreated.innerText = strOptionText1;
					ObjOptionCreated.value = strOptionValue1;
									
					objListFieldsToBeShown.selectedIndex=intSelectedIndex;
					objListFieldsToBeShown.focus();
				}
			}
			
			
		</script>
	</BODY>
</HTML>
