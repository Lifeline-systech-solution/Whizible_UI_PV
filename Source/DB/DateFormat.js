 
 
 function callcalendarNew(formname,datefield1,datefield2)
	{
	
	 
		var objdateObject1=GetObjectReference(formname,datefield1);
		var objdateObject2=GetObjectReference(formname,datefield2);
		
		//var objdateObject2="window.document.forms['" + formname + "'].elements['" + datefield2 + "']";
		//alert(objdateObject2);
		if (objdateObject2.disabled==true) {return;}
		var dtval;
	if(objdateObject1.value =='')
		dtval=objdateObject2.value;	
	else
		dtval=objdateObject1.value;
 	
 	//Issue ID 28888
	if (window.showModalDialog)
		calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield1 +'&formname=' + formname + '&dateval=' + dtval,'calendar_window','top=0,left=0,width=348,height=260');
	else
		calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield1 +'&formname=' + formname + '&dateval=' + dtval,'calendar_window','top=0,left=0,width=348,height=300');		
	
	calendar_window.focus()
	}

function GetFormat(originalDate,fmt1,fmt2)
{ 
		//alert('here');
		var i;
		var d='';
		var m='';
		var y='';
		//var newDate='';
		 
		if(fmt1=='dd,mmm yyyy')
		{
			 			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate.charAt(i) !=',')
				{
					d=d+originalDate.charAt(i);
					i++;
				}
								 
				i=i+2;
				
				//alert(originalDate.charAt(i));
				
				//while loop for paersing upto space to get month..
				while(originalDate.charAt(i) !=' ')
				{
					m=m+originalDate.charAt(i);
					i++;
				}
				
				m=convertIntoMonth(m);
				/*switch(m)
				{
					case 'Jan':
						m='01';
						break;
						
					case 'Feb':
						m='02';
						break;
						
					case 'Mar':
						m='03';
						break;
						
					case 'Apr':
						m='04';
						break;
						
					case 'May':
						m='05';
						break;
						
					case 'Jun':
						m='06';
						break;
						
					case 'Jul':
						m='07';
						break;
						
					case 'Aug':
						m='08';
						break;
						
					case 'Sep':
						m='09';
						break;
						
					case 'Oct':
						m='10';
						break;
						
					case 'Nov':
						m='11';
						break;
						
					case 'Dec':
						m='12';
						break;
						
				}*/
				 
				i++;
				while(i<originalDate.length)
				{
					y=y+originalDate.charAt(i);
					i++;
				}
				
				//alert('y'+y);
			}// End of For  loop..
			
			
				switch(fmt2)
				{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
									 newDate=y + '-' + m + '-' + d;
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
				}
				
				return newDate;
		}	// End of Firnst Date Format....	
		 
		 
	//Second Date Format
	
	
	if(fmt1=='mmm dd,yyyy')
		{
			for(i=0;i<originalDate.length;)
			{
								//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !=' ')
								{
									m=m+originalDate.charAt(i);
									i++;
								}
								 
								 m=convertIntoMonth(m);
								/*switch(m)
								{
									case 'Jan':
										m='01';
										break;
										
									case 'Feb':
										m='02';
										break;
										
									case 'Mar':
										m='03';
										break;
										
									case 'Apr':
										m='04';
										break;
										
									case 'May':
										m='05';
										break;
										
									case 'Jun':
										m='06';
										break;
										
									case 'Jul':
										m='07';
										break;
										
									case 'Aug':
										m='08';
										break;
										
									case 'Sep':
										m='09';
										break;
										
									case 'Oct':
										m='10';
										break;
										
									case 'Nov':
										m='11';
										break;
										
									case 'Dec':
										m='12';
										break;
										
								} */
								i=i+1;
								
								//alert(originalDate.charAt(i));
								
								//while loop for paersing upto space to get month..
								while(originalDate.charAt(i) !=',')
								{
									d=d+originalDate.charAt(i);
									i++;
								}
								
								
								//alert('m'+m);
								i++;
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									i++;
								}
				
				//alert('y'+y);
			}//End of For loop....
			
			
			switch(fmt2)
				{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
									 //Modified By VarunA on 6-Aug-2008 RequestID-14286
									 //Purpose : To have month place instead of day
									 //newDate=y + '-' + d + '-' + m;
									 newDate=y + '-' + m + '-' + d;
									 //End By VarunA on 6-Aug-2008 RequestID-14286
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
				}
				
				return newDate;
		} //End of if..
		
