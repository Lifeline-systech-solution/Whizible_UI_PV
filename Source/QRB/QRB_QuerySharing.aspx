<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_QuerySharing.aspx.vb" Inherits="Whiz.QRB_QuerySharing" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle,,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%>
	

    <body class='clsBody' onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmQuerySharing" name="frmQuerySharing" method="post" runat="server">
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
		
		objform = GetFormReference('frmQuerySharing');
		objdivlist = GetObjectReference('frmQuerySharing','DivBody');
		txtModified = GetObjectReference('frmQuerySharing','hdModified');
		
		<%MyBase.InitializeResources("Resources.QRB_ReviewAssignment", "Resources")%>;
	   <% 'WAF3_PB_42 April 10, 2007 START 
	  'Removed local functions for window onload and resize 
	  'WAF3_PB_42 April 10, 2007 END%>
	function Paging_OnClick(strAlphabet)
	{
		var objTxt,i;
		var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
		for(i=0;i< objSelectedUserList.options.length;i++)
			objSelectedUserList.options[i].selected=true;	
		
		objTxt = GetObjectReference('frmQuerySharing','hdAlphabet');
		objTxt.value = URLEncode(strAlphabet);//Modified By Shrikant IssueID 20608
		//Issue ID	:	WAF3_QB_IssueFixes 1
		objform.action="QRB_QuerySharing.aspx?Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&MasterTagID=<%=m_strMasterTagID%>&ParentSortOrder=<%=m_strParentSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strParentAlphabet%>&Tab=<%=m_strTab%>";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		objform.submit();  		
	}
	
	function Filter_OnChange()
	{
		var i;
		var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
		for(i=0;i< objSelectedUserList.options.length;i++)
			objSelectedUserList.options[i].selected=true;	
		//Issue ID	:	WAF3_QB_IssueFixes 1
		objform.action="QRB_QuerySharing.aspx?Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&MasterTagID=<%=m_strMasterTagID%>&ParentSortOrder=<%=m_strParentSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strParentAlphabet%>&Tab=<%=m_strTab%>";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		objform.submit();
	}
	
	function Show_OnClick()
	{
		var objTxt,i;
		var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
			
	
		objTxt = GetObjectReference('frmQuerySharing','txtName');
		if(objTxt.value != '' && objTxt.value != null)
		{
			//modified May 23,05 RajK #BI_72 Issue ID#18878
			//for(i=0;i< objSelectedUserList.options.length;i++)
			for(i=0;i< objSelectedUserList.length;i++)
			objSelectedUserList.options[i].selected=true;
			//end modification May 23,05 RajK #BI_72 Issue ID#18878
			//Issue ID	:	WAF3_QB_IssueFixes 1
			objform.action="QRB_QuerySharing.aspx?Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&MasterTagID=<%=m_strMasterTagID%>&ParentSortOrder=<%=m_strParentSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strParentAlphabet%>&Tab=<%=m_strTab%>";
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
		var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
		
		//modified May 23,05 RajK #BI_72 Issue ID#18878
		for(i=0;i< objSelectedUserList.length;i++)
			objSelectedUserList.options[i].selected=true;	
		//end modification May 23,05 RajK #BI_72 Issue ID#18878
		
		objTxt = GetObjectReference('frmQuerySharing','txtName');
		/*if(objTxt.value != '' && objTxt.value != null)
		{*/
			objTxt.value="";
			objTxt=null;
			objTxt = GetObjectReference('frmQuerySharing','hdAlphabet');
			objTxt.value = "-1";
			objTxt=null;
		//Issue ID	:	WAF3_QB_IssueFixes 1
			objform.action="QRB_QuerySharing.aspx?Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&MasterTagID=<%=m_strMasterTagID%>&ParentSortOrder=<%=m_strParentSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strParentAlphabet%>&Tab=<%=m_strTab%>";
			blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
			objform.submit();		
		//}
	}
	
	function AddAll_OnClick()
		{
			var objUserList = GetObjectReference('frmQuerySharing','lstUserList'); 
			
			var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
			
			//modified May 23,05 RajK #BI_72	 Issue ID#18878		
			var Count = objUserList.length;
			//end modification May 23,05 RajK #BI_72 Issue ID#18878
			
			if (objUserList.length > 0) 
			{	var intCounter;
				for (intCounter = 0;intCounter < Count;)
				{
					var objOption = document.createElement("OPTION");				
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					//objSelectedUserList.options.add(objOption);
					//if (navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
					    //objSelectedUserList.options.add(objOption);  Commented & added by vaijat k on 26-11-2015
					    document.getElementById("lstSelectedUser").appendChild(objOption);
					else
						objSelectedUserList.add(objOption,null);
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
										
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					objOption.text = objUserList.options[intCounter].text;	
					objOption.value = objUserList.options[intCounter].value;	
					
					//objUserList.options.remove(intCounter);
					//Count=objUserList.options.length;
					if(navigator.appName == 'Microsoft Internet Explorer')
						{
						objUserList.options.remove(intCounter);
						Count=objUserList.options.length;
						}
					else
						{
						objUserList.remove(intCounter);
						Count = objUserList.length;
						}
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
					
								
					objSelectedUserList.focus();
					txtModified.value = 'yes';
				}
			}	
		}
			
		function Add_OnClick()
		{
			var objUserList = GetObjectReference('frmQuerySharing','lstUserList'); 
			
			var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
						
			var intCounter;
			//modified May 23,05 RajK #BI_72 Issue ID#18878
			//for(intCounter=0;intCounter < objUserList.options.length;)
			for(intCounter=0;intCounter < objUserList.length;)
			//end modification May 23,05 RajK #BI_72 Issue ID#18878
			{
				if(objUserList.options[intCounter].selected==true)
				{
					var objOption = document.createElement("OPTION");

					//modified May 23,05 RajK #BI_72 Issue ID#18878
					//objSelectedUserList.options.add(objOption);
					//if(navigator.appName == 'Microsoft Internet Explorer')
					//    objSelectedUserList.options.add(objOption);
					if (WhichBrowser() == 'IE')
					    //objSelectedUserList.options.add(objOption);  Commented & added by vaijat k on 26-11-2015
					    document.getElementById("lstSelectedUser").appendChild(objOption);
					else
						objSelectedUserList.add(objOption,null);	
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
										
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					objOption.text = objUserList.options[intCounter].text;	
					objOption.value = objUserList.options[intCounter].value;	
					//objUserList.options.remove(intCounter)
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						objUserList.options.remove(intCounter);
					else
						objUserList.remove(intCounter);
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
					txtModified.value = 'yes';
				}
				else
				{
				intCounter++;
				}
			}
		}
					
		function Remove_OnClick()
		{
		
			var objUserList = GetObjectReference('frmQuerySharing','lstUserList'); 
			
			var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
						
			var intCounter;
			//modified May 23,05 RajK #BI_72 Issue ID#18878
			//for(intCounter=0;intCounter<objSelectedUserList.options.length;)
			for(intCounter=0;intCounter<objSelectedUserList.length;)
			//end modification May 23,05 RajK #BI_72 Issue ID#18878
			
			{
				if(objSelectedUserList.options[intCounter].selected==true)
				{
					var objOption = document.createElement("OPTION");
					
					
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					//objUserList.options.add(objOption);
				    //if(navigator.appName == 'Microsoft Internet Explorer')
                    if(WhichBrowser()=="IE")
                        //objUserList.options.add(objOption);       Commented & added by vaijat k on 26-11-2015
                        document.getElementById("lstUserList").appendChild(objOption);
					else
						objUserList.add(objOption,null);
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
					
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					objOption.text=objSelectedUserList.options[intCounter].text;
					objOption.value=objSelectedUserList.options[intCounter].value;
			
					//objSelectedUserList.options.remove(intCounter)
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
						objSelectedUserList.options.remove(intCounter);
					else
						objSelectedUserList.remove(intCounter);
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
				}
				else
				{
					intCounter++;
				}
			}	 
		}


		function RemoveAll_OnClick()
		{
			
			var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
			
			var objUserList = GetObjectReference('frmQuerySharing','lstUserList')
			
			//modified May 23,05 RajK #BI_72 Issue ID#18878
			//var Count = objSelectedUserList.options.length
			var Count = objSelectedUserList.length;
			//end modification May 23,05 RajK #BI_72	 Issue ID#18878							
			
			
			if (objSelectedUserList.length>0) 
			{	var intCounter;
				for (intCounter=0;intCounter< Count; )
				{
					var objOption = document.createElement("OPTION");				
			
					//modified May 23,05 RajK #BI_72	 Issue ID#18878								
					//objUserList.options.add(objOption);
				    //if(navigator.appName == 'Microsoft Internet Explorer')
					if (WhichBrowser() == 'IE')
					    //objUserList.options.add(objOption);     Commented & added by vaijat k on 26-11-2015
					    document.getElementById("lstUserList").appendChild(objOption);
					else
						objUserList.add(objOption,null);					
					//end modification May 23,05 RajK #BI_72 Issue ID#18878v
											
					//modified May 23,05 RajK #BI_72 Issue ID#18878
					objOption.text = objSelectedUserList.options[intCounter].text;	
					objOption.value = objSelectedUserList.options[intCounter].value;	
					
					//objSelectedUserList.options.remove(intCounter)
					//Count = objSelectedUserList.options.length
					//if (navigator.appName == 'Microsoft Internet Explorer')
					if(WhichBrowser() == 'IE')
						{
						objSelectedUserList.options.remove(intCounter);
						Count = objSelectedUserList.options.length;
						}
					else
						{
						objSelectedUserList.remove(intCounter);
						Count = objSelectedUserList.length;
						}
					//end modification May 23,05 RajK #BI_72 Issue ID#18878
					
					objUserList.focus();
				}
			}	
		}
		
		function Save_OnClick()
		{
			var i,count,ans;
			var call=false;
			
			var objSelectedUserList = GetObjectReference('frmQuerySharing','lstSelectedUser'); 
			
			//modified May 23,05 RajK #BI_72  Issue ID#18878
			//count = objSelectedUserList.options.length;
			if(navigator.appName == 'Microsoft Internet Explorer')
				count = objSelectedUserList.options.length;
			else
				count = objSelectedUserList.length;
			//end modification May 23,05 RajK #BI_72 Issue ID#18878
			
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
					//modified May 23,05 RajK #BI_72	 Issue ID#18878
					objSelectedUserList.options[i].selected=true;
					//end modification May 23,05 RajK #BI_72	 Issue ID#18878
				//Issue ID	:	WAF3_QB_IssueFixes 1	
				objform.action="QRB_QuerySharing.aspx?Mode=<%=m_strMode%>&QueryID=<%=m_lngQueryID%>&Action=SAVE&MasterTagID=<%=m_strMasterTagID%>&ParentSortOrder=<%=m_strParentSortOrder%>&SortBy=<%=m_strSortBy%>&ParentAlphabet=<%=m_strParentAlphabet%>&Tab=<%=m_strTab%>";
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
</HTML>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>

<script type="text/javascript">

$(document).ready(function(){
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

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:16/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
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

});
</script>
