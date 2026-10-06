<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_WIZ_GroupFields.aspx.vb" Inherits="Whiz.CRW_WIZ_GroupFields" %>
<!DOCTYPE HTML>
<HTML>
     <head>
         <!-- Added By Bharat Tekade on 22nd-jan-2016 -->
        <style>
            #lstUnGroupedFields , #lstGroupedFields
            {
                   height:250px;
            }
            tr:nth-child(2) td:nth-child(2n)
            {
                   vertical-align:middle;
            }
        </style>
       <!-- End of Added By Bharat Tekade on 22nd-jan-2016 -->
	    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
     </head>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmGroupFields" name="frmGroupFields" method="post" runat="server" onsubmit="CloseWindow_OnSubmit()">
			<%GenerateGroupFieldsUI%>
		</form>
			<script language="javascript">
			 var objdivlist; 
			 var objfrm; 
						 
			 objfrm= GetFormReference('frmGroupFields');
			 objdivlist=GetObjectReference('frmGroupFields','divBody');
<% 'WAF3_PB_42 April 10, 2007 removed window_onload and window_onresize functions  %>			
			function SubmitForm(strAction) 
			{ 
				var objform; 
				objform = GetFormReference('frmGroupFields'); 
				objform.action = strAction;
				
				var objListGroupedFields=GetObjectReference('frmReportFields','lstGroupedFields'); 
				var Count=objListGroupedFields.options.length;
				for (i=0;i<Count; i++)
					objListGroupedFields.options[i].selected=true;
				
				
				var objListUnGroupedFields=GetObjectReference('frmReportFields','lstUnGroupedFields'); 
				var Count=objListUnGroupedFields.options.length;
				for (i=0;i<Count; i++)
					objListUnGroupedFields.options[i].selected=true;
							 
				objform.submit(); 
			} 
		
			function Back_OnClick(strBackPageName,lngReportID,intLayout,strMode,intShowGroupLink)
			{
				document.location=strBackPageName + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout +"&Mode=" + strMode + "&ShowGroupLink=" + intShowGroupLink ;
			}
			
			
			function Finish_OnClick(strSubmitToPage,lngReportID,intLayout,strMode,strLinkName)
			{	
			 	var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportID + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName  ;
			 	SubmitForm(strAction);
			 	//window.opener.location="CRW_ReportDesigner.aspx?ReportID="+lngReportID + "&Mode=None"
	 			//CloseWindow_OnSubmit();
			}
						
			function CloseWindow_OnSubmit()
			{
				window.close();
			}
		
		//Initialize Resource File
		<%MyBase.InitializeResources("Resources.CRW_ReportWizard", "Resources")%>
		
			function AddAll_OnClick()
			{
				var objListUnGroupedFields=GetObjectReference('frmGroupFields','lstUnGroupedFields'); 
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				var Count=objListUnGroupedFields.options.length;
							
				var objTextMaxGroups= GetObjectReference('frmGroupFields','txtMaxGroups'); 
				
				var intTotalGroups=objListGroupedFields.options.length + objListUnGroupedFields.options.length;	
									
				if(intTotalGroups >=0 && intTotalGroups < objTextMaxGroups.value)
				{
				if (objListUnGroupedFields.length>0) 
				{	var intCounter;
					for (intCounter=0;intCounter< Count; )
					{
						var objOption = document.createElement("OPTION");				
													
						objListGroupedFields.options.add(objOption);
						objOption.text=objListUnGroupedFields.options[intCounter].text;	
						objOption.value=objListUnGroupedFields.options[intCounter].value;	
						
						objListUnGroupedFields.options.remove(intCounter);
						Count=objListUnGroupedFields.options.length;
									
						objListGroupedFields.focus();
					}
				}
				}	
				else
				{
					alert('<%=MyBase.GetResourceString("ERR_MSG_GROUP_FILEDS_GROUPSUPPORT")%> ' + objTextMaxGroups.value + ' <%=MyBase.GetResourceString("ERR_GROUPS")%>' );
				}
			}
		
			function Add_OnClick()
			{
				var objListUnGroupedFields=GetObjectReference('frmGroupFields','lstUnGroupedFields'); 
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				var objTextMaxGroups= GetObjectReference('frmGroupFields','txtMaxGroups'); 
					
				var intTotalGroups=objListGroupedFields.options.length;			
				var intSelectedGroups, intCounter;
				intSelectedGroups=0;
				for (intCounter=0;intCounter<objListUnGroupedFields.options.length;intCounter++)
				{
				if(objListUnGroupedFields.options[intCounter].selected==true)
				{
						intSelectedGroups=intSelectedGroups+1;
				}
				} 
				 
				intTotalGroups=intTotalGroups+intSelectedGroups;
								 
				if(intTotalGroups >=0 && intTotalGroups <= objTextMaxGroups.value)
				{
					
					for(intCounter=0;intCounter<objListUnGroupedFields.options.length;)
					{
						if(objListUnGroupedFields.options[intCounter].selected==true)
						{
							if (objListGroupedFields.options.length <= intTotalGroups )
							{ 
								var objOption = document.createElement("OPTION");
								objListGroupedFields.options.add(objOption);
								objOption.text=objListUnGroupedFields.options[intCounter].text;	
								objOption.value=objListUnGroupedFields.options[intCounter].value;	
								objListUnGroupedFields.options.remove(intCounter);
															
							}
							else
							{
								alert('<%=MyBase.GetResourceString("ERR_MSG_GROUP_FILEDS_GROUPSUPPORT")%> ' + objTextMaxGroups.value + ' <%=MyBase.GetResourceString("ERR_GROUPS")%>' );
								break;
							}
						}
						else
						{
							intCounter++;
													
						}
					}
				}
				else
				{
					alert('<%=MyBase.GetResourceString("ERR_MSG_GROUP_FILEDS_GROUPSUPPORT")%> ' + objTextMaxGroups.value + ' <%=MyBase.GetResourceString("ERR_GROUPS")%>' );
				}
			}
			
					
			function Remove_OnClick()
			{
			
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				var objListUnGroupedFields=GetObjectReference('frmGroupFields','lstUnGroupedFields'); 
							
				var intCounter;
				for(intCounter=0;intCounter<objListGroupedFields.options.length;)
				{
					if(objListGroupedFields.options(intCounter).selected==true)
					{
						var objOption = document.createElement("OPTION");
						objListUnGroupedFields.options.add(objOption);
						objOption.text=objListGroupedFields.options[intCounter].text;	
						objOption.value=objListGroupedFields.options[intCounter].value;
				
						objListGroupedFields.options.remove(intCounter);
					}
					else
					{
						intCounter++;
					}
				}	 
			}


			function RemoveAll_OnClick()
			{
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				var objListUnGroupedFields=GetObjectReference('frmGroupFields','lstUnGroupedFields');
												
				var Count=objListGroupedFields.options.length;
				
				if (objListGroupedFields.length>0) 
				{	var intCounter;
					for (intCounter=0;intCounter< Count; )
					{
						var objOption = document.createElement("OPTION");				
													
						objListUnGroupedFields.options.add(objOption);
						objOption.text=objListGroupedFields.options[intCounter].text;	
						objOption.value=objListGroupedFields.options[intCounter].value;
						
						objListGroupedFields.options.remove(intCounter);
						Count=objListGroupedFields.options.length;
										
						objListUnGroupedFields.focus();	
					}
				}	
			}


			function Top_OnClick()
			{
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				var intSelectedIndex=objListGroupedFields.selectedIndex;			
				
				if (intSelectedIndex>0)
				{
					var strOptionText1 =objListGroupedFields.options[intSelectedIndex].text;
					var strOptionValue1 =objListGroupedFields.options[intSelectedIndex].value;
					
					var objOption2=objListGroupedFields.options[intSelectedIndex-1];
					
					objListGroupedFields.options[intSelectedIndex].text=objOption2.text;
					objListGroupedFields.options[intSelectedIndex].value=objOption2.value;
					
					objOption2.text=strOptionText1;
					objOption2.value=strOptionValue1;
					
					objListGroupedFields.selectedIndex=intSelectedIndex-1;
					objListGroupedFields.focus();
				}
			}

			
			function Bottom_OnClick()
			{
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
							
				var intSelectedIndex=objListGroupedFields.selectedIndex;
				var intOptionCount=objListGroupedFields.length-1;
				
				if (intSelectedIndex<intOptionCount && intSelectedIndex!=-1)
				{
					var strOptionText1 =objListGroupedFields.options[intSelectedIndex].text;
					var strOptionValue1 =objListGroupedFields.options[intSelectedIndex].value;
					
					var objOption2=objListGroupedFields.options[intSelectedIndex+1];
					
					objListGroupedFields.options[intSelectedIndex].text=objOption2.text;
					objListGroupedFields.options[intSelectedIndex].value=objOption2.value;
					
					objOption2.text=strOptionText1;
					objOption2.value=strOptionValue1;
					
					objListGroupedFields.selectedIndex=intSelectedIndex+1;
					objListGroupedFields.focus();
				}
				
			}
		
			function TopMost_OnClick()
			{
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				
				var intSelectedIndex=objListGroupedFields.selectedIndex;
				
				if (intSelectedIndex>0)
				{
					var strOptionText1 =objListGroupedFields.options[intSelectedIndex].text;
					var strOptionValue1 =objListGroupedFields.options[intSelectedIndex].value;
					
					objListGroupedFields.remove(intSelectedIndex);
					
					var ObjOptionCreated = document.createElement("OPTION");
					objListGroupedFields.options.add(ObjOptionCreated,0);
					ObjOptionCreated.innerText = strOptionText1;
					ObjOptionCreated.value = strOptionValue1;
									
					objListGroupedFields.selectedIndex=0;
					objListGroupedFields.focus();
				}
			}
			
			function BottomMost_OnClick()
			{
						
				var objListGroupedFields=GetObjectReference('frmGroupFields','lstGroupedFields'); 
				
				var intSelectedIndex=objListGroupedFields.selectedIndex;
				var intOptionCount=objListGroupedFields.length-1;
				
				if (intSelectedIndex<intOptionCount && intSelectedIndex!=-1)
				{
					var strOptionText1 =objListGroupedFields.options[intSelectedIndex].text;
					var strOptionValue1 =objListGroupedFields.options[intSelectedIndex].value;
					
					objListGroupedFields.remove(intSelectedIndex);
					var ObjOptionCreated = document.createElement("OPTION");
					objListGroupedFields.options.add(ObjOptionCreated);
					ObjOptionCreated.innerText = strOptionText1;
					ObjOptionCreated.value = strOptionValue1;
									
					objListGroupedFields.selectedIndex=intSelectedIndex;
					objListGroupedFields.focus();
				}
			}
		
			
			</script>
		
	</BODY>
</HTML>
