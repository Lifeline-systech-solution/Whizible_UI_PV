<%@ Page Language="vb" AutoEventWireup="false" Codebehind="OnBehalfAvailableSurvey_CommonList.aspx.vb" Inherits="Whiz.OnBehalfAvailableSurvey_CommonList"%>
<script language="javascript" type="text/javascript">
function AddAnonymousResponse(SurveyID,SecToken)
{
    var sURL="../WhizSurvey/ConductSurvey.aspx?MemberID=0&SurveyType=1&Mode=3&SubMode=1&Lang=1033&SurveyID="
    sURL+=SurveyID+"&SecToken="+SecToken;
    window.open(sURL,"_conduct","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 630) / 2 + ",width=900,height=630");
}
</script>