// Third Format.....
		if(fmt1=='mm/dd/yyyy')
		{
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									i++;
								}
								
								//m=convertIntoMonth(m);
								
				
								i++;
				
								while(originalDate.charAt(i) !='/')
								{
									d=d+originalDate.charAt(i);	
									i++;
								}
								i++;
								
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									i++;
								}
					}//End of For Loop....
		
		
					switch(fmt2)
					{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
									 //Modified By VarunA on 6-Aug-2008 RequestID-14286
									 //Purpose : To have month place instead of day
									 //newDate=y + '-' + d + '-' + m;
									 newDate=y + '-' + m + '-' + d;
									 //End By VarunA on 6-Aug-2008 RequestID-14286
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
					}
				
					return newDate;
					}//End of if....
		 
		 
		 
		 // FOurth Format....
		 
		  
		if(fmt1=='dd/mm/yyyy')
		{
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
									d=d+originalDate.charAt(i);	
									i++;
								}
								i++;
								
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									i++;
								}
								
								//m=convertIntoMonth(m);								
				
								i++;
				
								
								
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									i++;
								}
					}//End of For Loop....
		
		
					switch(fmt2)
					{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
							         //Modified By VarunA on 6-Aug-2008 RequestID-14286
									 //Purpose : To have month place instead of day
									 //newDate=y + '-' + d + '-' + m;
									 newDate=y + '-' + m + '-' + d;
									 //End By VarunA on 6-Aug-2008 RequestID-14286
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
					}
					
				//alert('date :'+newDate);
					return newDate;
					}//End of if....
					
					 
		// Fifth Format....
		 
		  
		if(fmt1=='yyyy/MM/dd')
		{
		    for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
									y=y+originalDate.charAt(i);	
									i++;
								}
								i++;
								
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									i++;
								}
								
								//m=convertIntoMonth(m);								
				
								i++;
				
								
								
								while(i<originalDate.length)
								{
									d=d+originalDate.charAt(i);
									i++;
								}
					}//End of For Loop....
		
		
					switch(fmt2)
					{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
							         //Modified By VarunA on 6-Aug-2008 RequestID-14286
									 //Purpose : To have month place instead of day
							         //newDate=y + '-' + d + '-' + m;
									 newDate=y + '-' + m + '-' + d;
									 //End By VarunA on 6-Aug-2008 RequestID-14286
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
					}
					
				//alert('date :'+newDate);
					return newDate;
					}//End of if....
					
					
		// Sixth Format....		 
		  
		if(fmt1=='dd-mmm-yyyy')
		{
		    for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='-')
								{
									d=d+originalDate.charAt(i);	
									i++;
								}
								i++;
																								
								while(originalDate.charAt(i) !='-')
								{
									m=m+originalDate.charAt(i);	
									i++;
								}
								//Modified By VarunA on 6-Aug-2008 RequestID-14286
								//Purpose : To have month integer instead of name.
								m=convertIntoMonth(m);
								//End By VarunA	on 6-Aug-2008 RequestID-14286							
								i++;
				
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									i++;
								}
					}//End of For Loop....
		
		            switch(fmt2)
					{
			 
							case 'DD-MM-YYYY':
									 newDate=d + '-' + m + '-' + y;
									break;
									
							case 'DD/MM/YYYY':
									 newDate=d + '/' + m + '/' + y;
									break;
									
							case 'DD.MM.YYYY':
									 newDate=d + '.' + m + '.' + y;
									break;
									
									
							case 'MM-DD-YYYY':
									 newDate=m + '-' + d + '-' + y;
									break;
									
							case 'MM/DD/YYYY':
									newDate=m + '/' + d + '/' + y;
									break;
									
							case 'MM.DD.YYYY':
									 newDate=m + '.' + d + '.' + y;
									break;
									
							case 'YYYY-DD-MM':
									 newDate=y + '-' + d + '-' + m;
									break;
									
							case 'YYYY.DD.MM':
									 newDate=y + '.' + d + '.' + m;
									break;
									
							case 'YYYY/DD/MM':
									 newDate=y + '/' + d + '/' + m;
									break;
									
							case 'YYYY-MM-DD':
							          //Modified By VarunA on 6-Aug-2008 RequestID-14286
									 //Purpose : To have month place instead of day
									 //newDate=y + '-' + d + '-' + m;
									 newDate=y + '-' + m + '-' + d;
									 //End By VarunA on 6-Aug-2008 RequestID-14286
									break;
									
							case 'YYYY/MM/DD':
									 newDate=y + '/' + m + '/' + d;
									break;
									
							case 'YYYY.MM.DD':
									 newDate=y + '.' + m + '.' + d;
									break;
				
					}
					
				//alert('date :'+newDate);
					return newDate;
					}//End of if....
					
}//End of Function....



