<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_ConfigureAccess_CommonList.aspx.vb" Inherits="PbNIT.CRM_ConfigureAccess_CommonList"%>
<!DOCTYPE HTML>
<script language="javascript" >

var objFrm=GetFormReference('frmCommonList');

function SaveConfigureAccess()
{
    //Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
    //debugger;
    var objImgLoader = GetObjectReference('frmCommonList','imgLoader');
    objImgLoader.style.display = "";
    var objlblAlertMessage = GetObjectReference('frmCommonList','lblAlertMessage');
    objlblAlertMessage.style.display = "";
    
    var objlblSavedMessage = GetObjectReference('frmCommonList','lblSavedMessage');
    if (objlblSavedMessage.style.display == "")
    {
        objlblSavedMessage.style.display = "none"
    }
    
    //End of Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
    
    objFrm.action="../CRM/CRM_ConfigureAccess_CommonList.aspx?CustomFieldID=<%=m_strCustomFieldID%>&MasterTagId=3981&EntityName=<%=m_strEntityName%>&Action=Save&FromNewUI=1";
    objFrm.submit();
  
}
</script> 