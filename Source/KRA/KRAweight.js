
//function:OnSaveValidation
//purpose :Validate the Rule Before Save

function OnSaveWeight(X)
{
	alert("Hi");
}
	/*var StartTextboxObj=document.getElementsByName("DefaultWeight");
	var EndTextboxObj=document.getElementsByName("DefaultWeight");
	//var AppliedObj=document.getElementsByName("AppliedValue");
	var count=1;
	var ubound=StartTextboxObj.length-1;
	
	for(count=0;count<=ubound;count++)
	{   //Check till end of all weights
		//if (isBlank(StartObj[count].value)==false)
		//{	//validation for  frist  subrule is zero	
			if(StartTextboxObj[0].value!=0)			   
				return false;		
				
			//validation for is end of subrule	
			if(isBlank(EndObj[count+1].value)==false  )
			{	//check endRange of subRule is 1 less then start range of immediate next subrule start
				if(EndObj[count].value+1 == StartObj[count+1])
					return false;							
			}
			else
			{	//if subrule is last subrule then check end range for that subrule is 100
			    if(EndObj[count].value!=100)
			       return false;
			    
			    
			}			
			//check start range is less than endRange
			if(disallowValue1GreaterThanOrEqualToValue2(StartObj[count],EndObj[count],'Message'))			
				return false;
				
			
				
		}	
	}
	
	return true;
}


/*function validateCR_StartRange(x)
{
}*/
function validateCR_StartRange(x)
{	
	var startIndex=parseInt(x.substring(10,x.length));
    var obj=document.getElementById(x);
    var StartObj=document.getElementsByName("StartRange");
	var EndObj=document.getElementsByName("EndRange");
	var AppliedObj=document.getElementsByName("AppliedValue");
	var count=1;
	var i=1;
	var ubound=StartObj.length-1;
	var endIndex=startIndex-3;//get endindex of cross endrang
	startIndex=startIndex/4;
	endIndex=endIndex-1;
	endIndex=endIndex/4;
	//update endrange
	
	if(startIndex!=0)
		{
			EndObj[endIndex].value=parseInt(StartObj[startIndex].value) - 1;	
			if(isBlank(StartObj[startIndex])==false)
			{		
				if(disallowValue1GreaterThanOrEqualToValue2(StartObj[startIndex-1],StartObj[startIndex],'start range must be greter than privous one ')==false)
				{
	
					
				}		
			}	
		}
		
		
	
	
	
	//alert for positive & numeric value
	if(isBlank(obj.value)==true)
	{		
			alert('Blank is not allow');
			obj.focus();
			
	}
	//check for only integer
	if(isInteger(obj.value)==false)
	{	alert('Enter Positive Integer Value');
		obj.value="";
		obj.focus();
	}
	//check for range between 0 to 99
		if(disallowValueRangeViolation(obj,0,99)==true)
			{
					alert('Enter no between 0 to 99 Value');
  		     }

   
}
//-----------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------
/*function  validateCR_EndRange(x)
{
}*/
function validateCR_EndRange(x)
{			
            var EndIndex=parseInt(x.substring(8,x.length));
            //alert(EndIndex);
           EndIndex=EndIndex-1;
            EndIndex=EndIndex/4;
           // alert('value of end index')
           // alert(EndIndex);
			var obj=document.getElementById(x);
			var StartObj=document.getElementsByName("StartRange");
			var EndObj=document.getElementsByName("EndRange");
			var AppliedObj=document.getElementsByName("AppliedValue");
			var count=1;
			var ubound=StartObj.length-1;
			//EndIndex=EndIndex/4;
			for(count=0;count<=ubound;count++)
			{
					if (isBlank(EndObj[count].value)==true)
						break;	
			}
			//check user enter value between 1 to 100
			 if(disallowValueRangeViolation(obj,0,101)==true)
			{
					alert('Enter no between 1 to 100 Value');
					return;
			}
			
			
			
	//alert for end range is greater than start range
	disallowValue1GreaterThanOrEqualToValue2(StartObj[EndIndex],EndObj[EndIndex],'end range greter than start range ');
	
		
	//endrange value greter than privous end range
	if(EndIndex>=1)
	{		
			disallowValue1GreaterThanOrEqualToValue2(EndObj[EndIndex-1],EndObj[EndIndex],'endrange value greter than privous endrange ');
			return;
			
	}	
  
   
	
	//check for integer
	if(isInteger(obj.value)==false)
	{	alert('Enter Positive Integer Value');
		obj.value="";
		obj.focus();
		return;
	}
	//alert for positive & numeric value
	if(isBlank(StartObj[EndIndex]==false))
	{
		if(isBlank(obj.value)==true)
		{		
				alert('Blank is not allow');
				obj.focus();
		}	
	}
	
	if(obj.value!="")
	{
		if(isInteger(obj.value)==false)
		 {		
			
			
			alert('Enter Positive Integer Value');
			obj.value="";
			obj.focus();
			return;
		
		}
   }
   
  
//------------------------------------------------------------------------------------------------------------	
	//if user enter 100 in end range disable all text box below that subrule 
	var temp=EndIndex+1;
	//set next startrange value to endindex +1
	
	if(EndObj[EndIndex].value<100)
	
	{
			
			StartObj[EndIndex+1].value=parseInt(EndObj[EndIndex].value)+1;
	}
	
	if(obj.value==100)
		{	
			
			alert('in 100 disable true')
			for(;temp<=ubound;temp++)
			{
					EndObj[temp].disabled=true;
					StartObj[temp].disabled=true;
					AppliedObj[temp].disabled=true;
					
			}
		}
	//if there is no 100 value in endRange then enable all text box
	if(obj.defaultValue==100)
	{
		alert('in 100')
		for(;temp<=ubound;temp++)
		{
							EndObj[temp].disabled=false
							StartObj[temp].disabled=false
							AppliedObj[temp].disabled=false
		}
	}
	
	  
} //end of function

//----------------------------------------------------------------
/*function validateCR_AppliedRange(x)
{
}*/
function validateCR_AppliedRange(x)
{	
	
	 var AppliedIndex=parseInt(x.substring(12,x.length));
	 
     var obj=document.getElementById(x);
     var StartObj=document.getElementsByName("StartRange");
	 var EndObj=document.getElementsByName("EndRange");
	 var AppliedObj=document.getElementsByName("AppliedValue");
	 var count=1;
	 var ubound=StartObj.length-1;
	 AppliedIndex=AppliedIndex-2;
	 AppliedIndex=AppliedIndex/4;
	
	
	
	/*for(count=0;count<=ubound;count++)
	{
		if (isBlank(AppliedObj[count].value)==true)
		break;	
	}
	
	
	//set start range of next subrule to privous range plus 1 
	//check whether next range is blank
	if(isBlank(StartObj[count-1].value)==false)
	{
			if(EndObj[count-1].value<100)
			{
				StartObj[count].value=parseInt(EndObj[count-1].value) + 1;
				EndObj[count].focus();
			}
   }*/
  
  disallowBlank(obj,'in blank');
  
  //Appliedvalue   value greter than privous Applied value
	if(AppliedIndex>=1)
	{		
			disallowValue1GreaterThanOrEqualToValue2(AppliedObj[AppliedIndex-1],AppliedObj[AppliedIndex],'Applied value greter than privous Applied value ');
			return;
			
	}	
	//check user enter value between start range and end range
			 if(disallowValueRangeViolation(obj,StartObj[AppliedIndex].value,EndObj[AppliedIndex].value)==true)
			{
					alert('Enter applied value between start range & end range ');
					return;
			}
  
   EndObj[AppliedIndex+1].focus();
   
}*/

