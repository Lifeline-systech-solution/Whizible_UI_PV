<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CrossTabGridReport.aspx.vb" Inherits="PbNIT.CrossTabGridReport" %>
<%--Added by Dhanashri S on 1 Aug 2016--%>
<!DOCTYPE html>
<%--End of Addition by Dhanashri S on 1 Aug 2016--%>
<style>
   /*commented and added by Yogesh J on 04-Nov-2015*/
    #txtCurPageNumber {
        margin-top:0px !important;
        height:20px !important;
    }
    #TxtDummy {
        
        height:20px !important;
        margin-top:0px !important;
    }
    .locked{
        position:static !important;
        }
    .Locked{
        position:static !important;
        }
    /*Added By Chakshuta H on 23rd-Aug-2016 Purpose:Qa issue fixing*/
    #TblOtherView
        {
        background-color:#f6eee4 !important;
        }
    /*End of addition by Yogesh J on 04-Nov-2015*/
</style>

 <%--   Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade
  <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>

<html > 
   
<%  CommonFunctions.General.PlotPageHeadTag("Cross Tab Report") %>
<body class="clsBody" onload="window_onload()" onresize="window_onresize()"  >
    <form id="frmCrossTabGridReport" name="frmCrossTabGridReport"  runat="server" >
    <div id="fillDiv" style="filter: alpha(opacity=60);background-color:#d1d1d1;DISPLAY: none; Z-INDEX: 100; LEFT: 0px; VISIBILITY: visible; WIDTH: 100%; POSITION: absolute; TOP: 0px; HEIGHT: 100%"></div>    
    
    <div id="pleasewaitscreen" style="position:absolute;z-index:105;top:30%;left:35%;display:none;">
 <table class="clsTable" border=1 cellpadding="0" cellspacing="0" height="200" width="300">
    <tr class="clsTREven">
  <td width="100%" height="100%" align="center" valign="middle">
   <br/><br/>   
            <b>Processing...  please wait...</b>
    <br/><br/>
  </td>
 </tr>
    </table>
</div>


        <% WritePage()%>
          <%--&nbsp;--%>
         <%-- <div id="divMain1" style="width:99.99%; height:300px">--%>
     <table id="tblGraphs"  cellspacing="0" align="center" class="clsTable"  cellpadding="0" runat="server">
    
    </table>
   <%-- </div>--%>
          </form>

    
     <script language="javascript" type="text/javascript">
     function ShowWait()
     {
       
         //Commented and added By Bharat Tekade on 16th-Jun-2015
         //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
         objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
         //end of Commented and added By Bharat Tekade on 16th-Jun-2015
                 objWait.style.display="block";
                
     }
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
         var objfrm              = GetFormReference("frmCrossTabGridReport"); 
         var objDivMain          = GetObjectReference("frmCrossTabGridReport","DivMain"); 
         var objYAxis            = GetObjectReference("frmCrossTabGridReport","hdnDQYAxis"); 
         var objXAxis            = GetObjectReference("frmCrossTabGridReport","hdnDQXAxis");
         var objNoOfPages =  GetObjectReference('frmCrossTabGridReport','txtNoOfPages');
	    var objPageNumber = GetObjectReference("frmCrossTabGridReport","txtCurPageNumber"); 
	    var objDivpopup = document.getElementById("divTbl");
	    var objdivTblX = GetObjectReference("frmCrossTabGridReport","divTblX"); 
	    var objdivTblY = GetObjectReference("frmCrossTabGridReport","divTblY");
	    var objdivTblMainOtherView = GetObjectReference("frmCrossTabGridReport","divTblMainOtherView");
	    	    
	    var objdivTblXX = GetObjectReference("frmCrossTabGridReport","divTblXX"); 
	    var objdivTblYY = GetObjectReference("frmCrossTabGridReport","divTblYY"); 
	    var objTblOtherView = GetObjectReference("frmCrossTabGridReport","TblOtherView"); 
	    
	    var objTxtFYPeriod=GetObjectReference('','txtFYPeriod');
	    
        var objDivMainAdvancedFilters=GetObjectReference("frmCrossTabGridReport","divMainAdvancedFilters");
	    var objDivAdvancedFilters=GetObjectReference("frmCrossTabGridReport","divAdvancedFilters");
	    
