<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCharter.aspx.vb" Inherits="PbNIT.ProjectCharter" %>

<!DOCTYPE HTML>



  <%-- MenuTab for projectCharter--%>
            	
		<meta content="Microsoft Visual Studio.NET 7.0" name="GENERATOR">
		<meta content="Visual Basic 7.0" name="CODE_LANGUAGE">
	    <script src="../General/CommonValidations.js"></script>
		<meta http-equiv="Cache-Control" CONTENT="no-cache">
		<meta http-equiv="Pragma" CONTENT="no-cache">

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

        <script src="JqueryMenuTab.js"></script>
    

 <%--end of  MenuTab for projectCharter--%>

  <!-- <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" /> -->
<script language="javascript" type="text/javascript">
    
    //FOR  MenuTabLIKE MENU
    //$(document).ready(function () {
    //    /*menutab for projectCharter*/
    //    //$('#tabs').tabs().addClass('ui-tabs-vertical ui-helper-clearfix');
    //    //$("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
     
     

    //});



    
    window.onload = function ()
    {
        $('#tabs').tabs().addClass('ui-tabs-vertical ui-helper-clearfix');
        $("#tabs li").removeClass("ui-corner-top").addClass("ui-corner-left");
        var UserName = '<%=Session("strUserName")%>';
        document.getElementById("Initiatedby").value= UserName;
       // alert(UserName);
       

       // FOR DISPALY DATE
       // var  strDateControlName='<%=System.DateTime.Today%>';
        //'<%=System.DateTime.Today%>';
       // addDate();
       //document.getElementById("DateControlName").value= strDateControlName;
      //  alert( strDateControlName);
       
          
     //function addDate() {
    //    date = new Date();
    //    var month = date.getMonth() + 1;
    //    var day = date.getDate();
    //    var year = date.getFullYear();

    //    if ($('#DateControlName').value == '') {
    //       $('#DateControlName').value = day + '/' + month + '/' + year;
    //    }
        //}

    }

    //keypress Event for searching customer name

  
        function isEmpty(str) {
            return str.replace(/^\s+|\s+$/gm,'').length == 0;
        }
        function Doc_OnmouseUp()
        {
            var objDiv = document.getElementById('SearchKeyDiv');
            if(objDiv!=null)
            {
                objDiv.style.display='none';		    
            }		
            
            //var objProjectName=document.getElementById('Customer');  
            //var objProjectID=GetObjectReference('frmProjectCharter','Customer');  
            //if(objProjectName="" && objProjectName!=null && objProjectName!='undefined' && objProjectID!=null && objProjectID!='undefined')
            //{
        
            //    var str = firstElem.split(',');
            //    objProjectID.value = str[0];
            //    objProjectName.value = str[1];    
            //}
		    

        }
        var id
       // var GetObjectReference;
        var result;
        var  firstElem;
        var objProjectID=GetObjectReference('frmProjectCharter','Customer');
        function Unit_ONClick_Project(id)
        {
          //  debugger;

      
            if (objProjectID != null)
            {    
                objProjectID.value = '';                   
            }
         
            // debugger;
            var SearchKey=document.getElementById(id).value   
            var rect = document.getElementById(id).getBoundingClientRect();
            var getID=document.getElementById(id);
   
            if(SearchKey=='')
            {
                Doc_OnmouseUp();
            }   
       
            var str;
     
            url= "Action=GetProjectCode&SearchKey=" + SearchKey + "";
    
            result1 = CheckData(url,0,0,0,0); 
 
            if (result1 != null && result1 != true && isEmpty(SearchKey)!=true)
            { 
     
                var strArr1=[];
       
                //  var list='<ul style=" list-style-type:none;">';
                var list='<table id=" Searchtbl" border=1 class=clsTable cellspacing=0 cellpadding=0 Width=100%>';
                strArr1 = result1.split('$$');
                for(i=0;i<=strArr1.length-2;i++)
                {
      
                    var strPrj = strArr1[i+1].split(',');
           
                    if(i==0)
                    {
                        firstElem =strArr1[i+1];
                    }    
                
                    // list += "<li ><a id='"+strArr1[i+1]+"' onclick=javascript:setvalue_onclick(this.id,"+id+");>"+strPrj[1]+"</a></li>";
                    list += "<tr class=clsTREven <a id='"+strArr1[i+1]+"' onmouseover=this.style.backgroundColor='#FFD695' onmouseout=this.style.backgroundColor='' onclick='javascript: setvalue_onclick(this.id);'id='td_"+i+"''></a><td>"+strPrj[1]+"</td></tr>";
                  //  list += "<tr class=clsTREven <a id='"+strArr1[i+1]+"'onclick='javascript: setvalue_onclick(this.id);>"+strPrj[1]+"</a><td ></td></tr>";
                   
                    //list += "<li ><a href='javascript:setvalue("""+strArr[i+1]+""")' style='font-size:10pt' >"+strArr[i+1]+"</a></li>";
                 
                }
              
                //  list+='</ul>';
                list+='</table>';
             
                //alert(result);
                document.getElementById('SearchKeyDiv').innerHTML= list;
                document.getElementById('SearchKeyDiv').style.display='block';
                var d = document.getElementById('SearchKeyDiv');
              //  d.style.position = "fixed";
                d.style.left = rect.left;
                d.style.top = rect.top+20;
            }
            else
            {
            
            }
        }


    
        function ValidateText(id)
        {  
           //debugger;

            var strArr=[];
            var SearchKey=document.getElementById(id).value   
            var rect = document.getElementById(id).getBoundingClientRect();
            var getID=document.getElementById(id);
            var objProjectName = GetObjectReference('frmProjectCharter','Customer')
            // var objProjectName = document.getElementById('frmProjectCharter','Customer')
    
            var result1;
  

     
       
            if(SearchKey!="")
            {
                if(id=='Customer')
                {
                    url= "Action=GetProjectCode&SearchKey=" + SearchKey + "";
        
                    result1 = CheckData(url,0,0,0,0); 
                 
                    if(result1 == "")
                    {
                        alert("Please Provide Valid Data")
                 
                        document.getElementById(id).value="";
                  
                        document.getElementById('SearchKeyDiv').style.display='none';
                        document.getElementById(id).focus(); 
                        return false;
                   

                    }
                }
            }

    
       
        }

        //function setvalue(obj)
        //{  
        //    id.value = val;
        //    debugger;
        //    document.getElementById('Customer').value= obj.value;
        //    document.getElementById('SearchKeyDiv').style.display='none';
        //}
    
        function setvalue_onclick(str,txtid)
        {  
           
            //debugger;
           
         //   str=firstElem;
          
            var NewTR,newTD;      
            var NewTR1,newTD1;
            var strPrjID = str.split(',');
            txtid = strPrjID[1];
            document.getElementById('SearchKeyDiv').style.display='none';
            document.getElementById("Customer").value=strPrjID[1];
            alert(strPrjID[0]);

            // alert(strPrjID);
            //document.getElementById("Customer").value = strPrjID[1];
            //document.getElementById('SearchKeyDiv').style.display='none';
            //var Project = document.getElementById("Customer")
            document.getElementById("txthidProjectID").value= strPrjID[0];
            //alert(strPrjID[0]);
      
            if (objProjectID != null)
            {    
                objProjectID.value = strPrjID[1];
                document.getElementById("txthidProjectID").value= strPrjID[0]
                //alert(document.getElementById("txthidProjectID").value);
            }
    
  
        }
    

        //keypress Event for searching customer name
            	
    
              
            
    
        //FUNCTION FOR TO TAKE LIMITATED CHAR IN FILED
        function limitText(limitField, limitCount, limitNum) {
            var length;  
       

            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else 
            {
                limitCount.value = limitNum - limitField.value.length;
            }
            
     
        }
       
        //$(window).scroll(function(){
        //    $("#SearchKeyDiv")
        //           .stop()
        //           .animate({"marginTop": ($(window).scrollTop() + 30) + "px"}, "slow" );
        //});

