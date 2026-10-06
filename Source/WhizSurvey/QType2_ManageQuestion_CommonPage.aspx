<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QType2_ManageQuestion_CommonPage.aspx.vb" Inherits="Whiz.QType2_ManageQuestion_CommonPage"%>

<script language="javascript" type="text/javascript">
function New_OnClick_Tab()
{
    var sFormId='frmCommonPage';
    var oSurveyQuestionID_PK=GetObjectReference(sFormId,'SurveyQuestionID_PK');
    if (oSurveyQuestionID_PK!=null && oSurveyQuestionID_PK.value=='')
    {
        var oSubTagID=GetObjectReference(sFormId,'SubTagIDs');
        var sSubtagID='';
        if (oSubTagID!=null)
        {
            sSubtagID=oSubTagID.value;
            var ControlDef_OptionText_English='';
            var ControlDef_OptionArabic_English='';
            var ControlDef_OptionWeight='';
            var ControlDef_GoToQuestion='';
            
            try{ControlDef_OptionText_English=GetObjectReference(sFormId,'ControlDef_OptionText_English_'+sSubtagID).value;} catch (e) {}
            try{ControlDef_OptionWeight=GetObjectReference(sFormId,'ControlDef_OptionWeight_'+sSubtagID).value;} catch (e) {}
            try{ControlDef_GoToQuestion=GetObjectReference(sFormId,'ControlDef_GoToQuestion_'+sSubtagID).value;} catch (e) {}
            AddNewRow_MultiInsertGrid(sSubtagID,'tblGrid1772'+ sSubtagID,ControlDef_OptionText_English,ControlDef_OptionWeight,ControlDef_GoToQuestion);
            AddNewRow_MultiInsertGrid(sSubtagID,'tblGrid1772'+ sSubtagID,ControlDef_OptionText_English,ControlDef_OptionWeight,ControlDef_GoToQuestion);

            var oOptionText_English=GetObjectReference(sFormId,'OptionText_English',true);
            if (oOptionText_English!=null && oOptionText_English.length==2)
            {
                oOptionText_English[0].value='Yes';oOptionText_English[0].disabled=true;
                oOptionText_English[1].value='No';oOptionText_English[1].disabled=true;
            }
        }
        
    }
    else
    {
            var oOptionText_English=GetObjectReference(sFormId,'OptionText_English',true);
            if (oOptionText_English!=null && oOptionText_English.length==2)
            {
                oOptionText_English[0].value='Yes';oOptionText_English[0].disabled=true;
                oOptionText_English[1].value='No';oOptionText_English[1].disabled=true;
            }           
    }
}

try{ New_OnClick_Tab(); 
focusOnFirstControl();
}
catch (ex) {}
</script>