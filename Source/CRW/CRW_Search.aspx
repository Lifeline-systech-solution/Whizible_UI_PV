<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_Search.aspx.vb" Inherits="Whiz.CRW_Search" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
       
		<form id="frmSearchPage" method="post" name="frmSearchPage" runat="server">
			<%PageInit%>
            	 
		</form>
		<script language="javascript">
			function Search_OnClick()
			{
				var objfrm;
				var objTextSearch;
				document.forms[0].txtCheckVal.value = "Search";     // Modified by puneet m on 23-12-2015
				objfrm = GetFormReference('frmSearchPage');
				
				objTextSearch = GetObjectReference('frmSearchPage','txtSearch');
				
				if(objTextSearch.value!='')
				{
					objfrm.action = "CRW_Search.aspx?strToBeSearched=" + objTextSearch.value ;
					objfrm.submit(); 
				}
				 
			}
			
			function USP_OnClick(strSPName)
			{
               
				var objCheckVal;
				var objCreateReport;
				var objSPName;
				
				objSPName = GetObjectReference('frmSearchPage','txtTextBoxName');
				objCreateReport = GetObjectReference('frmSearchPage','txtFormName');
				objCheckVal = GetObjectReference('frmSearchPage','txtCheckVal');
				
				objCheckVal.value = "GotText";
            
				
                //Modified by swapnil aswale on 3rd Nov 2015 for Browser compatiblity 
			    //window.opener.document.forms(objCreateReport.value).item(objSPName.value).value = strSPName									
				var obj = GetObjectReference(window.opener.document.forms[objCreateReport.value], 'txtTextBoxName');
				window.opener.document.getElementById(objSPName.value).value = strSPName
				 
				window.close();
			}
			
			function Clear_OnClick()
			{
				var objSearch;
				objSearch = GetObjectReference('frmSearchPage','txtSearch');
				objSearch.value="";
				objfrm.action = "CRW_Search.aspx?strToBeSearched=";
				objfrm.submit(); 
			}
          
			
		var objdivlist;
		var objfrm;
		objfrm = GetFormReference('frmSearchPage')
		objdivlist = GetObjectReference('frmSearchPage', 'DivSearchPage')
		
	
		    <% 'WAF3_PB_42 April 10, 2007 removed window_onload and window_onresize functions  %>
            //Added By Vidya J ON 27-01-2016 
		    function window_onload() {
		        
		        var intDivHeight;
		      
		        document.getElementById('DivSearchPage').style.overflow = 'hidden';
		         
		        
		        if (objdivlist != null) {

		             if (WhichBrowser() == 'IE') {
		               
		                intDivHeight = window.innerHeight - objdivlist.offsetTop   ;
		                 
		            }
		             else  
		                 if (WhichBrowser() == 'CR') {
		                     intDivHeight = window.innerHeight - objdivlist.offsetTop;
		                      
		                 }
		                 else
		                     if (WhichBrowser() == 'FF')
		                     {

		                         intDivHeight = window.innerHeight - objdivlist.offsetTop;
                            }

		            if (intDivHeight < 100)
		                intDivHeight = 100;
		          
		            objdivlist.style.height = intDivHeight + 'px';
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

		    //End Of Added By Vidya J ON 27-01-2016
		</script>
	</body>
</HTML>
