// ===================================================================
// Author: Bhagirath Team (UmeshJ,AshishR,RajK)
// ===================================================================
var defaultDateFormat = "d-MMM-y"
//-------------------------------------------------------------------
// Trim functions
//   Returns string with whitespace trimmed
//-------------------------------------------------------------------
function LTrim(str){
	if (str==null){return null;}
	for(var i=0;str.charAt(i)==" ";i++);
	return str.substring(i,str.length);
	}
function RTrim(str){
	if (str==null){return null;}
	for(var i=str.length-1;str.charAt(i)==" ";i--);
	return str.substring(0,i+1);
	}
function Trim(str){return LTrim(RTrim(str));}
function LTrimAll(str) {
	if (str==null){return str;}
	for (var i=0; str.charAt(i)==" " || str.charAt(i)=="\n" || str.charAt(i)=="\t"; i++);
	return str.substring(i,str.length);
	}
function RTrimAll(str) {
	if (str==null){return str;}
	for (var i=str.length-1; str.charAt(i)==" " || str.charAt(i)=="\n" || str.charAt(i)=="\t"; i--);
	return str.substring(0,i+1);
	}
function TrimAll(str) {
	return LTrimAll(RTrimAll(str));
	}
//-------------------------------------------------------------------
// isNull(value)
//   Returns true if value is null
//-------------------------------------------------------------------
function isNull(val){return(val==null);}

//-------------------------------------------------------------------
// isBlank(value)
//   Returns true if value only contains spaces
//-------------------------------------------------------------------
function isBlank(val){
	if(val==null){return true;}
	for(var i=0;i<val.length;i++) {
		if ((val.charAt(i)!=' ')&&(val.charAt(i)!="\t")&&(val.charAt(i)!="\n")&&(val.charAt(i)!="\r")){return false;}
		}
	return true;
	}

//-------------------------------------------------------------------
// isInteger(value)
//   Returns true if value contains all digits
//-------------------------------------------------------------------
function isInteger(val){
	if (isBlank(val)){return false;}
	var digits="1234567890";
	var firstDigits = "-1234567890";
	//First Digit Validation
	if (val.length==1 && val.charAt(0) == "-") {return false;}
	if (firstDigits.indexOf(val.charAt(0))==-1) { return false; }
	
	for (var i=1; i < val.length; i++) {
		if (digits.indexOf(val.charAt(i))==-1) { return false; }
		}
	return true;
	
	}

//-------------------------------------------------------------------
// isNumeric(value)
//   Returns true if value contains a positive float value
//-------------------------------------------------------------------
function isNumeric(val){return(parseFloat(val,10)==(val*1));}

//-------------------------------------------------------------------
// isArray(obj)
// Returns true if the object is an array, else false
//-------------------------------------------------------------------
function isArray(obj){return(typeof(obj.length)=="undefined")?false:true;}

//-------------------------------------------------------------------
// isDigit(value)
//   Returns true if value is a 1-character digit
//-------------------------------------------------------------------
function isDigit(num) {
	if (num.length>1){return false;}
	var string="1234567890";
	if (string.indexOf(num)!=-1){return true;}
	return false;
	}

//-------------------------------------------------------------------
//	refreshParent(parentFormName,submitToPage[,closeChildWindow])
//		Refresh the parent window
//		parentFormName		-	Parent Form Name
//		submitToPage		-	Submit to page name
//		closeChildWindow	-	Optional parameter
//								If true then close the window
//-------------------------------------------------------------------

//Commented and Added by Dhanashri S on 8 Dec 2015
//function refreshParent(parentFormName,parentPage,submitToPage) {
	//	var closeChildWindow=(arguments.length>3)?arguments[3]:false;
    //   	var strParentPage;
	//	strParentPage = new String();
	//	strParentPage = opener.location.href;
	//	// If the document loaded in the parent window is the Page to submit, then refresh the page.
	//	if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1)
	//	{
    //    	window.opener.document.forms[parentFormName].action = submitToPage;
    //    	try{window.opener.document.forms[parentFormName].submit();}catch(e){}//Modified By Ninad WAF3_PB_64
    //    	 if (closeChildWindow==true) { window.close(); }	
	//	}
       
	//}

	function refreshParent(parentFormName, parentPage, submitToPage) {
	    var closeChildWindow = (arguments.length > 3) ? arguments[3] : false;
	    var strParentPage;
	    strParentPage = new String();
	    //Added by Vinay on 10 DEC. 2008 WAF3_GEN_18 implement try catch block
	    try {
	        strParentPage = opener.location.href;
	        // If the document loaded in the parent window is the Page to submit, then refresh the page.
	        if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1) {
	            window.opener.document.forms[parentFormName].action = submitToPage;
	            try { window.opener.document.forms[parentFormName].submit(); } catch (e) { }//Modified By Ninad WAF3_PB_64	
	        }
	        if (closeChildWindow == true) { window.close(); }
	    }
	    catch (e) { }//Addition End by Vinay on 10 DEC. 2008 WAF3_GEN_18 implement try catch block

	}
//End of Comment and Addition by Dhanashri S on 8 Dec 2015

//-------------------------------------------------------------------

//-------------------------------------------------------------------
// setNullIfBlank(input_object)
//   Sets a form field to "" if it isBlank()
//-------------------------------------------------------------------
function setNullIfBlank(obj){if(isBlank(obj.value)){obj.value="";}}

//-------------------------------------------------------------------
// setFieldsToUpperCase(input_object)
//   Sets value of form field toUpperCase() for all fields passed
//-------------------------------------------------------------------
function setFieldsToUpperCase(){
	for(var i=0;i<arguments.length;i++) {
		arguments[i].value = arguments[i].value.toUpperCase();
		}
	}

//-------------------------------------------------------------------
// isSubstringExists(string,substring)
//  Check if sub string exists in the string
//-------------------------------------------------------------------
function isSubstringExists(str,subStr){
	if (str.indexOf(subStr) != -1) return true;
	return false;
}

//REPLACE fns..()
//-------------------------------------------------------------------
// replaceSubstring(value)
//   Returns string with replaced sub string by the replacement
//-------------------------------------------------------------------
function replaceSubstring(inputString, fromString, toString) {
    // Goes through the inputString and replaces every occurrence of fromString with toString
 	var temp = inputString;
	if (fromString == "") {
		return inputString;
	}
	if (toString.indexOf(fromString) == -1) { // If the string being replaced is not a part of the replacement string (normal situation)
		while (temp.indexOf(fromString) != -1) {
			var toTheLeft = temp.substring(0, temp.indexOf(fromString));
			var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
			temp = toTheLeft + toString + toTheRight;
		}
	} else { // String being replaced is part of replacement string (like "+" being replaced with "++") - prevent an infinite loop
		var midStrings = new Array("~", "`", "_", "^", "#");
		var midStringLen = 1;
		var midString = "";
		// Find a string that doesn't exist in the inputString to be used
		// as an "inbetween" string
		while (midString == "") {
			for (var i=0; i < midStrings.length; i++) {
				var tempMidString = "";
				for (var j=0; j < midStringLen; j++) { tempMidString += midStrings[i]; }
				if (fromString.indexOf(tempMidString) == -1) {
				midString = tempMidString;
				i = midStrings.length + 1;
				}
			}
		} // Keep on going until we build an "inbetween" string that doesn't exist
		// Now go through and do two replaces - first, replace the "fromString" with the "inbetween" string
		while (temp.indexOf(fromString) != -1) {
			var toTheLeft = temp.substring(0, temp.indexOf(fromString));
			var toTheRight = temp.substring(temp.indexOf(fromString)+fromString.length, temp.length);
			temp = toTheLeft + midString + toTheRight;
		}
		// Next, replace the "inbetween" string with the "toString"
		while (temp.indexOf(midString) != -1) {
			var toTheLeft = temp.substring(0, temp.indexOf(midString));
			var toTheRight = temp.substring(temp.indexOf(midString)+midString.length, temp.length);
			temp = toTheLeft + toString + toTheRight;
		}
	} // Ends the check to see if the string being replaced is part of the replacement string or not
	return temp; // Send the updated string back to the user
	} // Ends the "replaceSubstring" function
	
	function replaceChar(theString, oldChar, newChar) 
	{
		var i = 0;
		var j = theString.length;

		for(i=0; i < theString.length; i++) 
		{
			if(theString.charAt(i) == oldChar) 
			{
				theString = theString.substring(0,i) + newChar + theString.substring(i+1,theString.length);
				if(i > j) 
				{ 
					break;
				}
			}
		}
		return theString;
	}
//--------------------------------------------------------------------------------------------	
//-------------------------------------------------------------------
// disallowBlank(input_object[,message[,true]])
//   Checks a form field for a blank value. Optionally alerts if 
//   blank and focuses
//-------------------------------------------------------------------

//Commented and Added by Dhanashri S on 8 Dec 2015
//function disallowBlank(obj){
//	if (obj == null) {return false;} 
//	var msg=(arguments.length>1)?arguments[1]:"";
//	msg=replaceSubstring(msg,"&#39;","'");
//	var dofocus=(arguments.length>2)?arguments[2]:true;
//	if (isBlank(getInputValue(obj))){
//		if(!isBlank(msg)){alert(msg);}
//		if(dofocus){
//			setFocus(obj);
//				if (obj.type=='select-one')
//				{
//					obj.selectedIndex = 0;
//					//obj.click();
//					//obj.style.backgroundColor="#000066";
//				}			
//			}
//		return true;
//		}
//	return false;
//	}


function disallowBlank(obj) {
    if (obj == null) { return false; }
    var msg = (arguments.length > 1) ? arguments[1] : "";
    msg = replaceSubstring(msg, "&#39;", "'");
    var dofocus = (arguments.length > 2) ? arguments[2] : true;
    if (isBlank(getInputValue(obj))) {
        if (!isBlank(msg)) { alert(msg); }
        if (dofocus) {
            setFocus(obj);
            if (obj.type == 'select-one') {
                obj.selectedIndex = -1;//Modified By ShrikantB On 21-OCT-2010 For 
                //obj.click();
                //obj.style.backgroundColor="#000066";
            }
        }
        return true;
    }
    return false;
}
//End of Comment and Addition by Dhanashri S on 8 Dec 2015

