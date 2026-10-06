<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB2DReports.aspx.vb" Inherits="PbNIT.IB2DReports" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%PlotPageHeadTag()%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
   
					<form id="frmIB2dReports" name="frmIB2dReports" method="post" runat="server">
									<%BuildPage()%>
					</form>
					<!--Modified By PrachiK on 22 Feb 2005 for Issue ID. 16247
             Purpose: Cosmetic Issue - GUI of this page is not proper. - White space is present at the top,Right side and Bottom .
                      To resolve this issue ,extra table tags are removed-->
	<SCRIPT language="javascript">
	
	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>


	<%MyBase.InitializeResources("AppResources.IB2DReports", "AppResources")%>
	//Modified by SantoshK on Date July 06,2006 for PMLifeLine Issue ID.4168
	//Chnaged frmIB2DReports to frmIB2dReports
	var objfrmIB2DReports = GetFormReference('frmIB2dReports');
	//End of modification by SantoshK on July 06,2006 Isse ID.4168	
	var objXAxisFromDateImg = GetObjectReference('frmIB2dReports','XAxisFromDateImg');
	var objXAxisToDateImg = GetObjectReference('frmIB2dReports','XAxisToDateImg');
	var objYAxisFromDateImg = GetObjectReference('frmIB2dReports','YAxisFromDateImg');
	var objYAxisToDateImg = GetObjectReference('frmIB2dReports','YAxisToDateImg');
	var objBasedOnFromDateImg = GetObjectReference('frmIB2dReports','BasedOnFromDateImg');
	var objBasedOnToDateImg = GetObjectReference('frmIB2dReports','BasedOnToDateImg');
	var objtxtReportName = GetObjectReference('frmIB2dReports','txtReportName');
	var objtxtQueryString = GetObjectReference('frmIB2dReports','txtQueryString');
	var objcboProjectGroup = GetObjectReference('frmIB2dReports','cboProjectGroup');
	var objchkDelete = GetObjectReference('frmIB2dReports','chkDelete');
	var objcboXAxis = GetObjectReference('frmIB2dReports','cboXAxis');
	var objcboYAxis = GetObjectReference('frmIB2dReports','cboYAxis');
	var objcboXAxisType = GetObjectReference('frmIB2dReports','cboXAxisType');
	var objcboYAxisType = GetObjectReference('frmIB2dReports','cboYAxisType');
	var objcboBasedOn = GetObjectReference('frmIB2dReports','cboBasedOn');
	var objcboBasedOnType = GetObjectReference('frmIB2dReports','cboBasedOnType');
	var objtxtXAxisFromDate = GetObjectReference('frmIB2dReports','txtXAxisFromDate');
	var objtxtXAxisToDate = GetObjectReference('frmIB2dReports','txtXAxisToDate');
	var objtxtYAxisFromDate = GetObjectReference('frmIB2dReports','txtYAxisFromDate');
	var objtxtYAxisToDate = GetObjectReference('frmIB2dReports','txtYAxisToDate');
	var objtxtBasedOnFromDate = GetObjectReference('frmIB2dReports','txtBasedOnFromDate');
	var objtxtBasedOnToDate = GetObjectReference('frmIB2dReports','txtBasedOnToDate');
	
	//***** Code Addded by SandipL on 5 Dec 2005 -- To solve problem of Editable Date Control 
	//var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtXAxisFromDate');
	//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
	
	if(navigator.appName == 'Netscape')
	{
        //Commented and Added by Dhanashri S on 26 Nov 2015
		//var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports','txtXAxisFromDate');
		//var objFFE29587WHIZ_txtXAxisToDate = GetObjectReference('frmIB2dReports','txtXAxisToDate');
		//var objFFE29587WHIZ_txtYAxisFromDate = GetObjectReference('frmIB2dReports','txtYAxisFromDate');
		//var objFFE29587WHIZ_txtYAxisToDate = GetObjectReference('frmIB2dReports','txtYAxisToDate');
		//var objFFE29587WHIZ_txtBasedOnFromDate = GetObjectReference('frmIB2dReports','txtBasedOnFromDate');
	    //var objFFE29587WHIZ_txtBasedOnToDate = GetObjectReference('frmIB2dReports','txtBasedOnToDate');

	    //var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports','txtXAxisFromDate');
	    var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtXAxisFromDate');
	    var objFFE29587WHIZ_txtXAxisToDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtXAxisToDate');
	    //var objFFE29587WHIZ_txtXAxisToDate = GetObjectReference('frmIB2dReports','txtXAxisToDate');
	    var objFFE29587WHIZ_txtYAxisFromDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtYAxisFromDate');
	    var objFFE29587WHIZ_txtYAxisToDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtYAxisToDate');
	    var objFFE29587WHIZ_txtBasedOnFromDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtBasedOnFromDate');
	    var objFFE29587WHIZ_txtBasedOnToDate = GetObjectReference('frmIB2dReports', 'FFE29587WHIZ_txtBasedOnToDate');
	    //End of Comment and Addition by Dhanashri S on 26 Nov 2015

	}
	else
	{
		//var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports','txtXAxisFromDate');
		var objFFE29587WHIZ_txtXAxisFromDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtXAxisFromDate');
		var objFFE29587WHIZ_txtXAxisToDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtXAxisToDate');
		//var objFFE29587WHIZ_txtXAxisToDate = GetObjectReference('frmIB2dReports','txtXAxisToDate');
		var objFFE29587WHIZ_txtYAxisFromDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtYAxisFromDate');
		var objFFE29587WHIZ_txtYAxisToDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtYAxisToDate');
		var objFFE29587WHIZ_txtBasedOnFromDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtBasedOnFromDate');
		var objFFE29587WHIZ_txtBasedOnToDate = GetObjectReference('frmIB2dReports','FFE29587WHIZ_txtBasedOnToDate');
	}
   var blnDateEditable  = '<%=m_blnDateEditable%>'
   //***** End addition by SandipL on 5 Dec
	var objcboView = GetObjectReference('frmIB2dReports','cboView');
	
	var objtxtProjectGroupID = GetObjectReference('frmIB2dReports','txtProjectGroupID');
	
	
	if(objcboXAxisType!=null) objcboXAxisType.selectedIndex=-1;
	if(objcboYAxisType!=null) objcboYAxisType.selectedIndex=-1;
	if(objcboBasedOnType!=null) objcboBasedOnType.selectedIndex=-1;
	
	function Delete_OnClick()
	{
		//Added by MonikaI on 11-Sep-2006 IssueID : 6022
		if (IsCheckboxSelected('frmIB2dReports','chkDelete'))
		{
		//End by MonikaI
			if(confirm('<%=mybase.GetResourceString("CONFIRMDELETE")%>'))
			{
				objfrmIB2DReports.action="IB2DReports.aspx?Mode=Delete";
				objfrmIB2DReports.submit(); 
			}
		}
	}
	
	function Close_OnClick()
	{
		window.close(); 
	}
	
	function GenerateReport_OnClick(strQueryString)
	{
		window.open ("IB2DReports.aspx" + strQueryString ,"","scrollbars=yes,resizable=yes,Width=600,Height=500,Left=10,top=10,menubar=yes,statusbar=yes");
	}

	function XAxis_Change()
	{   
		if((objcboXAxis.value=='TypeAndStatus') || (objcboXAxis.value=='SubType'))
		{
			objcboXAxisType.style.display='block';
			if((objcboXAxisType.length - 1) > 0) 
				objcboXAxisType.selectedIndex=0;
		}
		else
		{
			objcboXAxisType.style.display='none';
			objcboXAxisType.selectedIndex=-1;
		}
		//alert(objcboXAxis.selectedIndex);
		if((objcboXAxis.selectedIndex==-1) || (objcboXAxis.selectedIndex==0))
		{
		
			objcboYAxis.selectedIndex=-1;
			objcboBasedOn.selectedIndex=-1;
			objcboYAxisType.style.display='none';
			objcboYAxisType.selectedIndex=-1;
			objcboBasedOnType.style.display='none';
			objcboBasedOnType.selectedIndex=-1;
			objcboYAxis.disabled=true;
			
			objtxtYAxisFromDate.style.display='none';				
			objYAxisFromDateImg.style.display='none';					
			objtxtYAxisToDate.style.display='none';			
			
			objYAxisToDateImg.style.display='none';		
			objtxtYAxisFromDate.value='';
			objtxtYAxisToDate.value='';
			//alert(blnDateEditable);
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if ((blnDateEditable == 'True') && (navigator.appName!='Netscape' ))
			{
			
			objFFE29587WHIZ_txtYAxisFromDate.style.display='none';
			objFFE29587WHIZ_txtYAxisToDate.style.display='none';
			objFFE29587WHIZ_txtYAxisFromDate.value='';
			objFFE29587WHIZ_txtYAxisToDate.value='';
			}
			//***** End addition by SandipL on 5 Dec	
			objcboBasedOn.disabled=true;
			
			objtxtBasedOnFromDate.style.display='none';			
			objBasedOnFromDateImg.style.display='none';					
			objtxtBasedOnToDate.style.display='none';			
			objBasedOnToDateImg.style.display='none';
			
			objtxtBasedOnFromDate.value="";
			objtxtBasedOnToDate.value="";
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if ((blnDateEditable == 'True') && (navigator.appName!='Netscape' ))
			{
			objFFE29587WHIZ_txtBasedOnFromDate.style.display='none';
			objFFE29587WHIZ_txtBasedOnToDate.style.display='none';
			objFFE29587WHIZ_txtBasedOnFromDate.value="";
			objFFE29587WHIZ_txtBasedOnToDate.value="";
			}	
			//***** End addition by SandipL on 5 Dec	
			
		}
		else
		{
			
			objcboYAxis.disabled=false;
		}
			
		if(isSubstringExists(objcboXAxis.value.toUpperCase(),"DATE"))
		{
		
			objtxtXAxisFromDate.style.display='block';		
			objXAxisFromDateImg.style.display='block';			
			objtxtXAxisToDate.style.display='block';
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if (blnDateEditable == 'True')
			{
			    objFFE29587WHIZ_txtXAxisFromDate.style.display = 'block'; 
				objFFE29587WHIZ_txtXAxisToDate.style.display='block';
				 
			}
			//***** End addition by SandipL on 5 Dec	
			objXAxisToDateImg.style.display='block';
		}
		else
		{
		 
            //Commented and Added by Dhanashri S on 30 Nov 2015
			//objtxtXAxisFromDate.style.display='none';					
			//objXAxisFromDateImg.style.display='none';			
			//objtxtXAxisToDate.style.display='none';						
			//objXAxisToDateImg.style.display='none';
			
			//objtxtXAxisFromDate.value='';
			//objtxtXAxisToDate.value = '';


		    objFFE29587WHIZ_txtXAxisFromDate.style.display = 'none';
			objXAxisFromDateImg.style.display = 'none';
			objFFE29587WHIZ_txtXAxisToDate.style.display = 'none';
			objXAxisToDateImg.style.display = 'none';

			objtxtXAxisFromDate.value = '';
			objtxtXAxisToDate.value = '';
            //End of Comment and Addition by Dhanashri S on 30 Nov 2015
			
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if ((blnDateEditable == 'True') && (navigator.appName!='Netscape' ))
			{
			 
			objFFE29587WHIZ_txtXAxisFromDate.style.display ='none';
			objFFE29587WHIZ_txtXAxisToDate.style.display='none';
			objFFE29587WHIZ_txtXAxisFromDate.value='';
			objFFE29587WHIZ_txtXAxisToDate.value='';
			
			}
			//***** End addition by SandipL on 5 Dec	
		}
	}
	
	function YAxis_Change()
	{
		if((objcboYAxis.value=='TypeAndStatus') || (objcboYAxis.value=='SubType'))
		{ 
			objcboYAxisType.style.display='block';
			if ((objcboYAxisType.length - 1) > 0) 
				objcboYAxisType.selectedIndex=0;
		}		
		else
		{
			objcboYAxisType.style.display='none';
			objcboYAxisType.selectedIndex=-1;
		}

		if((objcboYAxis.selectedIndex==-1) || (objcboYAxis.selectedIndex==0))
		{
			objcboBasedOn.selectedIndex=-1;
			objcboBasedOn.disabled=true;
			
			objtxtBasedOnFromDate.style.display='none';			
			objBasedOnFromDateImg.style.display='none';				
			objtxtBasedOnToDate.style.display='none';
			
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
		    if (blnDateEditable == 'True')
			{
			objFFE29587WHIZ_txtBasedOnFromDate.style.display='none';
			objFFE29587WHIZ_txtBasedOnToDate.style.display='none';
			}
			//***** End addition by SandipL on 5 Dec	
			objBasedOnToDateImg.style.display='none';

		}	
		else
		{
			objcboBasedOn.disabled=false;
		}
		
		if(isSubstringExists(objcboYAxis.value.toUpperCase(),'DATE'))
		{
			objtxtYAxisFromDate.style.display='block';			
			objYAxisFromDateImg.style.display='block';				
			objtxtYAxisToDate.style.display='block';
			 
			 //***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			  if (blnDateEditable == 'True')
			{
			objFFE29587WHIZ_txtYAxisFromDate.style.display='block';
			objFFE29587WHIZ_txtYAxisToDate.style.display='block';
			}
			//***** End addition by SandipL on 5 Dec	
			objYAxisToDateImg.style.display='block';	
		}
		else
		{
			objtxtYAxisFromDate.style.display='none';						
			objYAxisFromDateImg.style.display='none';			
			objtxtYAxisToDate.style.display='none';			
			objYAxisToDateImg.style.display='none';	
				
			objtxtYAxisFromDate.value='';
			objtxtYAxisToDate.value='';
			
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			 if (blnDateEditable == 'True')
			{
			objFFE29587WHIZ_txtYAxisFromDate.style.display='none';
			objFFE29587WHIZ_txtYAxisToDate.style.display='none';
			objFFE29587WHIZ_txtYAxisFromDate.value='';
			objFFE29587WHIZ_txtYAxisToDate.value='';
			}
			//***** End addition by SandipL on 5 Dec	
		}
	}	
	
	function BasedOn_Change()
	{
		if((objcboBasedOn.value=='TypeAndStatus') || (objcboBasedOn.value=='SubType'))
		{
			objcboBasedOnType.style.display='block';
			if ((objcboBasedOnType.length - 1) > 0)
				objcboBasedOnType.selectedIndex=0;
		}
		else
		{
			objcboBasedOnType.style.display='none';
			objcboBasedOnType.selectedIndex=-1;
		}
		
		if (isSubstringExists(objcboBasedOn.value.toUpperCase(),'DATE'))
		{
			objtxtBasedOnFromDate.style.display='block';			
			objBasedOnFromDateImg.style.display='block';				
			objtxtBasedOnToDate.style.display='block';
			
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if (blnDateEditable == 'True')
			{
			objFFE29587WHIZ_txtBasedOnFromDate.style.display='block';
			objFFE29587WHIZ_txtBasedOnToDate.style.display='block';
			}
			//***** End addition by SandipL on 5 Dec	
			
			objBasedOnToDateImg.style.display='block';		
		}
		else
		{
			objtxtBasedOnFromDate.style.display='none';			
			objBasedOnFromDateImg.style.display='none';				
			objtxtBasedOnToDate.style.display='none';			
			objBasedOnToDateImg.style.display='none';
			
			objtxtBasedOnFromDate.value="";
			objtxtBasedOnToDate.value="";
			
			//***** Code added  by SandipL on 5 Dec 2005 --To solve Editable Date Control Issue 
			if (blnDateEditable == 'True')
			{
			objFFE29587WHIZ_txtBasedOnFromDate.style.display='none';
			objFFE29587WHIZ_txtBasedOnToDate.style.display='none';
			objFFE29587WHIZ_txtBasedOnFromDate.value="";
			objFFE29587WHIZ_txtBasedOnToDate.value="";
			}
			//***** End addition by SandipL on 5 Dec	
			
		}
	}
	
	function SaveReport_OnClick()
	{
		 
		var strQueryString;
		

	    //Added by swapnil aswale on 17th Nov 2015 for special character validation
		var ObjtxtReportName;
		ObjtxtReportName = GetObjectReference('frmIB2dReports', 'txtReportName');
		if (disallowSpecialCharacters(ObjtxtReportName, "Characters '/:*?+\"><,\\\\' are not allowed")) return false;
	    //Ended
		//Check blank report name
		if(disallowBlank(objtxtReportName,"<%=mybase.getResourceString("BLANKREPORTNAME")%>",true))
		return;
		//Added By JyotiG
		//Issue ID : 6015
		//Start
		if (objcboProjectGroup !=null)
		{
		//End	
			//Check for duplicate report name	
			if (objcboProjectGroup.selectedIndex!=0)
			{
				if(disallowDuplicates(objtxtReportName,ArrGroupReports,"<%=mybase.GetResourceString("REPORTEXISTS")%>",true,false))		
				return;
			}
			else
			{
				if(disallowDuplicates(objtxtReportName,ArrProjectReports,"<%=mybase.GetResourceString("REPORTEXISTS")%>",true,false))
				return;
			}
		//Added By JyotiG
		//Issue ID : 6015
		//Start			
		}
		//End
		//Check for X Axis value
		if(objcboXAxis.selectedIndex < 1)
		{
			alert('<%=mybase.GetResourceString("XAXISVALUE")%>');
			setFocus(objcboXAxis);
			return;
		}
		
		//X Axis from date>todate
		if(disallowDate1GreaterThanDate2(objtxtXAxisFromDate,objtxtXAxisToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;
			
		//Y Axis from date>todate
		if(disallowDate1GreaterThanDate2(objtxtYAxisFromDate,objtxtYAxisToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;
			
		//Based on from date>todate
		if(disallowDate1GreaterThanDate2(objtxtBasedOnFromDate,objtxtBasedOnToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;			

				//Check for same values for X and Y Axis
		if(objcboYAxis.selectedIndex >= 1)
		{
		 
			if(objcboXAxis.value.toUpperCase()==objcboYAxis.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboYAxis);
				return;
			}
		}
		 
		//Check for same values for X and Z Axis
		if(objcboBasedOn.selectedIndex >= 1)
		{ 
			if(objcboXAxis.value.toUpperCase()==objcboBasedOn.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboBasedOn);
				return;
			}
		}
		
		//Check for same values for Y and Z Axis
		if(objcboBasedOn.selectedIndex >= 1)
		{
			if(objcboYAxis.value.toUpperCase()==objcboBasedOn.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboBasedOn);
				return;
			}
		}

		
		//Check for type and subtype
		//For X and Y Axis
		if(((objcboXAxis.value=='TypeAndStatus')||(objcboXAxis.value=='SubType'))&&((objcboYAxis.value=='TypeAndStatus')||(objcboYAxis.value=='SubType')))
		{
			if(objcboXAxisType.value!=objcboYAxisType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboYAxisType);
				return;
			}
		}
		
		//For X Axis and Based On
		if(((objcboXAxis.value=='TypeAndStatus')||(objcboXAxis.value=='SubType'))&&((objcboBasedOn.value=='TypeAndStatus')||(objcboBasedOn.value=='SubType')))
		{
			if(objcboXAxisType.value!=objcboBasedOnType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboBasedOnType);
				return;				
			}
		}
		
		//For Y Axis and Based On
		if(((objcboYAxis.value=='TypeAndStatus')||(objcboYAxis.value=='SubType'))&&((objcboBasedOn.value=='TypeAndStatus')||(objcboBasedOn.value=='SubType')))
		{
			if(objcboYAxisType.value!=objcboBasedOnType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboBasedOnType);
				return;
			}
		}
		
		strQueryString = "?Mode=GenerateReport&cboXAxisType=" + ((objcboXAxisType.selectedIndex!=-1)?objcboXAxisType.value:"")
		strQueryString = strQueryString + "&cboYAxisType=" + ((objcboYAxisType.selectedIndex!=-1)?objcboYAxisType.value:"")
		strQueryString = strQueryString + "&cboBasedOnType=" + ((objcboBasedOnType.selectedIndex!=-1)?objcboBasedOnType.value:"")
		strQueryString = strQueryString + "&txtXAxisFromDate=" + objtxtXAxisFromDate.value
		strQueryString = strQueryString + "&txtXAxisToDate=" + objtxtXAxisToDate.value
		strQueryString = strQueryString + "&txtYAxisFromDate=" + objtxtYAxisFromDate.value
		strQueryString = strQueryString + "&txtYAxisToDate=" + objtxtYAxisToDate.value
		strQueryString = strQueryString + "&txtBasedOnFromDate=" + objtxtBasedOnFromDate.value
		strQueryString = strQueryString + "&txtBasedOnToDate=" + objtxtBasedOnToDate.value
		strQueryString = strQueryString + "&cboXAxis=" + objcboXAxis.value
		strQueryString = strQueryString + "&cboYAxis=" + objcboYAxis.value
		strQueryString = strQueryString + "&cboBasedOn=" + objcboBasedOn.value

		//Check for Project Group combo
		 
		if(objcboProjectGroup!=null)
		{
			strQueryString = strQueryString + "&cboProjectGroup=" + objcboProjectGroup.value
			
			//Check for custom fields at project level
			if(objcboProjectGroup.value!="")
			{
				//Custom fields for X Axis
				if (isSubstringExists(objcboXAxis.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboXAxis);
					return;
				}
				
				//Custom fields for Y Axis
				if (isSubstringExists(objcboYAxis.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboYAxis);
					return;
				}

				//Custom fields for Based On
				if (isSubstringExists(objcboBasedOn.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboBasedOn);
					return;
				}
			}
		}
		
		objtxtQueryString.value = strQueryString;
		//alert(objfrmIB2DReports);
		objfrmIB2DReports.action="IB2DReports.aspx?Mode=Save";
		//var str="IB2DReports.aspx?Mode=Save";
		objfrmIB2DReports.submit();
		
		//SubmitForm(objfrmIB2DReports);
	}
	
	function Show_OnClick()
	{
		var strQueryString;
		
		//Check for X Axis value
		if(objcboXAxis.selectedIndex < 1)
		{
			alert("<%=mybase.GetResourceString("XAXISVALUE")%>");
			setFocus(objcboXAxis);
			return;
		}
		
		//Check for same values for X and Y Axis
		if(objcboYAxis.selectedIndex >= 1)
		{
			if(objcboXAxis.value.toUpperCase()==objcboYAxis.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboYAxis);
				return;
			}
		}
		
		//Check for same values for X and Z Axis
		if(objcboBasedOn.selectedIndex >= 1)
		{
			if(objcboXAxis.value.toUpperCase()==objcboBasedOn.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboBasedOn);
				return;
			}
		}
		
		//Check for same values for Y and Z Axis
		if(objcboBasedOn.selectedIndex >= 1)
		{
			if(objcboYAxis.value.toUpperCase()==objcboBasedOn.value.toUpperCase())
			{
				alert("<%=mybase.GetResourceString("DIFFERENTVALUES")%>");
				setFocus(objcboBasedOn);
				return;
			}
		}
		
		//X Axis from date>todate
		if(disallowDate1GreaterThanDate2(objtxtXAxisFromDate,objtxtXAxisToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;
			
		//Y Axis from date>todate
		if(disallowDate1GreaterThanDate2(objtxtYAxisFromDate,objtxtYAxisToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;
			
		//Based on from date>todate
		if(disallowDate1GreaterThanDate2(objtxtBasedOnFromDate,objtxtBasedOnToDate,"<%=mybase.GetResourceString("FROMDATE>TODATE")%>",false))
			return;			
			

		//Check for type and subtype
		//For X and Y Axis
		if(((objcboXAxis.value=='TypeAndStatus')||(objcboXAxis.value=='SubType'))&&((objcboYAxis.value=='TypeAndStatus')||(objcboYAxis.value=='SubType')))
		{
			if(objcboXAxisType.value!=objcboYAxisType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboYAxisType);
				return;
			}
		}
		
		//For X Axis and Based On
		if(((objcboXAxis.value=='TypeAndStatus')||(objcboXAxis.value=='SubType'))&&((objcboBasedOn.value=='TypeAndStatus')||(objcboBasedOn.value=='SubType')))
		{
			if(objcboXAxisType.value!=objcboBasedOnType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboBasedOnType);
				return;				
			}
		}
		
		//For Y Axis and Based On
		if(((objcboYAxis.value=='TypeAndStatus')||(objcboYAxis.value=='SubType'))&&((objcboBasedOn.value=='TypeAndStatus')||(objcboBasedOn.value=='SubType')))
		{
			if(objcboYAxisType.value!=objcboBasedOnType.value)
			{
				alert("<%=mybase.GetResourceString("TYPESUBTYPE",false)%>");
				setFocus(objcboBasedOnType);
				return;
			}
		}
		
		strQueryString = "?Mode=GenerateReport&cboXAxisType=" + ((objcboXAxisType.selectedIndex!=-1)?objcboXAxisType.value:"")
		strQueryString = strQueryString + "&cboYAxisType=" + ((objcboYAxisType.selectedIndex!=-1)?objcboYAxisType.value:"")
		strQueryString = strQueryString + "&cboBasedOnType=" + ((objcboBasedOnType.selectedIndex!=-1)?objcboBasedOnType.value:"")
		strQueryString = strQueryString + "&txtXAxisFromDate=" + objtxtXAxisFromDate.value
		strQueryString = strQueryString + "&txtXAxisToDate=" + objtxtXAxisToDate.value
		strQueryString = strQueryString + "&txtYAxisFromDate=" + objtxtYAxisFromDate.value
		strQueryString = strQueryString + "&txtYAxisToDate=" + objtxtYAxisToDate.value
		strQueryString = strQueryString + "&txtBasedOnFromDate=" + objtxtBasedOnFromDate.value
		strQueryString = strQueryString + "&txtBasedOnToDate=" + objtxtBasedOnToDate.value
		strQueryString = strQueryString + "&cboXAxis=" + objcboXAxis.value
		strQueryString = strQueryString + "&cboYAxis=" + objcboYAxis.value
		strQueryString = strQueryString + "&cboBasedOn=" + objcboBasedOn.value

		//Check for Project Group combo
		if(objcboProjectGroup!=null)
		{
			strQueryString = strQueryString + "&cboProjectGroup=" + objcboProjectGroup.value
			
			//Check for custom fields at project level
			if(objcboProjectGroup.value!="")
			{
				//Custom fields for X Axis
				if (isSubstringExists(objcboXAxis.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboXAxis);
					return;
				}
				
				//Custom fields for Y Axis
				if (isSubstringExists(objcboYAxis.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboYAxis);
					return;
				}

				//Custom fields for Based On
				if (isSubstringExists(objcboBasedOn.value.toUpperCase(),'CUSTOMFIELD'))
				{
					alert("<%=mybase.GetResourceString("NOCUSTOMFIELDS",false)%>");
					setFocus(objcboBasedOn);
					return;
				}
			}
		}
		window.open ("IB2DReports.aspx" + strQueryString,"","scrollbars=yes,resizable=yes,Width=600,Height=500,Left=10,top=10,menubar=yes,statusbar=yes");
	}	
	
	function ShowDetails(strXAxis,strYAxis,strBasedOn,strXAxisValue,strYAxisValue,strBasedOnValue,xAxisType,yAxisType,BasedOnType,strXAxisFromDate,strXAxisToDate,strYAxisFromDate,strYAxisToDate,strBasedOnFromDate,strBasedOnToDate,strLevel)
	{
		/*if(objcboView.value=="")
		{
			alert("Please select the view.");
			setFocus(objcboView);
			return;
		}*/
		
		var strQueryString;
		
		strQueryString = "?cboView=" + objcboView.value;
		strQueryString = strQueryString + "&xAxisFieldName=" + replaceSubstring(strXAxis,"&","*");
		strQueryString = strQueryString + "&yAxisFieldName=" + replaceSubstring(strYAxis,"&","*");
		strQueryString = strQueryString + "&BasedOnFieldName=" + replaceSubstring(strBasedOn,"&","*");
		strQueryString = strQueryString + "&xAxisFieldValue=" + replaceSubstring(replaceSubstring(strXAxisValue," ","+"),"&","*");
		strQueryString = strQueryString + "&yAxisFieldValue=" + replaceSubstring(replaceSubstring(strYAxisValue," ","+"),"&","*");
		strQueryString = strQueryString + "&BasedOnFieldValue=" + replaceSubstring(replaceSubstring(strBasedOnValue," ","+"),"&","*");
		strQueryString = strQueryString + "&xAxisType=" + replaceSubstring(replaceSubstring(xAxisType," ","+"),"&","*");
		strQueryString = strQueryString + "&yAxisType=" + replaceSubstring(replaceSubstring(yAxisType," ","+"),"&","*");
		strQueryString = strQueryString + "&BasedOnType=" + replaceSubstring(replaceSubstring(BasedOnType," ","+"),"&","*");
		strQueryString = strQueryString + "&xAxisFromDate=" + strXAxisFromDate;
		strQueryString = strQueryString + "&xAxisToDate=" + strXAxisToDate;
		strQueryString = strQueryString + "&yAxisFromDate=" + strYAxisFromDate;
		strQueryString = strQueryString + "&yAxisToDate=" + strYAxisToDate;
		strQueryString = strQueryString + "&BasedOnFromDate=" + strBasedOnFromDate;
		strQueryString = strQueryString + "&BasedOnToDate=" + strBasedOnToDate;
		strQueryString = strQueryString + "&Level=" + strLevel;
		
		if(objtxtProjectGroupID!=null) 
			strQueryString = strQueryString + "&ProjectGroupID=" + objtxtProjectGroupID.value;
				
		window.open("IB_2DReportDetails.aspx" + strQueryString, "","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500,menubar=yes,statusbar=yes");								
	}
	
	function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				//'Modified by ShraddhaM on Date 01 Jully,2006 for PMLifeLine Issue ID.4168
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) 
			{
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				 //'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
				if (intDivHeight < 100)	
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight +'px';	
			}
		}	
			</SCRIPT>
			</TD></TR></TABLE>
		</TABLE>
	</body>
</HTML>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
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

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->