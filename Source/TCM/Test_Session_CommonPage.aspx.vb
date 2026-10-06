Imports CommonEngines.General.cEventHandlers
Public Class Test_Session_CommonPage
    Inherits CommonPage
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        If Request.QueryString("FromXML") = "1" Then
            Call PopulateCombo()
        End If
        MyBase.strListPage = "Test_Session_CommonList.aspx"
        MyBase.strFormPage = "Test_Session_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cTest_SessionPlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cTest_SessionPlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cTest_SessionCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cTest_SessionDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cTest_SessionSubTagCLSQL(WhizGlobal)
    End Function

    Private Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load


    End Sub
    Private Sub PopulateCombo()
        '====================================================================
        ' Procedure Name        : PopulateCombo
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Populates the Session Variable Combo on Selection of Session Type Combo
        ' Description           : same as above
        ' Assumptions           : none
        ' Dependencies          : none
        ' Author                : RajeshJ
        ' Created               : Nov 16 ,2006
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim DrReader As IDataReader
        Dim strSessionVariableName As String
        Dim strSessionDetailId As String
        Dim strComboString As String
        Dim strSessionVariable As String
        Dim strComboString_f As String 'Stores String to be written to the Session Variable Combo

        strComboString = ""

        strSQL = "usp_sel_tbl_TCM_TestSession_SessionVariable " + Request.QueryString("SessionTypeID")

        DrReader = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        strSessionVariable = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), "")

        If strSessionVariable = "" Then ' When there is No Session Variable Against a Session Type
            strComboString = ","
            Response.Clear()

            Response.Write(strComboString)
            Response.End()
        Else
            While DrReader.Read 'When there Exists Session Variable Against a Session Type
                strSessionVariableName = DrReader("SessionVariableName").ToString()
                strSessionDetailId = DrReader("SessionDetailId").ToString()
                strComboString = strComboString + strSessionVariableName + "," + strSessionDetailId + ","

            End While

            CommonFunction.Data.DisposeDataReader(DrReader)
            strComboString_f = strComboString.Substring(0, strComboString.Length - 1)
            Response.Clear()
            Response.Write(strComboString_f)
            Response.End()
        End If

    End Sub
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Added By NitinC on 19 April 2011 for WhizbibleSEM 10.0
        'Purpose: To save custom fields

        ''Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
        If Convert.ToInt32(PrimaryKey) > 0 Then
            Dim strSQLQuery As String
            Dim WorkHourMinute As String
            Dim WorkHour As String
            Dim WorkMinute As String

            WorkHourMinute = CommonFunction.General.CheckIsNothing(ControlsHashTable("NonDatabase10"))

            If WorkHourMinute = "" Then
                WorkHourMinute = "00:00"
            End If

            WorkHour = WorkHourMinute.Substring(0, WorkHourMinute.IndexOf(":"))
            WorkMinute = WorkHourMinute.Substring(WorkHourMinute.IndexOf(":") + 1)

            If WorkHour = "" Then
                WorkHour = "0"
            End If
            If WorkMinute = "" Then
                WorkMinute = "0"
            End If
            If WorkMinute.Length = 1 Then
                WorkMinute = WorkMinute + "0"
            End If

            strSQLQuery = "EXEC usp_Whizible2_upd_EstimatedEffortsForWBS " & PrimaryKey & ",'" & WorkHour & "','" & WorkMinute & "',12"
            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, True)
        End If

        ''End of Added By Usha Pandit on 05-Mar-2019 Purpose::Project Work field level changes 
    End Function
End Class
Public Class cTest_SessionDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cTest_SessionSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    'Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'Args.
    'End Sub

    'Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub


    'Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'Args.IsInsert = True
    '    'args.
    'End Sub


End Class
Public Class cTest_SessionCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cTest_SessionPlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub




    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

        If Args.ControlName = "ConductedBy" Then

            Args.Editable = False


        End If


    End Sub


End Class