// Second Function for comparison of two dates..

function convertIntoMonth(month)
{
var m='';
    switch(month)
				{
					case 'Jan':
						m='01';
						 
						break;
						
					case 'Feb':
						m='02';
						 
						break;
						
					case 'Mar':
						m='03';
						 
						break;
						
					case 'Apr':
						m='04';
						 
						break;
						
					case 'May':
						m='05';
						 
						break;
						
					case 'Jun':
						m='06';
						 
						break;
						
					case 'Jul':
						m='07';
						 
						break;
						
					case 'Aug':
						m='08';
						 
						break;
						
					case 'Sep':
						m='09';
						 
						break;
						
					case 'Oct':
						m='10';
						 
						break;
						
					case 'Nov':
						m='11';
						 
						break;
						
					case 'Dec':
						 m='12';
						 
						break;
						
				}
				 
				return m;
}



function TaskEdit_DisallowDate1GreaterThanDate2(originalDate,originalDate2,originalDate1,fmt1,fmt2)
{
var d='';
var d1='';
var m='';
var m1='';
var y='';
var y1='';
var d2='';
var m2='';
var y2='';

//alert('here1');
		switch(fmt2)
		{
			case 'dd,mmm yyyy':
		
			 			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate.charAt(i) !=',')
				{
					d=d+originalDate.charAt(i);
					d2=d2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+2;
				
				//alert(originalDate.charAt(i));
				
				//while loop for paersing upto space to get month..
				while(originalDate.charAt(i) !=' ')
				{
					m=m+originalDate.charAt(i);
					m2=m2+originalDate2.charAt(i);
					i++;
				}
				
				
				var m=convertIntoMonth(m);
				var m2=convertIntoMonth(m2);
				
				 
				i++;
				while(i<originalDate.length)
				{
					y=y+originalDate.charAt(i);
					y2=y2+originalDate2.charAt(i);
					i++;
				}
				
				//alert('y'+y);
			}// End of For  loop..
			
			break;
			case 'mmm dd,yyyy':
			
			for(i=0;i<originalDate.length;)
			{
								//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !=' ')
								{
									m=m+originalDate.charAt(i);
									m2=m2+originalDate2.charAt(i);
									i++;
								}
								 
								//To get Month in integer.. 
								var m=convertIntoMonth(m);
								var m2=convertIntoMonth(m2);
								i=i+1;
								
								//alert(originalDate.charAt(i));
								
								//while loop for paersing upto space to get month..
								while(originalDate.charAt(i) !=',')
								{
									d=d+originalDate.charAt(i);
									d2=d2+originalDate2.charAt(i);
									i++;
								}
								
								
								//alert('m'+m);
								i++;
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									y2=y2+originalDate2.charAt(i);
									i++;
								}
				
				//alert('y'+y);
			}//End of For loop....
			
			break;
			
			case 'mm/dd/yyyy':
			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									m2=m2+originalDate2.charAt(i);	
									i++;
								}
								
								//To get Month in integer.. 
								//var m=convertIntoMonth(m);
								//var m2=convertIntoMonth(m2);
				
								i++;
				
								while(originalDate.charAt(i) !='/')
								{
									d=d+originalDate.charAt(i);	
									d2=d2+originalDate2.charAt(i);	
									i++;
								}
								i++;
								
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									y2=y2+originalDate2.charAt(i);
									i++;
								}
					}//End of For Loop....
		
		
			break;
			
			case 'dd/mm/yyyy':
			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
									d=d+originalDate.charAt(i);	
									d2=d2+originalDate2.charAt(i);	
									i++;
								}
								i++;
							 
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									m2=m2+originalDate2.charAt(i);	
									i++;
								}
								 
								//To get Month in integer.. 
								//var m=convertIntoMonth(m);
								//var m2=convertIntoMonth(m2);
				
								i++;
											
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									y2=y2+originalDate2.charAt(i);
									i++;
								}
								 
					}//End of For Loop....
					
			break;
			
            //Added By VarunA on 6-Aug-2008 RequestID-14286
            //Purpose : To have two new output format.
            case 'dd-mmm-yyyy':
			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='-')
								{
									d=d+originalDate.charAt(i);	
									d2=d2+originalDate2.charAt(i);	
									i++;
								}
								i++;
							 
								while(originalDate.charAt(i) !='-')
								{
									m=m+originalDate.charAt(i);	
									m2=m2+originalDate2.charAt(i);	
									i++;
								}
								 
								//To get Month in integer.. 
								var m=convertIntoMonth(m);
								var m2=convertIntoMonth(m2);
				
								i++;
											
								while(i<originalDate.length)
								{
									y=y+originalDate.charAt(i);
									y2=y2+originalDate2.charAt(i);
									i++;
								}
								 
					}//End of For Loop....
					
			break;
			
			case 'yyyy/MM/dd':
			
			for(i=0;i<originalDate.length;)
			{
				//while loop for paersing upto , to get day..
								while(originalDate.charAt(i) !='/')
								{
								    //Modified By VarunA on 18-Aug-2008 RequestID-14286
								    //d=d+originalDate.charAt(i);	
									//d2=d2+originalDate2.charAt(i);
								    y=y+originalDate.charAt(i);
									y2=y2+originalDate2.charAt(i);
									//End By VarunA on 18-Aug-2008 RequestID-14286
									i++;
								}
								i++;
							 
								while(originalDate.charAt(i) !='/')
								{
									m=m+originalDate.charAt(i);	
									m2=m2+originalDate2.charAt(i);	
									i++;
								}
								 
								//To get Month in integer.. 
								//var m=convertIntoMonth(m);
								//var m2=convertIntoMonth(m2);
				
								i++;
											
								while(i<originalDate.length)
								{
								    //Modified By VarunA on 18-Aug-2008 RequestID-14286
								    //y=y+originalDate.charAt(i);
									//y2=y2+originalDate2.charAt(i);
									d=d+originalDate.charAt(i);	
									d2=d2+originalDate2.charAt(i);	
									//End By VarunA on 18-Aug-2008 RequestID-14286
									i++;
								}
								 
					}//End of For Loop....
					
			break;
            //End By VarunA on 6-Aug-2008 RequestID-14286
        
		}//End of Switch case..



