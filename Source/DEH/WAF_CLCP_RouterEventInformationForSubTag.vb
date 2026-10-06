Public Class WAF_CLCP_RouterEventInformationForSubTag
    Public Shared Sub AfterSave(ByRef WhizGlobal As WebPages.Template.IGlobal, _
                     ByRef ControlsHashTable As Hashtable, _
                     ByRef PrimaryKey As String, _
                     ByRef strActionCode As String, _
                     ByRef strMasterPrimaryKey As String, _
                     ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
                     ByRef AfterSave As String, _
                     Optional ByRef RedirectToCL As Boolean = True)


        Dim lngTagID As Long
        lngTagID = CType(HttpContext.Current.Request.QueryString("TagID"), Long)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(lngTagID)

    End Sub
End Class