//	    if('<%=m_strMode %>'=='Graph')
//	        objDivMain          = GetObjectReference("frmCrossTabGridReport","DivMain1"); 
	    
        function window_onload()
        {
            var browser = WhichBrowser();

            if(objDivMain!=null){ 

                var intDivHeight;
                //Added By Vaijat K On 28/11/2015
                //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
			intDivHeight = window.innerHeight - objDivMain.offsetTop - 42;
			if (intDivHeight < 100) intDivHeight = 100;
			var Mode = getParameterByName("Mode");
			
			if (Mode == "View") {
			    if (browser == 'IE') {
			        objDivMain.style.height = window.innerHeight - objDivMain.offsetTop - 30;
			    }
			    else
			        objDivMain.style.height = window.innerHeight - objDivMain.offsetTop - 40;
			   // alert(objDivMain.style.height);
			}
			else
			if (browser == 'FF') //Added By Vaijat K On 18/11/2015
			    objDivMain.style.height = intDivHeight - 2 + 'px' ;
			else
			    objDivMain.style.height = intDivHeight + 'px';
            }
            
            if (objdivTblX != null) {
                if (browser == 'IE') {
                    document.body.style.height = window.innerHeight-14 + 'px';
                  
                }
                else
                if (browser == 'FF') {
                    document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
                }
                    if(objdivTblXX.scrollHeight > 200){
                       objdivTblXX.style.height = "70%";
                       objdivTblX.style.height ="50%";
                     }
                objdivTblX.style.display='none';
            
            }
            if (objdivTblY != null) {
                if (browser == 'IE') {
                    document.body.style.height = window.innerHeight - 14 + 'px';
                   
                }
                else
	           if (browser == 'FF') {
	               document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
	           }
                   
                    if(objdivTblYY.scrollHeight > 200){
                        objdivTblYY.style.height =  "70%";
                         objdivTblY.style.height = "50%";
                    }
                     
                     	           
                objdivTblY.style.display='none';
            }
            
	       if(objdivTblMainOtherView!=null){
	           if (browser == 'IE') {
	               document.body.style.height = window.innerHeight - 14 + 'px';
	             
	           }
	           else
	           if (browser == 'FF') {
	               document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
	           }
                if(objTblOtherView.scrollHeight > 200){
                    objTblOtherView.style.height =  "80%";
                     objdivTblMainOtherView.style.height = "52%";
                }                     	           
                    objdivTblMainOtherView.style.display='none';
           }
           
             if(objDivMainAdvancedFilters!=null){
                 if (browser == 'FF') {
                     document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
                 }
                   
                    if(objDivAdvancedFilters.scrollHeight > 200){
                        objDivAdvancedFilters.style.height =  "70%";
                         objDivMainAdvancedFilters.style.height = "50%";
                    }
                     
                     	           
                objDivMainAdvancedFilters.style.display='none';
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
        function window_onresize()
        {
            var browser = WhichBrowser();
			var intDivHeight;
			if (objDivMain != null) {
			    //Added By Vaijat K On 18/11/2015
    //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 70;
    intDivHeight = window.innerHeight - objDivMain.offsetTop - 42;
			if (intDivHeight < 100)	intDivHeight = 100;
			if (browser == 'FF') //Added By Vaijat K On 18/11/2015
			    objDivMain.style.height = intDivHeight - 2 + 'px';
			else 
			    objDivMain.style.height = intDivHeight + 'px';
			}
			
			  if(objdivTblX!=null){
			      if (browser == 'IE')
			      {
			          document.body.style.height = window.innerHeight-14 + 'px';
			         
			      }
                  else
			      if (browser == 'FF') {
			          document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
			      }
                   
                    if(objdivTblXX.scrollHeight > 200){
                       objdivTblXX.style.height = "75%";
                       objdivTblX.style.height ="55%";
                     }
                objdivTblX.style.display='none';
            
            }
			  if (objdivTblY != null) {
			      if (browser == 'IE') {
			          document.body.style.height = window.innerHeight-14 + 'px';
			         
			      }
			      else
	           if (browser == 'FF') {
	               document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
	           }
                    if(objdivTblYY.scrollHeight > 200){
                        objdivTblYY.style.height =  "70%";
                         objdivTblY.style.height = "50%";
                    }
                     
                     	           
                objdivTblY.style.display='none';
            }	
            
          if(objdivTblMainOtherView!=null){
              if (browser == 'IE') {
                  document.body.style.height = window.innerHeight-14 + 'px';
                  
              }
              else
              if (browser == 'FF') {
                  document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K On 18/11/2015
              }
                if(objTblOtherView.scrollHeight > 200){
                    objTblOtherView.style.height =  "80%";
                     objdivTblMainOtherView.style.height = "52%";
                }                     	           
                    objdivTblMainOtherView.style.display='none';
           }        
        }
   function OtherViewsLink_OnClick(CTReportID)
   {
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('OtherViewsLink_OnClick("'+CTReportID+'","1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                 OtherViewsLink_OnClick(CTReportID,"2")
//                 objWait.style.display="none";      
//                 document.getElementById('fillDiv').style.display="none";                                               
            }            
           if  (Mode == "2")
            { 
               ClearAll_OnClick('frmCrossTabGridReport','chkXAxisFilter');   
               ClearAll_OnClick('frmCrossTabGridReport','chkYAxisFilter');              

               // objfrm.action = "CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&Mode=<%=m_strMode %>&CTReportID="+CTReportID;
               //  objfrm.submit();
               //Added By Vidya J ON 2 Feb 2016
               $.ajax({
                   type: 'POST',
                   dataType: 'json',
                   contentType: 'application/json',
                   url: 'CrossTabGridReport.aspx/GenrateURLToken_OtherViewsLink_OnClick',
                   data: JSON.stringify({ MenuGroupID: '<%=m_strMenuGroupId%>', CTReportID: CTReportID, EmployeeID: "<%=Session("intUserID")%>" }),
                   success: function (Result) {

                       objfrm.action = "CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&Mode=<%=m_strMode %>&CTReportID="+CTReportID+"&PkToken=" + Result.d;
                       objfrm.submit();
                   },
                   error: function () {
                       // alert("Error")
                   }

               });
               //End Of Added By Vidya J ON 2 Feb 2016  
            }   
   }
    function ViewReport_OnClick(format)
    {     
    
            var strYAxis = "",strXAxis="";
            if(objYAxis!=null){
                 strYAxis = objYAxis.value;
                 strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
                 strYAxis =   strYAxis.replace(/%/g,"PERCENT");
            }
            if(objXAxis!=null){
                 strXAxis = objXAxis.value;
                 strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
                 strXAxis=  strXAxis.replace(/%/g,"PERCENT");
            }
            

            
            if (strXAxis!="" && strYAxis!=""){
               objfrm.action = "CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&Action=Report&Format="+format+"&FYPeriodID=<%=m_strFYPeriod %>";
           }
            else
            {   objfrm.action = "CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&CTReportID=<%=m_intCTReportID%>&Mode=View&Action=Report&Format="+format+"&FYPeriodID=<%=m_strFYPeriod %>";
            }
           objfrm.submit();

    }
    function Detail_OnClick(strXAxis,strYAxis,strCTReportID)
    {
             strYAxis = strYAxis.replace(/&/g, "AMPERCENT");
             strYAxis =   strYAxis.replace(/%/g,"PERCENT");
             strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
             strXAxis=  strXAxis.replace(/%/g,"PERCENT");
             var str_MenugroupID = '<%=m_strMenuGroupId%>';
       if (str_MenugroupID != "") {
            if ('<%=m_blnIsFYDriven.ToString() %>' == 'True')
                //commented and Added By Nilesh g on 20/1/2016 for URL security
                //     window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                //  else
                //      window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                    {
                        //Added By Vidya J ON 2 Feb 2016
                        $.ajax({
                            type: 'POST',
                            dataType: 'json',
                            contentType: 'application/json',
                            url: 'CrossTabGridReport.aspx/GenrateURLToken_GraphDetail_OnClick',
                            data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', MenuGroupID: '<%=m_strMenuGroupId%>', DQXAxis: strXAxis, DQYAxis: strYAxis, EmployeeID: "<%=Session("intUserID")%>" }),
                            success: function (Result) {

                                window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>&PKToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                            },
                            error: function () {
                                //alert("Error")
                            }

                        });
                        //End Of Added By Vidya J ON 2 Feb 2016  
                    }
                    //  window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&PKToken=<%=m_PKToken_ExportData%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
            else {
                   //Added By Vidya J ON 2 Feb 2016
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json',
                        url: 'CrossTabGridReport.aspx/GenrateURLToken_GraphDetail_OnClick',
                        data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', MenuGroupID: '<%=m_strMenuGroupId%>', DQYAxis: strYAxis, DQXAxis: strXAxis, EmployeeID: "<%=Session("intUserID")%>" }),
                        success: function (Result) {

                            window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&PKToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                        },
                        error: function () {
                            //  alert("Error")
                        }

                    });
                    //End Of Added By Vidya J ON 2 Feb 2016  
                 }
             }
        else
                {
                    if ('<%=m_blnIsFYDriven.ToString() %>' == 'True')
                       {
                        //Added By Vidya J ON 2 Feb 2016
                        $.ajax({
                            type: 'POST',
                            dataType: 'json',
                            contentType: 'application/json',
                            url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                            data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                            success: function (Result) {

                                window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>&PKToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                            },
                            error: function () {
                                //alert("Error")
                            }

                        });
                        //End Of Added By Vidya J ON 2 Feb 2016  
                        }
                     else {
                         //Added By Vidya J ON 2 Feb 2016
                        $.ajax({
                            type: 'POST',
                            dataType: 'json',
                            contentType: 'application/json',
                            url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                            data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                            success: function (Result) {

                                window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery&PKToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                            },
                            error: function () {
                                //  alert("Error")
                            }

                        });
                        //End Of Added By Vidya J ON 2 Feb 2016  
                        }
                  }
             
         //   window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&PKToken=<%=m_PKToken_ExportData%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=" + strCTReportID + "&Mode=DetailQuery", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
        //end of commented and Added By Nilesh g on 20/1/2016 for URL security
    }
    function Export_OnClick()
    {
        //Commented By Shamkant S on 11 Feb 2016
        // window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&CTReportID=<%=m_intCTReportID%>&Mode=View&FYPeriodID=<%=m_strFYPeriod %>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450) / 2) + ",top=" + ((window.screen.height - 350) / 2) + ",width=450,height=350");
        window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&PKToken=<%=m_PKToken_ExportData%>&CTReportID=<%=m_intCTReportID%>&Mode=View&FYPeriodID=<%=m_strFYPeriod %>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 450) / 2) + ",top=" + ((window.screen.height - 350) / 2) + ",width=450,height=350");
          
    }
    
    function txtPageNumber_OnBlur(obj)
    {

       if(!validateNumPaging())
			    return;
		
		    
    }

        function ShowPreviousPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
    			
			    if (objPageNumber.value==1){alert("This is the first page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value) -1;
			            Page_OnClick(objPageNumber.value);
		    }
    			
	    }
	    function ShowFirstPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==1){alert("This is the first page");return;}
			    objPageNumber.value = 1;
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowNextPage()
	    {
	        
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(1);
		    else
		    {
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
				    objPageNumber.value = parseInt(objPageNumber.value)+1
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    function ShowLastPage()
	    {
		    if (isBlank(objPageNumber.value))
			    Page_OnClick(parseInt(objNoOfPages.value));
		    else
		    {	
			    if(!validateNumPaging())
			    return;
			    if (objPageNumber.value==parseInt(objNoOfPages.value)){alert("This is the last page");return;}
			    objPageNumber.value=parseInt(objNoOfPages.value);
			    Page_OnClick(objPageNumber.value);
		    }
	    }
	    /*function txtPageNumber_KeyPress(e)
	    {
		    var code;
			    if (e.keyCode) 
				    code = e.keyCode;
			    else
				    if (e.which) 
					    code = e.which;
    					
			    if(code==13) 
			    {
			   
			 		/* if(!validateNumPaging())
			                return;		*/
			                
			    /*if (!disallowBlank(objPageNumber,"Please Enter Page number",true) && (!disallowNonNumeric(objPageNumber,"Please Enter numeric value for Page number",true)) && (!disallowNegativeNumeric(objPageNumber,"Please Enter positive integer value for Page number",true)) & (!disallowNonInteger(objPageNumber,"Please Enter positive integer value for Page number",true)))				
				    {
					    if (Number(objPageNumber.value) ==0)
					    {
						    alert("Page number should be greater than zero!");
						    return;
					    }
    					
					    if(Number(objPageNumber.value) > Number(parseInt(objNoOfPages.value)) ) 
					    {
						    alert("Page number should not be greater than " + parseInt(objNoOfPages.value));
						    return;
					    }
					    Page_OnClick(objPageNumber.value);
				    }
				    
				    Page_OnClick(objPageNumber.value);
			    }
	    }*/
	
	    function validateNumPaging()
	    {

        if(disallowBlank(objPageNumber,"Please enter page number !",true))
		    return false;
		if(disallowNonNumeric(objPageNumber,"Page number should be numeric only !",true))
		    return false;
		if(disallowNegativeNumeric(objPageNumber,"Only positive number allowed !",true))
		    return false;            	    
		if(disallowNonInteger(objPageNumber,"Only positive integer number allowed !",true))
		    return false;
		    
		    if(isNaN(objPageNumber.value))
		    {
			    alert("Please enter numeric value");
			    objPageNumber.focus();
			    return false;
		    }
		    
		    if(parseInt(objNoOfPages.value)<parseInt(objPageNumber.value))
		    {
			    alert("Please enter value within range of 1 to "+parseInt(objNoOfPages.value));
			     objPageNumber.focus();
			    return false;
		    }
		    return true;
	    }
	function Page_OnClick(Page)
	    {
	    //debugger;
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                objWait.style.display="block";
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('Page_OnClick("'+Page+'","1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                 Page_OnClick(Page,"2")
            }            
           if  (Mode == "2")
            {       
                var strYAxis = "",strXAxis="";
                if(objYAxis!=null){
                     strYAxis = objYAxis.value;
                     strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
                     strYAxis =   strYAxis.replace(/%/g,"PERCENT");
                }
                if(objXAxis!=null){
                     strXAxis = objXAxis.value;
                     strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
                     strXAxis=  strXAxis.replace(/%/g,"PERCENT");
                }
                

               
                
                if (strXAxis != "" && strYAxis != "") {
                   //Commented and added by Yogesh J on 10-Feb-2016 to pass Token
                  // objfrm.action = "CrossTabGridReport.aspx?DQYAxis="+strYAxis+"&DQXAxis="+strXAxis+"&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>";
                    //objfrm.action = "CrossTabGridReport.aspx?DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>&PkToken=<%=m_PK_Token%>";
                    //objfrm.action = "CrossTabGridReport.aspx?DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&Flag=Page&FYPeriodID=<%=m_strFYPeriod %>&PkToken=<%=m_PK_Token%>";
                   
                    //Added by Chakshuta H on 10th-Nov-2016 for to generate and validate Token
                    $.ajax({
                        type: 'POST',
                        dataType: 'json',
                        contentType: 'application/json',
                        url: 'CrossTabGridReport.aspx/GenrateURLToken_Page_OnClick',
                        data: JSON.stringify({ CTReportID: "<%=m_intCTReportID%>", EmployeeID: "<%=Session("intUserID")%>" }),
		                success: function (Result) {
		                    objfrm.action = "CrossTabGridReport.aspx?DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=<%=m_intCTReportID%>&Mode=DetailQuery&FYPeriodID=<%=m_strFYPeriod %>&PkToken=<%=m_PK_Token%>";

		                },
		                error: function () {
		                    //  alert("Error")
		                }
		            });

                    //End Of Added by Chakshuta H on 10th-Nov-2016 for to generate and validate Token
                    //End of comment by Yogesh J 
                }
                else
                {   objfrm.action = "CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID%>&Mode=<%=m_strMode %>";
                }
                objfrm.submit();
            }
	}
	
	
	    function applyFilter()
        {
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');
                //if (objWait) Added by Dhanashri S on 15 June 2015
                //if (objWait) {
                    objWait.style.display = "block";
                //}
                //End of Addition by Dhanashri S on 15 June 2015
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('applyFilter("1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                 applyFilter("2")
            }            
           if  (Mode == "2")
            {               
               if ('<%=m_strMode %>' == 'Graph' && '<%=m_strFromWhere %>' == '')
               {
                   //Added By Vidya J ON 2 Feb 2016
                   $.ajax({
                       type: 'POST',
                       dataType: 'json',
                       contentType: 'application/json',
                       url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                       data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                   success: function (Result) {

                       objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter&PkToken=" + Result.d;
                       objfrm.submit();
                   },
                   error: function () {
                       // alert("Error")
                   }

               });
                   //End Of Added By Vidya J ON 2 Feb 2016  

               }
                   //objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter";
               else
               {
                   //Added By Vidya J ON 2 Feb 2016
                   $.ajax({
                       type: 'POST',
                       dataType: 'json',
                       contentType: 'application/json',
                       url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                       data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                   success: function (Result) {

                       objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&PkToken=" + Result.d;
                       objfrm.submit();
                   },
                   error: function () {
                       // alert("Error")
                   }

               });
                   //End Of Added By Vidya J ON 2 Feb 2016  
               }  //  objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>";
                  // objfrm.submit();
            }   
        }
        function SCX_OnClick()
        {
             var objChkXAxisFilter = GetObjectReference('frmCrossTabGridReport','chkXAxisFilter',true);
             var obSCFX = GetObjectReference('frmCrossTabGridReport','chkXAxisFilterAll');
            // var obhdnXAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnXAxisFilterString');
              //obhdnXAxisFilterString.value="";
             var isSelectedX=0;
	         if(objChkXAxisFilter!=null)
	         {    
	                for(i=0;i<objChkXAxisFilter.length;i++){
        	        
	                    if (objChkXAxisFilter[i].checked==false)
	                    {   isSelectedX = 1;
	                    }
	                }
	    
	        }
	        if(isSelectedX==1)
	           obSCFX.checked=false;
	           
	        if(isSelectedX==0)
	           obSCFX.checked=true;
        
        }
        
        function SCY_OnClick()
        {
             var objChkYAxisFilter = GetObjectReference('frmCrossTabGridReport','chkYAxisFilter',true);
             var obSCFY = GetObjectReference('frmCrossTabGridReport','chkYAxisFilterAll');
            // var obhdnYAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnYAxisFilterString');
            // obhdnYAxisFilterString.value="";
             var isSelectedY=0;
	         if(objChkYAxisFilter!=null)
	         {    
	                for(i=0;i<objChkYAxisFilter.length;i++){
        	        
	                    if (objChkYAxisFilter[i].checked==false)
	                    {   isSelectedY = 1;
	                    }
	                }
	    
	        }
	        if(isSelectedY==1)
	           obSCFY.checked=false;
	           
	           
	           
	        if(isSelectedY==0)
	           obSCFY.checked=true;
        
        }
        var SelectClearAllY=0;
        function SelectAndClearAllY_OnClick()
        {
                var obSCFilterY = GetObjectReference('frmCrossTabGridReport','chkYAxisFilterAll');
               // var obhdnYAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnYAxisFilterString');
              
                if(obSCFilterY!=null){
                    if(obSCFilterY.checked==true)
                        SelectClearAllY = 0;
                    else
                        SelectClearAllY = 1;
                }
                if(SelectClearAllY==0){
                
                    SelectAllCheckboxs('frmCrossTabGridReport','chkYAxisFilter');
                    SelectClearAllY = 1;
                }
                else
                {
                    ClearAll_OnClick('frmCrossTabGridReport','chkYAxisFilter');
                    // obhdnYAxisFilterString.value = "";
                    SelectClearAllY=0;
                }

        }
        
        var SelectClearAllX=0;
        function SelectAndClearAllX_OnClick()
        {
                var obSCFilterX = GetObjectReference('frmCrossTabGridReport','chkXAxisFilterAll');
                //var obhdnXAxisFilterString = GetObjectReference('frmCrossTabGridReport','hdnXAxisFilterString');
              
                if(obSCFilterX!=null){
                    if(obSCFilterX.checked==true)
                        SelectClearAllX = 0;
                    else
                        SelectClearAllX = 1;
                }
                if(SelectClearAllX==0){
                
                    SelectAllCheckboxs('frmCrossTabGridReport','chkXAxisFilter');
                    SelectClearAllX = 1;
                }
                else
                {
                    ClearAll_OnClick('frmCrossTabGridReport','chkXAxisFilter');
                   //  obhdnXAxisFilterString.value = "";
                    SelectClearAllX=0;
                }

        }
        
        var ShowFilterX='0';
        var ShowFilterY='0';
        var ShowOtherViewFilter = '0';
        var ShowAdvancedFilter='0';
        
        function showFiltersX(show)
        {
            var objtblFilter = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilter =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
             
            if (ShowFilterX=='0')
            {
                objtblFilter.style.top = 25;
                //Commented and Added by Dhanashri S on 15 June 2015
                //objtblFilter.style.left = "57%";
                //Commented and added by Yogesh J on 09-OCT-2015
                //  objtblFilter.style.left = "20%";
                   objtblFilter.style.left = "57%"
                //End of Comment and Addition by Yogesh J on 06-OCT-2015
                //End of Comment and Addition by Dhanashri S on 15 June 2015
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                objShowFilter.style.display = 'None';
                objHideFilter.style.display = '';
                
                if(objShowFilterY!=null){
                objShowFilterY.style.display = '';
                objHideFilterY.style.display = 'none';}
                
                objtblFilterY.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                   
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                
                ShowFilterX='1';
                ShowFilterY ='0';
                ShowOtherViewFilter = '0';
                ShowAdvancedFilter='0';

            }
            else if(ShowFilterX=='1')
            {
                objtblFilter.style.display='none';
                ShowFilterX='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
        
       
        function showFiltersY(show)
        {
            var objtblFilter = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilter =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
            
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if (ShowFilterY=='0')
            {
                objtblFilter.style.top = 25;
                //Commented and Added by Dhanashri S on 15 June 2015
                //objtblFilter.style.left = "62%";
                //Commented and Added by Yogesh J on 09-OCT-2015
              //  objtblFilter.style.left = "28%";
                objtblFilter.style.left = "62%"
                //End of commment and Addition By Yogesh J on 09-OCT-2015
                //End of Comment and Addition by Dhanashri S on 15 June 2015
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                
                objShowFilter.style.display = 'None';
                
                objHideFilter.style.display = '';
                
                if(objShowFilterX!=null){
                objShowFilterX.style.display = '';
                objHideFilterX.style.display = 'none';}
                
                objtblFilterX.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                   
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                                
                ShowFilterY='1';
                ShowFilterX='0';
                ShowOtherViewFilter = '0';
                ShowAdvancedFilter='0';

            }
            else if(ShowFilterY=='1')
            {
                objtblFilter.style.display='none';
                ShowFilterY='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
        function showOtherViewFilters()
        {
            var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
            
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            var objdivMainAdvancedFilters= GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            var objHideAdvancedFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            var objShowAdvancedFilter =GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if (ShowOtherViewFilter=='0')
            {
                objtblOtherViewFilter.style.top=25;
                objtblOtherViewFilter.style.left="50%";
                objtblOtherViewFilter.zIndex=1;
                objtblOtherViewFilter.style.display='';
                
                objtblFilterX.style.display = 'none';
                objtblFilterY.style.display = 'none';
                
                if(objShowFilterX!=null)  
                objShowFilterX.style.display = '';
                
                if(objHideFilterX!=null)
                objHideFilterX.style.display = 'none';
                
                if(objShowFilterY!=null)
                objShowFilterY.style.display = '';   
                    
                if(objHideFilterY!=null)       
                objHideFilterY.style.display = 'None';
                
                if(objdivMainAdvancedFilters!=null)
                   objdivMainAdvancedFilters.style.display= 'None';
                
                if(objShowAdvancedFilter!=null){
                objShowAdvancedFilter.style.display = '';
                objHideAdvancedFilter.style.display = 'none';}
                
                ShowFilterY='0';
                ShowFilterX='0';
                ShowOtherViewFilter = '1';
                ShowAdvancedFilter='0';

            }
            else if(ShowOtherViewFilter=='1')
            {
                objtblOtherViewFilter.style.display='none';
                ShowOtherViewFilter='0';    
            }
        
        }
         function CloseFilter()
        {
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            var objShowFilterAdvanced=GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            var objHideFilterAdvanced =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');

            
            if(objShowFilterAdvanced!=null) objShowFilterAdvanced.style.display = '';
            if(objHideFilterAdvanced!=null) objHideFilterAdvanced.style.display = 'None';
             ShowAdvancedFilter='0'; 
            
            if(objShowFilterX!=null) objShowFilterX.style.display = '';
            if(objHideFilterX!=null) objHideFilterX.style.display = 'None';
             ShowFilterX='0'; 
            if(objShowFilterY!=null) objShowFilterY.style.display = '';
            if(objHideFilterY!=null) objHideFilterY.style.display = 'None';
             ShowFilterY='0'; 
            if(objdivTblY!=null) objdivTblY.style.display='none';
            if(objdivTblX!=null) objdivTblX.style.display='none';
            if(objdivTblMainOtherView!=null) objdivTblMainOtherView.style.display='none';
            ShowOtherViewFilter = '0';
            
            if(objDivMainAdvancedFilters!=null) objDivMainAdvancedFilters.style.display='none';
                        
        }
        
        function ShowFilterX_OnClick()
        {
            showFiltersX(1);
        }
        function HideFilterX_OnClick()
        {
            showFiltersX(0);
        }
        function ShowFilterX_OnClick()
        {
            showFiltersX(1);
        }
        function HideFilterX_OnClick()
        {
            showFiltersX(0);
        }
        
        function ShowFilterY_OnClick()
        {
            showFiltersY(1);
        }
        function HideFilterY_OnClick()
        {
            showFiltersY(0);
        }
        function OtherViews_OnClick()
        {
              showOtherViewFilters();
        }
        
////Added By Amol Changle On: 09 Feb 2009
//Purpose: To view reports Financial year wise          
        function ShowPreviousFY(Title)
        {
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');

                 if (Title !="")   
                 {
                 objWait.style.display="block";
                 document.getElementById('fillDiv').style.display="block";                                                                   
                 }
                 window.setTimeout('ShowPreviousFY("'+Title+'","1")',1)
            }
            
            if (Mode == "1")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');
                ShowPreviousFY(Title,"2");
                if (Title =="")
                {
                    objWait.style.display="none";
                     document.getElementById('fillDiv').style.display="none";                                                                   
                }               
            }    
            if (Mode == "2")
            {
                if(Title=='')
                {   
                   alert('This is First Financial Period.');
                   return;
                }
                
                if(objTxtFYPeriod==null)
                    return;
                  
                objTxtFYPeriod.value=parseInt(objTxtFYPeriod.value)-1;
                objfrm.submit();         
            }
        
        }
      
        function ShowNextFY(Title)
        {   
            var Mode = (arguments.length>1)?arguments[1]:"0";
            if (Mode == "0")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');

                 if (Title !="")   
                 {
                    objWait.style.display="block";
                    document.getElementById('fillDiv').style.display="block";                        
                    document.body.readonly=true;
                 }
                 window.setTimeout('ShowNextFY("'+Title+'","1")',1)            
            }
            if(Mode == "1")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');
             ShowNextFY(Title,"2");
             if (Title =="")
             {
                 objWait.style.display="none";      
                 document.getElementById('fillDiv').style.display="none";                                               
             }       
            }
            
            if(Mode == "2")
            { 
                if(Title=='')
                {   
                   alert('This is Last Financial Period.');
                   return;
                }
                
                if(objTxtFYPeriod==null)
                    return;
                  
                objTxtFYPeriod.value=parseInt(objTxtFYPeriod.value)+1;
                objfrm.submit();              
            
            }
    
        }
        
                    
    function txtPageNumber_KeyPress(e)
	{

            var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{       
			    
			      if(validateNumPaging()) {
					Page_OnClick(objPageNumber.value);
					}
					else{ return; }
					
			}
		    else
		    return;
	}
        
//End Addition         

function ViewGraph_OnClick()
{
       
//        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
//        window.open("../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&FYPeriodID=<%=m_strFYPeriod %>","_self","resizable=no,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");
//        else
//        window.open("../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph","_self","resizable=no,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 570)/2) + ",width=900,height=570");


//        if('<%=m_blnIsFYDriven.ToString() %>'=='True')
//        objfrm.action= "../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&FYPeriodID=<%=m_strFYPeriod %>";
//        else
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitscreen');
                //if (objWait) Added by Dhanashi S on 15 June 2015
                //if (objWait)
                //{
                    objWait.style.display = "block";
                //}
                //End of Addition by Dhanashri S on 15 June 2015
                document.getElementById('fillDiv').style.display="block";                        

                window.setTimeout('ViewGraph_OnClick("1")',1)            
            }   
            if (Mode == "1")
            {
                 objWait = GetObjectReference('frmCrossTabGridReport','pleasewaitScreen');
                 ViewGraph_OnClick("2")
            }            
           if  (Mode == "2")
           {
               //Added By Vidya J ON 2 Feb 2016
               $.ajax({
                   type: 'POST',
                   dataType: 'json',
                   contentType: 'application/json',
                   url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                   data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                   success: function (Result) {

                       objfrm.action = "../Home/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph&PkToken=" + Result.d;
                       objfrm.submit();
                   },
                     error: function () {
                         // alert("Error")
                     }

               });
               //End Of Added By Vidya J ON 2 Feb 2016  
             //   objfrm.action="../Home/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&Mode=Graph";
                         
            }
}       

function CboGraphType_OnChange(ObjGraphType)
{
    if(ObjGraphType==null)
        return;
        
    for(i=0;i<ObjGraphType.length;i++)
    {
        objRow=GetObjectReference('','TR_'+ObjGraphType.options[i].value);
        
        if(ObjGraphType.options[i].value==ObjGraphType.value)
            objRow.style.display='';
        else
            objRow.style.display='none';
    }
}

function GridView_OnClick()
{
            var Mode = (arguments.length>0)?arguments[0]:"0";
            if (Mode == "0")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                //if (objWait) Added by Dhanashri S on 15 June 2015 
                if (objWait) {
                    objWait.style.display = "block";
                }
                //End of addition by Dhanashri S on 15 June 2015
                document.getElementById('fillDiv').style.display = "block";

                window.setTimeout('GridView_OnClick("1")',1)            
            }   
            if (Mode == "1")
            {
                //Commented and added By Bharat Tekade on 16th-Jun-2015
                //objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitScreen');
                objWait = GetObjectReference('frmCrossTabGridReport', 'pleasewaitscreen');
                //End Of Commented and added By Bharat Tekade on 16th-Jun-2015
                 GridView_OnClick("2")
            }            
           if  (Mode == "2")
            {       
            //window.location.href="../Payroll/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&FromWhere=Graph"  
            //   objfrm.action = "../Home/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&FromWhere=Graph";
               // objfrm.submit();  
               //Added By Vidya J ON 5 Feb 2016
               $.ajax({
                   type: 'POST',
                   dataType: 'json',
                   contentType: 'application/json',
                   url: 'CrossTabGridReport.aspx/GenrateURLToken_ViewGraph_OnClick',
                   data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', EmployeeID: "<%=Session("intUserID")%>" }),
                   success: function (Result) {
 
                       objfrm.action = "../Home/CrossTabGridReport.aspx?CTReportID=<%=m_intCTReportID.ToString() %>&FromWhere=Graph&PkToken=" + Result.d;
                       objfrm.submit();
                   },
                   error: function () {
                       // alert("Error")
                   }

               });
               //End OF Added By Vidya J ON 5 Feb 2016
             }
}
      
         function GraphDetail_OnClick(strText,strYAxis,strXAxis)
         {
  
             
             var index=strXAxis.split("series")[1];
            
             strXAxis=arrSeries[index-1];

             strYAxis = strYAxis.replace(/&/g,"AMPERCENT");
             strYAxis =   strYAxis.replace(/%/g,"PERCENT");
             strYAxis =   strYAxis.replace(/#/g,"<HASH>");
             strXAxis =  strXAxis.replace(/&/g,"AMPERCENT");
             strXAxis=  strXAxis.replace(/%/g,"PERCENT");
             strXAxis=  strXAxis.replace(/#/g,"<HASH>");
        
             if('<%=m_blnIsFYDriven.ToString() %>'=='True')
             {   //Added By Vidya J ON 2 Feb 2016
                 $.ajax({
                     type: 'POST',
                     dataType: 'json',
                     contentType: 'application/json',
                     url: 'CrossTabGridReport.aspx/GenrateURLToken_GraphDetail_OnClick',
                     data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', MenuGroupID: '<%=m_strMenuGroupId%>', DQYAxis: strYAxis, DQXAxis: strXAxis, EmployeeID: "<%=Session("intUserID")%>" }),
                     success: function (Result) {
	                      
                         window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=<%=m_intCTReportID.ToString() %>&Mode=DetailQuery&Flag=GraphDetail&FYPeriodID=<%=m_strFYPeriod %>&PkToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
                     },
                     error: function () {
                        // alert("Error")
                     }

                 });
                 //End Of Added By Vidya J ON 2 Feb 2016  
             }
          
         else
         {
             //Added By Vidya J ON 2 Feb 2016
		            $.ajax({
		                type: 'POST',
		                dataType: 'json',
		                contentType: 'application/json',
		                url: 'CrossTabGridReport.aspx/GenrateURLToken_GraphDetail_OnClick',
		                data: JSON.stringify({ CTReportID: '<%=m_intCTReportID.ToString() %>', MenuGroupID: '<%=m_strMenuGroupId%>', DQYAxis: strYAxis, DQXAxis: strXAxis, EmployeeID: "<%=Session("intUserID")%>" }),
		                success: function (Result) {
	                      
		                    window.open("../Home/CrossTabGridReport.aspx?MenuGroupID=<%=m_strMenuGroupId%>&DQYAxis=" + strYAxis + "&DQXAxis=" + strXAxis + "&CTReportID=<%=m_intCTReportID.ToString() %>&Mode=DetailQuery&Flag=GraphDetail&PkToken=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900) / 2) + ",top=" + ((window.screen.height - 570) / 2) + ",width=900,height=570");
	                    },
	                    error: function () {
	                    //    alert("Error")
	                    }

		            });
             //End Of Added By Vidya J ON 2 Feb 2016  
       
         }   
    }  
    
    function ShowHelpDeskAnalytics()
    {
      //  window.open("../Home/DetailView.aspx?MenuGroupId=<%=m_strMenuGroupId%>", "_self")
        //Added By Vidya J ON 2 Feb 2016
        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'CrossTabGridReport.aspx/GenrateURLToken_ShowHelpDeskAnalytics',
            data: JSON.stringify({ MenuGroupID: '<%=m_strMenuGroupId%>',EmployeeID: "<%=Session("intUserID")%>" }),
            success: function (Result) {

                window.open("../Home/DetailView.aspx?MenuGroupId=<%=m_strMenuGroupId%>&PKToken=" + Result.d, "_self")
            },
            error: function () {
              //  alert("Error")
            }

        });
        //End Of Added By Vidya J ON 2 Feb 2016   
    }
    
            function ShowAdvancedFilters_OnClick()
        {
            ShowAdvancedFilters(1);
        }
        function HideAdvancedFilters_OnClick()
        {
            ShowAdvancedFilters(0);
        }
        
         function ShowAdvancedFilters(show)
        {
            var objtblFilterX = GetObjectReference('frmCrossTabGridReport','divTblX');
            var objtblFilterY = GetObjectReference('frmCrossTabGridReport','divTblY');
            var objtblFilter  = GetObjectReference('frmCrossTabGridReport','divMainAdvancedFilters');
            
            var objHideFilterY =GetObjectReference('frmCrossTabGridReport','HideFilterY_OnClickUI_HEAD0-6350');
            var objShowFilterY =GetObjectReference('frmCrossTabGridReport','ShowFilterY_OnClickUI_HEAD0-6350');
            
            
            var objHideFilterX =GetObjectReference('frmCrossTabGridReport','HideFilterX_OnClickUI_HEAD0-6350');
            var objShowFilterX =GetObjectReference('frmCrossTabGridReport','ShowFilterX_OnClickUI_HEAD0-6350');
            
            var  objShowFilter=GetObjectReference('frmCrossTabGridReport','ShowAdvancedFilters_OnClickUI_HEAD0-6350');
            var objHideFilter =GetObjectReference('frmCrossTabGridReport','HideAdvancedFilters_OnClickUI_HEAD0-6350');
            
             var objtblOtherViewFilter = GetObjectReference('frmCrossTabGridReport','divTblMainOtherView');
             
            if (ShowAdvancedFilter=='0')
            {
                objtblFilter.style.top=25;
                objtblFilter.style.left="47%";
                objtblFilter.zIndex=1;
                objtblFilter.style.display='';
                objShowFilter.style.display = 'None';
                objHideFilter.style.display = '';
                
                if(objShowFilterX!=null){
                objShowFilterX.style.display = '';
                objHideFilterX.style.display = 'none';}
                
                objtblFilterX.style.display = 'None';
                
                if(objShowFilterY!=null){
                objShowFilterY.style.display = '';
                objHideFilterY.style.display = 'none';}
                
                objtblFilterY.style.display = 'None';
                
                if(objtblOtherViewFilter!=null)
                objtblOtherViewFilter.style.display = 'None';
                
                ShowAdvancedFilter='1';
                ShowFilterX='0';
                ShowFilterY ='0';
                ShowOtherViewFilter = '0';

            }
            else if(ShowAdvancedFilter=='1')
            {
                objtblFilter.style.display='none';
                ShowAdvancedFilter='0';    
                objShowFilter.style.display = '';
                objHideFilter.style.display = 'None';
            }
        }
    
            function applyAdvancedFilter()
        {
            if(!ValidateAdvancedFilters()) return;
             
            if ('<%=m_strMode %>' == 'Graph' && '<%=m_strFromWhere %>' == '')
                //Commented and Added by Dhanashri S on 22 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
                //objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter";
                //ADDED BY NILESH G ON 22/8/2016 PURPOSE :PKTOKEN ISSUE
                // objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter&Flag=ApplyFilter";
                objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&PKToken=<%=m_PKToken%>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter&Flag=ApplyFilter";
                //End of comment and addition by Dhanashri S on 22 Aug 2016 
            else
                //Commented andAdded by Dhanashri S on 22 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
                //objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>";
                //ADDED BY NILESH G ON 22/8/2016 PURPOSE :PKTOKEN ISSUE
                //  objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Flag=ApplyFilter";
                objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&PKToken=<%=m_PKToken%>&CTReportID=<%=m_intCTReportID%>&Flag=ApplyFilter";
                //End of comment and addition by Dhanashri S on 22 Aug 2016 
           objfrm.submit();
        }
        
        function ClearAdvancedFilter()
        {   
            ClearFilter();
        
            if ('<%=m_strMode %>' == 'Graph' && '<%=m_strFromWhere %>' == '')
                //ADDED BY NILESH G ON 22/8/2016 PURPOSE :PKTOKEN ISSUE
                //  objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter&Flag=ApplyFilter";
                objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&PKToken=<%=m_PKToken%>&CTReportID=<%=m_intCTReportID%>&Action=ApplyFilter&Flag=ApplyFilter";
            else
                //ADDED BY NILESH G ON 22/8/2016 PURPOSE :PKTOKEN ISSUE
                //objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&CTReportID=<%=m_intCTReportID%>&Flag=ApplyFilter";
                objfrm.action = "CrossTabGridReport.aspx?Mode=<%=m_strMode %>&PKToken=<%=m_PKToken%>&CTReportID=<%=m_intCTReportID%>&Flag=ApplyFilter";
           objfrm.submit();
        }
    
         </script>
</body>
</html>