</script>


        

<html>
    <head>
            <title></title>
      
    <style>

         /*menutab for projectCharter*/
.ui-tabs.ui-tabs-vertical .ui-widget-header {
    border: none;
}

.ui-tabs.ui-tabs-vertical .ui-tabs-nav li a {
    display: block;
    width: 100%;
    padding: 0.6em 2em;
    color: black;
}
.ui-tabs.ui-tabs-vertical.ui-tabs-nav li {
    clear: left;
    width: 100%;
    margin: 0.2em 0;
    border: 1px solid gray;
    border-width: 1px 1px 1px 1px;
    border-radius: 4px 0 0 4px;
    overflow: hidden;
    position: relative;
    right: -2px;
    z-index: 2;
    border-top-color: #ff6a00;
}

.ui-tabs.ui-tabs-vertical .ui-tabs-nav li a:hover {
    cursor: pointer;
}
.ui-tabs.ui-tabs-vertical .ui-tabs-nav li.ui-tabs-active {
    margin-bottom: 0.2em;
    padding-bottom: 0;
    border-right: 1px solid white;
}
.ui-tabs.ui-tabs-vertical .ui-tabs-nav li:last-child {
    margin-bottom: 10px;
}
.ui-tabs.ui-tabs-vertical .ui-tabs-panel {
    float: left;
    width: 28em;
    border-left: 1px solid gray;
    border-radius: 0;
    position: relative;
    left: -1px;
}
.ui-tabs.ui-tabs-vertical .ui-tabs-nav {
    float: left;
    width: 13em;
    background: #fbecd5;
    border-radius: 4px 0 0 7px;
    border-right: 1px solid gray;
    border-top-color: #e88a05;
}
.ui-helper-reset {
    margin: 0;
    padding: 0;
    border: 0;
    outline: 0;
    line-height: 1.6;
    text-decoration: none;
    font-size: 100%;
    list-style: none;
}
.ui-state-default a, .ui-state-default a:link, .ui-state-default a:visited {
    text-decoration: none;
}
.ui-tabs .ui-tabs-nav li {
    list-style: none;
    float: left;
    position: relative;
    top: 0px;
    margin: 1px .2em 0 0;
    border-bottom-width: 0px;
    padding: 0;
    /*white-space: nowrap;*/
  
    /*list-style: none;
    float: left;
    position: relative;
    top: 0px;
    margin: 1px .2em 0 0;
    border-bottom-width: 0px;
    padding: 0;*/
    width: 95%;
}

