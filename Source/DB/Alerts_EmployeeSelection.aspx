<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Alerts_EmployeeSelection.aspx.vb" Inherits="PbNIT.Alerts_EmployeeSelection"%>
<!DOCTYPE HTML>
<HTML>
    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
			<form id="frmEmployeeSelection" name="frmEmployeeSelection" method="post" runat="server">
						
									<%PageInit()%>
							
					</form>
				
					<script language="javascript">
			var objdivlist;
			var objform;
			
			var objFilter;
			
			objform = GetFormReference('frmEmployeeSelection');
			objdivlist = GetObjectReference('frmEmployeeSelection','DivList');
			
			objFilter =GetObjectReference('frmEmployeeSelection','txtFilter');
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
			 //Modified by JyotiG on Date 11 July,2006 for PMLifeline Issue ID.4168

			function window_onload()		
			{
			//debugger;
				var intDivHeight ;
				var intDivHeightRisk;
				
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100){	intDivHeight = 100; }
				//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeline Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/201	;	
		}
			function window_onresize()		
			
			{
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeline Issue ID.4168

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
				objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/201	;	
			}
			
			function Paging_OnClick(chr)
			{
			//Modified by MrugajaB for Issue ID.1835
			
				objform.action = "Alerts_EmployeeSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>&Alphabet=" + chr;
				objform.submit();
			}
		/*	function Filter_OnChange()
			{
				objform.action = "Alerts_CustomerSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}*/
			function Show_OnClick()
			{
				objform.action = "Alerts_EmployeeSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function Clear_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmEmployeeSelection','txtFilter');
				objTxt.value='';
				
				objform.action = "Alerts_EmployeeSelection.aspx?Mode=<%=m_strMode%>&Date=<%=m_strDate%>&intReviewee=<%=m_intReviewee%>&ReviewstatisticsID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function ShowEmployee_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmEmployeeSelection','txtShowEmployee');
				objTxt.value='1';
				objform.action = "Alerts_EmployeeSelection.aspx?intCustomer=1&EntryID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			function ShowAll_OnClick()
			{
				var objTxt;
				objTxt = GetObjectReference('frmEmployeeSelection','txtShowEmployee');
				objTxt.value='';
				objform.action = "Alerts_EmployeeSelection.aspx?EntryID=<%=m_strReviewStatisticsID%>";
				objform.submit();
			}
			
			function SetEmployee_OnClick()
			{
				var objChk,intCnt,intLen;
				var blnSelected=false;
				
				objChk = GetObjectReference('frmEmployeeSelection','chkSelect',true);
				try
				{
					intLen = objChk.length;
			
					if(intLen > 0)
					{
						for(intCnt=0;intCnt<intLen;intCnt++)
						{
							if(objChk[intCnt].checked==true)
							{
								blnSelected=true;
								break;
							}
						}
					}
					
					if(blnSelected==false)
					{
						alert('Please select atleast one employee');
					}
					else
					{
						objform.action = "Alerts_EmployeeSelection.aspx?Action=<%=CONST_ACTION_SAVE%>";	
						objform.submit();
					}
				}
				catch(e)
				{}
			}
			function chkSelect_OnClick(obj)
			{
			
				//PURPOSE: To update the ReviewerID list when a reviewer is selected / removed.
				var objTxt,strReviewerIDList;
				objTxt = GetObjectReference('frmEmployeeSelection','txtEmployeeIDList');
				strReviewerIDList = new String(objTxt.value);
				
				var EmpID = obj.value;
				
				//If the resource has been added to the list of reviewers, then...
				if(obj.checked==true)
				{
					//if not in the list then add 
					if(strReviewerIDList.indexOf("," + EmpID +",",0)==-1)
					{
						strReviewerIDList = strReviewerIDList + EmpID + ",";
						objTxt.value = strReviewerIDList; 
					}
				}
				else
				{
					if(strReviewerIDList.indexOf("," + EmpID +",",0) != -1)
					{
						//Remove the Employee ID from the comma separated list.
						strReviewerIDList = replaceSubstring(strReviewerIDList,"," + EmpID + ",","," );
						objTxt.value = strReviewerIDList; 
					}
				}		
			}
			
		function txtFilter_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
			if(code==13) 
			{
				var objFilter =  GetObjectReference('frmEmployeeSelection','txtFilter');
				Page_OnClick(objFilter.value);

			}
		}
		</script>
	</body>
</HTML>
