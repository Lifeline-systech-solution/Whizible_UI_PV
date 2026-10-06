<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .clsTable td {
    vertical-align: middle !important;
    padding: 2px;
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QRB_CT_QuerySharing.aspx.vb" Inherits="Whiz.QRB_CT_QuerySharing" %>

<!DOCTYPE HTML>
<HTML>
	
    <%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle,,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%><% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
   

     <body class='clsBody' onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id='frmCTQuerySharing' name='frmCTQuerySharing' method='post' runat='server'>
			<%PageInit()%>
		</form>
	    <script language="javascript">

		var objdivlist;
		var objform;
		var txtModified;
		//	 Added By Shrikant B For WAF3_PB_64
        <% 

        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivBody';")
        Response.Write("blnNavigate = null;")
        Response.Write("strControlsToExcludeFrmNavigationAlert='txtName';")    
        End If
        %>
        //End Addition by Shrikant B For WAF3_PB_64
		
		objform = GetFormReference('frmCTQuerySharing');
		objdivlist = GetObjectReference('frmCTQuerySharing','DivBody');
		txtModified = GetObjectReference('frmCTQuerySharing','hdModified');
		
		<%MyBase.InitializeResources("Resources.QRB_ReviewAssignment", "Resources")%>;
		<% 'WAF3_PB_42 April 10, 2007 START 
	  'Removed local functions for window onload and resize 
	  'WAF3_PB_42 April 10, 2007 END%>
	    function Paging_OnClick(strAlphabet)
	    {
		    var objTxt,i;
		    var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser'); 
		    for(i=0;i< objSelectedUserList.options.length;i++)
			    objSelectedUserList.options[i].selected=true;	
    		
		    objTxt = GetObjectReference('frmCTQuerySharing','hdAlphabet');
		    objTxt.value = URLEncode(strAlphabet);//Modified By Shrikant IssueID 20608
		    
    		
		    objform.action="QRB_CT_QuerySharing.aspx?CTQueryID=<%=m_lngCTQueryID%>";
		     blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		    objform.submit();
		}
		function Filter_OnChange()
	    {
		    var i;
		    var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser'); 
		    for(i=0;i< objSelectedUserList.options.length;i++)
			    objSelectedUserList.options[i].selected=true;	
    		
		    objform.action="QRB_CT_QuerySharing.aspx?CTQueryID=<%=m_lngCTQueryID%>";
		     blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		    objform.submit();
	    }
	    function Show_OnClick()
	    {
		    var objTxt,i;
		    var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser'); 
    			
		    objTxt = GetObjectReference('frmCTQuerySharing','txtName');
		    if(objTxt.value != '' && objTxt.value != null)
		    {
			    for(i=0;i< objSelectedUserList.length;i++)
			    objSelectedUserList.options[i].selected=true;
    			
			    objform.action="QRB_CT_QuerySharing.aspx?CTQueryID=<%=m_lngCTQueryID%>";
			    blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
			    objform.submit();
		    }
		    else
		    {
			    alert('<%=MyBase.GetResourceString("MSG_FILTER_EMPTY")%>');
			    objTxt.focus()
		    }
	    }
        function Clear_OnClick()
	    {
		    var objTxt,i;
		    var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser'); 
    		
		    for(i=0;i< objSelectedUserList.length;i++)
			    objSelectedUserList.options[i].selected=true;	
    		
		    objTxt = GetObjectReference('frmCTQuerySharing','txtName');
		    objTxt.value="";
		    objTxt=null;
		    objTxt = GetObjectReference('frmCTQuerySharing','hdAlphabet');
		    objTxt.value = "-1";
		    objTxt=null;
    	
		    objform.action="QRB_CT_QuerySharing.aspx?CTQueryID=<%=m_lngCTQueryID%>";
		    blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		    objform.submit();		
	    }
	    function AddAll_OnClick()
		{
			var objUserList = GetObjectReference('frmCTQuerySharing','lstUserList'); 
			var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser'); 
		    var Count = objUserList.length;
			
			if (objUserList.length > 0) 
			{	var intCounter;
				for (intCounter = 0;intCounter < Count;)
				{
					var objOption = document.createElement("OPTION");				
				    //Commented And Added By Vaijat K ON 26/11/2015
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
					    //objSelectedUserList.options.add(objOption);
					    document.getElementById("lstSelectedUser").appendChild(objOption);
					else
						objSelectedUserList.add(objOption,null);

					objOption.text = objUserList.options[intCounter].text;	
					objOption.value = objUserList.options[intCounter].value;	
					
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						{
						    objUserList.options.remove(intCounter);
						    Count=objUserList.options.length;
						}
					else
						{
						    objUserList.remove(intCounter);
						    Count = objUserList.length;
						}
					objSelectedUserList.focus();
					txtModified.value = 'yes';
				}
			}
		}			
		function Add_OnClick()
		{
			var objUserList = GetObjectReference('frmCTQuerySharing','lstUserList');			
			var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser');						
			var intCounter;
			for(intCounter=0;intCounter < objUserList.length;)
			{
				if(objUserList.options[intCounter].selected==true)
				{
				    var objOption = document.createElement("OPTION");
				    //Commented And Added By Vaijat K ON 26/11/2015
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
					    //objSelectedUserList.options.add(objOption);
					    document.getElementById("lstSelectedUser").appendChild(objOption);
					else
						objSelectedUserList.add(objOption,null);	
					objOption.text = objUserList.options[intCounter].text;	

					objOption.value = objUserList.options[intCounter].value;	

				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						objUserList.options.remove(intCounter);
					else
						objUserList.remove(intCounter);

					txtModified.value = 'yes';
				}
				else
				{
				    intCounter++;
				}
			}
		}
		function Remove_OnClick()
		{//debugger;
			var objUserList = GetObjectReference('frmCTQuerySharing','lstUserList');
			var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser');
			var intCounter;
			for(intCounter=0;intCounter<objSelectedUserList.length;)
			{
				if(objSelectedUserList.options[intCounter].selected==true)
				{
					var objOption = document.createElement("OPTION");
				    //Commented And Added By Vaijat K ON 26/11/2015
				    //if(navigator.appName == 'Microsoft Internet Explorer')
                    if (WhichBrowser() == 'IE')
                        //objUserList.options.add(objOption);
                        document.getElementById("lstUserList").appendChild(objOption);
					else
						objUserList.add(objOption,null);
					objOption.text=objSelectedUserList.options[intCounter].text;
					objOption.value=objSelectedUserList.options[intCounter].value;
			
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						objSelectedUserList.options.remove(intCounter);
					else
						objSelectedUserList.remove(intCounter);
				}
				else
				{
					intCounter++;
				}
			}
		}
		function RemoveAll_OnClick()
		{
		    var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser');
		    var objUserList = GetObjectReference('frmCTQuerySharing','lstUserList');
		    var Count = objSelectedUserList.length;
		    if (objSelectedUserList.length>0) 
			{	var intCounter;
				for (intCounter=0;intCounter< Count; )
				{
					var objOption = document.createElement("OPTION");				

				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
                        //Commented And Added By Vaijat K ON 26/11/2015
					    //objUserList.options.add(objOption); 
					    document.getElementById("lstUserList").appendChild(objOption);
					else
						objUserList.add(objOption,null);					

					objOption.text = objSelectedUserList.options[intCounter].text;	
					objOption.value = objSelectedUserList.options[intCounter].value;	
					
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						{
						objSelectedUserList.options.remove(intCounter);
						Count = objSelectedUserList.options.length;
						}
					else
						{
						objSelectedUserList.remove(intCounter);
						Count = objSelectedUserList.length;
						}
				
					objUserList.focus();
				}
			}	
		}
		function Save_OnClick()
		{
			var i,count,ans;
			var call=false;
			var objSelectedUserList = GetObjectReference('frmCTQuerySharing','lstSelectedUser');
			if(navigator.appName == 'Microsoft Internet Explorer')
				count = objSelectedUserList.options.length;
			else
				count = objSelectedUserList.length;

			if(count < 1)
			{
				ans = window.confirm('<%=mybase.GetResourceString("MSG_NOSHARE")%>');
				if(ans==true)
					call=true;
				else
					call=false;	 
			}
			else
				call=true;
				
			if(call==true)
			{
				for(i=0;i< count;i++)
					objSelectedUserList.options[i].selected=true;
				objform.action="QRB_CT_QuerySharing.aspx?CTQueryID=<%=m_lngCTQueryID%>&Action=SAVE";
				blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
				objform.submit();
			}
		}
	        function WhichBrowser() {

	            var brwser = '';
	            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
	            if (/trident/i.test(M[1])) {
	                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
	                //return 'IE '+(tem[1] || '');
	                return 'IE';
	            }
	            if (M[1] === 'Chrome') {
	                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
	                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
	                brwser = 'CR';
	            }
	            else if (M[1] === 'Firefox') {
	                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
	                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
	                brwser = 'FF';
	            }
	            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
	            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
	            //return M.join(' ');
	            return brwser;
	        }
		</script>
	</body>
</html>