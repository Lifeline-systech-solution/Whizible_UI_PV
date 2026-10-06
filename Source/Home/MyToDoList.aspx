<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MyToDoList.aspx.vb" Inherits="PbNIT.MyToDoList" %>
<html >
<%  CommonFunctions.General.PlotPageHeadTag("My To Do List")%>
<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
<body class="clsBody" onload="window_onload()" onresize="window_onresize()" >
     <form id="frmMyToDoList" name="frmMyToDoList"  runat="server">
             <% WritePage()%>
    </form>
    
     <script language="javascript" type="text/javascript">
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
         var objfrm               = GetFormReference("frmMyToDoList"); 
         var objDivMain          = GetObjectReference("frmMyToDoList","DivMain"); 
        	    

	    
        function window_onload()
        {
            if(objDivMain!=null){ 

			var intDivHeight ;
			intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';	
            
            }
          
        }
        function window_onresize()
        {
			var intDivHeight;
            if(objDivMain!=null){ 
			intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';
			}       
        }
        
        function FlagSet(intProjectID,intContextid,intEmployeeid,strContexttype,strEntityName)
        {  
            window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intContextid + "&EmployeeID=" + intEmployeeid + "&ContextType="+ strContexttype +"&FromWhich=FlagTrack&ContextName=" + strEntityName ,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" ); 
        }  
        function openHelpDeskReq(id,pkToken)
        {
            window.open ("../CRM/CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=MD&QueryID="+id+"&PKToken="+pkToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=380");
        }
        function openTaskReq(intProjectID,intTaskID)
        {
            window.open ("../PM/PM_DailyActivity.aspx?FromWhere=ATS&WhatToShow=Entry&ShowClose=1&ProjectID="+intProjectID+"&TaskID="+intTaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=700,height=380");
        }
        
        
        function Duration_OnChange()
        {
            objfrm.action = "../Home/MyToDoList.aspx?FromWhere=HOME"
            objfrm.submit();
        }
        function EntityFilter(EntityType)
        {
            objfrm.action = "../Home/MyToDoList.aspx?FromWhere=HOME&EntityType="+EntityType;
            objfrm.submit();
        
        }
        </script>
        
</body>
</html>
