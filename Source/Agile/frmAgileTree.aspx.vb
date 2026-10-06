Public Class frmAgileTree
    Inherits WebPages.Template.WhizTemplate
    Protected strPageName As String = ""
    Protected strClass As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

    End Sub

    Protected Function PlotLeftTree() As String
        '=====================================================================
        'Procedure Name         : PlotLeftTree()
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	Draw controls
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vaijat K
        ' Created				:	19/02/2018
        ' Revisions				:	
        '=====================================================================

        Dim strHTML As New StringBuilder()

        strHTML.Append("<div id='divTree' class='menuburger'>")
        strHTML.Append("<div class='Activity'>")
        strHTML.Append("<table id='tblTree'>")
        Dim strSql As String = "usp_sel_tbl_UI_APP_TagMaster " & Session("intUserID") & "," & Session("intPostID") & "," & Session("intProjectID") & ",'" & Session("LoginType") & "','PM'"

        Dim dtTagList As New DataTable
        dtTagList = CommonFunctions.Data.GetDataTable(strSql, True)
        For index As Integer = 0 To dtTagList.Rows.Count - 1
            'If index = 6 Then
            '    strHTML.Append("<tr>")
            '    strHTML.Append("<td>")
            '    strHTML.Append("<a href='#'><i class='fa fa-angle-double-down arrow bounce' title='Scroll Down' data-toggle='tooltip'  data-placement='top'></i></a>")
            '    strHTML.Append("<td>")
            '    strHTML.Append("</tr>")
            '    If GetTagAccessRights(CommonFunction.Data.CheckIsDBNull(dtTagList.Rows(index)("TagID"), 0)) = True Or CommonFunction.Data.CheckIsDBNull(dtTagList.Rows(index)("TagID"), 0) = 0 Then
            '        strHTML.Append("<tr>")
            '        If index = 0 Then
            '            strPageName = CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayPageName"), "")
            '            strClass = "active"
            '        Else
            '            strClass = ""
            '        End If
            '        strHTML.Append("<td class='tab" & strClass & "' onclick=NavigateToAgile('" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayPageName"), "") & "',this)  title='" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "'   data-toggle='tooltip' data-placement='right'>")

            '        strHTML.Append("<label>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("Images"), "") & "</label>")
            '        strHTML.Append("<label class='PageName'>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "</label>")
            '        strHTML.Append("</td>")
            '        strHTML.Append("</tr>")
            '    End If
            'Else
            If GetTagAccessRights(CommonFunction.Data.CheckIsDBNull(dtTagList.Rows(index)("TagID"), 0)) = True Or CommonFunction.Data.CheckIsDBNull(dtTagList.Rows(index)("TagID"), 0) = 0 Then
                strHTML.Append("<tr>")
                If index = 0 Then
                    strPageName = CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayPageName"), "")
                    strClass = "active"
                Else
                    strClass = ""
                End If
                strHTML.Append("<td class='tab" & strClass & "' onclick=NavigateToAgile('" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayPageName"), "") & "',this) >")

                strHTML.Append("<label  title='" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "'  data-toggle='tooltip'  data-container='body' data-placement='right'>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("Images"), "") & " </label></div>")
                strHTML.Append("<label class='PageName'>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "</label>")

                'strHTML.Append("<td class='tab" & strClass & "' onclick=NavigateToAgile('" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayPageName"), "") & "',this)  title='" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "'   data-toggle='tooltip' data-placement='right'>")

                'strHTML.Append("<label>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("Images"), "") & "</label>")
                'strHTML.Append("<label class='PageName'>" & CommonFunctions.Data.CheckIsDBNull(dtTagList.Rows(index)("DisplayTagName"), "") & "</label>")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
            End If
            'End If
        Next
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        'strHTML.Append("<a href='#'><i class='fa fa-angle-double-down arrow bounce' title='Scroll Down' data-toggle='tooltip'  data-placement='bottom'></i></a>")
        strHTML.Append("<i class='fa fa-angle-double-down arrow bounce' title='Scroll Down' data-toggle='tooltip' data-container='body' data-placement='right'></i>")
        strHTML.Append("</div>")

        Return strHTML.ToString()
    End Function

    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = True) As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Vaijat K
        ' Created				:	19/02/2018
        ' Revisions				:	
        '=====================================================================
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, lngTagID, Session("intPostID"), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
        'Create the object of GetAccess class
        Dim objGetAccess As New WebPage.Templates.AccessRights
        'Call method get access to get the access

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            objGetAccess.GetAccess(objGlobal, IsModuleAccess)

            If IsModuleAccess Then
                Return objGetAccess.Access()
            End If

            If objGetAccess.Add = True OrElse objGetAccess.Delete = True OrElse objGetAccess.Edit = True OrElse objGetAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function

End Class
