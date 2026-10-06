Imports CommonEngines.General.cEventHandlers



Public Class TSMailerConfiguration_CommonPage
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
        MyBase.strListPage = "TSMailerConfiguration_CommonList.aspx"
        MyBase.strFormPage = "TSMailerConfiguration_CommonPage.aspx"
        Dim strMode As String = ""
        strMode = CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "")
        If strMode.ToUpper = "SAVE" Then
            Dim strSelected() As String
            Dim strNotSelected() As String
            Dim strConfigureFor As String
            Dim intCount As Integer
            strConfigureFor = CommonFunction.General.CheckIsNothing(Request.QueryString("Entity"), "").ToString.ToUpper
            strSelected = (CommonFunction.General.CheckIsNothing(Request.QueryString("List"), "").ToString).Split(","c)
            strNotSelected = (CommonFunction.General.CheckIsNothing(Request.QueryString("Unchecked"), "").ToString).Split(","c)

            For intCount = 0 To strSelected.Length - 1
                If strSelected(intCount) <> "" Then
                    CommonFunction.Data.InsertOrUpdateData("Usp_Ins_Upd_TSConfiguration Null," + strSelected(intCount).ToString + ",'" + strConfigureFor + "'", True)
                End If
            Next

            For intCount = 0 To strNotSelected.Length - 1
                If strNotSelected(intCount) <> "" Then
                    CommonFunction.Data.InsertOrUpdateData("usp_Del_TSM_NotApplicable_TSConfiguration " + strNotSelected(intCount).ToString + ",'" + strConfigureFor + "'", True)
                End If
            Next

        End If
        MyBase.Page_Load(sender, e)
    End Sub
    'Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
    '    Dim strSQL As String
    '    strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = 3649  And Identifier= 'SUBTAG'"
    '    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    'End Function
    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New TSMailerConfiguration_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New TSMailerConfiguration_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function
    'Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
    '    Return New TSMailerConfiguration_CommonPagePlotGrid(MyBase.m_ObjGlobal)
    'End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New TSMailerConfiguration_CommonPageSubTagPlotGrid(MyBase.m_objGlobal)
    End Function
    Public Function CheckRoleAccess(ByVal intTagID As Integer, ByVal intParentTagID As Integer) As Boolean

        Dim drAccess As IDataReader
        Dim strQuery As String

        'Check if Project is Selected
        'If Not CType(Session("intProjectID"), String) = "" Then
        '    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'," + CType(Session("intProjectID"), String)
        'Else
        '    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "'"
        'End If

        strQuery = "Exec usp_Sel_tbl_UI_NodeAccess " + CType(intTagID, String) + "," + CType(Session("intPostID"), String) + "," + CType(Session("intUserID"), String) + ",'" + CType(Session("LoginType"), String) + "',Null," + CType(intParentTagID, String)

        '##### Get the Default Approver
        drAccess = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If intParentTagID = 0 Then
            If drAccess.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drAccess("A"), "0"), Boolean) And CType(CommonFunctions.Data.CheckIsDBNull(drAccess("E"), "0"), Boolean) Then
                    CheckRoleAccess = True
                Else
                    CheckRoleAccess = False
                End If
            End If
        Else
            If drAccess.Read Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drAccess("A"), "0"), Boolean) And CType(CommonFunctions.Data.CheckIsDBNull(drAccess("E"), "0"), Boolean) Then
                    CheckRoleAccess = True
                Else
                    CheckRoleAccess = False
                End If
            End If
        End If

        CommonFunctions.Data.DisposeDataReader(drAccess)
        '##### End 

    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Business Group 
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3193 And Args.LinkName.ToUpper = "SAVE" Then
            If CheckRoleAccess(3193, 3649) = False Then
                Cancel = True
            End If
            Args.ToBeInserted = "<Script language=javascript >" + vbCrLf
            Args.ToBeInserted += "function SaveConfiguration(Entity,strSelected,strNotselected)" + vbCrLf
            Args.ToBeInserted += "{ var objList = GetObjectReference('frmCommonPage','chkDelete3193',true);" + vbCrLf
            Args.ToBeInserted += "objfrm.action='TSMailerConfiguration_CommonPage.aspx?Mode=SAVE&Entity='+Entity+'&List='+strSelected+'&Unchecked='+strNotselected;" + vbCrLf
            Args.ToBeInserted += "objfrm.submit()" + vbCrLf
            Args.ToBeInserted += "}"
            Args.ToBeInserted += "</Script>"
        End If
        'Orgnization Unit
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3194 And Args.LinkName.ToUpper = "SAVE" Then
            If CheckRoleAccess(3194, 3649) = False Then
                Cancel = True
            End If
            Args.ToBeInserted = "<Script language=javascript >" + vbCrLf
            Args.ToBeInserted += "function SaveConfiguration(Entity,strSelected,strNotselected)" + vbCrLf
            Args.ToBeInserted += "{ var objList = GetObjectReference('frmCommonPage','chkDelete3194',true);" + vbCrLf
            Args.ToBeInserted += "objfrm.action='TSMailerConfiguration_CommonPage.aspx?Mode=SAVE&Entity='+Entity+'&List='+strSelected+'&Unchecked='+strNotselected;" + vbCrLf
            Args.ToBeInserted += "objfrm.submit()" + vbCrLf
            Args.ToBeInserted += "}"
            Args.ToBeInserted += "</Script>"
        End If
        'Delivery Unit
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3195 And Args.LinkName.ToUpper = "SAVE" Then
            If CheckRoleAccess(3195, 3649) = False Then
                Cancel = True
            End If
            Args.ToBeInserted = "<Script language=javascript >" + vbCrLf
            Args.ToBeInserted += "function SaveConfiguration(Entity,strSelected,strNotselected)" + vbCrLf
            Args.ToBeInserted += "{ var objList = GetObjectReference('frmCommonPage','chkDelete3195',true);" + vbCrLf
            Args.ToBeInserted += "objfrm.action='TSMailerConfiguration_CommonPage.aspx?Mode=SAVE&Entity='+Entity+'&List='+strSelected+'&Unchecked='+strNotselected;" + vbCrLf
            Args.ToBeInserted += "objfrm.submit()" + vbCrLf
            Args.ToBeInserted += "}"
            Args.ToBeInserted += "</Script>"
        End If
        'Delivery Team
        If WhizGlobal.ParentTagID <> 0 And WhizGlobal.TagID = 3196 And Args.LinkName.ToUpper = "SAVE" Then
            If CheckRoleAccess(3196, 3649) = False Then
                Cancel = True
            End If
            Args.ToBeInserted = "<Script language=javascript >" + vbCrLf
            Args.ToBeInserted += "function SaveConfiguration(Entity,strSelected,strNotselected)" + vbCrLf
            Args.ToBeInserted += "{ var objList = GetObjectReference('frmCommonPage','chkDelete3196',true);" + vbCrLf
            Args.ToBeInserted += "objfrm.action='TSMailerConfiguration_CommonPage.aspx?Mode=SAVE&Entity='+Entity+'&List='+strSelected+'&Unchecked='+strNotselected;" + vbCrLf
            Args.ToBeInserted += "objfrm.submit()" + vbCrLf
            Args.ToBeInserted += "}"
            Args.ToBeInserted += "</Script>"
        End If
        If WhizGlobal.ParentTagID = 0 And WhizGlobal.TagID = 3649 And Args.LinkName.ToUpper = "SAVE" Then
            If CheckRoleAccess(3649, 0) = False Then
                Cancel = True
            End If
        End If
    End Sub


    'Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function
