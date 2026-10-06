//Function Name: DeSelect

//Purpose : Selecting Delecting "SELECT" CHECK BOX

//Input : current object

//Author : Manoj Dagde

//Assumption:

//Date: 19-Oct-2007

//Revision:

function DeSelect(id)

{ //alert('NInad');

var objChkSelect=GetObjectReference('frmCommonList','chkSelect',true)

var icount

//var check=document.getElementById(id)


for(icount=0;icount<objChkSelect.length;icount++)

{ 

objChkSelect[icount].checked=false


}

id.checked=true 

}

//Function Name: ValidateEmployeeWeight

//Purpose : Used for balancing weight

//Input : current object

//Author : Manoj Dagde

//Assumption:

//Date: 19-Oct-2007

//Revision:

//var WeightLimit=100

var WeightSum=0;

function ValidateEmployeeWeight(obj)

{ 

var i;

var totalWeight;


//To get balance weight Textbox Value 

var balance=GetObjectReference('frmCommonPage','Total');

var weights=document.getElementsByName("Weight");

for(i=0;i<weights.length;i++)

{

totalWeight=parseInt(weights[i].value);

WeightSum=parseInt(WeightSum)+totalWeight;


}


if(parseInt(WeightSum)>100)

balance.style.color='red';

else

balance.style.color='black';


balance.value=WeightSum;

WeightSum=0;

}

 

 

 

 

 

 

 

 

//----------------------------------------------------------------------------

//Created By : ShraddhaJ

//Date : 18 Oct 2007

//Description : To validate the weight in summation of 100

//-----------------------------------------------------------------------------

var limit=100

var sum=0;

function ValidateWeight(x)

{ 

var i;

var totalweight;


//To get balance weight Textbox Value 

var balance=GetObjectReference('frmCommonPage','Total');

var weights=document.getElementsByName("DefaultWeight");

for(i=0;i<weights.length;i++)

{

totalweight=parseInt(weights[i].value);

sum=parseInt(sum)+totalweight;

/*if( isBlank(weights[i].value)==false)

sum+=ParseInt(weights[i].value);

*/ 

}


if(parseInt(sum)>100)

balance.style.color='red';

else

balance.style.color='black';


balance.value=sum;

sum=0;

/*


if(balance.value<0)

balance.style.color='red';

else

balance.style.color='black';

if(limit>=0)

{

limit=limit-x.value

//alert('Now enter weight in limit :' + parseInt(limit));

}

if(balance.value==0)

{

balance=0;

}

balance.value=limit;

*/

}

//----------------------------------------------------------------------------

//Ended By : ShraddhaJ

//Date : 18 Oct 2007

//-----------------------------------------------------------------------------

//----------------------------------------------------------------------------

//Created By : KunalL

//Date : 18 Oct 2007

//Description : To validate the all text box on save

//-----------------------------------------------------------------------------

function OnSaveValidation()

{

var StartObj=document.getElementsByName("StartRange");

var EndObj=document.getElementsByName("EndRange");

var AppliedObj=document.getElementsByName("AppliedValue");

var count=0;

var ubound=StartObj.length-1;

//following while loop find index where 100 value locate in endRange text box

//if endRange textBox not contain ,then rule is not completed hence return false 

//if contain 100 then it indicate end of rule ,hence count give length of subrule 

while(EndObj[count].value!=100)

{

count++;

if(count>ubound)

{

alert("Rule must be end with 100 value ");

return(false);

} 

}

//following for loop check whether textbox contain blank field 

//and endrange value is less than start range value 

for(var i=0;i<count;i++)

{ //CHECK ANY FIELD CONTAIN 0 VALUE

if(EndObj[i].value=="")

{

alert('Please insert value ');

return false;

}

if(StartObj[i].value=="")

{

alert('Please insert value ');

return false;

}


if(AppliedObj[i].value=="")

{

alert('Please insert value ');

return false;

}

if(StartObj[i]>EndObj[i])

{ 

alert('Start range is greter than end range ')

return false;

}



}

//following for loop check for non zero and 


for(var i=0;i<count;i++)

{

if(i>0)

{

if(StartObj[i]<EndObj[i-1])

{ alert('check start range and end range')

StartObj[i].focus();

return false;

}

if(StartObj[i].value<=StartObj[i-1].value||EndObj[i].value<=EndObj[i-1].value)

{

alert('StartRange Vlaue or EndRange Value less than last one ')

StartObj[i].focus();

return false;

}


if(StartObj[i].value==0||EndObj[i].value==0)

{

alert(' Only frist stratRange value contain zero');


return flase;

}

}

}

return true;

}