.ui-tabs.ui-tabs-vertical .ui-tabs-nav {
    float: left;
    width: 13em;
    background: #fbecd5;
    border-radius: 4px 0 0 7px;
    border-right: 1px solid gray;
    border-top-color: #e88a05;
    /*margin-left: 8%;*/
}

.ui-tabs.ui-tabs-vertical {
    padding: 0;
    width: 84% !important;
    margin-top: 1%;
    border-color: #e88a05;
    margin-left: 6%;
    margin-bottom: 1%;
}



#DivMain
{
    overflow: auto;
   
    background-color:#f6eee4;
    
   
    width: 99.99%;
    height: 517px;


}
 /* end of menutab for projectCharter*/

#countdown {
    width: 53%;
    border: NONE;
    float: right;
    margin-right: 178%;
    background-color: #f6eee4;
    font-size:13px;
}


 #countdown1 {
    width: 53%;
    border: NONE;
    float: right;
    margin-right: 178%;
    background-color: #f6eee4;
    font-size:13px;
}

        #SearchKeyDiv {
            height: 65px;
            width: 146px;
            /*border: 1px solid grey;*/
            /*overflow: auto;*/
            /*position: relative;*/
            display: block;
            /*height: 60px;
    width: 140px;*/
            overflow: auto;
            right: 247px;
            position: fixed;
            bottom: 534PX;
                /*656px;*/
            margin-left: 982px;
        }






</style>
  </head>
   <% CommonFunctions.General.PlotPageHeadTag("Project Charter")%>
       
<body class="clsBody" MS_POSITIONING="GridLayout" onmouseup="Doc_OnmouseUp()" style="overflow:auto" >

    <form id="frmProjectCharter" name="frmProjectCharter" method="post" runat="server">
            <%PageInit()%>

           <div id='SearchKeyDiv' style="overflow:auto;position:relative">
		   </div>

    </form>
   

