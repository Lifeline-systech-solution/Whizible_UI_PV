#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.Text
#End Region

Public Class DB_PMDocument
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Page Initialization"
    Public Sub PageInit()

        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : main procedure to build page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================
        Response.Write("<DIV ID='PageDiv' Style='Height:80%;WIDTH:100%;OVERFLOW:auto;'>")
        DisplayGrid()
        Response.Write("</DIV>")
    End Sub ' Main procedure to build page

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Nov 17, 2005
        ' Revisions             :
        '=====================================================================

        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DocumentType", "AppResources")

    End Sub ' Constructor for the page
#End Region

    Private Function GetStartDateOfWeek() As Date
        '====================================================================
        ' Function Name        :   PlotGridForPreviousWeek()
        ' Parameters Passed     :   None
        ' Returns               :   Date
        ' Parameters Affected   :   None
        ' Purpose               :   To get The FromDate And Todate for The specific week
        ' Description           :   To get The FromDate And Todate for The specific week
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   ManishK
        ' Created               :   9th Dec 2005
        ' Revisions             :   
        '=====================================================================
        Dim intStartDayofWeek As Integer
        Dim tempDate As Date

        intStartDayofWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT StartingDayOfWeek FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        Select Case intStartDayofWeek

            Case 1
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Monday) - 1), System.DateTime.Now)
            Case 2
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday) - 1), System.DateTime.Now)
            Case 3
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday) - 1), System.DateTime.Now)
            Case 4
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Thursday) - 1), System.DateTime.Now)
            Case 5
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Friday) - 1), System.DateTime.Now)
            Case 6
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Saturday) - 1), System.DateTime.Now)
            Case 7
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Sunday) - 1), System.DateTime.Now)

        End Select

        Return tempDate

    End Function

    Private Sub DisplayGrid()

        '====================================================================
        ' Procedure Name        :   DisplayGrid
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw grid
        ' Description           :   This procedure is used to draw grid on the page.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   ManishK
        ' Created               :   9th Dec 2005
        ' Revisions             :   
        '=====================================================================
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' width='99.9%' cellSpacing='0' cellPadding='0' >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'>")
        CommonFunctions.General.WriteHTML("<td align='left'>" & MyBase.GetResourceString("CAP_DOCUMENTS") & "</td>")
        'Commented By SandeepA on 22 Dec,2005 to remove Help link
        CommonFunctions.General.WriteHTML("<td  colspan='5' align='right'>|")
        CommonFunctions.General.WriteHTML("<Font color='white'><a class='Menu' href=javascript:Help_OnClick('Documents')>" & MyBase.GetResourceString("MENU_QUESTION_MARK") & "</a></font>|</td>")
        'End of Comment by SandeepA on 22 Dec,2005
        CommonFunctions.General.WriteHTML("</tr >")
        CommonFunctions.General.WriteHTML("</table>")

        Response.Write("<DIV Id='PageDiv' Style='Width:100%;OverFlow:auto; Height:435px'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' width='99.9%' cellSpacing='0' cellPadding='0' >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<tr class=clsTREven>")
        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan='6'>")
        'tO Do
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellSpacing='0' cellPadding='0' width='99.9%' align='center' >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<tbody>")

        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td align=left width='10%'>")
        CommonFunctions.General.WriteHTML("<a class='Menu' href='javascript:DisplayThisWeek()'>")
        CommonFunctions.General.WriteHTML("<img ID='imgAttachments' src='..\..\images\Minus.gif' border='0' alt='View Project Details' align='left' WIDTH='10' HEIGHT='10'></a><B>")
        CommonFunctions.General.WriteHTML("" + MyBase.GetResourceString("CAP_THIS_WEEK") + "</B></td>")

        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader' id='tblThisWeek'>")
        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan=6>")
        Call PlotGrid(1)
        CommonFunctions.General.WriteHTML("</td>")
        'For Outer This Week
        CommonFunctions.General.WriteHTML("</tr></tbody></table>")
        Response.Write("</td></tr>")
        Response.Write("<tr class=clsTREven>")
        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan='5'>")

        'Start for Pre Week
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table class='clsGridTable'  cellSpacing='0' cellPadding='0' width='99.9%' align='center' >")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader'>")
        CommonFunctions.General.WriteHTML("<td align=left width='10%'>")
        CommonFunctions.General.WriteHTML("<a  class='Menu' href='javascript:DisplayPreviousWeek()'>")
        CommonFunctions.General.WriteHTML("<img ID='imgAttach' src='..\..\images\Minus.gif' border='0' alt='View Project Details' align='left' WIDTH='10' HEIGHT='10'></a><B>")
        CommonFunctions.General.WriteHTML("" + MyBase.GetResourceString("CAP_PREVIOUS_WEEKS") + "</B></td>")

        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRSectionHeader' id='tblPreviousWeek' >")
        CommonFunctions.General.WriteHTML("<td class='clsTDOdd' colspan=6 >")
        Call PlotGrid(2)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></tbody></table>")

        Response.Write("</td></tr>")
        Response.Write("</table>")

        Response.Write("</DIV>")

    End Sub

    Private Sub PlotGrid(ByVal intTemp As Integer)
        '====================================================================
        ' Procedure Name        :   PlotGrid()
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw grid
        ' Description           :   This procedure is used to draw grid on the page for this Week.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   ManishK
        ' Created               :   9th Dec 2005
        ' Revisions             :   
        '=====================================================================

        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim intEmployeeID, intProjectID As Integer
        Dim intCategoryID, intEmployeeCount, intProjectCount, iRowLoop, iProjectRowLoop, intFileSize As Integer
        Dim strEmployee, strProjectName, strCategory, strSubCategory, strFileName, strProject, strSelection, strProjectID, strUploadedDate, strUpdatedDate As String
        Dim dblTotalCTC, dblBillablePercent, dblSelfDevelopment, dblWorkHours, dblInternalProjectsPercent, dblTotalBilled, dblProfitLoss, dblLeaveHours, dblProfitPercent As Double
        Dim strQuery, strEmployeeQuery, strClass As String
        Dim drAll, drEmployee, drProject, drCategory As IDataReader
        Dim intRowCnt As Integer
        Dim dtFromDate As Date
        Dim dtToDate As Date
        Dim intCount As Integer

        CommonFunctions.General.WriteHTML("<DIV style='overflow:auto'>")
        If intTemp = 1 Then
            CommonFunctions.General.WriteHTML("<table  class='clsGridTable' id='tblHeaderForTW' cellSpacing='1' cellPadding='0'   >")
        Else
            CommonFunctions.General.WriteHTML("<table  class='clsGridTable'  id='tblHeaderForPW' cellSpacing='1' cellPadding='0'   >")
        End If

        CommonFunctions.General.WriteHTML("<tbody>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader' >")
        CommonFunctions.General.WriteHTML("<td   align='center' width='21%'>")
        CommonFunctions.General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_DOCUMENT_CATEGORY") + "</B>")
        CommonFunctions.General.WriteHTML("</td><td  align='left' width='22%'>")
        CommonFunctions.General.WriteHTML("<B>&nbsp;" + MyBase.GetResourceString("CAP_DOCUMENT_SUBCATEGORY") + "</B>")
        CommonFunctions.General.WriteHTML("</td><td  align='left' width='29%'>")
        CommonFunctions.General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_DOCUMENT_NAME") + "</B>")
        CommonFunctions.General.WriteHTML("</td><td  align='left' width='12%'>")
        CommonFunctions.General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_UPLOAD_DATE") + "</B>")
        CommonFunctions.General.WriteHTML("</td><td  align='center' width='6%'>")
        CommonFunctions.General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_FILE_SIZE") + "</B>")
        CommonFunctions.General.WriteHTML("</td><td  align='left'>")
        CommonFunctions.General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_LAST_MODIFIED") + "</B>")
        CommonFunctions.General.WriteHTML("</td></tr>")

        dtFromDate = GetStartDateOfWeek()
        'Modified by MrugajaB on 3rd March 2006 for WhizibleSEM 6.0 Issue ID.2631
        dtToDate = DateAdd(DateInterval.Day, 7, GetStartDateOfWeek())
        'End Modification

        If intTemp = 1 Then

            strSQLQuery = "EXEC usp_Sel_Documents_Attached_PMDashboard " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
            strSQLQuery += "NULL, '" + dtFromDate.ToString + "', '"
            strSQLQuery += dtToDate.ToString + "'"
            strSQLQuery += ",NULL,1,1"
        ElseIf intTemp = 2 Then
            strSQLQuery = "EXEC usp_Sel_Documents_Attached_PMDashboard " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
            strSQLQuery += "NULL,NULL , '" + dtToDate.ToString + "'"
            strSQLQuery += ",NULL, 1"
        End If

        drAll = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        iRowLoop = 0
        iProjectRowLoop = 0

        'This loop is to show the number of projects 
        While drAll.Read()

            iRowLoop += 1
            iProjectRowLoop += 1

            intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drAll("ProjectID"), ""), Integer)
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drAll("ProjectName"), ""), String)
            If intTemp = 1 Then
                If iProjectRowLoop Mod 2 = 0 Then
                    CommonFunctions.General.WriteHTML("<tr id=trpForTW_" & CType(intProjectID, String) & " class='clsTROdd' >")
                Else
                    CommonFunctions.General.WriteHTML("<tr id=trpForTW_" & CType(intProjectID, String) & " class='clsTREven' >")
                End If
            Else
                If iProjectRowLoop Mod 2 = 0 Then
                    CommonFunctions.General.WriteHTML("<tr id=trpForPW_" & CType(intProjectID, String) & " class='clsTROdd' >")
                Else
                    CommonFunctions.General.WriteHTML("<tr id=trpForPW_" & CType(intProjectID, String) & " class='clsTREven' >")
                End If

            End If
            CommonFunctions.General.WriteHTML("<td align=left colspan=6>")

            If intTemp = 1 Then
                CommonFunctions.General.WriteHTML("<a class='Menu' href='javascript:ShowHideRowsForTW(" & CType(intProjectID, String) & ", " & iRowLoop & ") '>")
                CommonFunctions.General.WriteHTML("<img ID='imgAttachmentsForTW" & CType(intProjectID, String) & "' src='..\..\images\Plus.gif' border='0' alt='View Project Details' align='left' WIDTH='10' HEIGHT='10'></a><B>")
            ElseIf intTemp = 2 Then
                CommonFunctions.General.WriteHTML("<a class='Menu' href='javascript:ShowHideRowsForPW(" & CType(intProjectID, String) & ", " & iRowLoop & ") '>")
                CommonFunctions.General.WriteHTML("<img ID='imgAttachmentsForPW" & CType(intProjectID, String) & "' src='..\..\images\Plus.gif' border='0' alt='View Project Details' align='left' WIDTH='10' HEIGHT='10'></a><B>")
            End If

            CommonFunctions.General.WriteHTML("</B>" & strProjectName & "</td>")
            CommonFunctions.General.WriteHTML("</tr>")


            If intTemp = 1 Then
                strSQLQuery = "EXEC usp_Sel_Documents_Attached_PMDashboard " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
                strSQLQuery += intProjectID.ToString + ", "
                strSQLQuery += " '" + dtFromDate.ToString + "', '"
                strSQLQuery += dtToDate.ToString + "'"
                strSQLQuery += ",NULL,2,1"

            ElseIf intTemp = 2 Then
                strSQLQuery = "EXEC usp_Sel_Documents_Attached_PMDashboard " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
                strSQLQuery += intProjectID.ToString + ", "
                strSQLQuery += "NULL,'" + dtToDate.ToString + "'"
                strSQLQuery += ",NULL,2"
            End If

            drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            'This loop is to show all the documents under the specific project
            While drProject.Read()
                iRowLoop += 1

                strCategory = CType(CommonFunctions.Data.CheckIsDBNull(drProject("Category"), ""), String)
                intCategoryID = CType(CommonFunctions.Data.CheckIsDBNull(drProject("CategoryID"), "0"), Integer)

                If intTemp = 1 Then
                    CommonFunctions.General.WriteHTML("<tr id=trcForTW_" & CType(intProjectID, String) & CType(intCategoryID, String) & " class='clsTRSectionHeader' style='display:none' >")
                Else
                    CommonFunctions.General.WriteHTML("<tr id=trcForPW_" & CType(intProjectID, String) & CType(intCategoryID, String) & " class='clsTRSectionHeader' style='display:none' >")
                End If

                CommonFunctions.General.WriteHTML("<td align='left' colspan=6 >")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp; " & strCategory & "</td>")
                CommonFunctions.General.WriteHTML("</tr>")

                Dim strSQL As String
                If intTemp = 1 Then
                    strSQL = "EXEC usp_Sel_Documents_Attached_PMDashboard_Detail " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
                    strSQL += intProjectID.ToString + ", "
                    strSQL += " '" + dtFromDate.ToString + "', '"
                    strSQL += dtToDate.ToString + "'"
                    strSQL += ", " + intCategoryID.ToString + ",1"
                ElseIf intTemp = 2 Then
                    strSQL = "EXEC usp_Sel_Documents_Attached_PMDashboard_Detail " + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "") + ", "
                    strSQL += intProjectID.ToString + ", "
                    strSQL += "NULL,'" + dtToDate.ToString + "'"
                    strSQL += ", " + intCategoryID.ToString
                End If

                drCategory = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                intRowCnt = 1

                'This loop is to show the details containing filename etc.

                While drCategory.Read()
                    iRowLoop += 1


                    strSubCategory = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("SubCategory"), " "), String)
                    strFileName = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("FileName"), "0"), String)
                    'Modified By ShraddhaM on 12 Sep 2006 for SP7 Issue ID : 4901
                    Dim strIsUrl As String = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("IsUrl"), "0"), String)

                    Dim blUploadDate As Boolean
                    If IsDate((CommonFunctions.Data.CheckIsDBNull(drCategory("UploadedDate"), "0"))) Then
                        'strUploadedDate = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("UploadedDate"), "0"), Date).ToString("MM/dd/yyyy")
                        strUploadedDate = CStr(CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drCategory("UploadedDate"), "1/1/2005"), Date)))
                    Else
                        strUploadedDate = ""
                    End If

                    intFileSize = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("FileSize"), "0"), Integer)

                    If IsDate((CommonFunctions.Data.CheckIsDBNull(drCategory("UpdatedDate"), "0"))) Then
                        'strUpdatedDate = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("UpdatedDate"), "0"), Date).ToString("MM/dd/yyyy")
                        strUpdatedDate = CStr(CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drCategory("UpdatedDate"), "1/1/2005"), Date)))
                    Else
                        strUpdatedDate = ""
                    End If

                    Dim intDocumentID As Integer = CType(CommonFunctions.Data.CheckIsDBNull(drCategory("DocumentID"), "0"), Integer)

                    intRowCnt = intRowCnt + 1

                    If intRowCnt Mod 2 = 0 Then
                        strClass = "clsTROdd"
                    Else
                        strClass = "clsTREven"
                    End If

                    If intTemp = 1 Then
                        CommonFunctions.General.WriteHTML("<tr class='" + strClass + "' id=trpc_" & CType(intProjectID, String) & CType(intCategoryID, String) & " style='display:none' >")
                    Else
                        CommonFunctions.General.WriteHTML("<tr class='" + strClass + "' id=trpcForPW_" & CType(intProjectID, String) & CType(intCategoryID, String) & " style='display:none' >")
                    End If
                   

                    CommonFunctions.General.WriteHTML("<td  width=18% >&nbsp;</td>")
                    CommonFunctions.General.WriteHTML("<td  align=left width=22%>")
                    CommonFunctions.General.WriteHTML(strSubCategory & "</td>")
                    CommonFunctions.General.WriteHTML("<td  align=left width=29%>")
                    'Modified By ShraddhaM on 12 Sep 2006 for SP7 Issue ID : 4901
                    If strIsUrl = "True" Then
                        CommonFunctions.General.WriteHTML("<a href='" & strFileName & "' target=_new >" & strFileName & "</a></td>")
                        'CommonFunctions.General.WriteHTML(strFileName & "</a></td>")
                    Else
                        CommonFunctions.General.WriteHTML("<a href='javascript:Document_OnClick(" & CType(intDocumentID, String) & "," & CType(intProjectID, String) & ")'>")
                        CommonFunctions.General.WriteHTML(strFileName & "</a></td>")

                    End If
                    'End of Modification By ShraddhaM on 12 Sep 2006 for SP7 Issue ID : 4901
                    'CommonFunctions.General.WriteHTML("<a href='javascript:Document_OnClick(" & CType(intDocumentID, String) & "," & CType(intProjectID, String) & ")'>")
                    'CommonFunctions.General.WriteHTML(strFileName & "</a></td>")

                    CommonFunctions.General.WriteHTML("<td  align='left' width=12%>")
                    CommonFunctions.General.WriteHTML(strUploadedDate & "</td>")

                    CommonFunctions.General.WriteHTML("<td  align=right width=6%>")
                    CommonFunctions.General.WriteHTML(intFileSize & "</td>")

                    CommonFunctions.General.WriteHTML("<td  align='left' >")
                    CommonFunctions.General.WriteHTML(strUpdatedDate & "</td>")
                    CommonFunctions.General.WriteHTML("</tr>")

                End While

                CommonFunctions.Data.DisposeDataReader(drCategory)

            End While

            CommonFunctions.Data.DisposeDataReader(drProject)

        End While

        If intTemp = 1 Then
            CommonFunctions.General.WriteHTML("<tr id='trpForTW_' class='clsTROdd' align='center' width='100%'>")
        Else
            CommonFunctions.General.WriteHTML("<tr id='trpForPW_' class='clsTROdd' align='center' width='100%'>")
        End If

        CommonFunctions.General.WriteHTML("<td colspan=6> </td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("</tbody></table>")
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.Data.DisposeDataReader(drAll)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub



End Class