End Class

Public Class TSMailerConfiguration_CommonPageSubTagPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    Dim strNewGridSQL As String
    '    strNewGridSQL = Args.GridSQL
    '    strNewGridSQL = strNewGridSQL.Replace(" WHERE 1 = 1 AND ", " WHERE 1 = 1 OR ")
    '    Args.GridSQL = strNewGridSQL
    'End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim obj As New TSMailerConfiguration_CommonPage
        Dim intSubTagID As Integer
        Dim strReplaceValue As String
        Dim strSQL As String
        'If global.ParentTagID = 0 Then
        '    If Args.ColumnName.ToUpper = "CONFIGURE CC" And Args.DataReader("TSMConfigured").ToString = "0" Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<TD align=Left >Configure CC</TD>"
        '    End If

        '    If Args.ColumnName.ToUpper = "SELECT" And Args.DataReader("TSMConfigured").ToString.ToUpper = "1" Then
        '        Args.IsSelected = True
        '    End If
        'End If

        If WhizGlobal.ParentTagID = 0 Then
            If Args.ColumnName.ToUpper = "CONFIGURE CC" Then
                If Args.DataReader("TSMConfigured").ToString = "0" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=Left >Configure CC</TD>"
                Else
                    Select Case Args.PrimaryKeyName.ToUpper
                        Case "BUSINESSGROUPID"
                            intSubTagID = 3193
                            strSQL = "Usp_Get_Configure_CCList " + Args.DataReader("BUSINESSGROUPID").ToString + ", 'BG'"
                        Case "LOCATIONID"
                            intSubTagID = 3194
                            strSQL = "Usp_Get_Configure_CCList " + Args.DataReader("LOCATIONID").ToString + ", 'OU'"
                        Case "RESOURCEPOOLID"
                            intSubTagID = 3195
                            strSQL = "Usp_Get_Configure_CCList " + Args.DataReader("RESOURCEPOOLID").ToString + ", 'DU'"
                        Case "GROUPID"
                            intSubTagID = 3196
                            strSQL = "Usp_Get_Configure_CCList " + Args.DataReader("GROUPID").ToString + ", 'DT'"
                    End Select
                    strReplaceValue = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strSQL, True), "").ToString
                    If obj.CheckRoleAccess(intSubTagID, 3649) = False Then
                        Cancel = True
                        Args.StringToBeInserted = "<TD align=Left >" + strReplaceValue + "</TD>"
                    End If
                End If
            End If

            If Args.ColumnName.ToUpper = "SELECT" And Args.DataReader("TSMConfigured").ToString.ToUpper = "1" Then
                Args.IsSelected = True
            End If
        End If



        'If Args.ColumnName.ToUpper = "CONFIGURE CC" Then
        '    If obj.CheckRoleAccess(CType(global.TagID, Integer), CType(global.ParentTagID, Integer)) = False Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<TD align=Left >" + Args.DataReader("HyperLink1").ToString + "</TD>"
        '    End If
        'End If

        'If global.ParentTagID = 0 Then
        '    Dim strReplacementValue, strsql As String
        '    If Args.ColumnName.ToUpper = "SELECT" Then
        '        'strsql = "SELECT EmployeeID from tbl_PM_Employee_ResourceFullControlUsers WHERE EmployeeID=" & CType(Args.DataReader("EmployeeID"), String)
        '        strsql = "usp_RM_hasLeaveDataAccess " & CType(Args.DataReader("EmployeeID"), String)

        '        Dim hasAccess As Integer = CType(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Integer)

        '        ' Args.IgnoreActualValue = True
        '        strReplacementValue = "<td > <input type=checkbox id=chkDelete name=chkDelete value=" + CType(Args.DataReader("EmployeeID"), String) + " OnClick=javascript:chkSelect_OnClick(this) "

        '        If hasAccess = 0 Then
        '            strReplacementValue = strReplacementValue + " > </td>"
        '        Else
        '            strReplacementValue = strReplacementValue + " checked > </td>"
        '        End If

        '        'strReplacementValue = CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , False, CType(Args.DataReader("EmployeeID"), String), , " onclick=javascript:chkSelect_OnClick(this)", True)
        '        ' Args.ReplacementValue = strReplacementValue

        '        Args.StringToBeInserted = strReplacementValue
        '        Cancel = True
        '    End If
        'End If


    End Sub

    Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub
