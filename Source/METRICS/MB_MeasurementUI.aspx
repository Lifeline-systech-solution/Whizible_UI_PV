<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MB_MeasurementUI.aspx.vb" Inherits="PbNIT.MB_MeasurementUI"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("WINDOW_TITLE"), "Formula Builder"))%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
	<script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .clsTable td
    {
        vertical-align:top
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
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

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

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

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id='frmFormulaBuilder' method='post' runat='server'>
			<%InitPage()%>
		</form>
		<script language="javascript">
		

		//******************************************************************************
		var blnStatus;
		var strIsSaved ;
		var req; 
		function generateRequest(url) 
		{ 
		    // Mozilla and Friends 

            //Commented and Added by Dhanashri S on 14 Oct 2015
		    //if (window.XMLHttpRequest) 
		    //{ 
			//	req = new XMLHttpRequest(); 
		    //} else if (window.ActiveXObject) 
		    //{ 
			//	// Internet Explorer 
			//	req = new ActiveXObject("Microsoft.XMLHTTP"); 
		    //} 

		    if (window.ActiveXObject || "ActiveXObject" in window) 
		    { 
		        // Internet Explorer 
		        req = new ActiveXObject("Microsoft.XMLHTTP"); 
		    }
		    else
		    {
		        if (window.XMLHttpRequest) 
		        { 
		            req = new XMLHttpRequest(); 
		        } 
		    }
            //End of Comment and Addition by Dhanashri S on 14 Oct 2015
			
			req.onreadystatechange = processChoices;
			req.open("POST", url,false); 
			req.send();
			delete req;
			return true;
		}
		var brw=isIE(); 
		function processChoices() 
		{ 
			// wait until the request is done 
			if (req.readyState == 4) 
			{ 
				// Make sure request came back OK 
				if (req.status == 200) 
				{   
                    //Commented and Added by Dhanashri S on 14 Oct 2015
				    //if (window.ActiveXObject)
				   // if (window.ActiveXObject || "ActiveXObject" in window )
				    //End of Comment and Addition by Dhanashri S on 14 Oct 2015
				    if(brw=="IE")
					{
						xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
						xmlDoc.async=false;
						xmlDoc.loadXML(req.responseText);
					}
					// code for Mozilla, etc.
					else if (document.implementation &&	document.implementation.createDocument)
					{
					    xmlDoc= document.implementation.createDocument("","",null);
					    if(brw=="FF")//added by Nilesh g on 10/12/2015
						xmlDoc.load(req.responseXML);
					}
					
					strIsSaved = xmlDoc.getElementsByTagName("isSaved")[0].firstChild.nodeValue
					if(strIsSaved != 'true')
					{	blnStatus = false;
					}
				}
				else 
				{	blnStatus = false;
				}     
				
			}
		}
	

		//*******************************************************************************
		var mode;
		var objform;
		var objdivlist;
		var objtxtFormulaName;
		var objchkDelete;
		var objtxtFormula;
		var objcboAttributes;
		var objcboFunction;
		var objtxtDescription;
		var intTotalCount;
		
		objform = GetFormReference('frmFormulaBuilder');
		objdivlist = GetObjectReference('frmFormulaBuilder','divList');
		objtxtFormulaName = GetObjectReference('frmFormulaBuilder','txtFormulaName');
		objchkDelete = GetObjectReference('frmFormulaBuilder','chkDelete',true);
		objtxtFormula = GetObjectReference('frmFormulaBuilder','txtFormula');
		objcboAttributes = GetObjectReference('frmFormulaBuilder','cboAttributes');
		objcboFunction = GetObjectReference('frmFormulaBuilder','cboFunction');
		objtxtDescription = GetObjectReference('frmFormulaBuilder','txtDescription');
		
		mode = "<%=UCase(Trim(m_strMode & ""))%>";
		if (mode == "LIST")
		{
			intTotalCount = <%=UBound(m_arrFormulaID)%>;
			if (intTotalCount < 0)
			{
				intTotalCount = 0
			} 
			var arrFormulaID =new Array(intTotalCount);
			var arrFormulaUsers =new Array(intTotalCount);
					
			<%For m_intCounterI = 0 to UBound(m_arrFormulaID)%>
				arrFormulaID [<%=m_intCounterI%>] = "<%=m_arrFormulaID(m_intCounterI)%>";
				arrFormulaUsers[<%=m_intCounterI%>] = "<%=m_arrFormulaUsers(m_intCounterI)%>";
			<%Next%>
		}
		
		function txtFormula_OnKeyPress()
		{
			var key;
			key = window.event.keyCode;
			if (key == 13)
			{
				window.event.keyCode=0; 
			}
		}
		function txtFormulaName_OnKeyPress()
		{
			var key;
			var oracle;
			if  ("<%=m_blnQueryUsesOracleDB%>" == "True")
			{
				key = window.event.keyCode;
				if (key == 32)
				{
					window.event.keyCode=0; 
				}
			}
		}
		
		
		function Clear_OnClick()
		{
			objtxtFormula.value = ""; 
		}
		
		function Append_OnClick()
		{
			var strFunction;
			var strAttribute;
					
			if (disallowBlank(objcboAttributes,"Please select the attribute!")) return;
			
			strFunction = objcboFunction.value;
			strAttribute = objcboAttributes.value;
			if (trimString(strFunction)!="")
			{
				objtxtFormula.value =  	objtxtFormula.value + " " + strFunction + "(@" + strAttribute + "@)";
			}
			else
			{
				objtxtFormula.value =  	objtxtFormula.value + "  @" + strAttribute + "@";
			}
		}
		
		function Back_OnClick()
		{
			//window.location.href = "MB_MeasurementUI.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>"; 
			window.location.href = "MB_MeasurementUI.aspx?sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>"; 
		}
		
		function AddNew_OnClick()
		{
			window.location.href = "MB_MeasurementUI.aspx?Mode=NEW&sortby=<%=m_strSortBy%>&MetricID=<%=m_intMetricID%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>"; 
		}
		
		function Formula_OnClick(formulaid)
		{
			var index;
			for (index=0;index<arrFormulaID.length;index++ )
			{
				if (formulaid==arrFormulaID[index])
				{
					
					if (trimString(arrFormulaUsers[index])!= "")
					{
						if (confirm("The formula is being used on Dashboard(s) by the following users :\n" + arrFormulaUsers[index]+ "\nModifying the formula can result in incorrect data.\n Do you want to continue?")==false)
						{
							return;
						}
						;
					}
					break;
				}
			}
			window.location.href = "MB_MeasurementUI.aspx?Mode=EDIT&FormulaID=" + formulaid + "&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
		}
		
		function SelectAll_OnClick()
		{
				var LoopCtr; 
				var TotalRows;
		
				TotalRows = "<%=m_intTotalRows%>";
				if (TotalRows == 0)
				{
					alert("There are no alerts to select");
					return;
				}	
				
				for (LoopCtr = 0;LoopCtr < TotalRows;LoopCtr++)
				{
					objchkDelete[LoopCtr].checked=true;
				}
				return;
				
		}

		function Delete_OnClick(msg)
		{
			if (confirm(msg))
			{
				objform.action = "MB_MeasurementUI.aspx?Mode=LIST&Action=DELETE&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				objform.submit();
			}
		}
	
		function Sort_OnClick(sortby, sortorder)
		{
			window.location.href = "MB_MeasurementUI.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&Alphabet=<%=m_strAlphabet%>&SortBy=" + sortby + "&SortOrder=" + sortorder ; 
		}
	
			
		function Page_OnClick(alphabet)
		{
			window.location.href = "MB_MeasurementUI.aspx?Mode=LIST&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&alphabet=" + alphabet;
		}
		
		function Operator_OnClick(operator)
		{
			if (isNumeric(Right(objtxtFormula.value,1))==true)
			{
				if (isNumeric(operator))
				{
					objtxtFormula.value = objtxtFormula.value + operator;   
				}
				else
				{
					if(operator == '=' || operator == '.')
					{
						objtxtFormula.value = objtxtFormula.value + operator;
					}
					else
					{
						objtxtFormula.value = objtxtFormula.value + " " + operator;
					}
				}
			}
			else
			{ 
				if(operator == '=' || operator == '.' || Right(objtxtFormula.value,1) == '.')
				{
					objtxtFormula.value = objtxtFormula.value + operator;
				}
				else
				{
					objtxtFormula.value = objtxtFormula.value + " " + operator;
				}
				
			}
		}
		
		function Validate()
		{
			if (disallowBlank(objtxtFormula ,'Please provide the formula')) return false;
			if (disallowMaxlengthViolation(objtxtFormula,2000,"Please provide the formula within 2000 characters" ))return false;
			if (disallowMaxlengthViolation(objtxtDescription,2000,"Please provide the description within 2000 characters" ))return false;
			
			return true;
		}
		
		function Save_OnClick()
		{	
			if (disallowBlank(objtxtFormulaName,'Please enter the formula name')) return;
			if (disallowSpecialCharacters(objtxtFormulaName,"Characters [/:*?+\"><|,\\\\] are not allowed within the formula name")) return;
			
			if (Validate() == true)
			{
				//*********************************
				var objDivBar = GetObjectReference('frmFormulaBuilder','divBar'); 
				objDivBar.style.display = "block";
			    var strUrl="MB_MeasurementUI.aspx?Mode=<%=m_strMode%>&Action=SAVE&CorporateLevelMB=<%=m_CorporateLevelMB%>&MetricID=<%=m_intMetricID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&ProjectID=<%=m_intProjectID%>&Alphabet=<%=m_strAlphabet%>&txtFormula=" + encodeURIComponent(GetObjectReference('frmFormulaBuilder','txtFormula').value);
				var val=generateRequest(strUrl);
				if(val==true)
				{
					objDivBar.style.display = "none";
					if(strIsSaved == 'false')
					{alert("Formula is not valid");}
					else
					{
						var objtxtFormula1 = GetObjectReference('frmFormulaBuilder','txtFormula');						
						if(objtxtFormula1 != null)
						{
							if(window.opener.frmCommonPage.NewUDFormula != null)
							window.opener.frmCommonPage.NewUDFormula.value=objtxtFormula1.value;
							window.opener.frmCommonPage.NonDatabase1.value=objtxtFormula1.value;
							window.close();
							//refreshParent('frmCommonPage', 'MetricBuilder_CommonPage.aspx','../METRICS/MetricBuilder_CommonPage.aspx?MetricID_PK=<%=m_intMetricID%>&MasterTagID=2503&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');
//							"../METRICS/MetricBuilder_CommonPage.aspx?MetricID_PK=28&PKToken=BIwvHeJYZiG9XN1uYv6tog&MasterTagID=2503&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
						}
					}
				}
				//***********************************
				//objform.action = "MB_MeasurementUI.aspx?Mode=<%=m_strMode%>&Action=SAVE&MetricID=<%=m_intMetricID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				//objform.submit();
			}
		}
		
		function Validate_OnClick()
		{
			if (Validate() == true)
			{
				objform.action = "MB_MeasurementUI.aspx?Mode=<%=m_strMode%>&CorporateLevelMB=<%=m_CorporateLevelMB%>&Action=VALIDATE&MetricID=<%=m_intMetricID%>&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>&ProjectID=<%=m_intProjectID%>";
				objform.submit();
			}
		}
		
		function Execute_OnClick()
		{
			if (Validate() == true)
			{
				objform.action = "MB_MeasurementUI.aspx?Mode=<%=m_strMode%>&Action=EXECUTE&FormulaID=<%=m_lngFormulaID%>&EntityID=<%=m_lngEntityID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&Alphabet=<%=m_strAlphabet%>";
				objform.submit();
			}
		}
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var msg;
			
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
						
			msg = "<%=m_strInvalidFormulaNameMsg%>";
			if (trimString(msg)!= "")
			{
				alert(msg);
				objtxtFormulaName.focus(); 
				return;
			}
			
			msg = "<%=m_strInvalidFormulaMsg%>";
			if (trimString(msg)!= "")
			{
				alert(msg);
				return;
			}
			
			msg = "<%=m_strFormulasCannotBeDeletedMsg%>";
			if (trimString(msg)!="")
			{
				alert(msg);
				return;
			}
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
            
		   
		}
		</script>
		
	</body>
</HTML>
<%Process()%>