//-------------------------------------------------------------------
// disallowNonAlphabets(input_object)
//	This function will check if the string contains only alphabets ([a-z] or [A-Z])
//   Returns true the string contains some character other than the alphabets
//-------------------------------------------------------------------
function disallowNonAlphabets(obj)
{
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (!isAlphabet(getInputValue(obj))){
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
		}
	return false;
}

//-------------------------------------------------------------------
// isAlphabet(value)
//   Returns true if it the string contains only alphabets ([a-z] or [A-Z])
//	 allowSpace - If True then allow space( ) along with alphabets else only alphabets
//-------------------------------------------------------------------
function isAlphabet(strValue)
{
	//var objRegExp=/[\W_0-9]/;
	var allowSpace=(arguments.length>1)?arguments[1]:true;	
	if (allowSpace==true) {	var objRegExp=/[^A-Za-z ]/;}
	else {	var objRegExp=/[^A-Za-z]/;}
	if (objRegExp.test(strValue)) { return false;}
	return true;
}

//-------------------------------------------------------------------
// disallowNonNumeric(input_object[,message[,true]])
//   Checks a form field for a non numeric value. Optionally alerts if 
//   non numeric and focuses
//-------------------------------------------------------------------
function disallowNonNumeric(obj){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (!isNumeric(getInputValue(obj))){
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
		}
	return false;
	}

