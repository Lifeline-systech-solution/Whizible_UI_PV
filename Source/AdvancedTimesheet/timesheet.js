// JScript File


		
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
			
				var objtxtpageNumber =  GetObjectReference('','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"Please enter page number !",true) && (!disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true)) & (!disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
					
						alert("Invalid Page Number !");
						return;
					}
					Page_Onclick(objtxtpageNumber.value);
				}	
			}
		
		}
    function validateNumPaging()
    {

        
		
		
			    
		if(disallowBlank(objtxtpageNumber,"Please enter page number !",true))
		    return false;
		if(disallowNonNumeric(objtxtpageNumber,"Page number should be numeric only !",true))
		    return false;
		if(disallowNegativeNumeric(objtxtpageNumber,"Only positive number allowed !",true))
		    return false;            	    
		if(disallowNonInteger(objtxtpageNumber,"Only positive integer number allowed !",true))
		    return false;
		
		if (Number(objtxtpageNumber.value) ==0)
		{
						alert("Page number should be greater than zero!");
						return false;
		}        
	    
    	
	    if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
	    {
		    alert("Please enter value within range of 1 to "+noOfPages);
		    return false;
	    }
	    return true;
    }
    function ShowPreviousPage()
    {
	    if (isBlank(objtxtpageNumber.value))
		    Page_Onclick(1);
	    else
	    {
		    if(!validateNumPaging())
		    return;
    		
		    if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			    objtxtpageNumber.value=objtxtpageNumber.value -1;
		    Page_Onclick(objtxtpageNumber.value);
	    }
    		
    }
    function ShowFirstPage()
    {
	    if (isBlank(objtxtpageNumber.value))
		    Page_Onclick(1);
	    else
	    {
		    if(!validateNumPaging())
		    return;
		    if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		    objtxtpageNumber.value=1;
		    Page_Onclick(objtxtpageNumber.value);
	    }
    }
    function ShowNextPage()
    {
	    if (isBlank(objtxtpageNumber.value))
		    Page_Onclick(1);
	    else
	    {  

		    if(!validateNumPaging())
		    return;
		    if (objtxtpageNumber.value==parseInt(noOfPages)){alert("This is the last page");return;}		 
		    objtxtpageNumber.value=parseInt(objtxtpageNumber.value) + 1;
    				 
		    Page_Onclick(objtxtpageNumber.value);
    		 
	    }
    }
    function ShowLastPage()
    {
	    if (isBlank(objtxtpageNumber.value))
		    Page_Onclick(noOfPages);
	    else
	    {	
		    if(!validateNumPaging())
		    return;
		    if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		    objtxtpageNumber.value=noOfPages;
		    Page_Onclick(objtxtpageNumber.value);
	    }
    }