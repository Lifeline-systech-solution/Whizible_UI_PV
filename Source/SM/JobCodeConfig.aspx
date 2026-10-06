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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="JobCodeConfig.aspx.vb" Inherits="PbNIT.JobCodeConfig" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->

<html>
 	<%CommonFunctions.General.PlotPageHeadTag("Project Code Configuration")%>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmJobCodeConfig"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmJobCodeConfig');
		var objdivlist=GetObjectReference('frmJobCodeConfig','PageDiv');
		
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
		function OnlyNumeric(intAllowDecimal)
		{
			var KeyAscii = window.event.keyCode;
			
			if (intAllowDecimal==1 && KeyAscii == 46)
			{
			return;
			}
			
			else
			{
			if ( KeyAscii < 48 || KeyAscii > 57 ) 
				{ window.event.keyCode = 0; } 
			}	
		}
		function AddNew_OnClick()
		{
			objform.action = "JobCodeConfig.aspx?Mode=ADD"; 
			objform.submit();
		}
		function Save_OnClick()
		{
			var objNoControl=GetObjectReference('frmJobCodeConfig','txtStartLCV',true);	
			var resultNo=objNoControl.length;
			var i,j,currindex;
			var blnControlArray;
			var strDelimtedString;
			var objLastJobCode=GetObjectReference('frmJobCodeConfig','txtLastJobCode',true);	
			var objtxtStartLCV=GetObjectReference('frmJobCodeConfig','txtStartLCV',true);	
			var objtxtEndLCV=GetObjectReference('frmJobCodeConfig','txtEndLCV',true);	
			var objtxtStartJob=GetObjectReference('frmJobCodeConfig','txtStartJobCode',true);	
			var objtxtEndJob=GetObjectReference('frmJobCodeConfig','txtEndJobCode',true);	
			if(resultNo==1)//single control
			{
				blnControlArray=0;
				var result;
				objLastJobCode=GetObjectReference('frmJobCodeConfig','txtLastJobCode');
				objtxtStartLCV=GetObjectReference('frmJobCodeConfig','txtStartLCV');
				objtxtEndLCV=GetObjectReference('frmJobCodeConfig','txtEndLCV');
				objtxtStartJob=GetObjectReference('frmJobCodeConfig','txtStartJobCode');
				objtxtEndJob=GetObjectReference('frmJobCodeConfig','txtEndJobCode');
				
				
				result=disallowBlank(objtxtStartLCV);
				if(result==true)
				{
					alert("<%=MyBase.GetResourceString("BLANK_STARTLCV")%>");
					return;
				}
				
				result=disallowBlank(objtxtEndLCV);
				if(result==true)
				{
					alert("<%=MyBase.GetResourceString("BLANK_ENDLCV")%>");
					return;
				}
				if (disallowValue1GreaterThanValue2(objtxtStartLCV,objtxtEndLCV)) 
				{
					alert("<%=MyBase.GetResourceString("LCVGRCHECK")%>");
					return;
				}	
				
				
				result=disallowBlank(objtxtStartJob);
				if(result==true)
				{
					alert("<%=MyBase.GetResourceString("BLANK_STARTJOBNO")%>");
					return;
				}
				
				
				result=disallowBlank(objtxtEndJob);
				if(result==true)
				{
					alert("<%=MyBase.GetResourceString("BLANK_ENDJOBNO")%>");
					return;
				}
				if (disallowValue1GreaterThanValue2(objtxtStartJob,objtxtEndJob)) 
				{
					alert("<%=MyBase.GetResourceString("JOBNOGRCHECK")%>");
					return;
				}	
						
			}
			
			if(resultNo>1)
			{
				blnControlArray = 1  //..... Control Array
				var intInd=0;
				while(intInd<=resultNo-1)
				{
					var result;
					
					result=disallowBlank(frmJobCodeConfig.txtStartLCV[intInd]);
					if(result==true)
					{
						alert("<%=MyBase.GetResourceString("BLANK_STARTLCV")%>");
						return;
					}
					
					result=disallowBlank(frmJobCodeConfig.txtEndLCV[intInd]);
					if(result==true)
					{
						alert("<%=MyBase.GetResourceString("BLANK_ENDLCV")%>");
						return;
					}
					if (disallowValue1GreaterThanValue2(frmJobCodeConfig.txtStartLCV[intInd],frmJobCodeConfig.txtEndLCV[intInd])) 
					{
						alert("<%=MyBase.GetResourceString("LCVGRCHECK")%>");
						return;
					}	
					
					
					result=disallowBlank(frmJobCodeConfig.txtStartJobCode[intInd]);
					if(result==true)
					{
						alert("<%=MyBase.GetResourceString("BLANK_STARTJOBNO")%>");
						return;
					}
					
					result=disallowBlank(frmJobCodeConfig.txtEndJobCode[intInd]);
					if(result==true)
					{
						alert("<%=MyBase.GetResourceString("BLANK_ENDJOBNO")%>");
						return;
					}
					if (disallowValue1GreaterThanValue2(frmJobCodeConfig.txtStartJobCode[intInd],frmJobCodeConfig.txtEndJobCode[intInd])) 
					{
						alert("<%=MyBase.GetResourceString("JOBNOGRCHECK")%>");
						return;
					}	
					intInd++;	
				}//while
			}//if
			//validate range overlap for LCV Range, Validate range overlap for Job Code Range
			
			if(blnControlArray==1)
			{
				
				for(i=0;i<resultNo;i++)
				{
					
					currindex=i;
					for(j=0;j<resultNo;j++)
					{
							
						if(j!=currindex)
						{
					
							//Check start range of LCV
							if(((parseFloat(objtxtStartLCV[currindex].value)  > parseFloat(objtxtStartLCV[j].value))||(parseFloat(objtxtStartLCV[currindex].value)  == parseFloat(objtxtStartLCV[j].value))) && ((parseFloat(objtxtStartLCV[currindex].value) < parseFloat(objtxtEndLCV[j].value))||(parseFloat(objtxtStartLCV[currindex].value) == parseFloat(objtxtEndLCV[j].value)))==true)
								{
								alert("<%=MyBase.GetResourceString("LCVOVERLAP")%>");
								setFocus(objtxtStartLCV[currindex]);
								return;
								}
							
							//'Check End range for LCV
							if(((parseFloat(objtxtEndLCV[currindex].value) > parseFloat(objtxtStartLCV[j].value))||(parseFloat(objtxtEndLCV[currindex].value) == parseFloat(objtxtStartLCV[j].value))) && ((parseFloat(objtxtEndLCV[currindex].value) < parseFloat(objtxtEndLCV[j].value))||(parseFloat(objtxtEndLCV[currindex].value) == parseFloat(objtxtEndLCV[j].value)))==true)
								{
								alert("<%=MyBase.GetResourceString("LCVOVERLAP")%>");
								setFocus(objtxtEndLCV[currindex]);
								return;
								}
						
							//'Check start rnage for job code
							if(((parseFloat(objtxtStartJob[currindex].value) > parseFloat(objtxtStartJob[j].value))||(parseFloat(objtxtStartJob[currindex].value) == parseFloat(objtxtStartJob[j].value))) && ((parseFloat(objtxtStartJob[currindex].value) < parseFloat(objtxtEndJob[j].value))||(parseFloat(objtxtStartJob[currindex].value) == parseFloat(objtxtEndJob[j].value)))==true)
								{
								alert("<%=MyBase.GetResourceString("JOBNOOVERLAP")%>");
								setFocus(objtxtStartJob[currindex]);
								return;
								}
							
							//'check end range fo rjob code
							if (((parseFloat(objtxtEndJob[currindex].value)  > parseFloat(objtxtStartJob[j].value))|| (parseFloat(objtxtEndJob[currindex].value)  == parseFloat(objtxtStartJob[j].value))) && ((parseFloat(objtxtEndJob[currindex].value) < parseFloat(objtxtEndJob[j].value))||(parseFloat(objtxtEndJob[currindex].value) == parseFloat(objtxtEndJob[j].value)))==true) 
								{
								alert("<%=MyBase.GetResourceString("JOBNOOVERLAP")%>");
								setFocus(objtxtEndJob[currindex]);
								return;
								}
													
						}
					}
					
					
				}
			}
			strDelimtedString='';
			if(blnControlArray==1)
			{
				
				
				for(i=0;i<resultNo;i++)
				{
					if(i==(resultNo-1))
					{
					strDelimtedString = strDelimtedString + objLastJobCode[i].value + "~" +objtxtStartLCV[i].value + "-" +objtxtEndLCV[i].value + "~" +objtxtStartJob[i].value + "-" +objtxtEndJob[i].value;
									
					}
					else
					{
					strDelimtedString = strDelimtedString + objLastJobCode[i].value + "~" +objtxtStartLCV[i].value + "-" +objtxtEndLCV[i].value + "~" +objtxtStartJob[i].value + "-" +objtxtEndJob[i].value + ",";
					}
					
				}
				
			}
			else
			{
				strDelimtedString = strDelimtedString + objLastJobCode.value + "~" +objtxtStartLCV.value + "-" +objtxtEndLCV.value + "~" +objtxtStartJob.value + "-" +objtxtEndJob.value;
			}
			
		var objHidden=GetObjectReference('frmJobCodeConfig','txtHidden');	
		objHidden.value = strDelimtedString;
		objform.action = "JobCodeConfig.aspx?Mode=Save" 
		objform.submit();
		}
		
		function Close_OnClick()
		{
		window.close();
		}
	
		
	</Script>
	  </body>
</html>
