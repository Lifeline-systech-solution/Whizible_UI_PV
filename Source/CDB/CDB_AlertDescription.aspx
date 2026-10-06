<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_AlertDescription.aspx.vb" Inherits="Whiz.CDB_AlertDescription" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Alert Settings")%>
	<body style="overflow:auto" class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id='frmAlertDescription' method='post' runat='server'>
			<%WritePage()%>
		</form>

       <%-- Added by Dhanashri S on 14 Oct 2015--%>
        <style>
            .clsBody table:nth-last-child(2).clsTable 
            {
                position: absolute;
                bottom: auto;
            }
          
           /*Added by Reshma Chavan on 7th Dec 2020 For UI Issue*/
            #DivList { height:auto!important; min-height:80vh; }
           /*End of Added by Reshma Chavan on 7th Dec 2020 For UI Issue*/
        </style>
        <%--End of addition by Dhanashri S on 14 Oct 2014--%>

	</body>
</html>
<script language="javascript">
	<%=m_strResreshScript%>
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objtxtAlertTitle;
	var objcboAlertType;
	var objtxtHiddenStep;
	var objtxtAlert1MinValue;
	var objtxtAlert1MaxValue;
	var objtxtAlert2MinValue;
	var objtxtAlert2MaxValue;
	var objtxtAlert3MinValue;
	var objtxtAlert3MaxValue;
	var objcboEntity;
	var objcboFormula;
	var objcboDetailQuery;
	objform = GetFormReference('frmAlertDescription');
	objdivlist = GetObjectReference('frmAlertDescription','divList');
	objtxtAlertTitle = GetObjectReference('frmAlertDescription','txtAlertTitle');
	objcboAlertType = GetObjectReference('frmAlertDescription','cboAlertType');
	objtxtHiddenStep = GetObjectReference('frmAlertDescription','txtHiddenStep');
	objtxtAlert1MinValue = GetObjectReference('frmAlertDescription','txtAlert1MinValue');
	objtxtAlert1MaxValue = GetObjectReference('frmAlertDescription','txtAlert1MaxValue');
	objtxtAlert2MinValue = GetObjectReference('frmAlertDescription','txtAlert2MinValue');
	objtxtAlert2MaxValue = GetObjectReference('frmAlertDescription','txtAlert2MaxValue');
	objtxtAlert3MinValue = GetObjectReference('frmAlertDescription','txtAlert3MinValue');
	objtxtAlert3MaxValue = GetObjectReference('frmAlertDescription','txtAlert3MaxValue');
	objcboEntity = GetObjectReference('frmAlertDescription','cboEntity');
	objcboFormula = GetObjectReference('frmAlertDescription','cboFormula');
	objcboDetailQuery = GetObjectReference('frmAlertDescription','cboDetailQuery');
	
	function validate()
	{
		var strAlertTitles;
		var step;
		step =objtxtHiddenStep.value;
		if (step==1)
		{
			if (disallowBlank(objtxtAlertTitle,"Please enter the Alert Title")) return false;
			strAlertTitles = "<%=m_strExistingAlertTitles%>";
			if (isSubstringExists(strAlertTitles,"," + trimString(objtxtAlertTitle.value)  + ","))
			{
				alert("There exists a title with the same name already");
				return false;
			}
			if (disallowMaxlengthViolation(objtxtAlertTitle,100,"The alert title should not be more than 100 characters")) return false;
			if (disallowBlank(objcboAlertType,"Please select the alert type")) return false;
		}
		else
		{
			
			if (disallowBlank(objcboEntity,"Please select the entity")) return false;
			if (trimString(objcboAlertType.value) == "Summary" )
			{
				if (disallowBlank(objcboFormula,"Please select the formula")) return false;
				if (disallowNonNumeric(objtxtAlert1MinValue,"Please enter a numeric value")) return false;
				if (disallowNonNumeric(objtxtAlert1MaxValue,"Please enter a numeric value")) return false;
				if (disallowNonNumeric(objtxtAlert2MinValue,"Please enter a numeric value")) return false;
				if (disallowNonNumeric(objtxtAlert2MaxValue,"Please enter a numeric value")) return false;
				if (disallowNonNumeric(objtxtAlert3MinValue,"Please enter a numeric value")) return false;
				if (disallowNonNumeric(objtxtAlert3MaxValue,"Please enter a numeric value")) return false;
				
				if (disallowBlank(objtxtAlert1MinValue,"",false)==false && disallowBlank(objtxtAlert1MaxValue,"",false)==false) 
				{
					if (disallowMaxValueViolation(objtxtAlert1MinValue,objtxtAlert1MaxValue.value,"The minimum value cannot be greater than maximum value",true)) return false;
				}
				if (disallowBlank(objtxtAlert2MinValue,"",false)==false && disallowBlank(objtxtAlert2MaxValue,"",false)==false) 
				{
					if (disallowMaxValueViolation(objtxtAlert2MinValue,objtxtAlert2MaxValue.value,"The minimum value cannot be greater than maximum value",true)) return false;
				}
				if (disallowBlank(objtxtAlert3MinValue,"",false)==false && disallowBlank(objtxtAlert3MaxValue,"",false)==false) 
				{
					if (disallowMaxValueViolation(objtxtAlert3MinValue,objtxtAlert3MaxValue.value,'The minimum value cannot be greater than maximum value',true)) return false;
				}
			}
			else
			{
				if (disallowBlank(objcboDetailQuery,"Please select the detail query",true)) return false;
			}
		}
		return true;
	}

    //Added by Chetan M on 5 Jan 2021 for Duplicate record insert on double click
    var counter = 0;
    //End of Added by Chetan M on 5 Jan 2021 for Duplicate record insert on double click
	function Next_OnClick(DBID,mode)
    {           
        if (validate() == true) {
            //Added by Chetan M on 5 Jan 2021 for Duplicate record insert on double click
                counter = counter + 1;     
            if (counter == 1) {
            //End of Added by Chetan M on 5 Jan 2021 for Duplicate record insert on double click
                blnNavigate = false;    //Added By Ninad WAF3_PB_64		
                if (mode == "EDIT") {
                    if (objtxtHiddenStep.value == 1) {
                        objtxtHiddenStep.value = 2;
                        objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Action=NEXT&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=" + DBID;
                    }
                    else {
                        objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=NEXT&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=" + DBID;
                    }
                    objform.submit();
                }
                else {

                    if (objtxtHiddenStep.value == 1) {
                        objtxtHiddenStep.value = 2;
                        tblAlertDetail.style.display = "block";
                        tblAlertDescription.style.display = "none";
                        objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=&Mode=NEW&AlertID=<%=m_lngAlertID%>&DashboardID=" + DBID;
                        objform.submit();
                    }
                    else {
                        objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=NEXT&Mode=NEW&AlertID=<%=m_lngAlertID%>&DashboardID=" + DBID;
                        objform.submit();
                    }
                }
            }
        }
	}
	
	function Save_OnClick(DBID,alertid)
	{
		if (validate()==true)
		{
			blnNavigate = false;    //Added By Ninad WAF3_PB_64
			if (objtxtHiddenStep.value == 1)
			{
				objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Action=SAVE&Mode=<%=m_strMode%>&AlertID=<%=m_lngAlertID%>&DashboardID=" + DBID;
				objform.submit();
			}
			else
			{
				objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=SAVE&Mode=<%=m_strMode%>&AlertID=" + alertid + "&DashboardID=" + DBID;
				objform.submit();
			}
		}
	}
	
	function Back_OnClick(DBID,mode)
	{
	    if(ShowNavigationAlert()==false) return; //Added By Ninad WAF3_PB_64		
		window.location.href = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>&mode=" + mode; 
	}
	
	function cboEntity_OnChange()
	{
		objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=" + objtxtHiddenStep.value + "&Mode=<%=m_strMode%>&Action=REFRESH&DashboardID=<%=m_lngDashboardID%>&alertid=<%=m_lngAlertID%>";
	    blnNavigate = false;    //Added By Ninad WAF3_PB_64		
		objform.submit();
	}
	
	function cboAlertType_OnChange()
	{
		objform.action = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=" + objtxtHiddenStep.value + "&Mode=<%=m_strMode%>&Action=REFRESH&DashboardID=<%=m_lngDashboardID%>&alertid=<%=m_lngAlertID%>";
		blnNavigate = false;    //Added By Ninad WAF3_PB_64
		objform.submit();
	}
	
	function ChainLink_OnClick(pos)
	{
		var descriptive;
		descriptive = <%=m_intDescriptive%>;
		if(ShowNavigationAlert()==false) return; //Added By Ninad WAF3_PB_64		
		switch(true)
		{
		case (pos==1):
			window.location.href =  "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		case (pos==2):
			window.location.href =  "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		case (pos==3):
			if (descriptive==0)
			{
			window.location.href =  "CDB_AlertFilters.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			}
			else
			{
			window.location.href =  "CDB_AlertLinkList.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			}
			break;
		case (pos==4):
			window.location.href =  "CDB_AlertMails.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		default:
			break;
		}
	}
	
	function window_onload()
	{
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	
		if (objtxtHiddenStep.value == 1)
		{
			objtxtAlertTitle.focus();
		}
		else
		{
			
		}
	}
	
	<% 'WAF3_PB_42 April 16, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 16, 2007 END%>

	
</script>



<!--Including files & Libraries-->
    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>
  <%--//Added by Chetan M on 31 Dec 2020 for Duplicate record insert on double click--%>
<script src="../General/CommonFunctions.js"></script>
<%--//End of Added by Chetan M on 31 Dec 2020 for Duplicate record insert on double click--%>
<script type="text/javascript">

$(document).ready(function(){

/*----------------------------------------------------------*/
// Starts Feature Tag:whiz41-System Dashboard->High Level Dashboard->Configuration->Palletes
// Description:Apply FooTable
// By Whom: Miiint
// When:16/02/2015
/*---------------------------------------------------------*/
if($('.clsGridTable').length > 0)
{
    var divName=$('.clsBody').find('#divListPageTag').find('div:first').attr('id');
    dataCollapse(divName);
}
/*---------------------------------------------------------*/
// Ends Feature Tag:whiz41-Apply FooTable
/*---------------------------------------------------------*/

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
    //Added By Usha Pandit On 04.06.2020 For Title field display issue
    $('.clsBody').find(".footerMenuTable").css("cssText", "margin-top: 100% !important;");
    //End Of Added By Usha Pandit On 04.06.2020 For Title field display issue
});
</script>