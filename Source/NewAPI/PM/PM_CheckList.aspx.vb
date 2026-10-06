Public Class PM_CheckList
    Inherits WebPages.Template.WhizTemplate

    Public m_PM_CheckListAddAccess As Boolean = False
    Public m_PM_CheckListDeleteAccess As Boolean = False
    Public m_PM_CheckListEditAccess As Boolean = False
    Public m_PM_CheckListViewAccess As Boolean = False

    Public m_PKToken_ToCheckList As String
    Public m_PKToken_FromResourcesList As String
    Public ProjectID As Int32

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        MyBase.InitializeResources("Whizible2Resources.Source.PM.CheckLists", "Whizible2Resources")
        CreatePM_CheckListGlobalObject()

        ProjectID = Convert.ToInt32(Session("intProjectID"))
        m_PKToken_ToCheckList = CommonFunctions.Security.Token.GetToken("2263" + ProjectID + CType(Session("intUserID"), String))

        'If (((m_PKToken_ToCheckList = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken("2263" + ProjectID + CType(Session("intUserID"), String), m_PKToken_ToCheckList) = False)) Then

        '    System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")

        'End If
        m_PKToken_ToCheckList = Trim(Request.QueryString("PKToken") & "")
        If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Session("intUserID"), String), m_PKToken_ToCheckList) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
        End If
    End Sub
    Public Sub CreatePM_CheckListGlobalObject()
        Dim objGlobal As WebPages.Template.IGlobal
        ' Session("IssueSQL") = ""
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 2263

        Dim objAccess As New WebPages.Template.AccessRights
        objAccess.GetAccess(objGlobal)

        m_PM_CheckListAddAccess = objAccess.Add 'If user has AddNew Access
        m_PM_CheckListDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_PM_CheckListEditAccess = objAccess.Edit 'If user has Edit Access
        m_PM_CheckListViewAccess = objAccess.View 'If user has Edit Access

        If (m_PM_CheckListAddAccess = True Or m_PM_CheckListEditAccess = True Or m_PM_CheckListDeleteAccess = True) Then
            m_PM_CheckListViewAccess = True
        End If
    End Sub

    'Function MyFunc() As Integer


    '    Case CommonFunction.Constants.APP_TAG_PROJECT_CHECKLIST
    '    ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
    '    Dim drAccessRights As IDataReader
    '    Dim strQuery As String
    '    Dim intPostId As Integer
    '    Dim intUserId As Integer
    '    Dim strLoginType As String
    '    Dim intProjectID As Integer
    '    Dim blnAddRight As Boolean
    '    Dim blnEditRight As Boolean
    '    intPostId = CType(HttpContext.Current.Session("intPostID"), Integer)
    '    intUserId = CType(HttpContext.Current.Session("intUserID"), Integer)
    '    strLoginType = CType(HttpContext.Current.Session("LoginType"), String)
    '    intProjectID = CType(HttpContext.Current.Session("intProjectID"), Integer)

    '    strQuery = "Exec usp_Sel_tbl_UI_NodeAccess 2263 ," & intPostId.ToString & "," & intUserId.ToString & ",'" & strLoginType & "'," & intProjectID.ToString
    '    drAccessRights = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
    '    If CommonFunctions.General.CheckIsNothing(drAccessRights) <> "" Then
    '        drAccessRights.Read()
    '        blnAddRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("A"), "False"), Boolean)
    '        blnEditRight = CType(CommonFunctions.Data.CheckIsDBNull(drAccessRights.Item("E"), "False"), Boolean)

    '    End If
    '    CommonFunctions.Data.DisposeDataReader(drAccessRights)

    '    'end of addition by harshada

    '    Dim strSQLQuery As String
    '    Dim drCompareRevision As IDataReader
    '    Dim strIsCopyCheckList As String
    '    strSQLQuery = ""
    '    If Args.ColumnName.ToUpper = "CHECKLIST TYPE" Then
    '        strIsCopyCheckList = Args.DataReader("IsCopyCheckList").ToString
    '        If strIsCopyCheckList.ToUpper = "TRUE" Then
    '            Args.IgnoreActualValue = True
    '            Args.ReplacementValue = "Project Specific"
    '        Else
    '            Args.IgnoreActualValue = True
    '            Args.ReplacementValue = "Inherited"
    '        End If
    '    End If
    '    If Args.ColumnName.ToUpper = "GET LATEST REVISION" Then
    '        strIsCopyCheckList = Args.DataReader("IsCopyCheckList").ToString
    '        If strIsCopyCheckList.ToUpper = "TRUE" Then
    '            Args.IgnoreActualValue = True
    '            Args.EnableLink = False
    '            Args.ReplacementValue = ""
    '        Else
    '            If Args.DataReader("ProjectCheckListID").ToString <> "" Then
    '                strSQLQuery = "EXEC usp_Sel_tbl_PM_WorkOrderChecklist_CheckLatest " & CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String)
    '                drCompareRevision = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
    '                If drCompareRevision.Read Then
    '                    Args.IgnoreActualValue = True
    '                    Args.EnableLink = False
    '                    Args.ReplacementValue = "<FONT color='RED'>" + "Latest" + "</FONT>"
    '                End If
    '                CommonFunctions.Data.DisposeDataReader(drCompareRevision)
    '            End If
    '        End If
    '    End If
    '    '-----------------End----------------------------------------------------
    '    '--------Added by HarshK on 18/07/2005
    '    Dim strProjectCheckListID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectCheckListID"), "0"), String) & ""
    '    Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    '    If Args.ColumnName.ToUpper = "COPY" Then
    '        ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
    '        If (blnAddRight = True Or blnEditRight = True) Then
    '            'end of addition by harshada .
    '            strSQLQuery = "usp_Sel_tbl_PM_WorkOrderChecklist_IsPublished " + strProjectCheckListID.Trim
    '            If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer) = 0 Then
    '                Args.IgnoreActualValue = True
    '                Args.StringToBeInserted = "<TD><IMG Border=0  SRC='../../Images/Copy.gif' title='Please publish the checklist to use for Copy checklist.' ></A></TD>"
    '                Cancel = True
    '                Args.EnableLink = False
    '            End If
    '        Else

    '            Cancel = True

    '        End If

    '    End If

    '    'if Revisionstatus="D" then display link as publish,else dont display link
    '    If Args.DataField.ToLower = "hyperlink1" Then
    '        ' added by harshada d for checklist issue fixes if role doesnt have add or delete access rhen copy and publish links should not be displayed
    '        If (blnAddRight = True Or blnEditRight = True) Then
    '            'end of addition by harshada
    '            strSQLQuery = "usp_Sel_tbl_PM_WorkOrderChecklist_IsPublished " + strProjectCheckListID.Trim
    '            If CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, blnUseSQL), "0"), Integer) > 0 Then
    '                'If the checklist is published then do not show the link..
    '                Args.IgnoreActualValue = True
    '                Args.ReplacementValue = "<FONT color='RED'>" + "Published" + "</FONT>"
    '                Args.EnableLink = False
    '                'added by harshada d for whiziblesem SP 7.4 for chkList issue . if no items present then chklist will be published
    '            Else
    '                Dim drCntOfQuestionaire As IDataReader
    '                Dim strSQLCntOfQuestionaireID As String
    '                Dim intCntOfprojectChecklistItemID As Integer
    '                Dim strFunction As String
    '                'If CommonFunction.Data.CheckIsDBNull(Args.DataReader("QuestionnaireID"), "").ToString.Trim <> "" Then
    '                Dim drApplicableChecklists As IDataReader
    '                strSQLCntOfQuestionaireID = "select ISNULL(count(projectChecklistItemID),0) AS CountprojectChecklistItemID from tbl_PM_WorkOrderCheckListItem  where projectChecklistID =  " + Args.DataReader("projectChecklistID").ToString
    '                intCntOfprojectChecklistItemID = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLCntOfQuestionaireID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
    '                If intCntOfprojectChecklistItemID = 0 Then
    '                    Cancel = True
    '                    Args.StringToBeInserted = "<TD align=left Title=""Column Name : Publish"">"
    '                    Args.StringToBeInserted += "<A href='JavaScript:PublishNoItems_OnClick()' >Publish"
    '                    Args.StringToBeInserted += "</A>"
    '                    Args.StringToBeInserted += "</TD>"
    '                    Args.StringToBeInserted += "<Script language='JavaScript'>"
    '                    Args.StringToBeInserted += " function PublishNoItems_OnClick() { "
    '                    Args.StringToBeInserted += " alert('There are no checklist items present against this checklist , cannot publish it');"
    '                    Args.StringToBeInserted += " }"
    '                    Args.StringToBeInserted += "</Script>"
    '                    CommonFunctions.Data.DisposeDataReader(drCntOfQuestionaire)
    '                    ' End If
    '                End If
    '            End If
    '        Else

    '            Cancel = True

    '        End If

    '    End If
    '    '---------END HarshK on 18/07/2005----------------------------------------------------------------

    '    ' Modified By NitinVs on 23 Apr 2007 for WhizibleSEM SP 8 regression Fiexes Issue 12367 
    '    ' Tocheck add access for COPY and EDIT Access for PUBLISH 

    '    If Args.ColumnName.ToUpper = "COPY" Then
    '        If (blnAddRight = True) Then
    '        Else
    '            Cancel = True
    '        End If
    '    End If
    '    'end of addition by harshada
    '    If Args.ColumnName.ToUpper = "PUBLISH" Then
    '        If (blnEditRight = True) Then
    '        Else
    '            Cancel = True
    '        End If
    '    End If

    '    Return 0
    'End Function

End Class