//-------------------------------------------------------------------
// disallowNegativeNumeric(input_object[,message[,true]])
//   Checks a form field for a non numeric value and positive. Optionally alerts if 
//   non numeric and focuses
//-------------------------------------------------------------------
function disallowNegativeNumeric(obj){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if (getInputValue(obj) < 0) {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowNonInteger(input_object[,message[,true]])
//   Checks a form field for a non numberic value. Optionally alerts if 
//   non numeric and focuses
//-------------------------------------------------------------------
function disallowNonInteger(obj){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (!isInteger(getInputValue(obj))){
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
		}
	return false;
	}

//-------------------------------------------------------------------
// disallowNegativeInteger(input_object[,message[,true]])
//   Checks a form field for a non negative numberic value. Optionally alerts if 
//   non negative numberic and focuses
//-------------------------------------------------------------------
function disallowNegativeInteger(obj){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (disallowNonInteger(obj,msg,dofocus)) {return true;}
	else if (getInputValue(obj) < 0) {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowMinValueViolation(input_object,minimum value[,message[,true[,inclusive]]])
//   Checks a form field for a value not less than the minimum value
//	return true if value is less than the minimum value else false
//-------------------------------------------------------------------
function disallowMinValueViolation(obj,minVal){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var inclusive=(arguments.length>4)?arguments[4]:true;
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if (((inclusive == true) && (parseFloat(getInputValue(obj)) < parseFloat(minVal))) || ((inclusive == false) && (parseFloat(getInputValue(obj)) <= parseFloat(minVal))))  {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowMaxValueViolation(input_object,maximum value[,message[,true[,inclusive]]])
//   Checks a form field for a value not greater than the maximum value
//	return true if value is less than the greater value else false
//-------------------------------------------------------------------
function disallowMaxValueViolation(obj,maxVal){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var inclusive=(arguments.length>4)?arguments[4]:true;
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if (((inclusive == true) && (parseFloat(getInputValue(obj)) > parseFloat(maxVal))) || ((inclusive == false) && (parseFloat(getInputValue(obj)) >= parseFloat(maxVal))))  {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowValueRangeViolation(input_object,minimum,maximum value[,message[,true[,minInclusive[,maxInclusive]]]])
//   Checks a form field for a value not greater than the maximum value
//   Checks a form field for a value not less than the minimum value
//	return true if so else false
//-------------------------------------------------------------------
function disallowValueRangeViolation(obj,minVal,maxVal){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>3)?arguments[3]:"";
	msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>4)?arguments[4]:true;
	var minInclusive=(arguments.length>5)?arguments[5]:true;
	var maxInclusive=(arguments.length>6)?arguments[6]:true;
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if (disallowMinValueViolation(obj,minVal,"",dofocus,minInclusive) || disallowMaxValueViolation(obj,maxVal,"",dofocus,maxInclusive)) {
				if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowMaxlengthViolation(input_object,maxLength,[,message[,true]])
//   Checks whether length of a form field exceeds the maximum allowed length  
//-------------------------------------------------------------------
function disallowMaxlengthViolation(obj,maxLength){
 if (obj == null) {return false;} 
 if (isBlank(getInputValue(obj))) {return false;}
 var msg=(arguments.length>2)?arguments[2]:"";
 msg=replaceSubstring(msg,"&#39;","'");
 //Added By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
 var lngth=getInputValue(obj).length.toString();
 msg=replaceSubstring(msg,"<L>",lngth);
 //End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
 var dofocus=(arguments.length>3)?arguments[3]:true;
 if (parseFloat(getInputValue(obj).length) > parseFloat(maxLength)) {
   if(!isBlank(msg)){alert(msg);}
  if(dofocus){
   setFocus(obj);
   }
  return true;
 } 
 return false;
 }
//-------------------------------------------------------------------
// disallowMinlengthViolation(input_object,minLength,[,message[,true]])
//   Checks whether length of a form field is lesser than the minimum required length  
//-------------------------------------------------------------------
function disallowMinlengthViolation(obj,minLength){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	//Added By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
	var lngth=getInputValue(obj).length.toString();
	msg=replaceSubstring(msg,"<L>",lngth);
	//End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 21 May 2007
	var dofocus=(arguments.length>3)?arguments[3]:true;
	if ( parseFloat(getInputValue(obj).length) < parseFloat(minLength)) {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowSpecialCharacters(input_object,[,message[,true,[special charcter string]]])
//   Checks whether the form field contains any of the special chracters
//	 return true if so else false 
//	 Limitation : Charater - is not allowed in special character string
//-------------------------------------------------------------------
function disallowSpecialCharacters(obj)
{
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
    var dofocus = (arguments.length > 2) ? arguments[2] : true;
    //Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
	//var spChars=(arguments.length>3)?arguments[3]:"[/:*?+\"><|,\\\\]";
    var spChars = (arguments.length > 3) ? arguments[3] : "['/:*?+\"><|,\\\\]";
      //End of Commented and added by Chetan M on 5th Aug 2020 for All E Tech Issue ID = 25755
	if (hasSpecialCharacters(getInputValue(obj),spChars)) {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
}

//-------------------------------------------------------------------
// hasSpecialCharacters(string,special charcter string)
//   Checks whether the string contains any of the special chracters
//	 return true if so else false 
//-------------------------------------------------------------------
function hasSpecialCharacters(strValue,spChars)
{
		var r1 = new RegExp(spChars);
				
		return (r1.test(strValue));
}

//-------------------------------------------------------------------
// disallowDuplicates(input_object,arrValues,[,message[,true[,matchCase]]])
//   Checks a form field for duplicate value
//	 return true if the value exists in the arrValues array else false
//-------------------------------------------------------------------

//Commented and Added by Dhanashri S on 8 Dec 2015

//function disallowDuplicates(obj,arrValues){
//	if (obj == null) {return false;} 
//	if (isBlank(getInputValue(obj))) {return false;}
//	var msg=(arguments.length>2)?arguments[2]:"";
//	msg=replaceSubstring(msg,"&#39;","'");
//	var dofocus=(arguments.length>3)?arguments[3]:true;
//	var matchCase=(arguments.length>4)?arguments[4]:true;
//	if (isExist(getInputValue(obj),arrValues,matchCase)){
//		if(!isBlank(msg)){alert(msg);}
//		if(dofocus){
//			setFocus(obj);
//			}
//		return true;
//		}
//	return false;
//}


function disallowDuplicates(obj, arrValues) {

    if (obj == null) { return false; }

    if (isBlank(getInputValue(obj))) { return false; }
    var msg = (arguments.length > 2) ? arguments[2] : "";
    msg = replaceSubstring(msg, "&#39;", "'");
    var dofocus = (arguments.length > 3) ? arguments[3] : true;
    var matchCase = (arguments.length > 4) ? arguments[4] : true;
    //Added by Vinay on 05 DEC. 2008 WAF3_GEN_18
    var numbericData = (arguments.length > 5) ? arguments[5] : false;
    if (numbericData) {
        if (!isNaN(obj.value)) {
            obj.value = parseFloat(obj.value);
        }
    }
    //Addition End by Vinay on 05 DEC. 2008 WAF3_GEN_18  
    if (isExist(getInputValue(obj), arrValues, matchCase)) {
        if (!isBlank(msg)) { alert(msg); }
        if (dofocus) {
            setFocus(obj);
        }
        return true;
    }
    return false;
}
//End of Addition by Dhanashri S on 8 Dec 2015

//-------------------------------------------------------------------
// isExist(value,arrValues[,matchCase])
//   Checks a value exists in the array
//	 return true if the value exists in the arrValues array else false
//-------------------------------------------------------------------
function isExist(value,arrValues) {
	if(arrValues==null||arrValues.length<=0){return false;}
	var matchCase=(arguments.length>2)?arguments[2]:true;
	for(var i=0;i<arrValues.length;i++){
		if (matchCase == true) {		
			if (value.toString() == arrValues[i].toString())
			{ return true; } }
		else {		
			if (value.toString().toUpperCase() == arrValues[i].toString().toUpperCase())
			{ return true; } }		
		}
	return false;
}

//-------------------------------------------------------------------
// setFocus(obj[,showSelected])
//   set focus to the control
//-------------------------------------------------------------------
function setFocus(obj){
	try{
	//Added By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
		if (document.getElementById('FFE29587WHIZ_' + obj.name)!=null || document.getElementById('anc' + obj.name)!=null)
		{
		    var controlplaceHolder;
		    if (document.getElementById('FFE29587WHIZ_' + obj.name)!=null)
		        controlplaceHolder='FFE29587WHIZ_';
		    else    
		        controlplaceHolder='anc';
		    var len=document.getElementsByName(controlplaceHolder + obj.name).length;    
		    if(len==1)
		    {
		        obj=document.getElementById(controlplaceHolder + obj.name)
		    }
		    else
		    {
		        for (var i = 0; i < len; i++)
		        {
		            if(document.getElementsByName(obj.name)[i].value==obj.value)
		            {
		                obj=document.getElementsByName(controlplaceHolder + obj.name)[i];
		                break;
		            }    
		        }
		    }
		
		}
        //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007		
		var showSelected=(arguments.length>1)?arguments[1]:false;	
		if (obj == null) {return;} 
		if (obj.disabled == true) {return;}
		if (isArray(obj) && (typeof(obj.type)=="undefined")) {obj=obj[0];}
		if (obj.type=="hidden") {return;}
		if (showSelected ==true) {
		if(obj.type=="text"||obj.type=="textarea"||obj.type=="password") { obj.select(); }
		}
		obj.focus();
	}
	catch(e){}
}


//-------------------------------------------------------------------
//				COMPARISON RULES FOR NUMBERS	: BEGIN
//-------------------------------------------------------------------
// disallowValue1GreaterThanValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is greater than value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowValue1GreaterThanValue2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var val1 = parseFloat(obj1.value);
	var val2 = parseFloat(obj2.value);
	if (isNaN(val1)) {val1=obj1.value;}
	if (isNaN(val2)) {val2=obj2.value;}
	if (val1 > val2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowValue1LessThanValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is less than value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowValue1LessThanValue2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var val1 = parseFloat(obj1.value);
	var val2 = parseFloat(obj2.value);
	if (isNaN(val1)) {val1=obj1.value;}
	if (isNaN(val2)) {val2=obj2.value;}
	if (val1 < val2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowValue1EqualToValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------

//Commented and Added by Dhanashri S on 8 Dec 2015 

//function disallowValue1EqualToValue2(obj1,obj2){
//	if (obj1 == null) {return false;} 
//	if (obj2 == null) {return false;} 
//	if (isBlank(getInputValue(obj1))) {return false;}
//	if (isBlank(getInputValue(obj2))) {return false;}
//	var msg=(arguments.length>2)?arguments[2]:"";
//	msg=replaceSubstring(msg,"&#39;","'");
//	var dofocus=(arguments.length>3)?arguments[3]:true;
//	var val1 = parseFloat(obj1.value);
//	var val2 = parseFloat(obj2.value);
//	if (isNaN(val1)) {val1=obj1.value;}
//	if (isNaN(val2)) {val2=obj2.value;}
//	//Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
//	var matchCase=(arguments.length>4)?arguments[4]:true; 
//	if (matchCase == false) 
//	{		
//	    val1=val1.toUpperCase()
//	    val2=val2.toUpperCase()
//	}
//	//End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
//	if (val1 == val2) {
//		if(!isBlank(msg)){alert(msg);}
//		if(dofocus){
//			setFocus(obj1);
//			}
//		return true;
//	}	
//	return false;
//}

function disallowValue1EqualToValue2(obj1, obj2) {
    if (obj1 == null) { return false; }
    if (obj2 == null) { return false; }
    if (isBlank(getInputValue(obj1))) { return false; }
    if (isBlank(getInputValue(obj2))) { return false; }
    var msg = (arguments.length > 2) ? arguments[2] : "";
    msg = replaceSubstring(msg, "&#39;", "'");
    var dofocus = (arguments.length > 3) ? arguments[3] : true;
    var val1 = parseFloat(obj1.value);
    var val2 = parseFloat(obj2.value);
    if (isNaN(val1)) { val1 = obj1.value; }
    if (isNaN(val2)) { val2 = obj2.value; }
    //Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    var matchCase = (arguments.length > 4) ? arguments[4] : true;
    if (matchCase == false) {
        if (isNaN(val1)) { val1 = val1.toUpperCase(); }//Modified By Ninad IssueID-29330
        if (isNaN(val2)) { val2 = val2.toUpperCase(); }//Modified By Ninad IssueID-29330
    }
    //End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
    if (val1 == val2) {
        if (!isBlank(msg)) { alert(msg); }
        if (dofocus) {
            setFocus(obj1);
        }
        return true;
    }
    return false;
}

//End of Comment and Addition by Dhanashri S on 8 Dec 2015

//-------------------------------------------------------------------
// disallowValue1NotEqualToValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowValue1NotEqualToValue2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var val1 = parseFloat(obj1.value);
	var val2 = parseFloat(obj2.value);
	if (isNaN(val1)) {val1=obj1.value;}
	if (isNaN(val2)) {val2=obj2.value;}
	if (val1 != val2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowValue1GreaterThanOrEqualToValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowValue1GreaterThanOrEqualToValue2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var val1 = parseFloat(obj1.value);
	var val2 = parseFloat(obj2.value);
	if (isNaN(val1)) {val1=obj1.value;}
	if (isNaN(val2)) {val2=obj2.value;}
	if (val1 >= val2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowValue1LessThanOrEqualToValue2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowValue1LessThanOrEqualToValue2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var val1 = parseFloat(obj1.value);
	var val2 = parseFloat(obj2.value);
	if (isNaN(val1)) {val1=obj1.value;}
	if (isNaN(val2)) {val2=obj2.value;}
	if (val1 <= val2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
//				COMPARISON RULES	: END
//-------------------------------------------------------------------


//-------------------------------------------------------------------
// disallowModify(input_object[,message[,true]])
//   Checks a form field for a value different than defaultValue. 
//   Optionally alerts and focuses
//-------------------------------------------------------------------
function disallowModify(obj){
	if (obj == null) {return false;} 
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (getInputValue(obj)!=getInputDefaultValue(obj)){
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			if (isArray(obj) && (typeof(obj.type)=="undefined")) {obj=obj[0];}
			if(obj.type=="text"||obj.type=="textarea"||obj.type=="password") { obj.select(); }
			obj.focus();
			}
		setInputValue(obj,getInputDefaultValue(obj));
		return true;
		}
	return false;
	}

//-------------------------------------------------------------------
// commifyArray(array)
//   Take an array of values and turn it into a comma-separated string
//-------------------------------------------------------------------
function commifyArray(obj){
	var s="";
	if(obj==null||obj.length<=0){return s;}
	for(var i=0;i<obj.length;i++){
		s=s+((s=="")?"":",")+obj[i].toString();
		}
	return s;
	}

//-------------------------------------------------------------------
// getSingleInputValue(input_object,use_default)
//   Utility function used by others
//-------------------------------------------------------------------
function getSingleInputValue(obj,use_default) {
	switch(obj.type){
		case 'radio': case 'checkbox': return(((use_default)?obj.defaultChecked:obj.checked)?obj.value:null);
		case 'text': case 'file': case 'hidden': case 'textarea': case 'Textbox': return(use_default)?obj.defaultValue:obj.value;
		case 'password': return((use_default)?null:obj.value);
		case 'select-one':
			if (obj.options==null) { return null; }
			if(use_default){
				var o=obj.options;
				for(var i=0;i<o.length;i++){if(o[i].defaultSelected){return o[i].value;}}
				return o[0].value;
				}
			if (obj.selectedIndex<0){return null;}
			return(obj.options.length>0)?obj.options[obj.selectedIndex].value:null;
		case 'select-multiple': 
			if (obj.options==null) { return null; }
			var values=new Array();
			for(var i=0;i<obj.options.length;i++) {
				if((use_default&&obj.options[i].defaultSelected)||(!use_default&&obj.options[i].selected)) {
					values[values.length]=obj.options[i].value;
					}
				}
			return (values.length==0)?null:commifyArray(values);
		}
	alert("FATAL ERROR: Field type "+obj.type+" is not supported for this function");
	return null;
	}

//-------------------------------------------------------------------
// getSingleInputText(input_object,use_default)
//   Utility function used by others
//-------------------------------------------------------------------
function getSingleInputText(obj,use_default) {
	switch(obj.type){
		case 'radio': case 'checkbox': 	return "";
		case 'text': case 'file': case 'Textbox': case 'hidden': case 'textarea': return(use_default)?obj.defaultValue:obj.value;
		case 'password': return((use_default)?null:obj.value);
		case 'select-one':
			if (obj.options==null) { return null; }
			if(use_default){
				var o=obj.options;
				for(var i=0;i<o.length;i++){if(o[i].defaultSelected){return o[i].text;}}
				return o[0].text;
				}
			if (obj.selectedIndex<0){return null;}
			return(obj.options.length>0)?obj.options[obj.selectedIndex].text:null;
		case 'select-multiple': 
			if (obj.options==null) { return null; }
			var values=new Array();
			for(var i=0;i<obj.options.length;i++) {
				if((use_default&&obj.options[i].defaultSelected)||(!use_default&&obj.options[i].selected)) {
					values[values.length]=obj.options[i].text;
					}
				}
			return (values.length==0)?null:commifyArray(values);
		}
	alert("FATAL ERROR: Field type "+obj.type+" is not supported for this function");
	return null;
	}

//-------------------------------------------------------------------
// setSingleInputValue(input_object,value)
//   Utility function used by others
//-------------------------------------------------------------------
function setSingleInputValue(obj,value) {
	switch(obj.type){
		case 'radio': case 'checkbox': if(obj.value==value){obj.checked=true;return true;}else{obj.checked=false;return false;}
		case 'text': case 'file': case 'Textbox': case 'hidden': case 'textarea': case 'password': obj.value=value;return true;
		case 'select-one': case 'select-multiple': 
			var o=obj.options;
			for(var i=0;i<o.length;i++){
				if(o[i].value==value){o[i].selected=true;}
				else{o[i].selected=false;}
				}
			return true;
		}
	alert("FATAL ERROR: Field type "+obj.type+" is not supported for this function");
	return false;
	}

//-------------------------------------------------------------------
// getInputValue(input_object)
//   Get the value of any form input field
//   Multiple-select fields are returned as comma-separated values
//   (Doesn't support input types: button,file,reset,submit)
//-------------------------------------------------------------------
function getInputValue(obj) {
	var use_default=(arguments.length>1)?arguments[1]:false;
	if (isArray(obj) && (typeof(obj.type)=="undefined")) {
		var values=new Array();
		for(var i=0;i<obj.length;i++){
			var v=getSingleInputValue(obj[i],use_default);
			if(v!=null){values[values.length]=v;}
			}
		return commifyArray(values);
		}
	return TrimAll(getSingleInputValue(obj,use_default));
	}

//-------------------------------------------------------------------
// getInputText(input_object)
//   Get the displayed text of any form input field
//   Multiple-select fields are returned as comma-separated values
//   (Doesn't support input types: button,file,reset,submit)
//-------------------------------------------------------------------
function getInputText(obj) {
	var use_default=(arguments.length>1)?arguments[1]:false;
	if (isArray(obj) && (typeof(obj.type)=="undefined")) {
		var values=new Array();
		for(var i=0;i<obj.length;i++){
			var v=getSingleInputText(obj[i],use_default);
			if(v!=null){values[values.length]=v;}
			}
		return commifyArray(values);
		}
	return getSingleInputText(obj,use_default);
	}

//-------------------------------------------------------------------
// getInputDefaultValue(input_object)
//   Get the default value of any form input field when it was created
//   Multiple-select fields are returned as comma-separated values
//   (Doesn't support input types: button,file,password,reset,submit)
//-------------------------------------------------------------------
function getInputDefaultValue(obj){return getInputValue(obj,true);}

//-------------------------------------------------------------------
// isChanged(input_object)
//   Returns true if input object's value has changed since it was
//   created.
//-------------------------------------------------------------------
function isChanged(obj){return(getInputValue(obj)!=getInputDefaultValue(obj));}

//-------------------------------------------------------------------
// setInputValue(obj,value)
//   Set the value of any form field. In cases where no matching value
//   is available (select, radio, etc) then no option will be selected
//   (Doesn't support input types: button,file,password,reset,submit)
//-------------------------------------------------------------------
function setInputValue(obj,value) {
	var use_default=(arguments.length>1)?arguments[1]:false;
	if(isArray(obj)&&(typeof(obj.type)=="undefined")){
		for(var i=0;i<obj.length;i++){setSingleInputValue(obj[i],value);}
		}
	else{setSingleInputValue(obj,value);}
	}
	
//-------------------------------------------------------------------
// isFormModified(form_object,hidden_fields,ignore_fields)
//   Check to see if anything in a form has been changed. By default
//   it will check all visible form elements and ignore all hidden 
//   fields. 
//   You can pass a comma-separated list of field names to check in
//   addition to visible fields (for hiddens, etc).
//   You can also pass a comma-separated list of field names to be
//   ignored in the check.
//-------------------------------------------------------------------
function isFormModified(theform,hidden_fields,ignore_fields){
	if(hidden_fields==null){hidden_fields="";}
	if(ignore_fields==null){ignore_fields="";}
	var hiddenFields=new Object();
	var ignoreFields=new Object();
	var i,field;
	var hidden_fields_array=hidden_fields.split(',');
	for (i=0;i<hidden_fields_array.length;i++) {
		hiddenFields[Trim(hidden_fields_array[i])]=true;
		}
	var ignore_fields_array=ignore_fields.split(',');
	for (i=0;i<ignore_fields_array.length;i++) {
		ignoreFields[Trim(ignore_fields_array[i])]=true;
		}
	for (i=0;i<theform.elements.length;i++) {
		var changed=false;
		var name=theform.elements[i].name;
		if(!isBlank(name)){
			var type=theform[name].type;
			if(!ignoreFields[name]){
				if(type=="hidden"&&hiddenFields[name]){changed=isChanged(theform[name]);}
				else if(type=="hidden"){changed=false;}
				else {changed=isChanged(theform[name]);}
				}
			}
		if(changed){return true;}
		}
		return false;
	}
//**************************************************************************************************
//		*																		*
//		*								DATE FUNCTIONS							*
//		*																		*
//**************************************************************************************************
var MONTH_NAMES=new Array('January','February','March','April','May','June','July','August','September','October','November','December','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec');
var DAY_NAMES=new Array('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sun','Mon','Tue','Wed','Thu','Fri','Sat');
// ------------------------------------------------------------------
// Utility functions for parsing in getDateFromFormat()
// ------------------------------------------------------------------
function _isInteger(val) {
	var digits="1234567890";
	for (var i=0; i < val.length; i++) {
		if (digits.indexOf(val.charAt(i))==-1) { return false; }
		}
	return true;
	}
function _getInt(str,i,minlength,maxlength) {
	for (var x=maxlength; x>=minlength; x--) {
		var token=str.substring(i,i+x);
		if (token.length < minlength) { return null; }
		if (_isInteger(token)) { return token; }
		}
	return null;
	}
	
// ------------------------------------------------------------------
// getDateFromFormat( date_string [,format_string] )
//
// This function takes a date string and a format string. It matches
// If the date string matches the format string, it returns the 
// getTime() of the date. If it does not match, it returns 0.
// ------------------------------------------------------------------
function getDateFromFormat(val) {
	var format=(arguments.length>1)?arguments[1]:defaultDateFormat;
	val=val+"";
	format=format+"";
	var i_val=0;
	var i_format=0;
	var c="";
	var token="";
	var token2="";
	var x,y;
	var now=new Date();
	var year=now.getYear();
	var month=now.getMonth()+1;
	var date=1;
	var hh=now.getHours();
	var mm=now.getMinutes();
	var ss=now.getSeconds();
	var ampm="";
	
	while (i_format < format.length) {
		// Get next token from format string
		c=format.charAt(i_format);
		token="";
		while ((format.charAt(i_format)==c) && (i_format < format.length)) {
			token += format.charAt(i_format++);
			}
		// Extract contents of value based on format token
		if (token=="yyyy" || token=="yy" || token=="y") {
			if (token=="yyyy") { x=4;y=4; }
			if (token=="yy")   { x=2;y=2; }
			if (token=="y")    { x=2;y=4; }
			year=_getInt(val,i_val,x,y);
			if (year==null) { return 0; }
			i_val += year.length;
			if (year.length==2) {
				if (year > 70) { year=1900+(year-0); }
				else { year=2000+(year-0); }
				}
			}
		else if (token=="MMM"||token=="NNN"){
			month=0;
			for (var i=0; i<MONTH_NAMES.length; i++) {
				var month_name=MONTH_NAMES[i];
				if (val.substring(i_val,i_val+month_name.length).toLowerCase()==month_name.toLowerCase()) {
					if (token=="MMM"||(token=="NNN"&&i>11)) {
						month=i+1;
						if (month>12) { month -= 12; }
						i_val += month_name.length;
						break;
						}
					}
				}
			if ((month < 1)||(month>12)){return 0;}
			}
		else if (token=="EE"||token=="E"){
			for (var i=0; i<DAY_NAMES.length; i++) {
				var day_name=DAY_NAMES[i];
				if (val.substring(i_val,i_val+day_name.length).toLowerCase()==day_name.toLowerCase()) {
					i_val += day_name.length;
					break;
					}
				}
			}
		else if (token=="MM"||token=="M") {
			month=_getInt(val,i_val,token.length,2);
			if(month==null||(month<1)||(month>12)){return 0;}
			i_val+=month.length;}
		else if (token=="dd"||token=="d") {
			date=_getInt(val,i_val,token.length,2);
			if(date==null||(date<1)||(date>31)){return 0;}
			i_val+=date.length;}
		else if (token=="hh"||token=="h") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>12)){return 0;}
			i_val+=hh.length;}
		else if (token=="HH"||token=="H") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>23)){return 0;}
			i_val+=hh.length;}
		else if (token=="KK"||token=="K") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<0)||(hh>11)){return 0;}
			i_val+=hh.length;}
		else if (token=="kk"||token=="k") {
			hh=_getInt(val,i_val,token.length,2);
			if(hh==null||(hh<1)||(hh>24)){return 0;}
			i_val+=hh.length;hh--;}
		else if (token=="mm"||token=="m") {
			mm=_getInt(val,i_val,token.length,2);
			if(mm==null||(mm<0)||(mm>59)){return 0;}
			i_val+=mm.length;}
		else if (token=="ss"||token=="s") {
			ss=_getInt(val,i_val,token.length,2);
			if(ss==null||(ss<0)||(ss>59)){return 0;}
			i_val+=ss.length;}
		else if (token=="a") {
			if (val.substring(i_val,i_val+2).toLowerCase()=="am") {ampm="AM";}
			else if (val.substring(i_val,i_val+2).toLowerCase()=="pm") {ampm="PM";}
			else {return 0;}
			i_val+=2;}
		else {
			if (val.substring(i_val,i_val+token.length)!=token) {return 0;}
			else {i_val+=token.length;}
			}
		}
	// If there are any trailing characters left in the value, it doesn't match
	if (i_val != val.length) { return 0; }
	// Is date valid for month?
	if (month==2) {
		// Check for leap year
		if ( ( (year%4==0)&&(year%100 != 0) ) || (year%400==0) ) { // leap year
			if (date > 29){ return 0; }
			}
		else { if (date > 28) { return 0; } }
		}
	if ((month==4)||(month==6)||(month==9)||(month==11)) {
		if (date > 30) { return 0; }
		}
	// Correct hours value
	if (hh<12 && ampm=="PM") { hh=hh-0+12; }
	else if (hh>11 && ampm=="AM") { hh-=12; }
	var newdate=new Date(year,month-1,date,hh,mm,ss);
	return newdate.getTime();
	}
// ------------------------------------------------------------------
// isDate
//		Check if date is valid or not
//		return true if valid date else false
// ------------------------------------------------------------------
function isDate(obj) {
	if (obj == null) {return true;} 
	if (isBlank(getInputValue(obj))) {return true;}
	var msg=(arguments.length>1)?arguments[1]:"";
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (parseDate(getInputValue(obj))) {
			if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return false;
	}	
	return true;
}

function getDate(val) {
	var format=(arguments.length>1)?arguments[1]:defaultDateFormat;
	d=getDateFromFormat(val,format);
	if (d!=0) { return new Date(d);  }
	return null;
	}

// ------------------------------------------------------------------
// parseDate( date_string)
//
// This function takes a date string and tries to match it to a
// number of possible date formats to get the value. It will try to
// match against the following international formats, in this order:
// y-M-d   MMM d, y   MMM d,y   y-MMM-d   d-MMM-y  MMM d
// M/d/y   M-d-y      M.d.y     MMM-d     M/d      M-d
// d/M/y   d-M-y      d.M.y     d-MMM     d/M      d-M
// Returns true if no patterns match else false
// ------------------------------------------------------------------
function parseDate(val) {
	generalFormats=new Array('y-M-d','MMM d, y','MMM d,y','y-MMM-d','d-MMM-y','MMM d');
	monthFirst=new Array('M/d/y','M-d-y','M.d.y','MMM-d','M/d','M-d');
	dateFirst =new Array('d/M/y','d-M-y','d.M.y','d-MMM','d/M','d-M');
	var checkList=new Array('generalFormats','dateFirst','monthFirst');
	var d=null;
	for (var i=0; i<checkList.length; i++) {
		var l=window[checkList[i]];
		for (var j=0; j<l.length; j++) {
			d=getDateFromFormat(val,l[j]);
			if (d!=0) { return false; }
			}
		}
	return true;
	}

// -------------------------------------------------------------------
// compareDates(date1,date2[,date1format[,date2format]])
//   Compare two date strings to see which is greater.
//   Returns:
//   1 if date1 is greater than date2
//   0 if date1 is equal to date2
//  -1 if date2 is greater than date1
//	-2 if either of the dates is in an invalid format
// -------------------------------------------------------------------
function compareDates(date1,date2) {
	if (date1  == null ) {return -2;}
	if (date2  == null ) {return -2;}
	if (isBlank(date1)) {return -2;}
	if (isBlank(date2)) {return -2;}	
	
	var date1format; //=(arguments.length>2)?arguments[2]:defaultDateFormat;
	if (arguments.length>2) {
		if (isNull(arguments[2])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[2])) {date1format=arguments[2];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>3)?arguments[3]:defaultDateFormat;
	var d1=getDateFromFormat(date1,date1format);
	var d2=getDateFromFormat(date2,date2format);
	if (d1==0 || d2==0) {
		return -2;
		}
	else if (d1 > d2) {
		return 1;
		}
	else if (d1 < d2) {
		return -1;
		}	
	return 0;
	}
	
	
// -------------------------------------------------------------------
// getDate()
// Returns date on client machine in following formats : 
// 1 : 15-Jan-2004
// 2 : 15 January 2004
// 3 : January 15, 2004
// 4 : Jan 15, 2004
// 5 : 15 Jan, 2004
// -------------------------------------------------------------------	
function getDate1(format)
	{
		var dateString;
		var months = new Array(13);
		months[0] = "January";
		months[1] = "February";
		months[2] = "March";
		months[3] = "April";
		months[4] = "May";
		months[5] = "June";
		months[6] = "July";
		months[7] = "August";
		months[8] = "September";
		months[9] = "October";
		months[10] = "November";
		months[11] = "December";
		var now = new Date();
		var monthnumber = now.getMonth();
		var monthname = months[monthnumber];
		var monthday = now.getDate();
		var year = now.getYear();
		if(year < 2000) { year = year + 1900; }
		
		switch(format)
		{
			case 1:
				dateString = monthday + '-' + Left(monthname,3) + '-' + year;
				break;
			case 2:
				dateString = monthday + ' ' + monthname + ' ' + year;
				break;
			case 3:
				dateString = monthname + ' ' + monthday + ', ' + year;
				break;
			case 4:
				dateString = Left(monthname,3) + ' ' + monthday + ', ' + year;
				break;
			case 5:
				dateString = monthday + ' ' + Left(monthname,3) + ', ' + year;
				break;
			default:
				dateString = monthday + ' ' + monthname + ' ' + year;
		}
		return dateString;
	} // function getCalendarDate()


// -------------------------------------------------------------------
// getTime
// Returns time on client machine in format : hh:mm:ss am/pm 
// -------------------------------------------------------------------	
	function getTime()
	{
		var now = new Date();
		var hour = now.getHours();
		var minute = now.getMinutes();
		var second = now.getSeconds();
		var ap = "AM";
		if (hour > 11) { ap = "PM"; }
		if (hour > 12) { hour = hour - 12; }
		if (hour == 0) { hour = 12; }
		if (hour < 10) { hour = "0" + hour; }
		if (minute < 10) { minute = "0" + minute; }
		if (second < 10) { second = "0" + second; }
		var timeString = hour + ':' + minute + ':' + second + " " + ap;
		return timeString;
	} // function getClockTime()


// -------------------------------------------------------------------
// Now()
// Returns date and time on client machine in following date formats : 
// 1 : 15-Jan-2004
// 2 : 15 January 2004
// 3 : January 15, 2004
// 4 : Jan 15, 2004
// 5 : 15 Jan, 2004
// -------------------------------------------------------------------	
	function Now(format)
	{
		if (format!=null)
			return getDate1(format) + " " + getTime() ;
		else
			return getDate1() + " " + getTime() ;
	}	
//-------------------------------------------------------------------
//				COMPARISION RULES FOR DATES	: BEGIN
//-------------------------------------------------------------------
// disallowDate1GreaterThanDate2(input_date1,input_date2[,message[,true]])
//   if the value of the from field 1 is greater than value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1GreaterThanDate2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 > d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowDate1LessThanDate2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is less than value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1LessThanDate2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 < d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowDate1EqualToDate2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1EqualToDate2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 == d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowDate1NotEqualToDate2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1NotEqualToDate2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 != d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowDate1GreaterThanOrEqualToDate2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1GreaterThanOrEqualToDate2(obj1,obj2){
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 >= d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
// disallowDate1LessThanOrEqualToDate2(input_object1,input_object2[,message[,true]])
//   if the value of the from field 1 is not equal to value of form field 2
//	 then show the message and return true.
//-------------------------------------------------------------------
function disallowDate1LessThanOrEqualToDate2(obj1, obj2) {
   
	if (obj1 == null) {return false;} 
	if (obj2 == null) {return false;} 
	if (isBlank(getInputValue(obj1))) {return false;}
	if (isBlank(getInputValue(obj2))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	var date1format;
	if (arguments.length>4) {
		if (isNull(arguments[4])) {date1format=defaultDateFormat;}
		else if (!isBlank(arguments[4])) {date1format=arguments[4];}
		else {date1format=defaultDateFormat;}
	}
	else {date1format=defaultDateFormat;}
	
	var date2format=(arguments.length>5)?arguments[5]:defaultDateFormat;
	var d1=getDateFromFormat(obj1.value,date1format);
	var d2=getDateFromFormat(obj2.value,date2format);
	if (d1 <= d2) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj1);
			}
		return true;
	}	
	return false;
	}

//-------------------------------------------------------------------
//				COMPARISION RULES	: END
//-------------------------------------------------------------------

// String functions Left, Right, Mid, InStr (Rajanikant)
	function Left(str, n)
	 {
        if (n <= 0)     // Invalid bound, return blank string
                return "";
        else if (n > String(str).length)   // Invalid bound, return
                return str;                // entire string
        else // Valid bound, return appropriate substring
                return String(str).substring(0,n);
	}

	function Right(str, n)
    {
        if (n <= 0)     // Invalid bound, return blank string
            return "";
        else if (n > String(str).length)   // Invalid bound, return
            return str;                     // entire string
        else { // Valid bound, return appropriate substring
            var iLen = String(str).length;
            return String(str).substring(iLen, iLen - n);
        }
    }
	
	function Mid(str, start, len)
    {
            // Make sure start and len are within proper bounds
            if (start < 0 || len < 0) return "";

            var iEnd, iLen = String(str).length;
            if (start + len > iLen)
                    iEnd = iLen;
            else
                    iEnd = start + len;

            return String(str).substring(start,iEnd);
    }
    
	function InStr(strSearch, charSearchFor)
	/*
	InStr(strSearch, charSearchFor) : Returns the first location a substring (SearchForStr)
							was found in the string str.  (If the character is not
							found, -1 is returned.)
	Requires use of:
		Mid function
		Len function
	*/
	{
		for (i=0; i < Len(strSearch); i++)
		{
			if (charSearchFor == Mid(strSearch, i, 1))
			{
				return i;
			}
		}
		return -1;
	}
	
	function Len(str)
    {  
		return String(str).length;  
	}

// end of string functiond Left. Right, Mid, InStr


// "--" validation for queryies!
	function CheckComment(strCheckQuery)
	{
		var CheckComment = 0;
		var intFirstPos;
		intFirstPos = strCheckQuery.indexOf('--');
		if (intFirstPos == 0) return 0;
		if (Occurence(Mid(strCheckQuery,1,intFirstPos - 1 ), "'", 1) == 1)
		{
			return 2;
		}
		else
		{
			//alert("Comments (--) are not allowed.");
			return 1
		}
	}

	function Occurence(strValue,strSearch,intStart)
	{
		var intCnt,intStart;
		var strQ;
		intCnt=0;
		
		strQ = new String(strValue);
		if(strQ.indexOf(strSearch) != -1)
		{					
			while(strQ.indexOf(strSearch,intStart) != -1) 
			{
				intStart = strQ.indexOf(strSearch,intStart)+1;
				intCnt += 1;							  
			}
			intCnt = intCnt % 2;	
		}
		
		return intCnt;				
	}
	
	function IsValidURL(strURL) {
			/*
			'=====================================================================
			' Procedure Name        :   IsValidURL
			' Description           :   Validates if the text entered is a valid URL.
			' Purpose               :   Validates if the text entered is a valid URL.
			' Parameters Passed     :   URL to be validated.
			' Returns               :	True/False
			' Parameters Affected   :   None
			' Assumptions           :
			' Dependencies          :
			' Author                :   RajaniR
			' Created               :   11th September 2000
			' Revisions             :
			'=====================================================================
			*/		
			// Are regular expressions supported ?
			var supported = 0;					
			
			//var r1 = new RegExp("http[s]*://(\\[?)[a-zA-Z0-9\\-\\_\\.]+(\\]?)(/[a-zA-Z0-9\\-\\.\\_\\?\\=\\%\\&]*)*$", "i");						
			//Commented & modified below MonikaI On 6-Apr-10 For RequestID-25380
			//var r1 = new RegExp("http[s]*://(\\[?)[a-zA-Z0-9\\-\\_\\.]+(\\]?)(/[a-zA-Z0-9\\-\\.\\_\\?\\=\\%\\&\\(\\)\\{\\ \\}\\~\\!\\@\\#\\$\\^\\+\\;\\[\\]\\,]*)*$", "i");
			var r1 = new RegExp("http[s]*://(\\[?)[a-zA-Z0-9\\-\\_\\.\\:]+(\\]?)(/[a-zA-Z0-9\\-\\.\\_\\?\\=\\%\\&\\(\\)\\{\\ \\}\\~\\!\\@\\#\\$\\^\\+\\;\\[\\]\\,\\:]*)*$", "i");
			//End by MonikaI on 6-Apr-10
			
			return (r1.test(strURL));						
		}	
		
//____________________________________________________________________
//			TIME VALIDATIONS	:	BEGIN
//			Added By			:	DipaliS, UmeshJ
//			Date				:	July 09, 2004
//____________________________________________________________________
		
	//-------------------------------------------------------------------
	// Time_OnKeyPress(e[,exclude Char])
	//   Only allow digits and 'exclude Char'
	//-------------------------------------------------------------------
	function Time_OnKeyPress(e)	
	{
		//Only Allow Numbers And ':'
		var sSep=(arguments.length>1)?arguments[1]:":";
		var code;
		var cancel;
		var excludeCode = sSep.charCodeAt(0)
		cancel=false;	
		if (e.keyCode) {code = e.keyCode;}
		else {if (e.which) {code = e.which;}
			}
				
		if(code < 48 || code > 57) {
				if(code != excludeCode) //58
					cancel=true;}
					
		if (cancel==true)	{
				if (e.keyCode) 
					e.keyCode=0;
				else
					if (e.which) 
							e.which=0;
			}			
	}
	 
	//-------------------------------------------------------------------
	// isTime(objTime[,message[,set focus][,Separator[,Min Allowed Hour[,Max Allowed Hour[,Min allowed minutes[,Max allowed minutes]]]]])
	//   Validate the time value in for hour and minutes format
	//	 calls the 	isTime_Main function
	//-------------------------------------------------------------------
	function isTime(obj)
	{
		if (isBlank(getInputValue(obj))) {return true;}
		
		var msg=(arguments.length>1)?arguments[1]:"";
		var dofocus=(arguments.length>2)?arguments[2]:true;
		var sSep=(arguments.length>3)?arguments[3]:":";
		var minHr=(arguments.length>4)?arguments[4]:0;
		var maxHr=(arguments.length>5)?arguments[5]:23;
		var minMin=(arguments.length>6)?arguments[6]:0;
		var maxMin=(arguments.length>7)?arguments[7]:59;
		msg=replaceSubstring(msg,"&#39;","'");

		if (isTime_Main(obj,sSep,minHr,maxHr,minMin,maxMin)) {return true;}
		else {
			if(!isBlank(msg)){alert(msg);}
			if(dofocus){
				setFocus(obj);
				}
			return false;
		}				
	}

	function isTime_Main(objTime)
	{
		var sSep=(arguments.length>1)?arguments[1]:":";
		var minHr=(arguments.length>2)?arguments[2]:0;
		var maxHr=(arguments.length>3)?arguments[3]:23;
		var minMin=(arguments.length>4)?arguments[4]:0;
		var maxMin=(arguments.length>5)?arguments[5]:59;

		var time=objTime.value;	var index;	index=time.indexOf(sSep);					
		//If sSep not entered or hour is more than 2 digit then return false.
		if(index <= 0 || index > 2){return false; }
		else {
			//If minute is not entered return false.
			if(index==time.length-1 || index+2 != time.length-1){return false; }
			else {
					var hour,minute,minPart1;
					try
					{hour=parseInt(time.substring(0,index),10);if (isNaN(hour)){return false;}}
					catch(e)
					{return false;}
					
					if ( hour < minHr || hour > maxHr)
					{return false;}

					try
					{minute=parseInt(time.substring(index+1,time.length),10);if (isNaN(minute)){return false;}}
					catch(e)
					{return false;}
					
					if(minute < minMin || minute > maxMin)
					{return false;}				
					
			}										
		} 
		return true;	
	}
//____________________________________________________________________
//			TIME VALIDATIONS	:	END
//____________________________________________________________________

//Time And Date-Time Validations
//Added By : DipaliS
//Date	   : 17 Sep 2004



	//-------------------------------------------------------------------
	// disAllowTime1GreaterThanTime2(objTime1,objTime2[,message[,set focus])
	//   if the value of the from field 1 is greater than value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowTime1GreaterThanTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		//If Hour of Time 1 is > than Hour of Time 2 return true
		if(hr1 > hr2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
			
		//If Hour Values are same, then compare the minute values
		if(hr1==hr2)
		{
			if(min1>min2)
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
					
		return false;
			
}
	
	//-------------------------------------------------------------------
	// disAllowTime1LessThanTime2(objTime1,objTime2[,message[,set focus])
	//   if the value of the from field 1 is less than value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowTime1LessThanTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		//If Hour of Time 1 is < than Hour of Time 2 return true
		if(hr1 < hr2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		
		//If Hour Values are same, then compare the minute values	
		if(hr1==hr2)
		{
			if(min1<min2)
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
					
		return false;
			
}


	//-------------------------------------------------------------------
	// disAllowTime1EqualToTime2(objTime1,objTime2[,message[,set focus])
	//   if the value of the from field 1 is equal to value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
function disAllowTime1EqualToTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		//If both the Hour and Minute Values Are Same then return true.
		if(hr1 == hr2 && min1==min2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
			
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowTime1NotEqualToTime2(objTime1,objTime2[,message[,set focus])
	//   if the value of the from field 1 is not equal to value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
function disAllowTime1NotEqualToTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		//If Any of the Hour or Minute Values are not matching then return true
		if(hr1 != hr2 || min1 != min2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
			
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowTime1GreaterThanOrEqualToTime2(objTime1,objTime2[,message[,set focus],msgInvalid1,msgInvalid2)
	//   if the value of the from field 1 is greater than or equal to value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
function disAllowTime1GreaterThanOrEqualToTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		
		//If Hour of Time 1 is > than Hour of Time 2 return true
		if(hr1 > hr2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
			
		//If Hour Values are same, then compare the minute values
		if(hr1==hr2)
		{
			if(min1>min2 || min1==min2)
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
		
			
		return false;
			
}
	
	//-------------------------------------------------------------------
	// disAllowTime1LessThanOrEqualToTime2(objTime1,objTime2[,message[,set focus])
	//   if the value of the from field 1 is less than or equal to value of form field 2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
	
function disAllowTime1LessThanOrEqualToTime2(objTime1,objTime2)
{
		
		var msg=(arguments.length>2)?arguments[2]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>3)?arguments[3]:true;
		var msgInvalid1=(arguments.length>4)?arguments[4]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>5)?arguments[5]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Validate the time values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
			
		//Get the two time values
		var time1=objTime1.value;
		var time2=objTime2.value;
				
		var hr1,hr2,min1,min2;
		var indexOfSem1,indexOfSem2;
		
		//Get the Index of ":" for the time values
		indexOfSem1=time1.indexOf(":");
		indexOfSem2=time2.indexOf(":");
		
		//Get the Minute And Hour Values By Splitting at ":"
		hr1=time1.substring(0,indexOfSem1);
		hr2=time2.substring(0,indexOfSem2);
		min1=time1.substring(indexOfSem1+1,time1.length);
		min2=time2.substring(indexOfSem2+1,time2.length);
		
		hr1=parseInt(hr1,10);
		hr2=parseInt(hr2,10);
		min1=parseInt(min1,10);
		min2=parseInt(min2,10);
		
		
		//If Hour of Time 1 is < than Hour of Time 2 return true
		if(hr1 < hr2)	
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
			
		//If Hour Values are same, then compare the minute values
		if(hr1==hr2)
		{
			if(min1<min2 || min1==min2)
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
		
			
		return false;
			
}


	//-------------------------------------------------------------------
	// disAllowDateTime1GreaterThanDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is greater than Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
function disAllowDateTime1GreaterThanDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		
		//Date Formats if provided
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;

		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		//Date1 Cannot be Greater than Date2
		if(disallowDate1GreaterThanDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
		{
//alert(objDate1.value);
			return true;
		}
		//If Date1 is equal to Date 2
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Compare for the Time Values as Time1 cannot be Greater than Time2
			if(disAllowTime1GreaterThanTime2(objTime1,objTime2,msg,dofocus))
			return true;			
		}
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowDateTime1LessThanDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is less than Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------	
function disAllowDateTime1LessThanDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Date Formats if provided
		
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;
			
		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		
		//Date1 Cannot be Less than Date2
		if(disallowDate1LessThanDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
			return true;
					
		//If Date1 is equal to Date 2
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Compare for the Time Values as Time1 cannot be Less than Time2
			if(disAllowTime1LessThanTime2(objTime1,objTime2,msg,dofocus))
			return true;
		}
					
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowDateTime1EqualToDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is equal Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowDateTime1EqualToDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Date Formats if provided
		
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;
			
		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		
		//If both Date and Time Are matching then return true
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			if(disAllowTime1EqualToTime2(objTime1,objTime2,msg,dofocus))
			return true;
		}
					
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowDateTime1NotEqualToDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is not equal Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowDateTime1NotEqualToDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Date Formats if provided
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;
			
		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		
		if(disallowDate1NotEqualToDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
			return true;
			
		
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Compare for the Time Values as Time1 cannot be equal to Time2
			if(disAllowTime1NotEqualToTime2(objTime1,objTime2,msg,dofocus))
			return true;
		}
		
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowDateTime1GreaterThanOrEqualToDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is greater then or equal to Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowDateTime1GreaterThanOrEqualToDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Date Formats if provided
		
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;
			
		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		
		//Date1 Cannot be Greater than Date1
		if(disallowDate1GreaterThanDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
			return true;
			
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Time1 cannot be greater than or equal to Time2
			if(disAllowTime1GreaterThanTime2(objTime1,objTime2) || disAllowTime1EqualToTime2(objTime1,objTime2))
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
					
		return false;
			
}

	//-------------------------------------------------------------------
	// disAllowDateTime1LessThanOrEqualDateTime2(objDate1,objTime1,objDate2,objTime2[,message[,set focus])
	//   if the value of the from field Date1-Time1 is less then or equal to Date2-Time2
	//	 then show the message and return true.
	//-------------------------------------------------------------------
function disAllowDateTime1LessThanOrEqualDateTime2(objDate1,objTime1,objDate2,objTime2)
{
		
		var msg=(arguments.length>4)?arguments[4]:"";
		msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>5)?arguments[5]:true;
		var msgInvalid1=(arguments.length>6)?arguments[6]:"";
		msgInvalid1=replaceSubstring(msgInvalid1,"&#39;","'");
		var msgInvalid2=(arguments.length>7)?arguments[7]:"";
		msgInvalid2=replaceSubstring(msgInvalid2,"&#39;","'");
		
		//Date Formats if provided
		
		var date1format; //Format for Date1
		if (arguments.length>8) 
		{
			if (isNull(arguments[8])) {date1format=defaultDateFormat;}
			else if (!isBlank(arguments[8])) {date1format=arguments[8];}
			else {date1format=defaultDateFormat;}
		}
		else 
			date1format=defaultDateFormat;
			
		var date2format=(arguments.length>9)?arguments[9]:defaultDateFormat;
		
		//Validate the time Values
		if(isTime(objTime1,msgInvalid1)==false || isTime(objTime2,msgInvalid2)==false)
			return true;
		
		//Date1 Cannot be Less than Date1
		if(disallowDate1LessThanDate2(objDate1,objDate2,msg,dofocus,date1format,date2format))
			return true;
			
		if(disallowDate1EqualToDate2(objDate1,objDate2)==true)
		{
			//Time1 cannot be less than or equal to Time2
			if(disAllowTime1LessThanTime2(objTime1,objTime2) || disAllowTime1EqualToTime2(objTime1,objTime2))
			{
			if(!isBlank(msg))
					alert(msg);
			if(dofocus)
					setFocus(objTime1);
			return true;
			}
		}
					
		return false;
			
}
//End Time And Date-Time Validations

//Added By UmeshJ on 29th Sep 2004
//-------------------------------------------------------------------
// restrictDecimal(input_object[,decimalPlaces[,message[,true]]])
//   Restrict the number to the specified number of decimal places
//-------------------------------------------------------------------
function restrictDecimal(obj){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var decimalPlaces=(arguments.length>1)?arguments[1]:2;
	var msg=(arguments.length>1)?arguments[2]:"";
	var string=obj.value;
	if (string.indexOf(".")==-1) {return false;}
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[3]:true;	
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if ((string.length - string.indexOf(".")-1) > decimalPlaces)
	{
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;	
	}
	return false;
}
//End of addition

//-------------------------------------------------------------------
//   validateEmailID(input_object[,message[,true]])
//   Validate the Email ID
//	 return true if the Email ID is valid
//   Hot Fix Id : 2.0.36-SP4-WAF
//   Added By Ninad
//   Date 7 Sept 2006
//-------------------------------------------------------------------
function validateEmailID(obj){
	if (obj == null) {return true;} 
	if (isBlank(getInputValue(obj))) {return true;}
	var re_mail =/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z])+$/;
	var msg=(arguments.length>1)?arguments[1]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>2)?arguments[2]:true;
	if (!re_mail.test(obj.value)){
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return false;
		}
	return true;
	}
//-------------------------------------------------------------------
// AllowNumbers_OnKeyPress(e[,exclude Char])
//   Only allow digits and 'excluded Char'
//-------------------------------------------------------------------
function AllowNumbers_OnKeyPress(e)	
{
	//Only Allow Numbers And the 'exclude Char' e.g. "."
	var excludeChar=(arguments.length>1)?arguments[1]:"";
	var code;
	var cancel;
	var excludeCode; 
	if (!isBlank(excludeChar)) {excludeCode=excludeChar.charCodeAt(0)}
	
	cancel=false;	

	if (e.keyCode) {code = e.keyCode;}
	else if (e.which) {code = e.which;}

	if(code < 48 || code > 57) {
		if (!isBlank(excludeChar) && (code == excludeCode))
				cancel=false; //exclude character
		else 
				cancel=true;	
	}
	if (cancel==true)	{
			if (e.keyCode) 
				e.keyCode=0;
			else
				if (e.which) 
						e.which=0;
		}			
}

/* Start : Added By SumitS on 12 July 2006 Req. ID WAF3_GEN_4   */
		var g_objXHttp_MultiInset;
		var g_strResponseText_MultiInset;
		
		function CheckDBDuplicate(TableName, ColumnName, RowCount, DBColumnName, ForeignKeyColumnName,ForeignKeyDataType,ForeignKeyValue,MatchCase)
		{
			var i;
			var ColumnContent = "";
			for (i = 0; i < RowCount; i++)
			{	
				var TempVar = ColumnName + i;
				var oObj = GetObjectReference("", TempVar);
				if (oObj.value != "")
				{					
					if (ColumnContent == "")
						ColumnContent = ColumnContent + oObj.value;
					else
						ColumnContent = ColumnContent +  "," + oObj.value;						
				}
			}
			//Create the url to send the request to
			
			var strurl = "../General/Validate.aspx?ColumnContent=" + EncodeURLString(ColumnContent) + "&ColumnName=" + DBColumnName + "&TableName=" + TableName + "&Caption=" + EncodeURLString(ColumnName);
			strurl += "&ForeignKeyColumnName=" + ForeignKeyColumnName + "&ForeignKeyDataType=" + ForeignKeyDataType + "&ForeignKeyValue=" + EncodeURLString(ForeignKeyValue) + "&MatchCase=" + MatchCase;

			var strNavigator = navigator.appName;
			strNavigator = strNavigator.toUpperCase();
			if(strNavigator == "MICROSOFT INTERNET EXPLORER")
			{ 
				g_objXHttp_MultiInset = new ActiveXObject("Msxml2.XMLHTTP"); 
				//hook the event handler
				g_objXHttp_MultiInset.onreadystatechange = CheckState;
				
				//prepare the call, http method=GET, false=asynchronous call
				g_objXHttp_MultiInset.open("GET",strurl, false);
				//finally send the call
				g_objXHttp_MultiInset.send();
			}
			else
			{
				// Mozilla - based browser , Netscape
				g_objXHttp_MultiInset = new XMLHttpRequest();
				//hook the event handler
				g_objXHttp_MultiInset.onreadystatechange =  CheckState();
				//prepare the call, http method=GET, false=asynchronous call
				g_objXHttp_MultiInset.open("GET",strurl, false);
				//finally send the call
				g_objXHttp_MultiInset.send(null);
			}
			if (g_strResponseText_MultiInset != null)
			{
				g_objXHttp_MultiInset = null;
				return g_strResponseText_MultiInset;
			}
			else
			{
				g_objXHttp_MultiInset = null;
				return 'FALSE';
			}
		}
		
		function CheckState()
		{
			if (g_objXHttp_MultiInset.readyState==4)
			{			
				if (g_objXHttp_MultiInset.responseText != null)
				{
					g_strResponseText_MultiInset = g_objXHttp_MultiInset.responseText;
				}
			}
		}
		
		function EncodeURLString(strURL)
		{	var intIDX = 0;
			if (strURL != null && strURL != "")
			{	strURL = escape(strURL);
				while (intIDX >-1)
				{
					strURL = strURL.replace("+","%2B");	//	Plus		-> %2B
					intIDX = strURL.indexOf("+");
				}				
			}
			return strURL;
		}
		
		/* End : Added By SumitS on 12 July 2006 Req. ID WAF3_GEN_4   */

//Disable mouse right click Script WAF3_PB_35
function disableRightClick() {document.oncontextmenu=new Function("return false");}

//2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 START
function disallowFileNameLengthGreaterThanMax(obj,maxLength)
{
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>2)?arguments[2]:"";
	msg=replaceSubstring(msg,"&#39;","'");
	var dofocus=(arguments.length>3)?arguments[3]:true;
	if (parseFloat(ExtractFileName(getInputValue(obj)).length) > parseFloat(maxLength)) {
		if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			setFocus(obj);
			}
		return true;
	}	
	return false;
}
function ExtractFileName(FilePath)
{ 	return FilePath.substring(FilePath.lastIndexOf("\\")+1,FilePath.length)	}
//2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 END
function CheckDuplicate_MultiInsertGrid(ControlName,Msg,RowIndex)
{
/*
Function Name   :   CheckDuplicate_MultiInsertGrid
Input Parameters:   ControlName - control name for which we need to check duplicate entries
                    Msg - Message to show
                    RowIndex - Row index of control
                    arguments[3] - flag to identify whether it is date control
                    arguments[4] - flag to identify whether to match case for validation
Desc            :   To check duplicate control values in grid rows
Author          :   NinadP
Created         :   10 Dec 2007
ReqID           :   WAF3_PB_55
*/
    var IsDate=(arguments.length>3)?arguments[3]:false;
    var MatchCase = (arguments.length > 4) ? arguments[4] : false;

    //Added by Dhanashri S on 8 Dec 2015
    //Added by Vinay on 03 DEC. 2008 WAF3_GEN_18
    var isNumericData = (arguments.length > 5) ? arguments[5] : false;
    if (isNumericData) {
        if (!isNaN(ControlName.value)) {
            ControlName.value = parseFloat(ControlName.value);
        }
    }
    //Addition End by Vinay on 03 DEC. 2008 WAF3_GEN_18
    //End of Addition by Dhanashri S on 8 Dec 2015


    var controlArray = document.getElementsByName(ControlName);
    var objControl=controlArray[RowIndex];
        for (var j = RowIndex+1; j < controlArray.length; j++) 
        {

                if(IsDate==false)
                {
                    if(disallowValue1EqualToValue2(controlArray[j],objControl,Msg,false,MatchCase))
                    {
                        setFocus_MultiInsertGrid(controlArray[j],j)
                        return false;
                     }   
                }
                else
                {
                    if(disallowDate1EqualToDate2(controlArray[j],objControl,Msg,false))
                    {
                        setFocus_MultiInsertGrid(controlArray[j],j)
                        return false;
                     }   
                }
           
        }
return true
}

function setFocus_MultiInsertGrid(obj,RowIndex)
{
/*
Function Name   :   setFocus_MultiInsertGrid
Input Parameters:   obj - control object on which we need to set focus
                    RowIndex - Row index of control
Desc            :   To set focus on control.
Author          :   NinadP
Created         :   10 Dec 2007
ReqID           :   WAF3_PB_55
*/
	try{
		if (document.getElementById('FFE29587WHIZ_' + obj.name)!=null || document.getElementById('anc' + obj.name)!=null)
		{
		    var controlplaceHolder;
		    if (document.getElementById('FFE29587WHIZ_' + obj.name)!=null)
		        controlplaceHolder='FFE29587WHIZ_';
		    else    
		        controlplaceHolder='anc';
            obj=document.getElementsByName(controlplaceHolder + obj.name)[RowIndex];		        
    	}        
		obj.focus();
	    }
	    catch(e){}
}	    


//End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
//Added By Ninad on 29 Feb 2008, SRID 19375 - Show alert if form data is change and yet is not saved
var strControlsForNavAlerts='';
function isFormDataChanged(strMsg) 
{
var rtnVal = false; 
//	//loop through Header Section Controls
var objdiv = document.getElementById('divSection1');
var ele = objdiv.all;
for ( i=0; i < ele.length; i++ ) 
{
		if ( ele[i].type!=null ) 
		{
		    if (strControlsForNavAlerts.indexOf(',' + ele[i].name + ',')!=-1) 		    {
		    if ( isElementChanged( ele, i )) 
			    {
				    rtnVal = true;
				    break;
		    }
			}    
	}
	}
	if (rtnVal==false)
	{   //loop through Footer Section Controls
	    var objdiv = document.getElementById('divSection5');
    if (objdiv==null) return false;
	    var ele = objdiv.all;
	    for ( i=0; i < ele.length; i++ ) 
	    {
		    if ( ele[i].type!=null ) 
		    {
		        if (strControlsForNavAlerts.indexOf(',' + ele[i].name + ',')!=-1) 
		        {
			        if ( isElementChanged( ele, i )) 
			        {
				        rtnVal = true;
				        break;
			        }
			    }    
		    }
	    }
	} 
	if (rtnVal==true)
	{
	    if(confirm(strMsg)==false)
	        rtnVal=true;
	    else    
	        rtnVal=false;
	}
	return rtnVal;
}
function isElementChanged( ele, i ) 
{
var isEleChanged = false; 
switch ( ele[i].type ) 
{ 
	case "text" :
		if ( ele[i].value != ele[i].defaultValue ) return true;
			break;
			
	case "password" :
		if ( ele[i].value != ele[i].defaultValue ) return true;
			break;		
	
	case "textarea" : 
		if ( ele[i].value != ele[i].defaultValue ) return true;
			break;

	case "select-one" : 
		var blndefaultSelected = false;
		for ( var x =0 ; x <ele[i].length; x++ ) 
		{
			if (ele[i].options[ x ].defaultSelected==true)
			{
				 	blndefaultSelected=true;		
					break;	
			}
		}
		if (ele[i].selectedIndex==0 && blndefaultSelected==false) return false;
		for ( var x =0 ; x <ele[i].length; x++ ) 
		{
			if ( ele[i].options[ x ].selected != ele[i].options[ x ].defaultSelected ) return true;
		}
		break;

	case "checkbox" :
	if ( ele[i].checked != ele[i].defaultChecked ) return true;
	        break;
	case "radio" :
		if ( ele[i].checked != ele[i].defaultChecked ) return true;
			break;
	case "select-multiple" :
		for ( var x =0 ; x <ele[i].length; x++ ) 
		{
			if ( ele[i].options[ x ].selected != ele[i].options[ x ].defaultSelected ) return true;
		}
		break;

	default:
		return false;
	break;
}
}


//End Addition By Ninad on 29 Feb 2008, SRID 19375

//Added by Dhanashri S on 7 Dec 2015
function disallowDuplicatesUsingAjax(obj, TagID) {
    /*
    Function Name   :   disallowDuplicatesUsingAjax
    Input Parameters:   obj - control object on which we need to set focus
                        TagID - TagID of page
                        arguments[2] - Message to show
                        arguments[3] - If true then set focus
                        arguments[4] - If true then match case
                        arguments[5] - 
    Desc            :   To set focus on control.
    Author          :   NinadP
    Created         :   10 Dec 2007
    ReqID           :   WAF3_PB_55
    */
    if (blnPerformAJAXValidation == false) {
        blnPerformAJAXValidation == true;
        return false;
    }
    if (obj.defaultValue == obj.value) { return false; }
    if (obj == null) { return false; }
    if (isBlank(getInputValue(obj))) { return false; }
    var msg = (arguments.length > 2) ? arguments[2] : "";
    msg = replaceSubstring(msg, "&#39;", "'");
    var dofocus = (arguments.length > 3) ? arguments[3] : true;
    var matchCase = (arguments.length > 4) ? arguments[4] : true;
    var numbericData = (arguments.length > 5) ? arguments[5] : false;
    var blnReturnFlag = true;
    var OriginalValue = obj.defaultValue;
    var CurrentValue = obj.value;
    try {
        var strUrl = "../SM/PB_XMLHttpRequestHandler.aspx?operation=CHECKDUPLICATEVALIDATION&ControlName=" + EncodeURLString(obj.name) + "&TagID=" + TagID + "&OriginalValue=" + EncodeURLString(OriginalValue) + "&CurrentValue=" + EncodeURLString(CurrentValue) + "&CheckDuplicateSQL=" + EncodeURLString(document.getElementById('hdValidationSQL_' + obj.name).value) + "&MatchCase=" + matchCase + "&IsNumeric=" + numbericData;
        var objXHttp;
        var strNavigator = navigator.appName;
        strNavigator = strNavigator.toUpperCase();
        if (strNavigator == "MICROSOFT INTERNET EXPLORER") {
            objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
            //hook the event handler
            //prepare the call, http method=GET, false=asynchronous call
            objXHttp.open("GET", strUrl, false);
            //finally send the call
            objXHttp.send();
            if (objXHttp.responseText != null) {
                if (objXHttp.responseText == 'true') {
                    if (!isBlank(msg)) { alert(msg); }
                    if (dofocus) {
                        setFocus(obj);
                        blnReturnFlag = true;
                    }
                }
                else
                    blnReturnFlag = false;
            }
        }
        else {
            // Mozilla - based browser , Netscape
            objXHttp = new XMLHttpRequest();
            //hook the event handler
            objXHttp.onreadystatechange = function () {
                if (objXHttp.readyState == 4) {
                    if (objXHttp.responseText != null) {
                        if (objXHttp.responseText == 'true') {
                            if (!isBlank(msg)) { alert(msg); }
                            if (dofocus) { setFocus(obj); }
                            blnReturnFlag = true;
                            blnPerformAJAXValidation = true;
                        }
                        else {
                            blnReturnFlag = false;
                            blnPerformAJAXValidation = false;
                            eval(strFunctionCallFromDisallowDuplicatesUsingAjax);
                        }
                    }
                }
            }
            //prepare the call, http method=GET, false=asynchronous call
            objXHttp.open("GET", strUrl, true);
            //finally send the call
            objXHttp.send(null);
        }
    }
    catch (e) { alert('Error occured while sending XMLHTTP request for check duplication validation') }
    return blnReturnFlag;
}
//End of Addition by Dhanashri S on 7 Dec 2015

//Added By Nikhil A on 2 May 2022 for encrypting the Parameter of API
function encryptString(value) {
	var intStrArr; 
	intStrArr = [];
	var strEncryptedString = "";
	var intEncryptNum = 1;
	var i;
	if (String(value).length > 0) {
		for (i = 0; i <= value.length - 1; i++) {
			intStrArr[i] = String(String(String(value[i])).charCodeAt(0) + intEncryptNum);
			intEncryptNum = intEncryptNum + 2;
		}
		strEncryptedString = intStrArr.join("-");
		if (String(strEncryptedString).substring(0, 1) == "-") {
			strEncryptedString = String(strEncryptedString).substring(1, String(strEncryptedString).length - 1)
		}
	}
	return strEncryptedString;
}
function isJson(str) {
	try {
		JSON.parse(str);
	} catch (e) {
		return false;
	}
	return true;
} 
//End Of Added BY Nikhil A
//End of Addition by Dhanashri S on 7 Dec 2015