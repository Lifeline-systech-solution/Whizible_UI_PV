<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DXU_LookUp.aspx.vb" Inherits="PbNIT.DXU_LookUp" %>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>DXU_LookUp</title>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		
        <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->


<%-- Commented by Madhuri.K On 14-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

    
         <script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
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

	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody">
		<form id="Form1" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
			var objfrmCommonPage = GetFormReference('Form1');
			var hdntxtTable = GetObjectReference('Form1', 'hdntxtTable');
			var strSelectedTable = hdntxtTable.value;
			var intFieldID = objfrmCommonPage.hdntxtFieldID.value;
			var intTemplateID = objfrmCommonPage.hdntxtTemplateID.value;
			
			 <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			function Save_onclick()
			{
				
				if (objfrmCommonPage.cboTable.selectedIndex <= 0 || objfrmCommonPage.txtMatchField == null)
				{
					alert('Please Select a table from the list');
					return;
				}
				if(objfrmCommonPage.txtMatchField != null && objfrmCommonPage.txtMatchField.value == '')
				{
					alert('Please select a column to match with.');
					return;
				}
				if(objfrmCommonPage.txtMatchValue != null && objfrmCommonPage.txtMatchValue.value == '')
				{
					alert('Please select a column whose value to insert.');
					return;
				}	
				hdntxtTable.value = objfrmCommonPage.cboTable.options[objfrmCommonPage.cboTable.selectedIndex].innerText;
				objfrmCommonPage.action="DXU_LookUp.aspx?intFieldID="+intFieldID+"&intTemplateID="+intTemplateID+"&PrimaryKeyName=<%=m_strPrimaryKey%>&Mode=Save&IsLookUP=1";
				objfrmCommonPage.submit();
				opener.location.href = "../DXU/DXU_MapFields.aspx?ForeignKey=TemplateID&PrimaryKeyName=<%=m_strPrimaryKey%>&TemplateID="+intTemplateID+"&FromSubTagCL=1";
			}
			
			function Cancel_onclick()
			{
				window.close();
			}
			
			function cboTable_OnChange()
			{
				var objForm = document.Form1; 
				var  objcboTable = GetObjectReference('Form1','cboTable'); 
				var IsLookUp;
				if(objcboTable.value != '') 
				{
					hdntxtTable.value = objcboTable.options[objcboTable.selectedIndex].innerText;
					<% If Not Request.querystring("IsLookUp") Is Nothing AndAlso Request.Querystring("IsLookUp") <> "" Then %>
							 IsLookUp = <%=Request.querystring("IsLookUp")%>;
					   <%Else%>
							 IsLookUp = 0;
					<%End If %>
							 
					objfrmCommonPage.action="DXU_LookUp.aspx?intFieldID="+intFieldID+"&intTemplateID="+intTemplateID+"&TableId="+objcboTable.value+"&PrimaryKeyName=<%=m_strPrimaryKey%>&Mode=PopulateCombo&IsLookUp="+IsLookUp;
					objfrmCommonPage.submit();
				}
				
			}
			
			function AddForeignKey()
			{
				var objlistbox = objfrmCommonPage.lstColumns;
				var objComboBox = objfrmCommonPage.hdncboDatatypes
				if (objlistbox.selectedIndex >= 0)
				{
					if(objlistbox.options[objlistbox.selectedIndex].text == objfrmCommonPage.txtMatchValue.value)
					{
						alert("Please select another field!!");	
					}
					else
					{
						//Code added by SandipL for Data type validation on 23 Sep For Whizengg Team
						 var strXtype = objComboBox.options[objlistbox.selectedIndex].text
						 if ( strXtype != 48 && strXtype != 52 && strXtype != 56 && strXtype != 108 && strXtype != 127  )
						 {
								 alert("Data type of selected field should be Numeric ");
						 }
						 else
						 //End addition by SandipL
						 objfrmCommonPage.txtMatchField.value = objlistbox.options[objlistbox.selectedIndex].text; 
					}
				}
				else
				{
					alert("Please select a value from the list box first!!");
				}
				
			}
			
			function AddFieldToMatch()
			{
				var objlistbox = objfrmCommonPage.lstColumns;
				if(objlistbox.selectedIndex >= 0)
				{
					if(objlistbox.options[objlistbox.selectedIndex].text == objfrmCommonPage.txtMatchField.value)
					{
						alert("Please select another field!!");	
					}
					else
					{
						objfrmCommonPage.txtMatchValue.value = objlistbox.options[objlistbox.selectedIndex].text; 
					}	
				}
				else
				{
					alert("Please select a value from the list box first!!");
				}
				
			}
			function ClearLookUp_onclick()
			{
					objfrmCommonPage.action="DXU_LookUp.aspx?intFieldID="+intFieldID+"&intTemplateID="+intTemplateID+"&PrimaryKeyName=<%=m_strPrimaryKey%>&Mode=ClearLookUp&IsLookUp=0";
					objfrmCommonPage.submit();	
					opener.location.reload();
			}
			function DefLookup_onclick()
			{
			
				objfrmCommonPage.action="DXU_LookUp.aspx?intFieldID="+intFieldID+"&intTemplateID="+intTemplateID+"&PrimaryKeyName=<%=m_strPrimaryKey%>&Mode=InsertDefault&IsLookUP=1";
				objfrmCommonPage.submit();
				opener.location.href = "../DXU/DXU_MapFields.aspx?ForeignKey=TemplateID&PrimaryKeyName=<%=m_strPrimaryKey%>&TemplateID="+intTemplateID+"&FromSubTagCL=1";
			
			}
		</script>
	</body>
</HTML>
