<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CompanyInformation.aspx.vb" Inherits="PbNIT.CompanyInformation" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("CompanyInformation")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmCompanyInformation" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmCompanyInformation');
		var objdivlist=GetObjectReference('frmCompanyInformation','PageDiv');
		
		var objtxtCompanyName = GetObjectReference('frmCompanyInformation','txtCompanyName');
		var objtxtCompanyShortName = GetObjectReference('frmCompanyInformation','txtCompanyShortName');
		var objtxtEmail = GetObjectReference('frmCompanyInformation','txtEmail');
		var objcboDateformat = GetObjectReference('frmCompanyInformation','cboDateformat');
		var objtxtfileSize = GetObjectReference('frmCompanyInformation','txtfileSize');
		var objtxtWeekDays = GetObjectReference('frmCompanyInformation','txtWeekDays');
		var objtxtHours = GetObjectReference('frmCompanyInformation','txtHours');
		var objtxtStartDate = GetObjectReference('frmCompanyInformation', 'txtStartDate');
		var objtxtEndDate =  GetObjectReference('frmCompanyInformation', 'txtEndDate');
		
		<%' Added By SonalD on 22nd Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 22nd Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}	
			setFocus(objtxtCompanyName);		
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function Save_OnClick()
		{
			if(!Valid())
				return;
			
			objform.action = "companyInformation.aspx?Mode=Save";
			objform.submit();
		}
		
		function Valid()
		{
			//Blank company name
			if(disallowBlank(objtxtCompanyName,"<%=MyBase.GetResourceString("BLANKCOMPANYNAME")%>",true))
				return false;
			
			//Blank company short name
			if(disallowBlank(objtxtCompanyShortName,"<%=mybase.getresourcestring("BLANKCOMPANYSHORTNAME")%>",true))
				return false;
				
			//Valid EmailId
			if(objtxtEmail.value != "" && !ValidEmail(objtxtEmail.value))
			{
				alert("<%=mybase.getresourcestring("INVALIDEMAIL")%>");
				setFocus(objtxtEmail);
				return false;
			}

			//Blank date format
			if(disallowBlank(objcboDateformat,"<%=MYBASE.GETRESOURCESTRING("DATEFORMAT")%>",true))
				return false;
				
			if(disallowBlank(objtxtStartDate,"<%=MyBase.GetResourceString("BLANK_START_DATE")%>"))
				return false;
				
			if(disallowBlank(objtxtEndDate, "<%=MyBase.GetResourceString("BLANK_END_DATE")%>"))
				return false;
				
			//Blank release file size
			if(disallowBlank(objtxtfileSize,"<%=MyBase.GetResourceString("BLANKFILESIZE")%>",true))
				return false;
			
			//Numeric file size
			if(disallowNonNumeric(objtxtfileSize,"<%=MYBASE.GETRESOURCESTRING("NUMERICFILESIZE")%>",true))			
				return false;
				
			//Positive values
			if(disallowNegativeNumeric(objtxtfileSize,"<%=MYBASE.GETRESOURCESTRING("POSITIVEFILESIZE")%>",true))
				return false;
				

			//Blank week days
			if(disallowBlank(objtxtWeekDays,"<%=MYBASE.GETRESOURCESTRING("BLANKWEEKDAYS")%>",true))
				return false;
				
			//Numeric week days
			if(disallowNonNumeric(objtxtWeekDays,"<%=MYBASE.GETRESOURCESTRING("NUMERICWEEKDAYS")%>",true))			
				return false;
				
			//Positive values
			if(disallowNegativeNumeric(objtxtWeekDays,"<%=MYBASE.GETRESOURCESTRING("POSITIVEWEEKDAYS")%>",true))
				return false;
				
			//WeekDays > 7
			if(objtxtWeekDays.value>7)
			{
				alert("<%=MYBASE.GETRESOURCESTRING("WEEKDAYS>7")%>")
				setFocus(objtxtWeekDays);
				return false;
			}				
			
			//Blank hours per day
			if(disallowBlank(objtxtHours,"<%=MYBASE.GETRESOURCESTRING("BLANKHOURS")%>",true))
				return false;
				
			//Numeric hours
			if(disallowNonNumeric(objtxtHours,"<%=MYBASE.GETRESOURCESTRING("NUMERICDAYS")%>",true))			
				return false;
				
			//Positive values
			if(disallowNegativeNumeric(objtxtHours,"<%=MYBASE.GETRESOURCESTRING("POSITIVEDAYS")%>",true))
				return false;
				
			
			if(objtxtHours.value>24)
			{
				alert("<%=MYBASE.GETRESOURCESTRING("HOURS>24")%>")
				setFocus(objtxtHours);
				return false;
			}
			
			return true;
		}
		
		function ValidEmail(EmailId)
		{
			var filter=/^.+@.+\..{2,3}$/

			if (filter.test(EmailId))
				return true;
			else 
				return false;
		}
		</Script>
	</body>
</HTML>