//For Sencond Date


switch(fmt1)
		{
			case 'DD-MM-YYYY':
									
			for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..

			break;
									
			case 'DD/MM/YYYY':
			
for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..

			break;
									
			case 'DD.MM.YYYY':
				for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..	 
			break;
									
									
			case 'MM-DD-YYYY':
					 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
								 
			i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'MM/DD/YYYY':
				 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'MM.DD.YYYY':
				 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'YYYY-DD-MM':
					 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				  
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
 
				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
				 
			}//End of For Loop..
			break;
									
			case 'YYYY.DD.MM':
				 for(i=0;i<originalDate1.length;)
				{
					//while loop for paersing upto , to get day..
					while(originalDate1.charAt(i) !='.')
					{
						y1=y1+originalDate1.charAt(i);
						//y2=y2+originalDate2.charAt(i);
						i++;
					}
									 
					i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'YYYY/DD/MM':
					  for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'YYYY-MM-DD':
					 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					d1=d1+originalDate1.charAt(i);
						//d2=d2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'YYYY/MM/DD':
				 for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				//Modified By VarunA on 6-Aug-2008 RequestID-14286
				//while(i<originalDate.length)
				while(i<originalDate1.length)
				//End By VarunA on 6-Aug-2008 RequestID-14286
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
									
			case 'YYYY.MM.DD':
				  for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					y1=y1+originalDate1.charAt(i);
					//y2=y2+originalDate2.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					//m2=m2+originalDate2.charAt(i);
					i++;
				}

				i++;
				//Modified By VarunA on 6-Aug-2008 RequestID-14286
				//while(i<originalDate.length)
				while(i<originalDate1.length)
				//End By VarunA on 6-Aug-2008 RequestID-14286
				{
					d1=d1+originalDate1.charAt(i);
					//d2=d2+originalDate2.charAt(i);
					i++;
				}
			}//End of For Loop..
			break;
}

