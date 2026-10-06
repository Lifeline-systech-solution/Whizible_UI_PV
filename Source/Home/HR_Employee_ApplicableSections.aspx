<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_Employee_ApplicableSections.aspx.vb" Inherits="PbNIT.HR_Employee_ApplicableSections" %>

<html>
<%  CommonFunctions.General.PlotPageHeadTag("Employee Sections")%> 
<body MS_POSITIONING="GridLayout" class='clsBody' onresize="window_onresize()" onload="window_onload()">
    <form id="frmHR_Employee_ApplicableSections"  name="frmHR_Employee_ApplicableSections" runat="server">
        <%InitPage%>
    </form>

<script language =javascript >
    
    var objfrm = GetFormReference('frmHR_Employee_ApplicableSections');
    var objDivMain = GetObjectReference('frmHR_Employee_ApplicableSections','PageDiv');
    
    function window_onload()
	{
		var intDivHeight ;
	    if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 40;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight +'px';
			}
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objDivMain)
		{
			intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 50;
			if (intDivHeight < 100)	intDivHeight = 100;
			objDivMain.style.height = intDivHeight +'px';
		}
	}
	
    function Save_onClick()
    {
          /* var objHidMenuGroupID =  GetObjectReference('frmHR_Employee_ApplicableSections','txtHidMenuGroupIDs');
           var strMenuGroupID = objHidMenuGroupID.value;
           arrMenuGroupID = strMenuGroupID.split(",");
           
           var intCount = 0;
           var intCount2 = 0; 
           for(intCount=0;intCount<arrMenuGroupID.length;intCount++)
           {
                var objOrderNumber =  GetObjectReference('frmHR_Employee_ApplicableSections','txtOrderNumber_'+arrMenuGroupID[intCount]);
                var objchkApplicable = GetObjectReference('frmHR_Employee_ApplicableSections','chkIsAppicable_'+arrMenuGroupID[intCount]);
                //var objMaxControlLimit = GetObjectReference('frmHR_Employee_ApplicableSections','txtMaxControlLimit_'+arrMenuGroupID[intCount]);
               
                //if (objMaxControlLimit!= null)
               // {
                    if(objchkApplicable.checked==true)
                    {
                        /*if(objMaxControlLimit.value=='')
                        {
                            alert("Maximum items can not be blank.");
                            objMaxControlLimit.focus();
                            return;
                        }*/
                      /*  if(objOrderNumber.value=='')
                        {
                            alert("Order number can not be blank.");
                            objOrderNumber.focus();
                            return;
                        }
                    
                    
                        /*if(isNumeric(objMaxControlLimit.value)==false)
                        {
                            alert("Please enter the numeric value.");
                            objMaxControlLimit.focus();
                            return;
                        }*/
                    
                        /*if(parseInt(objMaxControlLimit.value)>10)
                        {
                            alert("Maximum items can not be greater than 10.");
                            objMaxControlLimit.focus();
                            return;
                        }
                    
                    
                        if(parseInt(objMaxControlLimit.value)<0)
                        {
                            alert("Please enter the positive numeric value.");
                            objMaxControlLimit.focus();
                            return;
                        }*/
                    
                       /* if(isNumeric(objOrderNumber.value)==false)
                        {
                            alert("Please enter the numeric value.");
                            objOrderNumber.focus();
                            return;
                        }
                    
                        if(parseInt(objOrderNumber.value)<0)
                        {
                            alert("Please enter the positive numeric value.");
                            objOrderNumber.focus();
                            return;
                        }
                    }    
                //}    
             }  
            
           for(intCount=0;intCount<arrMenuGroupID.length;intCount++)
           {
                for(intCount2=0;intCount2<arrMenuGroupID.length;intCount2++)
                {
                        if(intCount!=intCount2)
                        {
                             var objOrderNumber1 =  GetObjectReference('frmHR_Employee_ApplicableSections','txtOrderNumber_'+arrMenuGroupID[intCount]);    
                             var objOrderNumber2 =  GetObjectReference('frmHR_Employee_ApplicableSections','txtOrderNumber_'+arrMenuGroupID[intCount2]);    
                             
                             var objchkIsAppicable1 =  GetObjectReference('frmHR_Employee_ApplicableSections','chkIsAppicable_'+arrMenuGroupID[intCount]);    
                             var objchkIsAppicable2 =  GetObjectReference('frmHR_Employee_ApplicableSections','chkIsAppicable_'+arrMenuGroupID[intCount2]);    
                             
                             if(objchkIsAppicable1.checked==true && objchkIsAppicable2.checked==true)
                             {
                                if(parseInt(objOrderNumber1.value) == parseInt(objOrderNumber2.value))
                                {
                                    alert("Please enter the distinct order numbers.");
                                    objOrderNumber1.focus();
                                    return; 
                                }
                             }
                        }
                }
           }    
            */
                      
            objfrm.action = "HR_Employee_ApplicableSections.aspx?Mode=Save";
			objfrm.submit();
    }
    
    function Close_OnClick()
    {
        window.close();
    }

    /*function Applicable_OnCheck(intMenuGroupID)
    {
        var objChkIsAppicable = GetObjectReference('frmHR_Employee_ApplicableSections','chkIsAppicable_'+intMenuGroupID);
        //var objtxtMaxControlLimit = GetObjectReference('frmHR_Employee_ApplicableSections','txtMaxControlLimit_'+intMenuGroupID);
        var objtxtOrderNumber = GetObjectReference('frmHR_Employee_ApplicableSections','txtOrderNumber_'+intMenuGroupID);
        if(objChkIsAppicable!= null)
        {
            if(objChkIsAppicable.checked==true)
            {
                //objtxtMaxControlLimit.disabled=false;
                 objtxtOrderNumber.disabled=false;
            }
            else
            {
                 //objtxtMaxControlLimit.disabled=true;
                  objtxtOrderNumber.disabled=true;
            }
        } 
    }*/
    
    
    
</script>

</body>
</html>

