Imports CommonEngines.General.cEventHandlers
Public Class TemplateDesign_CommonPage
    Inherits CommonPage
    Private m_strTemplateID As String
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
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "TemplateDesign_CommonList.aspx"
        MyBase.strFormPage = "TemplateDesign_CommonPage.aspx"
        MyBase.Page_Load(sender, e)

    End Sub
    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim EntityID As Integer = CType(ControlsHashTable("EntityID"), Integer)
        Dim strSQL As String

        If EntityID = 6 Or EntityID = 7 Then
            strSQL = "Update tbl_DXU_TemplateMaster set IsSpecialRequest = 1 where TemplateID = " & PrimaryKey
            CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If
    End Function


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cTemplateDesign_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New cTemplateDesign_CommonPagePlotControls(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cTemplateDesign_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cTemplateDesign_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function


    Protected Overloads Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cTemplateDesign_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
            Args.ToBeInsertedInFunction = "objForm = GetFormReference('frmCommonPage') " + vbCrLf
            Args.ToBeInsertedInFunction += "objstartCol = GetObjectReference('frmCommonPage','ActivityStartColumn')" + vbCrLf
            Args.ToBeInsertedInFunction += "objEndCol = GetObjectReference('frmCommonPage','ActivityEndColumn')" + vbCrLf
            Args.ToBeInsertedInFunction += "objEntityID = GetObjectReference('frmCommonPage','EntityID')" + vbCrLf
            Args.ToBeInsertedInFunction += "if (document.getElementById('ActivityEndColumn').parentNode.parentNode.style.display!='none'){ " + vbCrLf
            Args.ToBeInsertedInFunction += " if (objEntityID.value != 7) {" + vbCrLf
            Args.ToBeInsertedInFunction += "if(disallowBlank(objstartCol,'Enter Value for Activity start column')==true)  return;" + vbCrLf
            Args.ToBeInsertedInFunction += "if(disallowBlank(objEndCol,'Enter Value for Activity End column')==true)  return;" + vbCrLf
            Args.ToBeInsertedInFunction += "}" + vbCrLf
            Args.ToBeInsertedInFunction += "else {" + vbCrLf
            Args.ToBeInsertedInFunction += "if(disallowBlank(objstartCol,'Enter Value for Resource start column')==true)  return;" + vbCrLf
            Args.ToBeInsertedInFunction += "if(disallowBlank(objEndCol,'Enter Value for Resource End column')==true)  return;" + vbCrLf
            Args.ToBeInsertedInFunction += "}" + vbCrLf
            Args.ToBeInsertedInFunction += "}" + vbCrLf
            'Args.ToBeInsertedInFunction += "alert('Enter ActivityEndColumn');return;}" + vbCrLf
        End If
    End Sub
End Class

Public Class cTemplateDesign_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cTemplateDesign_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '__________Added By HemantB on Dec 09, 2004 for Template Design Utility________________________
        Dim strConnStringExcel As String
        Dim strSourceFilePath As String = HttpContext.Current.Server.MapPath(CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + Args.AttTblCol_SystemFileNameValue)
        Dim objConnection As New ADODB.Connection
        Dim intCounter As Integer = 0

        Dim objExcel As New ADOX.Catalog
        Dim objConn As New CommonFunctions.Connection
        Dim objDataReader As System.Data.IDataReader
        Dim sqlCmd As SqlClient.SqlCommand
        'Code modified by SandipL added try - Catch block
        Try
            'Connection string for EXCEL file.
            ''Added by swapnil aswale on 4th Jan 2016
            Dim checkExtension As String = System.IO.Path.GetExtension(strSourceFilePath)
            If checkExtension.ToString = ".xls" Then
                strConnStringExcel = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strSourceFilePath & ";Extended Properties=""Excel 8.0;HDR=Yes;IMEX=1"""
            ElseIf checkExtension.ToString = ".xlsx" Then
                strConnStringExcel = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & strSourceFilePath & ";Extended Properties=""Excel 12.0;HDR=Yes;IMEX=1"""

            End If
            strConnStringExcel &= "Extended Properties=""Excel 8.0;HDR=YES;IMEX=1"""
            ''Ended
            'strConnStringExcel = "Provider=" & _
            '   "Microsoft.Jet.OLEDB.4.0;" & _
            '   "Data Source=" & strSourceFilePath & ";" & _
            '   "Extended Properties=Excel 8.0;"

            objConnection.Open(strConnStringExcel)
            objExcel.ActiveConnection = objConnection

            Dim strSQL As String
            strSQL = "SELECT TOP 1 * FROM [" & objExcel.Tables(0).Name & "]"

            'Getting TemplateID - Template for which this file is uploaded.
            Dim intTemplateId As Integer
            intTemplateId = CType(Args.AttTblCol_ForeignKeyValue, Integer)

            objDataReader = CommonFunctions.Data.GetDataReader(strSQL, False, strConnStringExcel)
            sqlCmd = New SqlClient.SqlCommand
            sqlCmd.Connection = objConn.GetSQLConnection(CommonFunction.General.GetConnectionString)

            ' Delete earlier records from the TemplateDetails table while re-uploading for 
            ' the(already) existing Template.

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Dim strCheckSQL As String = "Select * from tbl_DXU_TemplateDetails where TemplateID = " & intTemplateId
            Dim strCheckSQL As String = "usp_sel_tbl_DXU_TemplateDetails_TemplateID " & intTemplateId
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Dim objChkDataReader As System.Data.IDataReader

            objChkDataReader = CommonFunctions.Data.GetDataReader(strCheckSQL, True)
            If objChkDataReader.Read = True Then
                strSQL = "Delete from tbl_DXU_TemplateDetails where TemplateId = " & intTemplateId
                sqlCmd.CommandText = strSQL
                sqlCmd.ExecuteNonQuery()
                strSQL = "Delete from tbl_DXU_Lookup where TemplateId = " & intTemplateId
                sqlCmd.CommandText = strSQL
                sqlCmd.ExecuteNonQuery()
            End If
            CommonFunction.Data.DisposeDataReader(objChkDataReader)
            ' Code added by SwapnilR on 3rd Jun 2005
            ' Purpose : If template is made for special request then 
            '           donot insert the columns which are greater than the activity start column
            Dim strSQLCheck As String = ""
            Dim objDr As IDataReader
            Dim blnIsSpecialRequest As Boolean
            Dim intActivityStartColumn As Integer
            Dim blnInsertFlag As Boolean = False
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQLCheck = "SELECT * FROM tbl_DXU_TemplateMaster WHERE EntityID = 6  and TemplateID = " + intTemplateId.ToString
            strSQLCheck = "usp_tbl_DXU_TemplateMaster_EntityID_TemplateID " + intTemplateId.ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            objDr = CommonFunction.Data.GetDataReader(strSQLCheck, True)

            If objDr.Read Then
                blnIsSpecialRequest = CType(CommonFunction.General.CheckIsNothing(objDr("IsSpecialRequest"), "False"), Boolean)
                intActivityStartColumn = CType(CommonFunction.General.CheckIsNothing(objDr("ActivityStartColumn"), CType(objDataReader.FieldCount, String)), Integer)
                If blnIsSpecialRequest = True Then
                    For intCounter = 0 To intActivityStartColumn - 2
                        strSQL = "Insert into tbl_DXU_TemplateDetails (TemplateId,TemplateFieldName,ActualExcelColName) values("
                        strSQL &= intTemplateId & ",'"
                        strSQL &= Replace(objDataReader.GetName(intCounter), " ", "") & "','"
                        strSQL &= objDataReader.GetName(intCounter) & "')"
                        sqlCmd.CommandText = strSQL
                        sqlCmd.ExecuteNonQuery()
                    Next
                    blnInsertFlag = True
                End If
                strSQL = ""
                strSQL = "INSERT INTO tbl_DXU_TemplateDetails (TemplateID, TemplateFieldName, ActualExcelColName, DataType) Values ("
                strSQL = strSQL + intTemplateId.ToString + ", 'SubTaskTypes', 'SubTaskTypes','nvarchar')"
                sqlCmd.CommandText = strSQL
                sqlCmd.ExecuteNonQuery()
            End If
            CommonFunction.Data.DisposeDataReader(objDr)
            'Code added by SandipL for Template Resource Distribution ( DXU Enhancements)
            'WhizEngg Team 

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQLCheck = "SELECT * FROM tbl_DXU_TemplateMaster WHERE EntityID = 7  and TemplateID = " + intTemplateId.ToString
            strSQLCheck = "usp_sel_tbl_DXU_TemplateMaster_EntityID_7_TemplateID " + intTemplateId.ToString
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            objDr = CommonFunction.Data.GetDataReader(strSQLCheck, True)

            If objDr.Read Then
                'blnIsSpecialRequest = CType(CommonFunction.General.CheckIsNothing(objDr("IsSpecialRequest"), "False"), Boolean)
                intActivityStartColumn = CType(CommonFunction.General.CheckIsNothing(objDr("ActivityStartColumn"), CType(objDataReader.FieldCount, String)), Integer)
                'If blnIsSpecialRequest = True Then
                For intCounter = 0 To intActivityStartColumn - 2
                    strSQL = "Insert into tbl_DXU_TemplateDetails (TemplateId,TemplateFieldName,ActualExcelColName) values("
                    strSQL &= intTemplateId & ",'"
                    strSQL &= Replace(objDataReader.GetName(intCounter), " ", "") & "','"
                    strSQL &= objDataReader.GetName(intCounter) & "')"
                    sqlCmd.CommandText = strSQL
                    sqlCmd.ExecuteNonQuery()
                Next
                blnInsertFlag = True
                ' End If
                ''strSQL = ""
                strSQL = "INSERT INTO tbl_DXU_TemplateDetails (TemplateID, TemplateFieldName, ActualExcelColName, DataType) Values ("
                strSQL = strSQL + intTemplateId.ToString + ", 'UserName', 'UserName','nvarchar')"
                sqlCmd.CommandText = strSQL
                sqlCmd.ExecuteNonQuery()
            End If



            'End addition by SandipL
            If blnInsertFlag = False Then
                ' End of code addition by SwapnilR on 3rd Jun 2005
                'Inserting each column-headers of the EXCEL file into the Template Details table.
                For intCounter = 0 To objDataReader.FieldCount - 1
                    strSQL = "Insert into tbl_DXU_TemplateDetails (TemplateId,TemplateFieldName,ActualExcelColName) values("
                    strSQL &= intTemplateId & ",'"
                    strSQL &= Replace(objDataReader.GetName(intCounter), " ", "") & "','"
                    strSQL &= objDataReader.GetName(intCounter) & "')"
                    sqlCmd.CommandText = strSQL
                    sqlCmd.ExecuteNonQuery()
                Next
                ' Code added by SwapnilR on 3rd Jun 2005
            End If
            objDataReader.Close()
            objDataReader = Nothing
            objConnection.Close()
            objConnection = Nothing
            objDr.Close()
            objDr = Nothing
        Catch

            If objConnection.State = ConnectionState.Open Then
                objConnection.Close()
                objConnection = Nothing
            End If
            If Not objDataReader Is Nothing Then
                If objDataReader.IsClosed = False Then
                    objDataReader.Close()
                    objDataReader = Nothing
                End If
            End If

        End Try
        'End Modification by SandipL (try - Catch block)

        ' End of code addition by SwapnilR on 3rd Jun 2005

    End Sub

End Class
Public Class cTemplateDesign_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cTemplateDesign_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private IsMappingDone As Boolean = False
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        Dim strSQL As String
        Dim intCount As Integer
        Dim strTemplateID As String
        strTemplateID = HttpContext.Current.Request("TemplateID_PK")
        If strTemplateID <> "" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "Select Count(1) As [Count] from tbl_DXU_TemplateDetails Where TemplateID = " & strTemplateID & " And ActualFieldName IS NOT NULL"
            strSQL = "usp_tbl_DXU_TemplateDetails_count " & strTemplateID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            intCount = CType(CommonFunctions.Data.GetDataScalar(strSQL, True), Integer)
            If intCount > 0 Then
                IsMappingDone = True
            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("EntityID")).ToString = "7" Or Args.IsEditMode Then
            If Args.IsEditMode Then
                Dim strSQL As String
                Dim drEntity As IDataReader
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "Select EntityID from tbl_DXU_TemplateMaster where TemplateID = " & CType(Args.PrimaryKeyValue, String)
                strSQL = "usp_sel_tbl_DXU_TemplateMaster_ENtityID " & CType(Args.PrimaryKeyValue, String)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                drEntity = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drEntity.Read Then
                    If CType(drEntity("EntityID"), String) = "7" Then
                        Select Case Args.ControlName.ToUpper
                            Case "ACTIVITYSTARTCOLUMN"
                                Args.ControlCaption = "Resource Start Column "
                            Case "ACTIVITYENDCOLUMN"
                                Args.ControlCaption = "Resource End Column "
                        End Select
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drEntity)
            Else
                Select Case Args.ControlName.ToUpper
                    Case "ACTIVITYSTARTCOLUMN"
                        Args.ControlCaption = "Resource Start Column "
                    Case "ACTIVITYENDCOLUMN"
                        Args.ControlCaption = "Resource End Column "
                End Select
            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If Not HttpContext.Current.Request.QueryString("IsComboChange") Is Nothing Then
            If Args.ControlName = "PrimaryKey" Then
                'Args.IgnoreActualValue = True
                Args.AdditionalInformation = "SELECT FieldName, UserFriendlyName FROM tbl_DXU_EntityDetails" _
                                                & " WHERE Show = 1 and EntityID = " & HttpContext.Current.Request.Form("EntityID") + " Order by UserFriendlyName"
                Args.DropDownEditSQL = Args.AdditionalInformation
            End If
        End If
        Select Case Args.ControlName.ToUpper
            Case "TEMPLATENAME"
            Case Else
                If IsMappingDone Then
                    Args.Editable = False
                End If
        End Select
    End Sub

    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
        If Not HttpContext.Current.Request.Form("TemplateName") Is Nothing And HttpContext.Current.Request.Form("TemplateName") <> "" And (Args.ControlName = "TemplateName") Then
            CommonFunction.General.WriteHTML("<script language=Javascript>")
            CommonFunction.General.WriteHTML("var objTemplateName = GetObjectReference('frmCommonPage', 'TemplateName');")
            CommonFunction.General.WriteHTML("if(objTemplateName!=null) objTemplateName.value = """ + Replace(HttpContext.Current.Request.Form("TemplateName"), """", "\""") + """;")
            CommonFunction.General.WriteHTML("</script>")

        End If
        If Not HttpContext.Current.Request.Form("EntityID") Is Nothing And HttpContext.Current.Request.Form("EntityID") <> "" And (Args.ControlName = "EntityID") Then
            CommonFunction.General.WriteHTML("<script language=Javascript>")
            CommonFunction.General.WriteHTML("var objEntityID = GetObjectReference('frmCommonPage', 'EntityID');")
            CommonFunction.General.WriteHTML("if(objEntityID!=null) objEntityID.value = " + HttpContext.Current.Request.Form("EntityID") + ";")
            CommonFunction.General.WriteHTML("</script>")

        End If
        'Code added by SandipL on 22 sep 2005
        'DXU Enhancements

        If Args.ControlName.ToUpper = "ACTIVITYSTARTCOLUMN" Then
            InsertAfterControl = CommonFunction.HTMLControls.DrawMandatoryImage(, True)
        ElseIf Args.ControlName.ToUpper = "ACTIVITYENDCOLUMN" Then
            InsertAfterControl = CommonFunction.HTMLControls.DrawMandatoryImage(, True)
        End If

    End Sub
End Class


