Imports System.Web
Public Class DynamicMenuRouter

    Public Shared Sub AfterSave(ByRef WhizGlobal As WebPages.Template.IGlobal, _
                 ByRef ControlsHashTable As Hashtable, _
                 ByRef PrimaryKey As String, _
                 ByRef strActionCode As String, _
                 ByRef strMasterPrimaryKey As String, _
                 ByRef m_objTemplate As WebPages.Template.WhizTemplate, _
                 ByRef AfterSave As String, _
                 Optional ByRef RedirectToCL As Boolean = True)

        'Application standard return code. Do not comment following lines
        Dim objEvent As CommonEngine.General.cEventHandlers
        strActionCode = objEvent.ReturnCodes.DO_NOTHING.ToString

        CommonEngines.HashTables.CreateHashTables.CreateMenuSettingsHashTable()

    End Sub
    Public Shared Sub Before_PlotControl(ByRef Cancel As Boolean, _
                   ByRef Args As EventHandlers.WAF_Controls, _
                   ByRef WhizGlobal As WebPages.Template.IGlobal, _
                   Optional ByRef drControls As IDataReader = Nothing, _
                   Optional ByRef InsertBeforeControl As String = "")

        If Args.ControlName.ToLower = "shadowcolor" Then
            Cancel = True
            InsertBeforeControl = CommonFunction.HTMLControls.DrawColorComboBox("shadowcolor", , drControls(Args.ControlName).ToString, , , True, , False)
        End If
    End Sub

End Class
