var g_iFlag=0;
var g_iQNumTo=0;
var g_iQIdFrom=0;

var g_iQNumFrom=0; // for comparing

var arrCaps = new Array();
var strPagePath='';
var sFrmId='';
var oFrm;

function AddQuestionHere(obj)
{
    var iQNum=0;
    var iSurveyID=0;
    var oSurveyID = GetObjectReference(sFrmId,'SurveyID');
    var iIsLastQ=0;
    if (obj!=null)
    {
       iQNum=obj.attributes['qnum'].value;
       iIsLastQ=obj.attributes['isLastQ'].value;
       if (iIsLastQ==1)
        iQNum=parseInt(iQNum)+1;
    }
    if (oSurveyID!=null)
    {
        iSurveyID=oSurveyID.value;
    }
    var sURL=new String();
    sURL="../WhizSurvey/QuestionTypeSelection.aspx?FromDesigner=1&SurveyID="+iSurveyID+"&QuestionNumber=" + iQNum;
    window.open (sURL, "","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 1015)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=1015,height=650");
}
function AddQuestionFromLibrary(obj)
{

    var iQNum=0;
    var iSurveyID=0;
    var oSurveyID = GetObjectReference(sFrmId,'SurveyID');
    var iIsLastQ=0;
    if (obj!=null)
    {
       iQNum=obj.attributes['qnum'].value;
       iIsLastQ=obj.attributes['isLastQ'].value;
       if (iIsLastQ==1)
        iQNum=parseInt(iQNum)+1;
        
       if (parseInt(iQNum)==0)
        iQNum=1;
    }
    if (oSurveyID!=null)
    {
        iSurveyID=oSurveyID.value;
    }
    
 var sURL=new String();
 sURL="../WhizSurvey/SelectFromQLib_CommonList.aspx?MasterTagID=1785&FromDesigner=1&SurveyID="+iSurveyID+"&QuestionNumber=" + iQNum;
 window.open (sURL, "","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 700)/2) + ",width=900,height=700");
}

function AddQ(obj)
{
    if (g_iFlag!=0)
        ResetAll();
    else
        AddQuestionHere(obj);    
}
function AddQFromQLib(obj)
{
    var oSubMode;
    var iFlag_IsLastQuestion=0;
    if (g_iFlag!=0)
    {
        g_iQNumTo = obj.attributes['qnum'].value;
        iFlag_IsLastQuestion=obj.attributes['isLastQ'].value; //second last question can move to last question
                
        // Avoid unnecessary postbacks
        if ( (g_iFlag==1) && (g_iQNumFrom!=g_iQNumTo) && (g_iQNumTo-g_iQNumFrom !=1 || iFlag_IsLastQuestion==1) || (g_iFlag==2) )
        {   
            //for Copy question if last question, add 1 to qnum where question is to be copied.  
            //Issue Id:29462       
            if(g_iFlag==2 && iFlag_IsLastQuestion==1)
                g_iQNumTo = parseInt(g_iQNumTo,10) + 1;
            oSubMode=GetObjectReference(sFrmId,'SubMode');
            if(oSubMode!=null)
            {
                oSubMode.value=g_iFlag+2;            
                oFrm.action=strPagePath + "?MoveCopyOrDeleteQuestionFrom=" + g_iQIdFrom + "&MoveOrCopyQuestionAt=" + g_iQNumTo;
                oFrm.submit();
            }
        }
        else
        {
            ResetAll();
        }
    }
    else
        AddQuestionFromLibrary(obj);
    
}
function CopyQ(obj)
{
    ResetAll();
    g_iFlag=2;
    obj.style.color='red';
    SetCaps(obj);
    g_iQIdFrom = obj.attributes['qid'].value;
    
    g_iQNumFrom= obj.attributes['qnum'].value; // To do comparison for avoiding unnecessary postbacks
}
function MoveQ(obj)
{
    ResetAll();
    g_iFlag=1;    
    obj.style.color='red';    
    SetCaps(obj);
    g_iQIdFrom = obj.attributes['qid'].value;
    
    g_iQNumFrom= obj.attributes['qnum'].value; // To do comparison for avoiding unnecessary postbacks
    
}
function DelQ(obj)
{
    var oSubMode;
    g_iQIdFrom = obj.attributes['qid'].value;
    var iQnum = obj.attributes['qnum'].value; 
    if(!confirm("Are you sure you want to delete Question # " + iQnum + "?"))
        return;
    oSubMode=GetObjectReference(sFrmId,'SubMode');
    if(oSubMode!=null)
    {
        oSubMode.value=5;            
        oFrm.action=strPagePath + "?MoveCopyOrDeleteQuestionFrom=" + g_iQIdFrom; 
        oFrm.submit();
    }
}
function ResetAll()
{
    var iLen=0;
    var iLoop=0;    
    var oActionBtn;
    var sActionBtnId='';
    
    var oAddQBtns = GetObjectReference(sFrmId,'btnAddQ',true);
    var oAddQFromQLibBtns = GetObjectReference(sFrmId,'btnAddQFromQLib',true);
      
    g_iQNumTo=0;
    g_iQIdFrom=0;    
   
    if (oAddQBtns!=null)
    {
        iLen=oAddQBtns.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {
            oAddQBtns[iLoop].value=arrCaps[0];
        }
    }
    if (oAddQFromQLibBtns!=null)
    {
        iLen=oAddQFromQLibBtns.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {
            oAddQFromQLibBtns[iLoop].value=arrCaps[1];
        }
    }    
    sActionBtnId='btnMovQ';
    oActionBtn=GetObjectReference(sFrmId,sActionBtnId,true);
    if(oActionBtn!=null)
    {
        iLen=oActionBtn.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {
            oActionBtn[iLoop].style.color='black';
        }
    }
    sActionBtnId='btnCopyQ';
    oActionBtn=GetObjectReference(sFrmId,sActionBtnId,true);
    if(oActionBtn!=null)
    {
        iLen=oActionBtn.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {
            oActionBtn[iLoop].style.color='black';
        }
    }
    g_iFlag=0;
        
}
function SetCaps(obj)
{
    
    var sCapAddQHere='';
    var sCapAddQFromQLib='';
    var iLen=0;
    var iLoop=0;    
    
    var oAddQBtns = GetObjectReference(sFrmId,'btnAddQ',true);
    var oAddQFromQLibBtns = GetObjectReference(sFrmId,'btnAddQFromQLib',true); 
    
    switch(obj.id)
    {
        case 'btnMovQ':                
                sCapAddQHere=arrCaps[2];
                sCapAddQFromQLib=arrCaps[3];                                
                break;
        case 'btnCopyQ':
                sCapAddQHere=arrCaps[4];
                sCapAddQFromQLib=arrCaps[5];
                break;
        default: break;                
    }
    if (oAddQBtns!=null)
    {   
        iLen=oAddQBtns.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {            
            oAddQBtns[iLoop].value=sCapAddQHere;
        }
    }
    if (oAddQFromQLibBtns!=null)
    {
        iLen=oAddQFromQLibBtns.length;
        for(iLoop=0;iLoop<iLen;iLoop++)
        {
            oAddQFromQLibBtns[iLoop].value=sCapAddQFromQLib;
        }
    }
    
}
function Btn_OnClick(obj)
{
    switch(obj.id)
    {
        case 'btnAddQ' :
                AddQ(obj);
                break;
        case 'btnAddQFromQLib':
                AddQFromQLib(obj);
                break;
        case 'btnMovQ':
                MoveQ(obj);
                break;
        case 'btnCopyQ':
                CopyQ(obj);
                break;                   
        case 'btnDelQ':
                DelQ(obj);
                break;
        case 'btnEditQ':
                EditQ(obj);
                break;
        default: break;
    }
}

function EditQ(obj)
{
    var iQType=0;
    var iQNum=0;
    var iQID=0;
    var iSurveyID=0;
    var iMasterTagID=0;
    var oSurveyID = GetObjectReference(sFrmId,'SurveyID');
    if (obj!=null)
    {
       iQType=obj.attributes['qtypeid'].value;
       iQNum=obj.attributes['qnum'].value;
       iQID=obj.attributes['qid'].value;
    }
    if (oSurveyID!=null)
    {
        iSurveyID=oSurveyID.value;
    }

    iMasterTagID=1770+parseInt(iQType);

    var sURL=new String();
    sURL="../WhizSurvey/QType" + iQType + "_ManageQuestion_CommonPage.aspx?FromCL=1&MasterTagID=" + iMasterTagID;
    sURL+="&ParentTagID=0&QuestionNumber="+iQNum;
    sURL+="&SurveyID="+iSurveyID;
    sURL+="&SurveyQuestionID_PK=" + iQID;
    sURL+="&FromDesigner=1";

    window.open (sURL, "EditQ","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 1015)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=1015,height=650");
}

//FinishAndSave - Called from Finish Button
function FinishAndSave(obj)
{
    var oSavePageNum=GetObjectReference(sFrmId,'SavePageNum'); 
    var oSurveyID=GetObjectReference(sFrmId,'SurveyID');
    var oSurveyResponseID=GetObjectReference(sFrmId,'SurveyResponseID'); 
    var oMode=GetObjectReference(sFrmId,'Mode');    
    var oSubMode=GetObjectReference(sFrmId,'SubMode'); 
    var oSurveyType=GetObjectReference(sFrmId,'SurveyType'); 
    var oLang=GetObjectReference(sFrmId,'Lang');
    var oSecToken=GetObjectReference(sFrmId,'SecToken'); 
    var oMemberID=GetObjectReference(sFrmId,'MemberID'); 

    if (isUserMode()==true)
    {
        if ( ValidateResponse() == true)
        {
            oSavePageNum.value=obj.attributes['savePageNum'].value;            

            oFrm.action=strPagePath+"?Finish=1&SurveyID=" + oSurveyID.value+"&Mode="+oMode.value+"&SubMode="+oSubMode.value+"&MemberID="+oMemberID.value;  
            oFrm.action +="&SurveyType="+oSurveyType.value+"&SecToken="+oSecToken.value+"&SurveyResponseID="+oSurveyResponseID.value;  
            oFrm.submit();
            
            if(oSurveyType.value == 4)
            {   
                if (oMemberID.value=='' || oMemberID.value=='0')
                {
                    window.location.href = "../WhizSurvey/ThankYou.aspx?SurveyID="+oSurveyID.value+"&MemberID="+oMemberID.value+"&FromWhere=MPM&ThankYou=1";
                }
                else
                { 
                    
                    if(arguments[1] == 1 )
                        oFrm.action="../General/Navigation.aspx?subPage=../WhizSurvey/ThankYou.aspx&SurveyID="+oSurveyID.value+"&MemberID="+oMemberID.value+"&FromWhere=MPM&ThankYou=1";
                    else
                        window.location.href = "../General/Navigation.aspx?subPage=../WhizSurvey/ThankYou.aspx&SurveyID="+oSurveyID.value+"&MemberID="+oMemberID.value+"&FromWhere=MPM&ThankYou=1";
                }
            }
        }
    }
}

/*
Function Name:  NavigateNext
Description  :  Called on click of Next button
Assumptions  :  strPagePath must be declare in ASPX
Logic        :  Validates response if not design mode,
                Sets the Page Numbers of Page to be saved.
*/
function NavigateNext(obj)
{   
    var oSavePageNum=GetObjectReference(sFrmId,'SavePageNum'); 
    var oSurveyID=GetObjectReference(sFrmId,'SurveyID');
    var oSurveyResponseID=GetObjectReference(sFrmId,'SurveyResponseID'); 
    var oMode=GetObjectReference(sFrmId,'Mode');    
    var oSubMode=GetObjectReference(sFrmId,'SubMode'); 
    var oSurveyType=GetObjectReference(sFrmId,'SurveyType'); 
    var oLang=GetObjectReference(sFrmId,'Lang');
    var oSecToken=GetObjectReference(sFrmId,'SecToken'); 
    var oMemberID=GetObjectReference(sFrmId,'MemberID'); 
    var oRadioArr=document.getElementsByTagName('input');
    var oGoTo = GetObjectReference(sFrmId,'GoTo');
    var goToPage, oRadioName, isGoToPageZero;
    var cnt=0;

    if (isUserMode()==false) //|| ValidateResponse() == true)
     {
        oSavePageNum.value=obj.attributes['savePageNum'].value;            
        oFrm.action=strPagePath+"?NavDir=NEXT";
        oFrm.submit();
      }
    else
    {  
        if(ValidateResponse() == true)
        {
            oSavePageNum.value=obj.attributes['savePageNum'].value;
            oFrm.action=strPagePath+"?NavDir=NEXT&SurveyID=" + oSurveyID.value+"&Mode="+oMode.value+"&SubMode="+oSubMode.value+"&MemberID="+oMemberID.value;  
            oFrm.action +="&SurveyType="+oSurveyType.value+"&SecToken="+oSecToken.value+"&SurveyResponseID="+oSurveyResponseID.value;  

            //further checks for GoToQ                 
            if(oGoTo.value == 1)
            {
                var sType = new String();
                for (cnt=0; cnt < oRadioArr.length; cnt++)
                {
                    //if type is radio button
                    sType = oRadioArr[cnt].attributes['type'].value;
                    if(sType.toLowerCase() == "radio")
                    {
                        oRadioName = GetObjectReference(sFrmId,oRadioArr[cnt].name, true);
                        //if qtype is single answer/single answer y or n / rating / single answer with open question
                        if(oRadioName[0].attributes['qtype'].value == 1 || oRadioName[0].attributes['qtype'].value == 2 || oRadioName[0].attributes['qtype'].value == 9 || oRadioName[0].attributes['qtype'].value == 7)
                        {
                            for (cnt=0; cnt < oRadioName.length; cnt++)
                            {
                                if(oRadioName[cnt].checked==true)
                                {
                                    goToPage = oRadioName[cnt].attributes['gotoq'].value;
                                    //if there is any option with a jump (goto) to certain question specified
                                    if(goToPage != 0)
                                    {
                                        if(goToPage != -99)
                                        {
                                            oFrm.action+="&GoToPage="+goToPage;
                                            break;
                                        }
                                        else
                                        {
                                            if(!confirm(GetAlertFinishMsg()))
                                                return;
                                            else
                                               FinishAndSave(obj,1);
                                               break;
                                        }
                                    }
                                    else
                                    {
                                        isGoToPageZero=0;
                                    }
                                }    
                            } 
                        }
                        break;
                    }
                }
                if(isGoToPageZero==0)
                {
                   var intSavePageNum = parseInt(oSavePageNum.value);
                   intSavePageNum = intSavePageNum + 1; 
                   oFrm.action+="&GoToPage="+intSavePageNum;
                }
            }
            oFrm.submit();
        }
    }  
}

/*
Function Name:  NavigateBack
Description  :  Called on click of Back button
Assumptions  :  strPagePath must be declare in ASPX
Logic        :  Validates response if not design mode,
                Sets the Page Numbers of Page to be saved.
*/
function NavigateBack(obj)
{   
    var oSavePageNum=GetObjectReference(sFrmId,'SavePageNum'); 
    var oSurveyID=GetObjectReference(sFrmId,'SurveyID');
    var oSurveyResponseID=GetObjectReference(sFrmId,'SurveyResponseID'); 
    var oMode=GetObjectReference(sFrmId,'Mode');    
    var oSubMode=GetObjectReference(sFrmId,'SubMode'); 
    var oSurveyType=GetObjectReference(sFrmId,'SurveyType'); 
    var oLang=GetObjectReference(sFrmId,'Lang');
    var oSecToken=GetObjectReference(sFrmId,'SecToken'); 
    var oMemberID=GetObjectReference(sFrmId,'MemberID'); 
    
    if (isUserMode()==false) // || ValidateResponse() == true)
     {            
        oSavePageNum.value=obj.attributes['savePageNum'].value;
        oFrm.action=strPagePath+"?NavDir=BACK";
        oFrm.submit();
     }
    else
    {
        if(ValidateResponse() == true)
          {
            oSavePageNum.value=obj.attributes['savePageNum'].value;            
            oFrm.action=strPagePath+"?NavDir=BACK&SurveyID=" + oSurveyID.value+"&Mode="+oMode.value+"&SubMode="+oSubMode.value+"&MemberID="+oMemberID.value;  
            oFrm.action +="&SurveyType="+oSurveyType.value+"&SecToken="+oSecToken.value+"&SurveyResponseID="+oSurveyResponseID.value;  
            oFrm.submit();
          }
    }
}

//return true if the mode is design mode
function isUserMode()
{
    var iMode=0;
    var hdMode=GetObjectReference(sFrmId,'Mode');
    if (hdMode!=null)
    {       
        iMode=hdMode.value;
        if (iMode==3)
            return true;
    }
    return false;
}

//Validation Methods

function SelOneOptPerCol(obj)
{
    var iQnum=obj.attributes['qnum'].value;
    var iColnum=obj.attributes['colnum'].value;
    
    var iLoop=0;
    var iLen=0;
    var oOptCollection=document.getElementsByTagName('input');
    iLen=oOptCollection.length;    
    for (iLoop=0;iLoop<iLen;iLoop++)
    {
        try
        {
            if (oOptCollection[iLoop].attributes['type'].value=='radio')
            {
                if (oOptCollection[iLoop].attributes['qnum'].value==iQnum)
                {
                    if (oOptCollection[iLoop].attributes['colnum'].value==iColnum)
                    {
                        if (oOptCollection[iLoop].id != obj.id)
                        {
                            oOptCollection[iLoop].checked=false;
                        }
                    }
                }
            }
        }
        catch(ex) {}
    }   
}

function IsNumberLess(sOptId,iMinVal)
{
    var objOption=GetObjectReference(sFrmId,sOptId);
    return (disallowMinValueViolation(objOption,iMinVal,'',false,true));
}
function IsNumberGreater(sOptId,iMaxVal)
{
    var objOption=GetObjectReference(sFrmId,sOptId);
    return (disallowMaxValueViolation(objOption,iMaxVal,'',false,true));
}
function IsWholeNumber(sOptId)
{
    if (IsOptBlank(sOptId)==false)
    {
        var objOption=GetObjectReference(sFrmId,sOptId);
        return (!disallowNegativeInteger(objOption,'',false));
    }
    return true;
}

function IsOptAlphaNumeric(sOptId)
{
   if(IsOptBlank(sOptId) == false)
   {
        var objOption = GetObjectReference(sFrmId,sOptId);
        return (!disallowSpecialCharacters(objOption,'',false));
   }
}

function IsOptNumeric(sOptId)
{
    if (IsOptBlank(sOptId)==false)
    {
        var objOption=GetObjectReference(sFrmId,sOptId);
        return (!disallowNonNumeric(objOption,'',false));
    }
    return true;
}

function IsOptBlank(sOptId)
{
    var objOption=GetObjectReference(sFrmId,sOptId);
    return disallowBlank(objOption,'',false);
}

function IsValidEmail(sOptId)
{
    if (IsOptBlank(sOptId)==false)
    {
        var objOption=GetObjectReference(sOptId);
        return (!validateEmailID(objOption,'',false));
    }
    return true;
}

function EnableDisableOpenQuestion(objOpt)
{
    var sTxtAreaPrefix = new String();
    sTxtAreaPrefix = 'txtArea_';
    var sTxtBoxPrefix = new String();
    sTxtBoxPrefix = 'txt_';
    var sTxtAreaSuffix =  new String();
    var sOptId = new String();
    sOptId = objOpt;
    sTxtAreaSuffix = sOptId.substring(sOptId.indexOf("_")+1, sOptId.length);
    var sTextAreaId=new String();
    sTextAreaId = sTxtAreaPrefix + sTxtAreaSuffix; 
    var sTextBoxId = new String();
    sTextBoxId = sTxtBoxPrefix + sTxtAreaSuffix; 
    
    if(IsLastOptSelecetd(objOpt))
    {
        if(GetObjectReference(sFrmId, sTextAreaId) != null)
            GetObjectReference(sFrmId, sTextAreaId).disabled=false;
        else
            GetObjectReference(sFrmId, sTextBoxId).disabled=false;
    }
    else
    {
        if(GetObjectReference(sFrmId, sTextAreaId) != null)
        {
            GetObjectReference(sFrmId, sTextAreaId).disabled=true;
            GetObjectReference(sFrmId, sTextAreaId).value="";
        }
        else
        {
            GetObjectReference(sFrmId, sTextBoxId).disabled=true;
            GetObjectReference(sFrmId, sTextBoxId).value="";
        }
    }
}

function IsLastOptSelecetd(sOptId)
{
    var oOptBtn=GetObjectReference(sFrmId,sOptId,true);
    var iLength=oOptBtn.length;
    var iCounter=0;
    for (iCounter=0;iCounter<iLength;iCounter++)
    {
        if (oOptBtn[iCounter].checked == true)
        {
            try
            {
                if (oOptBtn[iCounter].attributes['lastOpt'].value == '1')
                    return true;
            }
            catch (e) {}
        }
    }
    return false;        
}

function IsNoOfOptSelecetdCorrect(sOptId,iNoOfOptReq,iType)
{
    if (IsOptSelecetd(sOptId)==true)
    {
        var oOptBtn=GetObjectReference(sFrmId,sOptId,true);
        var iLength=oOptBtn.length;
        var iCounter=0;
        var iNoOfOptSelected=0;
        for (iCounter=0;iCounter<iLength;iCounter++)
         {        
            if (oOptBtn[iCounter].checked == true)
                iNoOfOptSelected++;
         }

        switch(iType)
        {
            case 2: //Atleast
                    if (iNoOfOptSelected < iNoOfOptReq)
                        return false;
                    break;
            case 3: //Exactly
                    if (iNoOfOptSelected != iNoOfOptReq)
                        return false;
                    break;        
            case 4: //Atmost
                    if (iNoOfOptSelected > iNoOfOptReq)
                        return false;
                    break;
            default:
                    return false;
                    break;  
        }
    }
    return true;
}
function IsOptSelecetd(sOptId)
{
     var oOptBtn=GetObjectReference(sFrmId,sOptId,true);
     var iLength=oOptBtn.length;     
     var iCounter=0;         
     for (iCounter=0;iCounter<iLength;iCounter++)
     {          
        if (oOptBtn[iCounter].checked == true)
            return true;
     }
     return false;
}

function GetRankComboValuesArray(sOptIdPrefix)
{
    var iNoOfCombos = 0;
    var iCounter = 0;
    var sId = new String();
    var oCboCollection = document.getElementsByTagName('select');
    var iNoOfRankingCombos=0;
    
    iNoOfCombos=oCboCollection.length;
    var arrRanks=new Array();
    for (iCounter=0;iCounter<iNoOfCombos;iCounter++)
    {
        sId=oCboCollection[iCounter].id;
        if (sId.indexOf(sOptIdPrefix) > -1)
        {  
            arrRanks[iNoOfRankingCombos]=oCboCollection[iCounter].value;
            iNoOfRankingCombos++;
        }            
    }
    return arrRanks;
}

function AreRankOptsSelecetd(sOptIdPrefix)
{
    var arrRanks=GetRankComboValuesArray(sOptIdPrefix);
    var iCounter = 0;
    var iNoOfRankingCombos=0;   
    if (arrRanks!=null)
    {
        iNoOfRankingCombos = arrRanks.length;
        if (iNoOfRankingCombos>0)
        {
            for (iCounter=0;iCounter<iNoOfRankingCombos;iCounter++)
            {
                if ( (arrRanks[iCounter]== null) || (arrRanks[iCounter] =='') )
                {
                    return false;
                    break;
                }
            }
        }
    }
    return true;
}
function IsDuplicateRankOptSelecetd(sOptIdPrefix)
{
    if ( AreRankOptsSelecetd(sOptIdPrefix)==false )
        return false;

    var iCounter = 0;
    var iNoOfRankingCombos=0;    
    var arrRanks=GetRankComboValuesArray(sOptIdPrefix);
    
    if (arrRanks!=null)
    {
        iNoOfRankingCombos=arrRanks.length;
        if (iNoOfRankingCombos>0)
        {
            arrRanks=arrRanks.sort(sortNumber);
            for (iCounter=0;iCounter<iNoOfRankingCombos;iCounter++)
            {
                if (iCounter!=0)
                {   if (arrRanks[iCounter]==arrRanks[iCounter-1] && arrRanks[iCounter]!= null && arrRanks[iCounter] !='')
                    {
                        return true;
                        break;
                    }
                }
            }
        }
    }
    return false;
}
function sortNumber(a, b)
{return a - b;}

function GetIntoView(sContainerId)
{var oContainer=GetObjectReference(sFrmId,sContainerId);if (oContainer !=null){oContainer.scrollIntoView();}}

//Functions for Preview links
var sCommonQS4Preview='?Mode=2&CurrentPageNum=1&SavePageNum=0&MoveCopyOrDeleteQuestionFrom=0&MoveOrCopyQuestionAt=0'
sCommonQS4Preview+='&SurveyType=1&SurveyResponseID=0&SubMode=2&MemberID=&MemberName=&Lang=';
function EnglishPreview_OnClick()
{
    var oSurveyID=GetObjectReference(sFrmId,'SurveyID');
    var sURL=strPagePath + sCommonQS4Preview +  '1033&SurveyID=' + oSurveyID.value;   
    window.open(sURL,'_WinPreview',"resizable=yes,scrollbars=no,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 630)/2) + ",width=900,height=630");
}
//Functions For Hard Copy Links
function EnglishHardCopy_OnClick()
{
     var oSurveyID=GetObjectReference(sFrmId,'SurveyID');
     var sURL="CRW_SurveykitHardcopy.aspx?Lang=1033&SurveyID=" + oSurveyID.value;
     window.open(sURL,'_WinHardCopy');
}