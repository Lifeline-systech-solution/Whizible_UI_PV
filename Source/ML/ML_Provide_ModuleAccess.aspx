<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ML_Provide_ModuleAccess.aspx.vb" Inherits="PbNIT.ML_Provide_ModuleAccess"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<%  CommonFunctions.General.PlotPageHeadTag("Module Access")%>
	 <body MS_POSITIONING="GridLayout" class="clsBody" onresize=window_onresize() onload=window_onload() >
		<form id="frmProvideAccess" method="post" runat="server">
		<%PageInit%>
		</form>
		
		<script>
		objform=GetFormReference('frmProvideAccess');
		objDivMain=GetObjectReference('frmProvideAccess','DivList');
		//objDivGrid=GetObjectReference('frmProvideAccess','DivGrid');
		function window_onload()		
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			if(objDivMain != null)
			{ 
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objDivMain.offsetTop - 45;
			 }
			 else
			 {
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
				}
				if (intDivHeight < 100)
				intDivHeight = 100;
				objDivMain.style.height = intDivHeight	;
			}
			
		}
		/*--------------------------------------------------------------------------------------------------------------*/
		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
			 if (navigator.appName=="Netscape") 
			 {
			 intDivHeight = window.innerHeight - objDivMain.offsetTop - 45;
			 }
			 else
			 {
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 45;
			 }
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight	;
				//objDivGrid.style.height = intDivHeight	;
			}
			
		}
		function SelectAll_OnClick()
		{ 
			var objApplicable = GetObjectReference('frmProvideAccess','chkApplicable',true);
						
			if (objApplicable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
				{
				    if ( objApplicable[i].disabled==false)
				        {
					        objApplicable[i].checked=true;
					    }
				}
					
		
		}
		
		function Save_OnClick()
		{			
		        if (ValidateControl()==true)
					{
		            objform.action = "ML_Provide_ModuleAccess.aspx?LoginID=<%=m_strLoginID%>&Action=Save";
		            //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
		            var MenuTags = document.getElementsByTagName('A');
		            for (i = 0; i < MenuTags.length; i++) {
		                if (MenuTags[i].className == "Menu") {
		                    //MenuTags[i].style.display= "none";
		                    MenuTags[i].parentNode.parentNode.style.display = "none";
		                }
		            }
		            //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 


					objform.submit();
					}
				else
				    {
				    alert("You can not remove access of all modules! ");
				    objform.action = "ML_Provide_ModuleAccess.aspx?LoginID=<%=m_strLoginID%>&Action=REFRESH";
		            //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
		            var MenuTags = document.getElementsByTagName('A');
		            for (i = 0; i < MenuTags.length; i++) {
		                if (MenuTags[i].className == "Menu") {
		                    //MenuTags[i].style.display= "none";
		                    MenuTags[i].parentNode.parentNode.style.display = "none";
		                }
		            }
		            //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 


					objform.submit();
				    }
		}
            function Saveclose_OnClick() {

                if (ValidateControl() == true) {
                    //Commented And Added by Usha Pandit on 19.11.2020 for Save Module Access Issue
					<%--objform.action = "ML_Provide_ModuleAccess.aspx?LoginID=<%=m_strLoginID%>&Action=Save" ;
					objform.submit();
                    window.close();--%>
                    objform.action = "ML_Provide_ModuleAccess.aspx?LoginID=<%=m_strLoginID%>&Action=Save";
                    objform.submit();
                    window.onunload = refreshMyParent;
                    function refreshMyParent() {
                        window.close();
                    }
                    //End Of Added by Usha Pandit on 19.11.2020 for Save Module Access Issue
                }
                else {
                    alert("You can not remove access of all modules! ");
                    objform.action = "ML_Provide_ModuleAccess.aspx?LoginID=<%=m_strLoginID%>&Action=REFRESH";
                    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
                    var MenuTags = document.getElementsByTagName('A');
                    for (i = 0; i < MenuTags.length; i++) {
                        if (MenuTags[i].className == "Menu") {
                            //MenuTags[i].style.display= "none";
                            MenuTags[i].parentNode.parentNode.style.display = "none";
                        }
                    }
                    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 


                    objform.submit();
                }
            }
	
		function Close_OnClick()
		{
			window.close();
		}
		
		function ValidateControl()
		{ 
			var objApplicable = GetObjectReference('frmProvideAccess','chkApplicable',true);
            var blnModuleSelected;
            blnModuleSelected=false;					
			if (objApplicable==null ) return;
			
				for (i=0;i<objApplicable.length;i++) 
				{
				    if ( objApplicable[i].checked==true)
				        {
				        blnModuleSelected=true;
				        return true;
				        }
				}
					
		return false;
		}
		

	
		
				</script>
	</body>
</HTML>