//----------------------------------------------------------------------------

//Ended By : KunalL

//Date : 18 Oct 2007

//-----------------------------------------------------------------------------

 

//----------------------------------------------------------------------------

//Created By : KunalL

//Date : 18 Oct 2007

//Description : To validate the StartRange Text Box

// these function call onblur event of StartRange text box

//-----------------------------------------------------------------------------

function validateCR_StartRange(x)

{ 

//the name to stratRange text box is "StartRang"+count.to string 

//to get that count here substring is used 

var startIndex=parseInt(x.substring(10,x.length));

//alert(startIndex)

//to get refence of currnt text box

var obj=document.getElementById(x);

var StartObj=document.getElementsByName("StartRange");

var EndObj=document.getElementsByName("EndRange"); 

var AppliedObj=document.getElementsByName("AppliedValue");

var count=1;

var i=1;

var ubound=StartObj.length-1;

//get endindex of cross endrang

//var endIndex=startIndex-3;

//var endIndex=

//textbox are in the form array to get current text box id diveded it by 4

//e.g: 0 1 2

// 4 5 6

// 8 9 10

//suppose current text box index is 4 by deviding 4 it give index for current

// text to acces in array of getElementsByName("StartRange"); 

startIndex=startIndex/3;

//endIndex=endIndex-1;

//endIndex=stra;


//check check box is blank or not

if(obj.value=="")

{

alert('Please insert Value');

return;

}


//check for range between 0 to 99

if(disallowValueRangeViolation(obj,0,99)==true)

{

alert('Enter no between 0 to 99 Value');

return;

}




//check startRange value greter than privous startrange 

if(startIndex>=1)

{ 

if(disallowValue1GreaterThanOrEqualToValue2(StartObj[startIndex-1],StartObj[startIndex],'StartRange value greter than previous StartRange value ')==true)

{

return;

}

} 





//check box index is not frist row then update last endrange value 


if(startIndex>=1)

{ 

EndObj[startIndex-1].value=parseInt(StartObj[startIndex].value) - 1; 


} 


}//end of function

//----------------------------------------------------------------------------

//Ended By : KunalL

//Date : 18 Oct 2007

//-----------------------------------------------------------------------------

 

//----------------------------------------------------------------------------

//Created By : KunalL

//Date : 18 Oct 2007

//Description : To validate the EndRange Text Box

//-----------------------------------------------------------------------------

function validateCR_EndRange(x)

{ 

var EndIndex=parseInt(x.substring(8,x.length));

// alert(EndIndex);

EndIndex=EndIndex-1;

// alert(EndIndex);

EndIndex=EndIndex/3;

//alert(EndIndex);

var obj=document.getElementById(x);

var StartObj=document.getElementsByName("StartRange");

var EndObj=document.getElementsByName("EndRange");

var AppliedObj=document.getElementsByName("AppliedValue");

var count=1;

var ubound=StartObj.length-1;


//chek for blank field


/*if(disallowBlank(obj,'Please insert the value')==true)

{

return;

}*/

if(obj.value=="")

{

alert('Please insert value ');

return;

}

//check user enter value between 1 to 100

if(disallowValueRangeViolation(obj,0,101)==true)

{

alert('Enter no between 1 to 100 Value');


return;

}

//check user enter 100 in end range then all text box below make disabled 

var temp=EndIndex+1; 

if(obj.value==100)

{ 



for(;temp<=ubound;temp++)

{ EndObj[temp].value="";

EndObj[temp].disabled=true;

StartObj[temp].value="";

StartObj[temp].disabled=true;

AppliedObj[temp].value="";

AppliedObj[temp].disabled=true;


}

}

//if there 100 value in endRange then enable all text box

var flag=false;

//these loop check whether check box contain 100 value then set flag 

for(var i=0;i<=EndIndex;i++)

{

if(EndObj[i].value==100)

{

falg=true;
//alert(EndObj[i].value);
AppliedObj[i].value=100;

}

}

//these if check flag is false ,false indicate end range colomn not contain 100 value hence visible all text box 

if(flag==false)

{

for(;temp<=ubound;temp++)

{

EndObj[temp].disabled=false

StartObj[temp].disabled=false

AppliedObj[temp].disabled=false

}


}






//alert for end range is greater than start range

if(disallowValue1GreaterThanOrEqualToValue2(StartObj[EndIndex],EndObj[EndIndex],'end range greter than start range '))

{

return;

}




//endrange value greter than privous end range

/*if(EndIndex>=1)

{ 

if(disallowValue1GreaterThanOrEqualToValue2(EndObj[EndIndex-1],EndObj[EndIndex],'endrange value greter than privous endrange ')==true)

{

return;

}

}*/


//if end range value is less than 100 then there is one row below that text box hence set value of next startrange text box 

//alert('before 100');

if(EndObj[EndIndex].value<100)

{ //alert(EndIndex);

//alert('in 100');

StartObj[EndIndex+1].value=parseInt(EndObj[EndIndex].value)+1;

} 


} //end of function