</body>
</html>

   
<script>

    function CheckData(strURL,MasterTagID,ParentTagID,strFocusOnControl)
    {    
        //start .Added mode option in parameter list to the function         
        var blnPROGFlag = (arguments.length > 5)?arguments[5]:0;
        //End
        var strResult;
        var strNavigator;
        g_sResponseText='';
        strNavigator = navigator.appName;
        strNavigator = strNavigator.toUpperCase();	
			
		
        strURL="../Enhancement/Customer_XMLHttp.aspx?MasterTagID=" + 	MasterTagID + "&ParentTagID=" +ParentTagID + "&" + strURL;
		

        if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
        { 
            g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
            //hook the event handler
            g_oValidateXMLHttp.onreadystatechange = GetText();
            //prepare the call, http method=GET, false=asynchronous call
            g_oValidateXMLHttp.open("GET",strURL, false);
            //finally send the call
            g_oValidateXMLHttp.send();         
        } 
        else 
        { 
            // Mozilla - based browser 
            g_oValidateXMLHttp = new XMLHttpRequest(); 
            //hook the event handler
            g_oValidateXMLHttp.onreadystatechange = GetText();
            //prepare the call, http method=GET, false=asynchronous call
            g_oValidateXMLHttp.open("GET",strURL, false);
            //finally send the call
            g_oValidateXMLHttp.send(null);
        }				

        /*g_oValidateXMLHttp = null;

        if(isBlank(g_sResponseText)==false)
        {
            var blnValidateData = (arguments.length > 4)?arguments[4]:true;
            
            if (blnValidateData == true)
            {
			    //alert(g_sResponseText);
			    g_sResponseText = '';
			    var objCtr = GetObjectReference('',strFocusOnControl);
			    if(objCtr) {objCtr.focus();}
			    return false;
			}
			if (blnValidateData == false) //i.e. ReturnData
            {
                return g_sResponseText;
            }
		}
		return true;*/
        if ( g_oValidateXMLHttp.responseText != null)
        {
            strResult = g_oValidateXMLHttp.responseText;
        } 
        return strResult;
    }

    // START OF CODING BY PS
    /*
    function returnData(strURL,MasterTagID,ParentTagID,strFocusOnControl)
    {
            var strNavigator;
            g_sResponseText='';
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();		
            strURL="../General/AjaxValidation.aspx?MasterTagID=" + 	MasterTagID + "&ParentTagID=" +ParentTagID + "&" + strURL;
    
            if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            { 
                g_oValidateXMLHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText;
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET",strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send();         
            } 
            else 
            { 
                // Mozilla - based browser 
                g_oValidateXMLHttp = new XMLHttpRequest(); 
                //hook the event handler
                g_oValidateXMLHttp.onreadystatechange = GetResponseText();
                //prepare the call, http method=GET, false=asynchronous call
                g_oValidateXMLHttp.open("GET",strURL, false);
                //finally send the call
                g_oValidateXMLHttp.send(null);
            }				
    
            g_oValidateXMLHttp = null;
    
            if(isBlank(g_sResponseText)==false)
            {
                return g_sResponseText;
            }
            return true;
    }
    */
    //END OF CODING BY PS

    function GetText()
    {
   
        if (g_oValidateXMLHttp.readyState==4)
        {
            if (g_oValidateXMLHttp.responseText != null)
            {			
                g_sResponseText = g_oValidateXMLHttp.responseText;
            }
        }		
    }


  
    var objform = document.getElementById("frmProjectCharter")
    function Save_OnClick()
    {
        if  (document.getElementById("textName").value == '')
        {
            alert('"Project Title" Should not be left blank');
            document.getElementById('textName').focus();
           //  $('#textName').css('border-color', 'grey');//RED

            return false;
        }

        if  (document.getElementById("projectCode").value == '')
        {
            alert('"Project Code" Should not be left blank');
            document.getElementById('projectCode').focus();
            return false;
        }

        if  (document.getElementById("TEXTDescription").value == '')
        {
            alert('"Project Description" Should not be left blank');
            document.getElementById('TEXTDescription').focus();

            return false;
        }
      

        if  (document.getElementById("Customer").value == '')
        {
            alert('"Customer Name" Should not be left blank');
            document.getElementById('Customer').focus();
            return false;
        }

        if  (document.getElementById("textBNeed").value == '')
        {
            alert('"Business Need" Should not be left blank');
            document.getElementById('textBNeed').focus();
            return false;
        }
              
           
        if  (document.getElementById("Initiatedby").value == '')
        {
            alert('"Inititated by" Should not be left blank');
        document.getElementById('Initiatedby').focus();
            return false;
        }
    
    
    
        if  (document.getElementById("textBlack").value == '')
        {
            alert('"Background" Should not be left blank');
            document.getElementById('textBlack').focus();
            return false;
        } 
        //if  (document.getElementById("strapproved").value == '')
        //{
        //    alert('"Approved by" Should not be left blank');
        //document.getElementById('strapproved').focus();
        //    return false;
        //}

        if  (document.getElementById("textSOW").value == '')
        {
            alert('"StateMent Of Work" Should not be left blank');
            document.getElementById('textSOW').focus();
            return false;
        }

        //if  (document.getElementById("strDateControlName").value == '')
        //{
        //    alert('"Initiated Date" Should not be left blank');
        // document.getElementById('strDateControlName').focus();
        //    return false;
        //}

        if  (document.getElementById("txtCandA").value == '')
        {
            alert('"Constraints and Assumptions" Should not be left blank');
             document.getElementById('txtCandA').focus();
            return false;
        }

        //if  (document.getElementById("ApprovalDate").value == '')
        //{
        //    alert('"Approval Date" Should not be left blank');
       // document.getElementById('ApprovalDate').focus();
        //    return false;
        //}
 
         // var UserName = '<%=Session("strUserName")%>';
          // document.getElementById("Initiatedby").value= <%=UserName%>
        //Added by Tejal D date 12/10/2016 for FOR SAVE ISSUE 
 
        var MenuTags = document.getElementsByTagName('A');
        for (i = 0; i < MenuTags.length; i++) {
            if (MenuTags[i].className == "Menu") {
                //MenuTags[i].style.display= "none";
                MenuTags[i].parentNode.style.display = "none";
            }
        }
        setFrameLoader();
        //End of Addtion by tejal Deshmukh date 12/10/2016  FOR SAVE ISSUE 

                    objform.action ="ProjectCharter.aspx?Mode=SAVE"
                    objform.submit();
                    if(<%=insertFlag%> == 0)               // if(<%=insertFlag%> == 1) PERVIOUS 
                   {
                        alert('Data Save Successfully!!!!!!');
                   }
         
                //<script language="javascript" type="text/javascript">
       
            
             
               }

         


</script>