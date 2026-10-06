<%@ Page Language="vb" AutoEventWireup="false" Codebehind="HR_TemplateMaster_CommonPage.aspx.vb" Inherits="PbNIT.HR_TemplateMaster_CommonPage" %>

<SCRIPT type="text/javascript" >
    var yy=3;
    function Applicable_Click(id,value)
    {
    
      var objApplicable = GetObjectReference("frmCommonPage","chkIsApplicable",true); 
      var objOrderNumber=GetObjectReference("frmCommonPage","txtOrderNumber_"+value);
      var objtxtMaxLimit=GetObjectReference("frmCommonPage","txtMaxLimit_"+value);
      var arrOrderNumber=new Array(); 
      var objTemplateSectionID=document.getElementById ("txtHidstrTemplateSectionID");
      var TemplateSectionID;
      var TemplateSectionIDs =new Array();
      var loopCount=0;
      TemplateSectionID=objTemplateSectionID.value;
      TemplateSectionIDs=TemplateSectionID.split(",");
      var J=0;
     
      
      for(var i=0;i<objApplicable.length;i++)
      {
        var objtxtMaxLimit=GetObjectReference("frmCommonPage","txtMaxLimit_"+objApplicable(i).value);
         var objOrderNumber=GetObjectReference("frmCommonPage","txtOrderNumber_"+objApplicable(i).value);
       if(objApplicable(i).checked==true)
       {
         objtxtMaxLimit.disabled=false;
         objOrderNumber.disabled=false;
       }
       else if(objApplicable(i).checked==false)
       {
         
         objtxtMaxLimit.disabled=true;
         objOrderNumber.disabled=true;
       }
      }
      //  alert(objApplicable.value);
      // if(objtxtMaxLimit.disabled==true)
      //{
      //   objtxtMaxLimit.disabled=false;
      // }
     if (objApplicable.checked==false)
     {
       objtxtMaxLimit.value="0";
     }
      
     for(J=0;J<objApplicable.length;J++) 
     {
        arrOrderNumber[J]=objOrderNumber.value;
     } 
     var i = 0;
     var OrderNumber;
     for ( i=0;i<objOrderNumber.length;i++)
     {
     
         if (objApplicable[i].checked==true)
         {
         
            OrderNumber=TemplateSectionIDs[i];    
         } 
       }

     }  
function   ValidateControl()
{
   
      var objApplicable = GetObjectReference("frmCommonPage","chkIsApplicable",true); 
      var count;
      var countArray;
      var innerLoop;
      var outerLoop;
      countArray=0;
      var arrOrderNumber=new Array(); 
     
      for(count=0;count<objApplicable.length;count++)
      {
        if(objApplicable[count].checked==true)
        {
            var objOrderNumber=GetObjectReference("frmCommonPage","txtOrderNumber_"+objApplicable[count].value);
            var objtxtMaxLimit=GetObjectReference("frmCommonPage","txtMaxLimit_"+objApplicable[count].value);
            if(objOrderNumber.value=='')
            {
            alert("Order Number should not be blank.");
              objOrderNumber.focus();
            return;
            }
           else if(objtxtMaxLimit.value=='')
            {
             alert("Maximum Limit should not be blank.");
               objtxtMaxLimit.focus();
              return;
            }
            else if(isNumeric(objtxtMaxLimit.value)==false)
                    {
                        alert("Please enter the numeric value.");
                        objtxtMaxLimit.focus();
                        return;
                    }
            else  if(isNumeric(objOrderNumber.value)==false)
                    {
                        alert("Please enter the numeric value.");
                        objOrderNumber.focus();
                        return;
                    }      
        
           
           else if(parseInt(objtxtMaxLimit.value)<=0)
            {
            alert("Maximum Limit should be greater than zero.");
             objtxtMaxLimit.focus();
              return;
            }
           else if(parseInt(objOrderNumber.value)<=0)
            {
            alert("Order Number should be greater than zero.");
             objOrderNumber.focus();
              return;
            }
            else
            {
              arrOrderNumber[countArray]=objOrderNumber.value;
              countArray=countArray+1;
            }  
          }  
        }
//       for(outerLoop=0;outerLoop<arrOrderNumber.length;outerLoop++)
//       {
//        for(innerLoop=0;innerLoop<arrOrderNumber.length;innerLoop++)
//        {
//         if(outerLoop!=innerLoop)
//         {
//           if(arrOrderNumber[innerLoop]==arrOrderNumber[outerLoop])
//           {
//            alert("Order Number already exists.");
//            return;
//           }
//         }
//        }
//       }

                 return true; 
    }
                            
   </SCRIPT>
                     
                     
                     
                     