//For validation..
//alert(d);
//alert(d2);
//alert(m);
//alert(m2);
								 
								
var startDate=m+"/"+d+"/"+y;
startDate=new Date(startDate);
//alert('startdate '+startDate);
 
 var endDate=m2+"/"+d2+"/"+y2;
 endDate=new Date(endDate);
//alert('enddate '+endDate);
 
 
 var ActualDate=m1+"/"+d1+"/"+y1;
 ActualDate=new Date(ActualDate);
//alert('ActualDate '+ActualDate);

if(ActualDate < startDate || ActualDate > endDate )
{
 
	return false;
}
else
{
	return true;
}
//End of Validation..

}

//End of Function..





//Third Function


function ConvertIntoDate(originalDate1,fmt1)
{
    
var y1='';
var m1='';
var d1='';
 
switch(fmt1)
		{
			case 'DD-MM-YYYY':
				
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if(originalDate1.charAt(2)=='-')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='-')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='-')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='-')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
								
			/*for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/

			break;
									
			case 'DD/MM/YYYY':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if(originalDate1.charAt(2)=='/')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='/')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='/')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='/')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
			
			
			/*for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/

			break;
									
			case 'DD.MM.YYYY':
			
					if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if(originalDate1.charAt(2)=='.')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='.')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='.')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;																				 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='.')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..	
										
									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
			
			
				/* for(i=0;i<originalDate1.length;)
			{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..	 */
			break;
									
									
			case 'MM-DD-YYYY':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if(originalDate1.charAt(2)=='-')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='-')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
										 for(i=0;i<originalDate1.length;)
										{
											//while loop for paersing upto , to get day..
											while(originalDate1.charAt(i) !='-')
											{
												m1=m1+originalDate1.charAt(i);
												i++;
											}
															 
											i=i+1;
											
											 
											
											//while loop for paersing upto space to get month..
											while(originalDate1.charAt(i) !='-')
											{
												d1=d1+originalDate1.charAt(i);
												i++;
											}

											i++;
											while(i<originalDate1.length)
											{
												y1=y1+originalDate1.charAt(i);
												i++;
											}
									}//End of For Loop..	

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
					/*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
								 
			i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'MM/DD/YYYY':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
			//Modified by SuchitraP on 2-Jan-2008
			//Purpose:To remove invalid date format alert
				//if(originalDate1.charAt(2)=='-')
				if(originalDate1.charAt(2)=='/')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='/')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='/')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='/')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
				 /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'MM.DD.YYYY':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if(originalDate1.charAt(2)=='.')
				{
					if((originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9)&&(originalDate1.charAt(4)>=0 && originalDate1.charAt(4)<=9))
					{
						if(originalDate1.charAt(5)=='.')
						{
								if((originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9)&&(originalDate1.charAt(7)>=0 && originalDate1.charAt(7)<=9))
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='.')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='.')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
										}//End of For Loop..
										
									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
				 /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY-DD-MM':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='-')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='-')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
											//while loop for paersing upto , to get day..
											while(originalDate1.charAt(i) !='-')
											{
												y1=y1+originalDate1.charAt(i);
												i++;
											}
															 
											i=i+1;
											
											 
											
											//while loop for paersing upto space to get month..
											while(originalDate1.charAt(i) !='-')
											{
												d1=d1+originalDate1.charAt(i);
												i++;
											}

											i++;
											while(i<originalDate1.length)
											{
												m1=m1+originalDate1.charAt(i);
												i++;
											}
										}//End of For Loop..
											

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
					/* for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY.DD.MM':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='.')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='.')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
													//while loop for paersing upto , to get day..
													while(originalDate1.charAt(i) !='.')
													{
														y1=y1+originalDate1.charAt(i);
														i++;
													}
																	 
													i=i+1;
													
													 
													
													//while loop for paersing upto space to get month..
													while(originalDate1.charAt(i) !='.')
													{
														d1=d1+originalDate1.charAt(i);
														i++;
													}

													i++;
													while(i<originalDate1.length)
													{
														m1=m1+originalDate1.charAt(i);
														i++;
													}
										}//End of For Loop..
											

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
			
			
				 /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY/DD/MM':
			
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='/')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='/')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											 for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='/')
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='/')
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
			
					/*  for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					y1=y1+originalDate.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY-MM-DD':
			
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='-')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='-')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
													//while loop for paersing upto , to get day..
													while(originalDate1.charAt(i) !='-')
													{
														y1=y1+originalDate1.charAt(i);
														i++;
													}
																	 
													i=i+1;
													
													 
													
													//while loop for paersing upto space to get month..
													while(originalDate1.charAt(i) !='-')
													{
														m1=m1+originalDate1.charAt(i);
														i++;
													}

													i++;
													while(i<originalDate1.length)
													{
														d1=d1+originalDate1.charAt(i);
														i++;
													}
										}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
			
					 /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='-')
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='-')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate1.length)
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY/MM/DD':
			
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='/')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='/')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											for(i=0;i<originalDate1.length;)
											{
												//while loop for paersing upto , to get day..
												while(originalDate1.charAt(i) !='/')
												{
													y1=y1+originalDate1.charAt(i);
													i++;
												}
																 
												i=i+1;
												
												 
												
												//while loop for paersing upto space to get month..
												while(originalDate1.charAt(i) !='/')
												{
													m1=m1+originalDate1.charAt(i);
													i++;
												}

												i++;
												while(i<originalDate1.length)
												{
													d1=d1+originalDate1.charAt(i);
													i++;
												}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
				 /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='/')
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='/')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate.length)
				{
					d1=d+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
									
			case 'YYYY.MM.DD':
			
			if((originalDate1.charAt(0)>=0 && originalDate1.charAt(0)<=9)&&(originalDate1.charAt(1)>=0 && originalDate1.charAt(1)<=9))
			{
				if((originalDate1.charAt(2)>=0 && originalDate1.charAt(2)<=9)&&(originalDate1.charAt(3)>=0 && originalDate1.charAt(3)<=9))
				{
					if(originalDate1.charAt(4)=='.')
					{
						if((originalDate1.charAt(5)>=0 && originalDate1.charAt(5)<=9)&&(originalDate1.charAt(6)>=0 && originalDate1.charAt(6)<=9))
						{
								if(originalDate1.charAt(7)=='.')
								{
									if((originalDate1.charAt(8)>=0 && originalDate1.charAt(8)<=9)&&(originalDate1.charAt(9)>=0 && originalDate1.charAt(9)<=9))
									{
											 for(i=0;i<originalDate1.length;)
											{
													//while loop for paersing upto , to get day..
													while(originalDate1.charAt(i) !='.')
													{
														y1=y1+originalDate1.charAt(i);
														i++;
													}
																	 
													i=i+1;
													
													 
													
													//while loop for paersing upto space to get month..
													while(originalDate1.charAt(i) !='.')
													{
														m1=m1+originalDate1.charAt(i);
														i++;
													}

													i++;
													while(i<originalDate1.length)
													{
														d1=d1+originalDate1.charAt(i);
														i++;
													}
											}//End of For Loop..

									}
									else
									{
										//alert('Please Enter valid Date.');
										return;
									}
								}
								else
								{
									//alert('Please Enter valid Date.');
									return;
								}
						}
						else
						{
							//alert('Please Enter valid Date.');
							return;
						}
					}
					else
					{
						//alert('Please Enter valid Date.');
						return;
					}
				}
				else
				{
					//alert('Please Enter valid Date.');
					return;
				}
			}
			else
			{
				//alert('Please Enter valid Date.');
				return;
			}
				  /*for(i=0;i<originalDate1.length;)
					{
				//while loop for paersing upto , to get day..
				while(originalDate1.charAt(i) !='.')
				{
					y1=y1+originalDate1.charAt(i);
					i++;
				}
								 
				i=i+1;
				
				 
				
				//while loop for paersing upto space to get month..
				while(originalDate1.charAt(i) !='.')
				{
					m1=m1+originalDate1.charAt(i);
					i++;
				}

				i++;
				while(i<originalDate.length)
				{
					d1=d1+originalDate1.charAt(i);
					i++;
				}
			}//End of For Loop..*/
			break;
	}//End of switch case..
	
	var newDate=m1 +'/' +d1 + '/' +y1;
	return newDate;
}

