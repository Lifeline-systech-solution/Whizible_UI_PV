<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PublishSurvey_CommonList.aspx.vb" Inherits="Whiz.PublishSurvey_CommonList"%>

<script language =javascript >
    function OpenWindowPublish(SurveyPublishID, IsPublished,Title_English,SurveyTypeID)
    {
        var iWidth=930;
        var iHeight=600;
        switch(SurveyTypeID)
        {
            case "0":        
            if(IsPublished == "0")
            {
               window.open("../WhizSurvey/PublishSurvey_CommonPage.aspx?SurveyPublishID_PK=" + SurveyPublishID +  "&MasterTagID=1797&FromCL=1&Title_English="+Title_English,"_new","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - iWidth)/2 + ",top=" + (window.screen.height - iHeight)/2 + ",width="+iWidth+",height="+iHeight);
            }
            else
            {
               window.open("../WhizSurvey/PublishSurvey_CommonPage.aspx?SurveyPublishID_PK=" + SurveyPublishID +  "&MasterTagID=1797&FromCL=1&IsPublished=1&Title_English="+Title_English,"_new","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - iWidth)/2 + ",top=" + (window.screen.height - iHeight)/2 + ",width="+iWidth+",height="+iHeight);
            }
            break;
            
            case "1":
            if(IsPublished=="0")
            {
               window.open("../WhizSurvey/PublishPoll_CommonPage.aspx?SurveyPublishID_PK=" + SurveyPublishID +  "&MasterTagID=1797&FromCL=1&Title_English="+Title_English,"_new","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - iWidth)/2 + ",top=" + (window.screen.height - iHeight)/2 + ",width="+iWidth+",height="+iHeight);
            }
            else
            {
               window.open("../WhizSurvey/PublishPoll_CommonPage.aspx?SurveyPublishID_PK=" + SurveyPublishID +  "&MasterTagID=1797&FromCL=1&IsPublished=1&Title_English="+Title_English,"_new","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - iWidth)/2 + ",top=" + (window.screen.height - iHeight)/2 + ",width="+iWidth+",height="+iHeight);
            }
            break;
        }    
    }
</script>