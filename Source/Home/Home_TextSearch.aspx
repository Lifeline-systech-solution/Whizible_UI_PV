<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Home_TextSearch.aspx.vb" Inherits="PbNIT.Home_TextSearch" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<%  CommonFunctions.General.PlotPageHeadTag("Home Text Search")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<body id='tab1' class='clsPopUpBody'  onresize="window_onresize()" onload="window_onload()">
    <form id="Home_TextSearch" method="post"  runat="server"  >
    <%PageInit()%>
    </form>
    <script language=javascript>
    var objForm;
	var objdivlist;
	
	objForm = GetFormReference('Home_TextSearch');
	objdivlist = GetObjectReference('Home_TextSearch','divPage');
	
    
    function window_onload()
	{
		var intDivHeight ;
			
	    if(objdivlist != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objdivlist.offsetTop - 15;
				}
				else
				{   
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 15;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight + 'px';
			}
			
		
	}
	
	function window_onresize()		
	{
		var intDivHeight;
				
		if(objdivlist)
		{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 20;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';
		}
		
	}
    
    function Close_Click()
    {
        //window.close();
        // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.style.display='none';
            document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.src = "";
        //Ended
    }

    function OK_OnClik()
    {
        var objTextSearch;
        var objChkIssue;
        var objChkTask;
        var objChkMilestone;
        var objChkDeliverable;
        var objChkModule;
        var objFlag = 0;
        var objConCheckbox = '';
        
        objTextSearch = GetObjectReference('Home_TextSearch','txtSearch');
        /*
        if(trimString(objTextSearch.value)=='')
        {
            alert("Please enter text which is to be searched");
            return;
        } */
        
        objChkIssue = GetObjectReference('Home_TextSearch','chkIssue');
        objChkTask = GetObjectReference('Home_TextSearch','chkTask');
        objChkMilestone = GetObjectReference('Home_TextSearch','chkMilestone');
        objChkDeliverable = GetObjectReference('Home_TextSearch','chkDeliverable');
        objChkModule = GetObjectReference('Home_TextSearch','chkModule');
        
        if(objChkIssue.checked==true)   
        {
            objConCheckbox = objConCheckbox + 'I' + "," ;
            objFlag = 1;
        }
        
        if(objChkTask.checked==true)   
        {
            objConCheckbox = objConCheckbox + 'T' + ",";
            objFlag = 1;
        }
        
        if(objChkMilestone.checked==true)   
        {
            objConCheckbox = objConCheckbox + 'M' + ",";
            objFlag = 1;
        }
  
        if(objChkDeliverable.checked==true)   
        {
            objConCheckbox = objConCheckbox + 'D' + ",";
            objFlag = 1;
        }
        
        if(objChkModule.checked==true)   
        {
            objConCheckbox = objConCheckbox + 'MO' + ",";
            objFlag = 1;
        }
       
        if (objFlag==0)
        {
            alert("Please select atleast one checkbox");
            return;
        }
        
        objText = URLEncode(replaceSubstring(trimString("<%=m_strSearch%>"), "'", "|"));
        // Modifed by swapnil aswale on 8-12-2015 for Browser Compatibilty issue
        //window.open("../Home/Home_TextSearch.aspx?FromWhere=Home&Mode=2&TextSearch="+ trimString(objTextSearch.value) + "&Parameter="+ objConCheckbox +"", "", "resizable=yes,scrollbars=auto,left=" + ((window.screen.width - 750)/2) + ",top=" + ((window.screen.height -700)/2) + ",height=650,width=900");
        document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.style.display='none';
        document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].parent(1).frameElement.src="";
        document.forms(0).parentElement.parentElement.ownerDocument.parentWindow.frames.parent.frames[0].location.href="../Home/Home_TextSearch.aspx?FromWhere=Home&Mode=2&TextSearch="+ objText + "&Parameter="+ objConCheckbox; 
        //Ended
    }
    
    function SummaryDetails(intIssueID)
    {
        var objDiv = GetObjectReference('','Summary'+intIssueID);
        var objImg = GetObjectReference('','imgSummaryShowHide'+intIssueID);
        var objTR = GetObjectReference('','Description'+intIssueID);
		    
        var IsCollapse = objImg.getAttribute("Collapse");
        if(IsCollapse=="Y")
        {   
            objImg.src='../../Images/plus.gif';
            objTR.style.display='none';
            objDiv.style.display='none';
            objImg.setAttribute("Collapse","N");
        }
        else if(IsCollapse=="N")
        {   
            objImg.src='../../Images/minus.gif';
            objTR.style.display=''; 
            objDiv.style.display='';
            objImg.setAttribute("Collapse","Y");
        }
    }
    
    function txtPageNumber_KeyPress(e,intWhichPage)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);
				var objtxtNoOfPages = GetObjectReference('Home_TextSearch','txtNoOfPages'+intWhichPage);
								
				//if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				if (!disallowBlank(objtxtpageNumber,"Please Enter Page Number.",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number must be Numeric.",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page number must be Positive.",true)) & (!disallowNonInteger(objtxtpageNumber,"Page number must be Integer.",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Page number is not valid.");
						return;
					}
					Page_OnClick(objtxtpageNumber.value,intWhichPage);
				}
			}
		
		}
		function Page_OnClick(page,intWhichPage)
		{
				objForm.action = "Home_TextSearch.aspx?TextSearch=<%=m_strSearch %>&Mode=2&Parameter=<%=m_strParameter %>&WhichPage="+intWhichPage+"&PageNumber=" +page ;  
				objForm.submit();
		}
		

function validateNumPaging(intWhichPage)
{
			
	var noOfPages = GetObjectReference('Home_TextSearch','hidNoOfPages'+intWhichPage).value;
	var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);		
	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage(intWhichPage)
{
    
    var noOfPages = GetObjectReference('Home_TextSearch','hidNoOfPages'+intWhichPage).value;
	var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1,intWhichPage);
	else
	{
		if(!validateNumPaging(intWhichPage))
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_OnClick(objtxtpageNumber.value,intWhichPage);
	}
		
}
function ShowFirstPage(intWhichPage)
{
    
    var noOfPages = GetObjectReference('Home_TextSearch','hidNoOfPages'+intWhichPage).value;
	var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1,intWhichPage);
	else
	{
		if(!validateNumPaging(intWhichPage))
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_OnClick(objtxtpageNumber.value,intWhichPage);
	}
}
function ShowNextPage(intWhichPage)
{
    
	var noOfPages = GetObjectReference('Home_TextSearch','hidNoOfPages'+intWhichPage).value;
	var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);
	
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1,intWhichPage);
	else
	{
		if(!validateNumPaging(intWhichPage))
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		Page_OnClick(objtxtpageNumber.value,intWhichPage);
	}
}
function ShowLastPage(intWhichPage)
{
    
	var noOfPages = GetObjectReference('Home_TextSearch','hidNoOfPages'+intWhichPage).value;
	var objtxtpageNumber =  GetObjectReference('Home_TextSearch','txtPageNumber'+intWhichPage);
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(noOfPages,intWhichPage);
	else
	{	
		if(!validateNumPaging(intWhichPage))
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_OnClick(objtxtpageNumber.value,intWhichPage);
	}
}
				
		
    </script>
</body>
</html>