End Class


Public Class TSMailerConfiguration_DataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

'Public Class TSMailerConfiguration_EventHandlers
'    Inherits CommonEngine.General.cEventHandlers
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New()
'    End Sub

'End Class


Public Class TSMailerConfiguration_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Private m_lngSubTagToBeSelected As Long = 0
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        Dim blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        Dim strKey As String = HttpContext.Current.Session("intUserID").ToString + "-" + HttpContext.Current.Session("LoginType").ToString + "-SUBTAG-3649"
        Dim strSelectedSubTag As String = CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "0")

        Dim strQueryStringValue As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FocusOn"), "")
        If strQueryStringValue <> "" Then
            m_lngSubTagToBeSelected = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubTagId"), "0"), Long)
        Else
            m_lngSubTagToBeSelected = CType(CommonFunctions.Data.GetDataScalar("Usp_Get_Default_SubTagID " + strSelectedSubTag, blnUseSQL), Long)
        End If
    End Sub

    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'Dim drSelectedSubTag As IDataReader
        'Dim blnEnabledAtBG As Boolean = False
        'Dim blnEnabledAtOU As Boolean = False
        'Dim blnEnabledAtDU As Boolean = False
        'Dim blnEnabledAtDT As Boolean = False
        'drSelectedSubTag = CommonFunction.General.CheckIsNothing()
        'drSelectedSubTag = CommonFunction.Data.GetDataReader("Select EnabledAtBG,EnabledAtOU,EnabledAtDU,EnabledAtDT From tbl_CNF_TSMailerConfiguration ", True)
        'If drSelectedSubTag.Read Then
        '    blnEnabledAtBG = CType(drSelectedSubTag(0), Boolean)
        '    blnEnabledAtOU = CType(drSelectedSubTag(1), Boolean)
        '    blnEnabledAtDU = CType(drSelectedSubTag(2), Boolean)
        '    blnEnabledAtDT = CType(drSelectedSubTag(3), Boolean)
        'End If
        Dim IsEnabled As String = ""
        Dim strSQL As String = ""
        Dim strInsert As String = ""
        Dim strSubTagID As String = ""

        Select Case Args.SubTagID
            Case 3193
                IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 EnabledAtBG From tbl_CNF_TSMAilerConfiguration", True), "False").ToString
                Args.SelectedSubTagID = m_lngSubTagToBeSelected

                Dim strKey As String = HttpContext.Current.Session("intUserID").ToString + "-" + HttpContext.Current.Session("LoginType").ToString + "-SUBTAG-3649"
                Dim lngSelectedSubTag As Long = CType(CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "0"), Long)


                If IsEnabled.ToUpper = "FALSE" Then
                    Cancel = True


                    'If currunt subtag which is cancelled, is the selected subtag then its entry should be removed 
                    'from user preferences and cache
                    If Args.SubTagID = lngSelectedSubTag Then
                        strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = 3649  And Identifier= 'SUBTAG'"
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                        'Select the first subtag by order from the available subtags
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtOU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                        If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtOU ", True), Boolean) Then
                            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                            strSubTagID = "3194"
                        Else
                            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                            'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                            If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtOU", True), Boolean) Then
                                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                strSubTagID = "3195"
                            Else
                                'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDT from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                                If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                                    'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                    strSubTagID = "3196"
                                End If
                            End If
                        End If

                        'insert the entry for the selected subtag in database as well as cache of user preferences
                        If strSubTagID <> "" Then
                            strInsert = "Insert Into tbl_UI_UserPreferences(UserID,LoginType,Identifier,ItemID,Value) "
                            strInsert += "values (" & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("LoginType").ToString & "','SUBTAG',3649," & strSubTagID & ")"
                            CommonFunction.Data.InsertOrUpdateData(strInsert, True)
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strKey, strSubTagID)
                        End If

                    End If
                End If

            Case 3194
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                'IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 EnabledAtOU From tbl_CNF_TSMAilerConfiguration", True), "False").ToString
                IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMAilerConfiguration_EnabledAtOU_1", True), "False").ToString
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                Args.SelectedSubTagID = m_lngSubTagToBeSelected

                Dim strKey As String = HttpContext.Current.Session("intUserID").ToString + "-" + HttpContext.Current.Session("LoginType").ToString + "-SUBTAG-3649"
                Dim lngSelectedSubTag As Long = CType(CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "0"), Long)

                If IsEnabled.ToUpper = "FALSE" Then
                    Cancel = True

                    If Args.SubTagID = lngSelectedSubTag Then

                        strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = 3649  And Identifier= 'SUBTAG'"
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtBG from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                        If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtBG", True), Boolean) Then
                            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                            strSubTagID = "3193"
                        Else
                            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                            ' If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                            If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtDU", True), Boolean) Then
                                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                                strSubTagID = "3195"
                            Else
                                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDT from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                                If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtDU", True), Boolean) Then
                                    'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                                    strSubTagID = "3196"
                                End If
                            End If
                        End If

                        If strSubTagID <> "" Then
                            strInsert = "Insert Into tbl_UI_UserPreferences(UserID,LoginType,Identifier,ItemID,Value) "
                            strInsert += "values (" & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("LoginType").ToString & "','SUBTAG',3649," & strSubTagID & ")"
                            CommonFunction.Data.InsertOrUpdateData(strInsert, True)
                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strKey, strSubTagID)
                        End If


                    End If
                End If

            Case 3195
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                'IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 EnabledAtDU From tbl_CNF_TSMAilerConfiguration", True), "False").ToString
                IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMAilerConfiguration_EnabledAtDU_1", True), "False").ToString
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                Args.SelectedSubTagID = m_lngSubTagToBeSelected

                Dim strKey As String = HttpContext.Current.Session("intUserID").ToString + "-" + HttpContext.Current.Session("LoginType").ToString + "-SUBTAG-3649"
                Dim lngSelectedSubTag As Long = CType(CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "0"), Long)

                If IsEnabled.ToUpper = "FALSE" Then
                    Cancel = True


                    If Args.SubTagID = lngSelectedSubTag Then

                        strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = 3649  And Identifier= 'SUBTAG'"
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtBG from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                        If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtBG", True), Boolean) Then
                            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                            strSubTagID = "3193"
                        Else
                            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                            'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtOU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                            If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtDU", True), Boolean) Then
                                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                strSubTagID = "3194"
                            Else
                                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDT from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                                If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtDT", True), Boolean) Then
                                    'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                    strSubTagID = "3196"
                                End If
                            End If
                        End If

                        If strSubTagID <> "" Then
                            strInsert = "Insert Into tbl_UI_UserPreferences(UserID,LoginType,Identifier,ItemID,Value) "
                            strInsert += "values (" & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("LoginType").ToString & "','SUBTAG',3649," & strSubTagID & ")"
                            CommonFunction.Data.InsertOrUpdateData(strInsert, True)

                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strKey, strSubTagID)
                        End If
                    End If
                End If

            Case 3196
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                ' IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 EnabledAtDT From tbl_CNF_TSMAilerConfiguration", True), "False").ToString
                IsEnabled = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMAilerConfiguration_EnabledAtDT_1", True), "False").ToString
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                Args.SelectedSubTagID = m_lngSubTagToBeSelected

                Dim strKey As String = HttpContext.Current.Session("intUserID").ToString + "-" + HttpContext.Current.Session("LoginType").ToString + "-SUBTAG-3649"
                Dim lngSelectedSubTag As Long = CType(CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strKey), "0"), Long)

                If IsEnabled.ToUpper = "FALSE" Then
                    Cancel = True


                    If Args.SubTagID = lngSelectedSubTag Then
                        strSQL = "Delete From tbl_UI_UserPreferences Where UserId = " & HttpContext.Current.Session("intUserID").ToString & " And ItemID = 3649  And Identifier= 'SUBTAG'"
                        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        ''If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtBG from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                        If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtBG", True), Boolean) Then
                            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                            strSubTagID = "3193"
                        Else
                            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                            ''If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtOU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                            If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtOU", True), Boolean) Then
                                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                strSubTagID = "3194"
                            Else
                                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                'If CType(CommonFunction.Data.GetDataScalar("Select EnabledAtDU from tbl_CNF_TSMailerConfiguration", True), Boolean) Then
                                If CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration_EnabledAtDU", True), Boolean) Then
                                    'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                                    strSubTagID = "3195"
                                End If
                            End If
                        End If

                        If strSubTagID <> "" Then
                            strInsert = "Insert Into tbl_UI_UserPreferences(UserID,LoginType,Identifier,ItemID,Value) "
                            strInsert += "values (" & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("LoginType").ToString & "','SUBTAG',3649," & strSubTagID & ")"
                            CommonFunction.Data.InsertOrUpdateData(strInsert, True)

                            CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strKey, strSubTagID)
                        End If
                    End If
                End If
        End Select

    End Sub
End Class

Public Class TSMailerConfiguration_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class TSMailerConfiguration_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class



