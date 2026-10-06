<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRD_ProductTree.aspx.vb" Inherits="PbNIT.PRD_ProductTree" %>
<!DOCTYPE HTML>
<style>
      /*Commented and added by Yogesh J on 19/12/2015* issue id = 2752 */
    #divLeft {
        position:absolute!important;
        top:0px !important;
    }
    .clsTable {
        position:relative;
    }
      /*End of comment and addition by Yogesh J on 19/12/2015* issue id = 2752 */
</style>
<html>
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<%CommonFunctions.General.PlotPageHeadTag("PRD_ProductTree")%>
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
    
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()" >
    <form id="frmPRD_ProductTree"  method="post" runat="server">
			<%PageInit%>
    </form>
	<script language="javascript" type="text/javascript">
		var objform=GetFormReference('frmPRD_ProductTree');
		var objdivlist = GetObjectReference('frmPRD_ProductTree', 'PageDiv');
		var objdivLeft = GetObjectReference('frmPRD_ProductTree', 'divLeft');
		var objdivRight = GetObjectReference('frmPRD_ProductTree', 'divRight');
		var objdivpage = GetObjectReference('frmPRD_ProductTree', 'divPage');
		var strResult = "";
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
	    //The div tag has id as PageDiv 
	    
		function window_onload()
		{
		    
		   
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100) intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
		
			objdivlist.style.height = intDivHeight + 'px';

			}
			    /*Commented and added by Yogesh J on 19/12/2015* issue id = 2752 */
     else if (objdivpage !=null) {
			intDivHeight = window.innerHeight - objdivpage.offsetTop - 38;
			if (intDivHeight < 100) intDivHeight = 100;
			objdivpage.style.height = intDivHeight + 'px';
     }

			if (objdivLeft != null && objdivRight != null)
			{
			    intDivHeight = window.innerHeight - objdivpage.offsetTop - 45;
			    objdivRight.style.height = intDivHeight + 'px';
			    objdivLeft.style.height = intDivHeight + 'px';

			}
		    /*End of comment by Yogesh J on on 19/12/2015* issue id = 2752 */
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			   
			objdivlist.style.height = intDivHeight + 'px';
			}

			    /*Commented and added by Yogesh J on 19/12/2015* issue id = 2752 */
			else if (objdivpage != null) {
			    intDivHeight = window.innerHeight - objdivpage.offsetTop - 38;
			    if (intDivHeight < 100) intDivHeight = 100;
			    objdivpage.style.height = intDivHeight + 'px';

			}
			if (objdivLeft != null && objdivRight != null) {
			    intDivHeight = window.innerHeight - objdivpage.offsetTop - 45;
			    objdivRight.style.height = intDivHeight + 'px';
			    objdivLeft.style.height = intDivHeight + 'px';

			}
		    /*End of comment by Yogesh J on on 19/12/2015* issue id = 2752 */
		}	
		//function Node_OnClick(NodeID)
		//{
		//    debugger;
		//	objform.action = "PRD_ProductTree.aspx?NodeID=" + NodeID + "&Mode=Edit"
		//	objform.submit();
			
		//}	
		//ADDED BY NILESH G ON 6/1/2015 FOR ISSUE ID 2752
  //      function TabItemOnClick(PageName, TagID, ControlItemID)
  //      {
  //          alert(1);
		//    var num;
		//    var str = PageName;
		//    str = str.split("(");
		//    num = str[1];
		//    num = num.substring(0, num.length - 1);
		//    Node_OnClick(num);
           

		//}
	 //   //ENDDED BY NILESH G ON 6/1/2015 FOR ISSUE ID 2752
		//function Node_OnClick(NodeID)
		//{
		//   alert(2);
		//    //Added by swapnil aswale on 12-09-2015
		//    document.getElementById("divLeft").style.position = ""
  //          //Ended
		//	var objDivRight = GetObjectReference('frmPRD_ProductTree','divRight');
		//	var strURL= "PRD_ProductTree.aspx?NodeID=" + NodeID + "&Mode=Edit";
		//	val=generateRequest(strURL); 
		//	if (val==true) 
		//	{ 
		//		objDivRight.innerHTML = strResult
		//	}

		//	window.parent.jQuery("#preloader").remove();
		//	window.parent.jQuery("#fillDiv").remove();
		//	window.parent.jQuery("#preloader").fadeOut("slow");
		//	window.parent.jQuery("#fillDiv").fadeOut("slow");
		//	window.parent.jQuery("#preloader").remove();
		//	window.parent.jQuery("#fillDiv").remove();
		//}		
		var brw = isIE();

		function Process() 
		{ 
			if (req.readyState == 4) 
			{ 
				if (req.status == 200) 
				{ 
				    //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
				    if (brw == "IE")
					{ 
						xmlDoc = new ActiveXObject("Microsoft.XMLDOM"); 
						xmlDoc.async=false; 
						xmlDoc.loadXML(req.responseText); 
					} 
					else if (document.implementation &&	document.implementation.createDocument) 
					{
					    if (req.responseXML != null)
                            {
					        xmlDoc = document.implementation.createDocument("", "", null);
					        if (brw == "FF")//added by Nilesh g on 10/12/2015

						xmlDoc.load(req.responseXML); 
                            }
					} 
						
					strResult=req.responseText; 
					
				} 
			} 
		}

	
		function generateRequest(url)
		{ 
		    /*if (window.XMLHttpRequest) 
			{ 	
				req = new XMLHttpRequest(); 
			} 
			else if (window.ActiveXObject) 
			{ 
				req = new ActiveXObject("Microsoft.XMLHTTP"); 
			}  
			req.onreadystatechange = Process; 
			req.open("POST", url,false); 
			req.send(); 
			delete req; */
		    // Modified By MahendraV On 12:29 PM 7/25/2007 For PMLifeLine 7.0
		    // To Mozilla - based browser , Netscape- based browser
		    // Start_MV_7/25/2007
		    var strNavigator = navigator.appName;
		    strNavigator = strNavigator.toUpperCase();
		    if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
		    { 
		        req = new ActiveXObject("Msxml2.XMLHTTP"); 
		        //hook the event handler
				
		        req.onreadystatechange = Process;
				
		        //prepare the call, http method=GET, false=asynchronous call
		        req.open("POST",url, false);
				
		        //finally send the call
		        req.send();
		    }
		    else
		    {
			
		        // Mozilla - based browser , Netscape
		        req = new XMLHttpRequest();
		        //hook the event handler
		        req.onreadystatechange = Process;
		        //prepare the call, http method=GET, false=asynchronous call
		        req.open("POST",url, false);
		        //finally send the call
		        req.send(null);
				
		        if (req.readyState == 4) 
		        { 
		            if (req.status == 200) 
		            { 
		                if (req.responseText != null)
		                {
		                    if (req.responseXML != null) {
		                        xmlDoc = document.implementation.createDocument("", "", null);
		                        xmlDoc.async = false;
		                        //xmlDoc.load(req.responseXML);
		                        xmlDoc.load(req.responseXML);
		                        strResult = req.responseText;
		                    }
							
		                }
		            }
		        }
				
		    }
		    //End_MV_7/25/2007
		    delete req;
		    return true;
			 
		}
			
	</script>
<%
If Request.QueryString("Mode") = "Edit" Then
	GenerateInformation()
End If
%>	
  </body>
</html>
