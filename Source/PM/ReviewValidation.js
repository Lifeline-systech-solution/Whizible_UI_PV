// Author By :  MahendraV On 6:06 PM 7/12/2007 For WhizibleSEM 7
// Purpose   :  Validate review date from reviewee and reviewer date
//			 :  If function arguments is greater than 3 it means function validating Fast Track Review resource dates.
// Start_MV_7/12/2007
function ValidateResourceDate(srtNonDbFiled1,srtNonDbFiled2,srtNonDbFiled3,srtNonDbFiled4)
{
	var objReIDList,objRrIDList,objReviewSDate,objReviewEDate;
	var arrReIDList = new Array();
	var arrRrIDList = new Array();
	var objReID,objReName;
	objReIDList				= GetObjectReference('frmCommonPage','NonDatabase12');
	objResourceValidation	= GetObjectReference('frmCommonPage',srtNonDbFiled4);
	objRrIDList				= GetObjectReference('frmCommonPage','NonDatabase1');
	objReviewEDate			= GetObjectReference('frmCommonPage','ReviewEndDate');
	if (objResourceValidation.value == "True")
	{
			// Reviewee date validation 
			if(arguments.length > 4)
			{
				objReviewSDate		= GetObjectReference('frmCommonPage','ReviewedDate');
				objReID				= GetObjectReference('frmCommonPage',arguments[4]);
				objReName			= GetObjectReference('frmCommonPage',arguments[5]);
				if(objReID!=null && objReID.options.length>1)
				{
					if(objReName!=null && objReName.selectedIndex>0)
					{
						if(!ValidateReviewResourceDate(objReID,'Reviewee',srtNonDbFiled1,srtNonDbFiled2,srtNonDbFiled3,objReviewSDate,objReviewEDate,objReName))
							return false;
					}
				}
				
			}
			else
			{
				objReviewSDate			= GetObjectReference('frmCommonPage','ReviewStartDate');
				
			}
				if(objReIDList!=null && objReIDList.value!="")
				{	
					var strRevieweeIDList;
					strRevieweeIDList		=  objReIDList.value;
					arrReIDList				= strRevieweeIDList.split(",");
					if(!ValidateReviewResourceDate(arrReIDList,'Reviewee',srtNonDbFiled1,srtNonDbFiled2,srtNonDbFiled3,objReviewSDate,objReviewEDate))
						return false;
					
				}

				// Reviewer date validation
				if(objRrIDList!=null && objRrIDList.value!="")
				{
					var strReviewerIDList;
					strReviewerIDList		= objRrIDList.value;
					arrRrIDList				= strReviewerIDList.split(",");
					if(!ValidateReviewResourceDate(arrRrIDList,'Reviewer',srtNonDbFiled1,srtNonDbFiled2,srtNonDbFiled3,objReviewSDate,objReviewEDate))
						return false;
				}
	}
	return true;
	
}
// Review date validation for resources
function ValidateReviewResourceDate(arrayIDList,resource,srtNonDbFiled1,srtNonDbFiled2,srtNonDbFiled3,objReviewSDate,objReviewEDate)
{
	var objRSDate,objREDate;
	var dtRSDate,dtREDate,strReID,dtObjRSDate,strReName;
	objRSDate 			= GetObjectReference('frmCommonPage',srtNonDbFiled1);
	objREDate 			= GetObjectReference('frmCommonPage',srtNonDbFiled2);
	dtObjRSDate			= GetObjectReference('frmCommonPage',srtNonDbFiled3);

	for(i=0;i<arrayIDList.length;i++)
	{
		if(arguments.length > 7)
		{
			strReName	= arguments[7].options[ arguments[7].selectedIndex].value;
			if(strReName==arrayIDList[i].text )
			{
				strReID=arrayIDList[i].value;
				
			}
			
		}
		else
		{
			strReID = arrayIDList[i];
		}
		if(strReID!="")
		{	
			if(objRSDate !=null && objRSDate.options.length>1)
			{	
				for(j=0;j<objRSDate.options.length;j++)
				{
					if(objRSDate.options[j].value == strReID)
					{
					
						if(objReviewSDate!=null && objReviewSDate.value!="")
						{ 
							dtRSDate =objRSDate.options[j].text;
							dtObjRSDate.value = dtRSDate;
							if(disallowDate1LessThanDate2(objReviewSDate,dtObjRSDate," 'Start Date' should be between "+resource+" 'Start Date' (" + objRSDate.options[j].text + ") and 'End Date' (" + objREDate.options[j].text + ") on project."))
							{
						 		return false;
							}
						}	
						if(objReviewEDate!=null && objReviewEDate.value!="")
						{ 
							dtREDate =  objREDate.options[j].text;
							dtObjRSDate.value = dtREDate;
							if(disallowDate1LessThanDate2(dtObjRSDate,objReviewEDate,resource+" 'End Date' should be between "+resource+" 'Start Date' (" + objRSDate.options[j].text + ") and 'End Date' (" + objREDate.options[j].text + ") on project." ))
							{
								return false;
							}
						}
					}	
				}
			}
		}
	}
	return true;

}

// End_MV_7/12/2007