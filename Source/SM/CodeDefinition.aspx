<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CodeDefinition.aspx.vb" Inherits="PbNIT.CodeDefinition" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Code Definition")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmCodeDefinition" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmCodeDefinition');
		var objdivlist=GetObjectReference('frmCodeDefinition','PageDiv');
		var objFromWhere = GetObjectReference('frmCodeDefinition', 'hdFromWhere');
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
           disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;

			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
        }
		}
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;

			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
        }
		}	
		function DisplaySelectBoxes(whichControl,obj)
		{
			var strOption = "";
			var strSelectBox = "";
			var intCounter;
			var strSepOption = "";
			var strSepSelectBox = "";
			var obj1, obj2, objTemp;
			
			for(intCounter=0;intCounter<arrFields.length;intCounter++) 
			{
				strOption += "<OPTION value=" + intCounter+1 + ">" + arrFields[intCounter] +"</OPTION>";
			}	

			strSelectBox += "<SELECT class=clsCombobox onChange=CodePreView() name=Seq" + whichControl + " id=Seq" + whichControl + ">" +strOption + "</SELECT>";
			strSelectBox += "<INPUT type=textbox style=display:none onChange=CodePreView()  "   + " name=txtCode" + whichControl + " id=txtCode" + whichControl +  " >"; 
			
			//-------------Commented by AbhijeetD on 4th June 2004---------------
			//strSepOption += "<OPTION value=" + 1 + ">" + "-";
			//strSepOption += "<OPTION value=" + 2 + ">" + ".";
			//strSepOption += "<OPTION value=" + 3 + ">" + " ";
			//---------------------------End comment---------------------------
			for(intCounter=0;intCounter<arrSeparators.length;intCounter++) 
			{
				strSepOption += "<OPTION value=" + intCounter+1 + ">" + arrSeparators[intCounter] +"</OPTION>";
			}	
			//Commented By VidyaJ on 21st March 2002
			//strSepOption += "<OPTION value=" + 4 + ">" + "\/";
			//strSepOption += "<OPTION value=" + 5 + ">" + "\\";
			
			strSepSelectBox += "<SELECT  class=clsCombobox onChange=CodePreView() id=Sep" + whichControl + ">" + strSepOption + "</SELECT>";

			obj1 = eval('document.all.tdSequence'+whichControl);
			obj2 = eval('document.all.tdSeperator'+whichControl);
			
			if (obj.checked == true)
			{
				obj1.innerHTML = strSelectBox;
				obj2.innerHTML = strSepSelectBox;
				
				obj1 = eval('document.all.Seq' + whichControl);
				obj1.selectedIndex =-1;
			}
			else
			{
				obj1.innerHTML = "";
				obj2.innerHTML = "";
			}
			CodePreView(whichControl);
		}

		function CodePreView(whichControl)
		{
			var obj1,obj2,obj3,obj4;
			var SequenceSelected, SeperatorSelected;
			var TemplateString = "";
			var strStyle;
			var strMainString = new String()
			var strSubString = new String()
			
			var objCodePreFix = GetObjectReference("frmCodeDefinition", "txtCodePreFix");
			if (objCodePreFix.value.search(",") != -1)
			{
				<%MyBase.InitializeResources("AppResources.CodeDefinition", "AppResources")%>
				alert('<%=MyBase.GetResourceString("VALIDATION_COMMA")%>');
				setFocus(objCodePreFix);
				return;
			}
			
			TemplateString += document.all.txtCodePreFix.value;
			strMainString = TemplateString
			
			/*If (strMainString.indexOf(strSubString,1) > 0 )
				{
					alert ("Duplicate values are present for " + SequenceSelected);
					return;
				}
			*/
			for (var i=1; i < 6; i++)
			{
				obj1 = eval('document.all.chk'+i);
							
				if ((obj1.checked))
				{
					obj2 = eval('document.all.Seq'+i);
					if (obj2.selectedIndex >-1)
					{
						
						SequenceSelected = eval('obj2.options[obj2.selectedIndex].text');
						
						strSubString = SequenceSelected;
						//alert (strSubString.length);
						strMainString=TemplateString
						if (strSubString.length > 0) 
						{
							//alert(strMainString.indexOf(strSubString,1));
							
							if(strMainString.indexOf(strSubString,1) >0) 
							{
								alert ("Duplicate values are present for " + SequenceSelected);	
								obj2.selectedIndex = -1;
								return false;
							}
						}		
					
					
						//Code Added By VidyaJ on 16th april 2003
						if (SequenceSelected=="Others")
							{
								obj4=eval('document.all.txtCode'+i);
								obj4.className="clstextbox";
								obj4.focus();
								SequenceSelected=obj4.value;
								obj3 = eval('document.all.Sep'+i);
								if (obj3.selectedIndex>-1)
								{
									SeperatorSelected = eval('obj3.options[obj3.selectedIndex].text');
									if(SeperatorSelected == '[space]' || SeperatorSelected == '[SPACE]')
										SeperatorSelected = ' '
									TemplateString +=  SequenceSelected + "" + SeperatorSelected;
								}
							}
						else
							{
								obj4=eval('document.all.txtCode'+i);
								obj4.className="DN";
								obj3 = eval('document.all.Sep'+i);
								if (obj3.selectedIndex>-1)
								{
									SeperatorSelected = eval('obj3.options[obj3.selectedIndex].text');
									if(SeperatorSelected == '[space]' || SeperatorSelected == '[SPACE]')
										SeperatorSelected = ' '
									TemplateString += "<" + SequenceSelected + ">" + SeperatorSelected;
								}
							}		
					}
				}
			}
			document.all.txtCodePreView.value = "";
			document.all.txtCodePreView.value = TemplateString;
			document.all.lblCodePreView.innerHTML = document.all.txtCodePreView.value;
			//alert (TemplateString);
		}
		function Save_OnClick()
		{
			var objSequence = GetObjectReference('frmCodeDefinition', 'txtCodePreView');
			if(ValidateSequence(objSequence.value)==true)
			{
				if(objFromWhere.value == "Issues" && strAfterSaveMsg != '')
				{
					if(window.confirm(strAfterSaveMsg))
					{
						frmCodeDefinition.action = "../SM/CodeDefinition.aspx?Action=Save&ModuleID=" + GetObjectReference('frmCodeDefinition', 'hdModuleID').value + "&FromWhere=" + GetObjectReference('frmCodeDefinition', 'hdFromWhere').value;
						frmCodeDefinition.submit(); 
					}
				}
				else
				{
					frmCodeDefinition.action = "../SM/CodeDefinition.aspx?Action=Save&ModuleID=" + GetObjectReference('frmCodeDefinition', 'hdModuleID').value + "&FromWhere=" + GetObjectReference('frmCodeDefinition', 'hdFromWhere').value;
					frmCodeDefinition.submit(); 
				}
				if (GetObjectReference('frmCodeDefinition', 'hdFromWhere').value != 'JobCode')
					opener.location.href = opener.location.href;
			}
		}
		function ValidateSequence(sequence)
		{
			if(objFromWhere.value == "Issues")
			{
				<%MyBase.InitializeResources("AppResources.CodeDefinition", "AppResources")%>
				if(sequence.search("Project Code") == -1)
				{
					alert('<%=MyBase.GetResourceString("PROJECT_CODE_MANDATORY")%>');
					return false;
				}
			}
			return true;
		}
		</Script>
	</body>
</HTML>