//---/-------------------------------------------------------------------------

//Ended By : KunalL

//Date : 18 Oct 2007

//-----------------------------------------------------------------------------

 

//----------------------------------------------------------------------------

//Created By : KunalL

//Date : 18 Oct 2007

//Description : To validate the AppliedRange Text Box

//-----------------------------------------------------------------------------

function validateCR_AppliedRange(x)

{ 


var AppliedIndex=parseInt(x.substring(12,x.length));

//alert(AppliedIndex)

var obj=document.getElementById(x);

var StartObj=document.getElementsByName("StartRange");

var EndObj=document.getElementsByName("EndRange");

var AppliedObj=document.getElementsByName("AppliedValue");

//alert(AppliedIndex)

var ubound=StartObj.length-1;

AppliedIndex=AppliedIndex-2;

AppliedIndex=AppliedIndex/3;


//alert(AppliedIndex)


//chek for blank field


/*if(disallowBlank(obj,'Please insert the value')==true)

{

return;

}*/

if(obj.value=="")

{

alert('Please insert value ');

}


//check Appliedvalue value greter than privous Applied value

if(AppliedIndex>=1)

{ 

disallowValue1GreaterThanOrEqualToValue2(AppliedObj[AppliedIndex-1],AppliedObj[AppliedIndex],'Applied value greter than previous Applied value ');

return;


} 

//check user enter value between start range and end range

if(disallowValueRangeViolation(obj,0,100)==true)

{

alert('Enter applied value between 0 & 100 ');

return;

}




}

//----------------------------------------------------------------------------

//Ended By : KunalL

//Date : 18 Oct 2007

//-----------------------------------------------------------------------------


//----------------------------------------------------------------------------

//Created By : ManojD

//Date : 5 FEB 2008

//Description : To validate the Rating  Text Box On Kra Rating form

//-----------------------------------------------------------------------------


function ValidateRating()
{
var objRating1 = GetObjectReference('frmCommonPage','Rating1',true);
var obj1 = GetObjectReference('frmCommonPage','Rating1');
var objRating2 = GetObjectReference('frmCommonPage','Rating2',true);
var obj2 = GetObjectReference('frmCommonPage','Rating2');
var objRating3 = GetObjectReference('frmCommonPage','Rating3',true);
var obj3 = GetObjectReference('frmCommonPage','Rating3');
var i;
if(obj1.type!="hidden")
{
	if(objRating1)
	{
		for(i=0;i<objRating1.length;i++)
		{
			if(objRating1[i].value=="")
			{
				objRating1[i].focus();return 1;
			}
			else if(isInteger(objRating1[i].value)!=true)
			{
				objRating1[i].focus();return 2;
			}
			else if(parseInt(objRating1[i].value)>100)
			{
				objRating1[i].focus();return 3;
			}
			else if(parseInt(objRating1[i].value)<0)
			{
				objRating1[i].focus();return 4;
			}
		}
	}
}

if(obj2.type!="hidden")
{
	if(objRating2)
	{
		for(i=0;i<objRating2.length;i++)
		{	
			if(objRating2[i].value=="")
			{
				objRating2[i].focus();
				return 1;
			}
			else if(isInteger(objRating2[i].value)!=true)
			{
				objRating2[i].focus();
				return 2;
			}
			else if(parseInt(objRating2[i].value)>100)
			{
				objRating2[i].focus();
				return 3;
			}
			else if(parseInt(objRating2[i].value)<0)
			{
				objRating2[i].focus();return 4;
			}
		}
	}
}

if(obj3.type!="hidden")
{
	if(objRating3)
	{
		for(i=0;i<objRating3.length;i++)
		{
			if(objRating3[i].value=="")
			{
				objRating3[i].focus();
				return 1;
			}
			else if(isInteger(objRating3[i].value)!=true)
			{

				objRating3[i].focus();
				return 2;
			}
			else if(parseInt(objRating3[i].value)>100)
			{
				objRating3[i].focus();
				return 3;
			}
			else if(parseInt(objRating3[i].value)<0)
			{
				objRating3[i].focus();return 4;
			}
		}
	}
}


}


//----------------------------------------------------------------------------

//End By : ManojD

//Date : 5 FEB 2008

//-----------------------------------------------------------------------------

