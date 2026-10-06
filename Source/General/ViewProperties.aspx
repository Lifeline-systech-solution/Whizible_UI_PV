<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ViewProperties.aspx.vb" Inherits="Whiz.ViewProperties" %>
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>


<style>    .clsTRBody {
   font-size:12px !important;
    }
</style>
<%--End of addition by Yogesh J on 02-Nov-2015--%>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frm_ViewProperties" name="frm_ViewProperties" method="post">
				<%PageInit()%>
		</form>
		<script language="javascript">
		var objdivlist;
		var objform;
		objform=GetFormReference('frm_ViewProperties');
		objdivlist=GetObjectReference('frm_ViewProperties','DivList');
		setFocus(GetObjectReference("frm_ViewProperties","txtViewName"));
		function window_onload()		
		{
		  
		    var browser = WhichBrowser();
			var intDivHeight ;
			var intDivHeightRisk;
			if (browser == 'CR') {
                //Commented by Yogesh J on 18-Nov-2015
			    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop -29;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46
			}
			else {
			   // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 80;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46
			    //End of comment by Yogesh J  on 18-Nov-2015
			}
			if (intDivHeight < 100)
			intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px'	;			
		}
	
		function window_onresize()		
		{
		    var browser = WhichBrowser();
			var intDivHeight ;
			var intDivHeightRisk;
            //Commented and added by Yogesh J on 18-Nov-2015
		    //	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 40;
			if (browser == 'CR') {
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46
			}
			else {
			  
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 46
			}
		    //End of Comment by Yogesh J  on 18-Nov-2015
	
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
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
	
		function Save_OnClick(Count,ApplyView,TagID,MasterTagID)
		{	
		    if (!Validate(Count)) { return; }
		    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			objform.action="ViewProperties.aspx?Operation=SAVE&Apply=" + ApplyView + "&TagID=" + TagID + "&MasterTagID=" + MasterTagID+"<%=m_Parent_CommonQueryString%>";
			objform.submit(); 
		}
 
		function Validate(Count)
		{
			if (disallowBlank(GetObjectReference("frm_ViewProperties","txtViewName"),'<%=MyBase.GetResourceString("VALIDATION_MSG_VIEW_NAME_BLANK")%>',true) )
				{ return false;}
			var arrView=new Array(<%=m_strArrayViewNames%>)
			if (disallowDuplicates(GetObjectReference("frm_ViewProperties","txtViewName"),arrView,'<%=MyBase.GetResourceString("VALIDATION_MSG_VIEW_DUPLICATE")%>',true,false))
				{ return false; }
			var Columns =",";
			objColumn = GetObjectReference("frm_ViewProperties","cboColumn",true);
			for(var i=0; i < Count ; i++ )
			{		
				if(Count==1)
					sColumn = objColumn.value;
				else
					sColumn = objColumn[i].value;
				if (!isBlank(sColumn)) 
				{
					if(isSubstringExists(Columns,"," + sColumn + ",")) 
					{ 
						alert('<%=MyBase.GetResourceString("VALIDATION_MSG_DUPLICATE_COLUMN")%>'); 
						setFocus(objColumn[i]);
						return false; 
					} 
					else
						{ Columns = Columns + sColumn + ","; }
				}
			}
			if(Columns==",") 
			{
				alert('<%=MyBase.GetResourceString("VALIDATION_MSG_COLUMN_NOT_SELECTED")%>'); setFocus(objColumn); 
				return false;
			 } 
			return true;
	}
	
	function Back_OnClick(MasterTagID,TagID) 
	{ 
		window.location.href = "ViewProperties_CommonList.aspx?MasterTagID=" + MasterTagID + "&TagID=" + TagID+"<%=m_Parent_CommonQueryString%>"
	}
 
		</script>
	</body>
</HTML>
