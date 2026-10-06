<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_ShowReport_Helpdesk.aspx.vb" Inherits="PbNIT.CRM_ShowReport_Helpdesk" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("New Request Page")%>--%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>


<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmShowReport" method="post" runat="server">
						
									<%DrawPage()%>
								
					</form>
				<link href="../General/loaderStylesheet.css" rel="stylesheet" />
					<script language="javascript">
<!--
					    window.onload = function () {
					        RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
					    }

	var objForm = GetFormReference('frmShowReport');
	var title = "<%=m_Title%>";
	
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
	
	function Export_OnClick(sFormat)
	{
		objForm.target="_blank";
		objForm.action = "CRM_ShowReport_Helpdesk.aspx?Mode=EXPORT&Format=" + sFormat + "&Title=" + title ;
		objForm.submit();
	}

	var objdivlist = GetObjectReference('frmShowReport','divList');
	function window_onload()
	{
			//'Modified by ShraddhaM on Date 01 Jully,2006 for PMLifeLine Issue ID.4168
		var intDivHeight ;
		if (objdivlist !=null)
		{
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 105 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 105;
		    //}
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 56; //Added By Vaijat K ON 14/12/2015
			if (intDivHeight < 100)
				intDivHeight = 100;
			
			// Let the minimum height of the div tag be 100
			objdivlist.style.height = intDivHeight + 'px';		//Added By Nilesh g on 11/12/2015
		}	
	}

	function window_onresize()		
	{
	    var intDivHeight;
	    if (objdivlist != null)
	    {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			//if(navigator.appName == 'Netscape')
		    //{		  
			//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 105 ;
		    //}
		    //else
		    //{
			//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -105;
	        //}
	        intDivHeight = window.innerHeight - objdivlist.offsetTop - 56; //Added By Vaijat K ON 14/12/2015
			if (intDivHeight < 100 )
				intDivHeight = 100;	// Let the minimum height of the div tag be 100
			
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015
		}
	}
	
//-->
					</script>
				
	</body>
</HTML>
