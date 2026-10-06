Public Class Settings_Tabs
    Inherits WebPages.Template.WhizTemplate

#Region "Member Declaration"
    Public Shared m_blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Protected m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

    End Sub
    Protected Function WriteSettingTabs(ByVal strFlag As String) As String
        Dim strTabHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim drTab As IDataReader
        Dim TabID, strTabName, strTabURL, strTabOrder, strFirstTab, strParentTagID As String
        'Commented By Dipali V On 27th March 2020 For As per login type node should be display
        'strSQL = "Usp_NG2_Sel_tbl_NG2_SettingsTabs "
        strSQL = "Usp_NG2_Sel_tbl_NG2_SettingsTabs '" & Session("LoginType").ToString & "'"
        'End of Commented By Dipali V On 27th March 2020 For As per login type node should be display
        drTab = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        Dim strSqlForTag As String
        Dim dtTagDetails As DataTable
        Dim HasAccess As String
        Dim Counter As Integer
        Counter = 1
        Dim icon As String = ""
        While drTab.Read
            TabID = CommonFunctions.Data.CheckIsDBNull(drTab("SettingTabID"))
            strTabName = CommonFunctions.Data.CheckIsDBNull(drTab("SettingTabName"))
            strTabURL = CommonFunctions.Data.CheckIsDBNull(drTab("TabURL"))
            strTabOrder = CommonFunctions.Data.CheckIsDBNull(drTab("OrderNumber"))
            'strParentTagID = CommonFunctions.Data.CheckIsDBNull(drTab("ParentTagID"))
            icon = CommonFunctions.Data.CheckIsDBNull(drTab("icon"))
            ''Commented By Vaijat K ON 15/12/2017 For opening the first tab
            'If Counter = 1 Then
            '    strFirstTab = strTabName
            'End If
            ''End Commented By Vaijat K ON 15/12/2017 For opening the first tab
            strSqlForTag = "usp_sel_tbl_NG2_TagMaster  " & TabID & "," & Session("intUserID").ToString & "," & Session("intPostID").ToString & "," & CommonFunction.General.CheckIsNothing(Session("intProjectID"), "NULL") & ",'" & Session("LoginType").ToString & "','SM'"
            dtTagDetails = CommonFunctions.Data.GetDataTable(strSqlForTag, True)
            HasAccess = "0"
            For i As Integer = 0 To dtTagDetails.Rows.Count - 1
                Dim strTagid As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("TagID"), "")
                'strParentTagID = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("ParentTagID"), "")
                'GetGlobalObject(strTagid, strParentTagID)
                If GetTagAccessRights(strTagid) = True Then
                    HasAccess = "1"
                End If
            Next
            'GetTagAccessRights(strTagID)
            If HasAccess = "1" Then
                ''Added By Vaijat K ON 15/12/2017 For opening the first tab
                If strFirstTab Is Nothing Then
                    strFirstTab = strTabName
                End If
                ''End Added By Vaijat K ON 15/12/2017 For opening the first tab
                If (strTabName = strFirstTab) Then
                    strTabHTML.Append("<button class='btnSettingTab' onclick=""openCity(event, '" & strTabName & "','" & strTabURL & "')"" id='defaultOpen' >" & icon & "  " & strTabName & "</button>" & vbCrLf)
                Else
                    strTabHTML.Append("<button class='btnSettingTab' onclick=""openCity(event, '" & strTabName & "','" & strTabURL & "')""  >" & icon & "  " & strTabName & "</button>" & vbCrLf)
                End If
            End If

            Counter += 1
        End While

        If strFlag = "" Then
            CommonFunctions.General.WriteHTML(strTabHTML.ToString)
        Else
            strTabHTML.ToString()
        End If

    End Function
#Region "Request Tab Section Related Code"

    Protected Sub GetGlobalObject(ByVal TagID As String, ByVal ParentTagID As String)
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get the global object and assign it to variable
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vidya Jadhav
        ' Created               :	1 Nov  2016
        '=====================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        'If RequestTypeTagID <> "" Then
        '    m_objGlobal.TagID = RequestTypeTagID
        'End If
        m_objGlobal.TagID = TagID
        m_objGlobal.ParentTagID = ParentTagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    Private Function GetTagAccessRights(ByVal lngTagID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the global object and assign it to variable
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vidya Jadhav
        ' Created               :	1 Nov  2016
        '=====================================================================

        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, lngTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
        'Create the object of GetAccess class
        Dim objGetAccess As New WebPage.Templates.AccessRights
        'Call method get access to get the access

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 
            objGetAccess.GetAccess(objGlobal)

            If objGetAccess.Add = True OrElse objGetAccess.Delete = True OrElse objGetAccess.Edit = True OrElse objGetAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode
    End Function
#End Region
End Class