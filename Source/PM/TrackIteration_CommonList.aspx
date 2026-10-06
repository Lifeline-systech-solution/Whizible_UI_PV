<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TrackIteration_CommonList.aspx.vb" Inherits="PbNIT.TrackIteration_CommonList" %>

<script language="javascript">
function ShowDescription_onClick(IterationID)
{
     
    var i=1;
    var objTD = GetObjectReference('',IterationID);
    var objDiv = GetObjectReference('','Summary'+IterationID);
    var objImg = GetObjectReference('','imgSummaryShowHide'+IterationID);
              
     
    var IsCollapse = objImg.getAttribute("Collapse");    
    
    
  if(navigator.appName != 'Netscape')
  { 
        if(IsCollapse=="Y")
        {
            //alert('Y');
                objTD.style.borderBottom = '1px solid gray';
                while(i<objTD.parentNode.children.length)
                {
                    objTD.nextSibling.style.borderBottom = '1px solid gray';    
                    //objTD.style.borderBottom = '0px solid gray';    
                    objTD = objTD.nextSibling;
                    i=i+1;
                }
                //objImg.setAttribute("Collapse","N");
                 
               
        }
        else
        { 
            objTD.style.borderBottom = '0px solid gray';         
            
            while(i<objTD.parentNode.children.length)
            {  
                objTD.nextSibling.style.borderBottom = '0px solid gray';    
                //objTD.style.borderBottom = '0px solid gray';    
                objTD = objTD.nextSibling;
                i=i+1;
            }
            
        }
   }
    //objTD.parentNode.style.borderBottom = '';
    
    
        var objTR = GetObjectReference('frmCommonList','Description'+IterationID);
        
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

function Name_OnClick(ID,Flag)
{
    
	    //debugger;
	    if (Flag == "STORY")
	    {
	        window.open("../PM/UserStories_CommonPage.aspx?UserStoryID_PK=" + ID +"&MasterTagID=8087&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
	        
	        //../General/CommonPage.aspx?MastertagID=20121&<PARAMETERS>,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400"
	        //http://localhost/WhizibleSEM10.0/Source/General/CommonPage.aspx?ReleaseID_PK=18&PKToken=CtkJ4r9WgFYvvlNmMoZ0/w&MasterTagID=8083&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1
	    }
	    if (Flag == "ITERATION")
	    {
	        window.open("../PM/Iterations_CommonPage.aspx?IterationID_PK=" + ID +"&MasterTagID=8084&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
	    } 
			
}

</script>