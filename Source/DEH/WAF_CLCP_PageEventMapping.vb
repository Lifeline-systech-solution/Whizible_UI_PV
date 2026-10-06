Imports System.Web
Public Class WAF_CLCP_PageEventMapping
    Public Shared Sub After_ExecutingAction(ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, _
                     ByRef WhizGlobal As WebPages.Template.IGlobal, _
                     Optional ByRef PrimaryKey As String = "", _
                     Optional ByRef ControlsHashTable As Hashtable = Nothing)

        Dim lngTagID As Long
        lngTagID = CType(HttpContext.Current.Request.QueryString("Tag"), Long)
        CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(lngTagID)
    End Sub
End Class
