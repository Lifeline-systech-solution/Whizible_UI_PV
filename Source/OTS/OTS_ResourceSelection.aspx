<%@ Page Language="vb" AutoEventWireup="false" Codebehind="OTS_ResourceSelection.aspx.vb" Inherits="PbNIT.OTS_ResourceSelection" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
    <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("OTS_ResourceSelection")%>
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"  type="text/javascript"></script> -->
<script src="../../responsive/responsive.js"></script>


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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmOTS_ResourceSelection"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmOTS_ResourceSelection');
		var objdivlist=GetObjectReference('frmOTS_ResourceSelection','PageDiv');
		
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
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
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
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
			}
		}	
		function Paging_OnClick(chr)
		{
			objform.action = "OTS_ResourceSelection.aspx?Alphabet=" + chr;
			objform.submit();
		}
		function Filter_OnChange()
		{
			objform.action = "OTS_ResourceSelection.aspx?";
			objform.submit();
		}
		function Show_OnClick()
		{
			//Code added By DebadattaR on 28-Sep-2005. 
			var objUserName=GetObjectReference('frmCommonList','txtEmpName')
			var objEmail=GetObjectReference('frmCommonList','txtEmailID1')
			var objEmpID =GetObjectReference('frmCommonList','txtEmployeeID')
			var flag=0;
			
			if(disallowMinlengthViolation(objUserName,3,'Please specify minimum 3 characters for search.',true))
				return;
			if(disallowMinlengthViolation(objEmail,3,'Please specify minimum 3 characters for search.',true))
				return;
			if(disallowMinlengthViolation(objEmpID,3,'Please specify minimum 3 characters for search.',true))
				return;
			if(objEmail.value!='' || objEmpID.value!='')
				flag=1; 
			else 
				flag=0;
				
			if (flag==0)
			{
				alert('Please specify Employee ID / Email ID.');
				objEmpID.focus();
				return;
			}
			//End of code added By DebadattaR on 28-Sep-2005.
			
			objform.action = "OTS_ResourceSelection.aspx?";
			objform.submit();
		}
		function Clear_OnClick()
		{
			var objTxt;
			objTxt = GetObjectReference('frmOTS_ResourceSelection','txtEmpName');
			objTxt.value='';
			objTxt = GetObjectReference('frmOTS_ResourceSelection','txtEmployeeID');
			objTxt.value='';
			objTxt = GetObjectReference('frmOTS_ResourceSelection','txtEmailID');
			objTxt.value='';
			
			objform.action = "OTS_ResourceSelection.aspx?";
			objform.submit();
		}
		//Code Added by RajkumarM on 5th Oct to Add SelectAll link
		function SelectAll_OnClick()
			{
				var objChkSelect;
				objChkSelect=GetObjectReference('frmOTS_ResourceSelection','chkSelect',true);
				if(objChkSelect!=null)
				{
					var len=objChkSelect.length;
					var intCount;
										
					if(len==1)
					{
						objChkSelect.checked=true;
					}
					else
					{
						
						for(intCount=0;intCount<len;intCount++)
						{
							objChkSelect[intCount].checked=true
						}
					} 
				}
			}
			
			function ClearAll_OnClick()
			{
				var objChkSelect;
				objChkSelect=GetObjectReference('frmOTS_ResourceSelection','chkSelect',true);
				if(objChkSelect!=null)
				{
					var len=objChkSelect.length;
					var intCount;
										
					if(len==1)
					{
						objChkSelect.checked=false;
					}
					else
					{
						
						for(intCount=0;intCount<len;intCount++)
						{
							objChkSelect[intCount].checked=false
						}
					} 
				}
			}
			
			//Code Added by RajkumarM on 5th Oct to Add SelectAll link
			
		function Save_OnClick()
		{
			
			if("<%=m_strSingleSelect%>"==1)
			{
				var objChkSelect;
				objChkSelect=GetObjectReference('frmOTS_ResourceSelection','chkSelect',true);
				if(objChkSelect!=null)
				{
					var len=objChkSelect.length;
					var intCount,intSelected;
					var intSelectedCount=0;
					var EmpID;
					if(len==1)
					{
						objChkSelect=GetObjectReference('frmOTS_ResourceSelection','chkSelect');
						EmpID=objChkSelect.value;
					}
					else
					{
						
						for(intCount=0;intCount<len;intCount++)
						{
							if(objChkSelect[intCount].checked==true)
							{
								intSelectedCount=intSelectedCount+1;
								
							}
						}
					}
					if(intSelectedCount>1)
					{
						alert('Only single selection is allowed.');
						return;
					}
					
					else if(intSelectedCount==1)
					{
						if(len==1)
							intSelected=1;
						else
							{
								for(intCount=0;intCount<len;intCount++)
								{
									if(objChkSelect[intCount].checked==true)
									{
										intSelected=intCount;
										EmpID=objChkSelect[intCount].value;
										break;
									}
								}	
							}
							
						var objParentEmpID;
						var objParentEmpName;
						var objEmailID,objPEmailID;
						objParentEmpID=GetParentObjectReference('frmCommonPage','EmployeeID')
						objParentEmpName=GetParentObjectReference('frmCommonPage','UserName')
						objPEmailID=GetParentObjectReference('frmCommonPage','EmailID')
						var objName=GetObjectReference('frmOTS_ResourceSelection','txtUserName' + EmpID);
						var objEmailID=GetObjectReference('frmOTS_ResourceSelection','txtEmailID1' + EmpID);
						if(objParentEmpID!=null)
						objParentEmpID.value=EmpID;
						if(objParentEmpName!=null)
						objParentEmpName.value=objName.value;
						if(objPEmailID != null)
							objPEmailID.value=objEmailID.value;
						window.close();
					}
					
				}
				else
				{
					var objParentEmpID;
					var objParentEmpName;
					var objPEmailID;
					objParentEmpID=GetParentObjectReference('frmCommonPage','EmployeeID')
					objParentEmpName=GetParentObjectReference('frmCommonPage','UserName')
					objPEmailID=GetParentObjectReference('frmCommonPage','EmailID')
					if(objParentEmpID!=null)
						objParentEmpID.value='';
					if(objParentEmpName!=null)
						objParentEmpName.value='';
					if(objPEmailID != null)
						objPEmailID.value='';
				}
			}
			else
			{
			objform.action = "OTS_ResourceSelection.aspx?Action=<%=CONST_ACTION_SAVE%>";
			objform.submit();
			}
		}
	</Script>
  </body>
</html>
