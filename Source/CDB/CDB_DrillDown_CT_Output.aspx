<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_DrillDown_CT_Output.aspx.vb" Inherits="Whiz.CDB_DrillDown_CT_Output"%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body style="overflow:auto" MS_POSITIONING="GridLayout" class="clsCDBBody">			 
		<form id="frmCDBCTOUT" method="post" runat="server">		   
				<%WritePage%>			
		</form>
	<script language=javascript>
		var objdiv;
		var objfrm;
		objfrm = GetFormReference('frmCDBCTOUT');
		objdiv = GetObjectReference('frmCDBCTOUT','DivListCT');
		
		function Detail_OnClick(y,x,queryid, detailqueryid)
		{
			x = URLEncode(x);
			y = URLEncode(y);
		    //window.open("../QRB/QRB_CT_OutputDetail.aspx?QueryID="+ detailqueryid  + "&CTQueryID=" + queryid + "&y=" + y + "&x=" + x + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=<%=m_strWhereForDetail%>&FromAdmin=<%=m_intFromAdmin%>&TransPgID=<%=m_lngTransactionPageID%>","CT_OutputDetail","menubar=yes,resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 500)/2) + ",height=500,width=600"); 
			$.ajax({
			    type: 'POST',
			    dataType: 'json',
			    contentType: 'application/json',
			    url: 'CDB_DrillDown_CT_Output.aspx/GenrateURLToken',
			    data: JSON.stringify({ QueryID: detailqueryid, CTQueryID: queryid, DashboardID: "<%=m_lngDashboardID%>", ItemID: "<%=m_lngItemId%>", EmployeeID: "<%=Session("intUserID")%>" }),
			    success: function (Result) {
			        window.open("../QRB/QRB_CT_OutputDetail.aspx?QueryID=" + detailqueryid + "&FromWhere=XAXIS&PKToken=" + Result.d + "&CTQueryID=" + queryid + "&y=" + y + "&x=" + x + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=<%=m_strWhereForDetail%>&FromAdmin=<%=m_intFromAdmin%>&TransPgID=<%=m_lngTransactionPageID%>", "CT_OutputDetail", "menubar=yes,resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - 600) / 2) + ",top=" + ((window.screen.height - 500) / 2) + ",height=500,width=600"); 
                        //  callback.call(strToken);
                    },
                    error: function () {
                        alert("Error")
                    }
            });
			
		}
		function AttributeChanged()
		{
			var strURL = "<%=m_strLocationURL%>"
			var objCboXAxisAttribute = GetObjectReference('frmCDBCTOUT','cboXAxisAttribute');
			var objCboYAxisAttribute = GetObjectReference('frmCDBCTOUT','cboYAxisAttribute');
			if (objCboXAxisAttribute != null && objCboYAxisAttribute != null)
			{
				if (objCboXAxisAttribute.value != objCboYAxisAttribute.value)
				{
					strURL += "&XAxisAttribute=" + objCboXAxisAttribute.value;
					strURL += "&YAxisAttribute=" + objCboYAxisAttribute.value;
				}
				else
				{
					alert("Please Select Different X and Y Axis Attributes.");
					return;
				}
			}
			window.location.href = strURL;			
		}
		function ShowGraph()
		{
		    var iHeight=550,iWidth=990; 
            var sUrl = "../CDB/CDB_CT_Graph.aspx?x=<%=m_strXAxisAttribute%>&y=<%=m_strYAxisAttribute%>&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&FromAdmin=<%=m_intFromAdmin%>";
            //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
		    //window.open(sUrl,"_CTGraph","resizable=no,scrollbars=no,status=no,left=" + ((window.screen.width - iWidth)/2) + ",top=" + ((window.screen.height - iHeight)/2) + ",height="+ iHeight+",width="+iWidth); 
            window.open(sUrl, "_CTGraph", "resizable=yes,scrollbars=no,status=no,left=" + ((window.screen.width - iWidth) / 2) + ",top=" + ((window.screen.height - iHeight) / 2) + ",height=" + iHeight + ",width=" + iWidth); 
            //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
		}
	</script>
	</body>
</html>