//Added By VarunA on 6-July-2008 RequestID-14286
//Purpose : To have proper date format
function GetFormatDate(formname,controlname,format,message)
{
    var objRegExp;
	var objControl;
	var objOriginalControl;
	var RowIndex=(arguments.length>4)?arguments[4]:"0"; 
	if (RowIndex=="0")
	{
	    objControl= GetObjectReference(formname,'FFE29587WHIZ_' + controlname);
	    objOriginalControl= GetObjectReference(formname,controlname);
	}    
	else
	{
	    objControl= GetObjectReference(formname,'FFE29587WHIZ_' + controlname,true)[parseInt(RowIndex)-1];
	    objOriginalControl= GetObjectReference(formname,controlname,true)[parseInt(RowIndex)-1];
	}   
		var originalDate;
	var standardDate;
	var arrDate;
	var arrFormat;
	var intCount;
	var separator;
	var formatSeparator;
	//if (objControl.value == '')
	//{	objOriginalControl.value='';
	//	alert(message);
	//}
	objControl.value = Trim(objControl.value);
	arrFormat = format.split('/');
	formatSeparator = '/';
	if (arrFormat.length !=3)
	{
		arrFormat = format.split('-');
		formatSeparator = '-';
		if (arrFormat.length !=3)
		{
			arrFormat = format.split('.');
			formatSeparator = '.';
		}
	}
	format = format.toUpperCase();
	switch(true)
	{
	  case (formatSeparator == '/'):
		{
		 objControl.value = replaceSubstring(objControl.value,'.',formatSeparator);
		 objControl.value = replaceSubstring(objControl.value,'-',formatSeparator);
		 break;	
		}  
	  case (formatSeparator == '-'):
		{
			objControl.value = replaceSubstring(objControl.value,'.',formatSeparator);
			objControl.value = replaceSubstring(objControl.value,'/',formatSeparator);
			break;	
		}  
	  case (formatSeparator == '.'):
		{
			objControl.value = replaceSubstring(objControl.value,'/',formatSeparator);
			objControl.value = replaceSubstring(objControl.value,'-',formatSeparator);
			break;	
		}  
	}
	
	arrFormat = objControl.value.split(formatSeparator);
	if (arrFormat.length !=3)
		{
		 if (message != '')
			alert(message);
		if(navigator.appName == 'Microsoft Internet Explorer')
			setFocus(objControl);
		else
			window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1);		 return false;
	     return false;
		}
	switch(true)
	{
		case (format=='DD-MM-YYYY' || format=='DD.MM.YYYY' || format == 'DD/MM/YYYY'):
			{
			 objRegExp = /^(0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])[-\/.](19|20)\d\d$/;
			 if (objControl.value.length != 10)
				{
				 arrDate = objControl.value.split(formatSeparator);
				 arrDate[0] = FormatDayMonthYear(arrDate[0],'D');
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'M');
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'YYYY');
				 objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
			 break;
			}
		case (format=='MM-DD-YYYY' || format=='MM.DD.YYYY' || format == 'MM/DD/YYYY'):
		   {
			 objRegExp = /^(0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](19|20)\d\d$/;
			 if (objControl.value.length != 10)
				{
				 arrDate = objControl.value.split(formatSeparator);
			     arrDate[0] = FormatDayMonthYear(arrDate[0],'M')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'D')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'YYYY')

				    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
			  break;
			}
		case (format=='YYYY-DD-MM' || format=='YYYY.DD.MM' || format == 'YYYY/DD/MM'):
		   {			
				objRegExp = /^(19|20)\d\d[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])$/;
				if (objControl.value.length != 10)
				{
				 arrDate = objControl.value.split(formatSeparator);
				 arrDate[0] = FormatDayMonthYear(arrDate[0],'YYYY')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'D')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'M')
				    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;	
			}
		case (format=='YYYY-MM-DD' || format=='YYYY.MM.DD' || format == 'YYYY/MM/DD'):
		    {
				objRegExp = /^(19|20)\d\d[-\/.](0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])$/;
				if (objControl.value.length != 10)
				{
				 arrDate = objControl.value.split(formatSeparator);
				 arrDate[0] = FormatDayMonthYear(arrDate[0],'YYYY')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'M')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'D')
				    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;
			}
		case (format=='DD-MM-YY' || format=='DD.MM.YY' || format == 'DD/MM/YY'):
			{
				objRegExp = /^(0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])[-\/.]\d\d$/;
				if (objControl.value.length != 8)
				{
				 arrDate = objControl.value.split(formatSeparator);
				 arrDate[0] = FormatDayMonthYear(arrDate[0],'D')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'M')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'YY')
				 objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;
			}
		case (format=='MM-DD-YY' || format=='MM.DD.YY' || format == 'MM/DD/YY'):
			{
				objRegExp = /^(0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.]\d\d$/;
				if (objControl.value.length != 8)
				{
				 arrDate = objControl.value.split(formatSeparator);
				 arrDate[0] = FormatDayMonthYear(arrDate[0],'M')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'D')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'YY')
				 objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;
			}
		case (format=='YY-DD-MM' || format=='YY.DD.MM' || format == 'YY/DD/MM'):
			{
				objRegExp = /^\d\d[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])[-\/.](0[1-9]|1[012])$/;
				if (objControl.value.length != 8)
				{
				 arrDate = objControl.value.split(formatSeparator);
				  arrDate[0] = FormatDayMonthYear(arrDate[0],'YY')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'D')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'M')
				    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;
			}
		case (format=='YY-MM-DD' || format=='YY.MM.DD' || format == 'YY/MM/DD'):
			{
				objRegExp = /^\d\d[-\/.](0[1-9]|1[012])[-\/.](0[1-9]|1[0-9]|2[0-9]|3[01])$/;
				if (objControl.value.length != 8)
				{
				 arrDate = objControl.value.split(formatSeparator);
				  arrDate[0] = FormatDayMonthYear(arrDate[0],'YY')
				 arrDate[1] = FormatDayMonthYear(arrDate[1],'M')
				 arrDate[2] = FormatDayMonthYear(arrDate[2],'D')
				    objControl.value = arrDate[0] + formatSeparator + arrDate[1] + formatSeparator + arrDate[2];
				    //alert(objControl.value);     
				}	
				break;
			}
		default:
			if (message != '')
				alert(message);
			if(navigator.appName == 'Microsoft Internet Explorer')
				setFocus(objControl);
			else
				window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1);
			return false;
			break;
	}
	
	if(!objRegExp.test(objControl.value) == true)
	{
		//invalid format return false
		if (message != '')
			alert(message);
		if(navigator.appName == 'Microsoft Internet Explorer')
			setFocus(objControl);
		else
			window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 1);
		return false; 
	}
	else
	{
		// date format pattern matched!
		
		//check the validity of the separator and get the separator
		separator = formatSeparator; //getSeparator(objControl.value, format);
		//validate the date now
		standardDate = '';
		standardDate = ConvertDateToStanderFormat(formname,controlname, format, separator,RowIndex);//Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
		if (standardDate != '' )
		{	
			objOriginalControl.value = standardDate;
			//alert(objOriginalControl.value);
			originalDate = objControl.value;
			objControl.value = standardDate;
			if (isDate(objControl,null,false) == true) 
			{
				objControl.value=originalDate ;
				//alert(objControl.value);
				return objControl.value;
			}
			objControl.value=originalDate; 
			if (message != '')
				alert(message);
			if(navigator.appName == 'Microsoft Internet Explorer')
				setFocus(objControl);
			else
				window.setTimeout('document.forms["' + formname + '"].elements["' + objControl.id + '"].focus()', 0);
			return false;
			//alert(objControl.value);
		}
		
	}
	return false;
}

//End By VarunA on 6-July-2008 RequestID-14286