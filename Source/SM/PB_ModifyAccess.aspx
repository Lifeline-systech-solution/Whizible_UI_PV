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
    $(document).ready(function(){

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:12/02/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
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
        // When:12/02/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:12/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });

</script>

<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_ModifyAccess.aspx.vb" Inherits="Whiz.PB_ModifyAccess" %>
<!DOCTYPE HTML>
<html>
	<% CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>

<body class="clsBody" onresize="window_onload_resize()" onload="window_onload_resize()">
<style type="text/css">
body
{
    overflow-y: auto;
}
</style>
    
    <script type="text/javascript" language="javascript">
            function window_onload_resize()
	        {   var intHeight=0;
	            var objDivMain = GetObjectReference('frmModifyAccess','divMain');
	            var objDivInner = GetObjectReference('frmModifyAccess','divInner');
	            var intRiskFactor=<%=m_intHightRiskFactor%>; 
	            if(objDivMain)
	            {if (navigator.appName.toUpperCase =  'MICROSOFT INTERNET EXPLORER')
	             {intHeight = document.body.offsetHeight - objDivMain.offsetTop - intRiskFactor;}
	             else{intHeight= window.innerHeight - objDivMain.offsetTop -intRiskFactor;}
	             if (intHeight<100){intHeight=100;}
	             objDivMain.style.height = intHeight;
	             if(objDivInner)
	             {  
	                intHeight=intHeight-objDivInner.offsetTop - 5;
	                if (intHeight<95){intHeight=95;}
	                objDivInner.style.height = intHeight;
	              }	             
	            }
	        }     
	        function Close_OnClick(){window.close();}
	        function Access_OnClick(intIndex)
	       {
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess;
				
				objChkAccess = GetObjectReference('frmModifyAccess','chkAccess',true);
				objChkAdd = GetObjectReference('frmModifyAccess','chkAdd',true);
				objChkEdit = GetObjectReference('frmModifyAccess','chkEdit',true);
				objChkDel = GetObjectReference('frmModifyAccess','chkDelete',true);
				objChkView = GetObjectReference('frmModifyAccess','chkView',true);
								
				objChkAdd[intIndex].disabled = !objChkAccess[intIndex].checked;
				objChkEdit[intIndex].disabled = !objChkAccess[intIndex].checked;
				objChkDel[intIndex].disabled = !objChkAccess[intIndex].checked;
				objChkView[intIndex].disabled = !objChkAccess[intIndex].checked;
				
				objChkAdd[intIndex].checked = objChkAccess[intIndex].checked;
				objChkEdit[intIndex].checked = objChkAccess[intIndex].checked;
				objChkDel[intIndex].checked = objChkAccess[intIndex].checked;
				objChkView[intIndex].checked = objChkAccess[intIndex].checked;
			}
			function SelectAll_OnClick()
			{
				var objRowCount;
				var count,indx;
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess,objChkAccessInherit;
				
				objRowCount = GetObjectReference('frmModifyAccess','hdRowCount');
				count = objRowCount.value;
				
				if(count > 0)
				{
										
				    objChkAccess = GetObjectReference('frmRoleAccess','chkAccess',true);
					objChkAccessInherit = GetObjectReference('frmRoleAccess','chkAccessInherit',true);
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd',true);
					objChkEdit = GetObjectReference('frmRoleAccess','chkEdit',true);
					objChkDel = GetObjectReference('frmRoleAccess','chkDelete',true);
					objChkView = GetObjectReference('frmRoleAccess','chkView',true);
					
				    //for(indx=0;indx<count;indx++)     // COMMENTED & ADDED BY PUNEET M ON 27-11-2015
					for(indx=0; indx < objChkAccess.length; indx++)
					{
					    if(objChkAccess) {if(objChkAccess[indx]){objChkAccess[indx].checked = true;}}
					    if (objChkAccessInherit) {if(objChkAccessInherit[indx]){objChkAccessInherit[indx].checked = true;}}
							
					    objChkAdd[indx].disabled = false;
					    objChkEdit[indx].disabled = false;
					    objChkDel[indx].disabled = false;
					    objChkView[indx].disabled = false;
										
					    objChkAdd[indx].checked = true;
					    objChkEdit[indx].checked = true;
					    objChkDel[indx].checked = true;
					    objChkView[indx].checked = true;
					}
				}
			}
            function ClearAll_OnClick()
			{
				var objRowCount;
				var count,indx;
				var objChkAdd,objChkEdit,objChkDel,objChkView;
				var objChkAccess,objChkAccessInherit;
				var blnAccessChkExists=false;
				objRowCount = GetObjectReference('frmModifyAccess','hdRowCount');
				count = objRowCount.value;
				
				if(count > 0)
				{
										
					objChkAccess = GetObjectReference('frmRoleAccess','chkAccess',true);
					objChkAccessInherit = GetObjectReference('frmRoleAccess','chkAccessInherit',true);
					objChkAdd = GetObjectReference('frmRoleAccess','chkAdd',true);
					objChkEdit = GetObjectReference('frmRoleAccess','chkEdit',true);
					objChkDel = GetObjectReference('frmRoleAccess','chkDelete',true);
					objChkView = GetObjectReference('frmRoleAccess','chkView',true);
				
				    //for(indx=0;indx<count;indx++)     // COMMENTED & ADDED BY PUNEET M ON 27-11-2015
					for(indx=0; indx < objChkAccess.length; indx++)
					{
					    blnAccessChkExists = false;
                        if(objChkAccess) {if(objChkAccess[indx]){blnAccessChkExists=true; objChkAccess[indx].checked = false;}}
						if (objChkAccessInherit) {if(objChkAccessInherit[indx]){objChkAccessInherit[indx].checked = false;}}
						objChkAdd[indx].disabled = blnAccessChkExists;
						objChkEdit[indx].disabled = blnAccessChkExists;
						objChkDel[indx].disabled = blnAccessChkExists;
						objChkView[indx].disabled = blnAccessChkExists;
										
						objChkAdd[indx].checked = false;
						objChkEdit[indx].checked = false;
						objChkDel[indx].checked = false;
						objChkView[indx].checked = false;
					}
				}
			}
			function Save_OnClick()
			{
			    var objFrm =  GetFormReference('frmModifyAccess');
			    objFrm.action = '<%=m_strCommonHref%>' + '&Action=SAVE';
			    objFrm.submit();
			}
			function ApplyFilter(ev,obj)
			{
			    if(ev){if(ev.keyCode==13)
			    {   var objFrm,objFilterText;
			        objFilterText = GetObjectReference('frmRoleAccess','hdFilterText');
			        if(obj)
			        {   objFilterText.value=obj.value;
			            objFrm = GetFormReference('frmModifyAccess');
			            objFrm.action = '<%=m_strCommonHref%>'// + '&Action=SAVE'; Commented By Vaijat K ON 20/11/2015
			            objFrm.submit();
			         }
                }}
			}
			function FilterAlphabet_OnClick(chAlphabet)
			{
			    var objFrm,objFilterAlphabet;
		        objFilterAlphabet = GetObjectReference('frmRoleAccess','hdFilterAlphabet');
		        objFilterAlphabet.value=chAlphabet;
		        objFrm =  GetFormReference('frmModifyAccess');
		        objFrm.action = '<%=m_strCommonHref%>'// + '&Action=SAVE'; Commented By Vaijat K ON 20/11/2015
		        objFrm.submit();
			}
    </script>
    <form id="frmModifyAccess" name="frmModifyAccess" method="post" runat="server">
        <%WritePage()%>
    </form>
</body>
</html>


