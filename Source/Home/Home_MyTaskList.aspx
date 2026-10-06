<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Home_MyTaskList.aspx.vb" Inherits="PbNIT.Home_MyTaskList"%>
<html>
<%PlotHeadTag()%>
  <body MS_POSITIONING="clsFullPageBody" class="clsBody" onresize="window_onResize()"  onload="window_onLoad()" >
    <form id="frmMyTaskList" method="post" runat="server">
    <%Page_Init()%>
    <INPUT type="hidden" name="txtContentTab" id="txtContentTab" runat="server">
    </form>
    <script language="javascript">
    var objform = GetFormReference('frmMyTaskList');
    var objContentTab=GetObjectReference('frmMyTaskList','txtContentTab');
     var objdivlist=GetObjectReference('frmMyTaskList','divList');
     
     
     function window_onLoad()
    {
    
        var intDivHeight ;
		var intDivHeightRisk;
		
		if(objdivlist)
		{
			if (navigator.appName == 'Microsoft Internet Explorer'){
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
			}
			else{
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 10;
			}
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';
		}
	}	
	
	function window_onResize()
{

    var intDivHeight ;
    var intDivHeightRisk;
    if (navigator.appName == 'Microsoft Internet Explorer'){
    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 10;
    }
    else{
    intDivHeight = window.innerHeight - 10;
    }
    if (intDivHeight < 100)
	    intDivHeight = 100;


}
    function ContentTab(TabName)
		{	objContentTab.value = TabName;
			objform.action = "Home_MyTaskList.aspx";
			objform.submit();
		}
	function Back_OnClick()
		{
			window.location.href ="HRHome.aspx?Fromwhere=HOME";
		}
		function MyTaskList_Click()
{
	window.location.href = "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
}
function Approval_Click()
{
	window.location.href = "../Home/Home_Approvals.aspx?FromWhere=HOME";
}

function LastUpdated_Click()
{
//window.location.href = url+"&From_Where=HRHome";
}
 function Search_OnKeyPress(e)
{
		var code;
       if (e.keyCode) code = e.keyCode;
	    else if (e.which) code = e.which;
	    if(code==13) {
		objfrm.action = "../Home/HRHome.aspx";
		objfrm.submit(); 
		}

}

 function Search_OnClick()
    {
            //var objReminderDiv=GetObjectReference('','MyreminderDiv');
            //if(objReminderDiv.style.display=='')
                GetObjectReference('','DisplayDiv').value="1";
            //else
                //GetObjectReference('','DisplayDiv').value="2";
        
        objform.submit();
    }
    function Filter_OnClick()
    {
        objdivFilters=GetObjectReference('frmMyTaskList','divFilters');
        if(objdivFilters.style.display == '')
        {
            objdivFilters.style.display='none';
        }
        else
        {
        objdivFilters.style.display='';
        objdivFilters.style.left =700;
	    objdivFilters.style.top =20;
	    objdivFilters.style.position ='absolute';
        }
    }
    function applyFilter(intFlag)
    {
   		var objcboproject=GetObjectReference('frmMyTaskList','cboProject');
		//var objcboTaskTypeFilter=GetObjectReference('frmMyTaskList','cboType');

  	     if(parseInt(intFlag)==1)
	     {
			objcboproject.value='';
			//objcboTaskTypeFilter.value='';
	     }
		    objform.action = "../Home/Home_MyTaskList.aspx?FromWhere=HOME";
			objform.submit();
    }
    function ExpandCollapse_OnClick(group,IsExpanded)
	{
		
	}
    </script>
  </body>
</html>
