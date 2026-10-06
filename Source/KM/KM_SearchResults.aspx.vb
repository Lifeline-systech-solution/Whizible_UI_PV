Public Class KM_SearchResults
    Inherits WebPages.Template.WhizTemplate

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

#Region " Constants Used in the Class "
    Private Const UNIQUE_FIELD As String = "ProcedureID"
    Private Const GROUPBY_FIELD As String = "Category"
    Private Const LINK_FIELD As String = "Title"
    Private Const CHECKBOX_NAME As String = "chkFoundIn"

    Private Enum MenuIndex
        ADD_NEW
        AUTHENTICATION_RIGHTS
        HELP
    End Enum
#End Region

#Region " Class scope Variables Declarations "
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(2) As String
    Private m_arrMenuTooltip(2) As String
    Private m_arrClientSideFunctions(2) As String

    Private m_strNbyA As String = ""
    Private m_strPageTitle As String = ""
    Private m_strQuery As String = ""
    Private m_strTextToBeHighlighted As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitPageMenu()

        m_strPageTitle = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("PAGE_TITLE"))
        m_strNbyA = CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("NBYA"))

        m_strQuery = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_Query"))
        m_strTextToBeHighlighted = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText"))
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.KM_SearchResults", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "KM_SearchResults : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW")
        m_arrMenuTooltip(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_NEW) = "New_OnClick()"

        m_arrMenuItem(MenuIndex.AUTHENTICATION_RIGHTS) = MyBase.GetResourceString("MENU_KM_AUTHENTICATION_RIGHTS")
        m_arrMenuTooltip(MenuIndex.AUTHENTICATION_RIGHTS) = MyBase.GetResourceString("MENU_KM_AUTHENTICATION_RIGHTS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.AUTHENTICATION_RIGHTS) = "Rights_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('KM')"

        MyBase.InitializeResources("AppResources.KM_SearchResults", "AppResources")
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<Br>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("SEARCH_RESULTS"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Page Header
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        objHeaderFooter.HeaderFooter = GetUserFriendlySearchQuery()
        CommonFunctions.General.WriteHTML(objHeaderFooter.DrawHeaderFooter(Nothing, True))
        objHeaderFooter.HeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Search Result Grid
        Display_SearchResults()

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<Br>")
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub Display_SearchResults()
        Dim intColumnsToShow As Integer = 0
        Dim intCount As Integer = 0
        Dim intIndex As Integer = 0
        Dim intColWidth As Integer = 0
        Dim drResult As IDataReader
        Dim arrActualColumns() As String = {GROUPBY_FIELD}
        Dim arrUserFriendlyColumn() As String = {GROUPBY_FIELD}
        Dim arrRowLink() As String = {""}
        Dim arrstrTDStyle() As String = {"width='5%' nowrap"}
        Dim arrGroup() As String = {"1"}
        Dim strHTML As String = ""

        drResult = CommonFunctions.Data.GetDataReader(m_strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drResult) <> "" Then
            intColumnsToShow = drResult.FieldCount()
            ReDim Preserve arrActualColumns(intColumnsToShow - 2)
            ReDim Preserve arrUserFriendlyColumn(intColumnsToShow - 2)
            ReDim Preserve arrRowLink(intColumnsToShow - 2)
            ReDim Preserve arrstrTDStyle(intColumnsToShow - 2)
            

            intIndex = 1
            For intCount = 0 To drResult.FieldCount() - 1
                If drResult.GetName(intCount) <> GROUPBY_FIELD And drResult.GetName(intCount) <> UNIQUE_FIELD Then
                    arrActualColumns(intIndex) = drResult.GetName(intCount)
                    arrUserFriendlyColumn(intIndex) = drResult.GetName(intCount)
                    If drResult.GetName(intCount) = LINK_FIELD Then
                        arrRowLink(intIndex) = "LinkField_OnClick('" & UNIQUE_FIELD & "')"
                        arrstrTDStyle(intIndex) = "width='30%' align='left'"
                    Else
                        arrRowLink(intIndex) = ""
                        intColWidth = CType(65 / (intColumnsToShow - 3), Integer)
                        If intColWidth < 10 Then intColWidth = 15
                        arrstrTDStyle(intIndex) = "width='" & intColWidth.ToString() & "%' align='left'"
                    End If
                    intIndex += 1
                End If
            Next
        End If
        CommonFunctions.Data.DisposeDataReader(drResult)
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .GroupOnColumn = arrGroup
            .EmptyValueReplacement = "-"
            .PrimaryKey = UNIQUE_FIELD
            .SQL = m_strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Function GetUserFriendlySearchQuery() As String
        '=====================================================================
        ' Procedure Name        :	GetUserFriendlySearchQuery
        ' Description           :	To retrieve the current search criteria.
        ' Purpose               :	Same as above.
        ' Parameters Passed     :	None.
        ' Returns               :	None.
        ' Parameters Affected   :	None.
        ' Assumptions           :	This function retrieves the previous sessions from the search query that was built.
        '							If any of the parameters in the stored procedure are modified or rearranged,
        '							the corresponding changes must be made in this function as well.
        ' Dependencies          :	None.
        ' Author                :	Jayavant
        ' Created               :	5-Mar-2004
        ' Revisions             :
        '=====================================================================
        Dim strReturn As String = ""

        Dim arrTemp() As String
        Dim strFilterQuery As String = ""
        Dim intUbound As Integer = 0
        Dim drWork As IDataReader
        Dim strQuery As String = ""

        'Search Fields
        Dim strFreeText As String = ""
        Dim blnSearchInAll As Boolean = False
        Dim lngContributorId As Long = 0
        Dim strContributorName As String = ""
        Dim strSubmission_FromDate As String = ""
        Dim strSubmission_ToDate As String = ""
        Dim lngAuthenticatorId As Long = 0
        Dim strAuthenticatorName As String = ""
        Dim strAuthentication_FromDate As String = ""
        Dim strAuthentication_ToDate As String = ""
        Dim lngCategoryId As Long = 0
        Dim strCategoryName As String = ""
        Dim lngSubCategoryId As Long = 0
        Dim strSubCategoryName As String = ""
        Dim lngProjectId As Long = 0
        Dim strProjectName As String = ""

        strFilterQuery = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_Query"))

        ' NOTE: The parameters to the stored procedure can be retrieved by splitting them at
        '		every occurance of comma. But if the free text itself contains comma(s), 
        '		it may cause a problem. This case needs to be handled.
        ' If the free text contains any commas, then...

        If InStr(CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText")), ",", CompareMethod.Text) <> 0 Then
            ' Split the free text and get the number of commas present in the string.
            arrTemp = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText")).Split(CType(",", Char))

            ' Now, split the main query on the commas, and replace them with empty string. 
            ' This operation will remove the commas from the free text in the main query.
            ' This query can now be split correctly for the other parameters.
            intUbound = arrTemp.Length
            arrTemp = Split(strFilterQuery, ",", intUbound + 1, CompareMethod.Text)
            strFilterQuery = Join(arrTemp, "")
        End If
        arrTemp = Split(strFilterQuery, ",")

        intUbound = UBound(arrTemp)
        If intUbound < 17 Then
            Exit Function
        End If

        strReturn &= MyBase.GetResourceString("SEARCH_CRITERIA_APPLIED") & "<BR>"

        ' Free Text.
        strFreeText = CommonFunctions.General.CheckIsNothing(Session.Item("KM_Search_FreeText"))

        If strFreeText <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("TEXT") & " <B>" & strFreeText & "</B> " & MyBase.GetResourceString("FOUND_IN")

            ' Search in All.
            If Trim(arrTemp(8)) = "1" Then
                blnSearchInAll = True
            End If

            ' Search in Title.
            If Trim(arrTemp(1)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("TITLE") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Code.
            If Trim(arrTemp(2)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("CODE_ARTICLE") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Example.
            If Trim(arrTemp(3)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("EXAMPLE") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Comments.
            If Trim(arrTemp(4)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("COMMENTS") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Prerequisites.
            If Trim(arrTemp(5)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("PREREQUISITES") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Application.
            If Trim(arrTemp(6)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("ARTICLE_APPLIED") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            ' Search in Attachment Names.
            If Trim(arrTemp(7)) = "1" Or blnSearchInAll = True Then
                strReturn &= "<I>" & MyBase.GetResourceString("ATTACHMENT_NAMES") & "</I> " & MyBase.GetResourceString("OR") & " "
            End If

            strReturn = Left(strReturn, InStrRev(strReturn, MyBase.GetResourceString("OR")) - 1)
            strReturn &= "] " & MyBase.GetResourceString("AND") & " "
        End If

        ' Contributed By.
        If Trim(arrTemp(9)) <> "NULL" Then
            lngContributorId = CType("0" & Trim(arrTemp(9)), Long)
            GetEmployeeInfo(lngContributorId, strContributorName)
            strReturn &= "[ " & MyBase.GetResourceString("CONTRIBUTED_BY") & " = <B>" & Server.HtmlEncode(strContributorName) & "</b> ] " & MyBase.GetResourceString("AND") & " "
        End If

        ' Date of Submission (From date).
        If Trim(arrTemp(10)) <> "NULL" Then
            strSubmission_FromDate = Trim(arrTemp(10))
            strSubmission_FromDate = Mid(strSubmission_FromDate, 2, Len(strSubmission_FromDate) - 2)
        End If

        ' Date of Submission (To date).
        If Trim(arrTemp(11)) <> "NULL" Then
            strSubmission_ToDate = Trim(arrTemp(11))
            strSubmission_ToDate = Mid(strSubmission_ToDate, 2, Len(strSubmission_ToDate) - 2)
        End If

        ' Submission period (From and To dates).
        If strSubmission_FromDate <> "" And strSubmission_ToDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_SUBMITTED_BETWEEN") & " <B>" & strSubmission_FromDate & "</B> " & MyBase.GetResourceString("AND") & " <B>" & strSubmission_ToDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        ElseIf strSubmission_FromDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_SUBMITTED_ON_AFTER") & " <B>" & strSubmission_FromDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        ElseIf strSubmission_ToDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_SUBMITTED_ON_BEFORE") & " <B>" & strSubmission_ToDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        End If

        ' Authenticated By.
        If Trim(arrTemp(12)) <> "NULL" Then
            lngAuthenticatorId = CType("0" & Trim(arrTemp(12)), Long)
            GetEmployeeInfo(lngAuthenticatorId, strAuthenticatorName)
            strReturn &= "[ " & MyBase.GetResourceString("AUTHENTICATED_BY") & " = <B>" & Server.HtmlEncode(strAuthenticatorName) & "</b> ] " & MyBase.GetResourceString("AND") & " "
        End If

        ' Date of Authentication (From date).
        If Trim(arrTemp(13)) <> "NULL" Then
            strAuthentication_FromDate = Trim(arrTemp(13))
            strAuthentication_FromDate = Mid(strAuthentication_FromDate, 2, Len(strAuthentication_FromDate) - 2)
        End If

        ' Date of Authentication (To date).
        If Trim(arrTemp(14)) <> "NULL" Then
            strAuthentication_ToDate = Trim(arrTemp(14))
            strAuthentication_ToDate = Mid(strAuthentication_ToDate, 2, Len(strAuthentication_ToDate) - 2)
        End If

        ' Authentication period (From and To dates).
        If strAuthentication_FromDate <> "" And strAuthentication_ToDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_AUTHETICATED_BETWEEN") & " <B>" & strAuthentication_FromDate & "</B> " & MyBase.GetResourceString("AND") & " <B>" & strAuthentication_ToDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        ElseIf strAuthentication_FromDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_AUTHETICATED_ON_AFTER") & " <B>" & strAuthentication_FromDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        ElseIf strAuthentication_ToDate <> "" Then
            strReturn &= "[ " & MyBase.GetResourceString("ARTICLE_AUTHETICATED_ON_BEFORE") & " <B>" & strAuthentication_ToDate & "</B> ] " & MyBase.GetResourceString("AND") & " "
        End If

        ' Category.
        If Trim(arrTemp(15)) <> "NULL" Then
            lngCategoryId = CType("0" & Trim(arrTemp(15)), Long)
            strQuery = "Exec usp_Sel_tbl_KM_Categories " & lngCategoryId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strCategoryName = drWork.Item("CategoryName").ToString()
                    strCategoryName = CommonFunctions.General.UnBuildQueryString(strCategoryName)
                    strCategoryName = Server.HtmlEncode(strCategoryName)
                    strReturn &= "[ " & MyBase.GetResourceString("CATEGORY") & " = <B>" & strCategoryName & "</B> ] " & MyBase.GetResourceString("AND") & " "
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If

        ' Sub Category.
        If Trim(arrTemp(16)) <> "NULL" Then
            lngSubCategoryId = CType("0" & Trim(arrTemp(16)), Long)
            strQuery = "Exec usp_Sel_tbl_KM_SubCategories " & lngSubCategoryId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strSubCategoryName = drWork.Item("SubCategoryName").ToString()
                    strSubCategoryName = CommonFunctions.General.UnBuildQueryString(strSubCategoryName)
                    strSubCategoryName = Server.HtmlEncode(strSubCategoryName)
                    strReturn &= "[ " & MyBase.GetResourceString("SUBCATEGORY") & " = <B>" & strSubCategoryName & "</B> ] " & MyBase.GetResourceString("AND") & " "
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If

        ' Project.
        If Trim(arrTemp(17)) <> "NULL" Then
            lngProjectId = CType("0" & Trim(arrTemp(17)), Long)
            strQuery = "Exec usp_Sel_tbl_PM_Project " & lngProjectId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strProjectName = drWork.Item("ProjectName").ToString()
                    strProjectName = CommonFunctions.General.UnBuildQueryString(strProjectName)
                    strProjectName = Server.HtmlEncode(strProjectName)
                    strReturn &= "[ " & MyBase.GetResourceString("PROJECT") & " = <B>" & strProjectName & "</B> ] " & MyBase.GetResourceString("AND") & " "
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If

        strReturn = Left(strReturn, InStrRev(strReturn, MyBase.GetResourceString("AND")) - 1)

        Return (strReturn)

    End Function

    Private Sub GetEmployeeInfo(ByVal lngEmployeeId As Long, ByRef strEmployeeName As String)
        Dim drEmployee As IDataReader
        Dim strQuery As String = ""

        strEmployeeName = ""
        If lngEmployeeId <= 0 Then Return

        strQuery = "usp_tbl_Sel_EmployeeInfo " & lngEmployeeId.ToString()
        drEmployee = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmployee) <> "" Then
            If drEmployee.Read() Then
                strEmployeeName = drEmployee.Item("UserName").ToString()
                strEmployeeName = CommonFunctions.General.UnBuildQueryString(strEmployeeName)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If CType("0" & CommonFunctions.General.CheckIsNothing(Session.Item("intPostID")), Long) <> CommonFunctions.Constants.ROLE_ADMINISTRATOR And Args.LinkName = m_arrMenuItem(MenuIndex.AUTHENTICATION_RIGHTS) Then Cancel = True
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'If Args.DataReader.GetDataTypeName(Args.DataReader.GetOrdinal(Args.DataField.ToString())).ToUpper() = "BOOLEAN" Then
        If Args.DataReader.Table.Columns(Args.DataField.ToString()).DataType().ToString.ToUpper = "BOOLEAN" Then
            If Args.DataFieldValue.ToString() = "" Then
                Args.DataFieldValue = m_strNbyA
            Else
                Args.DataFieldValue = CommonFunctions.HTMLControls.DrawCheckBox(CHECKBOX_NAME, CHECKBOX_NAME, , CType(Args.DataFieldValue, Boolean), Args.DataReader.Item(UNIQUE_FIELD).ToString(), , , True)
            End If
        Else
            'If Args.DataReader.GetDataTypeName(Args.DataReader.GetOrdinal(Args.DataField.ToString())).ToUpper() = "DATETIME" Then
            If Args.DataReader.Table.Columns(Args.DataField.ToString()).DataType().ToString.ToUpper = "DATETIME" Then
                Args.TDStyle = "nowrap"
            End If
            If Args.DataFieldValue.ToString().IndexOf("IMG") > 0 Then
                Args.ApplyHTMLEncode = False
            End If
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Args.TDStyle = "valign=top"
    End Sub
End Class
